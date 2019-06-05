---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}

# クラスター DNS プロバイダーの構成
{: #cluster_dns}

{{site.data.keyword.containerlong}} クラスター内の各サービスには、DNS 要求を解決するためにクラスターの DNS プロバイダーが登録するドメイン・ネーム・システム (DNS) 名が割り当てられます。 クラスターの Kubernetes バージョンに応じて、Kubernetes DNS (KubeDNS) と [CoreDNS ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://coredns.io/) のどちらかを選択できます。 サービスおよびポッドの DNS について詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/) を参照してください。
{: shortdesc}

**各 Kubernetes バージョンがサポートするクラスター DNS プロバイダー**<br>

| Kubernetes バージョン | 新規クラスターのデフォルト | 説明 |
|---|---|---|
| 1.13 以降 | CoreDNS | 以前のバージョンから 1.13 に更新されたクラスターは、更新時に使用していた DNS プロバイダーをそのまま使用します。 別のプロバイダーを使用するには、[DNS プロバイダーを切り替え](#dns_set)ます。 |
| 1.12 | KubeDNS | 代わりに CoreDNS を使用するには、[DNS プロバイダーを切り替え](#set_coredns)ます。 |
| 1.11 以前 | KubeDNS | DNS プロバイダーを CoreDNS に切り替えることはできません。 |
{: caption="Kubernetes バージョン別のデフォルトのクラスター DNS プロバイダー" caption-side="top"}

## クラスター DNS プロバイダーの自動スケーリング
{: #dns_autoscale}

デフォルトでは、{{site.data.keyword.containerlong_notm}} のクラスター DNS プロバイダーには、クラスター内のワーカー・ノードとコアの数に応じて DNS ポッドを自動スケーリングするためのデプロイメントが含まれています。 DNS 自動スケーリング機能のパラメーターを微調整するには、DNS 自動スケーリング機能の構成マップを編集します。 例えば、アプリでクラスター DNS プロバイダーを頻繁に使用している場合は、アプリをサポートするために DNS ポッドの最小数を増やす必要があります。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) を参照してください。
{: shortdesc}

開始前に、以下のことを行います。 [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1.  クラスター DNS プロバイダーのデプロイメントが使用可能であることを確認します。 クラスターには、KubeDNS、CoreDNS、または両方の DNS プロバイダーの自動スケーリング機能がインストールされている可能性があります。 両方の DNS の自動スケーリング機能がインストールされている場合は、CLI 出力の **AVAILABLE** 列を調べて、どちらが使用中であるか確認します。 使用中のデプロイメントは、使用可能なデプロイメントが 1 と表示されます。
    ```
    kubectl get deployment -n kube-system | grep dns-autoscaler
    ```
    {: pre}
    
    出力例:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler     0         0         0            0           32d
    kube-dns-autoscaler    1         1         1            1           260d
    ```
    {: screen}
2.  DNS 自動スケーリング機能のパラメーターの構成マップの名前を取得します。
    ```
    kubectl get configmap -n kube-system
    ```
    {: pre}    
3.  DNS 自動スケーリング機能のデフォルト設定を編集します。 `data.linear` フィールドを探します。デフォルトでは、クラスターのサイズに関係なく、DNS ポッド数はワーカー・ノード 16 台につき 1 つ、またはコア 256 個につき 1 つ、最小数は 2 (`preventSinglePointFailure: true`) に設定されます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters) を参照してください。
    ```
    kubectl edit configmap -n kube-system <dns-autoscaler>
    ```
    {: pre}
    
    出力例:
    ```
    apiVersion: v1
    data:
      linear: '{"coresPerReplica":256,"nodesPerReplica":16,"preventSinglePointFailure":true}'
    kind: ConfigMap
    metadata:
    ...
    ```
    {: screen}

## クラスター DNS プロバイダーのカスタマイズ
{: #dns_customize}

{{site.data.keyword.containerlong_notm}} のクラスター DNS プロバイダーをカスタマイズするには、DNS の構成マップを編集します。 例えば、外部ホストを指すサービスを解決するようにスタブドメインとアップストリーム・ネーム・サーバーを構成することができます。 さらに、CoreDNS を使用している場合は、CoreDNS 構成マップ内に複数の [Corefile ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://coredns.io/2017/07/23/corefile-explained/) を構成できます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を参照してください。
{: shortdesc}

開始前に、以下のことを行います。 [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1.  クラスター DNS プロバイダーのデプロイメントが使用可能であることを確認します。 KubeDNS、CoreDNS、または両方の DNS プロバイダー用の DNS クラスター・プロバイダーがクラスターにインストールされている可能性があります。 両方の DNS プロバイダーがインストールされている場合は、CLI 出力の **AVAILABLE** 列を調べて、どちらが使用中であるか確認します。 使用中のデプロイメントは、使用可能なデプロイメントが 1 と表示されます。
    ```
    kubectl get deployment -n kube-system -l k8s-app=kube-dns
    ```
    {: pre}
    
    出力例:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns                0         0         0            0           89d
    kube-dns-amd64         2         2         2            2           89d
    ```
    {: screen}
2.  CoreDNS または KubeDNS 構成マップのデフォルト設定を編集します。
    
    *   **CoreDNS の場合**: スタブドメインとアップストリーム・ネーム・サーバーをカスタマイズするには、構成マップの `data` セクションで Corefile を使用します。 詳しくは、[Kubernetes 資料　![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns) 参照してください。
        ```
        kubectl edit configmap -n kube-system coredns
        ```
        {: pre}
    
        **CoreDNS の出力例**: 
          ```
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: coredns
            namespace: kube-system
          data:
            Corefile: |
              abc.com:53 {
                  errors
                  cache 30
                  proxy . 1.2.3.4
              }
              .:53 {
                  errors
            health
            kubernetes cluster.local in-addr.arpa ip6.arpa {
                     pods insecure
                     upstream 172.16.0.1
                     fallthrough in-addr.arpa ip6.arpa
                  }
                  prometheus :9153
                  proxy . /etc/resolv.conf
                  cache 30
                  loop
                  reload
                  loadbalance
              }
          ```
          {: screen}
          
          編成したいカスタマイズがたくさんありますか? Kubernetes バージョン 1.12.6_1543 以降では、CoreDNS の構成マップに複数の Corefile を追加できます。 詳しくは、[Corefile のインポートに関する資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://coredns.io/plugins/import/) を参照してください。
          {: tip}
          
    *   **KubeDNS の場合**: 構成マップの `data` セクションにスタブドメインとアップストリーム・ネーム・サーバーを構成します。 詳しくは、[Kubernetes 資料　![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns) 参照してください。
        ```
        kubectl edit configmap -n kube-system kube-dns
        ```
        {: pre}

        **KubeDNS の出力例**:
        ```
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: kube-dns
          namespace: kube-system
        data:
          stubDomains: |
          {"abc.com": ["1.2.3.4"]}
        ```
        {: screen}

## クラスターの DNS プロバイダーを CoreDNS または KubeDNS に設定する
{: #dns_set}

{{site.data.keyword.containerlong_notm}} クラスターで Kubernetes バージョン 1.12 以降を実行する場合は、クラスター DNS プロバイダーとして Kubernetes DNS (KubeDNS) と CoreDNS のどちらを使用するかを選択できます。
{: shortdesc}

**始める前に**:
1.  [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。
2.  現在のクラスターの DNS プロバイダーを調べます。 次の例では、KubeDNS が現在のクラスターの DNS プロバイダーです。
    ```
    kubectl cluster-info
    ```
    {: pre}

    出力例:
    ```
    ...
    KubeDNS is running at https://c2.us-south.containers.cloud.ibm.com:20190/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    ...
    ```
    {: screen}
3.  クラスターで使用している DNS プロバイダーに応じて、DNS プロバイダーを切り替える次の手順に従います。
    *  [CoreDNS を使用するように切り替える](#set_coredns)。
    *  [KubeDNS を使用するように切り替える](#set_kubedns)。

### CoreDNS をクラスター DNS プロバイダーとしてセットアップする
{: #set_coredns}

クラスター DNS プロバイダーとして KubeDNS ではなく CoreDNS をセットアップします。
{: shortdesc}

1.  KubeDNS プロバイダーの構成マップまたは KubeDNS 自動スケーリング機能の構成マップをカスタマイズした場合は、それらのカスタマイズ内容をすべて CoreDNS の構成マップに移します。
    *   `kube-system` 名前空間の `kube-dns` 構成マップについては、すべての [DNS カスタマイズ内容 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を `kube-system` 名前空間の `coredns` 構成マップに移します。 `kube-dns` 構成マップと `coredns` 構成マップは構文が異なることに注意してください。 例については、[Kubernetes 資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns) を参照してください。
    *   `kube-system` 名前空間の `kube-dns-autoscaler` 構成マップについては、すべての [DNS 自動スケーリング機能のカスタマイズ内容 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) を `kube-system` 名前空間の `coredns-autoscaler` 構成マップに移します。 カスタマイズの構文は同じです。
2.  KubeDNS autoscaler デプロイメントをスケールダウンします。
    ```
    kubectl scale deployment -n kube-system --replicas=0 kube-dns-autoscaler
    ```
    {: pre}
3.  ポッドが削除されるまで、確認しながら待機します。
    ```
    kubectl get pods -n kube-system -l k8s-app=kube-dns-autoscaler
    ```
    {: pre}
4.  KubeDNS デプロイメントをスケールダウンします。
    ```
    kubectl scale deployment -n kube-system --replicas=0 kube-dns-amd64
    ```
    {: pre}
5.  CoreDNS autoscaler デプロイメントをスケールアップします。
    ```
    kubectl scale deployment -n kube-system --replicas=1 coredns-autoscaler
    ```
    {: pre}
6.  CoreDNS のクラスター DNS サービスにラベルとアノテーションを付けます。
    ```
    kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=CoreDNS
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port=9153
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape=true
    ```
    {: pre}
7.  **オプション**: Prometheus を使用して CoreDNS ポッドからメトリックを収集する予定の場合は、切り替え元の `kube-dns` サービスにメトリック・ポートを追加する必要があります。
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"metrics","port":9153,"protocol":"TCP"}]}}' --type strategic
    ```
    {: pre}



### KubeDNS をクラスター DNS プロバイダーとしてセットアップする
{: #set_kubedns}

クラスター DNS プロバイダーとして CoreDNS ではなく KubeDNS をセットアップします。
{: shortdesc}

1.  CoreDNS プロバイダーの構成マップまたは CoreDNS 自動スケーリング機能の構成マップをカスタマイズした場合は、それらのカスタマイズ内容をすべて KubeDNS の構成マップに転送します。
    *   `kube-system` 名前空間の `coredns` 構成マップについては、すべての [DNS カスタマイズ内容 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を `kube-system` 名前空間の `kube-dns` 構成マップに移します。 `kube-dns` 構成マップと `coredns` 構成マップは構文が異なることに注意してください。 例については、[Kubernetes 資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns) を参照してください。
    *   `kube-system` 名前空間の `coredns-autoscaler` 構成マップについては、すべての [DNS 自動スケーリング機能のカスタマイズ内容 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) を `kube-system` 名前空間の `kube-dns-autoscaler` 構成マップに移します。 カスタマイズの構文は同じです。
2.  CoreDNS autoscaler デプロイメントをスケールダウンします。
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns-autoscaler
    ```
    {: pre}
3.  ポッドが削除されるまで、確認しながら待機します。
    ```
    kubectl get pods -n kube-system -l k8s-app=coredns-autoscaler
    ```
    {: pre}
4.  CoreDNS デプロイメントをスケールダウンします。
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns
    ```
    {: pre}
5.  KubeDNS autoscaler デプロイメントをスケールアップします。
    ```
    kubectl scale deployment -n kube-system --replicas=1 kube-dns-autoscaler
    ```
    {: pre}
6.  KubeDNS のクラスター DNS サービスにラベルとアノテーションを付けます。
    ```
    kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=KubeDNS
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port-
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape-
    ```
    {: pre}
7.  **オプション**: Prometheus を使用して CoreDNS ポッドからメトリックを収集していた場合は、`kube-dns` サービスにメトリック・ポートが作成されています。 しかし、KubeDNS にはこのメトリック・ポートを含める必要がないため、サービスからポートを削除できます。
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"dns","port":53,"protocol":"UDP"},{"name":"dns-tcp","port":53,"protocol":"TCP"}]}}' --type merge
    ```
    {: pre}
