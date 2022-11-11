---

copyright: 
  years: 2014, 2022
lastupdated: "2022-11-11"

keywords: kubernetes

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}




# Managing security and compliance with Kubernetes
{: #manage-security-compliance}

{{site.data.keyword.containerlong}} is integrated with the {{site.data.keyword.compliance_short}} to help you manage security and compliance for your organization.
{: shortdesc}

With the {{site.data.keyword.compliance_short}}, you can:

* Monitor for controls and goals that pertain to {{site.data.keyword.containerlong_notm}}.
* Define rules for {{site.data.keyword.containerlong_notm}} that can help to standardize resource configuration.

## Monitoring security and compliance posture with Kubernetes
{: #monitor-clusters}

As a security or compliance focal, you can use the {{site.data.keyword.containerlong_notm}} [goals](#x2117978){: term} to help ensure that your organization is adhering to the external and internal standards for your industry. By using the {{site.data.keyword.compliance_short}} to validate the resource configurations in your account against a [profile](#x2034950){: term}, you can identify potential issues as they arise.
{: shortdesc}


All of the goals for {{site.data.keyword.containerlong_notm}} are added to the {{site.data.keyword.cloud_notm}} Control Library profile, but can also be mapped to other profiles.
{: note}

To start monitoring your resources, check out [Getting started with {{site.data.keyword.compliance_short}}](/docs/security-compliance?topic=security-compliance-getting-started).

### Available goals for Kubernetes
{: #clusters-available-goals}

Review the following goals for {{site.data.keyword.containerlong_notm}}.
{: shortdesc}


- **Check whether {{site.data.keyword.containershort_notm}} clusters are accessible only by using private endpoints.** You can [disable the public cloud service endpoint](/docs/containers?topic=containers-cs_network_cluster#disable-public-se). For more information, see [Planning your cluster network setup](/docs/containers?topic=containers-plan_clusters).
- **Check whether {{site.data.keyword.containershort_notm}} Ingress is configured only with TLS v1.2 for all inbound traffic.** The default TLS versions are 1.2 or 1.3. For more information, see [About Ingress](/docs/containers?topic=containers-ingress-about).
- **Check whether {{site.data.keyword.containershort_notm}} clusters are enabled with IBM Log Analysis.** For more information, see [Choosing a logging solution](/docs/containers?topic=containers-health#logging_overview).
- **Check whether {{site.data.keyword.containershort_notm}} clusters are enabled with IBM Cloud Monitoring.** For more information, see [Choosing a monitoring solution](/docs/containers?topic=containers-health-monitor#view_metrics).
- **Check whether the {{site.data.keyword.containershort_notm}} version is up-to-date.** For more information, see [Version information and update actions](/docs/containers?topic=containers-cs_versions).
- **Check whether {{site.data.keyword.containershort_notm}} worker nodes are updated to the latest image to ensure patching of vulnerabilities.** For more information, see [Version information and update actions](/docs/containers?topic=containers-cs_versions).
- **Check whether your {{site.data.keyword.containershort_notm}} cluster has image pull secrets enabled.** For more information, see [Understanding how to authorize your cluster to pull images from a private registry](/docs/containers?topic=containers-registry#cluster_registry_auth).
- **Check whether {{site.data.keyword.containershort_notm}} access is managed only by IAM access groups.** For more information, see the [IAM documentation](/docs/account?topic=account-groups).
- **Check whether {{site.data.keyword.containershort_notm}} has at least # service IDs with the IAM manager role.** Your account administrator configures the number of service IDs in [{{site.data.keyword.compliance_short}}](/docs/security-compliance?topic=security-compliance-custom-goals).
- **Check whether {{site.data.keyword.containershort_notm}} has at least # users with the IAM manager role.** Your account administrator configures the number of users in [{{site.data.keyword.compliance_short}}](/docs/security-compliance?topic=security-compliance-custom-goals).
- **Check whether {{site.data.keyword.containershort_notm}} has no more than # service IDs with the IAM administrator role.** Your account administrator configures the number of service IDs in [{{site.data.keyword.compliance_short}}](/docs/security-compliance?topic=security-compliance-custom-goals).
- **Check whether {{site.data.keyword.containershort_notm}} has no more than # users with the IAM administrator role.** Your account administrator configures the number of service IDs in [{{site.data.keyword.compliance_short}}](/docs/security-compliance?topic=security-compliance-custom-goals).
- **Check whether {{site.data.keyword.containershort_notm}} is configured with role-based access control (RBAC).** [{{site.data.keyword.cloud_notm}} IAM service access roles for **Kubernetes Service**](/docs/containers?topic=containers-iam-service-access-roles) are automatically synchronized with RBAC roles in the cluster. You can also [customize RBAC](/docs/containers?topic=containers-access-overview).





