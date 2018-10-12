---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Tuning performance
{: #kernel}

If you have specific performance optimization requirements, you can change the default settings for the Linux kernel `sysctl` parameters on worker nodes and pod network namespaces in {{site.data.keyword.containerlong}}.
{: shortdesc}

Worker nodes are automatically provisioned with optimized kernel performance, but you can change the default settings by applying a custom Kubernetes `DaemonSet` object to your cluster. The daemonset alters the settings for all existing worker nodes and applies the settings to any new worker nodes that are provisioned in the cluster. No pods are affected.

To optimize kernel settings for app pods, you can insert an initContainer into the `pod/ds/rs/deployment` YAML for each deployment. The initContainer is added to each app deployment that is in the pod network namespace for which you want to optimize performance.

For example, the samples in the following sections change the default maximum number of connections allowed in the environment via the `net.core.somaxconn` setting and the ephemeral port range via the `net.ipv4.ip_local_port_range` setting.

**Warning**: If you choose to change the default kernel parameter settings, you are doing so at your own risk. You are responsible for running tests against any changed settings and for any potential disruptions caused by the changed settings in your environment.

## Optimizing worker node performance
{: #worker}

Apply a [daemonset ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) to change kernel parameters on the worker node host.

**Note**: You must have the [Administrator access role](cs_users.html#access_policies) to run the sample privileged initContainer. After the containers for the deployments are initialized, the privileges are dropped.

1. Save the following daemonset in a file named `worker-node-kernel-settings.yaml`. In the `spec.template.spec.initContainers` section, add the fields and values for the `sysctl` parameters that you want to tune. This example daemonset changes the values of the `net.core.somaxconn` and `net.ipv4.ip_local_port_range` parameters.
    ```
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    metadata:
      name: kernel-optimization
      namespace: kube-system
      labels:
        tier: management
        app: kernel-optimization
    spec:
      template:
        metadata:
          labels:
            name: kernel-optimization
        spec:
          hostNetwork: true
          hostPID: true
          hostIPC: true
          initContainers:
            - command:
                - sh
                - -c
                - sysctl -w net.ipv4.ip_local_port_range="1025 65535"; sysctl -w net.core.somaxconn=32768;
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
                capabilities:
                  add:
                    - NET_ADMIN
              volumeMounts:
                - name: modifysys
                  mountPath: /sys
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                    sleep 100000;
                  done
          volumes:
            - name: modifysys
              hostPath:
                path: /sys
    ```
    {: codeblock}

2. Apply the daemonset to your worker nodes. The changes are applied immediately.
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

To revert your worker nodes' `sysctl` parameters to the default values set by {{site.data.keyword.containerlong_notm}}:

1. Delete the daemonset. The initContainers that applied the custom settings are removed.
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [Reboot all worker nodes in the cluster](cs_cli_reference.html#cs_worker_reboot). The worker nodes come back online with the default values applied.

<br />


## Optimizing pod performance
{: #pod}

If you have specific workload demands, you can apply an [initContainer ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) patch to change kernel parameters for app pods.
{: shortdesc}

**Note**: You must have the [Administrator access role](cs_users.html#access_policies) to run the sample privileged initContainer. After the containers for the deployments are initialized, the privileges are dropped.

1. Save the following initContainer patch in a file named `pod-patch.yaml` and add the fields and values for the `sysctl` parameters that you want to tune. This example initContainer changes the values of the `net.core.somaxconn` and `net.ipv4.ip_local_port_range` parameters.
    ```
    spec:
      template:
        spec:
          initContainers:
          - command:
            - sh
            - -c
            - sysctl -e -w net.core.somaxconn=32768;  sysctl -e -w net.ipv4.ip_local_port_range="1025 65535";
            image: alpine:3.6
            imagePullPolicy: IfNotPresent
            name: sysctl
            resources: {}
            securityContext:
              privileged: true
    ```
    {: codeblock}

2. Patch each of your deployments.
    ```
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. If you changed the `net.core.somaxconn` value in the kernel settings, most apps can automatically use the updated value. However, some apps might require you to manually change the corresponding value in your app code to match the kernel value. For example, if you're tuning the performance of a pod where an NGINX app is running, you must change the value of the `backlog` field in the NGINX app code to match. For more information, see this [NGINX blog post ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nginx.com/blog/tuning-nginx/).
