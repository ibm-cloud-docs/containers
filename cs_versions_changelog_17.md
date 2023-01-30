---

copyright:
  years: 2014, 2023
lastupdated: "2023-01-30"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}






# Version 1.7 changelog (Unsupported)
{: #17_changelog}


Review the version 1.7 changelogs.
{: shortdesc}

## Change log for worker node fix pack 1.7.16_1514, released 11 June 2018
{: #1716_1514}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel update | 4.4.0-116 | 4.4.0-127 | New worker node images with kernel update for [CVE-2018-3639](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639){: external}. |
{: caption="Table 1. Changes since version 1.7.16_1513" caption-side="bottom"}


## Change log for worker node fix pack 1.7.16_1513, released 18 May 2018
{: #1716_1513}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubelet | N/A | N/A | Fix to address a bug that occurred if you used the block storage plug-in. |
{: caption="Table 1. Changes since version 1.7.16_1512" caption-side="bottom"}


## Change log for worker node fix pack 1.7.16_1512, released 16 May 2018
{: #1716_1512}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubelet | N/A | N/A | The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine. |
{: caption="Table 1. Changes since version 1.7.16_1511" caption-side="bottom"}


## Change log for 1.7.16_1511, released 19 April 2018
{: #1716_1511}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.7.4 | v1.7.16 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16]{: external}. This release addresses [CVE-2017-1002101](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101){: external} and [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102){: external} vulnerabilities.   \n Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly. |
| {{site.data.keyword.cloud_notm}} Provider | v1.7.4-133 | v1.7.16-17 | `NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers?topic=containers-loadbalancer#lb_source_ip) by setting `service.spec.externalTrafficPolicy` to `Local`. |
| General | N/A | N/A | Fix [edge node](/docs/containers?topic=containers-edge#edge) toleration setup for older clusters. |
{: caption="Table 1. Changes since version 1.7.4_1509" caption-side="bottom"}
