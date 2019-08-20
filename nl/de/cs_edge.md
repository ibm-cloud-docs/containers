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

# Netzverkehr auf Edge-Workerknoten beschränken
{: #edge}

Mit Edge-Workerknoten kann die Sicherheit des {{site.data.keyword.containerlong}}-Clusters verbessert werden, indem der externe Zugriff auf Workerknoten beschränkt und die Netzarbeitslast isoliert wird.
{:shortdesc}

Wenn diese Workerknoten nur für den Netzbetrieb markiert sind, können andere Arbeitslasten nicht die CPU oder den Speicher des entsprechenden Workerknotens nutzen und somit Auswirkungen auf den Netzbetrieb haben.

Wenn Sie über einen Mehrzonencluster verfügen und den Datenaustausch im Netz auf Edge-Workerknoten beschränken möchten, müssen in jeder Zone mindestens zwei Edge-Workerknoten für die Hochverfügbarkeit von Lastausgleichsfunktions- oder Ingress-Pods aktiviert werden. Erstellen Sie einen Worker-Pool für Edge-Workerknoten, der sich über alle Zonen im Cluster erstreckt, mit mindestens zwei Workerknoten pro Zone.
{: tip}

## Bezeichnung für Edge-Knoten zu Workerknoten hinzufügen
{: #edge_nodes}

Fügen Sie die Bezeichnung `dedicated=edge` zu mindestens zwei Workerknoten in jedem öffentlichen oder privaten VLAN in Ihrem Cluster hinzu, um sicherzustellen, dass Netzlastausgleichsfunktionen (NLBs) und Ingress-Lastausgleichsfunktionen für Anwendungen (ALBs) nur für diese Workerknoten bereitgestellt werden.
{:shortdesc}

**Community-Cluster (Kubernetes)**: In Kubernetes 1.14 und höher können sowohl öffentliche als auch private NLBs und ALBs auf Edge-Workerknoten bereitgestellt werden. In Kubernetes 1.13 und niedriger können öffentliche und private ALBs und öffentliche NLBs auf Edge-Knoten bereitgestellt werden, aber private NLBs dürfen nur auf Nicht-Edge-Workerknoten in Ihrem Cluster bereitgestellt werden.
{: note}

Vorbereitende Schritte:

* Stellen Sie sicher, dass Sie die folgenden [{{site.data.keyword.cloud_notm}} IAM-Rollen](/docs/containers?topic=containers-users#platform) innehaben:
  * Beliebige Plattformrolle für den Cluster
  * Servicerolle **Schreibberechtigter** oder **Manager** für alle Namensbereiche
* [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

</br>Gehen Sie wie folgt vor, um eine Bezeichnung für Edge-Knoten zu Workerknoten hinzuzufügen:

1. [Erstellen Sie einen neuen Worker-Pool](/docs/containers?topic=containers-add_workers#add_pool), der sich über alle Zonen im Cluster erstreckt und mindestens zwei Worker pro Zone aufweist. Schließen Sie im Befehl `ibmcloud ks worker-pool-create` das Flag `--labels dedicated=edge` ein, um allen Workerknoten im Pool eine Bezeichnung zuzuordnen. Alle Workerknoten in diesem Pool, einschließlich aller später hinzugefügten Workerknoten, werden als Edge-Knoten bezeichnet. Nachdem der Worker-Pool mit der Bezeichnung `dedicated=edge` markiert wurde, erhalten alle vorhandenen und nachfolgenden Ingress- und Lastausgleichsfunktionen diese Bezeichnung und werden auf einem Edge-Workerknoten bereitgestellt.
  <p class="tip">Wenn Sie einen vorhandenen Worker-Pool verwenden, muss der Pool sich über alle Zonen im Cluster erstrecken und mindestens zwei Worker pro Zone aufweisen. Mithilfe der [PATCH-Worker-Pool-API](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/PatchWorkerPool) können Sie dem Worker-Pool die Bezeichnung `dedicated=edge` zuordnen. Übergeben Sie im Hauptteil der Anforderung den folgenden JSON-Code.
      <pre class="screen">
      {
        "labels": {"dedicated":"edge"},
        "state": "labels"
      }</pre></p>

2. Stellen Sie sicher, dass der Worker-Pool und die Workerknoten die Bezeichnung `dedicated=edge` haben.
  * Gehen Sie wie folgt vor, um den Worker-Pool zu überprüfen:
    ```
    ibmcloud ks worker-pool-get --cluster <clustername_oder_-id> --worker-pool <worker-poolname_oder_-id>
    ```
    {: pre}

  * Überprüfen Sie das Feld **Labels** der Ausgabe des folgenden Befehls, um einzelne Workerknoten zu überprüfen.
    ```
    kubectl describe node <private_workerknoten-ip>
    ```
    {: pre}

3. Rufen Sie alle vorhandenen NLBs und ALBs im Cluster ab.
  ```
  kubectl get services --all-namespaces | grep LoadBalancer
  ```
  {: pre}

  Notieren Sie für jeden Lastausgleichsservice die Angaben unter **Namensbereich** und **Name** in der Ausgabe. Beispiel: In der folgenden Ausgabe sind vier Lastausgleichsservices vorhanden: eine öffentliche NLB im Namensbereich `default` und eine private und zwei öffentliche ALBs im Namensbereich `kube-system`.
  ```
  NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                     AGE
  default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                                10m
  kube-system   private-crdf253b6025d64944ab99ed63bb4567b6-alb1  LoadBalancer   172.21.158.78    10.185.94.150   80:31015/TCP,443:31401/TCP,9443:32352/TCP   25d
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.48.228.78   80:30286/TCP,443:31363/TCP                  25d
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb2   LoadBalancer   172.21.229.73    169.46.17.6     80:31104/TCP,443:31138/TCP                  25d
  ```
  {: screen}

4. Führen Sie unter Verwendung der Ausgabe des vorherigen Schritts den folgenden Befehl für jede NLB und ALB aus. Mit diesem Befehl wird die NLB oder ALB erneut auf einem Edge-Workerknoten bereitgestellt.

  **Community-Cluster (Kubernetes)**: Wenn Ihr Cluster Kubernetes Version 1.14 oder höher ausführt, können Sie sowohl öffentliche als auch private NLBs und ALBs auf Edge-Workerknoten bereitstellen. In Kubernetes 1.13 und niedriger können nur öffentliche und private ALBs und öffentliche NLBs auf Edge-Knoten bereitgestellt werden, deshalb dürfen Sie privaten NLB-Services nicht erneut bereitstellen.
  {: note}

  ```
  kubectl get service -n <namensbereich> <servicename> -o yaml | kubectl apply -f -
  ```
  {: pre}

  Beispielausgabe:
  ```
  service "webserver-lb" configured
  ```
  {: screen}

5. Um zu überprüfen, ob Netzworkloads auf Edge-Knoten eingeschränkt sind, vergewissern Sie sich, dass NLB- und ALB-Pods auf den Edge-Knoten geplant sind und nicht auf Nicht-Edge-Knoten geplant sind.

  * NLB-Pods:
    1. Vergewissern Sie sich, dass NLB-Pods auf Edge-Knoten bereitgestellt werden. Suchen Sie externe IP-Adresse des Lastausgleichsservice, der in der Ausgabe von Schritt 3 aufgelistet wird. Ersetzen Sie die Punkte (`.`) durch Bindestriche (`-`). Beispiel für die NLB `webserver-lb` mit der externen IP-Adresse `169.46.17.2`:
      ```
      kubectl describe nodes -l dedicated=edge | grep "169-46-17-2"
      ```
      {: pre}

      Beispielausgabe:
      ```
      ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
      ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-2z64r                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
      ```
      {: screen}
    2. Vergewissern Sie sich, dass keine NLB-Pods auf Nicht-Edge-Knoten bereitgestellt werden. Beispiel für die NLB `webserver-lb` mit der externen IP-Adresse `169.46.17.2`:
      ```
      kubectl describe nodes -l dedicated!=edge | grep "169-46-17-2"
      ```
      {: pre}
      * Wenn die NLB-Pods ordnungsgemäß auf Edge-Knoten bereitgestellt werden, werden keine NLB-Pods zurückgegeben. Ihre NLBs wurden erfolgreich nur auf Edge-Workerknoten neu geplant.
      * Wenn NLB-Pods zurückgegeben werden, fahren Sie mit dem nächsten Schritt fort.

  * ALB-Pods:
    1. Vergewissern Sie sich, dass alle ALB-Pods auf Edge-Knoten bereitgestellt werden. Suchen Sie nach dem Schlüsselwort `alb`. Jede öffentliche und private ALB hat zwei Pods. Beispiel:
      ```
      kubectl describe nodes -l dedicated=edge | grep alb
      ```
      {: pre}

      Beispielausgabe für einen Cluster mit zwei Zonen, in denen eine private Standard-ALB und zwei öffentliche Standard-ALBs aktiviert sind:
      ```
      kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-27pv4    0 (0%)        0 (0%)      0 (0%)           0 (0%)
      kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-7p9q6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
      kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-s77z6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
      kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-kvs9f    0 (0%)        0 (0%)      0 (0%)           0 (0%)
      kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb2-57df7c7b5b-tp6xw    0 (0%)        0 (0%)      0 (0%)           0 (0%)
      kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb2-57df7c7b5b-z5p2v    0 (0%)        0 (0%)      0 (0%)           0 (0%)
      ```
      {: screen}

    2. Vergewissern Sie sich, dass keine ALB-Pods auf Nicht-Edge-Knoten bereitgestellt werden. Beispiel:
      ```
      kubectl describe nodes -l dedicated!=edge | grep alb
      ```
      {: pre}
      * Wenn die ALB-Pods ordnungsgemäß auf Edge-Knoten bereitgestellt werden, werden keine ALB-Pods zurückgegeben. Ihre ALBs wurden nur auf Edge-Workerknoten erfolgreich neu geplant.
      * Wenn ALB-Pods zurückgegeben werden, fahren Sie mit dem nächsten Schritt fort.

6. Wenn immer noch NLB- oder ALB-Pods auf Nicht-Edge-Knoten bereitgestellt werden, können Sie die Pods löschen, sodass sie auf Edge-Knoten erneut bereitgestellt werden. **Wichtig**: Löschen Sie jeweils nur einen Pod und vergewissern Sie sich, dass der Pod auf einem Edge-Knoten neu geplant wurde, bevor Sie weitere Pods löschen.
  1. Löschen Sie einen Pod. Beispiel für den Fall, dass einer der `webserver-lb`-NLB-Pods nicht auf einem Edge-Knoten geplant wurde:
    ```
    kubectl delete pod ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg
    ```
    {: pre}

  2. Stellen Sie sicher, dass der Pod auf einem Edge-Workerknoten neu geplant wurde. Die Neuplanung erfolgt automatisch, kann aber einige Minuten dauern. Beispiel für die NLB `webserver-lb` mit der externen IP-Adresse `169.46.17.2`:
    ```
    kubectl describe nodes -l dedicated=edge | grep "169-46-17-2"
    ```
    {: pre}

    Beispielausgabe:
    ```
    ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
      ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-2z64r                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
      ```
    {: screen}

</br>Sie haben Workerknoten in einem Worker-Pool mit der Bezeichnung `dedicated=edge` markiert und alle vorhandenen ALBs und NLBs auf den Edge-Knoten neu bereitgestellt. Alle nachfolgenden ALBs und NLBs, die dem Cluster hinzugefügt werden, werden auch auf einem Edge-Knoten in Ihrem Edge-Worker-Pool bereitgestellt. Verhindern Sie nun als nächsten Schritt, dass andere [Arbeitslasten auf Edge-Workerknoten ausgeführt werden](#edge_workloads) und [blockieren Sie eingehenden Datenverkehr an Knotenports auf Workerknoten](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Verhindern, dass Workloads auf Edge-Workerknoten ausgeführt werden
{: #edge_workloads}

Ein Vorteil von Edge-Workerknoten besteht darin, dass sie so konfiguriert werden können, dass sie nur Netzservices (Networking Services) ausführen.
{:shortdesc}

Die Verwendung der Tolerierung `dedicated=edge` bedeutet, dass alle Services für Netzlastausgleichsfunktionen (NLB) und Ingress-Lastausgleichsfunktionen für Anwendungen (ALB) nur auf den markierten Workerknoten ausgeführt werden. Um jedoch zu verhindern, dass andere Workloads auf Edge-Workerknoten ausgeführt werden und deren Ressourcen verbrauchen, müssen Sie [Kubernetes-Taints ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) verwenden.

Vorbereitende Schritte:
- Stellen Sie sicher, dass Sie über die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Manager** für alle Namensbereiche](/docs/containers?topic=containers-users#platform) verfügen.
- [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

</br>Gehen Sie wie folgt vor, um zu verhindern, dass andere Workloads auf Edge-Workerknoten ausgeführt werden:

1. Wenden Sie einen Taint auf alle Workerknoten mit der Bezeichnung `dedicated=edge` an, der verhindert, dass Pods auf den entsprechenden Workerknoten ausgeführt werden, und der Pods von den Workerknoten entfernt, die nicht die Bezeichnung `dedicated=edge` aufweisen. Die entfernten Pods werden auf anderen Workerknoten mit entsprechender Kapazität erneut bereitgestellt.
  ```
  kubectl taint node -l dedicated=edge dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```
  {: pre}
  Nun werden nur Pods mit der Tolerierung `dedicated=edge` auf Ihren Edge-Workerknoten bereitgestellt.

2. Stellen Sie sicher, dass Ihre Edge-Knoten mit Taints versehen wurden.
  ```
  kubectl describe nodes -l dedicated=edge | grep "Taint|Hostname"
  ```
  {: pre}

  Beispielausgabe:
  ```
  Taints:             dedicated=edge:NoExecute
    Hostname:    10.176.48.83
  Taints:             dedicated=edge:NoExecute
    Hostname:    10.184.58.7
  ```
  {: screen}

3. Wenn Sie die [Beibehaltung der Quellen-IP für einen NLB-Service der NLB-Version 1.0](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations) wählen, stellen Sie sicher, dass App-Pods auf den Edge-Workerknoten geplant werden, indem Sie [Edge-Knoten-Affinität zu App-Pods hinzufügen](/docs/containers?topic=containers-loadbalancer#lb_edge_nodes). App-Pods müssen auf Edge-Knoten geplant werden, um eingehende Anforderungen empfangen zu können.

4. Zum Entfernen eines Taints führen Sie den folgenden Befehl aus.
    ```
    kubectl taint node <knotenname> dedicated:NoSchedule- dedicated:NoExecute-
    ```
    {: pre}


