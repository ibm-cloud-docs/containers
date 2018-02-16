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

# 设置 VPN 连接
{: #vpn}

VPN 连接允许您将 Kubernetes 集群中的应用程序安全地连接到内部部署网络。您还可以将集群外部的应用程序连接到正在集群内部运行的应用程序。
{:shortdesc}

## 使用 Strongswan IPSec VPN 服务 Helm 图表设置 VPN 连接
{: #vpn-setup}

要设置 VPN 连接，可以使用 Helm 图表来配置并部署 Kubernetes pod 内的 [Strongswan IPSec VPN 服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.strongswan.org/)。然后所有 VPN 流量都通过此 pod 进行路由。有关用于设置 Strongswan 图表的 Helm 命令的更多信息，请参阅 <a href="https://docs.helm.sh/helm/" target="_blank">Helm 文档 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。
{:shortdesc}

开始之前：

- [创建标准集群](cs_clusters.html#clusters_cli)。
- [如果使用的是现有集群，请将其更新为 V1.7.4 或更高版本。](cs_cluster_update.html#master)
- 集群必须至少具有一个可用的公共负载均衡器 IP 地址。
- [设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

要设置与 Strongswan 的 VPN 连接，请执行以下操作：

1. 如果尚未启用，请安装并初始化集群的 Helm。

    1. 安装 <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。

    2. 初始化 Helm 并安装 `tiller`。

        ```
        helm init
        ```
        {: pre}

    3. 验证 `tiller-deploy` pod 是否在集群中具有 `Running` 状态。

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        输出示例：

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. 向 Helm 实例添加 {{site.data.keyword.containershort_notm}} Helm 存储库。

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. 验证是否在 Helm 存储库中列出了 Strongswan 图表。

        ```
        helm search bluemix
        ```
        {: pre}

2. 在本地 YAML 文件中保存 Strongswan Helm 图表的缺省配置设置。

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. 打开 `config.yaml` 文件，并根据所需的 VPN 配置，对缺省值进行以下更改。如果属性具有可选择的特定值，那么这些值将列在该文件内每个属性上方的注释中。**重要信息**：如果不需要更改属性，请通过在属性前面放置 `#` 注释掉该属性。

    <table>
    <caption>了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>如果您有要使用的现有 <code>ipsec.conf</code> 文件，请除去大括号 (<code>{}</code>) 并在此属性后添加文件的内容。文件内容必须缩进。**注：**如果您使用自己的文件，那么不会使用 <code>ipsec</code>、<code>local</code> 和 <code>remote</code> 部分的任何值。</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>如果您有要使用的现有 <code>ipsec.secrets</code> 文件，请除去大括号 (<code>{}</code>) 并在此属性后添加文件的内容。文件内容必须缩进。**注：**如果您使用自己的文件，那么不会使用 <code>preshared</code> 部分的任何值。</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>如果内部部署的 VPN 通道端点不支持 <code>ikev2</code> 作为初始化连接的协议，请将此值更改为 <code>ikev1</code>。</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>将此值更改为内部部署 VPN 通道端点用于连接的 ESP 加密/认证算法列表。</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>将此值更改为内部部署 VPN 通道端点用于连接的 IKE/ISAKMP SA 加密/认证算法列表。</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>如果希望集群启动 VPN 连接，请将此值更改为 <code>start</code>。</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>将此值更改为应该通过 VPN 连接显示在内部部署网络上的集群子网 CIDR 的列表。此列表可以包含以下子网：<ul><li>Kubernetes pod 子网 CIDR：<code>172.30.0.0/16</code></li><li>Kubernetes 服务子网 CIDR：<code>172.21.0.0/16</code></li><li>工作程序节点的专用子网 CIDR（如果应用程序由专用网络上的 NodePort 服务显示）。要查找此值，请运行 <code>bx cs subnets | grep <xxx.yyy.zzz></code>，其中 &lt;xxx.yyy.zzz&gt; 是工作程序节点的专用 IP 地址的前 3 个八位字节。</li><li>集群的专用或用户管理的子网 CIDR（如果应用程序由专用网络上的 LoadBalancer 服务显示）。要查找这些值，请运行 <code>bx cs cluster-get <cluster name> --showResources</code>。在 <b>VLANS</b> 部分中，查找 <b>Public</b> 值为 <code>false</code> 的 CIDR。</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>将此值更改为 VPN 通道端点用于连接的本地 Kubernetes 集群端的字符串标识。</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>将此值更改为内部部署 VPN 网关的公共 IP 地址。</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>将此值更改为允许 Kubernetes 集群访问的内部部署专用子网 CIDR 的列表。</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>将此值更改为 VPN 通道端点用于连接的远程内部部署端的字符串标识。</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>将此值更改为内部部署 VPN 通道端点网关用于连接的预共享密钥。</td>
    </tr>
    </tbody></table>

4. 保存更新的 `config.yaml` 文件。

5. 使用更新的 `config.yaml` 文件将 Helm 图表安装到集群。更新的属性存储在图表的配置映射中。

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. 检查图表部署状态。当图表就绪时，输出顶部附近的 **STATUS** 字段的值为 `DEPLOYED`。

    ```
    helm status vpn
    ```
    {: pre}

7. 部署图表后，请验证是否使用了 `config.yaml` 文件中的已更新设置。

    ```
    helm get values vpn
    ```
    {: pre}

8. 测试新的 VPN 连接。
    1. 如果内部部署网关上的 VPN 处于不活动状态，请启动 VPN。

    2. 设置 `STRONGSWAN_POD` 环境变量。

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. 检查 VPN 的状态。状态 `ESTABLISHED` 表示 VPN 连接成功。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        输出示例：
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

        **注**：
          - 首次使用此 Helm 图表时，VPN 的状态很可能不是 `ESTABLISHED`。您可能需要检查内部部署 VPN 端点设置并返回到步骤 3 以更改 `config.yaml` 文件数次，连接才能成功。
          - 如果 VPN pod 处于 `ERROR` 状态或继续崩溃并重新启动，那么可能是由于在图表的配置映射中对 `ipsec.conf` 设置进行了参数验证。要查看是否是这个原因，请通过运行 `kubectl logs -n kube-system $STRONGAN_POD` 来检查 Strongswan pod 日志中是否存在任何验证错误。如果存在验证错误，请运行 `helm delete --purge vpn`，返回到步骤 3 以修正 `config.yaml` 文件中的错误值，并重复步骤 4 到 8。如果集群具有大量工作程序节点，那么还可以使用 `helm upgrade` 来更迅速地应用更改，而不是运行 `helm delete` 和 `helm install`。

    4. VPN 的状态为 `ESTABLISHED` 后，请使用 `ping` 测试连接。以下示例将 ping 从 Kubernetes 集群中的 VPN pod 发送到内部部署 VPN 网关的专用 IP 地址。请确保在配置文件中指定了正确的 `remote.subnet` 和 `local.subnet`，并且本地子网列表包含发送 ping 的源 IP 地址。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

### 禁用 Strongswan IPSec VPN 服务
{: vpn_disable}

1. 删除 Helm 图表。

    ```
    helm delete --purge vpn
    ```
    {: pre}
