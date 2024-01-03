---

copyright: 
  years: 2014, 2024
lastupdated: "2024-01-03"


keywords: kubernetes, registry, pull secret, secrets

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# Building containers from images
{: #images}

A Docker image is the basis for every container that you create with {{site.data.keyword.containerlong}}.
{: shortdesc}

An image is created from a Dockerfile, which is a file that contains instructions to build the image. A Dockerfile might reference build artifacts in its instructions that are stored separately, such as an app, the app's configuration, and its dependencies.

## Deploying containers from an {{site.data.keyword.registrylong_notm}} image to the `default` Kubernetes namespace
{: #namespace}

You can deploy containers to your cluster from an IBM-provided public image or a private image that is stored in your {{site.data.keyword.registrylong_notm}} namespace. For more information about how your cluster accesses registry images, see [Understanding how your cluster is authorized to pull images from {{site.data.keyword.registrylong_notm}}](/docs/containers?topic=containers-registry#cluster_registry_auth).
{: shortdesc}

Before you begin:
1. [Set up a namespace in {{site.data.keyword.registrylong_notm}} and push images to this namespace](/docs/Registry?topic=Registry-getting-started#gs_registry_namespace_add).
2. [Create a cluster](/docs/containers?topic=containers-clusters).
3. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Create a deployment configuration file that is named `<deployment>.yaml`.
2. Define the deployment and the image to use from your namespace in {{site.data.keyword.registrylong_notm}}.

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: <deployment>
    spec:
      replicas: <number_of_replicas>
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - name: <app_name>
            image: <region>.icr.io/<namespace>/<image>:<tag>
    ```
    {: codeblock}


    `<deployment>`
    :   Give your deployment a name.
    
    `<number_of_replicas>`
    :   Enter the number of replica pods that the deployment creates.
    
    `app: <app_name>`
    :   Use the name of your app as a label for the container.
    
    `name: <app_name>`
    :   Give your container a name, such as the name of your `app` label.
    
    `image: <region>.icr.io/namespace>/image>:tag>`
    :   Replace the image URL variables with the information for your image:
    :   `region>`: The regional {{site.data.keyword.registrylong_notm}} API endpoint for the registry domain. To list the domain for the region that you are logged in to, run `ibmcloud cr api`.
    :   `namespace>`: The registry namespace. To get your namespace information, run `ibmcloud cr namespace-list`.
    :   `image>:tag>`: The image and tag that you want to use for your container. To list the images that are available in your registry namespace, run `ibmcloud cr images`.


3. Create the deployment in your cluster.

    ```sh
    kubectl apply -f <deployment>.yaml
    ```
    {: pre}



## Referring to the image pull secret in your pod deployment
{: #pod_imagePullSecret}

If the cluster administrator did not [store the image pull secret in the Kubernetes service account](/docs/containers?topic=containers-registry#use_imagePullSecret), all deployments that don't specify a service account can't use the image pull secret to deploy containers. Instead, you can define an image pull secret in your pod deployment. When you refer to the image pull secret in a pod deployment, the image pull secret is valid for this pod only and can't be shared across pods in the Kubernetes namespace.
{: shortdesc}

Before you begin
- [Create an image pull secret](/docs/containers?topic=containers-registry#other) to access images in other registries or Kubernetes namespaces other than `default`.
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

To refer to the image pull secret in your pod deployment,

1. Create a pod configuration file that is named `mypod.yaml`.
2. Define the pod and the image pull secret to access images in {{site.data.keyword.registrylong_notm}}.

    To access a private image,
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: mypod
    spec:
      containers:
        - name: <container_name>
          image: <region>.icr.io/<namespace_name>/<image_name>:<tag>
      imagePullSecrets:
        - name: <secret_name>
    ```
    {: codeblock}

    To access an {{site.data.keyword.cloud_notm}} public image,
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: mypod
    spec:
      containers:
        - name: <container_name>
          image: icr.io/<image_name>:<tag>
      imagePullSecrets:
        - name: <secret_name>
    ```
    {: codeblock}


    `container_name>`
    :   The name of the container to deploy to your cluster.
    `namespace_name>`
    :   The registry namespace where the image is stored. To list available namespaces, run `ibmcloud cr namespace-list`.
    `image_name>`
    :   The name of the image to use. To list available images in an {{site.data.keyword.cloud_notm}} account, run `ibmcloud cr image-list`.
    `tag>`
    :   The version of the image that you want to use. If no tag is specified, the image that is tagged **latest** is used by default.
    `<secret_name>`
    :   The name of the image pull secret that you created earlier.

3. Save your changes.
4. Create the deployment in your cluster.

    ```sh
    kubectl apply -f mypod.yaml
    ```
    {: pre}



## Pushing images to {{site.data.keyword.registrylong_notm}}
{: #push-images}

After the cluster administrator [sets up an image registry with {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=Registry-getting-started#getting-started), you can securely store and share Docker images with other users by adding images to your namespace.
{: shortdesc}

For example, you might pull an image from any private or public registry source, and then tag it for later use in {{site.data.keyword.registrylong_notm}}. Or, you might push a Docker image that you work with to your namespace so that other users can access the image. To get started, see [Adding images to your namespace](/docs/Registry?topic=Registry-registry_images_).



## Managing security of images in {{site.data.keyword.registrylong_notm}} with Vulnerability Advisor
{: #va-images}

Vulnerability Advisor checks the security status of container images that are provided by IBM, third parties, or added to your organization's {{site.data.keyword.registrylong_notm}} namespace.
{: shortdesc}

When you add an image to a namespace, the image is automatically scanned by Vulnerability Advisor to detect security issues and potential vulnerabilities. If security issues are found, instructions are provided to help fix the reported vulnerability. To get started, see [Managing image security with Vulnerability Advisor](/docs/Registry?topic=Registry-va_index).



## Setting up trusted content for container images
{: #trusted_images}

You can build containers from trusted images that are signed and stored in {{site.data.keyword.registrylong_notm}}, and prevent deployments from unsigned or vulnerable images.
{: shortdesc}

1. [Sign images for trusted content](/docs/Registry?topic=Registry-registry_trustedcontent#registry_trustedcontent). After you set up trust for your images, you can manage trusted content and signers that can push images to your registry.
2. To enforce a policy so that only signed images can be used to build containers in your cluster, [install the open source Portieris project](#portieris-image-sec).
3. Cluster users can deploy apps that are built from trusted images.
    1. [Deploy to the `default` Kubernetes namespace](/docs/containers?topic=containers-images#namespace).
    2. [Deploy to a different Kubernetes namespace, or from a different {{site.data.keyword.cloud_notm}} region or account](/docs/containers?topic=containers-registry#other).



## Enabling image security enforcement in your cluster
{: #portieris-image-sec}

When you enable image security enforcement in your cluster, you install the open-source Portieris Kubernetes project. Then, you can create image policies to prevent pods that don't meet the policies, such as unsigned images, from running in your cluster.
{: shortdesc}

For more information, see the [Portieris documentation](https://github.com/IBM/portieris){: external}.

**Mutated images**: By default, Portieris uses the `MutatingAdmissionWebhook` admission controller to mutate your image to refer to the image by a digest instead of a tag. However, you might have some deployment technology that rejects a mutated image. If so, you can use the [image mutation option](https://github.com/IBM/portieris/blob/main/README.md#image-mutation-option){: external} and [policy](https://github.com/IBM/portieris/blob/main/POLICIES.md#image-mutation-option){: external} to change the default behavior.
{: note}

### Enabling or disabling image security enforcement
{: #portieris-enable}

You can enable or disable image security enforcement for your cluster from the CLI or console. For earlier versions, see the [Portieris documentation](https://github.com/IBM/portieris){: external}.
{: shortdesc}

#### Enabling or disabling image security enforcement with the CLI
{: #portieris-enable-cli}

See the following commands.
- [`ibmcloud ks cluster image-security enable`](/docs/containers?topic=containers-kubernetes-service-cli#cs-image-security-enable)
- [`ibmcloud ks cluster image-security disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs-image-security-disable)

#### Enabling or disabling image security enforcement from the console
{: #portieris-enable-ui}

1. From the [Kubernetes clusters console](https://cloud.ibm.com/kubernetes/clusters){: external}, select your cluster.
2. From the **Overview** tab, in the **Summary** pane, find the **Image security enforcement** field and click **Enable** or **Disable**.

### Default image policies
{: #portieris-default-policies}

When you enable image security enforcement, {{site.data.keyword.containerlong_notm}} automatically creates certain image policies in your cluster. When you disable the feature, the underlying `ClusterImagePolicy` CRD is removed, which removes all the default image policies and any custom images policies that you created.
{: shortdesc}

- Image policies with the name `ibm-signed-image-enforcement` restrict the images that are run in the namespace to {{site.data.keyword.containerlong_notm}} images only. Do not modify these image policies. Any changes that you make are overwritten within a few minutes.
- Other image policies, such as `default` or `default-allow-all`, permit images that are not restricted by another image policy. You can modify these image policies and your changes are preserved, but don't rename the image policy. If you rename the policy, more policies with the default name and settings are created.

To review the image policies in your cluster,

Before you begin

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. List the image policies that apply globally to the cluster. For an example configuration, see the [Portieris policy documentation](https://github.com/IBM/portieris/blob/main/helm/portieris/templates/policies.yaml#L66){: external}.

    ```sh
    kubectl get ClusterImagePolicy
    ```
    {: pre}

2. List the image policies that apply to particular namespaces within the cluster. For an example configuration, see the [Portieris policy documentation](https://github.com/IBM/portieris/blob/main/helm/portieris/templates/policies.yaml#L14){: external}.

    ```sh
    kubectl get ImagePolicy --all-namespaces
    ```
    {: pre}




