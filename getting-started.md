---

copyright:
  years: 2014, 2023
lastupdated: "2023-07-27"

keywords: kubernetes, containers

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}






# Getting started with {{site.data.keyword.containerlong_notm}}
{: #getting-started}

Deploy highly available containerized apps in Kubernetes clusters and use the powerful tools of {{site.data.keyword.containerlong}} to automate, isolate, secure, manage, and monitor your workloads across zones or regions.
{: shortdesc}

First, create a cluster in the {{site.data.keyword.cloud_notm}} console or {{site.data.keyword.containerlong_notm}} CLI. Then, deploy your first containerized app to your cluster.

To complete the getting started tutorial, use a [Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account](/docs/account?topic=account-upgrading-account) where you are the owner or have [full Administrator access](/docs/account?topic=account-assign-access-resources).
{: note}


## Creating a VPC cluster in the {{site.data.keyword.cloud_notm}} console
{: #vpc-gen2-gs}
{: ui}

Create a standard VPC cluster by using the {{site.data.keyword.cloud_notm}} console. For more detailed information about your cluster customization options, see [Creating a standard VPC cluster](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui).


## Creating classic clusters in the {{site.data.keyword.containerlong_notm}} CLI
{: #clusters_gs_classic_cli}
{: cli}

Review the sample commands for creating classic clusters in the CLI. For more detailed steps and information about creating clusters, see [Creating classic clusters](/docs/containers?topic=containers-cluster-create-classic&interface=cli). For information about planning your cluster set up, see [Preparing to create clusters](/docs/containers?topic=containers-clusters&interface=cli).
{: shortdesc}


Create a classic cluster on a shared virtual machine.

```sh
ibmcloud ks cluster create classic --name my_cluster --zone dal10 --flavor b3c.4x16 --hardware shared --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
```
{: pre}


Create a classic cluster with bare metal architecture. 

```sh
ibmcloud ks cluster create classic --name my_cluster --zone dal10 --flavor mb2c.4x32 --hardware dedicated --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
```
{: pre}

Create a classic cluster that uses private VLANs and the private cloud service endpoint only.

```sh
ibmcloud ks cluster create classic --name my_cluster --zone dal10 --flavor b3c.4x16 --hardware shared --workers 3 --private-vlan <private_VLAN_ID> --private-only --private-service-endpoint
```
{: pre}


For a classic multizone cluster, after you created the cluster in a [multizone metro](/docs/containers?topic=containers-regions-and-zones#zones-mz), [add zones](/docs/containers?topic=containers-add_workers#add_zone):
```sh
ibmcloud ks zone add classic --zone <zone> --cluster <cluster_name_or_ID> --worker-pool <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
```
{: pre}

## Creating VPC clusters in the CLI
{: #clusters_gs_vpc_cli}
{: cli}

Review the sample commands for creating classic clusters in the CLI. For more detailed steps and information about creating clusters, see [Creating VPC clusters](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=cli#cluster_create_vpc). For information about planning your cluster set up, see [Preparing to create clusters](/docs/containers?topic=containers-clusters&interface=cli).
{: shortdesc}

Create a VPC cluster with three worker nodes.

```sh
ibmcloud ks cluster create vpc-gen2 --name my_cluster --zone us-east-1 --vpc-id <VPC_ID> --subnet-id <VPC_SUBNET_ID> --flavor bx2.4x16 --workers 3
```
{: pre}

For a VPC multizone cluster, after you created the cluster in a [multizone metro](/docs/containers?topic=containers-regions-and-zones#zones-vpc), [add zones](/docs/containers?topic=containers-add_workers#vpc_add_zone).

```sh
ibmcloud ks zone add vpc-gen2 --zone <zone> --cluster <cluster_name_or_ID> --worker-pool <pool_name> --subnet-id <VPC_SUBNET_ID>
```
{: pre}

## Deploying an app to your cluster
{: #deploy-app}

After you create a cluster, deploy your first app. You can use a sample `websphere-liberty` Java application server that IBM provides and deploy the app to your cluster by using the Kubernetes dashboard.
{: shortdesc}

The [Kubernetes dashboard](https://github.com/kubernetes/dashboard){: external} is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage Kubernetes resources that are within your cluster, such as pods, services, and namespaces. Not sure what all these Kubernetes resources mean? Check out the overview for [container](/docs/containers?topic=containers-overview) and [Kubernetes](/docs/containers?topic=containers-overview) concepts.

### Deploying and exposing an app with a load balancer
{: #deployapp2}

Follow the steps to deploy an example `websphere-liberty` to your standard cluster.
{: shortdesc}

1. Select your cluster from the [cluster list](https://cloud.ibm.com/kubernetes/clusters){: external} to open the details for your cluster.
2. Click **Kubernetes dashboard**.
3. From the menu bar, click the **Create new resource** icon (`+`).
4. Select the **Create from form** tab.
    1. Enter a name for your app, such as `liberty`.
    2. Enter `websphere-liberty` for your container image. Remember that your cluster's VPC subnet must have a public gateway so that the cluster can pull an image from DockerHub.
    3. Enter the number of pods for your app deployment, such as `1`.
    4. From the **Service** drop-down menu, select **External** to create a `LoadBalancer` service that external users can use to access the app. Configure the external service as follows.
        - **Port**: `80`
        - **Target port**: `9080`
        - **Protocol**: `TCP`
5. Click **Deploy**. During the deployment, the cluster downloads the `websphere-liberty` container image from Docker Hub and deploys the app in your cluster. Your app is exposed by a Layer 4, version 1.0 network load balancer (NLB) so that it can be accessed by other users internally or externally. For other ways to expose an app such as Ingress, see [Planning in-cluster and external networking for apps](/docs/containers?topic=containers-cs_network_planning).
6. From the **Pods** menu, click your `liberty` pod and check that its status is **Running**.
7. From the **Services** menu, click the **External Endpoint** of your `liberty` service. For example, `169.xx.xxx.xxx:80` for classic clusters or `http://<hash>-<region>.lb.appdomain.cloud/` for VPC clusters. The **Welcome to Liberty** page is displayed.



Great job! You just deployed your first app in your Kubernetes cluster.



## What's next?
{: #whats-next}

Go through a tutorial to install the CLI, create a private image registry, set up your cluster environment, add an {{site.data.keyword.cloud_notm}} service to the cluster, and deploy an app.

- [VPC clusters tutorial](/docs/containers?topic=containers-vpc_ks_tutorial)

Set up the correct environment for your workloads.
- Plan your [cluster network setup](/docs/containers?topic=containers-plan_clusters), develop a [highly available architecture](/docs/containers?topic=containers-ha_clusters), and [set up autoscaling](/docs/containers?topic=containers-cluster-scaling-install-addon) for your cluster.
- Create [image pull secrets](/docs/containers?topic=containers-registry#other) to [deploy apps](/docs/containers?topic=containers-app) to Kubernetes namespaces other than `default`.
- Decide what type of [file, block, object, database, or software-defined storage](/docs/containers?topic=containers-storage-plan) you want to integrate with your apps.
- Control network traffic to your apps for [classic](/docs/containers?topic=containers-network_policies) and [VPC](/docs/containers?topic=containers-vpc-network-policy) clusters.

Explore other capabilities for your cluster.
- Check out [{{site.data.keyword.cloud_notm}} and 3rd-party services](/docs/containers?topic=containers-supported_integrations), such as Portworx.
- Enhance your app lifecycle with [managed add-ons](/docs/containers?topic=containers-managed-addons) like Istio.

Looking for an overview of all your options in {{site.data.keyword.containerlong_notm}}? Check out the curated [learning path for administrators](/docs/containers?topic=containers-learning-path-admin) or [learning path for developers](/docs/containers?topic=containers-learning-path-dev).
{: tip}






