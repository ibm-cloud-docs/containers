---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Einführung in Cluster in {{site.data.keyword.Bluemix_dedicated_notm}}
{: #dedicated}

Wenn Sie über ein {{site.data.keyword.Bluemix_dedicated}}-Konto für die Verwendung von {{site.data.keyword.containerlong}} verfügen, können Sie Kubernetes-Cluster in einer dedizierten Cloudumgebung (`https://<my-dedicated-cloud-instance>.bluemix.net`) bereitstellen und eine Verbindung mit den vorausgewählten {{site.data.keyword.Bluemix}}-Services herstellen, die ebenfalls darin ausgeführt werden.
{:shortdesc}

Wenn Sie nicht über ein {{site.data.keyword.Bluemix_dedicated_notm}}-Konto verfügen, können Sie [Ihre ersten Schritte mit {{site.data.keyword.containershort_notm}}](container_index.html#container_index) in einem {{site.data.keyword.Bluemix_notm}} Public-Konto ausführen.

## Informationen zur Dedicated-Cloudumgebung
{: #dedicated_environment}

Bei einem {{site.data.keyword.Bluemix_dedicated_notm}}-Konto sind die verfügbaren physischen Ressourcen nur Ihrem Cluster zugeordnet und werden nicht mit Clustern von anderen {{site.data.keyword.IBM_notm}} Kunden geteilt. Sie können eine {{site.data.keyword.Bluemix_dedicated_notm}}-Umgebung einrichten, wenn Sie eine Isolation für Ihren Cluster sowie eine Isolation für die anderen, von Ihnen genutzten {{site.data.keyword.Bluemix_notm}}-Services benötigen. Wenn Sie nicht über ein Dedicated-Konto verfügen, können Sie [Cluster mit dedizierter Hardware in {{site.data.keyword.Bluemix_notm}}  Public-Konten erstellen](cs_clusters.html#clusters_ui).

Mit {{site.data.keyword.Bluemix_dedicated_notm}} können Sie Cluster aus dem Katalog in der Dedicated-Konsole oder mithilfe der {{site.data.keyword.containershort_notm}}-CLI erstellen. Wenn Sie die Dedicated-Konsole verwenden, melden Sie sich mit Ihrer IBMid sowohl bei Ihren Dedicated- als auch den Public-Konten gleichzeitig an. Dank dieser dualen Anmeldung können Sie auf Ihre Public-Cluster über Ihre Dedicated-Konsole zugreifen. Wenn Sie die CLI verwenden, melden Sie sich mithilfe Ihres Dedicated-Endpunkts (`api.<my-dedicated-cloud-instance>.bluemix.net.`) an und legen den {{site.data.keyword.containershort_notm}}-API-Endpunkt der öffentlichen Region, die der Dedicated-Umgebung zugeordnet ist, als Ziel fest.

Die wichtigsten Unterschiede zwischen {{site.data.keyword.Bluemix_notm}} Public- und Bluemix Dedicated-Konten sind die folgenden.

*   In {{site.data.keyword.Bluemix_dedicated_notm}} besitzt und verwaltet {{site.data.keyword.IBM_notm}} das Konto von IBM Cloud Infrastructure (SoftLayer), unter dem die Workerknoten, VLANs und Teilnetze bereitgestellt werden. In {{site.data.keyword.Bluemix_notm}} Public sind Sie Eigner des Kontos von IBM Cloud Infrastructure (SoftLayer).
*   In  {{site.data.keyword.Bluemix_dedicated_notm}} werden die Spezifikationen für die VLANs und Teilnetze im {{site.data.keyword.IBM_notm}}-verwalteten Konto von IBM Cloud Infrastructure (SoftLayer) festgelegt, wenn die Dedicated-Umgebung aktiviert ist. In {{site.data.keyword.Bluemix_notm}} Public werden Spezifikationen für VLANs und Teilnetze festgelegt, wenn der Cluster erstellt wird. 

### Unterschiede in der Clusterverwaltung zwischen den Cloudumgebungen
{: #dedicated_env_differences}

|Bereich|{{site.data.keyword.Bluemix_notm}} Public|{{site.data.keyword.Bluemix_dedicated_notm}}|
|--|--------------|--------------------------------|
|Clustererstellung|Erstellen Sie einen kostenlosen Cluster oder geben Sie die folgenden Details für einen Standardcluster an:<ul><li>Clustertyp</li><li>Name</li><li>Standort</li><li>Maschinentyp</li><li>Anzahl von Workerknoten</li><li>Öffentliches VLAN</li><li>Privates VLAN</li><li>Hardware</li></ul>|Geben Sie die folgenden Details für einen Standardcluster an:<ul><li>Name</li><li>Kubernetes-Version</li><li>Maschinentyp</li><li>Anzahl von Workerknoten</li></ul><p>**Hinweis:** Die VLAN- und Hardware-Einstellungen werden beim Erstellen der {{site.data.keyword.Bluemix_notm}}-Umgebung vordefiniert.</p>|
|Cluster-Hardware und Eigentumsrechte|In Standardclustern kann die Hardware mit anderen {{site.data.keyword.IBM_notm}} Kunden gemeinsam genutzt oder nur Ihnen zugeordnet werden. Die öffentlichen und privaten VLANs sind Ihr Eigentum und werden von Ihnen in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) verwaltet.|In Clustern in {{site.data.keyword.Bluemix_dedicated_notm}} ist die Hardware immer dediziert. Die öffentlichen und privaten VLANs sind Eigentum von IBM und werden von IBM verwaltet. Die Position ist für die {{site.data.keyword.Bluemix_notm}}-Umgebung vordefiniert.|
|Lastausgleichsfunktion und Ingress Networking|Bei der Bereitstellung von Standardclustern werden die folgenden Aktionen automatisch ausgeführt.<ul><li>Ein öffentliches portierbares Teilnetz und ein privates portierbares Teilnetz werden an Ihren Cluster gebunden und Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) zugeordnet.</li><li>Eine portierbare öffentliche IP-Adresse wird für eine hoch verfügbare Lastausgleichsfunktion für Anwendungen verwendet und eine eindeutige öffentliche Route wird im Format '&lt;clustername&gt;.containers.mybluemix.net' zugeordnet. Sie können diese Route verwenden, um mehrere Apps öffentlich zugänglich zu machen. Eine private portierbare IP-Adresse wird für eine private Lastausgleichsfunktion für Anwendungen verwendet.</li><li>Vier öffentliche und vier private portierbare IP-Adressen sind dem Cluster zugeordnet, mit denen Apps über Lastausgleichsservices öffentlich zugänglich gemacht werden können. Zusätzliche Teilnetze können über Ihr Konto von IBM Cloud Infrastructure (SoftLayer) angefordert werden.</li></ul>|Wenn Sie Ihr Dedicated-Konto erstellen, treffen Sie eine Entscheidung, wie Sie Ihre Cluster-Services zugänglich machen und darauf zugreifen wollen. Wenn Sie Ihre eigenen Unternehmens-IP-Bereiche (benutzerverwaltete IPs) verwenden möchten, müssen Sie diese beim [Einrichten einer {{site.data.keyword.Bluemix_dedicated_notm}}-Umgebung](/docs/dedicated/index.html#setupdedicated) angeben. <ul><li>Standardmäßig sind keine öffentlichen portierbaren Teilnetze an Cluster gebunden, die Sie in Ihrem Dedicated-Konto erstellen. Stattdessen haben Sie die Flexibilität, das Konnektivitätsmodell auszuwählen, das am besten zu Ihrem Unternehmen passt.</li><li>Nachdem Sie das Cluster erstellt haben, wählen Sie den Typ der Teilnetze aus, die sie an Ihren Cluster binden und für den Lastausgleich bzw. die Ingress-Konnektivität verwenden möchten.<ul><li>Für öffentliche oder private portierbare Teilnetze können Sie
[Teilnetze zu Clustern hinzufügen](cs_subnets.html#subnets).</li><li>Für benutzerverwaltete IP-Adressen, die Sie IBM beim Dedicated-Onboarding bereitgestellt haben, können Sie [benutzerverwaltete Teilnetze zu Clustern hinzufügen](#dedicated_byoip_subnets).</li></ul></li><li>Nachdem Sie ein Teilnetz an Ihren Cluster gebunden haben, wird die Ingress-Lastausgleichsfunktion für Anwendungen erstellt. Eine öffentliche Ingress-Route wird nur dann erstellt, wenn Sie ein portierbares öffentliches Teilnetz verwenden.</li></ul>|
|NodePort Networking|Machen Sie auf Ihrem Workerknoten einen öffentlichen Port zugänglich und verwenden Sie die öffentliche IP-Adresse des Workerknotens, um öffentlich auf Ihren Service im Cluster zuzugreifen.|Alle öffentlichen IP-Adressen der Workerknoten sind durch eine Firewall blockiert. Bei {{site.data.keyword.Bluemix_notm}}-Services, die dem Cluster hinzugefügt wurden, kann der Knotenport jedoch über eine öffentliche IP-Adresse oder eine private IP-Adresse zugegriffen werden.|
|Persistenter Speicher|Verwenden Sie für Datenträger eine [dynamische Bereitstellung](cs_storage.html#create) oder eine [statische Bereitstellung](cs_storage.html#existing).|Verwenden Sie für Datenträger eine [dynamische Bereitstellung](cs_storage.html#create). [Öffnen Sie ein Support-Ticket](/docs/get-support/howtogetsupport.html#getting-customer-support), um eine Sicherung für ihre Datenträger bzw. eine Wiederherstellung von Ihren Datenträgern anzufordern und andere Speicherfunktionen auszuführen.</li></ul>|
|Image-Registry-URL in {{site.data.keyword.registryshort_notm}}|<ul><li>Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten): <code>registry.ng bluemix.net</code></li><li>Vereinigtes Königreich (Süden): <code>registry.eu-gb.bluemix.net</code></li><li>EU-Central (Frankfurt): <code>registry.eu-de.bluemix.net</code></li><li>Australien (Sydney): <code>registry.au-syd.bluemix.net</code></li></ul>|<ul><li>Verwenden Sie für neue Namensbereiche dieselben regionsbasierten Registrys, die für {{site.data.keyword.Bluemix_notm}} Public definiert sind.</li><li>Verwenden Sie für Namensbereiche, die für einzelne und skalierbare Container in {{site.data.keyword.Bluemix_dedicated_notm}} eingerichtet wurden, <code>registry.&lt;dedizierte_domäne&gt;</code>.</li></ul>|
|Auf die Registry zugreifen|Die einzelnen Optionen sind unter [Private und öffentliche Image-Registrys mit {{site.data.keyword.containershort_notm}} verwenden](cs_images.html) beschrieben.|<ul><li>Die einzelnen Optionen für neue Namensbereiche sind unter [Private und öffentliche Image-Registrys mit {{site.data.keyword.containershort_notm}} verwenden](cs_images.html) beschrieben.</li><li>Für Namensbereiche, die für einzelne und skalierbare Gruppen eingerichtet wurden: [Verwenden Sie ein Token und erstellen Sie einen geheimen Kubernetes-Schlüssel](cs_dedicated_tokens.html#cs_dedicated_tokens) zur Authentifizierung.</li></ul>|
{: caption="Funktionsunterschiede zwischen {{site.data.keyword.Bluemix_notm}} Public und {{site.data.keyword.Bluemix_dedicated_notm}}" caption-side="top"}

<br />


### Servicearchitektur
{: #dedicated_ov_architecture}

Jeder Workerknoten ist mit einer von {{site.data.keyword.IBM_notm}} verwalteten Docker Engine, getrennten Rechenressourcen, Netzbetrieb und einem Datenträgerservice eingerichtet.
{:shortdesc}

Integrierte Sicherheitsfeatures stellen die Isolation, die Funktionalität für die Verwaltung von Ressourcen und die Einhaltung der Sicherheitsbestimmungen für die Workerknoten sicher. Der Workerknoten kommuniziert über sichere TLS-Zertifikate und eine openVPN-Verbindung mit dem Master.


*Kubernetes-Architektur und Netzbetrieb in {{site.data.keyword.Bluemix_dedicated_notm}}*

![{{site.data.keyword.containershort_notm}} Kubernetes-Architektur unter {{site.data.keyword.Bluemix_dedicated_notm}}](images/cs_dedicated_arch.png)

<br />


## {{site.data.keyword.containershort_notm}} unter Dedicated einrichten
{: #dedicated_setup}

Jede {{site.data.keyword.Bluemix_dedicated_notm}}-Umgebung verfügt über ein öffentliches, zum Client gehörendes Unternehmenskonto in {{site.data.keyword.Bluemix_notm}}. Damit Benutzer in der Dedicated-Umgebung Cluster erstellen können, muss der Administrator die Benutzer zu einem öffentlichen Unternehmenskonto hinzufügen.{:shortdesc}

Vorbemerkungen:
  * [{{site.data.keyword.Bluemix_dedicated_notm}}-Umgebung einrichten](/docs/dedicated/index.html#setupdedicated).
  * Wenn Ihr lokales System oder Ihr Unternehmensnetz die öffentlichen Internetendpunkte mithilfe von Proxys oder Firewalls steuert, müssen Sie [erforderliche Ports und IP-Adressen in Ihrer Firewall öffnen](cs_firewall.html#firewall).
  * [Laden Sie die Cloud Foundy-CLI herunter ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudfoundry/cli/releases) und [fügen Sie das IBM Cloud-Administrator-CLI-Plug-in hinzu](/docs/cli/plugins/bluemix_admin/index.html#adding-the-ibm-cloud-admin-cli-plug-in).

Gehen Sie wie folgt vor, damit {{site.data.keyword.Bluemix_dedicated_notm}}-Benutzer auf Cluster zugreifen können:

1.  Der Besitzer Ihres {{site.data.keyword.Bluemix_notm}} Public-Kontos muss einen API-Schlüssel generieren.
    1.  Melden Sie sich beim Endpunkt für Ihre {{site.data.keyword.Bluemix_dedicated_notm}}-Instanz an. Geben Sie die {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise für den Besitzer des Public-Kontos ein und wählen Sie bei entsprechender Aufforderung Ihr Konto aus.

        ```
        bx login -a api.<meine-dedizierte-cloudinstanz>.<region>.bluemix.net
        ```
        {: pre}

        **Hinweis:** Wenn Sie über eine eingebundene ID verfügen, geben Sie `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` ein, um sich bei der {{site.data.keyword.Bluemix_notm}}-CLI anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

    2.  Generieren Sie einen API-Schlüssel, um Benutzer zum öffentlichen Konto einzuladen. Notieren Sie sich den API-Schlüssel, den der Administrator des Dedicated-Kontos im nächsten Schritt verwenden wird.

        ```
        bx iam api-key-create <schlüsselname> -d "Key to invite users to <name_des_dedizierten_kontos>"
        ```
        {: pre}

    3.  Notieren Sie sich die GUID der öffentlichen Kontoorganisation, zu der Sie Benutzer einladen möchten. Diese GUID wird vom Dedicated-Kontoadministrator im nächsten Schritt verwendet.

        ```
        bx account orgs
        ```
        {: pre}

2.  Der Besitzer Ihres {{site.data.keyword.Bluemix_dedicated_notm}}-Kontos kann einzelne oder mehrere Benutzer zu Ihrem Public-Konto einladen.
    1.  Melden Sie sich beim Endpunkt für Ihre {{site.data.keyword.Bluemix_dedicated_notm}}-Instanz an. Geben Sie die {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise für den Besitzer des Dedicated-Kontos ein und wählen Sie bei entsprechender Aufforderung Ihr Konto aus.

        ```
        bx login -a api.<meine-dedizierte-cloudinstanz>.<region>.bluemix.net
        ```
        {: pre}

        **Hinweis:** Wenn Sie über eine eingebundene ID verfügen, geben Sie `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` ein, um sich bei der {{site.data.keyword.Bluemix_notm}}-CLI anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

    2.  Laden Sie die Benutzer zum öffentlichen Konto ein.
        * Gehen Sie wie folgt vor, um einen einzelnen Benutzer einzuladen:

            ```
            bx cf bluemix-admin invite-users-to-public -userid=<benutzer-e-mail> -apikey=<öffentlicher_api-schlüssel> -public_org_id=<öffentliche_org-id>
            ```
            {: pre}

            Ersetzen Sie <em>&lt;benutzer-IBMid&gt;</em> durch die E-Mail des Benutzers, den Sie einladen möchten, <em>&lt;öffentlicher_api-schlüssel&gt;</em> durch den im vorherigen Schritt generierten API-Schlüssel und <em>&lt;öffentliche_org-id&gt;</em> durch die GUID der öffentlichen Kontoorganisation. Weitere Informationen zu diesem Befehl finden Sie unter [Benutzer über IBM Cloud Dedicated einladen](/docs/cli/plugins/bluemix_admin/index.html#admin_dedicated_invite_public).

        * Gehen Sie wie folgt vor, um alle Benutzer einzuladen, die derzeit Mitglied in einer Dedicated-Kontoorganisation sind:

            ```
            bx cf bluemix-admin invite-users-to-public -organization=<dedizierte_org-id> -apikey=<öffentlicher_api-schlüssel> -public_org_id=<öffentliche_org-id>
            ```

            Ersetzen Sie <em>&lt;dedizierte_org-id&gt;</em> durch die ID der Dedicated-Kontoorganisation, <em>&lt;öffentlicher_api-schlüssel&gt;</em> durch den im vorherigen Schritt generierten API-Schlüssel und <em>&lt;öffentliche_org-id&gt;</em> durch die GUID der öffentlichen Kontoorganisation. Weitere Informationen zu diesem Befehl finden Sie unter [Benutzer über IBM Cloud Dedicated einladen](/docs/cli/plugins/bluemix_admin/index.html#admin_dedicated_invite_public).

    3.  Wenn ein Benutzer über eine IBMid verfügt, wird er automatisch zur angegebenen Organisation in dem öffentlichen Konto hinzugefügt. Wenn ein Benutzer noch nicht über eine IBMid verfügt, wird eine Einladung an die Benutzer-E-Mail-Adresse gesendet. Sobald der Benutzer die Einladung annimmt, wird eine IBMid für ihn erstellt und er wird zur angegebenen Organisation im öffentlichen Konto hinzugefügt.

    4.  Überprüfen Sie, dass die Benutzer zum Konto hinzugefügt wurden.

        ```
        bx cf bluemix-admin invite-users-status -apikey=<öffentlicher_api-schlüssel>
        ```
        {: pre}

        Eingeladene Benutzer, die über eine IBMid verfügen, haben den Status `ACTIVE`. Eingeladene Benutzer, die nicht über eine IBMid verfügen, haben den Status `PENDING` oder `ACTIVE`, abhängig davon, ob sie die Einladung zum Konto bereits angenommen haben.

3.  Wenn ein Benutzer Berechtigungen zum Erstellen von Clustern benötigt, müssen Sie diesem Benutzer die Administratorrolle erteilen.

    1.  Klicken Sie in der Menüleiste in der Public-Konsole auf **Verwalten > Sicherheit > Identität und Zugriff** und klicken Sie anschließend auf **Benutzer**.

    2.  Wählen Sie über die Zeile für denjenigen Benutzer, dem Sie Zugriff erteilen wollen, das Menü **Aktionen** aus und klicken Sie anschließend auf **Zugriff zuweisen**.

    3.  Wählen Sie **Zugriff auf Ressourcen zuweisen** aus.

    4.  Wählen Sie in der Liste **Services** den Eintrag **IBM Cloud Container Service** aus.

    5.  Wählen Sie in der Liste **Region** entweder **Alle aktuellen Regionen** oder eine bestimmte Region aus, sofern Sie dazu aufgefordert werden.

    6. Wählen Sie unter **Rollen auswählen** den Eintrag 'Administrator' aus.

    7. Klicken Sie auf **Zuweisen**.

4.  Benutzer können sich beim Dedicated-Kontoendpunkt anmelden, um mit dem Erstellen von Clustern zu beginnen.

    1.  Melden Sie sich beim Endpunkt für Ihre {{site.data.keyword.Bluemix_dedicated_notm}}-Instanz an. Geben Sie Ihre IBMid ein, wenn Sie dazu aufgefordert werden.

        ```
        bx login -a api.<meine-dedizierte-cloudinstanz>.<region>.bluemix.net
        ```
        {: pre}

        **Hinweis:** Wenn Sie über eine eingebundene ID verfügen, geben Sie `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` ein, um sich bei der {{site.data.keyword.Bluemix_notm}}-CLI anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

    2.  Wenn Sie sich zum ersten Mal anmelden, geben Sie Ihre Dedicated-Benutzer-ID und Ihr Kennwort an, wenn Sie dazu aufgefordert werden. Auf diese Weise wird das Dedicated-Konto authentifiziert und werden das Dedicated und das Public-Konto miteinander verknüpft. Im Anschluss müssen Sie nur noch Ihre IBMid angeben, wenn Sie sich anmelden. Weitere Informationen finden Sie unter [Dedizierte ID mit öffentlicher IBMid verbinden](/docs/cli/connect_dedicated_id.html#connect_dedicated_id).

        **Hinweis**: Sie müssen sich sowohl bei Ihrem Dedicated- als auch bei Ihrem Public-Konto anmelden, um Cluster zu erstellen. Wenn Sie sich nur bei Ihrem Dedicated-Konto anmelden möchten, verwenden Sie das Flag `--no-iam` für die Anmeldung am Dedicated-Endpunkt.

    3.  Für den Zugriff auf oder die Erstellung von Clustern in der Dedicated-Umgebung müssen Sie die Region festlegen, die der betreffenden Umgebung zugeordnet ist.

        ```
        bx cs region-set
        ```
        {: pre}

5.  Wenn Sie die Verknüpfung zwischen Ihren Konten aufheben möchten, können Sie Ihre IBMid von Ihrer Dedicated-Benutzer-ID abkoppeln. Weitere Informationen finden Sie unter [Verbindung zwischen dedizierter ID und öffentlicher IBMid aufheben](/docs/cli/connect_dedicated_id.html#disconnect-your-dedicated-id-from-the-public-ibmid).

    ```
    bx iam dedicated-id-disconnect
    ```
    {: pre}

<br />


## Cluster erstellen
{: #dedicated_administering}

Konzipieren Sie die Konfiguration Ihres {{site.data.keyword.Bluemix_dedicated_notm}}-Clusters, um das größtmögliche Maß an Verfügbarkeit und Kapazität zu erzielen.
{:shortdesc}

### Cluster über die GUI erstellen
{: #dedicated_creating_ui}

1.  Öffnen Sie Ihre Dedicated-Konsole: `https://<my-dedicated-cloud-instance>.bluemix.net`.
2. Aktivieren Sie das Kontrollkästchen **Also log in to {{site.data.keyword.Bluemix_notm}} Public** und klicken Sie auf **Log in**.
3. Folgen Sie den Eingabeaufforderungen, um sich mit Ihrer IBMid anzumelden. Wenn Sie sich zum ersten Mal bei Ihrem Dedicated-Konto anmelden, befolgen Sie die Eingabeaufforderungen für die Anmeldung bei {{site.data.keyword.Bluemix_dedicated_notm}}.
4.  Wählen Sie im Katalog **Containers** aus und klicken Sie auf **Kubernetes cluster**.
5.  Geben Sie bei **Cluster Name** einen Namen für den Cluster ein. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich enthalten und darf maximal 35 Zeichen lang sein. Beachten Sie, dass die {{site.data.keyword.IBM_notm}}-zugeordnete Ingress-Unterdomäne aus dem Clusternamen abgeleitet wird. Der Clustername und die Ingress-Unterdomäne bilden zusammen den vollständig qualifizierten Domänennamen, der innerhalb einer Region eindeutig sein muss und maximal 63 Zeichen lang sein darf. Um diese Anforderungen zu erfüllen, kann der Clustername abgeschnitten werden oder der Unterdomäne können zufällige Zeichenwerte zugeordnet werden.
6.  Wählen Sie in **Machine type** einen Maschinentyp aus. Der Maschinentyp definiert die Menge an virtueller CPU und Hauptspeicher, die in jedem Workerknoten eingerichtet wird. Sowohl die virtuelle CPU als auch der Hauptspeicher sind für alle Container verfügbar, die Sie in Ihren Knoten bereitstellen.
    -   Der Maschinentyp 'Micro' gibt die kleinste Option an.
    -   Bei einem ausgeglichenen Maschinentyp ist jeder CPU dieselbe Speichermenge zugeordnet. Dadurch wird die Leistung optimiert.
7.  Wählen Sie für **Number of worker nodes** die benötigte Anzahl von Workerknoten aus. Wählen Sie den Wert `3` aus, um Hochverfügbarkeit für Ihren Cluster sicherzustellen.
8.  Klicken Sie auf **Create Cluster**. Die Detailinformationen für den Cluster werden geöffnet; die Einrichtung der Workerknoten im Cluster kann jedoch einige Minuten in Anspruch nehmen. Auf der Registerkarte **Worker nodes** können Sie den Fortschritt der Workerknotenbereitstellung verfolgen. Wenn die Workerknoten bereit sind, wechselt der Zustand zu **Ready**.

### Cluster über die CLI erstellen
{: #dedicated_creating_cli}

1.  Installieren Sie die {{site.data.keyword.Bluemix_notm}}-CLI sowie das [{{site.data.keyword.containershort_notm}}-Plug-in](cs_cli_install.html#cs_cli_install).
2.  Melden Sie sich beim Endpunkt für Ihre {{site.data.keyword.Bluemix_dedicated_notm}}-Instanz an. Geben Sie Ihre Berechtigungsnachweise für {{site.data.keyword.Bluemix_notm}} ein und wählen Sie Ihr Konto aus, wenn Sie dazu aufgefordert werden.

    ```
    bx login -a api.<meine-dedizierte-cloudinstanz>.<region>.bluemix.net
    ```
    {: pre}

    **Hinweis:** Wenn Sie über eine eingebundene ID verfügen, geben Sie `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` ein, um sich bei der {{site.data.keyword.Bluemix_notm}}-CLI anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

3.  Um eine Region als Ziel auszuwählen, führen Sie `bx cs region-set` aus.

4.  Erstellen Sie einen Cluster mit dem Befehl `cluster-create`. Wenn Sie ein Standardcluster erstellen, wird für die Hardware des Workerknotens nach
Nutzungsstunden abgerechnet.

    Beispiel:

    ```
    bx cs cluster-create --location <standort> --machine-type <maschinentyp> --name <clustername> --workers <anzahl>
    ```
    {: pre}

    <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>Der Befehl zum Erstellen eines Clusters in Ihrer {{site.data.keyword.Bluemix_notm}}-Organisation.</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;standort&gt;</em></code></td>
    <td>Ersetzen Sie &lt;standort&gt; durch die ID des {{site.data.keyword.Bluemix_notm}}-Standorts, dessen Verwendung in Ihrer Dedicated-Umgebung konfiguriert ist.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;maschinentyp&gt;</em></code></td>
    <td>Wählen Sie bei Erstellung eines Standardclusters den Maschinentyp aus. Der Maschinentyp gibt an, welche virtuellen Rechenressourcen jedem Workerknoten zur Verfügung stehen. Weitere Informationen finden Sie unter [Vergleich von kostenlosen Clustern und Standardclustern für {{site.data.keyword.containershort_notm}}](cs_why.html#cluster_types). Bei kostenlosen Clustern muss kein Maschinentyp definiert werden.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;name&gt;</em> durch den Namen Ihres Clusters. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich enthalten und darf maximal 35 Zeichen lang sein. Beachten Sie, dass die {{site.data.keyword.IBM_notm}}-zugeordnete Ingress-Unterdomäne aus dem Clusternamen abgeleitet wird. Der Clustername und die Ingress-Unterdomäne bilden zusammen den vollständig qualifizierten Domänennamen, der innerhalb einer Region eindeutig sein muss und maximal 63 Zeichen lang sein darf. Um diese Anforderungen zu erfüllen, kann der Clustername abgeschnitten werden oder der Unterdomäne können zufällige Zeichenwerte zugeordnet werden.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;anzahl&gt;</em></code></td>
    <td>Die Anzahl der Workerknoten, die im Cluster eingebunden werden sollen. Wird die Option <code>--workers</code> nicht angegeben, wird ein Workerknoten erstellt.</td>
    </tr>
    </tbody></table>

5.  Prüfen Sie, ob die Erstellung des Clusters angefordert wurde.

    ```
    bx cs clusters
    ```
    {: pre}

    **Hinweis:** Es kann bis zu 15 Minuten dauern, bis die Workerknotenmaschinen angewiesen werden und der Cluster in Ihrem
Konto eingerichtet und bereitgestellt wird.

    Nach Abschluss der Bereitstellung Ihres Clusters wird der Status des Clusters in **deployed** (Bereitgestellt) geändert.

    ```
    Name         ID                                   State      Created          Workers   Location   Version
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         dal10      1.8.8
    ```
    {: screen}

6.  Überprüfen Sie den Status der Workerknoten.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Wenn die Workerknoten bereit sind, wechselt der Zustand (State) zu **Normal**, während für den Status die Angabe **Bereit** angezeigt wird. Wenn der Knotenstatus **Bereit** lautet, können Sie auf den Cluster zugreifen.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Location   Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.47.223.113   10.171.42.93   free           normal     Ready    dal10      1.8.8
    ```
    {: screen}

7.  Legen Sie den von Ihnen erstellten Cluster als Kontext für diese Sitzung fest. Führen Sie diese Konfigurationsschritte jedes Mal aus, wenn Sie mit Ihrem Cluster arbeiten.

    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        bx cs cluster-config <clustername_oder_-id>
        ```
        {: pre}

        Wenn
der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können,
um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-prod-dal10-<clustername>.yml
        ```
        {: screen}

    2.  Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.
    3.  Stellen Sie sicher, dass die Umgebungsvariable `KUBECONFIG` richtig eingestellt ist.

        Beispiel für OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Ausgabe:

        ```
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-prod-dal10-<clustername>.yml

        ```
        {: screen}

8.  Gehen Sie wie folgt vor, um das Kubernetes-Dashboard über den Standardport 8001 zu öffnen:
    1.  Legen Sie die Standardportnummer für den Proxy fest.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Öffnen Sie die folgende URL in einem Web-Browser, damit das Kubernetes-Dashboard angezeigt wird.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

### Private und öffentliche Image-Registrys verwenden
{: #dedicated_images}

Die einzelnen Optionen für neue Namensbereiche sind unter [Private und öffentliche Image-Registrys mit {{site.data.keyword.containershort_notm}} verwenden](cs_images.html) beschrieben. Für Namensbereiche, die für einzelne und skalierbare Gruppen eingerichtet wurden: [Verwenden Sie ein Token und erstellen Sie einen geheimen Kubernetes-Schlüssel](cs_dedicated_tokens.html#cs_dedicated_tokens) zur Authentifizierung.

### Clustern Teilnetze hinzufügen
{: #dedicated_cluster_subnet}

Ändern Sie den Pool der verfügbaren portierbaren öffentlichen IP-Adressen, indem Sie Ihrem Cluster Teilnetze hinzufügen. Weitere Informationen finden Sie unter [Clustern Teilnetze hinzufügen](cs_subnets.html#subnets). Überprüfen Sie die folgenden Unterschiede beim Hinzufügen von Teilnetzen zu Dedicated-Clustern.

#### Zusätzliche vom Benutzer verwaltete Teilnetze und IP-Adressen zu Ihren Kubernetes-Clustern hinzufügen
{: #dedicated_byoip_subnets}

Stellen Sie weitere eigene Teilnetze aus einem lokalen Netz zur Verfügung, über das auf {{site.data.keyword.containershort_notm}} zugegriffen werden soll. Sie können private IP-Adressen aus diesen Teilnetzen zu Ingress und zu den Lastausgleichsservices in Ihrem Kubernetes-Cluster hinzufügen. Benutzerverwaltete Teilnetze können auf zwei Arten konfiguriert sein, abhängig von dem Format des Teilnetzes, das Sie verwenden möchten.

Voraussetzungen:
- Vom Benutzer verwaltete Teilnetze können nur zu privaten VLANs hinzugefügt werden.
- Die Begrenzung für die Länge des Teilnetzpräfix beträgt /24 bis /30. Beispiel: `203.0.113.0/24` gibt 253 verwendbare private IP-Adressen an, während `203.0.113.0/30` 1 verwendbare private IP-Adresse angibt.
- Die erste IP-Adresse im Teilnetz muss als Gateway für das Teilnetz verwendet werden.

Vorab müssen Sie das Routing des Netzverkehrs zwischen Ihrem Unternehmensnetz und dem {{site.data.keyword.Bluemix_dedicated_notm}}-Netz konfigurieren, das das benutzerverwaltete Teilnetz verwenden wird.

1. Um Ihr eigenes Teilnetz zu verwenden, [öffnen Sie ein Support-Ticket](/docs/get-support/howtogetsupport.html#getting-customer-support) und stellen die Liste von Teilnetz-CIDRs bereit, die Sie verwenden möchten.
    **Hinweis**: Die Art und Weise, wie die ALB und die Lastausgleichsfunktionen für lokale und interne Kontokonnektivität verwaltet werden, kann abhängig von dem Format des Teilnetz-CIDR variieren. Informationen zu den Konfigurationsunterschieden erhalten Sie im letzten Schritt.

2. Nachdem {{site.data.keyword.IBM_notm}} das benutzerverwaltete Teilnetz bereitgestellt hat, machen Sie es für Ihre Kubernetes-Cluster verfügbar.

    ```
    bx cs cluster-user-subnet-add <clustername> <teilnetz_CIDR> <privates_VLAN>
    ```
    {: pre}
    Ersetzen Sie <em>&lt;clustername&gt;</em> durch den Namen oder die ID Ihres Clusters, <em>&lt;teilnetz-CIDR&gt;</em> durch eines der Teilnetz-CIDRs, das Sie im Support-Ticket angegeben haben, und <em>&lt;privates_VLAN&gt;</em> durch eine verfügbare VLAN-ID. Sie können durch das Ausführen des Befehls `bx cs vlans` nach der ID eines verfügbaren privaten VLANs suchen.

3. Überprüfen Sie, ob die Teilnetze zu Ihrem Cluster hinzugefügt wurden. Das Feld für die Verwaltung durch den Benutzer für vom Benutzer bereitgestellte Teilnetze ist auf _true_ gesetzt.

    ```
    bx cs cluster-get --showResources <clustername>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Optional: [Routing zwischen Teilnetzen auf demselben VLAN aktivieren](cs_subnets.html#vlan-spanning).

5. Wählen Sie eine der folgenden Optionen aus, um lokale und interne Kontokonnektivität zu konfigurieren:
  - Wenn Sie einen privaten IP-Adressbereich 10.x.x.x für das Teilnetz verwendet haben, nutzen Sie gültige IPs aus diesem Bereich, um lokale und interne Kontokonnektivität mit Ingress und einer Lastausgleichsfunktion zu konfigurieren. Weitere Informationen finden Sie unter [Zugriff auf eine App konfigurieren](cs_network_planning.html#planning).
  - Wenn Sie keinen privaten IP-Adressbereich 10.x.x.x für das Teilnetz verwendet haben, nutzen Sie gültige IPs aus diesem Bereich, um lokale Konnektivität mit Ingress und einer Lastausgleichsfunktion zu konfigurieren. Weitere Informationen finden Sie unter [Zugriff auf eine App konfigurieren](cs_network_planning.html#planning). Sie müssen allerdings ein portierbares, privates Teilnetz von IBM Cloud Infrastructure (SoftLayer) verwenden, um interne Kontokonnektivität zwischen Ihrem Cluster und anderen Cloud Foundry-basierten Services zu konfigurieren. Sie können ein portierbares privates Teilnetz mithilfe des Befehls [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) erstellen. In diesem Szenario verfügt Ihr Cluster sowohl über ein benutzerverwaltetes Teilnetz für lokale Konnektivität als auch über ein portierbares privates Teilnetz von IBM Cloud Infrastructure (SoftLayer) für interne Kontokonnektivität.

### Andere Clusterkonfigurationen
{: #dedicated_other}

Sehen Sie sich die folgenden Optionen für andere Clusterkonfigurationen an:
  * [Clusterzugriff verwalten](cs_users.html#managing)
  * [Kubernetes-Master aktualisieren](cs_cluster_update.html#master)
  * [Workerknoten aktualisieren](cs_cluster_update.html#worker_node)
  * [Clusterprotokollierung konfigurieren](cs_health.html#logging)
      * **Hinweis**: Die Aktivierung des Protokolls wird vom Dedicated-Endpunkt nicht unterstützt. Melden Sie sich beim öffentlichen {{site.data.keyword.cloud_notm}}-Endpunkt an und geben Sie als Ziel Ihre öffentliche Organisation und den Bereich an, um die Protokollweiterleitung zu ermöglichen. 
  * [Clusterüberwachung konfigurieren](cs_health.html#monitoring)
      * **Hinweis**: In jedem {{site.data.keyword.Bluemix_dedicated_notm}}-Konto gibt es einen `ibm-monitoring`-Cluster. Dieser Cluster überwacht kontinuierlich den Status von {{site.data.keyword.containerlong_notm}} in der Dedicated-Umgebung, wobei er die Stabilität und Konnektivität der Umgebung prüft. Entfernen Sie diesen Cluster nicht aus der Umgebung.
  * [Kubernetes-Clusterressourcen grafisch darstellen](cs_integrations.html#weavescope)
  * [Cluster entfernen](cs_clusters.html#remove)

<br />


## Apps in Clustern bereitstellen
{: #dedicated_apps}

Sie können Kubernetes-Verfahren verwenden, um Apps in {{site.data.keyword.Bluemix_dedicated_notm}}-Clustern bereitzustellen und sicherzustellen, dass Ihre Apps ununterbrochen betriebsbereit sind.
{:shortdesc}

Befolgen Sie die Anweisungen für die [Bereitstellung von Apps in {{site.data.keyword.Bluemix_notm}} Public-Clustern](cs_app.html#app), um Apps in Clustern bereitzustellen. Überprüfen Sie die folgenden Unterschiede für {{site.data.keyword.Bluemix_dedicated_notm}}-Cluster.

### Öffentlichen Zugriff auf Apps zulassen
{: #dedicated_apps_public}

Für {{site.data.keyword.Bluemix_dedicated_notm}}-Umgebungen sind öffentliche primäre IP-Adressen durch eine Firewall blockiert. Machen Sie eine App statt mit einem NodePort-Service mithilfe eines [LoadBalancer-Service](#dedicated_apps_public_load_balancer) oder über [Ingress](#dedicated_apps_public_ingress) öffentlich verfügbar. Wenn Sie Zugriff auf einen LoadBalancer-Service oder auf Ingress benötigen, die portierbare öffentliche IP-Adressen nutzen, stellen Sie IBM beim Onboarding eine Unternehmensfirewall-Whitelist bereit.

#### Zugriff auf eine App durch Verwenden des Servicetyps 'LoadBalancer' konfigurieren
{: #dedicated_apps_public_load_balancer}

Wenn Sie öffentliche IP-Adressen für die Lastausgleichsfunktion verwenden möchten, stellen Sie sicher, dass eine Unternehmensfirewall-Whitelist für IBM bereitgestellt wurde, oder [öffnen Sie ein Support-Ticket](/docs/get-support/howtogetsupport.html#getting-customer-support), um die Firewall-Whitelist zu konfigurieren. Befolgen Sie dann die Schritte unter [Zugriff auf eine App durch Verwenden des Servicetyps 'LoadBalancer' konfigurieren](cs_loadbalancer.html#config).

#### Öffentlichen Zugriff auf eine App mithilfe von Ingress konfigurieren
{: #dedicated_apps_public_ingress}

Wenn Sie öffentliche IP-Adressen für die Lastausgleichsfunktion für Anwendungen verwenden möchten, stellen Sie sicher, dass eine Unternehmensfirewall-Whitelist für IBM bereitgestellt wurde, oder [öffnen Sie ein Support-Ticket](/docs/get-support/howtogetsupport.html#getting-customer-support), um die Firewall-Whitelist zu konfigurieren. Befolgen Sie dann die Schritte unter [Zugriff auf eine App mithilfe von Ingress konfigurieren](cs_ingress.html#configure_alb).

### Persistenten Speicher erstellen
{: #dedicated_apps_volume_claim}

Informationen zu Optionen für das Erstellen von permanentem Speicher finden Sie unter [Persistenter Datenspeicher](cs_storage.html#planning). Um eine Sicherung für Ihre Datenträger, eine Wiederherstellung von Ihren Datenträgern und andere Speicherfunktionen auszuführen, müssen Sie ein [Support-Ticket öffnen](/docs/get-support/howtogetsupport.html#getting-customer-support).
