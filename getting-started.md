---

copyright:
  years: 2014, 2019
lastupdated: "2019-11-26"

keywords: kubernetes, iks, containers

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



<style>
<!--
    #tutorials { /* hide the page header */
        display: none !important
    }
    .allCategories {
        display: flex !important;
        flex-direction: row !important;
        flex-wrap: wrap !important;
    }
    .icon {
        width: 1rem;
        height: 1rem;
    }
    .bx--tile-content {
        box-shadow: 0 1px 2px 0 rgba(0,0,0,0.2);
        background-color: #fff;
        border: 1px solid #dfe3e6;
    }
    .solutionBoxContainer {}
    .solutionBox {
        display: inline-block !important;
        width: 100% !important;
        margin: 10px 10px 10px 10px !important;
        padding: 10px !important;
        border: 1px #dfe6eb solid !important;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2) !important;
    }
    @media screen and (min-width: 960px) {
        .solutionBox {
        width: 27% !important;
        }
        .solutionBoxContent {
        height: 300px !important;
        }
    }
    @media screen and (min-width: 1298px) {
        .solutionBox {
        width: calc(33% - 2%) !important;
        }
        .solutionBoxContent {
        min-height: 300px !important;
        }
    }
    .solutionBox:hover {
        border-color: rgb(136, 151, 162) !important;
    }
    .solutionBoxDescription {
        flex-grow: 1 !important;
        display: flex !important;
        flex-direction: column !important;
    }
-->
</style>

