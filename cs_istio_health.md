---

copyright:
  years: 2014, 2024
lastupdated: "2024-01-03"


keywords: kubernetes, mesh, Prometheus, Grafana, Jaeger, Kiali, controlz, envoy

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}






# Observing Istio traffic
{: #istio-health}

Log and monitor your apps that are managed by Istio on {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

## Enabling access logs for the entire mesh
{: #enable_logs_entire}

To enable Envoy access logs for the entire mesh, you can use the `managed-istio-custom` ConfigMap resource, which is located in the `ibm-operators` namespace that is provided by the Istio add-on. To enable Envoy access logs, edit the `managed-istio-custom` ConfigMap resource and add the key-value pair `istio-global-proxy-accessLogFile: "dev/stdout"`. For more information, see [Customizing the Istio installation](/docs/containers?topic=containers-istio&interface=ui#customize).
{: shortdesc}

## Enabling access logs for individual containers
{: #enable_logs_individual}

Starting from version 1.18, the Istio add-on provides the option to enable Envoy access logs for individual containers by using telemetry CRs. To set up telemetry CRs, use the following telemetry definition.

```yaml
apiVersion: telemetry.istio.io/v1alpha1
kind: Telemetry
metadata:
  name: example-telemetry-enabling-envoy-access-logs
  namespace: <namespace> # Pod's namespace
spec:
  selector:
    matchLabels:
      <key>: <value> # Pod's label
  accessLogging:
  - providers:
    - name: enable-targeted-envoy-access-logs    
```
{: codeblock}

Modify the previous example definition to contain your Pod's namespace and label. After the telemetry definition is applied, you can see Envoy access logs through the `istio-proxy` container.

## Setting up logging with {{site.data.keyword.la_full_notm}}
{: #istio_health_la}

Seamlessly manage logs for your app container and the Envoy proxy sidecar container in each pod by deploying {{site.data.keyword.la_short}} agents to your worker nodes to forward logs to {{site.data.keyword.la_full}}.
{: shortdesc}

To use [{{site.data.keyword.la_full_notm}}](/docs/log-analysis?topic=log-analysis-getting-started), you deploy a logging agent to every worker node in your cluster. This agent collects logs with the extension `*.log` and extensionless files that are stored in the `/var/log` directory of your pod from all namespaces, including `kube-system`. These logs include logs from your app container and the Envoy proxy sidecar container in each pod. The agent then forwards the logs to the {{site.data.keyword.la_full_notm}} service.

To get started, set up logging for your cluster by following the steps in [Managing Kubernetes cluster logs with {{site.data.keyword.la_full_notm}}](/docs/log-analysis?topic=log-analysis-tutorial-use-logdna).


## Setting up monitoring with {{site.data.keyword.mon_full_notm}}
{: #istio_health_mon}

Gain operational visibility into the performance and health of your Istio-managed apps by deploying a {{site.data.keyword.mon_short}} agent to your worker nodes to forward metrics to {{site.data.keyword.mon_full}}.
{: shortdesc}

To deploy monitoring agents to your cluster, complete the following steps.

1. [Provision an instance of {{site.data.keyword.mon_full_notm}}](https://cloud.ibm.com/observe/monitoring/create){: external}.

2. [Configure a monitoring agent in your cluster.](/docs/monitoring?topic=monitoring-kubernetes_cluster)

3. In the [Monitoring console](https://cloud.ibm.com/observe/monitoring){: external}, click **Open Dashboard** for the instance that you provisioned.

4. In the {{site.data.keyword.mon_short}} UI, click **Add new dashboard**.

5. Search for `Istio` and select one of the {{site.data.keyword.mon_short}} predefined Istio dashboards.

For more information about referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out the [How to monitor Istio, the Kubernetes service mesh](https://sysdig.com/blog/monitor-istio/){: external} blog post.

## Launching the ControlZ component inspection and Envoy sidecar dashboards
{: #istio_inspect}

To inspect specific components of Istio, launch the [ControlZ](https://istio.io/latest/docs/ops/diagnostic-tools/controlz/){: external} and [Envoy](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-dashboard-envoy){: external} dashboards.
{: shortdesc}

The ControlZ dashboard accesses the Istio component ports to provide an interactive view into the internal state of each component. The Envoy dashboard provides configuration information and metrics for an Envoy sidecar proxy that runs in an app pod.

Before you begin
* [Install the `istio` managed add-on](/docs/containers?topic=containers-istio#istio_install) in a cluster.
* [Install the `istioctl` CLI](/docs/containers?topic=containers-istio&interface=cli#istioctl).

### ControlZ
{: #controlz}

1. Get the pod name for the Istio component that you want to inspect. You can inspect the component pods for `istio-citadel`, `istio-galley`, `istio-pilot`, `istio-policy`, and `istio-telemetry`.
    ```sh
    kubectl get pods -n istio-system | grep istio
    ```
    {: pre}

    Example output

    ```sh
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
    ```sh
    istioctl dashboard controlz <component_pod_name>.istio-system
    ```
    {: pre}

### Envoy
{: #envoy}

1. Get the name of the app pod where you want to inspect the Envoy sidecar container.
    ```sh
    kubectl get pods -n <namespace>
    ```
    {: pre}

2. Access the Envoy dashboard for that pod.
    ```sh
    istioctl dashboard envoy <pod-name>.<namespace>
    ```
    {: pre}






