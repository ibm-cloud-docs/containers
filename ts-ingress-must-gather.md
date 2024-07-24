---

copyright: 
  years: 2014, 2024
lastupdated: "2024-07-24"


keywords: containers, kubernetes, help, network, connectivity, ingress, must gather

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Gathering Ingress details for debugging
{: #ingress-must-gather}
{: support}

Run the following commands to gather the required logs and details for debugging Ingress.
{: shortdesc}

1. Get nodes and node labels.

    ```sh
    kubectl get nodes --show-labels
    ```
    {: pre}
    
1. Get endpoints.

    ```sh
    kubectl get endpoints -o wide
    ```
    {: pre}

1. Get the Ingress status.

    ```sh
    ibmcloud ks ingress status-report get -c CLUSTERID
    ```
    {: pre}
    



1. List ALBs.

    ```sh
    ibmcloud ks ingress alb ls -c CLUSTERID
    ```
    {: pre}

1. Describe your Ingress resource.

    ```sh
    kubectl describe ing <ingress name> -n <namespace>
    ```
    {: pre}
    
1. Get the logs for the `nginx-ingress` container in your Ingress pods.

    ```sh
    kubectl logs <ingress pods> -n kube-system -c nginx-ingress
    ```
    {: pre}
    
1.  List host names for network load balancer (NLB).

    ```sh
    ibmcloud ks nlb-dns ls -c CLUSTERID
    ```
    {: pre}

1. List the `alb` pods in the `kube-system` namespace.

    ```sh
    kubectl get pods -n kube-system | grep alb
    ```
    {: pre}



1. List your cluster subdomains.
    ```sh
    ibmcloud ks ingress domain ls -c CLUSTERID
    ```
    {: pre}
    
1. Run an `nslookup` on your Ingress subdomain.

    ```sh
    nslookup ingresssubdomain.com
    ```
    {: pre}
    

1. Save the information you've gathered and Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.




