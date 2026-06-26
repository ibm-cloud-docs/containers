---

copyright:
  years: 2026, 2026
lastupdated: "2026-06-26"


keywords: kubernetes, containers, 136, version 136, 136 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.36 version information and update actions
{: #cs_versions_136}


Review information about version 1.36 of {{site.data.keyword.containerlong}}. For more information about Kubernetes project version 1.36, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}.
{: shortdesc}



## Release timeline
{: #release_timeline_136}

The following table includes the expected release timeline for version 1.36 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported.
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | Release date | Unsupported date |
|------|------|----------|----------|
| 1.36 | Yes | {{site.data.keyword.kubernetes_136_release_date}} | {{site.data.keyword.kubernetes_136_unsupported_date}} `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.36" caption-side="bottom"}


## Preparing to update
{: #prep-up-136}

For a complete list of changes that might impact your deployed apps when you update your cluster, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.36.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_136) for version 1.36. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

Anonymous access to the Kubernetes API server is now restricted
:   Anonymous access to the Kubernetes API server is now restricted to health check endpoints (`/healthz`, `/readyz`, `/livez`, `/livez/ping`). All other endpoints require authentication (for example, `/version`). This reduces exposure from accidental RBAC misconfigurations that grant permissions to `system:anonymous` or `system:unauthenticated`.

Kubernetes Dashboard is deprecated
:   The open source Kubernetes Dashboard is deprecated and archived. The Kubernetes Dashboard is no longer installed on newly provisioned clusters and is removed from clusters on earlier versions when you upgrade to 1.36. [The Headlamp add-on](/docs/containers?topic=containers-headlamp-addon) is available as a replacement Kubernetes UI.

Kubernetes API server and Konnectivity tunnel served over port 443
:   The Kubernetes API server and Konnectivity tunnel are now served over the standard HTTPS port 443 instead of a dynamically assigned node port (for example, a port in the `20000–32767` range). Traffic is routed to the correct backend service using hostname-based routing, which is why each function has a dedicated hostname even though all services share port 443. This change makes it easier to connect to your cluster from restrictive network environments because you no longer need to allow a non-standard port through your firewalls and egress controls. Your cluster exposes two purpose-built hostnames through its private and public service endpoints:

    - `<cluster>.api.<region-domain>` — the Kubernetes API server endpoint
    - `<cluster>.tunnel.<region-domain>` — the Konnectivity tunnel endpoint used for control plane to worker node communication

    This capability is available starting with IKS version 1.36 in the following regions: Montreal (`ca-mon`), Chennai (`in-che`), and Mumbai (`in-mum`). Support for additional regions is coming soon.

    - **New clusters:** No action is required. New clusters are created with port 443 endpoints and the kubeconfig you download already uses port 443.
    - **Updated clusters that use the public service endpoint:** After your cluster is updated to use port 443, a kubeconfig that still references the public service endpoint URL keeps using the old port, which will fail. `kubectl` commands will result in connection timeouts. To avoid this, either download a fresh kubeconfig by running `ibmcloud ks cluster config`, or manually update the port in your existing kubeconfig to 443.
    - **Updated clusters that use the private service endpoint only:** No immediate action is required. Existing connections that target the previous NodePort continue to work after the upgrade. The new kubeconfig that you download uses the port 443 endpoint.
    - **Custom network rules:** Update any firewall, security group, or egress allowlist rules that explicitly reference the old high-numbered control plane port to allow outbound HTTPS on port 443 instead. Any rules that pinned the previous high-numbered port can be removed.
    - **IP-based allowlists:** The public service endpoint DNS records now resolve to Akamai IP Protect (IPP) frontend IP addresses instead of the previous load balancer (NLB) IP addresses. If your firewall or egress rules allow traffic to your cluster by destination IP address, update them to use the current Akamai IPP IP ranges.

NVIDIA GPU drivers no longer automatically installed
:   Starting with Kubernetes version 1.36, {{site.data.keyword.containerlong_notm}} no longer automatically installs NVIDIA GPU drivers on GPU worker nodes. You must install and manage GPU drivers yourself to run GPU workloads. For more information, see [Migrating to self-managed GPU drivers](/docs/containers?topic=containers-gpu-migrate-136).

Cluster autoscaler does not yet support version 1.36. Do not update your cluster to version 1.36 if the autoscaler is installed.
{: important}

### Update before master
{: #before-master-136}

Review the following changes that you must make before you update the Kubernetes master.
{: shortdesc}

| Type | Description |
| --- | --- |
| **Removed:** In-tree Portworx volume plugin | The in-tree Portworx volume plugin is removed in Kubernetes 1.36, completing the migration to the Portworx CSI driver. The `CSIMigrationPortworx` feature gate (GA and locked since 1.33) and the alpha `InTreePluginPortworxUnregister` feature gate are also removed, and all in-tree Portworx volume operations are redirected to CSI. Before you update, make sure that the [Portworx CSI driver](https://kubernetes.io/docs/concepts/storage/volumes/#portworxvolume){: external} is installed and that your `StorageClass`, `PersistentVolume`, and `PersistentVolumeClaim` resources reference the CSI driver. Clusters that still rely on the in-tree plugin lose access to Portworx volumes after the update. |
| **Changed:** Stricter IP and CIDR validation | The `StrictIPCIDRValidation` feature gate is enabled by default in the API server. API fields that hold IP or CIDR values no longer accept addresses with extraneous leading zeros (for example, `010.000.000.005` instead of `10.0.0.5`) or CIDR values with ambiguous host bits (for example, `192.168.0.5/24` instead of `192.168.0.0/24` or `192.168.0.5/32`). Audit your manifests and tooling for resources such as `Service`, `NetworkPolicy`, and `EndpointSlice`, and correct any non-canonical IP or CIDR values before you update. After the master is updated, requests that create or update objects with invalid values are rejected. |
| **Changed:** Renamed control plane metrics | The `volume_operation_total_errors` metric (kube-controller-manager) is renamed to `volume_operation_errors_total`, and the `etcd_bookmark_counts` metric is renamed to `etcd_bookmark_total`. If you use custom monitoring dashboards or alerting rules that reference the old metric names, update them to the new names so that your monitoring continues to work after the control plane is updated. |
| **Removed:** `git-repo` volume plugin | The `git-repo` volume plugin is disabled by default with no option to re-enable it; the `GitRepoVolumeDriver` feature gate no longer has any effect. This volume type has been unsupported in {{site.data.keyword.containerlong_notm}} since version 1.33. If any workloads still use a `gitRepo` volume, migrate them to an `emptyDir` volume that is populated by an `init` container that clones the repository by using `git`. For more information, see [Removal of in-tree `gitRepo` volume driver](https://kubernetes.io/blog/2025/04/23/kubernetes-v1-33-release/#removal-of-in-tree-gitrepo-volume-driver){: external}. |
{: caption="Changes to make before you update the master to Kubernetes 1.36" caption-side="bottom"}

### Update after master
{: #after-master-136}

Review the following changes that you must make after you update the Kubernetes master.
{: shortdesc}

| Type | Description |
| --- | --- |
| **Deprecated:** Service `.spec.externalIPs` | The `.spec.externalIPs` field on `Service` resources is deprecated, and the API server now returns a deprecation warning when the field is set. Plan to stop using `externalIPs`, and route external traffic through a `LoadBalancer` service or an Ingress instead. For more information, see [External IPs](https://kubernetes.io/docs/concepts/services-networking/service/#external-ips){: external}. |
| **Changed:** Default `kubectl debug` profile | The default profile for `kubectl debug` changes from `legacy` to `general`. If you have scripts or runbooks that depend on the behavior of the `legacy` profile, pass `--profile=legacy` explicitly. The `legacy` profile is planned for removal in Kubernetes 1.39. For more information, see [Debugging running Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/){: external}. |
| **Changed:** client-go informer event ordering (`AtomicFIFO`) | The client-go `AtomicFIFO` feature gate is enabled by default. Informer stores are now fully updated to a consistent resource version before the per-item `OnAdd`, `OnUpdate`, and `OnDelete` handlers are called, and informer resync processing changes slightly, which can produce observable differences in handler invocation timing. Test custom controllers and operators that embed client-go. If you observe regressions, you can temporarily set the `AtomicFIFO` client-go feature gate to `false` in your own controller binary while you adapt. |
| **Changed:** Stricter CustomResourceDefinition numeric validation | CustomResourceDefinition (CRD) validation now strictly enforces the ranges of the `int32`, `int64`, `float`, and `double` numeric formats when they are set in a schema. Existing objects that already hold out-of-range values are preserved through validation ratcheting, but new or updated values must fall within range. Review custom resources that use these numeric formats. |
| **Deprecated:** Credential plugin allowlist field | In the client credential plugin allowlist, the `AllowlistEntry.Name` field is renamed to `AllowlistEntry.Command`. If you configure a credential plugin allowlist (for example, through `kuberc`), update your configuration to use the new field name. |
| **Deprecated:** Direct access to `metav1.FieldsV1.Raw` | Direct access to the `Raw` field of `metav1.FieldsV1` is deprecated. Code that constructs or reads `FieldsV1` (for example, controllers or tools that inspect managed fields) should migrate to the new `NewFieldsV1(string)`, `GetRawBytes()`, `GetRawString()`, and `SetRawBytes()` accessor methods. |
| **Action required:** Custom scheduler PreBind plugins | The scheduler framework now supports running PreBind plugins in parallel. If you maintain custom scheduler plugins, update them to return a `PreBindPreFlightResult` from the `PreBindPreFlight` method; returning `nil` retains the existing sequential behavior, and plugins opt in to parallel execution by returning `AllowParallel: true`. This action applies only to clusters that run custom scheduler plugins. |
| **Action required:** Granular RBAC for DRA drivers | When the `DRAResourceClaimGranularStatusAuthorization` feature gate is enabled (beta in 1.36), Dynamic Resource Allocation (DRA) drivers and controllers require granular RBAC permissions to update `ResourceClaim` statuses. Schedulers and controllers need `update` or `patch` on `resourceclaims/binding`, and DRA drivers need `associated-node:update` or `arbitrary-node:update` on `resourceclaims/driver`, restricted by their specific `resourceNames`. If you run DRA drivers, update their RBAC. This action applies only to clusters that use DRA. |
{: caption="Changes to make after you update the master to Kubernetes 1.36" caption-side="bottom"}
