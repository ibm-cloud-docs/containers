---

copyright:
  years: 2014, 2020
lastupdated: "2020-05-12"

keywords: kubernetes, iks, containers

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


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
        width: 600px !important;
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

First, create a cluster with a few clicks in the {{site.data.keyword.cloud_notm}} console. Then, deploy your first containerized app to your cluster through the Kubernetes dashboard.

To complete the getting started tutorial, use a [Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account](/docs/account?topic=account-upgrading-account) where you are the owner or have [full Administrator access](/docs/iam?topic=iam-iammanidaccser).
{: note}

<div class=solutionBoxContainer>
  <div class="solutionBox">
    <a href = "#clusters_gs">
      <div>
        <h2><img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Create a classic cluster</h2>
        <p class="bx--type-caption">Create a Kubernetes cluster on {{site.data.keyword.cloud_notm}} classic workers nodes, subnets, and VLAN networking. Choose from a variety of virtual, bare metal, GPU, or software-defined storage flavors.</p>
      </div>
    </a>
  </div>
  <div class="solutionBox">
    <a href = "#vpc-classic-gs">
      <div>
         <h2><img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Create a VPC cluster</h2>
         <p class="bx--type-caption">Create your cluster in the first generation of virtual machine compute resources in a Virtual Private Cloud (VPC) that gives you the security of a private cloud with the dynamic scalability of a public cloud.</p>
      </div>
    </a>
  </div>
  <div class="solutionBox">
    <a href = "#deploy-app">
      <div>
         <h2><img src="images/icon-containers-bw.svg" alt="Container icon" width="15" style="width:15px; border-style: none"/> Deploy and expose an app</h2>
         <p class="bx--type-caption">Deploy a `websphere-liberty` Java application server as a container from a Docker Hub image. Then, expose it with a `LoadBalancer` service to get an IP address for quick testing of your first app.</p>
      </div>
    </a>
  </div>
</div>

