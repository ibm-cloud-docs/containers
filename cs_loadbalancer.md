---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-26"

keywords: kubernetes, iks, lb2.0, nlb, health check

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



# Basic and DSR load balancing with network load balancers (NLB)
{: #loadbalancer}

Expose a port and use a portable IP address for a Layer 4 network load balancer (NLB) to access a containerized app.
{:shortdesc}

Choose one of the following options to get started:

<img src="images/cs_loadbalancer_imagemap.png" usemap="#image-map" alt="This imagemap provides quick links to configuration topics on this page.">
<map name="image-map">
    <area target="" alt="Overview" title="Overview" href="#lb_overview" coords="35,44,175,72" shape="rect">
    <area target="" alt="Comparison of version 1.0 and 2.0 load balancers" title="Comparison of version 1.0 and 2.0 load balancers" href="#comparison" coords="34,83,173,108" shape="rect">
    <area target="" alt="Registering a load balancer host name" title="Registering a load balancer host name" href="#loadbalancer_hostname" coords="33,119,174,146" shape="rect">
    <area target="" alt="v2.0: Components and architecture (Beta)" title="v2.0: Components and architecture (Beta)" href="#planning_ipvs" coords="273,45,420,72" shape="rect">
    <area target="" alt="v2.0: Prerequisites" title="v2.0: Prerequisites" href="#ipvs_provision" coords="277,85,417,108" shape="rect">
    <area target="" alt="v2.0: Setting up a load balancer 2.0 in a multizone cluster" title="v2.0: Setting up a load balancer 2.0 in a multizone cluster" href="#ipvs_multi_zone_config" coords="276,122,417,147" shape="rect">
    <area target="" alt="v2.0: Setting up a load balancer 2.0 in a single-zone cluster" title="v2.0: Setting up a load balancer 2.0 in a single-zone cluster" href="#ipvs_single_zone_config" coords="277,156,419,184" shape="rect">
    <area target="" alt="v2.0: Scheduling algorithms" title="v2.0: Scheduling algorithms" href="#scheduling" coords="276,196,419,220" shape="rect">
    <area target="" alt="v1.0: Components and architecture" title="v1.0: Components and architecture" href="#v1_planning" coords="519,47,668,74" shape="rect">
    <area target="" alt="v1.0: Setting up a load balancer 1.0 in a multizone cluster" title="v1.0: Setting up a load balancer 1.0 in a multizone cluster" href="#multi_zone_config" coords="520,85,667,110" shape="rect">
    <area target="" alt="v1.0: Setting up a load balancer 1.0 in a single-zone cluster" title="v1.0: Setting up a load balancer 1.0 in a single-zone cluster" href="#lb_config" coords="520,122,667,146" shape="rect">
    <area target="" alt="v1.0: Enabling source IP preservation" title="v1.0: Enabling source IP preservation" href="#node_affinity_tolerations" coords="519,157,667,194" shape="rect">
</map>
</br>

To quickly get started, you can run the following command to create a load balancer 1.0:
```
kubectl expose deploy my-app --port=80 --target-port=8080 --type=LoadBalancer --name my-lb-svc
```
{: pre}

## Overview
{: #lb_overview}

When you create a standard cluster, {{site.data.keyword.containerlong}} automatically provisions a portable public subnet and a portable private subnet.
{: shortdesc}

* The portable public subnet provides 5 usable IP addresses. 1 portable public IP address is used by the default [public Ingress ALB](/docs/containers?topic=containers-ingress). The remaining 4 portable public IP addresses can be used to expose single apps to the internet by creating public network load balancer services, or NLBs.
* The portable private subnet provides 5 usable IP addresses. 1 portable private IP address is used by the default [private Ingress ALB](/docs/containers?topic=containers-ingress#private_ingress). The remaining 4 portable private IP addresses can be used to expose single apps to a private network by creating private load balancer services, or NLBs.

Portable public and private IP addresses are static floating IPs and do not change when a worker node is removed. If the worker node that the NLB IP address is on is removed, a Keepalived daemon that constantly monitors the IP automatically moves the IP to another worker node. You can assign any port to your NLB. The NLB serves as the external entry point for incoming requests for the app. To access the NLB from the internet, you can use the public IP address of your NLB and the assigned port in the format `<IP_address>:<port>`. You can also create DNS entries for NLBs by registering the NLB IP addresses with host names.

When you expose an app with an NLB service, your app is automatically made available over the service's NodePorts too. [NodePorts](/docs/containers?topic=containers-nodeport) are accessible on every public and private IP address of every worker node within the cluster. To block traffic to NodePorts while you are using an NLB, see [Controlling inbound traffic to network load balancer (NLB) or NodePort services](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Comparison of basic and DSR load balancing in version 1.0 and 2.0 NLBs
{: #comparison}

When you create an NLB, you can choose a version 1.0 NLB, which performs basic oad balancing, or version 2.0 NLB, which performs direct server return (DSR) load balancing. Note that version 2.0 NLBs are in beta.
{: shortdesc}

**How are version 1.0 and 2.0 NLBs similar?**

Version 1.0 and 2.0 NLBs are both Layer 4 load balancers that live only in the Linux kernel space. Both versions run inside the cluster, and use worker node resources. Therefore, the available capacity of the NLBs is always dedicated to your own cluster. Additionally, both version of NLBs do not terminate the connection. Instead, they forward connections to an app pod.

**How are version 1.0 and 2.0 NLBs different?**

When a client sends a request to your app, the NLB routes request packets to the worker node IP address where an app pod exists. Version 1.0 NLBs use network address translation (NAT) to rewrite the request packet's source IP address to the IP of worker node where a load balancer pod exists. When the worker node returns the app response packet, it uses that worker node IP where the NLB exists. The NLB must then send the response packet to the client. To prevent the IP address from being rewritten, you can [enable source IP preservation](#node_affinity_tolerations). However, source IP preservation requires load balancer pods and app pods to run on the same worker so that the request doesn't have to be forwarded to another worker. You must add node affinity and tolerations to app pods. For more information about basic load balancing with version 1.0 NLBs, see [v1.0: Components and architecture of basic load balancing](#v1_planning).

As opposed to version 1.0 NLBs, version 2.0 NLBs don't use NAT when forwarding requests to app pods on other workers. When an NLB 2.0 routes a client request, it uses IP over IP (IPIP) to encapsulate the original request packet into another, new packet. This encapsulating IPIP packet has a source IP of the worker node where the load balancer pod is, which allows the original request packet to preserve the client IP as its source IP address. The worker node then uses direct server return (DSR) to send the app response packet to the client IP. The response packet skips the NLB and is sent directly to the client, decreasing the amount of traffic that the NLB must handle. For more information about DSR load balancing with version 2.0 NLBs, see [v2.0: Components and architecture of DSR load balancing](#planning_ipvs).

<br />


## v1.0: Components and architecture of basic load balancing
{: #v1_planning}

The TCP/UDP network load balancer (NLB) 1.0 uses Iptables, a Linux kernel feature, to load balance requests across an app's pods.
{: shortdesc}

### Traffic flow in a single-zone cluster
{: #v1_single}

The following diagram shows how an NLB 1.0 directs communication from the internet to an app in a single-zone cluster.
{: shortdesc}

<img src="images/cs_loadbalancer_planning.png" width="410" alt="Expose an app in {{site.data.keyword.containerlong_notm}} by using an NLB 1.0" style="width:410px; border-style: none"/>

1. A request to your app uses the public IP address of your NLB and the assigned port on the worker node.

2. The request is automatically forwarded to the NLB service's internal cluster IP address and port. The internal cluster IP address is accessible inside the cluster only.

3. `kube-proxy` routes the request to the NLB service for the app.

4. The request is forwarded to the private IP address of the app pod. The source IP address of the request package is changed to the public IP address of the worker node where the app pod is running. If multiple app instances are deployed in the cluster, the NLB routes the requests between the app pods.

### Traffic flow in a multizone cluster
{: #v1_multi}

The following diagram shows how a network load balancer (NLB) 1.0 directs communication from the internet to an app in a multizone cluster.
{: shortdesc}

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Use an NLB 1.0 to load balance apps in multizone clusters" style="width:500px; border-style: none"/>

By default, each NLB 1.0 is set up in one zone only. To achieve high availability, you must deploy an NLB 1.0 in every zone where you have app instances. Requests are handled by the NLBs in various zones in a round-robin cycle. Additionally, each NLB routes requests to the app instances in its own zone and to app instances in other zones.

<br />


## v1.0: Setting up an NLB 1.0 in a multizone cluster
{: #multi_zone_config}

**Before you begin**:
* To create public network load balancers (NLBs) in multiple zones, at least one public VLAN must have portable subnets available in each zone. To create private NLBs in multiple zones, at least one private VLAN must have portable subnets available in each zone. You can add subnets by following the steps in [Configuring subnets for clusters](/docs/containers?topic=containers-subnets).
* If you restrict network traffic to edge worker nodes, ensure that at least 2 [edge worker nodes](/docs/containers?topic=containers-edge#edge) are enabled in each zone so that NLBs deploy uniformly.
* Enable [VLAN spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) for your IBM Cloud infrastructure (SoftLayer) account so your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-users#infra_access), or you can request the account owner to enable it. To check if VLAN spanning is already enabled, use the `ibmcloud ks vlan-spanning-get --region <region>` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get).
* Ensure you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for the `default` namespace.


To set up an NLB 1.0 service in a multizone cluster:
1.  [Deploy your app to the cluster](/docs/containers?topic=containers-app#app_cli). Ensure that you add a label to your deployment in the metadata section of your configuration file. This label is needed to identify all of the pods where your app is running so that they can be included in the load balancing.

2.  Create a load balancer service for the app that you want to expose to the public internet or a private network.
  1. Create a service configuration file that is named, for example, `myloadbalancer.yaml`.
  2. Define a load balancer service for the app that you want to expose. You can specify a zone, a VLAN, and an IP address.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
      ```
      {: codeblock}

      <table>
      <caption>Understanding the YAML file components</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>Annotation to specify a <code>private</code> or <code>public</code> load balancer.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Annotation to specify the zone that the load balancer service deploys to. To see zones, run <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Annotation to specify a VLAN that the load balancer service deploys to. To see VLANs, run <code>ibmcloud ks vlans --zone <zone></code>.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>The label key (<em>&lt;selector_key&gt;</em>) and value (<em>&lt;selector_value&gt;</em>) that you used in the <code>spec.template.metadata.labels</code> section of your app deployment YAML.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>The port that the service listens on.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Optional: To create a private load balancer or to use a specific portable IP address for a public load balancer, specify the IP address that you want to use. The IP address must be on the VLAN and zone that you specify in the annotations. If you do not specify an IP address:<ul><li>If your cluster is on a public VLAN, a portable public IP address is used. Most clusters are on a public VLAN.</li><li>If your cluster is on a private VLAN only, a portable private IP address is used.</li></ul></td>
      </tr>
      </tbody></table>

      Example configuration file to create a private NLB 1.0 service that uses a specified IP address on private VLAN `2234945` in `dal12`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. Optional: Make your NLB service available to only a limited range of IP addresses by specifying the IPs in the `spec.loadBalancerSourceRanges` field. `loadBalancerSourceRanges` is implemented by `kube-proxy` in your cluster via Iptables rules on worker nodes. For more information, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Create the service in your cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verify that the NLB service was created successfully. It might take a few minutes for the service to be created and for the app to be available.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Example CLI output:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    The **LoadBalancer Ingress** IP address is the portable IP address that was assigned to your NLB service.

4.  If you created a public NLB, access your app from the internet.
    1.  Open your preferred web browser.
    2.  Enter the portable public IP address of the NLB and port.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}    

5. Repeat the steps 2 - 4 to add a version 1.0 NLB in each zone.    

6. If you choose to [enable source IP preservation for an NLB 1.0](#node_affinity_tolerations), ensure that app pods are scheduled onto the edge worker nodes by [adding edge node affinity to app pods](#lb_edge_nodes). App pods must be scheduled onto edge nodes to receive incoming requests.

7. Optional: A load balancer service also makes your app available over the service's NodePorts. [NodePorts](/docs/containers?topic=containers-nodeport) are accessible on every public and private IP address for every node within the cluster. To block traffic to NodePorts while you are using an NLB service, see [Controlling inbound traffic to network load balancer (NLB) or NodePort services](/docs/containers?topic=containers-network_policies#block_ingress).

Next, you can [register an NLB host name](#loadbalancer_hostname).

<br />


## v1.0: Setting up an NLB 1.0 in a single-zone cluster
{: #lb_config}

**Before you begin**:
* You must have an available portable public or private IP address to assign to the network load balancer (NLB) service. For more information, see [Configuring subnets for clusters](/docs/containers?topic=containers-subnets).
* Ensure you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for the `default` namespace.

To create an NLB 1.0 service in a single-zone cluster:

1.  [Deploy your app to the cluster](/docs/containers?topic=containers-app#app_cli). Ensure that you add a label to your deployment in the metadata section of your configuration file. This label is needed to identify all pods where your app is running so that they can be included in the load balancing.
2.  Create a load balancer service for the app that you want to expose to the public internet or a private network.
    1.  Create a service configuration file that is named, for example, `myloadbalancer.yaml`.

    2.  Define a load balancer service for the app that you want to expose.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>Understanding the YAML file components</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotation to specify a <code>private</code> or <code>public</code> load balancer.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Annotation to specify a VLAN that the load balancer service deploys to. To see VLANs, run <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>The label key (<em>&lt;selector_key&gt;</em>) and value (<em>&lt;selector_value&gt;</em>) that you used in the <code>spec.template.metadata.labels</code> section of your app deployment YAML.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>The port that the service listens on.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Optional: To create a private load balancer or to use a specific portable IP address for a public load balancer, specify the IP address that you want to use. The IP address must be on the VLAN that you specify in the annotations. If you do not specify an IP address:<ul><li>If your cluster is on a public VLAN, a portable public IP address is used. Most clusters are on a public VLAN.</li><li>If your cluster is on a private VLAN only, a portable private IP address is used.</li></ul></td>
        </tr>
        </tbody></table>

        Example configuration file to create a private NLB 1.0 service that uses a specified IP address on private VLAN `2234945`:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3. Optional: Make your NLB service available to only a limited range of IP addresses by specifying the IPs in the `spec.loadBalancerSourceRanges` field. `loadBalancerSourceRanges` is implemented by `kube-proxy` in your cluster via Iptables rules on worker nodes. For more information, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Create the service in your cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Verify that the NLB service was created successfully. It might take a few minutes for the service to be created and for the app to be available.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Example CLI output:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    The **LoadBalancer Ingress** IP address is the portable IP address that was assigned to your NLB service.

4.  If you created a public NLB, access your app from the internet.
    1.  Open your preferred web browser.
    2.  Enter the portable public IP address of the NLB and port.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. If you choose to [enable source IP preservation for an NLB 1.0](#node_affinity_tolerations), ensure that app pods are scheduled onto the edge worker nodes by [adding edge node affinity to app pods](#lb_edge_nodes). App pods must be scheduled onto edge nodes to receive incoming requests.

6. Optional: A load balancer service also makes your app available over the service's NodePorts. [NodePorts](/docs/containers?topic=containers-nodeport) are accessible on every public and private IP address for every node within the cluster. To block traffic to NodePorts while you are using an NLB service, see [Controlling inbound traffic to network load balancer (NLB) or NodePort services](/docs/containers?topic=containers-network_policies#block_ingress).

Next, you can [register an NLB host name](#loadbalancer_hostname).

<br />


## v1.0: Enabling source IP preservation
{: #node_affinity_tolerations}

This feature is for version 1.0 network load balancers (NLBs) only. The source IP address of client requests is preserved by default in version 2.0 NLBs.
{: note}

When a client request to your app is sent to your cluster, a load balancer service pod receives the request. If no app pod exists on the same worker node as the load balancer service pod, the NLB forwards the request to an app pod on a different worker node. The source IP address of the package is changed to the public IP address of the worker node where the load balancer service pod is running.
{: shortdesc}

To preserve the original source IP address of the client request, you can [enable source IP ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for load balancer services. The TCP connection continues all the way to the app pods so that the app can see the actual source IP address of the initiator. Preserving the client’s IP is useful, for example, when app servers have to apply security and access-control policies.

After you enable the source IP, load balancer service pods must forward requests to app pods that are deployed to the same worker node only. Typically, load balancer service pods are also deployed to the worker nodes that the app pods are deployed to. However, some situations exist where the load balancer pods and app pods might not be scheduled onto the same worker node:

* You have edge nodes that are tainted so that only load balancer service pods can deploy to them. App pods are not permitted to deploy to those nodes.
* Your cluster is connected to multiple public or private VLANs, and your app pods might deploy to worker nodes that are connected only to one VLAN. Load balancer service pods might not deploy to those worker nodes because the NLB IP address is connected to a different VLAN than the worker nodes.

To force your app to deploy to specific worker nodes where load balancer service pods can also deploy to, you must add affinity rules and tolerations to your app deployment.

### Adding edge node affinity rules and tolerations
{: #lb_edge_nodes}

When you [label worker nodes as edge nodes](/docs/containers?topic=containers-edge#edge_nodes) and also [taint the edge nodes](/docs/containers?topic=containers-edge#edge_workloads), load balancer service pods deploy only to those edge nodes, and app pods cannot deploy to edge nodes. When source IP is enabled for the NLB service, the load balancer pods on the edge nodes cannot forward incoming requests to your app pods on other worker nodes.
{:shortdesc}

To force your app pods to deploy to edge nodes, add an edge node [affinity rule ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) and [toleration ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) to the app deployment.

Example deployment YAML file with edge node affinity and edge node toleration:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  selector:
    matchLabels:
      <label_name>: <label_value>
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

Both the **affinity** and **tolerations** sections have `dedicated` as the `key` and `edge` as the `value`.

### Adding affinity rules for multiple public or private VLANs
{: #edge_nodes_multiple_vlans}

When your cluster is connected to multiple public or private VLANs, your app pods might deploy to worker nodes that are connected only to one VLAN. If the NLB IP address is connected to a different VLAN than these worker nodes, load balancer service pods won't deploy to those worker nodes.
{:shortdesc}

When source IP is enabled, schedule app pods on worker nodes that are the same VLAN as the NLB's IP address by adding an affinity rule to the app deployment.

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. Get the IP address of the NLB service. Look for the IP address in the **LoadBalancer Ingress** field.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Retrieve the VLAN ID that your NLB service is connected to.

    1. List portable public VLANs for your cluster.
        ```
        ibmcloud ks cluster-get --cluster <cluster_name_or_ID> --showResources
        ```
        {: pre}

        Example output:
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. In the output under **Subnet VLANs**, look for the subnet CIDR that matches the NLB IP address that you retrieved earlier and note the VLAN ID.

        For example, if the NLB service IP address is `169.36.5.xxx`, the matching subnet in the example output of the previous step is `169.36.5.xxx/29`. The VLAN ID that the subnet is connected to is `2234945`.

3. [Add an affinity rule ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) to the app deployment for the VLAN ID that you noted in the previous step.

    For example, if you have multiple VLANs but want your app pods to deploy to worker nodes on the `2234945` public VLAN only:

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      selector:
        matchLabels:
          <label_name>: <label_value>
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    In the example YAML, the **affinity** section has `publicVLAN` as the `key` and `"2234945"` as the `value`.

4. Apply the updated deployment configuration file.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. Verify that the app pods deployed to worker nodes connected to the designated VLAN.

    1. List the pods in your cluster. Replace `<selector>` with the label that you used for the app.
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        Example output:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. In the output, identify a pod for your app. Note the **NODE** ID of the worker node that the pod is on.

        In the example output of the previous step, the app pod `cf-py-d7b7d94db-vp8pq` is on worker node `10.176.48.78`.

    3. List the details for the worker node.

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        Example output:

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. In the **Labels** section of the output, verify that the public or private VLAN is the VLAN that you designated in previous steps.

<br />


## v2.0: Components and architecture (beta)
{: #planning_ipvs}

Network load balancer (NLB) 2.0 capabilities are in beta. To use an NLB 2.0, you must [update your cluster's master and worker nodes](/docs/containers?topic=containers-update) to Kubernetes version 1.12 or later.
{: note}

The NLB 2.0 is a Layer 4 load balancer that uses the Linux kernel's IP Virtual Server (IPVS). The NLB 2.0 supports TCP and UDP, runs in front of multiple worker nodes, and uses IP over IP (IPIP) tunneling to distribute traffic that arrives to a single NLB IP address across those worker nodes.

Want more details about the load balancing deployment patterns that are available in {{site.data.keyword.containerlong_notm}}? Check out this [blog post ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/).
{: tip}

### Traffic flow in a single-zone cluster
{: #ipvs_single}

The following diagram shows how an NLB 2.0 directs communication from the internet to an app in a single zone cluster.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_planning.png" width="600" alt="Expose an app in {{site.data.keyword.containerlong_notm}} by using a version 2.0 NLB" style="width:600px; border-style: none"/>

1. A client request to your app uses the public IP address of your NLB and the assigned port on the worker node. In this example, the NLB has a virtual IP address of 169.61.23.130, which is currently on worker 10.73.14.25.

2. The NLB encapsulates the client request packet (labeled as "CR" in the image) inside an IPIP packet (labeled as "IPIP"). The client request packet retains the client IP as its source IP address. The IPIP encapsulating packet uses the worker 10.73.14.25 IP as its source IP address.

3. The NLB routes the IPIP packet to a worker that an app pod is on, 10.73.14.26. If multiple app instances are deployed in the cluster, the NLB routes the requests between the workers where app pods are deployed.

4. Worker 10.73.14.26 unpacks the IPIP encapsulating packet, and then unpacks the client request packet. The client request packet is forwarded to the app pod on that worker node.

5. Worker 10.73.14.26 then uses the source IP address from the original request packet, the client IP, to return the app pod's response packet directly to the client.

### Traffic flow in a multizone cluster
{: #ipvs_multi}

The traffic flow through a multizone cluster follows the same path as [traffic through a single zone cluster](#ipvs_single). In a multizone cluster, the NLB routes requests to the app instances in its own zone and to app instances in other zones. The following diagram shows how version 2.0 NLBs in each zone direct traffic from the internet to an app in a multizone cluster.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="Expose an app in {{site.data.keyword.containerlong_notm}} by using an NLB 2.0" style="width:500px; border-style: none"/>

By default, each version 2.0 NLB is set up in one zone only. You can achieve higher availability by deploying a version 2.0 NLB in every zone where you have app instances.

<br />


## v2.0: Prerequisites
{: #ipvs_provision}

You cannot update an existing version 1.0 NLB to 2.0. You must create a new NLB 2.0. Note that you can run version 1.0 and 2.0 NLBs simultaneously in a cluster.
{: shortdesc}

Before you create an NLB 2.0, you must complete the following prerequisite steps.

1. [Update your cluster's master and worker nodes](/docs/containers?topic=containers-update) to Kubernetes version 1.12 or later.

2. To allow your NLB 2.0 to forward requests to app pods in multiple zones, open a support case to request capacity aggregation for your VLANs. This configuration setting does not cause any network disruptions or outages.
    1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/).
    2. From the menu bar, click **Support**, click the **Manage cases** tab, and click **Create new case**.
    3. In the case fields, enter the following:
       * For type of support, select **Technical**.
       * For category, select **VLAN Spanning**.
       * For subject, enter **Public VLAN Network Question.**
    4. Add the following information to the description: "Please set up the network to allow capacity aggregation on the public VLANs associated with my account. The reference ticket for this request is: https://control.softlayer.com/support/tickets/63859145". Note that if you want to allow capacity aggregation on specific VLANs, such as the public VLANs for one cluster only, you can specify those VLAN IDs in the description.
    5. Click **Submit**.

3. Enable a [Virtual Router Function (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) for your IBM Cloud infrastructure (SoftLayer) account. To enable VRF, [contact your IBM Cloud infrastructure (SoftLayer) account representative](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). If you cannot or do not want to enable VRF, enable [VLAN spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). When a VRF or VLAN spanning is enabled, the NLB 2.0 can route packets to various subnets in the account.

4. If you use [Calico pre-DNAT network policies](/docs/containers?topic=containers-network_policies#block_ingress) to manage traffic to the IP address of an NLB 2.0, you must add the `applyOnForward: true` and `doNotTrack: true` fields to and remove the `preDNAT: true` from the `spec` section in the policies. `applyOnForward: true` ensures that the Calico policy is applied to the traffic as it is encapsulated and forwarded. `doNotTrack: true` ensures that the worker nodes can use DSR to return a response packet directly to the client without needing the connection to be tracked. For example, if you use a Calico policy to whitelist traffic from only specific IP addresses to your NLB IP address, the policy looks similar to the following:
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      doNotTrack: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

Next, you can follow the steps in [Setting up an NLB 2.0 in a multizone cluster](#ipvs_multi_zone_config) or [in a single-zone cluster](#ipvs_single_zone_config).

<br />


## v2.0: Setting up an NLB 2.0 in a multizone cluster
{: #ipvs_multi_zone_config}

**Before you begin**:

* **Important**: Complete the [NLB 2.0 prerequisites](#ipvs_provision).
* To create public NLBs in multiple zones, at least one public VLAN must have portable subnets available in each zone. To create private NLBs in multiple zones, at least one private VLAN must have portable subnets available in each zone. You can add subnets by following the steps in [Configuring subnets for clusters](/docs/containers?topic=containers-subnets).
* If you restrict network traffic to edge worker nodes, ensure that at least 2 [edge worker nodes](/docs/containers?topic=containers-edge#edge) are enabled in each zone so that NLBs deploy uniformly.
* Ensure you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for the `default` namespace.


To set up an NLB 2.0 in a multizone cluster:
1.  [Deploy your app to the cluster](/docs/containers?topic=containers-app#app_cli). Ensure that you add a label to your deployment in the metadata section of your configuration file. This label is needed to identify all of the pods where your app is running so that they can be included in the load balancing.

2.  Create a load balancer service for the app that you want to expose to the public internet or a private network.
  1. Create a service configuration file that is named, for example, `myloadbalancer.yaml`.
  2. Define a load balancer service for the app that you want to expose. You can specify a zone, a VLAN, and an IP address.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
      ```
      {: codeblock}

      <table>
      <caption>Understanding the YAML file components</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>Annotation to specify a <code>private</code> or <code>public</code> load balancer.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Annotation to specify the zone that the load balancer service deploys to. To see zones, run <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Annotation to specify a VLAN that the load balancer service deploys to. To see VLANs, run <code>ibmcloud ks vlans --zone <zone></code>.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
        <td>Annotation to specify a version 2.0 load balancer.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
        <td>Optional: Annotation to specify the scheduling algorithm. Accepted values are <code>"rr"</code> for Round Robin (default) or <code>"sh"</code> for Source Hashing. For more information, see [2.0: Scheduling algorithms](#scheduling).</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>The label key (<em>&lt;selector_key&gt;</em>) and value (<em>&lt;selector_value&gt;</em>) that you used in the <code>spec.template.metadata.labels</code> section of your app deployment YAML.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>The port that the service listens on.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Optional: To create a private NLB or to use a specific portable IP address for a public NLB, specify the IP address that you want to use. The IP address must be in the zone and VLAN that you specify in the annotations. If you do not specify an IP address:<ul><li>If your cluster is on a public VLAN, a portable public IP address is used. Most clusters are on a public VLAN.</li><li>If your cluster is on a private VLAN only, a portable private IP address is used.</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>Set to <code>Local</code>.</td>
      </tr>
      </tbody></table>

      Example configuration file to create an NLB 2.0 service in `dal12` that uses the Round Robin scheduling algorithm:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
      ```
      {: codeblock}

  3. Optional: Make your NLB service available to only a limited range of IP addresses by specifying the IPs in the `spec.loadBalancerSourceRanges` field.  `loadBalancerSourceRanges` is implemented by `kube-proxy` in your cluster via Iptables rules on worker nodes. For more information, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Create the service in your cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verify that the NLB service was created successfully. It might take a few minutes for the NLB service to be created properly and for the app to be available.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Example CLI output:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    The **LoadBalancer Ingress** IP address is the portable IP address that was assigned to your NLB service.

4.  If you created a public NLB, access your app from the internet.
    1.  Open your preferred web browser.
    2.  Enter the portable public IP address of the NLB and port.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. To achieve high availability, repeat the steps 2 - 4 to add an NLB 2.0 in each zone where you have app instances.

6. Optional: An NLB service also makes your app available over the service's NodePorts. [NodePorts](/docs/containers?topic=containers-nodeport) are accessible on every public and private IP address for every node within the cluster. To block traffic to NodePorts while you are using an NLB service, see [Controlling inbound traffic to network load balancer (NLB) or NodePort services](/docs/containers?topic=containers-network_policies#block_ingress).

Next, you can [register an NLB host name](#loadbalancer_hostname).

<br />


## v2.0: Setting up an NLB 2.0 in a single-zone cluster
{: #ipvs_single_zone_config}

**Before you begin**:

* **Important**: Complete the [NLB 2.0 prerequisites](#ipvs_provision).
* You must have an available portable public or private IP address to assign to the NLB service. For more information, see [Configuring subnets for clusters](/docs/containers?topic=containers-subnets).
* Ensure you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for the `default` namespace.

To create an NLB 2.0 service in a single-zone cluster:

1.  [Deploy your app to the cluster](/docs/containers?topic=containers-app#app_cli). Ensure that you add a label to your deployment in the metadata section of your configuration file. This label is needed to identify all pods where your app is running so that they can be included in the load balancing.
2.  Create a load balancer service for the app that you want to expose to the public internet or a private network.
    1.  Create a service configuration file that is named, for example, `myloadbalancer.yaml`.

    2.  Define a load balancer 2.0 service for the app that you want to expose.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>Understanding the YAML file components</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotation to specify a <code>private</code> or <code>public</code> load balancer.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Optional: Annotation to specify a VLAN that the load balancer service deploys to. To see VLANs, run <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>Annotation to specify a load balancer 2.0.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>Optional: Annotation to specify a scheduling algorithm. Accepted values are <code>"rr"</code> for Round Robin (default) or <code>"sh"</code> for Source Hashing. For more information, see [2.0: Scheduling algorithms](#scheduling).</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>The label key (<em>&lt;selector_key&gt;</em>) and value (<em>&lt;selector_value&gt;</em>) that you used in the <code>spec.template.metadata.labels</code> section of your app deployment YAML.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>The port that the service listens on.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Optional: To create a private NLB or to use a specific portable IP address for a public NLB, specify the IP address that you want to use. The IP address must be on the VLAN that you specify in the annotations. If you do not specify an IP address:<ul><li>If your cluster is on a public VLAN, a portable public IP address is used. Most clusters are on a public VLAN.</li><li>If your cluster is on a private VLAN only, a portable private IP address is used.</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>Set to <code>Local</code>.</td>
        </tr>
        </tbody></table>

    3.  Optional: Make your NLB service available to only a limited range of IP addresses by specifying the IPs in the `spec.loadBalancerSourceRanges` field. `loadBalancerSourceRanges` is implemented by `kube-proxy` in your cluster via Iptables rules on worker nodes. For more information, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Create the service in your cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Verify that the NLB service was created successfully. It might take a few minutes for the service to be created and for the app to be available.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Example CLI output:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    The **LoadBalancer Ingress** IP address is the portable IP address that was assigned to your NLB service.

4.  If you created a public NLB, access your app from the internet.
    1.  Open your preferred web browser.
    2.  Enter the portable public IP address of the NLB and port.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Optional: An NLB service also makes your app available over the service's NodePorts. [NodePorts](/docs/containers?topic=containers-nodeport) are accessible on every public and private IP address for every node within the cluster. To block traffic to NodePorts while you are using an NLB service, see [Controlling inbound traffic to network load balancer (NLB) or NodePort services](/docs/containers?topic=containers-network_policies#block_ingress).

Next, you can [register an NLB host name](#loadbalancer_hostname).

<br />


## v2.0: Scheduling algorithms
{: #scheduling}

Scheduling algorithms determine how an NLB 2.0 assigns network connections to your app pods. As client requests arrive to your cluster, the NLB routes the request packets to worker nodes based on the scheduling algorithm. To use a scheduling algorithm, specify its Keepalived short name in the scheduler annotation of your NLB service configuration file: `service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`. Check the following lists to see which scheduling algorithms are supported in {{site.data.keyword.containerlong_notm}}. If you do not specify a scheduling algorithm, the Round Robin algorithm is used by default. For more information, see the [Keepalived documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](http://www.Keepalived.org/doc/scheduling_algorithms.html).
{: shortdesc}

### Supported scheduling algorithms
{: #scheduling_supported}

<dl>
<dt>Round Robin (<code>rr</code>)</dt>
<dd>The NLB cycles through the list of app pods when routing connections to worker nodes, treating each app pod equally. Round Robin is the default scheduling algorithm for version 2.0 NLBs.</dd>
<dt>Source Hashing (<code>sh</code>)</dt>
<dd>The NLB generates a hash key based on the source IP address of the client request packet. The NLB then looks up the hash key in a statically assigned hash table, and routes the request to the app pod that handles hashes of that range. This algorithm ensures that requests from a particular client are always directed to the same app pod.</br>**Note**: Kubernetes uses Iptables rules, which cause requests to be sent to a random pod on the worker. To use this scheduling algorithm, you must ensure that no more than one pod of your app is deployed per worker node. For example, if each pod has the label <code>run=&lt;app_name&gt;</code>, add the following anti-affinity rule to the <code>spec</code> section of your app deployment:</br>
<pre class="codeblock">
<code>
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: run
                  operator: In
                  values:
                  - <APP_NAME>
              topologyKey: kubernetes.io/hostname</code></pre>

You can find the complete example in [this IBM Cloud deployment pattern blog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-4-multi-zone-cluster-app-exposed-via-loadbalancer-aggregating-whole-region-capacity/).</dd>
</dl>

### Unsupported scheduling algorithms
{: #scheduling_unsupported}

<dl>
<dt>Destination Hashing (<code>dh</code>)</dt>
<dd>The destination of the packet, which is the NLB IP address and port, is used to determine which worker node handles the incoming request. However, the IP address and port for NLBs in {{site.data.keyword.containerlong_notm}} don't change. The NLB is forced to keep the request within the same worker node that it is on, so only app pods on one worker handle all incoming requests.</dd>
<dt>Dynamic connection counting algorithms</dt>
<dd>The following algorithms depend on dynamic counting of connections between clients and NLBs. However, because direct service return (DSR) prevents NLB 2.0 pods from being in the return packet path, NLBs don't keep track of established connections.<ul>
<li>Least Connection (<code>lc</code>)</li>
<li>Locality-Based Least Connection (<code>lblc</code>)</li>
<li>Locality-Based Least Connection with Replication (<code>lblcr</code>)</li>
<li>Never Queue (<code>nq</code>)</li>
<li>Shortest Expected Delay (<code>seq</code>)</li></ul></dd>
<dt>Weighted pod algorithms</dt>
<dd>The following algorithms depend on weighted app pods. However, in {{site.data.keyword.containerlong_notm}}, all app pods are assigned equal weight for load balancing.<ul>
<li>Weighted Least Connection (<code>wlc</code>)</li>
<li>Weighted Round Robin (<code>wrr</code>)</li></ul></dd></dl>

<br />


## Registering an NLB host name
{: #loadbalancer_hostname}

After you set up network load balancers (NLBs), you can create DNS entries for the NLB IPs by creating host names. You can also set up TCP/HTTP(S) monitors to health check the NLB IP addresses behind each host name.
{: shortdesc}

<dl>
<dt>Host name</dt>
<dd>When you create a public NLB in a single- or multizone cluster, you can expose your app to the internet by creating a host name for the NLB IP address. Additionally, {{site.data.keyword.cloud_notm}} takes care of generating and maintaining the wildcard SSL certificate for the host name for you.
<p>In multizone clusters, you can create a host name and add the NLB IP address in each zone to that host name DNS entry. For example, if you deployed NLBs for your app in 3 zones in US-South, you can create the host name `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` for the 3 NLB IP addresses. When a user accesses your app host name, the client accesses one of these IPs at random, and the request is sent to that NLB.</p>
Note that you currently cannot create host names for private NLBs.</dd>
<dt>Health check monitor</dt>
<dd>Enable health checks on the NLB IP addresses behind a single host name to determine whether they are available or not. When you enable a monitor for your host name, the monitor health checks each NLB IP and keeps the DNS lookup results updated based on these health checks. For example, if your NLBs have IP addresses `1.1.1.1`, `2.2.2.2`, and `3.3.3.3`, a normal operation DNS lookup of your host name returns all 3 IPs, 1 of which the client accesses at random. If the NLB with IP address `3.3.3.3` becomes unavailable for any reason, such as due to zone failure, then the health check for that IP fails, the monitor removes the failed IP from the host name, and the DNS lookup returns only the healthy `1.1.1.1` and `2.2.2.2` IPs.</dd>
</dl>

You can see all host names that are registered for NLB IPs in your cluster by running the following command.
```
ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
```
{: pre}

</br>

### Registering NLB IPs with a DNS host name
{: #loadbalancer_hostname_dns}

Expose your app to the public internet by creating a host name for the network load balancer (NLB) IP address.
{: shortdesc}

Before you begin:
* Review the following considerations and limitations.
  * You can create host names for public version 1.0 and 2.0 NLBs.
  * You currently cannot create host names for private NLBs.
  * You can register up to 128 host names. This limit can be lifted on request by opening a [support case](/docs/get-support?topic=get-support-getting-customer-support).
* [Create an NLB for your app in a single-zone cluster](#lb_config) or [create NLBs in each zone of a multizone cluster](#multi_zone_config).

To create a host name for one or more NLB IP addresses:

1. Get the **EXTERNAL-IP** address for your NLB. If you have NLBs in each zone of a multizone cluster that expose one app, get the IPs for each NLB.
  ```
  kubectl get svc
  ```
  {: pre}

  In the following example output, the NLB **EXTERNAL-IP**s are `168.2.4.5` and `88.2.4.5`.
  ```
  NAME             TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)                AGE
  lb-myapp-dal10   LoadBalancer   172.21.xxx.xxx   168.2.4.5         1883:30303/TCP         6d
  lb-myapp-dal12   LoadBalancer   172.21.xxx.xxx   88.2.4.5          1883:31303/TCP         6d
  ```
  {: screen}

2. Register the IP by creating a DNS host name. Note that you can initially create the host name with only one IP address.
  ```
  ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <NLB_IP>
  ```
  {: pre}

3. Verify that the host name is created.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Example output:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.2.4.5"]      None             created                   <certificate>
  ```
  {: screen}

4. If you have NLBs in each zone of a multizone cluster that expose one app, add the IPs of the other NLBs to the host name. Note that you must run the following command for each IP address that you want to add.
  ```
  ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
  ```
  {: pre}

5. Optional: Verify that the IPs are registered with your host name by running a `host` or `ns lookup`.
  Example command:
  ```
  host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
  ```
  {: pre}

  Example output:
  ```
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 88.2.4.5  
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 168.2.4.5
  ```
  {: screen}

6. In a web browser, enter the URL to access your app through the host name that you created.

Next, you can [enable health checks on the host name by creating a health monitor](#loadbalancer_hostname_monitor).

</br>

### Understanding the host name format
{: #loadbalancer_hostname_format}

Host names for NLBs follow the format `<cluster_name>-<globally_unique_account_HASH>-0001.<region>.containers.appdomain.cloud`.
{: shortdesc}

For example, a host name that you create for an NLB might look like `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud`. The following table describes each component of the host name.

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the LB host name format</th>
</thead>
<tbody>
<tr>
<td><code>&lt;cluster_name&gt;</code></td>
<td>The name of your cluster.
<ul><li>If the cluster name is 26 characters or fewer, the entire cluster name is included and is not modified: <code>myclustername</code>.</li>
<li>If the cluster name is 26 characters or greater and the cluster name is unique in this region, only the first 24 characters of the cluster name are used: <code>myveryverylongclusternam</code>.</li>
<li>If the cluster name is 26 characters or greater and there is an existing cluster of the same name in this region, only the first 17 characters of the cluster name are used and a dash with 6 random characters is added: <code>myveryverylongclu-ABC123</code>.</li></ul>
</td>
</tr>
<tr>
<td><code>&lt;globally_unique_account_HASH&gt;</code></td>
<td>A globally unique HASH is created for your {{site.data.keyword.cloud_notm}} account. All host names that you create for NLBs in clusters in your account use this globally unique HASH.</td>
</tr>
<tr>
<td><code>0001</code></td>
<td>
The first and second characters, <code>00</code>, indicate a public host name. The third and fourth characters, such as <code>01</code> or another number, act as a counter for each host name that you create.</td>
</tr>
<tr>
<td><code>&lt;region&gt;</code></td>
<td>The region that the cluster is created in.</td>
</tr>
<tr>
<td><code>containers.appdomain.cloud</code></td>
<td>The subdomain for {{site.data.keyword.containerlong_notm}} host names.</td>
</tr>
</tbody>
</table>

</br>

### Enable health checks on a host name by creating a health monitor
{: #loadbalancer_hostname_monitor}

Enable health checks on the NLB IP addresses behind a single host name to determine whether they are available or not.
{: shortdesc}

Before you begin, [register NLB IPs with a DNS host name](#loadbalancer_hostname_dns).

1. Get the name of your host name. In the output, note that the host has a monitor **Status** of `Unconfigured`.
  ```
  ibmcloud ks nlb-dns-monitor-ls --cluster <cluster_name_or_id>
  ```
  {: pre}

  Example output:
  ```
  Hostname                                                                                   Status         Type    Port   Path
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud        Unconfigured   N/A     0      N/A
  ```
  {: screen}

2. Create a health check monitor for the host name. If you do not include a configuration parameter, the default value is used.
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --enable --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
  ```
  {: pre}

  <table>
  <caption>Understanding this command's components</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
  </thead>
  <tbody>
  <tr>
  <td><code>--cluster &lt;cluster_name_or_ID&gt;</code></td>
  <td>Required: The name or ID of the cluster where the host name is registered.</td>
  </tr>
  <tr>
  <td><code>--nlb-host &lt;host_name&gt;</code></td>
  <td>Required: The host name to enable a health check monitor for.</td>
  </tr>
  <tr>
  <td><code>--enable</code></td>
  <td>Required: Enable the health check monitor for the host name.</td>
  </tr>
  <tr>
  <td><code>--description &lt;description&gt;</code></td>
  <td>A description of the health monitor.</td>
  </tr>
  <tr>
  <td><code>--type &lt;type&gt;</code></td>
  <td>The protocol to use for the health check: <code>HTTP</code>, <code>HTTPS</code>, or <code>TCP</code>. Default: <code>HTTP</code></td>
  </tr>
  <tr>
  <td><code>--method &lt;method&gt;</code></td>
  <td>The method to use for the health check. Default for <code>type</code> <code>HTTP</code> and <code>HTTPS</code>: <code>GET</code>. Default for <code>type</code> <code>TCP</code>: <code>connection_established</code></td>
  </tr>
  <tr>
  <td><code>--path &lt;path&gt;</code></td>
  <td>When <code>type</code> is <code>HTTPS</code>: The endpoint path to health check against. Default: <code>/</code></td>
  </tr>
  <tr>
  <td><code>--timeout &lt;timeout&gt;</code></td>
  <td>The timeout, in seconds, before the IP is considered unhealthy. Default: <code>5</code></td>
  </tr>
  <tr>
  <td><code>--retries &lt;retries&gt;</code></td>
  <td>When a timeout occurs, the number of retries to attempt before the IP is considered unhealthy. Retries are attempted immediately. Default: <code>2</code></td>
  </tr>
  <tr>
  <td><code>--interval &lt;interval&gt;</code></td>
  <td>The interval, in seconds, between each health check. Short intervals might improve failover time, but increase load on the IPs. Default: <code>60</code></td>
  </tr>
  <tr>
  <td><code>--port &lt;port&gt;</code></td>
  <td>The port number to connect to for the health check. When <code>type</code> is <code>TCP</code>, this parameter is required. When <code>type</code> is <code>HTTP</code> or <code>HTTPS</code>, define the port only if you use a port other than 80 for HTTP or 443 for HTTPS. Default for TCP: <code>0</code>. Default for HTTP: <code>80</code>. Default for HTTPS: <code>443</code>.</td>
  </tr>
  <tr>
  <td><code>--expected-body &lt;expected-body&gt;</code></td>
  <td>When <code>type</code> is <code>HTTP</code> or <code>HTTPS</code>: A case-insensitive sub-string that the health check looks for in the response body. If this string is not found, the IP is considered unhealthy.</td>
  </tr>
  <tr>
  <td><code>--expected-codes &lt;expected-codes&gt;</code></td>
  <td>When <code>type</code> is <code>HTTP</code> or <code>HTTPS</code>: HTTP codes that the health check looks for in the response. If the HTTP code is not found, the IP is considered unhealthy. Default: <code>2xx</code></td>
  </tr>
  <tr>
  <td><code>--allows-insecure &lt;true&gt;</code></td>
  <td>When <code>type</code> is <code>HTTP</code> or <code>HTTPS</code>: Set to <code>true</code> to not validate the certificate.</td>
  </tr>
  <tr>
  <td><code>--follows-redirects &lt;true&gt;</code></td>
  <td>When <code>type</code> is <code>HTTP</code> or <code>HTTPS</code>: Set to <code>true</code> to follow any redirects that are returned by the IP.</td>
  </tr>
  </tbody>
  </table>

  Example command:
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --desc "Login page monitor" --type HTTPS --method GET --path / --timeout 5 --retries 2 --interval 60 --expected-body "healthy" --expected-codes 2xx --follows-redirects true
  ```
  {: pre}

3. Verify that the health check monitor is configured with the correct settings.
  ```
  ibmcloud ks nlb-dns-monitor-get --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Example output:
  ```
  <placeholder - still want to test this one>
  ```
  {: screen}

4. View the health check status of the NLB IPs that are behind your host name.
  ```
  ibmcloud ks nlb-dns-monitor-status --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Example output:
  ```
  Hostname                                                                                IP          Health Monitor   H.Monitor Status
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     168.2.4.5   Enabled          Healthy
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     88.2.4.5    Enabled          Healthy
  ```
  {: screen}

</br>

### Updating and removing IPs and monitors from host names
{: #loadbalancer_hostname_delete}

You can add and remove NLB IP addresses from host names that you have generated. You can also disable and enable health check monitors for host names as needed.
{: shortdesc}

**NLB IPs**

If you later add more NLBs in other zones of your cluster to expose the same app, you can add the NLB IPs to the existing host name. Note that you must run the following command for each IP address that you want to add.
```
ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
```
{: pre}

You can also remove IP addresses of NLBs that you no longer want to be registered with a host name. Note that you must run the following command for each IP address that you want to remove. If you remove all IPs from a host name, the host name still exists but no IPs are associated with it.
```
ibmcloud ks nlb-dns-rm --cluster <cluster_name_or_id> --ip <ip1,ip2> --nlb-host <host_name>
```
{: pre}

</br>

**Health check monitors**

If you need to change your health monitor configuration, you can change specific settings. Include only the flags for the settings that you want to change.
```
ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
```
{: pre}

You can disable the health check monitor for a host name at any time by running the following command:
```
ibmcloud ks nlb-dns-monitor-disable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}

To re-enable a monitor for a host name, run the following command:
```
ibmcloud ks nlb-dns-monitor-enable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}


