---

copyright:
  years: 2022, 2022
lastupdated: "2022-09-21"

keywords: certificate manager, certificates, secrets, migration

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Migrating from {{site.data.keyword.cloudcerts_long_notm}} to {{site.data.keyword.secrets-manager_full_notm}}
{: #certs-mgr-migration}

With the deprecation of {{site.data.keyword.cloudcerts_long}}, you can now manage certificates with {{site.data.keyword.secrets-manager_short}}. For a comparison between the two services and details on migrating your resources, see [Migrating certificates from Certificate Manager](/docs/secrets-manager?topic=secrets-manager-migrate-from-certificate-manager#migrate-process). For migration instructions, see [Migration guidelines](/docs/secrets-manager?topic=secrets-manager-migrate-from-certificate-manager#migrate-guidelines).
{: shortdesc}

Support for the {{site.data.keyword.cloudcerts_short}} in Kubernetes clusters is set to end in late 2022, and any remaining {{site.data.keyword.cloudcerts_short}} instances are set to be deleted on 31 Dec 2022. Secrets in deleted {{site.data.keyword.cloudcerts_short}} are written directly to the cluster. If you do not migrate your secrets and set a default {{site.data.keyword.secrets-manager_short}}, your secrets are written only to the cluster and not to any manager instance.
{: note}

## Migration FAQ
{: #certs-mgr_migration_faq}

Keep the following points in mind when migrating from {{site.data.keyword.cloudcerts_short}} to {{site.data.keyword.secrets-manager_short}}.
{: shortdesc}

What functionality can I gain with {{site.data.keyword.secrets-manager_short}}?
:   With {{site.data.keyword.secrets-manager_short}}, you can:
    - Create managed Kubernetes secrets with Ingress TLS certificates included.
    - Create Kubernetes secrets of any type by using the CRN of any {{site.data.keyword.secrets-manager_short}} instance you own.
    - Automatically update your secrets in your cluster on a regular basis.
    - Track the experation dates of your certificates from the {{site.data.keyword.cloud_notm}} console.
    - Control who has access to your secrets by creating secret groups for approved users.

Are secrets that are stored in a registered {{site.data.keyword.secrets-manager_short}} instance automatically updated?
:   Yes. Secrets that are stored in a registered {{site.data.keyword.secrets-manager_short}} instance are automatically updated once a day using the value of the secret from the corresponding CRN.

Are my secrets automatically updated if I do not create and register a {{site.data.keyword.secrets-manager_short}} instance?
:    If you do not have a {{site.data.keyword.secrets-manager_short}} instance registered to your cluster, your default Ingress secrets continue to update automatically every 90 days and are applied to your cluster. However, any secrets you created that *reference* the default Ingress secret are not automatically updated. 
:    **Example scenario**: You have a default Ingress certificate in the `default` namespace. You run the **`ibmcloud ks ingress secret create`** command and reference the CRN of the default Ingress certificate to mirror the certificate in the `istio-system` namespace. Without a {{site.data.keyword.secrets-manager_short}} instance, the default Ingress certificate in the `default` namespace automatically updates. However, you are responsible for regularly updating the certificate in the `istio-system` namespace with the **`ibmcloud ks ingress secret update`** command. 

I created secrets that reference a default Ingress certificate, but I have not created and registered a {{site.data.keyword.secrets-manager_short}} instance and have not migrated my secrets from {{site.data.keyword.cloudcerts_short}}. Can I still manually update these secrets with the **`ibmcloud ks ingress secret`** commands?
:   Yes. The `ibmcloud ks ingress secret` commands support secrets with {{site.data.keyword.cloudcerts_long_notm}} CRNs until 31 December 2022.


## Timeline for {{site.data.keyword.cloudcerts_short}} end of support
{: #certs-mgr_timeline}

Review the list of important dates regarding {{site.data.keyword.cloudcerts_short}} end of support.
{: shortdesc}

The following information is provided for general awareness only. Dates that are marked with a dagger (`†`) are tentative and subject to change. This timeline and the details regarding the {{site.data.keyword.cloudcerts_short}} end of support are tentative and subject to change. 
{: important}

23 September 2022`†` 
:   {{site.data.keyword.cloudcerts_short}} instances are no longer automatically provisioned in new clusters.

24 October 2022`†`
:   CRNs that reference secrets stored in {{site.data.keyword.cloudcerts_short}} end of support are no longer used to update secrets in the cluster.

31 December 2022`†`
:   {{site.data.keyword.cloudcerts_short}} becomes fully unsupported.
:   Any remaining {{site.data.keyword.cloudcerts_short}} instances are deleted.
:   Secrets in deleted {{site.data.keyword.cloudcerts_short}} are written directly to the cluster. If you do not migrate your secrets and set a default {{site.data.keyword.secrets-manager_short}}, your secrets are written only to the cluster and not to any manager instance.
:   `ibmcloud ks ingress secret` commands no longer support CRNs that reference secrets stored in {{site.data.keyword.cloudcerts_short}}.
