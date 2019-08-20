---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="blank"}
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

# Benutzerzugriffsberechtigungen
{: #access_reference}

Wenn Sie [Clusterberechtigungen zuordnen](/docs/containers?topic=containers-users), kann es schwierig sein, zu beurteilen, welche Rolle einem Benutzer zugeordnet werden muss. Anhand der Tabellen in den folgenden Abschnitten können Sie das Mindestniveau der Berechtigungen feststellen, die für die Ausführung allgemeiner Tasks in {{site.data.keyword.containerlong}} erforderlich sind.
{: shortdesc}

## {{site.data.keyword.cloud_notm}} IAM-Plattformrollen
{: #iam_platform}

{{site.data.keyword.containerlong_notm}} ist für die Verwendung von {{site.data.keyword.cloud_notm}} Identity and Access Management-Rollen (IAM-Rollen) konfiguriert. Von den {{site.data.keyword.cloud_notm}} IAM-Plattformrollen werden die Aktionen festgelegt, die Benutzer an {{site.data.keyword.cloud_notm}}-Ressourcen wie Clustern, Workerknoten und Ingress-Lastausgleichsfunktionen für Anwendungen (ALB) ausführen können. Durch {{site.data.keyword.cloud_notm}} IAM-Plattformrollen werden darüber hinaus automatisch auch grundlegende Infrastrukturberechtigungen für Benutzer festgelegt. Informationen zum Festlegen von Plattformrollen finden Sie unter [{{site.data.keyword.cloud_notm}} IAM-Plattformberechtigungen zuordnen](/docs/containers?topic=containers-users#platform).
{: shortdesc}

<p class="tip">Weisen Sie {{site.data.keyword.cloud_notm}} IAM-Plattformrollen nicht gleichzeitig mit einer Servicerolle zu. Sie müssen Plattform- und Servicerollen separat zuweisen.</p>

Die Tabellen in den folgenden Abschnitten enthalten die jeweiligen Berechtigungen für die Clusterverwaltung, für die Protokollierung und für Ingress-Berechtigungen, die durch die einzelnen {{site.data.keyword.cloud_notm}} IAM-Plattformrollen erteilt werden. Die Tabellen sind nach CLI-Befehlsnamen alphabetisch angeordnet.

* [Berechtigungsfreie Aktionen](#none-actions)
* [Aktionen für Anzeigeberechtigte](#view-actions)
* [Editoraktionen](#editor-actions)
* [Operatoraktionen](#operator-actions)
* [Administratoraktionen](#admin-actions)

### Berechtigungsfreie Aktionen
{: #none-actions}

Jedem Benutzer in Ihrem Konto, der den CLI-Befehl ausführt oder den API-Aufruf für die Aktion in der folgenden Tabelle durchführt, wird das Ergebnis angezeigt, auch wenn dem Benutzer keine Berechtigungen zugeordnet sind.
{: shortdesc}

<table>
<caption>Übersicht über die CLI-Befehle und API-Aufrufe, für die keine Berechtigungen in {{site.data.keyword.containerlong_notm}} erforderlich sind</caption>
<thead>
<th id="none-actions-action">Aktion</th>
<th id="none-actions-cli">CLI-Befehl</th>
<th id="none-actions-api">API-Aufruf</th>
</thead>
<tbody>
<tr>
<td>Liste der Versionen anzeigen, die für verwaltete Add-ons in {{site.data.keyword.containerlong_notm}} unterstützt werden.</td>
<td><code>[ibmcloud ks addon-versions](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_addon_versions)</code></td>
<td><code>[GET /v1/addon](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetAddons)</code></td>
</tr>
<tr>
<td>API-Endpunkt für {{site.data.keyword.containerlong_notm}} als Ziel festlegen oder anzeigen</td>
<td><code>[ibmcloud ks api](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cli_api)</code></td>
<td>-</td>
</tr>
<tr>
<td>Liste der unterstützten Befehle und Parameter anzeigen</td>
<td><code>[ibmcloud ks help](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_help)</code></td>
<td>-</td>
</tr>
<tr>
<td>{{site.data.keyword.containerlong_notm}}-Plug-ins initialisieren oder Region angeben, in der Sie Kubernetes-Cluster erstellen oder darauf zugreifen möchten</td>
<td><code>[ibmcloud ks init](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_init)</code></td>
<td>-</td>
</tr>
<tr>
<td>Veraltet: Liste der Kubernetes-Versionen anzeigen, die in {{site.data.keyword.containerlong_notm}} unterstützt werden</td>
<td><code>[ibmcloud ks kube-versions](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_kube_versions)</code></td>
<td><code>[GET /v1/kube-versions](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetKubeVersions)</code></td>
</tr>
<tr>
<td>Liste der für Workerknoten verfügbaren Typen anzeigen</td>
<td><code>[ibmcloud ks flavors](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_machine_types) (machine-types)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/machine-types](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetDatacenterMachineTypes)</code></td>
</tr>
<tr>
<td>Aktuelle Nachrichten für den Benutzer der IBMid anzeigen</td>
<td><code>[ibmcloud ks messages](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_messages)</code></td>
<td><code>[GET /v1/messages](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetMessages)</code></td>
</tr>
<tr>
<td>Veraltet: Nach der {{site.data.keyword.containerlong_notm}}-Region suchen, in der Sie sich befinden</td>
<td><code>[ibmcloud ks region](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_region)</code></td>
<td>-</td>
</tr>
<tr>
<td>Veraltet: Region für {{site.data.keyword.containerlong_notm}} festlegen</td>
<td><code>[ibmcloud ks region-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_region-set)</code></td>
<td>-</td>
</tr>
<tr>
<td>Veraltet: Verfügbare Regionen auflisten</td>
<td><code>[ibmcloud ks regions](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_regions)</code></td>
<td><code>[GET /v1/regions](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetRegions)</code></td>
</tr>
<tr>
<td>Liste der Standorte anzeigen, die in {{site.data.keyword.containerlong_notm}} unterstützt werden.</td>
<td><code>[ibmcloud ks supported-locations](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_supported-locations)</code></td>
<td><code>[GET /v1/locations](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/ListLocations)</code></td>
</tr>
<tr>
<td>Liste der Versionen anzeigen, die in {{site.data.keyword.containerlong_notm}} unterstützt werden.</td>
<td><code>[ibmcloud ks versions](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_versions_command)</code></td>
<td>-</td>
</tr>
<tr>
<td>Liste der verfügbaren Zonen zum Erstellen eines Clusters anzeigen</td>
<td><code>[ibmcloud ks zones](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_datacenters)</code></td>
<td><code>[GET /v1/zones](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetZones)</code></td>
</tr>
</tbody>
</table>

### Aktionen für Anzeigeberechtigte
{: #view-actions}

Die Plattformrolle **Anzeigeberechtigter** (Viewer) umfasst die [Aktionen, die keine Berechtigungen erfordern](#none-actions), sowie die Berechtigungen, die in der folgenden Tabelle aufgeführt werden. Mit der Rolle **Anzeigeberechtigter** können Benutzer wie Auditoren oder Zuständige für die Rechnungsstellung die Clusterdetails anzeigen, aber nicht die Infrastruktur ändern.
{: shortdesc}

<table>
<caption>Übersicht über CLI-Befehle und API-Aufrufe, die die Plattformrolle eines Anzeigeberechtigten in {{site.data.keyword.containerlong_notm}} erfordern</caption>
<thead>
<th id="view-actions-mngt">Aktion</th>
<th id="view-actions-cli">CLI-Befehl</th>
<th id="view-actions-api">API-Aufruf</th>
</thead>
<tbody>
<tr>
<td>Informationen zu einer Ingress-Lastausgleichsfunktion für Anwendungen (ALB)</td>
<td><code>[ibmcloud ks alb-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_get)</code></td>
<td><code>[GET /albs/{albId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/GetClusterALB)</code></td>
</tr>
<tr>
<td>ALB-Typen anzeigen, die in der Region unterstützt werden</td>
<td><code>[ibmcloud ks alb-types](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_types)</code></td>
<td><code>[GET /albtypes](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetAvailableALBTypes)</code></td>
</tr>
<tr>
<td>Alle Ingress-ALBs in einem Cluster auflisten</td>
<td><code>[ibmcloud ks albs](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_albs)</code></td>
<td><code>[GET /clusters/{idOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/GetClusterALBs)</code></td>
</tr>
<tr>
<td>Name und E-Mail-Adresse für den Eigner des {{site.data.keyword.cloud_notm}} IAM-API-Schlüssels für eine Ressourcengruppe und Region anzeigen</td>
<td><code>[ibmcloud ks api-key-info](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_api_key_info)</code></td>
<td><code>[GET /v1/logging/{idOrName}/clusterkeyowner](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/GetClusterKeyOwner)</code></td>
</tr>
<tr>
<td>Kubernetes-Konfigurationsdaten und -Zertifikate herunterladen, um eine Verbindung zum Cluster herzustellen und `kubectl`-Befehle auszuführen</td>
<td><code>[ibmcloud ks cluster-config](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_config)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/config](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterConfig)</code></td>
</tr>
<tr>
<td>Informationen zu einem Cluster anzeigen</td>
<td><code>[ibmcloud ks cluster-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetCluster)</code></td>
</tr>
<tr>
<td>Alle Services in allen Namensbereichen auflisten, die an einen Cluster gebunden sind</td>
<td><code>[ibmcloud ks cluster-services](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_services)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/ListServicesForAllNamespaces)</code></td>
</tr>
<tr>
<td>Alle Cluster auflisten</td>
<td><code>[ibmcloud ks clusters](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_clusters)</code></td>
<td><code>[GET /v1/clusters](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusters)</code></td>
</tr>
<tr>
<td>Infrastrukturberechtigungsnachweise für das {{site.data.keyword.cloud_notm}}-Konto für den Zugriff auf ein anderes Portfolio der IBM Cloud-Infrastruktur abrufen</td>
<td><code>[ibmcloud ks credential-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credential_get)</code></td><td><code>[GET /v1/credentials](https://containers.cloud.ibm.com/global/swagger-global-api/#/accounts/GetUserCredentials)</code></td>
</tr>
<tr>
<td>Prüfen, ob in den Berechtigungsnachweisen für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur für die Zielregion und -ressourcengruppe empfohlene oder erforderliche Infrastrukturberechtigungen fehlen</td>
<td><code>[ibmcloud ks infra-permissions-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#infra_permissions_get)</code></td>
<td><code>[GET /v1/infra-permissions](https://containers.cloud.ibm.com/global/swagger-global-api/#/accounts/GetInfraPermissions)</code></td>
</tr>
<tr>
<td>Status für automatische Aktualisierungen des Fluentd-Add-ons anzeigen</td>
<td><code>[ibmcloud ks logging-autoupdate-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_autoupdate_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>Standardprotokollierungsendpunkt für die Zielregion anzeigen</td>
<td>-</td>
<td><code>[GET /v1/logging/{idOrName}/default](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/GetDefaultLoggingEndpoint)</code></td>
</tr>
<tr>
<td>Alle Protokollweiterleitungskonfigurationen im Cluster oder für eine Protokollquelle im Cluster auflisten</td>
<td><code>[ibmcloud ks logging-config-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/FetchLoggingConfigs) und [GET /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/FetchLoggingConfigsForSource)</code></td>
</tr>
<tr>
<td>Informationen zu einer Protokollfilterkonfiguration anzeigen</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/FetchFilterConfig)</code></td>
</tr>
<tr>
<td>Alle Protokollierungsfilterkonfigurationen im Cluster auflisten</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/FetchFilterConfigs)</code></td>
</tr>
<tr>
<td>Alle an einen bestimmten Namensbereich gebundenen Services auflisten</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/services/{namespace}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/ListServicesInNamespace)</code></td>
</tr>
<tr>
<td>Alle an einen Cluster gebundenen Teilnetze der IBM Cloud-Infrastruktur auflisten</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/subnets](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterSubnets)</code></td>
</tr>
<tr>
<td>Alle an einen Cluster gebundenen benutzerverwalteten Teilnetze auflisten</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Verfügbare Teilnetze im Infrastrukturkonto auflisten</td>
<td><code>[ibmcloud ks subnets](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_subnets)</code></td>
<td><code>[GET /v1/subnets](https://containers.cloud.ibm.com/global/swagger-global-api/#/properties/ListSubnets)</code></td>
</tr>
<tr>
<td>VLAN-Spanning-Status für das Infrastrukturkonto anzeigen</td>
<td><code>[ibmcloud ks vlan-spanning-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get)</code></td>
<td><code>[GET /v1/subnets/vlan-spanning](https://containers.cloud.ibm.com/global/swagger-global-api/#/accounts/GetVlanSpanning)</code></td>
</tr>
<tr>
<td>Wenn für nur einen Cluster festgelegt: VLANs auflisten, mit denen der Cluster in einer Zone verbunden ist.</br>Wenn für alle Cluster im Konto festgelegt: Alle in einer Zone verfügbaren VLANs auflisten.</td>
<td><code>[ibmcloud ks vlans](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlans)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/vlans](https://containers.cloud.ibm.com/global/swagger-global-api/#/properties/GetDatacenterVLANs)</code></td>
</tr>
<tr>
<td>Alle Webhooks für einen Cluster auflisten</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterWebhooks)</code></td>
</tr>
<tr>
<td>Informationen zu einem Workerknoten anzeigen</td>
<td><code>[ibmcloud ks worker-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetWorkers)</code></td>
</tr>
<tr>
<td>Informationen zu einem Worker-Pool anzeigen</td>
<td><code>[ibmcloud ks worker-pool-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetWorkerPool)</code></td>
</tr>
<tr>
<td>Alle Worker-Pools in einem Cluster auflisten</td>
<td><code>[ibmcloud ks worker-pools](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pools)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetWorkerPools)</code></td>
</tr>
<tr>
<td>Alle Workerknoten in einem Cluster auflisten</td>
<td><code>[ibmcloud ks workers](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_workers)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterWorkers)</code></td>
</tr>
</tbody>
</table>

### Editoraktionen
{: #editor-actions}

Die Plattformrolle **Editor** umfasst alle Berechtigungen, die durch die Rolle **Anzeigeberechtigter** erteilt werden, sowie die folgenden Berechtigungen. Mit der Rolle **Editor** können Benutzer wie z. B. Entwickler Services binden, mit Ingress-Ressourcen arbeiten und die Protokollweiterleitung für ihre Apps einrichten, jedoch nicht die Infrastruktur ändern. **Tipp:** Verwenden Sie diese Rolle für Anwendungsentwickler und ordnen Sie die Rolle <a href="#cloud-foundry">Cloud Foundry</a>-**Entwickler** zu.
{: shortdesc}

<table>
<caption>Übersicht über CLI-Befehle und API-Aufrufe, die die Plattformrolle eines Editors in {{site.data.keyword.containerlong_notm}} erfordern</caption>
<thead>
<th id="editor-actions-mngt">Aktion</th>
<th id="editor-actions-cli">CLI-Befehl</th>
<th id="editor-actions-api">API-Aufruf</th>
</thead>
<tbody>
<tr>
<td>Automatische Aktualisierungen für das Ingress-ALB-Add-on inaktivieren</td>
<td><code>[ibmcloud ks alb-autoupdate-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_disable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Automatische Aktualisierungen für das Ingress-ALB-Add-on aktivieren</td>
<td><code>[ibmcloud ks alb-autoupdate-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_enable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Prüfen, ob automatische Aktualisierungen für das Ingress-ALB-Add-on aktiviert sind</td>
<td><code>[ibmcloud ks alb-autoupdate-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_get)</code></td>
<td><code>[GET /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>Ingress-ALB aktivieren oder inaktivieren</td>
<td><code>[ibmcloud ks alb-configure](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure)</code></td>
<td><code>[POST /albs](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/EnableALB) und [DELETE /albs/{albId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/)</code></td>
</tr>
<tr>
<td>Aktualisierung des Ingress-ALB-Add-ons auf den Build zurücksetzen, den die ALB-Pods zuvor ausgeführt haben</td>
<td><code>[ibmcloud ks alb-rollback](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_rollback)</code></td>
<td><code>[PUT /clusters/{idOrName}/updaterollback](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/RollbackUpdate)</code></td>
</tr>
<tr>
<td>Einmalige Aktualisierung der ALB-Pods durch manuelles Aktualisieren des Ingress-ALB-Add-ons erzwingen</td>
<td><code>[ibmcloud ks alb-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_update)</code></td>
<td><code>[PUT /clusters/{idOrName}/update](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/UpdateALBs)</code></td>
</tr>
<tr>
<td>Webhook für API-Serveraudit erstellen</td>
<td><code>[ibmcloud ks apiserver-config-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_config_set)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/apiserverconfigs/UpdateAuditWebhook)</code></td>
</tr>
<tr>
<td>Webhook für einen API-Serveraudit löschen</td>
<td><code>[ibmcloud ks apiserver-config-unset](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_config_unset)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/global/swagger-global-api/#/apiserverconfigs/DeleteAuditWebhook)</code></td>
</tr>
<tr>
<td>Service an einen Cluster binden. **Hinweis**: Sie müssen über die Rolle des Cloud Foundry-Entwicklers für den Bereich verfügen, in dem sich Ihre Serviceinstanz befindet.</td>
<td><code>[ibmcloud ks cluster-service-bind](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_service_bind)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/BindServiceToNamespace)</code></td>
</tr>
<tr>
<td>Bindung eines Service an einen Cluster aufheben. **Hinweis**: Sie müssen über die Rolle des Cloud Foundry-Entwicklers für den Bereich verfügen, in dem sich Ihre Serviceinstanz befindet.</td>
<td><code>[ibmcloud ks cluster-service-unbind](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_service_unbind)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/services/{namespace}/{serviceInstanceId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UnbindServiceFromNamespace)</code></td>
</tr>
<tr>
<td>Protokollweiterleitungskonfiguration für alle Protokollquellen außer <code>kube-audit</code> erstellen</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>Anzeige einer Protokollweiterleitungskonfiguration aktualisieren</td>
<td><code>[ibmcloud ks logging-config-refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_refresh)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/refresh](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/RefreshLoggingConfig)</code></td>
</tr>
<tr>
<td>Protokollweiterleitungskonfiguration für alle Protokollquellen außer <code>kube-audit</code> löschen</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/DeleteLoggingConfig)</code></td>
</tr>
<tr>
<td>Alle Protokollweiterleitungskonfigurationen für einen Cluster löschen</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/DeleteLoggingConfigs)</code></td>
</tr>
<tr>
<td>Protokollweiterleitungskonfiguration aktualisieren</td>
<td><code>[ibmcloud ks logging-config-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/UpdateLoggingConfig)</code></td>
</tr>
<tr>
<td>Protokollfilterkonfiguration erstellen</td>
<td><code>[ibmcloud ks logging-filter-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/CreateFilterConfig)</code></td>
</tr>
<tr>
<td>Protokollfilterkonfiguration löschen</td>
<td><code>[ibmcloud ks logging-filter-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_delete)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/DeleteFilterConfig)</code></td>
</tr>
<tr>
<td>Alle Protokollierungsfilterkonfigurationen für den Kubernetes-Cluster löschen</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/DeleteFilterConfigs)</code></td>
</tr>
<tr>
<td>Protokollfilterkonfiguration aktualisieren</td>
<td><code>[ibmcloud ks logging-filter-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/UpdateFilterConfig)</code></td>
</tr>
<tr>
<td>Eine NLB-IP-Adresse zu einem vorhandenen NLB-Hostnamen hinzufügen.</td>
<td><code>[ibmcloud ks nlb-dns-add](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-add)</code></td>
<td><code>[PUT /clusters/{idOrName}/add](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-dns-beta/UpdateDNSWithIP)</code></td>
</tr>
<tr>
<td>Einen DNS-Hostnamen erstellen, um eine NLB-IP-Adresse zu registrieren.</td>
<td><code>[ibmcloud ks nlb-dns-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-create)</code></td>
<td><code>[POST /clusters/{idOrName}/register](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-dns-beta/RegisterDNSWithIP)</code></td>
</tr>
<tr>
<td>NLB-Hostnamen und -IP-Adressen auflisten, die in einem Cluster registriert sind.</td>
<td><code>[ibmcloud ks nlb-dnss](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-ls)</code></td>
<td><code>[GET /clusters/{idOrName}/list](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-dns-beta/ListNLBIPsForSubdomain)</code></td>
</tr>
<tr>
<td>NLB-IP-Adresse aus einem Hostnamen entfernen.</td>
<td><code>[ibmcloud ks nlb-dns-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-rm)</code></td>
<td><code>[DELETE /clusters/{idOrName}/host/{nlbHost}/ip/{nlbIP}/remove](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-dns-beta/UnregisterDNSWithIP)</code></td>
</tr>
<tr>
<td>Statusprüfmonitor für einen vorhandenen NLB-Hostnamen in einem Cluster konfigurieren und optional aktivieren.</td>
<td><code>[ibmcloud ks nlb-dns-monitor-configure](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-configure)</code></td>
<td><code>[POST /health/clusters/{idOrName}/config](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/AddNlbDNSHealthMonitor)</code></td>
</tr>
<tr>
<td>Einstellungen für einen vorhandenen Statusprüfmonitor anzeigen.</td>
<td><code>[ibmcloud ks nlb-dns-monitor-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-get)</code></td>
<td><code>[GET /health/clusters/{idOrName}/host/{nlbHost}/config](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/GetNlbDNSHealthMonitor)</code></td>
</tr>
<tr>
<td>Vorhandenen Statusprüfmonitor für einen Hostnamen in einem Cluster inaktivieren.</td>
<td><code>[ibmcloud ks nlb-dns-monitor-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-disable)</code></td>
<td><code>[PUT /clusters/{idOrName}/health](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/UpdateNlbDNSHealthMonitor)</code></td>
</tr>
<tr>
<td>Einen von Ihnen konfigurierten Statusprüfmonitor aktivieren.</td>
<td><code>[ibmcloud ks nlb-dns-monitor-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-enable)</code></td>
<td><code>[PUT /clusters/{idOrName}/health](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/UpdateNlbDNSHealthMonitor)</code></td>
</tr>
<tr>
<td>Einstellungen des Statusprüfmonitors für jeden NLB-Hostnamen in einem Cluster auflisten.</td>
<td><code>[ibmcloud ks nlb-dns-monitor-ls](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-ls)</code></td>
<td><code>[GET /health/clusters/{idOrName}/list](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/ListNlbDNSHealthMonitors)</code></td>
</tr>
<tr>
<td>Status der Statusprüfung für jede IP-Adresse auflisten, die bei einem NLB-Hostnamen in einem Cluster registriert ist.</td>
<td><code>[ibmcloud ks nlb-dns-monitor-status](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-status)</code></td>
<td><code>[GET /health/clusters/{idOrName}/status](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/ListNlbDNSHealthMonitorStatus)</code></td>
</tr>
<tr>
<td>Webhook in einem Cluster erstellen.</td>
<td><code>[ibmcloud ks webhook-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_webhook_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddClusterWebhooks)</code></td>
</tr>
</tbody>
</table>

### Operatoraktionen
{: #operator-actions}

Die Plattformrolle **Operator** (Bediener) umfasst alle Berechtigungen, die durch die Rolle **Anzeigeberechtigter** erteilt werden, sowie die Berechtigungen in der folgenden Tabelle. Mit der Rolle **Operator** können Benutzer wie Site Reliability Engineers (SREs), DevOps-Entwickler oder Clusteradministratoren Workerknoten und eine Infrastruktur zur Fehlerbehebung hinzufügen, indem sie z. B. einen Workerknoten neu laden. Sie können jedoch den Cluster nicht erstellen oder löschen, die Berechtigungsnachweise nicht ändern und keine clusterweiten Funktionen wie Serviceendpunkte oder verwaltete Add-ons einrichten.
{: shortdesc}

<table>
<caption>Übersicht über CLI-Befehle und API-Aufrufe, die die Plattformrolle eines Operators in {{site.data.keyword.containerlong_notm}} erfordern</caption>
<thead>
<th id="operator-mgmt">Aktion</th>
<th id="operator-cli">CLI-Befehl</th>
<th id="operator-api">API-Aufruf</th>
</thead>
<tbody>
<tr>
<td>Kubernetes-Master aktualisieren</td>
<td><code>[ibmcloud ks apiserver-refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_refresh) (cluster-refresh)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/masters](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/HandleMasterAPIServer)</code></td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} IAM-Service-ID für den Cluster erstellen, Richtlinie für die Service-ID erstellen, die die Servicezugriffsrolle **Leseberechtigter** (Reader) in {{site.data.keyword.registrylong_notm}} zuordnet, und schließlich API-Schlüssel für die Service-ID erstellen</td>
<td><code>[ibmcloud ks cluster-pull-secret-apply](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_pull_secret_apply)</code></td>
<td>-</td>
</tr>
<tr>
<td>Teilnetz einem Cluster hinzufügen</td>
<td><code>[ibmcloud ks cluster-subnet-add](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_subnet_add)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddClusterSubnet)</code></td>
</tr>
<tr>
<td>Teilnetz erstellen und einem Cluster hinzufügen.</td>
<td><code>[ibmcloud ks cluster-subnet-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_subnet_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/vlans/{vlanId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/CreateClusterSubnet)</code></td>
</tr>
<tr>
<td>Teilnetz von Cluster abhängen</td>
<td><code>[ibmcloud ks cluster-subnet-detach](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_subnet_detach)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/DetachClusterSubnet)</code></td>
</tr>
<tr>
<td>Cluster aktualisieren</td>
<td><code>[ibmcloud ks cluster-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UpdateCluster)</code></td>
</tr>
<tr>
<td>Benutzerverwaltetes Teilnetz einem Cluster hinzufügen</td>
<td><code>[ibmcloud ks cluster-user-subnet-add](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_user_subnet_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Benutzerverwaltetes Teilnetz aus einem Cluster entfernen</td>
<td><code>[ibmcloud ks cluster-user-subnet-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_user_subnet_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/usersubnets/{subnetId}/vlans/{vlanId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Workerknoten hinzufügen</td>
<td><code>[ibmcloud ks worker-add (veraltet)](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddClusterWorkers)</code></td>
</tr>
<tr>
<td>Worker-Pool erstellen</td>
<td><code>[ibmcloud ks worker-pool-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/CreateWorkerPool)</code></td>
</tr>
<tr>
<td>Worker-Pool neu ausgleichen</td>
<td><code>[ibmcloud ks worker-pool-rebalance](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_rebalance)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>Größe eines Worker-Pools ändern</td>
<td><code>[ibmcloud ks worker-pool-resize](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_resize)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>Worker-Pool löschen</td>
<td><code>[ibmcloud ks worker-pool-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveWorkerPool)</code></td>
</tr>
<tr>
<td>Workerknoten neu starten</td>
<td><code>[ibmcloud ks worker-reboot](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reboot)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Workerknoten erneut laden</td>
<td><code>[ibmcloud ks worker-reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Workerknoten entfernen</td>
<td><code>[ibmcloud ks worker-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveClusterWorker)</code></td>
</tr>
<tr>
<td>Workerknoten aktualisieren</td>
<td><code>[ibmcloud ks worker-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Zone einem Worker-Pool hinzufügen</td>
<td><code>[ibmcloud ks zone-add](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_zone_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddWorkerPoolZone)</code></td>
</tr>
<tr>
<td>Netzkonfiguration für eine bestimmte Zone in einem Worker-Pool aktualisieren</td>
<td><code>[ibmcloud ks zone-network-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_zone_network_set)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddWorkerPoolZoneNetwork)</code></td>
</tr>
<tr>
<td>Zone aus einem Worker-Pool entfernen</td>
<td><code>[ibmcloud ks zone-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_zone_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveWorkerPoolZone)</code></td>
</tr>
</tbody>
</table>

### Administratoraktionen
{: #admin-actions}

Die Plattformrolle **Administrator** umfasst alle Berechtigungen, die durch die Rollen **Anzeigeberechtigter**, **Editor** und **Operator** erteilt werden, sowie die folgenden Berechtigungen. Mit der Rolle **Administrator** können Benutzer wie z. B. Cluster- oder Kontoadministratoren Cluster erstellen und löschen oder clusterweite Funktionen wie Serviceendpunkte oder verwaltete Add-ons einrichten. Zum Erstellen solcher Infrastrukturressourcen, wie Workerknotenmaschinen, VLANs und Teilnetze, benötigen Administratorbenutzer entweder die **<a href="#infra">Infrastrukturrolle</a> des **Superuser** oder der API-Schlüssel für die Region muss mit den entsprechenden Berechtigungen eingerichtet sein.
{: shortdesc}

<table>
<caption>Übersicht über CLI-Befehle und API-Aufrufe, die die Plattformrolle eines Administrators in {{site.data.keyword.containerlong_notm}} erfordern</caption>
<thead>
<th id="admin-mgmt">Aktion</th>
<th id="admin-cli">CLI-Befehl</th>
<th id="admin-api">API-Aufruf</th>
</thead>
<tbody>
<tr>
<td>Beta: Zertifikat aus der {{site.data.keyword.cloudcerts_long_notm}}-Instanz für eine Lastausgleichsfunktion für Anwendungen (ALB) bereitstellen</td>
<td><code>[ibmcloud ks alb-cert-deploy](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_cert_deploy)</code></td>
<td><code>[POST /albsecrets](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/CreateALBSecret) oder [PUT /albsecrets](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb-beta/UpdateALBSecret)</code></td>
</tr>
<tr>
<td>Beta: Details zu einem geheimen ALB-Schlüssel in einem Cluster anzeigen</td>
<td><code>[ibmcloud ks alb-cert-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_cert_get)</code></td>
<td><code>[GET /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb-beta/ViewClusterALBSecrets)</code></td>
</tr>
<tr>
<td>Beta: Geheimen ALB-Schlüssel aus einem Cluster entfernen</td>
<td><code>[ibmcloud ks alb-cert-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_cert_rm)</code></td>
<td><code>[DELETE /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb-beta/DeleteClusterALBSecrets)</code></td>
</tr>
<tr>
<td>Alle geheimen ALB-Schlüssel in einem Cluster auflisten</td>
<td><code>[ibmcloud ks alb-certs](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_certs)</code></td>
<td>-</td>
</tr>
<tr>
<td>API-Schlüssel für das {{site.data.keyword.cloud_notm}}-Konto für den Zugriff auf das verknüpfte Portfolio der IBM Cloud-Infrastruktur festlegen.</td>
<td><code>[ibmcloud ks api-key-reset](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_api_key_reset)</code></td>
<td><code>[POST /v1/keys](https://containers.cloud.ibm.com/global/swagger-global-api/#/accounts/ResetUserAPIKey)</code></td>
</tr>
<tr>
<td>Verwaltetes Add-on wie Istio oder Knative in einem Cluster inaktvieren.</td>
<td><code>[ibmcloud ks cluster-addon-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addon_disable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>Verwaltetes Add-on wie Istio oder Knative in einem Cluster aktivieren.</td>
<td><code>[ibmcloud ks cluster-addon-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addon_enable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>Verwaltete Add-ons wie Istio oder Knative auflisten, die in einem Cluster aktiviert sind.</td>
<td><code>[ibmcloud ks cluster-addons](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addons)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterAddons)</code></td>
</tr>
<tr>
<td>Kostenlosen Cluster oder Standardcluster erstellen. **Hinweis:** Die Plattformrolle 'Administrator' für {{site.data.keyword.registrylong_notm}} und die Infrastrukturrolle 'Superuser' sind ebenfalls erforderlich.</td>
<td><code>[ibmcloud ks cluster-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_create)</code></td>
<td><code>[POST /v1/clusters](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/CreateCluster)</code></td>
</tr>
<tr>
<td>Angegebene Funktion für einen Cluster inaktivieren (z. B. den öffentlichen Serviceendpunkt für den Cluster-Master).</td>
<td><code>[ibmcloud ks cluster-feature-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_disable)</code></td>
<td>-</td>
</tr>
<tr>
<td>Angegebene Funktion für einen Cluster aktivieren (z. B. den privaten Serviceendpunkt für den Cluster-Master).</td>
<td><code>[ibmcloud ks cluster-feature-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_enable)</code></td>
<td>-</td>
</tr>
<tr>
<td>Cluster löschen.</td>
<td><code>[ibmcloud ks cluster-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveCluster)</code></td>
</tr>
<tr>
<td>Infrastrukturberechtigungsnachweise für das {{site.data.keyword.cloud_notm}}-Konto für den Zugriff auf ein anderes Portfolio der IBM Cloud-Infrastruktur festlegen.</td>
<td><code>[ibmcloud ks credential-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credentials_set)</code></td>
<td><code>[POST /v1/credentials](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/accounts/StoreUserCredentials)</code></td>
</tr>
<tr>
<td>Infrastrukturberechtigungsnachweise für das {{site.data.keyword.cloud_notm}}-Konto für den Zugriff auf ein anderes Portfolio der IBM Cloud-Infrastruktur entfernen.</td>
<td><code>[ibmcloud ks credential-unset](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credentials_unset)</code></td>
<td><code>[DELETE /v1/credentials](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/accounts/RemoveUserCredentials)</code></td>
</tr>
<tr>
<td>Beta: Geheimen Kubernetes-Schlüssel mithilfe von {{site.data.keyword.keymanagementservicefull}} verschlüsseln.</td>
<td><code>[ibmcloud ks key-protect-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_messages)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/kms](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/CreateKMSConfig)</code></td>
</tr>
<tr>
<td>Automatische Aktualisierungen für das Fluentd-Cluster-Add-on inaktivieren</td>
<td><code>[ibmcloud ks logging-autoupdate-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_autoupdate_disable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Automatische Aktualisierungen für das Fluentd-Cluster-Add-on aktivieren</td>
<td><code>[ibmcloud ks logging-autoupdate-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_autoupdate_enable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Snapshot der API-Serverprotokolle in einem {{site.data.keyword.cos_full_notm}}-Bucket erfassen</td>
<td><code>[ibmcloud ks logging-collect](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_collect)</code></td>
<td>[POST /v1/log-collector/{idOrName}/masterlogs](https://containers.cloud.ibm.com/global/swagger-global-api/#/log45collector/CreateMasterLogCollection)</td>
</tr>
<tr>
<td>Status des Snapshots der API-Serverprotokolle anzeigen</td>
<td><code>[ibmcloud ks logging-collect-status](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_collect_status)</code></td>
<td>[GET /v1/log-collector/{idOrName}/masterlogs](https://containers.cloud.ibm.com/global/swagger-global-api/#/log45collector/GetMasterLogCollectionStatus)</td>
</tr>
<tr>
<td>^Protokollweiterleitungskonfiguration für die Protokollquelle <code>kube-audit</code> erstellen</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>Protokollweiterleitungskonfiguration für die Protokollquelle <code>kube-audit</code> löschen</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/DeleteLoggingConfig)</code></td>
</tr>
</tbody>
</table>

<br />


## {{site.data.keyword.cloud_notm}} IAM-Servicerollen
{: #service}

Jedem Benutzer, dem eine {{site.data.keyword.cloud_notm}} IAM-Servicezugriffsrolle zugeordnet ist, wird automatisch auch eine entsprechende Rolle für Kubernetes-RBAC (RBAC - rollenbasierte Zugriffssteuerung) in einem bestimmten Namensbereich zugeordnet. Weitere Informationen zu Servicezugriffsrollen finden Sie unter [{{site.data.keyword.cloud_notm}} IAM-Servicerollen](/docs/containers?topic=containers-users#platform). Weisen Sie {{site.data.keyword.cloud_notm}} IAM-Plattformrollen nicht gleichzeitig mit einer Servicerolle zu. Sie müssen Plattform- und Servicerollen separat zuweisen.
{: shortdesc}

Suchen Sie nach Informationen dazu, welche Kubernetes-Aktionen die einzelnen Servicerollen durch RBAC erteilen? Siehe [Kubernetes-Ressourcenberechtigungen für RBAC-Rollen](#rbac_ref). Weitere Informationen zu RBAC-Rollen finden Sie unter [RBAC-Berechtigungen zuordnen](/docs/containers?topic=containers-users#role-binding) und [Vorhandene Berechtigungen durch Aggregieren von Clusterrollen erweitern](/docs/containers?topic=containers-users#rbac_aggregate).
{: tip}

In der folgenden Tabelle sind die Kubernetes-Ressourcenberechtigungen aufgeführt, die durch die einzelnen Servicerollen und die entsprechenden RBAC-Rollen erteilt werden.

<table>
<caption>Kubernetes-Ressourcenberechtigungen für Servicerollen und entsprechende RBAC-Rollen</caption>
<thead>
    <th id="service-role">Servicerolle</th>
    <th id="rbac-role">Entsprechende RBAC-Rolle, Bindung und Bereich</th>
    <th id="kube-perm">Kubernetes-Ressourcenberechtigungen</th>
</thead>
<tbody>
  <tr>
    <td id="service-role-reader" headers="service-role">Leseberechtigter (Reader)</td>
    <td headers="service-role-reader rbac-role">Bei Geltung für nur einen Namensbereich: Die Clusterrolle <strong><code>view</code></strong> wird durch die Rollenbindung <strong><code>ibm-view</code></strong> in diesem Namensbereich angewendet</br><br>Bei Geltung für alle Namensbereiche: Die Clusterrolle <strong><code>view</code></strong> wird durch die Rollenbindung <strong><code>ibm-view</code></strong> in jedem Namensbereich des Clusters angewendet.</td>
    <td headers="service-role-reader kube-perm"><ul>
      <li>Lesezugriff auf Ressourcen in einem Namensbereich</li>
      <li>Kein Lesezugriff auf Rollen und Rollenbindungen oder auf geheime Kubernetes-Schlüssel</li>
      <li>Zugriff auf das Kubernetes-Dashboard zum Anzeigen von Ressourcen in einem Namensbereich</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-writer" headers="service-role">Schreibberechtigter (Writer)</td>
    <td headers="service-role-writer rbac-role">Bei Geltung für nur einen Namensbereich: Die Clusterrolle <strong><code>edit</code></strong> wird durch die Rollenbindung <strong><code>ibm-edit</code></strong> in diesem Namensbereich angewendet</br><br>Bei Geltung für alle Namensbereiche: Die Clusterrolle <strong><code>edit</code></strong> wird durch die Rollenbindung <strong><code>ibm-edit</code></strong> in jedem Namensbereich des Clusters angewendet.</td>
    <td headers="service-role-writer kube-perm"><ul><li>Schreib-/Lesezugriff auf Ressourcen in einem Namensbereich</li>
    <li>Kein Schreib-/Lesezugriff auf Rollen und Rollenbindungen</li>
    <li>Zugriff auf das Kubernetes-Dashboard zum Anzeigen von Ressourcen in einem Namensbereich</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-manager" headers="service-role">Manager</td>
    <td headers="service-role-manager rbac-role">Bei Geltung für nur einen Namensbereich: Die Clusterrolle <strong><code>admin</code></strong> wird durch die Rollenbindung <strong><code>ibm-operate</code></strong> in diesem Namensbereich angewendet</br><br>Bei Geltung für alle Namensbereiche: Die Clusterrolle <strong><code>cluster-admin</code></strong> wird durch die Clusterrollenbindung <strong><code>ibm-admin</code></strong> angewendet, die für alle Namensbereiche gilt.</td>
    <td headers="service-role-manager kube-perm">Bei Geltung für nur einen Namensbereich:
      <ul><li>Schreib-/Lesezugriff auf alle Ressourcen in einem Namensbereich, jedoch nicht auf Ressourcenquoten oder den Namensbereich selbst</li>
      <li>RBAC-Rollen und -Rollenbindungen in einem Namensbereich erstellen</li>
      <li>Zugriff auf das Kubernetes-Dashboard zum Anzeigen aller Ressourcen in einem Namensbereich</li></ul>
    </br>Bei Geltung für alle Namensbereiche:
        <ul><li>Schreib-/Lesezugriff auf alle Ressourcen in jedem Namensbereich</li>
        <li>RBAC-Rollen und -Rollenbindungen in einem Namensbereich oder Clusterrollen und Clusterrollenbindungen in allen Namensbereichen erstellen</li>
        <li>Zugriff auf das Kubernetes-Dashboard</li>
        <li>Ingress-Ressource erstellen, durch die Anwendungen öffentlich verfügbar gemacht werden</li>
        <li>Clustermetriken prüfen, z. B. durch die Befehle <code>kubectl top pods</code>, <code>kubectl top nodes</code> oder <code>kubectl get nodes</code></li></ul>
    </td>
  </tr>
    <tr>
    <td>Jede Servicerolle</td>
    <td>**Nur OpenShift-Cluster**: Alle Benutzer eines OpenShift-Clusters erhalten die Clusterrollen `basic-users` und `self-provisioners`, die von den Clusterrollenbindungen `basic-users` und `self-provisioners` angewendet werden.</td>
    <td><ul>
      <li>Grundlegende Informationen zu Projekten abrufen, auf die der Benutzer Zugriff hat.</li>
      <li>Berechtigte Ressourcen in den Projekten erstellen, auf die der Benutzer zugreifen kann.</li>
      <li>Weitere Informationen finden Sie in der [OpenShift-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_rbac.html).</li></ul></td>
  </tr>
</tbody>
</table>

<br />


## Kubernetes-Ressourcenberechtigungen für RBAC-Rollen
{: #rbac_ref}

Jedem Benutzer, dem eine {{site.data.keyword.cloud_notm}} IAM-Servicezugriffsrolle zugeordnet ist, wird automatisch auch eine entsprechende vordefinierte Rolle für Kubernetes-RBAC (RBAC - rollenbasierte Zugriffssteuerung) zugeordnet. Wenn Sie eigene angepasste Kubernetes-RBAC-Rollen verwalten wollen, finden Sie entsprechende Informationen in [Angepasste RBAC-Berechtigungen für Benutzer, Gruppen oder Servicekonten erstellen](/docs/containers?topic=containers-users#rbac).
{: shortdesc}

Fragen Sie sich, ob Sie über die richtigen Berechtigungen zum Ausführen eines bestimmten `kubectl`-Befehls für eine Ressource in einem Namensbereich haben? Probieren Sie den Befehl [`kubectl auth can-i` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-can-i-em-) aus.
{: tip}

In der folgenden Tabelle sind die Berechtigungen aufgeführt, die durch jede RBAC-Rolle für einzelne Kubernetes-Ressourcen erteilt werden. Für die Berechtigungen wird angegeben, welche Verben ein Benutzer mit der jeweiligen Rolle für die Ressource ausführen kann, wie zum Beispiel: "get", "list", "describe", "create" oder "delete".

<table>
 <caption>Kubernetes-Ressourcenberechtigungen, die durch die vordefinierten RBAC-Rollen erteilt werden</caption>
 <thead>
  <th>Kubernetes-Ressource</th>
  <th><code>view</code></th>
  <th><code>edit</code></th>
  <th><code>admin</code> und <code>cluster-admin</code></th>
 </thead>
<tbody>
<tr>
  <td><code>bindings</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>configmaps</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>cronjobs.batch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>daemonsets.apps </code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>daemonsets.extensions</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>deployments.apps</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>deployments.apps/rollback</code></td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>deployments.apps/scale</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>deployments.extensions</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>deployments.extensions/rollback</code></td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>deployments.extensions/scale</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>endpoints</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>events</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>horizontalpodautoscalers.autoscaling</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>ingresses.extensions</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>jobs.batch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>limitranges</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>localsubjectaccessreviews</code></td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code></td>
</tr><tr>
  <td><code>namespaces</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></br>**nur cluster-admin:** <code>create</code>, <code>delete</code></td>
</tr><tr>
  <td><code>namespaces/status</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>networkpolicies</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>networkpolicies.extensions</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>persistentvolumeclaims</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>poddisruptionbudgets.policy</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>pods</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>top</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>pods/attach</code></td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>pods/exec</code></td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>pods/log</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>pods/portforward</code></td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>pods/proxy</code></td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>pods/status</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>replicasets.apps</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>replicasets.apps/scale</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>replicasets.extensions</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>replicasets.extensions/scale</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>replicationcontrollers</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>replicationcontrollers/scale</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>replicationcontrollers/status</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>replicationcontrollers.extensions/scale</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>resourcequotas</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>resourcequotas/status</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td><code>rolebindings</code></td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>roles</code></td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>secrets</code></td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>serviceaccounts</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
</tr><tr>
  <td><code>Services</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>services/proxy</code></td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>statefulsets.apps</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td><code>statefulsets.apps/scale</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr>
</tbody>
</table>

<br />


## Cloud Foundry-Rollen
{: #cloud-foundry}

Cloud Foundry-Rollen gewähren Zugriff auf Organisationen und Bereiche innerhalb des Kontos. Wenn Sie die Liste der Cloud Foundry-basierten Services in {{site.data.keyword.cloud_notm}} anzeigen möchten, führen Sie `ibmcloud service list` aus. Weitere Informationen finden Sie unter den verfügbaren [Organisations- und Benutzerrollen](/docs/iam?topic=iam-cfaccess) oder in den Schritten unter [Cloud Foundry-Zugriff verwalten](/docs/iam?topic=iam-mngcf) in der Dokumentation zu {{site.data.keyword.cloud_notm}} Identity and Access Management.
{: shortdesc}

In der folgenden Tabelle werden die Cloud Foundry-Rollen aufgeführt, die für Clusteraktionsberechtigungen erforderlich sind.

<table>
  <caption>Berechtigungen zur Clusterverwaltung für Cloud Foundry-Rollen</caption>
  <thead>
    <th>Cloud Foundry-Rolle</th>
    <th>Berechtigungen der Clusterverwaltung</th>
  </thead>
  <tbody>
  <tr>
    <td>Bereichsrolle: Manager</td>
    <td>Benutzerzugriff auf einen {{site.data.keyword.cloud_notm}}-Bereich verwalten</td>
  </tr>
  <tr>
    <td>Bereichsrolle: Entwickler</td>
    <td>
      <ul><li>{{site.data.keyword.cloud_notm}}-Serviceinstanzen erstellen</li>
      <li>{{site.data.keyword.cloud_notm}}-Serviceinstanzen an Cluster binden</li>
      <li>Protokolle aus einer Protokollweiterleitungskonfiguration des Clusters auf Bereichsebene anzeigen</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## Klassische Infrastrukturrollen
{: #infra}

Ein Benutzer mit der Infrastrukturzugriffsrolle **Superuser** [legt den API-Schlüssel für eine Region und eine Ressourcengruppe fest](/docs/containers?topic=containers-users#api_key), sodass Infrastrukturaktionen ausgeführt werden können. (In seltenen Fällen legt er [manuell unterschiedliche Berechtigungsnachweise für das Konto fest](/docs/containers?topic=containers-users#credentials)). Dann werden die Infrastrukturaktionen, die von anderen Benutzern im Konto ausgeführt werden können, über {{site.data.keyword.cloud_notm}} IAM-Plattformrollen autorisiert. Sie müssen die Berechtigungen der Benutzer für die klassische Infrastruktur nicht bearbeiten. Verwenden Sie die folgende Tabelle zum Anpassen der Benutzerberechtigungen für die klassische Infrastruktur nur, wenn Sie **Superuser** nicht dem Benutzer zuordnen können, der den API-Schlüssel festgelegt hat. Weitere Informationen zum Zuordnen von Berechtigungen finden Sie unter [Infrastrukturberechtigungen anpassen](/docs/containers?topic=containers-users#infra_access).
{: shortdesc}



Müssen Sie überprüfen, ob der API-Schlüssel oder die manuell festgelegten Anmeldeinformationen über die erforderlichen und vorgeschlagenen Infrastrukturberechtigungen verfügen? Verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#infra_permissions_get) `ibmcloud ks infra-permissions-get`.
{: tip}

In der folgenden Tabelle sind die klassischen Infrastrukturberechtigungen aufgeführt, die die Berechtigungsnachweise für eine Region und Ressourcengruppe für das Erstellen von Clustern und für andere allgemeine Anwendungsfälle haben können. Die Beschreibung enthält auch Informationen darüber, wie Sie die Berechtigung in der klassischen {{site.data.keyword.cloud_notm}} IAM-Infrastrukturkonsole oder im Befehl `ibmcloud sl` zuordnen können. Weitere Informationen finden Sie unter in der Anleitung zur [Konsole](/docs/containers?topic=containers-users#infra_console) oder zur [CLI](/docs/containers?topic=containers-users#infra_cli).
*   **Cluster erstellen**: Klassische Infrastrukturberechtigungen, die Sie zum Erstellen eines Clusters benötigen. Wenn Sie `ibmcloud ks infra-permissions-get` ausführen, werden diese Berechtigungen als **Erforderlich** aufgelistet.
*   **Andere allgemeine Anwendungsfälle**: Klassische Infrastrukturberechtigungen, die Sie für andere allgemeine Szenarios verwenden müssen. Auch wenn Sie über die Berechtigung zum Erstellen eines Clusters verfügen, können einige Einschränkungen gelten. Es kann z. B. sein, dass Sie nicht in der Lage sind, einen Cluster mit Bare-Metal-Workerknoten oder einer öffentlichen IP-Adresse zu erstellen oder mit ihm zu arbeiten. Nach der Clustererstellung schlagen möglicherweise weitere Schritte zum Hinzufügen von Netz- oder Speicherressourcen fehl. Wenn Sie `ibmcloud ks infra-permissions-get` ausführen, werden diese Berechtigungen als **Vorgeschlagen** aufgelistet.

| Berechtigung | Beschreibung | IAM-Konsole für Richtlinienzuordnung | CLI |
|:-----------------|:-----------------|:---------------|:----|
| IPMI-Fernverwaltung | Workerknoten verwalten. |Klassische Infrastruktur > Berechtigungen > Geräte|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission REMOTE_MANAGEMENT --enable true</code></pre> |
| Server hinzufügen | Workerknoten hinzufügen. Für Workerknoten, die öffentliche IP-Adressen haben, benötigen Sie auch die Berechtigung **Berechnen mit öffentlichem Netzport hinzufügen**. |Klassische Infrastruktur > Berechtigungen > Konto|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission SERVER_ADD --enable true</code></pre>  |
| Server abbrechen | Workerknoten löschen. |Klassische Infrastruktur > Berechtigungen > Konto|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission SERVER_CANCEL --enable true</code></pre>  |
| Betriebssystem und Rescue-Kernel erneut laden | Sie können Workerknoten aktualisieren, neu starten und erneut laden. |Klassische Infrastruktur > Berechtigungen > Geräte|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission SERVER_RELOAD --enable true</code></pre>  |
| Details zu virtuellen Servern anzeigen | Erforderlich, wenn der Cluster VM-Workerknoten enthält. Sie können Details zu VM-Workerknoten auflisten und abrufen. |Klassische Infrastruktur > Berechtigungen > Geräte|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission VIRTUAL_GUEST_VIEW --enable true</code></pre>  |
| Hardwaredetails anzeigen | Erforderlich, wenn der Cluster Bare-Metal-Workerknoten enthält. Sie können Details zu Bare-Metal-Workerknoten auflisten und abrufen. |Klassische Infrastruktur > Berechtigungen > Geräte|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission HARDWARE_VIEW --enable true</code></pre>  |
| Supportfall hinzufügen | Im Rahmen der Automatisierung der Clustererstellung werden Supportfälle für die Bereitstellung der Clusterinfrastruktur geöffnet. | Zugriff auf Kontoverwaltungsservices zuweisen > Support Center > Administrator|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission TICKET_ADD --enable true</code></pre>  |
| Supportfall bearbeiten | Im Rahmen der Automatisierung der Clustererstellung werden Supportfälle für die Bereitstellung der Clusterinfrastruktur aktualisiert. | Zugriff auf Kontoverwaltungsservices zuweisen > Support Center > Administrator|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission TICKET_EDIT --enable true</code></pre>  |
| Supportfall anzeigen | Im Rahmen der Automatisierung der Clustererstellung werden Supportfälle für die Bereitstellung der Clusterinfrastruktur verwendet. | Zugriff auf Kontoverwaltungsservices zuweisen > Support Center > Administrator|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission TICKET_VIEW --enable true</code></pre>  |
{: class="simple-tab-table"}
{: caption="Erforderliche klassische Infrastrukturberechtigungen" caption-side="top"}
{: #classic-permissions-required}
{: tab-title="Create clusters"}
{: tab-group="Classic infrastructure permissions"}

| Berechtigung | Beschreibung | IAM-Konsole für Richtlinienzuordnung | CLI |
|:-----------------|:-----------------|:---------------|:----|
| Auf sämtliche VM-Workerknoten zugreifen | Zugriff auf alle VM-Workerknoten erteilen. Ohne diese Berechtigung kann ein Benutzer, der einen Cluster erstellt, die VM-Workerknoten eines anderen Clusters möglicherweise nicht anzeigen, auch wenn der Benutzer IAM-Zugriff auf beide Cluster hat. |Klassische Infrastruktur > Geräte > Alle virtuellen Server und automatischen Zugriff auf virtuelle Server auswählen |<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission ACCESS_ALL_GUEST --enable true</code></pre> |
| Auf sämtliche Hardware zugreifen | Zugriff auf alle Bare-Metal-Workerknoten erteilen. Ohne diese Berechtigung kann ein Benutzer, der einen Cluster erstellt, die Bare-Metal-Workerknoten eines anderen Clusters möglicherweise nicht anzeigen, auch wenn der Benutzer IAM-Zugriff auf beide Cluster hat. |Klassische Infrastruktur > Geräte > Alle virtuellen Server und automatischen Zugriff auf virtuelle Server auswählen |<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission ACCESS_ALL_HARDWARE --enable true</code></pre> |
| Datenverarbeitung mit öffentlichem Netzport hinzufügen | Workerknoten einen Port ermöglichen, der über das öffentliche Netz zugänglich sein kann. |Klassische Infrastruktur > Berechtigungen > Netz|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission PUBLIC_NETWORK_COMPUTE --enable true</code></pre> |
| DNS verwalten | Öffentliche Lastausgleichsfunktion oder das Ingress-Networking einrichten, um Apps bereitzustellen. |Klassische Infrastruktur > Berechtigungen > Services|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission DNS_MANAGE --enable true</code></pre> |
| Hostname/Domäne bearbeiten | Öffentliche Lastausgleichsfunktion oder das Ingress-Networking einrichten, um Apps bereitzustellen. |Klassische Infrastruktur > Berechtigungen > Geräte|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission HOSTNAME_EDIT --enable true</code></pre> |
| IP-Adressen hinzufügen | IP-Adressen zu öffentlichen oder privaten Teilnetzen hinzufügen, die für den Lastausgleich im Cluster verwendet werden. |Klassische Infrastruktur > Berechtigungen > Netz|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission IP_ADD --enable true</code></pre> |
| Teilnetzrouten im Netz verwalten | Öffentliche und private VLANs und Teilnetze verwalten, die für den Lastausgleich im Cluster verwendet werden. |Klassische Infrastruktur > Berechtigungen > Netz|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission NETWORK_ROUTE_MANAGE --enable true</code></pre> |
| Portsteuerung verwalten | Ports verwalten, die für den Lastausgleich bei Apps verwendet werden. |Klassische Infrastruktur > Berechtigungen > Geräte|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission PORT_CONTROL --enable true</code></pre> |
| Zertifikate verwalten (SSL) | Zertifikate einrichten, die für den Lastausgleich im Cluster verwendet werden. |Klassische Infrastruktur > Berechtigungen > Services|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission SECURITY_CERTIFICATE_MANAGE --enable true</code></pre>  |
| Zertifikate anzeigen (SSL) | Zertifikate einrichten, die für den Lastausgleich im Cluster verwendet werden. |Klassische Infrastruktur > Berechtigungen > Services|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission SECURITY_CERTIFICATE_MANAGE --enable true</code></pre> |
| Speicher hinzufügen/Upgrades für Speicher durchführen (StorageLayer) | {{site.data.keyword.cloud_notm}}-Datei- oder -Blockspeicherinstanzen erstellen, die als Datenträger für die persistente Datenspeicherung an Ihre Apps angehängt werden sollen. |Klassische Infrastruktur > Berechtigungen > Konto|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission ADD_SERVICE_STORAGE --enable true</code></pre>  |
| Speicher verwalten | {{site.data.keyword.cloud_notm}}-Datei- oder -Blockspeicherinstanzen verwalten, die als Datenträger für die persistente Datenspeicherung an Ihre Apps angehängt werden. |Klassische Infrastruktur > Berechtigungen > Services|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;benutzer-id&gt; --permission NAS_MANAGE --enable true</code></pre> |
{: class="simple-tab-table"}
{: caption="Vorgeschlagene klassische Infrastrukturberechtigungen" caption-side="top"}
{: #classic-permissions-suggested}
{: tab-title="Other common use cases"}
{: tab-group="Classic infrastructure permissions"}




