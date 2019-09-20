---

copyright:
  years: 2014, 2019
lastupdated: "2019-09-20"

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
         <h2 style="margin: 10px 10px 10px 10px;"><img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC on Classic</h2>
         <p class="bx--type-caption" style="margin: 10px 10px 10px 10px;">Create your cluster in a Virtual Private Cloud (VPC) that gives you the security of a private cloud with the dynamic scalability of a public cloud. Control network traffic with security groups and access control lists.   </p>
     </div>
    </a>
</div>
    </div>
   

## Overview
{: #gs-overview}

Learn more about {{site.data.keyword.containerlong}}, its capabilities and the options that are available to you to customize the cluster to your needs.
{: shortdesc}

**What is {{site.data.keyword.containerlong_notm}} and how does it work?** </br>
{{site.data.keyword.containerlong_notm}} is a managed Kubernetes offering to create your own Kubernetes cluster of compute hosts to deploy and manage containerized apps on {{site.data.keyword.cloud_notm}}. As a certified Kubernetes provider, {{site.data.keyword.containerlong_notm}} provides intelligent scheduling, self-healing, horizontal scaling, service discovery and load balancing, automated rollouts and rollbacks, and secret and configuration management for your apps. Combined with an intuitive user experience, built-in security and isolation, and advanced tools to secure, manage, and monitor your cluster workloads, you can rapidly deliver highly available and secure containerized apps in the public cloud.

**What is Kubernetes?** </br>
Kubernetes is an open source platform for managing containerized workloads and services across multiple hosts, and offers management tools for deploying, automating, monitoring, and scaling containerized apps with minimal to no manual intervention. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational).

