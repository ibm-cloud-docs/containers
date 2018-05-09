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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# 集群故障诊断
{: #cs_troubleshoot}

在使用 {{site.data.keyword.containerlong}} 时，请考虑这些用于故障诊断和获取帮助的方法。您还可以检查 [{{site.data.keyword.Bluemix_notm}} 系统的状态 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/bluemix/support/#status)。
{: shortdesc}

您可以执行一些常规步骤来确保集群是最新的：
- 定期[重新启动工作程序节点](cs_cli_reference.html#cs_worker_reboot)，以确保已安装 IBM 自动部署到操作系统的更新和安全补丁
- 针对 {{site.data.keyword.containershort_notm}}，将集群更新到 [Kubernetes 的最新缺省版本](cs_versions.html)

<br />




## 调试集群
{: #debug_clusters}

复查可用于调试集群并查找失败根本原因的选项。

1.  列出集群并找到集群的 `State`。

  ```
  bx cs clusters
  ```
  {: pre}

2.  复查集群的 `State`。如果集群处于 **Critical**、**Delete failed** 或 **Warning** 状态，或者长时间卡在 **Pending** 状态，请开始[调试工作程序节点](#debug_worker_nodes)。

    <table summary="每个表行都应从左到右阅读，其中第一列是集群状态，第二列是描述。">
  <thead>
   <th>集群状态</th>
   <th>描述</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>在部署 Kubernetes 主节点之前，用户请求删除集群。在集群删除完成后，将从仪表板中除去集群。如果集群长时间卡在此状态，请开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/get-support/howtogetsupport.html#using-avatar)。</td>
   </tr>
 <tr>
     <td>Critical</td>
     <td>无法访问 Kubernetes 主节点，或者集群中的所有工作程序节点都已停止运行。</td>
    </tr>
   <tr>
     <td>Delete failed</td>
     <td>Kubernetes 主节点或至少一个工作程序节点无法删除。</td>
   </tr>
   <tr>
     <td>Deleted</td>
     <td>集群已删除，但尚未从仪表板中除去。如果集群长时间卡在此状态，请开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/get-support/howtogetsupport.html#using-avatar)。</td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>正在删除集群，并且正在拆除集群基础架构。无法访问集群。</td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>无法完成 Kubernetes 主节点的部署。您无法解决此状态。请通过开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/get-support/howtogetsupport.html#using-avatar)来联系 IBM Cloud 支持。</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Kubernetes 主节点尚未完全部署。无法访问集群。请等待集群完全部署后，再复查集群的运行状况。</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>集群中的所有工作程序节点都已启动并正在运行。您可以访问集群，并将应用程序部署到集群。此状态视为正常运行，不需要您执行操作。</td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>Kubernetes 主节点已部署。正在供应工作程序节点，这些节点在集群中尚不可用。您可以访问集群，但无法将应用程序部署到集群。</td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>发送了用于创建集群并为 Kubernetes 主节点和工作程序节点订购基础架构的请求。集群部署启动后，集群状态将更改为 <code>Deploying</code>。如果集群长时间卡在 <code>Requested</code> 状态，请开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/get-support/howtogetsupport.html#using-avatar)。</td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>在 Kubernetes 主节点中运行的 Kubernetes API 服务器正在更新到新的 Kubernetes API 版本。在更新期间，无法访问或更改集群。用户已部署的工作程序节点、应用程序和资源不会被修改，并且将继续运行。等待更新完成后，再复查集群的运行状况。</td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>集群中至少有一个工作程序节点不可用，但其他工作程序节点可用，并且可以接管工作负载。</td>
    </tr>
   </tbody>
 </table>

<br />


## 调试工作程序节点
{: #debug_worker_nodes}

复查可用于调试工作程序节点并查找故障根本原因的选项。


1.  如果集群处于 **Critical**、**Delete failed** 或 **Warning** 状态，或者长时间卡在 **Pending** 状态，请复查工作程序节点的状态。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

2.  复查 CLI 输出中每个工作程序节点的 `State` 和 `Status` 字段。

  <table summary="每个表行都应从左到右阅读，其中第一列是集群状态，第二列是描述。">
  <thead>
    <th>工作程序节点状态</th>
    <th>描述</th>
    </thead>
    <tbody>
  <tr>
      <td>Critical</td>
      <td>工作程序节点可能由于许多原因而进入 Critical 状态。最常见的原因如下：<ul><li>对工作程序节点启动了重新引导，但并未对工作程序节点执行封锁和放弃操作。重新引导工作程序节点可能会导致 <code>docker</code>、<code>kubelet</code>、<code>kube-proxy</code> 和 <code>calico</code> 中发生数据损坏。</li><li>部署到工作程序节点的 pod 不会对[内存 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) 和 [CPU ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/) 使用资源限制。如果没有资源限制，那么 pod 可以使用所有可用资源，这样就没有资源可供其他 pod 在此工作程序节点上运行。这一过度落实工作负载的情况会导致工作程序节点失败。</li><li>在运行数百个或数千个容器一段时间后，<code>Docker</code>、<code>kubelet</code> 或 <code>calico</code> 进入不可恢复的状态。</li><li>为工作程序节点设置了 Vyatta，但 Vyatta 已停止运行并切断了工作程序节点与 Kubernetes 主节点之间的通信。</li><li> {{site.data.keyword.containershort_notm}} 或 IBM Cloud Infrastructure (SoftLayer) 中导致工作程序节点与 Kubernetes 主节点之间通信失败的当前网络问题。</li><li>工作程序节点的容量不足。检查工作程序节点的 <strong>Status</strong>，以查看它是否显示 <strong>Out of disk</strong> 或 <strong>Out of memory</strong>。如果工作程序节点的容量不足，请考虑减少工作程序节点上的工作负载，或者向集群添加工作程序节点来帮助对工作负载进行负载均衡。</li></ul> 在许多情况下，[重新装入](cs_cli_reference.html#cs_worker_reload)工作程序节点可以解决此问题。在重新装入工作程序节点之前，请务必对工作程序节点执行封锁和放弃操作，以确保正常终止现有 pod 并将其重新安排到剩余的工作程序节点。</br></br> 如果重新装入工作程序节点无法解决此问题，请转至下一步以继续对工作程序节点进行故障诊断。</br></br><strong>提示：</strong>可以[为工作程序节点配置运行状况检查并启用自动恢复](cs_health.html#autorecovery)。如果自动恢复根据配置的检查，检测到运行状况欠佳的工作程序节点，那么自动恢复会触发更正操作，例如在工作程序节点上重装操作系统。有关自动恢复的工作方式的更多信息，请参阅[自动恢复博客 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)。</td>
     </tr>
      <tr>
        <td>Deploying</td>
        <td>更新工作程序节点的 Kubernetes 版本时，将重新部署工作程序节点以安装更新。如果工作程序节点长时间卡在此状态，请继续执行下一步，以查看在部署期间是否发生了问题。</td>
     </tr>
        <tr>
        <td>Normal</td>
        <td>工作程序节点已完全供应并准备就绪，可以在集群中使用。此状态视为正常运行，不需要用户执行操作。</td>
     </tr>
   <tr>
        <td>Provisioning</td>
        <td>正在供应工作程序节点，该节点在集群中尚不可用。您可以在 CLI 输出的 <strong>Status</strong> 列中监视供应过程。如果工作程序节点长时间卡在此状态，并且在 <strong>Status</strong> 列中看不到任何进度，请继续执行下一步以查看供应期间是否发生了问题。</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>无法供应工作程序节点。继续执行下一步以找到失败的详细信息。</td>
      </tr>
   <tr>
        <td>Reloading</td>
        <td>正在重新装入工作程序节点，该节点在集群中不可用。您可以在 CLI 输出的 <strong>Status</strong> 列中监视重新装入过程。如果工作程序节点长时间卡在此状态，并且在 <strong>Status</strong> 列中看不到任何进度，请继续执行下一步以查看重新装入期间是否发生了问题。</td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>无法重新装入工作程序节点。继续执行下一步以找到失败的详细信息。</td>
      </tr>
      <tr>
        <td>Reload_pending </td>
        <td>发送了用于重新装入或更新工作程序节点的 Kubernetes 版本的请求。正在重新装入工作程序节点时，状态将更改为 <code>Reloading</code>。</td>
      </tr>
      <tr>
       <td>Unknown</td>
       <td>由于以下某种原因，Kubernetes 主节点不可访问：<ul><li>您请求了更新 Kubernetes 主节点。在更新期间无法检索到工作程序节点的状态。</li><li>您可能有其他防火墙在保护工作程序节点，或者最近更改了防火墙设置。{{site.data.keyword.containershort_notm}} 需要打开特定 IP 地址和端口，以允许工作程序节点与 Kubernetes 主节点之间进行通信。有关更多信息，请参阅[防火墙阻止工作程序节点进行连接](#cs_firewall)。</li><li>Kubernetes 主节点已停止运行。请通过开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/get-support/howtogetsupport.html#getting-customer-support)来联系 {{site.data.keyword.Bluemix_notm}} 支持。</li></ul></td>
  </tr>
     <tr>
        <td>Warning</td>
        <td>工作程序节点将达到内存或磁盘空间的限制。您可以减少工作程序节点上的工作负载，或者向集群添加一个工作程序节点以帮助均衡工作负载。</td>
  </tr>
    </tbody>
  </table>

5.  列出工作程序节点的详细信息。如果详细信息包含错误消息，请查看[工作程序节点的常见错误消息](#common_worker_nodes_issues)列表以了解如何解决问题。

   ```
   bx cs worker-get <worker_id>
   ```
   {: pre}

  ```
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
  ```
  {: pre}

<br />


## 工作程序节点的常见问题
{: #common_worker_nodes_issues}

查看常见错误消息并了解如何解决这些错误。

  <table>
    <thead>
    <th>错误消息</th>
    <th>描述和解决方法
    </thead>
    <tbody>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure 异常：当前禁止您的帐户订购“计算实例”。</td>
        <td>您的 IBM Cloud infrastructure (SoftLayer) 帐户可能受到限制，无法订购计算资源。请通过开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/get-support/howtogetsupport.html#getting-customer-support)来联系 {{site.data.keyword.Bluemix_notm}} 支持。</td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure 异常：无法下单。路由器“router_name”后的资源不足，无法实现以下访客的请求：“worker_id”。</td>
        <td>所选的 VLAN 与数据中心内没有足够空间来供应工作程序节点的 pod 相关联。有以下选项可供选择：<ul><li>使用其他数据中心来供应工作程序节点。运行 <code>bx cs locations</code> 以列出可用的数据中心。<li>如果您有与数据中心内另一个 pod 相关联的现有公用和专用 VLAN 对，请改为使用此 VLAN 对。<li>请通过开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/get-support/howtogetsupport.html#getting-customer-support)来联系 {{site.data.keyword.Bluemix_notm}} 支持。</ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure 异常：无法获取标识为 &lt;vlan id&gt; 的网络 VLAN。</td>
        <td>由于以下某种原因而找不到所选的 VLAN 标识，因此无法供应工作程序节点：<ul><li>您可能指定的是 VLAN 编号，而不是 VLAN 标识。VLAN 编号的长度为 3 位或 4 位，而 VLAN 标识的长度为 7 位。运行 <code>bx cs vlans &lt;location&gt;</code> 以检索 VLAN 标识。<li>该 VLAN 标识可能未与所使用的 IBM Cloud infrastructure (SoftLayer) 帐户相关联。运行 <code>bx cs vlans &lt;location&gt;</code> 以列出您帐户的可用 VLAN 标识。要更改 IBM Cloud infrastructure (SoftLayer) 帐户，请参阅 [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)。</ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation：为此订单提供的位置无效。(HTTP 500)</td>
        <td>IBM Cloud infrastructure (SoftLayer) 未设置为订购所选数据中心内的计算资源。请联系 [{{site.data.keyword.Bluemix_notm}} 支持](/docs/get-support/howtogetsupport.html#getting-customer-support)，以验证您的帐户是否正确设置。</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure 异常：用户没有必需的 {{site.data.keyword.Bluemix_notm}} Infrastructure 许可权来添加服务器
</br></br>
        {{site.data.keyword.Bluemix_notm}} Infrastructure 异常：必须具有许可权才能订购“项”。</td>
        <td>您可能没有必需的许可权来从 IBM Cloud infrastructure (SoftLayer) 产品服务组合供应工作程序节点。请参阅[配置对 IBM Cloud infrastructure (SoftLayer) 产品服务组合的访问权以创建标准 Kubernete 集群](cs_infrastructure.html#unify_accounts)。</td>
      </tr>
      <tr>
       <td>工作程序无法与 {{site.data.keyword.containershort_notm}} 服务器通信。请验证防火墙设置是否允许来自此工作程序的流量。
       <td><ul><li>如果您有防火墙，请[配置防火墙设置以允许出局流量流至相应的端口和 IP 地址](cs_firewall.html#firewall_outbound)。</li><li>通过运行 `bx cs workers <mycluster>` 来检查集群是否没有公共 IP。如果未列出任何公共 IP，说明集群仅具有专用 VLAN。<ul><li>如果希望集群仅具有专用 VLAN，请确保已设置 [VLAN 连接](cs_clusters.html#worker_vlan_connection)和[防火墙](cs_firewall.html#firewall_outbound)。</li><li>如果希望集群具有公共 IP，请[添加新的工作程序节点](cs_cli_reference.html#cs_worker_add)（具有公用和专用 VLAN）。</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>无法创建 IMS 门户网站令牌，因为没有 IMS 帐户链接到所选的 BSS 帐户</br></br>找不到提供的用户或该用户不处于活动状态</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus：用户帐户当前处于 cancel_pending 状态。</td>
  <td>用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的 API 密钥的所有者没有执行此操作的必需许可权，或者可能处于暂挂删除状态。</br></br><strong>以用户身份</strong>，执行以下步骤：<ol><li>如果您有权访问多个帐户，请确保您已登录到要使用 {{site.data.keyword.containerlong_notm}} 的帐户。</li><li>运行 <code>bx cs api-key-info</code> 以查看用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的当前 API 密钥所有者。</li><li>运行 <code>bx account list</code> 以查看当前使用的 {{site.data.keyword.Bluemix_notm}} 帐户的所有者。</li><li>请与 {{site.data.keyword.Bluemix_notm}} 帐户的所有者联系，并报告您先前检索到的 API 密钥所有者在 IBM Cloud Infrastructure (SoftLayer) 中的许可权不足，或者可能暂挂待删除。</li></ol></br><strong>以帐户所有者身份</strong>，执行以下步骤：<ol><li>复查 [IBM Cloud Infrastructure (SoftLayer) 中的必需许可权](cs_users.html#managing)，即执行先前失败的操作所需的许可权。</li><li>使用 [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) 命令来修正 API 密钥所有者的许可权或创建新的 API 密钥。</li><li>如果您或其他帐户管理员在您的帐户上手动设置了 IBM Cloud Infrastructure (SoftLayer) 凭证，请运行 [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) 以从您的帐户中除去凭证。</li></ol></td>
  </tr>
    </tbody>
  </table>



<br />




## 调试应用程序部署
{: #debug_apps}

复查您可用于调试应用程序部署并查找失败根本原因的选项。

1. 通过运行 `describe` 命令，在服务或部署资源中查找异常情况。

 示例：
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [检查容器是否卡在 ContainerCreating 状态](#stuck_creating_state)。

3. 检查集群是否处于 `Critical` 状态。如果集群处于 `Critical` 状态，请检查防火墙规则，并验证主节点是否能与工作程序节点进行通信。

4. 验证该服务是否正在侦听正确的端口。
   1. 获取 pod 的名称。
<pre class="pre"><code>        kubectl get pods
        </code></pre>
   2. 登录到容器。
<pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. 从容器中 Curl 应用程序。如果该端口不可访问，那么该服务可能未在侦听正确的端口，或者应用程序可能存在问题。使用正确的端口更新服务的配置文件，并重新部署或调查应用程序的潜在问题。<pre class="pre"><code>curl localhost: &lt;port&gt;</code></pre>

5. 验证服务是否已正确链接到 Pod。
   1. 获取 pod 的名称。
<pre class="pre"><code>        kubectl get pods
        </code></pre>
   2. 登录到容器。
<pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. Curl 服务的集群 IP 地址和端口。如果 IP 地址和端口不可访问，请查看服务的端点。如果没有端点，那么服务的选择器与 pod 不匹配。如果存在端点，请查看服务上的目标端口字段，并确保目标端口与用于这些 pod 的目标端口相同。
<pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. 对于 Ingress 服务，请验证可从集群内访问该服务。
   1. 获取 pod 的名称。
<pre class="pre"><code>        kubectl get pods
        </code></pre>
   2. 登录到容器。
<pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Curl 为 Ingress 服务指定的 URL。如果该 URL 不可访问，请检查集群和外部端点之间是否存在防火墙问题。
<pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />


## 无法连接到 Infrastructure 帐户
{: #cs_credentials}

{: tsSymptoms}
创建新的 Kubernetes 集群时，收到以下消息。

```
我们无法连接到您的 IBM Cloud infrastructure (SoftLayer) 帐户。创建标准集群要求您有链接到 IBM Cloud infrastructure (SoftLayer) 帐户条款的现买现付帐户，或者您已使用 {{site.data.keyword.Bluemix_notm}} Container Service CLI 设置 {{site.data.keyword.Bluemix_notm}} Infrastructure API 密钥。
```
{: screen}

{: tsCauses}
具有未链接 {{site.data.keyword.Bluemix_notm}} 帐户的用户必须创建新的现买现付帐户，或者使用 {{site.data.keyword.Bluemix_notm}} CLI 手动添加 IBM Cloud infrastructure (SoftLayer) API 密钥。

{: tsResolve}
要向您的 {{site.data.keyword.Bluemix_notm}} 帐户添加凭证，请执行以下操作：

1.  请联系 IBM Cloud infrastructure (SoftLayer) 管理员，以获取您的 IBM Cloud infrastructure (SoftLayer) 用户名和 API 密钥。

    **注**：您使用的 IBM Cloud infrastructure (SoftLayer) 帐户必须设置有“超级用户”许可权才可成功创建标准集群。

2.  添加凭证。

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  创建标准集群。

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## 防火墙阻止 CLI 命令运行
{: #ts_firewall_clis}

{: tsSymptoms}
从 CLI 运行 `bx`、`kubectl` 或 `calicoctl` 命令时，它们会失败。

{: tsCauses}
您可能具有企业网络策略，这些策略灰阻止通过代理或防火墙从本地系统访问公共端点。

{: tsResolve}
[允许 TCP 访问以使 CLI 命令能够运作](cs_firewall.html#firewall)。此任务需要[管理员访问策略](cs_users.html#access_policies)。验证您当前的[访问策略](cs_users.html#infra_access)。


## 防火墙阻止集群连接到资源
{: #cs_firewall}

{: tsSymptoms}
当工作程序节点无法连接时，您可能会看到各种不同的症状。当 kubectl 代理失败时，或者您尝试访问集群中的某个服务并且连接失败时，您可能会看到以下消息之一。

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

如果运行 kubectl exec、attach 或 log，那么可能会看到以下消息。

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

如果 kubectl 代理成功，但仪表板不可用，那么您可能会看到以下消息。

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
您可能已在 IBM Cloud infrastructure (SoftLayer) 帐户中额外设置了防火墙或定制了现有防火墙设置。{{site.data.keyword.containershort_notm}} 需要打开特定 IP 地址和端口，以允许工作程序节点与 Kubernetes 主节点之间进行通信。另一个原因可能是工作程序节点陷入重新装入循环。

{: tsResolve}
[允许集群访问基础架构资源和其他服务](cs_firewall.html#firewall_outbound)。此任务需要[管理员访问策略](cs_users.html#access_policies)。验证您当前的[访问策略](cs_users.html#infra_access)。

<br />



## 使用 SSH 访问工作程序节点失败
{: #cs_ssh_worker}

{: tsSymptoms}
使用 SSH 连接无法访问工作程序节点。

{: tsCauses}
工作程序节点上禁用了通过密码进行的 SSH。

{: tsResolve}
将 [DaemonSets ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) 用于必须在每个节点上运行的任何操作，或者将作业用于必须执行的任何一次性操作。

<br />



## 将服务绑定到集群导致同名错误
{: #cs_duplicate_services}

{: tsSymptoms}
运行 `bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>` 时，看到以下消息。

```
Multiple services with the same name were found.
Run 'bx service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
多个服务实例可能在不同区域中具有相同名称。

{: tsResolve}
在 `bx cs cluster-service-bind` 命令中，请使用服务 GUID，而不要使用服务实例名称。

1. [登录到包含要绑定的服务实例的区域](cs_regions.html#bluemix_regions)。

2. 获取服务实例的 GUID。
  ```
  bx service show <service_instance_name> --guid
  ```
  {: pre}

  输出：
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. 再次将服务绑定到集群。
  ```
  bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />



## 更新或重新装入工作程序节点后，出现重复的节点和 pod
{: #cs_duplicate_nodes}

{: tsSymptoms}
运行 `kubectl get nodes` 时，您看到状态为 **NotReady** 的重复工作程序节点。状态为 **NotReady** 的工作程序节点具有公共 IP 地址，而状态为 **Ready** 的工作程序节点具有专用 IP 地址。

{: tsCauses}
较旧的集群具有按集群的公共 IP 地址列出的工作程序节点。现在，工作程序节点按集群的专用 IP 地址列出。当您重新装入或更新节点时，IP 地址将更改，但对公共 IP 地址的引用将保持不变。

{: tsResolve}
由于这些重复，因此不存在服务中断，但您应该从 API 服务器中除去旧的工作程序节点引用。

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />




## 工作程序节点的文件系统更改为只读
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
您可能会看到下列其中一个症状：
- 当您运行 `kubectl get pods -o wide` 时，您会看到在同一工作程序节点上运行的多个 pod 陷入 `ContainerCreating` 状态。
- 运行 `kubectl describe` 命令时，在 events 部分中看到以下错误：`MountVolume.SetUp failed for volume ... read-only file system`。

{: tsCauses}
工作程序节点上的文件系统是只读的。

{: tsResolve}
1. 备份可能存储在工作程序节点或容器中的任何数据。
2. 要对现有工作程序节点进行短时间修订，请重新装入工作程序节点。

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

对于长时间修订，请[通过添加其他工作程序节点来更新机器类型](cs_cluster_update.html#machine_type)。

<br />




## 访问新工作程序节点上的 pod 失败，并返回超时错误
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
您删除了集群中的工作程序节点，然后添加了工作程序节点。部署 pod 或 Kubernetes 服务时，资源无法访问新创建的工作程序节点，并且连接超时。

{: tsCauses}
如果从集群中删除工作程序节点，然后添加工作程序节点，那么可能会将已删除工作程序节点的专用 IP 地址分配给新工作程序节点。Calico 使用此专用 IP 地址作为标记，并继续尝试访问已删除的节点。

{: tsResolve}
手动更新专用 IP 地址的引用以指向正确的节点。

1.  确认您是否有两个工作程序节点使用相同的**专用 IP** 地址。记下已删除的工作程序的**专用 IP** 和**标识**。

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12    203.0.113.144    b2c.4x16       normal    Ready    dal10      1.8.8
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16    203.0.113.144    b2c.4x16       deleted    -       dal10      1.8.8
  ```
  {: screen}

2.  安装 [Calico CLI](cs_network_policy.html#adding_network_policies)。
3.  列出 Calico 中的可用工作程序节点。将 <path_to_file> 替换为 Calico 配置文件的本地路径。

  ```
  calicoctl get nodes --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  删除 Calico 中的重复工作程序节点。将 NODE_ID 替换为工作程序节点标识。

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  重新引导未删除的工作程序节点。

  ```
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


已删除的节点不会再在 Calico 中列出。

<br />


## 集群保持暂挂状态
{: #cs_cluster_pending}

{: tsSymptoms}
部署集群时，集群保持暂挂状态，而不启动。

{: tsCauses}
如果刚刚创建了集群，那么工作程序节点可能仍在配置中。如果已经等待了一段时间，那么可能是 VLAN 无效。

{: tsResolve}

可以尝试下列其中一个解决方案：
  - 通过运行 `bx cs cluster` 来检查集群的阶段状态。然后，通过运行 `bx cs workers <cluster_name>` 检查以确保工作程序节点已部署。
  - 检查以确定 VLAN 是否有效。要使 VLAN 有效，必须将 VLAN 与可使用本地磁盘存储来托管工作程序的基础架构相关联。可以通过运行 `bx cs vlans LOCATION` 来[列出 VLAN](/docs/containers/cs_cli_reference.html#cs_vlans)，如果 VLAN 未显示在列表中，说明该 VLAN 无效。请选择其他 VLAN。

<br />


## Pod 保持暂挂状态
{: #cs_pods_pending}

{: tsSymptoms}
运行 `kubectl get pods` 时，可能看到 pod 保持**暂挂**状态。

{: tsCauses}
如果刚刚创建了 Kubernetes 集群，那么工作程序节点可能仍在配置中。如果这是现有集群，那么可能是集群中没有足够的容量来部署 pod。

{: tsResolve}
此任务需要[管理员访问策略](cs_users.html#access_policies)。验证您当前的[访问策略](cs_users.html#infra_access)。

如果刚创建了 Kubernetes 集群，请运行以下命令并等待工作程序节点初始化。

```
kubectl get nodes
```
{: pre}

如果这是现有集群，请检查集群容量。

1.  使用缺省端口号设置代理。

  ```
  kubectl proxy
  ```
   {: pre}

2.  打开 Kubernetes 仪表板。

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  检查集群中是否有足够的容量来部署 pod。

4.  如果集群中没有足够的容量，请向集群另外添加一个工作程序节点。

  ```
  bx cs worker-add <cluster name or id> 1
  ```
  {: pre}

5.  如果在完全部署工作程序节点后，pod 仍然保持 **pending** 状态，请查看 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) 以进一步对 pod 的暂挂状态进行故障诊断。

<br />




## 容器不启动
{: #containers_do_not_start}

{: tsSymptoms}
pod 会成功部署到集群，但容器不启动。

{: tsCauses}
当达到注册表限额时，容器可能不会启动。

{: tsResolve}
[在 {{site.data.keyword.registryshort_notm}} 中释放存储器。](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />




## 日志不显示
{: #cs_no_logs}

{: tsSymptoms}
访问 Kibana 仪表板时，日志不显示。

{: tsResolve}
查看以下导致日志不显示的原因以及对应的故障诊断步骤：

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>问题原因</th>
 <th>解决方法</th>
 </thead>
 <tbody>
 <tr>
 <td>未设置任何日志记录配置。</td>
 <td>要发送日志，必须先创建日志记录配置，以便将日志转发到 {{site.data.keyword.loganalysislong_notm}}。要创建日志记录配置，请参阅<a href="cs_health.html#logging">配置集群日志记录</a>。</td>
 </tr>
 <tr>
 <td>集群不处于 <code>Normal</code> 状态。</td>
 <td>要检查集群的状态，请参阅<a href="cs_troubleshoot.html#debug_clusters">调试集群</a>。</td>
 </tr>
 <tr>
 <td>已达到日志存储配额。</td>
 <td>要提高日志存储限制，请参阅 <a href="/docs/services/CloudLogAnalysis/troubleshooting/error_msgs.html">{{site.data.keyword.loganalysislong_notm}} 文档</a>。</td>
 </tr>
 <tr>
 <td>如果您在创建集群时指定了空间，帐户所有者没有对该空间的“管理员”、“开发者”或“审计员”许可权。</td>
 <td>要更改帐户所有者的访问许可权，请执行以下操作：<ol><li>要找出集群的帐户所有者，请运行 <code>bx cs api-key-info &lt;cluster_name_or_ID&gt;</code>。</li><li>要授予帐户所有者对空间的 {{site.data.keyword.containershort_notm}}“管理员”、“开发者”或“审计员”访问许可权，请参阅<a href="cs_users.html#managing">管理集群访问权</a>。</li><li>要在更改许可权后刷新日志记录令牌，请运行 <code>bx cs logging-config-refresh &lt;cluster_name_or_ID&gt;</code>。</li></ol></td>
 </tr>
 </tbody></table>

要测试在故障诊断期间进行的更改，可以在集群中的一个工作程序节点上部署 Noisy（用于生成多个日志事件的样本 pod）。

  1. [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)，将目标设置为要在其中开始生成日志的集群。

  2. 创建 `deploy-noisy.yaml` 配置文件。

      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: noisy
      spec:
        containers:
        - name: noisy
          image: ubuntu:16.04
          command: ["/bin/sh"]
          args: ["-c", "while true; do sleep 10; echo 'Hello world!'; done"]
          imagePullPolicy: "Always"
        ```
        {: codeblock}

  3. 在集群上下文中运行该配置文件。

        ```
        kubectl apply -f <filepath_to_noisy>
        ```
        {:pre}

  4. 几分钟后，可以在 Kibana 仪表板中查看日志。要访问 Kibana 仪表板，请转至以下某个 URL，然后选择在其中创建了集群的 {{site.data.keyword.Bluemix_notm}} 帐户。如果在创建集群时指定了空间，请改为转至该空间。
      - 美国南部和美国东部：https://logging.ng.bluemix.net
      - 英国南部：https://logging.eu-gb.bluemix.net
      - 欧洲中部：https://logging.eu-fra.bluemix.net
      - 亚太南部：https://logging.au-syd.bluemix.net

<br />




## Kubernetes 仪表板不显示利用率图形
{: #cs_dashboard_graphs}

{: tsSymptoms}
访问 Kibana 仪表板时，利用率图形不显示。

{: tsCauses}
有时，在集群更新或工作程序节点重新引导后，`kube-dashboard` pod 不会更新。

{: tsResolve}
删除 `kube-dashboard` pod 以强制重新启动。该 pod 会通过 RBAC 策略重新创建，以用于访问 heapster 来获取利用率信息。

  ```
    kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
    ```
  {: pre}

<br />


## 添加持久性存储器的非 root 用户访问权失败
{: #cs_storage_nonroot}

{: tsSymptoms}
在[添加持久性存储器的非 root 用户访问权](cs_storage.html#nonroot)或使用指定的非 root 用户标识部署 Helm 图表后，用户无法写入安装的存储器。

{: tsCauses}
部署或 Helm 图表配置为 pod 的 `fsGroup`（组标识）和 `runAsUser`（用户标识）指定了[安全上下文](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)。目前，{{site.data.keyword.containershort_notm}} 不支持 `fsGroup` 规范，而仅支持将 `runAsUser` 设置为 `0`（root 用户许可权）。

{: tsResolve}
从映像、部署或 Helm 图表配置文件中除去配置的 `fsGroup` 和 `runAsUser` 的 `securityContext` 字段，然后重新部署。如果需要将安装路径的所有权从 `nobody` 更改为其他值，请[添加非 root 用户访问权](cs_storage.html#nonroot)。

<br />


## 无法通过 LoadBalancer 服务连接到应用程序
{: #cs_loadbalancer_fails}

{: tsSymptoms}
您已通过在集群中创建 LoadBalancer 服务来向公众公开应用程序。但尝试通过负载均衡器的公共 IP 地址连接到应用程序时，连接失败或超时。

{: tsCauses}
由于以下某种原因，LoadBalancer 服务可能未正常运行：

-   集群为免费集群，或者为仅具有一个工作程序节点的标准集群。
-   集群尚未完全部署。
-   LoadBalancer 服务的配置脚本包含错误。

{: tsResolve}
要对 LoadBalancer 服务进行故障诊断，请执行以下操作：

1.  检查是否设置了完全部署的标准集群，以及该集群是否至少有两个工作程序节点，以确保 LoadBalancer 服务具有高可用性。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    在 CLI 输出中，确保工作程序节点的 **Status** 显示 **Ready**，并且 **Machine Type** 显示除了 **free** 之外的机器类型。

2.  检查 LoadBalancer 服务的配置文件是否准确。

  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: myservice
  spec:
    type: LoadBalancer
    selector:
      <selectorkey>:<selectorvalue>
    ports:
     - protocol: TCP
       port: 8080
  ```
  {: pre}

    1.  检查是否已将 **LoadBalancer** 定义为服务类型。
    2.  确保使用的是部署应用程序时在 **label/metadata** 部分中所用的 **<selectorkey>** 和 **<selectorvalue>**。
    3.  检查是否使用的是应用程序侦听的**端口**。

3.  检查 LoadBalancer 服务，并查看 **Events** 部分以查找潜在错误。

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    查找以下错误消息：
    

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>要使用 LoadBalancer 服务，您必须有至少包含两个工作程序节点的标准集群。
    </li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>此错误消息指示没有任何可移植公共 IP 地址可供分配给 LoadBalancer 服务。请参阅<a href="cs_subnets.html#subnets">向集群添加子网</a>，以了解有关如何为集群请求可移植公共 IP 地址的信息。有可移植的公共 IP 地址可供集群使用后，将自动创建 LoadBalancer 服务。
    </li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>您使用 **loadBalancerIP** 部分为 LoadBalancer 服务定义了可移植公共 IP 地址，但此可移植公共 IP 地址在可移植公共子网中不可用。请更改 LoadBalancer 服务配置脚本，并选择其中一个可用的可移植公共 IP 地址，或者从脚本中除去 **loadBalancerIP** 部分，以便可以自动分配可用的可移植公共 IP 地址。
    </li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>您没有足够的工作程序节点可部署 LoadBalancer 服务。一个原因可能是您已部署了包含多个工作程序节点的标准集群，但供应这些工作程序节点失败。
    </li>
    <ol><li>列出可用的工作程序节点。</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>如果找到了至少两个可用的工作程序节点，请列出工作程序节点详细信息。</br><pre class="codeblock"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
    <li>确保分别由 <code>kubectl get nodes</code> 和 <code>bx cs [&lt;cluster_name_or_id&gt;] worker-get</code> 命令返回的工作程序节点的公共和专用 VLAN 标识相匹配。</li></ol></li></ul>

4.  如果使用定制域来连接到 LoadBalancer 服务，请确保定制域已映射到 LoadBalancer 服务的公共 IP 地址。
    1.  找到 LoadBalancer 服务的公共 IP 地址。

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  检查定制域是否已映射到指针记录 (PTR) 中 LoadBalancer 服务的可移植公共 IP 地址。

<br />


## 无法通过 Ingress 连接到应用程序
{: #cs_ingress_fails}

{: tsSymptoms}
您已通过为集群中的应用程序创建 Ingress 资源来向公众公开应用程序。但尝试通过 Ingress 应用程序负载均衡器的公共 IP 地址或子域连接到应用程序时，连接失败或超时。

{: tsCauses}
由于以下原因，Ingress 可能未正常运行：
<ul><ul>
<li>集群尚未完全部署。
<li>集群设置为免费集群，或设置为仅具有一个工作程序节点的标准集群。
<li>Ingress 配置脚本包含错误。
</ul></ul>

{: tsResolve}
要对 Ingress 进行故障诊断，请执行以下操作：

1.  检查是否设置了完全部署的标准集群，以及该集群是否至少有两个工作程序节点，以确保 Ingress 应用程序负载均衡器具有高可用性。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    在 CLI 输出中，确保工作程序节点的 **Status** 显示 **Ready**，并且 **Machine Type** 显示除了 **free** 之外的机器类型。

2.  检索 Ingress 应用程序负载均衡器子域和公共 IP 地址，然后对每一项执行 ping 操作。

    1.  检索应用程序负载均衡器子域。

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  对 Ingress 应用程序负载均衡器子域执行 ping 操作。

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  检索 Ingress 应用程序负载均衡器的公共 IP 地址。

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  对 Ingress 应用程序负载均衡器公共 IP 地址执行 ping 操作。

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    如果对于 Ingress 应用程序负载均衡器的公共 IP 地址或子域，CLI 返回超时，并且您已设置定制防火墙来保护工作程序节点，那么可能需要在[防火墙](#cs_firewall)中打开其他端口和联网组。

3.  如果使用的是定制域，请确保定制域已通过域名服务 (DNS) 提供程序映射到 IBM 提供的 Ingress 应用程序负载均衡器的公共 IP 地址或子域。
    1.  如果使用的是 Ingress 应用程序负载均衡器子域，请检查规范名称记录 (CNAME)。
    2.  如果使用的是 Ingress 应用程序负载均衡器公共 IP 地址，请检查定制域是否已映射到指针记录 (PTR) 中的可移植公共 IP 地址。
4.  检查 Ingress 资源配置文件。

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress_subdomain>
        secretName: <ingress_tlssecret>
      rules:
      - host: <ingress_subdomain>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  检查 Ingress 应用程序负载均衡器子域和 TLS 证书是否正确。要查找 IBM 提供的子域和 TLS 证书，请运行 `bx cs cluster-get <cluster_name_or_id>`。
    2.  确保应用程序侦听的是在 Ingress 的 **path** 部分中配置的路径。如果应用程序设置为侦听根路径，请包含 **/** 以作为路径。
5.  检查 Ingress 部署，并查找潜在的警告或错误消息。

    ```
  kubectl describe ingress <myingress>
  ```
    {: pre}

    例如，在输出的 **Events** 部分中，您可能会看到有关 Ingress 资源中或使用的特定注释中值无效的警告消息。

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xx,169.xx.xxx.xx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.mybluemix.net
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

6.  检查应用程序负载均衡器的日志。
    1.  检索正在集群中运行的 Ingress pod 的标识。

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  检索每个 Ingress pod 的日志。

      ```
      kubectl logs <ingress_pod_id> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  在应用程序负载均衡器日志中查找错误消息。

<br />



## Ingress 应用程序负载均衡器私钥问题
{: #cs_albsecret_fails}

{: tsSymptoms}
将 Ingress 应用程序负载均衡器私钥部署到集群后，在 {{site.data.keyword.cloudcerts_full_notm}} 中查看证书时，`Description` 字段未使用该私钥名称进行更新。

列出有关应用程序负载均衡器私钥的信息时，阶段状态为 `*_failed`。例如，`create_failed`、`update_failed` 或 `delete_failed`。

{: tsResolve}
查看以下导致应用程序负载均衡器私钥可能失败的原因以及对应的故障诊断步骤：

<table>
 <thead>
 <th>问题原因</th>
 <th>解决方法</th>
 </thead>
 <tbody>
 <tr>
 <td>您没有下载和更新证书数据所需的访问角色。</td>
 <td>请咨询帐户管理员，要求为您分配对 {{site.data.keyword.cloudcerts_full_notm}} 实例的**操作员**和**编辑者**角色。有关更多详细信息，请参阅 {{site.data.keyword.cloudcerts_short}} 的<a href="/docs/services/certificate-manager/about.html#identity-access-management">身份和访问权管理</a>。</td>
 </tr>
 <tr>
 <td>创建、更新或除去时提供的证书 CRN 所属的帐户与集群不同。</td>
 <td>检查提供的证书 CRN 导入到的 {{site.data.keyword.cloudcerts_short}} 服务实例是否与集群部署在同一帐户中。</td>
 </tr>
 <tr>
 <td>创建时提供的证书 CRN 不正确。</td>
 <td><ol><li>检查提供的证书 CRN 字符串的准确性。</li><li>如果发现证书 CRN 是准确的，请尝试更新私钥：<code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>如果此命令生成 <code>update_failed</code> 阶段状态，请除去私钥：<code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></li><li>重新部署私钥：<code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>更新时提供的证书 CRN 不正确。</td>
 <td><ol><li>检查提供的证书 CRN 字符串的准确性。</li><li>如果发现证书 CRN 是准确的，请除去私钥：<code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></li><li>重新部署私钥：<code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>尝试更新私钥：<code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>{{site.data.keyword.cloudcerts_long_notm}} 服务遭遇停机时间。</td>
 <td>检查 {{site.data.keyword.cloudcerts_short}} 服务是否已启动并在运行。</td>
 </tr>
 </tbody></table>

<br />


## 无法使用已更新的配置值安装 Helm 图表
{: #cs_helm_install}

{: tsSymptoms}
尝试通过运行 `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>` 来安装更新的 Helm 图表时，将获得 `Error: failed to download "ibm/<chart_name>"` 错误消息。

{: tsCauses}
Helm 实例中 {{site.data.keyword.Bluemix_notm}} 存储库的 URL 可能不正确。

{: tsResolve}
要对 Helm 图表进行故障诊断，请执行以下操作：

1. 列出 Helm 实例中当前可用的存储库。

    ```
    helm repo list
    ```
    {: pre}

2. 在输出中，验证 {{site.data.keyword.Bluemix_notm}} 存储库 `ibm` 的 URL 是否为 `https://registry.bluemix.net/helm/ibm`。

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * 如果该 URL 不正确，请执行以下操作：

        1. 除去 {{site.data.keyword.Bluemix_notm}} 存储库。

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. 重新添加 {{site.data.keyword.Bluemix_notm}} 存储库。

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * 如果该 URL 正确，请从相应存储库中获取最新更新。

        ```
        helm repo update
        ```
        {: pre}

3. 使用更新安装 Helm 图表。

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}


<br />


## 无法与 strongSwan Helm 图表建立 VPN 连接
{: #cs_vpn_fails}

{: tsSymptoms}
通过运行 `kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status` 来检查 VPN 连接时，未看到阶段状态 `ESTABLISHED`，或者 VPN pod 处于 `ERROR` 状态或继续崩溃并重新启动。

{: tsCauses}
Helm 图表配置文件具有不正确的值、缺少值或有语法错误。

{: tsResolve}
尝试使用 strongSwan Helm 图表建立 VPN 连接时，很有可能 VPN 阶段状态一开始不是 `ESTABLISHED`。您可能需要检查多种类型的问题，并相应地更改配置文件。要对 strongSwan VPN 连接进行故障诊断，请执行以下操作：

1. 针对配置文件中的设置检查内部部署 VPN 端点设置。如果存在不匹配项：

    <ol>
    <li>删除现有的 Helm 图表。</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>修正 <code>config.yaml</code> 文件中不正确的值，并保存更新的文件。</li>
    <li>安装新的 Helm 图表。</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

2. 如果 VPN pod 处于 `ERROR` 状态或继续崩溃并重新启动，那么可能是由于在图表的配置映射中对 `ipsec.conf` 设置进行了参数验证。

    <ol>
    <li>检查 strongSwan pod 日志中是否有任何验证错误。</br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>如果存在验证错误，请删除现有 Helm 图表。</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>修正 `config.yaml` 文件中不正确的值，并保存更新的文件。</li>
    <li>安装新的 Helm 图表。</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

3. 运行 strongSwan 图表定义中包含的 5 个 Helm 测试。

    <ol>
    <li>运行 Helm 测试。</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>如果任何测试失败，请参阅[了解 Helm VPN 连接测试](cs_vpn.html#vpn_tests_table)，以获取有关每个测试的信息以及测试可能失败的原因。<b>注</b>：某些测试有一些要求，而这些要求在 VPN 配置中是可选设置。如果某些测试失败，失败可能是可接受的，具体取决于您是否指定了这些可选设置。</li>
    <li>通过查看测试 pod 的日志来查看失败测试的输出。<br><pre class="codeblock"><code>kubectl logs -n kube-system <test_program></code></pre></li>
    <li>删除现有的 Helm 图表。</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>修正 <code>config.yaml</code> 文件中不正确的值，并保存更新的文件。</li>
    <li>安装新的 Helm 图表。</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    <li>要检查更改，请执行以下操作：<ol><li>获取当前测试 pod。</br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>清除当前测试 pod。</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>重新运行测试。</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. 运行在 VPN pod 映像内打包的 VPN 调试工具。

    1. 设置 `STRONGSWAN_POD` 环境变量。

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. 运行调试工具。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        该工具在对常见联网问题运行各种测试时，会输出多页信息。以 `ERROR`、`WARNING`、`VERIFY` 或 `CHECK` 开头的输出行指示 VPN 连接可能存在错误。

    <br />


## 添加或删除工作程序节点后，strongSwan VPN 连接失败
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
先前已使用 strongSwan IPSec VPN 服务建立了有效的 VPN 连接。但是，在集群上添加或删除工作程序节点后，遇到了下列一种或多种症状：

* VPN 的阶段状态不为 `ESTABLISHED`
* 无法从内部部署网络访问新工作程序节点
* 无法从新工作程序节点上运行的 pod 访问远程网络

{: tsCauses}
如果添加了工作程序节点：

* 工作程序节点在新的专用子网上供应，该子网未由现有 `localSubnetNAT` 或 `local.subnet` 设置通过 VPN 连接公开
* 无法将 VPN 路径添加到工作程序节点，因为工作程序具有未包含在现有 `tolerations` 或 `nodeSelector` 设置中的污点或标签
* VPN pod 在新的工作程序节点上运行，但该工作程序节点的公共 IP 地址不允许通过内部部署防火墙

如果删除了工作程序节点：

* 由于对现有 `tolerations` 或 `nodeSelector` 设置中的特定污点或标签存在限制，因此该工作程序节点是唯一在运行 VPN pod 的节点

{: tsResolve}
更新 Helm 图表值以反映工作程序节点更改：

1. 删除现有的 Helm 图表。

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. 打开 strongSwan VPN 服务的配置文件。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. 检查以下设置并根据需要进行更改，以反映出已删除或已添加的工作程序节点。

    如果添加了工作程序节点：

    <table>
     <thead>
     <th>设置</th>
     <th>描述</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>添加的工作程序节点可能部署在新的专用子网上，该子网不同于其他工作程序节点所在的其他现有子网。如果是使用子网 NAT 来重新映射集群的专用本地 IP 地址，并且在新子网上添加了工作程序节点，请将新的子网 CIDR 添加到此设置。</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>如果先前将 VPN pod 限制为在具有特定标签的任何工作程序节点上运行，并且希望将 VPN 路径添加到该工作程序，请确保添加的工作程序节点具有该标签。</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>如果添加的工作程序节点已有污点，并且您希望将 VPN 路径添加到该工作程序，请更改此设置以允许 VPN pod 在所有有污点的工作程序节点上或具有特定污点的工作程序节点上运行。</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>添加的工作程序节点可能部署在新的专用子网上，该子网不同于其他工作程序节点所在的其他现有子网。如果应用程序是由专用网络上的 NodePort 或 LoadBalancer 服务公开的，并且位于添加的新工作程序节点上，请将新的子网 CIDR 添加到此设置。**注**：如果将值添加到 `local.subnet`，请检查内部部署子网的 VPN 设置，以确定是否还必须更新这些设置。</td>
     </tr>
     </tbody></table>

    如果删除了工作程序节点：

    <table>
     <thead>
     <th>设置</th>
     <th>描述</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>如果是使用子网 NAT 重新映射特定专用本地 IP 地址，请从旧工作程序节点中除去任何 IP 地址。如果是使用子网 NAT 来重新映射整个子网，并且子网上没有剩余的工作程序节点，请从此设置中除去该子网 CIDR。</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>如果先前将 VPN pod 限制为在单个工作程序节点上运行，并且删除了该工作程序节点，请将此设置更改为允许 VPN pod 在其他工作程序节点上运行。</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>如果删除的工作程序节点没有污点，但保留的唯一工作程序节点有污点，请将此设置更改为允许 VPN pod 在所有有污点的工作程序节点上或具有特定污点的工作程序节点上运行。</td>
     </tr>
     </tbody></table>

4. 使用更新的值安装新 Helm 图表。

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. 检查图表部署状态。当图表就绪时，输出顶部附近的 **STATUS** 字段的值为 `DEPLOYED`。

    ```
    helm status <release_name>
    ```
    {: pre}

6. 在某些情况下，可能需要更改内部部署设置和防火墙设置，以匹配对 VPN 配置文件的更改。

7. 启动 VPN。
    * 如果 VPN 连接是由集群启动的（`ipsec.auto` 设置为 `start`），请先在内部部署网关上启动 VPN，然后在集群上启动 VPN。
    * 如果 VPN 连接是由内部部署网关启动的（`ipsec.auto` 设置为 `auto`），请先在集群上启动 VPN，然后在内部部署网关上启动 VPN。

8. 设置 `STRONGSWAN_POD` 环境变量。

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. 检查 VPN 的状态。

    ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
    {: pre}

    * 如果 VPN 连接的阶段状态为 `ESTABLISHED`，说明 VPN 连接成功。无需进一步操作。

    * 如果仍存在连接问题，请参阅[无法建立与 stronSwan Helm 图表的 VPN 连接](#cs_vpn_fails)，以进一步对 VPN 连接进行故障诊断。

<br />


## 无法检索用于 Calico CLI 配置的 ETCD URL
{: #cs_calico_fails}

{: tsSymptoms}
检索 `<ETCD_URL>` 以[添加网络策略](cs_network_policy.html#adding_network_policies)时，您获得 `calico-config not found` 错误消息。

{: tsCauses}
集群不是 [Kubernetes V1.7](cs_versions.html) 或更高版本。

{: tsResolve}
使用与较早版本 Kubernetes 兼容的命令来[更新集群](cs_cluster_update.html#master)或检索 `<ETCD_URL>`。

要检索 `<ETCD_URL>`，请运行以下某个命令：

- Linux 和 OS X：

    ```
              kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
              ```
    {: pre}

- Windows：<ol>
    <li> 获取 kube-system 名称空间中 pod 的列表，并找到 Calico 控制器 pod。</br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>示例：</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> 查看 Calico 控制器 pod 的详细信息。</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
    <li> 找到 ETCD 端点值。示例：<code>https://169.1.1.1:30001</code></ol>

检索 `<ETCD_URL>` 时，继续执行(添加网络策略)[cs_network_policy.html#adding_network_policies]中列出的步骤。

<br />




## 获取帮助和支持
{: #ts_getting_help}

从何处开始对容器进行故障诊断？
{: shortdesc}

-   要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，请[检查 {{site.data.keyword.Bluemix_notm}} 状态页面 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/bluemix/support/#status)。
-   在 [{{site.data.keyword.containershort_notm}} Slack ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://ibm-container-service.slack.com) 中发布问题。提示：如果未将 IBM 标识用于 {{site.data.keyword.Bluemix_notm}} 帐户，请针对此 Slack [请求邀请](https://bxcs-slack-invite.mybluemix.net/)。
-   请复查论坛，以查看是否有其他用户遇到相同的问题。使用论坛进行提问时，请使用适当的标记来标注您的问题，以方便 {{site.data.keyword.Bluemix_notm}} 开发团队识别。

    -   如果您有关于使用 {{site.data.keyword.containershort_notm}} 开发或部署集群或应用程序的技术问题，请在 [Stack Overflow ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) 上发布您的问题，并使用 `ibm-cloud`、`kubernetes` 和 `containers` 标记您的问题。
    -   有关服务的问题和入门指示信息，请使用 [IBM developerWorks dW Answers ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 论坛。请加上 `ibm-cloud` 和 `containers` 标记。
    有关使用论坛的更多详细信息，请参阅[获取帮助](/docs/get-support/howtogetsupport.html#using-avatar)。

-   联系 IBM 支持。有关提交 IBM 支持凭单或支持级别和凭单严重性的信息，请参阅[联系支持人员](/docs/get-support/howtogetsupport.html#getting-customer-support)。

{:tip}
报告问题时，请包含集群标识。要获取集群标识，请运行 `bx cs clusters`。
