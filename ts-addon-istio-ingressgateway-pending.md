---

copyright:
  years: 2023, 2024
lastupdated: "2024-01-03"


keywords: istio, ingress gateway, trouble shooting, pending, istio pods
subcollection: containers
content-type: troubleshoot

---


{{site.data.keyword.attribute-definition-list}}


# Why are my default `istio-ingressgateway` pods stuck in `pending`?
{: #ts-istio-ingressgateway-pending}
{: support}


When you run **`kubectl get pod -n istio-system`**, the `istio-ingressgateway` pods are stuck in `pending`. 
{: tsSymptoms}

Additionally, when you get the details of one of the pods by running **`kubectl describe pods -n istio-system -l app=istio-ingressgateway`** and check the `Events` section of the output, you see a message similar to the following.

```sh
Events:
  Type     Reason            Age                From               Message
  ----     ------            ----               ----               -------
  Warning  FailedScheduling  18s (x4 over 15m)  default-scheduler  0/3 nodes are available: 3 node(s) didn't match Pod's node affinity/selector. preemption: 0/3 nodes are available: 3 Preemption is not helpful for scheduling..
```
{: screen}

The zone label keys on the `istio-ingressgateway` pods might not match the labels of any of your nodes. This prevents node affinity rules from scheduling pods to nodes.
{: tsCauses}

To check the zone label keys, run **`kubectl describe cm managed-istio-custom -n ibm-operators`** to view the managed Istio custom ConfigMap. Check the ConfigMap for keys in the `istio-ingressgateway-zone-<#>` format, such as `istio-ingressgateway-zone-1`. If the keys are not present in the ConfigMap, the pod and worker node labels do not match.

To resolve the issue, restart the Istio setup job that adds the zone labels into the ConfigMap.
{: tsResolve}

1. Delete the Istio setup job in the `ibm-system` namespace.

    ```sh
    kubectl delete job -n ibm-system -l addon.cleanup=istio
    ```
    {: pre}

2. Wait 15 minutes for the job to update the ConfigMap and for the `istio-ingressgateway` pods to pick up the zone labels. 

3. Run `kubectl get pod -n istio-system` to check the status of the pods.



