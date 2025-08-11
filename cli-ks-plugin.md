---

copyright:
  years: 2014, 2025
lastupdated: "2025-08-11"


keywords: containers, cli reference, kubernetes cli, openshift cli, {{site.data.keyword.containerlong_notm}}

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# {{site.data.keyword.containerlong_notm}} CLI reference
{: #kubernetes-service-cli}

Refer to these commands to create and manage **both community Kubernetes or {{site.data.keyword.redhat_openshift_notm}} clusters** in {{site.data.keyword.containerlong}}.
{: shortdesc}

* **Kubernetes**: [Install the Kubernetes CLI plug-in](/docs/containers?topic=containers-cli-install).
* **OpenShift**: [Install the {{site.data.keyword.redhat_openshift_notm}} CLI plug-in](/docs/containers?topic=containers-cli-install).

In the command line, you are notified when updates to the `ibmcloud` CLI and plug-ins are available. Be sure to keep your CLI up-to-date so that you can use all available commands and options.

Looking for `ibmcloud cr` commands? See the [{{site.data.keyword.registrylong_notm}} CLI reference](/docs/Registry?topic=Registry-containerregcli). Looking for `kubectl` commands? See the [Kubernetes documentation](https://kubectl.docs.kubernetes.io/){: external}.
{: tip}


## {{site.data.keyword.containerlong_notm}} commands
{: #cli_commands}

The following tables list the `ibmcloud ks` command groups. For a complete list of all `ibmcloud ks` commands as they are structured in the CLI, see the [{{site.data.keyword.containerlong_notm}} CLI map](/docs/containers?topic=containers-icks_map).
{: shortdesc}

| Command group | Description |
| --- | --- |
| [Cluster commands](#cluster) | Create, view, and modify clusters and cluster settings, such as add-on, subnet, and master settings. |
| [Worker commands](#worker_node_commands) | View and modify worker nodes for a cluster.  |
| [Worker-pool commands](#worker-pool) | View and modify worker pools for a cluster. |
| [Zone commands](#zone) | List availability zones and modify the zones attached to a worker pool. |
| [Ingress commands](#alb-commands) | View and modify Ingress services and settings. | 
| [Logging commands](#logging_commands) | Forward logs from your cluster. | 
| [NLB-DNS commands](#nlb-dns) | Create and manage host names for network load balancer (NLB) IP addresses in a cluster and health check monitors for host names. |
| [Webhook-create commands](#cs_webhook_create) | Register a webhook in a cluster. |
| [API-key commands](#api_key-commands) | View information about the API key for a cluster or reset it to a new key. |
| [Credential commands](#credential) | Set and unset credentials that allow you to access the IBM Cloud classic infrastructure portfolio through your IBM Cloud account. |
| [Infra-permissions commands](#infra-commands) | Check classic IBM Cloud infrastructure permissions that are used in IBM Cloud Kubernetes Service. |
| [KMS commands](#ks_kms) | Enable a key management service (KMS) provider in your cluster to encrypt the etcd component and Kubernetes secrets with a root key that you control. |
| [Quota commands](#cs_quota) | View the quota and limits for cluster-related resources in your IBM Cloud account. |
| [Subnets commands](#cs_subnets) | List available subnets in your IBM Cloud infrastructure account. |
| [VLAN commands](#vlan) | List public and private VLANs for a zone and view the VLAN spanning status.|
| [VPCS commands](#vpc-ls-cli) | List all VPCs in the targeted resource group. If no resource group is targeted, then all VPCs in the account are listed.|
| [Flavor commands](#cs_machine_types) | Get the information of a flavor or list available flavors for a zone. |
| [Locations commands](#cs_supported-locations) | List the locations that are supported by IBM Cloud Kubernetes Service. |
| [Messages commands](#cs_messages) | View the current user messages. |
| [Versions commands](#cs_versions_command) | List the container platform versions that are available for IBM Cloud Kubernetes Service clusters. |
| **Deprecated** [API commands](#cs_cli_api) | View or target the API endpoint and API version for the service. |
| **Deprecated** [`init` commands](#cs_init) | Initialize the IBM Cloud Kubernetes Service plug-in or specify the region where you want to create or access Kubernetes clusters. |
| [Script commands](#script) | Rewrite scripts that call IBM Cloud Kubernetes Service plug-in commands. |
| **Beta** [Storage commands](#cs_storage) | View and modify storage resources. |
{: caption="{{site.data.keyword.containerlong_notm}} CLI command groups" caption-side="bottom"}

## `cluster` commands
{: #cluster}

Create, view, and modify clusters and cluster settings, such as add-on, subnet, and master settings.
{: shortdesc}

### `ibmcloud ks cluster addon disable`
{: #cs_cluster_addon_disable}

Disable a managed add-on in an existing cluster. This command must be combined with one of the following subcommands for the managed add-on that you want to disable.
{: shortdesc}

#### `ibmcloud ks cluster addon disable alb-oauth-proxy`
{: #cs_cluster_addon_disable_alb-oauth-proxy}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


Disable the add-on for the [ALB OAuth Proxy](/docs/containers?topic=containers-debug-tool) in a cluster.
{: shortdesc}

```sh
ibmcloud ks cluster addon disable alb-oauth-proxy --cluster CLUSTER
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.


##### Example `addon disable alb-oauth-proxy` command
{: #addon-disable-alb-oauth-proxy}

```sh
ibmcloud ks cluster addon disable alb-oauth-proxy --cluster my_cluster
```
{: pre}

#### `ibmcloud ks cluster addon disable debug-tool`
{: #cs_cluster_addon_disable_debug}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable the add-on for the {{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool.
{: shortdesc}

```sh
ibmcloud ks cluster addon disable debug-tool --cluster CLUSTER [-f]
```
{: pre}


Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.


#### `ibmcloud ks cluster addon disable istio`
{: #cs_cluster_addon_disable_istio}

[Classic infrastructure]{: tag-classic-inf}


Disable the managed Istio add-on. Removes all Istio core components from the cluster, including Prometheus.
{: shortdesc}

```sh
ibmcloud ks cluster addon disable istio --cluster CLUSTER [-f]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: This Istio add-on is a dependency for the `istio-extras` and `istio-sample-bookinfo` managed add-ons. Include this option to also disable those add-ons.


#### `ibmcloud ks cluster addon disable istio-extras`
{: #cs_cluster_addon_disable_istio_extras}

[Classic infrastructure]{: tag-classic-inf}


Disable the managed Istio extras add-on, which is unsupported. Removes Grafana, Jeager, and Kiali from the cluster.
{: shortdesc}

```sh
ibmcloud ks cluster addon disable istio-extras --cluster CLUSTER [-f]
```
{: pre}


Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: This Istio add-on is a dependency for the `istio-sample-bookinfo` managed add-on. Include this option to also disable that add-on.


#### `ibmcloud ks cluster addon disable istio-sample-bookinfo`
{: #cs_cluster_addon_disable_istio_sample_bookinfo}

[Classic infrastructure]{: tag-classic-inf}


Disable the managed Istio BookInfo add-on, which is unsupported. Removes all deployments, pods, and other BookInfo app resources from the cluster.
{: shortdesc}

```sh
ibmcloud ks cluster addon disable istio-sample-bookinfo --cluster CLUSTER
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.


#### `ibmcloud ks cluster addon disable kube-terminal`
{: #cs_cluster_addon_disable_kube-terminal}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable the [Kubernetes web terminal](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addon_disable) add-on. To use the Kubernetes web terminal in the {{site.data.keyword.containerlong_notm}} cluster console, you must re-enable the add-on first.
{: shortdesc}

```sh
ibmcloud ks cluster addon disable kube-terminal --cluster CLUSTER [-f]
```
{: pre}


Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.


#### `ibmcloud ks cluster addon disable static-route`
{: #cs_cluster_addon_disable_static-route}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable the [static route](/docs/containers?topic=containers-static-routes) add-on.
{: shortdesc}

```sh
ibmcloud ks cluster addon disable static-route --cluster CLUSTER
```
{: pre}


Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}



#### `ibmcloud ks cluster addon disable vpc-block-csi-driver`
{: #cs_cluster_addon_disable_vpc-block-csi-driver}

[Classic infrastructure]{: tag-classic-inf}


Disable the [{{site.data.keyword.vpc_short}} Block Storage CSI Driver](/docs/containers?topic=containers-vpc-block) add-on.
{: shortdesc}

```sh
ibmcloud ks cluster addon disable vpc-block-csi-driver --cluster CLUSTER [-f]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.




### `ibmcloud ks cluster addon enable`
{: #cs_cluster_addon_enable}

Enable a managed add-on in an existing cluster. This command must be combined with one of the following subcommands for the managed add-on that you want to enable.
{: shortdesc}

#### `ibmcloud ks cluster addon enable alb-oauth-proxy`
{: #cs_cluster_addon_enable_alb-oauth-proxy}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable the add-on for the [ALB OAuth Proxy](/docs/containers?topic=containers-debug-tool) in a cluster. When your ALBs run the Kubernetes Ingress image, you can use the ALB OAuth proxy to enforce authentication for your apps by configuring Ingress with {{site.data.keyword.appid_full_notm}}.
{: shortdesc}

```sh
ibmcloud ks cluster addon enable alb-oauth-proxy --cluster CLUSTER [--version VERSION]
```
{: pre}


Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--version VERSION`
:    Optional: Specify the version of the add-on to install. If no version is specified, the default version is installed.


##### Example `addon enable alb-oauth-proxy` command
{: #addon-enable-alb-oauth-proxy}

```sh
ibmcloud ks cluster addon enable alb-oauth-proxy --cluster my_cluster
```
{: pre}

#### `ibmcloud ks cluster addon enable debug-tool`
{: #cs_cluster_addon_enable_debug}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable the add-on for the [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-debug-tool) in a cluster.
{: shortdesc}

```sh
ibmcloud ks cluster addon enable debug-tool --cluster CLUSTER [--version VERSION]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--version VERSION`
:    Optional: Specify the version of the add-on to install. If no version is specified, the default version is installed.


##### Example `addon enable debug-tool` command
{: #addon-enable-debug-tool}

```sh
ibmcloud ks cluster addon enable debug-tool --cluster my_cluster
```
{: pre}

#### `ibmcloud ks cluster addon enable istio`
{: #cs_cluster_addon_enable_istio}

[Classic infrastructure]{: tag-classic-inf}


Enable the managed [Istio add-on](/docs/containers?topic=containers-istio). Installs the core components of Istio, including Prometheus.
{: shortdesc}

```sh
ibmcloud ks cluster addon enable istio --cluster CLUSTER [--version VERSION]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--version VERSION`
:    Optional: Specify the version of the add-on to install. If no version is specified, the default version is installed. Note that Istio version 1.3 is supported only in Kubernetes version 1.15 and earlier clusters, and Istio versions 1.4 and later are supported only in Kubernetes version 1.16 and later clusters.


#### `ibmcloud ks cluster addon enable static-route`
{: #cs_cluster_addon_enable_static-route}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable the [static route](/docs/containers?topic=containers-static-routes) add-on.
{: shortdesc}

```sh
ibmcloud ks cluster addon enable static-route --cluster CLUSTER [--version VERSION]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--version VERSION`
:    Optional: Specify the version of the add-on to install. If no version is specified, the default version is installed.




#### `ibmcloud ks cluster addon enable vpc-block-csi-driver`
{: #cs_cluster_addon_enable_vpc-block-csi-driver}

[Virtual Private Cloud]{: tag-vpc} 

Enable the [{{site.data.keyword.vpc_short}} Block Storage CSI Driver](/docs/containers?topic=containers-vpc-block) add-on.
{: shortdesc}

```sh
ibmcloud ks cluster addon enable vpc-block-csi-driver --cluster CLUSTER [--version VERSION]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--version VERSION`
:    Optional: Specify the version of the add-on to install. If no version is specified, the default version is installed.




### `ibmcloud ks cluster addon get`
{: #cs_cluster_addon_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of an installed add-on.
{: shortdesc}

```sh
ibmcloud ks cluster addon get --addon ADDON --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--addon ADDON`
:    Required: The name of the `addon`. To list installed add-ons, run `ibmcloud ks cluster addon ls`.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


### `ibmcloud ks cluster addon ls`
{: #cs_cluster_addons}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List any managed add-ons that are enabled in a cluster.
{: shortdesc}

```sh
ibmcloud ks cluster addon ls --cluster CLUSTER
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.


### `ibmcloud ks cluster addon options`
{: #cs_cluster_addon_options}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Before you enable an add-on, view its installation options.
{: shortdesc}

```sh
ibmcloud ks cluster addon options --addon ADDON [--output OUTPUT] [-q] [--version VERSION]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--addon ADDON`
:    Required: The name of the `addon`. To list available add-ons, run `ibmcloud ks cluster addon versions`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`--version VERSION`
:    Optional: Specify an add-on version to display options for. If no version is specified, the default version's options are displayed. To list available add-on versions, run `ibmcloud ks cluster addon versions`.


### `ibmcloud ks cluster addon update`
{: #cs_cluster_addon_update}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Update an installed add-on.
{: shortdesc}

```sh
ibmcloud ks cluster addon update ADD-ON_NAME --cluster CLUSTER [-f] [-q] [--version VERSION] [-y]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`--version VERSION`
:    Optional: Specify the version to update the add-on to. If no version is specified, the add-on is updated to the default version. To list available add-on versions, run `ibmcloud ks cluster addon versions`.


### `ibmcloud ks cluster addon versions`
{: #cs_addon_versions}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View a list of supported versions for managed add-ons in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

```sh
ibmcloud ks cluster addon versions [--addon ADD-ON_NAME] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--addon ADD-ON_NAME`
:    Optional: Specify an add-on name such as `istio` to filter versions for.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `addon versions` command
{: #addon-versions-example}

```sh
ibmcloud ks cluster addon versions --addon istio
```
{: pre}



### `ibmcloud ks cluster ca create`
{: #cs_cluster_ca_create}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Create a new certificate authority (CA) for your cluster. After the CA is created and new CA certificates are issued for components in your cluster, the API server of the cluster is automatically refreshed.
{: shortdesc}

After you run this command and before you run the `ibmcloud ks cluster ca rotate` command, follow the steps in [Rotating CA certificates in your cluster](/docs/containers?topic=containers-cert-rotate) to ensure that any tooling that uses certificates that are signed by the old CA is updated to use the new certificates and to update your worker nodes.
{: important}

```sh
ibmcloud ks cluster ca create --cluster CLUSTER [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster ca create` command
{: #cluster-ca-create-example}

```sh
ibmcloud ks cluster ca create --cluster my_cluster
```
{: pre}

### `ibmcloud ks cluster ca get`
{: #cs_cluster_ca_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of a cluster's CA certificate.
{: shortdesc}

```sh
ibmcloud ks cluster ca get --cluster CLUSTER [ --output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster ca get` command
{: #cluster-ca-get-example}

```sh
ibmcloud ks cluster ca get --cluster my_cluster
```
{: pre}

### `ibmcloud ks cluster ca rotate`
{: #cs_cluster_ca_rotate}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Rotate the certificate authority (CA) certificates of a cluster. Rotating invalidates certificates signed by the cluster's previous CA and issues certificates signed by the cluster's new CA to worker nodes.
{: shortdesc}

Before you run this command, follow the steps in [Rotating CA certificates in your cluster](/docs/containers?topic=containers-cert-rotate) to ensure that any tooling that uses the old CA certificates is updated to use the new certificates and to update your worker nodes.
{: important}

```sh
ibmcloud ks cluster ca rotate --cluster CLUSTER [-f] [-q]
```
{: pre}


Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster ca rotate` command
{: #cluster-ca-rotate-example}

```sh
ibmcloud ks cluster ca rotate --cluster my_cluster
```
{: pre}


### `ibmcloud ks cluster ca status`
{: #cs_cluster_ca_status}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

After you run [`ibmcloud ks cluster ca rotate`](#cs_cluster_ca_rotate), view the rotation status of certificate authority (CA) certificates for a cluster.
{: shortdesc}

```sh
ibmcloud ks cluster ca status --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster ca status` command
{: #cluster-ca-status-example}

```sh
ibmcloud ks cluster ca status --cluster my_cluster
```
{: pre}


### `ibmcloud ks cluster config`
{: #cs_cluster_config}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

After logging in to {{site.data.keyword.cloud_notm}}, download the Kubernetes configuration data and certificates as a `kubeconfig` file to your local machine so that you can connect to your cluster and run `kubectl` commands.
{: shortdesc}

The `kubeconfig` file is merged to your existing `kubeconfig` file in `~/.kube/config` (`<user_profile>/.kube/config` in Windows), or to the last file that is set by the `KUBECONFIG` environment variable in your command line session. After you run `ibmcloud ks cluster config`, you can interact with your cluster immediately, and quickly change the context to other clusters in the Kubernetes context.

```sh
ibmcloud ks cluster config --cluster CLUSTER [--admin] [--endpoint ENDPOINT_TYPE] [--network] [--skip-rbac] [-q] [-o]
```
{: pre}

Minimum required permissions
:   **Viewer** or **Reader** {{site.data.keyword.cloud_notm}} IAM service access role for the cluster in {{site.data.keyword.containerlong_notm}}. Further, if you have only a platform access role or only a service access role, additional constraints apply.
* **Platform**: If you have only a platform access role, you can perform this command, but you need a [service access role](/docs/containers?topic=containers-iam-platform-access-roles) to perform Kubernetes actions in the cluster.
* **Service**: If you have the `service` access role, you can perform this command. However, your cluster admin must gather the cluster details for you by either running the `ibmcloud ks cluster ls` command or using the {{site.data.keyword.containerlong_notm}} console. After you receive the cluster name and ID, you can [launch the Kubernetes dashboard from the CLI](/docs/containers?topic=containers-deploy_app#db_cli) and work with Kubernetes.

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--admin`
:    Optional: The **Administrator** Platform role is required to use this option. Download the TLS certificates and permission files for the Super User role. The files are downloaded to `<user_home_directory>/.bluemix/plugins/kubernetes-service/clusters/<cluster_name>-admin`. The certificates can be revoked or rotated. Fore more information, see [Rotating CA certificates in your cluster](/docs/containers?topic=containers-cert-rotate).

`--endpoint ENDPOINT_TYPE`
:    Optional: Specify the type of endpoint to use to connect to the cluster. If you don't specify this option, the default service endpoint for your cluster is used.
     - `private`: If the private cloud service endpoint is enabled for your cluster, set to `private` to use the private cloud service endpoint for your cluster context. Note you must be in your {{site.data.keyword.cloud_notm}} private network or connected to the private network through a [VPC VPN connection](/docs/vpc?topic=vpc-vpn-onprem-example), or for classic infrastructure, a [classic VPN connection](/docs/iaas-vpn?topic=iaas-vpn-getting-started) or [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl).
        
     - `vpe`: If it is a VPC cluster, set to `vpe` to use the Virtual Private Endpoint gateway for your cluster context. Note you must be connected to the same VPC where the cluster is deployed through [VPC VPN connection](/docs/vpc?topic=vpc-vpn-overview).

`--network`
:    Optional: Download the Calico configuration file, TLS certificates, and permission files that are required to run `calicoctl` commands in your cluster.

`--skip-rbac`
:    Skip adding user Kubernetes RBAC roles based on the {{site.data.keyword.cloud_notm}} IAM service access roles to the cluster configuration. Include this option only if you [manage your own Kubernetes RBAC roles](/docs/containers?topic=containers-understand-rbac). If you use [{{site.data.keyword.cloud_notm}} IAM service access roles](/docs/containers?topic=containers-iam-platform-access-roles) to manage all your RBAC users, don't include this option.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`-o`
:    Optional: Prints the command output in YAML, JSON, or `.zip` format.


#### Example `cluster config` command
{: #cluster-config-example}

```sh
ibmcloud ks cluster config --cluster my_cluster
```
{: pre}


### `ibmcloud ks cluster create classic`
{: #cs_cluster_create}

[Classic infrastructure]{: tag-classic-inf}


Create a cluster with worker nodes on classic infrastructure.
{: shortdesc}

```sh
ibmcloud ks cluster create classic [--hardware HARDWARE] --zone ZONE --flavor FLAVOR --name NAME  [--operating-system SYSTEM] [--version MAJOR.MINOR.PATCH] [--no-subnet] [--sm-group GROUP] [--sm-instance INSTANCE] [--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN] [--private-only] [--private-service-endpoint] [--public-service-endpoint] [--workers WORKER] [--disable-disk-encrypt] [--pod-subnet SUBNET] [--service-subnet SUBNET] [--skip-advance-permissions-check] [-q]
```
{: pre}


To create a VPC cluster, use the [`ibmcloud ks cluster create vpc-gen2` command](#cli_cluster-create-vpc-gen2) instead.
{: note}

Minimum required permissions
:   **Administrator** platform access role for {{site.data.keyword.containerlong_notm}} at the account level
:   **Administrator** platform access role for {{site.data.keyword.registrylong_notm}} at the account level
:   **Super User** role for IBM Cloud infrastructure

**Command options**:

`--hardware HARDWARE`
:    The level of hardware isolation for your worker node. Use `dedicated` so that available physical resources are dedicated to you only, or `shared` to allow physical resources to be shared with other IBM customers. The default is `shared`. For bare metal flavors, specify `dedicated`.

`--zone ZONE`
:    The zone where you want to create the cluster. This value is required for standard clusters.
:    Review available [classic](/docs/containers?topic=containers-regions-and-zones#zones-mz) or [VPC](/docs/containers?topic=containers-regions-and-zones#zones-vpc) zones.
     When you select a zone that is located outside your country, keep in mind that you might require legal authorization before data can be physically stored in a foreign country.
     {: note}

`--flavor FLAVOR`
:    Choose a flavor, or machine type, for your worker nodes. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual flavors vary by the zone in which you deploy the cluster. For more information, see the documentation for the `ibmcloud ks flavors (machine-types)` [command](#cs_machine_types).

`--name NAME`
:    Required: The name for the cluster. The name must start with a letter, can contain letters, numbers, periods (.), and hyphen (-), and must be 35 characters or fewer. Use a name that is unique across regions. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.


`--operating-system UBUNTU_20_64|UBUNTU_24_64`
:   Optional. The operating system of the worker nodes in your cluster. For a list of available operating systems by cluster version, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions). If no option is specified, the default operating system that corresponds to the cluster version is used.

`--version MAJOR.MINOR.PATCH`
:    Optional: The Kubernetes version for the cluster master node. When the version is not specified, the cluster is created with the default of supported Kubernetes versions. To see available versions, run `ibmcloud ks versions`.

`--no-subnet`
:    By default, a public and a private portable subnet are created on the VLAN associated with the cluster. Include the `--no-subnet` option to avoid creating subnets with the cluster. You can [create](#cs_cluster_subnet_create) or [add](#cs_cluster_subnet_add) subnets to a cluster later.

`--sm-group GROUP`
:    The secret group ID of the {{site.data.keyword.secrets-manager_short}} instance where your secrets are persisted. To get a secret group ID, see the [{{site.data.keyword.secrets-manager_short}} CLI reference](/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-secret-groups-cli).

`--sm-instance INSTANCE`
:    The CRN of the {{site.data.keyword.secrets-manager_short}} instance. To get the CRN of an instance, run [`ibmcloud ks ingress instance ls --cluster CLUSTER`](#cs_ingress_instance_ls).

`--private-vlan PRIVATE_VLAN`
:    If this standard cluster is the first standard cluster that you create in this zone, don't include this option. A private VLAN is created for you when the cluster is created. If you created a standard cluster before in this zone or created a private VLAN in IBM Cloud infrastructure before, you must specify that private VLAN. Private VLAN routers always begin with `bcr` (back-end router) and public VLAN routers always begin with `fcr` (front-end router). When you create a cluster and specify the public and private VLANs, the number and letter combination after those prefixes must match.
:    To find out whether you already have a private VLAN for a specific zone or to find the name of an existing private VLAN, run `ibmcloud ks vlan ls --zone ZONE`.

`--public-vlan PUBLIC_VLAN`
:    If this standard cluster is the first standard cluster that you create in this zone, don't use this option. A public VLAN is created for you when the cluster is created. If you created a standard cluster before in this zone or created a public VLAN in IBM Cloud infrastructure before, specify that public VLAN. If you want to connect your worker nodes to a private VLAN only, don't specify this option. Private VLAN routers always begin with `bcr` (back-end router) and public VLAN routers always begin with `fcr` (front-end router). When you create a cluster and specify the public and private VLANs, the number and letter combination after those prefixes must match.
:    To find out whether you already have a public VLAN for a specific zone or to find the name of an existing public VLAN, run `ibmcloud ks vlan ls --zone ZONE`. 

`--private-only`
:    Use this option to prevent a public VLAN from being created. Required only when you specify the `--private-vlan` option and don't include the `--public-vlan` option.
     If worker nodes are set up with a private VLAN only, you must enable the private cloud service endpoint or configure a gateway appliance. For more information, see [Worker-to-master and user-to-master communication](/docs/containers?topic=containers-plan_basics#workeruser-master).
     {: note}

`--private-service-endpoint`
:    **Standard clusters in [accounts that are enabled with VRF and service endpoints](/docs/account?topic=account-vrf-service-endpoint)**: Enable the [private cloud service endpoint](/docs/containers?topic=containers-plan_basics#workeruser-master) so that your Kubernetes master and the worker nodes communicate over the private VLAN. In addition, you can choose to enable the public cloud service endpoint by using the `--public-service-endpoint` option to access your cluster over the internet. If you enable the private cloud service endpoint only, you must be connected to the private VLAN to communicate with your Kubernetes master. After you enable a private cloud service endpoint, you can't later disable it. After you create the cluster, you can get the endpoint by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`.

`--public-service-endpoint`
:    Enable the [public cloud service endpoint](/docs/containers?topic=containers-plan_basics#workeruser-master) so that your Kubernetes master can be accessed over the public network, for example to run `kubectl` commands from your command line. Public-only clusters can only be created in accounts that don't have VRF enabled. If you have an [account that is enabled with VRF and service endpoints](/docs/account?topic=account-vrf-service-endpoint) and also include the `--private-service-endpoint` option, master-worker node communication goes over the private and the public network. You can later disable the public cloud service endpoint if you want a private-only cluster.
     After you create the cluster, you can get the endpoint by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`.


`--workers WORKERS`
:    **Optional**: Specify the number of worker nodes to include in the cluster. The default value is 1.
     If you create a cluster with only one worker node per zone, you might experience issues with Ingress. For high availability, create a cluster with at least two workers per zone. Every worker node is assigned a unique worker node ID and domain name that must not be manually changed after the cluster is created. Changing the ID or domain name prevents the Kubernetes master from managing your cluster.
     {: important}

`--disable-disk-encrypt`
:    Worker nodes feature AES 256-bit disk encryption by default; [learn more](/docs/containers?topic=containers-security#encrypted_disk). To disable encryption, include this option.

`--pod-subnet SUBNET`{: #pod-subnet}
:    All pods that are deployed to a worker node are assigned a private IP address in the `172.17.0.0/18` range by default. If you plan to connect your cluster to on-premises networks through {{site.data.keyword.BluDirectLink}} or a VPN service, you can avoid subnet conflicts by specifying a custom subnet CIDR that provides the private IP addresses for your pods.
:    When you choose a subnet size, consider the size of the cluster that you plan to create and the number of worker nodes that you might add in the future. The subnet must have a CIDR of at least `/23`, which provides enough pod IPs for a maximum of four worker nodes in a cluster. For larger clusters, use `/22` to have enough pod IP addresses for eight worker nodes, `/21` to have enough pod IP addresses for 16 worker nodes, and so on.
:    The subnet that you choose must be within one of the following ranges:
     - `172.17.0.0 - 172.17.255.255`
     - `172.21.0.0 - 172.31.255.255`

     - `192.168.0.0 - 192.168.255.255`


     - `198.18.0.0 - 198.19.255.255`

:    Note that the pod and service subnets can't overlap. The service subnet is in the 172.21.0.0/16 range by default.

`--service-subnet *SUBNET`{: #service-subnet}
:    All services that are deployed to the cluster are assigned a private IP address in the 172.21.0.0/16 range by default. If you plan to connect your cluster to on-premises networks through {{site.data.keyword.dl_full_notm}} or a VPN service, you can avoid subnet conflicts by specifying a custom subnet CIDR that provides the private IP addresses for your services.
:    The subnet must be specified in CIDR format with a size of at least `/24`, which allows a maximum of 255 services in the cluster, or larger. The subnet that you choose must be within one of the following ranges:
     - `172.17.0.0 - 172.17.255.255`
     - `172.21.0.0 - 172.31.255.255`

     - `192.168.0.0 - 192.168.255.255`


     - `198.18.0.0 - 198.19.255.255`

:    Note that the pod and service subnets can't overlap. The pod subnet is in the 172.30.0.0/16 range by default.

`--skip-advance-permissions-check`
:    Optional: Skip [the check for infrastructure permissions](/docs/containers?topic=containers-kubernetes-service-cli#infra_permissions_get) before creating the cluster. Note that if you don't have the correct infrastructure permissions, the cluster creation might only partially succeed, such as the master provisioning but the worker nodes unable to provision. You might skip the permissions check if you want to continue an otherwise blocked operation, such as when you use multiple infrastructure accounts and can handle the infrastructure resources separately from the master, if needed later.

`-q`
:    Optional: Do not show the message of the day or update reminders.



#### Example `cluster create classic` commands
{: #cluster-create-classic-examples}



**Create your first cluster**: The first standard cluster that is created in a zone also creates a private VLAN. Therefore, don't include the `--public-vlan` option.
{: #example_cluster_create}

```sh
ibmcloud ks cluster create classic --zone dal10 --private-vlan my_private_VLAN_ID --flavor b3c.4x16 --name my_cluster --hardware shared --workers 2 --operating-system UBUNTU_20_64
```
{: pre}

**Create subsequent standard clusters**: If you already created a standard cluster in this zone or created a public VLAN in IBM Cloud infrastructure before, specify that public VLAN with the `--public-vlan` option. To find out whether you already have a public VLAN for a specific zone or to find the name of an existing public VLAN, run `ibmcloud ks vlan ls --zone <zone>`.

```sh
ibmcloud ks cluster create classic --zone dal10 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --flavor b3c.4x16 --name my_cluster --hardware shared --workers 2 --operating-system UBUNTU_20_64
```
{: pre}

### `ibmcloud ks cluster create vpc-gen2`
{: #cli_cluster-create-vpc-gen2}

[Virtual Private Cloud]{: tag-vpc}

Create a Virtual Private Cloud (VPC) cluster with worker nodes on Generation 2 infrastructure. When you log in to your {{site.data.keyword.cloud_notm}} account, target the {{site.data.keyword.cloud_notm}} region and resource group where you want to create your VPC cluster. For supported regions, see [Creating a VPC in a different region](/docs/vpc?topic=vpc-creating-a-vpc-in-a-different-region). The cluster's resource group can differ from the VPC resource group.
{: shortdesc}

VPC Gen 2 cluster flavors with instance storage are available for allowlisted accounts. To get added to the allowlist, [open a case](https://cloud.ibm.com/unifiedsupport/cases/form){: external} with support.
{: note}




```sh
ibmcloud ks cluster create vpc-gen2 --name NAME --zone ZONE --vpc-id VPC_ID --subnet-id VPC_SUBNET_ID --flavor WORKER_FLAVOR [--cluster-security-group GROUP_ID] [--operating-system SYSTEM] [--version VERSION] [--workers NUMBER_WORKERS_PER_ZONE] [--dedicated-host-pool POOL] [--disable-outbound-traffic-protection] [--disable-public-service-endpoint] [--pod-subnet SUBNET] [--service-subnet SUBNET] [--kms-account-id ID] [--kms-instance KMS_INSTANCE_ID] [--crk ROOT_KEY_ID][--skip-advance-permissions-check] [--sm-group GROUP] [--sm-instance INSTANCE] [-q] [--secondary-storage STORAGE]
```
{: pre}

Minimum required permissions
:   [**Administrator** platform access role for VPC Infrastructure](/docs/vpc?topic=vpc-iam-getting-started).
:   [**Administrator** platform access role](/docs/containers?topic=containers-iam-platform-access-roles) for {{site.data.keyword.containerlong_notm}} at the account level.
:   [**Writer** or **Manager** service access role](/docs/containers?topic=containers-iam-platform-access-roles) for {{site.data.keyword.containerlong_notm}}.
:   [**Administrator** platform access role](/docs/containers?topic=containers-iam-platform-access-roles) for {{site.data.keyword.registrylong_notm}} at the account level.

**Command options**:


`--name NAME`
:    Required: The name for the cluster. The name must start with a letter, can contain letters, numbers, periods (.), and hyphen (-), and must be 35 characters or fewer. Use a name that is unique across regions. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.

`--zone ZONE`
:    Required: Select a zone to deploy the initial cluster worker pool in. If you create the cluster in a multizone metro, you can add a zone to the worker pool later. To list available VPC zones, run `ibmcloud ks zone ls --provider vpc-gen2`.</p>
     When you select a zone that is located outside your country, keep in mind that you might require legal authorization before data can be physically stored in a foreign country.
    {: note}

`--vpc-id VPC_ID`
:    Required: The ID of the VPC in which to create the cluster and worker nodes. To list available IDs, run `ibmcloud ks vpcs`.

`--subnet-id VPC_SUBNET_ID`
:    Required: The VPC subnet to assign the cluster. To list available VPC subnets, run `ibmcloud ks subnets --provider vpc-gen2`.

`--version VERSION`
:    The Kubernetes version for the cluster master node. To see available versions, run `ibmcloud ks versions`.

`--flavor FLAVOR`
:    Choose a flavor for your worker nodes. You can deploy your worker nodes as virtual machines on shared or dedicated hardware. To see flavors that are available in a zone, run `ibmcloud ks flavors --zone <vpc_zone> --provider vpc-gen2`.

`--cluster-security-group GROUP_ID`
:    Optional. Specify additional security group IDs to apply to all workers on the cluster. You must include a separate `--cluster-security-group` option for each individual security group you want to add. To apply the IBM-created `kube-clusterID`, use `--cluster-security-group cluster`. If no value is specified, only the `kube-clusterID` and the default VPC security group are applied. A maximum of five security groups can be applied to workers, including the default security groups. Note that the VPC security group is only applied if no other security groups are specified. For more information, see [Adding VPC security groups to clusters and worker pools during create time](/docs/containers?topic=containers-vpc-security-group-manage).
    The security groups applied to a cluster cannot be changed once the cluster is created. You can change the rules of the security groups that are applied to the cluster, but you cannot add or remove security groups at the cluster level. If you apply the incorrect security groups at cluster create time, you must delete the cluster and create a new one. For more information, see [Adding VPC security groups to clusters and worker pools during create time](/docs/containers?topic=containers-vpc-security-group-manage).
    {: important}

`--operating-system UBUNTU_20_64|UBUNTU_24_64`
:   Optional. The operating system of the worker nodes in your cluster. For a list of available operating systems by cluster version, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions). If no option is specified, the default operating system that corresponds to the cluster version is used.



`--preview PREVIEW`
:    Optional: Specify one or more cluster level preview features, such as `fips`.

`--dedicated-host-pool POOL`
:    Optional: The ID of the dedicated host pool where you want to run your workers. 

`--workers NUMBER_WORKERS_PER_ZONE`
:    Optional: Specify the number of worker nodes to include in the cluster. The default value is 1.

`--disable-outbound-traffic-protection`
:    Include this option to allow public outbound access from the cluster workers. By default, public outbound access is blocked in OpenShift versions 4.15 and later and Kubernetes versions 1.30 and later.

`--disable-public-service-endpoint`
:    To ensure that worker nodes and authorized cluster users communicate with the master through the private cloud service endpoint only, include this option to create the cluster without the public cloud service endpoint.

`--pod-subnet SUBNET`
:    In the first cluster that you create in a VPC, the default pod subnet is `172.17.0.0/18`. In the second cluster that you create in that VPC, the default pod subnet is `172.17.64.0/18`. In each subsequent cluster, the pod subnet range is the next available, non-overlapping `/18` subnet. If you plan to connect your cluster to on-premises networks through {{site.data.keyword.BluDirectLink}} or a VPN service, you can avoid subnet conflicts by specifying a custom subnet CIDR that provides the private IP addresses for your pods.
:    When you choose a subnet size, consider the size of the cluster that you plan to create and the number of worker nodes that you might add in the future. The subnet must have a CIDR of at least `/23`, which provides enough pod IPs for a maximum of four worker nodes in a cluster. For larger clusters, use `/22` to have enough pod IP addresses for eight worker nodes, `/21` to have enough pod IP addresses for 16 worker nodes, and so on.
:   :    All pods that are deployed to a worker node are assigned a private IP address in the `172.17.0.0/18` range by default. If you plan to connect your cluster to on-premises networks through {{site.data.keyword.BluDirectLink}} or a VPN service, you can avoid subnet conflicts by specifying a custom subnet CIDR that provides the private IP addresses for your pods.
:   For VPC clusters, you can specify the subnet size by including it in the `--pod-subnet` option. For example: `--pod-subnet 0.0.0.0/X` where `X` is the required pod subnet size. Then pod subnet is then automatically selected. When allocating the pod subnet automatically, the allocation will start from `172.17.0.0`, the biggest subnet is limited to `13`, and the smallest subnet size is limited to `23`. For more information, see [Configuring VPC subnets](/docs/containers?topic=containers-vpc-subnets).
     The subnet that you choose must be within one of the following ranges.
     - `172.17.0.0 - 172.17.255.255`
     - `172.21.0.0 - 172.31.255.255`

     - `192.168.0.0 - 192.168.255.255`


     - `198.18.0.0 - 198.19.255.255`

:    Note that the pod and service subnets can't overlap. If you use custom-range subnets for your worker nodes, you must [ensure that your worker node subnets don't overlap with your cluster's pod subnet](/docs/containers?topic=containers-vpc-subnets#vpc-ip-range).

`--service-subnet SUBNET`
:    All services that are deployed to the cluster are assigned a private IP address in the 172.21.0.0/16 range by default. If you plan to connect your cluster to on-premises networks through {{site.data.keyword.dl_full_notm}} or a VPN service, you can avoid subnet conflicts by specifying a custom subnet CIDR that provides the private IP addresses for your services.
     The subnet must be specified in CIDR format with a size of at least `/24`, which allows a maximum of 255 services in the cluster, or larger. The subnet that you choose must be within one of the following ranges.
     - `172.17.0.0 - 172.17.255.255`
     - `172.21.0.0 - 172.31.255.255`
     - `192.168.0.0 - 192.168.255.255`
     - `198.18.0.0 - 198.19.255.255`

:    Note that the pod and service subnets can't overlap.

`--skip-advance-permissions-check`
:    Optional: Skip [the check for infrastructure permissions](/docs/containers?topic=containers-kubernetes-service-cli#infra_permissions_get) before creating the cluster. Note that if you don't have the correct infrastructure permissions, the cluster creation might only partially succeed, such as the master provisioning but the worker nodes unable to provision. You might skip the permissions check if you want to continue an otherwise blocked operation, such as when you use multiple infrastructure accounts and can handle the infrastructure resources separately from the master, if needed later.

`--kms-account-id ID`
:    Optional: The ID of the account that contains the KMS instance you want to use for local disk or secret encryption.

`--kms-instance KMS_INSTANCE_ID`
:    Optional: Include the ID of a key management service (KMS) instance to use to encrypt the local disk on the worker nodes in the `default` worker pool. To list available KMS instances, run `ibmcloud ks kms instance ls`. If you include this option, you must also include the `--crk` option.
     Before you can use KMS encryption, you must create a KMS instance and set up the required service authorization in IAM. See [Managing encryption for the worker nodes in your cluster](/docs/containers?topic=containers-encryption).
     {: note}

`--crk ROOT_KEY`
:    Optional: Include the ID of the root key in the KMS instance to use to encrypt the local disk on the worker nodes in the `default` worker pool. To list available root keys, run `ibmcloud ks kms crk ls --instance-id`. If you include this option, you must also include the `--kms-instance` option.
     Before you can use KMS encryption, you must create a KMS instance and set up the required service authorization in IAM. See [Managing encryption for the worker nodes in your cluster](/docs/containers?topic=containers-encryption).
     {: note}
     
`--sm-group GROUP`
:    The secret group ID of the {{site.data.keyword.secrets-manager_short}} instance where your secrets are persisted. To get a secret group ID, see the [{{site.data.keyword.secrets-manager_short}} CLI reference](/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-cli-secret-groups-command).

`--sm-instance INSTANCE`
:    The CRN of the {{site.data.keyword.secrets-manager_short}} instance. To find the CRN of an instance, run [`ibmcloud ks ingress instance ls --cluster CLUSTER`](#cs_ingress_instance_ls).

`--secondary-storage STORAGE`
:    Optional: The storage option for the flavor. For example, `900gb.5iops-tier`. When you add a secondary disk, that disk is used for the container runtime, while the primary disk is used for the operating system. To view the storage options for a flavor, run the `**ibmcloud ks flavor get --flavor FLAVOR --zone ZONE --provider vpc-gen2` command.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster create vpc-gen2` command
{: #cluster-create-vpc-gen2-example}

```sh
ibmcloud ks cluster create vpc-gen2 --name mycluster --version 1.32 --zone us-south-1 --vpc-id a0123456-78b9-0c1d-23d4-567890123ef4 --subnet-id 1ab23c45-6789-0123-456d-789ef01gh234 --flavor bx2.4x16 --workers 3
```
{: pre}

### `ibmcloud ks cluster get`
{: #cs_cluster_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of a cluster.
{: shortdesc}

```sh
ibmcloud ks cluster get --cluster CLUSTER [--show-resources] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--show-resources`
:    Show more cluster resources such as add-ons, VLANs, subnets, and storage.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster get` command
{: #cluster-get-example}

```sh
ibmcloud ks cluster get --cluster my_cluster --show-resources
```
{: pre}

### `ibmcloud ks cluster image-security disable`
{: #cs-image-security-disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable [image security enforcement](/docs/containers?topic=containers-images#portieris-image-sec). When you disable the feature, the underlying `ClusterImagePolicy` CRD is removed, which removes all the default image policies and any custom images policies that you created.
{: shortdesc}

```sh
ibmcloud ks cluster image-security disable --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster image-security disable` command
{: #cluster-image-security-disable-example}

```sh
ibmcloud ks cluster image-security disable --cluster my_cluster
```
{: pre}

### `ibmcloud ks cluster image-security enable`
{: #cs-image-security-enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable [image security enforcement](/docs/containers?topic=containers-images#portieris-image-sec) by installing the Portieris Kubernetes admission controller and the associated default image policies in your cluster.
{: shortdesc}

```sh
ibmcloud ks cluster image-security enable --cluster CLUSTER [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster image-security enable` command
{: #cluster-image-security-enable-example}

```sh
ibmcloud ks cluster image-security enable --cluster my_cluster
```
{: pre}

### `ibmcloud ks cluster ls`
{: #cs_clusters}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}

List all clusters in your {{site.data.keyword.cloud_notm}} account.
{: shortdesc}

Clusters in all locations are returned. To filter clusters by a specific location, include the `--location` option. For example, if you filter clusters for the `dal` metro, multizone clusters in that metro and single-zone clusters in data centers (zones) within that metro are returned. If you filter clusters for the `dal10` data center (zone), multizone clusters that have a worker node in that zone and single-zone clusters in that zone are returned. You can pass one location or a comma-separated list of locations.

```sh
ibmcloud ks cluster ls [--provider (classic | vpc-gen2)] [--location LOCATION] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--provider (classic | vpc-gen2)`
:    Optional: Filter output based on infrastructure provider type.

`-l, --location LOCATION`
:    Filter output by a specific location. To see supported locations, run `ibmcloud ks locations`. To specify multiple locations, use one option for each location, such as `-l dal -l seo`.

`--output json`
:    Optional: Prints the command output in JSON format. **Note**: If you don't include the `--provider` option, only classic clusters are returned.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `cluster ls` command
{: #cluster-ls-example}

```sh
ibmcloud ks cluster ls -l ams03 -l wdc -l ap
```
{: pre}



### `ibmcloud ks cluster master audit-webhook`
{: #cluster_master_audit_webhook}

Modify the webhook back end that forwards API server audit logs to a remote server.
{: shprtdesc}

The `apiserver-config-get|set|unset audit-webhook` aliases for these commands are deprecated.
{: note}

#### `ibmcloud ks cluster master audit-webhook get`
{: #cs_apiserver_config_get}

View the URL for the remote logging service that you are sending API server audit logs to. The URL was specified when you created the webhook back end for the API server configuration.
{: shortdesc}

```sh
ibmcloud ks cluster master audit-webhook get --cluster CLUSTER [-q]
```
{: pre}

[Classic infrastructure]{: tag-classic-inf}


Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

##### Example `cluster master audit-webhook get` command
{: #cluster-master-audit-webhook-get-example}

```sh
ibmcloud ks cluster master audit-webhook get --cluster mycluster
```
{: pre}


#### `ibmcloud ks cluster master audit-webhook set`
{: #cs_apiserver_config_set}

[Classic infrastructure]{: tag-classic-inf}


Set the webhook back end for the API server configuration. The webhook back end forwards API server audit logs to a remote server. After you set the webhook, you must run the `ibmcloud ks cluster master refresh` command to apply the changes to the Kubernetes master.
{: shortdesc}

```sh
ibmcloud ks cluster master audit-webhook set --cluster CLUSTER [--remote-server SERVER_URL_OR_IP] [--ca-cert CA_CERT_PATH] [--client-cert CLIENT_CERT_PATH] [--client-key CLIENT_KEY_PATH] [--policy POLICY] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--remote-server SERVER_URL`
:    Optional: The URL or IP address for the remote logging service you want to send audit logs to. If you provide an insecure server URL, any certificates are ignored. If you provide an IP address, add the `http://` prefix to the IP.

`--ca-cert CA_CERT_PATH`
:    Optional: The file path for the CA certificate that is used to verify the remote logging service.

`--client-cert CLIENT_CERT_PATH`
:    Optional: The file path for the client certificate that is used to authenticate against the remote logging service.

`--client-key CLIENT_KEY_PATH`
:    Optional: The file path for the corresponding client key that is used to connect to the remote logging service.

`--policy POLICY`
:    Optional: The type of policy that is used for auditing. Use `default` or `verbose`. Note that the `verbose` policy type audits a larger number of API transactions, which might impact cluster performance, and is only recommended for occasional use.

`-q`
:    Optional: Do not show the message of the day or update reminders.


##### Example `cluster master audit-webhook set` command
{: #cluster-master-audit-webhook-set-example}

```sh
ibmcloud ks cluster master audit-webhook set --cluster my_cluster --remote-server https://audit.example.com/audit --ca-cert /mnt/etc/kubernetes/apiserver audit/ca.pem --client-cert /mnt/etc/kubernetes/apiserver audit/cert.pem --client-key /mnt/etc/kubernetes/apiserver audit/key.pem
```
{: pre}


#### `ibmcloud ks cluster master audit-webhook unset`
{: #cs_apiserver_config_unset}

[Classic infrastructure]{: tag-classic-inf}


Disable the webhook back-end configuration for the cluster's API server. Disabling the webhook back end stops forwarding API server audit logs to a remote server.
{: shortdesc}

```sh
ibmcloud ks cluster master audit-webhook unset --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.




## `ibmcloud ks cluster master console-oauth-access get`
{: #cluster-master-console-oauth-access-get-cli}

Get the OpenShift web console and OAuth server access type.

```txt
ibmcloud ks cluster master console-oauth-access get --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}
{: #cluster-master-console-oauth-access-get-usage}

### Command options
{: #cluster-master-console-oauth-access-get-options}

`--cluster CLUSTER`, `-c CLUSTER`
:    Specify the cluster name or ID.

`--output OUTPUT`
:    Prints the command output in the provided format. Accepted values: `json`

`-q`
:    Do not show the message of the day or update reminders.
{: #cluster-master-console-oauth-access-get-options-dl}


## `ibmcloud ks cluster master console-oauth-access set`
{: #cluster-master-console-oauth-access-set-cli}

Set the OpenShift web console and OAuth server access type.

```txt
ibmcloud ks cluster master console-oauth-access set --cluster CLUSTER [-f] [-q] [--type TYPE]
```
{: pre}
{: #cluster-master-console-oauth-access-set-usage}

### Command options
{: #cluster-master-console-oauth-access-set-options}

`--cluster CLUSTER`, `-c CLUSTER`
:    Specify the cluster name or ID.

`-f`
:    Force the command to run without user prompts.

`-q`
:    Do not show the message of the day or update reminders.

`--type TYPE`
:    Specify the OpenShift web console and OAuth server access type. Accepted values: `vpe-gateway`, `legacy`
{: #cluster-master-console-oauth-access-set-options-dl}

### `ibmcloud ks cluster master pod-security get`
{: #cluster-master-pod-security-get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the pod security admission configuration for a cluster's Kubernetes API server.
{: shortdesc}

```sh
ibmcloud ks cluster master pod-security get --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `cluster master pod-security get` command
{: #cluster-master-pod-security-get-example}

```sh
ibmcloud ks cluster master pod-security get --cluster mycluster
```
{: pre}

### `ibmcloud ks cluster master pod-security policy disable`
{: #cluster-master-pod-security-policy-disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable the pod security policy for a cluster's Kubernetes API server.
{: shortdesc}

```sh
ibmcloud ks cluster master pod-security policy disable --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `cluster master pod-security policy disable` command
{: #cluster-master-pod-security-policy-disable-example}

```sh
ibmcloud ks cluster master pod-security policy disable --cluster mycluster
```
{: pre}

### `ibmcloud ks cluster master pod-security policy enable`
{: #cluster-master-pod-security-policy-enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable the pod security policy for a cluster's Kubernetes API server. Note that pod security policies are not available in clusters that run version 1.25 or later. 
{: shortdesc}

```sh
ibmcloud ks cluster master pod-security policy enable --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `cluster master pod-security policy enable` command
{: #cluster-master-pod-security-policy-enable-example}

```sh
ibmcloud ks cluster master pod-security policy enable --cluster mycluster
```
{: pre}

### `ibmcloud ks cluster master pod-security policy get`
{: #cluster-master-pod-security-policy-get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the pod security policy configuration for a cluster's Kubernetes API server. Note that pod security policies are not available in clusters that run version 1.25 or later. 
{: shortdesc}

```sh
ibmcloud ks cluster master pod-security policy get --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `cluster master pod-security policy get` command
{: #cluster-master-pod-security-policy-get-example}

```sh
ibmcloud ks cluster master pod-security policy get --cluster mycluster
```
{: pre}

### `ibmcloud ks cluster master pod-security set`
{: #cluster-master-pod-security-set}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Set and enable the [pod security admission](/docs/containers?topic=containers-pod-security-admission&interface=ui) for a cluster's Kubernetes API server.
{: shortdesc}

```sh
ibmcloud ks cluster master pod-security set --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `cluster master pod-security set` command
{: #cluster-master-pod-security-set-example}

```sh
ibmcloud ks cluster master pod-security set --cluster mycluster
```
{: pre}

### `ibmcloud ks cluster master pod-security unset`
{: #cluster-master-pod-security-unset}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove the [pod security admission](/docs/containers?topic=containers-pod-security-admission&interface=ui) configuration for a cluster's Kubernetes API server.
{: shortdesc}

```sh
ibmcloud ks cluster master pod-security unset --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `cluster master pod-security unset` command
{: #cluster-master-pod-security-unset-example}

```sh
ibmcloud ks cluster master pod-security unset --cluster mycluster
```
{: pre}

### `ibmcloud ks cluster master private-service-endpoint allowlist`
{: #cs_master_pse_allowlist}

Private service endpoint allowlists are no longer supported. Migrate from allowlists to context based restrictions as soon as possible. For more information, see [Migrating from a private service endpoint allowlist to context based restrictions (CBR)](/docs/containers?topic=containers-pse-to-cbr-migration).
{: unsupported}

Manage a private cloud service endpoint allowlist so that authorized users can access your private cloud service endpoint from only the subnets that are specified in the allowlist.
{: shortdesc}

#### `ibmcloud ks cluster master private-service-endpoint allowlist add`
{: #cs_master_pse_allowlist_add}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

After you enable a private cloud service endpoint allowlist, add subnets from which authorized users can access your private cloud service endpoint to the allowlist.
{: shortdesc}

For example, to access your cluster's private cloud service endpoint, you must connect to your {{site.data.keyword.cloud_notm}} classic network or your VPC network through a VPN or {{site.data.keyword.dl_full_notm}}. You can add the subnet for the VPN or {{site.data.keyword.dl_full_notm}} tunnel so that authorized users in your organization can only access the private cloud service endpoint from that subnet.

Worker node subnets are automatically added to and removed from your allowlist so that worker nodes can always access the master through the private cloud service endpoint.

```sh
ibmcloud ks cluster master private-service-endpoint allowlist add --cluster CLUSTER --subnet SUBNET [--subnet SUBNET ...] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--subnet SUBNET`
:    Required: The subnet in CIDR format. Specify more than one subnet by using multiple repeated options.

`-q`
:    Optional: Do not show the message of the day or update reminders.


##### Example `cluster master private-service-endpoint allowlist add` command
{: #cluster-master-private-service-endpoint-allowlist-add-example}

```sh
ibmcloud ks cluster master private-service-endpoint allowlist add --cluster mycluster --subnet 1.1.1.1/16
```
{: pre}

#### `ibmcloud ks cluster master private-service-endpoint allowlist disable`
{: #cs_master_pse_allowlist_disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable the subnet allowlist feature for a cluster's private cloud service endpoint.
{: shortdesc}

After you disable this feature, authorized requests to your cluster master through the cluster's private cloud service endpoint can originate from any subnet.

```sh
ibmcloud ks cluster master private-service-endpoint allowlist disable --cluster CLUSTER [-f] [-q]
```
{: pre}


Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run without user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


##### Example `cluster master private-service-endpoint allowlist disable` command
{: #cluster-master-private-service-endpoint-allowlist-disable-example}

```sh
ibmcloud ks cluster master private-service-endpoint allowlist disable --cluster mycluster
```
{: pre}

#### `ibmcloud ks cluster master private-service-endpoint allowlist enable`
{: #cs_master_pse_allowlist_enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable the subnet allowlist feature for a cluster's private cloud service endpoint.
{: shortdesc}

After you run this command, use the [`ibmcloud ks cluster master private-service-endpoint allowlist` command](#cs_master_pse_allowlist_add) to add subnets to the allowlist. Only authorized requests to your cluster master that originate from subnets in the allowlist are permitted through the cluster's private cloud service endpoint. If the public cloud service endpoint is enabled for your cluster, authorized requests are still permitted through the public cloud service endpoint.

```sh
ibmcloud ks cluster master private-service-endpoint allowlist enable --cluster CLUSTER [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run without user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


##### Example `cluster master private-service-endpoint allowlist enable` command
{: #cluster-master-private-service-endpoint-allowlist-enable-example}

```sh
ibmcloud ks cluster master private-service-endpoint allowlist enable --cluster mycluster
```
{: pre}

#### `ibmcloud ks cluster master private-service-endpoint allowlist get`
{: #cs_master_pse_allowlist_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List all subnets in the allowlist for a cluster's private cloud service endpoint.
{: shortdesc}

This list includes subnets that you manually added by using the `ibmcloud ks cluster master private-service-endpoint allowlist add` command and subnets that are automatically added and managed by IBM, such as worker node subnets.

```sh
ibmcloud ks cluster master private-service-endpoint allowlist get --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.


##### Example `cluster master private-service-endpoint allowlist get` command
{: #cluster-master-private-service-endpoint-allowlist-get-example}

```sh
ibmcloud ks cluster master private-service-endpoint allowlist get --cluster mycluster
```
{: pre}

#### `ibmcloud ks cluster master private-service-endpoint allowlist rm`
{: #cs_master_pse_allowlist_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove subnets that you previously added to the allowlist for a cluster's private cloud service endpoint.
{: shortdesc}

After a subnet is removed, any requests that originate from this subnet to the cluster master through the private cloud service endpoint are denied.

```sh
ibmcloud ks cluster master private-service-endpoint allowlist rm --cluster CLUSTER --subnet SUBNET [--subnet SUBNET ...] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--subnet SUBNET`
:    Required: The subnet CIDR. Specify more than one subnet by using multiple repeated options.

`-f`
:    Optional: Force the command to run without user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


##### Example `cluster master private-service-endpoint allowlist rm` command
{: #cluster-master-private-service-endpoint-allowlist-rm}

```sh
ibmcloud ks cluster master private-service-endpoint allowlist rm --cluster mycluster
 --subnet 1.1.1.1/16
```
{: pre}

### `ibmcloud ks cluster master private-service-endpoint disable`
{: #cs_cluster_master_pse_disable}

[Classic infrastructure]{: tag-classic-inf}


Disable the [private cloud service endpoint](/docs/containers?topic=containers-plan_basics#workeruser-master) to remove private accessibility to your cluster master.
{: shortdesc}

**Important**: Before you disable the private endpoint, you first must complete the following steps to enable the public cloud service endpoint:
1. Enable the public cloud service endpoint by running `ibmcloud ks cluster master public-service-endpoint enable --cluster <cluster_name>`.
2. Follow the prompt in the CLI to refresh the Kubernetes master API server.
3. [Reload all the worker nodes in your cluster to pick up the public endpoint configuration.](#cs_worker_reload)

```sh
ibmcloud ks cluster master private-service-endpoint disable --cluster CLUSTER [-f] [-q] [-y]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-f`
:   Optional: Force the command to run with no user prompts.

`-q`
:   Optional: Do not show the message of the day or update reminders.

`-y`
:   Optional: Refresh the cluster master and reload worker nodes with no user prompts.

#### Example `cluster master private-service-endpoint disable` command
{: #cluster-master-private-service-endpoint-disable-example}

```sh
ibmcloud ks cluster master private-service-endpoint disable --cluster my_cluster
```
{: pre}

### `ibmcloud ks cluster master private-service-endpoint enable`
{: #cs_cluster_master_pse_enable}

[Classic infrastructure]{: tag-classic-inf}


Enable the [private cloud service endpoint](/docs/containers?topic=containers-plan_basics#workeruser-master) to make your cluster master privately accessible.
{: shortdesc}

To run this command:
1. Enable [VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui) in your IBM Cloud infrastructure account. To check whether a VRF is already enabled, use the `ibmcloud account show` command.
2. [Enable your {{site.data.keyword.cloud_notm}} account to use service endpoints](/docs/account?topic=account-vrf-service-endpoint#service-endpoint).
3. Run `ibmcloud ks cluster master private-service-endpoint enable --cluster <cluster_name>`.
4. Follow the prompt in the CLI to refresh the Kubernetes master API server.
5. [Reload all the worker nodes](#cs_worker_reload) in your cluster to pick up the private endpoint configuration.

```sh
ibmcloud ks cluster master private-service-endpoint enable --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`-y`
:    Optional: Refresh the cluster master and reload worker nodes with no user prompts.


#### Example `cluster master private-service-endpoint enable` command
{: #cluster-master-private-service-endpoint-enable-example}

```sh
ibmcloud ks cluster master private-service-endpoint enable --cluster my_cluster
```
{: pre}



### `ibmcloud ks cluster master public-service-endpoint disable`
{: #cs_cluster_master_pub_se_disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable the public cloud service endpoint for a cluster.
{: shortdesc}

**Important**: Before you disable the public endpoint, you first must complete the following steps to enable the private cloud service endpoint:
1. Enable the private cloud service endpoint by running `ibmcloud ks cluster master private-service-endpoint enable --cluster <cluster_name>`.
2. Follow the prompt in the CLI to refresh the Kubernetes master API server.
3. [Reload all the worker nodes in your cluster to pick up the private endpoint configuration.](#cs_worker_reload)

```sh
ibmcloud ks cluster master public-service-endpoint disable --cluster CLUSTER [-q] [-f]
```
{: pre}


Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.

`-y`
:    Optional: Refresh the cluster master and reload worker nodes with no user prompts.


#### Example `cluster master public-service-endpoint disable` command
{: #cluster-master-public-service-endpoint-disable-example}

```sh
ibmcloud ks cluster master public-service-endpoint disable --cluster my_cluster
```
{: pre}



### `ibmcloud ks cluster master public-service-endpoint enable`
{: #cs_cluster_master_pub_se_enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable the [public cloud service endpoint](/docs/containers?topic=containers-plan_basics#workeruser-master) to make your cluster master publicly accessible.
{: shortdesc}


After you run this command, you must refresh the API server to use the service endpoint by following the prompt in the CLI.

```sh
ibmcloud ks cluster master public-service-endpoint enable --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`-y`
:    Optional: Refresh the cluster master with no user prompts.


#### Example `cluster master public-service-endpoint enable` command
{: #cluster-master-public-service-endpoint-enable-example}

```sh
ibmcloud ks cluster master public-service-endpoint enable --cluster my_cluster
```
{: pre}


### `ibmcloud ks cluster master refresh`
{: #cs_apiserver_refresh}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Apply configuration changes for the Kubernetes master that are requested with the `ibmcloud ks cluster master` commands. The highly available Kubernetes master components are restarted in a rolling restart. Your worker nodes, apps, and resources are not modified and continue to run.
{: shortdesc}

The `apiserver-refresh` and `cluster-refresh` aliases for this command are deprecated.
{: note}

```sh
ibmcloud ks cluster master refresh --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.

### `ibmcloud ks cluster master update`
{: #cs_cluster_update}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}

Update the Kubernetes master and API server. During the update, you can't access or change the cluster. Worker nodes, apps, and resources that were deployed are not modified and continue to run. 
{: shortdesc}

You might need to change your YAML files for future deployments. Review this [release note](/docs/containers?topic=containers-cs_versions) for details.

The `cluster-update` alias for this command is deprecated.
{: note}

```sh
ibmcloud ks cluster master update --cluster CLUSTER [--version MAJOR.MINOR.PATCH] [--force-update] [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--version MAJOR.MINOR.PATCH`
:    Optional: The Kubernetes version of the cluster. If you don't specify a version, the Kubernetes master is updated to the default API version. To see available versions, run [ibmcloud ks versions](#cs_versions_command).

`--force-update`
:    Optional: Attempt the update even if the change is greater than two minor versions from the worker node version.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster master update` command
{: #cluster-master-update-example}

```sh
ibmcloud ks cluster master update --cluster my_cluster
```
{: pre}


### `ibmcloud ks cluster pull-secret apply`
{: #cs_cluster_pull_secret_apply}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Make an {{site.data.keyword.cloud_notm}} IAM service ID for the cluster, create a policy for the service ID that assigns the **Reader** service access role in {{site.data.keyword.registrylong_notm}}, and then create an API key for the service ID. The API key is then stored in a Kubernetes image pull secret so that you can pull images from your {{site.data.keyword.registrylong_notm}} namespaces for containers that are in the `default` Kubernetes namespace. This process happens automatically when you create a cluster. If you got an error during the cluster creation process or have an existing cluster, you can use this command to apply the process again.
{: shortdesc}

By using IAM API keys to access {{site.data.keyword.registrylong_notm}}, you can customize IAM policies for the service ID to restrict access to your namespaces or specific images. For example, you can change the service ID policies in the cluster's image pull secret to pull images from only a certain registry region or namespace. Before you can customize IAM policies, you must [enable {{site.data.keyword.cloud_notm}} IAM policies for {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=Registry-user).
For more information, see [Understanding how your cluster is authorized to pull images from {{site.data.keyword.registrylong_notm}}](/docs/containers?topic=containers-registry#cluster_registry_auth).

When you run this command, the creation of IAM credentials and image pull secrets is initiated and can take some time to complete. You can't deploy containers that pull an image from the {{site.data.keyword.registrylong_notm}} `icr.io` domains until the image pull secrets are created. To check the image pull secrets, run `kubectl get secrets | grep icr-io`. If you added IAM policies to an existing service ID, such as to restrict access to a regional registry, the service ID, IAM policies, and API key for the image pull secret are reset by this command.
{: important}

```sh
ibmcloud ks cluster pull-secret apply --cluster CLUSTER
```
{: pre}

**Minimum required permissions**:
*  **Operator or Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}
*  **Administrator** platform access role in {{site.data.keyword.registrylong_notm}} across all regions and resource groups. The policy can't be scoped to a particular region or resource group.

**Command options**:


`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.


### `ibmcloud ks cluster rm`
{: #cs_cluster_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Delete a cluster. All worker nodes, apps, and containers are permanently deleted. This action can't be undone.
{: shortdesc}

```sh
ibmcloud ks cluster rm --cluster CLUSTER [--force-delete-storage] [--skip-advance-permissions-check] [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--force-delete-storage`
:    Optional: Deletes the cluster and any persistent storage that the cluster uses. **Attention**: If you include this option, the data that is stored in the cluster or its associated storage instances can't be recovered.

`--skip-advance-permissions-check`
:    Optional: Skip [the check for infrastructure permissions](/docs/containers?topic=containers-kubernetes-service-cli#infra_permissions_get) before deleting the cluster. Note that if you don't have the correct infrastructure permissions, the cluster deletion might only partially succeed, such as the IBM-managed master being removed but the worker nodes unable to be removed from your infrastructure account. You might skip the permissions check if you want to continue an otherwise blocked operation, such as when you use multiple infrastructure accounts and can handle the infrastructure resources separately from the master, if needed later.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster rm` command
{: #cluster-rm-example}

```sh
ibmcloud ks cluster rm --cluster my_cluster
```
{: pre}


### `ibmcloud ks cluster service bind`
{: #cs_cluster_service_bind}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Add an IBM Cloud service to a cluster by binding the service instance to a Kubernetes namespace. This command creates service credentials of an {{site.data.keyword.cloud_notm}} service and stores these credentials in a Kubernetes secret in your cluster.
{: shortdesc}

To view available {{site.data.keyword.cloud_notm}} services from the {{site.data.keyword.cloud_notm}} catalog, run `ibmcloud service offerings`. **Note**: You can add only {{site.data.keyword.cloud_notm}} services that support service keys. For more information about service binding and what services you can add to your cluster, see [Adding services by using IBM Cloud service binding](/docs/containers?topic=containers-service-binding).

```sh
ibmcloud ks cluster service bind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE [--key SERVICE_INSTANCE_KEY] [--role IAM_SERVICE_ROLE] --service SERVICE_INSTANCE [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-n, --namespace KUBERNETES_NAMESPACE`
:    Required: The name of the Kubernetes namespace where you want to create the Kubernetes secret for your service credentials.

`--key SERVICE_INSTANCE_KEY`
:    Optional: The name or GUID of an existing service key. When you use the `service-binding` command, new service credentials are automatically created for your service instance and assigned the IAM **Writer** service access role for IAM-enabled services. If you want to use an existing service key that you created earlier, use this option. If you define a service key, you can't set the `--role` option at the same time because your service keys are already created with a specific IAM service access role.

`--role IAM_SERVICE_ROLE`
:    The {{site.data.keyword.cloud_notm}} IAM role that you want the service key to have. This value is optional and can be used for IAM-enabled services only. If you don't set this option, your service credentials are automatically created and assigned the IAM **Writer** service access role. If you want to use existing service keys by specifying the `--key` option, don't include this option.
     To list available roles for the service, run `ibmcloud iam roles --service <service_name>`. The service name is the name of the service in the catalog, which you can get by running `ibmcloud catalog search`.

`--service SERVICE_INSTANCE`
:    Required: The name of the {{site.data.keyword.cloud_notm}} service instance that you want to bind. To find the name, run `ibmcloud resource service-instances`.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster service bind` command
{: #cluster-service-bind-example}

```sh
ibmcloud ks cluster service bind --cluster my_cluster --namespace my_namespace --service my_service_instance
```
{: pre}


### `ibmcloud ks cluster service ls`
{: #cs_cluster_services}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List the services that are bound to one or all the Kubernetes namespace in a cluster. If no options are specified, the services for the default namespace are displayed.
{: shortdesc}

```sh
ibmcloud ks cluster service ls --cluster CLUSTER [--namespace KUBERNETES_NAMESPACE] [--all-namespaces] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-n, --namespace KUBERNETES_NAMESPACE`
:    Optional: Include the services that are bound to a specific namespace in a cluster.

`--all-namespaces`
:    Optional: Include the services that are bound to all the namespaces in a cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster service ls` command
{: #cluster-service-ls-example}

```sh
ibmcloud ks cluster service ls --cluster my_cluster --namespace my_namespace
```
{: pre}


### `ibmcloud ks cluster service unbind`
{: #cs_cluster_service_unbind}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove an {{site.data.keyword.cloud_notm}} service from a cluster by unbinding it from a Kubernetes namespace.
{: shortdesc}

When you remove an {{site.data.keyword.cloud_notm}} service, the service credentials are removed from the cluster. If a pod is still using the service, it fails because the service credentials can't be found.
{: tip}

```sh
ibmcloud ks cluster service unbind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-n, --namespace KUBERNETES_NAMESPACE`
:    Required: The name of the Kubernetes namespace.

`--service SERVICE_INSTANCE`
:    Required: The name of the {{site.data.keyword.cloud_notm}} service instance that you want to remove. To find the name of the service instance, run `ibmcloud ks cluster service ls --cluster <cluster_name_or_ID>`.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster service unbind` command
{: #cluster-service-unbind}

```sh
ibmcloud ks cluster service unbind --cluster my_cluster --namespace my_namespace --service 8567221
```
{: pre}


### `ibmcloud ks cluster subnet add`
{: #cs_cluster_subnet_add}

[Classic infrastructure]{: tag-classic-inf}


Make an existing portable public or private classic subnet in your IBM Cloud infrastructure account available to a cluster or reuse subnets from a deleted cluster instead of using the automatically provisioned subnets.
{: shortdesc}

When you make a subnet available to a cluster, IP addresses of this subnet are used for cluster networking purposes. To avoid IP address conflicts, make sure that you use a subnet with one cluster only. Do not use a subnet for multiple clusters or for other purposes outside of {{site.data.keyword.containerlong_notm}} at the same time. If you use the same subnet across multiple clusters, your default Ingress TLS certificate might become invalidated. To enable communication between workers that are on different subnets on the same VLAN in non-VRF accounts, you must [enable routing between subnets on the same VLAN](/docs/containers?topic=containers-subnets#subnet-routing).
{: important}

```sh
ibmcloud ks cluster subnet add --cluster CLUSTER --subnet-id SUBNET [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--subnet-id SUBNET`
:    Required: The ID of the subnet.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster subnet add` command
{: #cluster-subnet-add-example}

```sh
ibmcloud ks cluster subnet add --cluster my_cluster --subnet-id 1643389
```
{: pre}


### `ibmcloud ks cluster subnet create`
{: #cs_cluster_subnet_create}

[Classic infrastructure]{: tag-classic-inf}


Create a portable classic subnet in an IBM Cloud infrastructure account on your public or private VLAN and make it available to a cluster.
{: shortdesc}

Portable public IP addresses are charged monthly. If you remove portable public IP addresses after your cluster is provisioned, you still must pay the monthly charge, even if you used them only for a short amount of time. When you make a subnet available to a cluster, IP addresses of this subnet are used for cluster networking purposes. To avoid IP address conflicts, make sure that you use a subnet with one cluster only. Do not use a subnet for multiple clusters or for other purposes outside of {{site.data.keyword.containerlong_notm}} at the same time. If you use the same subnet across multiple clusters, your default Ingress TLS certificate might become invalidated. In classic clusters, if you have multiple VLANs for your cluster, multiple subnets on the same VLAN, or a multizone classic cluster, you must enable a [Virtual Router Function (VRF)](/docs/account?topic=account-vrf-service-endpoint&interface=ui) for your IBM Cloud infrastructure account so your worker nodes can communicate with each other on the private network. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** infrastructure permission, or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).
{: important}

```sh
ibmcloud ks cluster subnet create --cluster CLUSTER --size SIZE --vlan VLAN_ID [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster. To list your clusters, use the `ibmcloud ks cluster ls` [command](#cs_clusters).

`--size SIZE`
:    The number of IP addresses that you want to create in the portable subnet. Accepted values are 8, 16, 32, or 64.
     When you add portable IP addresses for your subnet, three IP addresses are used to establish cluster-internal networking. You can't use these three IP addresses for your Ingress application load balancers (ALBs) or to create network load balancer (NLB) services. For example, if you request eight portable public IP addresses, you can use five of them to expose your apps to the public.
     {: note}

`--vlan VLAN_ID`
:    The ID of the public or private VLAN on which you want to create the subnet. You must select a public or private VLAN that an existing worker node is connected to. To review the public or private VLANs that your worker nodes are connected to, run `ibmcloud ks cluster get --cluster <cluster> --show-resources` and look for the **Subnet VLANs** section in the output. The subnet is provisioned in the same zone that the VLAN is in.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster subnet create` command
{: #cluster-subnet-create-example}

```sh
ibmcloud ks cluster subnet create --cluster my_cluster --size 8 --vlan 1764905
```
{: pre}

### `ibmcloud ks cluster subnet detach`
{: #cs_cluster_subnet_detach}

[Classic infrastructure]{: tag-classic-inf}


Detach a public or private portable classic subnet in an IBM Cloud infrastructure account from a cluster. The subnet remains available in your IBM Cloud infrastructure account. **Note**: Any services that were deployed to an IP address from the subnet remain active after the subnet is removed.
{: shortdesc}

```sh
ibmcloud ks cluster subnet detach --cluster CLUSTER --subnet-id SUBNET_ID [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster. To list your clusters, use the `ibmcloud ks cluster ls` [command](#cs_clusters).

`--vlan VLAN_ID`
:    The ID of the public or private subnet that you want to detach. To find the subnet ID, first run `ibmcloud ks cluster get --cluster <cluster> --show-resources` and look for the subnet CIDR in the **Subnet VLANs** section of the output. Then, using the subnet CIDR, run `ibmcloud ks subnets --provider classic` and look for the subnet's **ID**.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `cluster subnet detach` command
{: #cluster-subnet-detach-example}

```sh
ibmcloud ks cluster subnet detach --cluster my_cluster --subnet-id 1602829
```
{: pre}


### Deprecated: `ibmcloud ks cluster user-subnet add`
{: #cs_cluster_user_subnet_add}

[Classic infrastructure]{: tag-classic-inf}


Bring your own private subnet to your {{site.data.keyword.containerlong_notm}} clusters. This private subnet is not one provided by IBM Cloud infrastructure. As such, you must configure any inbound and outbound network traffic routing for the subnet.
{: shortdesc}

This command is deprecated. Add an existing IBM Cloud infrastructure subnet to your cluster by running [`ibmcloud ks cluster subnet add`](#cs_cluster_subnet_add).
{: deprecated}

When you make a subnet available to a cluster, IP addresses of this subnet are used for cluster networking purposes. To avoid IP address conflicts, make sure that you use a subnet with one cluster only. Do not use a subnet for multiple clusters or for other purposes outside of {{site.data.keyword.containerlong_notm}} at the same time. If you use the same subnet across multiple clusters, your default Ingress TLS certificate might become invalidated. In classic clusters, if you have multiple VLANs for your cluster, multiple subnets on the same VLAN, or a multizone classic cluster, you must enable a [Virtual Router Function (VRF)](/docs/account?topic=account-vrf-service-endpoint&interface=ui) for your IBM Cloud infrastructure account so your worker nodes can communicate with each other on the private network. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** infrastructure permission, or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).
{: important}

```sh
ibmcloud ks cluster user-subnet add --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
```
{: pre}


Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--subnet-cidr SUBNET_CIDR`
:    The subnet Classless InterDomain Routing (CIDR). This value is required, and must not conflict with any subnet that is used by IBM Cloud infrastructure. Supported prefixes range from `/30` (1 IP address) to `/24` (253 IP addresses). If you set the CIDR at one prefix length and later need to change it, first add the new CIDR, then [remove the old CIDR](#cs_cluster_user_subnet_rm).

`--private-vlan PRIVATE_VLAN`
:    Required: The ID of the private VLAN. The ID must be for a private VLAN in the cluster that one or more of the worker nodes are on. To see private VLANs in your cluster, run `ibmcloud ks cluster get --cluster <cluster_name_or_ID> --show-resources`. In the **Subnet VLANs** section of the output, look for VLANs that have a **Public** value of `false`.


#### Example `cluster user-subnet add` command
{: #cluster-user-subnet-add-example}

```sh
ibmcloud ks cluster user-subnet add --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
```
{: pre}


### Deprecated: `ibmcloud ks cluster user-subnet rm`
{: #cs_cluster_user_subnet_rm}

[Classic infrastructure]{: tag-classic-inf}


Remove your own private subnet from a specified cluster. Any service that was deployed with an IP address from your own private subnet remains active after the subnet is removed.
{: shortdesc}

This command is deprecated. To remove an IBM Cloud infrastructure subnet from your cluster instead, run [`ibmcloud ks cluster subnet detach`](#cs_cluster_subnet_detach).
{: deprecated}

```sh
ibmcloud ks cluster user-subnet rm --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--subnet-cidr SUBNET_CIDR`
:    The subnet Classless InterDomain Routing (CIDR). This value is required, and must match the CIDR that was set by the `ibmcloud ks cluster user-subnet add` [command](#cs_cluster_user_subnet_add).

`--private-vlan PRIVATE_VLAN`
:    The ID of the private VLAN. This value is required, and must match the VLAN ID that was set by the `ibmcloud ks cluster user-subnet add` [command](#cs_cluster_user_subnet_add).


#### Example `cluster user-subnet rm` command
{: #cluster-user-subnet-rm-example}

```sh
ibmcloud ks cluster user-subnet rm --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
```
{: pre}

## Beta: `dedicated` commands
{: #dedicated_commands}

View, create, and remove a dedicated host or dedicated host pool.
{: shortdesc}

The `dedicated` commands are available in beta.
{: beta}

### Beta: `ibmcloud ks dedicated flavors`
{: #dedicated_flavors}

[Virtual Private Cloud]{: tag-vpc}

View dedicated host flavors.
{: shortdesc}

```sh
ibmcloud ks dedicated flavors --zone ZONE --provider PROVIDER
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--zone ZONE`
:    The zone to search for dedicated host flavors.

`--provider PROVIDER`
:    The provider to use to search for dedicated host flavors.

`--output json`
:    Optional: Prints the command output in JSON format.

**Example**:

```sh
ibmcloud ks dedicated flavors --zone us-south-1 --provider myprovider1
```
{: pre}

### Beta: `ibmcloud ks dedicated host create`
{: #dedicated_host_create}

[Virtual Private Cloud]{: tag-vpc}

Create a dedicated host.
{: shortdesc}

```sh
ibmcloud ks dedicated host create --flavor FLAVOR --pool POOL --zone ZONE [--output OUTPUT] [-q]
```
{: pre}


Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`-- flavor FLAVOR`
:    The flavor of the dedicated host.

`-- pool POOL`
:    The name of the dedicated host pool where the dedicated host is added.

`--zone ZONE`
:    The zone to create the dedicated host in.

`--output json`
:    Optional: Prints the command output in JSON format.

**Example**:

```sh
ibmcloud ks dedicated host create --flavor b3c.4x16 --pool mypool --zone wdc
```
{: pre}

### Beta: `ibmcloud ks dedicated host get`
{: #dedicated_host_get}

[Virtual Private Cloud]{: tag-vpc}

Get the details of a dedicated host.
{: shortdesc}

```sh
ibmcloud ks dedicated host get --host HOST --pool POOL [--output OUTPUT] [-q]
```
{: pre}


Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--host HOST`
:    The ID of the dedicated host.

`--pool POOL`
:    The ID of the dedicated host pool that the dedicated host is located in. To list dedicated host pools run `ibmcloud ks dedicated pool ls`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated host get --host myhost  --pool mypool
```
{: pre}

### Beta: `ibmcloud ks dedicated host ls`
{: #dedicated_host_ls}

[Virtual Private Cloud]{: tag-vpc}

List all dedicated hosts in a dedicated host pool.
{: shortdesc}

```sh
ibmcloud ks dedicated host ls --pool POOL [--output OUTPUT] [-q]
```
{: pre}


Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--pool POOL`
:    The ID of the dedicated host pool. To list dedicated host pools run `ibmcloud ks dedicated pool ls`.

`-q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated host ls --pool mypool
```
{: pre}


### Beta: `ibmcloud ks dedicated host placement disable`
{: #dedicated_host_placement_disable}

[Virtual Private Cloud]{: tag-vpc}

Disable dedicated host placement.
{: shortdesc}

```sh
ibmcloud ks dedicated host placement disable --host HOST --pool POOL
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--host HOST`
:    The ID of the dedicated host to disable placement for.

`--pool POOL`
:    The ID of the dedicated host pool that the dedicated host is located in. To list dedicated host pools run `ibmcloud ks dedicated pool ls`.

`--q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated host placement disable --host myhost --pool mypool
```
{: pre}

### Beta: `ibmcloud ks dedicated host placement enable`
{: #dedicated_host_placement_enable}

[Virtual Private Cloud]{: tag-vpc}

Enable dedicated host placement.
{: shortdesc}

```sh
ibmcloud ks dedicated host placement enable --host HOST --pool POOL
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--host HOST`
:    The ID of the dedicated host to enable placement for.

`--pool POOL`
:    The ID of the dedicated host pool that the dedicated host is located in. To list dedicated host pools run `ibmcloud ks dedicated pool ls`.

`--q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated host placement enable --host myhost --pool mypool
```
{: pre}

### Beta: `ibmcloud ks dedicated host rm`
{: #dedicated_host_rm}

[Virtual Private Cloud]{: tag-vpc}

Delete a dedicated host. This action can't be undone.
{: shortdesc}

```sh
ibmcloud ks dedicated host rm --host HOST --pool POOL [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--pool POOL`
:    The ID of the dedicated host pool that contains the dedicated host to delete. To list dedicated host pools run `ibmcloud ks dedicated pool ls`.

`--output json`
:    Optional: Prints the command output in JSON format.

`--q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated host rm --host myhost --pool mypool
```
{: pre}

### Beta: `ibmcloud ks dedicated pool create`
{: #dedicated_pool_create}

[Virtual Private Cloud]{: tag-vpc}

Create a dedicated host pool.
{: shortdesc}

```sh
ibmcloud ks dedicated pool create --flavor-class CLASS --metro METRO --name NAME [--output OUTPUT]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--flavor-class CLASS`
:    The flavor-class of the dedicated host pool. To see available options, run `ibmcloud ks flavors`.

`--metro METRO`
:    The metro to create the dedicated host pool in, such as `dal` or `wdc`.

`--name NAME`
:    The name of the dedicated host pool.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated pool --flavor-class mb4c.20x64 --metro dal --name mypool
```
{: pre}

### Beta: `ibmcloud ks dedicated pool get`
{: #dedicated_pool_get}

[Virtual Private Cloud]{: tag-vpc}

Get the details of a dedicated host pool.
{: shortdesc}

```sh
ibmcloud ks dedicated pool get --pool POOL [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--pool POOL`
:    The ID of the dedicated host pool. To list dedicated host pools run `ibmcloud ks dedicated pool ls`.

`--output OUTPUT`

`-q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated pool get --pool mypool
```
{: pre}

### Beta: `ibmcloud ks dedicated pool ls`
{: #dedicate_pool_ls}

[Virtual Private Cloud]{: tag-vpc}

List all dedicated host pools.
{: shortdesc}

```sh
ibmcloud ks dedicated pool ls [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--output json`
:    Optional: Prints the command output in JSON format.

`--q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated pool ls
```
{: pre}

### Beta: `ibmcloud ks dedicated pool rm`
{: #dedicated_pool_rm}

[Virtual Private Cloud]{: tag-vpc}

Delete a dedicated host pool. This action can't be undone.
{: shortdesc}

```sh
ibmcloud ks dedicated pool rm --pool POOL [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`--pool POOL`
:    The ID of the dedicated host pool to delete. To list dedicated host pools run `ibmcloud ks dedicated pool ls`.

`--q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks dedicated pool rm --pool mypool
```
{: pre}

## `worker` commands
{: #worker_node_commands}

View and modify worker nodes for a cluster.
{: shortdesc}

### Deprecated: `ibmcloud ks worker add`
{: #cs_worker_add}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Add stand-alone worker nodes to a cluster.
{: shortdesc}

This command is deprecated. Create a worker pool by running [`ibmcloud ks worker-pool create classic`](#cs_worker_pool_create) or [`ibmcloud ks worker-pool create vpc-gen2`](#cli_worker_pool_create_vpc_gen2), or add workers to an existing worker pool by running [`ibmcloud ks worker-pool resize`](#cs_worker_pool_resize).
{: deprecated}

```sh
ibmcloud ks worker add --cluster CLUSTER [--hardware HARDWARE] --flavor FLAVOR --workers NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt] [--operating-system SYSTEM] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--hardware HARDWARE`
:    Optional: The level of hardware isolation for your worker node. Use `dedicated` so that available physical resources are dedicated to you only, or `shared` to allow physical resources to be shared with other IBM customers. The default is `shared`. For bare metal flavors, specify `dedicated`.

`--flavor FLAVOR`
:    Choose a machine type, or flavor, for your worker nodes. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual machines types vary by the zone in which you deploy the cluster. For more information, see the documentation for the `ibmcloud ks flavors (machine-types)` [command](#cs_machine_types).

`--workers NUMBER`
:    An integer that represents the number of worker nodes to create in the cluster.

`--private-vlan PRIVATE_VLAN`
:    Required: The private VLAN that was specified when the cluster was created. Private VLAN routers always begin with `bcr` (back-end router) and public VLAN routers always begin with `fcr` (front-end router). When you create a cluster and specify the public and private VLANs, the number and letter combination after those prefixes must match.

`--public-vlan PUBLIC_VLAN`
:    Optional: The public VLAN that was specified when the cluster was created. If you want your worker nodes to exist on a private VLAN only, don't provide a public VLAN ID. Private VLAN routers always begin with `bcr` (back-end router) and public VLAN routers always begin with `fcr` (front-end router). When you create a cluster and specify the public and private VLANs, the number and letter combination after those prefixes must match.
     If worker nodes are set up with a private VLAN only, you must allow worker nodes and the cluster master to communicate by [enabling the private cloud service endpoint](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se) or [configuring a gateway appliance](/docs/containers?topic=containers-plan_basics#workeruser-master).
     {: note}

`--disable-disk-encrypt`
:    Worker nodes feature AES 256-bit disk encryption by default; [learn more](/docs/containers?topic=containers-security#encrypted_disk). To disable encryption, include this option.


`--operating-system UBUNTU_20_64|UBUNTU_24_64`
:   Optional. The operating system of the worker nodes in your cluster. For a list of available operating systems by cluster version, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions). If no option is specified, the default operating system that corresponds to the cluster version is used.

`-q`
:    Optional: Do not show the message of the day or update reminders.



#### Example `worker add` command
{: #worker-add-example}

```sh
ibmcloud ks worker add --cluster my_cluster --workers 3 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --flavor b3c.4x16 --hardware shared
```
{: pre}


### `ibmcloud ks worker get`
{: #cs_worker_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of a worker node.
{: shortdesc}

```sh
ibmcloud ks worker get --cluster CLUSTER_NAME_OR_ID --worker WORKER_NODE_ID [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c, --cluster CLUSTER_NAME_OR_ID`
:    Optional: The name or ID of the worker node's cluster.

`--worker WORKER_NODE_ID`
:    Required: The name of your worker node. Run `ibmcloud ks worker ls --cluster CLUSTER` to view the IDs for the worker nodes in a cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker get` command
{: #worker-get-example}

```sh
ibmcloud ks worker get --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
```
{: pre}


### `ibmcloud ks worker ls`
{: #cs_workers}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List all worker nodes in a cluster.
{: shortdesc}

```sh
ibmcloud ks worker ls --cluster CLUSTER [--worker-pool POOL] [--show-pools] [--show-deleted] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster for the available worker nodes.

`-p`, `--worker-pool POOL`
:    Optional: View only worker nodes that belong to the worker pool. To list available worker pools, run `ibmcloud ks worker-pool ls --cluster <cluster_name_or_ID>`.

`--show-pools`
:    Optional: List the worker pool that each worker node belongs to.

`--show-deleted`
:    Optional: View worker nodes that were deleted from the cluster, including the reason for deletion.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker ls` command
{: #worker-ls-example}

```sh
ibmcloud ks worker ls --cluster my_cluster
```
{: pre}


### `ibmcloud ks worker reboot`
{: #cs_worker_reboot}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Reboot a worker node in a cluster.
{: shortdesc}

During the reboot, the state of your worker node does not change. For example, you might use a reboot if the worker node status in classic IBM Cloud infrastructure is `Powered Off` and you need to turn on the worker node. A reboot clears temporary directories, but does not clear the entire file system or reformat the disks. The worker node IP address remains the same after the reboot operation.

Rebooting a worker node can cause data corruption on the worker node. Use this command with caution and when you know that a reboot can help recover your worker node. In all other cases, [reload your worker node](#cs_worker_reload) instead.
{: important}

Before you reboot your worker node, make sure that you have enough capacity in other worker nodes to reschedule the pods on the worker node. Rescheduling pods helps to avoid downtime for your app or data corruption on your worker node.

1. List all worker nodes in your cluster and note the **name** of the worker node that you want to remove.
    ```sh
    kubectl get nodes
    ```
    {: pre}

    The **name** that is returned in this command is the private IP address that is assigned to your worker node. You can find more information about your worker node when you run the `ibmcloud ks worker ls --cluster <cluster_name_or_ID>` command and look for the worker node with the same **Private IP** address.

2. Force pods to be removed from your worker node and rescheduled onto remaining worker nodes in the cluster. The worker node is also cordoned, or marked as unavailable for future pod scheduling. Replace `<worker_name>` with the private IP address of the worker node that you previously retrieved.
    ```sh
    kubectl drain <worker_name>
    ```
    {: pre}

    This process can take a few minutes.
3. Reboot the worker node. Use the worker ID that is returned from the `ibmcloud ks worker ls --cluster <cluster_name_or_ID>` command.
    ```sh
    ibmcloud ks worker reboot --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}

4. Wait about 5 minutes before you make your worker node available for pod scheduling to ensure that the reboot is finished. During the reboot, the state of your worker node does not change. The reboot of a worker node is usually completed in a few seconds.
5. Make your worker node available for pod scheduling. Use the **name** for your worker node that is returned from the `kubectl get nodes` command.
    ```sh
    kubectl uncordon <worker_name>
    ```
    {: pre}


```sh
ibmcloud ks worker reboot [--hard] --cluster CLUSTER --worker WORKER_ID [--skip-master-healthcheck] [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--hard`
:    Optional: Use this option to force a hard restart of a worker node by cutting off power to the worker node. Use this option if the worker node is unresponsive or the worker node's container runtime is unresponsive.

`-w, --worker WORKER`
:    Specify a worker node ID. To reload multiple worker nodes, use multiple options, such as `-w worker1_id -w worker2_id`.

`--skip-master-healthcheck`
:    Skip a health check of your master before reloading or rebooting your worker nodes.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker reboot` command
{: #worker-reboot-example}

```sh
ibmcloud ks worker reboot --cluster my_cluster -w kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 -w kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
```
{: pre}



### `ibmcloud ks worker reload`
{: #cs_worker_reload}

[Classic infrastructure]{: tag-classic-inf}


Reload the configurations for a Classic worker node. To reload a worker node in a VPC cluster, use the [**`ibmcloud ks worker replace`** command](#cli_worker_replace) instead.
{: shortdesc}

A reload can be useful if your worker node experiences problems, such as slow performance or if your worker node is stuck in an unhealthy state. During the reload, your worker node machine is updated with the latest image and data is deleted if not [stored outside the worker node](/docs/containers?topic=containers-storage-plan). The worker node public and private IP address remain the same after the reload operation.

Reloading a worker node applies patch version updates to your worker node, but not major or minor updates. To see the changes from one patch version to the next, review the [Version change log](/docs/containers?topic=containers-cs_versions) documentation.
{: tip}

Before you reload your worker node, make sure that you have enough capacity in other worker nodes to reschedule the pods on the worker node. Rescheduling pods helps to avoid downtime for your app or data corruption on your worker node.

1. List all worker nodes in your cluster and note the **name** of the worker node that you want to reload.
    ```sh
    kubectl get nodes
    ```
    {: pre}

    The **name** that is returned in this command is the private IP address that is assigned to your worker node. You can find more information about your worker node when you run the `ibmcloud ks worker ls --cluster <cluster_name_or_ID>` command and look for the worker node with the same **Private IP** address.

2. Reload the worker node. As part of the reload process, the pods that run on the worker node are drained and rescheduled onto remaining worker nodes in the cluster. The worker node is also cordoned, or marked as unavailable for future pod scheduling. Use the worker node ID that is returned from the `ibmcloud ks worker ls --cluster <cluster_name_or_ID>` command.
    ```sh
    ibmcloud ks worker reload --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}

3. Wait for the reload to complete. When your worker node is in a Normal state, the worker node becomes available for pod scheduling again.


```sh
ibmcloud ks worker reload --cluster CLUSTER --worker WORKER_ID [--skip-master-healthcheck] [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-w, --worker WORKER`
:    Specify a worker node ID. To reload multiple worker nodes, use multiple options, such as `-w worker1_id -w worker2_id`.

`--skip-master-healthcheck`
:    Skip a health check of your master before reloading or rebooting your worker nodes.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker reload` command
{: #worker-reload-example}

```sh
ibmcloud ks worker reload --cluster my_cluster -w kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 -w kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
```
{: pre}


### `ibmcloud ks worker replace`
{: #cli_worker_replace}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Delete a worker node and replace it with a new worker node in the same worker pool.
{: shortdesc}

The replacement worker node is created in the same zone and has the same flavor as the old worker node, but might be assigned new public or private IP addresses. You might replace a worker node if you can't reload or update the worker node, such as if it enters a troubled state.

You can also use this command to update the Kubernetes version of the worker node to match the major and minor version of the Kubernetes master by including the `--update` option. If you don't include the `--update` option, patch version updates are applied to your worker node, but not major or minor updates. To see the changes from one major, minor, or patch version to the next, review the [Version change log](/docs/containers?topic=containers-cs_versions) documentation. Remember that your worker nodes can be only up to two versions behind the master version (`n-2`).

When you replace a worker node, keep in mind the following considerations.
{: important}

To update {{site.data.keyword.satelliteshort}} worker nodes, see [Updating hosts that are assigned as worker nodes to Satellite-enabled services](/docs/satellite?topic=satellite-host-update-workers).
{: tip}

* **Multiple worker nodes are replaced concurrently**: If you replace multiple worker nodes at the same time, they are deleted and replaced concurrently, not one by one. Make sure that you have enough capacity in your cluster to reschedule your workloads before you replace worker nodes.
* **Node-level customizations are not preserved**: Any custom labels or taints that you applied at the individual worker node level are not applied to the replacement worker node. Instead, apply [labels](/docs/containers?topic=containers-worker-tag-label) or [taints](#worker_pool_taint) at the worker pool level so that the replacement worker node gets these attributes.
* **Automatic rebalancing**: A replacement worker node is not created if the worker pool does not have [automatic rebalancing enabled](/docs/containers?topic=containers-auto-rebalance-off).

Before you begin, make sure that your cluster has enough other worker nodes so that your pods can be rescheduled and continue to run.

1. List all worker nodes in your cluster and note the **name** of the worker node that you want to replace.
    ```sh
    kubectl get nodes
    ```
    {: pre}

    The **name** that is returned in this command is the private IP address that is assigned to your worker node. You can find more information about your worker node when you run the `ibmcloud ks worker ls --cluster <cluster_name_or_ID>` command and look for the worker node with the same **Private IP** address.

2. Replace the worker node. As part of the replace process, the pods that run on the worker node are drained and rescheduled onto remaining worker nodes in the cluster. The worker node is also cordoned, or marked as unavailable for future pod scheduling. Use the worker node ID that is returned from the `ibmcloud ks worker ls --cluster <cluster_name_or_ID>` command.
    ```sh
    ibmcloud ks worker replace --cluster <cluster_name_or_ID> --worker <worker_node_ID>
    ```
    {: pre}

3. Verify that the worker node is replaced.
    ```sh
    ibmcloud ks worker ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

```sh
ibmcloud ks worker replace --cluster CLUSTER_NAME_OR_ID --worker WORKER_ID [--update] [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--worker WORKER`
:    Required: The name or ID of a worker node.

`--update`
:    Include this option to update the worker node to the same major and minor version of the master and the latest patch.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker replace` command
{: #worker-replace-example}

```sh
ibmcloud ks worker replace --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
```
{: pre}


### `ibmcloud ks worker rm`
{: #cs_worker_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove one or more worker nodes from a cluster. If you remove a worker node, your cluster becomes unbalanced, and [replacing a worker node](#cli_worker_replace) no longer creates a replacement worker node. You can automatically rebalance your worker pool by running the `ibmcloud ks worker-pool rebalance` [command](#cs_rebalance) after you remove a worker node.
{: shortdesc}

```sh
ibmcloud ks worker rm --cluster CLUSTER --worker WORKER [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-w, --worker WORKER`
:    Specify a worker node ID. To reload multiple worker nodes, use multiple options, such as `-w worker1_id -w worker2_id`.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker rm` command
{: #worker-rm-example}

```sh
ibmcloud ks worker rm --cluster my_cluster -w kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 -w kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
```
{: pre}


### `ibmcloud ks worker update`
{: #cs_worker_update}

[Classic infrastructure]{: tag-classic-inf}


Update worker nodes to apply the latest security updates and patches to the operating system, and to update the Kubernetes version to match the version of the Kubernetes master. You can update the master Kubernetes version with the `ibmcloud ks cluster master update` [command](#cs_cluster_update). Remember that your worker nodes can be only up to two versions behind the master version (`n-2`). The worker node IP address remains the same after the update operation.
{: shortdesc}

To update a worker node in a VPC cluster, use the [**`ibmcloud ks worker replace`** command](#cli_worker_replace) instead.
{: note}

Running `ibmcloud ks worker update` can cause downtime for your apps and services. During the update, all pods are rescheduled onto other worker nodes, the worker node is reimaged, and data is deleted if not stored outside the pod. To avoid downtime, [ensure that you have enough worker nodes to handle your workload while the selected worker nodes are updating](/docs/containers?topic=containers-update#worker_node).
{: important}

To update {{site.data.keyword.satelliteshort}} worker nodes, see [Updating hosts that are assigned as worker nodes to Satellite-enabled services](/docs/satellite?topic=satellite-host-update-workers).
{: tip}

You might need to change your YAML files for deployments before you update. Review this [release note](/docs/containers?topic=containers-cs_versions) for details.

```sh
ibmcloud ks worker update --cluster CLUSTER --worker WORKER_ID [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where you list available worker nodes.

`-w, --worker WORKER`
:    Specify a worker node ID. To reload multiple worker nodes, use multiple options, such as `-w worker1_id -w worker2_id`.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker update` command
{: #worker-update-example}

```sh
ibmcloud ks worker update --cluster my_cluster -w kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 -w kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
```
{: pre}



## `worker-pool` commands
{: #worker-pool}

View and modify worker pools for a cluster.
{: shortdesc}

### `ibmcloud ks worker-pool create classic`
{: #cs_worker_pool_create}

[Classic infrastructure]{: tag-classic-inf}


You can create a worker pool in your cluster. When you add a worker pool, it is not assigned a zone by default. You specify the number of workers that you want in each zone and the flavors for the workers. The worker pool is given the default Kubernetes versions. To finish creating the workers, [add a zone or zones](#cs_zone_add) to your pool.
{: shortdesc}

To create a worker pool in a VPC cluster, use the [**`ibmcloud ks worker-pool create vpc-gen2`** command](#cli_worker_pool_create_vpc_gen2).
{: note}

```sh
ibmcloud ks worker-pool create classic --name POOL_NAME --cluster CLUSTER --flavor FLAVOR --size-per-zone WORKERS_PER_ZONE --hardware ISOLATION [--disable-disk-encrypt] [--label KEY1=VALUE1] [--operating-system SYSTEM]  [-q] [--output json]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--name POOL_NAME`
:    The name that you want to give your worker pool.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--flavor FLAVOR`
:    Choose a machine type, or flavor. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual machines types vary by the zone in which you deploy the cluster. For more information, see the documentation for the `ibmcloud ks flavors (machine-types)` [command](#cs_machine_types).

`--size-per-zone WORKERS_PER_ZONE`
:    The number of workers to create in each zone.

`--hardware ISOLATION`
:    Required: The level of hardware isolation for your worker node. Use `dedicated` if you want to have available physical resources that are dedicated to you only, or `shared` to allow physical resources to be shared with other IBM customers. The default is `shared`. For bare metal flavors, specify `dedicated`.

`--disable-disk-encrypt`
:    Specifies that the disk is not encrypted. The default value is `false`.

`-l, --label KEY1=VALUE1`
:    Optional: Apply key-value labels to each worker node in the worker pool. To specify multiple labels, use multiple options, such as `-l key1=value1 -l key2=value2`.

`--operating-system UBUNTU_20_64|UBUNTU_24_64`
:   Optional. The operating system of the worker nodes in your cluster. For a list of available operating systems by cluster version, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions). If no option is specified, the default operating system that corresponds to the cluster version is used.



`-q`
:    Optional: Do not show the message of the day or update reminders.

`--output json`
:    Optional: Prints the command output in JSON format.


#### Example `worker-pool create classic` command
{: #worker-pool-create-classic-example}

```sh
ibmcloud ks worker-pool create classic --name my_pool --cluster my_cluster --flavor b3c.4x16 --size-per-zone 6
```
{: pre}


### `ibmcloud ks worker-pool create vpc-gen2`
{: #cli_worker_pool_create_vpc_gen2}

[Virtual Private Cloud]{: tag-vpc} 

Add a worker pool to a VPC cluster. No worker nodes are created until you [add zones](#cli_zone-add-vpc-gen2) to the worker pool.
{: shortdesc}

```sh
ibmcloud ks worker-pool create vpc-gen2 --name <worker_pool_name> --cluster <cluster_name_or_ID> --flavor <flavor> --size-per-zone <number_of_workers_per_zone> [--operating-system SYSTEM][--dedicated-host-pool POOL][--vpc-id <VPC ID>] [--label KEY1=VALUE1] [--kms-account-id ID] [--kms-instance KMS_INSTANCE_ID] [--crk ROOT_KEY_ID] [--operating-system SYSTEM] [-q] [--secondary-storage STORAGE] [--security-group GROUP ...] [--output json]
```
{: pre}


Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:


`--name NAME`
:    Required: Set the name for the worker pool.

`-c`, `--cluster CLUSTER`
:    Required: Specify the name or ID of the cluster. To list VPC clusters, run `ibmcloud ks cluster ls --provider vpc-gen2`.

`--size-per-zone NUMBER_WORKERS_PER_ZONE`
:    Specify the number of worker nodes to create per zone in this worker pool. No worker nodes are created until you [add zones](#cli_zone-add-vpc-gen2) to the worker pool.

`--operating-system UBUNTU_20_64|UBUNTU_24_64`
:   Optional. The operating system of the worker nodes in your cluster. For a list of available operating systems by cluster version, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions). If no option is specified, the default operating system that corresponds to the cluster version is used.

`--flavor FLAVOR`
:    Choose a flavor for your worker nodes. You can deploy your worker nodes as virtual machines on shared or dedicated hardware. To see flavors that are available in a VPC zone, run `ibmcloud ks flavors --zone <vpc_zone> --provider vpc-gen2`.

`--dedicated-host-pool POOL`
:    Optional. The ID of the dedicated host pool where you want to run your workers. 

`--vpc-id VPC_ID`
:    Optional: Specify the ID of the VPC in which to create the worker pool's worker nodes. The value must match the VPC ID that the cluster is in. To list the cluster's VPC ID, run `ibmcloud ks cluster get -c <cluster_name_or_ID>`. If this option is not provided, then the worker pool defaults to the VPC ID of existing worker pools in the cluster.

`-l, --label KEY1=VALUE1`
:    Optional: Apply key-value labels to each worker node in the worker pool. To specify multiple labels, use multiple options, such as `-l key1=value1 -l key2=value2`.

`--kms-account-id ID`
:    Optional: The ID of the account that contains the KMS instance you want to use for local disk or secret encryption.

`--kms-instance KMS_INSTANCE_ID`
:    Optional: Include the ID of a key management service (KMS) instance to use to encrypt the local disk on the worker nodes in the `default` worker pool. To list available KMS instances, run `ibmcloud ks kms instance ls`. If you include this option, you must also include the `--crk` option. For more information including steps to create, see [Managing encryption for the worker nodes in your cluster](/docs/containers?topic=containers-encryption).

`--crk ROOT_KEY`
:    Optional: Include the ID of the root key in the KMS instance to use to encrypt the local disk on the worker nodes in this worker pool. To list available root keys, run `ibmcloud ks kms crk ls --instance-id`. If you include this option, you must also include the `--kms-instance` option.
     Before you can use KMS encryption, you must create a KMS instance and set up the required service authorization in IAM. See [Managing encryption for the worker nodes in your cluster](/docs/containers?topic=containers-encryption).
     {: note}

`-q`
:    Optional: Do not show the message of the day or update reminders.

`--secondary-storage STORAGE`
:    Optional: The storage option for the flavor. For example, `900gb.5iops-tier`. When you add a secondary disk, that disk is used for the container runtime, while the primary disk is used for the operating system. To view the storage options for a flavor, run the `**ibmcloud ks flavor get --flavor FLAVOR --zone ZONE --provider vpc-gen2` command.

`--security-group GROUP`
:   Optional. Specify one or more security group IDs to apply to all workers on the cluster. For OpenShift version 4.15 and Kubernetes version 1.30 and later, these security groups are applied in addition to the IBM-managed `kube-clusterID` security group. For earlier cluster versions, specify the `--cluster-security-group cluster` option to apply the `kube-clusterID` security group. If no value is specified, a default set of security groups including `kube-clusterID` are applied.

`--output json`
:    Optional: Prints the command output in JSON format.



#### Example `worker-pool create vpc-gen2` command
{: #worker-pool-create-vpc-gen2-example}

```sh
ibmcloud ks worker-pool create vpc-gen2 --name my_pool --cluster my_cluster --flavor bx2.4x16 --size-per-zone 3
```
{: pre}

### `ibmcloud ks worker-pool get`
{: #cs_worker_pool_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of a worker pool.
{: shortdesc}

```sh
ibmcloud ks worker-pool get --worker-pool WORKER_POOL --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-p, --worker-pool WORKER_POOL`
:    Required: The name of the worker node pool that you want to view the details of. To list available worker pools, run `ibmcloud ks worker-pool ls --cluster <cluster_name_or_ID>`.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the worker pool is located.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker-pool get` command
{: #worker-pool-get-example}

```sh
ibmcloud ks worker-pool get --worker-pool pool1 --cluster my_cluster
```
{: pre}


### `ibmcloud ks worker-pool label rm`
{: #cs_worker_pool_label_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove all custom Kubernetes labels from all worker nodes in a worker pool.
{: shortdesc}

An individual taint cannot be removed from a working pool. Instead use `kubectl taint node <worker_privateIP> key:effect-` command to remove a taint from an individual worker node.
{: tip}

```sh
ibmcloud ks worker-pool label rm --cluster CLUSTER --worker-pool POOL [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the worker pool is located.

`-p, --worker-pool WORKER_POOL`
:    Required: The name of the worker node pool that you want to view the details of. To list available worker pools, run `ibmcloud ks worker-pool ls --cluster <cluster_name_or_ID>`.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker-pool label rm` command
{: #worker-pool-label-rm-example}

```sh
ibmcloud ks worker-pool label rm --worker-pool pool1 --cluster my_cluster
```
{: pre}


### `ibmcloud ks worker-pool label set`
{: #cs_worker_pool_label_set}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Set custom Kubernetes labels in the format `key=value` for all the worker nodes in the worker pool. To keep any existing custom labels on the worker pool, you must include those labels in this command.
{: shortdesc}

```sh
ibmcloud ks worker-pool label set --cluster CLUSTER --label LABEL [--label LABEL ...] --worker-pool POOL [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the worker pool is located.

`--label LABEL`
:    Required: A custom label in the format `key=value` to set for all the worker nodes in the worker pool. For multiple labels, repeat this option. To keep any existing custom labels on the worker pool, include those labels with this option. You can list the existing custom labels on worker nodes in the worker pool by running `ibmcloud ks worker-pool get -c <cluster_name_or_ID> --worker-pool <pool>`.

`-p, --worker-pool WORKER_POOL`
:    Required: The name of the worker node pool that you want to view the details of. To list available worker pools, run `ibmcloud ks worker-pool ls --cluster <cluster_name_or_ID>`.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker-pool label set` command
{: #worker-pool-label-set-example}

```sh
ibmcloud ks worker-pool label set --worker-pool pool1 --cluster my_cluster --label app=dev
```
{: pre}


### `ibmcloud ks worker-pool ls`
{: #cs_worker_pools}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List all worker pools in a cluster.
{: shortdesc}

```sh
ibmcloud ks worker-pool ls --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c, --cluster CLUSTER_NAME_OR_ID`
:    Required: The name or ID of the cluster for which you want to list worker pools.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker-pool ls` command
{: #worker-pool-ls-example}

```sh
ibmcloud ks worker-pool ls --cluster my_cluster
```
{: pre}

### `ibmcloud ks worker-pool operating-system set`
{: #worker-pool-operating-system-set-cli}

Set the operating system. After you set the operating system, you must update your workers by running either `ibmcloud ks worker update` or `ibmcloud ks worker replace`.

```txt
ibmcloud ks worker-pool operating-system set --cluster CLUSTER --operating-system SYSTEM --worker-pool POOL [-q]
```
{: pre}
{: #worker-pool-operating-system-set-usage}

#### Command options
{: #worker-pool-operating-system-set-options}

`--cluster CLUSTER`, `-c CLUSTER`
:    Specify the cluster name or ID.

`--operating-system SYSTEM`
:    Specify the name of the operating system.

`-q`
:    Do not show the message of the day or update reminders.

`--worker-pool POOL`, `-p POOL`
:    Specify a worker pool.
{: #worker-pool-operating-system-set-options-dl}


### `ibmcloud ks worker-pool rebalance`
{: #cs_rebalance}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Rebalance a worker pool in a cluster after you delete a worker node. When you run this command, a new worker or workers are added to your worker pool so that the worker pool has the same number of nodes per zone that you specified.
{: shortdesc}



```sh
ibmcloud ks worker-pool rebalance --cluster CLUSTER --worker-pool WORKER_POOL [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-p, --worker-pool WORKER_POOL`
:    Required: The worker pool that you want to rebalance.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker-pool rebalance` command
{: #worker-pool-rebalance-example}

```sh
ibmcloud ks worker-pool rebalance --cluster my_cluster --worker-pool my_pool
```
{: pre}


### `ibmcloud ks worker-pool resize`
{: #cs_worker_pool_resize}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Resize your worker pool to increase or decrease the number of worker nodes that are in each zone of your cluster.
{: shortdesc}

```sh
ibmcloud ks worker-pool resize --cluster CLUSTER --worker-pool WORKER_POOL --size-per-zone WORKERS_PER_ZONE [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:


`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster for which you want to resize worker pools.

`--worker-pool WORKER_POOL`
:    Required: The name of the worker node pool that you want to update.

`--size-per-zone WORKERS_PER_ZONE`
:    The number of workers that you want to have in each zone.

`-q`
:    Optional: Do not show the message of the day or update reminders.



#### Example `worker-pool resize` command
{: #worker-pool-resize-example}

```sh
ibmcloud ks worker-pool resize --cluster my_cluster --worker-pool my_pool --size-per-zone 3
```
{: pre}


### `ibmcloud ks worker-pool rm`
{: #cs_worker_pool_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove a worker pool from your cluster. All worker nodes in the pool are deleted. Your pods are rescheduled when you delete. To avoid downtime, be sure that you have enough workers to run your workload.
{: shortdesc}

```sh
ibmcloud ks worker-pool rm --worker-pool WORKER_POOL --cluster CLUSTER [-q] [-f]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-p, --worker-pool WORKER_POOL`
:    Required: The name of the worker node pool that you want to remove.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster that you want to remove the worker pool from.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`-f`
:    Optional: Force the command to run with no user prompts.


#### Example `worker-pool rm` command
{: #worker-pool-rm-example}

```sh
ibmcloud ks worker-pool rm --cluster my_cluster --worker-pool pool1
```
{: pre}


### `ibmcloud ks worker-pool taint`
{: #worker_pool_taint}

Set or remove Kubernetes taints for all the worker nodes in a worker pool. After you set up taints, pods without a matching toleration can't run on the worker pool. You might use taints to dedicate your worker pool exclusively for a certain type of workload, such as for networking edge nodes or the cluster autoscaler. For more information about how taints and tolerations work, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/){: external}.
{: shortdesc}

#### `ibmcloud ks worker-pool taint set`
{: #worker_pool_taint_set}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Set Kubernetes taints for all the worker nodes in a worker pool. Taints prevent pods without matching tolerations from running on the worker nodes. After you set your custom taint for the worker pool, confirm that the taints are set on the worker nodes by getting the private IP address of the worker node (`ibmcloud ks worker ls -c <cluster_name_or_ID>`) and running `kubectl describe node <worker_private_IP>`.
{: shortdesc}

When you set taints for the worker pool, any custom taints that you previously set with this command are overwritten. To keep your existing custom taints and set new taints, check the worker pool's existing taints and include them when you rerun this command.
{: important}

```sh
ibmcloud ks worker-pool taint set --worker-pool WORKER_POOL --cluster CLUSTER --taint KEY=VALUE:EFFECT [--taint KEY=VALUE2:EFFECT] [-f]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-p, --worker-pool WORKER_POOL`
:    Required: The name of the worker node pool that you want to add the taint to. To list available worker pools, run `ibmcloud ks worker-pool ls -c <cluster_name_or_ID>`.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster with the worker pool that you want to taint.

`--taint KEY=VALUE:EFFECT`
:    Required: The label and effect for the Kubernetes taint that you want to set for the worker pool. Specify the taint in the format `key=value:effect`. The `key=value` is a label pair such as `env=prod` that you use to manage the worker node taint and matching pod tolerations. The `effect` is a [Kubernetes taint effect](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/){: external} such as `NoSchedule`, `PreferNoSchedule`, or `NoExecute` that describes how the taint works. Depending on the effect of the taint that you set, pods that are running on your worker nodes might be evicted.

`-f`
:    Optional: Force the command to run with no user prompts.


#### Example `worker-pool taint set` command
{: #worker-pool-taint-set-example}

```sh
ibmcloud ks worker-pool taint set --cluster my_cluster --worker-pool pool1 --taint env=prod:NoSchedule
```
{: pre}


#### `ibmcloud ks worker-pool taint rm`
{: #worker_pool_taint_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove all Kubernetes taints for all the worker nodes in a worker pool. To check the taints before you remove them, run `ibmcloud ks worker-pool get -c <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>`.
{: shortdesc}

When you remove taints for the worker pool, all Kubernetes taints are removed from the worker pool and its worker nodes. To remove an individual taint from all worker nodes, rerun the `ibmcloud ks worker-pool taint set` command and include only the taints that you want to keep. Or, use `kubectl taint node <worker_privateIP> key:effect-` command to remove a taint from an individual worker node.
{: important}

```sh
ibmcloud ks worker-pool taint rm --worker-pool WORKER_POOL --cluster CLUSTER [-f]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-p, --worker-pool WORKER_POOL`
:    Required: The name of the worker node pool that you want to add the taint to. To list available worker pools, run `ibmcloud ks worker-pool ls -c <cluster_name_or_ID>`.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster with the worker pool that you want to taint.

`-f`
:    Optional: Force the command to run with no user prompts.


#### Example `worker-pool taint rm` command
{: #worker-pool-taint-rm-example}

```sh
ibmcloud ks worker-pool taint rm --cluster my_cluster --worker-pool pool1
```
{: pre}


### `ibmcloud ks worker-pool zones`
{: #cs_worker_pool_zones}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the zones that are attached to a worker pool.
{: shortdesc}

```sh
ibmcloud ks worker-pool zones --worker-pool WORKER_POOL --cluster CLUSTER [-q] [-f]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the worker pool exists.

`-p, --worker-pool WORKER_POOL`
:    Required: The name of the worker node pool that you want to see zones for.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `worker-pool zones` command
{: #worker-pool-zones-example}

```sh
ibmcloud ks worker-pool zones --cluster my_cluster --worker-pool pool1
```
{: pre}



## `zone` commands
{: #zone}

### `ibmcloud ks zone add classic`
{: #cs_zone_add}

[Classic infrastructure]{: tag-classic-inf}


After you create a classic cluster or worker pool, you can add a zone. When you add a zone, worker nodes are added to the new zone to match the number of workers per zone that you specified for the worker pool. You can add more than one zone only if your cluster is in a multizone metro.
{: shortdesc}

To add a zone to worker pools in a VPC cluster, use the [**`ibmcloud ks zone add vpc-gen2`** command](#cli_zone-add-vpc-gen2).
{: note}

```sh
ibmcloud ks zone add classic --zone ZONE --cluster CLUSTER --worker-pool WORKER_POOL [--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN] [--private-only] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--zone ZONE`
:    Required: The zone that you want to add. The zone must be a [multizone-capable zone](/docs/containers?topic=containers-regions-and-zones#zones-mz) within the cluster's region.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-p, --worker-pool WORKER_POOL`
:    The name of the worker pool to add the zone to. To specify multiple worker pools, use multiple options, such as `-p pool1 -p pool2`.

`--private-vlan PRIVATE_VLAN`
:    The ID of the private VLAN. This value is conditional.
     If you have a private VLAN in the zone, this value must match the private VLAN ID of one or more of the worker nodes in the cluster. To see the VLANs that you have available, run `ibmcloud ks cluster get --cluster <cluster> --show-resources`. New worker nodes are added to the VLAN that you specify, but the VLANs for any existing worker nodes are not changed.
     If you don't have a private or public VLAN in that zone, don't specify this option. A private and a public VLAN are automatically created for you when you initially add a zone to your worker pool.
     In classic clusters, if you have multiple VLANs for your cluster, multiple subnets on the same VLAN, or a multizone classic cluster, you must enable a [Virtual Router Function (VRF)](/docs/account?topic=account-vrf-service-endpoint&interface=ui) for your IBM Cloud infrastructure account so your worker nodes can communicate with each other on the private network. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** infrastructure permission, or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).

`--public-vlan PUBLIC_VLAN`
:    The ID of the public VLAN. This value is required if you want to expose workloads on the nodes to the public after you create the cluster. It must match the public VLAN ID of one or more of the worker nodes in the cluster for the zone. To see the VLANs that you have available, run `ibmcloud ks cluster get --cluster <cluster> --show-resources`. New worker nodes are added to the VLAN that you specify, but the VLANs for any existing worker nodes are not changed.
     If you don't have a private or public VLAN in that zone, don't specify this option. A private and a public VLAN are automatically created for you when you initially add a zone to your worker pool.
     In classic clusters, if you have multiple VLANs for your cluster, multiple subnets on the same VLAN, or a multizone classic cluster, you must enable a [Virtual Router Function (VRF)](/docs/account?topic=account-vrf-service-endpoint&interface=ui) for your IBM Cloud infrastructure account so your worker nodes can communicate with each other on the private network. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** infrastructure permission, or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).
     {: note}

`--private-only`
:    Use this option to prevent a public VLAN from being created. Required only when you specify the `--private-vlan` option and don't include the `--public-vlan` option.
     If worker nodes are set up with a private VLAN only, you must enable the private cloud service endpoint or configure a gateway appliance. For more information, see [Planning your private cluster and worker node setup](/docs/containers?topic=containers-plan_basics#private_clusters).
     {: pre}

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `zone add classic` command
{: #zone-add-classic-example}

```sh
ibmcloud ks zone add classic --zone dal10 --cluster my_cluster -p pool1 -w pool2 --private-vlan 2294021
```
{: pre}


### `ibmcloud ks zone add vpc-gen2`
{: #cli_zone-add-vpc-gen2}

[Virtual Private Cloud]{: tag-vpc} 

After you create a Generation 2 VPC cluster or worker pool, you can add a zone. When you add a zone, worker nodes are added to the new zone to match the number of workers per zone that you specified for the worker pool. You can add more than one zone only if your cluster is in a multizone metro.
{: shortdesc}

```sh
ibmcloud ks zone add vpc-gen2 --zone ZONE --subnet-id VPC_SUBNET_ID --cluster CLUSTER --worker-pool WORKER_POOL [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--zone ZONE`
:    Required: The zone that you want to add. It must be a VPC zone within the cluster's region. To see available VPC zones, run `ibmcloud ks zone ls --provider vpc-gen2`.

`--subnet-id SUBNET_ID`
:    Required: The ID of the subnet that you want to add. The VPC subnet must be within the `zone` that you specify. To see available VPC subnets, run `ibmcloud ks subnets --provider vpc-gen2 --vpc-id <vpc> --zone <vpc_zone>`. VPC subnets provide IP addresses for your worker nodes and load balancer services in the cluster, so use a [VPC subnet with enough IP addresses](/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets), such as 256.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster. To list VPC clusters, run `ibmcloud ks cluster ls --provider vpc-gen2`.

`-p, --worker-pool WORKER_POOL`
:    The name of the worker pool to add the zone to. To specify multiple worker pools, use multiple options, such as `-p pool1 -p pool2`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `zone add vpc-gen2` command
{: #zone-add-vpc-gen2-example}

```sh
ibmcloud ks zone add vpc-gen2 --zone us-south-3 --cluster my_cluster -p pool1 -w pool2
```
{: pre}


### `ibmcloud ks zone ls`
{: #cs_datacenters}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}

View a list of available zones that you can create a cluster in.
{: shortdesc}

The `locations` alias for this command is deprecated.
{: note}

```sh
ibmcloud ks zone ls --provider (classic | satellite | vpc-gen2) [--location LOCATION] [--region-only] [--output json] [-q]
```
{: pre}

**Minimum permissions**: None

**Command options**:

`--provider (classic | satellite | vpc-gen2)`
:    The infrastructure provider type to list zones for. This option is required.

`-l, --location LOCATION`
:    Filter output by a specific location. To see supported locations, run `ibmcloud ks locations`. To specify multiple locations, use one option for each location, such as `-l dal -l seo`.

`--region-only`
:    Optional: List multizones only within the region that you are logged in to.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Example**:
```sh
ibmcloud ks zone ls -l ap
```
{: pre}


### `ibmcloud ks zone network-set`
{: #cs_zone_network_set}

[Classic infrastructure]{: tag-classic-inf}


**Multizone classic clusters only**: Set the network metadata for a worker pool to use a different public or private VLAN for the zone than it previously used. Worker nodes that were already created in the pool continue to use the previous public or private VLAN, but new worker nodes in the pool use the new network data.
{: shortdesc}

```sh
ibmcloud ks zone network-set --zone ZONE --cluster CLUSTER  --private-vlan PRIVATE_VLAN --worker-pool WORKER_POOL [--public-vlan PUBLIC_VLAN] [--private-only] [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--zone ZONE`
:    Required: The zone that you want to add. The zone must be a [multizone-capable zone](/docs/containers?topic=containers-regions-and-zones#zones-mz) within the cluster's region.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-p, --worker-pool WORKER_POOL`
:    The name of the worker pool to add the zone to. To specify multiple worker pools, use multiple options, such as `-p pool1 -p pool2`.

`--private-vlan PRIVATE_VLAN`
:    The ID of the private VLAN. This value is required, whether you want to use the same or a different private VLAN than the one that you used for your other worker nodes. New worker nodes are added to the VLAN that you specify, but the VLANs for any existing worker nodes are not changed.
     The private and public VLANs must be compatible, which you can determine from the **Router** ID prefix.
     {: note}

`--public-vlan PUBLIC_VLAN`
:    The ID of the public VLAN. This value is required only if you want to change the public VLAN for the zone. To change the public VLAN, you must always provide a compatible private VLAN. New worker nodes are added to the VLAN that you specify, but the VLANs for any existing worker nodes are not changed.
     The private and public VLANs must be compatible, which you can determine from the **Router** ID prefix.
     {: note}

`--private-only`
:    Optional: Unset the public VLAN so that the workers in this zone are connected to a private VLAN only.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Usage**:
1. Check the VLANs that are available in your cluster.
    ```sh
    ibmcloud ks cluster get --cluster <cluster_name_or_ID> --show-resources
    ```
    {: pre}

    Example output

    ```sh
    Subnet VLANs
    VLAN ID   Subnet CIDR         Public   User-managed
    229xxxx   169.xx.xxx.xxx/29   true     false
    229xxxx   10.xxx.xx.x/29      false    false
    ```
    {: screen}

2. Check that the public and private VLAN IDs that you want to use are compatible. To be compatible, the **Router** must have the same pod ID. Private VLAN routers always begin with `bcr` (back-end router) and public VLAN routers always begin with `fcr` (front-end router). When you create a cluster and specify the public and private VLANs, the number and letter combination after those prefixes must match.
    ```sh
    ibmcloud ks vlan ls --zone <zone>
    ```
    {: pre}

    In the example output, note that **Router** pod IDs match: `01a` and `01a`. If one pod ID was `01a` and the other was `02a`, you can't set these public and private VLAN IDs for your worker pool.
    ```sh
    ID        Name   Number   Type      Router         Supports Virtual Workers
    229xxxx          1234     private   bcr01a.dal12   true
    229xxxx          5678     public    fcr01a.dal12   true
    ```
    {: screen}

3. If you don't have any VLANs available, you can [order new VLANs](/docs/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans).

#### Example `zone network-set` command
{: #zone-network-set-example}

```sh
ibmcloud ks zone network-set --zone dal10 -c my_cluster -p pool1 -p pool2 --private-vlan 2294021
```
{: pre}


### `ibmcloud ks zone rm`
{: #cs_zone_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

**Multizone clusters only**: Remove a zone from one or more worker pools in your cluster. All worker nodes in the worker pool for this zone are deleted.
{: shortdesc}

Before you remove a zone, make sure that you have enough worker nodes in other zones in the cluster so that your pods can reschedule. Rescheduling your pods can avoid a downtime for your app or data corruption on your worker node.
{: tip}

```sh
ibmcloud ks zone rm --cluster CLUSTER --zone ZONE --worker-pool WORKER_POOL [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--zone ZONE`
:    Required: The zone that you want to remove.

`-p, --worker-pool WORKER_POOL`
:    The name of the worker pool to remove the zone from. To specify multiple worker pools, use multiple options, such as `-p pool1 -p pool2`. To remove the zone from all worker pools in the cluster, don't include this option.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `zone rm` command
{: #zone-rm-example}

```sh
ibmcloud ks zone rm --zone dal10 --cluster my_cluster
```
{: pre}



## `ingress` commands
{: #alb-commands}

View and configure Ingress application load balancers (ALBs).
{: shortdesc}

In CLI version 1.0.157 and later, the `ibmcloud ks alb` category is deprecated, and these commands are now listed in the `ibmcloud ks ingress alb` subcategory. For more information, see the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog#10).
{: important}

### `ibmcloud ks ingress alb autoscale get`
{: #cs_alb_autoscale_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Get the details and status of an Ingress ALB autoscaling configuration.
{: shortdesc}

```sh
ibmcloud ks ingress alb autoscale get --alb ALB --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--alb ALB`
:    Required: The name or ID of the ALB to configure autoscaling on.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`--output json`
:    Optional: Prints the command output in JSON format.

#### Example `ingress alb autoscale get` command
{: #ingress-alb-autoscale-get-example}

```sh
ibmcloud ks ingress alb autoscale get --alb myalb123 --cluster mycluster 
``` 
{: pre}


### `ibmcloud ks ingress alb autoscale set`
{: #cs_alb_autoscale_set}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Configure autoscaling to automatically increase or decrease the number of Ingress ALB pods based on the current load. You can choose to scale pods based on CPU utilization, or you can use custom metrics that you specify. If you base autoscaling configuration on CPU utilization, you specify an average CPU utilization rate as well as a maximum and minimum number of pods to be deployed at any given time. If you choose to specify custom metrics for autoscaling, you pass in a path to a custom metric file. 
{: shortdesc}

```sh
ibmcloud ks ingress alb autoscale set --alb ALB --cluster CLUSTER --max-replicas REPLICAS --min-replicas REPLICAS [--output OUTPUT] [-q] (--cpu-average-utilization PERCENT | --custom-metrics-file FILE)
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--alb ALB`
:    Required: The name or ID of the ALB to configure autoscaling on.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.


`--max-replicas REPLICAS`
:   The maximum number of replicas to deployed at any time. This value is required if you include the `---cpu-average-utilization` option.

`--min-replicas REPLICAS`
:   The minimum number of replicas to deploy at any time. This value is required if you include the `---cpu-average-utilization` option.

`--cpu-average-utilization PERCENTAGE`
:   The average utilization threshold used to dynamically calculate the number of replicas.

`--custom-metrics-file`
:   The path to the custom metrics file.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`--output json`
:    Optional: Prints the command output in JSON format.

#### Example `ingress alb autoscale set` command
{: #ingress-alb-autoscale-set-example}

```sh
ibmcloud ks ingress alb autoscale set --alb myalb123 --cluster mycluster --max-replicas 5 --min-replicas 2 --cpu-average-utilization 5
``` 
{: pre}


### `ibmcloud ks ingress alb autoscale unset`
{: #cs_alb_autoscale_unset}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove autoscaling from your Ingress ALBs by deleting the autoscaling configuration.
{: shortdesc}

```sh
ibmcloud ks ingress alb autoscale unset --alb ALB --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--alb ALB`
:    Required: The name or ID of the ALB to configure autoscaling on.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress alb autoscale unset` command
{: #ingress-alb-autoscale-unset-example}

```sh
ibmcloud ks ingress alb autoscale unset --alb myalb123 --cluster mycluster 
``` 
{: pre}

### `ibmcloud ks ingress alb autoupdate disable`
{: #cs_alb_autoupdate_disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable automatic updates of all Ingress ALB pods in a cluster.
{: shortdesc}

By default, automatic updates to Ingress application load balancers (ALBs) are enabled. ALB pods are automatically updated when a new image version is available. To instead update the add-on manually, use this command to disable automatic updates. You can then update ALB pods by running the [`ibmcloud ks ingress alb update` command](#cs_alb_update).

When you update the major or minor Kubernetes version of your cluster, IBM automatically makes necessary changes to the Ingress deployment, but does not change the image version of your Ingress ALB add-on. You are responsible for checking the compatibility of the latest Kubernetes versions and your Ingress ALB add-on images.

```sh
ibmcloud ks ingress alb autoupdate disable --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb autoupdate disable` command
{: #ingress-alb-autoupdate-disable-example}

```sh
ibmcloud ks ingress alb autoupdate disable --cluster mycluster
```
{: pre}


### `ibmcloud ks ingress alb autoupdate enable`
{: #cs_alb_autoupdate_enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable automatic updates of all Ingress ALB pods in a cluster.
{: shortdesc}

If automatic updates for the Ingress ALB add-on are disabled, you can re-enable automatic updates. Whenever the next image version becomes available, the ALBs are automatically updated to the latest build.

```sh
ibmcloud ks ingress alb autoupdate enable --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.


### `ibmcloud ks ingress alb autoupdate get`
{: #cs_alb_autoupdate_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Check whether automatic updates for the Ingress ALB add-on are enabled and whether your ALBs are updated to the latest image version.
{: shortdesc}

```sh
ibmcloud ks ingress alb autoupdate get --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


### `ibmcloud ks ingress alb create classic`
{: #cs_alb_create}

[Classic infrastructure]{: tag-classic-inf}


Create a public or private ALB in a classic cluster. The ALB that you create is enabled by default.
{: shortdesc}

```sh
ibmcloud ks ingress alb create classic --cluster CLUSTER --type (PUBLIC|PRIVATE) --vlan VLAN_ID --zone ZONE [--ip IP] [--version IMAGE_VERSION] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`--type (PUBLIC|PRIVATE)`
:    The type of ALB: `public` or `private`. This type must match the `vlan`.

`--vlan VLAN_ID`
:    The ID of the VLAN to create the ALB on. This VLAN must match the ALB `type` and must be in the same `zone` as the ALB that you want to create.

`--zone ZONE`
:    The zone to create the ALB in.

`--ip IP`
:    Optional: An IP address to assign to the ALB. This IP must be on the `vlan` that you specified and must be in the same `zone` as the ALB that you want to create. This IP address must not be in use by another load balancer or ALB in the cluster. To see the IP addresses that are currently in use, run `kubectl get svc --all-namespaces`.

`--version IMAGE_VERSION`
:    Optional: The version of the image that you want the ALB to run. To list available versions, run `ibmcloud ks ingress alb versions`. To specify a version other than the default, you must first disable automatic updates by running the `ibmcloud ks ingress alb autoupdate disable` command. If you omit this option, the ALB runs the default version of the Kubernetes Ingress image type.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb create classic` command
{: #ingress-alb-create-classic-example}

```sh
ibmcloud ks ingress alb create classic --cluster mycluster --type public --vlan 2234945 --zone dal10 --ip 1.1.1.1 --version 1.1.2_2507_iks
```
{: pre}



### `ibmcloud ks ingress alb create vpc-gen2`
{: #cli_alb-create-vpc-gen2}

[Virtual Private Cloud]{: tag-vpc} 

Create a public or private ALB in a VPC cluster. The ALB that you create is enabled by default.
{: shortdesc}

```sh
ibmcloud ks ingress alb create vpc-gen2 --cluster CLUSTER --type PUBLIC|PRIVATE --zone ZONE [--version IMAGE_VERSION] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster. To view VPC clusters, run `ibmcloud ks cluster ls --provider vpc-gen2`.

`--type PUBLIC|PRIVATE`
:    The type of ALB: `public` or `private`.

`--zone ZONE`
:    The VPC zone to deploy the ALB to.

`--version IMAGE_VERSION`
:    Optional: The version of the image that you want the ALB to run. To list available versions, run `ibmcloud ks ingress alb versions`. To specify a version other than the default, you must first disable automatic updates by running the `ibmcloud ks ingress alb autoupdate disable` command. If you omit this option, the ALB runs the default version of the Kubernetes Ingress image type.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb create vpc-gen2` command
{: #ingress-alb-create-vpc-gen2-example}

```sh
ibmcloud ks ingress alb create vpc-gen2 --cluster mycluster --type public --zone us-south-1 --version 1.1.2_2507_iks
```
{: pre}



### `ibmcloud ks ingress alb disable`
{: #cs_alb_disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable an ALB in your cluster. The ALB and its pods still exist, but stop routing traffic to your apps.
{: shortdesc}

The previous alias for this command, `ibmcloud ks ingress alb configure`, is deprecated.
{: note}

```sh
ibmcloud ks ingress alb disable --alb ALB_ID --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--alb ALB_ID`
:    Required: The ID for an ALB. To view the IDs for the ALBs in a cluster, run `ibmcloud ks ingress alb ls --cluster CLUSTER`.

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb disable` command
{: #ingress-alb-disable-example}

```sh
ibmcloud ks ingress alb disable --alb public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --cluster mycluster
```
{: pre}


### `ibmcloud ks ingress alb enable classic`
{: #cs_alb_configure}

[Classic infrastructure]{: tag-classic-inf}


Enable an ALB in your classic cluster.
{: shortdesc}

The previous alias for this command, `ibmcloud ks ingress alb configure classic`, is deprecated.
{: note}

You can use this command to:
* Enable a default private ALB. When you create a cluster, a default private ALB is created for you in each zone where you have workers and an available private subnet, but the default private ALBs are not enabled. However, all default public ALBs are automatically enabled, and any public or private ALBs that you create with the `ibmcloud ks ingress alb create classic` command are enabled by default too.
* Enable an ALB that you previously disabled.

```sh
ibmcloud ks ingress alb enable classic --alb ALB_ID --cluster CLUSTER [--ip IP_ADDRESS] [--version IMAGE_VERSION] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--alb ALB_ID`
:    Required: The ID for an ALB. To view the IDs for the ALBs in a cluster, run `ibmcloud ks ingress alb ls --cluster CLUSTER`.

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`--ip IP_ADDRESS`
:    Optional: Specify an IP address that is on a VLAN in the zone that the ALB was created in. The ALB is enabled with and uses this public or private IP address.
    This IP address must not be in use by another load balancer or ALB in the cluster. If no IP address is provided, the ALB is deployed with a public or private IP address from the portable public or private subnet that was provisioned automatically when you created the cluster, or if you re-enable an ALB that was previously enabled, the public or private IP address that was previously assigned to the ALB.
    {: note}

`--version IMAGE_VERSION`
:    Optional: The version of the image that you want the ALB to run. To list available versions, run `ibmcloud ks ingress alb versions`. To specify a version other than the default, you must first disable automatic updates by running the `ibmcloud ks ingress alb autoupdate disable` command. If you omit this option, the ALB runs the default version of the same image that the ALB previously ran: either the Kubernetes Ingress image or the {{site.data.keyword.containerlong_notm}} Ingress image.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb enable classic` command
{: #ingress-alb-enable-classic-example}

```sh
ibmcloud ks ingress alb enable classic --alb private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --cluster mycluster --ip 169.XX.XXX.XX --version 1.1.2_2507_iks
```
{: pre}



### `ibmcloud ks ingress alb enable vpc-gen2`
{: #cli_alb_configure_vpc_gen2}

[Virtual Private Cloud]{: tag-vpc} 

Enable an ALB in a VPC cluster.
{: shortdesc}

The previous alias for this command, `ibmcloud ks ingress alb configure vpc-gen2`, is deprecated.
{: note}

You can use this command to:
* Enable a default private ALB. When you create a cluster, a default private ALB is created for you in each zone where you have worker nodes, but the default private ALBs are not enabled. However, all default public ALBs are automatically enabled, and any public or private ALBs that you create with the `ibmcloud ks ingress alb create vpc-gen2` command are enabled by default too.
* Enable an ALB that you previously disabled.

```sh
ibmcloud ks ingress alb enable vpc-gen2 --alb ALB_ID --cluster CLUSTER [--version IMAGE_VERSION] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--alb ALB_ID`
:    Required: The ID for an ALB. To view the IDs for the ALBs in a cluster, run `ibmcloud ks ingress alb ls --cluster CLUSTER`.

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`--version IMAGE_VERSION`
:    Optional: The version of the image that you want the ALB to run. To list available versions, run `ibmcloud ks ingress alb versions`. To specify a version other than the default, you must first disable automatic updates by running the `ibmcloud ks ingress alb autoupdate disable` command. If you omit this option, the ALB runs the default version of the same image that the ALB previously ran: either the Kubernetes Ingress image or the {{site.data.keyword.containerlong_notm}} Ingress image.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb enable vpc-gen2` command
{: #ingress-alb-enable-vpc-gen2-example}

```sh
ibmcloud ks ingress alb enable vpc-gen2 --alb private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --cluster mycluster --version 1.1.2_2507_iks
```
{: pre}



### `ibmcloud ks ingress alb get`
{: #cs_alb_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of an Ingress ALB in a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress alb get --alb ALB_ID --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--alb ALB_ID`
:    Required: The ID for an ALB. To view the IDs for the ALBs in a cluster, run `ibmcloud ks ingress alb ls --cluster CLUSTER`.

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb get` command
{: #ingress-alb-get-example}

```sh
ibmcloud ks ingress alb get --alb public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress alb health-checker disable`
{: #cs_alb_healthchecker_disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable the health checker for an Ingress ALB in a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress alb health-checker disable --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb health-checker disable` command
{: #ingress-alb-health-checker-disable-example}

```sh
ibmcloud ks ingress alb health-checker disable --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress alb health-checker enable`
{: #cs_alb_healthchecker_enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable the health checker for an Ingress ALB in a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress alb health-checker enable --cluster CLUSTER [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb health-checker enable` command
{: #ingress-alb-health-checker-enable-example}

```sh
ibmcloud ks ingress alb health-checker enable --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress alb health-checker get`
{: #cs_alb_healthchecker_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of the health checker for an Ingress ALB in a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress alb health-checker get --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb health-checker get` command
{: #ingress-alb-health-checker-get-example}

```sh
ibmcloud ks ingress alb health-checker get --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress alb ls`
{: #cs_albs}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List all Ingress ALB IDs in a cluster and view whether an update for the ALB pods is available.
{: shortdesc}

If no ALB IDs are returned, then the cluster does not have a portable subnet. You can [create](#cs_cluster_subnet_create) or [add](#cs_cluster_subnet_add) subnets to a cluster. Afterward, ALBs are automatically created for you.
{: tip}

```sh
ibmcloud ks ingress alb ls --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`*-c, --cluster *CLUSTER`
:    Required: The name or ID of the cluster where you list available ALBs.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress alb ls` command
{: #ingress-alb-ls-example}

```sh
ibmcloud ks ingress alb ls --cluster my_cluster
```
{: pre}




### `ibmcloud ks ingress alb update`
{: #cs_alb_update}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Force an update of the pods for individual or all Ingress ALBs in the cluster to the latest or a specific version.
{: shortdesc}

If automatic updates for the Ingress ALB add-on are disabled and you want to update the add-on, you can force a one-time update of your ALB pods. If your ALB pods were recently updated, but a custom configuration for your ALBs is affected by the latest build, you can also use this command to roll back ALB pods to an earlier, supported version. Note that you can use this command to update your ALB image to a different version, but you can't use this command to change your ALB from one type of image to another. After you force a one-time update, automatic updates remain disabled, but can be re-enabled with the `ibmcloud ks ingress alb autoupdate enable` command.

```sh
ibmcloud ks ingress alb update --cluster CLUSTER [--alb ALB1_ID --alb ALB2_ID ...] [--version IMAGE_VERSION] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where you want to update the ALBs.

`--alb CLUSTER`
:    Optional: The ID of the individual ALB to update. To list ALB IDs, run `ibmcloud ks ingress alb ls -c <cluster>`. To update multiple ALBs, use multiple options, such as `--alb ALB1_ID --alb ALB2_ID`. If you omit this option, all ALBs in the cluster are updated.

`--version IMAGE_VERSION`
:    Optional: The version of the image that you want to update ALBs to.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


* To update all ALB pods in the cluster:
    ```sh
    ibmcloud ks ingress alb update -c mycluster --version 1.1.2_2507_iks
    ```
    {: pre}

* To update the ALB pods for one or more specific ALBs:
    ```sh
    ibmcloud ks ingress alb update -c mycluster --version 1.1.2_2507_iks --alb public-crdf253b6025d64944ab99ed63bb4567b6-alb1
    ```
    {: pre}

### `ibmcloud ks ingress alb versions`
{: #cs_alb_versions}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the available Ingress ALB versions.
{: shortdesc}

```sh
ibmcloud ks ingress alb versions [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for {{site.data.keyword.containerlong_notm}}

**Command options**:

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


### `ibmcloud ks ingress domain create`
{: #ingress-domain-create}

Create an Ingress domain for a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress domain create --cluster CLUSTER [--crn CRN] [--default] [--domain DOMAIN] [--hostname HOSTNAME] [--ip IP] [--output OUTPUT] [--domain-provider PROVIDER] [-q] [--secret-namespace NAMESPACE] [--domain-zone ZONE]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where you want to create the domain.

`--crn CRN`
:    Required for {{site.data.keyword.cis_full_notm}} domains. The CRN for the {{site.data.keyword.cis_full_notm}} instance.

`--is-default`
:    Optional. Include this option to set the relevant domain as the default domain for the cluster. 

`--domain DOMAIN`
:    The Ingress domain. You can specify an existing domain, or create a new one. For provider specific information on specifying domains, see [Creating your own Ingress domain](/docs/containers?topic=containers-ingress-domains).

`--hostname HOSTNAME`
:    Optional. For VPC clusters. The hostname to register for the domain. 

`--ip IP`
:    Optional. The IP addresses to register for the domain. 

`--output OUTPUT`
:    Optional: Prints the command output in JSON format.

`--domain-provider PROVIDER`
:    Optional. The external DNS provider type. Available options are `akamai`, `cis-ext`. If no provider is specified, a domain is created with the IBM-managed internal provider.


`--secret-namespace NAMESPACE`
:    Optional. The namespace that the TLS secret is created in. If no namespace is specified, the secret is created in the `default` namespace.

`--domain-zone ZONE`
:    Optional. The Domain ID for your {{site.data.keyword.cis_full_notm}} instance. This is a GUID value.


#### Example `ingress domain create` command
{: #ingress-domain-create-example}

This example command creates a domain registered with the {{site.data.keyword.cloud_notm}} internal provider. For examples to create domains with different providers, see [Creating your own Ingress domain](/docs/containers?topic=containers-ingress-domains).

```sh
ibmcloud ks ingress domain create --cluster my-cluster --domain exampledomain
```
{: pre}

### `ibmcloud ks ingress domain default replace`
{: #ingress-domain-default-replace}

Change a cluster's default Ingress domain.
{: shortdesc}

```sh
ibmcloud ks ingress domain default replace --cluster CLUSTER --domain DOMAIN [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}.

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the domain is applied.

`--domain DOMAIN`
:   Required. The domain that you want to specify as the new default domain for the cluster. You must specify an existing domain. 

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress domain default replace` command
{: #ingress-domain-default-replace-example}

```sh
ibmcloud ks ingress domain default replace --cluster CLUSTER --domain DOMAIN [-q]
```
{: pre}

### `ibmcloud ks ingress domain get`
{: #ingress-domain-get}

View the details of an Ingress domain.
{: shortdesc}

```sh 
ibmcloud ks ingress domain get --cluster CLUSTER --domain DOMAIN [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the domain is applied.

`--domain DOMAIN`
:    Required. The domain that you want to view details for. 

`--output OUTPUT`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress domain get` command
{: #ingress-domain-get-example}

```sh 
ibmcloud ks ingress domain get --cluster CLUSTER --domain DOMAIN [--output OUTPUT] [-q]
```
{: pre}


### `ibmcloud ks ingress domain ls`
{: #ingress-domain-ls}

List all Ingress domains for a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress domain ls --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output OUTPUT`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress domain ls` command
{: #ingress-domain-ls-example}

```sh
ibmcloud ks ingress domain ls --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

### `ibmcloud ks ingress domain rm`
{: #ingress-domain-rm}

Remove an Ingress domain from a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress domain rm --cluster CLUSTER --domain DOMAIN [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the domain is applied.

`--domain DOMAIN`
:    Required. The domain that you want to remove from the cluster. You cannot specify the default domain. If you want to remove the domain that is currently set as the default for your cluster, you must first [replace the default](#ingress-domain-default-replace) with another domain. 

`-f`

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress domain rm` command
{: #ingress-domain-rm-example}

```sh
ibmcloud ks ingress domain rm --cluster CLUSTER --domain DOMAIN [-f] [-q]
```
{: pre}

### `ibmcloud ks ingress domain secret regenerate`
{: #ingress-domain-secret-regenerate}

Regenerate the certificate for an Ingress domain. Run this command to generate a new token in your DNS provider and apply it to your cluster
{: shortdesc}

```sh
ibmcloud ks ingress domain secret regenerate --cluster CLUSTER --domain DOMAIN [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the domain is applied.

`--domain DOMAIN`
:    Required. The domain you want to regenerate. 

`--output OUTPUT`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress domain secret regenerate` command
{: #ingress-domain-secret-regenerate-example}

```sh
ibmcloud ks ingress domain secret regenerate --cluster mycluster --domain exampledomain [--output OUTPUT] [-q]
```
{: pre}

### `ibmcloud ks ingress domain secret rm`
{: #ingress-domain-secret-rm}

Delete the secret for an Ingress domain and prevent future renewal of the certificate.
{: shortdesc} 

```sh
ibmcloud ks ingress domain secret rm --cluster CLUSTER --domain DOMAIN [-f] [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the domain is applied.

`--domain DOMAIN`
:    Required. The domain you want to remove the secret from. 

`-f`

`--output OUTPUT`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress domain secret rm` command
{: #ingress-domain-secret-rm-example}

```sh
ibmcloud ks ingress domain secret rm --cluster CLUSTER --domain DOMAIN [-f] [--output OUTPUT] [-q]
```
{: pre}

### `ibmcloud ks ingress domain update`
{: #ingress-domain-update}

Update an Ingress domain for a cluster to change the hostnames or IP addresses associated with the domain. This command updates all the resources in your cluster with the specified IP addresses or hostnames and changes your app URLs. 
{: shortdesc}

```sh
ibmcloud ks ingress domain update --cluster CLUSTER --domain DOMAIN [--hostname HOSTNAME] [--ip IP] [--ip IP] [-q]
```
{: pre}

Note that when you add IP addresses or hostnames, you must include any IPs or hostnames that are currently registered to the domain. The domain updates with the exact values specified, so any current IP addresses or hostnames are overwritten if they are not included. For example, if `52.137.182.166` is currently registered to your domain and you want to add `52.137.182.270`, you must specify `--ip 52.137.182.166 --ip 52.137.182.270` in the command.
{: important}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where the domain is applied.

`--domain DOMAIN`
:    Required. The domain you want to update. 

`--hostname HOSTNAME`
:    For VPC clusters. The hostname to register for the domain. 

`--ip IP`
:    The IP addresses to register for the domain. The IP addresses passed in fully replace those that are currently associated with the domain. If you want to keep the current IP addresses, you must include them. Specifying this flag with no values unregisters the current IP addresses from the domain.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress domain update` command
{: #ingress-domain-update-example}

```sh
ibmcloud ks ingress domain update --cluster CLUSTER --domain DOMAIN [--hostname HOSTNAME] [--ip IP] [-q]
```
{: pre}



### `ibmcloud ks ingress instance default set`
{: #cs_ingress_instance_default_set}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Set a registered an IBM Cloud {{site.data.keyword.secrets-manager_short}} instance to default. If an existing default instance exists, it will be unset from default.
{: shortdesc}

When you set a new default {{site.data.keyword.secrets-manager_short}} instance, any existing secrets that are not managed by IBM Cloud must have their certificate CRN manually updated to match the CRN of the new default instance. To update the CRN, use the `ibmcloud ks ingress secret update` command. If you do not update the CRN, these secrets do not update at the next scheduled certificate renewal.
{: important}

```sh
ibmcloud ks ingress instance default set --cluster CLUSTER --crn CRN --name NAME [-q] [--secret-group GROUP]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--crn`
:    Required. The CRN of the IBM Cloud Secret Manager instance.

`--name NAME`
:    Required. The name of the Secret Manager instance.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`--secret-group GROUP`
:    Secret group ID of the IBM Cloud Secret Manager instance where the secrets are persisted. To get a secret group ID, see the [{{site.data.keyword.secrets-manager_short}} CLI reference](/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-cli-secret-groups-command).

**Example**:

```sh
ibmcloud ks ingress instance default set --cluster --cluster a111aaa11a1aaaaaaa1 --crn crn:v1:staging:public:secrets-manager:eu-gb:a/1a11a1a111aa11aa111aa1a1111aa1a1:1aaa1a1a-aaaa-11aa-1a11-a11aaa1a11a1:secret:a1a11a11-111a-11a1-aa11-11aaa1a11a11 --name my-secret-manager --namespace default --secret-group 90e059dd-d04e-a32b-010f-4d303b9050b8
```
{: pre}

### `ibmcloud ks ingress instance default unset`
{: #cs_ingress_instance_default_unset}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove a {{site.data.keyword.secrets-manager_short}} instance as the default instance.
{: shortdesc}

If no default instance is set, your secrets are only written directly to the cluster and are not written to any {{site.data.keyword.secrets-manager_short}} instance.
{: important}

```sh
ibmcloud ks ingress instance default unset --cluster CLUSTER --crn CRN --name NAME [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--crn`
:    Required. The CRN of the IBM Cloud Secret Manager instance.

`--name NAME`
:    Required. The name of the Secret Manager instance.

`-q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks ingress instance default unset --cluster --cluster a111aaa11a1aaaaaaa1 --crn crn:v1:staging:public:secrets-manager:eu-gb:a/1a11a1a111aa11aa111aa1a1111aa1a1:1aaa1a1a-aaaa-11aa-1a11-a11aaa1a11a1:secret:a1a11a11-111a-11a1-aa11-11aaa1a11a11 --name my-secret-manager --namespace default
```
{: pre}

### `ibmcloud ks ingress instance get`
{: #cs_ingress_instance_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of a {{site.data.keyword.secrets-manager_short}} instance.
{: shortdesc}

```sh
ibmcloud ks ingress instance get --cluster CLUSTER --name NAME [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--name NAME`
:    Required. The name of the Secret Manager instance.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks ingress instance get --cluster my-cluster --name my-secrets-manager
```
{: pre}

### `ibmcloud ks ingress instance ls`
{: #cs_ingress_instance_ls}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List all {{site.data.keyword.secrets-manager_short}} instances registered to a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress instance ls --cluster CLUSTER [--output OUTPUT] [-q] [--show-deleted]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

`--show-deleted`
:   Optional. Add this option to include instances that were unregistered from the cluster.

**Example**:

```sh
ibmcloud ks ingress instance ls --cluster my-cluster --show-deleted
```
{: pre}

### `ibmcloud ks ingress instance register`
{: #cs_ingress_instance_register}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Register a {{site.data.keyword.secrets-manager_short}} instance to a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress instance register --cluster CLUSTER --crn CRN [--is-default] [--secret-group GROUP] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--crn`
:    Required. The CRN of the IBM Cloud Secret Manager instance.

`--is-default`
:    Optional. Include this option to also set the registered instance as the default {{site.data.keyword.secrets-manager_short}} instance where all Ingress subdomain certificates are stored. If another instance is already set as default, it is removed. Note that you must manually update any certificates or secrets to upload them to the new default instance. Otherwise, they are uploaded at the next scheduled update time for the secret.  

`-q`
:    Optional: Do not show the message of the day or update reminders.

`--secret-group GROUP`
:    Secret group ID of the IBM Cloud Secret Manager instance where the secrets are persisted. To get a secret group ID, see the [{{site.data.keyword.secrets-manager_short}} CLI reference](/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-cli-secret-groups-command).

**Example**:

```sh
ibmcloud ks ingress instance register --cluster my-cluster --crn crn:v1:staging:public:secrets-manager:eu-gb:a/1a11a1a111aa11aa111aa1a1111aa1a1:1aaa1a1a-aaaa-11aa-1a11-a11aaa1a11a1:secret:a1a11a11-111a-11a1-aa11-11aaa1a11a11 --secret-group 90e059dd-d04e-a32b-010f-4d303b9050b8
```
{: pre}

### `ibmcloud ks ingress instance unregister`
{: #cs_ingress_instance_unregister}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove a {{site.data.keyword.secrets-manager_short}} instance from a cluster.
{: shortdesc}

```sh
ibmcloud ks ingress instance unregister --cluster CLUSTER --name NAME [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--name`
:    Required. The name of the {{site.data.keyword.secrets-manager_short}} instance to remove.

`-q`
:    Optional: Do not show the message of the day or update reminders.

**Example**:

```sh
ibmcloud ks ingress instance unregister --cluster my-cluster --name my-secrets-manager-instance
```
{: pre}

### `ibmcloud ks ingress lb get`
{: #cs_ingress_lb_proxy-protocol_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Get the configuration of load balancers that expose Ingress ALBs in your cluster.
{: shortdesc}

For example, if you previously ran commands such as [`ibmcloud ks ingress lb proxy-protocol enable`](#cs_ingress_lb_proxy-protocol_enable), you can use this command to view your configuration changes.

```sh
ibmcloud ks ingress lb get --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:


`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress lb get` command
{: #ingress-lb-get-example}

```sh
ibmcloud ks ingress lb get --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress lb proxy-protocol disable`
{: #cs_ingress_lb_proxy-protocol_disable}

[Virtual Private Cloud]{: tag-vpc} 

Disable the NGINX PROXY protocol for the load balancers in front of all Ingress ALBs in your cluster so that client connection information is no longer passed in request headers to ALBs.
{: shortdesc}

After you run this command, the existing load balancers are deleted and re-created, which can cause service disruptions. Two unused IP addresses must be available in each subnet during the load balancer recreation.
{: important}

```sh
ibmcloud ks ingress lb proxy-protocol disable --cluster CLUSTER [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:



`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress lb proxy-protocol disable` command
{: #ingress-lb-proxy-protocol-disable-example}

```sh
ibmcloud ks ingress lb proxy-protocol disable --cluster mycluster
```
{: pre}


### `ibmcloud ks ingress lb proxy-protocol enable`
{: #cs_ingress_lb_proxy-protocol_enable}

[Virtual Private Cloud]{: tag-vpc} 

Enable the [NGINX PROXY protocol](https://docs.nginx.com/nginx/admin-guide/load-balancer/using-proxy-protocol/){: external} for all load balancers that expose Ingress ALBs in your cluster so that client connection information is passed in request headers to ALBs.
{: shortdesc}

The PROXY protocol enables load balancers to pass client connection information that is contained in headers on the client request to the ALBs. This client information can include the client IP address, the proxy server IP address, and both port numbers.

After you run this command, the existing load balancers are deleted and re-created, which can cause service disruptions. Two unused IP addresses must be available in each subnet during the load balancer recreation.
{: important}

```sh
ibmcloud ks ingress lb proxy-protocol enable --cluster CLUSTER [--cidr CIDR ...] [--header-timeout TIMEOUT] [-f] [-q]
```
{: pre}

Minimum required permissions
:   **Operator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:


`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--cidr CIDR`
:    Optional: Load balancer CIDRs from which ALBs process information in PROXY protocol headers. If requests that contain PROXY headers originate from load balancers in other IP ranges, the information in the headers is not process by the ALB. This option is supported only for ALBs that run the community Kubernetes Ingress image. Default: `0.0.0.0/0`

`--header-timeout TIMEOUT`
:    Optional: The timeout value, in seconds, for the load balancer to receive the PROXY protocol headers that contain the client connection information. This option is supported only for ALBs that run the community Kubernetes Ingress image. Default: `5`

`-f`
:    Optional: Force the command to run with no user prompts.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress lb proxy-protocol enable` command
{: #ingress-lb-proxy-protocol-enable-example}

```sh
ibmcloud ks ingress lb proxy-protocol enable --cluster mycluster --cidr 1.1.1.1/16
```
{: pre}


### `ibmcloud ks ingress secret create`
{: #cs_ingress_secret_create}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Create an Ingress secret in a cluster for a certificate that is stored in {{site.data.keyword.secrets-manager_full}}. This command can be used to create TLS or non-TLS secrets. 
{: shortdesc}

The previous alias for this command, `ibmcloud ks ingress alb cert deploy`, is deprecated. In CLI version 1.0.157 and later, the `ibmcloud ks ingress alb cert` category is deprecated, and these commands are now listed in the `ibmcloud ks ingress secret` subcategory. For more information, see the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog#10).
{: note}

To use the `ibmcloud ks ingress secret create` command, you must have a default [{{site.data.keyword.secrets-manager_short}}](/docs/containers?topic=containers-secrets-mgr) instance registered to your cluster. If you do not have a {{site.data.keyword.secrets-manager_short}} instance and your secrets are instead written directly to your cluster, your secrets do not have the required CRN value and you must manage them with `kubectl` commands. 
{: important}

```sh
ibmcloud ks ingress secret create --cert-crn CERTIFICATE_CRN --cluster CLUSTER --name SECRET_NAME  [--namespace NAMESPACE] [--field CRN] [--persist] [--type] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:


`--cert-crn CERTIFICATE_CRN`
:    Required: The certificate CRN.

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--name SECRET_NAME`
:    Required: Specify a name for the secret. Make sure that you don't create the secret with the same name as the IBM-provided Ingress secret, which you can find by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID> | grep Ingress`.

`--field CRN`
:   Required for non-TLS secrets. Add a field to the secret. You can specify more than one field at a time. For more information, see [Managing non-TLS secret fields](/docs/containers?topic=containers-secrets#non-tls-field). This option is not supported for TLS secrets. 
     - To pull in the secret with the default field name for the secret type, use the default field option: `--field <crn>`. This option is available for all non-TLS secret types. 
     - To specify the field name, use the named field option: `--field name=<crn>`. This option is available for arbitrary and IAM credential secret types.
     - To use the IBM Cloud {{site.data.keyword.secrets-manager_short}} secret as the prefix, use the prefixed field option: `--field prefix=<crn>`. This option is available for IAM credential, username and password, and key value secret types. 

`--namespace NAMESPACE`
:    Optional: Specify the namespace that your Ingress resource is deployed to. If your ALB runs the Kubernetes Ingress image, this value is required, because the ALB can identify secrets only in the same namespace as your Ingress resource. If your ALB runs the {{site.data.keyword.containerlong_notm}} Ingress image, and you don't specify a namespace, the certificate secret is created in a namespace called `ibm-cert-store`. A reference to this secret is then created in the `default` namespace, which any Ingress resource in any namespace can access. While processing requests, the ALB follows the reference to pick up and use the certificate secret from the `ibm-cert-store` namespace.

`--persist`
:    Optional: Persist the secret data in your cluster. If the secret is later deleted from the CLI or {{site.data.keyword.redhat_openshift_notm}} web console, the secret is automatically re-created in your cluster. To permanently delete the secret, you must use the [`/ingress/v2/secret/deleteSecret` API](https://containers.cloud.ibm.com/global/swagger-global-api/#/beta/DeleteIngressSecret).

`--type`
: Optional. The type of secret. Choose from `tls` for certificate CRNs or `opaque` for non-certificate CRNs. For `tls`, specify up to one CRN. For`opaque`, you can specify multiple CRNs. If no secret type is specified, `tls` is applied by default.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress secret create` command
{: #ingress-secret-create-example}

```sh
ibmcloud ks ingress secret create --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff --cluster my_cluster --type tls --name my_alb_secret --namespace demo_ns
```
{: pre}

### `ibmcloud ks ingress secret field add`
{: #cs_ingress_secret_field_add}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Add a non-TLS CRN field to an Opaque secret. There are three ways to specify the field type. The one you choose depends on the secret type and how you want to name the field in the non-TLS secret. For more information, see [Managing non-TLS secret fields](/docs/containers?topic=containers-secrets#non-tls-field).
{: shortdesc}

```sh
ibmcloud ks ingress secret field add --cluster CLUSTER --name SECRET_NAME --field CRN --namespace NAMESPACE [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--name NAME`
:    Required. The name of the secret to add the field to.

`--field CRN`
:    Required. The secret CRN to add to the field. You can specify more than one field at a time. For more information, see [Managing non-TLS secret fields](/docs/containers?topic=containers-secrets#non-tls-field).
     - To pull in the secret with the default field name for the secret type, use the default field option: `--field <crn>`. This option is available for all non-TLS secret types. 
     - To specify the field name, use the named field option: `--field name=<crn>`. This option is available for arbitrary and IAM credential secret types.
     - To use the IBM Cloud {{site.data.keyword.secrets-manager_short}} secret as the prefix, use the prefixed field option: `--field prefix=<crn>`. This option is available for IAM credential, username and password, and key value secret types. 

`--namespace NAMESPACE`
:    Required. The namespace that the secret is deployed to.

`-q`
:    Optional: Do not show the message of the day or update reminders.

**Example to add default, named, and prefixed fields to a set of IAM credentials**:
```sh
ibmcloud ks ingress secret field add --cluster example-cluster --name example-iam-secret --namespace default  --field crn:v1:bluemix:public:secrets-manager:us-south:a/1aa111aa1a11111aaa1a1111aa1aa111:111a1111-11a1 --field unique_iam_name=crn:v1:bluemix:public:secrets-manager:us-south:a/1aa111aa1a11111aaa1a1111aa1aa111:111a1111-11a1 --field prefix=crn:v1:bluemix:public:secrets-manager:us-south:a/1aa111aa1a11111aaa1a1111aa1aa111:111a1111-11a1
```
{: pre}

### `ibmcloud ks ingress secret field ls`
{: #cs_ingress_secret_field_ls}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the CRN fields of an Ingress secret. This command applies only to Opaque secrets.
{: shortdesc}

```sh
ibmcloud ks ingress secret field ls --cluster CLUSTER --name SECRET_NAME --namespace NAMESPACE [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--name NAME`
:    Required. The name of the secret to add the field to.

`--namespace NAMESPACE`
:    Required. The namespace that the secret is deployed to.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress secret field ls` command
{: #ingress-secret-field-ls-example}

```sh
ibmcloud ks ingress secret field ls --cluster a11a11a11a111a1a111a --name my-secret --namespace default
```
{: pre}

### `ibmcloud ks ingress secret field rm`
{: #cs_ingress_secret_field_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


```sh
ibmcloud ks ingress secret field rm --cluster CLUSTER --name NAME --namespace NAMESPACE [--field-name NAME]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--c, --cluster CLUSTER`
:    Required. The name or ID of the cluster.

`--name NAME`
:    Required. The name of the secret to remove the field from.

`--namespace NAMESPACE`
:    Required. The namespace that the secret is deployed to.

`--field-name NAME`
:    The name of the field to remove. To see a list of fields, run [`ibmcloud ks ingress secret field ls`](#cs_ingress_secret_field_ls).

#### Example `ingress secret field rm` command
{: #ingress-secret-field-rm-example}

```sh
ibmcloud ks ingress secret field rm --cluster a11a11a11a111a1a111a --name my-secret --namespace default --field-name test-field-name
```
{: pre}

### `ibmcloud ks ingress secret get`
{: #cs_ingress_secret_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View information about Ingress secrets in your cluster, including secrets stored in {{site.data.keyword.secrets-manager_full}}.
{: shortdesc}

The previous alias for this command, `ibmcloud ks ingress alb cert get`, is deprecated. In CLI version 1.0.157 and later, the `ibmcloud ks ingress alb cert` category is deprecated, and these commands are now listed in the `ibmcloud ks ingress secret` subcategory. For more information, see the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog#10).
{: note}

```sh
ibmcloud ks ingress secret get --cluster CLUSTER --name SECRET_NAME --namespace NAMESPACE [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--name SECRET_NAME`
:    Required: The name of the secret.

`--namespace NAMESPACE`
:    Required: The namespace that the secret is deployed to.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress secret get` command
{: #ingress-secret-get-example}

```sh
ibmcloud ks ingress secret get --cluster my_cluster --name my_alb_secret --namespace demo_ns
```
{: pre}


### `ibmcloud ks ingress secret ls`
{: #cs_ingress_secret_ls}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List Ingress secrets in your cluster, including secrets stored in {{site.data.keyword.secrets-manager_full}}.
{: shortdesc}

The previous alias for this command, `ibmcloud ks ingress alb cert ls`, is deprecated.
{: note}

```sh
ibmcloud ks ingress secret ls --cluster CLUSTER [--show-deleted] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:


`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--show-deleted`
:    Optional: View secrets that were deleted from the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress secret ls` command
{: #ingress-secret-ls-example}

```sh
ibmcloud ks ingress secret ls --cluster my_cluster
```
{: pre}


### `ibmcloud ks ingress secret rm`
{: #cs_ingress_secret_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Delete an Ingress secret from your cluster. If you created a secret for a certificate from {{site.data.keyword.secrets-manager_short}}, only the secret in the cluster is deleted and the certificate remains in your  {{site.data.keyword.secrets-manager_short}} instance.
{: shortdesc}

The previous alias for this command, `ibmcloud ks ingress alb cert rm`, is deprecated. In CLI version 1.0.157 and later, the `ibmcloud ks ingress alb cert` category is deprecated, and these commands are now listed in the `ibmcloud ks ingress secret` subcategory. For more information, see the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog#10).
{: note}

```sh
ibmcloud ks ingress secret rm --cluster CLUSTER --name SECRET_NAME --namespace NAMESPACE [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:


`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--name SECRET_NAME`
:    Required: The name of the secret.

`--namespace NAMESPACE`
:    Required: The namespace that the secret is deployed to.

`-q`
:    Optional: Do not show the message of the day or update reminders.



#### Example `ingress secret rm` command
{: #ingress-secret-rm-example}

```sh
ibmcloud ks ingress secret rm --cluster my_cluster --name my_alb_secret --namespace demo_ns
```
{: pre}


### `ibmcloud ks ingress secret update`
{: #cs_ingress_secret_update}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Update an Ingress secret for a certificate that is not hosted in the default {{site.data.keyword.secrets-manager_short}} instance that was created for your cluster.
{: shortdesc}

Any changes that you make to a certificate in the default {{site.data.keyword.secrets-manager_short}} instance in your cluster are automatically reflected in the secret in your cluster. If you make changes to a certificate that is not hosted in your cluster {{site.data.keyword.secrets-manager_short}} instance, you must use this command to update the secret in your cluster the pick up the certificate changes.

```sh
ibmcloud ks ingress secret update --cluster CLUSTER --name SECRET_NAME --namespace NAMESPACE [--cert-crn CRN] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--name SECRET_NAME`
:    Required: The name of the secret. To see available secrets, run `ibmcloud ks ingress secret ls`.

`--namespace NAMESPACE`
:    Required: The namespace that the secret is deployed to. To see the secret namespace, run `ibmcloud ks ingress secret get --cluster cluster_name_or_ID <--name secret_name> --namespace <namespace>`.

`--cert-crn CERTIFICATE_CRN`
:    Optional: The certificate CRN. To see the secret CRN, run `ibmcloud ks ingress secret get --cluster <cluster_name_or_ID> --name secret_name> --namespace <namespace>`. This option requires a default [{{site.data.keyword.secrets-manager_short}}](/docs/containers?topic=containers-secrets-mgr#secrets-mgr_about) instance in your cluster.

`-q`
:    Optional: Do not show the message of the day or update reminders.



#### Example `ingress secret update` command
{: #ingress-secret-update-example}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

```sh
ibmcloud ks ingress secret update --cluster my_cluster --name my_alb_secret --namespace demo_ns
```
{: pre}




### `ibmcloud ks ingress status-report disable`
{: #cs_ingress_status_report_disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable status reporting for Ingress components in a cluster.

```sh
ibmcloud ks ingress status-report disable --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress status-report disable` command
{: #ingress-status-report-disable-example}

```sh
ibmcloud ks ingress status-report disable --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress status-report enable`
{: #cs_ingress_status_report_enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable the status reporting of the Ingress components in a cluster.

```sh
ibmcloud ks ingress status-report enable --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress status-report enable` command
{: #ingress-status-report-enable-example}

```sh
ibmcloud ks ingress status-report enable --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress status-report get`
{: #cs_ingress_status_report_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Get the status report for Ingress components in a cluster.

```sh
ibmcloud ks ingress status-report get --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress status-report get` command
{: #ingress-status-report-get-example}

```sh
ibmcloud ks ingress status-report get --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress status-report ignored-errors add`
{: #cs_ingress_status_report_add}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Add warnings to be ignored by Ingress status for a cluster.

```sh
ibmcloud ks ingress status-report ignored-errors add --cluster CLUSTER --code CODE [--code CODE ...] [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-code, --code CODE`
:    Required: Code of the warning to be ignored.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress status-report ignored-errors add` command
{: #ingress-status-report-ignored-errors-add-example}

```sh
ibmcloud ks ingress status-report ignored-errors add --cluster mycluster --code CODE
```
{: pre}

### `ibmcloud ks ingress status-report ignored-errors ls`
{: #cs_ingress_status_report_ignore_ls}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List warnings that are currently ignored by Ingress status for a cluster.

```sh
ibmcloud ks ingress status-report ignored-errors ls --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `ingress status-report ignored-errors ls` command
{: #ingress-status-report-ignored-errors-ls-example}

```sh
ibmcloud ks ingress status-report ignored-errors ls --cluster mycluster
```
{: pre}

### `ibmcloud ks ingress status-report ignored-errors rm`
{: #cs_ingress_status_report_ignore_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Remove warnings that are currently ignored by Ingress status for a cluster. Once removed, these warnings are no longer ignored. 

```sh
ibmcloud ks ingress status-report ignored-errors rm --cluster CLUSTER --code CODE [--code CODE ...] [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-code, --code CODE`
:    Required: Code of the warning to be removed from the ignored list.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `ingress status-report ignored-errors rm` command
{: #ingress-status-report-ignored-errors-rm-example}

```sh
ibmcloud ks ingress status-report ignored-errors rm --cluster mycluster
```
{: pre}




## `logging` commands
{: #logging_commands}

Forward logs from your cluster to an external server.
{: shortdesc}

### `ibmcloud ks logging autoupdate disable`
{: #cs_log_autoupdate_disable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Disable automatic updates of all Fluentd pods in a cluster.
{: shortdesc}

Disable automatic updates of your Fluentd pods in a specific cluster. When you update the major or minor Kubernetes version of your cluster, IBM automatically makes necessary changes to the Fluentd ConfigMap, but does not change the image version of your Fluentd for logging add-on. You are responsible for checking the compatibility of the latest Kubernetes versions and your add-on images.

```sh
ibmcloud ks logging autoupdate disable --cluster CLUSTER [-q]
```
{: pre}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where you want to disable automatic updates for the Fluentd add-on.

`-q`
:    Optional: Do not show the message of the day or update reminders.



### `ibmcloud ks logging autoupdate enable`
{: #cs_log_autoupdate_enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Enable automatic updates for your Fluentd pods in a specific cluster. Fluentd pods are automatically updated when a new image version is available.
{: shortdesc}

```sh
ibmcloud ks logging autoupdate enable --cluster CLUSTER [-q]
```
{: pre}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where you want to enable automatic updates for the Fluentd add-on.

`-q`
:    Optional: Do not show the message of the day or update reminders.


### `ibmcloud ks logging autoupdate get`
{: #cs_log_autoupdate_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View whether your Fluentd pods are set to automatically update in a cluster.
{: shortdesc}

```sh
ibmcloud ks logging autoupdate get --cluster CLUSTER [--output json] [-q]
```
{: pre}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster where you want to check whether automatic updates for the Fluentd add-on are enabled.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


### `ibmcloud ks logging config create`
{: #cs_logging_create}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Create a logging configuration. You can use this command to forward logs for containers, applications, worker nodes, Kubernetes clusters, and Ingress application load balancers to an external syslog server.
{: shortdesc}

```sh
ibmcloud ks logging config create --cluster CLUSTER --logsource LOG_SOURCE --type syslog [--namespace KUBERNETES_NAMESPACE] [--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT] [--app-containers CONTAINERS] [--app-paths PATHS_TO_LOGS] [--syslog-protocol PROTOCOL] [--skip-validation] [--force-update] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster

**Command options**:

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster.

`--logsource LOG_SOURCE`
:    The log source to enable log forwarding for. This option supports a comma-separated list of log sources to apply for the configuration. Accepted values are `container`, `application`, `worker`, `kubernetes`, `storage`, and `ingress`. If you don't provide a log source, configurations are created for `container` and `ingress`.

`--type syslog`
:    Enter `syslog` to forward logs to an external server.

`-n, --namespace KUBERNETES_NAMESPACE`
:    The Kubernetes namespace that you want to forward logs from. Log forwarding is not supported for the `ibm-system` and `kube-system` Kubernetes namespaces. This value is valid only for the container log source and is optional. If you don't specify a namespace, then all namespaces in the cluster use this configuration.

`--hostname LOG_SERVER_HOSTNAME`
:    The hostname or IP address of the log collector server.

`--port LOG_SERVER_PORT`
:    Optional: The port of the log collector server. If you don't specify a port, then the standard port `514` is used for `syslog` and the standard port `9091` is used for `ibm`.

`-p, --app-path`
:    The path on the container that the apps are logging to. To forward logs with source type `application`, you must provide a path. Wildcards, such as `/var/log/*.log`, can be used, but recursive globs, such as `/var/log/**/test.log`, can't be used. To specify more than one path, use multiple options, such as `-p /var/log/myApp1/&ast; -p /var/log/myApp2/&ast;`. This value is required for log source `application`.

`--syslog-protocol`
:    The transfer layer protocol that is used when the logging type is `syslog`. Supported values are `tcp`, `tls`, and the default `udp`. When forwarding to a rsyslog server with the `udp` protocol, logs that are over 1 KB are truncated.

`-C, --app-container`
:    To forward logs from apps, you can specify the name of the container that contains your app. To specify more than one container, use multiple options, such as `-C /var/log/myApp1/&ast; -C /var/log/myApp2/&ast;`. If no containers are specified, logs are forwarded from all the containers that contain the paths that you provided. This option is only valid for log source `application`.

`--skip-validation`
:    Optional: Skip validation of the org and space names when they are specified. Skipping validation decreases processing time, but an invalid logging configuration does not correctly forward logs.

`--force-update`
:    Force your Fluentd pods to update to the latest version. Fluentd must be at the latest version to change your logging configurations.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Examples**:

Example for log type `syslog` that forwards from a `container` log source on default port 514:
```sh
ibmcloud ks logging config create my_cluster --logsource container --namespace my_namespace  --hostname 169.xx.xxx.xxx --type syslog
```
{: pre}

Example for log type `syslog` that forwards logs from an `ingress` source on a port different than the default:
```sh
ibmcloud ks logging config create --cluster my_cluster --logsource container --hostname 169.xx.xxx.xxx --port 5514 --type syslog
```
{: pre}


### `ibmcloud ks logging config get`
{: #cs_logging_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View all log forwarding configurations for a cluster, or filter logging configurations based on log source.
{: shortdesc}

```sh
ibmcloud ks logging config get --cluster CLUSTER [--logsource LOG_SOURCE] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--logsource LOG_SOURCE`
:    Optional: The kind of log source for which you want to filter. Logging configurations of only this log source in the cluster are returned. Accepted values are `container`, `storage`, `application`, `worker`, `kubernetes`, and `ingress`.

`--show-covering-filters`
:    Shows the logging filters that render previous filters obsolete.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `logging config get` command
{: #logging-config-get-example}

```sh
ibmcloud ks logging config get --cluster my_cluster --logsource worker
```
{: pre}


### `ibmcloud ks logging config rm`
{: #cs_logging_rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Delete one log forwarding configuration or all logging configurations for a cluster. Deleting the log configuration stops log forwarding to a remote syslog server.
{: shortdesc}

```sh
ibmcloud ks logging config rm --cluster CLUSTER (--namespace NAMESPACE --id LOG_CONFIG_ID] [--all] [--force-update] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`-n, --namespace NAMESPACE`
:    The namespace you want to remove the log forwarding configuration from. If there is more than one config for the same namespace, use the `--id <logging_configuration_ID>` option instead.

`--id LOG_CONFIG_ID`
:    If you want to remove a single logging configuration, the logging configuration ID.

`--all`
:    The option to remove all logging configurations in a cluster.

`--force-update`
:    Force your Fluentd pods to update to the latest version. Fluentd must be at the latest version to change your logging configurations.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `logging config rm` command
{: #logging-config-rm-example}

```sh
ibmcloud ks logging config rm --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
```
{: pre}

### `ibmcloud ks logging config update`
{: #cs_logging_update}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Update the details of a log forwarding configuration.
{: shortdesc}

```sh
ibmcloud ks logging config update --cluster CLUSTER --id LOG_CONFIG_ID --type LOG_TYPE  [--namespace NAMESPACE] [--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT] [--app-paths PATH] [--app-containers PATH] [--output json] [--skipValidation] [--force-update] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--id LOG_CONFIG_ID`
:    Required: The logging configuration ID that you want to update.

`--type LOG_TYPE`
:    Required: The log forwarding protocol that you want to use. Currently, `syslog` and `ibm` are supported.

`-n, --namespace NAMESPACE`
:    The Kubernetes namespace that you want to forward logs from. Log forwarding is not supported for the `ibm-system` and `kube-system` Kubernetes namespaces. This value is valid only for the `container` log source. If you don't specify a namespace, then all namespaces in the cluster use this configuration.

`--hostname LOG_SERVER_HOSTNAME`
:    The hostname or IP address of the log collector server.

`--port LOG_SERVER_PORT`
:    The port of the log collector server. This value is optional when the logging type is `syslog`. If you don't specify a port, then the standard port `514` is used for `syslog` and `9091` is used for `ibm`.

`-p, --app-path`
:    The path on the container that the apps are logging to. To forward logs with source type `application`, you must provide a path. Wildcards, such as `/var/log/*.log`, can be used, but recursive globs, such as `/var/log/**/test.log`, can't be used. To specify more than one path, use multiple options, such as `-p /var/log/myApp1/&ast; -p /var/log/myApp2/&ast;`. This value is required for log source `application`.

`-C, --app-container`
:    To forward logs from apps, you can specify the name of the container that contains your app. To specify more than one container, use multiple options, such as `-C /var/log/myApp1/&ast; -C /var/log/myApp2/&ast;`. If no containers are specified, logs are forwarded from all the containers that contain the paths that you provided. This option is only valid for log source `application`.

`--output json`
:    Optional: Prints the command output in JSON format.

`--skipValidation`
:    Optional: Skip validation of the org and space names when they are specified. Skipping validation decreases processing time, but an invalid logging configuration does not correctly forward logs.

`--force-update`
:    Force your Fluentd pods to update to the latest version. Fluentd must be at the latest version to change your logging configurations.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Example for log type `ibm`**:

```sh
ibmcloud ks logging config update --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
```
{: pre}

**Example for log type `syslog`**:

```sh
ibmcloud ks logging config update --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
```
{: pre}


### `ibmcloud ks logging filter create`
{: #cs_log_filter_create}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Filter out logs that are forwarded by your logging configuration.
{: shortdesc}

```sh
ibmcloud ks logging filter create --cluster CLUSTER --type LOG_TYPE [--logging-config CONFIG] [--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME] [--level LOGGING_LEVEL] [--message MESSAGE] [--regex-message MESSAGE] [--force-update] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster to create a logging filter for.

`--type LOG_TYPE`
:    The type of logs that you want to apply the filter to. Currently `all`, `container`, and `host` are supported.

`-lc, --logging-config CONFIG`
:    Optional: The logging configuration ID. If not provided, the filter is applied to all the cluster logging configurations that are passed to the filter. You can view log configurations that match the filter by using the `--show-matching-configs` option with the command. To specify multiple IDs, use multiple options, such as `-lc id1 -lc id2`.

`-n, --namespace KUBERNETES_NAMESPACE`
:    Optional: The Kubernetes namespace from which you want to filter logs.

`--container CONTAINER_NAME`
:    Optional: The name of the container from which you want to filter out logs. This option applies only when you are using log type `container`.

`--level LOGGING_LEVEL`
:    Optional: Filters out logs that are at the specified level and less. Acceptable values in their canonical order are `fatal`, `error`, `warn/warning`, `info`, `debug`, and `trace`. As an example, if you filtered logs at the `info` level, `debug`, and `trace` are also filtered. **Note**: You can use this option only when log messages are in JSON format and contain a level field. Example output `{"log": "hello", "level": "info"}`

`--message MESSAGE`
:    Optional: Filters out any logs that contain a specified message anywhere in the log. Example: The messages "Hello", "!", and "Hello, World!", would apply to the log "Hello, World!".

`--regex-message MESSAGE`
:    Optional: Filters out any logs that contain a specified message that is written as a regular expression anywhere in the log. Example: The pattern "hello [0-9]" would apply to "hello 1", "hello 2", and "hello 9".

`--force-update`
:    Force your Fluentd pods to update to the latest version. Fluentd must be at the latest version to change your logging configurations.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Examples**:

This example filters out all logs that are forwarded from containers with the name `test-container` in the default namespace that are at the debug level or less, and have a log message that contains "GET request".
```sh
ibmcloud ks logging filter create --cluster example-cluster --type container --namespace default --container test-container --level debug --message "GET request"
```
{: pre}

This example filters out all the logs that are forwarded, at an `info` level or less, from a specific cluster. The output is returned as JSON.
```sh
ibmcloud ks logging filter create --cluster example-cluster --type all --level info --output json
```
{: pre}


### `ibmcloud ks logging filter get`
{: #cs_log_filter_view}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View a logging filter configuration.
{: shortdesc}

```sh
ibmcloud ks logging filter get --cluster CLUSTER [--id FILTER_ID] [--show-matching-configs] [--show-covering-filters] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster that you want to view filters from.

`--id FILTER_ID`
:    The ID of the log filter that you want to view.

`--show-matching-configs`
:    Optional: Show the logging configurations that match the configuration that you're viewing.

`--show-covering-filters`
:    Optional: Show the logging filters that render previous filters obsolete.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `logging filter get` command
{: #logging-filter-get-example}

```sh
ibmcloud ks logging filter get --cluster mycluster --id 885732 --show-matching-configs
```
{: pre}


### `ibmcloud ks logging filter rm`
{: #cs_log_filter_delete}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Delete a logging filter.
{: shortdesc}

```sh
ibmcloud ks logging filter rm --cluster CLUSTER [--id FILTER_ID] [--all] [--force-update] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    The name or ID of the cluster that you want to delete a filter from.

`--id FILTER_ID`
:    The ID of the log filter to delete.

`--all`
:    Optional: Delete all your log forwarding filters.

`--force-update`
:    Force your Fluentd pods to update to the latest version. Fluentd must be at the latest version to change your logging configurations.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `logging filter rm` command
{: #logging-filter-rm-example}

```sh
ibmcloud ks logging filter rm --cluster mycluster --id 885732
```
{: pre}


### `ibmcloud ks logging filter update`
{: #cs_log_filter_update}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Update a logging filter.
{: shortdesc}

```sh
ibmcloud ks logging filter update --cluster CLUSTER --id FILTER_ID --type LOG_TYPE [--logging-config CONFIG] [--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME] [--level LOGGING_LEVEL] [--message MESSAGE] [--regex-message MESSAGE] [--force-update] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster that you want to update a logging filter for.

`--id FILTER_ID`
:    The ID of the log filter to update.

`--type LOG_TYPE`
:    The type of logs that you want to apply the filter to. Currently `all`, `container`, and `host` are supported.

`-lc, --logging-config CONFIG`
:    Optional: The logging configuration ID. If not provided, the filter is applied to all the cluster logging configurations that are passed to the filter. You can view log configurations that match the filter by using the `--show-matching-configs` option with the command. To specify multiple IDs, use multiple options, such as `-lc id1 -lc id2`.

`-n, --namespace KUBERNETES_NAMESPACE`
:    Optional: The Kubernetes namespace from which you want to filter logs.

`--container CONTAINER_NAME`
:    Optional: The name of the container from which you want to filter out logs. This option applies only when you are using log type `container`.

`--level LOGGING_LEVEL`
:    Optional: Filters out logs that are at the specified level and less. Acceptable values in their canonical order are `fatal`, `error`, `warn/warning`, `info`, `debug`, and `trace`. As an example, if you filtered logs at the `info` level, `debug`, and `trace` are also filtered. **Note**: You can use this option only when log messages are in JSON format and contain a level field. Example output `{"log": "hello", "level": "info"}`

`--message MESSAGE`
:    Optional: Filters out any logs that contain a specified message anywhere in the log. Example: The messages "Hello", "!", and "Hello, World!", would apply to the log "Hello, World!".

`--regex-message MESSAGE`
:    Optional: Filters out any logs that contain a specified message that is written as a regular expression anywhere in the log. Example: The pattern "hello [0-9]" would apply to "hello 1", "hello 2", and "hello 9"

`--force-update`
:    Force your Fluentd pods to update to the latest version. Fluentd must be at the latest version to change your logging configurations.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Examples**:

This example filters out all logs that are forwarded from containers with the name `test-container` in the default namespace that are at the debug level or less, and have a log message that contains "GET request".
```sh
ibmcloud ks logging filter update --cluster example-cluster --id 885274 --type container --namespace default --container test-container --level debug --message "GET request"
```
{: pre}

This example filters out all the logs that are forwarded, at an `info` level or less, from a specific cluster. The output is returned as JSON.
```sh
ibmcloud ks logging filter update --cluster example-cluster --id 274885 --type all --level info --output json
```
{: pre}


### `ibmcloud ks logging refresh`
{: #cs_logging_refresh}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Refresh the logging configuration for the cluster. This action refreshes the logging token for any logging configuration that is forwarding to the space level in your cluster.
{: shortdesc}

The `logging config refresh` alias for this command is deprecated.
{: note}

```sh
ibmcloud ks logging refresh --cluster CLUSTER [--force-update] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--force-update`
:    Force your Fluentd pods to update to the latest version. Fluentd must be at the latest version to change your logging configurations.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `logging refresh` command
{: #logging-refresh-example}

```sh
ibmcloud ks logging refresh --cluster my_cluster
```
{: pre}



## `nlb-dns` commands
{: #nlb-dns}

Create and manage subdomains for network load balancer (NLB) IP addresses and health check monitors for subdomains. For more information, see [Registering a load balancer subdomain](/docs/containers?topic=containers-loadbalancer_hostname).
{: shortdesc}

DNS microservice updates are asynchronous and might take several minutes to apply. Note that if you run an `ibmcloud ks nlb-dns` command and receive a 200 confirmation message, you might still have to wait for your changes to be implemented. To check the status of your subdomain, run `ibmcloud ks nlb-dns ls` and find the `Status` column in the output.
{: tip}

### `ibmcloud ks nlb-dns add`
{: #cs_nlb-dns-add}

[Classic infrastructure]{: tag-classic-inf}


Add one or more network load balancer (NLB) IP addresses to an existing subdomain that you created with the `ibmcloud ks nlb-dns create` command.
{: shortdesc}

For example, in a multizone classic cluster, you might create an NLB in each zone to expose an app. You register the NLB IPs with a subdomain by running `ibmcloud ks nlb-dns create classic`. Later, you add another zone to your cluster and another NLB for that zone. You can use this command to add the new NLB IP to this existing subdomain. When a user accesses your app subdomain, the client accesses one of these IPs at random, and the request is sent to that NLB.

```sh
ibmcloud ks nlb-dns add --cluster CLUSTER --ip NLB_IP [--ip NLB2_IP2 --ip NLB3_IP ...] --nlb-host SUBDOMAIN [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--ip NLB_IP`
:    The NLB IP address(es) that you want to add to the subdomain. To see your NLB IPs, run `kubectl get svc`. To specify multiple IP addresses, use multiple `--ip` options.

`--nlb-host SUBDOMAIN`
:    The subdomain that you want to add IPs to. To see existing subdomains, run `ibmcloud ks nlb-dns ls`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns add` command
{: #nlb-dns-add-example}

```sh
ibmcloud ks nlb-dns add --cluster mycluster --ip 1.1.1.1 --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}


### `ibmcloud ks nlb-dns create classic`
{: #cs_nlb-dns-create}

[Classic infrastructure]{: tag-classic-inf}


Publicly expose your app by creating a DNS subdomain to register a network load balancer (NLB) IP.
{: shortdesc}

```sh
ibmcloud ks nlb-dns create classic --cluster CLUSTER --ip NLB_IP [--ip NLB2_IP --ip NLB3_IP ...] [--secret-namespace NAMESPACE] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--ip IP`
:    The network load balancer IP address that you want to register. To see your NLB IP addresses, run `kubectl get svc`. To specify multiple IP addresses, use multiple `--ip` options.

`--secret-namespace NAMESPACE`
:    The Kubernetes namespace where you want to create the Kubernetes secret that holds the SSL certificate information for the NLB. If you don't specify a namespace, the secret is automatically created in the `default` namespace.

`--type public`
:    The subdomain type. Currently, only `public` is supported.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns create classic` command
{: #nlb-dns-create-classic-example}

```sh
ibmcloud ks nlb-dns create classic --cluster mycluster --ip 1.1.1.1
```
{: pre}


### `ibmcloud ks nlb-dns create vpc-gen2`
{: #cs_nlb-dns-create-vpc-gen2}

[Virtual Private Cloud]{: tag-vpc}

Create a DNS record for a Network Load Balancer for VPC or Application Load Balancer for VPC.
{: shortdesc}

When you create a Network Load Balancer for VPC, the load balancer is assigned external IP addresses for each zone in your cluster. When you create an Application Load Balancer for VPC, the load balancer is assigned a hostname. If you want an app subdomain with TLS termination, you can use the `ibmcloud ks nlb-dns create vpc-gen2` command to create a DNS record for the IP addresses or hostname. {{site.data.keyword.cloud_notm}} takes care of generating and maintaining the wildcard SSL certificate for the subdomain for you. You can create subdomains for both public and private VPC load balancers.

```sh
ibmcloud ks nlb-dns create vpc-gen2 --cluster CLUSTER (--lb-host VPC_ALB_HOSTNAME | --ip VPC_NLB_IP) [--secret-namespace NAMESPACE] [--type (public|private)] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--lb-host VPC_ALB_HOSTNAME` | `--ip VPC_NLB_IP`
:    For VPC application load balancers, the load balancer hostname. To see load balancer hostnames, run `kubectl get svc -o wide`. For VPC network load balancers, the external IP addresses. To specify multiple IP addresses, use multiple `--ip` options. To see load balancer IP addresses, run `kubectl get svc -o wide`.

`--secret-namespace NAMESPACE`
:    The Kubernetes namespace where you want to create the Kubernetes secret that holds the SSL certificate information for the NLB. If you don't specify a namespace, the secret is automatically created in the `default` namespace.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns create vpc-gen2` command
{: #nlb-dns-create-vpc-gen2-example}

```sh
ibmcloud ks nlb-dns create vpc-gen2 --cluster mycluster --lb-host 1234abcd-us-south.lb.appdomain.cloud --type public
```
{: pre}



### `ibmcloud ks nlb-dns get`
{: #cs_nlb-dns-get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the details of a registered NLB host name in a cluster.
{: shortdesc}

```sh
ibmcloud ks nlb-dns get --cluster CLUSTER --nlb-subdomain SUBDOMAIN [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--nlb-subdomain SUBDOMAIN`
:   The DNS subdomain where your network load balancer (NLB) IP address is registered. To list NLBs, run `ibmcloud ks nlb-dns ls --cluster mycluster`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns get` command
{: #nlb-dns-get-example}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

```sh
ibmcloud ks nlb-dns get --cluster mycluster --nlb-subdomain subDomain1
```
{: pre}

### `ibmcloud ks nlb-dns ls`
{: #cs_nlb-dns-ls}

In a classic cluster, list the network load balancer (NLB) IP addresses that are registered to DNS subdomains. In a VPC cluster, list the VPC load balancer hostnames that are registered to DNS subdomains.
{: shortdesc}

```sh
ibmcloud ks nlb-dns ls --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns ls` command
{: #nlb-dns-ls-example}

```sh
ibmcloud ks nlb-dns ls --cluster mycluster
```
{: pre}


### `ibmcloud ks nlb-dns monitor configure`
{: #nlb-dns-monitor-configure-cli}

Configure a health check monitor for an existing NLB host name in a cluster. To enable the monitor, include the `--enable` flag. To update an existing monitor, include only the flags for the settings that you want to change.

```txt
ibmcloud ks nlb-dns monitor configure --cluster CLUSTER --nlb-host HOST [--enable] [--header HEADER ...] [--interval INTERVAL] [--output OUTPUT] [--path PATH] [--port PORT] [-q] [--timeout TIMEOUT] [--type TYPE]
```
{: pre}
{: #nlb-dns-monitor-configure-usage}

### Command options
{: #nlb-dns-monitor-configure-options}

`--cluster CLUSTER`, `-c CLUSTER`
:    Specify the cluster name or ID.

`--enable`
:    Enable the health check monitor for the host name.

`--header HEADER`
:   Required when `type` is `HTTP` or `HTTPS`: HTTP request headers for the health check are limited to the Host header. This flag is valid only for type 'HTTP' or 'HTTPS'. This flag accepts values in the following format: '--header Header-Name=value'. When updating a monitor, the existing headers are replaced by the ones you specify. To delete all existing headers specify the flag with an empty value '--header ""'.

`--interval INTERVAL`
:    The interval, in seconds, between each health check. Short intervals might improve failover time but increase load on the IPs. The value must be in the range [60, 300]. Default: `60`

`--nlb-host HOST`
:    The host name. To see existing host names, run `ibmcloud ks nlb-dns ls`.

`--output OUTPUT`
:    Prints the command output in the provided format. Accepted values: `json`

`--path PATH`
:    The endpoint path to health check against. This flag is valid only for type `HTTP` or `HTTPS`. Default: `/` 

`--port PORT`
:    The port number to connect to for the health check. When type is TCP, this flag is required. When type is HTTP or HTTPS, use this flag only for ports other than 80 for HTTP or 443 for HTTPS. HTTP default: `80`. HTTPS default: `443`.

`-q`
:    Do not show the message of the day or update reminders.

`--timeout TIMEOUT`
:    The timeout, in seconds, before the IP is considered unhealthy. Must be in the range [1, 60]. Default: `5`

`--type TYPE`
:    The protocol to use for the health check. Accepted values: `http`, `https`, `tcp`
{: #nlb-dns-monitor-configure-options-dl}




#### Example `nlb-dns monitor configure` command
{: #nlb-dns-monitor-configure-example}



```sh
ibmcloud ks nlb-dns monitor configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --type HTTPS --path / --timeout 5 --interval 60 --header Host=example.com
```
{: pre}

### `ibmcloud ks nlb-dns monitor disable`
{: #cs_nlb-dns-monitor-disable}

[Classic infrastructure]{: tag-classic-inf}


Disable an existing health check monitor for a subdomain in a cluster.
{: shortdesc}

```sh
ibmcloud ks nlb-dns monitor disable --cluster CLUSTER --nlb-host SUBDOMAIN [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--nlb-host SUBDOMAIN`
:    The subdomain that the monitor health checks. To list subdomains, run `ibmcloud ks nlb-dns ls --cluster CLUSTER`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns monitor disable` command
{: #nlb-dns-monitor-disable-example}

```sh
ibmcloud ks nlb-dns monitor disable --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}



### `ibmcloud ks nlb-dns monitor enable`
{: #cs_nlb-dns-monitor-enable}

[Classic infrastructure]{: tag-classic-inf}


Enable a health check monitor that you configured.
{: shortdesc}

The first time that you create a health check monitor, you must configure and enable it with the `ibmcloud ks nlb-dns monitor configure` command. Use the `ibmcloud ks nlb-dns monitor enable` command only to enable a monitor that you configured but did not yet enable, or to re-enable a monitor that you previously disabled.

```sh
ibmcloud ks nlb-dns monitor enable --cluster CLUSTER --nlb-host SUBDOMAIN [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--nlb-host SUBDOMAIN`
:    The subdomain that the monitor health checks. To list subdomains, run `ibmcloud ks nlb-dns ls --cluster CLUSTER`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns monitor enable` command
{: #nlb-dns-monitor-enable-example}

```sh
ibmcloud ks nlb-dns monitor enable --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}


### `ibmcloud ks nlb-dns monitor get`
{: #cs_nlb-dns-monitor-get}

[Classic infrastructure]{: tag-classic-inf}


View the settings for an existing health check monitor.
{: shortdesc}

```sh
ibmcloud ks nlb-dns monitor get --cluster CLUSTER --nlb-host SUBDOMAIN [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--nlb-host SUBDOMAIN`
:    The subdomain that the monitor health checks. To list subdomains, run `ibmcloud ks nlb-dns ls --cluster CLUSTER`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns monitor get` command
{: #nlb-dns-monitor-get-example}

```sh
ibmcloud ks nlb-dns monitor get --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}


### `ibmcloud ks nlb-dns monitor ls`
{: #cs_nlb-dns-monitor-ls}

[Classic infrastructure]{: tag-classic-inf}


List the health check monitor settings for each NLB subdomain in a cluster.
{: shortdesc}

```sh
ibmcloud ks nlb-dns monitor ls --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns monitor ls` command
{: #nlb-dns-monitor-ls-example}

```sh
ibmcloud ks nlb-dns monitor ls --cluster mycluster
```
{: pre}


### `ibmcloud ks nlb-dns replace`
{: #cs_nlb-dns-replace}

[Virtual Private Cloud]{: tag-vpc} 

Replace the load balancer hostname that is registered with a DNS subdomain. For example, if you create a new VPC load balancer for your app, but you don't want to create a new DNS subdomain through which users can access your app, you can replace the hostname of the old load balancer with the hostname of the new load balancer.
{: shortdesc}

```sh
ibmcloud ks nlb-dns replace --cluster CLUSTER --lb-host NEW_LB_HOSTNAME --nlb-subdomain SUBDOMAIN [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--lb-host NEW_LB_HOSTNAME`
:    The hostname of the new VPC load balancer to update the subdomain with. To see VPC load balancer hostnames, run `kubectl get svc -o wide`.

`nlb-subdomain SUBDOMAIN`
:    The DNS subdomain that you want to replace the load balancer hostname for. To see existing subdomains, run `ibmcloud ks nlb-dns ls --cluster <cluster>`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns replace` command
{: #nlb-dns-replace-example}

```sh
ibmcloud ks nlb-dns replace --cluster mycluster --lb-host 1234abcd-us-south.lb.appdomain.cloud nlb-subdomain mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}


### `ibmcloud ks nlb-dns rm classic`
{: #cs_nlb-dns-rm}

[Classic infrastructure]{: tag-classic-inf}


Remove a network load balancer (NLB) IP address from a subdomain. If you remove all IPs from a subdomain, the subdomain still exists but no IPs are associated with it. **Note**: You must run this command for each IP address that you want to remove.
{: shortdesc}

```sh
ibmcloud ks nlb-dns rm classic --cluster CLUSTER --ip IP --nlb-host SUBDOMAIN [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--ip IP`
:    The NLB IP that you want to remove. To see the IPs registered with each subdomain, run `ibmcloud ks nlb-dns ls --cluster <cluster>`.

`--nlb-host SUBDOMAIN`
:    The subdomain that you want to remove an IP from. To see existing subdomains, run `ibmcloud ks nlb-dns ls`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns rm classic` command
{: #nlb-dns-rm-classic-example}

```sh
ibmcloud ks nlb-dns rm classic --cluster mycluster --ip 1.1.1.1 --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}


### `ibmcloud ks nlb-dns rm vpc-gen2`
{: #cs_nlb-dns-rm-vpc-gen2}

[Virtual Private Cloud]{: tag-vpc} 

Remove the load balancer hostname (VPC application load balancers) or IP addresses (VPC network load balancers) from the DNS record for that load balancer.
{: shortdesc}

After you remove the hostname or IP addresses, the DNS subdomain still exists, but no load balancer is registered with it.

```sh
ibmcloud ks nlb-dns rm vpc-gen2 --cluster CLUSTER --nlb-subdomain SUBDOMAIN [ --ip IP] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--nlb-subdomain SUBDOMAIN`
:    The subdomain that you want to disassociate from the VPC load balancer hostname. To see existing subdomains, run `ibmcloud ks nlb-dns ls --cluster <cluster>`.

`--ip IP`
:    For VPC network load balancers, the IP address that you want to remove. To see the IPs registered with each subdomain, run `ibmcloud ks nlb-dns ls --cluster <cluster>`. Note that you must repeat this command for each IP address that you want to remove.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns rm vpc-gen2` command
{: #nlb-dns-rm-vpc-gen2-example}

```sh
ibmcloud ks nlb-dns rm vpc-gen2 --cluster mycluster --nlb-subdomain mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}

### Experimental: `ibmcloud ks nlb-dns secret regenerate`
{: #cs_nlb-dns-secret-regenerate}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Regenerate the certificate and secret for an NLB subdomain. Secret regeneration is not disruptive, and traffic continues to flow while the secret regenerates.
{: shortdesc}

If the Let’s Encrypt certificate creation fails during secret regeneration, a 10 minute wait period must pass before the regeneration is automatically attempted again. The regeneration of the secret takes another 5 minutes to complete, making it a total of 15 minutes before the process is completed.

To avoid the Let’s Encrypt rate limit, don't regenerate a secret more than 5 times per day.
{: note}

```sh
ibmcloud ks nlb-dns secret regenerate --cluster CLUSTER --nlb-subdomain SUBDOMAIN [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--nlb-subdomain SUBDOMAIN`
:    The subdomain to regenerate the secret for. To list subdomains, run `ibmcloud ks nlb-dns ls --cluster CLUSTER`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns secret regenerate` command
{: #nlb-dns-secret-regenerate-example}

```sh
ibmcloud ks nlb-dns secret regenerate --cluster mycluster --nlb-subdomain mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}


### Experimental: `ibmcloud ks nlb-dns secret rm`
{: #cs_nlb-dns-secret-rm}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Delete a secret from an NLB subdomain and prevent future renewal of the certificate.
{: shortdesc}

You might delete the secret for an NLB subdomain if you no longer use the subdomain, or if the owner of the secret leaves your organization.

```sh
ibmcloud ks nlb-dns secret rm --cluster CLUSTER --nlb-subdomain SUBDOMAIN [-f] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--nlb-subdomain SUBDOMAIN`
:    The subdomain to delete the secret for. To list subdomains, run `ibmcloud ks nlb-dns ls --cluster CLUSTER`.

`-f`
:    Optional: Force the command to run with no user prompts.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `nlb-dns secret rm` command
{: #nlb-dns-secret-rm-example}

```sh
ibmcloud ks nlb-dns secret rm --cluster mycluster --nlb-subdomain mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
```
{: pre}


## `ibmcloud ks vpc secure-by-default enable`
{: #vpc-secure-by-default-enable-cli}

Enable Secure By Default VPC Networking for a VPC cluster using legacy Security Groups.

```txt
ibmcloud ks vpc secure-by-default enable --cluster CLUSTER [--disable-outbound-traffic-protection] [-f] [-q]
```
{: pre}
{: #vpc-secure-by-default-enable-usage}

### Command options
{: #vpc-secure-by-default-enable-options}

`--cluster CLUSTER`, `-c CLUSTER`
:    Specify the cluster name or ID.

`--disable-outbound-traffic-protection`
:    Include this option to allow public outbound access from the cluster workers. By default, public outbound access is blocked.

`-f`
:    Force the command to run without user prompts.

`-q`
:    Do not show the message of the day or update reminders.
{: #vpc-secure-by-default-enable-options-dl}

## `webhook-create` command
{: #cs_webhook_create}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Register a webhook.
{: shortdesc}

```sh
ibmcloud ks webhook-create --cluster CLUSTER --level LEVEL --type slack --url URL  [-q]
```
{: pre}


Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--level LEVEL`
:    Optional: The notification level, such as `Normal` or `Warning`. `Warning` is the default value.

`--type slack`
:    Required: The webhook type. Currently, Slack is supported.

`--url URL`
:    Required: The URL for the webhook.

`-q`
:    Optional: Do not show the message of the day or update reminders.


### Example `webhook-create` command
{: #webhook-create-example}

```sh
ibmcloud ks webhook-create --cluster my_cluster --level Normal --type slack --url http://github.com/mywebhook
```
{: pre}



## `api-key` commands
{: #api_key-commands}

View information about the API key for a cluster or reset it to a new key.
{: shortdesc}

### `ibmcloud ks api-key info`
{: #cs_api_key_info}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View the name and email address for the owner of the {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) API key that {{site.data.keyword.containerlong_notm}} uses to authenticate certain requests like infrastructure in the region and resource group.
{: shortdesc}

To create a different API key for the resource group and region, use the [`ibmcloud ks api-key reset`](#cs_api_key_reset) command.

If you manually set IBM Cloud infrastructure credentials by using the [`ibmcloud ks credential set`](#cs_credentials_set) command, the API key that is returned in this command is not used for infrastructure permissions.
{: note}

```sh
ibmcloud ks api-key info --cluster CLUSTER [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`-c`, `--cluster CLUSTER`
:    Required: The name or ID of the cluster.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.



#### Example `api-key info` command
{: #api-key-info-example}

```sh
ibmcloud ks api-key info --cluster my_cluster
```
{: pre}


### `ibmcloud ks api-key reset`
{: #cs_api_key_reset}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Create an {{site.data.keyword.cloud_notm}} IAM API key that impersonates the user's permissions to authenticate requests for all clusters in the current resource group and region.
{: shortdesc}

If you use the {{site.data.keyword.block_storage_is_short}} or cluster autoscaler add-ons in your cluster, you must re-create the add-on controller pods after you reset your API key. For more information, see [{{site.data.keyword.block_storage_is_short}} PVC creation fails after API key reset](/docs/containers?topic=containers-vpc-block-api-key-reset-ts) and [Autoscaling fails after API key reset](/docs/containers?topic=containers-ts-storage-ca-apikey-reset).
{: important}

Before you use this command, make sure that the user who runs this command has the required [{{site.data.keyword.containerlong_notm}} and IBM Cloud infrastructure permissions](/docs/containers?topic=containers-iam-platform-access-roles). Target the resource group and region that you want to set the API key for. When the API key is reset, the previous API key that was used, if any, for the region and resource group is now obsolete. You can then delete the old API key from your list of API keys. Before you reset the API key, check whether you have other services that use the existing API key, such as a [key management service (KMS) provider](/docs/containers?topic=containers-encryption) or [{{site.data.keyword.secrets-manager_short}}](/docs/containers?topic=containers-secrets-mgr).
{: important}

```sh
ibmcloud ks api-key reset --region REGION [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--region REGION`
:    Specify a region in {{site.data.keyword.containerlong_notm}}: `jp-osa`, `jp-tok`, `au-syd`, `eu-de`, `eu-gb`, `us-east`, or `us-south`.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `api-key reset` command
{: #api-key-reset-example}

```sh
ibmcloud ks api-key reset --region us-south
```
{: pre}



## `credential` commands
{: #credential}

Set and unset credentials that allow you to access the classic IBM Cloud infrastructure portfolio through your {{site.data.keyword.cloud_notm}} account.
{: shortdesc}

You can manually set infrastructure credentials to a different account only for classic clusters, not for VPC clusters.

### `ibmcloud ks credential get`
{: #cs_credential_get}

[Classic infrastructure]{: tag-classic-inf}


If you set up your {{site.data.keyword.cloud_notm}} account to use different credentials to access the IBM Cloud infrastructure portfolio, get the infrastructure username for the region and resource group that you are currently targeted to.
{: shortdesc}

```sh
ibmcloud ks credential get --region REGION [-q] [--output json]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--region REGION`
:    Specify a region in {{site.data.keyword.containerlong_notm}}: `jp-osa`, `jp-tok`, `au-syd`, `eu-de`, `eu-gb`, `us-east`, or `us-south`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `credential get` command
{: #credential-get-example}

```sh
ibmcloud ks credential get --region us-south
```
{: pre}

### `ibmcloud ks credential set classic`
{: #cs_credentials_set}

[Classic infrastructure]{: tag-classic-inf}


Set credentials for a resource group and region so that you can access the IBM Cloud infrastructure portfolio through your {{site.data.keyword.cloud_notm}} account.
{: shortdesc}

If you have an {{site.data.keyword.cloud_notm}} Pay-As-You-Go account, you have access to the IBM Cloud infrastructure portfolio by default. However, you might want to use a different, existing IBM Cloud infrastructure account to order infrastructure. You can link this infrastructure account to your {{site.data.keyword.cloud_notm}} account by using this command.

If IBM Cloud infrastructure credentials are manually set for a region and a resource group, these credentials are used to order infrastructure for all clusters within that region in the resource group. These credentials are used to determine infrastructure permissions, even if an [{{site.data.keyword.cloud_notm}} IAM API key](#cs_api_key_info) exists for the resource group and region. If the user whose credentials are stored does not have the required permissions to order infrastructure, then infrastructure-related actions, such as creating a cluster or reloading a worker node can fail.

You can't set multiple credentials for the same {{site.data.keyword.containerlong_notm}} resource group and region.

Before you use this command, make sure that the user whose credentials are used has the required [{{site.data.keyword.containerlong_notm}} and IBM Cloud infrastructure permissions](/docs/containers?topic=containers-iam-platform-access-roles).
{: important}

```sh
ibmcloud ks credential set classic --infrastructure-api-key API_KEY --infrastructure-username USERNAME --region REGION [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--infrastructure-username USERNAME`
:    Required: IBM Cloud infrastructure account API username. The infrastructure API username is not the same as the IBMid. To view the infrastructure API username, see [Managing classic infrastructure API keys](/docs/account?topic=account-classic_keys).

`--infrastructure-api-key API_KEY`
:    Required: IBM Cloud infrastructure account API key. To view or generate an infrastructure API key, see [Managing classic infrastructure API keys](/docs/account?topic=account-classic_keys).

`--region REGION`
:    Specify a region in {{site.data.keyword.containerlong_notm}}: `jp-osa`, `jp-tok`, `au-syd`, `eu-de`, `eu-gb`, `us-east`, or `us-south`.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `credential set classic` command
{: #credential-set-classic-example}

```sh
ibmcloud ks credential set classic --infrastructure-api-key <api_key> --infrastructure-username dbmanager --region us-south
```
{: pre}


### `ibmcloud ks credential unset`
{: #cs_credentials_unset}

[Classic infrastructure]{: tag-classic-inf}


Remove the credentials for a resource group and region to remove access to the IBM Cloud infrastructure portfolio through your {{site.data.keyword.cloud_notm}} account.
{: shortdesc}

After you remove the credentials, the [{{site.data.keyword.cloud_notm}} IAM API key](#cs_api_key_info) is used to order resources in IBM Cloud infrastructure.

```sh
ibmcloud ks credential unset --region REGION [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--region REGION`
:    Specify a region in {{site.data.keyword.containerlong_notm}}: `jp-osa`, `jp-tok`, `au-syd`, `eu-de`, `eu-gb`, `us-east`, or `us-south`.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `credential unset` command
{: #credential-unset-example}

```sh
ibmcloud ks credential unset --region us-south
```
{: pre}



## `infra-permissions` commands
{: #infra-commands}

Check classic IBM Cloud infrastructure permissions that are used in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

The `ibmcloud ks infra-permissions` commands check only classic IBM Cloud infrastructure, not VPC permissions.
{: note}

### `ibmcloud ks infra-permissions get`
{: #infra_permissions_get}

[Classic infrastructure]{: tag-classic-inf}


Check whether the credentials that allow [access to the IBM Cloud infrastructure portfolio](/docs/containers?topic=containers-access-creds) for the targeted resource group and region are missing suggested or required infrastructure permissions.
{: shortdesc}

If the infrastructure credentials for the region and resource group are missing any permissions, the output of this command returns a list of `required` and `suggested` permissions.
*   **Required**: These permissions are needed to successfully order and manage infrastructure resources such as worker nodes. If the infrastructure credentials are missing one of these permissions, common actions such as `worker reload` can fail for all clusters in the region and resource group.
*   **Suggested**: These permissions are helpful to include in your infrastructure permissions, and might be necessary in certain use cases. For example, the `Add Compute with Public Network Port` infrastructure permission is suggested because if you want public networking, you need this permission. However, if your use case is a cluster on the private VLAN only, the permission is not needed so it is not considered `required`.

For a list of common use cases by permission, see [Infrastructure roles](/docs/containers?topic=containers-iam-platform-access-roles).

What if I see an infrastructure permission that I can't find in the console or [Infrastructure roles](/docs/containers?topic=containers-iam-platform-access-roles) table?
:   `Support Case` permissions are managed in a different part of the console than infrastructure permissions. See [Customizing infrastructure permissions](/docs/containers?topic=containers-iam-platform-access-roles).

Which infrastructure permissions do I assign?
:   If your company's policies for permissions are strict, you might need to limit the `suggested` permissions for your cluster's use case. Otherwise, make sure that your infrastructure credentials for the region and resource group include all the `required` and `suggested` permissions.

For most use cases, [set up the API key](/docs/containers?topic=containers-iam-platform-access-roles) for the region and resource group with the appropriate infrastructure permissions. If you need to use another infrastructure account that differs from your current account, [set up manual credentials](/docs/containers?topic=containers-classic-credentials).

How do I control what actions the users can perform?
:   After infrastructure credentials are set up, you can control what actions your users can perform by assigning them [{{site.data.keyword.cloud_notm}} IAM platform access roles](/docs/containers?topic=containers-iam-platform-access-roles).

```sh
ibmcloud ks infra-permissions get --region REGION [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--region REGION`
:    Required: Specify a region in {{site.data.keyword.containerlong_notm}}: `jp-osa`, `jp-tok`, `au-syd`, `eu-de`, `eu-gb`, `us-east`, or `us-south`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `infra-permissions get` command
{: #infra-permissions-get-example}

```sh
ibmcloud ks infra-permissions get --region us-south
```
{: pre}

Example output
```sh
Missing Virtual Worker Permissions

Add Server                    suggested
Cancel Server                 suggested
View Virtual Server Details   required

Missing Physical Worker Permissions

No changes are suggested or required.

Missing Network Permissions

No changes are suggested or required.

Missing Storage Permissions

Add Storage       required
Manage Storage    required
```
{: screen}



## `kms` commands
{: #ks_kms}

Enable a [key management service (KMS) provider](/docs/containers?topic=containers-encryption-setup) in your cluster to encrypt the etcd component and Kubernetes secrets with a root key that you control.
{: shortdesc}

### `ibmcloud ks kms crk ls`
{: #ks_kms_crk_ls}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List available customer root keys (CRKs) in a key management service instance. Root keys wrap and unwrap the local data encryption keys (DEKs) that the cluster uses to encrypt its secrets. For more information, see [Understanding Key Management Service (KMS) providers](/docs/containers?topic=containers-encryption-setup).
{: shortdesc}

Do not delete root keys in your KMS instance, even if you rotate to use a new key. If you delete a root key that a cluster uses, the cluster becomes unusable, loses all its data, and can't be recovered.
{: important}

```sh
ibmcloud ks kms crk ls --instance-id KMS_INSTANCE_ID [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--instance-id KMS_INSTANCE_ID`
:    The ID of the key management service instance that you want to list root keys for. To list available KMS instances, run `ibmcloud ks kms instance ls`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `kms crk ls` command
{: #kms-crk-ls-example}

```sh
ibmcloud ks kms crk ls --instance-id 1aa1a111-1111-1111-a111-a1aaaa1a1a1a
```
{: pre}

### `ibmcloud ks kms enable`
{: #ks_kms_enable}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Encrypt your Kubernetes secrets by [enabling a key management service (KMS) provider](/docs/containers?topic=containers-encryption) in your cluster. To rotate a key in a cluster with existing key encryption, rerun this command with a new root key ID.
{: shortdesc}

Do not delete root keys in your KMS instance, even if you rotate to use a new key. If you delete a root key that a cluster uses, the cluster becomes unusable, loses all its data, and can't be recovered. When you rotate a root key, you can't reuse a previous root key for the same cluster.
{: important}

```sh
ibmcloud ks kms enable --cluster CLUSTER_NAME_OR_ID --instance-id KMS_INSTANCE_ID --crk ROOT_KEY_ID [--kms-account-id ID] [--public-endpoint] [-q]
```
{: pre}

Minimum required permissions
:   **Administrator** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--container, -c CLUSTER_NAME_OR_ID`
:    The name or ID of the cluster.

`--instance-id KMS_INSTANCE_ID`
:    The ID of the KMS instance that you want to use to encrypt the secrets in your cluster. To list available KMS instances, run `ibmcloud ks kms instance ls`.

`--crk ROOT_KEY_ID`
:    The ID of the customer root key (CRK) in your KMS instance that you want to use to wrap the data encryption keys (DEK) that are stored locally in your cluster. To list available root keys, run `ibmcloud ks kms crk ls --instance-id <kms_instance_id>`.

`--kms-account-id ID`
:    Optional: The ID of the account that contains the KMS instance you want to use for local disk or secret encryption.

`--public-endpoint`
:    Optional: Specify this option to use the KMS public cloud service endpoint. If you don't include this option, the private cloud service endpoint is used by default.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `kms enable` command
{: #kms-enable-example}

```sh
ibmcloud ks kms enable -c mycluster --instance-id a11aa11a-bbb2-3333-d444-e5e555e5ee5 --crk 1a111a1a-bb22-3c3c-4d44-55e555e55e55
```
{: pre}

### `ibmcloud ks kms instance ls`
{: #ks_kms_instance_ls}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List available [key management service (KMS) instances](/docs/containers?topic=containers-encryption-setup) in your {{site.data.keyword.cloud_notm}} account that you can choose to enable in your cluster.
{: shortdesc}

```sh
ibmcloud ks kms instance ls [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role in {{site.data.keyword.containerlong_notm}}

**Command options**:


`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Example**:
```sh
ibmcloud ks kms instance ls
```
{: pre}



## `quota` commands
{: #cs_quota}

### `ibmcloud ks quota ls`
{: #cs_quota_ls}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List all quota and limits for cluster-related resources in your {{site.data.keyword.cloud_notm}} account.
{: shortdesc}

```sh
ibmcloud ks quota ls [--provider PROVIDER] [--output json]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for {{site.data.keyword.containerlong_notm}}

**Command options**:

`--provider (classic | vpc-gen2)`
:    The infrastructure provider type to list quota and limits for.

`--output json`
:    Optional: Prints the command output in JSON format.


**Example**:
```sh
ibmcloud ks quota ls
```
{: pre}




## `subnets` command
{: #cs_subnets}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List available subnets in all resource groups in your IBM Cloud infrastructure account.
{: shortdesc}

```sh
ibmcloud ks subnets [--provider (classic | vpc-gen2)] [--vpc-id <VPC_ID> --zone <VPC_ZONE>] [--location LOCATION] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for {{site.data.keyword.containerlong_notm}}

**Command options**:

`--provider (classic | vpc-gen2)`
:    The infrastructure provider type to list subnets for. This option is required to list VPC subnets.

`--vpc-id VPC_ID`
:    The ID of the VPC to list subnets for. This option is required when you specify the `vpc-gen2` provider type. To list VPC IDs, run `ibmcloud ks vpcs`.

`--zone VPC_ZONE`
:    The zone to list VPC subnets for. This option is required when you specify a VPC provider type.

`-l, --location LOCATION`
:    Filter output by a specific location. To see supported locations, run `ibmcloud ks locations`. To specify multiple locations, use one option for each location, such as `-l dal -l seo`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Example**:
```sh
ibmcloud ks subnets -l ams03 -l wdc -l ap
```
{: pre}


## `vlan` commands
{: #vlan}

[Classic infrastructure]{: tag-classic-inf}


List public and private VLANs for a zone and view the VLAN spanning status.
{: shortdesc}

### `ibmcloud ks vlan ls`
{: #cs_vlans}

[Classic infrastructure]{: tag-classic-inf}


List the public and private VLANs that are available for a zone in your classic IBM Cloud infrastructure account. To list available VLANs, you must have a paid account.
{: shortdesc}

```sh
ibmcloud ks vlan ls --zone ZONE [--all] [--output json] [-q]
```
{: pre}

**Minimum required permissions**:
* To view the VLANs that the cluster is connected to in a zone: **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}
* To list all available VLANs in a zone: **Viewer** platform access role for the region in {{site.data.keyword.containerlong_notm}}

**Command options**:

`--zone ZONE`
:    Required: Enter the zone where you want to list your private and public VLANs. To see available zones, run `ibmcloud ks zone ls`.

`--all`
:    Lists all available VLANs. By default VLANs are filtered to show only those VLANs that are valid. To be valid, a VLAN must be associated with infrastructure that can host a worker with local disk storage.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `vlan ls` command
{: #vlan-ls-example}

```sh
ibmcloud ks vlan ls --zone dal10
```
{: pre}


### `ibmcloud ks vlan spanning get`
{: #cs_vlan_spanning_get}

[Classic infrastructure]{: tag-classic-inf}


View the VLAN spanning status for an IBM Cloud infrastructure account. VLAN spanning enables all devices on an account to communicate with each other through the private network, regardless of its assigned VLAN.
{: shortdesc}

The VLAN spanning option is disabled for clusters that are created in a VRF-enabled account. When VRF is enabled, all VLANs in the account can automatically communicate with each other over the private network. To check whether a VRF is enabled, use the `ibmcloud account show` command. For more information, see [Planning your cluster network setup: Worker-to-worker communication](/docs/containers?topic=containers-plan_basics#worker-worker).
{: note}

```sh
ibmcloud ks vlan spanning get --region REGION [--output json] [-q]
```
{: pre}

Minimum required permissions
:   **Viewer** platform access role for {{site.data.keyword.containerlong_notm}}

**Command options**:

`--region REGION`
:    Specify a region in {{site.data.keyword.containerlong_notm}}: `jp-osa`, `jp-tok`, `au-syd`, `eu-de`, `eu-gb`, `us-east`, or `us-south`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


#### Example `vlan spanning get` command
{: #vlan-spanning-get-example}

```sh
ibmcloud ks vlan spanning get --region us-south
```
{: pre}




## `ibmcloud ks vpc ls`
{: #vpc-ls-cli}

List all VPCs in the targeted resource group. If no resource group is targeted, all VPCs in the account are listed.

```txt
ibmcloud ks vpc ls [--output OUTPUT] [--provider PROVIDER] [-q]
```
{: pre}
{: #vpc-ls-usage}

### Command options
{: #vpc-ls-options}

`--output OUTPUT`
:    Prints the command output in the provided format. Accepted values: `json`
`--provider PROVIDER`
:    The VPC infrastructure provider type. Supported values are `vpc-classic` and `vpc-gen2`. By default, VPCs of all provider types are returned.

`-q`
:    Do not show the message of the day or update reminders.
{: #vpc-ls-options-dl}


## `ibmcloud ks vpc outbound-traffic-protection disable`
{: #vpc-outbound-traffic-protection-disable-cli}

Disable outbound traffic protection for a Secure By Default VPC cluster.

```txt
ibmcloud ks vpc outbound-traffic-protection disable --cluster CLUSTER [-f] [-q]
```
{: pre}
{: #vpc-outbound-traffic-protection-disable-usage}

### Command options
{: #vpc-outbound-traffic-protection-disable-options}

`--cluster CLUSTER`, `-c CLUSTER`
:    Specify the cluster name or ID.

`-f`
:    Force the command to run without user prompts.

`-q`
:    Do not show the message of the day or update reminders.
{: #vpc-outbound-traffic-protection-disable-options-dl}


## `ibmcloud ks vpc outbound-traffic-protection enable`
{: #vpc-outbound-traffic-protection-enable-cli}

Enable outbound traffic protection for a Secure By Default VPC cluster.

```txt
ibmcloud ks vpc outbound-traffic-protection enable --cluster CLUSTER [-f] [-q]
```
{: pre}
{: #vpc-outbound-traffic-protection-enable-usage}

### Command options
{: #vpc-outbound-traffic-protection-enable-options}

`--cluster CLUSTER`, `-c CLUSTER`
:    Specify the cluster name or ID.

`-f`
:    Force the command to run without user prompts.

`-q`
:    Do not show the message of the day or update reminders.
{: #vpc-outbound-traffic-protection-enable-options-dl}



## `flavor` command
{: #cs_machine_types}

Each flavor includes the amount of virtual CPU, memory, and disk space for each worker node in the cluster. 
{: shortdesc}

By default, the secondary storage disk directory where all container data is stored, is encrypted with LUKS encryption. If the `disable-disk-encrypt` option is included during cluster creation, then the host's container runtime data is not encrypted. [Learn more about the encryption](/docs/containers?topic=containers-security#encrypted_disk).

You can provision your worker node as a virtual machine on shared or dedicated hardware, or for classic clusters only, as a physical machine on bare metal.

### `flavor get` command
{: #cs_flavor_get}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Get the information of a flavor for a zone and provider.
{: shortdesc}

```sh
ibmcloud ks flavor get --flavor FLAVOR --provider PROVIDER --zone ZONE [--output OUTPUT] [-q]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--flavor FLAVOR`
:    The flavor you want to get information for. Flavors determine how much virtual CPU, memory, and disk space is available to each worker node.

`--provider PROVIDER`
:    The infrastructure provider for which you want to get flavor information for. Available options are `classic`, `vpc-classic` and `vpc-gen2`.

`--zone ZONE`
:    The zone where you want to get flavor information for. To see available zones for classic clusters, run `ibmcloud ks zone ls`. To see available zones for VPC clusters, run `ibmcloud ks zone ls --provider vpc-gen2` for Generation 2 compute.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `flavor get` command
{: #flavor-get-example}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

```sh
ibmcloud ks flavor get --zone us-south-1 --provider vpc-gen2 --flavor bx2d.48x192.900gb
```
{: pre}

### `flavor ls` command
{: #cs_flavor_ls}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List available flavors for a zone.
{: shortdesc}

```sh
ibmcloud ks flavor ls --zone ZONE [--output OUTPUT] [--provider PROVIDER] [-q] [--show-os] [--show-storage]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--zone ZONE`
:    The zone where you want to get flavor information for. To see available zones for classic clusters, run `ibmcloud ks zone ls`. To see available zones for VPC clusters, run `ibmcloud ks zone ls --provider vpc-gen2` for Generation 2 compute.

`--provider PROVIDER`
:    Optional: The infrastructure provider for which you want to get flavor information for. Available options are `classic`, `vpc-classic` and `vpc-gen2`.

`--show-os`
:    Optional: List supported operating systems.

`--show-storage`
:    Optional: Show additional raw disks that are available for SDS worker node flavors. For more information, see [Software-defined storage (SDS) machines](/docs/containers?topic=containers-classic-flavors). In the tables for each metro area section, SDS flavors are in the **Bare Metal** tabs and end with `.ssd`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.

#### Example `flavor ls` command
{: #flavor-ls-example}

```sh
ibmcloud ks flavor ls --zone us-south-1 --provider vpc-gen2 --show-os --show-storage
```
{: pre}

## `messages` command
{: #cs_messages}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

View current messages from the {{site.data.keyword.containerlong_notm}} CLI plug-in for the IBMid user.
{: shortdesc}

```sh
ibmcloud ks messages
```
{: pre}

Minimum required permissions
:   None

**Command options**: None



## locations command
{: #cs_supported-locations}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List the locations that are supported by {{site.data.keyword.containerlong_notm}}. For more information about the locations that are returned, see [{{site.data.keyword.containerlong_notm}} locations](/docs/containers?topic=containers-regions-and-zones#locations).
{: shortdesc}

```sh
ibmcloud ks locations [--output json]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--output json`
:    Optional: Prints the command output in JSON format.




## `versions` command
{: #cs_versions_command}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List all the container platform versions that are available for {{site.data.keyword.containerlong_notm}} clusters. Update your [cluster master](#cs_cluster_update) and [worker nodes](#cs_worker_update) to the default version for the latest, stable capabilities.
{: shortdesc}

The `kube-versions` alias for this command is deprecated.
{: note}

```sh
ibmcloud ks versions [--show-version (KUBERNETES|OPENSHIFT)] [--output json] [-q]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--show-version (KUBERNETES|OPENSHIFT)`
:    Show only the versions for the specified container platform. Supported values are `kubernetes` or `openshift`.

`--output json`
:    Optional: Prints the command output in JSON format.

`-q`
:    Optional: Do not show the message of the day or update reminders.


**Example**:
```sh
ibmcloud ks versions
```
{: pre}



## `api` command
{: #cs_cli_api}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Target the API endpoint for {{site.data.keyword.containerlong_notm}}. If you don't specify an endpoint, you can view information about the current endpoint that is targeted.
{: shortdesc}

Region-specific endpoints are deprecated. Use the global endpoint instead.
{: deprecated}

If you need to list and work with resources from one region only, you can use the `ibmcloud ks api` command to target a regional endpoint instead of the global endpoint.
* Dallas (US South, us-south): `https://us-south.containers.cloud.ibm.com`
* Frankfurt (EU Central, eu-de): `https://eu-de.containers.cloud.ibm.com`
* London (UK South, eu-gb): `https://eu-gb.containers.cloud.ibm.com`
* Osaka (jp-osa): `https://jp-osa.containers.cloud.ibm.com`
* São Paulo (br-sao): `https://br-sao.containers.cloud.ibm.com`
* Sydney (AP South, au-syd): `https://au-syd.containers.cloud.ibm.com`
* Tokyo (AP North, jp-tok): `https://jp-tok.containers.cloud.ibm.com`
* Toronto (ca-tor): `https://ca-tor.containers.cloud.ibm.com`
* Washington, D.C. (US East, us-east): `https://us-east.containers.cloud.ibm.com`

To use the global functionality, you can use the `ibmcloud ks api` command again to target the global endpoint: `https://containers.cloud.ibm.com`

```sh
ibmcloud ks api --endpoint ENDPOINT [--insecure] [--skip-ssl-validation] [--api-version VALUE] [-q]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--endpoint ENDPOINT`
    :    The {{site.data.keyword.containerlong_notm}} API endpoint. **Note**: This endpoint is different than the {{site.data.keyword.cloud_notm}} endpoints. This value is required to set the API endpoint.


`--insecure`
:    Allow an insecure HTTP connection. This option is optional.

`--skip-ssl-validation`
:    Allow insecure SSL certificates. This option is optional.

`--api-version VALUE`
:    Optional: Specify the API version of the service that you want to use.

`-q`
:    Optional: Do not show the message of the day or update reminders.



**Example**: View information about the current API endpoint that is targeted.
```sh
ibmcloud ks api
```
{: pre}

```sh
API Endpoint:          https://containers.cloud.ibm.com
API Version:           v1
Skip SSL Validation:   false
Region:                us-south
```
{: screen}



## `init` command
{: #cs_init}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Initialize the {{site.data.keyword.containerlong_notm}} plug-in or specify the region where you want to create or access Kubernetes clusters.
{: shortdesc}

Region-specific endpoints are deprecated. Use the global endpoint instead.
{: deprecated}

If you need to list and work with resources from one region only, you can use the `ibmcloud ks init` command to target a regional endpoint instead of the global endpoint.

* Dallas (US South, us-south): `https://us-south.containers.cloud.ibm.com`
* Frankfurt (EU Central, eu-de): `https://eu-de.containers.cloud.ibm.com`
* London (UK South, eu-gb): `https://eu-gb.containers.cloud.ibm.com`
* Osaka (jp-osa): `https://jp-osa.containers.cloud.ibm.com`
* São Paulo (br-sao): `https://br-sao.containers.cloud.ibm.com`
* Sydney (AP South, au-syd): `https://au-syd.containers.cloud.ibm.com`
* Tokyo (AP North, jp-tok): `https://jp-tok.containers.cloud.ibm.com`
* Toronto (ca-tor): `https://ca-tor.containers.cloud.ibm.com`
* Washington, D.C. (US East, us-east): `https://us-east.containers.cloud.ibm.com`

To use the global functionality, you can use the `ibmcloud ks init` command again to target the global endpoint: `https://containers.cloud.ibm.com`

```sh
ibmcloud ks init [--host HOST] [--insecure] [-p] [-u] [-q]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--host HOST`
:    Optional: The {{site.data.keyword.containerlong_notm}} API endpoint to use.

`--insecure`
:    Allow an insecure HTTP connection.

`-p`
:    Your IBM Cloud password.

`-u`
:    Your IBM Cloud username.

`-q`
:    Optional: Do not show the message of the day or update reminders.



**Examples**:
*  Example to target the US South regional endpoint:
    ```sh
    ibmcloud ks init --host https://us-south.containers.cloud.ibm.com
    ```
    {: pre}

*  Example to target the global endpoint again:
    ```sh
    ibmcloud ks init --host https://containers.cloud.ibm.com
    ```
    {: pre}



## `script` commands
{: #script}

### `ibmcloud ks script update`
{: #script_update}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Rewrite scripts that call `kubernetes-service` commands. Legacy-structured commands are replaced with beta-structured commands.
{: shortdesc}

Most command behavior and syntax changes in version 1.0. These changes are not compatible with earlier versions. After you update your scripts, you must continue to use version `1.0` of the plug-in within the script or the environment where the script is run. Do not change the `IKS_BETA_VERSION` environment variable to a different version.
{: important}

```sh
ibmcloud ks script update [--in-place] FILE [FILE ...]
```
{: pre}

Minimum required permissions
:   None

**Command options**:


`--in-place`
:    Optional: Rewrite the source file with the updated command structure. If this option is not specified, you can see a summary of the changes to the script file in STDOUT.

`FILE [FILE ...]`
:    The file that contains the scripts that you want to update.


To use this command to prepare your automation scripts for the release of version 1.0 of the {{site.data.keyword.containerlong_notm}} plug-in:
1. Run the command on a test script without the `--in-place` option.
    ```sh
    ibmcloud ks script update ./mytestscript.sh
    ```
    {: pre}

2. Review the proposed changes to the script in the difference that is shown in the command line STDOUT. Example output
    ```sh
    --- a/script-test-2
    +++ b/script-test-2
    @@ -1,5 +1,5 @@
    -ibmcloud ks logging-config-get --cluster mycluster
    -ibmcloud ks logging-config-update --cluster mycluster --id myconfig --logsource application --type ibm --app-containers app1,app2,app3 --app-paths /var/log/path/
    -ibmcloud ks logging-config-update --cluster mycluster --id myconfig --logsource application --type ibm --app-paths=/var/log/path/,/var/log/other/path/
    -ibmcloud ks clusters -s --locations dal09,dal12 --output json
    -ibmcloud ks subnets --locations sao01
    +ibmcloud ks logging config get --cluster mycluster
    +ibmcloud ks logging config update --cluster mycluster --id myconfig --logsource application --type ibm -C app1 -C app2 -C app3 -p /var/log/path/
    +ibmcloud ks logging config update --cluster mycluster --id myconfig --logsource application --type ibm -p /var/log/path/ -p /var/log/other/path/
    +ibmcloud ks clusters -s -l dal09 -l dal12 --output json
    +ibmcloud ks subnets -l sao01
    ```
    {: screen}

3. To rewrite the script with the proposed updates, run the command again with the `--in-place` option.
    ```sh
    ibmcloud ks script update ./mytestscript.sh --in-place
    ```
    {: pre}

4. Search for and address any commands that are flagged in the script with `# WARNING` messages. For example, some commands are deprecated and don't have a replacement command.
5. Within the script or the environment where the script is run, set the `IKS_BETA_VERSION` environment variable to `1.0`.
    ```sh
    export IKS_BETA_VERSION=1.0
    ```
    {: pre}

6. Test your automation with the updated script. Note that you might incur charges if your automation includes creating clusters.
7. Update all your scripts.
8. Update your CLI plug-in to version 1.0.
    ```sh
    ibmcloud plugin update kubernetes-service
    ```
    {: pre}



## `security-group` commands
{: #security_group}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Reset or sync a security group to the [default traffic rules](/docs/containers?topic=containers-vpc-security-group&interface=ui#vpc-sg-inbound-outbound).
{: shortdesc}

## `ibmcloud ks security-group ls`
{: #security-group-ls-cli}

List all security groups associated with a cluster.

```txt
ibmcloud ks security-group ls --cluster CLUSTER [--attached-to ATTACHED] [--managed-by MANAGER] [--output OUTPUT] [-q] [--scope SCOPE]
```
{: pre}
{: #security-group-ls-usage}

### Command options
{: #security-group-ls-options}

`--attached-to ATTACHED`
:    Filter the security groups by the components they are attached to. Accepted values: `cluster`, `load-balancer`, `vpc`, `vpe-gateway`, `worker-pool`

`--cluster CLUSTER`, `-c CLUSTER`
:    Specify the cluster name or ID.

`--managed-by MANAGER`
:    Specify `user` to return the security groups created by user. Specify `ibm` to return only the security groups managed by IBM. Accepted values: `ibm`, `user`

`--output OUTPUT`
:    Prints the command output in the provided format. Accepted values: `json`

`-q`
:    Do not show the message of the day or update reminders.

`--scope SCOPE`
:    Specify `cluster` to return security groups scoped to the cluster.  Specify `vpc` to return security groups scoped to the entire VPC. Accepted values: `cluster`, `vpc`
{: #security-group-ls-options-dl}

### `ibmcloud ks security-group reset`
{: #security_group_reset}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

[Deletes all existing security group rules and reapplies the default rules](/docs/containers?topic=containers-vpc-security-group&interface=ui#vpc-sg-inbound-outbound).
{: shortdesc}

```sh
ibmcloud ks security-group reset --cluster CLUSTER --security-group GROUP [-f] [-q]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--cluster CLUSTER`
:    Required: Specify the cluster name or ID. To list available clusters, run `ibmcloud ks cluster ls`.

`--security-group GROUP_ID`
:    Required: Specify the security group ID. 

**Example**: 

```sh
ibmcloud ks security-group reset --cluster mycluster --security-group mygroup
```
{: pre}

### `ibmcloud ks security-group sync`
{: #security_group_sync}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Reapplies the [default security group rules](/docs/containers?topic=containers-vpc-security-group&interface=ui#vpc-sg-inbound-outbound) to add any missing rules. Does not delete preexisting rules.
{: shortdesc}

```sh
ibmcloud ks security-group sync --cluster CLUSTER --security-group GROUP [-q]
```
{: pre}

Minimum required permissions
:   None

**Command options**:

`--cluster CLUSTER`
:    Required: Specify the cluster name or ID. To list available clusters, run `ibmcloud ks cluster ls`.

`--security-group GROUP_ID`
:    Required: Specify the security group ID. 

**Example**: 

```sh
ibmcloud ks security-group sync --cluster mycluster --security-group mygroup 
```
{: pre}




## Beta: `storage` commands
{: #cs_storage}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Create, get, list, or remove storage volume attachments.
{: shortdesc}

The `storage` commands are available in beta.
{: beta}

### `ibmcloud ks storage attachment create`
{: #cs_storage_att_cr}

[Virtual Private Cloud]{: tag-vpc}

Attach a storage volume to a worker node in your cluster.
{: shortdesc}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

```sh
ibmcloud ks storage attachment create --cluster CLUSTER_ID --volume VOLUME --worker WORKER [--output json]
```
{: pre}

**Command options**:


`--cluster CLUSTER_ID`
:    Required: Specify the cluster ID. To list available clusters, run `ibmcloud ks cluster ls`.

`--volume VOLUME`
:    Required: Specify the volume ID. To list available workers, run `ibmcloud ks storage volume ls`.

`--worker WORKER`
:    Required: Specify the worker ID. To list available workers, run `ibmcloud ks worker ls`.

`--output json`
:    Optional: Prints the command output in JSON format.


**Example**:

```sh
ibmcloud ks storage attachment create --cluster aa1111aa11aaaaa11aa1 --volume 111111111 --worker kube-aa1111aa11aaaaa11aa1-my_cluster-default-00000110 [--output json]
```
{: pre}

### `ibmcloud ks storage attachment get`
{: #cs_storage_att_get}

[Virtual Private Cloud]{: tag-vpc} 

Get the details of a storage volume attachment in your cluster.
{: shortdesc}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

```sh
ibmcloud ks storage attachment get --cluster CLUSTER_ID --attachment ATTACHMENT --worker WORKER [--output json]
```
{: pre}


`--cluster CLUSTER_ID`
:    Required: Specify the cluster ID. To list available clusters, run `ibmcloud ks cluster ls`.

`--attachment ATTACHMENT`
:    Required: Specify the volume attachment ID. To list available attachments, run `ibmcloud ks storage attachment ls`.

`--worker WORKER`
:    Required: Specify the worker ID. To list available workers, run `ibmcloud ks worker ls`.

`--output json`
:    Optional: Prints the command output in JSON format.


**Example**:

```sh
ibmcloud ks storage attachment get --cluster aa1111aa11aaaaa11aa1 --attachment 0111-1a111aaa-1111-1111-111a-aaa1a1a11a11 --worker kube-aa1111aa11aaaaa11aa1-my_cluster-default-00000110 [--output json]
```
{: pre}

### `ibmcloud ks storage attachment ls`
{: #cs_storage_att_ls}

[Virtual Private Cloud]{: tag-vpc} 

List the storage volume attachments for a worker node in your cluster.
{: shortdesc}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

```sh
ibmcloud ks storage attachment ls --cluster CLUSTER_ID --worker WORKER [--output json]
```
{: pre}


`--cluster CLUSTER_ID`
:    Required: Specify the cluster ID. To list available clusters, run `ibmcloud ks cluster ls`.

`--worker WORKER`
:    Required: Specify the worker ID. To list available workers, run `ibmcloud ks worker ls`.

`--output json`
:    Optional: Prints the command output in JSON format.


**Example**:

```sh
ibmcloud ks storage attachment ls --cluster aa1111aa11aaaaa11aa1 --worker kube-aa1111aa11aaaaa11aa1-my_cluster-default-00000110 [--output json]
```
{: pre}


### `ibmcloud ks storage attachment rm`
{: #cs_storage_att_rm}

[Virtual Private Cloud]{: tag-vpc} 

Remove a storage volume from a worker node in your cluster.
{: shortdesc}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

```sh
ibmcloud ks storage attachment rm --cluster CLUSTER_ID --attachment ATTACHMENT --worker WORKER [--output json]
```
{: pre}

**Command options**:


`--cluster CLUSTER_ID`
:    Required: Specify the cluster ID. To list available clusters, run `ibmcloud ks cluster ls`.

`--attachment ATTACHMENT`
:    Required: Specify the volume attachment ID. To list available attachments, run `ibmcloud ks storage attachment ls`.

`--worker WORKER`
:    Required: Specify the worker ID. To list available workers, run `ibmcloud ks worker ls`.

`--output json`
:    Optional: Prints the command output in JSON format.


**Example**:

```sh
ibmcloud ks storage attachment rm --cluster aa1111aa11aaaaa11aa1 --attachment 0111-1a111aaa-1111-1111-111a-aaa1a1a11a11 --worker kube-aa1111aa11aaaaa11aa1-my_cluster-default-00000110 [--output json]
```
{: pre}

### `ibmcloud ks storage volume get`
{: #cs_storage_att_ls_c}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

List storage volumes for your classic clusters.
{: shortdesc}

Minimum required permissions
:   **Viewer** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

```sh
ibmcloud ks storage volume get --volume VOLUME
```
{: pre}

**Command options**:


`--volume VOLUME`
:    Required: Specify the volume ID. To list available volumes, run `ibmcloud ks storage volume ls`.

`--output json`
:    Optional: Prints the command output in JSON format.


**Example**:

```sh
ibmcloud ks storage volume get --volume 111111111
```
{: pre}


### `ibmcloud ks storage volume ls`
{: #cs_storage_att_ls_2}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Get a list of storage volumes.
{: shortdesc}

Minimum required permissions
:   **Editor** platform access role for the cluster in {{site.data.keyword.containerlong_notm}}

```sh
ibmcloud ks storage volume ls [--cluster CLUSTER_ID] [--provider PROVIDER] [--zone ZONE] [--output json]
```
{: pre}

**Command options**:


`--cluster CLUSTER_ID`
:    Optional: Specify the cluster ID. To list available clusters, run `ibmcloud ks cluster ls`.

`--provider PROVIDER`
:    Optional: Specify the provider. Supported values are `classic` and `vpc-gen2`.

`--zone ZONE`
:    Optional: Specify the zone. To list available zones, run `ibmcloud ks locations`.

`--output json`
:    Optional: Prints the command output in JSON format.


**Example**:

```sh
ibmcloud ks storage volume ls --cluster aa1111aa11aaaaa11aa1
```
{: pre}



## `ibmcloud ks experimental trusted-profile default get`
{: #experimental-trusted-profile-default-get-cli}

[Expires on 2025-10-03] Get the default trusted profile for clusters created in a resource-group.

```txt
ibmcloud ks experimental trusted-profile default get --region REGION --resource-group GROUP [--output OUTPUT] [-q]
```
{: pre}
{: #experimental-trusted-profile-default-get-usage}

### Command options
{: #experimental-trusted-profile-default-get-options}

`--output OUTPUT`
:    Prints the command output in the provided format. Accepted values: `json`

`-q`
:    Do not show the message of the day or update reminders.

`--region REGION`
:    The region where the resource-group is located.

`--resource-group GROUP`
:    The resource-group whose default trusted profile is to be retrieved.
{: #experimental-trusted-profile-default-get-options-dl}


## `ibmcloud ks experimental trusted-profile default set`
{: #experimental-trusted-profile-default-set-cli}

[Expires on 2025-10-03] Set the default trusted profile for clusters created in a resource-group.

```txt
ibmcloud ks experimental trusted-profile default set --region REGION --resource-group GROUP --trusted-profile PROFILE [--output OUTPUT] [-q]
```
{: pre}
{: #experimental-trusted-profile-default-set-usage}

### Command options
{: #experimental-trusted-profile-default-set-options}

`--output OUTPUT`
:    Prints the command output in the provided format. Accepted values: `json`

`-q`
:    Do not show the message of the day or update reminders.

`--region REGION`
:    The region where the resource group is located.

`--resource-group GROUP`
:    The resource group ID to set the trusted profile on.

`--trusted-profile PROFILE`
:    The trusted profile ID.
{: #experimental-trusted-profile-default-set-options-dl}


## `ibmcloud ks experimental trusted-profile get`
{: #experimental-trusted-profile-get-cli}

[Expires on 2025-10-03] Get trusted profile for a cluster.

```txt
ibmcloud ks experimental trusted-profile get --cluster CLUSTER [--output OUTPUT] [-q]
```
{: pre}
{: #experimental-trusted-profile-get-usage}

### Command options
{: #experimental-trusted-profile-get-options}

`--cluster CLUSTER`
:    The cluster ID to retrieve the trusted profile for.

`--output OUTPUT`
:    Prints the command output in the provided format. Accepted values: `json`

`-q`
:    Do not show the message of the day or update reminders.
{: #experimental-trusted-profile-get-options-dl}


## `ibmcloud ks experimental trusted-profile set`
{: #experimental-trusted-profile-set-cli}

[Expires on 2025-10-03] Set trusted profile on a cluster.

```txt
ibmcloud ks experimental trusted-profile set --cluster CLUSTER --trusted-profile PROFILE [--output OUTPUT] [-q]
```
{: pre}
{: #experimental-trusted-profile-set-usage}

### Command options
{: #experimental-trusted-profile-set-options}

`--cluster CLUSTER`
:    The cluster ID to set the the trusted profile on.

`--output OUTPUT`
:    Prints the command output in the provided format. Accepted values: `json`

`-q`
:    Do not show the message of the day or update reminders.

`--trusted-profile PROFILE`
:    The trusted profile ID.
{: #experimental-trusted-profile-set-options-dl}
