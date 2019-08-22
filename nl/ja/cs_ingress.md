---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

subcollection: containers

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
{:preview: .preview}



# Ingress のセットアップ
{: #ingress}

{{site.data.keyword.containerlong}} で、IBM 提供のアプリケーション・ロード・バランサーで管理される Ingress リソースを作成して、Kubernetes クラスター内の複数のアプリを公開します。
{:shortdesc}

## サンプル YAML
{: #sample_ingress}

素早く Ingress リソースの指定を始めるには、以下のサンプル YAML ファイルを使用してください。
{: shortdesc}

**アプリをパブリックに公開するための Ingress リソース**</br>

以下の作業は完了しましたか?
- アプリのデプロイ
- アプリ・サービスの作成
- ドメイン名と TLS シークレットの選択

以下のデプロイメント YAML を使用して Ingress リソースを作成できます。

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingressresource
spec:
  tls:
  - hosts:
    - <domain>
    secretName: <tls_secret_name>
  rules:
  - host: <domain>
    http:
      paths:
      - path: /<app1_path>
        backend:
          serviceName: <app1_service>
          servicePort: 80
      - path: /<app2_path>
        backend:
          serviceName: <app2_service>
          servicePort: 80
```
{: codeblock}

</br>

**アプリをプライベートに公開するための Ingress リソース**</br>

以下の作業は完了しましたか?
- プライベート ALB の有効化
- アプリのデプロイ
- アプリ・サービスの作成
- カスタム・ドメイン名と TLS シークレットの登録

以下のデプロイメント YAML を使用して Ingress リソースを作成できます。

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingressresource
  annotations:
    ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
spec:
  tls:
  - hosts:
    - <domain>
    secretName: <tls_secret_name>
  rules:
  - host: <domain>
    http:
      paths:
      - path: /<app1_path>
        backend:
          serviceName: <app1_service>
          servicePort: 80
      - path: /<app2_path>
        backend:
          serviceName: <app2_service>
          servicePort: 80
```
{: codeblock}

<br />


## 前提条件
{: #config_prereqs}

Ingress の使用を開始する前に、以下の前提条件を確認してください。
{:shortdesc}

**すべての Ingress 構成の前提条件:**
- Ingress は標準クラスターでのみ使用可能です。高可用性を確保して定期的に更新を適用するために、ゾーンごとにワーカー・ノードが 2 つ以上必要です。 1 つのゾーンにワーカーが 1 つしか存在しない場合は、ALB が自動更新を受け取れません。 自動更新が ALB ポッドにロールアウトされると、そのポッドは再ロードされます。 しかし、高可用性のために、ALB には各ワーカー・ノードに 1 つしかポッドをスケジュールしないようにするアンチアフィニティー・ルールが設定されます。 1 つのワーカーには ALB ポッドが 1 つしか存在しないので、トラフィックが中断されないようにするために、そのポッドは再始動されません。 ALB ポッドが最新バージョンに更新されるのは、古いポッドを手動で削除することによって、新しい更新後のポッドがスケジュール可能になった場合のみです。
- Ingress をセットアップするには、以下の [{{site.data.keyword.cloud_notm}} IAM 役割](/docs/containers?topic=containers-users#platform)が必要です。
    - クラスターに対する**管理者**のプラットフォーム役割
    - すべての名前空間に対する**管理者**のサービス役割

**複数ゾーン・クラスターで Ingress を使用するための前提条件**:
 - ネットワーク・トラフィックを[エッジ・ワーカー・ノード](/docs/containers?topic=containers-edge)に制限する場合、Ingress ポッドの高可用性を確保するために、少なくとも 2 つのエッジ・ワーカー・ノードを各ゾーンで有効にする必要があります。 クラスター内のすべてのゾーンにまたがり、ゾーンごとにワーカー・ノードを 2 つ以上持つ[エッジ・ワーカー・ノード・プールを作成します](/docs/containers?topic=containers-add_workers#add_pool)。
 - 1 つのクラスターに複数の VLAN がある場合、同じ VLAN 上に複数のサブネットがある場合、または複数ゾーン・クラスターがある場合は、IBM Cloud インフラストラクチャー・アカウントに対して[仮想ルーター機能 (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにする必要があります。 VRF を有効にするには、[IBM Cloud インフラストラクチャーのアカウント担当者に連絡してください](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion)。 VRF が既に有効になっているかどうかを確認するには、`ibmcloud account show` コマンドを使用します。 VRF の有効化が不可能または不要な場合は、[VLAN スパンニング](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)を有効にしてください。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](/docs/containers?topic=containers-users#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get<region>` [コマンド](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get)を使用します。
 - ゾーンで障害が発生した場合、そのゾーンの Ingress ALB への要求で断続的に障害が発生する可能性があります。

<br />


## 1 つの名前空間を使用する場合と複数の名前空間を使用する場合のネットワーキングの計画
{: #multiple_namespaces}

公開するアプリを入れる名前空間ごとに 1 つの Ingress リソースが必要です。
{:shortdesc}

### 1 つの名前空間にすべてのアプリを入れる場合
{: #one-ns}

クラスター内のすべてのアプリを同じ名前空間に入れる場合は、そこで公開するアプリのルーティング・ルールを定義するために 1 つの Ingress リソースが必要になります。 例えば、開発用の名前空間にあるサービスで `app1` と `app2` を公開する場合は、その名前空間で 1 つの Ingress リソースを作成できます。 そのリソースで、`domain.net` をホストとして指定し、各アプリが `domain.net` で listen するパスを登録します。
{: shortdesc}

<img src="images/cs_ingress_single_ns.png" width="270" alt="名前空間ごとに 1 つのリソースが必要です。" style="width:270px; border-style: none"/>

### 複数の名前空間にアプリを入れる場合
{: #multi-ns}

クラスター内のアプリを別々の名前空間に入れる場合は、そこで公開するアプリのルールを定義するために、名前空間ごとに 1 つのリソースを作成する必要があります。
{: shortdesc}

ただし、1 つのホスト名を定義できるのは 1 つのリソースだけです。 複数のリソースで同じホスト名を定義することはできません。 複数の Ingress リソースを同じホスト名で登録する場合は、ワイルドカード・ドメインを使用する必要があります。 ワイルドカード・ドメイン (`*.domain.net` など) を登録すると、複数のサブドメインがすべて同じホストに解決されます。 そうすれば、各名前空間で Ingress リソースを作成し、各 Ingress リソースで別々のサブドメインを指定できます。

例えば、以下のシナリオがあるとします。
* テスト用の同じアプリに `app1` と `app3` という 2 つのバージョンがあります。
* それらのアプリを同じクラスター内の 2 つの別々の名前空間にデプロイします (`app1` を開発用名前空間に、`app3` をステージング用名前空間にデプロイします)。

同じクラスター ALB を使用してそれらのアプリへのトラフィックを管理するには、以下のサービスとリソースを作成します。
* `app1` を公開する開発用名前空間の Kubernetes サービス。
* ホストを `dev.domain.net` として指定する、開発用名前空間内の Ingress リソース。
* `app3` を公開するステージング用名前空間の Kubernetes サービス。
* ホストを `stage.domain.net` として指定する、ステージング用名前空間内の Ingress リソース。
</br>
<img src="images/cs_ingress_multi_ns.png" width="625" alt="名前空間内の 1 つ以上のリソースでサブドメインを使用する" style="width:625px; border-style: none"/>


これで、両方の URL が同じドメインに解決され、同じ ALB のサービスを受けるようになります。 しかし、ステージング用名前空間のリソースは `stage` サブドメインに登録されるので、Ingress ALB は、`stage.domain.net/app3` URL からの要求を `app3` だけに正しくルーティングします。

{: #wildcard_tls}
デフォルトでは、クラスターに対し、IBM 提供の Ingress サブドメイン・ワイルドカード `*.<cluster_name>.<region>.containers.appdomain.cloud` が登録されます。 IBM 提供の TLS 証明書はワイルドカード証明書ですので、ワイルドカード・サブドメインに使用できます。 カスタム・ドメインを使用する場合は、カスタム・ドメインを `*.custom_domain.net` などのワイルドカード・ドメインとして登録する必要があります。 TLS を使用するには、ワイルドカード証明書を取得する必要があります。
{: note}

### 1 つの名前空間の中で複数のドメインを使用する場合
{: #multi-domains}

それぞれの名前空間では、1 つのドメインを使用して、その名前空間内のすべてのアプリにアクセスできます。 1 つの名前空間の中でアプリのために複数のドメインを使用する場合は、ワイルドカード・ドメインを使用します。 ワイルドカード・ドメイン (`*.mycluster.us-south.containers.appdomain.cloud` など) を登録すると、すべてのサブドメインが同じホストに解決されます。 そうすれば、1 つのリソースを使用し、そのリソースの中で複数のサブドメイン・ホストを指定することができます。 あるいは別の方法として、その名前空間で複数の Ingress リソースを作成し、各 Ingress リソースで別々のサブドメインを指定することも可能です。
{: shortdesc}

<img src="images/cs_ingress_single_ns_multi_subs.png" width="625" alt="名前空間ごとに 1 つのリソースが必要です。" style="width:625px; border-style: none"/>

デフォルトでは、クラスターに対し、IBM 提供の Ingress サブドメイン・ワイルドカード `*.<cluster_name>.<region>.containers.appdomain.cloud` が登録されます。 IBM 提供の TLS 証明書はワイルドカード証明書ですので、ワイルドカード・サブドメインに使用できます。 カスタム・ドメインを使用する場合は、カスタム・ドメインを `*.custom_domain.net` などのワイルドカード・ドメインとして登録する必要があります。 TLS を使用するには、ワイルドカード証明書を取得する必要があります。
{: note}

<br />


## クラスター内のアプリをパブリックに公開する
{: #ingress_expose_public}

パブリック Ingress ALB を使用して、クラスター内のアプリをパブリックに公開します。
{:shortdesc}

開始前に、以下のことを行います。

* Ingress の[前提条件](#config_prereqs)を確認します。
* [アカウントにログインします。 該当する場合は、適切なリソース・グループをターゲットにします。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

### ステップ 1: アプリをデプロイしてアプリ・サービスを作成する
{: #public_inside_1}

まず、アプリをデプロイし、それらを公開するための Kubernetes サービスを作成します。
{: shortdesc}

1.  [アプリをクラスターにデプロイします](/docs/containers?topic=containers-app#app_cli)。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります (例えば、`app: code`)。 このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。

2.   公開するアプリごとに Kubernetes サービスを作成します。 アプリをクラスター ALB の Ingress ロード・バランシングに含めるには、Kubernetes サービスを介してアプリを公開する必要があります。
      1.  任意のエディターを開き、`myappservice.yaml` などの名前のサービス構成ファイルを作成します。
      2.  ALB で公開するアプリのサービスを定義します。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
         port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> ALB サービス YAML ファイルの構成要素について</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>) のペアを入力します。 ポッドをターゲットにして、それらをサービスのロード・バランシングに組み込む場合は、<em>&lt;selector_key&gt;</em> と <em>&lt;selector_value&gt;</em> を、デプロイメント YAML の <code>spec.template.metadata.labels</code> セクションにあるキー/値のペアと同じになるようにしてください。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>サービスが listen するポート。</td>
           </tr>
           </tbody></table>
      3.  変更を保存します。
      4.  クラスター内にサービスを作成します。 クラスター内の複数の名前空間にアプリをデプロイする場合は、公開するアプリと同じ名前空間にサービスをデプロイするようにしてください。

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  公開するアプリごとに、上記のステップを繰り返します。


### ステップ 2: アプリ・ドメインを選択する
{: #public_inside_2}

パブリック ALB を構成する場合は、アプリにアクセスするためのドメインを選択します。
{: shortdesc}

IBM 提供のドメイン (`mycluster-12345.us-south.containers.appdomain.cloud/myapp` など) を使用して、インターネットからアプリにアクセスできます。 代わりにカスタム・ドメインを使用するには、カスタム・ドメインを IBM 提供のドメインにマップする CNAME レコードをセットアップするか、または ALB のパブリック IP アドレスを使用して DNS プロバイダーに A レコードをセットアップします。

**IBM 提供の Ingress ドメインを使用する場合:**

IBM 提供のドメインを取得します。 `<cluster_name_or_ID>` を、アプリがデプロイされているクラスターの名前に置き換えます。
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

出力例:
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
    Ingress Secret:         <tls_secret>
```
{: screen}

**カスタム・ドメインを使用する場合:**
1.    カスタム・ドメインを作成します。 カスタム・ドメインを登録する時には、Domain Name Service (DNS) プロバイダーまたは [{{site.data.keyword.cloud_notm}} DNS](/docs/infrastructure/dns?topic=dns-getting-started) を使用してください。
      * Ingress で公開するアプリが 1 つのクラスター内の別々の名前空間にある場合は、カスタム・ドメインをワイルドカード・ドメイン (`*.custom_domain.net` など) として登録します。

2.  着信ネットワーク・トラフィックを IBM 提供の ALB にルーティングするようにドメインを構成します。 以下の選択肢があります。
    -   IBM 提供ドメインを正規名レコード (CNAME) として指定することで、カスタム・ドメインの別名を定義します。 IBM 提供の Ingress ドメインを確認するには、`ibmcloud ks cluster-get --cluster <cluster_name>` を実行し、**「Ingress サブドメイン (Ingress subdomain)」**フィールドを見つけます。 IBM では IBM サブドメインに対する自動ヘルス・チェックを提供しており、障害のある IP がすべて DNS 応答から削除されるため、CNAME の使用をお勧めします。
    -   カスタム・ドメインを IBM 提供の ALB のポータブル・パブリック IP アドレスにマップします。これは、IP アドレスを A レコードとして追加して行います。ALB のポータブル・パブリック IP アドレスを見つけるには、`ibmcloud ks alb-get --albID<public_alb_ID>` を実行します。

### ステップ 3: TLS 終端を選択する
{: #public_inside_3}

アプリ・ドメインを選択した後に、TLS 終端を使用するかどうかを選択します。
{: shortdesc}

ALB は、HTTP ネットワーク・トラフィックをクラスター内のアプリに振り分けてロード・バランシングを行います。 着信 HTTPS 接続のロード・バランシングも行う場合は ALB でその機能を構成できます。つまり、ネットワーク・トラフィックを復号し、復号した要求をクラスター内で公開されているアプリに転送するように構成します。

* IBM 提供の Ingress サブドメインを使用する場合は、IBM 提供の TLS 証明書を使用できます。 IBM 提供の TLS 証明書は、LetsEncrypt によって署名され、IBM によって完全に管理されます。 証明書の有効期間は 90 日で、有効期限が切れる 37 日前に自動的に更新されます。 ワイルドカードの TLS 証明書について詳しくは、[この注記](#wildcard_tls)を参照してください。
* カスタム・ドメインを使用する場合は、独自の TLS 証明書を使用して TLS 終端を管理できます。 ALB はまず、アプリが入っている名前空間にシークレットがあるかどうかをチェックし、次に `default`、最後に `ibm-cert-store` をチェックします。 1 つの名前空間にのみアプリがある場合は、その同じ名前空間に、証明書に対する TLS シークレットをインポートまたは作成できます。 複数の名前空間にアプリがある場合は、どの名前空間でも ALB が証明書にアクセスして使用できるように、`default` 名前空間の証明書に対して TLS シークレットをインポートまたは作成します。 名前空間ごとに定義する Ingress リソースに、デフォルトの名前空間にあるシークレットの名前を指定してください。 ワイルドカードの TLS 証明書について詳しくは、[この注記](#wildcard_tls)を参照してください。 **注**: 事前共有鍵 (TLS-PSK) を含む TLS 証明書はサポートされていません。

**IBM 提供の Ingress ドメインを使用する場合:**

クラスター用に IBM 提供の TLS シークレットを取得します。
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

出力例:
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
    Ingress Secret:         <tls_secret>
```
{: screen}
</br>

**カスタム・ドメインを使用する場合:**

使用する TLS 証明書が {{site.data.keyword.cloudcerts_long_notm}} に保管されている場合は、それに関連付けられたシークレットを、以下のコマンドを実行してクラスター内にインポートできます。

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

IBM 提供の Ingress シークレットと同じ名前のシークレットは作成しないでください。 IBM 提供の Ingress シークレットの名前を確認するには、`ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress` を実行します。
{: note}

このコマンドを使用して証明書をインポートすると、`ibm-cert-store` という名前空間に証明書シークレットが作成されます。 それから、このシークレットへの参照が `default` 名前空間に作成されます。これには、どの名前空間内の、どの Ingress リソースでもアクセスできます。 ALB は、要求を処理するとき、この参照に従って `ibm-cert-store` 名前空間から証明書シークレットを選出して使用します。

</br>

TLS 証明書の準備ができていない場合は、以下の手順に従ってください。
1. 証明書プロバイダーから認証局 (CA) の証明書と鍵を生成します。 独自のドメインがある場合は、ご使用のドメインの正式な TLS 証明書を購入してください。 証明書ごとに異なる [CN ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://support.dnsimple.com/articles/what-is-common-name/) を使用してください。
2. 証明書と鍵を base-64 に変換します。
   1. 証明書と鍵を base-64 にエンコードし、base-64 エンコード値を新しいファイルに保存します。
      ```
      openssl base64 -in tls.key -out tls.key.base64
      ```
      {: pre}

   2. 証明書と鍵の base-64 エンコード値を表示します。
      ```
      cat tls.key.base64
      ```
      {: pre}

3. 証明書と鍵を使用して、シークレット YAML ファイルを作成します。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. 証明書を Kubernetes シークレットとして作成します。
     ```
     kubectl apply -f ssl-my-test
     ```
     {: pre}
     IBM 提供の Ingress シークレットと同じ名前のシークレットは作成しないでください。 IBM 提供の Ingress シークレットの名前を確認するには、`ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress` を実行します。
     {: note}


### ステップ 4: Ingress リソースを作成する
{: #public_inside_4}

Ingress リソースは、ALB がトラフィックをアプリ・サービスにルーティングするために使用するルーティング・ルールを定義します。
{: shortdesc}

クラスター内の複数の名前空間でアプリを公開する場合は、名前空間ごとに 1 つの Ingress リソースが必要になります。 ただし、各名前空間で別々のホストを使用する必要があります。 ワイルドカード・ドメインを登録し、各リソースで別々のサブドメインを指定しなければなりません。 詳しくは、[1 つの名前空間を使用する場合と複数の名前空間を使用する場合のネットワーキングの計画](#multiple_namespaces)を参照してください。
{: note}

1. 任意のエディターを開き、`myingressresource.yaml` などの名前の Ingress 構成ファイルを作成します。

2. IBM 提供のドメインまたはカスタム・ドメインを使用して着信ネットワーク・トラフィックを作成済みサービスにルーティングする Ingress リソースを構成ファイル内に定義します。

    TLS を使用しない YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    TLS を使用する YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls.hosts</code></td>
    <td>TLS を使用する場合は、<em>&lt;domain&gt;</em> を IBM 提供の Ingress サブドメインかカスタム・ドメインに置き換えます。

    </br></br>
    <strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` や `subdomain1.mycluster.us-south.containers.appdomain.cloud` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </tr>
    <tr>
    <td><code>tls.secretName</code></td>
    <td><ul><li>IBM 提供の Ingress ドメインを使用する場合は、<em>&lt;tls_secret_name&gt;</em> を IBM 提供の Ingress シークレットの名前に置き換えます。</li><li>カスタム・ドメインを使用する場合は、<em>&lt;tls_secret_name&gt;</em> を、カスタム TLS 証明書と鍵を保持するために作成しておいたシークレットに置き換えます。 {{site.data.keyword.cloudcerts_short}} から証明書をインポートする場合、<code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> を実行して、TLS 証明書に関連付けられたシークレットを確認できます。</li><ul><td>
    </tr>
    <tr>
    <td><code>host</code></td>
    <td><em>&lt;domain&gt;</em> を IBM 提供の Ingress サブドメインかカスタム・ドメインに置き換えます。

    </br></br>
    <strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` や `subdomain1.mycluster.us-south.containers.appdomain.cloud` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td><em>&lt;app_path&gt;</em> をスラッシュに置き換えるか、アプリが listen するパスに置き換えます。 IBM 提供のドメインまたはカスタム・ドメインにパスが追加され、アプリへの固有の経路が作成されます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが ALB にルーティングされます。 ALB は、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信します。 そして、サービスが、アプリを実行しているポッドにトラフィックを転送します。
    </br></br>
    多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。 例: <ul><li><code>http://domain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://domain/app1_path</code> の場合、<code>/app1_path</code> をパスとして入力します。</li></ul>
    </br>
    <strong>ヒント:</strong> アプリが listen するパスとは異なるパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](/docs/containers?topic=containers-ingress_annotation#rewrite-path)を使用できます。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td><em>&lt;app1_service&gt;</em> や <em>&lt;app2_service&gt;</em> などを、アプリを公開するために作成しておいたサービスの名前に置き換えます。 クラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、同じ名前空間にあるアプリ・サービスだけを組み込んでください。 公開するアプリを入れる名前空間ごとに 1 つの Ingress リソースを作成する必要があります。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
    </tr>
    </tbody></table>

3.  クラスターの Ingress リソースを作成します。 リソースで指定したアプリ・サービスと同じ名前空間にリソースがデプロイされていることを確認します。

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Ingress リソースが正常に作成されたことを確認します。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. イベント内のメッセージにリソース構成のエラーが示された場合は、リソース・ファイル内の値を変更して、リソースのファイルを再適用してください。


Ingress リソースがアプリ・サービスと同じ名前空間に作成されます。 その名前空間内のアプリがクラスターの Ingress ALB に登録されます。

### ステップ 5: インターネットからアプリにアクセスする
{: #public_inside_5}

Web ブラウザーに、アクセスするアプリ・サービスの URL を入力します。
{: shortdesc}

```
https://<domain>/<app1_path>
```
{: codeblock}

複数のアプリを公開した場合は、URL に追加するパスを変更して、それぞれのアプリにアクセスしてください。

```
https://<domain>/<app2_path>
```
{: codeblock}

ワイルドカード・ドメインを使用して複数の名前空間のアプリを公開した場合は、それぞれのサブドメインを使用して各アプリにアクセスしてください。

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


Ingress を介したアプリへの接続に問題が発生していますか? [Ingress のデバッグ](/docs/containers?topic=containers-cs_troubleshoot_debug_ingress)をお試しください。
{: tip}

<br />


## クラスター外のアプリをパブリックに公開する
{: #external_endpoint}

クラスター外にあるアプリをパブリック Ingress ALB のロード・バランシングに組み込んでパブリックに公開します。 IBM 提供のドメインまたはカスタム・ドメインに着信したパブリック要求が自動的にその外部アプリに転送されます。
{: shortdesc}

開始前に、以下のことを行います。

* Ingress の[前提条件](#config_prereqs)を確認します。
* クラスター・ロード・バランシングに含めようとしている外部アプリに、パブリック IP アドレスを使用してアクセスできることを確認します。
* [アカウントにログインします。 該当する場合は、適切なリソース・グループをターゲットにします。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

クラスター外のアプリをパブリックに公開するには、以下のようにします。

1.  作成する外部エンドポイントに着信要求を転送する Kubernetes サービスをクラスターに作成します。
    1.  任意のエディターを開き、`myexternalservice.yaml` などの名前のサービス構成ファイルを作成します。
    2.  ALB で公開するアプリのサービスを定義します。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myexternalservice
        spec:
          ports:
           - protocol: TCP
         port: 8080
        ```
        {: codeblock}

        <table>
        <caption>ALB サービス・ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata.name</code></td>
        <td><em><code>&lt;myexternalservice&gt;</code></em> をサービスの名前に置き換えます。<p>Kubernetes リソースを処理する際の[個人情報の保護](/docs/containers?topic=containers-security#pi)の詳細を確認してください。</p></td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>サービスが listen するポート。</td>
        </tr></tbody></table>

    3.  変更を保存します。
    4.  クラスターの Kubernetes サービスを作成します。

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}
2.  クラスター・ロード・バランシングに含める外部のアプリの場所を定義する、Kubernetes エンドポイントを構成します。
    1.  任意のエディターを開き、`myexternalendpoint.yaml` などの名前のエンドポイント構成ファイルを作成します。
    2.  外部エンドポイントを定義します。 外部アプリにアクセスするために使用可能な、すべてのパブリック IP アドレスとポートを含めます。

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalservice
        subsets:
          - addresses:
              - ip: <external_IP1>
              - ip: <external_IP2>
            ports:
              - port: <external_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em><code>&lt;myexternalendpoint&gt;</code></em> を、先ほど作成した Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td><em>&lt;external_IP&gt;</em> を、外部アプリに接続するためのパブリック IP アドレスに置き換えます。</td>
         </tr>
         <td><code>port</code></td>
         <td><em>&lt;external_port&gt;</em> を、外部アプリが listen するポートに置き換えます。</td>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスターの Kubernetes エンドポイントを作成します。

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

3. 『クラスター内のアプリをパブリックに公開する』の手順の『[ステップ 2: アプリ・ドメインを選択する](#public_inside_2)』に進みます。

<br />


## プライベート・ネットワークにアプリを公開する
{: #ingress_expose_private}

プライベート Ingress ALB を使用して、アプリをプライベート・ネットワークに公開します。
{:shortdesc}

プライベート ALB を使用するには、まずプライベート ALB を有効にしなければなりません。 プライベート VLAN だけのクラスターには IBM 提供の Ingress サブドメインが割り当てられないので、クラスターのセットアップ時に Ingress シークレットが作成されません。 プライベート・ネットワークにアプリを公開するには、ALB をカスタム・サブドメインに登録する必要があります。その後、独自の TLS 証明書をインポートすることも可能です。

開始前に、以下のことを行います。
* Ingress の[前提条件](#config_prereqs)を確認します。
* ワーカー・ノードを[パブリック VLAN とプライベート VLAN](/docs/containers?topic=containers-cs_network_planning#private_both_vlans)、または[プライベート VLAN のみ](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan)に接続した状況でアプリへのプライベート・アクセスを計画するためのオプションを確認します。
    * ワーカー・ノードがプライベート VLAN にのみ接続されている場合は、[プライベート・ネットワーク上で使用可能な DNS サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を構成する必要があります。

### ステップ 1: アプリをデプロイしてアプリ・サービスを作成する
{: #private_1}

まず、アプリをデプロイし、それらを公開するための Kubernetes サービスを作成します。
{: shortdesc}

1.  [アプリをクラスターにデプロイします](/docs/containers?topic=containers-app#app_cli)。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります (例えば、`app: code`)。 このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。

2.   公開するアプリごとに Kubernetes サービスを作成します。 アプリをクラスター ALB の Ingress ロード・バランシングに含めるには、Kubernetes サービスを介してアプリを公開する必要があります。
      1.  任意のエディターを開き、`myappservice.yaml` などの名前のサービス構成ファイルを作成します。
      2.  ALB で公開するアプリのサービスを定義します。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
         port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> ALB サービス YAML ファイルの構成要素について</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>) のペアを入力します。 ポッドをターゲットにして、それらをサービスのロード・バランシングに組み込む場合は、<em>&lt;selector_key&gt;</em> と <em>&lt;selector_value&gt;</em> を、デプロイメント YAML の <code>spec.template.metadata.labels</code> セクションにあるキー/値のペアと同じになるようにしてください。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>サービスが listen するポート。</td>
           </tr>
           </tbody></table>
      3.  変更を保存します。
      4.  クラスター内にサービスを作成します。 クラスター内の複数の名前空間にアプリをデプロイする場合は、公開するアプリと同じ名前空間にサービスをデプロイするようにしてください。

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  公開するアプリごとに、上記のステップを繰り返します。


### ステップ 2: デフォルトのプライベート ALB を有効にする
{: #private_ingress}

標準クラスターを作成した場合は、ワーカー・ノードが存在する各ゾーンに IBM 提供のプライベート・アプリケーション・ロード・バランサー (ALB) が作成され、ポータブル・プライベート IP アドレスとプライベート経路を割り当てられます。 ただし、各ゾーンのデフォルトのプライベート ALB は自動的には有効になりません。 デフォルトのプライベート ALB でプライベート・ネットワーク・トラフィックをアプリに振り分けてロード・バランシングを行うには、まず IBM 提供のポータブル・プライベート IP アドレスを使用するか、独自のポータブル・プライベート IP アドレスを使用して、プライベート ALB を有効にする必要があります。
{:shortdesc}

クラスターを作成したときに `--no-subnet` フラグを使用した場合、プライベート ALB を有効にするには、その前にポータブル・プライベート・サブネットまたはユーザー管理サブネットを追加する必要があります。 詳しくは、[クラスターのその他のサブネットの要求](/docs/containers?topic=containers-subnets#request)を参照してください。
{: note}

**IBM 提供の事前割り当てポータブル・プライベート IP アドレスを使用してデフォルトのプライベート ALB を有効にするには、以下のようにします。**

1. 有効にするデフォルトのプライベート ALB の ID を取得します。 <em>&lt;cluster_name&gt;</em> を、公開するアプリがデプロイされているクラスターの名前に置き換えます。

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    プライベート ALB の**「Status」**フィールドは「_disabled_」になっています。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.xx.xxx.xxx  dal10   ingress:411/ingress-auth:315   2234945
    ```
    {: screen}
    複数ゾーン・クラスターでは、ALB ID の接尾部の番号は、ALB が追加された順序を示しています。
    * 例えば、ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` の接尾部 `-alb1` は、それが最初に作成されたデフォルトのプライベート ALB であることを示しています。 これは、クラスターを作成したゾーンに存在します。 前の例では、クラスターは `dal10` に作成されました。
    * ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` の接尾部 `-alb2` は、それが 2 番目に作成されたデフォルトのプライベート ALB であることを示しています。 これは、クラスターに追加した 2 番目のゾーンに存在します。 前の例では、2 番目のゾーンは `dal12` です。

2. プライベート ALB を有効にします。 <em>&lt;private_ALB_ID&gt;</em> を、前のステップの出力にあるプライベート ALB の ID に置き換えます。

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}

3. **複数ゾーン・クラスター**: 高可用性を実現するために、各ゾーンでプライベート ALB に対して前のステップを繰り返します。

<br>
**独自のポータブル・プライベート IP アドレスを使用してプライベート ALB を有効にするには、以下のようにします。**

1. クラスターで使用可能な ALB をリストします。プライベート ALB の ID と、ALB が属するゾーンをメモします。

 ```
 ibmcloud ks albs --cluster <cluster_name>
 ```
 {: pre}

 プライベート ALB の**「Status」**フィールドは_「disabled」_になっています。
 ```
 ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.xx.xxx.xxx  dal10   ingress:411/ingress-auth:315   2234945
 ```
 {: screen}

 2. そのゾーンのプライベート VLAN 上でトラフィックをルーティングするように、選択した IP アドレスのユーザー管理サブネットを構成します。

   ```
   ibmcloud ks cluster-user-subnet-add --cluster <cluster_name> --subnet-cidr <subnet_CIDR> --private-vlan <private_VLAN>
   ```
   {: pre}

   <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> コマンドの構成要素について</th>
   </thead>
   <tbody>
   <tr>
   <td><code>&lt;cluster_name&gt;</code></td>
   <td>公開するアプリのデプロイ先のクラスターの名前または ID。</td>
   </tr>
   <tr>
   <td><code>&lt;subnet_CIDR&gt;</code></td>
   <td>ユーザー管理サブネットの CIDR。</td>
   </tr>
   <tr>
   <td><code>&lt;private_VLAN_ID&gt;</code></td>
   <td>プライベート VLAN の ID。 この値は必須です。 これは、プライベート ALB と同じゾーン内のプライベート VLAN 用の ID でなければなりません。ワーカー・ノードが存在するこのゾーンのプライベート VLAN を表示するには、`ibmcloud ks workers -cluster <cluster_name_or_ID>` を実行し、このゾーン内のワーカー・ノードの ID をメモします。ワーカー・ノード ID を使用して、`ibmcloud ks worker-get --worker <worker_id> --cluster <cluster_name_or_id>`を実行します。出力にある**プライベート VLAN** の ID をメモします。</td>
   </tr>
   </tbody></table>

3. プライベート ALB を有効にします。 <em>&lt;private_ALB_ID&gt;</em> を、プライベート ALB の ID に置き換えます。<em>&lt;user_IP&gt;</em> を、使用するユーザー管理サブネットからの IP アドレスに置き換えます。
   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

4. **複数ゾーン・クラスター**: 高可用性を実現するために、各ゾーンでプライベート ALB に対して前のステップを繰り返します。

### ステップ 3: カスタム・ドメインをマップする
{: #private_3}

プライベート VLAN だけのクラスターには IBM 提供の Ingress サブドメインが割り当てられません。 プライベート ALB を構成する場合は、カスタム・ドメインを使用してアプリを公開してください。
{: shortdesc}

**プライベート VLAN だけのクラスター:**

1. ワーカー・ノードがプライベート VLAN だけに接続されている場合は、[プライベート・ネットワークで使用できる独自の DNS サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を構成する必要があります。
2. DNS プロバイダー経由でカスタム・ドメインを作成します。 1 つのクラスター内の複数の名前空間にあるアプリを Ingress で公開する場合は、カスタム・ドメインをワイルドカード・ドメイン (*.custom_domain.net など) として登録します。
3. プライベート DNS サービスを使用して、ALB のポータブル・プライベート IP アドレスを A レコードとして追加して、カスタム・ドメインを IP アドレスにマップします。 ALB のポータブル・プライベート IP アドレスを見つけるには、ALB ごとに `ibmcloud ks alb-get --albID <private_alb_ID>` を実行します。

**プライベートとパブリックの VLAN を使用するクラスター:**

1.    カスタム・ドメインを作成します。 カスタム・ドメインを登録する時には、Domain Name Service (DNS) プロバイダーまたは [{{site.data.keyword.cloud_notm}} DNS](/docs/infrastructure/dns?topic=dns-getting-started) を使用してください。
      * Ingress で公開するアプリが 1 つのクラスター内の別々の名前空間にある場合は、カスタム・ドメインをワイルドカード・ドメイン (`*.custom_domain.net` など) として登録します。

2.  ALB のポータブル・プライベート IP アドレスを A レコードとして追加して、カスタム・ドメインを IP アドレスにマップします。 ALB のポータブル・プライベート IP アドレスを見つけるには、ALB ごとに `ibmcloud ks alb-get --albID <private_alb_ID>` を実行します。

### ステップ 4: TLS 終端を選択する
{: #private_4}

カスタム・ドメインをマップした後に、TLS 終端を使用するかどうかを選択します。
{: shortdesc}

ALB は、HTTP ネットワーク・トラフィックをクラスター内のアプリに振り分けてロード・バランシングを行います。 着信 HTTPS 接続のロード・バランシングも行う場合は ALB でその機能を構成できます。つまり、ネットワーク・トラフィックを復号し、復号した要求をクラスター内で公開されているアプリに転送するように構成します。

プライベート VLAN だけのクラスターには IBM 提供の Ingress ドメインが割り当てられないので、クラスターのセットアップ時に Ingress シークレットが作成されません。 独自の TLS 証明書を使用して TLS 終端を管理できます。  ALB はまず、アプリが入っている名前空間にシークレットがあるかどうかをチェックし、次に `default`、最後に `ibm-cert-store` をチェックします。 1 つの名前空間にのみアプリがある場合は、その同じ名前空間に、証明書に対する TLS シークレットをインポートまたは作成できます。 複数の名前空間にアプリがある場合は、どの名前空間でも ALB が証明書にアクセスして使用できるように、`default` 名前空間の証明書に対して TLS シークレットをインポートまたは作成します。 名前空間ごとに定義する Ingress リソースに、デフォルトの名前空間にあるシークレットの名前を指定してください。 ワイルドカードの TLS 証明書について詳しくは、[この注記](#wildcard_tls)を参照してください。 **注**: 事前共有鍵 (TLS-PSK) を含む TLS 証明書はサポートされていません。

使用する TLS 証明書が {{site.data.keyword.cloudcerts_long_notm}} に保管されている場合は、それに関連付けられたシークレットを、以下のコマンドを実行してクラスター内にインポートできます。

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

このコマンドを使用して証明書をインポートすると、`ibm-cert-store` という名前空間に証明書シークレットが作成されます。 それから、このシークレットへの参照が `default` 名前空間に作成されます。これには、どの名前空間内の、どの Ingress リソースでもアクセスできます。 ALB は、要求を処理するとき、この参照に従って `ibm-cert-store` 名前空間から証明書シークレットを選出して使用します。

### ステップ 5: Ingress リソースを作成する
{: #private_5}

Ingress リソースは、ALB がトラフィックをアプリ・サービスにルーティングするために使用するルーティング・ルールを定義します。
{: shortdesc}

クラスター内の複数の名前空間でアプリを公開する場合は、名前空間ごとに 1 つの Ingress リソースが必要になります。 ただし、各名前空間で別々のホストを使用する必要があります。 ワイルドカード・ドメインを登録し、各リソースで別々のサブドメインを指定しなければなりません。 詳しくは、[1 つの名前空間を使用する場合と複数の名前空間を使用する場合のネットワーキングの計画](#multiple_namespaces)を参照してください。
{: note}

1. 任意のエディターを開き、`myingressresource.yaml` などの名前の Ingress 構成ファイルを作成します。

2.  カスタム・ドメインを使用して着信ネットワーク・トラフィックを作成済みのサービスにルーティングするように、Ingress リソースを構成ファイル内に定義します。

    TLS を使用しない YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    TLS を使用する YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td><em>&lt;private_ALB_ID&gt;</em> を、プライベート ALB の ID に置き換えます。 複数ゾーン・クラスターを使用していて、複数のプライベート ALB を有効にしている場合は、各 ALB の ID を指定してください。 ALB ID を見つけるには、<code>ibmcloud ks albs --cluster <my_cluster></code> を実行します。 この Ingress アノテーションについて詳しくは、[プライベート・アプリケーションのロード・バランサーのルーティング](/docs/containers?topic=containers-ingress_annotation#alb-id)を参照してください。</td>
    </tr>
    <tr>
    <td><code>tls.hosts</code></td>
    <td>TLS を使用する場合は、<em>&lt;domain&gt;</em> をカスタム・ドメインに置き換えます。</br></br><strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </tr>
    <tr>
    <td><code>tls.secretName</code></td>
    <td><em>&lt;tls_secret_name&gt;</em> を、先ほど作成した、カスタム TLS 証明書と鍵を保持するシークレットの名前に置き換えます。 {{site.data.keyword.cloudcerts_short}} から証明書をインポートする場合、<code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> を実行して、TLS 証明書に関連付けられたシークレットを確認できます。
    </tr>
    <tr>
    <td><code>host</code></td>
    <td><em>&lt;domain&gt;</em> をカスタム・ドメインに置き換えます。
    </br></br>
    <strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td><em>&lt;app_path&gt;</em> をスラッシュに置き換えるか、アプリが listen するパスに置き換えます。 カスタム・ドメインにパスが追加され、アプリへの固有の経路が作成されます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが ALB にルーティングされます。 ALB は、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信します。 そして、サービスが、アプリを実行しているポッドにトラフィックを転送します。
    </br></br>
    多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。 例: <ul><li><code>http://domain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://domain/app1_path</code> の場合、<code>/app1_path</code> をパスとして入力します。</li></ul>
    </br>
    <strong>ヒント:</strong> アプリが listen するパスとは異なるパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](/docs/containers?topic=containers-ingress_annotation#rewrite-path)を使用できます。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td><em>&lt;app1_service&gt;</em> や <em>&lt;app2_service&gt;</em> などを、アプリを公開するために作成しておいたサービスの名前に置き換えます。 クラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、同じ名前空間にあるアプリ・サービスだけを組み込んでください。 公開するアプリを入れる名前空間ごとに 1 つの Ingress リソースを作成する必要があります。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
    </tr>
    </tbody></table>

3.  クラスターの Ingress リソースを作成します。 リソースで指定したアプリ・サービスと同じ名前空間にリソースがデプロイされていることを確認します。

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Ingress リソースが正常に作成されたことを確認します。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. イベント内のメッセージにリソース構成のエラーが示された場合は、リソース・ファイル内の値を変更して、リソースのファイルを再適用してください。


Ingress リソースがアプリ・サービスと同じ名前空間に作成されます。 その名前空間内のアプリがクラスターの Ingress ALB に登録されます。

### ステップ 6: プライベート・ネットワークからアプリにアクセスする
{: #private_6}

1. アプリにアクセスする前に、DNS サービスにアクセスできることを確認してください。
  * パブリック VLAN とプライベート VLAN: デフォルトの外部 DNS プロバイダーを使用するには、[パブリック・アクセス用のエッジ・ノードを構成](/docs/containers?topic=containers-edge#edge)し、[仮想ルーター・アプライアンスを構成 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) する必要があります。
  * プライベート VLAN のみ: [プライベート・ネットワークで使用可能な DNS サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を構成する必要があります。

2. プライベート・ネットワーク・ファイアウォール内で、Web ブラウザーにアプリ・サービスの URL を入力します。

```
https://<domain>/<app1_path>
```
{: codeblock}

複数のアプリを公開した場合は、URL に追加するパスを変更して、それぞれのアプリにアクセスしてください。

```
https://<domain>/<app2_path>
```
{: codeblock}

ワイルドカード・ドメインを使用して複数の名前空間のアプリを公開した場合は、それぞれのサブドメインを使用して各アプリにアクセスしてください。

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


プライベート ALB と TLS を使用してクラスター全体でマイクロサービス間通信を保護する方法を学ぶ包括的なチュートリアルがあります。[このブログの投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2) を参照してください。
{: tip}
