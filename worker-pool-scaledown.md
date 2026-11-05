---

copyright:
  years: 2026, 2026
lastupdated: "2026-11-05"


keywords: containers, {{site.data.keyword.containerlong_notm}}, scale down, worker pool resize, worker node deletion order

subcollection: containers

content-type: reference

---

{{site.data.keyword.attribute-definition-list}}


# How worker pools are scaled down
{: #worker-scaledown-logic}

When worker nodes are removed during a scale-down, such as when you run [`ibmcloud ks worker-pool resize`](/docs/containers?topic=containers-kubernetes-service-cli#worker-pool-resize-cli), IBM prioritizes the worker nodes for deletion automatically. You do not need to configure this behavior.
{: shortdesc}

When the number of worker nodes in a worker pool is decreased, the worker nodes are prioritized for deletion based on several properties including state, health, and version.

This priority logic is not relevant to the autoscaler add-on.
{: note}

The following table shows the order in which worker nodes are prioritized for deletion.

You can run the `ibmcloud ks worker ls` command to view all the worker node properties listed in the table. 
{: tip}

| Priority | Property | Description |
|---|---|---|
| 1 | Worker node state | Worker nodes in non-functioning or low-functioning states are prioritized for removal. This list shows the states ordered from highest to lowest priority: `provision_failed`, `deploy_failed`, `deleting`, `provision_pending`, `provisioning`, `deploying`, `provisioned`, `reloading_failed`, `reloading`, `deployed`. |
| 2 | Worker node health | Unhealthy worker nodes are prioritized over healthy worker nodes. This list shows the health states ordered from highest to lowest priority: `critical`, `warning`, `pending`, `unsupported`, `normal`.|
| 3 | Worker node version | Worker nodes that run on older versions are at a higher priority for deletion. |
| 4 | Chosen placement setting | **For workers running on a dedicated host only.** Worker nodes running on a dedicated host that has the `DesiredPlacementDisabled` option set to `true` are at a higher priority for deletion. | 
| 5 | Alphabetical order | After worker nodes are prioritized based on the factors in the previous rows, they are deleted in alphabetical order. Note that, based on worker node ID conventions, IDs for workers on classic and VPC clusters correlate with age, so older worker nodes are removed first. |
{: caption="Priority for worker nodes deleted during worker pool scale down" caption-side="bottom"}

## Related links
{: #worker-scaledown-related}

* [Updating clusters, worker nodes, and cluster components](/docs/containers?topic=containers-update)
* [Updating flavors (machine types)](/docs/containers?topic=containers-update-flavors)
