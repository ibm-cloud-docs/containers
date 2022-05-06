---

copyright: 
  years: 2014, 2022
lastupdated: "2022-05-06"

keywords: kubernetes

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Debugging common CLI issues with clusters
{: #ts_clis}
{: troubleshoot}
{: support}

Review the following common reasons for CLI connection issues or command failures.
{: shortdesc}

**Infrastructure provider**:
* ![Classic](../icons/classic.svg "Classic") Classic
* ![VPC](../icons/vpc.svg "VPC") VPC

## Firewall prevents running CLI commands
{: #ts_firewall_clis}


When you run `ibmcloud`, `kubectl`, or `calicoctl` commands from the CLI, they fail.
{: tsSymptoms}


You might have corporate network policies that prevent access from your local system to public endpoints via proxies or firewalls.
{: tsCauses}


[Allow TCP access for the CLI commands to work](/docs/containers?topic=containers-firewall#firewall_bx).
{: tsResolve}

This task requires the [**Administrator** {{site.data.keyword.cloud_notm}} IAM platform access role](/docs/containers?topic=containers-users#checking-perms) for the cluster.



## `kubectl` commands don't work
{: #kubectl_fails}


When you run `kubectl` commands against your cluster, your commands fail with an error message similar to the following.
{: tsSymptoms}

```sh
No resources found.
Error from server (NotAcceptable): unknown (get nodes)
```
{: screen}

```sh
invalid object doesn't have additional properties
```
{: screen}

```sh
error: No Auth Provider found for name "oidc"
```
{: screen}


You have a different version of `kubectl` than your cluster version.
{: tsCauses}

[Kubernetes does not support](https://kubernetes.io/releases/version-skew-policy/){: external} `kubectl` client versions that are 2 or more versions apart from the server version (n +/- 2). If you use a community Kubernetes cluster, you might also have the {{site.data.keyword.redhat_openshift_notm}} version of `kubectl`, which does not work with community Kubernetes clusters.

To check your client `kubectl` version against the cluster server version, run `kubectl version --short`.


[Install the version of `kubectl`](/docs/containers?topic=containers-cs_cli_install#kubectl) that matches the Kubernetes version of your cluster.
{: tsResolve}

If you have multiple clusters at different Kubernetes versions or different container platforms such as {{site.data.keyword.redhat_openshift_notm}}, download each `kubectl` version binary file to a separate directory. Then, you can set up an alias in your local command-line interface (CLI) profile to point to the `kubectl` binary file directory that matches the `kubectl` version of the cluster that you want to work with, or you might be able to use a tool such as `brew switch kubernetes-cli <major.minor>`.





## `kubectl` commands time out
{: #exec_logs_fail}


If you run commands such as `kubectl exec`, `kubectl attach`, `kubectl proxy`, `kubectl port-forward`, or `kubectl logs`, you see the following message.
{: tsSymptoms}

    ```
    <workerIP>:10250: getsockopt: connection timed out
    ```
    {: screen}


Kubernetes version 1.20 or earlier: The OpenVPN connection between the master node and worker nodes is not functioning properly.
{: tsResolve}

1. In classic clusters, if you have multiple VLANs for your cluster, multiple subnets on the same VLAN, or a multizone classic cluster, you must enable a [Virtual Router Function (VRF)](/docs/account?topic=account-vrf-service-endpoint#vrf) for your IBM Cloud infrastructure account so your worker nodes can communicate with each other on the private network. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint#vrf). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-access-creds#infra_access), or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).
2. Restart the OpenVPN client pod.
    ```sh
    kubectl delete pod -n kube-system -l app=vpn
    ```
    {: pre}

3. If you still see the same error message, then the worker node that the VPN pod is on might be unhealthy. To restart the VPN pod and reschedule it to a different worker node, [cordon, drain, and reboot the worker node](/docs/openshift?topic=openshift-kubernetes-service-cli#cs_worker_reboot) that the VPN pod is on.




