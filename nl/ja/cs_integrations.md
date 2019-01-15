---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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




# サービスの統合
{: #integrations}

{{site.data.keyword.containerlong}} の標準の Kubernetes クラスターでは、さまざまな外部サービスとカタログ・サービスを使用できます。
{:shortdesc}


## DevOps サービス
{: #devops_services}
<table summary="アクセシビリティーについての要約">
<caption>DevOps サービス</caption>
<thead>
<tr>
<th>サービス</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Codeship</td>
<td>コンテナーの継続的な統合とデリバリーのために <a href="https://codeship.com" target="_blank">Codeship <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用できます。 詳しくは、<a href="https://www.ibm.com/blogs/bluemix/2017/10/using-codeship-pro-deploy-workloads-ibm-container-service/" target="_blank">Using Codeship Pro To Deploy Workloads to {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> は Kubernetes パッケージ・マネージャーです。 新しい Helm チャートを作成するか、既存の Helm チャートを使用して、{{site.data.keyword.containerlong_notm}} クラスターで実行される複雑な Kubernetes アプリケーションの定義、インストール、アップグレードを行うことができます。 <p>詳しくは、[{{site.data.keyword.containerlong_notm}} での Helm のセットアップ](cs_integrations.html#helm)を参照してください。</p></td>
</tr>
<tr>
<td>{{site.data.keyword.contdelivery_full}}</td>
<td>アプリのビルドと Kubernetes クラスターへのコンテナーのデプロイメントを、ツールチェーンを使用して自動化します。 セットアップ情報については、<a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Deploy Kubernetes pods to the {{site.data.keyword.containerlong_notm}} using DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> というブログを参照してください。 </td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> は 、Kubernetes などのクラウド・オーケストレーション・プラットフォームでマイクロサービス・ネットワーク (別名、サービス・メッシュ) の接続、保護、管理、モニターを行うための方法を開発者に提供するオープン・ソース・サービスです。 このオープン・ソース・プロジェクトの詳細については、<a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">IBM が Istio を共同創設して立ち上げた経過 <img src="../icons/launch-glyph.svg" alt=" 外部リンク・アイコン"></a> に関するブログ投稿を参照してください。 {{site.data.keyword.containerlong_notm}} の Kubernetes クラスターに Istio をインストールしてサンプル・アプリの使用を開始するには、[Istio を使用したマイクロサービスの管理に関するチュートリアル](cs_tutorials_istio.html#istio_tutorial)を参照してください。</td>
</tr>
</tbody>
</table>

<br />



## サービスのロギングとモニタリング
{: #health_services}
<table summary="アクセシビリティーについての要約">
<caption>サービスのロギングとモニタリング</caption>
<thead>
<tr>
<th>サービス</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoScale</td>
<td><a href="https://www.newrelic.com/coscale" target="_blank">CoScale <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、ワーカー・ノード、コンテナー、レプリカ・セット、レプリケーション・コントローラー、サービスをモニターします。 詳しくは、<a href="https://www.ibm.com/blogs/bluemix/2017/06/monitoring-ibm-bluemix-container-service-coscale/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with CoScale <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>Datadog</td>
<td><a href="https://www.datadoghq.com/" target="_blank">Datadog <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、クラスターをモニターし、インフラストラクチャーとアプリケーションのパフォーマンス・メトリックを表示します。 詳しくは、<a href="https://www.ibm.com/blogs/bluemix/2017/07/monitoring-ibm-bluemix-container-service-datadog/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Datadog <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>{{site.data.keyword.cloudaccesstrailfull}}</td>
<td>Grafana を使用してログを分析し、クラスター内で実行された管理アクティビティーをモニターします。 このサービスについて詳しくは、[Activity Tracker](/docs/services/cloud-activity-tracker/index.html) の資料を参照してください。 追跡できるイベントのタイプについて詳しくは、[Activity Tracker イベント](cs_at_events.html)を参照してください。</td>
</tr>
<tr>
<td>{{site.data.keyword.loganalysisfull}}</td>
<td>{{site.data.keyword.loganalysisfull_notm}} を使用して、ログの収集、保存、検索の機能を拡張します。 詳しくは、<a href="../services/CloudLogAnalysis/containers/containers_kube_other_logs.html" target="_blank">クラスター・ログの自動収集の有効化 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>LogDNA をサード・パーティー・サービスとしてワーカー・ノードにデプロイし、ポッド・コンテナーのログを管理することで、ログ管理機能をクラスターに追加できます。詳しくは、[{{site.data.keyword.loganalysisfull_notm}} with LogDNA による Kubernetes クラスター・ログの管理](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube) を参照してください。</td>
</tr>
<tr>
<td>{{site.data.keyword.monitoringlong}}</td>
<td>{{site.data.keyword.monitoringlong_notm}} を使用してルールとアラートを定義して、メトリックの収集と保存の機能を拡張します。 詳しくは、<a href="../services/cloud-monitoring/tutorials/container_service_metrics.html" target="_blank">Kubernetes クラスターにデプロイされたアプリに関する Grafana でのメトリックの分析 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。</td>
</tr>
<tr>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>Sysdig をサード・パーティー・サービスとしてワーカー・ノードにデプロイし、メトリックを {{site.data.keyword.monitoringlong}} に転送することで、アプリのパフォーマンスと正常性を可視化して運用することができます。詳しくは、[Kubernetes クラスターにデプロイされたアプリのメトリックの分析方法](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster)を参照してください。**注**: Kubernetes バージョン 1.11 以降を実行するクラスターで {{site.data.keyword.mon_full_notm}} を使用する場合、Sysdig は現在 `containerd` をサポートしていないため、すべてのコンテナー・メトリックが収集されるわけではありません。</td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> は、アプリを自動的に検出してマップする GUI を使用して、インフラストラクチャーとアプリのパフォーマンス・モニターを提供します。 Istana はアプリに対するすべての要求をキャプチャーするので、その情報を使用してトラブルシューティングと根本原因分析を行い、問題の再発を防げるようになります。 詳しくは、<a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">{{site.data.keyword.containerlong_notm}} での Istana のデプロイ <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> に関するブログ投稿を参照してください。</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus は、特に Kubernetes のために設計された、モニタリング、ロギング、アラートのためのオープン・ソース・ツールです。 Prometheus は、Kubernetes のロギング情報に基づいて、クラスター、ワーカー・ノード、デプロイメントの正常性に関する詳細情報を取得します。 クラスターで実行されているコンテナーごとに、CPU、メモリー、I/O、ネットワーク・アクティビティーの情報が収集されます。 収集されたデータをカスタム・クエリーやアラートで使用して、クラスター内のパフォーマンスとワークロードをモニターできます。

<p>Prometheus を使用する場合は、<a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">CoreOS の説明 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> に従ってください。</p>
</td>
</tr>
<tr>
<td>Sematext</td>
<td><a href="https://sematext.com/" target="_blank">Sematext <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、コンテナー化アプリケーションのメトリックとログを表示します。 詳しくは、<a href="https://www.ibm.com/blogs/bluemix/2017/09/monitoring-logging-ibm-bluemix-container-service-sematext/" target="_blank">Monitoring and logging for containers with Sematext <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>Sysdig</td>
<td><a href="https://sysdig.com/" target="_blank">Sysdig <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、単一の計測ポイントでアプリ、コンテナー、statsd、ホストのメトリックをキャプチャーします。 詳しくは、<a href="https://www.ibm.com/blogs/bluemix/2017/08/monitoring-ibm-bluemix-container-service-sysdig-container-intelligence/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Sysdig Container Intelligence <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope は、Kubernetes クラスター内のリソース (サービス、ポッド、コンテナー、プロセス、ノードなど) のビジュアル図を表示します。 Weave Scope は CPU とメモリーのインタラクティブ・メトリックを示し、コンテナーの中で追尾したり実行したりするツールも備えています。<p>詳しくは、[Weave Scope と {{site.data.keyword.containerlong_notm}} での Kubernetes クラスター・リソースの視覚化](cs_integrations.html#weavescope)を参照してください。</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## セキュリティー・サービス
{: #security_services}

{{site.data.keyword.Bluemix_notm}} セキュリティー・サービスをクラスターと統合する方法の包括的な説明が必要ですか? [Apply end-to-end security to a cloud application チュートリアル](/docs/tutorials/cloud-e2e-security.html)を確認してください。
{: shortdesc}

<table summary="アクセシビリティーについての要約">
<caption>セキュリティー・サービス</caption>
<thead>
<tr>
<th>サービス</th>
<th>説明</th>
</tr>
</thead>
<tbody>
  <tr id="appid">
    <td>{{site.data.keyword.appid_full}}</td>
    <td>ユーザーに対してサインインを要求することにより、[{{site.data.keyword.appid_short}}](/docs/services/appid/index.html#gettingstarted) によって、アプリのセキュリティー・レベルを強化します。 アプリに対する Web または API の HTTP /HTTPS 要求を認証するために、[{{site.data.keyword.appid_short_notm}} 認証 Ingress アノテーション](cs_annotations.html#appid-auth)を使用して、{{site.data.keyword.appid_short_notm}} を Ingress サービスと統合できます。</td>
  </tr>
<tr>
<td>Aqua Security</td>
  <td><a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a> を補完するために、<a href="https://www.aquasec.com/" target="_blank">Aqua Security <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、アプリで実行できる動作を減らすことで、コンテナー・デプロイメントのセキュリティーを強化できます。 詳しくは、<a href="https://blog.aquasec.com/securing-container-deployments-on-bluemix-with-aqua-security" target="_blank">Securing container deployments on {{site.data.keyword.Bluemix_notm}} with Aqua Security <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>{{site.data.keyword.cloudcerts_full}}</td>
<td><a href="../services/certificate-manager/index.html" target="_blank">{{site.data.keyword.cloudcerts_long}} <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、アプリの SSL 証明書を保管および管理できます。 詳しくは、<a href="https://www.ibm.com/blogs/bluemix/2018/01/use-ibm-cloud-certificate-manager-ibm-cloud-container-service-deploy-custom-domain-tls-certificates/" target="_blank">Use {{site.data.keyword.cloudcerts_long_notm}} with {{site.data.keyword.containerlong_notm}} to deploy custom domain TLS Certificates <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
  <td>{{site.data.keyword.registrylong}}</td>
  <td>保護された独自の Docker イメージ・リポジトリーをセットアップします。そこでイメージを安全に保管し、クラスター・ユーザー間で共有することができます。 詳しくは、<a href="/docs/services/Registry/index.html" target="_blank">{{site.data.keyword.registrylong}} の資料 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。</td>
</tr>
<tr>
  <td>{{site.data.keyword.keymanagementservicefull}}</td>
  <td>{{site.data.keyword.keymanagementserviceshort}} を有効にして、クラスター内にある Kubernetes シークレットを暗号化します。 Kubernetes シークレットを暗号化すると、許可されていないユーザーがクラスターの機密情報にアクセスできなくなります。<br>セットアップするには、<a href="cs_encrypt.html#keyprotect">{{site.data.keyword.keymanagementserviceshort}} を使用した Kubernetes シークレットの暗号化</a>を参照してください。<br>詳しくは、<a href="/docs/services/key-protect/index.html#getting-started-with-key-protect" target="_blank">{{site.data.keyword.keymanagementserviceshort}} の資料 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。</td>
</tr>
<tr>
<td>NeuVector</td>
<td><a href="https://neuvector.com/" target="_blank">NeuVector <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、コンテナーをクラウド・ネイティブ・ファイアウォールによって保護します。 詳しくは、<a href="https://www.ibm.com/us-en/marketplace/neuvector-container-security" target="_blank">NeuVector Container Security <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>Twistlock</td>
<td><a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a> を補完するために、<a href="https://www.twistlock.com/" target="_blank">Twistlock <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、ファイアウォール、脅威防御、インシデント対応を管理できます。 詳しくは、<a href="https://www.ibm.com/blogs/bluemix/2017/07/twistlock-ibm-bluemix-container-service/" target="_blank">Twistlock on {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
</tbody>
</table>

<br />



## ストレージ・サービス
{: #storage_services}
<table summary="アクセシビリティーについての要約">
<caption>ストレージ・サービス</caption>
<thead>
<tr>
<th>サービス</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Heptio Ark</td>
  <td><a href="https://github.com/heptio/ark" target="_blank">Heptio Ark <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を使用して、クラスター・リソースと永続ボリュームのバックアップとリストアを実行できます。 詳しくは、Heptio Ark の <a href="https://github.com/heptio/ark/blob/release-0.9/docs/use-cases.md" target="_blank">Use cases for disaster recovery and cluster migration <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。</td>
</tr>
<tr>
  <td>{{site.data.keyword.cos_full}}</td>
  <td>{{site.data.keyword.cos_short}} で保管するデータは、暗号化され、複数の地理的ロケーションに分散され、REST API を使用して HTTP によってアクセスされます。 [ibm-backup-restore image](/docs/services/RegistryImages/ibm-backup-restore/index.html) を使用して、クラスターのデータの一回限りのバックアップ、またはスケジュールしたバックアップを実行するようにサービスを構成できます。 このサービスに関する一般情報については、<a href="/docs/services/cloud-object-storage/about-cos.html" target="_blank">{{site.data.keyword.cos_short}} の資料 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。</td>
</tr>
  <tr>
    <td>{{site.data.keyword.cloudantfull}}</td>
    <td>{{site.data.keyword.cloudant_short_notm}} は、データを JSON 形式の文書として保管する文書指向の DataBase as a Service (DBaaS) です。 このサービスは、スケーラビリティー、高可用性、耐久性を実現するように設計されています。 詳しくは、<a href="/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant" target="_blank">{{site.data.keyword.cloudant_short_notm}} の資料 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。</td>
  </tr>
  <tr>
    <td>{{site.data.keyword.composeForMongoDB_full}}</td>
    <td>{{site.data.keyword.composeForMongoDB}} は、高可用性と冗長性、自動およびオンデマンドのノンストップ・バックアップ、モニター・ツール、アラート・システムへの統合、パフォーマンス分析ビューなどを提供します。 詳しくは、<a href="/docs/services/ComposeForMongoDB/index.html#about-compose-for-mongodb" target="_blank">{{site.data.keyword.composeForMongoDB}} の資料 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。</td>
  </tr>
</tbody>
</table>


<br />



## {{site.data.keyword.Bluemix_notm}} サービスをクラスターに追加する
{: #adding_cluster}

{{site.data.keyword.Bluemix_notm}} サービスを追加して、Watson AI、データ、セキュリティー、モノのインターネット (IoT) などの領域の追加機能によって Kubernetes クラスターを拡張します。
{:shortdesc}

サービス・キーをサポートするサービスのみをバインドできます。サービス・キーをサポートするサービスのリストを確認するには、[{{site.data.keyword.Bluemix_notm}} サービスを使用するための外部アプリの使用可能化](/docs/resources/connect_external_app.html#externalapp)を参照してください。
{: note}

開始前に、以下のことを行います。
- 以下の役割があることを確認してください。
    - クラスターに対する[**エディター**または**管理者**の {{site.data.keyword.Bluemix_notm}} IAM サービス役割](cs_users.html#platform)。
    - 使用するスペースに対する[**開発者**の Cloud Foundry 役割](/docs/iam/mngcf.html#mngcf)。
- [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。

クラスターに {{site.data.keyword.Bluemix_notm}} サービスを追加するには、以下の手順を実行します。
1. [{{site.data.keyword.Bluemix_notm}} サービスのインスタンスを作成します](/docs/apps/reqnsi.html#req_instance)。
    * 一部の {{site.data.keyword.Bluemix_notm}} サービスは、選択された地域でのみ使用可能です。 サービスがクラスターと同じ地域で使用可能な場合にのみ、サービスをクラスターにバインドできます。 さらに、ワシントン DC ゾーンでサービス・インスタンスを作成する場合は、CLI を使用する必要があります。
    * クラスターと同じリソース・グループにサービス・インスタンスを作成する必要があります。 リソースは 1 つのリソース・グループにしか作成できず、その後にリソース・グループを変更することはできません。

2. 作成したサービスのタイプを確認し、サービス・インスタンスの**名前**をメモします。
   - **Cloud Foundry サービス:**
     ```
     ibmcloud service list
     ```
     {: pre}

     出力例:
     ```
     name                         service           plan    bound apps   last operation
     <cf_service_instance_name>   <service_name>    spark                create succeeded
     ```
     {: screen}

  - **{{site.data.keyword.Bluemix_notm}}IAM 対応サービス:**
     ```
     ibmcloud resource service-instances
     ```
     {: pre}

     出力例:
     ```
     Name                          Location   State    Type               Tags   
     <iam_service_instance_name>   <region>   active   service_instance      
     ```
     {: screen}

   ダッシュボードに異なるサービス・タイプが**「Cloud Foundry サービス」**および**「サービス」**として表示される場合もあります。

3. {{site.data.keyword.Bluemix_notm}} IAM 対応サービスの場合は、このサービスをクラスターにバインドできるように Cloud Foundry 別名を作成します。 サービスが既に Cloud Foundry サービスである場合、このステップは不要です。次のステップに進むことができます。
   1. Cloud Foundry の組織およびスペースをターゲットにします。
      ```
      ibmcloud target --cf
      ```
      {: pre}

   2. サービス・インスタンスの Cloud Foundry 別名を作成します。
      ```
      ibmcloud resource service-alias-create <service_alias_name> --instance-name <iam_service_instance_name>
      ```
      {: pre}

   3. サービス別名が作成されたことを確認します。
      ```
      ibmcloud service list
      ```
      {: pre}

4. サービスを追加するために使用するクラスターの名前空間を識別します。 次のいずれかのオプションを選択します。
     ```
     kubectl get namespaces
     ```
     {: pre}

5.  サービスをクラスターに追加します。 {{site.data.keyword.Bluemix_notm}} IAM 対応サービスの場合は、前に作成した Cloud Foundry 別名を使用します。
    ```
    ibmcloud ks cluster-service-bind <cluster_name_or_ID> <namespace> <service_instance_name>
    ```
    {: pre}

    サービスがクラスターに正常に追加されると、サービス・インスタンスの資格情報を保持するクラスター・シークレットが作成されます。 シークレットは、データを保護するために etcd では自動的に暗号化されます。

    出力例:
    ```
    ibmcloud ks cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace:	mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Kubernetes シークレットでサービス資格情報を確認します。
    1. シークレットの詳細を取得し、**binding** 値をメモします。 **binding** 値は base64 エンコードであり、サービス・インスタンスの資格情報を JSON 形式で保持します。
       ```
       kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
       ```
       {: pre}

       出力例:
       ```
       apiVersion: v1
       data:
         binding: <binding>
       kind: Secret
       metadata:
         annotations:
           service-instance-id: 1111aaaa-a1aa-1aa1-1a11-111aa111aa11
           service-key-id: 2b22bb2b-222b-2bb2-2b22-b22222bb2222
         creationTimestamp: 2018-08-07T20:47:14Z
         name: binding-<service_instance_name>
         namespace: <namespace>
         resourceVersion: "6145900"
         selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
         uid: 33333c33-3c33-33c3-cc33-cc33333333c
       type: Opaque
       ```
       {: screen}

    2. binding 値をデコードします
       ```
       echo "<binding>" | base64 -D
       ```
       {: pre}

       出力例:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    3. オプション: 前のステップでデコードしたサービス資格情報を、{{site.data.keyword.Bluemix_notm}} ダッシュボードのサービス・インスタンスで検索したサービス資格情報と比較します。

7. これでサービスがクラスターにバインドされたため、[Kubernetes シークレットのサービス資格情報にアクセスする](#adding_app)ために、アプリを構成する必要があります。


## アプリからのサービス資格情報へのアクセス
{: #adding_app}

アプリから {{site.data.keyword.Bluemix_notm}} サービス・インスタンスにアクセスするには、Kubernetes シークレットに保管されているサービス資格情報をアプリで使用可能にする必要があります。
{: shortdesc}

サービス・インスタンスの資格情報は base64 エンコードであり、JSON 形式でシークレットの内部に保管されます。 シークレットにあるデータにアクセスするには、次のオプションの中から選択します。
- [シークレットをボリュームとしてポッドにマウントする](#mount_secret)
- [環境変数でシークレットを参照する](#reference_secret)
<br>
シークレットをさらに保護したいですか? クラスター管理者に連絡してクラスター内の [{{site.data.keyword.keymanagementservicefull}} を有効にして](cs_encrypt.html#keyprotect)もらい、{{site.data.keyword.Bluemix_notm}} サービス・インスタンスの資格情報を保管するシークレットなどの、新しいシークレットと既存のシークレットを暗号化します。
{: tip}

始める前に
- [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。
- [{{site.data.keyword.Bluemix_notm}} サービスをクラスターに追加します](#adding_cluster)。

### シークレットをボリュームとしてポッドにマウントする
{: #mount_secret}

シークレットをボリュームとしてポッドにマウントすると、`binding` という名前のファイルがボリューム・マウント・ディレクトリーに保管されます。 JSON 形式の `binding` ファイルには、{{site.data.keyword.Bluemix_notm}} サービスにアクセスするために必要なすべての情報と資格情報が格納されます。
{: shortdesc}

1.  クラスター内の使用可能なシークレットをリストし、シークレットの **name** をメモします。 **Opaque** タイプのシークレットを探します。 複数のシークレットが存在する場合は、クラスター管理者に連絡して、サービスに対応する正しいシークレットを確認してください。

    ```
    kubectl get secrets
    ```
    {: pre}

    出力例:

    ```
    NAME                              TYPE            DATA      AGE
    binding-<service_instance_name>   Opaque          1         3m

    ```
    {: screen}

2.  Kubernetes デプロイメントの YAML ファイルを作成し、シークレットをボリュームとしてポッドにマウントします。
    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: registry.bluemix.net/ibmliberty:latest
            name: secret-test
            volumeMounts:
            - mountPath: <mount_path>
              name: <volume_name>
          volumes:
          - name: <volume_name>
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <caption>YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts.mountPath</code></td>
    <td>コンテナー内でボリュームがマウントされるディレクトリーの絶対パス。</td>
    </tr>
    <tr>
    <td><code>volumeMounts.name</code></br><code>volumes.name</code></td>
    <td>ポッドにマウントするボリュームの名前。</td>
    </tr>
    <tr>
    <td><code>secret.defaultMode</code></td>
    <td>シークレットに対する読み取りおよび書き込みアクセス権。 読み取り専用アクセス権を設定するには、`420` を使用します。 </td>
    </tr>
    <tr>
    <td><code>secret.secretName</code></td>
    <td>前のステップでメモしたシークレットの名前。</td>
    </tr></tbody></table>

3.  ポッドを作成して、シークレットをボリュームとしてマウントします。
    ```
    kubectl apply -f secret-test.yaml
    ```
    {: pre}

4.  ポッドが作成されたことを確認します。
    ```
    kubectl get pods
    ```
    {: pre}

    CLI 出力例:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

5.  サービス資格情報にアクセスします。
    1. ポッドにログインします。
       ```
       kubectl exec <pod_name> -it bash
       ```
       {: pre}

    2. 先ほど定義したボリューム・マウント・パスにナビゲートし、ボリューム・マウント・パスのファイルをリストします。
       ```
       cd <volume_mountpath> && ls
       ```
       {: pre}

       出力例:
       ```
       バインド
       ```
       {: screen}

       `binding` ファイルには、Kubernetes シークレットに保管したサービス資格情報が含まれています。

    4. サービス資格情報を表示します。 資格情報は、JSON 形式でキー値ペアとして保管されています。
       ```
       cat binding
       ```
       {: pre}

       出力例:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    5. JSON コンテンツを解析してサービスにアクセスするために必要な情報を取得するようにアプリを構成します。


### 環境変数でシークレットを参照する
{: #reference_secret}

Kubernetes シークレットのサービス資格情報およびその他のキー値ペアを、環境変数としてデプロイメントに追加できます。   
{: shortdesc}

1. クラスター内の使用可能なシークレットをリストし、シークレットの **name** をメモします。 **Opaque** タイプのシークレットを探します。 複数のシークレットが存在する場合は、クラスター管理者に連絡して、サービスに対応する正しいシークレットを確認してください。

    ```
    kubectl get secrets
    ```
    {: pre}

    出力例:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m
    ```
    {: screen}

2. シークレットの詳細を入手して、ポッドで環境変数として参照できる潜在的なキー値ペアを検索します。 サービス資格情報は、シークレットの `binding` キーに保管されています。
   ```
   kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
   ```
   {: pre}

   出力例:
   ```
   apiVersion: v1
   data:
     binding: <binding>
   kind: Secret
   metadata:
     annotations:
       service-instance-id: 7123acde-c3ef-4ba2-8c52-439ac007fa70
       service-key-id: 9h30dh8a-023f-4cf4-9d96-d12345ec7890
     creationTimestamp: 2018-08-07T20:47:14Z
     name: binding-<service_instance_name>
     namespace: <namespace>
     resourceVersion: "6145900"
     selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
     uid: 12345a31-9a83-11e8-ba83-cd49014748f
   type: Opaque
   ```
   {: screen}

3. Kubernetes デプロイメントの YAML ファイルを作成し、`binding` キーを参照する環境変数を指定します。
   ```
   apiVersion: apps/v1beta1
   kind: Deployment
   metadata:
     labels:
       app: secret-test
     name: secret-test
     namespace: <my_namespace>
   spec:
     selector:
       matchLabels:
         app: secret-test
     template:
       metadata:
         labels:
           app: secret-test
       spec:
         containers:
         - image: registry.bluemix.net/ibmliberty:latest
           name: secret-test
           env:
           - name: BINDING
             valueFrom:
               secretKeyRef:
                 name: binding-<service_instance_name>
                 key: binding
     ```
     {: codeblock}

     <table>
     <caption>YAML ファイルの構成要素について</caption>
     <thead>
     <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
     </thead>
     <tbody>
     <tr>
     <td><code>containers.env.name</code></td>
     <td>環境変数の名前。</td>
     </tr>
     <tr>
     <td><code>env.valueFrom.secretKeyRef.name</code></td>
     <td>前のステップでメモしたシークレットの名前。</td>
     </tr>
     <tr>
     <td><code>env.valueFrom.secretKeyRef.key</code></td>
     <td>シークレットの一部であり、環境変数で参照するキー。 サービス資格情報を参照するには、<strong>binding</strong> キーを使用する必要があります。  </td>
     </tr>
     </tbody></table>

4. シークレットの `binding` キーを環境変数として参照するポッドを作成します。
   ```
   kubectl apply -f secret-test.yaml
   ```
   {: pre}

5. ポッドが作成されたことを確認します。
   ```
   kubectl get pods
   ```
   {: pre}

   CLI 出力例:
   ```
   NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
   ```
   {: screen}

6. 環境変数が正しく設定されていることを確認します。
   1. ポッドにログインします。
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   2. すべての環境変数をポッド内にリストします。
      ```
      env
      ```
      {: pre}

      出力例:
      ```
      BINDING={"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
      ```
      {: screen}

7. 環境変数を読み取り、JSON コンテンツを解析してサービスにアクセスするために必要な情報を取得するようにアプリを構成します。

   Python のコード例:
   ```
   if os.environ.get('BINDING'):
        credentials = json.loads(os.environ.get('BINDING'))
   ```
   {: codeblock}

## {{site.data.keyword.containerlong_notm}} での Helm のセットアップ
{: #helm}

[Helm ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://helm.sh) は Kubernetes パッケージ・マネージャーです。 Helm チャートを作成するか、既存の Helm チャートを使用して、{{site.data.keyword.containerlong_notm}} クラスターで実行される複雑な Kubernetes アプリケーションの定義、インストール、アップグレードを行うことができます。
{:shortdesc}

Helm チャートを {{site.data.keyword.containerlong_notm}} で使用する前に、クラスターに Helm インスタンスをインストールして初期化する必要があります。 その後、{{site.data.keyword.Bluemix_notm}} Helm リポジトリーを Helm インスタンスに追加できます。

開始前に、以下のことを行います。 [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。

1. <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> をインストールします。

2. **重要**: クラスターのセキュリティーを維持するため、[{{site.data.keyword.Bluemix_notm}} `kube-samples` リポジトリー](https://github.com/IBM-Cloud/kube-samples/blob/master/rbac/serviceaccount-tiller.yaml)から以下の `.yaml` ファイルを適用することによって、Tiller のサービス・アカウントを `kube-system` 名前空間に作成し、`tiller-deploy` ポッドに対する Kubernetes RBAC クラスター役割バインディングを作成します。 **注**: `kube-system` 名前空間のサービス・アカウントとクラスター役割バインディングを使用して Tiller をインストールするには、[`cluster-admin` 役割](cs_users.html#access_policies)が必要です。
    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/rbac/serviceaccount-tiller.yaml
    ```
    {: pre}

3. 作成したサービス・アカウントを使用して、Helm を初期化し、`tiller` をインストールします。

    ```
    helm init --service-account tiller
    ```
    {: pre}

4. クラスター内の `tiller-deploy` ポッドの**「状況」**が`「実行中」`になっていることを確認します。

    ```
    kubectl get pods -n kube-system -l app=helm
    ```
    {: pre}

    出力例:

    ```
    NAME                            READY     STATUS    RESTARTS   AGE
    tiller-deploy-352283156-nzbcm   1/1       Running   0          2m
    ```
    {: screen}

5. {{site.data.keyword.Bluemix_notm}} Helm リポジトリーを Helm インスタンスに追加します。

    ```
    helm repo add ibm  https://registry.bluemix.net/helm/ibm
    ```
    {: pre}

    ```
    helm repo add ibm-charts https://registry.bluemix.net/helm/ibm-charts
    ```
    {: pre}

6. {{site.data.keyword.Bluemix_notm}} リポジトリーで現在使用可能な Helm チャートをリストします。

    ```
    helm search ibm
    ```
    {: pre}

    ```
    helm search ibm-charts
    ```
    {: pre}

7. チャートの詳細を確認するには、その設定とデフォルト値をリストします。

    例えば、strongSwan IPSec VPN サービス Helm チャートの設定、文書、デフォルト値を確認するには、次のようにします。

    ```
    helm inspect ibm/strongswan
    ```
    {: pre}


### Helm の関連リンク
{: #helm_links}

* strongSwan Helm チャートを使用するには、[strongSwan IPSec VPN サービスの Helm Chart を使用した VPN 接続のセットアップ](cs_vpn.html#vpn-setup)を参照してください。
* コンソールの [Helm チャートのカタログ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts) で、{{site.data.keyword.Bluemix_notm}} で使用可能な Helm チャートを確認します。
* Helm チャートのセットアップと管理に使用する Helm コマンドについて詳しくは、<a href="https://docs.helm.sh/helm/" target="_blank">Helm の資料 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。
* Kubernetes Helm チャートを使用して開発速度を上げる方法について詳しくは、[こちら ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/) を参照してください。

## Kubernetes クラスター・リソースの視覚化
{: #weavescope}

Weave Scope は、Kubernetes クラスター内のリソース (サービス、ポッド、コンテナーなど) のビジュアル図を表示します。 Weave Scope には、CPU とメモリーのインタラクティブ・メトリックと、コンテナーの中で追跡したり実行したりできるツールが備わっています。
{:shortdesc}

開始前に、以下のことを行います。

-   クラスター情報を公共のインターネットに公開しないようにしてください。 安全に Weave Scope をデプロイして Web ブラウザーからローカル・アクセスするには、以下の手順を実行します。
-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_clusters.html#clusters_ui)。 Weave Scope は、アプリでは特に、CPU の負荷が大きくなります。 フリー・クラスターではなく、比較的大規模な標準クラスターで Weave Scope を実行してください。
-   [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。


Weave Scope をクラスターで使用するには、以下のようにします。
2.  提供された RBAC 許可構成ファイルをクラスターにデプロイします。

    読み取り/書き込みアクセス権を有効にするには、以下のようにします。

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    読み取り専用アクセス権を有効にするには、以下のようにします。

    ```
    kubectl apply --namespace weave -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    出力:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Weave Scope サービスをデプロイします。このサービスは、クラスター IP アドレスでのプライベート・アクセスが可能です。

    <pre class="pre">
    <code>kubectl apply --namespace weave -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    出力:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  ポート転送コマンドを実行して、コンピューター上でサービスを開きます。 次回 Weave Scope にアクセスする時は、上記の構成ステップを再度実行する必要はなく、次のポート転送コマンドを実行することができます。

    ```
    kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    出力:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]: :1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Web ブラウザーで `http://localhost:4040` を開きます。 デフォルトのコンポーネントをデプロイしないと、次の図が表示されます。 クラスター内の Kubernetes リソースのトポロジー・ダイアグラムまたはテーブルを表示するように選択できます。

     <img src="images/weave_scope.png" alt="Weave Scope のトポロジーの例" style="width:357px;" />


[Weave Scope の機能についての詳細 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.weave.works/docs/scope/latest/features/)。

<br />

