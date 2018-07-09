---

copyright:
  years: 2014, 2018
lastupdated: "2018-07-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Understanding Kubernetes storage basics

## Choosing your pre-defined storage tier with storage classes

## Customizing a storage class

## Using persistent volume claims to add persistent storage

## Preparing existing storage for multizone usage

If you updated your cluster from a single-zone to a multizone cluster and had existing persistent volumes (PVs), add the Kubernetes zone and region labels to your PVs. The labels assure that pods that mount this storage are deployed to the zone where the persistent storage exists.
{:shortdesc}

**Note:** These steps are required only if you had existing PVs that were created before multizone capabilities were available. PVs that were created after multizone was available already include the Kubernetes region and the zone label. 

Use a script to find all the PVs in your cluster and apply the Kubernetes `failure-domain.beta.kubernetes.io/region` and `failure-domain.beta.kubernetes.io/zone` labels. If the PV already has the labels, the script does not overwrite the existing values.

Before you begin:
- [Target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure).
- Enable [VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) for your IBM Cloud infrastructure (SoftLayer) account so your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](cs_users.html#infra_access), or you can request the account owner to enable it. As an alternative to VLAN spanning, you can use a Virtual Router Function (VRF) if it is enabled in your IBM Cloud infrastructure (SoftLayer) account.

To update existing PVs:

1.  Apply the multizone labels to your PVs by running the script.  Replace <mycluster> with the name of your cluster. When prompted, confirm the update of your PVs.

    ```
    bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <mycluster>
    ```
    {: pre}

    **Example output**:

    ```
    Retrieving cluster storage...
    OK

    Name:			mycluster
    ID:			  myclusterID1234
    State:			normal
    ...
    Addons
    Name                   Enabled
    storage-watcher-pod    true
    basic-ingress-v2       true
    customer-storage-pod   true
    us-south
    kube-config-dal10-storage.yml
    storage.yml
    dal10\n
    The persistent volumes which do not have region and zone labels will be updated with REGION=
    us-south and ZONE=dal10. Are you sure to continue (y/n)?y
    persistentvolume "pvc-ID-123456" labeled
    persistentvolume "pvc-ID-789101" labeled
    ['failure-domain.beta.kubernetes.io/region' already has a value (us-south), and --overwrite is false, 'failure-domain.beta.kubernetes.io/zone' already has a value (dal10), and --overwrite is false]
    ['failure-domain.beta.kubernetes.io/region' already has a value (us-south), and --overwrite is false, 'failure-domain.beta.kubernetes.io/zone' already has a value (dal10), and --overwrite is false]
    \nSuccessfully applied labels to persistent volumes which did not have region and zone labels.
    ```
    {: screen}

2.  Verify that the labels were applied to your PVs.

    1.  Look in the output of the previous command for the IDs of PVs that were labeled.

        ```
        persistentvolume "pvc-ID-123456" labeled
        persistentvolume "pvc-ID-789101" labeled
        ```
        {: screen}

    2.  Review the region and zone labels for your PVs.

        ```
        kubectl describe pv pvc-ID-123456
        ```
        {: pre}

        **Example output**:
        ```
        Name:		pvc-ID-123456
        Labels:		CapacityGb=4
        		Datacenter=dal10
            ...
        		failure-domain.beta.kubernetes.io/region=us-south
        		failure-domain.beta.kubernetes.io/zone=dal10
            ...
        ```
        {: screen}
        
**What's next?**

Now that you labeled your existing PVs, you can mount the PV to your multizone cluster. See the following links for more information. 
- Use [existing NFS file storage](cs_storage_file.html#existing_file)
- Use [existing block storage](cs_storage_block.html#existing_block)




