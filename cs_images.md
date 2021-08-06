---

copyright:
  years: 2014, 2021
lastupdated: "2021-08-06"

keywords: kubernetes, iks, registry, pull secret, secrets

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:api: .ph data-hd-interface='api'}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:audio: .audio}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: .ph data-hd-programlang='c#'}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: #curl .ph data-hd-programlang='curl'}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: .external target="_blank"}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: #java .ph data-hd-programlang='java'}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:middle: .ph data-hd-position='middle'}
{:navgroup: .navgroup}
{:new_window: target="_blank"}
{:node: .ph data-hd-programlang='node'}
{:note: .note}
{:note:.deprecated}
{:objectc: .ph data-hd-programlang='Objective C'}
{:objectc: data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: .ph data-hd-programlang='PHP'}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:right: .ph data-hd-position='right'}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:step: data-tutorial-type='step'} 
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: #swift .ph data-hd-programlang='swift'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:terraform: .ph data-hd-interface='terraform'}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:topicgroup: .topicgroup}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vbnet: .ph data-hd-programlang='vb.net'}
{:video: .video}
  
  

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
2. [Create a Kubernetes cluster](/docs/containers?topic=containers-clusters).
3. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To deploy a container into the **default** namespace of your cluster:

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

    <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
    <caption>Understanding the YAML file components</caption>
    <col width="20%">
    <thead>
    <th>Parameter</th>
    <th>Description</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>&lt;deployment&gt;</em></code></td>
    <td>Give your deployment a name.</td>
    </tr>
    <tr>
    <td><code><em>&lt;number_of_replicas&gt;</em></code></td>
    <td>Enter the number of replica pods that the deployment creates.</td>
    </tr>
    <tr>
    <td><code>app: <em>&lt;app_name&gt;</em></code></td>
    <td>Use the name of your app as a label for the container.</td>
    </tr>
    <tr>
    <td><code>name: <em>&lt;app_name&gt;</em></code></td>
    <td>Give your container a name, such as the name of your `app` label.</td>
    </tr>
    <tr>
    <td><code>image: <em>&lt;region&gt;</em>.icr.io/<em>&lt;namespace&gt;</em>/<em>&lt;image&gt;</em>:<em>&lt;tag&gt;</em></code></td>
    <td>Replace the image URL variables with the information for your image:
        <ul><li><strong><code><region></code></strong>: The regional {{site.data.keyword.registrylong_notm}} API endpoint for the registry domain. To list the domain for the region that you are logged in to, run <code>ibmcloud cr api</code>.</li>
        <li><strong><code><namespace></code></strong>: The registry namespace. To get your namespace information, run `ibmcloud cr namespace-list`.</li>
        <li><strong><code><image>:<tag></code></strong>: The image and tag that you want to use for your container. To list the images that are available in your registry namespace, run <code>ibmcloud cr images</code>.</li></ul></td>
    </tr>
    </tbody></table>

3. Create the deployment in your cluster.

    ```
    kubectl apply -f <deployment>.yaml
    ```
    {: pre}

<br />

