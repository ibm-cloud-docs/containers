---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 使用网络策略控制流量
{: #network_policies}

每个 Kubernetes 集群均设置有名为 Calico 的网络插件。缺省网络策略设置为保护每个工作程序节点的公用网络接口的安全。当您有独特的安全需求时，可以使用 Calico 和本机 Kubernetes 功能来为集群配置更多网络策略。这些网络策略会指定是要允许还是阻止与集群中的 pod 之间进出的网络流量。
{: shortdesc}

可以从 Calico 和本机 Kubernetes 功能中进行选择来为集群创建网络策略。一开始可使用 Kubernetes 网络策略，但为了获得更稳健的功能，请使用 Calico 网络策略。

<ul>
  <li>[Kubernetes 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)：提供了一些基本选项，例如指定哪些 pod 可以相互通信。对于协议和端口，可以允许或阻止入局网络流量。可以依据正尝试连接到其他 pod 的 pod 的标签和 Kubernetes 名称空间，过滤此流量。</br>可以使用 `kubectl` 命令或 Kubernetes API 来应用这些策略。这些策略应用后，即会转换成 Calico 网络策略，Calico 会强制实施这些策略。</li>
  <li>[Calico 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy)：这些策略是 Kubernetes 网络策略的超集，通过以下功能增强了本机 Kubernetes 能力。</li>
    <ul><ul><li>允许或阻止特定网络接口上的网络流量，而不仅仅是 Kubernetes pod 流量。</li>
    <li>允许或阻止入局 (流入）和出局 (外流) 网络流量。</li>
    <li>[阻止流至 LoadBalancer 或 NodePort Kubernetes 服务的入局（Ingress）流量](#block_ingress)。</li>
    <li>允许或阻止基于源或目标 IP 地址或 CIDR 的流量。</li></ul></ul></br>

这些策略通过使用 `calicoctl` 命令来应用。Calico 会通过在 Kubernetes 工作程序节点上设置 Linux iptable 规则来强制实施这些策略，包括转换为 Calico 策略的任何 Kubernetes 网络策略。iptable 规则充当工作程序节点的防火墙，可定义网络流量为能够转发到目标资源而必须满足的特征。</ul>

<br />


## 缺省策略配置
{: #default_policy}

创建集群时，会自动为每个工作程序节点的公用网络接口设置缺省网络策略，以限制来自公共因特网的工作程序节点的入局流量。这些策略不会影响 pod 到 pod 的流量，并设置为允许访问 Kubernetes NodePort、LoadBalancer 和 Ingress 服务。
{:shortdesc}

不会直接将缺省策略应用于 pod；缺省策略使用 Calico 主机端点应用于工作程序节点的公用网络接口。在 Calico 中创建主机端点后，除非策略允许与工作程序节点网络接口之间进出的所有流量，否则将阻止该流量。

**重要信息**：不要除去应用于主机端点的策略，除非您充分了解策略并确定无需该策略允许的流量。


 <table summary="表中的第一行跨两列。其余行应从左到右阅读，其中第一列是服务器位置，第二列是要匹配的 IP 地址。">
  <caption>每个集群的缺省策略</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 每个集群的缺省策略</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>允许所有出站流量。</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>允许端口 52311 的入局流量流至 bigfix 应用程序，以允许执行必需的工作程序节点更新。</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>允许入局 icmp 包 (ping)。</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>允许入局 NodePort、LoadBalancer 和 Ingress 服务流量流入这些服务公开的 pod。请注意，这些服务在公共接口上公开的端口不必加以指定，因为 Kubernetes 会使用目标网络地址转换 (DNAT) 将这些服务请求转发到正确的 pod。这一转发过程在 iptable 中应用主机端点策略之前执行。</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>允许用于管理工作程序节点的特定 IBM Cloud infrastructure (SoftLayer) 系统的入局连接。</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>允许使用 vrrp 包，这些包用于监视虚拟 IP 地址并在工作程序节点之间移动这些 IP 地址。</td>
   </tr>
  </tbody>
</table>

<br />


## 添加网络策略
{: #adding_network_policies}

在大多数情况下，缺省策略无需更改。只有高级场景可能需要更改。如果发现必须进行更改，请安装 Calico CLI 并创建自己的网络策略。
{:shortdesc}

开始之前：

1.  [安装 {{site.data.keyword.containershort_notm}} 和 Kubernetes CLI](cs_cli_install.html#cs_cli_install)。
2.  [创建免费或标准集群](cs_clusters.html#clusters_ui)。
3.  [设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。在 `bx cs cluster-config` 命令中包含 `--admin` 选项，以用于下载证书和许可权文件。此下载还包含超级用户角色的密钥，以供运行 Calico 命令时使用。

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **注**：支持 Calico CLI V1.6.1。

要添加网络策略，请执行以下操作：
1.  安装 Calico CLI。
    1.  [下载 Calico CLI ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1)。

        **提示：**如果使用的是 Windows，请将 Calico CLI 安装在 {{site.data.keyword.Bluemix_notm}} CLI 所在的目录中。此安装将在您以后运行命令时减少一些文件路径更改操作。

    2.  对于 OSX 和 Linux 用户，请完成以下步骤。
        1.  将可执行文件移至 /usr/local/bin 目录。
            -   Linux：


              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS X：

              ```
              mv /<path_to_file>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  使文件可执行。

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  通过检查 Calico CLI 客户机版本，验证 `calico` 命令是否正常运行。

        ```
        calicoctl version
        ```
        {: pre}

    4.  如果企业网络策略阻止通过代理或防火墙从本地系统访问公共端点，请参阅[从防火墙后运行 `calicoctl` 命令](cs_firewall.html#firewall)，以获取有关如何允许通过 Calico 命令进行 TCP 访问的指示信息。

2.  配置 Calico CLI。

    1.  对于 Linux 和 OS X，创建 `/etc/calico` 目录。对于 Windows，可以使用任何目录。

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  创建 `calicoctl.cfg` 文件。
        -   Linux 和 OS X：

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows：使用文本编辑器创建该文件。

    3.  在 <code>calicoctl.cfg</code> 文件中输入以下信息。

        ```
      apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD_URL>
          etcdKeyFile: <CERTS_DIR>/admin-key.pem
          etcdCertFile: <CERTS_DIR>/admin.pem
          etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
      ```
        {: codeblock}

        1.  检索 `<ETCD_URL>`. 如果此命令失败，并返回 `calico-config not found` 错误，请参阅此[故障诊断主题](cs_troubleshoot.html#cs_calico_fails)。

          -   Linux 和 OS X：

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   输出示例：

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows：<ol>
            <li>从配置映射获取 Calico 配置值。</br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>在 `data` 部分中，找到 etcd_endpoints 值。示例：<code>https://169.1.1.1:30001</code></ol>

        2.  检索 `<CERTS_DIR>`，即 Kubernetes 证书的下载目录。

            -   Linux 和 OS X：

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                输出示例：

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows：

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                输出示例：

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **注**：要获取目录路径，请除去输出末尾的文件名 `kube-config-prod-<location>-<cluster_name>.yml`。

        3.  检索 <code>ca-*pem_file<code>。

            -   Linux 和 OS X：

              ```
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows：<ol><li>打开在最后一步中检索到的目录。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
              <li> 找到 <code>ca-*pem_file</code> 文件。</ol>

        4.  验证 Calico 配置是否在正常运行。

            -   Linux 和 OS X：

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows：

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
              ```
              {: pre}

              输出：

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  检查现有网络策略。

    -   查看 Calico 主机端点。

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   查看为集群创建的所有 Calico 和 Kubernetes 网络策略。此列表包含可能还未应用于任何 pod 或主机的策略。要强制实施网络策略，该策略必须找到与 Calico 网络策略中定义的选择器相匹配的 Kubernetes 资源。

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   查看网络策略的详细信息。

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   查看集群的所有网络策略的详细信息。

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  创建 Calico 网络策略以允许或阻止流量。

    1.  通过创建配置脚本 (.yaml) 来定义 [Calico 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)。这些配置文件包含选择器，用于描述这些策略应用于哪些 pod、名称空间或主机。请参阅这些[样本 Calico 策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) 以帮助您创建自己的策略。

    2.  将策略应用于集群。
        -   Linux 和 OS X：

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows：

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}

<br />


## 阻止流至 LoadBalancer 或 NodePort 服务的入局流量。
{: #block_ingress}

缺省情况下， Kubernetes `NodePort` 和 `LoadBalancer` 服务旨在使应用程序在所有公用和专用集群接口上都可用。但是，您可以基于流量源或目标，阻止流至服务的入局流量。要阻止流量，请创建 Calico `preDNAT` 网络策略。
{:shortdesc}

Kubernetes LoadBalancer 服务也是 NodePort 服务。LoadBalancer 服务通过负载均衡器 IP 地址和端口提供应用程序，并通过服务的节点端口使应用程序可用。对于集群内的每个节点，在每个 IP 地址（公共和专用）上都可以访问节点端口。

集群管理员可以使用 Calico `preDNAT` 网络策略来阻止：

  - 流至 NodePort 服务的流量。允许使用流至 LoadBalancer 服务的流量。
  - 基于源地址或 CIDR 的流量。

Calico `preDNAT` 网络策略的一些常见用法：

  - 阻止流至专用 LoadBalancer 服务的公共节点端口的流量。
  - 阻止流至正在运行[边缘工作程序节点](cs_edge.html#edge)的集群上公共节点端口的流量。阻止节点端口可确保边缘工作程序节点是处理入局流量的唯一工作程序节点。

`preDNAT` 网络策略非常有用，因为在保护 Kubernetes NodePort 和 LoadBalancer 服务的情况下，由于会为这些服务生成 DNAT iptables 规则，所以很难应用缺省的 Kubernetes 和 Calico 策略。

Calico `preDNAT` 网络策略基于 [Calico 网络策略资源 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) 生成 iptables 规则。

1. 定义 Calico `preDNAT` 网络策略，以对 Kubernetes 服务进行 Ingress 访问。

  用于阻止所有节点端口的示例：

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. 应用 Calico preDNAT 网络策略。在整个集群中应用策略更改大约需要 1 分钟时间。

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}
