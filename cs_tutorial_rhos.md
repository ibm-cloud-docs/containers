---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-05"

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
{:preview: .preview}

# Tutorial: Creating a Red Hat OpenShift on IBM Cloud cluster (beta)
{: #openshift_tutorial}

Red Hat OpenShift on IBM Cloud is available as a beta to test out OpenShift clusters. Not all the features of {{site.data.keyword.containerlong}} are available during the beta. Also, any OpenShift beta clusters that you create remain for only 30 days after the beta ends and Red Hat OpenShift on IBM Cloud becomes generally available.
{: preview}

With the **Red Hat OpenShift on IBM Cloud beta**, you can create {{site.data.keyword.containerlong_notm}} clusters with worker nodes that come installed with the OpenShift container orchestration platform software. You get all the [advantages of managed {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-responsibilities_iks) for your cluster infrastructure environment, while using the [OpenShift tooling and catalog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.openshift.com/container-platform/3.11/welcome/index.html) that runs on Red Hat Enterprise Linux for your app deployments. OpenShift worker nodes are available for standard clusters only.
{: shortdesc}

## Objectives
{: #openshift_objectives}

In the tutorial lessons, you create a standard Red Hat OpenShift on IBM Cloud cluster, open the OpenShift console, access built-in OpenShift components, deploy an app that uses {{site.data.keyword.Bluemix_notm}} services in an OpenShift project, and expose the app on an OpenShift route so that external users can access the service.
{: shortdesc}

This page also includes information on the OpenShift cluster architecture, beta limitations, and how to give feedback and get support.

## Time required
{: #openshift_time}
45 minutes

## Audience
{: #openshift_audience}

This tutorial is for cluster administrators who want to learn how to create a Red Hat OpenShift on IBM Cloud cluster for the first time.
{: shortdesc}

## Prerequisites
{: #openshift_prereqs}

*   Ensure that you have the following {{site.data.keyword.Bluemix_notm}} IAM access policies.
    *   The [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}
    *   The [**Writer** or **Manager** service role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}
    *   The [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.registrylong_notm}}
*    Make sure that the [API key](/docs/containers?topic=containers-users#api_key) for the {{site.data.keyword.Bluemix_notm}} region and resource group is set up with the correct infrastructure permissions, **Super User** or the [minimum roles](/docs/containers?topic=containers-access_reference#infra) to create a cluster.
*   Install the command line tools.
    *   [Install the {{site.data.keyword.Bluemix_notm}} CLI (`ibmcloud`), {{site.data.keyword.containershort_notm}} plug-in (`ibmcloud ks`), and {{site.data.keyword.registryshort_notm}} plug-in (`ibmcloud cr`)](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps).
    *   [Install the OpenShift Origin (`oc`) and Kubernetes (`kubectl`) CLIs](/docs/containers?topic=containers-cs_cli_install#cli_oc).

<br />


## Architectural overview
{: #openshift_architecture}

The following diagram and table describe the default components that are set up in a Red Hat OpenShift on IBM Cloud architecture.
{: shortdesc}

![Red Hat OpenShift on IBM Cloud cluster architecture](images/cs_org_ov_both_ses_rhos.png)

| Master components| Description |
|:-----------------|:-----------------|
| Replicas | Master components including the OpenShift Kubernetes API server and etcd data store have 3 replicas and, if located in a multizone metro, are spread across zones for even higher availability. The master components are backed up every 8 hours.|
| rhos-api | The OpenShift Kubernetes API server serves as the main entry point for all cluster management requests from the worker node to the master. The API server validates and processes requests that change the state of Kubernetes resources, such as pods or services, and stores this state in the etcd data store.|
| openvpn-server | The OpenVPN server works with the OpenVPN client to securely connect the master to the worker node. This connection supports `apiserver proxy` calls to your pods and services, and `kubectl exec`, `attach`, and `logs` calls to the kubelet.|
| etcd | etcd is a highly available key value store that stores the state of all Kubernetes resources of a cluster, such as services, deployments, and pods. Data in etcd is backed up to an encrypted storage instance that IBM manages.|
| rhos-controller | The OpenShift controller manager watches for newly created pods and decides where to deploy them based on capacity, performance needs, policy constraints, anti-affinity specifications, and workload requirements. If no worker node can be found that matches the requirements, the pod is not deployed in the cluster. The controller also watches the state of cluster resources, such as replica sets. When the state of a resource changes, for example if a pod in a replica set goes down, the controller manager initiates correcting actions to achieve the required state. The `rhos-controller` functions as both the scheduler and controller manager in a native Kubernetes configuration. |
| cloud-controller-manager | The cloud controller manager manages cloud provider-specific components such as the {{site.data.keyword.Bluemix_notm}} load balancer.|
{: caption="Table 1. OpenShift master components." caption-side="top"}
{: #rhos-components-1}
{: tab-title="Master"}
{: tab-group="rhos-components"}
{: class="simple-tab-table"}

| Worker node components| Description |
|:-----------------|:-----------------|
| Operating System | Red Hat OpenShift on IBM Cloud worker nodes run on the Red Hat Enterprise Linux 7 (RHEL 7) operating system. |
| Projects | OpenShift organizes your resources into projects, which are Kubernetes namespaces with annotations, and includes many more components than native Kubernetes clusters to run OpenShift features such as the catalog. Select components of projects are described in the following rows. For more information, see [Projects and users ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/projects_and_users.html).|
| kube-system | This namespace includes many components that are used to run Kubernetes on the worker node.<ul><li>**`ibm-master-proxy`**: The `ibm-master-proxy` is a daemon set that forwards requests from the worker node to the IP addresses of the highly available master replicas. In single zone clusters, the master has three replicas on separate hosts. For clusters that are in a multizone-capable zone, the master has three replicas that are spread across zones. A highly available load balancer forwards requests to the master domain name to the master replicas.</li><li>**`openvpn-client`**: The OpenVPN client works with the OpenVPN server to securely connect the master to the worker node. This connection supports `apiserver proxy` calls to your pods and services, and `kubectl exec`, `attach`, and `logs` calls to the kubelet.</li><li>**`kubelet`**: The kubelet is a worker node agent that runs on every worker node and is responsible for monitoring the health of pods that run on the worker node and for watching the events that the Kubernetes API server sends. Based on the events, the kubelet creates or removes pods, ensures liveness and readiness probes, and reports back the status of the pods to the Kubernetes API server.</li><li>**`calico`**: Calico manages network policies for your cluster, and includes a few components to manage container network connectivity, IP address assignment, and network traffic control.</li><li>**Other components**: The `kube-system` namespace also includes components to manage IBM-provided resources such as storage plug-ins for file and block storage, ingress application load balancer (ALB), `fluentd` logging, and `keepalived`.</li></ul>|
| ibm-system | This namespace includes the `ibm-cloud-provider-ip` deployment that works with `keepalived` to provide health checking and Layer 4 load balancing for requests to app pods.|
| kube-proxy-and-dns| This namespace includes the components to validate incoming network traffic against the `iptables` rules that are set up on the worker node, and proxies requests that are allowed to enter or leave the cluster.|
| default | This namespace is used if you do not specify a namespace or create a project for your Kubernetes resources. In addition, the default namespace includes the following components to support your OpenShift clusters.<ul><li>**`router`**: OpenShift uses [routes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.openshift.com/container-platform/3.11/architecture/networking/routes.html) to expose an app's service on a host name so that external clients can reach the service. The router maps the service to the host name.</li><li>**`docker-registry`** and **`registry-console`**: OpenShift provides an internal [container image registry ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.openshift.com/container-platform/3.11/install_config/registry/index.html) that you can use to locally manage and view images through the console. Alternatively, you can set up the private {{site.data.keyword.registrylong_notm}}.</li></ul>|
| Other projects | Other components are installed in various namespaces by default to enable functionality such as logging, monitoring, and the OpenShift console.<ul><li>ibm-cert-store</li><li>kube-public</li><li>kube-service-catalog</li><li>openshift</li><li>openshift-ansible-service-broker</li><li>openshift-console</li><li>openshift-infra</li><li>openshift-monitoring</li><li>openshift-node</li><li>openshift-template-service-broker</li><li>openshift-web-console</li></ul>|
{: caption="Table 2. OpenShift worker node components." caption-side="top"}
{: #rhos-components-2}
{: tab-title="Worker nodes"}
{: tab-group="rhos-components"}
{: class="simple-tab-table"}

<br />


## Lesson 1: Creating a Red Hat OpenShift on IBM Cloud cluster
{: #openshift_create_cluster}

You can create a Red Hat OpenShift on IBM Cloud cluster in {{site.data.keyword.containerlong_notm}} by using the [console](#openshift_create_cluster_console) or [CLI](#openshift_create_cluster_cli). To learn about what components are set up when you create a cluster, see the [Architecture overview](#openshift_architecture). OpenShift is available for only standard clusters. You can learn more about the price of standard clusters in the [frequently asked questions](/docs/containers?topic=containers-faqs#charges).
{:shortdesc}

Any OpenShift clusters that you create during the beta remain for 30 days after the beta ends and Red Hat OpenShift on IBM Cloud becomes generally available.
{: important}

### Creating a cluster with the console
{: #openshift_create_cluster_console}

Create a standard OpenShift cluster in the {{site.data.keyword.containerlong_notm}} console.
{: shortdesc}

Before you begin, [complete the prerequisites](#openshift_prereqs) to make sure that you have the appropriate permissions to create a cluster.

1.  Create a cluster.
    1.  Log in to your [{{site.data.keyword.Bluemix_notm}} account ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/).
    2.  From the hamburger menu ![hamburger menu icon](../icons/icon_hamburger.svg "hamburger menu icon"), select **Kubernetes** and then click **Create cluster**.
    3.  Choose your cluster setup details and name. For the beta, OpenShift clusters are available only as standard clusters that are located in Washington, DC and London data centers.
        *   For **Select a plan**, choose **Standard**.
        *   For **Select an environment**, choose **Classic infrastructure**.
        *   For the **Location**, set the geography to **North America** or **Europe**, select either a **Single zone** or **Multizone** availability, and then select **Washington, DC** or **London** worker zones.
        *   For **Default worker pool**, select the **OpenShift** cluster version. Choose an available flavor for your worker nodes ideally with at least 4 Cores 16 GB RAM.
        *   Set a number of worker nodes to create per zone, such as 3.
    4.  To finish, click **Create cluster**.<p class="note">Your cluster creation might take some time to complete. After the cluster state shows **Normal**, the cluster network and load balancing components take about 10 more minutes to deploy and update the cluster domain that you use for the OpenShift web console and other routes. Wait until the cluster is ready before continuing to the next step by checking that the **Ingress subdomain** follows a pattern of `<cluster_name>.<region>.containers.appdomain.cloud`.</p>
2.  From the cluster details page, click **OpenShift web console**.
3.  From the dropdown menu in the OpenShift container platform menu bar, click **Application Console**. The Application Console lists all project namespaces in your cluster. You can navigate to a namespace to view your applications, builds, and other Kubernetes resources.
4.  To complete the next lesson by working in the terminal, click your profile **IAM#user.name@email.com > Copy Login Command**. Paste the copied `oc` login command into your terminal to authenticate via the CLI.

### Creating a cluster with the CLI
{: #openshift_create_cluster_cli}

Create a standard OpenShift cluster by using the {{site.data.keyword.Bluemix_notm}} CLI.
{: shortdesc}

Before you begin, [complete the prerequisites](#openshift_prereqs) to make sure that you have the appropriate permissions to create a cluster, the `ibmcloud` CLI and plug-ins, and the `oc` and `kubectl` CLIs.

1.  Log in to the account that you set up to create OpenShift clusters. Target the **us-east** or **eu-gb** region. If you have a federated account, include the `--sso` flag.
    ```
    ibmcloud login -r (us-east|eu-gb) [--sso]
    ```
    {: pre}
2.  Create a cluster.
    ```
    ibmcloud ks cluster-create --name <name> --location <zone> --kube-version <openshift_version> --machine-type <worker_node_flavor> --workers <number_of_worker_nodes_per_zone> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
    ```
    {: pre}

    Example command to create a cluster with 3 workers nodes that have 4 cores and 16 GB memory in Washington, DC.

    ```
    ibmcloud ks cluster-create --name my_openshift --location wdc04 --kube-version 3.11_openshift --machine-type b3c.4x16.encrypted  --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
    ```
    {: pre}

    <table summary="The first row in the table spans both columns. The rest of the rows should be read left to right, with the command component in column one and the matching description in column two.">
    <caption>cluster-create components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>The command to create a classic infrastructure cluster in your {{site.data.keyword.Bluemix_notm}} account.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Enter a name for your cluster. The name must start with a letter, can contain letters, numbers, and hyphen (-), and must be 35 characters or fewer. Use a name that is unique across {{site.data.keyword.Bluemix_notm}} regions.</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;zone&gt;</em></code></td>
    <td>Specify the zone where you want to create your cluster. For the beta, available zones are `wdc04, wdc06, wdc07, lon04, lon05,` or `lon06`.</p></td>
    </tr>
    <tr>
      <td><code>--kube-version <em>&lt;openshift_version&gt;</em></code></td>
      <td>You must choose a supported OpenShift version. OpenShift versions include a Kubernetes version that differs from the Kubernetes versions that are available on native Kubernetes Ubuntu clusters. To list available OpenShift versions, run `ibmcloud ks versions`. To create a cluster with the latest the patch version, you can specify just the major and minor version, such as ` 3.11_openshift`.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;worker_node_flavor&gt;</em></code></td>
    <td>Choose a machine type. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual machines types vary by the zone in which you deploy the cluster. To list available machine-types, run `ibmcloud ks machine-types --zone <zone>`.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number_of_worker_nodes_per_zone&gt;</em></code></td>
    <td>The number of worker nodes to include in the cluster. You might want to specify at least 3 worker nodes so that your cluster has enough resources to run the default components and for high availability. If the <code>--workers</code> option is not specified, 1 worker node is created.</td>
    </tr>
    <tr>
    <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
    <td>If you already have a public VLAN set up in your IBM Cloud infrastructure (SoftLayer) account for that zone, enter the ID of the public VLAN. To check available VLANs, run `ibmcloud ks vlans --zone <zone>`. <br><br>If you do not have a public VLAN in your account, do not specify this option. {{site.data.keyword.containerlong_notm}} automatically creates a public VLAN for you.</td>
    </tr>
    <tr>
    <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
    <td>If you already have a private VLAN set up in your IBM Cloud infrastructure (SoftLayer) account for that zone, enter the ID of the private VLAN. To check available VLANs, run `ibmcloud ks vlans --zone <zone>`. <br><br>If you do not have a private VLAN in your account, do not specify this option. {{site.data.keyword.containerlong_notm}} automatically creates a private VLAN for you.</td>
    </tr>
    </tbody></table>
3.  List your cluster details. Review the cluster **State**, check the **Ingress Subdomain**, and note the **Master URL**.<p class="note">Your cluster creation might take some time to complete. After the cluster state shows **Normal**, the cluster network and load balancing components take about 10 more minutes to deploy and update the cluster domain that you use for the OpenShift web console and other routes. Wait until the cluster is ready before continuing to the next step by checking that the **Ingress Subdomain** follows a pattern of `<cluster_name>.<region>.containers.appdomain.cloud`.</p>
    ```
    ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
    ```
    {: pre}
4.  Download the configuration files to connect to your cluster.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
    ```
    {: pre}

    When the download of the configuration files is finished, a command is displayed that you can copy and paste to set the path to the local Kubernetes configuration file as an environment variable.

    Example for OS X:

    ```
    export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-<datacenter>-<cluster_name>.yml
    ```
    {: screen}
5.  In your browser, navigate to the address of your **Master URL** and append `/console`. For example, `https://c0.containers.cloud.ibm.com:23652/console`.
6.  Click your profile **IAM#user.name@email.com > Copy Login Command**. Paste the copied `oc` login command into your terminal to authenticate via the CLI.<p class="tip">Save your cluster master URL to access the OpenShift console later. In future sessions, you can skip the `cluster-config` step and copy the login command from the console instead.</p>
7.  Verify that the `oc` commands run properly with your cluster by checking the version.

    ```
    oc version
    ```
    {: pre}

    Example output:

    ```
    oc v3.11.0+0cbc58b
    kubernetes v1.11.0+d4cacc0
    features: Basic-Auth

    Server https://c0.containers.cloud.ibm.com:23652
    openshift v3.11.98
    kubernetes v1.11.0+d4cacc0
    ```
    {: screen}

    If you cannot perform operations that require Administrator permissions, such as listing all the worker nodes or pods in a cluster, download the TLS certificates and permission files for the cluster administrator by running the `ibmcloud ks cluster-config --cluster <cluster_name_or_ID> --admin` command.
    {: tip}

<br />


## Lesson 2: Accessing built-in OpenShift services
{: #openshift_access_oc_services}

Red Hat OpenShift on IBM Cloud comes with built-in services that you can use to help operate your cluster, such as the OpenShift console, Prometheus, and Grafana. For the beta, to access these services, you can use the local host of a [route ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.openshift.com/container-platform/3.11/architecture/networking/routes.html).
{:shortdesc}

1.  After logging in to your cluster through your terminal, verify that your router is deployed. The router functions as the ingress point for external traffic to make the services in your cluster publicly available on its external IP address through a route. The router listens on the host network interface, unlike your app pods that listen only on private IPs. The router proxies external requests for route host names to the IPs of the app pods that are identified by the service that you associated with the route host name.
    ```
    oc get svc router -n default
    ```
    {: pre}

    Example output:
    ```
    NAME      TYPE           CLUSTER-IP               EXTERNAL-IP     PORT(S)                      AGE
    router    LoadBalancer   172.21.xxx.xxx   169.xx.xxx.xxx   80:30399/TCP,443:32651/TCP                      5h
    ```
    {: screen}
2.  Get the **Host/Port** host name of the service route that you want to access. For example, you might want to access your Grafana dashboard to check metrics on your cluster's resource usage. The default route domain names follow a cluster-specific pattern of `<router_service_name>.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud`.
    ```
    oc get route --all-namespaces
    ```
    {: pre}

    Example output:
    ```
    NAMESPACE                          NAME                HOST/PORT                                                                    PATH                  SERVICES            PORT               TERMINATION          WILDCARD
    default                            registry-console    registry-console-default.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud                              registry-console    registry-console   passthrough          None
    kube-service-catalog               apiserver           apiserver-kube-service-catalog.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud                        apiserver           secure             passthrough          None
    openshift-ansible-service-broker   asb-1338            asb-1338-openshift-ansible-service-broker.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud            asb                 1338               reencrypt            None
    openshift-console                  console             console.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud                                              console             https              reencrypt/Redirect   None
    openshift-monitoring               alertmanager-main   alertmanager-main-openshift-monitoring.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud                alertmanager-main   web                reencrypt            None
    openshift-monitoring               grafana             grafana-openshift-monitoring.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud                          grafana             https              reencrypt            None
    openshift-monitoring               prometheus-k8s      prometheus-k8s-openshift-monitoring.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud                   prometheus-k8s      web                reencrypt
    ```
    {: screen}
3.  In your web browser, open the route, for example: `https://grafana-openshift-monitoring.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud`. The first time that you access the host name, you might need to authenticate, such as by clicking **Log in with OpenShift** and authorizing access to your IAM identity.
4.  To open the internal registry console, you must update the provider URL so that you can access it externally.
    1.  Edit the `registry-console` deployment to be accessible through the public API endpoint of the cluster master URL by adding `-e` to the master URL.
        ```
        oc edit deploy registry-console -n default
        ```
        {: pre}
        
        In the `Pod Template.Containers.registry-console.Environment. OPENSHIFT_OAUTH_PROVIDER_URL` field, add `-e` after the `c1` such as in `https://c1-e.eu-gb.containers.cloud.ibm.com:20399`.
        ```
        Name:                   registry-console
        Namespace:              default
        ...
        Pod Template:
          Labels:  name=registry-console
          Containers:
           registry-console:
            Image:      registry.eu-gb.bluemix.net/armada-master/iksorigin-registry-console:v3.11.98-6
            ...
            Environment:
              OPENSHIFT_OAUTH_PROVIDER_URL:  https://c1-e.eu-gb.containers.cloud.ibm.com:20399
              ...
        ```
        {: screen}
    2.  In your web browser, open the registry console route that you retrieved in the previous step, for example: `https://registry-console-default.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud`.

Now you're in the built-in OpenShift app! For example, if you're in Grafana, you might check out your namespace CPU usage or other graphs.

<br />


## Lesson 3: Deploying an app to your OpenShift cluster
{: #openshift_deploy_app}

With Red Hat OpenShift on IBM Cloud, you can create a new app and expose your app service via an OpenShift router for external users to use.
{: shortdesc}

1.  Create a project for your Hello World app. A project is an OpenShift version of a Kubernetes namespace with additional annotations.
    ```
    oc new-project hello-world
    ```
    {: pre}
2.  Build the sample app [from the source code ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/IBM/container-service-getting-started-wt). With the OpenShift `new-app` command, you can refer to a directory in a remote repository that contains the Dockerfile and app code to build your image. The command builds the image, stores the image in the local Docker registry, and creates the app deployment configurations (`dc`) and services (`svc`). For more information on creating new apps, [see the OpenShift docs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.openshift.com/container-platform/3.11/dev_guide/application_lifecycle/new_app.html).
    ```
    oc new-app --name hello-world https://github.com/IBM/container-service-getting-started-wt --context-dir="Lab 1"
    ```
    {: pre}
3.  Verify that the sample Hello World app components are created.
    1.  Check for the **hello-world** image in the cluster's built-in Docker registry by accessing the registry console in your browser. Make sure that you updated the registry console provider URL with `-e` as described in the previous lesson.
        ```
        https://registry-console-default.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud/
        ```
        {: codeblock}
    2.  List the **hello-world** services and note the service name. Your app listens for traffic on these internal cluster IP addresses unless you create a route for the service so that the router can forward external traffic requests to the app.
        ```
        oc get svc -n hello-world
        ```
        {: pre}

        Example output:
        ```
        NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
        hello-world   ClusterIP   172.21.xxx.xxx   <nones>       8080/TCP   31m
        ```
        {: screen}
    3.  List the pods. Pods with `build` in the name are jobs that **Completed** as part of the new app build process. Make sure that the **hello-world** pod status is **Running**.
        ```
        oc get pods -n watson
        ```
        {: pre}

        Example output:
        ```
        NAME                READY     STATUS             RESTARTS   AGE
        hello-world-9cv7d   1/1       Running            0          30m
        hello-world-build   0/1       Completed          0          31m
        ```
        {: screen}
4.  Set up a route so that you can publicly access the {{site.data.keyword.toneanalyzershort}} service. By default, the host name is in the format of `<service_name>.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud`. If you want to customize the host name, include the `--hostname=<hostname>` flag.
    1.  Create a route for the **hello-world** service.
        ```
        oc create route edge --service=hello-world -n hello-world
        ```
        {: pre}
    2.  Get the route host name address from the **Host/Port** output.
        ```
        oc get route -n hello-world
        ```
        {: pre}
        Example output:
        ```
        NAME          HOST/PORT                         PATH                                        SERVICES      PORT       TERMINATION   WILDCARD
        hello-world   hello-world.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud    hello-world   8080-tcp   edge/Allow    None
        ```
        {: screen}
5.  Access your app.
    ```
    curl https://hello-world.<cluster_name>-<random_ID>.<region>.containers.appdomain.cloud
    ```
    {: pre}
    
    Example output:
    ```
    Hello world from hello-world-9cv7d! Your app is up and running in a cluster!
    ```
    {: screen}
6.  **Optional** To clean up the resources that you created in this lesson, you can use the labels that are assigned to each app.
    1.  List all the resources for each app in the `hello-world` project.
        ```
        oc get all -l app=hello-world -o name -n hello-world
        ```
        {: pre}
        Example output:
        ```
        pod/hello-world-1-dh2ff
        replicationcontroller/hello-world-1
        service/hello-world
        deploymentconfig.apps.openshift.io/hello-world
        buildconfig.build.openshift.io/hello-world
        build.build.openshift.io/hello-world-1
        imagestream.image.openshift.io/hello-world
        imagestream.image.openshift.io/node
        route.route.openshift.io/hello-world
        ```
        {: screen}
    2.  Delete all the resources that you created.
        ```
        oc delete all -l app=hello-world -n hello-world
        ```
        {: pre}



<br />


## Limitations
{: #openshift_limitations}

The Red Hat OpenShift on IBM Cloud beta is released with the following limitations.
{: shortdesc}

**Cluster**:
*   You can create only standard clusters, not free clusters.
*   Locations are available in two multizone metro areas, Washington, DC and London. Supported zones are `wdc04, wdc06, wdc07, lon04, lon05,` and `lon06`.
*   You cannot create a cluster with worker nodes that run multiple operating systems, such as OpenShift on Red Hat Enterprise Linux and native Kubernetes on Ubuntu.
*   The [cluster autoscaler](/docs/containers?topic=containers-ca) is not supported because it requires Kubernetes version 1.12 or later. OpenShift 3.11 includes only Kubernetes version 1.11.



**Storage**:
*   {{site.data.keyword.Bluemix_notm}} file, block, and cloud object storage are supported. Portworx software-defined storage (SDS) is not supported.
*   Because of the way that {{site.data.keyword.Bluemix_notm}} NFS file storage configures Linux user permissions, you might encounter errors when you use file storage. If so, you might need to configure [OpenShift Security Context Contraints ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_scc.html) or use a different storage type.

**Networking**:
*   Calico is used as the networking policy provider instead of OpenShift SDN.

**Add-ons, integrations, and other services**:
*   {{site.data.keyword.containerlong_notm}} add-ons such as Istio, Knative, and the Kubernetes terminal are not available.
*   Helm charts are not certified to work in OpenShift clusters, except {{site.data.keyword.Bluemix_notm}} Object Storage.
*   Clusters are not deployed with image pull secrets for {{site.data.keyword.registryshort_notm}} `icr.io` domains. You can [create your own image pull secrets](/docs/containers?topic=containers-images#other_registry_accounts), or instead use the built-in Docker registry for OpenShift clusters.

**Apps**:
*   OpenShift sets up stricter security settings by default than native Kubernetes. For more information, see the OpenShift docs for [Managing Security Context Contraints (SCC) ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_scc.html).
*   For example, apps that are configured to run as root might fail, with the pods in a `CrashLoopBackOff` status. To resolve this issue, you can either modify the default security context constraints or use an image that does not run as root.
*   OpenShift are set up by default with a local Docker registry. If you want to use images that are stored in your remote private {{site.data.keyword.registrylong_notm}} `icr.io` domain names, you must create the secrets for each global and regional registry yourself. You can use the `ibmcloud ks cluster-pull-secret-apply` command to [create the secret in the `default` namespace](/docs/containers?topic=containers-images#imagePullSecret_migrate_api_key), and then [copy this secret](/docs/containers?topic=containers-images#copy_imagePullSecret) or [create your own secret](/docs/containers?topic=containers-images#other_registry_accounts) for each namespace that you want to build containers from images that are stored in `icr.io` registries.
*   The OpenShift console is used instead of the Kubernetes dashboard.

<br />


## What's next?
{: #openshift_next}

For more information about working with your apps and routing services, see the [OpenShift Developer Guide](https://docs.openshift.com/container-platform/3.11/dev_guide/index.html).

<br />


## Feedback and questions
{: #openshift_support}

During the beta, Red Hat OpenShift on IBM Cloud clusters are not covered by IBM Support nor Red Hat Support. Any support that is provided is to help you evaluate the product in preparation for its general availability.
{: important}

For any questions or feedback, post in Slack. 
*   If you are an external user, post in the [#openshift ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-container-service.slack.com/messages/CKCJLJCH4) channel. 
*   If you are an IBMer, use the [#iks-openshift-users ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-argonauts.slack.com/messages/CJH0UPN2D) channel.

If you do not use an IBMid for your {{site.data.keyword.Bluemix_notm}} account, [request an invitation](https://bxcs-slack-invite.mybluemix.net/) to this Slack.
{: tip}
