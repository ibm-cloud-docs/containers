---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# クラスターを管理するための CLI リファレンス
{: #cs_cli_reference}

クラスターの作成と管理を行うときに以下のコマンドを参照してください。
{:shortdesc}

**ヒント:** `bx cr` コマンドをお探しですか? [{{site.data.keyword.registryshort_notm}} CLI リファレンス](/docs/cli/plugins/registry/index.html)を参照してください。`kubectl` コマンドをお探しですか? [Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/) を参照してください。


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="{{site.data.keyword.Bluemix_notm}} でクラスターを作成するためのコマンド">
 <thead>
    <th colspan=5>{{site.data.keyword.Bluemix_notm}} でクラスターを作成するためのコマンド</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_devtools.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_devtools.html#cs_cluster_create)</td>
    <td>[bx cs cluster-get](cs_cli_devtools.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_devtools.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_devtools.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_devtools.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_devtools.html#cs_cluster_services)</td>
    <td>[bx cs cluster-subnet-add](cs_cli_devtools.html#cs_cluster_subnet_add)</td>
    <td>[bx cs clusters](cs_cli_devtools.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_devtools.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_devtools.html#cs_credentials_unset)</td>
   <td>[bx cs help](cs_cli_devtools.html#cs_help)</td>
   <td>[bx cs init](cs_cli_devtools.html#cs_init)</td>
   <td>[bx cs locations](cs_cli_devtools.html#cs_datacenters)</td>
   <td>[bx cs machine-types](cs_cli_devtools.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_devtools.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_devtools.html#cs_vlans)</td>
    <td>[bx cs webhook-create](cs_cli_devtools.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_devtools.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_devtools.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_devtools.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_devtools.html#cs_worker_reload)</td>
   <td>[bx cs worker-rm](cs_cli_devtools.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_devtools.html#cs_workers)</td>
   
  </tr>
 </tbody>
 </table>

**ヒント:** {{site.data.keyword.containershort_notm}} プラグインのバージョンを表示するには、以下のコマンドを実行します。

```
bx plugin list```
{: pre}


## bx cs コマンド
{: #cs_commands}

### bx cs cluster-config CLUSTER [--admin]
{: #cs_cluster_config}

ログインした後に、クラスターに接続して `kubectl` コマンドを実行するための Kubernetes 構成データと証明書をダウンロードします。それらのファイルは、`user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>` にダウンロードされます。

**コマンド・オプション**:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code>--admin</code></dt>
   <dd>管理者 rbac の役割の証明書と許可ファイルをダウンロードします。これらのファイルを持つユーザーは、クラスターに対する管理アクション (クラスターの削除など) を実行できます。この値はオプションです。</dd>
   </dl>

**例**:

```
bx cs cluster-config my_cluster
```
{: pre}


### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--no-subnet][--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN][--workers WORKER]
{: #cs_cluster_create}

組織内にクラスターを作成します。

<strong>コマンド・オプション</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>標準クラスターを作成する YAML ファイルのパス。このコマンドに用意されているオプションを使用してクラスターの特性を定義する代わりに、YAML ファイルを使用することができます。

この値は、標準クラスターではオプションで、ライト・クラスターでは使用できません。

<p><strong>注:</strong> YAML ファイル内のパラメーターと同じオプションをコマンドで指定した場合は、コマンドの値が YAML 内の値よりも優先されます。例えば、YAML ファイル内で場所を定義し、コマンドで <code>--location</code> オプションを使用した場合は、コマンド・オプションに入力した値が YAML ファイル内の値をオーバーライドします。<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>


<table>
    <caption>表 1. YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td><code><em>&lt;cluster_name&gt;</em></code> をクラスターの名前に置き換えます。</td>
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td><code><em>&lt;location&gt;</em></code> を、クラスターを作成する場所に置き換えます。使用可能な場所は、ログインしている地域によって異なります。使用可能な場所をリストするには、<code>bx cs locations</code> を実行します。</td>
     </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td><code><em>&lt;machine_type&gt;</em></code> を、ワーカー・ノードに使用するマシン・タイプに置き換えます。現在の場所で使用可能なマシン・タイプをリストするには、<code>bx cs machine-types <em>&lt;location&gt;</em></code> を実行します。</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td><code><em>&lt;private_vlan&gt;</em></code> を、ワーカー・ノードに使用するプライベート VLAN の ID に置き換えます。使用可能な VLAN をリストするには、<code>bx cs vlans <em>&lt;location&gt;</em></code> を実行して、<code>bcr</code> で始まる VLAN ルーター (バックエンド・ルーター) を探します。</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td><code><em>&lt;public_vlan&gt;</em></code> を、ワーカー・ノードに使用するパブリック VLAN の ID に置き換えます。使用可能な VLAN をリストするには、<code>bx cs vlans <em>&lt;location&gt;</em></code> を実行して、<code>fcr</code> で始まる VLAN ルーター (フロントエンド・ルーター) を探します。</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>ワーカー・ノードのハードウェア分離のレベル。使用可能な物理リソースを自分専用にする場合には dedicated を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には shared を使用してください。デフォルトは <code>shared</code> です。</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td><code><em>&lt;number_workers&gt;</em></code> を、デプロイするワーカー・ノードの数に置き換えます。</td>
     </tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>ワーカー・ノードのハードウェア分離のレベル。使用可能な物理リソースを自分専用にする場合は dedicated を使用し、IBM の他のお客様と物理リソースを共有することを許可する場合は shared を使用します。デフォルトは shared です。この値は、標準クラスターではオプションで、ライト・クラスターでは使用できません。</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>クラスターを作成する場所。使用可能な場所は、ログインしている {{site.data.keyword.Bluemix_notm}} 地域によって異なります。
最高のパフォーマンスを得るために、物理的に最も近い地域を選択してください。
この値は、標準クラスターでは必須で、ライト・クラスターではオプションです。

<p>[使用可能なロケーション](cs_regions.html#locations)を参照してください。
</p>

<p><strong>注:</strong> 国外の場所を選択する場合は、その国にデータを物理的に保管する前に法的な許可を得なければならないことがあります。</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>選択したマシン・タイプによって、ワーカー・ノードにデプロイされたコンテナーで使用できるメモリーとディスク・スペースの量が左右されます。
使用可能なマシン・タイプをリストするには、[bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types) を参照してください。この値は、標準クラスターでは必須で、ライト・クラスターでは使用できません。</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>クラスターの名前。この値は必須です。</dd>

<dt><code>--no-subnet</code></dt>
<dd>ポータブル・サブネットなしでクラスターを作成するためのフラグを指定します。デフォルトでは、フラグを使用しないで IBM Bluemix Infrastructure (SoftLayer) ポートフォリオにサブネットを作成します。この値はオプションです。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>このパラメーターは、ライト・クラスターでは使用できません。</li>
<li>この標準クラスターが、この場所に作成する最初の標準クラスターである場合は、このフラグを含めないでください。プライベート VLAN は、クラスターが作成されるときに作成されます。</li>
<li>前に標準クラスターをこのロケーションに作成している場合、または前にプライベート VLAN を IBM Bluemix Infrastructure (SoftLayer) に作成している場合は、そのプライベート VLAN を指定する必要があります。

<p><strong>注:</strong> create コマンドで指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
</p></li>
</ul>

<p>特定の場所にプライベート VLAN が既に存在するかどうかや、既存のプライベート VLAN の名前を確認するには、<code>bx cs vlans <em>&lt;location&gt;</em></code> を実行します。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>このパラメーターは、ライト・クラスターでは使用できません。</li>
<li>この標準クラスターが、この場所に作成する最初の標準クラスターである場合は、このフラグを使用しないでください。パブリック VLAN は、クラスターが作成されるときに作成されます。</li>
<li>前に標準クラスターをこのロケーションに作成している場合、または前にパブリック VLAN を IBM Bluemix Infrastructure (SoftLayer) に作成している場合は、そのパブリック VLAN を指定する必要があります。

<p><strong>注:</strong> create コマンドで指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
</p></li>
</ul>

<p>特定の場所にパブリック VLAN が既に存在するかどうかや、既存のパブリック VLAN の名前を確認するには、<code>bx cs vlans <em>&lt;location&gt;</em></code> を実行します。</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>クラスターにデプロイするワーカー・ノードの数。
このオプションを指定しない場合、1 つのワーカー・ノードを持つクラスターが作成されます。
この値は、標準クラスターではオプションで、ライト・クラスターでは使用できません。

<p><strong>注:</strong> ワーカー・ノードごとに、固有のワーカー・ノード ID とドメイン名が割り当てられます。クラスターが作成された後にこれらを手動で変更してはいけません。ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。</p></dd>
</dl>

**例**:

  

  標準クラスターの例:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  ライト・クラスターの例:

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  {{site.data.keyword.Bluemix_notm}} Dedicated 環境の場合の例:


  ```
bx cs cluster-create --machine-type machine-type --workers number --name cluster_name```
  {: pre}


### bx cs cluster-get CLUSTER
{: #cs_cluster_get}

組織内のクラスターに関する情報を表示します。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

組織が使用するクラスターを削除します。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にクラスターを削除するには、このオプションを使用します。この値はオプションです。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

{{site.data.keyword.Bluemix_notm}} サービスをクラスターに追加します。

**ヒント:** {{site.data.keyword.Bluemix_notm}} Dedicated ユーザーの場合は、[{{site.data.keyword.Bluemix_notm}} Dedicated (最終ベータ版) のクラスターに {{site.data.keyword.Bluemix_notm}} サービスを追加する](cs_cluster.html#binding_dedicated)を参照してください。



<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名前空間の名前。この値は必須です。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>バインドする {{site.data.keyword.Bluemix_notm}} サービス・インスタンスの ID。この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

クラスターから {{site.data.keyword.Bluemix_notm}} サービスを削除します。


**注:** {{site.data.keyword.Bluemix_notm}} サービスを削除すると、サービス資格情報がクラスターから削除されます。そのサービスをまだ使用しているポッドがあるなら、サービス資格情報を検出できなくなるためそのポッドは失敗します。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名前空間の名前。この値は必須です。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>削除する {{site.data.keyword.Bluemix_notm}} サービス・インスタンスの ID。この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces]
{: #cs_cluster_services}

クラスター内の 1 つまたはすべての Kubernetes 名前空間にバインドされたサービスをリストします。指定されたオプションがない場合、デフォルトの名前空間のサービスが表示されます。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>クラスター内の特定の名前空間にバインドされたサービスを含めます。この値はオプションです。</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>クラスター内のすべての名前空間にバインドされたサービスを含めます。この値はオプションです。</dd>
    </dl>

**例**:

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

指定されたクラスターで、IBM Bluemix Infrastructure (SoftLayer) アカウント内のサブネットを使用できるようにします。

**注:** クラスターでサブネットを使用できるようにすると、このサブネットの IP アドレスは、クラスターのネットワーキングの目的で使用されるようになります。IP アドレスの競合を回避するため、1 つのサブネットは必ず 1 つのクラスターでのみ使用してください。
あるサブネットを複数のクラスターで使用したり、同時に他の目的で {{site.data.keyword.containershort_notm}}の外部で使用したりしないでください。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>サブネットの ID。この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}


### bx cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

{{site.data.keyword.containershort_notm}} のクラスターに独自のプライベート・サブネットを追加します。

このプライベート・サブネットは、IBM Bluemix Infrastructure (SoftLayer) から提供されたプライベート・サブネットではありません。このため、そのサブネットに対してインバウンドおよびアウトバウンドのネットワーク・トラフィックのルーティングをすべて構成する必要があります。IBM Bluemix Infrastructure (SoftLayer) のサブネットを追加する場合は、`bx cs cluster-subnet-add` [コマンド](#cs_cluster_subnet_add)を使用します。

**注**: ユーザーのプライベート・サブネットをクラスターに追加する場合、そのクラスター内のプライベートのロード・バランサーでこのサブネットの IP アドレスが使用されます。IP アドレスの競合を回避するため、1 つのサブネットは必ず 1 つのクラスターでのみ使用してください。
あるサブネットを複数のクラスターで使用したり、同時に他の目的で {{site.data.keyword.containershort_notm}}の外部で使用したりしないでください。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>サブネットのクラスレス・ドメイン間ルーティング (CIDR)。この値は必須です。IBM Bluemix Infrastructure (SoftLayer) によって使用されるどのサブネットとも競合しない値にする必要があります。

   サポートされる接頭部の範囲は、`/30` (1 個の IP アドレス) から `/24` (253 個の IP アドレス) です。CIDR の接頭部の長さを設定した後でその長さを変更することが必要になった場合は、まず新しい CIDR を追加し、その後[古い CIDR を削除](#cs_cluster_user_subnet_rm)します。</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>プライベート VLAN の ID。この値は必須です。

この値は、クラスター内にある 1 つ以上のワーカー・ノードのプライベート VLAN ID と一致していなければなりません。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-user-subnet-add my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

指定されたクラスターから独自のプライベート・サブネットを削除します。

**注:** 独自のプライベート・サブネットに属する IP アドレスにデプロイされたサービスは、そのサブネットが削除された後にもすべてアクティブのままになります。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>サブネットのクラスレス・ドメイン間ルーティング (CIDR)。この値は必須です。`bx cs cluster-user-subnet-add` [コマンド](#cs_cluster_user_subnet_add)で設定された CIDR と一致する値にする必要があります。</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>プライベート VLAN の ID。この値は必須です。`bx cs cluster-user-subnet-add` [コマンド](#cs_cluster_user_subnet_add)で設定された VLAN ID と一致する値にする必要があります。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-user-subnet-rm my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER
{: #cs_cluster_update}

Kubernetes マスターを最新の API バージョンに更新します。更新中、クラスターにアクセスすることも変更することもできません。ユーザーがデプロイしたワーカー・ノード、アプリ、リソースは変更されず、引き続き実行されます。

今後のデプロイメント用に、YAML ファイルを変更する必要がある場合があります。詳しくは、この[リリース・ノート](cs_versions.html)を確認してください。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずにマスターを強制的に更新するには、このオプションを使用します。この値はオプションです。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

組織が使用するクラスターのリストを表示します。

<strong>コマンド・オプション</strong>:

   

  なし

**例**:

  ```
bx cs clusters```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

{{site.data.keyword.Bluemix_notm}} アカウントに IBM Bluemix Infrastructure (SoftLayer) アカウントの資格情報を設定します。これらの資格情報が設定されると、{{site.data.keyword.Bluemix_notm}} アカウントを使用して IBM Bluemix Infrastructure (SoftLayer) ポートフォリオにアクセスできます。

**注:** 1 つの {{site.data.keyword.Bluemix_notm}} アカウントに複数の資格情報を設定しないでください。それぞれの {{site.data.keyword.Bluemix_notm}} アカウントは、1 つの IBM Bluemix Infrastructure (SoftLayer) ポートフォリオだけにリンクされます。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>IBM Bluemix Infrastructure (SoftLayer) アカウントのユーザー名。この値は必須です。</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>IBM Bluemix Infrastructure (SoftLayer) アカウントの API キー。この値は必須です。

<p>
API キーを生成するには、以下のようにします。<ol>
  <li>[IBM Bluemix Infrastructure (SoftLayer) ポータル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://control.softlayer.com/) にログインします。</li>
  <li><strong>「アカウント」</strong>を選択し、次に<strong>「ユーザー」</strong>を選択します。</li>
  <li><strong>「生成」</strong>をクリックして、アカウント用の IBM Bluemix Infrastructure (SoftLayer) の API キーを生成します。</li>
  <li>このコマンドで使用するために API キーをコピーします。</li>
  </ol>

  既存の API キーを表示するには、以下のようにします。
  <ol>
  <li>[IBM Bluemix Infrastructure (SoftLayer) ポータル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://control.softlayer.com/) にログインします。</li>
  <li><strong>「アカウント」</strong>を選択し、次に<strong>「ユーザー」</strong>を選択します。</li>
  <li><strong>「表示」</strong>をクリックして既存の API キーを表示します。</li>
  <li>このコマンドで使用するために API キーをコピーします。</li>
  </ol></p></dd>

**例**:

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


###   bx cs credentials-unset
  
{: #cs_credentials_unset}

{{site.data.keyword.Bluemix_notm}} アカウントから IBM Bluemix Infrastructure (SoftLayer) アカウントの資格情報を削除します。資格情報を削除すると、{{site.data.keyword.Bluemix_notm}} アカウントを使用して IBM Bluemix Infrastructure (SoftLayer) ポートフォリオにアクセスすることはできなくなります。

<strong>コマンド・オプション</strong>:

   

   なし

**例**:

  ```
  bx cs credentials-unset
  ```
  {: pre}



###   bx cs help
  
{: #cs_help}

サポートされるコマンドとパラメーターのリストを表示します。


<strong>コマンド・オプション</strong>:

   

   なし

**例**:

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

{{site.data.keyword.containershort_notm}} プラグインを初期化するか、Kubernetes クラスターを作成またはアクセスする地域を指定します。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>使用する {{site.data.keyword.containershort_notm}} API エンドポイント。この値はオプションです。

例:    <ul>
    <li>米国南部:

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>米国東部:

    <pre class="codeblock">
    <code>bx cs init --host https://us-east.containers.bluemix.net</code>
    </pre>
    <p><strong>注</strong>: 米国東部を使用できるのは、CLI コマンドで使用する場合だけです。</p></li>

    <li>英国南部:

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>中欧:

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>南アジア太平洋地域:

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>




###   bx cs locations
  
{: #cs_datacenters}

クラスターを作成するために使用できる場所のリストを表示します。

<strong>コマンド・オプション</strong>:

   

   なし

**例**:

  ```
  bx cs locations
  ```
  {: pre}


###   bx cs machine-types LOCATION
  
{: #cs_machine_types}

ワーカー・ノードのために使用できるマシン・タイプのリストを表示します。
各マシン・タイプには、クラスター内の各ワーカー・ノード用の仮想 CPU、メモリー、ディスク・スペースの量が含まれます。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><em>LOCATION</em></dt>
   <dd>使用可能なマシン・タイプをリストする対象の場所を入力します。この値は必須です。

[使用可能なロケーション](cs_regions.html#locations)を参照してください。</dd></dl>

**例**:

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

IBM Bluemix Infrastructure (SoftLayer) アカウントで使用できるサブネットのリストを表示します。

<strong>コマンド・オプション</strong>:

   

   なし

**例**:

  ```
bx cs subnets```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

あるロケーションにおいて、IBM Bluemix Infrastructure (SoftLayer) アカウントで使用可能なパブリック VLAN とプライベート VLAN をリストします。使用可能な VLAN をリストするには、有料アカウントが必要です。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt>LOCATION</dt>
   <dd>プライベート VLAN とパブリック VLAN をリストする対象の場所を入力します。この値は必須です。

[使用可能なロケーション](cs_regions.html#locations)を参照してください。</dd>
   </dl>

**例**:

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

Web フックを作成します。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd><code>Normal</code> や <code>Warning</code> などの通知レベル。<code>警告</code> はデフォルト値です。この値はオプションです。</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>slack などの Web フック・タイプ。slack だけがサポートされています。この値は必須です。</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>Web フックの URL。この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN
{: #cs_worker_add}

ワーカー・ノードを標準クラスターに追加します。

<strong>コマンド・オプション</strong>:

   

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>クラスターの名前または ID。この値は必須です。</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>ワーカー・ノードをクラスターに追加する YAML ファイルのパス。このコマンドに用意されているオプションを使用して追加のワーカー・ノードを定義する代わりに、YAML ファイルを使用することができます。

この値はオプションです。

<p><strong>注:</strong> YAML ファイル内のパラメーターと同じオプションをコマンドで指定した場合は、コマンドの値が YAML 内の値よりも優先されます。例えば、YAML ファイル内でマシン・タイプを定義し、コマンドで --machine-type オプションを使用した場合は、コマンド・オプションに入力した値が YAML ファイル内の値をオーバーライドします。

      <pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_id&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>

<table>
<caption>表 2. YAML ファイルの構成要素について</caption>
<thead>
<th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td><code><em>&lt;cluster_name_or_id&gt;</em></code> を、ワーカー・ノードの追加先のクラスターの名前または ID に置き換えます。</td>
</tr>
<tr>
<td><code><em>location</em></code></td>
<td><code><em>&lt;location&gt;</em></code> を、ワーカー・ノードをデプロイする場所に置き換えます。使用可能な場所は、ログインしている地域によって異なります。使用可能な場所をリストするには、<code>bx cs locations</code> を実行します。</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td><code><em>&lt;machine_type&gt;</em></code> を、ワーカー・ノードに使用するマシン・タイプに置き換えます。現在の場所で使用可能なマシン・タイプをリストするには、<code>bx cs machine-types <em>&lt;location&gt;</em></code> を実行します。</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td><code><em>&lt;private_vlan&gt;</em></code> を、ワーカー・ノードに使用するプライベート VLAN の ID に置き換えます。使用可能な VLAN をリストするには、<code>bx cs vlans <em>&lt;location&gt;</em></code> を実行して、<code>bcr</code> で始まる VLAN ルーター (バックエンド・ルーター) を探します。</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td><code>&lt;public_vlan&gt;</code> を、ワーカー・ノードに使用するパブリック VLAN の ID に置き換えます。使用可能な VLAN をリストするには、<code>bx cs vlans &lt;location&gt;</code> を実行して、<code>fcr</code> で始まる VLAN ルーター (フロントエンド・ルーター) を探します。</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>ワーカー・ノードのハードウェア分離のレベル。使用可能な物理リソースを自分専用にする場合には dedicated を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には shared を使用してください。デフォルトは shared です。</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td><code><em>&lt;number_workers&gt;</em></code> を、デプロイするワーカー・ノードの数に置き換えます。</td>
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>ワーカー・ノードのハードウェア分離のレベル。使用可能な物理リソースを自分専用にする場合には dedicated を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には shared を使用してください。デフォルトは shared です。この値はオプションです。</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>選択したマシン・タイプによって、ワーカー・ノードにデプロイされたコンテナーで使用できるメモリーとディスク・スペースの量が左右されます。
この値は必須です。

使用可能なマシン・タイプをリストするには、[bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types) を参照してください。</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>クラスター内に作成するワーカー・ノードの数を表す整数。デフォルト値は 1 です。この値はオプションです。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>クラスターの作成時に指定されたプライベート VLAN。この値は必須です。

<p><strong>注:</strong> 指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>クラスターの作成時に指定されたパブリック VLAN。この値はオプションです。

<p><strong>注:</strong> 指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
</p></dd>
</dl>

**例**:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  {{site.data.keyword.Bluemix_notm}} Dedicated の場合の例:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

ワーカー・ノードの詳細を表示します。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><em>WORKER_NODE_ID</em></dt>
   <dd>ワーカー・ノードの ID。
クラスター内のワーカー・ノードの ID を表示するには、<code>bx cs workers <em>CLUSTER</em></code> を実行します。この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs worker-get WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

クラスター内のワーカー・ノードをリブートします。
ワーカー・ノードに問題がある場合は、まずワーカー・ノードをリブートして再始動してみてください。
リブートしても問題が解決されない場合、`worker-reload` コマンドを試してください。
リブートの際に、ワーカー・ノードの状態は変更されません。
状態は `deployed` のままですが、状況は更新されます。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にワーカー・ノードを再始動するには、このオプションを使用します。この値はオプションです。</dd>

   <dt><code>--hard</code></dt>
   <dd>ワーカー・ノードの電源を遮断することでワーカー・ノードのハード再始動を強制するには、このオプションを使用します。このオプションは、ワーカー・ノードが応答しない場合、またはワーカー・ノードで Docker ハングが生じた場合に使用します。この値はオプションです。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>1 つ以上のワーカー・ノードの名前または ID。複数のワーカー・ノードをリストするには、スペースを使用します。
この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

クラスター内のワーカー・ノードを再ロードします。
ワーカー・ノードに問題がある場合は、まずワーカー・ノードをリブートしてみてください。
リブートしても問題が解決されない場合、`worker-reload` コマンドを試してください。
ワーカー・ノードに必要なすべての構成が再ロードされます。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にワーカー・ノードを再ロードするには、このオプションを使用します。この値はオプションです。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>1 つ以上のワーカー・ノードの名前または ID。複数のワーカー・ノードをリストするには、スペースを使用します。
この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

1 つ以上のワーカー・ノードをクラスターから削除します。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にワーカー・ノードを削除するには、このオプションを使用します。この値はオプションです。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>1 つ以上のワーカー・ノードの名前または ID。複数のワーカー・ノードをリストするには、スペースを使用します。
この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_update}

ワーカー・ノードを最新の Kubernetes バージョンに更新します。`bx cs worker-update` を実行すると、アプリとサービスにダウン時間が発生する可能性があります。更新中、すべてのポッドが他のワーカー・ノードにスケジュール変更されるので、ポッドの外部に保管されていないデータは削除されます。ダウン時間を回避するには、選択したワーカー・ノードの更新中に、ワークロードを処理するために十分なワーカー・ノード数を確保するようにしてください。

更新の前に、デプロイメント用に YAML ファイルを変更する必要がある場合があります。詳しくは、この[リリース・ノート](cs_versions.html)を確認してください。

<strong>コマンド・オプション</strong>:

   

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>使用可能なワーカー・ノードをリストする対象のクラスターの名前または ID。この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずにマスターを強制的に更新するには、このオプションを使用します。この値はオプションです。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>1 つ以上のワーカー・ノードの ID。複数のワーカー・ノードをリストするには、スペースを使用します。
この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs worker-update my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

ワーカー・ノードのリストと、それぞれのクラスター内での状況を表示します。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>使用可能なワーカー・ノードをリストする対象のクラスターの名前または ID。この値は必須です。</dd>
   </dl>

**例**:

  ```
  bx cs workers mycluster
  ```
  {: pre}
