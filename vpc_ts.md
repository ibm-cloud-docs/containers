---

copyright:
  years: 2014, 2019
lastupdated: "2019-08-19"

keywords: kubernetes, iks, vpc

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:preview: .preview}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}

# Troubleshooting VPC clusters
{: #vpc_troubleshoot}

Review some known issues or common error messages that you might encounter when you use VPC clusters.
{: shortdesc}

## Cannot connect to an app via load balancer
{: #vpc_ts_lb}

{: tsSymptoms}
You publicly exposed your app by creating a Kubernetes `LoadBalancer` service in your VPC cluster. When you try to connect to your app by using the host name that is assigned to the Kubernetes `LoadBalancer`, the connection fails or times out.

When you run `kubectl describe svc <kubernetes_lb_service_name>`, you see a warning message similar to one the following in the **Events** section:
```
The VPC load balancer that routes requests to this Kubernetes `LoadBalancer` service is offline.
```
{: screen}
```
The VPC load balancer that routes requests to this Kubernetes `LoadBalancer` service was deleted from your VPC account.
```
{: screen}

{: tsCauses}
When you create a Kubernetes `LoadBalancer` service in your cluster, a VPC load balancer is automatically created in your VPC account. The VPC load balancer routes requests only to the app that the Kubernetes `LoadBalancer` service exposes. Requests cannot be routed to your app in the following situations:
* The VPC load balancer is offline, such as due to load balancer provisioning errors or VSI connection errors.
* The VPC load balancer is deleted through the VPC console or the CLI.
* The VPC load balancer's DNS entry is still registering.

{: tsResolve}
Verify that the VPC load balancer for the Kubernetes `LoadBalancer` service exists. In the output, look for the VPC load balancer that is formatted `kube-<cluster_ID>-<kubernetes_lb_service_UID>`. You can get the Kubernetes `LoadBalancer` service UID by running `kubectl get svc <service_name> -o yaml`.
  ```
  ibmcloud is load-balancers
  ```
  {: pre}

* If the VPC load balancer is not listed, it was deleted through the VPC console or the CLI. To recreate the VPC load balancer for your Kubernetes `LoadBalancer` service, restart the Kubernetes master by running `ibmcloud ks apiserver-refresh --cluster <cluster_name_or_id>`. <p class="tip">If you want to remove the load-balancing setup for an app in your VPC cluster, delete the Kubernetes `LoadBalancer` service by running `kubectl delete svc <kubernetes_lb_service_name>`. The VPC load balancer that is associated with the Kubernetes `LoadBalancer` service is automatically deleted from your VPC account.</p>
* If the VPC load balancer is listed, its DNS entry might still be registering. When a VPC load balancer is created, the hostname is registered through a public DNS. In some cases, it can take several minutes for this DNS entry to be replicated to the specific DNS that your client is using. You can either wait for the hostname to be registered in your DNS, or access the VPC load balancer directly by using one of its IP addresses. To find the VPC load balancer IP addresses, look for the **Public IP** column in the output of `ibmcloud is load-balancers`. If after several minutes you cannot reach the load balancer, it might be offline due to provisioning or connection issues. [Open an {{site.data.keyword.cloud_notm}} support case](https://cloud.ibm.com/unifiedsupport/cases/add). For the type, select **Technical**. For the category, select **Network** in the VPC section. In the description, include your cluster ID and the VPC load balancer ID.

## Cannot connect to an app via Ingress
{: #vpc_ts_alb}

{: tsSymptoms}
You publicly exposed your app by creating an Ingress resource for your app in your cluster. When you tried to connect to your app by using the subdomain of the Ingress application load balancer (ALB), the connection failed or timed out.

{: tsCauses}
When you create a VPC cluster, one public and one private VPC load balancer is automatically created outside of your cluster in your VPC. The VPC load balancer routes requests to the apps that the ALBs expose. Requests cannot be routed to your app in the following situations:
* The VPC load balancer is offline, such as due to load balancer provisioning errors or VSI connection errors.
* The VPC load balancer is deleted through the VPC console or the CLI.
* The VPC load balancer's DNS entry is still registering.

{: tsResolve}
Verify that the VPC load balancer for your ALBs exists. In the output, look for the VPC load balancer that has the same **Host Name** as your public or private ALBs. You can see the host names for your public and private ALBs by running `ibmcloud ks albs --cluster <cluster_name_or_ID>` and looking for the **Load Balancer Hostname** field.
  ```
  ibmcloud is load-balancers
  ```
  {: pre}

* If the VPC load balancer is not listed, it was deleted through the VPC console or the CLI. To recreate the VPC load balancer for your ALBs, disable all of the public or private ALBs that are assigned that VPC load balancer's host name by running `ibmcloud ks alb-configure-vpc-classic --albID <ALB_ID> --disable` for each ALB. Then, re-enable those ALBs by running `ibmcloud ks alb-configure-vpc-classic --albID <ALB_ID> --enable` for each ALB. A new VPC load balancer for the ALBs takes a few minutes to provision in your VPC account. You cannot access your app until the VPC load balancer for your ALBs is fully provisioned.
* If the VPC load balancer is listed, its DNS entry might still be registering. When a VPC load balancer is created, the hostname is registered through a public DNS. In some cases, it can take several minutes for this DNS entry to be replicated to the specific DNS that your client is using. You can either wait for the hostname to be registered in your DNS, or access the VPC load balancer directly by using one of its IP addresses. To find the VPC load balancer IP addresses, look for the **Public IP** column in the output of `ibmcloud is load-balancers`. If after several minutes you cannot reach the load balancer, it might be offline due to provisioning or connection issues. [Open an {{site.data.keyword.cloud_notm}} support case](https://cloud.ibm.com/unifiedsupport/cases/add). For the type, select **Technical**. For the category, select **Network** in the VPC section. In the description, include your cluster ID and the VPC load balancer ID.


