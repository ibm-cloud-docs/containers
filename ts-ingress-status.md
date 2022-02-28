---

copyright: 
  years: 2014, 2022
lastupdated: "2022-02-28"

keywords: kubernetes, help, network, connectivity

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Checking the status of Ingress components
{: #ingress-status}
{: support}

**Infrastructure provider**:
* ![Classic infrastructure provider icon.](images/icon-classic-2.svg) Classic
* ![VPC infrastructure provider icon.](images/icon-vpc-2.svg) VPC

## Getting the status and message
{: #check_status}

To check the overall health and status of your cluster's Ingress components:
{: shortdesc}

Review the [Gathering Ingress logs](/docs/openshift?topic=openshift-ingress-must-gather) topic for help gathering the required logs for debugging Ingress.
{: tip}

```sh
ibmcloud ks ingress status -c <cluster_name_or_ID>
```
{: pre}

The state of the Ingress components are reported in an **Ingress Status** and **Ingress Message**. Example output
```sh
ingress Status:   healthy
Message:          All Ingress components are healthy

Component                                        Status    Type
public-crdf253b6025d64944ab99ed63bb4567b6-alb1   healthy   alb
public-crdf253b6025d64944ab99ed63bb4567b6-alb2   healthy   alb
```
{: screen}

The **Ingress Status** and **Ingress Message** fields are also returned in the output of the `ibmcloud ks cluster get` command. The health of your Ingress components might impact the health of your cluster master. For example,  if your Ingress components are unhealthy, your cluster master might show a `warning` state. However, the health of your Ingress components does not cause your master health to become `critical`.
{: tip}


## Ingress statuses
{: #ingress_status}

The Ingress Status reflects the overall health of the Ingress components.
{: shortdesc}

|Ingress status|Description|
|--- |--- |
|`healthy` |The Ingress components are healthy. Check the **Ingress Message** field to verify that all operations for the Ingress components are complete.|
|`warning` |The Ingress components might not function properly due to errors. Check the **Ingress Message** field for more information and troubleshooting.|
{: caption="Ingress statuses"}
{: summary="Table rows read from left to right, with the Ingress status in column one and a description in column two."}

## Ingress messages
{: #ingress_message}

The Ingress Message provides details of what operation is in progress or information about any components that are unhealthy. Each status and message is described in the following tables.
{: shortdesc}

|Ingress message|Description|
|--- |--- |
|`ALB is disabled` |Your public ALBs were manually disabled. For more information, see the [`ibmcloud ks ingress alb enable` CLI command reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure).|
|`ALB is unhealthy or unreachable` |One or more ALB IP addresses can't be reached. For troubleshooting information, see [Ping the ALB subdomain and public IP addresses](/docs/containers?topic=containers-ingress-debug#ping).|
|`ALBs are not health checked in clusters created with no subnets` |Ingress health reporting is not supported for classic clusters that were created with the `--no-subnet` flag.|
|`ALBs are not health checked in private-only clusters` |Ingress health reporting is not supported for classic clusters that are connected to private VLANs only.|
|`ALBs can't be created because no portable subnet is available` |1Each ALB is created with a portable public or private IP address from the public or private subnet on the VLANs that your classic cluster is connected to. If no portable IP address is available, the ALB is not created. You might need to add a new subnet to your cluster or order a new VLAN. For troubleshooting information, see [Classic clusters: Why does the ALB not deploy in a zone?](/docs/containers?topic=containers-cs_subnet_limit).|
|`All Ingress components are healthy` |The Ingress components are successfully deployed and are healthy.|
|`Creating Ingress ALBs` |Your ALBs are currently deploying. Wait until your ALBs are fully deployed to review the health of your Ingress components. Note that ALB creation can take up to 15 minutes to complete. |
|`Creating TLS certificate for Ingress subdomain, which might take several minutes. Ensure you have the correct IAM permissions.` |The default Ingress subdomain for your cluster is created with a default TLS certificate, which is stored in the **Ingress Secret**. The certificate is currently being created and stored in the default {{site.data.keyword.cloudcerts_long_notm}} instance for your cluster.<p class="note">When the creation of the {{site.data.keyword.cloudcerts_short}} instance is triggered, the {{site.data.keyword.cloudcerts_short}} instance might take up to an hour to become visible in the {{site.data.keyword.cloud_notm}} console. If this message continues to be displayed, see [Why does no Ingress secret exist after cluster creation?](/docs/containers?topic=containers-ingress_secret).</p>|
|`Could not create a Certificate Manager instance. Ensure you have the correct IAM platform permissions.` | A default {{site.data.keyword.cloudcerts_long_notm}} instance for your cluster was not created to store the TLS certificate for the Ingress subdomain. The API key for the resource group and region that your cluster is in does not have the correct IAM permissions for {{site.data.keyword.cloudcerts_short}}. For troubleshooting steps, see [Why does no Ingress secret exist after cluster creation?](/docs/containers?topic=containers-ingress_secret).|
|`Could not upload certificates to Certificate Manager instance. Ensure you have the correct IAM service permissions.` |The TLS certificate for your cluster's default Ingress subdomain is created, but can't be stored in the default {{site.data.keyword.cloudcerts_long_notm}} instance for your cluster. The API key for the resource group and region that your cluster is in does not have the correct IAM permissions for {{site.data.keyword.cloudcerts_short}}. For troubleshooting steps, see [Why does no Ingress secret exist after cluster creation?](/docs/containers?topic=containers-ingress_secret).|
|`Ingress is not supported for free clusters` |In a free cluster, you can expose your app only by using a [NodePort service](/docs/containers?topic=containers-nodeport).|
|`Ingress subdomain is unreachable` |Your cluster is assigned an Ingress subdomain in the format `<cluster_name>.<region>.containers.mybluemix.net` that can't be reached. For troubleshooting information, see [Ping the ALB subdomain and public IP addresses](/docs/containers?topic=containers-ingress-debug#ping).|
|`Load balancer service for ALB or router is not ready` |<ul><li>VPC clusters: The VPC load balancer that routes requests to the apps that your ALBs expose either might still be creating or did not correctly deploy to your VPC. For troubleshooting information, see <a href="/docs/containers?topic=containers-vpc_ts_alb">VPC clusters: Why can't my app connect via Ingress?</a>.</li><li>Classic clusters: The load balancer service that exposes your ALB did not correctly deploy to your cluster. For troubleshooting information, see <a href="/docs/containers?topic=containers-cs_subnet_limit">Classic clusters: Why does the ALB not deploy in a zone?</a>.</li></ul>|
|`No workers found in this zone` | ALB pods can't deploy to a zone because no worker nodes match the pod affinity requirements. To ensure that you have the minimum required worker nodes per zone, see [Why do ALB pods not deploy to worker nodes?](/docs/containers?topic=containers-alb-pod-affinity).|
|`One or more ALBs are unhealthy` |The external IP address for one or more of your ALBs was reported as unhealthy. For troubleshooting information, see [Ping the ALB subdomain and public IP addresses](/docs/containers?topic=containers-ingress-debug#ping).|
|`Pending update or enable operation for ALB in progress` |Your ALB is currently updating to a new version, or your ALB that was previously disabled is enabling. For information about updating ALBs, see [Updating ALBs](/docs/containers?topic=containers-ingress-types#alb-update). For information about enabling ALBs, see the [`ibmcloud ks ingress alb enable` CLI command reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure).|
|`Registering Ingress subdomain` |The default **Ingress Subdomain** for your cluster is currently being created. The Ingress subdomain and secret creation follows a process that might take more than 15 minutes to complete. For troubleshooting information, see [Why does no Ingress subdomain exist after cluster creation?](/docs/openshift?topic=openshift-ingress_subdomain).|
|`The expiration dates reported by Ingress secrets are out of sync across namespaces.` | To resynchronize the expiration dates, [regenerate the secrets for your Ingress subdomain certificate](/docs/containers?topic=containers-sync_cert_dates).|
{: caption="Ingress messages"}
{: summary="Table rows read from left to right, with the Ingress message in column one and a description in column two."}




