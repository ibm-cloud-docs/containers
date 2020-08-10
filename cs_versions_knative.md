---

copyright:
  years: 2014, 2020
lastupdated: "2020-08-10"

keywords: kubernetes, iks, knative, add-on, knative changelog

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
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
{:java: #java .ph data-hd-programlang='java'}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
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
{:swift: #swift .ph data-hd-programlang='swift'}
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
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vb.net: .ph data-hd-programlang='vb.net'}
{:video: .video}



# Knative add-on version changelog
{: #knative-changelog}

View information for patch updates to the [managed Knative add-on](/docs/containers?topic=containers-serverless-apps-knative) in your {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}

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
