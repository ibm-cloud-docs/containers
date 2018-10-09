---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

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



# Fehlerbehebung für Cluster und Workerknoten
{: #cs_troubleshoot_clusters}

Ziehen Sie bei der Verwendung von {{site.data.keyword.containerlong}} die folgenden Verfahren für die Fehlerbehebung Ihrer Cluster und Workerknoten in Betracht.
{: shortdesc}

Wenn Sie ein allgemeineres Problem haben, testen Sie das [Cluster-Debugging](cs_troubleshoot.html).
{: tip}

## Verbindung mit dem Infrastrukturkonto kann nicht hergestellt werden
{: #cs_credentials}

{: tsSymptoms}
Wenn Sie einen neuen Kubernetes-Cluster erstellen, erhalten Sie eine Fehlernachricht ähnlich einer der folgenden.

```
Es konnte keine Verbindung zu Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) hergestellt werden.
Zur Erstellung eines Standardclusters ist es erforderlich, dass Sie entweder über ein nutzungsabhängiges Konto
mit einer Verbindung zum Konto der IBM Cloud-Infrastruktur (SoftLayer) verfügen oder dass Sie die {{site.data.keyword.containerlong_notm}}-CLI zum Einrichten der API-Schlüssel für die {{site.data.keyword.Bluemix_notm}}-Infrastruktur verwendet haben.
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: 'Item' must be ordered with permission.
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: The user does not have the necessary {{site.data.keyword.Bluemix_notm}} Infrastructure permissions to add servers
```
{: screen}

```
IAM token exchange request failed: Cannot create IMS portal token, as no IMS account is linked to the selected BSS account
```
{: screen}

{: tsCauses}
Nutzungsabhängige {{site.data.keyword.Bluemix_notm}}-Konten, die erstellt wurden, nachdem die automatische Kontoverknüpfung aktiviert wurde, haben bereits Zugriff auf das Portfolio von IBM Cloud Infrastructure (SoftLayer). Somit können Sie Infrastrukturressourcen für Ihren Cluster ohne weitere Konfiguration kaufen. Wenn Sie über ein gültiges nutzungsabhängiges Konto verfügen und diese Fehlernachricht erhalten, verwenden Sie möglicherweise nicht die richtigen Berechtigungsnachweise für das Konto der IBM Cloud-Infrastruktur (SoftLayer), um auf Infrastrukturressourcen zuzugreifen.

Benutzer mit anderen {{site.data.keyword.Bluemix_notm}}-Kontotypen müssen ihre Konten konfigurieren, um Standardcluster zu erstellen. Beispiele für den Fall, dass Sie einen anderen Kontotyp haben:
* Sie haben ein IBM Cloud Infrastructure-Konto (SoftLayer), das älter als Ihr {{site.data.keyword.Bluemix_notm}}-Plattformkonto ist, und Sie möchten es weiterhin verwenden.
* Sie möchten ein anderes IBM Cloud-Infrastrukturkonto (SoftLayer) verwenden, in dem die Infrastrukturressourcen eingerichtet werden sollen. Sie können beispielsweise ein {{site.data.keyword.Bluemix_notm}}-Teamkonto einrichten, um ein anderes Infrastrukturkonto für Abrechnungszwecke zu verwenden.

{: tsResolve}
Der Kontoeigner muss die Berechtigungsnachweise für das Infrastrukturkonto ordnungsgemäß einrichten. Die Berechtigungsnachweise richten sich nach dem Typ des von Ihnen verwendeten Infrastrukturkontos.

**Vorbereitende Schritte**:

1.  Überprüfen Sie, dass Sie Zugriff auf ein Infrastrukturkonto haben. Melden Sie sich an der [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) an und klicken Sie im erweiterbaren Menü auf **Infrastruktur**. Wenn das Dashboard 'Infrastruktur' angezeigt wird, haben Sie Zugriff auf ein Infrastrukturkonto.
2.  Überprüfen Sie, ob Ihr Cluster ein anderes Infrastrukturkonto verwendet als das zusammen mit Ihrem nutzungsabhängigen Konto gelieferte Konto.
    1.  Klicken Sie im erweiterbaren Menü auf **Container > Cluster**.
    2.  Wählen Sie Ihren Cluster in der Tabelle aus.
    3.  Suchen Sie auf der Registerkarte **Übersicht** nach dem Feld **Infrastrukturbenutzer**.
        * Wenn das Feld **Infrastrukturbenutzer** nicht angezeigt wird, verfügen Sie über ein verlinktes nutzungsabhängiges Konto, das für Ihre Infrastruktur- und Plattformkonten dieselben Berechtigungsnachweise verwendet.
        * Wenn ein Feld für den **Infrastrukturbenutzer** angezeigt wird, verwendet der Cluster ein anderes Infrastrukturkonto als das zusammen mit Ihrem nutzungsabhängigen Konto gelieferte Konto. Diese verschiedenen Berechtigungsnachweise gelten für alle Cluster in der Region. 
3.  Entscheiden Sie, welche Art von Konto Sie verwenden möchten, um festzustellen, wie Sie das Problem mit der Infrastrukturberechtigung beheben können. Für die meisten Benutzer ist das standardmäßig verknüpfte nutzungsabhängige Konto ausreichend.
    *  Verknüpftes nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto: [Stellen Sie sicher, dass der API-Schlüssel mit den richtigen Berechtigungen konfiguriert wurde](#apikey). Wenn Ihr Cluster ein anderes Infrastrukturkonto verwendet, müssen Sie diese Berechtigungsnachweise im Rahmen des Prozesses inaktivieren.
    *  Andere {{site.data.keyword.Bluemix_notm}}-Plattform- und Infrastrukturkonten: Überprüfen Sie, ob Sie auf das Infrastruktur-Portfolio zugreifen können und dass [die Berechtigungsnachweise für das Infrastrukturkonto mit den richtigen Berechtigungen eingerichtet sind](#credentials).

### Standard-Infrastrukturberechtigungsnachweise für verknüpfte nutzungsabhängige Konten mit dem API-Schlüssel verwenden
{: #apikey}

1.  Stellen Sie sicher, dass der Benutzer, dessen Berechtigungsnachweise für Infrastrukturaktionen verwendet werden sollen, über die richtigen Berechtigungen verfügt.

    1.  Melden Sie sich an der [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) an.

    2.  Wählen Sie im erweiterbaren Menü **Infrastruktur** aus.

    3.  Wählen Sie in der Menüleiste **Konto** > **Benutzer** > **Benutzerliste** aus.

    4.  Stellen Sie in der Spalte **API-Schlüssel** sicher, dass der Benutzer über einen API-Schlüssel verfügt, oder klicken Sie auf die Option zum **Generieren**.

    5.  Bestätigen Sie die [Richtigkeit der Infrastrukturberechtigungen](cs_users.html#infra_access) oder weisen Sie dem Benutzer solche zu.

2.  Legen Sie für die Region, in der sich der Cluster befindet, den API-Schlüssel fest.

    1.  Melden Sie sich bei dem Terminal als der Benutzer an, dessen Infrastrukturberechtigungen Sie verwenden möchten.
    
    2.  Wenn Sie sich in einer anderen Region befinden, wechseln Sie in die Region, in der Sie den API-Schlüssel festlegen möchten.
    
        ```
        ibmcloud ks region-set
        ```
        {: pre}

    3.  Legen Sie den API-Schlüssel für die Region fest.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    

    4.  Überprüfen Sie, dass der API-Schlüssel festgelegt wurde.
        ```
        ibmcloud ks api-key-info <clustername_oder-_id>
        ```
        {: pre}

3.  **Optional**: Wenn Ihr nutzungsabhängiges Konto ein anderes Infrastrukturkonto verwendet, um Cluster zur Verfügung zu stellen (wenn Sie z. B. den Befehl `ibmcloud ks credentials-set` verwendet haben), verwendet das Konto weiterhin diese Infrastrukturberechtigungsnachweise anstelle des API-Schlüssels. Sie müssen das zugehörige Infrastrukturkonto entfernen, damit der API-Schlüssel, den Sie im vorherigen Schritt festgelegt haben, verwendet wird.
    ```
    ibmcloud ks credentials-unset
    ```
    {: pre}
        
4.  **Optional**: Wenn Sie Ihren öffentlichen Cluster mit lokalen Ressourcen verbinden, müssen Sie die Netzkonnektivität überprüfen.

    1.  Überprüfen Sie die VLAN-Konnektivität Ihrer Worker.
    2.  [Richten Sie die VPN-Konnektivität ein](cs_vpn.html#vpn), falls erforderlich.
    3.  [Öffnen Sie in Ihrer Firewall die erforderlichen Ports](cs_firewall.html#firewall).

### Berechtigungsnachweise für die Infrastruktur für unterschiedliche Plattform- und Infrastrukturkonten konfigurieren
{: #credentials}

1.  Rufen Sie das Infrastrukturkonto ab, das Sie für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) verwenden möchten. Sie haben verschiedene Optionen, die sich nach Ihrem aktuellen Kontotyp richten.

    <table summary="In der Tabelle werden die Standardoptionen für die Clustererstellung nach Kontotyp angezeigt. Die Zeilen sind von links nach rechts zu lesen, mit der Kontobeschreibung in Spalte eins und den Optionen zum Erstellen eines Standardclusters in Spalte 2.">
    <caption>Erstellungsoptionen für Standardcluster nach Kontotyp</caption>
      <thead>
      <th>Kontobeschreibung</th>
      <th>Optionen zum Erstellen eines Standardclusters</th>
      </thead>
      <tbody>
        <tr>
          <td>Mit **Lite-Konten** können keine Cluster bereitgestellt werden.</td>
          <td>[Aktualisieren Sie Ihr Lite-Konto auf ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto](/docs/account/index.html#paygo), das mit Zugriff auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) eingerichtet ist.</td>
        </tr>
        <tr>
          <td>**Neuere nutzungsabhängige** Konten werden mit Zugriff auf das Infrastruktur-Portfolio geliefert.</td>
          <td>Sie können Standardcluster erstellen. Informationen zum Beheben von Fehlern in Infrastrukturberechtigungen finden Sie in [Infrastruktur-API-Berechtigungsnachweise für verknüpfte Konten konfigurieren](#apikey).</td>
        </tr>
        <tr>
          <td>**Ältere nutzungsabhängige Konten**, die erstellt wurden, bevor die automatische Kontoverknüpfung verfügbar war, haben keinen Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer).<p>Wenn Sie ein Konto der IBM Cloud-Infrastruktur (SoftLayer) haben, können Sie dieses Konto nicht mit einem älteren nutzungsabhängigen Konto verknüpfen.</p></td>
          <td><p><strong>Option 1:</strong> [Erstellen Sie ein neues nutzungsabhängiges Konto](/docs/account/index.html#paygo), das mit Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) eingerichtet wird. Wenn Sie diese Option auswählen, erhalten Sie zwei separate {{site.data.keyword.Bluemix_notm}}-Konten und -Abrechnungen.</p><p>Um Ihr altes nutzungsabhängiges Konto weiterhin zu verwenden, können Sie mit Ihrem neuen nutzungsabhängigen Konto einen API-Schlüssel generieren. Mit diesem API-Schlüssel greifen Sie auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) zu.</p><p><strong>Option 2:</strong> Wenn Sie bereits ein Konto der IBM Cloud-Infrastruktur (SoftLayer) haben, das Sie verwenden möchten, können Sie die Berechtigungsnachweise in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto festlegen.</p><p>**Anmerkung:** Wenn Sie eine manuelle Verknüpfung zu einem Konto der IBM Cloud-Infrastruktur (SoftLayer) herstellen, werden die Berechtigungsnachweise für jede für die IBM Cloud-Infrastruktur (SoftLayer) spezifische Aktion in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verwendet. Sie müssen sicherstellen, dass der von Ihnen angegebene API-Schlüssel über [ausreichende Infrastrukturberechtigungen](cs_users.html#infra_access) verfügt, damit die Benutzer Cluster erstellen und mit diesen arbeiten können.</p><p>**Fahren Sie bei beiden Optionen mit dem nächsten Schritt fort**.</p></td>
        </tr>
        <tr>
          <td>**Abonnementkonten** werden ohne Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) eingerichtet.</td>
          <td><p><strong>Option 1:</strong> [Erstellen Sie ein neues nutzungsabhängiges Konto](/docs/account/index.html#paygo), das mit Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) eingerichtet wird. Wenn Sie diese Option auswählen, erhalten Sie zwei separate {{site.data.keyword.Bluemix_notm}}-Konten und -Abrechnungen.</p><p>Wenn Sie Ihr Abonnementkonto weiterhin verwenden möchten, können Sie mit Ihrem neuen nutzungsabhängigen Konto einen API-Schlüssel in der IBM Cloud-Infrastruktur (SoftLayer) generieren. Anschließend müssen Sie für Ihr Abonnementkonto den API-Schlüssel der IBM Cloud-Infrastruktur (SoftLayer) manuell festlegen. Beachten Sie, dass Ressourcen der IBM Cloud-Infrastruktur (SoftLayer) über Ihr neues nutzungsabhängiges Konto in Rechnung gestellt werden.</p><p><strong>Option 2:</strong> Wenn Sie bereits ein Konto der IBM Cloud-Infrastruktur (SoftLayer) haben, das Sie verwenden möchten, können Sie die Berechtigungsnachweise für die IBM Cloud-Infrastruktur (SoftLayer) für Ihr {{site.data.keyword.Bluemix_notm}}-Konto manuell festlegen.</p><p>**Anmerkung:** Wenn Sie eine manuelle Verknüpfung zu einem Konto der IBM Cloud-Infrastruktur (SoftLayer) herstellen, werden die Berechtigungsnachweise für jede für die IBM Cloud-Infrastruktur (SoftLayer) spezifische Aktion in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verwendet. Sie müssen sicherstellen, dass der von Ihnen angegebene API-Schlüssel über [ausreichende Infrastrukturberechtigungen](cs_users.html#infra_access) verfügt, damit die Benutzer Cluster erstellen und mit diesen arbeiten können.</p><p>**Fahren Sie bei beiden Optionen mit dem nächsten Schritt fort**.</p></td>
        </tr>
        <tr>
          <td>**Konten der IBM Cloud-Infrastruktur (SoftLayer)**, kein {{site.data.keyword.Bluemix_notm}}-Konto</td>
          <td><p>[Erstellen Sie ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto](/docs/account/index.html#paygo), das mit Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) eingerichtet ist. Bei Auswahl dieser Option wird ein Konto der IBM Cloud-Infrastruktur (SoftLayer) für Sie erstellt. Sie haben zwei separate Konten der IBM Cloud-Infrastruktur (SoftLayer) und jeweils separate Abrechnungen.</p><p>Ihr neues {{site.keyword.data.Bluemix_notm}}-Konto verwendet standardmäßig das neue Infrastrukturkonto. Wenn Sie das alte Infrastrukturkonto weiter verwenden möchten, fahren Sie mit dem nächsten Schritt fort.</p></td>
        </tr>
      </tbody>
      </table>

2.  Stellen Sie sicher, dass der Benutzer, dessen Berechtigungsnachweise für Infrastrukturaktionen verwendet werden sollen, über die richtigen Berechtigungen verfügt.

    1.  Melden Sie sich an der [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) an.

    2.  Wählen Sie im erweiterbaren Menü **Infrastruktur** aus.

    3.  Wählen Sie in der Menüleiste **Konto** > **Benutzer** > **Benutzerliste** aus.

    4.  Stellen Sie in der Spalte **API-Schlüssel** sicher, dass der Benutzer über einen API-Schlüssel verfügt, oder klicken Sie auf die Option zum **Generieren**.

    5.  Bestätigen Sie die [Richtigkeit der Infrastrukturberechtigungen](cs_users.html#infra_access) oder weisen Sie dem Benutzer solche zu.

3.  Legen Sie die Infrastruktur-API-Berechtigungsnachweise mit dem richtigen Benutzer für das Konto fest.

    1.  Rufen Sie die Infrastruktur-API-Berechtigungsnachweise des Benutzers ab. **Anmerkung**: Die Berechtigungsnachweise lauten anders als die IBMid.

        1.  Klicken Sie in der Tabelle **Infrastruktur** > **Konto** > **Benutzer** > **Benutzerliste** der [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) auf **IBMid** oder **Benutzername**.

        2.  Zeigen Sie im Abschnitt **API-Zugriffsinformationen** die Werte für **API-Benutzername** und **Authentifizierungsschlüssel** an.    

    2.  Legen Sie die zu verwendenden Berechtigungsnachweise für die Infrastruktur-API fest.
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastruktur-api-benutzername> --infrastructure-api-key <infrastruktur-api-authentifizierungsschlüssel>
        ```
        {: pre}

4.  **Optional**: Wenn Sie Ihren öffentlichen Cluster mit lokalen Ressourcen verbinden, müssen Sie die Netzkonnektivität überprüfen.

    1.  Überprüfen Sie die VLAN-Konnektivität Ihrer Worker.
    2.  [Richten Sie die VPN-Konnektivität ein](cs_vpn.html#vpn), falls erforderlich.
    3.  [Öffnen Sie in Ihrer Firewall die erforderlichen Ports](cs_firewall.html#firewall).

<br />


## Firewall verhindert das Ausführen von CLI-Befehlen
{: #ts_firewall_clis}

{: tsSymptoms}
Wenn Sie die Befehle `ibmcloud`, `kubectl` oder `calicoctl` über die Befehlszeilenschnittstelle ausführen, schlagen sie fehl.

{: tsCauses}
Möglicherweise verhindern Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls.

{: tsResolve}
[Lassen Sie TCP-Zugriff zu, damit die CLI-Befehle ausgeführt werden können](cs_firewall.html#firewall). Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_users.html#access_policies) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_users.html#infra_access).


## Firewall verhindert die Verbindung des Clusters mit Ressourcen
{: #cs_firewall}

{: tsSymptoms}
Wenn die Workerknoten keine Verbindung herstellen können, dann werden Sie möglicherweise eine Vielzahl unterschiedlicher Symptome feststellen. Das System zeigt eventuell eine der folgenden Nachrichten an, wenn die Ausführung des Befehls 'kubectl proxy' fehlschlägt oder wenn Sie versuchen, auf einen Service in Ihrem Cluster zuzugreifen und diese Verbindung fehlschlägt.

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

Wenn Sie 'kubectl exec', kubectl attach' oder 'kubectl logs' ausführen, dann wird möglicherweise die folgende Nachricht angezeigt.

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Wenn die Ausführung von 'kubectl proxy' erfolgreich verläuft, das Dashboard jedoch nicht verfügbar ist, dann wird möglicherweise die folgende Nachricht angezeigt.

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
Möglicherweise wurde eine weitere Firewall eingerichtet oder Sie haben die vorhandenen Firewalleinstellungen für Ihr Konto von IBM Cloud Infrastructure (SoftLayer) angepasst. {{site.data.keyword.containerlong_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Ein weiterer möglicher Grund kann sein, dass Ihre Workerknoten in einer Neuladen-Schleife hängen.

{: tsResolve}
[Gewähren Sie dem Cluster den Zugriff auf Infrastrukturressourcen und andere Services](cs_firewall.html#firewall_outbound). Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_users.html#access_policies) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_users.html#infra_access).

<br />



## Zugreifen auf Workerknoten mit SSH schlägt fehl
{: #cs_ssh_worker}

{: tsSymptoms}
Es ist kein Zugriff auf Ihren Workerknoten über eine SSH-Verbindung möglich.

{: tsCauses}
Auf den Workerknoten ist SSH nach Kennwort nicht verfügbar.

{: tsResolve}
Verwenden Sie [DaemonSets ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) für Aktionen, die Sie für jeden Knoten ausführen müssen, oder verwenden Sie Jobs für Aktionen, die Sie einmalig ausführen müssen.

<br />


## ID der Bare-Metal-Instanz ist mit Workerdatensätzen inkonsistent
{: #bm_machine_id}

{: tsSymptoms}
Wenn Sie für Ihren Bare-Metal-Workerknoten `ibmcloud ks worker`-Befehle ausführen, wird eine Nachricht ähnlich der folgenden angezeigt.

```
Instance ID inconsistent with worker records
```
{: screen}

{: tsCauses}
Die Maschinen-ID und der {{site.data.keyword.containerlong_notm}}-Workerdatensatz können inkonsistent werden, wenn die Maschine Hardwareprobleme hat. Wenn die IBM Cloud-Infrastruktur (SoftLayer) dieses Problem behebt, kann sich eine Komponente innerhalb des Systems ändern, die der Service nicht identifiziert.

{: tsResolve}
Damit {{site.data.keyword.containerlong_notm}} die Maschine erneut identifizieren kann, [laden Sie den Bare-Metal-Workerknoten erneut](cs_cli_reference.html#cs_worker_reload). **Anmerkung**: Durch das erneute Laden wird außerdem die [Patchversion](cs_versions_changelog.html) der Maschine aktualisiert.

Sie können auch [den Bare-Metal-Workerknoten löschen](cs_cli_reference.html#cs_cluster_rm). **Anmerkung**: Die Abrechnung für Bare-Metal-Instanzen erfolgt monatlich.

<br />


## `kubectl`-Befehle überschreiten Zeitlimit
{: #exec_logs_fail}

{: tsSymptoms}
Wenn Sie Befehle wie `kubectl exec`, `kubectl attach`, `kubectl proxy`, `kubectl port-forward` oder `kubectl logs` ausführen, wird die folgende Nachricht angezeigt: 

  ```
  <worker-ip>:10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
Die OpenVPN-Verbindung zwischen dem Masterknoten und dem Workerknoten funktioniert möglicherweise nicht ordnungsgemäß.

{: tsResolve}
1. Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer). 
2. Starten Sie den OpenVPN-Client-Pod erneut.
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. Wenn weiterhin dieselbe Fehlernachricht angezeigt wird, kann es sein, dass der Workerknoten, auf dem sich der VPN-Pod befindet, nicht ordnungsgemäß funktioniert. Um den VPN-Pod erneut zu starten und ihn für einen anderen Workerknoten zu terminieren, [riegeln Sie den Workerknoten, auf dem sich der VPN-Pod befindet, ab, entleeren sie ihn und starten Sie ihn neu](cs_cli_reference.html#cs_worker_reboot).

<br />


## Bindung eines Service an einen Cluster führt zu Fehler wegen identischer Namen
{: #cs_duplicate_services}

{: tsSymptoms}
Wenn Sie `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` ausführen, wird die folgende Nachricht angezeigt:

```
Multiple services with the same name were found.
Run 'ibmcloud service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
Unter Umständen haben mehrere Serviceinstanzen in unterschiedlichen Regionen denselben Namen.

{: tsResolve}
Verwenden Sie im Befehl `ibmcloud ks cluster-service-bind` die GUID des Service anstelle des Serviceinstanznamens.

1. [Melden Sie sich in der Region an, in der sich die Serviceinstanz befindet, die gebunden werden soll.](cs_regions.html#bluemix_regions)

2. Rufen Sie die GUID für die Serviceinstanz ab.
  ```
  ibmcloud service show <serviceinstanzname> --guid
  ```
  {: pre}

  Ausgabe:
  ```
  Invoking 'cf service <serviceinstanzname> --guid'...
  <serviceinstanz-GUID>
  ```
  {: screen}
3. Binden Sie den Service erneut an den Cluster.
  ```
  ibmcloud ks cluster-service-bind <clustername> <namensbereich> <serviceinstanz-guid>
  ```
  {: pre}

<br />


## Bindung eines Service an einen Cluster führt zu einem Fehler des Typs 'Service nicht gefunden'
{: #cs_not_found_services}

{: tsSymptoms}
Wenn Sie `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` ausführen, wird die folgende Nachricht angezeigt:

```
Binding service to a namespace...
FAILED

The specified IBM Cloud service could not be found. If you just created the service, wait a little and then try to bind it again. To view available IBM Cloud service instances, run 'ibmcloud service list'. (E0023)
```
{: screen}

{: tsCauses}
Um Services an einen Cluster zu binden, müssen Sie über die Benutzerrolle des Cloud Foundry-Entwicklers für den Bereich verfügen, in dem die Serviceinstanz bereitgestellt wurde. Außerdem müssen Sie über die IAM-Editorzugriffsrechte auf {{site.data.keyword.containerlong}} verfügen. Um auf die Serviceinstanz zugreifen zu können, müssen Sie an dem Bereich angemeldet sein, in dem die Serviceinstanz bereitgestellt wurde.

{: tsResolve}

**Als Benutzer:**

1. Melden Sie sich bei {{site.data.keyword.Bluemix_notm}} an.
   ```
   ibmcloud login
   ```
   {: pre}

2. Geben Sie als Ziel die Organisation und den Bereich an, wo die Serviceinstanz bereitgestellt wird.
   ```
   ibmcloud target -o <organisation> -s <bereich>
   ```
   {: pre}

3. Überprüfen Sie, dass sich sich in dem richtigen Bereich befinden, indem Sie Ihre Serviceinstanzen aufführen.
   ```
   ibmcloud service list
   ```
   {: pre}

4. Versuchen Sie, den Service erneut zu binden. Wenn der gleiche Fehler angezeigt wird, wenden Sie sich an den Kontoadministrator und überprüfen Sie, dass Sie über ausreichende Berechtigungen zum Binden von Services verfügen (siehe die folgenden Schritte für den Kontoadministrator).

**Als Kontoadministrator:**

1. Stellen Sie sicher, dass der Benutzer, bei dem dieses Problem auftritt, über [Editorberechtigungen für {{site.data.keyword.containerlong}}](/docs/iam/mngiam.html#editing-existing-access) verfügt.

2. Stellen Sie sicher, dass der Benutzer, bei dem dieses Problem auftritt, über die [Cloud Foundry-Entwicklerrolle für den Bereich](/docs/iam/mngcf.html#updating-cloud-foundry-access) verfügt, für den der Service bereitgestellt wird.

3. Wenn die korrekten Berechtigungen vorhanden sind, versuchen Sie, eine andere Berechtigung zuzuweisen und dann die erforderliche Berechtigung erneut zuzuweisen.

4. Warten Sie einige Minuten und lassen Sie dann den Benutzer versuchen, den Service erneut zu binden.

5. Wenn dadurch das Problem nicht behoben wird, sind die IAM-Berechtigungen nicht synchron und Sie können das Problem nicht selbst lösen. [Wenden Sie sich an den IBM Support](/docs/get-support/howtogetsupport.html#getting-customer-support), indem Sie ein Support-Ticket öffnen. Stellen Sie sicher, dass Sie die Cluster-ID, die Benutzer-ID und die Serviceinstanz-ID bereitstellen.
   1. Rufen Sie die Cluster-ID ab.
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. Rufen Sie die Serviceinstanz-ID ab.
      ```
      ibmcloud service show <servicename> --guid
      ```
      {: pre}


<br />


## Bindung eines Service an einen Cluster führt zu einem Fehler des Typs 'Service unterstützt Serviceschlüssel nicht'
{: #cs_service_keys}

{: tsSymptoms}
Wenn Sie `ibmcloud ks cluster-service-bind <clustername> <namensbereich> <serviceinstanzname>` ausführen, wird die folgende Nachricht angezeigt:

```
Dieser Service unterstützt nicht das Erstellen von Schlüsseln.
```
{: screen}

{: tsCauses}
Bestimmte Services in {{site.data.keyword.Bluemix_notm}}, wie z. B. {{site.data.keyword.keymanagementservicelong}}, unterstützen nicht das Erstellen von Serviceberechtigungsnachweisen, die auch als Serviceschlüssel bezeichnet werden. Ohne die Unterstützung von Serviceschlüsseln kann ein Cluster nicht gebunden werden. Informationen zum Suchen einer Liste von Services, die das Erstellen von Serviceschlüsseln unterstützen, finden Sie unter [Externen Apps die Verwendung von {{site.data.keyword.Bluemix_notm}}-Services ermöglichen](/docs/apps/reqnsi.html#accser_external).

{: tsResolve}
Wenn Sie Services integrieren möchten, die keine Serviceschlüssel unterstützen, überprüfen Sie, ob der Service eine API bereitstellt, die Sie für den direkten Zugriff auf den Service über Ihre App verwenden können. Wenn Sie z. B. {{site.data.keyword.keymanagementservicelong}} verwenden möchten, finden Sie weitere Informationen hierzu in der [API-Referenz![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link") ](https://console.bluemix.net/apidocs/kms?language=curl). 

<br />


## Nachdem ein Workerknoten aktualisiert oder erneut geladen wurde, werden doppelte Knoten und Pods angezeigt
{: #cs_duplicate_nodes}

{: tsSymptoms}
Wenn Sie `kubectl get nodes` ausführen, werden doppelte Workerknoten mit dem Status **NotReady** (Nicht bereit) angezeigt. Die Workerknoten mit dem Status **NotReady** verfügen über öffentliche IP-Adressen, während die Workerknoten mit dem Status **Ready** (Bereit) private IP-Adressen haben.

{: tsCauses}
Bei älteren Clustern wurden Workerknoten anhand der öffentlichen IP-Adresse des Clusters aufgeführt. Nun werden Workerknoten über die private IP-Adresse des Clusters aufgelistet. Wenn Sie einen Knoten erneut laden oder aktualisieren, dann wird die IP-Adresse geändert, der Verweis auf die öffentliche IP-Adresse bleibt jedoch erhalten.

{: tsResolve}
Es treten keine Serviceunterbrechungen aufgrund dieser Duplikate auf, Sie können die alten Workerknotenverweise jedoch vom API-Server entfernen.

  ```
  kubectl delete node <knotenname1> <knotenname2>
  ```
  {: pre}

<br />


## Zugriff auf einen Pod auf einem Workerknoten schlägt mit einer Zeitlimitüberschreitung fehl
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Sie haben einen Workerknoten in Ihrem Cluster gelöscht und dann einen Workerknoten hinzugefügt. Wenn Sie einen Pod oder einen Kubernetes-Service bereitgestellt haben, kann die Ressource nicht auf den neu erstellten Workerknoten zugreifen, und die Verbindung überschreitet das Zeitlimit.

{: tsCauses}
Wenn Sie einen Workerknoten aus Ihrem Cluster löschen und dann einen Workerknoten hinzufügen, kann es sein, dass der neue Workerknoten der privaten IP-Adresse des gelöschten Workerknotens zugeordnet wird. Calico verwendet diese private IP-Adresse als Tag und versucht weiterhin, den gelöschten Knoten zu erreichen.

{: tsResolve}
Aktualisieren Sie die Referenz der privaten IP-Adresse manuell, um auf den korrekten Knoten zu zeigen.

1.  Stellen Sie sicher, dass Sie zwei Workerknoten mit derselben **privaten IP**-Adresse haben. Notieren Sie sich die **private IP** und die **ID** des gelöschten Workers.

  ```
  ibmcloud ks workers <CLUSTERNAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Zone   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.7
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.7
  ```
  {: screen}

2.  Installieren Sie die [Calico-CLI](cs_network_policy.html#adding_network_policies).
3.  Listen Sie die verfügbaren Workerknoten in Calico auf. Ersetzen Sie <dateipfad> durch den lokalen Pfad zur Calico-Konfigurationsdatei.

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Löschen Sie den doppelten Workerknoten in Calico. Ersetzen Sie KNOTEN-ID durch die Workerknoten-ID.

  ```
  calicoctl delete node KNOTEN-ID --config=<dateipfad>/calicoctl.cfg
  ```
  {: pre}

5.  Starten Sie den Workerknoten, der nicht gelöscht wurde, neu.

  ```
  ibmcloud ks worker-reboot CLUSTER-ID KNOTEN-ID
  ```
  {: pre}


Der gelöschte Knoten wird nicht mehr in Calico aufgelistet.

<br />




## Bereitstellen von Pods schlägt wegen einer Sicherheitsrichtlinie für Pods fehl
{: #cs_psp}

{: tsSymptoms}
Nach dem Erstellen eines Pods oder der Ausführung von `kubectl get events` zum Überprüfen, ob ein Pod bereitgestellt wurde, wird eine Fehlernachricht ähnlich der folgenden angezeigt.

```
unable to validate against any pod security policy
```
{: screen}

{: tsCauses}
[Der Zugangscontroller `PodSecurityPolicy`](cs_psp.html) überprüft die Autorisierung des Benutzers oder Servicekontos (z. B. eine Bereitstellung oder 'tiller' von Helm), der bzw. das versuchte, den Pod zu erstellen. Wenn der Benutzer oder das Servicekonto von keiner Sicherheitsrichtlinie für Pods unterstützt wird, verhindert der Zugangscontroller `PodSecurityPolicy` die Erstellung der Pods.

Wenn Sie für die [{{site.data.keyword.IBM_notm}}-Clusterverwaltung](cs_psp.html#ibm_psp) eine der Ressourcen für Sicherheitsrichtlinien für Pods gelöscht haben, treten möglicherweise ähnliche Probleme auf.

{: tsResolve}
Stellen Sie sicher, dass der Benutzer oder das Servicekonto durch eine Pod-Sicherheitsrichtlinie berechtigt ist. Möglicherweise müssen Sie eine [vorhandene Richtlinie ändern](cs_psp.html#customize_psp).

Wenn Sie eine {{site.data.keyword.IBM_notm}} Clusterverwaltungsressource gelöscht haben, müssen Sie den Kubernetes-Master aktualisieren, um ihn wiederherzustellen.

1.  [Wählen Sie als Ziel für Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) Ihren Cluster aus.
2.  Aktualisieren Sie den Kubernetes-Master, um ihn wiederherzustellen.

    ```
    ibmcloud ks apiserver-refresh
    ```
    {: pre}


<br />




## Cluster verbleibt im Wartestatus ('Pending')
{: #cs_cluster_pending}

{: tsSymptoms}
Wenn Sie Ihren Cluster bereitstellen, bleibt dieser im Wartestatus und startet nicht.

{: tsCauses}
Wenn Sie den Cluster gerade erst erstellt haben, werden die Workerknoten möglicherweise noch konfiguriert. Wenn Sie bereits eine Weile warten, ist das VLAN möglicherweise nicht gültig.

{: tsResolve}

Sie können eine der folgenden Lösungen ausprobieren:
  - Überprüfen Sie den Status Ihres Clusters, indem Sie `ibmcloud ks clusters` ausführen. Überprüfen Sie anschließend durch Ausführen von `ibmcloud ks workers <cluster_name>`, dass Ihre Workerknoten bereitgestellt wurden.
  - Überprüfen Sie, ob Ihr VLAN gültig ist. Damit ein VLAN gültig ist, muss es einer Infrastruktur zugeordnet sein, die einen Worker mit lokalem Plattenspeicher hosten kann. Sie können [Ihre VLANs auflisten](/docs/containers/cs_cli_reference.html#cs_vlans), indem Sie den Befehl `ibmcloud ks vlans <zone>` ausführen. Wenn das VLAN nicht in der Liste aufgeführt wird, ist es nicht gültig. Wählen Sie ein anderes VLAN aus.

<br />


## Pods verweilen in  im Status 'Pending' (Anstehend)
{: #cs_pods_pending}

{: tsSymptoms}
Beim Ausführen von `kubectl get pods` verbleiben Pods weiterhin im Status **Pending** (Anstehend).

{: tsCauses}
Wenn Sie den Kubernetes-Cluster gerade erst erstellt haben, werden die Workerknoten möglicherweise noch konfiguriert. 

Falls dieser Cluster bereits vorhanden ist: 
*  Möglicherweise ist in Ihrem Cluster nicht ausreichend Kapazität verfügbar, um den Pod bereitzustellen.
*  Der Pod kann eine Ressourcenanforderung oder einen Grenzwert überschritten haben.

{: tsResolve}
Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_users.html#access_policies) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_users.html#infra_access).

Führen Sie den folgenden Befehl aus, wenn Sie den Kubernetes-Cluster gerade erst erstellt haben. Warten Sie, bis die Workerknoten initialisiert werden.

```
kubectl get nodes
```
{: pre}

Falls dieser Cluster bereits vorhanden ist, prüfen Sie Ihre Clusterkapazität.

1.  Legen Sie die Standardportnummer für den Proxy fest.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Öffnen Sie das Kubernetes-Dashboard.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Überprüfen Sie, ob in Ihrem Cluster ausreichend Kapazität verfügbar ist, um Ihren Pod bereitzustellen.

4.  Wenn Ihr Cluster nicht über ausreichend Kapazität verfügt, ändern Sie die Größe des Worker-Pools, um weitere Knoten hinzuzufügen.

    1.  Prüfen Sie die aktuellen Größen und Maschinentypen Ihrer Worker-Pools, um zu entscheiden, für welche Worker-Pools eine Größenänderung durchgeführt werden soll.

        ```
        ibmcloud ks worker-pools
        ```
        {: pre}

    2.  Ändern Sie die Größe der Worker-Pools, um den einzelnen Zonen, die der Pool umfasst, weitere Knoten hinzuzufügen.

        ```
        ibmcloud ks worker-pool-resize <worker-pool> --cluster <clustername_oder_-id> --size-per-zone <worker_pro_zone>
        ```
        {: pre}

5.  Optional: Überprüfen Sie Ihre Podressourcenanforderungen.

    1.  Vergewissern Sie sich, dass die Werte für `resources.requests` nicht größer sind als die Kapazität des Workerknotens. Beispiel: Wenn die Podanforderung `cpu: 4000m` - oder 4 Kerne - beträgt, der Workerknoten aber nur 2 Kerne umfasst, kann der Pod nicht bereitgestellt werden.

        ```
        kubectl get pod <podname> -o yaml
        ```
        {: pre}
    
    2.  Wenn die Anforderung die verfügbare Kapazität überschreitet, [fügen Sie einen neuen Worker-Pool](cs_clusters.html#add_pool) mit Workerknoten hinzu, die die Anforderung erfüllen können.

6.  Falls Ihre Pods auch weiterhin im Status **Pending** (Anstehend) verweilen, obwohl der Workerknoten voll bereitgestellt wurde, ziehen Sie die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) zurate, um die Ursache für den andauernden Status 'Pending' Ihres Pods zu ermitteln und den Fehler zu beheben.

<br />


## Container werden nicht gestartet
{: #containers_do_not_start}

{: tsSymptoms}
Die Pods wurden erfolgreich auf den Clustern bereitgestellt, aber die Container können nicht gestartet werden.

{: tsCauses}
Die Container werden möglicherweise nicht gestartet, wenn die Registry-Quote erreicht ist.

{: tsResolve}
[Geben Sie Speicherplatz in {{site.data.keyword.registryshort_notm}} frei.](../services/Registry/registry_quota.html#registry_quota_freeup)



<br />


## Ein Helm-Diagramm kann nicht mit aktualisierten Konfigurationswerten installiert werden.
{: #cs_helm_install}

{: tsSymptoms}
Wenn Sie versuchen, ein aktualisiertes Helm-Diagramm zu installieren, indem Sie den Befehl `helm install -f config.yaml --namespace=kube-system --name=<releasename> ibm/<diagrammname>` ausführen, erhalten Sie die Fehlernachricht `Error: failed to download "ibm/<chart_name>"`.

{: tsCauses}
Die URL für das {{site.data.keyword.Bluemix_notm}}-Repository in Ihrer Helm-Instanz ist möglicherweise nicht korrekt.

{: tsResolve}
Gehen Sie wie folgt vor, um Fehler in Ihrem Helm-Diagramm zu beheben:

1. Listen Sie die Repository auf, die aktuell in Ihrer Helm-Instanz verfügbar sind.

    ```
    helm repo list
    ```
    {: pre}

2. Überprüfen Sie in der Ausgabe, dass die URL für das {{site.data.keyword.Bluemix_notm}}-Repository, `ibm`, wie folgt lautet: `https://registry.bluemix.net/helm/ibm`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * Falls die URL falsch ist:

        1. Entfernen Sie das {{site.data.keyword.Bluemix_notm}}-Repository.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Fügen Sie das {{site.data.keyword.Bluemix_notm}}-Repository erneut hinzu.

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * Wenn die URL richtig ist, rufen Sie die aktuellsten Aktualisierung vom Repository ab:

        ```
        helm repo update
        ```
        {: pre}

3. Installieren Sie das Helm-Diagramm mit Ihren Aktualisierungen.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<releasename> ibm/<diagrammname>
    ```
    {: pre}

<br />


## Hilfe und Unterstützung anfordern
{: #ts_getting_help}

Haben Sie noch immer Probleme mit Ihrem Cluster?
{: shortdesc}

-  Sie werden im Terminal benachrichtigt, wenn Aktualisierungen für die `ibmcloud`-CLI und -Plug-ins verfügbar sind. Halten Sie Ihre CLI stets aktuell, sodass Sie alle verfügbaren Befehle und Flags verwenden können.

-   [Überprüfen Sie auf der {{site.data.keyword.Bluemix_notm}}-Statusseite ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/bluemix/support/#status), ob {{site.data.keyword.Bluemix_notm}} verfügbar ist.
-   Veröffentlichen Sie eine Frage im [{{site.data.keyword.containerlong_notm}}-Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com).

    Wenn Sie keine IBM ID für Ihr {{site.data.keyword.Bluemix_notm}}-Konto verwenden, [fordern Sie eine Einladung](https://bxcs-slack-invite.mybluemix.net/) zu diesem Slack an.
    {: tip}
-   Suchen Sie in entsprechenden Foren, ob andere Benutzer auf das gleiche Problem gestoßen sind. Versehen Sie Ihre Fragen in den Foren mit Tags, um sie für das Entwicklungsteam von {{site.data.keyword.Bluemix_notm}} erkennbar zu machen.

    -   Wenn Sie technische Fragen zur Entwicklung oder Bereitstellung von Clustern oder Apps mit {{site.data.keyword.containerlong_notm}} haben, veröffentlichen Sie Ihre Frage auf [Stack Overflow ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) und versehen Sie sie mit den Tags `ibm-cloud`, `kubernetes` und `containers`.
    -   Verwenden Sie bei Fragen zum Service und zu ersten Schritten das Forum [IBM Developer Answers ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Geben Sie die Tags `ibm-cloud` und `containers` an.
    Weitere Details zur Verwendung der Foren finden Sie unter [Hilfe anfordern](/docs/get-support/howtogetsupport.html#using-avatar).

-   Wenden Sie sich an den IBM Support, indem Sie ein Ticket öffnen. Informationen zum Öffnen eines IBM Support-Tickets oder zu Supportstufen und zu Prioritätsstufen von Tickets finden Sie unter [Support kontaktieren](/docs/get-support/howtogetsupport.html#getting-customer-support).

{: tip}
Geben Sie beim Melden eines Problems Ihre Cluster-ID an. Führen Sie den Befehl `ibmcloud ks clusters` aus, um Ihre Cluster-ID abzurufen.

