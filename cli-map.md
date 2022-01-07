---

copyright: 
  years: 2022, 2022
lastupdated: "2022-01-07"

keywords: kubernetes

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.containerlong_notm}} CLI Map
{: #icks_map}

The page lists all `ibmcloud ks` commands as they are structured in the CLI. For more CLI command details, see the [{{site.data.keyword.containerlong_notm}} CLI reference](/docs/containers?topic=containers-kubernetes-service-cli).



## ibmcloud ks cluster
{: #icks_map_cluster}

[View and modify cluster and cluster service settings](/docs/containers?topic=containers-kubernetes-service-cli#cluster).
{: shortdesc}

* **`cluster addon`**: View, enable, update, and disable cluster add-ons.
    * [`cluster addon disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addon_disable)
    * [`cluster addon enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addon_enable)
    * [`cluster addon get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addon_get)
    * [`cluster addon ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addons)
    * [`cluster addon options`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addon_options)
    * [`cluster addon update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addon_update)
    * [`cluster addon versions`](/docs/containers?topic=containers-kubernetes-service-cli#cs_addon_versions)
* **`cluster ca`**: Manage the Certificate Authority (CA) certificates of a cluster.
    * [`cluster ca create`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_ca_create)
    * [`cluster ca rotate`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_ca_rotate)
    * [`cluster ca status`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_ca_status)
* [`cluster config`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_config)
* **`cluster create`**: Create a classic or VPC cluster.
    * [`cluster create classic`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_create)
    * [`cluster create vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#cli_cluster-create-vpc-gen2)
* [`cluster get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_get)
* **`cluster image-security`**: Manage image security enforcement in your cluster.
    * [`cluster image-security disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs-image-security-disable)
    * [`cluster image-security enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs-image-security-enable)
* [`cluster ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_clusters)
* **`cluster master`**: View and modify the master for a cluster.
    * **`cluster master audit-webhook`**: View and modify the audit webhook configuration for a cluster's Kubernetes API server.
        * [`cluster master audit-webhook get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_config_get) 
        * [`cluster master audit-webhook set`](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_config_set) 
        * [`cluster master audit-webhook unset`](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_config_unset) 
    * **`cluster master private-service-endpoint`**: Manage the private service endpoint of a cluster.
        * **[`cluster master private-service-endpoint allowlist`**: Manage the private service endpoint allowlist.
            * [`cluster master private-service-endpoint allowlist add`](/docs/containers?topic=containers-kubernetes-service-cli#cs_master_pse_allowlist_add)
            * [`cluster master private-service-endpoint allowlist disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_master_pse_allowlist_disable)
            * [`cluster master private-service-endpoint allowlist enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_master_pse_enable)
            * [`cluster master private-service-endpoint allowlist get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_master_pse_get)
            * [`cluster master private-service-endpoint allowlist rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_master_pse_rm)
        * [`cluster master private-service-endpoint enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_master_pse_enable)
    * **`cluster master public-service-endpoint`**: Manage the public service endpoint of a cluster.
        * [`cluster master public-service-endpoint disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_master_pub_se_disable)
        * [`cluster master public-service-endpoint enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_master_pub_se_enable)
    * [`cluster master refresh`](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh)
    * [`cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update)
* **`cluster pull-secret`**: Manage image pull secrets for the cluster to access images in IBM Cloud Container Registry.
    * [`cluster pull-secret apply`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_pull_secret_apply) 
* [`cluster rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_rm)
* **`cluster service`**: View, bind, and unbind IBM Cloud services on a cluster.
    * [`cluster service bind`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_service_bind)
    * [`cluster service ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_services)
    * [`cluster service unbind`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_service_unbind)
* **`cluster subnet`**: Add and create portable subnets for a classic cluster.
    * [`cluster subnet add`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_subnet_add)
    * [`cluster subnet create`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_subnet_create)
    * [`cluster subnet detach`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_subnet_detach)

## ibmcloud ks worker
{: #icks_map_worker}

[View and modify worker nodes for a cluster](/docs/containers?topic=containers-kubernetes-service-cli#worker_node_commands).
{: shortdesc}

* [`worker add`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_add) **Deprecated**
* [`worker get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_get)
* [`worker ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_workers)
* [`worker reboot`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reboot)
* [`worker reload`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload)
* [`worker replace`](/docs/containers?topic=containers-kubernetes-service-cli#cli_worker_replace)
* [`worker rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_rm)
* [`worker update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update)

## ibmcloud ks worker-pool
{: #icks_map_worker-pool}

[View and modify worker pools for a cluster](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool).
{: shortdesc}

* **`worker-pool create`**: Add a worker pool to a cluster. No worker nodes are created until zones are added to the worker pool.
    * [`worker-pool create classic`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_create)
    * [`worker-pool create vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#cli_worker_pool_create_vpc_gen2)
* [`worker-pool get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_get)
* **`worker-pool label`**: Set and remove custom Kubernetes labels for all worker nodes in a worker pool.
    * [`worker-pool label rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_label_rm)
    * [`worker-pool label set`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_label_set)
* [`worker-pool ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pools)
* [`worker-pool rebalance`](/docs/containers?topic=containers-kubernetes-service-cli#cs_rebalance)
* [`worker-pool resize`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_resize)
* [`worker-pool rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_rm)
* [`worker-pool taint`](/docs/containers?topic=containers-kubernetes-service-cli#worker_pool_taint): Set and remove Kubernetes taints for all worker nodes in a worker pool.
    * [`worker-pool taint rm`](/docs/containers?topic=containers-kubernetes-service-cli#worker_pool_taint_rm)
    * [`worker-pool taint set`](/docs/containers?topic=containers-kubernetes-service-cli#worker_pool_taint_set)
* [`worker-pool zones`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_zones)

## ibmcloud ks zone
{: #icks_map_zone}

[List availability zones and modify the zones attached to a worker pool](/docs/containers?topic=containers-kubernetes-service-cli#zone).
{: shortdesc}

* **`zone add`**: Add a zone to one or more worker pools in a cluster.
    * [`zone add classic`](/docs/containers?topic=containers-kubernetes-service-cli#cs_zone_add)
    * [`zone add vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#cli_zone-add-vpc-gen2)
* [`zone ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_datacenters)
* [`zone network-set`](/docs/containers?topic=containers-kubernetes-service-cli#cs_zone_network_set)
* [`zone rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_zone_rm)

## ibmcloud ks ingress
{: #icks_map_ingress}

**Beta** [View and modify Ingress services and settings](/docs/containers?topic=containers-kubernetes-service-cli#alb-commands).
{: shortdesc}

* **`ingress alb`**: View and configure an Ingress application load balancer (ALB).
    * **`ingress alb autoupdate`**: Manage automatic updates for the Ingress ALB add-on in a cluster.
        * [`ingress alb autoupdate disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_disable)
        * [`ingress alb autoupdate enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_enable)
        * [`ingress alb autoupdate get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_get)
    * **`ingress alb create`**: Create an Ingress ALB in a cluster.
            * [`ingress alb create classic`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_create)
            * [`ingress alb create vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#cli_alb-create-vpc-gen2)
    * [`ingress alb disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_disable)
    * **`ingress alb enable`**: Enable an Ingress ALB in a cluster.
        * [`ingress alb enable classic`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure)
        * [`ingress alb enable vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#cli_alb_configure_vpc_gen2)
    * [`ingress alb get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_get)
    * [`ingress alb ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_albs)
    * **`ingress alb migrate`**: Migrate your IBM Cloud Ingress configmap and resources to the Kubernetes Ingress format.
        * [`ingress alb migrate clean`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_migrate_clean)
        * [`ingress alb migrate start`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_migrate_start)
        * [`ingress alb migrate status`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_migrate_status)
    * [`ingress alb update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_update)
    * [`ingress alb versions`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_versions)
* **`ingress lb`**: Modify load balancers that expose Ingress ALBs in your cluster.
    * [`ingress lb get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_lb_proxy-protocol_get)
    * **`ingress lb proxy-protocol`**: **VPC only** Modify the PROXY protocol configuration for ALB load balancers.
        * [`ingress lb proxy-protocol disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_lb_proxy-protocol_disable)
        * [`ingress lb proxy-protocol enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_lb_proxy-protocol_enable)
* **`ingress secret`**: Manage Ingress secrets in a cluster.
    * [`ingress secret create`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_secret_create)
    * [`ingress secret get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_secret_get)
    * [`ingress secret ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_secret_ls)
    * [`ingress secret rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_secret_rm)
    * [`ingress secret update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_secret_update)
* [`ingress status`](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_status)

## ibmcloud ks logging
{: #icks_map_logging}

[Forward logs from your cluster.](/docs/containers?topic=containers-kubernetes-service-cli#logging_commands).
{: shortdesc}

* **`logging autoupdate`**: Manage automatic updates of the Fluentd add-on in a cluster.
    * [`logging autoupdate disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_autoupdate_disable)
    * [`logging autoupdate enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_autoupdate_enable)
    * [`logging autoupdate get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_autoupdate_get)
* [`logging collect`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_collect)
* [`logging collect-status`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_collect_status)
* **`logging config`**: View or modify log forwarding configurations for a cluster.
    * [`logging config create`](/docs/containers?topic=containers-kubernetes-service-cli#cs_logging_create)
    * [`logging config get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_logging_get)
    * [`logging config rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_logging_rm)
    * [`logging config update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_logging_update)
* **`logging filter`**: View or modify log filters for a cluster.
    * [`logging filter create`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_filter_create)
    * [`logging filter get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_filter_view)
    * [`logging filter rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_filter_delete)
    * [`logging filter update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_log_filter_update)
* [`logging refresh`](/docs/containers?topic=containers-kubernetes-service-cli#cs_logging_refresh)

## ibmcloud ks nlb-dns
{: icks_map_nlb-dns}

[Create and manage host names for network load balancer (NLB) IP addresses in a cluster and health check monitors for host names](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns).
{: shortdesc}

* [`nlb-dns add`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-add)
* **`nlb-dns create`**: Create a DNS host name.
    * [`nlb-dns create classic`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-create)
    * [`nlb-dns create vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-create-vpc-gen2)
* [`nlb-dns ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-ls)
* **`nlb-dns monitor`**: Create and manage health check monitors for network load balancer (NLB) IP addresses and host names in a cluster.
    * [`nlb-dns monitor configure`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-monitor-configure)
    * [`nlb-dns monitor disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-monitor-disable)
    * [`nlb-dns monitor enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-monitor-enable)
    * [`nlb-dns monitor get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-monitor-get)
    * [`nlb-dns monitor ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-monitor-ls)
* [`nlb-dns replace`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-replace)
* **`nlb-dns rm`**: Create and manage health check monitors for network load balancer (NLB) IP addresses and host names in a cluster.
    * [`nlb-dns rm classic`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-rm)
    * [`nlb-dns rm vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-rm-vpc-gen2)
* **`nlb-dns secret`**: **Beta** Manage the secret for an NLB subdomain.
    * [`nlb-dns secret regenerate`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-secret-regenerate)
    * [`nlb-dns secret rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-secret-rm)

## ibmcloud ks webhook-create
{: #icks_map_webhook-create}

[Register a webhook in a cluster](/docs/containers?topic=containers-kubernetes-service-cli#cs_webhook_create).
{: shortdesc}

## ibmcloud ks api-key 
{: #icks_map_api-key}

[View information about the API key for a cluster or reset it to a new key](/docs/containers?topic=containers-kubernetes-service-cli#api_key-commands).
{: shortdesc}

* [`api-key info`](/docs/containers?topic=containers-kubernetes-service-cli#cs_api_key_info)
* [`api-key reset`](/docs/containers?topic=containers-kubernetes-service-cli#cs_api_key_reset)

## ibmcloud ks credential
{: #icks_map_credential}

[Set and unset credentials that allow you to access the IBM Cloud classic infrastructure portfolio through your IBM Cloud account](/docs/containers?topic=containers-kubernetes-service-cli#credential).
{: shortdesc}

* [`credential get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_credential_get)
* [`credential set classic`](/docs/containers?topic=containers-kubernetes-service-cli#cs_credentials_set)
* [`credential unset`](/docs/containers?topic=containers-kubernetes-service-cli#cs_credentials_unset)

## ibmcloud ks infra-permissions
{: #icks_map_infra-permissions}

[View information about infrastructure permissions that allow you to access the IBM Cloud classic infrastructure portfolio through your IBM Cloud account](/docs/containers?topic=containers-kubernetes-service-cli#infra-commands).
{: shortdesc}

* [`infra-permissions get`](/docs/containers?topic=containers-kubernetes-service-cli#infra_permissions_get)

## ibmcloud ks kms 
{: #icks_map_kms}

[View and configure Key Management Service integrations](/docs/containers?topic=containers-kubernetes-service-cli#ks_kms).
{: shortdesc}

* **`kms crk`**: List and configure the root keys for a Key Management Service instance.
    * [`kms crk ls`](/docs/containers?topic=containers-kubernetes-service-cli#ks_kms_crk_ls)
* [`kms enable`](/docs/containers?topic=containers-kubernetes-service-cli#ks_kms_enable)
* **`kms instance`**: View and configure available Key Management Service instances.
    * [`kms instance ls`](/docs/containers?topic=containers-kubernetes-service-cli#ks_kms_instance_ls)

## ibmcloud ks quota 
{: #icks_map_quota}

[View the quota and limits for cluster-related resources in your IBM Cloud account](/docs/containers?topic=containers-kubernetes-service-cli#cs_quota).

* [`quota ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_quota_ls)

## ibmcloud ks subnets 
{: #icks_map_subnets}

[List available portable subnets in your IBM Cloud infrastructure account](/docs/containers?topic=containers-kubernetes-service-cli#cs_subnets).
{: shortdesc}

### ibmcloud ks vlan 
{: #icks_map_vlan}

[List public and private VLANs for a zone and view the VLAN spanning status](/docs/containers?topic=containers-kubernetes-service-cli#vlan).
{: shortdesc}

* [`vlan ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlans)
* **`vlan spanning`**: View the VLAN spanning status for your IBM Cloud classic infrastructure account.
    * [`vlan spanning get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get)
    
## ibmcloud ks vpcs 
{: #icks_map_vpcs}

[List all VPCs in the targeted resource group. If no resource group is targeted, then all VPCs in the account are listed.](/docs/containers?topic=containers-kubernetes-service-cli#cs_vpcs).
{: shortdesc}

## ibmcloud ks flavors
{: #icks_map_flavors}

[List available flavors for a zone](/docs/containers?topic=containers-kubernetes-service-cli#cs_machine_types).
{: shortdesc}

## ibmcloud ks locations
{: #icks_map_locations}

[List supported IBM Cloud Kubernetes Service locations](/docs/containers?topic=containers-kubernetes-service-cli#cs_supported-locations).
{: shortdesc}

## ibmcloud ks messages
{: #icks_map_messages}

[View the current user messages](/docs/containers?topic=containers-kubernetes-service-cli#cs_messages).
{: shortdesc}

## ibmcloud ks versions
{: #icks_map_versions}

[List all the container platform versions that are available for IBM Cloud Kubernetes Service clusters](/docs/containers?topic=containers-kubernetes-service-cli#cs_versions_command).
{: shortdesc}

## ibmcloud ks api
{: #icks_map_api}

[**Deprecated** View or set the API endpoint and API version for the service](/docs/containers?topic=containers-kubernetes-service-cli#cs_cli_api).
{: shortdesc}

## ibmcloud ks init
{: #icks_map_init}

[Initialize the Kubernetes Service plug-in and get authentication tokens](/docs/containers?topic=containers-kubernetes-service-cli#cs_init).
{: shortdesc}

## ibmcloud ks script  
{: #icks_map_script}

[Rewrite scripts that call IBM Cloud Kubernetes Service plug-in commands](/docs/containers?topic=containers-kubernetes-service-cli#script).
{: shortdesc}

* [`script update`](/docs/containers?topic=containers-kubernetes-service-cli#script_update)

## ibmcloud ks storage 
{: #icks_map_storage}

[**Beta** View and modify storage resources](/docs/containers?topic=containers-kubernetes-service-cli#cs_storage).
{: shortdesc}

* **`storage attachment`**: View and modify storage volume attachments of worker nodes in your cluster.
    * [`storage attachment create`](/docs/containers?topic=containers-kubernetes-service-cli#cs_storage_att_cr)
    * [`storage attachment get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_storage_att_get)
    * [`storage attachment ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_storage_att_ls)
    * [`storage attachment rm`](/docs/containers?topic=containers-kubernetes-service-cli#cs_storage_att_rm)
* **`storage volume`**: View a list of storage volumes.
    * [`storage volume get`](/docs/containers?topic=containers-kubernetes-service-cli#cs_storage_att_ls_c)
    * [`storage volume ls`](/docs/containers?topic=containers-kubernetes-service-cli#cs_storage_att_ls_2)
    
    
