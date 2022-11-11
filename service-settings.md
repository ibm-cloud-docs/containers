---

copyright: 
  years: 2014, 2022
lastupdated: "2022-11-11"

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

Default pod tolerations
:   `default-not-ready-toleration-seconds=600s`
:   `default-unreachable-toleration-seconds=600s`

Privileged pods
:   `allow-privileged=true`

Request headers
:   `requestheader-client-ca-file=/mnt/etc/kubernetes-cert/ca.pem`
:   `requestheader-username-headers=X-Remote-User`
:   `requestheader-group-headers=X-Remote-Group`
:   `requestheader-extra-headers-prefix=X-Remote-Extra-`

Number of client requests
:   `k8s_max_requests_inflight: 1600`
:   `k8s_max_mutating_requests_inflight: 800`

Admission controllers
:   `NamespaceLifecycle`
:   `LimitRanger`
:   `ServiceAccount`
:   `MutatingAdmissionWebhook`
:   `ValidatingAdmissionWebhook`
:   `ResourceQuota`
:   `PodSecurityPolicy`
:   `DefaultTolerationSeconds`
:   `StorageObjectInUseProtection`
:   `PersistentVolumeClaimResize`
:   `Priority`
:   `NodeRestriction`
:   `TaintNodesByCondition`
:   `CertificateApproval` (Kubernetes 1.18 or later)
:   `CertificateSigning` (Kubernetes 1.18 or later)
    - `CertificateSubjectRestriction` (Kubernetes 1.18 or later)
    - `DefaultIngressClass` (Kubernetes 1.18 or later)
    - `RuntimeClass` (Kubernetes 1.20 or later)
    - `DenyServiceExternalIPs` (Kubernetes 1.21 or later)
    
Kube audit log config
:   `audit-log-maxsize=128`
:   `audit-log-maxage=2`
:   `audit-log-maxbackup=2`

