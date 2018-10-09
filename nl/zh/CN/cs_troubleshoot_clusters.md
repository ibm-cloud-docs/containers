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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# 集群和工作程序节点故障诊断
{: #cs_troubleshoot_clusters}

在使用 {{site.data.keyword.containerlong}} 时，请考虑对集群和工作程序节点进行故障诊断的以下方法。
{: shortdesc}

如果您有更常规的问题，请尝试[集群调试](cs_troubleshoot.html)。
{: tip}

## 无法连接到 Infrastructure 帐户
{: #cs_credentials}

{: tsSymptoms}
创建新的 Kubernetes 集群时，会收到类似于下列其中一项的错误消息。

```
我们无法连接到您的 IBM Cloud Infrastructure (SoftLayer) 帐户。创建标准集群要求您有链接到 IBM Cloud Infrastructure (SoftLayer) 帐户条款的现买现付帐户，或者您已使用 {{site.data.keyword.containerlong_notm}} CLI 设置 {{site.data.keyword.Bluemix_notm}} 基础架构 API 密钥。
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure 异常：必须具有许可权才能订购“项”。
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure 异常：用户没有必需的 {{site.data.keyword.Bluemix_notm}} Infrastructure 许可权来添加服务器
```
{: screen}

```
IAM 令牌交换请求失败：无法创建 IMS 门户网站令牌，因为没有 IMS 帐户链接到所选的 BSS 帐户
```
{: screen}

{: tsCauses}
在自动帐户链接启用后创建的 {{site.data.keyword.Bluemix_notm}} 现买现付帐户已设置有对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。您可以为集群购买基础架构资源，而无需额外配置。
如果您有有效的现买现付帐户，但收到此错误消息，说明可能未使用正确的 IBM Cloud Infrastructure (SoftLayer) 帐户凭证来访问基础架构资源。

具有其他 {{site.data.keyword.Bluemix_notm}} 帐户类型的用户必须配置其帐户以创建标准集群。以下是您可能具有不同帐户类型的情况的示例：
* 您具有日期早于 {{site.data.keyword.Bluemix_notm}} 平台帐户的现有 IBM Cloud infrastructure (SoftLayer) 帐户，并且想要继续使用此帐户。
* 您想要使用不同的 IBM Cloud infrastructure (SoftLayer) 帐户来供应基础架构资源。例如，您可以设置团队 {{site.data.keyword.Bluemix_notm}} 帐户以将不同的基础架构帐户用于计费。

{: tsResolve}
帐户所有者必须正确设置基础架构帐户凭证。凭证取决于使用的基础架构帐户的类型。

**开始之前**：

1.  验证您是否有权访问基础架构帐户。登录到 [{{site.data.keyword.Bluemix_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/)，然后在可展开的菜单中，单击**基础架构**。如果看到基础架构仪表板，说明您有权访问基础架构帐户。
2.  检查集群使用的是否是与现买现付帐户随附的基础架构帐户不同的基础架构帐户。
    1.  在可展开的菜单中，单击**容器 > 集群**。
    2.  从表中选择您的集群。
    3.  在**概述**选项卡中，检查**基础架构用户**字段。
        * 如果看不到**基础架构用户**字段，那么会有一个链接的现买现付帐户，此帐户将相同的凭证用于基础架构和平台帐户。
        * 如果看到**基础架构用户**字段，那么集群使用的基础架构帐户与现买现付帐户随附的基础架构帐户不同。这些不同的凭证应用于区域中的所有集群。 
3.  决定您想要具有哪种类型的帐户以确定如何对基础架构许可权问题进行故障诊断。对于大多数用户，缺省链接的现买现付帐户就已足够。
    *  链接的现买现付 {{site.data.keyword.Bluemix_notm}} 帐户：[验证基础架构 API 密钥是否设置有正确的许可权](#apikey)。如果集群正在使用其他基础架构帐户，那么必须在此过程中取消设置这些凭证。
    *  其他 {{site.data.keyword.Bluemix_notm}} 平台和基础架构帐户：验证您是否可以访问基础架构产品服务组合，以及是否[基础架构帐户凭证设置有正确的许可权](#credentials)。

### 将缺省基础架构凭证用于具有 API 密钥的链接的现买现付帐户
{: #apikey}

1.  验证要将其凭证用于基础架构操作的用户是否具有正确的许可权。

    1.  登录到 [{{site.data.keyword.Bluemix_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/)。

    2.  在展开的菜单中，选择**基础架构**。

    3.  在菜单栏中，选择**帐户** > **用户** > **用户列表**。

    4.  在 **API 密钥**列中，验证用户是否具有 API 密钥，如果没有，请单击**生成**。

    5.  验证用户是否具有[正确的基础架构许可权](cs_users.html#infra_access)，如果没有，为用户分配正确的基础架构许可权。

2.  为集群所在的区域设置 API 密钥。

    1.  使用要使用其基础架构许可权的用户登录到终端。
    
    2.  如果您位于其他区域，请切换到要设置 API 密钥的区域。
    
        ```
        ibmcloud ks region-set
        ```
        {: pre}

    3.  设置该区域的用户 API 密钥。
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    

    4.  验证 API 密钥是否已设置。
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

3.  **可选**：如果您的现买现付帐户使用其他基础架构帐户来供应集群（例如，使用 `ibmcloud ks credentials-set` 命令），那么帐户继续使用这些基础架构凭证，而不是 API 密钥。您必须除去关联的基础架构帐户，从而使用在先前步骤中设置的 API 密钥。
    ```
        ibmcloud ks credentials-unset
        ```
    {: pre}
        
4.  **可选**：如果将公共集群连接到内部部署资源，请检查网络连接。

    1.  检查工作程序 VLAN 连接。
    2.  如果需要，请[设置 VPN 连接](cs_vpn.html#vpn)。
    3.  [在防火墙中打开必需的端口](cs_firewall.html#firewall)。

### 为其他平台和基础架构帐户配置基础架构凭证
{: #credentials}

1.  获取要用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的基础架构帐户。根据您当前的帐户类型，您会有不同的选项。

    <table summary="该表显示了按帐户类型列出的标准集群创建选项。每行从左到右阅读，其中第一列是帐户描述，第二列是用于创建标准集群的选项。">
    <caption>按帐户类型列出的标准集群创建选项</caption>
      <thead>
      <th>帐户描述</th>
      <th>用于创建标准集群的选项</th>
      </thead>
      <tbody>
        <tr>
          <td>**轻量帐户**无法供应集群。</td>
          <td>[将 Lite 帐户升级到 {{site.data.keyword.Bluemix_notm}} 现买现付帐户](/docs/account/index.html#paygo)，该帐户设置为具有对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。</td>
        </tr>
        <tr>
          <td>**最近的现买现付帐户**随附对基础架构产品服务组合的访问权。</td>
          <td>可以创建标准集群。要对基础架构许可权进行故障诊断，请参阅[为链接的帐户配置基础架构 API 凭证](#apikey)。</td>
        </tr>
        <tr>
          <td>**较旧的现买现付帐户**是在自动帐户链接可用之前创建的帐户，这种帐户不随附对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。<p>如果您有现有的 IBM Cloud Infrastructure (SoftLayer) 帐户，那么无法将此帐户链接到较旧的现买现付帐户。</p></td>
          <td><p><strong>选项 1：</strong>[创建新的现买现付帐户](/docs/account/index.html#paygo)，该帐户设置为具有对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。选择此选项时，您有两个单独的 {{site.data.keyword.Bluemix_notm}} 帐户和帐单。</p><p>要继续使用旧的现买现付帐户，可以使用新的现买现付帐户生成 API 密钥，以用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。</p><p><strong>选项 2：</strong>如果您已经拥有要使用的现有 IBM Cloud Infrastructure (SoftLayer) 帐户，那么可以在 {{site.data.keyword.Bluemix_notm}} 帐户中设置凭证。</p><p>**注：**手动链接到 IBM Cloud Infrastructure (SoftLayer) 帐户时，凭证用于 {{site.data.keyword.Bluemix_notm}} 帐户中每个特定于 IBM Cloud Infrastructure (SoftLayer) 的操作。您必须确保设置的 API 密钥具有[足够的基础架构许可权](cs_users.html#infra_access)，以便用户可以创建和使用集群。</p><p>**对于这两个选项，都请继续执行下一步**。</p></td>
        </tr>
        <tr>
          <td>**预订帐户**未设置为具有对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。</td>
          <td><p><strong>选项 1：</strong>[创建新的现买现付帐户](/docs/account/index.html#paygo)，该帐户设置为具有对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。选择此选项时，您有两个单独的 {{site.data.keyword.Bluemix_notm}} 帐户和帐单。</p><p>如果要继续使用预订帐户，那么可以使用新的现买现付帐户在 IBM Cloud Infrastructure (SoftLayer) 中生成 API 密钥。然后，必须手动为预订帐户设置 IBM Cloud Infrastructure (SoftLayer) API 密钥。请记住，IBM Cloud Infrastructure (SoftLayer) 资源将通过新的现买现付帐户进行计费。</p><p><strong>选项 2：</strong>如果您已经拥有要使用的现有 IBM Cloud Infrastructure (SoftLayer) 帐户，那么可以为 {{site.data.keyword.Bluemix_notm}} 帐户手动设置 IBM Cloud Infrastructure (SoftLayer) 凭证。</p><p>**注：**手动链接到 IBM Cloud Infrastructure (SoftLayer) 帐户时，凭证用于 {{site.data.keyword.Bluemix_notm}} 帐户中每个特定于 IBM Cloud Infrastructure (SoftLayer) 的操作。您必须确保设置的 API 密钥具有[足够的基础架构许可权](cs_users.html#infra_access)，以便用户可以创建和使用集群。</p><p>**对于这两个选项，都请继续执行下一步**。</p></td>
        </tr>
        <tr>
          <td>**IBM Cloud infrastructure (SoftLayer) 帐户**，无 {{site.data.keyword.Bluemix_notm}} 帐户</td>
          <td><p>[创建 {{site.data.keyword.Bluemix_notm}} 现买现付帐户](/docs/account/index.html#paygo)，该帐户设置为具有对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。选择此选项时，将为您创建 IBM Cloud Infrastructure (SoftLayer) 帐户。您有两个独立的 IBM Cloud Infrastructure (SoftLayer) 帐户，两者单独进行计费。</p><p>缺省情况下，新的 {{site.keyword.data.Bluemix_notm}} 帐户将使用新的基础架构帐户。要继续使用旧基础架构帐户，请继续执行下一步。</p></td>
        </tr>
      </tbody>
      </table>

2.  验证要将其凭证用于基础架构操作的用户是否具有正确的许可权。

    1.  登录到 [{{site.data.keyword.Bluemix_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/)。

    2.  在展开的菜单中，选择**基础架构**。

    3.  在菜单栏中，选择**帐户** > **用户** > **用户列表**。

    4.  在 **API 密钥**列中，验证用户是否具有 API 密钥，如果没有，请单击**生成**。

    5.  验证用户是否具有[正确的基础架构许可权](cs_users.html#infra_access)，如果没有，为用户分配正确的基础架构许可权。

3.  为正确帐户的用户设置基础架构 API 凭证。

    1.  获取用户的基础架构 API 凭证。**注**：凭证与 IBM 标识不同。

        1.  在 [{{site.data.keyword.Bluemix_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/) 的**基础架构** > **帐户** > **用户** > **用户列表**表中，单击 **IBM 标识或用户名**。

        2.  在 **API 访问信息**部分中，查看 **API 用户名**和**认证密钥**。    

    2.  设置要使用的基础架构 API 凭证。
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

4.  **可选**：如果将公共集群连接到内部部署资源，请检查网络连接。

    1.  检查工作程序 VLAN 连接。
    2.  如果需要，请[设置 VPN 连接](cs_vpn.html#vpn)。
    3.  [在防火墙中打开必需的端口](cs_firewall.html#firewall)。

<br />


## 防火墙阻止 CLI 命令运行
{: #ts_firewall_clis}

{: tsSymptoms}
通过 CLI 运行 `ibmcloud`、`kubectl` 或 `calicoctl` 命令时，这些命令会失败。

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
您可能已在 IBM Cloud Infrastructure (SoftLayer) 帐户中设置了其他防火墙或定制了现有防火墙设置。{{site.data.keyword.containerlong_notm}} 需要打开特定 IP 地址和端口，以允许工作程序节点与 Kubernetes 主节点之间进行通信。另一个原因可能是工作程序节点陷入重新装入循环。

{: tsResolve}
[允许集群访问基础架构资源和其他服务](cs_firewall.html#firewall_outbound)。此任务需要[管理员访问策略](cs_users.html#access_policies)。验证您当前的[访问策略](cs_users.html#infra_access)。

<br />



## 使用 SSH 访问工作程序节点失败
{: #cs_ssh_worker}

{: tsSymptoms}
使用 SSH 连接无法访问工作程序节点。

{: tsCauses}
通过密码进行 SSH 在工作程序节点上不可用。

{: tsResolve}
将 [DaemonSets ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) 用于必须在每个节点上运行的操作，或者将作业用于必须运行的一次性操作。

<br />


## 裸机实例标识与工作程序记录不一致
{: #bm_machine_id}

{: tsSymptoms}
对裸机工作程序节点使用 `ibmcloud ks worker` 命令时，将看到类似于以下内容的消息。

```
实例标识与工作程序记录不一致
```
{: screen}

{: tsCauses}
机器遇到硬件问题时，机器标识可能会与 {{site.data.keyword.containerlong_notm}} 工作程序记录不一致。IBM Cloud Infrastructure (SoftLayer) 解决此问题时，组件可能会在服务无法识别的系统内更改。

{: tsResolve}
要使 {{site.data.keyword.containerlong_notm}} 重新识别到机器，请[重新装入裸机工作程序节点](cs_cli_reference.html#cs_worker_reload)。**注**：重新装入还会更新机器的[补丁版本](cs_versions_changelog.html)。

您还可以[删除裸机工作程序节点](cs_cli_reference.html#cs_cluster_rm)。**注**：裸机实例按月计费。

<br />


## `kubectl` 命令超时
{: #exec_logs_fail}

{: tsSymptoms}
如果运行命令，例如，`kubectl exec`、`kubectl attach`、`kubectl proxy`、`kubectl port-forward` 或 `kubectl logs`，那么会看到以下消息。

  ```
  <workerIP>:10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
主节点与工作程序节点之间的 OpenVPN 连接工作不正常。

{: tsResolve}
1. 如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。
2. 重新启动 OpenVPN 客户机 pod。
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. 如果仍看到相同的错误消息，说明 VPN pod 所在的工作程序节点可能运行状况欠佳。要重新启动 VPN pod 并将其重新安排到其他工作程序节点，请[对工作程序节点执行 cordon、drain 和 reboot](cs_cli_reference.html#cs_worker_reboot)（即，对 VPN pod 所在的工作程序节点执行这些命令）。

<br />


## 将服务绑定到集群导致同名错误
{: #cs_duplicate_services}

{: tsSymptoms}
运行 `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` 时，会看到以下消息。

```
Multiple services with the same name were found.
请运行“ibmcloud service list”以查看可用的 Bluemix 服务实例...
```
{: screen}

{: tsCauses}
多个服务实例可能在不同区域中具有相同名称。

{: tsResolve}
在 `ibmcloud ks cluster-service-bind` 命令中，请使用服务 GUID，而不要使用服务实例名称。

1. [登录到包含要绑定的服务实例的区域](cs_regions.html#bluemix_regions)。

2. 获取服务实例的 GUID。
  ```
  ibmcloud service show <service_instance_name> --guid
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
  ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />


## 将服务绑定到集群导致找不到服务错误
{: #cs_not_found_services}

{: tsSymptoms}
运行 `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` 时，会看到以下消息。

```
Binding service to a namespace...
FAILED

The specified IBM Cloud service could not be found. If you just created the service, wait a little and then try to bind it again. 要查看可用的 IBM Cloud 服务实例，请运行“ibmcloud service list”。(E0023)
```
{: screen}

{: tsCauses}
要将服务绑定到集群，您必须具有在其中供应服务实例的空间的 Cloud Foundry 开发者用户角色。此外，您必须具有对 {{site.data.keyword.containerlong}} 的 IAM 编辑者访问权。要访问服务实例，您必须登录到在其中供应该服务实例的空间。

{: tsResolve}

**以用户身份执行以下操作：**

1. 登录到 {{site.data.keyword.Bluemix_notm}}。
   ```
   ibmcloud login
   ```
   {: pre}

2. 将在其中供应服务实例的组织和空间设定为目标。
   ```
   ibmcloud target -o <org> -s <space>
   ```
   {: pre}

3. 通过列出服务实例来验证您是否位于正确的空间中。
   ```
   ibmcloud service list
   ```
   {: pre}

4. 重试绑定服务。如果遇到相同的错误，请联系帐户管理员，并验证您是否具有足够的许可权来绑定服务（请参阅以下帐户管理员步骤）。

**以帐户管理员身份执行以下操作：**

1. 验证遇到此问题的用户是否具有[对 {{site.data.keyword.containerlong}} 的编辑者许可权](/docs/iam/mngiam.html#editing-existing-access)。

2. 验证遇到此问题的用户是否具有对在其中供应该服务的[空间的 Cloud Foundry 开发者角色](/docs/iam/mngcf.html#updating-cloud-foundry-access)。

3. 如果存在正确的许可权，请尝试分配其他许可权，然后重新分配所需的许可权。

4. 稍等几分钟，然后让用户重试绑定服务。

5. 如果这无法解决此问题，说明 IAM 许可权不同步，您无法自行解决此问题。请通过开具支持凭单来[联系 IBM 支持](/docs/get-support/howtogetsupport.html#getting-customer-support)。确保提供集群标识、用户标识和服务实例标识。
   1. 检索集群标识。
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. 检索服务实例标识。
      ```
      ibmcloud service show <service_name> --guid
      ```
      {: pre}


<br />


## 将服务绑定到集群将导致服务不支持服务密钥错误
{: #cs_service_keys}

{: tsSymptoms}
运行 `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` 时，会看到以下消息。

```
This service doesn't support creation of keys
```
{: screen}

{: tsCauses}
{{site.data.keyword.Bluemix_notm}} 中的某些服务（例如，{{site.data.keyword.keymanagementservicelong}}）不支持创建服务凭证，也称为服务密钥。如果不支持服务密钥，那么服务不可绑定到集群。要查找支持创建服务密钥的服务的列表，请参阅[使外部应用程序能够使用 {{site.data.keyword.Bluemix_notm}} 服务](/docs/apps/reqnsi.html#accser_external)。

{: tsResolve}
要集成不支持服务密钥的服务，请检查服务是否提供可用于直接从应用程序访问服务的 API。例如，如果想要使用 {{site.data.keyword.keymanagementservicelong}}，请参阅 [API 引用 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/apidocs/kms?language=curl)。 

<br />


## 工作程序节点更新或重新装入后，出现重复的节点和 pod
{: #cs_duplicate_nodes}

{: tsSymptoms}
运行 `kubectl get nodes` 时，看到状态为 **NotReady** 的重复工作程序节点。状态为 **NotReady** 的工作程序节点具有公共 IP 地址，而状态为 **Ready** 的工作程序节点具有专用 IP 地址。

{: tsCauses}
较旧的集群按集群的公共 IP 地址列出工作程序节点。现在，工作程序节点按集群的专用 IP 地址列出。当您重新装入或更新节点时，IP 地址将更改，但对公共 IP 地址的引用将保持不变。

{: tsResolve}
由于存在这些重复项，因此服务不会中断，但您可以从 API 服务器中除去旧的工作程序节点引用。

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

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
  ibmcloud ks workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Zone   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.7
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.7
  ```
  {: screen}

2.  安装 [Calico CLI](cs_network_policy.html#adding_network_policies)。
3.  列出 Calico 中的可用工作程序节点。将 <path_to_file> 替换为 Calico 配置文件的本地路径。

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  删除 Calico 中的重复工作程序节点。将 NODE_ID 替换为工作程序节点标识。

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  重新引导未删除的工作程序节点。

  ```
  ibmcloud ks worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


已删除的节点不会再在 Calico 中列出。

<br />




## 因 pod 安全策略导致 pod 部署失败
{: #cs_psp}

{: tsSymptoms}
创建 pod 或运行 `kubectl get events` 来检查 pod 部署后，您会看到类似以下内容的错误消息。

```
无法根据任何 pod 安全策略进行验证
```
{: screen}

{: tsCauses}
[`PodSecurityPolicy` 许可控制器](cs_psp.html)会检查尝试创建 pod 的用户或服务帐户的授权，例如部署或 Helm Tiller。如果没有 pod 安全策略支持用户或服务帐户，那么 `PodSecurityPolicy` 许可控制器会阻止创建 pod。

如果已删除 [{{site.data.keyword.IBM_notm}} 集群管理](cs_psp.html#ibm_psp)的其中一个 pod 安全策略资源，那么可能会遇到类似问题。

{: tsResolve}
确保用户或服务帐户通过 pod 安全策略授权。您可能需要[修改现有策略](cs_psp.html#customize_psp)。

如果已删除 {{site.data.keyword.IBM_notm}} 集群管理资源，请刷新 Kubernetes 主节点以将其复原。

1.  [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。
2.  刷新 Kubernetes 主节点以将其复原。

    ```
    ibmcloud ks apiserver-refresh
    ```
    {: pre}


<br />




## 集群保持暂挂状态
{: #cs_cluster_pending}

{: tsSymptoms}
部署集群时，集群保持暂挂状态，而不启动。

{: tsCauses}
如果刚刚创建了集群，那么工作程序节点可能仍在配置中。如果您已经等待一段时间，那么可能是 VLAN 无效。

{: tsResolve}

可以尝试下列其中一个解决方案：
  - 通过运行 `ibmcloud ks clusters` 来检查集群的阶段状态。然后，通过运行 `ibmcloud ks workers <cluster_name>`.
  - 检查以确定 VLAN 是否有效。要使 VLAN 有效，必须将 VLAN 与可使用本地磁盘存储来托管工作程序的基础架构相关联。可以通过运行 `ibmcloud ks vlans <zone>` 来[列出 VLAN](/docs/containers/cs_cli_reference.html#cs_vlans)，如果 VLAN 未显示在列表中，说明该 VLAN 无效。请选择其他 VLAN。

<br />


## Pod 保持暂挂状态
{: #cs_pods_pending}

{: tsSymptoms}
运行 `kubectl get pods` 时，可能看到 pod 保持**暂挂**状态。

{: tsCauses}
如果刚刚创建了 Kubernetes 集群，那么工作程序节点可能仍在配置中。 

如果这是现有集群：
*  那么可能是集群中没有足够的容量来部署 pod。
*  pod 可能已超出资源请求或限制。

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

4.  如果集群中没有足够的容量，请调整工作程序池的大小以添加更多节点。

    1.  查看工作程序池的当前大小和机器类型，以决定要调整哪个工作程序池的大小。

        ```
        ibmcloud ks worker-pools
        ```
        {: pre}

    2.  调整工作程序池的大小，以将更多节点添加到池所跨的每个专区。

        ```
        ibmcloud ks worker-pool-resize <worker_pool> --cluster <cluster_name_or_ID> --size-per-zone <workers_per_zone>
        ```
        {: pre}

5.  可选：检查 pod 资源请求。

    1.  确认 `resources.requests` 值不大于工作程序节点的容量。例如，如果 pod 请求 `cpu: 4000m` 或 4 个核心，但是工作程序节点大小为仅 2 个核心，那么无法部署 pod。

        ```
        kubectl get pod <pod_name> -o yaml
        ```
        {: pre}
    
    2.  如果请求超过可用容量，那么使用可满足请求的工作程序节点[添加新的工作程序池](cs_clusters.html#add_pool)。

6.  如果在完全部署工作程序节点后，pod 仍然保持 **pending** 状态，请查看 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) 以进一步对 pod 的暂挂状态进行故障诊断。

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


## 获取帮助和支持
{: #ts_getting_help}

集群仍然有问题吗？
{: shortdesc}

-  在终端中，在 `ibmcloud` CLI 和插件更新可用时，会通知您。请确保保持 CLI 为最新，从而可使用所有可用命令和标志。

-   要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，请[检查 {{site.data.keyword.Bluemix_notm}} 状态页面 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/bluemix/support/#status)。
-   在 [{{site.data.keyword.containerlong_notm}} Slack ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://ibm-container-service.slack.com) 中发布问题。

如果未将 IBM 标识用于 {{site.data.keyword.Bluemix_notm}} 帐户，请针对此 Slack [请求邀请](https://bxcs-slack-invite.mybluemix.net/)。
    {: tip}
-   请复查论坛，以查看是否有其他用户遇到相同的问题。使用论坛进行提问时，请使用适当的标记来标注您的问题，以方便 {{site.data.keyword.Bluemix_notm}} 开发团队识别。

    -   如果您有关于使用 {{site.data.keyword.containerlong_notm}} 开发或部署集群或应用程序的技术问题，请在 [Stack Overflow ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) 上发布您的问题，并使用 `ibm-cloud`、`kubernetes` 和 `containers` 标记您的问题。
    -   有关服务的问题和入门指示信息，请使用 [IBM Developer Answers ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 论坛。请加上 `ibm-cloud` 和 `containers` 标记。
    有关使用论坛的更多详细信息，请参阅[获取帮助](/docs/get-support/howtogetsupport.html#using-avatar)。

-   通过开具凭单，与 IBM 支持联系。要了解有关开具 IBM 支持凭单或有关支持级别和凭单严重性的信息，请参阅[联系支持人员](/docs/get-support/howtogetsupport.html#getting-customer-support)。

{: tip}
报告问题时，请包含集群标识。要获取集群标识，请运行 `ibmcloud ks clusters`。

