---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Sensible Informationen im Cluster schützen
{: #encryption}

Vom {{site.data.keyword.containerlong}}-Cluster werden standardmäßig verschlüsselte Platten zum Speichern von Informationen wie zum Beispiel Konfigurationen in `etcd` oder dem Containerdateisystem verwendet, das auf den sekundären Platten des Workerknotens ausgeführt wird. Speichern Sie sensible Informationen wie Berechtigungsnachweise oder Schlüssel beim Bereitstellen einer App nicht in der YAML-Konfigurationsdatei, Konfigurationszuordnungen oder Scripts. Verwenden Sie stattdessen [geheime Kubernetes-Schlüssel ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/secret/). Sie können auch Daten in geheimen Kubernetes-Schlüsseln verschlüsseln, um zu verhindern, dass nicht berechtigte Benutzer auf sensible Clusterinformationen zugreifen können.
{: shortdesc}

Weitere Informationen zum Schützen des Clusters finden Sie unter [Sicherheit für {{site.data.keyword.containerlong_notm}}](cs_secure.html#security).



## Erläuterungen zur Verwendung von geheimen Schlüsseln
{: #secrets}

Geheime Kubernetes-Schlüssel stellen eine sichere Methode zum Speichern vertraulicher Informationen wie Benutzernamen, Kennwörter oder Schlüssel dar. Wenn Sie vertrauliche Informationen verschlüsseln müssen, [aktivieren Sie {{site.data.keyword.keymanagementserviceshort}}](#keyprotect), um die geheimen Schlüssel zu verschlüsseln. Weitere Informationen darüber, was Sie in geheimen Schlüsseln speichern können, finden Sie in der [Dokumentation zu Kubernetes ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/secret/).
{:shortdesc}

Überprüfen Sie die folgenden Tasks, für die geheime Schlüssel erforderlich sind.

### Service zu einem Cluster hinzufügen
{: #secrets_service}

Wenn Sie einen Service an einen Cluster binden, müssen Sie keinen geheimen Schlüssel erstellen, um die Serviceberechtigungsnachweise zu speichern. Ein geheimer Schlüssel wird automatisch für Sie erstellt. Weitere Informationen hierzu finden Sie im Abschnitt [Cloud-Foundry-Services zu Clustern hinzufügen](cs_integrations.html#adding_cluster).

### Datenverkehr zur App mit geheimen TLS-Schlüsseln verschlüsseln
{: #secrets_tls}

Die Lastausgleichsfunktion für Anwendungen verteilt die Lasten des HTTP-Netzverkehrs auf die Apps in Ihrem Cluster. Um auch einen Lastausgleich für eingehende HTTPS-Verbindungen durchführen zu können, können Sie die Lastausgleichsfunktion so konfigurieren, dass der Netzverkehr entschlüsselt und die entschlüsselte Anforderung an die Apps weitergeleitet wird, die in Ihrem Cluster zugänglich sind. Weitere Informationen finden Sie in der [Ingress-Dokumentation zur Konfiguration](cs_ingress.html#public_inside_3).

Wenn Sie außerdem über Apps verfügen, für die das HTTPS-Protokoll erforderlich ist und der Datenverkehr verschlüsselt werden muss, können Sie geheime Schlüssel für die unidirektionale oder gegenseitige Authentifizierung mit der Annotation `ssl-services` verwenden. Weitere Informationen finden Sie in der [Ingress-Dokumentation zu Annotationen](cs_annotations.html#ssl-services).

### Auf Registry mit Berechtigungsnachweisen zugreifen, die in einem Kubernetes-`imagePullSecret` gespeichert sind
{: #imagepullsecret}

Wenn Sie einen Cluster erstellen, werden die geheimen Schlüssel für die {{site.data.keyword.registrylong}}-Berechtigungsnachweise automatisch im Kubernetes-Namensbereich `default` erstellt. Sie müssen jedoch ein [eigenes imagePullSecret für den Cluster erstellen](cs_images.html#other), wenn Sie in den folgenden Situationen einen Container bereitstellen möchten.
* Auf der Grundlage eines Image in der {{site.data.keyword.registryshort_notm}}-Registry für einen anderen Kubernetes-Namensbereich als `default`.
* Auf der Grundlage eines Image in der {{site.data.keyword.registryshort_notm}}-Registry, die in einer abweichenden {{site.data.keyword.Bluemix_notm}}-Region oder in einem anderem {{site.data.keyword.Bluemix_notm}}-Konto gespeichert ist.
* Auf der Grundlage eines Image, das in einem {{site.data.keyword.Bluemix_notm}} Dedicated-Konto gespeichert ist.
* Auf der Grundlage eines Image, das in einer externen privaten Registry gespeichert ist.

<br />


## Geheime Kubernetes-Schlüssel mit {{site.data.keyword.keymanagementserviceshort}} verschlüsseln
{: #keyprotect}

Sie können geheime Kubernetes-Schlüssel mithilfe von [{{site.data.keyword.keymanagementservicefull}} ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](/docs/services/key-protect/index.html#getting-started-with-key-protect) als [KMS-Provider (KMS - Key Management Service)![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) im Cluster verschlüsseln. Der Anbieter für den Schlüsselmanagementservice (Key Management Service, KMS) ist in den Kubernetes-Versionen 1.10 und 1.11 eine Alpha-Funktion.
{: shortdesc}

Geheime Kubernetes-Schlüssel werden standardmäßig auf einer verschlüsselten Platte in der Komponente `etcd` des von IBM verwalteten Kubernetes-Master gespeichert. Die Workerknoten verfügen auch über sekundäre Platten, die mithilfe von LUKS-Schlüsseln verschlüsselt werden, die von IBM verwaltet und als geheime Schlüssel im Cluster gespeichert werden. Wenn Sie {{site.data.keyword.keymanagementserviceshort}} im Cluster aktivieren, wird Ihr eigener Rootschlüssel verwendet, um geheime Kubernetes-Schlüssel, einschließlich der geheimen LUKS-Schlüssel, zu verschlüsseln. Sie erhalten mehr Kontrolle über Ihre sensiblen Daten, wenn Sie die geheimen Schlüssel mit Ihrem Rootschlüssel verschlüsseln. Wenn Sie eine eigene Verschlüsselung verwenden, fügen Sie damit eine weitere Sicherheitsebene zu den geheimen Kubernetes-Schlüsseln hinzu und können genauer steuern, wer auf sensible Clusterinformationen zugreifen kann. Falls Sie den Zugriff auf die geheimen Schlüssel irreversibel entfernen müssen, können Sie den Rootschlüssel löschen.

**Wichtig:** Wenn Sie den Rootschlüssel in der {{site.data.keyword.keymanagementserviceshort}}-Instanz löschen, können Sie weder auf die Daten in den geheimen Schlüsseln im Cluster zugreifen noch diese Daten danach entfernen.

Vorbereitende Schritte:
* [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)
* Stellen Sie sicher, dass im Cluster die Kubernetes-Version 1.10.8_1524, 1.11.3_1521 oder eine aktuellere Version ausgeführt wird; setzen Sie hierzu `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` ab und überprüfen Sie das Feld **Version**.
* Stellen Sie sicher, dass Sie über die [Berechtigung eines **Administrators**](cs_users.html#access_policies) verfügen, um diese Schritte ausführen zu können.
* Stellen Sie sicher, dass der API-Schlüssel, der für die Region festgelegt ist, in der sich der Cluster befindet, zur Verwendung von Key Protect berechtigt ist. Führen Sie zum Überprüfen des API-Schlüsseleigners, dessen Berechtigungsnachweise für die Region gespeichert sind, den Befehl `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>` aus.

Gehen Sie wie folgt vor, um {{site.data.keyword.keymanagementserviceshort}} zu aktivieren oder die Instanz bzw. den Rootschlüssel zu aktualisieren, von der bzw. dem die geheimen Schlüssel im Cluster verschlüsselt werden:

1.  [Erstellen Sie eine {{site.data.keyword.keymanagementserviceshort}}-Instanz](/docs/services/key-protect/provision.html#provision).

2.  Rufen Sie die Serviceinstanz-ID ab.


    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [Erstellen Sie einen Rootschlüssel](/docs/services/key-protect/create-root-keys.html#create-root-keys). Der Rootschlüssel wird standardmäßig ohne Ablaufdatum erstellt.

    Muss ein Ablaufdatum erstellt werden, weil interne Sicherheitsrichtlinien dies erforderlich machen? [Erstellen Sie den Rootschlüssel mit der API](/docs/services/key-protect/create-root-keys.html#api) und schließen Sie den Parameter `expirationDate` ein. **Wichtig:** Vor dem Ablaufen des Rootschlüssels müssen Sie diese Schritte wiederholen, um den den Cluster so zu aktualisieren, dass ein neuer Rootschlüssel verwendet wird. Andernfalls können Sie Ihre geheimen Schlüssel nicht entschlüsseln.
    {: tip}

4.  Notieren Sie die [Rootschlüssel-**ID**](/docs/services/key-protect/view-keys.html#gui).

5.  Rufen Sie den [{{site.data.keyword.keymanagementserviceshort}}-Endpunkt](/docs/services/key-protect/regions.html#endpoints) der Instanz ab.

6.  Rufen Sie den Namen des Clusters ab, für den Sie {{site.data.keyword.keymanagementserviceshort}} aktivieren möchten. 

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  Aktivieren Sie {{site.data.keyword.keymanagementserviceshort}} im Cluster. Geben Sie die Flags mit den Informationen ein, die Sie zuvor abgerufen haben.

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

Nach der Aktivierung von {{site.data.keyword.keymanagementserviceshort}} im Cluster werden vorhandene geheime Schlüssel und neue geheime Schlüssel, die im Cluster erstellt werden, automatisch unter Verwendung des {{site.data.keyword.keymanagementserviceshort}}-Rootschlüssels verschlüsselt. Sie können den Schlüssel jederzeit turnusmäßig wechseln, indem Sie diese Schritte mit einer neuen Rootschlüssel-ID wiederholen.
