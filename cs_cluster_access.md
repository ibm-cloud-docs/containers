---

copyright:
  years: 2014, 2020
lastupdated: "2020-10-15"

keywords: kubernetes, iks, clusters

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: #java .ph data-hd-programlang='java'}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: #swift .ph data-hd-programlang='swift'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vb.net: .ph data-hd-programlang='vb.net'}
{:video: .video}



# Accessing Kubernetes clusters
{: #access_cluster}
{: help}
{: support}

After your {{site.data.keyword.containerlong}} cluster is created, you can begin working with your cluster by accessing the cluster.
{: shortdesc}

## Prerequisites
{: #prereqs}

1. [Install the required CLI tools](/docs/containers?topic=containers-cs_cli_install), including the {{site.data.keyword.cloud_notm}} CLI, {{site.data.keyword.containershort_notm}} plug-in(`ibmcloud ks`), and Kubernetes CLI (`kubectl`).
2. [Create your Kubernetes cluster](/docs/containers?topic=containers-clusters).
3. If your network is protected by a company firewall, [allow access](/docs/containers?topic=containers-firewall) to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports. For private service endpoint-only clusters, you cannot test the connection to your cluster until you expose the private service endpoint of the master to the cluster by using a [private NLB](#access_private_se).
4. Check that your cluster is in a healthy state by running `ibmcloud ks cluster get -c <cluster_name_or_ID>`. If your cluster is not in a healthy state, review the [Debugging clusters](/docs/containers?topic=containers-cs_troubleshoot) guide for help. For example, if your cluster is provisioned in an account that is protected by a firewall gateway appliance, you must [configure your firewall settings to allow outgoing traffic to the appropriate ports and IP addresses](/docs/containers?topic=containers-firewall).
5.  In the output of the cluster details from the previous step, check the **Public** or **Private Service Endpoint** URL of the cluster.
    *  **Public Service Endpoint URL**: Continue with [Accessing Kubernetes clusters through the public service endpoint](#access_public_se).
    *  **Private Service Endpoint URL only**: If your cluster has only a private service endpoint enabled, continue with [Accessing clusters through the private service endpoint](#access_private_se). Note that this step requires a private network connection to your cluster.

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
    1.  Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
        ```
        ibmcloud ks cluster config -c <cluster_name_or_ID>
        ```
        {: pre}
    2.  Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
        ```
        kubectl config current-context
        ```
        {: pre}

        Example output:
        ```
        <cluster_name>/<cluster_ID>
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

The Kubernetes master is accessible through the private service endpoint if authorized cluster users are in your {{site.data.keyword.cloud_notm}} private network or are connected to the private network through a [VPC VPN connection](/docs/vpc?topic=vpc-vpn-onprem-example) for VPC infrastructure, or for classic infrastructure, a [VPN connection](/docs/iaas-vpn?topic=iaas-vpn-getting-started) or [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl). However, communication with the Kubernetes master over the private service endpoint must go through the <code>166.X.X.X</code> IP address range, which is not routable from a VPN connection or through {{site.data.keyword.dl_full_notm}}. You can expose the private service endpoint of the master for your cluster users by using a private network load balancer (NLB). The private NLB exposes the private service endpoint of the master as an internal <code>10.X.X.X</code> IP address range that users can access with the VPN or {{site.data.keyword.dl_full_notm}} connection. If you enable only the private service endpoint, you can use the Kubernetes dashboard or temporarily enable the public service endpoint to create the private NLB.
{: shortdesc}

### Accessing classic clusters through the private service endpoint
{: #classic_private_se}





1. If your network is protected by a company firewall, allow access to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports.
  1. [Allow access to the public endpoints for the `ibmcloud` API and the `ibmcloud ks` API in your firewall](/docs/containers?topic=containers-firewall#firewall_bx).
  2. [Allow your authorized cluster users to run `kubectl` commands](/docs/containers?topic=containers-firewall#firewall_kubectl). Note that you cannot test the connection to your cluster with `kubectl` commands until you complete all steps in this section.

2. Get the private service endpoint URL and port for your cluster.
  ```
  ibmcloud ks cluster get -c <cluster_name_or_ID>
  ```
  {: pre}

  In this example output, the **Private Service Endpoint URL** is `https://c1.private.us-east.containers.cloud.ibm.com:25073`.
  ```
  Name:                           setest
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

3. Create a YAML file that is named `kube-api-via-nlb.yaml`. This YAML creates a private `LoadBalancer` service and exposes the private service endpoint through that NLB. Replace `<private_service_endpoint_port>` with the port you found in the previous step.
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

4. To create the private NLB, you must be connected to the cluster master. Because you cannot yet connect through the private service endpoint from a VPN or {{site.data.keyword.dl_full_notm}}, you must connect to the cluster master and create the NLB by using the public service endpoint or Kubernetes dashboard.
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
    3. Verify that the `kube-api-via-nlb` NLB is created. In the output, note the `10.x.x.x` **EXTERNAL-IP** address. This IP address exposes the private service endpoint for the Kubernetes master on the port that you specified in your YAML file.
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

  Example text to add:
  ```
  10.186.92.42      c1.private.us-east.containers.cloud.ibm.com
  ```
  {: codeblock}

6. Verify that you are connected to the private network through a [VPN](/docs/iaas-vpn?topic=iaas-vpn-getting-started) or [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl) connection.

7. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
    ```
    ibmcloud ks cluster config -c <cluster_name_or_ID>
    ```
    {: pre}

8. Optional: If you have both the public and private service endpoints enabled, update your local Kubernetes configuration file to use the private service endpoint. By default, the public service endpoint is downloaded to the configuration file.
  1. Navigate to the `kubeconfig` directory and open the file.
    ```
    cd /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/<cluster_name> && nano touch kube-config-prod-dal10-mycluster.yml
    ```
    {: pre}
  2. Edit your Kubernetes configuration file to add the word `private` to the service endpoint URL. For example, in the Kubernetes configuration file `kube-config-prod-dal10-mycluster.yml`, the server field might look like `server: https://c1.us-east.containers.cloud.ibm.com:30426`. You can change this URL to the private service endpoint URL by changing the server field to `server: https://c1.private.us-east.containers.cloud.ibm.com:30426`.
  3. Repeat these steps each time that you run `ibmcloud ks cluster config`.

9. Verify that the `kubectl` commands run properly with your cluster through the private service endpoint by checking the Kubernetes CLI server version.
  ```
  kubectl version --short
  ```
  {: pre}

  Example output:
  ```
  Client Version: v1.18.9
  Server Version: v1.18.9
  ```
  {: screen}

### Accessing VPC clusters through the private service endpoint
{: #vpc_private_se}



1. If your network is protected by a company firewall, allow access to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports.
  1. [Allow access to the public endpoints for the `ibmcloud` API and the `ibmcloud ks` API in your firewall](/docs/containers?topic=containers-vpc-firewall#vpc-firewall_bx).
  2. [Allow your authorized cluster users to run `kubectl` commands](/docs/containers?topic=containers-vpc-firewall#vpc-firewall_kubectl). Note that you cannot test the connection to your cluster with `kubectl` commands until you complete all steps in this section.

2. Set up your {{site.data.keyword.vpc_short}} VPN.
  1. [Configure a VPN gateway on your local machine](/docs/vpc?topic=vpc-vpn-onprem-example#configuring-onprem-gateway). For example, you might choose to set up StrongSwan on your machine.
  2. [Create a VPN gateway in your VPC, and create the connection between the VPC VPN gateway and your local VPN gateway](/docs/vpc?topic=vpc-creating-a-vpc-using-the-ibm-cloud-console#vpn-ui). If you have a multizone cluster, you must create a VPC gateway on a subnet in each zone where you have worker nodes.

3. Get the private service endpoint URL and port for your cluster.
  ```
  ibmcloud ks cluster get -c <cluster_name_or_ID>
  ```
  {: pre}

  In this example output, the **Private Service Endpoint URL** is `https://c1.private.us-east.containers.cloud.ibm.com:25073`.
  ```
  ...
  Creator:                        -
  Public Service Endpoint URL:    -
  Private Service Endpoint URL:   https://c1.private.us-east.containers.cloud.ibm.com:25073
  Pull Secrets:                   enabled in the default namespace
  VPCs:                           aa11bb22-cc33-dd44-ee55-ff66gg77hh88
  ```
  {: screen}

4. Create a YAML file that is named `kube-api-via-nlb.yaml`. This YAML creates a private `LoadBalancer` service and exposes the private service endpoint through that NLB. Replace `<private_service_endpoint_port>` with the port you found in the previous step.
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

5. To create the private NLB, you must be connected to the cluster master. Because you cannot yet connect through the private service endpoint from a VPN or {{site.data.keyword.dl_full_notm}}, you must connect to the cluster master and create the NLB by using the public service endpoint or Kubernetes dashboard.
  * **If you enabled the private service endpoint only**, you can use the Kubernetes dashboard to create the NLB. The dashboard automatically routes all requests to the private service endpoint of the master.
    1.  Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/).
    2.  From the menu bar, select the account that you want to use.
    3.  From the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon"), click **Kubernetes**.
    4.  On the **Clusters** page, click the cluster that you want to access.
    5.  From the cluster detail page, click the **Kubernetes Dashboard**.
    6.  Click **+ Create**.
    7.  Select **Create from file**, upload the `kube-api-via-nlb.yaml` file, and click **Upload**.
    8.  In the **Overview** page, verify that the `kube-api-via-nlb` service is created. In the **External endpoints** column, the hostname exposes the private service endpoint for the Kubernetes master on the port that you specified in your YAML file.

  * **If you also enabled the public service endpoint**, you already have access to the master.
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
    3. Verify that the `kube-api-via-nlb` NLB is created. In the output, the hostname in the **EXTERNAL-IP** address field exposes the private service endpoint for the Kubernetes master on the port that you specified in your YAML file.
      ```
      kubectl get svc -o wide
      ```
      {: pre}

6. Verify that you are connected to the private network through your {{site.data.keyword.vpc_short}} VPN connection.

7. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
    ```
    ibmcloud ks cluster config -c <cluster_name_or_ID>
    ```
    {: pre}

8. Optional: If you have both the public and private service endpoints enabled, update your local Kubernetes configuration file to use the private service endpoint. By default, the public service endpoint is downloaded to the configuration file.
  1. Navigate to the `kubeconfig` directory and open the file.
    ```
    cd /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/<cluster_name> && nano touch kube-config-prod-dal10-mycluster.yml
    ```
    {: pre}
  2. Edit your Kubernetes configuration file to add the word `private` to the service endpoint URL. For example, in the Kubernetes configuration file `kube-config-prod-dal10-mycluster.yml`, the server field might look like `server: https://c1.us-east.containers.cloud.ibm.com:30426`. You can change this URL to the private service endpoint URL by changing the server field to `server: https://c1.private.us-east.containers.cloud.ibm.com:30426`.
  3. Repeat these steps each time that you run `ibmcloud ks cluster config`.

9. Verify that the `kubectl` commands run properly with your cluster through the private service endpoint by checking the Kubernetes CLI server version.
  ```
  kubectl version --short
  ```
  {: pre}

  Example output:
  ```
  Client Version: v1.18.9
  Server Version: v1.18.9
  ```
  {: screen}


<br />



<br />


## Accessing the cluster master via admission controllers and webhooks
{: #access_webhooks}

Admission controllers intercept authorized API requests from various Kubernetes resources before the requests reach the API server that runs in your {{site.data.keyword.containerlong_notm}} cluster master. Mutating admission webhooks might modify the request, and validating admission webhooks check the request. If either webhook rejects a request, the entire request fails. Advanced features, whether built-in or added on, often require admission controllers as a security precaution and to control what requests are sent to the API server. For more information, see [Using Admission Controllers](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/){: external} and [Dynamic Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} in the Kubernetes documentation.

**What are the default admission controllers in my cluster?**<br>
Review the order of default admission controllers by cluster version in the [`kube-apiserver` component reference information](/docs/containers?topic=containers-service-settings#kube-apiserver).

<br>

**Can I create my own admission controllers?**<br>
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

<br>

**What other types of apps use admission controllers?**<br>
Many cluster add-ons, plug-ins, and other third-party extensions create custom admission controllers. Some common ones include:
*   [Container image security enforcement](/docs/Registry?topic=Registry-security_enforce).
*   [Istio](/docs/containers?topic=containers-istio-about).
*   [Knative](/docs/containers?topic=containers-serverless-apps-knative).

<br>

**I need help with a broken webhook. What can I do?**<br>
See [Cluster cannot update because of broken webhook](/docs/containers?topic=containers-cs_troubleshoot#webhooks_update).



