---

copyright:
  years: 2014, 2018
lastupdated: "2018-05-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Accessing the IBM Cloud Infrastructure (SoftLayer) portfolio
{: #infrastructure}

To create a standard Kubernetes cluster, you must have access to the IBM Cloud infrastructure (SoftLayer) portfolio. This access is needed to request paid infrastructure resources, such as worker nodes, portable public IP addresses, or persistent storage for your Kubernetes cluster in {{site.data.keyword.containerlong}}.
{:shortdesc}


## Access the IBM Cloud infrastructure (SoftLayer) portfolio
{: #unify_accounts}

{{site.data.keyword.Bluemix_notm}} Pay-As-You-Go accounts that were created after automatic account linking was enabled are already set up with access to the IBM Cloud infrastructure (SoftLayer) portfolio. You can purchase infrastructure resources for your cluster without additional configuration.
{:shortdesc}

Users with other {{site.data.keyword.Bluemix_notm}} account types or users that have an existing IBM Cloud infrastructure (SoftLayer) account that is not linked to their {{site.data.keyword.Bluemix_notm}} account, must configure their accounts to create standard clusters.
{:shortdesc}

Review the table to find available options for each account type.

|Account type|Description|Available options to create a standard cluster|
|------------|-----------|----------------------------------------------|
|Lite accounts|Lite accounts cannot provision clusters.|[Upgrade your Lite account to an {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account](/docs/account/index.html#billableacts) that is set up with access to the IBM Cloud infrastructure (SoftLayer) portfolio.|
|Older Pay-As-You-Go accounts|Pay-As-You-Go accounts that were created before automatic account linking was available, did not come with access to the IBM Cloud infrastructure (SoftLayer) portfolio.<p>If you have an existing IBM Cloud infrastructure (SoftLayer) account, you cannot link this account to an older Pay-As-You-Go account.</p>|Option 1: [Create a new Pay-As-You-Go account](/docs/account/index.html#billableacts) that is set up with access to the IBM Cloud infrastructure (SoftLayer) portfolio. When you choose this option, you have two separate {{site.data.keyword.Bluemix_notm}} accounts and billings.<p>To continue using your old Pay-As-You-Go account to create standard clusters, you can use your new Pay-As-You-Go account to generate an API key to access the IBM Cloud infrastructure (SoftLayer) portfolio. Then, you must set the API key for your old Pay-As-You-Go account. For more information, see [Generating an API key for old Pay-As-You-Go and Subscription accounts](#old_account). Keep in mind that IBM Cloud infrastructure (SoftLayer) resources are billed through your new Pay-As-You-Go account.</p></br><p>Option 2: If you already have an existing IBM Cloud infrastructure (SoftLayer) account that you want to use, you can [set your credentials](cs_cli_reference.html#cs_credentials_set) for your {{site.data.keyword.Bluemix_notm}} account.</p><p>**Note:** The IBM Cloud infrastructure (SoftLayer) account that you use with your {{site.data.keyword.Bluemix_notm}} account must be set up with Super User permissions.</p>|
|Subscription accounts|Subscription accounts are not set up with access to the IBM Cloud infrastructure (SoftLayer) portfolio.|Option 1: [Create a new Pay-As-You-Go account](/docs/account/index.html#billableacts) that is set up with access to the IBM Cloud infrastructure (SoftLayer) portfolio. When you choose this option, you have two separate {{site.data.keyword.Bluemix_notm}} accounts and billings.<p>If you want to continue using your Subscription account to create standard clusters, you can use your new Pay-As-You-Go account to generate an API key to access the IBM Cloud infrastructure (SoftLayer) portfolio. Then, you must set the API key for your Subscription account. For more information, see [Generating an API key for old Pay-As-You-Go and Subscription accounts](#old_account). Keep in mind that IBM Cloud infrastructure (SoftLayer) resources are billed through your new Pay-As-You-Go account.</p></br><p>Option 2: If you already have an existing IBM Cloud infrastructure (SoftLayer) account that you want to use, you can [set your credentials](cs_cli_reference.html#cs_credentials_set) for your {{site.data.keyword.Bluemix_notm}} account.<p>**Note:** The IBM Cloud infrastructure (SoftLayer) account that you use with your {{site.data.keyword.Bluemix_notm}} account must be set up with Super User permissions.</p>|
|IBM Cloud infrastructure (SoftLayer) accounts, no {{site.data.keyword.Bluemix_notm}} account|To create a standard cluster, you must have an {{site.data.keyword.Bluemix_notm}} account.|<p>[Create a Pay-As-You-Go account](/docs/account/index.html#billableacts) that is set up with access to the IBM Cloud infrastructure (SoftLayer) portfolio. When you choose this option, an IBM Cloud infrastructure (SoftLayer) account is created for you. You have two separate IBM Cloud infrastructure (SoftLayer) accounts and billing.</p>|

<br />


