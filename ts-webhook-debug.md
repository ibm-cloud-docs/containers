---

copyright: 
  years: 2022, 2025
lastupdated: "2025-09-18"


keywords: kubernetes, help, network, connectivity, webhooks

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}





# Debugging webhooks
{: #ts-webhook-debug}
{: support}

When running kubectl commands, you see error messages similar to the following examples.


```sh
Error from server (InternalError): error when creating "testjob.yaml": Internal error occurred: failed calling webhook "mywebhook.test.io": Post https://admission-webhook.default.svc:443/validate?timeout=30s: dial tcp 172.21.189.228:443: connect: connection timed out
```
{: pre}

```sh
error creating namespace "test": Internal error occurred: admission plugin "MutatingAdmissionWebhook" failed to complete mutation in 13s
```
{: pre}

Failing webhooks might also cause problems similar to the following issues.
{: tsSymptoms}

- You can't create or modify pods, secrets, or namespaces.
- You can't add worker nodes to a cluster or create a secret that holds the LUKS encryption key.
- You can't patch, update, or upgrade and the underlying failure is related to creating resources in the cluster.


A problem in the called service or the secure tunnel can cause requests to fail due to timeouts. You might be unaware that you have admission control webhooks installed until this happens.
{: tsCauses}

Admission control webhooks provide the ability to validate or modify, or mutate, Kubernetes API requests. These webhooks are called from the cluster `apiserver` or `openshift-apiserver` and typically call a service running in the cluster. Admission control webhooks have rules defining the kind of resource such as pod, namespace, and so on and the operation they are called for, such as create, retrieve, update, or delete.

Webhooks have a failure policy that indicates whether Kubernetes can ignore connection errors when calling the webhook or whether connection error  must fail the operation. A `ValidatingWebhookConfiguration` resource inspects the request while a `MutatingWebhookConfiguration` resource modifies the request data before it is processed.

Webhooks can also deny requests as part of normal operation: A webhook might deny requests that violate security policies or it might perform other data validation. In such cases the failure information contains a `denied the request` response with a reason indicating the problem.

```sh
admission webhook "mutate.configuration.upsert.appconnect.ibm.com" denied the request: version is not supported
```
{: pre}

In {{site.data.keyword.containerlong_notm}}, webhooks that call services running in the cluster do so by using a secure tunnel that connects the cluster control plane in an {{site.data.keyword.cloud_notm}} account to cluster worker nodes in your customer account.

Complete the following steps to identify the webhook that is causing the issue. Then debug the related service and remove or recreate your webhook if needed.
{: tsResolve}

1. Run the following commands to get the VPN pod logs. If you can't get the VPN logs, follow the steps to [Debug common CLI issues](/docs/containers?topic=containers-ts_clis) and return to this page when you are able to retrieve the logs. If the commands succeed and you can get the logs, the VPN tunnel is working and you can continue to the next step.

    ```sh
    kubectl get pods -n kube-system -l app=vpn
    ```
    {: pre}

    ```sh
    kubectl logs -n kube-system -l app=vpn
    ```
    {: pre}

1. Describe your admission control webhooks and save the output to a file called `webhooks.txt`.
    ```sh
    kubectl describe mutatingwebhookconfigurations,validatingwebhookconfigurations > webhooks.txt
    ```
    {: pre}

1. Review the `webhooks.txt` file for error messages. Webhook related error messages from an application, including kubectl, can help to identify the webhook.

1. Review the apiserver metrics for rejection type, count, and the rejection code. You can get a snapshot of the metrics by using the following command.
    ```sh
    kubectl get --raw /metrics | grep apiserver_admission_webhook_rejection_count
    ```
    {: pre}
    
    ```sh
    apiserver_admission_webhook_rejection_count{error_type="calling_webhook_error",name="check-ignore-label.gatekeeper.sh",operation="UPDATE",rejection_code="0",type="validating"} 16
    ```
    {: pre}

    A `rejection_code` value of 0 indicates an error occurred when calling the webhook. A non-zero `rejection_code` value indicates the webhook rejected the request.
    {: note}

    There are 3 apiserver instances. The kubectl command gets metrics from one of them and reflects the activity there. Each apiserver returns different data. Instances that have not processed the failing requests might not return this metric.
    {: important}


1. Review the command output from the previous steps and look for webhook descriptions to identify the specific `MutatingWebhookConfiguration` or `ValidatingWebhookConfiguration` value. If the errors, logs, or metrics do not help, review the webhook descriptions that you retrieved earlier. Each webhook configuration has a set of rules that specify the kinds of resources and actions the webhook is called for. This information can be used to identify the webhook(s) that might be involved.

    - If there is an error calling the webhook, review the documentation for that service for product-specific debugging steps.

    - If the webhook is rejecting the requests, look at the policies and configuration options for the webhook. It might be possible to adjust them to allow the request. Or, the request might be violating the policies and the request or the application making the request need to be changed. For more information, see [What are the best practices for using webhooks](/docs/containers?topic=containers-access_webhooks#webhook-best-practice).


## Reviewing the service that the webhook is calling
{: #review-webhook-service}

1. Get the details of the service and its endpoints.
    ```sh
    kubectl get svc NAME -n NAMESPACE
    ```
    {: pre}
    
    ```sh
    kubectl get ep NAME -n NAMESPACE
    ```
    {: pre}

    - If the webhook is calling a service that doesn't exist, the webhook might be leftover from an incomplete or improper removal of an application. In this case, look for service-specific documentation and follow the steps to uninstall the service.

    - If you are unable to uninstall the service, delete the webhook configuration.
 
        ```sh
        kubectl delete validatingwebhookconfiguration NAME
        ```
        {: pre}
        
        ```sh
        kubectl delete mutatingwebhookconfiguration NAME
        ```
        {: pre}

1. If the service exists, but has no endpoints, check the health of the pods. First, get the pod labels from the service.
    ```sh
    kubectl describe svc NAME -n NAMESPACE
    ```
    {: pre}
    
    Example output
    ```sh
    Selector:          app=my-webhook
    ```
    {: screen}

1. List the pods that are using the labels. For example, the label in the following command is `app=mywebhook`.
    ```sh
    kubectl get pods -n NAMESPACE -l app=my-webhook
    ```
    {: pre}

1. Review the command output. If the pods are not healthy check the pod events, logs, worker node health, and other components to troubleshoot. For more information, see [Debugging app deployments](/docs/containers?topic=containers-debug_apps).

## Disabling or removing a webhook
{: #webhook-disable-rm}

1. Temporarily ignore connection and timeouts by setting the failure policy to `Ignore`. Edit the webhook by running the following commands.
    ```sh
    kubectl edit validatingwebhookconfiguration NAME
    ```
    {: pre}
    
    ```sh
    kubectl edit mutatingwebhookconfiguration NAME
    ```
    {: pre}

1. Search for `failurePolicy` and change the value to `Ignore`.

1. Save the configuration and exit the editor. If adjusting the failure policy doesn't resolve the issue, repeat the previous steps and change the value back to `Fail`.

1. Temporarily remove the webhook. Save the existing webhook configuration to a file before deleting it.
    ```sh
    kubectl get validatingwebhookconfiguration NAME -o yaml > webhook-config.yaml
    ```
    {: pre}

    ```sh
    kubectl get mutatingwebhookconfiguration NAME -o yaml > webhook-config.yaml
    ```
    {: pre}

1. Delete the webhook configuration.
    ```sh
    kubectl delete validatingwebhookconfiguration NAME
    ```
    {: pre}

    ```sh
    kubectl delete mutatingwebhookconfiguration NAME
    ```
    {: pre}

1. Wait a few minutes, then retry the `kubectl` commands that were failing to see if the problem is resolved.

1. Recreate the webhook.
    ```sh
    kubectl apply -f webhook-config.yaml
    ```
    {: pre}

1. If the issue persists, contact support. Open a [support case](/docs/account?topic=account-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.
