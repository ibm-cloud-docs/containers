---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 設定負載平衡器服務
{: #loadbalancer}

公開埠並使用可攜式 IP 位址，讓負載平衡器可以存取應用程式。使用公用 IP 位址，將應用程式設為可在網際網路上進行存取，或使用專用 IP 位址，將應用程式設為可在專用基礎架構網路上進行存取。
{:shortdesc}

## 使用負載平衡器服務類型來配置應用程式的存取
{: #config}

與 NodePort 服務不同，負載平衡器服務的可攜式 IP 位址不是取決於在其上已部署應用程式的工作者節點。不過，Kubernetes LoadBalancer 服務也是 NodePort 服務。LoadBalancer 服務可讓您的應用程式透過負載平衡器 IP 位址及埠提供使用，並讓您的應用程式可透過服務的節點埠提供使用。
{:shortdesc}

負載平衡器的可攜式 IP 位址會自動進行指派，而且不會在您新增或移除工作者節點時變更。因此，負載平衡器服務的高可用性高於 NodePort 服務。使用者可以選取負載平衡器的任何埠，而不只限於 NodePort 埠範圍。您可以針對 TCP 及 UDP 通訊協定使用負載平衡器服務。

**附註：**負載平衡器服務不支援 TLS 終止。如果您的應用程式需要 TLS 終止，您可以使用 [Ingress](cs_ingress.html) 來公開應用程式，或配置應用程式來管理 TLS 終止。

開始之前：

-   只有標準叢集才能使用此特性。
-   您必須要有可指派給負載平衡器服務的可攜式公用或專用 IP 位址。
-   具有可攜式專用 IP 位址的負載平衡器服務仍然會在每個工作者節點上開啟一個公用節點埠。若要新增網路原則以防止公用資料流量，請參閱[封鎖送入的資料流量](cs_network_policy.html#block_ingress)。

若要建立負載平衡器服務，請執行下列動作：

1.  [將應用程式部署至叢集](cs_app.html#app_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在負載平衡中。
2.  為您要公開的應用程式建立負載平衡器服務。若要讓您的應用程式可在公用網際網路或專用網路上使用，請建立應用程式的 Kubernetes 服務。請配置服務，以將所有構成應用程式的 Pod 包含在負載平衡中。
    1.  例如，建立名稱為 `myloadbalancer.yaml` 的服務配置檔。
    2.  為您要公開的應用程式定義負載平衡器服務。
        - 如果叢集是在公用 VLAN 上，則會使用可攜式公用 IP 位址。大部分叢集都在公用 VLAN 上。
        - 如果您的叢集只能在專用 VLAN 上使用，則會使用可攜式專用 IP 位址。
        - 您可以透過將註釋新增至配置檔，要求 LoadBalancer 服務的可攜式公用或專用 IP 位址。

        使用預設 IP 位址的 LoadBalancer 服務：

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        使用註釋來指定專用或公用 IP 位址的 LoadBalancer 服務：

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <private_ip_address>
        ```
        {: codeblock}

        <table>
        <caption>瞭解 LoadBalancer 服務檔案元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td>將 <em>&lt;myservice&gt;</em> 取代為負載平衡器服務的名稱。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>輸入標籤索引鍵 (<em>&lt;selectorkey&gt;</em>) 及值 (<em>&lt;selectorvalue&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。例如，如果您使用下列選取器 <code>app: code</code>，會將所有其 meta 資料中具有此標籤的 Pod 都包含在負載平衡中。當您將應用程式部署至叢集時，請輸入所使用的相同標籤。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>服務所接聽的埠。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>要指定 LoadBalancer 類型的註釋。值為 `private` 和 `public`。在公用 VLAN 的叢集中建立公用 LoadBalancer 時，不需要此註釋。
        </td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>建立專用 LoadBalancer 或針對公用 LoadBalancer 使用特定的可攜式 IP 位址時，請將 <em>&lt;loadBalancerIP&gt;</em> 取代為您要使用的 IP 位址。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer)。</td>
        </tr>
        </tbody></table>

    3.  選用項目：在 spec 區段中指定 `loadBalancerSourceRanges`，以配置防火牆。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

    4.  在叢集中建立服務。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

                若已建立負載平衡器服務，可攜式 IP 位址即會自動指派給負載平衡器。如果沒有可用的可攜式 IP 位址，則無法建立負載平衡器服務。


3.  驗證已順利建立負載平衡器服務。將 _&lt;myservice&gt;_ 取代為您在前一個步驟中建立之負載平衡器服務的名稱。

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **附註：**這可能需要幾分鐘的時間，才能適當地建立負載平衡器服務，以及提供使用應用程式。

    CLI 輸出範例：

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 位址是已指派給負載平衡器服務的可攜式 IP 位址。
4.  如果您已建立公用負載平衡器，請從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入負載平衡器的可攜式公用 IP 位址及埠。在上述範例中，`192.168.10.38` 可攜式公用 IP 位址已指派給負載平衡器服務。

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}
