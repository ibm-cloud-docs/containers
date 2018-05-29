---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

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


## 更新或重新装入工作程序节点后，应用程序收到 RBAC DENY 错误
{: #cs_rbac_deny}

{: tsSymptoms}
更新到 Kubernetes V1.7 后，应用程序收到 `RBAC DENY` 错误。

{: tsCauses}
从 [Kubernetes V1.7](cs_versions.html#cs_v17) 开始，在 `default` 名称空间中运行的应用程序不再具有对 Kubernetes API 的集群管理员特权，以提高安全性。

如果应用程序在 `default` 名称空间中运行，使用 `default ServiceAccount`，并且访问 Kubernetes API，那么此 Kubernetes 更改会对其产生影响。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/admin/authorization/rbac/#upgrading-from-15)。

{: tsResolve}
开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

1.  **临时操作**：更新应用程序 RBAC 策略时，您可能希望临时还原到 `default` 名称空间中 `default ServiceAccount` 的先前 `ClusterRoleBinding`。

    1.  复制以下 `.yaml` 文件。

        ```yaml
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-nonResourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-nonResourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-resourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-resourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ```

    2.  将 `.yaml` 文件应用于集群。

        ```
        kubectl apply -f FILENAME
        ```
        {: pre}

2.  [创建 RBAC 授权资源 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) 以更新 `ClusterRoleBinding` 管理访问权。

3.  如果创建了临时集群角色绑定，请将其除去。

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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.8.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.8.11
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
  - 通过运行 `bx cs cluster` 来检查集群的阶段状态。然后，通过运行 `bx cs workers <cluster_name>`.
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
  bx cs worker-add <cluster_name_or_ID> 1
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

-   要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，请[检查 {{site.data.keyword.Bluemix_notm}} 状态页面 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/bluemix/support/#status)。
-   在 [{{site.data.keyword.containershort_notm}} Slack ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://ibm-container-service.slack.com) 中发布问题。如果未将 IBM 标识用于 {{site.data.keyword.Bluemix_notm}} 帐户，请针对此 Slack [请求邀请](https://bxcs-slack-invite.mybluemix.net/)。
    {: tip}
-   请复查论坛，以查看是否有其他用户遇到相同的问题。使用论坛进行提问时，请使用适当的标记来标注您的问题，以方便 {{site.data.keyword.Bluemix_notm}} 开发团队识别。

    -   如果您有关于使用 {{site.data.keyword.containershort_notm}} 开发或部署集群或应用程序的技术问题，请在 [Stack Overflow ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) 上发布您的问题，并使用 `ibm-cloud`、`kubernetes` 和 `containers` 标记您的问题。
    -   有关服务的问题和入门指示信息，请使用 [IBM developerWorks dW Answers ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 论坛。请加上 `ibm-cloud` 和 `containers` 标记。
    有关使用论坛的更多详细信息，请参阅[获取帮助](/docs/get-support/howtogetsupport.html#using-avatar)。

-   通过开具凭单，与 IBM 支持联系。有关提交 IBM 支持凭单或支持级别和凭单严重性的信息，请参阅[联系支持人员](/docs/get-support/howtogetsupport.html#getting-customer-support)。

{:tip}
报告问题时，请包含集群标识。要获取集群标识，请运行 `bx cs clusters`。


