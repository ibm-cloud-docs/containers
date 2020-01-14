---

copyright:
  years: 2014, 2020
lastupdated: "2020-01-14"

keywords: kubernetes, iks

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# Setting up continuous integration and delivery
{: #cicd}

With {{site.data.keyword.cloud_notm}} and other open source tools, you can set up continuous integration and delivery (CI/CD), version control, tool chains, and more to help automate app development and deployment.
{: shortdesc}

Continuous integration (CI) can help you detect errors early, ensure early system integration, and improve collaboration in your development process. Continuous delivery (CD) is a practice by which you build and deploy your software so that it can be released into production at any time. By automating your continuous integration and delivery processes through setting up CI/CD pipelines, you can achieve repeatability in code releases and greater predictability in delivery schedules.

For a deep dive into the benefits and specifics of automating continuous integration and delivery, check out [Automate continuous integration](https://www.ibm.com/garage/method/practices/code/practice_continuous_integration) and [Build and deploy by using continuous delivery](https://www.ibm.com/garage/method/practices/deliver/practice_continuous_delivery) in the IBM Garage Methodology documentation.

## Supported automation tools
{: #cicd_strategy}

To automate your CI/CD pipeline, check out the following supported integrations and tools.
{: shortdesc}

<dl>
<dt>Codeship</dt>
<dd>You can use [Codeship](https://codeship.com){: external} for the continuous integration and delivery of containers. For more information, see [Using Codeship Pro To Deploy Workloads to {{site.data.keyword.containerlong_notm}}](https://www.ibm.com/cloud/blog/using-codeship-pro-deploy-workloads-ibm-container-service){:external}.</dd>
<dt>Grafeas</dt>
<dd>[Grafeas](https://grafeas.io){: external} is an open source CI/CD service that provides a common way for how to retrieve, store, and exchange metadata during the software supply chain process. For example, if you integrate Grafeas into your app build process, Grafeas can store information about the initiator of the build request, vulnerability scan results, and quality assurance sign-off so that you can make an informed decision if an app can be deployed to production. You can use this metadata in audits or to prove compliance for your software supply chain.</dd>
<dt>{{site.data.keyword.deliverypipelinelong}}</dt>
<dd>With your app configuration files organized in a source control management system such as Git, you can build your pipeline to test and deploy code to different environments, such as `test` and `prod`. {{contdelivery_full}} alows you to automate your app builds and container deployments to Kubernetes clusters by using a toolchain. To get started, see [Setting up a continuous delivery pipeline for a cluster](#continuous-delivery-pipeline). You can also check out [this tutorial on Continuous Deployment to Kubernetes](/docs/tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes).</dd>
<dt>Helm</dt>
<dd>[Helm](https://helm.sh){:external} is a Kubernetes package manager. You can create new Helm charts or use preexisting Helm charts to define, install, and upgrade complex Kubernetes applications that run in {{site.data.keyword.containerlong_notm}} clusters. For example, you can specify all Kubernetes resources that your app requires in a Helm chart. Then, you can use Helm to create the YAML configuration files and deploy these files in your cluster. You can also [integrate {{site.data.keyword.cloud_notm}}-provided Helm charts](https://cloud.ibm.com/kubernetes/helm){: external} to extend your cluster's capabilities, such as with a block storage plug-in.<p>For more information, see [Setting up Helm in {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-helm).</p></dd>
<dt>Razee</dt>
<dd>[Razee](https://razee.io/){: external} is an open-source project that automates and manages the deployment of Kubernetes resources across clusters, environments, and cloud providers, and helps you to visualize deployment information for your resources so that you can monitor the rollout process and find deployment issues more quickly. For more information about Razee and how to set up Razee in your cluster to automate your deployment process, see the [Razee documentation](https://github.com/razee-io/Razee){: external}.</dd>
</dl>

<br />


{[cont-delivery.md]}
