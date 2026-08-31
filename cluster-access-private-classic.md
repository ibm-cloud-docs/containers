---

copyright:
  years: 2014, 2026
lastupdated: "2026-08-31"

keywords: kubernetes, clusters, access, private, endpoint, classic, vpn, nlb

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Accessing Classic clusters through the private cloud service endpoint
{: #access-private-classic}

For {{site.data.keyword.containerlong_notm}} Classic clusters that have only the private cloud service endpoint enabled, you must expose the master endpoint through a private NLB and be connected to the IBM Cloud classic private network through a VPN connection to access the cluster.
{: shortdesc}

## Before you begin
{: #access-private-classic-prereqs}

1. [Install the required CLI tools](/docs/containers?topic=containers-cli-install).
1. Set up a [{{site.data.keyword.vpn_full}}](/docs/iaas-vpn?topic=iaas-vpn-getting-started) connection to the IBM Cloud classic private network.
1. Verify your cluster is healthy: `ibmcloud ks cluster get -c CLUSTER_NAME_OR_ID`.

## Exposing the master endpoint through a private NLB
{: #access-private-classic-nlb}

Before you can connect to the cluster master over the private network, you must expose the private cloud service endpoint through a private NLB.

1. Get the private cloud service endpoint URL and port for your cluster.
    ```sh
    ibmcloud ks cluster get -c CLUSTER_NAME_OR_ID
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

1. Create a YAML file named `kube-api-via-nlb.yaml`. This YAML creates a private `LoadBalancer` service and exposes the private cloud service endpoint through that NLB. Replace `<private_service_endpoint_port>` with the port you found in the previous step.

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

1. To create the private NLB, you must be connected to the cluster master. Because you can't yet connect through the private cloud service endpoint from a VPN or {{site.data.keyword.dl_full_notm}}, you must connect to the cluster master and create the NLB by using the public cloud service endpoint or a dashboard.
    * If you enabled the private cloud service endpoint only, you can use the [Headlamp dashboard](/docs/containers?topic=containers-headlamp-addon) to create the NLB. Headlamp routes all requests to the private cloud service endpoint of the master.
        1. On the **Clusters** [page](https://cloud.ibm.com/containers/cluster-management/clusters){: external}, click the cluster that you want to access.
        1. Get your ingress subdomain: `ibmcloud ks cluster get -c CLUSTER_NAME_OR_ID | grep "Ingress Subdomain"`.
        1. Open `https://headlamp.<ingress_subdomain>` in a browser, sign in, and navigate to **+** > **Upload YAML**.
        1. Upload the `kube-api-via-nlb.yaml` file and click **Apply**.
        1. Navigate to **Network > Services**, verify that the `kube-api-via-nlb` service is created, and note the `10.x.x.x` **External IP** address. This IP address exposes the private cloud service endpoint for the Kubernetes master on the port that you specified in your YAML file.

    * If you also enabled the public cloud service endpoint, you already have access to the master.
        1. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
            ```sh
            ibmcloud ks cluster config -c CLUSTER_NAME_OR_ID
            ```
            {: pre}

        1. Create the NLB and endpoint.
            ```sh
            kubectl apply -f kube-api-via-nlb.yaml
            ```
            {: pre}

        1. Verify that the `kube-api-via-nlb` NLB is created. In the output, note the `10.x.x.x` **EXTERNAL-IP** address. This IP address exposes the private cloud service endpoint for the Kubernetes master on the port that you specified in your YAML file.
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

1. On the client machines where you or your users run `kubectl` commands, add the NLB IP address and the private cloud service endpoint URL to the `/etc/hosts` file. Do not include any ports in the IP address and URL and don't include `https://` in the URL.
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

1. Verify that you are connected to the private network through a [VPN](/docs/iaas-vpn?topic=iaas-vpn-getting-started) or [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl) connection.

1. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
    ```sh
    ibmcloud ks cluster config -c CLUSTER_NAME_OR_ID --endpoint private
    ```
    {: pre}

1. Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
    ```sh
    kubectl config current-context
    ```
    {: pre}

    Example output
    ```sh
    <cluster_name>/<cluster_ID>
    ```
    {: screen}
