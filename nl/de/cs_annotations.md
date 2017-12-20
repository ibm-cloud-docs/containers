---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Ingress-Annotationen
{: #ingress_annotation}

Um Ihrem Ingress-Controller Funktionalität hinzuzufügen, können Sie Annotationen als Metadaten in einer Ingress-Ressource angeben.
{: shortdesc}

Allgemeine Informationen zu Ingress-Services und eine Einführung in deren Verwendung finden Sie in [Öffentlichen Zugriff auf eine App durch Verwenden des Ingress-Controllers konfigurieren](cs_apps.html#cs_apps_public_ingress).


|Unterstützte Annotation|Beschreibung|
|--------------------|-----------|
|[Zusätzlicher Clientanforderungs- oder -antwortheader](#proxy-add-headers)|Einer Clientanforderung Headerinformationen hinzufügen, bevor Sie die Anforderung an Ihre Back-End-App weiterleiten, bzw. einer Clientantwort, bevor Sie die Antwort an den Client senden.|
|[Pufferung von Clientantwortdaten](#proxy-buffering)|Pufferung einer Clientantwort auf dem Ingress-Controller inaktivieren, während die Antwort an den Client gesendet wird.|
|[Entfernen des Clientantwortheaders](#response-remove-headers)|Headerinformationen aus einer Clientantwort entfernen, bevor die Antwort an den Client weitergeleitet wird.|
|[Angepasste Verbindungs- und Lesezeitlimits](#proxy-connect-timeout)|Wartezeit des Ingress-Controllers für das Verbinden mit und Lesen aus der Back-End-App, bis die Back-End-App als nicht verfügbar betrachtet wird, anpassen.|
|[Angepasste HTTP- und HTTPS-Ports](#custom-port)|Standardports für HTTP- und HTTPS-Netzverkehr ändern.|
|[Angepasste maximale Länge des Clientanforderungshauptteils](#client-max-body-size)|Länge des Clientanforderungshauptteils anpassen, die an den Ingress-Controller gesendet werden darf.|
|[Externe Services](#proxy-external-service)|Pfaddefinitionen zu externen Services, wie einem unter {{site.data.keyword.Bluemix_notm}} gehosteten Service, hinzufügen.|
|[Grenzwerte für globale Rate](#global-rate-limit)|Für alle Services die Verarbeitungsrate für Anforderungen und Verbindungen anhand eines definierten Schlüssels begrenzen.|
|[HTTP-Weiterleitungen an HTTPS](#redirect-to-https)|Unsichere HTTP-Anforderungen an Ihre Domäne an HTTPS weiterleiten.|
|[Keepalive-Anforderungen](#keepalive-requests)|Maximale Anzahl von Anforderungen konfigurieren, die über eine Keepalive-Verbindung bedient werden können.|
|[Keepalive-Zeitlimit](#keepalive-timeout)|Zeitspanne konfigurieren, die eine Keepalive-Verbindung auf dem Server geöffnet bleibt.|
|[Gegenseitige Authentifizierung](#mutual-auth)|Gegenseitige Authentifizierung für den Ingress-Controller konfigurieren.|
|[Proxy-Puffer](#proxy-buffers)|Anzahl und Größe der Puffer festlegen, mit denen eine Antwort für eine einzelne Verbindung von einem Proxy-Server gelesen wird.|
|[Größe belegter Puffer des Proxys](#proxy-busy-buffers-size)|Gesamtgröße der Puffer begrenzen, die eine Antwort an den Client senden, während die Antwort noch nicht vollständig gelesen wurde.|
|[Puffergröße des Proxys](#proxy-buffer-size)|Größe des Puffers festlegen, mit dem der erste Teil der Antwort gelesen wird, die vom Proxy-Server empfangen wird.|
|[Pfade neu schreiben](#rewrite-path)|Eingehenden Netzverkehr an einen anderen Pfad weiterleiten, den Ihre Back-End-App überwacht.|
|[Sitzungsaffinität mit Cookies](#sticky-cookie-services)|Eingehenden Netzverkehr mithilfe eines permanenten Cookies immer an denselben Upstream-Server weiterleiten.|
|[Grenzwerte für Servicerate](#service-rate-limit)|Für bestimmte Services die Verarbeitungsrate für Anforderungen und Verbindungen anhand eines definierten Schlüssels begrenzen.|
|[Unterstützung für SSL-Services](#ssl-services)|Unterstützung für SSL-Services für den Lastausgleich zulassen.|
|[TCP-Ports](#tcp-ports)|Zugriff auf eine App über einen vom Standard abweichenden TCP-Port.|
|[Keepalive-Verbindungen für Upstream-Server](#upstream-keepalive)|Maximale Anzahl der inaktiven Keepalive-Verbindungen für einen Upstream-Server konfigurieren.|






## Zusätzlicher Clientanforderungs- oder Clientantwortheader (proxy-add-headers)
{: #proxy-add-headers}

Einer Clientanforderung zusätzliche Headerinformationen hinzufügen, bevor Sie die Anforderung an Ihre Back-End-App senden, bzw. einer Clientantwort, bevor Sie die Antwort an den Client senden.{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Der Ingress-Controller fungiert als Proxy zwischen der Client-App und Ihrer Back-End-App. Clientanforderungen, die an den Ingress-Controller gesendet werden, werden (als Proxy) verarbeitet und in eine neue Anforderung umgesetzt, die anschließend vom Ingress-Controller an Ihre Back-End-App gesendet wird. Beim Senden einer Anforderung als Proxy werden Headerinformationen entfernt, z. B. der Benutzername, der ursprünglich vom Client gesendet wurde. Falls Ihre Back-End-App diese Informationen erfordert, können Sie die Annotation <strong>ingress.bluemix.net/proxy-add-headers</strong> verwenden, um der Clientanforderung Headerinformationen hinzuzufügen, bevor die Anforderung vom Ingress-Controller an Ihre Back-End-App weitergeleitet wird.

</br></br>
Wenn eine Back-End-App eine Antwort an den Client sendet, wird die Antwort vom Ingress-Controller als Proxy gesendet, und die HTTP-Header werden aus der Antwort entfernt. Die Client-Web-App benötigt diese Headerinformationen, um die Antwort erfolgreich verarbeiten zu können. Sie können die Annotation <strong>ingress.bluemix.net/response-add-headers</strong> verwenden, um der Clientanforderung Headerinformationen hinzuzufügen, bevor die Anforderung vom Ingress-Controller an Ihre Back-End-App weitergeleitet wird.</dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;servicename1&gt; {
      &lt;header1> &lt;wert1&gt;;
      &lt;header2> &lt;wert2&gt;;
      }
      serviceName=&lt;servicename2&gt; {
      &lt;header3&gt; &lt;wert3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;servicename1&gt; {
      "&lt;header1&gt;: &lt;wert1&gt;";
      "&lt;header2&gt;: &lt;wert2&gt;";
      }
      serviceName=&lt;servicename1&gt; {
      "&lt;header3&gt;: &lt;wert3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;servicename1&gt;
          servicePort: 8080
      - path: /meine_app
        backend:
          serviceName: &lt;servicename2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;servicename&gt;</em></code>: Der Name des Kubernetes-Service, den Sie für Ihre App erstellt haben.</li>
  <li><code><em>&lt;header&gt;</em></code>: Der Schlüssel der Headerinformationen, die der Clientanforderung oder der Clientantwort hinzugefügt werden sollen.</li>
  <li><code><em>&lt;wert&gt;</em></code>: Der Wert der Headerinformationen, die der Clientanforderung oder der Clientantwort hinzugefügt werden sollen.</li>
  </ul></td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />


 ## Pufferung von Clientantwortdaten (proxy-buffering)
 {: #proxy-buffering}

 Verwenden Sie die 'buffer'-Annotation, um das Speichern von Antwortdaten auf dem Ingress-Controller während des Sendens von Daten an den Client zu inaktivieren.
 {:shortdesc}

 <dl>
 <dt>Beschreibung</dt>
 <dd>Der Ingress-Controller fungiert als Proxy zwischen Ihrer Back-End-App und dem Client-Web-Browser. Wenn eine Antwort von der Back-End-App an den Client gesendet wird, werden die Antwortdaten standardmäßig auf dem Ingress-Controller gepuffert. Der Ingress-Controller verarbeitet die Clientantwort als Proxy und beginnt mit dem Senden der Antwort an den Client (in der Geschwindigkeit des Clients). Nachdem alle Daten aus der Back-End-App vom Ingress-Controller empfangen wurden, wird die Verbindung zur Back-End-App gekappt. Die Verbindung vom Ingress-Controller zum Client bleibt geöffnet, bis der Client alle Daten empfangen hat.

</br></br>
 Falls die Pufferung von Antwortdaten auf dem Ingress-Controller inaktiviert ist, werden Daten sofort vom Ingress-Controller an den Client gesendet. Der Client muss eingehende Daten in der Geschwindigkeit des Ingress-Controllers verarbeiten können. Falls der Client zu langsam ist, gehen unter Umständen Daten verloren.
 </br></br>
 Die Pufferung von Antwortdaten auf dem Ingress-Controller ist standardmäßig aktiviert.</dd>
 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/proxy-buffering: "False"
 spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
 </dd></dl>

<br />


 ## Entfernen des Clientantwortheaders (response-remove-headers)
 {: #response-remove-headers}

Entfernen Sie Headerinformationen, die aus der Back-End-App in die Clientantwort eingeschlossen werden sollen, bevor die Antwort an den Client gesendet wird.
{:shortdesc}

 <dl>
 <dt>Beschreibung</dt>
 <dd>Der Ingress-Controller fungiert als Proxy zwischen Ihrer Back-End-App und dem Client-Web-Browser. Clientantworten von der Back-End-App, die an den Ingress-Controller gesendet werden, werden (als Proxy) verarbeitet und in eine neue Antwort umgesetzt, die anschließend vom Ingress-Controller an Ihren Client-Web-Browser gesendet wird. Auch wenn beim Senden einer Antwort als Proxy die HTTP-Headerinformationen entfernt werden, die ursprünglich von der Back-End-App gesendet wurden, entfernt dieser Prozess möglicherweise nicht alle Back-End-App-spezifischen Header. Entfernen Sie Headerinformationen aus einer Clientantwort, bevor die Antwort vom Ingress-Controller an den Client-Web-Browser weitergeleitet wird.</dd>
 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/response-remove-headers: |
       serviceName=&lt;servicename1&gt; {
       "&lt;header1&gt;";
       "&lt;header2&gt;";
       }
       serviceName=&lt;servicename2&gt; {
       "&lt;header3&gt;";
       }
 spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: &lt;servicename1&gt;
          servicePort: 8080
       - path: /meine_app
        backend:
          serviceName: &lt;servicename2&gt;
          servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>Ersetzen Sie die folgenden Werte:<ul>
   <li><code><em>&lt;servicename&gt;</em></code>: Der Name des Kubernetes-Service, den Sie für Ihre App erstellt haben.</li>
   <li><code><em>&lt;header&gt;</em></code>: Der Schlüssel des Headers, der aus der Clientantwort gesendet werden soll.</li>
   </ul></td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


## Angepasste Verbindungs- und Lesezeitlimits (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Legen Sie ein angepasstes Verbindungs- und Lesezeitlimit für den Ingress-Controller fest. Passen Sie die Wartezeit des Ingress-Controllers für das Verbinden mit und Lesen aus der Back-End-App, bis die Back-End-App als nicht verfügbar betrachtet wird, an.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Wenn eine Clientanforderung an den Ingress-Controller gesendet wird, wird vom Ingress-Controller eine Verbindung mit der Back-End-App geöffnet. Standardmäßig wartet der Ingress-Controller 60 Sekunden auf eine Antwort von einer Back-End-App. Falls die Back-End-App nicht innerhalb von 60 Sekunden antwortet, wird die Verbindungsanforderung abgebrochen und die Back-End-App als nicht verfügbar angenommen.

</br></br>
Nachdem der Ingress-Controller mit der Back-End-App verbunden wurde, werden Antwortdaten von der Back-End-App vom Ingress-Controller gelesen. Zwischen zwei Leseoperationen wartet der Ingress-Controller maximal 60 Sekunden auf Daten aus der Back-End-App. Falls die Back-End-App innerhalb von 60 Sekunden keine Daten sendet, wird die Verbindung zur Back-End-App gekappt und die App wird als nicht verfügbar angenommen.
</br></br>
Ein Verbindungszeitlimit und Lesezeitlimit von 60 Sekunden ist die Standardeinstellung auf einem Proxy und sollte in der Regel nicht geändert werden.
</br></br>
Falls die Verfügbarkeit Ihrer App nicht durchgehend gewährleistet ist oder Ihre App aufgrund hoher Workloads langsam antwortet, können Sie die Vebindungs- und Lesezeitlimits nach oben korrigieren. Denken Sie daran, dass sich das Erhöhen des Zeitlimits negativ auf die Leistung des Ingress-Controllers auswirken kann, da die Verbindung mit der Back-End-App geöffnet bleiben muss, bis das Zeitlimit erreicht wurde.
</br></br>
Sie können andererseits das Zeitlimit nach unten korrigieren, um die Leistung des Ingress-Controllers zu verbessern. Stellen Sie sicher, dass Ihre Back-End-App Anforderungen auch bei höheren Workloads innerhalb des angegebenen Zeitlimits verarbeiten kann.</dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/proxy-connect-timeout: "&lt;verbindungszeitlimit&gt;s"
   ingress.bluemix.net/proxy-read-timeout: "&lt;lesezeitlimit&gt;s"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>Ersetzen Sie die folgenden Werte:<ul><li><code><em>&lt;verbindungszeitlimit&gt;</em></code>: Geben Sie die Anzahl von Sekunden ein, die auf eine Verbindung mit der Back-End-App gewartet werden soll, z. B. <strong>65s</strong>.

 </br></br>
 <strong>Hinweis:</strong> Ein Verbindungszeitlimit kann nicht größer als 75 Sekunden sein.</li><li><code><em>&lt;lesezeitlimit&gt;</em></code>: Geben Sie die Anzahl von Sekunden ein, die auf das Lesen der Back-End-App gewartet werden soll, z. B. <strong>65s</strong>.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


## Angepasste HTTP- und HTTPS-Ports (custom-port)
{: #custom-port}

Ändern Sie die Standardports für den HTTP- (Port 80) und den HTTPS-Netzverkehr (Port 443).
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Standardmäßig ist der Ingress-Controller so konfiguriert, dass er für eingehenden HTTP-Netzverkehr am Port mit der Nummer 80 und für eingehenden HTTPS-Netzverkehr am Port mit der Nummer 443 empfangsbereit ist. Sie können die Standardports ändern, um die Sicherheit Ihrer Ingress-Controllerdomäne zu verbessern oder um ausschließlich einen HTTPS-Port zu aktivieren.
</dd>


<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/custom-port: "protocol=&lt;protokoll1&gt; port=&lt;port1&gt;;protocol=&lt;protokoll2&gt;port=&lt;port2&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>Ersetzen Sie die folgenden Werte:<ul>
 <li><code><em>&lt;protokoll&gt;</em></code>: Geben Sie <strong>http</strong> oder <strong>https</strong> ein, um den Standardport für eingehenden HTTP- oder HTTPS-Netzverkehr zu ändern.</li>
 <li><code><em>&lt;port&gt;</em></code>: Geben Sie die Portnummer ein, die Sie für eingehenden HTTP- oder HTTPS-Netzverkehr verwenden wollen.</li>
 </ul>
 <p><strong>Hinweis:</strong> Wenn für HTTP oder HTTPS ein angepasster Port angegeben wird, dann sind die Standardports für HTTP und auch für HTTPS nicht mehr gültig. Um beispielsweise den Standardport für HTTPS in 8443 zu ändern, für HTTP jedoch weiterhin den Standardport zu verwenden, müssen Sie für beide Protokolle angepasste Ports festlegen: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p>
 </td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Syntax</dt>
 <dd><ol><li>Überprüfen Sie offene Ports für Ihren Ingress-Controller. **Hinweis: Die IP-Adressen müssen generische Doc-IP-Adressen sein. Außerdem sollten sie mit der kubectl-CLI verknüpft sein, die als Ziel eingerichtet ist.**
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
Die Ausgabe in der Befehlszeilenschnittstelle (CLI) ähnelt der folgenden:
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>Öffnen Sie die Konfigurationsübersicht des Ingress-Controllers.
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>Fügen Sie die nicht dem Standard entsprechenden HTTP- und HTTPS-Ports zur Konfigurationsübersicht hinzu. Ersetzen Sie &lt;port&gt; durch den HTTP- oder HTTPS-Port, der geöffnet werden soll.
<pre class="codeblock">
<code>apiVersion: v1
kind: ConfigMap
data:
 public-ports: &lt;port1&gt;;&lt;port2&gt;
metadata:
 creationTimestamp: 2017-08-22T19:06:51Z
 name: ibm-cloud-provider-ingress-cm
 namespace: kube-system
 resourceVersion: "1320"
 selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
 uid: &lt;uid&gt;</code></pre></li>
 <li>Überprüfen Sie, ob der Ingress-Controller mit den nicht dem Standard entsprechenden Ports neu konfiguriert wurde.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
Die Ausgabe in der Befehlszeilenschnittstelle (CLI) ähnelt der folgenden:
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>Konfigurieren Sie Ingress zur Verwendung der nicht dem Standard entsprechenden Ports bei der Weiterleitung von eingehendem Netzverkehr an Ihre Services. Verwenden Sie die YAML-Beispieldatei in dieser Referenz. </li>
<li>Aktualisieren Sie Ihre Ingress-Controllerkonfiguration.
<pre class="pre">
<code>kubectl apply -f &lt;yaml-datei&gt;</code></pre>
</li>
<li>Öffnen Sie Ihren bevorzugten Web-Browser, um auf Ihre App zuzugreifen. Beispiel: <code>https://&lt;ibm-domäne&gt;:&lt;port&gt;/&lt;servicepfad&gt;/</code></li></ol></dd></dl>

<br />


## Angepasste maximale Länge des Clientanforderungshauptteils (client-max-body-size)
{: #client-max-body-size}

Passen Sie die maximale Größe des Hauptteils an, den der Client als Teil einer Anforderung senden kann.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Um die erwartete Leistung beizubehalten, ist die maximale Größe des Clientanforderungshauptteils auf 1 Megabyte festgelegt. Wenn eine Clientanforderung mit einer das Limit überschreitenden Größe des Hauptteils an den Ingress-Controller gesendet wird und der Client das Unterteilen von Daten nicht zulässt, gibt der Ingress-Controller die HTTP-Antwort 413 (Anforderungsentität zu groß) an den Client zurück. Eine Verbindung zwischen dem Client und dem Ingress-Controller ist erst möglich, wenn die der Anforderungshauptteil verkleinert wird. Wenn der Client das Unterteilen in mehrere Blöcke zulässt, werden die Daten in Pakete von 1 Megabyte aufgeteilt und an den Ingress-Controller gesendet.

</br></br>
Wenn Sie Clientanforderungen mit einer Hauptteilgröße über 1 Megabyte erwarten, können Sie die maximale Größe des Hauptteils erhöhen. Beispiel: Sie möchten, dass Ihr Client große Dateien hochladen kann. Das Erhöhen der maximalen Größe des Anforderungshauptteils kann sich negativ auf die Leistung Ihres Ingress-Controllers auswirken, weil die Verbindung mit dem Client geöffnet bleiben muss, bis die Anforderung empfangen wird.
</br></br>
<strong>Hinweis:</strong> Manche Client-Web-Browser können die HTTP-Antwortnachricht 413 nicht ordnungsgemäß anzeigen.</dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/client-max-body-size: "&lt;größe&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>Ersetzen Sie den folgenden Wert:<ul>
 <li><code><em>&lt;größe&gt;</em></code>: Geben Sie die maximale Größe des Clientantworthauptteils ein. Um sie beispielsweise auf 200 Megabyte festzulegen, definieren Sie <strong>200m</strong>.

 </br></br>
 <strong>Hinweis:</strong> Sie können die Größe auf '0' festlegen, um die Prüfung der Größe des Clientanforderungshauptteils zu inaktivieren.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


<hierher zurückkehren>

## Externe Services (proxy-external-service)
{: #proxy-external-service}
Fügen Sie Pfaddefinitionen zu externen Services hinzu, wie unter {{site.data.keyword.Bluemix_notm}} gehosteten Services, hinzu.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Fügen Sie Pfaddefinitionen zu externen Services hinzu. Diese Annotation wird in speziellen Fällen verwendet, da sie nicht für einen Back-End-Service eingesetzt und für einen externen Service verwendet wird. Annotationen, außer 'client-max-body-size', 'proxy-read-timeout, 'proxy-connect-timeout' und 'proxy-buffering', werden nicht für eine externe Serviceroute unterstützt.
</dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: cafe-ingress
  annotations:
    ingress.bluemix.net/proxy-external-service: "path=&lt;pfad&gt; external-svc=https:&lt;externer_service&gt; host=&lt;meine_domäne&gt;"
spec:
  tls:
  - hosts:
    - &lt;meine_domäne&gt;
    secretName: mysecret
  rules:
  - host: &lt;meine_domäne&gt;
    http:
      paths:
      - path: &lt;pfad&gt;
        backend:
          serviceName: myservice
          servicePort: 80
</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>Ersetzen Sie den folgenden Wert:
 <ul>
 <li><code><em>&lt;externer_service&gt;</em></code>: Geben Sie den externen Service ein, der aufgerufen werden soll. Beispiel: https://&lt;mein_service&gt;.&lt;region&gt;.mybluemix.net.</li>
 </ul>
 </tr>
 </tbody></table>

 </dd></dl>


<br />


## Grenzwerte für globale Rate (global-rate-limit)
{: #global-rate-limit}

Begrenzen Sie für alle Services die Verarbeitungsrate für Anforderungen und die Anzahl der Verbindungen anhand eines definierten Schlüssels, die von einer einzelnen IP-Adresse für alle Hosts in einer Ingress-Zuordnung kommen.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>
Zum Festlegen des Grenzwerts werden Zonen anhand von `ngx_http_limit_conn_module` und `ngx_http_limit_req_module` definiert. Diese Zonen werden in den Serverblöcken angewendet, die den einzelnen Hosts in einer Ingress-Zuordnung entsprechen.
</dd>


 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/global-rate-limit: "key=&lt;schlüssel&gt; rate=&lt;rate&gt; conn=&lt;anzahl_der_verbindungen&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;key&gt;</em></code>: Um einen globalen Grenzwert für eingehenden Anforderungen basierend auf dem Standort des Service festzulegen, verwenden Sie `key=location`. Um einen globalen Grenzwert für eingehenden Anforderungen basierend auf dem Header festzulegen, verwenden Sie `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code>: Die Rate.</li>
  <li><code><em>&lt;conn&gt;</em></code>: Die Anzahl der Verbindungen.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

  <br />


 ## HTTP-Weiterleitungen an HTTPS (redirect-to-https)
 {: #redirect-to-https}

 Konvertieren Sie unsichere HTTP-Clientanforderungen in HTTPS.
 {:shortdesc}

 <dl>
 <dt>Beschreibung</dt>
 <dd>Sie konfigurieren Ihren Ingress-Controller für die Sicherung Ihrer Domäne mit dem von IBM bereitgestellten TLS-Zertifikat oder Ihrem angepassten TLS-Zertifikat. Manche Benutzer versuchen unter Umständen, auf Ihre Apps zuzugreifen, indem Sie eine unsichere HTTP-Anforderung an die Domäne Ihres Ingress-Controllers senden, z. B. <code>http://www.myingress.com</code>, anstatt <code>https</code> zu verwenden. Sie können die 'redirect'-Annotation verwenden, um unsichere HTTP-Anforderungen immer in HTTPS zu konvertieren. Wenn Sie diese Annotation nicht verwenden, werden unsichere HTTP-Anforderungen nicht standardmäßig in HTTPS-Anforderungen konvertiert und machen unter Umständen vertrauliche Daten ohne Verschlüsselung öffentlich zugänglich.

</br></br>
 Das Umadressieren von HTTP-Anforderungen in HTTPS ist standardmäßig inaktiviert.</dd>
 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/redirect-to-https: "True"
 spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
 </dd></dl>

<br />




 <br />

 
 ## Keepalive-Anforderungen (keepalive-requests)
 {: #keepalive-requests}

 Konfigurieren Sie die maximale Anzahl von Anforderungen, die über eine Keepalive-Verbindung bedient werden können.
 {:shortdesc}

 <dl>
 <dt>Beschreibung</dt>
 <dd>
 Legt die maximale Anzahl von Anforderungen fest, die über eine Keepalive-Verbindung bedient werden können.
 </dd>


 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/keepalive-requests: "serviceName=&lt;servicename&gt; requests=&lt;maximale_anforderungen&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Kubernetes-Service, den Sie für die App erstellt haben. Dieser Parameter ist optional. Die Konfiguration wird auf alle Services auf dem Ingress-Host angewendet, es sei denn, es wird ein Service angegeben. Wird der Parameter bereitgestellt, werden die Keepalive-Anforderung für den angegebenen Service festgelegt. Wird der Parameter nicht bereitgestellt, werden die Keepalive-Anforderungen auf der Serverebene der Datei <code>nginx.conf</code> für alle Services festgelegt, für die die Keepalive-Anforderungen nicht konfiguriert sind.</li>
  <li><code><em>&lt;requests&gt;</em></code>: Ersetzen Sie <em>&lt;maximale_anforderungen&gt;</em> durch die maximale Anzahl der Anforderungen, die über eine Keepalive-Verbindung bedient werden können.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Keepalive-Zeitlimit (keepalive-timeout)
 {: #keepalive-timeout}

  Konfigurieren Sie die Zeitspanne, die eine Keepalive-Verbindung serverseitig geöffnet bleibt.{:shortdesc}

  <dl>
  <dt>Beschreibung</dt>
  <dd>
  Legt die Zeitspanne fest, die eine Keepalive-Verbindung auf dem Server geöffnet bleibt.
  </dd>


  <dt>YAML-Beispiel einer Ingress-Ressource</dt>
  <dd>

  <pre class="codeblock">
  <code>apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;servicename&gt; timeout=&lt;zeit&gt;s"
  spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>Ersetzen Sie die folgenden Werte:<ul>
   <li><code><em>&lt;serviceName&gt;</em></code>: Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Kubernetes-Service, den Sie für die App erstellt haben. Dieser Parameter ist optional. Wird der Parameter bereitgestellt, wird das Keepalive-Zeitlimit für den angegebenen Service festgelegt. Wird der Parameter nicht bereitgestellt, wird das Keepalive-Zeitlimit auf der Serverebene der Datei <code>nginx.conf</code> für alle Services festgelegt, für die das Keepalive-Zeitlimit nicht konfiguriert ist.</li>
   <li><code><em>&lt;timeout&gt;</em></code>: Ersetzen Sie <em>&lt;zeit&gt;</em> durch die Zeitspanne in Sekunden. Beispiel:<code><em>timeout=20s</em></code>. Der Wert null inaktiviert die Keepalive-Verbindungen für den Client.</li>
   </ul>
   </td>
   </tr>
   </tbody></table>

   </dd>
   </dl>

 <br />


 ## Gegenseitige Authentifizierung (mutual-auth)
 {: #mutual-auth}

 Konfigurieren Sie die gegenseitige Authentifizierung für den Ingress-Controller.
 {:shortdesc}

 <dl>
 <dt>Beschreibung</dt>
 <dd>
 Konfigurieren Sie die gegenseitige Authentifizierung für den Ingress-Controller. Der Client authentifiziert den Server und der Server authentifiziert den Client anhand von Zertifikaten. Die gegenseitige Authentifizierung wird auch als zertifikatbasierte Authentifizierung oder Zweiwegeauthentifizierung bezeichnet.
 </dd>

 <dt>Voraussetzungen</dt>
 <dd>
 <ul>
 <li>[Sie müssen über einen geheimen Schlüssel verfügen, der die erforderliche Zertifizierungsstelle (CA) enthält](cs_apps.html#secrets). Außerdem werden die Dateien <code>client.key</code> und <code>client.crt</code> für die gegenseitige Authentifizierung benötigt.</li>
 <li>Um die gegenseitige Authentifizierung an einem anderen Port als 443 zu ermöglichen, [konfigurieren Sie die Lastausgleichsfunktion zum Öffnen des gültigen Ports](cs_apps.html#opening_ingress_ports).</li>
 </ul>
 </dd>


 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/mutual-auth: "port=&lt;port&gt; secretName=&lt;name_des_geheimen_schlüssels&gt; serviceName=&lt;service1&gt;,&lt;service2&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Der Name mindestens einer Ingress-Ressource. Dieser Parameter ist optional.</li>
  <li><code><em>&lt;secretName&gt;</em></code>: Ersetzen Sie <em>&lt;name_des_geheimen_schlüssels&gt;</em> durch einen Namen für die geheime Ressource.</li>
  <li><code><em>&lt;port&gt;</em></code>: Geben Sie die Portnummer ein.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Proxypuffer (proxy-buffers)
 {: #proxy-buffers}
 
 Konfigurieren Sie Proxypuffer für den Ingress-Controller.
 {:shortdesc}

 <dl>
 <dt>Beschreibung</dt>
 <dd>
 Legen Sie die Anzahl und Größe der Puffer fest, mit denen eine Antwort für eine einzelne Verbindung von einem Proxy-Server gelesen wir. Die Konfiguration wird auf alle Services auf dem Ingress-Host angewendet, es sei denn, es wird ein Service angegeben. Wenn beispielsweise eine Konfiguration wie <code>serviceName=SERVICE number=2 size=1k</code> angegeben wird, wird '1k' auf den Service angewendet. Wenn eine Konfiguration wie <code>number=2 size=1k</code> angegeben wird, wird '1k' auf alle Services auf dem Ingress-Host angewendet.
 </dd>
 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffers: "serviceName=&lt;servicename&gt; number=&lt;anzahl_der_puffer&gt; size=&lt;größe&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:
  <ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen für den Service, um 'proxy-buffers' anzuwenden. </li>
  <li><code><em>&lt;number&gt;</em></code>: Ersetzen Sie <em>&lt;anzahl_der_puffer&gt;</em> durch eine Zahl, wie <em>2</em>.</li>
  <li><code><em>&lt;size&gt;</em></code>: Geben Sie die Größe der einzelnen Puffer in Kilobyte (k oder K) ein, wie <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>
  </dd>
  </dl>

 <br />


 ## Größe belegter Puffer des Proxys (proxy-busy-buffers-size)
 {: #proxy-busy-buffers-size}

 Konfigurieren Sie die Größe belegter Puffer des Proxys für den Ingress-Controller.
 {:shortdesc}

 <dl>
 <dt>Beschreibung</dt>
 <dd>
 Wenn das Puffern von Antworten vom Proxy-Server aktiviert ist, begrenzen Sie die Gesamtgröße der Puffer, die eine Antwort an den Client senden, während die Antwort noch nicht vollständig gelesen wurde. In der Zwischenzeit kann der Rest der Puffer zum Lesen der Antwort und bei Bedarf zum Puffern eines Teils der Antwort in eine temporäre Datei verwendet werden. Die Konfiguration wird auf alle Services auf dem Ingress-Host angewendet, es sei denn, es wird ein Service angegeben. Wenn beispielsweise eine Konfiguration wie <code>serviceName=SERVICE size=1k</code> angegeben wird, wird '1k' auf den Service angewendet. Wenn eine Konfiguration wie <code>size=1k</code> angegeben wird, wird '1k' auf alle Services auf dem Ingress-Host angewendet.
 </dd>


 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-busy-buffers-size: "serviceName=&lt;servicename&gt; size=&lt;größe&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Service, um 'proxy-busy-buffers-size' anzuwenden.</li>
  <li><code><em>&lt;size&gt;</em></code>: Geben Sie die Größe der einzelnen Puffer in Kilobyte (k oder K) ein, wie <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Puffergröße des Proxys (proxy-buffer-size)
 {: #proxy-buffer-size}

 Konfigurieren Sie die Puffergröße des Proxys für den Ingress-Controller.
 {:shortdesc}

 <dl>
 <dt>Beschreibung</dt>
 <dd>
 Legen Sie die Größe des Puffers fest, mit dem der erste Teil der Antwort gelesen wird, die vom Proxy-Server empfangen wird. Dieser Teil der Antwort enthält normalerweise einen kleinen Antwortheader. Die Konfiguration wird auf alle Services auf dem Ingress-Host angewendet, es sei denn, es wird ein Service angegeben. Wenn beispielsweise eine Konfiguration wie <code>serviceName=SERVICE size=1k</code> angegeben wird, wird '1k' auf den Service angewendet. Wenn eine Konfiguration wie <code>size=1k</code> angegeben wird, wird '1k' auf alle Services auf dem Ingress-Host angewendet.
 </dd>


 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;servicename&gt; size=&lt;größe&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080
 </code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Service, um 'proxy-busy-buffers-size' anzuwenden.</li>
  <li><code><em>&lt;size&gt;</em></code>: Geben Sie die Größe der einzelnen Puffer in Kilobyte (k oder K) ein, wie <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />



## Pfade neu schreiben (rewrite-path)
{: #rewrite-path}

Leiten Sie eingehenden Netzverkehr für den Pfad in der Domäne eines Ingress-Controllers an einen anderen Pfad weiter, an dem die Back-End-Anwendung empfangsbereit ist.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Die Domäne des Ingress-Controllers leitet eingehenden Netzverkehr für <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> an Ihre App weiter. Ihre App überwacht <code>/coffee</code> statt <code>/beans</code>. Zum Weiterleiten des eingehenden Netzverkehrs an Ihre App fügen Sie eine Annotation zum erneuten Schreiben (rewrite) zur Konfigurationsdatei der Ingress-Ressource hinzu. Dadurch wird sichergestellt, dass der an <code>/beans</code> eingehende Netzverkehr mithilfe des Pfads <code>/coffee</code> an Ihre App weitergeleitet wird. Wenn Sie mehrere Services einschließen, verwenden Sie nur ein Semikolon (;) zum Trennen der Services.</dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;servicename1&gt; rewrite=&lt;zielpfad1&gt;;serviceName=&lt;servicename2&gt; rewrite=&lt;zielpfad2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: &lt;mein_geheimer_tls-schlüssel&gt;
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domänenpfad1&gt;
        backend:
          serviceName: &lt;servicename1&gt;
          servicePort: &lt;serviceport1&gt;
      - path: /&lt;domänenpfad2&gt;
        backend:
          serviceName: &lt;servicename2&gt;
          servicePort: &lt;serviceport2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Kubernetes-Service, den Sie für Ihre App erstellt haben, und <em>&lt;zielpfad&gt;</em> durch den Pfad, an dem Ihre App empfangsbereit ist. Der eingehende Netzverkehr in der Domäne des Ingress-Controllers wird mithilfe dieses Pfads an den Kubernetes-Service weitergeleitet. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. Definieren Sie in diesem Fall <code>/</code> als <em>neu_geschriebener_pfad</em> für Ihre App.</td>
</tr>
<tr>
<td><code>path</code></td>
<td>Ersetzen Sie <em>&lt;domänenpfad&gt;</em> durch den Pfad, den Sie zur Domäne des Ingress-Controllers hinzufügen möchten. Der für diesen Pfad eingehende Netzverkehr wird an den neu geschriebenen Pfad weitergeleitet, den Sie in der Annotation definiert haben. Im obigen Beispiel muss als Pfad der Domäne <code>/beans</code> festgelegt sein, damit dieser Pfad in den Lastenausgleich des Ingress-Controllers aufgenommen wird.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Kubernetes-Service, den Sie für die App erstellt haben. Der hier verwendete Servicename muss mit dem Namen identisch sein, den Sie in der Annotation definiert haben.</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>Ersetzen Sie <em>&lt;serviceport&gt;</em> durch den Port, an dem der Service empfangsbereit ist.</td>
</tr></tbody></table>

</dd></dl>

<br />


## Grenzwerte für Servicerate (service-rate-limit)
{: #service-rate-limit}

Begrenzen Sie für bestimmte Services die Verarbeitungsrate für Anforderungen und die Anzahl der Verbindungen anhand eines definierten Schlüssels, die von einer einzelnen IP-Adresse für alle Pfade der ausgewählten Backend-Systeme kommen.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>
Zum Festlegen des Grenzwerts werden Zonen angewendet, die anhand von `ngx_http_limit_conn_module` und `ngx_http_limit_req_module` in allen Positionsblöcken definiert sind, die den Services entsprechen, die als Ziel in der Annotation in der Ingress-Zuordnung angegeben sind. </dd>


 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;servicename&gt; key=&lt;schlüssel&gt; rate=&lt;rate&gt; conn=&lt;anzahl_der_verbindungen&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Der Name der Ingress-Ressource.</li>
  <li><code><em>&lt;key&gt;</em></code>: Um einen globalen Grenzwert für eingehenden Anforderungen basierend auf dem Standort des Service festzulegen, verwenden Sie `key=location`. Um einen globalen Grenzwert für eingehenden Anforderungen basierend auf dem Header festzulegen, verwenden Sie `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code>: Die Rate.</li>
  <li><code><em>&lt;conn&gt;</em></code>: Die Anzahl der Verbindungen.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


## Sitzungsaffinität mit Cookies (sticky-cookie-services)
{: #sticky-cookie-services}

Verwenden Sie die permanente Cookie-Annotation, um Ihrem Ingress-Controller Sitzungsaffinität hinzuzufügen und eingehenden Netzverkehr immer an denselben Upstream-Server weiterzuleiten.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Um eine hohe Verfügbarkeit zu erreichen, müssen Sie bei einigen Appkonfigurationen unter Umständen mehrere Upstream-Server bereitstellen, die eingehende Clientanforderungen verarbeiten. Wenn ein Client eine Verbindung mit Ihrer Back-End-App herstellt, kann ein Client für die Dauer einer Sitzung bzw. für die Zeit, die für den Abschluss einer Task erforderlich ist, von demselben Upstream-Server bedient werden. Sie können Ihren Ingress-Controller so konfigurieren, dass Sitzungsaffinität sichergestellt ist, indem Sie eingehenden Netzverkehr immer an denselben Upstream-Server weiterleiten.

</br></br>
Jeder Client, der eine Verbindung mit Ihrer Back-End-App herstellt, wird durch den Ingress-Controller einem der verfügbaren Upstream-Server zugeordnet. Der Ingress-Controller erstellt ein Sitzungscookie, das in der App des Clients gespeichert wird und das in die Headerinformationen jeder Anforderung zwischen dem Ingress-Controller und dem Client eingeschlossen wird. Die Information im Cookie stellen sicher, dass alle Anforderungen während der gesamten Sitzung von demselben Upstream-Server verarbeitet werden.

</br></br>
Wenn Sie mehrere Services einschließen, verwenden Sie ein Semikolon (;) zum Trennen der Services.</dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;servicename1&gt; name=&lt;cookiename1&gt; expires=&lt;ablaufzeit1&gt; path=&lt;cookiepfad1&gt; hash=&lt;hash-algorithmus1&gt;;serviceName=&lt;servicename2&gt; name=&lt;cookiename2&gt; expires=&lt;ablaufzeit2&gt; path=&lt;cookiepfad2&gt; hash=&lt;hash-algorithmus2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;servicename1&gt;
          servicePort: 8080
      - path: /meine_app
        backend:
          serviceName: &lt;servicename2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>Erklärung der Komponenten der YAML-Datei</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;servicename&gt;</em></code>: Der Name des Kubernetes-Service, den Sie für Ihre App erstellt haben.</li>
  <li><code><em>&lt;cookiename&gt;</em></code>: Wählen Sie einen Namen für das permanente Cookie aus, das während einer Sitzung erstellt wird.</li>
  <li><code><em>&lt;ablaufzeit&gt;</em></code>: Die Zeit in Sekunden, Minuten oder Stunden, bevor das permanente Cookie abläuft. Diese Zeit ist unabhängig von der Benutzeraktivität. Nachdem das Cookie abgelaufen ist, wird es durch den Web-Browser des Clients gelöscht und nicht mehr an den Ingress-Controller gesendet. Um beispielsweise eine Ablaufzeit von einer Sekunde, einer Minute oder einer Stunde festzulegen, geben Sie <strong>1s</strong>, <strong>1m</strong> oder <strong>1h</strong> ein.</li>
  <li><code><em>&lt;cookiepfad&gt;</em></code>: Der Pfad, der an die Ingress-Unterdomäne angehängt ist, und der angibt, für welche Domänen und Unterdomänen das Cookie an den Ingress-Controller gesendet wird. Wenn Ihre Ingress-Domäne beispielsweise <code>www.myingress.com</code> ist und Sie das Cookie in jeder Clientanforderung senden möchten, müssen Sie <code>path=/</code> festlegen. Wenn Sie das Cookie nur für <code>www.myingress.com/meine_app</code> und alle zugehörigen Unterdomänen senden möchten, müssen Sie <code>path=/meine_app</code> festlegen.</li>
  <li><code><em>&lt;hash-algorithmus&gt;</em></code>: Der Hashalgorithmus, der die Informationen im Cookie schützt. Nur <code>sha1</code> wird unterstützt. SHA1 erstellt eine Hashsumme auf der Grundlage der Informationen im Cookie und hängt die Hashsumme an das Cookie an. Der Server kann die Informationen im Cookie entschlüsseln und die Datenintegrität bestätigen.
  </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


## Unterstützung für SSL-Services (ssl-services)
{: #ssl-services}

Lassen Sie HTTPS-Anforderungen zu und verschlüsseln Sie Datenverkehr zu Ihren Upstream-Apps.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>
Verschlüsseln Sie den Datenverkehr zu Ihren Upstream-Apps, für die HTTPS erforderlich ist, mit den Ingress-Controllern.

**Optional**: Sie können die [unidirektionale Authentifizierung oder die gegenseitige Authentifizierung](#ssl-services-auth) zu dieser Annotation hinzufügen.
</dd>


<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: &lt;mein_ingress-name&gt;
  annotations:
    ingress.bluemix.net/ssl-services: ssl-service=&lt;service1&gt; [ssl-secret=&lt;geheimer_ssl-schlüssel_von_service1&gt;];ssl-service=&lt;service2&gt; [ssl-secret=&lt;geheimer_ssl-schlüssel_von_service2&gt;]
spec:
  rules:
  - host: &lt;ibm_domäne&gt;
    http:
      paths:
      - path: /&lt;mein_servicepfad1&gt;
        backend:
          serviceName: &lt;mein_service1&gt;
          servicePort: 8443
      - path: /&lt;mein_servicepfad2&gt;
        backend:
          serviceName: &lt;mein_service2&gt;
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;myservice&gt;</em></code>: Geben Sie den Namen des Service ein, der für Ihre App steht. Der Datenverkehr wird vom Ingress-Controller zu dieser App verschlüsselt.</li>
  <li><code><em>&lt;ssl-secret&gt;</em></code>: Geben Sie den geheimen Schlüssel für den Service ein. Dieser Parameter ist optional. Wenn der Parameter bereitgestellt wird, muss der Wert den Schlüssel und das Zertifikat enthalten, den/das die App vom Client erwartet.  </li></ul>
  </td>
  </tr>
  <tr>
  <td><code>rules/host</code></td>
  <td>Ersetzen Sie <em>&lt;ibm_domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen.
  <br><br>
  <strong>Hinweis:</strong> Um Fehler während der Ingress-Erstellung zu vermeiden, verwenden Sie keine Sternchen (*) für Ihren Host oder lassen Sie die Hosteigenschaft leer.</td>
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Ersetzen Sie <em>&lt;mein_servicepfad&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

  </br>
  Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service. Er sendet Netzverkehr an diesen Service und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz
zu erhalten.

  </br></br>
Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.
  </br>
  Beispiel: <ul><li>Geben Sie für <code>http://ingress-hostname/</code> als Pfad <code>/</code> ein.</li><li>Geben Sie für <code>http://ingress-hostname/mein_servicepfad</code> als Pfad <code>/mein_servicepfad</code> ein.</li></ul>
  </br>
  <strong>Tipp:</strong> Um Ingress für die Überwachung eines Pfads zu konfigurieren, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit der <a href="#rewrite-path" target="_blank">Annotation 'rewrite'</a> eine richtige Weiterleitung an Ihre App einrichten.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Ersetzen Sie <em>&lt;mein_service&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre App verwendet haben.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>Der Port, den Ihr Service überwacht. Verwenden Sie denselben Port, die Sie beim Erstellen des Kubernetes-Service für Ihre App definiert haben.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


### Unterstützung für SSL-Services mit Authentifizierung
{: #ssl-services-auth}

Lassen Sie HTTPS-Anforderungen zu und verschlüsseln Sie Datenverkehr zu Ihren Upstream-Apps für zusätzliche Sicherheit mit der unidirektionalen oder gegenseitigen Authentifizierung.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>
Konfigurieren Sie die gegenseitige Authentifizierung für Lastausgleichs-Apps, für die HTTPS erforderlich ist, mit den Ingress-Controllern.

**Hinweis**: Bevor Sie beginnen, [konvertieren Sie das Zertifikat und den Schlüssel in die Base64-Codierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.base64encode.org/).

</dd>


<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: &lt;mein_ingress-name&gt;
  annotations:
    ingress.bluemix.net/ssl-services: |
      ssl-service=&lt;service1&gt; ssl-secret=&lt;geheimer_ssl-schlüssel_für_service1&gt;;
      ssl-service=&lt;service2&gt; ssl-secret=&lt;geheimer_ssl-schlüssel_für_service2&gt;
spec:
  tls:
  - hosts:
    - &lt;ibm_domäne&gt;
    secretName: &lt;name_des_geheimen_schlüssels&gt;
  rules:
  - host: &lt;ibm_domäne&gt;
    http:
      paths:
      - path: /&lt;mein_servicepfad1&gt;
        backend:
          serviceName: &lt;mein_service1&gt;
          servicePort: 8443
      - path: /&lt;mein_servicepfad2&gt;
        backend:
          serviceName: &lt;mein_service2&gt;
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;service&gt;</em></code>: Geben Sie den Namen des Service ein.</li>
  <li><code><em>&lt;geheimer_ssl-schlüssel_für_service&gt;</em></code>: Geben Sie den geheimen Schlüssel für den Service ein.</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>tls/host</code></td>
  <td>Ersetzen Sie <em>&lt;ibm_domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen.
  <br><br>
  <strong>Hinweis:</strong> Um Fehler während der Ingress-Erstellung zu vermeiden, verwenden Sie keine Sternchen (*) für Ihren Host oder lassen Sie die Hosteigenschaft leer.</td>
  </tr>
  <tr>
  <td><code>tls/secretName</code></td>
  <td>Ersetzen Sie <em>&lt;name_des_geheimen_schlüssels&gt;</em> durch den Namen des geheimen Schlüssels, in dem sich das Zertifikat und für die gegenseitige Authentifizierung der Schlüssel befindet.
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Ersetzen Sie <em>&lt;mein_servicepfad&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

  </br>
  Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz
zu erhalten.

  </br></br>
  Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.
  </br>
  Beispiel: <ul><li>Geben Sie für <code>http://ingress-hostname/</code> als Pfad <code>/</code> ein.</li><li>Geben Sie für <code>http://ingress-hostname/mein_servicepfad</code> als Pfad <code>/mein_servicepfad</code> ein.</li></ul>
  </br>
  <strong>Tipp:</strong> Um Ingress für die Überwachung eines Pfads zu konfigurieren, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit <a href="#rewrite-path" target="_blank">Annotation neu schreiben</a> eine richtige Weiterleitung an Ihre App einrichten.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Ersetzen Sie <em>&lt;mein_service&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre App verwendet haben.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>Der Port, den Ihr Service überwacht. Verwenden Sie denselben Port, die Sie beim Erstellen des Kubernetes-Service für Ihre App definiert haben.</td>
  </tr>
  </tbody></table>

  </dd>



<dt>YAML-Beispieldatei eines geheimen Schlüssels für die unidirektionale Authentifizierung</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadata:
  name: &lt;name_des_geheimen_schlüssels&gt;
type: Opaque
data:
  trusted.crt: &lt;zertifikatsname&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Ersetzen Sie <em>&lt;name_des_geheimen_schlüssels&gt;</em> durch einen Namen für die Ressource mit dem geheimen Schlüssel.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Ersetzen Sie den folgenden Wert:<ul>
  <li><code><em>&lt;zertifikatsname&gt;</em></code>: Geben Sie den Namen des vertrauenswürdigen Zertifikats ein.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>

<dt>YAML-Beispieldatei eines geheimen Schlüssels für die gegenseitige Authentifizierung</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadata:
  name: &lt;name_des_geheimen_schlüssels&gt;
type: Opaque
data:
  trusted.crt: &lt;zertifikatsname&gt;
    client.crt : &lt;clientzertifikatsname&gt;
    client.key : &lt;zertifikatsschlüssel&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Ersetzen Sie <em>&lt;name_des_geheimen_schlüssels&gt;</em> durch einen Namen für die Ressource mit dem geheimen Schlüssel.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;zertifikatsname&gt;</em></code>: Geben Sie den Namen des vertrauenswürdigen Zertifikats ein.</li>
  <li><code><em>&lt;clientzertifikatsname&gt;</em></code>: Geben Sie den Namen des Clientzertifikats ein.</li>
  <li><code><em>&lt;zertifikatsschlüssel&gt;</em></code>: Geben Sie den Schlüssel für das Clientzertifikat ein.</li></ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />



## TCP-Ports für Ingress-Controller (tcp-ports)
{: #tcp-ports}

Greifen Sie auf eine App über einen vom Standard abweichenden TC-Port zu.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>
Verwenden Sie diese Annotation für eine App, für die eine Arbeitslast für TCP-Datenströme ausgeführt wird.

<p>**Hinweis**: Der Ingress-Controller arbeitet im Durchgriffsmodus und leitet den Datenverkehr an Backend-Apps weiter. Die SSL-Terminierung wird in diesem Fall nicht unterstützt.</p>
</dd>


 <dt>YAML-Beispiel einer Ingress-Ressource</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/tcp-ports: "serviceName=&lt;servicename&gt; ingressPort=&lt;ingress-port&gt; [servicePort=&lt;service-port&gt;]"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte:<ul>
  <li><code><em>&lt;ingressPort&gt;</em></code>: Der TCP-Port, an dem Sie auf Ihre App zugreifen möchten.</li>
  <li><code><em>&lt;serviceName&gt;</em></code>: Der Name des Kubernetes-Service, auf den über einen vom Standard abweichenden Port zugegriffen wird.</li>
  <li><code><em>&lt;servicePort&gt;</em></code>: Dieser Parameter ist optional. Wenn ein Wert bereitgestellt wird, wird der Port durch diesen Wert ersetzt, bevor der Datenverkehr an die Backend-App gesendet wird. Andernfalls entspricht der Port weiterhin dem Ingress-Port.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


  ## Keepalive-Verbindungen für Upstream-Server (upstream-keepalive)
  {: #upstream-keepalive}

  Konfigurieren Sie die maximale Anzahl der inaktiven Keepalive-Verbindungen für einen Upstream-Server.
  {:shortdesc}

  <dl>
  <dt>Beschreibung</dt>
  <dd>
  Ändern Sie die maximale Anzahl inaktiver Keepalive-Verbindungen zu einem Upstream-Server für einen angegebenen Service. Der Upstream-Server verfügt standardmäßig über 64 inaktive Keepalive-Verbindungen.
  </dd>


   <dt>YAML-Beispiel einer Ingress-Ressource</dt>
   <dd>

   <pre class="codeblock">
   <code>apiVersion: extensions/v1beta1
   kind: Ingress
   metadata:
    name: myingress
    annotations:
      ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;servicename&gt; keepalive=&lt;maximale_verbindungen&gt;"
   spec:
    tls:
    - hosts:
      - mydomain
    secretName: mytlssecret
  rules:
    - host: mydomain
    http:
      paths:
        - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

   <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>annotations</code></td>
    <td>Ersetzen Sie die folgenden Werte:<ul>
    <li><code><em>&lt;serviceName&gt;</em></code>: Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Kubernetes-Service, den Sie für die App erstellt haben. </li>
    <li><code><em>&lt;keepalive&gt;</em></code>: Ersetzen Sie <em>&lt;max_verbindungen&gt;</em> durch die maximale Anzahl der inaktiven Keepalive-Verbindungen zum Upstream-Server. Der Standardwert ist '64'. Mit dem Wert null werden Keepalive-Verbindungen zum Upstream-Server für den angegebenen Service inaktiviert.</li>
    </ul>
    </td>
    </tr>
    </tbody></table>
    </dd>
    </dl>


