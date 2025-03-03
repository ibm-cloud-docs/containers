---

copyright: 
  years: 2014, 2025
lastupdated: "2025-02-28"


keywords: containers, kubernetes, mzr, szr, multizone, multi az

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Locations
{: #regions-and-zones}

[{{site.data.keyword.cloud_notm}} resources](/docs/overview?topic=overview-locations) are organized into a hierarchy of geographic locations. {{site.data.keyword.containerlong_notm}} is available in a subset of the {{site.data.keyword.cloud_notm}} locations, including worldwide multizone regions (MZRs) and single-campus multizone regions (SC-MZRs).
{: shortdesc}

![{{site.data.keyword.containerlong_notm}} locations](images/locations.svg){: caption="{{site.data.keyword.containerlong_notm}} locations" caption-side="bottom"}

This image is an artistic representation and does not reflect actual political or geographic boundaries.
{: note}


## {{site.data.keyword.containerlong_notm}} locations
{: #locations}

Availability of a cluster is based on the type of cluster it is and how many replicas of the resources you have.
{: shortdesc}

The term `zone` in this document refers to different things depending the type of infrastructure being used. For VPC, the term `zone` refers to the zone names within an MZR, such as `us-south-1`. For Classic infrastructure, the term `zone` refers to a Classic data center, such as `dal10`. 
{: tip}

### Classic regions with multiple data centers
{: #zones-mz}

If you create a classic cluster with multiple data centers, the replicas of the highly available Kubernetes master are automatically spread across the data centers. You have the option to spread your worker nodes across classic zones (data centers) to protect your apps from a zone failure. To determine whether a classic region has multiple data centers from the CLI, your can run `ibmcloud ks locations` and look for the value in the `Multizone Metro` column.
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
{: caption="Available multizone regions for classic clusters in {{site.data.keyword.containerlong_notm}}." caption-side="bottom"}
{: #classic-multizone-locations-table}



`*` lon05 replaces lon02. New clusters must use lon05, which supports highly available masters that are spread across zones.
{: note}



### Classic regions with one data center
{: #zones-sz}

If you create a classic cluster in a region with only one data center, the highly available master includes three replicas on separate hosts, but is not spread across classic zones.
{: shortdesc}

Classic regions with one data center are managed from the regional endpoint located in the nearest region that supports classic data centers, such as `mon01` to `us-east` or `sao01` to `us-south`.

The Milan (`mil01`) datacenter is deprecated and closes on 31 October 2025. Migrate your {{site.data.keyword.containerlong_notm}} on IBM Cloud clusters currently hosted in `mil01` to another IBM Cloud datacenter by 31 October 2025.
{: deprecated}

| Geography | Country | Metro | Region | Zone | Managed from region |
| --- | --- | --- | --- | --- | --- |
| Asia Pacific | India | Chennai | in-che | che01 | AP North (`ap-north`, `jp-tok`) |
| Asia Pacific | Singapore | Singapore | sng-mtr | sng01 | AP North (`ap-north`, `jp-tok`) |
| Europe | France | Paris | fr-par | par01 | EU Central (`eu-central`, `eu-de`) |
| Europe | Italy | Milan | it-mil | mil01 | EU Central (`eu-central`, `eu-de`) |
| Europe | Netherlands | Amsterdam | nl-ams | ams03 | EU Central (`eu-central`, `eu-de`) |
| North America | Canada | Montreal | ca-mon | mon01 | US East (`us-east`) |
| North America | Canada | Toronto | ca-tor | tor01 | US East (`us-east`) |
| North America | United States | San Jose | us-sjc | sjc03, sjc04 | US South (`us-south`) |
| South America | Brazil | Sao Paulo | br-sao | sao01 | US South (`us-south`) |
{: caption="Available single zone data centers for classic clusters in {{site.data.keyword.containerlong_notm}}." caption-side="bottom"}
{: #classic-single-zone-locations-table}



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
{: caption="Available multizone regions for VPC clusters in {{site.data.keyword.containerlong_notm}}." caption-side="bottom"}
{: #vpc-gen2-multizone-locations-table}



`†` These regions are available as multizone regions for clusters on VPC infrastructure only.



## Where are the resources?
{: #regions_resources}

Where your resources are stored in the cluster depends on the availability of the cluster A cluster might be available in a single zone or multiple zones (multizone). 

### Resources in single zone clusters
{: #regions_single_zone}

Your cluster's resources remain in the data center in which the cluster is deployed, but management operations might be routed through a regional endpoint.
{: shortdesc}

Your cluster's resources, including the master and worker nodes, are in the same zone that you deployed the cluster to. When you initiate local container orchestration actions, such as `kubectl` commands, the information is exchanged between your master and worker nodes within the same zone.

If you set up other cluster resources, such as storage, networking, compute, or apps running in pods, the resources and their data remain in the data center that you deployed your cluster to.

When you initiate cluster management actions, such as running **`ibmcloud ks`** commands, basic information about the cluster such as name, ID, user, the command is routed through a regional endpoint and the global endpoint. 

### Resources in multizone clusters
{: #regions_multizone}

In multizone clusters, the cluster's resources are spread across multiple locations (zones for VPC and data centers for Classic) for higher availability.
{: shortdesc}

Worker nodes are spread across multiple VPC zones or Classic data centers in the region to provide more availability for your cluster. The Kubernetes master replicas are also spread across zones or classic data centers. When you initiate local container orchestration actions, such as **`kubectl`** commands, the information is exchanged between your master and worker nodes through the global endpoint.

Other cluster resources, such as storage, networking, compute, or apps running in pods, vary in how they deploy to the zones in your cluster. For more information, review these topics:
*   Setting up [file storage](/docs/containers?topic=containers-file_storage#add_file) and [block storage](/docs/containers?topic=containers-block_storage#add_block) in clusters, or [choosing a multizone persistent storage solution](/docs/containers?topic=containers-storage-plan).
*   [Enabling public or private access to an app by using a network load balancer (NLB) service in a cluster](/docs/containers?topic=containers-loadbalancer#multi_zone_config).
*   [Managing network traffic by using Ingress](/docs/containers?topic=containers-managed-ingress-about).
*   [Increasing the availability of your app](/docs/containers?topic=containers-app).

When you initiate cluster management actions, such as running [`ibmcloud ks` commands](/docs/containers?topic=containers-kubernetes-service-cli), basic information about the cluster, such as name, ID, user, the command is routed through the global endpoint.






## Previous {{site.data.keyword.cloud_notm}} region and zone structure
{: #bluemix_regions}

Previously, your {{site.data.keyword.cloud_notm}} resources were organized into regions. Regions are a conceptual tool to organize zones, and can include zones (data centers) in different countries and geographies. The following table maps the previous {{site.data.keyword.cloud_notm}} regions, {{site.data.keyword.containerlong_notm}} regions, and {{site.data.keyword.containerlong_notm}} zones. Multizone-capable zones are in bold.
{: shortdesc}

Region-specific endpoints for {{site.data.keyword.containerlong_notm}} are deprecated. Use the global endpoint instead. If you must use regional endpoints, use the `ibmcloud ks api` command. For more information, see [`ibmcloud ks api`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cli_api).
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
