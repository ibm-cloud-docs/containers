---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-12"

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


# 将 {{site.data.keyword.containerlong_notm}} 用于 {{site.data.keyword.Bluemix_notm}} Private
{: #hybrid_iks_icp}

如果您有 {{site.data.keyword.Bluemix}} Private 帐户，那么可以将其用于精选 {{site.data.keyword.Bluemix_notm}} 服务，包括 {{site.data.keyword.containerlong}}。有关更多信息，请参阅[跨 {{site.data.keyword.Bluemix_notm}} Private 和 IBM Public Cloud 的混合体验 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://ibm.biz/hybridJune2018)。
{: shortdesc}

您已了解了 [{{site.data.keyword.Bluemix_notm}} 产品](cs_why.html#differentiation)。现在，可以[连接公共云和私有云](#hybrid_vpn)，并可[复用公共容器的专用包](#hybrid_ppa_importer)。

## 使用 strongSwan VPN 连接公共云和私有云
{: #hybrid_vpn}

在公共 Kubernetes 集群与 {{site.data.keyword.Bluemix}} Private 实例之间建立 VPN 连接，以允许双向通信。
{: shortdesc}

1.  在 {{site.data.keyword.Bluemix_notm}} Public 中通过 {{site.data.keyword.containerlong}} 创建标准集群，或使用现有集群。要创建集群，有以下选项可供选择： 
    - [通过 GUI 创建标准集群](cs_clusters.html#clusters_ui)。 
    - [通过 CLI 创建标准集群](cs_clusters.html#clusters_cli)。 
    - [使用 Cloud Automation Manager (CAM) 通过预定义模板创建集群 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/SS2L37_2.1.0.3/cam_deploy_IKS.html)。使用 CAM 部署集群时，会自动安装 Helm Tiller。

2.  在 {{site.data.keyword.containerlong_notm}} 集群中，[遵循指示信息设置 strongSwan IPSec VPN 服务](cs_vpn.html#vpn_configure)。 

    *  对于[步骤 2](cs_vpn.html#strongswan_2)，请注意：

       * 在 {{site.data.keyword.containerlong_notm}} 集群中设置的 `local.id` 必须与稍后在 {{site.data.keyword.Bluemix}} Private 集群中设置为 `remote.id` 的内容相匹配。 
       * 在 {{site.data.keyword.containerlong_notm}} 集群中设置的 `remote.id` 必须与稍后在 {{site.data.keyword.Bluemix}} Private 集群中设置为 `local.id` 的内容相匹配。
       * 在 {{site.data.keyword.containerlong_notm}} 集群中设置的 `preshared.secret` 必须与稍后在 {{site.data.keyword.Bluemix}} Private 集群中设置为 `preshared.secret` 的内容相匹配。

    *  对于[步骤 3](cs_vpn.html#strongswan_3)，为**入站** VPN 连接配置 strongSwan。

       ```
       ipsec.auto: add
       loadBalancerIP: <portable_public_IP>
       ```
       {: codeblock}

3.  记下您设置为 `loadbalancerIP` 的可移植公共 IP 地址。

    ```
    kubectl get svc vpn-strongswan
    ```
    {: pre}

4.  [在 {{site.data.keyword.Bluemix_notm}} Private 中创建集群 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/installing/installing.html)。

5.  在 {{site.data.keyword.Bluemix_notm}} Private 集群中，部署 strongSwan IPSec VPN 服务。

    1.  [完成 strongSwan IPSec VPN 变通方法 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/SS2L37_2.1.0.3/cam_strongswan.html)。 

    2.  在专用集群中[设置 strongSwan VPN Helm 图表 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/app_center/create_release.html)。 
    
        *  在配置参数中，将**远程网关**字段设置为您设置为 {{site.data.keyword.containerlong_notm}} 集群的 `loadbalancerIP` 的可移植公共 IP 地址的值。
    
           ```
           Operation at startup: start
           ...
           Remote gateway: <portable_public_IP>
           ...
           ```
           {: codeblock}
    
        *  请记住，专用 `local.id` 必须与公共 `remote.id` 相匹配，专用 `remote.id` 必须与公共 `local.id` 相匹配，并且专用和公共的 `preshared.secret` 值必须相匹配。
        
        现在，可以启动从 {{site.data.keyword.Bluemix_notm}} Private 集群到 {{site.data.keyword.containerlong_notm}} 集群的连接。

7.  在集群之间[测试 VPN 连接](cs_vpn.html#vpn_test)。

8.  针对要连接的每个集群，重复上述步骤。 


## 在公共 Kubernetes 容器中运行 {{site.data.keyword.Bluemix_notm}} Private 映像
{: #hybrid_ppa_importer}

可以在 {{site.data.keyword.Bluemix_notm}} Public 的集群中，运行针对 {{site.data.keyword.Bluemix_notm}} Private 打包的精选许可 IBM 产品。  
{: shortdesc}

许可的软件在 [IBM Passport Advantage ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www-01.ibm.com/software/passportadvantage/index.html) 中提供。要在 {{site.data.keyword.Bluemix_notm}} Public 的集群中使用此软件，必须下载此软件，解压缩映像，然后将映像上传到 {{site.data.keyword.registryshort}} 中的名称空间。不管计划使用软件的环境是什么，都必须首先获取必需的产品许可证。 

下表概述了可在 {{site.data.keyword.Bluemix_notm}} Public 的集群中使用的可用 {{site.data.keyword.Bluemix_notm}} Private 产品。

|产品名称|版本|部件号|
| --- | --- | --- |
|IBM Db2 Direct Advanced Edition Server|11.1|CNU3TML|
|IBM Db2 Advanced Enterprise Server Edition Server|11.1|CNU3SML|
|IBM MQ Advanced|9.0.5|CNU1VML|
|IBM WebSphere Application Server Liberty|16.0.0.3|Docker Hub 映像|
{: caption="表. 可在 {{site.data.keyword.Bluemix_notm}} Public 中使用的受支持 {{site.data.keyword.Bluemix_notm}} Private 产品。" caption-side="top"}

开始之前： 
- [安装 {{site.data.keyword.registryshort}} CLI 插件 (`ibmcloud cr`)](/docs/services/Registry/registry_setup_cli_namespace.html#registry_cli_install)。 
- [在 {{site.data.keyword.registryshort}} 中设置名称空间](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)，或通过运行 `ibmcloud cr namespaces` 来检索现有名称空间。 
- [设定 `kubectl` CLI 的目标为集群](/docs/containers/cs_cli_install.html#cs_cli_configure)。 
- [在集群中安装 Helm CLI 并设置 Tiller](/docs/containers/cs_integrations.html#helm)。 

要在 {{site.data.keyword.Bluemix_notm}} Public 的集群中部署 {{site.data.keyword.Bluemix_notm}} Private 映像，请执行以下操作：

1.  执行 [{{site.data.keyword.registryshort}} 文档](/docs/services/Registry/ts_index.html#ts_ppa)中的步骤从 IBM Passport Advantage 下载许可软件，将映像推送到名称空间，然后在集群中安装 Helm 图表。 

    **对于 IBM WebSphere Application Server Liberty**：
    
    1.  不要从 IBM Passport Advantage 获取映像，请改为使用 [Docker Hub 映像 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://hub.docker.com/_/websphere-liberty/)。有关获取生产许可证的指示信息，请参阅[将映像从 Docker Hub 升级到生产映像 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/WASdev/ci.docker/tree/master/ga/production-upgrade)。
    
    2.  遵循 [Liberty Helm 图表指示信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/rwlp_icp_helm.html) 进行操作。 

2.  验证 Helm 图表的 **STATUS** 是否显示 `DEPLOYED`。如果未显示，请等待几分钟，然后重试。
    ```
    helm status <helm_chart_name>
    ```
    {: pre}
   
3.  有关如何配置产品并将其用于集群的更多信息，请参阅特定于产品的文档。 

    - [IBM Db2 Direct Advanced Edition Server ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.licensing.doc/doc/c0070181.html) 
    - [IBM MQ Advanced ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.0.0/com.ibm.mq.helphome.v90.doc/WelcomePagev9r0.html)
    - [IBM WebSphere Application Server Liberty ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/as_ditamaps/was900_welcome_liberty.html)
