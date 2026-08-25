---

copyright:
  years: 2026, 2026
lastupdated: "2026-08-25"


keywords: kubernetes, iks, ingress, monitoring, traefik

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Observing Traefik Ingress
{: #cs_traefik_ingress_monitor}

You can monitor Traefik-based Kubernetes Ingress ALBs by using {{site.data.keyword.mon_full_notm}}.
{: shortdesc}


## Setting up monitoring with {{site.data.keyword.mon_full_notm}}
{: #traefik_ingress_health_mon}

Gain operational visibility into the performance and health of your Traefik-based Kubernetes Ingress ALBs by deploying a {{site.data.keyword.mon_short}} agent to your worker nodes to forward metrics to {{site.data.keyword.mon_full}}. After you deploy the monitoring agent to the worker nodes in your cluster, monitoring automatically detects and scrapes the data and then displays it in your {{site.data.keyword.mon_full_notm}} dashboard.

1. [Provision an instance of {{site.data.keyword.mon_full_notm}}](https://cloud.ibm.com/observability/catalog/ibm-cloud-monitoring){: external}.

2. Configure a monitoring agent in your cluster.

    1. Select your monitor from the [Monitoring](https://cloud.ibm.com/observe/monitoring){: external} page.
    2. Click **Monitoring sources**.
    3. Follow the instructions for installing a monitoring agent to your cluster.
    
    It might take a few minutes for the agent to finish installing.

3. In the [Monitoring console](https://cloud.ibm.com/observe/monitoring){: external}, click **Open Dashboard** for the instance that you provisioned.

4. In the {{site.data.keyword.mon_short}} UI, click **Dashboards** > **Applications** > **Traefik Ingress**. The **Traefik Ingress** dashboard does not appear until data is available, which can take some time. The dashboard is visible only when the monitoring agent finds the `traefik_entrypoint_requests_total` metric. These metrics are exposed when you send requests to the hosts that are defined in your Ingress resources.
    
    The default Traefik Ingress monitoring filters can produce a high volume of metrics, which can incur additional billing. Add the filter `exclude: traefik_*bucket` to reduce costs by excluding some metrics while retaining the default metrics needed for the Traefik dashboard.
    {: note}

For more information about {{site.data.keyword.mon_full_notm}}, see [Getting started tutorial](/docs/monitoring?topic=monitoring-getting-started).


