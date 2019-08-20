---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

subcollection: containers

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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Fehlerbehebung für Clusterspeicher
{: #cs_troubleshoot_storage}

Ziehen Sie bei der Verwendung von {{site.data.keyword.containerlong}} die folgenden Verfahren für die Fehlerbehebung für Clusterspeicher in Betracht.
{: shortdesc}

Wenn Sie ein allgemeineres Problem haben, testen Sie das [Cluster-Debugging](/docs/containers?topic=containers-cs_troubleshoot).
{: tip}


## Fehler bei persistentem Speicher debuggen
{: #debug_storage}

Informieren Sie sich über die Optionen, die Ihnen für die Fehlerbehebung beim persistenten Speicher und zum Eingrenzen der jeweiligen Fehlerquelle zur Verfügung stehen.
{: shortdesc}

1. Überprüfen Sie, ob Sie die neueste Version des {{site.data.keyword.cloud_notm}}- und {{site.data.keyword.containerlong_notm}}-Plug-ins verwenden.
   ```
   ibmcloud update
   ```
   {: pre}

   ```
   ibmcloud plugin repo-plugins
   ```
   {: pre}

2. Stellen Sie sicher, dass die Version der `kubectl`-CLI, die Sie auf Ihrer lokalen Maschine ausführen, mit der Kubernetes-Version übereinstimmt, die in Ihrem Cluster installiert ist.
   1. Zeigen Sie die Version der `kubectl`-CLI an, die in Ihrem Cluster und auf Ihrer lokalen Maschine installiert ist.
      ```
      kubectl version
      ```
      {: pre}

      Beispielausgabe:
      ```
      Client Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.5", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:53:57Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"darwin/amd64"}
      Server Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.5+IKS", GitCommit:"e15454c2216a73b59e9a059fd2def4e6712a7cf0", GitTreeState:"clean", BuildDate:"2019-04-01T10:08:07Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
      ```
      {: screen}

      Die CLI-Versionen stimmen überein, wenn in `GitVersion` für den Client und den Server dieselbe Version angezeigt wird. Sie können den `+IKS`-Teil der Version für den Server ignorieren.
   2. Wenn die `kubectl`-CLI-Versionen auf Ihrer lokalen Maschine und in Ihrem Cluster nicht übereinstimmen, [aktualisieren Sie Ihren Cluster](/docs/containers?topic=containers-update) oder [installieren Sie auf der lokalen Maschine eine andere CLI-Version](/docs/containers?topic=containers-cs_cli_install#kubectl).

3. Nur für Blockspeicher, Objektspeicher und Portworx: Stellen Sie sicher, dass Sie [den Helm-Server-Tiller mit einem Kubernetes Service-Konto installiert haben](/docs/containers?topic=containers-helm#public_helm_install).

4. Nur für Blockspeicher, Objektspeicher und Portworx: Stellen Sie sicher, dass Sie die neueste Helm-Diagrammversion für das Plug-in installiert haben.

   **Block- und Objektspeicher**:

   1. Aktualisieren Sie Ihre Helm-Diagrammrepositorys.
      ```
      helm repo update
      ```
      {: pre}

   2. Listen Sie die Helm-Diagramme im Repository `iks-charts` auf.
      ```
      helm search iks-charts
      ```
      {: pre}

      Beispielausgabe:
      ```
      iks-charts/ibm-block-storage-attacher          	1.0.2        A Helm chart for installing ibmcloud block storage attach...
      iks-charts/ibm-iks-cluster-autoscaler          	1.0.5        A Helm chart for installing the IBM Cloud cluster autoscaler
      iks-charts/ibm-object-storage-plugin           	1.0.6        A Helm chart for installing ibmcloud object storage plugin  
      iks-charts/ibm-worker-recovery                 	1.10.46      IBM Autorecovery system allows automatic recovery of unhe...
      ...
      ```
      {: screen}

   3. Listen Sie die installierten Helm-Diagramme in Ihrem Cluster auf und vergleichen Sie die Version, die Sie installiert haben, mit der Version, die verfügbar ist.
      ```
      helm ls
      ```
      {: pre}

   4. Wenn eine neuere Version verfügbar ist, installieren Sie diese Version. Anweisungen finden Sie unter [{{site.data.keyword.cloud_notm}} Block Storage-Plug-in aktualisieren](/docs/containers?topic=containers-block_storage#updating-the-ibm-cloud-block-storage-plug-in) und [{{site.data.keyword.cos_full_notm}}-Plug-in aktualisieren](/docs/containers?topic=containers-object_storage#update_cos_plugin).

   **Portworx**:

   1. Suchen Sie die [neueste Helm-Diagrammversion ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/portworx/helm/tree/master/charts/portworx), die verfügbar ist.

   2. Listen Sie die installierten Helm-Diagramme in Ihrem Cluster auf und vergleichen Sie die Version, die Sie installiert haben, mit der Version, die verfügbar ist.
      ```
      helm ls
      ```
      {: pre}

   3. Wenn eine neuere Version verfügbar ist, installieren Sie diese Version. Anweisungen finden Sie unter [Portworx in Ihrem Cluster aktualisieren](/docs/containers?topic=containers-portworx#update_portworx).

5. Stellen Sie sicher, dass der Speichertreiber und die Plug-in-Pods den Status **Aktiv** (Running) aufweisen.
   1. Listen Sie die Pods im Namensbereich `kube-system` auf.
      ```
      kubectl get pods -n kube-system
      ```
      {: pre}

   2. Wenn die Pods nicht den Status **Aktiv** (Running) aufweisen, rufen Sie weitere Details zum Pod ab, um die Ursache herauszufinden. Abhängig vom Status Ihres Pods sind Sie möglicherweise nicht in der Lage, alle der folgenden Befehle auszuführen.
      ```
      kubectl describe pod <podname> -n kube-system
      ```
      {: pre}

      ```
      kubectl logs <podname> -n kube-system
      ```
      {: pre}

   3. Analysieren Sie den Ereignisabschnitt (**Events**) der CLI-Ausgabe des Befehls `kubectl describe pod` und die aktuellen Protokolle, um die eigentliche Ursache für den Fehler herauszufinden.

6. Überprüfen Sie, ob Ihr PVC erfolgreich bereitgestellt wurde.
   1. Überprüfen Sie den Status Ihres PVC. Ein PVC wurde erfolgreich bereitgestellt, wenn er den Status **Bound** (Gebunden) anzeigt.
      ```
      kubectl get pvc
      ```
      {: pre}

   2. Wenn als Status des PVC **Pending** (Anstehend) angezeigt wird, rufen Sie den Fehler ab, aufgrund dessen der PVC in diesem Status bleibt.
      ```
      kubectl describe pvc <pvc-name>
      ```
      {: pre}

   3. Überprüfen Sie allgemeine Fehler, die während der PVC-Erstellung auftreten können.
      - [Dateispeicher und Blockspeicher: PVC bleibt im Wartestatus (Pending).](#file_pvc_pending)
      - [Objektspeicher: PVC bleibt im Wartestatus (Pending).](#cos_pvc_pending)

7. Überprüfen Sie, ob der Pod, der Ihre Speicherinstanz anhängt, erfolgreich bereitgestellt wurde.
   1. Listen Sie die Pods in Ihrem Cluster auf. Ein Pod wurde erfolgreich bereitgestellt, wenn er den Status **Running** (Aktiv) anzeigt.
      ```
      kubectl get pods
      ```
      {: pre}

   2. Rufen Sie die Details für Ihren Pod ab und prüfen Sie, ob im Ereignisabschnitt (**Events**) Ihrer CLI-Ausgabe Fehler angezeigt werden.
      ```
      kubectl describe pod <podname>
      ```
      {: pre}

   3. Rufen Sie die Protokolle für Ihre App ab und prüfen Sie, ob Sie Fehlernachrichten finden.
      ```
      kubectl logs <podname>
      ```
      {: pre}

   4. Überprüfen Sie allgemeine Fehler, die auftreten können, wenn Sie einen PVC an Ihre App anhängen.
      - [Dateispeicher: App kann nicht auf PVC zugreifen oder in PVC schreiben](#file_app_failures)
      - [Blockspeicher: App kann nicht auf PVC zugreifen oder in PVC schreiben](#block_app_failures)
      - [Objektspeicher: Zugriff auf Dateien mit einem Benutzer ohne Rootberechtigung schlägt fehl](#cos_nonroot_access)


## Dateispeicher und Blockspeicher: PVC bleibt im Wartestatus (Pending)
{: #file_pvc_pending}

{: tsSymptoms}
Wenn Sie einen PVC erstellen und den Befehl `kubectl get pvc <pvc-name>` ausführen, bleibt Ihr PVC im Zustand **Pending** (Anstehend), selbst wenn Sie einige Zeit warten.

{: tsCauses}
Während der PVC-Erstellung und -Bindung werden vom File Storage- und Block Storage-Plug-in viele verschiedene Tasks ausgeführt. Jede Task kann fehlschlagen und eine andere Fehlernachricht auslösen.

{: tsResolve}

1. Suchen Sie nach der Ursache dafür, dass der PVC im Zustand **Pending** (Anstehend) bleibt.
   ```
   kubectl describe pvc <pvc-name> -n <namensbereich>
   ```
   {: pre}

2. Prüfen Sie die Beschreibungen allgemeiner Nachrichten und die Hinweise zur Fehlerbehebung.

   <table>
   <thead>
     <th>Fehlernachricht</th>
     <th>Beschreibung</th>
     <th>Schritte zur Behebung</th>
  </thead>
  <tbody>
    <tr>
      <td><code>User doesn't have permissions to create or manage Storage</code></br></br><code>Failed to find any valid softlayer credentials in configuration file</code></br></br><code>Storage with the order ID %d could not be created after retrying for %d seconds.</code></br></br><code>Unable to locate datacenter with name <rechenzentrumsname>.</code></td>
      <td>Der IAM-API-Schlüssel oder der API-Schlüssel der IBM Cloud-Infrastruktur, der im geheimen Kubernetes-Schlüssel `storage-secret-store` Ihres Clusters gespeichert ist, verfügt nicht über die erforderlichen Berechtigungen zum Bereitstellen von persistentem Speicher. </td>
      <td>Siehe [PVC-Erstellung schlägt aufgrund fehlender Berechtigungen fehl](#missing_permissions). </td>
    </tr>
    <tr>
      <td><code>Your order will exceed the maximum number of storage volumes allowed. Please contact Sales</code></td>
      <td>Jedes {{site.data.keyword.cloud_notm}}-Konto wird mit der maximalen Anzahl Speicherinstanzen eingerichtet, die erstellt werden können. Durch die Erstellung des PVC überschreiten Sie die maximale Anzahl von Speicherinstanzen. </td>
      <td>Wenn Sie einen PVC erstellen möchten, wählen Sie eine der folgenden Optionen aus. <ul><li>Entfernen Sie alle nicht verwendeten PVCs.</li><li>Bitten Sie den {{site.data.keyword.cloud_notm}}-Kontoeigner, Ihr Speicherkontingent zu erhöhen, indem Sie [einen Supportfall öffnen](/docs/get-support?topic=get-support-getting-customer-support).</li></ul> </td>
    </tr>
    <tr>
      <td><code>Unable to find the exact ItemPriceIds(type|size|iops) for the specified storage</code> </br></br><code>Failed to place storage order with the storage provider</code></td>
      <td>Die Speichergröße und die E/A-Operationen pro Sekunde (IOPS), die Sie in Ihrem PVC angegeben haben, werden von dem Speichertyp, den Sie ausgewählt haben, nicht unterstützt und können mit der angegebenen Speicherklasse nicht verwendet werden. </td>
      <td>Informationen zu den unterstützten Speichergrößen und IOPS für die Speicherklasse, die Sie verwenden möchten, finden Sie unter [Dateispeicherkonfiguration festlegen](/docs/containers?topic=containers-file_storage#file_predefined_storageclass) und [Blockspeichergröße festlegen](/docs/containers?topic=containers-block_storage#block_predefined_storageclass). Korrigieren Sie die Größe und die IOPS und erstellen Sie den PVC erneut. </td>
    </tr>
    <tr>
  <td><code>Failed to find the datacenter name in configuration file</code></td>
      <td>Das Rechenzentrum, das Sie in Ihrem PVC angegeben haben, ist nicht vorhanden. </td>
  <td>Führen Sie den Befehl <code>ibmcloud ks locations</code> aus, um die verfügbaren Rechenzentren aufzulisten. Korrigieren Sie das Rechenzentrum in Ihrem PVC und erstellen Sie den PVC erneut.</td>
    </tr>
    <tr>
  <td><code>Failed to place storage order with the storage provider</code></br></br><code>Storage with the order ID 12345 could not be created after retrying for xx seconds. </code></br></br><code>Failed to do subnet authorizations for the storage 12345.</code><code>Storage 12345 has ongoing active transactions and could not be completed after retrying for xx seconds.</code></td>
  <td>Die Speichergröße, die IOPS und der Speichertyp sind möglicherweise nicht mit der von Ihnen ausgewählten Speicherklasse kompatibel oder der {{site.data.keyword.cloud_notm}}-Infrastruktur-API-Endpunkt ist momentan nicht verfügbar. </td>
  <td>Informationen zu den unterstützten Speichergrößen und IOPS für die Speicherklasse und den Speichertyp, die/den Sie verwenden möchten, finden Sie unter [Dateispeicherkonfiguration festlegen](/docs/containers?topic=containers-file_storage#file_predefined_storageclass) und [Blockspeichergröße festlegen](/docs/containers?topic=containers-block_storage#block_predefined_storageclass). Löschen Sie dann den PVC und erstellen Sie den PVC erneut. </td>
  </tr>
  <tr>
  <td><code>Failed to find the storage with storage id 12345. </code></td>
  <td>Sie möchten einen PVC für eine vorhandene Speicherinstanz erstellen, indem Sie die statische Kubernetes-Bereitstellung verwenden, aber die Speicherinstanz, die Sie angegeben haben, konnte nicht gefunden werden. </td>
  <td>Befolgen Sie die Anweisungen, um vorhandenen [Dateispeicher](/docs/containers?topic=containers-file_storage#existing_file) oder [Blockspeicher](/docs/containers?topic=containers-block_storage#existing_block) in Ihrem Cluster bereitzustellen, und stellen Sie sicher, dass Sie für Ihre vorhandene Speicherinstanz die richtigen Informationen abrufen. Löschen Sie dann den PVC und erstellen Sie den PVC erneut.  </td>
  </tr>
  <tr>
  <td><code>Storage type not provided, expected storage type is `Endurance` or `Performance`. </code></td>
  <td>Sie haben eine angepasste Speicherklasse erstellt und einen Speichertyp angegeben, der nicht unterstützt wird.</td>
  <td>Aktualisieren Sie Ihre angepasste Speicherklasse, um `Endurance` oder `Performance` als Ihren Speichertyp anzugeben. Beispiele für angepasste Speicherklassen finden Sie in den angepassten Beispielspeicherklassen für [Dateispeicher](/docs/containers?topic=containers-file_storage#file_custom_storageclass) und [Blockspeicher](/docs/containers?topic=containers-block_storage#block_custom_storageclass). </td>
  </tr>
  </tbody>
  </table>

## Dateispeicher: App kann nicht auf PVC zugreifen oder in PVC schreiben
{: #file_app_failures}

Wenn Sie einen PVC an Ihren Pod anhängen, treten beim Zugreifen auf oder Schreiben in den PVC möglicherweise Fehler auf.
{: shortdesc}

1. Listen Sie die Pods in Ihrem Cluster auf und überprüfen Sie den Status des Pods.
   ```
   kubectl get pods
   ```
   {: pre}

2. Suchen Sie nach der Ursache dafür, dass Ihre App nicht auf den PVC zugreifen oder in ihn schreiben kann.
   ```
   kubectl describe pod <podname>
   ```
   {: pre}

   ```
   kubectl logs <podname>
   ```
   {: pre}

3. Überprüfen Sie allgemeine Fehler, die auftreten können, wenn Sie einen PVC an einen Pod anhängen.
   <table>
   <thead>
     <th>Symptom oder Fehlernachricht</th>
     <th>Beschreibung</th>
     <th>Schritte zur Behebung</th>
  </thead>
  <tbody>
    <tr>
      <td>Ihr Pod ist im Zustand <strong>ContainerCreating</strong> blockiert. </br></br><code>MountVolume.SetUp failed for volume ... read-only file system</code></td>
      <td>Das {{site.data.keyword.cloud_notm}}-Infrastruktur-Back-End hat Netzprobleme festgestellt. Zum Schutz Ihrer Daten und zur Vermeidung von Datenverlust hat {{site.data.keyword.cloud_notm}} die Verbindung zum Dateispeicherserver automatisch getrennt, um Schreiboperationen in NFS-Dateifreigaben zu verhindern.  </td>
      <td>Siehe [Dateispeicher: Dateisysteme für Workerknoten werden schreibgeschützt](#readonly_nodes).</td>
      </tr>
      <tr>
  <td><code>write-permission</code> </br></br><code>do not have required permission</code></br></br><code>cannot create directory '/bitnami/mariadb/data': Permission denied </code></td>
  <td>In Ihrer Bereitstellung haben Sie einen Benutzer ohne Rootberechtigung als Eigner des NFS-Dateispeichermountpfads angegeben. Standardmäßig haben Benutzer ohne Rootberechtigung keinen Schreibzugriff auf den Datenträgermountpfad für NFS-gesicherte Speicher. </td>
  <td>Siehe [Dateispeicher: App schlägt fehl, wenn ein Benutzer ohne Rootberechtigung Eigner des NFS-Dateispeicher-Mountpfads ist](#nonroot).</td>
  </tr>
  <tr>
  <td>Nachdem Sie einen Benutzer ohne Rootberechtigung als Eigner des NFS-Dateispeichermountpfads angegeben oder ein Helm-Diagramm unter Angabe einer Benutzer-ID für einen Benutzer ohne Rootberechtigung bereitgestellt haben, kann der Benutzer nicht in den angehängten Speicher schreiben.</td>
  <td>Die Bereitstellungs- oder Helm-Diagrammkonfiguration gibt den Sicherheitskontext für <code>fsGroup</code> (Gruppen-ID) und <code>runAsUser</code> (Benutzer-ID) des Pods an.</td>
  <td>Siehe [Dateispeicher: Hinzufügen von Zugriff für Benutzer ohne Rootberechtigung auf persistente Speicher ist fehlgeschlagen](#cs_storage_nonroot)</td>
  </tr>
</tbody>
</table>

### Dateispeicher: Dateisysteme für Workerknoten werden schreibgeschützt
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Sie bemerken möglicherweise eines der folgenden Symptome:
- Wenn Sie den Befehl `kubectl get pods -o wide` ausführen, dann können Sie erkennen, dass mehrere Pods, die auf demselben Workerknoten ausgeführt werden, im Zustand `ContainerCreating` blockiert sind.
- Wenn Sie den Befehl `kubectl describe` ausführen, sehen Sie den folgenden Fehler im Abschnitt **Ereignisse** `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
Das Dateisystem auf dem Workerknoten ist schreibgeschützt.

{: tsResolve}
1.  Erstellen Sie eine Sicherungskopie aller Daten, die möglicherweise auf dem Workerknoten oder in Ihren Containern gespeichert werden.
2.  Laden Sie den Workerknoten erneut, um eine kurzfristige Programmkorrektur für den vorhandenen Workerknoten zu erreichen.
    <pre class="pre"><code>ibmcloud ks worker-reload --cluster &lt;clustername&gt; --worker &lt;worker-id&gt;</code></pre>

Für eine langfristige Programmkorrektur müssen Sie [den Typ Ihres Worker-Pools aktualisieren](/docs/containers?topic=containers-update#machine_type).

<br />



### Dateispeicher: App schlägt fehl, wenn ein Benutzer ohne Rootberechtigung Eigner des NFS-Dateispeicher-Mountpfads ist
{: #nonroot}

{: tsSymptoms}
Nach dem [Hinzufügen von NFS-Speicher](/docs/containers?topic=containers-file_storage#file_app_volume_mount) zu Ihrer Bereitstellung schlägt die Bereitstellung Ihres Containers fehl. Wenn Sie die Protokolle für Ihren Container abrufen, werden möglicherweise Fehler wie die folgenden angezeigt. Der Pod schlägt fehl und bleibt in einer Neuladeschleife stecken.

```
write-permission
```
{: screen}

```
do not have required permission
```
{: screen}

```
cannot create directory '/bitnami/mariadb/data': Permission denied
```
{: screen}

{: tsCauses}
Standardmäßig haben Benutzer ohne Rootberechtigung keinen Schreibzugriff auf den Datenträgermountpfad für NFS-gesicherte Speicher. Einige allgemeine App-Images, wie z. B. Jenkins und Nexus3, geben einen Benutzer ohne Rootberechtigung an, der Eigner des Mountpfads in der Dockerfile ist. Wenn Sie einen Container aus dieser Dockerfile erstellen, schlägt die Erstellung des Containers aufgrund unzureichender Berechtigungen für den Benutzer ohne Rootberechtigung auf dem Mountpfad fehl. Um Schreibberechtigung zu erteilen, können Sie die Dockerfile so ändern, dass der Benutzer ohne Rootberechtigung temporär zur Stammbenutzergruppe hinzugefügt wird, bevor die Mountpfadberechtigungen geändert werden, oder Sie verwenden einen Init-Container.

Wenn Sie ein Helm-Diagramm verwenden, um das Image bereitzustellen, bearbeiten Sie die Helm-Bereitstellung, um einen Init-Container zu verwenden.
{:tip}



{: tsResolve}
Wenn Sie einen [Init-Container![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) in Ihre Bereitstellung einschließen, können Sie einem Benutzer ohne Rootberechtigung, der in Ihrer Dockerfile angegeben ist, Schreibberechtigungen für den Datenträgermountpfad innerhalb des Containers erteilen. Der Init-Container startet, bevor Ihr App-Container startet. Der Init-Container erstellt den Datenträgermountpfad innerhalb des Containers, ändert den Mountpfad, sodass der richtige Benutzer (ohne Rootberechtigung) Eigner ist, und schließt den Pfad wieder. Anschließend wird Ihr App-Container mit dem Benutzer ohne Rootberechtigung gestartet, der in den Mountpfad schreiben muss. Da der Benutzer ohne Rootberechtigung bereits Eigner des Pfads ist, ist das Schreiben in den Mountpfad erfolgreich. Wenn Sie keinen Init-Container verwenden möchten, können Sie die Dockerfile ändern, um Benutzern ohne Rootberechtigung Zugriff auf den NFS-Dateispeicher hinzuzufügen.


Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Öffnen Sie die Dockerfile für Ihre App und rufen Sie die Benutzer-ID (UID) und die Benutzer-ID (GID) von dem Benutzer ab, dem Sie Schreibzugriff auf den Datenträgermountpfad erteilen möchten. Im Beispiel einer Jenkins-Dockerfile lautet die Information:
    - UID: `1000`
    - GID: `1000`

    **Beispiel**:

    ```
    FROM openjdk:8-jdk

    RUN apt-get update &&apt-get install -y git curl &&rm -rf /var/lib/apt/lists/*

    ARG user=jenkins
    ARG group=jenkins
    ARG uid=1000
    ARG gid=1000
    ARG http_port=8080
    ARG agent_port=50000

    ENV JENKINS_HOME /var/jenkins_home
    ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
    ...
    ```
    {:screen}

2.  Fügen Sie persistenten Speicher zu Ihrer App hinzu, indem Sie einen PVC (Persistent Volume Claim) erstellen. Dieses Beispiel verwendet die Speicherklasse `ibmc-file-bronze`. Um verfügbare Speicherklassen zu überprüfen, führen Sie den folgenden Befehl aus: `kubectl get storageclasses`.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

3.  Erstellen Sie den PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

4.  Fügen Sie in Ihrer `.yaml`-Bereitstellungsdatei den Init-Container hinzu. Beziehen Sie die UID und GID ein, die Sie zuvor abgerufen haben.

    ```
    initContainers:
    - name: initcontainer # Kann durch einen beliebigen Namen ersetzt werden
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # Ersetzen Sie UID und GID durch Werte aus der Dockerfile
      volumeMounts:
      - name: volume # Kann durch einen beliebigen Namen ersetzt werden
        mountPath: /mount # Muss mit dem Mountpfad in der args-Zeile übereinstimmen
    ```
    {: codeblock}

    **Beispiel** für eine Jenkins-Bereitstellung

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my_pod
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: jenkins      
      template:
        metadata:
          labels:
            app: jenkins
        spec:
          containers:
          - name: jenkins
            image: jenkins
            volumeMounts:
            - mountPath: /var/jenkins_home
              name: volume
          volumes:
          - name: volume
            persistentVolumeClaim:
              claimName: mypvc
          initContainers:
          - name: permissionsfix
            image: alpine:latest
            command: ["/bin/sh", "-c"]
            args:
              - chown 1000:1000 /mount;
            volumeMounts:
            - name: volume
              mountPath: /mount
    ```
    {: codeblock}

5.  Erstellen Sie den Pod und hängen Sie den PVC an Ihren Pod an.

    ```
    kubectl apply -f mein_pod.yaml
    ```
    {: pre}

6. Überprüfen Sie, ob der Datenträger erfolgreich an Ihren Pod angehängt wurde. Notieren Sie den Namen des Pod und den **Containers/Mounts**-Pfad.

    ```
    kubectl describe pod <mein_pod>
    ```
    {: pre}

    **Beispielausgabe**:

    ```
    Name:		    mypod-123456789
    Namespace:	default
    ...
    Init Containers:
    ...
    Mounts:
      /mount from volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Containers:
      jenkins:
        Container ID:
        Image:		jenkins
        Image ID:
        Port:		  <none>
        State:		Waiting
          Reason:		PodInitializing
        Ready:		False
        Restart Count:	0
        Environment:	<none>
        Mounts:
          /var/jenkins_home from volume (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (Referenz auf einen PersistentVolumeClaim im gleichen Namensbereich)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

7.  Melden Sie sich beim Pod an, indem Sie den Podnamen verwenden, den Sie zuvor notiert haben.

    ```
    kubectl exec -it <mein_pod-123456789> /bin/bash
    ```
    {: pre}

8. Überprüfen Sie die Berechtigungen des Mountpfads Ihres Containers. In dem Beispiel ist der Mountpfad `/var/jenkins_home`.

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **Beispielausgabe**:

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    Diese Ausgabe zeigt, dass die GID und UID von Ihrer Dockerfile (in diesem Beispiel `1000` und `1000`) Eigner des Mountpfads innerhalb des Containers sind.

<br />


### Dateispeicher: Hinzufügen von Zugriff für Benutzer ohne Rootberechtigung auf persistente Speicher ist fehlgeschlagen
{: #cs_storage_nonroot}

{: tsSymptoms}
Nach dem [Hinzufügen von Zugriff für Benutzer ohne Rootberechtigung auf persistenten Speicher](#nonroot) oder nach dem Bereitstellen eines Helm-Diagramms, in dem ein Benutzer ohne Rootberechtigung angegeben ist, kann der Benutzer nicht in den angehängten Speicher schreiben.

{: tsCauses}
Die Bereitstellungs- oder Helm-Diagrammkonfiguration gibt den [Sicherheitskontext](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) für `fsGroup` (Gruppen-ID) und `runAsUser` (Benutzer-ID) des Pods an. Aktuell unterstützt {{site.data.keyword.containerlong_notm}} die Spezifikation `fsGroup` nicht, sondern nur `runAsUser` mit der Festlegung als `0` (Rootberechtigungen).

{: tsResolve}
Entfernen Sie in der Konfiguration die `securityContext`-Felder für `fsGroup` und `runAsUser` aus dem Image, der Bereitstellungs- oder Helm-Diagrammkonfigurationsdatei und nehmen Sie die Bereitstellung erneut vor. Wenn Sie die Eigentumsrechte des Mountpfads von `nobody` ändern müssen, [fügen Sie Zugriff für Benutzer ohne Rootberechtigung hinzu](#nonroot). Nachdem Sie den [non-root `initContainer`](#nonroot) hinzugefügt haben, legen Sie `runAsUser` auf Containerebene fest, nicht Podebene.

<br />




## Blockspeicher: App kann nicht auf PVC zugreifen oder in PVC schreiben
{: #block_app_failures}

Wenn Sie einen PVC an Ihren Pod anhängen, treten beim Zugreifen auf oder Schreiben in den PVC möglicherweise Fehler auf.
{: shortdesc}

1. Listen Sie die Pods in Ihrem Cluster auf und überprüfen Sie den Status des Pods.
   ```
   kubectl get pods
   ```
   {: pre}

2. Suchen Sie nach der Ursache dafür, dass Ihre App nicht auf den PVC zugreifen oder in ihn schreiben kann.
   ```
   kubectl describe pod <podname>
   ```
   {: pre}

   ```
   kubectl logs <podname>
   ```
   {: pre}

3. Überprüfen Sie allgemeine Fehler, die auftreten können, wenn Sie einen PVC an einen Pod anhängen.
   <table>
   <thead>
     <th>Symptom oder Fehlernachricht</th>
     <th>Beschreibung</th>
     <th>Schritte zur Behebung</th>
  </thead>
  <tbody>
    <tr>
      <td>Ihr Pod ist im Zustand <strong>ContainerCreating</strong> oder <strong>CrashLoopBackOff</strong> blockiert. </br></br><code>MountVolume.SetUp failed for volume ... read-only.</code></td>
      <td>Das {{site.data.keyword.cloud_notm}}-Infrastruktur-Back-End hat Netzprobleme festgestellt. Zum Schutz Ihrer Daten und zur Vermeidungen von Datenverlust hat {{site.data.keyword.cloud_notm}} die Verbindung zum Blockspeicherserver automatisch getrennt, um Schreiboperationen in Blockspeicherinstanzen zu verhindern.  </td>
      <td>Siehe [Blockspeicher: Blockspeicher wird schreibgeschützt](#readonly_block)</td>
      </tr>
      <tr>
  <td><code>failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32</code> </td>
        <td>Sie möchten eine vorhandene Blockspeicherinstanz anhängen, die für ein <code>XFS</code>-Dateisystem konfiguriert wurde. Beim Erstellen des persistenten Datenträgers und des übereinstimmenden PVC haben Sie ein Dateisystem <code>ext4</code> oder kein Dateisystem angegeben. Das Dateisystem, das Sie in Ihrem persistenten Datenträger angeben, muss mit dem Dateisystem übereinstimmen, das in Ihrer Blockspeicherinstanz konfiguriert ist. </td>
  <td>Siehe [Blockspeicher: Das Anhängen eines vorhandenen Blockspeichers an einen Pod schlägt aufgrund des falschen Dateisystems fehl](#block_filesystem)</td>
  </tr>
</tbody>
</table>

### Blockspeicher: Blockspeicher wird schreibgeschützt
{: #readonly_block}

{: tsSymptoms}
Sie bemerken möglicherweise die folgenden Symptome:
- Wenn Sie den Befehl `kubectl get pods -o wide` ausführen, können Sie erkennen, dass mehrere Pods auf demselben Workerknoten  im Zustand `ContainerCreating` oder `CrashLoopBackOff` blockiert sind. Alle diese Pods verwenden dieselbe Blockspeicherinstanz.
- Wenn Sie den Befehl `kubectl describe pod` ausführen, sehen Sie den folgenden Fehler im Abschnitt **Events**: `MountVolume.SetUp failed for volume ... read-only`.

{: tsCauses}
Wenn ein Netzfehler auftritt, während ein Pod auf einen Datenträger schreibt, schützt die IBM Cloud-Infrastruktur die Daten auf dem Datenträger gegen Beschädigung, indem der Datenträger in den Lesezugriffsmodus versetzt wird. Pods, die diesen Datenträger verwenden, können keine Daten mehr auf den Datenträger schreiben und empfangen einen Fehler.

{: tsResolve}
1. Prüfen Sie die Version des {{site.data.keyword.cloud_notm}} Block Storage-Plug-ins, das in Ihrem Cluster installiert ist.
   ```
   helm ls
   ```
   {: pre}

2. Überprüfen Sie, ob Sie die [neueste Version des {{site.data.keyword.cloud_notm}} Block Storage-Plug-ins](https://cloud.ibm.com/kubernetes/solutions/helm-charts/ibm/ibmcloud-block-storage-plugin) verwenden. Ist dies nicht der Fall, [aktualisieren Sie Ihr Plug-in](/docs/containers?topic=containers-block_storage#updating-the-ibm-cloud-block-storage-plug-in).
3. Wenn Sie eine Kubernetes-Bereitstellung für Ihren Pod verwendet haben, starten Sie den fehlgeschlagenen Pod erneut, indem Sie den Pod entfernen und Kubernetes den Pod erneut erstellen lassen. Wenn Sie keine Bereitstellung verwendet haben, rufen Sie die YAML-Datei ab, die zum Erstellen Ihres Pods verwendet wurde, indem Sie den Befehl `kubectl get pod <podname> -o yaml >pod.yaml` ausführen. Löschen Sie anschließend den Pod und erstellen Sie ihn neu.
    ```
    kubectl delete pod <podname>
    ```
    {: pre}

4. Prüfen Sie, ob die erneute Erstellung Ihres Pods das Problem behoben hat. Falls nicht, laden Sie den Workerknoten neu.
   1. Ermitteln Sie den Workerknoten, auf dem Ihr Pod ausgeführt wird, und notieren Sie die private IP-Adresse, die Ihrem Workerknoten zugeordnet ist.
      ```
      kubectl describe pod <podname> | grep Node
      ```
      {: pre}

      Beispielausgabe:
      ```
      Node:               10.75.XX.XXX/10.75.XX.XXX
      Node-Selectors:  <none>
      ```
      {: screen}

   2. Rufen Sie die **ID** Ihres Workerknotens ab, indem Sie die private IP-Adresse aus dem vorherigen Schritt verwenden.
      ```
      ibmcloud ks workers --cluster <clustername_oder_-id>
      ```
      {: pre}

   3. [Laden Sie den Workerknoten ordnungsgemäß neu](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload).


<br />


### Blockspeicher: Das Anhängen eines vorhandenen Blockspeichers an einen Pod schlägt aufgrund des falschen Dateisystems fehl
{: #block_filesystem}

{: tsSymptoms}
Bei der Ausführung des Befehls `kubectl describe pod <podname>` wird der folgende Fehler angezeigt:
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
Sie verfügen über eine vorhandene Blockspeichereinheit, die für ein `XFS`-Dateisystem konfiguriert ist. Um diese Einheit an Ihren Pod anzuhängen, haben Sie [einen persistenten Datenträger (PV) erstellt](/docs/containers?topic=containers-block_storage#existing_block), der `ext4` als Ihr Dateisystem oder kein Dateisystem im Abschnitt `spec/flexVolume/fsType` angegeben hat. Wenn kein Dateisystem definiert ist, nimmt der persistente Datenträger standardmäßig den Wert `ext4` ein.
Der persistente Datenträger wurde erfolgreich erstellt und mit der vorhandenen Blockspeicherinstanz verknüpft. Wenn Sie jedoch versuchen, den persistenten Datenträger mithilfe eines PVC an den Cluster anzuhängen, schlägt dieser Vorgang fehl. Sie können die `XFS`-Blockspeicherinstanz nicht mit einem `ext4`-Dateisystem an den Pod anhängen.

{: tsResolve}
Aktualisieren Sie das Dateisystem im vorhandenen persistenten Datenträger von `ext4` auf `XFS`.

1. Listen Sie die vorhandenen persistenten Datenträger in Ihrem Cluster auf und notieren Sie sich den Namen des persistenten Datenträgers, den Sie für die vorhandene Blockspeicherinstanz verwendet haben.
   ```
   kubectl get pv
   ```
   {: pre}

2. Speichern Sie die YALM-Datei des persistenten Datenträgers auf der lokalen Maschine.
   ```
   kubectl get pv <pv-name> -o yaml > <dateipfad/xfs_pv.yaml>
   ```
   {: pre}

3. Öffnen Sie die YALM-Datei und ändern Sie den Wert für `fsType` von `ext4` in `xfs`.
4. Ersetzen Sie den persistenten Datenträger im Cluster.
   ```
   kubectl replace --force -f <dateipfad/xfs_pv.yaml>
   ```
   {: pre}

5. Melden Sie sich bei dem Pod an, an den Sie den persistenten Datenträger angehängt haben.
   ```
   kubectl exec -it <pod-name> sh
   ```
   {: pre}

6. Stellen Sie sicher, dass das Dateisystem in `XFS` geändert wurde.
   ```
   df -Th
   ```
   {: pre}

   Beispielausgabe:
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## Objektspeicher: Installation des Helm-Plug-ins {{site.data.keyword.cos_full_notm}} `ibmc` schlägt fehl
{: #cos_helm_fails}

{: tsSymptoms}
Wenn Sie das {{site.data.keyword.cos_full_notm}}-Helm-Plug-in `ibmc` installieren, schlägt die Installation mit einem der folgenden Fehler fehl:
```
Error: symlink /Users/iks-charts/ibm-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

```
Error: fork/exec /home/iksadmin/.helm/plugins/helm-ibmc/ibmc.sh: permission denied
```
{: screen}

{: tsCauses}
Bei der Installation des Helm-Plug-ins `ibmc` wird eine symbolische Verbindung aus dem Verzeichnis `./helm/plugins/helm-ibmc` zu dem Verzeichnis hergestellt, in dem sich das Helm-Plug-in `ibmc` auf Ihrem lokalen System befindet, das normalerweise in `./ibmcloud-object-storage-plugin/helm-ibmc` enthalten ist. Wenn Sie das Helm-Plug-in `ibmc` von Ihrem lokalen System entfernen oder das Helm-Plug-in-Verzeichnis `ibmc` an eine andere Position verschieben, wird die symbolische Verbindung nicht entfernt.

Wenn ein Fehler `permission denied` (Berechtigung verweigert) angezeigt wird, verfügen Sie nicht über die erforderliche Lese-, Schreib- und Ausführungsberechtigung (`read`, `write` und `execute`) für die Bashdatei `ibmc.sh`, um Befehle für das Helm-Plug-in `ibmc` auszuführen.

{: tsResolve}

**Bei Fehlern mit symbolischen Verbindungen**:

1. Entfernen Sie das {{site.data.keyword.cos_full_notm}}-Helm-Plug-in.
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

2. Befolgen Sie die Anweisungen in der [Dokumentation](/docs/containers?topic=containers-object_storage#install_cos), um das Helm-Plug-in `ibmc` und das {{site.data.keyword.cos_full_notm}}-Plug-in erneut zu installieren.

**Bei Berechtigungsfehlern**:

1. Ändern Sie die Berechtigungen für das Plug-in `ibmc`.
   ```
   chmod 755 ~/.helm/plugins/helm-ibmc/ibmc.sh
   ```
   {: pre}

2. Probieren Sie das Helm-Plug-in `ibm`.
   ```
   helm ibmc --help
   ```
   {: pre}

3. [Setzen Sie die Installation des {{site.data.keyword.cos_full_notm}}-Plug-ins fort](/docs/containers?topic=containers-object_storage#install_cos).


<br />


## Objektspeicher: PVC bleibt im Wartestatus (Pending)
{: #cos_pvc_pending}

{: tsSymptoms}
Wenn Sie einen PVC erstellen und den Befehl `kubectl get pvc <pvc-name>` ausführen, bleibt Ihr PVC im Zustand **Pending** (Anstehend), selbst wenn Sie einige Zeit warten.

{: tsCauses}
Während der PVC-Erstellung und -Bindung werden vom {{site.data.keyword.cos_full_notm}}-Plug-in viele verschiedene Tasks ausgeführt. Jede Task kann fehlschlagen und eine andere Fehlernachricht auslösen.

{: tsResolve}

1. Suchen Sie nach der Ursache dafür, dass der PVC im Zustand **Pending** (Anstehend) bleibt.
   ```
   kubectl describe pvc <pvc-name> -n <namensbereich>
   ```
   {: pre}

2. Prüfen Sie die Beschreibungen allgemeiner Nachrichten und die Hinweise zur Fehlerbehebung.

   <table>
   <thead>
     <th>Fehlernachricht</th>
     <th>Beschreibung</th>
     <th>Schritte zur Behebung</th>
  </thead>
  <tbody>
    <tr>
      <td>`User doesn't have permissions to create or manage Storage`</td>
      <td>Der IAM-API-Schlüssel oder der API-Schlüssel der IBM Cloud-Infrastruktur, der im geheimen Kubernetes-Schlüssel `storage-secret-store` Ihres Clusters gespeichert ist, verfügt nicht über die erforderlichen Berechtigungen zum Bereitstellen von persistentem Speicher. </td>
      <td>Siehe [PVC-Erstellung schlägt aufgrund fehlender Berechtigungen fehl](#missing_permissions). </td>
    </tr>
    <tr>
      <td>`cannot get credentials: cannot get secret <secret_name>: secrets "<secret_name>" not found`</td>
      <td>Der geheime Kubernetes-Schlüssel, der Ihre {{site.data.keyword.cos_full_notm}}-Serviceberechtigungsnachweise enthält, ist nicht in demselben Namensbereich wie der PVC oder Pod vorhanden. </td>
      <td>Siehe [PVC- oder Poderstellung schlägt fehl, weil der geheime Kubernetes-Schlüssel nicht gefunden wurde](#cos_secret_access_fails).</td>
    </tr>
    <tr>
      <td>`cannot get credentials: Wrong Secret Type.Provided secret of type XXXX.Expected type ibm/ibmc-s3fs`</td>
      <td>Der geheime Kubernetes-Schlüssel, den Sie für Ihre {{site.data.keyword.cos_full_notm}}-Serviceinstanz erstellt haben, enthält `type: ibm/ibmc-s3fs` nicht.</td>
      <td>Bearbeiten Sie den geheimen Kubernetes-Schlüssel, der Ihre {{site.data.keyword.cos_full_notm}}-Berechtigungsnachweise enthält, um den Typ (`type`) in `ibm/ibmc-s3fs` zu ändern oder die Typangabe hinzuzufügen. </td>
    </tr>
    <tr>
      <td>`Bad value for ibm.io/object-store-endpoint XXXX: scheme is missing. Must be of the form http://<hostname> or https://<hostname>`</br> </br> `Bad value for ibm.io/iam-endpoint XXXX: scheme is missing. Must be of the form http://<hostname< or https://<hostname>`</td>
      <td>Der s3fs-API- oder IAM-API-Endpunkt hat das falsche Format oder der s3fs-API-Endpunkt konnte auf der Basis Ihres Clusterstandorts nicht abgerufen werden.  </td>
      <td>Siehe [PVC-Erstellung schlägt aufgrund eines falschen s3fs-API-Endpunkts fehl](#cos_api_endpoint_failure).</td>
    </tr>
    <tr>
      <td>`object-path cannot be set when auto-create is enabled`</td>
      <td>Sie haben ein vorhandenes Unterverzeichnis in Ihrem Bucket angegeben, das Sie mit der Annotation `ibm.io/object-path` an Ihren PVC anhängen möchten. Wenn Sie ein Unterverzeichnis angeben, müssen Sie die Funktion für die automatische Erstellung von Buckets inaktivieren.  </td>
      <td>Legen Sie in Ihrem PVC `ibm.io/auto-create-bucket: "false"` fest und geben Sie den Namen des vorhandenen Buckets in `ibm.io/bucket` an.</td>
    </tr>
    <tr>
    <td>`bucket auto-create must be enabled when bucket auto-delete is enabled`</td>
    <td>Geben Sie in Ihrem PVC `ibm.io/auto-delete-bucket: true` an, damit die Daten, das Bucket und der PVC automatisch gelöscht werden, wenn Sie den PVC entfernen. Diese Option erfordert, dass `ibm.io/auto-create-bucket` auf <strong>true</strong> und `ibm.io/bucket` auf `""` gesetzt ist.</td>
    <td>Legen Sie in Ihrem PVC `ibm.io/auto-create-bucket: true` und `ibm.io/bucket: ""` fest, sodass Ihr Bucket automatisch mit einem Namen im Format `tmp-s3fs-xxxx` erstellt wird. </td>
    </tr>
    <tr>
    <td>`bucket cannot be set when auto-delete is enabled`</td>
    <td>Geben Sie in Ihrem PVC `ibm.io/auto-delete-bucket: true` an, damit die Daten, das Bucket und der PVC automatisch gelöscht werden, wenn Sie den PVC entfernen. Diese Option erfordert, dass `ibm.io/auto-create-bucket` auf <strong>true</strong> und `ibm.io/bucket` auf `""` gesetzt ist.</td>
    <td>Legen Sie in Ihrem PVC `ibm.io/auto-create-bucket: true` und `ibm.io/bucket: ""` fest, sodass Ihr Bucket automatisch mit einem Namen im Format `tmp-s3fs-xxxx` erstellt wird. </td>
    </tr>
    <tr>
    <td>`cannot create bucket using API key without service-instance-id`</td>
    <td>Wenn Sie IAM-API-Schlüssel für den Zugriff auf Ihre {{site.data.keyword.cos_full_notm}}-Serviceinstanz verwenden möchten, müssen Sie den API-Schlüssel und die ID der {{site.data.keyword.cos_full_notm}}-Serviceinstanz in einem geheimen Kubernetes-Schlüssel speichern.  </td>
    <td>Siehe [Geheimen Schlüssel für die Berechtigungsnachweise des Objektspeicherservice erstellen](/docs/containers?topic=containers-object_storage#create_cos_secret). </td>
    </tr>
    <tr>
      <td>`object-path “<subdirectory_name>” not found inside bucket <bucket_name>`</td>
      <td>Sie haben ein vorhandenes Unterverzeichnis in Ihrem Bucket angegeben, das Sie mit der Annotation `ibm.io/object-path` an Ihren PVC anhängen möchten. Dieses Unterverzeichnis konnte in dem Bucket, das Sie angegeben haben, nicht gefunden werden. </td>
      <td>Stellen Sie sicher, dass das Unterverzeichnis, das Sie in `ibm.io/object-path` angegeben haben, in dem Bucket vorhanden ist, das Sie in `ibm.io/bucket` angegeben haben. </td>
    </tr>
        <tr>
          <td>`BucketAlreadyExists: The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.`</td>
          <td>Sie haben `ibm.io/auto-create-bucket: true` festgelegt und gleichzeitig einen Bucketamen angegeben oder Sie haben einen Bucketnamen angegeben, der in {{site.data.keyword.cos_full_notm}} bereits vorhanden ist. Bucketnamen müssen für alle Serviceinstanzen und -regionen in {{site.data.keyword.cos_full_notm}} eindeutig sein.  </td>
          <td>Stellen Sie sicher, dass Sie `ibm.io/auto-create-bucket: false` festlegen und einen Bucketnamen angeben, der in {{site.data.keyword.cos_full_notm}} eindeutig ist. Wenn Sie das {{site.data.keyword.cos_full_notm}}-Plug-in verwenden möchten, um automatisch einen Bucketnamen für Sie zu erstellen, legen Sie `ibm.io/auto-create-bucket: true` und `ibm.io/bucket: ""` fest. Ihr Bucket wird mit einem eindeutigen Namen im Format `tmp-s3fs-xxxx` erstellt. </td>
        </tr>
        <tr>
          <td>`cannot access bucket <bucket_name>: NotFound: Not Found`</td>
          <td>Sie haben versucht, auf ein Bucket zuzugreifen, das Sie nicht erstellt haben, oder die Speicherklasse und der s3fs-API-Endpunkt, die Sie angegeben haben, stimmen nicht mit der Speicherklasse und dem s3fs-API-Endpunkt überein, die bei der Erstellung des Buckets verwendet wurden. </td>
          <td>Siehe [Zugriff auf ein vorhandenes Bucket nicht möglich](#cos_access_bucket_fails). </td>
        </tr>
        <tr>
          <td>`Put https://s3-api.dal-us-geo.objectstorage.service.networklayer.com/<bucket_name>: net/http: invalid header field value "AWS4-HMAC-SHA256 Credential=1234a12a123a123a1a123aa1a123a123\n\n/20190412/us-standard/s3/aws4_request, SignedHeaders=host;x-amz-content-sha256;x-amz-date, Signature=12aa1abc123456aabb12aas12aa123456sb123456abc" for key Authorization`</td>
          <td>Die Werte in Ihrem geheimen Kubernetes-Schlüssel sind nicht ordnungsgemäß mit Base64 codiert.  </td>
          <td>Überprüfen Sie die Werte in Ihrem geheimen Kubernetes-Schlüssel und codieren Sie jeden Wert mit Base64. Sie können auch den Befehl [`kubectl create secret`](/docs/containers?topic=containers-object_storage#create_cos_secret) verwenden, um einen neuen geheimen Schlüssel zu erstellen und Kubernetes automatisch Ihre Werte mit Base64 codieren zu lassen. </td>
        </tr>
        <tr>
          <td>`cannot access bucket <bucket_name>: Forbidden: Forbidden`</td>
          <td>Sie haben `ibm.io/auto-create-bucket: false` angegeben und versucht, auf ein Bucket zuzugreifen, das Sie nicht erstellt haben, oder der Servicezugriffsschlüssel oder die Zugriffsschlüssel-ID Ihrer {{site.data.keyword.cos_full_notm}}-HMAC-Berechtigungsnachweise sind falsch.  </td>
          <td>Sie können nicht auf ein Bucket zugreifen, das Sie nicht erstellt haben. Erstellen Sie stattdessen ein Bucket, indem Sie `ibm.io/auto-create-bucket: true` und `ibm.io/bucket: ""` festlegen. Wenn Sie Eigner des Buckets sind, finden Sie unter [PVC-Erstellung schlägt wegen falscher Berechtigungsnachweise fehl oder Zugriff verweigert](#cred_failure) Informationen zum Prüfen Ihrer Berechtigungsnachweise. </td>
        </tr>
        <tr>
          <td>`cannot create bucket <bucket_name>: AccessDenied: Access Denied`</td>
          <td>Sie haben `ibm.io/auto-create-bucket: true` angegeben, um automatisch ein Bucket in {{site.data.keyword.cos_full_notm}} zu erstellen, aber die Berechtigungsnachweise, die Sie im geheimen Kubernetes-Schlüssel angegeben haben, sind der IAM-Servicezugriffsrolle **Leseberechtigter** zugeordnet. Diese Rolle lässt die Bucketerstellung in {{site.data.keyword.cos_full_notm}} nicht zu. </td>
          <td>Siehe [PVC-Erstellung schlägt wegen falscher Berechtigungsnachweise fehl oder Zugriff verweigert](#cred_failure). </td>
        </tr>
        <tr>
          <td>`cannot create bucket <bucket_name>: AccessForbidden: Access Forbidden`</td>
          <td>Sie haben `ibm.io/auto-create-bucket: true` festgelgt und in `ibm.io/bucket` den Namen eines vorhandenen Buckets angegeben. Außerdem sind die Berechtigungsnachweise, die Sie im geheimen Kubernetes-Schlüssel angegeben haben, der IAM-Servicezugriffsrolle **Leseberechtigter** zugeordnet. Diese Rolle lässt die Bucketerstellung in {{site.data.keyword.cos_full_notm}} nicht zu. </td>
          <td>Legen Sie `ibm.io/auto-create-bucket: false` fest und geben Sie in `ibm.io/bucket` den Namen Ihres vorhandenen Buckets an, um ein vorhandenes Bucket zu verwenden. Wenn Sie ein Bucket automatisch erstellen möchten, indem Sie Ihren vorhandenen geheimen Kubernetes-Schlüssel verwenden, legen Sie `ibm.io/bucket: ""` fest und befolgen Sie die Anweisungen in [PVC-Erstellung schlägt wegen falscher Berechtigungsnachweise fehl oder Zugriff verweigert](#cred_failure) zum Prüfen der Berechtigungsnachweise in Ihrem geheimen Kubernetes-Schlüssel.</td>
        </tr>
        <tr>
          <td>`cannot create bucket <bucket_name>: SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details`</td>
          <td>Der geheime {{site.data.keyword.cos_full_notm}}-Zugriffsschlüssel Ihrer HMAC-Berechtigungsnachweise, den Sie in Ihrem geheimen Kubernetes-Schlüssel angegeben haben, ist nicht korrekt. </td>
          <td>Siehe [PVC-Erstellung schlägt wegen falscher Berechtigungsnachweise fehl oder Zugriff verweigert](#cred_failure).</td>
        </tr>
        <tr>
          <td>`cannot create bucket <bucket_name>: InvalidAccessKeyId: The AWS Access Key ID you provided does not exist in our records`</td>
          <td>Die {{site.data.keyword.cos_full_notm}}-Zugriffsschlüssel-ID oder der geheime Zugriffsschlüssel Ihrer HMAC-Berechtigungsnachweise, den Sie in Ihrem geheimen Kubernetes-Schlüssel angegeben haben, ist nicht korrekt.</td>
          <td>Siehe [PVC-Erstellung schlägt wegen falscher Berechtigungsnachweise fehl oder Zugriff verweigert](#cred_failure). </td>
        </tr>
        <tr>
          <td>`cannot create bucket <bucket_name>: CredentialsEndpointError: failed to load credentials` </br> </br> `cannot access bucket <bucket_name>: CredentialsEndpointError: failed to load credentials`</td>
          <td>Der {{site.data.keyword.cos_full_notm}}-API-Schlüssel Ihrer IAM-Berechtigungsnachweise und die GUID Ihrer {{site.data.keyword.cos_full_notm}}-Serviceinstanz sind nicht korrekt.</td>
          <td>Siehe [PVC-Erstellung schlägt wegen falscher Berechtigungsnachweise fehl oder Zugriff verweigert](#cred_failure). </td>
        </tr>
  </tbody>
    </table>


### Objektspeicher: PVC- oder Poderstellung schlägt fehl, weil der geheime Kubernetes-Schlüssel nicht gefunden wurde
{: #cos_secret_access_fails}

{: tsSymptoms}
Wenn Sie Ihren PVC erstellen oder einen Pod bereitstellen, der den PVC anhängt, schlägt die Erstellung oder Bereitstellung fehl.

- Beispielfehlernachricht für einen Fehler bei der PVC-Erstellung:
  ```
  cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- Beispielfehlernachricht für einen Fehler bei der Erstellung eines Pods:
  ```
  persistentvolumeclaim "pvc-3" not found (repeated 3 times)
  ```
  {: screen}

{: tsCauses}
Der geheime Kubernetes-Schlüssel, in dem Sie Ihre {{site.data.keyword.cos_full_notm}}-Serviceberechtigungsnachweise, den PVC und den Pod speichern, befinden sich nicht alle im selben Kubernetes-Namensbereich. Wenn der geheime Schlüssel in einem anderen Namensbereich bereitgestellt wird als Ihr PVC oder Pod, kann nicht auf den geheimen Schlüssel zugegriffen werden.

{: tsResolve}
Diese Task erfordert die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für alle Namensbereiche.

1. Listen Sie die geheimen Schlüssel in Ihrem Cluster auf und überprüfen Sie den Kubernetes-Namensbereich, in dem der geheime Kubernetes-Schlüssel für Ihre {{site.data.keyword.cos_full_notm}}-Serviceinstanz erstellt wird. Der geheime Schlüssel muss `ibm/ibmc-s3fs` als **Typ** aufweisen.
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}

2. Überprüfen Sie die YAML-Konfigurationsdatei auf Ihren PVC und Pod, um zu ermitteln, ob Sie denselben Namensbereich verwendet haben. Wenn Sie einen Pod in einem anderen Namensbereich als dem mit dem geheimen Schlüssel bereitstellen wollen, müssen Sie [einen weiteren geheimen Schlüssel](/docs/containers?topic=containers-object_storage#create_cos_secret) in diesem anderen Namensbereich erstellen.

3. Erstellen Sie den PVC oder stellen Sie den Pod in dem gewünschten Namensbereich bereit.

<br />


### Objektspeicher: PVC-Erstellung schlägt wegen falscher Berechtigungsnachweise fehl oder Zugriff verweigert
{: #cred_failure}

{: tsSymptoms}
Wenn Sie den PVC erstellen, wird eine Fehlernachricht ähnlich der folgenden angezeigt:

```
SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details.
```
{: screen}

```
AccessDenied: Access Denied status code: 403
```
{: screen}

```
CredentialsEndpointError: failed to load credentials
```
{: screen}

```
InvalidAccessKeyId: The AWS Access Key ID you provided does not exist in our records`
```
{: screen}

```
cannot access bucket <bucketname>: Forbidden: Forbidden
```
{: screen}


{: tsCauses}
Die {{site.data.keyword.cos_full_notm}}-Serviceberechtigungsnachweise, die Sie für den Zugriff auf die Serviceinstanz verwenden, sind möglicherweise falsch oder lassen nur Lesezugriff auf das Bucket zu.

{: tsResolve}
1. Klicken Sie in der Navigation auf der Seite mit den Servicedetails auf **Serviceberechtigungsnachweise**.
2. Suchen Sie nach Ihren Berechtigungsnachweisen und klicken Sie anschließend auf **Berechtigungsnachweise anzeigen**.
3. Überprüfen Sie im Abschnitt **iam_role_crn**, ob Sie über die Rolle `Schreibberechtigter` oder `Manager` verfügen. Wenn Sie nicht über die richtige Rolle verfügen, müssen Sie neue {{site.data.keyword.cos_full_notm}}-Serviceberechtigungsnachweise mit der richtigen Berechtigung erstellen.
4. Wenn die Rolle korrekt ist, stellen Sie sicher, dass die richtigen Werte für die Zugriffsschlüssel-ID (**access_key_id**) und den geheimen Zugriffsschlüssel (**secret_access_key**) in Ihrem geheimen Kubernetes-Schlüssel enthalten sind.
5. [Erstellen Sie einen neuen geheimen Schlüssel mit den aktualisierten Angaben für die Zugriffsschlüssel-ID (**access_key_id**) und den geheimen Zugriffsschlüssel (**secret_access_key**)](/docs/containers?topic=containers-object_storage#create_cos_secret).


<br />


### Objektspeicher: PVC-Erstellung schlägt wegen falschem s3fs- oder IAM-API-Endpunkt fehl
{: #cos_api_endpoint_failure}

{: tsSymptoms}
Wenn Sie den PVC erstellen, bleibt der PVC im Wartestatus (pending). Nach der Ausführung des Befehls `kubectl describe pvc <pvc-name>` sehen Sie eine der folgenden Fehlernachrichten:

```
Bad value for ibm.io/object-store-endpoint XXXX: scheme is missing. Must be of the form http://<hostname> or https://<hostname>
```
{: screen}

```
Bad value for ibm.io/iam-endpoint XXXX: scheme is missing. Must be of the form http://<hostname> or https://<hostname>
```
{: screen}

{: tsCauses}
Der s3fs-API-Endpunkt für das Bucket, das Sie verwenden möchten, hat möglicherweise das falsche Format oder Ihr Cluster wird an einer Position bereitgestellt, die in {{site.data.keyword.containerlong_notm}} unterstützt wird, aber vom {{site.data.keyword.cos_full_notm}}-Plug-in noch nicht unterstützt wird.

{: tsResolve}
1. Überprüfen Sie den s3fs-API-Endpunkt, der Ihren Speicherklassen während der Installation des {{site.data.keyword.cos_full_notm}}-Plug-ins vom Helm-Plug-in `ibmc` automatisch zugeordnet wurde. Der Endpunkt basiert auf dem Standort, an dem Ihr Cluster bereitgestellt wird.  
   ```
   kubectl get sc ibmc-s3fs-standard-regional -o yaml | grep object-store-endpoint
   ```
   {: pre}

   Wenn der Befehl `ibm.io/object-store-endpoint: NA` zurückgibt, wurde Ihr Cluster an einem Standort bereitgestellt, der in {{site.data.keyword.containerlong_notm}} unterstützt wird, aber vom {{site.data.keyword.cos_full_notm}}-Plug-in noch nicht unterstützt wird. Wenn Sie {{site.data.keyword.containerlong_notm}} den Standort hinzufügen möchten, müssen Sie eine Frage in unserem öffentlichen Slack posten oder einen {{site.data.keyword.cloud_notm}}-Supportfall öffnen. Weitere Informationen finden Sie im Abschnitt [Hilfe und Unterstützung anfordern](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).

2. Wenn Sie den s3fs-API-Endpunkt mit der Annotation `ibm.io/endpoint` oder den IAM-API-Endpunkt mit der Annotation `ibm.io/iam-endpoint` in Ihrem PVC manuell hinzugefügt haben, müssen Sie sicherstellen, dass Sie die Endpunkte im Format `https://<s3fs_api_endpoint>` und `https://<iam_api_endpoint>` hinzugefügt haben. Die Annotation überschreibt die API-Endpunkte, die vom Plug-in `ibmc` in den {{site.data.keyword.cos_full_notm}}-Speicherklassen automatisch festgelegt werden.
   ```
   kubectl describe pvc <pvc-name>
   ```
   {: pre}

<br />


### Objektspeicher: Zugriff auf ein vorhandenes Bucket nicht möglich
{: #cos_access_bucket_fails}

{: tsSymptoms}
Wenn Sie den PVC erstellen, kann auf das Bucket in {{site.data.keyword.cos_full_notm}} nicht zugegriffen werden. Es wird eine Fehlernachricht ähnlich der folgenden angezeigt:

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucketname>: NotFound: Not Found
```
{: screen}

{: tsCauses}
Sie haben möglicherweise die falsche Speicherklasse verwendet, um auf das vorhandene Bucket zuzugreifen, oder Sie haben versucht, auf ein Bucket zuzugreifen, das Sie nicht erstellt haben. Sie können nicht auf ein Bucket zugreifen, das Sie nicht erstellt haben.

{: tsResolve}
1. Wählen Sie im [{{site.data.keyword.cloud_notm}}-Dashboard ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/) Ihre {{site.data.keyword.cos_full_notm}}-Serviceinstanz aus.
2. Wählen Sie **Buckets** aus.
3. Überprüfen Sie die Informationen zu **Klasse** und **Standort** für Ihr vorhandenes Bucket.
4. Wählen Sie die entsprechende [Speicherklasse](/docs/containers?topic=containers-object_storage#cos_storageclass_reference) aus.
5. Stellen Sie sicher, dass Sie `ibm.io/auto-create-bucket: false` festlegen und den korrekten Namen Ihres vorhandenen Buckets angeben.

<br />


## Objektspeicher: Zugriff auf Dateien mit einem Benutzer ohne Rootberechtigung schlägt fehl
{: #cos_nonroot_access}

{: tsSymptoms}
Sie haben Dateien über die Konsole oder die REST-API in Ihre {{site.data.keyword.cos_full_notm}}-Serviceinstanz hochgeladen. Wenn Sie versuchen, auf diese Dateien als Benutzer ohne Rootberechtigung zuzugreifen, den Sie in der App-Bereitstellung mit `runAsUser` definiert haben, wird der Zugriff auf die Dateien verweigert.

{: tsCauses}
Unter Linux hat eine Datei oder ein Verzeichnis drei Zugriffsgruppen: `Eigner`, `Gruppe` und `Andere`. Wenn Sie eine Datei über die Konsole oder die REST-API in {{site.data.keyword.cos_full_notm}} hochladen, werden die Berechtigungen für `Eigner`, `Gruppe` und `Andere` entfernt. Die Berechtigung der einzelnen Dateien sieht wie folgt aus:

```
d--------- 1 root root 0 Jan 1 1970 <dateiname>
```
{: screen}

Wenn Sie eine Datei mithilfe des {{site.data.keyword.cos_full_notm}}-Plug-ins hochladen, werden die Berechtigungen für die Datei beibehalten und nicht geändert.

{: tsResolve}
Um auf die Datei als Benutzer ohne Rootberechtigung zugreifen zu können, muss der Benutzer ohne Rootberechtigung über Lese- und Schreibberechtigungen für die Datei verfügen. Wenn Sie die Berechtigung für eine Datei im Rahmen Ihrer Podbereitstellung ändern, ist eine Schreiboperation erforderlich. {{site.data.keyword.cos_full_notm}} ist nicht für Schreibworkloads konzipiert. Durch die Aktualisierung der Berechtigungen während der Podbereitstellung kann verhindert werden, dass Ihr Pod in den Status `Aktiv` wechselt.

Um dieses Problem zu beheben, müssen Sie vor dem Anhängen des PVC an Ihren App-Pod einen weiteren Pod erstellen, um die richtige Berechtigung für den Benutzer ohne Rootberechtigung festzulegen.

1. Überprüfen Sie die Berechtigungen Ihrer Dateien in Ihrem Bucket.
   1. Erstellen Sie eine Konfigurationsdatei für Ihren Pod `test-permission` und geben Sie der Datei den Namen `test-permission.yaml`.
      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: test-permission
      spec:
        containers:
        - name: test-permission
          image: nginx
          volumeMounts:
          - name: cos-vol
            mountPath: /test
        volumes:
        - name: cos-vol
          persistentVolumeClaim:
            claimName: <pvc-name>
      ```
      {: codeblock}

   2. Erstellen Sie den Pod `test-permission`.
      ```
      kubectl apply -f test-permission.yaml
      ```
      {: pre}

   3. Melden Sie sich beim Pod an.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   4. Navigieren Sie zu Ihrem Mountpfad und listen Sie die Berechtigungen für Ihre Dateien auf.
      ```
      cd test && ls -al
      ```
      {: pre}

      Beispielausgabe:
      ```
      d--------- 1 root root 0 Jan 1 1970 <dateiname>
      ```
      {: screen}

2. Löschen Sie den Pod.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

3. Erstellen Sie eine Konfigurationsdatei für den Pod, die Sie verwenden, um die Berechtigungen Ihrer Dateien zu korrigieren, und geben Sie ihr den Namen `fix-permission.yaml`.
   ```
   apiVersion: v1
   kind: Pod
   metadata:
     name: fix-permission
     namespace: <namensbereich>
   spec:
     containers:
     - name: fix-permission
       image: busybox
       command: ['sh', '-c']
       args: ['chown -R <nicht-root-benutzer-id> <mountpfad>/*; find <mountpfad>/ -type d -print -exec chmod u=+rwx,g=+rx {} \;']
       volumeMounts:
       - mountPath: "<mountpfad>"
         name: cos-volume
     volumes:
     - name: cos-volume
       persistentVolumeClaim:
         claimName: <pvc-name>
    ```
    {: codeblock}

3. Erstellen Sie den Pod `fix-permission`.
   ```
   kubectl apply -f fix-permission.yaml
   ```
   {: pre}

4. Warten Sie, bis der Pod in den Status `Abgeschlossen` wechselt.  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. Löschen Sie den Pod `fix-permission`.
   ```
   kubectl delete pod fix-permission
   ```
   {: pre}

5. Erstellen Sie wieder den Pod `test-permission`, den Sie zuvor verwendet haben, um die Berechtigungen zu überprüfen.
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}

5. Stellen Sie sicher, dass die Berechtigungen für Ihre Dateien aktualisiert wurden.
   1. Melden Sie sich beim Pod an.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   2. Navigieren Sie zu Ihrem Mountpfad und listen Sie die Berechtigungen für Ihre Dateien auf.
      ```
      cd test && ls -al
      ```
      {: pre}

      Beispielausgabe:
      ```
      -rwxrwx--- 1 <nicht-root-benutzer-id> root 6193 Aug 21 17:06 <dateiname>
      ```
      {: screen}

6. Löschen Sie den Pod `test-permission`.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

7. Hängen Sie den PVC mit dem Benutzer ohne Rootberechtigung an die App an.

   Definieren Sie den Benutzer ohne Rootberechtigung als `runAsUser`, ohne gleichzeitig `fsGroup` in Ihrer YAML-Datei für die Bereitstellung zu definieren. Wenn Sie `fsGroup` festlegen, wird das {{site.data.keyword.cos_full_notm}}-Plug-in ausgelöst, das die Gruppenberechtigungen für alle Dateien in einem Bucket aktualisiert, wenn der Pod bereitgestellt wird. Das Aktualisieren der Berechtigungen ist eine Schreiboperation, die möglicherweise verhindert, dass Ihr Pod in den Status `Aktiv` wechselt.
   {: important}

Laden Sie keine Dateien über die Konsole oder die REST-API hoch, nachdem Sie die richtigen Dateiberechtigungen in Ihrer {{site.data.keyword.cos_full_notm}}-Serviceinstanz festgelegt haben. Verwenden Sie das {{site.data.keyword.cos_full_notm}}-Plug-in, um Dateien zu Ihrer Serviceinstanz hinzuzufügen.
{: tip}

<br />



## PVC-Erstellung schlägt aufgrund fehlender Berechtigungen fehl
{: #missing_permissions}

{: tsSymptoms}
Wenn Sie den PVC erstellen, bleibt der PVC im Wartestatus (pending). Wenn Sie den Befehl `kubectl describe pvc <pvc-name>` ausführen, wird eine Fehlernachricht ähnlich der folgenden angezeigt:

```
User doesn't have permissions to create or manage Storage
```
{: screen}

{: tsCauses}
Der IAM-API-Schlüssel oder der API-Schlüssel der IBM Cloud-Infrastruktur, der im geheimen Kubernetes-Schlüssel `storage-secret-store` Ihres Clusters gespeichert ist, verfügt nicht über die erforderlichen Berechtigungen zum Bereitstellen von persistentem Speicher. 

{: tsResolve}
1. Rufen Sie den IAM-Schlüssel oder den API-Schlüssel der IBM Cloud-Infrastruktur ab, der im geheimen Kubernetes-Schlüssel `storage-secret-store` Ihres Clusters gespeichert ist, und stellen Sie sicher, dass der richtige API-Schlüssel verwendet wird. 
   ```
   kubectl get secret storage-secret-store -n kube-system -o yaml | grep slclient.toml: | awk '{print $2}' | base64 --decode
   ```
   {: pre}

   Beispielausgabe:
   ```
   [Bluemix]
   iam_url = "https://iam.bluemix.net"
   iam_client_id = "bx"
   iam_client_secret = "bx"
   iam_api_key = "<iam_api_key>"
   refresh_token = ""
   pay_tier = "paid"
   containers_api_route = "https://us-south.containers.bluemix.net"

   [Softlayer]
   encryption = true
   softlayer_username = ""
   softlayer_api_key = ""
   softlayer_endpoint_url = "https://api.softlayer.com/rest/v3"
   softlayer_iam_endpoint_url = "https://api.softlayer.com/mobile/v3"
   softlayer_datacenter = "dal10"
   ```
   {: screen}

   Der IAM-API-Schlüssel wird im Abschnitt `Bluemix.iam_api_key` der CLI-Ausgabe aufgelistet. Wenn `Softlayer.softlayer_api_key` zu diesem Zeitpunkt leer ist, wird der IAM-API-Schlüssel verwendet, um Ihre Infrastrukturberechtigungen zu bestimmen. Der IAM-API-Schlüssel wird von dem Benutzer automatisch festgelegt, der die erste Aktion ausführt, die die IAM-Plattformrolle **Administrator** in einer Ressourcengruppe oder Region erfordert. Wenn in `Softlayer.softlayer_api_key` ein anderer API-Schlüssel festgelegt ist, hat dieser Schlüssel Vorrang vor dem IAM-API-Schlüssel. `Softlayer.softlayer_api_key` wird festgelegt, wenn ein Clusteradministrator den Befehl `ibmcloud ks credentials-set` ausführt.

2. Wenn Sie die Berechtigungsnachweise ändern möchten, aktualisieren Sie den API-Schlüssel, der verwendet wird.
    1.  Um den IAM-API-Schlüssel zu aktualisieren, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_api_key_reset) `ibmcloud ks api-key-reset`. Zum Ändern des Schlüssels der IBM Cloud-Infrastruktur verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credentials_set) `ibmcloud ks credential-set`.
    2. Warten Sie 10 bis 15 Minuten, bis der geheime Kubernetes-Schlüssel `storage-secret-store` aktualisiert wurde, und stellen Sie dann sicher, dass der Schlüssel aktualisiert wurde.
       ```
       kubectl get secret storage-secret-store -n kube-system -o yaml | grep slclient.toml: | awk '{print $2}' | base64 --decode
       ```
       {: pre}

3. Wenn der API-Schlüssel korrekt ist, stellen Sie sicher, dass der Schlüssel über die korrekte Berechtigung zum Bereitstellen von persistentem Speicher verfügt.
   1. Wenden Sie sich an den Kontoeigner, um die Berechtigung des API-Schlüssels zu überprüfen.
   2. Wählen Sie als Kontoeigner **Verwalten** > **Zugriff (IAM)** in der Navigationsleiste der {{site.data.keyword.cloud_notm}}-Konsole aus.
   3. Wählen Sie **Benutzer** aus und suchen Sie den Benutzer, dessen API-Schlüssel Sie verwenden wollen.
   4. Wählen Sie **Benutzerdetails verwalten** im Aktionsmenü aus.
   5. Wechseln Sie zur Registerkarte **Klassische Infrastruktur**.
   6. Erweitern Sie die Kategorie **Konto** und stellen Sie sicher, dass die Berechtigung **Speicher hinzufügen/Upgrades für Speicher durchführen (StorageLayer)** zugeordnet ist.
   7. Erweitern Sie die Kategorie **Services** und stellen Sie sicher, dass die Berechtigung **Speicher verwalten** zugeordnet ist.
4. Entfernen Sie den PVC, der fehlgeschlagen ist.
   ```
   kubectl delete pvc <pvc-name>
   ```
   {: pre}

5. Erstellen Sie den PVC erneut.
   ```
   kubectl apply -f pvc.yaml
   ```
   {: pre}


## Hilfe und Unterstützung anfordern
{: #storage_getting_help}

Haben Sie noch immer Probleme mit Ihrem Cluster?
{: shortdesc}

-  Sie werden im Terminal benachrichtigt, wenn Aktualisierungen für die `ibmcloud`-CLI und -Plug-ins verfügbar sind. Halten Sie Ihre CLI stets aktuell, sodass Sie alle verfügbaren Befehle und Flags verwenden können.
-   [Überprüfen Sie auf der {{site.data.keyword.cloud_notm}}-Statusseite ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/status?selected=status), ob {{site.data.keyword.cloud_notm}} verfügbar ist.
-   Veröffentlichen Sie eine Frage im [{{site.data.keyword.containerlong_notm}}-Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com).
    Wenn Sie keine IBM ID für Ihr {{site.data.keyword.cloud_notm}}-Konto verwenden, [fordern Sie eine Einladung](https://cloud.ibm.com/kubernetes/slack) zu diesem Slack an.
    {: tip}
-   Suchen Sie in entsprechenden Foren, ob andere Benutzer auf das gleiche Problem
gestoßen sind. Versehen Sie Ihre Fragen in den Foren mit Tags, um sie für das Entwicklungsteam
von {{site.data.keyword.cloud_notm}} erkennbar zu machen.
    -   Wenn Sie technische Fragen zur Entwicklung oder Bereitstellung von Clustern oder Apps mit {{site.data.keyword.containerlong_notm}} haben, veröffentlichen Sie Ihre Frage auf [Stack Overflow ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) und versehen Sie sie mit den Tags `ibm-cloud`, `kubernetes` und `containers`.
    -   Verwenden Sie bei Fragen zum Service und zu ersten Schritten das Forum [IBM Developer Answers ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Geben Sie die Tags `ibm-cloud` und `containers` an.
    Weitere Details zur Verwendung der Foren finden Sie unter [Hilfe anfordern](/docs/get-support?topic=get-support-getting-customer-support#using-avatar).
-   Wenden Sie sich an den IBM Support, indem Sie einen Fall öffnen. Informationen zum Öffnen eines IBM Supportfalls oder zu Supportstufen und zu Prioritätsstufen von Fällen finden Sie unter [Support kontaktieren](/docs/get-support?topic=get-support-getting-customer-support).
Geben Sie beim Melden eines Problems Ihre Cluster-ID an. Führen Sie den Befehl `ibmcloud ks clusters` aus, um Ihre Cluster-ID abzurufen. Sie können außerdem [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) verwenden, um relevante Informationen aus Ihrem Cluster zu erfassen und zu exportieren, um sie dem IBM Support zur Verfügung zu stellen.
{: tip}

