---

copyright:
  years: 2014, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Security for {{site.data.keyword.containerlong_notm}}
{: #security}

You can use built-in security features in {{site.data.keyword.containerlong}} for risk analysis and security protection. These features help you to protect your Kubernetes cluster infrastructure and network communication, isolate your compute resources, and ensure security compliance across your infrastructure components and container deployments.
{: shortdesc}



## Security by cluster component
{: #cluster}

Each {{site.data.keyword.containerlong_notm}} cluster has security features that are built in to its [master](#master) and [worker](#worker) nodes.
{: shortdesc}

If you have a firewall, or want to run `kubectl` commands from your local system when corporate network policies prevent access to public internet endpoints, [open ports in your firewall](cs_firewall.html#firewall). To connect apps in your cluster to an on-premises network or to other apps external to your cluster, [set up VPN connectivity](cs_vpn.html#vpn).

In the following diagram, you can see security features that are grouped by Kubernetes master, worker nodes, and container images.

<img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} cluster security" style="width:400px; border-style: none"/>


<table summary="The first row in the table spans both columns. The remaining rows are to be read left to right, with the security component in column one and features to match in column two.">
<caption>Security by component</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Built-in cluster security settings in {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes master</td>
      <td>The Kubernetes master in each cluster is managed by IBM and is highly available. The master includes {{site.data.keyword.containershort_notm}} security settings that ensure security compliance and secure communication to and from the worker nodes. Security updates are performed by IBM as required. The dedicated Kubernetes master centrally controls and monitors all Kubernetes resources in the cluster. Based on the deployment requirements and capacity in the cluster, the Kubernetes master automatically schedules your containerized apps to deploy across available worker nodes. For more information, see [Kubernetes master security](#master).</td>
    </tr>
    <tr>
      <td>Worker node</td>
      <td>Containers are deployed on worker nodes that are dedicated to a cluster and that ensure compute, network, and storage isolation for IBM customers. {{site.data.keyword.containershort_notm}} provides built-in security features to keep your worker nodes secure on the private and public network and to ensure worker node security compliance. For more information, see [Worker node security](#worker). In addition, you can add [Calico network policies](cs_network_policy.html#network_policies) to further specify the network traffic that is allowed or blocked to and from a pod on a worker node.</td>
    </tr>
    <tr>
      <td>Images</td>
      <td>As the cluster admin, you can set up your own secure Docker image repository in {{site.data.keyword.registryshort_notm}} where you can store and share Docker images between your cluster users. To ensure safe container deployments, every image in your private registry is scanned by Vulnerability Advisor. Vulnerability Advisor is a component of {{site.data.keyword.registryshort_notm}} that scans for potential vulnerabilities, makes security recommendations, and provides instructions to resolve vulnerabilities. For more information, see [Image security in {{site.data.keyword.containershort_notm}}](#images).</td>
    </tr>
  </tbody>
</table>

<br />


## Kubernetes master
{: #master}

Review the built-in Kubernetes master security features to protect the Kubernetes master and to secure the cluster network communication.
{: shortdesc}

<dl>
  <dt>Fully managed and dedicated Kubernetes master</dt>
    <dd>Every Kubernetes cluster in {{site.data.keyword.containershort_notm}} is controlled by a dedicated Kubernetes master that is managed by IBM in an IBM-owned IBM Cloud infrastructure (SoftLayer) account. The Kubernetes master is set up with the following dedicated components that are not shared with other IBM customers or by different clusters within the same IBM account.
      <ul><li>etcd data store: Stores all Kubernetes resources of a cluster, such as Services, Deployments, and Pods. Kubernetes ConfigMaps and Secrets are app data that are stored as key value pairs so that they can be used by an app that runs in a pod. Data in etcd is stored on an encrypted disk that is managed by IBM and backed up daily. When sent to a pod, data is encrypted via TLS to assure data protection and integrity. </li>
      <li>kube-apiserver: Serves as the main entry point for all requests from the worker node to the Kubernetes master. The kube-apiserver validates and processes requests and can read from and write to the etcd data store.</li>
      <li>kube-scheduler: Decides where to deploy pods, considering the capacity and performance needs, hardware and software policy constraints, anti-affinity specifications, and workload requirements. If no worker node can be found that matches the requirements, the pod is not deployed in the cluster.</li>
      <li>kube-controller-manager: Responsible for monitoring replica sets, and creating corresponding pods to achieve the desired state.</li>
      <li>OpenVPN: {{site.data.keyword.containershort_notm}}-specific component to provide secured network connectivity for all Kubernetes master to worker node communication.</li></ul></dd>
  <dt>TLS secured network connectivity for all worker node to Kubernetes master communication</dt>
    <dd>To secure the connection to the Kubernetes master, {{site.data.keyword.containershort_notm}} generates TLS certificates that encrypt the communication to and from the kube-apiserver and etcd data store. These certificates are never shared across clusters or across Kubernetes master components.</dd>
  <dt>OpenVPN secured network connectivity for all Kubernetes master to worker node communication</dt>
    <dd>Although Kubernetes secures the communication between the Kubernetes master and worker nodes by using the `https` protocol, no authentication is provided on the worker node by default. To secure this communication, {{site.data.keyword.containershort_notm}} automatically sets up an OpenVPN connection between the Kubernetes master and the worker node when the cluster is created.</dd>
  <dt>Continuous Kubernetes master network monitoring</dt>
    <dd>Every Kubernetes master is continuously monitored by IBM to control and remediate process level Denial-Of-Service (DOS) attacks.</dd>
  <dt>Kubernetes master node security compliance</dt>
    <dd>{{site.data.keyword.containershort_notm}} automatically scans every node where the Kubernetes master is deployed for vulnerabilities found in Kubernetes and OS-specific security fixes. If vulnerabilities are found, {{site.data.keyword.containershort_notm}} automatically applies fixes and resolves vulnerabilities on behalf of the user to ensure master node protection. </dd>
</dl>

<br />


## Worker nodes
{: #worker}

Review the built-in worker node security features to protect the worker node environment and to assure resource, network, and storage isolation.
{: shortdesc}

<dl>
  <dt>Worker node ownership</dt>
    <dd>The ownership of worker nodes depends on the type of cluster that you create. <p> Worker nodes in free clusters are provisioned in to the IBM Cloud infrastructure (SoftLayer) account that is owned by IBM. Users can deploy apps to the worker nodes but cannot change settings or install extra software on the worker node.</p>
    <p>Worker nodes in standard clusters are provisioned in to the IBM Cloud infrastructure (SoftLayer) account that is associated with the customer's public or dedicated IBM Cloud account. The worker nodes are owned by the customer. Customers can choose to change security settings or install extra software on the worker nodes as provided by {{site.data.keyword.containerlong}}.</p> </dd>
  <dt>Compute, network, and storage infrastructure isolation</dt>
    <dd><p>When you create a cluster, worker nodes are provisioned as virtual machines by IBM. Worker nodes are dedicated to a cluster and do not host workloads of other clusters.</p>
    <p> Every {{site.data.keyword.Bluemix_notm}} account is set up with IBM Cloud infrastructure (SoftLayer) VLANs to assure quality network performance and isolation on the worker nodes. You can also designate worker nodes as private by connecting them to a private VLAN only.</p> <p>To persist data in your cluster, you can provision dedicated NFS-based file storage from IBM Cloud infrastructure (SoftLayer) and leverage the built-in data security features of that platform.</p></dd>
  <dt>Secured worker node setup</dt>
    <dd><p>Every worker node is set up with an Ubuntu operating system that cannot be changed by the worker node owner. Because the operating system of the worker node is Ubuntu, all containers that are deployed to the worker node must use a Linux distribution that uses the Ubuntu kernel. Linux distributions that must talk to the kernel in a different way cannot be used. To protect the operating system of the worker nodes from potential attacks, every worker node is configured with expert firewall settings that are enforced by Linux iptable rules.</p>
    <p>All containers that run on Kubernetes are protected by predefined Calico network policy settings that are configured on every worker node during cluster creation. This set up ensures secure network communication between worker nodes and pods.</p>
    <p>SSH access is disabled on the worker node. If you have a standard cluster and you want to install more features on your worker node, you can use [Kubernetes daemon sets ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) for everything that you want to run on every worker node. For any one-time action that you must execute, use [Kubernetes jobs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/).</p></dd>
  <dt>Kubernetes worker node security compliance</dt>
    <dd>IBM works with internal and external security advisory teams to address potential security compliance vulnerabilities. <b>Important</b>: Use the `bx cs worker-update` [command](cs_cli_reference.html#cs_worker_update) regularly (such as monthly) to deploy updates and security patches to the operating system and to update the Kubernetes version. When updates are available, you are notified when you view information about the worker nodes, such as with the `bx cs workers <cluster_name>` or `bx cs worker-get <cluster_name> <worker_ID>` commands.</dd>
  <dt>Option to deploy nodes on physical (bare metal) servers</dt>
    <dd>If you choose to provision your worker nodes on bare metal physical servers (instead of virtual server instances), you have more control over the compute host, such as the memory or CPU. This setup eliminates the virtual machine hypervisor that allocates physical resources to virtual machines that run on the host. Instead, all of a bare metal machine's resources are dedicated exclusively to the worker, so you don't need to worry about "noisy neighbors" sharing resources or slowing down performance. Bare metal servers are dedicated to you, with all its resources available for cluster usage.</dd>
  <dt id="trusted_compute">{{site.data.keyword.containershort_notm}} with Trusted Compute</dt>
    <dd><p>When you [deploy your cluster on bare metal](cs_clusters.html#clusters_ui) that supports Trusted Compute, you can enable trust. The Trusted Platform Module (TPM) chip is enabled on each bare metal worker node in the cluster that supports Trusted Compute (including future nodes that you add to the cluster). Therefore, after you enable trust, you cannot later disable it for the cluster. A trust server is deployed on the master node, and a trust agent is deployed as a pod on the worker node. When your worker node starts up, the trust agent pod monitors each stage of the process.</p>
    <p>For example, if an unauthorized user gains access to your system and modifies the OS kernel with extra logic to collect data, the trust agent detects this change and marks the node's as untrusted. With trusted compute, you can verify your worker nodes against tampering.</p>
    <p><strong>Note</strong>: Trusted Compute is available for select bare metal machine types. For example, `mgXc` GPU flavors do not support Trusted Compute.</p></dd>
  <dt id="encrypted_disks">Encrypted disk</dt>
    <dd><p>By default, {{site.data.keyword.containershort_notm}} provides two local SSD encrypted data partitions for all worker nodes when the worker nodes are provisioned. The first partition is not encrypted, and the second partition is unlocked by using LUKS encryption keys. Each worker in each Kubernetes cluster has its own unique LUKS encryption key, managed by {{site.data.keyword.containershort_notm}}. When you create a cluster or add a worker node to an existing cluster, the keys are pulled securely and then discarded after the encrypted disk is unlocked.</p>
    <p><b>Note</b>: Encryption can impact disk I/O performance. For workloads that require high-performance disk I/O, test a cluster with encryption both enabled and disabled to help you decide whether to turn off encryption.</p></dd>
  <dt>Support for IBM Cloud infrastructure (SoftLayer) network firewalls</dt>
    <dd>{{site.data.keyword.containershort_notm}} is compatible with all [IBM Cloud infrastructure (SoftLayer) firewall offerings ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/network-security). On {{site.data.keyword.Bluemix_notm}} Public, you can set up a firewall with custom network policies to provide dedicated network security for your standard cluster and to detect and remediate network intrusion. For example, you might choose to set up a [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html) to act as your firewall and block unwanted traffic. When you set up a firewall, [you must also open up the required ports and IP addresses](cs_firewall.html#firewall) for each region so that the master and the worker nodes can communicate.</dd>
  <dt>Keep services private or selectively expose services and apps to the public internet</dt>
    <dd>You can choose to keep your services and apps private and leverage the built-in security features to assure secured communication between worker nodes and pods. To expose services and apps to the public internet, you can leverage the Ingress and load balancer support to securely make your services publicly available.</dd>
  <dt>Securely connect your worker nodes and apps to an on-premises data center</dt>
    <dd><p>To connect your worker nodes and apps to an on-prem data center, you can configure a VPN IPSec endpoint with a strongSwan service, a Virtual Router Appliance or Fortigate Security Appliance.</p>
    <ul><li><b>strongSwan IPSec VPN Service</b>: You can set up a [strongSwan IPSec VPN service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/) that securely connects your Kubernetes cluster with an on-premises network. The strongSwan IPSec VPN service provides a secure end-to-end communication channel over the internet that is based on the industry-standard Internet Protocol Security (IPSec) protocol suite. To set up a secure connection between your cluster and an on-premises network, [configure and deploy the strongSwan IPSec VPN service](cs_vpn.html#vpn-setup) directly in a pod in your cluster.
    </li>
    <li><b>Virtual Router Appliance (VRA) or Fortigate Security Appliance (FSA)</b>: You might choose to set up a [VRA](/docs/infrastructure/virtual-router-appliance/about.html) or [FSA](/docs/infrastructure/fortigate-10g/about.html) to configure an IPSec VPN endpoint. This option is useful when you have a larger cluster, want to access non-Kubernetes resources over the VPN, or want to access multiple clusters over a single VPN. To configure a VRA, see [Setting up VPN connectivity with VRA](cs_vpn.html#vyatta).</li></ul></dd>

  <dt>Continuous monitoring and logging of cluster activity</dt>
    <dd>For standard clusters, all cluster-related events can be logged and sent to {{site.data.keyword.loganalysislong_notm}} and {{site.data.keyword.monitoringlong_notm}}. These events include adding a worker node, rolling update progress, or capacity usage information. You can [configure cluster logging](/docs/containers/cs_health.html#logging) and [cluster monitoring](/docs/containers/cs_health.html#view_metrics) to decide on the events that you want to monitor. </dd>
</dl>

<br />


## Images
{: #images}

Manage the security and integrity of your images with built-in security features.
{: shortdesc}

<dl>
<dt>Secured Docker private image repository in {{site.data.keyword.registryshort_notm}}</dt>
  <dd>Set up your own Docker image repository in a multi-tenant, highly available, and scalable private image registry that is hosted and managed by IBM. By using the registry, you can build, securely store, and share Docker images across cluster users.
  <p>Learn more about [securing your personal information](cs_secure.html#pi) when you work with container images.</p></dd>
<dt>Image security compliance</dt>
  <dd>When you use {{site.data.keyword.registryshort_notm}}, you can leverage the built-in security scanning that is provided by Vulnerability Advisor. Every image that is pushed to your namespace is automatically scanned for vulnerabilities against a database of known CentOS, Debian, Red Hat, and Ubuntu issues. If vulnerabilities are found, Vulnerability Advisor provides instructions for how to resolve them to assure image integrity and security.</dd>
</dl>

To view the vulnerability assessment for your images, [review the Vulnerability Advisor documentation](/docs/services/va/va_index.html#va_registry_cli).

<br />


## In-cluster networking
{: #in_cluster_network}

Secured, in-cluster network communication between worker nodes and pods is realized with private virtual local area networks (VLANs). A VLAN configures a group of worker nodes and pods as if they were attached to the same physical wire.
{:shortdesc}

When you create a cluster, every cluster is automatically connected to a private VLAN. The private VLAN determines the private IP address that is assigned to a worker node during cluster creation.

|Cluster type|Manager of the private VLAN for the cluster|
|------------|-------------------------------------------|
|Free clusters in {{site.data.keyword.Bluemix_notm}}|{{site.data.keyword.IBM_notm}}|
|Standard clusters in {{site.data.keyword.Bluemix_notm}}|You in your IBM Cloud infrastructure (SoftLayer) account <p>**Tip:** To have access to all VLANs in your account, turn on [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning).</p>|
{: caption="Managers of private VLANs" caption-side="top"}

All pods that are deployed to a worker node are also assigned a private IP address. Pods are assigned an IP in the 172.30.0.0/16 private address range and are routed between worker nodes only. To avoid conflicts, do not use this IP range on any nodes that communicate with your worker nodes. Worker nodes and pods can securely communicate on the private network by using the private IP addresses. However, when a pod crashes or a worker node needs to be re-created, a new private IP address is assigned.

By default, it is difficult to track changing private IP addresses for apps that must be highly available. To avoid that, you can use the built-in Kubernetes service discovery features and expose apps as cluster IP services on the private network. A Kubernetes service groups a set of pods and provides a network connection to these pods for other services in the cluster without exposing the actual private IP address of each pod. When you create a cluster IP service, a private IP address is assigned to that service from the 10.10.10.0/24 private address range. As with the pod private address range, do not use this IP range on any nodes that communicate with your worker nodes. This IP address is accessible inside the cluster only. You cannot access this IP address from the internet. At the same time, a DNS lookup entry is created for the service and stored in the kube-dns component of the cluster. The DNS entry contains the name of the service, the namespace where the service was created, and the link to the assigned private cluster IP address.

To access a pod behind a cluster IP service, the app can either use the private cluster IP address of the service or send a request by using the name of the service. When you use the name of the service, the name is looked up in the kube-dns component and routed to the private cluster IP address of the service. When a request reaches the service, the service ensures that all requests are equally forwarded to the pods, independent of their private IP addresses and the worker node they are deployed to.

For more information about how to create a service of type cluster IP, see [Kubernetes services ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services---service-types).

To securely connect apps in a Kubernetes cluster to an on-premises network, see [Setting up VPN connectivity](cs_vpn.html#vpn). To expose your apps for external network communication, see [Allowing public access to apps](cs_network_planning.html#public_access).


<br />


## Cluster trust
{: cs_trust}

By default, {{site.data.keyword.containerlong_notm}} provides many [features for your cluster components](#cluster) so that you can deploy your containerized apps in a security-rich environment. Extend your level of trust in your cluster to better ensure that what happens within your cluster is what you intended to happen. You can implement trust in your cluster in various ways, as shown in the following diagram.
{:shortdesc}

![Deploying containers with trusted content](images/trusted_story.png)

1.  **{{site.data.keyword.containerlong_notm}} with Trusted Compute**: On bare metal clusters, you can enable trust. The trust agent monitors the hardware startup process and reports any changes so that you can verify your bare metal worker nodes against tampering. With Trusted Compute, you can deploy your containers on verified bare metal hosts so that your workloads run on trusted hardware. Note that some bare metal machines, such as GPU, do not support Trusted Compute. [Learn more about how Trusted Compute works](#trusted_compute).

2.  **Content Trust for your images**: Ensure the integrity of your images by enabling content trust in your {{site.data.keyword.registryshort_notm}}. With trusted content, you can control who can sign images as trusted. After trusted signers push an image to your registry, users can pull the signed content so that they can verify the source of the image. For more information, see [Signing images for trusted content](/docs/services/Registry/registry_trusted_content.html#registry_trustedcontent).

3.  **Container Image Security Enforcement (beta)**: Create an admission controller with custom policies so that you can verify container images before you deploy them. With Container Image Security Enforcement, you control where the images are deployed from and ensure that they meet [Vulnerability Advisor](/docs/services/va/va_index.html) policies or [content trust](/docs/services/Registry/registry_trusted_content.html#registry_trustedcontent) requirements. If a deployment does not meet the policies that you set, security enforcement prevents modifications to your cluster. For more information, see [Enforcing container image security (beta)](/docs/services/Registry/registry_security_enforce.html#security_enforce).

4.  **Container Vulnerability Scanner**: By default, Vulnerability Advisor scans images that are stored in {{site.data.keyword.registryshort_notm}}. To check the status of live containers that are running in your cluster, you can install the container scanner. For more information, see [Installing the container scanner](/docs/services/va/va_index.html#va_install_livescan).

5.  **Network analytics with Security Advisor (preview)**: With {{site.data.keyword.Bluemix_notm}} Security Advisor, you can centralize security insights from {{site.data.keyword.Bluemix_notm}} services such as Vulnerability Advisor and {{site.data.keyword.cloudcerts_short}}. When you enable Security Advisor in your cluster, you can view reports about suspicious incoming and outgoing network traffic. For more information, see [Network Analytics](/docs/services/security-advisor/network-analytics.html#network-analytics). To install, see [Setting up monitoring of suspicious clients and server IP addresses for a Kubernetes cluster](/docs/services/security-advisor/setup_cluster.html).

6.  **{{site.data.keyword.cloudcerts_long_notm}} (beta)**: If you have a cluster in US South and want to [expose your app by using a custom domain with TLS](https://console.bluemix.net/docs/containers/cs_ingress.html#ingress_expose_public), you can store your TLS certificate in {{site.data.keyword.cloudcerts_short}}. Expired or about-to-expire certificates can also reported in your Security Advisor dashboard. For more information, see [Getting started with {{site.data.keyword.cloudcerts_short}}](/docs/services/certificate-manager/index.html#gettingstarted).

<br />


## Storing personal information
{: #pi}

You are responsible for ensuring the security of your personal information in Kubernetes resources and container images. Personal information includes your name, address, phone number, email address, or other information that might identify, contact, or locate you, your customers, or anyone else.
{: shortdesc}

<dl>
  <dt>Use a Kubernetes secret to store personal information</dt>
  <dd>Only store personal information in Kubernetes resources that are designed to hold personal information. For example, do not use your name in the name of a Kubernetes namespace, deployment, service, or config map. For proper protection and encryption, store personal information in <a href="cs_app.html#secrets">Kubernetes secrets</a> instead.</dd>

  <dt>Use a Kubernetes `imagePullSecret` to store image registry credentials</dt>
  <dd>Do not store personal information in container images or registry namespaces. For proper protection and encryption, store registry credentials in <a href="cs_images.html#other">Kubernetes imagePullSecrets</a> and other personal information in <a href="cs_app.html#secrets">Kubernetes secrets</a> instead. Remember that if personal information is stored in a previous layer of an image, deleting an image might not be sufficient to delete this personal information.</dd>
  </dl>

<br />





      <li>ResourceQuota</li>
      <li>ServiceAccount</li>
      <li>StorageObjectInUseProtection (Kubernetes 1.10 and later)</li>
      <li>ValidatingAdmissionWebhook (Kubernetes 1.9 and later)</li></ul></br>
      You can [install your own admission controllers in the cluster ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/admin/extensible-admission-controllers/#admission-webhooks) or choose from the admission controllers that {{site.data.keyword.containershort_notm}} provides: <ul><li><strong>[Container image security enforcer](/docs/services/Registry/registry_security_enforce.html#security_enforce):</strong> Use this admission controller to enforce Vulnerability Advisor policies in your cluster to block deployments from vulnerable images.</li></ul></br><strong>Note: </strong> If you manually installed admission controllers and you do not want to use them anymore, make sure to remove them entirely. If admission controllers are not entirely removed, they might block all actions that you want to perform on the cluster. </td>
    </tr>
  </tbody>
</table>

## Worker node
{: #workernodes}

Worker nodes carry the deployments and services that make up your app. When you host workloads in the public cloud, you want to ensure that your app is protected from being accessed, changed or monitored by an unauthorized user or software.
{: shortdesc}

**Who owns the worker node and am I responsible to secure it?** </br>
The ownership of a worker node depends on the type of cluster that you create. Worker nodes in free clusters are provisioned in to the IBM Cloud infrastructure (SoftLayer) account that is owned by IBM. You can deploy apps to the worker node but cannot change settings or install extra software on the worker node. Free clusters are removed automatically by {{site.data.keyword.containershort_notm}} after 21 days. </br> </br>
Worker nodes in standard clusters are provisioned in to the IBM Cloud infrastructure (SoftLayer) account that is associated with your public or dedicated {{site.data.keyword.Bluemix_notm}} account. The worker nodes are owned by you and you are responsible to keep your worker nodes up-to-date to ensure that the worker node OS and {{site.data.keyword.containershort_notm}} components apply that latest security updates and patches. </br></br><strong>Important: </strong>Use the <code>bx cs worker-update</code> [command](cs_cli_reference.html#cs_worker_update) regularly (such as monthly) to deploy updates and security patches to the operating system and to update the Kubernetes version. When updates are available, you are notified when you view information about the worker nodes, such as with the <code>bx cs workers <cluster_name></code> or <code>bx cs worker-get <cluster_name> <worker_ID></code> commands.

**How does my worker node setup look like?**</br>
The following image shows the components that are set up for every worker node to protect your worker node from malicious attacks. </br></br>
**Note:** The image does not include components that ensure secure end-to-end communication to and from the worker node. See [network security](#network) for more information.

<img src="images/cs_worker_setup.png" width="600" alt="Worker node setup (excluding network security" style="width:600px; border-style: none"/>

<table>
<caption>Worker node security setup</caption>
  <thead>
  <th>Security feature</th>
  <th>Description</th>
  </thead>
  <tbody>
    <tr><td>CIS compliant Linux image</td><td>Every worker node is set up with an Ubuntu operating system that implements the benchmarks that are published by the Center of Internet Security (CIS). The Ubuntu operating system cannot be changed by the user or the owner of the machine. IBM works with internal and external security advisory teams to address potential security compliance vulnerabilities. Security updates and patches for the operating system are made available through {{site.data.keyword.containershort_notm}} and must be installed by the user to keep the worker node secure. </br></br><strong>Note: </strong>Because the operating system of the worker node is Ubuntu, all containers deployed to the worker node must be based on a Linux distribution that uses the Ubuntu kernel. Linux distributions that talk to the kernel in a different way cannot be deployed.</td></tr>
    <tr>
  <td>Compute isolation</td>
  <td>Worker nodes are dedicated to a cluster and do not host workloads of other clusters. When you create a standard cluster, you can choose to provision your worker nodes as [physical machines (bare metal) or as virtual machines](cs_clusters.html#planning_worker_nodes) that run on shared or dedicated physical hardware. The worker node in a free cluster is automatically provisioned as a virtual, shared node in the IBM Cloud infrastructure (SoftLayer) account that is owned by IBM.</td>
</tr>
<tr>
<td>Option to deploy bare metal</td>
<td>If you choose to provision your worker nodes on bare metal physical servers (instead of virtual server instances), you have additional control over the compute host, such as the memory or CPU. This setup eliminates the virtual machine hypervisor that allocates physical resources to virtual machines that run on the host. Instead, all of a bare metal machine's resources are dedicated exclusively to the worker, so you don't need to worry about "noisy neighbors" sharing resources or slowing down performance. Bare metal servers are dedicated to you, with all its resources available for cluster usage.</td>
</tr>
<tr>
  <td id="trusted_compute">Option for Trusted Compute</td>
    <td>When you deploy your cluster on bare metal that supports Trusted Compute, you can [enable trust](cs_cli_reference.html#cs_cluster_feature_enable). The Trusted Platform Module (TPM) chip is enabled on each bare metal worker node in the cluster that supports Trusted Compute (including future nodes that you add to the cluster). Therefore, after you enable trust, you cannot later disable it for the cluster. A trust server is deployed on the master node, and a trust agent is deployed as a pod on the worker node. When your worker node starts up, the trust agent pod monitors each stage of the process.<p>The hardware is at the root of trust, which sends measurements by using the TPM. TPM generates encryption keys that are used for securing the transmission of the measurement data throughout the process. The trust agent passes along to the trust server the measurement of each component in the startup process: from the BIOS firmware that interacts with the TPM hardware to the bootloader and OS kernel. Then, the trusted agent compares these measurements with the expected values in the trusted server to attest whether the startup was valid. The trusted compute process does not monitor other pods in your worker nodes, such as applications.</p><p>For example, if an unauthorized user gains access to your system and modifies the OS kernel with extra logic to collect data, the trust agent detects this change and marks the node's as untrusted With trusted compute, you can verify your worker nodes against tampering.</p>
    <p><strong>Note</strong>: Trusted Compute is available for select bare metal machine types. For example, `mgXc` GPU flavors do not support Trusted Compute.</p>
    <p><img src="images/trusted_compute.png" alt="Trusted Compute for bare metal clusters" width="480" style="width:480px; border-style: none"/></p></td>
  </tr>
    <tr>
  <td>Encrypted disks</td>
    <td>By default, every worker node is provisioned with two local SSD encrypted data partitions. The first partition is not encrypted, and the second partition is unlocked by using LUKS encryption keys. Each worker in each Kubernetes cluster has its own unique LUKS encryption key, managed by {{site.data.keyword.containershort_notm}}. When you create a cluster or add a worker node to an existing cluster, the keys are pulled securely and then discarded after the encrypted disk is unlocked.</br></br><strong>Note: </strong>Encryption can impact disk I/O performance. For workloads that require high-performance disk I/O, test a cluster with encryption both enabled and disabled to help you decide whether to turn off encryption.</td>
      </tr>
    <tr>
      <td>Expert AppArmor policies</td>
      <td>Every worker node is set up with security and access policies that are enforced by [AppArmor [![External link icon](../icons/launch-glyph.svg "External link icon")](https://wiki.ubuntu.com/AppArmor) profiles that are loaded into the worker node during bootstrapping. AppArmor profiles cannot be changed by the user or owner of the machine. </td>
    </tr>
    <tr>
      <td>SSH disabled</td>
      <td>By default, SSH access is disabled on the worker node to protect your cluster from malicious attacks. When SSH access is disabled, access to the cluster is forced via the Kubernetes API server. The Kubernetes API server requires every request to be checked against the policies that are set in the authentication, authorization, and admission control module before the request is executed in the cluster. </br></br>  If you have a standard cluster and you want to install more features on your worker node, you can choose between the add-ons that are provided by {{site.data.keyword.containershort_notm}} or use [Kubernetes daemon sets [![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) for everything that you want to run on every worker node. For any one-time action that you must execute, use [Kubernetes jobs [![External link icon](../icons/launch-glyph.svg "External link icon")]](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/).</td>
    </tr>
  </tbody>
  </table>

## Network
{: #network}
The classic approach to protect a company's network is to set up a firewall and block any unwanted network traffic to your apps. While this is still true, researches show that a lot of malicious attacks come from insiders or authorized users who misuse their assigned permissions.
{: shortdesc}

To protect your network and limit the range of damage that a user can do when access to a network is granted, you must make sure that your workloads are as isolated as possible and that you limit the number of apps and worker nodes that are publicly exposed.

**What network traffic is allowed for my cluster by default?**</br>
All containers are protected by [predefined Calico network policy settings](cs_network_policy.html#default_policy) that are configured on every worker node during cluster creation. By default, all outbound network traffic is allowed for all worker nodes. Inbound network traffic is blocked with the exception of a few ports that are opened so that network traffic can be monitored by IBM and for IBM to automatically install security updates for the Kubernetes master. Access to the worker node's kubelet is secured by an OpenVPN tunnel. For more information, see the [{{site.data.keyword.containershort_notm}} architecture](cs_tech.html).

If you want to allow incoming network traffic from the internet, you must expose your apps with a [NodePort service, a LoadBalancer service, or an Ingress application load balancer](cs_network_planning.html#planning).  

**What is network segmentation and how can I set it up for a cluster?** </br>
Network segmentation describes the approach to divide a network into multiple sub-networks. You can group apps and related data to be accessed by a specific group in your organization. Apps that run in one sub-network cannot see or access apps in another sub-network. Network segmentation also limits the access that is provided to an insider or third party software and can limit the range of malicious activities.   

{{site.data.keyword.containershort_notm}} provides IBM Cloud infrastructure (SoftLayer) VLANs that ensure quality network performance and network isolation for worker nodes. A VLAN configures a group of worker nodes and pods as if they were attached to the same physical wire. VLANs are dedicated to your {{site.data.keyword.Bluemix_notm}} account and not shared across IBM customers. However, if you want to use multiple subnets or multiple VLANs in a cluster, for example in a multizone cluster, you must enable [VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) so that worker nodes can see and talk to each other.

VLAN spanning is an {{site.data.keyword.Bluemix_notm}} account setting and can be either turned on or off. When turned on, all clusters in your account can see and talk to each other. While this might be useful for some scenarios, VLAN spanning removes network segmentation for your clusters.

Review the following table to see your options for how to achieve network segmentation when VLAN spanning is turned on.

|Security feature|Description|
|-------|----------------------------------|
|Set up custom network policies with Calico|You can use the built-in Calico interface to [set up custom Calico network policies](cs_network_policy.html#network_policies) for your worker nodes. For example, you can allow or block network traffic on specific network interfaces, for specific pods, or services. To set up custom network policies, you must [install the <code>calicoctl</code> CLI](cs_network_policy.html#cli_install).|
|Support for IBM Cloud infrastructure (SoftLayer) network firewalls|{{site.data.keyword.containershort_notm}} is compatible with all [IBM Cloud infrastructure (SoftLayer) firewall offerings ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/network-security). On {{site.data.keyword.Bluemix_notm}} Public, you can set up a firewall with custom network policies to provide dedicated network security for your standard cluster and to detect and remediate network intrusion. For example, you might choose to set up a [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html) to act as your firewall and block unwanted traffic. When you set up a firewall, [you must also open up the required ports and IP addresses](cs_firewall.html#firewall) for each region so that the master and the worker nodes can communicate.|
{: caption="Network segmentation options" caption-side="top"}

**Can I use security groups to manage my cluster's network traffic?** </br>
To use Ingress and LoadBalancer services, use [Calico and Kubernetes policies](cs_network_policy.html) to manage network traffic into and out of your cluster. Do not use IBM Cloud infrastructure (SoftLayer) [security groups](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups). IBM Cloud infrastructure (SoftLayer) security groups are applied to the network interface of a single virtual server to filter traffic at the hypervisor level. However, security groups do not support the VRRP protocol, which {{site.data.keyword.containershort_notm}} uses to manage the master virtual IP address (VIP). If the VRRP protocol is not present to manage the master VIP, Ingress and LoadBalancer services do not work properly. If you are not using Ingress or LoadBalancer services and want to completely isolate your worker node from the public, you can use security groups.

**What else can I do to reduce the surface for external attacks?**</br>
The more apps or worker nodes that you expose publicly, the bigger the surface for external malicious attacks. Review the following table to find options for how to keep apps and worker nodes private.

|Security feature|Description|
|-------|----------------------------------|
|Limit the number of exposed apps|You can choose to keep your services and apps private and leverage the built-in security features to assure secured communication between worker nodes and pods. To expose services and apps to the public internet, you can leverage the [Ingress and load balancer support](cs_network_planning.html#planning) to securely make your services publicly available. Ensure that only necessary services are exposed, and re-visit the list of exposed apps on a regular basis to ensure that they are still valid. |
|Keep worker nodes private|When you create a cluster, every cluster is automatically connected to a private VLAN. The private VLAN determines the private IP address that is assigned to a worker node. You can choose to keep your worker nodes private by connecting them to a private VLAN only. Private VLANs in free clusters are managed by IBM, and private VLANs in standard clusters are managed by you in your IBM Cloud infrastructure (SoftLayer) account. </br></br>Keep in mind that in order to communicate with the Kubernetes master and for {{site.data.keyword.containershort_notm}} to properly function, you must configure public connectivity to [specific URLs and IP addresses](cs_firewall.html#firewall_outbound). To set up this public connectivity, you can configure a firewall, such as a [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html), in front of your worker nodes and enable network traffic to these URLs and IP addresses.|
|Limit public internet connectivity with edge node|By default, every worker node is configured to accept app pods and associated load balancer or ingress pods. You can label worker nodes as [edge nodes](cs_edge.html#edge) to force load balancer and ingress pods to be deployed to these worker nodes only. In addition, you can [taint your worker nodes](cs_edge.html#edge_workloads) so that app pods cannot schedule onto the edge nodes. With edge nodes, you can isolate the networking workload in your cluster and keep other worker nodes in the cluster private.|
{: caption="Private services and worker node options" caption-side="top"}

**What if I want to connect my cluster to an on-prem data center?**</br>
To connect your worker nodes and apps to an on-prem data center, you can configure a VPN IPSec endpoint with a strongSwan service, a Virtual Router Appliance, or with a Fortigate Security Appliance.

- **strongSwan IPSec VPN Service**: You can set up a [strongSwan IPSec VPN service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/) that securely connects your Kubernetes cluster with an on-premises network. The strongSwan IPSec VPN service provides a secure end-to-end communication channel over the internet that is based on the industry-standard Internet Protocol Security (IPSec) protocol suite. To set up a secure connection between your cluster and an on-premises network, [configure and deploy the strongSwan IPSec VPN service](cs_vpn.html#vpn-setup) directly in a pod in your cluster.

- **Virtual Router Appliance (VRA) or Fortigate Security Appliance (FSA)**: You might choose to set up a [VRA](/docs/infrastructure/virtual-router-appliance/about.html) or [FSA](/docs/infrastructure/fortigate-10g/about.html) to configure an IPSec VPN endpoint. This option is useful when you have a larger cluster, want to access non-Kubernetes resources over the VPN, or want to access multiple clusters over a single VPN. To configure a VRA, see [Setting up VPN connectivity with VRA](cs_vpn.html#vyatta).

## Persistent storage
{: #storage}

When you provision persistent storage to store data in your cluster, your data is automatically encrypted at no additional cost when it is stored in your file share or block storage. The encryption includes snapshots and replicated storage.
{: shortdesc}

For more information about how data is encrypted for the specific storage type, see the following links.
- [NFS file storage](/docs/infrastructure/FileStorage/block-file-storage-encryption-rest.html#securing-your-data-provider-managed-encryption-at-rest)
- [Block storage](/docs/infrastructure/BlockStorage/block-file-storage-encryption-rest.html#securing-your-data-provider-managed-encryption-at-rest)

## Monitoring and logging
{: #monitoring_logging}

The key to detect malicious attacks in your cluster is the proper monitoring and logging of all the events that happen in the cluster. Monitoring and logging can also help you understand the cluster capacity and availability of resources for your app so that you can plan accordingly to protect your apps from a downtime.
{: shortdesc}

**Does IBM monitor my cluster?**</br>
Every Kubernetes master is continuously monitored by IBM to control and remediate process level Denial-Of-Service (DOS) attacks. {{site.data.keyword.containershort_notm}} automatically scans every node where the Kubernetes master is deployed for vulnerabilities that are found in Kubernetes and OS-specific security fixes. If vulnerabilities are found, {{site.data.keyword.containershort_notm}} automatically applies fixes and resolves vulnerabilities on behalf of the user to ensure master node protection.  

**What information is logged?**</br>
For standard clusters, you can [set up log forwarding](/docs/containers/cs_health.html#logging) for all cluster-related events from different sources to {{site.data.keyword.loganalysislong_notm}} or to another external server so that you can filter and analyze your logs. These sources include logs from:

- **Containers**: Logs that are written to STDOUT or STDERR.
- **Apps**: Logs that are written to a specific path inside your app.
- **Workers**: Logs from the Ubuntu operating system that are sent to /var/log/syslog and /var/log/auth.log.
- **Kubernetes API server**: Every cluster-related action that is sent to the Kubernetes API server is logged for auditing reasons, including the time, the user, and the affected resource. For more information, see [Kubernetes audit logs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/)
- **Kubernetes system components**: Logs from the `kubelet`, the `kube-proxy`, and other components that run in the `kube-system` namespace.
- **Ingress**: Logs for an Ingress application load balancer that manages the network traffic that comes into a cluster.

You can choose what events you want to log for your cluster and where you want to forward your logs to. To detect malicious activities and to verify the health of your cluster, you must continuously analyze your logs.

**How can I monitor the health and performance of my cluster?**</br>
You can verify the capacity and performance of your cluster by monitoring your cluster components and compute resources, such as CPU and memory usage. {{site.data.keyword.containershort_notm}} automatically sends metrics for standard clusters to {{site.data.keyword.monitoringlong}} so that you can [see and analyze them in Grafana](cs_health.html#view_metrics).

You can also use built-in tools, such as the {{site.data.keyword.containershort_notm}} details page, the Kubernetes dashboard, or [set up third party integrations](cs_integrations.html#logging-and-monitoring-services), such as Prometheus, Weavescope, and others.

**What are my options to enable trust in my cluster?** </br>
By default, {{site.data.keyword.containershort_notm}} provides many features for your cluster components so that you can deploy your containerized apps in a security-rich environment. Extend your level of trust in your cluster to better ensure that what happens within your cluster is what you intended to happen. You can implement trust in your cluster in various ways, as shown in the following diagram.

![Deploying containers with trusted content](images/trusted_story.png)

1.  **{{site.data.keyword.containerlong_notm}} with Trusted Compute**: On bare metal clusters, you can enable trust. The trust agent monitors the hardware startup process and reports any changes so that you can verify your bare metal worker nodes against tampering. With Trusted Compute, you can deploy your containers on verified bare metal hosts so that your workloads run on trusted hardware. Note that some bare metal machines, such as GPU, do not support Trusted Compute. [Learn more about how Trusted Compute works](#trusted_compute).

2.  **Content Trust for your images**: Ensure the integrity of your images by enabling content trust in your {{site.data.keyword.registryshort_notm}}. With trusted content, you can control who can sign images as trusted. After trusted signers push an image to your registry, users can pull the signed content so that they can verify the source of the image. For more information, see [Signing images for trusted content](/docs/services/Registry/registry_trusted_content.html#registry_trustedcontent).

3.  **Container Image Security Enforcement (beta)**: Create an admission controller with custom policies so that you can verify container images before you deploy them. With Container Image Security Enforcement, you control where the images are deployed from and ensure that they meet [Vulnerability Advisor](/docs/services/va/va_index.html) policies or [content trust](/docs/services/Registry/registry_trusted_content.html#registry_trustedcontent) requirements. If a deployment does not meet the policies that you set, security enforcement prevents modifications to your cluster. For more information, see [Enforcing container image security (beta)](/docs/services/Registry/registry_security_enforce.html#security_enforce).

4.  **Container Vulnerability Scanner**: By default, Vulnerability Advisor scans images that are stored in {{site.data.keyword.registryshort_notm}}. To check the status of live containers that are running in your cluster, you can install the container scanner. For more information, see [Installing the container scanner](/docs/services/va/va_index.html#va_install_livescan).

5.  **Network analytics with Security Advisor (preview)**: With {{site.data.keyword.Bluemix_notm}} Security Advisor, you can centralize security insights from {{site.data.keyword.Bluemix_notm}} services such as Vulnerability Advisor and {{site.data.keyword.cloudcerts_short}}. When you enable Security Advisor in your cluster, you can view reports about suspicious incoming and outgoing network traffic. For more information, see [Network Analytics](/docs/services/security-advisor/network-analytics.html#network-analytics). To install, see [Setting up monitoring of suspicious clients and server IP addresses for a Kubernetes cluster](/docs/services/security-advisor/setup_cluster.html).

6.  **{{site.data.keyword.cloudcerts_long_notm}} (beta)**: If you have a cluster in US South and want to [expose your app by using a custom domain with TLS](https://console.bluemix.net/docs/containers/cs_ingress.html#ingress_expose_public), you can store your TLS certificate in {{site.data.keyword.cloudcerts_short}}. Expired or about-to-expire certificates can also reported in your Security Advisor dashboard. For more information, see [Getting started with {{site.data.keyword.cloudcerts_short}}](/docs/services/certificate-manager/index.html#gettingstarted).


## Image and registry
{: #images_registry}

Every deployment is based on an image that holds the instructions for how to spin up the container that runs your app. These instructions include the operating system inside the container and extra software that you want to install. To protect your app, you must protect the image and establish checks the ensure the image's integrity.
{: shortdesc}

**Should I use a public or a private registry to store my images?** </br>
Public registries, such as Docker Hub, can be used to get started with Docker and Kubernetes to create your first containerized app in a cluster. But when it comes to enterprise applications, avoid registries that you don't know or don't trust to protect your cluster from malicious images. Keep your images in a private registry, like the one provided in {{site.data.keyword.registryshort_notm}} and make sure to control access to the registry and the image content that can be pushed.

**Why is it important to check images against vulnerabilities?** </br>
Researches show that 80% of malicious attacks leverage known software vulnerabilities and weak system configurations. When you deploy a container from an image, the container spins up with the OS and extra binaries that you described in the image. Just like you protect your virtual or physical machine, you must eliminate known vulnerabilities in the OS and binaries that you use inside the container to protect your app from being accessed by unauthorized users. </br>

To protect your apps, consider establishing a process within your team to address the following areas:

1. **Scan images before they deploy into production:** </br>
Make sure to scan every image before you deploy a container from it. If vulnerabilities are found, consider eliminating the vulnerabilities or block deployment for those images. Establish a process where the content of the image must be approved and where you can only deploy images that pass the vulnerability checks.

2. **Regularly scan running containers:** </br>
Even if you deployed a container from an image that passes the vulnerability check, the operating system or binaries that run in the container might get vulnerable over time. To protect your app, you must ensure that running containers are regularly scanned so that you can detect and remediate vulnerabilities. Depending on the app, to add extra security, you can establish a process that takes down vulnerable containers after they are detected.

**How can {{site.data.keyword.registryshort_notm}} help me to protect my images and deployment process?**  

![Deploying containers with trusted content](images/cs_image_security.png)

<table>
<caption>Security for images and deployments</caption>
  <thead>
    <th>Security feature</th>
    <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td>Secured Docker private image repository in {{site.data.keyword.registryshort_notm}}</td>
      <td>Set up your own Docker [image repository](/docs/services/Registry/index.html#index) in a multi-tenant, highly available, and scalable private image registry that is hosted and managed by IBM. By using the registry, you can build, securely store, and share Docker images across cluster users. </br></br>Learn more about [securing your personal information](cs_secure.html#pi) when you work with container images.</td>
    </tr>
    <tr>
      <td>Push images with trusted content only</td>
      <td>Ensure the integrity of your images by enabling [content trust](/docs/services/Registry/registry_trusted_content.html#registry_trustedcontent) in your image repository. With trusted content, you can control who can sign images as trusted and push images to a specific registry namespace. After trusted signers push an image to a registry namespace, users can pull the signed content so that they can verify the publisher and the integrity of the image.</td>
    </tr>
    <tr>
      <td>Automatic vulnerability scans</td>
      <td>When you use {{site.data.keyword.registryshort_notm}}, you can leverage the built-in security scanning that is provided by [Vulnerability Advisor](/docs/services/va/va_index.html#va_registry_cli). Every image that is pushed to your registry namespace is automatically scanned for vulnerabilities against a database of known CentOS, Debian, Red Hat, and Ubuntu issues. If vulnerabilities are found, Vulnerability Advisor provides instructions for how to resolve them to assure image integrity and security.</td>
    </tr>
    <tr>
      <td>Block deployments from vulnerable images or untrusted users</td>
      <td>Create an admission controller with custom policies so that you can verify container images before you deploy them. With [Container Image Security Enforcement](/docs/services/Registry/registry_security_enforce.html#security_enforce), you control where the images are deployed from and ensure that they meet Vulnerability Advisor policies or content trust requirements. If a deployment does not meet the policies that you set, the admission controller blocks the deployment in your cluster.</td>
    </tr>
    <tr>
      <td>Live scan for containers</td>
      <td>In order to detect vulnerabilities in running containers, you can install the [ibmcloud-container-scanner](/docs/services/va/va_index.html#va_install_livescan). Similar to the images, you can set up the live scanner to monitor the containers for vulnerabilities in all cluster namespaces. When vulnerabilities are found, update the source image and re-deploy the container.</td>
    </tr>
  </tbody>
  </table>


## Container isolation and security
{: #container}

**What is a Kubernetes namespace and why should I use it?** </br>
Kubernetes namespaces are a way to virtually partition a cluster and provide isolation for your deployments and the groups of users that want to move their workload onto the cluster.

Every cluster is set up with the following namespaces:
- **default:** The namespace where everything is deployed to that does not define a specific namespace. When you assign the Viewer, Editor, or Operator platform role to a user, the user can access the default namespace, but not the `kube-system`, `ibm-system`, or `ibm-cloud-cert` namespaces.
- **kube-system and ibm-system:** This namespace holds deployments and services that are required for Kubernetes and {{site.data.keyword.containerlong_notm}} to manage the cluster. Cluster admins can use this namespace to make a Kubernetes resource available across namespaces.
- **ibm-cloud-cert:** This namespace is used for resources that are related to {{site.data.keyword.cloudcerts_long_notm}}.
- **kube-public:** This namespace can be accessed by all users, even if they are not authenticated with the cluster. Be cautious to deploy resources into this namespace as you might be putting your cluster at risk to get compromised.

Cluster admins can set up additional namespaces in the cluster and customize them to their needs. </br></br>
**Important:** For every namespace that you have in the cluster, make sure to set up proper [RBAC policies](cs_users.html#rbac) to limit access to this namespace, control what gets deployed, and to set proper [resource quotas ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/resource-quotas/) and [limit ranges ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/memory-default-namespace/).  

**Should I set up a single-tenant or a multi-tenant cluster?** </br>
In a single-tenant cluster, you create one cluster for every group of people that must run workloads in a cluster. Usually, this team is responsible to manage the cluster and to properly configure and secure it. Multi-tenant clusters use multiple namespaces to isolate tenants and their workloads.

<img src="images/cs_single_multitenant.png" width="600" alt="Single tenant vs. multi-tenant cluster" style="width:600px; border-style: none"/>

Single-tenant and multi-tenant clusters provide the same level of isolation for your workloads and come with roughly the same costs. The option that is right for you depends on the number of teams that must run workloads in a cluster, their service requirements, and the size of the service.

A single-tenant cluster might be your option if you have a lot of teams with complex services that each must have control over the lifecycle of the cluster. This includes having the freedom to decide when a cluster is updated or what resources can be deployed to the cluster. Keep in mind that managing a cluster requires in-depth Kubernetes and infrastructure knowledge to ensure cluster capacity and security for your deployments.  

Multi-tenant clusters come with the advantage that you can use the same service name in different namespaces which might come in handy when you plan to use namespaces to separate your prod, staging, and dev environment. While multi-tenant clusters usually require less people to manage and administer the cluster, they often add more complexity in the following areas:

- **Access:** When you set up multiple namespaces, you must configure proper RBAC policies for each namespace to ensure resource isolation. RBAC policies are complex and require in-depth Kubernetes knowledge.
- **Compute resource limitation:** To ensure that every team has the necessary resources to deploy services and run apps in the cluster, you must set up [resource quotas ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/resource-quotas/) for every namespace. Resource quotas determine the number of Kubernetes resources that you can deploy, and the amount of CPU and memory that can be consumed by those resources.
- **Shared cluster resources:** If you run multiple tenants in one cluster, some cluster resources, such as the Ingress application load balancer or available portable IP addresses are shared across tenants. Smaller services might have a hard time using shared resources if they must compete against large services in the cluster.
- **Updates:** You can run one Kubernetes API version at a time only. All apps that run in a cluster must comply with the current Kubernetes API version independent of the team that owns the app. When you want to update a cluster, you must ensure that all teams are ready to switch to a new Kubernetes API version and that apps are updated to work with the new Kubernetes API version. This also means that individual teams have less control over the Kubernetes API version they want to run.
- **Changes in cluster setup:** If you want to change the cluster setup or migrate to new worker nodes, you must roll out this change across tenants. This roll out requires more reconciliation and testing than in a single-tenant cluster.
- **Communication process:** When you manage multiple tenants, consider setting up a communication process so that tenants know where to go when an issue with the cluster exists, or when they need more resources for their services. This communication process also includes informing your tenants about all changes in the cluster setup or planned updates.

**What else can I do to protect my container?**

|Security feature|Description|
|-------|----------------------------------|
|Limit the number of privileged containers|Containers run as a separate Linux process on the compute host that is isolated from other processes. Although users have root access inside the container, the permissions of this user are limited outside the container to protect other Linux processes, the host file system, and host devices. Some apps require access to the host file system or advanced permissions to run properly. You can run containers in privileged mode to allow the container the same access as the processes running on the compute host. </br></br> <strong>Important: </strong>Keep in mind that privileged containers can cause huge damage to the cluster and the underlying compute host when they get compromised. Try to limit the number of containers that run in privileged mode and consider to change the configuration for your app so that the app can run without advanced permissions.|
|Set CPU and memory limits for containers|Every container requires a specific amount of CPU and memory to properly start and to continue to run. You can define [Kubernetes resource requests and resource limits ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) for your containers to limit the amount of CPU and memory that the container can consume. If no limits for CPU and memory are set, and the container is busy, the container uses all the resources that are available. This high consumption of resources might affect other containers on the worker node that do not have enough resources to properly start or run, and puts your worker node at risk for denial-of-service attacks.|
|Apply OS security settings to pods|You can add the [<code>securityContext</code> section ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) to your pod deployment to apply Linux-specific security settings to the pod or a specific container inside the pod. Security settings include the control over the user ID and group ID that runs scripts inside the container, such as the entrypoint script, or the user ID and group IP that own the volume mount path. </br></br><strong>Tip:</strong> If you want to use <code>securityContext</code> to set the <code>runAsUser</code> user ID or <code>fsGroup</code> group ID, consider using block storage when you [create persistent storage](cs_storage.html#create). NFS storage does not support <code>fsGroup</code>, and <code>runAsUser</code> must be set at the container level, not the pod level. |
{: caption="Other security protections" caption-side="top"}

## Storing personal information
{: #pi}

You are responsible for ensuring the security of your personal information in Kubernetes resources and container images. Personal information includes your name, address, phone number, email address, or other information that might identify, contact, or locate you, your customers, or anyone else.
{: shortdesc}

<dl>
  <dt>Use a Kubernetes secret to store personal information</dt>
  <dd>Only store personal information in Kubernetes resources that are designed to hold personal information. For example, do not use your name in the name of a Kubernetes namespace, deployment, service, or config map. For proper protection and encryption, store personal information in <a href="cs_app.html#secrets">Kubernetes secrets</a> instead.</dd>

  <dt>Use a Kubernetes `imagePullSecret` to store image registry credentials</dt>
  <dd>Do not store personal information in container images or registry namespaces. For proper protection and encryption, store registry credentials in <a href="cs_images.html#other">Kubernetes imagePullSecrets</a> and other personal information in <a href="cs_app.html#secrets">Kubernetes secrets</a> instead. Remember that if personal information is stored in a previous layer of an image, deleting an image might not be sufficient to delete this personal information.</dd>
  </dl>

</staging>
