, you can schedule mathematically intensive workloads onto the worker node. For example, you might run a 3D app that uses the Compute Unified Device Architecture (CUDA) platform to share the processing load across the GPU and CPU to increase performance.
{:shortdesc}

In the following steps, you learn how to deploy workloads that require the GPU. You can also [deploy apps](#app_ui) that don't need to process their workloads across both the GPU and CPU. After, you might find it useful to play around with mathematically intensive workloads such as the [TensorFlow ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.tensorflow.org/) machine learning framework with [this Kubernetes demo ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/pachyderm/pachyderm/tree/master/examples/ml/tensorflow).

Before you begin:
* [Create a bare metal GPU machine type](/docs/containers?topic=containers-clusters#clusters_ui). Note that this process can take more than 1 business day to complete.
* Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

To execute a workload on a GPU machine:
1.  Create a YAML file. In this example, a `Job` YAML manages batch-like workloads by making a short-lived pod that runs until the command that it is scheduled to complete successfully terminates.

    For GPU workloads, you must always provide the `resources: limits: nvidia.com/gpu` field in the YAML specification.
    {: note}

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-smi
      labels:
        name: nvidia-smi
    spec:
      template:
        metadata:
          labels:
            name: nvidia-smi
        spec:
          containers:
          - name: nvidia-smi
            image: nvidia/cuda:9.1-base-ubuntu16.04
            command: [ "/usr/test/nvidia-smi" ]
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
            volumeMounts:
            - mountPath: /usr/test
              name: nvidia0
          volumes:
            - name: nvidia0
              hostPath:
                path: /usr/bin
          restartPolicy: Never
    ```
    {: codeblock}

    <table summary="A table that describes in Column 1 the YAML file fields and in Column 2 how to fill out those fields.">
    <caption>YAML components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td>Metadata and label names</td>
    <td>Give a name and a label for the job, and use the same name in both the file's metadata and the `spec template` metadata. For example, `nvidia-smi`.</td>
    </tr>
    <tr>
    <td><code>containers.image</code></td>
    <td>Provide the image that the container is a running instance of. In this example, the value is set to use the DockerHub CUDA image:<code>nvidia/cuda:9.1-base-ubuntu16.04</code></td>
    </tr>
    <tr>
    <td><code>containers.command</code></td>
    <td>Specify a command to run in the container. In this example, the <code>[ "/usr/test/nvidia-smi" ]</code>command refers to a binary file that is on the GPU machine, so you must also set up a volume mount.</td>
    </tr>
    <tr>
    <td><code>containers.imagePullPolicy</code></td>
    <td>To pull a new image only if the image is not currently on the worker node, specify <code>IfNotPresent</code>.</td>
    </tr>
    <tr>
    <td><code>resources.limits</code></td>
    <td>For GPU machines, you must specify the resource limit. The Kubernetes [Device Plug-in![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) sets the default resource request to match the limit.
    <ul><li>You must specify the key as <code>nvidia.com/gpu</code>.</li>
    <li>Enter the whole number of GPUs that you request, such as <code>2</code>. <strong>Note</strong>: Container pods do not share GPUs and GPUs cannot be overcommitted. For example, if you have only 1 `mg1c.16x128` machine, then you have only 2 GPUs in that machine and can specify a maximum of `2`.</li></ul></td>
    </tr>
    <tr>
    <td><code>volumeMounts</code></td>
    <td>Name the volume that is mounted onto the container, such as <code>nvidia0</code>. Specify the <code>mountPath</code> on the container for the volume. In this example, the path <code>/usr/test</code> matches the path used in the job container command.</td>
    </tr>
    <tr>
    <td><code>volumes</code></td>
    <td>Name the job volume, such as <code>nvidia0</code>. In the GPU worker node's <code>hostPath</code>, specify the volume's <code>path</code> on the host, in this example, <code>/usr/bin</code>. The container <code>mountPath</code> is mapped to the host volume <code>path</code>, which gives this job access to the NVIDIA binaries on the GPU worker node for the container command to run.</td>
    </tr>
    </tbody></table>

2.  Apply the YAML file. For example:

    ```
    kubectl apply -f nvidia-smi.yaml
    ```
    {: pre}

3.  Check the job pod by filtering your pods by the `nvidia-sim` label. Verify that the **STATUS** is **Completed**.

    ```
    kubectl get pod -a -l 'name in (nvidia-sim)'
    ```
    {: pre}

    Example output:
    ```
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-smi-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4.  Describe the pod to see how the GPU device plug-in scheduled the pod.
    * In the `Limits` and `Requests` fields, see that the resource limit that you specified matches the request that the device plug-in automatically set.
    * In the events, verify that the pod is assigned to your GPU worker node.

    ```
    kubectl describe pod nvidia-smi-ppkd4
    ```
    {: pre}

    Example output:
    ```
    Name:           nvidia-smi-ppkd4
    Namespace:      default
    ...
    Limits:
     nvidia.com/gpu:  2
    Requests:
     nvidia.com/gpu:  2
    ...
    Events:
    Type    Reason                 Age   From                     Message
    ----    ------                 ----  ----                     -------
    Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-smi-ppkd4 to 10.xxx.xx.xxx
    ...
    ```
    {: screen}

5.  To verify that the job used the GPU to compute its workload, you can check the logs. The `[ "/usr/test/nvidia-smi" ]` command from the job queried the GPU device state on the GPU worker node.

    ```
    kubectl logs nvidia-sim-ppkd4
    ```
    {: pre}

    Example output:
    ```
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 390.12                 Driver Version: 390.12                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla K80           Off  | 00000000:83:00.0 Off |                  Off |
    | N/A   37C    P0    57W / 149W |      0MiB / 12206MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
    |   1  Tesla K80           Off  | 00000000:84:00.0 Off |                  Off |
    | N/A   32C    P0    63W / 149W |      0MiB / 12206MiB |      1%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```
    {: screen}

    In this example, you see that both GPUs were used to execute the job because both the GPUs were scheduled in the worker node. If the limit is set to 1, only 1 GPU is shown.


## Launching the Kubernetes dashboard
{: #cli_dashboard}

Open a Kubernetes dashboard on your local system to view information about a cluster and its worker nodes. [In the {{site.data.keyword.Bluemix_notm}} console](#db_gui), you can access the dashboard with a convenient one-click button. [With the CLI](#db_cli), you can access the dashboard or use the steps in an automation process such as for a CI/CD pipeline.
{:shortdesc}

Do you have so many resources and users in your cluster that the Kubernetes dashboard is a little slow? For clusters that run Kubernetes version 1.12 or later, your cluster admin can scale the `kubernetes-dashboard` deployment by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.
{: tip}

Before you begin:
* Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources.
* To [launch the Kubernetes dashboard from the console](#db_gui), you must be assigned a [platform role](/docs/containers?topic=containers-users#platform). If you are assigned only a service role but no platform role, [launch the Kubernetes dashboard from the CLI](#db_cli).
* [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

You can use the default port or set your own port to launch the Kubernetes dashboard for a cluster.

**Launching the Kubernetes dashboard from the {{site.data.keyword.Bluemix_notm}} console**
{: #db_gui}

1.  Log in to the [{{site.data.keyword.Bluemix_notm}} console](https://cloud.ibm.com/).
2.  From the menu bar, select the account that you want to use.
3.  From the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon"), click **Kubernetes**.
4.  On the **Clusters** page, click the cluster that you want to access.
5.  From the cluster detail page, click the **Kubernetes Dashboard** button.

</br>
</br>

**Launching the Kubernetes dashboard from the CLI**
{: #db_cli}

1.  Get your credentials for Kubernetes.

    ```
    kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
    ```
    {: pre}

2.  Copy the **id-token** value that is shown in the output.

3.  Set the proxy with the default port number.

    ```
    kubectl proxy
    ```
    {: pre}

    Example output:

    ```
    Starting to serve on 127.0.0.1:8001
    ```
    {: screen}

4.  Sign in to the dashboard.

  1.  In your browser, navigate to the following URL:

      ```
      http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
      ```
      {: codeblock}

  2.  In the sign-on page, select the **Token** authentication method.

  3.  Then, paste the **id-token** value that you previously copied into the **Token** field and click **SIGN IN**.

When you are done with the Kubernetes dashboard, use `CTRL+C` to exit the `proxy` command. After you exit, the Kubernetes dashboard is no longer available. Run the `proxy` command to restart the Kubernetes dashboard.

[Next, you can run a configuration file from the dashboard.](#app_ui)

<br />


## Scaling apps
{: #app_scaling}

With Kubernetes, you can enable [horizontal pod autoscaling ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) to automatically increase or decrease the number of instances of your apps based on CPU.
{:shortdesc}

Looking for information about scaling Cloud Foundry applications? Check out [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling?topic=Auto-Scaling%20-get-started). Want to scale your worker nodes instead of your pods? Check out the [cluster autoscaler](/docs/containers?topic=containers-ca#ca).
{: tip}

Before you begin:
- [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
- Heapster monitoring must be deployed in the cluster that you want to autoscale.
- Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

Steps:

1.  Deploy your app to a cluster from the CLI. When you deploy your app, you must request CPU.

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table summary="A table that describes in Column 1 the Kubectl command options and in Column 2 how to fill out those options.">
    <caption>Command components for `kubectl run`</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command&apos;s components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>The application that you want to deploy.</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>The required CPU for the container, which is specified in milli-cores. As an example, <code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>When true, creates an external service.</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>The port where your app is available externally.</td>
    </tr></tbody></table>

    For more complex deployments, you might need to create a [configuration file](#app_cli).
    {: tip}

2.  Create an autoscaler and define your policy. For more information about working with the `kubectl autoscale` command, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale).

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table summary="A table that describes in Column 1 the Kubectl command options and in Column 2 how to fill out those options.">
    <caption>Command components for `kubectl autoscale`</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command&apos;s components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>The average CPU utilization that is maintained by the Horizontal Pod Autoscaler, which is specified as a percentage.</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>The minimum number of deployed pods that are used to maintain the specified CPU utilization percentage.</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>The maximum number of deployed pods that are used to maintain the specified CPU utilization percentage.</td>
    </tr>
    </tbody></table>


<br />


## Managing rolling deployments to update your apps
{: #app_rolling}

You can manage the rollout of your app changes in an automated and controlled fashion for workloads with a pod template such as deployments. If your rollout isn't going according to plan, you can roll back your deployment to the previous revision.
{:shortdesc}

Want to prevent downtime during your rolling update? Be sure to specify a [readiness probe in your deployment](#probe) so that the rollout proceeds to the next app pod after the most recently updated pod is ready.
{: tip}

Before you begin:
*   [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
*   Create a [deployment](#app_cli).
*   Make sure that you have a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

To manage rolling updates to your apps:
1.  To make sure that your deployments are marked as ready only when the container is running and ready to service requests, add [liveness and readiness probes to your deployment](#probe).

2.  Update your deployment to include a rolling update strategy that specifies the maximum surge and unavailable pods or percentage of pods during the update.

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:  
      name: nginx-test
    spec:
      replicas: 10
      selector:
        matchLabels:
          service: http-server
      minReadySeconds: 5
      progressDeadlineSeconds: 600
      strategy: 
        type: RollingUpdate  
        rollingUpdate:    
          maxUnavailable: 50%
          maxSurge: 2
    ...
    ```
    {: codeblock}

    <table summary="A table that describes in Column 1 the YAML file fields and in Column 2 how to fill out those fields.">
    <caption>YAML components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>spec.minReadySeconds</code></td>
    <td>By default, deployments wait until the pod is marked as `ready` to continue with the rollout. If you notice that the deployment continues to create pods even though your app in the most recent pod is not yet ready, use this field to slow down the deployment rollout. For example, if you specify `5`, the deployment waits for 5 seconds after the pod is `ready` before it creates the next pod.</td>
    </tr>
    <tr>
    <td><code>spec.progressDeadlineSeconds</code></td>
    <td>Set a timeout in seconds before a deployment is considered failed. For example, without a timeout, if your new app version has a bug and hangs immediately, the rollout cannot continue because the pod never reaches a `ready` state. If you set this timeout to `600` seconds, then if any phase of the rollout fails to progress for 10 minutes, the deployment is marked as failed and the rollout stops.</td>
    </tr>
    <tr>
    <td><code>spec.strategy.type</code></td>
    <td>Specify the `RollingUpdate` strategy type.</td>
    </tr>
    <tr>
    <td><code>spec.strategy.rollingUpdate.maxUnavailable</code></td>
    <td>Set the maximum number of pods that can be unavailable during an update, as a number (`2`) or percentage (`50%`). Generally, use a percentage so that if you change the number of replicas later you don't have to remember to update the number here, unless you want to limit the rollout to allow only one pod to be down at a time. If you never want to fall below 100% capacity, set this value to `0%` and specify the `spec.strategy.type.rollingUpdate.maxSurge` parameter.</td>
    </tr>
    <tr>
    <td><code>spec.strategy.rollingUpdate.maxSurge</code></td>
    <td>Set how many extra resources the deployment can use during the rollout, as a number (`2`) or percentage (`50%`). For example, if your deployment specifies `10` replicas and you set the `maxSurge` to `2`, then during the rollout, 2 new replicas are created. You now have 12 replicas (10 existing, 2 new). After the 2 new replicas are ready, the deployment scales down the old replicas to 8 to meet the specified 10 replicas. This process continues until the rollout is complete and all 10 replicas run the new version.<p class="tip">If you want to perform a blue-green instantaneous switch style update, set the `maxSurge` to `100%`. The deployment creates all the new required replicas, then scales down the old version replicas to 0.</p></td>
    </tr>
    </tbody></table>

3.  [Roll out ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) a change. For example, you might want to change the image that you used in your initial deployment.

    1.  Get the deployment name.

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  Get the pod name.

        ```
        kubectl get pods
        ```
        {: pre}

    3.  Get the name of the container that is running in the pod.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  Set the new image for the deployment to use.

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    When you run the commands, the change is immediately applied and logged in the roll-out history.

4.  Check the status of your deployment.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

    If you notice something in the status that you want time to follow up on, you can pause and resume your rollout with the following commands.

    ```
    kubectl rollout pause deployment <deployment_name>
    ```
    {: pre}

    ```
    kubectl rollout resume deployment <deployment_name>
    ```
    {: pre}

5.  Roll back a change.
    1.  View the roll-out history for the deployment and identify the revision number of your last deployment.

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **Tip:** To see the details for a specific revision, include the revision number.

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  Roll back to the previous version, or specify a revision. To roll back to the previous version, use the following command.

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />


</staging>
