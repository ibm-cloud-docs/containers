---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-19"

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
{:preview: .preview}

# チュートリアルの概要
{: #tutorials-ov}

<style>
<!--
    #tutorials { /* hide the page header */
        display: none !important
    }
    .allCategories {
        display: flex !important;
        flex-direction: row !important;
        flex-wrap: wrap !important;
    }
    .solutionBoxContainer {}
    .solutionBoxContainer a {
        text-decoration: none !important;
        border: none !important;
    }
    .solutionBox {
        display: inline-block !important;
        width: 600px !important;
        margin: 0 10px 20px 0 !important;
        padding: 10px !important;
        border: 1px #dfe6eb solid !important;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2) !important;
    }
    @media screen and (min-width: 960px) {
        .solutionBox {
        width: 27% !important;
        }
        .solutionBoxContent {
        height: 320px !important;
        }
    }
    @media screen and (min-width: 1298px) {
        .solutionBox {
        width: calc(33% - 2%) !important;
        }
        .solutionBoxContent {
        min-height: 320px !important;
        }
    }
    .solutionBox:hover {
        border-color: rgb(136, 151, 162) !important;
    }
    .solutionBoxContent {
        display: flex !important;
        flex-direction: column !important;
    }
    .solutionBoxDescription {
        flex-grow: 1 !important;
        display: flex !important;
        flex-direction: column !important;
    }
    .descriptionContainer {
    }
    .descriptionContainer p {
        margin: 2px !important;
        overflow: hidden !important;
        display: -webkit-box !important;
        -webkit-line-clamp: 4 !important;
        -webkit-box-orient: vertical !important;
        font-size: 12px !important;
        font-weight: 400 !important;
        line-height: 1.5 !important;
        letter-spacing: 0 !important;
        max-height: 70px !important;
    }
    .architectureDiagramContainer {
        flex-grow: 1 !important;
        min-width: 200px !important;
        padding: 0 10px !important;
        text-align: center !important;
        display: flex !important;
        flex-direction: column !important;
        justify-content: center !important;
    }
    .architectureDiagram {
        max-height: 170px !important;
        padding: 5px !important;
        margin: 0 auto !important;
    }
-->
</style>