## Creating a free classic cluster
{: #clusters_gs}

Set up your free classic cluster with one worker node by using the {{site.data.keyword.cloud_notm}} console. For more information about free clusters, such as expiration and limited capabilities, see the [FAQ](/docs/containers?topic=containers-faqs#faq_free).
{: shortdesc}

1.  In the [{{site.data.keyword.cloud_notm}} **Catalog**](https://cloud.ibm.com/catalog?category=containers){: external}, select **Kubernetes Service** and click **Create**. A cluster configuration page opens.
2.  Select the **Free** cluster option, and give your cluster a unique name.
3.  Click **Create Cluster**. A worker pool is created that contains one worker node.   

<br>

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster by [deploying your first app](#deploy-app)!

<br />


## Creating a VPC Gen 1 compute cluster
{: #vpc-classic-gs}

Create a standard VPC Generation 1 compute cluster by using the {{site.data.keyword.cloud_notm}} console. For more detailed information about your cluster customization options, see [Creating a standard VPC Gen 1 compute cluster](/docs/containers?topic=containers-clusters#clusters_vpc_standard).
{: shortdesc}

VPC clusters can be created as standard clusters only, and as such incur costs. Be sure to review the order summary at the end of this tutorial to review the costs for your cluster. To keep your costs to a minimum, set up your cluster as a single zone cluster with one worker node only.
{: important}

1. [Create a Virtual Private Cloud (VPC) on generation 1 compute](https://cloud.ibm.com/vpc/provision/vpc){: external} with a subnet that is located in the zone where you want to create the cluster. Make sure to attach a public gateway to your subnet so that you can access public endpoints from your cluster. This public gateway is used later on to access container images from Docker Hub.<p class="tip">Make sure that the banner at the beginning of the new VPC page is set to **Gen 1 compute**. If **Gen 2 compute** is set, click **Switch to Gen 1 compute**.</p>
2. From the [{{site.data.keyword.containerlong_notm}} dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click **Create cluster**.
3. Configure your cluster environment.
   1. Select **Kubernetes** as your container platform and select the Kubernetes **version 1.16.9 or later**.
   2. Select **VPC infrastructure**.
   3. From the **Virtual Private Cloud** drop-down menu, select the VPC that you created earlier.
   4. Fill out the cluster name and resource group.
   5. For the **Location**, select the zone for which you created a VPC subnet earlier.
4. Select the **2 vCPUs 4GB RAM** worker node flavor.
5. For the number of worker nodes, enter **1**.
6. Review the order summary to verify the estimated costs for your cluster.
7. Click **Create cluster**.

<br>

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster by [deploying your first app](#deploy-app)!

<br />


## Deploying an app to your cluster
{: #deploy-app}

After you create a [classic](#clusters_gs) or [VPC](#vpc-classic-gs) cluster, deploy your first app. You can use a sample `websphere-liberty` Java application server that IBM provides and deploy the app to your cluster by using the Kubernetes dashboard. The [Kubernetes dashboard](https://github.com/kubernetes/dashboard){: external} is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage resources that are within your cluster, such as pods, services, and namespaces.
{: shortdesc}

The steps to deploy an app vary if you have a free or standard cluster, because free clusters do not support load balancers.

| Steps |
| ----- |
| <ol><li>Select your cluster from the [cluster list](https://cloud.ibm.com/kubernetes/clusters){: external} to open the details for your cluster.</li><li>Click **Kubernetes dashboard**.</li><li>From the menu bar, click the **Create new resource** icon (`+`).</li><li>Select the **Create from form** tab.<ol><li>Enter a name for your app, such as `liberty`.</li><li>Enter `websphere-liberty` for your container image.</li><li>Enter the number of pods for your app deployment, such as `1`.</li><li>Leave the **Service** drop-down menu set to **None**.</li></ol></li><li>Click **Deploy**. During the deployment, the cluster downloads the `websphere-liberty` container image from Docker Hub and deploys the app in your cluster.</li><li>Create a node port so that your app can be access by other users internally or externally. Because your cluster is a free cluster, you can only expose an app with a node port, not a load balancer or Ingress.<ol><li>Click the **Create new resource** icon (`+`).</li><li>Copy the [node port YAML from GitHub](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/gs-nodeport.yaml){: external}.</li><li>In the **Create from input** box, paste the node port YAML that you copied in the previous step.</li><li>Click **Upload**. The node port service is created.</li></ol><li>From the menu, click **Discovery and Load Balancing > Services**, and note the TCP endpoint port of your `liberty` service in the node port range `30000 - 32767`, such as `liberty:32323 TCP`.</li><li>From the menu, click **Workloads > Pods**, and note the **Node** that your pod runs on, such as `10.xxx.xx.xxx`.</li><li>Return to the [{{site.data.keyword.cloud_notm}} clusters console](https://cloud.ibm.com/kubernetes/clusters), select your cluster, and click the **Worker Nodes** tab. Find the **Public IP** of the worker node that matches the private IP of the node that the pod runs on.</li><li>In a tab in your browser, form the URL of your app by combining `http://` with the public IP and TCP port that you previously retrieved. For example, `http://169.xx.xxx.xxx:32323`. The **Welcome to Liberty** page is displayed.</li></ol> |
{: summary="The rows contains the steps to deploy an app and expose it with a node port."}
{: class="simple-tab-table"}
{: caption="Deploying an app to a free cluster and exposing with a node port" caption-side="top"}
{: #deployapp1}
{: tab-title="Free cluster"}
{: tab-group="deployapp"}

| Steps |
| ----- |
| <ol><li>Select your cluster from the [cluster list](https://cloud.ibm.com/kubernetes/clusters){: external} to open the details for your cluster.</li><li>Click **Kubernetes dashboard**.</li><li>From the menu bar, click the **Create new resource** icon (`+`).</li><li>Select the **Create from form** tab.<ol><li>Enter a name for your app, such as `liberty`.</li><li>Enter `websphere-liberty` for your container image.</li><li>Enter the number of pods for your app deployment, such as `1`.</li><li>From the **Service** drop-down menu, select **External** to create a `LoadBalancer` service that external users can use to access the app. Configure the external service as follows.<ul><li>**Port**: `80`</li><li>**Target port**: `9080`</li><li>**Protocol**: `TCP`</li></ul></li></ol></li><li>Click **Deploy**. During the deployment, the cluster downloads the `websphere-liberty` container image from Docker Hub and deploys the app in your cluster. Your app is exposed by a Layer 4, version 1.0 network load balancer (NLB) so that it can be accessed by other users internally or externally. For other ways to expose an app such as Ingress, see [Planning in-cluster and external networking for apps](/docs/containers?topic=containers-cs_network_planning).</li><li>From the **Workloads** > **Pods** menu, click your `liberty` pod and check that its status is **Running**.</li><li>From the **Discovery and Load Balancing > Services** menu, click the **External Endpoint** of your `liberty` service. For example, `169.xx.xxx.xxx:80` for classic clusters or `http://<hash>-<region>.lb.appdomain.cloud/` for VPC clusters. The **Welcome to Liberty** page is displayed.</li></ol> |
{: summary="The rows contains the steps to deploy an app and expose it with a load balancer."}
{: class="simple-tab-table"}
{: caption="Deploying an app to a standard cluster and exposing with a load balancer" caption-side="top"}
{: #deployapp2}
{: tab-title="Standard cluster"}
{: tab-group="deployapp"}

<br>
Great job! You just deployed your first app in your Kubernetes cluster.

<br />



## What's next?
{: #whats-next}

Go through a tutorial to install the CLI, create a private image registry, set up your cluster environment, add an {{site.data.keyword.cloud_notm}} service to the cluster, and deploy an app.
* [Classic clusters tutorial](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial).
* [VPC clusters tutorial](/docs/containers?topic=containers-vpc_ks_tutorial)

Set up the right environment for your workloads.
* Plan your [cluster network setup](/docs/containers?topic=containers-plan_clusters), develop a [highly available architecture](/docs/containers?topic=containers-ha_clusters), and [set up autoscaling](/docs/containers?topic=containers-ca) for your cluster.
* Create [image pull secrets](/docs/containers?topic=containers-registry#other) to [deploy apps](/docs/containers?topic=containers-app) to Kubernetes namespaces other than `default`.
* Decide what type of [file, block, object, database, or software-defined storage](/docs/containers?topic=containers-storage_planning) you want to integrate with your apps.
* Control network traffic to your apps for [classic](/docs/containers?topic=containers-network_policies) and [VPC](/docs/containers?topic=containers-vpc-network-policy) clusters.

Explore other capabilities for your cluster.
* Check out [{{site.data.keyword.cloud_notm}} and 3rd-party services](/docs/containers?topic=containers-supported_integrations), such as LogDNA and Sysdig to monitor your cluster's health.
* Enhance your app lifecycle with [managed add-ons](/docs/containers?topic=containers-managed-addons) like Istio and Knative.

Looking for an overview of all your options in {{site.data.keyword.containerlong_notm}}? Check out the curated [learning path for administrators](/docs/containers?topic=containers-learning-path-admin) or [learning path for developers](/docs/containers?topic=containers-learning-path-dev).
{: tip}
