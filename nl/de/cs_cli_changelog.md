---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

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



# CLI-Änderungsprotokoll
{: #cs_cli_changelog}

Sie werden im Terminal benachrichtigt, wenn Aktualisierungen für die `ibmcloud`-CLI und -Plug-ins verfügbar sind. Halten Sie Ihre CLI stets aktuell, sodass Sie alle verfügbaren Befehle und Flags verwenden können.
{:shortdesc}

* **Community Kubernetes**: [Installieren Sie das CLI-Plug-in](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps), das den Aliasnamen `ibmcloud ks` verwendet.
* **OpenShift**: [Installieren Sie das CLI-Plug-in](/docs/openshift?topic=openshift-openshift-cli), das den Aliasnamen `ibmcloud oc` verwendet.

<br>
In der folgenden Tabelle werden die Änderungen für jede Plug-in-Version der Befehlszeilenschnittstelle (CLI) von {{site.data.keyword.containerlong_notm}} zusammengefasst.

<table summary="Übersicht über die Versionsänderungen für das {{site.data.keyword.containerlong_notm}}-CLI-Plug-in">
<caption>Änderungsprotokoll für das {{site.data.keyword.containerlong_notm}}-CLI-Plug-in</caption>
<thead>
<tr>
<th>Version</th>
<th>Freigabedatum</th>
<th>Änderungen</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.3.95</td>
<td>30, Juli 2019</td>
<td>
<ul>
<li>Hinzufügen des Aliasnamens `ibmcloud oc` zum {{site.data.keyword.containershort_notm}}-Plug-in für das Management von Red Hat OpenShift on IBM Cloud-Clustern.</li>
<li>Hinzufügen des Befehls [`ibmcloud ks cluster-subnet-detach`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_subnet_detach), um ein öffentliches oder privates portables Teilnetz in einem IBM Cloud-Infrastrukturkonto von einem Cluster abzuhängen.</li>
<li>Umbenennen des Befehls `ibmcloud ks machine-types` in `ibmcloud ks flavors`. Sie können weiterhin den Aliasnamen `machine-types` verwenden.</li>
<li>In der Ausgabe von `ibmcloud ks flavors (machine-types)` werden Typen (flavors) angegeben, die nur für {{site.data.keyword.containerlong_notm}} oder nur für Red Hat OpenShift on IBM Cloud unterstützt werden.</li>
<li>In der Ausgabe von `ibmcloud ks cluster-get` wurde `Owner` in `Creator` geändert, um anzugeben, dass das Feld Informationen zu dem Benutzer zurückgibt, der den Cluster erstellt hat.</li>
<li>Verbesserte Fehlerbehandlung bei `ibmcloud ks zone-add`.</li>
<li>Aktualisiert Übersetzungen des Hilfetextes.</li>
</ul></td>
</tr>
<tr>
<td>0.3.58</td>
<td>02. Juli 2019</td>
<td><ul>
<li>Korrigiert einen Programmfehler, sodass eine Nachricht zum Worker-Pool-Neuausgleich nicht zurückgegeben wird, wenn der Autoscaler des Clusters aktiviert ist.</li>
<li>Korrigiert einen Programmfehler zur Unterstützung der Version des OpenShift-Standardclusters.</li>
<li>Aktualisiert den Hilfetext für die Befehle `cluster-feature-enable private-service-endpoint` und `nlb-dns-monitor-configure`.</li>
<li>Aktualisiert Übersetzungen des Hilfetextes.</li>
</ul>
</tr>
<tr>
<td>0.3.49</td>
<td>18. Juni 2019</td>
<td>Aktualisieren von Go auf Version 1.12.6.</td>
</tr>
<tr>
<td>0.3.47</td>
<td>15. Juni 2019</td>
<td><ul>
<li>Korrigiert einen Programmfehler, sodass leere Tabellen in der Ausgabe von `ibmcloud ks kube-versions` nicht zurückgegeben werden.</li>
<li>Aktualisiert das NLB-DNS-Modell, sodass ein Bereich von NLB-IP-Adressen von `ibmcloud ks nlb-dnss` zurückgegeben wird.</li>
<li>Ändert den Beschreibungstext für das {{site.data.keyword.containerlong_notm}}-CLI-Plug-in.</li>
</ul></td>
</tr>
<tr>
<td>0.3.34</td>
<td>31. Mai 2019</td>
<td>Hinzufügen von Unterstützung für das Erstellen von Red Hat OpenShift on IBM Cloud-Clustern:<ul>
<li>Hinzufügen von Unterstützung für OpenShift-Versionen im Flag `--kube-version` des Befehls `cluster-create`. Wenn Sie z. B. einen OpenShift-Standardcluster erstellen wollen, können Sie `--kube-version 3.11_openshift` im Befehl `cluster-create` angeben.</li>
<li>Hinzufügen des Befehls `versions` zum Auflisten aller unterstützten Kubernetes- und OpenShift-Versionen.</li>
<li>Befehl `kube-versions` ist veraltet.</li>
</ul></td>
</tr>
<tr>
<td>0.3.33</td>
<td>30. Mai 2019</td>
<td><ul>
<li>Hinzufügen des Flags <code>--powershell</code> zum Befehl `cluster-config`, um Kubernetes-Umgebungsvariablen im Windows PowerShell-Format abzurufen.</li>
<li>Befehle `region-get`, `region-set` und `regions` sind veraltet. Weitere Informationen finden Sie unter [globale Endpunktfunktionalität](/docs/containers?topic=containers-regions-and-zones#endpoint).</li>
</ul></td>
</tr>
<tr>
<td>0.3.28</td>
<td>23. Mai 2019</td>
<td><ul>
<li>Hinzufügen des Befehls [<code>ibmcloud ks infra-permissions-get</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#infra_permissions_get) zum Prüfen, ob in den Berechtigungsnachweisen für den [Zugriff auf das Portfolio der IBM Cloud-Infrastruktur](/docs/containers?topic=containers-users#api_key) für die Zielregion und -ressourcengruppe vorgeschlagene oder erforderliche Infrastrukturberechtigungen fehlen.</li>
<li>Hinzufügen des Flags <code>--private-only</code> zum Befehl `zone-network-set` zum Aufheben der Festlegung des öffentlichen VLAN für die Worker-Pool-Metadaten. Nachfolgende Workerknoten werden in dieser Worker-Pool-Zone nur mit einem privaten VLAN verbunden.</li>
<li>Entfernen des Flags <code>--force-update</code> aus dem Befehl `worker-update`.</li>
<li>Hinzufügen der Spalte **VLAN ID** in der Ausgabe der `albs`- und `alb-get`-Befehle.</li>
<li>Hinzufügen der Spalte **Multizone Metro** in der Ausgabe des Befehls `supported-locations` zum Bezeichnen von mehrzonenfähigen Zonen.</li>
<li>Hinzufügen der Felder **Master State** und **Master Health** in der Ausgabe des Befehls `cluster-get`. Weitere Informationen finden Sie unter [Masterzustände](/docs/containers?topic=containers-health#states_master).</li>
<li>Aktualisiert Übersetzungen des Hilfetextes.</li>
</ul></td>
</tr>
<tr>
<td>0.3.8</td>
<td>30. April 2019</td>
<td>Hinzufügen der Unterstützung für die [globale Endpunktfunktionalität](/docs/containers?topic=containers-regions-and-zones#endpoint) in Version `0.3`. Sie können jetzt standardmäßig alle Ihre {{site.data.keyword.containerlong_notm}}-Ressourcen an allen Standorten anzeigen und verwalten. Sie brauchen keine Region als Ziel festzulegen, um mit Ressourcen zu arbeiten.</li>
<ul><li>Hinzufügen des Befehls [<code>ibmcloud ks supported-locations</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_supported-locations) zum Auflisten aller von {{site.data.keyword.containerlong_notm}} unterstützten Standorte.</li>
<li>Hinzufügen des Flags <code>--locations</code> zu den `clusters`- und `zones`-Befehlen, um Ressourcen nach einem oder mehreren Standorten zu filtern.</li>
<li>Hinzufügen des Flags <code>--region</code> zu den Befehlen `credential-set/unset/get`, `api-key-reset` und `vlan-spanning-get`. Zum Ausführen dieser Befehle müssen Sie im Flag `--region` eine Region angeben.</li></ul></td>
</tr>
<tr>
<td>0.2.102</td>
<td>15. April 2019</td>
<td>Hinzufügen der Befehlsgruppe [`ibmcloud ks nlb-dns`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#nlb-dns) zum Registrieren und Verwalten eines Hostnamens für IP-Adressen der Netzlastausgleichsfunktion (NLB) und der Befehlsgruppe [`ibmcloud ks nlb-dns-monitor`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-configure) zum Erstellen und Ändern von Statusprüfmonitoren für NLB-Hostnamen. Weitere Informationen finden Sie unter [NLB-IPs mit einem DNS-Hostnamen registrieren](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_dns).
</td>
</tr>
<tr>
<td>0.2.99</td>
<td>9. April 2019</td>
<td><ul>
<li>Aktualisiert Hilfetext.</li>
<li>Aktualisiert die Go-Version auf 1.12.2.</li>
</ul></td>
</tr>
<tr>
<td>0.2.95</td>
<td>3. April 2019</td>
<td><ul>
<li>Fügt Unterstützung für die Versionssteuerung für verwaltete Cluster-Add-ons hinzu.</li>
<ul><li>Fügt den Befehl [<code>ibmcloud ks addon-versions</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_addon_versions) hinzu.</li>
<li>Fügt das Flag <code>--version</code> zu [ibmcloud ks cluster-addon-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addon_enable)-Befehlen hinzu.</li></ul>
<li>Aktualisiert Übersetzungen des Hilfetextes.</li>
<li>Aktualisiert Direktverbindungen zur Dokumentation im Hilfetext.</li>
<li>Korrigiert einen Programmfehler, bei dem JSON-Fehlernachrichten in falschem Format ausgegeben werden.</li>
<li>Korrigiert einen Programmfehler, bei dem die Verwendung eines unbeaufsichtigten Flags (`-s`) bei einigen Befehlen die Ausgabe von Fehlermeldungen verhinderte.</li>
</ul></td>
</tr>
<tr>
<td>0.2.80</td>
<td>19. März 2019</td>
<td><ul>
<li>Hinzufügen von Unterstützung zur Einrichtung der [Master-zu-Worker-Kommunikation mit Serviceendpunkten](/docs/containers?topic=containers-plan_clusters#workeruser-master) in Standardclustern, die Kubernetes Version 1.11 oder höher in [VRF-aktivierten Konten](/docs/resources?topic=resources-private-network-endpoints#getting-started) ausführen.<ul>
<li>Hinzufügen der Flags `--private-service-endpoint` und `--public-service-endpoint` zum Befehl [<code>ibmcloud ks cluster-create</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_create).</li>
<li>Hinzufügen der Felder **Public Service Endpoint URL** und **Private Service Endpoint URL** zur Ausgabe des Befehls <code>ibmcloud ks cluster-get</code>.</li>
<li>Hinzufügen des Befehls [<code>ibmcloud ks cluster-feature-enable private-service-endpoint</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_enable_private_service_endpoint).</li>
<li>Hinzufügen des Befehls [<code>ibmcloud ks cluster-feature-enable public-service-endpoint</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_enable_public_service_endpoint).</li>
<li>Hinzufügen des Befehls [<code>ibmcloud ks cluster-feature-disable public-service-endpoint</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_disable).</li>
</ul></li>
<li>Aktualisieren der Dokumentation und Übersetzung.</li>
<li>Aktualisieren von Go auf Version 1.11.6.</li>
<li>Lösen sporadisch auftretender Netzprobleme für Mac OS-Benutzer.</li>
</ul></td>
</tr>
<tr>
<td>0.2.75</td>
<td>14. März 2019</td>
<td><ul><li>Ausblenden unaufbereiteten HTML-Codes aus Fehlernachrichten.</li>
<li>Korrigieren von Schreibfehlern in Hilfetexten.</li>
<li>Korrigieren von Umsetzungen von Hilfetexten.</li>
</ul></td>
</tr>
<tr>
<td>0.2.61</td>
<td>26. Februar 2019</td>
<td><ul>
<li>Hinzufügen des Befehls `cluster-pull-secret-apply`, der eine IAM-Service-ID für den Cluster, Richtlinien, einen API-Schlüssel und geheime Schlüssel für Image-Pull-Operationen erstellt, sodass Container, die im Kubernetes-Standardnamensbereich (`default`) ausgeführt werden, Images aus der IBM Cloud Container-Registry extrahieren können. Für neue Cluster werden standardmäßig geheime Schlüssel für Image-Pull-Operationen erstellt, die IAM-Berechtigungsnachweise verwenden. Verwenden Sie diesen Befehl, um vorhandene Cluster zu aktualisieren, oder wenn für Ihren Cluster bei der Erstellung ein Fehler mit einem Schlüssel für Image-Pull-Operationen auftritt. Weitere Informationen finden Sie in diesem [Dokument](/docs/containers?topic=containers-images#cluster_registry_auth).</li>
<li>Korrigieren eines Programmfehlers, durch den der Befehl `ibmcloud ks init` zur Ausgabe eines Hilfetexts führte.</li>
</ul></td>
</tr>
<tr>
<td>0.2.53</td>
<td>19. Februar 2019</td>
<td><ul><li>Korrigieren eines Programmfehlers, durch den die Region für die Befehle `ibmcloud ks api-key-reset`, `ibmcloud ks credential-get/set` und `ibmcloud ks vlan-spanning-get` ignoriert wurde.</li>
<li>Verbessern der Leistung für den Befehl `ibmcloud ks worker-update`.</li>
<li>Hinzufügen der Version des Add-ons in Eingabeaufforderungen des Befehls `ibmcloud ks cluster-addon-enable`.</li>
</ul></td>
</tr>
<tr>
<td>0.2.44</td>
<td>08. Februar 2019</td>
<td><ul>
<li>Hinzufügen der Option `--skip-rbac` zum Befehl `ibmcloud ks cluster-config`, um das Hinzufügen von RBAC-Rollen für Kubernetes auf der Basis der {{site.data.keyword.cloud_notm}} IAM-Servicezugriffsrollen zur Clusterkonfiguration zu überspringen. Schließen Sie diese Option nur ein, wenn Sie [eigene RBAC-Rollen für Kubernetes verwalten](/docs/containers?topic=containers-users#rbac). Wenn Sie alle Ihre RBAC-Benutzer mit [{{site.data.keyword.cloud_notm}} IAM-Servicezugriffsrollen](/docs/containers?topic=containers-access_reference#service) verwalten, geben Sie diese Option nicht an.</li>
<li>Aktualisieren von Go auf Version 1.11.5.</li>
</ul></td>
</tr>
<tr>
<td>0.2.40</td>
<td>06. Februar 2019</td>
<td><ul>
<li>Hinzufügen der Befehle [<code>ibmcloud ks cluster-addons</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addons), [<code>ibmcloud ks cluster-addon-enable</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addon_enable) und [<code>ibmcloud ks cluster-addon-disable</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addon_disable) für die Arbeit mit verwalteten Cluster-Add-ons wie das verwaltete [Istio](/docs/containers?topic=containers-istio)-Add-on und das verwaltete [Knative](/docs/containers?topic=containers-serverless-apps-knative)-Add-on für {{site.data.keyword.containerlong_notm}}.</li>
<li>Verbessern der Hilfetexte für {{site.data.keyword.Bluemix_dedicated_notm}}-Benutzer des Befehls <code>ibmcloud ks vlans</code>.</li></ul></td>
</tr>
<tr>
<td>0.2.30</td>
<td>31. Januar 2019</td>
<td>Erhöhen des Standardzeitlimitwerts für den Befehl `ibmcloud ks cluster-config` auf `500s`.</td>
</tr>
<tr>
<td>0.2.19</td>
<td>16. Januar 2019</td>
<td><ul><li>Hinzufügen der Umgebungsvariablen `IKS_BETA_VERSION`, um die überarbeitete Betaversion der {{site.data.keyword.containerlong_notm}}-Plug-in-CLI zu aktivieren. Informationen zum Testen der überarbeiteten Version finden Sie unter [Befehlsstruktur der Betaversion verwenden](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_beta).</li>
<li>Erhöhen des Standardzeitlimitwerts für den Befehl `ibmcloud ks subnets` auf `60s`.</li>
<li>Kleinere Fehler- und Übersetzungskorrekturen.</li></ul></td>
</tr>
<tr>
<td>0.1.668</td>
<td>18. Dezember 2018</td>
<td><ul><li>Ändern des API-Standardendpunkts von <code>https://containers.bluemix.net</code> in <code>https://containers.cloud.ibm.com</code>.</li>
<li>Korrigieren eines Programmfehlers, sodass Übersetzungen für Hilfen zu Befehlen und Fehlernachrichten ordnungsgemäß angezeigt werden.</li>
<li>Schnelleres Anzeigen von Hilfen zu Befehlen.</li></ul></td>
</tr>
<tr>
<td>0.1.654</td>
<td>5. Dezember 2018</td>
<td>Aktualisieren der Dokumentation und Übersetzung.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15. November 2018</td>
<td>
<ul><li>Hinzufügen des Alias [<code>ibmcloud ks cluster-refresh</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_refresh) zum Befehl `apiserver-refresh`.</li>
<li>Hinzufügen des Namens der Ressourcengruppe zur Ausgabe von <code>ibmcloud ks cluster-get</code> und <code>ibmcloud ks clusters</code>.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>6. November 2018</td>
<td>Hinzufügen von Befehlen zur Verwaltung automatischer Aktualisierungen des Cluster-Add-ons für die Ingress-ALB:<ul>
<li>[<code>ibmcloud ks alb-autoupdate-disable</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_disable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-enable</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_enable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-get</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_get)</li>
<li>[<code>ibmcloud ks alb-rollback</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_rollback)</li>
<li>[<code>ibmcloud ks alb-update</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_update)</li>
</ul></td>
</tr>
<tr>
<td>0.1.621</td>
<td>30. Oktober 2018</td>
<td><ul>
<li>Hinzufügen des [Befehls <code>ibmcloud ks credential-get</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credential_get).</li>
<li>Hinzufügen von Unterstützung für die Protokollquelle <code>storage</code> zu allen Clusterprotokollierungsbefehlen. Weitere Informationen finden Sie unter <a href="/docs/containers?topic=containers-health#logging">Informationen zur Protokollweiterleitung für Cluster und Apps</a>.</li>
<li>Hinzufügen des Flags `--network` zum [Befehl <code>ibmcloud ks cluster-config</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_config), durch das die Calico-Konfigurationsdatei für die Ausführung aller Calico-Befehle heruntergeladen wird.</li>
<li>Kleinere Fehlerkorrekturen und Refactoring</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10. Oktober 2018</td>
<td><ul><li>Hinzufügen der Ressourcengruppen-ID zur Ausgabe von <code>ibmcloud ks cluster-get</code>.</li>
<li>Bei [Aktivierung von {{site.data.keyword.keymanagementserviceshort}}](/docs/containers?topic=containers-encryption#keyprotect) als KMS-Provider (KMS - Key Management Service) im Cluster, wird das Feld für die Aktivierung von KMS in der Ausgabe des Befehls <code>ibmcloud ks cluster-get</code> hinzugefügt.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>02. Oktober 2018</td>
<td>Hinzufügen der Unterstützung für [Ressourcengruppen](/docs/containers?topic=containers-clusters#cluster_prepare).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>01. Oktober 2018</td>
<td><ul>
<li>Hinzufügen der Befehle [<code>ibmcloud ks logging-collect</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_collect) und [<code>ibmcloud ks logging-collect-status</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_collect_status) zum Erfassen der API-Serverprotokolle im Cluster.</li>
<li>Hinzufügen des Befehls [<code>ibmcloud ks key-protect-enable</code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_key_protect) zum Aktivieren von {{site.data.keyword.keymanagementserviceshort}} als KMS-Provider (KMS - Key Management Service) im Cluster.</li>
<li>Hinzufügen des Flags <code>--skip-master-health</code> zu den Befehlen [ibmcloud ks worker-reboot](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reboot) und [ibmcloud ks worker-reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reboot) zum Überspringen der Masterstatusprüfung vor dem Einleiten eines Neustarts oder Warmstarts.</li>
<li>Umbenennen von <code>Owner Email</code> in <code>Owner</code> in der Ausgabe von <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
