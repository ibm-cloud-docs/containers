---

copyright:
  years: 2014, 2021
lastupdated: "2021-10-08"

keywords: kubernetes, iks, docker, containers

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

  


# Architecture and dependencies of the service
{: #service-arch}

Review sample cluster architectures and the components that are created in your [classic](#architecture_classic) or [VPC](#architecture_vpc) cluster.
{: shortdesc}

## Classic cluster
{: #architecture_classic}

![Classic infrastructure provider icon.](images/icon-classic-2.svg) The following architectural overviews are specific to the classic infrastructure provider. For an architectural overview for the VPC infrastructure provider, see [VPC cluster architecture](#architecture_vpc).
{: note}

### Non-VRF or VRF-enabled account with public cloud service endpoint only
{: #no-vrf-public-endpoint}

The following image shows the components of your cluster and how they interact in a non-VRF or VRF-enabled account when only the [public cloud service endpoint is enabled](/docs/containers?topic=containers-plan_clusters#workeruser-master).
{: shortdesc}

<p>
<figure>
    <img src="images/cs_org_ov_public_se.png" alt="{{site.data.keyword.containerlong_notm}} Kubernetes architecture">
    <figcaption>{{site.data.keyword.containerlong_notm}} architecture when only the public cloud service endpoint is enabled</figcaption>
</figure>
</p>

### VRF-enabled account with private and public cloud service endpoints
{: #vrf-both-endpoints}

The following image shows the components of your cluster and how they interact in a VRF-enabled account when the [public and private cloud service endpoints are enabled](/docs/containers?topic=containers-plan_clusters#workeruser-master).
{: shortdesc}

<p>
<figure>
    <img src="images/cs_org_ov_both_ses.png" alt="{{site.data.keyword.containerlong_notm}} Kubernetes architecture">
    <figcaption>{{site.data.keyword.containerlong_notm}} architecture when public and private cloud service endpoints are enabled</figcaption>
</figure>
</p>

### Kubernetes master components
{: #master-components}

The Kubernetes master is tasked with managing all compute, network, and storage resources in the cluster, and ensures that your containerized apps and services are equally deployed to the worker nodes in the cluster. Depending on how you configure your app and services the master determines the worker node that has sufficient resources to fulfill the app's requirements.
{: shortdesc}

The Kubernetes master and all the master components are dedicated only to you, and are not shared with other IBM customers.  
{: note}

The following table describes the components of the Kubernetes master.

<table summary="The columns are read from left to right. The first column has the master component. The second column describes the component.">
<caption>Components of the Kubernetes master</caption>
<col width="25%">
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
<td><code>openvpn-server</code> (Kubernetes version 1.20 or earlier) or <code>konnectivity-server</code> (Kubernetes version 1.21 or later)</td>
<td>The OpenVPN or Konnectivity server works with the OpenVPN client or Konnectivity agent to securely connect the master to the worker node. This connection supports <code>apiserver proxy</code> calls to your pods and services, and <code>kubectl exec</code>, <code>attach</code>, and <code>logs</code> calls to the kubelet.</td>
</tr>
<tr>
<td><code>etcd</code></td>
<td><code>etcd</code> is a highly available key value store that stores the state of all Kubernetes resources of a cluster, such as services, deployments, and pods. Data in etcd is backed up to an encrypted storage instance that IBM manages.</td>
</tr>
<tr>
<td><code>kube-scheduler</code></td>
<td>The Kubernetes scheduler watches for newly created pods and decides where to deploy them based on capacity, performance needs, policy constraints, anti-affinity specifications, and workload requirements. If no worker node can be found that matches the requirements, the pod is not deployed in the cluster.</td>
</tr>
<tr>
<td><code>kube-controller-manager</code></td>
<td>The Kubernetes controller manager is a daemon that watches the state of cluster resources, such as replica sets. When the state of a resource changes, for example if a pod in a replica set goes down, the controller manager initiates correcting actions to achieve the required state.</td>
</tr>
</tbody></table>

### Worker node components
{: #worker-components}

Each worker node is a physical machine (bare metal) or a virtual machine that runs on physical hardware in the cloud environment. When you provision a worker node, you determine the resources that are available to the containers that are hosted on that worker node. Out of the box, your worker nodes are set up with an {{site.data.keyword.IBM_notm}}-managed container runtime, separate compute resources, networking, and a volume service. The built-in security features provide isolation, resource management capabilities, and worker node security compliance.
{: shortdesc}

The worker nodes and all the worker node components are dedicated only to you, and are not shared with other IBM customers. However, if you use a worker node virtual machine, the underlying hardware might be shared with other customers depending on the level of hardware isolation that you choose. For more information, see [Virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm).   
{: note}

Modifying default worker node components such as the `kubelet` is not supported and might cause unexpected results.
{: note}

The following table describes the components of a worker node.
    <table summary="The columns are read from left to right. The first column has the worker node component. The second column describes the component.">
    <caption>Components of worker nodes</caption>
    <col width="15%">
    <thead>
    <th>Worker component</th>
    <th>Namespace</th>
    <th>Description</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ibm-master-proxy</code></td>
    <td><code>kube-system</code></td>
    <td>The <code>ibm-master-proxy</code> forwards requests from the worker node to the IP addresses of the highly available master replicas. In single zone clusters, the master has three replicas on separate hosts with one master IP address and domain name. For clusters that are in a multizone-capable zone, the master has three replicas that are spread across zones. As such, each master has its own IP address that is registered with DNS, with one domain name for the entire cluster master.</td>
    </tr>
    <tr>
    <td><code>openvpn-client</code> (Kubernetes version 1.20 or earlier) or <code>konnectivity-agent</code> (Kubernetes version 1.21 or later)</td>
    <td><code>kube-system</code></td>
    <td>The OpenVPN client or Konnectivity agent works with the OpenVPN or Konnectivity server to securely connect the master to the worker node. This connection supports <code>apiserver proxy</code> calls to your pods and services, and <code>kubectl exec</code>, <code>attach</code>, and <code>logs</code> calls to the kubelet.</td>
    </tr>
    <tr>
    <td><code>kubelet</code></td>
    <td><code>kube-system</code></td>
    <td>The kubelet is a pod that runs on every worker node and is responsible for monitoring the health of pods that run on the worker node and for watching the events that the Kubernetes API server sends. Based on the events, the kubelet creates or removes pods, ensures liveness and readiness probes, and reports back the status of the pods to the Kubernetes API server.</td>
    </tr>
    <tr>
    <td><code>coredns</code></td>
    <td><code>kube-system</code></td>
    <td>By default, Kubernetes schedules a CoreDNS pod (or KubeDNS pod in version 1.12 and earlier) and service on the cluster. Containers automatically use the DNS service's IP to resolve DNS names in their searches for other pods and services.</td>
    </tr>
    <tr>
    <td><code>calico</code></td>
    <td><code>kube-system</code></td>
    <td>Calico manages network policies for your cluster, and comprises a few components as follows.
    <ul>
    <li><strong><code>calico-cni</code></strong>: The Calico container network interface (CNI) manages the network connectivity of containers and removes allocated resources when a container is deleted.</li>
    <li><strong><code>calico-ipam</code></strong>: The Calico IPAM manages IP address assignment for containers.</li>
    <li><strong><code>calico-node</code></strong>: The Calico node is a container that bundles together the various components that are required for networking containers with Calico.</li>
    <li><strong><code>calico-policy-controller</code></strong>: The Calico policy controller watches inbound and outbound network traffic for compliance with set network policies. If the traffic is not allowed in the cluster, access to the cluster is blocked. The Calico policy controller is also used to create and set network policies for a cluster.</li></ul></td>
    </tr>
    <tr>
    <td><code>kube-proxy</code></td>
    <td><code>kube-system</code></td>
    <td>The Kubernetes network proxy is a daemon that runs on every worker node and that forwards or load balances TCP and UDP network traffic for services that run in the cluster.</td>
    </tr>
    <tr>
    <td><code>kube-dashboard</code></td>
    <td><code>kube-system</code></td>
    <td>The Kubernetes dashboard is a web-based GUI that allows users to manage and troubleshoot the cluster and applications that run in the cluster.</td>
    </tr>
    <tr>
    <td><code>heapster</code></td>
    <td><code>kube-system</code></td>
    <td>Heapster is a cluster-wide aggregator of monitoring and event data. The Heapster pod discovers all nodes in the cluster and queries usage information from each node's kubelet. You can find utilization graphs in the Kubernetes dashboard.</td>
    </tr>
    <tr>
    <td>Ingress ALB</td>
    <td><code>kube-system</code></td>
    <td>Ingress is a Kubernetes service that you can use to balance network traffic workloads in your cluster by forwarding public or private requests to multiple apps in your cluster. To expose your apps over the public or private network, you must create an Ingress resource to register your apps with the Ingress application load balancer (ALB). Multiple apps can then be accessed by using a single URL or IP address.</td>
    </tr>
    <tr>
    <td>Storage provider</td>
    <td><code>kube-system</code></td>
    <td>Every cluster is set up with a plug-in to provision file storage. You can choose to install other add-ons, such as block storage.</td>
    </tr>
    <tr>
    <td>Logging and metrics</td>
    <td><code>ibm-system</code></td>
    <td>You can use the {{site.data.keyword.la_full}} and {{site.data.keyword.mon_full}} services to expand your collection and retention capabilities when working with logs and metrics.</td>
    </tr>
    <tr>
    <td>Load balancer</td>
    <td><code>ibm-system</code></td>
    <td>A load balancer is a Kubernetes service that can be used to balance network traffic workloads in your cluster by forwarding public or private requests to an app.</td>
    </tr>
    <tr>
    <td>App pods and services</td>
    <td><code>default</code></td>
    <td>In the <code>default</code> namespace or in namespaces that you create, you can deploy apps in pods and services to communicate with those pods.</td>
    </tr>
    </tbody></table>


## VPC cluster
{: #architecture_vpc}

The following diagram and table describe the default components that are set up in an {{site.data.keyword.containerlong_notm}} VPC cluster architecture.
{: shortdesc}

![VPC infrastructure provider icon.](images/icon-vpc-2.svg) The following architectural overviews are specific to the VPC infrastructure provider. For an architectural overview for the classic infrastructure provider, see [Classic cluster architecture](#architecture_classic).
{: note}

![Kubernetes cluster in a VPC](images/cs_org_ov_vpc.png)

| Component | Description |
|:-----------------|:-----------------|
| Master |  [Master components](#master-components), including the API server and etcd, have three replicas and are spread across zones for even higher availability. Masters include the same components as described in the community Kubernetes architecture. The master and all the master components are dedicated only to you, and are not shared with other IBM customers.  |
| Worker node |  With {{site.data.keyword.containerlong_notm}}, the virtual machines that your cluster manages are instances that are called worker nodes. These worker nodes virtual machines and all the worker node components are dedicated to you only and are not shared with other IBM customers. However, the underlying hardware is shared with other IBM customers. For more information, see [Virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm). </br></br> You manage the worker nodes through the automation tools that are provided by {{site.data.keyword.containerlong_notm}}, such as the API, CLI, or console. Unlike classic clusters, you do not see VPC compute worker nodes in your infrastructure portal or separate infrastructure bill, but instead manage all maintenance and billing activity for the worker nodes from {{site.data.keyword.containerlong_notm}}.</br></br> Worker nodes include the same [components](#worker-components) as described in the Classic architecture. Community Kubernetes worker nodes run on Ubuntu 18.04 x86_64, 16.04 x86_64 (deprecated). |
| Cluster networking | Your worker nodes are created in a VPC subnet in the zone that you specify. By default, the public and private cloud service endpoints for your cluster are enabled. Communication between the master and worker nodes is over the private network. Authenticated external users can communicate with the master over the public network, such as to run `kubectl` commands. You can optionally set up your cluster to communicate with on-prem services by setting up a VPC VPN on the private network. |
| App networking | You can create a Kubernetes `LoadBalancer` service for your apps in the cluster, which automatically provisions a VPC load balancer in your VPC outside the cluster. The load balancer is multizonal and routes requests for your app through the private NodePorts that are automatically opened on your worker nodes. For more information, see [Exposing apps with VPC load balancers](/docs/containers?topic=containers-vpc-lbaas).<br><br>Calico is used as the cluster networking policy fabric. |
| Storage | You can set up only block persistent storage. Block storage is available as a cluster add-on. For more information, see [Storing data on IBM Block Storage for {{site.data.keyword.cloud_notm}}](/docs/containers?topic=containers-block_storage). |



## Overview of personal and sensitive data storage and removal options
{: #ibm-data}

Review what information is stored with IBM when you use {{site.data.keyword.containerlong_notm}}, how this data is stored and encrypted, and how you can permanently remove this information.
{: shortdesc}

### What information is stored with IBM when using {{site.data.keyword.containerlong_notm}}?
{: #pi-info}

For each cluster that you create with {{site.data.keyword.containerlong_notm}}, IBM stores the information that is described in the following table:

|Information type|Data|
|-------|----------|
|Personal information|The email address of the {{site.data.keyword.cloud_notm}} account that created the cluster.|
|Sensitive information|  - The TLS certificate and secret that is used for the assigned Ingress subdomain.  \n - The certificate authority that is used for the TLS certificate.  \n - The certificate authority, private keys, and TLS certificates for the Kubernetes master components, including the Kubernetes API server, etcd data store, and VPN.  \n - A customer root key in {{site.data.keyword.keymanagementservicelong_notm}} for each {{site.data.keyword.cloud_notm}} account that is used to encrypt personal and sensitive information.|


### How is my information stored and encrypted?
{: #pi-storage}

All information is stored in an etcd database and backed up every 8 hours to {{site.data.keyword.cos_full_notm}}. The etcd database and {{site.data.keyword.cos_short}} service instance are owned and managed by the {{site.data.keyword.cloud_notm}} SRE team. For each {{site.data.keyword.cloud_notm}} account, a customer root key in {{site.data.keyword.keymanagementservicelong_notm}} is created that is managed by the {{site.data.keyword.containerlong_notm}} service team. This root key is used to encrypt all personal and sensitive information in etcd and in {{site.data.keyword.cos_short}}.

### Where is my information stored?
{: #pi-location}

The location where your information is stored depends on the location your cluster is in. By default, your data is stored in the {{site.data.keyword.containerlong_notm}} multizone metro area that is closest to your cluster. However, {{site.data.keyword.containerlong_notm}} might decide to store your data in a different multizone metro area to optimize the utilization of available compute resources. If you create your cluster in a non-multizone metro area, your data is still stored in the closest multizone metro area. This location might be in a different country than the one where you created your cluster. Make sure that your information can reside in a different country before you create your cluster in a non-multizone metro area.

The data that you create and own is always stored in the same location as the cluster. For more information about what data you can create in your cluster, how this data is encrypted, and how you can protect this data, see [Protecting sensitive information in your cluster](/docs/containers?topic=containers-encryption).
{: note}

### How can I remove my information?
{: #pi-removal}

Review your options to remove your information from {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

Removing personal and sensitive information is permanent and nonreversible. Make sure that you want to permanently remove your information before you proceed.
{: important}

**Is my data removed when I remove the cluster?**

Deleting a cluster does not remove all information from {{site.data.keyword.containerlong_notm}}. When you delete a cluster, cluster-specific information is removed from the etcd instance that is managed by IBM. However, your information still exists in the {{site.data.keyword.cos_full_notm}} backup and can still be accessed by the IBM service team by using the account-specific customer root key in {{site.data.keyword.keymanagementservicelong_notm}} that IBM owns and manages.

**What options do I have to permanently remove my data?**

To remove that data that IBM stores, choose between the following options. Note that removing your personal and sensitive information requires all of your clusters to be deleted as well. Make sure that you backed up your app data before your proceed.

- **Open an {{site.data.keyword.cloud_notm}} support case**: Contact IBM Support to remove your personal and sensitive information from {{site.data.keyword.containerlong_notm}}. For more information, see [Getting support](/docs/get-support?topic=get-support-using-avatar).
- **End your {{site.data.keyword.cloud_notm}} subscription**: After you end your {{site.data.keyword.cloud_notm}} subscription, {{site.data.keyword.containerlong_notm}} removes the customer root key in {{site.data.keyword.keymanagementservicelong_notm}} that IBM created and managed for you as well as all the personal and sensitive information from the etcd data store and {{site.data.keyword.cos_short}} backup.



## Dependencies to other {{site.data.keyword.cloud_notm}} services
{: #dependencies-ibmcloud}

Review the {{site.data.keyword.cloud_notm}} services that {{site.data.keyword.containerlong_notm}} connects to over the public network. 
{: shortdesc}


| Service name | Description| 
| -----------|-------------------------------| 
| {{site.data.keyword.cloudaccesstraillong_notm}} | {{site.data.keyword.containerlong_notm}} integrates with {{site.data.keyword.at_full_notm}} to forward cluster audit events to the {{site.data.keyword.at_full_notm}} service instance that is set up and owned by the {{site.data.keyword.containerlong_notm}} user. For more information, see [{{site.data.keyword.cloudaccesstraillong_notm}} events](/docs/containers?topic=containers-at_events).|
|{{site.data.keyword.cloudcerts_full_notm}}|This service is used to retrieve the TLS certificates for custom Ingress domains in {{site.data.keyword.containerlong_notm}} clusters.|
|{{site.data.keyword.registrylong_notm}}|This service is used to store the container images that {{site.data.keyword.containerlong_notm}} uses to run the service.|
| {{site.data.keyword.mon_full_notm}} | {{site.data.keyword.containerlong_notm}} sends service metrics to {{site.data.keyword.mon_full_notm}}. These metrics are monitored by the service team to identify capacity and performance issues of the service. You can also use {{site.data.keyword.mon_full_notm}} to gain operational visibility into the performance and health of your apps. For more information, see [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/monitoring?topic=monitoring-kubernetes_cluster#kubernetes_cluster).|
|{{site.data.keyword.cloud_notm}} Platform | To authenticate requests to the service and authorize user actions, {{site.data.keyword.containerlong_notm}} implements platform and service access roles in Identity and Access Management (IAM). For more information about required IAM permissions to work with the service, see [Assigning cluster access](/docs/containers?topic=containers-users#checking-perms). |
| {{site.data.keyword.keymanagementservicelong_notm}} | To protect your cluster resources and data, {{site.data.keyword.containerlong_notm}}. uses {{site.data.keyword.keymanagementservicelong_notm}} root keys to encrypt data in etcd, secrets, and on the worker node drive. For additional encryption, you can enable {{site.data.keyword.keymanagementserviceshort}} as a key management system provider in your cluster. For more information about how data is encrypted, see [Overview of cluster encryption](/docs/containers?topic=containers-encryption#encrypt_ov). | 
| {{site.data.keyword.la_full_notm}} | {{site.data.keyword.containerlong_notm}} sends service logs to {{site.data.keyword.la_full_notm}}. These logs are monitored and analyzed by the service team to detect service issues and malicious activities. You can also use {{site.data.keyword.la_full_notm}} to manage your own pod container logs. To use {{site.data.keyword.la_full_notm}}, you must deploy a logging agent to every worker node in your cluster. This agent collects pod logs from all namespaces, including `kube-system`, and forwards the logs to {{site.data.keyword.la_full_notm}}. To get started, see [Managing Kubernetes cluster logs with {{site.data.keyword.la_full_notm}}](/docs/containers?topic=containers-health).  |
|{{site.data.keyword.cos_short}} (COS)|This service is used to store customer logs for all cluster master operations, such as `deploy`, `patch`, `update`, or `delete`, and to back up cluster metrics. Access to this service instance is protected by IAM policies and available to the {{site.data.keyword.containerlong_notm}} service team only to detect malicious activity. All data is encrypted in transit and at rest.|
| Virtual Private Cloud (VPC) | {{site.data.keyword.containerlong_notm}} uses the VPC API to provision, manage, and show information about VPC infrastructure resources of the cluster, such as worker nodes, subnets, or storage instances. |
{: caption="{{site.data.keyword.containerlong_notm}} dependencies to {{site.data.keyword.cloud_notm}} services." caption-side="top"}
{: summary="The rows are read from left to right. The first column is the service. The second column is a description of the service."}



## Dependencies to 3rd party services
{: #dependencies-3rd-party}

Review the list of 3rd party services that {{site.data.keyword.containerlong_notm}} connects to over the public network. 
{: shortdesc}

| Service name | Description| 
| -----------|-------------------------------| 
| Akamai, Cloudflare | Akamai and Cloudflare are used as the primary providers for DNS, global load balancing, and web firewall capabilities in {{site.data.keyword.containerlong_notm}}. With global load balancing, these providers decrypt requests to the product API server, read the header packet of the request, and reencrypt the request before forwarding to the product API server. The header packet can include information such as the requested API method, time, or region. Note that this process applies only to requests to the product API server, and not to other requests, such as to apps in your cluster over the Ingress subdomain or custom domains. |
| Let's Encrypt | This service is used as the Certificate authority to generate SSL certificates for customer owned public endpoints. All generated certificates are managed in {{site.data.keyword.cloudcerts_short}}.|
{: caption="{{site.data.keyword.containerlong_notm}} dependencies to third-party services." caption-side="top"}
{: summary="The rows are read from left to right. The first column is the service. The second column is a description of the service."}





