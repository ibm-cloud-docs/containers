
# `Version information and update actions` page template
Use this template when creating a new version information page when a new version is relesed  


Link structure: https://cloud.ibm.com/docs/containers?topic=containers-cs_versions_1XX
File name: cs_versions_1XX.md

* Replace the `XX` with the new minor version. If you use find and replace, make sure to double check links and anchors because the version number format may vary (eg. 1.XX, 1_XX, 1XX, etc).
* Replace `DAY MONTH YEAR` with the GA release date.
* In the release timeline table, replace `MONTH YEAR` with the tentative EOS date. 
* Keep the certification logo in staging tags until certification is official. This may not be until several days after GA.
    * The logo is found in the [CNCF artwork GH repo](https://github.com/cncf/artwork/tree/master/projects/kubernetes/certified-kubernetes). If it's not there, you may need to ask for it to be updated in the [Kubernetes slack](kubernetes.slack.com). 
    * Add the logo to the documentation images folder. 
* Add the `Update before master` and `Update after master` tables. 

## IKS Template
---------------------------------------------------------------------------------------------------------------------------------------------------------

# 1.XX version information and update actions
{: #cs_versions_1XX}

Review information about version 1.XX of {{site.data.keyword.containerlong}}, released DAY MONTH YEAR.
{: shortdesc}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}



{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.XX under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._

For more information about Kubernetes project version 1.XX, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}

## Release timeline 
{: #release_timeline_1XX}

The following table includes the expected release timeline for version 1.XX of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

For the release history and timeline of all current {{site.data.keyword.containerlong}} versions, see [Release history](/docs/containers?topic=containers-cs_versions#release-history).

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

|  Version | Supported? | {{site.data.keyword.containerlong_notm}} \n release date | {{site.data.keyword.containerlong_notm}} \n unsupported date |
|------|------|----------|----------|
| 1.XX | Yes | DAY MONTH YEAR | MONTH YEAR `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.XX" caption-side="top"}

## Preparing to update
{: #prep-up-1XX}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.XX. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.XX.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_1XX) for version 1.XX. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}. 
{: shortdesc}

### Update before master
{: #before_1XX}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |

{: caption="Changes to make after you update the master to Kubernetes 1.XX" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}


### Update after master
{: #after_1XX}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |

{: caption="Changes to make after you update the master to Kubernetes 1.XX" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

---------------------------------------------------------------------------------------------------------------------------------------------------------