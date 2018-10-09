---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

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

每个 Kubernetes 集群均设置有名为 Calico 的网络插件。缺省网络策略设置为保护 {{site.data.keyword.containerlong}} 中每个工作程序节点的公用网络接口的安全。
{: shortdesc}

如果您有独特的安全需求或者具有启用了 VLAN 生成的多专区集群，那么可以使用 Calico 和 Kubernetes 来为集群创建网络策略。通过 Kubernetes 网络策略，可以指定要允许或阻止与集群中的 pod 之间进出的网络流量。要设置更高级的网络策略（例如阻止流至 LoadBalancer 服务的入站（流入）流量），请使用 Calico 网络策略。

<ul>
  <li>
  [Kubernetes 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)：这些策略指定 pod 可以如何与其他 pod 以及与外部端点进行通信。自 Kubernetes V1.8 开始，可以根据协议、端口以及源或目标 IP 地址来允许或阻止入局和出局网络流量。还可以根据 pod 和名称空间标签对流量进行过滤。Kubernetes 网络策略通过使用 `kubectl` 命令或 Kubernetes API 来应用。这些策略应用后，即会自动转换成 Calico 网络策略，Calico 会强制实施这些策略。</li>
  <li>
  Kubernetes V[1.10 和更高版本集群 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) 或 [1.9 和更低版本集群的 Calico 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy)：这些策略是 Kubernetes 网络策略的超集，通过使用 `calicoctl` 命令来应用。Calico 策略添加了以下功能。
    <ul>
    <li>允许或阻止特定网络接口上的网络流量，而不考虑 Kubernetes pod 源或目标 IP 地址或 CIDR。</li>
    <li>允许或阻止各名称空间中的 pod 的网络流量。</li>
    <li>[阻止流至 LoadBalancer 或 NodePort Kubernetes 服务的入站（流入）流量](#block_ingress)。</li>
    </ul>
  </li>
  </ul>

Calico 会通过在 Kubernetes 工作程序节点上设置 Linux iptables 规则来强制实施这些策略，包括自动转换为 Calico 策略的任何 Kubernetes 网络策略。iptable 规则充当工作程序节点的防火墙，可定义网络流量为能够转发到目标资源而必须满足的特征。

要使用 Ingress 和 LoadBalancer 服务，请使用 Calico 和 Kubernetes 策略来管理流入和流出集群的网络流量。不要使用 IBM Cloud Infrastructure (SoftLayer) [安全组](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups)。IBM Cloud Infrastructure (SoftLayer) 安全组会应用于单个虚拟服务器的网络接口，以过滤系统管理程序级别的流量。但是，安全组不支持 VRRP 协议，{{site.data.keyword.containerlong_notm}} 使用该协议来管理 LoadBalancer IP 地址。如果没有 VRRP 协议来管理 LoadBalancer IP，那么 Ingress 和 LoadBalancer 服务无法正常工作。
{: tip}

<br />


## 缺省 Calico 和 Kubernetes 网络策略
{: #default_policy}

创建具有公用 VLAN 的集群时，会自动为每个工作程序节点及其公用网络接口自动创建具有 `ibm.role: worker_public` 标签的 HostEndpoint 资源。 为了保护工作程序节点的公用网络接口，缺省 Calico 策略会应用于任何具有 `ibm.role: worker_public` 标签的主机端点。
{:shortdesc}

这些缺省 Calico 策略允许所有出站网络流量，并允许流至特定集群组件（例如，Kubernees NodePort、LoadBalancer 和 Ingress 服务）的入站流量。将阻止从因特网流至缺省策略中未指定的工作程序节点的其他任何入站网络流量。缺省策略不会影响 pod 到 pod 的流量。

查看自动应用于集群的以下缺省 Calico 网络策略。

**重要信息：**不要除去应用于主机端点的策略，除非您充分了解该策略，并确信无需该策略允许的流量。

 <table summary="表中第一行跨两列。其他行应从左到右阅读，其中第一列是服务器专区，第二列是要匹配的 IP 地址。">
  <caption>每个集群的缺省 Calico 策略</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 每个集群的缺省 Calico 策略</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>允许所有出站流量。</td>
    </tr>
    <tr>
      <td><code>allow-bigfix-port</code></td>
      <td>允许端口 52311 的入局流量流至 BigFix 应用程序，以允许执行必需的工作程序节点更新。</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>允许入局 ICMP 包 (ping)。</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>允许入局 NodePort、LoadBalancer 和 Ingress 服务流量流至这些服务公开的 pod。<strong>注</strong>：您无需指定公开的端口，因为 Kubernetes 会使用目标网络地址转换 (DNAT) 将服务请求转发到正确的 pod。这一转发过程在 iptable 中应用主机端点策略之前执行。</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>允许用于管理工作程序节点的特定 IBM Cloud Infrastructure (SoftLayer) 系统的入局连接。</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>允许使用 VRRP 包，这些包用于监视虚拟 IP 地址并在工作程序节点之间移动这些 IP 地址。</td>
   </tr>
  </tbody>
</table>

在 Kubernetes V1.10 和更高版本的集群中，还会创建缺省 Kubernetes 策略，用于限制对 Kubernetes 仪表板的访问。Kubernetes 策略不会应用于主机端点，而是应用于 `kube-dashboard` pod。此策略应用于仅连接到专用 VLAN 的集群以及同时连接到公用和专用 VLAN 的集群。

<table>
<caption>每个集群的缺省 Kubernetes 策略</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 每个集群的缺省 Kubernetes 策略</th>
</thead>
<tbody>
 <tr>
  <td><code>kubernetes-dashboard</code></td>
  <td><b>仅在 Kubernetes V1.10 中</b>，在 <code>kube-system</code> 名称空间中提供：阻止所有 pod 访问 Kubernetes 仪表板。此策略不会影响通过 {{site.data.keyword.Bluemix_notm}} UI 或使用 <code>kubectl proxy</code> 访问仪表板。如果 pod 需要访问该仪表板，请将 pod 部署到具有 <code>kubernetes-dashboard-policy: allow</code> 标签的名称空间中。</td>
 </tr>
</tbody>
</table>

<br />


## 安装和配置 Calico CLI
{: #cli_install}

要查看、管理和添加 Calico 策略，请安装并配置 Calico CLI。
{:shortdesc}

CLI 配置和策略的 Calico 版本的兼容性随集群的 Kubernetes 版本不同而变化。要安装和配置 Calico CLI，请根据集群版本单击下列其中一个链接：

* [Kubernetes V1.10 或更高版本集群](#1.10_install)
* [Kubernetes V1.9 或更低版本集群](#1.9_install)

在将集群从 Kubernetes V1.9 或更低版本更新到 V1.10 或更高版本之前，请查看[准备更新到 Calico V3](cs_versions.html#110_calicov3)。
{: tip}

### 为运行 Kubernetes V1.10 或更高版本的集群安装和配置 Calico CLI V3.1.1
{: #1.10_install}

开始之前，请[设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)在 `ibmcloud ks cluster-config` 命令中包含 `--admin` 选项，以用于下载证书和许可权文件。此下载还包含密钥以访问基础架构产品服务组合以及在工作程序节点上运行 Calico 命令。

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

要安装和配置 Calico CLI 3.1.1，请执行以下操作：

1. [下载 Calico CLI ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/projectcalico/calicoctl/releases/tag/v3.1.1)。

    如果使用的是 OSX，请下载 `-darwin-amd64` 版本。如果使用的是 Windows，请将 Calico CLI 安装在 {{site.data.keyword.Bluemix_notm}} CLI 所在的目录中。此安装将在您以后运行命令时减少一些文件路径更改操作。确保将文件保存为 `calicoctl.exe`。
    {: tip}

2. 对于 OSX 和 Linux 用户，请完成以下步骤。
    1. 将可执行文件移至 _/usr/local/bin_ 目录。
        - Linux：


          ```
              mv filepath/calicoctl /usr/local/bin/calicoctl
              ```
          {: pre}

        - OS X：

          ```
              mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
          {: pre}

    2. 使该文件成为可执行文件。

        ```
            chmod +x /usr/local/bin/calicoctl
            ```
        {: pre}

3. 通过检查 Calico CLI 客户机版本，验证 `calico` 命令是否正常运行。

    ```
        calicoctl version
        ```
    {: pre}

4. 如果企业网络策略使用代理或防火墙阻止从本地系统访问公共端点，请[允许通过 Calico 命令进行 TCP 访问](cs_firewall.html#firewall)。

5. 对于 Linux 和 OS X，创建 `/etc/calico` 目录。对于 Windows，可以使用任何目录。

  ```
      sudo mkdir -p /etc/calico/
      ```
  {: pre}

6. 创建 `calicoctl.cfg` 文件。
    - Linux 和 OS X：

      ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
      {: pre}

    - Windows：使用文本编辑器创建该文件。

7. 在 <code>calicoctl.cfg</code> 文件中输入以下信息。

    ```
apiVersion: projectcalico.org/v3
    kind: CalicoAPIConfig
    metadata:
    spec:
        datastoreType: etcdv3
        etcdEndpoints: <ETCD_URL>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. 检索 `<ETCD_URL>`.

      - Linux 和 OS X：

          ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
          {: pre}

          输出示例：

          ```
          https://169.xx.xxx.xxx:30000
          ```
          {: screen}

      - Windows：<ol>
        <li>从配置映射获取 Calico 配置值。</br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>在 `data` 部分中，找到 etcd_endpoints 值。示例：<code>https://169.xx.xxx.xxx:30000</code>
        </ol>

    2. 检索 `<CERTS_DIR>`，即 Kubernetes 证书的下载目录。

        - Linux 和 OS X：

          ```
              dirname $KUBECONFIG
              ```
          {: pre}

          输出示例：

          ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
          {: screen}

        - Windows：

          ```
              ECHO %KUBECONFIG%
              ```
          {: pre}

            输出示例：

          ```
              C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
              ```
          {: screen}

        **注**：要获取目录路径，请除去输出末尾的文件名 `kube-config-prod-<zone>-<cluster_name>.yml`。

    3. 检索 `ca-*pem_file`。

        - Linux 和 OS X：

          ```
ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows：<ol><li>打开在最后一步中检索到的目录。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> 找到 <code>ca-*pem_file</code> 文件。</ol>

8. 保存该文件，并确保您位于该文件所在的目录中。

9. 验证 Calico 配置是否在正常运行。

    - Linux 和 OS X：

      ```
              calicoctl get nodes
              ```
      {: pre}

    - Windows：

      ```
              calicoctl get nodes --config=filepath/calicoctl.cfg
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


### 为运行 Kubernetes V1.9 或更低版本的集群安装和配置 Calico CLI V1.6.3
{: #1.9_install}

开始之前，请[设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)在 `ibmcloud ks cluster-config` 命令中包含 `--admin` 选项，以用于下载证书和许可权文件。此下载还包含密钥以访问基础架构产品服务组合以及在工作程序节点上运行 Calico 命令。

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

要安装和配置 Calico CLI 1.6.3，请执行以下操作：

1. [下载 Calico CLI ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.3)。

    如果使用的是 OSX，请下载 `-darwin-amd64` 版本。如果使用的是 Windows，请将 Calico CLI 安装在 {{site.data.keyword.Bluemix_notm}} CLI 所在的目录中。此安装将在您以后运行命令时减少一些文件路径更改操作。
    {: tip}

2. 对于 OSX 和 Linux 用户，请完成以下步骤。
    1. 将可执行文件移至 _/usr/local/bin_ 目录。
        - Linux：


          ```
              mv filepath/calicoctl /usr/local/bin/calicoctl
              ```
          {: pre}

        - OS X：

          ```
              mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
          {: pre}

    2. 使该文件成为可执行文件。

        ```
            chmod +x /usr/local/bin/calicoctl
            ```
        {: pre}

3. 通过检查 Calico CLI 客户机版本，验证 `calico` 命令是否正常运行。

    ```
        calicoctl version
        ```
    {: pre}

4. 如果企业网络策略使用代理或防火墙阻止从本地系统访问公共端点：请参阅[从防火墙后运行 `calicoctl` 命令](cs_firewall.html#firewall)，以获取有关如何允许通过 Calico 命令进行 TCP 访问的指示信息。

5. 对于 Linux 和 OS X，创建 `/etc/calico` 目录。对于 Windows，可以使用任何目录。
    ```
      sudo mkdir -p /etc/calico/
      ```
    {: pre}

6. 创建 `calicoctl.cfg` 文件。
    - Linux 和 OS X：

      ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
      {: pre}

    - Windows：使用文本编辑器创建该文件。

7. 在 <code>calicoctl.cfg</code> 文件中输入以下信息。

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

    1. 检索 `<ETCD_URL>`.

      - Linux 和 OS X：

          ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
          {: pre}

      - 输出示例：

          ```
              https://169.xx.xxx.xxx:30001
              ```
          {: screen}

      - Windows：<ol>
        <li>从配置映射获取 Calico 配置值。</br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>在 `data` 部分中，找到 etcd_endpoints 值。示例：<code>https://169.xx.xxx.xxx:30001</code>
            </ol>

    2. 检索 `<CERTS_DIR>`，即 Kubernetes 证书的下载目录。

        - Linux 和 OS X：

          ```
              dirname $KUBECONFIG
              ```
          {: pre}

          输出示例：

          ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
          {: screen}

        - Windows：

          ```
              ECHO %KUBECONFIG%
              ```
          {: pre}

          输出示例：

          ```
              C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
              ```
          {: screen}

        **注**：要获取目录路径，请除去输出末尾的文件名 `kube-config-prod-<zone>-<cluster_name>.yml`。

    3. 检索 `ca-*pem_file`。

        - Linux 和 OS X：

          ```
ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows：<ol><li>打开在最后一步中检索到的目录。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> 找到 <code>ca-*pem_file</code> 文件。</ol>

    4. 验证 Calico 配置是否在正常运行。

        - Linux 和 OS X：

          ```
              calicoctl get nodes
              ```
          {: pre}

        - Windows：

          ```
              calicoctl get nodes --config=filepath/calicoctl.cfg
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

          **重要信息**：Windows 和 OS X 用户每次运行 `calicoctl` 命令时，都必须包含 `--config=filepath/calicoctl.cfg` 标志。

<br />


## 查看网络策略
{: #view_policies}

查看应用于集群的缺省策略及添加的任何网络策略的详细信息。
{:shortdesc}

开始之前：
1. [安装和配置 Calico CLI](#cli_install)。
2. [设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。在 `ibmcloud ks cluster-config` 命令中包含 `--admin` 选项，以用于下载证书和许可权文件。此下载还包含密钥以访问基础架构产品服务组合以及在工作程序节点上运行 Calico 命令。
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

CLI 配置和策略的 Calico 版本的兼容性随集群的 Kubernetes 版本不同而变化。要安装和配置 Calico CLI，请根据集群版本单击下列其中一个链接：

* [Kubernetes V1.10 或更高版本集群](#1.10_examine_policies)
* [Kubernetes V1.9 或更低版本集群](#1.9_examine_policies)

在将集群从 Kubernetes V1.9 或更低版本更新到 V1.10 或更高版本之前，请查看[准备更新到 Calico V3](cs_versions.html#110_calicov3)。
{: tip}

### 查看运行 Kubernetes V1.10 或更高版本的集群中的网络策略
{: #1.10_examine_policies}

Linux 和 Mac 用户不需要在 `calicoctl` 命令中包含 `--config=filepath/calicoctl.cfg` 标志。
{: tip}

1. 查看 Calico 主机端点。

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. 查看为集群创建的所有 Calico 和 Kubernetes 网络策略。此列表包含可能还未应用于任何 pod 或主机的策略。要强制实施网络策略，必须找到与 Calico 网络策略中定义的选择器相匹配的 Kubernetes 资源。

    [网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) 的作用域限定为特定名称空间：
    ```
    calicoctl get NetworkPolicy --all-namespaces -o wide --config=filepath/calicoctl.cfg
    ```
    {:pre}

    [全局网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) 的作用域不限定于特定名称空间：
    ```
    calicoctl get GlobalNetworkPolicy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. 查看网络策略的详细信息。

    ```
    calicoctl get NetworkPolicy -o yaml <policy_name> --namespace <policy_namespace> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. 查看集群的所有全局网络策略的详细信息。

    ```
    calicoctl get GlobalNetworkPolicy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

### 查看运行 Kubernetes V1.9 或更低版本的集群中的网络策略
{: #1.9_examine_policies}

Linux 用户不需要在 `calicoctl` 命令中包含 `--config=filepath/calicoctl.cfg` 标志。
{: tip}

1. 查看 Calico 主机端点。

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. 查看为集群创建的所有 Calico 和 Kubernetes 网络策略。此列表包含可能还未应用于任何 pod 或主机的策略。要强制实施网络策略，必须找到与 Calico 网络策略中定义的选择器相匹配的 Kubernetes 资源。

    ```
    calicoctl get policy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. 查看网络策略的详细信息。

    ```
    calicoctl get policy -o yaml <policy_name> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. 查看集群的所有网络策略的详细信息。

    ```
    calicoctl get policy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

<br />


## 添加网络策略
{: #adding_network_policies}

在大多数情况下，缺省策略无需更改。只有高级场景可能需要更改。如果发现必须进行更改，可以创建您自己的网络策略。
{:shortdesc}

要创建 Kubernetes 网络策略，请参阅 [Kubernetes 网络策略文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)。

要创建 Calico 策略，请使用以下步骤。

开始之前：
1. [安装和配置 Calico CLI](#cli_install)。
2. [设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。在 `ibmcloud ks cluster-config` 命令中包含 `--admin` 选项，以用于下载证书和许可权文件。此下载还包含密钥以访问基础架构产品服务组合以及在工作程序节点上运行 Calico 命令。
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

CLI 配置和策略的 Calico 版本的兼容性随集群的 Kubernetes 版本不同而变化。根据集群版本单击下列其中一个链接：

* [Kubernetes V1.10 或更高版本集群](#1.10_create_new)
* [Kubernetes V1.9 或更低版本集群](#1.9_create_new)

在将集群从 Kubernetes V1.9 或更低版本更新到 V1.10 或更高版本之前，请查看[准备更新到 Calico V3](cs_versions.html#110_calicov3)。
{: tip}

### 在运行 Kubernetes V1.10 或更高版本的集群中添加 Calico 策略
{: #1.10_create_new}

1. 通过创建配置脚本 (`.yaml`) 来定义 Calico [网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) 或[全局网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy)。这些配置文件包含选择器，用于描述这些策略应用于哪些 pod、名称空间或主机。请参阅这些[样本 Calico 策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) 以帮助您创建自己的策略。**注**：Kubernetes V1.10 或更高版本集群必须使用 Calico V3 策略语法。

2. 将策略应用于集群。
    - Linux 和 OS X：

      ```
          calicoctl apply -f policy.yaml
          ```
      {: pre}

    - Windows：

      ```
          calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
          ```
      {: pre}

### 在运行 Kubernetes V1.9 或更低版本的集群中添加 Calico 策略
{: #1.9_create_new}

1. 通过创建配置脚本 (`.yaml`) 来定义 [Calico 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)。这些配置文件包含选择器，用于描述这些策略应用于哪些 pod、名称空间或主机。请参阅这些[样本 Calico 策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) 以帮助您创建自己的策略。**注**：Kubernetes V1.9 或更低版本集群必须使用 Calico V2 策略语法。


2. 将策略应用于集群。
    - Linux 和 OS X：

      ```
          calicoctl apply -f policy.yaml
          ```
      {: pre}

    - Windows：

      ```
          calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
          ```
      {: pre}

<br />


## 控制流至 LoadBalancer 或 NodePort 服务的入站流量
{: #block_ingress}

[缺省情况下](#default_policy)，Kubernetes NodePort 和 LoadBalancer 服务旨在使应用程序在所有公共和专用集群接口上都可用。但是，您可以使用 Calico 策略基于流量源或目标，阻止流至服务的入局流量。
{:shortdesc}

Kubernetes LoadBalancer 服务也是 NodePort 服务。LoadBalancer 服务使应用程序在 LoadBalancer IP 地址和端口上可用，并使应用程序在该服务的 NodePort 上可用。对于集群内的每个节点，在每个 IP 地址（公共和专用）上都可以访问 NodePort。

集群管理员可以使用 Calico `preDNAT` 网络策略来阻止：

  - 流至 NodePort 服务的流量。允许使用流至 LoadBalancer 服务的流量。
  - 基于源地址或 CIDR 的流量。

Calico `preDNAT` 网络策略的一些常见用法：

  - 阻止流至专用 LoadBalancer 服务的公共 NodePort 的流量。
  - 阻止流至运行[边缘工作程序节点](cs_edge.html#edge)的集群上公共 NodePort 的流量。阻止 NodePort 可确保边缘工作程序节点是处理入局流量的唯一工作程序节点。

因为会为 Kubernetes NodePort 和 LoadBalancer 服务生成 DNAT iptables 规则，所以很难应用缺省 Kubernetes 和 Calico 策略来保护这些服务。

Calico `preDNAT` 网络策略可基于 Calico 网络策略资源生成 iptables 规则，因此可以帮助您解决此问题。Kubernetes V1.10 或更高版本集群使用[采用 `calicoctl.cfg` V3 语法的网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy)。Kubernetes V1.9 或更低版本集群使用[采用 `calicoctl.cfg` V2 语法的策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)。

1. 定义 Calico `preDNAT` 网络策略，以允许对 Kubernetes 服务进行流入（入站流量）访问。

    * Kubernetes V1.10 或更高版本集群必须使用 Calico V3 策略语法。

        用于阻止所有 NodePort 的示例资源：

        ```
        apiVersion: projectcalico.org/v3
        kind: GlobalNetworkPolicy
        metadata:
          name: deny-nodeports
        spec:
          applyOnForward: true
          ingress:
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: TCP
            source: {}
          - action: Deny
            destination:
              ports:
              - 30000:32767
        protocol: UDP
        source: {}
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 1100
      types:
          - Ingress
        ```
        {: codeblock}

    * Kubernetes V1.9 或更低版本集群必须使用 Calico V2 策略语法。

        用于阻止所有 NodePort 的示例资源：

        ```
        apiVersion: v1
        kind: policy
        metadata:
          name: deny-nodeports
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

  - Linux 和 OS X：

    ```
    calicoctl apply -f deny-nodeports.yaml
    ```
    {: pre}

  - Windows：

    ```
    calicoctl apply -f filepath/deny-nodeports.yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. 可选：在多专区集群中，MZLB 运行状况检查会检查集群的每个专区中的 ALB，并根据这些运行状况检查来使 DNS 查找结果保持更新。如果使用 DNAT 前策略来阻止流至 Ingress 服务的所有入局流量，那么还必须将用于检查 ALB 运行状况的 [Cloudflare 的 IPv4 IP ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.cloudflare.com/ips/) 列入白名单。有关如何创建 Calico DNAT 前策略以将这些 IP 列入白名单的步骤，请参阅 [Calico 网络策略教程](cs_tutorials_policies.html#lesson3)中的第 3 课。

要查看如何将源 IP 地址列入白名单或黑名单，请试用[使用 Calico 网络策略阻止流量教程](cs_tutorials_policies.html#policy_tutorial)。有关用于控制流入和流出集群的流量的更多示例 Calico 网络策略，可以查看 [Stars Policy Demo ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) 和 [Advanced Network Policy ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy)。
{: tip}

## 隔离专用网络上的集群
{: #isolate_workers}

如果有多专区集群、有多个 VLAN 用于单专区集群，或者在同一 VLAN 上有多个子网，那么必须[启用 VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，以便工作程序节点可以在专用网络上相互通信。但是，当启用 VLAN 生成时，任何连接到相同 IBM Cloud 帐户中的任何专用 VLAN 的系统都可以与工作程序进行通信。

您还可以通过应用 [Calico 专用网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/private-network-isolation)，将集群与专用网络上的其他系统隔离。此组 Calico 策略和主机端点将集群的专用网络流量与帐户专用网络中的其他资源隔离。

策略以工作程序节点专用接口 (eth0) 和集群的 pod 网络为目标。

**工作程序节点**

* 仅允许到 pod IP、此集群中的工作程序以及 UPD/TCP 端口 53（进行 DNS 访问）的专用接口 Egress。
* 仅允许来自集群中的工作程序以及到 DNS、kubelet、ICMP 和 VRRP 的专用接口 Ingress。

**Pod**

* 允许来自集群中工作程序的到 pod 的所有 Ingress。
* 来自 pod 的 Egress 仅限于集群中的公共 IP、DNS、kubelet 和其他 pod。

开始之前：
1. [安装和配置 Calico CLI](#cli_install)。
2. [设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。在 `ibmcloud ks cluster-config` 命令中包含 `--admin` 选项，以用于下载证书和许可权文件。此下载还包含密钥以访问基础架构产品服务组合以及在工作程序节点上运行 Calico 命令。
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

要使用 Calico 策略隔离专用网络上的集群：

1. 克隆 `IBM-Cloud/kube-samples` 存储库。
    ```
    git clone https://github.com/IBM-Cloud/kube-samples.git
    ```
    {: pre}

2. 浏览至集群版本所兼容的 Calico 版本的专用策略目录。
    * Kubernetes V1.10 或更高版本集群：
      ```
      cd <filepath>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v3
      ```
      {: pre}

    * Kubernetes V1.9 或更低版本集群：
      ```
      cd <filepath>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v2
      ```
      {: pre}

3. 设置专用主机端点策略。
    1. 打开 `generic-privatehostendpoint.yaml` 策略。
    2. 将 `<worker_name>` 替换为工作程序节点的名称并将 `<worker-node-private-ip>` 替换为工作程序节点的专用 IP 地址。要查看工作程序节点的专用 IP，请运行 `ibmcloud ks workers --cluster <my_cluster>`。
    3. 针对集群中的每个工作程序节点重复新部分中的此步骤。**注**：每次向集群添加工作程序节点时，必须使用新条目更新主机端点文件。

4. 将所有策略应用于集群。
    - Linux 和 OS X：

      ```
      calicoctl apply -f allow-all-workers-private.yaml
      calicoctl apply -f allow-dns-10250.yaml
      calicoctl apply -f allow-egress-pods.yaml
      calicoctl apply -f allow-icmp-private.yaml
      calicoctl apply -f allow-vrrp-private.yaml
      calicoctl apply -f generic-privatehostendpoint.yaml
      ```
      {: pre}

    - Windows：

      ```
      calicoctl apply -f allow-all-workers-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-dns-10250.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-egress-pods.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-icmp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-vrrp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f generic-privatehostendpoint.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

## 控制 pod 之间的流量
{: #isolate_services}

Kubernetes 策略可保护 pod 不受内部网络流量的影响。可以创建简单的 Kubernetes 网络策略，以在一个名称空间内或跨名称空间使应用程序微服务相互隔离。
{: shortdesc}

有关 Kubernetes 网络策略如何控制 pod 到 pod 流量的更多信息以及更多示例策略，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)。
{: tip}

### 隔离一个名称空间内的应用程序服务
{: #services_one_ns}

以下场景演示了如何管理一个名称空间内应用程序微服务之间的流量。

Accounts 团队在一个名称空间中部署了多个应用程序服务，但这些服务需要隔离，以仅允许微服务之间通过公用网络进行必要的通信。对于应用程序 Srv1，该团队具有前端、后端和数据库服务。该团队使用 `app: Srv1` 标签以及 `tier: frontend`、`tier: backend` 或 `tier: db` 标签标记了每个服务。

<img src="images/cs_network_policy_single_ns.png" width="200" alt="使用网络策略来管理跨名称空间的流量。" style="width:200px; border-style: none"/>

Accounts 团队希望允许来自前端的流量流至后端，并允许来自后端的流量流至数据库。为此，他们在其网络策略中使用了标签，以指定在微服务之间允许哪些流量流动。

首先，他们创建了一个 Kubernetes 网络策略，允许来自前端的流量流至后端：

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: backend-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: frontend
```
{: codeblock}

`spec.podSelector.matchLabels` 部分列出了 Srv1 后端服务的标签，以便该策略仅_应用于_这些 pod。`spec.ingress.from.podSelector.matchLabels` 部分列出了 Srv1 前端服务的标签，以便仅允许_来自_这些 pod 的 Ingress。

接下来，他们创建了一个类似的 Kubernetes 网络策略，允许来自后端的流量流至数据库：

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: db-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: db
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: backend
  ```
  {: codeblock}

`spec.podSelector.matchLabels` 部分列出了 Srv1 数据库服务的标签，以便该策略仅_应用于_这些 pod。`spec.ingress.from.podSelector.matchLabels` 部分列出了 Srv1 后端服务的标签，以便仅允许_来自_这些 pod 的 Ingress。

现在，来自前端的流量可以流至后端，并且来自后端的流量可以流至数据库。数据库可以响应后端，并且后端可以响应前端，但无法建立逆向流量连接。

### 隔离跨名称空间的应用程序服务
{: #services_across_ns}

以下场景演示了如何管理跨多个名称空间的应用程序微服务之间的流量。

不同子团队拥有的服务需要进行通信，但这些服务部署在同一集群内的不同名称空间中。Accounts 团队在 accounts 名称空间中为应用程序 Srv1 部署了前端、后端和数据库服务。Finance 团队在 finance 名称空间中为应用程序 Srv2 部署了前端、后端和数据库服务。这两个团队使用 `app: Srv1` 或 `app: Srv2` 标签以及 `tier: frontend`、`tier: backend` 或 `tier: db` 标签标记了每个服务。他们还使用 `usage: accounts` 或 `usage: finance` 标签标记了名称空间。

<img src="images/cs_network_policy_multi_ns.png" width="475" alt="使用网络策略来管理跨名称空间的流量。" style="width:475px; border-style: none"/>

Finance 团队的 Srv2 需要从 Accounts 团队的 Srv1 后端调用信息。因此，Accounts 团队创建了一个 Kubernetes 网络策略，以使用标签允许来自 finance 名称空间的所有流量流至 accounts 名称空间中的 Srv1 后端。该团队还指定端口 3111 用于隔离仅通过该端口进行的访问。

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  Namespace: accounts
  name: accounts-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      Tier: backend
  ingress:
  - from:
    - NamespaceSelector:
        matchLabels:
          usage: finance
      ports:
        port: 3111
```
{: codeblock}

`spec.podSelector.matchLabels` 部分列出了 Srv1 后端服务的标签，以便该策略仅_应用于_这些 pod。`spec.ingres.from.NamespaceSelector.matchLabels` 部分列出了 finance 名称空间的标签，以便仅允许_来自_该名称空间中服务的 Ingress。

现在，流量可以从 finance 微服务流至 accounts Srv1 后端。accounts Srv1 后端可以响应 finance 微服务，但无法建立逆向流量连接。

**注**：由于无法组合使用 `podSelector` 和 `namespaceSelector`，因此无法允许来自其他名称空间中的特定应用程序 pod 的流量。在此示例中，允许来自 finance 名称空间中所有微服务的所有流量。

## 记录拒绝流量
{: #log_denied}

要记录到集群中特定 pod 的已拒绝的流量请求，可创建 Calico 日志网络策略。
{: shortdesc}

在设置网络策略以将流量限制为应用程序 pod 时，将拒绝并删除这些策略不允许的流量请求。在某些情况下，您可能想要有关已拒绝的流量请求的更多信息。例如，您可能注意到某个网络策略持续拒绝某些不常见流量。要监视潜在安全威胁，可以设置日志记录，以在每次策略拒绝指定的应用程序 pod 上尝试的操作时进行记录。

开始之前：
1. [安装和配置 Calico CLI](#cli_install)。**注**：这些步骤中的策略使用兼容运行 Kubernetes V1.10 或更高版本的集群的 Calico v3 语法。对于运行 Kubernetes V1.9 或更低版本的集群，必须使用 [Calico v2 策略语法 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)。
2. [设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。在 `ibmcloud ks cluster-config` 命令中包含 `--admin` 选项，以用于下载证书和许可权文件。此下载还包含密钥以访问基础架构产品服务组合以及在工作程序节点上运行 Calico 命令。
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

要创建 Calico 策略来记录已拒绝的流量，请执行以下操作：

1. 创建或使用阻止或限制入局流量的现有 Kubernetes 或 Calico 网络策略。例如，要控制 pod 之间的流量，可以使用名为 `access-nginx` 的以下示例 Kubernetes 策略，限制访问 NGINX 应用程序。到标记有“run=nginx”标签的 pod 的入局流量只能来自带有“run=access”标签的 pod。将阻止到“run=nginx”应用程序 pod 的所有其他入局流量。
    ```
    kind: NetworkPolicy
    apiVersion: extensions/v1beta1
    metadata:
      name: access-nginx
    spec:
      podSelector:
        matchLabels:
          run: nginx
      ingress:
        - 自：
          - podSelector:
              matchLabels:
                run: access
    ```
    {: codeblock}

2. 应用该策略。
    * 要应用 Kubernetes 策略：
        ```
        kubectl apply -f <policy_name>.yaml
        ```
        {: pre}
Kubernetes 策略将自动转换为 Calico NetworkPolicy，以便 Calico 可将其应用为 iptable 规则。

    * 要应用 Calico 策略：
        ```
        calicoctl apply -f <policy_name>.yaml --config=<filepath>/calicoctl.cfg
        ```
        {: pre}

3. 如果已应用 Kubernetes 策略，请查看自动创建的 Calico 策略的语法，并复制 `spec.selector` 字段的值。
    ```
    calicoctl get policy -o yaml <policy_name> --config=<filepath>/calicoctl.cfg
    ```
    {: pre}

    例如，在应用并转换后，`access-nginx` 策略具有以下 Calico v3 语法。`spec.selector` 字段具有值 `projectcalico.org/orchestrator == 'k8s' && run == 'nginx'`。
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: access-nginx
    spec:
      ingress:
      - action: Allow
        destination: {}
        source:
          selector: projectcalico.org/orchestrator == 'k8s' && run == 'access'
      order: 1000
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      types:
      - Ingress
        ```
    {: screen}

4. 要记录先前创建的 Calico 策略拒绝的所有流量，请创建名为 `log-denied-packets` 的 Calico NetworkPolicy。例如，使用以下策略以记录在步骤 1 中定义的网络策略所拒绝的所有包。日志策略使用与示例 `access-nginx` 策略相同的 pod 选择器，这会将此策略添加到 Calico iptable 规则链。通过使用更高的排序号，例如，`3000`，可确保将此规则添加到 iptable 规则链的末尾。“run=nginx”pod 接受来自匹配 `access-nginx` 策略规则的“run=access”pod 的任何请求包。但是，当来自任何其他源的包尝试匹配低位 `access-nginx` 策略规则时，将拒绝这些包。然后，这些包尝试匹配高位 `log-denied-packets` 策略规则。`log-denied-packets` 记录到达的任何包，因此仅记录“run=nginx”pod 所拒绝的包。在记录包的尝试后，将删除包。
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: log-denied-packets
    spec:
      types:
      - Ingress
      ingress:
      - action: Log
        destination: {}
        source: {}
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      order: 3000
    ```
    {: codeblock}

    <table>
    <caption>了解日志策略 YAML 组件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解日志策略 YAML 组件</th>
    </thead>
    <tbody>
    <tr>
     <td><code>types</code></td>
     <td>此 <code>Ingress</code> 策略应用入局流量请求。<strong>注：</strong>值 <code>Ingress</code> 是所有入局流量的通用术语，并且不会仅引用来自 IBM Ingress ALB 的流量。</td>
    </tr>
     <tr>
      <td><code>ingress</code></td>
      <td><ul><li><code>action</code>：<code>Log</code> 操作将匹配此策略的任何请求的日志条目写入到工作程序节点上的 `/var/log/syslog` 路径。</li><li><code>destination</code>：不指定任何目标，因为 <code>selector</code> 将此策略应用于具有特定标签的所有 pod。</li><li><code>source</code>：此策略应用于来自任何源的请求。</td>
     </tr>
     <tr>
      <td><code>selector</code></td>
      <td>将 &lt;selector&gt; 替换为步骤 1 中在 Calico 中使用的或者在步骤 3 中针对 Kubernetes 策略在 Calico 语法中找到的 `spec.selector` 字段中的相同选择器。例如，使用选择器 <code>selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'</code>，将此策略的规则作为步骤 1 中的 <code>access-nginx</code> 样本网络策略规则添加到相同的 iptable 链。此策略仅应用于到使用相同 pod 选择器标签的 pod 的入局网络流量。</td>
     </tr>
     <tr>
      <td><code>order</code></td>
      <td>Calico 策略具有确定何时应用于入局请求包的顺序。首先应用低位策略，例如，<code>1000</code>。高位策略在低位策略之后应用。例如，顺序非常高（例如，<code>3000</code>）的策略在应用所有低位策略后才最后应用。</br></br>入局请求包进入 iptable 规则链，并且首先尝试匹配低位策略的规则。如果包匹配任何规则，那么将接受该包。但是，如果包不匹配任何规则，那么将到达 iptable 规则链中顺序最高的最后一个规则。要确保这是链中的最后一个策略，请使用比在步骤 1 中创建的策略高很多的顺序，例如，<code>3000</code>。</td>
     </tr>
    </tbody>
    </table>

5. 应用该策略。
    ```
    calicoctl apply -f log-denied-packets.yaml --config=<filepath>/calicoctl.cfg
    ```
    {: pre}

6. [将日志](cs_health.html#configuring)从 `/var/log/syslog` 转发到 {{site.data.keyword.loganalysislong}} 或外部 syslog 服务器。
