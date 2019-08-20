---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb, health check, dns, host name

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


# NLB-Hostnamen registrieren
{: #loadbalancer_hostname}

Nachdem Sie Netzlastausgleichsfunktionen (NLBs) konfiguriert haben, können Sie DNS-Einträge für die NLB-IPs erstellen, indem Sie Hostnamen erstellen. Sie können auch TCP/HTTP(S)-Monitore einrichten, die den Status der NLB-IP-Adressen hinter den einzelnen Hostnamen überprüfen.
{: shortdesc}

<dl>
<dt>Hostname</dt>
<dd>Wenn Sie eine öffentliche NLB in einem Einzel- oder Mehrzonencluster erstellen, machen Sie Ihre App dem Internet zugänglich, indem Sie einen Hostnamen für die NLB-IP-Adresse erstellen. Zusätzlich übernimmt {{site.data.keyword.cloud_notm}} für Sie die Generierung und Pflege des Platzhalter-SSL-Zertifikats für den Hostnamen.
<p>In Mehrzonenclustern können Sie einen Hostnamen erstellen und die NLB-IP-Adresse in jeder Zone zum DNS-Eintrag dieses Hostnamens hinzufügen. Wenn Sie beispielsweise NLBs für Ihre App in drei Zonen in der Region 'Vereinigte Staaten (Süden)' bereitgestellt haben, können Sie den Hostnamen `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` für die drei NLB-IP-Adressen erstellen. Wenn ein Benutzer auf den Hostnamen Ihrer App zugreift, greift der Client zufällig auf eine dieser IPs zu und die Anforderung wird an diese NLB gesendet.</p>
Beachten Sie, dass Sie derzeit keine Hostnamen für private NLBs erstellen können.</dd>
<dt>Statusprüfmonitor</dt>
<dd>Aktivieren Sie Statusprüfungen für die NLB-IP-Adressen hinter einem einzelnen Hostnamen, um festzustellen, ob sie verfügbar sind. Wenn Sie einen Monitor für Ihren Hostnamen aktivieren, wird damit die NLB-IP überwacht und die Ergebnisse der DNS-Suche werden auf Grundlage dieser Statusprüfungen aktualisiert. Wenn Ihre NLBs beispielsweise die IP-Adressen `1.1.1.1`, `2.2.2.2` und `3.3.3.3` haben, gibt eine normale Operation der DNS-Suche nach Ihrem Hostnamen alle drei IPs zurück, von denen der Client zufällig auf eine zugreift. Wenn die NLB mit der IP-Adresse `3.3.3.3` aus irgendeinem Grund nicht verfügbar ist, z. B. wegen eines Zonenfehlers, dann schlägt die Statusprüfung für diese IP fehl. Der Monitor entfernt die fehlgeschlagene IP aus dem Hostnamen und die DNS-Suche gibt nur die einwandfreien IPs `1.1.1.1` und `2.2.2.2` zurück.</dd>
</dl>

Sie können alle Hostnamen anzeigen, die für NLB-IPs in Ihrem Cluster registriert sind, indem Sie den folgenden Befehl ausführen.
```
ibmcloud ks nlb-dnss --cluster <clustername_oder_-id>
```
{: pre}

</br>

## NLB-IPs mit einem DNS-Hostnamen registrieren
{: #loadbalancer_hostname_dns}

Machen Sie Ihre App dem öffentlichen Internet verfügbar, indem Sie einen Hostnamen für die IP-Adresse der Netzlastausgleichsfunktion (NLB) erstellen.
{: shortdesc}

Vorbereitende Schritte:
* Überprüfen Sie die folgenden Aspekte und Einschränkungen.
  * Sie können Hostnamen für öffentliche NLBs der Version 1.0 und 2.0 erstellen.
  * Sie können derzeit keine Hostnamen für private NLBs erstellen.
  * Sie können bis zu 128 Host-Namen registrieren. Diese Begrenzung kann auf Anforderung aufgehoben werden, indem ein [Supportfall](/docs/get-support?topic=get-support-getting-customer-support) geöffnet wird.
* [Erstellen Sie eine NLB für Ihre App in einem Einzelzonencluster](/docs/containers?topic=containers-loadbalancer#lb_config) oder [erstellen Sie NLBs in jeder Zone eines Mehrzonenclusters](/docs/containers?topic=containers-loadbalancer#multi_zone_config).

Gehen Sie wie folgt vor, um einen Hostnamen für eine oder mehrere NLB-IP-Adressen zu erstellen:

1. Rufen Sie die Adresse **EXTERNAL-IP** für Ihre NLB ab. Wenn Sie in jeder Zone eines Mehrzonenclusters eine NLB haben, die eine App zugänglich machen, rufen Sie die IPs für jede NLB ab.
  ```
  kubectl get svc
  ```
  {: pre}

  In der folgenden Beispielausgabe sind die externen IPs (**EXTERNAL-IP**) der NLB `168.2.4.5` und `88.2.4.5`.
  ```
  NAME             TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)                AGE
  lb-myapp-dal10   LoadBalancer   172.21.xxx.xxx   168.2.4.5         1883:30303/TCP         6d
  lb-myapp-dal12   LoadBalancer   172.21.xxx.xxx   88.2.4.5          1883:31303/TCP         6d
  ```
  {: screen}

2. Registrieren Sie die IP, indem Sie einen DNS-Hostnamen erstellen. Beachten Sie, dass Sie zunächst den Hostnamen mit nur einer IP-Adresse erstellen können.
  ```
  ibmcloud ks nlb-dns-create --cluster <clustername_oder_-id> --ip <NLB_IP>
  ```
  {: pre}

3. Stellen Sie sicher, dass der Hostname erstellt wurde.
  ```
  ibmcloud ks nlb-dnss --cluster <clustername_oder_-id>
  ```
  {: pre}

  Beispielausgabe:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.2.4.5"]      None             created                   <certificate>
  ```
  {: screen}

4. Wenn in einem Mehrzonencluster in jeder Zone eine NLB vorhanden sind, die eine App zugänglich macht, fügen Sie die IPs der anderen NLBs zum Hostnamen hinzu. Beachten Sie, dass Sie den folgenden Befehl für jede IP-Adresse ausführen müssen, die hinzugefügt werden soll.
  ```
  ibmcloud ks nlb-dns-add --cluster <clustername_oder_-id> --ip <IP-adresse> --nlb-host <hostname>
  ```
  {: pre}

5. Stellen Sie sicher, dass die IPs mit Ihrem Hostnamen registriert sind, indem Sie eine Suche nach `host` oder `ns` durchführen.
  Beispielbefehl:
  ```
  host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
  ```
  {: pre}

  Beispielausgabe:
  ```
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 88.2.4.5  
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 168.2.4.5
  ```
  {: screen}

6. Geben Sie in einem Web-Browser die ULR ein, um über den von Ihnen erstellten Hostnamen auf Ihre App zuzugreifen.

Als Nächstes können Sie [Statusprüfungen für einen Hostnamen durch Erstellen eines Statusmonitors aktivieren](#loadbalancer_hostname_monitor).

</br>

## Informationen zum Hostnamensformat
{: #loadbalancer_hostname_format}

Hostnamen für NLBs folgen dem folgenden Format: `<cluster_name>-<globally_unique_account_HASH>-0001.<region>.containers.appdomain.cloud`.
{: shortdesc}

Zum Beispiel kann ein Hostname, den Sie für eine NLB erstellen, etwa folgendermaßen aussehen: `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud`. In der folgenden Tabelle sind die einzelnen Komponenten des Hostnamens beschrieben.

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Informationen zum Format des LB-Hostnamens</th>
</thead>
<tbody>
<tr>
<td><code>&lt;clustername&gt;</code></td>
<td>Der Name Ihres Clusters.
<ul><li>Wenn der Clustername maximal 26 Zeichen enthält, wird der ganze Clustername eingeschlossen und nicht geändert: <code>myclustername</code>.</li>
<li>Enthält der Clustername 26 oder mehr Zeichen und ist er innerhalb dieser Region eindeutig, werden nur die ersten 24 Zeichen des Clusternamens verwendet: <code>myveryverylongclusternam</code>.</li>
<li>Enthält der Clustername 26 oder mehr Zeichen und es existiert innerhalb dieser Region ein weiterer Cluster desselben Namens, werden nur die ersten 17 Zeichen des Clusternamens verwendet und ein Strich mit sechs zufällig ausgewählten Zeichen wird hinzugefügt: <code>myveryverylongclu-ABC123</code>.</li></ul>
</td>
</tr>
<tr>
<td><code>&lt;globally_unique_account_HASH&gt;</code></td>
<td>Ein global eindeutiger Hash wird für Ihr {{site.data.keyword.cloud_notm}}-Konto erstellt. Alle Hostnamen, die Sie für NLBs in Clustern in Ihrem Konto erstellen, verwenden diesen global eindeutigen Hash.</td>
</tr>
<tr>
<td><code>0001</code></td>
<td>
Das erste und zweite Zeichen, <code>00</code>, geben den Namen eines öffentlichen Hosts an. Das dritte und das vierte Zeichen, z. B. <code>01</code> oder eine andere Zahl, dienen als Zähler für jeden Hostnamen, den Sie erstellen.</td>
</tr>
<tr>
<td><code>&lt;region&gt;</code></td>
<td>Die Region, in der der Cluster erstellt wird.</td>
</tr>
<tr>
<td><code>containers.appdomain.cloud</code></td>
<td>Die Unterdomäne für {{site.data.keyword.containerlong_notm}}-Hostnamen.</td>
</tr>
</tbody>
</table>

</br>

## Statusprüfungen für einen Hostnamen durch Erstellen eines Statusprüfmonitors aktivieren
{: #loadbalancer_hostname_monitor}

Aktivieren Sie Statusprüfungen für die NLB-IP-Adressen hinter einem einzelnen Hostnamen, um festzustellen, ob sie verfügbar sind.
{: shortdesc}

Bevor Sie beginnen, [registrieren Sie NLB-IPs mit einem DNS-Hostnamen](#loadbalancer_hostname_dns).

1. Rufen Sie den Namen Ihres Hostnamens ab. Beachten Sie in der Ausgabe, dass der Host den Monitor-**Status** `Unkonfiguriert` aufweist.
  ```
  ibmcloud ks nlb-dns-monitor-ls --cluster <clustername_oder_-id>
  ```
  {: pre}

  Beispielausgabe:
  ```
  Hostname                                                                                   Status         Type    Port   Path
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud        Unconfigured   N/A     0      N/A
  ```
  {: screen}

2. Erstellen Sie einen Statusprüfmonitor für den Hostnamen. Wenn Sie keinen Konfigurationsparameter einschließen, wird der Standardwert verwendet.
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --enable --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
  ```
  {: pre}

  <table>
  <caption>Erklärung der Bestandteile dieses Befehls</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
  </thead>
  <tbody>
  <tr>
  <td><code>--cluster &lt;clustername_oder_-id&gt;</code></td>
  <td>Erforderlich: Der Name oder die ID des Clusters, in dem der Hostname registriert ist.</td>
  </tr>
  <tr>
  <td><code>--nlb-host &lt;hostname&gt;</code></td>
  <td>Erforderlich: Der Hostname, für den ein Statusprüfmonitor aktiviert werden soll.</td>
  </tr>
  <tr>
  <td><code>--enable</code></td>
  <td>Erforderlich: Aktivieren Sie den Statusprüfmonitor für den Hostnamen.</td>
  </tr>
  <tr>
  <td><code>--description &lt;description&gt;</code></td>
  <td>Eine Beschreibung des Statusprüfmonitors.</td>
  </tr>
  <tr>
  <td><code>--type &lt;type&gt;</code></td>
  <td>Das für die Statusprüfung zu verwendende Protokoll: <code>HTTP</code>, <code>HTTPS</code> oder <code>TCP</code>. Standardwert: <code>HTTP</code></td>
  </tr>
  <tr>
  <td><code>--method &lt;method&gt;</code></td>
  <td>Die für die Statusprüfung zu verwendende Methode. Standardwert für <code>type</code> <code>HTTP</code> und <code>HTTPS</code>: <code>GET</code>. Standardwert für <code>type</code> <code>TCP</code>: <code>connection_established</code></td>
  </tr>
  <tr>
  <td><code>--path &lt;path&gt;</code></td>
  <td>Wenn <code>type</code> auf <code>HTTPS</code> festgelegt ist: der Endpunktpfad, anhand dessen die Statusprüfung erfolgt. Standardwert: <code>/</code></td>
  </tr>
  <tr>
  <td><code>--timeout &lt;timeout&gt;</code></td>
  <td>Das Zeitlimit in Sekunden, bevor die IP-Adresse als fehlerhaft eingestuft wird. Standardwert: <code>5</code></td>
  </tr>
  <tr>
  <td><code>--retries &lt;retries&gt;</code></td>
  <td>Bei einer Zeitlimitüberschreitung ist dies die Anzahl der Neuversuche, bis die IP als fehlerhaft eingestuft wird. Neuversuche werden sofort ausgeführt. Standardwert: <code>2</code></td>
  </tr>
  <tr>
  <td><code>--interval &lt;interval&gt;</code></td>
  <td>Das Intervall (in Sekunden) zwischen den einzelnen Statusprüfungen. Kurze Intervalle können die Failover-Zeit verbessern, erhöhen allerdings die Auslastung der IPs. Standardwert: <code>60</code></td>
  </tr>
  <tr>
  <td><code>--port &lt;port&gt;</code></td>
  <td>Die Portnummer, zu der eine Verbindung zwecks Statusprüfung hergestellt werden soll. Wenn <code>type</code> auf <code>TCP</code> gesetzt ist, ist dieser Parameter erforderlich. Wenn <code>type</code> auf <code>HTTP</code> oder <code>HTTPS</code> gesetzt ist, definieren Sie den Port nur dann, wenn Sie einen anderen Port als Port 80 für HTTP bzw. 443 für HTTPS verwenden. Standardwert für TCP: <code>0</code>. Standardwert für HTTP: <code>80</code>. Standardwert für HTTPS: <code>443</code>.</td>
  </tr>
  <tr>
  <td><code>--expected-body &lt;expected-body&gt;</code></td>
  <td>Wenn <code>type</code> auf <code>HTTP</code> oder <code>HTTPS</code> gesetzt ist: eine Unterzeichenfolge ohne Beachtung der Groß-/Kleinschreibung, nach der die Statusprüfung im Antworthauptteil sucht. Wenn diese Zeichenfolge nicht gefunden wird, wird die IP-Adresse als fehlerhaft eingestuft.</td>
  </tr>
  <tr>
  <td><code>--expected-codes &lt;expected-codes&gt;</code></td>
  <td>Wenn <code>type</code> auf <code>HTTP</code> oder <code>HTTPS</code> gesetzt ist: HTTP-Codes, nach denen die Statusprüfung in der Antwort sucht. Wenn der HTTP-Code nicht gefunden wird, wird die IP-Adresse als fehlerhaft eingestuft. Standardwert: <code>2xx</code></td>
  </tr>
  <tr>
  <td><code>--allows-insecure &lt;true&gt;</code></td>
  <td>Wenn <code>type</code> auf <code>HTTP</code> oder <code>HTTPS</code> gesetzt ist: auf <code>true</code> setzen, damit das Zertifikat nicht validiert wird.</td>
  </tr>
  <tr>
  <td><code>--follows-redirects &lt;true&gt;</code></td>
  <td>Wenn <code>type</code> auf <code>HTTP</code> oder <code>HTTPS</code> gesetzt ist: auf <code>true</code> setzen, um allen Weiterleitungen zu folgen, die von der IP zurückgegeben werden.</td>
  </tr>
  </tbody>
  </table>

  Beispielbefehl:
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --desc "Login page monitor" --type HTTPS --method GET --path / --timeout 5 --retries 2 --interval 60 --expected-body "healthy" --expected-codes 2xx --follows-redirects true
  ```
  {: pre}

3. Überprüfen Sie, ob der Statusprüfmonitor mit den korrekten Einstellungen konfiguriert ist.
  ```
  ibmcloud ks nlb-dns-monitor-get --cluster <clustername_oder_-id> --nlb-host <hostname>
  ```
  {: pre}

  Beispielausgabe:
  ```
  <placeholder - still want to test this one>
  ```
  {: screen}

4. Zeigen Sie den Status der Statusprüfung für die NLB-IPs hinter Ihrem Hostnamen an.
  ```
  ibmcloud ks nlb-dns-monitor-status --cluster <clustername_oder_-id> --nlb-host <hostname>
  ```
  {: pre}

  Beispielausgabe:
  ```
  Hostname                                                                                IP          Health Monitor   H.Monitor Status
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     168.2.4.5   Enabled          Healthy
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     88.2.4.5    Enabled          Healthy
  ```
  {: screen}

</br>

### IPs- und Monitore aktualisieren und von Hostnamen entfernen
{: #loadbalancer_hostname_delete}

Sie können NLB-IP-Adressen zu Hostnamen, die Sie generiert haben, hinzufügen und aus diesen entfernen. Sie können bei Bedarf auch Statusprüfmonitore für Hostnamen inaktivieren und aktivieren.
{: shortdesc}

**NLB-IPs**

Wenn Sie später weitere NLBs in anderen Zonen Ihres Clusters hinzufügen, um dieselbe App zugänglich zu machen, können Sie die NLB-IPs dem vorhandenen Hostnamen hinzufügen. Beachten Sie, dass Sie den folgenden Befehl für jede IP-Adresse ausführen müssen, die hinzugefügt werden soll.
```
ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
```
{: pre}

Sie können auch IP-Adressen von NLBs entfernen, die nicht mehr bei einem Hostnamen registriert sein sollen. Beachten Sie, dass Sie den folgenden Befehl für jede IP-Adresse ausführen müssen, die Sie entfernen möchten. Wenn Sie alle IPs aus einem Hostnamen entfernen, ist der Hostname immer noch vorhanden, nur sind ihm keine IPs zugeordnet.
```
ibmcloud ks nlb-dns-rm --cluster <clustername_oder_-id> --ip <ip1,ip2> --nlb-host <hostname>
```
{: pre}

</br>

**Statusprüfmonitore**

Wenn Sie die Konfiguration Ihres Statusprüfmonitors ändern müssen, können Sie einzelne Einstellungen ändern. Schließen Sie Flags nur für die Einstellungen ein, die geändert werden sollen.
```
ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
```
{: pre}

Sie können den Statusprüfmonitor für einen Hostnamen jederzeit inaktivieren, indem Sie den folgenden Befehl ausführen:
```
ibmcloud ks nlb-dns-monitor-disable --cluster <clustername_oder_-id> --nlb-host <hostname>
```
{: pre}

Führen Sie den folgenden Befehl aus, um die Überwachung eines Hostnamens erneut zu aktivieren:
```
ibmcloud ks nlb-dns-monitor-enable --cluster <clustername_oder_-id> --nlb-host <hostname>
```
{: pre}
