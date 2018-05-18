---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

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

通过 VPN 连接，您可以将 {{site.data.keyword.containerlong}} 上 Kubernetes 集群中的应用程序安全地连接到内部部署网络。您还可以将集群外部的应用程序连接到正在集群内部运行的应用程序。
{:shortdesc}

要将工作程序节点和应用程序连接到内部部署的数据中心，您可以使用 strongSwan 服务或者通过 Vyatta 网关设备或 Fortigate 设备来配置 VPN IPSec 端点。

- **strongSwan IPSec VPN 服务**：您可以设置 [strongSwan IPSec VPN 服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.strongswan.org/)，以将 Kubernetes 集群与内部部署网络安全连接。strongSwan IPSec VPN 服务基于业界标准因特网协议安全性 (IPsec) 协议组，通过因特网提供安全的端到端通信信道。要在集群与内部部署网络之间设置安全连接，您必须在内部部署数据中心内安装 IPsec VPN 网关。然后，可以在 Kubernetes pod 中[配置并部署 strongSwan IPSec VPN 服务](#vpn-setup)。

- **Vyatta 网关设备或 Fortigate 设备**：如果您具有更大的集群，希望通过 VPN 来访问非 Kubernetes 资源，或者希望通过单个 VPN 访问多个集群，那么可选择设置 Vyatta 网关设备或 Fortigate 设备来配置 IPSec VPN 端点。有关更多信息，请参阅有关[将集群连接到内部部署数据中心 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) 的此博客帖子。

## 使用 strongSwan IPSec VPN 服务 Helm 图表设置 VPN 连接
{: #vpn-setup}

使用 Helm 图表在 Kubernetes pod 内配置并部署 strongSwan IPSec VPN 服务。然后所有 VPN 流量都通过此 pod 进行路由。
{:shortdesc}

有关用于设置 strongSwan 图表的 Helm 命令的更多信息，请参阅 <a href="https://docs.helm.sh/helm/" target="_blank">Helm 文档 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。



### 配置 strongSwan Helm 图表
{: #vpn_configure}

开始之前：
* 必须在内部部署数据中心内安装 IPsec VPN 网关。
* [创建标准集群](cs_clusters.html#clusters_cli)或[将现有集群更新到 V1.7.4 或更高版本](cs_cluster_update.html#master)。
* 集群必须至少具有一个可用的公共负载均衡器 IP 地址。[可以检查以确定可用的公共 IP 地址](cs_subnets.html#manage)或[释放使用的 IP 地址](cs_subnets.html#free)。
* [设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

要配置 Helm 图表，请执行以下操作：

1. [为集群安装 Helm，然后将 {{site.data.keyword.Bluemix_notm}} 存储库添加到 Helm 实例](cs_integrations.html#helm)。

2. 在本地 YAML 文件中保存 strongSwan Helm 图表的缺省配置设置。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. 打开 `config.yaml` 文件，并根据所需的 VPN 配置，对缺省值进行以下更改。您可以在配置文件注释中找到更多高级设置的描述。

    **重要信息**：如果不需要更改属性，请通过在属性前面放置 `#` 注释掉该属性。

    <table>
    <col width="22%">
    <col width="78%">
    <caption>了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>localSubnetNAT</code></td>
    <td>子网的网络地址转换 (NAT) 提供了针对本地与内部部署网络之间子网冲突的变通方法。可以使用 NAT 将集群的专用本地 IP 子网、pod 子网 (172.30.0.0/16) 或 pod 服务子网 (172.21.0.0/16) 重新映射到其他专用子网。VPN 隧道看到的是重新映射的 IP 子网，而不是原始子网。在通过 VPN 隧道发送包之前以及来自 VPN 隧道的包到达之后，会发生重新映射。可以通过 VPN 来同时公开重新映射和未重新映射的子网。<br><br>要启用 NAT，可以添加整个子网，也可以添加单个 IP 地址。如果是添加整个子网（格式为 <code>10.171.42.0/24=10.10.10.0/24</code>），那么重新映射方式为 1 对 1：内部网络子网中的所有 IP 地址都会映射到外部网络子网，反之亦然。如果是添加单个 IP 地址（格式为 <code>10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32</code>），那么只有这些内部 IP 地址会映射到指定的外部 IP 地址。<br><br>如果使用此选项，通过 VPN 连接公开的本地子网是“内部”子网将映射到的“外部”子网。</td>
    </tr>
    <tr>
    <td><code>loadBalancerIP</code></td>
    <td>添加分配给此集群的子网中要用于 strongSwan VPN 服务的可移植公共 IP 地址。如果 VPN 连接是从内部部署网关启动的（<code>ipsec.auto</code> 设置为 <code>add</code>），那么可以使用此属性在集群的内部部署网关上配置持久公共 IP 地址。此值是可选的。</td>
    </tr>
    <tr>
    <td><code>nodeSelector</code></td>
    <td>要限制 strongSwan VPN pod 部署到的节点，请添加特定工作程序节点的 IP 地址或添加工作程序节点标签。例如，值 <code>kubernetes.io/hostname: 10.184.110.141</code> 会将 VPN pod 限制为仅在该工作程序节点上运行。值 <code>strongswan: vpn</code> 将 VPN pod 限制为在具有该标签的任何工作程序节点上运行。您可以使用任何工作程序节点标签，但建议您使用 <code>strongswan: &lt;release_name&gt;</code>，以便可以将不同的工作程序节点与此图表的不同部署配合使用。<br><br>如果 VPN 连接是由集群启动的（<code>ipsec.auto</code> 设置为 <code>start</code>），那么可以使用此属性来限制向内部部署网关公开的 VPN 连接源 IP 地址。此值是可选的。</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>如果内部部署 VPN 通道端点不支持 <code>ikev2</code> 作为初始化连接的协议，请将此值更改为 <code>ikev1</code> 或 <code>ike</code>。</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>添加内部部署 VPN 通道端点用于连接的 ESP 加密/认证算法的列表。此值是可选的。如果将此字段保留为空，那么会将缺省 strongSwan 算法 <code>aes128-sha1,3des-sha1</code> 用于连接。</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>添加内部部署 VPN 通道端点用于连接的 IKE/ISAKMP SA 加密/认证算法的列表。此值是可选的。如果将此字段保留为空，那么会将缺省 strongSwan 算法 <code>aes128-sha1-modp2048,3des-sha1-modp1536</code> 用于连接。</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>如果希望集群来启动 VPN 连接，请将此值更改为 <code>start</code>。</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>将此值更改为要通过内部部署网络的 VPN 连接公开的集群子网 CIDR 的列表。此列表可以包含以下子网：<ul><li>Kubernetes pod 子网 CIDR：<code>172.30.0.0/16</code></li><li>Kubernetes 服务子网 CIDR：<code>172.21.0.0/16</code></li><li>工作程序节点的专用子网 CIDR（如果应用程序由专用网络上的 NodePort 服务公开）。要查找此值，请运行 <code>bx cs subnets | grep <xxx.yyy.zzz></code>，其中 <code>&lt;xxx.yyy.zzz&gt;</code> 是工作程序节点的专用 IP 地址的前 3 个八位字节。</li><li>集群的专用或用户管理的子网 CIDR（如果应用程序由专用网络上的 LoadBalancer 服务公开）。要查找这些值，请运行 <code>bx cs cluster-get <cluster name> --showResources</code>。在 <b>VLANS</b> 部分中，查找 <b>Public</b> 值为 <code>false</code> 的 CIDR。</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>将此值更改为 VPN 通道端点用于连接的本地 Kubernetes 集群端的字符串标识。</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>将此值更改为内部部署 VPN 网关的公共 IP 地址。<code>ipsec.auto</code> 设置为 <code>start</code> 时，此值是必需的。</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>将此值更改为允许 Kubernetes 集群访问的内部部署专用子网 CIDR 的列表。</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>将此值更改为 VPN 通道端点用于连接的远程内部部署端的字符串标识。</td>
    </tr>
    <tr>
    <td><code>remote.privateIPtoPing</code></td>
    <td>添加远程子网中要由 Helm 测试验证程序用于 VPN ping 连接测试的专用 IP 地址。此值是可选的。</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>将此值更改为内部部署 VPN 通道端点网关用于连接的预共享密钥。此值存储在 <code>ipsec.secrets</code> 中。</td>
    </tr>
    </tbody></table>

4. 保存更新的 `config.yaml` 文件。

5. 使用更新的 `config.yaml` 文件将 Helm 图表安装到集群。更新的属性会存储在图表的配置映射中。

    **注**：如果在单个集群中有多个 VPN 部署，那么可以通过选择比 `vpn` 描述性更强的发行版名称，以避免命名冲突并区分部署。为了避免截断发行版名称，请将发行版名称限制为不超过 35 个字符。

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn ibm/strongswan
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


### 测试并验证 VPN 连接
{: #vpn_test}

部署 Hem 图表后，请测试 VPN 连接。
{:shortdesc}

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
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
    ```
    {: screen}

    **注**：

    <ul>
    <li>尝试使用 strongSwan Helm 图表建立 VPN 连接时，很有可能 VPN 阶段状态一开始不是 `ESTABLISHED`。您可能需要检查内部部署 VPN 端点设置，并多次更改配置文件，连接才能成功：<ol><li>运行 `helm delete --purge <release_name>`</li><li>修正配置文件中的错误值。</li><li>运行 `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan`</li></ol>您还可以在下一步中运行更多检查。</li>
    <li>如果 VPN pod 处于 `ERROR` 状态或继续崩溃并重新启动，那么可能是因为在图表的配置映射中对 `ipsec.conf` 设置进行了参数验证。<ol><li>请通过运行 `kubectl logs -n kube-system $STRONGSWAN_POD` 来检查 strongSwan pod 日志中是否存在任何验证错误。</li><li>如果存在验证错误，请运行 `helm delete --purge <release_name>`<li>修正配置文件中的错误值。</li><li>运行 `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan`</li></ol>如果集群具有大量工作程序节点，那么还可以使用 `helm upgrade` 来更迅速地应用更改，而不运行 `helm delete` 和 `helm install`。</li>
    </ul>

4. 可以通过运行 strongSwan 图表定义中包含的五个 Helm 测试来进一步测试 VPN 连接。

    ```
    helm test vpn
    ```
    {: pre}

    * 如果所有测试均通过，说明 strongSwan VPN 连接已成功建立。

    * 如果任何测试失败，请继续执行下一步。

5. 通过查看测试 pod 的日志来查看失败测试的输出。

    ```
    kubectl logs -n kube-system <test_program>
    ```
    {: pre}

    **注**：某些测试有一些要求，而这些要求在 VPN 配置中是可选设置。如果某些测试失败，失败可能是可接受的，具体取决于您是否指定了这些可选设置。有关每个测试的更多信息以及测试可能失败的原因，请参阅下表。

    {: #vpn_tests_table}
    <table>
    <caption>了解 Helm VPN 连接测试</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 Helm VPN 连接测试</th>
    </thead>
    <tbody>
    <tr>
    <td><code>vpn-strongswan-check-config</code></td>
    <td>验证通过 <code>config.yaml</code> 文件生成的 <code>ipsec.conf</code> 文件的语法。此测试可能会因为 <code>config.yaml</code> 文件中的值不正确而失败。</td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-check-state</code></td>
    <td>检查 VPN 连接的阶段状态是否为 <code>ESTABLISHED</code>。此测试可能因为以下原因而失败：<ul><li><code>config.yaml</code> 文件中的值与内部部署 VPN 端点设置不同。</li><li>如果集群处于“侦听”方式（<code>ipsec.auto</code> 设置为 <code>add</code>），那么不会在内部部署端建立连接。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td>对 <code>config.yaml</code> 文件中配置的 <code>remote.dgateway</code> 公共 IP 地址执行 ping 操作。此测试可能因为以下原因而失败：<ul><li>未指定内部部署 VPN 网关 IP 地址。如果 <code>ipsec.auto</code> 设置为 <code>start</code>，那么 <code>remote.dgateway</code> IP 地址是必需的。</li><li>VPN 连接的阶段状态不是 <code>ESTABLISHED</code>。有关更多信息，请参阅 <code>vpn-strongswan-check-state</code>。</li><li>VPN 连接状态为 <code>ESTABLISHED</code>，但防火墙阻止了 ICMP 包。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-1</code></td>
    <td>通过集群中的 VPN pod，对内部部署 VPN 网关的 <code>remote.privateIPtoPing</code> 专用 IP 地址执行 ping 操作。此测试可能因为以下原因而失败：<ul><li>未指定 <code>remote.privateIPtoPing</code> IP 地址。如果您是有意不指定 IP 地址，那么此失败是可接受的。</li><li>未在 <code>local.subnet</code> 列表中指定集群 pod 子网 CIDR <code>172.30.0.0/16</code>。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-2</code></td>
    <td>通过集群中的工作程序节点，对内部部署 VPN 网关的 <code>remote.privateIPtoPing</code> 专用 IP 地址执行 ping 操作。此测试可能因为以下原因而失败：<ul><li>未指定 <code>remote.privateIPtoPing</code> IP 地址。如果您是有意不指定 IP 地址，那么此失败是可接受的。</li><li>未在 <code>local.subnet</code> 列表中指定集群工作程序节点专用子网 CIDR。</li></ul></td>
    </tr>
    </tbody></table>

6. 删除当前 Helm 图表。

    ```
    helm delete --purge vpn
    ```
    {: pre}

7. 打开 `config.yaml` 文件并修正不正确的值。

8. 保存更新的 `config.yaml` 文件。

9. 使用更新的 `config.yaml` 文件将 Helm 图表安装到集群。更新的属性会存储在图表的配置映射中。

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

10. 检查图表部署状态。当图表就绪时，输出顶部附近的 **STATUS** 字段的值为 `DEPLOYED`。

    ```
    helm status vpn
    ```
    {: pre}

11. 部署图表后，请验证是否使用了 `config.yaml` 文件中的已更新设置。

    ```
    helm get values vpn
    ```
    {: pre}

12. 清除当前测试 pod。

    ```
    kubectl get pods -a -n kube-system -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -n kube-system -l app=strongswan-test
    ```
    {: pre}

13. 重新运行测试。

    ```
    helm test vpn
    ```
    {: pre}

<br />


## 升级 strongSwan Helm 图表
{: #vpn_upgrade}

通过升级 stronSwan Helm 图表以确保该图表是最新的。
{:shortdesc}

要将 strongSwan Helm 图表升级到最新版本，请执行以下操作：

  ```
  helm upgrade -f config.yaml --namespace kube-system <release_name> ibm/strongswan
  ```
  {: pre}


### 从 V1.0.0 升级
{: #vpn_upgrade_1.0.0}

由于在 V1.0.0 Helm 图表中使用的某些设置，您无法使用 `helm upgrade` 从 1.0.0 更新到最新版本。
{:shortdesc}

要从 V1.0.0 升级，必须删除 1.0.0 图表，然后安装最新版本：

1. 删除 1.0.0 Helm 图表。

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. 在本地 YAML 文件中保存最新版本 strongSwan Helm 图表的缺省配置设置。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. 更新配置文件，并使用这些更改保存该文件。

4. 使用更新的 `config.yaml` 文件将 Helm 图表安装到集群。

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

此外，在 1.0.0 中进行硬编码的某些 `ipsec.conf` 超时设置在更高版本中公开为可配置属性。其中某些可配置的 `ipsec.conf` 超时设置的名称和缺省值也已更改为与 strongSwan 标准更一致。如果要从 Helm 图表 1.0.0 进行升级，并且希望超时设置保留 1.0.0 版本的缺省值，请将新设置添加到使用旧缺省值的图表配置文件。

  <table>
  <caption>V1.0.0 与最新版本之间的 ipsec.conf 设置差异</caption>
  <thead>
  <th>1.0.0 设置名称</th>
  <th>1.0.0 缺省值</th>
  <th>最新版本设置名称</th>
  <th>最新版本缺省值</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ikelifetime</code></td>
  <td>60m</td>
  <td><code>ikelifetime</code></td>
  <td>3h</td>
  </tr>
  <tr>
  <td><code>keylife</code></td>
  <td>20m</td>
  <td><code>lifetime</code></td>
  <td>1h</td>
  </tr>
  <tr>
  <td><code>rekeymargin</code></td>
  <td>3m</td>
  <td><code>margintime</code></td>
  <td>9m</td>
  </tr>
  </tbody></table>


## 禁用 strongSwan IPSec VPN 服务
{: vpn_disable}

可以通过删除 Helm 图表来禁用 VPN 连接。
{:shortdesc}

  ```
  helm delete --purge <release_name>
  ```
  {: pre}
