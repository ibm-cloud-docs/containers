---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-26"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Logging and monitoring Ingress
{: #ingress_health}

Customize logging and set up monitoring to help you troubleshoot issues and improve the performance of your Ingress configuration.
{: shortdesc}

## Viewing Ingress logs
{: #ingress_logs}

Logs are automatically collected for your Ingress ALBs. To view the ALB logs, choose between two options.
* [Create a logging configuration for the Ingress service](cs_health.html#configuring) in your cluster.
* Check the logs from the CLI.
    1. Get the ID of a pod for an ALB.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Open the logs for that ALB pod. Verify that logs follow the updated format.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

</br>The default Ingress log content is formatted in JSON and displays common fields that describe the connection session between a client and your app. An example log with the default fields looks like the following:

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>Understanding fields in the default Ingress log format</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding fields in the default Ingress log format</th>
</thead>
<tbody>
<tr>
<td><code>"time_date": "$time_iso8601"</code></td>
<td>The local time in the ISO 8601 standard format when the log is written.</td>
</tr>
<tr>
<td><code>"client": "$remote_addr"</code></td>
<td>The IP address of the request package that the client sent to your app. This IP can change based on the following situations:<ul><li>When a client request to your app is sent to your cluster, the request is routed to a pod for the load balancer service that exposes the ALB. If no app pod exists on the same worker node as the load balancer service pod, the load balancer forwards the request to an app pod on a different worker node. The source IP address of the request package is changed to the public IP address of the worker node where the app pod is running.</li><li>If [source IP preservation is enabled](cs_ingress.html#preserve_source_ip), the original IP address of the client request to your app is recorded instead.</li></ul></td>
</tr>
<tr>
<td><code>"host": "$http_host"</code></td>
<td>The host, or subdomain, that your apps are accessible through. This host is configured in the Ingress resource files for your ALBs.</td>
</tr>
<tr>
<td><code>"scheme": "$scheme"</code></td>
<td>The kind of request: <code>HTTP</code> or <code>HTTPS</code>.</td>
</tr>
<tr>
<td><code>"request_method": "$request_method"</code></td>
<td>The method of the request call to the backend app, such as <code>GET</code> or <code>POST</code>.</td>
</tr>
<tr>
<td><code>"request_uri": "$uri"</code></td>
<td>The original request URI to your app path. ALBs process the paths that apps listen on as prefixes. When an ALB receives a request from a client to an app, the ALB checks the Ingress resource for a path (as a prefix) that matches the path in the request URI.</td>
</tr>
<tr>
<td><code>"request_id": "$request_id"</code></td>
<td>A unique request identifier generated from 16 random bytes.</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>The status code for the connection session.<ul>
<li><code>200</code>: Session completed successfully</li>
<li><code>400</code>: Client data can't be parsed</li>
<li><code>403</code>: Access forbidden; for example, when access is limited for certain client IP addresses</li>
<li><code>500</code>: Internal server error</li>
<li><code>502</code>: Bad gateway; for example, if an upstream server can't be selected or reached</li>
<li><code>503</code>: Service unavailable; for example, when access is limited by the number of connections</li>
</ul></td>
</tr>
<tr>
<td><code>"upstream_addr": "$upstream_addr"</code></td>
<td>The IP address and port or the path to the UNIX-domain socket of the upstream server. If several servers are contacted during request processing, their addresses are separated by commas: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock"</code>. If the request is redirected internally from one server group to another, then the server addresses from different groups are separated by colons: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80"</code>. If the ALB can't select a server, the name of the server group is logged instead.</td>
</tr>
<tr>
<td><code>"upstream_status": $upstream_status</code></td>
<td>The status code of the response obtained from the upstream server for the backend app, such as standard HTTP response codes. Status codes of several responses are separated by commas and colons like addresses in the <code>$upstream_addr</code> variable. If the ALB can't select a server, the 502 (Bad Gateway) status code is logged.</td>
</tr>
<tr>
<td><code>"request_time": $request_time</code></td>
<td>The request processing time, measured in seconds with a milliseconds resolution. This time starts when the ALB reads the client request's first bytes and stops when the ALB sends the response's last bytes to the client. The log is written immediately after the request processing time stops.</td>
</tr>
<tr>
<td><code>"upstream_response_time": $upstream_response_time</code></td>
<td>The time that it takes the ALB to receive the response from the upstream server for the backend app, measured in seconds with a milliseconds resolution. Times of several responses are separated by commas and colons like addresses in the <code>$upstream_addr</code> variable.</td>
</tr>
<tr>
<td><code>"upstream_connect_time": $upstream_connect_time</code></td>
<td>The time that it takes the ALB to establish a connection with the upstream server for the backend app, measured in seconds with a milliseconds resolution. If TLS/SSL is enabled in your Ingress resource configuration, this time includes time spent on the handshake. Times of several connections are separated by commas and colons like addresses in the <code>$upstream_addr</code> variable.</td>
</tr>
<tr>
<td><code>"upstream_header_time": $upstream_header_time</code></td>
<td>The time that it takes the ALB to receive the response header from the upstream server for the backend app, measured in seconds with a milliseconds resolution. Times of several connections are separated by commas and colons like addresses in the <code>$upstream_addr</code> variable.</td>
</tr>
</tbody></table>

## Customizing Ingress log content and format
{: #ingress_log_format}

You can customize the content and format of logs that are collected for the Ingress ALB.
{:shortdesc}

By default, Ingress logs are formatted in JSON and display common log fields. However, you can also create a custom log format. To choose which log components are forwarded and how the components are arranged in the log output:

1. Create and open a local version of the configuration file for the `ibm-cloud-provider-ingress-cm` configmap resource.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Add a <code>data</code> section. Add the `log-format` field and optionally, the `log-format-escape-json` field.

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
    <caption>YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the log-format configuration</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>Replace <code>&lt;key&gt;</code> with the name for the log component and <code>&lt;log_variable&gt;</code> with a variable for the log component that you want to collect in log entries. You can include text and punctuation that you want the log entry to contain, such as quotation marks around string values and commas to separate log components. For example, formatting a component like <code>request: "$request"</code> generates the following in a log entry: <code>request: "GET / HTTP/1.1"</code> . For a list of all the variables you can use, see the <a href="http://nginx.org/en/docs/varindex.html">Nginx variable index</a>.<br><br>To log an additional header such as <em>x-custom-ID</em>, add the following key-value pair to the custom log content: <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>Hyphens (<code>-</code>) are converted to underscores (<code>_</code>) and <code>$http_</code> must be prepended to the custom header name.</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>Optional: By default, logs are generated in text format. To generate logs in JSON format, add the <code>log-format-escape-json</code> field and use value <code>true</code>.</td>
    </tr>
    </tbody></table>

    For example, your log format might contain the following variables:
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

    A log entry according to this format looks like the following example:
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    To create a custom log format that is based on the default format for ALB logs, modify the following section as needed and add it to your configmap:
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

4. Save the configuration file.

5. Verify that the configmap changes were applied.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. To view the Ingress ALB logs, choose between two options.
    * [Create a logging configuration for the Ingress service](cs_health.html#logging) in your cluster.
    * Check the logs from the CLI.
        1. Get the ID of a pod for an ALB.
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. Open the logs for that ALB pod. Verify that logs follow the updated format.
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## Increasing the shared memory zone size for Ingress metrics collection
{: #vts_zone_size}

Shared memory zones are defined so that worker processes can share information such as cache, session persistence, and rate limits. A shared memory zone, called the virtual host traffic status zone, is set up for Ingress to collect metrics data for an ALB.
{:shortdesc}

In the `ibm-cloud-provider-ingress-cm` Ingress configmap, the `vts-status-zone-size` field sets the size of the shared memory zone for metrics data collection. By default, `vts-status-zone-size` is set to `10m`. If you have a large environment that requires more memory for metrics collection, you can override the default to instead use a larger value by following these steps.

1. Create and open a local version of the configuration file for the `ibm-cloud-provider-ingress-cm` configmap resource.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Change the value of `vts-status-zone-size` from `10m` to a larger value.

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

3. Save the configuration file.

4. Verify that the configmap changes were applied.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}
