---

copyright: 
  years: 2022, 2026
lastupdated: "2026-07-30"


keywords: kubernetes, containers

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# {{site.data.keyword.containerlong_notm}} CLI Map
{: #icks_map}

This page lists all `ibmcloud ks` commands as they are structured in the CLI. For more details on a specific command, click the command or see the [{{site.data.keyword.containerlong_notm}} CLI reference](/docs/containers?topic=containers-kubernetes-service-cli).



## ibmcloud ks cluster
{: #icks_map_cluster}

[View and modify cluster and cluster service settings](/docs/containers?topic=containers-kubernetes-service-cli#cluster).
{: shortdesc}

* **`cluster addon`**: View, enable, update, and disable cluster add-ons.
    * [`ibmcloud ks cluster addon disable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-addon-disable-cli)
    * [`ibmcloud ks cluster addon enable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-addon-enable-cli)
    * [`ibmcloud ks cluster addon get`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-addon-get-cli)
    * [`ibmcloud ks cluster addon ls`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-addon-ls-cli)
    * [`ibmcloud ks cluster addon options`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-addon-options-cli)
    * [`ibmcloud ks cluster addon update`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-addon-update-cli)
    * [`ibmcloud ks cluster addon versions`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-addon-versions-cli)
* **`cluster ca`**: Manage the Certificate Authority (CA) certificates of a cluster.
    * [`ibmcloud ks cluster ca create`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-ca-create-cli)
    * [`ibmcloud ks cluster ca get`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-ca-get-cli)
    * [`ibmcloud ks cluster ca rotate`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-ca-rotate-cli)
    * [`ibmcloud ks cluster ca status`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-ca-status-cli)
* [`ibmcloud ks cluster config`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-config-cli)
* **`cluster create`**: Create a classic or VPC cluster.
    * [`ibmcloud ks cluster create classic`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-create-classic-cli)
    * [`ibmcloud ks cluster create vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-create-vpc-gen2-cli)
* [`ibmcloud ks cluster get`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-get-cli)
* **`cluster image-security`**: Manage image security enforcement in your cluster.
    * [`ibmcloud ks cluster image-security disable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-image-security-disable-cli)
    * [`ibmcloud ks cluster image-security enable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-image-security-enable-cli)
* [`ibmcloud ks cluster ls`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-ls-cli)
* **`cluster master`**: View and modify the master for a cluster.
    * **`cluster master audit-webhook`**: View and modify the audit webhook configuration for a cluster's Kubernetes API server.
        * [`ibmcloud ks cluster master audit-webhook get`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-audit-webhook-get-cli) 
        * [`ibmcloud ks cluster master audit-webhook set`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-audit-webhook-set-cli) 
        * [`ibmcloud ks cluster master audit-webhook unset`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-audit-webhook-unset-cli)
    * **`cluster master pod-security`**: View and modify your Pod Security configurations.
        * [`ibmcloud ks cluster master pod-security get`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-pod-security-get)
        * [`ibmcloud ks cluster master pod-security set`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-pod-security-set)
        * [`ibmcloud ks cluster master pod-security unset`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-pod-security-unset)
        * **`ibmcloud ks cluster master pod-security policy`**: View and modify the deprecated Pod Security policy configuration in supported clusters.
            * [`ibmcloud ks cluster master pod-security policy disable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-pod-security-policy-disable)
            * [`ibmcloud ks cluster master pod-security policy enable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-pod-security-policy-enable)
            * [`ibmcloud ks cluster master pod-security policy get`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-pod-security-policy-get)
    * **`cluster master private-service-endpoint`**: Manage the private service endpoint of a cluster.
        * **`ibmcloud ks cluster master private-service-endpoint allowlist`**: Manage the private service endpoint allowlist.
            * [`ibmcloud ks cluster master private-service-endpoint allowlist add`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-private-service-endpoint-allowlist-add-cli)
            * [`ibmcloud ks cluster master private-service-endpoint allowlist disable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-private-service-endpoint-allowlist-disable-cli)
            * [`ibmcloud ks cluster master private-service-endpoint allowlist enable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-private-service-endpoint-allowlist-enable-cli)
            * [`ibmcloud ks cluster master private-service-endpoint allowlist get`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-private-service-endpoint-allowlist-get-cli)
            * [`ibmcloud ks cluster master private-service-endpoint allowlist remove`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-private-service-endpoint-allowlist-rm-cli)
        * [`ibmcloud ks cluster master private-service-endpoint enable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-private-service-endpoint-enable-cli)
    * **`cluster master public-service-endpoint`**: Manage the public service endpoint of a cluster.
        * [`ibmcloud ks cluster master public-service-endpoint disable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-public-service-endpoint-disable-cli)
        * [`ibmcloud ks cluster master public-service-endpoint enable`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-public-service-endpoint-enable-cli)
    * [`ibmcloud ks cluster master refresh`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-refresh-cli)
    * [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-update-cli)
* **`cluster pull-secret`**: Manage image pull secrets for the cluster to access images in IBM Cloud Container Registry.
    * [`ibmcloud ks cluster pull-secret apply`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-pull-secret-apply-cli) 
* [`ibmcloud ks cluster rm`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-rm-cli)
* **`cluster service`**: View, bind, and unbind IBM Cloud services on a cluster.
    * [`ibmcloud ks cluster service bind`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-service-bind-cli)
    * [`ibmcloud ks cluster service ls`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-service-ls-cli)
    * [`ibmcloud ks cluster service unbind`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-service-unbind-cli)
* **`cluster subnet`**: Add and create portable subnets for a classic cluster.
    * [`ibmcloud ks cluster subnet add`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-subnet-add-cli)
    * [`ibmcloud ks cluster subnet create`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-subnet-create-cli)
    * [`ibmcloud ks cluster subnet detach`](/docs/containers?topic=containers-kubernetes-service-cli#cluster-subnet-detach-cli)

## ibmcloud ks worker
{: #icks_map_worker}

[View and modify worker nodes for a cluster](/docs/containers?topic=containers-kubernetes-service-cli#worker_node_commands).
{: shortdesc}

* **Deprecated** [`ibmcloud ks worker add`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-create-classic-cli) 
* [`ibmcloud ks worker get`](/docs/containers?topic=containers-kubernetes-service-cli#worker-get-cli)
* [`ibmcloud ks worker ls`](/docs/containers?topic=containers-kubernetes-service-cli#worker-ls-cli)
* [`ibmcloud ks worker reboot`](/docs/containers?topic=containers-kubernetes-service-cli#worker-reboot-cli)
* [`ibmcloud ks worker reload`](/docs/containers?topic=containers-kubernetes-service-cli#worker-reload-cli)
* [`ibmcloud ks worker replace`](/docs/containers?topic=containers-kubernetes-service-cli#worker-replace-cli)
* [`ibmcloud ks worker rm`](/docs/containers?topic=containers-kubernetes-service-cli#worker-rm-cli)
* [`ibmcloud ks worker update`](/docs/containers?topic=containers-kubernetes-service-cli#worker-update-cli)

## ibmcloud ks worker-pool
{: #icks_map_worker-pool}

[View and modify worker pools for a cluster](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool).
{: shortdesc}

* **`worker-pool create`**: Add a worker pool to a cluster. No worker nodes are created until zones are added to the worker pool.
    * [`ibmcloud ks worker-pool create classic`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-create-classic-cli)
    * [`ibmcloud ks worker-pool create vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-create-vpc-gen2-cli)
* [`ibmcloud ks worker-pool get`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-get-cli)
* **`worker-pool label`**: Set and remove custom Kubernetes labels for all worker nodes in a worker pool.
    * [`ibmcloud ks worker-pool label rm`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-label-rm-cli)
    * [`ibmcloud ks worker-pool label set`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-label-set-cli)
* [`ibmcloud ks worker-pool ls`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-ls-cli)
* [`ibmcloud ks worker-pool rebalance`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-rebalance-cli)
* [`ibmcloud ks worker-pool resize`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-resize-cli)
* [`ibmcloud ks worker-pool rm`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-rm-cli)
* **[`worker-pool taint`]**: Set and remove Kubernetes taints for all worker nodes in a worker pool.
    * [`ibmcloud ks worker-pool taint rm`](/docs/containers?topic=containers-kubernetes-service-cli#worker_pool_taint_rm)
    * [`ibmcloud ks worker-pool taint set`](/docs/containers?topic=containers-kubernetes-service-cli#worker_pool_taint_set)
* [`ibmcloud ks worker-pool zones`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-zones-cli)

## ibmcloud ks zone
{: #icks_map_zone}

[List availability zones and modify the zones attached to a worker pool](/docs/containers?topic=containers-kubernetes-service-cli#zone).
{: shortdesc}

* **`zone add`**: Add a zone to one or more worker pools in a cluster.
    * [`ibmcloud ks zone add classic`](/docs/containers?topic=containers-kubernetes-service-cli#zone-add-classic-cli)
    * [`ibmcloud ks zone add vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#zone-add-vpc-gen2-cli)
* [`ibmcloud ks zone ls`](/docs/containers?topic=containers-kubernetes-service-cli#locations-cli)
* [`ibmcloud ks zone network-set`](/docs/containers?topic=containers-kubernetes-service-cli#zone-network-set-cli)
* [`ibmcloud ks zone rm`](/docs/containers?topic=containers-kubernetes-service-cli#zone-rm-cli)

## ibmcloud ks ingress
{: #icks_map_ingress}

[View and modify Ingress services and settings](/docs/containers?topic=containers-kubernetes-service-cli#alb-commands).
{: shortdesc}

* **`ingress alb`**: View and configure an Ingress application load balancer (ALB).
    * **`ingress alb autoscale`**: Configure autoscaling for Ingress ALBs. 
        * [`ibmcloud ks ingress alb autouscale get`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-autoscale-get-cli)
        * [`ibmcloud ks ingress alb autouscale set`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-autoscale-set-cli)
        * [`ibmcloud ks ingress alb autouscale unset`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-autoscale-unset-cli)
    * **`ingress alb autoupdate`**: Manage automatic updates for the Ingress ALB add-on in a cluster.
        * [`ibmcloud ks ingress alb autoupdate disable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-autoupdate-disable-cli)
        * [`ibmcloud ks ingress alb autoupdate enable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-autoupdate-enable-cli)
        * [`ibmcloud ks ingress alb autoupdate get`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-autoupdate-get-cli)
    * **`ingress alb create`**: Create an Ingress ALB in a cluster.
        * [`ibmcloud ks ingress alb create classic`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-create-classic-cli)
        * [`ibmcloud ks ingress alb create vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-create-vpc-gen2-cli)
    * [`ibmcloud ks ingress alb disable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-disable-cli)
    * **`ingress alb enable`**: Enable an Ingress ALB in a cluster.
        * [`ibmcloud ks ingress alb enable classic`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-update-cli)
        * [`ibmcloud ks ingress alb enable vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-update-cli)
    * [`ibmcloud ks ingress alb get`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-get-cli)
    * **`ingress alb health-checker`**: Manage the Ingress ALB health checker.
        * [`ibmcloud ks ingress alb health-checker disable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-health-checker-disable-cli)
        * [`ibmcloud ks ingress alb health-checker enable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-health-checker-enable-cli)
        * [`ibmcloud ks ingress alb health-checker get`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-health-checker-get-cli)
    * [`ibmcloud ks ingress alb ls`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-ls-cli)
    * [`ibmcloud ks ingress alb update`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-update-cli)
    * [`ibmcloud ks ingress alb versions`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-alb-versions-cli)
* **`ingress lb`**: Modify load balancers that expose Ingress ALBs in your cluster.
    * [`ibmcloud ks ingress lb get`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-load-balancer-proxy-protocol-get-cli)
    * **`ingress lb proxy-protocol`**: **VPC only** Modify the PROXY protocol configuration for ALB load balancers.
        * [`ibmcloud ks ingress lb proxy-protocol disable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-load-balancer-proxy-protocol-disable-cli)
        * [`ibmcloud ks ingress lb proxy-protocol enable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-load-balancer-proxy-protocol-enable-cli)
* **`ingress secret`**: Manage Ingress secrets in a cluster.
    * [`ibmcloud ks ingress secret create`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-secret-create-cli)
    * [`ibmcloud ks ingress secret get`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-secret-get-cli)
    * [`ibmcloud ks ingress secret ls`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-secret-ls-cli)
    * [`ibmcloud ks ingress secret rm`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-secret-rm-cli)
    * [`ibmcloud ks ingress secret update`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-secret-update-cli) 
* **`ingress status-report`**: View and manage ingress status reporting.
    * [`ibmcloud ks ingress status-report disable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-status-report-disable-cli)
    * [`ibmcloud ks ingress status-report enable`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-status-report-enable-cli)
    * [`ibmcloud ks ingress status-report get`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-status-report-get-cli)
* **`ibmcloud ks ingress status-report ignore`**: Manage warnings to be ignored by ingress status reports.
    * [`ibmcloud ks ingress status-report ignore add`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-status-report-ignored-errors-add-cli)
    * [`ibmcloud ks ingress status-report ignore ls`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-status-report-ignored-errors-ls-cli)
    * [`ibmcloud ks ingress status-report ignore rm`](/docs/containers?topic=containers-kubernetes-service-cli#ingress-status-report-ignored-errors-rm-cli)
    

## ibmcloud ks logging
{: #icks_map_logging}

[Forward logs from your cluster.](/docs/containers?topic=containers-kubernetes-service-cli#logging_commands).
{: shortdesc}

* **`logging autoupdate`**: Manage automatic updates of the Fluentd add-on in a cluster.
    * [`ibmcloud ks logging autoupdate disable`](/docs/containers?topic=containers-kubernetes-service-cli#logging-autoupdate-disable-cli)
    * [`ibmcloud ks logging autoupdate enable`](/docs/containers?topic=containers-kubernetes-service-cli#logging-autoupdate-enable-cli)
    * [`ibmcloud ks logging autoupdate get`](/docs/containers?topic=containers-kubernetes-service-cli#logging-autoupdate-get-cli)
* **`logging config`**: View or modify log forwarding configurations for a cluster.
    * [`ibmcloud ks logging config create`](/docs/containers?topic=containers-kubernetes-service-cli#logging-config-create-cli)
    * [`ibmcloud ks logging config get`](/docs/containers?topic=containers-kubernetes-service-cli#logging-config-get-cli)
    * [`ibmcloud ks logging config rm`](/docs/containers?topic=containers-kubernetes-service-cli#logging-config-rm-cli)
    * [`ibmcloud ks logging config update`](/docs/containers?topic=containers-kubernetes-service-cli#logging-config-update-cli)
* **`logging filter`**: View or modify log filters for a cluster.
    * [`ibmcloud ks logging filter create`](/docs/containers?topic=containers-kubernetes-service-cli#logging-filter-create-cli)
    * [`ibmcloud ks logging filter get`](/docs/containers?topic=containers-kubernetes-service-cli#logging-filter-get-cli)
    * [`ibmcloud ks logging filter rm`](/docs/containers?topic=containers-kubernetes-service-cli#logging-filter-rm-cli)
    * [`ibmcloud ks logging filter update`](/docs/containers?topic=containers-kubernetes-service-cli#logging-filter-update-cli)
* [`ibmcloud ks logging refresh`](/docs/containers?topic=containers-kubernetes-service-cli#logging-refresh-cli)


## ibmcloud ks nlb-dns
{: #icks_map_nlb-dns}

[Create and manage host names for network load balancer (NLB) IP addresses in a cluster and health check monitors for host names](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns).
{: shortdesc}

* [`ibmcloud ks nlb-dns add`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-add-cli)
* **`nlb-dns create`**: Create a DNS host name.
    * [`ibmcloud ks nlb-dns create classic`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-create-classic-cli)
    * [`ibmcloud ks nlb-dns create vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-create-vpc-gen2-cli)
* [`ibmcloud ks nlb-dns ls`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-ls-cli)
* [`ibmcloud ks nlb-dns get`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-get-cli)
* **`nlb-dns monitor`**: Create and manage health check monitors for network load balancer (NLB) IP addresses and host names in a cluster.
    * [`ibmcloud ks nlb-dns monitor configure`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-monitor-configure-cli)
    * [`ibmcloud ks nlb-dns monitor disable`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-monitor-disable-cli)
    * [`ibmcloud ks nlb-dns monitor enable`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-monitor-enable-cli)
    * [`ibmcloud ks nlb-dns monitor get`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-monitor-get-cli)
    * [`ibmcloud ks nlb-dns monitor ls`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-monitor-ls-cli)
* [`ibmcloud ks nlb-dns replace`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-replace-cli)
* **`nlb-dns rm`**: Create and manage health check monitors for network load balancer (NLB) IP addresses and host names in a cluster.
    * [`ibmcloud ks nlb-dns rm classic`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-rm-classic-cli)
    * [`ibmcloud ks nlb-dns rm vpc-gen2`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-rm-vpc-gen2-cli)
* **Beta** **`nlb-dns secret`**:  Manage the secret for an NLB subdomain.
    * [`ibmcloud ks nlb-dns secret regenerate`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-secret-regenerate-cli)
    * [`ibmcloud ks nlb-dns secret rm`](/docs/containers?topic=containers-kubernetes-service-cli#nlb-dns-secret-rm-cli)

## ibmcloud ks webhook-create
{: #icks_map_webhook-create}

[Register a webhook in a cluster](/docs/containers?topic=containers-kubernetes-service-cli#webhook-create-cli).
{: shortdesc}

## ibmcloud ks api-key 
{: #icks_map_api-key}

[View information about the API key for a cluster or reset it to a new key](/docs/containers?topic=containers-kubernetes-service-cli#api_key-commands).
{: shortdesc}

* [`ibmcloud ks api-key info`](/docs/containers?topic=containers-kubernetes-service-cli#api-key-info-cli)
* [`ibmcloud ks api-key reset`](/docs/containers?topic=containers-kubernetes-service-cli#api-key-reset-cli)

## ibmcloud ks credential
{: #icks_map_credential}

[Set and unset credentials that allow you to access the IBM Cloud classic infrastructure portfolio through your IBM Cloud account](/docs/containers?topic=containers-kubernetes-service-cli#credential).
{: shortdesc}

* [`ibmcloud ks credential get`](/docs/containers?topic=containers-kubernetes-service-cli#credential-get-cli)
* [`ibmcloud ks credential set classic`](/docs/containers?topic=containers-kubernetes-service-cli#credential-set-classic-cli)
* [`ibmcloud ks credential unset`](/docs/containers?topic=containers-kubernetes-service-cli#credential-unset-cli)

## ibmcloud ks infra-permissions
{: #icks_map_infra-permissions}

[View information about infrastructure permissions that allow you to access the IBM Cloud classic infrastructure portfolio through your IBM Cloud account](/docs/containers?topic=containers-kubernetes-service-cli#infra-commands).
{: shortdesc}

* [`ibmcloud ks infra-permissions get`](/docs/containers?topic=containers-kubernetes-service-cli#infra-permissions-get-cli)

## ibmcloud ks kms 
{: #icks_map_kms}

[View and configure Key Management Service integrations](/docs/containers?topic=containers-kubernetes-service-cli#kms-enable-cli).
{: shortdesc}

* **`kms crk`**: List and configure the root keys for a Key Management Service instance.
    * [`ibmcloud ks kms crk ls`](/docs/containers?topic=containers-kubernetes-service-cli#kms-crk-ls-cli)
* [`ibmcloud ks kms enable`](/docs/containers?topic=containers-kubernetes-service-cli#kms-enable-cli)
* **`kms instance`**: View and configure available Key Management Service instances.
    * [`ibmcloud ks kms instance ls`](/docs/containers?topic=containers-kubernetes-service-cli#kms-instance-ls-cli)

## ibmcloud ks quota 
{: #icks_map_quota}

[View the quota and limits for cluster-related resources in your IBM Cloud account](/docs/containers?topic=containers-kubernetes-service-cli#quota-ls-cli).

* [`ibmcloud ks quota ls`](/docs/containers?topic=containers-kubernetes-service-cli#quota-ls-cli)

## ibmcloud ks subnets 
{: #icks_map_subnets}

[List available portable subnets in your IBM Cloud infrastructure account](/docs/containers?topic=containers-kubernetes-service-cli#subnets-cli).
{: shortdesc}

## ibmcloud ks vlan 
{: #icks_map_vlan}

[List public and private VLANs for a zone and view the VLAN spanning status](/docs/containers?topic=containers-kubernetes-service-cli#vlan).
{: shortdesc}

* [`ibmcloud ks vlan ls`](/docs/containers?topic=containers-kubernetes-service-cli#vlan-ls-cli)
* **`vlan spanning`**: View the VLAN spanning status for your IBM Cloud classic infrastructure account.
    * [`ibmcloud ks vlan spanning get`](/docs/containers?topic=containers-kubernetes-service-cli#vlan-spanning-get-cli)
    
## ibmcloud ks vpcs 
{: #icks_map_vpcs}

[List all VPCs in the targeted resource group. If no resource group is targeted, then all VPCs in the account are listed.](/docs/containers?topic=containers-kubernetes-service-cli#vpc-ls-cli).
{: shortdesc}

## ibmcloud ks flavors
{: #icks_map_flavors}

[List available flavors for a zone](/docs/containers?topic=containers-kubernetes-service-cli#flavor-ls-cli).
{: shortdesc}

## ibmcloud ks locations
{: #icks_map_locations}

[List supported IBM Cloud Kubernetes Service locations](/docs/containers?topic=containers-kubernetes-service-cli#locations-cli).
{: shortdesc}

## ibmcloud ks messages
{: #icks_map_messages}

[View the current user messages](/docs/containers?topic=containers-kubernetes-service-cli#messages-cli).
{: shortdesc}

## ibmcloud ks versions
{: #icks_map_versions}

[List all the container platform versions that are available for IBM Cloud Kubernetes Service clusters](/docs/containers?topic=containers-kubernetes-service-cli#versions-cli).
{: shortdesc}

## ibmcloud ks api
{: #icks_map_api}

**Deprecated** [View or set the API endpoint and API version for the service](/docs/containers?topic=containers-kubernetes-service-cli#api-cli).
{: shortdesc}

## ibmcloud ks `init`
{: #icks_map_init}

[Initialize the Kubernetes Service plug-in and get authentication tokens](/docs/containers?topic=containers-kubernetes-service-cli#init-cli).
{: shortdesc}

## ibmcloud ks script  
{: #icks_map_script}

[Rewrite scripts that call IBM Cloud Kubernetes Service plug-in commands](/docs/containers?topic=containers-kubernetes-service-cli#script).
{: shortdesc}

* [`ibmcloud ks script update`](/docs/containers?topic=containers-kubernetes-service-cli#script_update)




## ibmcloud ks security-group
{: #icks_map_security_group}

[Reset or sync security group settings](/docs/containers?topic=containers-kubernetes-service-cli#security_group)

* [`ibmcloud ks security-group reset`](/docs/containers?topic=containers-kubernetes-service-cli#security_group_reset)
* [`ibmcloud ks security-group sync`](/docs/containers?topic=containers-kubernetes-service-cli#security_group_sync)



## ibmcloud ks storage 
{: #icks_map_storage}

**Beta** [View and modify storage resources](/docs/containers?topic=containers-kubernetes-service-cli#storage-attachment-create-cli).
{: shortdesc}

* **`storage attachment`**: View and modify storage volume attachments of worker nodes in your cluster.
    * [`ibmcloud ks storage attachment create`](/docs/containers?topic=containers-kubernetes-service-cli#storage-attachment-create-cli)
    * [`ibmcloud ks storage attachment get`](/docs/containers?topic=containers-kubernetes-service-cli#storage-attachment-get-cli)
    * [`ibmcloud ks storage attachment ls`](/docs/containers?topic=containers-kubernetes-service-cli#storage-attachment-ls-cli)
    * [`ibmcloud ks storage attachment rm`](/docs/containers?topic=containers-kubernetes-service-cli#storage-attachment-rm-cli)
* **`storage volume`**: View a list of storage volumes.
    * [`ibmcloud ks storage volume get`](/docs/containers?topic=containers-kubernetes-service-cli#storage-attachment-ls-cli)
    * [`ibmcloud ks storage volume ls`](/docs/containers?topic=containers-kubernetes-service-cli#storage-attachment-ls-cli)
    
    
