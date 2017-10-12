---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Resolvendo Problemas de Clusters
{: #cs_troubleshoot}

Durante a utilização do {{site.data.keyword.containershort_notm}}, considere estas técnicas para resolução de problemas e obtenção de ajuda.

{: shortdesc}


## Depurando clusters
{: #debug_clusters}

Revise as opções que você tem para depurar seus clusters e localizar as causas raízes das falhas.

1.  Liste o cluster e localize o `Estado` dele.

  ```
  bx cs clusters
  ```
  {: pre}

2.  Revise o `Estado` do cluster.

  <table summary="Cada linha da tabela deve ser lida da esquerda para a direita, com o estado do cluster na coluna um e uma descrição na coluna dois.">
    <thead>
    <th>Estado do cluster</th>
    <th>Descrição</th>
    </thead>
    <tbody>
      <tr>
        <td>Implementando</td>
        <td>O mestre do Kubernetes não está totalmente implementado ainda. Não é possível acessar seu cluster.</td>
       </tr>
       <tr>
        <td>Pendente</td>
        <td>O mestre do Kubernetes foi implementado. Os nós do trabalhador estão sendo provisionados e ainda não estão disponíveis no cluster. É possível acessar o cluster, mas não é possível implementar apps no cluster.</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Todos os nós do trabalhador em um cluster estão funcionando. É possível acessar o cluster e implementar apps no cluster.</td>
     </tr>
     <tr>
        <td>Avisar</td>
        <td>Pelo menos um nó do trabalhador no cluster não está disponível, mas outros nós do trabalhador estão disponíveis e podem assumir o controle da carga de trabalho.</td>
     </tr>
     <tr>
      <td>Crítico</td>
      <td>O mestre do Kubernetes não pode ser atingido ou todos os nós do trabalhador no cluster estão inativos.</td>
     </tr>
    </tbody>
  </table>

3.  Se o cluster estiver em um estado de **Aviso** ou **Crítico** ou estiver preso no estado **Pendente** por muito tempo, revise o estado dos nós do trabalhador. Se o cluster estiver em um estado **Implementando**, aguarde até que ele esteja totalmente implementado para revisar seu funcionamento. Os clusters em um estado **Normal** são considerados funcionais e não requerem uma ação no momento. 

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

  <table summary="Cada linha da tabela deve ser lida da esquerda para a direita, com o estado do cluster na coluna um e uma descrição na coluna dois.">
    <thead>
    <th>Estado do nó do trabalhador</th>
    <th>Descrição</th>
    </thead>
    <tbody>
      <tr>
       <td>Desconhecido</td>
       <td>O mestre do Kubernetes não está acessível por um dos motivos a seguir:<ul><li>Você solicitou uma atualização do mestre do Kubernetes. O estado do nó do trabalhador não pode ser recuperado durante a atualização.</li><li>É possível que você tenha um firewall adicional que esteja protegendo seus nós do trabalhador ou que tenha mudado as configurações do firewall recentemente. O {{site.data.keyword.containershort_notm}} requer que determinados endereços IP e portas sejam abertos para permitir a comunicação do nó do trabalhador com o mestre do Kubernetes e vice-versa. Para obter mais informações, veja [Os nós do trabalhador estão presos em um loop de recarregamento](#cs_firewall).</li><li>O mestre do Kubernetes está inativo. Entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}} abrindo um chamado de suporte do [{{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ul></td>
      </tr>
      <tr>
        <td>Provisionando</td>
        <td>O nó do trabalhador está sendo provisionado e ainda não está disponível no cluster. É possível monitorar o processo de fornecimento na coluna **Status** da saída da CLI. Se o nó do trabalhador ficar preso nesse estado por muito tempo e não for possível ver nenhum progresso na coluna **Status**, continue com a próxima etapa para ver se ocorreu um problema durante o fornecimento.</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>O nó do trabalhador não pôde ser provisionado. Continue com a próxima etapa para localizar os detalhes da falha.</td>
      </tr>
      <tr>
        <td>Recarregando</td>
        <td>O nó do trabalhador está sendo recarregado e não está disponível no cluster. É possível monitorar o processo de recarregamento na coluna **Status** da saída da CLI. Se o nó do trabalhador ficar preso nesse estado por muito tempo e não for possível ver nenhum progresso na coluna **Status**, continue com a próxima etapa para ver se ocorreu um problema durante o recarregamento.</td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>O nó do trabalhador não pôde ser recarregado. Continue com a próxima etapa para localizar os detalhes da falha.</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>O nó do trabalhador está totalmente provisionado e pronto para ser usado no cluster.</td>
     </tr>
     <tr>
        <td>Avisar</td>
        <td>O nó do trabalhador está atingindo o limite para memória ou espaço em disco.</td>
     </tr>
     <tr>
      <td>Crítico</td>
      <td>O nó do trabalhador ficou sem espaço em disco.</td>
     </tr>
    </tbody>
  </table>

4.  Liste os detalhes para o nó do trabalhador.

  ```
  bx cs worker-get <worker_node_id>
  ```
  {: pre}

5.  Revise as mensagens de erro comuns e saiba como resolvê-las.

  <table>
    <thead>
    <th>A mensagem de erro</th>
    <th>Descrição e resolução
    </thead>
    <tbody>
      <tr>
        <td>Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: sua conta está atualmente proibida de pedir 'Instâncias de cálculo'.</td>
        <td>A conta do {{site.data.keyword.BluSoftlayer_notm}} pode ser restringida de pedir recursos de cálculo. Entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}} abrindo um chamado de suporte do [{{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</td>
      </tr>
      <tr>
        <td>Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: não foi possível fazer a ordem. Há recursos insuficientes atrás do roteador 'router_name' para preencher a solicitação para os convidados a seguir: 'worker_id'.</td>
        <td>A VLAN selecionada está associada a um pod no data center que possui espaço insuficiente para provisionar o nó do trabalhador. Você pode escolher entre as seguintes opções:<ul><li>Use um data center diferente para provisionar o nó do trabalhador. Execute <code>bx cs locations</code> para listar o data center disponível.<li>Se você tiver um par existente de VLAN pública e privada que esteja associado a outro pod no data center, use esse par de VLAN como alternativa.<li>Entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}} abrindo um chamado de suporte do [{{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</ul></td>
      </tr>
      <tr>
        <td>Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: não foi possível obter a VLAN de rede com o ID: &lt;vlan id&gt;.</td>
        <td>O nó do trabalhador não pôde ser provisionado porque o ID de VLAN selecionado não pôde ser localizado por um dos motivos a seguir:<ul><li>Talvez você tenha especificado o número da VLAN, em vez do ID da VLAN. O número da VLAN tem 3 ou 4 dígitos de comprimento, enquanto o ID da VLAN tem 7 dígitos. Execute <code>bx cs vlans &lt;location&gt;</code> para recuperar o ID da VLAN.<li>O ID da VLAN pode não estar associado à conta de Infraestrutura do Bluemix (SoftLayer) usada. Execute <code>bx cs vlans &lt;location&gt;</code> para listar os IDs de VLAN disponíveis para sua conta. Para mudar a conta do {{site.data.keyword.BluSoftlayer_notm}}, veja [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: o local fornecido para essa ordem é inválido. (HTTP 500)</td>
        <td>O {{site.data.keyword.BluSoftlayer_notm}} não está configurado para pedir recursos de cálculo no data center selecionado. Entre em contato com o [suporte do {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support) para verificar se a conta está configurada corretamente.</td>
       </tr>
       <tr>
        <td>Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: o usuário não tem as permissões de infraestrutura necessárias do {{site.data.keyword.Bluemix_notm}} para incluir servidores
        
        </br></br>
        Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: 'Item' deve ser pedido com permissão.</td>
        <td>Talvez você não tenha as permissões necessárias para provisionar um nó do trabalhador do portfólio do {{site.data.keyword.BluSoftlayer_notm}}. Para localizar as permissões necessárias, veja [Configurar o acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}} para criar clusters padrão do Kubernetes](cs_planning.html#cs_planning_unify_accounts).</td>
      </tr>
    </tbody>
  </table>

## Não é possível se conectar à conta do IBM {{site.data.keyword.BluSoftlayer_notm}} durante a criação de um cluster
{: #cs_credentials}

{: tsSymptoms}
Ao criar um novo cluster do Kubernetes, você receberá a mensagem a seguir.

```
We were unable to connect to your {{site.data.keyword.BluSoftlayer_notm}} account. Creating a standard cluster requires that you have either a Pay-As-You-Go account that is linked to an {{site.data.keyword.BluSoftlayer_notm}} account term or that you have used the IBM
{{site.data.keyword.Bluemix_notm}} Container Service CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

{: tsCauses}
Os usuários com uma conta do {{site.data.keyword.Bluemix_notm}} desvinculada devem criar uma nova conta Pagamento por uso ou incluir manualmente as chaves API do {{site.data.keyword.BluSoftlayer_notm}} usando a CLI do {{site.data.keyword.Bluemix_notm}}.

{: tsResolve}
Para incluir credenciais na conta do {{site.data.keyword.Bluemix_notm}}:

1.  Entre em contato com o administrador do {{site.data.keyword.BluSoftlayer_notm}} para obter o nome do usuário e a chave API do {{site.data.keyword.BluSoftlayer_notm}}.

    **Nota:** a conta do {{site.data.keyword.BluSoftlayer_notm}} que for usada deverá ser configurada com permissões de Superusuário para criar clusters padrão com êxito.

2.  Inclua as credenciais.

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  Crie um cluster padrão.

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}


## O acesso a seu nó do trabalhador com SSH falha
{: #cs_ssh_worker}

{: tsSymptoms}
Não é possível acessar seu nó do trabalhador usando uma conexão SSH.

{: tsCauses}
O SSH via senha está desativado nos nós do trabalhador.

{: tsResolve}
Use [DaemonSets ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para qualquer coisa que precisar ser executada em cada nó ou tarefas para qualquer ação única que precisar ser executada.


## Os pods permanecem no estado pendente
{: #cs_pods_pending}

{: tsSymptoms}
Ao executar `kubectl get pods`, será possível ver pods que permanecem em um estado **Pendente**.

{: tsCauses}
Se você acabou de criar o cluster do Kubernetes, os nós do trabalhador podem ainda estar configurando. Se esse cluster for um existente, você talvez não tenha capacidade suficiente no cluster para implementar o pod.

{: tsResolve}
Esta tarefa requer uma [política de acesso de Administrador](cs_cluster.html#access_ov). Verifique sua [política de acesso atual](cs_cluster.html#view_access).

Se você acabou de criar o cluster do Kubernetes, execute o comando a seguir e aguarde a inicialização dos nós do trabalhador.

```
kubectl get nodes
```
{: pre}

Se esse cluster for um existente, verifique a capacidade dele.

1.  Configure o proxy com o número da porta padrão.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Abra o painel do Kubernetes.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Verifique se há capacidade suficiente no cluster para implementar o pod.

4.  Se não houver capacidade suficiente no cluster, inclua outro nó do trabalhador no cluster.

  ```
  bx cs worker-add <cluster name or id> 1
  ```
  {: pre}

5.  Se os pods ainda estiverem em um estado **pendente** depois que o nó do trabalhador for totalmente implementado, revise a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) para solucionar posteriormente os problemas no estado pendente do pod.

## A criação do nó do trabalhador falha com a mensagem provision_failed
{: #cs_pod_space}

{: tsSymptoms}
Ao criar um cluster do Kubernetes ou incluir nós do trabalhador, você verá um estado provision_failed. Execute o comando a seguir.

```
bx cs worker-get <WORKER_NODE_ID>
```
{: pre}

A seguinte mensagem é exibida.

```
SoftLayer_Exception_Virtual_Host_Pool_InsufficientResources: Could not place order. There are insufficient resources behind router bcr<router_ID> to fulfill the request for the following guests: kube-<location>-<worker_node_ID>-w1 (HTTP 500)
```
{: screen}

{: tsCauses}
O {{site.data.keyword.BluSoftlayer_notm}} pode não ter capacidade suficiente neste momento para provisionar o nó do trabalhador.

{: tsResolve}
Opção 1: criar o cluster em outro local.

Opção 2: abrir um problema de suporte com o {{site.data.keyword.BluSoftlayer_notm}} e perguntar sobre a disponibilidade de capacidade no local.

## Acessar um pod em um novo nó do trabalhador falha com um tempo limite
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Você excluiu um nó do trabalhador no cluster e, em seguida, incluiu um nó do trabalhador. Ao implementar um pod ou um serviço do Kubernetes, o recurso não pode acessar o nó do trabalhador recém-criado e os tempos de conexão se esgotam.

{: tsCauses}
Se você excluir um nó do trabalhador do cluster e, em seguida, incluir um nó do trabalhador, será possível que o novo nó do trabalhador seja designado ao endereço IP privado do nó do trabalhador excluído. O Calico usa esse endereço IP privado como uma tag e continua tentando acessar o nó excluído.

{: tsResolve}
Atualize manualmente a referência do endereço IP privado para apontar para o nó correto.

1.  Confirme que você tem dois nós do trabalhador com o mesmo endereço **IP privado**. Observe o **IP privado** e o **ID** do trabalhador excluído.

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b1c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b1c.4x16       deleted    -
  ```
  {: screen}

2.  Instale a [CLI do Calico](cs_security.html#adding_network_policies).
3.  Liste os nós do trabalhador disponíveis no Calico. Substitua <path_to_file> pelo caminho local para o arquivo de configuração do Calico.

  ```
  calicoctl get nodes --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Exclua o nó do trabalhador duplicado no Calico. Substitua NODE_ID pelo ID do nó do trabalhador.

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  Reinicialize o nó do trabalhador que não foi excluído.

  ```
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


O nó excluído não é mais listado no Calico.

## Os nós do trabalhador falham ao se conectar
{: #cs_firewall}

{: tsSymptoms}
Quando o proxy Kubectl falha ou você tenta acessar um serviço em seu cluster e sua conexão falha com uma das mensagens de erro a seguir:

  ```
  Conexão recusada
  ```
  {: screen}

  ```
  Conexão expirada
  ```
  {: screen}

  ```
  Não é possível se conectar ao servidor: net/http: tempo limite do handshake do TLS
  ```
  {: screen}

Ou quando você usa kubectl exec, attach ou logs e recebe este erro:

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Ou quando o proxy kubectl é bem-sucedido, mas o painel não está disponível e você recebe este erro:

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}

Ou quando os nós do trabalhador estão presos em um loop recarregamento.

{: tsCauses}
Você pode ter um firewall adicional configurado ou customizado nas configurações de firewall existentes em sua conta do {{site.data.keyword.BluSoftlayer_notm}}. O {{site.data.keyword.containershort_notm}} requer que determinados endereços IP e portas sejam abertos para permitir a comunicação do nó do trabalhador com o mestre do Kubernetes e vice-versa.

{: tsResolve}
Esta tarefa requer uma [política de acesso de Administrador](cs_cluster.html#access_ov). Verifique sua [política de acesso atual](cs_cluster.html#view_access).

Abra as portas e os endereços IP a seguir em seu firewall customizado.
```
TCP port 443 FROM '<each_worker_node_publicIP>' TO registry.ng.bluemix.net, apt.dockerproject.org
```
{: pre}


<!--Inbound left for existing clusters. Once existing worker nodes are reloaded, users only need the Outbound information, which is found in the regular docs.-->

1.  Anote o endereço IP público para todos os nós do trabalhador no cluster:

  ```
  bx cs workers '<cluster_name_or_id>'
  ```
  {: pre}

2.  Em seu firewall, permita as conexões a seguir para/de seus nós do trabalhador:

  ```
  TCP port 443 FROM '<each_worker_node_publicIP>' TO registry.ng.bluemix.net, apt.dockerproject.org
  ```
  {: pre}

    <ul><li>Para conectividade de ENTRADA para os nós do trabalhador, permita tráfego de rede recebido dos grupos de rede e endereços IP de origem a seguir para a porta TCP/UDP 10250 de destino e `<public_IP_of _each_worker_node>`:</br>
    
    <table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> Endereços IP de entrada</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.144.128/28</code></br><code>169.50.169.104/29</code></br><code>169.50.185.32/27</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.232/29</code></br><code>169.48.138.64/26</code></br><code>169.48.180.128/25</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.8/29</code></br><code>169.47.79.192/26</code></br><code>169.47.126.192/27</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.48.160/28</code></br><code>169.50.56.168/29</code></br><code>169.50.58.160/27</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.68.192/26</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.209.192/26</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.67.0/26</code></td>
      </tr>
    </table>

    <li>Para conectividade de SAÍDA dos nós do trabalhador, permita tráfego de rede de saída do nó do trabalhador de origem para o intervalo de portas TCP/UDP de destino 20.000 a 32.767, para `<each_worker_node_publicIP>` e os endereços IP e grupos de rede a seguir:</br>
    
    <table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> Endereços IP de saída</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>
    
    

## Falha ao conectar-se a um app por meio de Ingresso
{: #cs_ingress_fails}

{: tsSymptoms}
Você expôs publicamente seu app criando um recurso de Ingresso para seu app no cluster. Quando tentou se conectar ao app por meio do endereço IP público ou do subdomínio do controlador de Ingresso, a conexão falhou ou atingiu o tempo limite.

{: tsCauses}
O Ingresso pode não estar funcionando corretamente pelos motivos a seguir:
<ul><ul>
<li>O cluster não está totalmente implementado ainda.
<li>O cluster foi configurado como um cluster lite ou como um cluster padrão com apenas um nó do trabalhador.
<li>O script de configuração de Ingresso inclui erros.
</ul></ul>

{: tsResolve}
Para solucionar problemas do Ingresso:

1.  Verifique se configura um cluster padrão totalmente implementado e se tem pelo menos dois nós do trabalhador para assegurar alta disponibilidade para o controlador de Ingresso.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    Na saída da CLI, certifique-se de que o **Status** dos nós do trabalhador exiba **Pronto** e que o **Tipo de máquina** mostre um tipo de máquina diferente de **livre**.

2.  Recupere o subdomínio e o endereço IP público do controlador de Ingresso e, em seguida, execute ping de cada um.

    1.  Recupere o subdomínio do controlador de Ingresso.

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Execute ping do subdomínio do controlador de Ingresso.

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Recupere o endereço IP público do controlador de Ingresso.

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Execute ping do endereço IP público do controlador de Ingresso.

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    Se a CLI retornar um tempo limite para o endereço IP público ou o subdomínio do controlador de Ingresso e você tiver configurado um firewall customizado que esteja protegendo os nós do trabalhador, poderá ser necessário abrir portas e grupos de rede adicionais no [firewall](#cs_firewall).

3.  Se você estiver usando um domínio customizado, certifique-se de que seu domínio customizado seja mapeado para o endereço IP público ou o subdomínio do controlador de Ingresso fornecido pela IBM com o provedor Domain Name Service (DNS).
    1.  Se tiver usado o subdomínio do controlador de Ingresso, verifique seu registro de Nome canônico (CNAME).
    2.  Se tiver usado o endereço IP público do controlador de Ingresso, verifique se o seu domínio customizado está mapeado para o endereço IP público móvel no Registro de ponteiro (PTR).
4.  Verifique o arquivo de configuração do Ingresso.

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress_subdomain>
        secretName: <ingress_tlssecret>
      rules:
      - host: <ingress_subdomain>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  Verifique se o subdomínio do controlador de Ingresso e o certificado TLS estão corretos. Para localizar o subdomínio fornecido pela IBM e o certificado TLS, execute bx cs cluster-get <cluster_name_or_id>.
    2.  Certifique-se de que seu app atenda no mesmo caminho configurado na seção de **caminho** de seu Ingresso. Se o seu app estiver configurado para atender no caminho raiz, inclua **/** como seu caminho.
5.  Verifique sua implementação do Ingresso e procure mensagens de erro em potencial.

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  Verifique os logs para o seu controlador de Ingresso.
    1.  Recupere o ID dos pods do Ingresso que estão em execução no cluster.

      ```
      kubectl get pods -n kube-system |grep ingress
      ```
      {: pre}

    2.  Recupere os logs para cada pod do Ingresso.

      ```
      kubectl logs <ingress_pod_id> -n kube-system
      ```
      {: pre}

    3.  Procure mensagens de erro nos logs do controlador de Ingresso.

## Falha ao conectar-se a um app por meio de um serviço de balanceador de carga
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Você expôs publicamente seu app criando um serviço de balanceador de carga no cluster. Quando tentou se conectar ao app por meio do endereço IP público ou do balanceador de carga, a conexão falhou ou atingiu o tempo limite.

{: tsCauses}
O serviço de balanceador de carga pode não estar funcionando corretamente por um dos motivos a seguir:

-   O cluster é um cluster lite ou um cluster padrão com apenas um nó do trabalhador.
-   O cluster não está totalmente implementado ainda.
-   O script de configuração para o serviço de balanceador de carga inclui erros.

{: tsResolve}
Para solucionar problemas do serviço de balanceador de carga:

1.  Verifique se configura um cluster padrão totalmente implementado e se tem pelo menos dois nós do trabalhador para assegurar alta disponibilidade para o serviço de balanceador de carga.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    Na saída da CLI, certifique-se de que o **Status** dos nós do trabalhador exiba **Pronto** e que o **Tipo de máquina** mostre um tipo de máquina diferente de **livre**.

2.  Verifique a precisão do arquivo de configuração para o serviço de balanceador de carga.

  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: myservice
  spec:
    type: LoadBalancer
    selector:
      <selectorkey>:<selectorvalue>
    ports:
     - protocol: TCP
       port: 8080
  ```
  {: pre}

    1.  Verifique se definiu **LoadBlanacer** como o tipo do serviço.
    2.  Certifique-se de que tenha usado os mesmos **<selectorkey>** e **<selectorvalue>** usados na seção **rótulo/metadados** de quando implementou o app.
    3.  Verifique se usou a **porta** em que seu app atende.

3.  Verifique o serviço de balanceador de carga e revise a seção **Eventos** para localizar erros em potencial.

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    Procure as mensagens de erro a seguir:
    <ul><ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Para usar o serviço de balanceador de carga, deve-se ter um cluster padrão com pelo menos dois nós do trabalhador.
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Essa mensagem de erro indica que não sobrou nenhum endereço IP público móvel para ser alocado para o serviço de balanceador de carga. Consulte [Incluindo sub-redes nos clusters](cs_cluster.html#cs_cluster_subnet) para localizar informações sobre como solicitar endereços IP públicos móveis para seu cluster. Depois que os endereços IP públicos móveis estiverem disponíveis para o cluster, o serviço de balanceador de carga será criado automaticamente.
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips</code></pre></br>Você definiu um endereço IP público móvel para o serviço de balanceador de carga usando a seção **loadBalancerIP**, mas esse endereço IP público móvel não está disponível em sua sub-rede pública móvel. Mude o script de configuração do serviço de balanceador de carga e escolha um dos endereços IP públicos móveis disponíveis ou remova a seção **loadBalancerIP** de seu script para que um endereço IP público móvel disponível possa ser alocado automaticamente.
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Você não tem nós do trabalhador suficientes para implementar um serviço de balanceador de carga. Um motivo talvez seja que você tenha implementado um cluster padrão com mais de um nó do trabalhador, mas o fornecimento dos nós do trabalhador tenha falhado.
    <ol><li>Liste os nós do trabalhador disponíveis.</br><pre class="codeblock"><code>kubectl get nodes</code></pre>
    <li>Se pelo menos dois nós do trabalhador disponíveis forem localizados, liste os detalhes do nó do trabalhador.</br><pre class="screen"><code>bx cs worker-get <worker_ID></code></pre>
    <li>Certifique-se de que os IDs da VLAN pública e privada dos nós do trabalhador que foram retornados pelos comandos 'kubectl get nodes' e 'bx cs worker-get' correspondam.</ol></ul></ul>

4.  Se você estiver usando um domínio customizado para se conectar ao serviço de balanceador de carga, certifique-se de que seu domínio customizado seja mapeado para o endereço IP público do serviço de balanceador de carga.
    1.  Localize o endereço IP público do serviço de balanceador de carga.

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Verifique se o seu domínio customizado está mapeado para o endereço IP público móvel do serviço de balanceador de carga no registro de Ponteiro (PTR).

## Problemas conhecidos
{: #cs_known_issues}

Aprenda sobre os problemas conhecidos.
{: shortdesc}

### Clusters
{: #ki_clusters}

<dl>
  <dt>Os apps Cloud Foundry no mesmo espaço do {{site.data.keyword.Bluemix_notm}} não podem acessar um cluster</dt>
    <dd>Ao criar um cluster do Kubernetes, o cluster é criado no nível de conta e não usa o espaço, exceto quando você liga serviços do {{site.data.keyword.Bluemix_notm}}. Se você desejar que o cluster acesse um app Cloud Foundry, deve-se tornar o app Cloud Foundry ou o app em seu cluster [publicamente disponíveis](cs_planning.html#cs_planning_public_network).</dd>
  <dt>Serviço NodePort do painel Kube foi desativado</dt>
    <dd>Por motivos de segurança, o serviço NodePort do painel do Kubernetes está desativado. Para acessar seu painel do Kubernetes, execute o comando a seguir.</br><pre class="codeblock"><code>kubectl proxy</code></pre></br>Em seguida, será possível acessar o painel do Kubernetes em `http://localhost:8001/ui`.</dd>
  <dt>Limitações com o tipo de serviço de balanceador de carga</dt>
    <dd><ul><li>Não é possível usar o balanceamento de carga em VLANs privadas.<li>Não é possível usar as anotações de serviço service.beta.kubernetes.io/external-traffic e service.beta.kubernetes.io/healthcheck-nodeport. Para obter mais informações sobre essas anotações, veja a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tutorials/services/source-ip/).</ul></dd>
  <dt>O auto-scaling horizontal não funciona</dt>
    <dd>Por motivos de segurança, a porta padrão usada por Heapster (10255) fica fechada em todos os nós do trabalhador. Como essa porta está fechada, o Heapster não consegue relatar métricas para nós do trabalhador e o auto-scaling horizontal não pode funcionar conforme documentado em [Auto-scaling do pod horizontal ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) na documentação do Kubernetes.</dd>
</dl>

### Armazenamento Persistente
{: #persistent_storage}

O comando `kubectl describe <pvc_name>` exibe **ProvisioningFailed** para uma solicitação de volume persistente:
<ul><ul>
<li>Ao criar uma solicitação de volume persistente, nenhum volume persistente está disponível, portanto o Kubernetes retorna a mensagem **ProvisioningFailed**.
<li>Quando o volume persistente é criado e ligado à solicitação, o Kubernetes retorna a mensagem **ProvisioningSucceeded**. Esse processo pode levar alguns minutos.
</ul></ul>

## Obtendo ajuda e suporte
{: #ts_getting_help}

Onde você inicia a resolução de problemas de um contêiner?

-   Para ver se o {{site.data.keyword.Bluemix_notm}} está disponível, [verifique a página de status do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).
-   Poste uma pergunta no [Slack do {{site.data.keyword.containershort_notm}}. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com) Se você não estiver usando um IBMid para sua conta do {{site.data.keyword.Bluemix_notm}}, entre em contato com [crosen@us.ibm.com](mailto:crosen@us.ibm.com) e solicite um convite para esse Slack.
-   Revise os fóruns para ver se outros usuários tiveram o mesmo problema. Ao usar os fóruns para fazer uma pergunta, marque sua pergunta para que ela seja vista pelas equipes de desenvolvimento do {{site.data.keyword.Bluemix_notm}}.

    -   Se tiver questões técnicas sobre como desenvolver ou implementar clusters ou apps com o {{site.data.keyword.containershort_notm}}, poste sua pergunta no [Stack Overflow ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://stackoverflow.com/search?q=bluemix+containers) e identifique a sua pergunta com `ibm-bluemix`, `kubernetes` e `containers`.
    -   Para perguntas sobre o serviço e instruções de introdução, use o fórum [IBM developerWorks dW Answers ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Inclua as tags `bluemix` e `containers`.
    Consulte [Obtendo ajuda](/docs/support/index.html#getting-help) para obter mais detalhes sobre o uso dos fóruns.

-   Entre em contato com o Suporte IBM. Para obter informações sobre como abrir um chamado de suporte IBM ou sobre níveis de suporte e severidades de chamado, consulte [Entrando em contato com o suporte](/docs/support/index.html#contacting-support).
