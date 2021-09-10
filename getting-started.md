---

copyright:
  years: 2014, 2021
lastupdated: "2021-09-10"

keywords: kubernetes, iks, containers

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}  


<style>
    <!--
        #tutorials { /* hide the page header */
            display: none !important;
        }
        .allCategories {
            display: flex !important;
            flex-direction: row !important;
            flex-wrap: wrap !important;
        }
        .categoryBox {
            flex-grow: 1 !important;
            width: calc(33% - 20px) !important;
            text-decoration: none !important;
            margin: 0 10px 20px 0 !important;
            padding: 16px !important;
            border: 1px #dfe6eb solid !important;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2) !important;
            text-align: center !important;
            text-overflow: ellipsis !important;
            overflow: hidden !important;
        }
        .solutionBoxContainer {}
        .solutionBoxContainer a {
            text-decoration: none !important;
            border: none !important;
        }
        .solutionBox {
            display: inline-block !important;
            width: 100% !important;
            margin: 0 10px 20px 0 !important;
            padding: 16px !important;
            background-color: #f4f4f4 !important;
        }
        @media screen and (min-width: 960px) {
            .solutionBox {
            width: calc(50% - 3%) !important;
            }
            .solutionBox.solutionBoxFeatured {
            width: calc(50% - 3%) !important;
            }
            .solutionBoxContent {
            height: 350px !important;
            }
        }
        @media screen and (min-width: 1298px) {
            .solutionBox {
            width: calc(33% - 2%) !important;
            }
            .solutionBoxContent {
            min-height: 350px !important;
            }
        }
        .solutionBox:hover {
            border: 1px rgb(136, 151, 162)solid !important;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2) !important;
        }
        .solutionBoxContent {
            display: flex !important;
            flex-direction: column !important;
        }
        .solutionBoxTitle {
            margin: 0rem !important;
            margin-bottom: 5px !important;
            font-size: 14px !important;
            font-weight: 900 !important;
            line-height: 16px !important;
            height: 37px !important;
            text-overflow: ellipsis !important;
            overflow: hidden !important;
            display: -webkit-box !important;
            -webkit-line-clamp: 2 !important;
            -webkit-box-orient: vertical !important;
            -webkit-box-align: inherit !important;
        }
        .solutionBoxDescription {
            flex-grow: 1 !important;
            display: flex !important;
            flex-direction: column !important;
        }
        .descriptionContainer {
        }
        .descriptionContainer p {
            margin: 0 !important;
            overflow: hidden !important;
            display: -webkit-box !important;
            -webkit-line-clamp: 4 !important;
            -webkit-box-orient: vertical !important;
            font-size: 14px !important;
            font-weight: 400 !important;
            line-height: 1.5 !important;
            letter-spacing: 0 !important;
            max-height: 70px !important;
        }
        .architectureDiagramContainer {
            flex-grow: 1 !important;
            min-width: calc(33% - 2%) !important;
            padding: 0 16px !important;
            text-align: center !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: center !important;
            background-color: #f4f4f4;
        }
        .architectureDiagram {
            max-height: 175px !important;
            padding: 5px !important;
            margin: 0 auto !important;
        }
    -->
    </style>


