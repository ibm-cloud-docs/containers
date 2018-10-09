---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

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

Jeder Kubernetes-Cluster wird mit einem Netz-Plug-in namens Calico eingerichtet. Standardnetzrichtlinien werden zum Schutz der öffentlichen Netzschnittstelle der einzelnen Workerknoten in {{site.data.keyword.containerlong}} eingerichtet.
{: shortdesc}

Wenn Sie spezielle Sicherheitsanforderungen haben oder über einen Mehrfachzonencluster mit aktiviertem VLAN-Spanning verfügen, können Sie Calico und Kubernetes zum Erstellen von Netzrichtlinien für einen Cluster verwenden. Mit Kubernetes-Netzrichtlinien können Sie den Netzverkehr angeben, den Sie zu und von einem Pod in einem Cluster zulassen oder blockieren möchten. Um erweiterte Netzrichtlinien einzurichten, beispielsweise zum Blockieren von eingehendem Datenverkehr (Ingress) an LoadBalancer-Services, verwenden Sie Calico-Netzrichtlinien.

<ul>
  <li>
  [Kubernetes-Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): Diese Richtlinien geben an, wie Pods mit anderen Pods und externen Endpunkten kommunizieren können endpoints. Ab Kubernetes Vrsion 1.8 kann eingehender und abgehender Datenverkehr basierend auf Protokoll, Port, IP-Quellenadressen oder -Zieladressen erlaubt oder blockiert werden. Der Datenverkehr kann zudem anhand von Pod- und Namensbereichsbezeichnungen gefiltert werden. Kubernetes-Netzrichtlinien werden mithilfe von `kubectl`-Befehlen oder den Kubernetes-APIs angewendet. Werden diese Richtlinien angewendet, werden sie automatisch in Calico-Netzrichtlinien konvertiert und Calico erzwingt sie.
  </li>
  <li>
  Calico-Netzrichtlinien für Kubernetes Version [1.10 und höhere Cluster ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) oder [1.9 und frühere Cluster ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): Diese Richtlinien sind eine übergeordnete Gruppe der Kubernetes-Netzrichtlinien und werden mithilfe von Befehlen des Typs `calicoctl` angewendet. Im Rahmen von Calico-Richtlinien werden die folgenden Features hinzugefügt.
    <ul>
    <li>Zulassen oder Blockieren von Netzverkehr in bestimmten Netzschnittstellen, unabhängig von der IP-Quellenadresse oder -Zieladresse von Kubernetes-Pods oder vom CIDR.</li>
    <li>Zulassen oder Blockieren von Netzverkehr für Pods über Namensbereiche hinweg.</li>
    <li>[Blockieren von eingehendem Datenverkehr (Ingress) an die LoadBalancer- oder NodePort-Services von Kubernetes](#block_ingress).</li>
    </ul>
  </li>
  </ul>

Calico erzwingt diese Richtlinien, einschließlich aller Kubernetes-Netzrichtlinien, die automatisch in Calico-Richtlinien konvertiert werden, indem 'iptables'-Regeln von Linux in den Kubernetes-Workerknoten konfiguriert werden. 'iptables'-Regeln dienen als
Firewall für den Workerknoten, um die Merkmale zu definieren, die der Netzverkehr erfüllen muss, damit er an die Zielressource weitergeleitet wird.

Um Ingress- and LoadBalancer-Services zu verwenden, greifen Sie bei der Verwaltung des Netzverkehrs für Ihren Cluster auf Calico- and Kubernetes-Richtlinien zurück. Verwenden Sie dazu nicht [Sicherheitsgruppen](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups) der IBM Cloud-Infrastruktur (SoftLayer). Die Sicherheitsgruppen der IBM Cloud-Infrastruktur (SoftLayer) werden auf die Netzschnittstelle eines einzelnen virtuellen Servers angewendet, um den Datenverkehr auf Hypervisor-Ebene zu filtern. Sicherheitsgruppen unterstützen jedoch nicht das VRRP-Protokoll (VRRP – Virtual Router Redundancy Protocol), das von {{site.data.keyword.containerlong_notm}} zum Verwalten der LoadBalancer-IP-Adresse verwendet wird. Wenn das VRRP-Protokoll nicht zur Verwaltung der LoadBalancer-IP, der Ingress- und LoadBalancer-Services zur Verfügung steht, funktionieren die Services nicht ordnungsgemäß.
{: tip}

<br />


## Standardmäßige Calico- und Kubernetes-Netzrichtlinien
{: #default_policy}

Wenn ein Cluster mit einem öffentlichen VLAN erstellt wird, wird für jeden Workerknoten und die entsprechende öffentliche Netzschnittstelle automatisch eine Host-Endpunkt-Ressource mit der Bezeichnung `ibm.role: worker_public` erstellt. Um die öffentliche Netzschnittstelle eines Workerknotens zu schützen, werden Calico-Standardrichtlinien auf alle Host-Endpunkte mit der Bezeichnung `ibm.role: worker_public` angewendet.
{:shortdesc}

Diese Calico-Standardrichtlinien lassen sämtlichen ausgehenden und eingehenden Netzdatenverkehr zu bestimmten Clusterkomponenten, wie NodePort-, LoadBalancer- und Ingress-Services von Kubernetes, zu. Jeglicher eingehender Netzdatenverkehr aus dem Internet zu den Workerknoten, der nicht in den Standardrichtlinien festgelegt ist, wird blockiert. Die Standardrichtlinien wirken sich nicht auf Datenverkehr zwischen Pods aus.

Sehen Sie sich die folgenden Calico-Standardnetzrichtlinien an, die automatisch auf Ihren Cluster angewendet werden.

**Wichtig:** Entfernen Sie keine Richtlinien, die auf einen Host-Endpunkt angewendet sind, es sei denn, Sie kennen die Richtlinie. Vergewissern Sie sich, dass Sie den Datenverkehr, der durch diese Richtlinie zugelassen wird, nicht benötigen.

 <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die verbleibenden Zeilen enthalten von links nach rechts die jeweilige Serverzone in der ersten Spalte und die entsprechenden IP-Adressen in der zweiten Spalte.">
 <caption>Calico-Standardrichtlinien für die einzelnen Cluster</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Calico-Standardrichtlinien für die einzelnen Cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Lässt den gesamten ausgehenden Datenverkehr zu.</td>
    </tr>
    <tr>
      <td><code>allow-bigfix-port</code></td>
      <td>Lässt eingehenden Datenverkehr an Port 52311 zur BigFix-App zu, um erforderliche Aktualisierungen für Workerknoten zu ermöglichen.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Lässt eingehende 'ICMP-Pakete (Pings) zu.</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Lässt eingehenden Datenverkehr für den NodePort-, LoadBalancer- und Ingress-Service zu den Pods zu, die diese Services zugänglich machen. <strong>Hinweis</strong>: Sie müssen die zugänglich gemachten Ports nicht angeben, weil Kubernetes DNAT (Destination Network Address Translation, Zielnetzadressumsetzung) verwendet, um die Serviceanforderungen an die korrekten Pods weiterzuleiten. Diese Weiterleitung findet statt, bevor der Host-Endpunkt in 'iptables' angewendet wird.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Lässt eingehende Verbindungen für bestimmte Systeme der IBM Cloud-Infrastruktur (SoftLayer) zu, die zum Verwalten der Workerknoten verwendet werden.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Lässt VRRP-Pakete zu, die zum Überwachen und Verschieben von virtuellen IP-Adressen zwischen Workerknoten verwendet werden.</td>
   </tr>
  </tbody>
</table>

In Clustern der Kubernetes Version 1.10 und höher wird auch eine Kubernetes-Standardrichtlinie erstellt, die den Zugriff auf das Kubernetes-Dashboard begrenzt. Kubernetes-Richtlinien gelten nicht für den Host-Endpunkt, sondern für den Pod `kube-dashboard`. Diese Richtlinie wird auf Cluster angewendet, die ausschließlich mit einem privaten VLAN verbunden sind, sowie Cluster, die mit einem öffentlichen und einem privaten VLAN verbunden sind.

<table>
<caption>Kubernetes-Standardrichtlinien für die einzelnen Cluster</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Kubernetes-Standardrichtlinien für die einzelnen Cluster</th>
</thead>
<tbody>
 <tr>
  <td><code>kubernetes-dashboard</code></td>
  <td><b>Nur in Kubernetes Version 1.10</b> im Namensbereich <code>kube-system</code>: Blockiert für alle Pods den Zugriff auf das Kubernetes-Dashboard. Diese Richtlinie hat keinerlei Auswirkungen auf den Zugriff auf das Dashboard über die {{site.data.keyword.Bluemix_notm}}-Benutzerschnittstelle oder mithilfe von <code>kubectl proxy</code>. Wenn ein Pod Zugriff auf das Dashboard benötigt, stellen Sie den Pod in einem Namensbereich mit der Bezeichnung <code>kubernetes-dashboard-policy: allow</code> bereit.</td>
 </tr>
</tbody>
</table>

<br />


## Calico CLI installieren und konfigurieren
{: #cli_install}

Installieren und konfigurieren Sie die Calico-CLI zum Anzeigen, Verwalten und Hinzufügen von Calico-Richtlinien.
{:shortdesc}

Die Kompatibilität von Calico-Versionen für die CLI-Konfiguration und Richtlinien hängt von der Kubernetes-Version des Clusters ab. Um die Calico-CLI zu installieren und konfigurieren, klicken Sie basierend auf Ihrer Clusterversion auf einen der nachfolgenden Links:

* [Kubernetes Version 1.10 oder höhere Cluster](#1.10_install)
* [Kubernetes Version 1.10 oder frühere Cluster](#1.9_install)

Bevor Sie Ihren Cluster von Kubernetes Version 1.9 oder einer früheren Version auf Version 1.10 oder höher aktualisieren, ziehen Sie den Abschnitt [Vorbereitungen für die Aktualisierung auf Calico Version 3](cs_versions.html#110_calicov3) zurate.
{: tip}

### Version 3.1.1 der Calico-CLI für Cluster installieren und konfigurieren, die Kubernetes Version 1.10 oder höher ausführe
{: #1.10_install}

Führen Sie zunächst folgende Schritte aus. [Richten Sie die Kubernetes-CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `ibmcloud ks cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. Dieser Download umfasst auch die Schlüssel für den Zugriff auf Ihr Infrastrukturportfolio und zur Ausführung von Calico-Befehlen auf Ihren Workerknoten.

  ```
  ibmcloud ks cluster-config <clustername> --admin
  ```
  {: pre}

Gehen Sie wie folgt vor, um die Calico-CLI der Version 3.1.1 zu installieren und konfigurieren:

1. [Laden Sie die Calico-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/projectcalico/calicoctl/releases/tag/v3.1.1) herunter.

    Wenn Sie OSX verwenden, laden Sie die Version `-darwin-amd64` herunter. Wenn Sie Windows verwenden, installieren Sie die Calico-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen bei der späteren Ausführung von Befehlen einige Dateipfadänderungen. Stellen Sie sicher, dass die Datei als `calicoctl.exe` gespeichert wird.
    {: tip}

2. OSX- und Linux-Benutzer müssen die folgenden Schritte ausführen:
    1. Verschieben Sie die ausführbare Datei in das Verzeichnis _/usr/local/bin_.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS
X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. Konvertieren Sie die Datei in eine ausführbare Datei.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Stellen Sie sicher, dass die `calico`-Befehle ordnungsgemäß ausgeführt wurden. Überprüfen Sie dazu die Clientversion der Calico-CLI.

    ```
    calicoctl version
    ```
    {: pre}

4. Falls Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls verhindert, [lassen Sie TCP-Zugriff für Calico-Befehle zu](cs_firewall.html#firewall).

5. Erstellen Sie für Linux und OS X das Verzeichnis `/etc/calico`. Unter Windows kann ein beliebiges Verzeichnis verwendet werden.

  ```
  sudo mkdir -p /etc/calico/
  ```
  {: pre}

6. Erstellen Sie die Datei `calicoctl.cfg`.
    - Linux und OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: Erstellen Sie die Datei mit einem Texteditor.

7. Geben Sie die folgenden Informationen in der Datei <code>calicoctl.cfg</code> ein.

    ```
    apiVersion: projectcalico.org/v3
    kind: CalicoAPIConfig
    metadata:
    spec:
        datastoreType: etcdv3
        etcdEndpoints: <ETCD_URL>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. Rufen Sie die `<ETCD_URL>` ab.

      - Linux und OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

          Beispielausgabe:

          ```
          https://169.xx.xxx.xxx:30000
          ```
          {: screen}

      - Windows:
        <ol>
        <li>Rufen Sie die Calico-Konfigurationswerte aus der Konfigurationszuordnung ab. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>Suchen Sie im Abschnitt `data` nach dem Wert für 'etcd_endpoints'. Beispiel: <code>https://169.xx.xxx.xxx:30000</code>
        </ol>

    2. Rufen Sie das Verzeichnis `<CERTS_DIR>` ab. Dies ist das Verzeichnis, in das die Kubernetes-Zertifikate heruntergeladen werden.

        - Linux und OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          Beispielausgabe:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<clustername>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

            Ausgabebeispiel:

          ```
          C:/Users/<benutzer>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **Hinweis**: Entfernen Sie den Dateinamen `kube-config-prod-<zone>-<cluster_name>.yml` am Ende der Ausgabe, um den Verzeichnispfad zu erhalten.

    3. Rufen Sie die `ca-*pem-datei` ab.

        - Linux und OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>Öffnen Sie das Verzeichnis, das Sie im letzten Schritt abgerufen haben.</br><pre class="codeblock"><code>C:\Benutzer\<user>\.bluemix\plugins\container-service\&lt;clustername&gt;-admin\</code></pre>
          <li> Suchen Sie die Datei <code>ca-*pem-datei</code>.</ol>

8. Speichern Sie die Datei und stellen Sie sicher, dass Sie sich in dem Verzeichnis befinden, in dem sich die Datei befindet.

9. Vergewissern Sie sich, dass die Calico-Konfiguration ordnungsgemäß funktioniert.

    - Linux und OS X:

      ```
      calicoctl get nodes
      ```
      {: pre}

    - Windows:

      ```
      calicoctl get nodes --config=filepath/calicoctl.cfg
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


### Version 1.6.3 der Calico-CLI für Cluster installieren und konfigurieren, die Kubernetes Version 1.9 oder früher ausführe
{: #1.9_install}

Führen Sie zunächst folgende Schritte aus. [Richten Sie die Kubernetes-CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `ibmcloud ks cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. Dieser Download umfasst auch die Schlüssel für den Zugriff auf Ihr Infrastrukturportfolio und zur Ausführung von Calico-Befehlen auf Ihren Workerknoten.

  ```
  ibmcloud ks cluster-config <clustername> --admin
  ```
  {: pre}

Gehen Sie wie folgt vor, um die Calico-CLI der Version 1.6.3 zu installieren und konfigurieren:

1. [Laden Sie die Calico-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.3) herunter.

    Wenn Sie OSX verwenden, laden Sie die Version `-darwin-amd64` herunter. Wenn Sie Windows verwenden, installieren Sie die Calico-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen bei der späteren Ausführung von Befehlen einige Dateipfadänderungen.
    {: tip}

2. OSX- und Linux-Benutzer müssen die folgenden Schritte ausführen:
    1. Verschieben Sie die ausführbare Datei in das Verzeichnis _/usr/local/bin_.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS
X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. Konvertieren Sie die Datei in eine ausführbare Datei.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Stellen Sie sicher, dass die `calico`-Befehle ordnungsgemäß ausgeführt wurden. Überprüfen Sie dazu die Clientversion der Calico-CLI.

    ```
    calicoctl version
    ```
    {: pre}

4. Falls Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls verhindern, müssen Sie TCP-Zugriff für die Calico-Befehle zulassen. Weitere Informationen hierzu finden Sie unter [`calicoctl`-Befehle hinter einer Firewall ausführen](cs_firewall.html#firewall).

5. Erstellen Sie für Linux und OS X das Verzeichnis `/etc/calico`. Unter Windows kann ein beliebiges Verzeichnis verwendet werden.
    ```
    sudo mkdir -p /etc/calico/
    ```
    {: pre}

6. Erstellen Sie die Datei `calicoctl.cfg`.
    - Linux und OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: Erstellen Sie die Datei mit einem Texteditor.

7. Geben Sie die folgenden Informationen in der Datei <code>calicoctl.cfg</code> ein.

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

    1. Rufen Sie die `<ETCD_URL>` ab.

      - Linux und OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

      - Ausgabebeispiel:

          ```
          https://169.xx.xxx.xxx:30001
          ```
          {: screen}

      - Windows:
        <ol>
        <li>Rufen Sie die Calico-Konfigurationswerte aus der Konfigurationszuordnung ab. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>Suchen Sie im Abschnitt `data` nach dem Wert für 'etcd_endpoints'. Beispiel: <code>https://169.xx.xxx.xxx:30001</code>
        </ol>

    2. Rufen Sie das Verzeichnis `<CERTS_DIR>` ab. Dies ist das Verzeichnis, in das die Kubernetes-Zertifikate heruntergeladen werden.

        - Linux und OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          Beispielausgabe:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<clustername>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

          Beispielausgabe:

          ```
          C:/Users/<benutzer>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **Hinweis**: Entfernen Sie den Dateinamen `kube-config-prod-<zone>-<cluster_name>.yml` am Ende der Ausgabe, um den Verzeichnispfad zu erhalten.

    3. Rufen Sie die `ca-*pem-datei` ab.

        - Linux und OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>Öffnen Sie das Verzeichnis, das Sie im letzten Schritt abgerufen haben.</br><pre class="codeblock"><code>C:\Benutzer\<user>\.bluemix\plugins\container-service\&lt;clustername&gt;-admin\</code></pre>
          <li> Suchen Sie die Datei <code>ca-*pem-datei</code>.</ol>

    4. Vergewissern Sie sich, dass die Calico-Konfiguration ordnungsgemäß funktioniert.

        - Linux und OS X:

          ```
          calicoctl get nodes
          ```
          {: pre}

        - Windows:

          ```
          calicoctl get nodes --config=filepath/calicoctl.cfg
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

          **Wichtig**: Windows- und OS X-Benutzer müssen jedes Mal, wenn Sie einen Befehl des Typs `calicoctl` ausführen, das Flag `--config=filepath/calicoctl.cfg` einschließen.

<br />


## Netzrichtlinien anzeigen
{: #view_policies}

Zeigen Sie die Details für Standardrichtlinien und allen weiteren hinzugefügten Netzrichtlinien an, die auf Ihren Cluster angewendet werden.
{:shortdesc}

Vorbemerkungen:
1. [Installieren und konfigurieren Sie die Calico-CLI.](#cli_install)
2. [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `ibmcloud ks cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. Dieser Download umfasst auch die Schlüssel für den Zugriff auf Ihr Infrastrukturportfolio und zur Ausführung von Calico-Befehlen auf Ihren Workerknoten.
    ```
    ibmcloud ks cluster-config <clustername> --admin
    ```
    {: pre}

Die Kompatibilität von Calico-Versionen für die CLI-Konfiguration und Richtlinien hängt von der Kubernetes-Version des Clusters ab. Um die Calico-CLI zu installieren und konfigurieren, klicken Sie basierend auf Ihrer Clusterversion auf einen der nachfolgenden Links:

* [Kubernetes Version 1.10 oder höhere Cluster](#1.10_examine_policies)
* [Kubernetes Version 1.10 oder frühere Cluster](#1.9_examine_policies)

Bevor Sie Ihren Cluster von Kubernetes Version 1.9 oder einer früheren Version auf Version 1.10 oder höher aktualisieren, ziehen Sie den Abschnitt [Vorbereitungen für die Aktualisierung auf Calico Version 3](cs_versions.html#110_calicov3) zurate.
{: tip}

### Netzrichtlinien in Clustern anzeigen, die Kubernetes Version 1.10 oder höher ausführen
{: #1.10_examine_policies}

Linux- und Mac-Benutzer müssen das Flag `--config=filepath/calicoctl.cfg` nicht in Befehle des Typs `calicoctl` einschließen.
{: tip}

1. Zeigen Sie den Calico-Host-Endpunkt an.

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. Zeigen Sie alle Calico- und Kubernetes-Netzrichtlinien an, die für den Cluster erstellt wurden. Diese Liste enthält Richtlinien, die möglicherweise noch nicht auf Pods oder Hosts angewendet wurden. Damit eine Netzrichtlinie erzwungen wird, muss eine Kubernetes-Ressource gefunden werden, die mit dem Selektor übereinstimmt, der in der Calico-Netzrichtlinie definiert wurde.

    [Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) beziehen sich auf bestimmte Namensbereiche:
    ```
    calicoctl get NetworkPolicy --all-namespaces -o wide --config=filepath/calicoctl.cfg
    ```
    {:pre}

    [Globale Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) beziehen sich nicht auf bestimmte Namensbereiche:
    ```
    calicoctl get GlobalNetworkPolicy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Zeigen Sie Details für ein Netzrichtlinie an.

    ```
    calicoctl get NetworkPolicy -o yaml <richtlinienname> --namespace <namensbereich_für_richtlinie> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. Zeigen Sie die Details aller globalen Netzrichtlinien für den Cluster an.

    ```
    calicoctl get GlobalNetworkPolicy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

### Netzrichtlinien in Clustern anzeigen, die Kubernetes Version 1.9 oder früher ausführen
{: #1.9_examine_policies}

Linux-Benutzer müssen das Flag `--config=filepath/calicoctl.cfg` nicht in Befehle des Typs `calicoctl` einschließen.
{: tip}

1. Zeigen Sie den Calico-Host-Endpunkt an.

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. Zeigen Sie alle Calico- und Kubernetes-Netzrichtlinien an, die für den Cluster erstellt wurden. Diese Liste enthält Richtlinien, die möglicherweise noch nicht auf Pods oder Hosts angewendet wurden. Damit eine Netzrichtlinie erzwungen wird, muss eine Kubernetes-Ressource gefunden werden, die mit dem Selektor übereinstimmt, der in der Calico-Netzrichtlinie definiert wurde.

    ```
    calicoctl get policy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Zeigen Sie Details für ein Netzrichtlinie an.

    ```
    calicoctl get policy -o yaml <richtlinienname> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. Zeigen Sie die Details aller Netzrichtlinien für den Cluster an.

    ```
    calicoctl get policy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

<br />


## Netzrichtlinien hinzufügen
{: #adding_network_policies}

In den meisten Fällen müssen die Standardrichtlinien nicht geändert werden. Nur erweiterte Szenarios können unter Umständen Änderungen erforderlich machen. Wenn Sie feststellen, dass Sie Änderungen vornehmen müssen, können Sie Ihre eigenen Netzrichtlinien erstellen.
{:shortdesc}

Informationen zum Erstellen von Kubernetes-Netzrichtlinien finden Sie in der [Dokumentation zu Kubernetes-Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

Um Calico-Richtlinien zu erstellen, führen Sie die folgenden Schritte aus.

Vorbemerkungen:
1. [Installieren und konfigurieren Sie die Calico-CLI.](#cli_install)
2. [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `ibmcloud ks cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. Dieser Download umfasst auch die Schlüssel für den Zugriff auf Ihr Infrastrukturportfolio und zur Ausführung von Calico-Befehlen auf Ihren Workerknoten.
    ```
    ibmcloud ks cluster-config <clustername> --admin
    ```
    {: pre}

Die Kompatibilität von Calico-Versionen für die CLI-Konfiguration und Richtlinien hängt von der Kubernetes-Version des Clusters ab. Klicken Sie basierend auf Ihrer Clusterversion auf einen der nachfolgenden Links:

* [Kubernetes Version 1.10 oder höhere Cluster](#1.10_create_new)
* [Kubernetes Version 1.10 oder frühere Cluster](#1.9_create_new)

Bevor Sie Ihren Cluster von Kubernetes Version 1.9 oder einer früheren Version auf Version 1.10 oder höher aktualisieren, ziehen Sie den Abschnitt [Vorbereitungen für die Aktualisierung auf Calico Version 3](cs_versions.html#110_calicov3) zurate.
{: tip}

### Calico-Richtlinien in Clustern hinzufügen, die Kubernetes Version 1.10 oder höher ausführen
{: #1.10_create_new}

1. Definieren Sie die Calico-[Netzrichtlinie ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) oder [globale Netzrichtline ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy), indem Sie ein Konfigurationsscript (`.yaml`) erstellen. Diese Konfigurationsdateien enthalten die Selektoren, die beschreiben, auf welche Pods, Namensbereiche oder Hosts diese Richtlinien angewendet werden. Ziehen Sie diese [Calico-Beispielrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) als Hilfestellung heran, wenn Sie Ihre eigenen erstellen.
    **Hinweis**: Cluster der Kubernetes Version 1.10 oder höher müssen die Syntax für Calico Version 3-Richtlinien verwenden.

2. Wenden Sie die Richtlinien auf den Cluster an.
    - Linux und OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

### Calico-Richtlinien in Clustern hinzufügen, die Kubernetes Version 1.9 oder früher ausführen
{: #1.9_create_new}

1. Definieren Sie Ihre [Calico-Netzrichtlinie ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy), indem Sie ein Konfigurationsscript erstellen (`.yaml`). Diese Konfigurationsdateien enthalten die Selektoren, die beschreiben, auf welche Pods, Namensbereiche oder Hosts diese Richtlinien angewendet werden. Ziehen Sie diese [Calico-Beispielrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) als Hilfestellung heran, wenn Sie Ihre eigenen erstellen.
    **Hinweis**: Cluster der Kubernetes Version 1.9 oder früher müssen die Syntax für Calico Version 2-Richtlinien verwenden.


2. Wenden Sie die Richtlinien auf den Cluster an.
    - Linux und OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

<br />


## Eingehenden Datenverkehr zu LoadBalancer- oder NodePort-Services steuern
{: #block_ingress}

[Standardmäßig](#default_policy) sind die NodePort- und LoadBalancer-Services von Kubernetes so konzipiert, dass Ihre App in allen öffentlichen und privaten Clusterschnittstellen verfügbar ist. Sie können jedoch die Richtlinien von Calico verwenden, um den eingehenden Datenverkehr auf Basis der Datenverkehrsquelle oder des Ziels zu blockieren.
{:shortdesc}

Ein Kubernetes-LoadBalancer-Service stellt auch einen NodePort-Service dar. Ein LoadBalancer-Service stellt Ihre App über die IP-Adresse der Lastausgleichsfunktion und den zugehörigen Port zur Verfügung und macht sie über die Knotenports des Service verfügbar. Auf Knotenports kann über jede IP-Adresse (öffentlich und privat) für jeden Knoten innerhalb des Clusters zugegriffen werden.

Der Clusteradministrator kann die Calico-Netzrichtlinien vom Typ `preDNAT` verwenden, um folgenden Datenverkehr zu blockieren:

  - Den Datenverkehr zu den NodePort-Services. Der Datenverkehr zu LoadBalancer-Services ist zulässig.
  - Den Datenverkehr, der auf einer Quellenadresse oder einem CIDR basiert.

Nachfolgend finden Sie einige gängige Anwendungsbereiche für die Calico-Netzrichtlinien des Typs

  - Blockieren des Datenverkehrs an öffentliche Knotenports eines privaten LoadBalancer-Service.
  - Blockieren des Datenverkehrs an öffentliche Knotenports in Clustern, in denen [Edge-Workerknoten](cs_edge.html#edge) ausgeführt werden. Durch das Blockieren von Knotenports wird sichergestellt, dass die Edge-Workerknoten die einzigen Workerknoten sind, die eingehenden Datenverkehr verarbeiten.

Die standardmäßigen Kubernetes- und Calico-Richtlinien sind aufgrund der DNAT-iptables-Regeln, die für die Kubernetes-NodePort- und Kubernetes-LoadBalancer-Services generiert werden, zum Schutz dieser Services schwierig anzuwenden.

Calico-Netzrichtlinien des Typs `preDNAT` können Ihnen helfen, da sie iptables-Regeln auf Basis einer Calico-Netzrichtlinienressource
generieren. Cluster der Kubernetes Version 1.10 oder höher verwenden [Netzrichtlinien mit der Version 3-Syntax von `calicoctl.cfg` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy). Cluster der Kubernetes Version 1.9 oder früher verwenden [Richtlinien mit der Version 2-Syntax von `calicoctl.cfg` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

1. Definieren Sie eine Calico-Netzrichtlinie vom Typ `preDNAT` für den Ingress-Zugriff (eingehenden Datenverkehr) auf Kubernetes-Services.

    * Cluster der Kubernetes Version 1.10 oder höher müssen die Syntax für Calico Version 3-Richtlinien verwenden.

        Beispielressource, die alle NodePorts-Services blockiert:

        ```
        apiVersion: projectcalico.org/v3
        kind: GlobalNetworkPolicy
        metadata:
          name: deny-nodeports
        spec:
          applyOnForward: true
          ingress:
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: TCP
            source: {}
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: UDP
            source: {}
          preDNAT: true
          selector: ibm.role=='worker_public'
          order: 1100
          types:
          - Ingress
        ```
        {: codeblock}

    * Cluster der Kubernetes Version 1.9 oder früher müssen die Syntax für Calico Version 2-Richtlinien verwenden.

        Beispielressource, die alle NodePorts-Services blockiert:

        ```
        apiVersion: v1
        kind: policy
        metadata:
          name: deny-nodeports
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

  - Linux und OS X:

    ```
    calicoctl apply -f deny-nodeports.yaml
    ```
    {: pre}

  - Windows:

    ```
    calicoctl apply -f filepath/deny-nodeports.yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Optional: In Mehrzonenclustern überprüft ein MZLB-Status die ALBs in jeder Zone des Clusters und hält die Ergebnisse der DNS-Suche auf der Basis dieser Zustandsprüfungen aktualisiert. Wenn Sie die preDNAT-Richtlinien verwenden, um den gesamten eingehenden Datenverkehr zu Ingress-Services zu blockieren, müssen Sie auch die [Cloudflare-IPv4-IPs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.cloudflare.com/ips/), die zur Überprüfung des Status Ihrer ALBs verwendet werden, in die Whitelist stellen. Informationen zum Erstellen einer Calico-preDNAT-Richtlinie für die Whitelist für diese IPs finden Sie unter Lerneinheit 3 des Lernprogramms [ Calico-Netzrichtlinie ](cs_tutorials_policies.html#lesson3).

Um zu erfahren, wie Sie Quellen-IP-Adressen in Whitelists oder Blacklists aufnehmen, sehen Sie sich das [Lernprogramm zur Verwendung von Calico-Netzrichtlinien zum Blockieren von Datenverkehr](cs_tutorials_policies.html#policy_tutorial) an. Weitere Beispiele für Calico-Netzrichtlinien, die den Datenverkehr zu und von Ihrem Cluster steuern, finden Sie in der [Demo zur stars-Richtlinie ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) und in der [Demo zur erweiterten Richtlinie ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy).
{: tip}

## Cluster im privaten Netz isolieren
{: #isolate_workers}

Wenn Sie einen Mehrzonencluster, mehrere VLANs für einen Einzelzonencluster oder mehrere Teilnetze in demselben VLAN haben, müssen Sie das [VLAN-Spanning aktivieren](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning), damit Ihre Workerknoten miteinander im privaten Netz kommunizieren können. Wenn das VLAN-Spanning aktiviert ist, kann jedes System, das mit einem der privaten VLANs in demselben IBM Cloud-Konto verbunden ist, mit Workern kommunizieren.

Sie können Ihren Cluster von anderen Systemen im privaten Netz mithilfe von [Calico-Richtlinien für private Netze ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/private-network-isolation) isolieren. Diese Gruppe von Calico-Richtlinien und -Hostendpunkten isoliert den privaten Netzdatenverkehr eines Clusters von anderen Ressourcen im privaten Netz des Kontos.

Die Richtlinien zielen auf die private Schnittstelle des Workerknotens (eth0) und das Podnetz eines Clusters ab.

**Workerknoten**

* Abgehender Datenverkehr an der privaten Schnittstelle ist nur für Pod-IPs, Workers in diesem Cluster und den UPD/TCP-Port 53 für den DNS-Zugang zulässig.
* Eingehender Datenverkehr an der privaten Schnittstelle ist nur von Workern in dem Cluster und nur an DNS, kubelet, ICMP und VRRP zulässig.

**Pods**

* Der gesamte eingehende Datenverkehr an Pods von den Workern im Cluster wird zugelassen.
* Der abgehende Datenverkehr von Pods wird nur auf öffentliche IPs, DNS, kubelet und andere Pods im Cluster beschränkt.

Vorbereitende Schritte:
1. [Installieren und konfigurieren Sie die Calico-CLI.](#cli_install)
2. [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `ibmcloud ks cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. Dieser Download umfasst auch die Schlüssel für den Zugriff auf Ihr Infrastrukturportfolio und zur Ausführung von Calico-Befehlen auf Ihren Workerknoten.
    ```
    ibmcloud ks cluster-config <clustername> --admin
    ```
    {: pre}

Gehen Sie wie folgt vor, um Ihren Cluster mithilfe von Calico-Richtlinien im privaten Netz zu isolieren

1. Klonen Sie das Repository `IBM-Cloud/kube-samples`.
    ```
    git clone https://github.com/IBM-Cloud/kube-samples.git
    ```
    {: pre}

2. Navigieren Sie zum Verzeichnis mit den Richtlinien für private Netze für die Calico-Version, mit der Ihre Clusterversion kompatibel ist.
    * Cluster mit Kubernetes Version 1.10 oder höher:
      ```
      cd <dateipfad>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v3
      ```
      {: pre}

    * Cluster mit Kubernetes Version 1.9 oder früher:
      ```
      cd <dateipfad>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v2
      ```
      {: pre}

3. Richten Sie die Richtlinie für den privaten Hostendpunkt ein.
    1. Öffnen Sie die Richtlinie `generic-privatehostendpoint.yaml`.
    2. Ersetzen Sie `<worker_name>` durch den Namen eines Workerknotens und `<worker-node-private-ip>` durch die private IP-Adresse für den Workerknoten. Wenn Sie die privaten IPs Ihrer Workerknoten anzeigen wollen, führen Sie `ibmcloud ks workers --cluster <mein_cluster>` aus.
    3. Wiederholen Sie diesen Schritt in einem neuen Abschnitt für jeden Workerknoten in Ihrem Cluster.
    **Hinweis**: Jedes Mal, wenn Sie einen Workerknoten zu einem Cluster hinzufügen, müssen Sie die Hostendpunktdatei mit den neuen Einträgen aktualisieren.

4. Wenden Sie alle Richtlinien auf Ihren Cluster an.
    - Linux und OS X:

      ```
      calicoctl apply -f allow-all-workers-private.yaml
      calicoctl apply -f allow-dns-10250.yaml
      calicoctl apply -f allow-egress-pods.yaml
      calicoctl apply -f allow-icmp-private.yaml
      calicoctl apply -f allow-vrrp-private.yaml
      calicoctl apply -f generic-privatehostendpoint.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f allow-all-workers-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-dns-10250.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-egress-pods.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-icmp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-vrrp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f generic-privatehostendpoint.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

## Datenverkehr zwischen Pods steuern
{: #isolate_services}

Kubernetes-Richtlinien schützen Pods vor internem Netzdatenverkehr. Sie können einfache Kubernetes-Netzrichtlinien erstellen, um die App-Mikroservices innerhalb eines Namensbereichs oder über Namensbereiche hinweg voneinander zu trennen.
{: shortdesc}

Weitere Informationen darüber, wie Kubernetes-Netzrichtlinien Pod-zu-Pod-Datenverkehr steuern, sowie weitere Beispielrichtlinien finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
{: tip}

### App-Services in einem Namensbereich isolieren
{: #services_one_ns}

Das folgende Szenario veranschaulicht, wie der Datenverkehr zwischen App-Mikroservices in einem Namensbereich verwaltet wird.

Ein Team 'Accounts' stellt mehrere App-Services in einem Namensbereich bereit. Diese müssen jedoch isoliert werden, um nur die erforderliche Kommunikation zwischen den Mikroservices über das öffentliche Netz zu ermöglichen. Für die App 'Srv1' verfügt das Team über Front-End-, Back-End- und Datenbankservices. Jeder Service erhält die Bezeichnung `App: Srv1` sowie die Bezeichnung `Tier: Front-End`, `Tier: Back-End` oder `Tier: db`.

<img src="images/cs_network_policy_single_ns.png" width="200" alt="Verwenden Sie eine Netzrichtlinie, um den bereichsübergreifenden Datenverkehr zu verwalten." style="width:200px; border-style: none"/>

Das Team 'Accounts' möchte Datenverkehr vom Front-End zum Back-End und vom Back-End zur Datenbank zulassen. Es verwendet Bezeichnungen in den Netzrichtlinien, um festzulegen, welche Datenflüsse zwischen den Mikroservices zulässig sind.

Zunächst erstellt das Team eine Kubernetes-Netzrichtlinie, die den Datenverkehr vom Frontend zum Back-End ermöglicht:

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: backend-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: frontend
```
{: codeblock}

Im Abschnitt `spec.podSelector.matchLabels` sind die Bezeichnungen für den Back-End-Service für Srv1 aufgeführt, sodass die Richtlinie nur _für_ diese Pods gilt. Im Abschnitt ` spec.ingress.from.podSelector.matchLabels ` werden die Bezeichnungen für den Front-End-Service für Srv1 aufgelistet, sodass Ingress nur _über_ diese Pods zugelassen wird.

Anschließend erstellt das Team eine ähnliche Kubernetes-Netzrichtlinie, die den Datenverkehr vom Back-End zur Datenbank zulässt:

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: db-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: db
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: backend
  ```
  {: codeblock}

Im Abschnitt `spec.podSelector.matchLabels` sind die Bezeichnungen für den Datenbankservice für Srv1 aufgeführt, sodass die Richtlinie nur _für_ diese Pods gilt. Im Abschnitt `spec.ingress.from.podSelector.matchLabels` werden die Bezeichnungen für den Back-End-Service für Srv1 aufgelistet, sodass Ingress nur _über_ diese Pods zugelassen wird.

Der Datenverkehr kann nun vom Front-End zum Back-End und vom Back-End zur Datenbank fließen. Die Datenbank kann auf das Back-End reagieren und das Back-End auf das Front-End; es können jedoch keine reversen Datenverkehrsverbindungen aufgebaut werden.

### App-Services zwischen Namensbereichen isolieren
{: #services_across_ns}

Im folgenden Szenario wird gezeigt, wie der Datenverkehr zwischen App-Mikroservices über mehrere Namensbereiche hinweg verwaltet wird.

Services, deren Eigner verschiedene untergeordnete Teams sind, müssen kommunizieren, die Services werden aber in unterschiedlichen Namensbereichen innerhalb desselben Clusters implementiert. Das Team 'Accounts' implementiert Front-End-, Back-End- und Datenbankservices für die App 'Srv1' im Namensbereich 'Account'. Das Team 'Finance' implementiert Front-End-, Back-End- und Datenbankservices für die App 'Srv2' im Namensbereich 'Finance'. Jeder Service erhält von den Teams die Bezeichnung `App: Srv1` oder `App: Srv2` sowie die Bezeichnung `Tier: Front-End`, `Tier: Back-End` oder `Tier: db`. Außerdem werden die Namensbereiche mit der Bezeichnung `Usage: Accounts` oder `Usage: Finance` versehen.

<img src="images/cs_network_policy_multi_ns.png" width="475" alt="Verwenden Sie eine Netzrichtlinie zum Verwalten von namensbereichsübergreifendem Datenverkehr." style="width:475px; border-style: none"/>

'Srv2' des Teams 'Finance' muss Informationen vom Back-End für 'Srv1' des Teams 'Accounts' aufrufen. Das Team 'Accounts' erstellt daher eine Kubernetes-Netzrichtlinie, die mithilfe von Bezeichnungen den gesamten Datenverkehr vom Namensbereich 'Finance' zum Back-End für 'Srv1' im Namensbereich 'Accounts' zulässt. Das Team gibt zudem den Port 3111 an, um den Zugriff ausschließlich an diesem Port zu ermöglichen.

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  Namespace: accounts
  name: accounts-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      Tier: backend
  ingress:
  - from:
    - NamespaceSelector:
        matchLabels:
          usage: finance
      ports:
        port: 3111
```
{: codeblock}

Im Abschnitt `spec.podSelector.matchLabels` sind die Bezeichnungen für den Back-End-Service für Srv1 aufgeführt, sodass die Richtlinie nur _für_ diese Pods gilt. Der Abschnitt `spec.ingress.from.NamespaceSelector.matchLabels` enthält die Bezeichnung für den Namensbereich 'Finance', sodass für Ingress nur _Von_-Services in diesem Namensbereich zulässig sind.

Der Datenverkehr kann nun von den Mikroservices von 'Finance' zum Back-End für 'Srv1' von 'Accounts' fließen. Das Back-End für Srv1 von 'Accounts' kann auf die Mikroservices von 'Finance' antworten, jedoch keine umgekehrte Datenverkehrsverbindung herstellen.

**Hinweis**: Der Datenverkehr von bestimmten App-Pods in einem anderen Namensbereich ist nicht möglich, da `podSelector` und `namespaceSelector` nicht kombiniert werden können. In diesem Beispiel ist der gesamte Datenverkehr von allen Mikroservices im Namensbereich 'Finance' zulässig.

## Verweigerte Datenverkehr protokollieren
{: #log_denied}

Sie können eine Calico-Protokollnetzrichtlinie erstellen, um die verweigerten Datenverkehrsanforderungen an bestimmte Pods in Ihrem Cluster zu protokollieren.
{: shortdesc}

Wenn Sie Netzrichtlinien einrichten, um den Datenverkehr an App-Pods zu beschränken, werden Datenverkehrsanforderungen, die von diesen Richtlinien nicht zugelassen werden, verweigert und gelöscht. In bestimmten Szenarios wünschen Sie möglicherweise weitere Informationen zu verweigerten Datenverkehrsanforderungen. Beispielsweise könnte es sein, dass Sie ungewöhnlichen Datenverkehr bemerken, der kontinuierlich durch eine Ihrer Netzrichtlinien verweigert wird. Um die potenzielle Sicherheitsbedrohung zu überwachen, können Sie eine Protokollierung einrichten, um jeden Zeitpunkt aufzuzeichnen, zu dem die Richtlinie eine versuchte Aktion für die angegebenen App-Pods verweigert. 

Vorbereitende Schritte:
1. [Installieren und konfigurieren Sie die Calico-CLI.](#cli_install) **Hinweis**: Die Richtlinien in diesen Schritten verwenden die Syntax von Calico Version 3, die mit Clustern kompatibel ist, die Kubernetes Version 1.10 oder höher ausführen. Für Cluster, die Kubernetes Version 1.9 oder früher ausführen, müssen Sie die [Richtliniensyntax von Calico Version 2![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) verwenden.
2. [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `ibmcloud ks cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. Dieser Download umfasst auch die Schlüssel für den Zugriff auf Ihr Infrastrukturportfolio und zur Ausführung von Calico-Befehlen auf Ihren Workerknoten.
    ```
    ibmcloud ks cluster-config <clustername> --admin
    ```
    {: pre}

Gehen Sie wie folgt vor, um eine Calico-Richtlinie zur Protokollierung des verweigerten Datenverkehrs zu erstellen:

1. Erstellen oder verwenden Sie eine vorhandene Kubernetes- oder Calico-Netzrichtlinie, die den eingehenden Datenverkehr blockiert oder begrenzt. Wenn Sie beispielsweise den Datenverkehr zwischen Pods steuern möchten, können Sie die folgende Kubernetes-Beispielrichtlinie mit dem Namen `access-nginx` verwenden, die den Zugriff auf eine NGINX-App einschränkt. Der eingehende Datenverkehr an Pods mit der Bezeichnung "run=nginx" ist nur von Pods mit der Bezeichnung "run=access" zulässig. Der gesamte weitere eingehende Datenverkehr für die "run=nginx"-App-Pods wird blockiert.
    ```
    kind: NetworkPolicy
    apiVersion: extensions/v1beta1
    metadata:
      name: access-nginx
    spec:
      podSelector:
        matchLabels:
          run: nginx
      ingress:
        - from:
          - podSelector:
              matchLabels:
                run: access
    ```
    {: codeblock}

2. Wenden Sie die Richtlinie an.
    * Gehen Sie wie folgt vor, um eine Kubernetes-Richtlinie anzuwenden:
        ```
        kubectl apply -f <richtlinienname>.yaml
        ```
        {: pre}
        Die Kubernetes-Richtlinie wird automatisch in eine Calico-Netzrichtlinie konvertiert, sodass Calico sie als 'iptables'-Regeln anwenden kann.

    * Gehen Sie wie folgt vor, um eine Calico-Richtlinie anzuwenden:
        ```
        calicoctl apply -f <richtlinienname>.yaml --config=<dateipfad>/calicoctl.cfg
        ```
        {: pre}

3. Wenn Sie eine Kubernetes-Richtlinie angewendet haben, überprüfen Sie die Syntax der automatisch erstellten Calico-Richtlinie und kopieren Sie den Wert des Felds `spec.selector`.
    ```
    calicoctl get policy -o yaml <richtlinienname> --config=<dateipfad>/calicoctl.cfg
    ```
    {: pre}

    Beispiel: Nachdem die Richtlinie `access-nginx` angewendet und konvertiert wurde, hat sie die folgende Calico-Syntax (Version 3). Das Feld `spec.selector` hat den Wert `projectcalico.org/orchestrator == 'k8s' && run == 'nginx'`.
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: access-nginx
    spec:
      ingress:
      - action: Allow
        destination: {}
        source:
          selector: projectcalico.org/orchestrator == 'k8s' && run == 'access'
      order: 1000
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      types:
      - Ingress
    ```
    {: screen}

4. Um den gesamten Datenverkehr zu protokollieren, der von der zuvor erstellten Calico-Richtlinie verweigert wurde, erstellen Sie eine Calico-Netzrichtlinie mit dem Namen `log-denied-packets`. Verwenden Sie zum Beispiel die folgende Richtlinie, um alle Pakete zu protokollieren, die von der in Schritt 1 definierten Netzrichtlinie zurückgewiesen wurden. Die Protokollrichtlinie verwendet denselben Pod-Selektor wie die Beispielrichtlinie `access-nginx`, mit der diese Richtlinie zur Calico-Regelkette 'iptables' hinzugefügt wird. Wenn Sie eine höhere Folgenummer verwenden (z. B. `3000`), können Sie sicherstellen, dass diese Regel am Ende der Regelkette 'iptables' hinzugefügt wird. Jedes Anforderungspaket aus dem Pod "run=access", das mit der Richtlinienregel `access-nginx` übereinstimmt, wird von den "run=nginx"-Pods akzeptiert. 
Wenn jedoch Pakete aus einer anderen Quelle versuchen, mit der niederwertigen Richtlinienregel `access-nginx` übereinzustimmen, werden sie verweigert. Diese Pakete versuchen dann, mit der höherwertigen Richtlinienregel `log-denied-packets` übereinzustimmen. `log-denied-packets` protokolliert alle ankommenden Pakete, d. h. es werden nur Pakete aufgezeichnet, die von den "run=nginx"-Pods verweigert wurden. Nachdem die Versuche der Pakete protokolliert wurden, werden die Pakete gelöscht.
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: log-denied-packets
    spec:
      types:
      - Ingress
      ingress:
      - action: Log
        destination: {}
        source: {}
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      order: 3000
    ```
    {: codeblock}

    <table>
    <caption>Erklärung der YAML-Komponenten der Protokollrichtlinie</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Komponenten der Protokollrichtlinie</th>
    </thead>
    <tbody>
    <tr>
     <td><code>types</code></td>
     <td>Diese <code>Ingress</code>-Richtlinie bezieht sich auf alle eingehenden Datenverkehrsanforderungen. <strong>Hinweis:</strong> Der Wert <code>Ingress</code> ist ein allgemeiner Begriff für den gesamten eingehenden Datenverkehr und bezieht sich nicht nur auf den Datenverkehr von der IBM Ingress ALB. </td>
    </tr>
     <tr>
      <td><code>ingress</code></td>
      <td><ul><li><code>action</code>: Die Aktion <code>Log</code> schreibt einen Protokolleintrag für alle Anforderungen, die mit dieser Richtlinie übereinstimmen, in den Pfad `/var/log/syslog` auf dem Workerknoten.</li><li><code>destination</code>: Es wurde kein Ziel angegeben, da der <code>selector</code> diese Richtlinie auf alle Pods mit einer bestimmten Bezeichnung anwendet.</li><li><code>source</code>: Diese Richtlinie gilt für Anforderungen von jeder Quelle.</td>
     </tr>
     <tr>
      <td><code>selector</code></td>
      <td>Ersetzen Sie &lt;selector&gt; durch denselben Selektor im Feld `spec.selector`, den Sie in Ihrer Calico-Richtlinie aus Schritt 1 verwendet haben oder den Sie in der Calico-Syntax für Ihre Kubernetes-Richtlinie in Schritt 3 gefunden haben. Wenn Sie beispielsweise den Selektor <code>selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'</code> verwenden, wird die Regel dieser Richtlinie zu derselben 'iptables'-Kette hinzugefügt wie die Beispielregel <code>access-nginx</code> für die Netzrichtlinie in Schritt 1. Diese Richtlinie gilt nur für den eingehenden Netzdatenverkehr an Pods, die dieselbe Pod-Selektorbezeichnung verwenden.</td>
     </tr>
     <tr>
      <td><code>order</code></td>
      <td>Calico-Richtlinien haben eine Reihenfolge, die bestimmt, wann sie auf eingehende Anforderungspakete angewendet werden. Richtlinien mit niedrigerem Wert (z. B. <code>1000</code>) werden zuerst angewendet. Richtlinien mit höherem Wert werden nach den Richtlinien mit niedrigerem Wert angewendet. Beispiel: Eine Richtlinie mit einem sehr hohen Folgewert, z. B. <code>3000</code>, wird angewendet, nachdem alle Richtlinien mit niedrigerem Wert angewendet wurden.</br></br>Eingehende Anforderungspakete durchlaufen die 'iptables'-Regelkette und versuchen, zuerst mit den Regeln aus den Richtlinien mit niedrigerem Wert übereinzustimmen. Wenn ein Paket mit einer beliebigen Regel übereinstimmt, wird das Paket akzeptiert. Wenn ein Paket jedoch mit keiner Regel übereinstimmt, gelangt es zur letzten Regel in der 'iptables'-Regelkette mit dem höchsten Wert. Um sicherzustellen, dass es sich um die letzte Richtlinie in der Kette handelt, verwenden Sie einen viel höheren Wert (z. B. <code>3000</code>) als den der Richtlinie, die Sie in Schritt 1 erstellt haben.</td>
     </tr>
    </tbody>
    </table>

5. Wenden Sie die Richtlinie an.
    ```
    calicoctl apply -f log-denied-packets.yaml --config=<dateipfad>/calicoctl.cfg
    ```
    {: pre}

6. [Leiten Sie die Protokolle](cs_health.html#configuring) von `/var/log/syslog` an {{site.data.keyword.loganalysislong}} oder einen externen Syslog-Server weiter.
