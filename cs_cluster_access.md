---

copyright:
  years: 2014, 2023
lastupdated: "2023-06-08"

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

### Accessing VPC clusters through the private cloud service endpoint
{: #vpc_private_se}

The Kubernetes master is accessible through the private cloud service endpoint if authorized cluster users are in your {{site.data.keyword.cloud_notm}} private network or are connected to the private network, such as through a [VPC VPN connection](/docs/vpc?topic=vpc-vpn-onprem-example). However, communication with the Kubernetes master over the private cloud service endpoint must go through the `166.X.X.X` IP address range, which you must configure in your VPN gateway and connection setup.
{: shortdesc}

1. Set up your {{site.data.keyword.vpc_short}} VPN and connect to your private network through the VPN.
    1. [Configure a VPN gateway on your local machine](/docs/vpc?topic=vpc-vpn-onprem-example). For example, you might choose to set up strongSwan on your machine.
    2. [Create a VPN gateway in your VPC, and create the connection between the VPC VPN gateway and your local VPN gateway](/docs/vpc?topic=vpc-vpn-create-gateway#vpn-create-ui). In the **New VPN connection for VPC** section, add the `166.8.0.0/14` subnet to the **Local subnets** field. If you have a multizone cluster, repeat this step to configure a VPC gateway on a subnet in each zone where you have worker nodes.
    3. Verify that you are connected to the private network through your {{site.data.keyword.vpc_short}} VPN connection.

2. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
    ```sh
    ibmcloud ks cluster config -c <cluster_name_or_ID> --endpoint private
    ```
    {: pre}

3. Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
    ```sh
    kubectl config current-context
    ```
    {: pre}

    Example output

    ```sh
    <cluster_name>/<cluster_ID>
    ```
    {: screen}

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
        1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/).
        2. From the menu bar, select the account that you want to use.
        3. From the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon"), click **Kubernetes**.
        4. On the **Clusters** page, click the cluster that you want to access.
        5. From the cluster detail page, click the **Kubernetes Dashboard**.
        6. Click **+ Create**.
        7. Select **Create from file**, upload the `kube-api-via-nlb.yaml` file, and click **Upload**.
        8. In the **Overview** page, verify that the `kube-api-via-nlb` service is created. In the **External endpoints** column, note the `10.x.x.x` address. This IP address exposes the private cloud service endpoint for the Kubernetes master on the port that you specified in your YAML file.

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

### Creating an allowlist for the private cloud service endpoint
{: #private-se-allowlist}

Control access to your private cloud service endpoint by creating a subnet allowlist.
{: shortdesc}

After you [grant users access to your cluster through {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#checking-perms), you can add a secondary layer of security by creating an allowlist for the private cloud service endpoint. Only authorized requests to your cluster master that originate from subnets in the allowlist are permitted through the cluster's private cloud service endpoint.

If you want to allow requests from a different VPC than the one your cluster is in, you must include the cloud service endpoint for that VPC in the allowlist.
{: note}

For example, to access your cluster's private cloud service endpoint, you must connect to your {{site.data.keyword.cloud_notm}} classic network or your VPC network through a VPN or {{site.data.keyword.dl_full_notm}}. You can add the subnet for the VPN or {{site.data.keyword.dl_short}} tunnel so that only authorized users in your organization can access the private cloud service endpoint from that subnet.

A private cloud service endpoint allowlist can also help prevent users from accessing your cluster after their authorization is revoked. When a user leaves your organization, you remove their {{site.data.keyword.cloud_notm}} IAM permissions that grant them access to the cluster. However, the user might have copied the API key that contains a functional ID's credentials, which contain the necessary IAM permissions for you cluster. That user can still use those credentials and the private cloud service endpoint address to access your cluster from a different subnet, such as from a different {{site.data.keyword.cloud_notm}} account. If you create an allowlist that includes only the subnets for your VPN tunnel in your organization's {{site.data.keyword.cloud_notm}} account, the user's attempted access from another {{site.data.keyword.cloud_notm}} account is denied.

Worker node subnets are automatically added to and removed from your allowlist so that worker nodes can always access the master through the private cloud service endpoint.

By default, private cloud service endpoint allowlists are limited to 20 subnets. If you need more than 20 subnets in your allowlist, you can [open a support ticket](/docs/containers?topic=containers-get-help#help-support) to increase the limit to 75. 
{: tip}

If the public cloud service endpoint is enabled for your cluster, authorized requests are still permitted through the public cloud service endpoint. Therefore, the private cloud service endpoint allowlist is most effective for controlling access to clusters that have only the private cloud service endpoint enabled.
{: note}

Before you begin:
* [Access your cluster through the private cloud service endpoint](#access_private_se).
* [Grant users access to your cluster through {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#checking-perms).

To create a private cloud service endpoint allowlist:

1. Get the subnets that you want to add to the allowlist. For example, you might get the subnet for the connection through your VPN or {{site.data.keyword.dl_short}} tunnel to your {{site.data.keyword.cloud_notm}} private network.

2. Enable the subnet allowlist feature for a cluster's private cloud service endpoint. Now, access to the cluster via the private cloud service endpoint is blocked for any requests that originate from a subnet that is not in the allowlist. Your worker nodes continue to run and have access to the master.
    ```sh
    ibmcloud ks cluster master private-service-endpoint allowlist enable --cluster <cluster_name_or_ID>
    ```
    {: pre}

3. Add subnets from which authorized users can access your private cloud service endpoint to the allowlist.
    ```sh
    ibmcloud ks cluster master private-service-endpoint allowlist add --cluster <cluster_name_or_ID> --subnet <subnet_CIDR> [--subnet <subnet_CIDR> ...]
    ```
    {: pre}

4. Verify that the subnets in your allowlist are correct. The allowlist includes subnets that you manually added and subnets that are automatically added and managed by IBM, such as worker node subnets.
    ```sh
    ibmcloud ks cluster master private-service-endpoint allowlist get --cluster <cluster_name_or_ID>
    ```
    {: pre}

Your authorized users can now continue with [Accessing clusters through the private cloud service endpoint](#access_private_se).

## Accessing VPC clusters through the Virtual Private Endpoint Gateway
{: #vpc_vpe}

[Virtual Private Endpoint Gateway](/docs/vpc?topic=vpc-about-vpe) is created for VPC clusters automatically. The Kubernetes master is accessible through this Virtual Private Endpoint gateway if authorized cluster users are connected to the same VPC where the cluster is deployed, such as through a [{{site.data.keyword.vpc_short}} VPN](/docs/vpc?topic=vpc-vpn-overview). In this case, the `kubeconfig` is configured with the Virtual Private Endpoint (VPE) URL which is private DNS name and could be resolved only by the {{site.data.keyword.vpc_short}} Private DNS service. The {{site.data.keyword.vpc_short}} Private DNS server addresses are `161.26.0.7` and `161.26.0.8`.
{: shortdesc}

1. Set up your {{site.data.keyword.vpc_short}} VPN and connect to your VPC through VPN.

    1. Configure a [client-to-site](/docs/vpc?topic=vpc-vpn-client-to-site-overview) or [site-to-site](/docs/vpc?topic=vpc-vpn-onprem-example) VPN to your VPC. For example, you might choose to set up a client-to-site connection with an OpenVPN Client.
    2. In case of client-to-site VPN for {{site.data.keyword.vpc_short}} service, you must specify the {{site.data.keyword.vpc_short}} Private DNS service addresses when you provision the VPN server as mentioned in the [considerations](/docs/vpc?topic=vpc-client-to-site-vpn-planning#existing-vpc-configuration-considerations), and you must create a VPN route after the VPN server is provisioned, with destination `161.26.0.0/16` and action `translate`.
    3. In case of site-to-site VPN for {{site.data.keyword.vpc_short}} service, you must follow the [Accessing service endpoints through VPN guide](/docs/vpc?topic=vpc-build-se-connectivity-using-vpn) and configure the {{site.data.keyword.vpc_short}} Private DNS service addresses.
    4. Verify that you are connected to the VPC through your {{site.data.keyword.vpc_short}} VPN connection.

2. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
    ```sh
    ibmcloud ks cluster config -c <cluster_name_or_ID> --endpoint vpe
    ```
    {: pre}

3. Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
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
