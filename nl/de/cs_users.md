---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Benutzerzugriff auf Cluster zuweisen
{: #users}

Um sicherzustellen, dass nur autorisierte Benutzer mit dem Cluster arbeiten und Container auf dem Cluster in {{site.data.keyword.containerlong}} bereitstellen können, können Sie Zugriff auf einen Kubernetes-Cluster erteilen.
{:shortdesc}


## Kommunikationsprozesse planen
Als Clusteradministrator sollten Sie sich überlegen, wie Sie einen Kommunikationsprozess für die Mitglieder Ihrer Organisation einrichten können, um Zugriffsanforderungen an Sie zu übermitteln, damit Sie diese gut organisieren können.{:shortdesc}

Stellen Sie Ihren Clusterbenutzern Anweisungen bereit, in denen erläutert wird, wie die Benutzer den Zugriff auf einen Cluster anfordern oder wie sie bei allen allgemeinen Tasks Hilfe von einem Clusteradministrator anfordern können. Da Kubernetes diese Art der Kommunikation nicht vereinfacht, kann jedes Team den bevorzugten Prozess variieren. 

Sie können eine der folgenden Methoden verwenden oder Ihre eigene Methode erstellen. 
- Ticketsystem erstellen
- Formularvorlage erstellen
- Wikiseite erstellen
- E-Mail-Anforderung verlangen
- Verwenden Sie die Problemprotokollierungsmethode, die Sie bereits nutzen, um die tägliche Arbeit Ihres Teams zu überwachen. 


## Clusterzugriff verwalten
{: #managing}

Jedem Benutzer, der mit {{site.data.keyword.containershort_notm}} arbeitet, muss eine Kombination von servicespezifischen Benutzerrollen zugewiesen sein, deren Aktionen der Benutzer ausführen kann.
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien</dt>
<dd>In IAM (Identity and Access Management) bestimmen {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien die Cluster-Management-Aktionen, die Sie in einem Cluster ausführen können, z. B. das Erstellen oder Entfernen von Clustern und das Hinzufügen oder Entfernen von zusätzlichen Workerknoten. Diese Richtlinien müssen in Verbindung mit Infrastrukturrichtlinien gesetzt werden. Sie können Zugriff auf Basis einer Region erteilen. </dd>
<dt>Infrastrukturzugriffsrichtlinien</dt>
<dd>In IAM (Identity and Access Management) ermöglichen Infrastrukturzugriffsrichtlinien, dass die Aktionen, die von der {{site.data.keyword.containershort_notm}}-Benutzerschnittstelle oder -Befehlszeilenschnittstelle angefordert werden, in IBM Cloud Infrastructure (SoftLayer) abgeschlossen werden. Diese Richtlinien müssen in Verbindung mit {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien gesetzt werden. [Weitere Informationen zu den verfügbaren Infrastrukturrollen](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Ressourcengruppen</dt>
<dd>Mit einer Ressourcengruppe können {{site.data.keyword.Bluemix_notm}}-Services in Gruppierungen organisiert werden, sodass Benutzern schnell Zugriff auf mehr als eine Ressource gleichzeitig zugewiesen werden kann. [Erfahren Sie, wie Sie Benutzer anhand von Ressourcengruppen verwalten können](/docs/account/resourcegroups.html#rgs).</dd>
<dt>Cloud Foundry-Rollen</dt>
<dd>In IAM (Identity and Access Management) muss jedem Benutzer eine Cloud Foundry-Benutzerrolle zugewiesen sein. Diese Rolle bestimmt, welche Aktionen der Benutzer für das {{site.data.keyword.Bluemix_notm}}-Konto ausführen kann, z. B. andere Benutzer einladen oder die Kontingentnutzung anzeigen. [Weitere Informationen zu den verfügbaren Cloud Foundry-Rollen](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Kubernetes-RBAC-Rollen</dt>
<dd>Jedem Benutzer, dem eine {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinie zugeordnet ist, ist automatisch auch eine Kubernetes-RBAC-Rolle zugeordnet.  In Kubernetes bestimmen RBAC-Rollen, welche Aktionen Sie für Kubernetes-Ressourcen innerhalb eines Clusters ausführen können. RBAC-Rollen werden nur für die Standardnamensbereiche eingerichtet. Der Clusteradministrator kann RBAC-Rollen für andere Namensbereiche im Cluster hinzufügen. Sehen Sie sich die folgende Tabelle im Abschnitt [Zugriffsrichtlinien und Berechtigungen](#access_policies) an, um zu sehen, welche RBAC-Rolle welcher {{site.data.keyword.containershort_notm}} -Zugriffsrichtlinie entspricht. Weitere allgemeine Informationen zu RBAC-Rollen finden Sie unter [![](../icons/launch-glyph.svg "")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)</dd>
</dl>

<br />


## Zugriffsrichtlinien und -berechtigungen
{: #access_policies}

Überprüfen Sie die Zugriffsrichtlinien und die Berechtigungen, die Sie Benutzern in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto erteilen können.
{:shortdesc}

Der Rolle des {{site.data.keyword.Bluemix_notm}}-IAM-Operators (IAM, Identity Access and Management) und des -Bearbeiters sind unterschiedliche Berechtigungen zugewiesen. Wenn ein Benutzer Workerknoten hinzufügen und Services binden soll, müssen Sie ihm sowohl die Operator- als auch die Bearbeiterrolle zuordnen. Weitere Einzelheiten zu den Zugriffsrichtlinien für die entsprechende Infrastruktur finden Sie unter [Infrastrukturberechtigungen für einen Benutzer anpassen](#infra_access). <br/><br/>Wenn Sie die Zugriffsrichtlinie für einen Benutzer ändern, werden die RBAC-Richtlinien, die der Änderung in Ihrem Cluster zugeordnet sind, für Sie bereinigt. </br></br>**Anmerkung:** Wenn Sie die Berechtigungen herunterstufen, z. B. wenn Sie einen Zugriff für die Anzeigefunktion einem früheren Clusteradministrator zuordnen möchten, müssen Sie einige Minuten warten, bis der Downgrade abgeschlossen ist.

|{{site.data.keyword.containershort_notm}}-Zugriffsrichtlinie|Cluster-Management-Berechtigungen|Kubernetes-Ressourcenberechtigungen|
|-------------|------------------------------|-------------------------------|
|Administrator|Diese Rolle erbt die Berechtigungen von den Rollen 'Editor (Bearbeiter)', 'Bediener (Operator)' und 'Viewer (Anzeigeberechtigter)' für alle Cluster in diesem Konto. <br/><br/>Bei Festlegung für alle aktuellen Serviceinstanzen:<ul><li>Erstellen eines kostenlosen Clusters oder Standardclusters</li><li>Festlegen von Berechtigungsnachweisen für ein {{site.data.keyword.Bluemix_notm}}-Konto, um auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) zuzugreifen</li><li>Entfernen eines Clusters</li><li>Zuordnen und Ändern von {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien für andere vorhandene Benutzer in diesem Konto</li></ul><p>Bei Festlegung für eine bestimmte Cluster-ID:<ul><li>Entfernen eines bestimmten Clusters</li></ul></p>Entsprechende Infrastrukturzugriffsrichtlinie: Superuser<br/><br/><strong>Hinweis</strong>: Zum Erstellen von Ressourcen wie Maschinen, VLANs und Teilnetze benötigen Benutzer die Infrastrukturrolle **Superuser**.|<ul><li>RBAC-Rolle: cluster-admin</li><li>Schreib-/Lesezugriff auf Ressourcen in allen Namensbereichen</li><li>Erstellen von Rollen innerhalb eines Namensbereichs</li><li>Zugriff auf das Kubernetes-Dashboard</li><li>Erstellen einer Ingress-Ressource zur öffentlichen Bereitstellung von Apps</li></ul>|
|Operator|<ul><li>Hinzufügen zusätzlicher Workerknoten zu einem Cluster</li><li>Entfernen von Workerknoten aus einem Cluster</li><li>Neustarten eines Workerknotens</li><li>Neuladen eines Workerknotens</li><li>Hinzufügen eines Teilnetzes zu einem Cluster</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: [Angepasst](#infra_access)</p>|<ul><li>RBAC-Rolle: admin</li><li>Schreib-/Lesezugriff auf Ressourcen innerhalb von Standardnamensbereichen, aber nicht auf den Namensbereich selbst</li><li>Erstellen von Rollen innerhalb eines Namensbereichs</li></ul>|
|Editor <br/><br/><strong>Tipp</strong>: Verwenden Sie diese Rolle für App-Entwickler.|<ul><li>Binden eines {{site.data.keyword.Bluemix_notm}}-Service an einen Cluster</li><li>Auflösen einer Bindung eines {{site.data.keyword.Bluemix_notm}}-Service an einen Cluster</li><li>Erstellen eines Webhooks</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: [Angepasst](#infra_access)|<ul><li>RBAC-Rolle: edit</li><li>Schreib-/Lesezugriff auf Ressourcen innerhalb von Standardnamensbereichen</li></ul></p>|
|Viewer|<ul><li>Auflisten eines Clusters</li><li>Anzeigen von Details für einen Cluster</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: Nur anzeigen</p>|<ul><li>RBAC-Rolle: view</li><li>Lesezugriff auf Ressourcen innerhalb des Standardnamensbereichs</li><li>Kein Lesezugriff auf geheime Kubernetes-Schlüssel</li></ul>|

|Cloud Foundry-Zugriffsrichtlinie|Kontoverwaltungsberechtigungen|
|-------------|------------------------------|
|Organisationsrolle: Manager|<ul><li>Hinzufügen zusätzlicher Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto</li></ul>| |
|Bereichsrolle: Entwickler|<ul><li>Erstellen von {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen</li><li>Binden von {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen an Cluster</li></ul>| 

<br />



## Erklärung des IAM-API-Schlüssels und des Befehls `bx cs credentials-set`
{: #api_key}

Um erfolgreich Cluster bereitzustellen und mit diesen zu arbeiten, müssen Sie sicherstellen, dass Ihr Konto korrekt für den Zugriff auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) konfiguriert wurde. Abhängig von der Konfiguration Ihres Kontos verwenden Sie entweder den IAM-API-Schlüssel oder die Berechtigungsnachweise der Infrastruktur, die Sie manuell mithilfe des Befehls `bx cs credentials-set` definiert haben. 

<dl>
  <dt>IAM-API-Schlüssel</dt>
  <dd>Der IAM-API-Schlüssel (IAM, Identity and Access Management) wird automatisch für eine Region festgelegt, wenn die erste Aktion ausgeführt wird, für die die {{site.data.keyword.containershort_notm}}-Administratorzugriffsrichtlinie ausgeführt werden muss. Zum Beispiel erstellt einer Ihrer Benutzer mit Administratorberechtigung den ersten Cluster in der Region <code>Vereinigte Staaten (Süden)</code>. Dadurch wird der IAM-API-Schlüssel für diesen Benutzer in dem Konto für diese Region gespeichert. Der API-Schlüssel wird verwendet, um IBM Cloud Infrastructure (SoftLayer) wie beispielsweise neue Workerknoten oder VLANs zu bestellen. </br></br>
Wenn ein anderer Benutzer eine Aktion in dieser Region ausführt, die eine Interaktion mit dem Portfolio der IBM Cloud-Infrastruktur (SoftLayer) erfordert, wie z. B. die Erstellung eines neuen Clusters oder das erneute Laden eines Workerknotens, wird der gespeicherte API-Schlüssel verwendet, um festzustellen, ob ausreichende Berechtigungen vorhanden sind, um diese Aktion auszuführen. Um sicherzustellen, dass infrastrukturbezogene Aktionen in Ihrem Cluster erfolgreich ausgeführt werden können, ordnen Sie Ihre {{site.data.keyword.containershort_notm}}-Benutzer mit Administratorberechtigung der Infrastrukturzugriffsrichtlinie <strong>Superuser</strong> zu. </br></br>Sie können aktuelle Eigner von API-Schlüsseln finden, indem Sie den Befehl [<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info) ausführen. Wenn Sie feststellen, dass Sie den API-Schlüssel aktualisieren müssen, der für eine Region gespeichert ist, können Sie dies tun, indem Sie den Befehl [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) ausführen. Dieser Befehl erfordert die {{site.data.keyword.containershort_notm}}-Administratorzugriffsrichtlinie und speichert den API-Schlüssel des Benutzers, der diesen Befehl ausführt, im Konto. </br></br> <strong>Hinweis:</strong> Der API-Schlüssel, der für die Region gespeichert ist, wird möglicherweise nicht verwendet, falls die Berechtigungsnachweise für die IBM Cloud-Infrastruktur (SoftLayer) manuell durch Verwendung des Befehls <code>bx cs credentials-set</code> festgelegt wurden.</dd>
<dt>Berechtigungsnachweise für IBM Cloud Infrastructure (SoftLayer) über <code>bx cs credentials-set</code></dt>
<dd>Wenn Sie über ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto verfügen, haben Sie standardmäßig Zugriff auf das Portfolio der IBM Cloud-Infrastruktur. Es kann jedoch sein, dass Sie ein anderes IBM Cloud-Infrastrukturkonto (SoftLayer) verwenden möchten, das Sie bereits für die Infrastrukturbestellung verwenden. Sie können dieses Infrastrukturkonto mit Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verbinden, indem Sie den Befehl [<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set) verwenden. </br></br>Falls Berechtigungsnachweise für IBM Cloud Infrastructure (SoftLayer) manuell definiert wurden, werden diese Berechtigungsnachweise für die Bestellung von Infrastruktur verwendet, selbst wenn bereits ein IAM-API-Schlüssel für das Konto vorhanden ist. Wenn der Benutzer, dessen Berechtigungsnachweise gespeichert wurden, nicht über die erforderlichen Berechtigungen zum Bestellen von Infrastruktur verfügt, können infrastrukturbezogene Aktionen, wie z. B. das Erstellen eines Clusters oder das erneute Laden eines Workerknotens, fehlschlagen. </br></br> Um Berechtigungsnachweise für IBM Cloud Infrastructure (SoftLayer) zu entfernen, die manuell definiert wurden, können Sie den Befehl [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) verwenden. Nachdem die Berechtigungsnachweise entfernt wurden, wird der IAM-API-Schlüssel verwendet, um Infrastruktur zu bestellen. </dd>
</dl>

## Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen
{: #add_users}

Sie können Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen, um ihnen Zugriff auf Ihren Cluster zu gewähren.{:shortdesc}

Zunächst müssen Sie sicherstellen, dass Ihnen die Cloud Foundry-Rolle 'Manager' für ein {{site.data.keyword.Bluemix_notm}}-Konto zugeordnet wurde.

1.  [Fügen Sie den Benutzer zum Konto hinzu](../iam/iamuserinv.html#iamuserinv).
2.  Erweitern Sie im Abschnitt **Zugriff** den Eintrag **Services**.
3.  Weisen Sie eine {{site.data.keyword.containershort_notm}}-Zugriffsrolle zu. Wählen Sie in der Dropdown-Liste **Zugriff zuweisen zu** aus, ob Sie Zugriff nur Ihrem {{site.data.keyword.containershort_notm}}-Konto (**Ressource**) oder einer Reihe verschiedener Ressourcen in Ihrem Konto (**Ressourcengruppe**) gewähren möchten.
  -  Für **Ressource**:
      1. Wählen Sie in der Dropdown-Liste **Services** den Eintrag **{{site.data.keyword.containershort_notm}}** aus.
      2. Wählen Sie aus der Dropdown-Liste **Region** die Region aus, der der Benutzer angehören soll. **Hinweis**: Weitere Informationen für den Zugriff auf Cluster in der [Region 'Asien-Pazifik (Norden)'](cs_regions.html#locations) finden Sie unter [IAM-Zugriff für Benutzer auf Cluster innerhalb der Region 'Asien-Pazifik (Norden)' erteilen](#iam_cluster_region).
      3. Wählen Sie aus der Dropdown-Liste **Serviceinstanz** den Cluster aus, dem der Benutzer angehören soll. Führen Sie `bx cs clusters` aus, um die ID eines bestimmten Clusters zu finden.
      4. Wählen Sie im Abschnitt **Rollen auswählen** eine Rolle aus. Eine Liste von unterstützten Aktionen pro Rolle finden Sie unter [Zugriffsrichtlinien und -berechtigungen](#access_policies).
  - Für **Ressourcengruppe**:
      1. Wählen Sie aus der Dropdown-Liste **Ressourcengruppe** die Ressourcengruppe aus, die Berechtigungen für die {{site.data.keyword.containershort_notm}}-Ressource Ihres Kontos enthält.
      2. Wählen Sie aus der Dropdown-Liste **Zugriff für eine Ressourcengruppe zuweisen** zu einer Ressourcengruppe eine Rolle aus. Eine Liste von unterstützten Aktionen pro Rolle finden Sie unter [Zugriffsrichtlinien und -berechtigungen](#access_policies).
4. [Optional: Weisen Sie eine Cloud Foundry-Rolle zu](/docs/iam/mngcf.html#mngcf).
5. [Optional: Weisen Sie eine Infrastrukturrolle zu](/docs/iam/infrastructureaccess.html#infrapermission).
6. Klicken Sie auf **Benutzer einladen**.

<br />


### IAM-Zugriff für Benutzer auf Cluster innerhalb der Region 'Asien-Pazifik (Norden)' erteilen
{: #iam_cluster_region}

Wenn Sie [Benutzer zu Ihrem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen](#add_users), wählen Sie die Regionen aus, zu denen diese Zugriff erteilt bekommen haben. Eventuell sind einige Regionen wie 'Asien-Pazifik (Norden)' nicht in der Konsole verfügbar und müssen mithilfe der CLI hinzugefügt werden.
{:shortdesc}

Zunächst müssen Sie sicherstellen, dass Sie Administrator für das {{site.data.keyword.Bluemix_notm}}-Konto sind. 

1.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Wählen Sie das Konto aus, das Sie verwenden möchten. 

    ```
    bx login [--sso]
    ```
    {: pre}

    **Hinweis:** Falls Sie über eine eingebundene ID verfügen, geben Sie `bx login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer eingebundenen ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

2.  Geben Sie die Umgebung an, für die Sie Berechtigungen erteilen möchten, z. B. die Region 'Asien-Pazifik (Norden)' (`jp-tok`). Weitere Einzelheiten zu den Befehlsoptionen wie z. B. Organisation und Bereich finden Sie in der Dokumentation zum [Befehl `bluemix target`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target).

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  Rufen Sie die Namen oder IDs der Cluster der Region ab, auf die Sie Zugriff erteilen wollen. 

    ```
    bx cs clusters
    ```
    {: pre}

4.  Rufen Sie die Benutzer-IDs ab, denen Sie Zugriff erteilen wollen.

    ```
    bx account users
    ```
    {: pre}

5.  Wählen Sie die Rollen für die Zugriffsrichtlinie aus.

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  Erteilen Sie mit der entsprechenden Rolle den Benutzerzugriff für den Cluster. In diesem Beispiel wird `user@example.com` die Rolle `Operator` und `Editor` für drei Cluster erteilt. 

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    Um Zugriff auf vorhandene und zukünftige Cluster in der Region zu erteilen, geben Sie das Flag `--service-instance` nicht an. Weitere Informationen finden Sie in der Dokumentation zum [Befehl `bluemix iam user-policy-create`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create).
    {:tip}

## Infrastrukturberechtigungen für einen Benutzer anpassen
{: #infra_access}

Wenn Sie Infrastrukturrichtlinien in IAM (Identity and Access Management) konfigurieren, werden einem Benutzer mit einer Rolle verknüpfte Berechtigungen zugewiesen. Um diese Berechtigungen anzupassen, müssen Sie sich bei IBM Cloud Infrastructure (SoftLayer) anmelden und die Berechtigungen dort anpassen.{: #view_access}

**Basisbenutzer** können beispielsweise einen Workerknoten neu starten, ihn aber nicht neu laden. Ohne diesen Benutzern **Superuser**-Berechtigungen zuzuweisen, können Sie die Berechtigungen der IBM Cloud Infrastructure (SoftLayer) anpassen und die Berechtigung zum Ausführen eines Neuladen-Befehls hinzufügen.

1.  Melden Sie sich bei Ihrem [ {{site.data.keyword.Bluemix_notm}}-Konto](https://console.bluemix.net/) an und wählen Sie dann im Menü **Infrastruktur** aus.

2.  Wählen Sie **Konto** > **Benutzer** > **Benutzerliste** aus.

3.  Um die Berechtigungen zu ändern, wählen Sie den Namen des Benutzerprofils oder die Spalte **Gerätezugriff** aus. 

4.  Passen Sie auf der Registerkarte **Portalberechtigungen** den Benutzerzugriff an. Die Berechtigungen, die die Benutzer benötigen, sind davon abhängig, welche Infrastrukturressourcen sie verwenden müssen:

    * Verwenden Sie die Dropdown-Liste **Schnellberechtigungen**, um die Rolle **Superuser** zuzuordnen, die dem Benutzer alle Berechtigungen erteilt. 
    * Verwenden Sie die Dropdown-Liste **Schnellberechtigungen**, um die Rolle **Basisbenutzer** zuzuordnen, die dem Benutzer einige aber nicht alle benötigten Berechtigungen erteilt. 
    * Wenn Sie nicht alle Berechtigungen mit der Rolle **Superuser** erteilen möchten oder wenn Sie weitere Berechtigungen über die Rolle **Basisbenutzer** hinaus erteilen möchten, lesen Sie in der folgenden Tabelle nach. Sie beschreibt die erforderlichen Berechtigungen zum Ausführen allgemeiner Tasks in {{site.data.keyword.containershort_notm}}.

    <table summary="Infrastrukturberechtigungen für allgemeine {{site.data.keyword.containershort_notm}}-Szenarios.">
     <caption>Allgemein erforderliche Infrastrukturberechtigungen für {{site.data.keyword.containershort_notm}}</caption>
     <thead>
     <th>Allgemeine Tasks in {{site.data.keyword.containershort_notm}}</th>
     <th>Erforderliche Infrastrukturberechtigungen nach Registerkarte</th>
     </thead>
     <tbody>
     <tr>
     <td><strong>Mindestberechtigungen</strong>: <ul><li>Erstellen Sie einen Cluster.</li></ul></td>
     <td><strong>Geräte</strong>: <ul><li>Details zum virtuellen Server anzeigen</li><li>Server neu starten und IPMI-Systeminformationen anzeigen</li><li>Befehle zum erneuten Laden des Betriebssystems absetzen und Rescue-Kernel initiieren</li></ul><strong>Konto</strong>: <ul><li>Cloudinstanzen hinzufügen/aktualisieren</li><li>Server hinzufügen</li></ul></td>
     </tr>
     <tr>
     <td><strong>Clusterverwaltung</strong>: <ul><li>Cluster erstellen, aktualisieren und löschen.</li><li>Workerknoten hinzufügen, erneut laden und neu starten.</li><li>VLANs anzeigen.</li><li>Teilnetze erstellen-</li><li>Pods und Lastausgleichsservices  bereitstellen.</li></ul></td>
     <td><strong>Support</strong>: <ul><li>Tickets anzeigen</li><li>Tickets hinzufügen</li><li>Tickets bearbeiten</li></ul>
     <strong>Geräte</strong>: <ul><li>Details zum virtuellen Server anzeigen</li><li>Server neu starten und IPMI-Systeminformationen anzeigen</li><li>Upgrade für Server durchführen</li><li>Befehle zum erneuten Laden des Betriebssystems absetzen und Rescue-Kernel initiieren</li></ul>
     <strong>Services</strong>: <ul><li>SSH-Schlüssel verwalten</li></ul>
     <strong>Konto</strong>: <ul><li>Kontozusammenfassung anzeigen</li><li>Cloudinstanzen hinzufügen/aktualisieren</li><li>Server abbrechen</li><li>Server hinzufügen</li></ul></td>
     </tr>
     <tr>
     <td><strong>Speicher</strong>: <ul><li>Persistente Datenträgeranforderungen zur Bereitstellung von persistenten Datenträgern erstellen</li><li>Speicherinfrastrukturressourcen erstellen und verwalten.</li></ul></td>
     <td><strong>Services</strong>: <ul><li>Speicher verwalten</li></ul><strong>Konto</strong>: <ul><li>Speicher hinzufügen</li></ul></td>
     </tr>
     <tr>
     <td><strong>Privates Netz</strong>: <ul><li>Private VLANs für Netzbetrieb im Cluster verwalten</li><li>VPN-Konnektivität für private Netze konfigurieren</li></ul></td>
     <td><strong>Netz</strong>: <ul><li>Teilnetzrouten im Netz verwalten</li><li>VLAN-Spanning im Netz verwalten</li><li>IPSEC-Netztunnel verwalten</li><li>Netzgateways verwalten</li><li>VPN-Verwaltung</li></ul></td>
     </tr>
     <tr>
     <td><strong>Öffentliches Netz</strong>: <ul><li>Richten Sie eine öffentliche Lastausgleichsfunktion oder das Ingress-Networking ein, um Apps bereitzustellen.</li></ul></td>
     <td><strong>Geräte</strong>: <ul><li>Lastausgleichsfunktionen verwalten</li><li>Hostname/Domäne bearbeiten</li><li>Portsteuerung verwalten</li></ul>
     <strong>Netz</strong>: <ul><li>Berechnen mit öffentlichem Netzport hinzufügen</li><li>Teilnetzrouten im Netz verwalten</li><li>VLAN-Spanning im Netz verwalten</li><li>IP-Adressen hinzufügen</li></ul>
     <strong>Services</strong>: <ul><li>DNS, Reverse DNS und WHOIS verwalten</li><li>Zertifikate anzeigen (SSL)</li><li>Zertifikate verwalten (SSL)</li></ul></td>
     </tr>
     </tbody></table>

5.  Klicken Sie zum Speichern Ihrer Änderungen auf **Portalberechtigungen bearbeiten**.

6.  Wählen Sie auf der Registerkarte **Gerätezugriff** die Geräte aus, für die Zugriff erteilt werden soll. 

    * In der Dropdown-Liste **Gerätetyp** können Sie Zugriff auf **Alle virtuellen Server** erteilen.
    * Um Benutzern Zugriff auf neue Geräte zu erteilen, die erstellt wurden, markieren Sie **Der Zugriff wird automatisch erteilt, wenn neue Geräte hinzugefügt werden**.
    * Klicken Sie zum Speichern Ihrer Änderungen auf **Gerätezugriff aktualisieren**.

7.  Kehren Sie zur Liste der Benutzerprofile zurück und überprüfen Sie, dass **Gerätezugriff** erteilt wurde. 

## Benutzer mit angepassten Kubernetes-RBAC-Rollen berechtigen
{: #rbac}

{{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien entsprechen bestimmten rollenbasierten Kubernetes-RBAC-Rollen (RBAC; Role-Based Access Control), die  in [Zugriffsrichtlinien und Berechtigungen](#access_policies) beschrieben werden. Wenn Sie andere Kubernetes-Rollen berechtigen möchten, die sich von der entsprechenden Zugriffsrichtlinie unterscheiden, können Sie RBAC-Rollen anpassen und die Rollen dann Einzelpersonen oder Benutzergruppen zuordnen.{: shortdesc}

Beispiel: Sie möchten einem Team von Entwicklern die Berechtigung erteilen, an einer bestimmten API-Gruppe oder mit Ressourcen innerhalb eines Kubernetes-Namensbereichs im Cluster zu arbeiten, aber nicht über den gesamten Cluster. Sie erstellen eine Rolle und binden dann die Rolle an Benutzer, indem Sie einen Benutzernamen verwenden, der für {{site.data.keyword.containershort_notm}} eindeutig ist. Weitere Informationen finden Sie unter [Verwendung von RBAC-Autorisierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) in der Kubernetes-Dokumentation.

Führen Sie zunächst folgende Schritte aus. [Richten Sie die Kubernetes-CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

1.  Erstellen Sie die Rolle mit dem Zugriff, den Sie erteilen möchten.

    1. Erstellen Sie eine `.yaml`-Datei, um die Rolle mit dem Zugriff zu definieren, den Sie erteilen möchten. 

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>Tabelle. Erklärung dieser YAML-Komponenten</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung dieser YAML-Komponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Verwenden Sie `Role`, um Zugriff auf die Ressourcen in einem einzelnen Namensbereich zu erteilen, oder `ClusterRole` für clusterweite Ressourcen. </td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Für Cluster, die Kubernetes 1.8 oder höher ausführen, verwenden Sie `rbac.authorization.k8s.io/v1`. </li><li>Für ältere Versionen verwenden Sie `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Für `Role` kind: Geben Sie den Kubernetes-Namensbereich an, für den der Zugriff erteilt wird. </li><li>Verwenden Sie das Feld `namespace` nicht, wenn Sie eine Clusterrolle erstellen (`ClusterRole`), die auf Clusterebene gilt. </li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Benennen Sie die Rolle und verwenden Sie den Namen später, wenn Sie die Rolle binden. </td>
        </tr>
        <tr>
        <td><code>rules/apiGroups</code></td>
        <td><ul><li>Geben Sie die Kubernetes-API-Gruppen an, mit denen Benutzer interagieren können sollen. Zum Beispiel `"apps"`, `"batch"` oder `"extensions"`. </li><li>Für den Zugriff auf die Gruppe der API-Kerndefinitionen im REST-Pfad `api/v1` lassen Sie die Angabe für die Gruppe leer `[""]`. </li><li>Weitere Informationen finden Sie unter [API-Gruppen![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/api-overview/#api-groups) in der Kubernetes-Dokumentation.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>Geben Sie die Kubernetes-Ressourcen an, auf die Sie Zugriff erteilen möchten, z. B. `"daemonsets"`, `"deployments"`, `"events"` oder `"ingresses"`. </li><li>Falls Sie `"nodes"` angeben, muss als Rollentyp `ClusterRole` angegeben werden. </li><li>Eine Liste der Ressourcen finden Sie in der Tabelle der [Ressourcentypen![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) auf dem Kubernetes-Spickzettel. </li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>Geben Sie die Typen von Aktionen an, die Benutzer ausführen können sollen, z. B. `"get"`, `"list"`, `"describe"`, `"create"` oder `"delete"`. </li><li>Eine vollständige Liste der Verben finden Sie in der Dokumentation unter [`kubectl`![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).</li></ul></td>
        </tr>
        </tbody>
        </table>

    2.  Erstellen Sie die Rolle in Ihrem Cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Überprüfen Sie, dass die Rolle erstellt wurde. 

        ```
        kubectl get roles
        ```
        {: pre}

2.  Binden Sie Benutzer an die Rolle. 

    1. Erstellen Sie eine `.yaml`-Datei, um Benutzer an Ihre Rolle zu binden. Notieren Sie die eindeutige URL, die für die einzelnen Namen des jeweiligen Subjekts verwendet werden soll

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Tabelle. Erklärung dieser YAML-Komponenten</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung dieser YAML-Komponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Geben Sie für `kind` für beide Typen der `.yaml`-Rollendateien `RoleBinding` an: Namensbereich - `Role` und clusterweit - `ClusterRole`. </td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Für Cluster, die Kubernetes 1.8 oder höher ausführen, verwenden Sie `rbac.authorization.k8s.io/v1`. </li><li>Für ältere Versionen verwenden Sie `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Für `Role` kind: Geben Sie den Kubernetes-Namensbereich an, für den der Zugriff erteilt wird. </li><li>Verwenden Sie das Feld `namespace` nicht, wenn Sie eine Clusterrolle erstellen (`ClusterRole`), die auf Clusterebene gilt. </li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Geben Sie der Rollenbindung einen Namen. </td>
        </tr>
        <tr>
        <td><code>subjects/kind</code></td>
        <td>Geben Sie für 'kind' `User` an.</td>
        </tr>
        <tr>
        <td><code>subjects/name</code></td>
        <td><ul><li>Hängen Sie die E-Mailadresse des Benutzers an die folgende URL an: `https://iam.ng.bluemix.net/kubernetes#`. </li><li>Beispiel: `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li></ul></td>
        </tr>
        <tr>
        <td><code>subjects/apiGroup</code></td>
        <td>Verwenden Sie `rbac.authorization.k8s.io`.</td>
        </tr>
        <tr>
        <td><code>roleRef/kind</code></td>
        <td>Geben Sie denselben Wert als `kind` in der `.yaml`-Rollendatei an: `Role` oder `ClusterRole`.</td>
        </tr>
        <tr>
        <td><code>roleRef/name</code></td>
        <td>Geben Sie den Namen der `.yaml`-Rollendatei an. </td>
        </tr>
        <tr>
        <td><code>roleRef/apiGroup</code></td>
        <td>Verwenden Sie `rbac.authorization.k8s.io`.</td>
        </tr>
        </tbody>
        </table>

    2. Erstellen Sie die Ressource für die Rollenbindung in Ihrem Cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Überprüfen Sie, dass die Bindung erstellt wurde. 

        ```
        kubectl get rolebinding
        ```
        {: pre}

Jetzt, nachdem Sie eine angepasste Kubernetes-RBAC-Rolle erstellt und gebunden haben, fahren Sie mit den Benutzern fort. Bitten Sie sie, eine Aktion auszuführen, für deren Ausführung sie die Berechtigung aufgrund Ihrer Rolle haben. Zum Beispiel das Löschen eines Pods. 
