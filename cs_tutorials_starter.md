---

copyright:
  years: 2014, 2019
lastupdated: "2019-10-17"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:preview: .preview}

# Deploy a starter kit app to a Kubernetes cluster
{: #tutorial-starterkit-kube}

Create an app in {{site.data.keyword.cloud}} by using a blank starter kit, and set up a continuous integration/ continuous delivery DevOps pipeline to automate the deployment of the app to your Kubernetes cluster.
{: shortdesc}

{{site.data.keyword.cloud_notm}} offers starter kits that help you build the foundation of an app that runs on Kubernetes. When you use a starter kit, it's easy to follow a cloud native programming model that uses {{site.data.keyword.cloud_notm}} best practices for app development. Starter kits generate apps that follow the cloud native programming model, and they include test cases, health check, and metrics in each programming language. You can also provision {{site.data.keyword.cloud_notm}} services to add extra capabilities to your app.

## Objectives
{: #objectives-starterkit-kube}

- Create a Java + Spring app by using an {{site.data.keyword.cloud_notm}} starter kit.
- Add an {{site.data.keyword.cloudant_short_notm}} service instance to your app.
- Set up a continuous integration and continuous delivery pipeline for your app and connect the pipeline to a Kubernetes cluster in {{site.data.keyword.containerlong_notm}}.
- Explore the DevOps tools, such as GitLab or the DevOps delivery pipeline.
- View deployment information and verify that your app is up and running.

![Starter kit flow diagram](images/starterkit-app.png)

## Time required
{: #time-starterkit-kube}

45 minutes

## Audience
{: #audience-starterkit-kube}

This tutorial is intended for software developers who want to learn how to create a Java app from an {{site.data.keyword.cloud_notm}} starter kit and to deploy the app to a Kubernetes cluster by using a continuous delivery pipeline.

## Prerequisites
{: #prereqs-starterkit-kube}

* Create a **Java + Spring** app by using a [starter kit](/docs/apps/tutorials?topic=creating-apps-tutorial-starterkit).
* Install the [{{site.data.keyword.cloud_notm}} CLI](/docs/cli?topic=cloud-cli-getting-started#idt-prereq).
* Create a [classic](/docs/containers?topic=containers-clusters#clusters_standard) or [VPC](/docs/containers?topic=containers-clusters#clusters_vpc_standard) cluster.

## Lesson 1: Add services to your app
{: #resources-starterkit-kube}

Provision an {{site.data.keyword.cloudant_short_notm}} service instance, create service credentials, and bind the service to your starter kit app.
{: shortdesc}

1. Open your starter kit app and select the **App details** tab.
2. Click **Create service**.
2. Select **Databases** and click **Next**.
3. Select **Cloudant** and click **Next**.
4. On the **Add Cloudant** page, select the {{site.data.keyword.cloud_notm}} region and resource group that your cluster is in. Then, select a pricing plan. For example, use **Lite** to create a free {{site.data.keyword.cloudant_short_notm}} database instance.
5. Click **Create**. The **App details** page is displayed, and the Cloudant instance is provisioned and bound to your app. After the database is set up, you can see the credentials to access your database in the **Credentials** field on the **App details** page. This field might take a few minutes to display.

## Lesson 2: Deploy your app by using a DevOps toolchain
{: #deploy-starterkit-kube}

Attach a DevOps toolchain to your starter kit app, and configure a delivery pipeline to automatically deploy your app to your cluster in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

1. On the **App details** page, click **Configure continuous delivery**.
2. On the **Select a deployment target** page, select **Deploy to IBM Kubernetes Service**.
3. Select the region and the name of the cluster, for which you want to set up a continuous delivery pipeline. If you don't have a cluster, click **Create cluster**. For more information about creating a cluster, see the instructions for creating a [classic cluster](/docs/containers?topic=containers-clusters#clusters_standard) or [VPC cluster](/docs/containers?topic=containers-clusters#clusters_vpc_standard).
4. Click **Next**. The **Configure toolchain** page is displayed.
5. On the **Configure toolchain** page, enter a toolchain name, select the region and the resource group that your cluster is in, and then click **Create**. The **App details** page is displayed, along with deployment information about your toolchain.

## Lesson 3: Explore the toolchain tools, logs, and history
{: #view-logs-starterkit-kube}

With your toolchain set up, explore how you can use each tool to automate the deployment of your app.
{: shortdesc}

1. On the **App details** page, click **View toolchain**. The **Overview** tab of the toolchain page is displayed, which shows the tools that are included with the toolchain. This example includes the following tools that were preselected in the starter kit when the toolchain was created:
  * An issues tracker in GitLab to track project updates and changes.
  * A GitLab repo that contains the source code of your app.
  * An Eclipse Orion instance, which is a web-based IDE to edit your app.
  * A Delivery Pipeline that consists of a customizable **BUILD** and **DEPLOY** stage.
2. Configure your GitLab repo.
   1. From the toolchain overview page, select the **Git** card.
   2. From your project overview page, select **Repository** > **Files** to review your app code and dependencies.
   3. From your project overview page, select **Issues** to find or create your issues.
   4. Optional. Configure SSH on your desktop by following the on-screen instructions so that you can push and pull code changes by using the CLI.
   5. Optional. To allow apps to access the Git API, create a personal access token for your account.
      1. From your user profile, click **Settings**.
      2. Select **Access Tokens**.
      3. Follow the on-screen instructions to set up your personal access token.
3. Review your **Delivery Pipeline** stages.
   1. From the toolchain overview page, select **Delivery Pipeline**. The pipeline stages are displayed.
      - The **BUILD** stage clones your GitLab repository, builds your Docker image, and pushes the image to your namespace in {{site.data.keyword.registryshort_notm}}.
      - The **DEPLOY** stage retrieves the container image from {{site.data.keyword.registryshort_notm}} and deploys your app to your Kubernetes cluster.
   2. To find the details of what happened in each deployment stage, click **View logs and history**.

## Lesson 4: Verify the health of your app
{: #verify-starterkit-kube}

Access your app to verify that you app is up and running.
{: shortdesc}

1. From your DevOps toolchain, click **Delivery Pipeline**, and then find the **Deploy Stage**.
2. Click **View logs and history**.
3. At the end of your log file, find the public URL that is assigned to your app.

   Example log entry:
   ```
   View the application health at: http://<ipaddress>:<port>/health.
   ```
   {: screen}

4. In your preferred web browser, enter the URL. If your app is up and running, you see a `Congratulations` or `{"status":"UP"}` message in your web browser.


## Next steps
{: #next-steps-startkit-kube notoc}

* **Troubleshoot deployment errors**: If you encounter errors during the app deployment, check the troubleshooting topic for known issues like [exceeding storage quota](/docs/apps?topic=creating-apps-managingapps#exceed_quota), or learn how to [access Kubernetes logs](/docs/apps?topic=creating-apps-managingapps#access_kube_logs) to look for errors.

* **Access service credentials from your app**: You can use the _@Value_ annotation, or use the Spring framework environment class _getProperty()_ method. For more information, see [Accessing credentials](/docs/java?topic=java-spring-configuration#spring-access-credentials).

* **Add more capabilities to your app**: When you add another service to your app after the DevOps toolchain is created, those service credentials aren't automatically updated to your deployed app and GitLab repository. You must [manually add the credentials to the deployment environment](/docs/apps?topic=creating-apps-credentials_overview).
