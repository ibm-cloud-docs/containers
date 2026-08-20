---

copyright:
  years: 2025, 2026

lastupdated: "2026-08-20"

keywords: kubernetes, error messages, error codes, troubleshooting reference

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Troubleshooting error message reference
{: #ts-error-glossary}

This reference lists all documented error messages and error codes across troubleshooting topics for {{site.data.keyword.containerlong_notm}}. Entries are grouped by component and link to the full troubleshooting topic.
{: shortdesc}

## Clusters and masters
{: #ts-errors-cluster}

| Error message | Troubleshooting topic |
| --- | --- |
| `Cannot complete cluster master operations because the cluster has a broken webhook application.` | [Why do cluster master operations fail due to a broken webhook?](/docs/containers?topic=containers-webhooks_update) |

| `The master is approaching its allotted memory resource limit (93%).` | [Why does my cluster master status say it is approaching its resource limit?](/docs/containers?topic=containers-master_resource_limit) |
| `etcd database size is approaching the maximum` | [Why do I see an `etcd database size is approaching the maximum` error?](/docs/containers?topic=containers-ts-etcd-capacity) |
| `The 'configuration' field is not a valid Kubernetes PodSecurityConfiguration setting.` | [Why do I get an error that my PodSecurityConfiguration is not valid?](/docs/containers?topic=containers-ts-pod-security-reset) |
| `No VPC is available. Create a VPC.` | [VPC: Why is no VPC available when I create a cluster in the console?](/docs/containers?topic=containers-ts_no_vpc) |
| `Your cluster can't pull images from the 'icr.io' domains because an IAM access policy could not be created.` | [Why can't the cluster pull images from {{site.data.keyword.registrylong_notm}} during creation?](/docs/containers?topic=containers-ts_image_pull_create) |
| `Image security enforcement update canceled. CAE008: can't enable Portieris image security enforcement because the cluster already has a conflicting image admission controller installed.` | [Why is my Portieris cluster image security enforcement installation canceled?](/docs/containers?topic=containers-portieris_enable) |
| `incorrect account for worker`, `Worker deploy failed due to network communications failing`, `Unable to connect to the IBM Cloud account.` | [Why can't I create or delete clusters or worker nodes?](/docs/containers?topic=containers-cluster_infra_errors) |
| `Unable to create cluster. The 'vpc-gen2' infrastructure operation failed with the message: the provided token is not authorized to view the specified subnet` | [Why do I get an `infrastructure operation failed` error when creating a VPC cluster?](/docs/containers?topic=containers-ts-resource-group-permissions) |
| `No resources found.`, `connection timed out`, `dial tcp: connect: connection timed out` | [Debugging common CLI issues with clusters](/docs/containers?topic=containers-ts_clis) |
| `Encrypted storage cannot be configured. Review the customer root key configuration for the worker pool.` | [Why can't I create a VPC cluster with encrypted worker nodes?](/docs/containers?topic=containers-ts-vpc-byok-encrypted-storage) |
| `Pending security group creation` | [When I create a VPC cluster, my worker nodes are stuck in `Pending security group creation`](/docs/containers?topic=containers-ts-sbd-cluster-create-quota) |
| `Infrastructure instance status is 'failed': Can't start instance because provisioning failed.` | [Why do I see DNS failures after adding a custom DNS resolver?](/docs/containers?topic=containers-ts-sbd-custom-dns) |
| `Version update canceled. CAE009: Cannot complete cluster master operations because the cluster does not pass Pod Security upgrade prerequisites.` | [Why does my cluster upgrade fail due to Pod Security upgrade prerequisites?](/docs/containers?topic=containers-ts-pod-security-125) |
| `Cannot complete cluster master operations because there is a migration in progress` | [Resolving cluster master upgrade issues: Migration in progress error](/docs/containers?topic=containers-ts-resource-migration) |
{: caption="Cluster and master error messages" caption-side="bottom"}



## Worker nodes
{: #ts-errors-workers}

| Error message | Troubleshooting topic |
| --- | --- |
| `The worker node instance ID changed. Reload the worker node if bare metal hardware was serviced.` | [Classic: Why is the bare metal instance ID inconsistent with worker records?](/docs/containers?topic=containers-bm_machine_id) |
| `The dedicated hosts for the zone 'eu-de-2' are not ready.` | [VPC: Why can't I create worker nodes on dedicated hosts?](/docs/containers?topic=containers-ts-worker-dedicated) |
| `SoftLayerAPIError(SoftLayer_Exception_Public): Could not obtain network VLAN with id #123456.` | [Classic: Why can't I add worker nodes with an invalid VLAN ID?](/docs/containers?topic=containers-suspended) |
| `Registration failed – The plan containers.kubernetes.vpc.gen2.roks is not available in <region>.` | [Why do I see a `Registration failed` error when I try to provision or reload worker nodes?](/docs/containers?topic=containers-ts-worker-plan-not-avail) |
| `A VSI with this profile will put user over quota.` | [VPC worker nodes fail to provision due to quota limits](/docs/containers?topic=containers-ts-worker-vpc-quota) |
| `warning: Container container-00 is unable to start due to an error: Back-off pulling image "registry.redhat.io/rhel8/support-tools"` | [After creating a version 1.30 cluster, my app no longer works](/docs/containers?topic=containers-ts-sbd-app-not-working) |
{: caption="Worker node error messages" caption-side="bottom"}

## Network health check (NHC) errors
{: #ts-errors-nhc}

The following error codes appear in the output of the `ibmcloud ks cluster health issues` command.

| Error code | Severity | Description | Troubleshooting topic |
| --- | --- | --- | --- |
| `NHC001` | Warning | Tigera operator has been reporting that Calico is in 'progressing' state for over an hour. | [Why does the Network status show an `NHC001` error?](/docs/containers?topic=containers-ts-network-nhc001) |
| `NHC003` | Warning | Some worker nodes in the cluster can not reach container image registries to pull images. | [Why does the Network status show an `NHC003` error?](/docs/containers?topic=containers-ts-network-nhc003) |
| `NHC004` | Warning | Some worker nodes in the cluster can not resolve VPE gateway hostnames. | [Why does the Network status show an `NHC004` error?](/docs/containers?topic=containers-ts-network-nhc004) |
| `NHC005` | Warning | Tigera operator is reporting that Calico is in 'degraded' state. | [Why does the Network status show an `NHC005` error?](/docs/containers?topic=containers-ts-network-nhc005) |
| `NHC006` | Warning | One or more DNS resolvers are not reachable from certain worker nodes. | [Why does the Network status show an `NHC006` error?](/docs/containers?topic=containers-ts-network-nhc006) |
| `NHC007` | Warning | One or more DNS resolvers are not reachable from certain worker nodes. | [Why does the Network status show an `NHC007` error?](/docs/containers?topic=containers-ts-network-nhc007) |
| `NHC009` | Error | The IAM token exchange request failed. | [Why does the Network status show an `NHC009` error?](/docs/containers?topic=containers-ts-network-nhc009) |
| `NHC010` | Error | Exceeded security group rules related quota. | [Why does the Network status show an `NHC010` error?](/docs/containers?topic=containers-ts-network-nhc010) |
| `NHC011` | Error | Exceeded security group related quota. | [Why does the Network status show an `NHC011` error?](/docs/containers?topic=containers-ts-network-nhc011) |
{: caption="Network health check (NHC) error codes" caption-side="bottom"}

## Ingress status errors (ERR and ESS codes)
{: #ts-errors-ingress-codes}

The following error codes appear in the output of the `ibmcloud ks ingress status-report get` command. Shared codes appear in both {{site.data.keyword.containerlong_notm}} and {{site.data.keyword.openshiftlong_notm}}.

| Error code | Error message | Troubleshooting topic |
| --- | --- | --- |
| `ERRDSIA` | The subdomain has incorrect addresses registered. | [Ingress error: ERRDSIA](/docs/containers?topic=containers-ts-ingress-errdsia) |
| `ERRDRISS` | The subdomain has DNS resolution issues. | [Ingress error: ERRDRISS](/docs/containers?topic=containers-ts-ingress-errdriss) |
| `ERRDSAISS` | The external provider for the given subdomain has authorization issues. | [Ingress error: ERRDSAISS](/docs/containers?topic=containers-ts-ingress-errdsaiss) |
| `ERRDSISS` | The subdomain has TLS secret issues. | [Ingress error: ERRDSISS](/docs/containers?topic=containers-ts-ingress-errdsiss) |
| `ERRSAM` | The load balancer service address is missing. | [Ingress error: ERRSAM](/docs/containers?topic=containers-ts-ingress-errsam) |
| `ESSDNE` | The secret is not present on the cluster or is in the wrong namespace. | [Ingress error: ESSDNE](/docs/containers?topic=containers-ts-ingress-essdne) |
| `ESSEC` | The certificate for TLS secret expired or will expire soon. | [Ingress error: ESSEC](/docs/containers?topic=containers-ts-ingress-essec) |
| `ESSEF` | The Opaque secret field expired or will expire soon. | [Ingress error: ESSEF](/docs/containers?topic=containers-ts-ingress-essef) |
| `ESSSMG` | Could not find the secret group. | [Ingress error: ESSSMG](/docs/containers?topic=containers-ts-ingress-esssmg) |
| `ESSSMI` | Could not access Secrets Manager instance. | [Ingress error: ESSSMI](/docs/containers?topic=containers-ts-ingress-esssmi) |
| `ESSSMINF` | The Secrets Manager instance is not found. | [Ingress error: ESSSMINF](/docs/containers?topic=containers-ts-ingress-esssminf) |
| `ESSVC` | The CRN does not match the default secret with the same domain. | [Ingress error: ESSVC](/docs/containers?topic=containers-ts-ingress-essvc) |
| `ESSWS` | The secret status shows a warning. | [Ingress error: ESSWS](/docs/containers?topic=containers-ts-ingress-essws) |
| `ERRADNF` | The ALB deployment is not found on the cluster. | [Ingress error: ERRADNF](/docs/containers?topic=containers-ts-ingress-erradnf) |
| `ERRADRUH` | One or more ALB pods are not in the running state. | [Ingress error: ERRADRUH](/docs/containers?topic=containers-ts-ingress-erradruh) |
| `ERRAHCF` | The ALB is unable to respond to health requests. | [Ingress error: ERRAHCF](/docs/containers?topic=containers-ts-ingress-errahcf) |
| `ERRAHINF` | The ALB health Ingress resource is not found on the cluster. | [Ingress error: ERRAHINF](/docs/containers?topic=containers-ts-ingress-errahinf) |
| `ERRAHSNF` | The ALB health service is not found on the cluster. | [Ingress error: ERRAHSNF](/docs/containers?topic=containers-ts-ingress-errahsnf) |
| `ERRAVUS` | The ALB version is no longer supported. | [Ingress error: ERRAVUS](/docs/containers?topic=containers-ts-ingress-erravus) |
| `ERRHPAETPI` | Autoscaling is ineffective. | [Ingress error: ERRHPAETPI](/docs/containers?topic=containers-ts-ingress-errhpaetpi) |
| `ERRHPAIWC` | The cluster does not have enough worker nodes to satisfy the autoscaling configuration. | [Ingress error: ERRHPAIWC](/docs/containers?topic=containers-ts-ingress-errhpaiwc) |
| `ERRHPANA` | Autoscaling is failing. | [Ingress error: ERRHPANA](/docs/containers?topic=containers-ts-ingress-errhpana) |
| `ERRHPANF` | The autoscaler resource is missing. | [Ingress error: ERRHPANF](/docs/containers?topic=containers-ts-ingress-errhpanf) |
| `ERRICCNF` | The Ingress controller ConfigMap is not found on the cluster. | [Ingress error: ERRICCNF](/docs/containers?topic=containers-ts-ingress-erriccnf) |
| `ERRSNF` | The load balancer service is missing. | [Ingress error: ERRSNF](/docs/containers?topic=containers-ts-ingress-errsnf) |
| | `0/3 nodes are available: 1 node(s) didn't match pod affinity/anti-affinity` | [Why do ALB pods not deploy to worker nodes?](/docs/containers?topic=containers-alb-pod-affinity) |
| | `No valid subnets found for the specified zone.` | [Classic clusters: Why does enabling Ingress ALBs result in subnet errors?](/docs/containers?topic=containers-cs_alb_subnet) |
| | `admission webhook "validate.nginx.ingress.kubernetes.io" denied the request: nginx.ingress.kubernetes.io/configuration-snippet annotation cannot be used.` | [Ingress resource operations refused by validating webhook](/docs/containers?topic=containers-ts-ingress-webhook) |
{: caption="Ingress status error codes (ERR and ESS)" caption-side="bottom"}

## Load balancers
{: #ts-errors-lb}

| Error message | Troubleshooting topic |
| --- | --- |
| `The VPC load balancer that routes requests to this Kubernetes LoadBalancer service is offline.` | [VPC clusters: Why can't my app connect via load balancer?](/docs/containers?topic=containers-vpc_ts_lb) |
| `The subnet with ID(s) '<subnet_id>' has insufficient available ipv4 addresses.` | [VPC clusters: Why does a Kubernetes `LoadBalancer` service fail with no IPs?](/docs/containers?topic=containers-vpc_no_lb) |
| `The load balancer was created in zone <zone>. This setting cannot be changed.` | [VPC Clusters: My VPC NLB has a zone error and does not update](/docs/containers?topic=containers-ts-nlb-vpc-zone) |
| `Warning CreatingCloudLoadBalancerFailed ... Failed ensuring LoadBalancer: FindLoadBalancer failed ... 401 Unauthorized ... BXNIM0430E` | [Why do I see `SyncLoadBalancerFailed` errors when creating a VPC cluster?](/docs/containers?topic=containers-ts-loadbalancer-sync-failed) |
| Security group protocol mismatch events on load balancer creation or update | [VPC clusters: Security group protocol error creating or updating a LoadBalancer](/docs/containers?topic=containers-vpc_ts_lb_security_group_error) |
{: caption="Load balancer error messages" caption-side="bottom"}

## Apps and services
{: #ts-errors-apps}

| Error message | Troubleshooting topic |
| --- | --- |
| `Failed to create pod sandbox: rpc error: ... failed to request 1 IPv4 addresses. IPAM allocated only 0` | [Why don't my containers start?](/docs/containers?topic=containers-ts-app-container-start) |
| `ImagePullBackOff` or image pull authorization errors | [Why do images fail to pull from registry with `ImagePullBackOff` or authorization errors?](/docs/containers?topic=containers-ts-app-image-pull) |
| `pull QPS exceeded` errors during image pulls | [Why do pods show `pull QPS exceeded` errors during image pulls?](/docs/containers?topic=containers-ts-vpc-image-pull-qps) |
| `Error: failed to download "<helm_repo>/<chart_name>"` | [Troubleshooting helm chart installation updated configuration values](/docs/containers?topic=containers-ts-app-helm-install) |
| `This service doesn't support creation of keys` | [Resolving service binding errors in IBM Cloud clusters](/docs/containers?topic=containers-ts-app-svc-key) |
| Pod remains in `Pending` state | [Why do pods remain in pending state?](/docs/containers?topic=containers-ts-app-pod-pending) |
| Pod repeatedly fails to restart or is unexpectedly removed | [Why do pods repeatedly fail to restart or are unexpectedly removed?](/docs/containers?topic=containers-ts-app-pod-fail) |
| `unable to validate against any pod security policy` | [Why do my pods fail to deploy after applying a pod security policy?](/docs/containers?topic=containers-ts-app-psp) |
| Cluster or service instance already exists with the same name | [Why does binding a service to a cluster result in a same name error?](/docs/containers?topic=containers-ts-app-svc-bind-name) |
| `The server is currently unable to handle the request (get pods.metrics.k8s.io)` | [Troubleshooting metrics server issues in Kubernetes clusters](/docs/containers?topic=containers-debug_metrics_server) |
{: caption="App and service error messages" caption-side="bottom"}

## Permissions and credentials
{: #ts-errors-perms}

| Error message | Troubleshooting topic |
| --- | --- |
| `User doesn't have permissions to create or manage Storage` | [What permissions do I need to manage storage and create PVCs?](/docs/containers?topic=containers-missing_permissions) |
{: caption="Permission and credential error messages" caption-side="bottom"}

## Secure by default (SBD)
{: #ts-errors-sbd}

| Error message | Troubleshooting topic |
| --- | --- |
| `warning: Container container-00 is unable to start due to an error: Back-off pulling image "registry.redhat.io/rhel8/support-tools"` | [After creating a version 1.30 cluster, my app no longer works](/docs/containers?topic=containers-ts-sbd-app-not-working) |
| `Pending security group creation` | [When I create a VPC cluster, my worker nodes are stuck in `Pending security group creation`](/docs/containers?topic=containers-ts-sbd-cluster-create-quota) |
| `Infrastructure instance status is 'failed': Can't start instance because provisioning failed.` | [Why do I see DNS failures after adding a custom DNS resolver?](/docs/containers?topic=containers-ts-sbd-custom-dns) |
| Nodeport apps not working after updating to version 1.30 | [Fixing nodeport apps after updating cluster version 1.30 or later](/docs/containers?topic=containers-ts-sbd-nodeport-not-working) |
| Other clusters in the VPC failing after creating a version 1.30 cluster | [After creating a version 1.30 cluster, applications running in other clusters in my VPC are failing](/docs/containers?topic=containers-ts-sbd-other-clusters) |
| VSIs cannot access VPE gateway | [Why can't my VSIs access VPE gateway?](/docs/containers?topic=containers-ts-sbd-vsi-vpe) |
{: caption="Secure by default (SBD) error messages" caption-side="bottom"}

## File Storage
{: #ts-errors-file}

| Error message | Troubleshooting topic |
| --- | --- |
| `MountVolume.SetUp failed for volume ... mount.nfs: access denied by server while mounting` | [Classic: Why am I denied server access when mounting a volume to a worker node?](/docs/containers?topic=containers-ts-storage-file-access-denied) |
| `write-permission` or non-root user ownership errors on NFS mount path | [Why does my app fail when a non-root user owns the NFS file storage mount path?](/docs/containers?topic=containers-nonroot) |
| Group ID error applying NFS file storage permissions | [Why does my app fail with a group ID error for NFS file storage permissions?](/docs/containers?topic=containers-root) |
| Non-root user cannot add access to persistent storage | [Why can't I add non-root user access to persistent storage?](/docs/containers?topic=containers-cs_storage_nonroot) |
| File systems for worker nodes changed to read-only | [Why are the file systems for worker nodes changed to read-only?](/docs/containers?topic=containers-readonly_nodes) |
| PVC remains in pending state (file storage) | [Why does my file storage PVC stay in a pending state?](/docs/containers?topic=containers-file_pvc_pending) |
| `MetadataServiceNotEnabled` | [Why do I see a `MetadataServiceNotEnabled` error for {{site.data.keyword.filestorage_vpc_short}}?](/docs/containers?topic=containers-ts-storage-vpc-file-eit-metadata) |
| `MountingTargetFailed` or `rpc error: code = DeadlineExceeded desc = context deadline exceeded` | [Why do I see a `MountingTargetFailed` error for {{site.data.keyword.filestorage_vpc_short}}?](/docs/containers?topic=containers-ts-storage-vpc-file-eit-mount-failed) |
| `SubnetFindFailed` or `rpc error: code = FailedPrecondition` on PVC creation | [Why does PVC creation fail for {{site.data.keyword.filestorage_vpc_short}}?](/docs/containers?topic=containers-ts-storage-vpc-file-eit-pvc-fails) |
| `UnresponsiveMountHelperContainerUtility` | [Why do I see an `UnresponsiveMountHelperContainerUtility` error for {{site.data.keyword.filestorage_vpc_short}}?](/docs/containers?topic=containers-ts-storage-vpc-file-eit-unresponsive) |
| `shares_snapshot_operation_not_allowed` | [Why can't I create {{site.data.keyword.filestorage_vpc_short}} snapshots?](/docs/containers?topic=containers-ts-storage-vpc-file-snapshot-create) |
| `shares_snapshot_not_found` on PVC restore | [Why can't I restore my {{site.data.keyword.filestorage_vpc_short}} snapshot to a PVC?](/docs/containers?topic=containers-ts-storage-vpc-file-snapshot-restore) |
| VPC File Storage snapshot cannot be deleted | [Why can't I delete my {{site.data.keyword.filestorage_vpc_short}} snapshot?](/docs/containers?topic=containers-ts-storage-vpc-file-snapshot-delete) |
| `'rfs' profile is not accessible` or `stunnel manager is not initialized` | [Troubleshooting Regional File Storage encryption in transit](/docs/containers?topic=containers-ts-storage-vpc-file-rfs-eit) |
| VPC File Storage PVC stays in `Pending` with capacity roundoff | [Why does my PVC stay in Pending status when using capacity roundoff?](/docs/containers?topic=containers-ts-storage-vpc-file-capacity-roundoff) |
| VPC File Storage deployment permissions error | [Why does my {{site.data.keyword.filestorage_vpc_short}} deployment fail due to a permissions error?](/docs/containers?topic=containers-ts-storage-vpc-file-non-root) |
| App pod stuck in `Container creating` when mounting VPC File Storage | [Why is my app pod stuck in `Container creating` when trying to mount {{site.data.keyword.filestorage_vpc_short}}?](/docs/containers?topic=containers-ts-vpc-file-container-creating) |
| File Storage add-on in `Critical` state | [Why is the {{site.data.keyword.filestorage_vpc_short}} add-on in `Critical` state?](/docs/containers?topic=containers-ts-storage-file-addon-cm) |
{: caption="File Storage error messages" caption-side="bottom"}

## Block Storage
{: #ts-errors-block}

| Error message | Troubleshooting topic |
| --- | --- |
| `failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32` | [Why does mounting existing block storage to a pod fail with the wrong file system?](/docs/containers?topic=containers-block_filesystem) |
| `Volume not attached` | [Why do I get a `Volume not attached` error when trying to expand a {{site.data.keyword.block_storage_is_short}} volume?](/docs/containers?topic=containers-block_not_attached_vpc) |
| Block storage changes to read-only | [Why does block storage change to read-only?](/docs/containers?topic=containers-readonly_block) |
| `Message: 50% throttling of CPU in namespace kube-system for container ibmcloud-block-storage-driver-container` | [Why does the Block storage plug-in Helm chart give CPU throttling warnings?](/docs/containers?topic=containers-block_helm_cpu) |
| Block storage PVC remains in pending state | [Why does my block storage PVC stay in a pending state?](/docs/containers?topic=containers-block_pvc_pending) |
| App cannot access or write to PVC (block) | [Why can't my app access or write to a PVC?](/docs/containers?topic=containers-block_app_failures) |
| `Labels: ibm.io/pv-connectivity-status: limited` | [Why does my Block Storage persistent volume show a `limited` connectivity status?](/docs/containers?topic=containers-block-pv-limited-connectivity) |
| Block Storage API key reset causes provisioning failure | [{{site.data.keyword.block_storage_is_short}} PVC creation fails after API key reset](/docs/containers?topic=containers-vpc-block-api-key-reset-ts) |
| `UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.` | [Why does mounting {{site.data.keyword.blockstorageshort}} fail with a file system check error?](/docs/containers?topic=containers-ts-storage-fsck) |
| Block storage volume snapshot cannot be deleted | [Why can't I delete my {{site.data.keyword.block_storage_is_short}} volume snapshot resources?](/docs/containers?topic=containers-ts-storage-volumesnapshotdelete) |
| Block storage snapshot creation fails | [Why can't I create {{site.data.keyword.block_storage_is_short}} snapshots?](/docs/containers?topic=containers-ts-storage-snapshotfails) |
| Charges still appear for block storage devices after deleting the cluster | [Why am I still seeing charges for block storage devices after deleting my cluster?](/docs/containers?topic=containers-ts_storage_clean_volume) |
{: caption="Block Storage error messages" caption-side="bottom"}

## Object Storage
{: #ts-errors-cos}

| Error message | Troubleshooting topic |
| --- | --- |
| `pvc:...:can't access bucket <bucket_name>: NotFound: Not Found` | [Why can't my PVC access an existing bucket?](/docs/containers?topic=containers-cos_access_bucket_fails) |
| `Error: symlink ... helm-ibmc: file exists` | [Why does installing the Object storage Helm plug-in fail?](/docs/containers?topic=containers-cos_helm_fails) |
| `d--------- 1 root root 0 Jan 1 1970 <file_name>` (non-root user cannot access files) | [Resolving non-root user access issues to files in IBM Cloud](/docs/containers?topic=containers-cos_nonroot_access) |
| `EPERM: operation not permitted` | [Why does my app pod fail with an `Operation not permitted` error?](/docs/containers?topic=containers-cos_operation_not_permitted) |
| `chown: changing ownership of '<volume_mount_path>': Input/output error` | [Why can't the ownership of the mount path be changed?](/docs/containers?topic=containers-cos_mountpath_error) |
| `Error: rendered manifest contains a resource that already exists. ... existing_kind: storageClass` | [Why does installing the {{site.data.keyword.cos_full_notm}} plug-in fail?](/docs/containers?topic=containers-cos_plugin_fails) |
| `Bad value for ibm.io/object-store-endpoint ... scheme is missing.` | [Why do I see wrong s3fs or IAM API endpoints when I create a PVC?](/docs/containers?topic=containers-cos_api_endpoint_failure) |
| `SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided.` | [Why do I see wrong credentials or access denied messages when I create a PVC?](/docs/containers?topic=containers-cred_failure) |
| Object Storage PVC remains in pending state | [Why does my PVC remain in a pending state?](/docs/containers?topic=containers-cos_pvc_pending) |
| `can't get credentials: can't get secret tsecret-key: secrets "secret-key" not found` | [Why does PVC or pod creation fail due to not finding the Kubernetes secret?](/docs/containers?topic=containers-cos_secret_access_fails) |
| `Transport endpoint is not connected.` | [Why is the transport endpoint not connected?](/docs/containers?topic=containers-cos_transport_ts_connect) |
| `Error mounting volume: s3fs mount failed: s3fs: error while loading shared libraries: libfuse.so.2` | [Why do I see a volume mounting error when using the {{site.data.keyword.cos_full_notm}} plug-in?](/docs/containers?topic=containers-ts-cos-storage-dep) |
| Transport endpoint not connected errors when using the COS cluster add-on | [Why do I see transport endpoint not connected errors when using the {{site.data.keyword.cos_full_notm}} cluster add-on?](/docs/containers?topic=containers-ts-storage-cos-csi-addon) |
{: caption="Object Storage error messages" caption-side="bottom"}

## Portworx Storage
{: #ts-errors-portworx}

| Error message | Troubleshooting topic |
| --- | --- |
| `kp.Error: ... msg='Unauthorized: The user does not have access to the specified resource'` | [Why does encryption fail with an invalid KMS endpoint?](/docs/containers?topic=containers-px-kms-endpoint) |
{: caption="Portworx Storage error messages" caption-side="bottom"}



## Related links
{: #ts-errors-related}

- [Checking the Ingress status report](/docs/containers?topic=containers-ingress-status)
- [Checking the status of Network components](/docs/containers?topic=containers-network-status)
- [Cluster states and statuses](/docs/containers?topic=containers-cluster-states-reference)
- [Worker node states](/docs/containers?topic=containers-worker-node-state-reference)
- [Getting help and support](/docs/containers?topic=containers-get-help)
