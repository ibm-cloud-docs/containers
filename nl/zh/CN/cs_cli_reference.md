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





# {{site.data.keyword.containerlong_notm}} CLI 参考
{: #cs_cli_reference}

请参阅以下命令以在 {{site.data.keyword.containerlong}} 中创建和管理 Kubernetes 集群。
{:shortdesc}

要安装 CLI 插件，请参阅[安装 CLI](cs_cli_install.html#cs_cli_install_steps)。

在终端中，在 `ibmcloud` CLI 和插件更新可用时，会通知您。请确保保持 CLI 为最新，从而可使用所有可用命令和标志。

在查找 `ibmcloud cr` 命令吗？请参阅 [{{site.data.keyword.registryshort_notm}} CLI 参考](/docs/cli/plugins/registry/index.html)。在查找 `kubectl` 命令吗？请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/)。
{:tip}

## ibmcloud ks 命令
{: #cs_commands}

**提示：**要查看 {{site.data.keyword.containerlong_notm}} 插件的版本，请运行以下命令。

```
ibmcloud plugin list
```
{: pre}



<table summary="API 命令表">
<caption>API 命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>API 命令</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks api](#cs_api)</td>
    <td>[ibmcloud ks api-key-info](#cs_api_key_info)</td>
    <td>[ibmcloud ks api-key-reset](#cs_api_key_reset)</td>
    <td>[ibmcloud ks apiserver-config-get](#cs_apiserver_config_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks apiserver-config-set](#cs_apiserver_config_set)</td>
    <td>[ibmcloud ks apiserver-config-unset](#cs_apiserver_config_unset)</td>
    <td>[ibmcloud ks apiserver-refresh](#cs_apiserver_refresh)</td>
    <td></td>
 </tr>
</tbody>
</table>

<br>

<table summary="CLI 插件用法命令表">
<caption>CLI 插件用法命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>CLI 插件用法命令</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks help](#cs_help)</td>
    <td>[ibmcloud ks init](#cs_init)</td>
    <td>[ibmcloud ks messages](#cs_messages)</td>
    <td></td>
  </tr>
</tbody>
</table>

<br>

<table summary="“集群命令：管理”表">
<caption>集群命令：管理命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>集群命令：管理</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-config](#cs_cluster_config)</td>
    <td>[ibmcloud ks cluster-create](#cs_cluster_create)</td>
    <td>[ibmcloud ks cluster-feature-enable](#cs_cluster_feature_enable)</td>
    <td>[ibmcloud ks cluster-get](#cs_cluster_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks cluster-rm](#cs_cluster_rm)</td>
    <td>[ibmcloud ks cluster-update](#cs_cluster_update)</td>
    <td>[ibmcloud ks clusters](#cs_clusters)</td>
    <td>[ibmcloud ks kube-versions](#cs_kube_versions)</td>
  </tr>
</tbody>
</table>

<br>

<table summary="“集群命令：服务和集成”表">
<caption>集群命令：服务和集成命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>集群命令：服务和集成</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[ibmcloud ks cluster-service-unbind](#cs_cluster_service_unbind)</td>
    <td>[ibmcloud ks cluster-services](#cs_cluster_services)</td>
    <td>[ibmcloud ks va](#cs_va)</td>
  </tr>
    <td>[ibmcloud ks webhook-create](#cs_webhook_create)</td>
  <tr>
  </tr>
</tbody>
</table>

</br>

<table summary="“集群命令：子网”表">
<caption>集群命令：子网命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>集群命令：子网</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[ibmcloud ks cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[ibmcloud ks cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[ibmcloud ks cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks subnets](#cs_subnets)</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody>
</table>

</br>

<table summary="基础架构命令表">
<caption>集群命令：基础架构命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>基础架构命令</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks credentials-set](#cs_credentials_set)</td>
    <td>[ibmcloud ks credentials-unset](#cs_credentials_unset)</td>
    <td>[ibmcloud ks machine-types](#cs_machine_types)</td>
    <td>[ibmcloud ks vlans](#cs_vlans)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks vlan-spanning-get](#cs_vlan_spanning_get)</td>
    <td> </td>
    <td> </td>
    <td> </td>
  </tr>
</tbody>
</table>

</br>

<table summary="Ingress 应用程序负载均衡器 (ALB) 命令表">
<caption>Ingress 应用程序负载均衡器 (ALB) 命令</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Ingress 应用程序负载均衡器 (ALB) 命令</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks alb-cert-deploy](#cs_alb_cert_deploy)</td>
      <td>[ibmcloud ks alb-cert-get](#cs_alb_cert_get)</td>
      <td>[ibmcloud ks alb-cert-rm](#cs_alb_cert_rm)</td>
      <td>[ibmcloud ks alb-certs](#cs_alb_certs)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks alb-configure](#cs_alb_configure)</td>
      <td>[ibmcloud ks alb-get](#cs_alb_get)</td>
      <td>[ibmcloud ks alb-types](#cs_alb_types)</td>
      <td>[ibmcloud ks albs](#cs_albs)</td>
    </tr>
  </tbody>
</table>

</br>

<table summary="日志记录命令表">
<caption>日志记录命令</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>日志记录命令</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks logging-config-create](#cs_logging_create)</td>
      <td>[ibmcloud ks logging-config-get](#cs_logging_get)</td>
      <td>[ibmcloud ks logging-config-refresh](#cs_logging_refresh)</td>
      <td>[ibmcloud ks logging-config-rm](#cs_logging_rm)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-config-update](#cs_logging_update)</td>
      <td>[ibmcloud ks logging-filter-create](#cs_log_filter_create)</td>
      <td>[ibmcloud ks logging-filter-update](#cs_log_filter_update)</td>
      <td>[ibmcloud ks logging-filter-get](#cs_log_filter_view)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-filter-rm](#cs_log_filter_delete)</td>
      <td>[ibmcloud ks logging-autoupdate-enable](#cs_log_autoupdate_enable)</td>
      <td>[ibmcloud ks logging-autoupdate-disable](#cs_log_autoupdate_disable)</td>
      <td>[ibmcloud ks logging-autoupdate-get](#cs_log_autoupdate_get)</td>
    </tr>
  </tbody>
</table>

</br>

<table summary="区域命令表">
<caption>区域命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>区域命令</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks zones](#cs_datacenters)</td>
    <td>[ibmcloud ks region](#cs_region)</td>
    <td>[ibmcloud ks region-set](#cs_region-set)</td>
    <td>[ibmcloud ks regions](#cs_regions)</td>
  </tr>
</tbody>
</table>

</br>

<table summary="工作程序节点命令表">
<caption>工作程序节点命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>工作程序节点命令</th>
 </thead>
 <tbody>
    <tr>
      <td>不推荐：[ibmcloud ks worker-add](#cs_worker_add)</td>
      <td>[ibmcloud ks worker-get](#cs_worker_get)</td>
      <td>[ibmcloud ks worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud ks worker-reload](#cs_worker_reload)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud ks worker-update](#cs_worker_update)</td>
      <td>[ibmcloud ks workers](#cs_workers)</td>
      <td>[ibmcloud ks worker-get](#cs_worker_get)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud ks worker-reload](#cs_worker_reload)</td>
      <td>[ibmcloud ks worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud ks workers](#cs_workers)</td>
    </tr>
  </tbody>
</table>

<table summary="工作程序池命令表">
<caption>工作程序池命令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>工作程序池命令</th>
 </thead>
 <tbody>
    <tr>
      <td>[ibmcloud ks worker-pool-create](#cs_worker_pool_create)</td>
      <td>[ibmcloud ks worker-pool-get](#cs_worker_pool_get)</td>
      <td>[ibmcloud ks worker-pool-rebalance](#cs_rebalance)</td>
      <td>[ibmcloud ks worker-pool-resize](#cs_worker_pool_resize)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-pool-rm](#cs_worker_pool_rm)</td>
      <td>[ibmcloud ks worker-pools](#cs_worker_pools)</td>
      <td>[ibmcloud ks zone-add](#cs_zone_add)</td>
      <td>[ibmcloud ks zone-network-set](#cs_zone_network_set)</td>
    </tr>
    <tr>
     <td>[ibmcloud ks zone-rm](#cs_zone_rm)</td>
     <td></td>
    </tr>
  </tbody>
</table>

## API 命令
{: #api_commands}

### ibmcloud ks api --endpoint ENDPOINT [--insecure][--skip-ssl-validation] [--api-version VALUE][-s]
{: #cs_api}

将 {{site.data.keyword.containerlong_notm}} 的 API 端点设定为目标。如果未指定端点，那么可以查看有关设定为目标的当前端点的信息。

要切换区域？请改为使用 `ibmcloud ks region-set` [命令](#cs_region-set)。
{: tip}

<strong>命令选项</strong>：

   <dl>
   <dt><code>--endpoint <em>ENDPOINT</em></code></dt>
   <dd>{{site.data.keyword.containerlong_notm}} API 端点。请注意，此端点不同于 {{site.data.keyword.Bluemix_notm}} 端点。需要此值来设置 API 端点。接受的值如下：<ul>
   <li>全球端点：https://containers.bluemix.net</li>
   <li>亚太地区北部端点：https://ap-north.containers.bluemix.net</li>
   <li>亚太地区南部端点：https://ap-south.containers.bluemix.net</li>
   <li>欧洲中部端点：https://eu-central.containers.bluemix.net</li>
   <li>英国南部端点：https://uk-south.containers.bluemix.net</li>
   <li>美国东部端点：https://us-east.containers.bluemix.net</li>
   <li>美国南部端点：https://us-south.containers.bluemix.net</li></ul>
   </dd>

   <dt><code>--insecure</code></dt>
   <dd>允许不安全的 HTTP 连接。此标志是可选的。</dd>

   <dt><code>--skip-ssl-validation</code></dt>
   <dd>允许不安全的 SSL 证书。此标志是可选的。</dd>

   <dt><code>--api-version VALUE</code></dt>
   <dd>指定要使用的服务的 API 版本。此值是可选的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：查看有关设定为目标的当前 API 端点的信息。
```
ibmcloud ks api
```
{: pre}

```
API Endpoint:          https://containers.bluemix.net   
API Version:           v1   
Skip SSL Validation:   false   
Region:                us-south
```
{: screen}


### ibmcloud ks api-key-info --cluster CLUSTER [--json][-s]
{: #cs_api_key_info}

查看 {{site.data.keyword.containerlong_notm}} 区域中 IAM API 密钥所有者的姓名和电子邮件地址。

执行需要 {{site.data.keyword.containerlong_notm}} 管理员访问策略的第一个操作时，会自动针对区域设置 Identity and Access Management (IAM) API 密钥。例如，某个管理用户在 `us-south` 区域中创建了第一个集群。通过执行此操作，此用户的 IAM API 密钥将存储在此区域的帐户中。API 密钥用于订购 IBM Cloud Infrastructure (SoftLayer) 中的资源，例如新的工作程序节点或 VLAN。

其他用户在此区域中执行需要与 IBM Cloud Infrastructure (SoftLayer) 产品服务组合进行交互的操作（例如，创建新集群或重新装入工作程序节点）时，将使用存储的 API 密钥来确定是否存在执行该操作的足够许可权。要确保可以成功执行集群中与基础架构相关的操作，请为 {{site.data.keyword.containerlong_notm}} 管理用户分配**超级用户**基础架构访问策略。有关更多信息，请参阅[管理用户访问权](cs_users.html#infra_access)。

如果发现需要更新为区域存储的 API 密钥，那么可以通过运行 [ibmcloud ks api-key-reset](#cs_api_key_reset) 命令来执行此操作。此命令需要 {{site.data.keyword.containerlong_notm}} 管理员访问策略，并在帐户中存储执行此命令的用户的 API 密钥。

**提示：**如果使用 [ibmcloud ks credentials-set](#cs_credentials_set) 命令手动设置了 IBM Cloud Infrastructure (SoftLayer) 凭证，那么可能不会使用在此命令中返回的 API 密钥。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks api-key-info --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks api-key-reset [-s]
{: #cs_api_key_reset}

替换 {{site.data.keyword.containerlong_notm}} 区域中的当前 IAM API 密钥。

此命令需要 {{site.data.keyword.containerlong_notm}} 管理员访问策略，并在帐户中存储执行此命令的用户的 API 密钥。要从 IBM Cloud Infrastructure (SoftLayer) 产品服务组合订购基础架构，需要 IAM API 密钥。存储后，该 API 密钥会用于区域中需要基础架构许可权（与执行此命令的用户无关）的每个操作。有关 IAM API 密钥的工作方式的更多信息，请参阅 [`ibmcloud ks api-key-info` 命令](#cs_api_key_info)。

**重要信息**：使用此命令之前，请确保执行此命令的用户具有必需的 [{{site.data.keyword.containerlong_notm}} 和 IBM Cloud Infrastructure (SoftLayer) 许可权](cs_users.html#users)。

<strong>命令选项</strong>：

   <dl>
   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>


**示例**：

  ```
  ibmcloud ks api-key-reset
  ```
  {: pre}


### ibmcloud ks apiserver-config-get
{: #cs_apiserver_config_get}

获取有关集群的 Kubernetes API 服务器配置选项的信息。对于要获取其信息的配置选项，此命令必须与下列其中一个子命令组合在一起。

#### ibmcloud ks apiserver-config-get audit-webhook --cluster CLUSTER
{: #cs_apiserver_api_webhook_get}

查看要向其发送 API 服务器审计日志的远程日志记录服务的 URL。URL 是在您为 API 服务器配置创建 Webhook 后端时指定的。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks apiserver-config-get audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-config-set
{: #cs_apiserver_config_set}

为集群的 Kubernetes API 服务器配置设置选项。对于要设置的配置选项，此命令必须与下列其中一个子命令组合在一起。

#### ibmcloud ks apiserver-config-set audit-webhook --cluster CLUSTER [--remoteServer SERVER_URL_OR_IP][--caCert CA_CERT_PATH] [--clientCert CLIENT_CERT_PATH][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_api_webhook_set}

设置 API 服务器配置的 Webhook 后端。Webhook 后端将 API 服务器审计日志转发到远程服务器。根据您在此命令标志中提供的信息来创建 Webhook 配置。如果未在标志中提供任何信息，那么将使用缺省的 Webhook 配置。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--remoteServer <em>SERVER_URL</em></code></dt>
   <dd>要向其发送审计日志的远程日志记录服务的 URL 或 IP 地址。如果提供不安全的服务器 URL，那么将忽略任何证书。此值是可选的。</dd>

   <dt><code>--caCert <em>CA_CERT_PATH</em></code></dt>
   <dd>用于验证远程日志记录服务的 CA 证书的文件路径。此值是可选的。</dd>

   <dt><code>--clientCert <em>CLIENT_CERT_PATH</em></code></dt>
   <dd>用于针对远程日志记录服务进行认证的客户机证书的文件路径。此值是可选的。</dd>

   <dt><code>--clientKey <em> CLIENT_KEY_PATH</em></code></dt>
   <dd>用于连接到远程日志记录服务的相应客户机密钥的文件路径。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks apiserver-config-set audit-webhook --cluster my_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}


### ibmcloud ks apiserver-config-unset
{: #cs_apiserver_config_unset}

禁用集群的 Kubernetes API 服务器配置的选项。对于要取消设置的配置选项，此命令必须与下列其中一个子命令组合在一起。

#### ibmcloud ks apiserver-config-unset audit-webhook --cluster CLUSTER
{: #cs_apiserver_api_webhook_unset}

禁用集群 API 服务器的 Webhook 后端配置。禁用 Webhook 后端会停止将 API 服务器审计日志转发到远程服务器。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks apiserver-config-unset audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-refresh --cluster CLUSTER [-s]
{: #cs_apiserver_refresh}

在集群中重新启动 Kubernetes 主节点以将更改应用于 API 服务器配置。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks apiserver-refresh --cluster my_cluster
  ```
  {: pre}


<br />


## CLI 插件用法命令
{: #cli_plug-in_commands}

### ibmcloud ks help
{: #cs_help}

查看支持的命令和参数的列表。

<strong>命令选项</strong>：

   无

**示例**：

  ```
  ibmcloud ks help
  ```
  {: pre}


### ibmcloud ks init [--host HOST][--insecure] [-p][-u] [-s]
{: #cs_init}

初始化 {{site.data.keyword.containerlong_notm}} 插件或指定要在其中创建或访问 Kubernetes 集群的区域。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>要使用的 {{site.data.keyword.containerlong_notm}} API 端点。此值是可选的。[查看可用的 API 端点值。](cs_regions.html#container_regions)</dd>

   <dt><code>--insecure</code></dt>
   <dd>允许不安全的 HTTP 连接。</dd>

   <dt><code>-p</code></dt>
   <dd>您的 IBM Cloud 密码。</dd>

   <dt><code>-u</code></dt>
   <dd>您的 IBM Cloud 用户名。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：


```
ibmcloud ks init --host https://uk-south.containers.bluemix.net
```
{: pre}


### ibmcloud ks messages
{: #cs_messages}

查看 IBM 标识用户的当前消息。

**示例**：

```
ibmcloud ks messages
```
{: pre}


<br />


## 集群命令：管理
{: #cluster_mgmt_commands}


### ibmcloud ks cluster-config --cluster CLUSTER [--admin][--export] [-s][--yaml]
{: #cs_cluster_config}

登录后，下载 Kubernetes 配置数据和证书，以连接到集群并运行 `kubectl` 命令。这些文件会下载到 `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**命令选项**：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--admin</code></dt>
   <dd>下载超级用户角色的 TLS 证书和许可权文件。您可以使用证书来自动执行集群中的任务，而无需重新认证。这些文件会下载到 `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`。此值是可选的。</dd>

   <dt><code>--export</code></dt>
   <dd>下载 Kubernetes 配置数据和证书，而不包含导出命令以外的任何消息。由于未显示任何消息，因此您可以在创建自动化脚本时使用此标志。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>

  <dt><code>--yaml</code></dt>
  <dd>以 YAML 格式打印命令输出。此值是可选的。</dd>

   </dl>

**示例**：

```
ibmcloud ks cluster-config --cluster my_cluster
```
{: pre}


### ibmcloud ks cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --zone ZONE --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--workers WORKER][--disable-disk-encrypt] [--trusted][-s]
{: #cs_cluster_create}

在组织中创建集群。对于免费集群，请指定集群名称；其他所有项都设置为缺省值。免费集群在 30 天后会被自动删除。一次只能有一个免费集群。要利用 Kubernetes 的全部功能，请创建标准集群。

<strong>命令选项</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>用于创建标准集群的 YAML 文件的路径。您可以使用 YAML 文件，而不使用此命令中提供的选项来定义集群的特征。
此值对于标准集群是可选的，且不可用于免费集群。

<p><strong>注</strong>：如果在命令中提供的选项与 YAML 文件中的参数相同，那么命令中的值将优先于 YAML 中的值。例如，您在 YAML 文件中定义了位置，并在命令中使用了 <code>--zone</code> 选项，那么在该命令选项中输入的值会覆盖 YAML 文件中的相应值。

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
zone: <em>&lt;zone&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
diskEncryption: <em>false</em>
trusted: <em>true</em>
</code></pre>


<table>
    <caption>了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>将 <code><em>&lt;cluster_name&gt;</em></code> 替换为集群的名称。名称必须以字母开头，可以包含字母、数字和连字符 (-)，并且不能超过 35 个字符。集群名称和部署集群的区域构成了 Ingress 子域的标准域名。为了确保 Ingress 子域在区域内是唯一的，可能会截断 Ingress 域名中的集群名称并附加随机值。
</td>
    </tr>
    <tr>
    <td><code><em>zone</em></code></td>
    <td>将 <code><em>&lt;zone&gt;</em></code> 替换为要在其中创建集群的专区。可用的专区取决于您登录到的区域。要列出可用专区，请运行 <code>ibmcloud ks zones</code>。</td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>缺省情况下，将在与集群关联的 VLAN 上创建公用和专用可移植子网。将 <code><em>&lt;no-subnet&gt;</em></code> 替换为 <code><em>true</em></code> 可避免为集群创建子网。您可以日后为集群[创建](#cs_cluster_subnet_create)或[添加](#cs_cluster_subnet_add)子网。</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>将 <code><em>&lt;machine_type&gt;</em></code> 替换为要将工作程序节点部署到的机器类型。可以将工作程序节点作为虚拟机部署在共享或专用硬件上，也可以作为物理机器部署在裸机上。可用的物理和虚拟机类型随集群的部署专区而变化。有关更多信息，请参阅 `ibmcloud ks machine-type` [命令](cs_cli_reference.html#cs_machine_types)的文档。</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>将 <code><em>&lt;private_VLAN&gt;</em></code> 替换为要用于工作程序节点的专用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> 并查找以 <code>bcr</code>（后端路由器）开头的 VLAN 路由器。</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>将 <code><em>&lt;public_VLAN&gt;</em></code> 替换为要用于工作程序节点的公用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> 并查找以 <code>fcr</code>（前端路由器）开头的 VLAN 路由器。</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>对于虚拟机类型：工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 <code>shared</code>。</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>将 <code><em>&lt;number_workers&gt;</em></code> 替换为要部署的工作程序节点数。</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>集群主节点的 Kubernetes 版本。此值是可选的。未指定版本时，会使用受支持 Kubernetes 版本的缺省值来创建集群。要查看可用版本，请运行 <code>ibmcloud ks kube-versions</code>。
</td></tr>
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>工作程序节点缺省情况下具有磁盘加密功能：[了解更多](cs_secure.html#encrypted_disk)。要禁用加密，请包括此选项并将值设置为 <code>false</code>。</td></tr>
      <tr>
      <td><code>trusted: <em>true</em></code></td>
      <td>**仅限裸机**：启用[可信计算](cs_secure.html#trusted_compute)以验证裸机工作程序节点是否被篡改。如果在创建集群期间未启用信任，但希望日后启用，那么可以使用 `ibmcloud ks feature-enable` [命令](cs_cli_reference.html#cs_cluster_feature_enable)。启用信任后，日后无法将其禁用。</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。此值对于标准集群是可选的，且不可用于免费集群。</dd>

<dt><code>--zone <em>ZONE</em></code></dt>
<dd>要在其中创建集群的专区。可用的位置取决于您登录到的 {{site.data.keyword.Bluemix_notm}} 区域。请选择实际离您最近的区域，以获得最佳性能。
此值对于标准集群是必需的，对于免费集群是可选的。

<p>请查看[可用专区](cs_regions.html#zones)。</p>

<p><strong>注</strong>：选择您所在国家或地区以外的专区时，请记住，您可能需要法律授权才能将数据实际存储在国外。</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>选择机器类型。可以将工作程序节点作为虚拟机部署在共享或专用硬件上，也可以作为物理机器部署在裸机上。可用的物理和虚拟机类型随集群的部署专区而变化。有关更多信息，请参阅 `ibmcloud ks machine-types` [命令](cs_cli_reference.html#cs_machine_types)的文档。此值对于标准集群是必需的，且不可用于免费集群。</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>集群的名称。此值是必需的。名称必须以字母开头，可以包含字母、数字和连字符 (-)，并且不能超过 35 个字符。集群名称和部署集群的区域构成了 Ingress 子域的标准域名。为了确保 Ingress 子域在区域内是唯一的，可能会截断 Ingress 域名中的集群名称并附加随机值。
</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>集群主节点的 Kubernetes 版本。此值是可选的。未指定版本时，会使用受支持 Kubernetes 版本的缺省值来创建集群。要查看可用版本，请运行 <code>ibmcloud ks kube-versions</code>。
</dd>

<dt><code>--no-subnet</code></dt>
<dd>缺省情况下，将在与集群关联的 VLAN 上创建公用和专用可移植子网。包含 <code>--no-subnets</code> 标志可避免为集群创建子网。您可以日后为集群[创建](#cs_cluster_subnet_create)或[添加](#cs_cluster_subnet_add)子网。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>此参数不可用于免费集群。</li>
<li>如果此标准集群是您在此专区中创建的第一个标准集群，请勿包含此标志。创建集群时，将为您创建专用 VLAN。</li>
<li>如果之前在此专区中已创建标准集群，或者之前在 IBM Cloud Infrastructure (SoftLayer) 中已创建专用 VLAN，那么必须指定该专用 VLAN。

<p><strong>注：</strong>专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。创建集群并指定公用和专用 VLAN 时，在这些前缀之后的数字和字母组合必须匹配。</p></li>
</ul>

<p>要了解您是否已具有用于特定专区的专用 VLAN，或要查找现有专用 VLAN 的名称，请运行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>此参数不可用于免费集群。</li>
<li>如果此标准集群是您在此专区中创建的第一个标准集群，请勿使用此标志。创建集群时，将为您创建公用 VLAN。</li>
<li>如果之前在此专区中已创建标准集群，或者之前在 IBM Cloud Infrastructure (SoftLayer) 中已创建公用 VLAN，请指定该公用 VLAN。如果要将工作程序节点仅连接到专用 VLAN，请不要指定此选项。

<p><strong>注：</strong>专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。创建集群并指定公用和专用 VLAN 时，在这些前缀之后的数字和字母组合必须匹配。</p></li>
</ul>

<p>要了解您是否已具有用于特定专区的公用 VLAN，或要查找现有公用 VLAN 的名称，请运行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>。</p></dd>

<dt><code>--private-only </code></dt>
  <dd>使用此选项可阻止创建公用 VLAN。仅当指定 `--private-vlan` 标志并且不包含 `--public-vlan` 标志时，此项才是必需的。**注**：如果需要仅专用集群，那么必须配置网关设备进行网络连接。有关更多信息，请参阅[为仅专用 VLAN 设置规划专用外部联网](cs_network_planning.html#private_vlan)。</dd>

<dt><code>--workers WORKER</code></dt>
<dd>要在集群中部署的工作程序节点数。如果未指定此选项，将创建具有 1 个工作程序节点的集群。此值对于标准集群是可选的，且不可用于免费集群。

<p><strong>注</strong>：为每个工作程序节点分配了唯一的工作程序节点标识和域名，在创建集群后，不得手动更改该标识和域名。更改标识或域名会阻止 Kubernetes 主节点管理集群。</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>工作程序节点缺省情况下具有磁盘加密功能：[了解更多](cs_secure.html#encrypted_disk)。要禁用加密，请包括此选项。</dd>

<dt><code>--trusted</code></dt>
<dd><p>**仅限裸机**：启用[可信计算](cs_secure.html#trusted_compute)以验证裸机工作程序节点是否被篡改。如果在创建集群期间未启用信任，但希望日后启用，那么可以使用 `ibmcloud ks feature-enable` [命令](cs_cli_reference.html#cs_cluster_feature_enable)。启用信任后，日后无法将其禁用。</p>
<p>要检查裸机机器类型是否支持信任，请检查 `ibmcloud ks machine-types <zone>` [命令](#cs_machine_types)输出中的 `Trustable` 字段。要验证集群是否已启用信任，请查看 `ibmcloud ks cluster-get` [命令](#cs_cluster_get)输出中的 **Trust ready** 字段。要验证裸机工作程序节点是否已启用信任，请查看 `ibmcloud ks worker-get` [ 命令](#cs_worker_get)输出中的 **Trust** 字段。</p></dd>

<dt><code>-s</code></dt>
<dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例**：



  **创建免费集群**：仅指定集群名称；其他所有项都设置为缺省值。免费集群在 30 天后会被自动删除。一次只能有一个免费集群。要利用 Kubernetes 的全部功能，请创建标准集群。

  ```
  ibmcloud ks cluster-create --name my_cluster
  ```
  {: pre}

  **创建第一个标准集群**：在专区中创建的第一个标准集群还会创建专用 VLAN。因此，不要包含 `--public-vlan` 标志。
  {: #example_cluster_create}

  ```
  ibmcloud ks cluster-create --zone dal10 --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **创建后续标准集群**：如果在此专区中已经创建标准集群，或者之前在 IBM Cloud Infrastructure (SoftLayer) 中已创建公用 VLAN，请使用 `--public-vlan` 标志指定该公用 VLAN。要了解您是否已具有用于特定专区的公用 VLAN，或要查找现有公用 VLAN 的名称，请运行 `ibmcloud ks vlans <zone>`.

  ```
  ibmcloud ks cluster-create --zone dal10 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **在 {{site.data.keyword.Bluemix_dedicated_notm}} 环境中创建集群**：

  ```
  ibmcloud ks cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}

### ibmcloud ks cluster-feature-enable [-f] --cluster CLUSTER [--trusted][-s]
{: #cs_cluster_feature_enable}

在现有集群上启用功能。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制执行 <code>--trusted</code> 选项，而不显示用户提示。此值是可选的。</dd>

   <dt><code><em>--trusted</em></code></dt>
   <dd><p>包含此标志可对集群中所有支持的裸机工作程序节点启用[可信计算](cs_secure.html#trusted_compute)。启用信任后，日后无法对集群禁用信任。</p>
   <p>要检查裸机机器类型是否支持信任，请检查 `ibmcloud ks machine-types <zone>` [命令](#cs_machine_types)输出中的 **Trustable** 字段。要验证集群是否已启用信任，请查看 `ibmcloud ks cluster-get` [命令](#cs_cluster_get)输出中的 **Trust ready** 字段。要验证裸机工作程序节点是否已启用信任，请查看 `ibmcloud ks worker-get` [ 命令](#cs_worker_get)输出中的 **Trust** 字段。</p></dd>

  <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例命令**：

  ```
  ibmcloud ks cluster-feature-enable --cluster my_cluster --trusted=true
  ```
  {: pre}

### ibmcloud ks cluster-get --cluster CLUSTER [--json][--showResources] [-s]
{: #cs_cluster_get}

查看有关组织中集群的信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>显示更多集群资源，例如附加组件、VLAN、子网和存储器。</dd>


  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>



**示例命令**：

  ```
  ibmcloud ks cluster-get --cluster my_cluster --showResources
  ```
  {: pre}

**示例输出**：

  ```
  Name:        my_cluster
  ID:          abc1234567
  State:       normal
  Trust ready: false
  Created:     2018-01-01T17:19:28+0000
  Zone:        dal10
  Master URL:  https://169.xx.xxx.xxx:xxxxx
  Master Location: Dallas
  Ingress subdomain: my_cluster.us-south.containers.appdomain.cloud
  Ingress secret:    my_cluster
  Workers:      3
  Worker Zones: dal10
  Version:      1.11.2
  Owner Email:  name@example.com
  Monitoring dashboard: https://metrics.ng.bluemix.net/app/#/grafana4/dashboard/db/link

  Addons
  Name                   Enabled
  customer-storage-pod   true
  basic-ingress-v2       true
  storage-watcher-pod    true

  Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false

  ```
  {: screen}

### ibmcloud ks cluster-rm --cluster CLUSTER [--force-delete-storage][-f] [-s]
{: #cs_cluster_rm}

从组织中除去集群。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--force-delete-storage</code></dt>
   <dd>删除集群以及集群使用的任何持久性存储器。**注意**：如果包含此标志，那么无法恢复存储在集群或其关联存储实例中的数据。此值是可选的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制除去集群，而不显示用户提示。此值是可选的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks cluster-rm --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks cluster-update [-f] --cluster CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update] [-f][-s]
{: #cs_cluster_update}

将 Kubernetes 主节点更新到缺省 API 版本。在更新期间，您无法访问或更改集群。用户已部署的工作程序节点、应用程序和资源不会被修改，并且将继续运行。

您可能需要更改 YAML 文件以供未来部署。请查看此[发行说明](cs_versions.html)以了解详细信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>集群的 Kubernetes 版本。如果未指定版本，那么 Kubernetes 主节点将更新到缺省 API 版本。要查看可用版本，请运行 [ibmcloud ks kube-versions](#cs_kube_versions)。
此值是可选的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制更新主节点，而不显示用户提示。此值是可选的。</dd>

   <dt><code>--force-update</code></dt>
   <dd>即便更改是跨 2 个以上的次版本，也仍尝试更新。此值是可选的。</dd>

   <dt><code>-f</code></dt>
   <dd>强制此命令运行，而不显示用户提示。此值是可选的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks cluster-update --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks clusters [--json][-s]
{: #cs_clusters}

查看组织中集群的列表。

<strong>命令选项</strong>：

  <dl>
  <dt><code>--json</code></dt>
  <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

**示例**：

  ```
  ibmcloud ks clusters
  ```
  {: pre}


### ibmcloud ks kube-versions [--json][-s]
{: #cs_kube_versions}

查看 {{site.data.keyword.containerlong_notm}} 中支持的 Kubernetes 版本列表。将[集群主节点](#cs_cluster_update)和[工作程序节点](cs_cli_reference.html#cs_worker_update)更新到缺省版本以获取最新的稳定功能。

**命令选项**：

  <dl>
  <dt><code>--json</code></dt>
  <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

**示例**：

  ```
  ibmcloud ks kube-versions
  ```
  {: pre}

<br />



## 集群命令：服务和集成
{: #cluster_services_commands}


### ibmcloud ks cluster-service-bind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_NAME [-s]
{: #cs_cluster_service_bind}

向集群添加 {{site.data.keyword.Bluemix_notm}} 服务。要查看 {{site.data.keyword.Bluemix_notm}}“目录”中的可用 {{site.data.keyword.Bluemix_notm}} 服务，请运行 `ibmcloud service offerings`。**注**：只能添加支持服务密钥的 {{site.data.keyword.Bluemix_notm}} 服务。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名称空间的名称。此值是必需的。</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_NAME</em></code></dt>
   <dd>要绑定的 {{site.data.keyword.Bluemix_notm}} 服务实例的名称。要查找服务实例的名称，请运行 <code>ibmcloud service list</code>。如果多个实例在帐户中具有相同名称，请使用服务实例标识来代替名称。要查找标识，请运行 <code>ibmcloud service show <service instance name> --guid</code>。其中一个值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks cluster-service-bind --cluster my_cluster --namespace my_namespace --service my_service_instance
  ```
  {: pre}


### ibmcloud ks cluster-service-unbind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_GUID [-s]
{: #cs_cluster_service_unbind}

从集群中除去 {{site.data.keyword.Bluemix_notm}} 服务。

**注：**除去 {{site.data.keyword.Bluemix_notm}} 服务时，会从集群中除去服务凭证。如果 pod 仍在使用该服务，那么除去操作会因为找不到服务凭证而失败。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名称空间的名称。此值是必需的。</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>要除去的 {{site.data.keyword.Bluemix_notm}} 服务实例的标识。要查找服务实例的标识，请运行 `ibmcloud ks cluster-services <cluster_name_or_ID>`。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks cluster-service-unbind --cluster my_cluster --namespace my_namespace --service 8567221
  ```
  {: pre}


### ibmcloud ks cluster-services --cluster CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces] [--json][-s]
{: #cs_cluster_services}

列出绑定到集群中一个或全部 Kubernetes 名称空间的服务。如果未指定任何选项，那么将显示缺省名称空间的服务。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>包含绑定到集群中特定名称空间的服务。此值是可选的。</dd>

   <dt><code>--all-namespaces</code></dt>
   <dd>包含绑定到集群中所有名称空间的服务。此值是可选的。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks cluster-services --cluster my_cluster --namespace my_namespace
  ```
  {: pre}

### ibmcloud ks va --container CONTAINER_ID [--extended][--vulnerabilities] [--configuration-issues][--json]
{: #cs_va}

[安装容器扫描程序](/docs/services/va/va_index.html#va_install_container_scanner)后，请查看集群中容器的详细漏洞评估报告。

**命令选项**：

<dl>
<dt><code>--container CONTAINER_ID</code></dt>
<dd><p>容器的标识。此值是必需的。</p>
<p>要查找容器的标识，请执行以下操作：<ol><li>[设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。</li><li>通过运行 `kubectl get pods` 列出 pod。</li><li>在 `kubectl describe pod <pod_name>` 命令检索到的工作程序节点的标识。
      例如，`Container ID: containerd://1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`。</li><li>在将容器标识用于 `ibmcloud ks va` 命令之前，请从标识中除去 `containerd://` 前缀。例如，`1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`。</li></ol></p></dd>

<dt><code>--extended</code></dt>
<dd><p>扩展命令输出，以显示有漏洞的包的更多修订信息。此值是可选的。</p>
<p>缺省情况下，扫描结果会显示标识、策略状态、受影响的包以及解决方法。通过 `--extended` 标志，会添加摘要、供应商安全声明和官方声明链接等信息。</p></dd>

<dt><code>--vulnerabilities</code></dt>
<dd>将命令输出限制为仅显示包漏洞。此值是可选的。此标志不能与 `--configuration-flag` 标志一起使用。</dd>

<dt><code>--configuration-issues</code></dt>
<dd>将命令输出限制为仅显示配置问题。此值是可选的。此标志不能与 `--vulnerabilities` 标志一起使用。</dd>

<dt><code>--json</code></dt>
<dd>以 JSON 格式打印命令输出。此值是可选的。</dd>
</dl>

**示例**：

```
ibmcloud ks va --container 1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15 --extended --vulnerabilities --json
```
{: pre}


### ibmcloud ks webhook-create --cluster CLUSTER --level LEVEL --type slack --url URL  [-s]
{: #cs_webhook_create}

注册 Webhook。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>通知级别，例如 <code>Normal</code> 或 <code>Warning</code>。<code>Warning</code> 是缺省值。此值是可选的。</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Webhook 类型。当前支持 slack。此值是必需的。</dd>

   <dt><code>--url <em>URL</em></code></dt>
   <dd>Webhook 的 URL。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks webhook-create --cluster my_cluster --level Normal --type slack --url http://github.com/mywebhook
  ```
  {: pre}


<br />


## 集群命令：子网
{: #cluster_subnets_commands}

### ibmcloud ks cluster-subnet-add --cluster CLUSTER --subnet-id SUBNET [-s]
{: #cs_cluster_subnet_add}

可以向 Kubernetes 集群添加 IBM Cloud infrastructure (SoftLayer) 帐户中的现有可移植公用或专用子网，或者复用已删除集群中的子网，而不使用自动供应的子网。

**注：**
* 可移植公共 IP 地址按月收费。如果在供应集群后除去可移植公共 IP 地址，那么即使只使用了很短的时间，您也仍然必须支付一个月的费用。
* 使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containerlong_notm}} 外部的其他用途。
* 要启用同一 VLAN 的不同子网上的工作程序之间的通信，必须[启用同一 VLAN 上子网之间的路由](cs_subnets.html#subnet-routing)。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--subnet-id <em>SUBNET</em></code></dt>
   <dd>这是子网的标识。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks cluster-subnet-add --cluster my_cluster --subnet-id 1643389
  ```
  {: pre}


### ibmcloud ks cluster-subnet-create --cluster CLUSTER --size SIZE --vlan VLAN_ID [-s]
{: #cs_cluster_subnet_create}

在 IBM Cloud Infrastructure (SoftLayer) 帐户中创建子网，并使其可供 {{site.data.keyword.containerlong_notm}} 中的指定集群使用。

**注：**
* 使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containerlong_notm}} 外部的其他用途。
* 如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。要列出集群，请使用 `ibmcloud ks clusters` [命令](#cs_clusters)。</dd>

   <dt><code>--size <em>SIZE</em></code></dt>
   <dd>子网 IP 地址数。此值是必需的。可能的值为 8、16、32 或 64。</dd>

   <dd>要在其中创建子网的 VLAN。此值是必需的。要列出可用的 VLAN，请使用 `ibmcloud ks vlans <zone>` [命令](#cs_vlans)。子网会在 VLAN 所在的区域中进行供应。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks cluster-subnet-create --cluster my_cluster --size 8 --vlan 1764905
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-add --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

将您自己的专用子网置于 {{site.data.keyword.containerlong_notm}} 集群中。

此专用子网不是 IBM Cloud Infrastructure (SoftLayer) 提供的子网。因此，您必须为子网配置任何入站和出站网络流量路由。要添加 IBM Cloud Infrastructure (SoftLayer) 子网，请使用 `ibmcloud ks cluster-subnet-add` [命令](#cs_cluster_subnet_add)。

**注**：
* 将专用用户子网添加到集群时，此子网的 IP 地址将用于集群中的专用负载均衡器。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containerlong_notm}} 外部的其他用途。
* 如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>子网无类域间路由 (CIDR)。此值是必需的，且不得与 IBM Cloud Infrastructure (SoftLayer) 使用的任何子网相冲突。

   支持的前缀范围从 `/30`（1 个 IP 地址）到 `/24`（253 个 IP 地址）。如果将 CIDR 设置为一个前缀长度，而稍后需要对其进行更改，请先添加新的 CIDR，然后[除去旧 CIDR](#cs_cluster_user_subnet_rm)。</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>专用 VLAN 的标识。此值是必需的。它必须与集群中一个或多个工作程序节点的专用 VLAN 标识相匹配。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks cluster-user-subnet-add --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-rm --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

从指定集群除去您自己的专用子网。

**注：**除去子网后，部署到您自己专用子网的 IP 地址的任何服务都将保持活动状态。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>子网无类域间路由 (CIDR)。此值是必需的，并且必须与 `ibmcloud ks cluster-user-subnet-add` [命令](#cs_cluster_user_subnet_add)设置的 CIDR 匹配。</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>专用 VLAN 的标识。此值是必需的，并且必须与 `ibmcloud ks cluster-user-subnet-add` [命令](#cs_cluster_user_subnet_add)设置的 VLAN 标识匹配。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks cluster-user-subnet-rm --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}

### ibmcloud ks subnets [--json][-s]
{: #cs_subnets}

查看 IBM Cloud Infrastructure (SoftLayer) 帐户中可用的子网列表。

<strong>命令选项</strong>：

  <dl>
  <dt><code>--json</code></dt>
  <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

**示例**：

  ```
  ibmcloud ks subnets
  ```
  {: pre}


<br />


## Ingress 应用程序负载均衡器 (ALB) 命令
{: #alb_commands}

### ibmcloud ks alb-cert-deploy [--update] --cluster CLUSTER --secret-name SECRET_NAME --cert-crn CERTIFICATE_CRN [--update][-s]
{: #cs_alb_cert_deploy}

将 {{site.data.keyword.cloudcerts_long_notm}} 实例中的证书部署或更新到集群中的 ALB。

**注：**
* 只有具有管理员访问权角色的用户才能执行此命令。
* 只能更新从同一 {{site.data.keyword.cloudcerts_long_notm}} 实例导入的证书。

<strong>命令选项</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--update</code></dt>
   <dd>更新集群中 ALB 私钥的证书。此值是可选的。</dd>

   <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
   <dd>ALB 私钥的名称。此值是必需的。</dd>

   <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
   <dd>证书 CRN。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

部署 ALB 私钥的示例：

   ```
   ibmcloud ks alb-cert-deploy --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
   ```
   {: pre}

更新现有 ALB 私钥的示例：

 ```
 ibmcloud ks alb-cert-deploy --update --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:7e21fde8ee84a96d29240327daee3eb2
 ```
 {: pre}


### ibmcloud ks alb-cert-get --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [--json][-s]
{: #cs_alb_cert_get}

查看有关集群中 ALB 私钥的信息。

**注：**只有具有管理员访问权角色的用户才能执行此命令。

<strong>命令选项</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>ALB 私钥的名称。要获取有关集群中特定 ALB 私钥的信息，此值是必需的。</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>证书 CRN。要获取有关集群中与特定证书 CRN 匹配的所有 ALB 私钥的信息，此值是必需的。</dd>

  <dt><code>--json</code></dt>
  <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

**示例**：

 访存 ALB 私钥相关信息的示例：

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 访存与指定证书 CRN 匹配的所有 ALB 私钥相关信息的示例：

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --cert-crn  crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-cert-rm --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [-s]
{: #cs_alb_cert_rm}

除去集群中的 ALB 私钥。

**注：**只有具有管理员访问权角色的用户才能执行此命令。

<strong>命令选项</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>ALB 私钥的名称。要除去集群中的特定 ALB 私钥，此值是必需的。</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>证书 CRN。要除去集群中与特定证书 CRN 匹配的所有 ALB 私钥，此值是必需的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>

  </dl>

**示例**：

 除去 ALB 私钥的示例：

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 除去与指定证书 CRN 匹配的所有 ALB 私钥的示例：

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-certs --cluster CLUSTER [--json][-s]
{: #cs_alb_certs}

查看集群中 ALB 私钥的列表。

**注**：只有具有管理员访问权角色的用户才能执行此命令。

<strong>命令选项</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>
   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>
   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

 ```
 ibmcloud ks alb-certs --cluster my_cluster
 ```
 {: pre}

### ibmcloud ks alb-configure --albID ALB_ID [--enable][--disable] [--user-ip USERIP][-s]
{: #cs_alb_configure}

在标准集群中启用或禁用 ALB。缺省情况下，已启用公共 ALB。

**命令选项**：

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB 的标识。运行 <code>ibmcloud ks albs <em>--cluster </em>CLUSTER</code> 可查看集群中 ALB 的标识。此值是必需的。</dd>

   <dt><code>--enable</code></dt>
   <dd>包含此标志可在集群中启用 ALB。</dd>

   <dt><code>--disable</code></dt>
   <dd>包含此标志可在集群中禁用 ALB。</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>此参数仅可用于启用专用 ALB。</li>
    <li>专用 ALB 将使用用户提供的专用子网中的 IP 地址进行部署。如果未提供任何 IP 地址，那么该 ALB 将使用创建集群时自动供应的可移植专用子网中的专用 IP 地址进行部署。</li>
   </ul>
   </dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  启用 ALB 的示例：

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable
  ```
  {: pre}

  使用用户提供的 IP 地址启用 ALB 的示例：

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable --user-ip user_ip
  ```
  {: pre}

  禁用 ALB 的示例：

  ```
  ibmcloud ks alb-configure --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --disable
  ```
  {: pre}

### ibmcloud ks alb-get --albID ALB_ID [--json][-s]
{: #cs_alb_get}

查看 ALB 的详细信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB 的标识。运行 <code>ibmcloud ks albs --cluster <em>CLUSTER</em></code> 可查看集群中 ALB 的标识。此值是必需的。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks alb-get --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1
  ```
  {: pre}

### ibmcloud ks alb-types [--json][-s]
{: #cs_alb_types}

查看区域中支持的 ALB 类型。

<strong>命令选项</strong>：

  <dl>
  <dt><code>--json</code></dt>
  <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

**示例**：

  ```
  ibmcloud ks alb-types
  ```
  {: pre}


### ibmcloud ks albs --cluster CLUSTER [--json][-s]
{: #cs_albs}

查看集群中所有 ALB 的阶段状态。如果未返回任何 ALB 标识，说明集群没有可移植子网。您可以为集群[创建](#cs_cluster_subnet_create)或[添加](#cs_cluster_subnet_add)子网。

<strong>命令选项</strong>：

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>列出其中可用 ALB 的集群的名称或标识。此值是必需的。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks albs --cluster my_cluster
  ```
  {: pre}


<br />


## 基础架构命令
{: #infrastructure_commands}

### ibmcloud ks credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME [-s]
{: #cs_credentials_set}

为 {{site.data.keyword.containerlong_notm}} 区域设置 IBM Cloud Infrastructure (SoftLayer) 帐户凭证。

如果您有 {{site.data.keyword.Bluemix_notm}} 现买现付帐户，那么缺省情况下您可以访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。但是，您可能希望使用已经拥有的其他 IBM Cloud Infrastructure (SoftLayer) 帐户来订购基础架构。您可以使用此命令将此基础架构帐户链接到 {{site.data.keyword.Bluemix_notm}} 帐户。

如果为某个区域手动设置了 IBM Cloud Infrastructure (SoftLayer) 凭证，那么这些凭证会用于为该区域内的所有集群订购基础架构。这些凭证用于确定基础架构许可权，即使已存在该区域的 [IAM API 密钥](#cs_api_key_info)也不例外。如果存储了其凭证的用户没有必需的许可权来订购基础架构，那么与基础架构相关的操作（例如，创建集群或重新装入工作程序节点）可能会失败。

不能为同一 {{site.data.keyword.containerlong_notm}} 区域设置多个凭证。

**重要信息**：使用此命令之前，请确保使用其凭证的用户具有必需的 [{{site.data.keyword.containerlong_notm}} 和 IBM Cloud Infrastructure (SoftLayer) 许可权](cs_users.html#users)。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>IBM Cloud Infrastructure (SoftLayer) 帐户 API 用户名。此值是必需的。**注**：基础架构 API 用户名与 IBM 标识不同。要查看基础架构 API 用户名，请执行以下操作：
   <ol><li>登录到 [{{site.data.keyword.Bluemix_notm}} 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/)。</li>
   <li>在展开的菜单中，选择**基础架构**。</li>
   <li>在菜单栏中，选择**帐户** > **用户** > **用户列表**。</li>
   <li>对于要查看的用户，单击 **IBM 标识或用户名**。</li>
   <li>在 **API 访问信息**部分中，查看 **API 用户名**。</li>
   </ol></dd>


   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>IBM Cloud Infrastructure (SoftLayer) 帐户 API 密钥。此值是必需的。

 <p>
要生成 API 密钥：

  <ol>
  <li>登录到 [IBM Cloud Infrastructure (SoftLayer) 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://control.bluemix.net/)。</li>
  <li>选择<strong>帐户</strong>，然后选择<strong>用户</strong>。</li>
  <li>单击<strong>生成</strong>，为帐户生成 IBM Cloud Infrastructure (SoftLayer) API 密钥。</li>
  <li>复制 API 密钥以在此命令中使用。</li>
  </ol>

  要查看现有 API 密钥：
  <ol>
  <li>登录到 [IBM Cloud Infrastructure (SoftLayer) 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://control.bluemix.net/)。</li>
  <li>选择<strong>帐户</strong>，然后选择<strong>用户</strong>。</li>
  <li>单击<strong>查看</strong>以查看现有 API 密钥。</li>
  <li>复制 API 密钥以在此命令中使用。</li>
  </ol>
  </p></dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>

  </dl>

**示例**：

  ```
  ibmcloud ks credentials-set --infrastructure-api-key <api_key> --infrastructure-username dbmanager
  ```
  {: pre}


### ibmcloud ks credentials-unset
{: #cs_credentials_unset}

除去 {{site.data.keyword.containerlong_notm}} 区域的 IBM Cloud Infrastructure (SoftLayer) 帐户凭证。

除去凭证后，将使用 [IAM API 密钥](#cs_api_key_info)来订购 IBM Cloud Infrastructure (SoftLayer) 中的资源。

<strong>命令选项</strong>：

  <dl>
  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

**示例**：

  ```
  ibmcloud ks credentials-unset
  ```
  {: pre}


### ibmcloud ks machine-types --zone ZONE [--json][-s]
{: #cs_machine_types}

查看可用于工作程序节点的机器类型的列表。机器类型因专区而变化。每种机器类型都包含集群中每个工作程序节点的虚拟 CPU 量、内存量和磁盘空间量。缺省情况下，存储所有容器数据的辅助存储器磁盘目录将使用 LUKS 加密进行加密。如果在创建集群期间包含了 `disable-disk-encrypt` 选项，那么不会加密主机的容器运行时数据。[了解有关加密的更多信息](cs_secure.html#encrypted_disk)。
{:shortdesc}

可以将工作程序节点作为虚拟机在共享或专用硬件上进行供应，也可以作为物理机器在裸机上进行供应。[了解有关机器类型选项的更多信息](cs_clusters_planning.html#shared_dedicated_node)。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>输入要列出其中可用机器类型的专区。此值是必需的。请查看[可用专区](cs_regions.html#zones)。</dd>

   <dt><code>--json</code></dt>
  <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

**示例命令**：

  ```
  ibmcloud ks machine-types --zone dal10
  ```
  {: pre}

### ibmcloud ks vlans --zone ZONE [--all][--json] [-s]
{: #cs_vlans}

列出可用于 IBM Cloud Infrastructure (SoftLayer) 帐户中专区的公用和专用 VLAN。要列出可用 VLAN，您必须具有付费帐户。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>输入要列出其中专用和公用 VLAN 的专区。此值是必需的。请查看[可用专区](cs_regions.html#zones)。</dd>

   <dt><code>--all</code></dt>
   <dd>列出所有可用的 VLAN。缺省情况下，会对 VLAN 进行过滤，以仅显示有效的 VLAN。要使 VLAN 有效，必须将 VLAN 与可使用本地磁盘存储来托管工作程序的基础架构相关联。</dd>

   <dt><code>--json</code></dt>
  <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks vlans --zone dal10
  ```
  {: pre}


### ibmcloud ks vlan-spanning-get [--json][-s]
{: #cs_vlan_spanning_get}

查看 IBM Cloud Infrastructure (SoftLayer) 帐户的 VLAN 生成状态。VLAN 生成支持帐户中的所有设备通过专用网络相互通信，而不管设备分配给哪个 VLAN。

<strong>命令选项</strong>：

   <dl>
    <dt><code>--json</code></dt>
      <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

    <dt><code>-s</code></dt>
      <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks vlan-spanning-get
  ```
  {: pre}

<br />


## 日志记录命令
{: #logging_commands}

### ibmcloud ks logging-config-create --cluster CLUSTER --logsource LOG_SOURCE --type LOG_TYPE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-containers CONTAINERS] [--app-paths PATHS_TO_LOGS][--syslog-protocol PROTOCOL]  [--json][--skip-validation] [--force-update][-s]
{: #cs_logging_create}

创建日志记录配置。您可以使用此命令将容器、应用程序、工作程序节点、Kubernetes 集群以及 Ingress 应用程序负载均衡器的日志转发到 {{site.data.keyword.loganalysisshort_notm}} 或外部 syslog 服务器。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>集群的名称或标识。</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>    
    <dd>要对其启用日志转发的日志源。此自变量支持要应用其配置的日志源的逗号分隔列表。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> 和 <code>kube-audit</code>。如果未提供日志源，那么会为 <code>container</code> 和 <code>ingress</code> 创建配置。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>要转发日志的位置。选项为 <code>ibm</code>（将日志转发到 {{site.data.keyword.loganalysisshort_notm}}）和 <code>syslog</code>（将日志转发到外部服务器）。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>要从中转发日志的 Kubernetes 名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。此值仅对容器日志源有效，并且是可选的。如果未指定名称空间，那么集群中的所有名称空间都将使用此配置。</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
    <dd>日志记录类型为 <code>syslog</code> 时，日志收集器服务器的主机名或 IP 地址。此值对于 <code>syslog</code> 是必需的。日志记录类型为 <code>ibm</code> 时，{{site.data.keyword.loganalysislong_notm}} 数据获取 URL。您可以在[此处](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)找到可用数据获取 URL 的列表。如果未指定数据获取 URL，那么将使用创建集群所在区域的端点。</dd>

  <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
    <dd>日志收集器服务器的端口。此值是可选的。如果未指定端口，那么标准端口 <code>514</code> 将用于 <code>syslog</code>，并且标准端口 <code>9091</code> 将用于 <code>ibm</code>。</dd>

  <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
    <dd>可选：要向其发送日志的 Cloud Foundry 空间的名称。此值仅对日志类型 <code>ibm</code> 有效，并且是可选的。如果未指定空间，日志将发送到帐户级别。如果需要，还必须指定组织。</dd>

  <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
    <dd>可选：该空间所在的 Cloud Foundry 组织的名称。此值仅对日志类型 <code>ibm</code> 有效，如果指定了空间，那么此值是必需的。</dd>

  <dt><code>--app-paths</code></dt>
    <dd>容器上应用程序要将日志记录到的路径。要转发源类型为 <code>application</code> 的日志，必须提供路径。要指定多个路径，请使用逗号分隔列表。此值对于日志源 <code>application</code> 是必需的。示例：<code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

  <dt><code>--syslog-protocol</code></dt>
    <dd>日志记录类型为 <code>syslog</code> 时使用的传输层协议。支持的值为 <code>tcp</code>、<code>tls</code> 和缺省值 <code>udp</code>。使用 <code>udp</code> 协议转发到 rsyslog 服务器时，将截断超过 1 KB 的日志。</dd>

  <dt><code>--app-containers</code></dt>
    <dd>要转发来自应用程序的日志，可以指定包含应用程序的容器的名称。可以使用逗号分隔列表来指定多个容器。如果未指定任何容器，那么会转发来自包含所提供路径的所有容器中的日志。此选项仅对日志源 <code>application</code> 有效。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>--skip-validation</code></dt>
    <dd>跳过对指定组织和空间名称的验证。跳过验证可减少处理时间，但无效的日志记录配置将无法正确转发日志。此值是可选的。</dd>

  <dt><code>--force-update</code></dt>
    <dd>强制 Fluentd pod 更新到最新版本。Fluentd 必须处于最新版本才能更改日志记录配置。</dd>

    <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例**：

缺省端口 9091 上从 `container` 日志源转发的日志类型 `ibm` 的示例：

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

缺省端口 514 上从 `container` 日志源转发的日志类型 `syslog` 的示例：

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace  --hostname 169.xx.xxx.xxx --type syslog
  ```
  {: pre}

非缺省端口上从 `ingress` 源转发日志的日志类型 `syslog` 的实例：

  ```
  ibmcloud ks logging-config-create --cluster my_cluster --logsource container --hostname 169.xx.xxx.xxx --port 5514 --type syslog
  ```
  {: pre}

### ibmcloud ks logging-config-get --cluster CLUSTER [--logsource LOG_SOURCE][--json] [-s]
{: #cs_logging_get}

查看集群的所有日志转发配置，或基于日志源过滤日志记录配置。

<strong>命令选项</strong>：

 <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
    <dd>要过滤的日志源的类型。仅会返回集群中此日志源的日志记录配置。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> 和 <code>kube-audit</code>。此值是可选的。</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>显示导致先前过滤器过时的日志记录过滤器。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
 </dl>

**示例**：

  ```
  ibmcloud ks logging-config-get --cluster my_cluster --logsource worker
  ```
  {: pre}


### ibmcloud ks logging-config-refresh --cluster CLUSTER  [--force-update]  [-s]
{: #cs_logging_refresh}

刷新集群的日志记录配置。这将刷新转发到集群中空间级别的任何日志记录配置的日志记录令牌。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>--force-update</code></dt>
     <dd>强制 Fluentd pod 更新到最新版本。Fluentd 必须处于最新版本才能更改日志记录配置。</dd>

   <dt><code>-s</code></dt>
     <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例**：

  ```
  ibmcloud ks logging-config-refresh --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks logging-config-rm --cluster CLUSTER [--id LOG_CONFIG_ID][--all] [--force-update][-s]
{: #cs_logging_rm}

删除集群的一个日志转发配置或所有日志记录配置。这会停止将日志转发到远程 syslog 服务器或 {{site.data.keyword.loganalysisshort_notm}}。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>如果要除去单个日志记录配置，此值为日志记录配置标识。</dd>

  <dt><code>--all</code></dt>
   <dd>用于除去集群中所有日志记录配置的标志。</dd>

  <dt><code>--force-update</code></dt>
    <dd>强制 Fluentd pod 更新到最新版本。Fluentd 必须处于最新版本才能更改日志记录配置。</dd>

   <dt><code>-s</code></dt>
     <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例**：

  ```
  ibmcloud ks logging-config-rm --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### ibmcloud ks logging-config-update --cluster CLUSTER --id LOG_CONFIG_ID --type LOG_TYPE  [--namespace NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-paths PATH] [--app-containers PATH][--json] [--skipValidation][--force-update] [-s]
{: #cs_logging_update}

更新日志转发配置的详细信息。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>要更新的日志记录配置标识。此值是必需的。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>您要使用的日志转发协议。目前支持 <code>syslog</code> 和 <code>ibm</code>。此值是必需的。</dd>

  <dt><code>--namespace <em>NAMESPACE</em></code>
    <dd>要从中转发日志的 Kubernetes 名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。此值仅对 <code>container</code> 日志源有效。如果未指定名称空间，那么集群中的所有名称空间都将使用此配置。</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>日志记录类型为 <code>syslog</code> 时，日志收集器服务器的主机名或 IP 地址。此值对于 <code>syslog</code> 是必需的。日志记录类型为 <code>ibm</code> 时，{{site.data.keyword.loganalysislong_notm}} 数据获取 URL。您可以在[此处](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)找到可用数据获取 URL 的列表。如果未指定数据获取 URL，那么将使用创建集群所在区域的端点。</dd>

   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>日志收集器服务器的端口。当记录类型为 <code>syslog</code> 时，此值是可选的。如果未指定端口，那么标准端口 <code>514</code> 将用于 <code>syslog</code>，并且 <code>9091</code> 将用于 <code>ibm</code>。</dd>

   <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
   <dd>可选：要向其发送日志的空间的名称。此值仅对日志类型 <code>ibm</code> 有效，并且是可选的。如果未指定空间，日志将发送到帐户级别。如果需要，还必须指定组织。</dd>

   <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
   <dd>可选：该空间所在的 Cloud Foundry 组织的名称。此值仅对日志类型 <code>ibm</code> 有效，如果指定了空间，那么此值是必需的。</dd>

   <dt><code>--app-paths <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>容器中要从中收集日志的绝对文件路径。可以使用通配符（例如，“/var/log/*.log”），但不能使用递归 glob（例如，“/var/log/**/test.log”）。要指定多个路径，请使用逗号分隔列表。将日志源指定为“application”时，此值是必需的。</dd>

   <dt><code>--app-containers <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>容器上应用程序要将日志记录到的路径。要转发源类型为 <code>application</code> 的日志，必须提供路径。要指定多个路径，请使用逗号分隔列表。示例：<code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

   <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

   <dt><code>--skipValidation</code></dt>
    <dd>跳过对指定组织和空间名称的验证。跳过验证可减少处理时间，但无效的日志记录配置将无法正确转发日志。此值是可选的。</dd>

  <dt><code>--force-update</code></dt>
    <dd>强制 Fluentd pod 更新到最新版本。Fluentd 必须处于最新版本才能更改日志记录配置。</dd>

   <dt><code>-s</code></dt>
     <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

**日志类型 `ibm` 的示例**：

  ```
  ibmcloud ks logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**日志类型 `syslog` 的示例**：

  ```
  ibmcloud ks logging-config-update --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### ibmcloud ks logging-filter-create --cluster CLUSTER --type LOG_TYPE [--logging-configs CONFIGS] [--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME] [--level LOGGING_LEVEL] [--regex-message MESSAGE]  [--force-update]  [--json] [-s]
{: #cs_log_filter_create}

创建日志记录过滤器。可以使用此命令来过滤掉根据日志记录配置转发的日志。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要为其创建日志记录过滤器的集群的名称或标识。此值是必需的。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>要应用过滤器的日志的类型。目前支持 <code>all</code>、<code>container</code> 和 <code>host</code>。</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>日志记录配置标识的逗号分隔列表。如果未提供，过滤器将应用于传递到过滤器的所有集群日志记录配置。可以通过将 <code>--show-matching-configs</code> 标志用于命令来查看与过滤器相匹配的日志配置。此值是可选的。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>要从中过滤日志的 Kubernetes 名称空间。此值是可选的。</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>要从中过滤掉日志的容器的名称。仅当使用日志类型 <code>container</code> 时，此标志才适用。此值是可选的。</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>过滤掉处于指定级别及更低级别的日志。规范顺序的可接受值为 <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code> 和 <code>trace</code>。此值是可选的。例如，如果过滤掉 <code>info</code> 级别的日志，那么还会过滤掉 <code>debug</code> 和 <code>trace</code>。**注**：仅当日志消息为 JSON 格式且包含 level 字段时，才能使用此标志。示例输出：<code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>过滤掉在日志中任何位置包含编写为正则表达式的指定消息的任何日志。此值是可选的。</dd>

  <dt><code>--force-update</code></dt>
    <dd>强制 Fluentd pod 更新到最新版本。Fluentd 必须处于最新版本才能更改日志记录配置。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例**：

此示例过滤掉满足以下条件的所有日志：从缺省名称空间中名称为 `test-container` 的容器转发，处于 debug 级别或更低级别，并且具有包含“GET request”的日志消息。

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

此示例过滤掉处于 info 级别或更低级别且从特定集群转发的所有日志。输出会作为 JSON 返回。

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type all --level info --json
  ```
  {: pre}



### ibmcloud ks logging-filter-get --cluster CLUSTER [--id FILTER_ID][--show-matching-configs] [--show-covering-filters][--json] [-s]
{: #cs_log_filter_view}

查看日志记录过滤器配置。可以使用此命令来查看已创建的日志记录过滤器。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要查看其中过滤器的集群的名称或标识。此值是必需的。</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>要查看的日志过滤器的标识。</dd>

  <dt><code>--show-matching-configs</code></dt>
    <dd>显示与要查看的配置相匹配的日志记录配置。此值是可选的。</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>显示导致先前过滤器过时的日志记录过滤器。此值是可选的。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

   <dt><code>-s</code></dt>
     <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>


### ibmcloud ks logging-filter-rm --cluster CLUSTER [--id FILTER_ID][--all] [--force-update][-s]
{: #cs_log_filter_delete}

删除日志记录过滤器。可以使用此命令来除去已创建的日志记录过滤器。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要删除其中过滤器的集群的名称或标识。</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>要删除的日志过滤器的标识。</dd>

  <dt><code>--all</code></dt>
    <dd>删除所有日志转发过滤器。此值是可选的。</dd>

  <dt><code>--force-update</code></dt>
    <dd>强制 Fluentd pod 更新到最新版本。Fluentd 必须处于最新版本才能更改日志记录配置。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

### ibmcloud ks logging-filter-update --cluster CLUSTER --id FILTER_ID --type LOG_TYPE [--logging-configs CONFIGS] [--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME] [--level LOGGING_LEVEL] [--message MESSAGE]  [--force-update] [--json] [-s]
{: #cs_log_filter_update}

更新日志记录过滤器。可以使用此命令来更新已创建的日志记录过滤器。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要更新其日志记录过滤器的集群的名称或标识。此值是必需的。</dd>

 <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>要更新的日志过滤器的标识。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>要应用过滤器的日志的类型。目前支持 <code>all</code>、<code>container</code> 和 <code>host</code>。</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>日志记录配置标识的逗号分隔列表。如果未提供，过滤器将应用于传递到过滤器的所有集群日志记录配置。可以通过将 <code>--show-matching-configs</code> 标志用于命令来查看与过滤器相匹配的日志配置。此值是可选的。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>要从中过滤日志的 Kubernetes 名称空间。此值是可选的。</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>要从中过滤掉日志的容器的名称。仅当使用日志类型 <code>container</code> 时，此标志才适用。此值是可选的。</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>过滤掉处于指定级别及更低级别的日志。规范顺序的可接受值为 <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code> 和 <code>trace</code>。此值是可选的。例如，如果过滤掉 <code>info</code> 级别的日志，那么还会过滤掉 <code>debug</code> 和 <code>trace</code>。**注**：仅当日志消息为 JSON 格式且包含 level 字段时，才能使用此标志。示例输出：<code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>过滤掉在日志中任何位置包含指定消息的任何日志。消息按字面值进行匹配，而不作为表达式进行匹配。示例：消息“Hello”、“!”和“Hello, World!”都将应用于日志“Hello, World!”。此值是可选的。</dd>

  <dt><code>--force-update</code></dt>
    <dd>强制 Fluentd pod 更新到最新版本。Fluentd 必须处于最新版本才能更改日志记录配置。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

### ibmcloud ks logging-autoupdate-enable --cluster CLUSTER
{: #cs_log_autoupdate_enable}

在特定集群中启用 Fluentd pod 的自动更新。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要更新其日志记录过滤器的集群的名称或标识。此值是必需的。</dd>
</dl>

### ibmcloud ks logging-autoupdate-disable --cluster CLUSTER
{: #cs_log_autoupdate_disable}

在特定集群中禁用 Fluentd pod 的自动更新。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要更新其日志记录过滤器的集群的名称或标识。此值是必需的。</dd>
</dl>

### ibmcloud ks logging-autoupdate-get --cluster CLUSTER
{: #cs_log_autoupdate_get}

查看 Fluentd pod 是否在特定集群中设置为自动更新。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要更新其日志记录过滤器的集群的名称或标识。此值是必需的。</dd>
</dl>

<br />


## 区域命令
{: #region_commands}

### ibmcloud ks zones [--region-only][--json] [-s]
{: #cs_datacenters}

查看可用于在其中创建集群的专区的列表。可用的专区根据您登录到的区域而变化。要切换区域，请运行 `ibmcloud ks region-set`。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--region-only</code></dt>
   <dd>仅列出您登录到的区域内的多专区。此值是可选的。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
        ibmcloud ks zones
        ```
  {: pre}


### ibmcloud ks region
{: #cs_region}

查找当前所在的 {{site.data.keyword.containerlong_notm}} 区域。您可以创建和管理特定于该区域的集群。使用 `ibmcloud ks region-set` 命令可更改区域。

**示例**：

```
ibmcloud ks region
```
{: pre}

**输出**：
```
Region: us-south
```
{: screen}

### ibmcloud ks region-set [--region REGION]
{: #cs_region-set}

设置 {{site.data.keyword.containerlong_notm}} 的区域。您可以创建和管理特定于该区域的集群，并且您可能希望在多个区域中创建集群以实现高可用性。

例如，您可以登录到美国南部区域的 {{site.data.keyword.Bluemix_notm}} 并创建集群。接下来，您可以使用 `ibmcloud ks region-set eu-central` 将欧洲中部区域作为目标，并创建另一个集群。最后，您可以使用 `ibmcloud ks region-set us-south` 返回到美国南部，以管理该区域中的集群。

**命令选项**：

<dl>
<dt><code>--region <em>REGION</em></code></dt>
<dd>输入要作为目标的区域。此值是可选的。如果您未提供区域，那么可以从输出中的列表中选择区域。



要获取可用区域的列表，请查看[区域和专区](cs_regions.html)或使用 `ibmcloud ks regions` [命令](#cs_regions)。</dd></dl>

**示例**：

```
ibmcloud ks region-set eu-central
```
{: pre}

```
ibmcloud ks region-set
```
{: pre}

**输出**：
```
Choose a region:
1. ap-north
2. ap-south
3. eu-central
4. uk-south
5. us-east
6. us-south
Enter a number> 3
OK
```
{: screen}

### ibmcloud ks regions
{: #cs_regions}

列出可用的区域。`Region Name` 是 {{site.data.keyword.containerlong_notm}} 名称，`Region Alias` 是区域的常规 {{site.data.keyword.Bluemix_notm}} 名称。

**示例**：

```
ibmcloud ks regions
```
{: pre}

**输出**：
```
Region Name   Region Alias
ap-north      jp-tok
ap-south      au-syd
eu-central    eu-de
uk-south      eu-gb
us-east       us-east
us-south      us-south
```
{: screen}


<br />


## 工作程序节点命令
{: worker_node_commands}


### 不推荐：ibmcloud ks worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --workers NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt][-s]
{: #cs_worker_add}

向标准集群添加不在工作程序池中的独立工作程序节点。

<strong>命令选项</strong>：

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>集群的名称或标识。此值是必需的。</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>用于将工作程序节点添加到集群的 YAML 文件的路径。您可以使用 YAML 文件，而不使用此命令中提供的选项来定义其他工作程序节点。此值是可选的。

<p><strong>注</strong>：如果在命令中提供的选项与 YAML 文件中的参数相同，那么命令中的值将优先于 YAML 中的值。例如，您在 YAML 文件中定义了机器类型，并在命令中使用了 --machine-type 选项，那么在该命令选项中输入的值会覆盖 YAML 文件中的相应值。

      

<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_ID&gt;</em>
zone: <em>&lt;zone&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
diskEncryption: <em>false</em></code></pre>

<table>
<caption>了解 YAML 文件的组成部分</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>将 <code><em>&lt;cluster_name_or_ID&gt;</em></code> 替换为要在其中添加工作程序节点的集群的名称或标识。</td>
</tr>
<tr>
<td><code><em>zone</em></code></td>
<td>将 <code><em>&lt;zone&gt;</em></code> 替换为要部署工作程序节点的专区。可用的专区取决于您登录到的区域。要列出可用专区，请运行 <code>ibmcloud ks zones</code>。</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>将 <code><em>&lt;machine_type&gt;</em></code> 替换为要将工作程序节点部署到的机器类型。可以将工作程序节点作为虚拟机部署在共享或专用硬件上，也可以作为物理机器部署在裸机上。可用的物理和虚拟机类型随集群的部署专区而变化。有关更多信息，请参阅 `ibmcloud ks machine-types` [命令](cs_cli_reference.html#cs_machine_types)。</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>将 <code><em>&lt;private_VLAN&gt;</em></code> 替换为要用于工作程序节点的专用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> 并查找以 <code>bcr</code>（后端路由器）开头的 VLAN 路由器。</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>将 <code>&lt;public_VLAN&gt;</code> 替换为要用于工作程序节点的公用 VLAN 的标识。要列出可用的 VLAN，请运行 <code>ibmcloud ks vlans &lt;zone&gt;</code> 并查找以 <code>fcr</code>（前端路由器）开头的 VLAN 路由器。<br><strong>注</strong>：{[private_VLAN_vyatta]}</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>对于虚拟机类型：工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>将 <code><em>&lt;number_workers&gt;</em></code> 替换为要部署的工作程序节点数。</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>工作程序节点缺省情况下具有磁盘加密功能：[了解更多](cs_secure.html#encrypted_disk)。要禁用加密，请包括此选项并将值设置为 <code>false</code>。</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。此值是可选的。</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>选择机器类型。可以将工作程序节点作为虚拟机部署在共享或专用硬件上，也可以作为物理机器部署在裸机上。可用的物理和虚拟机类型随集群的部署专区而变化。有关更多信息，请参阅 `ibmcloud ks machine-types` [命令](cs_cli_reference.html#cs_machine_types)的文档。此值对于标准集群是必需的，且不可用于免费集群。</dd>

<dt><code>--workers <em>NUMBER</em></code></dt>
<dd>整数，表示要在集群中创建的工作程序节点数。缺省值为 1。此值是可选的。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>创建集群时指定的专用 VLAN。此值是必需的。

<p><strong>注：</strong>专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。创建集群并指定公用和专用 VLAN 时，在这些前缀之后的数字和字母组合必须匹配。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>创建集群时指定的公用 VLAN。此值是可选的。如果希望工作程序节点仅存在于专用 VLAN 上，请不要提供公用 VLAN 标识。<strong>注</strong>：{[private_VLAN_vyatta]}

<p><strong>注：</strong>专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。创建集群并指定公用和专用 VLAN 时，在这些前缀之后的数字和字母组合必须匹配。</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>工作程序节点缺省情况下具有磁盘加密功能：[了解更多](cs_secure.html#encrypted_disk)。要禁用加密，请包括此选项。</dd>

<dt><code>-s</code></dt>
<dd>不显示每日消息或更新提示。此值是可选的。</dd>

</dl>

**示例**：

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --hardware shared
  ```
  {: pre}

  {{site.data.keyword.Bluemix_dedicated_notm}} 的示例：

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --machine-type b2c.4x16
  ```
  {: pre}

### ibmcloud ks worker-get --cluster [CLUSTER_NAME_OR_ID] --worker WORKER_NODE_ID [--json][-s]
{: #cs_worker_get}

查看工作程序节点的详细信息。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
   <dd>工作程序节点的集群的名称或标识。此值是可选的。</dd>

   <dt><code>--worker <em>WORKER_NODE_ID</em></code></dt>
   <dd>工作程序节点的名称。运行 <code>ibmcloud ks workers <em>CLUSTER</em></code> 可查看集群中工作程序节点的标识。此值是必需的。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例命令**：

  ```
  ibmcloud ks worker-get --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
  ```
  {: pre}

**示例输出**：

  ```
  ID:           kube-dal10-123456789-w1
  State:        normal
  Status:       Ready
  Trust:        disabled
  Private VLAN: 223xxxx
  Public VLAN:  223xxxx
  Private IP:   10.xxx.xx.xxx
  Public IP:    169.xx.xxx.xxx
  Hardware:     shared
  Zone:         dal10
  Version:      1.8.11_1509
  ```
  {: screen}

### ibmcloud ks worker-reboot [-f][--hard] --cluster CLUSTER --worker WORKER [WORKER][-s]
{: #cs_worker_reboot}

重新引导集群中的工作程序节点。在重新引导期间，工作程序节点的状态不会更改。例如，如果 IBM Cloud Infrastructure (SoftLayer) 中的工作程序节点状态为 `Powered Off`，但您需要开启该工作程序节点，那么可以使用重新引导。

**注意：**重新引导工作程序节点可能导致工作程序节点上发生数据损坏。请谨慎使用此命令，仅在确信重新引导可以帮助恢复工作程序节点时使用。在其他所有情况下，请改为[重新装入工作程序节点](#cs_worker_reload)。

在重新引导工作程序节点之前，请确保将 pod 重新安排到其他工作程序节点上，以帮助避免因工作程序节点上的应用程序或数据损坏而产生的停机时间。

1. 列出集群中的所有工作程序节点，并记下要重新引导的工作程序节点的 **name**。
   ```
kubectl get nodes
```
   此命令中返回的 **name** 是分配给工作程序节点的专用 IP 地址。在运行 `ibmcloud ks workers <cluster_name_or_ID>` 命令，并查找具有相同 **Private IP** 地址的工作程序节点时，可以找到有关工作程序节点的更多信息。
2. 在称为“封锁”的过程中将工作程序节点标记为不可安排。封锁工作程序节点后，该节点即不可用于未来的 pod 安排。使用在上一步中检索到的工作程序节点的 **name**。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. 验证是否已对工作程序节点禁用了 pod 安排。
   ```
kubectl get nodes
```
   {: pre}
   如果阶段状态显示为 **SchedulingDisabled**，说明已禁止工作程序节点用于 pod 安排。
 4. 强制从工作程序节点中除去 pod，并将其重新安排到集群中的剩余工作程序节点上。
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
此过程可能需要几分钟时间。
 5. 重新引导工作程序节点。使用从 `ibmcloud ks workers <cluster_name_or_ID>` 命令检索到的工作程序节点的标识。
      ```
    ibmcloud ks worker-reboot --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}
 6. 等待大约 5 分钟后，才能使工作程序节点可用于 pod 安排，以确保重新引导完成。在重新引导期间，工作程序节点的状态不会更改。工作程序节点的重新引导通常在几秒后完成。
 7. 使工作程序节点可用于 pod 安排。请使用从 `kubectl get nodes` 命令返回的工作程序节点的 **name**。
    ```
    kubectl uncordon <worker_name>
    ```
    {: pre}
    </br>

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制重新启动工作程序节点，而不显示用户提示。此值是可选的。</dd>

   <dt><code>--hard</code></dt>
   <dd>使用此选项可通过切断工作程序节点的电源来强制硬重新启动该工作程序节点。如果工作程序节点无响应或工作程序节点的容器运行时无响应，请使用此选项。此值是可选的。</dd>

   <dt><code>--worker <em>WORKER</em></code></dt>
   <dd>一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks worker-reboot --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-reload [-f] --cluster CLUSTER --worker WORKER [WORKER][-s]
{: #cs_worker_reload}

重新装入工作程序节点的所有必需配置。如果工作程序节点遇到问题（例如，性能降低），或者如果工作程序节点卡在非正常运行状态，那么重新装入会非常有用。

重新装入工作程序节点会将补丁版本更新应用于工作程序节点，但不会应用主要或次要更新。要查看从一个补丁版本到下一个补丁版本的更改，请查看[版本更改日志](cs_versions_changelog.html#changelog)文档。
{: tip}

在重新装入工作程序节点之前，请确保将 pod 重新安排到其他工作程序节点上，以帮助避免因工作程序节点上的应用程序或数据损坏而产生的停机时间。

1. 列出集群中的所有工作程序节点，并记下要重新装入的工作程序节点的 **name**。
   ```
kubectl get nodes
```
   此命令中返回的 **name** 是分配给工作程序节点的专用 IP 地址。在运行 `ibmcloud ks workers <cluster_name_or_ID>` 命令，并查找具有相同 **Private IP** 地址的工作程序节点时，可以找到有关工作程序节点的更多信息。
2. 在称为“封锁”的过程中将工作程序节点标记为不可安排。封锁工作程序节点后，该节点即不可用于未来的 pod 安排。使用在上一步中检索到的工作程序节点的 **name**。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. 验证是否已对工作程序节点禁用了 pod 安排。
   ```
kubectl get nodes
```
   {: pre}
   如果阶段状态显示为 **SchedulingDisabled**，说明已禁止工作程序节点用于 pod 安排。
 4. 强制从工作程序节点中除去 pod，并将其重新安排到集群中的剩余工作程序节点上。
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
此过程可能需要几分钟时间。
 5. 重新装入工作程序节点。使用从 `ibmcloud ks workers <cluster_name_or_ID>` 命令检索到的工作程序节点的标识。
      ```
    ibmcloud ks worker-reload --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}
 6. 等待重新装入完成。
 7. 使工作程序节点可用于 pod 安排。请使用从 `kubectl get nodes` 命令返回的工作程序节点的 **name**。
    ```
    kubectl uncordon <worker_name>
    ```
</br>
<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制重新装入工作程序节点，而不显示用户提示。此值是可选的。</dd>

   <dt><code>--worker <em>WORKER</em></code></dt>
   <dd>一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks worker-reload --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-rm [-f] --cluster CLUSTER --workers WORKER[,WORKER][-s]
{: #cs_worker_rm}

从集群中除去一个或多个工作程序节点。如果除去工作程序节点，那么集群将变得不均衡。您可以通过运行 `ibmcloud ks worker-pool-rebalance` [命令](#cs_rebalance)来自动重新均衡工作程序池。

在除去工作程序节点之前，请确保将 pod 重新安排到其他工作程序节点上，以帮助避免因工作程序节点上的应用程序或数据损坏而产生的停机时间。
{: tip}

1. 列出集群中的所有工作程序节点，并记下要除去的工作程序节点的 **name**。
   ```
kubectl get nodes
```
   此命令中返回的 **name** 是分配给工作程序节点的专用 IP 地址。在运行 `ibmcloud ks workers <cluster_name_or_ID>` 命令，并查找具有相同 **Private IP** 地址的工作程序节点时，可以找到有关工作程序节点的更多信息。
2. 在称为“封锁”的过程中将工作程序节点标记为不可安排。封锁工作程序节点后，该节点即不可用于未来的 pod 安排。使用在上一步中检索到的工作程序节点的 **name**。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. 验证是否已对工作程序节点禁用了 pod 安排。
   ```
kubectl get nodes
```
   {: pre}
   如果阶段状态显示为 **SchedulingDisabled**，说明已禁止工作程序节点用于 pod 安排。
4. 强制从工作程序节点中除去 pod，并将其重新安排到集群中的剩余工作程序节点上。
   ```
    kubectl drain <worker_name>
    ```
   {: pre}
   此过程可能需要几分钟时间。
5. 除去工作程序节点。使用从 `ibmcloud ks workers <cluster_name_or_ID>` 命令检索到的工作程序节点的标识。
      
   ```
   ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
   ```
   {: pre}

6. 验证工作程序节点是否已除去。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
</br>
<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制除去工作程序节点，而不显示用户提示。此值是可选的。</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>一个或多个工作程序节点的名称或标识。列出多个工作程序节点时使用空格分隔。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks worker-rm --cluster my_cluster --workers kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-update [-f] --cluster CLUSTER --workers WORKER[,WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update][-s]
{: #cs_worker_update}

更新工作程序节点以将最新的安全性更新和补丁应用于操作系统，并更新 Kubernetes 版本以与主节点的版本相匹配。可以使用 `ibmcloud ks cluster-update` [命令](cs_cli_reference.html#cs_cluster_update)来更新主节点 Kubernetes 版本。

**重要信息**：运行 `ibmcloud ks worker-update` 可能会导致应用程序和服务产生停机时间。更新期间，所有 pod 都将重新安排到其他工作程序节点，如果数据未存储在 pod 外部，那么将删除数据。为避免停机时间，请[确保在所选工作程序节点更新时有足够的工作程序节点来处理工作负载](cs_cluster_update.html#worker_node)。

在更新前，您可能需要更改 YAML 文件以进行部署。请查看此[发行说明](cs_versions.html)以了解详细信息。

<strong>命令选项</strong>：

   <dl>

   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>列出了其中可用工作程序节点的集群的名称或标识。此值是必需的。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此选项可强制更新主节点，而不显示用户提示。此值是可选的。</dd>

   <dt><code>--force-update</code></dt>
   <dd>即便更改是跨 2 个以上的次版本，也仍尝试更新。此值是可选的。</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
     <dd>要用于更新工作程序节点的 Kubernetes 版本。如果未指定此值，将使用缺省版本。</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>一个或多个工作程序节点的标识。列出多个工作程序节点时使用空格分隔。此值是必需的。</dd>

   <dt><code>-s</code></dt>
   <dd>不显示每日消息或更新提示。此值是可选的。</dd>

   </dl>

**示例**：

  ```
  ibmcloud ks worker-update --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}

### ibmcloud ks workers --cluster CLUSTER [--worker-pool POOL][--show-pools] [--show-deleted][--json] [-s]
{: #cs_workers}

查看集群中工作程序节点的列表以及每个工作程序节点的状态。

<strong>命令选项</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>可用工作程序节点的集群的名称或标识。此值是必需的。</dd>

   <dt><code>--worker-pool <em>POOL</em></code></dt>
   <dd>仅查看属于工作程序池的工作程序节点。要列出可用的工作程序池，请运行 `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`. 此值是可选的。</dd>

   <dt><code>--show-pools</code></dt>
   <dd>列出每个工作程序节点所属的工作程序池。此值是可选的。</dd>

   <dt><code>--show-deleted</code></dt>
   <dd>查看从集群中删除的工作程序节点，包括删除原因。此值是可选的。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
  <dd>不显示每日消息或更新提示。此值是可选的。</dd>
   </dl>

**示例**：

  ```
  ibmcloud ks workers --cluster my_cluster
  ```
  {: pre}

<br />


## 工作程序池命令
{: #worker-pool}

### ibmcloud ks worker-pool-create --name POOL_NAME --cluster CLUSTER --machine-type MACHINE_TYPE --size-per-zone WORKERS_PER_ZONE [--hardware ISOLATION][--labels LABELS] [--disable-disk-encrypt][-s] [--json]
{: #cs_worker_pool_create}

可以在集群中创建工作程序池。添加工作程序池时，缺省情况下不会为其分配专区。您可以指定每个专区中需要的工作程序数以及工作程序的机器类型。将为工作程序池提供缺省 Kubernetes 版本。要完成创建工作程序，请向池[添加专区](#cs_zone_add)。

<strong>命令选项</strong>：
<dl>

  <dt><code>--name <em>POOL_NAME</em></code></dt>
    <dd>要为工作程序池提供的名称。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
    <dd>选择机器类型。可以将工作程序节点作为虚拟机部署在共享或专用硬件上，也可以作为物理机器部署在裸机上。可用的物理和虚拟机类型随集群的部署专区而变化。有关更多信息，请参阅 `ibmcloud ks machine-types` [命令](cs_cli_reference.html#cs_machine_types)的文档。此值对于标准集群是必需的，且不可用于免费集群。</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>要在每个专区中创建的工作程序数。此值是必需的，并且必须大于或等于 1。</dd>

  <dt><code>--hardware <em>HARDWARE</em></code></dt>
    <dd>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。此值是可选的。</dd>

  <dt><code>--labels <em>LABELS</em></code></dt>
    <dd>要分配给池中工作程序的标签。示例：<key1>=<val1>,<key2>=<val2></dd>

  <dt><code>--diable-disk-encrpyt</code></dt>
    <dd>指定不对磁盘进行加密。缺省值为 <code>false</code>。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例命令**：

  ```
  ibmcloud ks worker-pool-create --name my_pool --cluster my_cluster --machine-type b2c.4x16 --size-per-zone 6
  ```
  {: pre}

### ibmcloud ks worker-pool-get --worker-pool WORKER_POOL --cluster CLUSTER [-s][--json]
{: #cs_worker_pool_get}

查看工作程序池的详细信息。

<strong>命令选项</strong>：

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>要查看其详细信息的工作程序节点池的名称。要列出可用的工作程序池，请运行 `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`. 此值是必需的。</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>工作程序池所在的集群的名称或标识。此值是必需的。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例命令**：

  ```
  ibmcloud ks worker-pool-get --worker-pool pool1 --cluster my_cluster
  ```
  {: pre}

**示例输出**：

  ```
  Name:               pool   
  ID:                 a1a11b2222222bb3c33c3d4d44d555e5-f6f777g   
  State:              active   
  Hardware:           shared   
  Zones:              dal10,dal12   
  Workers per zone:   3   
  Machine type:       b2c.4x16.encrypted   
  Labels:             -   
  Version:            1.10.7_1512
  ```
  {: screen}

### ibmcloud ks worker-pool-rebalance --cluster CLUSTER --worker-pool WORKER_POOL [-s]
{: #cs_rebalance}

删除工作程序节点后，可以重新均衡工作程序池。运行此命令后，会向工作程序池添加新的工作程序。

<strong>命令选项</strong>：

<dl>
  <dt><code><em>--cluster CLUSTER</em></code></dt>
    <dd>集群的名称或标识。此值是必需的。</dd>
  <dt><code><em>--worker-pool WORKER_POOL</em></code></dt>
    <dd>要重新均衡的工作程序池。此值是必需的。</dd>
  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例**：

  ```
  ibmcloud ks worker-pool-rebalance --cluster my_cluster --worker-pool my_pool
  ```
  {: pre}

### ibmcloud ks worker-pool-resize --worker-pool WORKER_POOL --cluster CLUSTER --size-per-zone WORKERS_PER_ZONE [-s]
{: #cs_worker_pool_resize}

调整工作程序池的大小，以增大或减小集群的每个专区中的工作程序节点数。工作程序池必须至少有一个工作程序节点。

<strong>命令选项</strong>：

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>要更新的工作程序节点池的名称。此值是必需的。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要调整其工作程序池大小的集群的名称或标识。此值是必需的。</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>要在每个专区中拥有的工作程序数。此值是必需的，并且必须大于或等于 1。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>

</dl>

**示例命令**：

  ```
  ibmcloud ks worker-pool-resize --cluster my_cluster --worker-pool my_pool --size-per-zone 3
  ```
  {: pre}

### ibmcloud ks worker-pool-rm --worker-pool WORKER_POOL --cluster CLUSTER [-s]
{: #cs_worker_pool_rm}

从集群中除去工作程序池。这将删除池中的所有工作程序节点。执行删除时，会重新安排 pod。为了避免产生停机时间，请确保您有足够的工作程序来运行工作负载。

<strong>命令选项</strong>：

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>要除去的工作程序节点池的名称。此值是必需的。</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>要从中除去工作程序池的集群的名称或标识。此值是必需的。</dd>
  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例命令**：

  ```
  ibmcloud ks worker-pool-rm --cluster my_cluster --worker-pool pool1
  ```
  {: pre}

### ibmcloud ks worker-pools --cluster CLUSTER [--json][-s]
{: #cs_worker_pools}

查看您在集群中具有的工作程序池。

<strong>命令选项</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
    <dd>要列出其工作程序池的集群的名称或标识。此值是必需的。</dd>
  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>
  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例命令**：

  ```
  ibmcloud ks worker-pools --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks zone-add --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN][--private-only] [--json][-s]
{: #cs_zone_add}

**仅限多专区集群**：创建集群或工作程序池后，可以添加专区。添加专区后，会向新专区添加工作程序节点，以匹配为工作程序池指定的每个专区的工作程序数。

<strong>命令选项</strong>：

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>要添加的专区。必须是集群区域内的[支持多专区的专区](cs_regions.html#zones)。此值是必需的。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>向其添加区域的工作程序池的逗号分隔列表。至少需要 1 个工作程序池。</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd><p>专用 VLAN 的标识。此值是有条件的。</p>
    <p>如果专区中有专用 VLAN，那么此值必须与集群中一个或多个工作程序节点的专用 VLAN 标识相匹配。要查看可用的 VLAN，请运行 <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code>。</p>
    <p>如果在该专区中没有专用或公用 VLAN，请勿指定此选项。初始向工作程序池添加新专区后，会自动创建专用和公用 VLAN。</p>
    <p>如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。</p>
<p>**注**：新的工作程序节点会添加到指定的 VLAN，但不会更改任何现有工作程序节点的 VLAN。</p></dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd><p>公用 VLAN 的标识。如果要在创建集群之后向公众公开节点上的工作负载，那么此值是必需的。此值必须与集群中该专区的一个或多个工作程序节点的公用 VLAN 标识相匹配。要查看可用的 VLAN，请运行 <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code>。</p>
    <p>如果在该专区中没有专用或公用 VLAN，请勿指定此选项。初始向工作程序池添加新专区后，会自动创建专用和公用 VLAN。</p>
    <p>如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。</p>
    <p>**注**：新的工作程序节点会添加到指定的 VLAN，但不会更改任何现有工作程序节点的 VLAN。</p></dd>

  <dt><code>--private-only </code></dt>
    <dd>使用此选项可阻止创建公用 VLAN。仅当指定 `--private-vlan` 标志并且不包含 `--public-vlan` 标志时，此项才是必需的。**注**：如果需要仅专用集群，那么必须配置网关设备进行网络连接。有关更多信息，请参阅[为仅专用 VLAN 设置规划专用外部联网](cs_network_planning.html#private_vlan)。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式打印命令输出。此值是可选的。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例**：

  ```
  ibmcloud ks zone-add --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

  ### ibmcloud ks zone-network-set --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN][-f] [-s]
  {: #cs_zone_network_set}

  **仅限多专区集群**：为工作程序池设置网络元数据，以将与先前所用不同的公用或专用 VLAN 用于专区。池中已创建的工作程序节点会继续使用先前的公用或专用 VLAN，但池中的新工作程序节点将使用新的网络数据。

  专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。创建集群并指定公用和专用 VLAN 时，在这些前缀之后的数字和字母组合必须匹配。
  <ol><li>检查集群中可用的 VLAN。<pre class="pre"><code>ibmcloud ks cluster-get --cluster &lt;cluster_name_or_ID&gt; --showResources</code></pre><p>输出示例：</p>
  <pre class="screen"><code>Subnet VLANs
VLAN ID   Subnet CIDR         Public   User-managed
229xxxx   169.xx.xxx.xxx/29   true     false
229xxxx   10.xxx.xx.x/29      false    false</code></pre></li>
  <li>检查要使用的公用和专用 VLAN 标识是否兼容。要使两者兼容，<strong>Router</strong> 必须具有相同的 pod 标识。<pre class="pre"><code>ibmcloud ks vlans --zone &lt;zone&gt;</code></pre><p>输出示例：</p>
  <pre class="screen"><code>ID        Name   Number   Type      Router         Supports Virtual Workers
229xxxx          1234     private   bcr01a.dal12   true
229xxxx          5678     public    fcr01a.dal12   true</code></pre><p>请注意，<strong>Router</strong> pod 标识匹配：`01a` 和 `01a`。如果一个 pod 标识为 `01a`，另一个为 `02a`，那么无法为工作程序池设置公用和专用 VLAN 标识。</p></li>
  <li>如果没有任何 VLAN 可用，那么可以<a href="/docs/infrastructure/vlans/order-vlan.html#order-vlans">订购新的 VLAN</a>。</li></ol>

  <strong>命令选项</strong>：

  <dl>
    <dt><code>--zone <em>ZONE</em></code></dt>
      <dd>要添加的专区。必须是集群区域内的[支持多专区的专区](cs_regions.html#zones)。此值是必需的。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>向其添加区域的工作程序池的逗号分隔列表。至少需要 1 个工作程序池。</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd>专用 VLAN 的标识。此值是必需的，无论要使用的专用 VLAN 与用于其他工作程序节点的专用 VLAN 相同还是不同。<br><br><strong>重要信息</strong>：专用 VLAN 和公用 VLAN 必须兼容，这可通过 **Router** 标识前缀进行确定。<br><br>**注**：新的工作程序节点会添加到指定的 VLAN，但不会更改任何现有工作程序节点的 VLAN。</dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd>公用 VLAN 的标识。仅当要更改专区的公用 VLAN 时，此值才是必需的。要更改公用 VLAN，必须始终提供兼容的专用 VLAN。<br><br><strong>重要信息</strong>：专用 VLAN 和公用 VLAN 必须兼容，这可通过 **Router** 标识前缀进行确定。<br><br>**注**：新的工作程序节点会添加到指定的 VLAN，但不会更改任何现有工作程序节点的 VLAN。</dd>

  <dt><code>-f</code></dt>
    <dd>强制此命令运行，而不显示用户提示。此值是可选的。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
  </dl>

  **示例**：

  ```
  ibmcloud ks zone-network-set --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

### ibmcloud ks zone-rm --zone ZONE --cluster CLUSTER [-f][-s]
{: #cs_zone_rm}

**仅限多专区集群**：从集群中的所有工作程序池中除去专区。这将删除工作程序池中此专区的所有工作程序节点。

在除去专区之前，请确保集群的其他专区中有足够的工作程序节点，以便可以重新安排 pod，以帮助避免因工作程序节点上的应用程序或数据损坏而产生的停机时间。
{: tip}

<strong>命令选项</strong>：

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>要添加的专区。必须是集群区域内的[支持多专区的专区](cs_regions.html#zones)。此值是必需的。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>集群的名称或标识。此值是必需的。</dd>

  <dt><code>-f</code></dt>
    <dd>强制更新，而不显示用户提示。此值是可选的。</dd>

  <dt><code>-s</code></dt>
    <dd>不显示每日消息或更新提示。此值是可选的。</dd>
</dl>

**示例**：

  ```
  ibmcloud ks zone-rm --zone dal10 --cluster my_cluster
  ```
  {: pre}
