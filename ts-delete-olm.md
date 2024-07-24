---

copyright: 
  years: 2022, 2024
lastupdated: "2024-07-24"


keywords: kubernetes, OLM, operator lifecycle manager, delete olm, delete operator lifecycle manager components

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# How do I delete Operator Lifecycle Manager components?
{: #ts-delete-olm}

Operator Lifecycle Manager (OLM) is not installed or managed on clusters that run Kubernetes version 1.23 or later. However, clusters that were upgraded from version 1.22 to version 1.23 or later might still have the OLM components installed. If you are not using OLM components on your cluster, follow these steps to remove them.

If you want to continue using OLM components in your cluster, or you want to install and run OLM on a cluster that runs version 1.23 or later, you must manage updates yourself. Refer to the [open source OLM documentation](https://olm.operatorframework.io/).
{: note}


1. Confirm that you have the OLM operator installed.

    ```sh
    kubectl get deploy -n ibm-system olm-operator
    ```
    {: pre}

    Example output

    ```sh
    NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
    olm-operator                           1/1     1            1           6mo
    ```
    {: pre}


1. Check if you are using versions 1.4 through 1.9 of the Istio add-on. Istio versions 1.4 through 1.9 are unsupported and use OLM. If you use these versions, [upgrade to a supported version of the Istio add-on](/docs/containers?topic=containers-istio-changelog&interface=ui) that does not use the OLM operator. After you upgrade to a supported Istio version, you can delete the OLM operator.  
    ```sh
    ibmcloud ks cluster addons -c CLUSTER
    ```
    {: pre}

    In this example output, OLM is still used by the Istio add-on version 1.5. Upgrade the add-on, then continue these steps.

    ```sh
    NAME            Version     Health State   Health Status
    istio           1.5         normal         Addon Ready
    ```

1. Check if there are any operators in use that were deployed through OLM by listing the cluster service versions.
    ```sh
    kubectl get clusterserviceversions -A
    ```
    {: pre}

    Example output of an operator that was deployed through OLM.
    ```sh
    NAMESPACE                              NAME            DISPLAY          VERSION   REPLACES   PHASE
    kubernetes-operator-lifecycle-manager   packageserver   Package Server   0.19.0               Succeeded
    ```
    {: screen}

    If there are `clusterserviceversions` listed in the output, you are still using operators that are managed through OLM. You can continue to use the OLM, but you are responsible managing updates. The following steps assume you are no longer using OLM and provide clean up instructions, do not continue if you are still using OLM.
    {: important}

1. If there were no `clusterserviceversions` instances in the output of step 3, you are not using OLM. You can now get a list of the resources that were created by OLM and remove them.


1. For each CRD in the following list, get the custom resources (CRs) across all namespaces.
    ```sh
    kubectl get catalogsources.operators.coreos.com -A
    kubectl get clusterserviceversions.operators.coreos.com -A
    kubectl get installplans.operators.coreos.com -A
    kubectl get operatorgroups.operators.coreos.com -A
    kubectl get operators.operators.coreos.com -A
    kubectl get subscriptions.operators.coreos.com -A
    ```
    {: pre}

1. If you find CRs, determine whether you still need these resources.
    - You might still see the `olm-operators` and `ibm-operators` operator groups that were deployed by OLM. These operator groups were part of the installation of OLM. Because you do not have any `cluseterserviceversions` instances  in the previous steps, you are no longer using these operator groups.
    - If you had version 1.4 - 1.9 of the Istio add-on installed in the past, you might still see the `istio` `operators.operators.coreos.com` resource in the `ibm-operators` namespace. If you upgraded Istio to at least version 1.10, then you no longer need this resource.
    - If you find other CRs, chances are you are not using them because you didn't have any `clusterserviceversions` instances in the previous steps. However, review each CR with your cluster admin on a case-by-case basis to determine whether they are still being used.
    
    The following steps assume you've completed the review and guide you through deleting OLM.
    {: note}


1. If you determined that OLM is not used by the Istio add-on or any additional operators, run the following commands separately to delete OLM resources.
    ```sh
    kubectl delete clusterrole aggregate-olm-edit 
    kubectl delete clusterrole aggregate-olm-view
    kubectl delete deploy -n ibm-system catalog-operator
    kubectl delete deploy -n ibm-system olm-operator
    kubectl delete clusterrole system:controller:operator-lifecycle-manager
    kubectl delete serviceaccount -n ibm-system olm-operator-serviceaccount
    kubectl delete clusterrolebinding olm-operator-binding-ibm-system
    kubectl delete operatorgroup -n ibm-operators  ibm-operators
    kubectl delete operatorgroup -n ibm-system   olm-operators
    kubectl delete service -n ibm-system catalog-operator-metrics
    kubectl delete service -n ibm-system olm-operator-metrics
    ```
    {: pre}

1. Delete any unused CRs, then delete the custom resource definitions (CRD) that were installed by OLM.

    ```sh
    kubectl delete catalogsources.operators.coreos.com NAME -n NAMESPACE
    ```
    {: pre}

    ```sh
    kubectl delete crd catalogsources.operators.coreos.com
    ```
    {: pre}

1. Repeat the previous steps for each of the following CRDs.
    - `catalogsources.operators.coreos.com`
    - `clusterserviceversions.operators.coreos.com`
    - `installplans.operators.coreos.com`
    - `operatorgroups.operators.coreos.com`
    - `operators.operators.coreos.com`
    - `subscriptions.operators.coreos.com`
    
    
    
    
