---

copyright: 
  years: 2014, 2025
lastupdated: "2025-10-16"


keywords: kubernetes, responsibilities, incident, operations, change, security, regulation, disaster recovery, management, RACI

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# Your responsibilities with using {{site.data.keyword.containerlong_notm}}
{: #responsibilities_iks}
{: help}
{: support}

Learn about cluster management responsibilities that you have when you use {{site.data.keyword.containerlong}}. For overall terms of use, see [Cloud Services terms](/docs/overview?topic=overview-terms).
{: shortdesc}

## Overview of shared responsibilities
{: #overview-by-resource}

{{site.data.keyword.containerlong_notm}} is a managed service in the [{{site.data.keyword.cloud_notm}} shared responsibility model](/docs/overview?topic=overview-shared-responsibilities). Review the following table of who is responsible for particular cloud resources when using {{site.data.keyword.containerlong_notm}}. Then, you can view more granular tasks for shared responsibilities in [Tasks for shared responsibilities by area](#task-responsibilities).
{: shortdesc}

If you use other {{site.data.keyword.cloud_notm}} products such as {{site.data.keyword.cos_short}}, responsibilities that are marked as yours in the following table, such as disaster recovery for Data, might be IBM's or shared. Consult those products' documentation for your responsibilities.
{: note}

| Resource | [Incident and operations management](#incident-and-ops) | [Change management](#change-management) | [Identity and access management](#iam-responsibilities) | [Security and regulation compliance](#security-compliance) | [Disaster Recovery](#disaster-recovery) |
| - | - | - | - | - | - |
| [Data](#applications-and-data) | You | You | You | You | You |
| [Applications](#applications-and-data) | You | You | You | You | You |
| Observability | [Shared](#incident-and-ops) | {{site.data.keyword.IBM_notm}} | [Shared](#iam-responsibilities) | {{site.data.keyword.IBM_notm}} | IBM |
| App networking | [Shared](#incident-and-ops) | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | IBM |
| Cluster networking | [Shared](#incident-and-ops) | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | IBM |
| Cluster version | {{site.data.keyword.IBM_notm}} | [Shared](#change-management) | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Worker nodes | [Shared](#incident-and-ops) | [Shared](#change-management) | {{site.data.keyword.IBM_notm}} | [Shared](#security-compliance) | {{site.data.keyword.IBM_notm}} |
| Master | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Service | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Virtual storage | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Virtual network | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Hypervisor | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Physical servers and memory | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Physical storage | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Physical network and devices | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
| Facilities and Data Centers | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} | {{site.data.keyword.IBM_notm}} |
{: caption="Responsibilities by resource." caption-side="bottom"}

## Tasks for shared responsibilities by area
{: #task-responsibilities}

After reviewing the [overview](#overview-by-resource), see what tasks you and IBM share responsibility for each area and resource when you use {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

### Incident and operations management
{: #incident-and-ops}

You and IBM share responsibilities for the set up and maintenance of your {{site.data.keyword.containerlong_notm}} cluster environment for your application workloads. You are responsible for incident and operations management of your application data.
{: shortdesc}

| Resource | IBM responsibilities | Your responsibilities |
| -------- | -------------------- | --------------------- |
| Worker nodes | - Deploy a fully managed, highly available dedicated master in a secured, IBM-owned infrastructure account for each cluster. \n - Provision worker nodes in your IBM Cloud infrastructure account. \n - Ensure that worker nodes successfully provision when the user account and permissions are correctly set up, and sufficient quota exists. \n - Fulfill requests for more infrastructure, such as adding, reloading, updating, and removing worker nodes. \n - Provide tools, such as the [cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-install-addon), to extend your cluster infrastructure. \n - Integrate ordered infrastructure resources to work automatically with your cluster architecture and become available to your deployed apps and workloads. \n - Fulfill automation requests to help recover worker nodes. |- Use the provided API, CLI, or console tools to adjust compute and storage capacity to meet the needs of your workload. \n - Use the provided API, CLI, or console tools to request that worker nodes are rebooted, reloaded, or replaced, and troubleshoot issues such as when the worker nodes are in an [unhealthy state](/docs/containers?topic=containers-debug_worker_nodes). |
| Cluster networking | - Set up cluster management components, such as public or private cloud service endpoints, VLANs, and load balancers. \n - Fulfill requests for more infrastructure, such as attaching worker nodes to existing VLANs or subnets upon resizing a worker pool. \n - Create clusters with subnet IP addresses reserved to use to expose apps externally. \n - Set up a Konnectivity connection between the master and worker nodes when the cluster is created. \n - Provide the ability to set up a VPN connection with on-premises resources such as through the strongSwan IPSec VPN service or the {{site.data.keyword.vpc_short}} VPN. \n - Provide the ability to isolate network traffic with edge nodes. | - Use the provided API, CLI, or console tools to adjust [cluster networking configuration](/docs/containers?topic=containers-cs_network_cluster) to meet the needs of your workload, such as configuring service endpoints, adding VLANs to provide IP addresses for more worker nodes, setting up a VPN connection, or edge node worker pools. |
| App networking | - Set up a public application load balancer (ALB) that is multizone, if applicable. Provide the ability to set up private ALBs and public or private network load balancers (NLBs). \n - Support native Kubernetes public and private load balancers and Ingress routes for exposing services externally. \n - Install Calico as the container networking interface, and set up default Calico network policies to control basic cluster traffic. | - Set up any additional app networking capabilities that are needed, such as private ALBs, public or private NLBs, or additional Calico network policies.|
| Observability | - Provide {{site.data.keyword.logs_full_notm}} and {{site.data.keyword.mon_short}} as managed add-ons to enable observability of your cluster and container environments. Maintenance is simplified for you because IBM provides the installation and updates for the managed add-ons. \n - Provide cluster integration with {{site.data.keyword.logs_full_notm}} and send {{site.data.keyword.containerlong_notm}} API events for auditability. | - [Set up and monitor the health](/docs/containers?topic=containers-health) of your container logs and cluster metrics. \n - Set up and, if applicable, [configure `kube-audit` logs](/docs/containers?topic=containers-health-audit) to be sent to [{{site.data.keyword.logs_full_notm}}](/docs/containers?topic=containers-at_events_ref).|
{: caption="Responsibilities for incident and operations management" caption-side="bottom"}



### Change management
{: #change-management}

You and IBM share responsibilities for keeping your clusters at the latest container platform and operating system versions, along with recovering infrastructure resources that might require changes. You are responsible for change management of your application data.
{: shortdesc}

| Resource | IBM responsibilities | Your responsibilities |
| -------- | -------------------- | --------------------- |
| Worker nodes | - Provide worker node patch operating system (OS), version, and security updates. \n - Fulfill automation requests to update and recover worker nodes. | - Use the API, CLI, or console tools to [apply](/docs/containers?topic=containers-update#update) the provided worker node updates that include operating system patches; or to request that worker nodes are rebooted, reloaded, or replaced. |
| Cluster version | - Provide a suite of tools to automate cluster management, such as the {{site.data.keyword.containerlong_notm}} [API](https://cloud.ibm.com/apidocs/kubernetes/containers-v1-v2){: external}, [CLI plug-in](/docs/containers?topic=containers-kubernetes-service-cli), and [console](https://cloud.ibm.com/kubernetes/clusters){: external}. \n - Automatically apply Kubernetes master patch OS, version, and security updates. \n - Make major and minor updates for master nodes available for you to apply. \n - Provide worker node major, minor, and patch OS, version, and security updates. \n - Fulfill automation requests to update cluster master and worker nodes. | - Use the API, CLI, or console tools to [apply](/docs/containers?topic=containers-update#update) the provided major and minor Kubernetes master updates and major, minor, and patch worker node updates. |
{: caption="Responsibilities for change management" caption-side="bottom"}



### Identity and access management
{: #iam-responsibilities}

You and IBM share responsibilities for controlling access to your {{site.data.keyword.containerlong_notm}} instances. For {{site.data.keyword.iamlong}} responsibilities, consult that product's documentation. You are responsible for identity and access management to your application data.
{: shortdesc}

| Resource | IBM responsibilities | Your responsibilities |
| -------- | -------------------- | --------------------- |
| Observability | - Provide the ability to integrate {{site.data.keyword.logs_full_notm}} with your cluster to audit the actions that users take in the cluster. | - Set up {{site.data.keyword.logs_full_notm}} or other capabilities to track user activity in the cluster. |
{: caption="Responsibilities for identity and access management" caption-side="bottom"}



### Security and regulation compliance
{: #security-compliance}

IBM is responsible for the security and compliance of {{site.data.keyword.containerlong_notm}}. Compliance to industry standards varies depending on the infrastructure provider that you use for the cluster, such as classic or VPC. You are responsible for the security and compliance of any workloads that run in the cluster and your application data. For more information, see [What standards does the service comply to?](/docs/containers?topic=containers-faqs#standards).
{: shortdesc}

| Resource | IBM responsibilities | Your responsibilities |
| -------- | -------------------- | --------------------- |
| General | - Maintain controls commensurate to [various industry compliance standards](/docs/containers?topic=containers-update#update), such as PCI DSS. Compliance to industry standards varies depending on the infrastructure provider of the cluster, such as classic or VPC. \n - Monitor, isolate, and recover the cluster master. \n - Provide highly available replicas of the Kubernetes master API server, etcd, scheduler, and controller manager components to protect against a master outage. \n - Provide options for cluster network connectivity, such as public and private cloud service endpoints. \n - Provide options for compute isolation, such as dedicated virtual machines or bare metal. \n - Integrate Kubernetes role-based access control (RBAC) with {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM). | - Set up and maintain security and regulation compliance for your apps and data. For example, choose how to set up your [classic cluster networking](/docs/containers?topic=containers-cluster-create-classic) or [VPC cluster networking](/docs/containers?topic=containers-cluster-create-vpc-gen2), [protect sensitive information](/docs/containers?topic=containers-encryption) such as with {{site.data.keyword.keymanagementservicelong_notm}} encryption, and configure further [security settings](/docs/containers?topic=containers-security#security) to meet your workload's security and compliance needs. If applicable, configure your [firewall](/docs/containers?topic=containers-firewall#firewall).  |
| Worker nodes | - Monitor and report the health of the master and worker nodes in the various interfaces.  \n - Automatically apply master security patch updates, and provide worker node security patch updates. \n - Enable certain security settings, such as encrypted disks on worker nodes \n - Disable certain insecure actions for worker nodes, such as not permitting users to SSH into the host. \n - Encrypt communication between the master and worker nodes with TLS. \n - Provide CIS-compliant Linux images for worker node operating systems. \n - Continuously monitor master and worker node images to detect vulnerability and security compliance issues. \n - Provider-managed encryption is enabled by default on all volumes.| As part of your incident and operations management responsibilities for the worker nodes, apply the provided security patch updates.  \n - Optionally configure bring your own key encryption for worker node volumes. |
{: caption="Responsibilities for security and regulation compliance" caption-side="bottom"}



### Disaster recovery
{: #disaster-recovery}

IBM is responsible for the recovery of {{site.data.keyword.containerlong_notm}} components in case of disaster. You are responsible for the recovery of the workloads that run the cluster and your application data. If you integrate with other {{site.data.keyword.cloud_notm}} services such as file, block, object, cloud database, logging, or audit event services, consult those services' disaster recovery information.
{: shortdesc}

| Resource | IBM responsibilities | Your responsibilities |
| -------- | -------------------- | --------------------- |
| General | - Maintain service availability across [worldwide locations](/docs/containers?topic=containers-regions-and-zones) so that customers can deploy clusters across zones and regions for higher DR tolerance. \n - Provision clusters with three replicas of master components for high availability. \n - In multizone regions, automatically spread the master replicas across zones. \n - Continuously monitor to work to ensure the reliability and availability of the service environment by site reliability engineers. \n - Update and recover operational {{site.data.keyword.containerlong_notm}} and Kubernetes components within the cluster, such as the Ingress application load balancer and file storage plug-in. \n - Back up and recover data in etcd, such as your Kubernetes workload configuration files \n - Provide the optional [worker node Autorecovery](/docs/containers?topic=containers-health-monitor#autorecovery). \n - Provide the ability to integrate with other {{site.data.keyword.cloud_notm}} services such as storage providers so that data can be backed up and restored. | - Set up and maintain disaster recovery capabilities for your apps and data. For example, to prepare your cluster for HA/DR scenarios, follow the guidance in [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-strategy). Note that persistent storage of data such as application logs and cluster metrics are not set up by default.  |
{: caption="Responsibilities for disaster recovery" caption-side="bottom"}

### Applications and data
{: #applications-and-data}

You are completely responsible for the applications, workloads, and data that you deploy to {{site.data.keyword.cloud_notm}}. However, IBM provides various tools to help you set up, manage, secure, integrate and optimize your apps as described in the following table.
{: shortdesc}

| Resource | How IBM helps | What you can do |
| -------- | -------------------- | --------------------- |
| Applications  |- Provision clusters with Kubernetes components installed so that you can access the Kubernetes API to deploy and manage your containerized apps. \n - Provide a number of managed add-ons to extend your app's capabilities, such as [Istio](/docs/containers?topic=containers-istio) or the Diagnostics and Debug Tool. Maintenance is simplified for you because IBM provides the installation and updates for the managed add-ons. \n - Provide cluster integration with select third-party partnership technologies, such as {{site.data.keyword.logs_full_notm}}, {{site.data.keyword.mon_short}}, and Portworx. \n - Provide automation to enable service binding to other {{site.data.keyword.cloud_notm}} services. \n - Create clusters with image pull secrets so that your deployments in the `default` Kubernetes namespace can pull images from {{site.data.keyword.registrylong_notm}}. \n - Provide access to Kubernetes APIs that you can use to set up Operators to add community, third-party, and your own services to your cluster. Note that Operators might not work without manual adjustments such as changes in cluster security policies. \n - Provide storage classes and plug-ins to support persistent volumes for use with your apps. \n - Automatically configure security settings to prevent insecure access, such as disabling SSH into the worker node compute hosts. \n - Automatically integrate {{site.data.keyword.cloud_notm}} IAM service access roles with Kubernetes RBAC roles in the cluster. \n - Generate an API key that is used to access infrastructure permissions for each resource group and region. | - Maintain responsibility for your apps, data, and their complete lifecycle. \n - If you add community, third-party, your own, or other services to your cluster such as by using Operators, you are responsible for these services and for working with the appropriate provider to troubleshoot any issues. \n - Use the provided tools and features to [configure and deploy](/docs/containers?topic=containers-app); [keep up-to-date](/docs/containers?topic=containers-update_app#app_rolling); [set up resource requests and limits](/docs/containers?topic=containers-app#resourcereq); [size your worker pool](/docs/containers?topic=containers-strategy) to have enough resources to run your apps; [set up permissions](/docs/containers?topic=containers-iam-platform-access-roles); [integrate with other services](/docs/containers?topic=containers-supported_integrations#supported_integrations); [externally serve](/docs/containers?topic=containers-cs_network_planning#cs_network_planning); [save, back up, and restore data](/docs/containers?topic=containers-storage-plan); and otherwise manage your [highly available](/docs/containers?topic=containers-strategy) and resilient workloads.  \n - Some managed add-on operators allow you to control how updates are applied. If you choose to manually apply the updates, you receive notifications when an update is available, then you must promptly complete the manual update. If you choose to have updates applied automatically, you receive notifications, but the updates are automatically applied. There is no roll-back capability, so make sure to choose your update strategy carefully. |
| Data | - Maintain [platform-level standards](/docs/overview?topic=overview-security) so that your data can be stored with controls commensurate to leading international security compliance standards. \n - Provision clusters with Kubernetes components installed so that you can access the Kubernetes API to help manage your app data, such as with secrets and configmaps. \n - Integrate with {{site.data.keyword.cloud_notm}} services that you can use to store and manage your data, such as {{site.data.keyword.cloud_notm}} Databases or {{site.data.keyword.cos_short}}. \n - Integrate with {{site.data.keyword.ibmwatson_notm}} services that you can use to maximize the insights and use of your data with the latest artificial intelligence technology.| - Maintain responsibility for your data and how your apps consume the data. |
{: caption="Applications and data" caption-side="bottom"}
