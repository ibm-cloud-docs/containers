---

copyright:
  years: 2014, 2025
lastupdated: "2025-05-29"


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
    2. [Create a VPN gateway in your VPC, and create the connection between the VPC VPN gateway and your local VPN gateway](/docs/vpc?topic=vpc-vpn-create-gateway&interface=ui#vpn-create-ui). In the **New VPN connection for VPC** section, add the `166.8.0.0/14` subnet to the **Local subnets** field. If you have a multizone cluster, repeat this step to configure a VPC gateway on a subnet in each zone where you have worker nodes.
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

Public CBR rules (if your cluster has a public service endpoint) can also help prevent users from accessing your cluster after their authorization is revoked. When a user leaves your organization, you remove their {{site.data.keyword.cloud_notm}} IAM permissions that grant them access to the cluster. However, the user might have copied the admin kubeconfig file for a cluster, giving them access to that cluster. If you have a public CBR rule that only allows access to your cluster masters from known public subnets that your organization owns, then the user's attempted access from another public IP address will be blocked.

Worker node subnets are automatically added to and removed from the backend CBR implementation (but not the CBR rules/zones), so that worker nodes can always access the cluster master and users do not need to specifically add these to their own CBR rules.

To learn more about protecting your cluster with CBR rules, see [Protecting cluster resources with context-based restrictions](/docs/containers?topic=containers-cbr) and [Example context-based restrictions scenarios](/docs/containers?topic=containers-cbr-tutorial)
