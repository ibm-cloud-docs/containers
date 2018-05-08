---

copyright:
  years: 2014, 2018
lastupdated: "2018-05-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Controlling traffic with network policies
{: #network_policies}

Every Kubernetes cluster is set up with a network plug-in that is called Calico. Default network policies are set up to secure the public network interface of every worker node in {{site.data.keyword.containerlong}}.
{: shortdesc}

If you have unique security requirements, you can use Calico and Kubernetes to create more network policies for a cluster. With Kubernetes network policies, you can specify the network traffic that you want to allow or block to and from a pod within a cluster. To set more advanced network policies such as blocking incoming (ingress) traffic to LoadBalancer services, use Calico.

<ul>
  <li>
  [Kubernetes network policies ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): These policies specify how pods can communicate with other pods and with external endpoints. As of Kubernetes version 1.8, both incoming and outgoing network traffic can be allowed or blocked based on protocol, port, and source or destination IP addresses. Traffic can also be filtered based on pod and namespace labels.</br>Kubernetes network policies are applied by using `kubectl` commands or the Kubernetes APIs. When these policies are applied, they are automatically converted into Calico network policies and Calico enforces these policies.
  </li>
  <li>
  Calico network policies for Kubernetes version [1.10 and later clusters ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) or [1.9 and earlier clusters ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): These policies are a superset of the Kubernetes network policies and add the following features.
    <ul>
    <li>Allow or block network traffic on specific network interfaces regardless of the Kubernetes pod source or destination IP address or CIDR.</li>
    <li>Allow or block network traffic for pods across namespaces.</li>
    <li>[Block incoming (ingress) traffic to LoadBalancer or NodePort Kubernetes services](#block_ingress).</li>
    </ul></br>
  Calico network policies are applied by using `calicoctl` commands.
  </li>
  </ul>

Calico enforces these policies, including any Kubernetes network policies that are automatically converted to Calico policies, by setting up Linux iptables rules on the Kubernetes worker nodes. Iptables rules serve as a firewall for the worker node to define the characteristics that the network traffic must meet to be forwarded to the targeted resource.

<br />


## Default Calico and Kubernetes network policies
{: #default_policy}

When a cluster is created, default Calico policies are set for the public network interface of each worker node to limit incoming traffic from the public internet. These policies don't affect pod to pod traffic and allow access to the Kubernetes nodeport, load balancer, and Ingress services.
{:shortdesc}

Default Calico policies are not applied to pods directly; they are applied to the public network interface of a worker node by using a Calico host endpoint. When a host endpoint is created in Calico, all traffic to and from that worker node's network interface is blocked, unless that traffic is allowed by a policy.

**Important:** Do not remove policies that are applied to a host endpoint unless you fully understand the policy. Be sure that you do not need the traffic that is being allowed by the policy.

 <table summary="The first row in the table spans both columns. The rest of the rows should be read left to right, with the server location in column one and IP addresses to match in column two.">
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Default Calico policies for each cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Allows all outbound traffic.</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>Allows incoming traffic on port 52311 to the BigFix app to allow necessary worker node updates.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Allows incoming ICMP packets (pings).</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Allows incoming nodeport, load balancer, and ingress service traffic to the pods that those services are exposing. <strong>Note</strong>: You don't have to specify the exposed ports because Kubernetes uses destination network address translation (DNAT) to forward the service requests to the correct pods. That forwarding takes place before the host endpoint policies are applied in iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Allows incoming connections for specific IBM Cloud infrastructure (SoftLayer) systems that are used to manage the worker nodes.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Allow VRRP packets, which are used to monitor and move virtual IP addresses between worker nodes.</td>
   </tr>
  </tbody>
</table>

In Kubernetes version 1.10 and newer clusters, a default Kubernetes policy which limits access to the Kubernetes Dashboard is also created.

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Default Kubernetes policies for each cluster</th>
</thead>
<tbody>
 <tr>
  <td><code>kubernetes-dashboard</code></td>
  <td><b>In Kubernetes v1.10 only</b>, provided in the <code>kube-system</code> namespace: Blocks all pods from accessing the Kubernetes Dashboard. This does not impact accessing the dashboard from the {{site.data.keyword.Bluemix_notm}} UI or via <code>kubectl proxy</code>. If a pod requires access to the dashboard, is should be deployed in a namespace with the <code>kubernetes-dashboard-policy: allow</code> label assigned.</td>
 </tr>
</tbody>
</table>

<br />


## Install and configure the Calico CLI
{: #cli_install}

To view, manage, and add Calico policies, install and configure the Calico CLI.
{:shortdesc}

The compatibility of Calico versions for CLI configuration and policies varies based on the Kubernetes version of your cluster. To install and configure the Calico CLI, click one of the following links based on your cluster version:

* [Kubernetes version 1.10 or later clusters](#1.10_install)
* [Kubernetes version 1.9 or earlier clusters](#1.9_install)

Before you update your cluster from Kubernetes version 1.9 or earlier to version 1.10 or later, review [Preparing to update to Calico v3](cs_versions.html#110_calicov3).
{: tip}

### Install and configure the version 3.1.1 Calico CLI for Kubernetes version 1.10 or later clusters
{: #1.10_install}

Before you begin, [target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure). Include the `--admin` option with the `bx cs cluster-config` command, which is used to download the certificates and permission files. This download also includes the keys for the Super User role, which you need to run Calico commands.

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

1. [Download the Calico CLI ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/projectcalico/calicoctl/releases/tag/v3.1.1).

    If you are using OSX, download the `-darwin-amd64` version. If you are using Windows, install the Calico CLI in the same directory as the {{site.data.keyword.Bluemix_notm}} CLI. This setup saves you some filepath changes when you run commands later.
    {: tip}

2. For OSX and Linux users, complete the following steps.
    1. Move the executable file to the _/usr/local/bin_ directory.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. Make the file an executable file.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Verify that the `calico` commands ran properly by checking the Calico CLI client version.

    ```
    calicoctl version
    ```
    {: pre}

4. **If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls**: See [Running `calicoctl` commands from behind a firewall](cs_firewall.html#firewall) for instructions on how to allow TCP access for Calico commands.

5. For Linux and OS X, create the `/etc/calico` directory. For Windows, any directory can be used.

  ```
  sudo mkdir -p /etc/calico/
  ```
  {: pre}

6. Create a `calicoctl.cfg` file.
    - Linux and OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: Create the file with a text editor.

7. Enter the following information in the <code>calicoctl.cfg</code> file.

    ```
    apiVersion: projectcalico.org/v3
    kind: CalicoAPIConfig
    metadata:
    spec:
        datastoreType: etcdv3
        etcdEndpoints: <ETCD_URL>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. Retrieve the `<ETCD_URL>`.

      - Linux and OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

          Example output:

          ```
          https://169.xx.xxx.xxx:30001
          ```
          {: screen}

      - Windows:
        <ol>
        <li>Get the calico configuration values from the configmap. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>In the `data` section, locate the etcd_endpoints value. Example: <code>https://169.xx.xxx.xxx:30001</code>
        </ol>

    2. Retrieve the `<CERTS_DIR>`, the directory that the Kubernetes certificates are downloaded in.

        - Linux and OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          Example output:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

            Output example:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **Note**: To get the directory path, remove the file name `kube-config-prod-<location>-<cluster_name>.yml` from the end of the output.

    3. Retrieve the `ca-*pem_file`.

        - Linux and OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>Open the directory that you retrieved in the last step.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> Locate the <code>ca-*pem&#95;file</code> file.</ol>

    4. Verify that the Calico configuration is working correctly.

        - Linux and OS X:

          ```
          calicoctl get nodes
          ```
          {: pre}

        - Windows:

          ```
          calicoctl get nodes --config=filepath/calicoctl.cfg
          ```
          {: pre}

          Output:

          ```
          NAME
          kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
          kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
          kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
          ```
          {: screen}


### Install and configure the version 1.6.3 Calico CLI for Kubernetes version 1.9 or earlier clusters
{: #1.9_install}

Before you begin, [target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure). Include the `--admin` option with the `bx cs cluster-config` command, which is used to download the certificates and permission files. This download also includes the keys for the Super User role, which you need to run Calico commands.

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}


1. [Download the Calico CLI ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.3).

    If you are using OSX, download the `-darwin-amd64` version. If you are using Windows, install the Calico CLI in the same directory as the {{site.data.keyword.Bluemix_notm}} CLI. This setup saves you some filepath changes when you run commands later.
    {: tip}

2. For OSX and Linux users, complete the following steps.
    1. Move the executable file to the _/usr/local/bin_ directory.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. Make the file an executable file.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Verify that the `calico` commands ran properly by checking the Calico CLI client version.

    ```
    calicoctl version
    ```
    {: pre}

4. **If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls**: See [Running `calicoctl` commands from behind a firewall](cs_firewall.html#firewall) for instructions on how to allow TCP access for Calico commands.

5. For Linux and OS X, create the `/etc/calico` directory. For Windows, any directory can be used.
    ```
    sudo mkdir -p /etc/calico/
    ```
    {: pre}

6. Create a `calicoctl.cfg` file.
    - Linux and OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: Create the file with a text editor.

7. Enter the following information in the <code>calicoctl.cfg</code> file.

    ```
    apiVersion: v1
    kind: calicoApiConfig
    metadata:
    spec:
        etcdEndpoints: <ETCD_URL>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. Retrieve the `<ETCD_URL>`.

      - Linux and OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

      - Output example:

          ```
          https://169.xx.xxx.xxx:30001
          ```
          {: screen}

      - Windows:
        <ol>
        <li>Get the calico configuration values from the configmap. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>In the `data` section, locate the etcd_endpoints value. Example: <code>https://169.xx.xxx.xxx:30001</code>
        </ol>

    2. Retrieve the `<CERTS_DIR>`, the directory that the Kubernetes certificates are downloaded in.

        - Linux and OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          Example output:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

          Example output:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **Note**: To get the directory path, remove the file name `kube-config-prod-<location>-<cluster_name>.yml` from the end of the output.

    3. Retrieve the `ca-*pem_file`.

        - Linux and OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>Open the directory that you retrieved in the last step.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> Locate the <code>ca-*pem&#95;file</code> file.</ol>

    4. Verify that the Calico configuration is working correctly.

        - Linux and OS X:

          ```
          calicoctl get nodes
          ```
          {: pre}

        - Windows:

          ```
          calicoctl get nodes --config=filepath/calicoctl.cfg
          ```
          {: pre}

          Output:

          ```
          NAME
          kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
          kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
          kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
          ```
          {: screen}

<br />


## Viewing network policies
{: #view_policies}

Before you begin:
1. [Install and configure the Calico CLI.](#cli_install)
2. [Target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure). Include the `--admin` option with the `bx cs cluster-config` command, which is used to download the certificates and permission files. This download also includes the keys for the Super User role, which you need to run Calico commands.
    ```
    bx cs cluster-config <cluster_name> --admin
    ```
    {: pre}

The compatibility of Calico versions for CLI configuration and policies varies based on the Kubernetes version of your cluster. To install and configure the Calico CLI, click one of the following links based on your cluster version:

* [Kubernetes version 1.10 or later clusters](#1.10_examine_policies)
* [Kubernetes version 1.9 or earlier clusters](#1.9_examine_policies)

Before you update your cluster from Kubernetes version 1.9 or earlier to version 1.10 or later, review [Preparing to update to Calico v3](cs_versions.html#110_calicov3).
{: tip}

### View network policies in Kubernetes version 1.10 or later clusters
{: #1.10_examine_policies}

1. View the Calico host endpoint.

    ```
    calicoctl get hostendpoint -o yaml
    ```
    {: pre}

2. View all of the Calico and Kubernetes network policies that were created for the cluster. This list includes policies that might not be applied to any pods or hosts yet. For a network policy to be enforced, a Kubernetes resource must be found that matches the selector that was defined in the Calico network policy.

    [Network policies ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) are scoped to specific namespaces:
    ```
    calicoctl get NetworkPolicy --all-namespaces -o wide
    ```

    [Global network policies ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) are not scoped to specific namespaces:
    ```
    calicoctl get GlobalNetworkPolicy -o wide
    ```
    {: pre}

3. View details for a network policy.

    ```
    calicoctl get NetworkPolicy -o yaml <policy_name> --namespace <policy_namespace>
    ```
    {: pre}

4. View the details of all global network policies for the cluster.

    ```
    calicoctl get GlobalNetworkPolicy -o yaml
    ```
    {: pre}

### View network policies in Kubernetes version 1.9 or earlier clusters
{: #1.9_examine_policies}

1. View the Calico host endpoint.

    ```
    calicoctl get hostendpoint -o yaml
    ```
    {: pre}

2. View all of the Calico and Kubernetes network policies that were created for the cluster. This list includes policies that might not be applied to any pods or hosts yet. For a network policy to be enforced, a Kubernetes resource must be found that matches the selector that was defined in the Calico network policy.

    ```
    calicoctl get policy -o wide
    ```
    {: pre}

3. View details for a network policy.

    ```
    calicoctl get policy -o yaml <policy_name>
    ```
    {: pre}

4. View the details of all network policies for the cluster.

    ```
    calicoctl get policy -o yaml
    ```
    {: pre}

<br />


## Adding network policies
{: #adding_network_policies}

In most cases, the default policies do not need to be changed. Only advanced scenarios might require changes. If you find that you must make changes, you can create your own network policies.
{:shortdesc}

To create Kubernetes network policies, see the [Kubernetes network policy documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

To create Calico policies, follow the steps below.

Before you begin:
1. [Install and configure the Calico CLI.](#cli_install)
2. [Target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure). Include the `--admin` option with the `bx cs cluster-config` command, which is used to download the certificates and permission files. This download also includes the keys for the Super User role, which you need to run Calico commands.
    ```
    bx cs cluster-config <cluster_name> --admin
    ```
    {: pre}

The compatibility of Calico versions for CLI configuration and policies varies based on the Kubernetes version of your cluster. Click one of the following links based on your cluster version:

* [Kubernetes version 1.10 or later clusters](#1.10_create_new)
* [Kubernetes version 1.9 or earlier clusters](#1.9_create_new)

Before you update your cluster from Kubernetes version 1.9 or earlier to version 1.10 or later, review [Preparing to update to Calico v3](cs_versions.html#110_calicov3).
{: tip}

### Adding Calico policies in Kubernetes version 1.10 or later clusters
{: #1.10_create_new}

1. Define your Calico [network policy ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) or [global network policy ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) by creating a configuration script (`.yaml`). These configuration files include the selectors that describe what pods, namespaces, or hosts that these policies apply to. Refer to these [sample Calico policies ![External link icon](../icons/launch-glyph.svg "External link icon")](http://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) to help you create your own.
    **Note**: Kubernetes version 1.10 or later clusters must use Calico v3 policy syntax.

2. Apply the policies to the cluster.
    - Linux and OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

### Adding Calico policies in Kubernetes version 1.9 or earlier clusters
{: #1.9_create_new}

1. Define your [Calico network policy ![External link icon](../icons/launch-glyph.svg "External link icon")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) by creating a configuration script (`.yaml`). These configuration files include the selectors that describe what pods, namespaces, or hosts that these policies apply to. Refer to these [sample Calico policies ![External link icon](../icons/launch-glyph.svg "External link icon")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) to help you create your own.
    **Note**: Kubernetes version 1.9 or earlier clusters must use Calico v2 policy syntax.


2. Apply the policies to the cluster.
    - Linux and OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

<br />


## Blocking incoming traffic to LoadBalancer or NodePort services
{: #block_ingress}

By default, Kubernetes `NodePort` and `LoadBalancer` services are designed to make your app available on all public and private cluster interfaces. However, you can block incoming traffic to your services based on traffic source or destination.
{:shortdesc}

A Kubernetes LoadBalancer service is also a NodePort service. A LoadBalancer service makes your app available over the load balancer IP address and port and makes your app available over the service's node ports. Node ports are accessible on every IP address (public and private) for every node within the cluster.

The cluster administrator can use Calico `preDNAT` network policies to block:

  - Traffic to NodePort services. Traffic to LoadBalancer services is allowed.
  - Traffic that is based on a source address or CIDR.

Some common uses for Calico `preDNAT` network policies:

  - Block traffic to public node ports of a private LoadBalancer service.
  - Block traffic to public node ports on clusters that are running [edge worker nodes](cs_edge.html#edge). Blocking node ports ensures that the edge worker nodes are the only worker nodes that handle incoming traffic.

Default Kubernetes and Calico policies are difficult to apply to protecting Kubernetes NodePort and LoadBalancer services due to the DNAT iptables rules generated for these services.

Calico `preDNAT` network policies can help you because they generate iptables rules based on a Calico
network policy resource. Kubernetes version 1.10 or later clusters use [network policies with `calicoctl.cfg` v3 syntax ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy). Kubernetes version 1.9 or earlier clusters use [policies with `calicoctl.cfg` v2 syntax ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

1. Define a Calico `preDNAT` network policy for ingress access to Kubernetes services.

    * Kubernetes version 1.10 or later clusters must use Calico v3 policy syntax.

        Example resource that blocks all node ports:

        ```
        apiVersion: projectcalico.org/v3
        kind: GlobalNetworkPolicy
        metadata:
          name: deny-kube-node-port-services
        spec:
          applyOnForward: true
          ingress:
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: TCP
            source: {}
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: UDP
            source: {}
          preDNAT: true
          selector: ibm.role in { 'worker_public', 'master_public' }
          types:
          - Ingress
        ```
        {: codeblock}

    * Kubernetes version 1.9 or earlier clusters must use Calico v2 policy syntax.

        Example resource that blocks all node ports:

        ```
        apiVersion: v1
        kind: policy
        metadata:
          name: deny-kube-node-port-services
        spec:
          preDNAT: true
          selector: ibm.role in { 'worker_public', 'master_public' }
          ingress:
          - action: deny
            protocol: tcp
            destination:
              ports:
              - 30000:32767
          - action: deny
            protocol: udp
            destination:
              ports:
              - 30000:32767
        ```
        {: codeblock}

2. Apply the Calico preDNAT network policy. It takes about 1 minute for the
policy changes to be applied throughout the cluster.

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}
