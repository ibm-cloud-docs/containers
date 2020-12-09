---

copyright:
  years: 2014, 2020
lastupdated: "2020-12-09"

keywords: kubernetes, iks, knative

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
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
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
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
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
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vb.net: .ph data-hd-programlang='vb.net'}
{:video: .video}



# Deploying serverless apps with Knative (deprecated)
{: #serverless-apps-knative}

Learn how to install and use Knative in a Kubernetes cluster in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

As of 18 November 2020 the Knative managed add-on is deprecated. On 18 December 2020 the add-on becomes unsupported and can no longer be installed, and on 18 January 2021 the add-on is automatically uninstalled from all clusters. If you use the Knative add-on, consider migrating to the [Knative open source project](https://knative.dev/docs/install/){: external} or to [{{site.data.keyword.codeenginefull}}](/docs/codeengine?topic=codeengine-getting-started), which includes Knative's open-source capabilities.
{: deprecated}

**What is Knative and why do I want use it?**

[Knative](https://github.com/knative/docs) is an open source platform that was developed by IBM, Google, Pivotal, Red Hat, Cisco, and others. The goal is to extend the capabilities of Kubernetes to help you create modern, source-centric containerized, and serverless apps on top of your Kubernetes cluster. The platform is designed to address the needs of developers who today must decide what type of app they want to run in the cloud: 12-factor apps, containers, or functions. Each type of app requires an open source or proprietary solution that is tailored to these apps: Cloud Foundry for 12-factor apps, Kubernetes for containers, and OpenWhisk and others for functions. In the past, developers had to decide what approach they wanted to follow, which led to inflexibility and complexity when different types of apps had to be combined.

Knative uses a consistent approach across programming languages and frameworks to abstract the operational burden of building, deploying, and managing workloads in Kubernetes so that developers can focus on what matters most to them: the source code. You can use proven build processes that you are already familiar with, such as Kaniko, Dockerfile, Bazel, and others. By integrating with Istio, Knative ensures that your serverless and containerized workloads can be easily exposed on the internet, monitored, and controlled, and that your data is encrypted during transit.

**How does Knative work?**

Knative comes with two key components, or _primitives_, that help you to deploy and manage your serverless apps in your Kubernetes cluster:

- **Serving:** The `Serving` primitive helps to deploy serverless apps as Knative services and to automatically scale them, even down to zero instances. To expose your serverless and containerized workloads, Knative uses Istio. When you install the managed Knative add-on, the managed Istio add-on is automatically installed as well. By using the traffic management and intelligent routing capabilities of Istio, you can control what traffic is routed to a specific version of your service, which makes it easy for a developer to test and roll out a new app version or do A-B testing.
- **Eventing:** With the `Eventing` primitive, you can create triggers or event streams that other services can subscribe to. For example, you might want to kick off a new build of your app every time code is pushed to your GitHub master repo. Or you want to run a serverless app only if the temperature drops below freezing point. For example, the `Eventing` primitive can be integrated into your CI/CD pipeline to automate the build and deployment of apps in case a specific event occurs.

The Knative open-source project deprecated the **Build** primitive in favor of the Tekton open-source project. The Build primitive provided you with tools to automate the build process for your app from source code to a container image. The Tekton project originated from the Knative project and provides advanced CI/CD features on top of the deprecated Knative Build primitive. For more information, see the [Tekton open-source project](https://tekton.dev){: external}.
{: note}

**What is the Managed Knative on {{site.data.keyword.containerlong_notm}} add-on?**

Managed Knative on {{site.data.keyword.containerlong_notm}} is a [managed add-on](/docs/containers?topic=containers-managed-addons#managed-addons) that integrates Knative and Istio directly with your Kubernetes cluster. The Knative and Istio versions in the add-on are tested by IBM and supported for the use in {{site.data.keyword.containerlong_notm}}. For more information about managed add-ons, see [Adding services by using managed add-ons](/docs/containers?topic=containers-managed-addons#managed-addons).

**Are there any limitations?**
{: #knative_limitations}

* Version 0.15.1 of the managed Knative add-on version requires and installs Istio version 1.6, and version 0.14.0 of the managed Knative add-on version requires and installs Istio version 1.5. You cannot use the Knative add-on with earlier versions of Istio. Before you install Knative, check if Istio is already installed in your cluster by running `ibmcloud ks cluster addons -c <cluster_name_or_ID>`. If you have a version of Istio that is installed in your cluster but that does not match the version of Knative that you want to install, you must [update Istio first](/docs/containers?topic=containers-istio#istio_update).
* The Knative add-on can be enabled in clusters that run Kubernetes version 1.16 or later only.

## Setting up Knative in your cluster
{: #knative-setup}

Knative builds on top of Istio to ensure that your serverless and containerized workloads can be exposed within the cluster and on the internet. With Istio, you can also monitor and control network traffic between your services and ensure that your data is encrypted during transit. When you install the managed Knative add-on, the managed Istio add-on is automatically installed as well. However, as a developer you don't need to know Ingress specifics because you use Knative features only to work with your serverless app.
{: shortdesc}

The Knative add-on can be enabled in clusters that run Kubernetes version 1.16 or later only.
{: important}

Before you begin:
-  [Install the IBM Cloud CLI, the {{site.data.keyword.containerlong_notm}} plug-in, and the Kubernetes CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps). Make sure to install the `kubectl` CLI version that matches the Kubernetes version of your cluster.
-  [Create a standard cluster with at least 3 worker nodes that each have 4 cores and 16 GB memory (`b3c.4x16`) or more](/docs/containers?topic=containers-clusters#clusters_ui). Additionally, the cluster and worker nodes must run at least the minimum supported version of Kubernetes, which you can review by running `ibmcloud ks addon-versions --addon knative`.
-  Ensure that you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}.
-  [Target the CLI to your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
-  If you already have the managed Istio add-on installed, [check that the version is 1.5 or uninstall Istio](#knative_limitations). When you install the managed Knative add-on, Istio 1.5 is automatically installed with the add-on.
</br>

To install Knative in your cluster:

1. Enable the managed Knative add-on in your cluster. When you enable Knative in your cluster, Istio and all Knative components are installed in your cluster.
   ```
   ibmcloud ks cluster addon enable knative --cluster <cluster_name_or_ID> -y
   ```
   {: pre}

   Example output:
   ```
   Enabling add-on knative for cluster knative...
   OK
   ```
   {: screen}

   The installation of all Knative components might take a few minutes to complete.

2. Verify that Istio is successfully installed. All pods for the Istio services must be in a `Running` status.
   ```
   kubectl get pods --namespace istio-system
   ```
   {: pre}

3. Optional: If you want to use Istio for all other apps in the `default` namespace, add the `istio-injection=enabled` label to the namespace. Each serverless app pod that you create with Knative automatically runs an Envoy proxy sidecar so that the app can be included in the Istio service mesh. However, other apps in your namespaces are not included in the Istio service mesh by default. To include these apps, you must apply the label.
   ```
   kubectl label namespace default istio-injection=enabled
   ```
   {: pre}

4. Verify that all pods of the Knative `Serving` component are in a `Running` state.
   ```
   kubectl get pods --namespace knative-serving
   ```
   {: pre}

   Example output:
   ```
   NAME                          READY     STATUS    RESTARTS   AGE
   activator-598b4b7787-ps7mj    2/2       Running   0          21m
   autoscaler-5cf5cfb4dc-mcc2l   2/2       Running   0          21m
   controller-7fc84c6584-qlzk2   1/1       Running   0          21m
   webhook-7797ffb6bf-wg46v      1/1       Running   0          21m
   ```
   {: screen}

To resolve some common issues that you might encounter during the add-on deployment, see [Reviewing add-on state and statuses](/docs/containers?topic=containers-cs_troubleshoot_addons#debug_addons).
{: tip}

### Updating the Knative managed add-on
{: #update-knative-addon}

Update your Knative add-on to the latest versions.
{: shortdesc}

1. Check whether your add-on is at the latest version. If your add-on is denoted with `* (<version> latest)`, you can update the add-on.
   ```
   ibmcloud ks cluster addon ls --cluster <mycluster> | grep knative
   ```
   {: pre}

   Example output:
   ```
   OK
   Name      Version              
   knative   0.15.1* (<version> latest)
   ```
   {: screen}

2. Save any resources, such as configuration files for any services or apps, that you created or modified in the `knative-serving`, and `knative-eventing` namespaces.
   Example command:
   ```
   kubectl get pod <pod_name> -o yaml -n knative-serving > knative-serving-pods.yaml
   kubectl get pod <pod_name> -o yaml -n knative-eventing > knative-eventing-pods.yaml
   ```
   {: pre}

3. Save the Kubernetes resources that were automatically generated in the Knative namespaces to a YAML file on your local machine. These resources are generated by using custom resource definitions (CRDs).
   1. Get the CRDs for the `knative-serving`, and `knative-eventing` namespaces.
      ```
      kubectl get crd -n knative-serving
      kubectl get crd -n knative-eventing
      ```
      {: pre}

   2. Save any resources created from these CRDs.

4. If you modified any of the following Knative resources, get the YAML file and save them to your local machine. If you modified any of these resources, but you want to use the installed default instead, you can delete the resource. After a few minutes, the resource is re-created with the installed default values.
  <table summary="The columns are read from left to right. The first column has the Knative resource name. The second column has the type of resource. The third column is the namespace that the resource is in.">
  <caption>Knative resources</caption>
  <thead><tr><th>Resource name</th><th>Resource type</th><th>Namespace</th></tr></thead>
  <tbody>
  <tr><td><code>config-autoscaler</code></td><td>ConfigMap</td><td><code>knative-serving</code></td></tr>
  <tr><td><code>config-controller</code></td><td>ConfigMap</td><td><code>knative-serving</code></td></tr>
  <tr><td><code>config-domain</code></td><td>ConfigMap</td><td><code>knative-serving</code></td></tr>
  <tr><td><code>config-gc</code></td><td>ConfigMap</td><td><code>knative-serving</code></td></tr>
  <tr><td><code>config-istio</code></td><td>ConfigMap</td><td><code>knative-serving</code></td></tr>
  <tr><td><code>config-logging</code></td><td>ConfigMap</td><td><code>knative-serving</code></td></tr>
  <tr><td><code>config-network</code></td><td>ConfigMap</td><td><code>knative-serving</code></td></tr>
  <tr><td><code>config-observability</code></td><td>ConfigMap</td><td><code>knative-serving</code></td></tr>
  <tr><td><code>kaniko</code></td><td>BuildTemplate</td><td><code>default</code></td></tr>
  <tr><td><code>iks-knative-ingress</code></td><td>Ingress</td><td><code>istio-system</code></td></tr>
  </tbody></table>

  Example command:
  ```
  kubectl get cm config-autoscaler -n knative-serving -o yaml > config-autoscaler.yaml
  ```
  {: pre}

5. Disable the add-on in your cluster.
   ```
   ibmcloud ks cluster addon disable knative --cluster <cluster_name_or_ID> -f
   ```
   {: pre}

6. Verify that the `knative-serving`, `knative-eventing`, and `istio-system` namespaces are deleted. The namespaces might have a **STATUS** of `Terminating` for a few minutes before they are deleted.
    ```
    kubectl get namespaces -w
    ```
    {: pre}

7. Re-enable the add-on.
   ```
   ibmcloud ks cluster addon enable knative --cluster <cluster_name_or_ID> --version <version>
   ```
   {: pre}

8. Apply the CRD resources that you saved in step 3.
   ```
   kubectl apply -f crd.yaml -n knative-serving
   kubectl apply -f crd.yaml -n knative-eventing
   ```
   {: pre}

9. If you saved any of the resources in step 4, reapply them.

   Example command:
   ```
   kubectl apply -f config-autoscaler.yaml -n knative-serving
   ```
   {: pre}

10. If you saved any pod configuration files in step 2, reapply them.
    ```
    kubectl apply -f knative-serving-pods.yaml
    kubectl apply -f knative-eventing-pods.yaml
    ```
    {: pre}

11. Verify that your cluster uses the latest version of the Knative managed add-on.
    ```
    ibmcloud ks cluster addon ls --cluster <mycluster> | grep knative
    ```
    {: pre}

    Example output:
    ```
    OK
    Name      Version              
    knative   0.15.1
    ```
    {: screen}

12. Update the pods of your Knative data plane to include the latest version of the Istio proxy sidecar.
    1. Get the version of your Istio control plane components.
      ```
      kubectl -n istio-system get pod -l istio=pilot -o jsonpath='{.items[].spec.containers[0].image}'
      ```
      {: pre}
      Example output:
      ```
      icr.io/ext/istio/pilot:1.5.8
      ```
      {: screen}
    2. Using the Istio control plane version, download the `istioctl` client.
      ```
      curl -L https://istio.io/downloadIstio | ISTIO_VERSION=<istio-version> sh -
      ```
      {: pre}
    3. Navigate to the Istio package directory.
      ```
      cd istio-1.8.0
      ```
      {: pre}
    4. Linux and macOS users: Add the `istioctl` client to your `PATH` system variable.
      ```
      export PATH=$PWD/bin:$PATH
      ```
      {: pre}
    5. Get the names and namespaces of the Knative data plane pods.
      ```
      istioctl version --short=false | egrep 'cluster-local-gateway-|knative'
      ```
      {: pre}
      In the following example output, the pod names and namespaces are formatted like `"<pod_name>.<namespace>"`, such as the `controller-7865b5fd46-nf7r5` pod in the `istio-system` namespace.
      ```
      data plane version: version.ProxyInfo{ID:"cluster-local-gateway-dc7ff5449-lbt6f.istio-system", IstioVersion:"1.4.5"}
      data plane version: version.ProxyInfo{ID:"controller-7865b5fd46-nf7r5.knative-serving", IstioVersion:"1.4.5"}
      data plane version: version.ProxyInfo{ID:"activator-785dd6f98b-v69jx.knative-serving", IstioVersion:"1.4.5"}
      data plane version: version.ProxyInfo{ID:"autoscaler-hpa-6cfbdcc99c-fhm2t.knative-serving", IstioVersion:"1.4.5"}
      data plane version: version.ProxyInfo{ID:"autoscaler-7d8dc65584-njpng.knative-serving", IstioVersion:"1.4.5"}
      data plane version: version.ProxyInfo{ID:"webhook-7f4f6d9b64-rbp7z.knative-serving", IstioVersion:"1.4.5"}
      ```
      {: screen}
    6. Using the pod names and namespaces from the previous step, restart each pod by deleting it.
      ```
      kubectl delete pod <pod_name> -n <namespace>
      ```
      {: pre}
    7. Verify that the pods are restarted and have a `Running` status.
      ```
      kubectl get pods -n istio-system
      kubectl get pods -n knative-serving
      ```
      {: pre}

## Using Knative services to deploy a serverless app
{: #knative-deploy-app}

After you set up Knative in your cluster, you can deploy your serverless app as a Knative service.
{: shortdesc}

**What is a Knative service?** </br>
To deploy an app with Knative, you must specify a Knative `Service` resource. A Knative service is managed by the Knative `Serving` primitive and is responsible to manage the entire lifecycle of the workload. When you create the service, the Knative `Serving` primitive automatically creates a version for your serverless app and adds this version to the revision history of the service. Your serverless app is assigned a public URL from your Ingress subdomain in the format `<knative_service_name>-<namespace>.<ingress_subdomain>` that you can use to access the app from the internet. In addition, a private hostname is assigned to your app in the format `<knative_service_name>.<namespace>.cluster.local` that you can use to access your app from within the cluster.

**What happens behind the scenes when I create the Knative service?**</br>
When you create a Knative service, your app is automatically deployed as a Kubernetes pod in your cluster and exposed by using a Kubernetes service. To assign the public hostname, Knative uses the IBM-provided Ingress subdomain and TLS certificate. Incoming network traffic is routed based on the default IBM-provided Ingress routing rules.

**How can I roll out a new version of my app?**</br>
When you update your Knative service, a new version of your serverless app is created. This version is assigned the same public and private hostnames as your previous version. By default, all incoming network traffic is routed to the latest version of your app. However, you can also specify the percentage of incoming network traffic that you want to route to a specific app version so that you can do A-B testing. You can split incoming network traffic between two app versions at a time, the current version of your app and the new version that you want to roll over to.  

**Can I bring my own custom domain and TLS certificate?** </br>
You can change the configmap of your Istio Ingress gateway and the Ingress routing rules to use your custom domain name and TLS certificate when you assign a hostname to your serverless app. For more information, see [Setting up custom domain names and certificates](#knative-custom-domain-tls).

To deploy your serverless app as a Knative service:

1. Create a YAML file for your first serverless [`Hello World`](https://hub.docker.com/r/ibmcom/kn-helloworld) app in Go with Knative. When you send a request to your sample app, the app reads the environment variable `TARGET` and prints `"Hello ${TARGET}!"`. If this environment variable is empty, `"Hello World!"` is returned.

   ```yaml
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     template:
       spec:
         containers:
         - image: docker.io/ibmcom/kn-helloworld
           env:
           - name: TARGET
             value: "Go Sample v1"
   ```
   {: codeblock}

    <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
    <caption>Understanding the YAML file components</caption>
    <col width="25%">
    <thead>
    <th>Parameter</th>
    <th>Description</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata.name</code></td>
    <td>The name of your Knative service.</td>
    </tr>
    <tr>
    <td><code>metadata.namespace</td>
    <td>Optional: The Kubernetes namespace where you want to deploy your app as a Knative service. By default, all services are deployed to the <code>default</code> Kubernetes namespace. </td>
    </tr>
    <tr>
    <td><code>spec.template.spec.containers.image</code></td>
    <td>The URL to the container registry where your image is stored. In this example, you deploy a Knative Hello World app that is stored in the <code>ibmcom</code> namespace in Docker Hub. </td>
    </tr>
    <tr>
    <td><code>spec.template.spec.containers.env</code></td>
    <td>Optional: A list of environment variables that you want your Knative service to have. In this example, the value of the environment variable <code>TARGET</code> is read by the sample app and returned when you send a request to your app in the format <code>"Hello ${TARGET}!"</code>. If no value is provided, the sample app returns <code>"Hello World!"</code>.  </td>
    </tr>
    </tbody>
    </table>

2. Create the Knative service in your cluster.
   ```
   kubectl apply -f service.yaml
   ```
   {: pre}

   Example output:
   ```
   service.serving.knative.dev "kn-helloworld" created
   ```
   {: screen}

3. Verify that your Knative service is created. In your CLI output, you can view the public **DOMAIN** that is assigned to your serverless app. The **LATESTCREATED** and **LATESTREADY** columns show the version of your app that was last created and that is currently deployed in the format `<knative_service_name>-<version>`. The version that is assigned to your app is a random string value. In this example, the version of your serverless app is `rjmwt`. When you update the service, a new version of your app is created and assigned a new random string for the version.  
   ```
   kubectl get ksvc/kn-helloworld
   ```
   {: pre}

   Example output:
   ```
   NAME            DOMAIN                                                                LATESTCREATED         LATESTREADY           READY   REASON
   kn-helloworld   kn-helloworld-default.mycluster-<hash>-0001.us-south.containers.appdomain.cloud   kn-helloworld-rjmwt   kn-helloworld-rjmwt   True
   ```
   {: screen}

4. Try out your `Hello World` app by sending a request to the public URL that is assigned to your app.
   ```
   curl <public_app_url>
   ```
   {: pre}

   Example output:
   ```
   Hello Go Sample v1!
   ```
   {: screen}

5. List the number of pods that were created for your Knative service. In the example in this topic, one pod is deployed that consists of two containers. One container runs your `Hello World` app and the other container is a side car that runs Istio monitoring and logging tools.
   ```
   kubectl get pods
   ```
   {: pre}

   Example output:
   ```
   NAME                                             READY     STATUS    RESTARTS   AGE
   kn-helloworld-rjmwt-deployment-55db6bf4c5-2vftm  2/2      Running   0          16s
   ```
   {: screen}

6. Wait a few minutes to let Knative scale down your pod. Knative evaluates the number of pods that must be up at a time to process incoming workload. If no network traffic is received, Knative automatically scales down your pods, even to zero pods as shown in this example.

   Want to see how Knative scales up your pods? Try to increase workload for your app, for example by using tools like the [Simple cloud-based load tester](https://loader.io/).
   {: tip}
   ```
   kubectl get pods
   ```
   {: pre}

   If you do not see any `kn-helloworld` pods, Knative scaled down your app to zero pods.

7. Update your Knative service sample and enter a different value for the `TARGET` environment variable.

   Example service YAML:
   ```yaml
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     template:
       spec:
         containers:
         - image: docker.io/ibmcom/kn-helloworld
           env:
           - name: TARGET
             value: "Mr. Smith"
   ```
   {: codeblock}

8. Apply the change to your service. When you change the configuration, Knative automatically creates a new version for your app.
   ```
   kubectl apply -f service.yaml
   ```
   {: pre}

9. Verify that a new version of your app is deployed. In your CLI output, you can see the new version of your app in the **LATESTCREATED** column. When you see the same app version in the **LATESTREADY** column, your app is all set up and ready to receive incoming network traffic on the assigned public URL.
   ```
   kubectl get ksvc/kn-helloworld
   ```
   {: pre}

   Example output:
   ```
   NAME            DOMAIN                                                                LATESTCREATED         LATESTREADY           READY   REASON
   kn-helloworld   kn-helloworld-default.mycluster-<hash>-0001.us-south.containers.appdomain.cloud   kn-helloworld-ghyei   kn-helloworld-ghyei   True
   ```
   {: screen}

9. Make a new request to your app to verify that your change was applied.
   ```
   curl <public_app_url>
   ```

   Example output:
   ```
   Hello Mr. Smith!
   ```
   {: screen}

10. Verify that Knative scaled up your pod again to account for the increased network traffic.
    ```
    kubectl get pods
    ```
    {: pre}

    Example output:
    ```
    NAME                                              READY     STATUS    RESTARTS   AGE
    kn-helloworld-ghyei-deployment-55db6bf4c5-2vftm   2/2       Running   0          16s
    ```
    {: screen}

11. Optional: Clean up your Knative service.
    ```
    kubectl delete -f service.yaml
    ```
    {: pre}


## Setting up custom domain names and certificates
{: #knative-custom-domain-tls}

You can configure Knative to assign hostnames from your own custom domain that you configured with TLS.
{: shortdesc}

By default, every app is assigned a public subdomain from your Ingress subdomain in the format `<knative_service_name>-<namespace>.<ingress_subdomain>` that you can use to access the app from the Internet. In addition, a private hostname is assigned to your app in the format `<knative_service_name>.<namespace>.cluster.local` that you can use to access your app from within the cluster. If you want to assign hostnames from a custom domain that you own, you can change the Knative configmap to use the custom domain instead.

1. Create a custom domain. To register your custom domain, work with your Domain Name Service (DNS) provider or [IBM Cloud DNS](/docs/dns?topic=dns-getting-started).
2. Configure your domain to route incoming network traffic to the IBM-provided Ingress gateway. Choose between these options:
   - Define an alias for your custom domain by specifying the IBM-provided domain as a Canonical Name record (CNAME). To find the IBM-provided Ingress domain, run `ibmcloud ks cluster get --cluster <cluster_name>` and look for the **Ingress subdomain** field. Using a CNAME is preferred because IBM provides automatic health checks on the IBM subdomain and removes any failing IPs from the DNS response.
   - Map your custom domain to the portable public IP address of the Ingress gateway by adding the IP address as an A record. To find the public IP address of the Ingress gateway, run `nslookup <ingress_subdomain>`.
3. Purchase an official wildcard TLS certificate for your custom domain. If you want to purchase multiple TLS certificates, make sure the [CN](https://support.dnsimple.com/articles/what-is-common-name/){: external} is different for each certificate.
4. Create a Kubernetes secret for your cert and key.
   1. Encode the cert and key into base64 and save the base64 encoded value in a new file.
      ```
      openssl base64 -in tls.key -out tls.key.base64
      ```
      {: pre}

   2. View the base64 encoded value for your cert and key.
      ```
      cat tls.key.base64
      ```
      {: pre}

   3. Create a secret YAML file by using the cert and key.
      ```yaml
      apiVersion: v1
      kind: Secret
      metadata:
        name: mydomain-ssl
      type: Opaque
      data:
        tls.crt: <client_certificate>
        tls.key: <client_key>
      ```
      {: codeblock}

   4. Create the certificate in your cluster.
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}

5. Open the `iks-knative-ingress` Ingress resource in the `istio-system` namespace of your cluster to start editing it.
   ```
   kubectl edit ingress iks-knative-ingress -n istio-system
   ```
   {: pre}

6. Change the default routing rules for your Ingress.
   - Add your custom wildcard domain to the `spec.rules.host` section so that all incoming network traffic from your custom domain and any subdomain is routed to the `istio-ingressgateway`.
   - Configure all hosts of your custom wildcard domain to use the TLS secret that you created earlier in the `spec.tls.hosts` section.

   Example Ingress:
   ```yaml
   apiVersion: networking.k8s.io/v1beta1
   kind: Ingress
   metadata:
     name: iks-knative-ingress
     namespace: istio-system
   spec:
     rules:
     - host: '*.mydomain'
       http:
         paths:
         - backend:
             serviceName: istio-ingressgateway
             servicePort: 80
           path: /
     tls:
     - hosts:
       - '*.mydomain'
       secretName: mydomain-ssl
   ```
   {: codeblock}

   The `spec.rules.host` and `spec.tls.hosts` sections are lists and can include multiple custom domains and TLS certificates.
   {: tip}

7. Modify the Knative `config-domain` configmap to use your custom domain to assign hostnames to new Knative services.
   1. Open the `config-domain` configmap to start editing it.
      ```
      kubectl edit configmap config-domain -n knative-serving
      ```
      {: pre}

   2. Specify your custom domain in the `data` section of your configmap and remove the default domain that is set for your cluster.
      - **Example to assign a hostname from your custom domain for all Knative services**:
        ```yaml
        apiVersion: v1
        kind: ConfigMap
        data:
          <custom_domain>: ""
        metadata:
          name: config-domain
          namespace: knative-serving
        ```
        {: codeblock}

        By adding `""` to your custom domain, all Knative services that you create are assigned a hostname from your custom domain.  

      - **Example to assign a hostname from your custom domain for select Knative services**:
        ```yaml
        apiVersion: v1
        kind: ConfigMap
        data:
          <custom_domain>: |
            selector:
              app: sample
          mycluster-<hash>-0001.us-south.containers.appdomain.cloud: ""
        metadata:
          name: config-domain
          namespace: knative-serving
        ```
        {: codeblock}

        To assign a hostname from your custom domain for select Knative services only, add a `data.selector` label key and value to your configmap. In this example, all services with the label `app: sample` are assigned a hostname from your custom domain. Make sure to also have a domain name that you want to assign to all other apps that do not have the `app: sample` label. In this example, the default IBM-provided domain `mycluster-<hash>-0001.us-south.containers.appdomain.cloud` is used.
    3. Save your changes.

With your Ingress routing rules and Knative configmaps all set up, you can create Knative services with your custom domain and TLS certificate.

## Using volumes to access Kubernetes secrets and config maps
{: #knative-access-volume}

Access Kubernetes secrets and config maps from your Knative service by mounting the secret or config map as a volume to your Knative service.  
{: shortdesc}

Knative services support the Kubernetes `volume` specification to mount an existing Kubernetes secret or configmap to your app. Although the `volume` specification is supported, not all of the related features are supported in Knative. As of today, you can mount volumes that point to Kubernetes secrets or config maps only. To access other types of volumes, such as persistent volume claims (PVCs), you must use Kubernetes directly.
{: note}

1. Retrieve existing Kubernetes secrets or config maps in your cluster and note the name of the secret or config map that you want to mount.

   Example command for secrets:
   ```
   kubectl get secrets
   ```
   {: pre}

   Example command for config maps:
   ```
   kubectl get configmaps
   ```
   {: pre}

2. Reference your secret or config map as a Kubernetes volume in your Knative service. To share secrets and config maps across Knative services, mount the volume to every Knative service that must access the data.

   Example YAML file for mounting a secret:
   ```yaml
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     template:
       spec:
         containers:
         - image: docker.io/ibmcom/kn-helloworld
           volumeMounts:
           - name: <volume_name>
             mountPath: /<file_path>
         volumes:
         - name: <volume_name>
           secret:
             secretName: <secret_name>
   ```
   {: codeblock}

   Example YAML file for mounting a config map:
   ```yaml
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     template:
       spec:
         containers:
         - image: docker.io/ibmcom/kn-helloworld
           volumeMounts:
           - name: <volume_name>
             mountPath: /<file_path>
         volumes:
         - name: <volume_name>
           configMap:
             name: <configmap_name>
   ```
   {: codeblock}

   <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
   <caption>Understanding the YAML file components</caption>
   <col width="25%">
   <thead>
   <th>Parameter</th>
   <th>Description</th>
   </thead>
   <tbody>
   <tr>
     <td><code>spec.containers.volumeMounts.name</code></td>
   <td>Enter a name for the volume that you want to mount to your pod.</td>
   </tr>
   <tr>
   <td><code>spec.containers.volumeMounts.mountPath</code></td>
   <td>Enter the absolute path of the directory to where the volume is mounted inside the container. You use this mount directory to access the data from your secret or config map. </td>
   </tr>
   <tr>
   <td><code>spec.volumes.name</code></td>
     <td>Enter the same name for your volume that you entered in <code>spec.containers.volumeMounts.name</code>.</td>
   </tr>
   <tr>
   <td><code>spec.volumes.secret.secretName</code></td>
     <td>Enter the name of the secret that you want to mount to your Knative service.</td>
   </tr>
   <tr>
   <td><code>spec.volumes.configMap.name</code></td>
     <td>Enter the name of the config map that you want to mount to your Knative service.</td>
   </tr>
   </tbody>
   </table>

3. Create the Knative service in your cluster.
   ```
   kubectl apply -f service.yaml
   ```
   {: pre}

   Example output:
   ```
   service.serving.knative.dev "kn-helloworld" created
   ```
   {: screen}

## Pulling images from a private container registry
{: #knative-private-registry}

To access a container registry, your cluster must bet set up with the appropriate image pull secrets that include the credentials to authenticate with your registry. By default, Knative services can access images that are stored in {{site.data.keyword.registrylong_notm}}. To access other private registries, you must store the credentials in a Kubernetes image pull secret in your cluster.
{: shortdesc}

1. Follow the instructions to [create an image pull secret](/docs/containers?topic=containers-registry#private_images) that includes the credentials to access your private container registry.

2. Create a Knative service that uses the image pull secret. You can choose if you want to reference the image pull secret in your Knative service directly as shown in the following example, or to [add the image pull secret to the Kubernetes service account of the namespace](/docs/containers?topic=containers-registry#store_imagePullSecret) where you want to deploy your Knative service.

   Example to reference the image pull secret in your Knative service:
   ```yaml
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     template:
       spec:
         containers:
         - image: docker.io/ibmcom/kn-helloworld
         imagePullSecrets:
         - name: <secret_name>
   ```
   {: codeblock}

3. Create the Knative service in your cluster.
   ```
   kubectl apply -f service.yaml
   ```
   {: pre}

   Example output:
   ```
   service.serving.knative.dev "kn-helloworld" created
   ```
   {: screen}

## Accessing a Knative service from another Knative service
{: #knative-access-service}

You can access your Knative service from another Knative service by using a REST API call to the URL that is assigned to your Knative service.
{: shortdesc}

1. List all Knative services in your cluster.
   ```
   kubectl get ksvc --all-namespaces
   ```
   {: pre}

2. Retrieve the **DOMAIN** that is assigned to your Knative service.
   ```
   kubect get ksvc/<knative_service_name>
   ```
   {: pre}

   Example output:
   ```
   NAME        DOMAIN                                                            LATESTCREATED     LATESTREADY       READY   REASON
   myservice   myservice-default.mycluster-<hash>-0001.us-south.containers.appdomain.cloud   myservice-rjmwt   myservice-rjmwt   True
   ```
   {: screen}

3. Use the domain name to implement a REST API call to access your Knative service. This REST API call must be part of the app for which you create a Knative service. If the Knative service that you want to access is assigned a local URL in the format `<service_name>.<namespace>.svc.cluster.local`, Knative keeps the REST API request within the cluster-internal network.

   Example code snippet in Go:
   ```go
   resp, err := http.Get("<knative_service_domain_name>")
   if err != nil {
       fmt.Fprintf(os.Stderr, "Error: %s\n", err)
   } else if resp.Body != nil {
       body, _ := ioutil.ReadAll(resp.Body)
       fmt.Printf("Response: %s\n", string(body))
   }
   ```
   {: codeblock}

## Common Knative service settings
{: #knative-service-settings}

Review common Knative service settings that you might find useful as you develop your serverless app.
{: shortdesc}

- [Setting the minimum and maximum number of pods](#knative-min-max-pods)
- [Scaling your app based on CPU usage or number of requests](#scale-cpu-vs-number-requests)
- [Specifying the maximum number of requests per pod](#max-request-per-pod)
- [Changing the default container port](#knative-container-port)
- [Changing the `scale-to-zero-grace-period`](#knative-idle-time)
- [Creating private-only serverless apps](#knative-private-only)
- [Forcing the Knative service to repull a container image](#knative-repull-image)

### Setting the minimum and maximum number of pods
{: #knative-min-max-pods}

You can specify the minimum and maximum number of pods that you want to run for your apps by using an annotation. For example, if you don't want Knative to scale down your app to zero instances, set the minimum number of pods to 1.
{: shortdesc}

```yaml
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: ...
spec:
  template:
    metadata:
      annotations:
        autoscaling.knative.dev/minScale: "1"
        autoscaling.knative.dev/maxScale: "100"
    spec:
      containers:
      - image: <image_name>
...
```
{: codeblock}

<table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
<caption>Understanding the YAML file components</caption>
<col width="25%">
<thead>
<th>Parameter</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td><code>autoscaling.knative.dev/minScale</code></td>
<td>Enter the minimum number of pods that you want to run in your cluster. Knative cannot scale down your app lower than the number that you set, even if no network traffic is received by your app. The default number of pods is zero.  </td>
</tr>
<tr>
<td><code>autoscaling.knative.dev/maxScale</code></td>
<td>Enter the maximum number of pods that you want to run in your cluster. Knative cannot scale up your app higher than the number that you set, even if you have more requests that your current app instances can handle. You can enter any number that you want up to the [maximum number of pods that you can run per worker node](/docs/containers?topic=containers-limitations#classic_limits).</td>
</tr>
</tbody>
</table>

### Scaling your app based on CPU usage or number of requests
{: #scale-cpu-vs-number-requests}

By default, Knative scales your app based on the average number of incoming requests per pod. If the number of concurrent requests exceeds the default setting of 100 requests per pod, Knative automatically creates another instance of your pod and starts load balancing incoming requests between your instances. This behavior is also referred to as concurrency or concurrent auto-scaling. You can change the default number of requests by [specifying the number of requests per pod](#max-request-per-pod). To instruct Knative to scale your app based on CPU usage instead, use the `autoscaling.knative.dev/metric` annotation.
{: shortdesc}

```yaml
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: myservice
spec:
  template:
    metadata:
       annotations:
         autoscaling.knative.dev/metric: cpu
         autoscaling.knative.dev/target: 80
    spec:
      containers:
      - image: <image_name>
....
```
{: codeblock}

<table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
<caption>Understanding the YAML file components</caption>
<col width="25%">
<thead>
<th>Parameter</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td><code>autoscaling.knative.dev/metric</code></td>
<td>Instruct Knative to scale your service instances based on CPU usage. By default, the CPU threshold is set to 80 percent. If your service instance exceeds this threshold, then new services instances are automatically created by Knative. If you do not set this annotation, your Knative service is scaled based on the average number of concurrent requests by default.   </td>
</tr>
  <tr>
    <td><code>autoscaling.knative.dev/target</code></td>
    <td>Enter the CPU threshold that your app must meet before Knative scales up your service instances. By default, the threshold is set to <code>80</code>, which scales up your service instances if your app uses 80 percent of the CPU. To change the default setting, enter the CPU threshold that you want. </td>
  </tr>
</tbody>
</table>


### Specifying the maximum number of requests per pod
{: #max-request-per-pod}

You can specify the maximum number of requests that an app instance can receive and process before Knative considers to scale up your app instances. For example, if you set the maximum number of requests to 1, then your app instance can receive one request at a time. If a second request arrives before the first one is fully processed, Knative scales up another instance. By default, Knative sets the maximum number of requests for a pod to 100.

```yaml
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: myservice
spec:
  template:
    spec:
      containers:
      - image: <image_name>
      containerConcurrency: 1
....
```
{: codeblock}

<table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
<caption>Understanding the YAML file components</caption>
<col width="25%">
<thead>
<th>Parameter</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td><code>containerConcurrency</code></td>
<td>Enter the maximum number of requests an app instance can receive at a time before Knative considers to scale up your app instances.  </td>
</tr>
</tbody>
</table>

### Changing the default container port
{: #knative-container-port}

By default, all incoming requests to your Knative service are sent to port 8080. You can change this setting by using the `containerPort` specification.
{: shortdesc}

```yaml
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: ...
spec:
  template:
    spec:
      containers:
        - image: <image_name>
          ports:
          - containerPort: <container_port>
```
{: codeblock}

### Changing the `scale-to-zero-grace-period`
{: #knative-idle-time}

Change the default time that your Knative service instance does not receive any requests before Knative scales down your service to zero instances.
{: shortdesc}

Knative uses the `config-autoscaler` config map in the `knative-serving` namespace to determine the amount of time to wait before a stable Knative service is considered `idle` and can be scaled down to zero instances. This time is also referred to as the `scale-to-zero-grace-period`.  By default, the grace period is set to 30 seconds. However, before Knative starts counting down the seconds, the service must be considered stable for 60 seconds (`stable-window`). For example, if requests are stopped to your app, your Knative service instance is still up for the next 90 seconds (60s `stable window` + 30s `scale-to-zero-grace-period`) before Knative scales down your service to zero instances.

If you do not want Knative to scale down your service to zero instances, set the [minimum number of pods](#knative-min-max-pods) to 1.
{: tip}

1. Open the `config-autoscaler` config map in the `knative-serving` namespace of your cluster. The config map opens in the `vi` editor.
   ```
   kubectl edit configmap config-autoscaler -n knative-serving
   ```
   {: pre}

2. Change the default value for the `scale-to-zero-grace-period`. The new value must be configured in seconds (`s`).
   ```
   scale-to-zero-grace-period: "60s"
   ```
   {: codeblock}

3. Optional. To also change the time that your service must be considered stable, update the `stable-window` property. The new value must be configured in seconds (`s`).  
   ```
   stable-window: "90s"
   ```
   {: codeblock}

4. Save your changes to the config map and close the `vi` editor. Your changes are automatically applied to existing and new Knative services.

### Creating private-only serverless apps
{: #knative-private-only}

By default, every Knative service is assigned a public route from your Istio Ingress subdomain and a private route in the format `<service_name>.<namespace>.cluster.local`. You can use the public route to access your app from the public network. If you want to keep your service private, you can add the `serving.knative.dev/visibility` label to your Knative service. This label instructs Knative to assign a private hostname to your service only.
{: shortdesc}

```yaml
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: myservice
  labels:
    serving.knative.dev/visibility: cluster-local
spec:
  template:
    spec:
      containers:
      - image: <image_name>
...
```
{: codeblock}

<table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
<caption>Understanding the YAML file components</caption>
<col width="25%">
<thead>
<th>Parameter</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td><code>serving.knative.dev/visibility</code></td>
  <td>If you add the <code>serving.knative.dev/visibility: cluster-local</code> label, your service is assigned only a private route in the format <code>&lt;service_name&gt;.&lt;namespace&gt;.cluster.local</code>. You can use the private hostname to access your service from within the cluster, but you cannot access your service from the public network.  </td>
</tr>
</tbody>
</table>

### Forcing the Knative service to repull a container image
{: #knative-repull-image}

The current implementation of Knative does not provide a standard way to force your Knative `Serving` component to repull a container image. To repull an image from your registry, choose between the following options:

- **Modify the Knative service `template`**: The `template` of a Knative service is used to create a revision of your Knative service. If you modify this template and for example, add the `repullFlag` annotation, Knative must create a new revision for your app. As part of creating the revision, Knative must check for container image updates. When you set `imagePullPolicy: Always`, Knative cannot use the image cache in the cluster, but instead must pull the image from your container registry.

   ```yaml
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: <service_name>
   spec:
     template:
       metadata:
         annotations:
           repullFlag: 123
       spec:
         containers:
         - image: <image_name>
           imagePullPolicy: Always
    ```
    {: codeblock}

    You must change the `repullFlag` value every time that you want to create a new revision of your service that pulls the latest image version from your container registry. Make sure that you use a unique value for each revision to avoid that Knative uses an old image version because of two identical Knative service configurations.  
    {: note}

- **Use tags to create unique container images**: You can use unique tags for every container image that you create and reference this image in your Knative service `container.image` configuration. In the following example, `v1` is used as the image tag. To force Knative to pull a new image from your container registry, you must change the image tag. For example, use `v2` as your new image tag.

  ```yaml
  apiVersion: serving.knative.dev/v1alpha1
  kind: Service
  metadata:
    name: <service_name>
  spec:
    template:
      spec:
        containers:
        - image: myapp:v1
          imagePullPolicy: Always
  ```
  {: codeblock}

## Related links  
{: #knative-related-links}

- Try out this [Knative workshop](https://github.com/IBM/knative101/tree/master/workshop){: external} to deploy your first `Node.js` fibonacci app to your cluster.
  - Explore how to use the Knative `Build` primitive to build an image from a Dockerfile in GitHub and automatically push the image to your namespace in {{site.data.keyword.registrylong_notm}}.  
  - Learn how you can set up routing for network traffic from the IBM-provided Ingress subdomain to the Istio Ingress gateway that is provided by Knative.
  - Roll out a new version of your app and use Istio to control the amount of traffic that is routed to each app version.
- Explore [Knative `Eventing`](https://github.com/knative/docs/tree/master/docs/eventing/samples){: external} samples.
- Learn more about Knative with the [Knative documentation](https://github.com/knative/docs){: external}.
