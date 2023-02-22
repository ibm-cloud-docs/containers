---

copyright:
  years: 2022, 2023
lastupdated: "2023-02-22"

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

Manually keep your ALBs up to date with the latest version, or enable automatic updates.
{: shortdesc}

### Manually updating ALBs
{: #update-alb}

You can manually apply a one-time update of your Ingress ALB pods with the `ibmcloud ks ingress alb update` command. By default, this command applies the latest ALB image version, but you can apply a different version by including the  `--version` option. For more information or command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_update).
{: shortdesc}


If you want to update your ALB image to a specific version with the `--version` option, you must [disable automatic ALB updates](#autoupdate) and then keep them disabled for as long as you want to run the specified version. Automatic updates always apply the latest version and overwrite any manual updates you apply. If you want to use a different version, you cannot enable automatic updates. 
{: important}

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

### Managing automatic updates
{: #autoupdate}

By default, automatic updates to Ingress ALBs are enabled. If your ALBs run the Kubernetes Ingress image, your ALBs are automatically updated to the latest version of the Kubernetes Ingress NGINX image. For example, if your ALBs run version `1.2.1_2506_iks`, and the Kubernetes Ingress NGINX image `0.47.0` is released, your ALBs are automatically updated to the latest build of the latest community version, such as `1.1.2_2507_iks`.
{: shortdesc}

You can disable or enable automatic updates for your ALBs by running [`ibmcloud ks ingress alb autoupdate disable -c <cluster_name_or_ID>`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_enable) or [`ibmcloud ks ingress alb autoupdate enable -c <cluster_name_or_ID>`](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_disable). 

Do not enable automatic updates if you run an ALB image version that is different from the latest version. Automatic updates always apply the latest version and overwrite any manual updates you apply. If you want to update your ALB image to a specific version by using the `ibmcloud ks ingress alb update` command with the `--version` option, you must first [disable automatic ALB updates](#autoupdate) and then keep them disabled for as long as you want to run the specified version.
{: important}


### Scheduling maintenance windows for automatic updates
{: #alb-scheduled-updates}

You can enable automatic updates of all Ingress ALB pods in a cluster by enabling [automatic updates](#autoupdate). If you enable automatic update for your ALBs, you can further control and manage your ALB updates by creating a customized ConfigMap that specifies the time you want the updates to occur and the percentage of ALBs you want to update.  
{: shortdesc}

To set a time for automatic updates, you set the `updateStartTime` and `updateEndTime` keys in the deployment ConfigMap. Each key represents an assigned time in a 24 hour format (HH:MM). Note that this time is specified in coordinated universal time (UTC) rather than your local time. To specify a percentage of ALBs to update, you set the `updatePercentage` key as a whole number between 0 and 100.

1. Create a YAML file for your ConfigMap. Specify the `updatePercentage`, `updateStartTime`, and `updateEndTime` fields as key-value pairs in the `data` field.

    The following example ConfigMap sets the automatic update function to update 35% of ALB pods in your cluster between 20:34 and 23:59 UTC.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
        name: ingress-deploy-config
        namespace: kube-system
    data:
        "updatePercentage": "35"
        "updateStartTime": "20:34"
        "updateEndTime": "23:59"
    ```
    {: codeblock}

2. Deploy the ConfigMap in your cluster. The new rules apply the next time an update takes place.

    ```sh
    kubectl apply -f <filename>.yaml
    ```
    {: pre}

### Choosing a supported image version
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

For the changes that are in each version of the Ingress images, see the [Ingress version change log](/docs/containers?topic=containers-cluster-add-ons-changelog).

### Reverting to an earlier version
{: #revert-alb-version}

If your ALB pods were recently updated, but a custom configuration for your ALBs is affected by the latest image version build, you can use the [`ibmcloud ks ingress alb update`](#update-alb) command with the `--version` option to roll back ALB pods to an earlier, supported version. The image version that you change your ALB to must be a supported image version that is listed in the output of `ibmcloud ks ingress alb versions`. 
{: shortdesc}

Note that if you revert to an earlier version, you must [disable automatic ALB updates](#autoupdate) and then keep them disabled for as long as you want to run the earlier version. Automatic updates always apply the latest version and overwrite any manual updates you apply. If you want to use an earlier version, you cannot enable automatic updates. 

## Scaling ALBs
{: #scale_albs}

Each ALB can handle around 20,000 connections per second. If you need to process additional connections, you can create more ALBs in a zone or increase the number of ALB pod replicas.
{: shortdesc}

### Creating more ALBs in a zone
{: #create_alb}

Each ALB in a zone is deployed as two pods on different worker nodes. To scale up your ALB processing capabilities and handle more connections, you can create additional ALBs in a zone. The IP address of the new ALB is automatically added to your Ingress subdomain.
{: shortdesc}

When you create a multizone cluster, a default public ALB is created in each zone where you have worker nodes. If you later remove one of these original three zones and add workers in a different zone, a default public ALB is not created in that new zone. You can manually create an ALB to process connections in that new zone.
{: tip}

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


### Increasing the number of ALB pod replicas
{: #alb_replicas}

By default, each ALB has 2 replicas. You can scale up your ALB processing capabilities by increasing the number of ALB pods.
{: shortdesc}

By default, periodic Ingress version updates are automatically rolled out to your ALBs. If only one worker node exists in a zone in your cluster, and you set the number of ALB replicas to 1, this single ALB pod is deleted and a new pod is created whenever updates are applied. This process might cause traffic disruptions, even if you have worker nodes and ALB replicas in other zones. To prevent traffic disruptions, ensure that at least two worker nodes exist in each zone, and that two replicas exist for each ALB.
{: warning}

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

### Disabling ALBs
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

    Example output.

    ```sh
    Non-authoritative answer:
    Name:    mycluster-<hash>-0000.us-south.containers.appdomain.cloud
    Addresses:  169.49.28.09
            169.50.35.62
    ```
    {: screen}

7. Optional: If you no longer need the subnets on the old VLANs, you can [remove them](/docs/containers?topic=containers-subnets#remove-subnets).



