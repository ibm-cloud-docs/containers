---

copyright:
  years: 2021, 2022
lastupdated: "2022-11-11"

keywords: kubernetes, iks, ingress, monitoring

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Observing Kubernetes Ingress
{: #cs_ingress_monitor}

You can monitor the Kubernetes Ingress ALBs by using {{site.data.keyword.mon_full_notm}}. 
{: shortdesc}


## Setting up monitoring with {{site.data.keyword.mon_full_notm}}
{: #ingress_health_mon}

Gain operational visibility into the performance and health of your Kubernetes Ingress ALBs by deploying a {{site.data.keyword.mon_short}} agent to your worker nodes to forward metrics to {{site.data.keyword.mon_full}}. When you deploy a monitoring agent to the worker nodes in your cluster, Monitoring is already automatically enabled to detect and scrape the data  and then display them in your {{site.data.keyword.mon_full_notm}} dashboard.
{: shortdesc}

1. [Provision an instance of {{site.data.keyword.mon_full_notm}}](https://cloud.ibm.com/observe/monitoring/create){: external}.

2. Configure a monitoring agent in your cluster.

    1. Select your monitor from the [Monitoring](https://cloud.ibm.com/observe/monitoring){: external} page.
    2. Click **Monitoring sources**.
    3. Follow the instructions for installing a monitoring agent to your cluster.
    
    Note that it may take a few minutes for your agent to finish installing.

3. In the [Monitoring console](https://cloud.ibm.com/observe/monitoring){: external}, click **Open Dashboard** for the instance that you provisioned.

4. In the {{site.data.keyword.mon_short}} UI, click **Dashboards** > **Applications** > **NGINX Ingress**. Note that the **NGINX Ingress** dashboard does not appear until there is data available. This process can take some time. The **NGINX Ingress** dashboard is visible only when the monitoring agent finds `nginx_ingress_controller_requests metrics` value. These metrics are exposed when you send queries to the hosts that are defined in your Ingress resources.
    
    The default Ingress monitoring filters can produce a high volume of metrics, which can incur additional billing. Add the filter `exclude: nginx_ingress*bucket` to reduce costs by excluding some metrics while retaining the default metrics needed for the NGINX dashboard.
    {: note}

For more information about {{site.data.keyword.mon_full_notm}}, see [Getting started tutorial](/docs/monitoring?topic=monitoring-getting-started).


