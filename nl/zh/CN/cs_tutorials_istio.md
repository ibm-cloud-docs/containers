---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# 教程：在 {{site.data.keyword.containerlong_notm}} 上安装 Istio
{: #istio_tutorial}

[Istio ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/info/istio) 是一种开放式平台，用于连接、保护、控制和观察云平台（例如，{{site.data.keyword.containerlong}} 中的 Kubernetes）上的服务。通过 Istio，可管理网络流量，在微服务之间进行负载均衡，强制实施访问策略，验证服务身份，等等。
{:shortdesc}

在本教程中，您可以查看如何为简单的模拟书店应用程序“BookInfo”安装 Istio 以及四个微服务。微服务包括产品 Web 页面、书籍详细信息、评论和评级。将 BookInfo 的微服务部署到安装了 Istio 的 {{site.data.keyword.containerlong}} 集群时，会在每个微服务的 pod 中注入 Istio Envoecar sidecar 代理。

## 目标

-   在集群中部署 Istio Helm 图表
-   部署 BookInfo 样本应用程序
-   通过评级服务的三个版本来验证 BookInfo 应用程序部署和循环

## 所需时间

30 分钟

## 受众

本教程适用于首次使用 Istio 的软件开发者和网络管理员。

## 先决条件

-  [安装 IBM Cloud CLI、{{site.data.keyword.containerlong_notm}} 插件和 Kubernetes CLI](cs_cli_install.html#cs_cli_install_steps)。确保安装与集群的 Kubernetes 版本相匹配的 `kubectl` CLI 版本。
-  [创建集群](cs_clusters.html#clusters_cli)。 
-  [设定 CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

## 第 1 课：下载并安装 Istio
{: #istio_tutorial1}

在集群中下载并安装 Istio。
{:shortdesc}

1. 使用 [IBM Istio Helm 图表 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm-charts/ibm-istio) 安装 Istio。
    1. [在集群中设置 Helm 并将 `ibm-charts` 存储库添加到 Helm 实例](cs_integrations.html#helm)。
    2.  ****仅限 Helm V2.9 或更低版本**：安装 Istio 的定制资源定义。
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. 将 Helm 图表安装到集群。
        ```
        helm install ibm-charts/ibm-istio --name=istio --namespace istio-system
        ```
        {: pre}

2. 确保在继续之前完全部署了全部 9 个 Istio 服务的 pod 和 Prometheus 的 pod。
    ```
   kubectl get pods -n istio-system
   ```
    {: pre}

    ```
    NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
    ```
    {: screen}

非常好！您已成功将 Istio 安装到集群中。接下来，将 BookInfo 样本应用程序部署到集群中。


## 第 2 课：部署 BookInfo 应用程序
{: #istio_tutorial2}

将 BookInfo 样本应用程序的微服务部署到 Kubernetes 集群。
{:shortdesc}

这四个微服务包括产品 Web 页面、书籍详细信息、评论（具有多个版本的评论微服务）和评级。部署 BookInfo 时，在部署微服务 pod 之前，Envoy sidecar 代理会作为容器注入到应用程序微服务的 pod 中。Istio 使用 Envoy 代理的扩展版本来调解服务网中所有微服务的所有入站和出站流量。有关 Envoy 的更多信息，请参阅 [Istio 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy)。

1. 下载包含必要 BookInfo 文件的 Istio 包。
    1. 直接从 [https://github.com/istio/istio/releases ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/istio/istio/releases) 下载 Istio 并解压缩安装文件，或使用 cURL 获取最新版本：
       ```
   curl -L https://git.io/getLatestIstio | sh -
   ```
       {: pre}

    2. 将目录切换到 Istio 文件位置。
       ```
       cd <filepath>/istio-1.0
       ```
       {: pre}

    3. 向 PATH 添加 `istioctl` 客户机。例如，在 MacOS 或 Linux 系统上运行以下命令：
        ```
       export PATH=$PWD/istio-1.0/bin:$PATH
       ```
        {: pre}

2. 使用 `istio-injection=enabled` 标记 `default` 名称空间。
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. 部署 BookInfo 应用程序。当应用程序微服务部署时，每个微服务 pod 中也会部署 Envoy sidecar。

   ```
   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. 确保已部署微服务及其相应的 pod：
    ```
    kubectl get svc
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         1m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         1m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         1m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         1m
    ```
    {: screen}

    ```
            kubectl get pods
            ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

5. 要验证应用程序部署，请获取集群的公共地址。
    * 标准集群：
        1. 要在公共 Ingress IP 上公开应用程序，请部署 BookInfo 网关。
            ```
            kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

        2. 设置 Ingress 主机。
            ```
            export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
            {: pre}

        3. 设置 Ingress 端口。
            ```
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
            {: pre}

        4. 创建使用 Ingress 主机和端口的 `GATEWAY_URL` 环境变量。

           ```
           export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
           ```
           {: pre}

    * 免费集群：
        1. 获取集群中任何工作程序节点的公共 IP 地址。
            ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
            {: pre}

        2. 创建使用工作程序节点公共 IP 地址的 GATEWAY_URL 环境变量。
            ```
            export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. 对 `GATEWAY_URL` 变量运行 curl，以检查 BookInfo 应用程序是否正在运行。`200` 响应表示 BookInfo 应用程序使用 Istio 正常运行。
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  在浏览器中查看 BookInfo Web 页面。

    对于 Mac OS 或 Linux：
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    对于 Windows：
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

7. 尝试多次刷新该页面。不同版本的评论部分会以红色星星、黑色星星和无星星进行循环。

非常好！您已成功部署了使用 Istio Envoy sidecar 的 BookInfo 样本应用程序。接下来，您可以清除资源或继续使用更多教程来进一步探索 Istio。

## 清除
{: #istio_tutorial_cleanup}

如果您已完成使用 Istio，并且不希望[继续探索](#istio_tutorial_whatsnext)，那么可以清除集群中的 Istio 资源。
{:shortdesc}

1. 删除集群中的所有 BookInfo 服务、pod 和部署。
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. 卸载 Istio Helm 部署。
    ```
    helm del istio --purge
    ```
    {: pre}

3. 如果使用的是 Helm 2.9 或更低版本：
    1. 删除额外的作业资源。
      ```
      kubectl -n istio-system delete job --all
      ```
      {: pre}
    2. 可选：删除 Istio 定制资源定义。
      ```
    kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
    ```
      {: pre}

## 接下来要做什么？
{: #istio_tutorial_whatsnext}

* 希望同时使用 {{site.data.keyword.containerlong_notm}} 和 Istio 来公开应用程序吗？请了解本[博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2018/09/transitioning-your-service-mesh-from-ibm-cloud-kubernetes-service-ingress-to-istio-ingress/) 中有关如何连接 {{site.data.keyword.containerlong_notm}} Ingress ALB 和 Istio 网关的内容。
* 要进一步探索 Istio，您可以在 [Istio 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://istio.io/) 中找到更多指南。
    * [智能路由 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://istio.io/docs/guides/intelligent-routing.html)：此示例显示如何使用 Istio 的各种流量管理功能，将流量路由到特定版本 BookInfo 的评论和评级微服务中。
    * [深入遥测 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://istio.io/docs/guides/telemetry.html)：此示例包含如何使用 Istio Mixer 和 Envoy 代理跨 BookInfo 微服务获取统一度量值、日志和跟踪。
* 参加 [Cognitive Class: Getting started with Microservices with Istio and IBM Cloud Kubernetes Service ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/)。**注**：您可以跳过此课程中的 Istio 安装部分。
* 请查看博客帖子 [Vistio ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e)，了解有关使用 Vistio 对 Istio 服务网可视化的信息。
