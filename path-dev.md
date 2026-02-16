---

copyright: 
  years: 2014, 2026
lastupdated: "2026-02-16"


keywords: kubernetes, containers

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}







# Learning path for developers
{: #learning-path-dev}

Following a curated learning path to deploy highly available containerized apps in Kubernetes clusters and use the powerful tools of {{site.data.keyword.containerlong_notm}} to automate, isolate, secure, manage, and monitor your app workloads across zones or regions.
{: shortdesc}


## Access the cluster
{: #dev_cluster}

Begin working with your cluster by setting up the CLI and accessing the cluster.
{: shortdesc}

1. **CLI setup**: [Set up the CLIs](/docs/containers?topic=containers-cli-install) that are necessary to create and work with clusters. As you work with your cluster, refer to the [command reference](/docs/containers?topic=containers-kubernetes-service-cli) and keep track of CLI version updates with the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).
2. **User permissions**: Ensure that your cluster administrator gives you the proper [{{site.data.keyword.cloud_notm}} IAM role](/docs/containers?topic=containers-learning-path-admin#admin_secure) to access the cluster.
3. **Cluster access**: [Access your cluster through the public or private cloud service endpoint](/docs/containers?topic=containers-access_cluster).

Need help? Check out [Troubleshooting clusters and masters](/docs/containers?topic=containers-debug_clusters) and [Troubleshooting worker nodes](/docs/containers?topic=containers-debug_worker_nodes).
{: tip}


## Plan your deployment
{: #dev_plan}

Before you deploy an app, decide how you want to set up your app so that your app can be accessed properly and be integrated with other services.
{: shortdesc}

1. **Kubernetes-native**: [Plan your strategy for developing a Kubernetes-native app](/docs/containers?topic=containers-plan_deploy).
2. **Highly available**: [Plan your strategy for a highly available deployment](/docs/containers?topic=containers-plan_deploy#highly_available_apps).

Looking for serverless? Try [{{site.data.keyword.codeengineshort}}](/docs/codeengine?topic=codeengine-getting-started).
{: tip}

## Develop your app
{: #dev_develop}

Configure your app in a YAML file that declares the configuration of the Kubernetes object, and plan your app versioning strategy.
{: shortdesc}

1. **Develop your app**:
    1. Review the [basics of Kubernetes-native app deployments](/docs/containers?topic=containers-plan_deploy#kube-objects).
    2. Build app containers from [images in public or private image registries](/docs/containers?topic=containers-images).
    3. Specify your [app requirements in a YAML file](/docs/containers?topic=containers-app#app_yaml), which declares the configuration of the Kubernetes object.
2. **Version your app**:
    1. Plan customized configurations for more than one environment, such as development, testing, and production environments to manage your configuration YAML file.
    2. If you want to run your app in multiple clusters, public and private environments, or even multiple cloud providers, [package your application to help automate deployments](/docs/containers?topic=containers-plan_deploy#packaging).

Need help? Check out [Troubleshooting apps and integrations](/docs/containers?topic=containers-debug_apps).
{: tip}


## Deploy your app
{: #dev_deploy}

Deploy your app to the cluster by running your app configuration file.
{: shortdesc}


- [Deploying apps with the Kubernetes dashboard](/docs/containers?topic=containers-deploy_app).
- [Deploying apps with the CLI](/docs/containers?topic=containers-deploy_app).
- [Deploying apps to specific worker nodes by using labels](/docs/containers?topic=containers-deploy_app#node_affinity).
- [Deploying an app on a GPU machine](/docs/containers?topic=containers-deploy_app#gpu_app).


Need help? Check out [Troubleshooting apps and integrations](/docs/containers?topic=containers-debug_apps).
{: tip}


## Test, log, and monitor
{: #dev_test}

While you conduct performance testing on your app, set up logging and monitoring to help you troubleshoot issues, gain visibility into your workloads, and improve the health and performance of your apps.
{: shortdesc}

In a test environment, deliberately create various non-ideal scenarios, such as deleting all worker nodes in a zone to replicate a zonal failure. Review the logs and metrics to check how your app recovers.

1. **Test access**: Test access to your app by creating a public or private [NodePort](/docs/containers?topic=containers-nodeport) on your worker nodes.
2. **Monitoring**:
    1. Open a [Kubernetes dashboard](/docs/containers?topic=containers-deploy_app#cli_dashboard) on your local system to view information about your app resources.
    2. [Choose a monitoring solution](/docs/containers?topic=containers-health-monitor#view_metrics), such as {{site.data.keyword.mon_full}}, to gain operational visibility into the performance and health of your apps.
3. **Logging**: [Choose a logging solution](/docs/containers?topic=containers-health#logging_overview), such as {{site.data.keyword.logs_full_notm}}, to monitor container logs.

Need help? Check out [Troubleshooting logging and monitoring](/docs/containers?topic=containers-cs_dashboard_graphs).
{: tip}



## Update your app
{: #dev_update}

Perform rolling updates and rollbacks of apps without downtime for your users.
{: shortdesc}

1. **Update strategy**: [Plan your strategy for keeping your app up-to-date](/docs/containers?topic=containers-update_app#updating_apps).
2. **Set up updates**:
    - Add a [rolling update to your deployment file](/docs/containers?topic=containers-update_app#app_rolling)
    - Perform A/B, canary, and phased rollouts with the [Istio managed add-on](/docs/containers?topic=containers-istio-qs).
    - Set up [a continuous delivery pipeline for a cluster](/docs/containers?topic=containers-cicd).
3. **Scaling**: Enable [horizontal pod autoscaling](/docs/containers?topic=containers-update_app#app_scaling) to automatically increase or decrease the number of instances of your apps based on CPU.



## Secure your app
{: #dev_secure}

Use Kubernetes secrets to store confidential information, such as credentials or keys, and encrypt data in Kubernetes secrets to prevent unauthorized users from accessing sensitive app information.
{: shortdesc}


1. **Secrets**:
    1. Store personal or sensitive information in [Kubernetes secrets](/docs/containers?topic=containers-security#pi) that your app can access.
    2. [Encrypt secrets by using a KMS provider](/docs/containers?topic=containers-encryption-secrets).
    3. [Verify that secrets are encrypted](/docs/containers?topic=containers-encryption-secrets#encryption-secrets-verify).
2. **Pod-to-pod traffic**: [Enable mTLS encryption for traffic between microservices within an Istio service mesh](/docs/containers?topic=containers-istio-mesh#mtls).



## Expose your app
{: #dev_expose}

Publicly expose an app in your cluster to the internet or privately expose an app in your cluster to the private network only.
{: shortdesc}

1. **Plan service discovery**:
    1. Understand the [basics of Kubernetes service discovery](/docs/containers?topic=containers-plan_deploy#service_discovery).
    2. [Choose an app exposure service](/docs/containers?topic=containers-cs_network_planning) that fits your requirements for incoming traffic to the app.
2. **Expose your app**:
    - Load balancers:
        - Classic clusters:
            1. Create an [NLB 1.0](/docs/containers?topic=containers-loadbalancer) or [NLB 2.0](/docs/containers?topic=containers-loadbalancer-v2).
            2. [Register a DNS subdomain](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname) for the NLB.
        - VPC clusters: Set up a [VPC load balancer](/docs/containers?topic=containers-vpclb-about).

    - Ingress: [Configure Ingress](/docs/containers?topic=containers-managed-ingress-setup) for the public or private network.

Need help? Check out [Troubleshooting Ingress](/docs/containers?topic=containers-ingress-debug) and [Troubleshooting load balancers](/docs/containers?topic=containers-cs_loadbalancer_fails).
{: tip}

## Add app storage
{: #dev_storage}


1. **Requirements**: Determine your [requirements for a storage solution](/docs/containers?topic=containers-storage-plan).
2. **Choose a solution**: Using your storage requirements, choose a storage solution by comparing [your options](/docs/containers?topic=containers-storage-plan).

Need help? Check out the troubleshooting page for your persistent storage solution.
{: tip}

## Add integrations
{: #dev_integrate}

Enhance app capabilities by integrating various external services and catalog services in your cluster with your app.
{: shortdesc}

1. **Review supported integrations**:

    - [All supported integrations](/docs/containers?topic=containers-supported_integrations#supported_integrations)

    - [{{site.data.keyword.containerlong_notm}} partners](/docs/containers?topic=containers-supported_integrations)

    - [{{site.data.keyword.cloud_notm}} services and third-party integrations](/docs/containers?topic=containers-ibm-3rd-party-integrations)

2. **Add services to your cluster**: Ask your cluster administrator to [add the integration to your cluster](/docs/containers?topic=containers-learning-path-admin#admin_integrate).

3. **Access services from your app**: Ensure that your app can access the service. For example, to access an IBM Cloud service instance from your app, you must [make the service credentials that are stored in the Kubernetes secret available to your app](/docs/containers?topic=containers-service-binding#adding_app).

Need help? Check out [Troubleshooting apps and integrations](/docs/containers?topic=containers-debug_worker_nodes).
{: tip}f
