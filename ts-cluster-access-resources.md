---

copyright:
  years: 2014, 2024
lastupdated: "2024-01-03"


keywords: kubernetes

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Classic: Why can't I access resources in my cluster?
{: #cs_firewall}
{: support}

[Classic infrastructure]{: tag-classic-inf}



When the worker nodes in your cluster can't communicate on the private network, you might see various different symptoms.
{: tsSymptoms}

- Sample error message when you run `kubectl exec`, `attach`, `logs`, `proxy`, or `port-forward`:
    ```txt
    Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
    ```
    {: screen}

- Sample error message when `kubectl proxy` succeeds, but the Kubernetes dashboard is not available:
    ```txt
    timeout on 172.xxx.xxx.xxx
    ```
    {: screen}

- Sample error message when `kubectl proxy` fails or the connection to your service fails:
    ```txt
    Connection refused
    ```
    {: screen}

    ```txt
    Connection timed out
    ```
    {: screen}

    ```txt
    Unable to connect to the server: net/http: TLS handshake timeout
    ```
    {: screen}



To access resources in the cluster, your worker nodes must be able to communicate on the private network. You might have a Vyatta or another firewall set up, or customized your existing firewall settings in your IBM Cloud infrastructure account.
{: tsCauses}

{{site.data.keyword.containerlong_notm}} requires certain IP addresses and ports to be opened to allow communication from the worker node to the Kubernetes master and vice versa. If your worker nodes are spread across multiple zones, you must allow private network communication by enabling VLAN spanning. Communication between worker nodes might also not be possible if your worker nodes are stuck in a reloading loop.


Review the worker node state.
{: tsResolve}

1. List the worker nodes in your cluster and verify that your worker nodes are not stuck in a `Reloading` state.
    ```sh
    ibmcloud ks worker ls --cluster <cluster_name_or_id>
    ```
    {: pre}

2. If you have a multizone cluster and your account is not enabled for VRF, verify that you [enabled VLAN spanning](/docs/containers?topic=containers-subnets#subnet-routing) for your account.
3. If you have a Vyatta or custom firewall settings, make sure that you [opened up the required ports](/docs/containers?topic=containers-firewall#firewall_outbound) to allow the cluster to access infrastructure resources and services.






