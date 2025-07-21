---

copyright: 
  years: 2014, 2025
lastupdated: "2025-07-21"


keywords: kubernetes, help, network, dns, health check

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Ingress health checks fail on Akamai Global Load Balancer (GLB) configurations
{: #cs_ingress_health_check_ctm}
{: support}

[Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}


When you try to include Ingress subdomains that have health checks enabled in your Akamai Global Traffic Management (GTM) configuration, the health checks fail.
{: tsSymptoms}


Akamai Global Traffic Management (GTM) configurations don't support nested subdomains.
{: tsCauses}

Disable the default health check for the Ingress subdomain. For more information see the `nlb-dns monitor disable` [command reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_nlb-dns-monitor-disable).
{: tsResolve}

```sh
ibmcloud ks nlb-dns monitor disable --cluster CLUSTER --nlb-host SUBDOMAIN 
```
{: pre}
