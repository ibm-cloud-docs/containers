---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Clusterzugriff zuweisen
{: #users}

Als Clusteradministrator können Sie Zugriffsrichtlinien für Ihren Kubernetes-Cluster definieren, um verschiedene Zugriffsebenen für unterschiedliche Benutzer zu erstellen. Sie können beispielsweise bestimmte Benutzer autorisieren, mit Clusterressourcen zu arbeiten, während andere Benutzer nur Container bereitstellen können.
{: shortdesc}


## Erklärung der Zugriffsrichtlinien und Berechtigungen
{: #access_policies}

<dl>
  <dt>Muss ich Zugriffsrichtlinien festlegen?</dt>
    <dd>Sie müssen Zugriffsrichtlinien für jeden Benutzer definieren, der mit {{site.data.keyword.containerlong_notm}} arbeitet. Der Geltungsbereich einer Zugriffsrichtlinie basiert auf benutzerdefinierten Rollen, die die Aktionen bestimmen, die sie ausführen dürfen. Einige Richtlinien sind vordefiniert, andere können jedoch angepasst werden. Es wird dieselbe Richtlinie umgesetzt, unabhängig davon, ob der Benutzer eine Anforderung über die {{site.data.keyword.containerlong_notm}}-GUI oder über die CLI startet. Dies gilt auch dann, wenn die Aktionen in IBM Cloud Infrastructure (SoftLayer) ausgeführt werden.</dd>

  <dt>Welche Arten von Berechtigungen gibt es?</dt>
    <dd><p><strong>Plattform</strong>: {{site.data.keyword.containerlong_notm}} ist für die Verwendung von {{site.data.keyword.Bluemix_notm}}-Plattformrollen konfiguriert, mit denen die Aktionen festgelegt werden, die Personen in einem Cluster ausführen dürfen. Die Rollenberechtigungen bauen aufeinander auf, d. h. die Rolle `Editor` (Bearbeiter) verfügt über genau dieselben Berechtigungen wie die Rolle `Viewer` (Anzeigeberechtigter) und zusätzlich über die Berechtigungen, die einem Bearbeiter gewährt werden. Sie können diese Richtlinien nach Region festlegen. Diese Richtlinien müssen in Verbindung mit Infrastrukturrichtlinien festgelegt werden und sie haben entsprechende RBAC-Rollen, die dem Standardnamensbereich automatisch zugeordnet werden. Beispiele für Aktionen sind das Erstellen oder Entfernen von Clustern oder das Hinzufügen zusätzlicher Workerknoten.</p> <p><strong>Infrastruktur</strong>: Sie können die Zugriffsebenen für Ihre Infrastruktur, z. B. Clusterknotenmaschinen, Netz oder Speicherressourcen, bestimmen. Dieser Typ von Richtlinie muss gemeinsam mit {{site.data.keyword.containerlong_notm}}-Plattformzugriffsrichtlinien gesetzt werden. Wenn Sie mehr über die verfügbaren Rollen erfahren möchten, lesen Sie die Informationen zu den [Infrastrukturberechtigungen](/docs/iam/infrastructureaccess.html#infrapermission). Neben bestimmten Infrastrukturrollen müssen Sie auch Benutzern Gerätezugriff erteilen, die mit der Infrastruktur arbeiten. Führen Sie die folgenden Schritte unter [Infrastrukturberechtigungen für einen Benutzer anpassen](#infra_access) aus, um mit dem Zuweisen von Rollen zu beginnen. <strong>Anmerkung:</strong> Stellen Sie sicher, dass Ihr {{site.data.keyword.Bluemix_notm}}-Konto [mit Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) eingerichtet ist](cs_troubleshoot_clusters.html#cs_credentials), damit berechtigte
Benutzer basierend auf den zugewiesenen Berechtigungen entsprechende Aktionen im Konto der IBM Cloud-Infrastruktur (SoftLayer) durchführen können.</p> <p><strong>RBAC</strong>: Die rollenbasierte Zugriffssteuerung ist eine Methode, die Ressourcen in Ihrem Cluster zu sichern und zu entscheiden, welche Personen welche Kubernetes-Aktionen ausführen können. Jedem Benutzer, dem eine Plattformzugriffsrichtlinie zugewiesen ist, ist automatisch auch eine Kubernetes-Rolle zugewiesen. In Kubernetes bestimmt die rollenbasierte Zugriffssteuerung ([Role Based Access Control, RBAC ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview), welche Aktionen ein Benutzer für die Ressourcen in einem Cluster ausführen kann. <strong>Anmerkung</strong>: RBAC-Rollen werden in Verbindung mit der Plattformrolle für den Standardnamensbereich automatisch festgelegt. Als Clusteradministrator können Sie auch für andere Namensbereiche [Rollen aktualisieren oder zuweisen](#rbac).</p> <p><strong>Cloud Foundry</strong>: Nicht alle Services können mit Cloud IAM verwaltet werden. Wenn Sie einen dieser Services nutzen, können Sie weiterhin die [Cloud Foundry-Benutzerrollen](/docs/iam/cfaccess.html#cfaccess) verwenden, um den Zugriff auf Ihre Services zu steuern. Beispiele für Aktionen sind das Binden eines Service oder das Erstellen einer neuen Serviceinstanz.</p></dd>

  <dt>Wie kann ich die Berechtigungen festlegen?</dt>
    <dd><p>Sie können Plattformberechtigungen einem bestimmten Benutzer, einer Gruppe von Benutzern oder der Standardressourcengruppe zuweisen. Wenn Sie die Plattformberechtigungen festlegen, werden RBAC-Rollen für den Standardnamensbereich automatisch konfiguriert und eine Rollenbindung wird erstellt.</p>
    <p><strong>Benutzer</strong>: Sie haben möglicherweise einen bestimmten Benutzer, der mehr oder weniger Berechtigungen benötigt als der Rest Ihres Teams. Sie können die Berechtigungen individuell anpassen, sodass jede Person die richtige Menge an Berechtigungen hat, die sie zur Ausführung ihrer Aufgaben benötigt.</p>
    <p><strong>Zugriffsgruppen</strong>: Sie können Benutzergruppen erstellen und dann bestimmten Gruppen bestimmte Berechtigungen zuweisen. Sie können beispielsweise alle Teamleiter zusammenfassen und dieser Gruppe Administratorzugriff erteilen. Ihre Entwicklergruppe kann dagegen gleichzeitig nur Schreibzugriff haben.</p>
    <p><strong>Ressourcengruppen</strong>: Mit IAM können Sie Zugriffsrichtlinien für eine Ressourcengruppe erstellen und Benutzern Zugriff auf diese Gruppe erteilen. Diese Ressourcen können Teil eines {{site.data.keyword.Bluemix_notm}}-Service sein; Sie können Ressourcen aber auch serviceinstanzübergreifend gruppieren, wie z. B. einen {{site.data.keyword.containerlong_notm}}-Cluster oder eine CF-App.</p> <p>**Wichtig**: {{site.data.keyword.containerlong_notm}} unterstützt nur die Ressourcengruppe <code>default</code>. Alle clusterbezogenen Ressourcen werden automatisch in der Ressourcengruppe <code>default</code> zur Verfügung gestellt. Wenn Sie in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto über weitere Services verfügen, die Sie mit Ihrem Cluster zusammen verwenden möchten, müssen sich die Services auch in der Ressourcengruppe <code>default</code> befinden.</p></dd>
</dl>


Sind Sie überfordert? Testen Sie dieses Lernprogramm zu den [Best Practices für die Organisation von Benutzern, Teams und Anwendungen](/docs/tutorials/users-teams-applications.html).
{: tip}

<br />


## Auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) zugreifen
{: #api_key}

<dl>
  <dt>Warum benötige ich Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer)?</dt>
    <dd>Um erfolgreich Cluster bereitzustellen und mit diesen zu arbeiten, müssen Sie sicherstellen, dass Ihr Konto korrekt für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) konfiguriert wurde. Abhängig von der Konfiguration Ihres Kontos verwenden Sie entweder den IAM-API-Schlüssel oder die Berechtigungsnachweise der Infrastruktur, die Sie manuell mithilfe des Befehls `ibmcloud ks credentials-set` definiert haben.</dd>

  <dt>Wie funktioniert der IAM-API-Schlüssel mit {{site.data.keyword.containerlong_notm}}?</dt>
    <dd><p>Der IAM-API-Schlüssel (IAM, Identity and Access Management) wird automatisch für eine Region festgelegt, wenn die erste Aktion ausgeführt wird, für die die {{site.data.keyword.containerlong_notm}}-Administratorzugriffsrichtlinie ausgeführt werden muss. Zum Beispiel erstellt einer Ihrer Benutzer mit Administratorberechtigung den ersten Cluster in der Region <code>Vereinigte Staaten (Süden)</code>. Dadurch wird der IAM-API-Schlüssel für diesen Benutzer in dem Konto für diese Region gespeichert. Der API-Schlüssel wird verwendet, um IBM Cloud Infrastructure (SoftLayer) wie beispielsweise neue Workerknoten oder VLANs zu bestellen.</p> <p>Wenn ein anderer Benutzer eine Aktion in dieser Region ausführt, die eine Interaktion mit dem Portfolio der IBM Cloud-Infrastruktur (SoftLayer) erfordert, wie z. B. die Erstellung eines neuen Clusters oder das erneute Laden eines Workerknotens, wird der gespeicherte API-Schlüssel verwendet, um festzustellen, ob ausreichende Berechtigungen vorhanden sind, um diese Aktion auszuführen. Um sicherzustellen, dass infrastrukturbezogene Aktionen in Ihrem Cluster erfolgreich ausgeführt werden können, weisen Sie Ihre {{site.data.keyword.containerlong_notm}}-Benutzer mit Administratorberechtigung der Infrastrukturzugriffsrichtlinie <strong>Superuser</strong> zu.</p> <p>Sie können den aktuellen Eigner eines API-Schlüssels finden, indem Sie den Befehl [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info) ausführen. Wenn Sie feststellen, dass Sie den API-Schlüssel aktualisieren müssen, der für eine Region gespeichert ist, können Sie dies tun, indem Sie den Befehl [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) ausführen. Dieser Befehl erfordert die {{site.data.keyword.containerlong_notm}}-Administratorzugriffsrichtlinie und speichert den API-Schlüssel des Benutzers, der diesen Befehl ausführt, im Konto. Der API-Schlüssel, der für die Region gespeichert ist, wird möglicherweise nicht verwendet, falls die Berechtigungsnachweise für die IBM Cloud-Infrastruktur (SoftLayer) manuell durch Verwendung des Befehls <code>ibmcloud ks credentials-set</code> festgelegt wurden.</p> <p><strong>Anmerkung:</strong> Stellen Sie sicher, dass Sie den Schlüssel zurücksetzen möchten und die Auswirkungen auf Ihre App verstehen. Der Schlüssel wird an mehreren unterschiedlichen Stellen verwendet und kann zu unterbrechenden Änderungen führen, wenn er unnötigerweise geändert wird.</p></dd>

  <dt>Was bewirkt der Befehl <code>ibmcloud ks credentials-set</code>?</dt>
    <dd><p>Wenn Sie über ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto verfügen, haben Sie standardmäßig Zugriff auf das Portfolio der IBM Cloud-Infrastruktur. Es kann jedoch sein, dass Sie ein anderes IBM Cloud-Infrastrukturkonto (SoftLayer) verwenden möchten, das Sie bereits für die Infrastrukturbestellung für Cluster in einer Region verwendet haben. Sie können dieses Infrastrukturkonto mit Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verbinden, indem Sie den Befehl [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set) verwenden.</p> <p>Um manuell definierte Berechtigungsnachweise für die IBM Cloud-Infrastruktur (SoftLayer) zu entfernen, können Sie den Befehl [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) verwenden. Nachdem die Berechtigungsnachweise entfernt wurden, wird der IAM-API-Schlüssel verwendet, um Infrastruktur zu bestellen.</p></dd>

  <dt>Gibt es einen Unterschied zwischen den Berechtigungsnachweisen für die Infrastruktur und dem API-Schlüssel?</dt>
    <dd>Sowohl der API-Schlüssel als auch der Befehl <code>ibmcloud ks credentials-set</code> führen die gleiche Task aus. Wenn Sie mithilfe des Befehls <code>ibmcloud ks credentials-set</code> Berechtigungsnachweise manuell festlegen, setzen die festgelegten Berechtigungsnachweise jeden Zugriff außer Kraft, der durch den API-Schlüssel erteilt wird. Wenn der Benutzer, dessen Berechtigungsnachweise gespeichert sind, jedoch nicht über die erforderlichen Berechtigungen zum Bestellen von Infrastruktur verfügt, können infrastrukturbezogene Aktionen, wie z. B. das Erstellen eines Clusters oder das erneute Laden eines Workerknotens, fehlschlagen.</dd>
    
  <dt>Wie kann ich wissen, ob meine Infrastrukturkonto-Berechtigungsnachweise ein anderes Konto verwenden?</dt>
    <dd>Öffnen Sie die [{{site.data.keyword.containerlong_notm}}-GUI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/containers-kubernetes/clusters) und wählen Sie Ihren Cluster aus. Suchen Sie auf der Registerkarte **Übersicht** nach dem Feld **Infrastrukturbenutzer**. Wenn Sie dieses Feld sehen, bedeutet das, dass Sie nicht die Standard-Infrastrukturberechtigungsnachweise verwenden, die im Umfang Ihres nutzungsabhängigen Kontos in dieser Region enthalten sind. Stattdessen ist die Region so eingestellt, dass sie andere Berechtigungsnachweise für das Infrastrukturkonto verwendet.</dd>

  <dt>Gibt es eine Möglichkeit, die Zuordnung von Berechtigungen für die IBM Cloud-Infrastruktur (SoftLayer) zu vereinfachen?</dt>
    <dd><p>Benutzer benötigen in der Regel keine bestimmten Berechtigungen für die IBM Cloud-Infrastruktur (SoftLayer). Stattdessen müssen Sie den API-Schlüssel mit den richtigen Infrastrukturberechtigungen einrichten und diesen API-Schlüssel in jeder Region verwenden, in der Sie Cluster erstellen und verwenden wollen. Der API-Schlüssel kann dem Kontoeigner, einer Funktions-ID oder einem Benutzer zugeordnet sein, je nachdem, was für Sie einfacher zu verwalten und zu prüfen ist. </p> <p>Wenn Sie einen Cluster in einer neuen Region erstellen möchten, müssen Sie sicherstellen, dass der erste Cluster von der Person erstellt wird, die Eigner des API-Schlüssels ist, den Sie mit den richtigen Berechtigungsnachweisen für die Infrastruktur eingerichtet haben. Anschließend können Sie einzelne Personen, IAM-Gruppen oder Servicekontobenutzer in diese Region einladen. Die Benutzer innerhalb des Kontos nutzen die API-Schlüsselberechtigungsnachweise für die Ausführung von Infrastrukturaktionen (z. B. für das Hinzufügen von Workerknoten). Um zu steuern, welche Infrastrukturaktionen von einem Benutzer ausgeführt werden können, ordnen Sie die entsprechende {{site.data.keyword.containerlong_notm}}-Rolle in IAM zu.</p><p>Ein Benutzer mit der IAM-Rolle `Anzeigeberechtigter` ist zum Beispiel nicht berechtigt, einen Workerknoten hinzuzufügen. Daher schlägt die Aktion `worker-add` fehl, auch wenn der API-Schlüssel über die richtigen Infrastrukturberechtigungen verfügt. Wenn Sie die Benutzerrolle in IAM in `Operator` ändern, ist der Benutzer berechtigt, einen Workerknoten hinzuzufügen. Die Aktion `worker-add` ist erfolgreich, weil die Benutzerrolle berechtigt und der API-Schlüssel korrekt definiert ist. Sie müssen die Berechtigungen des Benutzers für die IBM Cloud-Infrastruktur (SoftLayer) nicht bearbeiten. </p> <p>Weitere Informationen zum Festlegen von Berechtigungen finden Sie im Abschnitt [Infrastrukturberechtigungen für einen Benutzer anpassen](#infra_access).</p></dd>
</dl>


<br />



## Erklärung der Rollenbeziehungen
{: #user-roles}

Bevor deutlich wird, welche Rolle welche Aktion ausführen kann, ist es wichtig zu verstehen, wie die Rollen ineinandergreifen.
{: shortdesc}

Die folgende Abbildung zeigt die Rollen, die die einzelnen Personen in Ihrem Unternehmen möglicherweise benötigen. Dies ist jedoch für jede Organisation unterschiedlich. Möglicherweise stellen Sie fest, dass bestimmte Benutzer angepasste Berechtigungen für die Infrastruktur benötigen. Im Abschnitt [Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer)](#api_key) erfahren Sie, was Berechtigungen für die IBM Cloud-Infrastruktur (SoftLayer) sind und welche Berechtigungen von den einzelnen Benutzern benötigt werden. 

![{{site.data.keyword.containerlong_notm}}-Zugriffsrollen](/images/user-policies.png)

Abbildung. {{site.data.keyword.containerlong_notm}}-Zugriffsberechtigungen nach Rollentyp

<br />



## Rollen über die GUI zuweisen
{: #add_users}

Sie können Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen, um ihnen Zugriff auf Ihren Cluster mithilfe der GUI zu gewähren.
{: shortdesc}

**Vorbereitende Schritte**

- Überprüfen Sie, dass der Benutzer zum Konto hinzugefügt wurde. Ist dies nicht der Fall, fügen Sie [sie](../iam/iamuserinv.html#iamuserinv) hinzu.
- Überprüfen Sie, dass Ihnen für das {{site.data.keyword.Bluemix_notm}}-Konto, in dem Sie arbeiten, die [Cloud Foundry-Rolle](/docs/iam/mngcf.html#mngcf) `Manager` zugewiesen wurde.

**Gehen Sie wie folgt vor, um einem Benutzer Zugriff zuzuweisen:**

1. Navigieren Sie zu **Verwalten > Benutzer**. Es wird eine Liste der Benutzer mit Zugriff auf das Konto angezeigt.

2. Klicken Sie auf den Namen des Benutzers, für den Sie Berechtigungen festlegen möchten. Wenn der Benutzer nicht angezeigt wird, klicken Sie auf **Benutzer einladen**, um diese dem Konto hinzuzufügen.

3. Weisen Sie eine Richtlinie zu.
  * Für eine Ressourcengruppe:
    1. Wählen Sie die Ressourcengruppe **default** (Standard) aus. Der {{site.data.keyword.containerlong_notm}}-Zugriff kann nur für die Standardressourcengruppe konfiguriert werden.
  * Für eine bestimmte Ressource:
    1. Wählen Sie in der Liste **Services** den Eintrag **{{site.data.keyword.containerlong_notm}}** aus.
    2. Wählen Sie in der Liste **Region** eine Region aus.
    3. Wählen Sie in der Liste **Serviceinstanz** den Cluster aus, in den der Benutzer eingeladen werden soll. Führen Sie `ibmcloud ks clusters` aus, um die ID eines bestimmten Clusters zu finden.

4. Wählen Sie im Abschnitt **Rollen auswählen** eine Rolle aus. 

5. Klicken Sie auf **Zuweisen**.

6. Weisen Sie eine [Cloud Foundry-Rolle](/docs/iam/mngcf.html#mngcf) zu.

7. Optional: Weisen Sie eine [Infrastrukturrolle](/docs/iam/infrastructureaccess.html#infrapermission) zu.

</br>

**Gehen Sie wie folgt vor, um Zugriff auf eine Gruppe zuzuweisen:**

1. Navigieren Sie zu **Verwalten > Zugriffsgruppen**.

2. Erstellen Sie eine Zugriffsgruppe.
  1. Klicken Sie auf **Erstellen** und geben Sie Ihrer Gruppe einen **Namen** und eine **Beschreibung**. Klicken Sie auf **Erstellen**.
  2. Klicken Sie auf **Benutzer hinzufügen**, um Ihrer Zugriffsgruppe Personen hinzuzufügen. Es wird eine Liste mit Benutzern angezeigt, die Zugriff auf Ihr Konto haben.
  3. Wählen Sie das Kästchen neben den Benutzern aus, die Sie zur Gruppe hinzufügen möchten. Ein Dialogfeld wird angezeigt.
  4. Klicken Sie auf **Zu Gruppe hinzufügen**.

3. Fügen Sie eine Service-ID hinzu, um Zugriff auf einen bestimmten Service zuzuweisen.
  1. Klicken Sie auf **Service-ID hinzufügen**.
  2. Wählen Sie das Kästchen neben den Benutzern aus, die Sie zur Gruppe hinzufügen möchten. Ein Popup-Fenster wird angezeigt.
  3. Klicken Sie auf **Zu Gruppe hinzufügen**.

4. Weisen Sie Zugriffsrichtlinien zu. Vergessen Sie nicht, die Personen genau zu überprüfen, die Sie Ihrer Gruppe hinzufügen. Für jeden in der Gruppe wird dieselbe Zugriffsebene bereitgestellt.
    * Für eine Ressourcengruppe:
        1. Wählen Sie die Ressourcengruppe **default** (Standard) aus. Der {{site.data.keyword.containerlong_notm}}-Zugriff kann nur für die Standardressourcengruppe konfiguriert werden.
    * Für eine bestimmte Ressource:
        1. Wählen Sie in der Liste **Services** den Eintrag **{{site.data.keyword.containerlong_notm}}** aus.
        2. Wählen Sie in der Liste **Region** eine Region aus.
        3. Wählen Sie in der Liste **Serviceinstanz** den Cluster aus, in den der Benutzer eingeladen werden soll. Führen Sie `ibmcloud ks clusters` aus, um die ID eines bestimmten Clusters zu finden.

5. Wählen Sie im Abschnitt **Rollen auswählen** eine Rolle aus. 

6. Klicken Sie auf **Zuweisen**.

7. Weisen Sie eine [Cloud Foundry-Rolle](/docs/iam/mngcf.html#mngcf) zu.

8. Optional: Weisen Sie eine [Infrastrukturrolle](/docs/iam/infrastructureaccess.html#infrapermission) zu.

<br />



## Rollen über die CLI zuweisen
{: #add_users_cli}

Sie können Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen, um ihnen Zugriff auf Ihren Cluster mithilfe der CLI zu gewähren.
{: shortdesc}

**Vorbereitende Schritte**

Überprüfen Sie, dass Ihnen für das {{site.data.keyword.Bluemix_notm}}-Konto, in dem Sie arbeiten, die [Cloud Foundry-Rolle](/docs/iam/mngcf.html#mngcf) `Manager` zugewiesen wurde.

**Gehen Sie wie folgt vor, um einem bestimmten Benutzer Zugriff zuzuweisen:**

1. Laden Sie den Benutzer zu Ihrem Konto ein.
  ```
  ibmcloud account user-invite <benutzer@email.com>
  ```
  {: pre}
2. Erstellen Sie eine IAM-Zugriffsrichtlinie, um Berechtigungen für {{site.data.keyword.containerlong_notm}} festzulegen. Sie können die Rollen "Anzeigeberechtigter", "Bearbeiter", "Operator" und "Administrator" auswählen.
  ```
  ibmcloud iam user-policy-create <benutzer-e-mail> --service-name containers-kubernetes --roles <rolle>
  ```
  {: pre}

**Gehen Sie wie folgt vor, um Zugriff auf eine Gruppe zuzuweisen:**

1. Wenn der Benutzer noch nicht in Ihrem Konto enthalten ist, laden Sie ihn ein.
  ```
  ibmcloud account user-invite <benutzer-e-mail>
  ```
  {: pre}

2. Erstellen Sie eine Gruppe.
  ```
  ibmcloud iam access-group-create <teamname>
  ```
  {: pre}

3. Fügen Sie den Benutzer zur Gruppe hinzu.
  ```
  ibmcloud iam access-group-user-add <teamname> <benutzer-e-mail>
  ```
  {: pre}

4. Fügen Sie den Benutzer zur Gruppe hinzu. Sie können die Rollen "Anzeigeberechtigter", "Bearbeiter", "Operator" und "Administrator" auswählen.
  ```
  ibmcloud iam access-group-policy-create <teamname> --service-name containers-kubernetes --roles <rolle>
  ```
  {: pre}

5. Aktualisieren Sie Ihre Clusterkonfiguration, um eine Rollenbindung zu generieren.
  ```
  ibmcloud ks cluster-config
  ```
  {: pre}

  Rollenbindung:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: <bindung>
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: <rolle>
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: <gruppenname>
    namespace: default
  ```
  {: screen}

In den vorherigen Anweisungen wurde gezeigt, wie Sie einer Benutzergruppe Zugriff auf alle {{site.data.keyword.containerlong_notm}}-Ressourcen erteilen können. Als Administrator können Sie außerdem den Zugriff auf den Service auf der Regions- oder Clusterinstanzebene einschränken.
{: tip}

<br />


## Benutzer mit RBAC-Rollenbindungen berechtigen
{: #role-binding}

Jeder Cluster wird mit vordefinierten RBAC-Rollen eingerichtet, die für den Standardnamensbereich Ihres Clusters konfiguriert sind. Sie können RBAC-Rollen aus dem Standardnamensbereich in andere Namensbereiche in Ihrem Cluster kopieren, um dieselbe Zugriffsebene für den Benutzer zu aktivieren.

**Was ist eine RBAC-Rollenbindung?**

Eine Rollenbindung ist eine ressourcenspezifische Kubernetes-Zugriffsrichtlinie. Sie können Rollenbindungen verwenden, um Richtlinien festzulegen, die speziell für Namensbereiche, Pods oder andere Ressourcen in Ihrem Cluster gelten. {{site.data.keyword.containerlong_notm}} stellt vordefinierte RBAC-Rollen zur Verfügung, die den Plattformrollen in IAM entsprechen. Wenn Sie einem Benutzer eine IAM-Plattformrolle zuweisen, wird automatisch eine RBAC-Rollenbindung für den Benutzer im Standardnamensbereich des Clusters erstellt.

**Was ist eine RBAC-Clusterrollenbindung?**

Während eine RBAC-Rollenbindung für eine Ressource (wie z. B. einen Namensbereich oder einen Pod) spezifisch ist, kann eine RBAC-Clusterrollenbindung verwendet werden, um Berechtigungen auf Clusterebene festzulegen, was alle Namensbereiche einschließt. Clusterrollenbindungen werden automatisch für den Standardnamensbereich erstellt, wenn Plattformrollen festgelegt werden. Sie können diese Rollenbindung in andere Namensbereiche kopieren.


<table>
  <tr>
    <th>Plattformrolle</th>
    <th>RBAC-Rolle</th>
    <th>Rollenbindung</th>
  </tr>
  <tr>
    <td>Viewer</td>
    <td>Anzeigen</td>
    <td><code>ibm-view</code></td>
  </tr>
  <tr>
    <td>Editor</td>
    <td>Bearbeiten</td>
    <td><code>ibm-edit</code></td>
  </tr>
  <tr>
    <td>Operator</td>
    <td>Administrator</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Administrator</td>
    <td>Clusteradministrator</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

**Gibt es spezielle Anforderungen bei der Arbeit mit Rollenbindungen?**

Um mit IBM Helm-Diagrammen arbeiten zu können, müssen Sie Tiller im `kube-system`-Namensbereich installieren. Um Tiller installieren zu können, müssen Sie über die Rolle [`cluster-admin`](cs_users.html#access_policies) im Namensbereich `kube-system` verfügen. Bei anderen Helm-Diagrammen können Sie einen anderen Namensbereich auswählen. Wenn Sie aber den Befehl `helm` ausführen, müssen Sie mit dem Flag `tiller-namespace <namespace>` auf den Namensbereich verweisen, in dem Tiller installiert ist.


### RBAC-Rollenbindung kopieren

Wenn Sie Ihre Plattformrichtlinien konfigurieren, wird automatisch eine Clusterrollenbindung für den Standardnamensbereich generiert. Sie können die Bindung in andere Namensbereiche kopieren, indem Sie die Bindung mit dem Namensbereich aktualisieren, für den die Richtlinie festgelegt werden soll. Beispiel: Eine Gruppe von Entwicklern mit dem Namen `team-a` hat die Zugriffsberechtigung `view` für den gesamten Service, benötigt jedoch die Berechtigung `edit` für den Namensbereich `teama`. Sie können die automatisch generierte Rollenbindung bearbeiten, um dem Team den Zugriff zu gewähren, den es auf Ressourcenebene benötigt.

1. Erstellen Sie eine RBAC-Rollenbindung für den Standardnamensbereich, indem Sie [den Zugriff mit einer Plattformrolle zuweisen](#add_users_cli).
  ```
  ibmcloud iam access-policy-create <teamname> --service-name containers-kubernetes --roles <rolle>
  ```
  {: pre}
  Beispielausgabe:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-view
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: View
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: default
  ```
  {: screen}
2. Kopieren Sie diese Konfiguration in einen anderen Namensbereich.
  ```
  ibmcloud iam access-policy-create <teamname> --service-name containers-kubernetes --roles <rolle> --namespace <namensbereich>
  ```
  {: pre}
  Im vorherigen Szenario habe ich eine Änderung an der Konfiguration für einen anderen Namensbereich vorgenommen. Die aktualisierte Konfiguration würde wie folgt aussehen:
```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-edit
    namespace: teama
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: teama
  ```
  {: screen}

<br />




### Angepasste Kubernetes-RBAC-Rollen erstellen
{: #rbac}

Wenn Sie andere Kubernetes-Rollen berechtigen möchten, die sich von der entsprechenden Plattformzugriffsrichtlinie unterscheiden, können Sie RBAC-Rollen anpassen und die Rollen dann Einzelpersonen oder Benutzergruppen zuweisen.
{: shortdesc}

Müssen Ihre Clusterzugriffsrichtlinien differenzierter sein, als dies durch eine IAM-Richtlinie möglich ist. Kein Problem. Sie können Benutzern, Benutzergruppen (in Clustern, in denen Kubernetes Version 1.11 oder höher ausgeführt wird) oder Servicekonten Zugriffsrichtlinien für bestimmte Kubernetes-Ressourcen zuordnen. Sie können eine Rolle erstellen und die Rolle anschließend an bestimmte Benutzer oder eine Gruppe binden. Weitere Informationen finden Sie unter [Verwendung von RBAC-Autorisierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) in der Kubernetes-Dokumentation.

Wenn für eine Gruppe eine Bindung erstellt wird, wirkt sich dies auf alle Benutzer aus, die dieser Gruppe hinzugefügt oder die aus dieser Gruppe entfernt werden. Wenn Sie der Gruppe Benutzer hinzufügen, verfügen diese Benutzer auch über den zusätzlichen Zugriff. Werden sie entfernt, wird ihr Zugriff widerrufen.
{: tip}

Wenn Sie Zugriff auf einen Service (z. B. eine Continuous-Delivery-Toolchain) zuweisen möchten, können Sie [Kubernetes-Servicekonten ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/) verwenden.

**Vorbereitende Schritte**

- Wählen Sie Ihr Cluster als Ziel Ihrer [Kubernetes-CLI](cs_cli_install.html#cs_cli_configure) aus.
- Stellen Sie sicher, dass der Benutzer oder die Gruppe auf dem Service-Level mindestens über den Zugriff `Viewer` (Anzeigeberechtigter) verfügt.


**Gehen Sie wie folgt vor, um RBAC-Rollen anzupassen

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
        <caption>Erklärung dieser YAML-Komponenten</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung dieser YAML-Komponenten</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>Verwenden Sie `Role`, um Zugriff auf die Ressourcen in einem einzelnen Namensbereich zu erteilen, oder `ClusterRole` für clusterweite Ressourcen.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Für Cluster, die Kubernetes 1.8 oder höher ausführen, verwenden Sie `rbac.authorization.k8s.io/v1`. </li><li>Für ältere Versionen verwenden Sie `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>Für `Role` kind: Geben Sie den Kubernetes-Namensbereich an, für den der Zugriff erteilt wird.</li><li>Verwenden Sie das Feld `namespace` nicht, wenn Sie eine Clusterrolle erstellen (`ClusterRole`), die auf Clusterebene gilt.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>Benennen Sie die Rolle und verwenden Sie den Namen später, wenn Sie die Rolle binden.</td>
            </tr>
            <tr>
              <td><code>rules/apiGroups</code></td>
              <td><ul><li>Geben Sie die Kubernetes-API-Gruppen an, mit denen Benutzer interagieren können sollen. Zum Beispiel `"apps"`, `"batch"` oder `"extensions"`. </li><li>Für den Zugriff auf die Gruppe der API-Kerndefinitionen im REST-Pfad `api/v1` lassen Sie die Angabe für die Gruppe leer `[""]`.</li><li>Weitere Informationen finden Sie unter [API-Gruppen![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) in der Kubernetes-Dokumentation.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>Geben Sie die Kubernetes-Ressourcen an, auf die Sie Zugriff erteilen möchten, z. B. `"daemonsets"`, `"deployments"`, `"events"` oder `"ingresses"`.</li><li>Falls Sie `"nodes"` angeben, muss als Rollentyp `ClusterRole` angegeben werden.</li><li>Eine Liste der Ressourcen finden Sie in der Tabelle der [Ressourcentypen![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) auf dem Kubernetes-Spickzettel.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>Geben Sie die Typen von Aktionen an, die Benutzer ausführen können sollen, z. B. `"get"`, `"list"`, `"describe"`, `"create"` oder `"delete"`. </li><li>Eine vollständige Liste der Verben finden Sie in der Dokumentation unter [`kubectl`![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/).</li></ul></td>
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
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <servicekontoname>
          namespace: <kubernetes-namensbereich>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Erklärung dieser YAML-Komponenten</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung dieser YAML-Komponenten</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>Geben Sie für `kind` für beide Typen der `.yaml`-Rollendateien `RoleBinding` an: Namensbereich - `Role` und clusterweit - `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Für Cluster, die Kubernetes 1.8 oder höher ausführen, verwenden Sie `rbac.authorization.k8s.io/v1`. </li><li>Für ältere Versionen verwenden Sie `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>Für `Role` kind: Geben Sie den Kubernetes-Namensbereich an, für den der Zugriff erteilt wird.</li><li>Verwenden Sie das Feld `namespace` nicht, wenn Sie eine Clusterrolle erstellen (`ClusterRole`), die auf Clusterebene gilt.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>Geben Sie der Rollenbindung einen Namen.</td>
            </tr>
            <tr>
              <td><code>subjects/kind</code></td>
              <td>Geben Sie für 'kind' eine der folgenden Optionen an:
              <ul><li>`User`: Binden Sie die RBAC-Rolle an einen einzelnen Benutzer in Ihrem Konto.</li>
              <li>`Group`: Für Cluster, die Kubernetes 1.11 oder höher ausführen, müssen Sie die RBAC-Rolle an eine [IAM-Gruppe](/docs/iam/groups.html#groups) in Ihrem Konto binden.</li>
              <li>`ServiceAccount`: Binden Sie die RBAC-Rolle an ein Servicekonto in einem Namensbereich in Ihrem Cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**Für `User`**: Hängen Sie die E-Mailadresse des Benutzers an die folgende URL an: `https://iam.ng.bluemix.net/kubernetes#`. Beispiel: `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**Für `Group`**: Für Cluster, die Kubernetes 1.11 oder höher ausführen, geben Sie den Namen der [IAM-Gruppe](/docs/iam/groups.html#groups) in Ihrem Konto an.</li>
              <li>**Für` ServiceAccount`**: Geben Sie den Namen des Servicekontos an.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td><ul><li>**Für `User` oder `Group`**: Verwenden Sie `rbac.authorization.k8s.io`.</li>
              <li>**Für `ServiceAccount`**: Fügen Sie dieses Feld nicht ein.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/namespace</code></td>
              <td>**Nur für `ServiceAccount`**: Geben Sie den Namen des Kubernetes-Namensbereichs an, in dem das Servicekonto bereitgestellt wird.</td>
            </tr>
            <tr>
              <td><code>roleRef/kind</code></td>
              <td>Geben Sie denselben Wert als `kind` in der `.yaml`-Rollendatei an: `Role` oder `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>roleRef/name</code></td>
              <td>Geben Sie den Namen der `.yaml`-Rollendatei an.</td>
            </tr>
            <tr>
              <td><code>roleRef/apiGroup</code></td>
              <td>Verwenden Sie `rbac.authorization.k8s.io`.</td>
            </tr>
          </tbody>
        </table>

    2. Erstellen Sie die Ressource für die Rollenbindung in Ihrem Cluster.

        ```
        kubectl apply -f filepath/my_role_binding.yaml
        ```
        {: pre}

    3.  Überprüfen Sie, dass die Bindung erstellt wurde.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Jetzt, nachdem Sie eine angepasste Kubernetes-RBAC-Rolle erstellt und gebunden haben, fahren Sie mit den Benutzern fort. Bitten Sie sie, eine Aktion auszuführen, für deren Ausführung sie die Berechtigung aufgrund Ihrer Rolle haben. Zum Beispiel das Löschen eines Pods.


<br />



## Infrastrukturberechtigungen für einen Benutzer anpassen
{: #infra_access}

Wenn Sie Infrastrukturrichtlinien in IAM (Identity and Access Management) konfigurieren, werden einem Benutzer mit einer Rolle verknüpfte Berechtigungen zugewiesen. Einige Richtlinien sind vordefiniert, andere können jedoch angepasst werden. Um diese Berechtigungen anzupassen, müssen Sie sich bei IBM Cloud Infrastructure (SoftLayer) anmelden und die Berechtigungen dort anpassen.
{: #view_access}

**Basisbenutzer** können beispielsweise einen Workerknoten neu starten, ihn aber nicht neu laden. Ohne diesen Benutzern **Superuser**-Berechtigungen zuzuweisen, können Sie die Berechtigungen der IBM Cloud Infrastructure (SoftLayer) anpassen und die Berechtigung zum Ausführen eines Neuladen-Befehls hinzufügen.

Wenn Sie Mehrzonencluster haben, muss der Eigner Ihres Kontos der IBM Cloud-Infrastruktur (SoftLayer) das VLAN-Spanning aktivieren, damit Knoten in unterschiedlichen Zonen innerhalb des Clusters miteinander kommunizieren können. Der Kontoeigner kann einem Benutzer auch die Berechtigung **Netz > VLAN-Spanning für das Netz verwalten** zuweisen, damit der Benutzer das VLAN-Spanning aktivieren kann. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}


1.  Melden Sie sich bei Ihrem [{{site.data.keyword.Bluemix_notm}}-Konto](https://console.bluemix.net/) an und wählen Sie dann im Menü **Infrastruktur** aus.

2.  Wählen Sie **Konto** > **Benutzer** > **Benutzerliste** aus.

3.  Um die Berechtigungen zu ändern, wählen Sie den Namen des Benutzerprofils oder die Spalte **Gerätezugriff** aus.

4.  Passen Sie auf der Registerkarte **Portalberechtigungen** den Benutzerzugriff an. Die Berechtigungen, die die Benutzer benötigen, sind davon abhängig, welche Infrastrukturressourcen sie verwenden müssen:

    * Verwenden Sie die Dropdown-Liste **Schnellberechtigungen**, um die Rolle **Superuser** zuzuweisen, die dem Benutzer alle Berechtigungen erteilt.
    * Verwenden Sie die Dropdown-Liste **Schnellberechtigungen**, um die Rolle **Basisbenutzer** zuzuweisen, die dem Benutzer einige aber nicht alle benötigten Berechtigungen erteilt.
    * Wenn Sie nicht alle Berechtigungen mit der Rolle **Superuser** erteilen möchten oder wenn Sie weitere Berechtigungen über die Rolle **Basisbenutzer** hinaus erteilen möchten, lesen Sie in der folgenden Tabelle nach. Sie beschreibt die erforderlichen Berechtigungen zum Ausführen allgemeiner Tasks in {{site.data.keyword.containerlong_notm}}.

    <table summary="Infrastrukturberechtigungen für allgemeine {{site.data.keyword.containerlong_notm}}-Szenarios.">
     <caption>Allgemein erforderliche Infrastrukturberechtigungen für {{site.data.keyword.containerlong_notm}}</caption>
     <thead>
      <th>Allgemeine Tasks in {{site.data.keyword.containerlong_notm}}</th>
      <th>Erforderliche Infrastrukturberechtigungen nach Registerkarte</th>
     </thead>
     <tbody>
       <tr>
         <td><strong>Mindestberechtigungen</strong>: <ul><li>Erstellen Sie einen Cluster.</li></ul></td>
         <td><strong>Geräte</strong>:<ul><li>Details zum virtuellen Server anzeigen</li><li>Server neu starten und IPMI-Systeminformationen anzeigen</li><li>Befehle zum erneuten Laden des Betriebssystems absetzen und Rescue-Kernel initiieren</li></ul><strong>Konto</strong>: <ul><li>Cloudinstanzen hinzufügen/aktualisieren</li><li>Server hinzufügen</li></ul></td>
       </tr>
       <tr>
         <td><strong>Clusterverwaltung</strong>: <ul><li>Cluster erstellen, aktualisieren und löschen.</li><li>Workerknoten hinzufügen, erneut laden und neu starten.</li><li>VLANs anzeigen.</li><li>Teilnetze erstellen-</li><li>Pods und Lastausgleichsservices  bereitstellen.</li></ul></td>
         <td><strong>Support</strong>:<ul><li>Tickets anzeigen</li><li>Tickets hinzufügen</li><li>Tickets bearbeiten</li></ul>
         <strong>Geräte</strong>:<ul><li>Details zum virtuellen Server anzeigen</li><li>Server neu starten und IPMI-Systeminformationen anzeigen</li><li>Upgrade für Server durchführen</li><li>Befehle zum erneuten Laden des Betriebssystems absetzen und Rescue-Kernel initiieren</li></ul>
         <strong>Services</strong>:<ul><li>SSH-Schlüssel verwalten</li></ul>
         <strong>Konto</strong>:<ul><li>Kontozusammenfassung anzeigen</li><li>Cloudinstanzen hinzufügen/aktualisieren</li><li>Server abbrechen</li><li>Server hinzufügen</li></ul></td>
       </tr>
       <tr>
         <td><strong>Speicher</strong>: <ul><li>Persistente Datenträgeranforderungen zur Bereitstellung von persistenten Datenträgern erstellen</li><li>Speicherinfrastrukturressourcen erstellen und verwalten.</li></ul></td>
         <td><strong>Services</strong>:<ul><li>Speicher verwalten</li></ul><strong>Konto</strong>:<ul><li>Speicher hinzufügen</li></ul></td>
       </tr>
       <tr>
         <td><strong>Privates Netz</strong>: <ul><li>Private VLANs für Netzbetrieb im Cluster verwalten</li><li>VPN-Konnektivität für private Netze konfigurieren</li></ul></td>
         <td><strong>Netz</strong>:<ul><li>Teilnetzrouten im Netz verwalten</li><li>IPSEC-Netztunnel verwalten</li><li>Netzgateways verwalten</li><li>VPN-Verwaltung</li></ul></td>
       </tr>
       <tr>
         <td><strong>Öffentliches Netz</strong>:<ul><li>Richten Sie eine öffentliche Lastausgleichsfunktion oder das Ingress-Networking ein, um Apps bereitzustellen.</li></ul></td>
         <td><strong>Geräte</strong>:<ul><li>Lastausgleichsfunktionen verwalten</li><li>Hostname/Domäne bearbeiten</li><li>Portsteuerung verwalten</li></ul>
         <strong>Netz</strong>:<ul><li>Berechnen mit öffentlichem Netzport hinzufügen</li><li>Teilnetzrouten im Netz verwalten</li><li>IP-Adressen hinzufügen</li></ul>
         <strong>Services</strong>:<ul><li>DNS, Reverse DNS und WHOIS verwalten</li><li>Zertifikate anzeigen (SSL)</li><li>Zertifikate verwalten (SSL)</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  Klicken Sie zum Speichern Ihrer Änderungen auf **Portalberechtigungen bearbeiten**.

6.  Wählen Sie auf der Registerkarte **Gerätezugriff** die Geräte aus, für die Zugriff erteilt werden soll.

    * In der Dropdown-Liste **Gerätetyp** können Sie Zugriff auf **Alle virtuellen Server** erteilen.
    * Um Benutzern Zugriff auf neue Geräte zu erteilen, die erstellt wurden, markieren Sie **Der Zugriff wird automatisch erteilt, wenn neue Geräte hinzugefügt werden**.
    * Klicken Sie zum Speichern Ihrer Änderungen auf **Gerätezugriff aktualisieren**.

Laden Sie gerade Berechtigungen herunter? Dies kann ein paar Minuten dauern.
{: tip}

<br />

