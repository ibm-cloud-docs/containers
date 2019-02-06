---

copyright:
  years: 2014, 2019
lastupdated: "2019-02-06"

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



# Protecting sensitive information in your cluster
{: #encryption}

Protect sensitive cluster information to ensure data integrity and to prevent your data from being exposed to unauthorized users.
{: shortdesc}

You can create sensitive data on different levels in your cluster that each require appropriate protection.
- **Cluster-level:** Cluster configuration data is stored in the etcd component of your Kubernetes master. In clusters that run Kubernetes version 1.10 or later, data in etcd is stored on the local disk of the Kubernetes master and is backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. You can choose to enable encryption for your etcd data on the local disk of your Kubernetes master by [enabling {{site.data.keyword.keymanagementservicelong_notm}} encryption](/docs/containers/cs_encrypt.html#encryption) for your cluster. The etcd data for clusters that run an earlier version of Kubernetes is stored on an encrypted disk that is managed by IBM and backed up daily.
- **App-level:** When you deploy your app, do not store confidential information, such as credentials or keys, in the YAML configuration file, configmaps, or scripts. Instead, use [Kubernetes secrets ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/secret/). You can also [encrypt data in Kubernetes secrets](#keyprotect) to prevent unauthorized users from accessing sensitive cluster information.

For more information on securing your cluster, see [Security for {{site.data.keyword.containerlong_notm}}](/docs/containers/cs_secure.html#security).

<img src="images/cs_encrypt_ov.png" width="700" alt="Overview of cluster encryption" style="width:700px; border-style: none"/>

_Figure: Overview of data encryption in a cluster_

1.  **etcd**: etcd is the component of the master that stores the data of your Kubernetes resources, such as object configuration `.yaml` files and secrets. In clusters that run Kubernetes version 1.10 or later, data in etcd is stored on the local disk of the Kubernetes master and is backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. You can choose to enable encryption for your etcd data on the local disk of your Kubernetes master by [enabling {{site.data.keyword.keymanagementservicelong_notm}} encryption](#keyprotect) for your cluster. Etcd data in clusters that run an earlier version of Kubernetes is stored on an encrypted disk that is managed by IBM and backed up daily. When etcd data is sent to a pod, data is encrypted via TLS to ensure data protection and integrity.
2.  **Secondary disk of the worker node**: Your worker node's secondary disk is where the container file system and locally pulled images are stored. The disk is AES 256-bit encrypted with a LUKS encryption key that is unique to the worker node and stored as a secret in etcd, managed by IBM. When you reload or update your worker nodes, the LUKS keys are rotated.
3.  **Storage**: You can choose to store data by [setting up file, block, or object persistent storage](/docs/containers/cs_storage_planning.html#persistent_storage_overview). The IBM Cloud infrastructure (SoftLayer) storage instances save the data on encrypted disks, so your data at rest is encrypted. Further, if you choose object storage, your data in transit is also encrypted.
4.  **{{site.data.keyword.Bluemix_notm}} services**: You can [integrate {{site.data.keyword.Bluemix_notm}} services](/docs/containers/cs_integrations.html#adding_cluster), such as {{site.data.keyword.registryshort_notm}} or {{site.data.keyword.watson}}, with your cluster. The service credentials are stored in a secret that is saved in etcd, that your app can access by mounting the secret as a volume or specifying the secret as an environment variable in [your deployment](/docs/containers/cs_app.html#secret).
5.  **{{site.data.keyword.keymanagementserviceshort}}**: When you [enable {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) in your cluster, a wrapped data encryption key (DEK) is stored in etcd. The DEK encrypts the secrets in your cluster, including service credentials and LUKS key. Because the root key is in your {{site.data.keyword.keymanagementserviceshort}} instance, you control access to your encrypted secrets. The {{site.data.keyword.keymanagementserviceshort}} keys are secured by FIPS 140-2 Level 2 certified cloud-based hardware security modules that protect against the theft of information. For more information on how {{site.data.keyword.keymanagementserviceshort}} encryption works, see [Envelope encryption](/docs/services/key-protect/concepts/envelope-encryption.html#envelope-encryption).

## Understanding when to use secrets
{: #secrets}

Kubernetes secrets are a secure way to store confidential information, such as user names, passwords, or keys. If you need confidential information encrypted, [enable {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) to encrypt the secrets. For more information on what you can store in secrets, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/secret/).
{:shortdesc}

Review the following tasks that require secrets.

### Adding a service to a cluster
{: #secrets_service}

When you bind a service to a cluster, you don't have to create a secret to store your service credentials. A secret is automatically created for you. For more information, see [Adding Cloud Foundry services to clusters](/docs/containers/cs_integrations.html#adding_cluster).
{: shortdesc}

### Encrypting traffic to your apps with TLS secrets
{: #secrets_tls}

The ALB load balances HTTP network traffic to the apps in your cluster. To also load balance incoming HTTPS connections, you can configure the ALB to decrypt the network traffic and forward the decrypted request to the apps that are exposed in your cluster. For more information, see the [Ingress configuration documentation](/docs/containers/cs_ingress.html#public_inside_3).
{: shortdesc}

Additionally, if you have apps that require the HTTPS protocol and need traffic to stay encrypted, you can use one-way or mutual authentication secrets with the `ssl-services` annotation. For more information, see the [Ingress annotations documentation](/docs/containers/cs_annotations.html#ssl-services).

### Accessing your registry with credentials stored in a Kubernetes `imagePullSecret`
{: #imagepullsecret}

When you create a cluster, secrets for your {{site.data.keyword.registrylong}} credentials are automatically created for you in the `default` Kubernetes namespace. However, you must [create your own imagePullSecret for your cluster](/docs/containers/cs_images.html#other) if you want to deploy a container in the following situations.
* From an image in your {{site.data.keyword.registryshort_notm}} registry to a Kubernetes namespace other than `default`.
* From an image in your {{site.data.keyword.registryshort_notm}} registry that is stored in a different {{site.data.keyword.Bluemix_notm}} region or {{site.data.keyword.Bluemix_notm}} account.
* From an image that is stored in an {{site.data.keyword.Bluemix_notm}} Dedicated account.
* From an image that is stored in an external, private registry.

<br />


## Encrypting the Kubernetes master's local disk and secrets by using {{site.data.keyword.keymanagementserviceshort}} (beta)
{: #keyprotect}

You can protect the etcd component in your Kubernetes master and Kubernetes secrets by using [{{site.data.keyword.keymanagementservicefull}} ![External link icon](../icons/launch-glyph.svg "External link icon")](/docs/services/key-protect/index.html#getting-started-with-key-protect) as a Kubernetes [key management service (KMS) provider ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) in your cluster. KMS provider is an alpha feature in Kubernetes for versions 1.10 and 1.11, which makes the {{site.data.keyword.keymanagementserviceshort}} integration a beta release in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

By default, your cluster configuration and Kubernetes secrets are stored in the etcd component of the IBM-managed Kubernetes master. Your worker nodes also have secondary disks that are encrypted by IBM-managed LUKS keys that are stored as secrets in etcd. In clusters that run Kubernetes version 1.10 or later, data in etcd is stored on the local disk of the Kubernetes master and is backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, data in your etcd component on the local disk of your Kubernetes master is not automatically encrypted until you enable {{site.data.keyword.keymanagementserviceshort}} encryption for your cluster. The etcd data for clusters that run an earlier version of Kubernetes is stored on an encrypted disk that is managed by IBM and backed up daily.

When you enable {{site.data.keyword.keymanagementserviceshort}} in your cluster, your own root key is used to encrypt data in etcd, including the LUKS secrets. You get more control over your sensitive data by encrypting the secrets with your root key. Using your own encryption adds an layer of security to your etcd data and Kubernetes secrets and gives you more granular control of who can access sensitive cluster information. If you ever need to irreversibly remove access to etcd or your secrets, you can delete the root key.

If you delete the root key in your {{site.data.keyword.keymanagementserviceshort}} instance, you cannot access or remove the data in etcd or the data from the secrets in your cluster afterward.
{: important}

Before you begin:
* [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).
* Check that your cluster runs Kubernetes version 1.10.8_1524, 1.11.3_1521, or later by running `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` and checking the **Version** field.
* Ensure you have the [**Administrator** {{site.data.keyword.Bluemix_notm}} IAM platform role](/docs/containers/cs_users.html#platform) for the cluster.
* Make sure that the API key that is set for the region that your cluster is in is authorized to use Key Protect. To check the API key owner whose credentials are stored for the region, run `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`.

To enable {{site.data.keyword.keymanagementserviceshort}}, or to update the instance or root key that encrypts secrets in the cluster:

1.  [Create a {{site.data.keyword.keymanagementserviceshort}} instance](/docs/services/key-protect/provision.html#provision).

2.  Get the service instance ID.

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [Create a root key](/docs/services/key-protect/create-root-keys.html#create-root-keys). By default, the root key is created without an expiration date.

    Need to set an expiration date to comply with internal security policies? [Create the root key by using the API](/docs/services/key-protect/create-root-keys.html#api) and include the `expirationDate` parameter. **Important**: Before your root key expires, you must repeat these steps to update your cluster to use a new root key. Otherwise, you cannot unencrypt your secrets.
    {: tip}

4.  Note the [root key **ID**](/docs/services/key-protect/view-keys.html#gui).

5.  Get the [{{site.data.keyword.keymanagementserviceshort}} endpoint](/docs/services/key-protect/regions.html#service-endpoints) of your instance.

6.  Get the name of the cluster for which you want to enable {{site.data.keyword.keymanagementserviceshort}}.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  Enable {{site.data.keyword.keymanagementserviceshort}} in your cluster. Fill in the flags with the information that you previously retrieved.

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

After {{site.data.keyword.keymanagementserviceshort}} is enabled in the cluster, data in `etcd`, existing secrets and new secrets that are created in the cluster are automatically encrypted by using your {{site.data.keyword.keymanagementserviceshort}} root key. You can rotate your key at any time by repeating these steps with a new root key ID.


## Encrypting data by using IBM Cloud Data Shield (Beta)
{: #datashield}

{{site.data.keyword.datashield_short}} is integrated with Intel® Software Guard Extensions (SGX) and Fortanix® technology so that your {{site.data.keyword.Bluemix_notm}} container workload code and data are protected in use. The app code and data run in CPU-hardened enclaves, which are trusted areas of memory on the worker node that protect critical aspects of the app, which helps to keep the code and data confidential and unmodified.
{: shortdesc}

When it comes to protecting your data, encryption is one of the most popular and effective controls. But the data must be encrypted at each step of its lifecycle. Data goes through three phases during its lifecycle: data at rest, data in motion, and data in use. Data at rest and in motion are commonly used to protect data when it is stored and when it is transported. Taking that protection one step further, you can now encrypt data in use.

If you or your company require data sensitivity due to internal policies, government regulations, or industry compliance requirements, this solution might help you to move to the cloud. Example solutions include financial and healthcare institutions, or countries with government policies that require on-premises cloud solutions.

To get started, provision an SGX-enabled bare metal worker cluster with machine type: mb2c.4x32 and check out the [the {{site.data.keyword.datashield_short}} docs](/docs/services/data-shield/index.html#gettingstarted).
