---

copyright:
  years: 2017, 2018
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


# {{site.data.keyword.cloudaccesstrailshort}} events
{: #at_events}

{{site.data.keyword.cloudaccesstrailshort}} サービスを使用して、{{site.data.keyword.containerlong_notm}} クラスター内でユーザーによって開始されたアクティビティーを表示、管理、および監査することができます。
{: shortdesc}



サービスの仕組みについて詳しくは、[{{site.data.keyword.cloudaccesstrailshort}} の資料](/docs/services/cloud-activity-tracker/index.html)を参照してください。追跡される Kubernetes アクションの詳細については、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/home/) を参照してください。


## Kubernetes 監査イベントの情報の検索
{: #kube-find}

{{site.data.keyword.cloudaccesstrailshort}} イベントは、イベントが生成される {{site.data.keyword.Bluemix_notm}} 地域内にある {{site.data.keyword.cloudaccesstrailshort}} **アカウント・ドメイン**で使用可能です。 {{site.data.keyword.cloudaccesstrailshort}} イベントは、{{site.data.keyword.cloudaccesstrailshort}} サービスがプロビジョンされている Cloud Foundry スペースに関連付けられている {{site.data.keyword.cloudaccesstrailshort}} **スペース・ドメイン** で使用可能です。

管理アクティビティーをモニターするには、次の手順を実行します。

1. {{site.data.keyword.Bluemix_notm}} アカウントにログインします。
2. カタログから、{{site.data.keyword.containerlong_notm}} のインスタンスと同じアカウントで、{{site.data.keyword.cloudaccesstrailshort}} サービスのインスタンスをプロビジョンします。
3. {{site.data.keyword.cloudaccesstrailshort}} ダッシュボードの **「管理」** タブで、**「Kibana で表示」**をクリックします。
4. ログを表示する時間フレームを設定します。 デフォルトは 15 分です。
5. **「使用可能なフィールド」**リストで、**「タイプ」**をクリックします。 **アクティビティー・トラッカー**の虫眼鏡のアイコンをクリックして、サービスによって追跡されるもののみにログを制限します。
6. その他の使用可能なフィールドを使用して、検索を絞り込むことができます。

他のユーザーがアカウントとスペースのイベントを表示できるようにするには、[Granting permissions to see account events](/docs/services/cloud-activity-tracker/how-to/grant_permissions.html#grant_permissions) を参照してください。
{: tip}

## Kubernetes 監査イベントの追跡
{: #kube-events}

{{site.data.keyword.cloudaccesstrailshort}} に送信されるイベントのリストについては、以下の表を確認してください。
{: shortdesc}

**始める前に**

[Kubernetes API 監査イベント](cs_health.html#api_forward)を転送するようにクラスターが構成されていることを確認してください。

**転送されるイベント**

<table>
  <tr>
    <th>アクション</th>
    <th>説明</th>
  </tr>
  <tr>
    <td><code>bindings.create</code></td>
    <td>バインディングが作成されました。</td>
  </tr>
  <tr>
    <td><code>configmaps.create</code></td>
    <td>構成マップが作成されました。</td>
  </tr>
  <tr>
    <td><code>configmaps.delete</code></td>
    <td>構成マップは削除されました。</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>構成マップにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>configmaps.update</code></td>
    <td>構成マップが更新されました。</td>
  </tr>
  <tr>
    <td><code>events.create</code></td>
    <td>イベントが作成されました。</td>
  </tr>
  <tr>
    <td><code>events.delete</code></td>
    <td>イベントが削除されました。</td>
  </tr>
  <tr>
    <td><code>events.patch</code></td>
    <td>イベントにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>events.update</code></td>
    <td>イベントが更新されました。</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>範囲制限が作成されました。</td>
  </tr>
  <tr>
    <td><code>limitranges.delete</code></td>
    <td>範囲制限が削除されました。</td>
  </tr>
  <tr>
    <td><code>limitranges.patch</code></td>
    <td>範囲制限にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>limitranges.update</code></td>
    <td>範囲制限が更新されました。</td>
  </tr>
  <tr>
    <td><code>namespaces.create</code></td>
    <td>名前空間が作成されました。</td>
  </tr>
  <tr>
    <td><code>namespaces.delete</code></td>
    <td>名前空間が削除されました。</td>
  </tr>
  <tr>
    <td><code>namespaces.patch</code></td>
    <td>名前空間にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>名前空間が更新されました。</td>
  </tr>
  <tr>
    <td><code>nodes.create</code></td>
    <td>ノードが作成されます。</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>ノードが削除されました。</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>ノードが削除されました。</td>
  </tr>
  <tr>
    <td><code>nodes.patch</code></td>
    <td>ノードにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>ノードが更新されました。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.create</code></td>
    <td>永続ボリューム請求が作成されました。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.delete</code></td>
    <td>永続ボリューム請求が削除されました。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.patch</code></td>
    <td>永続ボリューム請求にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.update</code></td>
    <td>永続ボリューム請求が更新されました。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.create</code></td>
    <td>永続ボリュームが作成されました。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.delete</code></td>
    <td>永続ボリュームが削除されました。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.patch</code></td>
    <td>永続ボリュームにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.update</code></td>
    <td>永続ボリュームが更新されました。</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>ポッドが作成されました。</td>
  </tr>
  <tr>
    <td><code>pods.delete</code></td>
    <td>ポッドが削除されました。</td>
  </tr>
  <tr>
    <td><code>pods.patch</code></td>
    <td>ポッドにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>pods.update</code></td>
    <td>ポッドが更新されました。</td>
  </tr>
  <tr>
    <td><code>podtemplates.create</code></td>
    <td>ポッド・テンプレートが作成されました。</td>
  </tr>
  <tr>
    <td><code>podtemplates.delete</code></td>
    <td>ポッド・テンプレートが削除されました。</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>ポッド・テンプレートにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>podtemplates.update</code></td>
    <td>ポッド・テンプレートが更新されました。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.create</code></td>
    <td>レプリケーション・コントローラーが作成されました。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.delete</code></td>
    <td>レプリケーション・コントローラーが削除されました。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.patch</code></td>
    <td>レプリケーション・コントローラーにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.update</code></td>
    <td>レプリケーション・コントローラーが更新されました。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.create</code></td>
    <td>リソース割り当て量が作成されました。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.delete</code></td>
    <td>リソース割り当て量が削除されました。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.patch</code></td>
    <td>リソース割り当て量にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.update</code></td>
    <td>リソース割り当て量が更新されました。</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>シークレットが作成されました。</td>
  </tr>
  <tr>
    <td><code>secrets.deleted</code></td>
    <td>シークレットが削除されました。</td>
  </tr>
  <tr>
    <td><code>secrets.get</code></td>
    <td>シークレットが表示されました。</td>
  </tr>
  <tr>
    <td><code>secrets.patch</code></td>
    <td>シークレットにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>secrets.updated</code></td>
    <td>シークレットが更新されました。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>サービス・アカウントが作成されました。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.deleted</code></td>
    <td>サービス・アカウントが削除されました。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.patch</code></td>
    <td>サービス・アカウントにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.updated</code></td>
    <td>サービス・アカウントが更新されました。</td>
  </tr>
  <tr>
    <td><code>services.create</code></td>
    <td>サービスが作成されました。</td>
  </tr>
  <tr>
    <td><code>services.deleted</code></td>
    <td>サービスが削除されました。</td>
  </tr>
  <tr>
    <td><code>services.patch</code></td>
    <td>サービスにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>サービスが更新されました。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.create</code></td>
    <td>Kubernetes v1.9 以降で、可変 Web フック構成が作成されました。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.delete</code></td>
    <td>Kubernetes v1.9 以降で、可変 Web フック構成が削除されました。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.patch</code></td>
    <td>Kubernetes v1.9 以降で、可変 Web フック構成にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.update</code></td>
    <td>Kubernetes v1.9 以降で、可変 Web フック構成が更新されました。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.create</code></td>
    <td>Kubernetes v1.9 以降で、Web フック構成の検証が作成されました。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.delete</code></td>
    <td>Kubernetes v1.9 以降で、Web フック構成の検証が削除されました。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.patch</code></td>
    <td>Kubernetes v1.9 以降で、Web フック構成の検証にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.update</code></td>
    <td>Kubernetes v1.9 以降で、Web フック構成の検証が更新されました。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>Kubernetes v1.8 で、外部アドミッション・フック構成が作成されました。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.delete</code></td>
    <td>Kubernetes v1.8 で、外部アドミッション・フック構成が削除されました。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.patch</code></td>
    <td>Kubernetes v1.8 で、外部アドミッション・フック構成にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.update</code></td>
    <td>Kubernetes v1.8 で、外部アドミッション・フック構成が更新されました。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.create</code></td>
    <td>コントローラー・リビジョンが作成されました。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.delete</code></td>
    <td>コントローラー・リビジョンが削除されました。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.patch</code></td>
    <td>コントローラー・リビジョンにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.update</code></td>
    <td>コントローラー・リビジョンにパッチが更新されました。</td>
  </tr>
  <tr>
    <td><code>daemonsets.create</code></td>
    <td>デーモン・セットが作成されました。</td>
  </tr>
  <tr>
    <td><code>daemonsets.delete</code></td>
    <td>デーモン・セットが削除されました。</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>デーモン・セットにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>daemonsets.update</code></td>
    <td>デーモン・セットが更新されました。</td>
  </tr>
  <tr>
    <td><code>deployments.create</code></td>
    <td>デプロイメントが作成されました。</td>
  </tr>
  <tr>
    <td><code>deployments.delete</code></td>
    <td>デプロイメントが削除されました。</td>
  </tr>
  <tr>
    <td><code>deployments.patch</code></td>
    <td>デプロイメントにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>deployments.update</code></td>
    <td>デプロイメントが更新されました。</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>レプリカ・セットが作成されました。</td>
  </tr>
  <tr>
    <td><code>replicasets.delete</code></td>
    <td>レプリカ・セットが削除されました。</td>
  </tr>
  <tr>
    <td><code>replicasets.patch</code></td>
    <td>レプリカ・セットにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>replicasets.update</code></td>
    <td>レプリカ・セットが更新されました。</td>
  </tr>
  <tr>
    <td><code>statefulsets.create</code></td>
    <td>ステートフル・セットが作成されました。</td>
  </tr>
  <tr>
    <td><code>statefulsets.delete</code></td>
    <td>ステートフル・セットが削除されました。</td>
  </tr>
  <tr>
    <td><code>statefulsets.patch</code></td>
    <td>ステートフル・セットにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>statefulsets.update</code></td>
    <td>ステートフル・セットが更新されました。</td>
  </tr>
  <tr>
    <td><code>tokenreviews.create</code></td>
    <td>トークン・レビューが作成されました。</td>
  </tr>
  <tr>
    <td><code>localsubjectaccessreviews.create</code></td>
    <td>ローカル件名アクセス・レビューが作成されました。</td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>セルフ件名アクセス・レビューが作成されました。</td>
  </tr>
  <tr>
    <td><code>selfsubjectrulesreviews.create</code></td>
    <td>セルフ件名ルール・レビューが作成されました。</td>
  </tr>
  <tr>
    <td><code>subjectaccessreviews.create</code></td>
    <td>件名アクセス・レビューが作成されました。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.create</code></td>
    <td>水平ポッド自動スケーリング・ポリシーが作成されました。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.delete</code></td>
    <td>水平ポッド自動スケーリング・ポリシーが削除されました。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.patch</code></td>
    <td>水平ポッド自動スケーリング・ポリシーにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.update</code></td>
    <td>水平ポッド自動スケーリング・ポリシーが更新されました。</td>
  </tr>
  <tr>
    <td><code>jobs.create</code></td>
    <td>ジョブが作成されました。</td>
  </tr>
  <tr>
    <td><code>jobs.delete</code></td>
    <td>ジョブが削除されました。</td>
  </tr>
  <tr>
    <td><code>jobs.patch</code></td>
    <td>ジョブにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>jobs.update</code></td>
    <td>ジョブが更新されました。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.create</code></td>
    <td>証明書署名要求が作成されました。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.delete</code></td>
    <td>証明書署名要求が削除されました。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.patch</code></td>
    <td>証明書署名要求にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.update</code></td>
    <td>証明書署名要求が更新されました。</td>
  </tr>
  <tr>
    <td><code>ingresses.create</code></td>
    <td>Ingress ALB が作成されました。</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>Ingress ALB が削除されました。</td>
  </tr>
  <tr>
    <td><code>ingresses.patch</code></td>
    <td>Ingress ALB にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>ingresses.update</code></td>
    <td>Ingress ALB が更新されました。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.create</code></td>
    <td>ネットワーク・ポリシーが作成されました。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.delete</code></td>
    <td>ネットワーク・ポリシーが削除されました。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.patch</code></td>
    <td>ネットワーク・ポリシーにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.update</code></td>
    <td>ネットワーク・ポリシーが更新されました。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.create</code></td>
    <td>Kubernetes v1.10 以上で、ポッドのセキュリティー・ポリシーが作成されました。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.delete</code></td>
    <td>Kubernetes v1.10 以上で、ポッドのセキュリティー・ポリシーが削除されました。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.patch</code></td>
    <td>Kubernetes v1.10 以上で、ポッドのセキュリティー・ポリシーにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>Kubernetes v1.10 以上で、ポッドのセキュリティー・ポリシーが更新されました。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.create</code></td>
    <td>ポッド中断予算が作成されました。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.delete</code></td>
    <td>ポッド中断予算が削除されました。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.patch</code></td>
    <td>ポッド中断予算にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.update</code></td>
    <td>ポッド中断予算が更新されました。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.create</code></td>
    <td>クラスター役割バインディングが作成されます。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.deleted</code></td>
    <td>クラスター役割バインディングが削除されます。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.patched</code></td>
    <td>クラスター役割バインディングにパッチが適用されます。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.updated</code></td>
    <td>クラスター役割バインディングが更新されます。</td>
  </tr>
  <tr>
    <td><code>clusterroles.create</code></td>
    <td>クラスター役割が作成されました。</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>クラスター役割が削除されました。</td>
  </tr>
  <tr>
    <td><code>clusterroles.patched</code></td>
    <td>クラスター役割にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>clusterroles.updated</code></td>
    <td>クラスター役割が更新されました。</td>
  </tr>
  <tr>
    <td><code>rolebindings.create</code></td>
    <td>役割バインディングが作成されました。</td>
  </tr>
  <tr>
    <td><code>rolebindings.deleted</code></td>
    <td>役割バインディングが削除されました。</td>
  </tr>
  <tr>
    <td><code>rolebindings.patched</code></td>
    <td>役割バインディングにパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>rolebindings.updated</code></td>
    <td>役割バインディングが更新されました。</td>
  </tr>
  <tr>
    <td><code>roles.create</code></td>
    <td>役割が作成されました。</td>
  </tr>
  <tr>
    <td><code>roles.deleted</code></td>
    <td>役割が削除されました。</td>
  </tr>
  <tr>
    <td><code>roles.patched</code></td>
    <td>役割にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>roles.updated</code></td>
    <td>役割が更新されました。</td>
  </tr>
  <tr>
    <td><code>podpresets.create</code></td>
    <td>ポッドの事前設定が作成されました。</td>
  </tr>
  <tr>
    <td><code>podpresets.deleted</code></td>
    <td>ポッドの事前設定が削除されました。</td>
  </tr>
  <tr>
    <td><code>podpresets.patched</code></td>
    <td>ポッドの事前設定にパッチが適用されました。</td>
  </tr>
  <tr>
    <td><code>podpresets.updated</code></td>
    <td>ポッドの事前設定が更新されました。</td>
  </tr>
</table>
