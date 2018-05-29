---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Fehlerbehebung für Clusternetze
{: #cs_troubleshoot_network}

Ziehen Sie bei der Verwendung von {{site.data.keyword.containerlong}} die folgenden Verfahren für die Fehlerbehebung für Clusternetze in Betracht.
{: shortdesc}

Wenn Sie ein allgemeineres Problem haben, testen Sie das [Cluster-Debugging](cs_troubleshoot.html).
{: tip}

## Verbindung mit einer App über einen Lastausgleichsservice kann nicht hergestellt werden
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Sie haben Ihre App öffentlich zugänglich gemacht, indem Sie einen Lastausgleichsservice in Ihrem Cluster erstellt haben. Als Sie versuchten, eine Verbindung mit Ihrer App über die öffentliche IP-Adresse der Lastausgleichsfunktion herzustellen, ist die Verbindung fehlgeschlagen oder sie hat das zulässige Zeitlimit überschritten.

{: tsCauses}
Ihr Lastausgleichsservice funktioniert aus einem der folgenden Gründe möglicherweise nicht ordnungsgemäß:

-   Der Cluster ist ein kostenloser Cluster oder Standardcluster mit nur einem Workerknoten.
-   Der Cluster ist noch nicht vollständig bereitgestellt.
-   Das Konfigurationsscript für Ihren Lastausgleichsservice enthält Fehler.

{: tsResolve}
Gehen Sie wie folgt vor, um Fehler in Ihrem Lastausgleichsservice zu beheben:

1.  Prüfen Sie, dass Sie einen Standardcluster einrichten, der vollständig bereitgestellt ist und mindestens zwei Workerknoten umfasst, um Hochverfügbarkeit für Ihren Lastausgleichsservice zu gewährleisten.

  ```
  bx cs workers <clustername_oder_-id>
  ```
  {: pre}

    Stellen Sie in Ihrer CLI-Ausgabe sicher, dass der **Status** Ihrer Workerknoten **Ready** (Bereit) lautet und dass für den **Maschinentyp** etwas anderes als **free** (frei) anzeigt wird.

2.  Prüfen Sie die Richtigkeit der Konfigurationsdatei für Ihren Lastausgleichsservice.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: myservice
    spec:
      type: LoadBalancer
      selector:
        <selektorschlüssel>:<selektorwert>
      ports:
       - protocol: TCP
         port: 8080
    ```
    {: pre}

    1.  Überprüfen Sie, dass Sie **LoadBalancer** als Typ für Ihren Service definiert haben.
    2.  Stellen Sie sicher, dass die Werte für `<selektorschlüssel>` und `<selektorwert>`, die Sie im Abschnitt `spec.selector` des LoadBalancer-Service verwenden, dem Schlüssel/Wert-Paar entspricht, das Sie im Abschnitt `spec.template.metadata.labels` Ihrer YAML-Bereitstellungsdatei angegeben haben. Wenn die Bezeichnungen nicht übereinstimmen, zeigt der Abschnitt zu den Endpunkten (**Endpoints**) in Ihrem LoadBalancer-Service **<none>** an und Ihre App ist über das Internet nicht zugänglich. 
    3.  Prüfen Sie, dass Sie den **Port** verwendet haben, den Ihre App überwacht.

3.  Prüfen Sie Ihren Lastausgleichsservice und suchen Sie im Abschnitt zu den Ereignissen (**Events**) nach potenziellen Fehlern.

    ```
    kubectl describe service <mein_service>
    ```
    {: pre}

    Suchen Sie nach den folgenden Fehlernachrichten:

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Um den Lastausgleichsservice verwenden zu können, müssen Sie über ein Standardcluster mit mindestens zwei Workerknoten verfügen.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Diese Fehlernachricht weist darauf hin, dass keine portierbaren öffentlichen IP-Adressen mehr verfügbar sind, die Ihrem Lastausgleichsservice zugeordnet werden können. Informationen zum Anfordern portierbarer IP-Adressen für Ihren Cluster finden Sie unter <a href="cs_subnets.html#subnets">Clustern Teilnetze hinzufügen</a>. Nachdem portierbare öffentliche IP-Adressen im Cluster verfügbar gemacht wurden, wird der Lastausgleichsservice automatisch erstellt.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>Sie haben eine portierbare öffentliche IP-Adresse für Ihren Lastausgleichsservice mithilfe des Abschnitts **loadBalancerIP** definiert, aber diese portierbare öffentliche IP-Adresse ist in Ihrem portierbaren öffentlichen Teilnetz nicht verfügbar. Ändern Sie das Konfigurationsscript Ihres Lastausgleichsservice und wählen Sie entweder eine der portierbaren öffentlichen IP-Adressen aus, oder entfernen Sie den Abschnitt **loadBalancerIP** aus Ihrem Script, damit eine verfügbare portierbare öffentliche IP-Adresse automatisch zugeordnet werden kann.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Sie verfügen nicht über ausreichend Workerknoten, um einen Lastausgleichsservice bereitzustellen. Ein Grund kann sein, dass Sie einen Standardcluster mit mehr ale einem Workerknoten bereitgestellt haben, aber die Bereitstellung der Workerknoten ist fehlgeschlagen.</li>
    <ol><li>Listen Sie verfügbare Workerknoten auf.</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>Werden mindestens zwei verfügbare Workerknoten gefunden, listen Sie die Details der Workerknoten auf.</br><pre class="codeblock"><code>bx cs worker-get [&lt;clustername_oder_-id&gt;] &lt;worker-id&gt;</code></pre></li>
    <li>Stellen Sie sicher, dass die öffentlichen und privaten VLAN-IDs für die Workerknoten, die von den Befehlen <code>kubectl get nodes</code> und <code>bx cs [&lt;clustername_oder_-id&gt;] worker-get</code> zurückgegeben wurden, übereinstimmen.</li></ol></li></ul>

4.  Wenn Sie eine angepasste Domäne verwenden, um Ihren Lastausgleichsservice zu verbinden, stellen Sie sicher, dass Ihre angepasste Domäne der öffentlichen IP-Adresse Ihres Lastausgleichsservice zugeordnet ist.
    1.  Suchen Sie nach der öffentlichen IP-Adresse Ihres Lastausgleichsservice.

        ```
        kubectl describe service <mein_service> | grep "LoadBalancer Ingress"
        ```
        {: pre}

    2.  Prüfen Sie, dass Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse Ihres Lastausgleichsservice im Zeigerdatensatz (PTR) zugeordnet ist.

<br />




## Verbindung mit einer App über Ingress kann nicht hergestellt werden
{: #cs_ingress_fails}

{: tsSymptoms}
Sie haben Ihre App öffentlich zugänglich gemacht, indem Sie eine Ingress-Ressource für Ihre App in Ihrem Cluster erstellt haben. Als Sie versuchten, eine Verbindung mit Ihrer App über die öffentliche IP-Adresse oder Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen herzustellen, ist die Verbindung fehlgeschlagen oder sie hat das zulässige Zeitlimit überschritten.

{: tsCauses}
Ingress funktioniert aus den folgenden Gründen möglicherweise nicht ordnungsgemäß:
<ul><ul>
<li>Der Cluster ist noch nicht vollständig bereitgestellt.
<li>Der Cluster wurde als kostenloser Cluster oder als Standardcluster mit nur einem Workerknoten eingerichtet.
<li>Das Ingress-Konfigurationsscript enthält Fehler.
</ul></ul>

{: tsResolve}
Gehen Sie wie folgt vor, um Fehler in Ingress zu beheben:

1.  Prüfen Sie, dass Sie einen Standardcluster einrichten, der vollständig ist und mindestens zwei Workerknoten umfasst, um Hochverfügbarkeit für Ihre Ingress-Lastausgleichsfunktion für Anwendungen zu gewährleisten.

  ```
  bx cs workers <clustername_oder_-id>
  ```
  {: pre}

    Stellen Sie in Ihrer CLI-Ausgabe sicher, dass der **Status** Ihrer Workerknoten **Ready** (Bereit) lautet und dass für den **Maschinentyp** etwas anderes als **free** (frei) anzeigt wird.

2.  Rufen Sie die Unterdomäne und die öffentliche IP-Adresse der Ingress-Lastausgleichsfunktion für Anwendungen ab und setzen Sie anschließend ein Pingsignal an beide ab.

    1.  Rufen Sie die Unterdomäne der Lastausgleichsfunktion für Anwendungen ab.

      ```
      bx cs cluster-get <clustername_oder_-id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Setzen Sie ein Pingsignal an die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen ab.

      ```
      ping <unterdomäne_des_ingress-controllers>
      ```
      {: pre}

    3.  Rufen Sie die öffentliche IP-Adresse Ihrer Ingress-Lastausgleichsfunktion für Anwendungen ab.

      ```
      nslookup <unterdomäne_des_ingress-controllers>
      ```
      {: pre}

    4.  Setzen Sie ein Pingsignal an die öffentliche IP-Adresse der Ingress-Lastausgleichsfunktion für Anwendungen ab.

      ```
      ping <ingress-controller-ip>
      ```
      {: pre}

    Falls die CLI eine Zeitlimitüberschreitung für die öffentliche IP-Adresse oder die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen zurückgibt und Sie eine angepasste Firewall eingerichtet haben, die Ihre Workerknoten schützt, müssen Sie unter Umständen zusätzliche Ports und Netzgruppen in Ihrer [Firewall](cs_troubleshoot_clusters.html#cs_firewall) öffnen.

3.  Wenn Sie eine angepasste Domäne verwenden, stellen Sie sicher, dass Ihre angepasste Domäne der öffentlichen IP-Adresse oder Unterdomäne der von IBM bereitgestellten Ingress-Lastausgleichsfunktion für Anwendungen mit Ihrem DNS-Anbieter (Domain Name Service) zugeordnet ist.
    1.  Wenn Sie die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen verwendet haben, prüfen Sie Ihren CNAME-Datensatz (Canonical Name, kanonischer Name).
    2.  Wenn Sie die öffentliche IP-Adresse der Ingress-Lastausgleichsfunktion für Anwendungen verwendet haben, prüfen Sie, dass Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse im Zeigerdatensatz (PTR) zugeordnet ist.
4.  Prüfen Sie Ihre Ingress-Ressourcenkonfigurationsdatei.

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress-unterdomäne>
        secretName: <geheimer_tls-schlüssel_in_ingress>
      rules:
      - host: <ingress-unterdomäne>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  Prüfen Sie, dass die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen und das TLS-Zertifikat korrekt sind. Um die von IBM bereitgestellte Unterdomäne und das TLS-Zertifikat zu finden, führen Sie den folgenden Befehl aus: `bx cs cluster-get <clustername_oder_-id>`.
    2.  Stellen Sie sicher, dass Ihre App denselben Pfad überwacht, der im Abschnitt **path** von Ingress konfiguriert ist. Wenn Ihre App so eingerichtet ist, dass sie den Rootpfad überwacht, schließen Sie **/** als Ihren Pfad ein.
5.  Überprüfen Sie Ihre Ingress-Bereitstellung und suchen Sie nach möglichen Warnungen und Fehlernachrichten.

    ```
    kubectl describe ingress <myingress>
    ```
    {: pre}

    Im Abschnitt **Ereignisse** der Ausgabe sehen Sie möglicherweise Nachrichten zu ungültigen Werten in Ihrer Ingress-Ressource oder in bestimmten Annotationen, die Sie verwendet haben.

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xxx,169.xx.xxx.xxx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.mybluemix.net
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

6.  Überprüfen Sie die Protokolle für Ihre Lastausgleichsfunktion für Anwendungen.
    1.  Rufen Sie die ID der Ingress-Pods ab, die in Ihrem Cluster ausgeführt werden.

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  Rufen Sie die Protokolle für jeden Ingress-Pod ab.

      ```
      kubectl logs <ingress-pod-id> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  Suchen Sie nach Fehlernachrichten in den Protokollen der Lastausgleichsfunktion für Anwendungen.

<br />




## Probleme mit geheimen Schlüsseln der Ingress-Lastausgleichsfunktion für Anwendungen
{: #cs_albsecret_fails}

{: tsSymptoms}
Nach der Bereitstellung eines geheimen Schlüssels der Ingress-Lastausgleichsfunktion für Anwendungen für Ihren Cluster wird das Beschreibungsfeld `Description` nicht mit dem Namen des geheimen Schlüssels aktualisiert, wenn Sie Ihr Zertifikat in {{site.data.keyword.cloudcerts_full_notm}} anzeigen.

Beim Auflisten von Informationen zum geheimen Schlüssel der Lastausgleichsfunktion für Anwendungen wird der Status `*_failed` angezeigt. Beispiel: `create_failed`, `update_failed` oder `delete_failed`.

{: tsResolve}
Überprüfen Sie die folgenden möglichen Ursachen für ein Fehlschlagen des geheimen Schlüssels der Lastausgleichsfunktion für Anwendungen sowie die entsprechenden Fehlerbehebungsschritte:

<table>
 <thead>
 <th>Mögliche Ursache</th>
 <th>Fehlerbehebungsmaßnahme</th>
 </thead>
 <tbody>
 <tr>
 <td>Sie verfügen nicht über die erforderlichen Zugriffsrollen für das Herunterladen und Aktualisieren von Zertifikatsdaten.</td>
 <td>Bitten Sie Ihren Kontoadministrator, Ihnen sowohl die Rolle eines **Operators** als auch die Rolle eines **Bearbeiters** für Ihre Instanz von {{site.data.keyword.cloudcerts_full_notm}} zuzuweisen. Weitere Informationen finden Sie unter <a href="/docs/services/certificate-manager/access-management.html#managing-service-access-roles">Servicezugriff verwalten</a> für {{site.data.keyword.cloudcerts_short}}. </td>
 </tr>
 <tr>
 <td>Die CRN des Zertifikats, die zum Zeitpunkt der Erstellung, Aktualisierung oder Entfernung angegeben wurde, gehört nicht zu demselben Konto wie der Cluster.</td>
 <td>Vergewissern Sie sich, dass die von Ihnen angegebene CRN des Zertifikats in eine Instanz des {{site.data.keyword.cloudcerts_short}}-Service importiert wurde, die in demselben Konto wie Ihr Cluster bereitgestellt wird.</td>
 </tr>
 <tr>
 <td>Die zum Zeitpunkt der Erstellung angegebene CRN des Zertifikats ist falsch.</td>
 <td><ol><li>Überprüfen Sie die Richtigkeit der von Ihnen angegebenen Zeichenfolge für die CRN des Zertifikats.</li><li>Falls die CRN des Zertifikats als korrekt befunden wird, versuchen Sie den geheimen Schlüssel <code>bx cs alb-cert-deploy --update --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code> zu aktualisieren. </li><li>Wenn dieser Befehl zum Status <code>update_failed</code> führt, entfernen Sie den geheimen Schlüssel: <code>bx cs alb-cert-rm --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt;</code> </li><li>Stellen Sie den geheimen Schlüssel erneut bereit: <code>bx cs alb-cert-deploy --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>Die zum Zeitpunkt der Aktualisierung angegebene CRN des Zertifikats ist falsch.</td>
 <td><ol><li>Überprüfen Sie die Richtigkeit der von Ihnen angegebenen Zeichenfolge für die CRN des Zertifikats.</li><li>Wenn die CRN des Zertifikats als korrekt befunden wurde, entfernen Sie den geheimen Schlüssel: <code>bx cs alb-cert-rm --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt;</code></li><li>Stellen Sie den geheimen Schlüssel erneut bereit: <code>bx cs alb-cert-deploy --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></li><li>Versuchen Sie, den geheimen Schlüssel zu aktualisieren: <code>bx cs alb-cert-deploy --update --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>Der {{site.data.keyword.cloudcerts_long_notm}}-Service ist ausgefallen.</td>
 <td>Vergewissern Sie sich, dass Ihr {{site.data.keyword.cloudcerts_short}}-Service betriebsbereit ist.</td>
 </tr>
 </tbody></table>

<br />


## Es kann keine Unterdomäne für die Ingress-ALB abgerufen werden
{: #cs_subnet_limit}

{: tsSymptoms}
Wenn Sie `bx cs cluster-get <cluster>` ausführen, hat Ihr Cluster einen `normalen` Zustand, aber es ist keine **Ingress-Unterdomäne** verfügbar. 

Es wird möglicherweise eine Fehlernachricht ähnlich der folgenden angezeigt. 

```
There are already the maximum number of subnets permitted in this VLAN.
```
{: screen}

{: tsCauses}
Wenn Sie einen Cluster erstellen, werden acht öffentliche und acht private portierbare Teilnetze in dem angegebenen VLAN angefordert. Für {{site.data.keyword.containershort_notm}} haben VLANs ein Limit von 40 Teilnetzen. Wenn das VLAN des Clusters dieses Limit bereits erreicht hat, kann die **Ingress-Unterdomäne** nicht bereitgestellt werden. 

So zeigen Sie die Anzahl von Teilnetzen eines VLAN an: 
1.  Wählen Sie in der [IBM Cloud Infrastructure-Konsole (SoftLayer)](https://control.bluemix.net/) **Netz** > **IP-Management** > **VLANs** aus. 
2.  Klicken Sie auf die **VLAN-Nummer** des VLANs, mit dem Sie Ihren Cluster erstellt haben. Überprüfen Sie den Abschnitt **Teilnetze**, um zu sehen, ob mehr als 40 Teilnetze vorhanden sind. 

{: tsResolve}
Wenn Sie ein neues VLAN benötigen, fordern Sie eines beim [{{site.data.keyword.Bluemix_notm}} Support](/docs/get-support/howtogetsupport.html#getting-customer-support) an. [Erstellen Sie dann einen Cluster](cs_cli_reference.html#cs_cluster_create), der dieses neue VLAN verwendet. 

Wenn Sie bereits ein verfügbares VLAN haben, können Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) in Ihrem vorhandenen Cluster konfigurieren. Anschließend können Sie dem Cluster neue Workerknoten hinzufügen, die das andere VLAN mit verfügbaren Teilnetzen verwenden. 

Wenn Sie nicht alle Teilnetze im VLAN verwenden, können Sie Teilnetze im Cluster wiederverwenden. 
1.  Prüfen Sie, dass die Teilnetze, die Sie verwenden möchten, verfügbar sind. **Hinweis**: Das Infrastrukturkonto, das Sie verwenden, wird möglicherweise von mehreren {{site.data.keyword.Bluemix_notm}}-Konten gemeinsam verwendet. Ist dies der Fall, werden, selbst wenn Sie den Befehl `bx cs subnets` ausführen, um Teilnetze mit **gebundenen Clustern** zu sehen, nur Informationen zu Ihren Clustern angezeigt. Besprechen Sie sich mit dem Eigner des Infrastrukturkontos, um sicherzustellen, dass die Teilnetze verfügbar sind und nicht von einem anderen Konto oder Team verwendet werden. 

2.  [Erstellen Sie einen Cluster](cs_cli_reference.html#cs_cluster_create) mit der Option `--no-subnet`, sodass der Service nicht versucht, neue Teilnetze zu erstellen. Geben Sie den Standort und das VLAN an, an dem Sie die verfügbaren Teilnetze finden können. 

3.  Verwenden Sie den [Befehl](cs_cli_reference.html#cs_cluster_subnet_add) `bx cs cluster-subnet-add`, um vorhandene Teilnetze zu Ihrem Cluster hinzuzufügen. Weitere Informationen finden Sie unter [Angepasste und vorhandene Teilnetze in Kubernetes-Clustern hinzufügen oder daraus entfernen](cs_subnets.html#custom). 

<br />


## VPN-Konnektivität kann nicht mit dem StrongSwan-Helm-Diagramm erstellt werden
{: #cs_vpn_fails}

{: tsSymptoms}
Wenn Sie die VPN-Konnektivität überprüfen, indem Sie den Befehl `kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status` ausführen, sehen Sie den Status `ESTABLISHED` nicht oder der VPN-Pod befindet sich im Fehlerstatus `ERROR` oder er schlägt immer wieder fehl und startet neu.

{: tsCauses}
Ihre Helm-Diagrammkonfigurationsdatei weist falsche oder fehlende Werte auf oder es liegen Syntaxfehler vor.

{: tsResolve}
Wenn Sie versuchen, VPN-Konnektivität mit dem StrongSwan-Helm-Diagramm zu erstellen, ist es wahrscheinlich, dass der Status beim ersten Mal nicht `ESTABLISHED` lautet. Möglicherweise müssen Sie mehrere Problemtypen überprüfen und Ihre Konfigurationsdatei entsprechend ändern. Gehen Sie wie folgt vor, um Fehler in Ihrer StrongSwan-VPN-Konnektivität zu beheben:

1. Überprüfen Sie die Einstellungen des lokalen VPN-Endpunkts im Unternehmen mit den Einstellungen in Ihrer Konfigurationsdatei. Falls Sie fehlende Übereinstimmung feststellen:

    <ol>
    <li>Löschen Sie das vorhandene Helm-Diagramm.</br><pre class="codeblock"><code>helm delete --purge <releasename></code></pre></li>
    <li>Korrigieren Sie die falschen Werte in der Datei <code>config.yaml</code> und speichern Sie die aktualisiert Datei.</li>
    <li>Installieren Sie das neue Helm-Diagramm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<releasename> bluemix/strongswan</code></pre></li>
    </ol>

2. Falls der VPN-Pod den Status `ERROR` hat oder immer wieder ausfällt und neu startet, kann dies an der Parametervalidierung der `ipsec.conf`-Einstellungen in der Konfigurationsmap des Diagramms liegen.

    <ol>
    <li>Überprüfen Sie alle Gültigkeitsfehler in den StrongSwan-Pod-Protokollen.</br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>Falls Gültigkeitsfehler vorliegen, löschen Sie das vorhandene Helm-Diagramm.</br><pre class="codeblock"><code>helm delete --purge <releasename></code></pre></li>
    <li>Korrigieren Sie die falschen Werte in der Datei `config.yaml` und speichern Sie die aktualisiert Datei.</li>
    <li>Installieren Sie das neue Helm-Diagramm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<releasename> bluemix/strongswan</code></pre></li>
    </ol>

3. Führen Sie die 5 Helm-Tests aus, die in der StrongSwan-Diagrammdefinition enthalten sind.

    <ol>
    <li>Führen Sie die Helm-Tests aus.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>Wenn ein Test fehlschlägt, lesen Sie die Informationen zu den einzelnen Tests und warum diese möglicherweise fehlschlagen unter [Erklärung der Helm-VPN-Konnektivitätstests](cs_vpn.html#vpn_tests_table). <b>Hinweis</b>: Einige der Tests haben als Voraussetzungen optionale Einstellungen in der VPN-Konfiguration. Wenn einige der Tests fehlschlagen, kann dies abhängig davon, ob Sie diese optionalen Einstellungen angegeben haben, zulässig sein.</li>
    <li>Zeigen Sie die Ausgabe eines fehlgeschlagenen Tests an, indem Sie die Protokolle des Testpods anzeigen.<br><pre class="codeblock"><code>kubectl logs -n kube-system <testprogramm></code></pre></li>
    <li>Löschen Sie das vorhandene Helm-Diagramm.</br><pre class="codeblock"><code>helm delete --purge <releasename></code></pre></li>
    <li>Korrigieren Sie die falschen Werte in der Datei <code>config.yaml</code> und speichern Sie die aktualisiert Datei.</li>
    <li>Installieren Sie das neue Helm-Diagramm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<releasename> bluemix/strongswan</code></pre></li>
    <li>Gehen Sie wie folgt vor, um Ihre Änderungen zu überprüfen:<ol><li>Rufen Sie die aktuellen Test-Pods ab.</br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>Bereinigen Sie die aktuellen Testpods.</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>Führen Sie die Tests erneut aus.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. Führen Sie das VPN-Debugging-Tool aus, das im Paket des VPN-Pod-Image enthalten ist.

    1. Legen Sie die Umgebungsvariable `STRONGSWAN_POD` fest.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. Führen Sie das Debugging-Tool aus.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        Das Tool gibt bei seiner Ausführung mehrere Seiten mit Informationen aus, da es verschiedene Tests für allgemeine Netzprobleme ausführt. Ausgabezeilen, die mit `ERROR`, `WARNING`, `VERIFY` oder `CHECK` beginnen, weisen auf mögliche Fehler bei der VPN-Verbindung hin.

    <br />


## StrongSwan-VPN-Konnektivität schlägt nach Hinzufügen oder Löschen von Workerknoten fehl
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
Sie haben zuvor eine funktionierende VPN-Verbindung mithilfe des StrongSwan-IPSec-VPN-Service hergestellt. Nachdem Sie einen Workerknoten in Ihrem Cluster hinzugefügt oder gelöscht haben, tritt jedoch mindestens eines der folgenden Symptome auf:

* Der VPN-Status lautet nicht `ESTABLISHED`
* Sie können von Ihrem lokalen Netz im Unternehmen nicht auf einen neuen Workerknoten zugreifen
* Sie können von Pods, die auf neuen Workerknoten ausgeführt werden, nicht auf das ferne Netz zugreifen.

{: tsCauses}
Wenn Sie einen Workerknoten hinzugefügt haben:

* Der Workerknoten wurde auf einem neuen privaten Teilnetz bereitgestellt, das nicht über die VPN-Verbindung durch Ihre vorhandenen `localSubnetNAT`- oder `local.subnet`-Einstellungen zugänglich gemacht wurde.
* VPN-Routen können nicht zum Workerknoten hinzugefügt werden, weil der Worker Taints oder Bezeichnungen aufweist, die nicht in Ihren vorhandenen `tolerations`- oder `nodeSelector`-Einstellungen enthalten sind.
* Der VPN-Pod ist auf dem neuen Workerknoten aktiv, aber die öffentliche IP-Adresse des Workerknotens ist über die lokale Firewall des Unternehmens nicht zulässig.

Wenn Sie einen Workerknoten gelöscht haben:

* Der Workerknoten war aufgrund von vorhandenen `tolerations`- oder `nodeSelector`-Einstellungen der einzige Knoten, in dem der VPN-Pod aktiv war.

{: tsResolve}
Aktualisieren Sie die Helm-Diagrammwerte, um die Änderungen im Workerknoten abzubilden.

1. Löschen Sie das vorhandene Helm-Diagramm.

    ```
    helm delete --purge <releasename>
    ```
    {: pre}

2. Öffnen Sie die Konfigurationsdatei für Ihren StrongSwan-VPN-Service.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Überprüfgen Sie die folgenden Einstellungen und nehmen Sie bei Bedarf Änderungen vor, um die gelöschten oder hinzugefügten Workerknoten abzubilden.

    Wenn Sie einen Workerknoten hinzugefügt haben:

    <table>
     <thead>
     <th>Einstellung</th>
     <th>Beschreibung</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Der hinzugefügte Workerknoten kann in einem neuen, anderen privaten Teilnetz bereitgestellt werden als die anderen vorhandenen Teilnetze, auf denen sich andere Workerknoten befinden. Wenn Sie die Teilnetz-NAT (subnetNAT) verwenden, um die privaten lokalen IP-Adressen Ihres Clusters erneut zuzuordnen, und wenn ein Workerknoten auf einem neuen Teilnetz hinzugefügt wurde, fügen Sie die neue Teilnetz-CIDR zu dieser Einstellung hinzu.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Wenn Sie den VPN-Pod zuvor auf die Ausführung auf beliebigen Workerknoten mit einer bestimmten Bezeichnung beschränkt haben und wenn Sie jetzt VPN-Routen zum Worker hinzufügen möchten, stellen Sie sicher, dass der hinzugefügte Workerknoten über diese Bezeichnung verfügt.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Wenn der hinzugefügte Workerknoten eine Bezeichnung trägt und Sie dem Worker VPN-Routen hinzufügen möchten, dann ändern Sie die Einstellung, damit der VPN-Pod auf allen Workerknoten mit Bezeichnungen oder auf Workerknoten mit bestimmten Bezeichnungen ausgeführt werden kann.</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>Der hinzugefügte Workerknoten kann in einem neuen, anderen privaten Teilnetz bereitgestellt werden als die anderen vorhandenen Teilnetze, auf denen sich andere Workerknoten befinden. Wenn Ihre Apps von NodePort- oder LoadBalancer-Services im privaten Netz zugänglich gemacht werden und sich auf einem neuen Workerknoten befinden, den Sie hinzugefügt haben, dann fügen Sie die neue Teilnetz-CIDR zu dieser Einstellung hinzu. **Hinweis**: Wenn Sie Werte zum `lokalen Teilnetz` hinzufügen, überprüfen Sie die VPN-Einstellungen für das lokale Teilnetz im Unternehmen, um zu sehen, ob diese ebenfalls aktualisiert werden müssen.</td>
     </tr>
     </tbody></table>

    Wenn Sie einen Workerknoten gelöscht haben:

    <table>
     <thead>
     <th>Einstellung</th>
     <th>Beschreibung</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Wenn Sie die Teilnetz-NAT (subnetNAT) verwenden, um bestimmte private, lokale IP-Adressen erneut zuzuordnen, entfernen Sie alle IP-Adressen aus dieser Einstellung, die vom alten Workerknoten stammen. Wenn Sie die Teilnetz-NAT verwenden, um ganze Teilnetze erneut zuzuordnen und wenn sich keine Ihrer Workerknoten mehr im Teilnetz befinden, dann entfernen Sie das Teilnetz-CIDR aus dieser Einstellung.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Sie haben zuvor den VPN-Pod auf die Ausführung auf einen einzigen Workerknoten beschränkt und dieser Workerknoten wurde gelöscht. Ändern Sie diese Einstellung, um dem VPN-Pod die Ausführung auf anderen Workerknoten zu erlauben.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Falls auf den von Ihnen gelöschten Workerknoten kein Taint angewendet wurde, aber auf alle verbleibenden Workerknoten wurden Taints angewendet, ändern Sie diese Einstellung, damit der VPN-Pod auf allen Workerknoten mit Taints oder auf Workerknoten mit bestimmten Taints ausgeführt werden kann. </td>
     </tr>
     </tbody></table>

4. Installieren Sie das neue Helm-Diagramm mit Ihren aktualisierten Werten.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<releasename> ibm/strongswan
    ```
    {: pre}

5. Prüfen Sie den Status der Diagrammbereitstellung. Sobald das Diagramm bereit ist, hat das Feld **STATUS** oben in der Ausgabe den Wert `DEPLOYED`.

    ```
    helm status <releasename>
    ```
    {: pre}

6. In einigen Fällen müssen Sie möglicherweise Ihre lokalen Einstellungen im Unternehmen und Ihre Firewalleinstellungen ändern, damit diese mit den Änderungen übereinstimmen, die Sie in der VPN-Konfigurationsdatei vorgenommen haben.

7. Starten Sie das VPN.
    * Falls die VPN-Verbindung von einem Cluster initialisiert wird (für `ipsec.auto` ist `start` festgelegt), starten Sie das VPN auf einem lokalen Gateway im Unternehmen und starten Sie dann das VPN auf dem Cluster.
    * Falls die VPN-Verbindung von einem lokalen Gateway im Unternehmen initialisiert wird (für `ipsec.auto` ist `auto` festgelegt), starten Sie das VPN auf dem Cluster und anschließend starten Sie das VPN auf dem lokalen Gateway im Unternehmen.

8. Legen Sie die Umgebungsvariable `STRONGSWAN_POD` fest.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<releasename> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. Prüfen Sie den Status des VPN.

    ```
    kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * Sobald die VPN-Verbindung den Status `ESTABLISHED` erreicht hat, war die VPN-Verbindung erfolgreich. Es ist keine weitere Aktion erforderlich.

    * Wenn Sie immer noch Verbindungsprobleme haben, lesen Sie die Informationen im Abschnitt [VPN-Konnektivität mit StrongSwan-Helm-Diagramm kann nicht erstellt werden](#cs_vpn_fails), um weiter nach Fehlern bei der VPN-Verbindung zu suchen.

<br />




## ETCD-URL für die Konfiguration der Calico-CLI kann nicht abgerufen werden
{: #cs_calico_fails}

{: tsSymptoms}
Wenn Sie die `<ETCD_URL>` abrufen, um [Netzrichtlinien hinzuzufügen](cs_network_policy.html#adding_network_policies), dann gibt das System die Fehlernachricht `calico-config nicht gefunden` aus.

{: tsCauses}
Ihr Cluster verfügt nicht über [Kubernetes Version 1.7](cs_versions.html) oder höher.

{: tsResolve}
[Aktualisieren Sie Ihren Cluster](cs_cluster_update.html#master) oder rufen Sie die `<ETCD_URL>` mithilfe von Befehlen ab, die mit älteren Versionen von Kubernetes kompatibel sind.

Führen Sie die folgenden Befehle aus, um den Wert für `<ETCD_URL>` abzurufen:

- Linux und OS X:

    ```
    kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
    ```
    {: pre}

- Windows:
    <ol>
    <li> Rufen Sie eine Liste der Pods im Namensbereich des kube-Systems ab und suchen Sie nach dem Calico-Controller-Pod. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Beispiel:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> Zeigen Sie die Details des Calico-Controller-Pods an.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;calico-pod-id&gt;</code></pre>
    <li> Suchen Sie den etcd-Endpunktwert. Beispiel: <code>https://169.1.1.1:30001</code>
    </ol>

Wenn Sie die `<ETCD_URL>` abrufen, dann arbeiten Sie mit den Schritten weiter, die unter (Netzrichtlinien hinzufügen)[cs_network_policy.html#adding_network_policies] aufgeführt sind.

<br />




## Hilfe und Unterstützung anfordern
{: #ts_getting_help}

Haben Sie noch immer Probleme mit Ihrem Cluster?
{: shortdesc}

-   [Überprüfen Sie auf der {{site.data.keyword.Bluemix_notm}}-Statusseite ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/bluemix/support/#status), ob {{site.data.keyword.Bluemix_notm}} verfügbar ist.
-   Veröffentlichen Sie eine Frage im [{{site.data.keyword.containershort_notm}}-Slack. ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com)
    Wenn Sie keine IBM ID für Ihr {{site.data.keyword.Bluemix_notm}}-Konto verwenden, [fordern Sie eine Einladung](https://bxcs-slack-invite.mybluemix.net/) zu diesem Slack an. {: tip}
-   Suchen Sie in entsprechenden Foren, ob andere Benutzer auf das gleiche Problem
gestoßen sind. Versehen Sie Ihre Fragen in den Foren mit Tags, um sie für das Entwicklungsteam
von {{site.data.keyword.Bluemix_notm}} erkennbar zu machen.

    -   Wenn Sie technische Fragen zur Entwicklung oder Bereitstellung von Clustern oder Apps mit {{site.data.keyword.containershort_notm}} haben, veröffentlichen Sie Ihre Frage auf [Stack Overflow ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) und versehen Sie sie mit den Tags `ibm-cloud`, `kubernetes` und `containers`.
    -   Verwenden Sie für Fragen zum Service und zu ersten Schritten das Forum [IBM developerWorks dW Answers ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Geben Sie die Tags `ibm-cloud` und `containers` an.
    Weitere Details zur Verwendung der Foren
finden Sie unter [Hilfe anfordern](/docs/get-support/howtogetsupport.html#using-avatar).

-   Wenden Sie sich an den IBM Support, indem Sie ein Ticket öffnen. Informationen zum Öffnen eines IBM
Support-Tickets oder zu Supportstufen und zu Prioritätsstufen von Tickets finden Sie unter
[Support kontaktieren](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Geben Sie beim Melden eines Problems Ihre Cluster-ID an. Führen Sie den Befehl `bx cs clusters` aus, um Ihre Cluster-ID abzurufen.