## クラスターの作成と最初のアプリのデプロイ
{: #tutorials-create-cluster-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cs_cluster_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Ubuntu 上の Kubernetes ネイティブ・クラスター
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Ubuntu オペレーティング・システムを実行するクラシック・インフラストラクチャー・ワーカー・ノードを使用して管理対象 {{site.data.keyword.containerlong_notm}} 上に Kubernetes クラスターを作成します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/tutorial_ov.png" alt="Kubernetes クラスターの作成のソリューションのアーキテクチャー図" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/containers?topic=containers-openshift_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Red Hat OpenShift クラスター
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>OpenShift コンテナー・オーケストレーション・プラットフォーム・ソフトウェアとともにインストールされるワーカー・ノードを含む {{site.data.keyword.containerlong_notm}} クラスターを作成します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_org_ov_both_ses_rhos.png" alt="アーキテクチャー RHOS" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## クラスターへのアプリのデプロイ 
{: #tutorials-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-scalable-webapp-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Kubernetes のスケーラブルな Web アプリケーション
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Web アプリをスキャフォールドし、クラスターにデプロイし、アプリをスケーリングしてその正常性をモニターする方法について説明します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution2/Architecture.png" alt="{{site.data.keyword.containerlong_notm}} を使用した Web アプリのデプロイのアーキテクチャー図" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/logistics-wizard-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Kubernetes と Cloud Foundry アプリの実行
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>ERP サービスと Controller サービスが Kubernetes にデプロイされ、Web ユーザー・インターフェースが Cloud Foundry アプリとしてデプロイされた、Logistics Wizard デプロイメントを作成します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/logistics-wizard-kubernetes/master/lw_kube_architecture.png" alt="Logistics Wizard アーキテクチャーの概要" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-pub-sub-object-storage#pub-sub-object-storage">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                アプリの非同期データ処理
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Apache Kafka ベースのメッセージング・サービスを使用して、Kubernetes クラスターで実行されるアプリの実行時間が長いワークロードをオーケストレーションします。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution25/Architecture.png" alt="非同期データ処理アーキテクチャー" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## 高可用性とセキュリティーのセットアップ
{: #tutorials-ov-ha-network-security}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-multi-region-k8s-cis#multi-region-k8s-cis">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Cloud Internet Services による耐障害性のあるセキュアな複数地域クラスター
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Cloud Internet Services を Kubernetes クラスターに統合し、複数の {{site.data.keyword.cloud_notm}} 地域において耐障害性のあるセキュアなソリューションを提供します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution32-multi-region-k8s-cis/Architecture.png" alt="CloudInternet Service の {{site.data.keyword.containerlong_notm}}" /> との使用のアーキテクチャー図               </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-strategies-for-resilient-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                クラウドの耐障害性のあるアプリケーションのための戦略
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>クラウドで耐障害性のあるアプリを作成する際の考慮事項と、使用できる {{site.data.keyword.cloud_notm}} サービスについて説明します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution39/Architecture.png" alt="耐障害性のあるアプリケーションの作成のアーキテクチャー図" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-policy_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Calico ポリシーによる不要なネットワーク・トラフィックのブロック
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Calico ポリシーを使用して、特定の IP アドレスとのネットワーク・トラフィックをホワイトリストまたはブラックリストに登録する方法を説明します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_tutorial_policies_L4.png" alt="Calico ネットワーク・ポリシーを使用して着信ネットワーク・トラフィックをブロックする" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-istio">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Istio によるマイクロサービス・ネットワークの保護、管理、およびモニター
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>クラウドでマイクロサービスを制御および保護するための Istio の高度なルーティングとモニタリングの機能について詳しく説明します。 </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/istio_ov.png" alt="Istio のコンポーネントと従属関係の概要" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-cloud-e2e-security#cloud-e2e-security">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                {{site.data.keyword.cloud_notm}} アプリへのエンドツーエンド・セキュリティーの適用
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>認証と暗号化を使用してアプリを保護する方法と、クラスター・アクティビティーをモニターおよび監査する方法について説明します。 </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://github.com/IBM-Bluemix-Docs/tutorials/blob/master/images/solution34-cloud-e2e-security/Architecture.png?raw=true" alt="クラウドのアプリへのエンドツーエンド・セキュリティーの適用のアーキテクチャー図" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-users-teams-applications#users-teams-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                {{site.data.keyword.cloud_notm}} の IAM (ID およびアクセス管理) を使用したユーザーとチームの編成
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>ユーザーとチームのクラスター・アクセスをセットアップし、このセットアップを複数の環境に複製する方法について説明します。 </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution20-users-teams-applications/architecture.png" alt="ユーザーとチームの編成のアーキテクチャー図" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>



## アプリとクラスターのデプロイメントの自動化
{: #tutorials-ov-app-cluster-deployments}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Knative サービスを使用したサーバーレス・アプリのデプロイ
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>最新のソース中心のコンテナー化されたサーバーレス・アプリを Kubernetes クラスター上に作成します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/knative_ov.png" alt="Knative のコンポーネントと従属関係の概要" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Kubernetes クラスターへの継続的デプロイメント
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Kubernetes で実行されるコンテナー化アプリの DevOps パイプラインをセットアップし、セキュリティー・スキャナー、Salck 通知、分析などの統合を追加します。  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution21/Architecture.png" alt="継続的デリバリーと継続的統合のパイプラインのセットアップのアーキテクチャー図" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/razee-io/Razee">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Razee を使用したマルチクラスター・デプロイメントの自動化
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Razee を使用して、クラスター、環境、クラウド・プロバイダーにおいて Kubernetes リソースのデプロイメントを自動化、管理、および視覚化します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/razee_ov_no_txt.png" alt="Razee によるデプロイメントの自動化のアーキテクチャー" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## クラスター・アクティビティーのモニターとログ記録
{: #tutorials-ov-monitor-log}

<div class = "solutionBoxContainer">
    <a href = "/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-kube#kube">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                {{site.data.keyword.la_full_notm}} による Kubernetes クラスター・ログの管理
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>{{site.data.keyword.la_full_notm}} を使用して、クラスター内にロギング・エージェントを構成し、各種ログ・ソースをモニターします。 </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Log-Analysis-with-LogDNA/master/images/kube.png" alt="LogDNA のアーキテクチャーの概要" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/services/Monitoring-with-Sysdig?topic=Sysdig-kubernetes_cluster#kubernetes_cluster">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                {{site.data.keyword.mon_full_notm}} を使用したクラスター・メトリックの分析
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>クラスター内に Sysdig メトリック・エージェントをセットアップし、クラスターの正常性をモニターする方法について詳しく説明します。  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Monitoring-with-Sysdig/master/images/kube.png" alt="Sysdig のアーキテクチャーの概要" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## クラウドへのアプリのマイグレーション 
{: #tutorials-ov-migrate-apps}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cf_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Cloud Foundry アプリのコンテナー化
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Python Cloud Foundry アプリから Docker イメージを作成し、そのイメージを {{site.data.keyword.registryshort_notm}} にプッシュし、アプリを Kubernetes クラスターにデプロイする方法について説明します。  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/python_flask.png" alt="Python hello world のウェルカム画面" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/tutorials?topic=solution-tutorials-vm-to-containers-and-kubernetes#move-a-vm-based-application-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                VM ベース・アプリのマイグレーション
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>アプリ・コードを準備し、VM ベース・アプリをコンテナー化し、そのアプリを Kubernetes クラスターにデプロイします。  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution30/modern_architecture.png" alt="VM ベース・アプリの Kubernetes へのマイグレーション" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/jpetstore-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Java Web アプリの最新化
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>JPetStore アプリをコンテナー化し、Watson Visual Recognition と Twilio テキスト・メッセージングを使用して拡張します。</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/jpetstore-kubernetes/master/readme_images/architecture.png" alt="Java Web アプリの最新化と拡張" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>
