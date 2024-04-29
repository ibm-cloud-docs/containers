---

copyright:
 years: 2022, 2024
lastupdated: "2024-04-29"


keywords: kubernetes, ingress, change log, configmap

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Ingress ConfigMap change log
{: #ibm-k8s-controller-config-change-log}

The {{site.data.keyword.containerlong_notm}} `ibm-k8s-controller-config` ConfigMap contains the default configuration for managed application load balancers (ALBs). Occasionally, {{site.data.keyword.containerlong_notm}} adjusts the ConfigMap values as needed. You can find the latest version of the ConfigMap in the `IBM/kube-samples` repo. For more information, see [`ibm-k8s-controller-config.yaml`](https://github.com/IBM-Cloud/kube-samples/blob/master/ingress-config/ibm-k8s-controller-config.yaml).

For more information about ALBs, see [Application Load Balancers](/docs/containers?topic=containers-managed-ingress-about#managed-ingress-albs). For more information about the possible configuration values, see the [nginx-ingress documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/){: external}.

## 29 April 2024
{: #ingress-cm-29-apr-2024}

- Updated the `ssl-ciphers` field to exclude weak ciphers such as [`AES128-GCM-SHA256`](https://ciphersuite.info/cs/TLS_RSA_WITH_AES_128_GCM_SHA256/){: external} and [`AES256-GCM-SHA384`](https://ciphersuite.info/cs/TLS_RSA_WITH_AES_256_GCM_SHA384/){: external} from the accepted cipher list. For more information, see the ConfigMap in the [`kube-samples`](https://github.com/IBM-Cloud/kube-samples/blob/bc63edf226758d1d5e9ef4ad9a120814e0a9124c/ingress-config/ibm-k8s-controller-config.yaml){: external} repo.

## 3 October 2022
{: #ingress-cm-3-oct-2022}

Removed managed contents from the `http-snippet` field. See the ConfigMap in the `IBM-Cloud/kube-samples` [repo](https://github.com/IBM-Cloud/kube-samples/blob/170e36cef314dd18823dfb016b041650126d3672/ingress-config/ibm-k8s-controller-config.yaml){: external}.

## 17 August 2022
{: #ingress-cm-17-aug-2022}

Added the ConfigMap to the `IBM-Cloud/kube-samples` [repo](https://github.com/IBM-Cloud/kube-samples/blob/8f765f825552449746dc2ab1ee7d62ca718119c0/ingress-config/ibm-k8s-controller-config.yaml){: external}.

