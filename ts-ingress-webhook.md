---

copyright: 
  years: 2024, 2024
lastupdated: "2024-06-26"

connectivitykeywords: kubernetes, ingress, webhook, alb, validation

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Ingress resource operations refused by validating webhook
{: #ts-ingress-webhook}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

When running kubectl commands to update or create Ingress resources, you see error messages similar to the following examples.
{: tsSymptoms}


```sh
Error from server (BadRequest): error when creating "example-ingress.yaml": admission webhook "validate.nginx.ingress.kubernetes.io" denied the request: nginx.ingress.kubernetes.io/configuration-snippet annotation cannot be used. Snippet directives are disabled by the Ingress administrator
```
{: pre}

```sh
Error from server (InternalError): error when creating "test-broken-ingress.yaml": Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io": failed to call webhook: Post "https://public-crcppcl2s207t5c95g1qgg-alb1-ingress-admission.kube-system.svc:443/networking/v1/ingresses?timeout=10s": no endpoints available for service "public-crcppcl2s207t5c95g1qgg-alb1-ingress-admission"
```
{: pre}


Depending on the issue, you might not be able to create or update certain or all Ingress resources. You might also being prevented to use certain configurations.


Ingress validation is enabled to forbid the application of possibly invalid Ingress resources. The configuration you are trying to apply is invalid and refused or the webhook is failing.
{: tsCauses}

When Ingress validation is enabled, a validating webhook is deployed to the cluster that validates each Ingress resource before they are created or updated. This webhook calls one of the ALB replicas from each ALB deployment (where validation is enabled) and that ALB pod validates the resource. The webhook has a FailurePolicy configured that prevents the operation succeeding in case no pods for an ALB is available.

Ingress validation deny invalid resources as part of its normal operation, so it is important to identify the reason for refusing a particular resource.

Check out the following sections to identify and mitigate the issue.
{: tsResolve}

## Invalid configurations denied by the validation webhook
{: #invalid-config}

In cases of normal operation, when the Ingress resource is denied, the failure information contains a `denied the request` response with a reason indicating the problem.

```sh
Error from server (BadRequest): error when creating "example-ingress.yaml": admission webhook "validate.nginx.ingress.kubernetes.io" denied the request: nginx.ingress.kubernetes.io/configuration-snippet annotation cannot be used. Snippet directives are disabled by the Ingress administrator
```
{: pre}

In this case, you should verify that the Ingress resource you are trying to apply is valid for that ALB, and also the features that it is trying to use is available and enabled (such as snippet annotations). After you corrected the resource you can simply retry applying the resource.

## The webhook itself is failing
{: #webhook-debug}

In case of an issue with the webhook itself, you will not see `denied the request` in the failure information, instead you will encounter an `Internal error occurred` message, such as the following example.

```sh
Error from server (InternalError): error when creating "example-ingress.yaml": Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io": Post https://public-crcppcl2s207t5c95g1qgg-alb1-ingress-admission.kube-system.svc:443/networking/v1/ingresses?timeout=10s: dial tcp 172.21.70.236:443: connect: connection timed out
```
{: pre}

For debugging the webhook itself, review our documentation on [Debugging webhooks](/docs/containers?topic=containers-ts-webhook-debug). As part of investigation or fixing the issue, you might want to disable the validation feature for the ALB, to do this, refer to [Disabling the validation feature](#disable-validation) section.

## Disabling the validation feature
{: #disable-validation}

Sometimes you might want to disable the validation webhook as part of a debugging or restoring service. To do this, you must set the `enableIngressValidation` config option to `"false"` in the [ConfigMap for customizing ingress deployment](/docs/containers?topic=containers-comm-ingress-annotations#create-ingress-configmap-custom).

Note that this configuration option exists per ALB so you can selectively enable or disable this feature for individual ALB deployments.

Enabling or disabling the validation webhooks might take a few minutes. To check the validation webhooks currently effective for your cluster you can use the following kubectl command:

```sh
kubectl get -n kube-system ValidatingWebhookConfiguration -l 'app.kubernetes.io/part-of=managed-ingress'
```
{: pre}


