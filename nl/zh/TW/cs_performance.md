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

# 調整效能
{: #kernel}

如果您具有特定的效能最佳化需求，則可以在 {{site.data.keyword.containerlong}} 中變更工作者節點及 Pod 網路名稱空間上的 Linux kernel `sysctl` 參數的預設值。
{: shortdesc}

會以最佳化核心效能來自動佈建工作者節點，但您可以藉由將自訂 Kubernetes `DaemonSet` 物件套用至叢集來變更預設值。DaemonSet 會變更所有現有工作者節點的設定，並將這些設定套用至叢集中所佈建的任何新工作者節點。不影響任何 Pod。

若要將應用程式 Pod 的核心設定最佳化，您可以將 initContainer 插入至每個部署的 `pod/ds/rs/deployment` YAML 中。initContainer 會新增至您要將效能最佳化的 Pod 網路名稱空間中的每一個應用程式部署。

例如，下列各節中的範例透過 `net.core.somaxconn` 設定來變更環境中允許的預設連線數上限，及透過 `net.ipv4.ip_local_port_range` 設定來變更暫時埠範圍。

**警告**：如果您選擇變更預設核心參數設定，則需自行承擔風險。您負責針對任何變更的設定執行測試，以及負責處理環境中因變更的設定而造成的任何可能中斷情況。

## 將工作者節點效能最佳化
{: #worker}

套用 [DaemonSet ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)，以變更工作者節點主機上的核心參數。

**附註**：您必須具有[管理者存取角色](cs_users.html#access_policies)，才能執行特許 initContainer 範例。在起始設定用於部署的容器之後，就會捨棄這些專用權。

1. 將下列 DaemonSet 儲存在名為 `worker-node-kernel-settings.yaml` 的檔案中。在 `spec.template.spec.initContainers` 區段中，新增您要調整的 `sysctl` 參數的欄位和值。此 DaemonSet 範例會變更 `net.core.somaxconn` 和 `net.ipv4.ip_local_port_range` 參數的值。
    ```
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    metadata:
      name: kernel-optimization
      namespace: kube-system
      labels:
        tier: management
        app: kernel-optimization
    spec:
      template:
        metadata:
          labels:
            name: kernel-optimization
        spec:
          hostNetwork: true
          hostPID: true
          hostIPC: true
          initContainers:
            - command:
                - sh
                - -c
                - sysctl -w net.ipv4.ip_local_port_range="1025 65535"; sysctl -w net.core.somaxconn=32768;
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
                capabilities:
                  add:
                    - NET_ADMIN
              volumeMounts:
                - name: modifysys
                  mountPath: /sys
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                    sleep 100000;
                  done
          volumes:
            - name: modifysys
              hostPath:
                path: /sys
    ```
    {: codeblock}

2. 將 DaemonSet 套用至您的工作者節點。會立即套用變更。
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

若要使工作者節點的 `sysctl` 參數回復至 {{site.data.keyword.containerlong_notm}} 所設定的預設值：

1. 刪除 DaemonSet。即會移除套用自訂設定的 initContainers。
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [將叢集中的所有工作者節點重新開機](cs_cli_reference.html#cs_worker_reboot)。工作者節點已回到線上，並已套用預設值。

<br />


## 將 Pod 效能最佳化
{: #pod}

如果您有特定的工作負載需求，您可以套用 [initContainer![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) 修補程式來變更應用程式 Pod 的核心參數。
{: shortdesc}

**附註**：您必須具有[管理者存取角色](cs_users.html#access_policies)，才能執行特許 initContainer 範例。在起始設定用於部署的容器之後，就會捨棄這些專用權。

1. 將下列 initContainer 修補程式儲存在名稱為 `pod-patch.yaml` 的檔案中，並新增您要調整的 `sysctl` 參數的欄位和值。此 initContainer 範例會變更 `net.core.somaxconn` 和 `net.ipv4.ip_local_port_range` 參數的值。
    ```
    spec:
      template:
        spec:
          initContainers:
          - command:
            - sh
            - -c
            - sysctl -e -w net.core.somaxconn=32768;  sysctl -e -w net.ipv4.ip_local_port_range="1025 65535";
            image: alpine:3.6
            imagePullPolicy: IfNotPresent
            name: sysctl
            resources: {}
            securityContext:
              privileged: true
    ```
    {: codeblock}

2. 修補每一個部署。
    ```
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. 如果您變更了核心設定中的 `net.core.somaxconn` 值，大部分應用程式都可以自動使用更新的值。然而，有些應用程式可能需要您手動變更應用程式碼中的對應值，以符合核心值。例如，如果您要調整 Pod 的效能，其中 NGINX 應用程式正在執行中，您必須變更 NGINX 應用程式碼中的 `backlog` 欄位的值使其相符。如需相關資訊，請參閱這個 [NGINX 部落格文章![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.nginx.com/blog/tuning-nginx/)。
