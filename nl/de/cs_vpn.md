---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# VPN-Konnektivität einrichten
{: #vpn}

VPN-Konnektivität ermöglicht Ihnen auch das sichere Verbinden von Apps in einem Kubernetes-Cluster mit einem lokalen Netz. Sie können auch Apps, die nicht in Ihrem Cluster enthalten sind, mit Apps verbinden, die Teil Ihres Clusters sind.
{:shortdesc}

## Helm-Diagramm zur Einrichtung von VPN-Konnektivität mit dem Strongswan-IPSec-VPN-Service
{: #vpn-setup}

Bei der Konfiguration von VPN-Konnektivität können Sie ein Helm-Diagramm verwenden, um den [Strongswan-IPSec-VPN-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.strongswan.org/) in einem Kubernetes-Pod einzurichten und bereitzustellen. Der gesamte VPN-Datenverkehr wird dann durch diesen Pod weitergeleitet. Weitere Informationen zu den Helm-Befehlen zum Konfigurieren des Strongswan-Diagramms finden Sie in der <a href="https://docs.helm.sh/helm/" target="_blank">Helm-Dokumentation <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.
{:shortdesc}

Vorbemerkungen:

- [Erstellen Sie einen Standardcluster.](cs_clusters.html#clusters_cli)
- [Wenn Sie ein vorhandenes Cluster verwenden, aktualisieren Sie es auf Version 1.7.4 oder höher.](cs_cluster_update.html#master)
- Das Cluster muss mindestens eine verfügbare öffentliche Load Balancer-IP-Adresse haben.
- [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure).

Gehen Sie wie folgt vor, um VPN-Konnektivität mit Strongswan einzurichten:

1. Falls Helm noch nicht aktiviert ist, installieren und initialisieren Sie es für Ihren Cluster.

    1. Installieren Sie die <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm-CLI <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>.

    2. Initialisieren Sie Helm und installieren Sie `tiller`.

        ```
        helm init
        ```
        {: pre}

    3. Überprüfen Sie, dass der Pod `tiller-deploy` den Status `Running` in Ihrem Cluster hat.

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        Beispielausgabe:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. Fügen Sie das {{site.data.keyword.containershort_notm}}-Helm-Repository zu Ihrer Helm-Instanz hinzu.

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Überprüfen Sie, dass das Strongswan-Diagramm im Helm-Repository aufgelistet ist.

        ```
        helm search bluemix
        ```
        {: pre}

2. Speichern Sie die Standardkonfigurationseinstellung für das Strongswan-Helm-Diagramm in einer lokalen YAML-Datei.

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. Öffnen Sie die Datei `config.yaml` und nehmen Sie die folgenden Änderungen an den Standardwerten entsprechend der gewünschten VPN-Konfiguration vor. Wenn Eigenschaften über bestimmte Werte verfügen, aus denen Sie wählen können, dann sind diese Werte in Kommentaren über den jeweiligen Eigenschaften in der Datei aufgeführt. **Wichtig**: Wenn Sie keine Eigenschaft ändern müssen, kommentieren Sie diese Eigenschaft aus, indem Sie jeweils ein `#` davorsetzen.

    <table>
    <caption>Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>Wenn Sie über eine vorhandene <code>ipsec.conf</code>-Datei verfügen, die Sie verwenden möchten, entfernen Sie die geschweiften Klammern (<code>{}</code>) und fügen Sie die Inhalte Ihrer Datei nach dieser Eigenschaft hinzu. Die Dateiinhalte müssem eingerückt sein. **Hinweis:** Wenn Sie Ihre eigene Datei verwenden, werden die Werte für die Abschnitte <code>ipsec</code>, <code>local</code> und <code>remote</code> nicht verwendet.</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>Wenn Sie über eine vorhandene <code>ipsec.secrets</code>-Datei verfügen, die Sie verwenden möchten, entfernen Sie die geschweiften Klammern (<code>{}</code>) und fügen Sie die Inhalte Ihrer Datei nach dieser Eigenschaft hinzu. Die Dateiinhalte müssen eingerückt sein. **Hinweis:** Wenn Sie Ihre eigene Datei verwenden, werden die Werte für den Abschnitt <code>preshared</code> nicht verwendet.</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>Wenn Ihr lokaler VPN-Tunnelendpunkt <code>ikev2</code> nicht als Protokoll für die Initialisierung der Verbindung unterstützt, ändern Sie diesen Wert in <code>ikev1</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>Ändern Sie diesen Wert in die Liste von ESP-Verschlüsselungs-/Authentifizierungsalgorithmen, die Ihr lokaler VPN-Tunnelendpunkt für die Verbindung verwendet.</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>Ändern Sie diesen Wert in die Liste von IKE/ISAKMP-SA-Verschlüsselungs-/Authentifizierungsalgorithmen, die Ihr lokaler VPN-Tunnelendpunkt für die Verbindung verwendet.</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>Wenn Sie möchten, dass der Cluster die VPN-Verbindung initialisiert, ändern Sie diesen Wert in <code>start</code>.</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>Ändern Sie diesen Wert in die Liste von Clusterteilnetz-CIDRs, die über die VPN-Verbindung für das lokale Netz zugänglich sein sollen. Diese Liste kann die folgenden Teilnetze enthalten: <ul><li>Die Teilnetz-CIDR des Kubernetes-Pods: <code>172.30.0.0/16</code></li><li>Die Teilnetz-CIDR des Kubernetes-Service: <code>172.21.0.0/16</code></li><li>Wenn Sie Anwendungen über einen NodePort-Service im privaten Netz zugänglich machen, die private Teilnetz-CIDR des Workerknotens. Sie finden diesen Wert, indem Sie <code>bx cs subnets | grep <xxx.yyy.zzz></code> ausführen, wobei &lt;xxx.yyy.zzz&gt; das erste von drei Oktetts der privaten IP-Adresse des Workerknotens ist.</li><li>Wenn Sie Anwendungen über LoadBalancer-Services im privaten Netz zugänglich machen, die private oder benutzerverwaltete Teilnetz-CIDR des Clusters. Sie finden diese Werte, indem Sie <code>bx cs cluster-get <clustername> --showResources</code> ausführen. Suchen Sie im Abschnitt <b>VLANS</b> nach CIDRs, deren <b>Public</b>-Wert <code>false</code> lautet.</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>Ändern Sie diesen Wert in die Zeichenfolge-ID für die lokale Kubernetes-Clusterseite, die Ihr VPN-Tunnelendpunkt für die Verbindung verwendet.</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>Ändern Sie diesen Wert in die öffentliche IP-Adresse für das lokale VPN-Gateway.</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Ändern Sie diesen Wert in die Liste von lokalen privaten Teilnetz-CIDRs, auf die der Kubernetes-Cluster zugreifen kann.</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>Ändern Sie diesen Wert in die Zeichenfolge-ID für die ferne lokale Seite, die Ihr VPN-Tunnelendpunkt für die Verbindung verwendet.</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>Ändern Sie diesen Wert in den vorab geteilten geheimen Schlüssel, den das Gateway Ihres lokalen VPN-Tunnelendpunkts für die Verbindung verwendet.</td>
    </tr>
    </tbody></table>

4. Speichern Sie die aktualisierte Datei `config.yaml`.

5. Installieren Sie das Helm-Diagramm auf Ihrem Cluster mit der aktualisierten Datei `config.yaml`. Die aktualisierten Eigenschaften werden in einer Konfigurationsmap für Ihr Diagramm gespeichert.

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. Prüfen Sie den Status der Diagrammbereitstellung. Sobald das Diagramm bereit ist, hat das Feld **STATUS** oben in der Ausgabe den Wert `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

7. Sobald das Diagramm bereitgestellt ist, überprüfen Sie, dass die aktualisierten Einstellungen in der Datei `config.yaml` verwendet wurden.

    ```
    helm get values vpn
    ```
    {: pre}

8. Testen Sie die neue VPN-Konnektivität.
    1. Wenn das VPN im lokalen Gateway nicht aktiv ist, starten Sie das VPN.

    2. Legen Sie die Umgebungsvariable `STRONGSWAN_POD` fest.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. Prüfen Sie den Status des VPN. Der Status `ESTABLISHED` bedeutet, dass die VPN-Verbindung erfolgreich war.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        Beispielausgabe:
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

        **Hinweis**:
          - Es ist sehr wahrscheinlich, dass das VPN nicht den Status `ESTABLISHED` hat, wenn Sie das erste Mal dieses Helm-Diagramm verwenden. Unter Umständen müssen Sie die Einstellungen des lokalen VPN-Endpunkts prüfen und zu Schritt 3 zurückkehren, um die Datei `config.yaml` mehrfach zu ändern, bevor die Verbindung erfolgreich ist.
          - Falls der VPN-Pod den Status `ERROR` hat oder immer wieder ausfällt und neu startet, kann dies an der Parametervalidierung der `ipsec.conf`-Einstellungen in der Konfigurationsmap des Diagramms liegen. Prüfen Sie, ob dies der Fall ist, indem Sie mithilfe des Befehls `kubectl logs -n kube-system $STRONGSWAN_POD` in den Protokollen des Strongswan-Pods nach Validierungsfehlern suchen. Falls Sie Validierungsfehler finden, führen Sie `helm delete --purge vpn` aus, kehren Sie zu Schritt 3 zurück, um die falschen Werte in der Datei `config.yaml` zu korrigieren, und wiederholen Sie dann die Schritte 4 bis 8. Wenn Ihr Cluster viele Workerknoten umfasst, können Sie mit `helm upgrade` Ihre Änderungen schneller anwenden, anstatt erst `helm delete` und dann `helm install` auszuführen.

    4. Sobald das VPN den Status `ESTABLISHED` hat, testen Sie die Verbindung mit `ping`. Im folgenden Beispiel wird ein Ping vom VPN-Pod im Kubernetes-Cluster an die private IP-Adresse des lokalen VPN-Gateways gesendet. Stellen Sie sicher, dass `remote.subnet` und `local.subnet` in der Konfigurationsdatei richtig angegeben sind und dass die lokale Teilnetzliste die Quellen-IP-Adresse umfasst, von der aus Sie das Ping-Signal senden.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <private_ip_des_lokalen_gateways>
        ```
        {: pre}

### Strongswan-IPSec-VPN-Service inaktivieren
{: vpn_disable}

1. Löschen Sie das Helm-Diagramm.

    ```
    helm delete --purge vpn
    ```
    {: pre}
