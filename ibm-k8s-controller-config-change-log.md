---

copyright:
 years: 2022, 2022
lastupdated: "2022-08-16"

keywords: kubernetes, ingress, change log, configmap

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Ingress ConfigMap change log
{: #ibm-k8s-controller-config-change-log}

The {{site.data.keyword.containerlong_notm}} `ibm-k8s-controller-config` ConfigMap contains the default configuration for managed application load balancers (ALBs). Occasionally, {{site.data.keyword.containerlong_notm}} adjusts the ConfigMap values as needed. You can find the latest version of the ConfigMap in the `IBM/kube-samples` repo. For more information, see [`ibm-k8s-controller-config.yaml`](https://github.com/IBM-Cloud/kube-samples/ingress-config/ibm-k8s-controller-config.yaml).

For more information about ALBs, see [About Ingress](/docs/containers?topic=containers-ingress-about). For more information about the possible configuration values, see the [nginx-ingress documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/){: external}.



## 17 August 2022
{: #ingress-cm-17-aug-2022}

Added the ConfigMap to the `IBM/kube-samples` [repo](https://github.com/IBM-Cloud/kube-samples/ingress-config/ibm-k8s-controller-config.yaml).

