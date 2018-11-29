---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"


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

Als Clusteradministrator können Sie Zugriffsrichtlinien für den {{site.data.keyword.containerlong}}-Cluster definieren, um verschiedene Zugriffsebenen für unterschiedliche Benutzer zu erstellen. Sie können beispielsweise bestimmte Benutzer autorisieren, mit Clusterinfrastrukturressourcen und anderen Ressourcen zu arbeiten, um nur Container bereitzustellen.
{: shortdesc}

## Erklärung der Zugriffsrichtlinien und Rollen
{: #access_policies}

Zugriffsrichtlinien legen die Zugriffsebene fest, über die Benutzer in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto auf Ressourcen mithilfe der {{site.data.keyword.Bluemix_notm}}-Plattform verfügen. Eine Richtlinie ordnet einem Benutzer mindestens eine Rolle zu, die den Geltungsbereich des Zugriffs auf einen einzelnen Service oder eine Gruppe von Services und Ressourcen definiert, die in einer Ressourcengruppe zusammengefasst sind. Für jeden Service in {{site.data.keyword.Bluemix_notm}} ist möglicherweise eine eigene Gruppe von Zugriffsrichtlinien erforderlich.
{: shortdesc}

Wenn Sie einen Plan zur Verwaltung des Benutzerzugriffs entwickeln, beachten Sie die folgenden allgemeinen Schritte:
1.  [Wählen Sie die richtige Zugriffsrichtlinie und Rolle für die Benutzer aus.](#access_roles)
2.  [Ordnen Sie den einzelnen Benutzern oder Benutzergruppen in IAM Zugriffsrollen zu.](#iam_individuals_groups)
3.  [Definieren Sie den Bereich für den Benutzerzugriff auf Clusterinstanzen oder Ressourcengruppen.](#resource_groups)

Wenn Sie verstanden haben, wie Rollen, Benutzer und Ressourcen im Konto verwaltet werden können, überprüfen Sie [Zugriff auf Cluster konfigurieren](#access-checklist) auf eine Checkliste zum Konfigurieren des Zugriffs.

### Richtige Zugriffsrichtlinie und Rolle für Benutzer auswählen
{: #access_roles}

Sie müssen Zugriffsrichtlinien für jeden Benutzer definieren, der mit {{site.data.keyword.containerlong_notm}} arbeitet. Der Geltungsbereich einer Zugriffsrichtlinie basiert auf benutzerdefinierten Rollen, die die Aktionen bestimmen, die die Benutzer ausführen können. dürfen. Einige Richtlinien sind vordefiniert, andere können jedoch angepasst werden. Es wird dieselbe Richtlinie umgesetzt, unabhängig davon, ob der Benutzer eine Anforderung über die {{site.data.keyword.containerlong_notm}}-GUI oder über die CLI startet. Dies gilt auch dann, wenn die Aktionen in IBM Cloud Infrastructure (SoftLayer) ausgeführt werden.
{: shortdesc}

Informieren Sie sich über die unterschiedlichen Typen der Berechtigungen und Rollen, mit welcher Rolle jede Aktion ausgeführt werden kann und wie die Rollen miteinander in Beziehung stehen.

Wenn Sie die spezifischen {{site.data.keyword.containerlong_notm}}-Berechtigungen für jede Rolle anzeigen möchten, überprüfen Sie dem Referenzabschnitt [Benutzerzugriffsberechtigungen](cs_access_reference.html).
{: tip}

<dl>

<dt><a href="#platform">IAM-Plattform</a></dt>
<dd>{{site.data.keyword.containerlong_notm}} verwendet {{site.data.keyword.Bluemix_notm}} Identity and Access Management-Rollen (IAM-Rollen), um Benutzern Zugriff auf Cluster zu gewähren. Von den Rollen der IAM-Plattform werden die Aktionen festgelegt, die Benutzer in einem Cluster ausführen können. Sie können die Richtlinien für diese Rollen nach Region festlegen. Jedem Benutzer, dem eine IAM-Plattformrolle zugeordnet ist, wird automatisch auch eine entsprechende RBAC-Rolle im Kubernetes-Namensbereich `default` zugewiesen. Darüber hinaus werden Sie durch die IAM-Plattformrollen berechtigt, Infrastrukturaktionen im Cluster auszuführen, Sie erhalten jedoch keinen Zugriff auf die Ressourcen der IBM Cloud-Infrastruktur (SoftLayer). Der Zugriff auf die Ressourcen der IBM Cloud-Infrastruktur (SoftLayer) ergibt sich aus dem [API-Schlüssel, der für die Region festgelegt ist](#api_key).</br></br>
Beispiele für Aktionen, zu denen die IAM-Plattformrollen berechtigen, sind das Erstellen oder Entfernen von Clustern, das Binden von Services an Cluster oder das Hinzufügen zusätzlicher Workerknoten.</dd>
<dt><a href="#role-binding">RBAC</a></dt>
<dd>In Kubernetes ist eine rollenbasierte Zugriffssteuerung (Role-Based Access Control, RBAC) eine Möglichkeit zum Sichern der Ressourcen im Cluster. Von den RBAC-Rollen hängt ab, welche Kubernetes-Aktionen Benutzer für diese Ressourcen ausführen können. Jedem Benutzer, dem eine IAM-Plattformrolle zugeordnet ist, wird automatisch eine entsprechende RBAC-Clusterrolle im Kubernetes-Namensbereich `default` zugewiesen. Diese RBAC-Clusterrolle wird abhängig von der ausgewählten IAM-Plattformrolle entweder im Standardnamensbereich oder in allen Namensbereichen angewendet.</br></br>
Beispiele für Aktionen, zu denen RBAC-Rollen berechtigen, sind das Erstellen von Objekten wie Pods oder das Lesen von Pod-Protokollen.</dd>
<dt><a href="#api_key">Infrastruktur</a></dt>
<dd>Infrastrukturrollen ermöglichen den Zugriff auf Ressourcen der IBM Cloud-Infrastruktur (SoftLayer). Richten Sie einen Benutzer mit der Infrastrukturrolle **Superuser** ein und speichern Sie die Infrastrukturberechtigungsnachweise dieses Benutzers in einem API-Schlüssel. Legen Sie anschließend den API-Schlüssel in jeder Region fest, in der Sie Cluster erstellen möchten. Nachdem Sie den API-Schlüssel eingerichtet haben, benötigen andere Benutzer, denen Sie Zugriff auf {{site.data.keyword.containerlong_notm}} erteilt haben, keine Infrastrukturrollen, da der API-Schlüssel von allen Benutzern in der Region gemeinsam genutzt wird. Stattdessen legen die IAM-Plattformrollen die Infrastrukturaktionen fest, die Benutzer ausführen dürfen. Wenn Sie den API-Schlüssel nicht mit vollständiger <strong>Superuser</strong>-Infrastruktur festlegen oder für Benutzer Zugriff auf bestimmte Geräte festlegen müssen, können Sie [Infrastrukturberechtigungen anpassen](#infra_access).</br></br>
Beispiele für Aktionen, die Infrastrukturrollen ermöglichen, sind das Anzeigen der Details von Workerknotenmaschinen in einem Cluster oder das Bearbeiten der Netzbetriebs- und Speicherressourcen.</dd>
<dt>Cloud Foundry</dt>
<dd>Nicht alle Services können mit {{site.data.keyword.Bluemix_notm}} IAM verwaltet werden. Wenn Sie einen dieser Services nutzen, können Sie weiterhin die Cloud Foundry-Benutzerrollen verwenden, um den Zugriff auf diese Services zu steuern. Cloud Foundry-Rollen gewähren Zugriff für Organisationen und Bereiche innerhalb des Kontos. Wenn Sie die Liste der Cloud Foundry-basierten Services in {{site.data.keyword.Bluemix_notm}} anzeigen möchten, führen Sie <code>ibmcloud service list</code> aus.</br></br>
Beispiele für Aktionen, zu denen Cloud Foundry-Rollen berechtigen, sind das Erstellen einer neuen Cloud Foundry-Serviceinstanzen und das Binden einer Cloud Foundry-Serviceinstanz an einen Cluster. Weitere Informationen finden Sie unter den verfügbaren [Organisations- und Benutzerrollen](/docs/iam/cfaccess.html) oder in den Schritten unter [Cloud Foundry-Zugriff verwalten](/docs/iam/mngcf.html) in der Dokumentation zu Identity and Access Management.</dd>
</dl>

### Einzelnen Benutzern oder Benutzergruppen in IAM Zugriffsrollen zuordnen
{: #iam_individuals_groups}

Wenn Sie IAM-Richtlinien festlegen, können Sie einem einzelnen Benutzer oder einer Benutzergruppe Rollen zuordnen.
{: shortdesc}

<dl>
<dt>Einzelne Benutzer</dt>
<dd>Es kann vorkommen, dass ein bestimmter Benutzer mehr oder weniger Berechtigungen als der Rest des Teams benötigt. Sie können die Berechtigungen individuell anpassen, sodass jede Person über die Berechtigungen verfügt, die sie zur Ausführung ihrer Aufgaben benötigt. Sie können jedem Benutzer mehrere IAM-Rollen zuordnen.</dd>
<dt>Mehrere Benutzer in einer Zugriffsgruppe</dt>
<dd>Sie können eine Benutzergruppe erstellen und dann dieser Gruppe Berechtigungen zuweisen. Sie können zum Beispiel alle Teamleiter zusammenfassen und der Gruppe Administratorzugriff erteilen. Anschließend können Sie alle Entwickler zusammenfassen und dieser Gruppe nur Schreibzugriff erteilen. Sie können jeder Gruppe mehrere IAM-Rollen zuordnen. Wenn Sie einer Gruppe Berechtigungen zuordnen, ist jeder Benutzer betroffen, der dieser Gruppe hinzugefügt oder aus dieser Gruppe entfernt wird. Wenn Sie der Gruppe Benutzer hinzufügen, verfügen diese Benutzer auch über den zusätzlichen Zugriff. Werden sie entfernt, wird ihr Zugriff widerrufen.</dd>
</dl>

IAM-Rollen können keinem Servicekonto zugeordnet werden. Stattdessen können Sie direkt [RBAC-Rollen zu Servicekonten zuordnen](#rbac).
{: tip}

Sie müssen außerdem angeben, ob Benutzer über Zugriff auf einen Cluster in einer Ressourcengruppe, auf alle Cluster in einer Ressourcengruppe oder auf alle Cluster in allen Ressourcengruppen im Konto verfügen.

### Bereich für Benutzerzugriff auf Clusterinstanzen oder Ressourcengruppen definieren
{: #resource_groups}

In IAM können Sie Ressourceninstanzen oder Ressourcengruppen Benutzerzugriffsrollen zuordnen.
{: shortdesc}

Wenn Sie Ihr {{site.data.keyword.Bluemix_notm}}-Konto erstellen, wird automatisch die Standardressourcengruppe erstellt. Falls Sie während der Erstellung einer Ressource keine Ressourcengruppe angeben, gehören die Ressourceninstanzen (Cluster) zur Standardressourcengruppe. Wenn Sie in Ihrem Konto eine Ressourcengruppe hinzufügen möchten, finden Sie Informationen hierzu unter [Bewährte Verfahren beim Einrichten des Kontos![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](/docs/tutorials/users-teams-applications.html#best-practices-for-organizing-users-teams-applications) und [Ressourcengruppen einrichten](/docs/resources/bestpractice_rgs.html#setting-up-your-resource-groups).

<dl>
<dt>Ressourceninstanz</dt>
  <dd><p>Jeder {{site.data.keyword.Bluemix_notm}}-Service im Konto ist eine Ressource, die über Instanzen verfügt. Die Instanzen sind von Service zu Service unterschiedlich. In {{site.data.keyword.containerlong_notm}} ist die Instanz zum Beispiel ein Cluster, in {{site.data.keyword.cloudcerts_long_notm}} ist die Instanz jedoch ein Zertifikat. Ressourcen gehören standardmäßig auch zur Standardressourcengruppe im Konto. Einem Benutzer können Sie eine Zugriffsrolle für eine Ressourceninstanz für die folgenden Szenarios zuordnen.
<ul><li>Alle IAM-Services im Konto, einschließlich aller Cluster in {{site.data.keyword.containerlong_notm}} und Images in {{site.data.keyword.registrylong_notm}}.</li>
  <li>Alle Instanzen in einem Service, zum Beispiel alle Cluster in {{site.data.keyword.containerlong_notm}}.</li>
  <li>Alle Instanzen in einer Region eines Service, zum Beispiel alle Cluster in der Region **Vereinigte Staaten (Süden)** von {{site.data.keyword.containerlong_notm}}.</li>
  <li>Eine einzelne Instanz, zum Beispiel einen Cluster.</li></ul></dd>
<dt>Ressourcengruppe</dt>
  <dd><p>Sie können Ihre Kontoressourcen in anpassbaren Gruppierungen zusammenfassen, sodass Sie einzelnen Benutzern oder Benutzergruppen schnell Zugriff auf mehrere Ressourcen gleichzeitig zuordnen können. Mit Ressourcengruppen können Operatoren und Administratoren Ressourcen filtern, um ihre aktuelle Verwendung anzuzeigen, Fehler zu beheben und Teams zu verwalten.</p>
  <p>**Wichtig:** Wenn Sie in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto über weitere Services verfügen, die Sie mit dem Cluster verwenden möchten, müssen sich die Services und der Cluster in derselben Ressourcengruppe befinden. Eine Ressource kann in nur einer Ressourcengruppe erstellt werden; eine Änderung ist danach nicht mehr möglich. Wenn Sie einen Cluster in der falschen Ressourcengruppe erstellen, müssen Sie den Cluster löschen und in der richtigen Ressourcengruppe erneut erstellen.</p>
  <p>Wenn Sie beabsichtigen, [{{site.data.keyword.monitoringlong_notm}} für Metriken](cs_health.html#view_metrics) zu verwenden, achten Sie darauf, für jeden Cluster einen Namen festzulegen, der in allen Ressourcengruppen und Regionen des Kontos eindeutig ist, um Konflikte bei Metriknamen zu vermeiden. Sie können einen Cluster nicht umbenennen.</p>
  <p>Einem Benutzer können Sie eine Zugriffsrolle für eine Ressourcengruppe für die folgenden Szenarios zuordnen. Beachten Sie, dass Sie im Gegensatz zu Ressourceninstanzen nicht Zugriff auf eine einzelne Instanz innerhalb einer Ressourcengruppe erteilen können.</p>
  <ul><li>Alle IAM-Services in der Ressourcengruppe, einschließlich aller Cluster in {{site.data.keyword.containerlong_notm}} und Images in {{site.data.keyword.registrylong_notm}}.</li>
  <li>Alle Instanzen in einem Service in der Ressourcengruppe, zum Beispiel alle Cluster in {{site.data.keyword.containerlong_notm}}.</li>
  <li>Alle Instanzen in einer Region eines Service in einer Ressourcengruppe, zum Beispiel alle Cluster in der Region **Vereinigte Staaten (Süden)** von {{site.data.keyword.containerlong_notm}}.</li></ul></dd>
</dl>

<br />


## Zugriff auf Cluster konfigurieren
{: #access-checklist}

Nachdem Sie [sich damit vertraut gemacht haben, wie Rollen, Benutzer und Ressourcen im Konto](#access_policies) verwaltet werden können, verwenden Sie die folgende Checkliste zum Konfigurieren des Benutzerzugriffs im Cluster.
{: shortdesc}

1. [Legen Sie den API-Schlüssel](#api_key) für alle Regionen und Ressourcengruppen fest, in denen Sie Cluster erstellen möchten.
2. Laden Sie Benutzer zu Ihrem Konto ein und [ordnen Sie ihnen IAM-Rollen](#platform) für {{site.data.keyword.containerlong_notm}} zu. 
3. Um Benutzern das Binden von Services an den Cluster oder das Anzeigen von Protokollen zu ermöglichen, die von Clusterprotokollierungskonfigurationen weitergeleitet werden, [erteilen Sie den Benutzern Cloud Foundry-Rollen](/docs/iam/mngcf.html) für die Organisation und den Bereich, in der bzw. dem die Services bereitgestellt werden oder die Protokolle erfasst werden.
4. Wenn Sie Kubernetes-Namensbereiche verwenden, um Ressourcen im Cluster zu isolieren, [kopieren Sie die Kubernetes-RBAC-Rollenbindungen für die IAM-Plattformrollen **Anzeigeberechtigter** und **Editor** in andere Namensbereiche](#role-binding).
5. Legen Sie für alle Automatisierungstools, wie zum Beispiel die CI/CD-Pipeline, Servicekonten fest und [ordnen Sie den Servicekonten Kubernetes-RBAC-Berechtigungen zu](#rbac).
6. Weitere erweiterte Konfigurationen zum Steuern des Zugriffs auf die Clusterressourcen auf Pod-Ebene finden Sie unter [Sicherheit für Pods konfigurieren](/docs/containers/cs_psp.html).

</br>

Weitere Informationen zum Konfigurieren des Kontos und der Ressourcen finden Sie im Lernprogramm zu [Best Practices für die Organisation von Benutzern, Teams und Anwendungen](/docs/tutorials/users-teams-applications.html#best-practices-for-organizing-users-teams-applications).
{: tip}

<br />


## API-Schlüssel für Aktivierung des Zugriffs auf Infrastrukturportfolio konfigurieren
{: #api_key}

Um erfolgreich Cluster bereitzustellen und mit diesen zu arbeiten, müssen Sie sicherstellen, dass Ihr {{site.data.keyword.Bluemix_notm}}-Konto korrekt für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) konfiguriert wurde.
{: shortdesc}

**Meiste Fälle:** Das nutzungsabhängige {{site.data.keyword.Bluemix_notm}}-Konto verfügt bereits über Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer). Wenn der {{site.data.keyword.containerlong_notm}}-Zugriff auf das Portfolio konfiguriert werden soll, muss der **Kontoeigner** den API-Schlüssel für die Region und die Ressourcengruppe festlegen.

1. Melden Sie sich als Kontoeigner am Terminal an.
    ```
    ibmcloud login [--sso]
    ```
    {: pre}

2. Geben Sie die Ressourcengruppe als Ziel an, in der Sie den API-Schlüssel festlegen möchten. Wenn Sie keine Ressourcengruppe als Ziel angeben, wird der API-Schlüssel für die Standardressourcengruppe festgelegt.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {:pre}

3. Wenn Sie sich in einer anderen Region befinden, wechseln Sie in die Region, in der Sie den API-Schlüssel festlegen möchten.
    ```
    ibmcloud ks region-set
    ```
    {: pre}

4. Definieren Sie den API-Schlüssel für die Region und die Ressourcengruppe.
    ```
    ibmcloud ks api-key-reset
    ```
    {: pre}    

5. Überprüfen Sie, dass der API-Schlüssel festgelegt wurde.
    ```
    ibmcloud ks api-key-info <clustername_oder-_id>
    ```
    {: pre}

6. Wiederholen Sie die Schritte für jede Region und Ressourcengruppe, in der Sie Cluster erstellen möchten.

**Alternative Optionen und weitere Informationen:** Informationen zu weiteren Möglichkeiten für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) finden Sie in den folgenden Abschnitten.
* Wenn Sie sich nicht sicher sind, ob Ihr Konto bereits über Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) verfügt, lesen Sie den Abschnitt [Informationen zum Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer)](#understand_infra).
* Wenn der Kontoeigner keinen API-Schlüssel festlegt, [stellen Sie sicher, dass der Benutzer, der den API-Schlüssel festlegt, über die passenden Berechtigungen verfügt](#owner_permissions).
* Weitere Informationen zur Verwendung des Standardkontos zum Festlegen des API-Schlüssels finden Sie im Abschnitt [Mit nutzungsabhängigem {{site.data.keyword.Bluemix_notm}}-Standardkonto auf Infrastrukturportfolio zugreifen](#default_account).
* Falls Sie nicht über ein nutzungsabhängiges Standardkonto verfügen oder ein abweichendes Konto der IBM Cloud-Infrastruktur (SoftLayer) verwenden müssen, finden Sie Informationen im Abschnitt [Auf anderes Konto der IBM Cloud-Infrastruktur (SoftLayer) zugreifen](#credentials).

### Informationen zum Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer)
{: #understand_infra}

Stellen Sie fest, ob Ihr Konto über Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) verfügt und machen Sie sich damit vertraut, wie der API-Schlüssel von {{site.data.keyword.containerlong_notm}} für den Zugriff auf das Portfolio verwendet wird.
{: shortdesc}

**Verfügt mein Konto bereits über Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer)?**</br>

Für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) verwenden Sie ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto. Wenn Sie über einen anderen Kontotyp verfügen, finden Sie Ihre Optionen in der folgenden Tabelle.

<table summary="In der Tabelle werden die Standardoptionen für die Clustererstellung nach Kontotyp angezeigt. Die Zeilen sind von links nach rechts zu lesen, mit der Kontobeschreibung in Spalte eins und den Optionen zum Erstellen eines Standardclusters in Spalte 2.">
<caption>Erstellungsoptionen für Standardcluster nach Kontotyp</caption>
  <thead>
  <th>Kontobeschreibung</th>
  <th>Optionen zum Erstellen eines Standardclusters</th>
  </thead>
  <tbody>
    <tr>
      <td>Mit **Lite-Konten** können keine Cluster bereitgestellt werden.</td>
      <td>[Führen Sie für Ihr Lite-Konto ein Upgrade auf ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto durch](/docs/account/index.html#paygo).</td>
    </tr>
    <tr>
      <td>**Nutzungsabhängige Konten** werden mit Zugriff auf das Infrastruktur-Portfolio geliefert.</td>
      <td>Sie können Standardcluster erstellen. Verwenden Sie einen API-Schlüssel, um die Infrastrukturberechtigungen für die Cluster einzurichten.</td>
    </tr>
    <tr>
      <td>**Abonnementkonten** werden ohne Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) eingerichtet.</td>
      <td><p><strong>Option 1:</strong> [Erstellen Sie ein neues nutzungsabhängiges Konto](/docs/account/index.html#paygo), das mit Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) eingerichtet wird. Wenn Sie diese Option auswählen, erhalten Sie zwei separate {{site.data.keyword.Bluemix_notm}}-Konten und -Abrechnungen.</p><p>Wenn Sie Ihr Abonnementkonto weiterhin verwenden möchten, können Sie mit Ihrem neuen nutzungsabhängigen Konto einen API-Schlüssel in der IBM Cloud-Infrastruktur (SoftLayer) generieren. Anschließend müssen Sie für Ihr Abonnementkonto den API-Schlüssel der IBM Cloud-Infrastruktur (SoftLayer) manuell festlegen. Beachten Sie, dass Ressourcen der IBM Cloud-Infrastruktur (SoftLayer) über Ihr neues nutzungsabhängiges Konto in Rechnung gestellt werden.</p><p><strong>Option 2:</strong> Wenn Sie bereits ein Konto der IBM Cloud-Infrastruktur (SoftLayer) haben, das Sie verwenden möchten, können Sie die Berechtigungsnachweise für die IBM Cloud-Infrastruktur (SoftLayer) für Ihr {{site.data.keyword.Bluemix_notm}}-Konto manuell festlegen.</p><p>**Anmerkung:** Wenn Sie eine manuelle Verknüpfung zu einem Konto der IBM Cloud-Infrastruktur (SoftLayer) herstellen, werden die Berechtigungsnachweise für jede für die IBM Cloud-Infrastruktur (SoftLayer) spezifische Aktion in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verwendet. Sie müssen sicherstellen, dass der von Ihnen angegebene API-Schlüssel über [ausreichende Infrastrukturberechtigungen](cs_users.html#infra_access) verfügt, damit die Benutzer Cluster erstellen und mit diesen arbeiten können.</p></td>
    </tr>
    <tr>
      <td>**Konten der IBM Cloud-Infrastruktur (SoftLayer)**, kein {{site.data.keyword.Bluemix_notm}}-Konto</td>
      <td><p>[Erstellen Sie ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto](/docs/account/index.html#paygo). Sie verfügen über zwei separate Konten der IBM Cloud-Infrastruktur (SoftLayer) und jeweils separate Abrechnungen.</p><p>Ihr neues {{site.data.keyword.Bluemix_notm}}-Konto verwendet standardmäßig das neue Infrastrukturkonto. Wenn Sie das alte Infrastrukturkonto weiter verwenden möchten, legen Sie die Berechtigungsnachweise manuell fest.</p></td>
    </tr>
  </tbody>
  </table>

**Das Infrastrukturportfolio ist jetzt eingerichtet. Wie wird von {{site.data.keyword.containerlong_notm}} auf das Portfolio zugegriffen?**</br>

{{site.data.keyword.containerlong_notm}} greift über einen API-Schlüssel auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) zu. Im API-Schlüssel werden die Berechtigungsnachweise eines Benutzers mit Zugriff auf ein Konto der IBM Cloud-Infrastruktur (SoftLayer) gespeichert. API-Schlüssel werden nach Region in einer Ressourcengruppe festgelegt und von den Benutzern in dieser Region gemeinsam genutzt. Damit alle Benutzer auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) zugreifen können, muss der Benutzer, dessen Berechtigungsnachweise im API-Schlüssel gespeichert sind, über [die Infrastrukturrolle **Superuser** und die Plattformrolle **Administrator**](#owner_permissions) für {{site.data.keyword.containerlong_notm}} im IBM Cloud-Konto verfügen. Danach kann dieser Benutzer die erste Administratoraktion in einer Region ausführen. Die Berechtigungsnachweise des Benutzers für die Infrastruktur werden in einem API-Schlüssel für diese Region gespeichert. Andere Benutzer innerhalb des Kontos nutzen den API-Schlüssel für den Zugriff auf die Infrastruktur gemeinsam. Sie können steuern, welche Infrastrukturaktionen die Benutzer ausführen können, indem Sie die entsprechende [IAM-Plattformrolle](#platform) zuordnen.

Wenn Sie beispielsweise einen Cluster in einer neuen Region erstellen möchten, stellen Sie sicher, dass der erste Cluster von einem Benutzer mit der Infrastrukturrolle **Superuser** erstellt wird, zum Beispiel dem Kontoeigner. Anschließend können Sie einzelne Benutzer oder Benutzer in IAM-Zugriffsgruppen in diese Region einladen, indem Sie die IAM-Plattformverwaltungsrichtlinien für sie in dieser Region festlegen. Ein Benutzer mit der IAM-Plattformrolle `Anzeigeberechtigter` ist nicht berechtigt, einen Workerknoten hinzuzufügen. Daher schlägt die Aktion `worker-add` fehl, auch wenn der API-Schlüssel über die richtigen Infrastrukturberechtigungen verfügt. Wenn Sie die IAM-Plattformrolle des Benutzers in **Operator** ändern, ist der Benutzer berechtigt, einen Workerknoten hinzuzufügen. Die Aktion `worker-add` ist erfolgreich, weil die Benutzerrolle berechtigt und der API-Schlüssel korrekt definiert ist. Sie müssen die Berechtigungen des Benutzers für die IBM Cloud-Infrastruktur (SoftLayer) nicht bearbeiten.

**Was kann ich tun, wenn ich dem Eigner des API-Schlüssels oder der Berechtigungsnachweise nicht die Infrastrukturrolle eines Superusers zuweisen möchte?**</br>

Es kann vorkommen, dass Compliance-, Sicherheits- oder Abrechnungsgründe dagegen sprechen, die Infrastrukturrolle **Superuser** dem Benutzer zuzuweisen, der den API-Schlüssel festlegt oder dessen Berechtigungsnachweis mit dem Befehl `ibmcloud ks credentials-set` festgelegt werden. Wenn dieser Benutzer jedoch nicht über die Rolle **Superuser** verfügt, können infrastrukturbezogene Aktionen, wie zum Beispiel das Erstellen eines Clusters oder das erneute Laden eines Workerknotens, fehlschlagen. Anstatt IAM-Plattformrollen zu verwenden, um den Infrastrukturzugriff der Benutzer zu steuern, müssen Sie für die Benutzer [bestimmte Berechtigungen für die IBM Cloud-Infrastruktur (SoftLayer) festlegen](#infra_access).

**Wie lege ich den API-Schlüssel für meinen Cluster fest?**</br>

Das hängt davon ab, welchen Kontotyp Sie für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) verwenden:
* [Ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto](#default_account)
* [Ein anderes Konto der IBM Cloud-Infrastruktur (SoftLayer), das nicht mit dem nutzungsabhängigen {{site.data.keyword.Bluemix_notm}}-Standardkonto verknüpft ist](#credentials)

### Sicherstellen, dass der Eigner des API-Schlüssels oder der Infrastrukturberechtigungsnachweise über die passenden Berechtigungen verfügt
{: #owner_permissions}

Um sicherzustellen, dass alle infrastrukturbezogenen Aktionen im Cluster erfolgreich ausgeführt werden können, muss der Benutzer, dessen Berechtigungsnachweise Sie für den API-Schlüssel festlegen möchten, über die entsprechenden Berechtigungen verfügen.
{: shortdesc}

1. Melden Sie sich an der [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) an.

2. Überprüfen Sie, ob der Benutzer über die passenden IAM-Plattformrollen verfügt, um sicherzustellen, dass alle kontenbezogenen Aktionen erfolgreich ausgeführt werden können.
    1. Navigieren Sie zu **Verwalten > Konto > Benutzer**.
    2. Klicken Sie auf den Namen des Benutzers, für den Sie den API-Schlüssel festlegen möchten oder dessen Berechtigungsnachweise Sie für den API-Schlüssel festlegen möchten.
    3. Wenn der Benutzer nicht über die Rolle **Administrator** für alle {{site.data.keyword.containerlong_notm}}-Cluster in allen Regionen verfügt, [ordnen Sie dem Benutzer diese Plattform zu](#platform).
    4. Wenn der Benutzer nicht mindestens über die Rolle **Anzeigeberechtigter** für die Ressourcengruppe verfügt, in der Sie den API-Schlüssel festlegen möchten, [ordnen Sie dem Benutzer die Rolle für diese Ressourcengruppe zu](#platform).
    5. Zum Erstellen von Clustern benötigt der Benutzer auch die Rolle **Administrator** für {{site.data.keyword.registryshort_notm}}.

3. Überprüfen Sie, ob der Benutzer über die passenden Infrastrukturzugriffsrichtlinien verfügt, um sicherzustellen, dass alle infrastrukturbezogenen Aktionen im Cluster erfolgreich ausgeführt werden können.
    1. Wählen Sie im Erweiterungsmenü die Option **Infrastruktur** aus.
    2. Wählen Sie in der Menüleiste **Konto** > **Benutzer** > **Benutzerliste** aus.
    3. Stellen Sie in der Spalte **API-Schlüssel** sicher, dass der Benutzer über einen API-Schlüssel verfügt, oder klicken Sie auf die Option zum **Generieren**.
    4. Wählen Sie den Namen des Benutzerprofils aus und überprüfen Sie die Berechtigungen des Benutzers.
    5. Wenn der Benutzer nicht über die Rolle **Superuser** verfügt, klicken Sie auf die Registerkarte **Portalberechtigungen**.
        1. Verwenden Sie die Dropdown-Liste **Schnellberechtigungen**, um die Rolle **Superuser** zuzuweisen.
        2. Klicken Sie auf **Berechtigungen festlegen**.

### Mit nutzungsabhängigem {{site.data.keyword.Bluemix_notm}}-Standardkonto auf Infrastrukturportfolio zugreifen
{: #default_account}

Wenn Sie über ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto verfügen, haben Sie standardmäßig Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer). Der API-Schlüssel wird verwendet, um Infrastrukturressourcen aus dem Portfolio der IBM Cloud-Infrastruktur (SoftLayer) zu bestellen, zum Beispiel neue Workerknoten oder VLANs.
{: shortdec}

Sie können den aktuellen Eigner eines API-Schlüssels finden, indem Sie den Befehl [`ibmcloud ks api-key-info`](cs_cli_reference.html#cs_api_key_info) ausführen. Wenn Sie feststellen, dass Sie den API-Schlüssel aktualisieren müssen, der für eine Region gespeichert ist, können Sie dies tun, indem Sie den Befehl [`ibmcloud ks api-key-reset`](cs_cli_reference.html#cs_api_key_reset) ausführen. Dieser Befehl erfordert die {{site.data.keyword.containerlong_notm}}-Administratorzugriffsrichtlinie und speichert den API-Schlüssel des Benutzers, der diesen Befehl ausführt, im Konto. **Hinweis:** Stellen Sie sicher, dass Sie den Schlüssel zurücksetzen möchten und die Auswirkungen auf Ihre App verstehen. Der Schlüssel wird an mehreren unterschiedlichen Stellen verwendet und kann zu unterbrechenden Änderungen führen, wenn er unnötigerweise geändert wird.

**Vorbereitende Schritte**:
- Wenn der Kontoeigner keinen API-Schlüssel festlegt, [stellen Sie sicher, dass der Benutzer, der den API-Schlüssel festlegt, über die passenden Berechtigungen verfügt](#owner_permissions).
- [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)

Gehen Sie wie folgt vor, um den API-Schlüssel für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) festzulegen:

1.  Legen Sie für die Region und Ressourcengruppe, in der sich der Cluster befindet, den API-Schlüssel fest.
    1.  Melden Sie sich bei dem Terminal als der Benutzer an, dessen Infrastrukturberechtigungen Sie verwenden möchten.
    2.  Geben Sie die Ressourcengruppe als Ziel an, in der Sie den API-Schlüssel festlegen möchten. Wenn Sie keine Ressourcengruppe als Ziel angeben, wird der API-Schlüssel für die Standardressourcengruppe festgelegt.
        ```
        ibmcloud target -g <resource_group_name>
        ```
        {:pre}
    3.  Wenn Sie sich in einer anderen Region befinden, wechseln Sie in die Region, in der Sie den API-Schlüssel festlegen möchten.
        ```
        ibmcloud ks region-set
        ```
        {: pre}
    4.  Legen Sie den API-Schlüssel für die Region fest.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    5.  Überprüfen Sie, dass der API-Schlüssel festgelegt wurde.
        ```
        ibmcloud ks api-key-info <clustername_oder-_id>
        ```
        {: pre}

2. [Erstellen Sie einen Cluster](cs_clusters.html). Zum Erstellen des Clusters werden die Berechtigungsnachweise für den API-Schlüssel verwendet, die Sie für die Region und die Ressourcengruppe festgelegt haben.

### Auf anderes Konto der IBM Cloud-Infrastruktur (SoftLayer) zugreifen
{: #credentials}

Anstatt das verknüpfte Standardkonto der IBM Cloud-Infrastruktur (SoftLayer) zu verwenden, um Infrastruktur für Cluster in einer Region zu bestellen, möchten Sie vielleicht ein anderes Konto der IBM Cloud-Infrastruktur (SoftLayer) verwenden, das über das Sie bereits verfügen. Sie können dieses Infrastrukturkonto mit Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verbinden, indem Sie den Befehl [`ibmcloud ks credentials-set`](cs_cli_reference.html#cs_credentials_set) verwenden. Die Berechtigungsnachweise für die IBM Cloud-Infrastruktur (SoftLayer) werden anstatt der Berechtigungsnachweise für das nutzungsabhängige Standardkonto verwendet, die für die Region gespeichert sind.

**Wichtig:** Die Berechtigungsnachweise der IBM Cloud-Infrastruktur (SoftLayer), die unter Verwendung des Befehls `ibmcloud ks credentials-set` festgelegt wurden, bleiben nach dem Ende der Sitzung bestehen. Wenn Sie die Berechtigungsnachweise für die IBM Cloud-Infrastruktur (SoftLayer) entfernen, die manuell mit dem Befehl [`ibmcloud ks credentials-unset`](cs_cli_reference.html#cs_credentials_unset) festgelegt wurden, werden die Berechtigungsnachweise für das nutzungsabhängige Standardkonto verwendet. Eine solche Änderung der Berechtigungsnachweise für Infrastrukturkonten kann jedoch zu [verwaisten Clustern](cs_troubleshoot_clusters.html#orphaned) führen.

**Vorbereitende Schritte**:
- Wenn Sie nicht die Berechtigungsnachweise des Kontoeigners verwenden, [stellen Sie sicher, dass der Benutzer, dessen Berechtigungsnachweise Sie für den API-Schlüssel festlegen möchten, über die passenden Berechtigungen verfügt](#owner_permissions).
- [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)

Gehen Sie wie folgt vor, um die Berechtigungsnachweise für das Infrastrukturkonto für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) festzulegen:

1. Rufen Sie das Infrastrukturkonto ab, das Sie für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) verwenden möchten. Sie haben verschiedene Optionen, die sich nach Ihrem [aktuellen Kontotyp](#understand_infra) richten.

2.  Legen Sie die Infrastruktur-API-Berechtigungsnachweise mit dem richtigen Benutzer für das Konto fest.

    1.  Rufen Sie die Infrastruktur-API-Berechtigungsnachweise des Benutzers ab. **Anmerkung**: Die Berechtigungsnachweise lauten anders als die IBMid.

        1.  Klicken Sie in der Tabelle **Infrastruktur** > **Konto** > **Benutzer** > **Benutzerliste** der [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) auf **IBMid** oder **Benutzername**.

        2.  Zeigen Sie im Abschnitt **API-Zugriffsinformationen** die Werte für **API-Benutzername** und **Authentifizierungsschlüssel** an.    

    2.  Legen Sie die zu verwendenden Berechtigungsnachweise für die Infrastruktur-API fest.
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastruktur-api-benutzername> --infrastructure-api-key <infrastruktur-api-authentifizierungsschlüssel>
        ```
        {: pre}

    3. Stellen Sie sicher, dass die ordnungsgemäßen Berechtigungsnachweise festgelegt wurden.
        ```
        ibmcloud ks credential-get
        ```
        Beispielausgabe:
        ```
        Infrastructure credentials for user name user@email.com set for resource group default.
        ```
        {: screen}

3. [Erstellen Sie einen Cluster](cs_clusters.html). Zum Erstellen des Clusters werden die Infrastrukturberechtigungsnachweise verwendet, die Sie für die Region und die Ressourcengruppe festgelegt haben.

4. Stellen Sie sicher, dass vom Cluster die festgelegten Berechtigungsnachweise für das Infrastrukturkonto verwendet werden.
  1. Öffnen Sie die [grafische Benutzerschnittstelle für den IBM Cloud Kubernetes-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/containers-kubernetes/clusters) und wählen Sie Ihren Cluster aus.
  2. Suchen Sie in der Registerkarte 'Übersicht' nach dem Feld **Infrastrukturbenutzer**.
  3. Wenn Sie dieses Feld sehen, bedeutet das, dass Sie nicht die Standard-Infrastrukturberechtigungsnachweise verwenden, die im Umfang Ihres nutzungsabhängigen Kontos in dieser Region enthalten sind. Stattdessen ist für die Region festgelegt, dass andere Berechtigungsnachweise für das Infrastrukturkonto verwendet werden, die Sie festgelegt haben.

<br />


## Benutzern Zugriff auf Cluster über IAM erteilen
{: #platform}

Definieren Sie IAM-Plattformverwaltungsrichtlinien in der [grafischen Benutzerschnittstelle](#add_users) oder in der [Befehlszeilenschnittstelle](#add_users_cli), damit die Benutzer mit Clustern in {{site.data.keyword.containerlong_notm}} arbeiten können. Lesen Sie bevor Sie beginnen [Erklärung der Zugriffsrichtlinien und Rollen](#access_policies), um zu überprüfen, was Richtlinien sind, wem Sie Richtlinien zuordnen können und für welche Ressourcen Richtlinien erteilt werden können.
{: shortdesc}

IAM-Rollen können keinem Servicekonto zugeordnet werden. Stattdessen können Sie direkt [RBAC-Rollen zu Servicekonten zuordnen](#rbac).
{: tip}

### IAM-Rollen über die grafische Benutzerschnittstelle zuweisen
{: #add_users}

Erteilen Sie Benutzern durch das Zuweisen von IAM-Plattformmanagementrollen über die grafische Benutzerschnittstelle Zugriff auf Cluster.
{: shortdesc}

Bevor Sie damit beginnen, vergewissern Sie sich, dass Ihnen die IAM-Plattformrolle **Administrator** für das {{site.data.keyword.Bluemix_notm}}-Konto zugeordnet ist, in dem Sie arbeiten. 

1. Melden Sie sich an der [grafischen IBM Cloud-Benutzerschnittstelle](https://console.bluemix.net/) an und navigieren Sie zu **Verwalten > Konto > Benutzer**.

2. Wählen Sie die Benutzer einzeln aus oder erstellen Sie eine Zugriffsgruppe für Benutzer.
    * Gehen Sie wie folgt vor, um einem einzelnen Benutzer Rollen zuzuordnen:
      1. Klicken Sie auf den Namen des Benutzers, für den Sie Berechtigungen festlegen möchten. Wenn der Benutzer nicht angezeigt wird, klicken Sie auf **Benutzer einladen**, um diese dem Konto hinzuzufügen.
      2. Klicken Sie auf **Zugriff zuweisen**.
    * Gehen Sie wie folgt vor, um mehreren Benutzern in einer Zugriffsgruppe Rollen zuzuordnen:
      1. Klicken Sie in der Navigation auf der linken Seite auf **Zugriffsgruppen**.
      2. Klicken Sie auf **Erstellen** und geben Sie Ihrer Gruppe einen **Namen** und eine **Beschreibung**. Klicken Sie auf **Erstellen**.
      3. Klicken Sie auf **Benutzer hinzufügen**, um Ihrer Zugriffsgruppe Personen hinzuzufügen. Es wird eine Liste mit Benutzern angezeigt, die Zugriff auf Ihr Konto haben.
      4. Wählen Sie das Kästchen neben den Benutzern aus, die Sie zur Gruppe hinzufügen möchten. Ein Dialogfeld wird angezeigt.
      5. Klicken Sie auf **Zu Gruppe hinzufügen**.
      6. Klicken Sie auf **Zugriffsrichtlinien**.
      7. Klicken Sie auf **Zugriff zuweisen**.

3. Weisen Sie eine Richtlinie zu.
  * Für den Zugriff auf alle Cluster in einer Ressourcengruppe:
    1. Klicken Sie auf **Zugriff in einer Ressourcengruppe zuweisen** aus.
    2. Wählen Sie den Ressourcengruppennamen aus.
    3. Wählen Sie in der Liste **Services** den Eintrag **{{site.data.keyword.containershort_notm}}** aus.
    4. Wählen Sie in der Liste **Region** eine Region oder alle Regionen aus.
    5. Wählen Sie eine **Plattformzugriffsrolle** aus. Eine Liste der unterstützten Aktionen pro Rolle finden Sie unter [Benutzerzugriffsberechtigungen](/cs_access_reference.html#platform).
    6. Klicken Sie auf **Zuweisen**.
  * Für den Zugriff auf einen Cluster in einer Ressourcengruppe oder für alle Cluster in allen Ressourcengruppen gilt Folgendes:
    1. Klicken Sie auf **Zugriff auf Ressourcen zuweisen**.
    2. Wählen Sie in der Liste **Services** den Eintrag **{{site.data.keyword.containershort_notm}}** aus.
    3. Wählen Sie in der Liste **Region** eine Region oder alle Regionen aus.
    4. Wählen Sie in der Liste **Serviceinstanz** einen Clusternamen oder **Alle Serviceinstanzen** aus.
    5. Wählen Sie im Abschnitt **Rollen auswählen** eine IAM-Plattformzugriffsrolle aus. Eine Liste der unterstützten Aktionen pro Rolle finden Sie unter [Benutzerzugriffsberechtigungen](/cs_access_reference.html#platform). Anmerkung: Wenn Sie einem Benutzer die IAM-Plattformrolle **Administrator** für nur einen Cluster zuordnen, müssen Sie dem Benutzer auch die Rolle **Anzeigeberechtigter** für alle Cluster in dieser Region in der Ressourcengruppe zuordnen.
    6. Klicken Sie auf **Zuweisen**.

4. Wenn die Benutzer in der Lage sein sollen, mit Clustern in einer anderen Ressourcengruppe als der Standardressourcengruppe zu arbeiten, benötigen diese Benutzer zusätzlich Zugriff auf die Ressourcengruppen, in denen sich die Cluster befinden. Sie können diesen Benutzern mindestens die Rolle **Anzeigeberechtigter** für Ressourcengruppen zuordnen.
  1. Klicken Sie auf **Zugriff in einer Ressourcengruppe zuweisen**.
  2. Wählen Sie den Ressourcengruppennamen aus.
  3. Wählen Sie in der Liste **Zugriff für eine Ressourcengruppe zuweisen** die Rolle **Anzeigeberechtigter** aus. Diese Rolle ermöglicht es Benutzern, auf die Ressourcengruppe selbst zuzugreifen, aber nicht auf Ressourcen innerhalb der Gruppe.
  4. Klicken Sie auf **Zuweisen**.

### IAM-Rollen über die Befehlszeilenschnittstelle zuweisen
{: #add_users_cli}

Erteilen Sie Benutzern durch das Zuweisen von IAM-Plattformmanagementrollen über die Befehlszeilenschnittstelle Zugriff auf Cluster.
{: shortdesc}

**Vorbereitende Schritte**:

- Vergewissern Sie sich, dass Ihnen die IAM-Plattformrolle `cluster-admin` (Clusteradministrator) für das {{site.data.keyword.Bluemix_notm}}-Konto zugeordnet ist, in dem Sie arbeiten.
- Stellen Sie sicher, dass der Benutzer zum Konto hinzugefügt wurde. Wenn der Benutzer nicht hinzugefügt wurde, laden Sie den Benutzer zu Ihrem Konto ein, indem Sie `ibmcloud account user-invite<user@email.com>` ausführen.
- [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)

**Gehen Sie wie folgt vor, um einem einzelnen Benutzer in der Befehlszeilenschnittstelle IAM-Rollen zuzuweisen:**

1.  Erstellen Sie eine IAM-Zugriffsrichtlinie, um Berechtigungen für {{site.data.keyword.containerlong_notm}} (**`--service-name container-kubernetes`**) festzulegen. Sie können die Rollen 'Anzeigeberechtigter', 'Editor', 'Operator' und 'Administrator' auswählen. Eine Liste der unterstützten Aktionen pro Rolle finden Sie unter [Benutzerzugriffsberechtigungen](cs_access_reference.html#platform).
    * Gehen Sie wie folgt vor, um Zugriff auf einen Cluster in einer Ressourcengruppe zuzuordnen:
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **Anmerkung:** Wenn Sie einem Benutzer die IAM-Plattformrolle **Administrator** für nur einen Cluster zuordnen, müssen Sie dem Benutzer auch die Rolle **Anzeigeberechtigter** für alle Cluster in dieser Region der Ressourcengruppe zuordnen.

    * Gehen Sie wie folgt vor, um Zugriff auf alle Cluster in einer Ressourcengruppe zuzuordnen:
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

    * Gehen Sie wie folgt vor, um Zugriff auf alle Cluster in allen Ressourcengruppen zuzuordnen:
      ```
      ibmcloud iam user-policy-create <benutzer-e-mail> --service-name containers-kubernetes --roles <rolle>
      ```
      {: pre}

2. Wenn die Benutzer in der Lage sein sollen, mit Clustern in einer anderen Ressourcengruppe als der Standardressourcengruppe zu arbeiten, benötigen diese Benutzer zusätzlichen Zugriff auf die Ressourcengruppen, in denen sich die Cluster befinden. Sie können diesen Benutzern mindestens die Rolle **Anzeigeberechtigter** für Ressourcengruppen zuordnen. Zum Suchen der Ressourcengruppen-ID können Sie `ibmcloud resource group <resource_group_name> --id` ausführen.
    ```
    ibmcloud iam user-policy-create <user-email_OR_access-group> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

3. Aktualisieren Sie die Clusterkonfiguration, damit die Änderungen wirksam werden.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

4. Die IAM-Plattformrolle wird automatisch als entsprechende [RBAC-Rollenbindung oder Clusterrollenbindung](#role-binding) angewendet. Stellen Sie sicher, dass der Benutzer der RBAC-Rolle hinzugefügt wird; führen Sie hierzu einen der folgenden Befehle für die von Ihnen zugeordnete IAM-Plattformrolle aus:
    * Anzeigeberechtigter:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operator:
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * Administrator:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  Wenn Sie zum Beispiel dem Benutzer `john@email.com` die IAM-Plattformrolle **Anzeigeberechtigter** zuordnen und `kubectl get rolebinding ibm-view -o yaml -n default` ausführen, wird folgende Ausgabe angezeigt:

  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-view
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-view
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: view
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: https://iam.ng.bluemix.net/IAM#user@email.com
  ```
  {: screen}


**Gehen Sie wie folgt vor, um IAM-Plattformrollen mehreren Benutzern in einer Zugriffsgruppe mit der Befehlszeilenschnittstelle zuzuweisen:**

1. Erstellen Sie eine Zugriffsgruppe.
    ```
    ibmcloud iam access-group-create <access_group_name>
    ```
    {: pre}

2. Fügen Sie Benutzer zur Zugriffsgruppe hinzu.
    ```
    ibmcloud iam access-group-user-add <access_group_name> <user_email>
    ```
    {: pre}

3. Erstellen Sie eine IAM-Zugriffsrichtlinie, um Berechtigungen für {{site.data.keyword.containerlong_notm}} festzulegen. Sie können die Rollen 'Anzeigeberechtigter', 'Editor', 'Operator' und 'Administrator' auswählen. Eine Liste der unterstützten Aktionen pro Rolle finden Sie unter [Benutzerzugriffsberechtigungen](/cs_access_reference.html#platform).
  * Gehen Sie wie folgt vor, um Zugriff auf einen Cluster in einer Ressourcengruppe zuzuordnen:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **Anmerkung:** Wenn Sie einem Benutzer die IAM-Plattformrolle **Administrator** für nur einen Cluster zuordnen, müssen Sie dem Benutzer auch die Rolle **Anzeigeberechtigter** für alle Cluster in der Region in der Ressourcengruppe zuordnen.

  * Gehen Sie wie folgt vor, um Zugriff auf alle Cluster in einer Ressourcengruppe zuzuordnen:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

  * Gehen Sie wie folgt vor, um Zugriff auf alle Cluster in allen Ressourcengruppen zuzuordnen:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

4. Wenn die Benutzer in der Lage sein sollen, mit Clustern in einer anderen Ressourcengruppe als der Standardressourcengruppe zu arbeiten, benötigen diese Benutzer zusätzlichen Zugriff auf die Ressourcengruppen, in denen sich die Cluster befinden. Sie können diesen Benutzern mindestens die Rolle **Anzeigeberechtigter** für Ressourcengruppen zuordnen. Zum Suchen der Ressourcengruppen-ID können Sie `ibmcloud resource group <resource_group_name> --id` ausführen.
    ```
    ibmcloud iam access-group-policy-create <access_group_name> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

    1. Wenn Sie den Zugriff auf alle Cluster in allen Ressourcengruppen zugeordnet haben, wiederholen Sie diesen Befehl für jede Ressourcengruppe im Konto.

5. Aktualisieren Sie die Clusterkonfiguration, damit die Änderungen wirksam werden.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

6. Die IAM-Plattformrolle wird automatisch als entsprechende [RBAC-Rollenbindung oder Clusterrollenbindung](#role-binding) angewendet. Stellen Sie sicher, dass der Benutzer der RBAC-Rolle hinzugefügt wird; führen Sie hierzu einen der folgenden Befehle für die von Ihnen zugeordnete IAM-Plattformrolle aus:
    * Anzeigeberechtigter:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operator:
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * Administrator:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  Wenn Sie zum Beispiel der Zugriffsgruppe `team1` die IAM-Plattformrolle **Anzeigeberechtigter** zuordnen und `kubectl get rolebinding ibm-view -o yaml -n default` ausführen, wird folgende Ausgabe angezeigt:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-edit
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-edit
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team1
  ```
  {: screen}

<br />




## RBAC-Berechtigungen zuordnen
{: #role-binding}

**Was sind RBAC-Rollen und Clusterrollen?**</br>

Von RBAC-Rollen und Clusterrollen werden Berechtigungen definiert, die festlegen, wie Benutzer mit Kubernetes-Ressourcen im Cluster interagieren können. Für eine Rolle wird ein Bereich für Ressourcen in einem bestimmten Namensbereich festgelegt, zum Beispiel einer Bereitstellung. Für eine Clusterrolle wird ein Bereich für clusterweite Ressourcen wie Workerknoten oder Ressourcen in einem Namensbereich festgelegt, die in jedem Namensbereich vorhanden sind, wie zum Beispiel Pods.

**Was sind RBAC-Rollenbindungen und Clusterrollenbindungen?**</br>

Von Rollenbindungen werden RBAC-Rollen oder Clusterrollen auf einen bestimmten Namensbereich angewendet. Wenn Sie eine Rollenbindung zum Anwenden auf eine Rolle verwenden, erteilen Sie einem Benutzer Zugriff auf eine bestimmte Ressource in einem bestimmten Namensbereich. Wenn Sie eine Rollenbindung zum Anwenden auf eine Clusterrolle verwenden, erteilen Sie einem Benutzer Zugriff auf Ressourcen in einem Namensbereich, die in jedem Namensbereich vorhanden sind (wie zum Beispiel Pods), aber nur in einem bestimmten Namensbereich.

Von Clusterrollenbindungen werden RBAC-Clusterrollen auf alle Namensbereiche im Cluster angewendet. Wenn Sie eine Clusterrollenbindung verwenden, um eine Clusterrolle anzuwenden, erteilen Sie einem Benutzer Zugriff auf clusterweite Ressourcen wie Workerknoten oder auf namensbereichsorientierte Ressourcen in jedem Namensbereich, wie zum Beispiel Pods.

**Wie werden diese Rollen in meinem Cluster dargestellt?**</br>

Jedem Benutzer, dem eine [IAM-Plattformmanagmentrolle](#platform) zugeordnet ist, ist automatisch eine entsprechende RBAC-Clusterrolle zugeordnet. Diese RBAC-Clusterrollen sind vordefiniert und ermöglichen es Benutzern, mit Kubernetes-Ressourcen im Cluster zu interagieren. Darüber hinaus wird entweder eine Rollenbindung erstellt, um die Clusterrolle auf einen bestimmten Namensbereich anzuwenden, oder eine Clusterrollenbindung wird erstellt, um die Clusterrolle auf alle Namensbereiche anzuwenden.

In der folgenden Tabelle werden die Beziehungen zwischen den IAM-Plattformrollen und den entsprechenden Clusterrollen und Rollenbindungen oder Clusterrollenbindung beschrieben, die automatisch für die IAM-Plattformrollen erstellt werden.

<table>
  <tr>
    <th>IAM-Plattformrolle</th>
    <th>RBAC-Clusterrolle</th>
    <th>RBAC-Rollenbindung</th>
    <th>RBAC-Clusterrollenbindung</th>
  </tr>
  <tr>
    <td>Anzeigeberechtigter</td>
    <td><code>view</code></td>
    <td><code>ibm-view</code> im Standardnamensbereich</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Editor</td>
    <td><code>edit</code></td>
    <td><code>ibm-edit</code> im Standardnamensbereich</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Operator</td>
    <td><code>admin</code></td>
    <td>-</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Administrator</td>
    <td><code>cluster-admin</code></td>
    <td>-</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

Weitere Informationen zu den Aktionen, die mit den einzelnen RBAC-Rollen zulässig sind, finden Sie im Referenzabschnitt [Benutzerzugriffsberechtigungen](cs_access_reference.html#platform).
{: tip}

**Wie kann ich RBAC-Berechtigungen für bestimmte Namensbereiche in meinem Cluster verwalten?**

Wenn Sie [Kubernetes-Namensbereiche zum Partitionieren des Clusters verwenden und eine Isolation für Workloads bereitzustellen](cs_secure.html#container), müssen Sie Benutzerzugriff für bestimmte Namensbereiche zuordnen. Wenn Sie einem Benutzer die IAM-Plattformrolle **Operator** oder **Administrator** zuordnen, werden die vordefinierten Clusterrollen `admin` (Administrator) und `cluster-admin` (Clusteradministrator) automatisch auf den gesamten Cluster angewendet. Wenn Sie einem Benutzer jedoch die IAM-Plattformrolle **Anzeigeberechtigter** oder **Editor** zuordnen, werden die vordefinierten Clusterrollen `view` (Anzeigen) und `edit` (Bearbeiten) automatisch auf den gesamten Cluster angewendet. Wenn Sie dieselbe Stufe des Benutzerzugriffs in anderen Namensbereichen erzwingen möchten, ist das [Kopieren der Rollenbindungen](#rbac_copy) für diese Clusterrollen mit `ibm-view` und `ibm-edit` in andere Namensbereiche möglich.

**Kann ich angepasste Rollen oder Clusterrollen erstellen?**

Die Clusterrollen `view` (Anzeigen), `edit` (Bearbeiten), `admin` (Administrator) und `cluster-admin` (Clusteradministrator) sind vordefinierte Rollen, die automatisch erstellt werden, wenn Sie einen Benutzer der entsprechenden IAM-Plattformrolle zuordnen. Wenn Sie andere Kubernetes-Berechtigungen erteilen möchten, können Sie [angepasste RBAC-Berechtigungen erstellen](#rbac).

**Wann muss ich Clusterrollenbindungen und Rollenbindungen verwenden, die nicht an die IAM-Berechtigungen gebunden sind, die ich festgelegt habe?**

Es kann sinnvoll sein, Personen Berechtigungen zuzuordnen, die Pods im Cluster erstellen und aktualisieren. Mit [Sicherheitsrichtlinien für Pods](https://console.bluemix.net/docs/containers/cs_psp.html#psp) können Sie vorhandene Clusterrollenbindungen verwenden, die im Cluster enthalten sind, oder können eigene Bindungen erstellen.

Es kann auch sinnvoll sein, Add-ons in den Cluster zu integrieren. Wenn Sie beispielsweise [Helm im Cluster konfigurieren](cs_integrations.html#helm), müssen Sie ein Servicekonto für Tiller im Namensbereich `kube-system` und eine Kubernetes-RBAC-Clusterrollenbindung für den Pod `tiller-deploy` erstellen.

### RBAC-Rollenbindung in anderen Namensbereich kopieren
{: #rbac_copy}

Einige Rollen und Clusterrollen werden nur auf einen Namensbereich angewendet. Beispiel: Die vordefinierten Clusterrollen `view` (Anzeigen) und `edit` (Bearbeiten) werden automatisch nur im Namensbereich `default` angewendet. Wenn Sie dieselbe Stufe des Benutzerzugriffs in anderen Namensbereichen erzwingen möchten, ist das Kopieren der Rollenbindungen für diese Rollen oder Clusterrollen in andere Namensbereiche möglich.
{: shortdesc}

Beispiel: Sie weisen de, Benutzer "john@email.com" die IAM-Plattformmanagementrolle **Editor** zu. Die vordefinierte RBAC-Clusterrolle `edit` wird automatisch im Cluster erstellt, und durch die Rollenbindung `ibm-edit` werden die Berechtigungen im Namensbereich `default` angewendet. Wenn Sie möchten, dass "john@email.com" auch über Editorzugriff auf den Namensbereich für die Entwicklung verfügt, kopieren Sie die Rollenbindung `ibm-edit` von `default` in `development`. **Anmerkung:** Sie müssen die Rollenbindung bei jedem Hinzufügen eines Benutzers zu den Rollen `view` (Anzeigen) oder `edit` (Bearbeiten) kopieren.

1. Kopieren Sie die Rollenbindung von `default` in einen anderen Namensbereich.
    ```
    kubectl get rolebinding <role_binding_name> -o yaml | sed 's/default/<namespace>/g' | kubectl -n <namespace> create -f -
    ```
    {: pre}

    Gehen Sie zum Beispiel wie folgt vor, um die Rollenbindung `ibm-edit` in den Namensbereich `testns` zu kopieren:
    ```
    kubectl get rolebinding ibm-edit -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
    ```
    {: pre}

2. Stellen Sie sicher, dass die Rollenbindung `ibm-edit` kopiert wurde.
    ```
    kubectl get rolebinding -n <namespace>
    ```
    {: pre}

<br />


### Angepasste RBAC-Berechtigungen für Benutzer, Gruppen oder Servicekonten erstellen
{: #rbac}

Die Clusterrollen `view` (Anzeigen), `edit` (Bearbeiten), `admin` (Administrator) und `cluster-admin` (Clusteradministrator) werden automatisch erstellt, wenn Sie die entsprechende IAM-Plattformmanagementrolle zuordnen. Müssen die Clusterzugriffsrichtlinien differenzierter sein, als dies anhand der vordefinierten Berechtigungen möglich ist? Kein Problem. Sie können angepasste RBAC-Rollen und Clusterrollen erstellen.
{: shortdesc}

Sie können einzelnen Benutzern, Benutzergruppen (in Clustern, in denen Kubernetes Version 1.11 oder höher ausgeführt wird) oder Servicekonten angepasste RBAC-Rollen und Clusterrollen zuordnen. Wenn für eine Gruppe eine Bindung erstellt wird, wirkt sich dies auf alle Benutzer aus, die dieser Gruppe hinzugefügt oder die aus dieser Gruppe entfernt werden. Wenn Sie Benutzer zu einer Gruppe hinzufügen, erhalten diese zusätzlich zu den individuellen Zugriffsberechtigungen, die Sie ihnen gewähren, die Zugriffsberechtigungen der Gruppe. Werden sie entfernt, wird ihr Zugriff widerrufen. **Anmerkung:** Sie können nicht Servicekonten zu Zugriffsgruppen hinzufügen.

Wenn Sie Zugriff auf einen Prozess (zum Beispiel eine Continuous Delivery-Toolchain) zuweisen möchten, können Sie [Kubernetes-Servicekonten ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/) verwenden. Wenn Sie ein Lernprogramm ausführen möchten, von dem die Einrichtung von Servicekonten für Travis und Jenkins und die Zuordnung von angepassten RBAC-Rollen zu den Servicekonten veranschaulicht wird, lesen Sie den Blogbeitrag [Kubernetes-Servicekonten zur Verwendung in automatisierten Systemen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://medium.com/@jakekitchener/kubernetes-serviceaccounts-for-use-in-automated-systems-515297974982).

**Anmerkung:** Wenn Sie unterbrechende Änderungen verhindern möchten, ändern Sie nicht die vordefinierten Clusterrollen `view` (Anzeigen), `edit` (Bearbeiten), `admin` (Administrator) und `cluster-admin` (Clusteradministrator).

**Soll ich eine Rolle oder Clusterrolle erstellen? Soll sie mit einer Rollenbindung oder einer Clusterrollenbindung angewendet werden?**

* Wenn Sie einem Benutzer, einer Zugriffsgruppe oder einem Servicekonto Zugriff auf eine Ressource in einem bestimmten Namensbereich gewähren möchten, wählen Sie eine der folgenden Kombinationen aus:
  * Erstellen Sie eine Rolle und wenden Sie sie mit einer Rollenbindung an. Diese Option ist nützlich, um den Zugriff auf eine eindeutige Ressource zu steuern, die nur in einem Namensbereich vorhanden ist, wie zum Beispiel eine App-Implementierung.
  * Erstellen Sie eine Clusterrolle und wenden Sie sie mit einer Rollenbindung an. Diese Option ist nützlich, um den Zugriff auf allgemeine Ressourcen in einem Namensbereich zu steuern, zum Beispiel auf Pods.
* Um einem Benutzer oder einer Zugriffsgruppe den Zugriff auf clusterweite Ressourcen oder Ressourcen in allen Namensbereichen zu ermöglichen, erstellen Sie eine Clusterrolle und wenden Sie sie mit einer Clusterrollenbindung an. Diese Option ist nützlich, um den Zugriff auf Ressourcen zu steuern, die sich nicht auf Namensbereiche (zum Beispiel Workerknoten) oder Ressourcen in allen Namensbereichen im Cluster (zum Beispiel Pods in jedem Namensbereich) beziehen.

Vorbereitende Schritte:

- Wählen Sie Ihr Cluster als Ziel Ihrer [Kubernetes-CLI](cs_cli_install.html#cs_cli_configure) aus.
- Wenn Sie einzelnen Benutzern oder Benutzern in einer Zugriffsgruppe Zugriff erteilen möchten, stellen Sie sicher, dass dem Benutzter oder der Gruppe mindestens eine [IAM-Plattformrolle](#platform) auf dem Service-Level von {{site.data.keyword.containerlong_notm}} zugewiesen wurde.

Gehen Sie wie folgt vor, um angepasste RBAC-Berechtigungen zu erstellen:

1. Erstellen Sie die Rolle oder Clusterrolle mit dem Zugriff, den Sie erteilen möchten.

    1. Erstellen Sie eine `.yaml`-Datei zum Definieren der Rolle oder Clusterrolle.

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
        <caption>Erklärung der Komponenten der YAML-Datei</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Komponenten der YAML-Datei</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>Verwenden Sie `Role`, um Zugriff auf die Ressourcen in einem bestimmten Namensbereich zu erteilen. Verwenden Sie `ClusterRole`, um Zugriff auf clusterweite Ressourcen (zum Beispiel Workerknoten) oder namensbereichsorientierte Ressourcen (zum Beispiel Pods in allen Namensbereichen) zu erteilen.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Für Cluster, die Kubernetes 1.8 oder höher ausführen, verwenden Sie `rbac.authorization.k8s.io/v1`. </li><li>Für ältere Versionen verwenden Sie `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td>Nur für `Role`: Geben Sie den Kubernetes-Namensbereich an, für den der Zugriff erteilt wird.</td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>Benennen Sie die Rolle oder die Clusterrolle.</td>
            </tr>
            <tr>
              <td><code>rules.apiGroups</code></td>
              <td>Geben Sie die Kubernetes-[API-Gruppen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) an, mit denen Benutzer interagieren können sollen, zum Beispiel `"apps"`, `"batch"` oder `"extensions"`. Für den Zugriff auf die Gruppe der API-Kerndefinitionen im REST-Pfad `api/v1` lassen Sie die Angabe für die Gruppe leer `[""]`.</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>Geben Sie die Kubernetes-[Ressourcentypen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) an, auf die Sie Zugriff erteilen möchten, zum Beispiel `"daemonsets"`, `"deployments"`, `"events"` oder `"ingresses"`. Falls Sie `"nodes"` angeben, muss als Typ `ClusterRole` angegeben werden.</td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>Geben Sie die Typen der [Aktionen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/) an, die Benutzer ausführen können sollen, zum Beispiel `"get"`, `"list"`, `"describe"`, `"create"` oder `"delete"`.</td>
            </tr>
          </tbody>
        </table>

    2. Erstellen Sie die Rolle oder Clusterrolle in Ihrem Cluster.

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. Überprüfen Sie, ob die Rolle bzw. Clusterrolle erstellt wurde.
      * Rolle:
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * Clusterrolle:
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. Binden Sie Benutzer an die Rolle bzw. Clusterrolle.

    1. Erstellen Sie eine `.yaml`-Datei, um Benutzer an die Rolle bzw. Clusterrolle zu binden. Notieren Sie die eindeutige URL, die für die einzelnen Namen des jeweiligen Subjekts verwendet werden soll

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/IAM#user1@example.com
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
        <caption>Erklärung der Komponenten der YAML-Datei</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Komponenten der YAML-Datei</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>Geben Sie `RoleBinding` für eine namensbereichsspezifische `Role` bzw. `ClusterRole` an. </li><li>Geben Sie `ClusterRoleBinding` für eine clusterweite `ClusterRole` an.</li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Für Cluster, die Kubernetes 1.8 oder höher ausführen, verwenden Sie `rbac.authorization.k8s.io/v1`. </li><li>Für ältere Versionen verwenden Sie `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td><ul><li>Für den Typ `RoleBinding`: Geben Sie den Kubernetes-Namensbereich an, für den der Zugriff erteilt wird.</li><li>Für den Typ `ClusterRoleBinding`: Verwenden Sie nicht das Feld `namespace`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>Benennen Sie die Rollenbindung bzw. Clusterrollenbindung.</td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>Geben Sie für 'kind' eine der folgenden Optionen an:
              <ul><li>`User`: Binden Sie die RBAC-Rolle oder Clusterrolle an einen einzelnen Benutzer im Konto.</li>
              <li>`Group`: Für Cluster, die Kubernetes 1.11 oder höher ausführen, müssen Sie die RBAC-Rolle bzw. Clusterrolle an eine [IAM-Zugriffsgruppe](/docs/iam/groups.html#groups) in Ihrem Konto binden.</li>
              <li>`ServiceAccount`: Binden Sie die RBAC-Rolle bzw. Clusterrolle an ein Servicekonto in einem Namensbereich in Ihrem Cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>Für `User`: Hängen Sie die E-Mail-Adresse des einzelnen Benutzers an die folgenden URLs an. <ul><li>Für Cluster, auf denen Kubernetes 1.11 oder  aktueller ausgeführt wird: <code>https://iam.ng.bluemix.net/IAM#user_email</code></li><li>Für Cluster, auf denen Kubernetes 1.10 oder früher ausgeführt wird: <code>https://iam.ng.bluemix.net/kubernetes#user_email</code></li></ul></li>
              <li>Für `Group`: Für Cluster, in denen Kubernetes 1.11 oder höher ausgeführt wird, geben Sie den Namen der [IAM-Gruppe](/docs/iam/groups.html#groups) in Ihrem Konto an.</li>
              <li>Für `ServiceAccount`: Geben Sie den Namen des Servicekontos an.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.apiGroup</code></td>
              <td><ul><li>Für `User` oder `Group`: Verwenden Sie `rbac.authorization.k8s.io`.</li>
              <li>Für `ServiceAccount`: Fügen Sie dieses Feld nicht ein.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.namespace</code></td>
              <td>Nur für `ServiceAccount`: Geben Sie den Namen des Kubernetes-Namensbereichs an, in dem das Servicekonto bereitgestellt wird.</td>
            </tr>
            <tr>
              <td><code>roleRef.kind</code></td>
              <td>Geben Sie denselben Wert als `kind` in der `.yaml`-Rollendatei an: `Role` oder `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>roleRef.name</code></td>
              <td>Geben Sie den Namen der `.yaml`-Rollendatei an.</td>
            </tr>
            <tr>
              <td><code>roleRef.apiGroup</code></td>
              <td>Verwenden Sie `rbac.authorization.k8s.io`.</td>
            </tr>
          </tbody>
        </table>

    2. Erstellen Sie die Ressource für die Rollenbindung bzw. Clusterrollenbindung in Ihrem Cluster.

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  Überprüfen Sie, dass die Bindung erstellt wurde.

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

Fahren Sie jetzt, nachdem Sie eine angepasste Kubernetes-RBAC-Rolle oder -Clusterrolle erstellt und gebunden haben, mit den Benutzern fort. Bitten Sie sie, eine Aktion auszuführen, für deren Ausführung sie die Berechtigung aufgrund Ihrer Rolle haben. Zum Beispiel das Löschen eines Pods.

<br />




## Infrastrukturberechtigungen anpassen
{: #infra_access}

Wenn Sie dem Administrator, der den API-Schlüssel festlegt oder dessen Infrastrukturberechtigungsnachweise festgelegt werden, die Infrastrukturrolle **Superuser** zuordnen, nutzen andere Benutzer im Konto den API-Schlüssel oder die Berechtigungsnachweise gemeinsam für die Ausführung von Infrastrukturaktionen. Sie können dann steuern, welche Infrastrukturaktionen die Benutzer ausführen können, indem Sie die entsprechende [IAM-Plattformrolle](#platform) zuordnen. Sie müssen die Berechtigungen des Benutzers für die IBM Cloud-Infrastruktur (SoftLayer) nicht bearbeiten.
{: shortdesc}

Es kann vorkommen, dass Compliance-, Sicherheits- oder Abrechnungsgründe dagegen sprechen, die Infrastrukturrolle **Superuser** dem Benutzer zuzuweisen, der den API-Schlüssel festlegt oder dessen Berechtigungsnachweis mit dem Befehl `ibmcloud ks credentials-set` festgelegt werden. Wenn dieser Benutzer jedoch nicht über die Rolle **Superuser** verfügt, können infrastrukturbezogene Aktionen, wie zum Beispiel das Erstellen eines Clusters oder das erneute Laden eines Workerknotens, fehlschlagen. Anstatt IAM-Plattformrollen zu verwenden, um den Infrastrukturzugriff der Benutzer zu steuern, müssen Sie für die Benutzer bestimmte Berechtigungen für die IBM Cloud-Infrastruktur (SoftLayer) festlegen.

Wenn Sie Mehrzonencluster haben, muss der Eigner Ihres Kontos der IBM Cloud-Infrastruktur (SoftLayer) das VLAN-Spanning aktivieren, damit Knoten in unterschiedlichen Zonen innerhalb des Clusters miteinander kommunizieren können. Der Kontoeigner kann einem Benutzer auch die Berechtigung **Netz > VLAN-Spanning für das Netz verwalten** zuweisen, damit der Benutzer das VLAN-Spanning aktivieren kann. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

Stellen Sie zunächst sicher, dass Sie der Kontoeigner sind oder über die Zugriffsberechtigung **Superuser** sowie Zugriff auf alle Geräte verfügen. Sie können nicht einen Benutzerzugriff erteilen, über den Sie selbst nicht verfügen.

1. Melden Sie sich an der [grafischen IBM Cloud-Benutzerschnittstelle](https://console.bluemix.net/) an und navigieren Sie zu **Verwalten > Konto > Benutzer**.

2. Klicken Sie auf den Namen des Benutzers, für den Sie Berechtigungen festlegen möchten.

3. Klicken Sie auf **Zugriff zuweisen** und klicken Sie auf **Zugriff auf Ihr SoftLayer-Konto zuweisen**.

4. Klicken Sie auf die Registerkarte **Portalberechtigungen**, um den Benutzerzugriff anzupassen. Welche Berechtigungen die Benutzer benötigen, ist davon abhängig, welche Infrastrukturressourcen sie verwenden müssen. Sie haben zwei Möglichkeiten für die Zuordnung des Zugriffs:
    * Verwenden Sie die Dropdown-Liste **Schnellberechtigungen**, um eine der folgenden vordefinierten Rollen zuzuweisen. Klicken Sie nach der Auswahl einer Rolle auf **Berechtigungen festlegen**.
        * **Nur Benutzer anzeigen** erteilt dem Benutzer nur die Berechtigungen zum Anzeigen von Infrastrukturdetails.
        * **Basisbenutzer** erteilt dem Benutzer einige, aber nicht alle Infrastrukturberechtigungen.
        * **Superuser** erteilt dem Benutzer alle Infrastrukturberechtigungen.
    * Wählen Sie in jeder Registerkarte einzelne Berechtigungen aus. Informationen zum Überprüfen von Berechtigungen, die für die Ausführung allgemeiner Tasks in {{site.data.keyword.containerlong_notm}} erforderlich sind, finden Sie im Abschnitt [Benutzerzugriffsberechtigungen](cs_access_reference.html#infra).

5.  Klicken Sie zum Speichern Ihrer Änderungen auf **Portalberechtigungen bearbeiten**.

6.  Wählen Sie auf der Registerkarte **Gerätezugriff** die Geräte aus, für die Zugriff erteilt werden soll.

    * In der Dropdown-Liste **Gerätetyp** können Sie Zugriff auf **Alle Geräte** erteilen, sodass Benutzer sowohl mit virtuellen als auch physischen (Bare-Metal-Hardware) Maschinentypen für Workerknoten arbeiten können.
    * Um Benutzern Zugriff auf neue Geräte zu erteilen, die erstellt wurden, markieren Sie **Der Zugriff wird automatisch erteilt, wenn neue Geräte hinzugefügt werden**.
    * Stellen Sie in der Tabelle der Geräte sicher, dass die entsprechenden Geräte ausgewählt sind.

7. Klicken Sie zum Speichern Ihrer Änderungen auf **Gerätezugriff aktualisieren**.

Laden Sie gerade Berechtigungen herunter? Die Ausführung dieser Aktion kann einige Minuten in Anspruch nehmen.
{: tip}

<br />



