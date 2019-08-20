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



# Änderungsprotokoll für Fluentd- und Ingress-ALB
{: #cluster-add-ons-changelog}

Ihr {{site.data.keyword.containerlong}}-Cluster wird mit Komponenten geliefert, z. B. die Fluentd- und Ingress-ALB-Komponenten, die von IBM automatisch aktualisiert werden. Sie können automatische Aktualisierungen für manche Komponenten auch inaktivieren und sie separat über die Master- und Worker-Knoten aktualisieren. In den Tabellen in den folgenden Abschnitten finden Sie eine Zusammenfassung der Änderungen für jede Version.
{: shortdesc}

Weitere Informationen zur Verwaltung von Aktualisierungen für Fluentd-und Ingress-ALBs finden Sie unter [Clusterkomponenten aktualisieren](/docs/containers?topic=containers-update#components).

## Ingress-ALB-Änderungsprotokoll
{: #alb_changelog}

Zeigen Sie die Änderungen der Buildversionen für Ingress-Lastausgleichsfunktionen für Anwendungen (ALBs) in Ihren {{site.data.keyword.containerlong_notm}}-Clustern an.
{:shortdesc}

Wenn die Ingress-ALB-Komponente aktualisiert wird, werden die Container `nginx-ingress` und `ingress-auth` in allen ALB-Pods auf die aktuelle Buildversion aktualisiert. Standardmäßig sind automatische Aktualisierungen für die Komponente aktiviert, aber Sie können die automatischen Aktualisierungen inaktivieren und die Komponente manuell aktualisieren. Weitere Informationen finden Sie unter [Ingress-Lastausgleichsfunktion für Anwendungen aktualisieren](/docs/containers?topic=containers-update#alb).

In der folgenden Tabelle finden Sie eine Zusammenfassung der Änderungen für jeden Build der Ingress-ALB-Komponente.

<table summary="Übersicht über Buildänderungen für die Komponente der Ingress-Lastausgleichsfunktion für Anwendungen">
<caption>Änderungsprotokoll für die Komponente der Ingress-Lastausgleichsfunktion für Anwendungen</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
<thead>
<tr>
<th>Build `nginx-ingress`/`ingress-auth`</th>
<th>Freigabedatum</th>
<th>Unterbrechungsfreie Änderungen</th>
<th>Änderungen mit Unterbrechung</th>
</tr>
</thead>
<tbody>
<tr>
<td>515/334</td>
<td>30. Juli 2019</td>
<td><ul>
<li>Fügt eine Bereitschaftsprüfung für ALB-Pod-Neustarts hinzu, um den Verlust von Anforderungen zu verhindern. Es wird verhindert, dass ALB-Pods versuchen, die Datenverkehrsanforderungen weiterzuleiten, bevor alle Ingress-Ressourcendateien geparst wurden. Der standardmäßige Maximalwert beträgt fünf Minuten. Weitere Informationen einschließlich der zur Änderung der Standardwerte für Zeitlimits auszuführenden Schritte finden Sie unter [Zeitwert der Bereitschaftsprüfung für Neustart für ALB-Pods erhöhen](/docs/containers?topic=containers-ingress-settings#readiness-check).</li>
<li>Behebt GNU-Schwachstellen für `Patches` für [CVE-2019-13636 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13636) und [CVE-2019-13638 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13638).</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>512/334</td>
<td>17. Juli 2019</td>
<td><ul>
<li>Behebt Schwachstellen für `rbash` für [CVE-2016-3189 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924).</li>
<li>Entfernt die folgenden apt-Pakete aus dem Image `nginx-ingress`: `curl`, `bash`, `vim`, `tcpdump` und `ca-certificates`.</li></ul></td>
<td>-</td>
</tr>
<tr>
<td>497/334</td>
<td>14. Juli 2019</td>
<td><ul>
<li>Fügt [`upstream-keepalive-timeout`](/docs/containers?topic=containers-ingress_annotation#upstream-keepalive-timeout) hinzu, um die maximal zulässige Zeitdauer anzugeben, für die eine Keepalive-Verbindung zwischen dem ALB-Proxy-Server und dem Upstream-Server für Ihre Back-End-App geöffnet bleibt.</li>
<li>Fügt Unterstützung für die Anweisung [`reuse-port`](/docs/containers?topic=containers-ingress-settings#reuse-port) hinzu, um die Anzahl der ALB-Socket-Listener von einem pro Cluster auf einen pro Workerknoten zu erhöhen.</li>
<li>Entfernt die redundante Aktualisierung der Lastausgleichsfunktion, die eine ALB zur Verfügung stellt, wenn eine Port-Nummer geändert wird.</li>
<li>Behebt Schwachstellen für `bzip2` für [CVE-2016-3189 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-3189) und [CVE-2019-12900 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12900).</li>
<li>Behebt Expat-Schwachstellen für [CVE-2018-20843 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20843).</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>477/331</td>
<td>24. Juni 2019</td>
<td>Behebt SQLite-Schwachstellen für [CVE-2016-6153 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-6153), [CVE-2017-10989 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-10989), [CVE-2017-13685 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-13685), [CVE-2017-2518 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-2518), [CVE-2017-2519 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-2519), [CVE-2017-2520 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-2520), [CVE-2018-20346 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20346), [CVE-2018-20505 ![Symbol für externen Link>](../icons/launch-glyph.svg "Symbol für externen Link")]](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20506), [CVE-2019-8457 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457), [CVE-2019-9936 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9936) und [CVE-2019-9937 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9937).
</td>
<td>-</td>
</tr>
<tr>
<td>473/331</td>
<td>18. Juni 2019</td>
<td><ul>
<li>Behebt Vim-Schwachstellen für [CVE-2019-5953 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5953) und [CVE-2019-12735 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12735).</li>
<li>Aktualisiert die NGINX-Version von ALBs auf 1.15.12.</li></ul>
</td>
<td>-</td>
</tr>
<tr>
<td>470/330</td>
<td>7. Juni 2019</td>
<td>Behebt Berkeley DB-Schwachstellen für [CVE-2019-8457 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457).
</td>
<td>-</td>
</tr>
<tr>
<td>470/329</td>
<td>6. Juni 2019</td>
<td>Behebt Berkeley DB-Schwachstellen für [CVE-2019-8457 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457).
</td>
<td>-</td>
</tr>
<tr>
<td>467/329</td>
<td>3. Juni 2019</td>
<td>Behebt GnuTLS-Schwachstellen für [CVE-2019-3829 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-3893 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3893), [CVE-2018-10844 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10845 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844) und [CVE-2018-10846 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846).
</td>
<td>-</td>
</tr>
<tr>
<td>462/329</td>
<td>28. Mai 2019</td>
<td>Behebt cURL-Schwachstellen für [CVE-2019-5435 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435) und [CVE-2019-5436 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
<td>-</td>
</tr>
<tr>
<td>457/329</td>
<td>23. Mai 2019</td>
<td>Behebt Go-Schwachstellen für [CVE-2019-11841 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11841).</td>
<td>-</td>
</tr>
<tr>
<td>423/329</td>
<td>13. Mai 2019</td>
<td>Verbessert die Leistung für die Integration mit {{site.data.keyword.appid_full}}.</td>
<td>-</td>
</tr>
<tr>
<td>411/315</td>
<td>15. April 2019</td>
<td>Aktualisiert den Wert für den Ablauf des {{site.data.keyword.appid_full_notm}}-Cookies entsprechend dem Wert für den Ablauf des Zugriffstokens.</td>
<td>-</td>
</tr>
<tr>
<td>411/306</td>
<td>22. März 2019</td>
<td>Aktualisiert Go auf Version 1.12.1.</td>
<td>-</td>
</tr>
<tr>
<td>410/305</td>
<td>18. März 2019</td>
<td><ul>
<li>Behebt Schwachstellen für Image-Scans.</li>
<li>Verbessert die Protokollierung für die Integration mit {{site.data.keyword.appid_full_notm}}.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408/304</td>
<td>5. März 2019</td>
<td>-</td>
<td>Behebt Fehler in der Autorisierungsintegration in Bezug auf Abmeldefunktionalität, Tokenablauf und `OAuth`-Autorisierungscallback. Diese Korrekturen werden nur implementiert, wenn Sie die {{site.data.keyword.appid_full_notm}}-Autorisierung durch die Annotation [`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth) aktiviert haben. Zur Implementierung dieser Korrekturen werden zusätzliche Header hinzugefügt, die die Gesamtgröße der Header erhöhen. Abhängig von der Größe der eigenen Header und der Gesamtgröße von Antworten müssen Sie möglicherweise von Ihnen verwendete [Annotationen für Proxypuffer](/docs/containers?topic=containers-ingress_annotation#proxy-buffer) anpassen.</td>
</tr>
<tr>
<td>406/301</td>
<td>19. Februar 2019</td>
<td><ul>
<li>Aktualisiert Go auf Version 1.11.5.</li>
<li>Behebt Schwachstellen für Image-Scans.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>404/300</td>
<td>31. Januar 2019</td>
<td>Aktualisiert Go auf Version 1.11.4.</td>
<td>-</td>
</tr>
<tr>
<td>403/295</td>
<td>23. Januar 2019</td>
<td><ul>
<li>Aktualisiert die NGINX-Version von ALBs auf 1.15.2.</li>
<li>Von IBM bereitgestellte TLS-Zertifikate werden jetzt automatisch 37 Tage, und nicht 7 Tage, vor Ablauf verlängert.</li>
<li>Fügt {{site.data.keyword.appid_full_notm}}-Abmeldefunktionalität hinzu: Wenn das Präfix `/logout` in einem {{site.data.keyword.appid_full_notm}}-Pfad vorhanden ist, werden Cookies entfernt und der Benutzer wird an die Anmeldeseite zurückverwiesen.</li>
<li>Fügt einen Header zu {{site.data.keyword.appid_full_notm}}-Anforderungen zu internen Verfolgungszwecken hinzu.</li>
<li>Aktualisiert die {{site.data.keyword.appid_short_notm}}-Anweisung 'location', sodass die Annotation `app-id` zusammen mit den Annotationen `proxy-buffers`, `proxy-buffer-size` und `proxy-busy-buffer-size` verwendet werden kann.</li>
<li>Behebt einen Programmfehler, sodass Informationsprotokolle nicht mit der Bezeichnung für Fehler ('error') versehen werden.</li>
</ul></td>
<td>Inaktiviert TLS 1.0 und 1.1 standardmäßig. Wenn die Clients, die eine Verbindung zu Ihren Apps herstellen, TLS 1.2 unterstützen, ist keine Aktion erforderlich. Wenn Sie noch ältere Clients haben, die eine Unterstützung von TLS 1.0 oder 1.1 erfordern, müssen Sie die erforderlichen TLS-Versionen manuell aktivieren, indem Sie [diese Schritte ausführen](/docs/containers?topic=containers-ingress-settings#ssl_protocols_ciphers). Weitere Informationen zum Anzeigen der TLS-Versionen, die Ihre Clients für den Zugriff auf Ihre Apps verwenden, finden Sie in diesem [{{site.data.keyword.cloud_notm}}-Blogeintrag](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).</td>
</tr>
<tr>
<td>393/291</td>
<td>9. Januar 2019</td>
<td>Fügt Unterstützung für Integration mit mehreren {{site.data.keyword.appid_full_notm}}-Instanzen hinzu.</td>
<td>-</td>
</tr>
<tr>
<td>393/282</td>
<td>29. November 2018</td>
<td>Verbessert die Leistung für die Integration mit {{site.data.keyword.appid_full_notm}}.</td>
<td>-</td>
</tr>
<tr>
<td>384/246</td>
<td>14. November 2018</td>
<td>Verbessert die Protokollierungs- und Abmeldefeatures für die Integration mit {{site.data.keyword.appid_full_notm}}.</td>
<td>Ersetzt das selbst signierte Zertifikat für `*.containers.mybluemix.net` durch das signierte Zertifikat von LetsEncrypt, das automatisch für den Cluster generiert und von diesem verwendet wird. Das selbst signierte Zertifikat `*.containers.mybluemix.net` wird entfernt.</td>
</tr>
<tr>
<td>350/192</td>
<td>5. November 2018</td>
<td>Fügt Unterstützung für die Aktivierung und Inaktivierung der automatischen Aktualisierungen der Ingress-ALB-Komponente hinzu.</td>
<td>-</td>
</tr>
</tbody>
</table>

## Fluentd für Protokollierung - Änderungsprotokoll
{: #fluentd_changelog}

Zeigen Sie Änderungen der Buildversion für die Fluentd-Komponente für die Protokollierung in Ihren {{site.data.keyword.containerlong_notm}}-Clustern an.
{:shortdesc}

Standardmäßig sind automatische Aktualisierungen für die Komponente aktiviert, aber Sie können die automatischen Aktualisierungen inaktivieren und die Komponente manuell aktualisieren. Weitere Informationen finden Sie unter [Automatische Aktualisierungen für Fluentd verwalten](/docs/containers?topic=containers-update#logging-up).

In der folgenden Tabelle finden Sie eine Zusammenfassung der Änderungen für jeden Build der Fluentd-Komponente.

<table summary="Übersicht über die Buildänderungen für die Fluentd-Komponente">
<caption>Änderungsprotokoll für die Fluentd-Komponente</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
<thead>
<tr>
<th>Fluentd-Build</th>
<th>Freigabedatum</th>
<th>Unterbrechungsfreie Änderungen</th>
<th>Änderungen mit Unterbrechung</th>
</tr>
</thead>
<tr>
<td>96f399cdea1c86c63a4ca4e043180f81f3559676</td>
<td>22. Juli 2019</td>
<td>Aktualisiert Alpine-Pakete für [CVE-2019-8905 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8905), [CVE-2019-8906 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8906) und  [CVE-2019-8907 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8907).</td>
<td>-</td>
</tr>
<tr>
<td>e7c10d74350dc64d4d92ba7f72bb4ff9219315d2</td>
<td>30. Mai 2019</td>
<td>Aktualisiert die Fluent-Konfigurationszuordnung, um Pod-Protokolle von IBM Namensbereichen immer zu ignorieren, selbst wenn der Kubernetes-Master nicht verfügbar ist.</td>
<td>-</td>
</tr>
<tr>
<td>c16fe1602ab65db4af0a6ac008f99ca2a526e6f6</td>
<td>21. Mai 2019</td>
<td>Korrigiert einen Programmfehler, bei dem Workerknotenmetriken nicht angezeigt wurden.</td>
<td>-</td>
</tr>
<tr>
<td>60fc11f7bd39d9c6cfed923c598bf6457b3f2037</td>
<td>10. Mai 2019</td>
<td>Aktualisiert Ruby-Pakete für [CVE-2019-8320 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320), [CVE-2019-8321 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321), [CVE-2019-8322 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322), [CVE-2019-8323 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323), [CVE-2019-8324 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324) und [CVE-2019-8325 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325).</td>
<td>-</td>
</tr>
<tr>
<td>91a737f68f7d9e81b5d2223c910aaa7d7f91b76d</td>
<td>8. Mai 2019</td>
<td>Aktualisiert Ruby-Pakete für [CVE-2019-8320 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320), [CVE-2019-8321 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321), [CVE-2019-8322 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322), [CVE-2019-8323 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323), [CVE-2019-8324 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324) und [CVE-2019-8325 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325).</td>
<td>-</td>
</tr>
<tr>
<td>d9af69e286986a05ed4a50469585b1cf978ddb1d</td>
<td>11. April 2019</td>
<td>Aktualisiert das cAdvisor-Plug-in für die Verwendung von TLS 1.2.</td>
<td>-</td>
</tr>
<tr>
<td>3100ddb62580a9f46ffdff7bab2ebec40b164de6</td>
<td>1. April 2019</td>
<td>Aktualisiert das Fluentd-Servicekonto.</td>
<td>-</td>
</tr>
<tr>
<td>c85567b75bd7ad1c9428794cd63a8e239c3fd8f5</td>
<td>18. März 2019</td>
<td>Entfernt die Abhängigkeit von cURL für [CVE-2019-8323 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323).</td>
<td>-</td>
</tr>
<tr>
<td>320ffdf87de068ee2f7f34c0e7a47a111e8d457b</td>
<td>18. Februar 2019</td>
<td><ul>
<li>Aktualisiert Fluend auf Version 1.3.</li>
<li>Entfernt Git aus dem Fluentd-Image für[CVE-2018-19486 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19486).</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>972865196aefd3324105087878de12c518ed579f</td>
<td>1. Januar 2019</td>
<td><ul>
<li>Aktiviert UTF-8-Codierung für das Fluentd-Plug-in `in_tail`.</li>
<li>Kleinere Fehlerkorrekturen.</li>
</ul></td>
<td>-</td>
</tr>
</tbody>
</table>
