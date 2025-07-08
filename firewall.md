---

copyright: 
  years: 2014, 2025
lastupdated: "2025-07-08"


keywords: kubernetes, allowlist, firewall, vyatta, ips

subcollection: containers

---


{{site.data.keyword.attribute-definition-list}}


# Opening required ports and IP addresses in your allowlist
{: #firewall}

[Classic clusters]{: tag-classic-inf}

This allowlist information is specific to classic clusters. For VPC clusters, see [Opening required ports and IP addresses in your allowlist for VPC clusters](/docs/containers?topic=containers-vpc-firewall).
{: note}

Review these situations in which you might need to open specific ports and IP addresses in your allowlists for your {{site.data.keyword.containerlong}} clusters.
{: shortdesc}

- [Corporate allowlists](#corporate): If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, you must allow access to run `ibmcloud`, `ibmcloud ks`, `ibmcloud cr`, `kubectl`, and `calicoctl` commands from your local system.
- [Gateway appliance allowlists](#vyatta_firewall): If you have allowlists set up on the public or private network in your IBM Cloud infrastructure account, such as a VRA, you must open IP ranges, ports, and protocols to allow worker nodes to communicate with the master, with infrastructure resources, and with other {{site.data.keyword.cloud_notm}} services. You can also open ports to allow incoming traffic to services exposing apps in your cluster.
- [Calico network policies](#firewall_calico_egress): If you use Calico network policies to act as an allowlist to restrict all worker node egress, you must allow your worker nodes to access the resources that are required for the cluster to function.
- [Other services or network allowlists](#firewall_workers): To allow your cluster to access services that run inside or outside {{site.data.keyword.cloud_notm}} or in on-premises networks and that are protected by an allowlist, you must add the IP addresses of your worker nodes in that allowlist.


## Opening ports in a corporate allowlist
{: #corporate}

If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, you must allow access to run [`ibmcloud`, `ibmcloud ks`, and `ibmcloud cr` commands](#firewall_bx), [`kubectl` commands](#firewall_kubectl), and [`calicoctl` commands](#firewall_calicoctl) from your local system.



### Running `ibmcloud`, `ibmcloud ks`, and `ibmcloud cr` commands from behind an allowlist
{: #firewall_bx}

If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, to run `ibmcloud`, `ibmcloud ks` and `ibmcloud cr` commands, you must allow TCP access for {{site.data.keyword.cloud_notm}}, {{site.data.keyword.containerlong_notm}}, and {{site.data.keyword.registrylong_notm}}.
{: shortdesc}

1. Allow access to `cloud.ibm.com` on port 443 in your allowlist.
2. Verify your connection by logging in to {{site.data.keyword.cloud_notm}} through this API endpoint.

    ```sh
    ibmcloud login -a https://cloud.ibm.com/
    ```
    {: pre}

3. Allow access to `containers.cloud.ibm.com` on port 443 in your allowlist.
4. Verify your connection. If access is configured correctly, zones are displayed in the output.

    ```sh
    curl https://containers.cloud.ibm.com/v1/zones
    ```
    {: pre}

    Example output

    ```sh
    [{"id":"mon01","metro":""},{"id":"tor01","metro":""},{"id":"wdc04","metro":"Washington D.C."},{"id":"wdc06","metro":"Washington D.C."},{"id":"wdc07","metro":"Washington D.C."}]
    ```
    {: screen}


5. Allow access to the [{{site.data.keyword.registrylong_notm}} regions](/docs/Registry?topic=Registry-registry_overview#registry_regions) that you plan to use on port 443 in your allowlist. The global registry stores IBM-provided public images, and regional registries store your own private or public images.

6. Verify your connection by [listing your container registry namespaces](/apidocs/container-registry#list-namespaces){: external}.

### Running `kubectl` commands from behind an allowlist
{: #firewall_kubectl}

If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, to run `kubectl` commands, you must allow TCP access for the cluster.
{: shortdesc}

When a cluster is created, the port in the service endpoint URLs is randomly assigned from within 30000-32767. You can either choose to open port range 30000-32767 for any cluster that might get created or you can choose to allow access for a specific existing cluster.

Before you begin, allow access to [run `ibmcloud ks` commands](#firewall_bx).

To allow access for a specific cluster:

1. Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted. If you have a federated account, include the `--sso` option.

    ```sh
    ibmcloud login [--sso]
    ```
    {: pre}

2. If the cluster is in a resource group other than `default`, target that resource group. To see the resource group that each cluster belongs to, run `ibmcloud ks cluster ls`. **Note**: You must have at least the [**Viewer** role](/docs/containers?topic=containers-iam-platform-access-roles) for the resource group.

    ```sh
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

3. Get the name of your cluster.

    ```sh
    ibmcloud ks cluster ls
    ```
    {: pre}

4. Retrieve the service endpoint URLs for your cluster.

    - If only the **Public Service Endpoint URL** is populated, get this URL. Your authorized cluster users can access the master through this endpoint on the public network.
    - If only the **Private Service Endpoint URL** is populated, get this URL. Your authorized cluster users can access the master through this endpoint on the private network.
    - If both the **Public Service Endpoint URL** and **Private Service Endpoint URL** are populated, get both URLs. Your authorized cluster users can access the master through the public endpoint on the public network or the private endpoint on the private network.

    ```sh
    ibmcloud ks cluster get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ...
    Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
    Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
    ...
    ```
    {: screen}

5. Allow access to the service endpoint URLs and ports that you got in the previous step. If your allowlist is IP-based, you can see which IP addresses are opened when you allow access to the service endpoint URLs by reviewing [this table](#master_ips).

6. Verify your connection.

    - If the public cloud service endpoint is enabled:

        ```sh
        curl --insecure <public_service_endpoint_URL>/version
        ```
        {: pre}

        Example command:

        ```sh
        curl --insecure https://c3.<region>.containers.cloud.ibm.com:31142/version
        ```
        {: pre}

        Example output

        ```sh
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

    - If the private cloud service endpoint is enabled, you must be in your {{site.data.keyword.cloud_notm}} private network or connect to the private network through a VPN connection to verify your connection to the master. **Note**: You must [expose the master endpoint through a private load balancer](/docs/containers?topic=containers-access_cluster#access_private_se) so that users can access the master through a VPN or {{site.data.keyword.BluDirectLink}} connection.

        ```sh
        curl --insecure <private_service_endpoint_URL>/version
        ```
        {: pre}

        Example command:

        ```sh
        curl --insecure https://c3-private.<region>.containers.cloud.ibm.com:31142/version
        ```
        {: pre}

        Example output

        ```sh
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

7. Optional: Repeat these steps for each cluster that you need to expose.



### Running `calicoctl` commands from behind an allowlist
{: #firewall_calicoctl}

If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, to run `calicoctl` commands, you must allow TCP access for the Calico commands.
{: shortdesc}

Before you begin, allow access to run [`ibmcloud` commands](#firewall_bx) and [`kubectl` commands](#firewall_kubectl).

1. Retrieve the IP address from the master URL that you used to allow the [`kubectl` commands](#firewall_kubectl).

2. Get the port for etcd.

    ```sh
    kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
    ```
    {: pre}

3. Allow access for the Calico policies via the master URL IP address and the etcd port.


## Opening ports in gateway appliance allowlists
{: #vyatta_firewall}
{: help}
{: support}

If you have allowlists set up on the [public network](#firewall_outbound) or [private network](#firewall_private) in your IBM Cloud infrastructure account, such as a Virtual Router Appliance (Vyatta), you must open IP ranges, ports, and protocols to allow worker nodes to communicate with the master, with infrastructure resources, and with other {{site.data.keyword.cloud_notm}} services.
{: shortdesc}

### Opening required ports in a public allowlist
{: #firewall_outbound}

If you have an allowlist on the public network in your IBM Cloud infrastructure account, such as a Virtual Router Appliance (Vyatta), you must open IP ranges, ports, and protocols in your allowlist to allow worker nodes to communicate with the master, with infrastructure resources, and with other {{site.data.keyword.cloud_notm}} services.
{: shortdesc}

Before you begin, note the public IP address for each worker node in the cluster.

```sh
ibmcloud ks worker ls --cluster <cluster_name_or_ID>
```
{: pre}

#### Allow worker nodes to communicate with cluster master
{: #master_ips}

To allow worker nodes to communicate with the cluster master over the public cloud service endpoint, allow outgoing network traffic from the source *<each_worker_node_publicIP>* to the destination TCP/UDP port range 30000-32767 and port 443, and the following IP addresses and network groups.

This table is moving. For the latest IP lists and continued updates, see the public network isolation folder in the `IBM/kube-samples` [repo](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/public-network-isolation){: external}. You can **Watch** pull requests in the repo for updates.
{: important}

- `TCP/UDP port range 30000-32767, port 443 FROM <each_worker_node_publicIP> TO <public_IPs>`
- Replace *<public_IPs>* with the public IP addresses of the region that your cluster is located.

| Region             | Public IP address  | 
|--------------------|------------------|
| AP North (`che01`, `sng01`, `tok02`, `tok04`, `tok05`) | `119.81.194.90`, `119.81.222.210`, `128.168.106.194`, `128.168.71.117`, `128.168.75.194`, `128.168.85.154`, `135.90.69.66`, `135.90.69.82`, `161.202.126.210`, `161.202.154.10`, `161.202.186.226`, `161.202.56.10`, `161.202.57.34`, `165.192.69.69`, `165.192.80.146`, `165.192.83.202`, `165.192.95.90`, `169.38.68.178`, `169.38.70.10`, `169.38.79.170`, `169.56.1.162`, `169.56.132.234`, `169.56.48.114`, `169.56.69.242`, `169.56.96.42`, `104.94.220.124`, `104.94.221.124`, `104.94.222.132`, `104.94.223.132`, `104.96.176.124`, `104.96.177.124`, `104.96.178.126`, `104.96.179.126`, `104.96.180.123`, `104.96.181.123` | 
| AP South (`syd01`, `syd04`, `syd05`) | `130.198.64.19`, `130.198.66.26`, `130.198.79.170`, `130.198.83.34`, `130.198.102.82`, `135.90.66.2`, `135.90.68.114`, `135.90.69.66`, `135.90.69.82`, `135.90.89.234`, `168.1.6.106`, `168.1.8.195`, `168.1.12.98`, `168.1.39.34`, `168.1.58.66`, `104.94.220.125`, `104.94.221.125`, `104.94.222.133`, `104.94.223.133`, `104.96.176.125`, `104.96.177.125`, `104.96.178.127`, `104.96.179.127`, `104.96.180.124`, `104.96.181.124` | 
| EU Central (`ams03`, `mil01`,  `par01`, `fra02`, `fra04`, `fra05`) | `149.81.103.98`, `149.81.104.122`, `149.81.113.154`, `149.81.123.18`, `149.81.142.90`, `149.81.180.114`, `149.81.180.122`, `149.81.68.2`, `149.81.78.114`, `158.177.102.162`, `158.177.107.50`, `158.177.112.146`, `158.177.138.138`, `158.177.151.2`, `158.177.156.178`, `158.177.198.138`, `158.177.79.34`, `159.122.141.69`, `159.122.150.2`, `159.8.79.250`, `159.8.86.149`, `159.8.95.34`, `161.156.115.138`, `161.156.120.74`, `161.156.12.82`, `161.156.183.218`, `161.156.187.226`, `161.156.65.42`, `161.156.65.82`, `161.156.74.10`, `161.156.79.26`, `169.50.146.82`, `169.50.169.110`, `169.50.184.18`, `169.50.56.174`, `169.51.197.18`, `104.94.220.127`, `104.94.221.127`, `104.94.222.135`, `104.94.223.135`, `104.96.176.127`, `104.96.177.127`, `104.96.178.129`, `104.96.179.129`, `104.96.180.126`, `104.96.181.126` |
| Madrid (`mad02`, `mad04`, `mad05`) | `13.120.65.98`, `13.120.127.250`, `13.121.64.178`, `13.121.64.186`, `13.122.65.10`, `13.122.65.34`, `2.18.48.89`, `2.18.49.89`, `2.18.50.89`, `2.18.51.89`, `2.18.52.89`, `2.18.53.89`, `2.18.54.89`, `2.18.55.89`, `23.40.100.89`, `23.7.244.89` |
| Osaka (`osa21`, `osa22`, `osa23`) | `163.68.69.114`, `163.68.69.122`, `163.69.65.114`, `163.69.65.122`, `163.73.64.250`, `163.73.65.194`, `104.94.220.131`, `104.94.221.131`, `104.94.222.139`, `104.94.223.139`, `104.96.176.131`, `104.96.177.131`, `104.96.178.133`, `104.96.179.133`, `104.96.180.130`, `104.96.181.130` | 
| São Paulo (`sao01`, `sao04`, `sao05`) | `163.107.65.194`, `163.107.65.202`, `163.109.65.154`, `163.109.65.242`, `169.57.159.130`, `169.57.254.50`, `104.94.220.129`, `104.94.221.129`, `104.94.222.137`, `104.94.223.137`, `104.96.176.129`, `104.96.177.129`, `104.96.178.131`, `104.96.179.131`, `104.96.180.128`, `104.96.181.128` |
| Toronto (`tor01`, `tor04`, `tor05`) | `158.85.77.114`, `158.85.110.18`, `163.74.65.242`, `163.74.65.250`, `163.75.64.122`, `163.75.64.162`, `104.94.220.132`, `104.94.221.132`, `104.94.222.140`, `104.94.223.140`, `104.96.176.132`, `104.96.177.132`, `104.96.178.134`, `104.96.179.134`, `104.96.180.131`, `104.96.181.131` |
| UK South (`lon02`, `lon04`, `lon05`, `lon06`) | `141.125.102.106`, `141.125.66.26`, `141.125.67.34`, `141.125.77.58`, `141.125.91.138`, `158.175.111.42`, `158.175.125.194`, `158.175.139.130`, `158.175.150.122`, `158.175.65.170`, `158.175.77.178`, `158.175.82.50`, `158.176.123.130`, `158.176.135.242`, `158.176.142.26`, `158.176.149.154`, `158.176.71.242`, `158.176.94.26`, `158.176.95.146`, `159.122.224.242`, `159.122.242.78`, `104.94.220.126`, `104.94.221.126`, `104.94.222.134`, `104.94.223.134`, `104.96.176.126`, `104.96.177.126`, `104.96.178.128`, `104.96.179.128`, `104.96.180.125`, `104.96.181.125` |
| US East (`mon01`, `wdc04`, `wdc06`, `wdc07`) | `158.85.97.34`, `169.47.162.130`, `169.47.174.106`, `169.53.167.50`, `169.53.171.210`, `169.54.126.219`, `169.54.80.106`, `169.54.94.26`, `169.60.100.242`, `169.60.101.42`, `169.60.111.58`, `169.60.73.142`, `169.60.92.50`, `169.60.92.66`, `169.61.109.34`, `169.61.110.66`, `169.61.74.210`, `169.61.83.62`, `169.62.10.162`, `169.62.9.250`, `169.63.106.50`, `169.63.111.82`, `169.63.149.122`, `169.63.158.82`, `169.63.160.130`, `169.63.66.226`, `169.63.75.82`, `169.63.88.178`, `169.63.88.186`, `169.63.94.210`, `52.117.72.42`, `52.117.88.42`, `104.94.220.128`, `104.94.221.128`, `104.94.222.136`, `104.94.223.136`, `104.96.176.128`, `104.96.177.128`, `104.96.178.130`, `104.96.179.130`, `104.96.180.127`, `104.96.181.127` |
| US South (`sjc03`, `sjc04`, `dal10`, `dal12`, `dal13`) | `50.22.129.34`, `52.116.231.210`, `52.116.254.234`, `52.116.54.122`, `52.117.197.210`, `52.117.212.34`, `52.117.215.162`, `52.117.232.194`, `52.117.240.106`, `52.117.28.138`, `67.228.97.210`, `169.45.126.154`, `169.45.67.210`, `169.45.88.98`, `169.46.110.218`, `169.46.111.122`, `169.46.16.202`, `169.46.24.210`, `169.46.27.234`, `169.46.63.250`, `169.46.68.234`, `169.46.7.238`, `169.46.89.50`, `169.47.109.34`, `169.47.115.18`, `169.47.201.194`, `169.47.209.66`, `169.47.229.90`, `169.47.232.210`, `169.47.239.34`, `169.47.242.242`, `169.47.70.10`, `169.47.71.138`, `169.48.110.250`, `169.48.143.218`, `169.48.161.242`, `169.48.226.2`, `169.48.230.146`, `169.48.244.66`, `169.57.100.18`, `169.57.13.10`, `169.57.147.58`, `169.57.151.10`, `169.57.154.98`, `169.59.219.90`, `169.59.223.194`, `169.59.230.98`, `169.60.128.2`, `169.60.170.234`, `169.61.175.106`, `169.61.177.2`, `169.61.187.58`, `169.61.228.138`, `169.61.28.66`, `169.61.29.194`, `169.61.60.130`, `169.62.166.98`, `169.62.189.26`, `169.62.206.234`, `169.62.230.114`, `169.62.82.197`, `169.62.87.170`, `169.62.97.218`, `169.63.39.66`, `169.63.47.250`, `104.94.220.130`, `104.94.221.130`, `104.94.222.138`, `104.94.223.138`, `104.96.176.130`, `104.96.177.130`, `104.96.178.132`, `104.96.179.132`, `104.96.180.129`, `104.96.181.129` |
{: caption="IP addresses to open for outgoing traffic" caption-side="bottom"}

#### Allow worker nodes to communicate with {{site.data.keyword.registrylong_notm}}
{: #firewall_registry}

Allow outgoing network traffic from your worker nodes to {{site.data.keyword.registrylong_notm}}. For more information, see [Accessing {{site.data.keyword.registrylong_notm}} through a firewall](/docs/Registry?topic=Registry-registry_firewall).


#### Allow outgoing network traffic from worker node to IAM
{: #firewall-iam}

Allow outgoing network traffic from your worker node to {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM). Your allowlist must be Layer 7 to allow the IAM domain name. IAM does not have specific IP addresses that you can allow. If your allowlist does not support Layer 7, you can allow all HTTPS network traffic on port 443.

- `TCP port 443 FROM <each_worker_node_publicIP> TO https://iam.bluemix.net`
- `TCP port 443 FROM <each_worker_node_publicIP> TO https://iam.cloud.ibm.com`

#### Optional: Allow outgoing network traffic from the worker nodes to {{site.data.keyword.mon_short}} and {{site.data.keyword.logs_full_notm}} services
{: #firewall-mon-la}

- **{{site.data.keyword.mon_full_notm}}**: 

    - `TCP port 443, port 6443 FROM <each_worker_node_public_IP> TO <monitoring_public_IP>`
    - Replace *<monitoring_public_IP>* with the [{{site.data.keyword.mon_short}} IP addresses](/docs/monitoring?topic=monitoring-endpoints).

- **{{site.data.keyword.logs_full_notm}}**:

    - `TCP port 443, port 80 FROM <each_worker_node_public_IP> TO <logging_public_IP>`
    - Replace *<logging_public_IP>* with the [{{site.data.keyword.logs_full_notm}} IP addresses](/docs/cloud-logs?topic=cloud-logs-ips2open).

#### Optional: Allow incoming and outgoing network traffic for the managed Istio add-on
{: #firewall-istio}

- Allow outgoing network traffic from the `istio-egressgateway` load balancer through the following ports: `TCP port 80, port 15443 FROM <each_worker_node_publicIP>`
- Allow incoming network traffic to the `istiod` control plane and the `istio-ingressgateway` load balancer through the following ports: `TCP port 443, port 853, port 15010, port 15012, port 15014 FROM <each_worker_node_publicIP>`


#### Optional: Allow incoming network traffic for Ingress subdomain monitoring 
{: #firewall-ingress-domain-monitor}

If you want to use the [Ingress domain health monitoring](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor) to monitor the health of your service endpoints, you must allow inbound access from the monitoring services.

{{site.data.keyword.containerlong_notm}} is transitioning its internal DNS provider from Akamai to IBM NS1. During this transition period, ensure that all IP address ranges of Akamai and NS1 are allowlisted to ensure uninterrupted health monitoring.

By default, monitoring health requests are sent through HTTPS to port 443, therefore you must allowlist traffic from the below IP ranges targeted to port 443. If your health monitor is configured to use HTTP instead, allowlist traffic must be targeted to port 80. Additionally, if you use a custom TCP port, make sure to allow incoming traffic to that port.

For more information see the [IBM NS1 Connect Documentation about monitoring](https://www.ibm.com/docs/en/ns1-connect?topic=monitoring) and the [Akamai GTM Documentation](https://learn.akamai.com/en-us/webhelp/global-traffic-management/global-traffic-management-user-guide/GUID-C1995591-5D7D-42B9-B54F-0CF6C7BD2532.html).


##### Akamai GTM Monitoring Ranges

 - `193.108.155.118/32`
 - `8.18.43.199/32`
 - `8.18.43.240/32`
 - `66.198.8.167/32`
 - `66.198.8.168/32`
 - `67.220.143.216/31`
 - `173.205.7.116/31`
 - `209.249.98.36/31`
 - `207.126.104.118/31`
 - `63.217.211.110/31`
 - `63.217.211.116/31`
 - `204.2.159.68/31`
 - `209.107.208.188/31`
 - `124.40.41.200/29`
 - `125.252.224.36/31`
 - `125.56.219.52/31`
 - `192.204.11.4/31`
 - `204.1.136.238/31`
 - `204.2.160.182/31`
 - `204.201.160.246/31`
 - `205.185.205.132/31`
 - `220.90.198.178/31`
 - `60.254.173.30/31`
 - `61.111.58.82/31`
 - `63.235.21.192/31`
 - `64.145.89.236/31`
 - `65.124.174.194/31`
 - `69.31.121.20/31`
 - `69.31.138.100/31`
 - `77.67.85.52/31`
 - `203.69.138.120/30`
 - `66.198.26.68/30`
 - `201.33.187.68/30`
 - `2.16.0.0/13`
 - `23.0.0.0/12`
 - `23.192.0.0/11`
 - `23.32.0.0/11`
 - `23.64.0.0/14`
 - `23.72.0.0/13`
 - `69.192.0.0/16`
 - `72.246.0.0/15`
 - `88.221.0.0/16`
 - `92.122.0.0/15`
 - `95.100.0.0/15`
 - `96.16.0.0/15`
 - `96.6.0.0/15`
 - `104.64.0.0/10`
 - `118.214.0.0/16`
 - `173.222.0.0/15`
 - `184.24.0.0/13`
 - `184.50.0.0/15`
 - `184.84.0.0/14`


##### IBM NS1 Connect Monitoring IP Ranges

 - `163.114.225.0/24`
 - `163.114.230.0/24`
 - `163.114.231.0/24`

#### Next steps
{: #firewall_next_steps}

If you use load balancer services, ensure that all traffic that uses the VRRP protocol is allowed between worker nodes on the public and private interfaces. {{site.data.keyword.containerlong_notm}} uses the VRRP protocol to manage IP addresses for public and private load balancers.




### Opening required ports in a private allowlist
{: #firewall_private}

If you have an allowlist on the private network in your IBM Cloud infrastructure account, such as a Virtual Router Appliance (Vyatta), you must open IP ranges, ports, and protocols in your allowlist to allow worker nodes to communicate with the master, with each other, with infrastructure resources, and with other {{site.data.keyword.cloud_notm}} services.
{: shortdesc}

Before you begin

1. Allow the IBM Cloud infrastructure private IP ranges so that you can create worker nodes in your cluster.

    1. Allow the appropriate IBM Cloud infrastructure private IP ranges. See [Backend (private) Network](/docs/infrastructure-hub?topic=infrastructure-hub-ibm-cloud-ip-ranges#back-end-network).
    2. Allow the IBM Cloud infrastructure private IP ranges for all the [zones](/docs/containers?topic=containers-regions-and-zones#locations) that you are using. **Note**: You must add the `166.8.0.0/14` and `161.26.0.0/16` IP ranges, the IP ranges for the `dal10` and `wdc04` zones. See [Service Network (on backend/private network)](/docs/infrastructure-hub?topic=infrastructure-hub-ibm-cloud-ip-ranges#back-end-network).

2. Note the private IP address for each worker node in the cluster.

    ```sh
    ibmcloud ks worker ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

#### Allow worker nodes to communicate with cluster master
{: #firewall_private_worker}

To allow worker nodes to communicate with the cluster master over the private cloud service endpoint, allow outgoing network traffic from the source *<each_worker_node_privateIP>* to the destination TCP/UDP port range 30000-32767 and port 443, and the following IP addresses and network groups.

This table is moving. For the latest IP lists and continued updates, see the private network isolation folder in the `IBM/kube-samples` [repo](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/private-network-isolation){: external}. You can **Watch** pull requests in the repo for updates.
{: important}

- `TCP/UDP port range 30000-32767, port 443 FROM <each_worker_node_privateIP> TO <private_IPs>`
- Replace *<private_IPs>* with the private IP addresses of the region where your cluster is located.

| Region | Private IP address  |
|---------------|-------------|
| AP North (`che01`, `sng01`, `tok02`, `tok04`, `tok05`) | `166.9.40.102`, `166.9.40.21`, `166.9.40.36`, `166.9.40.39`, `166.9.40.6`, `166.9.40.7`, `166.9.40.8`, `166.9.40.88`, `166.9.42.23`, `166.9.42.28`, `166.9.42.55`, `166.9.42.6`, `166.9.42.7`, `166.9.42.97`, `166.9.44.15`, `166.9.44.3`, `166.9.44.4`, `166.9.44.47`, `166.9.44.5`, `166.9.44.88`, `166.9.46.4`, `166.9.60.2`, `166.9.60.4`, `166.9.249.106`, `166.9.249.136`, `166.9.249.170` |
| AP South (`syd01`, `syd04`, `syd05`) | `166.9.52.14`, `166.9.52.15`, `166.9.52.23`, `166.9.52.30`, `166.9.52.31`, `166.9.54.11`, `166.9.54.12`, `166.9.54.13`, `166.9.54.21`, `166.9.54.32`, `166.9.54.33`, `166.9.56.10`, `166.9.56.11`, `166.9.56.16`, `166.9.56.24`, `166.9.56.36`, `166.9.244.107`, `166.9.244.137`, `166.9.244.171` |
| EU Central (`ams03`, `mil01`,  `par01`, `fra02`, `fra04`, `fra05`) | `166.9.28.107`, `166.9.28.17`, `166.9.28.19`, `166.9.28.20`, `166.9.28.203`, `166.9.28.22`, `166.9.28.23`, `166.9.28.235`, `166.9.28.24`, `166.9.28.240`, `166.9.28.43`, `166.9.28.64`, `166.9.28.84`, `166.9.28.87`, `166.9.28.91`, `166.9.28.94`, `166.9.28.95`, `166.9.30.100`, `166.9.30.11`, `166.9.30.116`, `166.9.30.12`, `166.9.30.13`, `166.9.30.22`, `166.9.30.41`, `166.9.30.54`, `166.9.30.56`, `166.9.30.9`, `166.9.30.92`, `166.9.32.101`, `166.9.32.185`, `166.9.32.20`, `166.9.32.26`, `166.9.32.27`, `166.9.32.44`, `166.9.32.54`, `166.9.32.56`, `166.9.32.84`, `166.9.32.88`, `166.9.32.9`, `166.9.248.77`, `166.9.248.106`, `166.9.248.137` |
| Madrid (`mad02`, `mad04`, `mad05`) | `166.9.94.6`, `166.9.95.6`, `166.9.96.6`, `166.9.94.7`, `166.9.95.7`, `166.9.96.7` |
| Osaka (`osa21`, `osa22`, `osa23`) | `166.9.70.6`, `166.9.70.8`, `166.9.71.8`, `166.9.71.10`, `166.9.72.9`, `166.9.72.10`, `166.9.247.41`, `166.9.247.75`, `166.9.247.107` | 
| UK South (`lon02`,`lon04`, `lon05`, `lon06`) | `166.9.34.17`, `166.9.34.41`, `166.9.34.45`, `166.9.34.5`, `166.9.34.50`, `166.9.34.6`, `166.9.34.77`, `166.9.36.10`, `166.9.36.11`, `166.9.36.12`, `166.9.36.13`, `166.9.36.23`, `166.9.36.30`, `166.9.36.53`, `166.9.36.65`, `166.9.36.95`, `166.9.38.18`, `166.9.38.28`, `166.9.38.46`, `166.9.38.54`, `166.9.38.6`, `166.9.38.7`, `166.9.38.75`, `166.9.244.12`, `166.9.244.48`, `166.9.244.75` |
| US East (`mon01`, `tor01`, `wdc04`, `wdc06`, `wdc07`) | `166.9.20.11`, `166.9.20.117`, `166.9.20.12`, `166.9.20.13`, `166.9.20.187`, `166.9.20.38`, `166.9.20.42`, `166.9.20.63`, `166.9.20.80`, `166.9.22.10`, `166.9.22.109`, `166.9.22.211`, `166.9.22.215`, `166.9.22.26`, `166.9.22.43`, `166.9.22.51`, `166.9.22.52`, `166.9.22.8`, `166.9.22.9`, `166.9.24.19`, `166.9.24.196`, `166.9.24.198`, `166.9.24.22`, `166.9.24.35`, `166.9.24.4`, `166.9.24.45`, `166.9.24.47`, `166.9.24.5`, `166.9.24.90`, `166.9.68.130`, `166.9.68.134`, `166.9.68.34`, `166.9.68.47`, `166.9.231.217`, `166.9.232.15`, `166.9.251.118` |
| US South (`sao01`, `sjc03`, `sjc04`, `dal10`, `dal12`, `dal13`) | `166.9.12.140`, `166.9.12.141`, `166.9.12.142`, `166.9.12.143`, `166.9.12.144`, `166.9.12.151`, `166.9.12.193`, `166.9.12.196`, `166.9.12.26`, `166.9.12.99`, `166.9.13.31`, `166.9.13.93`, `166.9.13.94`, `166.9.14.122`, `166.9.14.125`, `166.9.14.202`, `166.9.14.204`, `166.9.14.205`, `166.9.14.95`, `166.9.15.130`, `166.9.15.69`, `166.9.15.70`, `166.9.15.71`, `166.9.15.72`, `166.9.15.73`, `166.9.15.74`, `166.9.15.75`, `166.9.15.76`, `166.9.16.113`, `166.9.16.137`, `166.9.16.149`, `166.9.16.183`, `166.9.16.184`, `166.9.16.185`, `166.9.16.38`, `166.9.16.39`, `166.9.16.5`, `166.9.17.2`, `166.9.17.35`, `166.9.17.37`, `166.9.17.39`, `166.9.48.124`, `166.9.48.171`, `166.9.48.175`, `166.9.48.240`, `166.9.48.35`, `166.9.48.50`, `166.9.48.76`, `166.9.51.104`, `166.9.51.106`, `166.9.51.16`, `166.9.51.54`, `166.9.51.74`, `166.9.58.104`, `166.9.58.11`, `166.9.58.16`, `166.9.58.170`, `166.9.58.210`, `166.9.58.64`, `166.9.58.65`, `166.9.59.125`, `166.9.59.147`, `166.9.61.15`, `166.9.61.54`, `166.9.85.114`, `166.9.88.186`, `166.9.88.196`, `166.9.88.21`, `166.9.228.8`, `166.9.229.10`, `166.9.230.9` |
{: caption="IP addresses to open for outgoing traffic" caption-side="bottom"}

#### Open ports
{: #firewall_private_open_ports}

Open the following ports in your allowlist for your worker nodes to function properly. The following ports need should be open all destination IPs.

- Allow outbound TCP and UDP connections from the workers to ports 80 and 443 to allow worker node updates and reloads.
- Allow outbound TCP and UDP to port 2049 to allow mounting file storage as volumes.
- Allow outbound TCP and UDP to port 3260 for communication to block storage.
- Allow inbound TCP and UDP connections to port 10250 for the Kubernetes dashboard and commands such as `kubectl logs` and `kubectl exec`.
- Allow inbound and outbound connections to TCP and UDP port 53 for DNS access.

#### Enable worker-to-worker communication
{: #firewall_private_worker2worker}

Enable worker-to-worker communication by allowing all TCP, UDP, VRRP, and IPEncap traffic between worker nodes on the private interfaces and also allow VRRP on the public interface. {{site.data.keyword.containerlong_notm}} uses the VRRP protocol to manage IP addresses for load balancers and the IPEncap protocol to permit pod to pod traffic across subnets.

#### Permit worker nodes to communicate with {{site.data.keyword.registrylong_notm}}
{: #firewall_private_container_registry}

To permit worker nodes to communicate with {{site.data.keyword.registrylong_notm}}, allow outgoing network traffic from the worker nodes to [{{site.data.keyword.registrylong_notm}} regions](/docs/Registry?topic=Registry-registry_overview#registry_regions).

- `TCP port 443 FROM <each_worker_node_privateIP> TO <registry_ip>`
- Replace `<registry_ip>` with the registry IP address to which you want to allow traffic. The global registry stores IBM-provided public images, and regional registries store your own private or public images.

On 23 June 2022, only the `br-sao` and `ca-tor` regions changed. The remaining regions changed on 5 July 2022. For more information, see [{{site.data.keyword.registryshort}} private IP addresses changed on 5 July 2022](/docs/Registry?topic=Registry-registry_notices_iam_private_network).
{: note}

| {{site.data.keyword.containerlong_notm}} region | Registry address  | Registry private IP addresses until 5 July 2022 | Registry private IP addresses after 5 July 2022 |
| --- | --- | --- | --- |
| Global registry across {{site.data.keyword.containerlong_notm}} regions | `private.icr.io` `cp.icr.io` | 166.9.20.31, 166.9.22.22, 166.9.24.16 | 166.9.251.49, 166.9.251.82, 166.9.251.113 |
| AP North | `private.jp.icr.io` | 166.9.40.20, 166.9.42.21, 166.9.44.12 | 166.9.249.104, 166.9.249.157, 166.9.249.168 |
| AP South | `private.au.icr.io` | 166.9.52.20, 166.9.54.19, 166.9.56.13 | 166.9.244.106, 166.9.244.136, 166.9.244.170 |
| EU Central | `private.de.icr.io` | 166.9.28.35, 166.9.30.2, 166.9.32.2 | 166.9.248.76, 166.9.248.105, 166.9.248.136 |
| Madrid | `private.es.icr.io` | N/A | 166.9.248.76, 166.9.248.105, 166.9.248.136 |
| Osaka | `private.jp2.icr.io` | 166.9.70.4, 166.9.71.5, 166.9.72.6 | 166.9.247.39, 166.9.247.73, 166.9.247.105 |
| Sao Paolo | `private.br.icr.io` | 166.9.82.13, 166.9.83.13, 166.9.84.13 | 166.9.246.72, 166.9.246.104, 166.9.246.130 |
| Toronto | `private.ca.icr.io` | 166.9.76.12, 166.9.77.11, 166.9.78.11 | 166.9.247.143, 166.9.247.170, 166.9.247.207 |
| UK South | `private.uk.icr.io` | 166.9.36.19, 166.9.38.14, 166.9.34.12 | 166.9.244.9, 166.9.244.45, 166.9.244.73 |
| US East, US South | `private.us.icr.io` | 166.9.12.227, 166.9.15.116, 166.9.16.244 | 166.9.250.214, 166.9.250.246, 166.9.251.21 |
{: caption="IP addresses to open for Registry traffic" caption-side="bottom"}

#### Create persistent volume claims 
{: #pvc}

To create persistent volume claims in a cluster where worker nodes are connected to private VLANs only, make sure that your cluster is set up with the following Kubernetes version or {{site.data.keyword.cloud_notm}} storage plug-in versions. These versions enable private network communication from your cluster to your persistent storage instances.

| Type of storage   | Required version  | 
|--------------------|------------------|
| File storage | Kubernetes version `1.13.4_1512`, `1.12.6_1544`, `1.11.8_1550`, `1.10.13_1551`, or later
| Block storage | {{site.data.keyword.cloud_notm}} Block Storage plug-in version 1.3.0 or later |
| Object storage | {{site.data.keyword.cos_full_notm}} plug-in version 1.0.3 or later, {{site.data.keyword.cos_full_notm}} service set up with HMAC authentication |
{: caption="Overview of required Kubernetes or {{site.data.keyword.cloud_notm}} storage plug-in versions for private clusters" caption-side="bottom"}

If you must use a Kubernetes version or {{site.data.keyword.cloud_notm}} storage plug-in version that does not support network communication over the private network, or if you want to use {{site.data.keyword.cos_full_notm}} without HMAC authentication, allow egress access through your allowlist to IBM Cloud infrastructure and {{site.data.keyword.cloud_notm}} Identity and Access Management:

- Allow all egress network traffic on TCP port 443.
- Allow access to the IBM Cloud infrastructure IP range for the zone that your cluster is in for both the [**Front-end (public) network**](/docs/infrastructure-hub?topic=infrastructure-hub-ibm-cloud-ip-ranges#front-end-network) and [**Back-end (private) Network**](/docs/infrastructure-hub?topic=infrastructure-hub-ibm-cloud-ip-ranges#back-end-network). To find the zone of your cluster, run `ibmcloud ks cluster ls`.

#### Optional: Set up allowlist rules for {{site.data.keyword.logs_full_notm}} and {{site.data.keyword.mon_full_notm}} services
{: #firewall_private_mon_la}

To send logging and metric data, set up allowlist rules for your {{site.data.keyword.logs_full_notm}} and {{site.data.keyword.mon_full_notm}} services.

- [{{site.data.keyword.logs_full_notm}} private endpoints](/docs/cloud-logs?topic=cloud-logs-endpoints_api#private-endpoints)
- [{{site.data.keyword.mon_short}} private endpoints](/docs/monitoring?topic=monitoring-endpoints#endpoints_monitoring)

### Opening ports in a public or private allowlist for inbound traffic
{: #firewall_inbound}

You can allow incoming access to NodePort, load balancer, and Ingress services.
{: shortdesc}

NodePort service
:   Open the port that you configured when you deployed the service to the public or private IP addresses for all the worker nodes to allow traffic to. To find the port, run `kubectl get svc`. The port is in the 20000-32000 range.

Load balancer service
:   Open the port that you configured when you deployed the service to the load balancer service's public or private IP address.

Ingress
:   Open port 80 for HTTP and port 443 for HTTPS to the public or private IP address for the Ingress application load balancer.

Route
:   Open port 80 for HTTP and port 443 for HTTPS to the router's public IP address.


## Allowing the cluster to access resources through Calico network policies
{: #firewall_calico_egress}

Instead of setting up a gateway allowlist device, you can choose to use [Calico network policies](/docs/containers?topic=containers-network_policies) to act as a cluster allowlist on the public or private network. For more information, see the following topics.
{: shortdesc}

- [Isolating clusters on the public network](/docs/containers?topic=containers-network_policies#isolate_workers_public).
- [Isolating clusters on the private network](/docs/containers?topic=containers-network_policies#isolate_workers).



## Allowing traffic from your cluster in other services' allowlists or in on-premises allowlists
{: #firewall_workers}

If you want to access services that run inside or outside {{site.data.keyword.cloud_notm}} or on-premises and that are protected by an allowlist, you can add the IP addresses of your worker nodes in that allowlist to allow outbound network traffic to your cluster. For example, you might want to read data from an {{site.data.keyword.cloud_notm}} database that is protected by an allowlist, or specify your worker node subnets in an on-premises allowlist to allow network traffic from your cluster.
{: shortdesc}

1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

2. Get the worker node subnets or the worker node IP addresses.

    - **Worker node subnets**: If you anticipate changing the number of worker nodes in your cluster frequently, such as if you enable the [cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-install-addon), you might not want to update your allowlist for each new worker node. Instead, you can add the VLAN subnets that the cluster uses. Keep in mind that the VLAN subnet might be shared by worker nodes in other clusters.
        Note that the **primary public subnets** that {{site.data.keyword.containerlong_notm}} provisions for your cluster come with 14 available IP addresses, and can be shared by other clusters on the same VLAN. When you have more than 14 worker nodes, another subnet is ordered, so the subnets that you need to allow can change. To reduce the frequency of change, create worker pools with worker node flavors of higher CPU and memory resources so that you don't need to add worker nodes as often.

        1. List the worker nodes in your cluster.

            ```sh
            ibmcloud ks worker ls --cluster <cluster_name_or_ID>
            ```
            {: pre}

        2. From the output of the previous step, note all the unique network IDs (first three octets) of the **Public IP** for the worker nodes in your cluster. If you want to allow traffic from a private-only cluster, note the **Private IP** instead. In the following output, the unique network IDs are `169.xx.178` and `169.xx.210`.

            ```sh
            ID                                                  Public IP        Private IP     Machine Type        State    Status   Zone    Version   
            kube-dal10-crb2f60e9735254ac8b20b9c1e38b649a5-w31   169.xx.178.101   10.xxx.xx.xxx   b3c.4x16.encrypted   normal   Ready    dal10   1.32   
            kube-dal10-crb2f60e9735254ac8b20b9c1e38b649a5-w34   169.xx.178.102   10.xxx.xx.xxx   b3c.4x16.encrypted   normal   Ready    dal10   1.32  
            kube-dal12-crb2f60e9735254ac8b20b9c1e38b649a5-w32   169.xx.210.101   10.xxx.xx.xxx   b3c.4x16.encrypted   normal   Ready    dal12   1.32   
            kube-dal12-crb2f60e9735254ac8b20b9c1e38b649a5-w33   169.xx.210.102   10.xxx.xx.xxx   b3c.4x16.encrypted   normal   Ready    dal12   1.32  
            ```
            {: screen}

        3. List the VLAN subnets for each unique network ID.

            ```sh
            ibmcloud sl subnet list | grep -e <networkID1> -e <networkID2>
            ```
            {: pre}

            Example output
          
            ```sh
            ID        identifier       type                 network_space   datacenter   vlan_id   IPs   hardware   virtual_servers
            1234567   169.xx.210.xxx   ADDITIONAL_PRIMARY   PUBLIC          dal12        1122334   16    0          5   
            7654321   169.xx.178.xxx   ADDITIONAL_PRIMARY   PUBLIC          dal10        4332211   16    0          6    
            ```
            {: screen}

        4. Retrieve the subnet address. In the output, find the number of **IPs**. Then, raise `2` to the power of `n` equal to the number of IPs. For example, if the number of IPs is `16`, then `2` is raised to the power of `4` (`n`) to equal `16`. Now get the subnet CIDR by subtracting the value of `n` from `32` bits. For example, when `n` equals `4`, then the CIDR is `28` (from the equation `32 - 4 = 28`). Combine the **identifier** mask with the CIDR value to get the full subnet address. In the previous output, the subnet addresses are:

            *   `169.xx.210.xxx/28`
            *   `169.xx.178.xxx/28`
            
    - **Individual worker node IP addresses**: If you have a small number of worker nodes that run only one app and don't need to scale, or if you want to add only one worker node, list all the worker nodes in your cluster and note the **Public IP** addresses. If your worker nodes are connected to a private network only and you want to connect to {{site.data.keyword.cloud_notm}} services by using the private cloud service endpoint, note the **Private IP** addresses instead. Only these worker nodes are added. If you delete the worker nodes or add worker nodes to the cluster, you must update your allowlist accordingly.

        ```sh
        ibmcloud ks worker ls --cluster <cluster_name_or_ID>
        ```
        {: pre}

3. Add the subnet CIDR or IP addresses to your service's allowlist for outbound traffic or your on-premises allowlist for inbound traffic.
4. Repeat these steps for each cluster that you want to allow traffic to or from.

## Updating IAM allowlists for {{site.data.keyword.containershort}} network zones
{: #iam_firewall}

By default, all IP addresses can be used to log in to the {{site.data.keyword.cloud_notm}} console and perform actions to manage your cluster, such as creating, updating, deleting or viewing credentials. In the IBM Cloud Identity and Access Management (IAM) console, you can [create an allowlist by specifying which IP addresses have access](/docs/account?topic=account-ips), and all other IP addresses are restricted.
{: shortdesc} 

In your allowlist, you must also configure network zones in the {{site.data.keyword.containerlong_notm}} control plane for the region where your cluster is located so that {{site.data.keyword.containerlong_notm}} can create or access components such as Ingress ALBs 

Before you begin, the following steps require you to change the IAM allowlist for the user whose credentials are used for the cluster's region and resource group infrastructure permissions. If you are the credentials owner, you can change your own IAM allowlist settings. If you are not the credentials owner, but you are assigned the **Editor** or **Administrator** IBM Cloud IAM platform access role for the [User Management service](/docs/account?topic=account-account-services), you can update the networks for the credentials owner.

1. Identify what user credentials are used for the cluster's region and resource group infrastructure permissions.

    1. Check the API key for a region and resource group of the cluster.

        ```sh
        ibmcloud ks api-key info --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Example output
        ```sh
        Getting information about the API key owner for cluster <cluster_name>...
        OK
        Name                Email   
        <user_name>         <name@email.com>
        ```
        {: screen}

    2. Check if the infrastructure account for the region and resource group is manually set to use a different IBM Cloud infrastructure account.

        ```sh
        ibmcloud ks credential get --region <us-south>
        ```
        {: pre}

        **Example output if credentials are set to use a different account**. In this case, the user's infrastructure credentials are used for the region and resource group that you targeted, even if a different user's credentials are stored in the API key that you retrieved in the previous step.

        ```sh
        OK
        Infrastructure credentials for user name <1234567_name@email.com> set for resource group <resource_group_name>.
        ```
        {: screen}

        **Example output if credentials are not set to use a different account**. In this case, the API key owner that you retrieved in the previous step has the infrastructure credentials that are used for the region and resource group.

        ```sh
        FAILED
        No credentials set for resource group <resource_group_name>.: The user credentials could not be found. (E0051)
        ```
        {: screen}

3. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){: external}.

1. Create network zones that include the {{site.data.keyword.containershort}} IPs for either all regions or just the regions that you have clusters in.

    1. In the account that the cluster is in, from the menu bar, click **Manage** > **Context-based restrictions**.
    
    1. Click **Network zones** > **Create**.

    3. For the **Name**, enter a descriptive name for the network zone, such as `us-south-kubernetes-service-network-zone`.

    4. Do not enter any values for the **Allowed IP addresses**  and **Allowed VPCs** sections.

    5. In the **Reference a service** section, select **Kubernetes Service** and click **+**.

    6. For **Locations**, you can either leave the field empty so that all locations are used, which applies to clusters in other regions, or you can specify a single region.

    7. Click **Next** and review the selections.

    8. Click **Create**.

    9. Repeat for additional zones.

1. Add the network zone names to your IAM allowlist.

    1. From the menu bar, click **Manage** > **Access (IAM)**, and select **Settings**.

    2. Under **Restrict IP address access**, select **Enable** and provide the network zone name from the previous step.

    3. Click **Apply**.


### Getting your {{site.data.keyword.containershort}} subnet IP addresses
{: #iam_cidr_ip}

Follow the steps to obtain the correct subnet IP addresses to add to your IAM allowlist.
{: shortdesc}

#### Getting your subnet IP addresses in the console
{: #iam_cidr_ip_console}

1. From the {{site.data.keyword.cloud_notm}} console [resource list](https://cloud.ibm.com/resources), click your cluster.
2. Click **Worker nodes**.
3. Note each **Public VLAN** used by the worker nodes in your cluster. Multiple worker nodes might use the same public VLAN. 
4. From the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/) menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon"), click **Infrastructure** > **Classic Infrastructure** > **IP Management** > **VLANs**.
5. Click each public VLAN to check if it is used by the worker nodes in your cluster. 
6. For each public VLAN that is used by the worker nodes in your cluster, find the **Subnets** section and note each IP address included in the table. These are the IP addresses that you must include in your allowlist. 

#### Getting your subnet IP addresses in the CLI
{: #iam_cidr_ip_cli}

1. List the public VLANs your worker nodes use. The output is formatted as `publicVLAN=<vlan_id>`. 

    ```sh
    kubectl describe nodes | grep publicVLAN | sort | uniq
    ```
    {: pre}

2. For each public VLAN, find the associated public subnets. In the output, note the subnet IP addresses in the **identifier** column.

    ```sh
    ibmcloud sl subnet list | grep <vlan-id>
    ```
    {: pre}

    Example output of subnets associated with public VLAN with ID `2761690`.

    ```sh
    ID        identifier        type                 network_space   datacenter   vlan_id   IPs   hardware   virtual_servers  
    1962263   169.62.46.56      SECONDARY_ON_VLAN    PUBLIC          wdc07        2761690   8     0          0   
    2008207   169.62.39.248     SECONDARY_ON_VLAN    PUBLIC          wdc07        2761690   8     0          0   
    2342562   169.62.2.128      ADDITIONAL_PRIMARY   PUBLIC          wdc07        2761690   16    0          5 
    ```
    {: screen}
        
3. List your worker nodes and get their public IPs. In the output, the public IPs are listed in the **External-IP** column. Note which of these IP addresses are contained in the subnets you listed earlier, and note those subnet IDs. 

4. For each subnet ID, run the command to get the subnet details. In each output, note the IP address in the **identifier** column. This is the IP address you must add to the IAM allowlist. 

    ```sh
    ibmcloud sl subnet detail <subnet_id>
    ```
    {: pre}

    Example output

    ```sh
    Name             Value   
    ID               2342562   
    identifier       169.62.2.128/28   
    subnet type      ADDITIONAL_PRIMARY   
    network space    PUBLIC   
    gateway          169.62.2.129   
    broadcast        169.62.2.143   
    datacenter       wdc07   
    usable ips       13   
    IP address       ID          IP address      
                    186531376   169.62.2.128      
                    186531378   169.62.2.129      
                    186531380   169.62.2.130      
                    186531382   169.62.2.131      
                    186531384   169.62.2.132      
                    186531386   169.62.2.133      
                    186531388   169.62.2.134      
                    186531390   169.62.2.135      
                    186531392   169.62.2.136      
                    186531394   169.62.2.137      
                    186531396   169.62.2.138      
                    186531398   169.62.2.139      
                    186531400   169.62.2.140      
                    186531402   169.62.2.141      
                    186531404   169.62.2.142      
                    186531406   169.62.2.143      
                        
    virtual guests   hostname                                                 domain    public_ip      private_ip      
                    kube-c8ofi5pw077drsbovf90-roks47class-default-00000187   iks.ibm   169.62.2.130   10.191.55.109      
                    kube-c8ofi5pw077drsbovf90-roks47class-default-000002a2   iks.ibm   169.62.2.133   10.191.55.108      
                    kube-c8ofi5pw077drsbovf90-roks47class-default-00000372   iks.ibm   169.62.2.135   10.191.55.121      
                    kube-c8ofh6kw0jj8l6jovf8g-iks22classi-default-00000219   iks.ibm   169.62.2.132   10.191.55.105      
                    kube-c8ofh6kw0jj8l6jovf8g-iks22classi-default-0000012f   iks.ibm   169.62.2.134   10.191.55.107     
    ```
    {: screen}
