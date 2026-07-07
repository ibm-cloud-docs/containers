---

copyright:
  years: 2026, 2026
lastupdated: "2026-07-07"


keywords: ingress, alb, application load balancer, nginx, ingress controller, network traffic, exposing apps, traefik, migration

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Moving from Ingress-NGINX to Traefik on {{site.data.keyword.cloud_notm}}
{: #managed-ingress-move-traefik}

{{site.data.keyword.containerlong_notm}} is moving away from [Ingress-NGINX](https://github.com/kubernetes/ingress-nginx){: external} because the upstream project is retired. [Traefik](https://traefik.io/){: external} is the Ingress controller that {{site.data.keyword.IBM_notm}} supports going forward.
{: shortdesc}

During the transition period, both Ingress controllers are available, giving you the flexibility to test Traefik and migrate at your own pace.

This topic compares key configuration differences between Ingress-NGINX and Traefik and provides guidance for your transition.

## Comparing Ingress-NGINX to Traefik on {{site.data.keyword.cloud_notm}}
{: #comparing-ingress-nginx-to-traefik}

The following table compares high-level differences between Ingress-NGINX and Traefik.

| | Ingress-NGINX | Traefik |
| -------- | ------------- | ------- |
| IBM-provided default Ingress classes | `public-iks-k8s-nginx` for public and `private-iks-k8s-nginx` for private. | `public-iks-traefik` for public and `private-iks-traefik` for private. |
| Version scheme | `0.X.X_XXXX_iks` and `1.X.X_XXXX_iks` | Starting with Traefik version 3: `3.X.X_XXXX_iks` |
| Processed resources | [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#the-ingress-resource){: external} only | [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#the-ingress-resource){: external} with optional [Ingress-NGINX compatibility](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress-nginx/){: external} and [Traefik CRDs](https://doc.traefik.io/traefik/reference/install-configuration/providers/kubernetes/kubernetes-crd/){: external} |
| IBM-deployed service account name | `ibm-k8s-ingress` | `ibm-traefik-ingress` |
{: row-headers}
{: class="comparison-table"}
{: caption="High-level comparison of Ingress-NGINX and Traefik properties" caption-side="bottom"}
{: summary="This comparison table has row and column headers. The row headers identify the property being compared, and the column headers identify Ingress-NGINX and Traefik. Use the table to compare high-level differences between the two ingress controllers."}

The following table compares how you configure common features in Ingress-NGINX and Traefik.

| Configuration | Ingress-NGINX | Traefik |
| ------------- | ------------- | ------- |
| **{{site.data.keyword.appid_short_notm}} authentication** | Add `nginx.ingress.kubernetes.io/auth-url` and related snippet annotations to the Ingress resource. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#app-id-authentication). | Create a Traefik `ForwardAuth` Middleware CRD and apply it via the `traefik.ingress.kubernetes.io/router.middlewares` annotation. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#app-id-authentication). |
| **Maximum client request body size** | Use the `nginx.ingress.kubernetes.io/proxy-body-size` annotation. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#client-request-bodysize). | Create a Traefik `Buffering` Middleware CRD and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#client-request-bodysize). |
| **Client response data buffering** | Use the `nginx.ingress.kubernetes.io/proxy-buffering` annotation. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#client-response-data-buffering). | Create a Traefik `Buffering` Middleware CRD and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#client-response-data-buffering). |
| **Connect and read timeouts** | Use `nginx.ingress.kubernetes.io/proxy-connect-timeout` and `proxy-read-timeout` annotations. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#custom-connect-read-timeouts). | Configure read/write/idle timeouts in the `ibm-ingress-deploy-config` ConfigMap, and use a `ServersTransport` CRD for backend forwarding timeouts. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#adjusting-timeouts). |
| **Custom error actions** | Set the `custom-http-errors` field in the `ibm-k8s-controller-config` ConfigMap. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#custom-error-actions). | Create a Traefik `Errors` Middleware CRD and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#custom-error-actions). |
| **Customizing request headers** | Set the `proxy-set-headers` field in the `ibm-k8s-controller-config` ConfigMap. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#custom-request-header). | Create a Traefik `Headers` Middleware CRD and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#custom-request-header). |
| **Customizing response headers** | Use the `nginx.ingress.kubernetes.io/configuration-snippet` annotation. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#custom-response-header). | Create a Traefik `Headers` Middleware CRD and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#custom-response-header). |
| **HTTP to HTTPS redirect** | Set `ssl-redirect` in the `ibm-k8s-controller-config` ConfigMap or use the `nginx.ingress.kubernetes.io/ssl-redirect` annotation. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#http-redirects-https). | Set the `httpsRedirect` field in the `ibm-ingress-deploy-config` ConfigMap. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#http-redirects-https). |
| **HTTP Strict Transport Security (HSTS)** | Set the `hsts` field in the `ibm-k8s-controller-config` ConfigMap. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#http-strict-transport-security). | Create a Traefik `Headers` Middleware CRD with the `stsSeconds` and related fields and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#http-strict-transport-security). |
| **URI path matching (regex)** | Use the `nginx.ingress.kubernetes.io/use-regex` annotation. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#location-modifier). | Use the `traefik.ingress.kubernetes.io/router.pathmatcher` annotation. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#location-modifier). |
| **Mutual TLS authentication** | Use `nginx.ingress.kubernetes.io/auth-tls-*` annotations on the Ingress resource. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#mutual-authentication). | Create a Traefik TLSOption CRD and apply it via the `traefik.ingress.kubernetes.io/router.tls.options` annotation. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#mutual-authentication). |
| **Retry / next upstream** | Use `nginx.ingress.kubernetes.io/proxy-next-upstream` and related annotations. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#proxy-next-upstream). | Create a Traefik `Retry` Middleware CRD and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#proxy-next-upstream). |
| **Rate limiting** | Use `nginx.ingress.kubernetes.io/limit-*` annotations on the Ingress resource. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#rate-limiting). | Create a Traefik `RateLimit` Middleware CRD and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#rate-limiting). |
| **Path rewriting** | Use the `nginx.ingress.kubernetes.io/rewrite-target` annotation. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#alb-rewrite-paths). | Create a Traefik `ReplacePath` or `ReplacePathRegex` Middleware CRD and apply it to the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#alb-rewrite-paths). |
| **Session affinity (sticky cookies)** | Use `nginx.ingress.kubernetes.io/affinity` and related annotations. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#session-affinity-cookies). | Use Traefik Service `sticky cookie` annotations directly on the Ingress resource. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#session-affinity-cookies). |
| **Upstream TLS (SSL services)** | Use `nginx.ingress.kubernetes.io/backend-protocol` and `proxy-ssl-*` annotations. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#ssl-services-support). | Create a Traefik ServersTransport CRD with the `rootCAs` field and apply it to the backend Service. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#ssl-services-support). |
| **SSL protocols and ciphers** | Set `ssl-protocols` and `ssl-ciphers` fields in the `ibm-k8s-controller-config` ConfigMap. [See Ingress-NGINX docs](/docs/containers?topic=containers-comm-ingress-annotations#ssl_protocols_ciphers). | Create a Traefik TLSOption CRD with `minVersion`, `maxVersion`, and `cipherSuites` fields. [See Traefik docs](/docs/containers?topic=containers-traefik-ingress-customization#ssl_protocols_ciphers). |
{: row-headers}
{: caption="Configuration feature comparison between Ingress-NGINX and Traefik" caption-side="bottom"}
{: summary="This table has row and column headers. The row headers identify a configuration feature, and the column headers describe how to configure that feature in Ingress-NGINX and Traefik."}

If a feature depends on Traefik CRDs, such as `Middleware`, `TLSOption`, or `ServersTransport`, ensure that CRD processing is enabled. CRD processing is enabled by default. To configure CRD processing, see the `processTraefikCRDs` field in the `ibm-ingress-deploy-config` ConfigMap in [Creating custom settings in the Ingress ConfigMap](/docs/containers?topic=containers-traefik-ingress-customization#create-ingress-configmap-custom).
{: note}

The following table lists the customizable deployment parameters that Ingress-NGINX and Traefik support.

| | Ingress-NGINX | Traefik |
| --------- | ------------- | ------- |
| `replicas` | Supported | Supported |
| `ingressClass` | Supported | Supported |
| `httpPort`, `httpsPort` | Supported | Supported |
| `tcpServicesConfig` | Supported | Not applicable. Use the [IngressRouteTCP CRD](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/crd/tcp/ingressroutetcp/){: external}. |
| `enableSslPassthrough` | Supported | Not applicable. You do not need to enable this setting explicitly. |
| `defaultCertificate` | Supported | Not applicable. Use the [TLSStore CRD with `defaultCertificate`](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/crd/tls/tlsstore/#configuration-example){: external}. |
| `defaultBackendService` | Supported | Not applicable. Use [Global Default Backend Ingress](https://doc.traefik.io/traefik/reference/routing-configuration/kubernetes/ingress/#global-default-backend-ingresses){: external}. |
| `deepInspect` | Supported | Not applicable |
| `defaultConfig` | Supported | Not applicable |
| `enableAnnotationValidation` | Supported | Not applicable. Traefik is not prone to configuration injection from annotations. |
| `enableIngressValidation` | Supported | Not applicable |
| `logLevel` | Supported as a number from 0 - 5 for verbosity. | Supported as a string with the following values: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`, `PANIC`. |
| `ingressProvider` | Not applicable | Supported |
| `processTraefikCRDs` | Not applicable | Supported |
| `traefikIngressNginxAllowExternalNameServices` | Not applicable | Supported |
| `traefikCRDAllowCrossNamespace` | Not applicable | Supported |
| `traefikCRDAllowExternalNameServices` | Not applicable | Supported |
| `httpReadTimeout`, `httpsReadTimeout` | Not applicable. [Configure through the `ibm-k8s-controller-config` ConfigMap](/docs/containers?topic=containers-comm-ingress-annotations#ingress-configure-connection-handling). | Supported |
| `httpWriteTimeout`, `httpsWriteTimeout` | Not applicable. [Configure through the `ibm-k8s-controller-config` ConfigMap](/docs/containers?topic=containers-comm-ingress-annotations#ingress-configure-connection-handling). | Supported |
| `httpIdleTimeout`, `httpsIdleTimeout` | Not applicable. [Configure through the `ibm-k8s-controller-config` ConfigMap](/docs/containers?topic=containers-comm-ingress-annotations#ingress-configure-connection-handling). | Supported |
| `httpsRedirect` | Not applicable. [Configure through the `ibm-k8s-controller-config` ConfigMap or annotation](/docs/containers?topic=containers-comm-ingress-annotations#http-redirects-https). | Supported |
| `tolerations` | Supported | Supported |
{: row-headers}
{: caption="Customizable deployment parameters supported by Ingress-NGINX and Traefik" caption-side="bottom"}
{: summary="This table has row and column headers. The row headers identify a deployment parameter, and the column headers describe whether Ingress-NGINX and Traefik support that parameter or provide an alternative."}

## Behaviors to consider during migration
{: #managed-traefik-move-behaviors}

The following {{site.data.keyword.cloud_notm}} mechanisms help prevent service disruption in certain scenarios.

### DNS handling on classic clusters
{: #move-traefik-dns-classic}

On classic clusters, enabling or disabling public ALB instances automatically adds the IP addresses for these ALBs to the cluster's default domain.

When you enable different types of ALBs (mixing Traefik with Ingress-NGINX), DNS records are not added. This prevents the undesired situation where different ALB types are mixed behind a single domain, which could cause hard-to-debug issues. No new IP addresses are registered while this mixed state persists. IP address removal still functions as before.

When the last instance of the different type is disabled (either Traefik or Ingress-NGINX), the remaining ALBs are automatically re-registered to restore the desired state, where all public ALB instances are registered behind the cluster's default subdomain.

### Default Ingress Class handling
{: #move-traefik-default-ingress-class}

The default Ingress Class is reconciled on each ALB enable or disable event. If the default Ingress Class is left on the IBM default setting and is not configured, it is automatically updated.

If the cluster has only Traefik-based ALBs enabled, `public-iks-traefik` or `private-iks-traefik` is made the default, depending on whether `public-iks-k8s-nginx` or `private-iks-k8s-nginx` was the previous default. Similarly, if only Ingress-NGINX-based ALBs are enabled on the cluster, the default Ingress Class is changed back to the Ingress-NGINX one.

Custom Ingress Classes are never made the default automatically.

For more information about configuring and customizing Traefik, see [About Ingress with Traefik](/docs/containers?topic=containers-managed-traefik-ingress-about).

