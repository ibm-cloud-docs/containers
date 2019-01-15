---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Resolução de problemas de clusters e nós do trabalhador
{: #cs_troubleshoot_clusters}

Ao usar o {{site.data.keyword.containerlong}}, considere estas técnicas para resolução de problemas de seus clusters e nós do trabalhador.
{: shortdesc}

Se você tiver um problema mais geral, tente a [depuração do cluster](cs_troubleshoot.html).
{: tip}

## Não é possível criar um cluster devido a erros de permissão
{: #cs_credentials}

{: tsSymptoms}
Ao criar um novo cluster do Kubernetes, você recebe uma mensagem de erro semelhante a uma das seguintes.

```
Não foi possível se conectar à sua conta de infraestrutura do IBM Cloud (SoftLayer).
Criar um cluster padrão requer que você tenha uma conta pré-paga vinculada a um termo da conta de infraestrutura do IBM Cloud (SoftLayer) ou que tenha usado a CLI do {{site.data.keyword.containerlong_notm}} para configurar as suas chaves API de Infraestrutura do {{site.data.keyword.Bluemix_notm}}.
```
{: screen}

```
Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: 'Item' deve ser pedido com permissão.
```
{: screen}

```
Exceção de infraestrutura do {{site.data.keyword.Bluemix_notm}}: o usuário não tem as permissões de infraestrutura necessárias do {{site.data.keyword.Bluemix_notm}} para incluir servidores
```
{: screen}

```
A solicitação de troca de token do IAM falhou: não é possível criar o token do portal do IMS, pois nenhuma conta do IMS está vinculada à conta selecionada do BSS
```
{: screen}

```
O cluster não pôde ser configurado com o registro. Certifique-se de que você tenha a função de Administrador para o {{site.data.keyword.registrylong_notm}}.
```
{: screen}

{: tsCauses}
Você não tem as permissões corretas para criar um cluster. Você precisa das permissões a seguir para criar um cluster:
*  Função **Superusuário** para a infraestrutura do IBM Cloud (SoftLayer).
*  Função de gerenciamento de plataforma **Administrador** para o {{site.data.keyword.containerlong_notm}} no nível de conta.
*  Função de gerenciamento de plataforma **Administrador** para o {{site.data.keyword.registrylong_notm}} no nível de conta. Não limite políticas do {{site.data.keyword.registryshort_notm}} para o nível do grupo de recursos. Se você começou a usar o {{site.data.keyword.registrylong_notm}} antes de 4 de outubro de 2018, assegure-se de [ativar o cumprimento de política do {{site.data.keyword.Bluemix_notm}} IAM](/docs/services/Registry/registry_users.html#existing_users).

Para erros relacionados à infraestrutura, as contas Pré-pagas do {{site.data.keyword.Bluemix_notm}} que foram criadas após a ativação da vinculação de conta automática já estão configuradas com acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer). É possível comprar recursos de infraestrutura para seu cluster sem configuração adicional. Se você tiver uma conta Pré-paga válida e receber essa mensagem de erro, talvez não esteja usando as credenciais de conta de infraestrutura do IBM Cloud (SoftLayer) corretas para acessar recursos de infraestrutura.

Os usuários com outros tipos de conta do {{site.data.keyword.Bluemix_notm}} devem configurar suas contas para criar clusters padrão. Exemplos de quando você pode ter um tipo de conta diferente são:
* Você tem uma conta de infraestrutura do IBM Cloud (SoftLayer) existente que precede sua conta da plataforma {{site.data.keyword.Bluemix_notm}} e deseja continuar a usá-la.
* Você deseja usar uma conta de infraestrutura do IBM Cloud (SoftLayer) diferente para provisionar recursos de infraestrutura. Por exemplo, você pode configurar uma conta do {{site.data.keyword.Bluemix_notm}} de equipe para usar uma conta de infraestrutura diferente para propósitos de faturamento.

Se você usar uma conta de infraestrutura do IBM Cloud (SoftLayer) diferente para provisionar recursos de infraestrutura, também poderá ter [clusters órfãos](#orphaned) em sua conta.

{: tsResolve}
O proprietário da conta deve configurar as credenciais de conta de infraestrutura corretamente. As credenciais dependem do tipo de conta de infraestrutura que você está usando.

1.  Verifique se você tem acesso a uma conta de infraestrutura. Efetue login no [console {{site.data.keyword.Bluemix_notm}}![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/) e, no menu ![Ícone Menu](../icons/icon_hamburger.svg "Ícone Menu"), clique em **Infraestrutura**. Se vir o painel de infraestrutura, você terá acesso a uma conta de infraestrutura.
2.  Verifique se o cluster usa uma conta de infraestrutura diferente daquela que é fornecida com sua conta Pré-paga.
    1.  No menu ![Ícone Menu](../icons/icon_hamburger.svg "Ícone Menu"), clique em **Contêineres > Clusters**.
    2.  A partir da tabela, selecione seu cluster.
    3.  Na guia **Visão geral**, verifique um campo **Usuário de infraestrutura**.
        * Se não vir o campo **Usuário de infraestrutura**, você terá uma conta Pré-paga vinculada que usa as mesmas credenciais para suas contas de infraestrutura e de plataforma.
        * Se você vir um campo **Usuário de infraestrutura**, seu cluster usará uma conta de infraestrutura diferente daquela que veio com sua conta Pré-paga. Essas credenciais diferentes se aplicam a todos os clusters dentro da região.
3.  Decida qual tipo de conta você deseja ter para determinar como solucionar problemas de permissão de infraestrutura. Para a maioria dos usuários, a conta Pré-paga vinculada padrão é suficiente.
    *  Conta Pré-paga do {{site.data.keyword.Bluemix_notm}} vinculada: [verifique se a chave API está configurada com as permissões corretas](cs_users.html#default_account). Se seu cluster está usando uma conta de infraestrutura diferente, deve-se desconfigurar essas credenciais como parte do processo.
    *  Contas de plataforma e infraestrutura do {{site.data.keyword.Bluemix_notm}} diferentes: verifique se é possível acessar o portfólio de infraestrutura e se [as credenciais de conta de infraestrutura estão configuradas com as permissões corretas](cs_users.html#credentials).
4.  Se não for possível ver os nós do trabalhador do cluster em sua conta de infraestrutura, você poderá verificar se o [cluster está órfão](#orphaned).

<br />


## O firewall evita a execução de comandos da CLI
{: #ts_firewall_clis}

{: tsSymptoms}
Quando você executa os comandos `ibmcloud`, `kubectl` ou `calicoctl` na CLI, eles falham.

{: tsCauses}
Você pode ter políticas de rede corporativa que impedem o acesso de seu sistema local a terminais públicos por proxies ou firewalls.

{: tsResolve}
[Permita acesso TCP para os comandos da CLI funcionarem](cs_firewall.html#firewall_bx). Essa tarefa requer a [função de plataforma do IAM **Administrador** do {{site.data.keyword.Bluemix_notm}}](cs_users.html#platform) para o cluster.


## O firewall evita que o cluster se conecte a recursos
{: #cs_firewall}

{: tsSymptoms}
Quando os nós do trabalhador não podem se conectar, você pode ver vários sintomas diferentes. É possível que você veja uma das mensagens a seguir quando o proxy kubectl falhar ou você tentar acessar um serviço em seu cluster e a conexão falhar.

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
Você pode ter outro firewall configurado ou pode ter customizado suas configurações de firewall existentes em sua conta de infraestrutura do IBM Cloud (SoftLayer). O {{site.data.keyword.containerlong_notm}} requer que determinados endereços IP e portas sejam abertos para permitir a comunicação do nó do trabalhador com o mestre do Kubernetes e vice-versa. Outro motivo talvez seja que os nós do trabalhador estejam presos em um loop de recarregamento.

{: tsResolve}
[Permita que o cluster acesse os recursos de infraestrutura e outros serviços](cs_firewall.html#firewall_outbound). Essa tarefa requer a [função de plataforma do IAM **Administrador** do {{site.data.keyword.Bluemix_notm}}](cs_users.html#platform) para o cluster.

<br />



## Não é possível visualizar ou trabalhar com um cluster
{: #cs_cluster_access}

{: tsSymptoms}
* Você não consegue localizar um cluster. Quando você executa `ibmcloud ks clusters`, o cluster não é listado na saída.
* Você não consegue trabalhar com um cluster. Quando você executa `ibmcloud ks cluster-config` ou outros comandos específicos do cluster, o cluster não é localizado.


{: tsCauses}
No {{site.data.keyword.Bluemix_notm}}, cada recurso deve estar em um grupo de recursos. Por exemplo, o cluster `mycluster` pode existir no grupo de recursos `default`. Quando o proprietário da conta fornece acesso a recursos, designando a você uma função da plataforma do {{site.data.keyword.Bluemix_notm}} IAM, o acesso pode ser a um recurso específico ou ao grupo de recursos. Quando você recebe acesso a um recurso específico, não é necessário acesso ao grupo de recursos. Nesse caso, você não precisa destinar um grupo de recursos para trabalhar com os clusters aos quais tem acesso. Se você destinar um grupo de recursos diferente do grupo no qual o cluster está, as ações com relação a esse cluster poderão falhar. Por outro lado, quando você recebe acesso a um recurso como parte de seu acesso a um grupo de recursos, deve-se destinar um grupo de recursos para trabalhar com um cluster nesse grupo. Se você não destinar a sua sessão da CLI para o grupo de recursos no qual o cluster está, as ações com relação a esse cluster poderão falhar.

Se não for possível localizar ou trabalhar com um cluster, você poderá estar experimentando um dos problemas a seguir:
* Você tem acesso ao cluster e ao grupo de recursos no qual o cluster está, mas a sessão da CLI não é destinada para o grupo de recursos no qual o cluster está.
* Você tem acesso ao cluster, mas não como parte do grupo de recursos no qual o cluster está. Sua sessão da CLI é destinada a esse ou outro grupo de recursos.
* Você não tem acesso ao cluster.

{: tsResolve}
Para verificar suas permissões de acesso de usuário:

1. Liste todas as suas permissões de usuário.
    ```
    ibmcloud iam user-policies <your_user_name>
    ```
    {: pre}

2. Verifique se você tem acesso ao cluster e ao grupo de recursos em que o cluster está.
    1. Procure uma política que tenha um valor de **Nome do grupo de recursos** do grupo de recursos do cluster e um valor de **Memorando** igual a `Policy applies to the resource group`. Se tiver essa política, você terá acesso ao grupo de recursos. Por exemplo, essa política indica que um usuário tem acesso ao grupo de recursos `test-rg`:
        ```
        Policy ID:   3ec2c069-fc64-4916-af9e-e6f318e2a16c
        Roles:       Viewer
        Resources:
                     Resource Group ID     50c9b81c983e438b8e42b2e8eca04065
                     Resource Group Name   test-rg
                     Memo                  Policy applies to the resource group
        ```
        {: screen}
    2. Procure uma política que tenha um valor de **Nome do grupo de recursos** do grupo de recursos do cluster, um valor de **Nome do serviço** igual a `containers-kubernetes` ou nenhum valor e um valor de **Memorando** igual a `Policy applies to the resource(s) within the resource group`. Se tiver essa política, você terá acesso a clusters ou a todos os recursos dentro do grupo de recursos. Por exemplo, essa política indica que um usuário tem acesso a clusters no grupo de recursos `test-rg`:
        ```
        Policy ID:   e0ad889d-56ba-416c-89ae-a03f3cd8eeea
        Roles:       Administrator
        Resources:
                     Resource Group ID     a8a12accd63b437bbd6d58fb6a462ca7
                     Resource Group Name   test-rg
                     Service Name          containers-kubernetes
                     Service Instance
                     Region
                     Resource Type
                     Resource
                     Memo                  Policy applies to the resource(s) within the resource group
        ```
        {: screen}
    3. Se você tiver ambas as políticas, vá para a Etapa 4, primeiro marcador. Se você não tiver a política da Etapa 2a, mas tiver a política da Etapa 2b, vá para a Etapa 4, segundo marcador. Se não tiver nenhuma dessas políticas, continue com a Etapa 3.

3. Verifique se você tem acesso ao cluster, mas não como parte de acesso ao grupo de recursos em que o cluster está.
    1. Procure uma política que não tenha valores além dos campos **ID de política** e **Funções**. Se tiver essa política, você terá acesso ao cluster como parte do acesso à conta inteira. Por exemplo, essa política indica que um usuário tem acesso a todos os recursos na conta:
        ```
        Policy ID:   8898bdfd-d520-49a7-85f8-c0d382c4934e
        Roles:       Administrator, Manager
        Resources:
                     Service Name
                     Service Instance
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    2. Procure uma política que possua um valor de **Nome do serviço** igual a `containers-kubernetes` e um valor de **Instância de serviço** do ID do cluster. É possível localizar um ID de cluster executando `ibmcloud ks cluster-get <cluster_name>`. Por exemplo, essa política indica que um usuário tem acesso a um cluster específico:
        ```
        Policy ID:   140555ce-93ac-4fb2-b15d-6ad726795d90
        Roles:       Administrator
        Resources:
                     Service Name       containers-kubernetes
                     Service Instance   df253b6025d64944ab99ed63bb4567b6
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    3. Se você tiver qualquer uma dessas políticas, vá para o segundo ponto de marcador da etapa 4. Se não tiver nenhuma dessas políticas, vá para o terceiro ponto de marcador da etapa 4.

4. Dependendo de suas políticas de acesso, escolha uma das opções a seguir.
    * Se você tiver acesso ao cluster e ao grupo de recursos em que o cluster está:
      1. Destine o grupo de recursos. **Nota**: não é possível trabalhar com clusters em outros grupos de recursos até que você cancele a destinação desse grupo de recursos.
          ```
          ibmcloud target -g <resource_group>
          ```
          {: pre}

      2. Destine o cluster.
          ```
          ibmcloud ks cluster-config <cluster_name_or_ID>
          ```
          {: pre}

    * Se você tiver acesso ao cluster, mas não ao grupo de recursos em que o cluster está:
      1. Não destinar um grupo de recursos. Se você já tiver destinado um grupo de recursos, remova seu destino:
        ```
        ibmcloud target -g none
        ```
        {: pre}
        Esse comando falha porque não existe nenhum grupo de recursos denominado `none`. No entanto, o grupo de recursos atual tem o destino automaticamente removido quando o comando falha.

      2. Destine o cluster.
        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

    * Se você não tiver acesso ao cluster:
        1. Peça ao proprietário da conta para designar uma [{{site.data.keyword.Bluemix_notm}}função da plataforma IAM](cs_users.html#platform) a você para esse cluster.
        2. Não destinar um grupo de recursos. Se você já tiver destinado um grupo de recursos, remova seu destino:
          ```
          ibmcloud target -g none
          ```
          {: pre}
          Esse comando falha porque não existe nenhum grupo de recursos denominado `none`. No entanto, o grupo de recursos atual tem o destino automaticamente removido quando o comando falha.
        3. Destine o cluster.
          ```
          ibmcloud ks cluster-config <cluster_name_or_ID>
          ```
          {: pre}

<br />


## O acesso a seu nó do trabalhador com SSH falha
{: #cs_ssh_worker}

{: tsSymptoms}
Não é possível acessar seu nó do trabalhador usando uma conexão SSH.

{: tsCauses}
O SSH por senha está indisponível nos nós do trabalhador.

{: tsResolve}
Use um [`DaemonSet` do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para ações que devem ser executadas em cada nó ou use tarefas para ações únicas que devem ser executadas.

<br />


## O ID da instância bare metal está inconsistente com os registros do trabalhador
{: #bm_machine_id}

{: tsSymptoms}
Ao usar os comandos `ibmcloud ks workerr ` com o nó do trabalhador bare metal, você vê uma mensagem semelhante à seguinte.

```
ID da instância inconsistente com registros do trabalhador
```
{: screen}

{: tsCauses}
O ID da máquina pode se tornar inconsistente com o registro do trabalhador do {{site.data.keyword.containerlong_notm}} quando a máquina tem problemas de hardware. Quando a infraestrutura do IBM Cloud (SoftLayer) resolve esse problema, um componente pode mudar dentro do sistema que o serviço não identifica.

{: tsResolve}
Para o {{site.data.keyword.containerlong_notm}} reidentificar a máquina, [recarregue o nó do trabalhador bare metal](cs_cli_reference.html#cs_worker_reload). **Nota**: o recarregamento também atualiza a [versão de correção](cs_versions_changelog.html) da máquina.

Também é possível [excluir o nó do trabalhador bare metal](cs_cli_reference.html#cs_cluster_rm). **Nota**: as instâncias bare metal são faturadas mensalmente.

<br />


## Não é possível modificar ou excluir a infraestrutura em um cluster órfão
{: #orphaned}

{: tsSymptoms}
Não é possível executar comandos relacionados à infraestrutura em seu cluster, tais como:
* Incluindo ou removendo nós do trabalhador
* Recarregando ou reinicializando nós do trabalhador
* Redimensionando conjuntos de trabalhadores
* Atualizando seu cluster

Não é possível visualizar os nós do trabalhador do cluster em sua conta de infraestrutura do IBM Cloud (SoftLayer). No entanto, é possível atualizar e gerenciar outros clusters na conta.

Além disso, você verificou que tem as [credenciais de infraestrutura adequadas](#cs_credentials).

{: tsCauses}
O cluster pode ser provisionado em uma conta de infraestrutura do IBM Cloud (SoftLayer) que não está mais vinculada à sua conta do {{site.data.keyword.containerlong_notm}}. O cluster é órfão. Como os recursos estão em uma conta diferente, você não tem as credenciais de infraestrutura para modificar os recursos.

Considere o cenário a seguir para entender como os clusters podem se tornar órfãos.
1.  Você tem uma conta pré-paga do {{site.data.keyword.Bluemix_notm}}.
2.  Você cria um cluster chamado `Cluster1`. Os nós do trabalhador e outros recursos de infraestrutura são provisionados na conta de infraestrutura fornecida com sua conta Pré-paga.
3.  Posteriormente, você descobre que sua equipe usa uma conta de infraestrutura do IBM Cloud (SoftLayer) anterior ou compartilhada. Você usa o comando `ibmcloud ks credential-set` para mudar as credenciais de infraestrutura do IBM Cloud (SoftLayer) para usar a sua conta de equipe.
4.  Você cria um outro cluster chamado  ` Cluster2 `. Os nós do trabalhador e outros recursos de infraestrutura são provisionados na conta de infraestrutura da equipe.
5.  Você observa que o `Cluster1` precisa de uma atualização do nó do trabalhador, um recarregamento do nó do trabalhador ou você deseja apenas limpar excluindo-o. No entanto, como o `Cluster1` foi provisionado em uma conta de infraestrutura diferente, não é possível modificar seus recursos de infraestrutura. ` Cluster1 `  é órfão.
6.  Você segue as etapas de resolução na seção a seguir, mas não configura as credenciais de infraestrutura de volta para sua conta de equipe. É possível excluir `Cluster1`, mas agora `Cluster2` está órfão.
7.  Você muda suas credenciais de infraestrutura de volta para a conta de equipe que criou o `Cluster2`. Agora, você não tem mais um cluster órfão!

<br>

{: tsResolve}
1.  Verifique qual conta de infraestrutura a região em que seu cluster está usa atualmente para provisionar clusters.
    1.  Efetue login no [console do cluster do {{site.data.keyword.containerlong_notm}}![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/containers-kubernetes/clusters).
    2.  A partir da tabela, selecione seu cluster.
    3.  Na guia **Visão geral**, verifique um campo **Usuário de infraestrutura**. Esse campo ajuda a determinar se a sua conta do {{site.data.keyword.containerlong_notm}} usa uma conta de infraestrutura diferente do padrão.
        * Se não vir o campo **Usuário de infraestrutura**, você terá uma conta Pré-paga vinculada que usa as mesmas credenciais para suas contas de infraestrutura e de plataforma. O cluster que não pode ser modificado pode ser provisionado em uma conta de infraestrutura diferente.
        * Se você vir um campo **Usuário de infraestrutura**, use uma conta de infraestrutura diferente daquela que veio com a sua conta Pré-paga. Essas credenciais diferentes se aplicam a todos os clusters dentro da região. O cluster que não pode ser modificado pode ser provisionado em sua conta Pré-paga ou em uma conta de infraestrutura diferente.
2.  Verifique qual conta de infraestrutura foi usada para provisionar o cluster.
    1.  Na guia **Nós do trabalhador**, selecione um nó do trabalhador e anote seu **ID**.
    2.  Abra o menu ![Ícone de menu](../icons/icon_hamburger.svg "Ícone de menu") e clique em **Infraestrutura**.
    3.  Na área de janela de navegação de infraestrutura, clique em **Dispositivos > Lista de dispositivos**.
    4.  Procure o ID do nó do trabalhador que você anotou anteriormente.
    5.  Se você não localizar o ID do nó do trabalhador, o nó do trabalhador não será provisionado para essa conta de infraestrutura. Alterne para uma conta de infraestrutura diferente e tente novamente.
3.  Use o [comando](cs_cli_reference.html#cs_credentials_set) `ibmcloud ks credential-set` para mudar suas credenciais de infraestrutura para a conta na qual os nós do trabalhador do cluster são provisionados, que você localizou na etapa anterior.
    Se você não tiver mais acesso e não puder obter as credenciais de infraestrutura, deverá abrir um caso de suporte do {{site.data.keyword.Bluemix_notm}} para remover o cluster órfão.
    {: note}
4.  [ Exclua o cluster ](cs_clusters.html#remove).
5.  Se desejar, reconfigure as credenciais de infraestrutura para a conta anterior. Observe que, se você criou clusters com uma conta de infraestrutura diferente da conta para a qual está alternando, poderá deixar órfãos esses clusters.
    * Para configurar credenciais para uma conta de infraestrutura diferente, use o [comando](cs_cli_reference.html#cs_credentials_set) `ibmcloud ks credential-set`.
    * Para usar as credenciais padrão que acompanham sua conta Pré-paga do {{site.data.keyword.Bluemix_notm}}, use o [comando](cs_cli_reference.html#cs_credentials_unset) `ibmcloud ks credential-unset`.

<br />


## Comandos de ` kubectl `  de tempo limite
{: #exec_logs_fail}

{: tsSymptoms}
Se executar comandos como `kubectl exec`, `kubectl attach`, `kubectl proxy`, `kubectl port-forward` ou `kubectl logs`, você verá a mensagem a seguir.

  ```
  WorkerIP> <: 10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
A conexão OpenVPN entre o nó principal e os nós do trabalhador não está funcionando corretamente.

{: tsResolve}
1. Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).
2. Reinicie o pod cliente OpenVPN.
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. Se você ainda vê a mesma mensagem de erro, então o nó do trabalhador em que o pod de VPN está pode não estar funcional. Para reiniciar o pod de VPN e reagendá-lo para um nó do trabalhador diferente, [bloqueie, drene e reinicialize o nó do trabalhador](cs_cli_reference.html#cs_worker_reboot) em que o pod de VPN está.

<br />


## Ligar um serviço a um cluster resulta no erro de mesmo nome
{: #cs_duplicate_services}

{: tsSymptoms}
Quando você executa `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, você vê a mensagem a seguir.

```
Múltiplos serviços com o mesmo nome foram localizados.
Execute 'ibmcloud service list' para visualizar as instâncias de serviço disponíveis do Bluemix...
```
{: screen}

{: tsCauses}
Múltiplas instâncias de serviço podem ter o mesmo nome em regiões diferentes.

{: tsResolve}
Use o GUID de serviço em vez do nome da instância de serviço no comando `ibmcloud ks cluster-service-bind`.

1. [Efetue login na região que inclui a instância de serviço para ligação.](cs_regions.html#bluemix_regions)

2. Obtenha o GUID para a instância de serviço.
  ```
  ibmcloud service show < service_instance_name> -- guid
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
  ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />


## Ligar um serviço a um cluster resulta no erro de serviço não localizado
{: #cs_not_found_services}

{: tsSymptoms}
Quando você executa `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, você vê a mensagem a seguir.

```
Ligando o serviço a um namespace...
COM FALHA

O serviço IBM Cloud especificado não pôde ser localizado. Se você acabou de criar o serviço, espere um pouco e, em seguida, tente ligá-lo novamente. Para visualizar as instâncias de serviço disponíveis do IBM Cloud, execute 'ibmcloud service list'. (E0023)
```
{: screen}

{: tsCauses}
Para ligar serviços a um cluster, deve-se ter a função de usuário de desenvolvedor do Cloud Foundry para o espaço no qual a instância de serviço é provisionada. Além disso, deve-se ter o acesso da plataforma do {{site.data.keyword.Bluemix_notm}} IAM Editor ao {{site.data.keyword.containerlong}}. Para acessar a instância de serviço, deve-se ter efetuado login no espaço no qual a instância de serviço é provisionada.

{: tsResolve}

**Como o usuário:**

1. Efetue login no {{site.data.keyword.Bluemix_notm}}.
   ```
   ibmcloud login
   ```
   {: pre}

2. Destine a organização e o espaço nos quais a instância de serviço é provisionada.
   ```
   ibmcloud target -o <org> -s <space>
   ```
   {: pre}

3. Verifique se você está no espaço certo listando suas instâncias de serviço.
   ```
   Lista de serviços ibmcloud
   ```
   {: pre}

4. Tente ligar o serviço novamente. Se obtiver o mesmo erro, entre em contato com o administrador de conta e verifique se você tem permissões suficientes para ligar serviços (veja as etapas de administrador de conta).

**Como o administrador de conta:**

1. Verifique se o usuário que experiencia esse problema tem [permissões de Editor para o {{site.data.keyword.containerlong}}](/docs/iam/mngiam.html#editing-existing-access).

2. Verifique se o usuário que experiencia esse problema tem a [função de desenvolvedor do Cloud Foundry para o espaço](/docs/iam/mngcf.html#updating-cloud-foundry-access) no qual o serviço é provisionado.

3. Se as permissões corretas existirem, tente designar uma permissão diferente e, em seguida, redesignar a permissão necessária.

4. Aguarde alguns minutos, em seguida, permita que o usuário tente ligar o serviço novamente.

5. Se isso não resolver o problema, as permissões do {{site.data.keyword.Bluemix_notm}} IAM estão fora de sincronização e não é possível resolver o problema sozinho. [Entre em contato com o suporte IBM](/docs/get-support/howtogetsupport.html#getting-customer-support) abrindo um caso de suporte. Certifique-se de fornecer o ID do cluster, o ID do usuário e o ID da instância de serviço.
   1. Recupere o ID do cluster.
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. Recupere o ID da instância de serviço.
      ```
      ibmcloud service show < service_name> -- guid
      ```
      {: pre}


<br />


## Ligar um serviço a um cluster resulta em serviço que não suporta erros de chaves de serviço
{: #cs_service_keys}

{: tsSymptoms}
Quando você executa `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, você vê a mensagem a seguir.

```
Esse serviço não suporta a criação de chaves
```
{: screen}

{: tsCauses}
Alguns serviços no {{site.data.keyword.Bluemix_notm}}, como o {{site.data.keyword.keymanagementservicelong}}, não suportam a criação de credenciais de serviço, também referidas como chaves de serviço. Sem o suporte de chaves de serviço, o serviço não é vinculável a um cluster. Para localizar uma lista de serviços que suportem a criação de chaves de serviço, veja [Ativando apps externos para usar serviços do {{site.data.keyword.Bluemix_notm}}](/docs/resources/connect_external_app.html#externalapp).

{: tsResolve}
Para integrar serviços que não suportam chaves de serviço, verifique se o serviço fornece uma API que pode ser usada para acessar o serviço diretamente de seu app. Por exemplo, se você desejar usar {{site.data.keyword.keymanagementservicelong}}, consulte a [Referência de API ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/apidocs/kms?language=curl).

<br />


## Após um nó do trabalhador ser atualizado ou recarregado, nós e pods duplicados aparecem
{: #cs_duplicate_nodes}

{: tsSymptoms}
Ao executar `kubectl get nodes`, você vê nós do trabalhador duplicados com o status **NotReady**. Os nós do trabalhador com **NotReady** têm endereços IP públicos, enquanto os nós do trabalhador com **Ready** possuem endereços IP privados.

{: tsCauses}
Os clusters mais antigos listam os nós do trabalhador pelo endereço IP público do cluster. Agora, os nós do trabalhador são listados pelo endereço IP privado do cluster. Ao recarregar ou atualizar um nó, o endereço IP é mudado, mas a referência ao endereço IP público permanece.

{: tsResolve}
O serviço não é interrompido devido a essas duplicatas, mas é possível remover as referências do nó do trabalhador antigo do servidor de API.

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
Se você exclui um nó do trabalhador de seu cluster e, em seguida, inclui um nó do trabalhador, o novo nó do trabalhador pode ser designado a endereço IP privado do nó do trabalhador excluído. O Calico usa esse endereço IP privado como uma tag e continua tentando acessar o nó excluído.

{: tsResolve}
Atualize manualmente a referência do endereço IP privado para apontar para o nó correto.

1.  Confirme que você tem dois nós do trabalhador com o mesmo endereço **IP privado**. Observe o **IP privado** e o **ID** do trabalhador excluído.

  ```
  ibmcloud ks workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Zone   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.11
  ```
  {: screen}

2.  Instale a [CLI do Calico](cs_network_policy.html#adding_network_policies).
3.  Liste os nós do trabalhador disponíveis no Calico. Substitua <path_to_file> pelo caminho local para o arquivo de configuração do Calico.

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Exclua o nó do trabalhador duplicado no Calico. Substitua NODE_ID pelo ID do nó do trabalhador.

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  Reinicialize o nó do trabalhador que não foi excluído.

  ```
  ibmcloud ks worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


O nó excluído não é mais listado no Calico.

<br />




## Os pods falham ao serem implementados por causa de uma política de segurança de pod
{: #cs_psp}

{: tsSymptoms}
Depois de criar um pod ou executar `kubectl get events` para verificar uma implementação de pod, você vê uma mensagem de erro semelhante à seguinte.

```
unable to validate against any pod security policy
```
{: screen}

{: tsCauses}
[O controlador de admissão `PodSecurityPolicy`](cs_psp.html) verifica a autorização da conta de usuário ou de serviço, como uma implementação ou um Helm tiller, que tentou criar o pod. Se nenhuma política de segurança de pod suportar a conta de usuário ou de serviço, o controlador de admissão `PodSecurityPolicy` evitará que os pods sejam criados.

Se tiver excluído um dos recursos de política de segurança de pod para o [gerenciamento de cluster do {{site.data.keyword.IBM_notm}}](cs_psp.html#ibm_psp), você poderá ter problemas semelhantes.

{: tsResolve}
Certifique-se de que a conta de usuário ou de serviço esteja autorizada por uma política de segurança de pod. Pode ser necessário [modificar uma política existente](cs_psp.html#customize_psp).

Se você excluiu um recurso de gerenciamento de cluster do {{site.data.keyword.IBM_notm}}, atualize o mestre do Kubernetes para restaurá-lo.

1.  [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).
2.  Atualize o mestre do Kubernetes para restaurá-lo.

    ```
    ibmcloud ks apiserver-refresh
    ```
    {: pre}


<br />




## O cluster permanece em um estado pendente
{: #cs_cluster_pending}

{: tsSymptoms}
Quando você implementa o seu cluster, ele permanece em um estado pendente e não é iniciado.

{: tsCauses}
Se você acabou de criar o cluster, os nós do trabalhador podem ainda estar sendo configurados. Se já espera por um tempo, você pode ter uma VLAN inválida.

{: tsResolve}

É possível tentar uma das soluções a seguir:
  - Verifique o status de seu cluster executando `ibmcloud ks clusters`. Em seguida, verifique se os nós do trabalhador estão implementados executando `ibmcloud ks workers <cluster_name>`.
  - Verifique se a sua VLAN é válida. Para ser válida, uma VLAN deve ser associada à infraestrutura que pode hospedar um trabalhador com armazenamento em disco local. É possível [listar suas VLANs](/docs/containers/cs_cli_reference.html#cs_vlans) executando `ibmcloud ks vlans <zone>`, se a VLAN não é mostrada na lista, então ela não é válida. Escolha uma VLAN diferente.

<br />


## Os pods permanecem no estado pendente
{: #cs_pods_pending}

{: tsSymptoms}
Ao executar `kubectl get pods`, será possível ver pods que permanecem em um estado **Pendente**.

{: tsCauses}
Se você acabou de criar o cluster do Kubernetes, os nós do trabalhador podem ainda estar configurando.

Se esse cluster for um existente:
*  Você pode não ter capacidade suficiente em seu cluster para implementar o pod.
*  O pod pode ter excedido uma solicitação de recurso ou um limite.

{: tsResolve}
Esta tarefa requer a função [**Administrador** da plataforma](cs_users.html#platform) IAM {{site.data.keyword.Bluemix_notm}} para o cluster.

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

4.  Se você não tiver capacidade suficiente em seu cluster, redimensione seu conjunto de trabalhadores para incluir mais nós.

    1.  Revise os tamanhos atuais e os tipos de máquina de seus conjuntos de trabalhadores para decidir qual deve ser redimensionado.

        ```
        ibmcloud ks worker-pools
        ```
        {: pre}

    2.  Redimensione seus conjuntos de trabalhadores para incluir mais nós em cada zona que o conjunto abrange.

        ```
        ibmcloud ks worker-pool-resize <worker_pool> --cluster <cluster_name_or_ID> --size-per-zone <workers_per_zone>
        ```
        {: pre}

5.  Opcional: verifique as solicitações de recurso do pod.

    1.  Confirme se os valores `resources.requests` não são maiores que a capacidade do nó do trabalhador. Por exemplo, se o pod solicitar `cpu: 4000m` ou 4 núcleos, mas o tamanho do nó do trabalhador for somente 2 núcleos, o pod não poderá ser implementado.

        ```
        kubectl get pod < pod_name> -o yaml
        ```
        {: pre}

    2.  Se a solicitação exceder a capacidade disponível, [inclua um novo conjunto de trabalhadores](cs_clusters.html#add_pool) com os nós do trabalhador que podem cumprir a solicitação.

6.  Se os pods ainda estiverem em um estado **pendente** depois que o nó do trabalhador for totalmente implementado, revise a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) para solucionar posteriormente os problemas no estado pendente do pod.

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


## Os pods falham repetidamente ao serem reiniciados ou são removidos inesperadamente
{: #pods_fail}

{: tsSymptoms}
Sua pod estava funcional, mas inesperadamente é removido ou fica preso em um loop de reinicialização.

{: tsCauses}
Seus contêineres podem exceder seus limites de recurso ou seus pods podem ser substituídos por pods de prioridade mais alta.

{: tsResolve}
Para ver se um contêiner está sendo encerrado por causa de um limite de recurso:
<ol><li>Obtenha o nome de seu pod. Se você usou um rótulo, será possível incluí-lo para filtrar seus resultados.<pre class="pre"><code> kubectl get pods -- selector = 'app = wasliberty' </code></pre></li>
<li>Descreva o pod e procure a **Contagem de reinicializações**.<pre class="pre"><code>kubectl describe pod</code></pre></li>
<li>Se o pod reiniciou muitas vezes em um curto período de tempo, busque seu status. <pre class="pre"><code>kubectl get pod -o go-template={{range.status.containerStatuses}}{{"Container Name: "}}{{.name}}{{"\r\nLastState: "}}{{.lastState}}{{end}}</code></pre></li>
<li>Revise o motivo. Por exemplo, `OOM Killed` significa "falta de memória", indicando que o contêiner está travando devido a um limite de recurso.</li>
<li>Inclua capacidade em seu cluster para que os recursos possam ser preenchidos.</li></ol>

<br>

Para ver se seu pod está sendo substituído por pods de prioridade mais alta:
1.  Obtenha o nome de seu pod.

    ```
    kubectl get pods
    ```
    {: pre}

2.  Descreva seu pod YAML.

    ```
    kubectl get pod < pod_name> -o yaml
    ```
    {: pre}

3.  Verifique o campo  ` priorityClassName ` .

    1.  Se não houver nenhum valor de campo `priorityClassName`, seu pod terá a classe de prioridade `globalDefault`. Se seu administrador de cluster não configurou uma classe de prioridade `globalDefault`, o padrão será zero (0) ou a prioridade mais baixa. Qualquer pod com uma classe de prioridade mais alta pode priorizar ou remover seu pod.

    2.  Se houver um valor de campo `priorityClassName`, obtenha a classe de prioridade.

        ```
        kubectl get priorityclass < priority_class_name> -o yaml
        ```
        {: pre}

    3.  Anote o campo `value` para verificar a prioridade de seu pod.

4.  Liste as classes de prioridade existentes no cluster.

    ```
    kubectl get priorityclasses
    ```
    {: pre}

5.  Para cada classe de prioridade, obtenha o arquivo YAML e anote o campo `value`.

    ```
    kubectl get priorityclass < priority_class_name> -o yaml
    ```
    {: pre}

6.  Compare o valor da classe de prioridade de seu pod com os outros valores de classe de prioridade para ver se ele tem prioridade mais alta ou mais baixa.

7.  Repita as etapas 1 a 3 para outros pods no cluster, para verificar qual classe de prioridade eles estão usando. Se a classe de prioridade desses outros pods for maior que aquela de seu pod, seu pod não será provisionado a menos que haja recursos suficientes para ele e todos os pods com prioridade mais alta.

8.  Entre em contato com o administrador de cluster para incluir mais capacidade em seu cluster e confirmar se as classes de prioridade correta estão designadas.

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


## Obtendo ajuda e suporte
{: #ts_getting_help}

Ainda está tendo problemas com o seu cluster?
{: shortdesc}

-  No terminal, você é notificado quando atualizações para a CLI `ibmcloud` e plug-ins estão disponíveis. Certifique-se de manter sua CLI atualizada para que seja possível usar todos os comandos e sinalizações disponíveis.
-   Para ver se o {{site.data.keyword.Bluemix_notm}} está disponível, [verifique a página de status do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).
-   Poste uma pergunta no [{{site.data.keyword.containerlong_notm}} Slack ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com).
    Se você não estiver usando um IBMid para a sua conta do {{site.data.keyword.Bluemix_notm}}, [solicite um convite](https://bxcs-slack-invite.mybluemix.net/) para essa Folga.
    {: tip}
-   Revise os fóruns para ver se outros usuários tiveram o mesmo problema. Ao usar os fóruns para fazer uma pergunta, marque sua pergunta para que ela seja vista pelas equipes de desenvolvimento do {{site.data.keyword.Bluemix_notm}}.
    -   Se você tiver questões técnicas sobre como desenvolver ou implementar clusters ou apps com o {{site.data.keyword.containerlong_notm}}, poste sua pergunta no [Stack Overflow ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo") ](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e identifique-a com `ibm-cloud`, `kubernetes` e `containers`.
    -   Para perguntas sobre o serviço e instruções de introdução, use o fórum do [IBM Developer Answers ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Inclua as tags `ibm-cloud` e `containers`.
    Consulte [Obtendo ajuda](/docs/get-support/howtogetsupport.html#using-avatar) para obter mais detalhes sobre o uso dos fóruns.
-   Entre em contato com o Suporte IBM abrindo um caso. Para saber mais sobre como abrir um caso de suporte IBM ou sobre os níveis de suporte e as severidades do caso, consulte [Entrando em contato com o suporte](/docs/get-support/howtogetsupport.html#getting-customer-support).
Ao relatar um problema, inclua o ID do cluster. Para obter o ID do seu cluster, execute `ibmcloud ks clusters`.
{: tip}

