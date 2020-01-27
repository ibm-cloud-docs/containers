---

copyright:
  years: 2014, 2020
lastupdated: "2020-01-27"

keywords: kubernetes, iks, logging, help, debug

subcollection: containers

---

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


# Troubleshooting logging and monitoring
{: #cs_troubleshoot_health}

As you use {{site.data.keyword.containerlong}}, consider these techniques for troubleshooting issues with logging and monitoring.
{: shortdesc}

If you have a more general issue, try out [cluster debugging](/docs/containers?topic=containers-cs_troubleshoot).
{: tip}

## Kubernetes dashboard does not display utilization graphs
{: #cs_dashboard_graphs}

{: tsSymptoms}
When you access the Kubernetes dashboard, utilization graphs do not display.

{: tsCauses}
Sometimes after a cluster update or worker node reboot, the `kube-dashboard` pod does not update.

{: tsResolve}
Delete the `kube-dashboard` pod to force a restart. The pod is re-created with RBAC policies to access `heapster` for utilization information.

  ```
  kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
  ```
  {: pre}

<br />


## Log lines are too long
{: #long_lines}

{: tsSymptoms}
You set up a logging configuration in your cluster to forward logs to an external syslog server. When you view logs, you see a long log message. Additionally, in Kibana, you might be able to see only the last 600 - 700 characters of the log message.

{: tsCauses}
A long log message might be truncated due to its length before it is collected by Fluentd, so the log might not be parsed correctly by Fluentd before it is forwarded to your syslog server.

{: tsResolve}
To limit line length, you can configure your own logger to have a maximum length for the `stack_trace` in each log. For example, if you are using Log4j for your logger, you can use an [`EnhancedPatternLayout`](http://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/EnhancedPatternLayout.html){: external} to limit the `stack_trace` to 15KB.

## Getting help and support
{: #health_getting_help}

Still having issues with your cluster?
{: shortdesc}

-  In the terminal, you are notified when updates to the `ibmcloud` CLI and plug-ins are available. Be sure to keep your CLI up-to-date so that you can use all available commands and flags.
-   To see whether {{site.data.keyword.cloud_notm}} is available, [check the {{site.data.keyword.cloud_notm}} status page](https://cloud.ibm.com/status?selected=status){: external}.
-   Post a question in the [{{site.data.keyword.containerlong_notm}} Slack](https://ibm-container-service.slack.com){: external}.<p class="tip">If you are not using an IBM ID for your {{site.data.keyword.cloud_notm}} account, [request an invitation](https://cloud.ibm.com/kubernetes/slack) to this Slack.</p>
-   Review the forums to see whether other users ran into the same issue. When you use the forums to ask a question, tag your question so that it is seen by the {{site.data.keyword.cloud_notm}} development teams.
    -   If you have technical questions about developing or deploying clusters or apps with {{site.data.keyword.containerlong_notm}}, post your question on [Stack Overflow](https://stackoverflow.com/questions/tagged/ibm-cloud+containers){: external} and tag your question with `ibm-cloud`, `kubernetes`, and `containers`.
    -   For questions about the service and getting started instructions, use the [IBM Developer Answers](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix){: external} forum. Include the `ibm-cloud` and `containers` tags.
    See [Getting help](/docs/get-support?topic=get-support-getting-customer-support#using-avatar) for more details about using the forums.
-   Contact IBM Support by opening a case. To learn about opening an IBM support case, or about support levels and case severities, see [Contacting support](/docs/get-support?topic=get-support-getting-customer-support).<p class="tip">When you report an issue, include your cluster ID. To get your cluster ID, run `ibmcloud ks cluster ls`. You can also use the [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) to gather and export pertinent information from your cluster to share with IBM Support.</p>

