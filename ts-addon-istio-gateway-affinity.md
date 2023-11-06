---

copyright:
  years: 2014, 2023
lastupdated: "2023-11-06"

keywords: kubernetes, help

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}






# Why are the `ibm-cloud-provider-ip` pods for the Istio ingress gateway stuck in `pending`?
{: #istio_gateway_affinity}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Multizone clusters only


When you run `kubectl get pod -n ibm-system`, the `ibm-cloud-provider-ip` pod that provides the external IP address for your Istio ingress gateway is stuck in the `pending` status.
{: tsSymptoms}

Additionally, when you run `kubectl describe pod <pod_name> -n ibm-system` for the `ibm-cloud-provider-ip` pod, you notice a scheduling conflict error in the pod's events section of the output.

To identify the `ibm-cloud-provider-ip` pod for your gateway, you can run `kubectl get service -n istio-system` to find your gateway's load balancer service, note its **EXTERNAL-IP**, and look for the IP address in the `ibm-cloud-provider-ip` pod name.
{: tip}


When an `istio-ingressgateway` load balancer service is created, an `ibm-cloud-provider-ip` pod is created to provide an external IP address to the load balancer.
{: tsCauses}

These `ibm-cloud-provider-ip` pods have a node affinity rule so that they are created in the same zone as the subnet from which the IP address is derived. However, when the `ExternalTrafficPolicy` setting for the `istio-ingressgateway` load balancer service is set to `Local`, then the `ibm-cloud-provider-ip` pod also has a pod affinity rule to be deployed to the same zone as the gateway load balancer pod. If the IP address and gateway load balancer exist in different zones in your cluster, the `ibm-cloud-provider-ip` pod can't properly deploy.

To verify that the `ibm-cloud-provider-ip` and `istio-ingressgateway` pods don't exist in the same zone:

1. Identify the **NODE** that your `istio-ingressgateway` pod is deployed to.
    ```sh
    kubectl get pod -n istio-system -o wide
    ```
    {: pre}

2. Get the **EXTERNAL-IP** address for the gateway's load balancer service.
    ```sh
    kubectl get service -n istio-system
    ```
    {: pre}

3. Identify the **NODE** that the `ibm-cloud-provider-ip` pod for the load balancer is deployed to. Replace `<IP-with-hyphens>` with the IP address that you found in the previous step. In the IP address, use hyphens (-) instead of periods (.). For example, `169.12.345.67` becomes `169-12-345-67`.
    ```sh
    kubectl get pod -n ibm-system -o wide -l ibm-cloud-provider-ip=<IP-with-hyphens>
    ```
    {: pre}

4. List the zones that the worker nodes are in. Compare the worker nodes that you found in step 1 and 3 to determine whether the pods are deployed to worker nodes in different zones.
    ```sh
    kubectl get node --no-headers -L ibm-cloud.kubernetes.io/zone
    ```
    {: pre}

    Example output

    ```sh
    10.176.48.106   Ready   <none>   529d    v1.28+IKS   dal10
    10.176.48.107   Ready   <none>   196d    v1.28+IKS   dal10
    10.184.58.23    Ready   <none>   2y38d   v1.28+IKS   dal12
    10.184.58.42    Ready   <none>   529d    v1.28+IKS   dal12
    ```
    {: screen}


To resolve this issue, you can either move the `istio-ingressgateway` pod to the zone that the `ibm-cloud-provider-ip` pod exists in, or vice versa.
{: tsResolve}

* [Moving the `istio-ingressgateway` pod](#move-gateway-pod): The gateway's load balancer retains the same external IP address after it moves. However, in version 1.9 and earlier of the add-on, the changes that you make might be overwritten when the zone labels for gateways are automatically populated during Istio patch updates.
* [Moving the `ibm-cloud-provider-ip` pod](#move-ip-pod): The gateway **does not** retain the same external IP address after it moves, and is assigned a new IP address. However, no changes are overwritten during add-on updates.

## Moving the `istio-ingressgateway` pod
{: #move-gateway-pod}

Move the `istio-ingressgateway` pod to the same zone as the `ibm-cloud-provider-ip` pod.
{: shortdesc}

1. Edit the `managed-istio-custom` ConfigMap resource.
    ```sh
    kubectl edit cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

2. For the gateway that you want to move, change the `istio-ingressgateway-zone-1|2|3` setting to the zone where the `ibm-cloud-provider-ip` pod exists.
3. Save and close the configuration file. The `istio-ingressgateway` pod is moved to a worker node in the same zone as the `ibm-cloud-provider-ip` pod, and the `ibm-cloud-provider-ip` pod properly deploys.
4. To verify that the pods now exist in the same zone, follow the steps in the **Why it’s happening** section.

## Moving the `ibm-cloud-provider-ip` pod
{: #move-ip-pod}

Move the `ibm-cloud-provider-ip` pod to the same zone as the `istio-ingressgateway` pod.
{: shortdesc}

1. Edit the `managed-istio-custom` ConfigMap resource.
    ```sh
    kubectl edit cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

2. Note the name of the `istio-ingressgateway-zone-<1|2|3>` setting for the gateway. In this example ConfigMap, to move the `ibm-cloud-provider-ip` pod for the gateway that exists in `dal10`, note the key called `istio-ingressgateway-zone-1`.
    ```yaml
    apiVersion: v1
    data:
      istio-ingressgateway-zone-1: dal10
      istio-ingressgateway-zone-2: dal12
      istio-ingressgateway-public-1-enabled: "true"
      istio-ingressgateway-public-2-enabled: "true"
      istio-monitoring: "true"
    kind: ConfigMap
    ...
    ```
    {: screen}

3. Temporarily disable the gateway by changing the corresponding `istio-ingressgateway-public-<1|2|3>-enabled` setting to `"false"`. In this example ConfigMap, to move the `ibm-cloud-provider-ip` pod for the gateway that exists in `dal10`, change `istio-ingressgateway-public-1-enabled` to `"false"`.
    ```yaml
    apiVersion: v1
    data:
      istio-ingressgateway-zone-1: dal10
      istio-ingressgateway-zone-2: dal12
      istio-ingressgateway-public-1-enabled: "false"
      istio-ingressgateway-public-2-enabled: "true"
      istio-monitoring: "true"
    kind: ConfigMap
    ...
    ```
    {: screen}

4. Save and close the configuration file.

5. Verify that the gateway's load balancer pod is deleted. Note that it might take up to 30 minutes for the changes to complete.
    ```sh
    kubectl get service -n istio-system -o wide
    ```
    {: pre}

6. Open the `managed-istio-custom` ConfigMap resource.
    ```sh
    kubectl edit cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

7. Re-enable the gateway by changing the `istio-ingressgateway-public-<1|2|3>-enabled` setting back to `"true"`.

8. Save and close the configuration file. A new load balancer service for the gateway (the `istio-ingressgateway` pod) is created, and a new `ibm-cloud-provider-ip` pod for that load balancer is deployed to a worker node in the same zone as the `istio-ingressgateway` pod.

9. To verify that the pods now exist in the same zone, follow the steps in the **Why it’s happening** section.






