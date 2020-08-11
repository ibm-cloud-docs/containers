---

copyright:
  years: 2014, 2020
lastupdated: "2020-08-11"

keywords: kubernetes, iks

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: #java .ph data-hd-programlang='java'}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: #swift .ph data-hd-programlang='swift'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vb.net: .ph data-hd-programlang='vb.net'}
{:video: .video}



# Tutorial overview
{: #tutorials-ov}



## Create a cluster and deploy your first app
{: #tutorials-create-cluster-deploy-app}

<div class = "solutionBoxContainer">
  <div class = "solutionBox">
    <a href = "/docs/containers?topic=containers-cs_cluster_tutorial">
      <div class="solutionBoxContent">
      <div class="solutionBoxTitle">
        <p><strong>Community Kubernetes cluster</strong></p></div>
        <div class="solutionBoxDescription">
            <p>Create a Kubernetes cluster on managed {{site.data.keyword.containerlong_notm}} with Classic infrastructure worker nodes that run an Ubuntu operating system.</p>
            <div class="architectureDiagramContainer">
                <img class="architectureDiagram" src="images/tutorial_ov.png" alt="Architecture diagram for the solution Create a Kubernetes cluster" />
            </div>
        </div>
        </div>
    </a>
  </div>
    <div class = "solutionBox">
        <a href = "/docs/containers?topic=containers-vpc_ks_tutorial">
        <div class="solutionBoxContent">
        <div class = "solutionBoxTitle">
          <p><strong>Virtual Private Cloud cluster</strong></p></div>
            <div class="solutionBoxDescription">
                <p>Create a classic cluster in your Virtual Private Cloud (VPC).</p>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/cs_org_ov_vpc.png" alt="VPC cluster tutorial diagram" />
                </div>
            </div>
        </div>
        </a>
    </div>
    <div class = "solutionBox">
        <a href = "/docs/openshift?topic=openshift-openshift_tutorial">
        <div class="solutionBoxContent">
        <div class = "solutionBoxTitle">
          <p><strong>OpenShift cluster</strong></p></div>
            <div class="solutionBoxDescription">
                <p>Create an {{site.data.keyword.containerlong_notm}} cluster with worker nodes that come installed with the OpenShift container orchestration platform software.</p>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/roks_tutorial2.png" alt="OpenShift tutorial flow diagram" />
                </div>
            </div>
        </div>
        </a>
    </div>
</div>

## Deploy apps to a cluster
{: #tutorials-deploy-app}

<div class = "solutionBoxContainer">
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-scalable-webapp-kubernetes">
        <div class = "solutionBoxContent">
        <p><strong>Scalable web application on Kubernetes</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Scaffold a web app, deploy it to a cluster, and learn how to scale your app and monitor its health. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/ibm-cloud-docs/tutorials/master/images/solution2/Architecture.png" alt="Architecture diagram for deploying web apps with {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "https://github.com/IBM-Cloud/logistics-wizard-kubernetes">
        <div class = "solutionBoxContent">
               <p><strong>Run Kubernetes and Cloud Foundry apps</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Create a Logistics Wizard where the ERP and Controller services are in Kubernetes and the web UI in a Cloud Foundry app. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Cloud/logistics-wizard-kubernetes/master/lw_kube_architecture.png" alt="Logistics Wizard architecture overview" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-pub-sub-object-storage#pub-sub-object-storage">
        <div class = "solutionBoxContent">
               <p><strong>Asynchronous data processing for apps</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Use an Apache Kafka-based messaging service to orchestrate long running workloads in Kubernetes apps.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/ibm-cloud-docs/solution-tutorials/master/images/solution25/Architecture.png" alt="Asynchronous data processing architecture" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
        <a href = "/docs/containers?topic=containers-tutorial-starterkit-kube">
        <div class = "solutionBoxContent">
                <p><strong>Deploy a starter kit app to a cluster</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Create a containerized app from an {{site.data.keyword.cloud_notm}} starter kit and deploy your app by using a DevOps toolchain. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/starterkit-app.png" alt="Starter kit app flow" />
                </div>
            </div>
        </div>
    </a>
    </div>
</div>


## Set up high availability and security
{: #tutorials-ov-ha-network-security}

<div class = "solutionBoxContainer">
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-multi-region-k8s-cis#multi-region-k8s-cis">
        <div class = "solutionBoxContent">
                <p><strong>Resilient and secure multi-region clusters with Cloud Internet Services</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Integrate Cloud Internet Services with Kubernetes clusters to deliver a resilient and secure solution across multiple {{site.data.keyword.cloud_notm}} regions. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution32-multi-region-k8s-cis/Architecture.png" alt="Architecture diagram for using Cloud Internet Service with {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-strategies-for-resilient-applications">
        <div class = "solutionBoxContent">
                <p><strong>Strategies for resilient applications in the cloud</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Learn what to consider when creating resilient apps in the cloud and what {{site.data.keyword.cloud_notm}} services you can use. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution39/Architecture.png" alt="Architecture diagram for creating resilient applications" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/containers?topic=containers-policy_tutorial">
        <div class = "solutionBoxContent">
                <p><strong>Block unwanted network traffic with Calico policies</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Learn how to use Calico policies to allow network traffic from and to certain IP addresses. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/cs_tutorial_policies_L4.png" alt="Block incoming network traffic with Calico network policies" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
        <a href = "/docs/containers?topic=containers-istio">
        <div class = "solutionBoxContent">
                <p><strong>Secure, manage, and monitor a network of microservices with Istio</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Use Istio for intelligent routing and monitoring of your microservices in the cloud. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/istio_ov.png" alt="Overview of Istio components and dependencies" /></br>
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-cloud-e2e-security#cloud-e2e-security">
        <div class = "solutionBoxContent">
                <p><strong>Apply end to end security to an {{site.data.keyword.cloud_notm}} app</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Learn how to use authentication and encryption to protect your app, and how to monitor and audit cluster activities. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://github.com/IBM-Bluemix-Docs/tutorials/blob/master/images/solution34-cloud-e2e-security/Architecture.png?raw=true" alt="Architecture diagram for applying end-to-end security to a cloud app" /></br>
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-users-teams-applications#users-teams-applications">
        <div class = "solutionBoxContent">
                <p><strong>Organize users and teams with {{site.data.keyword.cloud_notm}} Identity and Access Management</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Set up cluster access for users and teams and learn how to replicate this setup across environments. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution20-users-teams-applications/architecture.png" alt="Architecture diagram for organizing users and teams" /></br>
                </div>
            </div>
        </div>
    </a>
    </div>
</div>



## Automate app and cluster deployments
{: #tutorials-ov-app-cluster-deployments}

<div class = "solutionBoxContainer">
    <div class = "solutionBox">
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
        <div class = "solutionBoxContent">
                <p><strong>Deploy serverless apps with Knative services</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Create modern, source-centric, containerized, and serverless apps on top of your Kubernetes cluster. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/knative_ov.png" alt="Overview of Knative components and dependencies" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes">
        <div class = "solutionBoxContent">
                <p><strong>Continuous deployment to Kubernetes clusters</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                   <p>Set up a DevOps pipeline for Kubernetes apps and integrate with security scanner, Slack notifications, and analytics.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution21/Architecture.png" alt="Architecture diagram for setting up a continuous delivery and continuous integration pipeline" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/containers?topic=containers-tutorial-byoc-kube">
        <div class = "solutionBoxContent">
                <p><strong>Set up a DevOps delivery pipeline for your GitHub app</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Configure pipelines to build an image from a Dockerfile, push it to a container registry, and deploy the app to a cluster.
             </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/byoc.png" alt="Continuous delivery pipeline stages in a DevOps toolchain" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "https://github.com/razee-io/Razee">
        <div class = "solutionBoxContent">
                <p><strong>Automate multi-cluster deployments with Razee</strong></p>
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Automate, deploy, manage, and visualize Kubernetes resources across clusters, environments, and cloud providers with Razee.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/razee_ov_no_txt.png" alt="Razee deployment automation architecture" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-plan-create-update-deployments">
        <div class = "solutionBoxContent">
                <p><strong>Automate cluster deployments across environments with Terraform</strong></p>
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Plan, create, and update Kubernetes resources across multiple deployment environments with Terraform.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/terraform_tutorial_ov.png" alt="Terraform deployment automation architecture" />
                </div>
            </div>
        </div>
    </a>
    </div>
</div>


## Monitor and log cluster activity
{: #tutorials-ov-monitor-log}

<div class = "solutionBoxContainer">
    <div class = "solutionBox">
    <a href = "/docs/Log-Analysis-with-LogDNA?topic=Log-Analysis-with-LogDNA-kube#kube">
        <div class = "solutionBoxContent">
                <p><strong>Manage Kubernetes cluster logs with {{site.data.keyword.la_full_notm}}</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Configure a logging agent in your cluster and monitor different log sources with  {{site.data.keyword.la_full_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Bluemix-Docs/Log-Analysis-with-LogDNA/master/images/kube.png" alt="LogDNA architecture overview" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/Monitoring-with-Sysdig?topic=Monitoring-with-Sysdig-kubernetes_cluster#kubernetes_cluster">
        <div class = "solutionBoxContent">
                <p><strong>Analyze cluster metrics with {{site.data.keyword.mon_full_notm}}</strong></p>
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Set up a Sysdig metrics agent in your cluster and explore how you can monitor your cluster's health.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Bluemix-Docs/Monitoring-with-Sysdig/master/images/kube.png" alt="Sysdig architecture overview" />
                </div>
            </div>
        </div>
    </a>
    </div>
</div>


## Migrate apps to the cloud
{: #tutorials-ov-migrate-apps}

<div class = "solutionBoxContainer">
    <div class = "solutionBox">
    <a href = "/docs/containers?topic=containers-cf_tutorial">
        <div class = "solutionBoxContent">
                <p><strong>Containerize a Cloud Foundry app</strong></p>
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  <p>Create a Docker image from a Python Cloud Foundry app, push the image to a container registry, and deploy your app to a Kubernetes cluster.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="images/python_flask.png" alt="Python hello world welcome screen" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "/docs/solution-tutorials?topic=solution-tutorials-vm-to-containers-and-kubernetes">
        <div class = "solutionBoxContent">
                <p><strong>Migrate a VM-based app</strong></p>
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Prepare your app code, containerize your VM-based app, and deploy this app to a Kubernetes cluster.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution30/modern_architecture.png" alt="VM-based app migration to Kubernetes" />
                </div>
            </div>
        </div>
    </a>
    </div>
    <div class = "solutionBox">
    <a href = "https://github.com/IBM-Cloud/jpetstore-kubernetes">
        <div class = "solutionBoxContent">
                <p><strong>Modernize a Java web app</strong></p>
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Containerize the JPetStore app and extend it with Watson Visual Recognition and Twilio text messaging.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src="https://raw.githubusercontent.com/IBM-Cloud/jpetstore-kubernetes/master/readme_images/architecture.png" alt="Modernize and extend a Java web app" />
                </div>
            </div>
        </div>
    </a>
    </div>
</div>
