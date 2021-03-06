---

copyright:
  years: 2014, 2021
lastupdated: "2021-07-14"

keywords: kubernetes, iks, help

subcollection: containers
content-type: troubleshoot

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


# Why are the `ibm-cloud-provider-ip` pods for the Istio ingress gateway stuck in `pending`?
{: #istio_gateway_affinity}

**Infrastructure provider**:
  * <img src="../images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic
  * <img src="../images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC
  * Multizone clusters only

{: tsSymptoms}
When you run `kubectl get pod -n ibm-system`, the `ibm-cloud-provider-ip` pod that provides the external IP address for your Istio ingress gateway is stuck in the `pending` status. Additionally, when you run `kubectl describe pod <pod_name> -n ibm-system` for the `ibm-cloud-provider-ip` pod, you notice a scheduling conflict error in the pod's events section of the output.

To identify the `ibm-cloud-provider-ip` pod for your gateway, you can run `kubectl get service -n istio-system` to find your gateway's load balancer service, note its **EXTERNAL-IP**, and look for the IP address in the `ibm-cloud-provider-ip` pod name.
{: tip}

{: tsCauses}
When an `istio-ingressgateway` load balancer service is created, an `ibm-cloud-provider-ip` pod is created to provide an external IP address to the load balancer. These `ibm-cloud-provider-ip` pods have a node affinity rule so that they are created in the same zone as the subnet from which the IP address is derived. However, when the `ExternalTrafficPolicy` setting for the `istio-ingressgateway` load balancer service is set to `Local`, then the `ibm-cloud-provider-ip` pod also has a pod affinity rule to be deployed to the same zone as the gateway load balancer pod. If the IP address and gateway load balancer exist in different zones in your cluster, the `ibm-cloud-provider-ip` pod cannot properly deploy.

To verify that the `ibm-cloud-provider-ip` and `istio-ingressgateway` pods do not exist in the same zone:

1. Identify the **NODE** that your `istio-ingressgateway` pod is deployed to.
  ```
  kubectl get pod -n istio-system -o wide
  ```
  {: pre}
2. Get the **EXTERNAL-IP** address for the gateway's load balancer service.
  ```
  kubectl get service -n istio-system
  ```
  {: pre}
3. Identify the **NODE** that the `ibm-cloud-provider-ip` pod for the load balancer is deployed to. Replace `<IP-with-hyphens>` with the IP address that you found in the previous step. In the IP address, use hyphens (-) instead of periods (.). For example, `169.12.345.67` becomes `169-12-345-67`.
  ```
  kubectl get pod -n ibm-system -o wide -l ibm-cloud-provider-ip=<IP-with-hyphens>
  ```
  {: pre}
4. List the zones that the worker nodes are in. Compare the worker nodes that you found in step 1 and 3 to determine whether the pods are deployed to worker nodes in different zones.
  ```
  kubectl get node --no-headers -L ibm-cloud.kubernetes.io/zone
  ```
  {: pre}

  Example output:
  ```
  10.176.48.106   Ready   <none>   529d    v1.20.7+IKS   dal10
  10.176.48.107   Ready   <none>   196d    v1.20.7+IKS   dal10
  10.184.58.23    Ready   <none>   2y38d   v1.20.7+IKS   dal12
  10.184.58.42    Ready   <none>   529d    v1.20.7+IKS   dal12
  ```
  {: screen}

{: tsResolve}
To resolve this issue, you can either move the `istio-ingressgateway` pod to the zone that the `ibm-cloud-provider-ip` pod exists in, or vice versa.
* [Moving the `istio-ingressgateway` pod](#move-gateway-pod): The gateway's load balancer retains the same external IP address after it moves. However, in version 1.9 and earlier of the add-on, the changes that you make might be overwritten when the zone labels for gateways are automatically populated during Istio patch updates.
* [Moving the `ibm-cloud-provider-ip` pod](#move-ip-pod): The gateway **does not** retain the same external IP address after it moves, and is assigned a new IP address. However, no changes are overwritten during add-on updates.

## Moving the `istio-ingressgateway` pod
{: #move-gateway-pod}

Move the `istio-ingressgateway` pod to the same zone as the `ibm-cloud-provider-ip` pod.
{: shortdesc}

1. Edit the `managed-istio-custom` configmap resource.
  ```
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

1. Edit the `managed-istio-custom` configmap resource.
  ```
  kubectl edit cm managed-istio-custom -n ibm-operators
  ```
  {: pre}

2. Note the name of the `istio-ingressgateway-zone-<1|2|3>` setting for the gateway. In this example configmap, to move the `ibm-cloud-provider-ip` pod for the gateway that exists in `dal10`, note the key that is called `istio-ingressgateway-zone-1`.
   ```
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

3. Temporarily disable the gateway by changing the corresponding `istio-ingressgateway-public-<1|2|3>-enabled` setting to `"false"`. In this example configmap, to move the `ibm-cloud-provider-ip` pod for the gateway that exists in `dal10`, change `istio-ingressgateway-public-1-enabled` to `"false"`.
   ```
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
  ```
  kubectl get service -n istio-system -o wide
  ```
  {: pre}

6. Open the `managed-istio-custom` configmap resource.
  ```
  kubectl edit cm managed-istio-custom -n ibm-operators
  ```
  {: pre}

7. Re-enable the gateway by changing the `istio-ingressgateway-public-<1|2|3>-enabled` setting back to `"true"`.

8. Save and close the configuration file. A new load balancer service for the gateway (the `istio-ingressgateway` pod) is created, and a new `ibm-cloud-provider-ip` pod for that load balancer is deployed to a worker node in the same zone as the `istio-ingressgateway` pod.

9. To verify that the pods now exist in the same zone, follow the steps in the **Why it’s happening** section.