## Referring to the image pull secret in your pod deployment
{: #pod_imagePullSecret}

If the cluster administrator did not [store the image pull secret in the Kubernetes service account](/docs/containers?topic=containers-registry#use_imagePullSecret), all deployments that do not specify a service account cannot use the image pull secret to deploy containers. Instead, you can define an image pull secret in your pod deployment. When you refer to the image pull secret in a pod deployment, the image pull secret is valid for this pod only and cannot be shared across pods in the Kubernetes namespace.
{: shortdesc}

Before you begin:
* [Create an image pull secret](/docs/containers?topic=containers-registry#other) to access images in other registries or Kubernetes namespaces other than `default`.
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Steps:

1. Create a pod configuration file that is named `mypod.yaml`.
2. Define the pod and the image pull secret to access images in {{site.data.keyword.registrylong_notm}}.

    To access a private image:
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

    To access an {{site.data.keyword.cloud_notm}} public image:
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

    <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
    <caption>Understanding the YAML file components</caption>
    <col width="20%">
    <thead>
    <th>Parameter</th>
    <th>Description</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>&lt;container_name&gt;</em></code></td>
    <td>The name of the container to deploy to your cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;namespace_name&gt;</em></code></td>
    <td>The registry namespace where the image is stored. To list available namespaces, run `ibmcloud cr namespace-list`.</td>
    </tr>
    <tr>
    <td><code><em>&lt;image_name&gt;</em></code></td>
    <td>The name of the image to use. To list available images in an {{site.data.keyword.cloud_notm}} account, run `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code><em>&lt;tag&gt;</em></code></td>
    <td>The version of the image that you want to use. If no tag is specified, the image that is tagged <strong>latest</strong> is used by default.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>The name of the image pull secret that you created earlier.</td>
    </tr>
    </tbody></table>

3. Save your changes.
4. Create the deployment in your cluster.
    ```
    kubectl apply -f mypod.yaml
    ```
    {: pre}

<br />

## Pushing images to {{site.data.keyword.registrylong_notm}}
{: #push-images}

After the cluster administrator [sets up an image registry with {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=Registry-getting-started#getting-started), you can securely store and share Docker images with other users by adding images to your namespace.
{: shortdesc}

For example, you might pull an image from any private or public registry source, and then tag it for later use in {{site.data.keyword.registrylong_notm}}. Or, you might push a Docker image that you work with to your namespace so that other users can access the image. To get started, see [Adding images to your namespace](/docs/Registry?topic=Registry-registry_images_).

<br />

## Managing security of images in {{site.data.keyword.registrylong_notm}} with Vulnerability Advisor
{: #va-images}

Vulnerability Advisor checks the security status of container images that are provided by IBM, third parties, or added to your organization's {{site.data.keyword.registrylong_notm}} namespace.
{: shortdesc}

When you add an image to a namespace, the image is automatically scanned by Vulnerability Advisor to detect security issues and potential vulnerabilities. If security issues are found, instructions are provided to help fix the reported vulnerability. To get started, see [Managing image security with Vulnerability Advisor](/docs/Registry?topic=va-va_index).

<br />

## Setting up trusted content for container images
{: #trusted_images}

You can build containers from trusted images that are signed and stored in {{site.data.keyword.registrylong_notm}}, and prevent deployments from unsigned or vulnerable images.
{: shortdesc}

1. [Sign images for trusted content](/docs/Registry?topic=Registry-registry_trustedcontent#registry_trustedcontent). After you set up trust for your images, you can manage trusted content and signers that can push images to your registry.
2. To enforce a policy so that only signed images can be used to build containers in your cluster, [install the open source Portieris project](#portieris-image-sec).
3. Cluster users can deploy apps that are built from trusted images.
    1. [Deploy to the `default` Kubernetes namespace](/docs/containers?topic=containers-images#namespace).
    2. [Deploy to a different Kubernetes namespace, or from a different {{site.data.keyword.cloud_notm}} region or account](/docs/containers?topic=containers-registry#other).

<br />

## Enabling image security enforcement in your cluster
{: #portieris-image-sec}

When you enable image security enforcement in your cluster, you install the open-source Portieris Kubernetes project. Then, you can create image policies to prevent pods that do not meet the policies, such as unsigned images, from running in your cluster.
{: shortdesc}

For more information, see the [Portieris documentation](https://github.com/IBM/portieris){: external}.

**Mutated images**: By default, Portieris uses the `MutatingAdmissionWebhook` admission controller to mutate your image to refer to the image by a digest instead of a tag. However, you might have some deployment technology that rejects a mutated image. If so, you can use the [image mutation option](https://github.com/IBM/portieris/blob/master/README.md#image-mutation-option){: external} and [policy](https://github.com/IBM/portieris/blob/master/POLICIES.md#image-mutation-option){: external} to change the default behavior.
{: note}

### Enabling or disabling image security enforcement
{: #portieris-enable}

**Kubernetes version 1.18 or later**: You can enable or disable image security enforcement for your cluster from the CLI or console. For earlier versions, see the [Portieris documentation](https://github.com/IBM/portieris){: external}.
{: shortdesc}

**CLI**: See the following commands.
* [`ibmcloud ks cluster image-security enable`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs-image-security-enable)
* [`ibmcloud ks cluster image-security disable`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs-image-security-disable)

**Console**:
1. From the [Kubernetes clusters console](https://cloud.ibm.com/kubernetes/clusters){: external}, select your cluster.
2. From the **Overview** tab, in the **Summary** pane, find the **Image security enforcement** field and click **Enable** or **Disable**.

### Default image policies
{: #portieris-default-policies}

When you enable image security enforcement, {{site.data.keyword.containerlong_notm}} automatically creates certain image policies in your cluster. When you disable the feature, the underlying `ClusterImagePolicy` CRD is removed, which removes all of the default image policies and any custom images policies that you created.
{: shortdesc}

* Image policies with the name `ibm-signed-image-enforcement` restrict the images that are run in the namespace to {{site.data.keyword.containerlong_notm}} images only. Do not modify these image policies. Any changes that you make are overwritten within a few minutes.
* Other image policies, such as `default` or `default-allow-all`, permit images that are not restricted by another image policy. You can modify these image policies and your changes are preserved, but do not rename the image policy. If you rename the policy, more policies with the default name and settings are created.

**To review the image policies in your cluster**:

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. List the image policies that apply globally to the cluster. For an example configuration, see the [Portieris policy documentation](https://github.com/IBM/portieris/blob/master/helm/portieris/templates/policies.yaml#L66){: external}.
    ```
    kubectl get ClusterImagePolicy
    ```
    {: pre}

2. List the image policies that apply to particular namespaces within the cluster. For an example configuration, see the [Portieris policy documentation](https://github.com/IBM/portieris/blob/master/helm/portieris/templates/policies.yaml#L14){: external}.
    ```
    kubectl get ImagePolicy --all-namespaces
    ```
    {: pre}




## Deprecated: Using a registry token to deploy containers from an {{site.data.keyword.registrylong_notm}} image
{: #namespace_token}

You can deploy containers to your cluster from an IBM-provided public image or a private image that is stored in your namespace in {{site.data.keyword.registrylong_notm}}. Existing clusters use a registry [token](https://www.ibm.com/cloud/blog/announcements/announcing-end-of-ibm-cloud-container-registry-support-for-uaa-tokens){: external} that is stored in a cluster image pull secret to authorize access to pull images from the `registry.bluemix.net` [domain names](/docs/Registry?topic=Registry-registry_overview#registry_regions). 
{: shortdesc}

The image pull secrets are added to the `default` Kubernetes namespace, the `kube-system` namespace, and the list of secrets in the `default` service account for those namespaces. By using this initial setup, you can deploy containers from any image that is available in a namespace in your {{site.data.keyword.cloud_notm}} account into the **default** namespace of your cluster. To deploy a container into other namespaces of your cluster, or to use an image that is stored in another {{site.data.keyword.cloud_notm}} region or in another {{site.data.keyword.cloud_notm}} account, you must [create your own image pull secret for your cluster](/docs/containers?topic=containers-registry#other).

This method of using a token to authorize cluster access to {{site.data.keyword.registrylong_notm}} for the `registry.bluemix.net` domain names is deprecated. Before tokens become unsupported, update your deployments to [use the API key method](/docs/containers?topic=containers-registry#cluster_registry_auth) to authorize cluster access to the new `icr.io` registry domain names.
{: deprecated}

Depending on where the image is and where the container is, you must deploy containers by following different steps.
*   [Deploy a container to the `default` Kubernetes namespace with an image that is in the same region as your cluster](#token_default_namespace)
*   [Deploy a container to a different Kubernetes namespace than `default`](#token_copy_imagePullSecret)
*   [Deploy a container with an image that is in a different region or {{site.data.keyword.cloud_notm}} account than your cluster](#token_other_regions_accounts)
*   [Deploy a container with an image that is from a private, non-IBM registry](/docs/containers?topic=containers-registry#private_images)

### Deprecated: Deploying images to the `default` Kubernetes namespace with a registry token
{: #token_default_namespace}

With the registry token that is stored in the image pull secret, you can deploy a container from any image that is available in your regional {{site.data.keyword.registrylong_notm}} into the **default** namespace of your cluster.
{: shortdesc}

Before you begin:
1. [Set up a namespace in {{site.data.keyword.registrylong_notm}} and push images to this namespace](/docs/Registry?topic=Registry-getting-started#gs_registry_namespace_add).
2. [Create a cluster](/docs/containers?topic=containers-clusters#clusters_ui).
3. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To deploy a container into the **default** namespace of your cluster, create a configuration file.

1. Create a deployment configuration file that is named `mydeployment.yaml`.
2. Define the deployment and the image that you want to use from your namespace in {{site.data.keyword.registrylong_notm}}.

    To use a private image from a namespace in {{site.data.keyword.registrylong_notm}}:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: <app_name>-deployment
    spec:
      replicas: 3
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
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **Tip:** To retrieve your namespace information, run `ibmcloud cr namespace-list`.

3. Create the deployment in your cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Tip:** You can also deploy an existing configuration file, such as one of the IBM-provided public images. This example uses the **ibmliberty** image in the US-South region.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### Deprecated: Copying the token-based image pull secret from the default namespace to other namespaces in your cluster
{: #token_copy_imagePullSecret}

You can copy the image pull secret with registry token credentials that is automatically created for the `default` Kubernetes namespace to other namespaces in your cluster.
{: shortdesc}

1. List available namespaces in your cluster.
    ```
    kubectl get namespaces
    ```
    {: pre}

    Example output:
    ```
    default          Active    79d
    ibm-cert-store   Active    79d
    ibm-system       Active    79d
    istio-system     Active    34d
    kube-public      Active    79d
    kube-system      Active    79d
    ```
    {: screen}

2. Optional: Create a namespace in your cluster.
    ```
    kubectl create namespace <namespace_name>
    ```
    {: pre}

3. Copy the image pull secrets from the `default` namespace to the namespace of your choice. The new image pull secrets are named `bluemix-<namespace_name>-secret-regional` and `bluemix-<namespace_name>-secret-international`.
    ```
    kubectl get secret bluemix-default-secret-regional -o yaml | sed 's/default/<namespace_name>/g' | kubectl -n <namespace_name> create -f -
    ```
    {: pre}

    ```
    kubectl get secret bluemix-default-secret-international -o yaml | sed 's/default/<namespace_name>/g' | kubectl -n <namespace_name> create -f -
    ```
    {: pre}

4. Verify that the secrets are created successfully.
    ```
    kubectl get secrets --namespace <namespace_name>
    ```
    {: pre}

5. [Deploy a container by using the image pull secret](/docs/containers?topic=containers-images#pod_imagePullSecret) in your namespace.


### Deprecated: Accessing token-authorized images in other {{site.data.keyword.cloud_notm}} regions and accounts
{: #token_other_regions_accounts}

To access images in other {{site.data.keyword.cloud_notm}} regions or accounts, you must create a registry token and save your credentials in an image pull secret.
{: shortdesc}

Tokens that authorize access to `registry.<region>.bluemix.net` domains are deprecated. You can no longer create new tokens. Instead, create cluster image pull secrets that use [API key credentials](/docs/containers?topic=containers-registry#imagePullSecret_migrate_api_key) to pull images from the `icr.io` registry domains.
{: deprecated}

1. List tokens in your {{site.data.keyword.cloud_notm}} account.

    ```
    ibmcloud cr token-list
    ```
    {: pre}

2. Note the token ID that you want to use.
3. Retrieve the value for your token. Replace <em>&lt;token_ID&gt;</em> with the ID of the token that you retrieved in the previous step.

    ```
    ibmcloud cr token-get <token_id>
    ```
    {: pre}

    Your token value is displayed in the **Token** field of your CLI output.

4. Create the Kubernetes secret to store your token information.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_URL> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table summary="The columns are read from left to right. The first column has the parameter of the command. The second column describes the parameter.">
    <caption>Understanding this command's components</caption>
    <col width="35%">
    <thead>
    <th>Parameter</th>
    <th>Description</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Required. The Kubernetes namespace of your cluster where you want to use the secret and deploy containers to. Run <code>kubectl get namespaces</code> to list all namespaces in your cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Required. The name that you want to use for your image pull secret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_URL&gt;</em></code></td>
    <td>Required. The URL to the image registry where your namespace is set up.<ul><li>For namespaces that are set up in US-South and US-East <code>registry.ng.bluemix.net</code></li><li>For namespaces that are set up in UK-South <code>registry.eu-gb.bluemix.net</code></li><li>For namespaces that are set up in EU-Central (Frankfurt) <code>registry.eu-de.bluemix.net</code></li><li>For namespaces that are set up in Australia (Sydney) <code>registry.au-syd.bluemix.net</code></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Required. The username to log in to your private registry. For {{site.data.keyword.registrylong_notm}}, the username is set to the value <strong><code>token</code></strong>.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Required. The value of your registry token that you retrieved earlier.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Required. If you have one, enter your Docker email address. If you do not, enter a fictional email address, as for example a@b.c. This email is mandatory to create a Kubernetes secret, but is not used after creation.</td>
    </tr>
    </tbody></table>

5. Verify that the secret was created successfully. Replace <em>&lt;kubernetes_namespace&gt;</em> with the namespace where you created the image pull secret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

6. [Deploy a container by using the image pull secret](/docs/containers?topic=containers-images#pod_imagePullSecret) in your namespace.


