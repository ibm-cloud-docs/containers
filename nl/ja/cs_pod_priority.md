---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# ポッドの優先度の設定
{: #pod_priority}

Kubernetes のポッドの優先度と回避により、ポッドの相対的な優先度を示すように優先度クラスを構成することができます。Kubernetes スケジューラーは、ポッドの優先度を考慮に入れ、高優先度のポッド用にワーカー・ノードのスペースを確保するために低優先度のポッドを回避 (削除) することもできます。Kubernetes バージョン 1.11.2 以降を実行する {{site.data.keyword.containerlong}} クラスターは、これらのクラスを強制する `Priority` アドミッション・コントローラーをサポートします。
{: shortdesc}

**ポッドの優先度を設定する理由**</br>
クラスター管理者は、クラスター・ワークロードにとってどのポッドがより重要かを制御する必要があります。優先度クラスは、低優先度のポッドより高優先度のポッドを優先する Kubernetes スケジューラーの決定を制御するのに役立ちます。スケジューラーは、保留中の高優先度のポッドをスケジュールできるように、実行中の低優先度のポッドを回避 (削除) することもできます。

ポッドの優先度を設定することによって、低優先度のワークロードがクラスター内の重要なワークロードに影響を与えるのを防ぐことができます (特に、クラスターがそのリソース容量に達し始めている場合)。

クラスターへの[適切なユーザー・アクセスがセットアップされている](cs_users.html#users)こと、および該当する場合は、[ポッドのセキュリティー・ポリシー](cs_psp.html#psp)があることを確認します。アクセスおよびポッドのセキュリティー・ポリシーにより、信頼できないユーザーが高優先度のポッドをデプロイして他のポッドのスケジューリングを妨げることがないようにすることができます。
{: tip}

{: #priority_scheduling}
**優先度のスケジュールと回避の仕組み**</br>
一般に、高優先度の保留中のポッドは、優先度付けの低いポッドより前にスケジュールされます。ワーカー・ノードに十分なリソースが残っていない場合、スケジューラーは、優先度付けの高いポッドをスケジュールするのに十分なリソースを解放するためにポッドを回避 (削除) することができます。回避は、正常終了期間、ポッド中断予算、およびワーカー・ノード・アフィニティーによっても影響を受けます。

ポッドのデプロイメントに優先度を指定しない場合、デフォルトは `globalDefault` として設定される優先度クラスに設定されます。`globalDefault` 優先度クラスがない場合、すべてのポッドのデフォルトの優先度はゼロ (`0`) になります。デフォルトでは、{{site.data.keyword.containerlong_notm}} は `globalDefault` を設定しないため、ポッドのデフォルトの優先度はゼロになります。

以下の図のシナリオを考えてみます。**重要**: ご覧のように、ポッドの優先度とスケジューラーを一緒に使用することにより、使用可能なリソースを持つワーカー・ノード上に、優先度付けされたポッドが配置される仕組みを理解する必要があります。それ以外の場合、シナリオ 3 のように、クラスター内の高優先度のポッドが保留状態のままになり、それと同時に既存のポッドが削除されることがあります。

_図: ポッドの優先度のシナリオ_ ![ポッドの優先度のシナリオ](images/pod-priority.png)
1.  優先度が高、中、低の 3 つのポッドが、スケジュール保留中です。スケジューラーは、3 つのすべてのポッドのためのスペースがある使用可能なワーカー・ノードを見つけ、高優先度のポッドが先にスケジュールされるように優先度の順にポッドをスケジュールします。
2.  優先度が高、中、低の 3 つのポッドが、スケジュール保留中です。スケジューラーは、使用可能なワーカー・ノードを見つけますが、ワーカー・ノードには優先度が高と中のポッドをサポートするのに十分なリソースしかありません。低優先度のポッドはスケジュールされず、保留中のままとなります。
3.  優先度が高と中の 2 つのポッドが、スケジュール保留中です。低優先度の 3 番目のポッドが使用可能なワーク・ノード上に存在します。ただし、ワーカー・ノードには、保留中のポッドをスケジュールするための十分なリソースがありません。スケジューラーは、低優先度のポッドを回避 (削除) して、このポッドを保留状態に戻します。次に、スケジューラーは、高優先度のポッドのスケジュールを試みます。ただし、ワーカー・ノードには、高優先度のポッドをスケジュールするための十分なリソースがないため、スケジューラーは中優先度のポッドをスケジュールします。

**詳細情報**: [ポッドの優先度および回避 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/) に関する Kubernetes の資料を参照してください。

**ポッドの優先度のアドミッション・コントローラーを無効にできるかどうか**</br>
いいえ。ポッドの優先度を使用しない場合は、`globalDefault` を設定したりポッドのデプロイメントに優先度クラスを含めたりしないでください。IBM が[デフォルトの優先度クラス](#default_priority_class)を使用してデプロイするクラスターに不可欠なポッドを除き、すべてのポッドのデフォルトはゼロです。ポッドの優先度は相対的であるため、この基本セットアップにより、クラスターに不可欠なポッドがリソースについて優先度付けされ、配置されている既存のスケジューリング・ポリシーに従ってその他のポッドがスケジュールされます。

## デフォルトの優先度クラスについて
{: #default_priority_class}

{{site.data.keyword.containerlong_notm}} クラスターには、デフォルトでいくつかの優先度クラスが用意されています。**重要**: デフォルトのクラスを変更しないでください。これらは、クラスターを正しく管理するために使用されています。アプリ・デプロイメントでこれらのクラスを使用するか、または[独自の優先度クラスを作成](#create_priority_class)することができます。
{: shortdesc}

以下の表では、デフォルトでクラスター内にある優先度クラス、およびそれらの使用目的について説明します。 

| 名前 | 設定元 | 優先度の値 | 目的 |
|---|---|---|
| `system-node-critical` | Kubernetes | 2000001000 | クラスターの作成時に `kube-system` 名前空間にデプロイされたポッドを選択し、この優先度クラスを使用して、ネットワーク、ストレージ、ロギング、モニター、およびメトリック・ポッドなど、ワーカー・ノードの重要な機能を保護します。 |
| `system-cluster-critical` | Kubernetes | 2000000000 | クラスターの作成時に `kube-system` 名前空間にデプロイされたポッドを選択し、この優先度クラスを使用して、ネットワーク、ストレージ、ロギング、モニター、およびメトリック・ポッドなど、クラスターの重要な機能を保護します。 |
| `ibm-app-cluster-critical` | IBM | 900000000 | クラスターの作成時に `ibm-system` 名前空間にデプロイされたポッドを選択し、この優先度クラスを使用して、ロード・バランサー・ポッドなど、アプリの重要な機能を保護します。 |
{: caption="変更してはならないデフォルトの優先度クラス" caption-side="top"}

以下のコマンドを実行することによって、優先度クラスを使用するポッドを確認できます。

```
kubectl get pods --all-namespaces -o custom-columns=NAME:.metadata.name,PRIORITY:.spec.priorityClassName
```
{: pre}

## 優先度クラスの作成
{: #create_priority_class}

ポッドの優先度を設定するには、優先度クラスを使用する必要があります。
{: shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分の Kubernetes 1.11 以降のクラスターに設定します。

1.  オプション: 既存の優先度クラスを新規クラスのテンプレートとして使用します。
    
    1.  既存の優先度クラスをリストします。
        
        ```
        kubectl get priorityclasses
        ```
        {: pre}
        
    2.  コピーする優先度クラスを選択し、ローカル YAML ファイルを作成します。
    
        ```
        kubectl get priorityclass <priority_class> -o yaml > Downloads/priorityclass.yaml
        ```
        {: pre}
        
2.  優先度クラス YAML ファイルを作成します。

    ```yaml
    apiVersion: scheduling.k8s.io/v1alpha1
    kind: PriorityClass
    metadata:
      name: <priority_class_name>
    value: <1000000>
    globalDefault: <false>
    description: "Use this class for XYZ service pods only."
    ```
    {: codeblock}
    
    <table>
    <caption>YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>必須: 作成する優先度クラスの名前。</td>
    </tr>
    <tr>
    <td><code>value</code></td>
    <td>必須: 10 億 (1000000000) 以下の整数を入力します。数字が大きければ大きいほど優先度が高くなります。値は、クラスター内の他の優先度クラスの値に対する相対値です。回避 (削除) しない、システムに不可欠な多数のポッドを予約します。</br></br>例えば、[デフォルトのクラスターに不可欠な優先度クラス](#default_priority_class)の値の範囲は 900000000 から 2000001000 であるため、これらのポッドよりも優先度付けが高くならないように、新しい優先度クラスにはこれらの数値未満の値を入力します。</td>
    </tr>
    <tr>
    <td><code>globalDefault</code></td>
    <td>オプション: この優先度クラスを、`priorityClassName` 値を使用せずにスケジュールされたすべてのポッドに適用されるグローバル・デフォルトにするには、このフィールドを `true` に設定します。グローバル・デフォルトとして設定できるのは、クラスター内の 1 つの優先度クラスのみです。グローバル・デフォルトがない場合、`priorityClassName` が指定されていないポッドの優先度はゼロ (`0`) になります。</br></br>
    [デフォルト優先度クラス](#default_priority_class)は、`globalDefault` を設定しません。クラスター内に他の優先度クラスを作成した場合、`kubectl describe priorityclass<name>` を実行することによって、`globalDefault` が設定されていないことを確認できます。</td>
    </tr>
    <tr>
    <td><code>description</code></td>
    <td>オプション: ユーザーにその優先度クラスを使用する理由を通知します。ストリングを引用符 (`""`) で囲みます。</td>
    </tr></tbody></table>
    
3.  クラスター内に優先度クラスを作成します。

    ```
    kubectl apply -f filepath/priorityclass.yaml
    ```
    {: pre}

4.  優先度クラスが作成されたことを確認します。

    ```
    kubectl get priorityclasses
    ```
    {: pre}

優先度クラスを作成しました。優先度クラスについて、およびポッドのデプロイメントに使用する優先度クラス (使用する必要がある場合) をチームに知らせてください。  

## ポッドへの優先度の割り当て
{: #prioritize}

優先度クラスをポッドの仕様に割り当てて、{{site.data.keyword.containerlong_notm}} クラスター内のポッドの優先度を設定します。優先度クラスが Kubernetes バージョン 1.11 で使用可能になる前にポッドが存在していた場合は、ポッド YAML ファイルを編集して、ポッドに優先度を割り当てる必要があります。
{: shortdesc}

開始前に、以下のことを行います。
* [CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分の Kubernetes 1.11 以降のクラスターに設定します。
* 優先度によって既存のポッドが回避され、クラスターのリソースの消費方法に影響を与える可能性があるため、[優先度スケジューリングの仕組みを理解](#priority_scheduling)します。

ポッドに優先度を割り当てるには、以下のようにします。

1.  既にデプロイされているものとの関連でポッドの正しい優先度クラスを選択できるように、他のデプロイ済みポッドの重要度を確認します。

    1.  名前空間内の他のポッドが使用する優先度クラスを表示します。 
        
        ```
        kubectl get pods -n <namespace> -o custom-columns=NAME:.metadata.name,PRIORITY:.spec.priorityClassName
        ```
        {: pre}
        
    2.  優先度クラスの詳細を取得し、**value** の数値をメモします。数値がより大きいポッドには、数値が小さいポッドの前の優先度が付けられます。確認する優先度クラスごとに、このステップを繰り返します。

        ```
        kubectl describe priorityclass <priorityclass_name>
        ```
        {: pre}

2.  使用する優先度クラスを取得するか、[独自の優先度クラスを作成](#create_priority_class)します。

    ```
    kubectl get priorityclasses
    ```
    {: pre}
    
3.  ポッドの仕様で、前のステップで取得した優先度クラスの名前を持つ `priorityClassName` フィールドを追加します。

    ```yaml
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.bluemix.net/ibmliberty:latest
            ports:
            - containerPort: 9080
          priorityClassName: <priorityclass_name>
    ```
    {: codeblock}

4.  デプロイ先の名前空間で、優先度付けされたポッドを作成します。

    ```
    kubectl apply -f filepath/pod-deployment.yaml
    ```
    {: pre}
