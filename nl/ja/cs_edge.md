---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks 

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



# ネットワーク・トラフィックをエッジ・ワーカー・ノードに制限する
{: #edge}

エッジ・ワーカー・ノードを使用すると、外部からアクセスされるワーカー・ノードの数を減らし、{{site.data.keyword.containerlong}} のネットワーキングのワークロードを分離することができるので、Kubernetes クラスターのセキュリティーが改善されます。
{:shortdesc}

これらのワーカー・ノードがネットワーキング専用としてマーク付けされると、他のワークロードはワーカー・ノードの CPU やメモリーを消費してネットワーキングに干渉することがなくなります。

複数ゾーン・クラスターがあり、エッジ・ワーカー・ノードへのネットワーク・トラフィックを制限する場合は、ロード・バランサーまたは Ingress ポッドの高可用性のために各ゾーンで少なくとも 2 つのエッジ・ワーカー・ノードを使用可能にする必要があります。 クラスター内のすべてのゾーンにかかるエッジ・ノード・ワーカー・プールを作成し、ゾーンごとに少なくとも 2 つのワーカー・ノードがあるようにします。
{: tip}

## ワーカー・ノードにエッジ・ノードとしてラベル付けする
{: #edge_nodes}

クラスター内の各パブリック VLAN 上の複数のワーカー・ノードに `dedicated=edge` ラベルを追加して、Ingress とロード・バランサーがそれらのワーカー・ノードにだけデプロイされるようにします。
{:shortdesc}

開始前に、以下のことを行います。

1. 以下の [{{site.data.keyword.Bluemix_notm}} IAM 役割](/docs/containers?topic=containers-users#platform)があることを確認します。
  * クラスターに対するプラットフォームの役割
  * すべての名前空間に対する**ライター**または**管理者**のサービス役割
2. [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。
3. クラスターに 1 つ以上のパブリック VLAN があることを確認してください。 エッジ・ワーカー・ノードは、プライベート VLAN だけがあるクラスターには使用できません。
4. クラスター内のすべてのゾーンにかかる[新しいワーカー・プールを作成](/docs/containers?topic=containers-clusters#add_pool)し、ゾーンごとに少なく少なくとも 2 つのワーカーがあるようにします。

ワーカー・ノードにエッジ・ノードとしてラベル付けするには、以下のようにします。

1. エッジ・ノード・ワーカー・プール内にあるワーカー・ノードをリストします。 **プライベート IP** アドレスを使用して、ノードを識別します。

  ```
  ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <edge_pool_name>
  ```
  {: pre}

2. `dedicated=edge` により、ワーカー・ノードにラベルを付けます。 `dedicated=edge` によりワーカー・ノードにマークが付けられると、すべての後続の Ingress とロード・バランサーは、エッジ・ワーカー・ノードにデプロイされます。

  ```
  kubectl label nodes <node1_IP> <node2_IP> dedicated=edge
  ```
  {: pre}

3. クラスター内の既存のロード・バランサーと Ingress アプリケーション・ロード・バランサー (ALB) をすべて検索します。

  ```
  kubectl get services --all-namespaces
  ```
  {: pre}

  出力から、**TYPE** が **LoadBalancer** になっているサービスを探します。 各ロード・バランサー・サービスの **Namespace** と **Name** をメモします。 例えば、以下の出力には 3 つのロード・バランサー・サービスがあります。`default` 名前空間内のロード・バランサー `webserver-lb` と、`kube-system` 名前空間内の Ingress ALB `public-crdf253b6025d64944ab99ed63bb4567b6-alb1` と `public-crdf253b6025d64944ab99ed63bb4567b6-alb2` です。

  ```
  NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
  default       kubernetes                                       ClusterIP      172.21.0.1       <none>          443/TCP                      1h
  default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                 10m
  kube-system   heapster                                         ClusterIP      172.21.101.189   <none>          80/TCP                       1h
  kube-system   kube-dns                                         ClusterIP      172.21.0.10      <none>          53/UDP,53/TCP                1h
  kube-system   kubernetes-dashboard                             ClusterIP      172.21.153.239   <none>          443/TCP                      1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.48.228.78   80:30286/TCP,443:31363/TCP   1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb2   LoadBalancer   172.21.229.73    169.46.17.6     80:31104/TCP,443:31138/TCP   57m
  ```
  {: screen}

4. 直前のステップで得られた出力を使用して、ロード・バランサーと Ingress ALB ごとに以下のコマンドを実行します。 このコマンドは、ロード・バランサーや Ingress ALB をエッジ・ワーカー・ノードに再デプロイします。 再デプロイする必要があるのは、パブリック・ロード・バランサーまたは ALB だけです。

  ```
  kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
  ```
  {: pre}

  出力例:

  ```
  service "my_loadbalancer" configured
  ```
  {: screen}

ワーカー・ノードに `dedicated=edge` のラベルを付け、既存のロード・バランサーのすべてと Ingress をエッジ・ワーカー・ノードに再デプロイしました。 次に、他の[ワークロードがエッジ・ワーカー・ノード上で実行されないようにして](#edge_workloads)、[ワーカー・ノード上の NodePort へのインバウンド・トラフィックをブロックします](/docs/containers?topic=containers-network_policies#block_ingress)。

<br />


## ワークロードがエッジ・ワーカー・ノード上で実行されないようにする
{: #edge_workloads}

エッジ・ワーカー・ノードの利点の 1 つは、それらがネットワーク・サービスだけを実行するように指定できることです。
{:shortdesc}

`dedicated=edge` 耐障害性の使用は、すべてのロード・バランサーと Ingress サービスが、ラベルの付けられたワーカー・ノードにのみデプロイされることを意味します。 ただし、他のワークロードがエッジ・ワーカー・ノード上で実行されてワーカー・ノードのリソースを消費することがないようにするため、[Kubernetes テイント ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) を使用する必要があります。

開始前に、以下のことを行います。
- すべての名前空間に対する[**管理者**の {{site.data.keyword.Bluemix_notm}} IAM サービス役割](/docs/containers?topic=containers-users#platform)があることを確認します。
- [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

他のワークロードがエッジ・ワーカー・ノード上で実行されないようにするには、以下のようにします。

1. `dedicated=edge` ラベルの付いたワーカー・ノードをすべてリストします。

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. テイントを各ワーカー・ノードに適用します。このテイントは、ポッドがワーカー・ノード上で実行されるのを防ぎ、`dedicated=edge` ラベルのないポッドをワーカー・ノードから削除します。 削除されるポッドは、容量のある他のワーカー・ノードに再デプロイされます。

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```
  {: pre}
  これで、`dedicated=edge` 耐障害性のあるポッドだけがエッジ・ワーカー・ノードにデプロイされます。

3. [ロード・バランサー 1.0 サービスのソース IP 保持を有効にする ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) 場合は必ず、[アプリ・ポッドにエッジ・ノード・アフィニティーを追加](/docs/containers?topic=containers-loadbalancer#edge_nodes)して、エッジ・ワーカー・ノードにアプリ・ポッドをスケジュールするようにしてください。 着信要求を受信するには、アプリ・ポッドをエッジ・ノードにスケジュールする必要があります。

4. テイントを削除するには、以下のコマンドを実行します。
    ```
    kubectl taint node <node_name> dedicated:NoSchedule- dedicated:NoExecute-
    ```
    {: pre}
