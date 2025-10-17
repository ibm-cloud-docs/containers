---

copyright: 
  years: 2014, 2025
lastupdated: "2025-10-17"


keywords: containers, {{site.data.keyword.containerlong_notm}}, continuous integration and delivery

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Continuous integration and delivery for app development and deployment
{: #cicd}

With {{site.data.keyword.cloud_notm}} and other open source tools, you can set up continuous integration and delivery (CI/CD), version control, tool chains, and more to help automate app development and deployment.
{: shortdesc}

Continuous integration (CI) can help you detect errors early, ensure early system integration, and improve collaboration in your development process. Continuous delivery (CD) is a practice by which you build and deploy your software so that it can be released into production at any time. By automating your continuous integration and delivery processes through setting up CI/CD pipelines, you can achieve repeatability in code releases and greater predictability in delivery schedules.

Adopt a DevOps approach by using {{site.data.keyword.deliverypipelinelong}}, which includes open toolchains that automate the building and deployment of containerized apps.  

## Before you begin
{: #cicd_before}

Before you begin, make sure that you have at least the following permissions in {{site.data.keyword.cloud_notm}} IAM.

- **Editor** platform access role and **Writer** service access role to the **Kubernetes Service** cluster. For more information, see [User access permissions](/docs/containers?topic=containers-iam-platform-access-roles).
- **Viewer** platform access role to the resource group of the cluster where you want to create the toolchain.
- **Editor** platform access role to the **Toolchain** service (note that this service is separate than **Continuous Delivery**).

## Creating a toolchain with Delivery Pipeline
{: #cicd_toolchain}

Follow these steps to create a CI/CD pipeline with a toolchain. A toolchain is a set of tool integrations that support development, deployment, and operations tasks. When configuring the toolchain you can include and configure a Delivery Pipeline that is automatically created and triggered after the toolchain is created.

1. From the [console](https://cloud.ibm.com/containers/cluster-management/clusters){: external}, select the cluster for which you want to set up a continuous delivery pipeline.
2. Select the **DevOps** tab.
3. Click **Create a toolchain**.
4. Review the available toolchains. IBM provides pre-defined toolchains that you can use to deploy, test, and monitor Kubernetes-native apps or Helm charts. You can expand each toolchain to find an overview of the tools that are set up for you and to find the scripts in GitHub that are used to configure the toolchain in your cluster. If you know what tools you want to use, you can create your own toolchain.
5. Select the toolchain that you want to use and click **Create**.
6. Follow the directions in the console to configure your toolchain. Make sure to include the name of your cluster in your toolchain name so that you can easily find the toolchain that is associated with your cluster later. For more information, see [Creating toolchains](/docs/ContinuousDelivery?topic=ContinuousDelivery-toolchains_getting_started).
7. Select **Delivery Pipeline** to review the stages of your continuous integration and continuous delivery pipeline. After you create your toolchain, your pipeline is automatically kicked off and runs through the stages that you configured. Make sure that your stages run successfully and correct any errors.
8. Modify your toolchain. You can add more tools to your toolchain or change the stages of your delivery pipeline.
    1. From the [console](https://cloud.ibm.com/containers/cluster-management/clusters){: external}, select the cluster for which you want to set up a continuous delivery pipeline.
    2. Select the **DevOps** tab.
    3. Select the toolchain that you want to modify.


## Other resources for automating your pipeline
{: #cicd-other}

Check out the following integrations and tools that you can use to automate your CI/CD pipeline. 

CloudBees Unify
:   You can use [CloudBees Unify](https://www.cloudbees.com/capabilities/ci-cd-workflows){: external} for the continuous integration and delivery of containers.

Grafeas
:   [Grafeas](https://grafeas.io){: external} is an open source CI/CD service that provides a common way for how to retrieve, store, and exchange metadata during the software supply chain process. For example, if you integrate Grafeas into your app build process, Grafeas can store information about the initiator of the build request, vulnerability scan results, and quality assurance sign-off so that you can make an informed decision if an app can be deployed to production. You can use this metadata in audits or to prove compliance for your software supply chain.

{{site.data.keyword.deliverypipelinelong}}
:   With your app configuration files organized in a source control management system such as Git, you can build your pipeline to test and deploy code to different environments, such as `test` and `prod`. {{site.data.keyword.contdelivery_full}} allows you to automate your app builds and container deployments to Kubernetes clusters by using a toolchain. You can also check out [this tutorial on Continuous Deployment to Kubernetes](/docs/ContinuousDelivery?topic=ContinuousDelivery-tutorial-cd-kubernetes).


Helm
:   [Helm](https://helm.sh){: external} is a Kubernetes package manager. You can create new Helm charts or use preexisting Helm charts to define, install, and upgrade complex Kubernetes applications that run in {{site.data.keyword.containerlong_notm}} clusters. For example, you can specify all Kubernetes resources that your app requires in a Helm chart. Then, you can use Helm to create the YAML configuration files and deploy these files in your cluster. You can also [integrate {{site.data.keyword.cloud_notm}}-provided Helm charts](https://cloud.ibm.com/kubernetes/helm){: external} to extend your cluster's capabilities, such as with a block storage plug-in. For more information, see [Setting up Helm in {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-helm).

Kustomize
:   Use the Kubernetes project [Kustomize](https://github.com/kubernetes-sigs/kustomize){: external} to package your apps by both standardizing and customizing your deployments across multiple environments. Kustomize helps you write, customize, and reuse your Kubernetes resource YAML configurations. To get started, see [Packaging apps for reuse in multiple environments with Kustomize](/docs/containers?topic=containers-kustomize).
