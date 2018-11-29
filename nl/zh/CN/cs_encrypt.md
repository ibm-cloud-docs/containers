---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 保护集群中的敏感信息
{: #encryption}

缺省情况下，{{site.data.keyword.containerlong}} 集群使用加密磁盘来存储信息，例如 `etcd` 中的配置或在工作程序节点辅助磁盘上运行的容器文件系统。部署应用程序时，请勿在 YAML 配置文件、配置映射或脚本中存储保密信息，例如凭证或密钥。请改为使用 [Kubernetes 私钥 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/secret/)。您还可以对 Kubernetes 私钥中的数据进行加密，以防止未经授权的用户访问敏感集群信息。
{: shortdesc}

有关保护集群的更多信息，请参阅 [{{site.data.keyword.containerlong_notm}} 的安全性](cs_secure.html#security)。



## 了解何时使用私钥
{: #secrets}

Kubernetes 私钥是一种存储保密信息（如用户名、密码或密钥）的安全方法。如果您需要加密保密信息，请[启用 {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) 以加密私钥。有关在私钥中可以存储哪些内容的更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/secret/)。
{:shortdesc}

查看以下需要私钥的任务。

### 向集群添加服务
{: #secrets_service}

将服务绑定到集群时，无需创建私钥来存储服务凭证。系统将自动创建私钥。有关更多信息，请参阅[向集群添加 Cloud Foundry 服务](cs_integrations.html#adding_cluster)。

### 使用 TLS 私钥加密流至应用程序的流量
{: #secrets_tls}

ALB 会对流至集群中应用程序的 HTTP 网络流量进行负载均衡。要同时对入局 HTTPS 连接进行负载均衡，可以配置 ALB 来解密网络流量，然后将已解密的请求转发到集群中公开的应用程序。有关更多信息，请参阅 [Ingress 配置文档](cs_ingress.html#public_inside_3)。

此外，如果您具有需要 HTTPS 协议且需要流量保持加密的应用程序，那么可以将单向或相互认证私钥与 `ssl-services` 注释一起使用。有关更多信息，请参阅 [Ingress 注释文档](cs_annotations.html#ssl-services)。

### 使用存储在 Kubernetes `imagePullSecret` 中的凭证访问注册表
{: #imagepullsecret}

创建集群时，会在 Kubernetes 名称空间 `default` 中自动为您创建 {{site.data.keyword.registrylong}} 凭证的私钥。但是，如果要在以下情况下部署容器，那么必须[为集群创建您自己的 imagePullSecret](cs_images.html#other)。
* 在非 `default` 的 Kubernetes 名称空间中，基于 {{site.data.keyword.registryshort_notm}} 注册表中的映像。
* 基于 {{site.data.keyword.registryshort_notm}} 注册表中存储在其他 {{site.data.keyword.Bluemix_notm}} 区域或 {{site.data.keyword.Bluemix_notm}} 帐户中的映像。
* 基于存储在 {{site.data.keyword.Bluemix_notm}} Dedicated 帐户中的映像。
* 基于存储在外部专用注册表中的映像。

<br />


## 使用 {{site.data.keyword.keymanagementserviceshort}} 加密 Kubernetes 私钥
{: #keyprotect}

通过在集群中将 [{{site.data.keyword.keymanagementservicefull}} ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](/docs/services/key-protect/index.html#getting-started-with-key-protect) 用作[密钥管理服务 (KMS) 提供程序 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/)，可以对 Kubernetes 私钥进行加密。
KMS 提供程序是 Kubernetes V1.10 和 V1.11 中的 Alpha 功能部件。
{: shortdesc}

缺省情况下，Kubernetes 私钥存储在 IBM 管理的 Kubernetes 主节点的 `etcd` 组件中的加密磁盘上。工作程序节点还具有由 IBM 管理的 LUKS 密钥（在集群中存储为私钥）加密的辅助磁盘。在集群中启用 {{site.data.keyword.keymanagementserviceshort}} 时，会使用您自己的根密钥来加密 Kubernetes 私钥，包括 LUKS 私钥。通过使用根密钥对私钥进行加密，您对敏感数据具有更多控制权。使用您自己的加密可为 Kubernetes 私钥多添加一层安全性，并让您能够更详细地控制哪些用户可以访问敏感集群信息。如果您需要不可撤销地除去对您私钥的访问权，那么可以删除根密钥。

**重要信息**：如果删除 {{site.data.keyword.keymanagementserviceshort}} 实例中的根密钥，那么删除之后您将无法访问或除去集群中私钥的数据。

开始之前：
* [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。
* 通过运行 `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` 并查看 **Version** 字段，以检查集群是否运行的是 Kubernetes V1.10.8_1524、V1.11.3_1521 或更高版本。
* 验证您是否具有[**管理员**许可权](cs_users.html#access_policies)来完成这些步骤。
* 确保为集群所在区域设置的 API 密钥有权使用 Key Protect。要检查为该区域存储其凭证的 API 密钥所有者，请运行 `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`。

要启用 {{site.data.keyword.keymanagementserviceshort}}，更新实例或更新用于加密集群中私钥的根密钥，请执行以下操作：

1.  [创建 {{site.data.keyword.keymanagementserviceshort}} 实例](/docs/services/key-protect/provision.html#provision)。

2.  获取服务实例标识。

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [创建根密钥](/docs/services/key-protect/create-root-keys.html#create-root-keys)。缺省情况下，会创建没有到期日期的根密钥。

    需要设置到期日期以符合内部安全策略吗？请[使用 API 创建根密钥](/docs/services/key-protect/create-root-keys.html#api)，并包含 `expirationDate` 参数。**重要信息**：在根密钥到期之前，必须重复这些步骤以将集群更新为使用新的根密钥。否则，无法对私钥进行解密。
    {: tip}

4.  记下[根密钥**标识**](/docs/services/key-protect/view-keys.html#gui)。

5.  获取实例的 [{{site.data.keyword.keymanagementserviceshort}} 端点](/docs/services/key-protect/regions.html#endpoints)。

6.  获取要为其启用 {{site.data.keyword.keymanagementserviceshort}} 的集群的名称。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  在集群中启用 {{site.data.keyword.keymanagementserviceshort}}。使用先前检索到的信息填写标志。

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

在集群中启用 {{site.data.keyword.keymanagementserviceshort}} 后，系统会使用 {{site.data.keyword.keymanagementserviceshort}} 根密钥自动对集群中创建的现有私钥和新私钥进行加密。您可以随时通过使用新的根密钥标识重复这些步骤来轮换密钥。
