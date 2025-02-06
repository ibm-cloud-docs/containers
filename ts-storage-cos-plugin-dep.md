---

copyright: 
  years: 2025, 2025
lastupdated: "2025-02-06"


keywords: containers, cos, mount error, libfuse

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Why do I see a volume mounting error when using the {{site.data.keyword.cos_full_notm}} plug-in?
{: #ts-cos-storage-dep}

When deploying an app that uses the COS plug-in, you see an error message similar the following.
{: tsSymptoms}

```sh
Error mounting volume: s3fs mount failed: s3fs: error while loading shared libraries: libfuse.so.2: cannot open shared object file: No such file or directory
```
{: screen}

The plug-in version you are using is deprecated. Update your COS plug-in to a supported version.
{: tsCauses}

Follow the steps to update the COS plug-in.
{: tsResolve}

1. Check your plug-in version by running the following command.

    ```sh
    kubectl get deploy ibmcloud-object-storage-plugin -n ibm-object-s3fs -oyaml | grep productVersion
    ```
    {: pre}

1. Review the [change log](/docs/containers?topic=containers-cos_plugin_changelog) for the latest version information.

1. Update the COS plug-in. For more information, see [Updating the {{site.data.keyword.cos_full_notm}} plug-in](/docs/containers?topic=containers-storage_cos_install#update_cos_plugin).

1. If the issue persists, contact support. Open a [support case](/docs/account?topic=account-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.


The COS plug-in is now available as a managed add-on. If you are using the COS plug-in Helm chart, consider migrating to the add-on. For more information, see [Enabling the {{site.data.keyword.cos_full_notm}} add-on](/docs/containers?topic=containers-storage-cos-install-addon#enable-cos-addon) and [Migrating from the Helm plug-in to the cluster add-on](/docs/containers?topic=containers-storage-cos-install-addon#cos-addon-migrate-helm).
{: tip}
