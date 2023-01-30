---

copyright:
  years: 2022, 2023
lastupdated: "2023-01-30"

keywords: kubernetes, help

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why can't I upgrade to version 1.12 of the managed Istio add-on?
{: #ts-addon-istio-webhooks}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

When you upgrade your managed Istio components from version 1.11 to version 1.12, the upgrade does not complete. 
{: tsSymptoms}

When you [check the status](/docs/containers?topic=containers-debug_addons) of the Istio add-on, the **HEALTH STATUS** remains set to `(1.11 --> 1.12)`.

```sh
Name    Version   Health State   Health Status   
istio   1.12      updating       (1.11 --> 1.12)   
```
{: screen}

Additionally, when you check the logs for the `addon-istio-operator` pod by running `kubectl logs -n ibm-operators -l name=managed-istio-operator`, you see the following error messages.

```sh
Error [IST0139] (MutatingWebhookConfiguration istio-sidecar-injector) Webhook overlaps with others: [istio-sidecar-injector/namespace.sidecar-injector.istio.io]. This may cause injection to occur twice.
Error [IST0139] (MutatingWebhookConfiguration istio-sidecar-injector) Webhook overlaps with others: [istio-sidecar-injector/sidecar-injector.istio.io]. This may cause injection to occur twice.
```
{: screen}

If the Istio add-on instance you are upgrading was provisioned at version 1.10 or earlier, there are webhook issues that must be resolved before you can upgrade to version 1.12.
{: tsCauses}

To resolve the webhook errors and continue the version upgrade, follow the instructions in step 4 of [Updating the minor version of the Istio add-on](/docs/containers?topic=containers-istio#istio_minor).
{: tsResolve}

Wait for the upgrade to proceed. Then, [check the Istio health status](/docs/containers?topic=containers-debug_addons) to verify that the add-on is functioning normally.

```sh
Name    Version   Health State   Health Status   
istio   1.12      normal         Addon Ready   
```
{: screen}

