---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# {{site.data.keyword.containerlong_notm}}的安全性
{: #cs_security}

您可以使用内置安全性功能来进行风险分析和安全保护。这些功能有助于保护集群基础架构和网络通信，隔离计算资源，以及确保基础架构组件和容器部署中的安全合规性。
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png"><img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} 集群安全性" style="width:400px;" /></a>

<table summary="表中的第一行跨两列。其余行应从左到右阅读，其中第一列是服务器位置，第二列是要匹配的 IP 地址。">
  <thead>
  <th colspan=2><img src="images/idea.png"/> {{site.data.keyword.containershort_notm}} 中的内置集群安全设置</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes 主节点</td>
      <td>每个集群中的 Kubernetes 主节点由 IBM 管理，具备高可用性，并且包含 {{site.data.keyword.containershort_notm}} 安全设置，用于确保工作程序节点的安全合规性以及保护与工作程序节点之间的往来通信。IBM 会根据需要执行更新。专用 Kubernetes 主节点集中控制和监视集群中的所有 Kubernetes 资源。根据集群中的部署需求和容量，Kubernetes 主节点会自动安排容器化应用程序在可用的工作节点之间进行部署。有关更多信息，请参阅 [Kubernetes 主节点安全性](#cs_security_master)。</td>
    </tr>
    <tr>
      <td>工作程序节点</td>
      <td>容器部署在工作程序节点上；这些工作程序节点专用于集群，并确保为 IBM 客户提供计算、网络和存储隔离功能。{{site.data.keyword.containershort_notm}} 提供了内置安全性功能，以使工作程序节点在专用和公用网络上保持安全，并确保工作程序节点的安全合规性。有关更多信息，请参阅[工作程序节点安全性](#cs_security_worker)。</td>
     </tr>
     <tr>
      <td>映像</td>
      <td>作为集群管理员，您可以在 {{site.data.keyword.registryshort_notm}} 中设置自己的安全 Docker 映像存储库，在其中可以存储 Docker 映像并在集群用户之间共享这些映像。为了确保容器部署的安全，漏洞顾问程序会扫描专用注册表中的每个映像。漏洞顾问程序是 {{site.data.keyword.registryshort_notm}} 的一个组件，用于扫描以查找潜在的漏洞，提出安全性建议，并提供解决漏洞的指示信息。有关更多信息，请参阅 [{{site.data.keyword.containershort_notm}} 中的映像安全性](#cs_security_deployment)。</td>
    </tr>
  </tbody>
</table>

## Kubernetes 主节点
{: #cs_security_master}

查看内置 Kubernetes 主节点安全功能，以保护 Kubernetes 主节点，并保护集群网络通信安全。
{: shortdesc}

<dl>
  <dt>全面管理的专用 Kubernetes 主节点</dt>
    <dd>{{site.data.keyword.containershort_notm}} 中的每个 Kubernetes 集群都会由 IBM 拥有的 {{site.data.keyword.BluSoftlayer_full}} 帐户中 IBM 管理的专用 Kubernetes 主节点进行控制。Kubernetes 主节点设置有以下专用组件，这些组件不与其他 IBM 客户共享。<ul><ul><li>etcd 数据存储器：存储集群的所有 Kubernetes 资源，例如服务、部署和 pod。Kubernetes ConfigMaps 和 Secrets 是存储为键/值对的应用程序数据，可由 pod 中运行的应用程序使用。etcd 中的数据存储在加密磁盘上，该磁盘由 IBM 管理，并在发送到 pod 时通过 TLS 加密，以确保数据保护和数据完整性。<li>kube-apiserver：充当从工作程序节点到 Kubernetes 主节点的所有请求的主入口点。kube-apiserver 会验证并处理请求，并可以对 etcd 数据存储器执行读写操作。<li><kube-scheduler：决定 pod 的部署位置，同时考虑容量和性能需求、软硬件策略约束、反亲缘关系规范和工作负载需求。如果找不到与这些需求相匹配的工作程序节点，那么不会在集群中部署 pod。<li>kube-controller-manager：负责监视副本集，并创建相应的 pod 以实现所需状态。<li>OpenVPN：特定于 {{site.data.keyword.containershort_notm}} 的组件，用于为 Kubernetes 主节点到工作程序节点的所有通信提供安全的网络连接。</ul></ul></dd>
  <dt>针对工作程序节点到 Kubernetes 主节点的所有通信，受到 TLS 保护的网络连接</dt>
    <dd>为了保护与 Kubernetes 主节点的网络通信，{{site.data.keyword.containershort_notm}} 会生成 TLS 证书，用于加密每个集群的 kube-apiserver 与 etcd 数据存储器组件之间的通信。这些证书从不会在集群之间或在 Kubernetes 主节点组件之间进行共享。</dd>
  <dt>针对 Kubernetes 主节点到工作程序节点的所有通信，受到 OpenVPN 保护的网络连接</dt>
    <dd>虽然 Kubernetes 会使用 `https` 协议来保护 Kubernetes 主节点与工作程序节点之间的通信，但缺省情况下不会在工作程序节点上提供任何认证。为了保护此通信，在创建集群时，{{site.data.keyword.containershort_notm}} 会自动设置 Kubernetes 主节点与工作程序节点之间的 OpenVPN 连接。</dd>
  <dt>持续监视 Kubernetes 主节点网络</dt>
    <dd>每个 Kubernetes 主节点都由 IBM 持续监视，以控制进程级别的拒绝服务 (DOS) 攻击，并采取相应的补救措施。</dd>
  <dt>Kubernetes 主节点安全合规性</dt>
    <dd>{{site.data.keyword.containershort_notm}} 会自动扫描部署了 Kubernetes 主节点的每个节点，以确定是否有 Kubernetes 中找到的漏洞，以及为确保保护主节点而需要应用的特定于操作系统的安全修订。如果找到了漏洞，{{site.data.keyword.containershort_notm}} 会自动代表用户应用修订并解决漏洞。</dd>
</dl>  

## 工作程序节点
{: #cs_security_worker}

查看内置工作程序节点安全功能，这些功能用于保护工作程序节点环境，并确保资源、网络和存储器隔离。
{: shortdesc}

<dl>
  <dt>计算、网络和存储基础架构隔离</dt>
    <dd>创建集群后，IBM 会将虚拟机作为客户 {{site.data.keyword.BluSoftlayer_notm}} 帐户或专用 {{site.data.keyword.BluSoftlayer_notm}} 帐户中的工作程序节点进行供应。工作程序节点专用于一个集群，而不托管其他集群的工作负载。</br> 每个 {{site.data.keyword.Bluemix_notm}} 帐户都设置有 {{site.data.keyword.BluSoftlayer_notm}} VLAN，可确保工作程序节点上的高质量网络性能和隔离。</br>要在集群中持久存储数据，可以从 {{site.data.keyword.BluSoftlayer_notm}} 供应基于 NFS 的专用文件存储器，并利用该平台的内置数据安全功能。</dd>
  <dt>安全的工作程序节点设置</dt>
    <dd>每个工作程序节点都由用户无法更改的 Ubuntu 操作系统进行设置。为保护工作程序节点的操作系统免受潜在攻击，每个工作程序节点都使用 Linux iptable 规则强制实施的专家防火墙设置进行配置。</br> 在 Kubernetes 上运行的所有容器都通过集群创建期间在每个工作程序节点上配置的预定义 Calico 网络策略设置进行保护。此设置将确保工作程序节点与 pod 之间的安全网络通信。要进一步限制容器可以对工作程序节点执行的操作，用户可以选择在工作程序节点上配置 [AppArmor 策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tutorials/clusters/apparmor/)。</br> 缺省情况下，在工作程序节点上会启用 root 用户的 SSH 访问权。如果要在工作程序节点上安装附加功能，那么您可以对要在每个工作程序节点上运行的任何对象使用 [Kubernetes 守护程序集 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset)，或者对您必须执行的任何一次性操作使用 [Kubernetes 作业 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/)。</dd>
  <dt>Kubernetes 工作程序节点安全合规性</dt>
    <dd>IBM 与内部和外部的安全顾问小组合作，确定工作程序节点的潜在安全合规性问题，并持续发布合规性更新和安全补丁，以解决发现的任何漏洞。IBM 会自动将更新和安全补丁部署到工作程序节点的操作系统。为此，IBM 会维护对工作程序节点的 SSH 访问权。
</br> <b>注</b>：某些更新需要重新引导工作程序节点。但是，IBM 不会在安装更新或安全补丁期间重新引导工作程序节点。建议用户定期重新引导工作程序节点，以确保更新和安全补丁的安装可以完成。</dd>
  <dt>支持 SoftLayer 网络防火墙</dt>
    <dd>{{site.data.keyword.containershort_notm}} 与所有 [{{site.data.keyword.BluSoftlayer_notm}} 防火墙产品 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud-computing/bluemix/network-security) 相兼容。在 {{site.data.keyword.Bluemix_notm}} Public 上，可以使用定制网络策略来设置防火墙，以便为集群提供专用网络安全性，检测网络侵入并进行补救。例如，您可以选择设置 [Vyatta ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/vyatta-1) 以充当防火墙并阻止不需要的流量。设置防火墙时，[还必须为每个区域打开必需的端口和 IP 地址](#opening_ports)，以便主节点和工作程序节点可以通信。在 {{site.data.keyword.Bluemix_notm}} Dedicated 上，防火墙、DataPower、Fortigate 和 DNS 已配置为标准专用环境部署的一部分。</dd>
  <dt>使服务保持专用，或者有选择地将服务和应用程序公开到公共因特网</dt>
    <dd>可以选择使服务和应用程序保持专用，并且利用本主题中所述的内置安全性功能来确保工作程序节点与 pod 之间的安全通信。要将服务和应用程序公开到公共因特网，可以利用 Ingress 和负载均衡器支持来安全地使服务公共可用。</dd>
  <dt>将工作程序节点和应用程序安全地连接到内部部署的数据中心</dt>
    <dd>可以设置 Vyatta 网关设备或 Fortigate 设备来配置 IPSec VPN 端点，以用于将 Kubernetees 集群与内部部署的数据中心相连接。通过加密的隧道，在 Kubernees 集群中运行的所有服务都可以与内部部署应用程序（例如，用户目录、数据库或大型机）安全地进行通信。有关更多信息，请参阅[将集群连接到内部部署的数据中心 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。</dd>
  <dt>持续监视和记录集群活动</dt>
    <dd>对于标准集群，{{site.data.keyword.containershort_notm}} 将记录并监视所有与集群相关的事件（例如，添加工作程序节点、滚动更新进度或容量使用情况信息），然后将其发送给 IBM Monitoring Service 和 IBM Logging Service。</dd>
</dl>

### 在防火墙中打开必需的端口和 IP 地址
{: #opening_ports}

为工作程序节点设置防火墙或定制 {{site.data.keyword.BluSoftlayer_notm}} 帐户中的防火墙设置时，必须打开特定端口和 IP 地址，以便工作程序节点与 Kubernees 主节点可以进行通信。

1.  记下用于集群中所有工作程序节点的公共 IP 地址。

    ```
    bx cs workers <cluster_name_or_id>
    ```
    {: pre}

2.  在防火墙中，允许与工作程序节点之间建立以下连接。

  ```
  TCP port 443 FROM <each_worker_node_publicIP> TO registry.<region>.bluemix.net, apt.dockerproject.org
  ```
  {: codeblock}

    <ul><li>对于来自工作程序节点的出站连接，允许从源工作程序节点到目标 TCP/UDP 端口范围 20000-32767（用于 `<each_worker_node_publicIP>`）以及以下 IP 地址和网络组的出局网络流量：</br>
    

    <table summary="表中的第一行跨两列。其余行应从左到右阅读，其中第一列是服务器位置，第二列是要匹配的 IP 地址。">
  <thead>
      <th colspan=2><img src="images/idea.png"/> 出站 IP 地址</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>


## 网络策略
{: #cs_security_network_policies}

每个 Kubernetes 集群均设置有名为 Calico 的网络插件。缺省网络策略设置为保护每个工作程序节点的公共网络接口的安全。当您有独特的安全需求时，可以使用 Calico 和本机 Kubernetes 功能来为集群配置更多网络策略。这些网络策略会指定是要允许还是阻止与集群中的 pod 之间进出的网络流量。
{: shortdesc}

可以从 Calico 和本机 Kubernetes 功能中进行选择来为集群创建网络策略。一开始可使用 Kubernetes 网络策略，但为了获得更稳健的功能，请使用 Calico 网络策略。

<ul><li>[Kubernetes 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)：提供了一些基本选项，例如指定哪些 pod 可以相互通信。可以针对某个协议和端口允许或阻止 pod 的入局网络流量，具体依据正尝试连接到这些 pod 的 pod 的标签和 Kubernetes 名称空间。</br>可以使用 `kubectl` 命令或 Kubernetes API 来应用这些策略。这些策略应用后，即会转换成 Calico 网络策略，Calico 会强制实施这些策略。<li>[Calico 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy)：这些策略是 Kubernetes 网络策略的超集，通过以下功能增强了本机 Kubernetes 能力。<ul><ul><li>允许或阻止特定网络接口上的网络流量，而不仅仅是 Kubernetes pod 流量。<li>允许或阻止入局 (流入）和出局 (外流) 网络流量。<li>允许或阻止基于源或目标 IP 地址或 CIDR 的流量。</ul></ul></br>
这些策略通过使用 `calicoctl` 命令来应用。Calico 会通过在 Kubernetes 工作程序节点上设置 Linux iptable 规则来强制实施这些策略，包括转换为 Calico 策略的任何 Kubernetes 网络策略。iptable 规则充当工作程序节点的防火墙，可定义网络流量为能够转发到目标资源而必须满足的特征。</ul>


### 缺省策略配置
{: #concept_nq1_2rn_4z}

创建集群时，会自动为每个工作程序节点的公共网络接口设置缺省网络策略，以限制来自公共因特网的工作程序节点的入局流量。这些策略不会影响 pod 到 pod 的流量，并设置为允许访问 Kubernetes NodePort、LoadBalancer 和 Ingress 服务。

不会直接将缺省策略应用于 pod；缺省策略使用 Calico [主机端点 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal) 应用于工作程序节点的公共网络接口。在 Calico 中创建主机端点后，除非策略允许与工作程序节点网络接口之间进出的所有流量，否则将阻止该流量。

请注意，不存在允许 SSH 的策略，所以会阻止通过公共网络接口进行的 SSH 访问，正如没有策略可将其打开的其他所有端口那样。SSH 访问和其他访问在每个工作程序节点的专用网络接口上可用。

**重要信息**：不要除去应用于主机端点的策略，除非您充分了解策略并确定无需该策略允许的流量。



  <table summary="表中的第一行跨两列。其余行应从左到右阅读，其中第一列是服务器位置，第二列是要匹配的 IP 地址。">
  <thead>
  <th colspan=2><img src="images/idea.png"/> 每个集群的缺省策略</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>允许所有出站流量。</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>允许入局 icmp 包 (ping)。</td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>允许所有入局流量流入端口 10250，这是 kubelet 使用的端口。此策略允许 `kubectl logs` 和 `kubectl exec` 在 Kubernetes 集群中正常运行。</td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>允许入局 NodePort、LoadBalancer 和 Ingress 服务流量流入这些服务公开的 pod。请注意，这些服务在公共接口上公开的端口不必加以指定，因为 Kubernetes 会使用目标网络地址转换 (DNAT) 将这些服务请求转发到正确的 pod。这一转发过程在 iptable 中应用主机端点策略之前执行。</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>允许用于管理工作程序节点的特定 {{site.data.keyword.BluSoftlayer_notm}} 系统的入局连接。</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>允许使用 vrrp 包，这些包用于监视虚拟 IP 地址并在工作程序节点之间移动这些 IP 地址。</td>
   </tr>
  </tbody>
</table>


### 添加网络策略
{: #adding_network_policies}

在大多数情况下，缺省策略无需更改。只有高级场景可能需要更改。如果发现必须进行更改，请安装 Calico CLI 并创建自己的网络策略。

开始之前，请完成以下步骤。

1.  [安装 {{site.data.keyword.containershort_notm}} 和 Kubernetes CLI](cs_cli_install.html#cs_cli_install)。
2.  [创建 Lite 或标准集群](cs_cluster.html#cs_cluster_ui)。
3.  [设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。在 `bx cs cluster-config` 命令中包含 `--admin` 选项，以用于下载证书和许可权文件。此下载还包含管理员 RBAC 角色的密钥，以供运行 Calico 命令时使用。

  ```
  bx cs cluster-config <cluster_name> 
  ```
  {: pre}


要添加网络策略，请执行以下操作：
1.  安装 Calico CLI。
    1.  [下载 Calico CLI ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/projectcalico/calicoctl/releases/)。

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
              mv /<path_to_file>/calico-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  将二进制文件转换为可执行文件。

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  通过检查 Calico CLI 客户机版本，验证 `calico` 命令是否正常运行。

        ```
        calicoctl version
        ```
        {: pre}

2.  配置 Calico CLI。

    1.  对于 Linux 和 OS X，创建“/etc/calico”目录。对于 Windows，可以使用任何目录。

      ```
      mkdir -p /etc/calico/
      ```
      {: pre}

    2.  创建“calicoctl.cfg”文件。
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
      {: pre}

        1.  检索 `<ETCD_URL>`。

          -   Linux 和 OS X：

              ```
              kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
              ```
              {: pre}

          -   输出示例：

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows：<ol>
            <li>获取 kube-system 名称空间中 pod 的列表，并找到 Calico 控制器 pod。</br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>示例：</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
            <li>查看 Calico 控制器 pod 的详细信息。</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
            <li>找到 ETCD 端点值。示例：<code>https://169.1.1.1:30001</code></ol>

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
              ls `dirname $KUBECONFIG` | grep ca-.*pem
              ```
              {: pre}

            -   Windows：<ol><li>打开在最后一步中检索到的目录。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&#60;cluster_name&#62;-admin\</code></pre>
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

    1.  通过创建配置脚本 (.yaml) 来定义 [Calico 网络策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy)。这些配置文件包含选择器，用于描述这些策略应用于哪些 pod、名称空间或主机。请参阅这些[样本 Calico 策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) 以帮助您创建自己的策略。

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


## 映像
{: #cs_security_deployment}

使用内置安全性功能来管理映像的安全性与完整性。
{: shortdesc}

### {{site.data.keyword.registryshort_notm}} 中的安全 Docker 专用映像存储库：

 可以在 IBM 托管和管理的具备高可用性和高可扩展性的多租户专用映像注册表中设置自己的 Docker 映像存储库，以构建和安全地存储 Docker 映像，并在集群用户之间共享这些映像。

### 映像安全合规性：

使用 {{site.data.keyword.registryshort_notm}} 时，可以利用漏洞顾问程序提供的内置安全性扫描。对于推送到名称空间的每个映像，都会自动根据包含已知 CentOS、Debian、Red Hat 和 Ubuntu 问题的数据库进行扫描以确定是否有漏洞。如果发现了漏洞，漏洞顾问程序会提供指示信息指导如何解决这些漏洞，以确保映像完整性和安全性。

要查看映像的漏洞评估，请执行以下操作：

1.  在**目录**中，选择**容器**。
2.  选择要查看其漏洞评估的映像。
3.  在**漏洞评估**部分中，单击**查看报告**。
