---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-12"

keywords: kubernetes, iks, oks, iro, openshift, red hat, red hat openshift, rhos

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
{:preview: .preview}

# Lernprogramm: Red Hat OpenShift on IBM Cloud-Cluster (Beta) erstellen
{: #openshift_tutorial}

Red Hat OpenShift on IBM Cloud ist als Betaversion zum Testen von OpenShift-Clustern verfügbar. In der Betaversion sind nicht alle Funktionen von {{site.data.keyword.containerlong}} verfügbar. Von Ihnen erstellte OpenShift-Betacluster bleiben nach Ablauf der Betaversion nur 30 Tage erhalten und Red Hat OpenShift on IBM Cloud ist dann allgemein verfügbar.
{: preview}

Mit der **Betaversion von Red Hat OpenShift on IBM Cloud** können Sie {{site.data.keyword.containerlong_notm}}-Cluster mit Workerknoten erstellen, die mit der Container-Orchestrierungsplattformsoftware OpenShift installiert werden. Bei der Verwendung der [OpenShift-Tools und des Katalogs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/welcome/index.html), der unter Red Hat Enterprise Linux ausgeführt wird, zum Entwickeln Ihrer Apps haben Sie alle [Vorteile der verwalteten {{site.data.keyword.containerlong_notm}}-Instanzen](/docs/containers?topic=containers-responsibilities_iks) für Ihre Clusterinfrastrukturumgebung.
{: shortdesc}

OpenShift-Workerknoten sind nur für Standardcluster verfügbar. Red Hat OpenShift on IBM Cloud unterstützt nur OpenShift Version 3.11 (enthält Kubernetes Version 1.11).
{: note}

## Ziele
{: #openshift_objectives}

In den Lerneinheiten des Lernprogramms erstellen Sie einen Red Hat OpenShift on IBM Cloud-Standardcluster, öffnen die OpenShift-Konsole, greifen auf integrierte OpenShift-Komponenten zu, stellen eine App bereit, die {{site.data.keyword.Bluemix_notm}}-Services in einem OpenShift-Projekt verwendet, und machen die App über eine OpenShift-Route zugänglich, sodass externe Benutzer auf den Service zugreifen können.
{: shortdesc}

Diese Seite enthält außerdem Informationen zur OpenShift-Clusterarchitektur und zu Einschränkungen der Betaversion sowie zur Vorgehensweise für Feedback und das Abrufen von Support. 

## Erforderlicher Zeitaufwand
{: #openshift_time}
45 Minuten

## Zielgruppe
{: #openshift_audience}

Dieses Lernprogramm richtet sich an Clusteradministratoren, die lernen möchten, wie sie zum ersten Mal einen Red Hat OpenShift on IBM Cloud-Cluster erstellen.
{: shortdesc}

## Voraussetzungen
{: #openshift_prereqs}

*   Stellen Sie sicher, dass Sie über die folgenden IAM-Zugriffsrichtlinien für {{site.data.keyword.Bluemix_notm}} verfügen: 
    *   [Plattformrolle **Administrator**](/docs/containers?topic=containers-users#platform) für {{site.data.keyword.containerlong_notm}}
    *   [Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für {{site.data.keyword.containerlong_notm}}
    *   [Plattformrolle **Administrator**](/docs/containers?topic=containers-users#platform) für {{site.data.keyword.registrylong_notm}}
*    Stellen Sie sicher, dass der [API-Schlüssel](/docs/containers?topic=containers-users#api_key) für die {{site.data.keyword.Bluemix_notm}}-Region und -Ressourcengruppe mit den richtigen Infrastrukturberechtigungen für das Erstellen eines Clusters eingerichtet ist, **Superuser** oder den [Mindestrollen](/docs/containers?topic=containers-access_reference#infra). 
*   Installieren Sie die Befehlszeilentools.
    *   [Installieren Sie die {{site.data.keyword.Bluemix_notm}}-CLI (`ibmcloud`), das {{site.data.keyword.containershort_notm}}-Plug-in (`ibmcloud ks`) und das {{site.data.keyword.registryshort_notm}}-Plug-in (`ibmcloud cr`)](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps).
    *   [Installieren Sie die CLIs für OpenShift Origin (`oc`) und Kubernetes (`kubectl`)](/docs/containers?topic=containers-cs_cli_install#cli_oc).

<br />


## Architekturübersicht
{: #openshift_architecture}

Das folgende Diagramm und die folgende Tabelle beschreiben die Standardkomponenten, die in einer Red Hat OpenShift on IBM Cloud-Architektur eingerichtet werden.
{: shortdesc}

![Red Hat OpenShift on IBM Cloud-Clusterarchitektur](images/cs_org_ov_both_ses_rhos.png)

|Masterkomponenten| Beschreibung |
|:-----------------|:-----------------|
| Replikate | Masterkomponenten, einschließlich OpenShift Kubernetes-API-Server und etcd-Datenspeicher, haben drei Replikate und werden zur weiteren Verbesserung der Hochverfügbarkeit über Zonen verteilt, sofern sie sich in einer Mehrzonenmetropole befinden. Die Masterkomponenten werden alle 8 Stunden gesichert. |
| `rhos-api` | Der OpenShift Kubernetes-API-Server dient als Haupteinstiegspunkt für alle Anforderungen der Clusterverwaltung vom Workerknoten zum Master. Der API-Server validiert und verarbeitet Anforderungen, die den Status von Kubernetes-Ressourcen, wie z. B. Pods oder Services, ändern, und speichert diesen Status im etcd-Datenspeicher.|
| `openvpn-server` | Der OpenVPN-Server arbeitet mit dem OpenVPN-Client zusammen, um den Master sicher mit dem Workerknoten zu verbinden. Diese Verbindung unterstützt `apiserver proxy`-Aufrufe für Ihre Pods und Services sowie `kubectl exec`-, `attach`- und `logs`-Aufrufe für 'kubelet'.|
| `etcd` | 'etcd' ist ein hoch verfügbarer Schlüsselwertspeicher, in dem der Status aller Kubernetes-Ressourcen eines Clusters gespeichert ist, wie z. B. von Services, Implementierungen und Pods. Daten in 'etcd' werden in einer verschlüsselten Speicherinstanz gesichert, die von IBM verwaltet wird.|
| `rhos-controller` | Der OpenShift-Controller-Manager überwacht neu erstellte Pods und entscheidet, wo sie auf der Basis von Kapazität, Leistungsbedarf, Richtlinienvorgaben, Anti-Affinitätsspezifikationen und Workloadanforderungen bereitgestellt werden. Wird kein Workerknoten gefunden, der mit den Anforderungen übereinstimmt, so wird der Pod nicht im Cluster bereitgestellt. Der Controller überwacht außerdem den Status von Clusterressourcen, wie z. B. Replikatgruppen. Wenn sich der Zustand einer Ressource ändert, z. B. wenn ein Pod in einer Replikatgruppe inaktiv wird, leitet der Controller-Manager Korrekturmaßnahmen ein, um den erforderlichen Zustand zu erreichen. Der `rhos-controller` fungiert sowohl als Scheduler als auch als Controller-Manager in einer nativen Kubernetes-Konfiguration. |
| `cloud-controller-manager` | Der Cloud-Controller-Manager verwaltet cloud-provider-spezifische Komponenten wie die {{site.data.keyword.Bluemix_notm}}-Lastausgleichsfunktion.|
{: caption="Tabelle 1. OpenShift-Masterkomponenten." caption-side="top"}
{: #rhos-components-1}
{: tab-title="Master"}
{: tab-group="rhos-components"}
{: class="simple-tab-table"}

| Workerknotenkomponenten| Beschreibung |
|:-----------------|:-----------------|
| Betriebssystem | Red Hat OpenShift on IBM Cloud-Workerknoten werden unter dem Betriebssystem Red Hat Enterprise Linux 7 (RHEL 7) ausgeführt. |
| Projekte | OpenShift organisiert Ihre Ressourcen in Projekten, bei denen es sich um Kubernetes-Namensbereiche mit Annotationen handelt, und enthält mehr Komponenten als native Kubernetes-Cluster, um OpenShift-Funktionen wie den Katalog auszuführen. Ausgewählte Komponenten der Projekte werden in den folgenden Zeilen beschrieben. Weitere Informationen finden Sie unter [Projekte und Benutzer ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/projects_and_users.html).|
| `kube-system` | Dieser Namensbereich enthält viele Komponenten, die für die Ausführung von Kubernetes auf dem Workerknoten verwendet werden.<ul><li>**`ibm-master-proxy`**: `ibm-master-proxy` ist eine Dämongruppe, die Anforderungen von den Workerknoten an die IP-Adressen der hochverfügbaren Masterreplikate weiterleitet. In Einzelzonenclustern verfügt der Master über drei Replikate auf separaten Hosts. Für Cluster in einer mehrzonenfähigen Zone verfügt der Master über drei Replikate, die über Zonen verteilt sind. Eine hoch verfügbare Lastausgleichsfunktion leitet Anforderungen an den Masterdomänennamen an die Masterreplikate weiter.</li><li>**`openvpn-client`**: Der OpenVPN-Client arbeitet mit dem OpenVPN-Server zusammen, um den Master sicher mit dem Workerknoten zu verbinden. Diese Verbindung unterstützt `apiserver proxy`-Aufrufe für Ihre Pods und Services sowie `kubectl exec`-, `attach`- und `logs`-Aufrufe für 'kubelet'.</li><li>**`kubelet`**: Das 'kubelet' ist ein Workerknotenagent, der auf allen Workerknoten ausgeführt wird und für die Überwachung des Zustands der Pods, die auf dem Workerknoten aktiv sind, sowie für die Überwachung der Ereignisse verantwortlich ist, die der Kubernetes-API-Server sendet. Das 'kubelet' erstellt oder entfernt auf der Basis der Ereignisse Pods, stellt Aktivitäts- und Bereitschaftsprüfungen sicher und meldet dem Kubernetes-API-Server den Zustand der Pods.</li><li>**`calico`**: Calico verwaltet Netzrichtlinien für Ihren Cluster und enthält ein paar Komponenten zum Verwalten der Containernetzkonnektivität, der IP-Adresszuordnung und der Netzverkehrssteuerung.</li><li>**Sonstige Komponenten**: Der Namensbereich `kube-system` enthält auch Komponenten zum Verwalten der von IBM bereitgestellten Ressourcen wie Speicher-Plug-ins für Datei- und Blockspeicher, die Ingress-Lastausgleichsfunktion für Anwendungen (ALB), `fluentd`-Protokollierung und `keepalived`.</li></ul>|
| `ibm-system` | Dieser Namensbereich enthält die `ibm-cloud-provider-ip`-Bereitstellung, die mit `keepalived` arbeitet, um Statusprüfung und Layer 4-Lastausgleich für Anforderungen an App-Pods bereitzustellen. |
| `kube-proxy-and-dns`| Dieser Namensbereich enthält die Komponenten zum Validieren des eingehendenNetzverkehrs anhand der `iptables`-Regeln, die auf dem Workerknoten eingerichtet sind, und fungiert als Proxy für Anforderungen, die im Cluster eingehen oder oder abgehen können. |
| `default` | Dieser Namensbereich wird verwendet, wenn Sie keinen Namensbereich angeben oder ein Projekt für Ihre Kubernetes-Ressourcen erstellen. Darüber hinaus enthält der Standardnamensbereich ('default') die folgenden Komponenten, um Ihre OpenShift-Cluster zu unterstützen.<ul><li>**`router`**: OpenShift verwendet [Routen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/architecture/networking/routes.html), um den Service einer App auf einem Hostnamen zugänglich zu machen, sodass externe Clients den Service erreichen können. Der Router ordnet den Service dem Hostnamen zu.</li><li>**`docker-registry`** und **`registry-console`**: OpenShift stellt eine interne [Container-Image-Registry ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/install_config/registry/index.html) bereit, die Sie zum lokalen Verwalten und Anzeigen von Images über die Konsole verwenden können. Alternativ können Sie die private {{site.data.keyword.registrylong_notm}} konfigurieren.</li></ul>|
| Sonstige Projekte | Weitere Komponenten werden standardmäßig in verschiedenen Namensbereichen installiert, um Funktionen wie Protokollierung und Überwachung sowie die OpenShift-Konsole zu aktivieren.<ul><li><code>ibm-cert-store</code></li><li><code>kube-public</code></li><li><code>kube-service-catalog</code></li><li><code>openshift</code></li><li><code>openshift-ansible-service-broker</code></li><li><code>openshift-console</code></li><li><code>openshift-infra</code></li><li><code>openshift-monitoring</code></li><li><code>openshift-node</code></li><li><code>openshift-template-service-broker</code></li><li><code>openshift-web-console</code></li></ul>|
{: caption="Tabelle 2. OpenShift-Workerknotenkomponenten." caption-side="top"}
{: #rhos-components-2}
{: tab-title="Worker nodes"}
{: tab-group="rhos-components"}
{: class="simple-tab-table"}

<br />


## Lerneinheit 1: Red Hat OpenShift on IBM Cloud-Cluster erstellen
{: #openshift_create_cluster}

Sie können einen Red Hat OpenShift on IBM Cloud-Cluster in {{site.data.keyword.containerlong_notm}} unter Verwendung der [Konsole](#openshift_create_cluster_console) oder [CLI](#openshift_create_cluster_cli) erstellen. Informationen zu den Komponenten, die bei der Erstellung eines Clusters eingerichtet werden, finden Sie in der [Architekturübersicht](#openshift_architecture). OpenShift ist nur für Standardcluster verfügbar. Unter [Häufig gestellte Fragen](/docs/containers?topic=containers-faqs#charges) finden Sie weitere Informationen zum Preis von Standardclustern.
{:shortdesc}

Sie können Cluster nur in der Ressourcengruppe **default** erstellen. Von Ihnen während der Betaphase erstellte OpenShift-Cluster bleiben nach Ablauf der Betaversion 30 Tage erhalten und Red Hat OpenShift on IBM Cloud ist dann allgemein verfügbar.
{: important}

### Cluster über die Konsole erstellen
{: #openshift_create_cluster_console}

Erstellen Sie einen Standard-OpenShift-Cluster in der {{site.data.keyword.containerlong_notm}}-Konsole.
{: shortdesc}

Prüfen Sie zunächst, ob Sie [die Voraussetzungen erfüllen](#openshift_prereqs), um sicherzustellen, dass Sie über die erforderlichen Berechtigungen zum Erstellen eines Clusters verfügen. 

1.  Erstellen Sie einen Cluster.
    1.  Melden Sie sich bei Ihrem [{{site.data.keyword.Bluemix_notm}}-Konto ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/) an.
    2.  Wählen Sie im Menü ![Menüsymbol](../icons/icon_hamburger.svg "Menüsymbol") **Kubernetes** aus und klicken Sie dann auf **Cluster erstellen**.
    3.  Wählen Sie die Konfigurationsdetails und den Namen Ihres Clusters aus. In der Betaversion sind OpenShift-Cluster nur als Standardcluster verfügbar, die sich in den Rechenzentren in Washington, DC, und London befinden. 
        *   Wählen Sie für **Plan auswählen** die Option **Standard** aus.
        *   Als **Ressourcengruppe** müssen Sie die Standardgruppe (**default**) verwenden.
        *   Legen Sie für den **Standort** die Geografie **Nordamerika** oder **Europa** fest, wählen Sie eine Einzelzonen-**** oder Mehrzonenverfügbarkeit**** aus und wählen Sie dann die Workerzone **Washington, DC** oder **London** aus. 
        *   Wählen Sie für den Standardworkerpool**** die **OpenShift**-Clusterversion aus. Red Hat OpenShift on IBM Cloud unterstützt nur OpenShift Version 3.11 (enthält Kubernetes Version 1.11). Wählen Sie einen verfügbaren Typ für Ihre Workerknoten aus. Im Idealfall hat dieser mindestens vier Kerne und 16 GB RAM. 
        *   Legen Sie die Anzahl der Workerknoten fest, die pro Zone erstellt werden sollen, z. B. 3.
    4.  Klicken Sie zum Fertigstellen auf **Cluster erstellen**.<p class="note">Die Clustererstellung kann einige Zeit dauern. Wenn der Clusterstatus **Normal** angezeigt wird, benötigen die Clusternetz- und Lastausgleichskomponenten ungefähr 10 Minuten, um die Clusterdomäne, die Sie für die OpenShift-Webkonsole und andere Routen verwenden, bereitzustellen und zu aktualisieren. Warten Sie, bis der Cluster bereit ist, bevor Sie mit dem nächsten Schritt fortfahren, indem Sie überprüfen, dass die **Ingress-Unterdomäne** dem Muster `<clustername>.<region>.containers.appdomain.cloud` folgt.</p>
2.  Klicken Sie auf der Seite mit den Clusterdetails auf **OpenShift-Webkonsole**.
3.  Klicken Sie im Dropdown-Menü der Menüleiste der OpenShift-Containerplattform auf **Anwendungskonsole** (Application Console). Die Anwendungskonsole listet alle Projektnamensbereiche in Ihrem Cluster auf. Sie können zu einem Namensbereich navigieren, um Ihre Anwendungen, Builds und andere Kubernetes-Ressourcen anzuzeigen. 
4.  Um die nächste Lerneinheit über das Terminal auszuführen, klicken Sie auf Ihr Profil **IAM#benutzer.name@email.com > Anmeldebefehl kopieren**. Fügen Sie den kopierten `oc`-Anmeldebefehl in Ihrem Terminal ein, um sich über die CLI zu authentifizieren.

### Cluster über die CLI erstellen
{: #openshift_create_cluster_cli}

Erstellen Sie einen Standard-OpenShift-Cluster unter Verwendung der {{site.data.keyword.Bluemix_notm}}-CLI.
{: shortdesc}

Prüfen Sie zunächst, ob Sie [die Voraussetzungen erfüllen](#openshift_prereqs), um sicherzustellen, dass Sie über die erforderlichen Berechtigungen zum Erstellen eines Clusters, der `ibmcloud`-CLI und -Plug-ins sowie der `oc`- und `kubectl`-CLIs verfügen.

1.  Melden Sie sich bei dem Konto an, das Sie zum Erstellen von OpenShift-Clustern eingerichtet haben. Wählen Sie die Region **us-east** oder **eu-gb** und die Ressourcengruppe **default** als Ziel aus. Wenn Sie über ein föderiertes Konto verfügen, schließen Sie das Flag `--sso` ein.
    ```
    ibmcloud login -r (us-east|eu-gb) -g default [--sso]
    ```
    {: pre}
2.  Erstellen Sie einen Cluster.
    ```
    ibmcloud ks cluster-create --name <name> --location <zone> --kube-version <openshift-version> --machine-type <workerknotentyp> --workers <anzahl_workerknoten_pro_zone> --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id>
    ```
    {: pre}

    Beispielbefehl zum Erstellen eines Clusters mit drei Workerknoten mit jeweils vier Kerne und 16 GB Speicher in Washington, DC. 

    ```
    ibmcloud ks cluster-create --name my_openshift --location wdc04 --kube-version 3.11_openshift --machine-type b3c.4x16.encrypted  --workers 3 --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id>
    ```
    {: pre}

    <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die verbleibenden Zeilen sollten von rechts nach links gelesen werden, wobei die Befehlskomponente in der ersten Spalte und die zugehörige Beschreibung in der zweiten Spalte angegeben ist.">
    <caption>Komponenten von 'cluster-create'</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>Der Befehl zum Erstellen eines Clusters mit einer klassischen Infrastruktur in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Geben Sie einen Namen für Ihren Cluster an. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich (-) enthalten und darf maximal 35 Zeichen lang sein. Verwenden Sie einen Namen, der in allen {{site.data.keyword.Bluemix_notm}}-Regionen eindeutig ist.</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;zone&gt;</em></code></td>
    <td>Geben Sie die Zone an, in der Sie Ihren Cluster erstellen wollen. Für die Betaversion sind die Zonen `wdc04, wdc06, wdc07, lon04, lon05,` oder `lon06` verfügbar.</p></td>
    </tr>
    <tr>
      <td><code>--kube-version <em>&lt;openshift-version&gt;</em></code></td>
      <td>Sie müssen eine unterstützte OpenShift-Version auswählen. OpenShift-Versionen enthalten eine Kubernetes-Version, die sich von den Kubernetes-Versionen unterscheidet, die in nativen Kubernetes-Ubuntu-Clustern verfügbar sind. Führen Sie den Befehl `ibmcloud ks versions` aus, um die verfügbaren OpenShift-Versionen anzuzeigen. Um einen Cluster mit der neuesten Patchversion zu erstellen, brauchen Sie nur die Haupt- und Nebenversion anzugeben, wie z. B. `3.11_openshift`.<br><br>Red Hat OpenShift on IBM Cloud unterstützt nur OpenShift Version 3.11 (enthält Kubernetes Version 1.11).</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;workerknotentyp&gt;</em></code></td>
    <td>Wählen Sie einen Maschinentyp aus. Sie können Ihre Workerknoten als virtuelle Maschinen auf gemeinsam genutzter oder dedizierter Hardware oder als physische Maschinen auf Bare-Metal-Systemen bereitstellen. Die Typen der verfügbaren physischen und virtuellen Maschinen variieren je nach der Zone, in der Sie den Cluster bereitstellen. Führen Sie den Befehl `ibmcloud ks machine-types --zone <zone>` aus, um die verfügbaren Maschinentypen aufzulisten.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;anzahl_workerknoten_pro_zone&gt;</em></code></td>
    <td>Die Anzahl der Workerknoten, die in den Cluster eingeschlossen werden sollen. Sie sollten mindestens drei Workerknoten angeben, damit Ihr Cluster über genügend Ressourcen zum Ausführen der Standardkomponenten sowie für Hochverfügbarkeit hat. Wird die Option <code>--workers</code> nicht angegeben, wird ein Workerknoten erstellt.</td>
    </tr>
    <tr>
    <td><code>--public-vlan <em>&lt;öffentliche_vlan-id&gt;</em></code></td>
    <td>Wenn für diese Zone bereits ein öffentliches VLAN in Ihrem IBM Cloud-Infrastrukturkonto (SoftLayer) eingerichtet ist, geben Sie die ID des öffentlichen VLAN ein. Führen Sie den Befehl `ibmcloud ks vlans --zone <zone>` aus, um verfügbare VLANs zu prüfen. <br><br>Wenn Sie noch nicht über ein öffentliches VLAN für dieses Konto verfügen, geben Sie diese Option nicht an. {{site.data.keyword.containerlong_notm}} erstellt automatisch ein öffentliches VLAN für Sie.</td>
    </tr>
    <tr>
    <td><code>--private-vlan <em>&lt;private_vlan-id&gt;</em></code></td>
    <td>Wenn für diese Zone bereits ein privates VLAN in Ihrem IBM Cloud-Infrastrukturkonto (SoftLayer) eingerichtet ist, geben Sie die ID des privaten VLAN ein. Führen Sie den Befehl `ibmcloud ks vlans --zone <zone>` aus, um verfügbare VLANs zu prüfen. <br><br>Wenn Sie noch nicht über ein privates VLAN für dieses Konto verfügen, geben Sie diese Option nicht an. {{site.data.keyword.containerlong_notm}} erstellt automatisch ein privates VLAN für Sie.</td>
    </tr>
    </tbody></table>
3.  Listen Sie die Clusterdetails auf. Prüfen Sie den **Clusterstatus** und die **Ingress-Unterdomäne** und notieren Sie sich die **Master-URL**.<p class="note">Die Clustererstellung kann einige Zeit dauern. Wenn der Clusterstatus **Normal** angezeigt wird, benötigen die Clusternetz- und Lastausgleichskomponenten ungefähr 10 Minuten, um die Clusterdomäne, die Sie für die OpenShift-Webkonsole und andere Routen verwenden, bereitzustellen und zu aktualisieren. Warten Sie, bis der Cluster bereit ist, bevor Sie mit dem nächsten Schritt fortfahren, indem Sie überprüfen, dass die **Ingress-Unterdomäne** dem Muster `<clustername>.<region>.containers.appdomain.cloud` folgt.</p>
    ```
    ibmcloud ks cluster-get --cluster <clustername_oder_-id>
    ```
    {: pre}
4.  Laden Sie die Konfigurationsdateien für die Verbindung zu Ihrem Cluster herunter.
    ```
    ibmcloud ks cluster-config --cluster <clustername_oder_-id>
    ```
    {: pre}

    Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie kopieren und einfügen können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

    Beispiel für OS X:

    ```
    export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-<rechenzentrum>-<clustername>.yml
    ```
    {: screen}
5.  Navigieren Sie in Ihrem Browser zur Adresse der **Master-URL** und hängen Sie `/console` an. Beispiel: `https://c0.containers.cloud.ibm.com:23652/console`.
6.  Klicken Sie auf Ihr Profil **IAM#benutzer.name@email.com > Anmeldebefehl kopieren**. Fügen Sie den kopierten `oc`-Anmeldebefehl in Ihrem Terminal ein, um sich über die CLI zu authentifizieren.<p class="tip">Speichern Sie Ihre Cluster-Master-URL, um später auf die OpenShift-Konsole zuzugreifen. In zukünftigen Sitzungen können Sie den `cluster-config`-Schritt überspringen und den Anmeldebefehl stattdessen von der Konsole kopieren.</p>
7.  Stellen Sie sicher, dass die `oc`-Befehle mit Ihrem Cluster ordnungsgemäß ausgeführt werden, indem Sie die Version überprüfen. 

    ```
    oc version
    ```
    {: pre}

    Beispielausgabe:

    ```
    oc v3.11.0+0cbc58b
    kubernetes v1.11.0+d4cacc0
    features: Basic-Auth

    Server https://c0.containers.cloud.ibm.com:23652
    openshift v3.11.98
    kubernetes v1.11.0+d4cacc0
    ```
    {: screen}

    Wenn Sie Operationen, für die Administratorberechtigungen erforderlich sind, wie z. B. das Auflisten aller Workerknoten oder Pods in einem Cluster, nicht ausführen können, laden Sie die TLS-Zertifikate und Berechtigungsdateien für den Clusteradministrator herunter, indem Sie den Befehl `ibmcloud ks cluster-config --cluster <clustername_oder_-id> --admin` ausführen.
    {: tip}

<br />


## Lerneinheit 2: Auf integrierte OpenShift-Services zugreifen
{: #openshift_access_oc_services}

Red Hat OpenShift on IBM Cloud wird mit integrierten Services geliefert, die Sie zum Betreiben Ihres Clusters verwenden können, wie z. B. die OpenShift-Konsole, Prometheus und Grafana. Für den Zugriff auf diese Services in der Betaversion können Sie den lokalen Host einer [Route ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/architecture/networking/routes.html) verwenden. Für die Standardroutendomänennamen gilt das clientspezifische Muster `<servicename>-<namensbereich>.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud`.
{:shortdesc}

Sie können über die [Konsole](#openshift_services_console) oder die [CLI](#openshift_services_cli) auf die integrierten OpenShift-Servicerouten zugreifen. Sie können die Konsole zum Navigieren in den Kubernetes-Ressourcen in einem Projekt verwenden. Mithilfe der CLI können Sie Ressourcen, z. B. Routen, projektübergreifend anzeigen. 

### Auf integrierte OpenShift-Services über die Konsole zugreifen
{: #openshift_services_console}
1.  Klicken Sie über die OpenShift-Webkonsole im Dropdown-Menü der Menüleiste der OpenShift-Containerplattform auf **Anwendungskonsole** (Application Console).
2.  Wählen Sie das Projekt **default** aus und klicken Sie dann im Navigationsfenster auf **Anwendungen > Pods**.
3.  Stellen Sie sicher, dass sich die **Router**-Pods den Status **Running** (Aktiv) aufweisen. Der Router fungiert als Ingress-Punkt für den externen Netzverkehr. Sie können den Router verwenden, um die Services in Ihrem Cluster unter Verwendung einer Route über die externe IP-Adresse des Routers öffentlich zugänglich zu machen. Der Router ist über die öffentliche Hostnetzschnittstelle empfangsbereit, im Gegensatz zu Ihren App-Pods, die nur über private IPs empfangsbereit sind. Der Router fungiert als Proxy für externe Anforderungen für Routenhostnamen an die IPs der App-Pod, die von dem Service angegeben werden, den Sie dem Routenhostnamen zugeordnet haben. 
4.  Klicken Sie im Navigationsfenster des Projekts **default** auf **Anwendungen > Bereitstellungen** und klicken Sie dann auf die Bereitstellung **registry-console**. Zum Öffnen der internen Registry-Konsole müssen Sie die Provider-URL aktualisieren, damit Sie extern auf die Konsole zugreifen können. 
    1.  Suchen Sie auf der Registerkarte **Umgebung** der Detailseite für **registry-console** das Feld **OPENSHIFT_OAUTH_PROVIDER_URL**.  
    2. Fügen Sie im Wertfeld nach `c1` den Wert `-e` ein, z. B. `https://c1-e.eu-gb.containers.cloud.ibm.com:20399`. 
    3. Klicken Sie auf **Speichern**. Jetzt kann über den öffentlichen API-Endpunkt des Cluster-Masters auf die Bereitstellung der Registry-Konsole zugegriffen werden. 
    4.  Klicken Sie im Navigationsfenster des Projekts **default** auf **Anwendungen > Routen**. Zum Öffnen der Registry-Konsole klicken Sie auf den ****Hostnamenwert, z. B. `https://registry-console-default.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud`.<p class="note">Für die Betaversion verwendet die Registry-Konsole selbst signierte TLS-Zertifikate. Sie müssen daher angeben, dass Sie fortfahren möchten, um die Registry-Konsole aufzurufen. Klicken Sie in Google Chrome auf **Advanced > Proceed to <cluster-master-url>** (Erweitert > Gehe zu <cluster-master-url>). Andere Browser haben ähnliche Optionen. Wenn Sie mit dieser Einstellung nicht fortfahren können, versuchen Sie, die URL in einem privaten Browser zu öffnen.</p>
5.  Klicken Sie im Dropdown-Menü der Menüleiste der OpenShift-Containerplattform auf **Clusterkonsole** (Cluster Console).
6.  Erweitern Sie **Überwachung** (Montoring) im Navigationsbereich.
7.  Klicken Sie auf das integrierte Überwachungstool, auf das Sie zugreifen möchten, wie z. B. **Dashboards**. Die Grafana-Route wird geöffnet, `https://grafana-openshift-monitoring.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud`.<p class="note">Wenn Sie zum ersten Mal auf den Hostnamen zugreifen, müssen Sie sich unter Umständen authentifizieren, z. B. indem Sie auf **Mit OpenShift anmelden** klicken und den Zugriff auf Ihre IAM-Identität autorisieren.</p>

### Auf integrierte OpenShift-Services über die CLI zugreifen
{: #openshift_services_cli}

1.  Klicken Sie in der OpenShift-Webkonsole auf Ihr Profil **IAM#benutzer.name@email.com > Anmeldebefehl kopieren** und fügen Sie den Anmeldebefehl zur Authentifizierung in Ihrem Terminal ein.

```
    oc login https://c1-e.<region>.containers.cloud.ibm.com:<port> --token=<zugriffstoken>
    ```
    {: pre}
2.  Überprüfen Sie, ob Ihr Router bereitgestellt wurde. Der Router fungiert als Ingress-Punkt für den externen Netzverkehr. Sie können den Router verwenden, um die Services in Ihrem Cluster unter Verwendung einer Route über die externe IP-Adresse des Routers öffentlich zugänglich zu machen. Der Router ist über die öffentliche Hostnetzschnittstelle empfangsbereit, im Gegensatz zu Ihren App-Pods, die nur über private IPs empfangsbereit sind. Der Router fungiert als Proxy für externe Anforderungen für Routenhostnamen an die IPs der App-Pods, die von dem Service angegeben werden, den Sie dem Routenhostnamen zugeordnet haben.
    ```
    oc get svc router -n default
    ```
    {: pre}

    Beispielausgabe:
    ```
    NAME      TYPE           CLUSTER-IP               EXTERNAL-IP     PORT(S)                      AGE
    router    LoadBalancer   172.21.xxx.xxx   169.xx.xxx.xxx   80:30399/TCP,443:32651/TCP                      5h
    ```
    {: screen}
2.  Rufen Sie den **Host/Port**-Hostnamen der Serviceroute ab, auf die Sie zugreifen möchten. Sie können beispielsweise auf Ihr Grafana-Dashboard zugreifen, um die Metriken zur Ressourcennutzung Ihres Clusters zu prüfen. Für die Standardroutendomänennamen gilt das clientspezifische Muster `<servicename>-<namensbereich>.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud`.
    ```
    oc get route --all-namespaces
    ```
    {: pre}

    Beispielausgabe:
    ```
    NAMESPACE                          NAME                HOST/PORT                                                                    PATH                  SERVICES            PORT               TERMINATION          WILDCARD
    default                            registry-console    registry-console-default.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud                              registry-console    registry-console   passthrough          None
    kube-service-catalog               apiserver           apiserver-kube-service-catalog.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud                        apiserver           secure             passthrough          None
    openshift-ansible-service-broker   asb-1338            asb-1338-openshift-ansible-service-broker.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud            asb                 1338               reencrypt            None
    openshift-console                  console             console.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud                                              console             https              reencrypt/Redirect   None
    openshift-monitoring               alertmanager-main   alertmanager-main-openshift-monitoring.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud                alertmanager-main   web                reencrypt            None
    openshift-monitoring               grafana             grafana-openshift-monitoring.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud                          grafana             https              reencrypt            None
    openshift-monitoring               prometheus-k8s      prometheus-k8s-openshift-monitoring.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud                   prometheus-k8s      web                reencrypt
    ```
    {: screen}
3.  **Einmalige Registry-Aktualisierung**: Um Ihre interne Registry-Konsole über das Internet zugänglich zu machen, bearbeiten Sie die `registry-console`-Bereitstellung, um den öffentlichen API-Endpunkt des Cluster-Masters als OpenShift-Provider-URL zu verwenden. Der öffentliche API-Endpunkt hat dasselbe Format wie der private API-Endpunkt, enthält jedoch ein zusätzliches `-e` in der URL.
    ```
    oc edit deploy registry-console -n default
    ```
    {: pre}
    
Fügen Sie im Feld `Pod Template.Containers.registry-console.Environment.OPENSHIFT_OAUTH_PROVIDER_URL` nach `c1` den Wert `-e` ein, z. B. `https://c1-e.eu-gb.containers.cloud.ibm.com:20399`.
    ```
    Name:                   registry-console
    Namespace:              default
    ...
    Pod Template:
      Labels:  name=registry-console
      Containers:
       registry-console:
        Image:      registry.eu-gb.bluemix.net/armada-master/iksorigin-registrconsole:v3.11.98-6
        ...
        Environment:
          OPENSHIFT_OAUTH_PROVIDER_URL:  https://c1-e.eu-gb.containers.cloud.ibm.com:20399
          ...
    ```
    {: screen}
4.  Öffnen Sie in Ihrem Web-Browser die Route, auf die Sie zugreifen möchten, z. B.`https://grafana-openshift-monitoring.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud`. Wenn Sie zum ersten Mal auf den Hostnamen zugreifen, müssen Sie sich unter Umständen authentifizieren, z. B. indem Sie auf **Mit OpenShift anmelden** klicken und den Zugriff auf Ihre IAM-Identität autorisieren.

<br>
Jetzt befinden Sie sich in der integrierten OpenShift-App! Wenn Sie beispielsweise Grafana geöffnet haben, können Sie die CPU-Auslastung des Namensbereichs oder andere Diagramme prüfen. Wenn Sie auf andere integrierte Tools zugreifen möchten, öffnen Sie deren Routenhostnamen. 

<br />


## Lerneinheit 3: App in Ihrem OpenShift-Cluster bereitstellen
{: #openshift_deploy_app}

Mit Red Hat OpenShift on IBM Cloud können Sie eine neue App erstellen und Ihren App-Service über einen OpenShift-Router für externe Benutzer zugänglich machen.
{: shortdesc}

Wenn Sie nach der letzten Lerneinheit eine Pause gemacht und ein neues Terminal gestartet haben, stellen Sie sicher, dass Sie sich erneut bei Ihrem Cluster anmelden. Öffnen Sie Ihre OpenShift-Konsole unter `https://<master_url>/console`. Beispiel: `https://c0.containers.cloud.ibm.com:23652/console`. Klicken Sie dann auf Ihr Profil **IAM#benutzer.name@email.com > Anmeldebefehl kopieren** und fügen Sie den kopierten `oc`-Anmeldefehl in Ihrem Terminal ein, um sich über die CLI zu authentifizieren.
{: tip}

1.  Erstellen Sie ein Projekt für Ihre App 'Hello World'. Ein Projekt ist eine OpenShift-Version eines Kubernetes-Namensbereichs mit zusätzlichen Annotationen.
    ```
    oc new-project hello-world
    ```
    {: pre}
2.  Erstellen Sie die Beispielapp [aus dem Quellcode ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM/container-service-getting-started-wt). Mit dem OpenShift-Befehl `new-app` können Sie auf ein Verzeichnis in einem fernen Repository verweisen, das die Dockerfile und den App-Code zum Erstellen Ihres Image enthält. Der Befehl erstellt das Image, speichert das Image in der lokalen Docker-Registry und erstellt die Konfigurationen (`dc`) und Services `svc`) für die App-Bereitstellung. Weitere Informationen zum Erstellen neuer Apps [finden Sie in der OpenShift-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/dev_guide/application_lifecycle/new_app.html).
    ```
    oc new-app --name hello-world https://github.com/IBM/container-service-getting-started-wt --context-dir="Lab 1"
    ```
    {: pre}
3.  Stellen Sie sicher, dass die Komponenten der Beispiel-App 'Hello World' erstellt wurden. 
    1.  Suchen Sie das **hello-world**-Image in der integrierten Docker-Registry des Clusters, indem Sie in Ihrem Browser auf die Registry-Konsole zugreifen. Stellen Sie sicher, dass Sie die Provider-URL für die Registry-Konsole wie in der vorherigen Lerneinheit beschrieben mit `-e` aktualisiert haben.
        ```
        https://registry-console-default.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud/
        ```
        {: codeblock}
    2.  Listen Sie die **hello-world**-Services auf und notieren Sie den Servicenamen. Ihre App ist über diese internen Cluster-IP-Adressen für den Datenverkehr empfangsbereit, es sei denn, Sie erstellen eine Route für den Service, sodass der Router externe Datenverkehrsanforderungen an die App weiterleiten kann.
        ```
        oc get svc -n hello-world
        ```
        {: pre}

        Beispielausgabe:
        ```
        NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
        hello-world   ClusterIP   172.21.xxx.xxx   <nones>       8080/TCP   31m
        ```
        {: screen}
    3.  Listen Sie die Pods auf. Pods mit `build` im Namen sind Jobs, die im Rahmen des Erstellungsprozesses für die neue App **ausgeführt** wurden. Stellen Sie sicher, dass der Pod **hello-world** den Status **Running** (Aktiv) aufweist.
        ```
        oc get pods -n hello-world
        ```
        {: pre}

        Beispielausgabe:
        ```
        NAME                READY     STATUS             RESTARTS   AGE
        hello-world-9cv7d   1/1       Running            0          30m
        hello-world-build   0/1       Completed          0          31m
        ```
        {: screen}
4.  Richten Sie eine Route ein, sodass Sie öffentlich auf den {{site.data.keyword.toneanalyzershort}}-Service zugreifen können. Der Hostname hat standardmäßig das Format `<servicename>-<namensbereich>.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud`. Wenn Sie den Hostnamen anpassen möchten, schließen Sie das Flag `--hostname=<hostname>` ein.
    1.  Erstellen Sie eine Route für den Service **hello-world**.
        ```
        oc create route edge --service=hello-world -n hello-world
        ```
        {: pre}
    2.  Rufen Sie die Adresse des Routenhostnamens aus der **Host/Port**-Ausgabe ab.

```
        oc get route -n hello-world
        ```
        {: pre}
        Beispielausgabe:
        ```
        NAME          HOST/PORT                         PATH                                        SERVICES      PORT       TERMINATION   WILDCARD
        hello-world   hello-world-hello.world.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud    hello-world   8080-tcp   edge/Allow    None
        ```
        {: screen}
5.  Greifen Sie auf Ihre App zu.
    ```
    curl https://hello-world-hello-world.<clustername>-<beliebige_id>.<region>.containers.appdomain.cloud
    ```
    {: pre}
    
    Beispielausgabe:
    ```
    Hello world from hello-world-9cv7d! Your app is up and running in a cluster!
    ```
    {: screen}
6.  **Optional**: Um die Ressourcen zu bereinigen, die Sie in dieser Lerneinheit erstellt haben, können Sie die Bezeichnungen verwenden, die den einzelnen Apps zugeordnet sind.
    1.  Listen Sie alle Ressourcen für die einzelnen Apps im Projekt `hello-world` auf.
        ```
        oc get all -l app=hello-world -o name -n hello-world
        ```
        {: pre}
        Beispielausgabe:
        ```
        pod/hello-world-1-dh2ff
        replicationcontroller/hello-world-1
        service/hello-world
        deploymentconfig.apps.openshift.io/hello-world
        buildconfig.build.openshift.io/hello-world
        build.build.openshift.io/hello-world-1
        imagestream.image.openshift.io/hello-world
        imagestream.image.openshift.io/node
        route.route.openshift.io/hello-world
        ```
        {: screen}
    2.  Löschen Sie alle Ressourcen, die Sie erstellt haben.
        ```
        oc delete all -l app=hello-world -n hello-world
        ```
        {: pre}



<br />


## Lerneinheit 4: LogDNA- und Sysdig-Add-ons zum Überwachen des Clusterstatus einrichten
{: #openshift_logdna_sysdig}

Da OpenShift standardmäßig striktere [Sicherheitskontextbeschränkungen (SCC - Security Context Constraints) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_scc.html) als natives Kubernetes festlegt, ist es möglich, dass Sie einige Apps oder Cluster-Add-ons, die Sie mit nativem Kubernetes verwenden können, in OpenShift nicht in derselben Weise bereitstellen können. Insbesondere müssen einige Images als `Root` oder privilegierter Container ausgeführt werden, was in OpenShift standardmäßig verhindert wird. In dieser Lerneinheit erfahren Sie, wie Sie die Standard-SCCs ändern, indem Sie privilegierte Sicherheitskonten erstellen und den `securityContext` in der Pod-Spezifikation so aktualisieren, dass zwei gängige {{site.data.keyword.containerlong_notm}}-Add-ons verwendet werden: {{site.data.keyword.la_full_notm}} und {{site.data.keyword.mon_full_notm}}.
{: shortdesc}

Melden Sie sich zuerst beim Ihrem Cluster als Administrator an. 
1.  Öffnen Sie Ihre OpenShift-Konsole unter `https://<master-url>/console`. Beispiel: `https://c0.containers.cloud.ibm.com:23652/console`.
2.  Klicken Sie auf Ihr Profil **IAM#benutzer.name@email.com > Anmeldebefehl kopieren** und fügen Sie den kopierten `oc`-Anmeldefehl in Ihrem Terminal ein, um sich über die CLI zu authentifizieren.
3.  Laden Sie die Admin-Konfigurationsdateien für Ihren Cluster herunter.
    ```
    ibmcloud ks cluster-config --cluster <clustername_oder_-id> --admin
    ```
    {: pre}
    
    Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie kopieren und einfügen können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

    Beispiel für OS X:

    ```
    export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-<datacenter>-<clustername>.yml
    ```
    {: screen}
4.  Setzen Sie die Lerneinheit zum Einrichten von [{{site.data.keyword.la_short}}](#openshift_logdna) und [{{site.data.keyword.mon_short}}](#openshift_sysdig) fort.

### Lerneinheit 4a: LogDNA einrichten
{: #openshift_logdna}

Richten Sie ein Projekt und ein privilegiertes Servicekonto für {{site.data.keyword.la_full_notm}} ein. Erstellen Sie dann eine {{site.data.keyword.la_short}}-Instanz in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto. Um Ihre {{site.data.keyword.la_short}}-Instanz in Ihren OpenShift-Cluster zu integrieren, müssen Sie die Dämongruppe, die für die Verwendung des privilegierten Servicekontos bereitgestellt wurde, so ändern, dass sie als Root ausgeführt wird.
{: shortdesc}

1.  Richten Sie das Projekt und das privilegierte Servicekonto für LogDNA ein.
    1.  Erstellen Sie als Clusteradministrator ein Projekt `logdna`.
        ```
        oc adm new-project logdna
        ```
        {: pre}
    2.  Richten Sie das Projekt so ein, dass die nachfolgenden Ressourcen, die Sie erstellen, im Namensbereich des Projekts `logdna` verwendet werden.
        ```
        oc project logdna
        ```
        {: pre}
    3.  Erstellen Sie ein Servicekonto für das Projekt `logdna`.
        ```
        oc create serviceaccount logdna
        ```
        {: pre}
    4.  Fügen Sie dem Servicekonto für das Projekt `logdna` eine Sicherheitskontextbeschränkung 'privileged' hinzu. <p class="note">Wenn Sie überprüfen möchten, welche Berechtigung die SCC-Richtlinie `privileged` dem Servicekonto zuordnet, führen Sie den Befehl `oc describe scc privileged` aus. Weitere Informationen zu SCCs finden Sie in der [OpenShift-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_scc.html).</p>
        ```
        oc adm policy add-scc-to-user privileged -n logdna -z logdna
        ```
        {: pre}
2.  Erstellen Sie Ihre {{site.data.keyword.la_full_notm}}-Instanz in derselben Ressourcengruppe wie Ihren Cluster. Wählen Sie einen Preistarif aus, der den Aufbewahrungszeitraum für Ihre Protokolle festlegt, wie z. B. `lite`, bei dem Protokolle für 0 Tage aufbewahrt werden. Die Region muss nicht mit der Region Ihres Clusters übereinstimmen. Weitere Informationen finden Sie unter [Instanz bereitstellen](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-provision) und [Preistarife](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about#overview_pricing_plans).
    ```
    ibmcloud resource service-instance-create <serviceinstanzname> logdna (lite|7-days|14-days|30-days) <region> [-g <ressourcengruppe>]
    ```
    {: pre}
    
    Beispielbefehl:
    ```
    ibmcloud resource service-instance-create logdna-openshift logdna lite us-south
    ```
    {: pre}
    
    Beachten Sie in der Ausgabe die Serviceinstanz-**ID**, die das Format `crn:v1:bluemix:public:logdna:<region>:<id-zeichenfolge>::` aufweist.
    ```
    Die Serviceinstanz <name> wurde erstellt.
                 
    Name:         <name>   
    ID:           crn:v1:bluemix:public:logdna:<region>:<id-zeichenfolge>::   
    GUID:         <guid>   
    Location:     <region>   
    ...
    ```
    {: screen}    
3.  Rufen Sie den Einpflegeschlüssel Ihrer {{site.data.keyword.la_short}}-Instanz ab. Der LogDNA-Einpflegeschlüssel wird verwendet, um ein sicheres Web-Service-Socket für den LogDNA-Einpflegeserver zu öffnen und den Protokollierungsagenten für den {{site.data.keyword.la_short}}-Service zu authentifizieren.
    1.  Erstellen Sie einen Serviceschlüssel für Ihre LogDNA-Instanz.
        ```
        ibmcloud resource service-key-create <schlüsselname> Administrator --instance-id <logdna-instanz-id>
        ```
        {: pre}
    2.  Notieren Sie den **Einplegeschlüssel** Ihres Serviceschlüssels.
        ```
        ibmcloud resource service-key <schlüsselname>
        ```
        {: pre}
        
        Beispielausgabe:
        ```
        Name:          <schlüsselname>  
        ID:           crn:v1:bluemix:public:logdna:<region>:<id-zeichenfolge>::    
        Created At:    Thu Jun  6 21:31:25 UTC 2019   
        State:         active   
        Credentials:                                   
                       apikey:                   <api-schlüsselwert>      
                       iam_apikey_description:   Auto-generated for key <id>     
                       iam_apikey_name:          <schlüsselname>       
                       iam_role_crn:             crn:v1:bluemix:public:iam::::role:Administrator      
                       iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::<id-zeichenfolge>     
                       ingestion_key:            111a11aa1a1a11a1a11a1111aa1a1a11    
        ```
        {: screen}
4.  Erstellen Sie einen geheimen Kubernetes-Schlüssel, um Ihren LogDNA-Einpflegeschlüssel für Ihre Serviceinstanz zu speichern.
    ```
     oc create secret generic logdna-agent-key --from-literal=logdna-agent-key=<logdna-einpflegeschlüssel>
    ```
    {: pre}
5.  Erstellen Sie eine Kubernetes-Dämongruppe, um den LogDNA-Agenten auf jedem Worker-Knoten Ihres Kubernetes-Clusters zu implementieren. Der LogDNA-Agent erfasst Protokolle mit der Erweiterung `*.log` und erweiterungslose Dateien, die im Verzeichnis `/var/log` Ihres Pods gespeichert sind. Standardmäßig werden Protokolle aus allen Namensbereichen, einschließlich `kube-system`, erfasst und automatisch an den {{site.data.keyword.la_short}}-Service weitergeleitet.
    ```
    oc create -f https://assets.us-south.logging.cloud.ibm.com/clients/logdna-agent-ds.yaml
    ```
    {: pre}
6.  Bearbeiten Sie die Konfiguration der Dämongruppe für den LogDNA-Agenten so, dass sie auf das Servicekonto verweist, das Sie zuvor erstellt haben, und dass der Sicherheitskontext auf 'privileged' gesetzt wird.
    ```
    oc edit ds logdna-agent
    ```
    {: pre}
    
    Fügen Sie in der Konfigurationsdatei die folgenden Spezifikationen hinzu. 
    *   Fügen Sie in `spec.template.spec` die Angabe `serviceAccount: logdna` hinzu.
    *   Fügen Sie in `spec.template.spec.containers` die Angabe `securityContext: privileged: true` hinzu.
    *   Wenn Sie Ihre {{site.data.keyword.la_short}}-Instanz in einer anderen Region als `us-south` erstellt haben, aktualisieren Sie die Werte der Umgebungsvariablen `spec.template.spec.containers.env` für `LDAPIHOST` und `LDLOGHOST` mit der Region.`` 

    Beispielausgabe:
    ```
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    spec:
      ...
      template:
        ...
        spec:
          serviceAccount: logdna
          containers:
          - securityContext:
              privileged: true
            ...
            env:
            - name: LOGDNA_AGENT_KEY
              valueFrom:
                secretKeyRef:
                  key: logdna-agent-key
                  name: logdna-agent-key
            - name: LDAPIHOST
              value: api.<region>.logging.cloud.ibm.com
            - name: LDLOGHOST
              value: logs.<region>.logging.cloud.ibm.com
          ...
    ```
    {: screen}
7.  Stellen Sie sicher, dass der `logdna-agent`-Pod auf allen Knoten den Status **Running** (Aktiv) aufweist.
    ```
    oc get pods
    ```
    {: pre}
8.  Klicken Sie über [{{site.data.keyword.Bluemix_notm}}-Beobachtbarkeit > Protokollierungskonsole](https://cloud.ibm.com/observe/logging) in der Zeile für Ihre {{site.data.keyword.la_short}}-Instanz auf **LogDNA anzeigen**. Das LogDNA-Dashboard wird geöffnet und Sie können mit der Analyse Ihrer Protokolle beginnen.

Weitere Informationen zur Verwendung von {{site.data.keyword.la_short}} finden Sie unter [Nächste Schritte](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-kube#kube_next_steps).

### Lerneinheit 4b: Sysdig einrichten
{: #openshift_sysdig}

Erstellen Sie eine {{site.data.keyword.mon_full_notm}}-Instanz in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto. Um Ihre {{site.data.keyword.mon_short}}-Instanz in Ihren OpenShift-Cluster zu integrieren, müssen Sie ein Script ausführen, das ein Projekt und ein privilegiertes Servicekonto für den Sysdig-Agenten erstellt.
{: shortdesc}

1.  Erstellen Sie Ihre {{site.data.keyword.mon_full_notm}}-Instanz in derselben Ressourcengruppe wie Ihren Cluster. Wählen Sie einen Preistarif aus, der den Aufbewahrungszeitraum für Ihre Protokolle festlegt, wie z. B. `lite`. Die Region muss nicht mit der Region Ihres Clusters übereinstimmen. Weitere Informationen finden Sie unter [Instanz bereitstellen](/docs/services/Monitoring-with-Sysdig?topic=Sysdig-provision).
    ```
    ibmcloud resource service-instance-create <serviceinstanzname> sysdig-monitor (lite|graduated-tier) <region> [-g <ressourcengruppe>]
    ```
    {: pre}
    
    Beispielbefehl:
    ```
    ibmcloud resource service-instance-create sysdig-openshift sysdig-monitor lite us-south
    ```
    {: pre}
    
    Beachten Sie in der Ausgabe die Serviceinstanz-**ID**, die das Format `crn:v1:bluemix:public:logdna:<region>:<id-zeichenfolge>::` aufweist.
    ```
    Die Serviceinstanz <name> wurde erstellt.
                 
    Name:         <name>   
    ID:           crn:v1:bluemix:public:sysdig-monitor:<region>:<id-zeichenfolge>::   
    GUID:         <guid>   
    Location:     <region>   
    ...
    ```
    {: screen}    
2.  Rufen Sie den Zugriffsschlüssel Ihrer {{site.data.keyword.mon_short}}-Instanz ab. Der Sysdig-Zugriffsschlüssel wird verwendet, um ein sicheres Web-Service-Socket für den Sysdig-Einpflegeserver zu öffnen und den Überwachungsagenten für den {{site.data.keyword.mon_short}}-Service zu authentifizieren.
    1.  Erstellen Sie einen Serviceschlüssel für Ihre Sysdig-Instanz.
        ```
        ibmcloud resource service-key-create <schlüsselname> Administrator --instance-id <sysdig-instanz-id>
        ```
        {: pre}
    2.  Notieren Sie sich den **Sysdig-Zugriffsschlüssel** und den **Sysdig-Collector-Endpunkt** Ihres Serviceschlüssels.
        ```
        ibmcloud resource service-key <schlüsselname>
        ```
        {: pre}
        
        Beispielausgabe:
        ```
        Name:          <schlüsselname>  
        ID:            crn:v1:bluemix:public:sysdig-monitor:<region>:<id-zeichenfolge>::    
        Created At:    Thu Jun  6 21:31:25 UTC 2019   
        State:         active   
        Credentials:                                   
                       Sysdig Access Key:           11a1aa11-aa1a-1a1a-a111-11a11aa1aa11      
                       Sysdig Collector Endpoint:   ingest.<region>.monitoring.cloud.ibm.com      
                       Sysdig Customer Id:          11111      
                       Sysdig Endpoint:             https://<region>.monitoring.cloud.ibm.com  
                       apikey:                   <api-schlüsselwert>      
                       iam_apikey_description:   Auto-generated for key <id>     
                       iam_apikey_name:          <schlüsselname>       
                       iam_role_crn:             crn:v1:bluemix:public:iam::::role:Administrator      
                       iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::<id-zeichenfolge>       
        ```
        {: screen}
3.  Führen Sie das Script aus, um ein Projekt `ibm-observe` mit einem privilegierten Servicekonto und einer Kubernetes-Dämongruppe einzurichten und den Sysdig-Agenten auf allen Workerknoten Ihres Kubernetes-Clusters bereitzustellen. Der Sysdig-Agent erfasst Metriken wie die CPU-Auslastung der Workerknoten, die Workerknotenspeicherbelegung, den HTTP-Datenverkehr zu und von Ihren Containern sowie Daten zu mehreren Infrastrukturkomponenten. 

    Ersetzen Sie im folgenden Befehl <sysdig-zugriffsschlüssel> und <sysdig-collector-endpunkt> durch den Serviceschlüssel, den Sie zuvor erstellt haben. Mit <tag> können Sie Tags mit Ihrem Sysdig-Agenten verknüpfen, wie z. B. `role:service,location:us-south`, um Sie bei der Identifizierung der Umgebung zu unterstützen, aus der die Metriken stammen.

    ```
    curl -sL https://ibm.biz/install-sysdig-k8s-agent | bash -s -- -a <sysdig-zugriffsschlüssel> -c <sysdig-collector-endpunkt> -t <tag> -ac 'sysdig_capture_enabled: false' --openshift
    ```
    {: pre}
    
    Beispielausgabe: 
    ```
    * Detecting operating system
    * Downloading Sysdig cluster role yaml
    * Downloading Sysdig config map yaml
    * Downloading Sysdig daemonset v2 yaml
    * Creating project: ibm-observe
    * Creating sysdig-agent serviceaccount in project: ibm-observe
    * Creating sysdig-agent access policies
    * Creating sysdig-agent secret using the ACCESS_KEY provided
    * Retreiving the IKS Cluster ID and Cluster Name
    * Setting cluster name as <clustername>
    * Setting ibm.containers-kubernetes.cluster.id 1fbd0c2ab7dd4c9bb1f2c2f7b36f5c47
    * Updating agent configmap and applying to cluster
    * Setting tags
    * Setting collector endpoint
    * Adding additional configuration to dragent.yaml
    * Enabling Prometheus
    configmap/sysdig-agent created
    * Deploying the sysdig agent
    daemonset.extensions/sysdig-agent created
    ```
    {: screen}
        
4.  Stellen Sie sicher, dass die `sydig-agent`-Pods auf allen Knoten zeigen, dass **1/1** Pods bereit (Ready) sind und dass alle Pods den Status **Running** (Aktiv) aufweisen.
    ```
    oc get pods
    ```
    {: pre}
    
    Beispielausgabe:
    ```
    NAME                 READY     STATUS    RESTARTS   AGE
    sysdig-agent-qrbcq   1/1       Running   0          1m
    sysdig-agent-rhrgz   1/1       Running   0          1m
    ```
    {: screen}
5.  Klicken Sie über [{{site.data.keyword.Bluemix_notm}}-Beobachtbarkeit > Überwachungskonsole](https://cloud.ibm.com/observe/logging) in der Zeile für Ihre {{site.data.keyword.mon_short}}-Instanz auf **Sysdig anzeigen**. Das Sysdig-Dashboard wird geöffnet und Sie können mit der Analyse Ihrer Clustermetriken beginnen.

Weitere Informationen zur Verwendung von {{site.data.keyword.mon_short}} finden Sie in der [Dokumentation der nächsten Schritte](/docs/services/Monitoring-with-Sysdig?topic=Sysdig-kubernetes_cluster#kubernetes_cluster_next_steps).

### Optional: Bereinigung
{: #openshift_logdna_sysdig_cleanup}

Entfernen Sie die {{site.data.keyword.la_short}}- und {{site.data.keyword.mon_short}}-Instanzen aus Ihrem Cluster und Ihrem {{site.data.keyword.Bluemix_notm}}-Konto. Beachten Sie, dass Sie nach dem Löschen der Instanzen aus Ihrem Konto nur auf diese Informationen zugreifen können, wenn Sie die Protokolle und Metriken im [persistenten Speicher](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-archiving) speichern.
{: shortdesc}

1.  Bereinigen Sie die {{site.data.keyword.la_short}}- und {{site.data.keyword.mon_short}}-Instanzen in Ihrem Cluster, indem Sie die Projekte entfernen, die Sie für diese Instanzen erstellt haben. Wenn Sie ein Projekt löschen, werden dessen Ressourcen, z. B. Servicekonten und Dämongruppen, ebenfalls gelöscht.
    ```
    oc delete project logdna
    ```
    {: pre}
    ```
    oc delete project ibm-observe
    ```
    {: pre}
2.  Entfernen Sie die Instanzen aus Ihrem {{site.data.keyword.Bluemix_notm}}-Konto.
    *   [{{site.data.keyword.la_short}}-Instanz entfernen](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-remove)
    *   [{{site.data.keyword.mon_short}}-Instanz entfernen](/docs/services/Monitoring-with-Sysdig?topic=Sysdig-remove)

<br />


## Einschränkungen
{: #openshift_limitations}

Red Hat OpenShift on IBM Cloud (Beta) wird mit den folgenden Einschränkungen freigegeben.
{: shortdesc}

**Cluster**:
*   Sie können nur Standardcluster erstellen, keine kostenlosen Cluster. 
*   Standorte sind in zwei Mehrzonenmetropolbereichen verfügbar, Washington (DC), und London. Unterstützte Zonen sind `wdc04, wdc06, wdc07, lon04, lon05` und `lon06`.
*   Sie können keinen Cluster mit Workerknoten erstellen, die unter mehreren Betriebssystemen ausgeführt werden, z. B. OpenShift unter Red Hat Enterprise Linux und natives Kubernetes unter Ubuntu.
*   Der [Cluster-Autoscaler](/docs/containers?topic=containers-ca) wird nicht unterstützt, da er Kubernetes Version 1.12 oder höher erfordert. OpenShift 3.11 umfasst nur Kubernetes Version 1.11.



**Speicher**:
*   {{site.data.keyword.Bluemix_notm}}-Dateispeicher, -Blockspeicher und -Cloudobjektspeicher werden unterstützt. Portworx-SDS (Software-Defined Storage - softwaredefinierter Speicher) wird nicht unterstützt. 
*   Aufgrund der Art und Weise, wie der {{site.data.keyword.Bluemix_notm}}-NFS-Dateispeicher Linux-Benutzerberechtigungen konfiguriert, treten möglicherweise Fehler auf, wenn Sie Dateispeicher verwenden. Wenn dies der Fall ist, müssen Sie unter Umständen [OpenShift-Sicherheitskontextbeschränkungen (SCC - Security Context Contraints) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_scc.html) konfigurieren oder einen anderen Speichertyp verwenden.

**Netzbetrieb**:
*   Calico wird anstelle von OpenShift-SDN (Software-Defined Networking) als Provider für Netzbetriebsrichtlinien verwendet.

**Add-ons, Integrationen und andere Services**:
*   {{site.data.keyword.containerlong_notm}}-Add-ons wie Istio, Knative und das Kubernetes-Terminal sind nicht verfügbar. 
*   Helm-Diagramme sind für die Verwendung in OpenShift-Clustern mit Ausnahme von {{site.data.keyword.Bluemix_notm}} Object Storage nicht zertiziert.
*   Cluster werden für {{site.data.keyword.registryshort_notm}}-`icr.io`-Domänen nicht mit geheimen Schlüsseln zum Extrahieren von Images bereitgestellt. Sie können [Ihre eigenen geheimen Schlüssel zum Extrahieren von Images erstellen](/docs/containers?topic=containers-images#other_registry_accounts) oder stattdessen die integrierte Docker-Registry für OpenShift-Cluster verwenden. 

**Apps**:
*   OpenShift konfiguriert standardmäßig strengere Sicherheitseinstellungen als natives Kubernetes. Weitere Informationen finden Sie in der OpenShift-Dokumentation zum [Verwalten von Sicherheitskontexteinschränkungen (SCC) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_scc.html).
*   Apps, die für die Ausführung als Root konfiguriert sind, können beispielsweise fehlschlagen, wobei die Pods den Status `CrashLoopBackOff` aufweisen. Zur Behebung dieses Problems können Sie die Standardsicherheitskontexteinschränkungen ändern oder ein Image verwenden, das nicht als Root ausgeführt wird. 
*   OpenShift wird standardmäßig mit einer lokalen Docker-Registry konfiguriert. Wenn Sie Images verwenden möchten, die in Ihren fernen privaten {{site.data.keyword.registrylong_notm}}-`icr.io`-Domänennamen gespeichert sind, müssen Sie die geheimen Schlüssel für die einzelnen globalen und regionalen Registrys selbst erstellen. Sie können die [geheimen `default-<region>-icr-io`-Schlüssel](/docs/containers?topic=containers-images#copy_imagePullSecret) aus dem Standardnamensbereich (`default`) in den Namensbereich kopieren, aus dem Sie Images extrahieren möchten, oder Sie können einen [eigenen geheimen Schlüssel erstellen](/docs/containers?topic=containers-images#other_registry_accounts). [Fügen Sie den geheimen Schlüssel zum Extrahieren von Images](/docs/containers?topic=containers-images#use_imagePullSecret) dann Ihrer Bereitstellungskonfiguration oder Ihrem Namensbereichsservicekonto hinzu. 
*   Die OpenShift-Konsole wird anstelle des Kubernetes-Dashboards verwendet.

<br />


## Womit möchten Sie fortfahren?
{: #openshift_next}

Weitere Informationen zum Arbeiten mit Ihren Apps und Routing-Services finden Sie im [OpenShift-Entwicklerhandbuch](https://docs.openshift.com/container-platform/3.11/dev_guide/index.html).

<br />


## Feedback und Fragen
{: #openshift_support}

In der Betaversion werden Red Hat OpenShift on IBM Cloud-Cluster weder vom IBM Support noch vom Red Hat Support abgedeckt. Support, der bereitgestellt wird, soll Sie beim Bewerten des Produkts in Vorbereitung auf seine allgemeine Verfügbar unterstützen.
{: important}

Posten Sie Fragen oder Feedback in Slack. 
*   Wenn Sie ein externer Benutzer sind, posten Sie über den Kanal [#openshift ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com/messages/CKCJLJCH4).  
*   Als IBM Mitarbeiter verwenden Sie den Kanal [#iks-openshift-users ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-argonauts.slack.com/messages/CJH0UPN2D). 

Wenn Sie für Ihr {{site.data.keyword.Bluemix_notm}}-Konto keine IBMid verwenden, [fordern Sie eine Einladung](https://bxcs-slack-invite.mybluemix.net/) zu diesem Slack an.
{: tip}
