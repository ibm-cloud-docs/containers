---

copyright:
  years: 2022, 2022
lastupdated: "2022-11-11"

keywords: kubernetes, help

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Debugging the `metrics-server`
{: #debug_metrics_server}
{: support}

Supported infrastructure providers
:   Classic
:   VPC

The following symptoms might indicate a need to adjust the `metrics-server` resources:
{: tsSymptoms}

- The `metrics-server` is restarting frequently.

- Deleting a namespace results in the namespace being stuck in a `Terminating` state and `kubectl describe namespace` includes a condition reporting a metrics API discovery error.

- `kubectl top pods`, `kubectl top nodes`, other `kubectl` commands, or applications that use the Kubernetes API to log Kubernetes errors such as:

    ```sh
    The server is currently unable to handle the request (get pods.metrics.k8s.io)
    ```
    {: screen}
    
    ```sh
    Discovery failed for some groups, 1 failing: unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: the server is currently unable to handle the request
    ```
    {: screen}

- HorizontalPodAutoscalers (HPAs) do not scale deployments.

- Running `kubectl get apiservices v1beta1.metrics.k8s.io` results in a status such as:

    ```sh
    NAME                     SERVICE                      AVAILABLE                      AGE
    v1beta1.metrics.k8s.io   kube-system/metrics-server   False (FailedDiscoveryCheck)   139d
    ```
    {: screen}

Your cluster has a metrics service provided by the `metrics-server` deployment in the `kube-system` namespace. The `metrics-server` resource requests and limits are based on the number of nodes in the cluster and are optimized for clusters with 30 or less pods per worker node. If the memory requests are too low, it can fail with out-of-memory errors and can respond very slowly. If the CPU requests are too low, it can possibly fail liveness and readiness probes due to CPU throttling.
{: tsCauses}

Problems with the `metrics-server` can also be cause problems in other areas. The metrics APIs is not available if the control plane is not able to communicate with the metrics-server by using the openvpn tunnel or Konnectivity. Admission control webhooks can prevent the control plane from creating pods, including the `metrics-server` pod.

Follow these steps to troubleshoot.
{: tsResolve}

1. Verify that metrics-server pods exist.
    ```sh
    kubectl get pod -n kube-system -l k8s-app=metrics-server
    ```
    {: pre}

   If no pods are listed, there is likely a problem with an `admission-control` webhook. See [Why do cluster operations fail due to a broken webhook?](/docs/containers?topic=containers-webhooks_update).

2. Verify that the apiserver can connect to the `metrics-server`.
    ```sh
    kubectl logs POD -n kube-system -c metrics-server --tail 5
    ```
    {: pre}

    Replace `POD` with the pod name shown earlier. The content of any logs returned does not matter.
  
    If you get an error message that contains text such as `<workerIP>:10250: getsockopt: connection timed out`, see [`kubectl` commands time out](/docs/containers?topic=containers-ts_clis#exec_logs_fail).
  
3. If the previous steps do not show a problem, adjust the resources for the `metrics-server`. See [Adjusting cluster metrics provider resources](/docs/containers?topic=containers-kernel#metrics).
