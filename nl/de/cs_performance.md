---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Leistung optimieren
{: #kernel}

Wenn Sie bestimmte Voraussetzungen für die Leistungsoptimierung haben, können Sie die Standardeinstellungen für die `sysctl`-Parameter für den Linux-Kernel auf Workerknoten und Pod-Netznamensbereiche in {{site.data.keyword.containerlong}} ändern.
{: shortdesc}

Workerknoten werden automatisch mit optimierter Kerneloptimierung eingerichtet, aber Sie können die Standardeinstellungen ändern, indem Sie ein angepasstes Kubernetes-Objekt des Typs `DaemonSet` auf Ihren Cluster anwenden. Das DaemonSet ändert die Einstellungen für alle vorhandenen Workerknoten und wendet die Einstellungen auf alle neuen Workerknoten an, die im Cluster eingerichtet werden. Es sind keine Pods betroffen.

Um die Kerneleinstellungen für App-Pods zu optimieren, können Sie einen initContainer in die YAML-Datei `pod/ds/rs/deployment` für jede Bereitstellung einfügen. Der initContainer wird jeder App-Bereitstellung hinzugefügt, die sich in dem Pod-Netznamensbereich befindet, für den Sie die Leistung optimieren möchten.

Die Beispiele in den folgenden Abschnitten ändern den Standardwert für die Anzahl Verbindungen, die maximal in der Umgebung zulässig sind, über die Einstellung `net.core.somaxconn` und den Bereich ephemerer Ports über die Einstellung `net.ipv4.ip_local_port_range`.

**Warnung**: Wenn Sie die Kernelparameter-Standardeinstellungen ändern möchten, tun Sie dies auf eigenes Risiko. Sie sind für die Ausführung der erforderlichen Tests für alle geänderten Einstellungen und für eventuelle Unterbrechungen, die durch die geänderten Einstellungen in Ihrer Umgebung verursacht werden, verantwortlich.

## Leistung des Workerknotens optimieren
{: #worker}

Wenden Sie ein [DaemonSet ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) an, um die Kernelparameter auf dem Host des Workerknotens zu ändern.

**Hinweis**: Sie müssen über die [Rolle mit Administratorzugriff](cs_users.html#access_policies) verfügen, um das Beispiel für den berechtigten initContainer ausführen zu können. Nachdem die Container für die Bereitstellungen initialisiert wurden, werden die Berechtigungen gelöscht.

1. Speichern Sie das folgende DaemonSet in einer Datei mit dem Namen `worker-node-kernel-settings.yaml`. Fügen Sie im Abschnitt `spec.template.spec.initContainers` die Felder und Werte für die `sysctl`-Parameter hinzu, die Sie optimieren möchten. In diesem Beispiel für ein DaemonSet werden die Werte der Parameter `net.core.somaxconn` und `net.ipv4.ip_local_port_range` geändert.
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

2. Wenden Sie das DaemonSet auf Ihre Workerknoten an. Die Änderungen werden sofort angewendet.
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

Gehen Sie wie folgt vor, um die `sysctl`-Parameter der Workerknoten auf die Standardwerte zurückzusetzen, die von {{site.data.keyword.containerlong_notm}} festgelegt wurden:

1. Löschen Sie das DaemonSet. Die initContainer, die die angepassten Einstellungen angewendet haben, werden entfernt.
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [Führen Sie für alle Workerknoten im Cluster einen Warmstart durch](cs_cli_reference.html#cs_worker_reboot). Die Workerknoten werden mit den angewendeten Standardwerten wieder gestartet.

<br />


## Podleistung optimieren
{: #pod}

Wenn Sie bestimmte Workloadanforderungen haben, können Sie ein Patch auf den [initContainer ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link") ](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) anwenden, um die Kernelparameter für App-Pods zu ändern.
{: shortdesc}

**Hinweis**: Sie müssen über die [Rolle mit Administratorzugriff](cs_users.html#access_policies) verfügen, um das Beispiel für den berechtigten initContainer ausführen zu können. Nachdem die Container für die Bereitstellungen initialisiert wurden, werden die Berechtigungen gelöscht.

1. Speichern Sie das folgende initContainer-Patch in einer Datei mit dem Namen `pod-patch.yaml` und fügen Sie die Felder und Werte für die `sysctl`-Parameter hinzu, die Sie optimieren möchten. In diesem beispielhaften initContainer werden die Werte der Parameter `net.core.somaxconn` und `net.ipv4.ip_local_port_range` geändert.
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

2. Wenden Sie Patches auf alle Ihre Bereitstellungen an.
    ```
    kubectl patch deployment <name_der_bereitstellung> --patch pod-patch.yaml
    ```
    {: pre}

3. Wenn Sie den Wert für `net.core.somaxconn` in den Kerneleinstellungen geändert haben, können die meisten Apps automatisch den aktualisierten Wert verwenden. Einige Apps erfordern jedoch unter Umständen, dass Sie den entsprechenden Wert in Ihrem App-Code manuell ändern, damit er mit dem Kernelwert übereinstimmt. Wenn Sie beispielsweise die Leistung eines Pods optimieren, in dem eine NGINX-App ausgeführt wird, müssen Sie den Wert des Felds `backlog` im NGINX-App-Code ändern, damit er übereinstimmt. Weitere Informationen finden Sie in diesem [Blogbeitrag zu NGINX![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.nginx.com/blog/tuning-nginx/).
