---

copyright: 
  years: 2014, 2025
lastupdated: "2025-10-27"


keywords: kubernetes, help, network, connectivity

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}





# Why can't I install a new strongSwan Helm chart release?
{: #cs_strongswan_release}
{: support}

[Classic infrastructure]{: tag-classic-inf}

The strongSwan IPSec VPN addon is deprecated, and will be unsupported on December 20, 2025.  See [Classic VPN connectivity](/docs/containers?topic=containers-vpn#vpn) for other options
{: note}

You modify your strongSwan Helm chart and try to install your new release by running `helm install vpn iks-charts/strongswan -f config.yaml`. However, you see the following error:
{: tsSymptoms}

```sh
Error: release vpn failed: deployments.extensions "vpn-strongswan" already exists
```
{: screen}


This error indicates that the previous release of the strongSwan chart was not completely uninstalled.
{: tsCauses}

Delete and re-install the Helm chart.
{: tsResolve}

1. Delete the previous chart release.
    ```sh
    helm uninstall vpn -n <namespace>
    ```
    {: pre}

2. Delete the deployment for the previous release. Deletion of the deployment and associated pod takes up to 1 minute.
    ```sh
    kubectl delete deploy vpn-strongswan
    ```
    {: pre}

3. Verify that the deployment has been deleted. The deployment `vpn-strongswan` does not appear in the list.
    ```sh
    kubectl get deployments
    ```
    {: pre}

4. Re-install the updated strongSwan Helm chart with a new release name.
    ```sh
    helm install vpn iks-charts/strongswan -f config.yaml
    ```
    {: pre}
