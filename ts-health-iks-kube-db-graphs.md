---

copyright:
  years: 2014, 2024
lastupdated: "2024-01-03"


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


Sometimes after a cluster update or worker node reboot, the `kube-dashboard` pod does not update.
{: tsCauses}


Delete the `kube-dashboard` pod to force a restart. The pod is re-created with RBAC policies to access `heapster` for utilization information.
{: tsResolve}

    ```sh
    kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
    ```
    {: pre}






