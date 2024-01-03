---

copyright: 
  years: 2014, 2024
lastupdated: "2024-01-03"


keywords: kubernetes, help, network, connectivity

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}





# Classic: Why is the bare metal instance ID inconsistent with worker records?
{: #bm_machine_id}
{: support}



[Classic infrastructure]{: tag-classic-inf}



When you use `ibmcloud ks worker` commands with your bare metal worker node, you see a message similar to the following.
{: tsSymptoms}

```sh
The worker node instance ID changed. Reload the worker node if bare metal hardware was serviced.
```
{: screen}


The machine ID can become inconsistent with the {{site.data.keyword.containerlong_notm}} worker record when the machine experiences hardware issues. When IBM Cloud infrastructure resolves this issue, a component can change within the system that the service does not identify.
{: tsCauses}


For {{site.data.keyword.containerlong_notm}} to re-identify the machine, [reload the bare metal worker node](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload). Note that reloading also updates the machine's patch version. For more information, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions).
{: tsResolve}

You can also [delete the bare metal worker node](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_rm). Remember that bare metal instances are billed monthly.






