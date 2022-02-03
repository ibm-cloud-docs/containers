---

copyright: 
  years: 2014, 2022
lastupdated: "2022-02-03"

keywords: kubernetes

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Default service settings for Kubernetes components
{: #service-settings}

Review the default settings for Kubernetes components, such as the `kube-apiserver`, `kubelet`, `kube-scheduler`, or `kube-proxy` that {{site.data.keyword.containerlong}} sets when you create your cluster. 
{: shortdesc}



## `kube-apiserver`
{: #kube-apiserver}

Review the default settings for the `kube-apiserver` master component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

| Category  |  Default settings |
|----------|------|
| Default pod tolerations | - `default-not-ready-toleration-seconds=600s`  \n - `default-unreachable-toleration-seconds=600s` | 
| Privileged pods | `allow-privileged=true` | 
| Request headers | - `requestheader-client-ca-file=/mnt/etc/kubernetes-cert/ca.pem`  \n - `requestheader-username-headers=X-Remote-User`  \n - `requestheader-group-headers=X-Remote-Group`  \n - `requestheader-extra-headers-prefix=X-Remote-Extra-` | 
| Number of client requests | - `k8s_max_requests_inflight: 1600`  \n - `k8s_max_mutating_requests_inflight: 800`|
| Admission controllers | - `NamespaceLifecycle`  \n - `LimitRanger`  \n - `ServiceAccount`  \n - `MutatingAdmissionWebhook`  \n - `ValidatingAdmissionWebhook`  \n - `ResourceQuota`  \n - `PodSecurityPolicy`  \n - `DefaultTolerationSeconds`  \n - `StorageObjectInUseProtection`  \n - `PersistentVolumeClaimResize`  \n - `Priority`  \n - `NodeRestriction`  \n - `TaintNodesByCondition`  \n - `CertificateApproval` (Kubernetes 1.18 or later)  \n - CertificateSigning` (Kubernetes 1.18 or later)</li><li>`CertificateSubjectRestriction` (Kubernetes 1.18 or later)</li><li>`DefaultIngressClass` (Kubernetes 1.18 or later)</li><li>`RuntimeClass` (Kubernetes 1.20 or later)</li><li>`DenyServiceExternalIPs` (Kubernetes 1.21 or later)</li></ul> |
| Kube audit log config | - `audit-log-maxsize=128`  \n - `audit-log-maxage=2`  \n - `audit-log-maxbackup=2` | 
| Feature gates | See [Feature gates](#feature-gates) | 
| TLS cipher support | <p><strong>TLS version =< 1.2 (Kubernetes version 1.19 and earlier)</strong>:</p>- `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`  \n - `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`  \n - `TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256`  \n - `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`  \n - `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`  \n - `TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256`<p><strong>TLS version 1.3 (Kubernetes version 1.19 and later)</strong>:</p>- `TLS_AES_128_GCM_SHA256`  \n - `TLS_CHACHA20_POLY1305_SHA256`  \n - `TLS_AES_256_GCM_SHA384`|
{: summary="The rows are read from left to right. The category is in the first column, with the description in the second column."}
{: caption="kube-apiserver settings" caption-side="top"}

## `kube-controller-manager`
{: #kube-controller-manager}

Review the default settings for the `kube-controller-manager` master component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}


| Category  | Default settings |
|----------|------|
| Feature gates | See [Feature gates](#feature-gates)|
| Pod garbage collection threshold | `terminated-pod-gc-threshold=12500` | 
| Horizontal pod autoscaling | `horizontal-pod-autoscaler-use-rest-clients=true` |
| TLS cipher support | <p><strong>TLS version =< 1.2 (Kubernetes version 1.19 and earlier)</strong>:</p>- `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`  \n - `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`  \n - `TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256`  \n - `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`  \n - `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`  \n - `TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256`<p><strong>TLS version 1.3 (Kubernetes version 1.19 and later)</strong>:</p>- `TLS_AES_128_GCM_SHA256`  \n - `TLS_CHACHA20_POLY1305_SHA256`  \n - `TLS_AES_256_GCM_SHA384`|
{: summary="The rows are read from left to right. The category is in the first column, with the description in the second column."}
{: caption="kube-controller-manager settings" caption-side="top"}


## `kubelet`
{: #kubelet}

Review the default settings for the `kubelet` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}


| Category  | Default settings |
|----------|------|
| cgroups | - `kubelet-cgroups=/podruntime/kubelet`  \n - `runtime-cgroups=/podruntime/runtime` | 
| Container logs | - `container-log-max-size=100Mi`  \n - `container-log-max-files=3` |
| Container runtime endpoint | `container-runtime-endpoint=unix:///run/containerd/containerd.sock` | 
| CPU CFS quota | `cpu-cfs-quota-period=20ms` |
| Feature gates | See [Feature gates](#feature-gates). In addition, `CRIContainerLogRotation=true` is set. | 
| File check frequency | `file-check-frequency=5s` |
| Graceful Node Shutdown | For Kubernetes version 1.21 and later:- `shutdownGracePeriod: 30s`  \n - `shutdownGracePeriodCriticalPods: 15s` |
| Kubernetes and system reserves | - `kube-reserved='memory=1051Mi,cpu=36m,pid=2048'`  \n - `system-reserved='memory=1576Mi,cpu=54m,pid=2048'` |
| Pod eviction | - `eviction-soft='memory.available<100Mi,nodefs.available<10%,imagefs.available<10%,nodefs.inodesFree<10%,imagefs.inodesFree<10%'`  \n - `eviction-soft-grace-period='memory.available=10m,nodefs.available=10m,imagefs.available=10m,nodefs.inodesFree=10m,imagefs.inodesFree=10m'`  \n - `eviction-hard='memory.available<100Mi,nodefs.available<5%,imagefs.available<5%,nodefs.inodesFree<5%,imagefs.inodesFree<5%'` | 
| Pod manifest path | `pod-manifest-path=/etc/kubernetes/manifests` | 
| TLS cipher support | TLS version =< 1.2 (Kubernetes version 1.19 and earlier): - `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`  \n - `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`  \n - `TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256`  \n - `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`  \n - `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`  \n - `TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256`  \n TLS version 1.3 (Kubernetes version 1.19 and later): - `TLS_AES_128_GCM_SHA256`  \n - `TLS_CHACHA20_POLY1305_SHA256`  \n - `TLS_AES_256_GCM_SHA384`|
{: summary="The rows are read from left to right. The category is in the first column, with the description in the second column."}
{: caption="kubelet settings" caption-side="top"}

## `kube-scheduler`
{: #kube-scheduler}

Review the default settings for the `kube-scheduler` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

| Category | Default settings |
| -------- | ---------------- |
| TLS cipher support | TLS version =< 1.2 (Kubernetes version 1.19 and earlier)</strong>:</p>- `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`  \n - `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`  \n - `TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256`  \n - `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`  \n - `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`  \n - `TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256`<p><strong>TLS version 1.3 (Kubernetes version 1.19 and later):  \n - `TLS_AES_128_GCM_SHA256`  \n - `TLS_CHACHA20_POLY1305_SHA256`  \n - `TLS_AES_256_GCM_SHA384`|
{: summary="The rows are read from left to right. The category is in the first column, with the description in the second column."}
{: caption="kube-scheduler settings" caption-side="top"}

## `kube-proxy`
{: #kube-proxy}

Review the default settings for the `kube-proxy` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

| Category  | Default settings |
|----------|------|
| Iptable settings | - `iptables-sync-period 300s`  \n - `iptables-min-sync-period 5s` |
| Proxy mode | `proxy-mode=iptables` |
| Feature gates | See [Feature gates](#feature-gates) | 
{: summary="The rows are read from left to right. The category is in the first column, with the description in the second column."}
{: caption="kube-proxy settings" caption-side="top"}



## Feature gates
{: #feature-gates}

Review the feature gates that are applied to all master and worker node components by default in {{site.data.keyword.containerlong_notm}} clusters. These feature gates differ from the ones that are set up in community distributions. The {{site.data.keyword.cloud_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.
{: shortdesc}

| Kubernetes version | Default feature gates |
|---|---|
| 1.22 | - `ServiceLoadBalancerClass=true`  \n - ServiceLBNodePortControl=false`  \n - `CustomCPUCFSQuotaPeriod=true`  \n - `IPv6DualStack=false` |
| 1.21 | - `CustomCPUCFSQuotaPeriod=true`  \n - `IPv6DualStack=false` |
| 1.20 | - `AllowInsecureBackendProxy=false`  \n - `CustomCPUCFSQuotaPeriod=true`|
| 1.19 | - `RuntimeClass=false`  \n - `CustomCPUCFSQuotaPeriod=true`  \n - `AllowInsecureBackendProxy=false`  \n - `SCTPSupport=false`  \n - `ServiceAppProtocol=false`|
| 1.18 | - `RuntimeClass=false`  \n - `CustomCPUCFSQuotaPeriod=true`  \n - `AllowInsecureBackendProxy=false`|
{: caption="Overview of feature gates" caption-side="top"}
{: summary="The rows are read from left to right. The version is in the first column, with the default feature gates in the second column."}






