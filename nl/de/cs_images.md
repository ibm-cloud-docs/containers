---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Container auf Grundlage von Images erstellen
{: #images}

Ein Docker-Image bildet die Grundlage für die Erstellung eines jeden Containers. Ein Image wird auf der Grundlage einer Dockerfile erstellt. Hierbei handelt es sich um eine Datei, die Anweisungen zum Erstellen des Image enthält. Eine Dockerfile referenziert möglicherweise in ihren Anweisungen Buildartefakte, die separat gespeichert sind, z. B. eine App, die Konfiguration der App und ihre Abhängigkeiten.
{:shortdesc}


## Image-Registrys planen
{: #planning}

Images werden in der Regel in einer Registry gespeichert, auf die der Zugriff entweder öffentlich (extern) möglich ist (öffentliche Registry) oder aber so eingerichtet ist, dass der Zugriff auf eine kleine Gruppe von Benutzern beschränkt ist (private Registry). Öffentliche Registrys wie Docker Hub sind gut dafür geeignet, sich mit Docker und Kubernetes vertraut zu machen und die erste containerisierte App in einem Cluster zu erstellen. Was Unternehmensanwendungen betrifft, so sollten Sie jedoch eine private Registry (wie z. B. die von {{site.data.keyword.registryshort_notm}} bereitgestellte Registry) verwenden,
um zu verhindern, dass Ihre Images durch nicht berechtigte Benutzer verwendet oder unbefugt Änderungen an ihnen vorgenommen werden. Private Registrys müssen vom Clusteradministrator eingerichtet werden, damit sichergestellt ist, dass die Berechtigungsnachweise für den Zugriff auf die private Registry den Clusterbenutzern zur Verfügung stehen.
{:shortdesc}

Für die Bereitstellung Ihrer Apps im Cluster können Sie mehrere Registrys mit {{site.data.keyword.containershort_notm}} verwenden.

|Registry|Beschreibung|Vorteil|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry/index.html)|Mit dieser Option können Sie Ihr eigenes geschütztes Docker-Image-Repository in {{site.data.keyword.registryshort_notm}} einrichten, in dem Sie Images sicher speichern und gemeinsam mit den Clusterbenutzern nutzen können.|<ul><li>Ermöglicht die Verwaltung des Zugriffs auf Images in Ihrem Konto.</li><li>Ermöglicht die Verwendung der von {{site.data.keyword.IBM_notm}} bereitgestellten Images und Beispielapps wie zum Beispiel {{site.data.keyword.IBM_notm}} Liberty als übergeordnetes Image, zu dem eigener App-Code hinzugefügt werden kann.</li><li>Automatisches Scannen der Images durch Vulnerability Advisor auf potenzielle Sicherheitslücken und Bereitstellung betriebssystemspezifischer Empfehlungen, um diese zu schließen.</li></ul>|
|Beliebige andere private Registry|Ermöglicht die Verbindung einer beliebigen vorhandenen privaten Registry mit Ihrem Cluster durch Erstellung eines geheimen Schlüssels vom Typ [imagePullSecret ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/containers/images/). Dieser dient dazu, die URL zur Ihrer Registry und die Berechtigungsnachweise sicher in einem geheimen Kubernetes-Schlüssel zu speichern.|<ul><li>Ermöglicht die Verwendung vorhandener privater Registrys unabhängig von ihrer jeweiligen Quelle (Docker Hub, organisationseigene Registrys oder andere private Cloud-Registrys).</li></ul>|
|Öffentliche Docker Hub-Registry|Verwenden Sie diese Option, um vorhandene öffentliche Images von Docker Hub direkt zu verwenden, wenn keine Dockerfile-Änderungen erforderlich sind. <p>**Hinweis:** Berücksichtigen Sie, dass diese Option möglicherweise den Sicherheitsanforderungen Ihrer Organisation (wie beispielsweise bei der Zugriffsverwaltung, der Ermittlung von Sicherheitslücken oder der Vertraulichkeit von App-Daten) nicht entspricht.</p>|<ul><li>Für Ihren Cluster ist keine zusätzliche Konfiguration erforderlich.</li><li>Enthält eine Vielzahl von Open-Source-Anwendungen.</li></ul>|
{: caption="Tabelle. Optionen für öffentliche und für private Image-Registrys" caption-side="top"}

Nachdem Sie eine Image-Registry eingerichtet haben, können Benutzer diese Images zur Bereitstellung ihrer Apps im Cluster verwenden.


<br />



## Zugriff auf einen Namensbereich in {{site.data.keyword.registryshort_notm}}
{: #namespace}

Sie können Container aus einem von IBM bereitgestellten öffentlichen Image oder einem privaten Image, das in Ihrem Namensbereich in {{site.data.keyword.registryshort_notm}} gespeichert ist, in Ihrem Cluster bereitstellen.
{:shortdesc}

Vorbemerkungen:

1. [Richten Sie einen Namensbereich in {{site.data.keyword.registryshort_notm}} unter {{site.data.keyword.Bluemix_notm}} Public oder {{site.data.keyword.Bluemix_dedicated_notm}} ein und übertragen Sie Images per Push-Operation an diesen Namensbereich](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Erstellen Sie einen Cluster](cs_clusters.html#clusters_cli).
3. [Richten Sie Ihre CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

Wenn Sie einen Cluster erstellen, werden automatisch auch nicht ablaufende Registry-Tokens und geheime Schlüssel für die [nächstgelegene regionale Registry sowie die internationale Registry](/docs/services/Registry/registry_overview.html#registry_regions) erstellt. Die internationale Registry dient der sicheren Speicherung öffentlicher, von IBM bereitgestellter Images, auf die Sie in allen Ihren Bereitstellungen verweisen können, sodass es nicht notwendig ist, unterschiedliche Verweise für Images zu verwenden, die in den einzelnen regionalen Registrys gespeichert sind. Die regionale Registry dient der sicheren Speicherung Ihrer eigenen privaten Docker-Images sowie derselben öffentlichen Images, die in der internationalen Registry gespeichert sind. Mithilfe der Tokens wird Lesezugriff auf alle Namensbereiche autorisiert, die Sie in {{site.data.keyword.registryshort_notm}} einrichten, sodass Sie mit diesen öffentlichen Images (in der internationalen Registry) und privaten Images (in den regionalen Registrys) arbeiten können.

Jedes Token muss in einem `imagePullSecret` von Kubernetes gespeichert sein, damit ein Kubernetes-Cluster darauf zugreifen kann, wenn Sie eine containerisierte App bereitstellen. Bei der Erstellung Ihres Clusters werden die Tokens für die internationale Registry (mit den von IBM bereitgestellten öffentliche Images) und die regionalen Registrys von {{site.data.keyword.containershort_notm}} automatisch in geheimen Schlüsseln für Image-Pulloperationen (imagePullSecrets) in Kubernetes gespeichert. Diese geheimen Schlüssel für Image-Pulloperationen werden dem `standardmäßigen` Kubernetes-Namensbereich (default), der Standardliste mit geheimen Schlüsseln im Servicekonto (`ServiceAccount`) für diesen Namensbereich und dem Namensbereich `kube-system` hinzugefügt.

**Hinweis:** Bei dieser anfänglichen Konfiguration können Sie Container aus allen Images, die in einem Namensbereich in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verfügbar sind, im **Standardnamensbereich** Ihres Clusters bereitstellen. Wenn Sie einen Container in anderen Namespaces Ihres Clusters bereitstellen möchten oder wenn Sie ein Image verwenden möchten, das in einer {{site.data.keyword.Bluemix_notm}}-Region oder in einem anderen {{site.data.keyword.Bluemix_notm}}-Konto gespeichert ist, müssen Sie [Ihr eigenes 'imagePullSecret' für Ihren Cluster erstellen](#other).

Um einen Container im Standardnamensbereich (**default**) Ihres Clusters bereitzustellen, müssen Sie eine Konfigurationsdatei erstellen.

1.  Erstellen Sie eine Bereitstellungskonfigurationsdatei mit dem Namen `mydeployment.yaml`.
2.  Definieren Sie die Bereitstellung und das Image aus Ihrem Namensbereich, das Sie verwenden möchten, in {{site.data.keyword.registryshort_notm}}.

    Gehen Sie wie folgt vor,
um ein privates Image aus einem Namensbereich in {{site.data.keyword.registryshort_notm}} zu verwenden:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namensbereich>/<mein_image>:<tag>
    ```
    {: codeblock}

    **Tipp:** Führen Sie `bx cr namespace-list` aus, um Ihre Namensbereichsinformationen abzurufen.

3.  Erstellen Sie die Bereitstellung in Ihrem Cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Tipp:** Sie können auch eine vorhandene Konfigurationsdatei bereitstellen, z. B. eines der von IBM bereitgestellten öffentlichen Images. In diesem Beispiel wird das Image **ibmliberty** in der Region 'Vereinigte Staaten (Süden)' verwendet.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}


<br />



## Zugriff auf Images in anderen Kubernetes-Namensbereichen, {{site.data.keyword.Bluemix_notm}}-Regionen und -Konten
{: #other}

Sie können Container in anderen Kubernetes-Namensbereichen bereitstellen oder Images verwenden, die in anderen {{site.data.keyword.Bluemix_notm}}-Regionen oder -Konten gespeichert sind, oder Images, die in {{site.data.keyword.Bluemix_dedicated_notm}} gespeichert sind, indem Sie Ihr eigenes 'imagePullSecret' erstellen.
{:shortdesc}

Vorbemerkungen:

1.  [Richten Sie einen Namensbereich in {{site.data.keyword.registryshort_notm}} unter {{site.data.keyword.Bluemix_notm}} Public oder {{site.data.keyword.Bluemix_dedicated_notm}} ein und übertragen Sie Images per Push-Operation an diesen Namensbereich](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Erstellen Sie einen Cluster](cs_clusters.html#clusters_cli).
3.  [Richten Sie Ihre CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

Gehen Sie wie folgt vor, um Ihr eigenes 'imagePullSecret' zu erstellen.

**Hinweis:** 'ImagePullSecrets' sind nur für die Namensbereiche gültig, für die sie erstellt wurden. Wiederholen Sie diese Schritte für jeden Namensbereich, in dem Sie Container bereitstellen möchten. Für Images aus [DockerHub](#dockerhub) ist 'ImagePullSecrets' nicht erforderlich.

1.  Falls Sie kein Token haben, [erstellen Sie ein Token für die Registry, auf die Sie zugreifen möchten.](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  Listen Sie die Tokens in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto auf.

    ```
    bx cr token-list
    ```
    {: pre}

3.  Notieren Sie sich die Token-ID, die Sie verwenden möchten.
4.  Rufen Sie den Wert für Ihr Token ab. Ersetzen Sie <em>&lt;token-id&gt;</em>
durch die ID des Tokens, das Sie im vorherigen Schritt abgerufen haben.

    ```
    bx cr token-get <token-id>
    ```
    {: pre}

    Ihr Tokenwert wird im Feld **Token** Ihrer CLI-Ausgabe angezeigt.

5.  Erstellen Sie den geheimen Kubernetes-Schlüssel, um Ihre Tokeninformationen zu speichern.

    ```
    kubectl --namespace <kubernetes-namensbereich> create secret docker-registry <name_des_geheimen_schlüssels>  --docker-server=<registry-url> --docker-username=token --docker-password=<tokenwert> --docker-email=<docker-e-mail>
    ```
    {: pre}

    <table>
    <caption>Tabelle. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes-namensbereich&gt;</em></code></td>
    <td>Erforderlich. Der Kubernetes-Namensbereich Ihres Clusters, in dem Sie den geheimen Schlüssel verwenden und Container bereitstellen möchten. Führen Sie <code>kubectl get namespaces</code>, um alle Namensbereiche in Ihrem Cluster aufzulisten.</td>
    </tr>
    <tr>
    <td><code><em>&lt;name_des_geheimen_schlüssels&gt;</em></code></td>
    <td>Erforderlich. Der Name, den Sie für Ihren geheimen Schlüssel für Image-Pulloperationen (imagePullSecret) verwenden wollen.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry-url&gt;</em></code></td>
    <td>Erforderlich. Die URL der Image-Registry, in der Ihr Namensbereich eingerichtet ist.<ul><li>Für Namensbereiche, die in den Regionen 'Vereinigte Staaten (Süden)' und 'Vereinigte Staaten (Osten)' eingerichtet sind: registry.ng.bluemix.net</li><li>Für Namensbereiche, die in der Region 'Großbritannien (Süden)' eingerichtet sind: registry.eu-gb.bluemix.net</li><li>Für Namensbereiche, die in der Region 'Zentraleuropa (Frankfurt)' eingerichtet sind: registry.eu-de.bluemix.net</li><li>Für Namensbereiche, die in der Region 'Australien (Sydney)' eingerichtet sind: registry.au-syd.bluemix.net</li><li>Für Namensbereiche, die in {{site.data.keyword.Bluemix_dedicated_notm}} eingerichtet sind: registry.<em>&lt;dedizierte_domäne&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker-benutzername&gt;</em></code></td>
    <td>Erforderlich. Der Benutzername für die Anmeldung bei Ihrer privaten Registry. Für {{site.data.keyword.registryshort_notm}} wurde als Benutzername <code>token</code> festgelegt.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;tokenwert&gt;</em></code></td>
    <td>Erforderlich. Der Wert des zuvor abgerufenen Registry-Tokens.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-e-mail&gt;</em></code></td>
    <td>Erforderlich. Falls Sie über eine Docker-E-Mail-Adresse verfügen, geben Sie diese ein. Ist dies nicht der Fall, geben Sie eine fiktive E-Mail-Adresse ein, z. B. a@b.c. Die Angabe der E-Mail-Adresse ist obligatorisch, um einen geheimen Kubernetes-Schlüssel zu erstellen, wird aber nach der Erstellung nicht weiter genutzt.</td>
    </tr>
    </tbody></table>

6.  Überprüfen Sie, dass der geheime Schlüssel erfolgreich erstellt wurde. Ersetzen Sie
<em>&lt;kubernetes-namensbereich&gt;</em> durch den Namen des Namensbereichs, in dem Sie das
'imagePullSecret' erstellt haben.

    ```
    kubectl get secrets --namespace <kubernetes-namensbereich>
    ```
    {: pre}

7.  Erstellen Sie einen Pod, der das 'imagePullSecret' referenziert.
    1.  Erstellen Sie eine Podkonfigurationsdatei mit dem Namen `mypod.yaml`.
    2.  Definieren Sie den Pod und das 'imagePullSecret', das Sie für den Zugriff auf die private
{{site.data.keyword.Bluemix_notm}}-Registry verwenden möchten.

        Ein privates Image aus einem Namensbereich:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <podname>
        spec:
          containers:
            - name: <containername>
              image: registry.<region>.bluemix.net/<mein_namensbereich>/<mein_image>:<tag>
          imagePullSecrets:
            - name: <name_des_geheimen_schlüssels>
        ```
        {: codeblock}

        Ein öffentliches {{site.data.keyword.Bluemix_notm}}-Image:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <podname>
        spec:
          containers:
            - name: <containername>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <name_des_geheimen_schlüssels>
        ```
        {: codeblock}

        <table>
        <caption>Tabelle. Erklärung der Komponenten der YAML-Datei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;containername&gt;</em></code></td>
        <td>Der Name des Containers, den Sie in Ihrem Cluster bereitstellen möchten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;mein_namensbereich&gt;</em></code></td>
        <td>Der Namensbereich, in dem das Image gespeichert ist. Führen Sie den Befehl `bx cr namespace-list` aus, um die verfügbaren Namensbereiche aufzulisten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;mein_image&gt;</em></code></td>
        <td>Der Name des Images, das Sie verwenden möchten. Führen Sie den Befehl `bx cr image-list` aus, um die verfügbaren Images in einem {{site.data.keyword.Bluemix_notm}} aufzulisten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>Die Version des Images, das Sie verwenden möchten. Ist kein Tag angegeben, wird standardmäßig das Image mit dem Tag <strong>latest</strong> verwendet.</td>
        </tr>
        <tr>
        <td><code><em>&lt;name_des_geheimen_schlüssels&gt;</em></code></td>
        <td>Der Name des 'imagePullSecret', das Sie zuvor erstellt haben.</td>
        </tr>
        </tbody></table>

   3.  Speichern Sie Ihre Änderungen.
   4.  Erstellen Sie die Bereitstellung in Ihrem Cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


<br />



## Zugriff auf öffentliche Images in Docker Hub
{: #dockerhub}

Sie können jedes beliebige öffentliche Image verwenden, das in Docker Hub gespeichert ist, um ohne zusätzliche Konfigurationsschritte einen Container in Ihrem Cluster bereitzustellen.
{:shortdesc}

Vorbemerkungen:

1.  [Erstellen Sie einen Cluster](cs_clusters.html#clusters_cli).
2.  [Richten Sie Ihre CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

Erstellen Sie eine Bereitstellungskonfigurationsdatei.

1.  Erstellen Sie eine Konfigurationsdatei mit dem Namen `mydeployment.yaml`.
2.  Definieren Sie die Bereitstellung und das gewünschte öffentliche Image aus Docker Hub. Die folgende Konfigurationsdatei verwendet das öffentliche NGINX-Image, das in Docker Hub verfügbar ist.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  Erstellen Sie die Bereitstellung in Ihrem Cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Tipp:** Stellen Sie alternativ eine vorhandene Konfigurationsdatei bereit. Im folgenden Beispiel wird dasselbe öffentliche NGINX-Image verwendet, aber direkt auf Ihren Cluster angewendet.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}

<br />



## Zugriff auf Images in anderen privaten Registrys
{: #private_images}

Wenn bereits eine private Registry vorhanden ist und Sie diese verwenden wollen, müssen Sie die Berechtigungsnachweise für die Registry in einem 'imagePullSecret' von Kubernetes
speichern und diesen geheimen Schlüssel in Ihrer Konfigurationsdatei referenzieren.
{:shortdesc}

Vorbemerkungen:

1.  [Erstellen Sie einen Cluster](cs_clusters.html#clusters_cli).
2.  [Richten Sie Ihre CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

Gehen Sie wie folgt vor, um ein 'imagePullSecret' zu erstellen:

**Hinweis:** 'ImagePullSecrets' sind für die Namensbereiche gültig, für die sie erstellt wurden. Wiederholen Sie diese Schritte für jeden Namensbereich, in dem Sie Container aus einem Image in einer privaten {{site.data.keyword.Bluemix_notm}}-Registry bereitstellen möchten.

1.  Erstellen Sie den geheimen Kubernetes-Schlüssel, um Ihre Berechtigungsnachweise für die private Registry zu speichern.

    ```
    kubectl --namespace <kubernetes-namensbereich> create secret docker-registry <name_des_geheimen_schlüssels>  --docker-server=<registry-url> --docker-username=<docker-benutzername> --docker-password=<docker-kennwort> --docker-email=<docker-e-mail>
    ```
    {: pre}

    <table>
    <caption>Tabelle. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes-namensbereich&gt;</em></code></td>
    <td>Erforderlich. Der Kubernetes-Namensbereich Ihres Clusters, in dem Sie den geheimen Schlüssel verwenden und Container bereitstellen möchten. Führen Sie <code>kubectl get namespaces</code>, um alle Namensbereiche in Ihrem Cluster aufzulisten.</td>
    </tr>
    <tr>
    <td><code><em>&lt;name_des_geheimen_schlüssels&gt;</em></code></td>
    <td>Erforderlich. Der Name, den Sie für Ihren geheimen Schlüssel für Image-Pulloperationen (imagePullSecret) verwenden wollen.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry-url&gt;</em></code></td>
    <td>Erforderlich. Die URL der Registry, in der Ihre privaten Images gespeichert sind.</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker-benutzername&gt;</em></code></td>
    <td>Erforderlich. Der Benutzername für die Anmeldung bei Ihrer privaten Registry.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;tokenwert&gt;</em></code></td>
    <td>Erforderlich. Der Wert des zuvor abgerufenen Registry-Tokens.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-e-mail&gt;</em></code></td>
    <td>Erforderlich. Falls Sie über eine Docker-E-Mail-Adresse verfügen, geben Sie diese ein. Ist dies nicht der Fall, geben Sie eine fiktive E-Mail-Adresse ein, z. B. a@b.c. Die Angabe der E-Mail-Adresse ist obligatorisch, um einen geheimen Kubernetes-Schlüssel zu erstellen, wird aber nach der Erstellung nicht weiter genutzt.</td>
    </tr>
    </tbody></table>

2.  Überprüfen Sie, dass der geheime Schlüssel erfolgreich erstellt wurde. Ersetzen Sie
<em>&lt;kubernetes-namensbereich&gt;</em> durch den Namen des Namensbereichs, in dem Sie das
'imagePullSecret' erstellt haben.

    ```
    kubectl get secrets --namespace <kubernetes-namensbereich>
    ```
    {: pre}

3.  Erstellen Sie einen Pod, der das 'imagePullSecret' referenziert.
    1.  Erstellen Sie eine Podkonfigurationsdatei mit dem Namen `mypod.yaml`.
    2.  Definieren Sie den Pod und das 'imagePullSecret', das Sie für den Zugriff auf die private
{{site.data.keyword.Bluemix_notm}}-Registry verwenden möchten. Gehen Sie wie folgt vor, um ein privates Image aus Ihrer privaten Registry zu verwenden:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <podname>
        spec:
          containers:
            - name: <containername>
              image: <mein_image>:<tag>
          imagePullSecrets:
            - name: <name_des_geheimen_schlüssels>
        ```
        {: codeblock}

        <table>
        <caption>Tabelle. Erklärung der Komponenten der YAML-Datei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;podname&gt;</em></code></td>
        <td>Der Name des Pod, den Sie erstellen möchten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;containername&gt;</em></code></td>
        <td>Der Name des Containers, den Sie in Ihrem Cluster bereitstellen möchten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;mein_image&gt;</em></code></td>
        <td>Der vollständige Pfad des gewünschten Images in Ihrer privaten Registry.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>Die Version des Images, das Sie verwenden möchten. Ist kein Tag angegeben, wird standardmäßig das Image mit dem Tag <strong>latest</strong> verwendet.</td>
        </tr>
        <tr>
        <td><code><em>&lt;name_des_geheimen_schlüssels&gt;</em></code></td>
        <td>Der Name des 'imagePullSecret', das Sie zuvor erstellt haben.</td>
        </tr>
        </tbody></table>

  3.  Speichern Sie Ihre Änderungen.
  4.  Erstellen Sie die Bereitstellung in Ihrem Cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}

