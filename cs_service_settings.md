---

copyright:
  years: 2014, 2021
lastupdated: "2021-05-14"

keywords: kubernetes, iks

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:api: .ph data-hd-interface='api'}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vbnet: .ph data-hd-programlang='vb.net'}
{:video: .video}
  
  

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
| Default pod tolerations | <ul><li><code>default-not-ready-toleration-seconds=600s</code></li><li><code>default-unreachable-toleration-seconds=600s</code></li></ul> | 
| Privileged pods | `allow-privileged=true` | 
| Request headers | <ul><li><code>requestheader-client-ca-file=/mnt/etc/kubernetes-cert/ca.pem</code></li><li><code>requestheader-username-headers=X-Remote-User</code></li><li><code>requestheader-group-headers=X-Remote-Group</code></li><li><code>requestheader-extra-headers-prefix=X-Remote-Extra-</code></li></ul> | 
| Number of client requests | <ul><li><code>k8s_max_requests_inflight: 1600</code></li><li><code>k8s_max_mutating_requests_inflight: 800</code></li></ul>|
| Admission controllers | <ul><li><code>NamespaceLifecycle</code></li><li><code>LimitRanger</code></li><li><code>ServiceAccount</code></li><li><code>DefaultStorageClass</code></li><li><code>Initializers</code> (Kubernetes 1.13 or earlier)</li><li><code>MutatingAdmissionWebhook</code></li><li><code>ValidatingAdmissionWebhook</code></li><li><code>ResourceQuota</code></li><li><code>PodSecurityPolicy</code></li><li><code>DefaultTolerationSeconds</code></li><li><code>StorageObjectInUseProtection</code></li><li><code>PersistentVolumeClaimResize</code></li><li><code>Priority</code> (Kubernetes 1.11 or later)</li><li><code>NodeRestriction</code> (Kubernetes 1.14 or later)</li><li><code>TaintNodesByCondition</code> (Kubernetes 1.14 or later)</li><li><code>CertificateApproval</code> (Kubernetes 1.18 or later)</li><li><code>CertificateSigning</code> (Kubernetes 1.18 or later)</li><li><code>CertificateSubjectRestriction</code> (Kubernetes 1.18 or later)</li><li><code>DefaultIngressClass</code> (Kubernetes 1.18 or later)</li><li><code>RuntimeClass</code> (Kubernetes 1.20 or later)</li></ul> |
| Kube audit log config | <ul><li><code>audit-log-maxsize=128</code></li><li><code>audit-log-maxage=2</code></li><li><code>audit-log-maxbackup=2</code></li></ul> | 
| Feature gates | See [Feature gates](#feature-gates) | 
| TLS cipher support | <p><strong>TLS version =< 1.2 (Kubernetes version 1.19 and earlier)</strong>:</p><ul><li><code>TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384</code></li><li><code>TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256</code></li><li><code>TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256</code></li><li><code>TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384</code></li><li><code>TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256</code></li><li><code>TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256</code></li></ul><p><strong>TLS version 1.3 (Kubernetes version 1.19 and later)</strong>:</p><ul><li><code>TLS_AES_128_GCM_SHA256</code></li><li><code>TLS_CHACHA20_POLY1305_SHA256</code></li><li><code>TLS_AES_256_GCM_SHA384</code></li></ul>|
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
| TLS cipher support | <p><strong>TLS version =< 1.2 (Kubernetes version 1.19 and earlier)</strong>:</p><ul><li><code>TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384</code></li><li><code>TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256</code></li><li><code>TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256</code></li><li><code>TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384</code></li><li><code>TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256</code></li><li><code>TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256</code></li></ul><p><strong>TLS version 1.3 (Kubernetes version 1.19 and later)</strong>:</p><ul><li><code>TLS_AES_128_GCM_SHA256</code></li><li><code>TLS_CHACHA20_POLY1305_SHA256</code></li><li><code>TLS_AES_256_GCM_SHA384</code></li></ul>|
{: summary="The rows are read from left to right. The category is in the first column, with the description in the second column."}
{: caption="kube-controller-manager settings" caption-side="top"}


## `kubelet`
{: #kubelet}

Review the default settings for the `kubelet` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}


| Category  | Default settings |
|----------|------|
| Feature gates | See [Feature gates](#feature-gates). In addition, <code>CRIContainerLogRotation=true</code> is set. | 
| Pod manifest path | `pod-manifest-path=/etc/kubernetes/manifests` | 
| File check frequency | `file-check-frequency=5s` |
| Container logs | <ul><li><code>container-log-max-size=100Mi</code></li><li><code>container-log-max-files=3</code></li></ul> |
| Container runtime endpoint | `container-runtime-endpoint=unix:///run/containerd/containerd.sock` | 
| Kubernetes and system reserves | <ul><li><code>kube-reserved='memory=1051Mi,cpu=36m,pid=2048'</code></li><li><code>system-reserved='memory=1576Mi,cpu=54m,pid=2048'</code></li></ul> |
| CPU CFS quota | `cpu-cfs-quota-period=20ms` |
| cgroups | <ul><li><code>kubelet-cgroups=/podruntime/kubelet</code></li><li><code>runtime-cgroups=/podruntime/runtime</code></li></ul> | 
| Pod eviction | <ul><li><code>eviction-soft='memory.available<100Mi,nodefs.available<10%,imagefs.available<10%,nodefs.inodesFree<10%,imagefs.inodesFree<10%'</code></li><li><code>eviction-soft-grace-period='memory.available=10m,nodefs.available=10m,imagefs.available=10m,nodefs.inodesFree=10m,imagefs.inodesFree=10m'</code></li><li><code>eviction-hard='memory.available<100Mi,nodefs.available<5%,imagefs.available<5%,nodefs.inodesFree<5%,imagefs.inodesFree<5%'</code></li></ul> | 
| TLS cipher support | <p><strong>TLS version =< 1.2 (Kubernetes version 1.19 and earlier)</strong>:</p><ul><li><code>TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384</code></li><li><code>TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256</code></li><li><code>TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256</code></li><li><code>TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384</code></li><li><code>TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256</code></li><li><code>TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256</code></li></ul><p><strong>TLS version 1.3 (Kubernetes version 1.19 and later)</strong>:</p><ul><li><code>TLS_AES_128_GCM_SHA256</code></li><li><code>TLS_CHACHA20_POLY1305_SHA256</code></li><li><code>TLS_AES_256_GCM_SHA384</code></li></ul>|
{: summary="The rows are read from left to right. The category is in the first column, with the description in the second column."}
{: caption="kubelet settings" caption-side="top"}

## `kube-scheduler`
{: #kube-scheduler}

Review the default settings for the `kube-scheduler` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

| Category | Default settings |
| -------- | ---------------- |
| TLS cipher support | <p><strong>TLS version =< 1.2 (Kubernetes version 1.19 and earlier)</strong>:</p><ul><li><code>TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384</code></li><li><code>TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256</code></li><li><code>TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256</code></li><li><code>TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384</code></li><li><code>TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256</code></li><li><code>TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256</code></li></ul><p><strong>TLS version 1.3 (Kubernetes version 1.19 and later)</strong>:</p><ul><li><code>TLS_AES_128_GCM_SHA256</code></li><li><code>TLS_CHACHA20_POLY1305_SHA256</code></li><li><code>TLS_AES_256_GCM_SHA384</code></li></ul>|
{: summary="The rows are read from left to right. The category is in the first column, with the description in the second column."}
{: caption="kube-scheduler settings" caption-side="top"}

## `kube-proxy`
{: #kube-proxy}

Review the default settings for the `kube-proxy` worker node component in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

| Category  | Default settings |
|----------|------|
| Iptable settings | <ul><li><code>iptables-sync-period 300s</code></li><li><code>iptables-min-sync-period 5s</code></li></ul> |
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
| 1.20 | <ul><li><code>AllowInsecureBackendProxy=false</code></li><li><code>CustomCPUCFSQuotaPeriod=true</code></li></ul>|
| 1.19 | <ul><li><code>RuntimeClass=false</code></li><li><code>CustomCPUCFSQuotaPeriod=true</code></li><li><code>AllowInsecureBackendProxy=false</code></li><li><code>SCTPSupport=false</code></li><li><code>ServiceAppProtocol=false</code></li></ul>|
| 1.18 | <ul><li><code>RuntimeClass=false</code></li><li><code>CustomCPUCFSQuotaPeriod=true</code></li><li><code>AllowInsecureBackendProxy=false</code></li></ul>|
| 1.17 | <ul><li><code>RuntimeClass=false</code></li><li><code>CustomCPUCFSQuotaPeriod=true</code></li><li><code>AllowInsecureBackendProxy=false</code></li></ul> | 
| 1.16 | <ul><li><code>RuntimeClass=false</code></li><li><code>CustomCPUCFSQuotaPeriod=true</code></li></ul> | 
| 1.15 | <ul><li><code>RuntimeClass=false</code></li><li><code>CustomCPUCFSQuotaPeriod=true</code></li></ul> | 
| 1.14 | <ul><li><code>RuntimeClass=false</code></li><li><code>SupportNodePidsLimit=true</code></li><li><code>CustomCPUCFSQuotaPeriod=true</code></li></ul>|
{: caption="Overview of feature gates" caption-side="top"}
{: summary="The rows are read from left to right. The version is in the first column, with the default feature gates in the second column."}
