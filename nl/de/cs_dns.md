---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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


# Cluster-DNS-Provider konfigurieren
{: #cluster_dns}

Jedem Service in Ihrem {{site.data.keyword.containerlong}}-Cluster wird ein DNS-Name (Domain Name System) zugeordnet, den der Cluster-DNS-Provider registriert, um DNS-Anforderungen aufzulösen. Abhängig von der Kubernetes-Version Ihres Clusters können Sie zwischen KubeDNS (Kubernetes-DNS) oder [CoreDNS ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://coredns.io/) auswählen. Weitere Informationen zu DNS für Services und Pods finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/).
{: shortdesc}

**Welche Kubernetes-Versionen unterstützen welchen Cluster-DNS-Provider?**<br>

| Kubernetes-Version | Standard für neue Cluster | Beschreibung |
|---|---|---|
| 1.14 und höher | CoreDNS | Wenn ein Cluster KubeDNS verwendet und von einer früheren Version auf Version 1.14 oder höher aktualisiert wird, wird der Cluster-DNS-Provider während der Clusteraktualisierung automatisch von KubeDNS auf CoreDNS migriert. Sie können nicht zum Cluster-DNS-Provider KubeDNS zurück wechseln. |
| 1.13 | CoreDNS | Cluster, die von einer einer früheren Version auf Version 1.13 aktualisiert werden, behalten den DNS-Provider, den sie zum Zeitpunkt der Aktualisierung verwendeten. Falls Sie einen anderen verwenden möchten, [wechseln Sie den DNS-Provider](#dns_set). |
| 1.12 | KubeDNS | Falls Sie stattdessen CoreDNS verwenden möchten, [wechseln Sie den DNS-Provider](#set_coredns). |
| 1.11 und früher | KubeDNS | Sie können nicht zum DNS-Provider CoreDNS wechseln. |
{: caption="Standard-Cluster-DNS-Provider nach Kubernetes-Version" caption-side="top"}

**Welche Vorteile bietet die Verwendung von CoreDNS im Vergleich zu KubeDNS?**<br>
CoreDNS ist der standardmäßig unterstützte Cluster-DNS-Provider für Kubernetes Version 1.13 und höher und wurde vor Kurzem zu einem [CNCF-Projekt (Cloud Native Computing Foundation) des Typs 'graduated' hochgestuft![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.cncf.io/projects/). Ein Projekt des Typs 'graduated' wurde gründlich getestet und permanent gespeichert und kann auf breiter Basis im Produktionsbetrieb eingesetzt werden.

Wie in der [Kubernetes-Ankündigung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/blog/2018/12/03/kubernetes-1-13-release-announcement/) angegeben, ist CoreDNS ein autoritativer, vielseitig einsetzbarer DNS-Server, der die abwärtskompatible, aber erweiterbare Integration in Kubernetes ermöglicht. Da CoreDNS eine einzelne ausführbare Funktion und ein einzelner Prozess ist, weist CoreDNS weniger Abhängigkeiten und bewegliche Teile auf als der bisherige Cluster-DNS-Provider und ist damit weniger fehleranfällig. Das Projekt wurde außerdem in derselben Sprache, `Go`, wie das Kubernetes-Projekt geschrieben, was den Schutz des Speichers erleichtert. Schließlich unterstützt CoreDNS flexiblere Anwendungsfälle als KubeDNS, da Sie angepasste DNS-Einträge wie die [gängigen Konfigurationen in der CoreDNS-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://coredns.io/manual/toc/#setups) erstellen können.

## Automatische Skalierung für den Cluster-DNS-Provider
{: #dns_autoscale}

Ihr {{site.data.keyword.containerlong_notm}}-Cluster-DNS-Provider enthält standardmäßig eine Bereitstellung zur automatischen Skalierung der DNS-Pods als Reaktion auf die Anzahl der Workerknoten und Cores im Cluster. Sie können die Parameter für die automatische DNS-Skalierungsfunktion (DNS-Autoscaler) optimieren, indem Sie die Konfigurationszuordnung (Configmap) für die automatische DNS-Skalierung bearbeiten. Wenn Ihre Apps den Cluster-DNS-Provider zum Beispiel intensiv nutzen, müssen Sie möglicherweise die Mindestanzahl der DNS-Pods zur Unterstützung der App erhöhen. Weitere Informationen finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/).
{: shortdesc}

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Überprüfen Sie, ob die Bereitstellung des Cluster-DNS-Providers verfügbar ist. Sie haben möglicherweise die automatische Skalierungsfunktion für den KubeDNS-, für den CoreDNS- oder für beide DNS-Provider in Ihrem Cluster installiert. Wenn beide automatischen DNS-Skalierungsfunktionen installiert sind, entnehmen Sie der Spalte **AVAILABLE** in Ihrer CLI-Ausgabe, welche Funktion verwendet wird. Die Bereitstellung, die im Gebrauch ist, wird mit einer verfügbaren Bereitstellung aufgelistet.
    ```
    kubectl get deployment -n kube-system | grep dns-autoscaler
    ```
    {: pre}

    Beispielausgabe:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler     0         0         0            0           32d
    kube-dns-autoscaler    1         1         1            1           260d
    ```
    {: screen}
2.  Rufen Sie den Namen der Konfigurationszuordnung (Configmap) für die Parameter der automatischen DNS-Skalierung ab.
    ```
    kubectl get configmap -n kube-system
    ```
    {: pre}    
3.  Bearbeiten Sie die Standardeinstellungen für die automatische DNS-Skalierung. Suchen Sie nach dem Feld `data.linear`, das standardmäßig einen DNS-Pod pro 16 Workerknoten oder 256 Cores mit einer Mindestanzahl von zwei DNS-Pods unabhängig von der Clustergröße (`preventSinglePointFailure: true`) angibt. Weitere Informationen finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters).
    ```
    kubectl edit configmap -n kube-system <dns-autoscaler>
    ```
    {: pre}

    Beispielausgabe:
    ```
    apiVersion: v1
    data:
      linear: '{"coresPerReplica":256,"nodesPerReplica":16,"preventSinglePointFailure":true}'
    kind: ConfigMap
    metadata:
    ...
    ```
    {: screen}

## Cluster-DNS-Provider anpassen
{: #dns_customize}

Sie können Ihren Cluster-DNS-Provider für {{site.data.keyword.containerlong_notm}} anpassen, indem Sie die DNS-Konfigurationszuordnung (Configmap) bearbeiten. Sie können zum Beispiel `Stub-Domänen` und vorgeordnete Namensserver (Upstream-Namensserver) zur Auflösung von Services konfigurieren, die auf externe Hosts verweisen. Darüber hinaus können Sie bei Verwendung von CoreDNS mehrere [Corefiles ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://coredns.io/2017/07/23/corefile-explained/) in der CoreDNS-Konfigurationszuordnung konfigurieren. Weitere Informationen finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
{: shortdesc}

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Überprüfen Sie, ob die Bereitstellung des Cluster-DNS-Providers verfügbar ist. Sie haben möglicherweise den Cluster-DNS-Provider für KubeDNS, CoreDNS oder beide DNS-Provider in Ihrem Cluster installiert. Wenn beide Provider installiert sind, entnehmen Sie der Spalte **AVAILABLE** in Ihrer CLI-Ausgabe, welche Funktion verwendet wird. Die Bereitstellung, die im Gebrauch ist, wird mit einer verfügbaren Bereitstellung aufgelistet.
    ```
    kubectl get deployment -n kube-system -l k8s-app=kube-dns
    ```
    {: pre}

    Beispielausgabe:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns                0         0         0            0           89d
    kube-dns-amd64         2         2         2            2           89d
    ```
    {: screen}
2.  Bearbeiten Sie die Standardeinstellungen für die CoreDNS- oder KubeDNS-Konfigurationszuordnung.

    *   **Für CoreDNS:** Verwenden Sie eine Corefile im Abschnitt `data` der Konfigurationszuordnung, um `Stub-Domänen` und vorgeordnete Namensserver (Upstream-Namensserver) anzupassen. Weitere Informationen finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns).
        ```
        kubectl edit configmap -n kube-system coredns
        ```
        {: pre}

        **CoreDNS-Beispielausgabe:**
          ```
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: coredns
            namespace: kube-system
          data:
            Corefile: |
              abc.com:53 {
                  errors
                  cache 30
                  proxy . 1.2.3.4
              }
              .:53 {
                  errors
                  health
                  kubernetes cluster.local in-addr.arpa ip6.arpa {
                     pods insecure
                     upstream 172.16.0.1
                     fallthrough in-addr.arpa ip6.arpa
                  }
                  prometheus :9153
                  proxy . /etc/resolv.conf
                  cache 30
                  loop
                  reload
                  loadbalance
              }
          ```
          {: screen}

          Haben Sie viele Anpassungen, die Sie organisieren möchten? In Kubernetes Version 1.12.6_1543 und höher können Sie der CoreDNS-Konfigurationszuordnung mehrere Corefiles hinzufügen. Weitere Informationen finden Sie in der [Dokumentation zum Corefile-Import ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://coredns.io/plugins/import/).
          {: tip}

    *   **Für KubeDNS:** Konfigurieren Sie `Stub-Domänen` und vorgeordnete Namensserver (Upstream-Namensserver) im Abschnitt `data` der Konfigurationszuordnung. Weitere Informationen finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns).
        ```
        kubectl edit configmap -n kube-system kube-dns
        ```
        {: pre}

        **KubeDNS-Beispielausgabe:**
        ```
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: kube-dns
          namespace: kube-system
        data:
          stubDomains: |
          {"abc.com": ["1.2.3.4"]}
        ```
        {: screen}

## Cluster-DNS-Provider auf CoreDNS oder KubeDNS festlegen
{: #dns_set}

Wenn Sie einen {{site.data.keyword.containerlong_notm}}-Cluster haben, der Kubernetes Version 1.12 oder 1.13 ausführt, können Sie zwischen der Verwendung von Kubernetes-DNS (KubeDNS) oder der Verwendung von CoreDNS als Cluster-DNS-Provider wählen.
{: shortdesc}

Cluster, die andere Kubernetes-Versionen ausführen, können den Cluster-DNS-Provider nicht festlegen. Version 1.11 und früher unterstützen nur KubeDNS und Version 1.14 und höher unterstützen nur CoreDNS.
{: note}

**Vorbereitende Schritte**:
1.  [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
2.  Bestimmen Sie den aktuellen Cluster-DNS-Provider. Im folgenden Beispiel ist KubeDNS der aktuelle Cluster-DNS-Provider.
    ```
    kubectl cluster-info
    ```
    {: pre}

    Beispielausgabe:
    ```
    ...
    KubeDNS is running at https://c2.us-south.containers.cloud.ibm.com:20190/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    ...
    ```
    {: screen}
3.  Befolgen Sie abhängig von dem DNS-Provider, den Ihr Cluster verwendet, die entsprechenden Schritte zum Wechsel des DNS-Providers.
    *  [Zur Verwendung von CoreDNS wechseln](#set_coredns).
    *  [Zur Verwendung von KubeDNS wechseln](#set_kubedns).

### CoreDNS als Cluster-DNS-Provider festlegen
{: #set_coredns}

Sie können CoreDNS anstelle von KubeDNS als Cluster-DNS-Provider einrichten.
{: shortdesc}

1.  Wenn Sie die Konfigurationszuordnung für den KubeDNS-Provider oder die Konfigurationszuordnung für die automatische KubeDNS-Skalierung angepasst haben, übertragen Sie alle Anpassungen auf die CoreDNS-Konfigurationszuordnungen.
    *   Übertragen Sie für die Konfigurationszuordnung `kube-dns` im Namensbereich `kube-system` alle [DNS-Anpassungen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) auf die Konfigurationszuordnung `coredns` im Namensbereich `kube-system`. Die Syntax der Konfigurationszuordnungen `kube-dns` und `coredns` ist unterschiedlich. Ein Beispiel dazu finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns).
    *   Übertragen Sie für die Konfigurationszuordnung `kube-dns-autoscaler` im Namensbereich `kube-system` alle [Anpassungen der automatischen DNS-Skalierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) auf die Konfigurationszuordnung `coredns-autoscaler` im Namensbereich `kube-system`. Die Anpassungssyntax ist für beide identisch.
2.  Skalieren Sie die KubeDNS-Bereitstellung für automatische Skalierung nach unten.
    ```
    kubectl scale deployment -n kube-system --replicas=0 kube-dns-autoscaler
    ```
    {: pre}
3.  Prüfen und warten Sie, bis die Pods gelöscht werden.
    ```
    kubectl get pods -n kube-system -l k8s-app=kube-dns-autoscaler
    ```
    {: pre}
4.  Skalieren Sie die KubeDNS-Bereitstellung nach unten.
    ```
    kubectl scale deployment -n kube-system --replicas=0 kube-dns-amd64
    ```
    {: pre}
5.  Skalieren Sie die CoreDNS-Bereitstellung für automatische Skalierung nach oben.
    ```
    kubectl scale deployment -n kube-system --replicas=1 coredns-autoscaler
    ```
    {: pre}
6.  Bezeichnen und annotieren Sie den Cluster-DNS-Service für CoreDNS.
    ```
    kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=CoreDNS
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port=9153
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape=true
    ```
    {: pre}
7.  **Optional:** Wenn Sie planen, mithilfe von Prometheus Metriken aus den CoreDNS-Pods zu erfassen, müssen Sie einen Metrikport zu dem Service `kube-dns` hinzufügen, von dem Sie wechseln.
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"metrics","port":9153,"protocol":"TCP"}]}}' --type strategic
    ```
    {: pre}



### KubeDNS als Cluster-DNS-Provider festlegen
{: #set_kubedns}

Sie können KubeDNS anstelle von CoreDNS als Cluster-DNS-Provider einrichten.
{: shortdesc}

1.  Wenn Sie die Konfigurationszuordnung für den CoreDNS-Provider oder die Konfigurationszuordnung für die automatische CoreDNS-Skalierung angepasst haben, übertragen Sie alle Anpassungen auf die KubeDNS-Konfigurationszuordnungen.
    *   Übertragen Sie für die Konfigurationszuordnung `coredns` im Namensbereich `kube-system` alle [DNS-Anpassungen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) auf die Konfigurationszuordnung `kube-dns` im Namensbereich `kube-system`. Die Syntax der Konfigurationszuordnungen `kube-dns` und `coredns` ist unterschiedlich. Ein Beispiel dazu finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns).
    *   Übertragen Sie für die Konfigurationszuordnung `coredns-autoscaler` im Namensbereich `kube-system` alle [Anpassungen der automatischen DNS-Skalierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) auf die Konfigurationszuordnung `kube-dns-autoscaler` im Namensbereich `kube-system`. Die Anpassungssyntax ist für beide identisch.
2.  Skalieren Sie die CoreDNS-Bereitstellung für automatische Skalierung nach unten.
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns-autoscaler
    ```
    {: pre}
3.  Prüfen und warten Sie, bis die Pods gelöscht werden.
    ```
    kubectl get pods -n kube-system -l k8s-app=coredns-autoscaler
    ```
    {: pre}
4.  Skalieren Sie die CoreDNS-Bereitstellung nach unten.
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns
    ```
    {: pre}
5.  Skalieren Sie die KubeDNS-Bereitstellung für automatische Skalierung nach oben.
    ```
    kubectl scale deployment -n kube-system --replicas=1 kube-dns-autoscaler
    ```
    {: pre}
6.  Bezeichnen und annotieren Sie den Cluster-DNS-Service für KubeDNS.
    ```
    kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=KubeDNS
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port-
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape-
    ```
    {: pre}
7.  **Optional:** Wenn Sie Prometheus verwendet haben, um Metriken aus den CoreDNS-Pods zu erfassen, hatte Ihr Service `kube-dns` einen Metrikport. KubeDNS muss diesen Metrikport jedoch nicht enthalten, sodass Sie den Port aus dem Service entfernen können.
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"dns","port":53,"protocol":"UDP"},{"name":"dns-tcp","port":53,"protocol":"TCP"}]}}' --type merge
    ```
    {: pre}
