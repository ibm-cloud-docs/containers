


## Limitations

A Kubernetes cluster with IBM Z worker nodes has the following limitations.
{: shortdesc}

* No backup/restore
* No resizing of worker VM cpu, memory or storage (1 T shirt size)
* No HA
* No IBM Cloud logging/monitoring (no sysdig, logdna)
* No Billing No IaaS visibility through IBM Cloud
* No multiarch cluster support
* No edge node support, it will be one worker with one public ip
* No customer IaaS account presence, worker hosted in IBM ZaaS ‘account’ (CoLo).
* No customer managed networking, ZaaS IaaS just assigns ip and handles this
* No LoadBalancing
* No Ingress (single worker initially)
* No network storage
* No SpectrumScale or GlusterFS
* No upgrade path (destroy, redeploy)
* No scalability
* No multi-regions

**TODO: What are the benefits of Z compared to other flavors? Goes along with the question of what this hyper secure environment is?
- How can I scale this cluster? Even if we just mention that you can only have 1 worker node right now.
- Things like is multizone, logging, monitoring, storage, service binding supported? Can I combine the Z worker node with other non-Z flavors? Or what limitations we have in terms of app deployment? E.g. that you cannot expose it with load balancers, Ingress, etc. Is it available in all regions?**
