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

# Datenverkehr anhand von Netzrichtlinien steuern
{: #network_policies}

Jeder Kubernetes-Cluster wird mit einem Netz-Plug-in namens Calico eingerichtet. Standardnetzrichtlinien werden zum Schutz der öffentlichen Netzschnittstelle der einzelnen Workerknoten eingerichtet. Sie können Calico und native
Kubernetes-Funktionen verwenden, um weitere Netzrichtlinien für einen Cluster zu konfigurieren, wenn Sie eindeutige Sicherheitsanforderungen haben. Diese Netzrichtlinien geben Sie den Netzverkehr an, den Sie zu und von einem Pod in einem Cluster zulassen oder blockieren
möchten.
{: shortdesc}

Sie können zwischen Calico und nativen Kubernetes-Funktionen wählen, um Netzrichtlinien für Ihren Cluster zu erstellen. Für den Anfang reichen Kubernetes-Netzrichtlinien aus, aber für stabilere Funktionen sollten Sie
die Calico-Netzrichtlinien verwenden.

<ul>
  <li>[Kubernetes-Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): Es werden grundlegende Optionen bereitgestellt, z. B. das Angeben der Pods, die miteinander kommunizieren können. Eingehender Netzverkehr kann für ein Protokoll und einen Port zugelassen oder blockiert werden. Dieser Datenverkehr kann auf Basis der Bezeichnungen und Kubernetes-Namensbereiche des Pods gefiltert werden, der versucht, eine Verbindung zu anderen Pods herzustellen.</br>Diese Richtlinien
können mithilfe von `kubectl`-Befehlen oder den Kubernetes-APIs angewendet werden. Werden diese Richtlinien angewendet, werden sie in Calico-Netzrichtlinien konvertiert und Calico erzwingt sie.</li>
  <li>[Calico-Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): Diese Richtlinien sind eine Obermenge
der Kubernetes-Netzrichtlinien und erweitern die nativen Kubernetes-Funktionen um die folgenden Features.</li>
    <ul><ul><li>Zulassen oder Blockieren von Netzverkehr in bestimmten Netzschnittstellen, nicht nur Kubernetes-Pod-Datenverkehr.</li>
    <li>Zulassen oder Blockieren eingehenden (Ingress) und ausgehenden (Egress) Netzverkehrs.</li>
    <li>[Blockieren von eingehendem Datenverkehr (Ingress) an die LoadBalancer- oder NodePort-Services von Kubernetes](#block_ingress).</li>
    <li>Zulassen oder Blockieren von Datenverkehr auf der Basis einer Quellen- oder Ziel-IP-Adresse oder -CIDR.</li></ul></ul></br>

Diese Richtlinien werden mithilfe von `calicoctl`-Befehlen angewendet. Calico erzwingt
diese Richtlinien, einschließlich aller Kubernetes-Netzrichtlinien, die in Calico-Richtlinien konvertiert werden, indem 'iptables'-Regeln von Linux in den Kubernetes-Workerknoten konfiguriert werden. 'iptables'-Regeln dienen als
Firewall für den Workerknoten, um die Merkmale zu definieren, die der Netzverkehr erfüllen muss, damit er an die Zielressource weitergeleitet wird.</ul>

<br />


## Standardrichtlinienkonfiguration
{: #default_policy}

Wenn ein Cluster erstellt wird, werden Standardnetzrichtlinien automatisch für die öffentliche Netzschnittstelle
jedes Workerknotens konfiguriert, um eingehenden Datenverkehr für einen Workerknoten aus dem öffentlichen Internet zu begrenzen. Diese Richtlinien wirken sich nicht auf Datenverkehr zwischen Pods aus
und werden konfiguriert, um Zugriff auf den Kubernetes-Knotenport, die Lastausgleichsfunktion und die Ingress-Services zu ermöglichen.
{:shortdesc}

Standardrichtlinien werden nicht direkt auf Pods angewendet. Sie werden mithilfe eines Calico-Host-Endpunkts auf die öffentliche Netzschnittstelle eines Workerknotens angewendet. Wenn ein Host-Endpunkt in Calico erstellt wird, wird der gesamte Datenverkehr zu und von der Netzschnittstelle dieses Workerknotens blockiert, es sei denn, eine Richtlinien lässt diesen Datenverkehr zu.

**Wichtig:** Entfernen Sie keine Richtlinien, die auf einen Host-Endpunkt angewendet sind, es sei denn, Sie kennen die Richtlinie und wissen, dass Sie den Datenverkehr, der durch diese Richtlinie zugelassen wird, nicht benötigen.


 <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
 <caption>Standardrichtlinien für die einzelnen Cluster</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Standardrichtlinien für die einzelnen Cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Lässt den gesamten ausgehenden Datenverkehr zu.</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>Lässt eingehenden Datenverkehr an Port 52311 zur BigFix-App zu, um erforderliche Aktualisierungen für Workerknoten zu ermöglichen.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Lässt eingehende 'icmp'-Pakete (Pings) zu.</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Lässt eingehenden Datenverkehr für den Knotenport, die Lastausgleichsfunktion und den Ingress-Service zu den Pods zu, die diese Services zugänglich machen. Beachten Sie, dass der Port, den diese Services in der öffentlichen
Schnittstelle zugänglich machen, nicht angegeben werden muss, weil Kubernetes DNAT (Destination Network Address Translation, Zielnetzadressumsetzung) verwendet, um diese Serviceanforderungen an die korrekten Pods weiterzuleiten. Diese Weiterleitung findet statt, bevor der Host-Endpunkt in 'iptables' angewendet wird.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Lässt eingehende Verbindungen für bestimmte Systeme von IBM Cloud Infrastructure (SoftLayer) zu, die zum Verwalten der Workerknoten verwendet werden.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Lässt 'vrrp'-Pakete zu, die zum Überwachen und Verschieben von virtuellen IP-Adressen zwischen Workerknoten verwendet werden.</td>
   </tr>
  </tbody>
</table>

<br />


## Netzrichtlinien hinzufügen
{: #adding_network_policies}

In den meisten Fällen müssen die Standardrichtlinien nicht geändert werden. Nur erweiterte Szenarios können unter Umständen Änderungen erforderlich machen. Wenn Sie feststellen, dass Sie Änderungen vornehmen müssen, installieren Sie die Calico-CLI und erstellen Sie Ihre eigenen Netzrichtlinien.
{:shortdesc}

Vorbemerkungen:

1.  [Installieren Sie die {{site.data.keyword.containershort_notm}}- und Kubernetes-CLIs.](cs_cli_install.html#cs_cli_install)
2.  [Erstellen Sie einen Lite-Cluster oder Standardcluster.](cs_clusters.html#clusters_ui)
3.  [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `bx cs cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. In diesem Download sind auch die Schlüssel für die Rolle 'Superuser' enthalten, die Sie zum Ausführen von Calico-Befehlen benötigen.

  ```
  bx cs cluster-config <clustername> --admin
  ```
  {: pre}

  **Hinweis**: Die Calico-CLI-Version 1.6.1 wird unterstützt.

Gehen Sie wie folgt vor, um Netzrichtlinien hinzuzufügen:
1.  Installieren Sie die Calico-CLI.
    1.  [Laden Sie die Calico-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1) herunter.

        **Tipp:** Wenn Sie Windows verwenden, installieren Sie die Calico-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen bei der späteren Ausführung von Befehlen einige Dateipfadänderungen.

    2.  OSX- und Linux-Benutzer müssen die folgenden Schritte ausführen:
        1.  Verschieben Sie die ausführbare Datei in das Verzeichnis '/usr/local/bin'.
            -   Linux:

              ```
              mv /<dateipfad>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS
X:

              ```
              mv /<dateipfad>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Konvertieren Sie die Datei in eine ausführbare Datei.

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Stellen Sie sicher, dass die `calico`-Befehle ordnungsgemäß ausgeführt wurden. Überprüfen Sie dazu die Clientversion der Calico-CLI.

        ```
        calicoctl version
        ```
        {: pre}

2.  Konfigurieren Sie die Calico-CLI.

    1.  Erstellen Sie für Linux und OS X das Verzeichnis `/etc/calico`. Unter Windows kann ein beliebiges Verzeichnis verwendet werden.

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Erstellen Sie die Datei `calicoctl.cfg`.
        -   Linux und OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows: Erstellen Sie die Datei mit einem Texteditor.

    3.  Geben Sie die folgenden Informationen in der Datei <code>calicoctl.cfg</code> ein.

        ```
        apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD-URL>
          etcdKeyFile: <ZERTIFIKATSVERZEICHNIS>/admin-key.pem
          etcdCertFile: <ZERTIFIKATSVERZEICHNIS>/admin.pem
          etcdCACertFile: <ZERTIFIKATSVERZEICHNIS>/<ca-*pem-datei>
        ```
        {: codeblock}

        1.  Rufen Sie die `<ETCD_URL>` ab. Schlägt die Ausführung dieses Befehls mit dem Fehler `calico-config nicht gefunden` fehl, dann lesen Sie die Informationen in diesem [Abschnitt zur Fehlerbehebung](cs_troubleshoot.html#cs_calico_fails).

          -   Linux und OS X:

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   Ausgabebeispiel:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Rufen Sie die Calico-Konfigurationswerte aus der Konfigurationsübersicht ab. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>Suchen Sie im Abschnitt `data` nach dem Wert für 'etcd_endpoints'. Beispiel: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Rufen Sie das Verzeichnis `<CERTS_DIR>` ab. Dies ist das Verzeichnis, in das die Kubernetes-Zertifikate heruntergeladen werden.

            -   Linux und OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                Ausgabebeispiel:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<clustername>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                Ausgabebeispiel:

              ```
              C:/Benutzer/<benutzer>/.bluemix/plugins/container-service/<clustername>-admin/kube-config-prod-<standort>-<clustername>.yml
              ```
              {: screen}

            **Hinweis**: Entfernen Sie den Dateinamen `kube-config-prod-<location>-<cluster_name>.yml` am Ende der Ausgabe, um den Verzeichnispfad zu erhalten.

        3.  Rufen Sie die <code>ca-*pem-datei<code> ab.

            -   Linux und OS X:

              ```
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows:
              <ol><li>Öffnen Sie das Verzeichnis, das Sie im letzten Schritt abgerufen haben.</br><pre class="codeblock"><code>C:\Benutzer\<user>\.bluemix\plugins\container-service\&lt;clustername&gt;-admin\</code></pre>
              <li> Suchen Sie die Datei <code>ca-*pem-datei</code>.</ol>

        4.  Vergewissern Sie sich, dass die Calico-Konfiguration ordnungsgemäß funktioniert.

            -   Linux und OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=<pfad_zu_>/calicoctl.cfg
              ```
              {: pre}

              Ausgabe:

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  Prüfen Sie die vorhandenen Netzrichtlinien.

    -   Zeigen Sie den Calico-Host-Endpunkt an.

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   Zeigen Sie alle Calico- und Kubernetes-Netzrichtlinien an, die für den Cluster erstellt wurden. Diese Liste enthält Richtlinien, die möglicherweise noch nicht auf Pods oder Hosts angewendet wurden. Damit eine Netzrichtlinie
erzwungen wird, muss sie eine Kubernetes-Ressource finden, die mit dem Selektor übereinstimmt, der in der Calico-Netzrichtlinie definiert wurde.

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   Zeigen Sie Details für ein Netzrichtlinie an.

      ```
      calicoctl get policy -o yaml <richtlinienname>
      ```
      {: pre}

    -   Zeigen Sie die Details aller Netzrichtlinien für den Cluster an.

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  Erstellen Sie die Calico-Netzrichtlinien zum Zulassen oder Blockieren von Datenverkehr.

    1.  Definieren Sie Ihre [Calico-Netzrichtlinie ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy), indem Sie ein Konfigurationsscript erstellen (.yaml). Diese Konfigurationsdateien enthalten die Selektoren, die beschreiben, auf welche Pods, Namensbereiche oder Hosts diese Richtlinien angewendet werden. Ziehen Sie diese [Calico-Beispielrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) als Hilfestellung heran, wenn Sie Ihre eigenen erstellen.

    2.  Wenden Sie die Richtlinien auf den Cluster an.
        -   Linux und OS X:

          ```
          calicoctl apply -f <richtliniendateiname.yaml>
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f <pfad_zu_>/<richtliniendateiname.yaml> --config=<pfad_zu_>/calicoctl.cfg
          ```
          {: pre}

<br />


## Eingehenden Datenverkehr zu LoadBalancer- oder NodePort-Services blockieren
{: #block_ingress}

Standardmäßig sind die Kubernetes-Services `NodePort` und `LoadBalancer` so konzipiert, dass Ihre App in allen öffentlichen und privaten Clusterschnittstellen verfügbar ist. Allerdings können Sie den eingehenden Datenverkehr zu Ihren Services auf Basis der Datenverkehrsquelle oder des Ziels blockieren. Zum Blockieren von Datenverkehr müssen Sie Calico-Netzrichtlinien vom Typ `preDNAT` erstellen.
{:shortdesc}

Ein Kubernetes-LoadBalancer-Service stellt auch einen NodePort-Service dar. Ein LoadBalancer-Service stellt Ihre App über die IP-Adresse der Lastausgleichsfunktion und den zugehörigen Port zur Verfügung und macht sie über die Knotenports des Service verfügbar. Auf Knotenports kann über jede IP-Adresse (öffentlich und privat) für jeden Knoten innerhalb des Clusters zugegriffen werden.

Der Clusteradministrator kann die Calico-Netzrichtlinien vom Typ `preDNAT` verwenden, um folgenden Datenverkehr zu blockieren:

  - Den Datenverkehr zu den NodePort-Services. Der Datenverkehr zu LoadBalancer-Services ist zulässig.
  - Den Datenverkehr, der auf einer Quellenadresse oder einem CIDR basiert.

Nachfolgend finden Sie einige gängige Anwendungsbereiche für die Calico-Netzrichtlinien des Typs

  - Blockieren des Datenverkehrs an öffentliche Knotenports eines privaten LoadBalancer-Service.
  - Blockieren des Datenverkehrs an öffentliche Knotenports in Clustern, in denen [Edge-Workerknoten](cs_edge.html#edge) ausgeführt werden. Durch das Blockieren von Knotenports wird sichergestellt, dass die Edge-Workerknoten die einzigen Workerknoten sind, die eingehenden Datenverkehr verarbeiten.

Die Netzrichtlinien vom Typ `preDNAT` sind nützlich, weil die standardmäßigen Kubernetes- und Calico-Richtlinien aufgrund der DNAT-iptables-Regeln, die für die Kubernetes-NodePort- und Kubernetes-LoadBalancer-Services generiert werden, zum Schutz dieser Services schwierig anzuwenden sind.

Die Calico-Netzrichtlinien des Typs `preDNAT` generieren iptables-Regeln auf Basis einer
[Calico-Netzrichtlinienressource ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

1. Definieren Sie eine Calico-Netzrichtlinie vom Typ `preDNAT` für den Ingress-Zugriff auf Kubernetes-Services.

  Beispiel für die Blockierung aller Knotenports:

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. Wenden Sie die Calico-Netzrichtlinie vom Typ 'preDNAT' an. Es dauert ca. eine Minute, bis die Richtlinienänderungen im Cluster angewendet sind.

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}
