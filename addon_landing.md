---

copyright:
years: 2025, 2025
lastupdated: "2025-03-28"


keywords:  


subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Add-ons for {{site.data.keyword.containerlong_notm}}
{: #addons}

Review the managed add-ons available for {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

|Add-on name | Description | Information and change log |
|---|---|---|
| Autoscaler | Automatically scale the worker pools in your cluster based on the sizing needs of your scheduled workloads. | - [Preparing classic and VPC clusters for autoscaling](/docs/containers?topic=containers-cluster-scaling-classic-vpc)  \n - [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog) | 
| ALB OAuth Proxy | Creates and manages the following Kubernetes resources: an OAuth2-Proxy deployment for your App ID service instance, a secret that contains the configuration of the OAuth2-Proxy deployment, and an Ingress resource that configures ALBs to route incoming requests to the OAuth2-Proxy deployment for your App ID instance. | - [Adding App ID authentication to apps](/docs/containers?topic=containers-comm-ingress-annotations#app-id-auth)  \n - [ALB OAuth Proxy add-on version change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy) |
| Back up and restore Helm chart | Create a one-time or scheduled backup for data that is stored in a file storage or block storage persistent volume claim (PVC). | - [Backing up and restoring PVC data for file and block storage](/docs/containers?topic=containers-utilities#ibmcloud-backup-restore)  \n - [Back up and restore Helm chart change log](/docs/containers?topic=containers-backup_restore_changelog) |
| IBM Cloud Object Storage plug-in | Set up pre-defined storage classes for IBM Cloud Object Storage and use these storage classes to create a PVC to provision storage for your apps. | - [Installing the IBM Cloud Object Storage plug-in](/docs/containers?topic=containers-storage_cos_install)  \n - [IBM Cloud Object Storage plug-in change log](/docs/containers?topic=containers-cos_plugin_changelog) |
| IBM Storage Operator |  Manage several storage configmaps and resources in your cluster. This add-on is installed by default in VPC clusters that run version 1.30 or later. | - [Enabling the IBM Storage Operator](/docs/containers?topic=containers-storage-operator)  \n - [IBM Storage Operator add-on version change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator) |
| Istio | An open service mesh platform to connect, secure, control, and observe microservices on cloud platforms. The Istio add-on is offered as a managed service that integrates Istio directly with your cluster. | [- Setting up the Istio managed add-on](/docs/containers?topic=containers-istio)  \n - [Istio add-on change log](/docs/containers?topic=containers-istio) | 
| Static Route |  Create static routes that allow worker nodes to re-route response packets through a VPN or gateway to an IP address in an on-premises data center. | - [Adding static routes to worker nodes](/docs/containers?topic=containers-static-routes)  \n - [Static Route add-on version change log](/docs/containers?topic=containers-cl-add-ons-static-route) |
| VPC Block CSI Driver | Copy a storage volume's contents at a particular point in time without creating an entirely new volume. | - [Setting up snapshots with the Block Storage for VPC cluster add-on](/docs/containers?topic=containers-vpc-volume-snapshot)  \n - [VPC Block CSI Driver add-on version change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) | 
| VPC File CSI Driver | Create persistent volume claims for fast and flexible network-attached, NFS-based File Storage for VPC. | -[Enabling the IBM Cloud File Storage for VPC cluster add-on](/docs/containers?topic=containers-storage-file-vpc-install)  \n - [VPC File CSI Driver add-on version change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver) |
