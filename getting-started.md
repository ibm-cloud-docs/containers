---

copyright:
  years: 2023, 2026
lastupdated: "2026-05-01"


keywords: containers, {{site.data.keyword.containerlong_notm}}, kubernetes cluster,  vpc cluster, classic cluster, clusters

subcollection: containers

---


{{site.data.keyword.attribute-definition-list}}



# Getting started with {{site.data.keyword.containerlong_notm}}
{: #getting-started}

{{site.data.keyword.containerlong_notm}} is a managed Kubernetes service to create your own cluster of compute hosts where you can deploy and manage containerized apps on IBM Cloud. Combined with an intuitive user experience, built-in security and isolation, and advanced tools to secure, manage, and monitor your cluster workloads, you can rapidly deliver highly available and secure containerized apps in the public cloud.
{: shortdesc}

## Ready to create your first cluster?
{: #getting-started-quick-start}

If you already have an IBM Cloud account and want to get started immediately:

[Create a cluster now](https://cloud.ibm.com/containers/cluster-management/catalog/create){: external}

Don't have an account? [Sign up for IBM Cloud](https://cloud.ibm.com/registration?target=/kubernetes/catalog/create){: external}

Use this page to move through the main setup flow: review the service, prepare your account, plan your environment, create a cluster, and deploy a sample app.

## Review the basics
{: #getting-started-basics}

Start with the core concepts, terminology, and benefits. For more information, see [Understanding {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-overview).

If you already know the basics, continue to the next section.

## Prepare your account
{: #getting-started-prepare-account}

Make sure that your {{site.data.keyword.cloud_notm}} account is ready for cluster creation. For setup steps, see [Preparing your account to create clusters](/docs/containers?topic=containers-clusters).

You must be logged in to IBM Cloud before you create a cluster. If you don't have an account yet, you can [create one](https://cloud.ibm.com/registration){: external}.

### Pricing considerations
{: #getting-started-pricing}

Pricing varies based on worker node flavor, number of nodes, and infrastructure type. For more information, see [Kubernetes Service pricing](https://cloud.ibm.com/containers/cluster-management/catalog/about#pricing){: external}.

## Create a cluster environment strategy
{: #getting-started-strategy}

Before you create a cluster, review the main design choices in [Creating a cluster environment strategy](/docs/containers?topic=containers-strategy). This topic helps you decide on factors such as infrastructure, networking, and availability.

## Create a cluster
{: #getting-started-create}

Follow a tutorial or set up your own custom cluster environment. Review the following table for your deployment options.


| Type | Level | Time | Description |
| --- | --- | --- | --- | 
| Tutorial| Beginner | 1 hour | Follow the steps in this tutorial to create your own Virtual Private Cloud (VPC), then create an {{site.data.keyword.containerlong_notm}} cluster by using the CLI. For more information, see [Create a cluster in your own Virtual Private Cloud](/docs/containers?topic=containers-vpc_ks_tutorial). |
| Custom deployment | Intermediate | 1-3 hours | [Create a custom cluster on Classic infrastructure](/docs/containers?topic=containers-cluster-create-classic). |
| Custom deployment | Intermediate | 1-3 hours | [Create a custom cluster on VPC infrastructure](/docs/containers?topic=containers-cluster-create-vpc-gen2). |
{: caption="Options for creating a cluster" caption-side="bottom"}

Already have a cluster? **[Learn how to access it](/docs/containers?topic=containers-access_cluster)** and continue to the next step to deploy a sample app!





## Deploy a sample app
{: #getting-started-deploy-app}
{: step}

After you create a cluster, deploy a sample app by using the Kubernetes dashboard.

1. Select your cluster from the [cluster list](https://cloud.ibm.com/kubernetes/clusters){: external}.
2. Click **Kubernetes dashboard**.
3. Click the **Create new resource** icon (`+`), then select the **Create from form** tab.
4. Enter a name for your app, such as `liberty`.
5. Enter `websphere-liberty` for the container image.
6. Enter the number of pods for your app deployment, such as `1`.
7. From the **Service** list, select **External** to create a `LoadBalancer` service.
8. Configure the external service:
   - **Port**: `80`
   - **Target port**: `9080`
   - **Protocol**: `TCP`
9. Click **Deploy**.
10. From the **Pods** menu, confirm that your `liberty` pod status is **Running**.
11. From the **Services** menu, open the **External Endpoint** of your `liberty` service. For example, `169.xx.xxx.xxx:80` for classic clusters or `http://<hash>-<region>.lb.appdomain.cloud/` for VPC clusters.

Your app is exposed by a Layer 4, version 1.0 network load balancer. To learn about other exposure options, see [Planning in-cluster and external networking for apps](/docs/containers?topic=containers-cs_network_planning).




## Quick actions
{: #getting-started-quick-actions}

If you already have a cluster, use these links to continue:

Access your cluster
:   Connect to your cluster and run kubectl commands. For more information, see [Accessing clusters](/docs/containers?topic=containers-access_cluster).

Install the CLI
:   Set up your local development environment. For more information, see [Installing the CLI](/docs/containers?topic=containers-cli-install).

Deploy your first app
:   Get hands-on with a sample application. For more information, see [Deploying apps](/docs/containers?topic=containers-app).

Need to check pricing first? [View Kubernetes Service pricing](https://cloud.ibm.com/containers/cluster-management/catalog/about#pricing){: external}.

## What's next?
{: #getting-started-whats-next}

Continue with one of these curated learning paths:
- [Learning path for administrators](/docs/containers?topic=containers-learning-path-admin).
- [Learning path for developers](/docs/containers?topic=containers-learning-path-dev).
