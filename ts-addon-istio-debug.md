---

copyright:
  years: 2014, 2025
lastupdated: "2025-09-02"


keywords: kubernetes, help, debug istio, troubleshoot istio, istio add-on debug

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}





# Debugging Istio
{: #istio_debug_tool}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

To further troubleshoot the [managed Istio add-on](/docs/containers?topic=containers-istio), consider the following debugging tools.
{: shortdesc}

1. Ensure that your Istio components all run the same version of managed Istio. Whenever the Istio add-on is updated to a new patch or minor version, the Istio control plane is automatically updated, but you must [manually update your data plane components](/docs/containers?topic=containers-istio-update#update_client_sidecar), including the `istioctl` client and the Istio sidecars for your app.

1. Check your Istio configurations by using the `istioctl analyze` CLI command. For more information about the command, including available command options and examples, see the [Istio open-source documentation](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-analyze){: external}.
