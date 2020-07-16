---

copyright:
  years: 2014, 2020
lastupdated: "2020-07-16"

keywords: kubernetes, iks, knative, add-on, knative changelog

subcollection: containers

---

{:beta: .beta}
{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}



# Knative add-on version changelog
{: #knative-changelog}

View information for patch updates to the [managed Knative add-on](/docs/containers?topic=containers-serverless-apps-knative) in your {{site.data.keyword.containerlong_notm}} clusters.
{:shortdesc}

## Changelog for 0.15.1, released 08 July 2020
{: #0151}

The following table shows the changes that are included in version 0.15.1 of the managed Knative add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 0.14.0 | 0.15.1 | <ul><li>See the [Knative release notes for version 0.14.0](/docs/containers?topic=containers-cs_versions#release-history){:external}.</li><li>In version 0.15.1 of the Knative managed add-on, you must use [Istio version 1.16](/docs/containers?topic=containers-istio).</li></ul> |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Knative 0.15.1" caption-side="top"}

## Changelog for 0.14.0, released 20 May 2020
{: #0140}

The following table shows the changes that are included in version 0.14.0 of the managed Knative add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 0.12.1 | 0.14.0| <ul><li>See the Knative release notes for version 0.14.0 of the [`eventing`](https://github.com/knative/eventing/releases/tag/v0.14.0){: external}, [`serving`](https://github.com/knative/serving/releases/tag/v0.14.0){: external}, and [`event-contrib`](https://github.com/knative/eventing-contrib/releases/tag/v0.14.0){: external} components.</li><li>In version 0.14.0 of the Knative managed add-on, you must use Istio version 1.15 or later.</li></ul> |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Knative 0.14.0" caption-side="top"}

## Changelog for 0.12.1, released 10 February 2020
{: #0121}

The following table shows the changes that are included in version 0.12.1 of the managed Knative add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 0.8.0 | 0.12.1 | <ul><li>[See the Knative release notes for version 0.12.1](https://github.com/knative/serving/releases/tag/v0.12.1){: external}.</li><li>Istio version 1.4 is now installed with the add-on. You cannot use the Knative add-on with Istio 1.3. If you have Istio 1.3 and want to use the managed Knative add-on, you must [uninstall Istio 1.3](/docs/containers?topic=containers-istio#istio_uninstall).</li><li>The Knative add-on can be enabled in clusters that run Kubernetes version 1.16 or later only.</li><li>`Knative-monitoring` was removed. To continue collecting app logs, see [Choosing a logging solution](/docs/containers?topic=containers-health#logging_overview).</li></ul> |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Knative 0.12.1" caption-side="top"}
