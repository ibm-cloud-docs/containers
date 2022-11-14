---

copyright: 
  years: 2014, 2022
lastupdated: "2022-11-14"

keywords: kubernetes, help, network, connectivity

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Checking the status of Ingress components
{: #ingress-status}
{: support}

Supported infrastructure providers
:   Classic
:   VPC

## Getting the status and message
{: #check_status}

To check the overall health and status of your cluster's Ingress components:
{: shortdesc}

```sh
ibmcloud ks ingress status report-get -c <cluster_name_or_ID>
```
{: pre}

The state of the Ingress components are reported in an **Ingress Status** and **Ingress Message**.

Example output


```sh
Ingress Status:   healthy
Message:          All Ingress components are healthy.

Cluster                        Status
ingress-controller-configmap   healthy
alb-healthcheck-ingress        healthy

Subdomain                                                                           Status
example-ae7743ca70a399d9cff4eaf617434c72-0000.us-south.containers.appdomain.cloud   healthy

ALB                                  Status
public-crad7rd4m219nv1vtgdivg-alb1   healthy

Secret                                          Namespace           Status
example-ae7743ca70a399d9cff4eaf617434c72-0000   ibm-cert-store      healthy
example-ae7743ca70a399d9cff4eaf617434c72-0000   default             healthy
example-ae7743ca70a399d9cff4eaf617434c72-0000   kube-system         healthy
```
{: screen}









The **Ingress Status** and **Ingress Message** fields are also returned in the output of the `ibmcloud ks cluster get` command. 
{: tip}


## Ingress statuses
{: #ingress_status}

The Ingress Status reflects the overall health of the Ingress components.
{: shortdesc}

| Ingress status | Description |
|--- | --- |
| `healthy` | The Ingress components are healthy.|
| `warning` | Some Ingress components might not function properly.|
| `critical` | Some Ingress components are malfunctioning.|
| `disabled` | Ingress status reporting is disabled. You can turn it on using the `ibmcloud ks ingress status-report enable` command.|
| `unsupported`| Ingress status reporting is not available for unsupported cluster versions. |
{: caption="Ingress statuses" caption-side="bottom"}


## Ingress messages
{: #ingress_message}

The Ingress message provides details of what operation is in progress or information about any components that are unhealthy. Each status and message is described in the following tables.
{: shortdesc}

|Ingress message|Description|
|--- |--- |
| `The Ingress Operator is in a degraded state (ERRIODEG).` | For more information, see [Why is the Ingress Operator in a degraded state?](/docs/containers?topic=containers-ts-ingress-erriodeg). | 
| `The Ingress Operator is missing from the cluster. (ERRSNF).` | For more information, see [Why is the Ingress LoadBalancer service missing from my cluster?](/docs/containers?topic=containers-ts-ingress-errsnf).|
| `The Ingress Operator is missing from the cluster. (ERRIONF).` | For more information, see [Why do I get an error that the Ingress Operator is missing from my cluster?](/docs/containers?topic=containers-ts-ingress-errionf).|
| `The external service is missing (ERRESNF).` | For more information, see [Why is the external service is missing from my cluster?](/docs/containers?topic=containers-ts-ingress-erresnf).|
| `The load balancer service is missing (ERRSNF).` | For more information, see [Why is the LoadBalancer service missing from my cluster?](/docs/containers?topic=containers-ts-ingress-errsnf).|
| `The ALB deployment is not found on the cluster (ERRADNF).` | For more information, see [Why does the Ingress status show an ERRADNF error?](/docs/containers?topic=containers-ts-ingress-erradnf).|
| `The ALB version is no longer supported (ERRAVUS).` | For more information, see [Why does the Ingress status show an ERRAVUS error?](/docs/containers?topic=containers-ts-ingress-erravus).|
| `The ingress controller configmap is not found on the cluster (ERRICCNF).` | For more information, see [Why is the Ingress controller ConfigMap missing from my cluster?](/docs/containers?topic=containers-ts-ingress-erriccnf).|
| `The ALB is unable to respond to health requests (ERRAHCF).` | For more information, see [Why is my ALB not responding to health check requests?](/docs/containers?topic=containers-ts-ingress-errahcf).|
| `The ALB health service is not found on the cluster (ERRAHSNF).` | For more information, see [Why is the ALB health check service missing from my cluster?](/docs/containers?topic=containers-ts-ingress-errahsnf).|
| `The ALB health ingress resource is not found on the cluster (ERRAHINF).` | For more information, see [Why is the health check Ingress resource missing from my cluster?](/docs/containers?topic=containers-ts-ingress-errahinf).|
| `One or more ALB pod is not in running state (ERRADRUH).` | For more information, see [Why does the Ingress status show an `ERRADRUH` error?](/docs/containers?topic=containers-ts-ingress-erradruh).|
| `The subdomain has incorrect addresses registered (ERRDSIA).` | For more information, see [Why does the Ingress status show an ERRDSIA error?](/docs/containers?topic=containers-ts-ingress-errdsia).|
| `The subdomain has DNS resolution issues (ERRDRISS).` | For more information, see [Why does the Ingress status show an ERRDRISS error?](/docs/containers?topic=containers-ts-ingress-errdriss).|
| `The subdomain has TLS secret issues (ERRDSISS).` | For more information, see [Why does the Ingress status show an ERRDSISS error?](/docs/containers?topic=containers-ts-ingress-errdsiss).|
| `Secret is not present on the cluster or is in the wrong namespace (ESSDNE).` | For more information, see [Why does the Ingress status show an ESSDNE error?](/docs/containers?topic=containers-ts-ingress-essdne).|
| `Secret status shows a warning (ESSWS).` | For more information, see [Why does the Ingress status show an ESSWS error?](/docs/containers?topic=containers-ts-ingress-essws).|
| `Field for opaque secret expired or will expire soon (ESSEF).` | For more information, see [Why does the Ingress status show an ESSEF error?](/docs/containers?topic=containers-ts-ingress-essef).|
| `Certificate for TLS secret expired or will expire soon (ESSEC).` | For more information, see [Why does the Ingress status show an ESSEC error?](/docs/containers?topic=containers-ts-ingress-essec).|
| `CRN does not match default secret with the same domain (ESSVC).` | For more information, see [Why does the Ingress status show an ESSVC error?](/docs/containers?topic=containers-ts-ingress-essvc).|
| `Could not access {{site.data.keyword.secrets-manager_short}} instance group, verify default group is accessible and exists within instance (ESSSMG).` | For more information, see [Why does the Ingress status show an ESSSMG error?](/docs/containers?topic=containers-ts-ingress-esssmg).|
| `Could not access {{site.data.keyword.secrets-manager_short}} instance., verify S2S is enabled (ESSSMI).` | For more information, see [Why does the Ingress status show an ESSSMI error?](/docs/containers?topic=containers-ts-ingress-esssmi).|
{: caption="Ingress messages" caption-side="bottom"}



