---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Fehlerbehebung für Cluster und Workerknoten
{: #cs_troubleshoot_clusters}

Ziehen Sie bei der Verwendung von {{site.data.keyword.containerlong}} die folgenden Verfahren für die Fehlerbehebung Ihrer Cluster und Workerknoten in Betracht.
{: shortdesc}

Wenn Sie ein allgemeineres Problem haben, testen Sie das [Cluster-Debugging](cs_troubleshoot.html).
{: tip}

## Erstellen eines Clusters aufgrund von Berechtigungsfehlern nicht möglich
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

```
Der Cluster konnte nicht mit der Registry konfiguriert werden. Stellen Sie sicher, dass Sie über die Administratorrolle für {{site.data.keyword.registrylong_notm}} verfügen.
```
{: screen}

{: tsCauses}
Sie verfügen nicht über die korrekten Berechtigungen zum Erstellen eines Clusters. Zum Erstellen eines Clusters benötigen Sie die folgenden Berechtigungen:
*  Die Rolle **Superuser** für die IBM Cloud-Infrastruktur (SoftLayer).
*  Die Plattformmanagementrolle **Administrator** für {{site.data.keyword.containerlong_notm}} auf Kontoebene.
*  Die Plattformmanagementrolle **Administrator** für {{site.data.keyword.registrylong_notm}} auf Kontoebene. Schränken Sie Richtlinien für {{site.data.keyword.registryshort_notm}} nicht auf Ressourcengruppenebene ein. Wenn Sie vor dem 4. Oktober 2018 damit begonnen haben, {{site.data.keyword.registrylong_notm}} zu verwenden, stellen Sie sicher, dass Sie die [{{site.data.keyword.Bluemix_notm}} IAM-Richtliniendurchsetzung aktivieren](/docs/services/Registry/registry_users.html#existing_users).

Aufgrund von infrastrukturbezogenen Fehlern wurde nutzungsabhängigen {{site.data.keyword.Bluemix_notm}}-Konten, die nach der Aktivierung der automatischen Kontoverknüpfung erstellt wurden, bereits Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) gewährt. Somit können Sie Infrastrukturressourcen für Ihren Cluster ohne weitere Konfiguration kaufen. Wenn Sie über ein gültiges nutzungsabhängiges Konto verfügen und diese Fehlernachricht erhalten, verwenden Sie möglicherweise nicht die richtigen Berechtigungsnachweise für das Konto der IBM Cloud-Infrastruktur (SoftLayer), um auf Infrastrukturressourcen zuzugreifen.

Benutzer mit anderen {{site.data.keyword.Bluemix_notm}}-Kontotypen müssen ihre Konten konfigurieren, um Standardcluster zu erstellen. Beispiele für den Fall, dass Sie einen anderen Kontotyp haben:
* Sie haben ein IBM Cloud Infrastructure-Konto (SoftLayer), das älter als Ihr {{site.data.keyword.Bluemix_notm}}-Plattformkonto ist, und Sie möchten es weiterhin verwenden.
* Sie möchten ein anderes IBM Cloud-Infrastrukturkonto (SoftLayer) verwenden, in dem die Infrastrukturressourcen eingerichtet werden sollen. Sie können beispielsweise ein {{site.data.keyword.Bluemix_notm}}-Teamkonto einrichten, um ein anderes Infrastrukturkonto für Abrechnungszwecke zu verwenden.

Falls Sie ein abweichendes IBM Cloud-Infrastrukturkonto (SoftLayer) zum Bereitstellen von Infrastrukturressourcen verwenden, verfügen Sie in Ihrem Konto möglicherweise auch über [verwaiste Cluster](#orphaned).

{: tsResolve}
Der Kontoeigner muss die Berechtigungsnachweise für das Infrastrukturkonto ordnungsgemäß einrichten. Die Berechtigungsnachweise richten sich nach dem Typ des von Ihnen verwendeten Infrastrukturkontos.

1.  Überprüfen Sie, dass Sie Zugriff auf ein Infrastrukturkonto haben. Melden Sie sich an der [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) an und klicken Sie im Menü ![Menüsymbol](../icons/icon_hamburger.svg "Menüsymbol") auf **Infrastruktur**. Wenn das Dashboard 'Infrastruktur' angezeigt wird, haben Sie Zugriff auf ein Infrastrukturkonto.
2.  Überprüfen Sie, ob Ihr Cluster ein anderes Infrastrukturkonto verwendet als das zusammen mit Ihrem nutzungsabhängigen Konto gelieferte Konto.
    1.  Klicken Sie im Menü ![Menüsymbol](../icons/icon_hamburger.svg "Menüsymbol") auf **Container > Cluster**.
    2.  Wählen Sie Ihren Cluster in der Tabelle aus.
    3.  Suchen Sie auf der Registerkarte **Übersicht** nach dem Feld **Infrastrukturbenutzer**.
        * Wenn das Feld **Infrastrukturbenutzer** nicht angezeigt wird, verfügen Sie über ein verlinktes nutzungsabhängiges Konto, das für Ihre Infrastruktur- und Plattformkonten dieselben Berechtigungsnachweise verwendet.
        * Wenn ein Feld für den **Infrastrukturbenutzer** angezeigt wird, verwendet der Cluster ein anderes Infrastrukturkonto als das zusammen mit Ihrem nutzungsabhängigen Konto gelieferte Konto. Diese verschiedenen Berechtigungsnachweise gelten für alle Cluster in der Region.
3.  Entscheiden Sie, welche Art von Konto Sie verwenden möchten, um festzustellen, wie Sie das Problem mit der Infrastrukturberechtigung beheben können. Für die meisten Benutzer ist das standardmäßig verknüpfte nutzungsabhängige Konto ausreichend.
    *  Verknüpftes nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto: [Stellen Sie sicher, dass der API-Schlüssel mit den korrekten Berechtigungen konfiguriert ist](cs_users.html#default_account). Wenn Ihr Cluster ein anderes Infrastrukturkonto verwendet, müssen Sie diese Berechtigungsnachweise im Rahmen des Prozesses inaktivieren.
    *  Andere {{site.data.keyword.Bluemix_notm}}-Plattform- und Infrastrukturkonten: Überprüfen Sie, ob Sie auf das Infrastruktur-Portfolio zugreifen können und dass [die Berechtigungsnachweise für das Infrastrukturkonto mit den richtigen Berechtigungen eingerichtet sind](cs_users.html#credentials).
4.  Wenn die Workerknoten des Clusters nicht im Infrastrukturkonto angezeigt werden, sollte Sie überprüfen, ob der [Cluster verwaist ist](#orphaned).

<br />


## Firewall verhindert das Ausführen von CLI-Befehlen
{: #ts_firewall_clis}

{: tsSymptoms}
Wenn Sie die Befehle `ibmcloud`, `kubectl` oder `calicoctl` über die Befehlszeilenschnittstelle ausführen, schlagen sie fehl.

{: tsCauses}
Möglicherweise verhindern Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls.

{: tsResolve}
[Lassen Sie TCP-Zugriff zu, damit die CLI-Befehle ausgeführt werden können](cs_firewall.html#firewall_bx). Diese Task setzt voraus, dass die {{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle [**Administrator** für den Cluster zugewiesen ist.


## Firewall verhindert die Verbindung des Clusters mit Ressourcen
{: #cs_firewall}

{: tsSymptoms}
Wenn die Workerknoten keine Verbindung herstellen können, dann werden Sie möglicherweise eine Vielzahl unterschiedlicher Symptome feststellen. Das System zeigt eventuell eine der folgenden Nachrichten an, wenn die Ausführung des Befehls 'kubectl proxy' fehlschlägt oder wenn Sie versuchen, auf einen Service in Ihrem Cluster zuzugreifen und diese Verbindung fehlschlägt.

  
  Connection refused
  
  {: screen}

  
  Connection timed out
  
  {: screen}

  
  Unable to connect to the server: net/http: TLS handshake timeout
  
  {: screen}

Wenn Sie 'kubectl exec', kubectl attach' oder 'kubectl logs' ausführen, dann wird möglicherweise die folgende Nachricht angezeigt.

  
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  
  {: screen}

Wenn die Ausführung von 'kubectl proxy' erfolgreich verläuft, das Dashboard jedoch nicht verfügbar ist, dann wird möglicherweise die folgende Nachricht angezeigt.

  
  timeout on 172.xxx.xxx.xxx
  
  {: screen}



{: tsCauses}
Möglicherweise wurde eine weitere Firewall eingerichtet oder Sie haben die vorhandenen Firewalleinstellungen für Ihr Konto von IBM Cloud Infrastructure (SoftLayer) angepasst. {{site.data.keyword.containerlong_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Ein weiterer möglicher Grund kann sein, dass Ihre Workerknoten in einer Neuladen-Schleife hängen.

{: tsResolve}
[Gewähren Sie dem Cluster den Zugriff auf Infrastrukturressourcen und andere Services](cs_firewall.html#firewall_outbound)(cs_users.html#platform)]. Diese Task setzt voraus, dass die {{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle <cs_users.html#platform>Administrator für den Cluster zugewiesen ist.

<br />



## Anzeigen eines Clusters oder Arbeiten mit Cluster nicht möglich
{: #cs_cluster_access}

{: tsSymptoms}
* Sie können einen Cluster nicht finden. Wenn Sie `ibmcloud ks clusters` ausführen, wird der Cluster nicht in der Ausgabe aufgeführt.
* Sie können nicht mit einem Cluster arbeiten. Wenn Sie `ibmcloud ks cluster-config` oder andere clusterspezifische Befehle ausführen, wird der Cluster nicht gefunden.


{: tsCauses}
In {{site.data.keyword.Bluemix_notm}} muss jede Ressource in einer Ressourcengruppe enthalten sein. Beispiel: Der Cluster `mycluster` ist möglicherweise in der Ressourcengruppe `default` enthalten. Wenn Ihnen der Kontoeigner Zugriff auf Ressourcen erteilt, indem er Ihnen eine {{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle zuordnet, können Sie über Zugriff auf eine bestimmte Ressource oder Ressourcengruppe verfügen. Wenn Ihnen Zugriff auf eine bestimmte Ressource erteilt wird, verfügen Sie nicht über Zugriff auf die Ressourcengruppe. In diesem Fall müssen Sie nicht ein Ziel für die Ressourcengruppe angeben, um mit den Clustern zu arbeiten, auf die Sie zugreifen können. Wenn Sie eine andere Ressourcengruppe als die Gruppe angeben, in der sich der Cluster befindet, können Aktionen für diesen Cluster fehlschlagen. Wenn Sie im umgekehrten Fall im Rahmen des Zugriffs auf eine Ressourcengruppe Zugriff auf eine Ressource erhalten, müssen Sie eine Ressourcengruppe als Ziel für die Arbeit mit einem Cluster in dieser Gruppe angeben. Falls Sie die CLI-Sitzung nicht als Ziel für die Ressourcengruppe angeben, in der der Cluster enthalten ist, schlagen Aktionen für diesen Cluster fehl.

Wenn Sie einen Cluster nicht finden oder nicht mit einem Cluster arbeiten können, ist möglicherweise eines der folgenden Probleme aufgetreten:
* Sie haben Zugriff auf den Cluster und die Ressourcengruppe, in der sich der Cluster befindet, aber Ihre CLI-Sitzung ist nicht als Ziel für die Ressourcengruppe angegeben, in der sich der Cluster befindet.
* Sie haben Zugriff auf den Cluster, aber nicht als Teil der Ressourcengruppe, in der sich der Cluster befindet. Ihre CLI-Sitzung ist für diese oder eine andere Ressourcengruppe als Ziel angegeben.
* Sie verfügen nicht über Zugriff auf den Cluster.

{: tsResolve}
Gehen Sie wie folgt vor, um Ihre Zugriffsberechtigungen zu überprüfen:

1. Listen Sie alle Benutzerberechtigungen auf.
    ```
    ibmcloud iam user-policies <your_user_name>
    ```
    {: pre}

2. Überprüfen Sie, ob Sie über Zugriff auf den Cluster und die Ressourcengruppe verfügen, in der sich der Cluster befindet.
    1. Suchen Sie eine Richtlinie, die für **Ressourcengruppenname** den Wert der Ressourcengruppe des Clusters und für **Memo** den Wert `Richtlinie gilt für die Ressourcengruppe` aufweist. Wenn diese Richtlinie vorhanden ist, verfügen Sie über Zugriff auf die Ressourcengruppe. Die folgende Richtlinie gibt zum Beispiel an, dass ein Benutzer über Zugriff auf die Ressourcengruppe `test-rg` verfügt:
        ```
        Policy ID:   3ec2c069-fc64-4916-af9e-e6f318e2a16c
        Roles:       Viewer
        Resources:
                     Resource Group ID     50c9b81c983e438b8e42b2e8eca04065
                     Resource Group Name   test-rg
                     Memo                  Policy applies to the resource group
        ```
        {: screen}
    2. Suchen Sie die Richtlinie, die für **Ressourcengruppenname** den Wert der Ressourcengruppe des Clusters, für **Servicename** den Wert `containera-kubernetes` oder keinen Wert und für **Memo** den Wert `Richtlinie gilt für Ressource(n) in der Ressourcengruppe` aufweist. Wenn diese Richtlinie vorhanden ist, verfügen Sie über Zugriff auf die Cluster oder auf alle Ressourcen in der Ressourcengruppe. Die folgende Richtlinie gibt zum Beispiel an, dass ein Benutzer über Zugriff auf Cluster in der Ressourcengruppe `test-rg` verfügt:
        ```
        Policy ID:   e0ad889d-56ba-416c-89ae-a03f3cd8eeea
        Roles:       Administrator
        Resources:
                     Resource Group ID     a8a12accd63b437bbd6d58fb6a462ca7
                     Resource Group Name   test-rg
                     Service Name          containers-kubernetes
                     Service Instance
                     Region
                     Resource Type
                     Resource
                     Memo                  Policy applies to the resource(s) within the resource group
        ```
        {: screen}
    3. Wenn Sie über diese beiden Richtlinien verfügen, fahren Sie unter Schritt 4 mit dem ersten Listenpunkt fort. Wenn Sie nicht über die Richtlinie aus Schritt 2a verfügen, aber über die Richtlinie aus Schritt 2b, fahren Sie unter Schritt 4 mit dem zweiten Listenpunkt fort. Wenn Sie über keine der beiden Richtlinien verfügen, fahren Sie mit Schritt 3 fort.

3. Überprüfen, ob Sie über Zugriff auf den Cluster verfügen, aber nicht im Rahmen des Zugriffs auf die Ressourcengruppe, in der sich der Cluster befindet.
    1. Suchen Sie die Richtlinie, die neben den Feldern **Richtlinien-ID** und **Rollen** keine Werte aufweist. Wenn Sie über diese Richtlinie verfügen, haben Sie im Rahmen des Zugriffs auf das gesamte Konto auch Zugriff auf den Cluster. Die folgende Richtlinie gibt zum Beispiel an, dass ein Benutzer über Zugriff auf alle Ressourcen im Konto verfügt:
        ```
        Policy ID:   8898bdfd-d520-49a7-85f8-c0d382c4934e
        Roles:       Administrator, Manager
        Resources:
                     Service Name
                     Service Instance
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    2. Suchen Sie eine Richtlinie, die für **Servicename** den Wert `container-kubernetes` und für **Serviceinstanz** den Wert der Cluster-ID aufweist. Die Cluster-ID können Sie mithilfe von `ibmcloud ks cluster-get <cluster_name>` suchen. Die folgende Richtlinie gibt zum Beispiel an, dass ein Benutzer über Zugriff auf einen bestimmten Cluster verfügt:
        ```
        Policy ID:   140555ce-93ac-4fb2-b15d-6ad726795d90
        Roles:       Administrator
        Resources:
                     Service Name       containers-kubernetes
                     Service Instance   df253b6025d64944ab99ed63bb4567b6
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    3. Falls Sie über eine dieser Richtlinien verfügen, überspringen Sie den zweiten Listenpunkt von Schritt 4; falls Sie über keine dieser Richtlinien verfügen, überspringen Sie den dritten Listenpunkt von Schritt 4.

4. Wählen Sie abhängig von den Zugriffsrichtlinien eine der folgenden Optionen aus.
    * Falls Sie über Zugriff auf den Cluster und die Ressourcengruppe verfügen, in der sich der Cluster befindet:
      1. Geben Sie als Ziel die Ressourcengruppe an. **Hinweis:** Sie können erst mit Clustern in anderen Ressourcengruppen arbeiten, wenn Sie die Angabe dieser Ressourcengruppe als Ziel zurücknehmen.
          ```
          ibmcloud target -g <ressourcengruppe>
          ```
          {: pre}

      2. Geben Sie den Cluster als Ziel an.
          ```
          ibmcloud ks cluster-config <clustername_oder_-id>
          ```
          {: pre}

    * Falls Sie über Zugriff auf den Cluster, aber  nicht auf die Ressourcengruppe verfügen, in der sich der Cluster befindet:
      1. Geben Sie keine Ressourcengruppe als Ziel an. Falls Sie bereits eine Ressourcengruppe als Ziel angegeben haben, machen Sie diese Angabe rückgängig.
        ```
        ibmcloud target -g none
        ```
        {: pre}
        Dieser Befehl schlägt fehl, weil keine Ressourcengruppe mit dem Namen `none` vorhanden ist. Die Angabe der aktuellen Ressourcengruppe als Ziel wird jedoch rückgängig gemacht, wenn der Befehl fehlschlägt.

      2. Geben Sie den Cluster als Ziel an.
        ```
        ibmcloud ks cluster-config <clustername_oder_-id>
        ```
        {: pre}

    * Wenn Sie keinen Zugriff auf den Cluster haben:
        1. Wenden Sie sich für die Zuordnung einer [{{site.data.keyword.Bluemix_notm}}IAM-Plattformrolle](cs_users.html#platform) für diesen Cluster an Ihren Kontoeigner.
        2. Geben Sie keine Ressourcengruppe als Ziel an. Falls Sie bereits eine Ressourcengruppe als Ziel angegeben haben, machen Sie diese Angabe rückgängig.
          ```
          ibmcloud target -g none
          ```
          {: pre}
          Dieser Befehl schlägt fehl, weil keine Ressourcengruppe mit dem Namen `none` vorhanden ist. Die Angabe der aktuellen Ressourcengruppe als Ziel wird jedoch rückgängig gemacht, wenn der Befehl fehlschlägt.
        3. Geben Sie den Cluster als Ziel an.
          ```
          ibmcloud ks cluster-config <clustername_oder_-id>
          ```
          {: pre}

<br />


## Zugreifen auf Workerknoten mit SSH schlägt fehl
{: #cs_ssh_worker}

{: tsSymptoms}
Es ist kein Zugriff auf Ihren Workerknoten über eine SSH-Verbindung möglich.

{: tsCauses}
Auf den Workerknoten ist SSH nach Kennwort nicht verfügbar.

{: tsResolve}
Verwenden Sie ein Kubernetes-[`DaemonSet` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) für Aktionen, die Sie für jeden Knoten ausführen müssen, und verwenden Sie Jobs für Aktionen, die Sie einmalig ausführen müssen.

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
Damit {{site.data.keyword.containerlong_notm}} die Maschine erneut identifizieren kann, [laden Sie den Bare-Metal-Workerknoten erneut](cs_cli_reference.html#cs_worker_reload). **Hinweis**: Durch das erneute Laden wird außerdem die [Patchversion](cs_versions_changelog.html) der Maschine aktualisiert.

Sie können auch [den Bare-Metal-Workerknoten löschen](cs_cli_reference.html#cs_cluster_rm). **Hinweis**: Die Abrechnung für Bare-Metal-Instanzen erfolgt monatlich.

<br />


## Ändern oder Löschen der Infrastruktur in verwaistem Cluster nicht möglich
{: #orphaned}

{: tsSymptoms}
Sie können im Cluster infrastrukturbezogene Befehle wie zum Beispiel die folgenden nicht ausführen:
* Workerknoten hinzufügen oder entfernen
* Workerknoten neu starten oder erneut laden
* Größe von Worker-Pools ändern
* Cluster aktualisieren

Sie können die Cluster-Workerknoten im IBM Cloud-Infrastrukturkonto (SoftLayer) nicht anzeigen. Sie können jedoch andere Cluster in dem Konto aktualisieren und verwalten.

Außerdem haben Sie sichergestellt, dass Sie über die [richtigen Berechtigungsnachweise für die Infrastruktur](#cs_credentials) verfügen.

{: tsCauses}
Der Cluster kann in einem IBM Cloud-Infrastrukturkonto (SoftLayer) bereitgestellt werden, das nicht mehr mit dem {{site.data.keyword.containerlong_notm}}-Konto verknüpft ist. Der Cluster ist verwaist. Da sich die Ressourcen in einem abweichenden Konto befinden, verfügen Sie nicht über die Berechtigungsnachweisen für die Infrastruktur zum Ändern der Ressourcen.

Im folgenden Szenario wird veranschaulicht, wie es dazu kommen kann, dass ein Cluster verwaist.
1.  Sie verfügen über ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto.
2.  Sie erstellen einen Cluster mit dem Namen `Cluster1`. Die Workerknoten und weitere Infrastrukturressource werden im Infrastrukturkonto angegeben, das mit dem nutzungsabhängigen Konto verknüpft ist.
3.  Später stellen Sie fest, dass von Ihrem Team ein traditionelles oder gemeinsam genutztes IBM Cloud-Infrastrukturkonto (SoftLayer) verwendet wird. Sie verwenden den Befehl `ibmcloud ks credential-set`, um die Berechtigungsnachweise der IBM Cloud-Infrastruktur (SoftLayer) zum Verwenden des Teamkontos zu ändern.
4.  Sie erstellen einen weiteren Cluster mit dem Namen `Cluster2`. Die Workerknoten und weitere Infrastrukturressource werden im Infrastrukturkonto des Teams angegeben.
5.  Sie bemerken, dass für `Cluster1` eine Aktualisierung bzw. ein erneutes Laden der Workerknoten erforderlich ist oder Sie möchten einfach eine Bereinigung zum Löschen durchführen. Da `Cluster1` jedoch in einem unterschiedlichen Infrastrukturkonto angegeben wurde, können Sie seine Infrastrukturressource nicht ändern. `Cluster1` ist verwaist.
6.  Gehen Sie gemäß den folgenden Schritten zur Lösung dieses Problems vor, machen Sie jedoch nicht die Berechtigungsnachweise für die Infrastruktur für das Teamkonto rückgängig. Sie können zwar `Cluster1` löschen, dann ist jedoch `Cluster2` verwaist.
7.  Sie können die Berechtigungsnachweise für die Infrastruktur wieder in die des Teamkontos ändern, von dem `Cluster2` erstellt wurde. Jetzt verfügen Sie nicht mehr über einen verwaisten Cluster.

<br>

{: tsResolve}
1.  Überprüfen Sie, welches Infrastrukturkonto von der Region, in der sich der Cluster befindet, derzeit zum Bereitstellen der Cluster verwendet wird.
    1.  Melden Sie sich bei der [{{site.data.keyword.containerlong_notm}}-Clusterkonsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/containers-kubernetes/clusters) an.
    2.  Wählen Sie Ihren Cluster in der Tabelle aus.
    3.  Suchen Sie auf der Registerkarte **Übersicht** nach dem Feld **Infrastrukturbenutzer**. Mithilfe dieses Felds können Sie feststellen, ob vom {{site.data.keyword.containerlong_notm}}-Konto ein anderes Infrastrukturkonto als das Standardkonto verwendet wird.
        * Wenn das Feld **Infrastrukturbenutzer** nicht angezeigt wird, verfügen Sie über ein verlinktes nutzungsabhängiges Konto, das für Ihre Infrastruktur- und Plattformkonten dieselben Berechtigungsnachweise verwendet. Der Cluster, der nicht geändert werden kann, kann in einem anderen Infrastrukturkonto bereitgestellt werden.
        * Wenn ein Feld für den **Infrastrukturbenutzer** angezeigt wird, verwenden Sie ein anderes Infrastrukturkonto als das, das mit dem nutzungsabhängigen Konto verknüpft ist. Diese verschiedenen Berechtigungsnachweise gelten für alle Cluster in der Region. Der Cluster, der nicht geändert werden kann, kann in einem nutzungsabhängigen Konto oder einem anderen Infrastrukturkonto bereitgestellt werden.
2.  Überprüfen Sie, welches Infrastrukturkonto zum Bereitstellen des Clusters verwendet wurde.
    1.  Wählen Sie in der Registerkarte **Workerknoten** einen Workerknoten aus und notieren Sie seine **ID**.
    2.  Öffnen Sie das Menü ![Menüsymbol](../icons/icon_hamburger.svg "Menüsymbol") und klicken Sie auf **Infrastruktur**.
    3.  Klicken Sie im Infrastrukturnavigationsbereich auf **Geräte > Geräteliste**.
    4.  Suchen Sie die Workerknoten-ID, die Sie vorher notiert haben.
    5.  Wenn Sie die Workerknoten-ID nicht finden, wird der Workerknoten in diesem Infrastrukturkonto nicht bereitgestellt. Wechseln Sie zu einem anderen Infrastrukturkonto und versuchen Sie es erneut.
3.  Verwenden Sie den [Befehl](cs_cli_reference.html#cs_credentials_set) `ibmcloud ks credential-set`, um die Berechtigungsnachweise für die Infrastruktur in die Berechtigungsnachweise des Kontos zu ändern, in dem die Workerknoten des Clusters bereitgestellt werden, die Sie im vorherigen Schritt ermittelt haben.
    Falls Sie nicht mehr über Zugriff auf die Berechtigungsnachweise für die Infrastruktur verfügen und diese auch nicht abrufen können, müssen Sie einen {{site.data.keyword.Bluemix_notm}}-Supportfall öffnen, um den verwaisten Cluster zu entfernen.
    {: note}
4.  [Löschen Sie den Cluster](cs_clusters.html#remove).
5.  Setzen Sie die Berechtigungsnachweise für die Infrastruktur bei Bedarf auf die des vorherigen Kontos zurück. Beachten Sie hierbei Folgendes: Wenn Sie Cluster mit einem anderen Infrastrukturkonto als dem Konto, zu dem Sie gewechselt sind, erstellt haben, können diese Cluster verwaisen.
    * Wenn Sie die Berechtigungsnachweise eines anderen Infrastrukturkontos festlegen möchten, verwenden Sie den [Befehl](cs_cli_reference.html#cs_credentials_set) `ibmcloud ks credential-set`.
    * Wenn Sie die Standardberechtigungsnachweise verwenden möchten, die mit dem nutzungsabhängigen {{site.data.keyword.Bluemix_notm}}-Konto bereitgestellt werden, verwenden Sie den [Befehl](cs_cli_reference.html#cs_credentials_unset) `ibmcloud ks credential-unset`.

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
Um Services an einen Cluster zu binden, müssen Sie über die Benutzerrolle des Cloud Foundry-Entwicklers für den Bereich verfügen, in dem die Serviceinstanz bereitgestellt wurde. Außerdem müssen Sie über Plattformzugriff für {{site.data.keyword.Bluemix_notm}} IAM-Editor auf {{site.data.keyword.containerlong}} verfügen. Um auf die Serviceinstanz zugreifen zu können, müssen Sie an dem Bereich angemeldet sein, in dem die Serviceinstanz bereitgestellt wurde.

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

3. Überprüfen Sie, ob Sie sich in dem richtigen Bereich befinden; listen Sie hierzu die Serviceinstanzen auf.
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

5. Wenn dadurch das Problem nicht behoben wird, sind die {{site.data.keyword.Bluemix_notm}} IAM-Berechtigungen nicht synchron und Sie können das Problem nicht selbst lösen. [Wenden Sie sich an den IBM Support](/docs/get-support/howtogetsupport.html#getting-customer-support), indem Sie einen Supportfall öffnen. Stellen Sie sicher, dass Sie die Cluster-ID, die Benutzer-ID und die Serviceinstanz-ID bereitstellen.
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
Wenn Sie `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` ausführen, wird die folgende Nachricht angezeigt:

```
Dieser Service unterstützt nicht das Erstellen von Schlüsseln.
```
{: screen}

{: tsCauses}
Bestimmte Services in {{site.data.keyword.Bluemix_notm}}, wie z. B. {{site.data.keyword.keymanagementservicelong}}, unterstützen nicht das Erstellen von Serviceberechtigungsnachweisen, die auch als Serviceschlüssel bezeichnet werden. Ohne die Unterstützung von Serviceschlüsseln kann ein Cluster nicht gebunden werden. Informationen zum Suchen einer Liste von Services, die das Erstellen von Serviceschlüsseln unterstützen, finden Sie unter [Externen Apps die Verwendung von {{site.data.keyword.Bluemix_notm}}-Services ermöglichen](/docs/resources/connect_external_app.html#externalapp).

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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.11
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

1.  [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)
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
Diese Task setzt voraus, dass die {{site.data.keyword.Bluemix_notm}} IAM-[Plattformrolle **Administrator**](cs_users.html#platform) für den Cluster zugewiesen ist.

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


## Neustarts von Pods schlagen wiederholt fehl oder Pods werden unerwartet entfernt
{: #pods_fail}

{: tsSymptoms}
Der Pod befand sich in einwandfreiem Zustand, wird aber unerwartet entfernt oder bleibt in einer Neustartschleife stecken.

{: tsCauses}
Es kann sein, dass die Ressourcengrenzwerte der Container überschritten werden oder dass die Pods durch Pods mit höherer Priorität ersetzt wurden.

{: tsResolve}
Gehen Sie wie folgt vor, um festzustellen, ob ein Container aufgrund einer Überschreitung eines Ressourcengrenzwerts gestoppt wird:
<ol><li>Rufen Sie den Namen des Pods ab. Falls Sie eine Bezeichnung verwenden, können Sie diese zum Filtern der Ergebnisse verwenden.<pre class="pre"><code>kubectl get pods --selector='app=wasliberty'</code></pre></li>
<li>Beschreiben Sie den Pod und suchen Sie nach dem **Zähler für Neustart** (Restart Count).<pre class="pre"><code>kubectl describe pod</code></pre></li>
<li>Rufen Sie den Status des Pods ab, wenn er in einem kurzen Zeitraum oft erneut gestartet wird. <pre class="pre"><code>kubectl get pod -o go-template={{range.status.containerStatuses}}{{"Container Name: "}}{{.name}}{{"\r\nLastState: "}}{{.lastState}}{{end}}</code></pre></li>
<li>Überprüfen Sie die Ursache. Beispiel: `OOM Killed` bedeutet, dass nicht ausreichend Speicher vorhanden war und der Container aufgrund eines Ressourcengrenzwerts gestoppt wurde.</li>
<li>Fügen Sie Kapazität zum Cluster hinzu, damit die Ressourcenanforderungen erfüllt werden können.</li></ol>

<br>

Gehen Sie wie folgt vor, um festzustellen, ob der Pod durch Pods mit höherer Priorität ersetzt wurde:
1.  Rufen Sie den Namen des Pods ab.

    ```
    kubectl get pods
    ```
    {: pre}

2.  Beschreiben Sie die YAML-Datei des Pods.

    ```
    kubectl get pod <podname> -o yaml
    ```
    {: pre}

3.  Überprüfen Sie das Feld `priorityClassName`.

    1.  Wenn für das Feld `priorityClassName` kein Wert angegeben ist, weist der Pod die Prioritätsklasse `globalDefault` auf. Wenn der Clusteradministrator nicht die Prioritätsklasse `globalDefault` festgelegt hat, ist der Standardwert null (0) oder die niedrigste Priorität. Der Pod kann von jedem Pod mit einer höheren Priorität zurückgestellt oder entfernt werden.

    2.  Falls für das Feld `priorityClassName` ein Wert angegeben ist, rufen Sie die Prioritätsklasse ab.

        ```
        kubectl get priorityclass <priority_class_name> -o yaml
        ```
        {: pre}

    3.  Notieren Sie den Wert für das Feld `Value`, um die Priorität des Pods zu überprüfen.

4.  Listen Sie vorhandene Prioritätsklassen im Cluster auf.

    ```
    kubectl get priorityclasses
    ```
    {: pre}

5.  Rufen Sie für jede Prioritätsklasse die YAML-Datei ab und notieren Sie den Wert im Feld `Value`.

    ```
    kubectl get priorityclass <priority_class_name> -o yaml
    ```
    {: pre}

6.  Vergleichen Sie den Prioritätsklassenwert des Pos mit den anderen Prioritätsklassenwerten, um festzustellen, ob seine Priorität höher oder niedriger ist.

7.  Wiederholen Sie die Schritte 1 bis 3 für andere Pods im Cluster, um zu überprüfen, welche Prioritätsklasse von ihnen verwendet wird. Wenn die Prioritätsklasse der anderen Pods höher ist als die Ihres Pods, wird Ihr Pod erst bereitgestellt, wenn genügend Ressourcen für Ihren Pod und alle Pods mit höherer Priorität vorhanden sind.

8.  Wenden Sie sich an den Clusteradministrator, um weitere Kapazität zum Cluster hinzuzufügen und zu bestätigen, dass die richtigen Prioritätsklassen zugeordnet sind.

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
-   Wenden Sie sich an den IBM Support, indem Sie einen Fall öffnen. Informationen zum Öffnen eines IBM Supportfalls oder zu Supportstufen und zu Prioritätsstufen von Fällen finden Sie unter [Support kontaktieren](/docs/get-support/howtogetsupport.html#getting-customer-support).
Geben Sie beim Melden eines Problems Ihre Cluster-ID an. Führen Sie den Befehl `ibmcloud ks clusters` aus, um Ihre Cluster-ID abzurufen.
{: tip}

