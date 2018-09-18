---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 日志记录和监视 Ingress
{: #ingress_health}

定制日志记录和设置监视可帮助您对问题进行故障诊断，并提高 Ingress 配置的性能。
{: shortdesc}

## 定制 Ingress 日志内容和格式
{: #ingress_log_format}

可以定制为 Ingress ALB 收集的日志的内容和格式。
{:shortdesc}

缺省情况下，Ingress 日志设置为 JSON 格式并显示公共日志字段。但是，您还可以创建定制日志格式。要选择转发哪些日志组成部分以及这些组成部分在日志输出中的排列方式，请执行以下操作：

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 添加 <code>data</code> 部分。添加 `log-format` 字段以及（可选）`log-format-escape-json` 字段。

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    <table>
    <caption>YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 log-format 配置</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>将 <code>&lt;key&gt;</code> 替换为日志组成部分的名称，并将 <code>&lt;log_variable&gt;</code> 替换为希望在日志条目中收集的日志组成部分的变量。可以包含希望日志条目包含的文本和标点符号，如用于将字符串值括起的引号，以及用于分隔日志组成部分的逗号。例如，将组成部分的格式设置为诸如 <code>request: "$request"</code> 会在日志条目中生成以下内容：<code>request: "GET / HTTP/1.1"</code>。有关可以使用的所有变量的列表，请参阅 <a href="http://nginx.org/en/docs/varindex.html">Nginx 变量索引</a>。<br><br>要记录其他头（例如 <em>x-custom-ID</em>），请将以下键/值对添加到定制日志内容：<br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>连字符 (<code>-</code>) 会转换为下划线 (<code>_</code>)，并且必须在定制头名称的前面附加 <code>$http_</code>。</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>可选：缺省情况下，将生成文本格式的日志。要生成 JSON 格式的日志，请添加 <code>log-format-escape-json</code> 字段并使用值 <code>true</code>。</td>
    </tr>
    </tbody></table>

    例如，日志格式可能包含以下变量：
    ```
        apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    符合此格式的日志条目类似于以下示例：
    ```
        remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    要创建基于 ALB 日志的缺省格式的定制日志格式，请根据需要修改以下部分并将其添加到 configmap：
    ```
        apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. 保存配置文件。

5. 验证是否已应用配置映射更改。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. 要查看 Ingress ALB 日志，请在两个选项之间进行选择。
    * 在集群中[为 Ingress 服务创建日志记录配置](cs_health.html#logging)。
    * 通过 CLI 检查日志。
        1. 获取 ALB 的 pod 的标识。
            ```
kubectl get pods -n kube-system | grep alb
      ```
            {: pre}

        2. 打开该 ALB pod 的日志。验证日志是否遵循更新的格式。
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## 增大用于 Ingress 度量值收集的共享内存专区大小
{: #vts_zone_size}

定义了共享内存专区，以便工作程序进程可以共享高速缓存、会话持久性和速率限制等信息。设置了共享内存专区（称为虚拟主机流量状态专区），以供 Ingress 收集 ALB 的度量值数据。
{:shortdesc}

在 `ibm-cloud-provider-ingress-cm` Ingress 配置映射中，`vts-status-zone-size` 字段设置用于度量值数据收集的共享内存专区的大小。缺省情况下，`vts-status-zone-size` 设置为 `10m`。如果大型环境需要更多内存用于度量值收集，那么可以通过执行以下步骤来覆盖缺省值，而改为使用更大的值。

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 将 `vts-status-zone-size` 的值从 `10m` 更改为更大的值。

   ```
   apiVersion: v1
   data:
     vts-status-zone-size: "10m"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. 保存配置文件。

4. 验证是否已应用配置映射更改。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}
