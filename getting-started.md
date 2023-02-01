---

copyright:
  years: 2014, 2023
lastupdated: "2023-02-01"

keywords: kubernetes, containers

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}






# Getting started with {{site.data.keyword.containerlong_notm}}
{: #getting-started}

Deploy highly available containerized apps in Kubernetes clusters and use the powerful tools of {{site.data.keyword.containerlong}} to automate, isolate, secure, manage, and monitor your workloads across zones or regions.
{: shortdesc}

First, create a cluster with a few clicks in the {{site.data.keyword.cloud_notm}} console. Then, deploy your first containerized app to your cluster through the Kubernetes dashboard.

To complete the getting started tutorial, use a [Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account](/docs/account?topic=account-upgrading-account) where you are the owner or have [full Administrator access](/docs/account?topic=account-assign-access-resources).
{: note}

## Creating a free classic cluster
{: #clusters_gs}

Set up your free classic cluster with one worker node by using the {{site.data.keyword.cloud_notm}} console. For more information about free clusters, such as expiration and limited capabilities, see the [FAQ](/docs/containers?topic=containers-faqs#faq_free).
{: shortdesc}

1. In the [{{site.data.keyword.cloud_notm}} **Catalog**](https://cloud.ibm.com/catalog?category=containers){: external}, select **Kubernetes Service**. A cluster configuration page opens.
2. From the plan dropdown, select the **Free** cluster option.
3. Give your cluster a unique name, such as `mycluster-free`.
4. Select a resource group to create the cluster in, such as `default`.
5. In the **Summary** pane, review the order summary and then click **Create**. A worker pool is created that contains one worker node in the default resource group.

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster by [deploying your first app](#deploy-app)!


## Creating a VPC cluster
{: #vpc-gen2-gs}

Create a standard VPC cluster by using the {{site.data.keyword.cloud_notm}} console. For more detailed information about your cluster customization options, see [Creating a standard VPC cluster](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui).
{: shortdesc}

VPC clusters can be created as standard clusters only, and as such incur costs. Be sure to review the order summary at the end of this tutorial to review the costs for your cluster. To keep your costs to a minimum, set up your cluster as a single zone cluster with one worker node only.
{: important}

1. Create a Virtual Private Cloud (VPC) on generation 2 compute.
    1. Navigate to the [VPC create console](https://cloud.ibm.com/vpc/provision/vpc){: external}.
    2. Give the VPC a name and select a resource group to deploy the VPC into.
    3. Give the VPC subnet a name and select the location where you want to create the cluster.
    4. Attach a public gateway to your subnet so that you can access public endpoints from your cluster. This public gateway is used later on to access container images from Docker Hub.
    5. Click **Create virtual private cloud**.
2. From the [{{site.data.keyword.containerlong_notm}} dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click **Create cluster**.
3. Configure your VPC environment.
    1. Select the **Standard** plan.
    2. Select **Kubernetes** as your container platform and select the Kubernetes **version 1.25 or later**.
    3. Select **VPC** infrastructure.
    4. From the **Virtual private cloud** drop-down menu, select the VPC that you created earlier.
4. Configure the **Location** details for your cluster.
    1. Select the **Resource group** that you want to create your cluster in. You can't change the resource group later.
    2. Select the zones to create your cluster in. The zones are filtered based on the VPC that you selected, and include the subnets that you previously created.
5. Configure your **Worker pool** setup.
    1. If you want a larger size for your worker nodes, click **Change flavor**. Otherwise, leave the default **4 vCPUs / 16 GB** flavor selected.
    2. Set how many worker nodes to create per zone, such as **2**.
6. Review the rest of the cluster details, such as the service endpoint, cluster name, and tags.
7. In the **Summary** pane, review your order summary and then click **Create**.


The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster by [deploying your first app](#deploy-app)!



## Deploying an app to your cluster
{: #deploy-app}

After you create a [classic](#clusters_gs) or a [VPC](#vpc-gen2-gs) cluster with a public gateway, deploy your first app. You can use a sample `websphere-liberty` Java application server that IBM provides and deploy the app to your cluster by using the Kubernetes dashboard.
{: shortdesc}

The [Kubernetes dashboard](https://github.com/kubernetes/dashboard){: external} is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage Kubernetes resources that are within your cluster, such as pods, services, and namespaces. Not sure what all these Kubernetes resources mean? Check out the overview for [container](/docs/containers?topic=containers-iks-overview#docker_containers) and [Kubernetes](/docs/containers?topic=containers-iks-overview#kubernetes_basics) concepts.

The steps to deploy an app vary if you have a free or standard cluster, because free clusters don't support load balancers.

### Deploying an app to a free classic cluster and exposing it with a node port
{: #deployapp1}

Follow the steps to deploy an example `websphere-liberty` to your free classic cluster.
{: shortdesc}

1. Select your cluster from the [cluster list](https://cloud.ibm.com/kubernetes/clusters){: external} to open the details for your cluster.
2. Click **Kubernetes dashboard**.
3. From the menu bar, click the **Create new resource** icon (`+`).
4. Select the **Create from form** tab.
    1. Enter a name for your app, such as `liberty`.
    2. Enter `websphere-liberty` for your container image.
    3. Enter the number of pods for your app deployment, such as `1`.
    4. Leave the **Service** drop-down menu set to **None**.
5. Click **Deploy**. During the deployment, the cluster downloads the `websphere-liberty` container image from Docker Hub and deploys the app in your cluster.
6. Create a node port so that your app can be accessed by other users internally or externally. Because your cluster is a free cluster, you can only expose an app with a node port, not a load balancer or Ingress.
    1. Click the **Create new resource** icon (`+`).
    2. Copy the [node port YAML](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/gs-nodeport.yaml){: external} from GitHub
    3. In the **Create from input** box, paste the node port YAML that you copied in the previous step.
    4. Click **Upload**. The node port service is created.
7. From the menu, click **Services**, and note the TCP endpoint port of your `liberty` service in the node port range `30000 - 32767`, such as `liberty:32323 TCP`.
8. From the menu, click **Pods**, and note the **Node** that your pod runs on, such as `10.xxx.xx.xxx`.
9. Return to the [{{site.data.keyword.cloud_notm}} clusters console](https://cloud.ibm.com/kubernetes/clusters), select your cluster, and click the **Worker Nodes** tab. Find the **Public IP** of the worker node that matches the private IP of the node that the pod runs on.
10. In a tab in your browser, form the URL of your app by combining `http://` with the public IP and TCP port that you previously retrieved. For example, `http://169.xx.xxx.xxx:32323`. The **Welcome to Liberty** page is displayed.

Great job! You just deployed your first app in your Kubernetes cluster.




### Deploying an app to a standard cluster and exposing with a load balancer
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
- Plan your [cluster network setup](/docs/containers?topic=containers-plan_clusters), develop a [highly available architecture](/docs/containers?topic=containers-ha_clusters), and [set up autoscaling](/docs/containers?topic=containers-cluster-scaling-classic-vpc) for your cluster.
- Create [image pull secrets](/docs/containers?topic=containers-registry#other) to [deploy apps](/docs/containers?topic=containers-app) to Kubernetes namespaces other than `default`.
- Decide what type of [file, block, object, database, or software-defined storage](/docs/containers?topic=containers-storage_planning) you want to integrate with your apps.
- Control network traffic to your apps for [classic](/docs/containers?topic=containers-network_policies) and [VPC](/docs/containers?topic=containers-vpc-network-policy) clusters.

Explore other capabilities for your cluster.
- Check out [{{site.data.keyword.cloud_notm}} and 3rd-party services](/docs/containers?topic=containers-supported_integrations), such as Portworx.
- Enhance your app lifecycle with [managed add-ons](/docs/containers?topic=containers-managed-addons) like Istio.

Looking for an overview of all your options in {{site.data.keyword.containerlong_notm}}? Check out the curated [learning path for administrators](/docs/containers?topic=containers-learning-path-admin) or [learning path for developers](/docs/containers?topic=containers-learning-path-dev).
{: tip}






