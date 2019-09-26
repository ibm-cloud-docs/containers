---

copyright:
  years: 2014, 2019
lastupdated: "2019-09-26"

keywords: kubernetes, iks, vpc lbaas,

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
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:preview: .preview}


# VPC: Exposing apps with VPC load balancers
{: #vpc-lbaas}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC load balancers can be created for VPC on Classic clusters only, and cannot be created for classic clusters. To load balance in classic clusters, see [About NLBs](https://cloud.ibm.com/docs/containers?topic=containers-loadbalancer-about).

Set up a Load Balancer for VPC to expose your app on the public or private network.
{: shortdesc}

## About VPC load balancing in {{site.data.keyword.containerlong_notm}}
{: #lbaas_about}

When you create a Kubernetes `LoadBalancer` service for an app in your cluster, a layer 7 [Load Balancer for VPC](/docs/vpc-on-classic-network?topic=vpc-on-classic-network---using-load-balancers-in-ibm-cloud-vpc) is automatically created in your VPC outside of your cluster. The load balancer is multizonal and routes requests for your app through the private NodePorts that are automatically opened on your worker nodes.
{: shortdesc}

The VPC load balancer serves as the external entry point for incoming requests for the app.
* If you create a public Kubernetes `LoadBalancer` service, you can access your app from the internet through the hostname that is assigned by the VPC load balancer to the Kubernetes `LoadBalancer` service in the format `1234abcd-<region>.lb.appdomain.cloud`. Even though your worker nodes are connected to only a private VPC subnet, the VPC load balancer can receive and route public requests to the service that exposes your app. Note that no public gateway is required on your VPC subnet to allow public requests to your VPC load balancer. However, if you app must access a public URL, you must attach public gateways to the VPC subnets that your worker nodes are connected to.
* If you create a private Kubernetes `LoadBalancer` service, your app is accessible only to systems that are connected to your private subnets within the same region and VPC. If you are connected to your private VPC network, you can access your app through the hostname that is assigned by the VPC load balancer to the Kubernetes `LoadBalancer` service in the format `1234abcd-<region>.lb.appdomain.cloud`.

The following diagram illustrates how a user accesses an app from the internet through the VPC load balancer.

<img src="images/vpc_tutorial_lesson4_lb.png" width="800" alt="VPC load balancing for a cluster" style="width:600px; border-style: none"/>

A request to your app uses the hostname that is assigned to the Kubernetes `LoadBalancer` service by the VPC load balancer. The request is automatically forwarded by the VPC load balancer to one of the node ports on the worker, and further to the private IP address of the app pod. If app instances are deployed to multiple worker nodes in the cluster, the load balancer routes the requests between the app pods on various worker nodes. Additionally, if you have a multizone cluster, the VPC load balancer routes requests to worker nodes across all subnets and zones in your cluster.

<br />


## Setting up a Load Balancer for VPC
{: #setup_vpc_ks_vpc_lb}

Expose your app to the public or to the private network by setting up a Kubernetes `LoadBalancer` service in your cluster. When you expose your app, a Load Balancer for VPC that routes requests to your app is automatically created for you in your VPC outside of your cluster.
{: shortdesc}

**Before you begin**:
* Ensure that you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for the `default` namespace.
* If you use [VPC security groups](/docs/infrastructure/security-groups?topic=security-groups-about-ibm-security-groups#about-ibm-security-groups), allow traffic requests that are routed by the VPC load balancer to node ports on your worker nodes.
  1. List the worker nodes in your VPC cluster, and note the private IP addresses.
    ```
    kubectl get nodes
    ```
    {: pre}
  2. List your security groups. If your VPC has only the default security group with a randomly generated name, inbound traffic to the node ports on the worker is already allowed. If you have another security group, note its ID.
    ```
    ibmcloud is security-groups
    ```
    {: pre}
    Example output with only the default security group of a randomly generated name, `preppy-swimmer-island-green-refreshment`:
    ```
    ID                                     Name                                       Rules   Network interfaces         Created                     VPC                      Resource group   
    1a111a1a-a111-11a1-a111-111111111111   preppy-swimmer-island-green-refreshment   4       -                           2019-08-12T13:24:45-04:00   <vpc_name>(bbbb222b-.)   c3c33cccc33c333ccc3c33cc3c333cc3  
    ```
    {: screen}
  3. For any other security groups for your VPC, add a rule to allow inbound TCP traffic on ports 30000-32767 to the private IP addresses of your worker nodes. For more information about the command options, see the [`security-group-rule-add` CLI reference docs](/docs/vpc-on-classic?topic=vpc-infrastructure-cli-plugin-vpc-reference#security-group-rule-add).
    ```
    ibmcloud is security-group-rule-add <security_group_ID> inbound tcp --remote <worker_node_private_IP> --port-min 30000 --port-max 32767
    ```
    {: pre}

</br>**To enable your app to receive public or private requests:**
1.  [Deploy your app to the cluster](/docs/containers?topic=containers-app#app_cli). Ensure that you add a label in the metadata section of your deployment configuration file. This custom label identifies all pods where your app runs to include them in the load balancing.

2. Create a configuration YAML file for your Kubernetes `LoadBalancer` service and name the file `myloadbalancer.yaml`.
  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: myloadbalancer
    annotations:
      service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
  spec:
    type: LoadBalancer
    selector:
      <selector_key>: <selector_value>
    ports:
     - protocol: TCP
       port: 8080
  ```
  {: codeblock}

  <table>
  <caption>Understanding the YAML file components</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
  </thead>
  <tbody>
  <tr>
  <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type`</td>
  <td>Annotation to specify a service that accepts public or private requests.  If you do not include this annotation, a public `LoadBalancer` is created.</td>
  </tr>
  <tr>
  <td>`selector`</td>
  <td>The label key (&lt;selector_key&gt;) and value (&lt;selector_value&gt;) that you used in the `spec.template.metadata.labels` section of your app deployment YAML. This custom label identifies all pods where your app runs to include them in the load balancing.</td>
  </tr>
  <tr>
  <td>`port`</td>
  <td>The port that the service listens on.</td>
  </tr>
  </tbody></table>

3. Create the Kubernetes `LoadBalancer` service in your cluster.
  ```
  kubectl apply -f myloadbalancer.yaml
  ```
  {: pre}

4. Verify that the Kubernetes `LoadBalancer` service is created successfully in your cluster. When the service is created, the **LoadBalancer Ingress** field is populated with a hostname that is assigned by the VPC load balancer.

  **The VPC load balancer takes a few minutes to provision in your VPC.** You cannot access your app by using the hostname of your Kubernetes `LoadBalancer` service until the VPC load balancer is fully provisioned.
  {: note}
  ```
  kubectl describe svc myloadbalancer
  ```
  {: pre}

  Example CLI output for a public `LoadBalancer` service:
  ```
  Name:                     myloadbalancer
  Namespace:                default
  Labels:                   <none>
  Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                              {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{"service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type":"public"},...
                            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: public
  Selector:                 run=webserver
  Type:                     LoadBalancer
  IP:                       172.21.106.166
  LoadBalancer Ingress:     1234abcd-us-south.lb.appdomain.cloud
  Port:                     <unset>  8080/TCP
  TargetPort:               8080/TCP
  NodePort:                 <unset>  30532/TCP
  Endpoints:
  Session Affinity:         None
  External Traffic Policy:  Cluster
  Events:
    Type    Reason                Age   From                Message
    ----    ------                ----  ----                -------
    Normal  EnsuringLoadBalancer  52s   service-controller  Ensuring load balancer
    Normal  EnsuredLoadBalancer   35s   service-controller  Ensured load balancer
  ```
  {: screen}

4. Verify that the VPC load balancer is created successfully in your VPC. In the output, verify that the VPC load balancer has an **Operating Status** of `online` and a **Provision Status** of `active`.

  The VPC load balancer name has a format `kube-<cluster_ID>-<kubernetes_lb_service_UID>`. To see your cluster ID, run `ibmcloud ks cluster get --cluster <cluster_name>`. To see the Kubernetes `LoadBalancer` service UID, run `kubectl get svc myloadbalancer -o yaml` and look for the **metadata.uid** field in the output. The dashes (-) are removed from the Kubernetes `LoadBalancer` service UID in the VPC load balancer name.
  {: tip}
  ```
  ibmcloud is load-balancers
  ```
  {: pre}

  In the following example CLI output, the VPC load balancer that is named `kube-bh077ne10vqpekt0domg-046e0f754d624dca8b287a033d55f96e` is created for the Kubernetes `LoadBalancer` service:
  ```
  ID                                     Name                                                         Created          Host Name                                  Is Public   Listeners                               Operating Status   Pools                                   Private IPs              Provision Status   Public IPs                    Subnets                                Resource Group   
  06496f64-a689-4693-ba23-320959b7b677   kube-bh077ne10vqpekt0domg-046e0f754d624dca8b287a033d55f96e   8 minutes ago    1234abcd-us-south.lb.appdomain.cloud       yes         95482dcf-6b9b-4c6a-be54-04d3c46cf017    online             717f2122-5431-403c-b21d-630a12fc3a5a    10.241.0.7,10.241.0.13   active             169.63.99.184,169.63.99.124   c6540331-1c1c-40f4-9c35-aa42a98fe0d9   00809211b934565df546a95f86160f62
  ```
  {: screen}

5. If you created a public `LoadBalancer` service, curl the hostname of the Kubernetes `LoadBalancer` service that is assigned by the VPC load balancer.
  Example:
  ```
  curl 06496f64-us-south.lb.appdomain.cloud:8080
  ```
  {: pre}

  Example output:
  ```
  Hello world from hello-world-deployment-5fd7787c79-sl9hn! Your app is up and running in a cluster!
  ```
  {: screen}

  If you created a private `LoadBalancer` service, you must be [connected to your private VPC network](/docs/vpc-on-classic-network?topic=vpc-on-classic-network---using-vpn-with-your-vpc) to curl the hostname.
  {: tip}

<br />


## Limitations
{: #lbaas_limitations}

* VPC load balancers do not currently support UDP.
* One VPC load balancer is created for each Kubernetes `LoadBalancer` service that you create, and it routes requests to that Kubernetes `LoadBalancer` service only. Across all of your VPC clusters in your VPC, a maximum of 20 VPC load balancers can be created.
* The VPC load balancer can route requests to pods that are deployed on a maximum of 50 worker nodes in a cluster.
* When you define the configuration YAML file for a Kubernetes `LoadBalancer` service, the following annotations and settings are not supported:
    * `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"`
    * `service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"`
    * `service.kubernetes.io/ibm-load-balancer-cloud-provider-ipvs-scheduler: "<algorithm>"`
    * `spec.loadBalancerIP`
    * `spec.loadBalancerSourceRanges`
    * The `externalTrafficPolicy: Local` setting is supported, but the setting does not preserve the source IP of the request.
* Source IP preservation for requests is not supported in VPC.
* When you delete a VPC cluster, any VPC load balancers that were automatically created by {{site.data.keyword.containerlong_notm}} for the Kubernetes `LoadBalancer` services in that cluster are also automatically deleted. However, any VPC load balancers that you manually created in your VPC are not deleted.


