---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

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

Ao usar {{site.data.keyword.containerlong}}, considere estas técnicas para resolução de problemas e obtenção de ajuda. Também é possível verificar o [status do sistema {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).
{: shortdesc}

É possível levar algumas etapas gerais para assegurar que seus clusters estejam atualizados:
- [Reinicialize seus nós do trabalhador](cs_cli_reference.html#cs_worker_reboot) regularmente para assegurar a instalação de atualizações e correções de segurança que a IBM implementa automaticamente no sistema operacional
- Atualize seu cluster para [a versão padrão mais recente do Kubernetes](cs_versions.html) para {{site.data.keyword.containershort_notm}}

<br />




## Depurando clusters
{: #debug_clusters}

Revise as opções para depurar seus clusters e localizar as causas raízes das falhas.

1.  Liste o cluster e localize o `Estado` dele.

  ```
  bx cs clusters
  ```
  {: pre}

2.  Revise o `Estado` do cluster. Se o seu cluster está em um estado **Crítico**, **Exclusão com falha** ou **Aviso** ou está preso no estado **Pendente** por muito tempo, inicie a [depuração dos nós do trabalhador](#debug_worker_nodes).

    <table summary="Cada linha da tabela deve ser lida da esquerda para a direita, com o estado do cluster na coluna um e uma descrição na coluna dois.">
   <thead>
   <th>Estado do cluster</th>
   <th>Descrição</th>
   </thead>
   <tbody>
<tr>
   <td>Interrompido</td>
   <td>A exclusão do cluster é solicitada pelo usuário antes da implementação do mestre do Kubernetes. Depois que a exclusão do cluster é concluída, o cluster é removido do painel. Se o seu cluster estiver preso nesse estado por muito tempo, abra um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
 <tr>
     <td>Crítico</td>
     <td>O mestre do Kubernetes não pode ser atingido ou todos os nós do trabalhador no cluster estão inativos. </td>
    </tr>
   <tr>
     <td>Exclusão com falha</td>
     <td>O mestre do Kubernetes ou pelo menos um nó do trabalhador não pode ser excluído.  </td>
   </tr>
   <tr>
     <td>Excluído</td>
     <td>O cluster foi excluído, mas ainda não foi removido de seu painel. Se o seu cluster estiver preso nesse estado por muito tempo, abra um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
   <td>Exclusão</td>
   <td>O cluster está sendo excluído e a infraestrutura de cluster está sendo desmantelada. Não é possível acessar o cluster.  </td>
   </tr>
   <tr>
     <td>Implementação com falha</td>
     <td>A implementação do mestre do Kubernetes não pôde ser concluída. Não é possível resolver esse estado. Entre em contato com o suporte IBM Cloud abrindo um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
     <tr>
       <td>Implementando</td>
       <td>O mestre do Kubernetes não está totalmente implementado ainda. Não é possível acessar seu cluster. Aguarde até que seu cluster seja totalmente implementado para revisar seu funcionamento.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Todos os nós do trabalhador em um cluster estão funcionando. É possível acessar o cluster e implementar apps no cluster. Esse estado é considerado saudável e não requer uma ação sua.</td>
    </tr>
      <tr>
       <td>Pendente</td>
       <td>O mestre do Kubernetes foi implementado. Os nós do trabalhador estão sendo provisionados e ainda não estão disponíveis no cluster. É possível acessar o cluster, mas não é possível implementar apps no cluster.  </td>
     </tr>
   <tr>
     <td>Solicitado</td>
     <td>Uma solicitação para criar o cluster e pedir a infraestrutura para os nós principal e do trabalhador do Kubernetes é enviada. Quando a implementação do cluster é iniciada, o estado do cluster muda para <code>Deploying</code>. Se o seu cluster estiver preso no estado <code>Requested</code> por muito tempo, abra um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
     <td>Atualizando</td>
     <td>O servidor da API do Kubernetes executado no mestre do Kubernetes está sendo atualizado para uma nova versão de API do Kubernetes. Durante a atualização, não é possível acessar nem mudar o cluster. Nós do trabalhador, apps e recursos que foram implementados pelo usuário não são modificados e continuam a ser executados. Aguarde a atualização ser concluída para revisar o funcionamento de seu cluster. </td>
   </tr>
    <tr>
       <td>Avisar</td>
       <td>Pelo menos um nó do trabalhador no cluster não está disponível, mas outros nós do trabalhador estão disponíveis e podem assumir o controle da carga de trabalho. </td>
    </tr>
   </tbody>
 </table>

<br />


## Depurando nós do trabalhador
{: #debug_worker_nodes}

Revise as opções para depurar seus nós do trabalhador e localizar as causas raízes das falhas.


1.  Se o seu cluster está em um estado **Crítico**, **Exclusão com falha** ou **Aviso** ou está preso no estado **Pendente** por muito tempo, revise o estado de seus nós do trabalhador.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

2.  Revise os campos `State` e `Status` para cada nó do trabalhador em sua saída da CLI.

  <table summary="Cada linha da tabela deve ser lida da esquerda para a direita, com o estado do cluster na coluna um e uma descrição na coluna dois.">
    <thead>
    <th>Estado do nó do trabalhador</th>
    <th>Descrição</th>
    </thead>
    <tbody>
  <tr>
      <td>Crítico</td>
      <td>Um nó do trabalhador pode entrar em um estado Crítico por muitas razões. As razões mais comuns são as seguintes: <ul><li>Você iniciou uma reinicialização para seu nó do trabalhador sem bloquear e drenar seu nó do trabalhador. A reinicialização de um nó do trabalhador pode causar distorção de dados em <code>docker</code>, <code>kubelet</code>, <code>kube-proxy</code> e <code>calico</code>. </li><li>Os pods que são implementados em seu nó do trabalhador não usam os limites de recurso para [memória ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) e [CPU ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/). Sem limites de recurso, os pods podem consumir todos os recursos disponíveis, sem deixar recursos para outros pods executarem nesse nó do trabalhador. Esse supercomprometimento de carga de trabalho faz com que o nó do trabalhador falhe. </li><li><code>Docker</code>, <code>kubelet</code> ou <code>calico</code> entraram em um estado irrecuperável depois de executar centenas ou milhares de contêineres ao longo do tempo. </li><li>Você configurou um Vyatta para o seu nó do trabalhador que ficou inativo e cortou a comunicação entre o seu nó do trabalhador e o mestre do Kubernetes. </li><li> Problemas de rede atual no {{site.data.keyword.containershort_notm}} ou na infraestrutura do IBM Cloud (SoftLayer) que fazem a comunicação entre seu nó do trabalhador e o mestre do Kubernetes falhar.</li><li>O nó do trabalhador ficou sem capacidade. Verifique o <strong>Status</strong> do nó do trabalhador para ver se ele mostra <strong>Sem disco</strong> ou <strong>Sem memória</strong>. Se o nó do trabalhador está fora de capacidade, considere reduzir a carga de trabalho em seu nó do trabalhador ou incluir um nó do trabalhador em seu cluster para ajudar no balanceamento de carga da carga de trabalho.</li></ul> Em muitos casos, [recarregar](cs_cli_reference.html#cs_worker_reload) seu nó do trabalhador pode resolver o problema. Antes de recarregar seu nó do trabalhador, certifique-se de bloquear e drenar o seu nó do trabalhador para assegurar que os pods existentes sejam finalizados normalmente e reprogramados em outros nós do trabalhador. </br></br> Se o recarregamento do nó do trabalhador não resolver o problema, acesse a próxima etapa para continuar a resolução de problemas de seu nó do trabalhador. </br></br><strong>Dica:</strong> é possível [configurar verificações de funcionamento para seu nó do trabalhador e ativar a Recuperação automática](cs_health.html#autorecovery). Se a Recuperação automática detecta um nó do trabalhador que não está saudável com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Para obter mais informações sobre como a Recuperação automática funciona, veja o [blog de Recuperação automática ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
      </td>
     </tr>
      <tr>
        <td>Implementando</td>
        <td>Quando você atualiza a versão do Kubernetes do nó do trabalhador, seu nó do trabalhador é reimplementado para instalar as atualizações. Se o nó do trabalhador está preso nesse estado por muito tempo, continue com a próxima etapa para ver se um problema ocorreu durante a implementação. </td>
     </tr>
        <tr>
        <td>Normal</td>
        <td>O nó do trabalhador está totalmente provisionado e pronto para ser usado no cluster. Esse estado é considerado saudável e não requer uma ação do usuário.</td>
     </tr>
   <tr>
        <td>Provisionando</td>
        <td>O nó do trabalhador está sendo provisionado e ainda não está disponível no cluster. É possível monitorar o processo de fornecimento na coluna <strong>Status</strong> da saída da CLI. Se o nó do trabalhador ficar preso nesse estado por muito tempo e não for possível ver nenhum progresso na coluna <strong>Status</strong>, continue com a próxima etapa para ver se ocorreu um problema durante o fornecimento.</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>O nó do trabalhador não pôde ser provisionado. Continue com a próxima etapa para localizar os detalhes da falha.</td>
      </tr>
   <tr>
        <td>Recarregando</td>
        <td>O nó do trabalhador está sendo recarregado e não está disponível no cluster. É possível monitorar o processo de recarregamento na coluna <strong>Status</strong> da saída da CLI. Se o nó do trabalhador ficar preso nesse estado por muito tempo e não for possível ver nenhum progresso na coluna <strong>Status</strong>, continue com a próxima etapa para ver se ocorreu um problema durante o recarregamento.</td>
       </tr>
       <tr>
        <td>Reloading_failed </td>
        <td>O nó do trabalhador não pôde ser recarregado. Continue com a próxima etapa para localizar os detalhes da falha.</td>
      </tr>
      <tr>
        <td>Reload_pending </td>
        <td>Uma solicitação para recarregar ou atualizar a versão do Kubernetes do nó do trabalhador é enviada. Quando o nó do trabalhador está sendo recarregado, o estado muda para <code>Reloading</code>. </td>
      </tr>
      <tr>
       <td>Desconhecido</td>
       <td>O mestre do Kubernetes não está acessível por um dos motivos a seguir:<ul><li>Você solicitou uma atualização do mestre do Kubernetes. O estado do nó do trabalhador não pode ser recuperado durante a atualização.</li><li>É possível que você tenha um firewall adicional que esteja protegendo seus nós do trabalhador ou que tenha mudado as configurações do firewall recentemente. O {{site.data.keyword.containershort_notm}} requer que determinados endereços IP e portas sejam abertos para permitir a comunicação do nó do trabalhador com o mestre do Kubernetes e vice-versa. Para obter mais informações, veja [O firewall evita que os nós do trabalhador se conectem](#cs_firewall).</li><li>O mestre do Kubernetes está inativo. Entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}} abrindo um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</li></ul></td>
  </tr>
     <tr>
        <td>Avisar</td>
        <td>O nó do trabalhador está atingindo o limite para memória ou espaço em disco. Será possível reduzir a carga de trabalho em seu nó do trabalhador ou incluir um nó do trabalhador em seu cluster para ajudar no balanceamento de carga da carga de trabalho.</td>
  </tr>
    </tbody>
  </table>

5.  Liste os detalhes para o nó do trabalhador. Se os detalhes incluem uma mensagem de erro, revise a lista de [mensagens de erro comum para nós do trabalhador](#common_worker_nodes_issues) para saber como resolver o problema.

   ```
   bx cs worker-get <worker_id>
   ```
   {: pre}

  ```
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
  ```
  {: pre}

<br />


## Problemas comuns com nós do trabalhador
{: #common_worker_nodes_issues}

Revise as mensagens de erro comuns e saiba como resolvê-las.

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
      <tr>
       <td>O trabalhador não consegue conversar com servidores {{site.data.keyword.containershort_notm}}. Verifique se sua configuração de firewall está permitindo tráfego desse trabalhador.
       <td><ul><li>Se você tiver um firewall, [defina suas configurações de firewall para permitir o tráfego de saída para as portas e endereços IP](cs_firewall.html#firewall_outbound).</li><li>Verifique se o seu cluster não tem um IP público executando `bx cs workers <mycluster>`. Se não houver nenhum IP público listado, então, o seu cluster terá somente VLANs privadas.<ul><li>Se você deseja que o cluster tenha somente VLANs privadas, certifique-se de que tenha configurado sua [Conexão VLAN](cs_clusters.html#worker_vlan_connection) e seu [firewall](cs_firewall.html#firewall_outbound).</li><li>Se você deseja que o cluster tenha um IP público, [inclua novos nós do trabalhador](cs_cli_reference.html#cs_worker_add) com as VLANs públicas e privadas.</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>Não é possível criar o token do portal do IMS, pois nenhuma conta do IMS está vinculada à conta selecionada do BSS</br></br>Usuário fornecido não localizado ou ativo</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus: a conta do usuário é atualmente cancel_pending.</td>
  <td>O proprietário da chave API que é usada para acessar o portfólio da infraestrutura do IBM Cloud (SoftLayer) não tem as permissões necessárias para executar a ação ou pode estar com exclusão pendente.</br></br><strong>Como o usuário</strong>, siga estas etapas: <ol><li>Se você tem acesso a múltiplas contas, certifique-se de que tenha efetuado login na conta em que deseja trabalhar com o {{site.data.keyword.containerlong_notm}}. </li><li>Execute <code>bx cs api-key-info</code> para visualizar o proprietário da chave API atual que é usado para acessar o portfólio da infraestrutura do IBM Cloud (SoftLayer). </li><li>Execute <code>bx account list</code> para visualizar o proprietário da conta do {{site.data.keyword.Bluemix_notm}} que você usa atualmente. </li><li>Entre em contato com o proprietário da conta do {{site.data.keyword.Bluemix_notm}} e relate que o proprietário da chave API que você recuperou anteriormente tem permissões insuficientes na infraestrutura do IBM Cloud (SoftLayer) ou pode estar com exclusão pendente. </li></ol></br><strong>Como o proprietário da conta</strong>, siga estas etapas: <ol><li>Revise as [permissões necessárias na infraestrutura do IBM Cloud (SoftLayer)](cs_users.html#managing) para executar a ação que falhou anteriormente. </li><li>Corrija as permissões do proprietário da chave API ou crie uma nova chave API usando o comando [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). </li><li>Se você ou outro administrador de conta configura manualmente as credenciais de infraestrutura do IBM Cloud (SoftLayer) em sua conta, execute [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) para remover as credenciais de sua conta.</li></ol></td>
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




## Os sistemas de arquivos para nós do trabalhador mudam para somente leitura
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Você pode ver um dos sintomas a seguir:
- Quando você executa `kubectl get pods -o wide`, você vê que vários pods que estão em execução no mesmo nó do trabalhador estão presos no estado `ContainerCreating`.
- Quando executa um comando `kubectl describe`, você vê o erro a seguir na seção de eventos: `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
O sistema de arquivos no nó do trabalhador é somente leitura.

{: tsResolve}
1. Faça backup de quaisquer dados que podem ser armazenados no nó do trabalhador ou em seus contêineres.
2. Para uma correção de curto prazo para o nó do trabalhador existente, recarregue o nó do trabalhador.

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

Para uma correção de longo prazo, [atualize o tipo de máquina incluindo outro nó do trabalhador](cs_cluster_update.html#machine_type).

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
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12    203.0.113.144    b2c.4x16       normal    Ready    dal10      1.8.8
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16    203.0.113.144    b2c.4x16       deleted    -       dal10      1.8.8
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


## O cluster permanece em um estado pendente
{: #cs_cluster_pending}

{: tsSymptoms}
Quando você implementa o seu cluster, ele permanece em um estado pendente e não é iniciado.

{: tsCauses}
Se você acabou de criar o cluster, os nós do trabalhador podem ainda estar sendo configurados. Se tiver esperado por um tempo, você poderá ter uma VLAN inválida.

{: tsResolve}

É possível tentar uma das soluções a seguir:
  - Verifique o status de seu cluster executando `bx cs clusters`. Em seguida, verifique se os nós do trabalhador estão implementados executando `bx cs workers <cluster_name>`.
  - Verifique se sua VLAN é válida. Para ser válida, uma VLAN deve ser associada à infraestrutura que pode hospedar um trabalhador com armazenamento em disco local. É possível [listar suas VLANs](/docs/containers/cs_cli_reference.html#cs_vlans) executando `bx cs vlans LOCATION`, se a VLAN não é mostrada na lista, então ela não é válida. Escolha uma VLAN diferente.

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
 <td>Para que os logs sejam enviados, deve-se primeiro criar uma configuração de criação de log para encaminhar logs para o {{site.data.keyword.loganalysislong_notm}}. Para criar uma configuração de criação de log, veja <a href="cs_health.html#logging">Configurando a criação de log de cluster</a>.</td>
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


## A inclusão do acesso de usuário não raiz no armazenamento persistente falha
{: #cs_storage_nonroot}

{: tsSymptoms}
Depois de [incluir o acesso de usuário não raiz no armazenamento persistente](cs_storage.html#nonroot) ou implementar um gráfico Helm com um ID do usuário não raiz especificado, o usuário não pode gravar no armazenamento montado.

{: tsCauses}
A configuração da implementação ou do gráfico Helm especifica o [contexto de segurança](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) para o `fsGroup` (ID do grupo) e `runAsUser` (ID do usuário) do pod. Atualmente, o {{site.data.keyword.containershort_notm}} não suporta a especificação `fsGroup` e suporta somente `runAsUser` configurado como `0` (permissões raiz).

{: tsResolve}
Remova os campos `securityContext` da configuração para `fsGroup` e `runAsUser` do arquivo de configuração da imagem, da implementação ou do gráfico Helm e reimplemente. Se você precisa mudar a propriedade do caminho de montagem de `nobody`, [inclua o acesso de usuário não raiz](cs_storage.html#nonroot).

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
    <li>Se pelo menos dois nós do trabalhador disponíveis forem localizados, liste os detalhes do nó do trabalhador.</br><pre class="codeblock"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
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

    1.  Recupere o subdomínio de balanceador de carga de aplicativo.

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

    1.  Verifique se o subdomínio do balanceador de carga de aplicativo de Ingresso e o certificado TLS estão corretos. Para localizar o subdomínio fornecido pela IBM e o certificado TLS, execute `bx cs cluster-get <cluster_name_or_id>`.
    2.  Certifique-se de que seu app atenda no mesmo caminho configurado na seção de **caminho** de seu Ingresso. Se o seu app estiver configurado para atender no caminho raiz, inclua **/** como seu caminho.
5.  Verifique a sua implementação do Ingresso e procure mensagens de aviso ou erro em potencial.

    ```
    kubectl describe ingress <myingress>
    ```
    {: pre}

    Por exemplo, na seção **Eventos** da saída, você pode ver mensagens de aviso sobre valores inválidos em seu recurso de Ingresso ou em certas anotações usadas.

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xx,169.xx.xxx.xx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.mybluemix.net
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

6.  Verifique os logs para seu balanceador de carga de aplicativo.
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

    3.  Procure mensagens de erro nos logs do balanceador de carga de aplicativo.

<br />



## Problemas de segredo do balanceador de carga de aplicativo de Ingresso
{: #cs_albsecret_fails}

{: tsSymptoms}
Após a implementação de um segredo do balanceador de carga de aplicativo de Ingresso para seu cluster, o campo `Description` não está atualizando com o nome secreto quando você visualiza seu certificado no {{site.data.keyword.cloudcerts_full_notm}}.

Quando você lista informações sobre o segredo do balanceador de carga de aplicativo, o status diz `*_failed`. Por exemplo, `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
Revise as razões a seguir porque o segredo do balanceador de carga de aplicativo pode falhar e as etapas de resolução de problemas correspondentes:

<table>
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
 <td><ol><li>Verifique a precisão da sequência CRN do certificado que você fornece.</li><li>Se for constatado que o CRN do certificado está exato, tente atualizar o segredo: <code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Se esse comando resultar no status <code>update_failed</code>, remova o segredo: <code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></li><li>Implemente o segredo novamente: <code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de atualização está incorreto.</td>
 <td><ol><li>Verifique a precisão da sequência CRN do certificado que você fornece.</li><li>Se for constatado que o CRN do certificado está exato, remova o segredo: <code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></li><li>Implemente o segredo novamente: <code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Tente atualizar o segredo: <code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>O serviço {{site.data.keyword.cloudcerts_long_notm}} está tendo tempo de inatividade.</td>
 <td>Verifique se o serviço {{site.data.keyword.cloudcerts_short}} está funcionando.</td>
 </tr>
 </tbody></table>

<br />


## Não é possível instalar um gráfico Helm com valores de configuração atualizados
{: #cs_helm_install}

{: tsSymptoms}
Ao tentar instalar um gráfico Helm atualizado executando `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>`, você obtém a mensagem de erro `Error: failed to download "ibm/<chart_name>"`.

{: tsCauses}
A URL para o repositório do {{site.data.keyword.Bluemix_notm}} em sua instância do Helm pode estar incorreta.

{: tsResolve}
Para solucionar problemas de seu gráfico Helm:

1. Liste os repositórios disponíveis atualmente em sua instância do Helm.

    ```
    helm repo list
    ```
    {: pre}

2. Na saída, verifique se a URL para o repositório do {{site.data.keyword.Bluemix_notm}}, `ibm`, é `https://registry.bluemix.net/helm/ibm`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * Se a URL estiver incorreta:

        1. Remova o repositório do {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Inclua o repositório do {{site.data.keyword.Bluemix_notm}} novamente.

            ```
            helm repo add ibm https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * Se a URL estiver correta, obtenha as atualizações mais recentes do repositório.

        ```
        helm repo update
        ```
        {: pre}

3. Instale o gráfico Helm com suas atualizações.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}


<br />


## Não é possível estabelecer a conectividade VPN com o gráfico Helm do strongSwan
{: #cs_vpn_fails}

{: tsSymptoms}
Quando você verifica a conectividade VPN executando `kubectl exec -n kube-system $STRONGSWAN_POD -- ipsec status`, você não vê um status de `ESTABLISHED` ou o pod VPN está em um estado `ERROR` ou continua travando e reiniciando.

{: tsCauses}
Seu arquivo de configuração do gráfico Helm tem valores incorretos, valores ausentes ou erros de sintaxe.

{: tsResolve}
Quando você tentar estabelecer a conectividade VPN com o gráfico Helm do strongSwan, é provável que o status da VPN não seja `ESTABLISHED` na primeira vez. Você pode precisar verificar vários tipos de problemas e mudar seu arquivo de configuração de acordo. Para solucionar problemas de sua conectividade VPN do strongSwan:

1. Verifique as configurações de terminal de VPN no local com relação às configurações em seu arquivo de configuração. Se houver incompatibilidades:

    <ol>
    <li>Exclua o gráfico do Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija os valores incorretos no arquivo <code>config.yaml</code> e salve o arquivo atualizado.</li>
    <li>Instale o novo gráfico do Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

2. Se o pod VPN está em um estado de `ERROR` ou continua travando e reiniciando, pode ser devido à validação do parâmetro das configurações `ipsec.conf` no mapa de configuração do gráfico.

    <ol>
    <li>Verifique quaisquer erros de validação nos logs do pod do Strongswan.</br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>Se houver erros de validação, exclua o gráfico Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija os valores incorretos no arquivo `config.yaml` e salve o arquivo atualizado.</li>
    <li>Instale o novo gráfico do Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

3. Execute os 5 testes do Helm incluídos na definição de gráfico do strongSwan.

    <ol>
    <li>Execute os testes do Helm.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>Se algum teste falhar, consulte [Entendendo os testes de conectividade de VPN do Helm](cs_vpn.html#vpn_tests_table) para obter informações sobre cada teste e por que ele pode falhar. <b>Nota</b>: alguns dos testes têm requisitos que são configurações opcionais na configuração de VPN. Se alguns dos testes falharem, as falhas poderão ser aceitáveis, dependendo de se você especificou essas configurações opcionais.</li>
    <li>Visualize a saída de um teste com falha consultando os logs do pod de teste.<br><pre class="codeblock"><code>kubectl logs -n kube-system <test_program></code></pre></li>
    <li>Exclua o gráfico do Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija os valores incorretos no arquivo <code>config.yaml</code> e salve o arquivo atualizado.</li>
    <li>Instale o novo gráfico do Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    <li>Para verificar suas mudanças:<ol><li>Obtenha os pods do teste atual.</br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>Limpe os pods de teste atuais.</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>Execute os testes novamente.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. Execute a ferramenta de depuração da VPN empacotada dentro da imagem de pod da VPN.

    1. Configure a variável de ambiente `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. Execute a ferramenta de depuração.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        A ferramenta exibe várias páginas de informações conforme ela executa vários testes para problemas de rede comum. As linhas de saída que iniciam com `ERROR`, `WARNING`, `VERIFY` ou `CHECK` indicam erros possíveis com a conectividade VPN.

    <br />


## A conectividade VPN do StrongSwan falha após a adição ou exclusão do nó do trabalhador
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
Você estabeleceu anteriormente uma conexão VPN de trabalho, usando o serviço de VPN IPSec do strongSwan. No entanto, após ter incluído ou excluído um nó do trabalhador em seu cluster, você tem um ou mais dos sintomas a seguir:

* você não tem um status de VPN de `ESTABLISHED`
* não é possível acessar novos nós do trabalhador por meio de sua rede no local
* não é possível acessar a rede remota de pods que estão em execução em novos nós do trabalhador

{: tsCauses}
Se você tiver incluído um nó do trabalhador:

* o nó do trabalhador foi provisionado em uma nova sub-rede privada que não é exposta sobre a conexão VPN por suas configurações `localSubnetNAT` ou `local.subnet` existentes
* as rotas de VPN não podem ser incluídas no nó do trabalhador porque o trabalhador tem contaminações ou rótulos que não estão incluídos em suas configurações `tolerations` ou `nodeSelector` existentes
* o pod de VPN está em execução no novo nó do trabalhador, mas o endereço IP público desse nó do trabalhador não é permitido por meio do firewall no local

Se você tiver excluído um nó do trabalhador:

* esse nó do trabalhador foi o único nó em que um pod de VPN estava em execução, devido a restrições em certas contaminações ou rótulos em suas configurações `tolerations` ou `nodeSelector` existentes

{: tsResolve}
Atualize os valores do gráfico Helm para refletir as mudanças do nó do trabalhador:

1. Exclua o gráfico do Helm existente.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Abra o arquivo de configuração para seu serviço de VPN do strongSwan.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Verifique as configurações a seguir e faça mudanças para refletir os nós do trabalhador excluídos ou incluídos, conforme necessário.

    Se você tiver incluído um nó do trabalhador:

    <table>
     <thead>
     <th>Configuração</th>
     <th>Descrição</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>O nó do trabalhador incluído pode ser implementado em uma nova sub-rede privada diferente das outras sub-redes existentes em que outros nós do trabalhador estão. Se você está usando a sub-rede NAT para remapear os endereços IP locais privados de seu cluster e o nó do trabalhador foi incluído em uma nova sub-rede, inclua a nova sub-rede CIDR nesta configuração.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Se você limitou anteriormente o pod de VPN para execução em quaisquer nós do trabalhador com um rótulo específico e deseja que as rotas de VPN sejam incluídas no trabalhador, certifique-se de que o nó do trabalhador incluído tenha esse rótulo.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Se o nó do trabalhador incluído está contaminado e você deseja que as rotas de VPN sejam incluídas no trabalhador, mude essa configuração para permitir que o pod de VPN seja executado em todos os nós do trabalhador contaminados ou nós do trabalhador com contaminações específicas.</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>O nó do trabalhador incluído pode ser implementado em uma nova sub-rede privada diferente das outras sub-redes existentes em que outros nós do trabalhador estão. Se seus apps são expostos por serviços NodePort ou LoadBalancer na rede privada e eles estão em um novo nó do trabalhador que você incluiu, inclua a nova sub-rede CIDR nesta configuração. **Nota**: se você incluir valores para `local.subnet`, verifique as configurações de VPN para a sub-rede no local para ver se elas também devem ser atualizadas.</td>
     </tr>
     </tbody></table>

    Se você tiver excluído um nó do trabalhador:

    <table>
     <thead>
     <th>Configuração</th>
     <th>Descrição</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Se você está usando a sub-rede NAT para remapear endereços IP locais privados específicos, remova quaisquer endereços IP do nó do trabalhador antigo. Se você está usando a sub-rede NAT para remapear sub-redes inteiras e não têm nós do trabalhador restantes em uma sub-rede, remova essa sub-rede CIDR desta configuração.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Se você limitou anteriormente o pod de VPN para execução em um único nó do trabalhador e esse nó do trabalhador foi excluído, mude essa configuração para permitir que o pod de VPN seja executado em outros nós do trabalhador.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Se você nó do trabalhador excluído não foi contaminado, mas os únicos nós do trabalhador que permanecem estão contaminados, mude essa configuração para permitir que o pod de VPN seja executado em todos os nós do trabalhador contaminados ou nós do trabalhador com contaminações específicas.
     </td>
     </tr>
     </tbody></table>

4. Instale o novo gráfico Helm com os seus valores atualizados.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. Verifique o status de implementação do gráfico. Quando o gráfico estiver pronto, o campo **STATUS** perto da parte superior da saída terá um valor de `DEPLOYED`.

    ```
    helm status <release_name>
    ```
    {: pre}

6. Em alguns casos, você pode precisar mudar suas configurações no local e suas configurações de firewall para corresponderem às mudanças feitas no arquivo de configuração de VPN.

7. Inicie a VPN.
    * Se a conexão VPN é iniciada pelo cluster (`ipsec.auto` está configurado para `start`), inicie a VPN no gateway no local e, em seguida, inicie a VPN no cluster.
    * Se a conexão VPN é iniciada pelo gateway no local (`ipsec.auto` está configurado para `auto`), inicie a VPN no cluster e, em seguida, inicie a VPN no gateway no local.

8. Configure a variável de ambiente `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. Verifique o status da VPN.

    ```
    kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * Se a conexão VPN tem um status de `ESTABLISHED`, a conexão VPN foi bem-sucedida. Nenhuma ação adicional é necessária.

    * Se você ainda está tendo problemas de conexão, veja [Não é possível estabelecer a conectividade VPN com o gráfico Helm do strongSwan](#cs_vpn_fails) para solucionar problemas posteriormente de sua conexão VPN.

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
{: shortdesc}

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
