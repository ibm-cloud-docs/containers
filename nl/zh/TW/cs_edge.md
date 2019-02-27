---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# 限制送至邊緣工作者節點的網路資料流量
{: #edge}

邊緣工作者節點可以藉由容許較少的工作者節點可在外部進行存取，以及隔離 {{site.data.keyword.containerlong}} 中的網路工作負載，來增進 Kubernetes 叢集的安全。
{:shortdesc}

僅在標示這些工作者節點可以進行網路連線時，其他工作負載才無法取用工作者節點的記憶體，並干擾網路連線。


如果您有多區域叢集且想要將網路資料流量限制為邊緣工作者節點，則必須在每一個區域中至少啟用 2 個邊緣工作者節點，以取得負載平衡器或 Ingress Pod 的高可用性。建立邊緣節點工作者節點儲存區，以跨越叢集裡的所有區域，而每個區域至少具有 2 個工作者節點。
{: tip}

## 將工作者節點標示為邊緣節點
{: #edge_nodes}

將 `dedicated=edge` 標籤新增至叢集裡每一個公用 VLAN 的兩個以上工作者節點，以確保 Ingress 及負載平衡器只會部署至那些工作者節點。
{:shortdesc}

開始之前：

1. 確定您具有任何 {{site.data.keyword.Bluemix_notm}} IAM [平台角色](cs_users.html#platform)。
2. [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。
3. 確保您的叢集至少具有一個公用 VLAN。僅具有專用 VLAN 的叢集無法使用邊緣工作者節點。
4. [建立新工作者節點儲存區](cs_clusters.html#add_pool)，以跨越叢集裡的所有區域，而每個區域至少具有 2 個工作者節點。

若要將工作者節點標示為邊緣節點，請執行下列動作：

1. 列出邊緣節點工作者節點儲存區中的工作者節點。請使用**專用 IP** 位址來識別節點。

  ```
  ibmcloud ks workers <cluster_name_or_ID> --worker-pool <edge_pool_name>
  ```
  {: pre}

2. 使用 `dedicated=edge` 來標示工作者節點。在使用 `dedicated=edge` 標示工作者節點之後，所有後續的 Ingress 及負載平衡器都會部署至邊緣工作者節點。

  ```
  kubectl label nodes <node1_IP> <node2_IP> dedicated=edge
  ```
  {: pre}

3. 擷取叢集裡所有現有的負載平衡器及 Ingress 應用程式負載平衡器 (ALB)。

  ```
  kubectl get services --all-namespaces
  ```
  {: pre}

  在輸出中，尋找**類型**為 **LoadBalancer** 的服務。請記下每一個負載平衡器服務的**名稱空間**和**名稱**。例如，在下列輸出中，有 3 個負載平衡器服務：`default` 名稱空間中的負載平衡器 `webserver-lb`，以及 `kube-system` 名稱空間中的 Ingress ALB、`public-crdf253b6025d64944ab99ed63bb4567b6-alb1` 和 `public-crdf253b6025d64944ab99ed63bb4567b6-alb2`。

  ```
  NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
  default       kubernetes                                       ClusterIP      172.21.0.1       <none>          443/TCP                      1h
  default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                 10m
  kube-system   heapster                                         ClusterIP      172.21.101.189   <none>          80/TCP                       1h
  kube-system   kube-dns                                         ClusterIP      172.21.0.10      <none>          53/UDP,53/TCP                1h
  kube-system   kubernetes-dashboard                             ClusterIP      172.21.153.239   <none>          443/TCP                      1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.48.228.78   80:30286/TCP,443:31363/TCP   1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb2   LoadBalancer   172.21.229.73    169.46.17.6     80:31104/TCP,443:31138/TCP   57m
  ```
  {: screen}

4. 使用前一個步驟的輸出，對每一個負載平衡器及 Ingress ALB 執行下列指令。這個指令會將負載平衡器或 Ingress ALB 重新部署至邊緣工作者節點。只有公用負載平衡器或 ALB 必須重新部署。

  ```
  kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
  ```
  {: pre}

  輸出範例：

  ```
  service "my_loadbalancer" configured
  ```
  {: screen}

您已使用 `dedicated=edge` 來標示工作者節點，並已將所有現有的負載平衡器及 Ingress 重新部署至邊緣工作者節點。接下來，請避免其他[工作負載在邊緣工作者節點上執行](#edge_workloads)，以及[封鎖對工作者節點上 NodePort 的入埠資料流量](cs_network_policy.html#block_ingress)。

<br />


## 避免工作負載在邊緣工作者節點上執行
{: #edge_workloads}

邊緣工作者節點的一項好處是它們可以指定為僅執行網路服務。
{:shortdesc}

使用 `dedicated=edge` 容忍，表示所有負載平衡器及 Ingress 服務都只會部署至已標示的工作者節點。不過，為了避免其他工作負載在邊緣工作者節點上執行，以及取用工作者節點資源，您必須使用 [Kubernetes 污點 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/)。


開始之前：[登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

1. 列出所有具有 `dedicated=edge` 標籤的工作者節點。

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. 將污點套用至每一個工作者節點，以避免 Pod 在工作者節點上執行，並從工作者節點移除沒有 `dedicated=edge` 標籤的 Pod。移除的 Pod 會重新部署在有容量的其他工作者節點上。

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```
  {: pre}
現在，僅具有 `dedicated=edge` 容忍的 Pod 才會部署至您的邊緣工作者節點。

3. 如果您選擇[針對負載平衡器 1.0 服務啟用來源 IP 保留 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)，請確保藉由[將邊緣節點親緣性新增至應用程式 Pod](cs_loadbalancer.html#edge_nodes)，在邊緣工作者節點上排定應用程式 Pod。必須在邊緣節點上排定應用程式 Pod，才能接收送入要求。
