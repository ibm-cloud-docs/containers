---

copyright:
  years: 2014, 2020
lastupdated: "2020-04-01"

keywords: kubernetes, iks, help

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# Managed add-ons
{: #cs_troubleshoot_addons}

As you use {{site.data.keyword.containerlong}}, consider these techniques for troubleshooting [managed add-ons](/docs/containers?topic=containers-managed-addons), such as Istio or Knative.
{: shortdesc}

## Reviewing add-on states and statuses
{: #debug_addons}

You can check the health state and status of a cluster add-on by running the following command:
```
ibmcloud ks cluster addons -c <cluster_name_or_ID>
```
{: pre}

Example output:
```
Name            Version   Health State   Health Status
debug-tool      2.0.0     normal         Addon Ready
istio           1.4       -              Enabling
kube-terminal   1.0.0     normal         Addon Ready
```
{: screen}

The **Health State** reflects the lifecycle of the add-on components. The **Health Status** provides details of what add-on operation is in progress. Each state and status is described in the following tables.

|Add-on health state|Description|
|--- |--- |
|`critical`|The add-on is not ready to be used for one of the following reasons:<ul><li>Some or all of the add-on components are unhealthy.</li><li>The add-on failed to deploy.</li><li>The add-on may be at an unsupported version.</li></ul>Check the **Health Status** field for more information.|
|`normal`|The add-on is successfully deployed. Check the status to verify that the add-on is `Ready` or to see if an update is available.|
|`pending`|Some or all components of the add-on are currently deploying. Wait for the state to become `normal` before working with your add-on.|
|`warning`|The add-on might not function properly due to cluster limitations. Check the **Health Status** field for more information.|
{: caption="Add-on health states"}
{: summary="Table rows read from left to right, with the add-on state in column one and a description in column two."}

</br>

|Add-on health status|Description|
|--- |--- |
|`Addon Not Ready`|Some or all of the add-on components are unhealthy. Check whether all add-on component pods are running. For example, for the Istio add-on, check whether all pods in the `istio-system` namespace are `Running` by running `kubectl get pods -n istio-system`.|
|`Addon Ready`|The add-on is successfully deployed and is healthy.|
|`Addon Unsupported`|The add-on runs an unsupported version. [Update your add-on to the latest version](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons), or see specific update steps for [Istio](/docs/containers?topic=containers-istio#istio_update) or [Knative](/docs/containers?topic=containers-serverless-apps-knative#update-knative-addon).|
|`Cluster resources low, not enough workers in Ready state.`|The add-on is not ready to be used for one of the following reasons:<ul><li>The cluster does not meet the size criteria for the add-on. For example, check the size requirements for [Istio](/docs/containers?topic=containers-istio#istio_install) or [Knative](/docs/containers?topic=containers-serverless-apps-knative#knative-setup).</li><li>Worker nodes in your cluster are not in a `Normal` state. [Review the worker nodes' state and status](/docs/containers?topic=containers-cs_troubleshoot_clusters#debug_worker_nodes).</li></ul>|
|`Enabling`|The add-on is currently deploying to the cluster. Note that the add-on might take up to 15 minutes to install.|
|`Istio data plane components may need to be updated.`| When the Istio control plane is updated, the Istio data plane components are not updated automatically. Whenever the Istio add-on is updated to a new patch or minor version, you must [manually update your data plane components](/docs/containers?topic=containers-istio#update_client_sidecar), including the `istioctl` client and the Istio sidecars for your app.|
{: caption="Add-on health statuses"}
{: summary="Table rows read from left to right, with the add-on status in column one and a description in column two."}


<br />


## Debugging Istio
{: #istio_debug_tool}

While you troubleshoot the [managed Istio add-on](/docs/containers?topic=containers-istio), you can use the {{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool to run Istio tests and gather pertinent information about the Istio add-on in your cluster. To use the debug tool, you can enable the add-on in your cluster.
{: shortdesc}

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to install the debug tool add-on.

2. Click the **Add-ons** tab.

3. On the Diagnostics and Debug Tool card, click **Install**.

4. In the dialog box, click **Install**. Note that it can take a few minutes for the add-on to be installed.

5. On the Diagnostics and Debug Tool card, click **Dashboard**.

5. In the debug tool dashboard, select the **istio_control_plane** or **istio_resources**  group of tests. Some tests check for potential warnings, errors, or issues, and some tests only gather information that you can reference while you troubleshoot. For more information about the function of each test, click the information icon next to the test's name.

6. Click **Run**.

7. Check the results of each test. If any test fails, click the information icon next to the test's name in the left-hand column for information about how to resolve the issue.

<br />


## Istio components are missing
{: #control_plane}

{: tsSymptoms}
One or more of the Istio control plane components, such as `istio-citadel` or `istio-telemetry`, does not exist in your cluster.

{: tsCauses}
* You deleted one of the Istio deployments that is installed in your cluster Istio managed add-on.
* You changed the default `IstioControlPlane` resource. When you enable the managed Istio add-on, you cannot use `IstioControlPlane` resources to customize the Istio control plane. Only the `IstioControlPlane` resources that are managed by IBM are supported. Changing the control plane settings might result in an unsupported control plane state.

{: tsResolve}
Refresh your `IstioControlPlane` resource. The Istio operator reconciles the installation of Istio to the original add-on settings, including the core components of the Istio control plane.
```
kubectl annotate icp -n ibm-operators managed-istiocontrolplane --overwrite restartedAt=$(date +%H-%M-%S)
```
{: pre}
