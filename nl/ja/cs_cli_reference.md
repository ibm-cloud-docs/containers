---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

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

**ヒント:** `bx cr` コマンドをお探しですか? [{{site.data.keyword.registryshort_notm}} CLI リファレンス](/docs/cli/plugins/registry/index.html#containerregcli)を参照してください。`kubectl` コマンドをお探しですか? [Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/) を参照してください。

 
<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="{{site.data.keyword.Bluemix_notm}} でクラスターを作成するためのコマンド">
 <thead>
    <th colspan=5>{{site.data.keyword.Bluemix_notm}} でクラスターを作成するためのコマンド</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_reference.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_reference.html#cs_cluster_create)</td> 
    <td>[bx cs cluster-get](cs_cli_reference.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_reference.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_reference.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_reference.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_reference.html#cs_cluster_services)</td> 
    <td>[bx cs cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</td>
    <td>[bx cs clusters](cs_cli_reference.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_reference.html#cs_credentials_unset)</td>
   <td>[bx cs locations](cs_cli_reference.html#cs_datacenters)</td> 
   <td>[bx cs help](cs_cli_reference.html#cs_help)</td>
   <td>[bx cs init](cs_cli_reference.html#cs_init)</td>
   <td>[bx cs machine-types](cs_cli_reference.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_reference.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_reference.html#cs_vlans)</td> 
    <td>[bx cs webhook-create](cs_cli_reference.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_reference.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_reference.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_reference.html#cs_worker_reload)</td> 
   <td>[bx cs worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_reference.html#cs_workers)</td>
   <td></td>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code>--admin</code></dt>
   <dd>(オプション) 管理者 rbac の役割の証明書と許可ファイルをダウンロードします。これらのファイルを持つユーザーは、クラスターに対する管理アクション (クラスターの削除など) を実行できます。</dd>
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

<dd>(標準クラスターの場合はオプション。ライト・クラスターの場合は利用不可) 標準クラスターを作成する YAML ファイルのパス。このコマンドに用意されているオプションを使用してクラスターの特性を定義する代わりに、YAML ファイルを使用することができます。

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
<dd>(標準クラスターの場合はオプション。ライト・クラスターの場合は利用不可) ワーカー・ノードのハードウェア分離のレベル。使用可能な物理リソースを自分専用にする場合には dedicated を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には shared を使用してください。デフォルトは shared です。</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>(標準クラスターの場合に必須。ライト・クラスターの場合はオプション。) クラスターを作成する場所。使用可能な場所は、ログインしている {{site.data.keyword.Bluemix_notm}} 地域によって異なります。
最高のパフォーマンスを得るために、物理的に最も近い地域を選択してください。
<p>使用可能な場所は、次のとおりです。<ul><li>米国南部<ul><li>dal10 [Dallas (ダラス)]</li><li>dal12 [Dallas (ダラス)]</li></ul></li><li>英国南部<ul><li>lon02 [London (ロンドン)]</li><li>lon04 [London (ロンドン)]</li></ul></li><li>中欧<ul><li>ams03 [Amsterdam (アムステルダム)]</li><li>ra02 [Frankfurt (フランクフルト)]</li></ul></li><li>南アジア太平洋地域<ul><li>syd01 [Sydney (シドニー)]</li><li>syd04 [Sydney (シドニー)]</li></ul></li></ul>
</p>

<p><strong>注:</strong> 国外の場所を選択する場合は、その国にデータを物理的に保管する前に法的な許可を得なければならないことがあります。</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>(標準クラスターの場合に必須。ライト・クラスターの場合は利用不可) 選択したマシン・タイプによって、ワーカー・ノードにデプロイされたコンテナーで使用できるメモリーとディスク・スペースの量が左右されます。
使用可能なマシン・タイプをリストするには、[bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types) を参照してください。</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>(必須) クラスターの名前。</dd>

<dt><code>--no-subnet</code></dt>
<dd>ポータブル・サブネットなしでクラスターを作成するためのフラグを指定します。デフォルトではフラグを使用しないで {{site.data.keyword.BluSoftlayer_full}} ポートフォリオにサブネットを作成します。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>(ライト・クラスターの場合は利用不可)<ul>
<li>このクラスターが、この場所に作成する最初のクラスターである場合は、このフラグを含めないでください。
プライベート VLAN は、クラスターが作成されるときに作成されます。</li>
<li>前にクラスターをこの場所に作成している場合、または前にプライベート VLAN を {{site.data.keyword.BluSoftlayer_notm}} に作成している場合は、そのプライベート VLAN を指定する必要があります。
<p><strong>注:</strong> create コマンドで指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
</p></li>
</ul>

<p>特定の場所にプライベート VLAN が既に存在するかどうかや、既存のプライベート VLAN の名前を確認するには、<code>bx cs vlans <em>&lt;location&gt;</em></code> を実行します。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>(ライト・クラスターの場合は利用不可)<ul>
<li>このクラスターが、この場所に作成する最初のクラスターである場合は、このフラグを使用しないでください。
パブリック VLAN は、クラスターが作成されるときに作成されます。</li>
<li>前にクラスターをこの場所に作成している場合、または前にパブリック VLAN を {{site.data.keyword.BluSoftlayer_notm}} に作成している場合は、そのパブリック VLAN を指定する必要があります。
<p><strong>注:</strong> create コマンドで指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
</p></li>
</ul>

<p>特定の場所にパブリック VLAN が既に存在するかどうかや、既存のパブリック VLAN の名前を確認するには、<code>bx cs vlans <em>&lt;location&gt;</em></code> を実行します。</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>(標準クラスターの場合はオプション。ライト・クラスターの場合は利用不可) クラスターにデプロイするワーカー・ノードの数。
このオプションを指定しない場合、1 つのワーカー・ノードを持つクラスターが作成されます。
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
   <dd>(必須) クラスターの名前または ID。</dd>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code>-f</code></dt>
   <dd>(オプション) ユーザー・プロンプトを出さずに強制的にクラスターを削除するには、このオプションを使用します。</dd>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(必須) Kubernetes 名前空間の名前。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(必須) バインドする {{site.data.keyword.Bluemix_notm}} サービス・インスタンスの ID。</dd>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(必須) Kubernetes 名前空間の名前。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(必須) 削除する {{site.data.keyword.Bluemix_notm}} サービス・インスタンスの ID。</dd>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(オプション) クラスター内の特定の名前空間にバインドされたサービスを含めます。</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>(オプション) クラスター内のすべての名前空間にバインドされたサービスを含めます。</dd>
    </dl>

**例**:

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

指定されたクラスターで、{{site.data.keyword.BluSoftlayer_notm}} アカウント内のサブネットを使用できるようにします。


**注:** クラスターでサブネットを使用できるようにすると、このサブネットの IP アドレスは、クラスターのネットワーキングの目的で使用されるようになります。IP アドレスの競合を回避するため、1 つのサブネットは必ず 1 つのクラスターでのみ使用してください。
あるサブネットを複数のクラスターで使用したり、同時に他の目的で {{site.data.keyword.containershort_notm}}の外部で使用したりしないでください。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>(必須) サブネットの ID。</dd>
   </dl>

**例**:

  ```
  bx cs cluster-subnet-add my_cluster subnet
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

{{site.data.keyword.Bluemix_notm}} アカウントに {{site.data.keyword.BluSoftlayer_notm}} アカウント資格情報を設定します。
これらの資格情報が設定されると、{{site.data.keyword.Bluemix_notm}} アカウントを使用して {{site.data.keyword.BluSoftlayer_notm}} ポートフォリオにアクセスできます。

<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>(必須) {{site.data.keyword.BluSoftlayer_notm}} アカウントのユーザー名。</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>(必須) {{site.data.keyword.BluSoftlayer_notm}} アカウントの API キー。
   
 <p>
API キーを生成するには、以下のようにします。    
  <ol>
  <li>[{{site.data.keyword.BluSoftlayer_notm}} ポータル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://control.softlayer.com/) にログインします。</li>
  <li><strong>「アカウント」</strong>を選択し、次に<strong>「ユーザー」</strong>を選択します。</li>
  <li><strong>「生成」</strong>をクリックしてアカウントの {{site.data.keyword.BluSoftlayer_notm}} API キーを生成します。</li>
  <li>このコマンドで使用するために API キーをコピーします。</li>
  </ol>

  既存の API キーを表示するには、以下のようにします。
  <ol>
  <li>[{{site.data.keyword.BluSoftlayer_notm}} ポータル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://control.softlayer.com/) にログインします。</li>
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

{{site.data.keyword.Bluemix_notm}} アカウントから {{site.data.keyword.BluSoftlayer_notm}} アカウント資格情報を削除します。
資格情報を削除した後は、{{site.data.keyword.Bluemix_notm}} アカウントを使用して {{site.data.keyword.BluSoftlayer_notm}} ポートフォリオにアクセスできなくなります。

<strong>コマンド・オプション</strong>:

   

   なし

**例**:

  ```
  bx cs credentials-unset
  ```
  {: pre}


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
   <dd>(オプション) 使用する {{site.data.keyword.containershort_notm}} API エンドポイント。例:    <ul>
    <li>米国南部:

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

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


###   bx cs machine-types LOCATION
  
{: #cs_machine_types}

ワーカー・ノードのために使用できるマシン・タイプのリストを表示します。
各マシン・タイプには、クラスター内の各ワーカー・ノード用の仮想 CPU、メモリー、ディスク・スペースの量が含まれます。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><em>LOCATION</em></dt>
   <dd>(必須) 使用可能なマシン・タイプをリストする対象の場所を入力します。使用可能な場所は、次のとおりです。<ul><li>米国南部<ul><li>dal10 [Dallas (ダラス)]</li><li>dal12 [Dallas (ダラス)]</li></ul></li><li>英国南部<ul><li>lon02 [London (ロンドン)]</li><li>lon04 [London (ロンドン)]</li></ul></li><li>中欧<ul><li>ams03 [Amsterdam (アムステルダム)]</li><li>ra02 [Frankfurt (フランクフルト)]</li></ul></li><li>南アジア太平洋地域<ul><li>syd01 [Sydney (シドニー)]</li><li>syd04 [Sydney (シドニー)]</li></ul></li></ul></dd></dl>
   
**例**:

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

{{site.data.keyword.BluSoftlayer_notm}} アカウントで使用できるサブネットのリストを表示します。


<strong>コマンド・オプション</strong>:

   

   なし

**例**:

  ```
bx cs subnets```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

{{site.data.keyword.BluSoftlayer_notm}} アカウントで、ある場所用に使用可能なパブリック VLAN とプライベート VLAN をリストします。
使用可能な VLAN をリストするには、有料アカウントが必要です。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt>LOCATION</dt>
   <dd>(必須) プライベート VLAN とパブリック VLAN をリストする対象の場所を入力します。使用可能な場所は、次のとおりです。<ul><li>米国南部<ul><li>dal10 [Dallas (ダラス)]</li><li>dal12 [Dallas (ダラス)]</li></ul></li><li>英国南部<ul><li>lon02 [London (ロンドン)]</li><li>lon04 [London (ロンドン)]</li></ul></li><li>中欧<ul><li>ams03 [Amsterdam (アムステルダム)]</li><li>ra02 [Frankfurt (フランクフルト)]</li></ul></li><li>南アジア太平洋地域<ul><li>syd01 [Sydney (シドニー)]</li><li>syd04 [Sydney (シドニー)]</li></ul></li></ul></dd>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>(オプション) <code>Normal</code> や <code>Warning</code> などの通知レベル。
<code>警告</code> はデフォルト値です。</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>(必須) slack などの Web フック・タイプ。 slack だけがサポートされています。</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>(必須) Web フックの URL。</dd>
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
<dd>(必須) クラスターの名前または ID。</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>ワーカー・ノードをクラスターに追加する YAML ファイルのパス。このコマンドに用意されているオプションを使用して追加のワーカー・ノードを定義する代わりに、YAML ファイルを使用することができます。

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
<dd>(オプション) ワーカー・ノードのハードウェア分離のレベル。使用可能な物理リソースを自分専用にする場合には dedicated を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には shared を使用してください。デフォルトは shared です。</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>(必須) 選択したマシン・タイプによって、ワーカー・ノードにデプロイされたコンテナーで使用できるメモリーとディスク・スペースの量が左右されます。
使用可能なマシン・タイプをリストするには、[bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types) を参照してください。</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>(必須) クラスター内に作成するワーカー・ノードの数を表す整数。
</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>(必須) 対象の場所に使用できるプライベート VLAN がある場合は、その VLAN を指定する必要があります。
これが、この場所に作成する最初のクラスターである場合は、このフラグを使用しないでください。
プライベート VLAN は自動的に作成されます。
<p><strong>注:</strong> create コマンドで指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>(必須) 対象の場所に使用できるパブリック VLAN がある場合は、その VLAN を指定する必要があります。
これが、この場所に作成する最初のクラスターである場合は、このフラグを使用しないでください。
パブリック VLAN は自動的に作成されます。
<p><strong>注:</strong> create コマンドで指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
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
クラスター内のワーカー・ノードの ID を表示するには、<code>bx cs workers <em>CLUSTER</em></code> を実行します。</dd>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code>-f</code></dt>
   <dd>(オプション) ユーザー・プロンプトを出さずに強制的にワーカー・ノードを再始動するには、このオプションを使用します。</dd>

   <dt><code>--hard</code></dt>
   <dd>(オプション) ワーカー・ノードの電源を遮断することでワーカー・ノードのハード再始動を強制するには、このオプションを使用します。
このオプションは、ワーカー・ノードが応答しない場合、またはワーカー・ノードで Docker ハングが生じた場合に使用します。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(必須) 1 つ以上のワーカー・ノードの名前または ID。
複数のワーカー・ノードをリストするには、スペースを使用します。
</dd>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code>-f</code></dt>
   <dd>(オプション) ユーザー・プロンプトを出さずに強制的にワーカー・ノードを再ロードするには、このオプションを使用します。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(必須) 1 つ以上のワーカー・ノードの名前または ID。
複数のワーカー・ノードをリストするには、スペースを使用します。
</dd>
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
   <dd>(必須) クラスターの名前または ID。</dd>

   <dt><code>-f</code></dt>
   <dd>(オプション) ユーザー・プロンプトを出さずに強制的にワーカー・ノードを削除するには、このオプションを使用します。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(必須) 1 つ以上のワーカー・ノードの名前または ID。
複数のワーカー・ノードをリストするには、スペースを使用します。
</dd>
   </dl>

**例**:

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

ワーカー・ノードのリストと、それぞれのクラスター内での状況を表示します。


<strong>コマンド・オプション</strong>:

   

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>(必須) 使用可能なワーカー・ノードをリストする対象のクラスターの名前または ID。</dd>
   </dl>

**例**:

  ```
  bx cs workers mycluster
  ```
  {: pre}

## クラスターの状態
{: #cs_cluster_states}

現在のクラスターの状態を確認するには、bx cs クラスター・コマンドを実行して **State** フィールドを見つけます。クラスターの状態から、クラスターの可用性と容量、発生した可能性のある問題についての情報が得られます。
{:shortdesc}

|クラスターの状態|理由|
|-------------|------|
|デプロイ|Kubernetes マスターがまだ完全にデプロイされていません。クラスターにアクセスできません。|
|Pending|Kubernetes マスターはデプロイされています。ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。クラスターにはアクセスできますが、アプリをクラスターにデプロイすることはできません。|
|Normal|クラスター内のすべてのワーカー・ノードが稼働中です。クラスターにアクセスし、アプリをクラスターにデプロイできます。|
|Warning|クラスター内の 1 つ以上のワーカー・ノードが使用不可です。ただし、他のワーカー・ノードが使用可能であるため、ワークロードを引き継ぐことができます。<ol><li>クラスター内のワーカー・ノードをリストして、<strong>Warning</strong> 状態のワーカー・ノードの ID をメモします。<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>ワーカー・ノードの詳細を取得します。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li><strong>「State」</strong>、<strong>「Status」</strong>、<strong>「Details」</strong>フィールドを参照して、ワーカー・ノードがダウンした根本問題を調べます。</li><li>ワーカー・ノードのメモリーやディスク・スペースが上限に近付いている場合は、ワーカー・ノードのワークロードを減らすか、ワークロードを分散できるようにクラスターにワーカー・ノードを追加してください。</li></ol>|
|Critical|Kubernetes マスターにアクセスできないか、クラスター内のワーカー・ノードがすべてダウンしています。<ol><li>クラスター内のワーカー・ノードをリストします。<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>各ワーカー・ノードの詳細を取得します。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li><strong>「State」</strong>、<strong>「Status」</strong>、<strong>「Details」</strong>フィールドを参照して、ワーカー・ノードがダウンした根本問題を調べます。</li><li>ワーカー・ノードの状態が <strong>Provision_failed</strong> の場合は、{{site.data.keyword.BluSoftlayer_notm}} ポートフォリオからワーカー・ノードをプロビジョンするために必要なアクセス権限がない可能性があります。必要なアクセス権限については、[{{site.data.keyword.BluSoftlayer_notm}} ポートフォリオへのアクセス権限を構成して標準の Kubernetes クラスターを作成する](cs_planning.html#cs_planning_unify_accounts)を参照してください。</li><li>ワーカー・ノードの状態が <strong>Critical</strong> で、ワーカー・ノードの状況が <strong>Out of disk</strong> である場合は、ワーカー・ノードの容量が使い尽くされています。ワーカー・ノードのワークロードを減らすか、またはワークロードを分散できるようにクラスターにワーカー・ノードを追加してください。</li><li>ワーカー・ノードの状態が <strong>Critical</strong> で、ワーカー・ノードの状況が <strong>Unknown</strong> である場合、Kubernetes マスターは使用不可です。[{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/support/index.html#contacting-support)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</li></ol>|
{: caption="表 3. クラスターの状態" caption-side="top"}
