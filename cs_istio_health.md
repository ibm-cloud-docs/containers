---

copyright:
  years: 2014, 2021
lastupdated: "2021-03-31"

keywords: kubernetes, iks, mesh, Prometheus, Grafana, Jaeger, Kiali, controlz, envoy

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



# Observing Istio traffic
{: #istio-health}

Log and monitor your apps that are managed by Istio on {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

## Setting up logging with {{site.data.keyword.la_full_notm}}
{: #istio_health_logdna}

Seamlessly manage logs for your app container and the Envoy proxy sidecar container in each pod by deploying {{site.data.keyword.la_short}} agents to your worker nodes to forward logs to {{site.data.keyword.la_full}}.
{: shortdesc}

To use [{{site.data.keyword.la_full_notm}}](/docs/Log-Analysis-with-LogDNA?topic=Log-Analysis-with-LogDNA-getting-started), you deploy a logging agent to every worker node in your cluster. This agent collects logs with the extension `*.log` and extensionless files that are stored in the `/var/log` directory of your pod from all namespaces, including `kube-system`. These logs include logs from your app container and the Envoy proxy sidecar container in each pod. The agent then forwards the logs to the {{site.data.keyword.la_full_notm}} service.

To get started, set up logging for your cluster by following the steps in [Managing Kubernetes cluster logs with {{site.data.keyword.la_full_notm}}](/docs/Log-Analysis-with-LogDNA?topic=Log-Analysis-with-LogDNA-kube#kube).

<br />

## Setting up monitoring with {{site.data.keyword.mon_full_notm}}
{: #istio_health_sysdig}

Gain operational visibility into the performance and health of your Istio-managed apps by deploying a {{site.data.keyword.mon_short}} agent to your worker nodes to forward metrics to {{site.data.keyword.mon_full}}.
{: shortdesc}

The managed `istio` add-on installs Prometheus into your cluster. The `istio-mixer-telemetry` pods in your cluster are annotated with a Prometheus endpoint so that Prometheus can aggregate all telemetry data for your pods. When you deploy a monitoring agent to the worker nodes in your cluster, {{site.data.keyword.mon_short}} is already automatically enabled to detect and scrape the data from these Prometheus endpoints to display them in your {{site.data.keyword.cloud_notm}} monitoring dashboard.

Since all of the Prometheus work is done, all that is left for you is to deploy monitoring agents in your cluster.

1. [Provision an instance of {{site.data.keyword.mon_full_notm}}](https://cloud.ibm.com/observe/monitoring/create){: external}.

2. [Configure a monitoring agent in your cluster.](/docs/Monitoring-with-Sysdig?topic=Monitoring-with-Sysdig-config_agent#config_agent_kube_script)

3. In the [Monitoring console](https://cloud.ibm.com/observe/monitoring){: external}, click **View Sysdig** for the instance that you provisioned.

4. In the {{site.data.keyword.mon_short}} UI, click **Add new dashboard**.

5. Search for `Istio` and select one of {{site.data.keyword.mon_short}}'s predefined Istio dashboards.

For more information about referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out the [How to monitor Istio, the Kubernetes service mesh](https://sysdig.com/blog/monitor-istio/){: external} blog post.

## Launching the ControlZ component inspection and Envoy sidecar dashboards
{: #istio_inspect}

To inspect specific components of Istio, launch the [ControlZ](https://istio.io/latest/docs/ops/diagnostic-tools/controlz/){: external} and [Envoy](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-dashboard-envoy){: external} dashboards.
{: shortdesc}

The ControlZ dashboard accesses the Istio component ports to provide an interactive view into the internal state of each component. The Envoy dashboard provides configuration information and metrics for an Envoy sidecar proxy that runs in an app pod.

**Before you begin**
* [Install the `istio` managed add-on](/docs/containers?topic=containers-istio#istio_install) in a cluster.
* [Install the `istioctl` CLI](/docs/containers?topic=containers-istio#istioctl).

### ControlZ
{: #controlz}

1. Get the pod name for the Istio component that you want to inspect. You can inspect the component pods for `istio-citadel`, `istio-galley`, `istio-pilot`, `istio-policy`, and `istio-telemetry`.
  ```
  kubectl get pods -n istio-system | grep istio
  ```
  {: pre}

  Example output:
  ```
  NAME                                      READY   STATUS    RESTARTS   AGE
  istio-citadel-869c7f9498-wtldz            1/1     Running   0          2m
  istio-egressgateway-69bb5d4585-qxxbp      1/1     Running   0          2m
  istio-galley-75d7b5bdb9-c9d9n             1/1     Running   0          2m
  istio-ingressgateway-5c8764db74-gh8xg     1/1     Running   0          2m
  istio-pilot-55fd7d886f-vv6fb              2/2     Running   0          2m
  istio-policy-6bb6f6ddb9-s4c8t             2/2     Running   0          2m
  istio-sidecar-injector-7d9845dbb7-r8nq5   1/1     Running   0          2m
  istio-telemetry-7695b4c4d4-tlvn8          2/2     Running   0          2m
  istio-tracing-55bbf55878-z4rd2            1/1     Running   0          2m
  ```
  {: screen}

2. Access the ControlZ dashboard for that component.
  ```
  istioctl dashboard controlz <component_pod_name>.istio-system
  ```
  {: pre}

### Envoy
{: #envoy}

1. Get the name of the app pod where you want to inspect the Envoy sidecar container.
  ```
  kubectl get pods -n <namespace>
  ```
  {: pre}

2. Access the Envoy dashboard for that pod.
  ```
  istioctl dashboard envoy <pod-name>.<namespace>
  ```
  {: pre}
