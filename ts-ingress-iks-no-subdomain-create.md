---

copyright:
  years: 2014, 2025
lastupdated: "2025-07-21"


keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}






# Why does no Ingress subdomain exist after cluster creation?
{: #ingress_subdomain}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


You create a cluster and run `ibmcloud ks cluster get --cluster <cluster>` to check its status. The cluster **State** is `normal`, but the **Ingress Subdomain** and **Ingress Secret** are not available.
{: tsSymptoms}


Even if the cluster is in a `normal` state, the Ingress subdomain and secret might still be in progress. The Ingress subdomain and secret creation might take more than 15 minutes to complete.
{: tsCauses}

## Classic clusters
{: #no-ingress-subdomain-classic}

1. When worker nodes are fully deployed and ready on the VLANs, a portable public and a portable private subnet for the VLANs are ordered.
2. After the portable subnet orders are successfully fulfilled, the `ibm-cloud-provider-vlan-ip-config` config map is updated with the portable public and portable private IP addresses.
3. When the `ibm-cloud-provider-vlan-ip-config` config map is updated, one public ALB per zone is triggered for creation.
4. A load balancer service that exposes the ALB is created and assigned an IP address.

5. The load balancer IP address is used to register the Ingress subdomain in Akamai. Akamai might have latency during the registration process.

### VPC clusters
{: #no-ingress-subdomain-vpc}

1. When you create a VPC cluster, one public and one private VPC load balancer are automatically created outside of your cluster in your VPC.
2. One public ALB per zone is triggered for creation.
3. A load balancer service that exposes the ALB is created and assigned a hostname.

4. The load balancer hostname is used to register the Ingress subdomain in Akamai. Akamai might have latency during the registration process.

Creating a cluster after deleting a cluster the same or similar name? See [Why does no Ingress subdomain exist after I create clusters of the same or similar name?](/docs/containers?topic=containers-cs_rate_limit) instead.
{: tip}


Typically, after the cluster is ready, the Ingress subdomain and secret are created after 15 minutes.
{: tsResolve}

If the Ingress subdomain and secret are still unavailable after your cluster is in a `normal` state for more than 15 minutes, you can check the progress of the creation process by following these steps:

1. Verify that the worker nodes have a **State** of `normal` and a **Status** of `Ready`. After you create the cluster, it can take up to 20 minutes for the worker nodes to be ready.
    ```sh
    ibmcloud ks worker ls -c <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ID                                                     Public IP         Private IP      Flavor              State     Status   Zone    Version
    kube-blrs3b1d0p0p2f7haq0g-mycluster-default-000001f7   169.xx.xxx.xxx    10.xxx.xx.xxx   u3c.2x4.encrypted   deployed   Ready    dal10   1.32
    ```
    {: screen}

2. Verify that the prerequisite steps for your ALB creation are completed.
    * **Classic clusters**: Get the details of the `ibm-cloud-provider-vlan-ip-config` config map.
        ```sh
        kubectl describe cm ibm-cloud-provider-vlan-ip-config -n kube-system
        ```
        {: pre}

    * If the config map shows IP addresses, continue to the next step.
    * If the **Events** section shows a warning message similar to `ErrorSubnetLimitReached: There are already the maximum number of subnets permitted in this VLAN`, see the [VLAN capacity troubleshooting topic](/docs/containers?topic=containers-cs_subnet_limit).

    Example output of a config map populated with IP addresses:
    ```sh
    NAME:         ibm-cloud-provider-vlan-ip-config
    Namespace:    kube-system
    Labels:       <none>
    Annotations:  <none>

    Data
    ====
    reserved_public_vlan_id:
    ----

    vlanipmap.json:
    ----
    {
        "vlans": [
        {
          "id": "2234947",
          "subnets": [
            {
              "id": "2215454",
              "ips": [
                "10.XXX.XXX.XXX",
                "10.XXX.XXX.XXX",
                "10.XXX.XXX.XXX",
                "10.XXX.XXX.XXX",
                "10.XXX.XXX.XXX"
              ],
              "is_public": false,
              "is_byoip": false,
              "cidr": "10.XXX.XXX.X/29"
            }
          ],
          "zone": "dal10",
          "region": "us-south"
        },
        {
          "id": "2234945",
          "subnets": [
            {
              "id": "2219170",
              "ips": [
                "169.XX.XXX.XX",
                "169.XX.XXX.XX",
                "169.XX.XXX.XX",
                "169.XX.XXX.XX",
                "169.XX.XXX.XX"
              ],
              "is_public": true,
              "is_byoip": false,
              "cidr": "169.XX.XXX.X/29"
            }
          ],
          "zone": "dal10",
          "region": "us-south"
        }
        ],
        "vlan_errors": [],
        "reserved_ips": []
    }
    cluster_id:
    ----
    bmnj1b1d09lpvv3oof0g
    reserved_private_ip:
    ----

    reserved_private_vlan_id:
    ----

    reserved_public_ip:
    ----

    Events:  <none>
    ```
    {: screen}

    * **VPC clusters**: Verify that the VPC load balancer for your ALBs exists. In the output, look for the VPC load balancer **Name** that starts with `kube-<cluster_ID>`. If you did not install the `infrastructure-service` plug-in, install it by running `ibmcloud plugin install infrastructure-service`.
        ```sh
        ibmcloud is load-balancers
        ```
        {: pre}

    Even though the VPC load balancer is listed, its DNS entry might still be registering. When a VPC load balancer is created, the hostname is registered through a public DNS. Sometimes, it can take several minutes for this DNS entry to be replicated to the specific DNS that your client is using.
    {: note}

3. Check whether an ALB exists for your cluster and that the ALB has an IP address (classic clusters) or hostname (VPC clusters) assigned.
    ```sh
    ibmcloud ks ingress alb ls -c <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ALB ID                                Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID   NLB Version
    private-crbmnj1b1d09lpvv3oof0g-alb1   false     disabled   private   -               dal10   ingress:1.1.2_2507_iks   2234947       2.0
    public-crbmnj1b1d09lpvv3oof0g-alb1    true      enabled    public    169.XX.XXX.XX   dal10   ingress:1.1.2_2507_iks   2234945       2.0
    ```
    {: screen}

    * If a public ALB is listed and is assigned an IP address (classic clusters) or hostname (VPC clusters), continue to the next step.
    * If a public ALB is listed and but is not assigned an IP address (classic clusters) or hostname (VPC clusters), try to disable and re-enable the ALBs.
        * Classic clusters:
            ```sh
            ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

            ```sh
            ibmcloud ks ingress alb enable classic --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

        * VPC clusters:
            ```sh
            ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

            ```sh
            ibmcloud ks ingress alb enable vpc-gen2 --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

    * If no ALBs are created after several minutes, [review ways to get help](/docs/containers?topic=containers-get-help).

4. Check whether the `LoadBalancer` service that exposes the ALB exists and is assigned the same IP address (classic clusters) or hostname (VPC clusters) as the public ALB.
    * If a `LoadBalancer` service is listed and is assigned an IP address (classic clusters) or hostname (VPC clusters), continue to the next step.
    * If no `LoadBalancer` services are created after several minutes, [review ways to get help](/docs/containers?topic=containers-get-help).

    ```sh
    kubectl get svc -n kube-system | grep LoadBalancer
    ```
    {: pre}

    Example output

    ```sh
    public-crbmnj1b1d09lpvv3oof0g-alb1   LoadBalancer   172.21.XXX.XXX   169.XX.XXX.XX   80:30723/TCP,443:31241/TCP   1d
    ```
    {: screen}

5. Check again whether the Ingress subdomain and secret are created. If they are not available, but you verified that all the components in steps 1 - 4 exist, [review ways to get help](/docs/containers?topic=containers-get-help).
    ```sh
    ibmcloud ks cluster get -c <cluster_name_or_ID>
    ```
    {: pre}
