---

copyright: 
  years: 2022, 2022
lastupdated: "2022-12-09"

keywords: kubernetes, OLM, operator lifecycle manager, delete olm, delete operator lifecycle manager components

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# How do I delete Operator Lifecycle Manager components?
{: #ts-delete-olm} 

Operator Lifecycle Manager (OLM) is not installed or managed on clusters that run Kubernetes version 1.23 or later. However, clusters that were upgraded from version 1.22 to version 1.23 or later might still have the OLM components installed. If you are not using OLM components on your cluster, follow these steps to remove them. 

If you want to continue using OLM components in your cluster, or you want to install and run OLM on a cluster that runs version 1.23 or later, you must manage updates yourself. Refer to the [opensource OLM documentation](https://olm.operatorframework.io/).
{: note} 


1. Confirm that you have the OLM operator installed. 

    ```sh
    kubectl get deploy -n ibm-system olm-operator
    ```
    {: pre}

    Example output.

    ```sh
    NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
    olm-operator                           1/1     1            1           6mo
    ```
    {: pre}

2. If the OLM operator is installed in your cluster, check if it is in use. 

    1. Check if you are using versions 1.4 through 1.9 of the Istio add-on. These Istio add-on versions use the OLM operator but are unsupported. 
        ```sh
        ibmcloud ks cluster addons -c CLUSTERID
        ```
        {: pre}

        Example output. In this example, the OLM is still used by the Istio add-on. 

        ```sh
        NAME            Version     Health State   Health Status
        istio           1.5         normal         Addon Ready
        ```

        Istio versions 1.4 through 1.9 are unsupported. If you use these versions, [upgrade to a supported version of the Istio add-on](/docs/containers?topic=containers-istio-changelog&interface=ui) that does not use the OLM operator. Then, you can delete the OLM operator. 
        {: tip}

    2. Check if there are any operators in use that were deployed through OLM. 
        ```sh
        kubectl get clusterserviceversions.operators.coreos.com -A
        ```
        {: pre}

        Example output of an operator that was deployed through OLM. 
        ```sh
        NAMESPACE                              NAME            DISPLAY          VERSION   REPLACES   PHASE
        kubernetes-operator-lifecycle-manager   packageserver   Package Server   0.19.0               Succeeded
        ```
        {: pre}


3. If you determined that OLM is not used by the Istio add-on or any additional operators, run each command individually to delete OLM resources.
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

4. If you determined that OLM is not used by the Istio add-on or any additional operators, delete any unused custom resource definitions (CRD) that were installed by OLM.
    1. List the custom resources (CR) of each CRD.
        ```sh 
        kubectl get crd catalogsources.operators.coreos.com -A
        ```
        {: pre}

        Example output listing the associated CRs.
        ```sh
        NAME                                  CREATED AT
        catalogsources.operators.coreos.com   2022-06-28T13:43:31Z
        ```
        {: screen}

    2. Get the details of each CR to determine if it is used. 
        ```sh
        kubectl get catalogsources.operators.coreos.com -A
        ```
        {: pre}

        Example output showing that the CR is not used.
        ```sh
        No resources found.
        ```
        {: screen}

    3. If the CRs are not used, delete the CRD.
        ```sh
        kubectl delete crd catalogsources.operators.coreos.com
        ```
        {: pre}

    4. Repeat the previous steps for each of the following CRDs.
        - catalogsources.operators.coreos.com
        - clusterserviceversions.operators.coreos.com
        - installplans.operators.coreos.com   
        - operatorgroups.operators.coreos.com
        - operators.operators.coreos.com
        - subscriptions.operators.coreos.com
