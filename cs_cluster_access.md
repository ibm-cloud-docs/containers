---

copyright:
  years: 2014, 2021
lastupdated: "2021-10-04"

keywords: kubernetes, iks, clusters

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

1. [Install the required CLI tools](/docs/containers?topic=containers-cs_cli_install), including the {{site.data.keyword.cloud_notm}} CLI, {{site.data.keyword.containershort_notm}} plug-in (`ibmcloud ks`), and Kubernetes CLI (`kubectl`). For quick access to test features in your cluster, you can also use the [{{site.data.keyword.cloud-shell_notm}}](/docs/containers?topic=containers-cs_cli_install#cloud-shell).
2. [Create your {{site.data.keyword.containerlong_notm}} cluster](/docs/containers?topic=containers-clusters).
3. If your network is protected by a company firewall, [allow access](/docs/containers?topic=containers-firewall#corporate) to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports. For private cloud service endpoint-only clusters, you cannot test the connection to your cluster until you [configure access to the cloud service endpoint subnet](#access_private_se).
4. Check that your cluster is in a healthy state by running `ibmcloud ks cluster get -c <cluster_name_or_ID>`. If your cluster is not in a healthy state, review the [Debugging clusters](/docs/containers?topic=containers-debug_clusters) guide for help. For example, if your cluster is provisioned in an account that is protected by a firewall gateway appliance, you must [configure your firewall settings to allow outgoing traffic to the appropriate ports and IP addresses](/docs/containers?topic=containers-firewall).
5. In the output of the cluster details from the previous step, check the **Public** or **Private Service Endpoint** URL of the cluster.
    *  **Public Service Endpoint URL only**: Continue with [Accessing clusters through the public cloud service endpoint](#access_public_se).
    *  **Private Service Endpoint URL only**: Continue with [Accessing clusters through the private cloud service endpoint](#access_private_se).
    *  **Both service endpoint URLs**: You can access your cluster either through the [public](#access_public_se) or the [private](#access_private_se) service endpoint.



## Accessing clusters through the public cloud service endpoint
{: #access_public_se}

To work with your cluster, set the cluster that you created as the context for a CLI session to run `kubectl` commands.
{: shortdesc}

If you want to use the {{site.data.keyword.cloud_notm}} console instead, you can run CLI commands directly from your web browser in the [{{site.data.keyword.cloud-shell_notm}}](/docs/containers?topic=containers-cs_cli_install#cloud-shell).
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

        ```
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
    1. [Configure a VPN gateway on your local machine](/docs/vpc?topic=vpc-vpn-onprem-example#configuring-onprem-gateway). For example, you might choose to set up StrongSwan on your machine.
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

The Kubernetes master is accessible through the private cloud service endpoint if authorized cluster users are in your {{site.data.keyword.cloud_notm}} private network or are connected to the private network such as through a [classic VPN connection](/docs/iaas-vpn?topic=iaas-vpn-getting-started) or [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl). However, communication with the Kubernetes master over the private cloud service endpoint must go through the <code>166.X.X.X</code> IP address range, which is not routable from a classic VPN connection or through {{site.data.keyword.dl_full_notm}}. You can expose the private cloud service endpoint of the master for your cluster users by using a private network load balancer (NLB). The private NLB exposes the private cloud service endpoint of the master as an internal <code>10.X.X.X</code> IP address range that users can access with the VPN or {{site.data.keyword.dl_full_notm}} connection. If you enable only the private cloud service endpoint, you can use the Kubernetes dashboard or temporarily enable the public cloud service endpoint to create the private NLB.
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

2. Create a YAML file that is named `kube-api-via-nlb.yaml`. This YAML creates a private `LoadBalancer` service and exposes the private cloud service endpoint through that NLB. Replace `<private_service_endpoint_port>` with the port you found in the previous step.
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
        port: <private_service_endpoint_port>
        targetPort: <private_service_endpoint_port>
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

3. To create the private NLB, you must be connected to the cluster master. Because you cannot yet connect through the private cloud service endpoint from a VPN or {{site.data.keyword.dl_full_notm}}, you must connect to the cluster master and create the NLB by using the public cloud service endpoint or Kubernetes dashboard.
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
            ```
            ibmcloud ks cluster config -c <cluster_name_or_ID>
            ```
            {: pre}

        2. Create the NLB and endpoint.
            ```
            kubectl apply -f kube-api-via-nlb.yaml
            ```
            {: pre}

        3. Verify that the `kube-api-via-nlb` NLB is created. In the output, note the `10.x.x.x` **EXTERNAL-IP** address. This IP address exposes the private cloud service endpoint for the Kubernetes master on the port that you specified in your YAML file.
            ```
            kubectl get svc -o wide
            ```
            {: pre}

            In this example output, the IP address for the private cloud service endpoint of the Kubernetes master is `10.186.92.42`.
            ```
            NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)          AGE   SELECTOR
            kube-api-via-nlb         LoadBalancer   172.21.150.118   10.186.92.42     443:32235/TCP    10m   <none>
            ...
            ```
            {: screen}

4. On the client machines where you or your users run `kubectl` commands, add the NLB IP address and the private cloud service endpoint URL to the `/etc/hosts` file. Do not include any ports in the IP address and URL and do not include `https://` in the URL.
    * For macOS and Linux users:
        ```
        sudo nano /etc/hosts
        ```
        {: pre}

    * For Windows users:
        ```
        notepad C:\Windows\System32\drivers\etc\hosts
        ```
        {: pre}
    
        Depending on your local machine permissions, you might need to run Notepad as an administrator to edit the hosts file.
        {: tip}

        Example text to add
        ```
        10.186.92.42      c1.private.us-east.containers.cloud.ibm.com
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

For example, to access your cluster's private cloud service endpoint, you must connect to your {{site.data.keyword.cloud_notm}} classic network or your VPC network through a VPN or {{site.data.keyword.dl_full_notm}}. You can add the subnet for the VPN or {{site.data.keyword.dl_short}} tunnel so that authorized users in your organization can only access the private cloud service endpoint from that subnet.

A private cloud service endpoint allowlist can also help prevent users from accessing your cluster after their authorization is revoked. When a user leaves your organization, you remove their {{site.data.keyword.cloud_notm}} IAM permissions that grant them access to the cluster. However, the user might have copied the API key that contains a functional ID's credentials, which contain the necessary IAM permissions for you cluster. That user can still use those credentials and the private cloud service endpoint address to access your cluster from a different subnet, such as from a different {{site.data.keyword.cloud_notm}} account. If you create an allowlist that includes only the subnets for your VPN tunnel in your organization's {{site.data.keyword.cloud_notm}} account, the user's attempted access from another {{site.data.keyword.cloud_notm}} account is denied.

Worker node subnets are automatically added to and removed from your allowlist so that worker nodes can always access the master through the private cloud service endpoint.

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



## Accessing the cluster master via admission controllers and webhooks
{: #access_webhooks}

Admission controllers intercept authorized API requests from various Kubernetes resources before the requests reach the API server that runs in your {{site.data.keyword.containerlong_notm}} cluster master. Mutating admission webhooks might modify the request, and validating admission webhooks check the request. If either webhook rejects a request, the entire request fails. Advanced features, whether built-in or added on, often require admission controllers as a security precaution and to control what requests are sent to the API server. For more information, see [Using Admission Controllers](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/){: external} and [Dynamic Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} in the Kubernetes documentation.

**What are the default admission controllers in my cluster?**

Review the order of default admission controllers by cluster version in the [`kube-apiserver` component reference information](/docs/containers?topic=containers-service-settings#kube-apiserver).


**Can I create my own admission controllers?**

Yes, see the [Kubernetes](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} documentation for more information.

As noted in the Kubernetes documentation, you can use admission controllers for operations that are otherwise handled by the control plane. As such, take great caution when you configure a custom admission controller. You are responsible for any changes that happen in your cluster because of a custom admission controller.
{: important}

Keep in mind the following considerations when you configure a webhook.

* Create [replica pods](/docs/containers?topic=containers-app#replicaset) for the webhook so that if one pod goes down, the webhook can still process requests from your resources. Spread the replica pods across zones, if possible.
* Set appropriate CPU and memory [resource requests and limits](/docs/containers?topic=containers-app#resourcereq) for your webhook.
* Add [liveness and readiness probes](/docs/containers?topic=containers-app#probe) to help make sure your webhook container is running and ready to serve requests.
* Set pod [anti-affinity scheduling rules](/docs/containers?topic=containers-app#affinity) to prefer that your webhook pods run on different worker nodes and zones when possible. In clusters that run Kubernetes version 1.18 or later, you might use [pod topology](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/){: external} instead. However, avoid [taints](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/){: external} or forced affinity that might restrict where the webhook pods can be scheduled.
* [Set pod priority](/docs/containers?topic=containers-pod_priority) to `system-cluster-critical` for the webhook pods so that other pods cannot take resources from your webhook pods.
* Scope your webhook to the appropriate namespace. Avoid webhooks that process resources that run in system-critical namespaces that are set up in your cluster by default, such as `kube-system`, `ibm-system`, `ibm-operators`, `calico-system`, `tigera-operator` and `openshift-*` namespaces.
* Make sure that the worker nodes in your cluster are [the right size for running your webhook applications](/docs/containers?topic=containers-strategy#sizing). For example, if your pods request more CPU or memory than the worker node can provide, the pods are not scheduled.


**What other types of apps use admission controllers?**

Many cluster add-ons, plug-ins, and other third-party extensions use admission controllers. Some common ones include:
*   [Portieris](/docs/openshift?topic=openshift-images#portieris-image-sec)
*   [Istio](/docs/containers?topic=containers-istio-about)


**I need help with a broken webhook. What can I do?**

See [Cluster cannot update because of broken webhook](/docs/containers?topic=containers-webhooks_update).

## Accessing private clusters by using the Wireguard VPN
{: #access_vpn_containers}

You can use the Wireguard VPN to securely connect to Kubernetes clusters with only a private network connection. 
{: shortdesc}

Before you begin, make sure that you have a Kubernetes cluster with a private-only network connection and that the cluster is assigned a private service endpoint.

1. Create a virtual server instance (VSI) that is connected to the same private network that your Kubernetes cluster runs in. This VSI serves as a jumpbox for your cluster. For example, if you have a private VPC cluster, make sure that you create the VSI in the same VPC. For more information about creating the VSI, consult your infrastructure provider's documentation. The VSI must meet the following specifications:
    - The VSI must have a minimum of 2 vCPUs, 8 GB memory, and 25 GB of disk space.
    - The VSI must run an operating system that is supported by Wireguard. For example, the steps in this topic were tested on an Ubuntu VSI.
    - You must create an SSH key that is stored on the VSI so that you can connect to your VSI via SSH.
    - You must assign a public IP address to your VSI so that your VSI is accessible over the public network.
    - Your VSI must allow at least the following network traffic. You can optionally open up more network traffic on your VSI if required for the apps that run on your cluster.
        - Inbound TCP traffic on port 22 for SSH connections
        - Inbound UDP traffic on port 51820 for the Wireguard server
        - All outbound traffic
2. Log in to your VSI by using the public IP address of the VSI.
    ```
    ssh -i <filepath_to_sshkey> root@<public_IP>
    ```
    {: pre}

3. Install the Wireguard server.

    The following steps are specific to VSIs that run Ubuntu. If you run a different Linux distribution, refer to the [Wireguard documentation](https://www.wireguard.com/install/){: external}.
    {: note}

    1. Update the Ubuntu operating system.
        ```
        apt update
        ```
        {: pre}
        
        ```
        apt upgrade
        ```
        {: pre}

    2. Check if your VSI requires a reboot to apply the updates.
        ```
        cat /var/run/reboot-required
        ```
        {: pre}

        Example output
        ```
        *** System restart required ***
        ```
        {: screen}

    3. If a reboot is required, reboot the VSI.
        ```
        reboot
        ```
        {: pre}

    4. Wait for the reboot to finish. Then, log in to your VSI again.
        ```
        ssh -i <filepath_to_sshkey> root@<public_IP>
        ```
        {: pre}

    5. Install the Wireguard server.
        ```
        apt install wireguard
        ```
        {: pre}

4. Create Wireguard server keys.
    1. On your VSI, create a new directory to store your keys.
        ```
        mkdir -p /etc/wireguard/keys
        ```
        {: pre}

    2. Create a private and a public Wireguard server key.
        ```
        wg genkey | tee /etc/wireguard/keys/server.key | wg pubkey | tee /etc/wireguard/keys/server.key.pub
        ```
        {: pre}

    3. Display the public and the private key that you created. </br>
        **Private key**:
        ```
        cat /etc/wireguard/keys/server.key
        ```
        {: pre}

        **Public key**:
        ```
        cat /etc/wireguard/keys/server.key.pub
        ```
        {: pre}

5. Retrieve the network interface that your VSI uses to route traffic.
    ```
    ip -o -4 route show to default | awk '{print $5}'
    ```
    {: pre}

    Example output

    ```sh
    ens3
    ```
    {: screen}

6. Create the Wireguard server configuration.
    1. Open the Wireguard server configuration. The configuration is intially empty.
        ```sh
        nano /etc/wireguard/wg0.conf
        ```
        {: pre}

    2. Add the following content to your configuration. In the `Interface` section, enter the private key from your Wireguard server that you created and change `<eth0>` to the network interface that you retrieved earlier. The IP address is a random address within the VPN tunnel that you assign to the Wireguard server.

        The server configuration does not yet include the Wireguard client configuration (`Peer`). You add the client configuration after you set up the Wireguard client on your local machine in a later step.
        {: note}

        ```
        [Interface]
        PrivateKey = <wireguard_server_private_key>
        Address = 172.16.0.1/24
        PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o <eth0> -j MASQUERADE
        PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o <eth0> -j MASQUERADE
        ListenPort = 51820
        ```
        {: codeblock}

    3. Save your changes and exit the nano editor.
    4. Change the permissions to your Wireguard configuration and server key file.
        ```
        chmod 600 /etc/wireguard/wg0.conf /etc/wireguard/keys/server.key
        ```
        {: pre}

7. Start the Wireguard server.
    1. Start the Wireguard server.
        ```
        wg-quick up wg0
        ```
        {: pre}

    2. Show the status of your Wireguard server connections. Note that your output only shows an interface section and no peer section as the Wireguard client is not successfully configured yet.
        ```
        wg show
        ```
        {: pre}

    3. Change the VSI system settings to automatically start the Wireguard server every time the VSI is booted.
        ```
        systemctl enable wg-quick@wg0
        ```
        {: pre}

8. Enable IPv4 forwarding on the Wireguard server.
    1. Open the VSI system and network settings.
        ```sh
        nano /etc/sysctl.conf
        ```
        {: pre}

    2. Remove the comment (`#`) from the `net.ipv4.ip_forward=1` line. Your configuration looks similar to the following:
        ```
        ...
        # Uncomment the next line to enable TCP/IP SYN cookies
        # See http://lwn.net/Articles/277146/
        # Note: This may impact IPv6 TCP sessions too
        #net.ipv4.tcp_syncookies=1

        # Uncomment the next line to enable packet forwarding for IPv4
        net.ipv4.ip_forward=1
        ...
        ```
        {: screen}
        
    3. Enable IPv4 forwarding on your VSI. 
        ```
        sysctl -p
        ```
        {: pre}

9. Retrieve the list of IP addresses that you need to allow in your Wireguard client configuration so that you can successfully connect to your private Kubernetes cluster.
    1. Get the details of your cluster and note the **Ingress Subdomain** and the **Private Service Endpoint URL**.
        ```sh
        ibmcloud ks cluster get --cluster <cluster_name_or_ID>
        ```
        {: pre}

    2. Retrieve the IP address that is assigned to the Ingress subdomain and your private service endpoint URL.
        ```
        nslookup <ingress_subdomain>
        ```
        {: pre}

        ```
        nslookup <private_service_endpoint_URL>
        ```
        {: pre}

        To successfully run an `nslookup` command on your private service endpoint URL, remove `https://` and the port from your URL. Alternatively, you can note all IP address CIDRs for the region that your cluster master is in as shown in step 3 of [Opening required ports in a private firewall](/docs/containers?topic=containers-firewall#firewall_private).
        {: tip}

    3. Get the IP address CIDR of all the VPC subnets, private VLANs, or on-prem networks that your cluster worker nodes are connected to. For example, if you created a VPC cluster in {{site.data.keyword.cloud_notm}}, you can get the subnet CIDR by getting the details for each worker node.  
        ```sh
        ibmcloud ks worker get --worker <worker_ID> --cluster <cluster_name_or_ID>
        ```
        {: pre}

10. Install, configure, and activate the Wireguard client.
    1. Follow the [instructions](https://www.wireguard.com/install/){: external} to install the Wireguard client on your local machine.
    2. Open the client.
    3. Click `+` to create an empty VPN tunnel. A Wireguard private and public key is automatically created for you and displayed in the client configuration.
    4. Enter a name for your client configuration.
    5. Add the following configuration after the `PrivateKey` that is displayed in the `Interface` section. The CIDR `192.168.3.217/32` is a random CIDR that you assign to the client to use within the VPN tunnel.

        Do not change the `PrivateKey` field, which can alter your Wireguard client private key and make the tunnel that you created unusable.
        {: important}

        In the `Peer` section, enter the following information:
        - `PublicKey`: The Wireguard server public key that you created earlier.
        - `AllowedIPs`: The IP address CIDRs of worker nodes, Ingress subdomain, the private service endpoint URL, and the Wireguard server that you retrieved earlier, separated by commas.
        - `Endpoint`: The public IP address of the jumpbox VSI.  

        ```
        Address = 192.168.3.217/32

        [Peer]
        PublicKey = <public_wireguard_server_key>
        AllowedIPs = <worker_CIDR>,<ingress_subdomain_CIDR>,<private_service_endpoint_URL_CIDR>,<wireguard_server_CIDR>
        Endpoint = <vsi_public_IP>:51820
        ```
        {: codeblock}

        Your final client configuration looks similar to the following:
        ```
        [Interface]
        PrivateKey = aAAA1a1AAAAAaaaaa1aaa1AAAa1AaAAaAaAAAaAaaAa=
        Address = 192.168.3.217/32

        [Peer]
        PublicKey = Aaaa1A1aaaaaaaaa1aaa1AAAa1AaAAAAAAAAAAaAaaAa=
        AllowedIPs = 166.9.58.104, 10.241.0.0/24, 172.16.0.1/24
        Endpoint = 167.63.170.188:51820
        ```
        {: codeblock}

    6. Save your configuration.
    7. Click **Activate** to start your Wireguard client. If the client is activated successfully, the status changes to **Active**.
    8. Copy the Wireguard client public key.

10. Finish the Wireguard server configuration.
    1. On your VSI, open the Wireguard server configuration again.
        ```sh
        nano /etc/wireguard/wg0.conf
        ```
        {: pre}

    2. Add the `Peer` section to your Wireguard server configuration to add the Wireguard client. Enter the Wireguard client public key in the `PublicKey` field and the IP address CIDR that you assigned to the client in the `AllowedIPs` field.  
        ```
        ...
        [Peer]
        PublicKey = <wireguard_client_public_key>
        AllowedIPs = 192.180.1.160/32
        ```
        {: codeblock}

        Your server configuration looks similar to the following:
        ```
        [Interface]
        PrivateKey = <wireguard_server_private_key>
        Address = 172.16.0.1/24
        PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
        PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o ens3 -j MASQUERADE
        ListenPort = 51820

        [Peer]
        PublicKey = <wireguard_client_public_key>
        AllowedIPs = 192.180.1.160/32
        ```
        {: codeblock}

    3. Stop the Wireguard server and start it again to apply your changes.
        ```
        wg-quick down wg0
        ```
        {: pre}

        ```
        wg-quick up wg0
        ```
        {: pre}

    4. Show the updated status of your Wireguard server connections. The interface and peer connections are displayed in your CLI output.
        ```
        wg show wg0
        ```
        {: pre}

        Example output
        ```
        interface: wg0
        public key: AA11aa1aa/aa1AaA1AaaaAAAaa1AAaaA1aAAAAaaAAA=
        private key: (hidden)
        listening port: 51820

        peer: a11aAaA+AaaaaaaaA1aAAaAA1/1AaAaAaaAA1AAA/aA=
        allowed ips: 192.180.1.160/32
        ```
        {: screen}

11. Check that you can connect to the private Kubernetes cluster from your local machine.
    1. From the [Kubernetes clusters console](https://cloud.ibm.com/kubernetes/clusters){: external}, select your private cluster that you want to connect to.  
    2. On the cluster overview page, go to the **Networking** section and copy the **Ingress subdomain**.
    3. Ping the Ingress subdomain to verify that you can connect to your private Kubernetes cluster.
    4. From the cluster overview page, open the Kubernetes web console. 





