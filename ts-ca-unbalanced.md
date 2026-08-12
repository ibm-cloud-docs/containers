---

copyright: 
  years: 2014, 2026
lastupdated: "2026-08-12"


keywords: kubernetes, help, network, connectivity, autoscaler

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Why are my autoscaled worker pools unbalanced?
{: #ts-ca-unbalanced}

Learn why your worker pool becomes unbalanced across zones when you enable the cluster autoscaler.
{: shortdesc}


During a scale-up, the cluster autoscaler balances nodes across zones, with a permitted difference of plus or minus one worker node.
{: tsSymptoms}

Your pending workloads might not request enough capacity to make each zone balanced.
{: tsCauses}

To balance the worker pools manually, [update your cluster autoscaler ConfigMap](/docs/containers?topic=containers-cluster-scaling-install-addon-enable) to remove the unbalanced worker pool. Then, run the `ibmcloud ks worker-pool rebalance` [command](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-rebalance-cli), and add the worker pool back to the cluster autoscaler ConfigMap.
{: tsResolve}
