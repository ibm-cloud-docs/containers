---

copyright:
  years: 2014, 2020
lastupdated: "2020-03-19"

keywords: kubernetes, iks, docker, containers

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


# Service architecture and dependencies
{: #service-arch}

Review sample cluster architectures and the components that are created in your [classic](#architecture_classic) or [VPC](#architecture_vpc) cluster.
{: shortdesc}

## Classic cluster
{: #architecture_classic}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> The following architectural overviews are specific to the classic infrastructure provider. For an architectural overview for the VPC infrastructure provider, see [VPC cluster architecture](#architecture_vpc).
{: note}

### Non-VRF or VRF-enabled account with public service endpoint only
{: #no-vrf-public-endpoint}

The following image shows the components of your cluster and how they interact in a non-VRF or VRF-enabled account when only the [public service endpoint is enabled](/docs/containers?topic=containers-plan_clusters#workeruser-master).
{: shortdesc}

<p>
<figure>
 <img src="images/cs_org_ov_public_se.png" alt="{{site.data.keyword.containerlong_notm}} Kubernetes architecture">
 <figcaption>{{site.data.keyword.containerlong_notm}} architecture when only the public service endpoint is enabled</figcaption>
</figure>
</p>

### VRF-enabled account with private and public service endpoints
{: #vrf-both-endpoints}

The following image shows the components of your cluster and how they interact in a VRF-enabled account when the [public and private service endpoints are enabled](/docs/containers?topic=containers-plan_clusters#workeruser-master).
{: shortdesc}

<p>
<figure>
 <img src="images/cs_org_ov_both_ses.png" alt="{{site.data.keyword.containerlong_notm}} Kubernetes architecture">
 <figcaption>{{site.data.keyword.containerlong_notm}} architecture when public and private service endpoints are enabled</figcaption>
</figure>
</p>

### Kubernetes master components
{: #master-components}

The Kubernetes master is tasked with managing all compute, network, and storage resources in the cluster, and ensures that your containerized apps and services are equally deployed to the worker nodes in the cluster. Depending on how you configure your app and services the master determines the worker node that has sufficient resources to fulfill the app's requirements.
{: shortdesc}

The Kubernetes master and all the master components are dedicated only to you, and are not shared with other IBM customers.  
{: note}

The following table describes the components of the Kubernetes master.

<table>
<caption>Components of the Kubernetes master</caption>
<thead>
<th>Master component</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>kube-apiserver</td>
<td>The Kubernetes API server serves as the main entry point for all cluster management requests from the worker node to the Kubernetes master. The Kubernetes API server validates and processes requests that change the state of Kubernetes resources, such as pods or services, and stores this state in etcd.</td>
</tr>
<tr>
<td>`openvpn-server`</td>
<td>The OpenVPN server works with the OpenVPN client to securely connect the master to the worker node. This connection supports `apiserver proxy` calls to your pods and services, and `kubectl exec`, `attach`, and `logs` calls to the kubelet.</td>
</tr>
<tr>
<td>`etcd`</td>
<td>`etcd` is a highly available key value store that stores the state of all Kubernetes resources of a cluster, such as services, deployments, and pods. Data in etcd is backed up to an encrypted storage instance that IBM manages.</td>
</tr>
<tr>
<td>`kube-scheduler`</td>
<td>The Kubernetes scheduler watches for newly created pods and decides where to deploy them based on capacity, performance needs, policy constraints, anti-affinity specifications, and workload requirements. If no worker node can be found that matches the requirements, the pod is not deployed in the cluster.</td>
</tr>
<tr>
<td>`kube-controller-manager`</td>
<td>The Kubernetes controller manager is a daemon that watches the state of cluster resources, such as replica sets. When the state of a resource changes, for example if a pod in a replica set goes down, the controller manager initiates correcting actions to achieve the required state.</td>
</tr>
</tbody></table>

### Worker node components
{: #worker-components}

Each worker node is a physical machine (bare metal) or a virtual machine that runs on physical hardware in the cloud environment. When you provision a worker node, you determine the resources that are available to the containers that are hosted on that worker node. Out of the box, your worker nodes are set up with an {{site.data.keyword.IBM_notm}}-managed Docker Engine, separate compute resources, networking, and a volume service. The built-in security features provide isolation, resource management capabilities, and worker node security compliance.
{: shortdesc}

The worker nodes and all the worker node components are dedicated only to you, and are not shared with other IBM customers. However, if you use a worker node virtual machine, the underlying hardware might be shared with other customers depending on the level of hardware isolation that you choose. For more information, see [Virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm).   
{: note}

Modifying default worker node components such as the `kubelet` is not supported and might cause unexpected results.
{: note}

The following table describes the components of a worker node.
    <table>
    <caption>Components of worker nodes</caption>
    <thead>
    <th>Worker component</th>
    <th>Namespace</th>
    <th>Description</th>
    </thead>
    <tbody>
    <tr>
    <td>`ibm-master-proxy`</td>
    <td>`kube-system`</td>
    <td>The `ibm-master-proxy` forwards requests from the worker node to the IP addresses of the highly available master replicas. In single zone clusters, the master has three replicas on separate hosts with one master IP address and domain name. For clusters that are in a multizone-capable zone, the master has three replicas that are spread across zones. As such, each master has its own IP address that is registered with DNS, with one domain name for the entire cluster master.</td>
    </tr>
    <tr>
    <td>`openvpn-client`</td>
    <td>`kube-system`</td>
    <td>The OpenVPN client works with the OpenVPN server to securely connect the master to the worker node. This connection supports `apiserver proxy` calls to your pods and services, and `kubectl exec`, `attach`, and `logs` calls to the kubelet.</td>
    </tr>
    <tr>
    <td>`kubelet`</td>
    <td>`kube-system`</td>
    <td>The kubelet is a pod that runs on every worker node and is responsible for monitoring the health of pods that run on the worker node and for watching the events that the Kubernetes API server sends. Based on the events, the kubelet creates or removes pods, ensures liveness and readiness probes, and reports back the status of the pods to the Kubernetes API server.</td>
    </tr>
    <tr>
    <td>`coredns`</td>
    <td>`kube-system`</td>
    <td>By default, Kubernetes schedules a CoreDNS pod (or KubeDNS pod in version 1.12 and earlier) and service on the cluster. Containers automatically use the DNS service's IP to resolve DNS names in their searches for other pods and services.</td>
    </tr>
    <tr>
    <td>`calico`</td>
    <td>`kube-system`</td>
    <td>Calico manages network policies for your cluster, and comprises a few components as follows.
    <ul>
    <li>**`calico-cni`**: The Calico container network interface (CNI) manages the network connectivity of containers and removes allocated resources when a container is deleted.</li>
    <li>**`calico-ipam`**: The Calico IPAM manages IP address assignment for containers.</li>
    <li>**`calico-node`**: The Calico node is a container that bundles together the various components that are required for networking containers with Calico.</li>
    <li>**`calico-policy-controller`**: The Calico policy controller watches inbound and outbound network traffic for compliance with set network policies. If the traffic is not allowed in the cluster, access to the cluster is blocked. The Calico policy controller is also used to create and set network policies for a cluster.</li></ul></td>
    </tr>
    <tr>
    <td>`kube-proxy`</td>
    <td>`kube-system`</td>
    <td>The Kubernetes network proxy is a daemon that runs on every worker node and that forwards or load balances TCP and UDP network traffic for services that run in the cluster.</td>
    </tr>
    <tr>
    <td>`kube-dashboard`</td>
    <td>`kube-system`</td>
    <td>The Kubernetes dashboard is a web-based GUI that allows users to manage and troubleshoot the cluster and applications that run in the cluster.</td>
    </tr>
    <tr>
    <td>`heapster`</td>
    <td>`kube-system`</td>
    <td>Heapster is a cluster-wide aggregator of monitoring and event data. The Heapster pod discovers all nodes in the cluster and queries usage information from each node's kubelet. You can find utilization graphs in the Kubernetes dashboard.</td>
    </tr>
    <tr>
    <td>Ingress ALB</td>
    <td>`kube-system`</td>
    <td>Ingress is a Kubernetes service that you can use to balance network traffic workloads in your cluster by forwarding public or private requests to multiple apps in your cluster. To expose your apps over the public or private network, you must create an Ingress resource to register your apps with the Ingress application load balancer (ALB). Multiple apps can then be accessed by using a single URL or IP address.</td>
    </tr>
    <tr>
    <td>Storage provider</td>
    <td>`kube-system`</td>
    <td>Every cluster is set up with a plug-in to provision file storage. You can choose to install other add-ons, such as block storage.</td>
    </tr>
    <tr>
    <td>Logging and metrics</td>
    <td>`ibm-system`</td>
    <td>You can use the {{site.data.keyword.la_full}} and {{site.data.keyword.mon_full}} services to expand your collection and retention capabilities when working with logs and metrics.</td>
    </tr>
    <tr>
    <td>Load balancer</td>
    <td>`ibm-system`</td>
    <td>A load balancer is a Kubernetes service that can be used to balance network traffic workloads in your cluster by forwarding public or private requests to an app.</td>
    </tr>
    <tr>
    <td>App pods and services</td>
    <td>`default`</td>
    <td>In the <code>default</code> namespace or in namespaces that you create, you can deploy apps in pods and services to communicate with those pods.</td>
    </tr>
    </tbody></table>


## VPC cluster
{: #architecture_vpc}

The following diagram and table describe the default components that are set up in an {{site.data.keyword.containerlong_notm}} VPC cluster architecture.
{: shortdesc}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> The following architectural overviews are specific to the VPC infrastructure provider. For an architectural overview for the classic infrastructure provider, see [Classic cluster architecture](#architecture_classic).
{: note}

![Kubernetes cluster in a VPC](images/cs_org_ov_vpc.png)

| Component | Description |
|:-----------------|:-----------------|
| Master |  [Master components](#master-components), including the API server and etcd, have three replicas and are spread across zones for even higher availability. Masters include the same components as described in the community Kubernetes architecture. The master and all the master components are dedicated only to you, and are not shared with other IBM customers.  |
| Worker node |  With {{site.data.keyword.containerlong_notm}}, the virtual machines that your cluster manages are instances that are called worker nodes. These worker nodes virtual machines and all the worker node components are dedicated to you only and are not shared with other IBM customers. However, the underlying hardware is shared with other IBM customers. For more information, see [Virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm). </br</br> You manage the worker nodes through the automation tools that are provided by {{site.data.keyword.containerlong_notm}}, such as the API, CLI, or console. Unlike classic clusters, you do not see VPC Gen 1 compute worker nodes in your infrastructure portal or separate infrastructure bill, but instead manage all maintenance and billing activity for the worker nodes from {{site.data.keyword.containerlong_notm}}.<br><br>Worker nodes include the same [components](#worker-components) as described in the Classic architecture. Community Kubernetes worker nodes run on Ubuntu 16.64, 18.64. |
| Cluster networking | Your worker nodes are created in a VPC subnet in the zone that you specify. By default, the public and private service endpoints for your cluster are enabled. Communication between the master and worker nodes is over the private network. Authenticated external users can communicate with the master over the public network, such as to run `kubectl` commands. You can optionally set up your cluster to communicate with on-prem services by setting up a VPN gateway appliance on the private network. |
| App networking | You can create a Kubernetes `LoadBalancer` service for your apps in the cluster, which automatically provisions a VPC load balancer in your VPC outside the cluster. The load balancer is multizonal and routes requests for your app through the private NodePorts that are automatically opened on your worker nodes. For more information, see [Exposing apps with VPC load balancers](/docs/containers?topic=containers-vpc-lbaas).<br><br>Calico is used as the cluster networking policy fabric. |
| Storage | You can set up only block persistent storage. Block storage is available as a cluster add-on. For more information, see [Storing data on IBM Block Storage for {{site.data.keyword.cloud_notm}}](/docs/containers?topic=containers-block_storage). |

<br />




## Dependencies to other {{site.data.keyword.cloud_notm}} services
{: #dependencies-ibmcloud}

Review the {{site.data.keyword.cloud_notm}} services that {{site.data.keyword.containerlong_notm}} connects to over the public network. 
{: #shortdesc}


| Service name | Description| 
| -----------|-------------------------------| 
| Business Support Services for {{site.data.keyword.cloud_notm}} (BSS) | The `BSS` component is used to access information about the {{site.data.keyword.cloud_notm}} account, service subscription, service usage, and billing. | 
|{{site.data.keyword.cloudcerts_short}}|This service is used to retrieve the TLS certificates for custom Ingress domains that {{site.data.keyword.containerlong_notm}} users set up.|
| Global Search and Tagging (Ghost) | The `Ghost` component is used to look up information about other {{site.data.keyword.cloud_notm}} services, such as IDs, tags, or service attributes. |
| Hypersync and hyperwarp | This {{site.data.keyword.cloud_notm}} component is used to provide information about clusters so that the cluster is visible to other {{site.data.keyword.cloud_notm}} services and cluster information can be searched and displayed. |
|{{site.data.keyword.cloud_notm}} Command Line (CLI)|When {{site.data.keyword.containerlong_notm}} runs CLI commands, the service connects to the service API endpoint over the public service endpoint.|
|{{site.data.keyword.registrylong_notm}}|This service is used to store the container images that {{site.data.keyword.containerlong_notm}} uses to run the service.|
| {{site.data.keyword.la_full_notm}} | {{site.data.keyword.containerlong_notm}} sends service logs to {{site.data.keyword.la_full_notm}}. These logs are monitored and analyzed by the service team to detect service issues and malicious activities. You can also use {{site.data.keyword.la_full_notm}} to manage your own pod container logs. To use {{site.data.keyword.la_full_notm}}, you must deploy a logging agent to every worker node in your cluster. This agent collects pod logs from all namespaces, including `kube-system`, and forwards the logs to {{site.data.keyword.la_full_notm}}. To get started, see [Managing Kubernetes cluster logs with {{site.data.keyword.la_full_notm}}](/docs/containers?topic=containers-health#app_logdna).  |
| {{site.data.keyword.mon_full_notm}} | {{site.data.keyword.containerlong_notm}} sends service metrics to {{site.data.keyword.mon_full_notm}}. These metrics are monitored by the service team to identify capacity and performance issues of the service. You can also use {{site.data.keyword.mon_full_notm}} to gain operational visibility into the performance and health of your apps. For more information, see [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster).|
| {{site.data.keyword.cloudaccesstraillong_notm}} | {{site.data.keyword.containerlong_notm}} integrates with {{site.data.keyword.at_full_notm}} to forward cluster audit events to the {{site.data.keyword.at_full_notm}} service instance that is set up and owned by the {{site.data.keyword.containerlong_notm}} user. For more information, see [{{site.data.keyword.cloudaccesstraillong_notm}} events](/docs/containers?topic=containers-at_events).|
| IBMid profile service | The IBMid component is used to look up the IBMid from an email address. The IBMid is used to authenticate with {{site.data.keyword.cloud_notm}} via Identity and Access Management (IAM). |
| Identity and Access Management (IAM) | To authenticate requests to the service and authorize user actions, {{site.data.keyword.containerlong_notm}} implements platform and service access roles in Identity and Access Management (IAM). For more information about required IAM permissions to work with the service, see [Assigning cluster access](/docs/containers?topic=containers-users). |
| Infrastructure Management System (IMS) | The Infrastructure Management System (IMS) component is used to provision, manage, and show information about classic infrastructure resources of the cluster, such as worker nodes, VLANs or subnets. |
| {{site.data.keyword.keymanagementservicelong_notm}} | To protect your cluster resources and data, {{site.data.keyword.containerlong_notm}}. uses {{site.data.keyword.keymanagementservicelong_notm}} root keys to encrypt data in etcd, secrets, and on the worker node drive. For additional encryption, you can enable {{site.data.keyword.keymanagementserviceshort}} as a key management system provider in your cluster. For more information about how data is encrypted, see [Overview of cluster encryption](/docs/containers?topic=containers-encryption#encrypt_ov). | 
|{{site.data.keyword.cos_short}} (COS)|This service is used to store customer logs for all cluster master operations, such as `deploy`, `patch`, `update`, or `delete`, and to back up cluster metrics. Access to this service instance is protected by IAM policies and available to the {{site.data.keyword.containerlong_notm}} service team only to detect malicious activity. All data is encrypted in transit and at rest.|
| User Account & Authentication (UAA) | This service is used to provide OAuth authentication for Cloud Foundry services. | 
| Virtual Private Cloud (VPC) | {{site.data.keyword.containerlong_notm}} uses the VPC API to provision, manage, and show information about VPC infrastructure resources of the cluster, such as worker nodes, subnets, or storage instances. |

## Dependencies to 3rd party services
{: #dependencies-3rd-party}

Review the list of 3rd party services that {{site.data.keyword.containerlong_notm}} connects to over the public network. 
{: #shortdesc}

| Service name | Description| 
| -----------|-------------------------------| 
| Cloudflare | Cloudflare is used as the primary provider for DNS, global load balancing, and web firewall capabilities in {{site.data.keyword.containerlong_notm}}. |
| Github Enterprise | GitHub Enterprise is used to track service enhancements, features, and customer issues. When a customer issue is identified, the cluster ID, worker node IDs, the flavor of the worker nodes, and the zone where the worker nodes are deployed to are documented. This information is then shared with the service team to start troubleshooting the issue. | 
| Launch Darkly | To manage the roll out of new features in {{site.data.keyword.containerlong_notm}}, Launch Darkly feature flags are used. A feature flag controls the visibility and availability of a feature to a selected user base. | 
| Let's Encrypt | This service is used as the Certificate authority to generate SSL certificates for customer owned public endpoints. All generated certificates are managed in {{site.data.keyword.cloudcerts_short}}.|
| Razee | [Razee](https://razee.io/){: external} is an open-source project that was developed by IBM to automate and manage the deployment of Kubernetes resources, versions, features, and security patches across {{site.data.keyword.containerlong_notm}} environments, and to visualize deployment information. Razee integrates with Launch Darkly to control the visibility of these features to the {{site.data.keyword.containerlong_notm}} use base. You can also use Razee to manage the rollout of your own deployments across multiple clusters. For more information, see the [Razee documentation](https://github.com/razee-io/Razee){: external}.   |
| Slack | Slack is used as the IBM-internal communication medium to troubleshoot cluster issues and bring together internal SMEs to resolve customer issues. Diagnostic information about clusters are sent to a private Slack channel and include the customer account ID, cluster ID, and details about the worker nodes. |

