---

copyright:
  years: 2014, 2025
lastupdated: "2025-05-28"


keywords: kubernetes

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Deploying Kubernetes-native apps in clusters
{: #deploy_app}

You can use Kubernetes techniques in {{site.data.keyword.containerlong}} to deploy apps in containers and ensure that those apps are up and running. For example, you can perform rolling updates and rollbacks without downtime for your users.
{: shortdesc}

For more information about creating a configuration file for your application, see [Configuration Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/){: external}.

## Launching the Kubernetes dashboard
{: #cli_dashboard}

Open a Kubernetes dashboard on your local system to view information about a cluster and its worker nodes. [In the {{site.data.keyword.cloud_notm}} console](#db_gui), you can access the dashboard with a convenient one-click button. [With the CLI](#db_cli), you can access the dashboard or use the steps in an automation process such as for a CI/CD pipeline.
{: shortdesc}

Do you have so many resources and users in your cluster that the Kubernetes dashboard is a little slow? Your cluster admin can scale the `kubernetes-dashboard` deployment by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.
{: tip}

To check the logs for individual app pods, you can run `kubectl logs <pod name>`. Do not use the Kubernetes dashboard to stream logs for your pods, which might cause a disruption in your access to the Kubernetes dashboard.
{: important}

Before you begin
- Make sure that you are assigned a [service access role](/docs/containers?topic=containers-iam-platform-access-roles) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources.
- To [launch the Kubernetes dashboard from the console](#db_gui), you must be assigned a [platform access role](/docs/containers?topic=containers-iam-platform-access-roles). If you are assigned only a service access role but no platform access role, [launch the Kubernetes dashboard from the CLI](#db_cli).
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

You can use the default port or set your own port to launch the Kubernetes dashboard for a cluster.

### Launching the Kubernetes dashboard from the {{site.data.keyword.cloud_notm}} console
{: #db_gui}

1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/).
2. From the menu bar, select the account that you want to use.
3. From the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon"), click **Containers** > **Clusters**.
4. On the **Clusters** page, click the cluster that you want to access.
5. From the cluster detail page, click the **Kubernetes Dashboard** button.


### Launching the Kubernetes dashboard from the CLI
{: #db_cli}

Before you begin, [install the CLI](/docs/containers?topic=containers-cli-install).

1. Get your credentials for Kubernetes.

    ```sh
    kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
    ```
    {: pre}

2. Copy the **id-token** value that is shown in the output.

3. Set the proxy with the default port number.

    ```sh
    kubectl proxy
    ```
    {: pre}

    Example output

    ```sh
    Starting to serve on 127.0.0.1:8001
    ```
    {: screen}

4. Sign in to the dashboard.

    1. In your browser, navigate to the following URL:

        ```sh
        http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
        ```
        {: codeblock}

    2. In the sign-on page, select the **Token** authentication method.

    3. Then, paste the **id-token** value that you previously copied into the **Token** field and click **SIGN IN**.

When you are done with the Kubernetes dashboard, use `CTRL+C` to exit the `proxy` command. After you exit, the Kubernetes dashboard is no longer available. Run the `proxy` command to restart the Kubernetes dashboard.

Next, you can [run a configuration file from the dashboard.](#app_ui).


## Deploying apps with the Kubernetes dashboard
{: #app_ui}

When you deploy an app to your cluster by using the Kubernetes dashboard, a deployment resource automatically creates, updates, and manages the pods in your cluster. For more information about using the dashboard, see [the Kubernetes docs](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/){: external}.
{: shortdesc}

Do you have so many resources and users in your cluster that the Kubernetes dashboard is a little slow? Your cluster admin can scale the `kubernetes-dashboard` deployment by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.
{: tip}

Before you begin

- [Install the required CLIs](/docs/containers?topic=containers-cli-install).
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
- Make sure that you are assigned a [service access role](/docs/containers?topic=containers-iam-platform-access-roles) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources.
- To [launch the Kubernetes dashboard from the console](#db_gui), you must be assigned a [platform access role](/docs/containers?topic=containers-iam-platform-access-roles). If you are assigned only a service access role but no platform access role, [launch the Kubernetes dashboard from the CLI](#db_cli).

To deploy your app,

1. Open the Kubernetes [dashboard](#cli_dashboard) and click **+ Create**.
2. Enter your app details in 1 of 2 ways.
    - Select **Specify app details** and enter the details.
    - Select **Upload a YAML or JSON file** to upload your app [configuration file](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/){: external}.

    Need help with your configuration file? Check out this [example YAML file](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml){: external}. In this example, a container is deployed from the **ibmliberty** image in the US-South region. Learn more about [securing your personal information](/docs/containers?topic=containers-security#pi) when you work with Kubernetes resources.
    {: tip}

3. Verify that you successfully deployed your app in one of the following ways.
    - In the Kubernetes dashboard, click **Deployments**. A list of successful deployments is displayed.
    - If your app is [publicly available](/docs/containers?topic=containers-cs_network_planning#public_access), navigate to the cluster overview page in your {{site.data.keyword.containerlong}} dashboard. Copy the subdomain, which is located in the cluster summary section and paste it into a browser to view your app.

## Deploying apps with the CLI
{: #app_cli}

After a cluster is created, you can deploy an app into that cluster by using the Kubernetes CLI.
{: shortdesc}

Before you begin

- Install the required [CLIs](/docs/containers?topic=containers-cli-install).
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
- Make sure that you are assigned a [service access role](/docs/containers?topic=containers-iam-platform-access-roles) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

To deploy your app,

1. Create a configuration file based on [Kubernetes best practices](https://kubernetes.io/docs/concepts/configuration/overview/){: external}. Generally, a configuration file contains configuration details for each of the resources you are creating in Kubernetes. Your script might include one or more of the following sections:

    - [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/){: external}: Defines the creation of pods and replica sets. A pod includes an individual containerized app and replica sets control multiple instances of pods.

    - [Service](https://kubernetes.io/docs/concepts/services-networking/service/){: external}: Provides front-end access to pods by using a worker node or load balancer public IP address, or a public Ingress route.

    - [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/){: external}: Specifies a type of load balancer that provides routes to access your app publicly.

    Learn more about [securing your personal information](/docs/containers?topic=containers-security#pi) when you work with Kubernetes resources.

2. Run the configuration file in a cluster's context.

    ```sh
    kubectl apply -f config.yaml
    ```
    {: pre}

3. If you made your app publicly available by using a NodePort service, a load balancer service, or Ingress, verify that you can access the app.

## Deploying apps to specific worker nodes by using labels
{: #node_affinity}

When you deploy an app, the app pods indiscriminately deploy to various worker nodes in your cluster. Sometimes, you might want to restrict the worker nodes that the app pods to deploy to. For example, you might want app pods to deploy to only worker nodes in a certain worker pool because those worker nodes are on bare metal machines. To designate the worker nodes that app pods must deploy to, add an affinity rule to your app deployment.
{: shortdesc}

Before you begin
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
- **Optional**: [Set a label for the worker pool](/docs/containers?topic=containers-worker-tag-label) that you want to run the app on.

To deploy apps to specific worker nodes,

1. Get the ID of the worker pool that you want to deploy app pods to.
    ```sh
    ibmcloud ks worker-pool ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. List the worker nodes that are in the worker pool, and note one of the **Private IP** addresses.
    ```sh
    ibmcloud ks worker ls --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
    ```
    {: pre}

3. Describe the worker node. In the **Labels** output, note the worker pool ID label, `ibm-cloud.kubernetes.io/worker-pool-id`.

    The steps in this topic use a worker pool ID to deploy app pods only to worker nodes within that worker pool. To deploy app pods to specific worker nodes by using a different label, note this label instead. For example, to deploy app pods only to worker nodes on a specific private VLAN, use the `privateVLAN=` label.
    {: tip}

    ```sh
    kubectl describe node <worker_node_private_IP>
    ```
    {: pre}

    Example output

    ```sh
    NAME:               10.xxx.xx.xxx
    Roles:              <none>
    Labels:             arch=amd64
                        beta.kubernetes.io/arch=amd64
                        beta.kubernetes.io/instance-type=b3c.4x16.encrypted
                        beta.kubernetes.io/os=linux
                        failure-domain.beta.kubernetes.io/region=us-south
                        failure-domain.beta.kubernetes.io/zone=dal10
                        ibm-cloud.kubernetes.io/encrypted-docker-data=true
                        ibm-cloud.kubernetes.io/ha-worker=true
                        ibm-cloud.kubernetes.io/iaas-provider=softlayer
                        ibm-cloud.kubernetes.io/machine-type=b3c.4x16.encrypted
                        ibm-cloud.kubernetes.io/sgx-enabled=false
                        ibm-cloud.kubernetes.io/worker-pool-id=00a11aa1a11aa11a1111a1111aaa11aa-11a11a
                        ibm-cloud.kubernetes.io/worker-version=1.32_1534
                        kubernetes.io/hostname=10.xxx.xx.xxx
                        privateVLAN=1234567
                        publicVLAN=7654321
    Annotations:        node.alpha.kubernetes.io/ttl=0
    ...
    ```
    {: screen}

4. [Add an affinity rule](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/){: external} for the worker pool ID label to the app deployment.

    Example YAML

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: ibm-cloud.kubernetes.io/worker-pool-id
                    operator: In
                    values:
                    - <worker_pool_ID>
    ...
    ```
    {: codeblock}

    In the **affinity** section of the example YAML, `ibm-cloud.kubernetes.io/worker-pool-id` is the `key` and `<worker_pool_ID>` is the `value`.

5. Apply the updated deployment configuration file.
    ```sh
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

6. Verify that the app pods deployed to the correct worker nodes.

    1. List the pods in your cluster.
        ```sh
        kubectl get pods -o wide
        ```
        {: pre}

        Example output
        ```sh
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. In the output, identify a pod for your app. Note the **NODE** private IP address of the worker node that the pod is on.

        In the previous example output, the app pod `cf-py-d7b7d94db-vp8pq` is on a worker node with the IP address `10.xxx.xx.xxx`.

    3. List the worker nodes in the worker pool that you designated in your app deployment.

        ```sh
        ibmcloud ks worker ls --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
        ```
        {: pre}

        Example output

        ```sh
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b3c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b3c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b3c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        If you created an app affinity rule based on another factor, get that value instead. For example, to verify that the app pod deployed to a worker node on a specific VLAN, view the VLAN that the worker node is on by running `ibmcloud ks worker get --cluster <cluster_name_or_ID> --worker <worker_ID>`.
        {: tip}

    4. In the output, verify that the worker node with the private IP address that you identified in the previous step is deployed in this worker pool.

## Deploying an app on an NVIDIA GPU machine
{: #gpu_app}

If you have a GPU machine type, you can speed up the processing time required for compute intensive workloads such as AI, machine learning, inferencing, and more.
{: shortdesc}




In {{site.data.keyword.containerlong_notm}}, the required GPU drivers are automatically installed for you.



In the following steps, you learn how to deploy workloads that require the GPU. However, you can also deploy apps that don't need to process their workloads across both the GPU and CPU. 

You can also try mathematically intensive workloads such as the [TensorFlow](https://www.tensorflow.org/){: external} machine learning framework with [this Kubernetes demo](https://github.com/pachyderm/pachyderm/tree/master/examples/ml/tensorflow){: external}.
{: tip}

### Prerequisites
{: #gpu-prereqs}

Before you begin
- Create a [cluster](/docs/containers?topic=containers-clusters) or worker pool that uses a GPU flavor. Keep in mind that setting up a bare metal machine can take more than one business day to complete. For a list of available flavors, see the following links.
    - [Classic flavors](/docs/containers?topic=containers-classic-flavors)
    - [VPC flavors](/docs/containers?topic=containers-vpc-flavors)

- Make sure that you are assigned a [service access role](/docs/containers?topic=containers-iam-platform-access-roles) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the cluster.



### Deploying a workload
{: #gpu-workload}

1. Create a YAML file. In this example, a `Job` YAML manages batch-like workloads by making a short-lived pod that runs until the command completes and successfully terminates.

    For GPU workloads, you must specify the `resources: limits: nvidia.com/gpu` field in the job YAML.
    {: note}

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-devicequery
      labels:
        name: nvidia-devicequery
    spec:
      template:
        metadata:
          labels:
            name: nvidia-devicequery
        spec:
          containers:
          - name: nvidia-devicequery
            image: nvcr.io/nvidia/k8s/cuda-sample:devicequery-cuda11.7.1-ubuntu20.04
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
          restartPolicy: Never
    ```
    {: codeblock}
    
    | Component | Description | 
    |--- | --- |
    | Metadata and label names | Enter a name and a label for the job, and use the same name in both the file's metadata and the `spec template` metadata. For example, `nvidia-devicequery`. |
    | `containers.image` | Provide the image that the container is a running instance of. In this example, the value is set to use the DockerHub CUDA device query image:`nvcr.io/nvidia/k8s/cuda-sample:devicequery-cuda11.7.1-ubuntu20.04`. |
    | `containers.imagePullPolicy` | To pull a new image only if the image is not currently on the worker node, specify `IfNotPresent`. |
    | `resources.limits` | For GPU machines, you must specify the resource limit. The Kubernetes [Device Plug-in](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/){: external} sets the default resource request to match the limit. \n * You must specify the key as `nvidia.com/gpu`. \n * Enter the whole number of GPUs that you request, such as `2`. Note that container pods don't share GPUs and GPUs can't be overcommitted. For example, if you have only 1 `mg1c.16x128` machine, then you have only 2 GPUs in that machine and can specify a maximum of `2`. |
    {: caption="Understanding your YAML components" caption-side="bottom"}

2. Apply the YAML file. For example:

    ```sh
    kubectl apply -f nvidia-devicequery.yaml
    ```
    {: pre}

3. Check the job pod by filtering your pods by the `nvidia-devicequery` label. Verify that the **STATUS** is **Completed**.

    ```sh
    kubectl get pod -A -l 'name in (nvidia-devicequery)'
    ```
    {: pre}

    Example output

    ```sh
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-devicequery-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4. Describe the pod to see how the GPU device plug-in scheduled the pod.
    - In the `Limits` and `Requests` fields, see that the resource limit that you specified matches the request that the device plug-in automatically set.
    - In the events, verify that the pod is assigned to your GPU worker node.

        ```sh
        kubectl describe pod nvidia-devicequery-ppkd4
        ```
        {: pre}

        Example output
        ```sh
        NAME:           nvidia-devicequery-ppkd4
        Namespace:      default
        ...
        Limits:
            nvidia.com/gpu:  1
        Requests:
            nvidia.com/gpu:  1
        ...
        Events:
        Type    Reason                 Age   From                     Message
        ----    ------                 ----  ----                     -------
        Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-devicequery-ppkd4 to 10.xxx.xx.xxx
        ...
        ```
        {: screen}

5. To verify that the job used the GPU to compute its workload, you can check the logs.

    ```sh
    kubectl logs nvidia-devicequery-ppkd4
    ```
    {: pre}

    Example output

    ```sh
    /cuda-samples/sample Starting...
    
    CUDA Device Query (Runtime API) version (CUDART static linking)
    
    Detected 1 CUDA Capable device(s)
    
    Device 0: "Tesla P100-PCIE-16GB"
    CUDA Driver Version / Runtime Version          11.4 / 11.7
    CUDA Capability Major/Minor version number:    6.0
    Total amount of global memory:                 16281 MBytes (17071734784 bytes)
    (056) Multiprocessors, (064) CUDA Cores/MP:    3584 CUDA Cores
    GPU Max Clock rate:                            1329 MHz (1.33 GHz)
    Memory Clock rate:                             715 Mhz
    Memory Bus Width:                              4096-bit
    L2 Cache Size:                                 4194304 bytes
    Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
    Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
    Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
    Total amount of constant memory:               65536 bytes
    Total amount of shared memory per block:       49152 bytes
    Total shared memory per multiprocessor:        65536 bytes
    Total number of registers available per block: 65536
    Warp size:                                     32
    Maximum number of threads per multiprocessor:  2048
    Maximum number of threads per block:           1024
    Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
    Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
    Maximum memory pitch:                          2147483647 bytes
    Texture alignment:                             512 bytes
    Concurrent copy and kernel execution:          Yes with 2 copy engine(s)
    Run time limit on kernels:                     No
    Integrated GPU sharing Host Memory:            No
    Support host page-locked memory mapping:       Yes
    Alignment requirement for Surfaces:            Yes
    Device has ECC support:                        Enabled
    Device supports Unified Addressing (UVA):      Yes
    Device supports Managed Memory:                Yes
    Device supports Compute Preemption:            Yes
    Supports Cooperative Kernel Launch:            Yes
    Supports MultiDevice Co-op Kernel Launch:      Yes
    Device PCI Domain ID / Bus ID / location ID:   0 / 175 / 0
    Compute Mode:
    < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >
    
    deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 11.4, CUDA Runtime Version = 11.7, NumDevs = 1
    Result = PASS
    ```
    {: screen}

    In this example, you see a GPU was used to execute the job because the GPU was scheduled in the worker node. If the limit is set to 2, only 2 GPUs are shown.

Now that you deployed a test GPU workload, you might want to set up your cluster to run a tool that relies on GPU processing, such as [IBM Maximo Visual Inspection](https://www.ibm.com/products/maximo/asset-performance-management){: external}.

    
## Deploying an app on an Intel GPU machine
{: #intel-gpu-app}

Complete the following example to deploy Intel Gaudi’s PyTorch container image that a retreives a Gaudi device by using the `resource.limits` field. Before you begin, make sure your cluster meets the following requirements.

- Version 4.18 and later
- VPC clusters only
- RHCOS worker nodes only
- Intel Gaudi Base [operator v1.20.1 and later](https://catalog.redhat.com/software/container-stacks/detail/6683b2cce45daa25e36bddcb){: external}

For more information and examples, see the [Habana docs](https://docs.habana.ai/en/latest/){: external} and the [quickstart example](https://docs.habana.ai/en/latest/Quick_Start_Guides/Kubernetes_Quick_Start.html){: external}.
{: tip}



1. Copy the following example job configuration and save it as a file called `config.yaml`
    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: habanalabs-gaudi-demo
    spec:
      template:
          spec:
            hostIPC: true
            restartPolicy: OnFailure
            containers:
              - name: habana-ai-base-container
                image: vault.habana.ai/gaudi-docker/1.21.0/ubuntu22.04/habanalabs/pytorch-installer-2.6.0:latest
                workingDir: /root
                command: ["hl-smi"]
                securityContext:
                  capabilities:
                      add: ["SYS_NICE"]
                resources:
                  limits:
                      habana.ai/gaudi: 8
                      memory: 409Gi
                      hugepages-2Mi: 9500Mi
    ```
    {: codeblock}

1. Apply the job in your cluster.
    ```sh
    oc apply -f config.yaml
    ```
    {: pre}

1. Wait for the pods to start, then verify the job completed.
    ```sh
    oc get po -n default
    ```
    {: pre}

    Example
    ```sh
    NAME                          READY   STATUS      RESTARTS   AGE
    habanalabs-gaudi-demo-kmdcp   0/1     Completed   0          2m32s
    ```
    {: screen}

1. Describe the job pod for more details.
    ```sh
    oc describe po habanalabs-gaudi-demo-kmdcp
    ```
    {: pre}

    ```sh
    Name:             habanalabs-gaudi-demo-kmdcp
    Namespace:        default
    Priority:         0
    Service Account:  default
    Node:             test-csrq76620trmo9r8j7u0-btsstagevpc-gaudi3s-00013059/10.180.0.83
    Start Time:       Tue, 27 May 2025 14:41:50 -0400
    Labels:           batch.kubernetes.io/controller-uid=c3b33c8a-5fef-4312-9d59-c8b13c03313a
                      batch.kubernetes.io/job-name=habanalabs-gaudi-demo
                      controller-uid=c3b33c8a-5fef-4312-9d59-c8b13c03313a
                      job-name=habanalabs-gaudi-demo
    Annotations:      cni.projectcalico.org/containerID: 7c883dfa9c681ee2c4128b1a5412d4dc181842d0de2a4b7b8019eefc06df37ca
                      cni.projectcalico.org/podIP: 
                      cni.projectcalico.org/podIPs: 
    Status:           Succeeded
    IP:               172.17.151.97
    IPs:
      IP:           172.17.151.97
    Controlled By:  Job/habanalabs-gaudi-demo
    Containers:
      habana-ai-base-container:
        Container ID:  cri-o://d75288e9b467f3f820e05e770bbc3d9a2b11cbf8155a54a129fc083d5d507571
        Image:         vault.habana.ai/gaudi-docker/1.21.0/ubuntu22.04/habanalabs/pytorch-installer-2.6.0:latest
        Image ID:      vault.habana.ai/gaudi-docker/1.21.0/ubuntu22.04/habanalabs/pytorch-installer-2.6.0@sha256:cd599626a8f4d1c3a7b354ccf4ef73e19196f09030d02261d4900bf3467a964c
        Port:          <none>
        Host Port:     <none>
        Command:
          hl-smi
        State:          Terminated
          Reason:       Completed
          Exit Code:    0
          Started:      Tue, 27 May 2025 14:41:53 -0400
          Finished:     Tue, 27 May 2025 14:41:54 -0400
        Ready:          False
        Restart Count:  0
        Limits:
          habana.ai/gaudi:  8
          hugepages-2Mi:    9500Mi
          memory:           409Gi
        Requests:
          habana.ai/gaudi:  8
          hugepages-2Mi:    9500Mi
          memory:           409Gi
        Environment:        <none>
        Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8vn42 (ro)
    Conditions:
      Type                        Status
      PodReadyToStartContainers   False 
      Initialized                 True 
      Ready                       False 
      ContainersReady             False 
      PodScheduled                True 
    Volumes:
      kube-api-access-8vn42:
        Type:                    Projected (a volume that contains injected data from multiple sources)
        TokenExpirationSeconds:  3607
        ConfigMapName:           kube-root-ca.crt
        ConfigMapOptional:       <nil>
        DownwardAPI:             true
        ConfigMapName:           openshift-service-ca.crt
        ConfigMapOptional:       <nil>
    QoS Class:                   Burstable
    Node-Selectors:              <none>
    Tolerations:                 node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                                  node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                                  node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
    Events:
      Type    Reason          Age   From               Message
      ----    ------          ----  ----               -------
      Normal  Scheduled       53s   default-scheduler  Successfully assigned default/habanalabs-gaudi-demo-kmdcp to test-csrq76620trmo9r8j7u0-btsstagevpc-gaudi3s-00013059
      Normal  AddedInterface  52s   multus             Add eth0 [172.17.151.97/32] from k8s-pod-network
      Normal  Pulling         52s   kubelet            Pulling image "vault.habana.ai/gaudi-docker/1.21.0/ubuntu22.04/habanalabs/pytorch-installer-2.6.0:latest"
      Normal  Pulled          50s   kubelet            Successfully pulled image "vault.habana.ai/gaudi-docker/1.21.0/ubuntu22.04/habanalabs/pytorch-installer-2.6.0:latest" in 2.146s (2.146s including waiting). Image size: 5188441181 bytes.
      Normal  Created         50s   kubelet            Created container: habana-ai-base-container
      Normal  Started         50s   kubelet            Started container habana-ai-base-container
    ```
    {: screen}

1. Get the pod logs to see the Gaudi device details.
    ```sh
    oc logs habanalabs-gaudi-demo-kmdcp
    ```
    {: pre}

    Example output    
    ```sh
    +-----------------------------------------------------------------------------+
    | HL-SMI Version:                              hl-1.21.0-fw-59.2.1.0          |
    | Driver Version:                                     1.20.1-366eb9c          |
    | Nic Driver Version:                                 1.20.1-213b09b          |
    |-------------------------------+----------------------+----------------------+
    | AIP  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncor-Events|
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | AIP-Util  Compute M. |
    |===============================+======================+======================|
    |   0  HL-325L             N/A  | 0000:e9:00.0     N/A |                   0  |
    | N/A   36C   P0  228W /  900W  |   672MiB / 131072MiB |     0%            0% |
    |-------------------------------+----------------------+----------------------+
    |   1  HL-325L             N/A  | 0000:c1:00.0     N/A |                   0  |
    | N/A   37C   P0  226W /  900W  |   672MiB / 131072MiB |     0%            0% |
    |-------------------------------+----------------------+----------------------+
    |   2  HL-325L             N/A  | 0000:b7:00.0     N/A |                   0  |
    | N/A   36C   P0  225W /  900W  |   672MiB / 131072MiB |     0%            0% |
    |-------------------------------+----------------------+----------------------+
    |   3  HL-325L             N/A  | 0000:ad:00.0     N/A |                   0  |
    | N/A   40C   P0  228W /  900W  |   672MiB / 131072MiB |     0%            0% |
    |-------------------------------+----------------------+----------------------+
    |   4  HL-325L             N/A  | 0000:a3:00.0     N/A |                   0  |
    | N/A   36C   P0  228W /  900W  |   672MiB / 131072MiB |     0%            0% |
    |-------------------------------+----------------------+----------------------+
    |   5  HL-325L             N/A  | 0000:df:00.0     N/A |                   0  |
    | N/A   39C   P0  229W /  900W  |   672MiB / 131072MiB |     0%            0% |
    |-------------------------------+----------------------+----------------------+
    |   6  HL-325L             N/A  | 0000:d5:00.0     N/A |                   0  |
    | N/A   36C   P0  231W /  900W  |   672MiB / 131072MiB |     0%            0% |
    |-------------------------------+----------------------+----------------------+
    |   7  HL-325L             N/A  | 0000:cb:00.0     N/A |                   0  |
    | N/A   38C   P0  227W /  900W  |   672MiB / 131072MiB |     0%            0% |
    |-------------------------------+----------------------+----------------------+
    | Compute Processes:                                               AIP Memory |
    |  AIP       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |   0        N/A   N/A    N/A                                      N/A        |
    |   1        N/A   N/A    N/A                                      N/A        |
    |   2        N/A   N/A    N/A                                      N/A        |
    |   3        N/A   N/A    N/A                                      N/A        |
    |   4        N/A   N/A    N/A                                      N/A        |
    |   5        N/A   N/A    N/A                                      N/A        |
    |   6        N/A   N/A    N/A                                      N/A        |
    |   7        N/A   N/A    N/A                                      N/A        |
    +=============================================================================+
    ```
    {: screen}


    
