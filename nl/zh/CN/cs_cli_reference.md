---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

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

**提示：**在查找 `bx cr` 命令吗？请参阅 [{{site.data.keyword.registryshort_notm}} CLI 参考](/docs/cli/plugins/registry/index.html#containerregcli)。在查找 `kubectl` 命令吗？请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)。

 
<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="用于在 {{site.data.keyword.Bluemix_notm}} 上创建集群的命令">
 <thead>
    <th colspan=5>用于在 {{site.data.keyword.Bluemix_notm}} 上创建集群的命令</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_reference.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_reference.html#cs_cluster_create)</td> 
    <td>[bx cs cluster-get](cs_cli_reference.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_reference.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_reference.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_reference.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_reference.html#cs_cluster_services)</td> 
    <td>[bx cs cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</td>
    <td>[bx cs clusters](cs_cli_reference.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_reference.html#cs_credentials_unset)</td>
   <td>[bx cs locations](cs_cli_reference.html#cs_datacenters)</td> 
   <td>[bx cs help](cs_cli_reference.html#cs_help)</td>
   <td>[bx cs init](cs_cli_reference.html#cs_init)</td>
   <td>[bx cs machine-types](cs_cli_reference.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_reference.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_reference.html#cs_vlans)</td> 
    <td>[bx cs webhook-create](cs_cli_reference.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_reference.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_reference.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_reference.html#cs_worker_reload)</td> 
   <td>[bx cs worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_reference.html#cs_workers)</td>
   <td></td>
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

### bx cs cluster-config CLUSTER [--admin]
{: #cs_cluster_config}

登录后，下载 Kubernetes 配置数据和证书，以连接到集群并运行 `kubectl` 命令。这些文件会下载到 `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`。

**命令选项**：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code>--admin</code></dt>
   <dd>（可选）下载管理员 RBAC 角色的证书和许可权文件。具有这些文件的用户可以在集群上执行管理操作，如除去集群。</dd>
   </dl>

**示例**：

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--no-subnet][--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN][--workers WORKER]
{: #cs_cluster_create}

在组织中创建集群。

<strong>命令选项</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>（对于标准集群是可选的。对于 Lite 集群不可用。）用于创建标准集群的 YAML 文件的路径。您可以使用 YAML 文件，而不使用此命令中提供的选项来定义集群的特征。
<p><strong>注</strong>：如果在命令中提供的选项与 YAML 文件中的参数相同，那么命令中的值将优先于 YAML 中的值。例如，您在 YAML 文件中定义了位置，并在命令中使用了 <code>--location</code> 选项，那么在该命令选项中输入的值会覆盖 YAML 文件中的相应值。<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>


<table>
    <caption>表 1. 了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
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
     <td><code><em>machine-type</em></code></td>
     <td>将 <code><em>&lt;machine_type&gt;</em></code> 替换为要用于工作程序节点的机器类型。要列出您所在位置的可用机器类型，请运行 <code>bx cs machine-types <em>&lt;location&gt;</em></code>。</td> 
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>将 <code><em>&lt;private_vlan&gt;</em></code> 替换为要用于工作程序节点的专用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code> 并查找以 <code>bcr</code>（后端路由器）开头的 VLAN 路由器。</td> 
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>将 <code><em>&lt;public_vlan&gt;</em></code> 替换为要用于工作程序节点的公共 VLAN 的标识。要列出可用的 VLAN，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code> 并查找以 <code>fcr</code>（前端路由器）开头的 VLAN 路由器。</td> 
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 <code>shared</code>。</td> 
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>将 <code><em>&lt;number_workers&gt;</em></code> 替换为要部署的工作程序节点数。</td> 
     </tr>
     </tbody></table>
    </p></dd>
    
<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>（对于标准集群是可选的。对于 Lite 集群不可用。）工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>（对于标准集群是必需的。对于 Lite 集群是可选的。）要在其中创建集群的位置。可用的位置取决于您登录到的 {{site.data.keyword.Bluemix_notm}} 区域。选择物理上与您最近的区域，以获得最佳性能。
<p>可用位置为：<ul><li>美国南部<ul><li>dal10 [达拉斯]</li><li>dal12 [达拉斯]</li></ul></li><li>英国南部<ul><li>lon02 [伦敦]</li><li>lon04 [伦敦]</li></ul></li><li>欧洲中部<ul><li>ams03 [阿姆斯特丹]</li><li>ra02 [法兰克福]</li></ul></li><li>亚太南部<ul><li>syd01 [悉尼]</li><li>syd04 [悉尼]</li></ul></li></ul>
</p>

<p><strong>注</strong>：选择您所在国家或地区以外的位置时，请记住，您可能需要法律授权才能将数据实际存储在国外。</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>（对于标准集群是必需的。对于 Lite 集群不可用。）所选择的机器类型会影响部署到工作程序节点的容器可用的内存量和磁盘空间量。
要列出可用的机器类型，请参阅 [bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types)。</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>（必需）集群的名称。</dd>

<dt><code>--no-subnet</code></dt>
<dd>包含用于创建集群而不创建可移植子网的标志。缺省值是不使用此标志，而在 {{site.data.keyword.BluSoftlayer_full}} 产品服务组合中创建子网。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>（对于 Lite 集群不可用。）
<ul>
<li>如果此集群是您在此位置中创建的第一个集群，请勿包含此标志。创建集群时，将为您创建专用 VLAN。</li>
<li>如果之前在此位置中已创建集群，或者之前在 {{site.data.keyword.BluSoftlayer_notm}} 中已创建专用 VLAN，那么必须指定该专用 VLAN。<p><strong>注</strong>：使用 create 命令指定的公共和专用 VLAN 必须匹配。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公共 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。不要使用不匹配的公共和专用 VLAN 来创建集群。</p></li>
</ul>

<p>要了解您是否已具有用于特定位置的专用 VLAN，或要找到现有专用 VLAN 的名称，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code>。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>（对于 Lite 集群不可用。）
<ul>
<li>如果此集群是您在此位置中创建的第一个集群，请勿使用此标志。创建集群时，将为您创建公共 VLAN。</li>
<li>如果之前在此位置中已创建集群，或者之前在 {{site.data.keyword.BluSoftlayer_notm}} 中已创建公共 VLAN，那么必须指定该公共 VLAN。<p><strong>注</strong>：使用 create 命令指定的公共和专用 VLAN 必须匹配。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公共 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。不要使用不匹配的公共和专用 VLAN 来创建集群。</p></li>
</ul>

<p>要了解您是否已具有用于特定位置的公共 VLAN，或要找到现有公共 VLAN 的名称，请运行 <code>bx cs vlans <em>&lt;location&gt;</em></code>。</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>（对于标准集群是可选的。对于 Lite 集群不可用。）要在集群中部署的工作程序节点数。如果未指定此选项，将创建具有 1 个工作程序节点的集群。<p><strong>注</strong>：为每个工作程序节点分配了唯一的工作程序节点标识和域名，在创建集群后，不得手动更改该标识和域名。更改标识或域名会阻止 Kubernetes 主节点管理集群。</p></dd>
</dl>

**示例**：

  
  
  标准集群的示例：
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  Lite 集群的示例：

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  {{site.data.keyword.Bluemix_notm}} Dedicated 环境的示例：

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER
{: #cs_cluster_get}

查看有关组织中集群的信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>（必需）集群的名称或标识。</dd>
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
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code>-f</code></dt>
   <dd>（可选）使用此选项可强制除去集群，而不显示用户提示。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

将 {{site.data.keyword.Bluemix_notm}} 服务添加到集群。

**提示**：对于 {{site.data.keyword.Bluemix_notm}} Dedicated 用户，请参阅[在 {{site.data.keyword.Bluemix_notm}} Dedicated 中向集群添加 {{site.data.keyword.Bluemix_notm}} 服务（封闭 Beta 版）](cs_cluster.html#binding_dedicated)。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>（必需）Kubernetes 名称空间的名称。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>（必需）要绑定的 {{site.data.keyword.Bluemix_notm}} 服务实例的标识。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

从集群中除去 {{site.data.keyword.Bluemix_notm}} 服务。

**注**：除去 {{site.data.keyword.Bluemix_notm}} 服务时，会从集群中除去相应的服务凭证。如果 pod 仍在使用该服务，那么除去操作会因为找不到服务凭证而失败。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>（必需）Kubernetes 名称空间的名称。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>（必需）要除去的 {{site.data.keyword.Bluemix_notm}} 服务实例的标识。</dd>
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
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>（可选）包含绑定到集群中特定名称空间的服务。</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>（可选）包含绑定到集群中所有名称空间的服务。</dd>
    </dl>

**示例**：

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

使 {{site.data.keyword.BluSoftlayer_notm}} 帐户中的子网可供指定集群使用。

**注**：使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containershort_notm}} 外部的其他用途。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>（必需）子网的标识。</dd>
   </dl>

**示例**：

  ```
  bx cs cluster-subnet-add my_cluster subnet
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

为 {{site.data.keyword.Bluemix_notm}} 帐户设置 {{site.data.keyword.BluSoftlayer_notm}} 帐户凭证。这些凭证允许您通过自己的 {{site.data.keyword.Bluemix_notm}} 帐户访问 {{site.data.keyword.BluSoftlayer_notm}} 产品服务组合。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>（必需）{{site.data.keyword.BluSoftlayer_notm}} 帐户用户名。</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>（必需）{{site.data.keyword.BluSoftlayer_notm}} 帐户 API 密钥。   
 <p>
要生成 API 密钥：    
  <ol>
  <li>登录到 [{{site.data.keyword.BluSoftlayer_notm}} 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://control.softlayer.com/)。</li>
  <li>选择<strong>帐户</strong>，然后选择<strong>用户</strong>。</li>
  <li>单击<strong>生成</strong>，为您的帐户生成 {{site.data.keyword.BluSoftlayer_notm}} API 密钥。</li>
  <li>复制 API 密钥以在此命令中使用。</li>
  </ol>

  要查看现有 API 密钥：
  <ol>
  <li>登录到 [{{site.data.keyword.BluSoftlayer_notm}} 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://control.softlayer.com/)。</li>
  <li>选择<strong>帐户</strong>，然后选择<strong>用户</strong>。</li>
  <li>单击<strong>查看</strong>以查看现有 API 密钥。</li>
  <li>复制 API 密钥以在此命令中使用。</li>
  </ol></p></dd>
    
**示例**：

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

从 {{site.data.keyword.Bluemix_notm}} 帐户中除去 {{site.data.keyword.BluSoftlayer_notm}} 帐户凭证。除去凭证后，就不能再通过 {{site.data.keyword.Bluemix_notm}} 帐户来访问 {{site.data.keyword.BluSoftlayer_notm}} 产品服务组合。

<strong>命令选项</strong>：

   无

**示例**：

  ```
  bx cs credentials-unset
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
   <dd>（可选）要使用的 {{site.data.keyword.containershort_notm}} API 端点。示例：

    <ul>
    <li>美国南部：

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>英国南部：

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>欧洲中部：

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>亚太南部：

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>


### bx cs machine-types LOCATION
{: #cs_machine_types}

查看可用于工作程序节点的机器类型的列表。每种机器类型都包含集群中每个工作程序节点的虚拟 CPU 量、内存量和磁盘空间量。

<strong>命令选项</strong>：

   <dl>
   <dt><em>LOCATION</em></dt>
   <dd>（必需）输入要列出其中可用机器类型的位置。可用位置为：<ul><li>美国南部<ul><li>dal10 [达拉斯]</li><li>dal12 [达拉斯]</li></ul></li><li>英国南部<ul><li>lon02 [伦敦]</li><li>lon04 [伦敦]</li></ul></li><li>欧洲中部<ul><li>ams03 [阿姆斯特丹]</li><li>ra02 [法兰克福]</li></ul></li><li>亚太南部<ul><li>syd01 [悉尼]</li><li>syd04 [悉尼]</li></ul></li></ul></dd></dl>
   
**示例**：

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

查看 {{site.data.keyword.BluSoftlayer_notm}} 帐户中可用的子网的列表。

<strong>命令选项</strong>：

   无

**示例**：

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

列出可用于 {{site.data.keyword.BluSoftlayer_notm}} 帐户中位置的公共和专用 VLAN。要列出可用 VLAN，您必须具有付费帐户。

<strong>命令选项</strong>：

   <dl>
   <dt>LOCATION</dt>
   <dd>（必需）输入要列出其中专用和公共 VLAN 的位置。可用位置为：<ul><li>美国南部<ul><li>dal10 [达拉斯]</li><li>dal12 [达拉斯]</li></ul></li><li>英国南部<ul><li>lon02 [伦敦]</li><li>lon04 [伦敦]</li></ul></li><li>欧洲中部<ul><li>ams03 [阿姆斯特丹]</li><li>ra02 [法兰克福]</li></ul></li><li>亚太南部<ul><li>syd01 [悉尼]</li><li>syd04 [悉尼]</li></ul></li></ul></dd>
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
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>（可选）通知级别，例如 <code>Normal</code> 或 <code>Warning</code>。<code>Warning</code> 是缺省值。</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>（必需）Webhook 类型，如 slack。仅支持 slack。</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>（必需）Webhook 的 URL。</dd>
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
<dd>（必需）集群的名称或标识。</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>用于将工作程序节点添加到集群的 YAML 文件的路径。您可以使用 YAML 文件，而不使用此命令中提供的选项来定义其他工作程序节点。
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
<th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
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
<td>将 <code>&lt;public_vlan&gt;</code> 替换为要用于工作程序节点的公共 VLAN 的标识。要列出可用的 VLAN，请运行 <code>bx cs vlans &lt;location&gt;</code> 并查找以 <code>fcr</code>（前端路由器）开头的 VLAN 路由器。</td> 
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
<dd>（可选）工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>（必需）所选择的机器类型会影响部署到工作程序节点的容器可用的内存量和磁盘空间量。要列出可用的机器类型，请参阅 [bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types)。</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>（必需）整数，表示要在集群中创建的工作程序节点数。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>（必需）如果您有专用 VLAN 可在该位置中使用，那么必须指定该 VLAN。如果这是您在此位置中创建的第一个集群，请勿使用此标志。将为您创建专用 VLAN。<p><strong>注</strong>：使用 create 命令指定的公共和专用 VLAN 必须匹配。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公共 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。不要使用不匹配的公共和专用 VLAN 来创建集群。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>（必需）如果您有公共 VLAN 可在该位置中使用，那么必须指定该 VLAN。如果这是您在此位置中创建的第一个集群，请勿使用此标志。将为您创建公共 VLAN。<p><strong>注</strong>：使用 create 命令指定的公共和专用 VLAN 必须匹配。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公共 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。不要使用不匹配的公共和专用 VLAN 来创建集群。</p></dd>
</dl>

**示例**：

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  {{site.data.keyword.Bluemix_notm}} Dedicated 的示例：

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

查看工作程序节点的详细信息。

<strong>命令选项</strong>：

   <dl>
   <dt><em>WORKER_NODE_ID</em></dt>
   <dd>工作程序节点的标识。运行 <code>bx cs workers <em>CLUSTER</em></code> 可查看集群中工作程序节点的标识。</dd>
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
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code>-f</code></dt>
   <dd>（可选）使用此选项可强制重新启动工作程序节点，而不显示用户提示。</dd>

   <dt><code>--hard</code></dt>
   <dd>（可选）使用此选项可通过切断工作程序节点的电源来强制硬重新启动该工作程序节点。如果工作程序节点无响应或工作程序节点有一个 Docker 挂起，请使用此选项。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>（必需）一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。</dd>
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
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code>-f</code></dt>
   <dd>（可选）使用此选项可强制重新装入工作程序节点，而不显示用户提示。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>（必需）一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。</dd>
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
   <dd>（必需）集群的名称或标识。</dd>

   <dt><code>-f</code></dt>
   <dd>（可选）使用此选项可强制除去工作程序节点，而不显示用户提示。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>（必需）一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。</dd>
   </dl>

**示例**：

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

查看集群中工作程序节点的列表以及每个工作程序节点的状态。

<strong>命令选项</strong>：

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>（必需）列出了其中可用工作程序节点的集群的名称或标识。</dd>
   </dl>

**示例**：

  ```
  bx cs workers mycluster
  ```
  {: pre}

## 集群状态
{: #cs_cluster_states}

您可以通过运行 bx cs clusters 命令并找到**状态**字段，查看当前集群状态。集群状态提供了有关集群可用性和容量的信息以及可能已发生的潜在问题。
{:shortdesc}

|集群状态|原因|
|-------------|------|
|Deploying|Kubernetes 主节点尚未完全部署。无法访问集群。|
|Pending|Kubernetes 主节点已部署。正在供应工作程序节点，这些节点在集群中尚不可用。您可以访问集群，但无法将应用程序部署到集群。|
|Normal|集群中的所有工作程序节点都已启动并正在运行。您可以访问集群，并将应用程序部署到集群。|
|Warning|集群中至少有一个工作程序节点不可用，但其他工作程序节点可用，并且可以接管工作负载。<ol><li>列出集群中的工作程序节点，并记下显示 <strong>Warning</strong> 状态的工作程序节点的标识。<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>获取工作程序节点的详细信息。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>查看<strong>状态</strong>、<strong>阶段状态</strong>和<strong>详细信息</strong>字段，以找到导致工作程序节点停止运行的根本问题。</li><li>如果工作程序节点几乎达到内存或磁盘空间限制，请减少工作程序节点上的工作负载，或者向集群添加一个工作程序节点以帮助均衡工作负载。</li></ol>|
|Critical|无法访问 Kubernetes 主节点，或者集群中的所有工作程序节点都已停止运行。<ol><li>列出集群中的工作程序节点。<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>获取每个工作程序节点的详细信息。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>查看<strong>状态</strong>、<strong>阶段状态</strong>和<strong>详细信息</strong>字段，以找到导致工作程序节点停止运行的根本问题。</li><li>如果工作程序节点状态显示 <strong>Provision_failed</strong>，说明您可能没有必需的许可权来从 {{site.data.keyword.BluSoftlayer_notm}} 产品服务组合供应工作程序节点。要查找必需的许可权，请参阅[配置对 {{site.data.keyword.BluSoftlayer_notm}} 产品服务组合的访问权以创建标准 Kubernees 集群](cs_planning.html#cs_planning_unify_accounts)。</li><li>如果工作程序节点状态显示 <strong>Critical</strong>，工作程序节点阶段状态显示 <strong>Out of disk</strong>，说明工作程序节点的容量不足。您可以减少工作节点上的工作负载，或者向集群添加一个工作程序节点以帮助均衡工作负载。</li><li>如果工作程序节点状态显示 <strong>Critical</strong>，工作程序节点阶段状态显示 <strong>Unknown</strong>，说明 Kubernetes 主节点不可用。请通过开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/support/index.html#contacting-support)来联系 {{site.data.keyword.Bluemix_notm}} 支持。</li></ol>|
{: caption="表 3. 集群状态" caption-side="top"}
