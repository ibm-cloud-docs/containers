---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Protecting sensitive information in your cluster
{: #encryption}

By default, your {{site.data.keyword.containerlong}} cluster uses encrypted disks to store information such as configurations in `etcd` or the container file system that runs on the worker node secondary disks. When you deploy your app, do not store confidential information, such as credentials or keys, in the YAML configuration file or scripts. Instead, use [Kubernetes secrets ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/secret/). You can also encrypt data in Kubernetes secrets to prevent unauthorized users from accessing sensitive cluster information.
{: shortdesc}

For more information on securing your cluster, see [Security for {{site.data.keyword.containerlong_notm}}](cs_secure.html#security).

## Understanding when to use secrets
{: #secrets}

Kubernetes secrets are a secure way to store confidential information, such as user names, passwords, or keys. For more information on what you can store in secrets, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/secret/).
{:shortdesc}

Review the following tasks that require secrets.

### Adding a service to a cluster
{: #secrets_service}

When you bind a service to a cluster, you don't have to create a secret to store your service credentials. A secret is automatically created for you. For more information, see [Adding Cloud Foundry services to clusters](cs_integrations.html#adding_cluster).

### Encrypting traffic to your apps with TLS secrets
{: #secrets_tls}

The ALB load balances HTTP network traffic to the apps in your cluster. To also load balance incoming HTTPS connections, you can configure the ALB to decrypt the network traffic and forward the decrypted request to the apps that are exposed in your cluster. For more information, see the [Ingress configuration documentation](cs_ingress.html#public_inside_3).

Additionally, if you have apps that require the HTTPS protocol and need traffic to stay encrypted, you can use one-way or mutual authentication secrets with the `ssl-services` annotation. For more information, see the [Ingress annotations documentation](cs_annotations.html#ssl-services).

### Accessing your registry with credentials stored in a Kubernetes `imagePullSecret`
{: #imagepullsecret}

When you create a cluster, secrets for your {{site.data.keyword.registrylong}} credentials are automatically created for you in the `default` Kubernetes namespace. However, you must [create your own imagePullSecret for your cluster](cs_images.html#other) if you want to deploy a container in the following situations.
* From an image in your {{site.data.keyword.registryshort_notm}} registry to a Kubernetes namespace other than `default`.
* From an image in your {{site.data.keyword.registryshort_notm}} registry that is stored in a different {{site.data.keyword.Bluemix_notm}} region or {{site.data.keyword.Bluemix_notm}} account.
* From an image that is stored in an {{site.data.keyword.Bluemix_notm}} Dedicated account.
* From an image that is stored in an external, private registry.


