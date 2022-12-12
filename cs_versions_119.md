---

copyright:
  years: 2014, 2022
lastupdated: "2022-12-12"

keywords: kubernetes, 1.19, versions, update, upgrade

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# 1.19 version information and update actions 
{: #cs_versions_119}

Kubernetes version 1.19 is unsupported.
{: important}

Review information about version 1.19 of {{site.data.keyword.containerlong}}, released 13 Oct 2020.
{: shortdesc}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}

![This badge indicates Kubernetes version 1.19 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Figure 1. Kubernetes version 1.19 certification badge" caption-side="bottom"}

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.19 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._


## Release timeline
{: #release_timeline_119}

The following table includes the expected release timeline for version 1.19 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

|  Version | Supported? | {{site.data.keyword.containerlong_notm}} \n release date | {{site.data.keyword.containerlong_notm}} \n unsupported date |
|------|------|----------|----------|
| 1.19 | Deprecated | 13 Oct 2020 | 14 Mar 2022 `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.19" caption-side="bottom"}

## Preparing to update
{: #prep-up-119}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.19. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.19.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_119) for version 1.19. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}. 
{: shortdesc}


### Update before master
{: #119_before}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| ---- | ---------- |
| Calico data store driver change | When you update your cluster to version 1.19, Calico is updated to use the Kubernetes data store driver (KDD). During the update, you can request resources that require Calico, such as pods that are subject to Calico policies, but the resources remain pending until the update is complete.  \n - Before the update, you must delete any `NetworkPolicy` resources that are scoped to namespaces that no longer exist. When you delete a namespace, Kubernetes cleans up all resources that are associated with that namespace. However, resources that you created for Calico by using the `calicoctl` CLI, such as `NetworkPolicy` resources that you scoped to that namespace, are not cleaned up and remain in your cluster even after the namespace is deleted. To find and delete any of these policies, list all `NetworkPolicy` resources by running `calicoctl get NetworkPolicy -A -o wide`. In the output, check if the namespace for each policy still exists in your cluster. You can list existing namespaces by running `kubectl get namespaces`. If any policy is scoped to a non-existent namespace, delete the policy by running `calicoctl delete networkpolicy <policy_name> -n <namespace>`.  \n - As part of the update to KDD and going forward, access to the `etcd` port in the cluster master is blocked. If you use the `etcd` port, such as in firewall rules or Calico policies that allow worker nodes to access `etcd`, update these resources to use the `apiserver` port instead. To get the `apiserver` port, run `ibmcloud ks cluster get -c <cluster_name_or_ID>` and look for the node port that is listed for the **Master URL**.  \n - Complete the steps in [Releasing individual IP addresses](/docs/containers?topic=containers-ts-app-container-start#individual-ips) to ensure that any pod IP addresses that are incorrectly detected as in use by the Calico IP address manager (IPAM) are released. |
| **Unsupported:** CoreDNS `federations` plug-in | CoreDNS version 1.7 and later no longer support the `federations` plug-in. If you customized your CoreDNS configuration to use this plug-in, you must remove the plug-in and any related configurations before updating. For more information about updating your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| **Unsupported:** Select CoreDNS metrics | CoreDNS version 1.7 and later [metrics changed](https://coredns.io/2020/06/15/coredns-1.7.0-release/#metric-changes){: external}. If you rely on these changed metrics, update accordingly. For example, you might update a Prometheus query of CoreDNS metrics to handle both the old and new metrics. |
| **Unsupported:** Select Kubernetes API server metrics | The following Kubernetes API service metric label names for `kubernetes_build_info` changed. These metrics, available via the `/metrics` endpoint, changed as follows. If you rely on these changed metrics, update accordingly.  \n - From `gitVersion` to `git_version`  \n - From `gitCommit` to `git_commit`  \n - From `gitTreeState` to `git_tree_state`  \n - From `buildDate` to `build_date`  \n - From `goVersion` to `go_version`. |
{: caption="Changes to make before you update the master to Kubernetes 1.19" caption-side="bottom"}

### Update after master
{: #119_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| ---- | ---------- |
| Calico data store driver change | When you update your cluster to version 1.19, Calico is updated to use Kubernetes data store driver (KDD). If you have any automation that depends on the Calico configuration file for your cluster, first download the new KDD-based Calico configuration file by running `ibmcloud ks cluster config -c <cluster_name_or_ID> --network`. Then, update your automation to use the new Calico configuration file. Additionally, because worker nodes can no longer access etcd with admin keys, ensure that you update your worker nodes so that the previous etcd secrets are removed. |
| Certificate signing request (CSR) | The `CertificateSigningRequest` API is promoted to `certificates.k8s.io/v1`. You can use the `CertificateSigningRequest` API to generate server certificates that are signed by the cluster certificate authority (CA) for TLS communication within the cluster. For more details, see the [Kubernetes version 1.19 changelog](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.19.md#api-change-1){: external} and [Kubernetes CSR documentation](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/){: external}. If you are currently using the `v1beta CertificateSigningRequest` API, make the following changes before you update to `v1`. For an example, see [Manage TLS Certificates in a Cluster](https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/){: external}.  \n - The Kubernetes `CertificateSigningRequest` API includes a mandatory `signerName` field. Use `kubernetes.io/kubelet-serving` when you create server certificates.  \n - The CSR subjects must include `organizations` that are exactly `["system:nodes"]`.  \n - The CSR common name must start with `system:node:`.  \n - The CSR subject alternative names must include the service or pod DNS hosts names and IP addresses that are used to connect to the server.|
| CoreDNS pod autoscaling configuration | Kubernetes DNS autoscaler configuration is updated to include unschedulable worker nodes in scaling calculations. To improve cluster DNS availability, you can set the `"includeUnschedulableNodes":true` parameter when [Autoscaling the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_autoscale). |
| Ingress resource fields | In the Ingress resource definition, several fields are changed, including the API version, service name, and service port, and added the `pathType` field. To update your Ingress resources to the new format, see the example YAML file in the documentation for the [community Kubernetes Ingress setup](/docs/containers?topic=containers-ingress-types#alb-comm-create). |
| Kubernetes `seccomp` support graduates to general availability (GA) | The support for `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io/...` annotations are now deprecated, and are planned for removal in Kubernetes version 1.22. A `seccompProfile` field is now added to the pod and container `securityContext` objects. The Kubernetes version skew handling automatically converts the new field into the annotations and vice versa. You don't have to change your existing workloads, but you can begin the conversion in preparation for the removal of the annotations before version 1.22. For more information, see [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/){: external}. |
| **Unsupported:** `kubectl apply --server-dry-run` removed | The deprecated `--server-dry-run` option is removed from the `kubectl apply` command. If your scripts rely on this flag, update them to use the `--dry-run=server` option instead. |
| **Unsupported:** `kubectl get --export` removed | The deprecated `--export` option is removed from the `kubectl get` command. If your scripts rely on this flag, refer to the [Deprecate --export option from get command pull request](https://github.com/kubernetes/kubernetes/pull/73787){: external} issue for discussion and references to scripts that handle various use cases. |
| `kubectl --output jsonpath` format changes  | The `kubectl get` `--o jsonpath` (or `-o jsonpath`) option now returns a JSON object for complex types such as structs, arrays, and slices. Previously, the option returned output in `go` format. If you use `kubectl get` to retrieve such fields using `--output jsonpath`, update your scripts to handle JSON objects. You might try using the `-o go-template` option to maintain compatibility with the previous behavior. |
| Temporary `kubectl` latency | RBAC operations are now performed asynchronously. After you run `ibmcloud ks cluster config` for the first time after the update, `kubectl` commands might fail for a few seconds while RBAC synchronizes for the first time. Afterward, `kubectl` commands perform as expected. If you use automation to access the cluster with `kubectl` commands, add retry logic for `kubectl` commands after a `kubeconfig` file is successfully retrieved. |
| **Unsupported:** Select `kubelet` metrics | The following `kubelet` metrics that were available via the `/metrics` and `/metrics/resource` endpoints are unsupported and removed. If you use any of these removed and deprecated `kubelet` metrics, change to use the available replacement metric.  \n - From `kubelet_running_container_count` to `kubelet_running_containers`  \n - From `kubelet_running_pod_count` to `kubelet_running_pods`  \n - From `node_cpu_usage_seconds` to `node_cpu_usage_seconds_total`  \n - From `container_cpu_usage_seconds` to `container_cpu_usage_seconds_total`. |
| **Unsupported:** Select `kube-proxy` metrics | The following `kube-proxy` metric label names for `kubernetes_build_info`, available via the `/metrics` endpoint, are changed. If you rely on these changed metrics, update accordingly.  \n - From `gitVersion` to `git_version`  \n - From `gitCommit` to `git_commit`  \n - From `gitTreeState` to `git_tree_state`  \n - From `buildDate` to `build_date`  \n - From `goVersion` to `go_version` |
{: caption="Changes to make after you update the master to Kubernetes 1.19" caption-side="bottom"}

### Update after worker nodes
{: #119_after_worker}

The following table shows the actions that you must take after you update your worker nodes.
{: shortdesc}

| Type | Description|
| ---- | ---------- |
| **Deprecated:** Beta worker node labels | The following beta worker node labels are deprecated and replaced. For now, both sets of labels are supported, but update your workloads to use the new labels, such as in affinity rules for deployments.  \n - From `beta.kubernetes.io/os` to `kubernetes.io/os`  \n - From `beta.kubernetes.io/arch` to `kubernetes.io/arch`  \n - From `failure-domain.beta.kubernetes.io/zone` to `topology.kubernetes.io/zone`  \n - From `failure-domain.beta.kubernetes.io/region` to `topology.kubernetes.io/region`  \n - From `beta.kubernetes.io/instance-type` to `node.kubernetes.io/instance-type` |
{: caption="Changes to make after you update the worker nodes to Kubernetes 1.19" caption-side="bottom"}



