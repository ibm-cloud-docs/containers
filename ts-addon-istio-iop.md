---

copyright:
  years: 2022, 2022
lastupdated: "2022-11-29"

keywords: custom gateway, reconcile loop, istio, IOP, help

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Why does my custom gateway Istio operator have a reconcile loop error?
{: #istio_control_plane}
{: support}

Supported infrastructure providers
:   Classic
:   VPC


When you check your IstioOperator (IOP) logs, you notice a reconcile loop, indicated by the following line repeating in the logs.
{: tsSymptoms}

```sh
2022-09-29T12:57:48.412711Z info installer Reconciling IstioOperator
```
{: screen}

Normally, a reconcile begins with the `info installer Reconciling IstioOperator` message and ends when the configuration is validated and deployments are updated. If the reconcile restarts, there is an issue in the [custom gateway IstioOperator (IOP) resource configuration](/docs/containers?topic=containers-istio-custom-gateway#custom-ingress-gateway-public) that causes the operator to restart. 
{: tsCauses}

In a test cluster, parse through the IOP resource configuration to find the line that contains the error.
{: tsResolve}

1. [Copy](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#cp){: external} your IOP resource configuration and save it to a safe location.

2. Create a new YAML file to test each section of the IOP resource. Consider naming it `iop-test.yaml`. 

3. Copy and paste a section from your IOP resource configuration into the test file. 

4. Apply the test file in a test cluster.

    To avoid disruptions to your workload, it is recommended that you follow these steps in a test cluster.
    {: important}

    ```sh
    kubectl apply -f iop-test.yaml
    ```
    {: pre}

5. Wait a few minutes then check the Istio operator pod logs for a reconcile loop error. If there is no reconcile loop error, add the next section of the IOP resource configuration to the test file, reapply the file, and check the logs again. Continue checking each section of the IOP resource configuration until you see the reconcile loop error in the logs.

    To check the Istio operator pod logs, run the following command.

    ```sh
    kubectl logs -n ibm-operators -l name=addon-istio-operator
    ```
    {: pre}

6. After you have determined which section in the IOP resource configuration caused the reconcile loop error, repeat the above process with each individual line in the section until you determine the line that is causing the error. 

7. Debug the line to resolve the error. 

8. Repeat the process with the remaining sections until you have copied all the original IOP configuration into the test file and determined that no errors remain. 

9. Remove the test file.
    ```sh
    kubectl remove <test_iop_name>
    ```
    {: pre}

10. Update your original IOP resource configuration to replace the line that caused the error. Then, reapply the original IOP resource to your production cluster.
    ```sh
    kubectl apply -f iop.yaml
    ```
    {: pre}


