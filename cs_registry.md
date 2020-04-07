---

copyright:
  years: 2014, 2020
lastupdated: "2020-04-07"

keywords: kubernetes, iks, registry, pull secret, secrets

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# Setting up an image registry
{: #registry}

Plan and set up an image registry so that developers can create app containers in {{site.data.keyword.containerlong}} by using Docker images.
{: shortdesc}

## Planning image registries
{: #planning_images}

Images are typically stored in a registry that can either be accessible by the public (public registry) or set up with limited access for a small group of users (private registry).
{:shortdesc}

Public registries, such as Docker Hub, can be used to get started with Docker and Kubernetes to create your first containerized app in a cluster. But when it comes to enterprise applications, use a private registry, like the one provided in {{site.data.keyword.registrylong_notm}} to protect your images from being used and changed by unauthorized users. Private registries must be set up by the cluster admin to ensure that the credentials to access the private registry are available to the cluster users.

You can use multiple registries with {{site.data.keyword.containerlong_notm}} to deploy apps to your cluster.

|Registry|Description|Benefit|
|--------|-----------|-------|
|[{{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=registry-getting-started#getting-started)|With this option, you can set up your own secured Docker image repository in {{site.data.keyword.registrylong_notm}} where you can safely store and share images between cluster users.|<ul><li>Manage access to images in your account.</li><li>Use {{site.data.keyword.IBM_notm}} provided images and sample apps, such as {{site.data.keyword.IBM_notm}} Liberty, as a parent image and add your own app code to it.</li><li>Automatic scanning of images for potential vulnerabilities by Vulnerability Advisor, including OS specific recommendations to fix them.</li></ul>|
|Any other private registry|Connect any existing private registry to your cluster by creating an [image pull secret](https://kubernetes.io/docs/concepts/containers/images/){: external}. The secret is used to securely save your registry URL and credentials in a Kubernetes secret.|<ul><li>Use existing private registries independent of their source (Docker Hub, organization owned registries, or other private Cloud registries).</li></ul>|
|[Public Docker Hub](https://hub.docker.com/){: external}{: #dockerhub}|Use this option to use existing public images from Docker Hub directly in your [Kubernetes deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/){: external} when no Dockerfile changes are needed. <p>**Note:** Keep in mind that this option might not meet your organization's security requirements, like access management, vulnerability scanning, or app privacy.</p>|<ul><li>No additional setup is needed for your cluster.</li><li>Includes a variety of open-source applications.</li></ul>|
{: caption="Public and private image registry options" caption-side="top"}

After you set up an image registry, cluster users can use the images to deploy apps to the cluster.

Learn more about [securing your personal information](/docs/containers?topic=containers-security#pi) when you work with container images.

<br />


## Setting up trusted content for container images
{: #trusted_images}

You can build containers from trusted images that are signed and stored in {{site.data.keyword.registrylong_notm}}, and prevent deployments from unsigned or vulnerable images.
{:shortdesc}

1.  [Sign images for trusted content](/docs/Registry?topic=registry-registry_trustedcontent#registry_trustedcontent). After you set up trust for your images, you can manage trusted content and signers that can push images to your registry.
2.  To enforce a policy that only signed images can be used to build containers in your cluster, [add Container Image Security Enforcement](/docs/Registry?topic=registry-security_enforce#security_enforce).
3.  Cluster users can deploy apps that are built from trusted images.
    1. [Deploy to the `default` Kubernetes namespace](/docs/containers?topic=containers-images#namespace).
    2. [Deploy to a different Kubernetes namespace, or from a different {{site.data.keyword.cloud_notm}} region or account](#other).

<br />


## Understanding how to authorize your cluster to pull images from a private registry
{: #cluster_registry_auth}

To pull images from a registry, your {{site.data.keyword.containerlong_notm}} cluster uses a special type of Kubernetes secret, an `imagePullSecret`. This image pull secret stores the credentials to access a container registry.
{: shortdesc}

The container registry can be:
* A private namespace in your own {{site.data.keyword.registrylong_notm}}.
* A private namespace in {{site.data.keyword.registrylong_notm}} that belongs to a different {{site.data.keyword.cloud_notm}} account.
* Any other private registry such as Docker. 

However, by default, your cluster is set up to pull images from only your account's namespaces in {{site.data.keyword.registrylong_notm}}, and deploy containers from these images to the `default` Kubernetes namespace in your cluster. If you need to pull images in other namespaces of the cluster or from other container registries, then you must set up your own image pull secrets.



**How is my cluster set up to pull images from the `default` Kubernetes namespace?**<br>
When you create a cluster, the cluster has an {{site.data.keyword.cloud_notm}} IAM service ID that is given an IAM **Reader** service access role policy to {{site.data.keyword.registrylong_notm}}. The service ID credentials are impersonated in a non-expiring API key that is stored in image pull secrets in your cluster. The image pull secrets are added to the `default` Kubernetes namespace and the list of secrets in the `default` service account for this Kubernetes namespace. By using image pull secrets, your deployments can pull images (read-only access) from the [global and regional {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=registry-registry_overview#registry_regions) to deploy containers in the `default` Kubernetes namespace.

* The global registry securely stores public images that are provided by IBM. You can refer to these public images across your deployments instead of having different references for images that are stored in each regional registry. 
* The regional registry securely stores your own private Docker images.

**What if I don't have image pull secrets in the `default` Kubernetes namespace?**<br>
You can check the image pull secrets by [logging in to your cluster](/docs/containers?topic=containers-access_cluster) and running `kubectl get secrets -n default | grep "icr-io"`. If no `icr` secrets are listed, the person who created the cluster might not have had the required permissions to {{site.data.keyword.registrylong_notm}} in IAM. See [Updating existing clusters to use the API key image pull secret](#imagePullSecret_migrate_api_key).

**Can I restrict pull access to a certain regional registry?**<br>
Yes, you can [edit the existing IAM policy of the service ID](/docs/iam?topic=iam-serviceidpolicy#access_edit) that restricts the **Reader** service access role to that regional registry or a registry resource such as a namespace. Before you can customize registry IAM policies, you must [enable {{site.data.keyword.cloud_notm}} IAM policies for {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=registry-user#existing_users).

  Want to make your registry credentials even more secured? Ask your cluster admin to [enable a key management service provider](/docs/containers?topic=containers-encryption#keyprotect) in your cluster to encrypt Kubernetes secrets in your cluster, such as the image pull secret that stores your registry credentials.
  {: tip}

**Can I pull images in a Kubernetes namespace other than `default`?**<br>
Not by default. By using the default cluster setup, you can deploy containers from any image that is stored in your {{site.data.keyword.registrylong_notm}} namespace into the `default` Kubernetes namespace of your cluster. To use these images in any other Kubernetes namespaces or other {{site.data.keyword.cloud_notm}} accounts, [you have the option to copy or create your own image pull secrets](#other).

**Can I pull images from a different {{site.data.keyword.cloud_notm}} account?**<br>
Yes, create an API key in the {{site.data.keyword.cloud_notm}} account that you want to use. Then, in each namespace of each cluster that you want to pull images from the {{site.data.keyword.cloud_notm}} account, create a secret that holds the API key. For more information, [follow along with this example that uses an authorized service ID API key](#other_registry_accounts).

To use a non-{{site.data.keyword.cloud_notm}} registry such as Docker, see [Accessing images that are stored in other private registries](#private_images).

**Does the API key need to be for a service ID? What happens if I reach the limit of service IDs for my account?**<br>
The default cluster setup creates a service ID to store {{site.data.keyword.cloud_notm}} IAM API key credentials in the image pull secret. However, you can also create an API key for an individual user and store those credentials in an image pull secret. If you reach the [IAM limit for service IDs](/docs/iam?topic=iam-iam_limits#iam_limits), your cluster is created without the service ID and image pull secret and cannot pull images from the `icr.io` registry domains by default. You must [create your own image pull secret](#other_registry_accounts), but by using an API key for an individual user such as a functional ID, not an {{site.data.keyword.cloud_notm}} IAM service ID.

**My cluster image pull secret uses a registry token. Does a token still work?**<br>

The previous method of authorizing cluster access to {{site.data.keyword.registrylong_notm}} via [tokens](https://www.ibm.com/cloud/blog/announcements/announcing-end-of-ibm-cloud-container-registry-support-for-registry-and-uaa-tokens){: external} is supported but deprecated.
{: deprecated}

Tokens authorize access to the deprecated `registry.bluemix.net` registry domains, whereas API keys authorize access to the `icr.io` registry domains. Existing clusters might have both tokens and API key-based image pull secrets, but new clusters only use API keys. Therefore by default, new clusters can pull images from only `icr.io` domains in the `default` Kubernetes namespace.

Before the deprecated tokens and `registry.bluemix.net` domains become unsupported, update your cluster image pull secrets to use the API key method for the [`default` Kubernetes namespace](#imagePullSecret_migrate_api_key) and [any other namespaces or accounts](#other) you might use. Then, update your deployments to pull from the `icr.io` registry domains.

**After I copy or create an image pull secret in another Kubernetes namespace, am I done?**<br>
Not quite. Your containers must be authorized to pull images by using the secret that you created. You can add the image pull secret to the service account for the namespace, or refer to the secret in each deployment. For instructions, see [Using the image pull secret to deploy containers](#use_imagePullSecret).



<br />


## Updating existing clusters to use the API key image pull secret
{: #imagePullSecret_migrate_api_key}

New {{site.data.keyword.containerlong_notm}} clusters store an API key in [image pull secrets to authorize access to {{site.data.keyword.registrylong_notm}}](#cluster_registry_auth). With these image pull secrets, you can deploy containers from images that are stored in the `icr.io` registry domains. You can add the image pull secrets to your cluster if your cluster was not created with the secrets. For clusters that were created before **25 February 2019**, you must update your cluster to store an API key instead of a registry token in the image pull secret.
{: shortdesc}

**Before you begin**:
*   [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
*   Make sure that you have the following permissions:
    *   {{site.data.keyword.cloud_notm}} IAM **Operator or Administrator** platform role for {{site.data.keyword.containerlong_notm}}. The account owner can give you the role by running:
        ```
        ibmcloud iam user-policy-create <your_user_email> --service-name containers-kubernetes --roles <(Administrator|Operator)>
        ```
        {: pre}
    *   {{site.data.keyword.cloud_notm}} IAM **Administrator** platform role for {{site.data.keyword.registrylong_notm}}, across all regions and resource groups. The policy cannot be scoped to a particular region or resource group. The account owner can give you the role by running:
        ```
        ibmcloud iam user-policy-create <your_user_email> --service-name container-registry --roles Administrator
        ```
        {: pre}

**To update your cluster image pull secret in the `default` Kubernetes namespace**:
1.  Get your cluster ID.
    ```
    ibmcloud ks cluster ls
    ```
    {: pre}
2.  Run the following command to create a service ID for the cluster and assign the service ID an IAM **Reader** service role for {{site.data.keyword.registrylong_notm}}. The command also creates an API key to impersonate the service ID credentials and stores the API key in a Kubernetes image pull secret in the cluster. The image pull secret is in the `default` Kubernetes namespace.
    ```
    ibmcloud ks cluster pull-secret apply --cluster <cluster_name_or_ID>
    ```
    {: pre}

    When you run this command, the creation of IAM credentials and image pull secrets is initiated and can take some time to complete. You cannot deploy containers that pull an image from the {{site.data.keyword.registrylong_notm}} `icr.io` domains until the image pull secrets are created.
    {: important}

3.  Verify that the image pull secrets are created in your cluster. Note that you have a separate image pull secret for each {{site.data.keyword.registrylong_notm}} region.
    ```
    kubectl get secrets | grep icr-io
    ```
    {: pre}
    Example output:
    ```
    default-us-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-uk-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-de-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-au-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-jp-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-icr-io                             kubernetes.io/dockerconfigjson        1         16d
    ```
    {: screen}
4.  Update your [container deployments](/docs/containers?topic=containers-app#image) to pull images from the `icr.io` domain name.
5.  Optional: If you have a firewall, make sure you [allow outbound network traffic to the registry subnets](/docs/containers?topic=containers-firewall#firewall_outbound) for the domains that you use.

**What's next?**
*   To pull images in Kubernetes namespaces other than `default` or from other {{site.data.keyword.cloud_notm}} accounts, [copy or create another image pull secret](#other).
*   To restrict the image pull secret access to particular registry resources such as namespaces or regions:
    1.  Make sure that [{{site.data.keyword.cloud_notm}} IAM policies for {{site.data.keyword.registrylong_notm}} are enabled](/docs/Registry?topic=registry-user#existing_users).
    2.  [Edit the {{site.data.keyword.cloud_notm}} IAM policies](/docs/iam?topic=iam-serviceidpolicy#access_edit) for the service ID, or [create another image pull secret](#other_registry_accounts).

<br />


## Using an image pull secret to access images in other {{site.data.keyword.cloud_notm}} accounts or external private registries from non-default Kubernetes namespaces
{: #other}

Set up your own image pull secret in your cluster to deploy containers to Kubernetes namespaces other than `default`, use images that are stored in other {{site.data.keyword.cloud_notm}} accounts, or use images that are stored in external private registries. Further, you might create your own image pull secret to apply IAM access policies that restrict permissions to specific registry image namespaces, or actions (such as `push` or `pull`).
{:shortdesc}

After you create the image pull secret, your containers must use the secret to be authorized to pull an image from the registry. You can add the image pull secret to the service account for the namespace, or refer to the secret in each deployment. For instructions, see [Using the image pull secret to deploy containers](#use_imagePullSecret).

Image pull secrets are valid only for the Kubernetes namespaces that they were created for. Repeat these steps for every namespace where you want to deploy containers. Images from [DockerHub](#dockerhub) do not require image pull secrets.
{: tip}

Before you begin:

1.  [Set up a namespace in {{site.data.keyword.registrylong_notm}} and push images to this namespace](/docs/Registry?topic=registry-getting-started#gs_registry_namespace_add).
2.  [Create a Kubernetes cluster](/docs/containers?topic=containers-clusters).
3.  [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

<br/>
To use your own image pull secret, choose among the following options:
- [Copy the image pull secret](#copy_imagePullSecret) from the default Kubernetes namespace to other namespaces in your cluster.
- [Create new IAM API key credentials and store them in an image pull secret](#other_registry_accounts) to access images in other {{site.data.keyword.cloud_notm}} accounts or to apply IAM policies that restrict access to certain registry domains or namespaces.
- [Create an image pull secret to access images in external private registries](#private_images).

<br/>
If you already created an image pull secret in your namespace that you want to use in your deployment, see [Deploying containers by using the created `imagePullSecret`](#use_imagePullSecret).

### Copying an existing image pull secret
{: #copy_imagePullSecret}

You can copy an image pull secret, such as the one that is automatically created for the `default` Kubernetes namespace, to other namespaces in your cluster. If you want to use different {{site.data.keyword.cloud_notm}} IAM API key credentials for this namespace such as to restrict access to specific namespaces, or to pull images from other {{site.data.keyword.cloud_notm}} accounts, [create an image pull secret](#other_registry_accounts) instead.
{: shortdesc}

1.  List available Kubernetes namespaces in your cluster, or create a namespace to use.
    ```
    kubectl get namespaces
    ```
    {: pre}

    Example output:
    ```
    default          Active    79d
    ibm-cert-store   Active    79d
    ibm-system       Active    79d
    kube-public      Active    79d
    kube-system      Active    79d
    ```
    {: screen}

    To create a namespace:
    ```
    kubectl create namespace <namespace_name>
    ```
    {: pre}
2.  List the existing image pull secrets in the `default` Kubernetes namespace for {{site.data.keyword.registrylong_notm}}.
    ```
    kubectl get secrets -n default | grep icr-io
    ```
    {: pre}
    Example output:
    ```
    default-us-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-uk-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-de-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-au-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-jp-icr-io                          kubernetes.io/dockerconfigjson        1         16d
    default-icr-io                             kubernetes.io/dockerconfigjson        1         16d
    ```
    {: screen}
3.  Copy each image pull secret from the `default` namespace to the namespace of your choice. The new image pull secrets are named `<namespace_name>-icr-<region>-io`. If you pull images from only a certain region, you can copy only that region's image pull secret.
    ```
    kubectl get secret default-us-icr-io -n default -o yaml | sed 's/default/<new-namespace>/g' | kubectl create -n <new-namespace> -f -   
    ```
    {: pre}
    ```
    kubectl get secret default-uk-icr-io -n default -o yaml | sed 's/default/<new-namespace>/g' | kubectl create -n <new-namespace> -f -
    ```
    {: pre}
    ```
    kubectl get secret default-de-icr-io -n default -o yaml | sed 's/default/<new-namespace>/g' | kubectl create -n <new-namespace> -f -
    ```
    {: pre}
    ```
    kubectl get secret default-au-icr-io -n default -o yaml | sed 's/default/<new-namespace>/g' | kubectl create -n <new-namespace> -f -
    ```
    {: pre}
    ```
    kubectl get secret default-jp-icr-io -n default -o yaml | sed 's/default/<new-namespace>/g' | kubectl create -n <new-namespace> -f -
    ```
    {: pre}
    ```
    kubectl get secret default-icr-io -n default -o yaml | sed 's/default/<new-namespace>/g' | kubectl create -n <new-namespace> -f -
    ```
    {: pre}
4.  Verify that the secrets are created successfully.
    ```
    kubectl get secrets -n <namespace_name> | grep icr-io
    ```
    {: pre}
5.  To deploy containers, [add the image pull secret](#use_imagePullSecret) to each deployment or to the service account of the namespace so that any deployment in the namespace can pull images from the registry.

### Creating an image pull secret with different IAM API key credentials for more control or access to images in other {{site.data.keyword.cloud_notm}} accounts
{: #other_registry_accounts}

You can assign {{site.data.keyword.cloud_notm}} IAM access policies to users or a service ID to restrict permissions to specific registry image namespaces or actions (such as `push` or `pull`). Then, create an API key and store these registry credentials in an image pull secret for your cluster.
{: shortdesc}

For example, to access images in other {{site.data.keyword.cloud_notm}} accounts, create an API key that stores the {{site.data.keyword.registrylong_notm}} credentials of a user or service ID in that account. Then, in your cluster's account, save the API key credentials in an image pull secret for each cluster and cluster namespace.

The following steps create an API key that stores the credentials of an {{site.data.keyword.cloud_notm}} IAM service ID. Instead of using a service ID, you might want to create an API key for a user ID that has an {{site.data.keyword.cloud_notm}} IAM service access policy to {{site.data.keyword.registrylong_notm}}. However, make sure that the user is a functional ID or have a plan in case the user leaves so that the cluster can still access the registry.
{: note}

1.  List available Kubernetes namespaces in your cluster, or create a namespace to use where you want to deploy containers from your registry images.
    ```
    kubectl get namespaces
    ```
    {: pre}

    Example output:
    ```
    default          Active    79d
    ibm-cert-store   Active    79d
    ibm-system       Active    79d
    kube-public      Active    79d
    kube-system      Active    79d
    ```
    {: screen}

    To create a namespace:
    ```
    kubectl create namespace <namespace_name>
    ```
    {: pre}
2.  Create an {{site.data.keyword.cloud_notm}} IAM service ID for your cluster that is used for the IAM policies and API key credentials in the image pull secret. Be sure to give the service ID a description that helps you retrieve the service ID later, such as including both the cluster and namespace name.
    ```
    ibmcloud iam service-id-create <cluster_name>-<namespace>-id --description "Service ID for IBM Cloud Container Registry in Kubernetes cluster <cluster_name> namespace <namespace>"
    ```
    {: pre}
3.  Create a custom {{site.data.keyword.cloud_notm}} IAM policy for your cluster service ID that grants access to {{site.data.keyword.registrylong_notm}}.
    ```
    ibmcloud iam service-policy-create <cluster_service_ID> --roles <service_access_role> --service-name container-registry [--region <IAM_region>] [--resource-type namespace --resource <registry_namespace>]
    ```
    {: pre}
    <table>
    <caption>Understanding this command's components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>&lt;cluster_service_ID&gt;</em></code></td>
    <td>Required. Replace with the `<cluster_name>-<kube_namespace>-id` service ID that you previously created for your Kubernetes cluster.</td>
    </tr>
    <tr>
    <td><code>--service-name <em>container-registry</em></code></td>
    <td>Required. Enter `container-registry` so that the IAM policy is for {{site.data.keyword.registrylong_notm}}.</td>
    </tr>
    <tr>
    <td><code>--roles <em>&lt;service_access_role&gt;</em></code></td>
    <td>Required. Enter the [service access role for {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=registry-iam#service_access_roles) that you want to scope the service ID access to. Possible values are `Reader`, `Writer`, and `Manager`.</td>
    </tr>
    <tr>
    <td><code>--region <em>&lt;IAM_region&gt;</em></code></td>
    <td>Optional. If you want to scope the access policy to certain IAM regions, enter the regions in a comma-separated list. Possible values are `global` and the [local registry regions](/docs/Registry?topic=registry-registry_overview#registry_regions_local).</td>
    </tr>
    <tr>
    <td><code>--resource-type <em>namespace</em> --resource <em>&lt;registry_namespace&gt;</em></code></td>
    <td>Optional. If you want to limit access to only images in certain [{{site.data.keyword.registrylong_notm}} namespaces](/docs/Registry?topic=registry-registry_setup_cli_namespace#registry_setup_cli_namespace_plan), enter `namespace` for the resource type and specify the `<registry_namespace>`. To list registry namespaces, run `ibmcloud cr namespaces`.</td>
    </tr>
    </tbody></table>
4.  Create an API key for the service ID. Name the API key similar to your service ID, and include the service ID that you previously created, ``<cluster_name>-<kube_namespace>-id`. Be sure to give the API key a description that helps you retrieve the key later.
    ```
    ibmcloud iam service-api-key-create <cluster_name>-<namespace>-key <cluster_name>-<namespace>-id --description "API key for service ID <service_id> in Kubernetes cluster <cluster_name> namespace <namespace>"
    ```
    {: pre}
5.  Retrieve your **API Key** value from the output of the previous command.
    ```
    Please preserve the API key! It cannot be retrieved after it's created.

    Name          <cluster_name>-<kube_namespace>-key   
    Description   key_for_registry_for_serviceid_for_kubernetes_cluster_multizone_namespace_test   
    Bound To      crn:v1:bluemix:public:iam-identity::a/1bb222bb2b33333ddd3d3333ee4ee444::serviceid:ServiceId-ff55555f-5fff-6666-g6g6-777777h7h7hh   
    Created At    2019-02-01T19:06+0000   
    API Key       i-8i88ii8jjjj9jjj99kkkkkkkkk_k9-llllll11mmm1   
    Locked        false   
    UUID          ApiKey-222nn2n2-o3o3-3o3o-4p44-oo444o44o4o4   
    ```
    {: screen}
6.  Create an image pull secret to store the API key credentials in the cluster namespace. Repeat this step for each namespace of each cluster for each `icr.io` domain that you want to pull images from.
    ```
    kubectl --namespace <namespace> create secret docker-registry <secret_name> --docker-server=<registry_URL> --docker-username=iamapikey --docker-password=<api_key_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Understanding this command's components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;namespace&gt;</em></code></td>
    <td>Required. Specify the Kubernetes namespace of your cluster that you used for the service ID name.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Required. Enter a name for your image pull secret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_URL&gt;</em></code></td>
    <td>Required. Set the URL to the image registry where your registry namespace is set up. For available domains, see [Local regions](/docs/Registry?topic=registry-registry_overview#registry_regions).</td>
    </tr>
    <tr>
    <td><code>--docker-username iamapikey</code></td>
    <td>Required. Enter the username to log in to your private registry. For {{site.data.keyword.registrylong_notm}}, the username is set to the value <strong><code>iamapikey</code></strong>.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Required. Enter the value of your **API Key** that you previously retrieved.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Required. If you have one, enter your Docker email address. If you do not, enter a fictional email address, such as `a@b.c`. This email is required to create a Kubernetes secret, but is not used after creation.</td>
    </tr>
    </tbody></table>
7.  Verify that the secret was created successfully. Replace <em>&lt;namespace&gt;</em> with the namespace where you created the image pull secret.

    ```
    kubectl get secrets --namespace <namespace>
    ```
    {: pre}
8.  [Add the image pull secret to a Kubernetes service account so that any pod in the namespace can use the image pull secret when you deploy a container](#use_imagePullSecret).

### Accessing images that are stored in other private registries
{: #private_images}

If you already have a private registry, you must store the registry credentials in a Kubernetes image pull secret and reference this secret from your configuration file.
{:shortdesc}

Before you begin:

1.  [Create a Kubernetes cluster](/docs/containers?topic=containers-clusters).
2.  [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To create an image pull secret:

1.  Create the Kubernetes secret to store your private registry credentials.

    ```
    kubectl --namespace <namespace> create secret docker-registry <secret_name>  --docker-server=<registry_URL> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Understanding this command's components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;namespace&gt;</em></code></td>
    <td>Required. The Kubernetes namespace of your cluster where you want to use the secret and deploy containers to. To list available namespaces in your cluster, run <code>kubectl get namespaces</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Required. The name that you want to use for your image pull secret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_URL&gt;</em></code></td>
    <td>Required. The URL to the registry where your private images are stored.</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Required. The username to log in to your private registry.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Required. The password to log in to your private registry, such as a token value.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Required. If you have one, enter your Docker email address. If you do not have one, enter a fictional email address, such as `a@b.c`. This email is required to create a Kubernetes secret, but is not used after creation.</td>
    </tr>
    </tbody></table>

2.  Verify that the secret was created successfully. Replace <em>&lt;namespace&gt;</em> with the name of the namespace where you created the image pull secret.

    ```
    kubectl get secrets --namespace <namespace>
    ```
    {: pre}

3.  [Create a pod that references the image pull secret](#use_imagePullSecret).

<br />


## Using the image pull secret to deploy containers
{: #use_imagePullSecret}

You can define an image pull secret in your pod deployment or store the image pull secret in your Kubernetes service account so that it is available for all deployments that do not specify a Kubernetes service account in the namespace.
{: shortdesc}

To plan how image pull secrets are used in your cluster, choose between the following options:
* Referring to the image pull secret in your pod deployment: Use this option if you do not want to grant access to your registry for all pods in your namespace by default. Developers can [include the image pull secret in each pod deployment](/docs/containers?topic=containers-images#pod_imagePullSecret) that must access your registry.
* Storing the image pull secret in the Kubernetes service account: Use this option to grant access to images in your registry for all deployments in the selected Kubernetes namespaces. To store an image pull secret in the Kubernetes service account, use the [following steps](#store_imagePullSecret).

### Storing the image pull secret in the Kubernetes service account for the selected namespace
{:#store_imagePullSecret}

Every Kubernetes namespace has a Kubernetes service account that is named `default`. Within the namespace, you can add the image pull secret to this service account to grant access for pods to pull images from your registry. Deployments that do not specify a service account automatically use the `default` service account for this Kubernetes namespace.
{:shortdesc}

1. Check if an image pull secret already exists for your default service account.
   ```
   kubectl describe serviceaccount default -n <namespace_name>
   ```
   {: pre}
   When `<none>` is displayed in the **Image pull secrets** entry, no image pull secret exists.
2. Add the image pull secret to your default service account.
   - **To add the image pull secret when no image pull secret is defined:**
       ```
       kubectl patch -n <namespace_name> serviceaccount/default -p '{"imagePullSecrets":[{"name": "<image_pull_secret_name>"}]}'
       ```
       {: pre}
   - **To add the image pull secret when an image pull secret is already defined:**
       ```
       kubectl patch -n <namespace_name> serviceaccount/default --type='json' -p='[{"op":"add","path":"/imagePullSecrets/-","value":{"name":"<image_pull_secret_name>"}}]'
       ```
       {: pre}
3. Verify that your image pull secret was added to your default service account.
   ```
   kubectl describe serviceaccount default -n <namespace_name>
   ```
   {: pre}

   Example output:
   ```
   Name:                default
   Namespace:           <namespace_name>
   Labels:              <none>
   Annotations:         <none>
   Image pull secrets:  <image_pull_secret_name>
   Mountable secrets:   default-token-sh2dx
   Tokens:              default-token-sh2dx
   Events:              <none>
   ```
   {: pre}

   If the **Image pull secrets** says `<secret> (not found)`, verify that the image pull secret exists in the same namespace as your service account by running `kubectl get secrets -n namespace`.

4. Create a pod configuration file that is named `mypod.yaml` to deploy a container from an **image** in your registry.
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: mypod
   spec:
     containers:
       - name: mypod-container
         image: <region>.icr.io/<namespace>/<image>:<tag>
   ```
   {: codeblock}

5. Create the pod in the cluster by applying the `mypod.yaml` configuration file.
   ```
   kubectl apply -f mypod.yaml
   ```
   {: pre}

<br />


## Setting up a cluster to pull entitled software
{: #secret_entitled_software}

You can set up your {{site.data.keyword.containerlong_notm}} cluster to pull entitled software, which is a collection of protected container images that are packaged in Helm charts that you are licensed to use by IBM. Entitled software is stored in a special {{site.data.keyword.registrylong_notm}} `cp.icr.io` domain. To access this domain, you must create an image pull secret with an entitlement key for your cluster and add this image pull secret to the Kubernetes service account of each namespace where you want to deploy this entitled software.
{: shortdesc}

Do you have older entitled software from Passport Advantage? Use the [PPA importer tool](/docs/containers?topic=containers-hybrid_iks_icp#hybrid_ppa_importer) instead to deploy this software in your cluster.
{: tip}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Get the entitlement key for your entitled software library.
    1.  Log in to [MyIBM.com](https://myibm.ibm.com){: external} and scroll to the **Container software library** section. Click **View library**.
    2.  From the **Access your container software > Entitlement keys** page, click **Copy key**. This key authorizes access to all the entitled software in your container software library.
2.  In the namespace that you want to deploy your entitled containers, create an image pull secret so that you can access the `cp.icr.io` entitled registry. Use the **entitlement key** that you previously retrieved as the `--docker-password` value. For more information, see [Accessing images that are stored in other private registries](#private_images).
    ```
    kubectl create secret docker-registry entitled-cp-icr-io --docker-server=cp.icr.io --docker-username=cp --docker-password=<entitlement_key> --docker-email=<docker_email> -n <namespace>
    ```
    {: pre}
3.  Add the image pull secret to the service account of the namespace so that any container in the namespace can use the entitlement key to pull entitled images. For more information, see [Using the image pull secret to deploy containers](#use_imagePullSecret).
    ```
    kubectl patch -n <namespace> serviceaccount/default --type='json' -p='[{"op":"add","path":"/imagePullSecrets/-","value":{"name":"entitled-cp-icr-io"}}]'
    ```
    {: pre}
4.  Create a pod in the namespace that builds a container from an image in the entitled registry.
    ```
    kubectl run <pod_name> --image=cp.icr.io/<image_name> -n <namespace> --generator=run-pod/v1
    ```
    {: pre}
5.  Check that your container was able to successfully build from the entitled image by verifying that the pod is in a **Running** status.
    ```
    kubectl get pod <pod_name> -n <namespace>
    ```
    {: pre}

Wondering what to do next? You can [set up the **entitled** Helm chart repository](/docs/containers?topic=containers-helm), where Helm charts that incorporate entitled software are stored. If you already have Helm installed in your cluster, run `helm repo add entitled https://raw.githubusercontent.com/IBM/charts/master/repo/entitled`.
{: tip}

