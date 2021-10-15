---

copyright:
  years: 2014, 2021
lastupdated: "2021-10-15"

keywords: kubernetes, iks

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

  

# Why does binding a service to a cluster result in a same name error?
{: #ts-app-svc-bind-name}

**Infrastructure provider**:
* ![Classic infrastructure provider icon.](images/icon-classic-2.svg) Classic
* ![VPC infrastructure provider icon.](images/icon-vpc-2.svg) VPC


When you run `ibmcloud ks cluster service bind --cluster <cluster_name> --namespace <namespace> --service <service_instance_name>`, you see the following message.
{: tsSymptoms}

```
Multiple services with the same name were found.
Run 'ibmcloud service list' to view available Bluemix service instances...
```
{: screen}


Multiple service instances might have the same name in different regions.
{: tsCauses}


Use the service GUID instead of the service instance name in the `ibmcloud ks cluster service bind` command.
{: tsResolve}

1. [Log in to the {{site.data.keyword.cloud_notm}} region that includes the service instance to bind.](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)

2. Get the GUID for the service instance.
    ```sh
    ibmcloud service show <service_instance_name> --guid
    ```
    {: pre}

    Example output

    ```sh
    Invoking 'cf service <service_instance_name> --guid'...
    <service_instance_GUID>
    ```
    {: screen}

3. Bind the service to the cluster again.
    ```sh
    ibmcloud ks cluster service bind --cluster <cluster_name> --namespace <namespace> --service <service_instance_GUID>
    ```
    {: pre}









