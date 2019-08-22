---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, nginx, iks multiple ingress controllers

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


# 自分の Ingress コントローラーを持ち込む
{: #ingress-user_managed}

独自の Ingress コントローラーを持ち込み、{{site.data.keyword.cloud_notm}} で実行して、IBM 提供のホスト名および TLS 証明書を利用します。
{: shortdesc}

IBM 提供の Ingress アプリケーション・ロード・バランサー (ALB) は、[カスタム {{site.data.keyword.cloud_notm}} アノテーション](/docs/containers?topic=containers-ingress_annotation)を使用して構成可能な NGINX コントローラーに基づいています。 アプリでの必要に応じて、独自のカスタム Ingress コントローラーを構成することが必要になる場合があります。 IBM 提供の Ingress ALB を使用するのではなく、独自の Ingress コントローラーを持ち込む場合は、コントローラー・イメージの提供、コントローラーの保守、コントローラーの更新、および Ingress コントローラーを脆弱性のない状態に保持するためのあらゆるセキュリティー関連の更新を自分で行う必要があります。 **注**: 独自の Ingress コントローラーの持ち込みは、アプリへのパブリック外部アクセスを可能にするためにのみサポートされ、プライベート外部アクセスを可能にするためにはサポートされていません。

独自の Ingress コントローラーを持ち込むには、以下の 2 つのオプションがあります。
* [ネットワーク・ロード・バランサー (NLB) を作成して、カスタム Ingress コントローラー・デプロイメントを公開してから、NLB IP アドレスのホスト名を作成します](#user_managed_nlb)。 {{site.data.keyword.cloud_notm}} によりホスト名が提供され、ユーザーの代わりにホスト名のワイルドカード SSL 証明書の生成および保守が行われます。 IBM 提供の NLB DNS ホスト名について詳しくは、[NLB ホスト名の登録](/docs/containers?topic=containers-loadbalancer_hostname)を参照してください。
* [IBM 提供の ALB デプロイメントを無効にし、IBM 提供の Ingress サブドメイン用の ALB および DNS 登録を公開したロード・バランサー・サービスを使用します](#user_managed_alb)。 このオプションを使用すると、クラスターに既に割り当てられている Ingress サブドメインおよび TLS 証明書を利用できます。

## NLB とホスト名を作成して Ingress コントローラーを公開する
{: #user_managed_nlb}

ネットワーク・ロード・バランサー (NLB) を作成して、カスタム Ingress コントローラー・デプロイメントを公開してから、NLB IP アドレスのホスト名を作成します。
{: shortdesc}

1. Ingress コントローラーの構成ファイルを準備します。 例えば、[クラウド汎用 NGINX コミュニティー Ingress コントローラー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic) を使用できます。 コミュニティー・コントローラーを使用する場合は、以下の手順に従って、`kustomization.yaml` ファイルを編集します。
  1. `namespace: ingress-nginx` を `namespace: kube-system` に置き換えます。
  2. `commonLabels` セクションで、`app.kubernetes.io/name: ingress-nginx` ラベルと `app.kubernetes.io/part-of: ingress-nginx` ラベルを 1 つの `app: ingress-nginx` ラベルに置き換えます。

2. 独自の Ingress コントローラーをデプロイします。 例えば、クラウド汎用 NGINX コミュニティー Ingress コントローラーを使用するには、以下のコマンドを実行します。
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

3. ロード・バランサーを定義して、カスタム Ingress デプロイメントを公開します。
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-lb-svc
    spec:
      type: LoadBalancer
      selector:
        app: ingress-nginx
      ports:
       - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
    ```
    {: codeblock}

4. クラスター内にサービスを作成します。
    ```
    kubectl apply -f my-lb-svc.yaml
    ```
    {: pre}

5. ロード・バランサーの **EXTERNAL-IP** アドレスを取得します。
    ```
    kubectl get svc my-lb-svc -n kube-system
    ```
    {: pre}

    次の出力例では、**EXTERNAL-IP** は `168.1.1.1` です。
    ```
    NAME         TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)            AGE
    my-lb-svc    LoadBalancer   172.21.xxx.xxx   168.1.1.1        80:30104/TCP       2m
    ```
    {: screen}

6. DNS ホスト名を作成することで、ロード・バランサー IP アドレスを登録します。
    ```
    ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <LB_IP>
    ```
    {: pre}

7. ホスト名が作成されたことを確認します。
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  出力例:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
  ```
  {: screen}

8. オプション: [ヘルス・モニターを作成して、ホスト名に対するヘルス・チェックを有効にします](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor)。

9. 構成マップなど、カスタム Ingress コントローラーに必要なその他のリソースをデプロイします。

10. アプリ用の Ingress リソースを作成します。 Kubernetes の資料を使用して、[Ingress リソース・ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/ingress/) を作成し、[アノテーション ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) を使用できます。
  <p class="tip">引き続き、1 つのクラスター内で IBM 提供の ALB をカスタム Ingress コントローラーと同時に使用する場合は、ALB およびカスタム・コントローラーに個別の Ingress リソースを作成できます。 [IBM ALB にのみ適用するために作成する Ingress リソース](/docs/containers?topic=containers-ingress#ingress_expose_public)で、アノテーション <code>kubernetes.io/ingress.class: "iks-nginx"</code> を追加します。</p>

11. ステップ 7 で見つけたロード・バランサー・ホスト名、および Ingress リソース・ファイルで指定したアプリが listen するパスを使用して、アプリにアクセスします。
  ```
  https://<load_blanacer_host_name>/<app_path>
  ```
  {: codeblock}

## 既存のロード・バランサーおよび Ingress サブドメインを使用して Ingress コントローラーを公開する
{: #user_managed_alb}

IBM 提供の ALB デプロイメントを無効にし、IBM 提供の Ingress サブドメイン用の ALB および DNS 登録を公開したロード・バランサー・サービスを使用します。
{: shortdesc}

1. デフォルトのパブリック ALB の ID を取得します。 パブリック ALB の形式は `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` のようになります。
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. デフォルトのパブリック ALB を無効にします。 `--disable-deployment` フラグは、IBM 提供の ALB デプロイメントを無効にしますが、IBM 提供の Ingress サブドメインの DNS 登録も、Ingress コントローラーを公開するために使用されるロード・バランサー・サービスも削除しません。
    ```
    ibmcloud ks alb-configure --albID <ALB_ID> --disable-deployment
    ```
    {: pre}

3. Ingress コントローラーの構成ファイルを準備します。 例えば、[クラウド汎用 NGINX コミュニティー Ingress コントローラー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic) を使用できます。 コミュニティー・コントローラーを使用する場合は、以下の手順に従って、`kustomization.yaml` ファイルを編集します。
  1. `namespace: ingress-nginx` を `namespace: kube-system` に置き換えます。
  2. `commonLabels` セクションで、`app.kubernetes.io/name: ingress-nginx` ラベルと `app.kubernetes.io/part-of: ingress-nginx` ラベルを 1 つの `app: ingress-nginx` ラベルに置き換えます。
  3. `SERVICE_NAME` 変数で、`name: ingress-nginx` を `name: <ALB_ID>` に置き換えます。 例えば、ステップ 1 からの ALB ID は、`name: public-cr18e61e63c6e94b658596ca93d087eed9-alb1` のようになります。

4. 独自の Ingress コントローラーをデプロイします。 例えば、クラウド汎用 NGINX コミュニティー Ingress コントローラーを使用するには、以下のコマンドを実行します。 **重要**: コントローラーを公開するロード・バランサー・サービスと IBM 提供の Ingress サブドメインを引き続き使用するには、コントローラーを `kube-system` 名前空間にデプロイする必要があります。
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

5. カスタム Ingress デプロイメントのラベルを取得します。
    ```
    kubectl get deploy <ingress-controller-name> -n kube-system --show-labels
    ```
    {: pre}

    次の出力例では、ラベル値は `ingress-nginx` です。
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

6. ステップ 1 で取得した ALB ID を使用して、IBM ALB を公開するロード・バランサー・サービスを開きます。
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

7. カスタム Ingress デプロイメントを指すようにロード・バランサー・サービスを更新します。 `spec/selector` の下で、`app` ラベルから ALB ID を削除し、ステップ 5 で取得した独自の Ingress コントローラーのラベルを追加します。
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. オプション: デフォルトでは、ロード・バランサー・サービスは、ポート 80 と 443 のトラフィックを許可します。 カスタム Ingress コントローラーで異なるポートのセットを使用する必要がある場合は、それらのポートを `ports` セクションに追加します。

8. 構成ファイルを保存して閉じます。 出力は、以下のようになります。
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

9. ALB `Selector` がユーザーのコントローラーを指していることを確認します。
    ```
    kubectl describe svc <ALB_ID> -n kube-system
    ```
    {: pre}

    出力例:
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
    ```
    {: screen}

10. 構成マップなど、カスタム Ingress コントローラーに必要なその他のリソースをデプロイします。

11. 複数ゾーン・クラスターがある場合は、ALB ごとにこれらの手順を繰り返します。

12. 複数ゾーン・クラスターが存在する場合は、ヘルス・チェックを構成する必要があります。 Cloudflare DNS ヘルス・チェック・エンドポイント `albhealth.<clustername>.<region>.containers.appdomain.com` では、応答内に本体 `healthy` を含む `200` 応答が予期されます。 `200` および `healthy` を返すようにヘルス・チェックがセットアップされていない場合は、ヘルス・チェックにより DNS プールからすべての ALB IP アドレスが削除されます。 既存のヘルス・チェック・リソースを編集することも、独自に作成することもできます。
  * 既存のヘルス・チェック・リソースを編集するには、以下のようにします。
      1. `alb-health` リソースを開きます。
        ```
        kubectl edit ingress alb-health --namespace kube-system
        ```
        {: pre}
      2. `metadata.annotations` セクションで、`ingress.bluemix.net/server-snippets` アノテーション名をコントローラーでサポートされるアノテーションに変更します。 例えば、`nginx.ingress.kubernetes.io/server-snippet` アノテーションを使用できます。 サーバー・スニペットのコンテンツを変更しないでください。
      3. ファイルを保存して閉じます。 変更内容は、自動的に適用されます。
  * 独自のヘルス・チェック・リソースを作成するには、次のスニペットが Cloudflare に返されるようにします。
    ```
    { return 200 'healthy'; add_header Content-Type text/plain; }
    ```
    {: codeblock}

13. [クラスター内部にあるアプリをパブリックに公開する](/docs/containers?topic=containers-ingress#ingress_expose_public)の手順に従って、アプリの Ingress リソースを作成します。

これで、カスタム Ingress コントローラーでアプリが公開されるようになりました。 IBM 提供の ALB デプロイメントを復元するには、ALB を再度有効にします。 ALB が再デプロイされ、ロード・バランサー・サービスがその ALB を指すように自動的に再構成されます。

```
ibmcloud ks alb-configure --albID <alb ID> --enable
```
{: pre}
