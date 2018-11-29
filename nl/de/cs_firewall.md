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




# Erforderliche Ports und IP-Adressen in Ihrer Firewall öffnen
{: #firewall}

Überprüfen Sie die hier aufgeführten Situationen, in denen Sie möglicherweise bestimmte Ports und IP-Adressen in Ihren Firewalls {{site.data.keyword.containerlong}} öffnen müssen, um folgende Aktionen zu ermöglichen:
{:shortdesc}

* [Ausführen von `ibmcloud`-Befehlen](#firewall_bx) aus Ihrem lokalen System, wenn die Netzrichtlinien eines Unternehmens den Zugriff auf öffentliche Internetendpunkte über Proxys oder Firewalls verhindern.
* [Ausführen von `kubectl`-Befehlen](#firewall_kubectl) aus Ihrem lokalen System, wenn die Netzrichtlinien eines Unternehmens den Zugriff auf öffentliche Internetendpunkte über Proxys oder Firewalls verhindern.
* [Ausführen von `calicoctl`-Befehlen](#firewall_calicoctl) aus Ihrem lokalen System, wenn die Netzrichtlinien eines Unternehmens den Zugriff auf öffentliche Internetendpunkte über Proxys oder Firewalls verhindern.
* [Zulassen der Kommunikation zwischen dem Kubernetes-Master und den Workerknoten](#firewall_outbound), wenn entweder eine Firewall für die Workerknoten eingerichtet wurde oder wenn die Firewalleinstellungen in Ihrem IBM Cloud-Infrastrukturkonto (SoftLayer) angepasst wurden.
* [Zulassen, dass der Cluster über eine Firewall im privaten Netz auf die Ressourcen zugreift](#firewall_private).
* [Zugreifen auf den NodePort-Service, Service für die Lastausgleichsfunktion oder Ingress-Service von außerhalb des Clusters](#firewall_inbound).

<br />


## `ibmcloud ks`-Befehle von hinter einer Firewall ausführen
{: #firewall_bx}

Falls Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls verhindern, müssen Sie TCP-Zugriff für {{site.data.keyword.containerlong_notm}} zulassen, um `ibmcloud ks`-Befehle auszuführen.
{:shortdesc}

1. Ermöglichen Sie Zugriff auf `containers.bluemix.net` an Port 443.
2. Überprüfen Sie Ihre Verbindung. Ist der Zugriff korrekt konfiguriert, werden in der Ausgabe Schiffe angezeigt.
   ```
   curl https://containers.bluemix.net/v1/
   ```
   {: pre}

   Beispielausgabe:
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}

<br />


## `kubectl`-Befehle von hinter einer Firewall ausführen
{: #firewall_kubectl}

Falls Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls verhindern, müssen Sie TCP-Zugriff für den Cluster zulassen, um `kubectl`-Befehle auszuführen.
{:shortdesc}

Wenn ein Cluster erstellt wird, wird der Port in der Master-URL zufällig einer Zahl zwischen 20000-32767 zugewiesen. Sie können entweder den Portbereich 20000-32767 für alle Cluster öffnen, die eventuell erstellt werden, oder Sie können den Zugriff für einen spezifischen vorhandenen Cluster gewähren.

Vorab müssen Sie zulassen, dass [`ibmcloud ks`-Befehle ausgeführt werden](#firewall_bx).

Gehen Sie wie folgt vor, um Zugriff auf einen bestimmten Cluster zu gewähren:

1. Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn Sie dazu aufgefordert werden. Wenn Sie über ein föderiertes Konto verfügen, schließen Sie die Option `--sso` ein.

   ```
   ibmcloud login [--sso]
   ```
   {: pre}

2. Wenn sich der Cluster in einer anderen Ressourcengruppe als `default` befindet, geben Sie diese Ressourcengruppe als Ziel an. **Anmerkung:** Sie müssen mindestens über die [Rolle **Anzeigeberechtigter**](cs_users.html#platform) für die Ressourcengruppe verfügen.
   ```
   ibmcloud target -g <resource_group_name>
   ```
   {: pre}

2. Wählen Sie die Region aus, in der sich Ihr Cluster befindet.

   ```
   ibmcloud ks region-set
   ```
   {: pre}

3. Rufen Sie den Namen Ihres Clusters ab.

   ```
   ibmcloud ks clusters
   ```
   {: pre}

4. Rufen Sie die **Master-URL** für Ihren Cluster ab.

   ```
   ibmcloud ks cluster-get <clustername_oder_-id>
   ```
   {: pre}

   Beispielausgabe:
   ```
   ...
   Master URL:		https://169.xx.xxx.xxx:31142
   ...
   ```
   {: screen}

5. Ermöglichen Sie Zugriff auf die **Master-URL** an dem Port, z. B. an Port `31142` aus dem vorherigen Beispiel.

6. Überprüfen Sie Ihre Verbindung.

   ```
   curl --insecure <master-URL>/version
   ```
   {: pre}

   Beispielbefehl:
   ```
   curl --insecure https://169.xx.xxx.xxx:31142/version
   ```
   {: pre}

   Beispielausgabe:
   ```
   {
     "major": "1",
     "minor": "7+",
     "gitVersion": "v1.7.4-2+eb9172c211dc41",
     "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
     "gitTreeState": "clean",
     "buildDate": "2017-11-16T08:13:08Z",
     "goVersion": "go1.8.3",
     "compiler": "gc",
     "platform": "linux/amd64"
   }
   ```
   {: screen}

7. Optional: Wiederholen Sie diese Schritte für jeden Cluster, den Sie zugänglich machen müssen.

<br />


## `calicoctl`-Befehle von hinter einer Firewall ausführen
{: #firewall_calicoctl}

Falls Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls verhindern, müssen Sie TCP-Zugriff für die Calico-Befehle zulassen, um `calicoctl`-Befehle auszuführen.
{:shortdesc}

Vorab müssen Sie zulassen, dass [`ibmcloud`-Befehle](#firewall_bx) und [`kubectl`-Befehle](#firewall_kubectl) ausgeführt werden.

1. Rufen Sie die IP-Adresse aus der Master-URL ab, die Sie verwendet haben, um die [`kubectl`-Befehle](#firewall_kubectl) zuzulassen.

2. Rufen Sie den Port für ETCD ab.

  ```
  kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
  ```
  {: pre}

3. Ermöglichen Sie Zugriff für die Calico-Richtlinien über die IP-Adresse und den ETCD-Port der Master-URL.

<br />


## Zugriff des Clusters auf Infrastrukturressourcen und andere Services ermöglichen
{: #firewall_outbound}

Ermöglichen Sie es Ihrem Cluster, auf Infrastrukturressourcen und Services von hinter einer Firewall zuzugreifen, wie beispielsweise für {{site.data.keyword.containerlong_notm}}-Regionen, {{site.data.keyword.registrylong_notm}}, {{site.data.keyword.monitoringlong_notm}}, {{site.data.keyword.loganalysislong_notm}}, private IPs der IBM Cloud-Infrastruktur (SoftLayer) und Egress für Persistent Volume Claims (PVCs).
{:shortdesc}

1.  Notieren Sie die öffentlichen IP-Adressen für alle Workerknoten im Cluster.

    ```
    ibmcloud ks workers <clustername_oder_-id>
    ```
    {: pre}

2.  Ermöglichen Sie Netzverkehr von der Quelle _<öffentliche_IP_für_jeden_workerknoten>_ zum Ziel-TCP/UDP-Portbereich 20000-32767 und zum Port 443 sowie für die folgenden IP-Adressen und Netzgruppen. Wenn Ihre Unternehmensfirewall verhindert, dass Ihr lokales System auf öffentliche Internetendpunkte zugreifen kann, führen Sie diesen Schritt sowohl für Ihre Quellen-Workerknoten als auch für Ihr lokales System aus.
    - **Wichtig**: Sie müssen den ausgehenden Datenverkehr am Port 443 für alle Zonen in der Region zulassen, um die Arbeitslast während des Bootstrap-Prozesses auszugleichen. Wenn sich Ihr Cluster beispielsweise in den USA (Süden) befindet, dann müssen Sie den Datenverkehr von den öffentlichen IPs jedes Ihrer Workerknoten an Port 443 der IP-Adresse für alle Zonen (dal10, dal12, dal13) zulassen.
    <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die verbleibenden Zeilen enthalten von links nach rechts die jeweilige Serverzone in der ersten Spalte und die entsprechenden IP-Adressen in der zweiten Spalte.">
    <caption>Zu öffnende IP-Adressen für abgehenden Datenverkehr</caption>
        <thead>
        <th>Region</th>
        <th>Zone</th>
        <th>IP-Adresse</th>
        </thead>
      <tbody>
        <tr>
          <td>Asien-Pazifik (Norden)</td>
          <td>hkg02<br>seo01<br>sng01<br>tok02</td>
          <td><code>169.56.132.234</code><br><code>169.56.69.242</code><br><code>161.202.186.226</code><br><code>161.202.126.210</code></td>
         </tr>
        <tr>
           <td>Asien-Pazifik (Süden)</td>
           <td>mel01<br>syd01<br>syd04</td>
           <td><code>168.1.97.67</code><br><code>168.1.8.195</code><br><code>130.198.64.19, 130.198.66.34</code></td>
        </tr>
        <tr>
           <td>Mitteleuropa</td>
           <td>ams03<br>fra02<br>mil01<br>osl01<br>par01</td>
           <td><code>169.50.169.110, 169.50.154.194</code><br><code>169.50.56.174</code><br><code>159.122.190.98, 159.122.141.69</code><br><code>169.51.73.50</code><br><code>159.8.86.149, 159.8.98.170</code></td>
          </tr>
        <tr>
          <td>Vereinigtes Königreich (Süden)</td>
          <td>lon02<br>lon04</td>
          <td><code>159.122.242.78</code><br><code>158.175.65.170, 158.175.74.170, 158.175.76.2</code></td>
        </tr>
        <tr>
          <td>Vereinigte Staaten (Osten)</td>
           <td>mon01<br>tor01<br>wdc06<br>wdc07</td>
           <td><code>169.54.126.219</code><br><code>169.53.167.50</code><br><code>169.60.73.142</code><br><code>169.61.83.62</code></td>
        </tr>
        <tr>
          <td>Vereinigte Staaten (Süden)</td>
          <td>dal10<br>dal12<br>dal13<br>hou02<br>sao01<br>sjc03<br>sjc04</td>
          <td><code>169.47.234.18, 169.46.7.238</code><br><code>169.47.70.10</code><br><code>169.60.128.2</code><br><code>184.173.44.62</code><br><code>169.57.151.10</code><br><code>169.45.67.210</code><br><code>169.62.82.197</code></td>
        </tr>
        </tbody>
      </table>

3.  Erlauben Sie ausgehenden Netzverkehr von den Workerknoten an [{{site.data.keyword.registrylong_notm}}-Regionen](/docs/services/Registry/registry_overview.html#registry_regions):
    - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
    - Ersetzen Sie <em>&lt;registry_publicIP&gt;</em> durch die Registry-IP-Adressen, zu denen Sie Datenverkehr erlauben wollen. In der globalen Registry werden von IBM bereitgestellte öffentliche Images gespeichert. Ihre eigenen privaten oder öffentlichen Images werden in regionalen Registrys gespeichert.
      <p>
<table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die verbleibenden Zeilen enthalten von links nach rechts die jeweilige Serverzone in der ersten Spalte und die entsprechenden IP-Adressen in der zweiten Spalte.">
  <caption>Zu öffnende IP-Adressen für Registry-Datenverkehr</caption>
      <thead>
        <th>{{site.data.keyword.containerlong_notm}}-Region</th>
        <th>Registry-Adresse</th>
        <th>Registry-IP-Adresse</th>
      </thead>
      <tbody>
        <tr>
          <td>Über {{site.data.keyword.containerlong_notm}}-Regionen hinweg verfügbare globale Registry</td>
          <td>registry.bluemix.net</td>
          <td><code>169.60.72.144/28</code><br><code>169.61.76.176/28</code></td>
        </tr>
        <tr>
          <td>Asien-Pazifik (Norden), Asien-Pazifik (Süden)</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></td>
        </tr>
        <tr>
          <td>Mitteleuropa</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></br><code>169.50.58.104/29</code></br><code>161.156.93.16/29</code></br><code>149.81.79.152/29</code></td>
         </tr>
         <tr>
          <td>Vereinigtes Königreich (Süden)</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></br><code>158.175.97.184/29</code></br><code>158.176.105.64/29</code></td>
         </tr>
         <tr>
          <td>Vereinigte Staaten (Osten), Vereinigte Staaten (Süden)</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></br><code>169.61.234.224/29</code></br><code>169.61.135.160/29</code></br><code>169.61.46.80/29</code></td>
         </tr>
        </tbody>
      </table>
</p>

4. Optional: Erlauben Sie den ausgehenden Netzverkehr von den Workerknoten an {{site.data.keyword.monitoringlong_notm}} und die {{site.data.keyword.loganalysislong_notm}}-Services:
    - `TCP port 443, port 9095 FROM <each_worker_node_public_IP> TO <monitoring_public_IP>`
    - Ersetzen Sie <em>&lt;monitoring_public_IP&gt;</em> durch alle Adressen für die Überwachungsregionen, an die der Datenverkehr als zulässig definiert werden soll:
      <p><table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die verbleibenden Zeilen enthalten von links nach rechts die jeweilige Serverzone in der ersten Spalte und die entsprechenden IP-Adressen in der zweiten Spalte.">
  <caption>Zu öffnende IP-Adressen für die Überwachung von Datenverkehr</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}}-Region</th>
        <th>Überwachungsadresse</th>
        <th>IP-Adressen für die Überwachung</th>
        </thead>
      <tbody>
        <tr>
         <td>Mitteleuropa</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>Vereinigtes Königreich (Süden)</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>Vereinigte Staaten (Osten), Vereinigte Staaten (Süden), Asien-Pazifik (Norden), Asien-Pazifik (Süden)</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
    - `TCP port 443, port 9091 FROM <each_worker_node_public_IP> TO <logging_public_IP>`
    - Ersetzen Sie <em>&lt;logging_public_IP&gt;</em> durch alle Adressen für die Protokollierungsregionen, an die der Datenverkehr als zulässig definiert werden soll:
      <p><table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die verbleibenden Zeilen enthalten von links nach rechts die jeweilige Serverzone in der ersten Spalte und die entsprechenden IP-Adressen in der zweiten Spalte.">
<caption>Zu öffnende IP-Adressen für die Protokollierung von Datenverkehr</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}}-Region</th>
        <th>Protokollierungsadresse</th>
        <th>IP-Adressen für die Protokollierung</th>
        </thead>
        <tbody>
          <tr>
            <td>Vereinigte Staaten (Osten), Vereinigte Staaten (Süden)</td>
            <td>ingest.logging.ng.bluemix.net</td>
            <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
           </tr>
          <tr>
           <td>Vereinigtes Königreich (Süden)</td>
           <td>ingest.logging.eu-gb.bluemix.net</td>
           <td><code>169.50.115.113</code></td>
          </tr>
          <tr>
           <td>Mitteleuropa</td>
           <td>ingest-eu-fra.logging.bluemix.net</td>
           <td><code>158.177.88.43</code><br><code>159.122.87.107</code></td>
          </tr>
          <tr>
           <td>Asien-Pazifik (Süden), Asien-Pazifik (Norden)</td>
           <td>ingest-au-syd.logging.bluemix.net</td>
           <td><code>130.198.76.125</code><br><code>168.1.209.20</code></td>
          </tr>
         </tbody>
       </table>
</p>

5. Wenn Sie Services der Lastausgleichsfunktion verwenden, müssen Sie sicherstellen, dass der gesamte Datenverkehr, der das VRRP-Protokoll verwendet, zwischen Workerknoten auf öffentlichen und privaten Schnittstellen zulässig ist. {{site.data.keyword.containerlong_notm}} verwendet das VRRP-Protokoll, um IP-Adressen für öffentliche und private Lastausgleichsfunktionen zu verwalten.

6. {: #pvc}Um Persistent Volume Claims für Datenspeicher zu erstellen, lassen Sie Egress-Zugriff über Ihre Firewall für die [IP-Adressen der IBM Cloud-Infrastruktur (SoftLayer)](/docs/infrastructure/hardware-firewall-dedicated/ips.html#ibm-cloud-ip-ranges) der Zone zu, in der sich Ihr Cluster befindet.
    - Um die Zone des Clusters zu ermitteln, führen Sie `ibmcloud ks clusters` aus.
    - Ermöglichen Sie Zugriff auf den IP-Bereich des [**(öffentlichen) Front-End-Netzes**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#frontend-public-network) und des [**privaten Back-End-Netzes**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network).
    - Beachten Sie, dass Sie die Zone `dal01` (Rechenzentrum) für das **(private) Back-End-Netz** hinzufügen müssen.

<br />


## Zugriff des Clusters auf Ressourcen über eine private Firewall ermöglichen
{: #firewall_private}

Wenn Sie über eine Firewall im privaten Netz verfügen, lassen Sie die Kommunikation zwischen den Workerknoten zu und lassen Sie Ihren Cluster über das private Netz auf die Infrastrukturressourcen zugreifen.
{:shortdesc}

1. Lassen Sie den gesamten Datenverkehr zwischen den Workerknoten zu.
    1. Lassen den gesamten TCP-, UDP-, VRRP- und IPEncap-Datenverkehr zwischen Workerknoten auf öffentlichen und privaten Schnittstelle zu. Von {{site.data.keyword.containerlong_notm}} wird das VRRP-Protokoll zum Verwalten von IP-Adressen für private Lastausgleichsfunktionen und das IPEncap-Protokoll für den Datenverkehr zwischen den Pods in den Teilnetzen verwendet.
    2. Wenn Sie Calico-Richtlinien verwenden oder wenn Sie über Firewalls in jeder Zone eines Mehrzonenclusters verfügen, kann eine Firewall möglicherweise die Kommunikation zwischen den Workerknoten blockieren. Sie müssen alle Workerknoten im Cluster füreinander öffnen, indem Sie die Worker-Ports, die privaten IP-Adressen der Worker oder die Calico-Workerknotenbezeichnung verwenden.

2. Lassen Sie für die IBM Cloud-Infrastruktur (SoftLayer) private IP-Bereiche zu, sodass Sie Workerknoten in Ihrem Cluster erstellen können.
    1. Lassen Sie für die entsprechende IBM Cloud-Infrastruktur (SoftLayer) private IP-Bereiche zu. Weitere Informationen finden Sie unter [Back-End-Netz (privat)](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network).
    2. Lassen Sie für die IBM Cloud-Infrastruktur (SoftLayer) private IP-Bereiche für alle [Zonen](cs_regions.html#zones) zu, die Sie verwenden. Beachten Sie, dass Sie IPs für die Zonen `dal01` und `wdc04` hinzufügen müssen. Weitere Informationen finden Sie unter [Servicenetz (im Back-End-Netz/privatem Netz)](/docs/infrastructure/hardware-firewall-dedicated/ips.html#service-network-on-backend-private-network-).

3. Öffnen Sie die folgenden Ports:
    - Abgehende TCP- und UDP-Verbindungen von den Workern zu den Ports 80 und 443 zulassen, um das Aktualisieren und erneute Laden von Workerknoten zu ermöglichen.
    - Abgehende TCP- und UDP-Verbindungen zu Port 2049 zulassen, um das Anhängen von Dateispeicher als Datenträger zu ermöglichen.
    - Abgehende TCP- und UDP-Verbindungen zu Port 3260 zulassen, um die Kommunikation mit Blockspeicher zu ermöglichen.
    - Eingehende TCP- und UDP-Verbindungen zu Port 10250 für das Kubernetes-Dashboard und Kubernetes-Befehle wie `kubectl logs` und `kubectl exec` zulassen.
    - Eingehende und abgehende TCP- und UDP-Verbindungen zu TCP- und UDP-Port 53 für den DNS-Zugriff zulassen.

4. Wenn Sie auch über eine Firewall im öffentlichen Netz verfügen oder wenn Sie über einen Cluster mit ausschließlich privatem VLAN verfügen und eine Gateway-Appliance als Firewall verwenden, müssen Sie auch die IPs und Ports zulassen, die im Abschnitt [Zugriff des Clusters auf Infrastrukturressourcen und andere Services ermöglichen](#firewall_outbound) angegeben sind.

<br />


## Auf NodePort-, LoadBalancer- und Ingress-Services von außerhalb des Clusters zugreifen
{: #firewall_inbound}

Sie können eingehenden Zugriff auf NodePort-, LoadBalancer- und Ingress-Services zulassen.
{:shortdesc}

<dl>
  <dt>NodePort-Service</dt>
  <dd>Öffnen Sie den Port, den Sie bei der Bereitstellung des Service an den öffentlichen IP-Adressen für alle Workerknoten konfiguriert haben, mit denen Datenverkehr möglich sein soll. Führen Sie `kubectl get svc` aus, um den Port zu suchen. Der Port liegt im Bereich 20000-32000.<dd>
  <dt>Service für die Lastausgleichsfunktion</dt>
  <dd>Öffnen Sie den Port, den Sie bei der Bereitstellung des LoadBalancer-Service an der öffentlichen IP-Adresse konfiguriert haben.</dd>
  <dt>Ingress</dt>
  <dd>Öffnen Sie Port 80 für HTTP oder Port 443 für HTTPS an der IP-Adresse für die Ingress-Lastausgleichsfunktion für Anwendungen.</dd>
</dl>
