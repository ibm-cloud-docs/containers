---

copyright:
  years: 2014, 2025
lastupdated: "2025-09-16"


keywords: istio migration, istio updates, istio upgrades

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Updating Istio
{: #istio-update}

Do not use `istioctl` to update the version of Istio that is installed by the managed add-on. When updated, the managed Istio add-on includes an update of the Istio version as well. Supported versions of Istio are tested by {{site.data.keyword.cloud_notm}} and approved for the use in {{site.data.keyword.containerlong_notm}}.
{: important}

## Before you begin
{: #istio-update-prereq}

- You can only manually update the Istio add-on one version at a time. To update the Istio add-on by two or more versions, you can repeat the manual update process or you can [uninstall](/docs/containers?topic=containers-istio#istio_uninstall_addon) the add-on and then [install](/docs/containers?topic=containers-istio#istio_install) the later version.

- You can't revert your managed Istio add-on to a previous version. To revert to an earlier minor version, you must [uninstall](/docs/containers?topic=containers-istio#istio_uninstall_addon) the add-on and then [install](/docs/containers?topic=containers-istio#istio_install) the earlier version.

- When you update the Istio control components in the `istio-system` namespace to the latest minor version, you might experience disruptive changes. Review the following changes that occur during a minor version update.
    * As updates are rolled out to control plane pods, the pods are re-created. The Istio control plane is not fully available until after the update completes.
    * The Istio data plane continues to function during the update. However, some traffic to apps in the service mesh might be interrupted for a short period of time.
    * The external IP address for the `istio-ingressgateway` load balancer does not change during or after the update.



## Updating to a minor version of the Istio add-on
{: #istio_minor}



Before you begin:

Review the [prerequisites](#istio-update-prereq) that apply to all version updates.


To update the minor version of the Istio add-on:

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

        Example output

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

        Example output

        ```sh
        mutatingwebhookconfiguration.admissionregistration.k8s.io "istio-sidecar-injector" deleted
        ```
        {: screen}

    1. Check that the additional webhooks were deleted. Get the details of your mutating webhook configurations and verify that there are 4 `istio-sidecar-injector` webhooks.

        ```sh
        kubectl get mutatingwebhookconfigurations
        ```
        {: pre}

        Example output

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

        Example output

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

        Example output

        ```sh
        validatingwebhookconfiguration.admissionregistration.k8s.io "istiod-istio-system" deleted
        ```
        {: screen}

    1. Verify that the `istiod-istio-system` webhook is no longer listed.

        ```sh
        kubectl get validatingwebhookconfigurations
        ```
        {: pre}

        Example output

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


## Updating the `istioctl` client and sidecars
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
    pilot version: version.BuildInfo{Version:1.23.5}
    pilot version: version.BuildInfo{Version:1.23.5}
    data plane version: version.ProxyInfo{ID:"istio-egressgateway-77bf75c5c-vp97p.istio-system", IstioVersion:1.23.5}
    data plane version: version.ProxyInfo{ID:"istio-egressgateway-77bf75c5c-qkhgm.istio-system", IstioVersion:1.23.5}
    data plane version: version.ProxyInfo{ID:"istio-ingressgateway-6dcb67b64d-dffhq.istio-system", IstioVersion:1.23.5}
    data plane version: version.ProxyInfo{ID:"httpbin-74fb669cc6-svc8x.default", IstioVersion:1.23.5}
    data plane version: version.ProxyInfo{ID:"istio-ingressgateway-6dcb67b64d-cs9r9.istio-system", IstioVersion:1.23.5}
    ...
    ```
    {: screen}

2. In the output, compare the `client version` (`istioctl`) to the version of the Istio control plane components, such as the `pilot version`. If the `client version` and control plane component versions don't match:
    1. Download the `istioctl` client of the same version as the control plane components.
    
        ```sh
        curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.23.5 sh -
        ```
        {: pre}

    2. Navigate to the Istio package directory.
    
        ```sh
        cd istio-1.23.5
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



## Updating from an unsupported version of the Istio add-on
{: #istio_update}

Update your [Istio components](/docs/containers?topic=containers-istio-update#istio_minor) to the latest patch version that is supported by {{site.data.keyword.containerlong_notm}}.
{: shortdesc}
