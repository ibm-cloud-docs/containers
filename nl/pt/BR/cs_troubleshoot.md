---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

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

Ao usar {{site.data.keyword.containershort_notm}}, considere estas técnicas para resolução de problemas e obtenção de ajuda. Também é possível verificar o [status do sistema {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).

É possível levar algumas etapas gerais para assegurar que seus clusters estejam atualizados:
- [Reinicialize seus nós do trabalhador](cs_cli_reference.html#cs_worker_reboot) regularmente para assegurar a instalação de atualizações e correções de segurança que a IBM implementa automaticamente no sistema operacional
- Atualize seu cluster para [a versão padrão mais recente do Kubernetes](cs_versions.html) para {{site.data.keyword.containershort_notm}}

{: shortdesc}

<br />




## Depurando clusters
{: #debug_clusters}

Revise as opções para depurar seus clusters e localizar as causas raízes das falhas.

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
      <td>Crítico</td>
      <td>O mestre do Kubernetes não pode ser atingido ou todos os nós do trabalhador no cluster estão inativos.</td>
     </tr>
  
      <tr>
        <td>Implementando</td>
        <td>O mestre do Kubernetes não está totalmente implementado ainda. Não é possível acessar seu cluster.</td>
       </tr>
       <tr>
        <td>Normal</td>
        <td>Todos os nós do trabalhador em um cluster estão funcionando. É possível acessar o cluster e implementar apps no cluster.</td>
     </tr>
       <tr>
        <td>Pendente</td>
        <td>O mestre do Kubernetes foi implementado. Os nós do trabalhador estão sendo provisionados e ainda não estão disponíveis no cluster. É possível acessar o cluster, mas não é possível implementar apps no cluster.</td>
      </tr>
  
     <tr>
        <td>Avisar</td>
        <td>Pelo menos um nó do trabalhador no cluster não está disponível, mas outros nós do trabalhador estão disponíveis e podem assumir o controle da carga de trabalho.</td>
     </tr>  
    </tbody>
  </table>

3.  Se o cluster estiver em um estado de **Aviso**, **Crítico** ou de **Falha na exclusão** ou estiver preso no estado **Pendente** por muito tempo, revise o estado dos nós do trabalhador. Se o cluster estiver em um estado **Implementando**, aguarde até que ele esteja totalmente implementado para revisar seu funcionamento. Os clusters em um estado **Normal** não requerem uma ação no momento. 
<p>Para revisar o estado de seus nós do trabalhador:</p>

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
       <td>O mestre do Kubernetes não está acessível por um dos motivos a seguir:<ul><li>Você solicitou uma atualização do mestre do Kubernetes. O estado do nó do trabalhador não pode ser recuperado durante a atualização.</li><li>É possível que você tenha um firewall adicional que esteja protegendo seus nós do trabalhador ou que tenha mudado as configurações do firewall recentemente. O {{site.data.keyword.containershort_notm}} requer que determinados endereços IP e portas sejam abertos para permitir a comunicação do nó do trabalhador com o mestre do Kubernetes e vice-versa. Para obter mais informações, veja [O firewall evita que os nós do trabalhador se conectem](#cs_firewall).</li><li>O mestre do Kubernetes está inativo. Entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}} abrindo um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</li></ul></td>
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
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
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
        <td>Sua conta de infraestrutura do IBM Cloud (SoftLayer) pode ser restringida de pedir recursos de cálculo. Entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}} abrindo um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</td>
      </tr>
      <tr>
        <td>Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: não foi possível fazer a ordem. Há recursos insuficientes atrás do roteador 'router_name' para preencher a solicitação para os convidados a seguir: 'worker_id'.</td>
        <td>A VLAN selecionada está associada a um pod no data center que possui espaço insuficiente para provisionar o nó do trabalhador. Você pode escolher entre as seguintes opções:<ul><li>Use um data center diferente para provisionar o nó do trabalhador. Execute <code>bx cs locations</code> para listar o data center disponível.<li>Se você tiver um par existente de VLAN pública e privada que esteja associado a outro pod no data center, use esse par de VLAN como alternativa.<li>Entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}} abrindo um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</ul></td>
      </tr>
      <tr>
        <td>Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: não foi possível obter a VLAN de rede com o ID: &lt;vlan id&gt;.</td>
        <td>O nó do trabalhador não pôde ser provisionado porque o ID de VLAN selecionado não pôde ser localizado por um dos motivos a seguir:<ul><li>Talvez você tenha especificado o número da VLAN, em vez do ID da VLAN. O número da VLAN tem 3 ou 4 dígitos de comprimento, enquanto o ID da VLAN tem 7 dígitos. Execute <code>bx cs vlans &lt;location&gt;</code> para recuperar o ID da VLAN.<li>O ID da VLAN pode não estar associado à conta de infraestrutura do IBM Cloud (SoftLayer) que você usa. Execute <code>bx cs vlans &lt;location&gt;</code> para listar os IDs de VLAN disponíveis para sua conta. Para mudar a conta de infraestrutura do IBM Cloud (SoftLayer), veja [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: o local fornecido para essa ordem é inválido. (HTTP 500)</td>
        <td>A infraestrutura do IBM Cloud (SoftLayer) não está configurada para pedir recursos de cálculo no data center selecionado. Entre em contato com o [suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support) para verificar se a conta está configurada corretamente.</td>
       </tr>
       <tr>
        <td>Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: o usuário não tem as permissões de infraestrutura necessárias do {{site.data.keyword.Bluemix_notm}} para incluir servidores

        </br></br>
        Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: 'Item' deve ser pedido com permissão.</td>
        <td>Você pode não ter as permissões necessárias para provisionar um nó do trabalhador do portfólio da infraestrutura do IBM Cloud (SoftLayer). Veja [Configurar o acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer) para criar clusters padrão do Kubernetes](cs_infrastructure.html#unify_accounts).</td>
      </tr>
    </tbody>
  </table>

<br />




## Depurando implementações de app
{: #debug_apps}

Revise as opções que você tiver para depurar suas implementações de app e localize as causas raiz das falhas.

1. Procure anomalias nos recursos de serviço ou implementação executando o comando `describe`.

 Exemplo:
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [Verifique se os contêineres estão presos no estado ContainerCreating](#stuck_creating_state).

3. Verifique se o cluster está no estado `Crítico`. Se o cluster estiver em um estado `Crítico`, verifique as regras de firewall e verifique se o mestre pode se comunicar com os nós do trabalhador.

4. Verifique se o serviço está atendendo na porta correta.
   1. Obtenha o nome de um pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Efetue login em um contêiner.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. Executar curl do app de dentro do contêiner. Se a porta não estiver acessível, o serviço poderá não estar atendendo na porta correta ou o app pode ter problemas. Atualize o arquivo de configuração para o serviço com a porta correta e reimplemente ou investigue problemas em potencial com o app.
     <pre class="pre"><code>curl localhost: &lt;port&gt;</code></pre>

5. Verifique se o serviço está vinculado corretamente aos pods.
   1. Obtenha o nome de um pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Efetue login em um contêiner.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. Executar curl do endereço IP do cluster e da porta do serviço. Se o endereço IP e a porta não estiverem acessíveis, observe os terminais para o serviço. Se não houver terminais, o seletor para o serviço não corresponderá ao pods. Se houver terminais, observe o campo da porta de destino no serviço e assegure-se de que a porta de destino seja a mesma que está sendo usada para os pods.
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Para serviços do Ingresso, verifique se o serviço está acessível de dentro do cluster.
   1. Obtenha o nome de um pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Efetue login em um contêiner.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Executar curl da URL especificada para o serviço do Ingresso. Se a URL não estiver acessível, procure um problema de firewall entre o cluster e o terminal externo. 
     <pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />


## Não é possível se conectar à sua conta de infraestrutura
{: #cs_credentials}

{: tsSymptoms}
Ao criar um novo cluster do Kubernetes, você receberá a mensagem a seguir.

```
Não foi possível se conectar à sua conta de infraestrutura do IBM Cloud (SoftLayer).
Criar um cluster padrão requer que você tenha uma conta Pay-As-You-Go
vinculada a um termo da conta de infraestrutura do IBM Cloud (SoftLayer) ou que tenha usado a CLI do {{site.data.keyword.Bluemix_notm}}
Container Service para configurar suas chaves API da infraestrutura do {{site.data.keyword.Bluemix_notm}}.
```
{: screen}

{: tsCauses}
Os usuários com uma conta do {{site.data.keyword.Bluemix_notm}} desvinculada devem criar uma nova conta Pay-As-You-Go ou incluir manualmente as chaves API de infraestrutura do IBM Cloud (SoftLayer) usando a CLI do {{site.data.keyword.Bluemix_notm}}.

{: tsResolve}
Para incluir credenciais na conta do {{site.data.keyword.Bluemix_notm}}:

1.  Entre em contato com o administrador da infraestrutura do IBM Cloud (SoftLayer) para obter o nome do usuário e a chave API da infraestrutura do IBM Cloud (SoftLayer).

    **Nota:** a conta da infraestrutura do IBM Cloud (SoftLayer) que você usa deve ser configurada com permissões de Superusuário para criar clusters padrão com êxito.

2.  Inclua as credenciais.

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  Crie um cluster padrão.

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## O firewall evita a execução de comandos da CLI
{: #ts_firewall_clis}

{: tsSymptoms}
Quando você executa os comandos `bx`, `kubectl` ou `calicoctl` na CLI, eles falham.

{: tsCauses}
Você pode ter políticas de rede corporativa que impedem o acesso de seu sistema local a terminais públicos por proxies ou firewalls.

{: tsResolve}
[Permita acesso TCP para os comandos da CLI funcionarem](cs_firewall.html#firewall). Essa tarefa requer uma [Política de acesso de administrador](cs_users.html#access_policies). Verifique sua [política de acesso](cs_users.html#infra_access) atual.


## O firewall evita que o cluster se conecte a recursos
{: #cs_firewall}

{: tsSymptoms}
Quando os nós do trabalhador não são capazes de se conectar, é possível ver uma variedade de sintomas diferentes. É possível que você veja uma das mensagens a seguir quando o proxy kubectl falhar ou você tentar acessar um serviço em seu cluster e a conexão falhar.

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

Se você executar kubectl exec, attach ou logs, é possível ver a mensagem a seguir.

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Se o proxy kubectl for bem-sucedido, mas o painel não estiver disponível, será possível que você veja a mensagem a seguir.

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
Você pode ter um firewall adicional configurado ou ter customizado as suas configurações de firewall existentes em sua conta de infraestrutura do IBM Cloud (SoftLayer). O {{site.data.keyword.containershort_notm}} requer que determinados endereços IP e portas sejam abertos para permitir a comunicação do nó do trabalhador com o mestre do Kubernetes e vice-versa. Outro motivo talvez seja que os nós do trabalhador estejam presos em um loop de recarregamento.

{: tsResolve}
[Permita que o cluster acesse os recursos de infraestrutura e outros serviços](cs_firewall.html#firewall_outbound). Essa tarefa requer uma [Política de acesso de administrador](cs_users.html#access_policies). Verifique sua [política de acesso](cs_users.html#infra_access) atual.

<br />



## O acesso a seu nó do trabalhador com SSH falha
{: #cs_ssh_worker}

{: tsSymptoms}
Não é possível acessar seu nó do trabalhador usando uma conexão SSH.

{: tsCauses}
O SSH via senha está desativado nos nós do trabalhador.

{: tsResolve}
Use [DaemonSets ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para qualquer coisa que precisar ser executada em cada nó ou tarefas para qualquer ação única que precisar ser executada.

<br />



## Ligar um serviço a um cluster resulta no erro de mesmo nome
{: #cs_duplicate_services}

{: tsSymptoms}
Ao executar `bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, você vê a mensagem a seguir.

```
Múltiplos serviços com o mesmo nome foram localizados.
Execute 'bx service list' para visualizar as instâncias de serviço disponíveis do Bluemix...
```
{: screen}

{: tsCauses}
Múltiplas instâncias de serviço podem ter o mesmo nome em regiões diferentes.

{: tsResolve}
Use o GUID de serviço em vez do nome da instância de serviço no comando `bx cs cluster-service-bind`.

1. [Efetue login na região que inclui a instância de serviço para ligação.](cs_regions.html#bluemix_regions)

2. Obtenha o GUID para a instância de serviço.
  ```
  bx service show <service_instance_name> --guid
  ```
  {: pre}

  Saída:
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. Ligue o serviço ao cluster novamente.
  ```
  bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />



## Após atualizar ou recarregar um nó do trabalhador, nós duplicados e pods aparecem
{: #cs_duplicate_nodes}

{: tsSymptoms}
Ao executar `kubectl get nodes`, você vê nós do trabalhador duplicados com o status **NotReady**. Os nós do trabalhador com **NotReady** têm endereços IP públicos, enquanto os nós do trabalhador com **Ready** possuem endereços IP privados.

{: tsCauses}
Clusters mais antigos tinham nós do trabalhador listados pelo endereço IP público do cluster. Agora, os nós do trabalhador são listados pelo endereço IP privado do cluster. Ao recarregar ou atualizar um nó, o endereço IP é mudado, mas a referência ao endereço IP público permanece.

{: tsResolve}
Não há interrupções de serviço devido a essas duplicatas, mas é necessário remover as referências do nó do trabalhador antigas do servidor de API.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />




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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b2c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b2c.4x16       deleted    -
  ```
  {: screen}

2.  Instale a [CLI do Calico](cs_network_policy.html#adding_network_policies).
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

<br />




## Os pods permanecem no estado pendente
{: #cs_pods_pending}

{: tsSymptoms}
Ao executar `kubectl get pods`, será possível ver pods que permanecem em um estado **Pendente**.

{: tsCauses}
Se você acabou de criar o cluster do Kubernetes, os nós do trabalhador podem ainda estar configurando. Se esse cluster for um existente, você talvez não tenha capacidade suficiente no cluster para implementar o pod.

{: tsResolve}
Essa tarefa requer uma [Política de acesso de administrador](cs_users.html#access_policies). Verifique sua [política de acesso](cs_users.html#infra_access) atual.

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

<br />




## Os pods são presos no estado de criação
{: #stuck_creating_state}

{: tsSymptoms}
Quando você executa `kubectl get pods -o wide`, você vê que vários pods que estão em execução no mesmo nó do trabalhador estão presos no estado `ContainerCreating`.

{: tsCauses}
O sistema de arquivos no nó do trabalhador é somente leitura.

{: tsResolve}
1. Faça backup de quaisquer dados que podem ser armazenados no nó do trabalhador ou em seus contêineres.
2. Reconstrua o nó do trabalhador executando o comando a seguir.

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

<br />




## Os contêineres não iniciam
{: #containers_do_not_start}

{: tsSymptoms}
Os pods são implementados com êxito em clusters, mas os contêineres não iniciam.

{: tsCauses}
Os contêineres não podem ser iniciados quando a cota de registro é atingido.

{: tsResolve}
[Liberar armazenamento em {{site.data.keyword.registryshort_notm}}.](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />




## Os logs não aparecem
{: #cs_no_logs}

{: tsSymptoms}
Quando você acessa o painel do Kibana, os logs não são exibidos.

{: tsResolve}
Revise as razões a seguir porque os logs não estão aparecendo e as etapas de resolução de problemas correspondentes:

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>Por que isso está acontecendo?</th>
 <th>Como corrigi-lo</th>
 </thead>
 <tbody>
 <tr>
 <td>Nenhuma configuração de criação de log está definida.</td>
 <td>Para que os logs sejam enviados, deve-se primeiro criar uma configuração de criação de log para encaminhar logs para o {{site.data.keyword.loganalysislong_notm}}. Para criar uma configuração de criação de log, consulte <a href="cs_health.html#log_sources_enable">Ativando o encaminhamento de log</a>.</td>
 </tr>
 <tr>
 <td>O cluster não está em um estado <code>Normal</code>.</td>
 <td>Para verificar o estado do seu cluster, veja <a href="cs_troubleshoot.html#debug_clusters">Depurando clusters</a>.</td>
 </tr>
 <tr>
 <td>A cota de armazenamento do log foi atingida.</td>
 <td>Para aumentar os seus limites de armazenamento de log, veja a <a href="/docs/services/CloudLogAnalysis/troubleshooting/error_msgs.html"> documentação do {{site.data.keyword.loganalysislong_notm}}</a>.</td>
 </tr>
 <tr>
 <td>Se você especificou um espaço na criação do cluster, o proprietário da conta não tem permissões de Gerenciador, Desenvolvedor ou Auditor para esse espaço.</td>
 <td>Para mudar permissões de acesso para o proprietário da conta:<ol><li>Para descobrir quem é o proprietário da conta para o cluster, execute <code>bx cs api-key-info &lt;cluster_name_or_ID&gt;</code>.</li><li>Para conceder a esse proprietário da conta as permissões de acesso de Gerenciador, Desenvolvedor ou Auditor do {{site.data.keyword.containershort_notm}} para o espaço, veja <a href="cs_users.html#managing">Gerenciando o acesso ao cluster</a>.</li><li>Para atualizar o token de criação de log depois que as permissões foram mudadas, execute <code>bx cs logging-config-refresh &lt;cluster_name_or_ID&gt;</code>.</li></ol></td>
 </tr>
 </tbody></table>

Para testar as mudanças feitas durante a resolução de problemas, é possível implementar o Noisy, um pod de amostra que produz vários eventos de log, em um nó do trabalhador em seu cluster.

  1. [Direcione sua CLI](cs_cli_install.html#cs_cli_configure) para um cluster no qual você deseja começar a produzir logs.

  2. Crie o arquivo de configuração `deploy-noisy.yaml`.

      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: noisy
      spec:
        containers:
        - name: noisy
          image: ubuntu:16.04
          command: ["/bin/sh"]
          args: ["-c", "while true; do sleep 10; echo 'Hello world!'; done"]
          imagePullPolicy: "Always"
        ```
        {: codeblock}

  3. Execute o arquivo de configuração no contexto do cluster.

        ```
        kubectl apply -f <filepath_to_noisy>
        ```
        {:pre}

  4. Após alguns minutos, é possível visualizar seus logs no painel do Kibana. Para acessar o painel do Kibana, acesse uma das URLs a seguir e selecione a conta do {{site.data.keyword.Bluemix_notm}} na qual você criou o cluster. Se você especificou um espaço na criação do cluster, acesse esse espaço.
      - Sul e Leste dos EUA: https://logging.ng.bluemix.net
      - Sul do Reino Unido: https://logging.eu-gb.bluemix.net
      - UE Central: https://logging.eu-fra.bluemix.net
      - AP-South: https://logging.au-syd.bluemix.net

<br />




## O painel do Kubernetes não exibe gráficos de utilização
{: #cs_dashboard_graphs}

{: tsSymptoms}
Quando você acessa o painel do Kubernetes, os gráficos de utilização não são exibidos.

{: tsCauses}
Às vezes, após uma atualização de cluster ou reinicialização do nó do trabalhador, o pod `kube-dashboard` não é atualizado.

{: tsResolve}
Exclua o pod `kube-painel` para forçar uma reinicialização. O pod é recriado com políticas RBAC para acessar o heapster para obter informações de utilização.

  ```
  kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
  ```
  {: pre}

<br />


## Não é possível se conectar a um app por meio de um serviço de balanceador de carga
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Você expôs publicamente seu app criando um serviço de balanceador de carga no cluster. Quando tentou se conectar ao app por meio do endereço IP público ou do balanceador de carga, a conexão falhou ou atingiu o tempo limite.

{: tsCauses}
O serviço de balanceador de carga pode não estar funcionando corretamente por um dos motivos a seguir:

-   O cluster é um cluster grátis ou um cluster padrão com somente um nó do trabalhador.
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

    1.  Verifique se você definiu **LoadBalancer** como o tipo para seu serviço.
    2.  Certifique-se de que tenha usado os mesmos **<selectorkey>** e **<selectorvalue>** usados na seção **rótulo/metadados** de quando implementou o app.
    3.  Verifique se usou a **porta** em que seu app atende.

3.  Verifique o serviço de balanceador de carga e revise a seção **Eventos** para localizar erros em potencial.

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    Procure as mensagens de erro a seguir:

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Para usar o serviço de balanceador de carga, deve-se ter um cluster padrão com pelo menos dois nós do trabalhador.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Essa mensagem de erro indica que não sobrou nenhum endereço IP público móvel para ser alocado para o serviço de balanceador de carga. Consulte <a href="cs_subnets.html#subnets">Incluindo sub-redes nos clusters</a> para localizar informações sobre como solicitar endereços IP públicos móveis para seu cluster. Depois que os endereços IP públicos móveis estiverem disponíveis para o cluster, o serviço de balanceador de carga será criado automaticamente.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>Você definiu um endereço IP público móvel para o serviço de balanceador de carga usando a seção **loadBalancerIP**, mas esse endereço IP público móvel não está disponível em sua sub-rede pública móvel. Mude o script de configuração do serviço de balanceador de carga e escolha um dos endereços IP públicos móveis disponíveis ou remova a seção **loadBalancerIP** de seu script para que um endereço IP público móvel disponível possa ser alocado automaticamente.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Você não tem nós do trabalhador suficientes para implementar um serviço de balanceador de carga. Um motivo talvez seja que você tenha implementado um cluster padrão com mais de um nó do trabalhador, mas o fornecimento dos nós do trabalhador tenha falhado.</li>
    <ol><li>Liste os nós do trabalhador disponíveis.</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>Se pelo menos dois nós do trabalhador disponíveis forem localizados, liste os detalhes do nó do trabalhador.</br><pre class="screen"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
    <li>Certifique-se de que os IDs da VLAN pública e privada para os nós do trabalhador que foram retornados pelos comandos <code>kubectl get nodes</code> e <code>bx cs [&lt;cluster_name_or_id&gt;] worker-get</code> correspondam.</li></ol></li></ul>

4.  Se você estiver usando um domínio customizado para se conectar ao serviço de balanceador de carga, certifique-se de que seu domínio customizado seja mapeado para o endereço IP público do serviço de balanceador de carga.
    1.  Localize o endereço IP público do serviço de balanceador de carga.

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Verifique se o seu domínio customizado está mapeado para o endereço IP público móvel do serviço de balanceador de carga no registro de Ponteiro (PTR).

<br />


## Não é possível se conectar a um app por meio de Ingresso
{: #cs_ingress_fails}

{: tsSymptoms}
Você expôs publicamente seu app criando um recurso de Ingresso para seu app no cluster. Ao tentar se conectar ao app por meio do endereço IP público ou o subdomínio do balanceador de carga de aplicativo de Ingresso, a conexão falhou ou atingiu o tempo limite.

{: tsCauses}
O Ingresso pode não estar funcionando corretamente pelos motivos a seguir:
<ul><ul>
<li>O cluster não está totalmente implementado ainda.
<li>O cluster foi configurado como um cluster grátis ou como um cluster padrão com somente um nó do trabalhador.
<li>O script de configuração de Ingresso inclui erros.
</ul></ul>

{: tsResolve}
Para solucionar problemas do Ingresso:

1.  Verifique se você configurou um cluster padrão que esteja totalmente implementado e tenha pelo menos dois nós do trabalhador para assegurar alta disponibilidade para o balanceador de carga de aplicativo de Ingresso.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    Na saída da CLI, certifique-se de que o **Status** dos nós do trabalhador exiba **Pronto** e que o **Tipo de máquina** mostre um tipo de máquina diferente de **livre**.

2.  Recupere o subdomínio de balanceador de carga de aplicativo de Ingresso e o endereço IP público e, em seguida execute ping de cada um.

    1.  Recupere o subdomínio do controlador de Ingresso.

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Execute ping do subdomínio de balanceador de carga de aplicativo de Ingresso.

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Recupere o endereço IP público de seu balanceador de carga de aplicativo de Ingresso.

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Execute ping do endereço IP público do balanceador de carga de aplicativo de Ingresso.

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    Se a CLI retornar um tempo limite para o endereço IP público ou subdomínio do balanceador de carga de aplicativo de Ingresso e você tiver configurado um firewall customizado que esteja protegendo seus nós do trabalhador, poderá ser necessário abrir portas e grupos de rede adicionais no seu [firewall](#cs_firewall).

3.  Se você estiver usando um domínio customizado, certifique-se de que seu domínio customizado esteja mapeado para o endereço IP público ou subdomínio do balanceador de carga de aplicativo de Ingresso fornecido pela IBM com o provedor de Domain Name Service (DNS).
    1.  Se você usou o subdomínio do balanceador de carga de aplicativo de Ingresso, verifique seu registro de Canonical Name (CNAME).
    2.  Se você usou o endereço IP público do balanceador de carga de aplicativo de Ingresso, verifique se o seu domínio customizado está mapeado para o endereço IP público móvel no Registro de Ponteiro (PTR).
4.  Verifique seu arquivo de configuração do recurso de Ingresso.

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

    1.  Verifique se o subdomínio do balanceador de carga de aplicativo de Ingresso e o certificado TLS estão corretos. Para localizar o subdomínio fornecido pela IBM e o certificado TLS, execute bx cs cluster-get <cluster_name_or_id>.
    2.  Certifique-se de que seu app atenda no mesmo caminho configurado na seção de **caminho** de seu Ingresso. Se o seu app estiver configurado para atender no caminho raiz, inclua **/** como seu caminho.
5.  Verifique sua implementação do Ingresso e procure mensagens de erro em potencial.

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  Verifique os logs para o seu controlador de Ingresso.
    1.  Recupere o ID dos pods do Ingresso que estão em execução no cluster.

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  Recupere os logs para cada pod do Ingresso.

      ```
      kubectl logs <ingress_pod_id> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  Procure mensagens de erro nos logs do controlador de Ingresso.

<br />



## Problemas de segredo do balanceador de carga de aplicativo de Ingresso
{: #cs_albsecret_fails}

{: tsSymptoms}
Após a implementação de um segredo do balanceador de carga de aplicativo de Ingresso para seu cluster, o campo `Description` não está atualizando com o nome secreto quando você visualiza seu certificado no {{site.data.keyword.cloudcerts_full_notm}}.

Quando você lista informações sobre o segredo do balanceador de carga de aplicativo, o status diz `*_failed`. Por exemplo, `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
Revise as razões a seguir porque o segredo do balanceador de carga de aplicativo pode falhar e as etapas de resolução de problemas correspondentes:

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>Por que isso está acontecendo?</th>
 <th>Como corrigi-lo</th>
 </thead>
 <tbody>
 <tr>
 <td>Você não tem as funções de acesso necessárias para fazer download e atualizar os dados do certificado.</td>
 <td>Verifique com seu Administrador de conta para designar a você as funções de **Operador** e **Editor** para sua instância do {{site.data.keyword.cloudcerts_full_notm}}. Para obter mais detalhes, veja <a href="/docs/services/certificate-manager/about.html#identity-access-management">Identity and Access Management</a> para o {{site.data.keyword.cloudcerts_short}}.</td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de criação, atualização ou remoção não pertence à mesma conta que o cluster.</td>
 <td>Verifique se o CRN do certificado fornecido é importado para uma instância do serviço {{site.data.keyword.cloudcerts_short}} que está implementado na mesma conta que seu cluster.</td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de criação está incorreto.</td>
 <td><ol><li>Verifique a precisão da sequência CRN do certificado que você fornece.</li><li>Se for constatado que o CRN do certificado está exato, tente atualizar o segredo. <pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li><li>Se esse comando resultar no status <code>update_failed</code>, remova o segredo. <pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></pre></li><li>Implemente o segredo novamente. <pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de atualização está incorreto.</td>
 <td><ol><li>Verifique a precisão da sequência CRN do certificado que você fornece.</li><li>Se for constatado que o CRN do certificado está exato, remova o segredo. <pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></pre></li><li>Implemente o segredo novamente. <pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li><li>Tente atualizar o segredo. <pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>O serviço {{site.data.keyword.cloudcerts_long_notm}} está tendo tempo de inatividade.</td>
 <td>Verifique se o serviço {{site.data.keyword.cloudcerts_short}} está funcionando.</td>
 </tr>
 </tbody></table>

<br />



## Não é possível recuperar a URL do ETCD para configuração da CLI do Calico
{: #cs_calico_fails}

{: tsSymptoms}
Quando você recuperar o `<ETCD_URL>` para [incluir políticas de rede](cs_network_policy.html#adding_network_policies), você obtém uma mensagem de erro `calico-config not found`.

{: tsCauses}
Seu cluster não está no [Kubernetes versão 1.7](cs_versions.html) ou mais recente.

{: tsResolve}
[Atualize o seu cluster](cs_cluster_update.html#master) ou recupere o `<ETCD_URL>` com comandos que são compatíveis com versões anteriores do Kubernetes.

Para recuperar o `<ETCD_URL>`, execute um dos comandos a seguir:

- Linux e OS X:

    ```
    kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
    ```
    {: pre}

- Windows:
    <ol>
    <li> Obtenha uma lista dos pods no namespace kube-system e localize o pod controlador do Calico. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Exemplo:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> Visualize os detalhes do pod controlador do Calico.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
    <li> Localize o valor de terminais do ETCD. Exemplo: <code>https://169.1.1.1:30001</code>
    </ol>

Quando você recuperar o `<ETCD_URL>`, continue com as etapas conforme listado em (Incluindo políticas de rede) [cs_network_policy.html#adding_network_policies].

<br />




## Obtendo ajuda e suporte
{: #ts_getting_help}

Onde você inicia a resolução de problemas de um contêiner?

-   Para ver se o {{site.data.keyword.Bluemix_notm}} está disponível, [verifique a página de status do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).
-   Poste uma pergunta no [Slack do {{site.data.keyword.containershort_notm}}. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com) Dica: se você não estiver usando um IBMid para a sua conta do {{site.data.keyword.Bluemix_notm}},
[solicite um convite](https://bxcs-slack-invite.mybluemix.net/) para esse Slack.
-   Revise os fóruns para ver se outros usuários tiveram o mesmo problema. Ao usar os fóruns para fazer uma pergunta, marque sua pergunta para que ela seja vista pelas equipes de desenvolvimento do {{site.data.keyword.Bluemix_notm}}.

    -   Se você tiver questões técnicas sobre como desenvolver ou implementar clusters ou apps com o {{site.data.keyword.containershort_notm}}, poste sua pergunta no [Stack Overflow ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e identifique a sua pergunta com `ibm-cloud`, `kubernetes` e `containers`.
    -   Para perguntas sobre o serviço e instruções de introdução, use o fórum [IBM developerWorks dW Answers ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Inclua as tags `ibm-cloud` e `containers`.
    Consulte [Obtendo ajuda](/docs/get-support/howtogetsupport.html#using-avatar) para obter mais detalhes sobre o uso dos fóruns.

-   Entre em contato com o Suporte IBM. Para obter informações sobre como abrir um chamado de suporte IBM ou sobre níveis de suporte e severidades de chamado, consulte [Entrando em contato com o suporte](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Ao relatar um problema, inclua seu ID do cluster. Para obter o ID do cluster, execute `bx cs clusters`.
