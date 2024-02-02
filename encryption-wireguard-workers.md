---

copyright:
  years: 2024, 2024
lastupdated: "2024-02-02"


keywords: kubernetes, help, wireguard, worker encryption

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Encrypting worker-to-worker traffic with WireGuard
{: #encrypt-nodes-wireguard}

[Classic infrastructure]{: tag-classic-inf} [Virtual Private Cloud]{: tag-vpc}

You can encrypt data that flows between worker nodes in your cluster by using WireGuard. 
{: shortdesc}

- Note that this feature only encrypts traffic between worker nodes on the same cluster and does not encrypt traffic between different pods on the same worker node.
- Worker-to-worker encryption with WireGuard is supported on {{site.data.keyword.containershort_notm}} clusters with workers that run [Ubuntu 20 or later](/docs/containers?topic=containers-ubuntu-migrate).
- WireGuard is not supported on workers that have user-installed encryption modules on them. 
- WireGuard is not FIPS or FedRamp compliant.
- You cannot alter the WireGuard configuration after it is enabled. However, you can disable it.

For more information on this configuration setting, see [Enable WireGuard for a cluster](https://docs.tigera.io/calico/3.25/network-policy/encrypt-cluster-pod-traffic#enable-wireguard-for-a-cluster){: external} in the Calico documentation.
{: tip}


## Enabling WireGuard encryption
{: #encrypt-nodes-wireguard-enable}

1. Run the following command to enable WireGuard.

    ```sh
    kubectl patch felixconfiguration default --type='merge' -p '{"spec":{"wireguardEnabled":true}}'
    ```
    {: pre}

    Example output.
    ```sh
    felixconfiguration.crd.projectcalico.org/default patched
    ```
    {: screen}

2. To verify that WireGuard is enabled, view your felixconfiguration. In the output, find the WireGuard section and verify that `wireguardPublicKey` is listed in the status column. 

    ```sh
    kubectl get felixconfiguration default -o yaml
    ```
    {: pre}

    Example output.

    ```sh
    apiVersion: crd.projectcalico.org/v1
    kind: FelixConfiguration
    metadata:
      annotations:
        created-by: IBMCloudKubernetesService
        projectcalico.org/metadata: '{"uid":"8a21b69b-9ffb-451d-9619-0dd1605810dc","creationTimestamp":"2023-09-13T14:00:15Z"}'
      creationTimestamp: "2023-09-13T14:00:15Z"
      generation: 2
      name: default
      resourceVersion: "24839234"
      uid: ff0c79f3-5548-4db4-a22f-2f367282631d
    spec:
      bpfLogLevel: ""
      floatingIPs: Disabled
      logSeverityScreen: Info
      natPortRange: 32768:65535
      reportingInterval: 0s
      wireguardEnabled: true
    ```
    {: screen}

## Disabling WireGuard encryption
{: #encrypt-nodes-wireguard-disable}

If you no longer need worker-to-worker encryption in your cluster, you can disable WireGuard.

1. Run the following command to disable WireGuard.

    ```sh
    kubectl patch felixconfiguration default --type='merge' -p '{"spec":{"wireguardEnabled":false}}' --allow-version-mismatch
    ```
    {: pre}

    Example output
    ```sh
    felixconfiguration.crd.projectcalico.org/default patched
    ```
    {: screen}

1. Verify WireGuard is disabled.
    ```sh
    kubectl get felixconfiguration default -o yaml
    ```
    {: pre}

    Example output
    ```sh
    apiVersion: crd.projectcalico.org/v1
    kind: FelixConfiguration
    metadata:
      annotations:
        created-by: IBMCloudKubernetesService
        projectcalico.org/metadata: '{"uid":"8a21b69b-9ffb-451d-9619-0dd1605810dc","creationTimestamp":"2023-09-13T14:00:15Z"}'
      creationTimestamp: "2023-09-13T14:00:15Z"
      generation: 3
      name: default
      resourceVersion: "24839453"
      uid: ff0c79f3-5548-4db4-a22f-2f367282631d
    spec:
      bpfLogLevel: ""
      floatingIPs: Disabled
      logSeverityScreen: Info
      natPortRange: 32768:65535
      reportingInterval: 0s
      wireguardEnabled: false
    ```
    {: screen}

