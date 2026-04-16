---

copyright:
  years: 2014, 2026
lastupdated: "2026-04-16"


keywords: kubernetes, clusters

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Accessing clusters
{: #access_cluster}
{: help}
{: support}

After your {{site.data.keyword.containerlong}} cluster is created, you can begin working with your cluster by accessing the cluster.
{: shortdesc}

## Prerequisites
{: #prereqs}

1. [Install the required CLI tools](/docs/containers?topic=containers-cli-install), including the {{site.data.keyword.cloud_notm}} CLI, {{site.data.keyword.containershort_notm}} plug-in (`ibmcloud ks`), and Kubernetes CLI (`kubectl`). For quick access to test features in your cluster, you can also use the [{{site.data.keyword.cloud-shell_notm}}](/docs/containers?topic=containers-cli-install).
2. [Create your {{site.data.keyword.containerlong_notm}} cluster](/docs/containers?topic=containers-clusters).
3. If your network is protected by a company firewall, [allow access](/docs/containers?topic=containers-firewall#corporate) to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports. For private cloud service endpoint-only clusters, you can't test the connection to your cluster until you [configure access to the cloud service endpoint subnet](#access_private_se).
4. Check that your cluster is in a healthy state by running `ibmcloud ks cluster get -c <cluster_name_or_ID>`. If your cluster is not in a healthy state, review the [Debugging clusters](/docs/containers?topic=containers-debug_clusters) guide for help. For example, if your cluster is provisioned in an account that is protected by a firewall gateway appliance, you must [configure your firewall settings to allow outgoing traffic to the appropriate ports and IP addresses](/docs/containers?topic=containers-firewall).
5. In the output of the cluster details from the previous step, check the **Public** or **Private Service Endpoint** URL of the cluster.
    *  **Public Service Endpoint URL only**: Continue with [Accessing clusters through the public cloud service endpoint](#access_public_se).
    *  **Private Service Endpoint URL only**: Continue with [Accessing clusters through the private cloud service endpoint](#access_private_se).
    *  **Both service endpoint URLs**: You can access your cluster either through the [public](#access_public_se) or the [private](#access_private_se) service endpoint.
6. You can also access your VPC cluster through the [Virtual Private Endpoint](#vpc_vpe).


## Accessing clusters through the public cloud service endpoint
{: #access_public_se}

To work with your cluster, set the cluster that you created as the context for a CLI session to run `kubectl` commands.
{: shortdesc}

If you want to use the {{site.data.keyword.cloud_notm}} console instead, you can run CLI commands directly from your web browser in the [{{site.data.keyword.cloud-shell_notm}}](/docs/cloud-shell?topic=cloud-shell-shell-ui).
{: tip}

1. Set the cluster that you created as the context for this session. Complete these configuration steps every time that you work with your cluster.
    1. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
        ```sh
        ibmcloud ks cluster config -c <cluster_name_or_ID>
        ```
        {: pre}

    2. Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
        ```sh
        kubectl config current-context
        ```
        {: pre}

        Example output
        ```sh
        <cluster_name>/<cluster_ID>
        ```
        {: screen}

2. Launch your Kubernetes dashboard with the default port `8001`.
    1. Set the proxy with the default port number.
        ```sh
        kubectl proxy
        ```
        {: pre}

        ```sh
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2. Open the following URL in a web browser to see the Kubernetes dashboard.
        ```sh
        http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
        ```
        {: codeblock}



## Accessing clusters through the private cloud service endpoint
{: #access_private_se}

Allow authorized cluster users to access your [VPC](#vpc_private_se) or [classic](#access_private_se) cluster through the private cloud service endpoint.
{: shortdesc}

### Accessing VPC clusters through the private service endpoint
{: #vpc_private_se}

All VPC clusters have a private service endpoint which authorized users can access. Since it is only available on the private network, users must access it in one of the following ways:
{: shortdesc}

1. For regions other than ca-mon, in-che, and in-mum, the private service endpoint for VPC clusters can be accessed from anywhere inside IBM Cloud, or from a client that is using a VPN (or similar) to connect in to IBM Cloud.

    You can connect via VPN into IBM Cloud using one of the following options:

    [client-to-site VPN](/docs/vpc?topic=vpc-vpn-client-to-site-overview)
    :   Most common option for cluster access, and fairly straightforward to set up. For configuration tips, see [Accessing VPC clusters through the Virtual Private Endpoint Gateway](#vpc_vpe).

    [site-to-site VPN](/docs/vpc?topic=vpc-vpn-onprem-example)
    :   This is more complex to set up but has additional features that might be useful.

    These clusters can be accessed via the private service endpoint URL for the cluster that looks like `c<XXX>.private.<REGION>.containers.cloud.ibm.com:XXXXX`. Use this command to get a kubeconfig file that uses this private endpoint:

    Then you can log into the cluster using one of several options shown below.  Once you have done so, you can verify that connection using something like `ibmcloud ks get nodes`

    * **Log in as admin**:
        1. Make sure that you have the [**Administrator** platform access role for the cluster](/docs/containers?topic=containers-iam-platform-access-roles).
        2. Download the kubeconfig for the administrator.
            ```sh
            ibmcloud ks cluster config -c <cluster_name_or_ID> --admin --endpoint private
            ```
            {: pre}


    * **Log in as user**:
        1. Download the kubeconfig for the the user you are logged in as.
            ```sh
            ibmcloud ks cluster config -c <cluster_name_or_ID> --endpoint private
            ```
            {: pre}






2. The private service endpoint for all VPC clusters, in all regions, can be accessed via that cluster's specific Virtual Private Endpoint (VPE) gateway. A VPE Gateway is only available from inside the VPC it was created in or via a VPN (or similar) into that specific VPC. There are two main options to connect to a cluster in this way:

    * A VPE Gateway for the cluster is automatically created in the VPC that the cluster was created in. So one option is to connect from a system inside that VPC, or from a system that has a VPN (or similar) connection into that VPC.
    * If you want to connect from a different VPC (maybe even a VPC in a different region or a different account) you can create a new VPE Gateway in that other VPC. Then from that other VPC (including if you are VPN'd into that other VPC), you can access the cluster master via that new VPE Gateway. The steps for how to do this are in the [Creating Additional Virtual Private Endpoint Gateways in Other VPCs and Accounts](#vpc_cluster_new_vpe_access) section below.
    * More information on this option, including how to get a kubeconfig file and tips on configuring a VPN, are in the [Accessing VPC clusters through the Virtual Private Endpoint Gateway](#vpc_vpe) section below.

### Accessing classic clusters through the private cloud service endpoint
{: #classic_private_se}

The Kubernetes master is accessible through the private cloud service endpoint if authorized cluster users are in your {{site.data.keyword.cloud_notm}} private network or are connected to the private network such as through a [classic VPN connection](/docs/iaas-vpn?topic=iaas-vpn-getting-started) or [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl). However, communication with the Kubernetes master over the private cloud service endpoint must go through the `166.X.X.X` IP address range, which is not routable from a classic VPN connection or through {{site.data.keyword.dl_full_notm}}. You can expose the private cloud service endpoint of the master for your cluster users by using a private network load balancer (NLB). The private NLB exposes the private cloud service endpoint of the master as an internal `10.X.X.X` IP address range that users can access with the VPN or {{site.data.keyword.dl_full_notm}} connection. If you enable only the private cloud service endpoint, you can use the Kubernetes dashboard or temporarily enable the public cloud service endpoint to create the private NLB.
{: shortdesc}

1. Get the private cloud service endpoint URL and port for your cluster.
    ```sh
    ibmcloud ks cluster get -c <cluster_name_or_ID>
    ```
    {: pre}

    In this example output, the **Private Service Endpoint URL** is `https://c1.private.us-east.containers.cloud.ibm.com:25073`.
    ```sh
    NAME:                           setest
    ID:                             b8dcc56743394fd19c9f3db7b990e5e3
    State:                          normal
    Status:                         healthy cluster
    Created:                        2019-04-25T16:03:34+0000
    Location:                       wdc04
    Master URL:                     https://c1.private.us-east.containers.cloud.ibm.com:25073
    Public Service Endpoint URL:    -
    Private Service Endpoint URL:   https://c1.private.us-east.containers.cloud.ibm.com:25073
    Master Location:                Washington D.C.
    ...
    ```
    {: screen}

2. Create a YAML file named `kube-api-via-nlb.yaml`. This YAML creates a private `LoadBalancer` service and exposes the private cloud service endpoint through that NLB. Replace `<private_service_endpoint_port>` with the port you found in the previous step.

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: kube-api-via-nlb
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
      namespace: default
    spec:
      type: LoadBalancer
      ports:
      - protocol: TCP
        port: 8080 # Or, the <private_service_endpoint_port> that you found earlier.
        targetPort: 8080 # Optional. By default, the `targetPort` is set to match the `port` value unless specified otherwise. 
    ---
    kind: Endpoints
    apiVersion: v1
    metadata:
      name: kube-api-via-nlb
    subsets:
      - addresses:
          - ip: 172.20.0.1
        ports:
          - port: 2040
    ```
    {: codeblock}

3. To create the private NLB, you must be connected to the cluster master. Because you can't yet connect through the private cloud service endpoint from a VPN or {{site.data.keyword.dl_full_notm}}, you must connect to the cluster master and create the NLB by using the public cloud service endpoint or Kubernetes dashboard.
    * If you enabled the private cloud service endpoint only, you can use the Kubernetes dashboard to create the NLB. The dashboard automatically routes all requests to the private cloud service endpoint of the master.
        1. On the **Clusters** [page](https://cloud.ibm.com/containers/cluster-management/clusters){: external}, click the cluster that you want to access.
        1. From the cluster detail page, click the **Kubernetes Dashboard**.
        1. Click **+ Create**.
        1. Select **Create from file**, upload the `kube-api-via-nlb.yaml` file, and click **Upload**.
        1. In the **Overview** page, verify that the `kube-api-via-nlb` service is created. In the **External endpoints** column, note the `10.x.x.x` address. This IP address exposes the private cloud service endpoint for the Kubernetes master on the port that you specified in your YAML file.

    * If you also enabled the public cloud service endpoint, you already have access to the master.
        1. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
            ```sh
            ibmcloud ks cluster config -c <cluster_name_or_ID>
            ```
            {: pre}

        2. Create the NLB and endpoint.
            ```sh
            kubectl apply -f kube-api-via-nlb.yaml
            ```
            {: pre}

        3. Verify that the `kube-api-via-nlb` NLB is created. In the output, note the `10.x.x.x` **EXTERNAL-IP** address. This IP address exposes the private cloud service endpoint for the Kubernetes master on the port that you specified in your YAML file.
            ```sh
            kubectl get svc -o wide
            ```
            {: pre}

            In this example output, the IP address for the private cloud service endpoint of the Kubernetes master is `10.186.92.42`.
            ```sh
            NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)          AGE   SELECTOR
            kube-api-via-nlb         LoadBalancer   172.21.150.118   10.186.92.42     443:32235/TCP    10m   <none>
            ...
            ```
            {: screen}

4. On the client machines where you or your users run `kubectl` commands, add the NLB IP address and the private cloud service endpoint URL to the `/etc/hosts` file. Do not include any ports in the IP address and URL and don't include `https://` in the URL.
    * For macOS and Linux users:
        ```sh
        sudo nano /etc/hosts
        ```
        {: pre}

    * For Windows users:
    
        ```sh
        notepad C:\Windows\System32\drivers\etc\hosts
        ```
        {: pre}
        
        Depending on your local machine permissions, you might need to run Notepad as an administrator to edit the hosts file.

        ```sh
        10.186.92.42  c1.private.us-east.containers.cloud.ibm.com
        ```
        {: codeblock}

5. Verify that you are connected to the private network through a [VPN](/docs/iaas-vpn?topic=iaas-vpn-getting-started) or [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl) connection.

6. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
    ```sh
    ibmcloud ks cluster config -c <cluster_name_or_ID> --endpoint private
    ```
    {: pre}

7. Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
    ```sh
    kubectl config current-context
    ```
    {: pre}

    Example output

    ```sh
    <cluster_name>/<cluster_ID>
    ```
    {: screen}

## Accessing VPC clusters through the Virtual Private Endpoint Gateway
{: #vpc_vpe}

[Virtual Private Endpoint Gateway](/docs/vpc?topic=vpc-about-vpe) is created for VPC clusters automatically. The Kubernetes master is accessible through this Virtual Private Endpoint gateway if authorized cluster users are connected to the same VPC where the cluster is deployed, such as through a [{{site.data.keyword.vpc_short}} VPN](/docs/vpc?topic=vpc-vpn-overview). In this case, the `kubeconfig` is configured with the Virtual Private Endpoint (VPE) URL which is private DNS name and could be resolved only by the {{site.data.keyword.vpc_short}} Private DNS service. The {{site.data.keyword.vpc_short}} Private DNS server addresses are `161.26.0.7` and `161.26.0.8`.
{: shortdesc}

1. Set up your {{site.data.keyword.vpc_short}} VPN and connect to your VPC through VPN.

    1. Configure a [client-to-site](/docs/vpc?topic=vpc-vpn-client-to-site-overview) or [site-to-site](/docs/vpc?topic=vpc-vpn-onprem-example) VPN to your VPC. For example, you might choose to set up a client-to-site connection with a VPN Client.
    1. In case of client-to-site VPN for {{site.data.keyword.vpc_short}} service, you must specify the {{site.data.keyword.vpc_short}} Private DNS service addresses when you provision the VPN server as mentioned in the [considerations](/docs/vpc?topic=vpc-client-to-site-vpn-planning#existing-vpc-configuration-considerations), and you must create a VPN route after the VPN server is provisioned, with destination `161.26.0.0/16` and action `translate`.
    1. In case of site-to-site VPN for {{site.data.keyword.vpc_short}} service, follow the [Accessing service endpoints through VPN guide](/docs/vpc?topic=vpc-build-se-connectivity-using-vpn) and configure the {{site.data.keyword.vpc_short}} Private DNS service addresses.
    1. Verify that you are connected to the VPC through your {{site.data.keyword.vpc_short}} VPN connection.

1. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.

    The `--endpoint vpe` flag ensures that the `<CLUSTERID>.private.<REGION>.containers.cloud.ibm.com:XXXXX` URL is used in the kubeconfig file.

    ```sh
    ibmcloud ks cluster config -c <cluster_name_or_ID> --endpoint vpe
    ```
    {: pre}

1. **1.30 and later** Add a security group rule to the `kube-vpegw-<clusterID>` for your VPN. The remote resource in this example comes from the VPN’s client IP CIDR. You can find your VPE port by running `ibmcloud ks cluster get -c CLUSTER`.

    ```sh
    ibmcloud is sg-rulec kube-vpegw-<clusterID> inbound tcp --port-min 30829  --port-max 30829 --remote 192.168.192.0/22
    ```
    {: pre}

1. Verify that the Kubernetes context is set to your cluster.
    ```sh
    kubectl config current-context
    ```
    {: pre}

    Example output

    ```sh
    <cluster_name>/<cluster_ID>
    ```
    {: screen}

    ```sh
    kubectl version
    ```
    {: pre}

    Example output

    ```sh
    Client Version: v1.25.3
    Kustomize Version: v4.5.7
    Server Version: v1.25.4+IKS
    ```
    {: screen}


### Protecting clusters using context based restrictions
{: #protect-service-endpoints-with-cbr}

Private service endpoint allowlists are no longer supported.  Migrate from private service endpoint allowlists to context based restrictions as soon as possible. For specific migration steps, see [Migrating from a private service endpoint allowlist to context based restrictions (CBR)](/docs/containers?topic=containers-pse-to-cbr-migration).
{: unsupported}

Control access to your public and private service endpoints using context based restriction (CBR) rules.
{: shortdesc}

After you [grant users access to your cluster through {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-iam-platform-access-roles), you can add a secondary layer of security by creating CBR rules for your cluster's public and private service endpoint. Only authorized requests to your cluster master that originate from subnets in the CBR rules will be allowed.

If you want to allow requests from a different VPC than the one your cluster is in, you must include the cloud service endpoint IP address for that VPC in the CBR rules.
{: note}

For example, to access your cluster's private cloud service endpoint, you must connect to your {{site.data.keyword.cloud_notm}} classic network or your VPC network through a VPN or {{site.data.keyword.dl_full_notm}}. You can specify just the subnet for the VPN or {{site.data.keyword.dl_short}} tunnel to your CBR rules so that only authorized users in your organization can access the private cloud service endpoint from that subnet.

Public CBR rules (if your cluster has a public service endpoint) can also help prevent users from accessing your cluster after their authorization is revoked. When a user leaves your organization, you remove their {{site.data.keyword.cloud_notm}} IAM permissions that grant them access to the cluster. However, the user might have copied the admin `kubeconfig` file for a cluster, giving them access to that cluster. If you have a public CBR rule that only allows access to your cluster masters from known public subnets that your organization owns, then the user's attempted access from another public IP address will be blocked.

Worker node subnets are automatically added to and removed from the backend CBR implementation (but not the CBR rules/zones), so that worker nodes can always access the cluster master and users do not need to specifically add these to their own CBR rules.

To learn more about protecting your cluster with CBR rules, see [Protecting cluster resources with context-based restrictions](/docs/containers?topic=containers-cbr) and [Example context-based restrictions scenarios](/docs/containers?topic=containers-cbr-tutorial)

## Creating additional Virtual Private Endpoint gateways in other VPCs and accounts
{: #vpc_cluster_new_vpe_access}

In addition to the VPE gateway that is created for a cluster in its VPC, you can create additional VPE gateways for that cluster to allow access over the private network from other VPCs, regions, and accounts.

* Additional VPE gateways must be created by using the CLI or API. After creation, they can be managed in the web UI.

* For cross-account VPE gateways, you must first create an authorization in the target account. For more information, see [Creating service authorization for cross-account VPE in the console](/docs/vpc?topic=vpc-ordering-cross-account-endpoint-gateway&interface=ui#cross-account-vpe-prerequisite-console).

* No transit gateway or special routing is needed. The VPE gateway handles routing to the target cluster.

The following steps show you how to create a cross-account VPE gateway.

1. Get the necessary information from the target cluster.

    1. Set `ibmcloud target` to the target account, region, and resource group.
    
    1. Get the existing VPE gateway information.
    
        ```sh
        ibmcloud is endpoint-gateway iks-TARGET_CLUSTER_ID
        ```
        {: pre}
    
    1. Note the **Target CRN** (format: `crn:v1:bluemix:public:containers-kubernetes:REGION:a/TARGET_ACCOUNT:TARGET_CLUSTER_ID::`).
    
    1. Note the **Service Endpoints** host names.

2. Create the new VPE gateway in the source account.

    1. Set `ibmcloud target` to the source account, region, and resource group.
    
    1. Verify the VPC exists in this account.
    
        ```sh
        ibmcloud is vpcs
        ```
        {: pre}
    
    1. Create the VPE gateway.
    
        ```sh
        ibmcloud is endpoint-gateway-create --vpc SOURCE_VPC_NAME --target TARGET_CRN --name new-iks-TARGET_CLUSTER_ID --resource-group-name SOURCE_ACCOUNT_RESOURCE_GROUP
        ```
        {: pre}
        
        `SOURCE_VPC_NAME`
        :   The VPC name from the previous step.
        
        `TARGET_CRN`
        :   The CRN from the target cluster's VPE gateway.
        
        `--name`
        :   A name for your VPE gateway.
        
        `SOURCE_ACCOUNT_RESOURCE_GROUP`
        :   The resource group name in the source account.
    
    1. If you get an error "Could not find service", verify the Target CRN is correct. If correct, you need to create the authorization in the target account. See [Creating service authorization for cross-account VPE in the console](/docs/vpc?topic=vpc-ordering-cross-account-endpoint-gateway&interface=ui#cross-account-vpe-prerequisite-console).

3. Add reserved IPs to your VPE gateway.

    You must add at least one reserved IP. Reserved IPs come from your source VPC subnets (one per zone maximum) and are added to the source VPC's private DNS entries.
    
    1. Create a reserved IP for each zone.
    
        ```sh
        ibmcloud is subnet-reserved-ip-create SOURCE_VPC_SUBNET_NAME --vpc SOURCE_VPC_NAME --name ANY_NAME_YOU_CHOOSE --auto-delete true --target VPE_GATEWAY_NAME
        ```
        {: pre}
    
    1. Optional: Add or modify security groups. By default, only the default security group for the source VPC is attached. For VPE gateways, security groups only protect ingress traffic. Ensure the security groups allow all necessary incoming traffic from clients.

4. Test the connection.

    1. From a VSI in the source VPC, use the same host name as the original VPE gateway. Find this in the **Service Endpoints** list or the **VPE Gateway** property from `ibmcloud ks cluster get -c CLUSTER_NAME`.
    
    1. Verify the connection works.
    
        ```sh
        curl -k https://CLUSTERID...:XXXXX/version
        ```
        {: pre}
    
    1. If the connection fails, check the following:
    
        * Security groups on the VSI and VPE gateway allow the necessary traffic
        * VPC ACL allows the traffic
        * Context Based Restriction (CBR) rules on the target cluster allow private traffic from the source VPC (add the three "Cloud Service Endpoint source addresses" from your source VPC to the private CBR rule)


### Example: Target account commands
{: #vpc_cluster_new_vpe_target_example}

The following example shows commands run in the target account to gather information about the cluster and its VPE gateway.

1. Verify you are targeting the correct account.

    ```sh
    ibmcloud target
    ```
    {: pre}

    Example output

    ```sh
    API endpoint:     https://cloud.ibm.com
    Region:           us-east
    User:             user2@example.com
    Account:          Target Account (9f8e7d6c5b4a321fedcba98765432222) <-> 2222222
    Resource group:   default
    ```
    {: screen}

1. List your clusters.

    ```sh
    ibmcloud ks clusters
    ```
    {: pre}

    Example output

    ```sh
    OK
    Name                     ID                     State    Created     Workers   Location        Version                  Resource Group Name   Provider
    vpe-cross-account-test   c8m5n3p2q4x6z1w7y077   normal   1 day ago   2         Washington DC   4.19.25_1572_openshift   default               vpc-gen2
    ```
    {: screen}

1. Get the VPE gateway details. Note the **Target CRN** and **Service Endpoints**.

    ```sh
    ibmcloud is endpoint-gateway iks-c8m5n3p2q4x6z1w7y077
    ```
    {: pre}

    Example output

    ```sh
    Getting endpoint gateway iks-c8m5n3p2q4x6z1w7y077 under account Target Account as user user2@example.com...
                                     
    ID                            r014-7a228b24-4bc4-416c-aede-7fda14e88d98   
    Name                          iks-c8m5n3p2q4x6z1w7y077
    CRN                           crn:v1:bluemix:public:is:us-east:a/9f8e7d6c5b4a321fedcba98765432222::endpoint-gateway:r014-7a228b24-4bc4-416c-aede-7fda14e88d98
    Target                        CRN      
                                  crn:v1:bluemix:public:containers-kubernetes:us-east:a/9f8e7d6c5b4a321fedcba98765432222:c8m5n3p2q4x6z1w7y077::
                                     
    DNS resolution binding mode   primary   
    Target Type                   provider_cloud_service   
    Target Remote                 ID                        Name   Resource type      
                                  No target remote found.      
                                     
    VPC                           ID                                          Name      
                                  r014-464b4e54-48a8-4f6c-b10a-68edc6fd2be4   new-vpcgen2-default-sec-grp-wdc      
                                     
    Private IPs                   ID                                          Name                                   Address       Subnet ID      
                                  0757-3bd457cb-af5a-4ab6-b9bb-6e78d3eaf752   iks-useast1-c8m5n3p2q4x6z1w7y077-2e8   172.22.0.11   0757-0c981aa5-cb47-41d9-ab29-edee98b416f8
                                     
    Service Endpoints             c8m5n3p2q4x6z1w7y077.vpe.private.us-east.containers.cloud.ibm.com
    Lifecycle State               stable   
    Health State                  ok   
    Security groups               ID                                          Name      
                                  r014-3873358e-3180-482b-927e-abcc300ecbf8   kube-vpegw-c8m5n3p2q4x6z1w7y077
                                     
    Created                       2026-04-03T12:14:59-05:00   
    Resource Group                default
    ```
    {: screen}

1. Optional: Get the cluster details to see the VPE gateway URL.

    ```sh
    ibmcloud ks cluster get -c c8m5n3p2q4x6z1w7y077
    ```
    {: pre}

    Example output

    ```sh
    Retrieving cluster c8m5n3p2q4x6z1w7y077...
    OK
                                    
    Name:                           vpe-cross-account-test
    ID:                             c8m5n3p2q4x6z1w7y077
    State:                          normal
    Status:                         All Workers Normal
    Created:                        2026-04-03 11:56:38 -0500 (1 day ago)
    Resource Group ID:              950cec30388441ce809ca0d18b5ca3bc
    Resource Group Name:            default
    Pod Subnet:                     172.17.0.0/18
    Service Subnet:                 172.21.0.0/16
    Workers:                        2
    Worker Zones:                   us-east-1
    Ingress Subdomain:              vpe-cross-account-test-354226545946e7ee0a2c700f061c1661-0000.us-east.containers.appdomain.cloud
    Ingress Secret:                 vpe-cross-account-test-354226545946e7ee0a2c700f061c1661-0000
    Ingress Status:                 healthy
    Ingress Message:                All Ingress components are healthy.
    Trusted Profile ID:             -
    Public Service Endpoint URL:    https://c111-e.us-east.containers.cloud.ibm.com:31100
    Private Service Endpoint URL:   https://c111.private.us-east.containers.cloud.ibm.com:31100
    Pull Secrets:                   enabled in the default namespace
    VPCs:                           r014-464b4e54-48a8-4f6c-b10a-68edc6fd2be4
    VPE Gateway:                    https://c8m5n3p2q4x6z1w7y077.vpe.private.us-east.containers.cloud.ibm.com:31100
    OAuth Server URL:               https://c111-e.us-east.containers.cloud.ibm.com:31264
    Konnectivity Server URL:        https://c8m5n3p2q4x6z1w7y077.vpe.private.us-east.containers.cloud.ibm.com:30996
    Secure By Default Networking:   enabled
    Outbound Traffic Protection:    enabled
    
    Master      
    Status:     Ready (1 day ago)
    State:      deployed
    Health:     normal
    Version:    4.19.25_1572_openshift
    Location:   Washington DC
    URL:        https://c111-e.us-east.containers.cloud.ibm.com:31100
    ```
    {: screen}

### Example: Source account commands
{: #vpc_cluster_new_vpe_source_example}

The following example shows commands run in the source account to create a VPE gateway that connects to the cluster in the target account.

1. Verify you are targeting the correct source account.

    ```sh
    ibmcloud target
    ```
    {: pre}

    Example output

    ```sh
    API endpoint:     https://cloud.ibm.com
    Region:           us-south
    User:             user1@example.com
    Account:          Source Account (a1b2c3d4e5f6789abcdef01234561111) <-> 1111111
    Resource group:   Default
    ```
    {: screen}

1. List your VPCs.

    ```sh
    ibmcloud is vpcs
    ```
    {: pre}

    Example output

    ```sh
    Listing vpcs in resource group Default and region us-south under account Source Account as user user1@example.com...
    ID                                          Name                      Status      Classic access   Default network ACL                             Default security group                           Resource group   Health state   DNS Hub   DNS Resolver Type   
    r006-6f450c4b-c808-40e7-9de6-c61c262a2ae9   dev-ansiblepr-vpc         available   false            vendor-paradox-ravioli-tank                     harmonica-hypnoses-tranquil-alkalize             Default          ok             false     system   
    r006-bd06a98a-1183-42d2-810d-1c564eeb5f39   fvt-vpc-sdnlb-server-40   available   false            sloppy-program-venue-subsiding                  prattle-pension-wilt-recycled                    Default          ok             false     system   
    r006-ecf65055-6868-4368-aa7c-48fc5ac29ff8   network-fvt-us-south      available   false            doorknob-baffle-quintet-poem                    spotted-sandpaper-auction-unluckily              Default          ok             false     system   
    r006-4ff93772-cee9-4d64-9d87-d8b1b781e201   network-fvt-vpc-gen2      available   false            stegosaur-reach-boxlike-alone-stranger-uncork   earplugs-preface-county-juicy-sensitize-babied   Default          ok             false     system
    ```
    {: screen}

1. Create the VPE gateway using the Target CRN from the target account.

    ```sh
    ibmcloud is endpoint-gateway-create --vpc network-fvt-us-south --target crn:v1:bluemix:public:containers-kubernetes:us-east:a/9f8e7d6c5b4a321fedcba98765432222:c8m5n3p2q4x6z1w7y077:: --name new-iks-c8m5n3p2q4x6z1w7y077 --resource-group-name Default
    ```
    {: pre}

    Example output

    ```sh
    Creating endpoint gateway new-iks-c8m5n3p2q4x6z1w7y077 in resource group Default under account Source Account as user user1@example.com...
                                     
    ID                            r006-2009f147-768a-4f6a-b8fa-75f20456cec2   
    Name                          new-iks-c8m5n3p2q4x6z1w7y077
    CRN                           crn:v1:bluemix:public:is:us-south:a/a1b2c3d4e5f6789abcdef01234561111::endpoint-gateway:r006-2009f147-768a-4f6a-b8fa-75f20456cec2
    Target                        CRN      
                                  crn:v1:bluemix:public:containers-kubernetes:us-east:a/9f8e7d6c5b4a321fedcba98765432222:c8m5n3p2q4x6z1w7y077::
                                     
    DNS resolution binding mode   primary   
    Target Type                   provider_cloud_service   
    Target Remote                 ID                        Name   Resource type      
                                  No target remote found.      
                                     
    VPC                           ID                                          Name      
                                  r006-ecf65055-6868-4368-aa7c-48fc5ac29ff8   network-fvt-us-south      
                                     
    Private IPs                   -   
    Service Endpoints             c8m5n3p2q4x6z1w7y077.vpe.private.us-east.containers.cloud.ibm.com
    Lifecycle State               pending   
    Health State                  ok   
    Security groups               ID                                          Name      
                                  r006-7ae081e2-743d-4046-b755-5ca9997ae077   spotted-sandpaper-auction-unluckily      
                                     
    Created                       2026-04-04T18:17:12-05:00   
    Resource Group                Default
    ```
    {: screen}

1. List the subnets to identify which to use for reserved IPs.

    ```sh
    ibmcloud is subnets --vpc network-fvt-us-south
    ```
    {: pre}

    Example output

    ```sh
    Listing subnets in resource group Default and region us-south under account Source Account as user user1@example.com...
    ID                                          Name                           Status      Subnet CIDR       Addresses   ACL                            Public Gateway                             VPC                    Zone         Resource group   
    0717-04288f84-4aef-4938-9fa7-5544a40ba258   network-fvt-us-south-1-priv    available   10.240.0.0/24     251/256     doorknob-baffle-quintet-poem   -                                          network-fvt-us-south   us-south-1   Default   
    0717-cdd4b20c-b48f-454b-b092-ad7aa14b39c8   network-fvt-us-south-1-pubgw   available   10.240.1.0/24     246/256     doorknob-baffle-quintet-poem   pgw-33eb53d0-74e4-11ee-a747-33927b3ab784   network-fvt-us-south   us-south-1   Default   
    0727-8813de08-fffa-45e3-ae67-2ba70703866e   network-fvt-us-south-2-priv    available   10.240.64.0/24    250/256     doorknob-baffle-quintet-poem   -                                          network-fvt-us-south   us-south-2   Default   
    0727-50b14707-c9f6-4f93-9f49-99de13c66161   network-fvt-us-south-2-pubgw   available   10.240.65.0/24    251/256     doorknob-baffle-quintet-poem   pgw-34fe4a70-74e4-11ee-a747-33927b3ab784   network-fvt-us-south   us-south-2   Default   
    0737-7a644374-f121-44c1-b216-5fd94c0362b2   network-fvt-us-south-3-priv    available   10.240.128.0/24   251/256     doorknob-baffle-quintet-poem   -                                          network-fvt-us-south   us-south-3   Default   
    0737-71a34942-304c-4419-9205-3714a3574962   network-fvt-us-south-3-pubgw   available   10.240.129.0/24   251/256     doorknob-baffle-quintet-poem   pgw-36088e80-74e4-11ee-a747-33927b3ab784   network-fvt-us-south   us-south-3   Default
    ```
    {: screen}

1. Create a reserved IP in the first zone and attach it to the VPE gateway.

    ```sh
    ibmcloud is subnet-reserved-ip-create network-fvt-us-south-1-pubgw --vpc network-fvt-us-south --name reserved-ip-for-us-south-1 --auto-delete true --target new-iks-c8m5n3p2q4x6z1w7y077
    ```
    {: pre}

    Example output

    ```sh
    Creating reserved IP in subnet network-fvt-us-south-1-pubgw under account Source Account as user user1@example.com...
                         
    ID                0717-685e1410-2fa1-4e7a-a4e5-27a097ec7a7a   
    Name              reserved-ip-for-us-south-1   
    Address           0.0.0.0   
    Auto delete       true   
    Owner             user   
    Created           2026-04-04T18:18:51-05:00   
    Lifecycle state   pending   
    Target            ID                                          Name                           Resource type      CRN      
                      r006-2009f147-768a-4f6a-b8fa-75f20456cec2   new-iks-c8m5n3p2q4x6z1w7y077   endpoint_gateway   crn:v1:bluemix:public:is:us-south:a/a1b2c3d4e5f6789abcdef01234561111::endpoint-gateway:r006-2009f147-768a-4f6a-b8fa-75f20456cec2
    ```
    {: screen}

1. Verify the reserved IP was added.

    ```sh
    ibmcloud is eg new-iks-c8m5n3p2q4x6z1w7y077
    ```
    {: pre}

    Example output

    ```sh
    Getting endpoint gateway new-iks-c8m5n3p2q4x6z1w7y077 under account Source Account as user user1@example.com...
                                     
    ID                            r006-2009f147-768a-4f6a-b8fa-75f20456cec2   
    Name                          new-iks-c8m5n3p2q4x6z1w7y077
    CRN                           crn:v1:bluemix:public:is:us-south:a/a1b2c3d4e5f6789abcdef01234561111::endpoint-gateway:r006-2009f147-768a-4f6a-b8fa-75f20456cec2
    Target                        CRN      
                                  crn:v1:bluemix:public:containers-kubernetes:us-east:a/9f8e7d6c5b4a321fedcba98765432222:c8m5n3p2q4x6z1w7y077::
                                     
    DNS resolution binding mode   primary   
    Target Type                   provider_cloud_service   
    Target Remote                 ID                        Name   Resource type      
                                  No target remote found.      
                                     
    VPC                           ID                                          Name      
                                  r006-ecf65055-6868-4368-aa7c-48fc5ac29ff8   network-fvt-us-south      
                                     
    Private IPs                   ID                                          Name                         Address      Subnet ID      
                                  0717-685e1410-2fa1-4e7a-a4e5-27a097ec7a7a   reserved-ip-for-us-south-1   10.240.1.5   0717-cdd4b20c-b48f-454b-b092-ad7aa14b39c8      
                                     
    Service Endpoints             c8m5n3p2q4x6z1w7y077.vpe.private.us-east.containers.cloud.ibm.com
    Lifecycle State               stable   
    Health State                  ok   
    Security groups               ID                                          Name      
                                  r006-7ae081e2-743d-4046-b755-5ca9997ae077   spotted-sandpaper-auction-unluckily      
                                     
    Created                       2026-04-04T18:17:12-05:00   
    Resource Group                Default
    ```
    {: screen}

1. Create a reserved IP in the second zone and attach it to the VPE gateway.

    ```sh
    ibmcloud is subnet-reserved-ip-create network-fvt-us-south-2-pubgw --vpc network-fvt-us-south --name reserved-ip-for-us-south-2 --auto-delete true --target new-iks-c8m5n3p2q4x6z1w7y077
    ```
    {: pre}

    Example output

    ```sh
    Creating reserved IP in subnet network-fvt-us-south-2-pubgw under account Source Account as user user1@example.com...
                         
    ID                0727-d315d943-c501-4f69-823d-bb82a2b13b29   
    Name              reserved-ip-for-us-south-2   
    Address           0.0.0.0   
    Auto delete       true   
    Owner             user   
    Created           2026-04-04T18:19:24-05:00   
    Lifecycle state   pending   
    Target            ID                                          Name                           Resource type      CRN      
                      r006-2009f147-768a-4f6a-b8fa-75f20456cec2   new-iks-c8m5n3p2q4x6z1w7y077   endpoint_gateway   crn:v1:bluemix:public:is:us-south:a/a1b2c3d4e5f6789abcdef01234561111::endpoint-gateway:r006-2009f147-768a-4f6a-b8fa-75f20456cec2
    ```
    {: screen}

1. Create a reserved IP in the third zone and attach it to the VPE gateway.

    ```sh
    ibmcloud is subnet-reserved-ip-create network-fvt-us-south-3-pubgw --vpc network-fvt-us-south --name reserved-ip-for-us-south-3 --auto-delete true --target new-iks-c8m5n3p2q4x6z1w7y077
    ```
    {: pre}

    Example output

    ```sh
    Creating reserved IP in subnet network-fvt-us-south-3-pubgw under account Source Account as user user1@example.com...
                         
    ID                0737-afbebd9f-02bd-4b9a-be90-5bacf9836041   
    Name              reserved-ip-for-us-south-3   
    Address           0.0.0.0   
    Auto delete       true   
    Owner             user   
    Created           2026-04-04T18:19:32-05:00   
    Lifecycle state   pending   
    Target            ID                                          Name                           Resource type      CRN      
                      r006-2009f147-768a-4f6a-b8fa-75f20456cec2   new-iks-c8m5n3p2q4x6z1w7y077   endpoint_gateway   crn:v1:bluemix:public:is:us-south:a/a1b2c3d4e5f6789abcdef01234561111::endpoint-gateway:r006-2009f147-768a-4f6a-b8fa-75f20456cec2
    ```
    {: screen}

1. Verify all reserved IPs were added.

    ```sh
    ibmcloud is eg new-iks-c8m5n3p2q4x6z1w7y077
    ```
    {: pre}

    Example output

    ```sh
    Getting endpoint gateway new-iks-c8m5n3p2q4x6z1w7y077 under account Source Account as user user1@example.com...
                                     
    ID                            r006-2009f147-768a-4f6a-b8fa-75f20456cec2   
    Name                          new-iks-c8m5n3p2q4x6z1w7y077
    CRN                           crn:v1:bluemix:public:is:us-south:a/a1b2c3d4e5f6789abcdef01234561111::endpoint-gateway:r006-2009f147-768a-4f6a-b8fa-75f20456cec2
    Target                        CRN      
                                  crn:v1:bluemix:public:containers-kubernetes:us-east:a/9f8e7d6c5b4a321fedcba98765432222:c8m5n3p2q4x6z1w7y077::
                                     
    DNS resolution binding mode   primary   
    Target Type                   provider_cloud_service   
    Target Remote                 ID                        Name   Resource type      
                                  No target remote found.      
                                     
    VPC                           ID                                          Name      
                                  r006-ecf65055-6868-4368-aa7c-48fc5ac29ff8   network-fvt-us-south      
                                     
    Private IPs                   ID                                          Name                         Address        Subnet ID      
                                  0737-afbebd9f-02bd-4b9a-be90-5bacf9836041   reserved-ip-for-us-south-3   10.240.129.5   0737-71a34942-304c-4419-9205-3714a3574962      
                                  0717-685e1410-2fa1-4e7a-a4e5-27a097ec7a7a   reserved-ip-for-us-south-1   10.240.1.5     0717-cdd4b20c-b48f-454b-b092-ad7aa14b39c8      
                                  0727-d315d943-c501-4f69-823d-bb82a2b13b29   reserved-ip-for-us-south-2   10.240.65.5    0727-50b14707-c9f6-4f93-9f49-99de13c66161      
                                     
    Service Endpoints             c8m5n3p2q4x6z1w7y077.vpe.private.us-east.containers.cloud.ibm.com
    Lifecycle State               stable   
    Health State                  ok   
    Security groups               ID                                          Name      
                                  r006-7ae081e2-743d-4046-b755-5ca9997ae077   spotted-sandpaper-auction-unluckily      
                                     
    Created                       2026-04-04T18:17:12-05:00   
    Resource Group                Default
    ```
    {: screen}

1. Test the connection from a VSI in the source VPC.

    ```sh
    curl -k https://c8m5n3p2q4x6z1w7y077.vpe.private.us-east.containers.cloud.ibm.com:31100/version
    ```
    {: pre}

    Example output

    ```sh
    {
      "major": "1",
      "minor": "32",
      "gitVersion": "v1.32.12",
      "gitCommit": "9b706b45b52a0c8bb05847295ee98ffccbabba32",
      "gitTreeState": "clean",
      "buildDate": "2026-02-19T13:30:47Z",
      "goVersion": "go1.23.10 (Red Hat 1.23.10-10.el9) X:strictfipsruntime",
      "compiler": "gc",
      "platform": "linux/amd64"
    }
    ```
    {: screen}

1. Verify the host name resolves to a reserved IP.

    ```sh
    dig +short c8m5n3p2q4x6z1w7y077.vpe.private.us-east.containers.cloud.ibm.com
    ```
    {: pre}

    Example output

    ```sh
    10.240.65.5
    ```
    {: screen}
