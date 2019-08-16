---

copyright:
  years: 2014, 2019
lastupdated: "2019-08-16"

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
        margin-top: 20px; 
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
        margin: 0 10px 20px 0 !important;
        padding: 10px !important;
        border: 1px #dfe6eb solid !important;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2) !important;
    }
    @media screen and (min-width: 960px) {
        .solutionBox {
        width: 27% !important;
        }
        .solutionBoxContent {
        height: 320px !important;
        }
    }
    @media screen and (min-width: 1298px) {
        .solutionBox {
        width: calc(33% - 2%) !important;
        }
        .solutionBoxContent {
        min-height: 320px !important;
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
    .descriptionContainer {
    }
    .descriptionContainer p {
        margin: 2px !important;
        overflow: hidden !important;
        display: -webkit-box !important;
        -webkit-line-clamp: 4 !important;
        -webkit-box-orient: vertical !important;
        font-size: 12px !important;
        font-weight: 400 !important;
        line-height: 1.5 !important;
        letter-spacing: 0 !important;
        max-height: 70px !important;
    }
    .architectureDiagramContainer {
        flex-grow: 1 !important;
        min-width: 200px !important;
        padding: 0 10px !important;
        text-align: center !important;
        display: flex !important;
        flex-direction: column !important;
        justify-content: center !important;
    }
-->
</style>

# Getting started with {{site.data.keyword.containerlong_notm}}
{: #getting-started}

Deploy highly available containerized apps in Kubernetes clusters and use the powerful tools of {{site.data.keyword.containerlong}} to automate, isolate, secure, manage, and monitor your workloads across zones or regions. 
{: shortdesc}



## Overview
{: #gs-overview}

Learn more about {{site.data.keyword.containerlong}}, its capabilities and the options that are available to you to customize the cluster to your needs. 
{: shortdesc}

**What is {{site.data.keyword.containerlong}} and how does it work?** </br>
{{site.data.keyword.containerlong}} is a managed Kubernetes offering to create your own Kubernetes cluster of compute hosts to deploy and manage containerized apps on {{site.data.keyword.cloud_notm}}. As a certified Kubernetes provider, {{site.data.keyword.containerlong}} provides intelligent scheduling, self-healing, horizontal scaling, service discovery and load balancing, automated rollouts and rollbacks, and secret and configuration management for your apps. Combined with an intuitive user experience, built-in security and isolation, and advanced tools to secure, manage, and monitor your cluster workloads, you can rapidly deliver highly available and secure containerized apps in the public cloud. 

**What is Kubernetes?** </br>
Kubernetes is an open source platform for managing containerized workloads and services across multiple hosts, and offers management tools for deploying, automating, monitoring, and scaling containerized apps with minimal to no manual intervention. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational). 

**What container platform can I choose from?** </br>
With {{site.data.keyword.containerlong}}, you can select from two container management platforms: the IBM version of community Kubernetes and {{site.data.keyword.openshiftlong}}. In community Kubernetes clusters, you get access to community Kubernetes API features that are considered beta or higher by the community. Your worker nodes are set up with an Ubuntu operating system and you can use native Kubernetes commands or API to work with your cluster and the cluster resources.   {{site.data.keyword.openshiftlong}} is a Kubernetes-based platform that is designed especially to accelerate your containerized app delivery processes that run on a Red Hat Enterprise Linux 7 operating system. For more information, see [Comparison between OpenShift and community Kubernetes clusters](/docs/openshift?topic=openshift-why_openshift#openshift_kubernetes).

In this getting started tutorial, you create a community Kubernetes cluster. If you want to create an OpenShift instead, see [Getting started with {{site.data.keyword.openshiftlong}}](/docs/openshift?topic=openshift-getting-started). 

**What compute host infrastructure does the service offer?** </br>
With {{site.data.keyword.containerlong}}, you can create your cluster of compute hosts on classic {{site.data.keyword.cloud_notm}} infrastructure.

Classic clusters are created on virtual or bare metal worker nodes that are connected to VLANs. In a classic cluster, you can choose from a variety of virtual and bare metal worker nodes. If you require additional local disks, you can also choose one of the bare metal flavors that are designed for software-defined storage solutions, such as Portworx. Depending on the level of hardware isolation that you need, virtual worker nodes can be set up as shared or dedicated nodes, whereas bare metal machines are always set up as dedicated nodes. 



**Where can I learn more about the service?** </br>
Review the following links to find out more about the benefits and responsibilities when you use {{site.data.keyword.containerlong}}. 

- [Benefits of using {{site.data.keyword.containerlong}}](/docs/containers?topic=containers-cs_ov)
- [Comparison of free and standard clusters](/docs/containers?topic=containers-cs_ov#cluster_types)
- [{{site.data.keyword.containerlong}} service architecture](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture)
- [Use cases](/docs/containers?topic=containers-cs_uc_intro)
- [Your responsibilities by using {{site.data.keyword.containerlong}}](/docs/containers?topic=containers-responsibilities_iks)
- [Defining your Kubernetes strategy](/docs/containers?topic=containers-strategy)


## Getting started with classic clusters
{: #clusters_gs}

Create a free classic cluster with one worker node and deploy your first app to {{site.data.keyword.cloud_notm}}. 
{:shortdesc}

### Creating a free classic cluster
{: #classic-cluster-create}

Set up your free classic cluster with one worker node by using the {{site.data.keyword.cloud_notm}} console. 
{: shortdesc}

Before you begin, get the [{{site.data.keyword.cloud_notm}} account](https://cloud.ibm.com/registration) type that is right for you:
* **Billable (Pay-As-You-Go or Subscription)**: You can create a free cluster. You can also provision IBM Cloud infrastructure resources to create and use in standard clusters.
* **Lite**: You cannot create a free or standard cluster. [Upgrade your account](/docs/account?topic=account-accountfaqs#changeacct) to a billable account.

To create a free classic cluster:

1.  In the [{{site.data.keyword.cloud_notm}} **Catalog** ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/catalog?category=containers), select **Kubernetes Cluster** and click **Create**. A cluster configuration page opens. By default, **Free cluster** is selected.

2.  Give your cluster a unique name.

3.  Click **Create Cluster**. A worker pool is created that contains one worker node.   

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster!

### Deploying an app to your classic cluster
{: #classic-deploy-app}

Deploy your first `nginx` app in your classic cluster by using the Kubernetes dashboard. The Kubernetes dashboard is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage resources that are within your cluster, such as pods, services, and namespaces. 
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
- [Create a standard classic cluster](/docs/containers?topic=containers-clusters#clusters_ui) with multiple nodes that you can customize to your workload requirements and set up your cluster for high availability.







