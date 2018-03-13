---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

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

Um sicherzustellen, dass nur autorisierte Benutzer mit dem Cluster arbeiten und Apps auf dem Cluster bereitstellen können, können Sie anderen Benutzern in Ihrer Organisation Zugriff auf einen Cluster erteilen.
{:shortdesc}


## Clusterzugriff verwalten
{: #managing}

Jedem Benutzer, der mit {{site.data.keyword.containershort_notm}} arbeitet, muss eine Kombination von servicespezifischen Benutzerrollen zugewiesen sein, deren Aktionen der Benutzer ausführen kann.
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien</dt>
<dd>In IAM (Identity and Access Management) bestimmen {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien die Cluster-Management-Aktionen, die Sie in einem Cluster ausführen können, z. B. das Erstellen oder Entfernen von Clustern und das Hinzufügen oder Entfernen von zusätzlichen Workerknoten. Diese Richtlinien müssen in Verbindung mit Infrastrukturrichtlinien gesetzt werden.</dd>
<dt>Infrastrukturzugriffsrichtlinien</dt>
<dd>In IAM (Identity and Access Management) ermöglichen Infrastrukturzugriffsrichtlinien, dass die Aktionen, die von der {{site.data.keyword.containershort_notm}}-Benutzerschnittstelle oder -Befehlszeilenschnittstelle angefordert werden, in IBM Cloud Infrastructure (SoftLayer) abgeschlossen werden. Diese Richtlinien müssen in Verbindung mit {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien gesetzt werden. [Weitere Informationen zu den verfügbaren Infrastrukturrollen](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Ressourcengruppen</dt>
<dd>Mit einer Ressourcengruppe können {{site.data.keyword.Bluemix_notm}}-Services in Gruppierungen organisiert werden, sodass Benutzern schnell Zugriff auf mehr als eine Ressource gleichzeitig zugewiesen werden kann. [Erfahren Sie, wie Sie Benutzer anhand von Ressourcengruppen verwalten können](/docs/account/resourcegroups.html#rgs).</dd>
<dt>Cloud Foundry-Rollen</dt>
<dd>In IAM (Identity and Access Management) muss jedem Benutzer eine Cloud Foundry-Benutzerrolle zugewiesen sein. Diese Rolle bestimmt, welche Aktionen der Benutzer für das {{site.data.keyword.Bluemix_notm}}-Konto ausführen kann, z. B. andere Benutzer einladen oder die Kontingentnutzung anzeigen. [Weitere Informationen zu den verfügbaren Cloud Foundry-Rollen](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Kubernetes-RBAC-Rollen</dt>
<dd>Jedem Benutzer, dem eine {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinie zugeordnet ist, ist automatisch auch eine Kubernetes-RBAC-Rolle zugeordnet. In Kubernetes bestimmen RBAC-Rollen, welche Aktionen Sie für Kubernetes-Ressourcen innerhalb eines Clusters ausführen können. RBAC-Rollen werden nur für die Standardnamensbereiche eingerichtet. Der Clusteradministrator kann RBAC-Rollen für andere Namensbereiche im Cluster hinzufügen. Weitere Informationen finden Sie im Kapitel zur [Verwendung von RBAC-Autorisierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) in der Kubernetes-Dokumentation.</dd>
</dl>

<br />


## Zugriffsrichtlinien und -berechtigungen
{: #access_policies}

Überprüfen Sie die Zugriffsrichtlinien und die Berechtigungen, die Sie Benutzern in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto erteilen können. Der Rolle des Operators und des Bearbeiters sind unterschiedliche Berechtigungen zugewiesen. Wenn ein Benutzer Workerknoten hinzufügen und Services binden soll, müssen Sie ihm sowohl die Operator- als auch die Bearbeiterrolle zuordnen. Wenn Sie die Zugriffsrichtlinie für einen Benutzer ändern, bereinigt {{site.data.keyword.containershort_notm}} die RBAC-Richtlinien, die der Änderung in Ihrem Cluster zugeordnet sind.

|{{site.data.keyword.containershort_notm}}-Zugriffsrichtlinie|Cluster-Management-Berechtigungen|Kubernetes-Ressourcenberechtigungen|
|-------------|------------------------------|-------------------------------|
|Administrator|Diese Rolle erbt die Berechtigungen von den Rollen 'Editor (Bearbeiter)', 'Bediener (Operator)' und 'Viewer (Anzeigeberechtigter)' für alle Cluster in diesem Konto. <br/><br/>Bei Festlegung für alle aktuellen Serviceinstanzen:<ul><li>Erstellen eines kostenlosen Clusters oder Standardclusters</li><li>Festlegen von Berechtigungsnachweisen für ein {{site.data.keyword.Bluemix_notm}}-Konto, um auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) zuzugreifen</li><li>Entfernen eines Clusters</li><li>Zuordnen und Ändern von {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien für andere vorhandene Benutzer in diesem Konto</li></ul><p>Bei Festlegung für eine bestimmte Cluster-ID:<ul><li>Entfernen eines bestimmten Clusters</li></ul></p>Entsprechende Infrastrukturzugriffsrichtlinie: Superuser<br/><br/><b>Hinweis</b>: Zum Erstellen von Ressourcen wie Maschinen, VLANs und Teilnetze benötigen Benutzer die Infrastrukturrolle **Superuser**.|<ul><li>RBAC-Rolle: cluster-admin</li><li>Schreib-/Lesezugriff auf Ressourcen in allen Namensbereichen</li><li>Erstellen von Rollen innerhalb eines Namensbereichs</li><li>Zugriff auf das Kubernetes-Dashboard</li><li>Erstellen einer Ingress-Ressource zur öffentlichen Bereitstellung von Apps</li></ul>|
|Operator|<ul><li>Hinzufügen zusätzlicher Workerknoten zu einem Cluster</li><li>Entfernen von Workerknoten aus einem Cluster</li><li>Neustarten eines Workerknotens</li><li>Neuladen eines Workerknotens</li><li>Hinzufügen eines Teilnetzes zu einem Cluster</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: Basisbenutzer</p>|<ul><li>RBAC-Rolle: admin</li><li>Schreib-/Lesezugriff auf Ressourcen innerhalb von Standardnamensbereichen, aber nicht auf den Namensbereich selbst</li><li>Erstellen von Rollen innerhalb eines Namensbereichs</li></ul>|
|Editor <br/><br/><b>Tipp</b>: Verwenden Sie diese Rolle für App-Entwickler.|<ul><li>Binden eines {{site.data.keyword.Bluemix_notm}}-Service an einen Cluster</li><li>Auflösen einer Bindung eines {{site.data.keyword.Bluemix_notm}}-Service an einen Cluster</li><li>Erstellen eines Webhooks</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: Basisbenutzer|<ul><li>RBAC-Rolle: edit</li><li>Schreib-/Lesezugriff auf Ressourcen innerhalb von Standardnamensbereichen</li></ul></p>|
|Viewer|<ul><li>Auflisten eines Clusters</li><li>Anzeigen von Details für einen Cluster</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: Nur anzeigen</p>|<ul><li>RBAC-Rolle: view</li><li>Lesezugriff auf Ressourcen innerhalb des Standardnamensbereichs</li><li>Kein Lesezugriff auf geheime Kubernetes-Schlüssel</li></ul>|

|Cloud Foundry-Zugriffsrichtlinie|Kontoverwaltungsberechtigungen|
|-------------|------------------------------|
|Organisationsrolle: Manager|<ul><li>Hinzufügen zusätzlicher Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto</li></ul>| |
|Bereichsrolle: Entwickler|<ul><li>Erstellen von {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen</li><li>Binden von {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen an Cluster</li></ul>| 

<br />


## Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen
{: #add_users}

Sie können zusätzliche Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen, um ihnen Zugriff auf Ihren Cluster zu gewähren.

Zunächst müssen Sie sicherstellen, dass Ihnen die Cloud Foundry-Rolle 'Manager' für ein {{site.data.keyword.Bluemix_notm}}-Konto zugeordnet wurde.

1.  [Fügen Sie den Benutzer zum Konto hinzu](../iam/iamuserinv.html#iamuserinv).
2.  Erweitern Sie im Abschnitt **Zugriff** den Eintrag **Services**.
3.  Weisen Sie eine {{site.data.keyword.containershort_notm}}-Zugriffsrolle zu. Wählen Sie in der Dropdown-Liste **Zugriff zuweisen zu** aus, ob Sie Zugriff nur Ihrem {{site.data.keyword.containershort_notm}}-Konto (**Ressource**) oder einer Reihe verschiedener Ressourcen in Ihrem Konto (**Ressourcengruppe**) gewähren möchten.
  -  Für **Ressource**:
      1. Wählen Sie in der Dropdown-Liste **Services** den Eintrag **{{site.data.keyword.containershort_notm}}** aus.
      2. Wählen Sie aus der Dropdown-Liste **Region** die Region aus, der der Benutzer angehören soll.
      3. Wählen Sie aus der Dropdown-Liste **Serviceinstanz** den Cluster aus, dem der Benutzer angehören soll. Führen Sie `bx cs clusters` aus, um die ID eines bestimmten Clusters zu finden.
      4. Wählen Sie im Abschnitt **Rollen auswählen** eine Rolle aus. Eine Liste von unterstützten Aktionen pro Rolle finden Sie unter [Zugriffsrichtlinien und -berechtigungen](#access_policies).
  - Für **Ressourcengruppe**:
      1. Wählen Sie aus der Dropdown-Liste **Ressourcengruppe** die Ressourcengruppe aus, die Berechtigungen für die {{site.data.keyword.containershort_notm}}-Ressource Ihres Kontos enthält.
      2. Wählen Sie aus der Dropdown-Liste **Zugriff für eine Ressourcengruppe zuweisen** zu einer Ressourcengruppe eine Rolle aus. Eine Liste von unterstützten Aktionen pro Rolle finden Sie unter [Zugriffsrichtlinien und -berechtigungen](#access_policies).
4. [Optional: Weisen Sie eine Infrastrukturrolle zu](/docs/iam/mnginfra.html#managing-infrastructure-access).
5. [Optional: Weisen Sie eine Cloud Foundry-Rolle zu](/docs/iam/mngcf.html#mngcf).
5. Klicken Sie auf **Benutzer einladen**.

<br />


## Infrastrukturberechtigungen für einen Benutzer anpassen
{: #infra_access}

Wenn Sie Infrastrukturrichtlinien in IAM (Identity and Access Management) konfigurieren, werden einem Benutzer mit einer Rolle verknüpfte Berechtigungen zugewiesen. Um diese Berechtigungen anzupassen, müssen Sie sich bei IBM Cloud Infrastructure (SoftLayer) anmelden und die Berechtigungen dort anpassen.
{: #view_access}

Basisbenutzer können beispielsweise einen Workerknoten neu starten, ihn aber nicht neu laden. Ohne diesen Benutzern Superuser-Berechtigungen zuzuweisen, können Sie die IBM Cloud Infrastructure (SoftLayer)-Berechtigungen anpassen und die Berechtigung zum Ausführen eines Neuladen-Befehls hinzufügen.

1.  Melden Sie sich bei Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) an.
2.  Wählen Sie ein Benutzerprofil aus, das aktualisiert werden soll.
3.  Passen Sie unter **Portalberechtigungen** den Zugriff des Benutzers an. Um beispielsweise eine Neuladen-Berechtigung hinzuzufügen, wählen Sie auf der Registerkarte **Devices** die Option **Issue OS Reloads and Initiate Rescue Kernel** aus.
9.  Speichern Sie Ihre Änderungen.
