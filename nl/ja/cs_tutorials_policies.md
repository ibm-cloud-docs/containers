---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# チュートリアル: Calico ネットワーク・ポリシーを使用したトラフィックのブロック
{: #policy_tutorial}

デフォルトで、Kubernetes の NodePort、LoadBalancer、Ingress の各サービスは、パブリックとプライベートのすべてのクラスター・ネットワーク・インターフェースでアプリを使用可能にします。デフォルトの `allow-node-port-dnat` Calico ポリシーでは、NodePort、LoadBalancer、Ingress の各サービスから、それらのサービスが公開しているアプリ・ポッドへの着信トラフィックが許可されます。Kubernetes は宛先ネットワーク・アドレス変換 (DNAT) を使用してサービス要求を正しいポッドに転送します。

ただし、セキュリティー上の理由から、特定のソース IP アドレスからのネットワーク・サービスへのトラフィックのみを許可する必要がある場合があります。[Calico Pre-DNAT ポリシー![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/getting-started/bare-metal/policy/pre-dnat)を使用して、特定の IP アドレスのトラフィックをホワイトリストまたはブラックリストに入れることができます。Pre-DNAT ポリシーは、Kubernetes がポッドにトラフィックを転送するために通常の DNAT を使用する前に適用されるため、指定されたトラフィックがアプリに到達することを防止します。Calico Pre-DNAT ポリシーを作成する場合、ソース IP アドレスをホワイトリストまたはブラックリストに入れるかどうかを選択します。ほとんどのシナリオでは、ホワイトリスティングによって、既知の許可されたソース IP アドレスからのトラフィックを除くすべてのトラフィックがブロックされるので、最も安全な構成が提供されます。通常、ブラックリスティングは、少数の IP アドレスからの攻撃を防ぐようなシナリオでのみ有用です。

このシナリオでは、PR 会社のネットワーク管理者の役割を担って、アプリへの何らかの異常なトラフィックを見つけます。このチュートリアルのレッスンでは、サンプル Web サーバー・アプリを作成し、LoadBalancer サービスを使用してアプリを公開し、Calico ポリシーのホワイトリストとブラックリストの両方を使用して、不要で異常なトラフィックからアプリを保護します。

## 達成目標

- 上位の Pre-DNAT ポリシーを作成することによって、すべての NodePort への着信トラフィックをブロックします。
- 下位の Pre-DNAT ポリシーを作成することによって、ホワイトリストにあるソース IP アドレスが、LoadBalancer のパブリック IP およびポートにアクセスできるようにします。下位ポリシーが上位ポリシーをオーバーライドします。
- 下位の Pre-DNAT ポリシーを作成することによって、ブラックリストにあるソース IP アドレスが、LoadBalancer のパブリック IP およびポートにアクセスすることをブロックします。

## 所要時間
1 時間

## 対象読者
このチュートリアルは、アプリへのネットワーク・トラフィックを管理するソフトウェア開発者やネットワーク管理者を対象にしています。

## 前提条件

- [バージョン 1.10 クラスターを作成する](cs_clusters.html#clusters_ui)か、または[既存のクラスターをバージョン 1.10 に更新します](cs_versions.html#cs_v110)。このチュートリアルでは、Kubernetes バージョン 1.10 以降のクラスターで、3.1.1 Calico CLI および Calico v3 ポリシー構文を使用する必要があります。
- [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。
- [Calico CLI をインストールして構成します](cs_network_policy.html#1.10_install)。

<br />


## レッスン 1: アプリをデプロイし、LoadBalancer を使用して公開する
{: #lesson1}

最初のレッスンでは、複数の IP アドレスとポートからアプリがどのように公開されるか、パブリック・トラフィックがクラスターにどのように着信するかを示します。
{: shortdesc}

チュートリアルを通じて使用するサンプル Web サーバー・アプリのデプロイから開始します。`echoserver` Web サーバーでは、クライアントからクラスターへの接続に関するデータが表示され、PR 会社のクラスターへのアクセスをテストできます。次に、LoadBalancer サービスを作成して、アプリを公開します。LoadBalancer サービスにより、LoadBalancer サービス IP アドレスとワーカー・ノードの NodePort の両方でアプリが使用可能になります。

以下のイメージは、レッスン 1 の終了時に、Web サーバー・アプリがパブリック NodePort とパブリック LoadBalancer によってインターネットにどのように公開されるかを示しています。

<img src="images/cs_tutorial_policies_Lesson1.png" width="450" alt="レッスン 1 の終了時に、Web サーバー・アプリがパブリック NodePort とパブリック LoadBalancer によってインターネットに公開されます。" style="width:450px; border-style: none"/>

1. このチュートリアルを通じて使用する `pr-firm` というテスト名前空間を作成します。
    ```
    kubectl create ns pr-firm
    ```
    {: pre}

2. サンプル Web サーバー・アプリをデプロイします。接続が Web サーバー・アプリに対して行われると、アプリは接続で受信した HTTP ヘッダーを使用して応答します。
    ```
    kubectl run webserver -n pr-firm --image=k8s.gcr.io/echoserver:1.10 --replicas=3
    ```
    {: pre}

3. Web サーバー・アプリ・ポッドの **STATUS** が `Running` になっていることを確認します。
    ```
    kubectl get pods -n pr-firm -o wide
    ```
    {: pre}

    出力例:
    ```
    NAME                         READY     STATUS    RESTARTS   AGE       IP               NODE
    webserver-855556f688-6dbsn   1/1       Running   0          1m        172.30.xxx.xxx   10.176.48.78
    webserver-855556f688-76rkp   1/1       Running   0          1m        172.30.xxx.xxx   10.176.48.78
    webserver-855556f688-xd849   1/1       Running   0          1m        172.30.xxx.xxx   10.176.48.78
    ```
    {: screen}

4. アプリをパブリック・インターネットに公開するには、テキスト・エディターで `webserver.yaml` という LoadBalancer サービス構成ファイルを作成します。
    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: webserver
      name: webserver-lb
      namespace: pr-firm
    spec:
      externalTrafficPolicy: Cluster
      ports:
      - name: webserver-port
        port: 80
        protocol: TCP
        targetPort: 8080
      selector:
        run: webserver
      type: LoadBalancer
    ```
    {: codeblock}

5. LoadBalancer をデプロイします。
    ```
    kubectl apply -f filepath/webserver.yaml
    ```
    {: pre}

6. LoadBalancer によってコンピューターから公開されたアプリにパブリック・アクセスできることを確認します。

    1. LoadBalancer のパブリック **EXTERNAL-IP** アドレスを取得します。
        ```
        kubectl get svc -n pr-firm -o wide
        ```
        {: pre}

        出力例:
        ```
        NAME           CLUSTER-IP       EXTERNAL-IP        PORT(S)        AGE       SELECTOR
        webserver-lb   172.21.xxx.xxx   169.xx.xxx.xxx     80:31024/TCP   2m        run=webserver
        ```
        {: screen}

    2. メモ用のテキスト・ファイルを作成して、LoadBalancer IP をそのテキスト・ファイルにコピーします。このメモは、後のレッスンで値を迅速に取り出すために役立ちます。

    3. LoadBalancer の外部 IP にパブリック・アクセスできることを確認します。
        ```
        curl --connect-timeout 10 <loadbalancer_IP>:80
        ```
        {: pre}

        以下の出力例では、LoadBalancer によってパブリック LoadBalancer IP アドレス `169.1.1.1` でアプリが公開されたことを確認できます。アプリ・ポッド `webserver-855556f688-76rkp` が curl 要求を受信しました。
        ```
        Hostname: webserver-855556f688-76rkp
        Pod Information:
            -no pod information available-
        Server values:
            server_version=nginx: 1.13.3 - lua: 10008
        Request Information:
            client_address=1.1.1.1
            method=GET
            real path=/
            query=
            request_version=1.1
            request_scheme=http
            request_uri=http://169.1.1.1:8080/
        Request Headers:
            accept=*/*
            host=169.1.1.1
            user-agent=curl/7.54.0
        Request Body:
            -no body in request-
        ```
        {: screen}

6. NodePort によってコンピューターから公開されたアプリにパブリック・アクセスできることを確認します。LoadBalancer サービスにより、LoadBalancer サービス IP アドレスとワーカー・ノードの NodePort の両方でアプリが使用可能になります。

    1. LoadBalancer がワーカー・ノードに割り当てた NodePort を取得します。NodePort の範囲は 30000 から 32767 までです。
        ```
        kubectl get svc -n pr-firm -o wide
        ```
        {: pre}

        以下の出力例では、NodePort は `31024` です。
        ```
        NAME           CLUSTER-IP       EXTERNAL-IP        PORT(S)        AGE       SELECTOR
        webserver-lb   172.21.xxx.xxx   169.xx.xxx.xxx     80:31024/TCP   2m        run=webserver
        ```
        {: screen}  

    2. ワーカー・ノードの **Public IP** アドレスを取得します。
        ```
        ibmcloud ks workers <cluster_name>
        ```
        {: pre}

        出力例:
        ```
        ID                                                 Public IP        Private IP     Machine Type        State    Status   Zone    Version   
        kube-dal10-cr18e61e63c6e94b658596ca93d087eed9-w1   169.xx.xxx.xxx   10.176.48.67   u2c.2x4.encrypted   normal   Ready    dal10   1.10.5_1513*   
        kube-dal10-cr18e61e63c6e94b658596ca93d087eed9-w2   169.xx.xxx.xxx   10.176.48.79   u2c.2x4.encrypted   normal   Ready    dal10   1.10.5_1513*   
        kube-dal10-cr18e61e63c6e94b658596ca93d087eed9-w3   169.xx.xxx.xxx   10.176.48.78   u2c.2x4.encrypted   normal   Ready    dal10   1.10.5_1513*   
        ```
        {: screen}

    3. 後のレッスンで使用するために、ワーカー・ノードのパブリック IP と NodePort をメモのテキストにコピーします。

    4. NodePort を使用してワーカー・ノードのパブリック IP アドレスにアクセスできることを確認します。
        ```
        curl  --connect-timeout 10 <worker_IP>:<NodePort>
        ```
        {: pre}

        以下の出力例では、アプリへの要求がワーカー・ノードのプライベート IP アドレス `10.1.1.1` と NodePort `31024` を介して受信されたことを確認できます。アプリ・ポッド `webserver-855556f688-xd849` が curl 要求を受信しました。
        ```
        Hostname: webserver-855556f688-xd849
        Pod Information:
            -no pod information available-
        Server values:
            server_version=nginx: 1.13.3 - lua: 10008
        Request Information:
            client_address=1.1.1.1
            method=GET
            real path=/
            query=
            request_version=1.1
            request_scheme=http
            request_uri=http://10.1.1.1:8080/
        Request Headers:
            accept=*/*
            host=10.1.1.1:31024
            user-agent=curl/7.60.0
        Request Body:
            -no body in request-
        ```
        {: screen}

この時点で、アプリは複数の IP アドレスとポートから公開されています。これらの IP のほとんどは、クラスターの内部にあり、プライベート・ネットワークを介してのみアクセス可能です。パブリック NodePort とパブリック LoadBalancer ポートのみ、パブリック・インターネットに公開されます。

次に、パブリック・トラフィックをブロックするための Calico ポリシーを作成して適用します。

## レッスン 2: すべての NodePort への着信トラフィックをブロックする
{: #lesson2}

PR 会社のクラスターを保護するには、アプリを公開している LoadBalancer サービスと NodePort の両方へのパブリック・アクセスをブロックする必要があります。まず、NodePort へのアクセスをブロックします。以下のイメージは、レッスン 2 の終了時に、トラフィックがどのように LoadBalancer に許可され、NodePort には許可されないかを示しています。

<img src="images/cs_tutorial_policies_Lesson2.png" width="450" alt="レッスン 2 の終了時に、Web サーバー・アプリがパブリック LoadBalancer によってのみインターネットに公開されます。" style="width:450px; border-style: none"/>

1. テキスト・エディターで、`deny-nodeports.yaml` という上位の Pre-DNAT ポリシーを作成し、すべてのソース IP からの NodePort への着信 TCP および UDP トラフィックを拒否します。
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: deny-nodeports
    spec:
      applyOnForward: true
      ingress:
      - action: Deny
            destination:
              ports:
          - 30000:32767
            protocol: TCP
            source: {}
      - action: Deny
            destination:
              ports:
          - 30000:32767
        protocol: UDP
        source: {}
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 1100
      types:
      - Ingress
    ```
    {: codeblock}

2. ポリシーを適用します。
    - Linux:

      ```
      calicoctl apply -f filepath/deny-nodeports.yaml
      ```
      {: pre}

    - Windows および OS X:

      ```
      calicoctl apply -f filepath/deny-nodeports.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}
  出力例:
  ```
  Successfully applied 1 'GlobalNetworkPolicy' resource(s)
  ```
  {: screen}

3. メモの値を使用して、ワーカー・ノードのパブリック IP アドレスおよび NodePort にパブリック・アクセスできないことを確認します。
    ```
    curl  --connect-timeout 10 <worker_IP>:<NodePort>
    ```
    {: pre}

    作成した Calico ポリシーによって NodePort へのトラフィックがブロックされるため、接続がタイムアウトになります。
    ```
    curl: (28) Connection timed out after 10016 milliseconds
    ```
    {: screen}

4. 前のレッスンで作成した LoadBalancer の externalTrafficPolicy を `Cluster` から `Local` に変更します。`Local` によって、次のステップで LoadBalancer の外部 IP に対して curl を実行したときに、システムのソース IP が保持されます。
    ```
    kubectl patch svc -n pr-firm webserver -p '{"spec":{"externalTrafficPolicy":"Local"}}'
    ```
    {: pre}

5. メモの値を使用して、まだ LoadBalancer 外部 IP アドレスにパブリック・アクセスできることを確認します。
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}

    出力例:
    ```
    Hostname: webserver-855556f688-76rkp
    Pod Information:
        -no pod information available-
    Server values:
        server_version=nginx: 1.13.3 - lua: 10008
    Request Information:
        client_address=1.1.1.1
        method=GET
        real path=/
        query=
        request_version=1.1
        request_scheme=http
        request_uri=http://<loadbalancer_IP>:8080/
    Request Headers:
        accept=*/*
        host=<loadbalancer_IP>
        user-agent=curl/7.54.0
    Request Body:
        -no body in request-
    ```
    {: screen}
出力の `Request Information` セクションのソース IP アドレスに注意してください (この例では、`client_address=1.1.1.1`)。ソース IP アドレスは、curl の実行に使用しているシステムのパブリック IP です。それ以外の場合、プロキシーまたは VPN を介してインターネットに接続している場合は、プロキシーまたは VPN がシステムの実際の IP アドレスを不明瞭にしている可能性があります。いずれの場合も、LoadBalancer はシステムのソース IP アドレスをクライアント IP アドレスとして認識します。

6. 後のレッスンで使用するために、システムのソース IP アドレス (前のステップの出力では `client_address=1.1.1.1`) をメモにコピーします。

この時点で、アプリはパブリック LoadBalancer ポートからのみパブリック・インターネットに公開されています。パブリック NodePort へのトラフィックはブロックされています。不要なトラフィックからクラスターを部分的にロックしました。

次に、特定のソース IP からのトラフィックをホワイトリストに入れるための Calico ポリシーを作成して適用します。

## レッスン 3: ホワイトリストにある IP からの LoadBalancer への着信トラフィックを許可する
{: #lesson3}

独自のコンピューター IP アドレスをホワイトリストに入れることによって、PR 会社のクラスターへのトラフィックを完全にロックして、アクセスをテストします。
{: shortdesc}

最初に、NodePort に加えて、アプリを公開している LoadBalancer へのすべての着信トラフィックをブロックする必要があります。その後、システムの IP アドレスをホワイトリストに入れるポリシーを作成できます。レッスン 3 の終了時に、パブリック NodePort および LoadBalancer へのすべてのトラフィックはブロックされ、ホワイトリストにあるシステム IP からのトラフィックのみ許可されます。
<img src="images/cs_tutorial_policies_L3.png" width="600" alt="Web サーバー・アプリは、パブリック LoadBalancer によってシステム IP にのみ公開されます。" style="width:600px; border-style: none"/>

1. テキスト・エディターで、`deny-lb-port-80.yaml` という上位の Pre-DNAT ポリシーを作成し、すべてのソース IP からの LoadBalancer IP アドレスとポートへの着信 TCP および UDP トラフィックを拒否します。メモした LoadBalancer パブリック IP アドレスに `<loadbalancer_IP>` を置き換えます。
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: deny-lb-port-80
    spec:
      applyOnForward: true
      ingress:
      - action: Deny
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source: {}
      - action: Deny
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: UDP
        source: {}
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 1100
      types:
      - Ingress
    ```
    {: codeblock}

2. ポリシーを適用します。
    - Linux:

      ```
      calicoctl apply -f filepath/deny-lb-port-80.yaml
      ```
      {: pre}

    - Windows および OS X:

      ```
      calicoctl apply -f filepath/deny-lb-port-80.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

3. メモの値を使用して、パブリック LoadBalancer IP アドレスにアクセスできないことを確認します。作成した Calico ポリシーによって LoadBalancer へのトラフィックがブロックされるため、接続がタイムアウトになります。
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}

4. テキスト・エディターで、`whitelist.yaml` という下位の Pre-DNAT ポリシーを作成し、システムの IP から LoadBalancer IP アドレスとポートへのトラフィックを許可します。メモの値を使用して、`<loadbalancer_IP>` を LoadBalancer のパブリック IP アドレスに置き換え、`<client_address>` をシステムのソース IP のパブリック IP アドレスに置き換えます。
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: codeblock}

5. ポリシーを適用します。
    - Linux:

      ```
      calicoctl apply -f filepath/whitelist.yaml
      ```
      {: pre}

    - Windows および OS X:

      ```
      calicoctl apply -f filepath/whitelist.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}
システムの IP アドレスがホワイトリストに入りました。

6. メモの値を使用して、パブリック LoadBalancer IP アドレスにアクセスできることを確認します。
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}

7. 別の IP アドレスを持つ別のシステムにアクセスできる場合は、そのシステムからの LoadBalancer へのアクセスを試みてください。
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}
システムの IP アドレスがホワイトリストにないため、接続がタイムアウトになります。

この時点で、パブリック NodePort と LoadBalancer へのすべてのトラフィックがブロックされます。ホワイトリストにあるシステム IP からのトラフィックのみ許可されます。

## レッスン 4: ブラックリストにある IP からの LoadBalancer への着信トラフィックを拒否する
{: #lesson4}

前のレッスンでは、すべてのトラフィックをブロックし、いくつかの IP のみをホワイトリストに入れました。このシナリオは、制御されたいくつかのソース IP アドレスのみにアクセスを制限するようなテスト目的の場合によく機能します。ただし、PR 会社のアプリは広く公開される必要のあるものです。少数の IP アドレスで見られる異常なトラフィックを除き、すべてのトラフィックが許可される必要があります。ブラックリスティングは、少数の IP アドレスからの攻撃を防ぐ場合に役立つため、このようなシナリオで有用です。

このレッスンでは、所有するシステムのソース IP アドレスからのトラフィックをブロックすることにより、ブラックリストをテストします。レッスン 4 の終了時に、パブリック NodePort へのすべてのトラフィックがブロックされ、パブリック LoadBalancer へのすべてのトラフィックが許可されます。ブラックリストに入れたシステム IP からの LoadBalancer へのトラフィックのみブロックされます。
<img src="images/cs_tutorial_policies_L4.png" width="600" alt="Web サーバー・アプリは、パブリック LoadBalancer によってインターネットに公開されます。システム IP からのトラフィックのみブロックされます。" style="width:600px; border-style: none"/>

1. 前のレッスンで作成したホワイトリスト・ポリシーをクリーンアップします。
    ```
    calicoctl delete GlobalNetworkPolicy deny-lb-port-80
    ```
    {: pre}
    ```
    calicoctl delete GlobalNetworkPolicy whitelist
    ```
    {: pre}
すべてのソース IP からの LoadBalancer IP アドレスとポートへの着信 TCP および UDP トラフィックが再度許可されます。

2. システムのソース IP アドレスからの LoadBalancer IP アドレスとポートへのすべての着信 TCP および UDP トラフィックを拒否するには、テキスト・エディターで、`deny-lb-port-80.yaml` という下位の Pre-DNAT ポリシーを作成します。メモの値を使用して、`<loadbalancer_IP>` を LoadBalancer のパブリック IP アドレスに置き換え、`<client_address>` をシステムのソース IP のパブリック IP アドレスに置き換えます。
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: blacklist
    spec:
      applyOnForward: true
      ingress:
      - action: Deny
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      - action: Deny
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: UDP
        source:
          nets:
          - <client_address>/32
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: codeblock}

3. ポリシーを適用します。
    - Linux:

      ```
      calicoctl apply -f filepath/blacklist.yaml
      ```
      {: pre}

    - Windows および OS X:

      ```
      calicoctl apply -f filepath/blacklist.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}
システムの IP アドレスがブラックリストに入りました。

4. メモの値を使用し、システムの IP がブラックリストにあるため、LoadBalancer IP にアクセスできないことをシステムから確認します。
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}
この時点で、パブリック NodePort へのすべてのトラフィックがブロックされ、パブリック LoadBalancer へのすべてのトラフィックが許可されます。ブラックリストに入れたシステム IP からの LoadBalancer へのトラフィックのみブロックされます。

5. ブラックリスト・ポリシーをクリーンアップするには、以下のようにします。
    ```
    calicoctl delete GlobalNetworkPolicy blacklist
    ```
    {: pre}

おつかれさまでした。 Calico Pre-DNAT ポリシーを使用してソース IP をホワイトリストとブラックリストに入れることにより、アプリへのトラフィックを正常に制御しました。

## 次の作業
{: #whats_next}

* [ネットワーク・ポリシーによるトラフィックの制御](cs_network_policy.html)をお読みください。
* クラスターのトラフィックを制御する Calico ネットワーク・ポリシーの例については、[Stars Policy Demo ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) と [advanced network policy ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) を参照してください。
