---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Netzverkehr zu Edge-Workerknoten beschränken
{: #edge}

Mit Edge-Workerknoten kann die Sicherheit des Clusters verbessert werden, indem der externe Zugriff auf Workerknoten beschränkt und die Netzarbeitslast isoliert wird. Wenn diese Workerknoten nur für den Netzbetrieb markiert sind, können andere Arbeitslasten nicht die CPU oder den Speicher des entsprechenden Workerknotens nutzen und somit Auswirkungen auf den Netzbetrieb haben.
{:shortdesc}



## Bezeichnung für Edge-Knoten zu Workerknoten hinzufügen
{: #edge_nodes}

Fügen Sie die Bezeichnung `dedicated=edge` zu mindestens zwei Workerknoten in Ihrem Cluster hinzu, um sicherzustellen, dass Ingress- und Lastausgleichsservices nur für diese Workerknoten bereitgestellt werden.

Vorbemerkungen:

- [Erstellen Sie einen Standardcluster.](cs_clusters.html#clusters_cli)
- Stellen Sie sicher, dass der Cluster mindestens über ein öffentliches VLAN verfügt. Edge-Workerknoten stehen nicht für Cluster mit ausschließlich privaten VLANs zur Verfügung.
- [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure).

Schritte:

1. Listen Sie alle Workerknoten im Cluster auf. Verwenden Sie die private IP-Adresse aus der Spalte **NAME**, um die Knoten anzugeben. Wählen Sie mindestens zwei Workerknoten als Edge-Workerknoten aus. Durch die Verwendung von zwei oder mehr Workerknoten wird die Verfügbarkeit der Netzressourcen verbessert.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated
  ```
  {: pre}

2. Ordnen Sie den Workerknoten die Bezeichnung `dedicated=edge` zu. Nachdem ein Workerknoten mit der Bezeichnung `dedicated=edge` markiert wurde, werden alle Ingress- und Lastausgleichsservices auf einem Edge-Workerknoten bereitgestellt.

  ```
  kubectl label nodes <knotenname> <knotenname2> dedicated=edge
  ```
  {: pre}

3. Rufen Sie alle vorhandenen Lastausgleichsservices in Ihrem Cluster auf.

  ```
  kubectl get services --all-namespaces -o jsonpath='{range .items[*]}kubectl get service -n {.metadata.namespace} {.metadata.name} -o yaml | kubectl apply -f - :{.spec.type},{end}' | tr "," "\n" | grep "LoadBalancer" | cut -d':' -f1
  ```
  {: pre}

  Ausgabe:

  ```
  kubectl get service -n <namensbereich> <name> -o yaml | kubectl apply -f
  ```
  {: screen}

4. Kopieren Sie unter Verwendung der Ausgabe aus dem vorherigen Schritt jede Zeile `kubectl get service` und fügen Sie sie ein. Mit diesem Befehl wird die Lastausgleichsfunktion erneut auf einem Edge-Workerknoten bereitgestellt. Nur öffentliche Lastausgleichsfunktionen müssen erneut bereitgestellt werden.

  Ausgabe:

  ```
  service "<name>" configured
  ```
  {: screen}

Sie haben Workerknoten mit der Bezeichnung `dedicated=edge` markiert und alle vorhandenen Lastausgleichs- sowie Ingress-Services erneut auf den Workerknoten bereitgestellt. Verhindern Sie nun als nächsten Schritt, dass andere [Arbeitslasten auf Edge-Workerknoten ausgeführt werden](#edge_workloads) und [blockieren Sie eingehenden Datenverkehr an Knotenports auf Workerknoten](cs_network_policy.html#block_ingress).

<br />


## Verhindern, dass Arbeitslasten auf Edge-Workerknoten ausgeführt werden
{: #edge_workloads}

Ein Vorteil von Edge-Workerknoten besteht darin, dass sie so konfiguriert werden können, dass sie nur Netzservices (Networking Services) ausführen. Die Verwendung der Tolerierung `dedicated=edge` bedeutet, dass alle Lastausgleichs- und Ingress-Services nur auf den markierten Workerknoten ausgeführt werden. Um jedoch zu verhindern, dass andere Arbeitslasten auf Edge-Workerknoten ausgeführt werden und deren Ressourcen verbrauchen, müssen Sie [Kubernetes-Taints ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) verwenden.
{:shortdesc}

1. Listen Sie alle Workerknoten mit der Bezeichnung `edge` auf.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Wenden Sie einen Taint auf alle Workerknoten an, der verhindert, dass Pods auf den entsprechenden Workerknoten ausgeführt werden und der Pods von den Workerknoten entfernt, die nicht die Bezeichnung `edge` aufweisen. Die entfernten Pods werden auf anderen Workerknoten mit entsprechender Kapazität erneut bereitgestellt.

  ```
  kubectl taint node <knotenname> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```

Nun werden nur Pods mit der Tolerierung `dedicated=edge` auf Ihren Edge-Workerknoten bereitgestellt.
