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


# Referência de CLI para gerenciar clusters
{: #cs_cli_reference}

Refira-se a estes comandos para criar e gerenciar clusters.
{:shortdesc}

**Dica:** procurando comandos `bx cr`? Veja a [referência de CLI do {{site.data.keyword.registryshort_notm}}](/docs/cli/plugins/registry/index.html). Procurando comandos `kubectl`? Consulte a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="Comandos para criar clusters no {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Comandos para criar clusters no {{site.data.keyword.Bluemix_notm}}</th>
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
    <td>[    bx cs clusters
    ](cs_cli_devtools.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_devtools.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_devtools.html#cs_credentials_unset)</td>
   <td>[  bx cs help
  ](cs_cli_devtools.html#cs_help)</td>
   <td>[        bx cs init
        ](cs_cli_devtools.html#cs_init)</td>
   <td>[bx cs locations](cs_cli_devtools.html#cs_datacenters)</td>
   <td>[bx cs machine-types](cs_cli_devtools.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[  bx cs subnets
  ](cs_cli_devtools.html#cs_subnets)</td>
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

**Dica:** para ver a versão do plug-in do {{site.data.keyword.containershort_notm}}, execute o comando a seguir.

```
bx plugin list
```
{: pre}


## Comandos bx cs
{: #cs_commands}

### bx cs cluster-config CLUSTER [--admin]
{: #cs_cluster_config}

Depois de efetuar login, faça download dos dados de configuração e certificados do Kubernetes para se conectar ao cluster e executar comandos `kubectl`. Os arquivos são transferidos por download em `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Opções de comando**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code>--admin</code></dt>
   <dd>Faça download dos certificados e dos arquivos de permissão para a função rbac do Administrador. Os usuários com esses arquivos podem executar ações de administrador no cluster, como remover o
cluster. Esse valor é opcional.</dd>
   </dl>

**Exemplo**:

```
bx cs cluster-config my_cluster
```
{: pre}


### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--no-subnet][--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN][--workers WORKER]
{: #cs_cluster_create}

Criar um cluster em sua organização.

<strong>Opções de comandos</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>O caminho para o arquivo YAML para criar seu cluster padrão. Em vez de definir as características de seu cluster usando as opções fornecidas nesse comando, será possível usar um arquivo YAML.  Esse valor é opcional para clusters padrão e não está disponível para clusters Lite.

<p><strong>Nota:</strong> se você fornecer a mesma opção no comando como parâmetro no arquivo YAML, o valor no comando terá precedência sobre o valor no YAML. Por exemplo, você define um local em seu arquivo YAML e usa a opção <code>--location</code> no comando, o valor inserido na opção de comando substituirá o valor no arquivo YAML.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>


<table>
    <caption>Tabela 1. Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Substitua <code><em>&lt;cluster_name&gt;</em></code> por um nome para seu cluster.</td>
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>Substitua <code><em>&lt;location&gt;</em></code> pelo local no qual você deseja criar seu cluster. Os locais disponíveis dependem da região a que você está conectado. Para listar os locais disponíveis, execute <code>bx cs locations</code>. </td>
     </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Substitua <code><em>&lt;machine_type&gt;</em></code> pelo tipo de máquina que você deseja para seus nós do trabalhador. Para listar os tipos de máquina disponíveis para seu local, execute <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Substitua <code><em>&lt;private_vlan&gt;</em></code> pelo ID da VLAN privada que você deseja usar para seus nós do trabalhador. Para listar as VLANs disponíveis, execute <code>bx cs vlans <em>&lt;location&gt;</em></code> e procure roteadores de VLAN iniciados com <code>bcr</code> (roteador de backend).</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Substitua <code><em>&lt;public_vlan&gt;</em></code> pelo ID da VLAN pública que você deseja usar para seus nós do trabalhador. Para listar as VLANs disponíveis, execute <code>bx cs vlans <em>&lt;location&gt;</em></code> e procure roteadores de VLAN iniciados com <code>fcr</code> (roteador de front-end).</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>O nível de isolamento de hardware para seu nó do trabalhador. Use dedicado se desejar que os recursos físicos disponíveis sejam dedicados somente a você ou compartilhado para permitir que os recursos físicos sejam compartilhados com outros clientes IBM. O padrão é <code>shared</code>.</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Substitua <code><em>&lt;number_workers&gt;</em></code> pelo número de nós do trabalhador que você deseja implementar.</td>
     </tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>O nível de isolamento de hardware para seu nó do trabalhador. Use dedicado para disponibilizar recursos físicos disponíveis apenas para você ou compartilhado para permitir que os recursos físicos sejam compartilhados com outros clientes da IBM. O padrão é shared.  Esse valor é opcional para clusters padrão e não está disponível para clusters Lite.</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>O local no qual você deseja criar o cluster. Os locais que estão disponíveis para você dependem da região do {{site.data.keyword.Bluemix_notm}} em que o login foi efetuado. Selecione a região fisicamente mais próxima de você para melhor desempenho.  Esse valor é obrigatório para clusters padrão e é opcional para clusters Lite.

<p>Revise [os locais disponíveis](cs_regions.html#locations).
</p>

<p><strong>Nota:</strong> ao selecionar um local fora de seu país, lembre-se de que você pode precisar de autorização legal para que os dados possam ser armazenados fisicamente em um país estrangeiro.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>O tipo de máquina que você escolhe afeta a quantia de memória e espaço em disco que está disponível para os contêineres que são implementados em seu nó do trabalhador. Para listar os tipos de máquina disponíveis, veja [bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types).  Esse valor é obrigatório para clusters padrão e não está disponível para clusters Lite.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>O nome para o cluster.  Este valor é obrigatório.</dd>

<dt><code>--no-subnet</code></dt>
<dd>Inclua a sinalização para criar um cluster sem uma sub-rede móvel. O padrão é não usar a sinalização e criar uma sub-rede em seu portfólio do IBM Bluemix Infrastructure (SoftLayer). Esse valor é opcional.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>Esse parâmetro não está disponível para clusters Lite.</li>
<li>Se esse cluster padrão for o primeiro cluster padrão que você criar nesse local, não inclua essa sinalização. Uma VLAN privada é criada para você quando o cluster é criado.</li>
<li>Se você criou um cluster padrão antes neste local ou criou uma VLAN privada em IBM Bluemix Infrastructure (SoftLayer) antes, deve-se especificar essa VLAN privada.

<p><strong>Nota:</strong> as VLANs públicas e privadas especificadas com o comando create devem corresponder. Os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador de backend) e roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador de front-end). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster. Não use VLANs públicas e privadas que não correspondem para criar um cluster.</p></li>
</ul>

<p>Para descobrir se você já tem uma VLAN privada para um local específico ou para localizar o nome de uma VLAN privada existente, execute <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>Esse parâmetro não está disponível para clusters Lite.</li>
<li>Se esse cluster padrão for o primeiro cluster padrão que você criar nesse local, não use essa sinalização. Uma VLAN pública é criada para você quando o cluster é criado.</li>
<li>Se você criou um cluster padrão antes neste local ou criou uma VLAN pública em IBM Bluemix Infrastructure (SoftLayer) antes, deve-se especificar essa VLAN pública.

<p><strong>Nota:</strong> as VLANs públicas e privadas especificadas com o comando create devem corresponder. Os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador de backend) e roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador de front-end). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster. Não use VLANs públicas e privadas que não correspondem para criar um cluster.</p></li>
</ul>

<p>Para descobrir se você já tem uma VLAN pública para um local específico ou para localizar o nome de uma VLAN pública existente, execute <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>O número de nós do trabalhador que
você deseja implementar em seu cluster. Se não
especificar essa opção, um cluster com 1 nó do trabalhador será criado. Esse valor é opcional para clusters padrão e não está disponível para clusters Lite.

<p><strong>Nota:</strong> a cada nó do trabalhador é designado um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o mestre do Kubernetes gerencie o cluster.</p></dd>
</dl>

**Exemplos**:

  

  Exemplo para um cluster padrão:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  Exemplo para um cluster lite:

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  Exemplo para um ambiente do {{site.data.keyword.Bluemix_notm}}
Dedicated:

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER
{: #cs_cluster_get}

Visualizar informações sobre um cluster em sua organização.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

Remover um cluster de sua organização.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code>-f</code></dt>
   <dd>Use esta opção para forçar a remoção de um cluster sem avisos do usuário. Esse valor é opcional.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

Incluir um serviço do {{site.data.keyword.Bluemix_notm}} em um
cluster.

**Dica:** para usuários do {{site.data.keyword.Bluemix_notm}} Dedicated, veja [Incluindo serviços do {{site.data.keyword.Bluemix_notm}} em clusters no {{site.data.keyword.Bluemix_notm}} Dedicated (Beta encerrado)](cs_cluster.html#binding_dedicated).

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>O nome do namespace do Kubernetes. Este valor é obrigatório.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>O ID da instância de serviço do {{site.data.keyword.Bluemix_notm}} que você deseja ligar. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

Remover um serviço do {{site.data.keyword.Bluemix_notm}} de um
cluster.

**Nota:** ao remover um serviço do {{site.data.keyword.Bluemix_notm}}, as credenciais de serviço são removidas do cluster. Se um pod ainda está usando o serviço,
ele falha porque as credenciais de serviço não podem ser localizadas.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>O nome do namespace do Kubernetes. Este valor é obrigatório.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>O ID da instância de serviço do {{site.data.keyword.Bluemix_notm}} que você deseja remover. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces]
{: #cs_cluster_services}

Listar os serviços que estão ligados a um ou todos os namespaces do Kubernetes em um cluster. Se nenhuma
opção é especificada, os serviços para o namespace padrão são exibidos.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Inclua os serviços que forem limitados a um namespace específico em um cluster. Esse valor é opcional.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>Inclua os serviços que forem limitados a todos os namespaces em um cluster. Esse valor é opcional.</dd>
    </dl>

**Exemplo**:

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

Faça uma sub-rede em uma conta IBM Bluemix Infrastructure (SoftLayer) disponível para um cluster especificado.

**Nota:** quando você disponibiliza uma sub-rede para um cluster, os endereços IP dessa sub-rede são usados para propósitos de rede do cluster. Para evitar conflitos de endereço IP, certifique-se de usar uma sub-rede com somente um cluster. Não use uma sub-rede para múltiplos clusters ou para outros
propósitos fora do {{site.data.keyword.containershort_notm}} ao mesmo
tempo.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>O ID da sub-rede. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}


### bx cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

Traga a sua própria sub-rede privada para os seus clusters do {{site.data.keyword.containershort_notm}}.

Essa sub-rede privada não é uma fornecida pelo IBM Bluemix Infrastructure (SoftLayer). Como tal, deve-se configurar qualquer roteamento de tráfego de rede de entrada e saída para a sub-rede. Se você deseja incluir uma sub-rede do IBM Bluemix Infrastructure (SoftLayer), use o [comando](#cs_cluster_subnet_add) `bx cs cluster-subnet-add`. 

**Nota**: ao incluir uma sub-rede de usuário privado em um cluster, os endereços IP dessa sub-rede serão usados para Balanceadores de carga privados no cluster. Para evitar conflitos de endereço IP, certifique-se de usar uma sub-rede com somente um cluster. Não use uma sub-rede para múltiplos clusters ou para outros
propósitos fora do {{site.data.keyword.containershort_notm}} ao mesmo
tempo.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>O Classless InterDomain Routing (CIDR) de sub-rede. Esse valor é obrigatório e não deverá entrar em conflito com qualquer sub-rede que for usada pelo IBM Bluemix Infrastructure (SoftLayer).

   Os prefixos suportados variam de `/30` (1 endereço IP) a `/24` (253 endereços IP). Se você definir o CIDR com um comprimento de prefixo e posteriormente precisar mudá-lo, primeiro inclua o novo CIDR, então, [remova o CIDR antigo](#cs_cluster_user_subnet_rm).</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>O ID da VLAN privada. Esse valor é necessário. Ele deverá corresponder ao ID de VLAN privada de um ou mais nós do trabalhador no cluster.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs cluster-user-subnet-add my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

Remova a sua própria sub-rede privada de um cluster especificado.

**Nota:** qualquer serviço que foi implementado em um endereço IP por meio de sua própria sub-rede privada permanecerá ativo após a sub-rede ser removida.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>O Classless InterDomain Routing (CIDR) de sub-rede. Esse valor é obrigatório e deverá corresponder ao CIDR que foi configurado pelo comando `bx cs cluster-user-subnet-add` [](#cs_cluster_user_subnet_add).</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>O ID da VLAN privada. Esse valor é obrigatório e deverá corresponder ao ID de VLAN que foi configurado pelo comando `bx cs cluster-user-subnet-add` [](#cs_cluster_user_subnet_add).</dd>
   </dl>

**Exemplo**:

  ```
  bx cs cluster-user-subnet-rm my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER
{: #cs_cluster_update}

Atualize o mestre do Kubernetes para a versão de API mais recente. Durante a atualização, não é possível acessar nem mudar o cluster. Nós do trabalhador, aplicativos e recursos que foram implementados pelo usuário não serão modificados e continuarão a ser executados.

Pode ser necessário mudar seus arquivos YAML para implementações futuras. Revise essa [nota sobre a liberação](cs_versions.html) para obter detalhes.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code>-f</code></dt>
   <dd>Use esta opção para forçar a atualização do mestre sem avisos do usuário. Esse valor é opcional.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Visualizar uma lista de clusters em sua organização.

<strong>Opções de comando</strong>:

  Nenhuma

**Exemplo**:

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

Configure as credenciais de conta do IBM Bluemix Infrastructure (SoftLayer) para a sua conta do {{site.data.keyword.Bluemix_notm}}. Essas credenciais permitem que você acesse o portfólio do IBM Bluemix Infrastructure (SoftLayer) por meio de sua conta do {{site.data.keyword.Bluemix_notm}}.

**Nota:** não configure múltiplas credenciais para uma conta do {{site.data.keyword.Bluemix_notm}}. Cada conta do {{site.data.keyword.Bluemix_notm}} é vinculada apenas a um portfólio do IBM Bluemix Infrastructure (SoftLayer).

<strong>Opções de comando</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>Um nome do usuário da conta do IBM Bluemix Infrastructure (SoftLayer). Este valor é obrigatório.</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>Uma chave API da conta do IBM Bluemix Infrastructure (SoftLayer). Esse valor é necessário.

 <p>
  Para gerar uma chave API:

  <ol>
  <li>Efetue login no portal do [IBM Bluemix Infrastructure (SoftLayer) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://control.softlayer.com/).</li>
  <li>Selecione <strong>Conta</strong> e, em seguida, <strong>Usuários</strong>.</li>
  <li>Clique em <strong>Gerar</strong> para gerar uma chave API do IBM Bluemix Infrastructure (SoftLayer) para a sua conta.</li>
  <li>Copie a chave API para usar nesse comando.</li>
  </ol>

  Para visualizar sua chave API existente:
  <ol>
  <li>Efetue login no portal do [IBM Bluemix Infrastructure (SoftLayer) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://control.softlayer.com/).</li>
  <li>Selecione <strong>Conta</strong> e, em seguida, <strong>Usuários</strong>.</li>
  <li>Clique em <strong>Visualizar</strong> para ver sua chave API existente.</li>
  <li>Copie a chave API para usar nesse comando.</li>
  </ol></p></dd>

**Exemplo**:

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Remova as credenciais de conta do IBM Bluemix Infrastructure (SoftLayer) de sua conta do {{site.data.keyword.Bluemix_notm}}. Após a remoção das credenciais, não é possível acessar o portfólio IBM Bluemix Infrastructure (SoftLayer) portfólio por meio de sua conta do {{site.data.keyword.Bluemix_notm}} mais.

<strong>Opções de comando</strong>:

   Nenhuma

**Exemplo**:

  ```
  bx cs credentials-unset
  ```
  {: pre}



### bx cs help
{: #cs_help}

Visualizar uma lista de comandos e parâmetros suportados.

<strong>Opções de comando</strong>:

   Nenhuma

**Exemplo**:

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

Inicialize o plug-in do {{site.data.keyword.containershort_notm}} ou especifique a região em que você deseja criar ou acessar clusters do Kubernetes.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>O terminal de API do {{site.data.keyword.containershort_notm}} que você deseja usar.  Esse valor é opcional. Exemplos:

    <ul>
    <li>Sul dos EUA:

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>Estados Unidos - Leste:

    <pre class="codeblock">
    <code>bx cs init --host https://us-east.containers.bluemix.net</code>
    </pre>
    <p><strong>Nota</strong>: o Leste dos EUA está disponível para uso apenas com comandos da CLI.</p></li>

    <li>Sul do Reino Unido:

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>UE Central:

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>Sul da Ásia-Pacífico:

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>




### bx cs locations
{: #cs_datacenters}

Visualizar uma lista de locais disponíveis para você criar um cluster.

<strong>Opções de comando</strong>:

   Nenhuma

**Exemplo**:

  ```
  bx cs locations
  ```
  {: pre}


### bx cs machine-types LOCATION
{: #cs_machine_types}

Visualizar uma lista de tipos de máquina disponíveis para seus nós do trabalhador. Cada tipo de máquina inclui a
quantia de CPU, memória e espaço em disco virtual para cada nó do trabalhador no cluster.

<strong>Opções de comando</strong>:

   <dl>
   <dt><em>LOCATION</em></dt>
   <dd>Insira o local no qual você deseja listar tipos de máquina disponíveis.  Esse valor é necessário. Revise [os locais disponíveis](cs_regions.html#locations).</dd></dl>

**Exemplo**:

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

Visualize uma lista de sub-redes que estão disponíveis em uma conta do IBM Bluemix Infrastructure (SoftLayer).

<strong>Opções de comando</strong>:

   Nenhuma

**Exemplo**:

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

Liste as VLANs públicas e privadas que estiverem disponíveis para um local em sua conta do IBM Bluemix Infrastructure (SoftLayer). Para listar as VLANs disponíveis, deve-se
ter uma conta paga.

<strong>Opções de comando</strong>:

   <dl>
   <dt>LOCALIDADE</dt>
   <dd>Insira o local no qual você deseja listar as suas VLANs públicas e privadas. Esse valor é necessário. Revise [os locais disponíveis](cs_regions.html#locations).</dd>
   </dl>

**Exemplo**:

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

Criar webhooks.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>O nível de notificação, como <code>Normal</code> ou <code>Warning</code>. <code>Warning</code> é o valor padrão. Esse valor é opcional.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>O tipo de webhook, como folga. Somente folga é suportado. Este valor é obrigatório.</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>A URL para o webhook. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN
{: #cs_worker_add}

Incluir nós do trabalhador no cluster padrão.

<strong>Opções de comando</strong>:

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>O caminho para o arquivo YAML para incluir nós do trabalhador em seu cluster. Em vez de definir seus nós do trabalhador adicionais usando as opções fornecidas nesse comando, será possível usar um arquivo YAML. Esse valor é opcional.

<p><strong>Nota:</strong> se você fornecer a mesma opção no comando como parâmetro no arquivo YAML, o valor no comando terá precedência sobre o valor no YAML. Por exemplo, você define um tipo de máquina em seu arquivo YAML e usa a opção --machine-type no comando, o valor inserido na opção de comando substituirá o valor no arquivo YAML.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_id&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>

<table>
<caption>Tabela 2. Entendendo os componentes de arquivo YAML</caption>
<thead>
<th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Substitua <code><em>&lt;cluster_name_or_id&gt;</em></code> pelo nome ou ID do cluster no qual você deseja incluir nós do trabalhador.</td>
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>Substitua <code><em>&lt;location&gt;</em></code> pelo local no qual você deseja implementar seus nós do trabalhador. Os locais disponíveis dependem da região a que você está conectado. Para listar os locais disponíveis, execute <code>bx cs locations</code>.</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Substitua <code><em>&lt;machine_type&gt;</em></code> pelo tipo de máquina que você deseja para seus nós do trabalhador. Para listar os tipos de máquina disponíveis para seu local, execute <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Substitua <code><em>&lt;private_vlan&gt;</em></code> pelo ID da VLAN privada que você deseja usar para seus nós do trabalhador. Para listar as VLANs disponíveis, execute <code>bx cs vlans <em>&lt;location&gt;</em></code> e procure roteadores de VLAN iniciados com <code>bcr</code> (roteador de backend).</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Substitua <code>&lt;public_vlan&gt;</code> pelo ID da VLAN pública que você deseja usar para seus nós do trabalhador. Para listar as VLANs disponíveis, execute <code>bx cs vlans &lt;location&gt;</code> e procure roteadores de VLAN iniciados com <code>fcr</code> (roteador de front-end).</td>
</tr>
<tr>
<td><code>Hardware</code></td>
<td>O nível de isolamento de hardware para seu nó do trabalhador. Use dedicado se desejar que os recursos físicos disponíveis sejam dedicados somente a você ou compartilhado para permitir que os recursos físicos sejam compartilhados com outros clientes IBM. O padrão é shared.</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Substitua <code><em>&lt;number_workers&gt;</em></code> pelo número de nós do trabalhador que você deseja implementar.</td>
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>O nível de isolamento de hardware para seu nó do trabalhador. Use dedicado se desejar que os recursos físicos disponíveis sejam dedicados somente a você ou compartilhado para permitir que os recursos físicos sejam compartilhados com outros clientes IBM. O padrão é shared. Esse valor é opcional.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>O tipo de máquina que você escolhe afeta a quantia de memória e espaço em disco que está disponível para os contêineres que são implementados em seu nó do trabalhador. Esse valor é necessário. Para listar os tipos de máquina disponíveis, veja [bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types).</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>Um número inteiro que representa o número de nós do trabalhador a serem criados no cluster. O valor padrão é 1. Esse valor é opcional.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>A VLAN privada que foi especificada quando o cluster foi criado. Esse valor é necessário.

<p><strong>Nota:</strong> as VLANs públicas e privadas que você especificar deverão corresponder. Os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador de backend) e roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador de front-end). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster. Não use VLANs públicas e privadas que não correspondem para criar um cluster.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>A VLAN pública que foi especificada quando o cluster foi criado. Esse valor é opcional.

<p><strong>Nota:</strong> as VLANs públicas e privadas que você especificar deverão corresponder. Os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador de backend) e roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador de front-end). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster. Não use VLANs públicas e privadas que não correspondem para criar um cluster.</p></dd>
</dl>

**Exemplos**:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  Exemplo para o {{site.data.keyword.Bluemix_notm}} Dedicated:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

Visualizar detalhes de um nó do trabalhador.

<strong>Opções de comando</strong>:

   <dl>
   <dt><em>WORKER_NODE_ID</em></dt>
   <dd>O ID para um nó do trabalhador. Execute <code>bx cs workers <em>CLUSTER</em></code> para visualizar os IDs para os nós do trabalhador em um cluster. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs worker-get WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

Reinicializar os nós do trabalhador em um cluster. Se existir um problema com um nó do trabalhador, primeiro tente reinicializar o nó do trabalhador, que o reinicia. Se a reinicialização não resolver o problema, tente o
comando `worker-reload`. O estado dos trabalhadores não muda durante a reinicialização. O estado permanece `deployed`, mas o status é atualizado.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code>-f</code></dt>
   <dd>Use esta opção para forçar a reinicialização do nó do trabalhador sem avisos do usuário. Esse valor é opcional.</dd>

   <dt><code>--hard</code></dt>
   <dd>Use esta opção para forçar uma reinicialização forçada de um nó do trabalhador cortando a energia para o nó do trabalhador. Use essa opção se o nó do trabalhador não responder ou se ele tiver uma interrupção do
Docker. Esse valor é opcional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>O nome ou ID de um ou mais nós do trabalhador. Use um espaço para listar múltiplos nós do
trabalhador. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

Recarregar os nós do trabalhador em um cluster. Se existir um problema com um nó do trabalhador, primeiro tente reinicializar o nó do trabalhador. Se a reinicialização não resolver o problema, tente o
comando `worker-reload`, que recarrega todas as configurações necessárias para o
nó do trabalhador.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code>-f</code></dt>
   <dd>Use esta opção para forçar a recarga de um nó do trabalhador sem avisos do usuário. Esse valor é opcional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>O nome ou ID de um ou mais nós do trabalhador. Use um espaço para listar múltiplos nós do
trabalhador. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

Remover um ou mais nós do trabalhador de um cluster.

<strong>Opções de comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>O nome ou ID do cluster. Este valor é obrigatório.</dd>

   <dt><code>-f</code></dt>
   <dd>Use esta opção para forçar a remoção de um nó do trabalhador sem avisos do usuário. Esse valor é opcional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>O nome ou ID de um ou mais nós do trabalhador. Use um espaço para listar múltiplos nós do
trabalhador. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_update}

Atualize os nós do trabalhador para a versão do Kubernetes mais recente. A execução de `bx cs worker-update` poderá causar tempo de inatividade para os seus aplicativos e serviços. Durante a atualização, todos os pods serão reprogramados sobre outros nós do trabalhador e os dados serão excluídos, se não forem armazenados fora do pod. Para evitar tempo de inatividade, assegure-se de ter nós do trabalhador suficientes para manipular a sua carga de trabalho enquanto os nós do trabalhador selecionados estiverem sendo atualizados.

Pode ser necessário mudar seus arquivos YAML para implementações antes de atualizar. Revise essa [nota sobre a liberação](cs_versions.html) para obter detalhes.

<strong>Opções de comando</strong>:

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>O nome ou ID do cluster no qual você lista nós do trabalhador disponíveis. Este valor é obrigatório.</dd>

   <dt><code>-f</code></dt>
   <dd>Use esta opção para forçar a atualização do mestre sem avisos do usuário. Esse valor é opcional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>O ID de um ou mais nós do trabalhador. Use um espaço para listar múltiplos nós do
trabalhador. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs worker-update my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

Visualizar uma lista de nós do trabalhador e o status de cada um deles em um cluster.

<strong>Opções de comando</strong>:

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>O nome ou ID do cluster no qual você lista nós do trabalhador disponíveis. Este valor é obrigatório.</dd>
   </dl>

**Exemplo**:

  ```
  bx cs workers mycluster
  ```
  {: pre}