# Getting started with {{site.data.keyword.containerlong_notm}}
{: #getting-started}

Deploy highly available containerized apps in Kubernetes clusters and use the powerful tools of {{site.data.keyword.containerlong}} to automate, isolate, secure, manage, and monitor your workloads across zones or regions.
{: shortdesc}

  <div class=solutionBoxContainer>
  <div class="solutionBox">
   <a href = "#clusters_gs">
    <div>
         <h2 style="margin: 10px 10px 10px 10px;"><img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic clusters</h2>
         <p class="bx--type-caption" style="margin: 10px 10px 10px 10px;">Create a Kubernetes cluster on {{site.data.keyword.cloud_notm}} classic infrastructure worker nodes with classic subnet and VLAN networking support. Choose between a variety of virtual, bare metal, GPU, or software-defined storage flavors. </br></p>
    </div>
    </a>
</div>
  <div class="solutionBox">
   <a href = "#vpc-classic-gs">
    <div>
         <h2 style="margin: 10px 10px 10px 10px;"><img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC</h2>
         <p class="bx--type-caption" style="margin: 10px 10px 10px 10px;">Create your cluster in the first generation of compute resources in a Virtual Private Cloud (VPC) that gives you the security of a private cloud with the dynamic scalability of a public cloud.  </p>
     </div>
    </a>
</div>
    </div>

## Getting started with classic clusters
{: #clusters_gs}

Create a free classic cluster with one worker node and deploy your first app to {{site.data.keyword.cloud_notm}}.
{:shortdesc}

### Creating a free classic cluster
{: #classic-cluster-create}

Set up your free classic cluster with one worker node by using the {{site.data.keyword.cloud_notm}} console.
{: shortdesc}

Before you begin:
- Make sure that you have a [billable Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account](https://cloud.ibm.com/registration). In this getting started tutorial you create a free classic cluster with one worker node. Although this cluster does not incur any costs, you must have a billable {{site.data.keyword.cloud_notm}} account to create the cluster.
- Make sure that you are assigned the following permissions in {{site.data.keyword.cloud_notm}} Identity and Access Management. If you are the {{site.data.keyword.cloud_notm}} account owner, you already have all permissions by default.
  * [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}} at the account level.
  * [**Writer** or **Manager** service role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}.
  * [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for Container Registry at the account level.
  *  **Super User** role or the [minimum required permissions](/docs/containers?topic=containers-access_reference#infra) for classic infrastructure.

To create a free classic cluster:

1.  In the [{{site.data.keyword.cloud_notm}} **Catalog** ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/catalog?category=containers), select **Kubernetes Service** and click **Create**. A cluster configuration page opens. Select the **free** cluster option. 

2.  Give your cluster a unique name.

3.  Click **Create Cluster**. A worker pool is created that contains one worker node.   

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster!

### Deploying an app to your classic cluster
{: #classic-deploy-app}

Deploy your first `nginx` app in your classic cluster by using the Kubernetes dashboard. The [Kubernetes dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard) is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage resources that are within your cluster, such as pods, services, and namespaces.
{: shortdesc}

Looking to have more control over what and how you deploy resources to the cluster, gain access to other features, such as storage and logs, or to implement automation for your CI/CD pipeline? Follow the steps on the **Access** tab to install the {{site.data.keyword.containerlong_notm}} CLI to connect to your cluster. Then, learn how you [use the CLI to deploy apps](/docs/containers?topic=containers-app#app_cli) to your cluster. 
{: tip}

1. Select your cluster from the [cluster list](https://cloud.ibm.com/kubernetes/clusters) to open the details for your cluster. 
2. Click **Kubernetes dashboard**.
3. Click **Create**.
4. Select the **Create an app** tab.
5. Configure your `nginx` app that is available in your cluster only.
   1. Enter a name for your app.
   2. Enter `nginx` for your container image.
6. Click **Deploy**. During the deployment, the cluster downloads the `nginx` container image from Docker Hub and deploys the app in your cluster. Your app is not exposed by a Kubernetes service and as such cannot be accessed by other workloads internally or externally. If you plan to make this app available to other workloads or to users on the internet, review ways to expose your app in [Planning in-cluster and external networking for apps](/docs/containers?topic=containers-cs_network_planning). 
7. From the **Workloads** > **Deployments** menu, select your `nginx` deployment and review the details for your deployment.

Great job! You just deployed your first app in your Kubernetes classic cluster.

### What's next
{: #classic-whats-next}

- Go through the [{{site.data.keyword.containerlong_notm}} tutorial](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial) for installing the CLI or using the Kubernetes Terminal, creating a private registry, setting up your cluster environment, adding a service to your cluster, and deploying a {{site.data.keyword.watson}} app.
- [Create a standard classic cluster](/docs/containers?topic=containers-clusters#clusters_ui) with multiple worker nodes that you can customize to your workload requirements and set up your cluster for high availability.

<br />


## Getting started with VPC Gen 1 compute clusters
{: #vpc-classic-gs}

Create a Virtual Private Cloud (VPC), provision your standard VPC Generation 1 compute cluster, and deploy your first app by using the {{site.data.keyword.cloud_notm}} console.
{:shortdesc}

### Creating a standard VPC Gen 1 compute cluster
{: #vpc-classic-cluster-create}

Create a standard VPC Generation 1 compute cluster in a [single zone](/docs/containers?topic=containers-ha_clusters#single_zone) by using the {{site.data.keyword.cloud_notm}} console. For more detailed information about your cluster customization options, see [Creating a standard VPC Gen 1 compute cluster](/docs/containers?topic=containers-clusters#clusters_vpc_standard).
{: shortdesc}

VPC clusters can be created as a standard cluster only, and as such incur costs. Be sure to review the order summary at the end of this tutorial to review the costs for your cluster. To keep your costs to a minimum, set up your cluster as a single zone cluster with one worker node only.
{: important}

Before you begin:
- Make sure that you have a [billable Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account](https://cloud.ibm.com/registration/).
- Make sure that you are assigned the following permissions in {{site.data.keyword.cloud_notm}} Identity and Access Management.
  * VPC clusters: [**Administrator** platform role for VPC Infrastructure](/docs/vpc-on-classic?topic=vpc-on-classic-managing-user-permissions-for-vpc-resources).
  * [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}} at the account level.
  * [**Writer** or **Manager** service role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}.
  * [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for Container Registry at the account level.

To create a standard VPC cluster:

1. [Create a Virtual Private Cloud (VPC) ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/vpc/provision/vpc) with a subnet that is located in the zone where you want to create the cluster. Make sure to attach a public gateway to your subnet so that you can access public endpoints from your cluster. This public gateway is used later on to access container images from DockerHub.
2. From the [{{site.data.keyword.containerlong_notm}} dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/kubernetes/clusters), click **Create cluster**.
3. Configure your cluster environment.
   1. Select **Kubernetes** as your container platform and select the Kubernetes **version 1.15 or later**.
   2. Select **VPC infrastructure**.
   3. From the **Virtual Private Cloud** drop-down menu, select the VPC that you created earlier.
   4. Fill out the cluster name, resource group, and geography.
   5. For the **Location**, select the zone for which you created a VPC subnet earlier.
4. Select the **2 vCPUs 4GB RAM** worker node flavor.
5. For the number of worker nodes, enter **1**.
6. Review the order summary to verify the estimated costs for your cluster.
7. Click **Create cluster**.

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster!

### Deploying an app to your VPC Gen 1 compute cluster
{: #vpc-deploy-app}

With your VPC cluster all set up, deploy your first `nginx` app by using the Kubernetes dashboard. The [Kubernetes dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard) is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage resources that are within your cluster, such as pods, services, and namespaces.
{: shortdesc}

1. Select your cluster from the [cluster list](https://cloud.ibm.com/kubernetes/clusters) to open the details for your cluster. 
2. Click **Kubernetes dashboard**.
3. Click **Create**.
4. Select the **Create an app** tab.
5. Configure your `nginx` app.
   1. Enter a name for your app.
   2. Enter `nginx` for your container image.
6. Click **Deploy**. During the deployment, the cluster downloads the `nginx` container image from Docker Hub and deploys the app in your cluster. Your app is not exposed by a Kubernetes service and as such cannot be accessed by other workloads internally or externally. If you plan to make this app available to other workloads or to users on the internet, review ways to expose your app in [Planning in-cluster and external networking for apps](/docs/containers?topic=containers-cs_network_planning). 
7. From the **Workloads** > **Deployments** menu, select your `nginx` deployment and review the details for your deployment.

Great job! You just deployed your first app in your Kubernetes VPC cluster.

### What's next
{: #vpc-classic-whats-next}

- Go through the [VPC cluster tutorial](/docs/containers?topic=containers-vpc_ks_tutorial) for installing the CLI, setting up your cluster environment, and deploying an app with a VPC load balancer that exposes your app on the internet.
- Explore other capabilities, such as creating a [multizone VPC cluster](/docs/containers?topic=containers-ha_clusters#multizone), controlling network access with [VPC access control lists](/docs/containers?topic=containers-vpc-network-policy), and [adding VPC Block Storage](/docs/containers?topic=containers-vpc-block) to your apps.





