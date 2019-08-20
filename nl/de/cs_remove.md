---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

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
{:gif: data-image-type='gif'}

# Cluster entfernen
{: #remove}

Kostenlose Cluster und Standardcluster, die mit einem belastbaren Konto erstellt wurden, müssen manuell entfernt werden, wenn sie nicht mehr benötigt werden, damit sie nicht länger Ressourcen verbrauchen.
{:shortdesc}

<p class="important">
In Ihrem persistenten Speicher werden keine Sicherungen Ihres Clusters oder Ihrer Daten erstellt. Wenn Sie einen Cluster löschen, können Sie auswählen, Ihren persistenten Speicher zu löschen. Persistenter Speicher, den Sie mit einer Speicherklasse mit der Angabe `delete` bereitgestellt haben, wird in der IBM Cloud-Infrastruktur permanent gelöscht, wenn Sie auswählen, Ihren persistenten Speicher zu löschen. Wenn Sie Ihren persistenten Speicher mit einer Speicherklasse mit der Angabe `retain` bereitgestellt haben und auswählen, Ihren Speicher zu löschen, werden der Cluster, der persistente Datenträger (PV) und der PersistentVolumeClaim (PVC) gelöscht, während die persistente Speicherinstanz in Ihrem Konto für die IBM Cloud-Infrastruktur bestehen bleibt.</br>
</br>Wenn Sie einen Cluster entfernen, entfernen Sie auch alle Teilnetze, die automatisch bereitgestellt wurden, als Sie den Cluster erstellt haben, und solche, die Sie mithilfe des Befehls `ibmcloud ks cluster-subnet-create` erstellt haben. Wenn Sie jedoch vorhandene Teilnetze manuell mithilfe des Befehls `ibmcloud ks cluster-subnet-add command` zu Ihrem Cluster hinzugefügt haben, werden diese Teilnetze nicht aus Ihrem IBM Cloud-Infrastrukturkonto entfernt und können in anderen Clustern wiederverwendet werden.</p>

Vorbereitende Schritte:
* Notieren Sie sich Ihre Cluster-ID. Möglicherweise benötigen Sie die Cluster-ID, um zugehörige Ressourcen der IBM Cloud-Infrastruktur zu untersuchen und zu entfernen, die nicht automatisch mit Ihrem Cluster gelöscht werden.
* Wenn Sie die Daten in Ihrem persistenten Speicher löschen möchten, [sollten Sie mit den Löschoptionen vertraut sein](/docs/containers?topic=containers-cleanup#cleanup).
* Stellen Sie sicher, dass Sie die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Administrator**](/docs/containers?topic=containers-users#platform) innehaben.

Gehen Sie wie folgt vor, um einen Cluster zu entfernen:
 
1. Optional: Speichern Sie über die CLI eine Kopie aller Daten in Ihrem Cluster in einer lokalen YAML-Datei.
  ```
  kubectl get all --all-namespaces -o yaml
  ```
  {: pre}

2. Entfernen Sie den Cluster.
  - Vorgehensweise bei Verwendung der {{site.data.keyword.cloud_notm}}-Konsole:
    1.  Wählen Sie Ihren Cluster aus und klicken Sie im Menü **Weitere Aktionen...** auf **Löschen**.

  - Vorgehensweise bei Verwendung der {{site.data.keyword.cloud_notm}}-CLI:
    1.  Listen Sie die verfügbaren Cluster auf.

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  Löschen Sie den Cluster.

        ```
        ibmcloud ks cluster-rm --cluster <clustername_oder_-id>
        ```
        {: pre}

    3.  Befolgen Sie die Eingabeaufforderungen und wählen Sie aus, ob Clusterressourcen, darunter Container, Pods, gebundene Services, persistenter Speicher und geheime Schlüssel, gelöscht werden sollen.
      - **Persistenter Speicher**: Persistenter Speicher stellt Hochverfügbarkeit für Ihre Daten bereit. Wenn Sie mithilfe einer [vorhandenen Dateifreigabe](/docs/containers?topic=containers-file_storage#existing_file) einen Persistent Volume Claim (PVC) erstellt haben, dann können Sie beim Löschen des Clusters die Dateifreigabe nicht löschen. Sie müssen die Dateifreigabe zu einem späteren Zeitpunkt manuell aus Ihrem Portfolio der IBM Cloud-Infrastruktur löschen.

          Bedingt durch den monatlichen Abrechnungszyklus kann ein Persistent Volume Claim (PVC) nicht am letzten Tag des Monats gelöscht werden. Wenn Sie den Persistent Volume Claim am letzten Tag des Monats entfernen, verbleibt die Löschung bis zum Beginn des nächsten Monats in einem anstehenden Zustand.
          {: note}

Nächste Schritte:
- Nachdem ein Cluster nicht länger in der Liste verfügbarer Cluster enthalten ist, wenn Sie den Befehl `ibmcloud ks clusters` ausführen, können Sie den Namen eines entfernten Clusters wiederverwenden.
- Wenn Sie die Teilnetze behalten, können Sie [sie in einem neuen Cluster wiederverwenden](/docs/containers?topic=containers-subnets#subnets_custom) oder manuell zu einem späteren Zeitpunkt aus dem Portfolio der IBM Cloud-Infrastruktur löschen.
- Wenn Sie den persistenten Speicher beibehalten haben, können Sie den [Speicher](/docs/containers?topic=containers-cleanup#cleanup) später über das Dashboard der IBM Cloud-Infrastruktur in der {{site.data.keyword.cloud_notm}}-Konsole löschen.



