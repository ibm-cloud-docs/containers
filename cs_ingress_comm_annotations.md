---

copyright:
  years: 2014, 2021
lastupdated: "2021-07-21"

keywords: kubernetes, iks, nginx, ingress controller

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:api: .ph data-hd-interface='api'}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:terraform: .ph data-hd-interface='terraform'}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vbnet: .ph data-hd-programlang='vb.net'}
{:video: .video}
  



# Kubernetes Ingress annotations
{: #comm-ingress-annotations}

Modify default ALB settings and add annotations to your Ingress resources for ALBs that run the Kubernetes Ingress image.
{: shortdesc}

<p class="important">From 07 to 31 July 2021, the DNS provider is changed from Cloudflare to Akamai for all `containers.appdomain.cloud`, `containers.mybluemix.net`, and `containers.cloud.ibm.com` domains for all clusters in {{site.data.keyword.containerlong_notm}}. Review the following actions that you must make to your Ingress setup.<ul><li>If you currently allow inbound traffic to your classic cluster from the Cloudflare source IP addresses, you must also allow inbound traffic from the [Akamai source IP addresses](https://github.com/IBM-Cloud/kube-samples/tree/master/akamai/gtm-liveness-test){: external} before 07 July. After the migration completes on 31 July, you can remove the Cloudflare IP address rules.</li><li>The Akamai health check does not support verification of the body of the health check response. Update any custom health check rules that you configured for Cloudflare that use verification of the body of the health check responses.</li><li>Cluster subdomains that were health checked in Cloudflare are now registered in the Akamai DNS as CNAME records. These CNAME records point to an Akamai Global Traffic Management domain that health checks the subdomains. When a client runs a DNS query for a health checked subdomain, a CNAME record is returned to the client, as opposed to Cloudflare, in which an A record was returned. If your client expects an A record for a subdomain that was health checked in Cloudflare, update your logic to accept a CNAME record.</li><li>During the migration, an Akamai Global Traffic Management health check was automatically created for any subdomains that had a Cloudflare health check. If you previously created a Cloudflare health check for a subdomain, and you create an Akamai health check for the subdomain after the migration, the two Akamai health checks might conflict. In this case, use the `ibmcloud ks nlb-dns monitor disable` command to disable the Akamai health check that the migration automatically configured for your subdomain.</li></ul>For more information, see the [announcement](https://cloud.ibm.com/notifications?selected=1621697674798){: external}.</p>

## Customizing routing with annotations
{: #annotations}

To customize routing for Ingress, you can add [Kubernetes NGINX annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/){: external} (`nginx.ingress.kubernetes.io/<annotation>`). Custom {{site.data.keyword.containerlong_notm}} annotations (`ingress.bluemix.net/<annotation>`) are **not** supported.
{: shortdesc}

The following sections compares the custom {{site.data.keyword.containerlong_notm}} annotations with equivalent Kubernetes NGINX annotations. If no equivalent Kubernetes NGINX annotation exists, alternate options, such as configuring a field in the `ibm-k8s-controller-config` configmap or the `ibm-ingress-deploy-config` configmap, are listed.

Kubernetes NGINX annotations are always applied to all service paths in the resource, and you cannot specify service names within the annotations.
{: note}

### Add server port to host header

Add a server port to the client request before the request is forwarded to your back-end app.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/add-host-port: "enabled=true serviceName=app1"
```
{: screen}

Kubernetes Ingress field: No equivalent annotation exists. Configure proxying external services in a [server snippet annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#server-snippet){:external} or as an `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#proxy-set-headers){:external}.


### ALB ID

Route incoming requests to your apps with a private ALB.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/alb-id: "private_ALB_ID"
```
{: screen}

Kubernetes Ingress resource [annotation](/docs/containers?topic=containers-ingress-types#alb-comm-create): Private ALBs are configured to use resources with this class.

```
kubernetes.io/ingress.class: "private-iks-k8s-nginx"
```
{: screen}

### {{site.data.keyword.appid_short_notm}} authentication
{: #app-id-authentication}

Configure Ingress with [{{site.data.keyword.appid_full_notm}}](https://cloud.ibm.com/catalog/services/app-id){: external} to enforce authentication for your apps.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/appid-auth: "bindSecret=bind_secret namespace=default requestType=web serviceName=app1 idToken=true"
```
{: screen}

Kubernetes Ingress field: See [Adding {{site.data.keyword.appid_short_notm}} authentication to apps](#app-id).


### Client request body size

Set the maximum size of the body that the client can send as part of a request.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotations:

```
ingress.bluemix.net/client-max-body-size: "serviceName=app1 size=200m"
```
{: screen}

Kubernetes Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#custom-max-body-size){:external}:

```
nginx.ingress.kubernetes.io/proxy-body-size: 8m
```
{: screen}

Or, Kubernetes `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#proxy-body-size){: external}:

```
proxy-body-size: 200m
```
{: screen}


### Client response data buffering

Disable or enable the storage of response data on the ALB while the data is sent to the client.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/proxy-buffering: "enabled=false serviceName=app1"
```
{: screen}

Kubernetes Ingress field: Disabled by default. To enable, set the Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#rewrite){:external}:

```
nginx.ingress.kubernetes.io/proxy-buffering: "on"
```
{: screen}


### Custom connect and read timeouts

Set the time that the ALB waits to connect to and read from the back-end app before the back-end app is considered unavailable.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotations:

```
ingress.bluemix.net/proxy-connect-timeout: "serviceName=app1 timeout=62s"
```
{: screen}
```
ingress.bluemix.net/proxy-read-timeout: "serviceName=app1 timeout=62s"
```
{: screen}

Kubernetes Ingress resource [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#custom-timeouts){:external}:

```
nginx.ingress.kubernetes.io/proxy-connect-timeout: 62
```
{: screen}
```
nginx.ingress.kubernetes.io/proxy-read-timeout: 62
```
{: screen}


### Custom error actions

Indicate custom actions that the ALB can take for specific HTTP errors.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotations:

```
ingress.bluemix.net/custom-errors: "serviceName=app1 httpError=401 errorActionName=/errorAction401"
```
{: screen}
```
ingress.bluemix.net/custom-error-actions: |
  errorActionName=/errorAction401
  proxy_pass http://example.com/forbidden.html;
  <EOS>
```
{: screen}

Kubernetes Ingress field: See the [`custom-http-errors` documentation](https://kubernetes.github.io/ingress-nginx/examples/customization/custom-errors/){:external}.


### Custom HTTP and HTTPS ports

Change the default ports for HTTP (port 80) and HTTPS (port 443) network traffic.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress fields:
* Ingress resource annotation:
    ```
    ingress.bluemix.net/custom-port: "protocol=http port=8080;protocol=https port=8443"
    ```
    {: screen}
* `ibm-cloud-provider-ingress-cm` configmap field:
    ```
    public-ports: "80;443;9443"
    ```
    {: screen}

Kubernetes Ingress fields:
1. `ibm-ingress-deploy-config` configmap [fields](#comm-customize-deploy):
    ```
    httpPort=8080
    httpsPort=8443
    ```
    {: screen}
2. [Modify each ALB service](#comm-customize-deploy) to add the ports.


### Custom request header

Add header information to a client request before forwarding the request to your back-end app.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/proxy-add-headers: |
  serviceName=app1 {
  X-Different-Name “true”;
  x-request-start “t=${sec}”;
  x-using-nginx “true”
  }
```
{: screen}

Kubernetes `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#proxy-set-headers):

```
proxy-set-headers: "ingress-nginx/custom-headers"
```
{: screen}

For the `custom-headers` configmap requirements, see [this example](https://github.com/kubernetes/ingress-nginx/blob/master/docs/examples/customization/custom-headers/custom-headers.yaml){:external}.


### Custom response header

Add header information to a client response before sending it to the client.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/response-add-headers: |
  serviceName=<myservice1> {
  <header1>:<value1>;
```
{: screen}

Kubernetes Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#configuration-snippet){:external}:

```
nginx.ingress.kubernetes.io/configuration-snippet: |
  more_set_headers "Request-Id: $req_id";
```
{: screen}


### External services

Add path definitions to external services, such as services hosted in IBM Cloud.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/proxy-external-service: "path=/path external-svc=https:myexternal_service host=ingress_subdomain"
```
{: screen}

Kubernetes Ingress field: No equivalent annotation exists. Configure proxying external services in a [location snippet](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#configuration-snippet){:external} or replace proxying with a [permanent redirect to external services](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#permanent-redirect){:external}.


### HTTP redirects to HTTPS

Convert insecure HTTP client requests to HTTPS.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/redirect-to-https: "True"
```
{: screen}

Kubernetes Ingress fields: HTTP redirects to HTTPS by default. To disable:

* `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#server-side-https-enforcement-through-redirect){:external}:
    ```
    ssl-redirect: "false"
    ```
    {: screen}
* Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#server-side-https-enforcement-through-redirect){:external}:
    ```
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    ```
    {: screen}


### HTTP Strict Transport Security

Set the browser to access the domain only by using HTTPS.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/hsts: enabled=true maxAge=31536000 includeSubdomains=true
```
{: screen}

Kubernetes Ingress fields: HSTS is enabled by default.
* To add max age and subdomain granularity, see [this NGINX blog](https://www.nginx.com/blog/http-strict-transport-security-hsts-and-nginx/){:external}.
* To disable, set the `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#hsts){:external}:
    ```
    hsts: false
    ```
    {: screen}


### Keepalive requests

Set the maximum number of requests that can be served through one keepalive connection.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/keepalive-requests: "serviceName=app1 requests=100"
```
{: screen}

Kubernetes `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#keep-alive-requests){:external}:

```
keep-alive-requests: 100
```
{: screen}

The default value for `keep-alive-requests` in Kubernetes Ingress is `100`, which is much lower than the default value of `4096` in {{site.data.keyword.containerlong_notm}} Ingress. If you migrated your Ingress setup from {{site.data.keyword.containerlong_notm}} Ingress to Kubernetes Ingress, you might need to change `keep-alive-requests` to pass existing performance tests.
{: note}

### Keepalive request timeout

Set the maximum time that a keepalive connection stays open between the client and the ALB proxy server.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/keepalive-timeout: "serviceName=app1 timeout=60s"
```
{: screen}


Kubernetes `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#keep-alive){:external}:

```
keep-alive: 60
```
{: screen}

### Large client header buffers

Set the maximum number and size of buffers that read large client request headers.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/large-client-header-buffers: "number=4 size=8k"
```
{: screen}

Kubernetes `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#large-client-header-buffers){:external}:

```
large-client-header-buffers: 4 8k
```
{: screen}


### Location modifier

Modify the way the ALB matches the request URI against the app path.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/location-modifier: "modifier='~' serviceName=app1"
```
{: screen}

Kubernetes Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#use-regex){:external}:

```
nginx.ingress.kubernetes.io/use-regex: "true"
```
{: screen}

For more info, see [this blog](https://kubernetes.github.io/ingress-nginx/user-guide/ingress-path-matching/#ingress-path-matching){: external}.


### Location snippets

Add a custom location block configuration for a service.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/location-snippets: |
  serviceName=app1
  more_set_headers "Request-Id: $req_id";
  <EOS>
```
{: screen}

Kubernetes Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#configuration-snippet){:external}:

```
nginx.ingress.kubernetes.io/configuration-snippet: |
  more_set_headers "Request-Id: $req_id";
```
{: screen}


### Mutual authentication

Configure mutual authentication for the ALB.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/mutual-auth: "secretName=mysecret port=9080 serviceName=app1"
```
{: screen}

Kubernetes Ingress resource [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#client-certificate-authentication){:external}:

```
nginx.ingress.kubernetes.io/auth-tls-verify-client: "on"
nginx.ingress.kubernetes.io/auth-tls-secret: "default/ca-secret"
nginx.ingress.kubernetes.io/auth-tls-verify-depth: "1"
nginx.ingress.kubernetes.io/auth-tls-error-page: "http://www.mysite.com/error-cert.html"
nginx.ingress.kubernetes.io/auth-tls-pass-certificate-to-upstream: "true"
```
{: screen}

Note that mutual authentication cannot be applied to custom ports and must be applied to the HTTPS port.


### Proxy buffer size

Configure the size of the proxy buffer that reads the first part of the response.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/proxy-buffer-size: "serviceName=app1 size=8k"
```
{: screen}

Kubernetes Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#proxy-buffer-size){:external}:

```
nginx.ingress.kubernetes.io/proxy-buffer-size: "8k"
```
{: screen}


### Proxy buffers

Configure the number and size of proxy buffers for the ALB.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/proxy-buffers: "serviceName=app1 number=4 size=8k"
```
{: screen}

Kubernetes Ingress resource [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#proxy-buffering){:external}:

```
nginx.ingress.kubernetes.io/proxy-buffers-number: "4"
nginx.ingress.kubernetes.io/proxy-buffer-size: "8k"
```
{: screen}


### Proxy busy buffers size

Configure the size of proxy buffers that can be busy.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/proxy-busy-buffers-size: "serviceName=app1 size=8k"
```
{: screen}

Kubernetes Ingress field: No equivalent annotation exists. Configure proxying external services in a [location snippet](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#configuration-snippet){:external}. For more info, see the [NGINX docs](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_busy_buffers_size){: external}.


### Proxy next upstream

Set when the ALB can pass a request to the next upstream server.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/proxy-next-upstream-config: "serviceName=app1 retries=3 timeout=50s http_502=true non_idempotent=true"
```
{: screen}

Kubernetes Ingress fields:
* Global setting: `ibm-k8s-controller-config` configmap [fields](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_next_upstream){:external}:
    ```
    retry-non-idempotent: true
    proxy-next-upstream: error timeout http_500
    ```
    {: screen}
* Per-resource setting: Ingress resource [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#custom-timeouts){:external}:
    ```
    nginx.ingress.kubernetes.io/proxy-next-upstream: http_500
    nginx.ingress.kubernetes.io/proxy-next-upstream-timeout: 50
    nginx.ingress.kubernetes.io/proxy-next-upstream-tries: 3
    ```
    {: screen}


### Rate limiting

Limit the request processing rate and number of connections per a defined key for all or specific services.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotations:

```
ingress.bluemix.net/global-rate-limit: "key=location rate=10r/s conn=75"
ingress.bluemix.net/service-rate-limit: "serviceName=app1 key=location rate=10r/s conn=75"
```
{: screen}

Kubernetes Ingress field: No directly equivalent annotation exists, but several Ingress resource [annotations for rate limiting](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#rate-limiting){: external} are available.


### Response header removal

Remove header information that is included in the client response from the back-end end app before the response is sent to the client.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/response-remove-headers: |
      serviceName=app1 {
      "header1";
      }
```
{: screen}

Kubernetes Ingress field: No equivalent annotation exists. Configure response header removal in a [location snippet](https://github.com/openresty/headers-more-nginx-module#more_clear_headers){:external}, or use the [`proxy_hide_header` field](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_hide_header){:external} as a [configuration snippet](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#configuration-snippet){: external} in the `ibm-k8s-controller-config` configmap.


### Rewrite paths

Route incoming network traffic on an ALB domain path to a different path that your back-end app listens on.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/rewrite-path: "serviceName=app1 rewrite=/newpath
```
{: screen}

Kubernetes Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#rewrite){:external}:

```
nginx.ingress.kubernetes.io/rewrite-target: /newpath
```
{: screen}


### Server snippets

Add a custom server block configuration.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/server-snippets: |
  location = /health {
  return 200 'Healthy';
  add_header Content-Type text/plain;
  }
```
{: screen}

Kubernetes Ingress resource [annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#server-snippet){:external}:

```
nginx.ingress.kubernetes.io/server-snippet: |
  location = /health {
  return 200 'Healthy';
  add_header Content-Type text/plain;
  }
```
{: screen}


### Session affinity with cookies

Always route incoming network traffic to the same upstream server by using a sticky cookie.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/sticky-cookie-services: "serviceName=app1 path=/app1 name=cookie_name1 expires=48h secure httponly"
```
{: screen}

Kubernetes Ingress resource [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#session-affinity){:external}:

```
nginx.ingress.kubernetes.io/affinity: "cookie"
nginx.ingress.kubernetes.io/session-cookie-name: "cookie_name1"
nginx.ingress.kubernetes.io/session-cookie-expires: "172800"
nginx.ingress.kubernetes.io/session-cookie-max-age: "172800"
nginx.ingress.kubernetes.io/configuration-snippet: |
  more_set_headers "Set-Cookie: HttpOnly";
```
{: screen}

The Kubernetes Ingress controller adds the `Secure` and `HttpOnly` attributes to the sticky cookies by default, which cannot be changed.


### SSL services support

Allow SSL services support to encrypt traffic to your upstream apps that require HTTPS.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/ssl-services: ssl-service=app1 ssl-secret=app1-ssl-secret proxy-ssl-verify-depth=5 proxy-ssl-name=proxy-ssl-name=mydomain.com
```
{: screen}

Kubernetes Ingress resource [backend protocol annotation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#backend-protocol){: external} and [backend certificate authentication annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#backend-certificate-authentication){:external}:

```
nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
nginx.ingress.kubernetes.io/proxy-ssl-secret: app1-ssl-secret
nginx.ingress.kubernetes.io/proxy-ssl-verify-depth: 5
nginx.ingress.kubernetes.io/proxy-ssl-name: proxy-ssl-name=mydomain.com
nginx.ingress.kubernetes.io/proxy-ssl-verify: true
```
{: screen}


### TCP ports

Access an app via a non-standard TCP port.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/tcp-ports: "serviceName=app1 ingressPort=9000 servicePort=8080"
```
{: screen}

Kubernetes Ingress fields:
1.  Create a `tcp-services` configmap to specify your TCP port, such as the following example ports. For the requirements of the `tcp-services` configmap, see [this blog](https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/){:external}.
    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: tcp-services
      namespace: kube-system
    data:
      9000: "<namespace>/<service>:8080"
    ```
    {: codeblock}

2. Create the configmap in the `kube-system` namespace.
  ```
  kubectl apply -f tcp-services.yaml -n kube-system
  ```
  {: pre}

3. Specify the `tcp-services` configmap as a field in the [`ibm-ingress-deploy-config` configmap](#comm-customize-deploy).
  ```
  "tcpServicesConfig":"kube-system/tcp-services"
  ```
  {: screen}

4. [Modify each ALB service](#comm-customize-deploy) to add the ports.

### Upstream fail timeout

Set the amount of time during which the ALB can attempt to connect to the server.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/upstream-fail-timeout: "serviceName=app1 fail-timeout=10s"
```
{: screen}

Kubernetes Ingress field: Currently, no configuration option for the Kubernetes Ingress exists.


### Upstream keepalive requests

Set the maximum number of requests that can be served through one keepalive connection.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/upstream-keepalive: "serviceName=app1 requests=32”
```
{: screen}

Kubernetes `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#upstream-keepalive-requests){:external}:

```
upstream-keepalive-requests: 32
```
{: screen}


### Upstream keepalive timeout

Set the maximum time that a keepalive connection stays open between the ALB proxy server and your app's upstream server.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/upstream-keepalive-timeout: "serviceName=app1 timeout=32s"
```
{: screen}

Kubernetes `ibm-k8s-controller-config` configmap [field](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#upstream-keepalive-timeout){:external}:

```
upstream-keepalive-timeout: 32
```
{: screen}


### Upstream max fails

Set the maximum number of unsuccessful attempts to communicate with the server.
{: shortdesc}

Previous {{site.data.keyword.containerlong_notm}} Ingress resource annotation:

```
ingress.bluemix.net/upstream-max-fails: "serviceName=app1 max-fails=2"
```
{: screen}

Kubernetes Ingress field: Currently, no configuration option for the Kubernetes Ingress exists.

<br />

## Customizing the ALB deployment
{: #comm-customize-deploy}

Customize the deployment for ALBs that run the Kubernetes Ingress image by creating an `ibm-ingress-deploy-config` configmap.
{: shortdesc}

1. Get the names of the services that expose each ALB.
  * Classic clusters:
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}
  * VPC clusters: In the output, look for a service name that is formatted such as `public-crc204dl7w0qf6n6sp7tug`.
    ```
    kubectl get svc -n kube-system | grep LoadBalancer
    ```
    {: pre}

2. Create a configmap to customize the Ingress deployment.

  1. Create a YAML file for an `ibm-ingress-deploy-config` configmap. For each ALB ID, you can specify one or more of the following optional settings. Note that you can specify only the settings that you want to configure, and do not need to specify all of the settings.
     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: ibm-ingress-deploy-config
       namespace: kube-system
     data:
       <alb1-id>: '{"defaultBackendService":"<service_name>", "defaultCertificate":"<namespace>/<secret_name>", "enableSslPassthrough":"<true|false>", "httpPort":"<port>", "httpsPort":"<port>", "ingressClass":"<class>", "replicas":<number_of_replicas>, "tcpServicesConfig":"<kube-system/tcp-services>"}'
       <alb2-id>: '{"defaultBackendService":"<service_name>", "defaultCertificate":"<namespace>/<secret_name>", "enableSslPassthrough":"<true|false>", "httpPort":"<port>", "httpsPort":"<port>", "ingressClass":"<class>", "replicas":<number_of_replicas>, "tcpServicesConfig":"<kube-system/tcp-services>"}'
       ...
     ```
     {: screen}

     <table summary="The columns are read from left to right. The first column has the parameter of the configmap. The second column describes the parameter.">
     <caption>Understanding this configmap's components</caption>
     <col width="25%">
     <thead>
     <th>Parameter</th>
     <th>Description</th>
     </thead>
     <tbody>
     <tr><td>`defaultBackendService`</td><td>Specify the name of an optional default service to receive requests when no host is configured or no matching host is found. This service replaces the IBM-provided default service that generates a `404` message. You might use this service to configure custom error pages or for testing connections.</td></tr>
     <tr><td>`defaultCertificate`</td><td>A secret for a default TLS certificate to apply to any subdomain that is configured with Ingress ALBs in the format `secret_namespace/secret_name`. To create a secret, you can run the [`ibmcloud ks ingress secret create` command](/docs/containers?topic=containers-ingress-types#manage_certs). If a secret for a different TLS certificate is specified in the `spec.tls` section of an Ingress resource, and that secret exists in the same namespace as the Ingress resource, then that secret is applied instead of this default secret.</td></tr>
     <tr><td>`enableSslPassthrough`</td><td>Enable SSL passthrough for the ALB. The TLS connection is not terminated and passes through untouched.</td></tr>
     <tr><td>`httpPort`, `httpsPort`</td><td>Expose non-default ports for the Ingress ALB by adding the HTTP or HTTPS ports that you want to open.</td></tr>
     <tr><td>`ingressClass`</td><td>If you specified a class other than `public-iks-k8s-nginx` or `private-iks-k8s-nginx` in your Ingress resource, specify the class.</td></tr>
     <tr><td>`replicas`</td><td>By default, each ALB has 2 replicas. Scale up your ALB processing capabilities by increasing the number of ALB pods. For more information, see [Increasing the number of ALB pod replicas](/docs/containers?topic=containers-ingress-types#scale_albs).</td></tr>
     <tr><td>`tcpServicesConfig`</td><td>Specify a configmap and the namespace that the configmap is in, such as [`kube-system/tcp-services`](#tcp-ports), that contains information about accessing your app service through a non-standard TCP port.</td></tr>
     </tbody>
     </table>

  2. Create the `ibm-ingress-deploy-config` configmap in your cluster.
    ```
    kubectl create -f ibm-ingress-deploy-config.yaml
    ```
    {: pre}

  3. To pick up the changes, update your ALBs. Note that it might take up to 5 minutes for the changes to be applied to your ALBs.
    ```
    ibmcloud ks ingress alb update -c <cluster_name_or_ID>
    ```
    {: pre}

3. If you specified non-standard HTTP, HTTPS, or TCP ports, you must open the ports on each ALB service.
  1. For each ALB service that you found in step 1, edit the YAML file.
    ```
    kubectl edit svc -n kube-system <alb_svc_name>
    ```
    {: pre}

  2. In the `spec.ports` section, add the ports that you want to open.
      * By default, ports 80 and 443 are open. If you want to keep 80 and 443 open, do not remove them from this file. Any port that is not specified is closed.
      * Do not specify a `nodePort`. After you add the port and apply the changes, a `nodePort` is automatically assigned.

      Example:
      ```
      ...
        ports:
        - name: port-80
          nodePort: 32632
          port: 80
          protocol: TCP
          targetPort: 80
        - name: port-443
          nodePort: 32293
          port: 443
          protocol: TCP
          targetPort: 443
        - name: <new_port>
          port: <port>
          protocol: TCP
          targetPort: <port>
      ...
      ```
      {: screen}

  3. Save and close the file. Your changes are applied automatically.

4. If you use {{site.data.keyword.blockchainfull}}, you must [re-establish connectivity between the {{site.data.keyword.blockchain}} management console and your cluster](/docs/blockchain?topic=blockchain-ibp-console-manage-console#ibp-console-refresh).

<br />

## Customizing the Ingress class
{: #-custom-ingress-class}

An Ingress class associates a class name with an Ingress controller type. Use the `IngressClass` resource to customize Ingress classes.
{: shortdesc}

For more information, see [Customizing the Ingress class](/docs/containers?topic=containers-ingress-types#ingress-class).

<br />

## Adding {{site.data.keyword.appid_short_notm}} authentication to apps
{: #app-id}

Enforce authentication for your apps by configuring Ingress with [{{site.data.keyword.appid_full_notm}}](https://cloud.ibm.com/catalog/services/app-id){: external}.
{: shortdesc}

1. Choose an existing or create a new {{site.data.keyword.appid_short_notm}} instance.

  <p class="note">An {{site.data.keyword.appid_short_notm}} instance can be used in only one namespace in your cluster. If you want to configure {{site.data.keyword.appid_short_notm}} for Ingress resources in multiple namespaces, repeat the steps in this section to specify a unique {{site.data.keyword.appid_short_notm}} instance for the Ingress resources in each namespace.</p>
  * To use an existing instance, ensure that the service instance name contains only **lowercase** alphanumeric characters or hyphens (`-`), and doesn't contain spaces. To change the name, select **Rename service** from the more options menu on your service instance details page.
  * To provision a [new {{site.data.keyword.appid_short_notm}} instance](https://cloud.ibm.com/catalog/services/app-id):
      1. Replace the auto-filled **Service name** with your own unique name for the service instance. The service instance name must contain only lowercase alphanumeric characters or hyphens (`-`), and can't contain spaces.
      2. Choose the same region that your cluster is deployed in.
      3. Click **Create**.

2. Add redirect URLs for your app. A redirect URL is the callback endpoint of your app. To prevent phishing attacks, {{site.data.keyword.appid_full_notm}} validates the request URL against the allowlist of redirect URLs.
  1. In the {{site.data.keyword.appid_short_notm}} management console, navigate to **Manage Authentication**.
  2. In the **Identity providers** tab, make sure that you have an Identity Provider selected. If no Identity Provider is selected, the user will not be authenticated but will be issued an access token for anonymous access to the app.
  3. In the **Authentication settings** tab, add redirect URLs for your app in the format `https://<hostname>/oauth2-<App_ID_service_instance_name>/callback`. Note that all letters in the service instance name must specified as lowercase.

    If you use the [{{site.data.keyword.appid_full_notm}} logout function](/docs/appid?topic=appid-cd-sso#cd-sso-log-out), you must append `/sign_out` to your domain in the format `https://<hostname>/oauth2-<App_ID_service_instance_name>/sign_out` and include this URL in the redirect URLs list.
    {: note}

3. Bind the {{site.data.keyword.appid_short_notm}} service instance to your cluster. The command creates a service key for the service instance, or you can include the `--key` flag to use existing service key credentials. Be sure to bind the service instance to the same namespace that your Ingress resources exist in. Note that all letters in the service instance name must specified as lowercase.
  ```
  ibmcloud ks cluster service bind --cluster <cluster_name_or_ID> --namespace <namespace> --service <App_ID_service_instance_name> [--key <service_instance_key>]
  ```
  {: pre}
  When the service is successfully bound to your cluster, a cluster secret is created that holds the credentials of your service instance. Example CLI output:
  ```
  ibmcloud ks cluster service bind --cluster mycluster --namespace mynamespace --service appid1
  Binding service instance to namespace...
  OK
  Namespace:    mynamespace
  Secret name:  binding-<service_instance_name>
  ```
  {: screen}

4. Enable the ALB OAuth Proxy add-on in your cluster. This add-on creates and manages the following Kubernetes resources: an OAuth2-Proxy deployment for your {{site.data.keyword.appid_short_notm}} service instance, a secret that contains the configuration of the OAuth2-Proxy deployment, and an Ingress resource that configures ALBs to route incoming requests to the OAuth2-Proxy deployment for your {{site.data.keyword.appid_short_notm}} instance. The name of each of these resources begins with `oauth2-`.
    1. Enable the `alb-oauth-proxy` add-on.
      ```
      ibmcloud ks cluster addon enable alb-oauth-proxy --cluster <cluster_name_or_ID>
      ```
      {: pre}
    2. Verify that the ALB OAuth Proxy add-on has a status of `Addon Ready`.
      ```
      ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
      ```
      {: pre}

5. In the Ingress resources for apps where you want to add {{site.data.keyword.appid_short_notm}} authentication, add the following annotations to the `metadata.annotations` section.
  1. Add the following `auth-url` annotation. This annotation specifies the URL of the OAuth2-Proxy for your {{site.data.keyword.appid_short_notm}} instance, which acts as the OIDC Relying Party (RP) for {{site.data.keyword.appid_short_notm}}. Note that all letters in the service instance name must be specified as lowercase.
     ```yaml
     ...
     annotations:
       nginx.ingress.kubernetes.io/auth-url: https://oauth2-<App_ID_service_instance_name>.<namespace_of_Ingress_resource>.svc.cluster.local/oauth2-<App_ID_service_instance_name>/auth
     ...
     ```
     {: codeblock}

  2. Choose which tokens to send in the `Authorization` header to your app. For more information about ID and access tokens, see the [{{site.data.keyword.appid_short_notm}} documentation](/docs/appid?topic=appid-tokens){: external}.
     * To send only the `ID Token`, add the `nginx.ingress.kubernetes.io/auth-response-headers: Authorization` annotation.
     * To send only the `Access Token`, add the following information to the `access_by_lua_block{}` in the `configuration-snippet` annotation.
       ```yaml
       ...
       annotations:
         nginx.ingress.kubernetes.io/configuration-snippet: |
           auth_request_set $access_token $upstream_http_x_auth_request_access_token;
           access_by_lua_block {
             if ngx.var.access_token ~= "" then
               ngx.req.set_header("Authorization", "Bearer " .. ngx.var.access_token)
             end
           }
       ...
       ```
       {: codeblock}
     * To send the `Access Token` and the `ID Token`, add the following information to the `access_by_lua_block{}` in the `configuration-snippet` annotation.
       ```yaml
       ...
       annotations:
         nginx.ingress.kubernetes.io/configuration-snippet: |
           auth_request_set $access_token $upstream_http_x_auth_request_access_token;
           auth_request_set $id_token $upstream_http_authorization;
           access_by_lua_block {
             if ngx.var.id_token ~= "" and ngx.var.access_token ~= "" then
               ngx.req.set_header("Authorization", "Bearer " .. ngx.var.access_token .. " " .. ngx.var.id_token:match("%s*Bearer%s*(.*)"))
             end
           }
       ...
       ```
       {: codeblock}
  3. Optional: If your app supports the [web app strategy](/docs/appid?topic=appid-key-concepts#term-web-strategy) in addition to or instead of the [API strategy](/docs/appid?topic=appid-key-concepts#term-api-strategy), add the `nginx.ingress.kubernetes.io/auth-signin: https://$host/oauth2-<App_ID_service_instance_name>/start?rd=$escaped_request_uri` annotation. Note that all letters in the service instance name must specified as lowercase.
    * If you specify this annotation, and the authentication for a client fails, the client is redirected to the URL of the OAuth2-Proxy for your {{site.data.keyword.appid_short_notm}} instance. This OAuth2-Proxy, which acts as the OIDC Relying Party (RP) for {{site.data.keyword.appid_short_notm}}, redirects the client to your {{site.data.keyword.appid_short_notm}} login page for authentication.
    * If you do not specify this annotation, a client must authenticate with a valid bearer token. If the authentication for a client fails, the client's request is rejected with a `401 Unauthorized` error message.

6. Re-apply your Ingress resources to enforce {{site.data.keyword.appid_short_notm}} authentication. After an Ingress resource with the appropriate annotations is re-applied, the ALB OAuth Proxy add-on deploys an OAuth2-Proxy deployment, creates a service for the deployment, and creates a separate Ingress resource to configure routing for the OAuth2-Proxy deployment messages. Do not delete these add-on resources.
  ```
  kubectl apply -f <app_ingress_resource>.yaml -n namespace
  ```
  {: pre}

7. Verify that {{site.data.keyword.appid_short_notm}} authentication is enforced for your apps.
  * If your apps supports the [web app strategy](/docs/appid?topic=appid-key-concepts#term-web-strategy): Access your app's URL in a web browser. If {{site.data.keyword.appid_short_notm}} is correctly applied, you are redirected to an {{site.data.keyword.appid_short_notm}} authentication log-in page.
  * If your apps supports the [API strategy](/docs/appid?topic=appid-key-concepts#term-api-strategy): Specify your `Bearer` access token in the Authorization header of requests to the apps. To get your access token, see the [{{site.data.keyword.appid_short_notm}} documentation](/docs/appid?topic=appid-obtain-tokens). If {{site.data.keyword.appid_short_notm}} is correctly applied, the request is successfully authenticated and is routed to your app. If you send requests to your apps without an access token in the Authorization header, or if the access token is not accepted by {{site.data.keyword.appid_short_notm}}, then the request is rejected.

8. Optional: You can customize the default behavior of the OAuth2-Proxy by creating a Kubernetes ConfigMap.
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
         # Format for authentication logs. For more info, see https://oauth2-proxy.github.io/oauth2-proxy/configuration#auth-log-format
         cookie_domains:
         # A list of optional domains to force cookies to. The longest domain that matches the request’s host is used. If there is no match for the request’s host, the shortest domain is used. Example: sub.domain.com,example.com
         cookie_expire: "168h0m0s"
         # Expiration timeframe for cookies. Default: "168h0m0s".
         cookie_samesite: ""
         # SameSite attribute for cookies. Supported values: "lax", "strict", "none", or "".
         email_domains: ""
         # Authenticate IDs that use the specified email domain. To authenticate IDs that use any email domain, use "*". Default: "". Example: example.com,example2.com
         pass_access_token: <true|false>
         # Pass the OAuth access token to the backend app via the X-Forwarded-Access-Token header.
         request_logging: <true|false>
         # Log all requests to the backend app.
         request_logging_format:
         # Format for request logs. For more info, see https://oauth2-proxy.github.io/oauth2-proxy/configuration#request-log-format
         scope:
         # Scope of the OAuth authentication. For more info, see https://oauth.net/2/scope/
         set_authorization_header: <true|false>
         # Set the Authorization Bearer response header when the app responds to the Ingress ALB, such when using the NGINX auth_request mode.
         set_xauthrequest: <true|false>
         # Set X-Auth-Request-User, X-Auth-Request-Email, and X-Auth-Request-Preferred-Username response headers when the app responds to the Ingress ALB, such as when using the NGINX auth_request mode.
         standard_logging: <true|false>
         # Log standard runtime information.
         standard_logging_format:
         # Format for standard logs. For more info, see https://oauth2-proxy.github.io/oauth2-proxy/configuration#standard-log-format
         tls_secret_name:
         # The name of a secret that contains the server-side TLS certificate and key to enable TLS between the OAuth2-Proxy and the Ingress ALB. By default, the TLS secret defined in your Ingress resources is used.
       ```
       {: codeblock}
    2. Apply the ConfigMap resource to your add-on. Your changes are applied automatically.
      ```
      kubectl apply -f oauth2-<App_ID_service_instance_name>.yaml
      ```
      {: pre}

For the list of changes for each ALB OAuth Proxy add-on version, see the [{{site.data.keyword.cloud_notm}} ALB OAuth Proxy add-on changelog](/docs/containers?topic=containers-alb-oauth-proxy-changelog).
{: tip}

<br />

## Preserving the source IP address
{: #preserve_source_ip}

By default, the source IP addresses of client requests are not preserved by the Ingress ALB. To preserve source IP addresses, you can enable the [PROXY protocol in VPC clusters](#preserve_source_ip_vpc) or [change the `externalTrafficPolicy` in classic clusters](#preserve_source_ip_classic).
{: shortdesc}

### Enabling the PROXY protocol in VPC clusters
{: #preserve_source_ip_vpc}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> To preserve the source IP address of the client request in a VPC cluster, you can enable the [NGINX PROXY protocol](https://docs.nginx.com/nginx/admin-guide/load-balancer/using-proxy-protocol/){: external} for all load balancers that expose Ingress ALBs in your cluster.
{: shortdesc}

The PROXY protocol enables load balancers to pass client connection information that is contained in headers on the client request, including the client IP address, the proxy server IP address, and both port numbers, to ALBs.

1. Enable the PROXY protocol. For more information about this command's parameters, see the [CLI reference](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_ingress_lb_proxy-protocol_enable).<p class="important">After you run this command, new load balancers are created with the updated PROXY protocol configuration. Two unused IP addresses for each load balancer must be available in each subnet during the load balancer recreation. After these load balancers are created, the existing ALB load balancers are deleted. This load balancer recreation process might cause service disruptions.</p>
  ```
  ibmcloud ks ingress lb proxy-protocol enable --cluster <cluster_name_or_ID> --cidr <subnet_CIDR> --header-timeout <timeout>
  ```
  {: pre}

2. Confirm that the PROXY protocol is enabled for the load balancers that expose ALBs in your cluster.
  ```
  ibmcloud ks ingress lb get --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. To later disable the PROXY protocol, you can run the following command:
  ```
  ibmcloud ks ingress lb proxy-protocol disable --cluster <cluster_name_or_ID>
  ```
  {: pre}

### Changing the `externalTrafficPolicy` in classic clusters
{: #preserve_source_ip_classic}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Preserve the source IP address for client requests in a classic cluster.
{: shortdesc}

By default, the source IP address of the client request is not preserved. When a client request to your app is sent to your cluster, the request is routed to a pod for the load balancer service that exposes the ALB. If no app pod exists on the same worker node as the load balancer service pod, the load balancer forwards the request to an app pod on a different worker node. The source IP address of the package is changed to the public IP address of the worker node where the app pod runs.

To preserve the original source IP address of the client request, you can enable [source IP preservation](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer){: external}. Preserving the client’s IP is useful, for example, when app servers have to apply security and access-control policies.

<p class="note">When source IP preservation is enabled, load balancers shift from forwarding traffic to an app pod on a different worker node to an app pod on the same worker node. Your apps might experience downtime during this shift.</br></br>If you [disable an ALB](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure), any source IP changes you make to the load balancer service that exposes the ALB are lost. When you re-enable the ALB, you must enable source IP again.</p>

**Before you begin**: If you configured edge nodes in your cluster, ALB pods are deployed to edge nodes and can only forward traffic to app pods that are also deployed to those edge nodes. Ensure that you have [at least three edge worker nodes per zone](/docs/containers?topic=containers-edge#edge_nodes).

To enable source IP preservation, edit the load balancer service that exposes an Ingress ALB:

1. Enable source IP preservation for a single ALB or for all the ALBs in your cluster.
    * To set up source IP preservation for a single ALB:
        1. Get the ID of the ALB for which you want to enable source IP. The ALB services have a format similar to `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` for a public ALB or `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` for a private ALB.
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Open the YAML for the load balancer service that exposes the ALB.
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. Under **`spec`**, change the value of **`externalTrafficPolicy`** from `Cluster` to `Local`.

        4. Save and close the configuration file. The output is similar to the following:

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * To set up source IP preservation for all public ALBs in your cluster, run the following command:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Example output:
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * To set up source IP preservation for all private ALBs in your cluster, run the following command:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Example output:
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Verify that the source IP is being preserved in your ALB pods logs.
    1. Get the ID of a pod for the ALB that you modified.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Open the logs for that ALB pod. Verify that the IP address for the `client` field is the client request IP address instead of the load balancer service IP address.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. Now, when you look up the headers for the requests that are sent to your back-end app, you can see the client IP address in the `x-forwarded-for` header.

4. If you no longer want to preserve the source IP, you can revert the changes that you made to the service.
    * To revert source IP preservation for your public ALBs:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * To revert source IP preservation for your private ALBs:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />

## Configuring SSL protocols and SSL ciphers at the HTTP level
{: #ssl_protocols_ciphers}

Enable SSL protocols and ciphers at the global HTTP level by editing the `ibm-cloud-provider-ingress-cm` configmap.
{: shortdesc}

For example, if you still have legacy clients that require TLS 1.0 or 1.1 support, you must manually enable these TLS versions to override the default setting of TLS 1.2 and TLS 1.3 only. For more information about how to see the TLS versions that your clients use to access your apps, see this [{{site.data.keyword.cloud_notm}} blog post](https://www.ibm.com/cloud/blog/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default).

When you specify the enabled protocols for all hosts, the TLSv1.1 and TLSv1.2 parameters (1.1.13, 1.0.12) work only when OpenSSL 1.0.1 or higher is used. The TLSv1.3 parameter (1.13.0) works only when OpenSSL 1.1.1 built with TLSv1.3 support is used.
{: note}

To edit the configmap to enable SSL protocols and ciphers:

1. Edit the configuration file for the `ibm-cloud-provider-ingress-cm` configmap resource.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Add the SSL protocols and ciphers. Format ciphers according to the [OpenSSL library cipher list format](https://www.openssl.org/docs/man1.0.2/man1/ciphers.html){: external}.

   ```yaml
   apiVersion: v1
   data:
     ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2 TLSv1.3"
     ssl-ciphers: "HIGH:!aNULL:!MD5:!CAMELLIA:!AESCCM:!ECDH+CHACHA20"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Save the configuration file.

4. Verify that the configmap changes were applied. The changes are applied to your ALBs automatically.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />

## Sending your custom certificate to legacy clients
{: #default_server_cert}

If you have legacy devices that do not support Server Name Indication (SNI) and you use a [custom TLS certificate in your Ingress resources](/docs/containers?topic=containers-ingress-types#alb-comm-create), you must edit the ALB's server settings to use your custom TLS certificate and custom TLS secret.
{: shortdesc}

When you create a classic cluster, a Let's Encrypt certificate is generated for the default Ingress secret that IBM provides. If you create a custom secret in your cluster and specify this custom secret for TLS termination in your Ingress resources, the Ingress ALB sends the certificate for your custom secret to the client instead of the default Let's Encrypt certificate. However, if a client does not support SNI, the Ingress ALB defaults to the Let's Encrypt certificate because the default secret is listed in the ALB's default server settings. To send your custom certificate to devices that do not support SNI, complete the following steps to change the ALB's default server settings to your custom secret.

1. Edit the `alb-default-server` Ingress resource.
    ```
    kubectl edit ingress alb-default-server -n kube-system
    ```
    {: pre}

2. In the `spec.tls` section, change the value of the `hosts.secretName` setting to the name of your custom secret that contains your custom certificate.
   Example:
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

4. Verify that the resource now points to your custom secret name. The changes are applied to your ALBs automatically.
   ```
   kubectl get ingress alb-default-server -n kube-system -o yaml
   ```
   {: pre}

<br />

## Tuning ALB performance
{: #perf_tuning}

To optimize performance of your Ingress ALBs, you can change the default settings according to your needs.
{: shortdesc}


### Enabling log buffering and flush timeout
{: #access-log}

By default, the Ingress ALB logs each request as it arrives. If you have an environment that is heavily used, logging each request as it arrives can greatly increase disk I/O utilization. To avoid continuous disk I/O, you can enable log buffering and flush timeout for the ALB by editing the `ibm-k8s-controller-config` Ingress configmap. When buffering is enabled, instead of performing a separate write operation for each log entry, the ALB buffers a series of entries and writes them to the file together in a single operation.
{: shortdesc}

1. Edit the `ibm-k8s-controller-config` configmap.
    ```
    kubectl edit cm ibm-k8s-controller-config -n kube-system
    ```
    {: pre}

2. Set the threshold for when the ALB should write buffered contents to the log.
    * Buffer size: Add the `buffer` field and set it to how much log memory can be held in the buffer before the ALB writes the buffered contents to the log file. For example, if the default value of `100KB` is used, the ALB writes buffer contents to the log file every time the buffer reaches 100KB of log content.
    * Time interval: Add the `flush` field and set it to how often the ALB should write to the log file. For example, if the default value of `5m` is used, the ALB writes buffer contents to the log file once every 5 minutes.
    * Time interval or buffer size: When both `flush` and `buffer` are set, the ALB writes buffer content to the log file based on whichever threshold parameter is met first.

  ```yaml
  apiVersion: v1
  kind: ConfigMap
  data:
    access-log-params: "buffer=100KB, flush=5m"
  metadata:
    name: ibm-k8s-controller-config
    ...
  ```
  {: codeblock}

3. Save and close the configuration file. The changes are applied to your ALBs automatically.

4. Verify that the logs for an ALB now contain buffered content that is written according to the memory size or time interval you set.
   ```
   kubectl logs -n kube-system <ALB_ID> -c nginx-ingress
   ```
   {: pre}

### Changing the number or duration of keepalive connections
{: #keepalive_time}

Keepalive connections can have a major impact on performance by reducing the CPU and network usage that is needed to open and close connections. To optimize the performance of your ALBs, you can change the maximum number of keepalive connections between the ALB and the client and how long the keepalive connections can last.
{: shortdesc}

1. Edit the `ibm-k8s-controller-config` configmap.
    ```
    kubectl edit cm ibm-k8s-controller-config -n kube-system
    ```
    {: pre}

2. Change the values of `keep-alive-requests` and `keep-alive`.
    * `keep-alive-requests`: The number of keepalive client connections that can stay open to the Ingress ALB. The default is `100`.
    * `keep-alive`: The timeout, in seconds, during which the keepalive client connection stays open to the Ingress ALB. The default is `75`.
   ```yaml
   apiVersion: v1
   data:
     keep-alive-requests: 100
     keep-alive: 75
   kind: ConfigMap
   metadata:
     name: ibm-k8s-controller-config
     ...
   ```
   {: codeblock}

3. Save and close the configuration file. The changes are applied to your ALBs automatically.

4. Verify that the configmap changes were applied.
   ```
   kubectl get cm ibm-k8s-controller-config -n kube-system -o yaml
   ```
   {: pre}

### Changing the number of simultaneous connections or worker processes
{: #worker_processes_connections}

Change the default setting for how many simultaneous connections the NGINX worker processes for one ALB can handle or how many worker processes can occur for one ALB.
{: shortdesc}

Each ALB has NGINX worker processes that process the client connections and communicate with the upstream servers for the apps that the ALB exposes. By changing the number of worker processes per ALB or how many connections the worker processes can handle, you can manage the maximum number of clients that an ALB can handle. Calculate your maximum client connections with the following formula: `maximum clients = worker_processes * worker_connections`.

* The `max-worker-connections` field sets the maximum number of simultaneous connections that can be handled by the NGINX worker processes for one ALB. The default value is `16384`. Note that the `max-worker-connections` parameter includes all connections that the ALB proxies, not just connections with clients. Additionally, the actual number of simultaneous connections cannot exceed the [limit on the maximum number of open files](#max-worker-files), which is set by the `max-worker-open-files` parameter. If you set the value of `max-worker-connections` to `0`, the value for `max-worker-open-files` is used instead.
* The `worker-processes` field sets the maximum number of NGINX worker processes for one ALB. The default value is `"auto"`, which indicates that the number of worker processes matches the number of cores on the worker node where the ALB is deployed. You can change this value to a number if your worker processes must perform high levels of I/0 operations.

1. Edit the `ibm-k8s-controller-config` configmap.
    ```
    kubectl edit cm ibm-k8s-controller-config -n kube-system
    ```
    {: pre}

2. Change the value of `max-worker-connections` or `worker-processes`.

   ```yaml
   apiVersion: v1
   data:
     max-worker-connections: 16384
     worker-processes: "auto"
   kind: ConfigMap
   metadata:
     name: ibm-k8s-controller-config
     ...
   ```
   {: codeblock}

3. Save the configuration file. The changes are applied to your ALBs automatically.

4. Verify that the configmap changes were applied.
   ```
   kubectl get cm ibm-k8s-controller-config -n kube-system -o yaml
   ```
   {: pre}

### Changing the number of open files for worker processes
{: #max-worker-files}

Change the default maximum for the number of files that can be opened by each worker node process for an ALB.
{: shortdesc}

Each ALB has NGINX worker processes that process the client connections and communicate with the upstream servers for the apps that the ALB exposes. If your worker processes are hitting the maximum number of files that can be opened, you might see a `Too many open files` error in your NGINX logs. By default, the `max-worker-open-files` parameter is set to `0`, which indicates that the value from the following formula is used: `system limit of maximum open files / worker-processes - 1024`. If you change the value to another integer, the formula no longer applies.

1. Edit the `ibm-k8s-controller-config` configmap.
    ```
    kubectl edit cm ibm-k8s-controller-config -n kube-system
    ```
    {: pre}

2. Change the value of `max-worker-open-files`.

   ```yaml
   apiVersion: v1
   data:
     max-worker-open-files: 0
   kind: ConfigMap
   metadata:
     name: ibm-k8s-controller-config
     ...
   ```
   {: codeblock}

3. Save the configuration file. The changes are applied to your ALBs automatically.

4. Verify that the configmap changes were applied.
   ```
   kubectl get cm ibm-k8s-controller-config -n kube-system -o yaml
   ```
   {: pre}

### Tuning kernel performance
{: #ingress_kernel}

To optimize performance of your Ingress ALBs, you can also [change the Linux kernel `sysctl` parameters on worker nodes](/docs/containers?topic=containers-kernel). Worker nodes are automatically provisioned with optimized kernel tuning, so change these settings only if you have specific performance optimization requirements.
{: shortdesc}
