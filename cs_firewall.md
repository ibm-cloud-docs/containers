---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-04"

keywords: kubernetes, iks

scope: containers

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




# Opening required ports and IP addresses in your firewall
{: #firewall}

Review these situations in which you might need to open specific ports and IP addresses in your firewalls for {{site.data.keyword.containerlong}}.
{:shortdesc}

* [To run `ibmcloud` commands](#firewall_bx) from your local system when corporate network policies prevent access to public internet endpoints via proxies or firewalls.
* [To run `kubectl` commands](#firewall_kubectl) from your local system when corporate network policies prevent access to public internet endpoints via proxies or firewalls.
* [To run `calicoctl` commands](#firewall_calicoctl) from your local system when corporate network policies prevent access to public internet endpoints via proxies or firewalls.
* [To allow communication between the Kubernetes master and the worker nodes](#firewall_outbound) when either a firewall is set up for the worker nodes or the firewall settings are customized in your IBM Cloud infrastructure (SoftLayer) account.
* [To allow the cluster to access resources over a firewall on the private network](#firewall_private).
* [To access the NodePort service, load balancer service, or Ingress from outside of the cluster](#firewall_inbound).

<br />


## Running `ibmcloud ks` commands from behind a firewall
{: #firewall_bx}

If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls, to run `ibmcloud ks` commands, you must allow TCP access for {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

1. Allow access to `containers.cloud.ibm.com` on port 443.
2. Verify your connection. If access is configured correctly, ships are displayed in the output.
   ```
   curl https://containers.cloud.ibm.com/v1/
   ```
   {: pre}

   Example output:
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}

<br />


## Running `kubectl` commands from behind a firewall
{: #firewall_kubectl}

If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls, to run `kubectl` commands, you must allow TCP access for the cluster.
{:shortdesc}

When a cluster is created, the port in the master URL is randomly assigned from within 20000-32767. You can either choose to open port range 20000-32767 for any cluster that might get created or you can choose to allow access for a specific existing cluster.

Before you begin, allow access to [run `ibmcloud ks` commands](#firewall_bx).

To allow access for a specific cluster:

1. Log in to the {{site.data.keyword.Bluemix_notm}} CLI. Enter your {{site.data.keyword.Bluemix_notm}} credentials when prompted. If you have a federated account, include the `--sso` option.

   ```
   ibmcloud login [--sso]
   ```
   {: pre}

2. If the cluster is in a resource group other than `default`, target that resource group. To see the resource group that each cluster belongs to, run `ibmcloud ks clusters`. **Note**: You must have at least the [**Viewer** role](/docs/containers?topic=containers-users#platform) for the resource group.
   ```
   ibmcloud target -g <resource_group_name>
   ```
   {: pre}

3. Select the region that your cluster is in.

   ```
   ibmcloud ks region-set
   ```
   {: pre}

4. Get the name of your cluster.

   ```
   ibmcloud ks clusters
   ```
   {: pre}

5. Retrieve the **Master URL** for your cluster.

   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   Example output:
   ```
   ...
   Master URL:		https://c3.<region>.containers.cloud.ibm.com:31142
   ...
   ```
   {: screen}

6. Allow access to the **Master URL** on the port, such as port `31142` from the previous example. If your firewall is IP-based, you can see which IP addresses are opened when you allow access to the master URL by reviewing [this table](#master_ips).

7. Verify your connection.

   ```
   curl --insecure <master_URL>/version
   ```
   {: pre}

   Example command:
   ```
   curl --insecure https://c3.<region>.containers.cloud.ibm.com:31142/version
   ```
   {: pre}

   Example output:
   ```
   {
     "major": "1",
     "minor": "7+",
     "gitVersion": "v1.7.4-2+eb9172c211dc41",
     "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
     "gitTreeState": "clean",
     "buildDate": "2017-11-16T08:13:08Z",
     "goVersion": "go1.8.3",
     "compiler": "gc",
     "platform": "linux/amd64"
   }
   ```
   {: screen}

8. Optional: Repeat these steps for each cluster that you need to expose.

<br />


## Running `calicoctl` commands from behind a firewall
{: #firewall_calicoctl}

If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls, to run `calicoctl` commands, you must allow TCP access for the Calico commands.
{:shortdesc}

Before you begin, allow access to run [`ibmcloud` commands](#firewall_bx) and [`kubectl` commands](#firewall_kubectl).

1. Retrieve the IP address from the master URL that you used to allow the [`kubectl` commands](#firewall_kubectl).

2. Get the port for etcd.

  ```
  kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
  ```
  {: pre}

3. Allow access for the Calico policies via the master URL IP address and the etcd port.

<br />


## Allowing the cluster to access infrastructure resources and other services
{: #firewall_outbound}

Let your cluster access infrastructure resources and services from behind a firewall, such as for {{site.data.keyword.containerlong_notm}} regions, {{site.data.keyword.registrylong_notm}}, {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM), {{site.data.keyword.monitoringlong_notm}}, {{site.data.keyword.loganalysislong_notm}}, IBM Cloud infrastructure (SoftLayer) private IPs, and egress for persistent volume claims.
{:shortdesc}



1.  Note the public IP address for all of your worker nodes in the cluster.

    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

2.  Allow outgoing network traffic from the source <em>&lt;each_worker_node_publicIP&gt;</em> to the destination TCP/UDP port range 20000-32767 and port 443, and the following IP addresses and network groups. If you have a corporate firewall that prevents your local machine from accessing public internet endpoints, do this step for both your source worker nodes and your local machine.

    You must allow outgoing traffic to port 443 for all of the zones within the region, to balance the load during the bootstrapping process. For example, if your cluster is in US South, you must allow traffic from the public IPs of each of your worker nodes to port 443 of the IP address for all the zones.
    {: important}

    {: #master_ips}
    <table summary="The first row in the table spans both columns. The rest of the rows should be read left to right, with the server zone in column one and IP addresses to match in column two.">
      <caption>IP addresses to open for outgoing traffic</caption>
          <thead>
          <th>Region</th>
          <th>Zone</th>
          <th>Public IP address</th>
          </thead>
        <tbody>
          <tr>
            <td>AP North</td>
            <td>che01<br>hkg02<br>seo01<br>sng01<br><br>tok02, tok04, tok05</td>
            <td><code>169.38.70.10</code><br><code>169.56.132.234</code><br><code>169.56.69.242</code><br><code>161.202.186.226</code><br><br><code>161.202.126.210, 128.168.71.117, 165.192.69.69</code></td>
           </tr>
          <tr>
             <td>AP South</td>
             <td>mel01<br><br>syd01, syd04, syd05</td>
             <td><code>168.1.97.67</code><br><br><code>168.1.8.195, 130.198.66.26, 168.1.12.98, 130.198.64.19</code></td>
          </tr>
          <tr>
             <td>EU Central</td>
             <td>ams03<br>mil01<br>osl01<br>par01<br><br>fra02, fra04, fra05</td>
             <td><code>169.50.169.110, 169.50.154.194</code><br><code>159.122.190.98, 159.122.141.69</code><br><code>169.51.73.50</code><br><code>159.8.86.149, 159.8.98.170</code><br><br><code>169.50.56.174, 161.156.65.42, 149.81.78.114</code></td>
            </tr>
          <tr>
            <td>UK South</td>
            <td>lon02, lon04, lon05, lon06</td>
            <td><code>159.122.242.78, 158.175.111.42, 158.176.94.26, 159.122.224.242, 158.175.65.170, 158.176.95.146</code></td>
          </tr>
          <tr>
            <td>US East</td>
             <td>mon01<br>tor01<br><br>wdc04, wdc06, wdc07</td>
             <td><code>169.54.126.219</code><br><code>169.53.167.50</code><br><br><code>169.63.88.186, 169.60.73.142, 169.61.109.34, 169.63.88.178, 169.60.101.42, 169.61.83.62</code></td>
          </tr>
          <tr>
            <td>US South</td>
            <td>hou02<br>mex01<br>sao01<br>sjc03<br>sjc04<br><br>dal10,dal12,dal13</td>
            <td><code>184.173.44.62</code><br><code>169.57.100.18</code><br><code>169.57.151.10</code><br><code>169.45.67.210</code><br><code>169.62.82.197</code><br><br><code>169.46.7.238, 169.48.230.146, 169.61.29.194, 169.46.110.218, 169.47.70.10, 169.62.166.98, 169.48.143.218, 169.61.177.2, 169.60.128.2</code></td>
          </tr>
          </tbody>
        </table>

3.  Allow outgoing network traffic from the worker nodes to [{{site.data.keyword.registrylong_notm}} regions](/docs/services/Registry?topic=registry-registry_overview#registry_regions):
    -   `TCP port 443, port 4443 FROM <each_worker_node_publicIP> TO <registry_subnet>`
    -   Replace <em>&lt;registry_subnet&gt;</em> with the registry subnet to which you want to allow traffic. The global registry stores IBM-provided public images, and regional registries store your own private or public images. Port 4443 is required for notary functions, such as [Verifying image signatures](/docs/services/Registry?topic=registry-registry_trustedcontent#registry_trustedcontent).
        <table summary="The first row in the table spans both columns. The rest of the rows should be read left to right, with the server zone in column one and IP addresses to match in column two.">
        <caption>IP addresses to open for Registry traffic</caption>
            <thead>
              <th>{{site.data.keyword.containerlong_notm}} region</th>
              <th>Registry address</th>
              <th>Registry subnets</th>
            </thead>
            <tbody>
              <tr>
                <td>Global registry across <br>{{site.data.keyword.containerlong_notm}} regions</td>
                <td><code>icr.io</code><br><br>
                Deprecated: <code>registry.bluemix.net</code></td>
                <td><code>169.60.72.144/28</code></br><code>169.61.76.176/28</code></br><code>169.62.37.240/29</code></br><code>169.60.98.80/29</code></br><code>169.63.104.232/29</code></td>
              </tr>
              <tr>
                <td>AP North</td>
                <td><code>jp.icr.io</code><br><br>
                Deprecated: <code>registry.au-syd.bluemix.net</code></td>
                <td><code>161.202.146.86/29</code></br><code>128.168.71.70/29</code></br><code>165.192.71.222/29</code></td>
              </tr>
              <tr>
                <td>AP South</td>
                <td><code>au.icr.io</code><br><br>
                Deprecated: <code>registry.au-syd.bluemix.net</code></td>
                <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></br><code>168.1.1.240/29</code></br><code>130.198.88.128/29</code></br><code>135.90.66.48/29</code></td>
              </tr>
              <tr>
                <td>EU Central</td>
                <td><code>de.icr.io</code><br><br>
                Deprecated: <code>registry.eu-de.bluemix.net</code></td>
                <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></br><code>169.50.58.104/29</code></br><code>161.156.93.16/29</code></br><code>149.81.79.152/29</code></td>
               </tr>
               <tr>
                <td>UK South</td>
                <td><code>uk.icr.io</code><br><br>
                Deprecated: <code>registry.eu-gb.bluemix.net</code></td>
                <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></br><code>158.175.97.184/29</code></br><code>158.176.105.64/29</code></br><code>141.125.71.136/29</code></td>
               </tr>
               <tr>
                <td>US East, US South</td>
                <td><code>us.icr.io</code><br><br>
                Deprecated: <code>registry.ng.bluemix.net</code></td>
                <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></br><code>169.61.234.224/29</code></br><code>169.61.135.160/29</code></br><code>169.61.46.80/29</code></td>
               </tr>
              </tbody>
            </table>

4. Allow outgoing network traffic from your worker node to {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM).
    - `TCP port 443 FROM <each_worker_node_publicIP> TO https://iam.bluemix.net`
    - `TCP port 443 FROM <each_worker_node_publicIP> TO https://iam.cloud.ibm.com`

5.  Optional: Allow outgoing network traffic from the worker nodes to {{site.data.keyword.monitoringlong_notm}}, {{site.data.keyword.loganalysislong_notm}}, Sysdig, and LogDNA services:
    *   **{{site.data.keyword.monitoringlong_notm}}**:
        <pre class="screen">TCP port 443, port 9095 FROM &lt;each_worker_node_public_IP&gt; TO &lt;monitoring_subnet&gt;</pre>
        Replace <em>&lt;monitoring_subnet&gt;</em> with the subnets for the monitoring regions to which you want to allow traffic:
        <p><table summary="The first row in the table spans both columns. The rest of the rows should be read left to right, with the server zone in column one and IP addresses to match in column two.">
  <caption>IP addresses to open for monitoring traffic</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}} region</th>
        <th>Monitoring address</th>
        <th>Monitoring subnets</th>
        </thead>
      <tbody>
        <tr>
         <td>EU Central</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>UK South</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>US East, US South, AP North, AP South</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
    *   **{{site.data.keyword.mon_full_notm}}**:
        <pre class="screen">TCP port 443, port 6443 FROM &lt;each_worker_node_public_IP&gt; TO &lt;sysdig_public_IP&gt;</pre>
        Replace `<sysdig_public_IP>` with the [Sysdig IP addresses](/docs/services/Monitoring-with-Sysdig?topic=Sysdig-network#network).
    *   **{{site.data.keyword.loganalysislong_notm}}**:
        <pre class="screen">TCP port 443, port 9091 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logging_public_IP&gt;</pre>
        Replace <em>&lt;logging_public_IP&gt;</em> with all of the addresses for the logging regions to which you want to allow traffic:
        <p><table summary="The first row in the table spans both columns. The rest of the rows should be read left to right, with the server zone in column one and IP addresses to match in column two.">
<caption>IP addresses to open for logging traffic</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}} region</th>
        <th>Logging address</th>
        <th>Logging IP addresses</th>
        </thead>
        <tbody>
          <tr>
            <td>US East, US South</td>
            <td>ingest.logging.ng.bluemix.net</td>
            <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
          </tr>
          <tr>
           <td>UK South</td>
           <td>ingest.logging.eu-gb.bluemix.net</td>
           <td><code>169.50.115.113</code></td>
          </tr>
          <tr>
           <td>EU Central</td>
           <td>ingest-eu-fra.logging.bluemix.net</td>
           <td><code>158.177.88.43</code><br><code>159.122.87.107</code></td>
          </tr>
          <tr>
           <td>AP South, AP North</td>
           <td>ingest-au-syd.logging.bluemix.net</td>
           <td><code>130.198.76.125</code><br><code>168.1.209.20</code></td>
          </tr>
         </tbody>
       </table>
</p>
    *   **{{site.data.keyword.la_full_notm}}**:
        <pre class="screen">TCP port 443, port 80 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logDNA_public_IP&gt;</pre>
        Replace `<logDNA_public_IP>` with the [LogDNA IP addresses](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-network#ips).

6. If you use load balancer services, ensure that all traffic using the VRRP protocol is allowed between worker nodes on the public and private interfaces. {{site.data.keyword.containerlong_notm}} uses the VRRP protocol to manage IP addresses for public and private load balancers.

7. {: #pvc}To create persistent volume claims for data storage, allow egress access through your firewall to IBM Cloud infrastructure (SoftLayer):
    - Allow access to the IBM Cloud infrastructure (SoftLayer) API endpoint to initiate provisioning requests: `TCP port 443 FROM <each_worker_node_public_IP> TO 66.228.119.120`.
    - Allow access to the IBM Cloud infrastructure (SoftLayer) IP range for the zone that your cluster is in for both the [**Frontend (public) network**](/docs/infrastructure/hardware-firewall-dedicated?topic=hardware-firewall-dedicated-ibm-cloud-ip-ranges#frontend-public-network) and [**Backend (private) Network**](/docs/infrastructure/hardware-firewall-dedicated?topic=hardware-firewall-dedicated-ibm-cloud-ip-ranges#backend-private-network). To find the zone of your cluster, run `ibmcloud ks clusters`.

<br />


## Allowing the cluster to access resources over a private firewall
{: #firewall_private}

If you have a firewall on the private network, allow communication between worker nodes and let your cluster access infrastructure resources over the private network.
{:shortdesc}

1. Allow all traffic between worker nodes.
    1. Allow all TCP, UDP, VRRP and IPEncap traffic between worker nodes on the public and private interfaces. {{site.data.keyword.containerlong_notm}} uses the VRRP protocol to manage IP addresses for private load balancers and the IPEncap protocol to permit pod to pod traffic across subnets.
    2. If you use Calico policies, or if you have firewalls in each zone of a multizone cluster, a firewall might block communication between worker nodes. You must open all worker nodes in the cluster to each other by using the workers' ports, workers' private IP addresses, or the Calico worker node label.

2. Allow the IBM Cloud infrastructure (SoftLayer) private IP ranges so that you can create worker nodes in your cluster.
    1. Allow the appropriate IBM Cloud infrastructure (SoftLayer) private IP ranges. See [Backend (private) Network](/docs/infrastructure/hardware-firewall-dedicated?topic=hardware-firewall-dedicated-ibm-cloud-ip-ranges#backend-private-network).
    2. Allow the IBM Cloud infrastructure (SoftLayer) private IP ranges for all of the [zones](/docs/containers?topic=containers-regions-and-zones#zones) that you are using. Note that you must add IPs for the `dal01` and `wdc04` zones. See [Service Network (on backend/private network)](/docs/infrastructure/hardware-firewall-dedicated?topic=hardware-firewall-dedicated-ibm-cloud-ip-ranges#service-network-on-backend-private-network-).

3. Open the following ports:
    - Allow outbound TCP and UDP connections from the workers to ports 80 and 443 to allow worker node updates and reloads.
    - Allow outbound TCP and UDP to port 2049 to allow mounting file storage as volumes.
    - Allow outbound TCP and UDP to port 3260 for communication to block storage.
    - Allow inbound TCP and UDP connections to port 10250 for the Kubernetes dashboard and commands such as `kubectl logs` and `kubectl exec`.
    - Allow inbound and outbound connections to TCP and UDP port 53 for DNS access.

4. If you also have a firewall on the public network, or if you have a private-VLAN only cluster and are using a gateway appliance as a firewall, you must also allow the IPs and ports specified in [Allowing the cluster to access infrastructure resources and other services](#firewall_outbound).

<br />


## Accessing NodePort, load balancer, and Ingress services from outside the cluster
{: #firewall_inbound}

You can allow incoming access to NodePort, load balancer, and Ingress services.
{:shortdesc}

<dl>
  <dt>NodePort service</dt>
  <dd>Open the port that you configured when you deployed the service to the public IP addresses for all of the worker nodes to allow traffic to. To find the port, run `kubectl get svc`. The port is in the 20000-32000 range.<dd>
  <dt>Load balancer service</dt>
  <dd>Open the port that you configured when you deployed the service to the load balancer service's public IP address.</dd>
  <dt>Ingress</dt>
  <dd>Open port 80 for HTTP or port 443 for HTTPS to the IP address for the Ingress application load balancer.</dd>
</dl>
