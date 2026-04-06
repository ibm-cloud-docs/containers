---

copyright:
  years: 2014, 2026
lastupdated: "2026-04-06"


keywords: kubernetes, logging, help, debug

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why doesn't the Kubernetes dashboard display utilization graphs?
{: #cs_dashboard_graphs}
{: support}


When you access the Kubernetes dashboard, utilization graphs don't display.
{: tsSymptoms}


Sometimes after a cluster update or worker node reboot, the `kubernetes-dashboard` pod does not update, or the `metrics-server` is not running properly.
{: tsCauses}


Follow these steps to resolve the issue:
{: tsResolve}

1. Verify that the `metrics-server` is running in your cluster.
    ```sh
    kubectl get deployment metrics-server -n kube-system
    ```
    {: pre}

2. If the `metrics-server` is not running or is in a failed state, check the pod logs.
    ```sh
    kubectl logs -n kube-system -l k8s-app=metrics-server
    ```
    {: pre}

3. Delete the `kubernetes-dashboard` pod to force a restart. The pod is re-created with RBAC policies to access the `metrics-server` for utilization information.
    ```sh
    kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
    ```
    {: pre}

4. If the issue persists, restart the `metrics-server` deployment.
    ```sh
    kubectl rollout restart deployment metrics-server -n kube-system
    ```
    {: pre}
