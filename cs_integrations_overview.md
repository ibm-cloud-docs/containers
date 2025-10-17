---

copyright:
  years: 2014, 2025
lastupdated: "2025-10-17"


keywords: kubernetes, helm

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Supported IBM Cloud and third-party integrations
{: #supported_integrations}

You can use various {{site.data.keyword.IBM}}, {{site.data.keyword.cloud}}, and external services with your {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}

## Popular integrations
{: #popular_services}

|Service|Category|Description|Classic|VPC|
|----|----|------|----|--- |
| {{site.data.keyword.appid_full_notm}} |Authentication|Add a level of security to your apps with [{{site.data.keyword.appid_short}}](/docs/appid?topic=appid-getting-started) by requiring users to sign in. To authenticate web or API HTTP or HTTPS requests to your app, you can integrate {{site.data.keyword.appid_short_notm}} with your Ingress service by using the [{{site.data.keyword.appid_short_notm}} authentication Ingress annotation](/docs/containers?topic=containers-comm-ingress-annotations#app-id-auth).|Yes|Yes|
|{{site.data.keyword.cloud_notm}} Classic Block Storage|Block storage|[{{site.data.keyword.cloud_notm}} Block Storage](/docs/BlockStorage?topic=BlockStorage-getting-started#getting-started) is persistent, high-performance iSCSI storage that you can add to your apps by using Kubernetes persistent volumes (PVs). Use block storage to deploy stateful apps in a single zone or as high-performance storage for single pods. For more information about how to provision block storage in your cluster, see [Setting up {{site.data.keyword.cloud_notm}} Block Storage](/docs/containers?topic=containers-block_storage#block_storage)|Yes| |
|{{site.data.keyword.block_storage_is_short}}|Block storage|[{{site.data.keyword.block_storage_is_short}}](/docs/vpc?topic=vpc-creating-block-storage) provides hypervisor-mounted, high-performance data storage for your virtual server instances that you provision within a VPC cluster. For more information about how to provision VPC Block Storage in your cluster, see [Setting up {{site.data.keyword.block_storage_is_short}}](/docs/containers?topic=containers-vpc-block)|  |Yes|
| {{site.data.keyword.codeenginefull_notm}} | Serverless | {{site.data.keyword.codeengineshort}} is a fully managed, serverless platform that runs your containerized workloads, including web apps, micro-services, event-driven functions, or batch jobs. {{site.data.keyword.codeengineshort}} even builds container images for you from your source code. Because these workloads are all hosted within the same Kubernetes infrastructure, all them can seamlessly work together. For more information, see [Getting started with {{site.data.keyword.codeenginefull_notm}}](/docs/codeengine). |
|{{site.data.keyword.registrylong_notm}}|Container images|Set up your own secured Docker image repository where you can safely store and share images between cluster users. For more information, see the [{{site.data.keyword.registrylong}} documentation](/docs/Registry?topic=Registry-getting-started){: external}.|Yes|Yes|
|{{site.data.keyword.cloud_notm}} {{site.data.keyword.contdelivery_short}}|Build automation|Automate your app builds and container deployments to Kubernetes clusters by using a toolchain. For more information about the setup, see [working with Tekton pipelines](/docs/ContinuousDelivery?topic=ContinuousDelivery-tekton-pipelines){: external}.|Yes|Yes|
| {{site.data.keyword.filestorage_short}} |File storage| NFS-based file storage that you can add to your apps by using Kubernetes persistent volumes. You can choose between predefined storage tiers with GB sizes and IOPS that meet the requirements of your workloads. |Yes| |
|{{site.data.keyword.keymanagementservicefull_notm}}|Data encryption|Encrypt the Kubernetes secrets that are in your cluster by [enabling  a key management service (KMS) provider](/docs/containers?topic=containers-encryption-setup). Encrypting your Kubernetes secrets prevents unauthorized users from accessing sensitive cluster information.|Yes|Yes|
|{{site.data.keyword.logs_full_notm}}|Cluster and app logs|Add log management capabilities to your cluster by deploying an {{site.data.keyword.logs_full_notm}} agent to your worker nodes to manage logs from your pod containers. For more information, see [Managing Kubernetes cluster logs with {{site.data.keyword.logs_full_notm}}](/docs/cloud-logs?topic=cloud-logs-agent-helm-kube-deploy).|Yes|Yes|
|{{site.data.keyword.mon_full_notm}}|Cluster and app metrics|Gain operational visibility into the performance and health of your apps by deploying an {{site.data.keyword.mon_full_notm}} agent to your worker nodes to forward metrics to {{site.data.keyword.mon_full}}. For more information, see [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/monitoring?topic=monitoring-kubernetes_cluster#kubernetes_cluster).|Yes|Yes|
|{{site.data.keyword.cos_full_notm}}|Object storage|Data that is stored with {{site.data.keyword.cos_short}} is encrypted and dispersed across multiple geographic regions, and accessed over HTTP by using a REST API. You can use the [ibm-backup-restore image](/docs/containers?topic=containers-utilities#ibmcloud-backup-restore) to configure the service to make one-time or scheduled backups for data in your clusters. For more information about the service, see the [{{site.data.keyword.cos_short}} documentation](/docs/cloud-object-storage?topic=cloud-object-storage-getting-started-cloud-object-storage){: external}.|Yes|Yes|
|Istio on {{site.data.keyword.containerlong_notm}}|Microservice management|[Istio](https://www.ibm.com/products/istio){: external} is an open source service that gives developers a way to connect, secure, manage, and monitor a network of microservices, also known as a service mesh, on cloud orchestration platforms. Istio on {{site.data.keyword.containerlong}} provides a one-step installation of Istio into your cluster through a managed add-on. With one click, you can get all Istio core components, additional tracing, monitoring, and visualization up and running. To get started, see [Using the managed Istio add-on](/docs/containers?topic=containers-istio).|Yes|Yes|
|Portworx|Storage for stateful apps|[Portworx](https://portworx.com/products/portworx-enterprise){: external} is a highly available software-defined storage solution that you can use to manage persistent storage for your containerized databases and other stateful apps, or to share data between pods across multiple zones. You can install Portworx with a Helm chart and provision storage for your apps by using Kubernetes persistent volumes. For more information about how to set up Portworx in your cluster, see [Setting up software-defined storage (SDS) with Portworx](/docs/containers?topic=containers-storage_portworx_about).|Yes|Yes|
|{{site.data.keyword.secrets-manager_full_notm}}| Ingress secrets and certificates| You can use {{site.data.keyword.secrets-manager_short}} to store and manage your Ingress secrets and certificates. For more information, see [Setting up {{site.data.keyword.secrets-manager_short}} in your Kubernetes Service cluster](/docs/containers?topic=containers-secrets-mgr).|Yes|Yes|
|{{site.data.keyword.bplong_notm}}/ Terraform|Infrastructure and {{site.data.keyword.cloud_notm}} service automation|Terraform is an open-source software that enables predictable and consistent provisioning of {{site.data.keyword.cloud_notm}} platform, classic infrastructure, and VPC infrastructure resources by using a high-level scripting language. {{site.data.keyword.bplong_notm}} delivers Terraform-as-a-Service so that you can model the resources that you want in your {{site.data.keyword.cloud_notm}} environment, and enable Infrastructure as Code (IaC). For more information about how to use native Terraform to create a cluster, see [Creating single and multizone Kubernetes and {{site.data.keyword.redhat_openshift_notm}} clusters](/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-tutorial-tf-clusters).|Yes|Yes|
{: caption="Popular integrations" caption-side="bottom"}


## DevOps services
{: #devops_services}

|Service|Description|Classic|VPC|
|----|------------|----|----|
|CloudBees Unify |You can use [CloudBees Unify](https://www.cloudbees.com/capabilities/ci-cd-workflows){: external} for the continuous integration and delivery of containers.|Yes|Yes|
|Grafeas|[Grafeas](https://grafeas.io){: external} is an open source CI/CD service that provides a common way for how to retrieve, store, and exchange metadata during the software supply chain process. For example, if you integrate Grafeas into your app build process, Grafeas can store information about the initiator of the build request, vulnerability scan results, and quality assurance sign-off so that you can make an informed decision if an app can be deployed to production. You can use this metadata in audits or to prove compliance for your software supply chain.|Yes|Yes|
|Helm|[Helm](https://helm.sh){: external} is a Kubernetes package manager. You can create new Helm charts or use preexisting Helm charts to define, install, and upgrade complex Kubernetes applications that run in {{site.data.keyword.containerlong_notm}} clusters. For more information, see [Setting up Helm in {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-helm).|Yes|Yes|
|{{site.data.keyword.cloud_notm}} {{site.data.keyword.contdelivery_short}}|Automate your app builds and container deployments to Kubernetes clusters by using a toolchain. For more information about the setup, see [working with Tekton pipelines](/docs/ContinuousDelivery?topic=ContinuousDelivery-tekton-pipelines).|Yes|Yes|
|Istio on {{site.data.keyword.containerlong_notm}}|[Istio](https://www.ibm.com/products/istio){: external} is an open source service that gives developers a way to connect, secure, manage, and monitor a network of microservices, also known as a service mesh, on cloud orchestration platforms. Istio on {{site.data.keyword.containerlong}} provides a one-step installation of Istio into your cluster through a managed add-on. With one click, you can get all Istio core components, additional tracing, monitoring, and visualization up and running. To get started, see [Using the managed Istio add-on](/docs/containers?topic=containers-istio)|Yes|Yes|
|Jenkins X|Jenkins X is a Kubernetes-native continuous integration and continuous delivery platform that you can use to automate your build process. For more information, see the [Jenkins X documentation](https://jenkins-x.io/v3/){: external}.| | |
|{{site.data.keyword.bplong_notm}}|[{{site.data.keyword.bplong_notm}}](/docs/schematics?topic=schematics-getting-started) is a managed Terraform service where you can use native Terraform capabilities, but you don't have to worry about setting up and maintaining the Terraform CLI and {{site.data.keyword.cloud_notm}} Provider plug-in. For more information about how to use Terraform to create a cluster, see [Creating single and multizone Kubernetes and {{site.data.keyword.redhat_openshift_notm}} clusters](/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-tutorial-tf-clusters).|Yes|Yes|
|Terraform|[Terraform](https://developer.hashicorp.com/terraform/docs){: external} is an open-source software that enables predictable and consistent provisioning of {{site.data.keyword.cloud_notm}} platform, classic infrastructure, and VPC infrastructure resources by using a high-level scripting language. For more information about how to use native Terraform to create a cluster, see [Creating single and multizone Kubernetes and {{site.data.keyword.redhat_openshift_notm}} clusters](/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-tutorial-tf-clusters).|Yes|Yes|
{: caption="DevOps services" caption-side="bottom"}



## Hybrid cloud services
{: #hybrid_cloud_services}

|Service|Description|Classic|VPC|
|----|------------|----|----|
| {{site.data.keyword.vpc_short}} VPN | With the {{site.data.keyword.vpc_short}} VPN, you can securely connect your VPC to an on-premises network, other VPCs, or to classic infrastructure through a VPN tunnel. For more information, see [Connecting to your on-premises network](/docs/vpc?topic=vpc-vpn-onprem-example).| |Yes|
|{{site.data.keyword.dl_short}}|With [{{site.data.keyword.dl_full}}](/docs/dl?topic=dl-dl-about), you can create a direct, private connection between your remote network environments and {{site.data.keyword.containerlong_notm}} without routing over the public internet. The {{site.data.keyword.dl_short}} offerings are useful when you must implement hybrid workloads, cross-provider workloads, large or frequent data transfers, or private workloads. To choose a {{site.data.keyword.dl_short}} offering and set up a {{site.data.keyword.dl_short}} connection, see [Get Started with {{site.data.keyword.dl_full_notm}} (2.0)](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl).|Yes|Yes|
|strongSwan IPSec VPN Service|Set up a [strongSwan IPSec VPN service](https://www.strongswan.org/about.html){: external} that securely connects your Kubernetes cluster with an on-premises network. The strongSwan IPSec VPN service provides a secure end-to-end communication channel over the internet that is based on the industry-standard Internet Protocol Security (IPSec) protocol suite. To set up a secure connection between your cluster and an on-premises network, [configure and deploy the strongSwan IPSec VPN service](/docs/containers?topic=containers-vpn#vpn-setup) directly in a pod in your cluster.|Yes| |
|{{site.data.keyword.tg_short}}|Use {{site.data.keyword.tg_full_notm}} to manage access between your VPCs. {{site.data.keyword.tg_short}} instances can be configured to route between VPCs that are in the same region (local routing) or VPCs that are in different regions (global routing). Additionally, you can use {{site.data.keyword.tg_short}} to manage access between your VPCs in multiple regions to resources in your {{site.data.keyword.cloud_notm}} classic infrastructure. To get started, see the [{{site.data.keyword.tg_short}} documentation](/docs/transit-gateway?topic=transit-gateway-getting-started).| |Yes|
{: caption="Hybrid cloud services" caption-side="bottom"}



## Logging and monitoring services
{: #health_services}

|Service|Description|Classic|VPC|
|----|------------|----|----|
|CoScale|Monitor worker nodes, containers, replica sets, replication controllers, and services with [CoScale](https://newrelic.com/blog/nerd-life/coscale){: external}.|Yes|Yes|
|Datadog|Monitor your cluster and view infrastructure and application performance metrics with [Datadog](https://www.datadoghq.com/){: external}.|Yes|Yes|
|{{site.data.keyword.logs_full_notm}}|Add log management capabilities to your cluster by deploying an {{site.data.keyword.logs_full_notm}} agent to your worker nodes to manage logs from your pod containers. For more information, see [Managing Kubernetes cluster logs with {{site.data.keyword.logs_full_notm}}](/docs/cloud-logs?topic=cloud-logs-agent-helm-kube-deploy).|Yes|Yes|
|{{site.data.keyword.mon_full_notm}}|Gain operational visibility into the performance and health of your apps by deploying a {{site.data.keyword.mon_short}} agent to your worker nodes to forward metrics to {{site.data.keyword.mon_full}}. For more information, see [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/monitoring?topic=monitoring-kubernetes_cluster#kubernetes_cluster).|Yes|Yes|
| Instana |Instana provides infrastructure and app performance monitoring with a GUI that automatically discovers and maps your apps. Instana captures every request to your apps, which you can use to troubleshoot and perform root cause analysis to prevent the problems from happening again. For more information, see the [Instana product page](https://www.ibm.com/products/instana){: external} |Yes|Yes|
|Prometheus|Prometheus is an open source monitoring, logging, and alerting tool that was designed for Kubernetes. Prometheus retrieves detailed information about the cluster, worker nodes, and deployment health based on Kubernetes logging information. CPU, memory, I/O, and network activity is collected for each container that runs in a cluster. You can use the collected data in custom queries or alerts to monitor performance and workloads in your cluster. To use Prometheus, follow the [CoreOS instructions](https://github.com/prometheus-operator/kube-prometheus){: external}.|Yes|Yes|
|Sematext|View metrics and logs for your containerized applications by using [Sematext](https://sematext.com/){: external}.|Yes|Yes|
|Splunk|Import and search your Kubernetes logging, object, and metrics data in Splunk by using Splunk Connect for Kubernetes. Splunk Connect for Kubernetes is a collection of Helm charts that deploy a Splunk-supported deployment of Fluentd to your Kubernetes cluster, a Splunk-built Fluentd HTTP Event Collector (HEC) plug-in to send logs and metadata, and a metrics deployment that captures your cluster metrics.|Yes|Yes|
{: caption="Logging and monitoring services" caption-side="bottom"}




## Security services
{: #security_services}

Want a comprehensive view of how to integrate {{site.data.keyword.cloud_notm}} security services with your cluster? Check out the [Apply end-to-end security to a cloud application tutorial](/docs/solution-tutorials?topic=solution-tutorials-cloud-e2e-security).
{: shortdesc}

|Service|Description|Classic|VPC|
|----|------------|----|----|
|{{site.data.keyword.appid_full_notm}}|Add a level of security to your apps with [{{site.data.keyword.appid_short}}](/docs/appid?topic=appid-getting-started) by requiring users to sign in. To authenticate web or API HTTP/HTTPS requests to your app, you can integrate {{site.data.keyword.appid_short_notm}} with your Ingress service by using the [{{site.data.keyword.appid_short_notm}} authentication Ingress annotation](/docs/containers?topic=containers-comm-ingress-annotations#app-id-auth).|Yes|Yes|
|Aqua Security|As a supplement to [Vulnerability Advisor](/docs/Registry?topic=Registry-va_index){: external}, you can use [Aqua Security](https://www.aquasec.com/){: external} to improve the security of container deployments by reducing what your app is allowed to do.|Yes|Yes|
|{{site.data.keyword.registrylong_notm}}|Set up your own secured Docker image repository where you can safely store and share images between cluster users. For more information, see the [{{site.data.keyword.registrylong}} documentation](/docs/Registry?topic=Registry-getting-started){: external}.|Yes|Yes|
|{{site.data.keyword.keymanagementservicefull_notm}}|Encrypt the Kubernetes secrets that are in your cluster by [enabling a key management service (KMS) provider](/docs/containers?topic=containers-encryption-setup). Encrypting your Kubernetes secrets prevents unauthorized users from accessing sensitive cluster information. |Yes|Yes|
|NeuVector|Protect containers with a cloud-native firewall by using [NeuVector](https://www.suse.com/products/rancher/security/){: external}.|Yes|Yes|
|{{site.data.keyword.secrets-manager_full_notm}}| Ingress secrets and certificates| You can use {{site.data.keyword.secrets-manager_short}} to store and manage your Ingress secrets and certificates. For more information, see [Setting up {{site.data.keyword.secrets-manager_short}} in your Kubernetes Service cluster](/docs/containers?topic=containers-secrets-mgr).|Yes|Yes|
|Twistlock|As a supplement to [Vulnerability Advisor](/docs/Registry?topic=Registry-va_index){: external}, you can use [Twistlock](https://www.paloaltonetworks.com/prisma/cloud){: external} to manage firewalls, threat protection, and incident response.|Yes|Yes|
{: caption="Security services" caption-side="bottom"}




## Storage services
{: #storage_services}

|Service|Description|Classic|VPC|
|----|------------|----|----|
|Heptio Velero|You can use [Heptio Velero](https://github.com/vmware-tanzu/velero){: external} to back up and restore cluster resources and persistent volumes. For more information, see the Heptio Velero [Use cases for disaster recovery and cluster migration](https://github.com/vmware-tanzu/velero/blob/release-0.9/docs/use-cases.md){: external}.|Yes|Yes|
|{{site.data.keyword.cloud_notm}} Classic Block Storage|[{{site.data.keyword.cloud_notm}} Classic Block Storage](/docs/BlockStorage?topic=BlockStorage-getting-started#getting-started) is persistent, high-performance iSCSI storage that you can add to your apps by using Kubernetes persistent volumes (PVs). For more information about how to provision block storage in your cluster, see [Setting up {{site.data.keyword.cloud_notm}} Block Storage](/docs/containers?topic=containers-block_storage#block_storage)|Yes| |
|{{site.data.keyword.block_storage_is_short}}|[{{site.data.keyword.block_storage_is_short}}](/docs/vpc?topic=vpc-creating-block-storage) provides hypervisor-mounted, high-performance data storage for your virtual server instances that you provision within a VPC cluster. For more information about how to provision VPC Block Storage in your cluster, see [Setting up {{site.data.keyword.block_storage_is_short}}](/docs/containers?topic=containers-vpc-block)| |Yes|
|{{site.data.keyword.cos_full_notm}}|Data that is stored with {{site.data.keyword.cos_short}} is encrypted and dispersed across multiple geographic regions, and accessed over HTTP by using a REST API. You can use the [ibm-backup-restore image](/docs/containers?topic=containers-utilities#ibmcloud-backup-restore) to configure the service to make one-time or scheduled backups for data in your clusters. For more information about the service, see the [{{site.data.keyword.cos_short}} documentation](/docs/cloud-object-storage?topic=cloud-object-storage-getting-started-cloud-object-storage){: external}.|Yes|Yes|
|{{site.data.keyword.filestorage_short}}|[{{site.data.keyword.filestorage_short}}](/docs/FileStorage?topic=FileStorage-getting-started#getting-started) is persistent, fast, and flexible network-attached, NFS-based file storage that you can add to your apps by using Kubernetes persistent volumes. You can choose between predefined storage tiers with GB sizes and IOPS that meet the requirements of your workloads. For more information about how to provision file storage in your cluster, see [Setting up {{site.data.keyword.filestorage_short}}](/docs/containers?topic=containers-file_storage#file_storage).|Yes| |
|Portworx|[Portworx](https://portworx.com/products/portworx-enterprise){: external} is a highly available software-defined storage solution that you can use to manage persistent storage for your containerized databases and other stateful apps, or to share data between pods across multiple zones. You can install Portworx with a Helm chart and provision storage for your apps by using Kubernetes persistent volumes. For more information about how to set up Portworx in your cluster, see [Setting up software-defined storage (SDS) with Portworx](/docs/containers?topic=containers-storage_portworx_about).|Yes|Yes|
{: caption="Storage services" caption-side="bottom"}



## Database services
{: #database_services}

|Service|Description|Classic|VPC|
|----|------------|----|----|
|Cloud databases|You can choose between various {{site.data.keyword.cloud_notm}} database services, such as {{site.data.keyword.composeForMongoDB_full}} or {{site.data.keyword.cloudantfull}} to deploy highly available and scalable database solutions in your cluster. For a list of available cloud databases, see the [{{site.data.keyword.cloud_notm}} catalog](https://cloud.ibm.com/catalog?category=databases){: external}.|Yes|Yes|
{: caption="Database services" caption-side="bottom"}
