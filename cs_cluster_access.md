---

copyright:
  years: 2014, 2019
lastupdated: "2019-12-13"

keywords: kubernetes, iks, clusters

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:download: .download}
{:preview: .preview} 

# Accessing Kubernetes clusters
{: #access_cluster}

After your {{site.data.keyword.containerlong}} cluster is created, you can begin working with your cluster by accessing the cluster.
{: shortdesc}

## Prerequisites
{: #prereqs}

1. [Install the required CLI tools](/docs/containers?topic=containers-cs_cli_install), including the {{site.data.keyword.cloud_notm}} CLI, {{site.data.keyword.containershort_notm}} plug-in(`ibmcloud ks`), and Kubernetes CLI (`kubectl`).
2. [Create your Kubernetes cluster](/docs/containers?topic=containers-clusters).
3. If your network is protected by a company firewall, [allow access](/docs/containers?topic=containers-firewall) to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports. For private service endpoint-only clusters, you cannot test the connection to your cluster until you expose the private service endpoint of the master to the cluster by using a [private NLB](#access_private_se).
4. Check that your cluster is in a healthy state by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`. If your cluster is not in a healthy state, review the [Debugging clusters](/docs/containers?topic=containers-cs_troubleshoot) guide for help. For example, if your cluster is provisioned in an account that is protected by a firewall gateway appliance, you must [configure your firewall settings to allow outgoing traffic to the appropriate ports and IP addresses](/docs/containers?topic=containers-firewall).

<br />



## Accessing Kubernetes clusters through the public service endpoint
{: #access_public_se}

To work with your cluster, set the cluster that you created as the context for a CLI session to run `kubectl` commands.
{: shortdesc}

If you want to use the {{site.data.keyword.cloud_notm}} console instead, you can run CLI commands directly from your web browser in the [Kubernetes Terminal](/docs/containers?topic=containers-cs_cli_install#cli_web).
{: tip}

1. If your network is protected by a company firewall, allow access to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports.
   1. [Allow access to the public endpoints for the `ibmcloud` API and the `ibmcloud ks` API in your firewall](/docs/containers?topic=containers-firewall#firewall_bx).
   2. [Allow your authorized cluster users to run `kubectl` commands](/docs/containers?topic=containers-firewall#firewall_kubectl) to access the master through the public only, private only, or public and private service endpoints.
   3. [Allow your authorized cluster users to run `calicotl` commands](/docs/containers?topic=containers-firewall#firewall_calicoctl) to manage Calico network policies in your cluster.

2. Set the cluster that you created as the context for this session. Complete these configuration steps every time that you work with your cluster.
   1. Get the command to set the environment variable and download the Kubernetes configuration files.
      ```
      ibmcloud ks cluster config --cluster <cluster_name_or_ID>
      ```
      {: pre}
      When the download of the configuration files is finished, a command is displayed that you can use to set the path to the local Kubernetes configuration file as an environment variable.

      Example for OS X:
      ```
      export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
      ```
      {: screen}
   2. Copy and paste the command that is displayed in your terminal to set the `KUBECONFIG` environment variable.
   3. Verify that the `KUBECONFIG` environment variable is set properly.
      Example for OS X:
      ```
      echo $KUBECONFIG
      ```
      {: pre}

      Output:
      ```
      /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
      ```
      {: screen}

3. Launch your Kubernetes dashboard with the default port `8001`.
   1. Set the proxy with the default port number.
      ```
      kubectl proxy
      ```
      {: pre}

      ```
      Starting to serve on 127.0.0.1:8001
      ```
      {: screen}

   2. Open the following URL in a web browser to see the Kubernetes dashboard.
      ```
      http://localhost:8001/ui
      ```
      {: codeblock}

<br />


## Accessing clusters through the private service endpoint
{: #access_private_se}

The Kubernetes master is accessible through the private service endpoint if authorized cluster users are in your {{site.data.keyword.cloud_notm}} private network or are connected to the private network through a [VPN connection](/docs/infrastructure/iaas-vpn?topic=VPN-getting-started) or [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link). However, communication with the Kubernetes master over the private service endpoint must go through the <code>166.X.X.X</code> IP address range, which is not routable from a VPN connection or through {{site.data.keyword.cloud_notm}} Direct Link. You can expose the private service endpoint of the master for your cluster users by using a private network load balancer (NLB). The private NLB exposes the private service endpoint of the master as an internal <code>10.X.X.X</code> IP address range that users can access with the VPN or {{site.data.keyword.cloud_notm}} Direct Link connection. If you enable only the private service endpoint, you can use the Kubernetes dashboard or temporarily enable the public service endpoint to create the private NLB.
{: shortdesc}


1. If your network is protected by a company firewall, allow access to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports.
  1. [Allow access to the public endpoints for the `ibmcloud` API and the `ibmcloud ks` API in your firewall](/docs/containers?topic=containers-firewall#firewall_bx).
  2. [Allow your authorized cluster users to run `kubectl` commands](/docs/containers?topic=containers-firewall#firewall_kubectl). Note that you cannot test the connection to your cluster in step 6 until you expose the private service endpoint of the master to the cluster by using a private NLB.

2. Get the private service endpoint URL and port for your cluster.
  ```
  ibmcloud ks cluster get --cluster <cluster_name_or_ID>
  ```
  {: pre}

  In this example output, the **Private Service Endpoint URL** is `https://c1.private.us-east.containers.cloud.ibm.com:25073`.
  ```
  Name:                           setest
  ID:                             b8dcc56743394fd19c9f3db7b990e5e3
  State:                          normal
  Created:                        2019-04-25T16:03:34+0000
  Location:                       wdc04
  Master URL:                     https://c1.private.us-east.containers.cloud.ibm.com:25073
  Public Service Endpoint URL:    -
  Private Service Endpoint URL:   https://c1.private.us-east.containers.cloud.ibm.com:25073
  Master Location:                Washington D.C.
  ...
  ```
  {: screen}

3. Create a YAML file that is named `kube-api-via-nlb.yaml`. This YAML creates a private `LoadBalancer` service and exposes the private service endpoint through that NLB. Replace `<private_service_endpoint_port>` with the port you found in the previous step.
  ```
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

4. To create the private NLB, you must be connected to the cluster master. Because you cannot yet connect through the private service endpoint from a VPN or {{site.data.keyword.cloud_notm}} Direct Link, you must connect to the cluster master and create the NLB by using the public service endpoint or Kubernetes dashboard.
  * If you enabled the private service endpoint only, you can use the Kubernetes dashboard to create the NLB. The dashboard automatically routes all requests to the private service endpoint of the master.
    1.  Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/).
    2.  From the menu bar, select the account that you want to use.
    3.  From the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon"), click **Kubernetes**.
    4.  On the **Clusters** page, click the cluster that you want to access.
    5.  From the cluster detail page, click the **Kubernetes Dashboard**.
    6.  Click **+ Create**.
    7.  Select **Create from file**, upload the `kube-api-via-nlb.yaml` file, and click **Upload**.
    8.  In the **Overview** page, verify that the `kube-api-via-nlb` service is created. In the **External endpoints** column, note the `10.x.x.x` address. This IP address exposes the private service endpoint for the Kubernetes master on the port that you specified in your YAML file.

  * If you also enabled the public service endpoint, you already have access to the master.
    1. Get the command to set the environment variable and download the Kubernetes configuration files.
        ```
        ibmcloud ks cluster config --cluster <cluster_name_or_ID>
        ```
        {: pre}
        When the download of the configuration files is finished, a command is displayed that you can use to set the path to the local Kubernetes configuration file as an environment variable.

        Example for OS X:
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}
    2. Copy and paste the command that is displayed in your terminal to set the `KUBECONFIG` environment variable.
    3. Create the NLB and endpoint.
      ```
      kubectl apply -f kube-api-via-nlb.yaml
      ```
      {: pre}
    4. Verify that the `kube-api-via-nlb` NLB is created. In the output, note the `10.x.x.x` **EXTERNAL-IP** address. This IP address exposes the private service endpoint for the Kubernetes master on the port that you specified in your YAML file.
      ```
      kubectl get svc -o wide
      ```
      {: pre}

      In this example output, the IP address for the private service endpoint of the Kubernetes master is `10.186.92.42`.
      ```
      NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)          AGE   SELECTOR
      kube-api-via-nlb         LoadBalancer   172.21.150.118   10.186.92.42     443:32235/TCP    10m   <none>
      ...
      ```
      {: screen}

5. On the client machines where you or your users run `kubectl` commands, add the NLB IP address and the private service endpoint URL to the `/etc/hosts` file. Do not include any ports in the IP address and URL and do not include `https://` in the URL.
  * For OSX and Linux users:
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

  Example text to add:
  ```
  10.186.92.42      c1.private.us-east.containers.cloud.ibm.com
  ```
  {: codeblock}

6. Verify that you are connected to the private network through one of the following methods:
  * Classic clusters: Use a [VPN](/docs/infrastructure/iaas-vpn?topic=VPN-getting-started) or [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) connection.
  * VPC clusters: Use a [VPC VPN](/docs/vpc-on-classic-network?topic=vpc-on-classic-network---using-vpn-with-your-vpc) connection.

7. Get the command to set the environment variable and download the Kubernetes configuration files.
    ```
    ibmcloud ks cluster config --cluster <cluster_name_or_ID>
    ```
    {: pre}
    When the download of the configuration files is finished, a command is displayed that you can use to set the path to the local Kubernetes configuration file as an environment variable.

    Example for OS X:
    ```
    export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
    ```
    {: screen}

8. Optional: If you have both the public and private service endpoints enabled, update your local Kubernetes configuration file to use the private service endpoint. By default, the public service endpoint is downloaded to the configuration file.
  1. Navigate to the `kubeconfig` directory and open the file.
    ```
    cd /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/<cluster_name> && nano touch kube-config-prod-dal10-mycluster.yml
    ```
    {: pre}
  2. Edit your Kubernetes configuration file to add the word `private` to the service endpoint URL. For example, in the Kubernetes configuration file `kube-config-prod-dal10-mycluster.yml`, the server field might look like `server: https://c1.us-east.containers.cloud.ibm.com:30426`. You can change this URL to the private service endpoint URL by changing the server field to `server: https://c1.private.us-east.containers.cloud.ibm.com:30426`.
  3. Repeat these steps each time that you run `ibmcloud ks cluster config`.

9. Copy and paste the command that is displayed in your terminal to set the `KUBECONFIG` environment variable.

10. Verify that the `kubectl` commands run properly with your cluster through the private service endpoint by checking the Kubernetes CLI server version.
  ```
  kubectl version --short
  ```
  {: pre}

  Example output:
  ```
  Client Version: v1.14.9
  Server Version: v1.14.9
  ```
  {: screen}

<br />





