---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-14"

keywords: kubernetes, iks

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

# Tutorial overview
{: #tutorials-ov}

<style>

</style>

## Create a cluster and deploy your first app
{: #tutorials-create-cluster-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cs_cluster_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Kubernetes-native cluster on Ubuntu
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Create a Kubernetes cluster on managed {{site.data.keyword.containerlong_notm}} with Classic infrastructure worker nodes that run an Ubuntu operating system. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_org_ov_public_se.png" alt="Architecture diagram for the solution Create a Kubernetes cluster" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/containers?topic=containers-openshift_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Red Hat OpenShift cluster
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Create an {{site.data.keyword.containerlong_notm}} cluster with worker nodes that come installed with the OpenShift container orchestration platform software. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_org_ov_both_ses_rhos.png" alt="Architecture RHOS" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>

## Set up high availability and network security
{: #tutorials-ov-ha-network-security}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-multi-region-k8s-cis#multi-region-k8s-cis">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Resilient and secure multi-region clusters with Cloud Internet Services
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Integrate Cloud Internet Services with Kubernetes clusters to deliver a resilient and secure solution across multiple {{site.data.keyword.cloud_notm}} regions. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution32-multi-region-k8s-cis/Architecture.png" alt="Architecture diagram for using Cloud Internet Service with {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-policy_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Block unwanted network traffic with Calico policies
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Learn how to use Calico policies to whitelist or blacklist network traffic from and to certain IP addresses. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_tutorial_policies_L4.png" alt="Block incoming network traffic with Calico network policies" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Secure, manage, and monitor a network of microservices with Istio
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Explore the intelligent routing and monitoring capability of Istio to control and secure your microservices in the cloud. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/istio_ov.png" alt="Overview of Istio components and dependencies" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Automate app and cluster deployments
{: #tutorials-ov-app-cluster-deployments}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Deploy serverless apps with Knative services
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Create modern, source-centric containerized and serverless apps on top of your Kubernetes cluster. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/knative_ov.png" alt="Overview of Knative components and dependencies" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Continuous deployment to Kubernetes clusters
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Set up a DevOps pipeline for containerized apps that run in Kubernetes and add integrations such as security scanner, Slack notifications, and analytics.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution21/Architecture.png" alt="Architecture diagram for setting up a continuous delivery and continuous integration pipeline" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/razee-io/Razee">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Automate multi-cluster deployments with Razee 
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Automate, manage, and visualize the deployment of Kubernetes resources across clusters, environments, and cloud providers with Razee.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/razee_ov_no_txt.png" alt="Razee deployment automation architecture" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>

## Migrate apps to the cloud 
{: #tutorials-ov-migrate-apps}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cf_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Containerize a Cloud Foundry app
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Learn how to create a Docker image from a Python Cloud Foundry app, push this image to {{site.data.keyword.registryshort_notm}}, and deploy your app to a Kubernetes cluster.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/python_flask.png" alt="Python hello world welcome screen" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/tutorials?topic=solution-tutorials-vm-to-containers-and-kubernetes#move-a-vm-based-application-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Migrate a VM-based app
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Prepare your app code, containerize your VM-based app, and deploy this app to a Kubernetes cluster.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution30/modern_architecture.png" alt="VM-based app migration to Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>

