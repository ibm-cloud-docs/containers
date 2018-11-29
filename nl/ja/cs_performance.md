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

# パフォーマンスのチューニング
{: #kernel}

特定のパフォーマンス最適化要件がある場合は、{{site.data.keyword.containerlong}} のワーカー・ノードおよびポッドのネットワーク名前空間で、Linux カーネルの `sysctl` パラメーターのデフォルト設定を変更できます。
{: shortdesc}

ワーカー・ノードには、最適化されたカーネル・パフォーマンスが自動的にプロビジョンされますが、Kubernetes のカスタム `DaemonSet` オブジェクトをクラスターに適用することによってデフォルト設定を変更できます。デーモン・セットは、既存のすべてのワーカー・ノードの設定を変更し、クラスター内でプロビジョンされている新規ワーカー・ノードに設定を適用します。ポッドは影響を受けません。

アプリ・ポッドのカーネル設定を最適化するには、各デプロイメントの `pod/ds/rs/deployment` YAML に initContainer を挿入することができます。 パフォーマンスを最適化するポッドのネットワーク名前空間内にある各アプリ・デプロイメントに initContainer が追加されます。

例えば、以下のセクションのサンプルは、`net.core.somaxconn` 設定により環境内で許可されているか、または `net.ipv4.ip_local_port_range` 設定により一時ポート範囲内で許可されているデフォルトの最大接続数を変更します。

**警告**: デフォルトのカーネル・パラメーター設定を変更する場合は、お客様自身の責任で行ってください。 変更された設定に対してテストを実行すること、および環境内の設定変更が原因で発生する可能性がある障害についてはお客様が責任を持ちます。

## ワーカー・ノードのパフォーマンスの最適化
{: #worker}

[デーモン・セット ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を適用して、ワーカー・ノード・ホスト上のカーネル・パラメーターを変更します。

**注**: サンプルの特権 initContainer を実行するには、[管理者アクセス役割](cs_users.html#access_policies)が必要です。 デプロイメントのコンテナーが初期化された後、特権は除去されます。

1. 以下のデーモン・セットを `worker-node-kernel-settings.yaml` という名前のファイルに保存します。`spec.template.spec.initContainers` セクションで、調整する `sysctl` パラメーターのフィールドと値を追加します。 このサンプル・デーモン・セットでは、`net.core.somaxconn` および `net.ipv4.ip_local_port_range` パラメーターの値を変更します。
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

2. ワーカー・ノードにデーモン・セットを適用します。この変更はすぐに適用されます。
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

ワーカー・ノードの `sysctl` パラメーターを {{site.data.keyword.containerlong_notm}} によって設定されたデフォルト値に戻すには、以下のようにします。

1. デーモン・セットを削除します。カスタム設定を適用した initContainers が削除されます。
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [クラスター内のすべてのワーカー・ノードをリブートします](cs_cli_reference.html#cs_worker_reboot)。 ワーカー・ノードは、デフォルト値が適用された状態でオンラインに戻ります。

<br />


## ポッドのパフォーマンスの最適化
{: #pod}

特定のワークロード需要がある場合は、[initContainer ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) パッチを適用して、アプリ・ポッドのカーネル・パラメーターを変更できます。
{: shortdesc}

**注**: サンプルの特権 initContainer を実行するには、[管理者アクセス役割](cs_users.html#access_policies)が必要です。 デプロイメントのコンテナーが初期化された後、特権は除去されます。

1. 以下の initContainer パッチを `pod-patch.yaml` という名前のファイルに保存し、調整する `sysctl` パラメーターのフィールドと値を追加します。 このサンプル initContainer では、`net.core.somaxconn` および `net.ipv4.ip_local_port_range` パラメーターの値を変更します。
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

2. 各デプロイメントにパッチを適用します。
    ```
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. カーネル設定の `net.core.somaxconn` 値を変更した場合、ほとんどのアプリが、更新された値を自動的に使用します。 ただし、一部のアプリでは、カーネル値に一致するように、アプリ・コードの対応する値を手動で変更する必要がある場合があります。 例えば、NGINX アプリが実行されているポッドのパフォーマンスを調整する場合、NGINX アプリ・コードの `backlog` フィールドの値を一致するように変更する必要があります。 詳しくは、[NGINX に関するブログ投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.nginx.com/blog/tuning-nginx/) を参照してください。