**What container platform can I choose from?** </br>
With {{site.data.keyword.containerlong_notm}}, you can select from two container management platforms: the IBM version of community Kubernetes and Red Hat OpenShift on IBM Cloud. In community Kubernetes clusters, you get access to community Kubernetes API features that are considered beta or higher by the community. Your worker nodes are set up with an Ubuntu operating system and you can use native Kubernetes commands or APIs to work with your cluster and the cluster resources. Red Hat OpenShift on IBM Cloud is a Kubernetes-based platform that is designed especially to accelerate your containerized app delivery processes that run on a Red Hat Enterprise Linux 7 operating system. For more information, see [Comparison between OpenShift and community Kubernetes clusters](/docs/openshift?topic=openshift-why_openshift#openshift_kubernetes).

In this getting started tutorial, you create a community Kubernetes cluster. If you want to create an OpenShift cluster instead, see [Getting started with {{site.data.keyword.openshiftlong}}](/docs/openshift?topic=openshift-getting-started).
{: note}

**What compute host infrastructure does the service offer?** </br>
With {{site.data.keyword.containerlong_notm}}, you can create your cluster of compute hosts on classic {{site.data.keyword.cloud_notm}} infrastructure., or VPC on Classic infrastructure. 

[Classic clusters](#clusters_gs) are created on your choice of virtual or bare metal worker nodes that are connected to VLANs. If you require additional local disks, you can also choose one of the bare metal flavors that are designed for software-defined storage solutions, such as Portworx. Depending on the level of hardware isolation that you need, virtual worker nodes can be set up as shared or dedicated nodes, whereas bare metal machines are always set up as dedicated nodes.


[VPC on Classic clusters](#vpc-classic-gs) are created in your own Virtual Private Cloud that gives you the security of a private cloud environment with the dynamic scalability of a public cloud. You use security groups as your virtual firewalls for instance-level protection, and network access control lists to protect the subnets that your worker nodes are connected to. VPC on Classic clusters can be provisioned on shared virtual infrastructure only.

For more information, see [Overview of Classic and VPC infrastructure providers](/docs/containers?topic=containers-infrastructure_providers). 

**Where can I learn more about the service?** </br>
Review the following links to find out more about the benefits and responsibilities when you use {{site.data.keyword.containerlong_notm}}.

- [Benefits of using {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-cs_ov)
- [Comparison of free and standard clusters](/docs/containers?topic=containers-cs_ov#cluster_types)
- [{{site.data.keyword.containerlong_notm}} service architecture](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture)
- [Use cases](/docs/containers?topic=containers-cs_uc_intro)
- [Your responsibilities by using {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-responsibilities_iks)
- [Defining your Kubernetes strategy](/docs/containers?topic=containers-strategy)

<br />


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

1.  In the [{{site.data.keyword.cloud_notm}} **Catalog** ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/catalog?category=containers), select **Kubernetes Cluster** and click **Create**. A cluster configuration page opens. By default, **Free cluster** is selected.

2.  Give your cluster a unique name.

3.  Click **Create Cluster**. A worker pool is created that contains one worker node.   

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster!

### Deploying an app to your classic cluster
{: #classic-deploy-app}

Deploy your first `nginx` app in your classic cluster by using the Kubernetes dashboard. The [Kubernetes dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard) is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage resources that are within your cluster, such as pods, services, and namespaces.
{: shortdesc}

1. From the cluster details page, click **Kubernetes dashboard**.
2. Click **Create**.
3. Select the **Create an app** tab.
4. Configure your `nginx` app.
   1. Enter a name for your app.
   2. Enter **nginx** for your container image.
5. Click **Deploy**.
6. From the **Workloads** > **Deployments** menu, select your `nginx` deployment and review the details for your deployment.

Congratulations! You just deployed your first app in your Kubernetes classic cluster.

### What's next
{: #classic-whats-next}

- Go through the [{{site.data.keyword.containerlong_notm}} tutorial](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial) for installing the CLI or using the Kubernetes Terminal, creating a private registry, setting up your cluster environment, adding a service to your cluster, and deploying a {{site.data.keyword.watson}} app.
- [Create a standard classic cluster](/docs/containers?topic=containers-clusters#clusters_ui) with multiple worker nodes that you can customize to your workload requirements and set up your cluster for high availability.

 
<br />


## Getting started with VPC on Classic clusters
{: #vpc-classic-gs}

Create a Virtual Private Cloud (VPC), provision your standard VPC on Classic cluster, and deploy your first app by using the {{site.data.keyword.cloud_notm}} console.
{:shortdesc}

### Creating a standard VPC on Classic cluster
{: #vpc-classic-cluster-create}

Create a standard VPC on Classic cluster in a [single zone](/docs/containers?topic=containers-ha_clusters#single_zone) by using the {{site.data.keyword.cloud_notm}} console. For more detailed information about your cluster customization options, see [Creating a standard VPC on Classic cluster](/docs/containers?topic=containers-clusters#clusters_vpc_standard).
{: shortdesc}

VPC on Classic clusters can be created as a standard cluster only, and as such incur costs. Be sure to review the order summary at the end of this tutorial to review the costs for your cluster. To keep your costs to a minimum, set up your cluster as a single zone cluster with one worker node only.
{: important}

Before you begin:
- Make sure that you have a [billable Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account](https://cloud.ibm.com/registration/).
- Make sure that you are assigned the following permissions in {{site.data.keyword.cloud_notm}} Identity and Access Management.
  * VPC clusters: [**Administrator** platform role for VPC Infrastructure](/docs/vpc-on-classic?topic=vpc-on-classic-managing-user-permissions-for-vpc-resources).
  * [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}} at the account level.
  * [**Writer** or **Manager** service role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}.
  * [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for Container Registry at the account level.

To create a standard VPC on Classic cluster:

1. [Create a Virtual Private Cloud (VPC) ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/vpc/provision/vpc) with a subnet that is located in the zone where you want to create the cluster. Make sure to attach a public gateway to your subnet so that you can access public endpoints from your cluster. This public gateway is used later on to access container images from DockerHub.
2. From the [{{site.data.keyword.containerlong_notm}} dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/kubernetes/clusters), click **Create cluster**.
3. Configure your cluster environment.
   1. Select **Kubernetes** as your container platform and select the Kubernetes **version 1.15 or later**.
   2. Select **VPC infrastructure**.
   3. From the **Virtual Private Cloud** drop-down menu, select the VPC that you created earlier.
   4. Fill out the cluster name, resouce group, and geography.
   5. For the **Location**, select the zone for which you created a VPC subnet earlier.
4. Select the **2 vCPUs 4GB RAM** worker node flavor.
5. For the number of worker nodes, enter **1**.
6. Review the order summary to verify the estimated costs for your cluster.
7. Click **Create cluster**.

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster!

### Deploying an app to your VPC cluster
{: #vpc-deploy-app}

With your VPC on Classic cluster all set up, deploy your first `nginx` app by using the Kubernetes dashboard. The [Kubernetes dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard) is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage resources that are within your cluster, such as pods, services, and namespaces.
{: shortdesc}

1. From the cluster details page, click **Kubernetes dashboard**.
2. Click **Create**.
3. Select the **Create an app** tab.
4. Configure your `nginx` app.
   1. Enter a name for your app.
   2. Enter **nginx** for your container image.
5. Click **Deploy**.
6. From the **Workloads** > **Deployments** menu, select your `nginx` deployment and review the details for your deployment.

Congratulations! You just deployed your first app in your Kubernetes VPC cluster.

### What's next
{: #vpc-classic-whats-next}

- Go through the [VPC on Classic cluster tutorial](/docs/containers?topic=containers-vpc_ks_tutorial) for installing the CLI, setting up your cluster environment, and deploying an app with a VPC load balancer that exposes your app on the internet.
- Explore other capabilities, such as creating a [multizone VPC on Classic cluster](/docs/containers?topic=containers-ha_clusters#multizone), controlling network access with [VPC access control lists](/docs/containers?topic=containers-vpc-network-policy), and [adding VPC Block Storage](/docs/containers?topic=containers-vpc-block) to your apps.







