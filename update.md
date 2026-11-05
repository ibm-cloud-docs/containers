---

copyright:
  years: 2014, 2026
lastupdated: "2026-11-05"


keywords: containers, {{site.data.keyword.containerlong_notm}}, upgrade, version, update cluster, update worker nodes, update cluster components, update cluster master, update checklist

subcollection: containers

content-type: overview

---

{{site.data.keyword.attribute-definition-list}}


# Updating clusters, worker nodes, and cluster components
{: #update}

Keep your cluster secure and supported by updating the master, worker nodes, and cluster components in the correct order. Updating out of sequence can cause version skew failures or unexpected downtime.
{: shortdesc}

For information about which updates IBM applies and which updates you apply, see [Your responsibilities with using {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-responsibilities_iks).

## Update checklist
{: #update-checklist}

Complete updates in the following order. Each step links to the topic that contains the procedure.
{: shortdesc}

Not sure which infrastructure type you have? In the {{site.data.keyword.cloud_notm}} console, click your cluster and check the **Infrastructure** field on the Overview tab. It shows **Classic**, **VPC**, or **Satellite**.

1. [Check your cluster version, worker node version, and worker node operating system](/docs/containers?topic=containers-flavor-os-check).
2. [Prepare to update your cluster](/docs/containers?topic=containers-update-prepare). Review version changes, back up, and check add-ons, plug-ins, and permissions.
3. [Update the cluster master](/docs/containers?topic=containers-update-master).
4. Update your worker nodes. The topic to use depends on your infrastructure type.
    * [Classic worker nodes](/docs/containers?topic=containers-update-workers-classic)
    * [VPC worker nodes](/docs/containers?topic=containers-update-workers-vpc)
    * [Satellite worker nodes](/docs/satellite?topic=satellite-host-update-workers)
5. [Update cluster components and managed add-ons](/docs/containers?topic=containers-update-components), such as Fluentd and Ingress ALBs if you manage them manually.

Some versions require add-on updates at a different point in the sequence. Always check the version information page for your target version for _Update before master_ and _Update after master_ actions.

To update Satellite worker nodes, follow the steps in [Updating hosts that are assigned as worker nodes](/docs/satellite?topic=satellite-host-update-workers).

## Other update tasks
{: #update-other-tasks}

You can also complete the following update-related tasks.

To change the flavor (machine type) of the worker nodes in a worker pool, see [Updating flavors (machine types)](/docs/containers?topic=containers-update-flavors). To learn which worker nodes are removed first when a worker pool shrinks, see [How worker pools are scaled down](/docs/containers?topic=containers-worker-scaledown-logic).


To change the operating system version of the worker nodes in a worker pool, see [Migrating to a new Ubuntu version](/docs/containers?topic=containers-ubuntu-migrate).



## Troubleshooting update problems
{: #update-troubleshooting}

If an update does not complete or a cluster or worker node enters an unexpected state, start with the following topics.
{: shortdesc}

To check the health of the master, see [Reviewing master health](/docs/containers?topic=containers-debug_master). If a webhook blocks the update, see [Troubleshooting webhook errors](/docs/containers?topic=containers-ts-webhook-debug). If replacing a worker node does not create a new worker node, see [Why doesn't replacing a worker node create a worker node?](/docs/containers?topic=containers-auto-rebalance-off). If duplicate nodes appear after an update, see [After a worker node updates or reloads, why do duplicate nodes and pods appear?](/docs/containers?topic=containers-cs_duplicate_nodes).


If the master update fails with a migration in progress error, see [Resolving cluster master upgrade issues: Migration in progress error](/docs/containers?topic=containers-ts-resource-migration).



For the states that your cluster and worker nodes can show, see [Cluster states and statuses](/docs/containers?topic=containers-cluster-states-reference) and [Worker node states](/docs/containers?topic=containers-worker-node-state-reference).

## Next steps
{: #update-next-steps}

After you update, [rotate your CA certificates](/docs/containers?topic=containers-cert-rotate) if you haven't recently, and review the [worker node states](/docs/containers?topic=containers-worker-node-state-reference) to confirm that your worker nodes are healthy.

## Related links
{: #update-related-links}

* [Your responsibilities with using {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-responsibilities_iks)
* [Kubernetes version information](/docs/containers?topic=containers-cs_versions)
* [Rotating CA certificates in your cluster](/docs/containers?topic=containers-cert-rotate)
