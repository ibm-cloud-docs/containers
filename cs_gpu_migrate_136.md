---

copyright:
  years: 2026
lastupdated: "2026-05-20"

keywords: kubernetes, gpu, nvidia, driver, migration, 1.36

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Migrating to self-managed NVIDIA GPU drivers for Kubernetes 1.36
{: #gpu-migrate-136}

Starting with Kubernetes version 1.36, {{site.data.keyword.containerlong_notm}} no longer automatically installs NVIDIA GPU drivers on GPU worker nodes. You must install and manage GPU drivers yourself to run GPU workloads.
{: shortdesc}

## What's changing?
{: #gpu-migrate-what-changed}

Version 1.36 and later
:   GPU drivers are not preinstalled on new or replaced GPU worker nodes. You must install and maintain the following components:
    - NVIDIA kernel driver
    - Container runtime components (such as `nvidia-container-toolkit`)
    - Kubernetes device plugin

Versions 1.35 and earlier
:   GPU drivers are automatically installed and managed by IBM on all GPU worker nodes.


## What's the impact?
{: #gpu-migrate-impact}

Pods that request GPU resources remain in `Pending` state until you install the required GPU drivers on the worker node. After the drivers are installed, pending pods automatically transition to `Running` state.

## Understanding the migration process
{: #gpu-migrate-process}

The migration to self-managed GPU drivers follows a specific sequence to ensure your GPU workloads continue running during the upgrade:

1. **Pre-installation phase**: You install the NVIDIA GPU Operator on your cluster while it's still running version 1.35 or earlier. During installation, you label the existing GPU nodes to prevent the operator from deploying driver resources, which would conflict with the pre-installed drivers.

2. **Control plane upgrade**: You'll upgrade the cluster control plane to version 1.36.

3. **Worker node upgrade**: Replace each worker node to upgrade them version 1.36. When you do this, the labels that prevented driver deployment are automatically removed. This allows the NVIDIA GPU Operator to deploy its driver stack on the new nodes.

4. **Automatic workload recovery**: Once the operator installs drivers on a replaced node, any pending GPU workloads automatically transition to `Running` state.

## Preparing for migration before version 1.36 is available
{: #gpu-migrate-prepare}

You can complete the pre-installation steps before version 1.36 is released to prepare your cluster for a smoother migration:

1. Label your existing GPU worker nodes to prevent the operator from deploying resources that would conflict with pre-installed drivers.

    ```sh
    kubectl label node/<node_name> nvidia.com/gpu.deploy.operands=false
    kubectl label node/<node_name> nvidia.com/gpu.deploy.driver=false
    ```
    {: pre}

2. Install the NVIDIA GPU Operator following the [NVIDIA GPU Operator installation guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html){: external}.

3. Verify that the operator is installed but not deploying driver resources on your labeled nodes.

    ```sh
    kubectl get pods -n gpu-operator -o wide
    ```
    {: pre}

By completing these preparation steps early, you reduce the work required during the actual upgrade to version 1.36. When version 1.36 becomes available, you only need to upgrade the control plane and replace the worker nodes.

## Before you begin
{: #gpu-migrate-prereqs}

- Review the [NVIDIA GPU Operator documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html){: external}.
- Ensure you have cluster administrator access.
- Plan your upgrade strategy based on your cluster configuration (single GPU node vs. multiple GPU nodes).

## Migration examples
{: #gpu-migrate-examples}

The following examples demonstrate how to migrate your cluster based on the number of GPU nodes.

## Example 1: Single GPU node in the cluster
{: #gpu-migrate-single-node}

This example demonstrates migrating a cluster with a single GPU node. Because the sole GPU node will be unavailable during the upgrade, you add a temporary second GPU worker to maintain capacity.

### Step 1: Get the initial cluster state
{: #gpu-migrate-single-initial-state}

1. Check the cluster control plane version.

    ```sh
    ibmcloud ks cluster get -c <cluster_name>
    ```
    {: pre}

    Example output showing version 1.35:

    ```sh
    Master
    Status:     Ready
    State:      deployed
    Health:     normal
    Version:    1.35.4_1528
    ```
    {: screen}

2. Check the worker node version.

    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

    Example output showing a single GPU node:

    ```sh
    ID                                                       Primary IP    Flavor         State    Status   Zone         Version       Operating System
    test-d8397vk20kb65iocenn0-btspstggput-default-000001e4   10.240.0.64   gx3.16x80.l4   normal   Ready    us-south-1   1.35.4_1528   UBUNTU_24_64
    ```
    {: screen}

### Step 2: Install the NVIDIA GPU Operator
{: #gpu-migrate-single-install-operator}

If you followed the steps in [Preparing for migration before version 1.36 is available](#gpu-migrate-prepare), you might have already completed this step.

1. Label the existing GPU worker node to prevent the operator from deploying resources that would conflict with pre-installed drivers.

    ```sh
    kubectl label node/10.240.0.64 nvidia.com/gpu.deploy.operands=false
    kubectl label node/10.240.0.64 nvidia.com/gpu.deploy.driver=false
    ```
    {: pre}

2. Add the NVIDIA Helm repository and install the GPU operator.

    ```sh
    helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
    helm repo update
    helm install --wait --generate-name -n gpu-operator --create-namespace nvidia/gpu-operator
    ```
    {: pre}

3. Verify that the GPU operator pods are running. Note that driver installer, device plugin, container toolkit, and DCGM exporter should NOT be running on the labeled node.

    ```sh
    kubectl get pods -n gpu-operator -o wide
    ```
    {: pre}

    Example output:
    ```sh
    NAME                                                              READY   STATUS    RESTARTS   AGE     IP              NODE          NOMINATED NODE   READINESS GATES
    gpu-operator-1778819096-node-feature-discovery-gc-84d98bd6nqw2z   1/1     Running   0          2m21s   172.17.64.94    10.240.0.64   <none>           <none>
    gpu-operator-1778819096-node-feature-discovery-master-6b6cpnm9w   1/1     Running   0          2m21s   172.17.64.93    10.240.0.64   <none>           <none>
    gpu-operator-1778819096-node-feature-discovery-worker-hm7ft       1/1     Running   0          2m21s   172.17.64.91    10.240.0.64   <none>           <none>
    gpu-operator-76c686b9df-kn4dw                                     1/1     Running   0          2m21s   172.17.64.92    10.240.0.64   <none>           <none>
    ```
    {: screen}

### Step 3: Upgrade the cluster control plane
{: #gpu-migrate-single-upgrade-master}

1. Upgrade the cluster control plane to version 1.36.

    ```sh
    ibmcloud ks cluster master update --cluster <cluster_name> --version 1.36.0
    ```
    {: pre}

2. Verify the control plane upgrade.

    ```sh
    ibmcloud ks cluster get -c <cluster_name>
    ```
    {: pre}

    Example output:

    ```sh
    Master
    Status:     Ready
    State:      deployed
    Health:     normal
    Version:    1.36.0_1506
    ```
    {: screen}

### Step 4: Add a temporary GPU worker node
{: #gpu-migrate-single-add-temp}

1. Add a temporary second GPU worker to the cluster with Kubernetes version 1.36.

    ```sh
    ibmcloud ks worker-pool create vpc-gen2 --name temp-gpu-pool --cluster <cluster_name> --flavor gx3.16x80.l4 --size-per-zone 1 --zone us-south-1
    ```
    {: pre}

2. Verify the temporary node is ready.

    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

    Example output showing both the original and temporary nodes:
    ```sh
    ID                                                       Primary IP    Flavor         State    Status   Zone         Version       Operating System
    test-d8397vk20kb65iocenn0-btspstggput-default-000001e4   10.240.0.64   gx3.16x80.l4   normal   Ready    us-south-1   1.35.4_1528   UBUNTU_24_64
    test-d8397vk20kb65iocenn0-tempgpupool-default-00000371   10.240.0.72   gx3.16x80.l4   normal   Ready    us-south-1   1.36.0_1507   UBUNTU_24_64
    ```
    {: screen}

3. Verify GPU operator pods are running on the new temporary node.

    ```sh
    kubectl get pods -n gpu-operator -o wide
    ```
    {: pre}

    Example output showing driver and device plugin running on the temporary node:
    ```sh
    NAME                                                              READY   STATUS      RESTARTS   AGE     IP               NODE          NOMINATED NODE   READINESS GATES
    gpu-feature-discovery-mw5km                                       1/1     Running     0          4m36s   172.17.116.201   10.240.0.72   <none>           <none>
    nvidia-container-toolkit-daemonset-ns6p8                          1/1     Running     0          4m36s   172.17.116.199   10.240.0.72   <none>           <none>
    nvidia-cuda-validator-vgj45                                       0/1     Completed   0          96s     172.17.116.203   10.240.0.72   <none>           <none>
    nvidia-dcgm-exporter-52cwh                                        1/1     Running     0          4m36s   172.17.116.204   10.240.0.72   <none>           <none>
    nvidia-device-plugin-daemonset-2ql7x                              1/1     Running     0          4m36s   172.17.116.202   10.240.0.72   <none>           <none>
    nvidia-driver-daemonset-zql6m                                     1/1     Running     0          5m29s   172.17.116.197   10.240.0.72   <none>           <none>
    nvidia-operator-validator-44xtz                                   1/1     Running     0          4m36s   172.17.116.200   10.240.0.72   <none>           <none>
    ```
    {: screen}

4. Verify GPU readiness on the temporary node.

    ```sh
    kubectl get nodes -o json | jq '.items[] | {name: .metadata.name, allocatable: .status.allocatable}'
    ```
    {: pre}

### Step 5: Migrate workloads and upgrade the original node
{: #gpu-migrate-single-upgrade-original}

1. Migrate your GPU workloads to the temporary 1.36 worker node. You can use node selectors, taints, or manual pod deletion to move workloads.

2. Replace the original GPU node.

    ```sh
    ibmcloud ks worker replace -w test-d8397vk20kb65iocenn0-btspstggput-default-000001e4 -c <cluster_name> --update
    ```
    {: pre}

3. Verify the node upgrade.

    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

    Example output showing both nodes now on version 1.36:
    ```sh
    ID                                                       Primary IP    Flavor         State    Status   Zone         Version       Operating System
    test-d8397vk20kb65iocenn0-btspstggput-default-00000485   10.240.0.68   gx3.16x80.l4   normal   Ready    us-south-1   1.36.0_1507   UBUNTU_24_64
    test-d8397vk20kb65iocenn0-tempgpupool-default-00000371   10.240.0.72   gx3.16x80.l4   normal   Ready    us-south-1   1.36.0_1507   UBUNTU_24_64
    ```
    {: screen}

4. Verify GPU operator pods are running on the upgraded original node.

    ```sh
    kubectl get pods -n gpu-operator -o wide
    ```
    {: pre}

5. Verify all GPU workloads are running.

    ```sh
    kubectl get pods -o wide
    ```
    {: pre}

    Example output:
    ```sh
    NAME             READY   STATUS    RESTARTS   AGE    IP               NODE          NOMINATED NODE   READINESS GATES
    gpu-burn-46pml   1/1     Running   0          6m8s   172.17.116.205   10.240.0.72   <none>           <none>
    gpu-burn-z6xnh   1/1     Running   0          44m    172.17.121.28    10.240.0.68   <none>           <none>
    ```
    {: screen}

### Step 6: Remove the temporary node (optional)
{: #gpu-migrate-single-cleanup}

After the original node is healthy and workloads are stable, you can optionally remove the temporary GPU node.

1. Delete the temporary worker pool.

    ```sh
    ibmcloud ks worker-pool rm --cluster <cluster_name> --worker-pool temp-gpu-pool
    ```
    {: pre}

2. Verify only the original node remains.

    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

## Example 2: Multiple GPU nodes in the cluster
{: #gpu-migrate-multiple-nodes}

This example demonstrates migrating a cluster with two GPU nodes from Kubernetes version 1.35 to 1.36. With multiple nodes, you can upgrade nodes one at a time while maintaining GPU capacity.

### Step 1: Get the initial cluster state
{: #gpu-migrate-multiple-initial-state}

1. Check the cluster control plane version.

    ```sh
    ibmcloud ks cluster get -c <cluster_name>
    ```
    {: pre}

    Example output showing version 1.35:

    ```sh
    Master
    Status:     Ready
    State:      deployed
    Health:     normal
    Version:    1.35.4_1528
    ```
    {: screen}

2. Check the worker node versions.

    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

    Example output showing two GPU nodes:

    ```sh
    ID                                                       Primary IP    Flavor         State    Status   Zone         Version       Operating System
    test-d8397vk20kb65iocenn0-btspstggput-default-000001e4   10.240.0.64   gx3.16x80.l4   normal   Ready    us-south-1   1.35.4_1528   UBUNTU_24_64
    test-d8397vk20kb65iocenn0-btspstggput-default-0000024b   10.240.0.66   gx3.16x80.l4   normal   Ready    us-south-1   1.35.4_1528   UBUNTU_24_64
    ```
    {: screen}

### Step 2: Install the NVIDIA GPU Operator
{: #gpu-migrate-multiple-install-operator}

If you followed the steps in [Preparing for migration before version 1.36 is available](#gpu-migrate-prepare), you might have already completed this step.

1. Label the existing GPU worker nodes to prevent the operator from deploying resources that would conflict with pre-installed drivers.

    ```sh
    kubectl label node/10.240.0.64 nvidia.com/gpu.deploy.operands=false
    kubectl label node/10.240.0.64 nvidia.com/gpu.deploy.driver=false
    kubectl label node/10.240.0.66 nvidia.com/gpu.deploy.operands=false
    kubectl label node/10.240.0.66 nvidia.com/gpu.deploy.driver=false
    ```
    {: pre}

2. Add the NVIDIA Helm repository and install the GPU operator.

    ```sh
    helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
    helm repo update
    helm install --wait --generate-name -n gpu-operator --create-namespace nvidia/gpu-operator
    ```
    {: pre}

3. Verify that the GPU operator pods are running. Note that driver installer, device plugin, container toolkit, and DCGM exporter should NOT be running on the labeled nodes.

    ```sh
    kubectl get pods -n gpu-operator -o wide
    ```
    {: pre}

    Example output:
    ```sh
    NAME                                                              READY   STATUS    RESTARTS   AGE     IP              NODE          NOMINATED NODE   READINESS GATES
    gpu-operator-1778819096-node-feature-discovery-gc-84d98bd6nqw2z   1/1     Running   0          2m21s   172.17.64.94    10.240.0.64   <none>           <none>
    gpu-operator-1778819096-node-feature-discovery-master-6b6cpnm9w   1/1     Running   0          2m21s   172.17.64.93    10.240.0.64   <none>           <none>
    gpu-operator-1778819096-node-feature-discovery-worker-hm7ft       1/1     Running   0          2m21s   172.17.64.91    10.240.0.64   <none>           <none>
    gpu-operator-1778819096-node-feature-discovery-worker-xh4qz       1/1     Running   0          2m21s   172.17.121.29   10.240.0.66   <none>           <none>
    gpu-operator-76c686b9df-kn4dw                                     1/1     Running   0          2m21s   172.17.64.92    10.240.0.64   <none>           <none>
    ```
    {: screen}

### Step 3: Upgrade the cluster control plane
{: #gpu-migrate-multiple-upgrade-master}

1. Upgrade the cluster control plane to version 1.36.

    ```sh
    ibmcloud ks cluster master update --cluster <cluster_name> --version 1.36.0
    ```
    {: pre}

2. Verify the control plane upgrade.

    ```sh
    ibmcloud ks cluster get -c <cluster_name>
    ```
    {: pre}

    Example output:

    ```sh
    Master
    Status:     Ready
    State:      deployed
    Health:     normal
    Version:    1.36.0_1506
    ```
    {: screen}

### Step 4: Upgrade the first worker node
{: #gpu-migrate-multiple-upgrade-first-worker}

1. Replace the first worker node.

    ```sh
    ibmcloud ks worker replace -w test-d8397vk20kb65iocenn0-btspstggput-default-000001e4 -c <cluster_name> --update
    ```
    {: pre}

2. Verify the node upgrade.

    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

    Example output:
    ```sh
    ID                                                       Primary IP    Flavor         State    Status   Zone         Version       Operating System
    test-d8397vk20kb65iocenn0-btspstggput-default-0000024b   10.240.0.66   gx3.16x80.l4   normal   Ready    us-south-1   1.35.4_1528   UBUNTU_24_64
    test-d8397vk20kb65iocenn0-btspstggput-default-00000371   10.240.0.72   gx3.16x80.l4   normal   Ready    us-south-1   1.36.0_1507   UBUNTU_24_64
    ```
    {: screen}

3. Check the GPU workload status. GPU workload scheduled on the new node will be in `Pending` state until the driver is installed.

    ```sh
    kubectl get pods -o wide
    ```
    {: pre}

    Example output:
    ```sh
    NAME             READY   STATUS    RESTARTS   AGE   IP              NODE          NOMINATED NODE   READINESS GATES
    gpu-burn-46pml   0/1     Pending   0          18s   <none>          <none>        <none>           <none>
    gpu-burn-z6xnh   1/1     Running   0          38m   172.17.121.28   10.240.0.66   <none>           <none>
    ```
    {: screen}

4. Verify GPU operator pods are running on the new node.

    ```sh
    kubectl get pods -n gpu-operator -o wide
    ```
    {: pre}

    Example output showing driver and device plugin running on the new node:
    ```sh
    NAME                                                              READY   STATUS      RESTARTS   AGE     IP               NODE          NOMINATED NODE   READINESS GATES
    gpu-feature-discovery-mw5km                                       1/1     Running     0          4m36s   172.17.116.201   10.240.0.72   <none>           <none>
    nvidia-container-toolkit-daemonset-ns6p8                          1/1     Running     0          4m36s   172.17.116.199   10.240.0.72   <none>           <none>
    nvidia-cuda-validator-vgj45                                       0/1     Completed   0          96s     172.17.116.203   10.240.0.72   <none>           <none>
    nvidia-dcgm-exporter-52cwh                                        1/1     Running     0          4m36s   172.17.116.204   10.240.0.72   <none>           <none>
    nvidia-device-plugin-daemonset-2ql7x                              1/1     Running     0          4m36s   172.17.116.202   10.240.0.72   <none>           <none>
    nvidia-driver-daemonset-zql6m                                     1/1     Running     0          5m29s   172.17.116.197   10.240.0.72   <none>           <none>
    nvidia-operator-validator-44xtz                                   1/1     Running     0          4m36s   172.17.116.200   10.240.0.72   <none>           <none>
    ```
    {: screen}

5. Verify the GPU workload scheduled on the new node.

    ```sh
    kubectl get pods -o wide
    ```
    {: pre}

    Example output:
    ```sh
    NAME             READY   STATUS    RESTARTS   AGE    IP               NODE          NOMINATED NODE   READINESS GATES
    gpu-burn-46pml   1/1     Running   0          6m8s   172.17.116.205   10.240.0.72   <none>           <none>
    gpu-burn-z6xnh   1/1     Running   0          44m    172.17.121.28    10.240.0.66   <none>           <none>
    ```
    {: screen}

### Step 5: Upgrade remaining nodes
{: #gpu-migrate-multiple-upgrade-remaining}

1. Repeat Step 4 for each remaining GPU node, upgrading one node at a time.

2. After all nodes are upgraded, verify all worker nodes are running version 1.36.

    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

    Example output:
    ```sh
    ID                                                       Primary IP    Flavor         State    Status   Zone         Version       Operating System
    test-d8397vk20kb65iocenn0-btspstggput-default-00000371   10.240.0.72   gx3.16x80.l4   normal   Ready    us-south-1   1.36.0_1507   UBUNTU_24_64
    test-d8397vk20kb65iocenn0-btspstggput-default-0000048c   10.240.0.73   gx3.16x80.l4   normal   Ready    us-south-1   1.36.0_1507   UBUNTU_24_64
    ```
    {: screen}

3. Verify all GPU operator pods are running.

    ```sh
    kubectl get pods -n gpu-operator -o wide
    ```
    {: pre}

4. Verify all GPU workloads are running.

    ```sh
    kubectl get pods -o wide
    ```
    {: pre}

    Example output:
    ```sh
    NAME             READY   STATUS    RESTARTS   AGE     IP               NODE          NOMINATED NODE   READINESS GATES
    gpu-burn-46pml   1/1     Running   0          18m     172.17.116.205   10.240.0.72   <none>           <none>
    gpu-burn-ttcbt   1/1     Running   0          6m46s   172.17.75.77     10.240.0.73   <none>           <none>
    ```
    {: screen}

## Next steps
{: #gpu-migrate-next-steps}

- Monitor your GPU workloads to ensure they are running correctly.
- Review the [NVIDIA GPU Operator documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/index.html){: external} for advanced configuration options.
- Set up monitoring for GPU metrics using the NVIDIA DCGM exporter.

## Related information
{: #gpu-migrate-related}

- [Deploying an app on a GPU machine](/docs/containers?topic=containers-deploy_app#gpu_app)
- [NVIDIA GPU Operator installation guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html){: external}
- [Kubernetes version information](/docs/containers?topic=containers-cs_versions)
