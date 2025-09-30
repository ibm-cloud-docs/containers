---

copyright:
  years: 2023, 2025
lastupdated: "2025-09-30"


keywords: kubernetes, containers

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}

# Setting up a domain for your cluster
{: #ingress-domains}

When you create a cluster, an Ingress subdomain is registered by default for your cluster in the format `<cluster_name>.<globally_unique_account_HASH>-0000.<region>.containers.appdomain.cloud`. Additionally, you can make your apps reachable at a custom domain by creating your own domain registered with IBM Cloud's internal domain provider, or a domain registered with an external provider. You can also add an existing domain to your cluster.
{: shortdesc}

This functionality is available in beta and is subject to change.
{: beta}

{{site.data.keyword.cloud_notm}} provides a managed, internal provider that you can use to create your own domains. With the managed domain provider, you do not need to create and maintain an account with an external provider. You can also use health check monitoring for your managed domains. When creating a domain with the internal provider, you specify a subdomain name, such as `exampledomain`, and the new domain is named in the format `exampledomain.<zone>.containers.appdomain.cloud`. 

You can also use your own {{site.data.keyword.cis_full_notm}} instance as an external provider for your cluster domains.

You can also use the `service.kubernetes.io/ibm-load-balancer-cloud-provider-dns-name` VPC load balancer annotation to create a new domain or register an existing domain to your VPC load balancer. For more information, see the annotation description in the [VPC ALB](/docs/containers?topic=containers-setup_vpc_alb#vpc_alb_annotations_opt) or [VPC NLB](/docs/containers?topic=containers-setup_vpc_nlb#vpc_nlb_annotations_opt) documentation. 
{: tip}

## Accessing domains in the console
{: #ingress-domains-ui-access}
{: ui}

Navigate to the your cluster's **Domains** page to create and manage domains. 

1. In the console, navigate to your [clusters tab](https://cloud.ibm.com/kubernetes/clusters){: external}. 
2. Click the cluster where you want to create or change a domain.
3. Click **Ingress**. 
4. Click the **Domains** tab. From here, you can manage the domains associated with the cluster. 

## Creating domains in the console
{: #ingress-domains-ui}
{: ui}

Use the {{site.data.keyword.cloud_notm}} console to create your own domain in your cluster, or add a domain that already exists in your provider account. Follow the console instructions to make the following domain configurations.

If you are using the **{{site.data.keyword.cis_full_notm}}** provider, you must first [set up service-to-service authorization](/docs/account?topic=account-serviceauth&interface=ui#create-auth) for your {{site.data.keyword.cis_full_notm}} instance. Set the source service as `Kubernetes Service`, and the target as `Internet services`. Assign the `Manager` service level role and the `Viewer` platform level role. 
{: note}

### Domain details
{: #ingress-domains-ui-details}
{: ui}

- **Domain name**: The name of the domain to create or add to your cluster. This can be a domain that exists in your provider account, or a new domain. 
- **Provider**: Choose a provider for your domain. To create a managed domain with IBM Cloud's internal provider, choose **Managed**. To use an external provider, choose from the remaining provider types.
- **Set as default**: Choose whether you want to set the domain as the default for the cluster. The default Ingress domain is used to form a unique URL for each of your apps and is the domain that is referenced by the IP addresses of any public ALBs in your cluster. You can change which domain is set as the default at any time. Setting a default domain replaces the current default. Default domain configuration is not supported for {{site.data.keyword.satelliteshort}} clusters or for {{site.data.keyword.openshiftlong}} clusters running version 4.18 or later.

### Registration details
{: #ingress-domains-ui-registration}
{: ui}

- Add one or more **IP addresses** (for Classic or VPC clusters) or **Hostnames** (for VPC clusters) to register to the domain. You can update which IP addresses or hostnames are registered.
- **Secret namespace**: Specify the namespace that the TLS secret for the domain is created in. If you don't specify a namespace, the secret is created in the `default` namespace.

## Managing your domain in the console
{: #ingress-domains-ui-manage}
{: ui}

You can complete the following actions to manage your domain. 

Delete a domain
:   If you delete a domain from a cluster, the domain cannot be recovered. If you later need the domain, you must reprovision it. If delete a domain that is registered with the managed provider, you cannot reuse that domain name. Note that you cannot delete a cluster's default domain. If you want to delete the domain that is currently registered as the default, you must first assign a different default domain.

Update a domain's IP addresses or hostname
:   When you update the IP addresses or hostnames, you must include any IPs or hostnames that are currently registered to the domain. The domain updates with the exact values specified, so any current IP addresses or hostnames are overwritten if they are not included. For example, if `52.137.182.166` is currently registered to your domain and you want to add `52.137.182.270`, you must specify both IP addresses.

Change a cluster's default domain
:   You can change the default domain to any domain that exists in your cluster. This change might take up to five minutes to apply. During that time, your domain might experience downtime. 


## Setting up domains with the managed {{site.data.keyword.cloud_notm}} internal provider
{: #ingress-domain-int}
{: cli}

{{site.data.keyword.cloud_notm}} provides a managed, internal provider that you can use to create your own domains. You can use the `ibmcloud ks ingress domain create` command to create a new domain, or you can specify an existing domain that you want to add to your cluster. When you create a domain with the internal provider, you might specify a subdomain name, such as `exampledomain`, or provide the fully qualified domain name. The new domain is named in the format `exampledomain.<zone>.containers.appdomain.cloud`. 

```sh
ibmcloud ks ingress domain create --cluster CLUSTER [--is-default] [--domain DOMAIN] [--hostname HOSTNAME] [--ip IP] [--output OUTPUT] [-q] [--secret-namespace NAMESPACE]
```
{: pre}

`-c, --cluster CLUSTER`
:    Required. The name or ID of the cluster where you want to create the domain.

`--is-default`
:    Optional. Include this option to set the relevant domain as the default domain for the cluster. 

`--domain DOMAIN`
:    The domain to create or add to your cluster. This can be a domain that exists in your provider account, or a new domain. 

`--hostname HOSTNAME`
:    Optional. For VPC clusters. The hostname to register for the domain. 

`--ip IP`
:    Optional. The IP addresses to register for the domain. 

`--output OUTPUT`
:    Optional: Prints the command output in JSON format.

`--secret-namespace NAMESPACE`
:    Optional. The namespace that the domain TLS secret is created in. If no namespace is specified, the secret is created in the `default` namespace.


## Setting up domains with {{site.data.keyword.cis_full_notm}}
{: #ingress-domain-cis}
{: cli}

Follow the steps to create a domain with {{site.data.keyword.cis_full_notm}}.

### Set up service-to-service authorization
{: #ingress-domain-cis-s2s}

Creating a domain with {{site.data.keyword.cis_full_notm}} requires you to [set up service-to-service authorization](/docs/account?topic=account-serviceauth&interface=ui#create-auth) for your {{site.data.keyword.cis_full_notm}} instance. Set the source service as `Kubernetes Service`, and the target as `Internet services`. Assign the `Manager` service level role and the `Viewer` platform level role. 

### Create a domain
{: #ingress-domain-cis-create}

Create a new domain, or specify an existing domain that you want to add to your cluster. To specify an existing domain, include the full domain name with the external provider zone, such as `exampledomain.externalzone.com`. To create a new domain, you must still include the external provider zone, but you can customize the subdomain portion, such as `custom.exampledomain.externalzone.com`. Note that the domain name must be unique in the zone it is registered in.

If you delete a domain that is registered with the IBM internal provider, you cannot reuse the domain name.
{: note}


```sh
ibmcloud ks ingress domain create --cluster CLUSTER [--crn CRN] [--is-default] [--domain DOMAIN] [--hostname HOSTNAME] [--ip IP] [--output OUTPUT] [--domain-provider PROVIDER] [-q] [--secret-namespace NAMESPACE] [--zone ZONE]
```
{: pre}

`-c, --cluster CLUSTER`
:    Required. The name or ID of the cluster where you want to create the domain.

`--crn CRN`
:    Required for {{site.data.keyword.cis_full_notm}} domains. The CRN for the {{site.data.keyword.cis_full_notm}} instance.

`--is-default`
:    Optional. Include this option to set the relevant domain as the default domain for the cluster. 

`--domain DOMAIN`
:    The domain to create or add to your cluster. This can be a domain that exists in your provider account, or a new domain. 

`--hostname HOSTNAME`
:    For VPC clusters. The hostname to register for the domain. 

`--ip IP`
:    The IP addresses to register for the domain. 

`--output OUTPUT`
:    Optional: Prints the command output in JSON format.

`--domain-provider PROVIDER`
:    Required. The external DNS provider type. Specify `cis-ext` .

`--secret-namespace NAMESPACE`
:    Optional. The namespace that the domain TLS secret is created in. If no namespace is specified, the secret is created in the `default` namespace.

`--domain-zone ZONE`
:    Optional. The Domain ID for your {{site.data.keyword.cis_full_notm}} instance. This is a GUID value.

## Managing domains
{: #ingress-domains-manage}
{: cli}

Learn how to manage the domains that exist in your cluster.
{: shortdesc}

### Listing all domains in a cluster
{: #ingress-domains-manage-view-ls}

For more details and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli&interface=ui#ingress-domain-ls).

```sh
ibmcloud ks ingress domain ls --cluster CLUSTER
```
{: pre}

### Getting the details of a single domain
{: #ingress-domains-manage-view-get}

For more details and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli&interface=ui#ingress-domain-get).

```sh
ibmcloud ks ingress domain get --cluster CLUSTER --domain DOMAIN
```
{: pre}

### Removing a domain from a cluster
{: #ingress-domains-manage-rm}

If you delete a domain from a cluster, the domain cannot be recovered. If you later need the domain, you must reprovision it. Note that you cannot delete a cluster's default domain. If you want to delete the domain that is currently registered as the default, you must first [assign a different default domain](#ingress-domain-manage-default).

If you delete a domain that is registered with the IBM internal provider, you cannot reuse the domain name.
{: note}

For more details and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli&interface=ui#ingress-domain-rm).

```sh
ibmcloud ks ingress domain rm --cluster CLUSTER --domain DOMAIN
```
{: pre}

### Updating a domain's IP addresses or hostname
{: #ingress-domains-manage-update}

You can update a domain's registered IP addresses (for Classic or VPC clusters) or hostname (for VPC clusters) after the domain is created or added to the cluster. This command updates all the resources in your cluster with the specified IP addresses or hostnames and changes your app URLs. 

For more information and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli&interface=ui#ingress-domain-update).

Note that when you add IP addresses or hostnames, you must include any IPs or hostnames that are currently registered to the domain. The domain updates with the exact values specified, so any current IP addresses or hostnames are overwritten if they are not included. For example, if `52.137.182.166` is currently registered to your domain and you want to add `52.137.182.270`, you must specify `--ip 52.137.182.166 --ip 52.137.182.270` in the command.
{: important}

```sh
ibmcloud ks ingress domain update --cluster CLUSTER --domain DOMAIN [--hostname HOSTNAME] [--ip IP] 
```
{: pre}

### Changing a cluster's default domain
{: #ingress-domain-manage-default}

The default Ingress domain is used to form a unique URL for each of your apps and is the domain that is referenced by the IP addresses of any public ALBs in your cluster. When you provision a cluster, the default Ingress domain is automatically created for you, but you can change the default domain to any domain that exists in your cluster. To check your cluster's default domain, run `ibmcloud ks cluster get` and find the **Ingress subdomain** in the output. 

For more details and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli&interface=ui#ingress-domain-default-replace).

It can take up to five minutes for the default domain to update. During that time, your domain might experience downtime.
{: important}

```sh
ibmcloud ks ingress domain default replace --cluster CLUSTER --domain DOMAIN
```
{: pre}

## Managing domain secrets and certificates
{: #ingress-domain-manage-secrets}
{: cli}

Learn how to manage the TLS certificate for your Ingress domain. 

### Regenerating the certificate for an Ingress domain
{: #ingress-domain-manage-secrets-regen}

Regenerate the domain certificate to generate a new token in your DNS provider and apply it to your cluster.

For more details and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#ingress-domain-secret-regenerate)

```sh
ibmcloud ks ingress domain secret regenerate --cluster CLUSTER --domain DOMAIN
```
{: pre}

### Deleting an Ingress domain secret
{: #ingress-domain-manage-secrets-rm}

Delete the secret for an Ingress domain and prevent future renewal of the certificate. 

For more details and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#ingress-domain-secret-rm)

```sh
ibmcloud ks ingress domain secret rm --cluster CLUSTER --domain DOMAIN 
```
{: pre}
