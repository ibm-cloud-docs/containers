---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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




# Services integrieren
{: #integrations}

Sie können verschiedene externe Services und Katalogservices mit einem Kubernetes-Standardcluster in {{site.data.keyword.containerlong}} verwenden.
{:shortdesc}


## DevOps-Services
{: #devops_services}
<table summary="Zusammenfassung der Zugriffsmöglichkeiten">
<caption>DevOps-Services</caption>
<thead>
<tr>
<th>Service</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Codeship</td>
<td>Mit <a href="https://codeship.com" target="_blank">Codeship <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> können Sie die kontinuierliche Integration und Bereitstellung von Containern vorantreiben. Weitere Informationen finden Sie unter <a href="https://www.ibm.com/blogs/bluemix/2017/10/using-codeship-pro-deploy-workloads-ibm-container-service/" target="_blank">Using Codeship Pro To Deploy Workloads to {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> ist ein Kubernetes-Paketmanager. Sie können neue Helm-Diagramme zum Definieren, Installieren und Durchführen von Upgrades für komplexe Kubernetes-Anwendungen, die in {{site.data.keyword.containerlong_notm}}-Clustern ausgeführt werden, erstellen. <p>Weitere Informationen finden Sie unter [Helm in {{site.data.keyword.containerlong_notm}} konfigurieren](cs_integrations.html#helm).</p></td>
</tr>
<tr>
<td>{{site.data.keyword.contdelivery_full}}</td>
<td>Automatisieren Sie die App-Builds und die Containerbereitstellungen in Kubernetes-Clustern mithilfe einer Toolchain. Informationen zur Konfiguration finden Sie in dem Blog <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Deploy Kubernetes pods to the {{site.data.keyword.containerlong_notm}} using DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> ist ein Open-Source-Service, der Entwicklern eine Möglichkeit zum Verbinden, Sichern, Verwalten und Überwachen eines Netzes von Mikroservices (auch als Servicenetz bezeichnet) auf Cloudorchestrierungsplattformen wie Kubernetes bietet. Lesen Sie den Blogbeitrag darüber, <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">wie IBM Istio mitgegründet und auf den Markt gebracht hat <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>, um weitere Informationen zu dem Open-Source-Projekt zu erhalten. Weitere Informationen zum Installieren von Istio auf Ihrem Kubernetes-Cluster in {{site.data.keyword.containerlong_notm}} und zu den ersten Schritten mit einer Beispiel-App erhalten Sie im [Lernprogramm: Mikroservices mit Istio verwalten](cs_tutorials_istio.html#istio_tutorial).</td>
</tr>
</tbody>
</table>

<br />



## Protokollierungs- und Überwachungsservices
{: #health_services}
<table summary="Zusammenfassung der Zugriffsmöglichkeiten">
<caption>Protokollierungs- und Überwachungsservices</caption>
<thead>
<tr>
<th>Service</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoScale</td>
<td>Überwachen Sie Workerknoten, Container, Replikatgruppen, Replikationscontroller und Services mit <a href="https://www.newrelic.com/coscale" target="_blank">CoScale <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. Weitere Informationen finden Sie unter <a href="https://www.ibm.com/blogs/bluemix/2017/06/monitoring-ibm-bluemix-container-service-coscale/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with CoScale <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Datadog</td>
<td>Überwachen Sie Ihren Cluster und zeigen Sie Metriken für die Infrastruktur- und Anwendungsleistung mit <a href="https://www.datadoghq.com/" target="_blank">Datadog <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> an. Weitere Informationen finden Sie unter <a href="https://www.ibm.com/blogs/bluemix/2017/07/monitoring-ibm-bluemix-container-service-datadog/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Datadog <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.cloudaccesstrailfull}}</td>
<td>Überwachen Sie die in Ihrem Cluster vorgenommenen Verwaltungsaktivitäten, indem Sie die Protokolle über Grafana analysieren. Weitere Informationen zum Service finden Sie in der Dokumentation zu [Activity Tracker](/docs/services/cloud-activity-tracker/index.html). Weitere Informationen zu den Typen von Ereignissen, die Sie überwachen können, finden Sie im Abschnitt [Activity Tracker-Ereignisse](cs_at_events.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.loganalysisfull}}</td>
<td>Erweitern Sie Ihre Protokollerfassungs-, Aufbewahrungs- und Suchmöglichkeiten mit {{site.data.keyword.loganalysisfull_notm}}. Weitere Informationen finden Sie unter <a href="../services/CloudLogAnalysis/containers/containers_kube_other_logs.html" target="_blank">Automatische Erfassung von Clusterprotokollen aktivieren<img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>Fügen Sie Ihrem Cluster Protokollmanagementfunktionen hinzu, indem Sie LogDNA als Drittanbieterservice auf Ihren Workerknoten implementieren, um Protokolle aus Ihren Pod-Containern zu verwalten. Weitere Informationen finden Sie unter [Kubernetes-Clusterprotokolle mit {{site.data.keyword.loganalysisfull_notm}} und LogDNA verwalten](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube).</td>
</tr>
<tr>
<td>{{site.data.keyword.monitoringlong}}</td>
<td>Erweitern Sie Ihre Erfassungs- und Aufbewahrungsmöglichkeiten für Metriken, indem Sie Regeln und Alerts mit {{site.data.keyword.monitoringlong_notm}} definieren. Weitere Informationen finden Sie unter <a href="../services/cloud-monitoring/tutorials/container_service_metrics.html" target="_blank">Metriken in Grafana für eine App analysieren, die in einem Kubernetes-Cluster bereitgestellt wurde<img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.</td>
</tr>
<tr>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>Gewinnen Sie betriebliche Einblicke in die Leistung und den Allgemeinzustand Ihrer Apps, indem Sie Sysdig als Drittanbieterservice auf Ihren Workerknoten bereitstellen, um Metriken an {{site.data.keyword.monitoringlong}} weiterzuleiten. Weitere Informationen finden Sie unter [Metriken für eine App analysieren, die in einem Kubernetes-Cluster bereitgestellt wurde](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster). **Hinweis**: Wenn Sie {{site.data.keyword.mon_full_notm}} mit Clustern verwenden, auf denen Kubernetes Version 1.11 oder höher ausgeführt wird, werden nicht alle Containermetriken erfasst, da Sysdig derzeit `containerd` nicht unterstützt.</td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> bietet eine Leistungsüberwachung von Infrastrukturen und Apps über eine grafische Benutzerschnittstelle, die automatisch Apps erkennt und zuordnet. Istana erfasst alle Anforderungen an Ihre Apps und ermöglicht Ihnen damit die Durchführung von Fehler- und Ursachenanalysen, um zu vermeiden, dass Probleme erneut auftreten. Lesen Sie dazu den Blogeintrag zur <a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">Bereitstellung von Istana in {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>, um weitere Informationen zu erhalten.</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus ist ein Open-Source-Tool für die Überwachung, Protokollierung und Benachrichtigung bei Alerts, das speziell für Kubernetes entwickelt wurde. Prometheus ruft auf Grundlage der Kubernetes-Protokollierungsinformationen detaillierte Informationen zu Cluster, Workerknoten und Bereitstellungszustand ab. Informationen zu CPU, Speicher, Ein-/Ausgabe und Netzaktivität werden für alle Container erfasst, die in einem Cluster ausgeführt werden. Sie können die erfassten Daten in angepassten Abfragen oder Alerts verwenden, um die Leistung und Workloads im Cluster zu überwachen.

<p>Um Prometheus zu verwenden, befolgen Sie die <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">CoreOS-Anweisungen <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.</p>
</td>
</tr>
<tr>
<td>Sematext</td>
<td>Zeigen Sie Metriken und Protokolle für Ihre containerisierten Anwendungen mithilfe von <a href="https://sematext.com/" target="_blank">Sematext <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> an. Weitere Informationen finden Sie unter <a href="https://www.ibm.com/blogs/bluemix/2017/09/monitoring-logging-ibm-bluemix-container-service-sematext/" target="_blank">Monitoring and logging for containers with Sematext <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Sysdig</td>
<td>Erfassen Sie App-, Container-, statsd- und Hostmetriken über einen einzigen Instrumentierungspunkt mithilfe von <a href="https://sysdig.com/" target="_blank">Sysdig <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. Weitere Informationen finden Sie unter <a href="https://www.ibm.com/blogs/bluemix/2017/08/monitoring-ibm-bluemix-container-service-sysdig-container-intelligence/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Sysdig Container Intelligence <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope liefert eine grafisch orientierte Diagrammdarstellung Ihrer Ressourcen in einem Kubernetes-Cluster unter Einbeziehung von Services, Pods, Containern, Prozessen, Knoten und vielem mehr. Weave Scope stellt interaktive Metriken für CPU und Speicher bereit und bietet Tools, um 'tail'- und 'exec'-Aufrufe in einem Container durchzuführen.<p>Weitere Informationen finden Sie unter [Kubernetes-Clusterressourcen mit Weave Scope und {{site.data.keyword.containerlong_notm}} grafisch darstellen](cs_integrations.html#weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## Sicherheitsservices
{: #security_services}

Möchten Sie einen umfassenden Überblick über die Integration von {{site.data.keyword.Bluemix_notm}}-Sicherheitsservices im Cluster? Überprüfen Sie die Informationen im [Lernprogramm zum Anwenden durchgängiger Sicherheit in einer Cloudanwendung](/docs/tutorials/cloud-e2e-security.html).
{: shortdesc}

<table summary="Zusammenfassung der Zugriffsmöglichkeiten">
<caption>Sicherheitsservices</caption>
<thead>
<tr>
<th>Service</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
  <tr id="appid">
    <td>{{site.data.keyword.appid_full}}</td>
    <td>Fügen Sie Ihren Apps mit [{{site.data.keyword.appid_short}}](/docs/services/appid/index.html#gettingstarted) eine Sicherheitsebene hinzu, indem Sie Benutzer dazu verpflichten, sich anzumelden. Um Web- oder API-HTTP/HTTPS-Anforderungen in Ihrer App zu authentifizieren, können Sie {{site.data.keyword.appid_short_notm}} in Ihren Ingress-Service integrieren, indem Sie die [{{site.data.keyword.appid_short_notm}}Annotation zur Ingress-Authentifizierung](cs_annotations.html#appid-auth) verwenden.</td>
  </tr>
<tr>
<td>Aqua Security</td>
  <td>Sie können <a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a> durch <a href="https://www.aquasec.com/" target="_blank">Aqua Security <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> ergänzen, um die Sicherheit von Containerbereitstellungen zu optimieren, indem Sie die zulässigen Funktionen für Ihre Apps einschränken. Weitere Informationen finden Sie in der Veröffentlichung <a href="https://blog.aquasec.com/securing-container-deployments-on-bluemix-with-aqua-security" target="_blank">Securing container deployments on {{site.data.keyword.Bluemix_notm}} with Aqua Security <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.cloudcerts_full}}</td>
<td>Sie können <a href="../services/certificate-manager/index.html" target="_blank">{{site.data.keyword.cloudcerts_long}} <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> verwenden, um SSL-Zertifikate für Ihre Apps zu speichern und zu verwalten. Weitere Informationen finden Sie unter <a href="https://www.ibm.com/blogs/bluemix/2018/01/use-ibm-cloud-certificate-manager-ibm-cloud-container-service-deploy-custom-domain-tls-certificates/" target="_blank">Use {{site.data.keyword.cloudcerts_long_notm}} with {{site.data.keyword.containerlong_notm}} to deploy custom domain TLS Certificates <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
  <td>{{site.data.keyword.registrylong}}</td>
  <td>Richten Sie Ihr eigenes gesichertes Docker-Image-Repository ein, in dem Sie Images sicher speichern und mit Clusterbenutzern teilen können. Weitere Informationen finden Sie in der <a href="/docs/services/Registry/index.html" target="_blank">{{site.data.keyword.registrylong}}-Dokumentation <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.</td>
</tr>
<tr>
  <td>{{site.data.keyword.keymanagementservicefull}}</td>
  <td>Verschlüsseln Sie die geheimen Kubernetes-Schlüssel im Cluster durch die Aktivierung von {{site.data.keyword.keymanagementserviceshort}}. Das Verschlüsseln der geheimen Kubernetes-Schlüssel verhindert, dass nicht berechtigte Benutzer auf sensible Clusterinformationen zugreifen können.<br>Informationen zum Einrichten finden Sie in <a href="cs_encrypt.html#keyprotect">Geheime Kubernetes-Schlüssel mit {{site.data.keyword.keymanagementserviceshort}} verschlüsseln</a>.<br>Weitere Informationen finden Sie in der <a href="/docs/services/key-protect/index.html#getting-started-with-key-protect" target="_blank">{{site.data.keyword.keymanagementserviceshort}}-Dokumentation <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.</td>
</tr>
<tr>
<td>NeuVector</td>
<td>Schützen Sie Container durch eine native Cloud-Firewall mithilfe von <a href="https://neuvector.com/" target="_blank">NeuVector <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. Weitere Informationen finden Sie unter <a href="https://www.ibm.com/us-en/marketplace/neuvector-container-security" target="_blank">NeuVector Container Security <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Twistlock</td>
<td>Sie können <a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a> durch <a href="https://www.twistlock.com/" target="_blank">Twistlock <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> ergänzen, um Firewalls, den Schutz vor Bedrohungen und die Behebung von Störfällen zu verwalten. Weitere Informationen finden Sie unter <a href="https://www.ibm.com/blogs/bluemix/2017/07/twistlock-ibm-bluemix-container-service/" target="_blank">Twistlock on {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
</tbody>
</table>

<br />



## Speicherservices
{: #storage_services}
<table summary="Zusammenfassung der Zugriffsmöglichkeiten">
<caption>Speicherservices</caption>
<thead>
<tr>
<th>Service</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Heptio Ark</td>
  <td>Sie können <a href="https://github.com/heptio/ark" target="_blank">Heptio Ark <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> verwenden, um Clusterressourcen und PVs (Persistent Volumes) zu sichern und wiederherzustellen. Weitere Informationen finden Sie in der Heptio Ark-Veröffentlichung zu <a href="https://github.com/heptio/ark/blob/release-0.9/docs/use-cases.md" target="_blank">Anwendungsfällen für Disaster-Recovery und Clustermigration <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.</td>
</tr>
<tr>
  <td>{{site.data.keyword.cos_full}}</td>
  <td>In {{site.data.keyword.cos_short}} gespeicherte Daten werden verschlüsselt und über mehrere geografische Regionen verteilt. Auf sie kann über HTTP mithilfe einer REST-API zugegriffen werden. Sie können den Befehl [ibm-backup-restore image](/docs/services/RegistryImages/ibm-backup-restore/index.html) verwenden, um den Service so zu konfigurieren, dass er einmalige oder geplante Sicherungen von Daten in Ihrem Cluster ausführt. Allgemeine Informationen zu dem Service finden Sie in der <a href="/docs/services/cloud-object-storage/about-cos.html" target="_blank">{{site.data.keyword.cos_short}}-Dokumentation <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.</td>
</tr>
  <tr>
    <td>{{site.data.keyword.cloudantfull}}</td>
    <td>{{site.data.keyword.cloudant_short_notm}} ist eine dokumentorientierte Database as a Service (DBaaS), die Daten als Dokumente im JSON-Format speichert. Der Service ist auf Skalierbarkeit, Hochverfügbarkeit und Langlebigkeit ausgelegt. Weitere Informationen finden Sie in der <a href="/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant" target="_blank">{{site.data.keyword.cloudant_short_notm}}-Dokumentation <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.</td>
  </tr>
  <tr>
    <td>{{site.data.keyword.composeForMongoDB_full}}</td>
    <td>{{site.data.keyword.composeForMongoDB}} bietet Hochverfügbarkeit und Redundanz, automatisierte und bedarfsgesteuerte, unterbrechungsfreie Sicherungen, Überwachungstools, Integration in Alertsysteme, Leistungsanalyseansichten und vieles mehr. Weitere Informationen finden Sie in der <a href="/docs/services/ComposeForMongoDB/index.html#about-compose-for-mongodb" target="_blank">{{site.data.keyword.composeForMongoDB}}-Dokumentation <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.</td>
  </tr>
</tbody>
</table>


<br />



## {{site.data.keyword.Bluemix_notm}}-Services zu Clustern hinzufügen
{: #adding_cluster}

Fügen Sie {{site.data.keyword.Bluemix_notm}}-Services hinzu, um Ihren Kubernetes-Cluster mit zusätzlichen Funktionen in Bereichen wie Watson AI, Daten, Sicherheit und Internet of Things (IoT) zu erweitern.
{:shortdesc}

Sie können nur Services binden, die Serviceschlüssel unterstützen. Eine Liste mit Services, die Serviceschlüssel unterstützen, finden Sie im Abschnitt [Externen Apps die Verwendung von {{site.data.keyword.Bluemix_notm}}-Services ermöglichen](/docs/resources/connect_external_app.html#externalapp).
{: note}

Vorbemerkungen:
- Stellen Sie sicher, dass Sie die folgenden Rollen innehaben:
    - [{{site.data.keyword.Bluemix_notm}} IAM-Servicerolle **Editor** oder **Administrator**](cs_users.html#platform) für den Cluster.
    - [Cloud Foundry-Rolle **Entwickler**](/docs/iam/mngcf.html#mngcf) für den Bereich, den Sie verwenden möchten.
- [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)

Gehen Sie wie folgt vor, um einen {{site.data.keyword.Bluemix_notm}}-Service zu Ihrem Cluster hinzuzufügen:
1. [Erstellen Sie eine Instanz des {{site.data.keyword.Bluemix_notm}}-Service](/docs/apps/reqnsi.html#req_instance).
    * Bestimmte {{site.data.keyword.Bluemix_notm}}-Services sind nur in ausgewählten Regionen verfügbar. Sie können einen Service nur an Ihren Cluster binden, wenn der Service in derselben Region wie Ihr Cluster verfügbar ist. Wenn Sie eine Serviceinstanz in der Zone 'Washington DC' erstellen wollen, müssen Sie außerdem die CLI verwenden.
    * Sie müssen die Serviceinstanz in derselben Ressourcengruppe wie den Cluster erstellen. Eine Ressource kann in nur einer Ressourcengruppe erstellt werden; eine Änderung ist danach nicht mehr möglich.

2. Überprüfen Sie den Servicetyp, den Sie erstellt haben, und notieren Sie die Serviceinstanz **Name**.
   - **Cloud Foundry-Services:**
     ```
     ibmcloud service list
     ```
     {: pre}

     Beispielausgabe:
     ```
     name                         service           plan    bound apps   last operation
     <cf-serviceinstanzname>   <servicename>    spark                create succeeded
     ```
     {: screen}

  - **{{site.data.keyword.Bluemix_notm}}IAM-fähige Services:**
     ```
     ibmcloud resource service-instances
     ```
     {: pre}

     Beispielausgabe:
     ```
     Name                          Location   State    Type               Tags   
     <iam-serviceinstanzname>   <region>   active   service_instance      
     ```
     {: screen}

   Sie können die verschiedenen Servicetypen auch in Ihrem Dashboard als **Cloud Foundry Services** und **Services** sehen.

3. Erstellen Sie für {{site.data.keyword.Bluemix_notm}} IAM-fähige Services einen Cloud Foundry-Aliasnamen, sodass Sie diesen Service an Ihren Cluster binden können. Wenn es sich bei Ihrem Service bereits um einen Cloud Foundry-Service handelt, ist dieser Schritt nicht erforderlich und Sie können mit dem nächsten Schritt fortfahren.
   1. Wählen Sie eine Cloud Foundry-Organisation und einen Cloud Foundry-Bereich als Ziel aus.
      ```
      ibmcloud target --cf
      ```
      {: pre}

   2. Erstellen Sie einen Cloud Foundry-Aliasnamen für die Serviceinstanz.
      ```
      ibmcloud resource service-alias-create <servicealiasname> --instance-name <iam-serviceinstanzname>
      ```
      {: pre}

   3. Überprüfen Sie, dass der Servicealiasname erstellt wurde.
      ```
      ibmcloud service list
      ```
      {: pre}

4. Geben Sie den Clusternamensbereich an, den Sie verwenden wollen, um Ihren Service hinzuzufügen. Wählen Sie eine der folgenden Optionen aus.
     ```
     kubectl get namespaces
     ```
     {: pre}

5.  Fügen Sie den Service zu Ihrem Cluster hinzu. Stellen Sie bei {{site.data.keyword.Bluemix_notm}} IAM-fähigen Services sicher, dass Sie den Cloud Foundry-Aliasnamen verwenden, den Sie zuvor erstellt haben.
    ```
    ibmcloud ks cluster-service-bind <clustername_oder_-id> <namensbereich> <serviceinstanzname>
    ```
    {: pre}

    Wenn der Service erfolgreich zu Ihrem Cluster hinzugefügt worden ist, wird ein geheimer Schlüssel für den Cluster erstellt, der die Berechtigungsnachweise Ihrer Serviceinstanz enthält. Geheime Schlüssel werden automatisch in 'etcd' verschlüsselt, um Ihre Daten zu schützen.

    Beispielausgabe:
    ```
    ibmcloud ks cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace:	mynamespace
    Secret name:     binding-<serviceinstanzname>
    ```
    {: screen}

6.  Überprüfen Sie die Serviceberechtigungsnachweise in Ihrem geheimen Kubernetes-Schlüssel.
    1. Rufen Sie die Details des geheimen Schlüssels ab und notieren Sie den **binding**-Wert. Der **binding**-Wert ist Base64-codiert und enthält die Berechtigungsnachweise für Ihre Serviceinstanz im JSON-Format.
       ```
       kubectl get secrets binding-<serviceinstanzname> --namespace=<namensbereich> -o yaml
       ```
       {: pre}

       Beispielausgabe:
       ```
       apiVersion: v1
       data:
         binding: <bindung>
       kind: Secret
       metadata:
         annotations:
           service-instance-id: 1111aaaa-a1aa-1aa1-1a11-111aa111aa11
           service-key-id: 2b22bb2b-222b-2bb2-2b22-b22222bb2222
         creationTimestamp: 2018-08-07T20:47:14Z
         name: binding-<serviceinstanzname>
         namespace: <namensbereich>
         resourceVersion: "6145900"
         selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
         uid: 33333c33-3c33-33c3-cc33-cc33333333c
       type: Opaque
       ```
       {: screen}

    2. Decodieren Sie den 'bindung'-Wert.
       ```
       echo "<bindung>" | base64 -D
       ```
       {: pre}

       Beispielausgabe:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    3. Optional: Vergleichen Sie die Serviceberechtigungsnachweise, die Sie im vorherigen Schritt decodiert haben, mit den Serviceberechtigungsnachweisen, die Sie für Ihre Serviceinstanz im {{site.data.keyword.Bluemix_notm}}-Dashboard finden.

7. Ihr Service ist nun an Ihren Cluster gebunden und Sie müssen Ihre App für den [Zugriff auf die Serviceberechtigungsnachweise im geheimen Kubernetes-Schlüssel](#adding_app) konfigurieren.


## Von Ihren Apps auf Serviceberechtigungsnachweise zugreifen
{: #adding_app}

Um über Ihre App auf eine {{site.data.keyword.Bluemix_notm}}-Serviceinstanz zuzugreifen, müssen Sie die im geheimen Kubernetes-Schlüssel gespeicherten Serviceberechtigungsnachweise für Ihre App verfügbar machen.
{: shortdesc}

Die Berechtigungsnachweise einer Serviceinstanz sind Base64-codiert und werden in Ihrem geheimen Schlüssel im JSON-Format gespeichert. Wählen Sie eine der folgenden Optionen aus, um auf die Daten in Ihrem geheimen Schlüssel zuzugreifen:
- [Geheimen Schlüssel als Datenträger an Ihren Pod anhängen](#mount_secret)
- [Auf den geheimen Schlüssel in Umgebungsvariablen verweisen](#reference_secret)
<br>
Sollen die geheimen Schlüssel noch sicherer werden? Wenden Sie sich zur [Aktivierung von {{site.data.keyword.keymanagementservicefull}}](cs_encrypt.html#keyprotect) im Cluster an Ihren Clusteradministrator, um neue und vorhandene geheime Schlüssel zu verschlüsseln, zum Beispiel den geheimen Schlüssel, in dem die Berechtigungsnachweise der {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen enthalten sind.
{: tip}

Vorbereitende Schritte:
- [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)
- [Fügen Sie einen {{site.data.keyword.Bluemix_notm}}-Service zu Ihrem Cluster hinzu](#adding_cluster).

### Geheimen Schlüssel als Datenträger an Ihren Pod anhängen
{: #mount_secret}

Wenn Sie den geheimen Schlüssel als Datenträger an Ihren Pod anhängen, wird eine Datei mit dem Namen `binding` im Mountverzeichnis des Datenträgers gespeichert. Die Datei `binding` im JSON-Format enthält sämtliche Informationen und Berechtigungsnachweise, die Sie benötigen, um auf den {{site.data.keyword.Bluemix_notm}}-Service zuzugreifen.
{: shortdesc}

1.  Listen Sie die verfügbaren geheimen Schlüssel in Ihrem Cluster auf und notieren Sie den **Namen** Ihres geheimen Schlüssels. Suchen Sie nach einem Schlüssel des Typs **Opaque**. Sollten mehrere geheime Schlüssel vorhanden sein, wenden Sie sich an Ihren Clusteradministrator, damit dieser den geheimen Schlüssel für den gewünschten Service ermittelt.

    ```
    kubectl get secrets
    ```
    {: pre}

    Beispielausgabe:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<serviceinstanzname>         Opaque                                1         3m

    ```
    {: screen}

2.  Erstellen Sie eine YAML-Datei für Ihre Kubernetes-Bereitstellung und hängen Sie den geheimen Schlüssel als Datenträger an Ihren Pod an.
    ```
    apiVersion: apps/v1beta1
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
          - image: registry.bluemix.net/ibmliberty:latest
            name: secret-test
            volumeMounts:
            - mountPath: <mountpfad>
              name: <datenträgername>
          volumes:
          - name: <datenträgername>
            secret:
              defaultMode: 420
              secretName: binding-<serviceinstanzname>
    ```
    {: codeblock}

    <table>
    <caption>Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts.mountPath</code></td>
    <td>Der absolute Pfad des Verzeichnisses, in dem der Datenträger innerhalb des Containers angehängt wird.</td>
    </tr>
    <tr>
    <td><code>volumeMounts.name</code></br><code>volumes.name</code></td>
    <td>Der Name des Datenträgers, der an Ihren Pod angehängt werden soll.</td>
    </tr>
    <tr>
    <td><code>secret.defaultMode</code></td>
    <td>Die Lese- und Schreibberechtigungen für den geheimen Schlüssel. Verwenden Sie `420`, um Leseberechtigungen festzulegen. </td>
    </tr>
    <tr>
    <td><code>secret.secretName</code></td>
    <td>Der Name des geheimen Schlüssels, den Sie im vorherigen Schritt notiert haben.</td>
    </tr></tbody></table>

3.  Erstellen Sie den Pod und hängen Sie den geheimen Schlüssel als Datenträger an.
    ```
    kubectl apply -f secret-test.yaml
    ```
    {: pre}

4.  Stellen Sie sicher, dass der Pod erstellt wurde.
    ```
    kubectl get pods
    ```
    {: pre}

    CLI-Beispielausgabe:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

5.  Greifen Sie auf die Serviceberechtigungsnachweise zu.
    1. Melden Sie sich beim Pod an.
       ```
       kubectl exec <podname> -it bash
       ```
       {: pre}

    2. Navigieren Sie zu Ihrem Datenträgermountpfad, den Sie zuvor definiert haben, und listen Sie die Dateien in Ihrem Datenträgermountpfad auf.
       ```
       cd <datenträger-mountpfad> && ls
       ```
       {: pre}

       Beispielausgabe:
       ```
       binding
       ```
       {: screen}

       Die `binding`-Datei enthält die Serviceberechtigungsnachweise, die Sie im geheimen Kubernetes-Schlüssel gespeichert haben.

    4. Zeigen Sie die Serviceberechtigungsnachweise an. Die Berechtigungsnachweise werden als Schlüssel/Wert-Paare im JSON-Format gespeichert.
       ```
       cat binding
       ```
       {: pre}

       Beispielausgabe:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    5. Konfigurieren Sie Ihre App, um den JSON-Inhalt zu parsen und die Informationen abzurufen, die Sie für den Zugriff auf den Service benötigen.


### Auf den geheimen Schlüssel in Umgebungsvariablen verweisen
{: #reference_secret}

Sie können die Serviceberechtigungsnachweise und andere Schlüssel/Wert-Paare aus Ihrem geheimen Kubernetes-Schlüssel als Umgebungsvariablen zur Ihrer Bereitstellung hinzufügen.   
{: shortdesc}

1. Listen Sie die verfügbaren geheimen Schlüssel in Ihrem Cluster auf und notieren Sie den **Namen** Ihres geheimen Schlüssels. Suchen Sie nach einem Schlüssel des Typs **Opaque**. Sollten mehrere geheime Schlüssel vorhanden sein, wenden Sie sich an Ihren Clusteradministrator, damit dieser den geheimen Schlüssel für den gewünschten Service ermittelt.

    ```
    kubectl get secrets
    ```
    {: pre}

    Beispielausgabe:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<serviceinstanzname>         Opaque                                1         3m
    ```
    {: screen}

2. Rufen Sie die Details Ihres geheimen Schlüssels ab, um potenzielle Schlüssel/Wert-Paare zu finden, auf die Sie als Umgebungsvariablen in Ihrem Pod verweisen können. Die Serviceberechtigungsnachweise werden im Schlüssel `bindung` Ihres geheimen Schlüssels gespeichert.
   ```
   kubectl get secrets binding-<serviceinstanzname> --namespace=<namensbereich> -o yaml
   ```
   {: pre}

   Beispielausgabe:
   ```
   apiVersion: v1
   data:
     binding: <bindung>
   kind: Secret
   metadata:
     annotations:
       service-instance-id: 7123acde-c3ef-4ba2-8c52-439ac007fa70
       service-key-id: 9h30dh8a-023f-4cf4-9d96-d12345ec7890
     creationTimestamp: 2018-08-07T20:47:14Z
     name: binding-<serviceinstanzname>
     namespace: <namensbereich>
     resourceVersion: "6145900"
     selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
     uid: 12345a31-9a83-11e8-ba83-cd49014748f
   type: Opaque
   ```
   {: screen}

3. Erstellen Sie eine YAML-Datei für Ihre Kubernetes-Bereitstellung und geben Sie eine Umgebungsvariable an, die auf den Schlüssel `binding` verweist.
   ```
   apiVersion: apps/v1beta1
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
     template:
       metadata:
         labels:
           app: secret-test
       spec:
         containers:
         - image: registry.bluemix.net/ibmliberty:latest
           name: secret-test
           env:
           - name: BINDING
             valueFrom:
               secretKeyRef:
                 name: binding-<serviceinstanzname>
                 key: binding
     ```
     {: codeblock}

     <table>
     <caption>Erklärung der Komponenten der YAML-Datei</caption>
     <thead>
     <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
     </thead>
     <tbody>
     <tr>
     <td><code>containers.env.name</code></td>
     <td>Der Name Ihrer Umgebungsvariablen.</td>
     </tr>
     <tr>
     <td><code>env.valueFrom.secretKeyRef.name</code></td>
     <td>Der Name des geheimen Schlüssels, den Sie im vorherigen Schritt notiert haben.</td>
     </tr>
     <tr>
     <td><code>env.valueFrom.secretKeyRef.key</code></td>
     <td>Der Schlüssel, der Teil Ihres geheimen Schlüssels ist und auf den Sie in Ihrer Umgebungsvariablen verweisen möchten. Wenn Sie auf die Serviceberechtigungsnachweise verweisen möchten, müssen Sie den Schlüssel <strong>binding</strong> verwenden.  </td>
     </tr>
     </tbody></table>

4. Erstellen Sie den Pod, der auf den Schlüssel `binding` des geheimen Schlüssels als Umgebungsvariable verweist.
   ```
   kubectl apply -f secret-test.yaml
   ```
   {: pre}

5. Stellen Sie sicher, dass der Pod erstellt wurde.
   ```
   kubectl get pods
   ```
   {: pre}

   CLI-Beispielausgabe:
   ```
   NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
   ```
   {: screen}

6. Stellen Sie sicher, dass die Umgebungsvariable richtig festgelegt ist.
   1. Melden Sie sich beim Pod an.
      ```
      kubectl exec <podname> -it bash
      ```
      {: pre}

   2. Listen Sie alle Umgebungsvariablen im Pod auf.
      ```
      env
      ```
      {: pre}

      Beispielausgabe:
      ```
      BINDING={"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
      ```
      {: screen}

7. Konfigurieren Sie Ihre App zum Lesen der Umgebungsvariablen und zum Parsen des JSON-Inhalts, um die Informationen abzurufen, die Sie für den Zugriff auf den Service benötigen.

   Beispielcode in Python:
   ```
   if os.environ.get('BINDING'):
        credentials = json.loads(os.environ.get('BINDING'))
   ```
   {: codeblock}

## Helm in {{site.data.keyword.containerlong_notm}} konfigurieren
{: #helm}

[Helm ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://helm.sh) ist ein Kubernetes-Paketmanager. Sie können Helm-Diagramme zum Definieren, Installieren und Durchführen von Upgrades für komplexe Kubernetes-Anwendungen, die in {{site.data.keyword.containerlong_notm}}-Clustern ausgeführt werden, erstellen.
{:shortdesc}

Vor der Verwendung von Helm-Diagrammen mit {{site.data.keyword.containerlong_notm}} müssen Sie eine Helm-Instanz in Ihrem Cluster installieren und initialisieren. Sie können anschließend das {{site.data.keyword.Bluemix_notm}}-Helm-Repository zu Ihrer Helm-Instanz hinzufügen.

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)

1. Installieren Sie die <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm-CLI <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.

2. **Wichtig**: Erstellen Sie zur Gewährleistung der Clustersicherheit ein Servicekonto für Tiller im Namensbereich `kube-system` und eine RBAC-Clusterrollenbindung für Kubernetes für den Pod `tiller-deploy`; verwenden Sie hierzu die folgende `.yaml`-Datei aus dem [{{site.data.keyword.Bluemix_notm}}-Repository `kube-samples`](https://github.com/IBM-Cloud/kube-samples/blob/master/rbac/serviceaccount-tiller.yaml). **Hinweis**: Wenn Sie Tiller mit dem Servicekonto und der Cluster-Rollenbindung im Namensbereich `kube-system` installieren möchten, müssen Sie über die Rolle [`cluster-admin`](cs_users.html#access_policies) verfügen.
    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/rbac/serviceaccount-tiller.yaml
    ```
    {: pre}

3. Initialisieren Sie Helm und installieren Sie `tiller` mit dem erstellten Servicekonto.

    ```
    helm init --service-account tiller
    ```
    {: pre}

4. Überprüfen Sie, dass der Pod `tiller-deploy` in Ihrem Cluster den **Status** `Running` aufweist.

    ```
    kubectl get pods -n kube-system -l app=helm
    ```
    {: pre}

    Beispielausgabe:

    ```
    NAME                            READY     STATUS    RESTARTS   AGE
    tiller-deploy-352283156-nzbcm   1/1       Running   0          2m
    ```
    {: screen}

5. Fügen Sie die {{site.data.keyword.Bluemix_notm}}-Helm-Repositorys zur Helm-Instanz hinzu.

    ```
    helm repo add ibm  https://registry.bluemix.net/helm/ibm
    ```
    {: pre}

    ```
    helm repo add ibm-charts https://registry.bluemix.net/helm/ibm-charts
    ```
    {: pre}

6. Listen Sie die aktuell in den {{site.data.keyword.Bluemix_notm}}-Repositorys verfügbaren Helm-Diagramme auf.

    ```
    helm search ibm
    ```
    {: pre}

    ```
    helm search ibm-charts
    ```
    {: pre}

7. Wenn Sie mehr über ein Diagramm erfahren möchten, listen Sie die zugehörigen Einstellungen und Standardwerte auf.

    So können Sie beispielsweise die Einstellungen, Dokumentation und Standardwerte für das Helm-Diagramm des strongSwan-IPSec-VPN-Service anzeigen:

    ```
    helm inspect ibm/strongswan
    ```
    {: pre}


### Zugehörige Helm-Links
{: #helm_links}

* Informationen zur Verwendung von StrongSwan finden Sie unter [Einrichtung von VPN-Konnektivität mit dem Helm-Diagramm des StrongSwan-IPSec-VPN-Service](cs_vpn.html#vpn-setup).
* Zeigen Sie verfügbare Helm-Diagramme an, die Sie mit {{site.data.keyword.Bluemix_notm}} im [Helm-Diagrammkatalog ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts) in der Konsole verwenden können.
* Weitere Informationen zu den Helm-Befehlen zum Konfigurieren und Verwalten von Helm-Diagrammen finden Sie in der <a href="https://docs.helm.sh/helm/" target="_blank">Helm-Dokumentation <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.
* Über den folgenden Link finden Sie weitere Informationen zur Vorgehensweise bei der [Erhöhung der Bereitstellungsgeschwindigkeit mit Kubernetes-Helm-Diagrammen![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/).

## Kubernetes-Clusterressourcen grafisch darstellen
{: #weavescope}

Weave Scope liefert eine grafisch orientierte Diagrammdarstellung Ihrer Ressourcen in einem Kubernetes-Cluster unter Einbeziehung von Services, Pods, Containern und vielem mehr. Weave Scope stellt interaktive Metriken für CPU und Speicher bereit und bietet Tools, um 'tail'- und 'exec'-Aufrufe in einem Container durchzuführen.
{:shortdesc}

Vorbemerkungen:

-   Denken Sie daran, dass Sie keine Clusterinformationen im öffentlichen Internet offenlegen dürfen. Führen Sie diese Schritte aus, um Weave Scope sicher bereitzustellen und dann lokal über einen Web-Browser auf den Service zuzugreifen.
-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_clusters.html#clusters_ui). Weave Scope kann die CPU stark belasten, insbesondere die App. Führen Sie Weave Scope mit den größeren Standardclustern aus und nicht mit kostenlosen Clustern.
-   [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)


Gehen Sie wie folgt vor, um Weave Scope mit einem Cluster zu verwenden:
2.  Stellen Sie eine der zur Verfügung gestellten Konfigurationsdatei für die RBAC-Berechtigungen im Cluster bereit.

    Gehen Sie wie folgt vor, um die Schreib-/Leseberechtigung zu aktivieren:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Gehen Sie wie folgt vor, um die Schreibberechtigung zu aktivieren:

    ```
    kubectl apply --namespace weave -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
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
    <code>kubectl apply --namespace weave -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Ausgabe:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Führen Sie einen Befehl zur Portweiterleitung aus, um den Service auf dem Computer zu öffnen. Beim nächsten Zugriff auf Weave Scope können Sie diesen Befehl zur Portweiterleitung ausführen, ohne wieder die vorherigen Konfigurationsschritte durchführen zu müssen.

    ```
    kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Ausgabe:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]: :1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Öffnen Sie Ihren Web-Browser mit der Adresse `http://localhost:4040`. Ohne die Bereitstellung der Standardkomponenten wird das folgende Diagramm angezeigt. Sie können entweder Topologiediagramme oder Tabellen in den Kubernetes-Ressourcen im Cluster anzeigen.

     <img src="images/weave_scope.png" alt="Beispieltopologie von Weave Scope" style="width:357px;" />


[Weitere Informationen zu den Weave Scope-Funktionen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.weave.works/docs/scope/latest/features/).

<br />

