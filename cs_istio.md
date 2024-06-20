---

copyright:
  years: 2014, 2024
lastupdated: "2024-06-20"


keywords: kubernetes, envoy, sidecar, mesh, bookinfo, istio

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}






# Setting up Istio
{: #istio}


## Setting up the Istio managed add-on
{: #addon}

Istio on {{site.data.keyword.containerlong}} provides a seamless installation of Istio, automatic updates and lifecycle management of Istio control plane components, and integration with platform logging and monitoring tools.
{: shortdesc}


### Installing the Istio add-on
{: #istio_install}

Instead of the community Istio, you can install the managed Istio add-on.
{: shortdesc}

Before you begin

* Ensure that you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service access role](/docs/containers?topic=containers-iam-platform-access-roles) for {{site.data.keyword.containerlong_notm}}.
* [Create a standard Kubernetes cluster with at least 3 worker nodes that each have 4 cores and 16 GB memory (`b3c.4x16`) or more](/docs/containers?topic=containers-clusters).
* You can't run community Istio concurrently with the managed Istio add-on in your cluster. If you use an existing cluster and you previously installed Istio in the cluster by using the IBM Helm chart or through another method, [clean up that Istio installation](#istio_uninstall_other).
* Classic multizone clusters: Ensure that you enable a [Virtual Routing and Forwarding (VRF)](/docs/account?topic=account-vrf-service-endpoint&interface=ui) for your IBM Cloud infrastructure account. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Manage Network VLAN Spanning** infrastructure permission, or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).

#### Installing the Istio add-on from the console
{: #istio_install_console}
{: ui}

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to install the Istio add-on.

2. Navigate to the **Add-ons** section.

3. On the Managed Istio card, click **Install**.

4. Click **Install** again.

5. On the Managed Istio card, verify that the add-on is listed.

#### Installing the Istio add-on with the CLI
{: #istio_install_cli}
{: cli}

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

2. Review the supported [Istio versions](/docs/containers?topic=containers-istio-changelog).
    ```sh
    ibmcloud ks addon-versions --addon istio
    ```
    {: pre}

3. Enable the `istio` add-on. The default version of the generally available Istio managed add-on, 1.22.1, is installed.
    ```sh
    ibmcloud ks cluster addon enable istio --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. Verify that the managed Istio add-on has a status of `Addon Ready`.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    NAME            Version     Health State   Health Status
    istio           1.22.1       normal         Addon Ready
    ```
    {: screen}

5. You can also check out the individual components of the add-on to ensure that the Istio services and their corresponding pods are deployed.
    ```sh
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```sh
    kubectl get pods -n istio-system
    ```
    {: pre}

6. Next, you can include your apps in the [Istio service mesh](/docs/containers?topic=containers-istio-mesh#istio_sidecar).



### Updating the Istio add-on
{: #istio_update}

Update your Istio add-on, which is tested by {{site.data.keyword.cloud_notm}} and approved for the use in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

Do not use `istioctl` to update the version of Istio that is installed by the managed add-on. Only use the following steps to update your managed Istio add-on, which includes an update of the Istio version.
{: important}

To update from unsupported versions of the Istio add-on, update your [Istio components](/docs/containers?topic=containers-istio#istio_minor) to the latest patch version that is supported by {{site.data.keyword.containerlong_notm}}.
{: important}


#### Updating the minor version of the Istio add-on
{: #istio_minor}

{{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio that is supported by {{site.data.keyword.containerlong_notm}}. To update your Istio components to the next minor version of Istio that is supported by {{site.data.keyword.containerlong_notm}}, such as from version 1.9 to 1.10, you must manually update your add-on. You can only manually update Istio one version at a time.
{: shortdesc}

You can only manually update the Istio add-on one version at a time. If you want to update the Istio add-on by two or more versions, you can repeat the manual update process or you can [uninstall and remove](#istio_uninstall_addon) the add-on and then [reinstall](#istio_install) it with a later version.
{: note}

When you update the Istio control components in the `istio-system` namespace to the latest minor version, you might experience disruptive changes. Review the following changes that occur during a minor version update.
* As updates are rolled out to control plane pods, the pods are re-created. The Istio control plane is not fully available until after the update completes.
* The Istio data plane continues to function during the update. However, some traffic to apps in the service mesh might be interrupted for a short period of time.
* The external IP address for the `istio-ingressgateway` load balancer does not change during or after the update.

You can't revert your managed Istio add-on to a previous version. If you want to revert to an earlier minor version, you must uninstall your add-on and then reinstall the add-on by specifying the earlier version.
{: important}

1. Review the current version of your Istio add-on.
    ```sh
    kubectl get iop managed-istio -n ibm-operators -o jsonpath='{.metadata.annotations.version}'
    ```
    {: pre}

1. Review the available Istio add-on versions.
    ```sh
    ibmcloud ks addon-versions
    ```
    {: pre}

1. Review the changes that are in each version in the [Istio add-on change log](/docs/containers?topic=containers-istio-changelog).

1. If you are upgrading from version 1.11 to version 1.12 and your Istio components were provisioned at version 1.10 or earlier:

    1. Run the command to get the details of your mutating webhook configurations.
        ```sh
        kubectl get mutatingwebhookconfigurations
        ```
        {: pre}

        Example output.

        ```sh
        NAME                     WEBHOOKS   AGE
        istio-sidecar-injector   5          32m
        ```
        {: screen}

    1. In the output, find the `istio-sidecar-injector` and review the **WEBHOOKS** column. If there are 5 or more webhooks, run the following command to delete the additional webhooks.
    
        ```sh
        kubectl delete mutatingwebhookconfigurations istio-sidecar-injector && kubectl rollout restart deploy addon-istio-operator -n ibm-operators
        ```
        {: pre}

        Example output.

        ```sh
        mutatingwebhookconfiguration.admissionregistration.k8s.io "istio-sidecar-injector" deleted
        ```
        {: screen}

    1. Check that the additional webhooks were deleted. Get the details of your mutating webhook configurations and verify that there are 4 `istio-sidecar-injector` webhooks.

        ```sh
        kubectl get mutatingwebhookconfigurations
        ```
        {: pre}

        Example output.

        ```sh
        NAME                     WEBHOOKS   AGE
        istio-sidecar-injector   4          60s
        ```
        {: screen}
    
    1. Run the command to get the details of your validating webhook configuration.

        ```sh
        kubectl get validatingwebhookconfigurations
        ```
        {: pre}

        Example output.

        ```txt
        NAME                           WEBHOOKS   AGE
        istio-validator-istio-system   2          66s
        istiod-istio-system            1          31m
        ```
        {: screen}
    
    1. Review the output. If the `istiod-istio-system` webhook is listed, run the following command to delete it.

        ```sh
        kubectl delete ValidatingWebhookConfiguration istiod-istio-system
        ```
        {: pre}

        Example output.

        ```sh
        validatingwebhookconfiguration.admissionregistration.k8s.io "istiod-istio-system" deleted
        ```
        {: screen}

    1. Verify that the `istiod-istio-system` webhook is no longer listed.

        ```sh
        kubectl get validatingwebhookconfigurations
        ```
        {: pre}

        Example output.

        ```sh
        NAME                           WEBHOOKS   AGE
        istio-validator-istio-system   2          2m
        ```
        {: screen}

1. Update the Istio add-on.
    ```sh
    ibmcloud ks cluster addon update istio --version <version> -c <cluster_name_or_ID>
    ```
    {: pre}

1. Before you proceed, verify that the update is complete.

    The update process can take up to 20 minutes to complete.
    {: note}

    1. Ensure that the Istio add-on's **Health State** is `normal` and the **Health Status** is `Addon Ready`. If the state is `updating`, the update is not yet complete.
    
        ```sh
        ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
        ```
        {: pre}

    2. Ensure that the control plane component pods in the `istio-system` namespace have a **STATUS** of `Running`.
        ```sh
        kubectl get pods -n istio-system
        ```
        {: pre}

        ```sh
        NAME                                                     READY   STATUS    RESTARTS   AGE
        istio-system    istio-egressgateway-6d4667f999-gjh94     1/1     Running     0          61m
        istio-system    istio-egressgateway-6d4667f999-txh56     1/1     Running     0          61m
        istio-system    istio-ingressgateway-7bbf8d885-b9xgp     1/1     Running     0          61m
        istio-system    istio-ingressgateway-7bbf8d885-xhkv6     1/1     Running     0          61m
        istio-system    istiod-5b9b5bfbb7-jvcjz                  1/1     Running     0          60m
        istio-system    istiod-5b9b5bfbb7-khcht                  1/1     Running     0          60m
        ```
        {: screen}

1. [Update your `istioctl` client and sidecars](#update_client_sidecar).

#### Updating the `istioctl` client and sidecars
{: #update_client_sidecar}

Whenever the Istio managed add-on is updated, update your `istioctl` client and the Istio sidecars for your app.
{: shortdesc}

For example, the patch version of your add-on might be updated automatically by {{site.data.keyword.containerlong_notm}}, or you might [update the minor version of your add-on](#istio_minor). In either case, update your `istioctl` client and your app's existing Istio sidecars to match the Istio version of the add-on.

1. Get the version of your `istioctl` client and the Istio add-on control plane components.
    ```sh
    istioctl version --short=false
    ```
    {: pre}

    Example output

    ```sh
    client version: version.BuildInfo{Version:"1.11.2"}
    pilot version: version.BuildInfo{Version:1.22.1}
    pilot version: version.BuildInfo{Version:1.22.1}
    data plane version: version.ProxyInfo{ID:"istio-egressgateway-77bf75c5c-vp97p.istio-system", IstioVersion:1.22.1}
    data plane version: version.ProxyInfo{ID:"istio-egressgateway-77bf75c5c-qkhgm.istio-system", IstioVersion:1.22.1}
    data plane version: version.ProxyInfo{ID:"istio-ingressgateway-6dcb67b64d-dffhq.istio-system", IstioVersion:1.22.1}
    data plane version: version.ProxyInfo{ID:"httpbin-74fb669cc6-svc8x.default", IstioVersion:1.22.1}
    data plane version: version.ProxyInfo{ID:"istio-ingressgateway-6dcb67b64d-cs9r9.istio-system", IstioVersion:1.22.1}
    ...
    ```
    {: screen}

2. In the output, compare the `client version` (`istioctl`) to the version of the Istio control plane components, such as the `pilot version`. If the `client version` and control plane component versions don't match:
    1. Download the `istioctl` client of the same version as the control plane components.
    
        ```sh
        curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.22.1 sh -
        ```
        {: pre}

    2. Navigate to the Istio package directory.
    
        ```sh
        cd istio-1.22.1
        ```
        {: pre}

    3. Linux and macOS users: Add the `istioctl` client to your `PATH` system variable.
    
        ```sh
        export PATH=$PWD/bin:$PATH
        ```
        {: pre}

3. In the output of step 1, compare the `pilot version` to the `data plane version` for each data plane pod.
    * If the `pilot version` and the `data plane version` match, no further updates are required.
    * If the `pilot version` and the `data plane version` don't match, restart your deployments for the data plane pods that run the old version. The pod name and namespace are listed in each entry as `data plane version: version.ProxyInfo{ID:"<pod_name>.<namespace>", IstioVersion:"1.8.4"}`.

    ```sh
    kubectl rollout restart deployment <deployment> -n <namespace>
    ```
    {: pre}


### Customizing the Istio installation
{: #customize}

You can customize a set of Istio configuration options by editing the `managed-istio-custom` ConfigMap resource. These settings include extra control over monitoring, logging, and networking in your control plane and service mesh.
{: shortdesc}

1. Describe the `managed-istio-custom` ConfigMap resource to review its contents and the in-line documentation.
    ```sh
    kubectl describe cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

2. Edit the `managed-istio-custom` ConfigMap resource.
    ```sh
    kubectl edit cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

3. In the `data` section, add the `<key>: "<value>"` pair of one or more of the following configuration options.

    `istio-components-pilot-requests-cpu`
    :   Default value: `"500m"`
    :   Configure the CPU request in `milli` CPU for the `istiod` component pod.
        Use caution when changing this value. Setting this value too low might prevent the control plane from working properly, and setting this value too high might prevent the `istiod` pod from being scheduled.
        {: important}

    `istio-global-logging-level`
    :   Default value: `"default:info"`
    :   Define the scope of logs and the level of log messages for control plane components. A scope represents a functional area within a control plane component and each scope supports specific log information levels. The `default` logging scope, which is for non-categorized log messages, is applied to all components in the control plane at the basic `info` level.
    :   To specify log levels for individual component scopes, enter a comma-separated list of scopes and levels, such as `"<scope>:<level>,<scope>:<level>"`. For a list of the scopes for each control plane component and the information level of log messages, see the [Istio component logging documentation](https://istio.io/latest/docs/ops/diagnostic-tools/component-logging/){: external}.
        To change the log level of the data plane, use the `istioctl proxy-config log <pod> --level <level>` command.
        {: tip}
      
    `istio-global-outboundTrafficPolicy-mode`
    :   Default value: `"ALLOW_ANY"`
    :   By default, all outbound traffic from the service mesh is permitted. To block outbound traffic from the service mesh to any host that is not defined in the service registry or that does not have a `ServiceEntry` within the service mesh, set to `REGISTRY_ONLY`.
    
    `istio-egressgateway-public-1-enabled`
    :   Default value: `"true"`
    :   To disable the default Istio egress gateway, set to `"false"`. For example, you might [create a custom egress gateway](/docs/containers?topic=containers-istio-custom-gateway#custom-egress-gateway) instead.

    `istio-global-proxy-accessLogFile`
    :   Default value: `""`
    :   Envoy proxies print access information to their standard output. These logs are helpful when you debug ingress or egress issues. To view this access information when running `kubectl logs` commands for the Envoy containers, set to `"/dev/stdout"`.
    
    `istio-ingressgateway-public-1|2|3-enabled`
    :   Default value: `"true"` in zone 1 only.
    :   To make your apps more highly available, set to `"true"` for each zone where you want a public `istio-ingressgateway` load balancer to be created. To use [custom ingress gateways](/docs/containers?topic=containers-istio-custom-gateway#custom-egress-gateway) instead of the default ingress gateway, you can set to `"false"`.
    
    `istio-ingressgateway-zone-1|2|3`
    :   Default value: `"<zone>"`
    :   The zones where your worker nodes are deployed, which are automatically populated when you install the add-on and whenever you apply an Istio patch update. These fields apply your cluster's zones to the `istio-ingressgateway-public-1|2|3-enabled` fields. Note that if the zones that are listed in this setting are out of sync with your cluster zones, you can restart the auto population job by running `kubectl delete pod -n ibm-system -l addon.cleanup=istio` and `kubectl delete job -n ibm-system -l addon.cleanup=istio`.
    
    `istio-monitoring-telemetry`
    :   Default value: `"true"`
    :   By default, telemetry metrics and Prometheus support is enabled. To remove any performance issues associated with telemetry metrics and disable all monitoring, set to `"false"`.
    
    `istio-meshConfig-enableTracing`
    :   Default value: `"true"`
    :   By default, Istio generates trace spans for 1 out of every 100 requests. To disable trace spans, set to `"false"`.
    
    `istio-pilot-traceSampling`
    :   Default value: `"1.0"`
    :   By default, Istio [generates trace spans for 1 out of every 100 requests](https://istio.io/latest/docs/tasks/observability/distributed-tracing/overview/#trace-sampling){: external}, which is a sampling rate of 1%. To generate more trace spans, increase the percentage value.

    `istio-components-pilot-hpa-maxReplicas`
    :   Default value: `"5"`
    :   By default, Istio sets the default horizontal pod autoscaler (HPA) max pods for istiod to 5. Do not increase this value unless you have a large service mesh where istiod needs increased resources to update the configurations.

    For example, your ConfigMap might look like the following example.
    ```yaml
    apiVersion: v1
    data:
      istio-ingressgateway-zone-1: dal10
      <key: value> # such as istio-egressgateway-public-1-enabled: "false"
    kind: ConfigMap
    metadata:
      name: managed-istio-custom
      namespace: ibm-operators
    ```
    {: screen}

    Don't see an option from this table in your ConfigMap? Because your ConfigMap contains user-defined values, the ConfigMap is not updated with any options that are released over time. Instead, you can back up a copy of your ConfigMap and delete the ConfigMap from your cluster. After about 5 minutes, a default ConfigMap that contains the new options is created in your cluster. Then, you can copy your previously configured settings from your backup to this default ConfigMap, configure any new settings, and apply the changes.
    {: tip}

4. Save and close the configuration file.

5. If you changed the `istio-global-logging-level` or `istio-global-proxy-accessLogFile` settings, you must restart your data plane pods to apply the changes to them.

    1. Get the list of all data plane pods that are not in the `istio-system` namespace.
    
        ```sh
        istioctl version --short=false | grep "data plane version" | grep -v istio-system
        ```
        {: pre}

        Example output

        ```sh
        data plane version: version.ProxyInfo{ID:"test-6f86fc4677-vsbsf.default", IstioVersion:"1.22.1"}
        data plane version: version.ProxyInfo{ID:"rerun-xfs-f8958bb94-j6n89.default", IstioVersion:"1.22.1"}
        data plane version: version.ProxyInfo{ID:"test2-5cbc75859c-jh6bx.default", IstioVersion:"1.22.1"}
        data plane version: version.ProxyInfo{ID:"minio-test-78b5d4597d-hkpvt.default", IstioVersion:"1.22.1"}
        data plane version: version.ProxyInfo{ID:"sb-887f89d7d-7s8ts.default", IstioVersion:"1.22.1"}
        data plane version: version.ProxyInfo{ID:"gid-deployment-5dc86db4c4-kdshs.default", IstioVersion:"1.22.1"}
        ```
        {: screen}

    2. Restart each pod by deleting it. In the output of the previous step, the pod name and namespace are listed in each entry as `data plane version: version.ProxyInfo{ID:"<pod_name>.<namespace>", IstioVersion:"1.22.1"}`.
        ```sh
        kubectl delete pod <pod_name> -n <namespace>
        ```
        {: pre}

Want to change a ConfigMap setting?
:   If you want to change a setting that you added to the ConfigMap, you can use a patch script. For example, if you added the `istio-global-proxy-accessLogFile: "/dev/stdout"` setting and later want to change it back to `""`, you can run `kubectl patch cm managed-istio-custom -n ibm-operators --type='json' -p='[{"op": "add", "path": "/data/istio-global-proxy-accessLogFile", "value":""}]'`. 

Need to debug your customization setup?
:   Check the logs for the `addon-istio-operator` (Istio version 1.10 or later) or `managed-istio-operator` (Istio version 1.9 or earlier) pod by running `kubectl logs -n ibm-operators -l name=managed-istio-operator`. The Istio operator validates and reconciles any custom Istio changes that you make.
{: tip}

If you disable the Istio add-on, the `managed-istio-custom` ConfigMap is not removed during uninstallation. When you re-enable the Istio add-on, your customized ConfigMap is applied during installation. If you don't want to re-use your custom settings in a later installation of Istio, you must delete the ConfigMap after you disable the Istio add-on by running `kubectl delete cm -n ibm-operators managed-istio-custom`. When you re-enable the Istio add-on, the default ConfigMap is applied during installation.
{: note}

### Uninstalling the Istio add-on
{: #istio_uninstall}

If you're finished working with Istio, you can clean up the Istio resources in your cluster and uninstall the Istio add-ons.
{: shortdesc}

#### Step 1: Saving resources before uninstallation
{: #uninstall_resources}

Any resources that you created or modified in the `istio-system` namespace are removed. To keep these resources, save them before you uninstall the Istio add-on.
{: shortdesc}

1. Save the `managed-istio-custom` ConfigMap to troubleshoot a problem or to reinstall the add-on later.

    ```sh
    kubectl get cm -n ibm-operators managed-istio-custom -o yaml > Customizations.yaml
    ```
    {: pre}

2. Save all IstioOperator CRs (IOPs).

    a. List the IOP resources:
    ```sh
    kubectl get iop -A
    ```
    {: pre}

    b. For each IOP resource listed, save each to a file:
    ```sh
    kubectl get iop -n <IOP_namespace> <IOP_name> -o yaml > <IOP_name>.yaml
    ```
    {: pre}



#### Step 2: Uninstalling the Istio add-on
{: #istio_uninstall_addon}

Uninstall the add-on from the console or CLI. For Istio 1.20 and earlier, any custom Istio operator (IOP) resources are automatically deleted.
{: shortdesc}

##### Uninstalling the Istio add-on from the console
{: #istio_uninstall_ui}
{: ui}

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to remove the Istio add-on.

2. Navigate to the **Add-ons** section.

3. On the Managed Istio card, click the Action menu icon.

4. Click **Uninstall**. The managed Istio add-on is disabled in this cluster and all Istio resources in this cluster are removed.

5. On the Managed Istio card, verify that the add-on you uninstalled is no longer listed.

##### Uninstalling the Istio add-ons from the CLI
{: #istio_uninstall_cli}
{: cli}

If you did not install the deprecated `istio-sample-bookinfo` and `istio-extras` add-ons, skip steps 1 and 2. 
{: tip}

1. Disable the `istio-sample-bookinfo` add-on.
    ```sh
    ibmcloud ks cluster addon disable istio-sample-bookinfo --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Disable the `istio-extras` add-on.
    ```sh
    ibmcloud ks cluster addon disable istio-extras --cluster <cluster_name_or_ID>
    ```
    {: pre}

3. Disable the `istio` add-on.
    ```sh
    ibmcloud ks cluster addon disable istio --cluster <cluster_name_or_ID> -f
    ```
    {: pre}

4. Verify that all managed Istio add-ons are disabled in this cluster. No Istio add-ons are returned in the output.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

#### Step 3: Removing resources
{: #istio_remove_resources}

After the resources are saved and the add-on is disabled, the resources can be removed.
{: shortdesc}

1. The `managed-istio-custom` ConfigMap is not removed during uninstallation. If you later re-enable the Istio add-on, any [customized settings that you made to the ConfigMap](#customize) are applied during installation. If you don't want to re-use your custom settings in a later installation of Istio, you must delete the ConfigMap.

    ```sh
    kubectl delete cm -n ibm-operators managed-istio-custom
    ```
    {: pre}

2. Delete any custom Istio operator (IOP) resources that you created, such as for a custom ingress gateway. When you run this command, the Istio operator automatically removes any resources that the IOP resource created, such as deployments or services.

    ```sh
    kubectl delete IstioOperator <resource_name> -n <namespace>
    ```
    {: pre}

3. For Istio 1.21 and later, delete the `managed-istio` IOP.

    ```sh
    kubectl delete iop -n ibm-operators managed-istio
    ```
    {: pre}

4. Wait 10 minutes before continuing to the next step.


#### Step 4: Remove the Istio operator
{: #istio_uninstall_operator}

After the add-on is completely uninstalled, you can remove the Istio operator.
{: shortdesc}

Delete the Istio operator deployment, service account, cluster role binding, and cluster role.
```sh
kubectl delete deployment -n ibm-operators addon-istio-operator --ignore-not-found=true
kubectl delete serviceaccount -n ibm-operators addon-istio-operator --ignore-not-found=true
kubectl delete clusterrolebinding addon-istio-operator --ignore-not-found=true
kubectl delete clusterrole addon-istio-operator --ignore-not-found=true
```
{: pre}


### Uninstalling other Istio installations in your cluster
{: #istio_uninstall_other}

If you previously installed Istio in the cluster by using the IBM Helm chart or through another method, clean up that Istio installation before you enable the managed Istio add-on in the cluster. To check whether Istio is already in a cluster, run `kubectl get namespaces` and look for the `istio-system` namespace in the output.
{: shortdesc}

- If you installed Istio by using the {{site.data.keyword.cloud_notm}} Istio Helm chart,
    1. Uninstall the Istio Helm deployment.
        ```sh
        helm del istio --purge
        ```
        {: pre}

    2. If you used Helm 2.9 or earlier, delete the extra job resource.
        ```sh
        kubectl -n istio-system delete job --all
        ```
        {: pre}

    3. The uninstallation process can take up to 10 minutes. Before you install the Istio managed add-on in the cluster, run `kubectl get namespaces` and verify that the `istio-system` namespace is removed.

- If you installed Istio manually or used the Istio community Helm chart, see the [Istio uninstall documentation](https://istio.io/latest/docs/setup/getting-started/#uninstall){: external}.
- If you previously installed BookInfo in the cluster, clean up those resources.
    1. Change the directory to the Istio file location.
        ```sh
        cd <filepath>/istio-1.22.1
        ```
        {: pre}

    2. Delete all BookInfo services, pods, and deployments in the cluster.
        ```sh
        samples/bookinfo/platform/kube/cleanup.sh
        ```
        {: pre}

    3. The uninstallation process can take up to 10 minutes. Before you install the Istio managed add-on in the cluster, run `kubectl get namespaces` and verify that the `istio-system` namespace is removed.



### Troubleshooting the Istio add-on
{: #istio-ts}

To resolve some common issues that you might encounter when you use the managed Istio add-on, see [Troubleshooting managed add-ons](/docs/containers?topic=containers-debug_addons).
{: shortdesc}



## Installing the `istioctl` CLI
{: #istioctl}
{: cli}

Install the `istioctl` CLI client on your computer. For more information, see the [`istioctl` command reference](https://istio.io/latest/docs/reference/commands/istioctl/){: external}.

1. Check the version of Istio that you installed in your cluster.
    ```sh
    istioctl version
    ```
    {: pre}

2. Download the version of `istioctl` that matches your cluster's Istio version to your computer.
    ```sh
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.22.1 sh -
    ```
    {: pre}

3. Navigate to the Istio package directory.
    ```sh
    cd istio-1.22.1
    ```
    {: pre}

4. Linux and macOS users: Add the `istioctl` client to your `PATH` system variable.
    ```sh
    export PATH=$PWD/bin:$PATH
    ```
    {: pre}





## Migrating from Istio add-on 1.21 to community Istio 1.21
{: #migrate}

You can migrate to using the community Istio instead of the managed Istio add-on.
{: shortdesc}

Before you begin
- If you are using a version earlier than 1.21, [update the Istio add-on to version 1.21](#istio_update). This upgrade is important because with this version, the disabling of the add-on does not remove custom resources as happens with earlier versions.
- If you no longer need Istio, you can [uninstall the add-on without installing the community Istio](#istio_uninstall_addon) instead of completing these step.



### Step 1: Disabling the Istio add-on from the console
{: #migrate_disable_ui}
{: ui}

Disable the add-on from the console or CLI.
{: shortdesc}

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to remove the Istio add-on.

2. Navigate to the **Add-ons** section.

3. On the Managed Istio card, click the Action menu icon.

4. Click **Uninstall**. The managed Istio add-on is disabled in this cluster.

5. On the Managed Istio card, verify that the add-on you uninstalled is no longer listed.

### Step 1: Disabling the Istio add-ons from the CLI
{: #migrate_disable_cli}
{: cli}

Disable the add-on and verify that no additional Istio add-ons remain.
{: tip}

1. Disable the `istio` add-on.
    ```sh
    ibmcloud ks cluster addon disable istio --cluster <cluster_name_or_ID> -f
    ```
    {: pre}

2. Verify that all managed Istio add-ons are disabled in this cluster. No Istio add-ons are returned in the output.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
    ```
    {: pre}


### Step 2: Removing the Istio operator
{: #migrate_uninstall_operator}

Delete the Istio operator deployment, service account, cluster role binding, and cluster role.
{: shortdesc}

Run the following commands:
```sh
kubectl delete deployment -n ibm-operators addon-istio-operator --ignore-not-found=true
kubectl delete serviceaccount -n ibm-operators addon-istio-operator --ignore-not-found=true
kubectl delete clusterrolebinding addon-istio-operator --ignore-not-found=true
kubectl delete clusterrole addon-istio-operator --ignore-not-found=true
```
{: pre}

### Step 3: Saving resources
{: #migrate_resources}

Save any resources that you created or modified in the `istio-system` namespace and all Kubernetes resources that were automatically generated by custom resource definitions (CRDs).
{: shortdesc}


1. Delete the finalizer in the IOP. Example using the `managed-istio` IOP:

    ```sh
    kubectl patch -n ibm-operators istiooperator/managed-istio --type json --patch='[ { "op": "remove", "path": "/metadata/finalizers" } ]'
    ```
    {: pre}

1. Save the `managed-istio-custom` ConfigMap to troubleshoot a problem or to reinstall the add-on later.

    ```sh
    kubectl get cm -n ibm-operators managed-istio-custom -o yaml > Customizations.yaml
    ```
    {: pre}

1. Save all IstioOperator CRs (IOPs).

    a. List the IOP resources:
    ```sh
    kubectl get iop -A
    ```
    {: pre}

    b. For each IOP resource listed, save each to a file:
    ```sh
    kubectl get iop -n <IOP_namespace> <IOP_name> -o yaml > <IOP_name>.yaml
    ```
    {: pre}

1. To get ready to apply them again, in the saved YAML files, remove the `status` section. In the  `metadata` section, keep `name` and `namespace`, but remove all other information.

    Result:
    ```txt
    apiVersion: install.istio.io/v1alpha1
    kind: IstioOperator
    metadata:
      name: NAME
      namespace: NAMESPACE
    spec:
      <spec_info>
    ```
    {: codeblock}

1. Wait 10 minutes before continuing to the next step.


### Step 4: Changing the installer of the IOPs 
{: #migrate_installer}

Delete all Istio operator (IOP) resources, such as for a custom ingress gateway.
{: shortdesc}

1. Run the `delete` command for the Istio operator to automatically remove any resources that the IOP resource created, such as deployments or services.

    ```sh
    kubectl delete IstioOperator <resource_name> -n <namespace>
    ```
    {: pre}

1. For each IOP file that you saved in the previous step, run the `upgrade` command.

    ```sh
    istioctl upgrade -f <filename>.yaml
    ```
    {: pre}


### Step 5: Removing the ConfigMap
{: #migrate_configmap}

Because the ConfigMap was saved earlier, it can be removed.
{: shortdesc}

Remove the `managed-istio-custom` ConfigMap.

```sh
kubectl delete cm -n ibm-operators managed-istio-custom
```
{: pre}

The removal of the add-on is complete and you can continue to use and upgrade the community Istio as needed.




