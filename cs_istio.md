---

copyright:
  years: 2014, 2020
lastupdated: "2020-04-06"

keywords: kubernetes, iks, envoy, sidecar, mesh, bookinfo

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


# Setting up Istio
{: #istio}

Istio on {{site.data.keyword.containerlong}} provides a seamless installation of Istio, automatic updates and lifecycle management of Istio control plane components, and integration with platform logging and monitoring tools.
{: shortdesc}

With one click, you can get all Istio core components and additional tracing, monitoring, and visualization up and running. Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on, so {{site.data.keyword.cloud_notm}} automatically keeps all your Istio components up-to-date.

The Istio managed add-on is generally available for Kubernetes version 1.16 and later clusters as of 19 November 2019. The beta version of the managed add-on, which runs Istio version 1.3 or earlier, can no longer be installed on 14 February 2020. In Kubernetes version 1.16 or later clusters, you can [update your add-on to the latest version](#istio_update) by uninstalling the Istio version 1.3 or earlier add-on and installing the Istio version 1.4 add-on.
{: important}

## Installing the Istio add-on
{: #istio_install}

In Kubernetes version 1.16 and later clusters, you can install the generally available managed Istio add-on, which runs Istio version 1.4.
{: shortdesc}

**Before you begin**</br>
* Ensure that you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}.
* [Create a standard Kubernetes version 1.16 or later cluster with at least 3 worker nodes that each have 4 cores and 16 GB memory (`b3c.4x16`) or more](/docs/containers?topic=containers-clusters#clusters_ui). To use an existing cluster, you must update both the [cluster master to version 1.16](/docs/containers?topic=containers-update#master) and the [worker nodes to version 1.16](/docs/containers?topic=containers-update#worker_node).
* If you use an existing cluster and you previously installed Istio in the cluster by using the IBM Helm chart or through another method, [clean up that Istio installation](#istio_uninstall_other).
* In multizone clusters, ensure that you enable a [Virtual Router Function (VRF)](/docs/resources?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) for your IBM Cloud infrastructure account. To enable VRF, [contact your IBM Cloud infrastructure account representative](/docs/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#benefits-of-moving-to-vrf). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you cannot or do not want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-users#infra_access), or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get).

**To use the {{site.data.keyword.cloud_notm}} console:**

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to install the Istio add-on.

2. Click the **Add-ons** tab.

3. On the Managed Istio card, click **Install**.

4. Click **Install** again.

5. On the Managed Istio card, verify that the add-on is listed.

**To use the CLI:**

1. [Target the CLI to your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

2. Enable the `istio` add-on. The default version of the generally available Istio managed add-on, 1.4.5, is installed.
  ```
  ibmcloud ks cluster addon enable istio --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Verify that the managed Istio add-on has a status of `Addon Ready`.
  ```
  ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:
  ```
  Name            Version     Health State   Health Status
  istio           1.4.5       normal         Addon Ready
  ```
  {: screen}

4. You can also check out the individual components of the add-on to ensure that the Istio services and their corresponding pods are deployed.
    ```
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```
    NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP                                                                    AGE
    grafana                  ClusterIP      172.21.98.154    <none>          3000/TCP                                                       2m
    istio-citadel            ClusterIP      172.21.221.65    <none>          8060/TCP,9093/TCP                                              2m
    istio-egressgateway      ClusterIP      172.21.46.253    <none>          80/TCP,443/TCP                                                 2m
    istio-galley             ClusterIP      172.21.125.77    <none>          443/TCP,9093/TCP                                               2m
    istio-ingressgateway     LoadBalancer   172.21.230.230   169.46.56.125   80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,
                                                                              8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  2m
    istio-pilot              ClusterIP      172.21.171.29    <none>          15010/TCP,15011/TCP,8080/TCP,9093/TCP                          2m
    istio-policy             ClusterIP      172.21.140.180   <none>          9091/TCP,15004/TCP,9093/TCP                                    2m
    istio-sidecar-injector   ClusterIP      172.21.248.36    <none>          443/TCP                                                        2m
    istio-telemetry          ClusterIP      172.21.204.173   <none>          9091/TCP,15004/TCP,9093/TCP,42422/TCP                          2m
    jaeger-agent             ClusterIP      None             <none>          5775/UDP,6831/UDP,6832/UDP                                     2m
    jaeger-collector         ClusterIP      172.21.65.195    <none>          14267/TCP,14268/TCP                                            2m
    jaeger-query             ClusterIP      172.21.171.199   <none>          16686/TCP                                                      2m
    kiali                    ClusterIP      172.21.13.35     <none>          20001/TCP                                                      2m
    prometheus               ClusterIP      172.21.105.229   <none>          9090/TCP                                                       2m
    tracing                  ClusterIP      172.21.125.177   <none>          80/TCP                                                         2m
    zipkin                   ClusterIP      172.21.1.77      <none>          9411/TCP                                                       2m
    ```
    {: screen}

    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                      READY   STATUS    RESTARTS   AGE
    grafana-76dcdfc987-94ldq                  1/1     Running   0          2m
    istio-citadel-869c7f9498-wtldz            1/1     Running   0          2m
    istio-egressgateway-69bb5d4585-qxxbp      1/1     Running   0          2m
    istio-galley-75d7b5bdb9-c9d9n             1/1     Running   0          2m
    istio-ingressgateway-5c8764db74-gh8xg     1/1     Running   0          2m
    istio-pilot-55fd7d886f-vv6fb              2/2     Running   0          2m
    istio-policy-6bb6f6ddb9-s4c8t             2/2     Running   0          2m
    istio-sidecar-injector-7d9845dbb7-r8nq5   1/1     Running   0          2m
    istio-telemetry-7695b4c4d4-tlvn8          2/2     Running   0          2m
    istio-tracing-55bbf55878-z4rd2            1/1     Running   0          2m
    kiali-77566cc66c-kh6lm                    1/1     Running   0          2m
    prometheus-5d5cb44877-lwrqx               1/1     Running   0          2m
    ```
    {: screen}

5. Next, you can include your apps in the [Istio service mesh](/docs/containers?topic=containers-istio-mesh#istio_sidecar) or set up visualization of your Istio mesh by [creating a secret for Kiali](/docs/containers?topic=containers-istio-health#kiali).

<br />


## Installing the `istioctl` CLI
{: #istioctl}

Install the `istioctl` CLI client. For more information, see the [`istioctl` command reference](https://istio.io/docs/reference/commands/istioctl/){: external}.

1. Download `istioctl`.
  ```
  curl -L https://istio.io/downloadIstio | sh -
  ```
  {: pre}
2. Navigate to the Istio package directory.
  ```
  cd istio-1.4.5
  ```
  {: pre}
3. MacOS and Linux users: Add the `istioctl` client to your `PATH` system variable.
  ```
  export PATH=$PWD/bin:$PATH
  ```
  {: pre}

## Updating the Istio add-on
{: #istio_update}

Update your Istio add-on to the latest version, which is tested by {{site.data.keyword.cloud_notm}} and approved for the use in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

### Updating your add-on from beta versions to the generally available version
{: #istio-ga}

The Istio managed add-on is generally available for Kubernetes version 1.16 and later clusters as of 19 November 2019. The beta version of the managed add-on, which runs Istio version 1.3 or earlier, can no longer be installed on 12 February 2020. In Kubernetes version 1.16 or later clusters, you can [update your add-on](#istio_update) by uninstalling the Istio version 1.3 or earlier add-on and installing the Istio version 1.4 add-on.
{: shortdesc}

After you install the Istio version 1.4 add-on in a Kubernetes version 1.16 or later cluster, {{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates. You can see the changes that are applied in each update in the [Istio add-on changelog](/docs/containers?topic=containers-istio-changelog).

1. Save any resources, such as configuration files for any services or apps, that you created or modified in the `istio-system` namespace. Example command:
   ```
   kubectl get pod <pod_name> -o yaml -n istio-system
   ```
   {: pre}

2. Save the Kubernetes resources that were automatically generated in the namespace of the managed add-on to a YAML file on your local machine. These resources are generated by using custom resource definitions (CRDs).
   1. Get the CRDs for your add-on.
      ```
      kubectl get crd
      ```
      {: pre}

   2. Save any resources created from these CRDs.

3. If you enabled the `istio-sample-bookinfo` and `istio-extras` add-ons, disable them.
   1. Disable the `istio-sample-bookinfo` add-on.
      ```
      ibmcloud ks cluster addon disable istio-sample-bookinfo --cluster <cluster_name_or_ID>
      ```
      {: pre}

   2. Disable the `istio-extras` add-on.
      ```
      ibmcloud ks cluster addon disable istio-extras --cluster <cluster_name_or_ID>
      ```
      {: pre}

4. Disable the Istio add-on.
   ```
   ibmcloud ks cluster addon disable istio --cluster <cluster_name_or_ID> -f
   ```
   {: pre}

5. Before you continue to the next step, verify that all add-on resources are removed.
  1. Verify that the beta Istio add-ons are removed.
     ```
     ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
     ```
     {: pre}
  2. Verify that the `istio-system` namespace is removed.
    ```
    kubectl get namespaces
    ```
    {: pre}

6. Re-enable Istio. The default version of the generally available Istio managed add-on, 1.4, is installed.
   ```
   ibmcloud ks cluster addon enable istio --cluster <cluster_name_or_ID>
   ```
   {: pre}

7. Apply the CRD resources that you saved in step 2.
    ```
    kubectl apply -f <file_name> -n <namespace>
    ```
    {: pre}

8. Optional: [Install the BookInfo sample app.](/docs/containers?topic=containers-istio-mesh#bookinfo_setup) In version 1.4 and later of the managed Istio add-on, the Grafana, Jaeger, and Kiali components that were previously installed by the `istio-extras` add-on are now included in the `istio` add-on. However, the BookInfo sample app that was previously installed by the `istio-sample-bookinfo` add-on is not included in the `istio` add-on and must be installed separately.

9. Optional: If you use TLS sections in your gateway configuration files, you must delete and re-create the gateways so that Envoy can access the secrets.
  ```
  kubectl delete gateway mygateway
  kubectl apply -f mygateway.yaml
  ```
  {: pre}

10. Next, [update your `istioctl` client and sidecars](#update_client_sidecar).

### Updating the `istioctl` client and sidecars
{: #update_client_sidecar}

Whenever the Istio managed add-on is updated, update your `istioctl` client and the Istio sidecars for your app.
{: shortdesc}

For example, the patch version of your add-on might be updated automatically by {{site.data.keyword.containerlong_notm}}, or you might [manually update your add-on](#istio_update) from older beta versions to a generally available version. In either case, update your `istioctl` client and your app's existing Istio sidecars to match the Istio version of the add-on.

1. Get the version of your `istioctl` client and the Istio add-on control plane components.
  ```
  istioctl version
  ```
  {: pre}
  Example output:
  ```
  client version: 1.4.4
  cluster-local-gateway version:
  citadel version: 1.4.5
  egressgateway version: 1.4.5
  egressgateway version: 1.4.5
  galley version: 1.4.5
  ingressgateway version: 1.4.5
  ingressgateway version: 1.4.5
  pilot version: 1.4.5
  policy version: 1.4.5
  sidecar-injector version: 1.4.4
  telemetry version: 1.4.5
  data plane version: 1.0-dev (2 proxies), 1.4.4 (11 proxies), 1.4.5 (10 proxies), 1.1.7 (1 proxies)
  ```
  {: screen}

2. In the output of step 1, compare the `client version` (`istioctl`) to the version of the Istio control plane components, such as the `pilot version`.
  * If the `client version` and control plane component versions match, continue to the next step.
  * If the `client version` and control plane component versions do not match:
    1. Download the `istioctl` client of the same version as the control plane components.
      ```
      curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.4.5 sh -
      ```
      {: pre}
    2. Navigate to the Istio package directory.
      ```
      cd istio-1.4.5
      ```
      {: pre}
    3. MacOS and Linux users: Add the `istioctl` client to your `PATH` system variable.
      ```
      export PATH=$PWD/bin:$PATH
      ```
      {: pre}

3. In the output of step 1, compare the `client version` (`istioctl`) to the `sidecar injector version`.
  * If the `client version` and `sidecar injector version` match, no further updates are required.
  * If the `client version` and `sidecar injector version` do not match, [update your sidecars](https://istio.io/docs/setup/kubernetes/upgrade/steps/#sidecar-upgrade){: external}.

<br />


## Uninstalling Istio
{: #istio_uninstall}

If you're finished working with Istio, you can clean up the Istio resources in your cluster by uninstalling the Istio add-ons.
{:shortdesc}

The `istio` add-on is a dependency for the [`knative`](/docs/containers?topic=containers-serverless-apps-knative) add-on.
{: important}

**Optional**: Any resources that you created or modified in the `istio-system` namespace and all Kubernetes resources that were automatically generated by custom resource definitions (CRDs) are removed. If you want to keep these resources, save them before you uninstall the `istio` add-ons.
1. Save any resources, such as configuration files for any services or apps, that you created or modified in the `istio-system` namespace.
   Example command:
   ```
   kubectl get pod <pod_name> -o yaml -n istio-system
   ```
   {: pre}

2. Save the Kubernetes resources that were automatically generated by CRDs in `istio-system` to a YAML file on your local machine.
   1. Get the CRDs in `istio-system`.
      ```
      kubectl get crd -n istio-system
      ```
      {: pre}

   2. Save any resources created from these CRDs.

### Uninstalling the Istio add-on from the console
{: #istio_uninstall_ui}

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to remove the Istio add-on.

2. Click the **Add-ons** tab.

3. On the Managed Istio card, click the Action menu icon.

4. Click **Uninstall**. The managed Istio add-on is disabled in this cluster and all Istio resources in this cluster are removed.

5. On the Managed Istio card, verify that the add-on you uninstalled is no longer listed.

### Uninstalling managed Istio add-ons from the CLI
{: #istio_uninstall_cli}

If you did not install the deprecated `istio-sample-bookinfo` and `istio-extras` add-ons, skip steps 1 and 2.
{: tip}

1. Disable the `istio-sample-bookinfo` add-on.
  ```
  ibmcloud ks cluster addon disable istio-sample-bookinfo --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Disable the `istio-extras` add-on.
  ```
  ibmcloud ks cluster addon disable istio-extras --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Disable the `istio` add-on.
  ```
  ibmcloud ks cluster addon disable istio --cluster <cluster_name_or_ID> -f
  ```
  {: pre}

4. Verify that all managed Istio add-ons are disabled in this cluster. No Istio add-ons are returned in the output.
  ```
  ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
  ```
  {: pre}

### Uninstalling other Istio installations in your cluster
{: #istio_uninstall_other}

If you previously installed Istio in the cluster by using the IBM Helm chart or through another method, clean up that Istio installation before you enable the managed Istio add-on in the cluster. To check whether Istio is already in a cluster, run `kubectl get namespaces` and look for the `istio-system` namespace in the output.
{: shortdesc}

- If you installed Istio by using the {{site.data.keyword.cloud_notm}} Istio Helm chart:
  1. Uninstall the Istio Helm deployment.
    ```
    helm del istio --purge
    ```
    {: pre}

  2. If you used Helm 2.9 or earlier, delete the extra job resource.
    ```
    kubectl -n istio-system delete job --all
    ```
    {: pre}

  3. The uninstallation process can take up to 10 minutes. Before you install the Istio managed add-on in the cluster, run `kubectl get namespaces` and verify that the `istio-system` namespace is removed.

- If you installed Istio manually or used the Istio community Helm chart, see the [Istio uninstall documentation](https://istio.io/docs/setup/kubernetes/install/kubernetes/#uninstall-istio-core-components){: external}.
* If you previously installed BookInfo in the cluster, clean up those resources.
  1. Change the directory to the Istio file location.
    ```
    cd <filepath>/istio-1.4.5
    ```
    {: pre}

  2. Delete all BookInfo services, pods, and deployments in the cluster.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

  3. The uninstallation process can take up to 10 minutes. Before you install the Istio managed add-on in the cluster, run `kubectl get namespaces` and verify that the `istio-system` namespace is removed.

<br />


## Troubleshooting
{: #istio-ts}

To resolve some common issues that you might encounter when you use the managed Istio add-on, see [Troubleshooting managed add-ons](/docs/containers?topic=containers-cs_troubleshoot_addons).
{: shortdesc}
