---

copyright:
  years: 2014, 2019
lastupdated: "2019-12-03"

keywords: kubernetes, iks, ibmcloud, ic, ks, kubectl, api

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:preview: .preview} 

# Setting up the API
{: #cs_api_install}

You can use the {{site.data.keyword.containerlong}} API to create and manage your community Kubernetes or {{site.data.keyword.openshiftshort}} clusters. To use the CLI, see [Setting up the CLI](/docs/containers?topic=containers-cs_cli_install).
{:shortdesc}

## About the API
{: #api_about}

The {{site.data.keyword.containerlong_notm}} API automates the provisioning and management of {{site.data.keyword.cloud_notm}} infrastructure resources for your clusters so that your apps have the compute, networking, and storage resources that they need to serve your users.
{:shortdesc}

The API is versioned to support the different infrastructure providers that are available for you to create clusters. For more information, see [Overview of Classic and VPC infrastructure providers](/docs/containers?topic=containers-infrastructure_providers).

You can use the version two (`v2`) API to manage both classic and VPC clusters. The `v2` API is designed to avoid breaking existing functionality when possible. However, make sure that you review the following differences between the `v1` and `v2` API.

<table summary="The rows are read from left to right, with the area of comparison in column one, version 1 API in column two, and version 2 API in column three.">
<caption>{[product_name_notm]} API versions</caption>
<col width="20%">
<col width="40%">
<col width="40%">
 <thead>
 <th>Area</th>
 <th>v1 API</th>
 <th>v2 API</th>
 </thead>
 <tbody>
 <tr>
   <td>API endpoint</td>
   <td>https://containers.cloud.ibm.com/global/v1</td>
   <td>https://containers.cloud.ibm.com/global/v2</td>
 </tr>
 <tr>
   <td>API reference docs</td>
   <td>[`https://containers.cloud.ibm.com/global/swagger-global-api/` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://containers.cloud.ibm.com/global/swagger-global-api/)</td>
   <td>[`https://containers.cloud.ibm.com/global/swagger-global-api/` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://containers.cloud.ibm.com/global/swagger-global-api/)</td>
 </tr>
 <tr>
   <td>API architectural style</td>
   <td>Representational state transfer (REST) that focuses on resources that you interact with through HTTP methods such as `GET`, `POST`, `PUT`, `PATCH`, and `DELETE`.</td>
   <td>Remote procedure calls (RPC) that focus on actions through only `GET` and `POST` HTTP methods.</td>
 </tr>
 <tr>
    <td>Supported container platforms</td>
    <td>Use the {[product_name_notm]} API to manage your {{site.data.keyword.cloud_notm}} infrastructure resources, such as worker nodes, for **both community Kubernetes and {{site.data.keyword.openshiftshort}} clusters**.</td>
    <td>VPC clusters are available for **only community Kubernetes clusters**, not {{site.data.keyword.openshiftshort}} clusters. As such, provider-specific `v2` API calls against {{site.data.keyword.openshiftshort}} clusters fail.</td>
 </tr>
 <tr>
  <td>Kubernetes API</td>
  <td>To use the Kubernetes API to manage Kubernetes resources within the cluster, such as pods or namespaces, see [Working with your cluster by using the Kubernetes API](#kube_api).</td>
  <td>Same as `v1`; see [Working with your cluster by using the Kubernetes API](#kube_api).</td>
 </tr>
 <tr>
   <td>Supported infrastructure providers</td>
   <td>`classic`</td>
   <td>`vpc` and `classic`<ul>
   <li>The `vpc` provider is designed to support multiple VPC subproviders. The supported VPC subprovider is `vpc-classic`, which corresponds to a VPC cluster for Generation 1 compute resources.</li>
   <li>Provider-specific requests have a path parameter in the URL, such as `v2/vpc/createCluster`. Some APIs are only available to a particular provider, such as `GET vlan` for classic or `GET vpcs` for VPC.</li>
   <li>Provider-agnostic requests can include a provider-specific body parameter that you specify, usually in JSON, such as `{"provider": "vpc"}`, if you want to return responses for only the specified provider.</li></ul></td>
 </tr>
 <tr>
   <td>`GET` responses</td>
   <td>The `GET` method for a collection of resources (such as `GET v1/clusters`) returns the same details for each resource in the list as a `GET` method for an individual resource (such as `GET v1/clusters/{idOrName}`).</td>
   <td>To return responses faster, the v2 `GET` method for a collection of resources (such as `GET v2/clusters`) returns only a subset of information that is detailed in a `GET` method for an individual resource (such as `GET v2/clusters/{idOrName}`).
   <br><br>Some list responses include a providers property to identify whether the returned item applies to classic or VPC infrastructure. For example, the `GET zones` list returns some results such as `mon01` that are available only in the classic infrastructure provider, while other results such as `us-south-01` are available only in the VPC infrastructure provider.</td>
 </tr>
 <tr>
   <td>Cluster, worker node, and worker-pool responses</td>
   <td>Responses include only information that is specific to the classic infrastructure provider, such as the VLANs in `GET` cluster and worker responses.</td>
   <td>The information that is returned varies depending on the infrastructure provider. For such provider-specific responses, you can specify the provider in your request. For example, VPC clusters do not return VLAN information since they do not have VLANs. Instead, they return subnet and CIDR network information.</td>
 </tr>
</tbody>
</table>

{[white-space.md]}

{[pg-api-install.md]}
