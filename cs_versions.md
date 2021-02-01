---

copyright:
  years: 2014, 2021
lastupdated: "2021-02-01"

keywords: kubernetes, iks, versions, update, upgrade

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:api: .ph data-hd-interface='api'}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift-ios: .ph data-hd-programlang='iOS Swift'}
{:swift-server: .ph data-hd-programlang='server-side Swift'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vbnet: .ph data-hd-programlang='vb.net'}
{:video: .video}



# Kubernetes version information and update actions   
{: #cs_versions}

Review information about supported Kubernetes versions for {{site.data.keyword.containerlong}} clusters.
{: shortdesc}

For more information about the Kubernetes project versions, see the Kubernetes changelog.
* [Kubernetes 1.19 release notes](https://kubernetes.io/docs/setup/release/notes/){: external}
* [Kubernetes 1.18 release notes](https://v1-18.docs.kubernetes.io/docs/setup/release/notes/){: external}
* [Kubernetes 1.17 release notes](https://v1-17.docs.kubernetes.io/docs/setup/release/notes/){: external}
* [Kubernetes changelogs](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG){: external}

## Update types
{: #update_types}

Your Kubernetes cluster has three types of updates: major, minor, and patch. As updates become available, you are notified when you view information about the cluster master or worker nodes, such as with the `ibmcloud ks cluster ls`, `cluster get`, `worker ls`, or `worker get` commands.
{: shortdesc}

|Update type|Examples of version labels|Updated by|Impact
|-----|-----|-----|-----|
|Major|1.x.x|You|Operation changes for clusters, including scripts or deployments.|
|Minor|x.19.x|You|Operation changes for clusters, including scripts or deployments.|
|Patch|x.x.4_1510|IBM and you|Kubernetes patches, as well as other {{site.data.keyword.cloud_notm}} Provider component updates such as security and operating system patches. IBM updates masters automatically, but you apply patches to worker nodes. See more about patches in the following section.|
{: caption="Impacts of Kubernetes updates" caption-side="top"}

<dl>
  <dt>Major and minor updates (1.x)</dt>
    <dd>First, [update your master node](/docs/containers?topic=containers-update#master) and then [update the worker nodes](/docs/containers?topic=containers-update#worker_node).
    <ul><li>You cannot update a Kubernetes master two or more minor versions ahead (n+2). For example, if your current master is version 1.17 and you want to update to 1.19, you must update to 1.18 first.</li>
    <li>Worker nodes cannot run a Kubernetes major or minor version that is greater than the masters. Additionally, your worker nodes can be only up to two versions behind the master version (`n-2`).</li>
    <li>If you use a `kubectl` CLI version that does not match at least the `major.minor` version of your clusters, you might experience unexpected results. Make sure to keep your Kubernetes cluster and [CLI versions](/docs/containers?topic=containers-cs_cli_install#kubectl) up-to-date.</li></ul></dd>
  <dt>Patch updates (x.x.4_1510)</dt>
    <dd>Changes across patches are documented in the [Version changelog](/docs/containers?topic=containers-changelog). Master patches are applied automatically, but you initiate worker node patches updates. Worker nodes can also run patch versions that are greater than the masters. As updates become available, you are notified when you view information about the master and worker nodes in the {{site.data.keyword.cloud_notm}} console or CLI, such as with the following commands: `ibmcloud ks cluster ls`, `cluster get`, `worker ls`, or `worker get`.<br>
    Patches can be for worker nodes, masters, or both.
    <ul><li>**Worker node patches**: Check monthly to see whether an update is available, and use the `ibmcloud ks worker update` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) or the `ibmcloud ks worker reload` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) to apply these security and operating system patches. During an update or reload, your worker node machine is reimaged, and data is deleted if not [stored outside the worker node](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).</li>
    <li>**Master patches**: Master patches are applied automatically over the course of several days, so a master patch version might show up as available before it is applied to your master. The update automation also skips clusters that are in an unhealthy state or have operations currently in progress. Occasionally, IBM might disable automatic updates for a specific master fix pack, as noted in the changelog, such as a patch that is only needed if a master is updated from one minor version to another. In any of these cases, you can choose to safely use the `ibmcloud ks cluster master update` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update) yourself without waiting for the update automation to apply.</li></ul></dd>
</dl>

## Kubernetes versions
{: #version_types}

{{site.data.keyword.containerlong_notm}} concurrently supports multiple versions of Kubernetes. When a latest version (`n`) is released, versions up to 2 behind (`n-2`) are supported. Versions more than 2 behind the latest (`n-3`) are first deprecated and then unsupported. For more information, see [Release lifecycle](#release_lifecycle).
{: shortdesc}

To continue receiving important security patch updates, make sure that your clusters run a supported Kubernetes version at all times. Deprecated clusters might not receive security updates.
{: important}

Review the supported versions of {{site.data.keyword.containerlong_notm}}. In the CLI, you can run `ibmcloud ks versions`.

**Supported Kubernetes versions**:
*   Latest: 1.19.7
*   Default: 1.18.15
*   Other: 1.17.17

**Deprecated and unsupported Kubernetes versions**:
*   Deprecated: 1.16.15
*   Unsupported: 1.5, 1.7, 1.8, 1.9, 1.10, 1.11, 1.12, 1.13, 1.14, 1.15

<br>

To check the server version of a cluster, log in to the cluster and run the following command.
```
kubectl version  --short | grep -i server
```
{: pre}

Example output:
```
Server Version: v1.18.15+IKS
```
{: screen}

## Release history
{: #release-history}
{: help}
{: support}

The following table records {{site.data.keyword.containerlong_notm}} version release history. You can use this information for planning purposes, such as to estimate general time frames when a certain release might become unsupported. After the Kubernetes community releases a version update, the IBM team begins a process of hardening and testing the release for {{site.data.keyword.containerlong_notm}} environments. Availability and unsupported release dates depend on the results of these tests, community updates, security patches, and technology changes between versions. Plan to keep your cluster master and worker node version up-to-date according to the `n-2` version support policy.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} was first generally available with Kubernetes version 1.5. Projected release or unsupported dates are subject to change. To go to the version update preparation steps, click the version number.

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

<table summary="This table shows the release history for {{site.data.keyword.containerlong_notm}}.">
<caption>Release history for {{site.data.keyword.containerlong_notm}}.</caption>
<col width="20%" align="center">
<col width="20%">
<col width="30%">
<col width="30%">
<thead>
<tr>
<th>Supported?</th>
<th>Version</th>
<th>{{site.data.keyword.containerlong_notm}}<br>release date</th>
<th>{{site.data.keyword.containerlong_notm}}<br>unsupported date</th>
</tr>
</thead>
<tbody>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="This version is supported."/></td>
  <td>[1.19](#cs_v119)</td>
  <td>13 Oct 2020</td>
  <td>Oct 2021 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="This version is supported."/></td>
  <td>[1.18](#cs_v118)</td>
  <td>11 May 2020</td>
  <td>Jun 2021 `†`</td>
</tr>
  <tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="This version is supported."/></td>
  <td>[1.17](#cs_v117)</td>
  <td>10 Feb 2020</td>
  <td>Mar 2021 `†`</td>
</tr>
  <tr>
  <td><img src="images/warning-filled.png" align="left" width="32" style="width:32px;" alt="This version is deprecated."/></td>
  <td>[1.16](#cs_v116)</td>
  <td>04 Nov 2019</td>
  <td>31 Jan 2021</td>
</tr>
  <tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.15](#cs_v115)</td>
  <td>05 Aug 2019</td>
  <td>22 Sep 2020</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.14](#cs_v114)</td>
  <td>07 May 2019</td>
  <td>31 May 2020</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.13](#cs_v113)</td>
  <td>05 Feb 2019</td>
  <td>22 Feb 2020</td>
</tr>
  <tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.12](#cs_v112)</td>
  <td>07 Nov 2018</td>
  <td>03 Nov 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.11](#cs_v111)</td>
  <td>14 Aug 2018</td>
  <td>20 Jul 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.10](#cs_v110)</td>
  <td>01 May 2018</td>
  <td>16 May 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.9](#cs_v19)</td>
  <td>08 Feb 2018</td>
  <td>27 Dec 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.8](#cs_v18)</td>
  <td>08 Nov 2017</td>
  <td>22 Sep 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.7](#cs_v17)</td>
  <td>19 Sep 2017</td>
  <td>21 Jun 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>1.6</td>
  <td>N/A</td>
  <td>N/A</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="This version is unsupported."/></td>
  <td>[1.5](#cs_v1-5)</td>
  <td>23 May 2017</td>
  <td>04 Apr 2018</td>
</tr>
</tbody>
</table>

## Release lifecycle
{: #release_lifecycle}

{{site.data.keyword.containerlong_notm}} concurrently supports select versions of community Kubernetes releases. When a latest community version is released, {{site.data.keyword.containerlong_notm}} deprecates its oldest supported version (`n-3`) and begins preparing to release the version of the community release.
{: shortdesc}

Each supported version of {{site.data.keyword.containerlong_notm}} goes through a lifecycle of testing, development, general release, support, deprecation, and becoming unsupported. Review the following diagram to understand how the community Kubernetes and {{site.data.keyword.cloud_notm}} provider version lifecycles interact across time.

![Diagram of the lifecycle of community Kubernetes and supported {{site.data.keyword.cloud_notm}} releases across time](images/version_flowchart_kube.png)

Estimated days and versions are provided for general understanding. Actual availability and release dates are subject to change and depend on various factors, such as community updates, security patches, and technology changes between versions.
{: note}

1.  The Kubernetes community releases version `n`. IBM engineers begin a process of testing and hardening the community version in preparation to release a supported {{site.data.keyword.containerlong_notm}} version.
2.  Version `n` is released as the latest supported {{site.data.keyword.containerlong_notm}} version.
3.  Version `n` becomes the default supported {{site.data.keyword.containerlong_notm}} version.
4.  Version `n` becomes the oldest supported {{site.data.keyword.containerlong_notm}} version.
5.  Version `n` is deprecated, and security patch updates might not be provided. Depending on the community release cycle and version testing, you have 45 days or less until the next phase of deprecation starts in step 6. During the deprecation period, your cluster is still functional, but might require updating to a supported release to fix security vulnerabilities. For example, you can add and reload worker nodes.
6.  You receive a notification in the console and CLI that you have 45 days to update your cluster to a supported version before version `n` becomes unsupported. Similar to step 5, your cluster is still functional, but might require updating to a supported release to fix security vulnerabilities.
7.  Version `n` is unsupported. Review the following potential impacts and then immediately [update the cluster](/docs/containers?topic=containers-update#update) to continue receiving important security updates and support. Unsupported clusters cannot add or reload existing worker nodes, and you cannot create clusters at an unsupported version.
8. The cluster master runs two or more versions behind the oldest supported version. You cannot update the cluster. Delete the cluster, and create a new one.

If you wait until your cluster is two or more minor versions behind the oldest supported version, you cannot update the cluster. Instead, [create a new cluster](/docs/containers?topic=containers-clusters#clusters), [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster, and [delete](/docs/containers?topic=containers-remove) the unsupported cluster.<br><br>To avoid this issue, update deprecated clusters to a supported version less than two ahead of the current version, such as 1.17 to 1.18 and then update to the latest version, 1.19. If the worker nodes run a version two or more behind the master, you might see your pods fail by entering a state such as `MatchNodeSelector`, `CrashLoopBackOff`, or `ContainerCreating` until you update the worker nodes to the same version as the master. After you update from a deprecated to a supported version, your cluster can resume normal operations and continue receiving support.<br><br>You can find out whether your cluster is **unsupported** by reviewing the **State** field in the output of the `ibmcloud ks cluster ls` command or in the [{{site.data.keyword.containerlong_notm}} console](https://cloud.ibm.com/kubernetes/clusters){: external}.
{: important}

<br />

## Preparing to update
{: #prep-up}
This information summarizes updates that are likely to have impact on deployed apps when you update a cluster to a new version from the previous version. For a complete list of changes, review the [community Kubernetes changelogs](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG), [IBM version changelogs](/docs/containers?topic=containers-changelog){: external}, and [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

-  Version 1.19 [preparation actions](#cs_v119).
-  Version 1.18 [preparation actions](#cs_v118).
-  Version 1.17 [preparation actions](#cs_v117).
-  [Archive](#k8s_version_archive) of unsupported versions.

<br />

## Version 1.19
{: #cs_v119}

<p><img src="images/certified_kubernetes_1x19.png" style="padding-right: 10px;" align="left" alt="This badge indicates Kubernetes version 1.19 certification for {{site.data.keyword.containerlong_notm}}."/> {{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.19 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._</p>

Review changes that you might need to make when you update from the previous Kubernetes version to 1.19.
{: shortdesc}

### Update before master
{: #119_before}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| ---- | ---------- |
| Calico data store driver change | When you update your cluster to version 1.19, Calico is updated to use Kubernetes data store driver (KDD). During the update, you can request resources that require Calico, such as pods that are subject to Calico policies, but the resources remain pending until the update is complete. As part of the update and going forward, access to the `etcd` port in the cluster master is blocked. If you use the `etcd` port, such as in firewall rules or Calico policies that allow worker nodes to access `etcd`, update these resources to use the `apiserver` port instead. To get the `apiserver` port, run `ibmcloud ks cluster get -c <cluster_name_or_ID>` and look for the node port that is listed for the **Master URL**. |
| **Unsupported:** CoreDNS `federations` plug-in | CoreDNS version 1.7 and later no longer support the `federations` plug-in. If you customized your CoreDNS configuration to use this plug-in, you must remove the plug-in and any related configurations before updating. For more information about updating your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| **Unsupported:** Select CoreDNS metrics | CoreDNS version 1.7 and later [metrics changed](https://coredns.io/2020/06/15/coredns-1.7.0-release/#metric-changes){: external}. If you rely on these changed metrics, update accordingly. For example, you might update a Prometheus query of CoreDNS metrics to handle both the old and new metrics. |
| **Unsupported:** Select Kubernetes API server metrics | The following Kubernetes API service metric label names for `kubernetes_build_info` changed. These metrics, available via the `/metrics` endpoint, changed as follows. If you rely on these changed metrics, update accordingly.<ul><li>From `gitVersion` to `git_version`</li><li>From `gitCommit` to `git_commit`</li><li>From `gitTreeState` to `git_tree_state`</li><li>From `buildDate` to `build_date`</li><li>From `goVersion` to `go_version`</li></ul>. |
{: caption="Changes to make before you update the master to Kubernetes 1.19" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

### Update after master
{: #119_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| ---- | ---------- |
| Calico data store driver change | When you update your cluster to version 1.19, Calico is updated to use Kubernetes data store driver (KDD). If you have any automation that depends on the Calico configuration file for your cluster, first download the new KDD-based Calico configuration file by running `ibmcloud ks cluster config -c <cluster_name_or_ID> --network`. Then, update your automation to use the new Calico configuration file. Additionally, because worker nodes can no longer access etcd with admin keys, ensure that you update your worker nodes so that the previous etcd secrets are removed. |
| CoreDNS pod autoscaling configuration | Kubernetes DNS autoscaler configuration is updated to include unscheduable worker nodes in scaling calculations. To improve cluster DNS availability, you can set the `"includeUnschedulableNodes":true` parameter when [Autoscaling the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_autoscale). |
| Ingress resource fields | In the Ingress resource definition, several fields are changed, including the API version, service name, and service port, and added the `pathType` field. To update your Ingress resources to the new format, see the example YAML file in the documentation for the [community Kubernetes Ingress setup](/docs/containers?topic=containers-ingress-types#alb-comm-create) or for the [deprecated custom {{site.data.keyword.containerlong_notm}} Ingress setup](/docs/containers?topic=containers-ingress#public_inside_4). |
| Kubernetes `seccomp` support graduates to general availability (GA) | The support for `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io/...` annotations are now deprecated, and are planned for removal in Kubernetes version 1.22. A `seccompProfile` field is now added to the pod and container `securityContext` objects. The Kubernetes version skew handling automatically converts the new field into the annotations and vice versa. You do not have to change your existing workloads, but you can begin the conversion in preparation for the removal of the annotations before version 1.22. For more information, see [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/){: external}. |
| **Unsupported:** `kubectl apply --server-dry-run` removed | The deprecated `--server-dry-run` flag is removed from the `kubectl apply` command. If your scripts rely on this flag, update them to use the `--dry-run=server` flag instead. |
| **Unsupported:** `kubectl get --export` removed | The deprecated `--export` flag is removed from the `kubectl get` command. If your scripts rely on this flag, refer to the [Deprecate --export flag from get command pull request](https://github.com/kubernetes/kubernetes/pull/73787){: external} issue for discussion and references to scripts that handle various use cases. |
| `kubectl --output jsonpath` format changes  | The `kubectl get` `--o jsonpath` (or `-o jsonpath`) option now returns a JSON object for complex types such as structs, arrays, and slices. Previously, the option returned output in `go` format. If you use `kubectl get` to retrieve such fields using `--output jsonpath`, update your scripts to handle JSON objects. You might try using the `-o go-template` option to maintain compatibility with the previous behavior. |
| Temporary `kubectl` latency | RBAC operations are now performed asynchronously. After you run `ibmcloud ks cluster config` for the first time after the update, `kubectl` commands might fail for a few seconds while RBAC synchronizes for the first time. Afterward, `kubectl` commands perform as expected. If you use automation to access the cluster with `kubectl` commands, add retry logic for `kubectl` commands after a `kubeconfig` file is successfully retrieved. |
| **Unsupported:** Select `kubelet` metrics | The following `kubelet` metrics that were available via the `/metrics` and `/metrics/resource` endpoints are unsupported and removed. If you use any of these removed and deprecated `kubelet` metrics, change to use the available replacement metric.<ul><li>From `kubelet_running_container_count` to `kubelet_running_containers`</li><li>From `kubelet_running_pod_count` to `kubelet_running_pods`</li><li>From `node_cpu_usage_seconds` to `node_cpu_usage_seconds_total`</li><li>From `container_cpu_usage_seconds` to `container_cpu_usage_seconds_total`</li></ul>. |
| **Unsupported:** Select `kube-proxy` metrics | The following `kube-proxy` metric label names for `kubernetes_build_info`, available via the `/metrics` endpoint, are changed. If you rely on these changed metrics, update accordingly.<ul><li>From `gitVersion` to `git_version`</li><li>From `gitCommit` to `git_commit`</li><li>From `gitTreeState` to `git_tree_state`</li><li>From `buildDate` to `build_date`</li><li>From `goVersion` to `go_version`</li></ul> |
{: caption="Changes to make after you update the master to Kubernetes 1.19" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

### Update after worker nodes
{: #119_after_worker}

The following table shows the actions that you must take after you update your worker nodes.
{: shortdesc}

| Type | Description|
| ---- | ---------- |
| **Deprecated:** Beta worker node labels | The following beta worker node labels are deprecated and replaced. For now, both sets of labels are supported, but update your workloads to use the new labels, such as in affinity rules for deployments.<ul><li>From `beta.kubernetes.io/os` to `kubernetes.io/os`</li><li>From `beta.kubernetes.io/arch` to `kubernetes.io/arch`</li><li>From `failure-domain.beta.kubernetes.io/zone` to `topology.kubernetes.io/zone`</li><li>From `failure-domain.beta.kubernetes.io/region` to `topology.kubernetes.io/region`</li><li>From `beta.kubernetes.io/instance-type` to `node.kubernetes.io/instance-type`</li></ul> |
{: caption="Changes to make after you update the worker nodes to Kubernetes 1.19" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

<br />

## Version 1.18
{: #cs_v118}

<p><img src="images/certified_kubernetes_1x18.png" style="padding-right: 10px;" align="left" alt="This badge indicates Kubernetes version 1.18 certification for {{site.data.keyword.containerlong_notm}}."/> {{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.18 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._</p>

Review changes that you might need to make when you update from the previous Kubernetes version to 1.18.
{: shortdesc}

### Update before master
{: #118_before}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| Add-ons and plug-ins | For each add-on and plug-in that you installed in your cluster, check for any impacts that might be caused by updating the cluster version. For instructions, see [Steps to update the cluster master](/docs/containers?topic=containers-update#master-steps) and refer to the add-on and plug-in documentation. |
| **Unsupported:** CoreDNS `federations` plug-in | CoreDNS version 1.7 and later no longer support the `federations` plug-in. If you customized your CoreDNS configuration to use this plug-in, you must remove the plug-in and any related configurations before updating. For more information about updating your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| **Unsupported:** Select CoreDNS metrics | CoreDNS version 1.7 and later [metrics changed](https://coredns.io/2020/06/15/coredns-1.7.0-release/#metric-changes){: external}. If you rely on these changed metrics, update accordingly. For example, you might update a Prometheus query of CoreDNS metrics to handle both the old and new metrics. |
| **Unsupported:** Select `kubelet` metrics | The following `kubelet` metrics that were available via the `/metrics` endpoint are unsupported and removed. If you use any of these [removed and deprecated kubelet metrics](https://kubernetes.io/docs/setup/release/notes/#client-go){: external}, change to use the available replacement metric: `kubelet_cgroup_manager_latency_microseconds`, `kubelet_cgroup_manager_latency_microseconds_count`, `kubelet_cgroup_manager_latency_microseconds_sum`, `kubelet_pleg_relist_interval_microseconds`, `kubelet_pleg_relist_interval_microseconds_count`, `kubelet_pleg_relist_interval_microseconds_sum`, `kubelet_pleg_relist_latency_microseconds`, `kubelet_pleg_relist_latency_microseconds_count`, `kubelet_pleg_relist_latency_microseconds_sum`, `kubelet_pod_start_latency_microseconds`, `kubelet_pod_start_latency_microseconds_count`, `kubelet_pod_start_latency_microseconds_sum`, `kubelet_pod_worker_latency_microseconds`, `kubelet_pod_worker_latency_microseconds_count`, `kubelet_pod_worker_latency_microseconds_sum`, `kubelet_pod_worker_start_latency_microseconds`, `kubelet_pod_worker_start_latency_microseconds_count`, `kubelet_pod_worker_start_latency_microseconds_sum`, `kubelet_runtime_operations`, `kubelet_runtime_operations_errors`, `kubelet_runtime_operations_latency_microseconds`, `kubelet_runtime_operations_latency_microseconds_count`, `kubelet_runtime_operations_latency_microseconds_sum` |
| **Unsupported:** Kubernetes API `batch/v2alpha1` | Kubernetes API `batch/v2alpha1` is no longer supported. If your apps rely on this API, update them to use `batch/v1beta1` instead. |
{: caption="Changes to make before you update the master to Kubernetes 1.18" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

### Update after master
{: #118_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| Registry image pull secret includes all domains | Previously, separate image pull secrets were created for each regional, public `icr.io` registry domain to enable your cluster to [pull images from {{site.data.keyword.registrylong_notm}}](/docs/containers?topic=containers-registry#cluster_registry_auth). Now, all the public and private `icr.io` registry domains for all regions are stored in a single `all-icr-io` image pull secret that is automatically created in the `default` namespace. Update your apps to use the new single `all-icr-io` image pull secret. |
| `kubectl diff` return code | The [`kubectl diff` command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#diff){: external} now returns `0` when no differences are found, `1` when differences are found, and greater than `1` when an error occurs. If your scripts rely on the previous return code behavior, update them. |
| `kubectl get` includes `managedFields` | The [Server Side Apply](https://kubernetes.io/docs/reference/using-api/api-concepts/#server-side-apply){: external} feature adds the `managedFields` field that is part of a resource's `metadata`.  If your scripts use `grep`, `awk`, or similar commands to parse the output of the `kubectl get` command, update your scripts to handle the addition of `managedFields`. For example, you might select fields by using the `kubectl get <resource> -o jsonpath` command or by using the [`jq` package](https://stedolan.github.io/jq/){: external} to parse the JSON output from the `kubectl get <resource> -o json` command. |
| **Unsupported:** `kubectl rolling-update` | The `kubectl rolling-update` command is removed. If your scripts rely on this command, update them to use the [`kubectl rollout` command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#rollout){: external} instead. |
| **Unsupported:** `kubectl run` removed deprecated flags | The [`kubectl run` command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run){: external} removed deprecated flags that are not used to create pods. If your scripts use `kubectl run` to create resources other than pods, such as deployments, update them to use the `kubectl create` or `kubectl apply` commands instead. |
| Kubernetes `Go` client updates | The Kubernetes `Go` client, `k8s.io/client-go` version 0.18.0 and later, is updated.  Signatures on methods in generated `clientsets`, `dynamic`, `metadata`, and `scale` clients are modified to accept `context.Context` as a first argument. Signatures of `Create`, `Update`, and `Patch` methods are updated to accept `CreateOptions`, `UpdateOptions` and `PatchOptions` respectively. Signatures of `Delete` and `DeleteCollection` methods now accept `DeleteOptions` by value instead of by reference. Generated `clientsets` with the previous interface are added in new `deprecated` packages to allow incremental migration to the new APIs. The `deprecated` packages are scheduled to be removed in the Kubernetes version 1.21 release. For help to rewrite method invocations with the new signatures, try the [`clientgofix` tool](http://sigs.k8s.io/clientgofix){: external}. |
| Temporary `kubectl` latency | RBAC operations are now performed asynchronously. After you run `ibmcloud ks cluster config` for the first time after the update, `kubectl` commands might fail for a few seconds while RBAC synchronizes for the first time. Afterward, `kubectl` commands perform as expected. If you use automation to access the cluster with `kubectl` commands, add retry logic for `kubectl` commands after a `kubeconfig` file is successfully retrieved. |
| **Unsupported**: `kubelet` statistics | The `kubelet` statistics that were available via the `/stats` endpoint are unsupported and removed. The cluster insights panel in the cluster console no longer reports statistics from this endpoint. |
{: caption="Changes to make after you update the master to Kubernetes 1.18" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

### Update after worker nodes
{: #118_after_worker}

The following table shows the actions that you must take after you update your worker nodes.
{: shortdesc}

| Type | Description|
| --- | --- |
| Format of the `CPUManager` state file | The format of the [`CPUManager`](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/){: external} state file is changed. Update any tools that rely on previous format. |
{: caption="Changes to make after you update the worker nodes to Kubernetes 1.18" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

<br />

## Version 1.17
{: #cs_v117}

<p><img src="images/certified_kubernetes_1x17.png" style="padding-right: 10px;" align="left" alt="This badge indicates Kubernetes version 1.17 certification for {{site.data.keyword.containerlong_notm}}."/> {{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.17 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._</p>

Review changes that you might need to make when you update from the previous Kubernetes version to 1.17.
{: shortdesc}

### Update before master
{: #117_before}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description |
| ---- | ----------- |
| Add-ons and plug-ins | For each add-on and plug-in that you installed in your cluster, check for any impacts that might be caused by updating the cluster version. For instructions, see [Steps to update the cluster master](/docs/containers?topic=containers-update#master-steps) and refer to the add-on and plug-in documentation. |
| **Unsupported:** CoreDNS `federations` plug-in | CoreDNS version 1.7 and later no longer support the `federations` plug-in. If you customized your CoreDNS configuration to use this plug-in, you must remove the plug-in and any related configurations before updating. For more information about updating your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| **Unsupported:** Select CoreDNS metrics | CoreDNS version 1.7 and later [metrics changed](https://coredns.io/2020/06/15/coredns-1.7.0-release/#metric-changes){: external}. If you rely on these changed metrics, update accordingly. For example, you might update a Prometheus query of CoreDNS metrics to handle both the old and new metrics. |
| **Gateway-enabled clusters only**: Public traffic is blocked on node ports | If you have a gateway-enabled cluster and use a public node port to expose your app, public traffic on the node port is now blocked by default. Instead, use a [load balancer service](/docs/containers?topic=containers-loadbalancer-qs) or [create a preDNAT Calico policy](/docs/containers?topic=containers-policy_tutorial) with an order number that is lower than `1800` and with a selector `ibm.role == 'worker_public'` so that public traffic is explicitly allowed to the node port. |
| Removed Kubernetes built-in cluster roles | Kubernetes built-in `system:csi-external-provisioner` and `system:csi-external-attacher` cluster roles are removed. Update any role or cluster role bindings that rely on these built-in cluster roles to use different cluster roles. |
| **Unsupported:** Select Kubernetes API server metrics | The following Kubernetes API service metrics available via the `/metrics` endpoint are unsupported and removed. If you use any of these [removed and deprecated Kubernetes metrics](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.14.md#removed-and-deprecated-metrics){: external}, change to the available replacement metric.<ul><li>`apiserver_request_count`</li><li>`apiserver_request_latencies`</li><li> `apiserver_request_latencies_summary`</li><li>`apiserver_dropped_requests`</li><li>`etcd_request_latencies_summary`</li><li>`apiserver_storage_transformation_latencies_microseconds`</li><li>`apiserver_storage_data_key_generation_latencies_microseconds`</li><li>`apiserver_storage_transformation_failures_total`</li><li>`rest_client_request_latency_seconds`</li></ul> |
{: caption="Changes to make before you update the master to Kubernetes 1.17" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}


### Update after master
{: #117_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description |
| ---- | ----------- |
| Kubernetes configuration | The OpenID Connect configuration for the cluster's Kubernetes API server now uses the {{site.data.keyword.iamlong}} (IAM) `iam.cloud.ibm.com` endpoint. As a result, you must refresh the cluster's Kubernetes configuration by using the [`ibmcloud ks cluster config` command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_config) after you update the master to Kubernetes version 1.17. If you continue to use an old Kubernetes configuration, you see an error message similar to the following: `You must be logged in to the server (Unauthorized).` |
| **Unsupported:** `kubectl` commands `--include-uninitialized` flag | The `kubectl` command `--include-uninitialized` flag is no longer supported. If your scripts rely on this flag, update them by removing the flag. |
{: caption="Changes to make after you update the master to Kubernetes 1.17" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

### Update after worker nodes
{: #117_after_worker}

The following table shows the actions that you must take after you update your worker nodes.
{: shortdesc}

| Type | Description |
| ---- | ----------- |
| **Unsupported or changed:** Select Kubernetes `kube-proxy` metrics | Select Kubernetes kube-proxy metrics available via the `/metrics` endpoint are unsupported or are changed. Update your `kube-proxy` metrics usage accordingly.<ul><li>**Removed**: The `kubeproxy_sync_proxy_rules_latency_microseconds` metric is removed.</li><li>**Changed**: The `sync_proxy_rules_last_timestamp_seconds` metric now updates only when services or endpoints change. To monitor for `iptables` update failures, use the `sync_proxy_rules_iptables_restore_failures_total` metric instead.</li></ul> |
{: caption="Changes to make after you update the worker nodes to Kubernetes 1.17" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

<br />

## Deprecated: Version 1.16
{: #cs_v116}

<p><img src="images/certified_kubernetes_1x16.png" style="padding-right: 10px;" align="left" alt="This badge indicates Kubernetes version 1.16 certification for {{site.data.keyword.containerlong_notm}}."/> {{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.16 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._</p>

Review changes that you might need to make when you update from the previous Kubernetes version to 1.16.
{: shortdesc}

Kubernetes version 1.16 is deprecated, and becomes unsupported on 31 January 2021. [Update your clusters](/docs/containers?topic=containers-update) to at least Kubernetes version 1.17 as soon as possible.
{: deprecated}

### Update before master
{: #116_before}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description |
| ---- | ----------- |
| Add-ons and plug-ins | For each add-on and plug-in that you installed in your cluster, check for any impacts that might be caused by updating the cluster version. For instructions, see [Steps to update the cluster master](/docs/containers?topic=containers-update#master-steps) and refer to the add-on and plug-in documentation. |
| **Unsupported**: Deprecated Kubernetes APIs are removed |<p class="important">Kubernetes version 1.16 removes several common, deprecated APIs. Follow the [blog update tips](https://www.ibm.com/cloud/blog/announcements/kubernetes-version-1-16-removes-deprecated-apis){: external}, then take the following steps to mitigate impact to your Kubernetes resources.</p><ol><li>Update the configuration files for any impacted Kubernetes resources, such as daemon sets, deployments, replica sets, stateful sets, pod security policies, and network policies.</li><li>If you [add services to your cluster by using Helm charts](/docs/containers?topic=containers-helm), update to Helm version 2.15.2 or later.</li><li>If you rely on the [Kubernetes dashboard](/docs/containers?topic=containers-deploy_app#cli_dashboard), prepare for a temporary outage during the master update.</li></ol> |
| Kubernetes scheduler events | The Kubernetes scheduler now sends events by using the `events.k8s.io/v1beta1` API. If your tooling targets events that are sent by the Kubernetes scheduler, update it to handle scheduling events with either the `core/v1` or `events.k8s.io/v1beta1` APIs. |
| **Unsupported**: Kubernetes annotation `scheduler.alpha.kubernetes.io/critical-pod` | Support for the `scheduler.alpha.kubernetes.io/critical-pod` annotation is removed. If your pods rely on this annotation, update the pods to use [pod priority](/docs/containers?topic=containers-pod_priority#pod_priority) instead. |
| CoreDNS configuration | CoreDNS version 1.6 no longer supports the `proxy` plug-in, which is replaced by the `forward` plug-in. In addition, the CoreDNS `kubernetes` plug-in no longer supports the `resyncperiod` option and ignores the `upstream` option. The Kubernetes 1.16 master update automatically migrates these unsupported and deprecated CoreDNS configurations. However, if you want to test any potential impact to your workloads, you can also update your CoreDNS configuration now. For more information about updating your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| CoreDNS minimum pods | To improve cluster DNS availability, you can [scale up the minimum number of CoreDNS pods to `3`](/docs/containers?topic=containers-cluster_dns#dns_autoscale). |
| **Unsupported**: KubeDNS cluster DNS provider | Since Kubernetes version 1.14, CoreDNS is the only supported cluster DNS provider for {{site.data.keyword.containerlong_notm}} clusters. With Kubernetes version 1.16, all KubeDNS resources that are provided by {{site.data.keyword.containerlong_notm}} are now removed. Change any apps or configurations that rely on the existence of these KubeDNS resources in the cluster. |
| Private network policy | The default private network policy is changed. If you created Calico private `HostEndpoints` and private network policies, see the following section about [Preparing private network policies](#116_networkpolicies). |
{: caption="Changes to make before you update the master to Kubernetes 1.16" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

### Update after master
{: #116_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description |
| ---- | ----------- |
| CoreDNS `cache` plug-in | CoreDNS caching is updated to better support older DNS clients. If you disabled the CoreDNS `cache` plug-in, you can now re-enable the plug-in. |
| Kubernetes Dashboard metrics | The latest Kubernetes Dashboard version works with `metrics-server` to display metrics in the Kubernetes Dashboard. If you deployed [Heapster](https://github.com/kubernetes-retired/heapster){: external} to your cluster to enable metrics in the Kubernetes Dashboard, you can now remove `heapster` to conserve cluster resources. |
| Connection between gateway-enabled clusters and classic virtual or bare metal server instances | [Update your server instance connection](/docs/containers?topic=containers-add_workers#update_connection) to use the latest latest version of the `ibm-external-compute-job.yaml` manifest file from the `IBM-Cloud/kube-samples/gateway-clusters` repository. |
| **Unsupported**: `kubectl cp` to copy symbolic links from containers | The `kubectl cp` command no longer supports copying symbolic links from containers. If your scripts rely on this, update them to use `kubectl exec` with `tar` instead. For an example, run `kubectl cp --help` in the `kubectl` 1.16 CLI version. |
| **Unsupported**: `kubectl log` | The `kubectl log` command is removed. If your scripts rely on this command, update them to use the `kubectl logs` command instead. |
| **Unsupported**: Prometheus queries that use `pod_name` and `container_name` labels | Update any Prometheus queries that match `pod_name` or `container_name` labels to use `pod` or `container` labels instead. Example queries that might use these deprecated labels include `kubelet` probe metrics. |
{: caption="Changes to make after you update the master to Kubernetes 1.16" caption-side="top"}
{: summary="The rows are read from left to right. The type of update action is in the first column, and a description of the update action type is in the second column."}

### Preparing private network policies
{: #116_networkpolicies}

Before you update the Kubernetes master, you might need to make changes to your Calico private network policies.
{: shortdesc}

To determine whether you must change your policies:

1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure) Include the `--admin` and `--network` options with the `ibmcloud ks cluster config` command. The `--admin` option downloads the infrastructure access keys to run Calico commands on your worker nodes. The `--network` option downloads the Calico configuration file to run all Calico commands.
  ```
  ibmcloud ks cluster config --cluster <cluster_name_or_ID> --admin --network
  ```
  {: pre}

2. Check whether you have any Calico host endpoints that use the `iks.worker.interface == 'private'` label. Previously, in version 1.15 clusters, the default `allow-all-private-default` private network policy used this host endpoint label. However, for version 1.16 clusters, the`allow-all-private-default` private network policy instead uses a new `ibm.role == 'worker_private'` label.
  ```
  calicoctl get hep -o yaml | grep 'iks.worker.interface.*private'
  ```
  {: pre}

  **Windows**: Use the `--config` flag to point to the network configuration file that you got in step 1: `calicoctl get hep -o yaml --config=<filepath>/calicoctl.cfg | grep 'iks.worker.interface.*private'`. Include this flag each time you run a `calicoctl` command.
  {: tip}
  * If no output is returned, continue to step 3.
  * If any host endpoints with this label are returned, then your default `allow-all-private-default` private network policy is replaced when you update the Kubernetes master to 1.16. If you use this policy to control traffic to your cluster on the private network, create a duplicate file of the `allow-all-private-default` policy and give the duplicate file a different name. After you create the duplicate file, apply it to your cluster. When the `allow-all-private-default` policy is modified during the upgrade to 1.16 to use the new label, your duplicate policy still exists and operates with the old label.

3. Check whether you have any Calico host endpoints that use the `ibm.role == 'worker_private'` label. For example, if you followed the steps in [Isolating clusters on the private network](/docs/containers?topic=containers-network_policies#isolate_workers), you created private host endpoints with this label for the worker nodes in your cluster.
  ```
  calicoctl get hep -o yaml | grep 'ibm.role.*worker_private'
  ```
  {: pre}

  **Windows**: Use the `--config` flag to point to the network configuration file that you got in step 1: `calicoctl get hep -o yaml --config=<filepath>/calicoctl.cfg | grep 'ibm.role.*worker_private`. Include this flag each time you run a `calicoctl` command.
  {: tip}
  * If no output is returned, no action is required. Continue to update your Kubernetes master to 1.16.
  * If any host endpoints with this label are returned, then both a default `allow-all-private-default` and a `deny-all-private-default` private network policy are created in your cluster so that any Calico private network policies continue to operate unaffected after the update. However, you might need to make the following changes:
    * In a future version 1.16 patch update, private host endpoints are created by default for worker nodes. To prevent future version patch updates from overwriting your custom private host endpoints, add the label `user.customized=true` to each private host endpoint before you update the master to 1.16.
    * Ensure you have a private host endpoint for each worker node in your cluster. If private host endpoints exist for all worker nodes in your cluster, no action is required. Continue to update your Kubernetes master to 1.16. If private host endpoints exist for only some worker nodes in your cluster, [create a private host endpoint with the `ibm.role == 'worker_private'` label for each worker node in your cluster](/docs/containers?topic=containers-network_policies#isolate_workers). The Calico policies in these steps are designed to apply to all worker nodes in the cluster. Applying the policies to only some worker nodes is not supported, because communication between worker nodes can be blocked.

<br />



## Archive
{: #k8s_version_archive}

Find an overview of Kubernetes versions that are unsupported in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

### Version 1.15 (Unsupported)
{: #cs_v115}

As of 22 September 2020, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.15](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.15 clusters cannot receive security updates or support unless they are updated to the next most recent version.
{: shortdesc}

[Review the potential impact](/docs/containers?topic=containers-cs_versions#cs_versions) of each Kubernetes version update, and then [update your clusters](/docs/containers?topic=containers-update#update) immediately to at least [Kubernetes 1.16](#cs_v116).

### Version 1.14 (Unsupported)
{: #cs_v114}

As of 31 May 2020, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.14](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.14 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [copy your deployments](/docs/containers?topic=containers-update_app#copy_apps_cluster) from the unsupported cluster to the new cluster.

### Version 1.13 (Unsupported)
{: #cs_v113}

As of 22 February 2020, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.13](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.13 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [copy your deployments](/docs/containers?topic=containers-update_app#copy_apps_cluster) from the unsupported cluster to the new cluster.

### Version 1.12 (Unsupported)
{: #cs_v112}

As of 3 November 2019, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.12](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.12 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [copy your deployments](/docs/containers?topic=containers-update_app#copy_apps_cluster) from the unsupported cluster to the new cluster.

### Version 1.11 (Unsupported)
{: #cs_v111}

As of 20 July 2019, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.11](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.11 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [copy your deployments](/docs/containers?topic=containers-update_app#copy_apps_cluster) from the unsupported cluster to the new cluster.

### Version 1.10 (Unsupported)
{: #cs_v110}

As of 16 May 2019, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.10](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.10 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.9 (Unsupported)
{: #cs_v19}

As of 27 December 2018, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.9](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.9 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.8 (Unsupported)
{: #cs_v18}

As of 22 September 2018, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.8](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.8 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.7 (Unsupported)
{: #cs_v17}

As of 21 June 2018, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.7](/docs/containers?topic=containers-changelog_archive) are unsupported. Version 1.7 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.5 (Unsupported)
{: #cs_v1-5}

As of 4 April 2018, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.5.md) are unsupported. Version 1.5 clusters cannot receive security updates or support.
{: shortdesc}

To continue running your apps in {{site.data.keyword.containerlong_notm}}, [create a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.
