---

copyright: 
  years: 2014, 2023
lastupdated: "2023-09-26"

keywords: kubernetes, mzr, szr, multizone, multi az

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# Locations
{: #regions-and-zones}

You can deploy {{site.data.keyword.containerlong}} clusters worldwide. When you create a cluster, its resources remain in the location that you deploy the cluster to. To work with your cluster, you can access the service via a global API endpoint.
{: shortdesc}



![{{site.data.keyword.containerlong_notm}} locations](images/locations.svg){: caption="Figure 1. {{site.data.keyword.containerlong_notm}} locations" caption-side="bottom"}


This image is an artistic representation and does not reflect actual political or geographic boundaries.
{: note}




## {{site.data.keyword.containerlong_notm}} locations
{: #locations}

{{site.data.keyword.cloud_notm}} resources are organized into a hierarchy of geographic locations. {{site.data.keyword.containerlong_notm}} is available in a subset of these locations, including worldwide multizone regions and single zone regions. Other {{site.data.keyword.cloud_notm}} services might be available globally or within a specific location.
{: shortdesc}

```sh
ibmcloud ks locations
```
{: pre}

### How locations are organized
{: #example_locations_org}

The following image is used as an example to explain how {{site.data.keyword.containerlong_notm}} locations are organized. For more information, see [Locations for resource deployment](/docs/overview?topic=overview-locations).
{: shortdesc}

![Organization of {{site.data.keyword.containerlong_notm}} locations](images/cs_regions_hierarchy.png){: caption="Figure 1. Organization of {{site.data.keyword.containerlong_notm}} locations" caption-side="bottom"}


|Type|Example|Description|
|--- |--- |--- |
|Geography |North America (`na`)|An organizational grouping that is based on geographic continents.|
|Country|Canada (`ca`)|The location's country within the geography.|
|Metro| For example, Dallas (`dal`). |The name of a city where 1 or more data centers are located. A metro might have a multizone region, such as Dallas, or might have a single zone region, such as Milan. If you create a cluster in a multizone region, the Kubernetes master and worker nodes can be spread across zones for high availability.|
|Data center (zone)|Dallas 12 (`dal12`)|A physical location of the compute, network, and storage infrastructure and related cooling and power that host cloud services and applications. In a region, clusters can be spread across data centers, or zones, in an multizone architecture for high availability. Zones are isolated from each other, which ensures no shared single point of failure.|
{: caption="Organization of {{site.data.keyword.containerlong_notm}} locations."}

### Classic multizone regions
{: #zones-mz}

If you create a classic cluster in a multizone region, the replicas of your highly available Kubernetes master are automatically spread across the data centers (zones). You have the option to spread your worker nodes across zones to protect your apps from a zone failure. To determine whether a location has a multizone region, your can run `ibmcloud ks locations` and look for the value in the `Multizone Metro` column.
{: shortdesc}

| Geography | Country | Metro | Region | Zones |
| --- | --- | --- | --- | --- |
| Asia Pacific | Australia | Sydney | au-syd | syd01, syd04, syd05 |
| Asia Pacific | Japan | Osaka | jp-osa | osa21, osa22, osa23 |
| Asia Pacific | Japan | Tokyo | jp-tok | tok02, tok04, tok05 |
| Europe | Germany | Frankfurt | de-fra | fra02, fra04, fra05 |
| Europe | United Kingdom | London | uk-lon | lon02, lon04, lon05, lon06 |
| North America | United States | Dallas | us-dal | dal10, dal12, dal13 |
| North America | United States | Washington DC | us-wdc | wdc04, wdc06, wdc07 |
{: caption="Available multizone metro locations for classic clusters in {{site.data.keyword.containerlong_notm}}." caption-side="bottom"}



`*` lon05 replaces lon02. New clusters must use lon05, which supports highly available masters that are spread across zones.
{: note}



### Classic single zone regions
{: #zones-sz}

If you create a classic cluster in a single zone region, you can create multiple worker nodes but you can't spread them across data centers (zones). The highly available master includes three replicas on separate hosts, but is not spread across zones.
{: shortdesc}

Classic single zone clusters are managed from the regional endpoint located in the nearest region that supports classic multizone, such as `mon01` to `us-east` or `sao01` to `us-south`.

| Geography | Country | Metro | Region | Zone | Managed from region |
| --- | --- | --- | --- | --- | --- |
| Asia Pacific | India | Chennai | in-che | che01 | AP North (`ap-north`, `jp-tok`) |
| Asia Pacific | Singapore | Singapore | sng-mtr | sng01 | AP North (`ap-north`, `jp-tok`) |
| Europe | Italy | Milan | it-mil | mil01 | EU Central (`eu-central`, `eu-de`) |
| Europe | Netherlands | Amsterdam | nl-ams | ams03 | EU Central (`eu-central`, `eu-de`) |
| North America | Canada | Montreal | ca-mon | mon01 | US East (`us-east`) |
| North America | Canada | Toronto | ca-tor | tor01 | US East (`us-east`) |
| North America | United States | San Jose | us-sjc | sjc03, sjc04 | US South (`us-south`) |
| South America | Brazil | Sao Paulo | br-sao | sao01 | US South (`us-south`) |
{: caption="Available single zone data center locations for classic clusters in {{site.data.keyword.containerlong_notm}}." caption-side="bottom"}



### VPC multizone regions
{: #zones-vpc}

VPC resources are provisioned in a region, which is a separate group of zones within a metro. The zones are mapped to separate data centers to ensure that resources are distributed evenly across zones in a multizone architecture. In the API and CLI, zones use the regional zone name in the API and command line (`us-south-1`), but in the console, zones use by the data center location (`Dallas 1`). For the data center code that the VPC zone and location corresponds to, such as `us-south-1` and `DAL10`, see [Multizone regions](/docs/overview?topic=overview-locations#table-mzr).
{: shortdesc}

| Geography | Country | Metro | Region | Zones |
| --- | --- | --- | --- | --- |
| Asia Pacific | Australia | Sydney | au-syd | au-syd-1, au-syd-2, au-syd-3 |
| Asia Pacific | Japan | Osaka | jp-osa | jp-osa-1, jp-osa-2, jp-osa-3 |
| Asia Pacific | Japan | Tokyo | jp-tok | jp-tok-1, jp-tok-2, jp-tok-3 |
| Europe | Germany | Frankfurt | eu-de | eu-de-1, eu-de-2, eu-de-3 |
| Europe | Spain | `†` Madrid | eu-es | eu-es-1, eu-es-2, eu-es-3 |
| Europe | United Kingdom | London | eu-gb | eu-gb-1, eu-gb-2, eu-gb-3 |
| North America | Canada | `†` Toronto | ca-tor | ca-tor-1, ca-tor-2, ca-tor-3 |
| North America | United States | Dallas | us-south | us-south-1, us-south-2, us-south-3 |
| North America | United States | Washington DC | us-east | us-east-1, us-east-2, us-east-3 |
| South America | Brazil | `†` São Paulo | br-sao | br-sao-1, br-sao-2, br-sao-3 |
{: caption="Available multizone metro locations for VPC clusters in {{site.data.keyword.containerlong_notm}}." caption-side="bottom"}



`†` These regions are available as multizone regions for clusters on VPC infrastructure only.

### Resources in a single zone cluster
{: #regions_single_zone}

In a single zone cluster, your cluster's resources remain in the data center (zone) in which the cluster is deployed, but management operations might be routed through a regional endpoint.
{: shortdesc}

Your cluster's resources, including the master and worker nodes, are in the same zone that you deployed the cluster to. When you initiate local container orchestration actions, such as `kubectl` commands, the information is exchanged between your master and worker nodes within the same zone.

If you set up other cluster resources, such as storage, networking, compute, or apps running in pods, the resources and their data remain in the zone that you deployed your cluster to.

When you initiate cluster management actions, such as running **`ibmcloud ks`** commands, basic information about the cluster such as name, ID, user, the command is routed through a regional endpoint and the global endpoint. 



### Resources in a multizone cluster
{: #regions_multizone}

In a multizone cluster, your cluster's resources are spread across multiple zones for higher availability.
{: shortdesc}

Worker nodes are spread across multiple zones in the metro location to provide more availability for your cluster. The Kubernetes master replicas are also spread across zones. When you initiate local container orchestration actions, such as **`kubectl`** commands, the information is exchanged between your master and worker nodes through the global endpoint.

Other cluster resources, such as storage, networking, compute, or apps running in pods, vary in how they deploy to the zones in your multizone cluster. For more information, review these topics:
*   Setting up [file storage](/docs/containers?topic=containers-file_storage#add_file) and [block storage](/docs/containers?topic=containers-block_storage#add_block) in multizone clusters, or [choosing a multizone persistent storage solution](/docs/containers?topic=containers-storage-plan).
*   [Enabling public or private access to an app by using a network load balancer (NLB) service in a multizone cluster](/docs/containers?topic=containers-loadbalancer#multi_zone_config).
*   [Managing network traffic by using Ingress](/docs/containers?topic=containers-managed-ingress-about).
*   [Increasing the availability of your app](/docs/containers?topic=containers-app).

When you initiate cluster management actions, such as running [`ibmcloud ks` commands](/docs/containers?topic=containers-kubernetes-service-cli), basic information about the cluster, such as name, ID, user, the command is routed through the global endpoint.






## Accessing the global endpoint
{: #endpoint}

You can organize your resources across {{site.data.keyword.cloud_notm}} services by using {{site.data.keyword.cloud_notm}} locations (formerly called regions). For example, you can deploy an app to a cluster by using a private Docker image that is stored in your {{site.data.keyword.registrylong_notm}} of the same location. To access these resources, you can use the global endpoints and filter by location.
{: shortdesc}

### Logging in to {{site.data.keyword.cloud_notm}}
{: #login-ic}

When you log in to the {{site.data.keyword.cloud_notm}} (`ibmcloud`) command line, you are prompted to select a region. However, this region does not affect the {{site.data.keyword.containerlong_notm}} plug-in (`ibmcloud ks`) endpoint, which still uses the global endpoint. Note that you do still need to target the resource group that your cluster is in if it is not in the default resource group.
{: shortdesc}

To log in to the {{site.data.keyword.cloud_notm}} global API endpoint and target the resource group that your cluster is in:
```sh
ibmcloud login -a https://cloud.ibm.com -g <nondefault_resource_group_name>
```
{: pre}

### Logging in to {{site.data.keyword.containerlong_notm}}
{: #login-iks}

When you log in to {{site.data.keyword.cloud_notm}}, you can access the {{site.data.keyword.containershort_notm}}. To help you get started, check out the following resources for using the {{site.data.keyword.containerlong_notm}} CLI and API.
{: shortdesc}

[Install the IBM Cloud CLI](/docs/containers?topic=containers-cli-install)
[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

When you use the new global functionality in the {{site.data.keyword.containerlong_notm}} CLI, consider the following changes from the legacy region-based functionality.

* Listing resources:
    * When you list resources, such as with the `ibmcloud ks cluster ls`, `ibmcloud ks subnets`, or `ibmcloud ks zone ls` commands, resources in all locations are returned. To filter resources by a specific location, certain commands include a `--location` option. For example, if you filter clusters for the `wdc` metro, multizone clusters in that metro and single-zone clusters in data centers (zones) within that metro are returned. If you filter clusters for the `wdc06` data center (zone), multizone clusters that have a worker node in that zone and single-zone clusters in that zone are returned. `ibmcloud ks cluster ls -l dal`.

    * Other commands don't return resources in all locations. To run `credential set/unset/get`, `api-key reset`, and `vlan spanning get` commands, you must specify a region in the `--region`.

* Working with resources:
    * When you use the global endpoint, you can work with resources that you have access permissions to in any location, even if you target one region and the resource that you want to work with is in another region.
    * If you have clusters with the same name in different regions, use the cluster ID when you run commands or set a region with the `ibmcloud ks init` command and use the cluster name when you run commands.

* Legacy functionality:
    * If you need to list and work with resources from one region only, you can use the `ibmcloud ks init` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_init) to target a regional endpoint instead of the global endpoint. Example to target the US South regional endpoint:
        ```sh
        ibmcloud ks init --host https://us-south.containers.cloud.ibm.com
        ```
        {: pre}

    * To use the global functionality, you can use the `ibmcloud ks init` command again to target the global endpoint. Example to target the global endpoint again:
        ```sh
        ibmcloud ks init --host https://containers.cloud.ibm.com
        ```
        {: pre}




**{{site.data.keyword.containerlong_notm}} API**:
* [Get started with the API](/docs/containers?topic=containers-cs_api_install#cs_api).
* [View documentation on the API commands](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external}.
* Generate a client of the API to use in automation by using the [`swagger.json` API](https://containers.cloud.ibm.com/global/swagger-global-api/swagger.json){: external}.

To interact with the global {{site.data.keyword.containerlong_notm}} API, enter the command type and append `global/v1/command` to the endpoint.

Example of `GET /clusters` global API:
```sh
GET https://containers.cloud.ibm.com/global/v1/clusters
```
{: codeblock}



If you need to specify a region in an API call, remove the `/global` parameter from the path and pass the region name in the `X-Region` header. To list available regions, review the [Previous region](#zones-mz) column in the {{site.data.keyword.containerlong_notm}} locations table.





## Previous {{site.data.keyword.cloud_notm}} region and zone structure
{: #bluemix_regions}

Previously, your {{site.data.keyword.cloud_notm}} resources were organized into regions. Regions are a conceptual tool to organize zones, and can include zones (data centers) in different countries and geographies. The following table maps the previous {{site.data.keyword.cloud_notm}} regions, {{site.data.keyword.containerlong_notm}} regions, and {{site.data.keyword.containerlong_notm}} zones. Multizone-capable zones are in bold.
{: shortdesc}

Region-specific endpoints for {{site.data.keyword.containerlong_notm}} are deprecated. Use the [global endpoint](#endpoint) instead. If you must use regional endpoints, [use the `ibmcloud ks api` command](/docs/containers?topic=containers-kubernetes-service-cli#cs_cli_api).
{: deprecated}

By using {{site.data.keyword.containerlong_notm}} regions, you can create or access Kubernetes clusters in a region other than the {{site.data.keyword.cloud_notm}} region that you are logged in to. {{site.data.keyword.containerlong_notm}} region endpoints refer specifically to the {{site.data.keyword.containerlong_notm}}, not {{site.data.keyword.cloud_notm}} as a whole.

You might want to log in to another {{site.data.keyword.containerlong_notm}} region for the following reasons:
    * You created {{site.data.keyword.cloud_notm}} services or private Docker images in one region and want to use them with {{site.data.keyword.containerlong_notm}} in another region.
    * You want to access a cluster in a region that is different from the default {{site.data.keyword.cloud_notm}} region that you are logged in to.

To switch regions, use the `ibmcloud ks init` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_init).

| {{site.data.keyword.containerlong_notm}} region | Corresponding {{site.data.keyword.cloud_notm}} regions | Available zones in the region |
| --- | --- | --- |
| AP North (standard clusters only) | Tokyo | che01, sng01, **tok02, tok04, tok05** |
| AP South | Sydney | **syd01, syd04, syd05** |
| EU Central | Frankfurt | ams03, **fra02, fra04, fra05**, mil01, par01 |
| UK South | London | lon02, **lon04, lon05, lon06** |
| US East (standard clusters only) | Washington DC | mon01, tor01, **wdc04, wdc06, wdc07** |
| US South | Dallas | **dal10, dal12, dal13**, sjc03, sjc04, sao01 |
{: caption="Corresponding {{site.data.keyword.containershort}} and {{site.data.keyword.cloud_notm}} regions, with zones. Multizone-capable zones are in bold." caption-side="bottom"}




