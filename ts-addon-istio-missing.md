---

copyright:
  years: 2014, 2024
lastupdated: "2024-01-03"


keywords: kubernetes, help

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why are Istio components missing?
{: #istio_components_missing}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


One or more of the Istio control plane components, such as `istiod`, does not exist in your cluster.
{: tsSymptoms}

Review the following possible causes:
{: tsCauses}

* You deleted one of the Istio deployments that is installed in your cluster Istio managed add-on.
* You changed the default `IstioOperator` (IOP) resource. When you enable the managed Istio add-on, you can't use `IstioOperator` (`iop`) resources to customize the Istio control plane installation. Only the `IstioOperator` resources that are managed by IBM for the Istio control plane are supported. Changing the control plane settings might result in an unsupported control plane state. If you create an `IstioOperator` resource for custom gateways in your Istio data plane, you are responsible for managing those resources.


To verify the control plane components installation:
{: tsResolve}

1. Check the values of any customizations that you specified in the customization ConfigMap. For example, if the value of the `istio-components-pilot-requests-cpu` setting is too high, control plane components might not be scheduled.
    ```sh
    kubectl describe cm managed-istio-custom -n ibm-operators
    ```sh
    {: pre}

2. Check the logs of the Istio operator. If any logs indicate that the operator is failing to reconcile your customization settings, verify your settings for the [customized Istio installation](/docs/containers?topic=containers-istio#customize) again.
    ```sh
    kubectl logs -n ibm-operators -l name=managed-istio-operator
    ```
    {: pre}

3. Optional: To refresh your `managed-istio-custom` ConfigMap resource, delete the ConfigMap from your cluster. After about 5 minutes, a default ConfigMap that contains the original installation settings is created in your cluster. The Istio operator reconciles the installation of Istio to the original add-on settings, including the core components of the Istio control plane.
    ```sh
    kubectl delete cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

4. If Istio control plane components or other Istio resources are still unavailable, refresh the cluster master.
    ```sh
    ibmcloud ks cluster master refresh -c <cluster_name_or_ID>
    ```
    {: pre}