Feature gates 
:   See [Feature gates](#feature-gates) 

TLS cipher support
:   TLS version =< 1.2 (Kubernetes version 1.19 and earlier):
    - `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`
    - `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`
    - `TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256`
    - `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`
    - `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`
    - `TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256`

:   TLS version 1.3 (Kubernetes version 1.19 and later):
    - `TLS_AES_128_GCM_SHA256`
    - `TLS_CHACHA20_POLY1305_SHA256`
    - `TLS_AES_256_GCM_SHA384`


## `kube-controller-manager`
{: #kube-controller-manager}

Review the default settings for the `kube-controller-manager` master component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}


Feature gates
:   See [Feature gates](#feature-gates)

Pod garbage collection threshold
:   `terminated-pod-gc-threshold=12500`

Horizontal pod autoscaling
:   `horizontal-pod-autoscaler-use-rest-clients=true`

TLS cipher support
:   TLS version =< 1.2 (Kubernetes version 1.19 and earlier):
    - `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`
    - `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`
    - `TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256`
    - `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`
    - `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`
    - `TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256`

:   TLS version 1.3 (Kubernetes version 1.19 and later):
    - `TLS_AES_128_GCM_SHA256`
    - `TLS_CHACHA20_POLY1305_SHA256`
    - `TLS_AES_256_GCM_SHA384`



## `kubelet`
{: #kubelet}

Review the default settings for the `kubelet` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}



cgroups 
:   `kubelet-cgroups=/podruntime/kubelet`
:   `runtime-cgroups=/podruntime/runtime`

Container logs
:   `container-log-max-size=100Mi`
:   `container-log-max-files=3`

Container runtime endpoint
:   `container-runtime-endpoint=unix:///run/containerd/containerd.sock`

CPU CFS quota
:   `cpu-cfs-quota-period=20ms`

Feature gates
:   See [Feature gates](#feature-gates). In addition, `CRIContainerLogRotation=true` is set.

File check frequency
:   `file-check-frequency=5s`

Graceful Node Shutdown
:   For Kubernetes version 1.21 and later:- `shutdownGracePeriod: 30s`
:   `shutdownGracePeriodCriticalPods: 15s`

Kubernetes and system reserves
:   `kube-reserved='memory=1051Mi,cpu=36m,pid=2048'`
:   `system-reserved='memory=1576Mi,cpu=54m,pid=2048'`

Pod eviction
:   `eviction-soft='memory.available<100Mi,nodefs.available<10%,imagefs.available<10%,nodefs.inodesFree<10%,imagefs.inodesFree<10%'`
:   `eviction-soft-grace-period='memory.available=10m,nodefs.available=10m,imagefs.available=10m,nodefs.inodesFree=10m,imagefs.inodesFree=10m'`
:   `eviction-hard='memory.available<100Mi,nodefs.available<5%,imagefs.available<5%,nodefs.inodesFree<5%,imagefs.inodesFree<5%'`

Pod manifest path
:   `pod-manifest-path=/etc/kubernetes/manifests`

TLS cipher support
:   TLS version =< 1.2 (Kubernetes version 1.19 and earlier):
    - `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`
    - `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`
    - `TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256`
    - `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`
    - `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`
    - `TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256`

:   TLS version 1.3 (Kubernetes version 1.19 and later): 
    - `TLS_AES_128_GCM_SHA256`
    - `TLS_CHACHA20_POLY1305_SHA256`
    - `TLS_AES_256_GCM_SHA384`


## `kube-scheduler`
{: #kube-scheduler}

Review the default settings for the `kube-scheduler` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

TLS cipher support
:   TLS version =< 1.2 (Kubernetes version 1.19 and earlier):
    - `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`
    - `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`
    - `TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256`
    - `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`
    - `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`
    - `TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256`

:   TLS version 1.3 (Kubernetes version 1.19 and later):
    - `TLS_AES_128_GCM_SHA256`
    - `TLS_CHACHA20_POLY1305_SHA256`
    - `TLS_AES_256_GCM_SHA384`


## `kube-proxy`
{: #kube-proxy}

Review the default settings for the `kube-proxy` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

Iptable settings
:   `iptables-sync-period 300s`
:   `iptables-min-sync-period 5s`

Proxy mode
:   `proxy-mode=iptables`

Feature gates
:   See [Feature gates](#feature-gates)




## Feature gates
{: #feature-gates}

Review the feature gates that are applied to all master and worker node components by default in {{site.data.keyword.containerlong_notm}} clusters. These feature gates differ from the ones that are set up in community distributions. In clusters that run version 1.23 or earlier, the {{site.data.keyword.cloud_notm}} provider version enables Kubernetes APIs and features that are at beta. In version 1.24 and later, most new beta features are disabled by default. Kubernetes alpha features, which are subject to change, are disabled in all versions. 
{: shortdesc}





1.25
:   `CustomCPUCFSQuotaPeriod=true`


1.24
:   `CustomCPUCFSQuotaPeriod=true`
:   `LegacyServiceAccountTokenNoAutoGeneration=false`
:   `PodSecurity=false`

1.23
:   `CustomCPUCFSQuotaPeriod=true`
:   `ServiceLBNodePortControl=false`
:   `PodSecurity=false`

1.22
:   `ServiceLBNodePortControl=false`
:   `CustomCPUCFSQuotaPeriod=true`
:   `IPv6DualStack=false`

1.21
:   `ServiceLoadBalancerClass=true`
:   `CustomCPUCFSQuotaPeriod=true`
:   `IPv6DualStack=false`

1.20
:   `AllowInsecureBackendProxy=false`
:   `CustomCPUCFSQuotaPeriod=true`

1.19
:   `RuntimeClass=false`
:   `CustomCPUCFSQuotaPeriod=true`
:   `AllowInsecureBackendProxy=false`
:   `SCTPSupport=false`
:   `ServiceAppProtocol=false`

1.18
:   `RuntimeClass=false`
:   `CustomCPUCFSQuotaPeriod=true`
:   `AllowInsecureBackendProxy=false`





