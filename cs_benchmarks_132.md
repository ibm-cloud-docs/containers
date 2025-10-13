---

copyright: 
  years: 2024, 2025
lastupdated: "2025-10-13"

keywords: containers, benchmarks, 1.32, containers benchmarks, containers 1.32

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Kubernetes version 1.32 CIS Kubernetes benchmark
{: #cis-benchmark-132}

The Center for Internet Security (CIS) publishes the [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes/){: external} as a framework of specific steps to configure Kubernetes more securely and with standards that are commensurate to various industry regulations. This document contains the results of the version 1.5 CIS Kubernetes benchmark for clusters that run Kubernetes version 1.32. For more information or help understanding the benchmark, see [Using the benchmark](/docs/containers?topic=containers-cis-benchmark).
{: shortdesc}


## 1 Master node security configuration
{: #1-master-node-security-configuration-132}

### 1.1 Master node configuration files
{: #11-master-node-configuration-files-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 1.1.1 | Ensure that the API server pod specification file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.2 | Ensure that the API server pod specification file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.3 | Ensure that the controller manager pod specification file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.4 | Ensure that the controller manager pod specification file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.5 | Ensure that the scheduler pod specification file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.6 | Ensure that the scheduler pod specification file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.7 | Ensure that the etcd pod specification file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.8 | Ensure that the etcd pod specification file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.9 | Ensure that the Container Network Interface file permissions are set to `644` or more restrictive. | Not Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.10 | Ensure that the Container Network Interface file ownership is set to `root:root`. | Not Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.11 | Ensure that the etcd data directory permissions are set to `700` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.12 | Ensure that the etcd data directory ownership is set to `etcd:etcd`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.13 | Ensure that the `admin.conf` file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.14 | Ensure that the `admin.conf` file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.15 | Ensure that the `scheduler.conf` file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.16 | Ensure that the `scheduler.conf` file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.17 | Ensure that the `controller-manager.conf` file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.18 | Ensure that the `controller-manager.conf` file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.19 | Ensure that the Kubernetes PKI directory and file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.20 | Ensure that the Kubernetes PKI certificate file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.1.21 | Ensure that the Kubernetes PKI key file permissions are set to `600`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
{: caption="Section 1.1 Master node configuration files benchmark results" caption-side="bottom"}

### 1.2 API server
{: #12-api-server-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 1.2.1 | Ensure that the `--anonymous-auth` argument is set to `false`. | Not Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 1.2.2 | Ensure that the `--basic-auth-file` argument is not set. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.3 | Ensure that the `--token-auth-file` parameter is not set. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.4 | Ensure that the `--kubelet-https` argument is set to `true`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.5 | Ensure that the `--kubelet-client-certificate` and `--kubelet-client-key` arguments are set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.6 | Ensure that the `--kubelet-certificate-authority` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.7 | Ensure that the `--authorization-mode` argument is not set to `AlwaysAllow`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.8 | Ensure that the `--authorization-mode` argument includes Node. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.9 | Ensure that the `--authorization-mode` argument includes RBAC. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.10 | Ensure that the admission control plug-in `EventRateLimit` is set. | Not Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 1.2.11 | Ensure that the admission control plug-in `AlwaysAdmit` is not set. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.12 | Ensure that the admission control plug-in `AlwaysPullImages` is set. | Not Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 1.2.13 | Ensure that the admission control plug-in `SecurityContextDeny` is set if `PodSecurityPolicy` is not used. | Not Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 1.2.14 | Ensure that the admission control plug-in `ServiceAccount` is set. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.15 | Ensure that the admission control plug-in `NamespaceLifecycle` is set. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.16 | Ensure that the admission control plug-in `PodSecurityPolicy` is set. | Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 1.2.17 | Ensure that the admission control plug-in `NodeRestriction` is set. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.18 | Ensure that the `--insecure-bind-address` argument is not set. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.19 | Ensure that the `--insecure-port` argument is set to `0`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.20 | Ensure that the `--secure-port` argument is not set to `0`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.21 | Ensure that the `--profiling` argument is set to `false`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.22 | Ensure that the `--audit-log-path` argument is set. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 1.2.23 | Ensure that the `--audit-log-maxage` argument is set to `30` or as appropriate. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 1.2.24 | Ensure that the `--audit-log-maxbackup` argument is set to `10` or as appropriate. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 1.2.25 | Ensure that the `--audit-log-maxsize` argument is set to `100` or as appropriate. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 1.2.26 | Ensure that the `--request-timeout` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.27 | Ensure that the `--service-account-lookup` argument is set to `true`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.28 | Ensure that the `--service-account-key-file` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.29 | Ensure that the `--etcd-certfile` and `--etcd-keyfile` arguments are set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.30 | Ensure that the `--tls-cert-file` and `--tls-private-key-file` arguments are set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.31 | Ensure that the `--client-ca-file` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.32 | Ensure that the `--etcd-cafile` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.2.33 | Ensure that the `--encryption-provider-config` argument is set as appropriate. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 1.2.34 | Ensure that encryption providers are appropriately configured. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 1.2.35 | Ensure that the API Server only makes use of Strong Cryptographic Ciphers. | Not Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
{: caption="Section 1.2 API server benchmark results" caption-side="bottom"}

### 1.3 Controller manager
{: #13-controller-manager-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 1.3.1 | Ensure that the `--terminated-pod-gc-threshold` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.3.2 | Ensure that the `--profiling` argument is set to `false`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.3.3 | Ensure that the `--use-service-account-credentials` argument is set to `true`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.3.4 | Ensure that the `--service-account-private-key-file` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.3.5 | Ensure that the `--root-ca-file` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.3.6 | Ensure that the `RotateKubeletServerCertificate` argument is set to `true`. | Scored | 2 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 1.3.7 | Ensure that the `--bind-address` argument is set to `127.0.0.1`. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
{: caption="Section 1.3 Controller manager benchmark results" caption-side="bottom"}

### 1.4 Scheduler
{: #14-scheduler-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 1.4.1 | Ensure that the `--profiling` argument is set to `false`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 1.4.2 | Ensure that the `--bind-address` argument is set to `127.0.0.1`. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
{: caption="Section 1.4 Scheduler benchmark results" caption-side="bottom"}

## 2 Etcd node configuration
{: #2-etcd-node-configuration-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 2.1 | Ensure that the `--cert-file` and `--key-file` arguments are set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 2.2 | Ensure that the `--client-cert-auth` argument is set to `true`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 2.3 | Ensure that the `--auto-tls` argument is not set to `true`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 2.4 | Ensure that the `--peer-cert-file` and `--peer-key-file` arguments are set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 2.5 | Ensure that the `--peer-client-cert-auth` argument is set to `true`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 2.6 | Ensure that the `--peer-auto-tls` argument is not set to `true`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 2.7 | Ensure that a unique Certificate Authority is used for etcd. | Not Scored | 2 | Pass | {{site.data.keyword.IBM_notm}} |
{: caption="Section 2 Etcd node configuration benchmark results" caption-side="bottom"}

## 3 Control plane configuration
{: #3-control-plane-configuration-132}

### 3.1 Authentication and authorization
{: #31-authentication-and-authorization-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 3.1.1 | Client certificate authentication should not be used for users. | Not Scored | 2 | Pass | Shared |
{: caption="Section 3.1 Authentication and authorization benchmark results" caption-side="bottom"}

### 3.2 Logging
{: #32-logging-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 3.2.1 | Ensure that a minimal audit policy is created. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 3.2.2 | Ensure that the audit policy covers key security concerns. | Not Scored | 2 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
{: caption="Section 3.2 Logging benchmark results" caption-side="bottom"}

## 4 Worker node security configuration
{: #4-worker-node-security-configuration-132}

### 4.1 Worker node configuration files
{: #41-worker-node-configuration-files-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 4.1.1 | Ensure that the kubelet service file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.2 | Ensure that the kubelet service file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.3 | Ensure that the proxy `kubeconfig` file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.4 | Ensure that the proxy `kubeconfig` file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.5 | Ensure that the `kubelet.conf` file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.6 | Ensure that the `kubelet.conf` file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.7 | Ensure that the certificate authorities file permissions are set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.8 | Ensure that the client certificate authorities file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.9 | Ensure that the kubelet configuration file has permissions set to `644` or more restrictive. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.1.10 | Ensure that the kubelet configuration file ownership is set to `root:root`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
{: caption="Section 4.1 Worker node configuration files benchmark results" caption-side="bottom"}

### 4.2 Kubelet
{: #42-kubelet-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 4.2.1 | Ensure that the `--anonymous-auth` argument is set to `false`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.2.2 | Ensure that the `--authorization-mode` argument is not set to `AlwaysAllow`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.2.3 | Ensure that the `--client-ca-file` argument is set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.2.4 | Ensure that the `--read-only-port` argument is set to `0`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.2.5 | Ensure that the `--streaming-connection-idle-timeout` argument is not set to `0`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.2.6 | Ensure that the `--protect-kernel-defaults` argument is set to `true`. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 4.2.7 | Ensure that the `--make-iptables-util-chains` argument is set to `true`. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.2.8 | Ensure that the `--hostname-override` argument is not set. | Not Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 4.2.9 | Ensure that the `--event-qps` argument is set to `0` or a level which ensures appropriate event capture. | Not Scored | 2 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.2.10 | Ensure that the `--tls-cert-file` and `--tls-private-key-file` arguments are set as appropriate. | Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 4.2.11 | Ensure that the `--rotate-certificates` argument is not set to `false`. | Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 4.2.12 | Ensure that the `RotateKubeletServerCertificate` argument is set to `true`. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | {{site.data.keyword.IBM_notm}} |
| 4.2.13 | Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers. | Not Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
{: caption="Section 4.2 Kubelet benchmark results" caption-side="bottom"}

## 5 Kubernetes policies
{: #5-kubernetes-policies-132}

### 5.1 RBAC and service accounts
{: #51-rbac-and-service-accounts-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 5.1.1 | Ensure that the cluster-admin role is only used where required. | Not Scored | 1 | Pass | Shared |
| 5.1.2 | Minimize access to secrets. | Not Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 5.1.3 | Minimize wildcard use in `Roles` and `ClusterRoles`. | Not Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 5.1.4 | Minimize access to create pods. | Not Scored | 1 | Pass | Shared |
| 5.1.5 | Ensure that default service accounts are not actively used. | Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 5.1.6 | Ensure that Service Account Tokens are only mounted where necessary. | Not Scored | 1 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
{: caption="Section 5.1 RBAC and service accounts benchmark results" caption-side="bottom"}

### 5.2 Pod security policies
{: #52-pod-security-policies-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 5.2.1 | Minimize the admission of privileged containers. | Not Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
| 5.2.2 | Minimize the admission of containers wishing to share the host process ID namespace. | Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
| 5.2.3 | Minimize the admission of containers wishing to share the host IPC namespace. | Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
| 5.2.4 | Minimize the admission of containers wishing to share the host network namespace. | Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
| 5.2.5 | Minimize the admission of containers with `allowPrivilegeEscalation`. | Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
| 5.2.6 | Minimize the admission of root containers. | Not Scored | 2 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
| 5.2.7 | Minimize the admission of containers with the NET_RAW capability. | Not Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
| 5.2.8 | Minimize the admission of containers with added capabilities. | Not Scored | 1 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
| 5.2.9 | Minimize the admission of containers with capabilities assigned. | Not Scored | 2 | [Pass](#ibm-remediations-and-explanations-132) | Shared |
{: caption="Section 5.2 Pod security policies benchmark results" caption-side="bottom"}

### 5.3 Network policies and CNI
{: #53-network-policies-and-cni-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 5.3.1 | Ensure that the CNI in use supports Network Policies. | Not Scored | 1 | Pass | {{site.data.keyword.IBM_notm}} |
| 5.3.2 | Ensure that all Namespaces have Network Policies defined. | Scored | 2 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
{: caption="Section 5.3 Network policies and CNI benchmark results" caption-side="bottom"}

### 5.4 Secrets management
{: #54-secrets-management-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 5.4.1 | Prefer using secrets as files over secrets as environment variables. | Not Scored | 1 | Pass | Shared |
| 5.4.2 | Consider external secret storage. | Not Scored | 2 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
{: caption="Section 5.4 Secrets management benchmark results" caption-side="bottom"}

### 5.5 Extensible admission control
{: #55-extensible-admission-control-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 5.5.1 | Configure Image Provenance using `ImagePolicyWebhook` admission controller. | Not Scored | 2 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
{: caption="Section 5.5 Extensible admission control benchmark results" caption-side="bottom"}

### 5.7 General policies
{: #57-general-policies-132}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |
| 5.7.1 | Create administrative boundaries between resources using namespaces. | Not Scored | 1 | Pass | Shared |
| 5.7.2 | Ensure that the `seccomp` profile is set to docker/default in your pod definitions. | Not Scored | 2 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 5.7.3 | Apply Security Context to Your Pods and Containers. | Not Scored | 2 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
| 5.7.4 | The default namespace should not be used. | Scored | 2 | [Fail](#ibm-remediations-and-explanations-132) | Shared |
{: caption="Section 5.7 General policies benchmark results" caption-side="bottom"}

### {{site.data.keyword.IBM_notm}} remediations and explanations
{: #ibm-remediations-and-explanations-132}

| Section | Remediation and explanation |
| --- | --- |
| 1.2.1 | {{site.data.keyword.IBM_notm}} utilizes RBAC for cluster protection, but allows anonymous discovery, which is considered reasonable per [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes/){: external}. |
| 1.2.10 | {{site.data.keyword.IBM_notm}} does not enable the [`EventRateLimit`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#eventratelimit){: external} admission controller since it is a Kubernetes alpha feature. |
| 1.2.12 | {{site.data.keyword.IBM_notm}} does not enable the [`AlwaysPullImages`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#alwayspullimages){: external} admission controller since it overrides a container's `imagePullPolicy` and may impact performance. |
| 1.2.13 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 1.2.16 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 1.2.22 | {{site.data.keyword.IBM_notm}} can optionally [enable Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| 1.2.23 | {{site.data.keyword.IBM_notm}} can optionally [enable Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| 1.2.24 | {{site.data.keyword.IBM_notm}} can optionally [enable Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| 1.2.25 | {{site.data.keyword.IBM_notm}} can optionally [enable Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| 1.2.33 | {{site.data.keyword.IBM_notm}} can optionally [enable a Kubernetes Key Management Service (KMS) provider](/docs/containers?topic=containers-encryption#cluster-secret-encryption). |
| 1.2.34 | {{site.data.keyword.IBM_notm}} can optionally [enable a Kubernetes Key Management Service (KMS) provider](/docs/containers?topic=containers-encryption#cluster-secret-encryption). |
| 1.3.6 | {{site.data.keyword.IBM_notm}} rotates certificates on every worker node reload or update. |
| 1.3.7 | The Controller Manager IP address cannot be restricted to `127.0.0.1`. The {{site.data.keyword.IBM_notm}} configuration is required so health checks can be performed against it. It is not exposed publicly or privately to customers. |
| 1.4.2 | The Scheduler IP address cannot be restricted to `127.0.0.1`. The {{site.data.keyword.IBM_notm}} configuration is required so health checks can be performed against it. It is not exposed publicly or privately to customers. |
| 3.2.1 | {{site.data.keyword.IBM_notm}} can optionally [enable Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| 3.2.2 | {{site.data.keyword.IBM_notm}} can optionally [enable Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| 4.2.6 | {{site.data.keyword.IBM_notm}} does not protect kernel defaults to allow customers to [tune kernel parameters](/docs/containers?topic=containers-kernel). |
| 4.2.8 | {{site.data.keyword.IBM_notm}} ensures that the hostname matches the name issued by the infrastructure. |
| 4.2.11 | {{site.data.keyword.IBM_notm}} rotates certificates on every worker node reload or update. |
| 4.2.12 | {{site.data.keyword.IBM_notm}} rotates certificates on every worker node reload or update. |
| 5.1.2 | {{site.data.keyword.IBM_notm}} deploys some system components that could have their Kubernetes secret access further restricted. |
| 5.1.3 | {{site.data.keyword.IBM_notm}} deploys some system components that could have their Kubernetes resource access further restricted. |
| 5.1.5 | {{site.data.keyword.IBM_notm}} does not set [`automountServiceAccountToken: false`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server){: external} for each default service account. |
| 5.1.6 | {{site.data.keyword.IBM_notm}} deploys some system components that could set [`automountServiceAccountToken: false`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server){: external}. |
| 5.2.1 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.2.2 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.2.3 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.2.4 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.2.5 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.2.6 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.2.7 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.2.8 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.2.9 | {{site.data.keyword.IBM_notm}} can optionally configure [pod security admission](/docs/containers?topic=containers-pod-security-admission), which is similar to the unsupported [Kubernetes pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. |
| 5.3.2 | {{site.data.keyword.IBM_notm}} has a set of [default Calico and Kubernetes network policies defined](/docs/containers?topic=containers-network_policies#default_policy) and [additional network policies can optionally be added](/docs/containers?topic=containers-network_policies#adding_network_policies). |
| 5.4.2 | {{site.data.keyword.IBM_notm}} can optionally [enable Secrets Manager service](/docs/containers?topic=containers-secrets-mgr). |
| 5.5.1 | {{site.data.keyword.IBM_notm}} can optionally [enable image security enforcement](/docs/containers?topic=containers-images#portieris-image-sec). |
| 5.7.2 | {{site.data.keyword.IBM_notm}} does not annotate all pods with [`seccomp` profiles](https://kubernetes.io/docs/concepts/security/pod-security-policy/#seccomp){: external}. |
| 5.7.3 | {{site.data.keyword.IBM_notm}} deploys some system components that do not set a [pod or container `securityContext`](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/){: external}. |
| 5.7.4 | {{site.data.keyword.IBM_notm}} deploys some Kubernetes resources to the default names. |
{: caption="Section {{site.data.keyword.IBM_notm}} remediations and explanations benchmark results" caption-side="bottom"}
