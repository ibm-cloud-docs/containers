---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

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


# Resolução de problemas de clusters e nós do trabalhador
{: #cs_troubleshoot_clusters}

Ao usar o {{site.data.keyword.containerlong}}, considere estas técnicas para resolução de problemas de seus clusters e nós do trabalhador.
{: shortdesc}

Se você tiver um problema mais geral, tente a [depuração do cluster](cs_troubleshoot.html).
{: tip}

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


## Depois de atualizar ou recarregar um nó do trabalhador, os aplicativos receberão erros RBAC DENY
{: #cs_rbac_deny}

{: tsSymptoms}
Depois de atualizar para o Kubernetes versão 1.7, os aplicativos receberão erros `RBAC DENY`.

{: tsCauses}
A partir do [Kubernetes versão 1.7](cs_versions.html#cs_v17), os aplicativos executados no namespace `padrão` não têm mais privilégios de administrador de cluster para a API do Kubernetes para segurança aprimorada.

Se o seu app for executado no namespace `padrão`, use o `default ServiceAccount` e acesse a API do Kubernetes, ele é afetado por esta mudança do Kubernetes. Para obter mais informações, veja [a documentação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/authorization/rbac/#upgrading-from-15).

{: tsResolve}
Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

1.  **Ação provisória**: ao atualizar as políticas de RBAC do app, talvez você queira reverter provisoriamente para o `ClusterRoleBinding` anterior do `default ServiceAccount` no namespace `default`.

    1.  Copie os seguintes `.yaml` arquivo.

        ```yaml
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-nonResourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-nonResourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-resourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-resourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ```

    2.  Aplique os arquivos `.yaml` em seu cluster.

        ```
        Kubectl apply -f FILENAME
        ```
        {: pre}

2.  [Crie recursos de autorização RBAC![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) para atualizar o acesso de administrador `ClusterRoleBinding`.

3.  Se você criou uma ligação de função de cluster provisória, remova-a.

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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.8.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.8.11
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
  Bx cs worker-add < cluster_name_or_ID> 1
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

-   Para ver se o {{site.data.keyword.Bluemix_notm}} está disponível, [verifique a página de status do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).
-   Poste uma pergunta no [Slack do {{site.data.keyword.containershort_notm}}. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com)
    Se você não estiver usando um IBMid para a sua conta do {{site.data.keyword.Bluemix_notm}}, [solicite um convite](https://bxcs-slack-invite.mybluemix.net/) para essa Folga.
    {: tip}
-   Revise os fóruns para ver se outros usuários tiveram o mesmo problema. Ao usar os fóruns para fazer uma pergunta, marque sua pergunta para que ela seja vista pelas equipes de desenvolvimento do {{site.data.keyword.Bluemix_notm}}.

    -   Se você tiver questões técnicas sobre como desenvolver ou implementar clusters ou apps com o {{site.data.keyword.containershort_notm}}, poste sua pergunta no [Stack Overflow ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e identifique a sua pergunta com `ibm-cloud`, `kubernetes` e `containers`.
    -   Para perguntas sobre o serviço e instruções de introdução, use o fórum [IBM developerWorks dW Answers ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Inclua as tags `ibm-cloud` e `containers`.
    Consulte [Obtendo ajuda](/docs/get-support/howtogetsupport.html#using-avatar) para obter mais detalhes sobre o uso dos fóruns.

-   Entre em contato com o Suporte IBM abrindo um chamado. Para obter informações sobre como abrir um chamado de suporte IBM ou sobre níveis de suporte e severidades de chamado, consulte [Entrando em contato com o suporte](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Ao relatar um problema, inclua seu ID do cluster. Para obter o ID do cluster, execute `bx cs clusters`.


