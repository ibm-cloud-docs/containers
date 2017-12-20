---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 用于管理集群的 CLI 参考
{: #cs_cli_reference}

请参阅以下命令来创建和管理集群。
{:shortdesc}

**提示：**在查找 `bx cr` 命令吗？请参阅 [{{site.data.keyword.registryshort_notm}} CLI 参考](/docs/cli/plugins/registry/index.html)。在查找 `kubectl` 命令吗？请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)。


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="用于在 {{site.data.keyword.Bluemix_notm}} 上创建集群的命令">
 <thead>
    <th colspan=5>用于在 {{site.data.keyword.Bluemix_notm}} 上创建集群的命令</th>
 </thead>
 <tbody>
  <tr>
    <td>[bx cs albs](#cs_albs)</td>
    <td>[bx cs alb-configure](#cs_alb_configure)</td>
    <td>[bx cs alb-get](#cs_alb_get)</td>
    <td>[bx cs alb-types](#cs_alb_types)</td>
    <td>[bx cs cluster-config](#cs_cluster_config)</td>
  </tr>
 <tr>
    <td>[bx cs cluster-create](#cs_cluster_create)</td>
    <td>[bx cs cluster-get](#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[bx cs cluster-service-unbind](#cs_cluster_service_unbind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-services](#cs_cluster_services)</td>
    <td>[bx cs cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[bx cs cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[bx cs cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[bx cs cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-update](#cs_cluster_update)</td>
    <td>[bx cs clusters](#cs_clusters)</td>
    <td>[bx cs credentials-set](#cs_credentials_set)</td>
    <td>[bx cs credentials-unset](#cs_credentials_unset)</td>
    <td>[bx cs help](#cs_help)</td>
 </tr>
 <tr>
    <td>[bx cs init](#cs_init)</td>
    <td>[bx cs kube-versions](#cs_kube_versions)</td>
    <td>[bx cs locations](#cs_datacenters)</td>
    <td>[bx cs logging-config-create](#cs_logging_create)</td>
    <td>[bx cs logging-config-get](#cs_logging_get)</td>
 </tr>
 <tr>
    <td>[bx cs logging-config-rm](#cs_logging_rm)</td>
    <td>[bx cs logging-config-update](#cs_logging_update)</td>
    <td>[bx cs machine-types](#cs_machine_types)</td>
    <td>[bx cs subnets](#cs_subnets)</td>
    <td>[bx cs vlans](#cs_vlans)</td>
 </tr>
 <tr>
    <td>[bx cs webhook-create](#cs_webhook_create)</td>
    <td>[bx cs worker-add](#cs_worker_add)</td>
    <td>[bx cs worker-get](#cs_worker_get)</td>
    <td>[bx cs worker-rm](#cs_worker_rm)</td>
    <td>[bx cs worker-update](#cs_worker_update)</td>
 </tr>
 <tr>
    <td>[bx cs worker-reboot](#cs_worker_reboot)</td>
    <td>[bx cs worker-reload](#cs_worker_reload)</td>
    <td>[bx cs workers](#cs_workers)</td>
 </tr>
 </tbody>
 </table>

**提示：**要查看 {{site.data.keyword.containershort_notm}} 插件的版本，请运行以下命令。

```
bx plugin list
```
{: pre}

## bx cs 命令
{: #cs_commands}


### bx cs albs --cluster CLUSTER
{: #cs_albs}

查看集群中所有应用程序负载均衡器 (ALB) 的状态。ALB 也称为 Ingress 控制器。如果未返回任何 ALB 标识，说明集群没有可移植子网。您可以为集群[创建](#cs_cluster_subnet_create)或[添加](#cs_cluster_subnet_add)子网。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>列出其中可用应用程序负载均衡器的集群的名称或标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs albs --cluster mycluster
  ```
  {: pre}

### bx cs alb-configure --albID ALB_ID [--enable][--disable][--user-ip USERIP]
{: #cs_alb_configure}

在标准集群中启用或禁用应用程序负载均衡器 (ALB)，也称为 Ingress 控制器。缺省情况下，已启用公共应用程序负载均衡器。

**命令选项**：

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB 的标识。运行 <code>bx cs albs <em>--cluster </em>CLUSTER</code> 可查看集群中 ALB 的标识。此值是必需的。</dd>

   <dt><code>--enable</code></dt>
   <dd>包含此标志可在集群中启用 ALB。</dd>

   <dt><code>--disable</code></dt>
   <dd>包含此标志可在集群中禁用 ALB。</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>此参数仅可用于专用 ALB</li>
    <li>专用 ALB 将使用用户提供的专用子网中的 IP 地址进行部署。如果未提供任何 IP 地址，那么该 ALB 将使用 IBM Cloud infrastructure (SoftLayer) 的专用子网中的随机 IP 地址进行部署。</li>
   </ul>
   </dd>
   </dl>

**示例**：

  启用 ALB 的示例：

  ```
  bx cs alb-configure --albID my_alb_id --enable
  ```
  {: pre}

  禁用 ALB 的示例：

  ```
  bx cs alb-configure --albID my_alb_id --disable
  ```
  {: pre}

  使用用户提供的 IP 地址启用 ALB 的示例：

  ```
  bx cs alb-configure --albID my_private_alb_id --enable --user-ip user_ip
  ```
  {: pre}

### bx cs alb-get --albID ALB_ID
{: #cs_alb_get}

查看应用程序负载均衡器 (ALB) 的详细信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB 的标识。运行 <code>bx cs albs --cluster <em>CLUSTER</em></code> 可查看集群中 ALB 的标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs alb-get --albID ALB_ID
  ```
  {: pre}

### bx cs alb-types
{: #cs_alb_types}

查看区域中支持的应用程序负载均衡器类型。

<strong>命令选项</strong>：

   无

**示例**：

  ```
  bx cs alb-types
  ```
  {: pre}

### bx cs cluster-config CLUSTER [--admin][--export]
{: #cs_cluster_config}

登录后，下载 Kubernetes 配置数据和证书，以连接到集群并运行 `kubectl` 命令。这些文件会下载到 `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**命令选项**：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--admin</code></dt>
   <dd>下载超级用户角色的 TLS 证书和许可权文件。您可以使用证书来自动执行集群中的任务，而无需重新认证。这些文件会下载到 `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`。此值是可选的。</dd>

   <dt><code>--export</code></dt>
   <dd>下载 Kubernetes 配置数据和证书，而不包含导出命令以外的任何消息。由于未显示任何消息，因此您可以在创建自动化脚本时使用此标志。此值是可选的。</dd>
   </dl>

**示例**：

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--workers WORKER]
{: #cs_cluster_create}

在组织中创建集群。

<strong>命令选项</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>用于创建标准集群的 YAML 文件的路径。您可以使用 YAML 文件，而不使用此命令中提供的选项来定义集群的特征。
此值对于标准集群是可选的，且不可用于 Lite 集群。

<p><strong>注</strong>：如果在命令中提供的选项与 YAML 文件中的参数相同，那么命令中的值将优先于 YAML 中的值。例如，您在 YAML 文件中定义了位置，并在命令中使用了 <code>--location</code> 选项，那么在该命令选项中输入的值会覆盖 YAML 文件中的相应值。<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
</code></pre>


<table>
    <caption>表 1. 了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>将 <code><em>&lt;cluster_name&gt;</em></code> 替换为集群的名称。</td>
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>将 <code><em>&lt;location&gt;</em></code> 替换为要在其中创建集群的位置。可用的位置取决于您登录到的区域。要列出可用位置，请运行 <code>bx cs locations</code>。</td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>缺省情况下，将在与集群关联的 VLAN 上创建公用和专用可移植子网。将 <code><em>&lt;no-subnet&gt;</em></code> 替换为 <code><em>true</em></code> 可避免为集群创建子网。您可以日后为集群[创建](#cs_cluster_subnet_create)或[添加](#cs_cluster_subnet_add)子网。</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>将 <code><em>&lt;machine_type&gt;</em></code> 替换为要用于工作程序节点的机器类型。要列出您所在位置的可用机器类型，请运行 <code>bx cs machine-types <em>&lt;location&gt;</em></code>。</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>将 <code><em>&lt;private_vlan&gt;</em></code> 替换为要用于工作程序节点的专用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code> 并查找以 <code>bcr</code>（后端路由器）开头的 VLAN 路由器。</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>将 <code><em>&lt;public_vlan&gt;</em></code> 替换为要用于工作程序节点的公用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code> 并查找以 <code>fcr</code>（前端路由器）开头的 VLAN 路由器。</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 <code>shared</code>。</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>将 <code><em>&lt;number_workers&gt;</em></code> 替换为要部署的工作程序节点数。</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>集群主节点的 Kubernetes 版本。此值是可选的。除非指定，否则会使用受支持 Kubernetes 版本的缺省值来创建集群。要查看可用版本，请运行 <code>bx cs kube-versions</code>。</td>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。此值对于标准集群是可选的，且不可用于 Lite 集群。</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>要在其中创建集群的位置。可用的位置取决于您登录到的 {{site.data.keyword.Bluemix_notm}} 区域。请选择实际离您最近的区域，以获得最佳性能。
此值对于标准集群是必需的，对于 Lite 集群是可选的。

<p>复查[可用位置](cs_regions.html#locations)。
</p>

<p><strong>注</strong>：选择您所在国家或地区以外的位置时，请记住，您可能需要法律授权才能将数据实际存储在国外。</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>所选择的机器类型会影响部署到工作程序节点的容器可用的内存量和磁盘空间量。要列出可用的机器类型，请参阅 [bx cs machine-types <em>LOCATION</em>](#cs_machine_types)。此值对于标准集群是必需的，且不可用于 Lite 集群。</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>集群的名称。此值是必需的。</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>集群主节点的 Kubernetes 版本。此值是可选的。除非指定，否则会使用受支持 Kubernetes 版本的缺省值来创建集群。要查看可用版本，请运行 <code>bx cs kube-versions</code>。</dd>

<dt><code>--no-subnet</code></dt>
<dd>缺省情况下，将在与集群关联的 VLAN 上创建公用和专用可移植子网。包含 <code>--no-subnets</code> 标志可避免为集群创建子网。您可以日后为集群[创建](#cs_cluster_subnet_create)或[添加](#cs_cluster_subnet_add)子网。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>此参数不可用于 Lite 集群。</li>
<li>如果此标准集群是您在此位置中创建的第一个标准集群，请勿包含此标志。创建集群时，将为您创建专用 VLAN。</li>
<li>如果之前在此位置中已创建标准集群，或者之前在 IBM Cloud infrastructure (SoftLayer) 中已创建专用 VLAN，那么必须指定该专用 VLAN。

<p><strong>注</strong>：使用 create 命令指定的公用和专用 VLAN 必须匹配。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。不要使用不匹配的公用和专用 VLAN 来创建集群。</p></li>
</ul>

<p>要了解您是否已具有用于特定位置的专用 VLAN，或要找到现有专用 VLAN 的名称，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code>。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>此参数不可用于 Lite 集群。</li>
<li>如果此标准集群是您在此位置中创建的第一个标准集群，请勿使用此标志。创建集群时，将为您创建公用 VLAN。</li>
<li>如果之前在此位置中已创建标准集群，或者之前在 IBM Cloud infrastructure (SoftLayer) 中已创建公用 VLAN，那么必须指定该公用 VLAN。

<p><strong>注</strong>：使用 create 命令指定的公用和专用 VLAN 必须匹配。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。不要使用不匹配的公用和专用 VLAN 来创建集群。</p></li>
</ul>

<p>要了解您是否已具有用于特定位置的公用 VLAN，或要找到现有公用 VLAN 的名称，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code>。</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>要在集群中部署的工作程序节点数。如果未指定此选项，将创建具有 1 个工作程序节点的集群。此值对于标准集群是可选的，且不可用于 Lite 集群。

<p><strong>注</strong>：为每个工作程序节点分配了唯一的工作程序节点标识和域名，在创建集群后，不得手动更改该标识和域名。更改标识或域名会阻止 Kubernetes 主节点管理集群。</p></dd>
</dl>

**示例**：

  

  标准集群的示例：
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  Lite 集群的示例：

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  {{site.data.keyword.Bluemix_dedicated_notm}} 环境的示例：

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER [--showResources]
{: #cs_cluster_get}

查看有关组织中集群的信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>显示集群的 VLAN 和子网。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

从组织中除去集群。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制除去集群，而不显示用户提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

向集群添加 {{site.data.keyword.Bluemix_notm}} 服务。

**提示**：对于 {{site.data.keyword.Bluemix_dedicated_notm}} 用户，请参阅[在 {{site.data.keyword.Bluemix_dedicated_notm}} 中向集群添加 {{site.data.keyword.Bluemix_notm}} 服务（封闭 Beta 版）](cs_cluster.html#binding_dedicated)。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名称空间的名称。此值是必需的。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>要绑定的 {{site.data.keyword.Bluemix_notm}} 服务实例的标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

从集群中除去 {{site.data.keyword.Bluemix_notm}} 服务。

**注：**除去 {{site.data.keyword.Bluemix_notm}} 服务时，会从集群中除去服务凭证。如果 pod 仍在使用该服务，那么除去操作会因为找不到服务凭证而失败。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名称空间的名称。此值是必需的。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>要除去的 {{site.data.keyword.Bluemix_notm}} 服务实例的标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces]
{: #cs_cluster_services}

列出绑定到集群中一个或全部 Kubernetes 名称空间的服务。如果未指定任何选项，那么将显示缺省名称空间的服务。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>包含绑定到集群中特定名称空间的服务。此值是可选的。</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>包含绑定到集群中所有名称空间的服务。此值是可选的。</dd>
    </dl>

**示例**：

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

使 IBM Cloud infrastructure (SoftLayer) 帐户中的子网可供指定集群使用。

**注**：使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containershort_notm}} 外部的其他用途。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>这是子网的标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs cluster-subnet-create CLUSTER SIZE VLAN_ID
{: #cs_cluster_subnet_create}

在 IBM Cloud infrastructure (SoftLayer) 帐户中创建子网，并使其可供 {{site.data.keyword.containershort_notm}} 中的指定集群使用。

**注**：使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containershort_notm}} 外部的其他用途。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。要列出集群，请使用 `bx cs clusters` [命令](#cs_clusters)。</dd>

   <dt><code><em>SIZE</em></code></dt>
   <dd>子网 IP 地址数。此值是必需的。可能的值为 8、16、32 或 64。</dd>

   <dt><code><em>VLAN_ID</em></code></dt>
   <dd>要在其中创建子网的 VLAN。此值是必需的。要列出可用的 VLAN，请使用 `bx cs vlans<location>` [命令](#cs_vlans)。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-subnet-create my_cluster 8 1764905
  ```
  {: pre}

### bx cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

将您自己的专用子网置于 {{site.data.keyword.containershort_notm}} 集群中。

此专用子网不是 IBM Cloud infrastructure (SoftLayer) 提供的子网。因此，您必须为子网配置任何入站和出站网络流量路由。要添加 IBM Cloud infrastructure (SoftLayer) 子网，请使用 `bx cs cluster-subnet-add` [命令](#cs_cluster_subnet_add)。

**注**：将专用用户子网添加到集群时，此子网的 IP 地址将用于集群中的专用负载均衡器。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containershort_notm}} 外部的其他用途。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>子网无类域间路由 (CIDR)。此值是必需的，且不得与 IBM Cloud infrastructure (SoftLayer) 使用的任何子网相冲突。

   支持的前缀范围从 `/30`（1 个 IP 地址）到 `/24`（253 个 IP 地址）。如果将 CIDR 设置为一个前缀长度，而稍后需要对其进行更改，请先添加新的 CIDR，然后[除去旧 CIDR](#cs_cluster_user_subnet_rm)。</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>专用 VLAN 的标识。此值是必需的。它必须与集群中一个或多个工作程序节点的专用 VLAN 标识相匹配。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-user-subnet-add my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

从指定集群除去自己的专用子网。

**注：**除去子网后，部署到您自己专用子网的 IP 地址的任何服务都将保持活动状态。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>子网无类域间路由 (CIDR)。此值是必需的，并且必须与 `bx cs cluster-user-subnet-add` [命令](#cs_cluster_user_subnet_add)设置的 CIDR 匹配。</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>专用 VLAN 的标识。此值是必需的，并且必须与 `bx cs cluster-user-subnet-add` [命令](#cs_cluster_user_subnet_add)设置的 VLAN 标识匹配。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-user-subnet-rm my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update]
{: #cs_cluster_update}

将 Kubernetes 主节点更新到缺省 API 版本。在更新期间，您无法访问或更改集群。用户已部署的工作程序节点、应用程序和资源不会被修改，并且将继续运行。

您可能需要更改 YAML 文件以供未来部署。请查看此[发行说明](cs_versions.html)以了解详细信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>
   
   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>集群的 Kubernetes 版本。如果未指定此标志，那么 Kubernetes 主节点将更新到缺省 API 版本。要查看可用版本，请运行 [bx cs kube-versions](#cs_kube_versions)。此值是可选的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制更新主节点，而不显示用户提示。此值是可选的。</dd>
   
   <dt><code>--force-update</code></dt>
   <dd>即便更改是跨 2 个以上的次版本，也仍尝试更新。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

查看组织中集群的列表。

<strong>命令选项</strong>：

  无

**示例**：

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

为 {{site.data.keyword.Bluemix_notm}} 帐户设置 IBM Cloud infrastructure (SoftLayer) 帐户凭证。这些凭证允许您通过 {{site.data.keyword.Bluemix_notm}} 帐户访问 IBM Cloud infrastructure (SoftLayer) 产品服务组合。

**注：**不要为一个 {{site.data.keyword.Bluemix_notm}} 帐户设置多个凭证。每个 {{site.data.keyword.Bluemix_notm}} 帐户仅链接到一个 IBM Cloud infrastructure (SoftLayer) 产品服务组合。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>IBM Cloud infrastructure (SoftLayer) 帐户用户名。此值是必需的。</dd>
   

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>IBM Cloud infrastructure (SoftLayer) 帐户 API 密钥。此值是必需的。<p>
要生成 API 密钥：<ol>
  <li>登录到 [IBM Cloud infrastructure (SoftLayer) 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://control.softlayer.com/)。</li>
  <li>选择<strong>帐户</strong>，然后选择<strong>用户</strong>。</li>
  <li>单击<strong>生成</strong>，为帐户生成 IBM Cloud infrastructure (SoftLayer) API 密钥。</li>
  <li>复制 API 密钥以在此命令中使用。</li>
  </ol>

  要查看现有 API 密钥：
  <ol>
  <li>登录到 [IBM Cloud infrastructure (SoftLayer) 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://control.softlayer.com/)。</li>
  <li>选择<strong>帐户</strong>，然后选择<strong>用户</strong>。</li>
  <li>单击<strong>查看</strong>以查看现有 API 密钥。</li>
  <li>复制 API 密钥以在此命令中使用。</li>
  </ol>
  </p></dd>
  </dl>

**示例**：

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

从 {{site.data.keyword.Bluemix_notm}} 帐户中除去 IBM Cloud infrastructure (SoftLayer) 帐户凭证。除去凭证后，无法再通过 {{site.data.keyword.Bluemix_notm}} 帐户访问 IBM Cloud infrastructure (SoftLayer) 产品服务组合。

<strong>命令选项</strong>：

   无

**示例**：

  ```
  bx cs credentials-unset
  ```
  {: pre}



### bx cs help
{: #cs_help}

查看支持的命令和参数的列表。

<strong>命令选项</strong>：

   无

**示例**：

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

初始化 {{site.data.keyword.containershort_notm}} 插件或指定要在其中创建或访问 Kubernetes 集群的区域。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>要使用的 {{site.data.keyword.containershort_notm}} API 端点。此值是可选的。示例：

    <ul>
    <li>美国南部：

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>美国东部：

    <pre class="codeblock">
    <code>bx cs init --host https://us-east.containers.bluemix.net</code>
    </pre>
    <p><strong>注</strong>：美国东部仅可与 CLI 命令一起使用。</p></li>

    <li>英国南部：

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>欧洲中部：

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>亚太地区南部：

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>



### bx cs kube-versions
{: #cs_kube_versions}

查看 {{site.data.keyword.containershort_notm}} 中支持的 Kubernetes 版本列表。将[集群主节点](#cs_cluster_update)和[工作程序节点](#cs_worker_update)更新到缺省版本以获取最新的稳定功能。

**命令选项**：

  无

**示例**：

  ```
  bx cs kube-versions
  ```
  {: pre}

### bx cs locations
{: #cs_datacenters}

查看可用于在其中创建集群的位置的列表。

<strong>命令选项</strong>：

   无

**示例**：

  ```
  bx cs locations
  ```
  {: pre}

### bx cs logging-config-create CLUSTER --logsource LOG_SOURCE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME] [--port LOG_SERVER_PORT] --type LOG_TYPE
{: #cs_logging_create}

创建日志记录配置。缺省情况下，名称空间日志会转发到 {{site.data.keyword.loganalysislong_notm}}。您可以使用此命令将名称空间日志转发到外部 syslog 服务器。您还可以使用此命令将应用程序、工作程序节点、Kubernetes 集群和 Ingress 控制器的日志转发至 {{site.data.keyword.loganalysisshort_notm}} 或外部 syslog 服务器。

<strong>命令选项</strong>：

<dl>
<dt><code><em>CLUSTER</em></code></dt>
<dd>集群的名称或标识。</dd>
<dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
<dd>要对其启用日志转发的日志源。接受的值为 <code>application</code>、<code>worker</code>、<code>kubernetes</code> 和 <code>ingress</code>。此值是必需的。</dd>
<dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
<dd>要从中将日志转发到 syslog 的 Docker 容器名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。对于名称空间，此值是必需的。如果未指定名称空间，那么容器中的所有名称空间都将使用此配置。</dd>
<dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
<dd>日志收集器服务器的主机名或 IP 地址。当记录类型为 <code>syslog</code> 时，此值是必需的。</dd>
<dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
<dd>日志收集器服务器的端口。当记录类型为 <code>syslog</code> 时，此值是可选的。如果未指定端口，那么将对 <code>syslog</code> 使用标准端口 <code>514</code>。</dd>
<dt><code>--type <em>LOG_TYPE</em></code></dt>
<dd>您要使用的日志转发协议。目前支持 <code>syslog</code> 和 <code>ibm</code>。此值是必需的。</dd>
</dl>

**示例**：

日志源 `namespace` 的示例：

  ```
  bx cs logging-config-create my_cluster --logsource namespaces --namespace my_namespace --hostname localhost --port 5514 --type syslog
  ```
  {: pre}

日志源 `ingress` 的示例：

  ```
  bx cs logging-config-create my_cluster --logsource ingress --type ibm
  ```
  {: pre}

### bx cs logging-config-get CLUSTER [--logsource LOG_SOURCE]
{: #cs_logging_get}

查看集群的所有日志转发配置，或基于日志源过滤日志记录配置。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>
   <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
   <dd>要过滤的日志源的类型。仅会返回集群中此日志源的日志记录配置。接受的值为 <code>namespaces</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 和 <code>ingress</code>。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  bx cs logging-config-get my_cluster --logsource worker
  ```
  {: pre}


### bx cs logging-config-rm CLUSTER --id LOG_CONFIG_ID
{: #cs_logging_rm}

删除日志转发配置。对于 Docker 容器名称空间，您可以停止将日志转发到 syslog 服务器。名称空间会继续将日志转发到 {{site.data.keyword.loganalysislong_notm}}。对于 Docker 容器名称空间以外的日志源，您可以停止将日志转发到 syslog 服务器或 {{site.data.keyword.loganalysisshort_notm}}。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>
   <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>要从日志源中除去的日志记录配置标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs logging-config-rm my_cluster --id my_log_config_id
  ```
  {: pre}


### bx cs logging-config-update CLUSTER [--namespace NAMESPACE][--id LOG_CONFIG_ID] [--hostname LOG_SERVER_HOSTNAME][--port LOG_SERVER_PORT] --type LOG_TYPE
{: #cs_logging_update}

将日志转发更新到要使用的日志记录服务器。对于 Docker 容器名称空间，您可以使用此命令来更新当前 syslog 服务器的详细信息或更改为其他 syslog 服务器。对于 Docker 容器名称空间以外的日志源，可以使用此命令来更改日志收集器服务器类型。目前，“syslog”和“ibm”是受支持的日志类型。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>
   <dt><code>--namespace <em>NAMESPACE</em></code></dt>
   <dd>要从中将日志转发到 syslog 的 Docker 容器名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。对于名称空间，此值是必需的。</dd>
   <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>要更新的日志记录配置标识。对于 Docker 容器名称空间以外的日志源，此值是必需的。</dd>
   <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>日志收集器服务器的主机名或 IP 地址。当记录类型为 <code>syslog</code> 时，此值是必需的。</dd>
   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>日志收集器服务器的端口。当记录类型为 <code>syslog</code> 时，此值是可选的。如果未指定端口，那么将对 <code>syslog</code> 使用标准端口 514。</dd>
   <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>您要使用的日志转发协议。目前支持 <code>syslog</code> 和 <code>ibm</code>。此值是必需的。</dd>
   </dl>

**日志类型 `ibm` 的示例**：

  ```
  bx cs logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**日志类型 `syslog` 的示例**：

  ```
  bx cs logging-config-update my_cluster --namespace my_namespace --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### bx cs machine-types LOCATION
{: #cs_machine_types}

查看可用于工作程序节点的机器类型的列表。每种机器类型都包含集群中每个工作程序节点的虚拟 CPU 量、内存量和磁盘空间量。 
- 名称中具有 `u2c` 或 `b2c` 的机器类型使用本地磁盘，而不是存储区联网 (SAN)，从而实现可靠性。可靠性优势包括在将字节序列化到本地磁盘时可提高吞吐量，以及减少因网络故障而导致的文件系统降级。这些机器类型包含用于操作系统文件系统的 25 GB 本地磁盘存储和用于 `/var/lib/docker`（这是写入所有容器数据的目录）的 100 GB 本地磁盘存储。 
- 名称中包含 `encrypted` 的机器类型将加密主机的 Docker 数据。存储所有容器数据的 `/var/lib/docker` 目录将使用 LUKS 加密进行加密。
- 不推荐使用名称中具有 `u1c` 或 `b1c` 的机器类型，例如 `u1c.2x4`。要开始使用 `u2c` 和 `b2c` 机器类型，请使用 `bx cs worker-add` 命令来添加使用已更新机器类型的工作程序节点。然后，使用 `bx cs worker-rm` 命令除去使用不推荐机器类型的工作程序节点。
</p>


<strong>命令选项</strong>：

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>输入要列出其中可用机器类型的位置。此值是必需的。复查[可用位置](cs_regions.html#locations)。
</dd></dl>

**示例**：

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

查看 IBM Cloud infrastructure (SoftLayer) 帐户中可用的子网列表。

<strong>命令选项</strong>：

   无

**示例**：

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

列出可用于 IBM Cloud infrastructure (SoftLayer) 帐户中位置的公用和专用 VLAN。要列出可用 VLAN，您必须具有付费帐户。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>输入要列出其中专用和公用 VLAN 的位置。此值是必需的。复查[可用位置](cs_regions.html#locations)。
</dd>
   </dl>

**示例**：

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

创建 Webhook。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>通知级别，例如 <code>Normal</code> 或 <code>Warning</code>。<code>Warning</code> 是缺省值。此值是可选的。</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Webhook 类型，如 slack。仅支持 slack。此值是必需的。</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>Webhook 的 URL。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN
{: #cs_worker_add}

将工作程序节点添加到标准集群。

<strong>命令选项</strong>：

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>集群的名称或标识。此值是必需的。</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>用于将工作程序节点添加到集群的 YAML 文件的路径。您可以使用 YAML 文件，而不使用此命令中提供的选项来定义其他工作程序节点。

        此值是可选的。

<p><strong>注</strong>：如果在命令中提供的选项与 YAML 文件中的参数相同，那么命令中的值将优先于 YAML 中的值。例如，您在 YAML 文件中定义了机器类型，并在命令中使用了 --machine-type 选项，那么在该命令选项中输入的值会覆盖 YAML 文件中的相应值。

      <pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_id&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>

<table>
<caption>表 2. 了解 YAML 文件的组成部分</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>将 <code><em>&lt;cluster_name_or_id&gt;</em></code> 替换为要在其中添加工作程序节点的集群的名称或标识。</td>
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>将 <code><em>&lt;location&gt;</em></code> 替换为要在其中部署工作程序节点的位置。可用的位置取决于您登录到的区域。要列出可用位置，请运行 <code>bx cs locations</code>。</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>将 <code><em>&lt;machine_type&gt;</em></code> 替换为要用于工作程序节点的机器类型。要列出您所在位置的可用机器类型，请运行 <code>bx cs machine-types <em>&lt;location&gt;</em></code>。</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>将 <code><em>&lt;private_vlan&gt;</em></code> 替换为要用于工作程序节点的专用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code> 并查找以 <code>bcr</code>（后端路由器）开头的 VLAN 路由器。</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>将 <code>&lt;public_vlan&gt;</code> 替换为要用于工作程序节点的公用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>bx cs vlans &lt;location&gt;</code> 并查找以 <code>fcr</code>（前端路由器）开头的 VLAN 路由器。</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>将 <code><em>&lt;number_workers&gt;</em></code> 替换为要部署的工作程序节点数。</td>
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。此值是可选的。</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>所选择的机器类型会影响部署到工作程序节点的容器可用的内存量和磁盘空间量。此值是必需的。要列出可用的机器类型，请参阅 [bx cs machine-types LOCATION](#cs_machine_types)。</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>整数，表示要在集群中创建的工作程序节点数。缺省值为 1。此值是可选的。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>创建集群时指定的专用 VLAN。此值是必需的。

<p><strong>注：</strong>您指定的公用和专用 VLAN 必须匹配。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。不要使用不匹配的公用和专用 VLAN 来创建集群。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>创建集群时指定的公用 VLAN。此值是可选的。

<p><strong>注：</strong>您指定的公用和专用 VLAN 必须匹配。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。不要使用不匹配的公用和专用 VLAN 来创建集群。</p></dd>
</dl>

**示例**：

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --hardware shared
  ```
  {: pre}

  {{site.data.keyword.Bluemix_dedicated_notm}} 的示例：

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u2c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

查看工作程序节点的详细信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>WORKER_NODE_ID</em></code></dt>
   <dd>工作程序节点的标识。运行 <code>bx cs workers <em>CLUSTER</em></code> 可查看集群中工作程序节点的标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs worker-get WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

重新引导集群中的工作程序节点。如果工作程序节点存在问题，请首先尝试重新引导该工作程序节点，这会重新启动该节点。如果重新引导未能解决问题，请尝试 `worker-reload` 命令。在重新引导期间，工作程序的状态不会更改。状态保持为 `deployed`，但阶段状态会更新。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制重新启动工作程序节点，而不显示用户提示。此值是可选的。</dd>

   <dt><code>--hard</code></dt>
   <dd>使用此选项可通过切断工作程序节点的电源来强制硬重新启动该工作程序节点。如果工作程序节点无响应或工作程序节点有一个 Docker 挂起，请使用此选项。此值是可选的。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

重新装入集群中的工作程序节点。如果工作程序节点存在问题，请首先尝试重新引导该工作程序节点。如果重新引导未能解决问题，请尝试 `worker-reload` 命令，此命令将重新装入该工作程序节点的所有必需配置。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制重新装入工作程序节点，而不显示用户提示。此值是可选的。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

从集群中除去一个或多个工作程序节点。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制除去工作程序节点，而不显示用户提示。此值是可选的。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update]
{: #cs_worker_update}

将工作程序节点更新到最新的 Kubernetes 版本。运行 `bx cs worker-update` 可能会导致应用程序和服务的停机时间。更新期间，所有 pod 都将重新安排到其他工作程序节点，如果数据未存储在 pod 外部，那么将删除数据。为避免停机时间，请确保在选定的工作程序节点更新时有足够的工作程序节点来处理工作负载。

在更新前，您可能需要更改 YAML 文件以进行部署。请查看此[发行说明](cs_versions.html)以了解详细信息。

<strong>命令选项</strong>：

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>列出了其中可用工作程序节点的集群的名称或标识。此值是必需的。</dd>
   
   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>集群的 Kubernetes 版本。如果未指定此标志，那么工作程序节点将更新到缺省版本。要查看可用版本，请运行 [bx cs kube-versions](#cs_kube_versions)。此值是可选的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制更新主节点，而不显示用户提示。此值是可选的。</dd>
   
   <dt><code>--force-update</code></dt>
   <dd>即便更改是跨 2 个以上的次版本，也仍尝试更新。此值是可选的。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>一个或多个工作程序节点的标识。列出多个工作程序节点时使用空格分隔。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs worker-update my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

查看集群中工作程序节点的列表以及每个工作程序节点的状态。

<strong>命令选项</strong>：

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>列出了其中可用工作程序节点的集群的名称或标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  bx cs workers mycluster
  ```
  {: pre}
