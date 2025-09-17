---

copyright:
  years: 2022, 2025
lastupdated: "2025-09-17"


keywords: ingress, alb, manage albs, update, alb image

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Managing ALBs
{: #ingress-alb-manage}

Manage the Ingress ALBs in your cluster to ensure that traffic flows uninterrupted.
{: shortdesc}

## Updating ALBs
{: #alb-update}

{{site.data.keyword.containerlong_notm}} regularly releases ALB versions to provide new functionality and to address security vulnerabilities. Use the [`ibmcloud ks ingress alb versions`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_versions) command to list the available versions, or review the [Ingress ALB version change log](/docs/containers?topic=containers-cl-ingress-alb) for the version history.

The ALB version follows the `<ingress_nginx_version>_<ibm_build>_iks` format, where `<ingress_nginx_version>` denotes the version of the [Kubernetes Ingress NGINX Controller](https://github.com/kubernetes/ingress-nginx) and the `<ibm_build>` number indicates the {{site.data.keyword.containerlong_notm}} build version.

ALBs can be updated to the default version automatically, or you can choose to disable automatic updates and manage ALB versions manually.
{: shortdesc}

### Enabling automatic updates
{: #autoupdate}

When you enable automatic updates, your ALBs are updated to the version that is marked as the default. When a newer version becomes the default version, your ALBs are automatically updated to that version.
{: shortdesc}

If only one worker node exists in a zone in your cluster, and you set the number of ALB replicas to 1, this single ALB pod is deleted and a new pod is created whenever updates are applied. This process might cause traffic disruptions even if you have worker nodes and ALB replicas in other zones. To prevent traffic disruptions, ensure that at least two worker nodes exist in each zone, and that [two replicas exist for each ALB](#alb_replicas). Note that during the update process, only new connections are routed to the second ALB pod; existing connections on the updating ALB pod are safely terminated. For existing connections that are terminated during the update, initiate a retry in client applications.
{: important}


### Scheduling maintenance windows for automatic updates
{: #alb-scheduled-updates}

You can control and manage automatic ALB updates by creating a customized ConfigMap that specifies the time you want the updates.
{: shortdesc}

To set a time for automatic updates, you set the `updateStartTime` and `updateEndTime` keys in the deployment ConfigMap. Each key represents an assigned time in a 24 hour format (HH:MM). Note that this time is specified in coordinated universal time (UTC) rather than your local time.

1. Create a YAML file for your ConfigMap. Specify the `updateStartTime`, and `updateEndTime` fields as key-value pairs in the `data` field.

    The following example ConfigMap sets the automatic update function to update ALB pods in your cluster between 20:34 and 23:59 UTC.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
        name: ibm-ingress-deploy-config
        namespace: kube-system
    data:
        "updateStartTime": "20:34"
        "updateEndTime": "23:59"
    ```
    {: codeblock}

2. Deploy the ConfigMap in your cluster. The new rules apply the next time an update takes place.

    ```sh
    kubectl apply -f <filename>.yaml
    ```
    {: pre}


### Disabling automatic updates
{: #autoupdate_disable}

To receive bug fixes and security updates, keep automatic updates enabled. When automatic updates are disabled, you are responsible for updating your ALBs manually.
{: important}

You can disable automatic updates for your ALBs by running [`ibmcloud ks ingress alb autoupdate disable -c <cluster_name_or_ID>`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_enable).

To check if automatic updates are enabled for your cluster, use the [`ibmcloud ks ingress alb autoupdate get -c <cluster_name_or_ID>`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_get) command. If you decide to enable automatic updates again, you can run [`ibmcloud ks ingress alb autoupdate enable -c <cluster_name_or_ID>`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_disable).


### Applying manual updates
{: #update-alb}

You can manually apply a one-time update of your Ingress ALB pods with the `ibmcloud ks ingress alb update` command. This command applies the default ALB image version, but you can apply a different version by including the  `--version` option. For more information or command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_update).
{: shortdesc}

To update your ALB image to a specific version with the `--version` option, you must [disable automatic ALB updates](#autoupdate) and then keep them disabled for as long as you want to run the specified version. Automatic updates always apply the default version and overwrite any manual updates you apply. If you want to use a different version, you cannot enable automatic updates.
{: important}

* To list the available ALB versions, run the following command.

    ```sh
    ibmcloud ks ingress alb versions --region <region>
    ```
    {: pre}
    
* To update all ALB pods in the cluster, run the following command.

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID> --version <image_version>
    ```
    {: pre}

* To update the ALB for specific ALBs, run the following command.

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID> --version <image_version> --alb <ALB_ID> [--alb <ALB_2_ID> ...]
    ```
    {: pre}



## Choosing a supported image version
{: #alb-version-choose}

{{site.data.keyword.containerlong_notm}} supports only the Kubernetes Ingress image for the Ingress application load balancers (ALBs) in your cluster. The Kubernetes Ingress image is built on the community Kubernetes project's implementation of the NGINX Ingress controller. The previously supported {{site.data.keyword.containerlong_notm}} Ingress image, which was built on a custom implementation of the NGINX Ingress controller, is unsupported.
{: shortdesc}

**Clusters created on or after 01 December 2020**: Default application load balancers (ALBs) run the Kubernetes Ingress image in all new {{site.data.keyword.containerlong_notm}} clusters.

**Clusters created before 01 December 2020**:
* Existing clusters with ALBs that run the custom IBM Ingress image continue to operate as-is.
* Support for the custom IBM Ingress image ended on 02 June 2021.
* You must move to the new Kubernetes Ingress by migrating any existing Ingress setups. Your existing ALBs and other Ingress resources are not automatically migrated to the new Kubernetes Ingress image.
* Any ALBs with the unsupported image continue to run, but are not supported by IBM.

When you [create a new ALB](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_create), [enable an ALB](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure) that was previously disabled, or [manually update(#update-alb) an ALB], you can specify an image version for your ALB with the `--version` option. If you omit the `--version` option when you enable or update an existing ALB, the ALB runs the default version of the same image that the ALB previously ran; either the Kubernetes Ingress image or the {{site.data.keyword.containerlong_notm}} Ingress image.

Automatic updates only apply the default version. To specify a version other than the default, you must [disable automatic updates](#autoupdate) by running the [`ibmcloud ks ingress alb autoupdate disable`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_disable) command. 
{: note}

### Viewing supported image versions
{: #alb-version-list}

To list the latest three versions that are supported for each type of image, run the following command.
{: shortdesc}

```sh
ibmcloud ks ingress alb versions
```
{: pre}

Example output

```sh
Kubernetes Ingress versions
1.1.2_2507_iks (default)
1.2.1_2506_iks
0.35.0_1374_iks
```
{: screen}

The Kubernetes Ingress version follows the format `<community_version>_<ibm_build>_iks`. The IBM build number indicates the most recent build of the Kubernetes Ingress NGINX release that {{site.data.keyword.containerlong_notm}} released. For example, the version `1.1.2_2507_iks` indicates the most recent build of the `0.47.0` Ingress NGINX version. {{site.data.keyword.containerlong_notm}} might release builds of the community image version to address vulnerabilities.

For the changes that are in each version of the Ingress images, see the [Ingress version change log](/docs/containers?topic=containers-cl-ingress-alb).

### Reverting to an earlier version
{: #revert-alb-version}

If your ALB pods were recently updated, but a custom configuration for your ALBs is affected by the latest image version build, you can use the [`ibmcloud ks ingress alb update`](#update-alb) command with the `--version` option to roll back ALB pods to an earlier, supported version. The image version that you change your ALB to must be a supported image version that is listed in the output of `ibmcloud ks ingress alb versions`. 
{: shortdesc}

Note that if you revert to an earlier version, you must [disable automatic ALB updates](#autoupdate) and then keep them disabled for as long as you want to run the earlier version. Automatic updates always apply the latest version and overwrite any manual updates you apply. If you want to use an earlier version, you cannot enable automatic updates. 

## Manually scaling your ALBs
{: #scale_albs}

Each ALB can handle around 20,000 connections per second. If you need to process additional connections, you can create more ALBs in a zone or increase the number of ALB pod replicas.
{: shortdesc}

### Creating more ALBs in a zone
{: #create_alb}

Each ALB in a zone is deployed as two pods on different worker nodes. To scale up your ALB processing capabilities and handle more connections, you can create additional ALBs in a zone. The IP address of the new ALB is automatically added to your Ingress subdomain.
{: shortdesc}

When you create a multizone cluster, a default public ALB is created in each zone where you have worker nodes. If you later remove one of these original three zones and add workers in a different zone, a default public ALB is not created in that new zone. You can manually create an ALB to process connections in that new zone.
{: tip}

When using Ingress resource validation, every create and update request is validated by all ALBs. If no pods are running for a particular ALB instance, you might be unable to apply Ingress resources on your cluster. Make sure to have at least one running pod for each ALB in enabled state. For more information, see [Ingress deployment customization reference](/docs/containers?topic=containers-comm-ingress-annotations#create-ingress-configmap-custom).
{: note}

1. In each zone where you have worker nodes, create an ALB.

    The following command applies to **classic clusters**. For more information and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_create).

    ```sh
    ibmcloud ks ingress alb create --cluster <cluster_name_or_ID> --type <public_or_private> --zone <zone> --vlan <VLAN_ID> [--ip <IP_address>] [--version image_version]
    ```
    {: pre}

    The following command applies to **VPC clusters**. For more information and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cli_alb-create-vpc-gen2).

    ```sh
    ibmcloud ks ingress alb create vpc-gen2 --cluster <cluster_name_or_ID> --type <public_or_private> --zone <vpc_zone> [--version image_version]
    ```
    {: pre}


2. Verify that the ALBs that you created in each zone have a **Status** of `enabled`. For classic clusters, check that an **ALB IP** is assigned. For VPC clusters, check that **Load Balancer Hostname** is assigned.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a classic cluster.

    ```sh
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID   NLB Version
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal12   ingress:1.1.2_2507_iks   2294021       -
    private-crdf253b6025d64944ab99ed63bb4567b6-alb2   false     disabled   private   -               dal10   ingress:1.1.2_2507_iks   2234947       -
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.48.228.78   dal12   ingress:1.1.2_2507_iks   2294019       -
    public-crdf253b6025d64944ab99ed63bb4567b6-alb2    true      enabled    public    169.46.17.6     dal10   ingress:1.1.2_2507_iks   2234945       -
    ```
    {: screen}

    Example output for a VPC cluster.

    ```sh
    ALB ID                                            Enabled   Status     Type      Load Balancer Hostname                 Zone         Build
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -                                      us-south-2   ingress:1.1.2_2507_iks
    private-crdf253b6025d64944ab99ed63bb4567b6-alb2   false     disabled   private   -                                      us-south-1   ingress:1.1.2_2507_iks
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    23f2dfb1-us-south.lb.appdomain.cloud   us-south-2   ingress:1.1.2_2507_iks
    public-crdf253b6025d64944ab99ed63bb4567b6-alb2    true      enabled    public    23f2dfb1-us-south.lb.appdomain.cloud   us-south-1   ingress:1.1.2_2507_iks

    ```
    {: screen}


### Changing the number of ALB pod replicas
{: #alb_replicas}

By default, each ALB has 2 replicas. You can customize your ALB processing capabilities by manually changing the number of ALB pods or by enabling dynamic, automatic scaling. 
{: shortdesc}

A single ALB pod can handle a large amount of requests. If you experience timeouts, slow responses or other signs of overload, check the state of your backend application. Make sure that ALB is the bottleneck of your application before scaling ALB pods, otherwise it might not provide the expected results.

**For classic clusters**: If the ALB's load balancer service configuration has the `externalTrafficPolicy` set to `Local`, do not scale above 2 replicas. Classic load balancers run with a fixed configuration of 2 replicas, and can only forward traffic to ALB pods that are located on the same node as the load balancer pods. 

By default, periodic Ingress version updates are automatically rolled out to your ALBs. If only one worker node exists in a zone in your cluster, and you set the number of ALB replicas to 1, this single ALB pod is deleted and a new pod is created whenever updates are applied. This process might cause traffic disruptions, even if you have worker nodes and ALB replicas in other zones. To prevent traffic disruptions, ensure that at least two worker nodes exist in each zone, and that two replicas exist for each ALB. Note that during the update process, only new connections are routed to the second ALB pod; existing connections on the updating ALB pod are safely terminated. It is recommended that client applications initiate a retry for existing connections that are terminated during the update. 
{: important}


Manually change the number of ALB replicas by creating a ConfigMap. Note that you cannot manually scale your ALB replicas if you have [configured your ALB to use dynamic scaling](#alb_replicas_autoscaler).

1. Get the IDs for your ALBs.

    ```sh
    ibmcloud ks ingress alb ls -c <cluster_name_or_ID>
    ```
    {: pre}

2. Create a YAML file for an `ibm-ingress-deploy-config` ConfigMap. For each ALB, add `'{"replicas":<number_of_replicas>}'`. This example increases the number of ALB pods to 4 replicas.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-ingress-deploy-config
      namespace: kube-system
    data:
      <alb1-id>: '{"replicas":4}'
      <alb2-id>: '{"replicas":4}'
      ...
    ```
    {: codeblock}

3. Create the `ibm-ingress-deploy-config` ConfigMap in your cluster.

    ```sh
    kubectl create -f ibm-ingress-deploy-config.yaml
    ```
    {: pre}

4. To apply the changes, update your ALBs. Note that it might take up to 5 minutes for the changes to apply.

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID>
    ```
    {: pre}

5. Verify that the number of ALB pods that are `Ready` increased to the number of replicas that you specified.

    ```sh
    kubectl get pods -n kube-system | grep alb
    ```
    {: pre}

## Dynamically scaling ALBs with autoscaler
{: #alb_replicas_autoscaler}

With dynamic scaling, the number of ALB replicas changes automatically based on actual load. The number of replicas decreases when actual load is lower and increases when the load is higher, saving compute capacity while maintaining the ability to handle traffic during peak times. You can configure the ALB autoscaler to implement scaling based on CPU utilization, or on custom metrics that you define.

To set up autoscaling, run the following command. You can scale based on CPU utilization by including the `--cpu-average-utilization` option. Or you can scale based on custom metrics by including the `--custom-metrics-file` option and specify a configuration file path.

```sh
ibmcloud ks ingress alb autoscale set --alb ALB --cluster CLUSTER --max-replicas NUM_REPLICAS --min-replicas NUM_REPLICAS [--output OUTPUT] [-q] (--cpu-average-utilization PERCENT | --custom-metrics-file FILE)
```
{: pre}

`--cluster, -c CLUSTER`
:   Required: The name or ID of the cluster.

`--alb ALB`
:   The ALB ID. To see available ALB IDs, run `ibmcloud ks ingress alb ls`.

`--max-replicas REPLICAS`:
:   The maximum number of replicas for the ALB. Specify a whole number. The maximum number of ALB replicas is limited to the number of worker nodes on the cluster. To add more worker nodes to your cluster, see [Adding worker nodes to Classic clusters](/docs/containers?topic=containers-add-workers-classic) or [Adding worker nodes to VPC clusters](/docs/containers?topic=containers-add-workers-vpc).

`--min-replicas REPLICAS`
:   The minimum number of replicas for the ALB. Specify a whole number that is at least `2`.


`--cpu-average-utilization PERCENT`
:   **Autoscaling by using average CPU utilization**: The target CPU utilization percentage for the autoscaler. The average represents the percentage of used CPU compared to the requested CPU for all ALB pods. To check the current CPU usage by ALB pods, run `kubectl top pods -n kube-system -l app=<alb-id>`. To check the CPU amount requested for ALB pods, run `kubectl get deployment -n kube-system <alb-id> -o=jsonpath='{.spec.template.spec.containers[0].resources.requests.cpu}`. You cannot use this option with the `--custom-metrics-file` option. 

`--custom-metrics-file FILE`
:   **Autoscaling by using custom metrics**: Specify the name of the configuration file that defines custom metrics and target values for autoscaling. Note that you are responsible for installing and configuring a metrics provider, such as Prometheus. You cannot use this option with the `--cpu-average-utilization` option.

Example custom metrics YAML file. Configure your custom metrics in a YAML file. Save the file and specify the file name with the `--custom-metrics-file` command option. For more information on writing your custom metrics spec file, See the Kubernetes documentation on [Horizontal Pod Autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-resource-metrics){: external} or the [MetricSpec API documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/#metricspec-v2-autoscaling){: external}).

```yaml
- type: Object
  object:
    metric:
      name: example_metrics
    describedObject:
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      name: example-ingress
    target:
      type: Value
      value: 2k
```
{: codeblock}



### Example commands for configuring dynamic ALB autoscaling
{: #alb_replicas_autoscaler_ex}

Example command for dynamic scaling based on an average CPU utilization of 60%.

```sh
ibmcloud ks ingress alb autoscale set -c <cluster_name_or_ID> --alb <alb-id> --min-replicas 2 --max-replicas 5 --cpu-average-utilization 60
```
{: pre}

Example command for dynamic scaling based on custom metrics stored in a file named `my-custom-metrics.yaml`.

```sh
ibmcloud ks ingress alb autoscale set -c <cluster_name_or_ID> --alb <alb-id> --min-replicas 2 --max-replicas 5 --custom-metrics-file my-custom-metrics.yaml
```
{: pre}

### Calculating average CPU utilization
{: #alb_scaling_average_cpu}

The following image shows an example scenario for determining CPU usage when planning your autoscaling configuration.

Assume that you have an idle cluster with two running ALB replicas that has no incoming traffic. The total CPU request in this case is `2*20m=40m`. One of the replicas might use `5m` CPU and the other `7m` CPU. We can calculate the CPU utilization by using the following formula.

![Calculating average CPU utilization](images/ingress-autoscale.svg "Calculating average CPU utilization"){: caption="This image contains the formuala for calculating average CPU utilization" caption-side="bottom"}


### Disabling ALB autoscaling
{: #alb_replicas_autoscaler_disable}

Run the command to disable autoscaling for an ALB.

```sh
ibmcloud ks ingress alb autoscale unset --alb ALB --cluster CLUSTER 
```
{: pre}


## Disabling ALBs
{: #alb-disable}

To scale down your ALBs, you can disable an ALB so that it no longer routes traffic in your cluster. 
{: shortdesc}

```sh
ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
```
{: pre}

You can re-enable an ALB at any time by running [`ibmcloud ks ingress alb enable classic --alb <ALB_ID> -c <cluster_name_or_ID>`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure) for classic clusters or [`ibmcloud ks ingress alb enable vpc-gen2 --alb <ALB_ID> -c <cluster_name_or_ID>`](/docs/containers?topic=containers-kubernetes-service-cli#cli_alb_configure_vpc_gen2) .


## Moving ALBs across VLANs in classic clusters
{: #migrate-alb-vlan}

The information in this topic is specific to classic clusters only.
{: note}

When you [change your worker node VLAN connections](/docs/containers?topic=containers-cs_network_cluster#change-vlans), the worker nodes are connected to the new VLAN and assigned new public or private IP addresses. However, ALBs can't automatically migrate to the new VLAN because they are assigned a stable, portable public or private IP address from a subnet that belongs to the old VLAN. When your worker nodes and ALBs are connected to different VLANs, the ALBs can't forward incoming network traffic to app pods to your worker nodes. To move your ALBs to a different VLAN, you must create an ALB on the new VLAN and disable the ALB on the old VLAN. Note that all public ALBs in your cluster share the same IBM-assigned Ingress subdomain. When you create new ALBs, you don't need to change your Ingress resource files.
{: shortdesc}

Removing all workers from a VLAN removes the IP address of the ALB in the VLAN's zone.
{: note}


1. Get the new public or private VLAN that you changed your worker node connections to in each zone.

    1. List the details for a worker in a zone.

        ```sh
        ibmcloud ks worker get --cluster <cluster_name_or_ID> --worker <worker_id>
        ```
        {: pre}

    2. In the output, note the **ID** for the public or the private VLAN.
        * To create public ALBs, note the public VLAN ID.
        * To create private ALBs, note the private VLAN ID.

    3. Repeat these steps for a worker in each zone so that you have the IDs for the new public or private VLAN in each zone.

2. In each zone, create an ALB on the new VLAN. For more information about this command's parameters, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_create).

    ```sh
    ibmcloud ks ingress alb create --cluster <cluster_name_or_ID> --type <public_or_private> --zone <zone> --vlan <VLAN_ID> [--ip <IP_address>] [--version image_version]
    ```
    {: pre}

3. Verify that the ALBs that you created on the new VLANs in each zone have a **Status** of `enabled` and that an **ALB IP** address is assigned.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a cluster in which new public ALBs are created on VLAN `2294030` in `dal12` and `2234940` in `dal10`.

    ```sh
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID   NLB Version
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal12   ingress:1.1.2_2507_iks   2294021
    private-crdf253b6025d64944ab99ed63bb4567b6-alb2   false     disabled   private   -               dal10   ingress:1.1.2_2507_iks   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.48.228.78   dal12   ingress:1.1.2_2507_iks   2294019
    public-crdf253b6025d64944ab99ed63bb4567b6-alb2    true      enabled    public    169.46.17.6     dal10   ingress:1.1.2_2507_iks   2234945
    public-crdf253b6025d64944ab99ed63bb4567b6-alb3    true      enabled    public    169.49.28.09    dal12   ingress:1.1.2_2507_iks   2294030
    public-crdf253b6025d64944ab99ed63bb4567b6-alb4    true      enabled    public    169.50.35.62    dal10   ingress:1.1.2_2507_iks   2234940
    ```
    {: screen}

4. Disable each ALB that is connected to the old VLANs.

    ```sh
    ibmcloud ks ingress alb disable --alb <old_ALB_ID> -c <cluster_name_or_ID>
    ```
    {: pre}

5. Verify that each ALB that is connected to the old VLANs has a **Status** of `disabled`. Only the ALBs that are connected to the new VLANs receive incoming network traffic and communicate with your app pods.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a cluster in which the default public ALBs on VLAN `2294019` in `dal12` and `2234945` in `dal10`: are disabled.

    ```sh
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal12   ingress:1.1.2_2507_iks   2294021
    private-crdf253b6025d64944ab99ed63bb4567b6-alb2   false     disabled   private   -               dal10   ingress:1.1.2_2507_iks   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    false     disabled   public    169.48.228.78   dal12   ingress:1.1.2_2507_iks   2294019
    public-crdf253b6025d64944ab99ed63bb4567b6-alb2    false     disabled   public    169.46.17.6     dal10   ingress:1.1.2_2507_iks   2234945
    public-crdf253b6025d64944ab99ed63bb4567b6-alb3    true      enabled    public    169.49.28.09    dal12   ingress:1.1.2_2507_iks   2294030
    public-crdf253b6025d64944ab99ed63bb4567b6-alb4    true      enabled    public    169.50.35.62    dal10   ingress:1.1.2_2507_iks   2234940
    ```
    {: screen}

6. Optional for public ALBs: Verify that the IP addresses of the new ALBs are listed under the IBM-provided Ingress subdomain for your cluster. You can find this subdomain by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`.

    ```sh
    nslookup <Ingress_subdomain>
    ```
    {: pre}

    Example output

    ```sh
    Non-authoritative answer:
    Name:    mycluster-<hash>-0000.us-south.containers.appdomain.cloud
    Addresses:  169.49.28.09
            169.50.35.62
    ```
    {: screen}

7. Optional: If you no longer need the subnets on the old VLANs, you can [remove them](/docs/containers?topic=containers-subnets#remove-subnets).
