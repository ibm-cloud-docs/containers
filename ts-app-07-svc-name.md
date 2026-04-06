---

copyright:
  years: 2014, 2026
lastupdated: "2026-04-06"


keywords: kubernetes

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why does binding a service to a cluster result in a same name error?
{: #ts-app-svc-bind-name}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


When you try to bind an {{site.data.keyword.cloud_notm}} service to your cluster, you see an error message indicating that multiple services with the same name were found.
{: tsSymptoms}

```txt
Multiple services with the same name were found.
Run 'ibmcloud resource service-instances' to view available IBM Cloud service instances...
```
{: screen}


Multiple service instances might have the same name in different regions or resource groups.
{: tsCauses}


Use the service instance GUID or CRN to uniquely identify the service when creating service credentials and binding them to your cluster.
{: tsResolve}

1. [Log in to the {{site.data.keyword.cloud_notm}} region that includes the service instance to bind.](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)

2. List your service instances and get the GUID or CRN for the specific service instance.
    ```sh
    ibmcloud resource service-instances --output json | grep -A 5 "<service_instance_name>"
    ```
    {: pre}

    Example output showing the GUID and CRN:

    ```sh
    "guid": "1234abcd-5678-efgh-9012-ijklmnop3456",
    "crn": "crn:v1:bluemix:public:service-name:us-south:a/abc123:1234abcd-5678-efgh-9012-ijklmnop3456::",
    ```
    {: screen}

3. Create service credentials for the service instance using the GUID or CRN.
    ```sh
    ibmcloud resource service-key-create <key_name> <role> --instance-id <service_instance_GUID>
    ```
    {: pre}

4. Get the service credentials.
    ```sh
    ibmcloud resource service-key <key_name> --output json
    ```
    {: pre}

5. Create a Kubernetes secret in your cluster with the service credentials.
    ```sh
    kubectl create secret generic <secret_name> --from-literal=<key>=<value> -n <namespace>
    ```
    {: pre}

6. Reference the secret in your app deployment to access the service credentials.

For more information, see [Adding services by using IBM Cloud service binding](/docs/containers?topic=containers-service-binding).
