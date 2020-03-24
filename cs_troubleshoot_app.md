---

copyright:
  years: 2014, 2020
lastupdated: "2020-03-24"

keywords: kubernetes, iks, help

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


# Apps and services
{: #cs_troubleshoot_app}

As you use {{site.data.keyword.containerlong}}, consider these techniques for troubleshooting app deployments and integrated services.
{: shortdesc}

While you troubleshoot, you can use the [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) to run tests and gather pertinent information from your cluster.
{: tip}

## Debugging app deployments
{: #debug_apps}

Review the options that you have to debug your app deployments and find the root causes for failures.

Before you begin, ensure you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for the namespace where your app is deployed.

1. Look for abnormalities in the service or deployment resources by running the `describe` command.
    ```
    kubectl describe service <service_name>
    ```
    {: pre}

2. [Check whether the containers are stuck in the `ContainerCreating` state](/docs/containers?topic=containers-cs_troubleshoot_storage#stuck_creating_state).

3. Check whether the cluster is in the `Critical` state. If the cluster is in a `Critical` state, check the firewall rules and verify that the master can communicate with the worker nodes.

4. Verify that the service is listening on the correct port.
   1. Get the name of a pod.
      ```
      kubectl get pods
      ```
      {: pre}
   2. Log in to a container.
      ```
      kubectl exec -it <pod_name> -- /bin/bash
      ```
      {: pre}
   3. Curl the app from within the container. If the port is not accessible, the service might not be listening on the correct port or the app might have issues. Update the configuration file for the service with the correct port and redeploy or investigate potential issues with the app.
      ```
      curl localhost: <port>
      ```
      {: pre}

5. Verify that the service is linked correctly to the pods.
   1. Get the name of a pod.
      ```
      kubectl get pods
      ```
      {: pre}
   2. Log in to a container.
      ```
      kubectl exec -it <pod_name> -- /bin/bash
      ```
      {: pre}
   3. Curl the cluster IP address and port of the service.
      ```
      curl <cluster_IP>:<port>
      ```
      {: pre}
   4. If the IP address and port are not accessible, look at the endpoints for the service.
      * If no endpoints are listed, then the selector for the service does not match the pods. For example, your app deployment might have the label `app=foo`, but the service might have the selector `run=foo`.
      * If endpoints are listed, then look at the target port field on the service and make sure that the target port is the same as what is being used for the pods. For example, your app might listen on port 9080, but the service might listen on port 80.

6. For Ingress services, verify that the service is accessible from within the cluster.
   1. Get the name of a pod.
      ```
      kubectl get pods
      ```
      {: pre}
   2. Log in to a container.
      ```
      kubectl exec -it <pod_name> -- /bin/bash
      ```
      {: pre}
   2. Curl the URL specified for the Ingress service. If the URL is not accessible, check for a firewall issue between the cluster and the external endpoint.
      ```
      curl <host_name>.<domain>
      ```
      {: pre}

<br />




## Failed to pull image from registry with `ImagePullBackOff` or authorization errors
{: #ts_image_pull}

{: tsSymptoms}

When you deploy a workload that pulls an image from {{site.data.keyword.registrylong_notm}}, your pods fail with an **`ImagePullBackOff`** status.

```
kubectl get pods
```
{: pre}

```
NAME         READY     STATUS             RESTARTS   AGE
<pod_name>   0/1       ImagePullBackOff   0          2m
```
{: screen}

When you describe the pod, you see authentication errors similar to the following.

```
kubectl describe pod <pod_name>
```
{: pre}

```
Failed to pull image "<region>.icr.io/<namespace>/<image>:<tag>" ... unauthorized: authentication required
Failed to pull image "<region>.icr.io/<namespace>/<image>:<tag>" ... 401 Unauthorized
```
{: screen}

```
Failed to pull image "registry.ng.bluemix.net/<namespace>/<image>:<tag>" ... unauthorized: authentication required
Failed to pull image "registry.ng.bluemix.net/<namespace>/<image>:<tag>" ... 401 Unauthorized
```
{: screen}

{: tsCauses}
Your cluster uses an API key or token that is stored in an [image pull secret](/docs/containers?topic=containers-registry#cluster_registry_auth) to authorize the cluster to pull images from {{site.data.keyword.registrylong_notm}}. By default, new clusters have image pull secrets that use API keys so that the cluster can pull images from any regional `icr.io` registry for containers that are deployed to the `default` Kubernetes namespace.

For clusters that were created before **1 July 2019**, the cluster might have an image pull secret that uses a token. Tokens grant access to {{site.data.keyword.registrylong_notm}} for only certain regional registries that use the deprecated `<region>.registry.bluemix.net` domains.

{: tsResolve}

1.  Verify that you use the correct name and tag of the image in your deployment YAML file.
    ```
    ibmcloud cr images
    ```
    {: pre}
2.  Check your [pull traffic and storage quota](/docs/Registry?topic=registry-registry_quota). If the limit is reached, free up used storage or ask your registry administrator to increase the quota.
    ```
    ibmcloud cr quota
    ```
    {: pre}
3.  Get the pod configuration file of a failing pod, and look for the `imagePullSecrets` section.
    ```
    kubectl get pod <pod_name> -o yaml
    ```
    {: pre}

    Example output:
    ```
    ...
    imagePullSecrets:
    - name: bluemix-default-secret
    - name: bluemix-default-secret-regional
    - name: bluemix-default-secret-international
    - name: default-us-icr-io
    - name: default-uk-icr-io
    - name: default-de-icr-io
    - name: default-au-icr-io
    - name: default-jp-icr-io
    - name: default-icr-io
    ...
    ```
    {: screen}
4.  If no image pull secrets are listed, set up the image pull secret in your namespace.
    1.  Verify that the `default` namespace has `icr-io` image pull secrets for each regional registry that you want to use. If no `icr-io` secrets are listed in the namespace, [use the `ibmcloud ks cluster pull-secret apply --cluster <cluster_name_or_ID>` command](/docs/containers?topic=containers-registry#imagePullSecret_migrate_api_key) to create the image pull secrets in the `default` namespace.
        ```
        kubectl get secrets -n default | grep "icr-io"
        ```
        {: pre}
    2.  [Copy the image pull secrets from the `default` Kubernetes namespace to the namespace where you want to deploy your workload](/docs/containers?topic=containers-registry#copy_imagePullSecret).
    3.  [Add the image pull secret to the service account for this Kubernetes namespace](/docs/containers?topic=containers-registry#store_imagePullSecret) so that all pods in the namespace can use the image pull secret credentials.
5.  If image pull secrets are listed in the pod, determine what type of credentials you use to access {{site.data.keyword.registrylong_notm}}.
    *   **Deprecated**: If the secret has `bluemix` in the name, you use a registry token to authenticate with the deprecated `registry.<region>.bluemix.net` domain names. Continue with [Troubleshooting image pull secrets that use tokens](#ts_image_pull_token).
    *   If the secret has `icr` in the name, you use an API key to authenticate with the `icr.io` domain names. Continue with [Troubleshooting image pull secrets that use API keys](#ts_image_pull_apikey).
    *   If you have both types of secrets, then you use both authentication methods. Going forward, use the `icr.io` domain names in your deployment YAMLs for the container image. Continue with [Troubleshooting image pull secrets that use API keys](#ts_image_pull_apikey).

<br>
<br>

**Troubleshooting image pull secrets that use API keys**</br>
{: #ts_image_pull_apikey}

If your pod configuration has an image pull secret that uses an API key, check that the API key credentials are set up correctly.
{: shortdesc}

The following steps assume that the API key stores the credentials of a service ID. If you set up your image pull secret to use an API key of an individual user, you must verify that user's {{site.data.keyword.cloud_notm}} IAM permissions and credentials.
{: note}

1.  Find the service ID that API key uses for the image pull secret by reviewing the **Description**. The service ID that is created with the cluster is named `cluster-<cluster_ID>` and is used in the `default` Kubernetes namespace. If you created another service ID such as to access a different Kubernetes namespace or to modify {{site.data.keyword.cloud_notm}} IAM permissions, you customized the description.
    ```
    ibmcloud iam service-ids
    ```
    {: pre}

    Example output:
    ```
    UUID                Name               Created At              Last Updated            Description                                                                                                                                                                                         Locked
    ServiceId-aa11...   <service_ID_name>  2019-02-01T19:01+0000   2019-02-01T19:01+0000   ID for <cluster_name>                                                                                                                                         false
    ServiceId-bb22...   <service_ID_name>  2019-02-01T19:01+0000   2019-02-01T19:01+0000   Service ID for IBM Cloud Container Registry in Kubernetes cluster <cluster_name> namespace <namespace>                                                                                                                                         false
    ```
    {: screen}
2.  Verify that the service ID is assigned at least an {{site.data.keyword.cloud_notm}} IAM **Reader** [service access role policy for {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=registry-user#create). If the service ID does not have the **Reader** service role, [edit the IAM policies](/docs/iam?topic=iam-serviceidpolicy#access_edit). If the policies are correct, continue with the next step to see if the credentials are valid.
    ```
    ibmcloud iam service-policies <service_ID_name>
    ```
    {: pre}

    Example output:
    ```
    Policy ID:   a111a111-b22b-333c-d4dd-e555555555e5
    Roles:       Reader
    Resources:
                  Service Name       container-registry
                  Service Instance
                  Region
                  Resource Type      namespace
                  Resource           <registry_namespace>
    ```
    {: screen}
3.  Check if the image pull secret credentials are valid.
    1.  Get the image pull secret configuration. If the pod is not in the `default` namespace, include the `-n` flag.
        ```
        kubectl get secret <image_pull_secret_name> -o yaml [-n <namespace>]
        ```
        {: pre}
    2.  In the output, copy the base64 encoded value of the `.dockerconfigjson` field.
        ```
        apiVersion: v1
        kind: Secret
        data:
          .dockerconfigjson: eyJyZWdp...==
        ...
        ```
        {: screen}
    3.  Decode the base64 string. For example, on OS X you can run the following command.
        ```
        echo -n "<base64_string>" | base64 --decode
        ```
        {: pre}

        Example output:
        ```
        {"auths":{"<region>.icr.io":{"username":"iamapikey","password":"<password_string>","email":"<name@abc.com>","auth":"<auth_string>"}}}
        ```
        {: screen}
    4.  Compare the image pull secret regional registry domain name with the domain name that you specified in the container image. By default, new clusters have image pull secrets for each regional registry domain name for containers that run in the `default` Kubernetes namespace. However, if you modified the default settings or are using a different Kubernetes namespace, you might not have an image pull secret for the regional registry. [Copy an image pull secret](/docs/containers?topic=containers-registry#copy_imagePullSecret) for the regional registry domain name.
    5.  Log in to the registry from your local machine by using the `username` and `password` from your image pull secret. If you cannot log in, you might need to fix the service ID.
        ```
        docker login -u iamapikey -p <password_string> <region>.icr.io
        ```
        {: pre}
        1.  Re-create the cluster service ID, {{site.data.keyword.cloud_notm}} IAM policies, API key, and image pull secrets for containers that run in the `default` Kubernetes namespace.
            ```
            ibmcloud ks cluster pull-secret apply --cluster <cluster_name_or_ID>
            ```
            {: pre}
        2.  Re-create your deployment in the `default` Kubernetes namespace. If you still see an authorization error message, repeat Steps 1-5 with the new image pull secrets. If you still cannot log in, [open an {{site.data.keyword.cloud_notm}} Support case](#getting_help).
    6.  If the login succeeds, pull an image locally. If the command fails with an `access denied` error, the registry account is in a different {{site.data.keyword.cloud_notm}} account than the one your cluster is in. [Create an image pull secret to access images in the other account](/docs/containers?topic=containers-registry#other_registry_accounts). If you can pull an image to your local machine, then your API key has the right permissions, but the API setup in your cluster is not correct. You cannot resolve this issue. [Open an {{site.data.keyword.cloud_notm}} Support case](#getting_help).
        ```
        docker pull <region>icr.io/<namespace>/<image>:<tag>
        ```
        {: pre}

<br>
<br>

**Deprecated: Troubleshooting image pull secrets that use tokens**</br>
{: #ts_image_pull_token}

If your pod configuration has an image pull secret that uses a token, check that the token credentials are valid.
{: shortdesc}

This method of using a token to authorize cluster access to {{site.data.keyword.registrylong_notm}} for the `registry.bluemix.net` domain names is deprecated. Before tokens become unsupported, update your deployments to [use the API key method](/docs/containers?topic=containers-registry#cluster_registry_auth) to authorize cluster access to the new `icr.io` registry domain names.
{: deprecated}

1.  Get the image pull secret configuration. If the pod is not in the `default` namespace, include the `-n` flag.
    ```
    kubectl get secret <image_pull_secret_name> -o yaml [-n <namespace>]
    ```
    {: pre}
2.  In the output, copy the base64 encoded value of the `.dockercfg` field.
    ```
    apiVersion: v1
    kind: Secret
    data:
      .dockercfg: eyJyZWdp...==
    ...
    ```
    {: screen}
3.  Decode the base64 string. For example, on OS X you can run the following command.
    ```
    echo -n "<base64_string>" | base64 --decode
    ```
    {: pre}

    Example output:
    ```
    {"auths":{"registry.<region>.bluemix.net":{"username":"token","password":"<password_string>","email":"<name@abc.com>","auth":"<auth_string>"}}}
    ```
    {: screen}
4.  Compare the registry domain name with the domain name that you specified in the container image. For example, if the image pull secret authorizes access to the `registry.ng.bluemix.net` domain but you specified an image that is stored in `registry.eu-de.bluemix.net`, you must [create a token to use in an image pull secret](/docs/containers?topic=containers-images#token_other_regions_accounts) for `registry.eu-de.bluemix.net`.
5.  Log in to the registry from your local machine by using the `username` and `password` from the image pull secret. If you cannot log in, the token has an issue that you cannot resolve. [Open an {{site.data.keyword.cloud_notm}} Support case](#getting_help).
    ```
    docker login -u token -p <password_string> registry.<region>.bluemix.net
    ```
    {: pre}
6.  If the login succeeds, pull an image locally. If the command fails with an `access denied` error, the registry account is in a different {{site.data.keyword.cloud_notm}} account than the one your cluster is in. [Create an image pull secret to access images in the other account](/docs/containers?topic=containers-images#token_other_regions_accounts). If the command succeeds, [open an {{site.data.keyword.cloud_notm}} Support case](#getting_help).
    ```
    docker pull registry.<region>.bluemix.net/<namespace>/<image>:<tag>
    ```
    {: pre}

<br />


## Containers do not start
{: #containers_do_not_start}

{: tsSymptoms}
The pods deploy successfully to clusters, but the containers do not start.

{: tsCauses}
Containers might not start when the registry quota is reached.

{: tsResolve}
[Free up storage in {{site.data.keyword.registrylong_notm}}.](/docs/Registry?topic=registry-registry_quota#registry_quota_freeup)

<br />



## Pods fail to deploy because of a pod security policy
{: #cs_psp}

{: tsSymptoms}
After creating a pod or running `kubectl get events` to check on a pod deployment, you see an error message similar to the following.

```
unable to validate against any pod security policy
```
{: screen}

{: tsCauses}
[The `PodSecurityPolicy` admission controller](/docs/containers?topic=containers-psp) checks the authorization of the user or service account, such as a deployment or Helm tiller, that tried to create the pod. If no pod security policy supports the user or service account, then the `PodSecurityPolicy` admission controller prevents the pods from being created.

If you deleted one of the pod security policy resources for [{{site.data.keyword.IBM_notm}} cluster management](/docs/containers?topic=containers-psp#ibm_psp), you might experience similar issues.

{: tsResolve}
Make sure that the user or service account is authorized by a pod security policy. You might need to [modify an existing policy](/docs/containers?topic=containers-psp#customize_psp).

If you deleted an {{site.data.keyword.IBM_notm}} cluster management resource, refresh the Kubernetes master to restore it.

1.  [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
2.  Refresh the Kubernetes master to restore it.

    ```
    ibmcloud ks cluster master refresh
    ```
    {: pre}

<br />



## Pods remain in pending state
{: #cs_pods_pending}

{: tsSymptoms}
When you run `kubectl get pods`, you can see pods that remain in a **Pending** state.

{: tsCauses}
If you just created the Kubernetes cluster, the worker nodes might still be configuring.

If this cluster is an existing one:
*  You might not have enough capacity in your cluster to deploy the pod.
*  The pod might have exceeded a resource request or limit.

{: tsResolve}
This task requires the {{site.data.keyword.cloud_notm}} IAM [**Administrator** platform role](/docs/containers?topic=containers-users#platform) for the cluster and the [**Manager** service role](/docs/containers?topic=containers-users#platform) for all namespaces.

If you just created the Kubernetes cluster, run the following command and wait for the worker nodes to initialize.

```
kubectl get nodes
```
{: pre}

If this cluster is an existing one, check your cluster capacity.


1.  Set the proxy with the default port number.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Open the Kubernetes dashboard.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Check if you have enough capacity in your cluster to deploy your pod.

4.  If you don't have enough capacity in your cluster, resize your worker pool to add more nodes.

    1.  Review the current sizes and flavors of your worker pools to decide which one to resize.

        ```
        ibmcloud ks worker-pool ls
        ```
        {: pre}

    2.  Resize your worker pools to add more nodes to each zone that the pool spans.

        ```
        ibmcloud ks worker-pool resize --worker-pool <worker_pool> --cluster <cluster_name_or_ID> --size-per-zone <workers_per_zone>
        ```
        {: pre}

5.  Optional: Check your pod resource requests.

    1.  Confirm that the `resources.requests` values are not larger than the worker node's capacity. For example, if the pod request `cpu: 4000m`, or 4 cores, but the worker node size is only 2 cores, the pod cannot be deployed.

        ```
        kubectl get pod <pod_name> -o yaml
        ```
        {: pre}

    2.  If the request exceeds the available capacity, [add a new worker pool](/docs/containers?topic=containers-add_workers#add_pool) with worker nodes that can fulfill the request.

6.  If your pods still stay in a **pending** state after the worker node is fully deployed, review the [Kubernetes documentation](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending){: external} to further troubleshoot the pending state of your pod.

<br />




## Pods repeatedly fail to restart or are unexpectedly removed
{: #pods_fail}

{: tsSymptoms}
Your pod was healthy but unexpectedly gets removed or gets stuck in a restart loop.

{: tsCauses}
Your containers might exceed their resource limits, or your pods might be replaced by higher priority pods.

{: tsResolve}
To see if a container is being killed because of a resource limit:
<ol><li>Get the name of your pod. If you used a label, you can include it to filter your results.<pre class="pre"><code>kubectl get pods --selector='app=wasliberty'</code></pre></li>
<li>Describe the pod and look for the **Restart Count**.<pre class="pre"><code>kubectl describe pod</code></pre></li>
<li>If the pod restarted many times in a short period of time, fetch its status. <pre class="pre"><code>kubectl get pod -o go-template={{range.status.containerStatuses}}{{"Container Name: "}}{{.name}}{{"\r\nLastState: "}}{{.lastState}}{{end}}</code></pre></li>
<li>Review the reason. For example, `OOM Killed` means "out of memory," indicating that the container is crashing because of a resource limit.</li>
<li>Add capacity to your cluster so that the resources can be fulfilled.</li></ol>

<br>

To see if your pod is being replaced by higher priority pods:
1.  Get the name of your pod.

    ```
    kubectl get pods
    ```
    {: pre}

2.  Describe your pod YAML.

    ```
    kubectl get pod <pod_name> -o yaml
    ```
    {: pre}

3.  Check the `priorityClassName` field.

    1.  If there is no `priorityClassName` field value, then your pod has the `globalDefault` priority class. If your cluster admin did not set a `globalDefault` priority class, then the default is zero (0), or the lowest priority. Any pod with a higher priority class can preempt, or remove, your pod.

    2.  If there is a `priorityClassName` field value, get the priority class.

        ```
        kubectl get priorityclass <priority_class_name> -o yaml
        ```
        {: pre}

    3.  Note the `value` field to check your pod's priority.

4.  List existing priority classes in the cluster.

    ```
    kubectl get priorityclasses
    ```
    {: pre}

5.  For each priority class, get the YAML file and note the `value` field.

    ```
    kubectl get priorityclass <priority_class_name> -o yaml
    ```
    {: pre}

6.  Compare your pod's priority class value with the other priority class values to see if it is higher or lower in priority.

7.  Repeat steps 1 to 3 for other pods in the cluster, to check what priority class they are using. If those other pods' priority class is higher than your pod, your pod is not provisioned unless there is enough resources for your pod and every pod with higher priority.

8.  Contact your cluster admin to add more capacity to your cluster and confirm that the right priority classes are assigned.

<br />


## Binding a service to a cluster results in same name error
{: #cs_duplicate_services}

{: tsSymptoms}
When you run `ibmcloud ks cluster service bind --cluster <cluster_name> --namespace <namespace> --service <service_instance_name>`, you see the following message.

```
Multiple services with the same name were found.
Run 'ibmcloud service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
Multiple service instances might have the same name in different regions.

{: tsResolve}
Use the service GUID instead of the service instance name in the `ibmcloud ks cluster service bind` command.

1. [Log in to the {{site.data.keyword.cloud_notm}} region that includes the service instance to bind.](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)

2. Get the GUID for the service instance.
  ```
  ibmcloud service show <service_instance_name> --guid
  ```
  {: pre}

  Output:
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. Bind the service to the cluster again.
  ```
  ibmcloud ks cluster service bind --cluster <cluster_name> --namespace <namespace> --service <service_instance_GUID>
  ```
  {: pre}

<br />


## Binding a service to a cluster results in service not found error
{: #cs_not_found_services}

{: tsSymptoms}
When you run `ibmcloud ks cluster service bind --cluster <cluster_name> --namespace <namespace> --service <service_instance_name>`, you see the following message.

```
Binding service to a namespace...
FAILED

The specified IBM Cloud service could not be found. If you just created the service, wait a little and then try to bind it again. To view available IBM Cloud service instances, run 'ibmcloud service list'. (E0023)
```
{: screen}

{: tsCauses}
To bind services to a cluster, you must have the Cloud Foundry developer user role for the space where the service instance is provisioned. In addition, you must have the {{site.data.keyword.cloud_notm}} IAM Editor platform access to {{site.data.keyword.containerlong_notm}}. To access the service instance, you must be logged in to the space where the service instance is provisioned.

{: tsResolve}

**As the user:**

1. Log in to {{site.data.keyword.cloud_notm}}.
   ```
   ibmcloud login
   ```
   {: pre}

2. Target the org and the space where the service instance is provisioned.
   ```
   ibmcloud target -o <org> -s <space>
   ```
   {: pre}

3. Verify that you are in the right space by listing your service instances.
   ```
   ibmcloud service list
   ```
   {: pre}

4. Try binding the service again. If you get the same error, then contact the account administrator and verify that you have sufficient permissions to bind services (see the following account admin steps).

**As the account admin:**

1. Verify that the user who experiences this problem has [Editor permissions for {{site.data.keyword.containerlong_notm}}](/docs/iam?topic=iam-iammanidaccser#edit_existing).

2. Verify that the user who experiences this problem has the [Cloud Foundry developer role for the space](/docs/iam?topic=iam-mngcf#update_cf_access) where the service is provisioned.

3. If the correct permissions exists, try assigning a different permission and then re-assigning the required permission.

4. Wait a few minutes, then let the user try to bind the service again.

5. If this does not resolve the problem, then the {{site.data.keyword.cloud_notm}} IAM permissions are out of sync and you cannot resolve the issue yourself. [Contact IBM support](/docs/get-support?topic=get-support-getting-customer-support) by opening a support case. Make sure to provide the cluster ID, the user ID, and the service instance ID.
   1. Retrieve the cluster ID.
      ```
      ibmcloud ks cluster ls
      ```
      {: pre}

   2. Retrieve the service instance ID.
      ```
      ibmcloud service show <service_name> --guid
      ```
      {: pre}


<br />


## Binding a service to a cluster results in service does not support service keys error
{: #cs_service_keys}

{: tsSymptoms}
When you run `ibmcloud ks cluster service bind --cluster <cluster_name> --namespace <namespace> --service <service_instance_name>`, you see the following message.

```
This service doesn't support creation of keys
```
{: screen}

{: tsCauses}
Some services in {{site.data.keyword.cloud_notm}}, such as {{site.data.keyword.keymanagementservicelong}} do not support the creation of service credentials, also referred to as service keys. Without the support of service keys, the service is not bindable to a cluster. To find a list of services that support the creation of service keys, see [Enabling external apps to use {{site.data.keyword.cloud_notm}} services](/docs/resources?topic=resources-externalapp#externalapp).

{: tsResolve}
To integrate services that do not support service keys, check if the service provides an API that you can use to access the service directly from your app. For example, if you want to use {{site.data.keyword.keymanagementservicelong}}, see the [API reference](https://cloud.ibm.com/apidocs/key-protect){: external}.

<br />


## Cannot install a Helm chart with updated configuration values
{: #cs_helm_install}

{: tsSymptoms}
When you try to install an updated Helm chart by running `helm install <release_name> iks-charts/<chart_name> -f config.yaml`, you get the `Error: failed to download "iks-charts/<chart_name>"` error message.

{: tsCauses}
The URL for the {{site.data.keyword.cloud_notm}} repository in your Helm instance might be incorrect.

{: tsResolve}
To troubleshoot your Helm chart:

1. List the repositories currently available in your Helm instance.

    ```
    helm repo list
    ```
    {: pre}

2. In the output, verify that the URL for the {{site.data.keyword.cloud_notm}} repository, `ibm`, is `https://icr.io/helm/iks-charts`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://icr.io/helm/iks-charts
    ```
    {: screen}

    * If the URL is incorrect:

        1. Remove the {{site.data.keyword.cloud_notm}} repository.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Add the {{site.data.keyword.cloud_notm}} repository again.

            ```
            helm repo add iks-charts  https://icr.io/helm/iks-charts
            ```
            {: pre}

    * If the URL is correct, get the latest updates from the repository.

        ```
        helm repo update
        ```
        {: pre}

3. Install the Helm chart with your updates.

    ```
    helm install <release_name> iks-charts/<chart_name> -f config.yaml
    ```
    {: pre}

<br />


## Cannot install Tiller for Helm version 2 or deploy containers from public images in a cluster
{: #cs_tiller_install}

{: tsSymptoms}

When you try to install Tiller for Helm version 2 or want to deploy images from public registries, such as DockerHub, the installation fails with an error similar to the following:

```
Failed to pull image "gcr.io/kubernetes-helm/tiller:v2.12.0": rpc error: code = Unknown desc = failed to resolve image "gcr.io/kubernetes-helm/tiller:v2.12.0": no available registry endpoint:
```
{: screen}

{: tsCauses}
You might have set up a custom firewall, specified custom Calico policies, or created a private-only cluster by using the private service endpoint that block public network connectivity to the container registry where the image is stored.

{: tsResolve}
- If you have a custom firewall or set custom Calico policies, allow outbound and inbound network traffic between your worker nodes and the container registry where the image is stored. If the image is stored in {{site.data.keyword.registrylong_notm}}, review the required ports in [Allowing the cluster to access infrastructure resources and other services](/docs/containers?topic=containers-firewall#firewall_outbound).
- If you created a private cluster by enabling the private service endpoint only, you can [enable the public service endpoint](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_disable) for your cluster. If want to install Helm charts in a private cluster without opening up a public connection, you can install Helm [with Tiller](/docs/containers?topic=containers-helm#private_local_tiller) or [without Tiller](/docs/containers?topic=containers-helm#private_install_without_tiller).

    [Helm v3 was released on 13 November 2019](https://helm.sh/blog/helm-3-released/){: external}. Tiller is removed in Helm v3. Install Helm v2 only if you have specific requirements to use Helm v2 in your cluster. Otherwise, [install the latest release of Helm v3](/docs/containers?topic=containers-helm#install_v3).
    {: note}

<br />


## Feedback, questions, and support
{: #getting_help}

Still having issues with your cluster? Review different ways to get help and support for your {{site.data.keyword.containerlong_notm}} clusters. For any questions or feedback, post in Slack.
{: shortdesc}

**General ways to resolve issues**<br>
1. Keep your cluster environment up to date.
   * Check monthly for available security and operating system patches to [update your worker nodes](/docs/containers?topic=containers-update#worker_node).
   * [Update your cluster](/docs/containers?topic=containers-update#master) to the latest default version for [{{site.data.keyword.containershort}}](/docs/containers?topic=containers-cs_versions).
2. Make sure that your command line tools are up to date.
   * In the terminal, you are notified when updates to the `ibmcloud` CLI and plug-ins are available. Be sure to keep your CLI up-to-date so that you can use all available commands and flags.
   * Make sure that [your `kubectl` CLI](/docs/containers?topic=containers-cs_cli_install#kubectl) client matches the same Kubernetes version as your cluster server. [Kubernetes does not support](https://kubernetes.io/docs/setup/release/version-skew-policy/){: external} `kubectl` client versions that are 2 or more versions apart from the server version (n +/- 2).
<br>

**Reviewing issues and status**<br>
1. To see whether {{site.data.keyword.cloud_notm}} is available, [check the {{site.data.keyword.cloud_notm}} status page](https://cloud.ibm.com/status?selected=status){: external}.
2. Filter for the **Kubernetes Service** component.
<br>

**Feedback and questions**<br>
1. Post in the {{site.data.keyword.containershort}} Slack.
   * If you are an external user, post in the [#general](https://ibm-cloud-success.slack.com/archives/C4G6362ER){: external} channel.
   * If you are an IBMer, use the [#armada-users](https://ibm-argonauts.slack.com/archives/C4S4NUCB1) channel.<p class="tip">If you do not use an IBMid for your {{site.data.keyword.cloud_notm}} account, [request an invitation](https://cloud.ibm.com/kubernetes/slack){: external} to this Slack.</p>
2. Review forums such as {{site.data.keyword.containershort}} help or Stack Overflow to see whether other users ran into the same issue. When you use the forums to ask a question, tag your question so that it is seen by the {{site.data.keyword.cloud_notm}} development teams.
   * If you have technical questions about developing or deploying clusters or apps with {{site.data.keyword.containerlong_notm}}, post your question on [Stack Overflow](https://stackoverflow.com/questions/tagged/ibm-cloud+containers){: external} and tag your question with `ibm-cloud` and `containers`.
   * See [Getting help](/docs/get-support?topic=get-support-getting-customer-support#using-avatar) for more details about using the forums.
<br>

**Getting help**<br>
1. Before you open a support case, gather relevant information about your cluster environment.
   1. Get your cluster details.
      ```
      ibmcloud ks cluster get -c <cluster_name_or_ID>
      ```
      {: pre}
   2. If your issue involves worker nodes, get the worker node details.
      1. List all worker nodes in the cluster, and note the **ID** of any worker nodes with an unhealthy **State** or **Status**.
         ```
         ibmcloud ks worker ls -c <cluster_name_or_ID>
         ```
         {: pre}
      2. Get the details of the unhealthy worker node.
         ```
         ibmcloud ks worker get -w <worker_ID> -c <cluster_name_or_ID>
         ```
         {: pre}
   3. For issues with resources within your cluster such as pods or services, log in to the cluster and use the Kubernetes API to get more information about them. 
   
   You can also use the [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) to gather and export pertinent information to share with IBM Support.
   {: tip}

2.  Contact IBM Support by opening a case. To learn about opening an IBM support case, or about support levels and case severities, see [Contacting support](/docs/get-support?topic=get-support-getting-customer-support).
3.  In your support case, for **Category**, select **Containers**.
4.  For the **Offering**, select your {{site.data.keyword.containershort}} cluster. Include the relevant information that you previously gathered.


