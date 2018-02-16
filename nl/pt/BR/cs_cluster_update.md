---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Atualizando clusters e nós do trabalhador
{: #update}

## Atualizando o mestre do Kubernetes
{: #master}

Periodicamente, o Kubernetes libera atualizações. Isso pode ser uma [atualização principal, menor ou de correção](cs_versions.html#version_types). Dependendo do tipo de atualização, você pode ser responsável por atualizar seu mestre do Kubernetes. Você é sempre responsável por manter seus nós do trabalhador atualizados. Ao fazer atualizações, o mestre do Kubernetes é atualizado antes de seus nós do trabalhador.
{:shortdesc}

Por padrão, limitamos a sua capacidade para atualizar um mestre do Kubernetes para mais de duas versões secundárias à frente de sua versão atual. Por exemplo, se o seu mestre atual é a versão 1.5 e você deseja atualizar para 1.8, deve-se primeiro atualizar para 1.7. É possível forçar a ocorrência da atualização, mas atualizar mais de duas versões secundárias pode causar resultados inesperados.

O diagrama a seguir mostra o processo que você pode usar para atualizar seu mestre.

![Melhor prática de atualização de mestre](/images/update-tree.png)

Figura 1. Atualizando o diagrama do processo de mestre do Kubernetes

**Atenção**: não é possível recuperar um cluster para uma versão anterior quando o processo de atualização ocorre. Certifique-se de usar um cluster de teste e siga as instruções para direcionar problemas potenciais antes de atualizar o mestre de produção.

Para atualizações _principal_ ou _menor_, conclua as etapas a seguir:

1. Revise as [mudanças do Kubernetes](cs_versions.html) e faça as atualizações marcadas como _Atualizar antes do mestre_.
2. Atualize seu mestre do Kubernetes usando a GUI ou executando o [comando da CLI](cs_cli_reference.html#cs_cluster_update). Ao atualizar o mestre do Kubernetes, o mestre estará inativo por cerca de 5 a 10 minutos. Durante a atualização, não é possível acessar nem mudar o cluster. No entanto, os nós do trabalhador, apps e recursos que os usuários do cluster implementaram não serão modificados e continuarão a executar.
3. Confirme que a atualização foi concluída. Revise a versão do Kubernetes no Painel do {{site.data.keyword.Bluemix_notm}} ou execute `bx cs clusters`.

Quando a atualização do mestre do Kubernetes for concluída, será possível atualizar seus nós do trabalhador.

<br />


## Atualizando nós do trabalhador
{: #worker_node}

Então, você recebeu uma notificação para atualizar seus nós do trabalhador. O que isso significa? Os seus dados são armazenados dentro dos pods em seus nós do trabalhador. Conforme as atualizações de segurança e as correções são colocadas no local para o mestre do Kubernetes, você precisa ter certeza de que seus nós do trabalhador permanecem em sincronização. O mestre do nó do trabalhador não pode ser maior que o mestre do Kubernetes.
{: shortdesc}

<ul>**Atenção**:</br>
<li>As atualizações para os nós do trabalhador podem causar tempo de inatividade para seus apps e serviços.</li>
<li>Os dados são excluídos se não armazenados fora do pod.</li>
<li>Use [réplicas ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) em suas implementações para reagendar os pods em nós disponíveis.</li></ul>

Mas e se eu não puder ter o tempo de inatividade?

Como parte do processo de atualização, nós específicos vão ficar inativos por um período de tempo. Para ajudar a evitar o tempo de inatividade para seu aplicativo, é possível definir chaves exclusivas em um mapa de configuração que especifica as porcentagens de limite para tipos específicos de nós durante o processo de upgrade. Definindo regras baseadas em rótulos padrão do Kubernetes e dando uma porcentagem da quantia máxima de nós que são permitidos estar indisponíveis, é possível assegurar que seu app continua funcionando. Um nó é considerado indisponível se ele ainda está para concluir o processo de implementação.

Como as chaves são definidas?

No mapa de configuração, há uma seção que contém informações de dados. É possível definir até 10 regras separadas para executar a qualquer momento. Para que um nó do trabalhador seja submetido a upgrade, os nós devem passar em todas as regras definidas no mapa.

As chaves estão definidas. E agora?

Depois de definir suas regras, você executa o comando worker-upgrade. Se uma resposta de êxito é retornada, os nós do trabalhador são enfileirados para serem submetidos a upgrade. No entanto, os nós não são submetidos ao processo de upgrade até que todas as regras estejam satisfeitas. Enquanto são enfileiradas, as regras são verificadas em um intervalo para ver se qualquer um dos nós pode ser submetido a upgrade.

E se eu escolher não definir um mapa de configuração?

Quando o mapa de configuração não está definido, o padrão é usado. Por padrão, um máximo de 20% de todos os nós do trabalhador em cada cluster ficam indisponíveis durante o processo de atualização.

Para atualizar seus nós do trabalhador:

1. Instale a versão do [`kubectl cli` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) que corresponde à versão do Kubernetes do mestre do Kubernetes.

2. Faça quaisquer mudanças que estejam marcadas como _Atualizar após o mestre_ em [Mudanças do Kubernetes](cs_versions.html).

3. Opcional: defina seu mapa de configuração.
    Exemplo:

    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 70,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
         "NodeSelectorValue": "dal13"
       }
     regioncheck.json: |
       {
         "MaxUnavailablePercentage": 80,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
         "NodeSelectorValue": "us-south"
       }
    ...
     defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 100
       }
    ```
    {:pre}
  <table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o parâmetro na coluna um e a descrição que corresponde na coluna dois.">
    <thead>
      <th colspan=2><img src="images/idea.png"/> Entendendo os componentes </th>
    </thead>
    <tbody>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td> Como um padrão, se o mapa ibm-cluster-update-configuration não está definido de uma maneira válida, somente 20% de seus clusters podem ficar indisponíveis por vez. Se uma ou mais regras válidas são definidas sem um padrão global, o novo padrão é para permitir que 100% dos trabalhadores fiquem indisponíveis por vez. É possível controlar isso criando uma porcentagem padrão. </td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td> Exemplos de chaves exclusivas para as quais você deseja configurar regras. Os nomes das chaves pode ser qualquer coisa que você desejar; as informações são analisadas pelas configurações definidas na chave. Para cada chave definida, é possível configurar somente um valor para <code>NodeSelectorKey</code> e <code>NodeSelectorValue</code>. Se você deseja configurar regras para mais de uma região ou local (data center), crie uma nova entrada de chave. </td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td> A quantia máxima, especificada em porcentagem, de nós que são permitidos estar indisponíveis para uma chave especificada. Um nó está indisponível quando no processo de implementação, recarregamento ou fornecimento. O upgrade dos nós do trabalhador enfileirados é bloqueado se eles excedem quaisquer percentagens máximas definidas disponíveis. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td> O tipo de rótulo para o qual você deseja configurar uma regra para uma chave especificada. É possível configurar regras para os rótulos padrão fornecidos pela IBM, bem como sobre os rótulos que você criou. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td> O subconjunto de nós em uma chave especificada que a regra está configurada para avaliar. </td>
      </tr>
    </tbody>
  </table>

    **Nota**: um máximo de 10 regras podem ser definidas. Se você inclui mais de 10 chaves em um arquivo, somente um subconjunto das informações é analisado.

3. Atualize seus nós do trabalhador na GUI ou executando o comando da CLI.
  * Para atualizar do Painel do {{site.data.keyword.Bluemix_notm}}, navegue para a seção `Nós do trabalhador` de seu cluster e clique em `Atualizar trabalhador`.
  * Para obter IDs de nó do trabalhador, execute `bx cs workers <cluster_name_or_id>`. Se você seleciona múltiplos nós do trabalhador, os nós do trabalhador são colocados em uma fila para avaliação de atualização. Se eles forem considerados prontos após a avaliação, eles serão atualizados de acordo com as regras definidas nas configurações

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. Opcional: verifique os eventos que são acionados pelo mapa de configuração e quaisquer erros de validação que ocorrem executando o comando a seguir e examinando **Eventos**.
    ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
    {: pre}

5. Confirme se a atualização foi concluída:
  * Revise a versão do Kubernetes no Painel do {{site.data.keyword.Bluemix_notm}} ou execute `bx cs workers <cluster_name_or_id>`.
  * Revise a versão do Kubernets dos nós do trabalhador executando `kubectl get nodes`.
  * Em alguns casos, clusters mais velhos podem listar nós do trabalhador duplicados com um status de **NotReady** após uma atualização. Para remover duplicatas, consulte [Resolução de problemas](cs_troubleshoot.html#cs_duplicate_nodes).

Próximas etapas:
  - Repita o processo de atualização com outros clusters.
  - Informe aos desenvolvedores que trabalham no cluster para atualizar sua CLI `kubectl` para a versão do mestre do Kubernetes.
  - Se o painel do Kubernetes não exibir gráficos de utilização, [exclua o pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).
<br />

