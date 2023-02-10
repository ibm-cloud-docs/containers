---

copyright: 
  years: 2023, 2023
lastupdated: "2023-02-10"

keywords: containers, subnet, detach

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# I deleted a portable subnet and now my Classic cluster my Load Balancers are failing. How do I recover?
{: #ts-network-subnet-recover}
{: support}

[Classic]{: tag-classic}

You cluster is experiencing network errors.
{: tsSymptoms}

A portable subnet was deleted.
{: tsCauses}

Complete the following steps.
{: tsResolve}


1. For the cluster that is experiencing issues, run the following command and make a note of the cluster ID.
    ```sh
    ibmcloud ks cluster ls
    ```
    {: pre}


1. List the subnets your cluster is using. In the output, make a note of the subnets that your cluster is using.
    ```sh
    ibmcloud ks subnets --provider classic | grep CLUSTER-ID
    ```
    {: pre}


1. List the subnets in your account. Check whether any subnets that you found in step 1 are missing from the list of subnets in your account. This means your cluster is using a subnet that was deleted, which is causing your Load Balancer to fail.
    
    ```sh
    ibmcloud sl subnet list
    ```
    {: pre}
    
    ```sh
    ibmcloud sl subnet detail SUBNET-ID
    ```
    {: pre}


1. For each subnet that was deleted, re-create it. If you need public IP addresses for your ALBs or LoadBalancers, specify the public VLAN ID of your worker nodes; for private IPs specify the private VLAN ID of your worker nodes.
    ```sh
    ibmcloud ks cluster subnet create -c CLUSTER --size 8 --vlan VLAN-ID
    ```
    {: pre}



1. Disable any ALBs that use the deleted portable subnets.
    1. List your ALBs and note the IDs of ALBS that you want to remove.
        ```sh
        ibmcloud ks ingress alb ls -c CLUSTER-ID
        ```
        {: pre}
    
    1. Disable the ALBs to delete the Load Balancer for the ALB, which releases the portable IP address in the portable subnet you want to detach
        ```sh
        ibmcloud ks ingress alb disable -c CLUSTER-ID --alb ALB-ID
        ```
        {: pre}

1. Complete the following steps to find any Load Balancers that use IP addresses from the deleted portable subnet(s), save their settings, and then delete them.

    1. Find the IP addresses your LoadBalancers use.
        ```sh
        kubectl get svc -A -o wide | grep LoadBalancer
        ```
        {: pre}
      
    1. For each Load Balancer that you identified earlier, run the following command to export it a YAML file.
        ```sh
        kubectl get svc -o yaml -n LB-NAMESPACE LB-NAME > LB-NAMESPACE.LB-NAME.yaml
        ```
        {: pre}
        
    1. After you saved the information to a YAML file, delete those LoadBalancers.
        ```sh
        kubectl delete svc -n LB-NAMESPACE LB-NAME
        ```
        {: pre}

1. Detach the deleted portable subnets from your cluster with the following command.
    ```sh
    ibmcloud ks cluster subnet detach -c CLUSTER --subnet-id SUBNET-ID
    ```
    {: pre}

1. Wait a few minutes for the detach command to finish, then check that they have been detached by reviewing the `ibm-cloud-provider-vlan-ip-config` ConfigMap that stores the subnets and IP addresses.
    ```sh
    kubectl get cm -n kube-system ibm-cloud-provider-vlan-ip-config -o yaml
    ```
    {: pre}

    It might take 5-10 minutes for the detach to complete. While you wait, you can ensure that the new portable subnets you created for this cluster also appear in the ConfigMap.
    {: note}

1. Create ALBs by using the following command. Note that you can't re-enable the old ALBs because they still use the deleted portable subnet.
    ```sh
    ibmcloud ks ingress alb create classic --cluster CLUSTER-ID --type public|private --zone ZONE --vlan VLAN-ID
    ```
    {: pre}  

1. Re-create the LoadBalancers that you deleted by using the YAML file that you saved earlier.
    ```sh
    kubectl apply -f LB-NAMESPACE.LB-NAME.yaml
    ```
    {: pre}


