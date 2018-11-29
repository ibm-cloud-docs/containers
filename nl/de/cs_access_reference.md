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

# Benutzerzugriffsberechtigungen
{: #understanding}



Wenn Sie [Clusterberechtigungen zuordnen](cs_users.html), kann es schwierig sein, zu beurteilen, welche Rolle einem Benutzer zugeordnet werden muss. Anhand der Tabellen in den folgenden Abschnitten können Sie das Mindestniveau der Berechtigungen feststellen, die für die Ausführung allgemeiner Tasks in {{site.data.keyword.containerlong}} erforderlich sind.
{: shortdesc}

## IAM-Plattform und Kubernetes-RBAC
{: #platform}

{{site.data.keyword.containerlong_notm}} ist für die Verwendung von {{site.data.keyword.Bluemix_notm}} Identity and Access Management-Rollen (IAM-Rollen) konfiguriert. Von den Rollen der IAM-Plattform werden die Aktionen festgelegt, die Benutzer in einem Cluster ausführen können. Jedem Benutzer, dem eine IAM-Plattformrolle zugeordnet ist, wird automatisch auch eine entsprechende Rolle für Kubernetes-RBAC (RBAC - rollenbasierte Zugriffssteuerung) im Standardnamensbereich zugeordnet. Zusätzlich werden mithilfe der IAM-Plattformrollen automatisch Basisinfrastrukturberechtigungen für Benutzer festgelegt. Informationen zum Festlegen von IAM-Richtlinien finden Sie unter [IAM-Plattformberechtigungen zuordnen](cs_users.html#platform). Weitere Informationen zu RBAC-Rollen finden Sie unter [RBAC-Berechtigungen zuordnen](cs_users.html#role-binding).

In der folgenden Tabelle werden die Berechtigungen für die Clusterverwaltung aufgeführt, die den entsprechenden RBAC-Rollen von jeder einzelnen IAM-Plattformrolle und den Kubernetes-Ressourcenberechtigungen gewährt werden.

<table>
  <tr>
    <th>IAM-Plattformrolle</th>
    <th>Berechtigungen der Clusterverwaltung</th>
    <th>Entsprechende RBAC-Rollen und Ressourcenberechtigungen</th>
  </tr>
  <tr>
    <td>**Viewer**</td>
    <td>
      Cluster:<ul>
        <li>Anzeigen des Namens und der E-Mail-Adresse für den Eigner des IAM-API-Schlüssels für eine Ressourcengruppe und Region</li>
        <li>Anzeigen des Infrastrukturbenutzernamens bei Verwendung abweichender Berechtigungsnachweise durch das {{site.data.keyword.Bluemix_notm}}-Konto für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer)</li>
        <li>Auflisten aller oder Anzeigen der Details für Cluster, Workerknoten, Worker-Pools, Services in einem Cluster und Webhooks</li>
        <li>Anzeigen des VLAN-Spanning-Status für das Infrastrukturkonto</li>
        <li>Auflisten der verfügbaren Teilnetze im Infrastrukturkonto</li>
        <li>Beim Festlegen für einen Cluster: Auflisten der VLANs, mit denen der Cluster in einer Zone verbunden ist</li>
        <li>Beim Festlegen für alle Cluster im Konto: Auflisten aller verfügbaren VLANs in einer Zone</li></ul>
      Protokollierung:<ul>
        <li>Anzeigen des Standardprotokollierungsendpunkts für Zielregion</li>
        <li>Auflisten oder Anzeigen der Details von Konfigurationen für Protokollweiterleitung und -filterung</li>
        <li>Anzeigen des Status für automatische Aktualisierungen des Fluentd-Add-Ons</li></ul>
      Ingress:<ul>
        <li>Auflisten aller oder Anzeigen der Details für Lastausgleichsfunktionen für Anwendungen (ALBs) in einem Cluster</li>
        <li>Anzeigen der Typen der Lastausgleichsfunktionen für Anwendungen, die in der Region unterstützt werden</li></ul>
    </td>
    <td>Die Clusterrolle <code>view</code> wird von der Rollenbindung <code>ibm-view</code> angewendet und stellt die folgenden Berechtigungen im Namensbereich <code>default</code> bereit:<ul>
      <li>Lesezugriff auf Ressourcen innerhalb des Standardnamensbereichs</li>
      <li>Kein Lesezugriff auf geheime Kubernetes-Schlüssel</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Editor** <br/><br/><strong>Tipp:</strong> Verwenden Sie diese Rolle für Anwendungsentwickler und ordnen Sie die Rolle <a href="#cloud-foundry">Cloud Foundry</a>-**Entwickler** zu.</td>
    <td>Diese Rolle verfügt über alle Berechtigungen der Rolle eines Anzeigeberechtigten und zusätzlich noch über die folgenden: </br></br>
      Cluster:<ul>
        <li>Binden und Aufheben der Bindungen von {{site.data.keyword.Bluemix_notm}}-Services an einen Cluster</li></ul>
      Protokollierung:<ul>
        <li>Erstellen, Aktualisieren und Löschen der Webhooks von API-Serveraudits</li>
        <li>Erstellen von Cluster-Webhooks</li>
        <li>Erstellen und Löschen von Protokollweiterleitungskonfigurationen für alle Typen bis auf `kube-audit`</li>
        <li>Aktualisieren der Protokollweiterleitungskonfigurationen</li>
        <li>Erstellen, Aktualisieren und Löschen von Protokollfilterkonfigurationen</li></ul>
      Ingress:<ul>
        <li>Aktivieren oder Inaktivieren der Lastausgleichsfunktionen für Anwendungen </li></ul>
    </td>
    <td>Die Clusterrolle <code>edit</code> wird von der Rollenbindung <code>ibm-edit</code> angewendet und stellt die folgenden Berechtigungen im Namensbereich <code>default</code> bereit:
      <ul><li>Schreib-/Lesezugriff auf Ressourcen innerhalb von Standardnamensbereichen</li></ul></td>
  </tr>
  <tr>
    <td>**Operator**</td>
    <td>Diese Rolle verfügt über alle Berechtigungen der Rolle eines Anzeigeberechtigten und zusätzlich noch über die folgenden: </br></br>
      Cluster:<ul>
        <li>Aktualisieren eines Clusters</li>
        <li>Aktualisieren des Kubernetes-Masters</li>
        <li>Hinzufügen und Entfernen von Workerknoten</li>
        <li>Erneutes Starten, erneutes Laden und Aktualisieren von Workerknoten</li>
        <li>Erstellen und Löschen von Worker-Pools</li>
        <li>Hinzufügen von Zonen zu und Entfernen von Zonen aus Worker-Pools</li>
        <li>Aktualisieren der Netzkonfiguration für eine bestimmte Zone in Worker-Pools</li>
        <li>Ändern der Größe von Worker-Pools und neues Ausgleichen von Worker-Pools</li>
        <li>Erstellen und Hinzufügen von Teilnetzen für einen Cluster</li>
        <li>Hinzufügen von benutzerverwalteten Teilnetzen zu und Entfernen benutzerverwalteter Teilnetze aus einem Cluster</li></ul>
    </td>
    <td>Die Clusterrolle <code>admin</code> wird von der Clusterrollenbindung <code>ibm-operate</code> angewendet und stellt die folgenden Berechtigungen bereit:
<ul>
      <li>Schreib-/Lesezugriff auf Ressourcen innerhalb eines Namensbereichs, aber nicht auf den Namensbereich selbst</li>
      <li>Erstellen von RBAC-Rollen innerhalb eines Namensbereichs</li></ul></td>
  </tr>
  <tr>
    <td>**Administrator**</td>
    <td>Diese Rolle weist alle Berechtigungen der Rollen 'Editor', 'Operator' und 'Anzeigeberechtigter' für alle Cluster in diesem Konto sowie die folgenden auf:</br></br>
      Cluster:<ul>
        <li>Erstellen von kostenlosen Clustern oder Standardclustern</li>
        <li>Löschen von Clustern</li>
        <li>Verschlüsseln von geheimen Kubernetes-Schlüsseln mithilfe von {{site.data.keyword.keymanagementservicefull}}</li>
        <li>Festlegen des API-Schlüssels für das {{site.data.keyword.Bluemix_notm}}-Konto für den Zugriff auf das verknüpfte Portfolio der IBM Cloud-Infrastruktur (SoftLayer)</li>
        <li>Festlegen, Anzeigen und Entfernen der Infrastrukturberechtigungsnachweise für das {{site.data.keyword.Bluemix_notm}}-Konto für den Zugriff auf ein anderes Portfolio der IBM Cloud-Infrastruktur (SoftLayer)</li>
        <li>Zuordnen und Ändern der IAM-Plattformrollen für weitere vorhandene Benutzer im Konto</li>
        <li>Beim Festlegen für alle {{site.data.keyword.containerlong_notm}} Instanzen (Cluster) in allen Regionen: Auflisten aller verfügbaren VLANs im Konto</ul>
      Protokollierung:<ul>
        <li>Erstellen und Aktualisieren von Protokollweiterleitungskonfigurationen für den Typ `kube-audit`</li>
        <li>Erfassen eines Snapshots der API-Serverprotokolle in einem {{site.data.keyword.cos_full_notm}}-Bucket</li>
        <li>Aktivieren und Inaktivieren automatischer Aktualisierungen für Fluentd-Cluster-Add-on</li></ul>
      Ingress:<ul>
        <li>Auflisten aller oder Anzeigen der Details für geheime ALB-Schlüssel (ALB - Lastausgleichsfunktionen für Anwendungen) in einem Cluster</li>
        <li>Bereitstellen eines Zertifikats der {{site.data.keyword.cloudcerts_long_notm}}-Instanz für eine Lastausgleichsfunktion für Anwendungen</li>
        <li>Aktualisieren oder Entfernen von geheimen ALB-Schlüsseln von einem Cluster</li></ul>
      <strong>Anmerkung:</strong> Zum Erstellen von Ressourcen wie Maschinen, VLANs und Teilnetzen benötigen Administratorbenutzer die Infrastrukturrolle **Superuser**.
    </td>
    <td>Die Clusterrolle <code>cluster-admin</code> wird von der Clusterrollenbindung <code>ibm-admin</code> angewendet und stellt die folgenden Berechtigungen bereit:
      <ul><li>Schreib-/Lesezugriff auf Ressourcen in allen Namensbereichen</li>
      <li>Erstellen von RBAC-Rollen innerhalb eines Namensbereichs</li>
      <li>Zugriff auf Kubernetes-Dashboard</li>
      <li>Erstellen einer Ingress-Ressource, von der Anwendungen öffentlich verfügbar gemacht werden</li></ul>
    </td>
  </tr>
</table>



## Cloud Foundry-Rollen
{: #cloud-foundry}

Cloud Foundry-Rollen gewähren Zugriff für Organisationen und Bereiche innerhalb des Kontos. Wenn Sie die Liste der Cloud Foundry-basierten Services in {{site.data.keyword.Bluemix_notm}} anzeigen möchten, führen Sie `ibmcloud service list` aus. Weitere Informationen finden Sie unter allen verfügbaren [Organisations- und Benutzerrollen](/docs/iam/cfaccess.html) oder in den Schritten unter [Cloud Foundry-Zugriff verwalten](/docs/iam/mngcf.html) in der Dokumentation zu Identity and Access Management.

In der folgenden Tabelle werden die Cloud Foundry-Rollen aufgeführt, die für Clusteraktionsberechtigungen erforderlich sind.

<table>
  <tr>
    <th>Cloud Foundry-Rolle</th>
    <th>Berechtigungen der Clusterverwaltung</th>
  </tr>
  <tr>
    <td>Bereichsrolle: Manager</td>
    <td>Verwalten des Benutzerzugriffs auf einen {{site.data.keyword.Bluemix_notm}}-Bereich</td>
  </tr>
  <tr>
    <td>Bereichsrolle: Entwickler</td>
    <td>
      <ul><li>Erstellen von {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen</li>
      <li>Binden von {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen an Cluster</li>
      <li>Anzeigen von Protokollen aus einer Protokollweiterleitungskonfiguration des Clusters auf Bereichsebene</li></ul>
    </td>
  </tr>
</table>

## Infrastrukturrollen
{: #infra}

**Anmerkung:** Wenn ein Benutzer mit der Infrastrukturzugriffsrolle **Superuser** [den API-Schlüssel für eine Region und eine Ressourcengruppe festlegt](cs_users.html#api_key), werden die Infrastrukturberechtigungen für die anderen Benutzer innerhalb des Kontos mithilfe von IAM-Plattformrollen festgelegt. Sie müssen die Berechtigungen der Benutzer für die IBM Cloud-Infrastruktur (SoftLayer) nicht bearbeiten. Verwenden Sie nur die folgende Tabelle zum Anpassen der Benutzerberechtigungen für die IBM Cloud-Infrastruktur (SoftLayer), wenn Sie **Superuser** nicht dem Benutzer zuordnen können, der den API-Schlüssel festgelegt hat. Weitere Informationen finden Sie in [Infrastrukturberechtigungen anpassen](cs_users.html#infra_access).


In der folgenden Tabelle werden die Infrastrukturberechtigungen aufgeführt, die zur Ausführung von Gruppen allgemeiner Tasks erforderlich sind.

<table summary="Infrastrukturberechtigungen für allgemeine {{site.data.keyword.containerlong_notm}}-Szenarios.">
 <caption>Allgemein erforderliche Infrastrukturberechtigungen für {{site.data.keyword.containerlong_notm}}</caption>
 <thead>
  <th>Allgemeine Tasks in {{site.data.keyword.containerlong_notm}}</th>
  <th>Erforderliche Infrastrukturberechtigungen nach Registerkarte</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>Mindestberechtigungen</strong>: <ul><li>Erstellen Sie einen Cluster.</li></ul></td>
     <td><strong>Geräte</strong>:<ul><li>Details zum virtuellen Server anzeigen</li><li>Server neu starten und IPMI-Systeminformationen anzeigen</li><li>Befehle zum erneuten Laden des Betriebssystems absetzen und Rescue-Kernel initiieren</li></ul><strong>Konto</strong>: <ul><li>Server hinzufügen</li></ul></td>
   </tr>
   <tr>
     <td><strong>Clusterverwaltung</strong>: <ul><li>Cluster erstellen, aktualisieren und löschen.</li><li>Workerknoten hinzufügen, erneut laden und neu starten.</li><li>VLANs anzeigen.</li><li>Teilnetze erstellen-</li><li>Pods und Lastausgleichsservices  bereitstellen.</li></ul></td>
     <td><strong>Support</strong>:<ul><li>Tickets anzeigen</li><li>Tickets hinzufügen</li><li>Tickets bearbeiten</li></ul>
     <strong>Geräte</strong>:<ul><li>Hardwaredetails anzeigen</li><li>Details zum virtuellen Server anzeigen</li><li>Server neu starten und IPMI-Systeminformationen anzeigen</li><li>Befehle zum erneuten Laden des Betriebssystems absetzen und Rescue-Kernel initiieren</li></ul>
     <strong>Netz</strong>:<ul><li>Berechnen mit öffentlichem Netzport hinzufügen</li></ul>
     <strong>Konto</strong>:<ul><li>Server abbrechen</li><li>Server hinzufügen</li></ul></td>
   </tr>
   <tr>
     <td><strong>Speicher</strong>: <ul><li>Persistente Datenträgeranforderungen zur Bereitstellung von persistenten Datenträgern erstellen</li><li>Speicherinfrastrukturressourcen erstellen und verwalten.</li></ul></td>
     <td><strong>Services</strong>:<ul><li>Speicher verwalten</li></ul><strong>Konto</strong>:<ul><li>Speicher hinzufügen</li></ul></td>
   </tr>
   <tr>
     <td><strong>Privates Netz</strong>: <ul><li>Private VLANs für Netzbetrieb im Cluster verwalten</li><li>VPN-Konnektivität für private Netze konfigurieren</li></ul></td>
     <td><strong>Netz</strong>:<ul><li>Teilnetzrouten im Netz verwalten</li></ul></td>
   </tr>
   <tr>
     <td><strong>Öffentliches Netz</strong>:<ul><li>Richten Sie eine öffentliche Lastausgleichsfunktion oder das Ingress-Networking ein, um Apps bereitzustellen.</li></ul></td>
     <td><strong>Geräte</strong>:<ul><li>Hostname/Domäne bearbeiten</li><li>Portsteuerung verwalten</li></ul>
     <strong>Netz</strong>:<ul><li>Berechnen mit öffentlichem Netzport hinzufügen</li><li>Teilnetzrouten im Netz verwalten</li><li>IP-Adressen hinzufügen</li></ul>
     <strong>Services</strong>:<ul><li>DNS, Reverse DNS und WHOIS verwalten</li><li>Zertifikate anzeigen (SSL)</li><li>Zertifikate verwalten (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
