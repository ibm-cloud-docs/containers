---

copyright:
  years: 2026

lastupdated: "2026-07-09"

keywords: kubernetes, traefik, ingress controller

subcollection: containers

content-type: howto

---

{{site.data.keyword.attribute-definition-list}}

# Customizing ALB routing
{: #traefik-ingress-customization}

Customize how your Application Load Balancers (ALBs) handle routing, headers, timeouts, authentication, and traffic by using Traefik Middleware resources, Ingress annotations, and the `ibm-ingress-deploy-config` ConfigMap.
{: shortdesc}

## Adding a server port to a host header
{: #add-serverport-header}

By default, Traefik handles the `Host` header in a way that is compatible with most modern apps. Modifying the `Host` header to include a port is not recommended. Before making any changes, review how Traefik handles the header by default and understand when overwriting is appropriate.

Default `Host` header handling
:   Traefik forwards the original `Host` header by default with [`passHostHeader: true`](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/crd/http/ingressroute/){: external}. It automatically adds the following separate forwarded headers instead of embedding the port in the `Host` header:
:   - `X-Forwarded-Host`
:   - `X-Forwarded-Port`

Overwriting the `Host` header for legacy apps
:   If your app requires the port embedded in the `Host` header, use Traefik [Headers Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/headers/){: external} to overwrite it.

    ```yaml
    # Example (Kubernetes Middleware)
    apiVersion: traefik.io/v1
    kind: Middleware
    metadata:
      name: test-header
    spec:
      headers:
        customRequestHeaders:
          Host: "legacy-app.example:8080"
    ```
    {: codeblock}

    Apply the Middleware to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}. Ensure that CRD processing is enabled (the default). To configure CRD processing, see the `ibm-ingress-deploy-config` ConfigMap [processTraefikCRDs field](#create-ingress-configmap-custom).
    {: note}

## Routing incoming requests with a private ALB
{: #alb_id_anno}

By default, public ALBs process Ingress resources. To route incoming requests through a private ALB instead, specify the `private-iks-traefik` class in the `spec.ingressClassName` field of your [Ingress resource](/docs/containers?topic=containers-managed-ingress-setup).

```sh
spec.ingressClassName: "private-iks-traefik"
```
{: pre}

## Authenticating apps with {{site.data.keyword.appid_short_notm}}
{: #app-id-authentication}

Configure Traefik Ingress with [{{site.data.keyword.appid_full_notm}}](https://cloud.ibm.com/catalog/services/app-id){: external} to enforce authentication for your apps. For more information, see [Adding {{site.data.keyword.appid_short_notm}} authentication to apps](#app-id-auth).

## Setting the maximum client request body size
{: #client-request-bodysize}

By default, Traefik does not enforce a limit on the client request body size. To set a maximum, create a Buffering Middleware and apply it to your Ingress resource.

Traefik rejects any request that exceeds the configured limit with an HTTP 413 response.
{: note}

1. Create a Traefik [Buffering Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/buffering/){: external} resource. Set `maxRequestBodyBytes` to the maximum number of bytes that the client can send. The following example sets a limit of 2 MB (2097152 bytes).

    ```yaml
    # Example (Kubernetes Middleware)
    apiVersion: traefik.io/v1
    kind: Middleware
    metadata:
      name: limit
    spec:
      buffering:
        maxRequestBodyBytes: 2097152
    ```
    {: codeblock}

2. Apply the Middleware to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.

## Enabling client response data buffering
{: #client-response-data-buffering}

By default, Traefik streams responses directly without buffering. With [Buffering Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/buffering/){: external}, Traefik can store responses in memory or write them to disk before sending them to the client. Use this Middleware only when your app requires it, as response buffering is not recommended in most cases.

To enable response buffering, complete the following steps:

1. Create a Traefik [Buffering Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/buffering/){: external} resource. Set `maxResponseBodyBytes` to the maximum response size in bytes and `memResponseBodyBytes` to the threshold above which the response is written to disk instead of held in memory. The following example buffers up to 5 MB total, with the first 1 MB held in memory.

    ```yaml
    # Example (Kubernetes Middleware)
    apiVersion: traefik.io/v1
    kind: Middleware
    metadata:
      name: response-buffer
    spec:
      buffering:
        maxResponseBodyBytes: 5242880    # 5 MB max response size
        memResponseBodyBytes: 1048576    # 1 MB in memory, then disk
    ```
    {: codeblock}

2. Apply the Middleware to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.

## Adjusting timeouts
{: #adjusting-timeouts}

Traefik exposes two sets of timeout controls: timeouts between the client and the ALB, and timeouts between the ALB and your back-end app. Configure them separately depending on where the bottleneck is.

To set client-to-ALB timeouts, configure the corresponding `ibm-ingress-deploy-config` ConfigMap [fields](#create-ingress-configmap-custom):

- To configure how long an incoming HTTP or HTTPS request waits for the Traefik instance to respond, use the [httpReadTimeout and httpsReadTimeout fields](#create-ingress-configmap-custom).
- To configure the maximum duration before response writes time out, use the [httpWriteTimeout and httpsWriteTimeout fields](#create-ingress-configmap-custom).
- To configure the maximum duration that a keepalive connection stays open before it closes, use the [httpIdleTimeout and httpsIdleTimeout fields](#create-ingress-configmap-custom).

To set the connection and read timeout between the ALB and your back-end app, use [ServersTransport](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/crd/http/serverstransport/){: external} to configure the transport between Traefik and your HTTP servers.

```yaml
# Example (Kubernetes ServersTransport)
apiVersion: traefik.io/v1
kind: ServersTransport
metadata:
  name: mytransport
spec:
  forwardingTimeouts:
    dialTimeout: 30s
    responseHeaderTimeout: 10s
    idleConnTimeout: 90s
```
{: codeblock}

For VPC clusters, you must also modify the idle connection timeout on the load balancer service that exposes your public ALB. Replace `<clusterid>` with your cluster ID, which you can retrieve by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`. The following example sets the timeout to 910 seconds:

```sh
kubectl annotate svc -n kube-system public-cr<clusterid> service.kubernetes.io/ibm-load-balancer-cloud-provider-vpc-idle-connection-timeout="910"
```
{: pre}

Traefik supports a value of `0` for its timeouts, which disables the timeout.
{: note}

The `ibm-load-balancer-cloud-provider-vpc-idle-connection-timeout` annotation on the VPC load balancer does not support a zero value. You can set a timeout value between 50 seconds and 7200 seconds (2 hours). If you need a value greater than 2 hours, open a [support case](/docs/get-support?topic=get-support-open-case) and provide the business justification.
{: note}

If your clusters are exposed through IBM Cloud Internet Services (CIS) or Cloudflare with Web Application Firewall (WAF) or global load balancing enabled, set these timeouts to more than 900 seconds. For more information, see the [Cloudflare documentation](https://developers.cloudflare.com/fundamentals/reference/connection-limits/#between-cloudflare-and-origin-server){: external}.
{: note}

After you create the `ServersTransport` resource, apply it to your Service resource by using the Traefik Service [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-ioservice-serverstransport){: external}.

## Customizing error actions
{: #custom-error-actions}

To indicate custom actions that the ALB can take for specific HTTP errors, configure the Traefik [Errors Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/errorpages/){: external}. After you create the Middleware, apply it to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.

## Changing the default HTTP and HTTPS ports
{: #custom-http-https-ports}

By default, ALBs listen on port 80 for HTTP and port 443 for HTTPS. If your cluster requires non-standard ports, you can change these values for each ALB by using the [httpPort and httpsPort fields](#create-ingress-configmap-custom) in the `ibm-ingress-deploy-config` ConfigMap.

## Customizing the request header
{: #custom-request-header}

Use the Traefik [Headers Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/headers/){: external} to add, overwrite, or remove header fields from a client request before forwarding it to your back-end app. This is useful for injecting context such as script names, tenant identifiers, or other metadata that your app requires.

```yaml
# Example (Kubernetes Middleware)
apiVersion: traefik.io/v1
kind: Middleware
metadata:
  name: test-header
spec:
  headers:
    customRequestHeaders:
      X-Script-Name: "test"
```
{: codeblock}

After you create the Middleware, apply it to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.

## Customizing the response header
{: #custom-response-header}

Use the Traefik [Headers Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/headers/){: external} to add, overwrite, or remove header fields from a response before sending it to the client. This is useful for enforcing security policies, adding CORS headers, or stripping internal headers before they reach the client.

```yaml
# Example (Kubernetes Middleware)
apiVersion: traefik.io/v1
kind: Middleware
metadata:
  name: test-header
spec:
  headers:
    customResponseHeaders:
      X-Custom-Response-Header: "value"
```
{: codeblock}

After you create the Middleware, apply it to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.

## Redirecting insecure requests
{: #http-redirects-https}

To enforce HTTPS-only access and permanently redirect all incoming HTTP requests to the HTTPS endpoint, set the `httpsRedirect` field in the [`ibm-ingress-deploy-config` ConfigMap](#comm-customize-deploy).

## Enabling and disabling HTTP Strict Transport Security
{: #http-strict-transport-security}

HTTP Strict Transport Security (HSTS) instructs browsers to access a domain over HTTPS only, preventing protocol downgrade attacks. This feature is opt-in for Traefik. Enable it by using the [Headers Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/headers/){: external} with the `stsSeconds`, `stsIncludeSubdomains`, and `stsPreload` fields.

```yaml
# Example (Kubernetes Middleware) - produces: Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
apiVersion: traefik.io/v1
kind: Middleware
metadata:
  name: security-headers
spec:
  headers:
    stsSeconds: 31536000            # max-age=1 year
    stsIncludeSubdomains: true
    stsPreload: true
```
{: codeblock}

Apply the Middleware to your Ingress resource by using the following Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.
{: note}

## Modifying how the ALB matches the request URI
{: #location-modifier}

By default, Traefik uses the `PathPrefix` matcher to route requests. If your app requires exact path matching or regular expression-based routing, override the matcher by using the following Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-pathmatcher){: external}.

```sh
traefik.ingress.kubernetes.io/router.pathmatcher: PathRegexp
```
{: pre}

## Configuring mutual authentication
{: #mutual-authentication}

Mutual TLS (mTLS) requires both the server and the client to present valid certificates, providing stronger authentication than standard TLS. To require client certificate authentication on your ALB, create a [TLSOption](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/crd/tls/tlsoption/){: external} resource that references your CA certificate secret.

```yaml
# Example (Kubernetes TLSOption)
apiVersion: traefik.io/v1
kind: TLSOption
metadata:
  name: mtls
  namespace: default
spec:
  minVersion: VersionTLS12
  clientAuth:
    secretNames:
      - my-ca-secret
    clientAuthType: RequireAndVerifyClientCert
```
{: codeblock}

After you create the `TLSOption` resource, apply it to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-tls-options){: external}.

## Configuring retry behavior for upstream requests
{: #proxy-next-upstream}

When a back-end server fails to respond, Traefik can automatically retry the request against another upstream server. Configure retry behavior by using the Traefik [Retry Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/retry/){: external}. After you create the Middleware, apply it to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.

## Rate limiting
{: #rate-limiting}

Rate limiting protects your back-end apps from traffic spikes and abuse by capping the number of requests that the ALB processes within a time window. Configure rate limiting by using the Traefik [RateLimit Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/ratelimit/){: external}. After you create the Middleware, apply it to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.

## Rewriting paths
{: #alb-rewrite-paths}

Path rewriting lets you expose a public URL path that differs from the path your back-end app listens on. For example, you can route requests arriving at `/app` to a back-end app that listens on `/`. Use one of the following Traefik resources depending on whether you need a fixed replacement or a pattern-based replacement:

- The Traefik [ReplacePath Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/replacepath/){: external} resource
- The Traefik [ReplacePathRegex Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/replacepathregex/){: external} resource

```yaml
# Example Replace the path with /foo
apiVersion: traefik.io/v1
kind: Middleware
metadata:
  name: test-replacepath
spec:
  replacePath:
    path: "/foo"
```
{: codeblock}

```yaml
# Example Replace path with regex
apiVersion: traefik.io/v1
kind: Middleware
metadata:
  name: test-replacepathregex
spec:
  replacePathRegex:
    regex: "^/foo/(.*)"
    replacement: "/bar/$1"
```
{: codeblock}

Apply the Middleware to your Ingress resource by using the following Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.
{: note}

## Routing traffic with sticky cookies
{: #session-affinity-cookies}

Sticky sessions ensure that a client's requests are always routed to the same back-end server for the duration of a session. This is useful for stateful apps that store session data locally on the server. Enable sticky sessions by configuring the Traefik Service [sticky cookie annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-ioservice-sticky-cookie){: external} on your Ingress resource.

## Encrypting traffic between your app and the ALB
{: #ssl-services-support}

By default, Traefik forwards traffic to your back-end app over plain HTTP. If your app requires encrypted upstream connections, use a [ServersTransport](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/crd/http/serverstransport/#opt-serverstransport-rootcas){: external} resource to configure TLS between the ALB and your app, including the CA certificate and expected server name.

```yaml
# Example (Kubernetes ServersTransport)
apiVersion: traefik.io/v1
kind: ServersTransport
metadata:
  name: backend-transport
spec:
  rootCAs:
    - secret: my-ca-cert
  serverName: <myapp.example.com> # must match your certificate
```
{: codeblock}

Apply the `ServersTransport` to your Service resource by using the following Traefik Service [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-ioservice-serverstransport){: external}.
{: note}

## Customizing the ALB deployment
{: #comm-customize-deploy}

The `ibm-ingress-deploy-config` ConfigMap controls ALB-level settings such as replica count, ports, log level, timeout values, and Ingress provider. Use this ConfigMap to apply configuration changes to one or more ALBs in your cluster without modifying individual Ingress resources.

1. Get the names of the services that expose each ALB. Note the service names because you use them in the following steps.

    * Classic clusters:

        ```sh
        kubectl get svc -n kube-system | grep alb
        ```
        {: pre}

    * VPC clusters: In the output, look for a service name that is formatted such as `public-crc204dl7w0qf6n6sp7tug`.

        ```sh
        kubectl get svc -n kube-system | grep LoadBalancer
        ```
        {: pre}

2. Create a YAML file for an `ibm-ingress-deploy-config` ConfigMap. For each ALB ID, you can specify one or more of the following optional settings. You only need to include the settings that you want to configure.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-ingress-deploy-config
      namespace: kube-system
    data:
      <alb1-id>: '{"replicas":<number_of_replicas>, "ingressClass":"<class>", "httpsPort":"<port>", "httpPort":"<port>", "logLevel": "<TRACE|DEBUG|INFO|WARN|ERROR|FATAL|PANIC>", "ingressProvider": "<ingress|ingress-nginx>", "processTraefikCRDs": <true|false>, "traefikIngressNginxAllowExternalNameServices": <true|false>, "traefikCRDAllowCrossNamespace": <true|false>, "traefikCRDAllowExternalNameServices": <true|false>, "httpReadTimeout": <seconds>, "httpWriteTimeout": <seconds>, "httpIdleTimeout": <seconds>, "httpsReadTimeout": <seconds>, "httpsWriteTimeout": <seconds>, "httpsIdleTimeout": <seconds>, "httpsRedirect": <true|false>, "tolerations": [{"key":"<key>","operator":"<Equal|Exists>","value":"<value>","effect":"<NoSchedule|PreferNoSchedule|NoExecute>"}]}'
      <alb2-id>: '{"replicas":<number_of_replicas>, "ingressClass":"<class>", "httpsPort":"<port>", "httpPort":"<port>", "logLevel": "<TRACE|DEBUG|INFO|WARN|ERROR|FATAL|PANIC>", "ingressProvider": "<ingress|ingress-nginx>", "processTraefikCRDs": <true|false>, "traefikIngressNginxAllowExternalNameServices": <true|false>, "traefikCRDAllowCrossNamespace": <true|false>, "traefikCRDAllowExternalNameServices": <true|false>, "httpReadTimeout": <seconds>, "httpWriteTimeout": <seconds>, "httpIdleTimeout": <seconds>, "httpsReadTimeout": <seconds>, "httpsWriteTimeout": <seconds>, "httpsIdleTimeout": <seconds>, "httpsRedirect": <true|false>, "tolerations": [{"key":"<key>","operator":"<Equal|Exists>","value":"<value>","effect":"<NoSchedule|PreferNoSchedule|NoExecute>"}]}'
    ```
    {: codeblock}

    `replicas`
    :   By default, each ALB has two replicas. Scale up your ALB processing capabilities by increasing the number of ALB pods. For more information, see [Increasing the number of ALB pod replicas](/docs/containers?topic=containers-traefik-ingress-alb-manage#scale_albs).

    `ingressClass`
    :   If you specified a class other than `public-iks-traefik` or `private-iks-traefik` in your Ingress resource, enter the class name here.

    `httpPort`, `httpsPort`
    :   Expose non-default ports for the Ingress ALB by adding the HTTP or HTTPS ports that you want to open.
    :   Default values: 80/443.

    `logLevel`
    :   Specify the logging level. Choose from: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`, `PANIC`.
    :   Default: `INFO`.

    `ingressProvider`
    :   Specify which Traefik Ingress provider to use for this ALB. Valid values:
    :   `ingress`: Uses [Traefik's own ingress controller](https://doc.traefik.io/traefik/reference/install-configuration/providers/kubernetes/kubernetes-ingress/){: external}. It processes Traefik-specific annotations on Ingress resources.
    :   `ingress-nginx`: Uses a temporary [compatibility layer for Ingress-NGINX in Traefik](https://doc.traefik.io/traefik/reference/install-configuration/providers/kubernetes/kubernetes-ingress-nginx/){: external}. It processes annotations that were created for Ingress-NGINX and mimics Ingress-NGINX behavior when possible. Use this value to help migrate from Ingress-NGINX to Traefik.
    :   Default: `ingress`.

    `processTraefikCRDs`
    :   When set to `true`, Traefik processes its own CRD resources in addition to Ingress resources. Supported CRDs include `IngressRoute`, `Middleware`, and `TLSOption`. For the full list, see [Traefik documentation on CRDs](https://doc.traefik.io/traefik/reference/install-configuration/providers/kubernetes/kubernetes-crd/){: external}.
    :   Default: `true`.

    `traefikIngressNginxAllowExternalNameServices`
    :   Enables support for ExternalName services for Ingress objects that are processed by the `ingress-nginx` provider. This option applies only when `ingressProvider` is set to `ingress-nginx`.
    :   Default: `true`.

    `traefikCRDAllowCrossNamespace`
    :   Allows IngressRoute resources (Traefik CRD) to reference resources in other namespaces.
    :   Default: `false`.

    `traefikCRDAllowExternalNameServices`
    :   Allows IngressRoute resources (Traefik CRD) to reference ExternalName services.
    :   Default: `false`.

    `httpReadTimeout`, `httpsReadTimeout`
    :   Configures the HTTP/HTTPS read timeout between the ALB and the client. Setting this value to zero disables the timeout.
    :   For more information, see the [Traefik documentation](https://doc.traefik.io/traefik/reference/install-configuration/entrypoints/#opt-transport-respondingTimeouts-readTimeout){: external}.

    `httpWriteTimeout`, `httpsWriteTimeout`
    :   Configures the HTTP/HTTPS write timeout between the ALB and the client. Setting this value to zero disables the timeout.
    :   For more information, see the [Traefik documentation](https://doc.traefik.io/traefik/reference/install-configuration/entrypoints/#opt-transport-respondingTimeouts-writeTimeout){: external}.

    `httpIdleTimeout`, `httpsIdleTimeout`
    :   Configures the HTTP/HTTPS idle timeout (keepalive) between the ALB and the client. Setting this value to zero disables the timeout.
    :   For more information, see the [Traefik documentation](https://doc.traefik.io/traefik/reference/install-configuration/entrypoints/#opt-transport-respondingTimeouts-idleTimeout){: external}.
    :   If you use IBM Cloud Internet Services (CIS) or Cloudflare with Web Application Firewall (WAF) or global load balancing, configure this value to more than 900 seconds. For more information, see [Adjusting timeouts](#adjusting-timeouts).
    {: important}

    `httpsRedirect`
    :   Enables a permanent redirect of all incoming HTTP requests to the HTTPS endpoint.
    :   Default: `false`.

    `tolerations`
    :   Specifies additional custom tolerations for the ALB pods. For more information, see [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/){: external}.

3. Create the `ibm-ingress-deploy-config` ConfigMap in your cluster.
    ```sh
    kubectl create -f ibm-ingress-deploy-config.yaml
    ```
    {: pre}

4. Update your ALBs to apply the changes. Changes can take up to five minutes to take effect. If the command returns without output, the update was submitted successfully.
    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID>
    ```
    {: pre}

5. If you specified non-standard HTTP, HTTPS, or TCP ports, you must open the ports on each ALB service.
    1. For each ALB service that you found in step 1, edit the YAML file.
        ```sh
        kubectl edit svc -n kube-system <alb_svc_name>
        ```
        {: pre}

    2. In the `spec.ports` section, add the ports that you want to open. By default, ports 80 and 443 are open. If you want to keep 80 and 443 open, don't remove them from this file. Any port that is not specified is closed. Do not specify a `nodePort`. After you add the port and apply the changes, a `nodePort` is automatically assigned.

        ```sh
        ...
        ports:
        - name: port-80
          port: 80
          protocol: TCP
          targetPort: 80
        - name: port-443
          port: 443
          protocol: TCP
          targetPort: 443
        - name: <new_port>
          port: <port>
          protocol: TCP
          targetPort: <port>
        ...
        ```
        {: codeblock}

    3. Save and close the file. Your changes are applied automatically.

## Customizing the Ingress class
{: #custom-ingress-class}

An Ingress class associates a class name with an Ingress controller type, allowing multiple controllers to coexist in the same cluster. Use the [`IngressClass`](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class){: external} resource to define a custom class for your ALBs.

Traefik only processes Ingress classes where `.spec.controller` is set to `traefik.io/ingress-controller`.
{: note}

## Adding {{site.data.keyword.appid_short_notm}} authentication to apps
{: #app-id-auth}

Protect your apps from unauthenticated access by integrating [{{site.data.keyword.appid_full_notm}}](https://cloud.ibm.com/catalog/services/app-id){: external} with your Ingress ALB. When authentication is configured, the ALB forwards requests through an OAuth2-Proxy that validates credentials with {{site.data.keyword.appid_short_notm}} before passing traffic to your app.

1. Choose an existing or create a new {{site.data.keyword.appid_short_notm}} instance.

    An {{site.data.keyword.appid_short_notm}} instance can be used in only one namespace in your cluster. If you want to configure {{site.data.keyword.appid_short_notm}} for Ingress resources in multiple namespaces, repeat the steps in this section to specify a unique {{site.data.keyword.appid_short_notm}} instance for the Ingress resources in each namespace.
    {: note}

    * To use an existing instance, ensure that the service instance name contains only **lowercase** alphanumeric characters and its length does not exceed 25 characters. To change the name, select **Rename service** from the more options menu on your service instance details page.
    * To provision a [new {{site.data.keyword.appid_short_notm}} instance](https://cloud.ibm.com/catalog/services/app-id):
        1. Replace the **Service name** with your own unique name for the service instance. The service instance name must contain only lowercase alphanumeric characters and cannot be longer than 25 characters.
        2. Choose the same region that your cluster is deployed in.
        3. Click **Create**.

2. Add redirect URLs for your app. A redirect URL is the callback endpoint of your app. To prevent phishing attacks, {{site.data.keyword.appid_full_notm}} validates the request URL against the allowlist of redirect URLs.
    1. In the {{site.data.keyword.appid_short_notm}} management console, navigate to **Manage Authentication**.
    2. In the **Identity providers** tab, make sure that you have an Identity Provider selected. If no Identity Provider is selected, you are not authenticated but are issued an access token for anonymous access to the app.
    3. In the **Authentication settings** tab, add redirect URLs for your app in the format `https://<hostname>/oauth2-<App_ID_service_instance_name>/callback`. All letters in the service instance name must be lowercase.

    If you use the [{{site.data.keyword.appid_full_notm}} logout function](/docs/appid?topic=appid-cd-sso#cd-sso-log-out), append `/sign_out` to your domain in the format `https://<hostname>/oauth2-<App_ID_service_instance_name>/sign_out` and include this URL in the redirect URLs list. To use a custom logout page, set `whitelist_domains` in the OAuth2-Proxy ConfigMap. Call the `https://<hostname>/oauth2-<App_ID_service_instance_name>/sign_out` endpoint with the `rd` query parameter or set the `X-Auth-Request-Redirect` header with your custom logout page URL. For more information, see [Sign out](https://oauth2-proxy.github.io/oauth2-proxy/features/endpoints/#sign-out){: external}.
    {: note}

3. Bind the {{site.data.keyword.appid_short_notm}} service instance to your cluster. The command creates a service key for the service instance, or you can include the `--key` option to use existing service key credentials. Bind the service instance to the same namespace that your Ingress resources are in. All letters in the service instance name must be lowercase.
    ```sh
    ibmcloud ks cluster service bind --cluster <cluster_name_or_ID> --namespace <namespace> --service <App_ID_service_instance_name> [--key <service_instance_key>]
    ```
    {: pre}

    When the service is successfully bound to your cluster, a cluster secret is created that holds the credentials for your service instance. The following example shows the output:
    ```sh
    ibmcloud ks cluster service bind --cluster mycluster --namespace mynamespace --service appid1
    Binding service instance to namespace...
    OK
    Namespace:    mynamespace
    Secret name:  binding-<service_instance_name>
    ```
    {: screen}

4. Enable the ALB OAuth Proxy add-on in your cluster. This add-on creates and manages the following Kubernetes resources: an OAuth2-Proxy deployment for your {{site.data.keyword.appid_short_notm}} service instance, a secret that contains the OAuth2-Proxy configuration, and an Ingress resource that routes incoming requests to the OAuth2-Proxy deployment. The name of each resource begins with `oauth2-`.
    1. Enable the `alb-oauth-proxy` add-on.
        ```sh
        ibmcloud ks cluster addon enable alb-oauth-proxy --cluster <cluster_name_or_ID>
        ```
        {: pre}

    2. Verify that the ALB OAuth Proxy add-on has a status of `Addon Ready`. Wait a few minutes and rerun the command if the status shows `Enabling`.
        ```sh
        ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
        ```
        {: pre}

5. In the Ingress resources for apps where you want to add {{site.data.keyword.appid_short_notm}} authentication, make sure that the resource name does not exceed 25 characters. Then configure the ForwardAuth Middleware:
    1. Create a Traefik [ForwardAuth Middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/forwardauth/){: external} resource. The `address` specifies the URL of the OAuth2-Proxy for your {{site.data.keyword.appid_short_notm}} instance, which acts as the OIDC Relying Party (RP). All letters in the service instance name must be lowercase.

        ```yaml
        apiVersion: traefik.io/v1
        kind: Middleware
        metadata:
          name: oauth-verify
          namespace: default
        spec:
          forwardAuth:
            address: "https://oauth2-<App_ID_service_instance_name>.<namespace_of_Ingress_resource>.svc.cluster.local/oauth2-<App_ID_service_instance_name>/auth"
            tls:
              insecureSkipVerify: true
        ```
        {: codeblock}

        By default, Traefik validates TLS IP subject alternative names (SANs). IBM-provided certificates are expected to fail this validation, so use the `insecureSkipVerify: true` option. This setting ensures that the Traefik instance, or ALB, can communicate with the `oauth2-proxy` deployment instances.
        {: note}

    2. Choose which tokens to send in the `Authorization` header to your app. For more information about ID and access tokens, see the [{{site.data.keyword.appid_short_notm}} documentation](/docs/appid?topic=appid-tokens).
        * To send only the `ID Token`, add the `authResponseHeaders` option to your ForwardAuth Middleware:

            ```yaml
            apiVersion: traefik.io/v1
            kind: Middleware
            metadata:
              name: oauth-verify
              namespace: default
            spec:
              forwardAuth:
                address: "https://oauth2-<App_ID_service_instance_name>.<namespace_of_Ingress_resource>.svc.cluster.local/oauth2-<App_ID_service_instance_name>/auth"
                authResponseHeaders:
                  - Authorization
                tls:
                  insecureSkipVerify: true
            ```
            {: codeblock}

        * To send only the `Access Token`, add the `authResponseHeaders` option to your ForwardAuth Middleware:

            ```yaml
            apiVersion: traefik.io/v1
            kind: Middleware
            metadata:
              name: oauth-verify
              namespace: default
            spec:
              forwardAuth:
                address: "https://oauth2-<App_ID_service_instance_name>.<namespace_of_Ingress_resource>.svc.cluster.local/oauth2-<App_ID_service_instance_name>/auth"
                authResponseHeaders:
                  - X-Auth-Request-Access-Token
                tls:
                  insecureSkipVerify: true
            ```
            {: codeblock}

        * To send both the `Access Token` and the `ID Token`, add the `authResponseHeaders` option to your ForwardAuth Middleware:

            ```yaml
            apiVersion: traefik.io/v1
            kind: Middleware
            metadata:
              name: oauth-verify
              namespace: default
            spec:
              forwardAuth:
                address: "https://oauth2-<App_ID_service_instance_name>.<namespace_of_Ingress_resource>.svc.cluster.local/oauth2-<App_ID_service_instance_name>/auth"
                authResponseHeaders:
                  - X-Auth-Request-Access-Token
                  - Authorization
                tls:
                  insecureSkipVerify: true
            ```
            {: codeblock}

    3. Optional: If your app supports the [web app strategy](/docs/appid?topic=appid-key-concepts#term-web-strategy) in addition to or instead of the [API strategy](/docs/appid?topic=appid-key-concepts#term-api-strategy), add the `authSigninURL` to your ForwardAuth Middleware. All letters in the service instance name must be lowercase.

        ```yaml
        apiVersion: traefik.io/v1
        kind: Middleware
        metadata:
          name: oauth-verify
          namespace: default
        spec:
          forwardAuth:
            address: "https://oauth2-<App_ID_service_instance_name>.<namespace_of_Ingress_resource>.svc.cluster.local/oauth2-<App_ID_service_instance_name>/auth"
            authResponseHeaders:
              - X-Auth-Request-Access-Token
              - Authorization
            authSigninURL: /oauth2-<App_ID_service_instance_name>/sign_in?rd={url}
            tls:
              insecureSkipVerify: true
        ```
        {: codeblock}

        * If you specify `authSigninURL` and authentication for a client fails, the client is redirected to the OAuth2-Proxy, which then redirects the client to the {{site.data.keyword.appid_short_notm}} login page.
        * If you don't specify `authSigninURL`, a client must authenticate with a valid bearer token. If authentication fails, the request is rejected with a `401 Unauthorized` error.

6. Optional: If your setup requires it, create a Traefik [ServersTransport](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/crd/http/serverstransport/#opt-serverstransport-insecureSkipVerify){: external} resource to skip TLS verification for requests forwarded to your app's Service resource.

    ```yaml
    # Example (Kubernetes ServersTransport)
    apiVersion: traefik.io/v1
    kind: ServersTransport
    metadata:
      name: skip-tls-verify
    spec:
      insecureSkipVerify: true
    ```
    {: codeblock}

    Apply the `ServersTransport` to your Service resource by using the Traefik Service [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-ioservice-serverstransport){: external}.
    {: note}

7. Edit your Ingress resources to enforce {{site.data.keyword.appid_short_notm}} authentication by applying the ForwardAuth Middleware that you created. Use the following Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-middlewares){: external}.

    ```sh
    traefik.ingress.kubernetes.io/router.middlewares: "default-oauth-verify@kubernetescrd"
    ```
    {: pre}

    After an Ingress resource with the appropriate annotations is reapplied, the ALB OAuth Proxy add-on deploys an `oauth2-proxy` deployment, creates a service for the deployment, and creates a separate Ingress resource to configure routing for the `oauth2-proxy` deployment. Do not delete these add-on resources.

8. Verify that {{site.data.keyword.appid_short_notm}} authentication is enforced for your apps.
    * If your app supports the [web app strategy](/docs/appid?topic=appid-key-concepts#term-web-strategy): Access your app's URL in a web browser. If {{site.data.keyword.appid_short_notm}} is correctly applied, you are redirected to an {{site.data.keyword.appid_short_notm}} authentication login page.
    * If your app supports the [API strategy](/docs/appid?topic=appid-key-concepts#term-api-strategy): Specify your `Bearer` access token in the Authorization header of requests to the apps. To get your access token, see the [{{site.data.keyword.appid_short_notm}} documentation](/docs/appid?topic=appid-obtain-tokens). If {{site.data.keyword.appid_short_notm}} is correctly applied, the request is successfully authenticated and is routed to your app. If you send requests to your apps without an access token in the Authorization header, or if the access token is not accepted by {{site.data.keyword.appid_short_notm}}, the request is rejected.

9. Optional: If you use network policies or another firewall solution on your cluster to limit outgoing traffic, make sure that your cluster can access the public App ID service. To obtain the IP address range for this service, submit a request through [customer support](/docs/containers?topic=containers-get-help).

10. Optional: You can customize the default behavior of the OAuth2-Proxy by creating a Kubernetes ConfigMap.
    1. Create a ConfigMap YAML file that specifies values for the OAuth2-Proxy settings that you want to change.
        ```yaml
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: oauth2-<App_ID_service_instance_name>
          namespace: <ingress_resource_namespace>
        data:
          auth_logging: <true|false>
          # Log all authentication attempts.
          auth_logging_format:
          # Format for authentication logs. For more info, see https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview#logging-configuration
          cookie_csrf_expire: "15m"
          # Expiration time for CSRF cookie. Default is "15m".
          cookie_csrf_per_request: <true|false>
          # Enable multiple CSRF cookies per request, making it possible to have parallel requests. Default is "false".
          cookie_domains:
          # A list of optional domains to force cookies to. The longest domain that matches the request’s host is used. If there is no match for the request’s host, the shortest domain is used. Example: sub.domain.com,example.com
          cookie_expire: "168h0m0s"
          # Expiration time for cookies. Default: "168h0m0s".
          cookie_samesite: ""
          # SameSite attribute for cookies. Supported values: "lax", "strict", "none", or "".
          email_domains: ""
          # Authenticate IDs that use the specified email domain. To authenticate IDs that use any email domain, use "*". Default: "". Example: example.com,example2.com
          pass_access_token: <true|false>
          # Pass the OAuth access token to the back-end app via the X-Forwarded-Access-Token header.
          request_logging: <true|false>
          # Log all requests to the back-end app.
          request_logging_format:
          # Format for request logs. For more info, see https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview#request-log-format
          scope:
          # Scope of the OAuth authentication. For more info, see https://oauth.net/2/scope/
          set_authorization_header: <true|false>
          # Set the Authorization Bearer response header when the app responds to the Ingress ALB, such as when using the Traefik ForwardAuth Middleware.
          set_xauthrequest: <true|false>
          # Set X-Auth-Request-User, X-Auth-Request-Email, and X-Auth-Request-Preferred-Username response headers when the app responds to the Ingress ALB, such as when using the Traefik ForwardAuth Middleware.
          standard_logging: <true|false>
          # Log standard runtime information.
          standard_logging_format:
          # Format for standard logs. For more info, see https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview#standard-log-format
          tls_secret_name:
          # The name of a secret that contains the server-side TLS certificate and key to enable TLS between the OAuth2-Proxy and the Ingress ALB. By default, the TLS secret defined in your Ingress resources is used.
          whitelist_domains:
          # Allowed domains for redirection after authentication. Default: "". Example: example.com,*.example2.com For more info, see: https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview#command-line-options
          oidc_extra_audiences:
          # Additional audiences which are allowed to pass verification. 
          cookie_refresh: 
          # Refresh the cookie after this duration. Example: "15m". To use this feature, you must enable "Refresh token" for the AppID instance. For more info, see: /docs/appid?topic=appid-managing-idp&interface=ui#idp-token-lifetime
        ```
        {: codeblock}

    2. Apply the ConfigMap resource to your add-on. Your changes are applied automatically.
        ```sh
        kubectl apply -f oauth2-<App_ID_service_instance_name>.yaml
        ```
        {: pre}

For the list of changes for each ALB OAuth Proxy add-on version, see the [{{site.data.keyword.cloud_notm}} ALB OAuth Proxy add-on change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).
{: tip}

## Upgrading the ALB OAuth Proxy add-on
{: #upgrading-alb-oauth-proxy-add-on}

To upgrade the ALB OAuth Proxy add-on to a newer version, disable the current installation and re-enable it with the version you want. Your existing `oauth2-proxy` instances are not interrupted during the upgrade.

The upgrade process is noninterruptive because the supervised `oauth2-proxy` instances remain on the cluster even when the add-on is disabled.
{: note}

1. Disable the add-on.
    ```sh
    ibmcloud ks cluster addon disable alb-oauth-proxy --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. List the available add-on versions and note the version you want to use. The output shows available versions and which version is the default.
    ```sh
    ibmcloud ks cluster addon versions --addon alb-oauth-proxy
    ```
    {: pre}

3. Enable the add-on and specify the `--version` option. If you don't specify a version, the default version is enabled.
    ```sh
    ibmcloud ks cluster addon enable alb-oauth-proxy --cluster <cluster_name_or_ID> [--version <version>]
    ```
    {: pre}

## Preserving the source IP address
{: #preserve_source_ip}

By default, the Ingress ALB does not preserve the original source IP address of client requests. This can prevent IP-based access control, logging, and security policies from working correctly. Choose the method that applies to your cluster type to enable source IP preservation.

### Enabling the PROXY protocol in VPC clusters
{: #preserve_source_ip_vpc}

The [PROXY protocol](https://www.haproxy.org/download/1.8/doc/proxy-protocol.txt){: external} passes the original client IP address through the load balancer layer to the ALB.

Enabling the PROXY protocol recreates your load balancers, which might cause a brief service disruption. Two unused IP addresses per load balancer must be available in each subnet during recreation.
{: important}

1. Enable the PROXY protocol. For more information about the command parameters, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_lb_proxy-protocol_enable).

    ```sh
    ibmcloud ks ingress lb proxy-protocol enable --cluster <cluster_name_or_ID> --cidr <subnet_CIDR>
    ```
    {: pre}

2. Confirm that the PROXY protocol is enabled for the load balancers that expose ALBs in your cluster. In the output, verify that the `Proxy Protocol` field shows `Enabled`.
    ```sh
    ibmcloud ks ingress lb get --cluster <cluster_name_or_ID>
    ```
    {: pre}

3. To disable the PROXY protocol later, run the following command:
    ```sh
    ibmcloud ks ingress lb proxy-protocol disable --cluster <cluster_name_or_ID>
    ```
    {: pre}

### Changing the `externalTrafficPolicy` in classic clusters
{: #preserve_source_ip_classic}

In classic clusters, set `externalTrafficPolicy` to `Local` on the load balancer service that exposes the ALB. This prevents the load balancer from replacing the client source IP with the worker node IP when it forwards traffic.

By default, the source IP address of the client request is not preserved. When a client request reaches your cluster, it is routed to a pod for the load balancer service that exposes the ALB. If no app pod exists on the same worker node as the load balancer service pod, the load balancer forwards the request to an app pod on a different worker node. The worker node where the app pod runs changes the source IP address of the packet to its public IP address.

To preserve the original source IP address of the client request, you can enable [source IP preservation](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer){: external}. Preserving the client's IP is useful, for example, when app servers have to apply security and access-control policies.

When source IP preservation is enabled, load balancers shift from forwarding traffic to an ALB pod on a different worker node to an ALB pod on the same worker node. Your apps might experience downtime during this shift. If you [disable an ALB](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure), you lose any source IP changes you made to the load balancer service that exposes the ALB. When you re-enable the ALB, you must enable source IP again.

In classic clusters, [increasing the ALB replica count to more than two](/docs/containers?topic=containers-ingress-alb-manage#alb_replicas) increases the number of replicas, but when `externalTrafficPolicy` is set to `Local`, any replicas beyond two are not used. Only two load balancer pods are present on the cluster in an active-passive setup and, because of this traffic policy, they forward incoming traffic only to the ALB pod on the same node.
{: important}

To enable source IP preservation, edit the load balancer service that exposes an Ingress ALB:

1. Enable source IP preservation for a single ALB or for all the ALBs in your cluster.
    * To set up source IP preservation for a single ALB:
        1. Get the ID of the ALB for which you want to enable source IP. The ALB services have a format similar to `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` for a public ALB or `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` for a private ALB.
        
            ```sh
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Open the YAML for the load balancer service that exposes the ALB.
        
            ```sh
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. Under `spec`, change the value of `externalTrafficPolicy` from `Cluster` to `Local`.

        4. Save and close the configuration file. The output is similar to the following:

            ```sh
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}

    * To set up source IP preservation for all public ALBs in your cluster, run the following command:
        ```sh
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Example output:

        ```sh
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * To set up source IP preservation for all private ALBs in your cluster, run the following command:
        ```sh
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Example output:

        ```sh
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Verify that the source IP is preserved in your ALB pod logs.
    1. Get the name of a pod for the ALB that you modified. Look for a pod name that begins with the ALB ID you modified, such as `public-cr<hash>-alb1-<suffix>`.
        ```sh
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Open the logs for that ALB pod. Verify that the IP address for the `client` field is the original client request IP address and not the load balancer service IP address.
        ```sh
        kubectl logs <ALB_pod_ID> traefik -n kube-system
        ```
        {: pre}

3. Confirm that the client IP address appears in the `x-forwarded-for` header of requests to your back-end app. You can verify this by checking your app logs or by inspecting incoming request headers in your app.

4. Optional: If you no longer want to preserve the source IP, revert the changes that you made to the service.
    * To revert source IP preservation for your public ALBs:
        ```sh
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

    * To revert source IP preservation for your private ALBs:
        ```sh
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

## Configuring TLS protocols and ciphers
{: #ssl_protocols_ciphers}

Use a [TLSOption](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/crd/tls/tlsoption/){: external} resource to enforce minimum TLS versions, restrict cipher suites, and configure other TLS connection parameters for traffic that reaches your ALB. After you create the `TLSOption` resource, apply it to your Ingress resource by using the Traefik Ingress [annotation](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#opt-traefik-ingress-kubernetes-iorouter-tls-options){: external}.

## Sending your custom certificate to legacy clients
{: #default_server_cert}

Legacy devices that don't support Server Name Indication (SNI) cannot negotiate which TLS certificate to use, so they receive the ALB's default Let's Encrypt certificate instead of your custom certificate. To ensure these devices receive your custom certificate, update the ALB's default server settings to point to your custom TLS secret.

The Let's Encrypt certificates that are generated by default aren't intended for production usage. For production workloads, bring your own custom certificate.
{: important}

When you create a classic cluster, IBM provides a Let's Encrypt certificate for the default Ingress secret. If you create a custom secret and specify it for TLS termination in your Ingress resources, the ALB sends your custom certificate to clients instead of the Let's Encrypt certificate. However, if a client does not support SNI, the ALB defaults to the Let's Encrypt certificate because the default secret is listed in the ALB's default server settings. To send your custom certificate to non-SNI devices, complete the following steps.

1. Edit the `alb-default-server` Ingress resource.
    ```sh
    kubectl edit ingress alb-default-server -n kube-system
    ```
    {: pre}

2. In the `spec.tls` section, change the value of the `hosts.secretName` setting to the name of your custom secret that contains your custom certificate.

    ```yaml
    spec:
      rules:
      ...
      tls:
      - hosts:
        - invalid.mycluster-<hash>-0000.us-south.containers.appdomain.cloud
        secretName: <custom_secret_name>
    ```
    {: codeblock}

3. Save the resource file.

4. Verify that the resource now points to your custom secret name. The changes are applied to your ALBs automatically. In the output, confirm that `spec.tls[].secretName` matches your custom secret name.
    ```sh
    kubectl get ingress alb-default-server -n kube-system -o yaml
    ```
    {: pre}

## Tuning ALB performance
{: #perf_tuning}

Worker nodes are automatically provisioned with optimized kernel tuning that suits most workloads. If your cluster has specific high-throughput or low-latency requirements, you can [adjust the Linux kernel `sysctl` parameters on worker nodes](/docs/containers?topic=containers-kernel) to further tune ALB performance. Change these settings only when you have a clear performance optimization requirement, as incorrect values can destabilize the node.

## Next steps
{: #traefik-ingress-customization-next}

- [Manage your Ingress ALBs](/docs/containers?topic=containers-ingress-alb-manage) to scale, update, or disable ALBs in your cluster.
- [Set up Ingress](/docs/containers?topic=containers-managed-ingress-setup) to expose your apps by using the managed Ingress service.
- [Debug Ingress](/docs/containers?topic=containers-debug_ingress) to diagnose and resolve common Ingress issues.

## Related links
{: #traefik-ingress-customization-related}

- [Traefik documentation](https://doc.traefik.io/traefik/){: external}
- [Traefik Middleware reference](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/){: external}
- [Traefik CRD reference](https://doc.traefik.io/traefik/reference/install-configuration/providers/kubernetes/kubernetes-crd/){: external}
- [{{site.data.keyword.appid_full_notm}} documentation](/docs/appid?topic=appid-getting-started)
