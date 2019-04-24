.</li>
  <li><strong>Ingress Annotation</strong>: [Added TCP port annotations](/docs/containers?topic=containers-ingress_annotation#ingress_annotation).</li>
  <li><strong>Integrations</strong>: Added Splunk as a [supported integration](/docs/containers?topic=containers-supported_integrations#supported_integrations).</li>
  <li><strong>New! Site map</strong>: [Added a site map](/docs/containers?topic=containers-cs_sitemap#cs_sitemap) to the documentation.</li></ul></td>
</tr>
<tr>
  <td>15 February 2019</td>
  <td><ul>
  <li><strong>Changelogs</strong>: Added changelogs for [worker node fix packs](/docs/containers?topic=containers-changelog#changelog).</li>
  <li><strong>Cluster autoscaling</strong>: Updated the `scaleDownUtilizationThreshold` [custom setting](/docs/containers?topic=containers-ca#ca).</li>
  <li><strong>Deploying apps</strong>: [Added prerequisite steps](/docs/containers?topic=containers-app#app) to have an IAM service access role to {{site.data.keyword.containerlong_notm}} to access Kubernetes resources.</li>
  <li><strong>Firewall</strong>: [Added a step](/docs/containers?topic=containers-firewall#firewall_outbound) to allow outgoing network traffic {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM).</li>
  <li><strong>Ingress</strong>: Added information about [importing certificates](/docs/containers?topic=containers-ingress#ingress) and using Istio with the Ingress ALB.</li>
  <li><strong>Ingress Annotation</strong>: [Updated Istio annotations](/docs/containers?topic=containers-ingress_annotation#ingress_annotation). Updated `client.crt` to `ca.crt`.</li>
  <li><strong>Istio</strong>: [Added information](/docs/containers?topic=containers-istio#istio) about the BookInfo sample app, creating Kubernetes services, and exposing apps by using the Ingress subdomain.</li>
  <li><strong>strongSwan VPN</strong>: Added how to configure the [strongSwan VPN in a multizone cluster](/docs/containers?topic=containers-vpn#vpn_multizone).</li>
  <li><strong>Subnets</strong>: [Added a zone annotation](/docs/containers?topic=containers-subnets#review_ip) to the service YAML.</li>
  <li><strong>Use cases</strong>: Added {{site.data.keyword.appid_full}} to [use case scenarios](/docs/containers?topic=containers-cs_uc_intro#cs_uc_intro).</li></ul></td>
</tr>
<tr>
  <td>08 February 2019</td>
  <td><ul>
  <li><strong>CLI reference</strong>: Updated [CLI reference docs](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference) with `--skip-rbac` option to speed up `cluster-config` if you use custom RBAC instead of IAM service access roles.</li>
  <li><strong>{{site.data.keyword.Bluemix_notm}} regions</strong>: Updated [how to log in](/docs/containers?topic=containers-regions-and-zones#bluemix_regions) to {{site.data.keyword.Bluemix_notm}} by using the new `cloud.ibm.com` API endpoint instead of the previous `bluemix.net`.</li></ul></td>
</tr>
<tr>
  <td>07 February 2019</td>
  <td><ul>
  <li><strong>Certified Kubernetes 1.13</strong>: [The Kubernetes 1.13 release](/docs/containers?topic=containers-cs_versions#cs_v113) is now certified.</li>
  <li><strong>CLI reference</strong>: Updated [CLI reference docs](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference) with rate limit tips for `ibmcloud ks alb` commands.</li>
  <li><strong>Ingress</strong>: [Clarified that Ingress](/docs/containers?topic=containers-ingress#config_prereqs) requires two worker nodes per zone to ensure high availability.</li>
  <li><strong>Ingress Annotation</strong>: Added a tip for the [rewrite path annotation](/docs/containers?topic=containers-ingress_annotation#rewrite-path) to include a trailing `/` if your app returns a 404 after adding the annotation.</li>
  <li><strong>PVC attributes</strong>: The [file](/docs/containers?topic=containers-file_storage#file_storage), [block](/docs/containers?topic=containers-block_storage#block_storage), [object](/docs/containers?topic=containers-object_storage#object_storage), and [Portworx](/docs/containers?topic=containers-portworx#portworx) storage docs are updated to specify the storage class as an attribute, not an annotation, in the PVC.</li></ul></td>
</tr>
<tr>
  <td>06 February 2019</td>
  <td><ul>
  <li><strong>Cluster DNS provider</strong>: In Kubernetes version 1.13 and later, CoreDNS is the default [cluster DNS provider](/docs/containers?topic=containers-cluster_dns#cluster_dns). You can customize CoreDNS, or change the cluster DNS provider between CoreDNS and KubeDNS.</li>
  <li><strong>New! Istio managed add-on</strong>: [Istio on {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-istio) provides a seamless installation of Istio, automatic updates and lifecycle management of Istio control plane components, and integration with platform logging and monitoring tools. With one click, you can get all Istio core components, additional tracing, monitoring, and visualization, and the BookInfo sample app up and running. Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on, so {{site.data.keyword.Bluemix_notm}} automatically keeps all your Istio components up to date.</li>
  <li><strong>New! Knative managed add-on</strong>: [Knative](/docs/containers?topic=containers-knative_tutorial) is an open source platform that extends the capabilities of Kubernetes to help you create modern, source-centric containerized and serverless apps on top of your Kubernetes cluster. Managed Knative on {{site.data.keyword.containerlong_notm}} is a managed add-on that integrates Knative and Istio directly with your Kubernetes cluster. The Knative and Istio version in the add-on are tested by IBM and supported for the use in {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>New! Kubernetes version 1.13</strong>: Create or update your clusters to [Kubernetes 1.13](/docs/containers?topic=containers-cs_versions#cs_v113).</li>
  <li><strong>NFS file storage</strong>: The file storage docs are updated to include examples for using [topology-aware volume scheduling](/docs/containers?topic=containers-file_storage#file-topology) to delay the creation of a file storage instance until the first pod that uses the storage is created.</li>
  <li><strong>Portworx storage</strong>: Added a link to the process to [order a Portworx license](/docs/containers?topic=containers-portworx#portworx) if you are an IBM employee.</li>
  <li><strong>Reference topics</strong>: To support new features such as Kubernetes 1.13, Istio managed add-on, and Knative managed add-on, the [CLI](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference), [user access](/docs/containers?topic=containers-access_reference#access_reference), and [changelog](/docs/containers?topic=containers-changelog#changelog) reference pages are updated.</li></ul></td>
</tr>
<tr>
  <td>04 February 2019</td>
  <td><ul>
  <li><strong>AES 256-bit encryption</strong>: Clarified that worker nodes feature [AES 256-bit disk encryption](/docs/containers?topic=containers-encryption#encryption) by default.</li>
  <li><strong>New cluster autoscaler name</strong>: The cluster autoscaler Helm chart v1.0.3 is renamed from `ibm-ks-cluster-autoscaler` to `ibm-iks-cluster-autoscaler`. [Update](/docs/containers?topic=containers-ca#ca_helm_up_102) to the latest Helm version today.</li>
  </ul></td>
</tr>
</tbody></table>


## January 2019
{: #feb19}

</staging>
