---

copyright:
  years: 2014, 2019
lastupdated: "2019-02-13"

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


# Tutorial: Using managed Knative to run serverless apps in Kubernetes clusters
{: #knative_tutorial}

With this tutorial, you can learn how to install Knative in a Kubernetes cluster in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

**What is Knative and why should I use it?**</br>
[Knative](https://github.com/knative/docs) is an open source platform that was developed by IBM, Google, Pivotal, Red Hat, Cisco, and others with the target to extend the capabilities of Kubernetes to help you create modern, source-centric containerized and serverless apps on top of your Kubernetes cluster. The platform is designed to address the needs of developers who today must decide what type of app they want to run in the cloud: 12-factor apps, containers, or functions. Each type of app requires an open source or proprietary solution that is tailored to these apps: Cloud Foundry for 12-factor apps, Kubernetes for containers, and OpenWhisk, and others for functions. In the past, developers had to decide what approach they wanted to follow, which led to inflexibility and complexity when different types of apps had to be combined.  

Knative uses a consistent approach across programming languages and frameworks to abstract the operational overhead of building, deploying and managing workloads in Kubernetes so that developers can focus on what matters most to them: the source code. You can use proven build packs that you are already familiar with, such as Cloud Foundry, Kaniko, Dockerfile, Bazel, and others. By integrating with Istio, Knative ensures that your serverless and containerized workloads can be easily exposed on the internet, monitored, and controlled, and that your data is encrypted during transit.

**How does Knative work?**</br>
Knative comes with 3 key components, or _primitives_, that help you to build, deploy, and manage your serverless apps in your Kubernetes cluster:

- **Build:** The `Build` primitive supports creating a set of steps to build your app from source code to a container image. Imagine using a simple build template where you specify the source repo to find your app code and the container registry where you want to host the image. With just a single command, you can instruct Knative to take this build template, pull the source code, create the image and push the image to your container registry so that you can use the image in your container.
- **Serving:** The `Serving` primitive helps to deploy serverless apps as Knative services and to automatically scale them, even down to zero instances. By using the traffic management and intelligent routing capabilities of Istio, you can control what traffic is routed to a specific version of your service which makes it easy for a developer to test and roll out a new app version or do A-B testing.
- **Eventing:** With the `Eventing` primitive, you can create triggers or event streams that other services can subscribe to. For example, you might want to kick off a new build of your app every time code is pushed to your GitHub master repo. Or you want to run a serverless app only if the temperature drops below freezing point. The `Eventing` primitive can be integrated into your CI/CD pipeline to automate the build and deployment of apps in case a specific event occurs.

**What is the Managed Knative on {{site.data.keyword.containerlong_notm}} (experimental) add-on?** </br>
Managed Knative on {{site.data.keyword.containerlong_notm}} is a managed add-on that integrates Knative and Istio directly with your Kubernetes cluster. The Knative and Istio version in the add-on are tested by IBM and supported for the use in {{site.data.keyword.containerlong_notm}}. {{site.data.keyword.containerlong_notm}} keeps the Knative and Istio components up-to-date by automatically rolling out updates for your add-on. 

Sounds good? Follow this tutorial to get started with Knative in {{site.data.keyword.containerlong_notm}}.

## Objectives
{: #knative_objectives}

- Learn the basics about Knative and the Knative primitives.  
- Install the managed Knative and managed Istio add-on in your cluster.
- Deploy your first serverless app with Knative and expose the app on the internet by using the Knative `Serving` primitive.
- Explore the Knative scaling and revision capabilities.

## Time required
{: #knative_time}

30 minutes

## Audience
{: #knative_audience}

This tutorial is designed for developers who are interested in learning how to use Knative to deploy a serverless app in a Kubernetes cluster, and for cluster admins who want to learn how to set up Knative in a cluster.

## Prerequisites
{: #knative_prerequisites}

-  [Install the IBM Cloud CLI, the {{site.data.keyword.containerlong_notm}} plug-in, and the Kubernetes CLI](/docs/containers/cs_cli_install.html#cs_cli_install_steps). Make sure to install the `kubectl` CLI version that matches the Kubernetes version of your cluster.
-  [Create a cluster with at least 3 worker nodes that each have 4 cores and 16 GB memory (`b2c.4x16`) or more](/docs/containers/cs_clusters.html#clusters_cli). Every worker node must run Kubernetes version 1.11 or higher.
-  Ensure you have the [**Writer** or **Manager** {{site.data.keyword.Bluemix_notm}} IAM service role](/docs/containers/cs_users.html#platform) for {{site.data.keyword.containerlong_notm}}.
-  [Target the CLI to your cluster](/docs/containers/cs_cli_install.html#cs_cli_configure).

## Lesson 1: Setting up the managed Knative add-on
{: #knative_setup}

Knative builds on top of Istio to ensure that your serverless and containerized workloads can be exposed within the cluster and on the internet. With Istio, you can also monitor and control network traffic between your services and ensure that your data is encrypted during transit. When you install the managed Knative add-on, the managed Istio add-on is automatically installed as well. 
{: shortdesc}

1. Enable the managed Knative add-on in your cluster. When you enable Knative in your cluster, Istio and all Knative components are installed in your cluster.
   ```
   ibmcloud ks cluster-addon-enable knative --cluster <cluster_name_or_ID>
   ```
   {: pre}

   Example output:
   ```
   The istio add-on is required to enable the knative add-on. Enable istio? [y/N]> y
   OK
   ```
   {: screen}

   The installation of all Knative components might take a few minutes to complete.

2. Verify that Istio is successfully installed. All pods for the 9 Istio services and the pod for Prometheus must be in a `Running` status.
   ```
   kubectl get pods --namespace istio-system
   ```
   {: pre}

   Example output:
   ```
   NAME                                       READY     STATUS      RESTARTS   AGE
   istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
   istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
   istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
   istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
   istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
   istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
   istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
   istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
   istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
   prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
   ```
   {: screen}

3. Verify that all Knative components are successfully installed.
   1. Verify that all pods of the Knative `Serving` component are in a `Running` state.  
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

   2. Verify that all pods of the Knative `Build` component are in a `Running` state.  
      ```
      kubectl get pods --namespace knative-build
      ```
      {: pre}

      Example output:
      ```
      NAME                                READY     STATUS    RESTARTS   AGE
      build-controller-79cb969d89-kdn2b   1/1       Running   0          21m
      build-webhook-58d685fc58-twwc4      1/1       Running   0          21m
      ```
      {: screen}

   3. Verify that all pods of the Knative `Eventing` component are in a `Running` state.
      ```
      kubectl get pods --namespace knative-eventing
      ```
      {: pre}

      Example output:

      ```
      NAME                                            READY     STATUS    RESTARTS   AGE
      eventing-controller-847d8cf969-kxjtm            1/1       Running   0          22m
      in-memory-channel-controller-59dd7cfb5b-846mn   1/1       Running   0          22m
      in-memory-channel-dispatcher-67f7497fc-dgbrb    2/2       Running   1          22m
      webhook-7cfff8d86d-vjnqq                        1/1       Running   0          22m
      ```
      {: screen}

   4. Verify that all pods of the Knative `Sources` component are in a `Running` state.
      ```
      kubectl get pods --namespace knative-sources
      ```
      {: pre}

      Example output:
      ```
      NAME                   READY     STATUS    RESTARTS   AGE
      controller-manager-0   1/1       Running   0          22m
      ```
      {: screen}

   5. Verify that all pods of the Knative `Monitoring` component are in a `Running` state.
      ```
      kubectl get pods --namespace knative-monitoring
      ```
      {: pre}

      Example output:
      ```
      NAME                                  READY     STATUS                 RESTARTS   AGE
      elasticsearch-logging-0               1/1       Running                0          22m
      elasticsearch-logging-1               1/1       Running                0          21m
      grafana-79cf95cc7-mw42v               1/1       Running                0          21m
      kibana-logging-7f7b9698bc-m7v6r       1/1       Running                0          22m
      kube-state-metrics-768dfff9c5-fmkkr   4/4       Running                0          21m
      node-exporter-dzlp9                   2/2       Running                0          22m
      node-exporter-hp6gv                   2/2       Running                0          22m
      node-exporter-hr6vs                   2/2       Running                0          22m
      prometheus-system-0                   1/1       Running                0          21m
      prometheus-system-1                   1/1       Running                0          21m
      ```
      {: screen}

Great! With Knative and Istio all set up, you can now deploy your first serverless app to your cluster.

## Lesson 2: Deploy a serverless app to your cluster
{: #deploy_app}

In this lesson, you deploy your first serverless [`Hello World`](https://hub.docker.com/r/ibmcom/kn-helloworld) app in Go. When you send a request to your sample app, the app reads the environment variable `TARGET` and prints `"Hello ${TARGET}!"`. If this environment variable is empty, `"Hello World!"` is returned.
{: shortdesc}

1. Create a YAML file for your first serverless `Hello World` app in Knative. To deploy an app with Knative, you must specify a Knative Service resource. A service is managed by the Knative `Serving` primitive and is responsible to manage the entire lifecycle of the workload. The service ensures that each deployment has a Knative revision, a route, and a configuration. When you update the service, a new version of the app is created and added to the revision history of the service. Knative routes ensure that each revision of the app is mapped to a network endpoint so that you can control how much network traffic is routed to a specific revision. Knative configurations hold the settings of a specific revision so that you can always rollback to an older revision or switch between revisions. For more information about Knative `Serving` resources, see the [Knative documentation](https://github.com/knative/docs/tree/master/serving).
   ```
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     runLatest:
       configuration:
         revisionTemplate:
           spec:
             container:
               image: docker.io/ibmcom/kn-helloworld
               env:
               - name: TARGET
                 value: "Go Sample v1"
    ```
    {: codeblock}

    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata.name</code></td>
    <td>The name of your Knative service.</td>
    </tr>
    <tr>
    <td><code>metadata.namespace</td>
    <td>The Kubernetes namespace where you want to deploy your app as a Knative service. </td>
    </tr>
    <tr>
    <td><code>spec.container.image</code></td>
    <td>The URL to the container registry where your image is stored. In this example, you deploy a Knative Hello World app that is stored in the <code>ibmcom</code> namespace in Docker Hub. </td>
    </tr>
    <tr>
    <td><code>spec.container.env</code></td>
    <td>A list of environment variables that you want your Knative service to have. In this example, the value of the environment variable <code>TARGET</code> is read by the sample app and returned when you send a request to your app in the format <code>"Hello ${TARGET}!"</code>. If no value is provided, the sample app returns <code>"Hello World!"</code>.  </td>
    </tr>
    </tbody>
    </table>

2. Create the Knative service in your cluster. When you create the service, the Knative `Serving` primitive creates an immutable revision, a Knative route, an Ingress routing rule, a Kubernetes service, a Kubernetes pod and a load balancer for your app. Your app is assigned a domain name in the format `<knative_service_name>.<namespace>.example.com` that you can use to access the app from the internet.
   ```
   kubectl apply -f service.yaml
   ```
   {: pre}

   Example output:
   ```
   service.serving.knative.dev "kn-helloworld" created
   ```
   {: screen}

3. Verify that your pod is created. Your pod consists of three containers. One container runs your `Hello World` app and the other two containers are side cars that run Istio and Knative monitoring and logging tools. Your pod is assigned a `00001` revision number.
   ```
   kubectl get pods
   ```

   Example output:
   ```
   NAME                                              READY     STATUS    RESTARTS   AGE
   kn-helloworld-00001-deployment-55db6bf4c5-2vftm   3/3       Running   0          16s
   ```
   {: screen}

4. Try out your `Hello World` app.
   1. Get the **EXTERNAL-IP** address of the Istio Ingress gateway.
      ```
      kubectl get svc istio-ingressgateway --namespace istio-system
      ```
      {: pre}

      Example output:
      ```
      NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)                                                                                                                   AGE
      istio-ingressgateway   LoadBalancer   172.21.xxx.xxx  169.xx.xxx.xxx   80:31380/TCP,443:31390/TCP,31400:31400/TCP,15011:31886/TCP,8060:32656/TCP,853:31265/TCP,15030:30719/TCP,15031:31936/TCP   3d
      ```
      {: screen}

   2. Get the **DOMAIN** name that Knative assigned to your app.
      ```
      kubectl get ksvc kn-helloworld --output=custom-columns=NAME:.metadata.name,DOMAIN:.status.domain
      ```
      {: pre}

      Example output:
      ```
      NAME            DOMAIN
      kn-helloworld   kn-helloworld.default.example.com
      ```
      {: screen}

   3. Make a request to your app. Replace `<external_IP>` with the external IP address of your Istio Ingress gateway that you retrieved earlier. If you changed the default name of your service, enter the domain name that was assigned to your service.
      ```
      curl -H "Host: kn-helloworld.default.example.com" http://<external_IP>
      ```
      {: pre}

      Example output:
      ```
      Hello Go Sample v1!
      ```
      {: screen}

5. Wait a few minutes to let Knative scale down your pod. Knative evaluates the number of pods that must be up at a time to process incoming workload. If no network traffic is received, Knative automatically scales down your pods, even to zero pods as shown in this example.

   Want to see how Knative scales up your pods? Try to increase workload for your app, for example by using tools like the [Simple cloud-based load tester](https://loader.io/).
   {: tip}
   ```
   kubectl get pods
   ```
   {: pre}

   If you do not see any `kn-helloworld` pods, Knative scaled down your app to zero pods.

6. Update your Knative service sample and enter a different value for the `TARGET` environment variable.

   Example service YAML:
   ```
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     runLatest:
       configuration:
         revisionTemplate:
           spec:
             container:
               image: docker.io/ibmcom/kn-helloworld
               env:
               - name: TARGET
                 value: "Mr. Smith"
    ```
    {: codeblock}

7. Apply the change to your service. When you change the configuration, Knative automatically creates a new revision, assigns a new route and by default instructs Istio to route incoming network traffic to the latest revision.
   ```
   kubectl apply -f service.yaml
   ```
   {: pre}

8. Make a new request to your app to verify that your change was applied.
   ```
   curl -H "Host: kn-helloworld.default.example.com" http://<public_IP>
   ```

   Example output:
   ```
   Hello Mr. Smith!
   ```
   {: screen}

9. Verify that Knative scaled up your pod again to account for the increased network traffic. Your pod is assigned a `00002` revision number. You can use the revision number to reference a specific version of your app, for example when you want to instruct Istio to split incoming traffic between the two revisions.
   ```
   kubectl get pods
   ```

   Example output:
   ```
   NAME                                              READY     STATUS    RESTARTS   AGE
   kn-helloworld-00002-deployment-55db6bf4c5-2vftm   3/3       Running   0          16s
   ```
   {: screen}

10. Optional: Clean up your Knative service.
    ```
    kubectl delete -f service.yaml
    ```
    {: pre}

Awesome! You successfully deployed your first Knative app to your cluster and explored the revision and scaling capabilities of the Knative `Serving` primitive.


## What's next?   
{: #whats-next}

- Try out this [Knative workshop ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/IBM/knative101/tree/master/workshop) to deploy your first `Node.js` fibonacci app to your cluster.
  - Explore how to use the Knative `Build` primitive to build an image from a Dockerfile in GitHub and automatically push the image to your namespace in {{site.data.keyword.registrylong_notm}}.  
  - Learn how you can set up routing for network traffic from the IBM-provided Ingress subdomain to the Istio Ingress gateway that is provided by Knative.
  - Roll out a new version of your app and use Istio to control the amount of traffic that is routed to each app version.
- Explore [Knative `Eventing` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/knative/docs/tree/master/eventing/samples) samples.
- Learn more about Knative with the [Knative documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/knative/docs).