# Getting started with {{site.data.keyword.containerlong_notm}}
{: #getting-started}

Deploy highly available containerized apps in Kubernetes clusters and use the powerful tools of {{site.data.keyword.containerlong}} to automate, isolate, secure, manage, and monitor your workloads across zones or regions.
{: shortdesc}

First, create a cluster with a few clicks in the {{site.data.keyword.cloud_notm}} console. Then, deploy your first containerized app to your cluster through the Kubernetes dashboard.

To complete the getting started tutorial, use a [Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account](/docs/account?topic=account-upgrading-account) where you are the owner or have [full Administrator access](/docs/account?topic=account-assign-access-resources).
{: note}

<div class=solutionBoxContainer>
    <div class="solutionBox">
        <a href = "#clusters_gs">
        <div>
        <p><strong><img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Create a classic cluster</p></strong>
        <p class="bx--type-caption">Create a Kubernetes cluster on {{site.data.keyword.cloud_notm}} classic workers nodes, subnets, and VLAN networking. Choose from a variety of virtual, bare metal, GPU, or software-defined storage flavors.</p>
        </div>
    </a>
    </div>
    <div class="solutionBox">
        <a href = "#vpc-gen2-gs">
        <div>
            <p><strong><img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Create a VPC cluster</p></strong>
            <p class="bx--type-caption">Create your cluster in the second generation of compute resources in a Virtual Private Cloud (VPC) that gives you the security of a private cloud with the dynamic scalability of a public cloud.</p>
        </div>
    </a>
    </div>
    <div class="solutionBox">
        <a href = "#deploy-app">
        <div>
            <p><strong><img src="images/icon-containers-bw.svg" alt="Container icon" width="15" style="width:15px; border-style: none"/> Deploy and expose an app</p></strong>
            <p class="bx--type-caption">Deploy a `websphere-liberty` Java application server as a container from a Docker Hub image. Then, expose it with a `LoadBalancer` service to get an IP address for quick testing of your first app.</p>
        </div>
    </a>
    </div>
</div>

## Creating a free classic cluster
{: #clusters_gs}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Set up your free classic cluster with one worker node by using the {{site.data.keyword.cloud_notm}} console. For more information about free clusters, such as expiration and limited capabilities, see the [FAQ](/docs/containers?topic=containers-faqs#faq_free).
{: shortdesc}

1. In the [{{site.data.keyword.cloud_notm}} **Catalog**](https://cloud.ibm.com/catalog?category=containers){: external}, select **Kubernetes Service**. A cluster configuration page opens.
2. From the plan dropdown, select the **Free** cluster option.
3. Give your cluster a unique name, such as `mycluster-free`.
4. Select a resource group to create the cluster in, such as `default`.
3. In the **Summary** pane, review the order summary and then click **Create**. A worker pool is created that contains one worker node in the default resource group.
<br>

The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster by [deploying your first app](#deploy-app)!


## Creating a VPC cluster
{: #vpc-gen2-gs}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Create a standard VPC cluster by using the {{site.data.keyword.cloud_notm}} console. For more detailed information about your cluster customization options, see [Creating a standard VPC cluster](/docs/containers?topic=containers-clusters#clusters_vpcg2).
{: shortdesc}

VPC clusters can be created as standard clusters only, and as such incur costs. Be sure to review the order summary at the end of this tutorial to review the costs for your cluster. To keep your costs to a minimum, set up your cluster as a single zone cluster with one worker node only.
{: important}

1. Create a Virtual Private Cloud (VPC) on generation 2 compute.
    1. Navigate to the [VPC create console](https://cloud.ibm.com/vpc/provision/vpc){: external}.
    3. Give the VPC a name and select a resource group to deploy the VPC into.
    4. Give the VPC subnet a name and select the location where you want to create the cluster.
    5. Attach a public gateway to your subnet so that you can access public endpoints from your cluster. This public gateway is used later on to access container images from Docker Hub.
    6. Click **Create virtual private cloud**.
2. From the [{{site.data.keyword.containerlong_notm}} dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click **Create cluster**.
3. Configure your VPC environment.
    1. Select the **Standard** plan.
    2. Select **Kubernetes** as your container platform and select the Kubernetes **version 1.20.7 or later**.
    3. Select **VPC** infrastructure.
    4. From the **Virtual private cloud** drop-down menu, select the VPC that you created earlier.
4. Configure the **Location** details for your cluster.
    1. Select the **Resource group** that you want to create your cluster in. You cannot change the resource group later.
    2. Select the zones to create your cluster in. The zones are filtered based on the VPC that you selected, and include the subnets that you previously created.
5. Configure your **Worker pool** setup.
    1. If you want a larger size for your worker nodes, click **Change flavor**. Otherwise, leave the default **4 vCPUs / 16 GB** flavor selected.
    2. Set how many worker nodes to create per zone, such as **2**.
6. Review the rest of the cluster details, such as the service endpoint, cluster name, and tags.
7. In the **Summary** pane, review your order summary and then click **Create**.
8. Kubernetes version 1.18 or earlier only: Allow traffic requests to apps that you deploy by modifying the VPC's default security group.
    1. From the [Virtual private cloud dashboard](https://cloud.ibm.com/vpc-ext/network/vpcs){: external}, click the name of the **Default Security Group** for the VPC that you created.
    2. In the **Inbound rules** section, click **New rule**.
    3. Choose the **TCP** protocol, enter `30000` for the **Port min** and `32767` for the **Port max**, and leave the **Any** source type selected.
    4. Click **Save**.
    5. If you require VPC VPN access or classic infrastructure access into this cluster, repeat these steps to add a rule that uses the **UDP** protocol, `30000` for the **Port min**, `32767` for the **Port max**, and the **Any** source type.


The worker node can take a few minutes to provision, but you can see the progress in the **Worker nodes** tab. When the status reaches `Ready`, you can start working with your cluster by [deploying your first app](#deploy-app)!



## Deploying an app to your cluster
{: #deploy-app}

After you create a [classic](#clusters_gs) or a [VPC](#vpc-gen2-gs) cluster with a public gateway, deploy your first app. You can use a sample `websphere-liberty` Java application server that IBM provides and deploy the app to your cluster by using the Kubernetes dashboard.
{: shortdesc}

The [Kubernetes dashboard](https://github.com/kubernetes/dashboard){: external} is a web console component that is provided by the open source community and installed in your cluster by default. Use the Kubernetes dashboard to manage Kubernetes resources that are within your cluster, such as pods, services, and namespaces. Not sure what all these Kubernetes resources mean? Check out the overview for [container](/docs/containers?topic=containers-iks-overview#docker_containers) and [Kubernetes](/docs/containers?topic=containers-iks-overview#kubernetes_basics) concepts.

The steps to deploy an app vary if you have a free or standard cluster, because free clusters do not support load balancers.

| Steps |
| ----- |
| <ol><li>Select your cluster from the <a href="https://cloud.ibm.com/kubernetes/clusters">cluster list</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> to open the details for your cluster.</li><li>Click <strong>Kubernetes dashboard</strong>.</li><li>From the menu bar, click the <strong>Create new resource</strong> icon (<code>+</code>).</li><li>Select the <strong>Create from form</strong> tab.<ol><li>Enter a name for your app, such as <code>liberty</code>.</li><li>Enter <code>websphere-liberty</code> for your container image.</li><li>Enter the number of pods for your app deployment, such as <code>1</code>.</li><li>Leave the <strong>Service</strong> drop-down menu set to <strong>None</strong>.</li></ol></li><li>Click <strong>Deploy</strong>. During the deployment, the cluster downloads the <code>websphere-liberty</code> container image from Docker Hub and deploys the app in your cluster.</li><li>Create a node port so that your app can be accessed by other users internally or externally. Because your cluster is a free cluster, you can only expose an app with a node port, not a load balancer or Ingress.<ol><li>Click the <strong>Create new resource</strong> icon (<code>+</code>).</li><li>Copy the <a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/gs-nodeport.yaml">node port YAML from GitHub</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li><li>In the <strong>Create from input</strong> box, paste the node port YAML that you copied in the previous step.</li><li>Click <strong>Upload</strong>. The node port service is created.</li></ol><li>From the menu, click <strong>Discovery and Load Balancing > Services</strong>, and note the TCP endpoint port of your <code>liberty</code> service in the node port range <code>30000 - 32767</code>, such as <code>liberty:32323 TCP</code>.</li><li>From the menu, click <strong>Workloads > Pods</strong>, and note the <strong>Node</strong> that your pod runs on, such as <code>10.xxx.xx.xxx</code>.</li><li>Return to the <a href="https://cloud.ibm.com/kubernetes/clusters">{{site.data.keyword.cloud_notm}} clusters console</a>, select your cluster, and click the <strong>Worker Nodes</strong> tab. Find the <strong>Public IP</strong> of the worker node that matches the private IP of the node that the pod runs on.</li><li>In a tab in your browser, form the URL of your app by combining <code>http://</code> with the public IP and TCP port that you previously retrieved. For example, <code>http://169.xx.xxx.xxx:32323</code>. The <strong>Welcome to Liberty</strong> page is displayed.</li></ol> |
{: summary="The rows contains the steps to deploy an app and expose it with a node port."}
{: class="simple-tab-table"}
{: caption="Deploying an app to a free cluster and exposing with a node port" caption-side="top"}
{: #deployapp1}
{: tab-title="Free cluster"}
{: tab-group="deployapp"}

| Steps |
| ----- |
| <ol><li>Select your cluster from the <a href="https://cloud.ibm.com/kubernetes/clusters">cluster list</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> to open the details for your cluster.</li><li>Click <strong>Kubernetes dashboard</strong>.</li><li>From the menu bar, click the <strong>Create new resource</strong> icon (<code>+</code>).</li><li>Select the <strong>Create from form</strong> tab.<ol><li>Enter a name for your app, such as <code>liberty</code>.</li><li>Enter <code>websphere-liberty</code> for your container image. Remember that your cluster's VPC subnet must have a public gateway so that the cluster can pull an image from DockerHub.</li><li>Enter the number of pods for your app deployment, such as <code>1</code>.</li><li>From the <strong>Service</strong> drop-down menu, select <strong>External</strong> to create a <code>LoadBalancer</code> service that external users can use to access the app. Configure the external service as follows.<ul><li><strong>Port</strong>: <code>80</code></li><li><strong>Target port</strong>: <code>9080</code></li><li><strong>Protocol</strong>: <code>TCP</code></li></ul></li></ol></li><li>Click <strong>Deploy</strong>. During the deployment, the cluster downloads the <code>websphere-liberty</code> container image from Docker Hub and deploys the app in your cluster. Your app is exposed by a Layer 4, version 1.0 network load balancer (NLB) so that it can be accessed by other users internally or externally. For other ways to expose an app such as Ingress, see <a href="/docs/containers?topic=containers-cs_network_planning">Planning in-cluster and external networking for apps</a>.</li><li>From the <strong>Workloads</strong> > <strong>Pods</strong> menu, click your <code>liberty</code> pod and check that its status is <strong>Running</strong>.</li><li>From the <strong>Discovery and Load Balancing > Services</strong> menu, click the <strong>External Endpoint</strong> of your <code>liberty</code> service. For example, <code>169.xx.xxx.xxx:80</code> for classic clusters or <code>http://&lt;hash&gt;-&lt;region&gt;.lb.appdomain.cloud/</code> for VPC clusters. The <strong>Welcome to Liberty</strong> page is displayed.</li></ol> |
{: summary="The rows contains the steps to deploy an app and expose it with a load balancer."}
{: class="simple-tab-table"}
{: caption="Deploying an app to a standard cluster and exposing with a load balancer" caption-side="top"}
{: #deployapp2}
{: tab-title="Standard cluster"}
{: tab-group="deployapp"}


Great job! You just deployed your first app in your Kubernetes cluster.



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
* Check out [{{site.data.keyword.cloud_notm}} and 3rd-party services](/docs/containers?topic=containers-supported_integrations), such as Portworx.
* Enhance your app lifecycle with [managed add-ons](/docs/containers?topic=containers-managed-addons) like Istio.

Looking for an overview of all your options in {{site.data.keyword.containerlong_notm}}? Check out the curated [learning path for administrators](/docs/containers?topic=containers-learning-path-admin) or [learning path for developers](/docs/containers?topic=containers-learning-path-dev).
{: tip}


