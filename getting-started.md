---

copyright:
  years: 2023, 2023
lastupdated: "2023-10-04"

keywords: containers, kubernetes cluster,  vpc cluster, classic cluster, clusters

subcollection: containers

---


{{site.data.keyword.attribute-definition-list}}



# Getting started with {{site.data.keyword.containerlong_notm}}
{: #getting-started}

{{site.data.keyword.containerlong_notm}} is a managed offering to create your own cluster of compute hosts where you can deploy and manage containerized apps on IBM Cloud. Combined with an intuitive user experience, built-in security and isolation, and advanced tools to secure, manage, and monitor your cluster workloads, you can rapidly deliver highly available and secure containerized apps in the public cloud.
{: shortdesc}

Complete the following steps to get familiar with the basics, understand the service components, create your first cluster, and deploy a starter app.

## Review the basics
{: #getting-started-basics}
{: step}

- Get an overview of the service by reviewing the concepts and terms, and benefits. For more information, see [Understanding {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-overview).

- [Review the FAQs](/docs/containers?topic=containers-faqs)

Already familiar with containers and {{site.data.keyword.containerlong_notm}}? Continue to the next step to prepare your account for creating clusters.

## Prepare your account
{: #getting-started-prepare-account}
{: step}

To set up your {{site.data.keyword.cloud_notm}} account so that you can create clusters, see [Preparing your account to create clusters](/docs/containers?topic=containers-clusters).

If you've already prepared your account and you're ready to create a cluster, continue to the next step.


## Create a cluster
{: #getting-started-create}
{: step}

Follow a tutorial, or set up your own custom cluster environment.



- [Tutorial]{: tag-blue} [Create a cluster in your own Virtual Private Cloud](/docs/containers?topic=containers-vpc_ks_tutorial).


- [Create a custom cluster on Classic infrastructure](/docs/containers?topic=containers-cluster-create-classic).

- [Create a custom cluster on VPC infrastructure](/docs/containers?topic=containers-cluster-create-vpc-gen2).


Already have a cluster? Continue to the next step to deploy an app!





## Deploy a sample app
{: #getting-started-deploy-app}
{: step}

After you create a cluster, deploy your first app. You can use a sample `websphere-liberty` Java application server that IBM provides and deploy the app to your cluster by using the Kubernetes dashboard.


1. Select your cluster from the [cluster list](https://cloud.ibm.com/kubernetes/clusters){: external}.
2. Click **Kubernetes dashboard**.
3. Click the **Create new resource** icon (`+`) and select the **Create from form** tab.
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
{: #getting-started-whats-next}


Check out the curated learning paths
- [Learning path for administrators](/docs/containers?topic=containers-learning-path-admin).
- [Learning path for developers](/docs/containers?topic=containers-learning-path-dev).


