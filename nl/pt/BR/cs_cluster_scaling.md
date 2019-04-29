---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, node scaling

subcollection: containers

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
{:gif: data-image-type='gif'}



# Clusters de Escalação
{: #ca}

Com o {{site.data.keyword.containerlong_notm}} plug-in `ibm-iks-cluster-autoscaler`, é possível escalar os conjuntos de trabalhadores em seu cluster automaticamente para aumentar ou diminuir o número de nós do trabalhador no conjunto de trabalhadores com base nas necessidades de dimensionamento de suas cargas de trabalho planejadas. O plug-in `ibm-iks-cluster-autoscaler` é baseado no [projeto Kubernetes Cluster-Autoscaler ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler).
{: shortdesc}

Deseja automaticamente escalar seus pods? Efetue check-out de  [ Scaling apps ](/docs/containers?topic=containers-app#app_scaling).
{: tip}

O escalador automático de cluster está disponível para clusters padrão que são configurados com conectividade de rede pública. Se o seu cluster não puder acessar a rede pública, como um cluster privado atrás de um firewall ou um cluster com apenas o terminal em serviço privado ativado, não será possível usar o escalador automático de cluster em seu cluster.
{: important}

## Entendendo como o Autoscaler do Cluster Funciona
{: #ca_about}

O escalador automático de cluster varre periodicamente o cluster para ajustar o número de nós do trabalhador nos conjuntos de trabalhadores que ele gerencia em resposta às suas solicitações de recurso de carga de trabalho e quaisquer configurações customizadas que você configurar, como intervalos de varredura. A cada minuto, o escalador automático de cluster verifica as situações a seguir.
{: shortdesc}

*   **Pods pendentes para aumentar a capacidade**: um pod é considerado pendente quando existem recursos de cálculo insuficientes para planejar o pod em um nó do trabalhador. Quando o escalador automático de cluster detecta os pods pendentes, ele aumenta a capacidade de seus nós do trabalhador uniformemente entre as zonas para atender às solicitações de recursos da carga de trabalho.
*   **Nós do trabalhador subutilizado para escalar para baixo**: Por padrão, os nós do trabalhador que são executados com menos de 50% do total de recursos de cálculo solicitados por 10 minutos ou mais e que podem reprogramar suas cargas de trabalho em outros nós do trabalhador são considerados subutilizados. Se o escalador automático de cluster detectar nós do trabalhador subutilizados, ele diminuirá a capacidade dos nós do trabalhador um de cada vez para que você tenha apenas os recursos de cálculo necessários. Se desejar, será possível [customizar](/docs/containers?topic=containers-ca#ca_chart_values) o limite de utilização de redução de escala padrão de 50% por 10 minutos.

A varredura e o aumento e redução de escala acontecem em intervalos regulares ao longo do tempo e, dependendo do número de nós do trabalhador, podem levar um período de tempo mais longo para serem concluídas, como 30 minutos.

O escalador automático de cluster ajusta o número de nós do trabalhador considerando as [solicitações de recurso ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) que você define para suas implementações, não o uso real do nó do trabalhador. Se seus pods e implementações não solicitarem quantias apropriadas de recursos, você deverá ajustar seus arquivos de configuração. O escalador automático de cluster não pode ajustá-los para você. Além disso, lembre-se de que os nós do trabalhador usam alguns de seus recursos de cálculo para a funcionalidade básica de cluster, [complementos](/docs/containers?topic=containers-update#addons) padrão e customizados e [reservas de recurso](/docs/containers?topic=containers-plan_clusters#resource_limit_node).
{: note}

<br>
**O que é escalonamento para cima e para baixo?**<br>
Em geral, o escalador automático de cluster calcula o número de nós do trabalhador que seu cluster precisa para executar sua carga de trabalho. O aumento ou diminuição da capacidade do cluster depende de vários fatores, incluindo o seguinte.
*   O tamanho mínimo e máximo do nó do trabalhador por zona que você configurou.
*   Suas solicitações de recurso de pod pendentes e determinados metadados que você associa com a carga de trabalho, como antiafinidade, rótulos para colocar os pods apenas em determinados tipos de máquina ou [orçamentos de interrupção do pod![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/).
*   Os conjuntos de trabalhadores que o escalador automático de cluster gerencia, potencialmente entre as zonas em um [cluster de múltiplas zonas](/docs/containers?topic=containers-plan_clusters#multizone).
*   Para obter mais informações, consulte as [FAQs do Kubernetes Cluster Autoscaler ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md).

**Como esse comportamento é diferente dos conjuntos de trabalhadores que não são gerenciados pelo escalador automático de cluster?**<br>
Quando você [cria um conjunto de trabalhadores](/docs/containers?topic=containers-clusters#add_pool), você especifica quantos nós do trabalhador por zona ele terá. O conjunto de trabalhadores mantém esse número de nós do trabalhador até você [redimensionar](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) ou [rebalancear](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance). O conjunto de trabalhadores não inclui nem remove nós do trabalhador para você. Se você tiver mais pods do que pode ser planejado, os pods permanecerão no estado pendente até que você redimensione o conjunto de trabalhadores.

Quando você ativa o escalador automático de cluster para um conjunto de trabalhadores, a capacidade dos nós do trabalhador é aumentada ou diminuída em resposta às suas configurações de especificação de pod e solicitações de recurso. Não é necessário redimensionar ou rebalancear o conjunto de trabalhadores manualmente.

**Posso ver um exemplo de como o escalador automático de cluster aumenta e diminui a capacidade?**<br>
Considere a imagem a seguir para obter um exemplo de aumento e diminuição de capacidade do cluster.

_Figura: Aumentando e diminuindo automaticamente a capacidade de um cluster._
![GIF de aumento e diminuição automáticos da capacidade de um cluster](images/cluster-autoscaler-x3.gif){: gif}

1.  O cluster tem quatro nós do trabalhador em dois conjuntos de trabalhadores que são difundidos entre duas zonas. Cada conjunto tem um nó do trabalhador por zona, mas o **Conjunto de trabalhadores A** tem um tipo de máquina `u2c.2x4` e o **Conjunto de trabalhadores B** tem um tipo de máquina `b2c.4x16`. Seu total de recursos de cálculo é aproximadamente 10 núcleos (2 núcleos x 2 nós do trabalhador para o **Conjunto de trabalhadores A** e 4 núcleos x 2 nós do trabalhador para o **Conjunto de trabalhadores B**). Seu cluster atualmente executa uma carga de trabalho que solicita 6 desses 10 núcleos. Observe que os recursos de computação adicionais são tomados em cada nó trabalhador pelos [recursos reservados](/docs/containers?topic=containers-plan_clusters#resource_limit_node) necessários para executar o cluster, nós do trabalhador e quaisquer complementos, como o auto-reinício do cluster.
2.  O escalador automático de cluster está configurado para gerenciar ambos os conjuntos de trabalhadores com os seguintes tamanhos mínimo e máximo por zona:
    *  ** Conjunto A do Trabalhador A **:  ` minSize=1 `,  ` maxSize=5 `.
    *  ** Conjunto do Trabalhador B **:  ` minSize=1 `,  ` maxSize=2 `.
3.  Você planeja implementações que requerem 14 réplicas de pod adicionais de um app que solicita 1 núcleo de CPU por réplica. Uma réplica de pod pode ser implementada nos recursos atuais, mas as outras 13 estão pendentes.
4.  O escalador automático de cluster aumenta a capacidade de seus nós do trabalhador dentro dessas restrições para suportar as 13 solicitações de recurso de réplicas de pod adicionais.
    *  **Conjunto de trabalhadores A**: 7 nós do trabalhador são incluídos em um método round-robin tão uniformemente quanto possível entre as zonas. Os nós do trabalhador aumentam a capacidade de cálculo do cluster em aproximadamente 14 núcleos (2 núcleos x 7 nós do trabalhador).
    *  **Conjunto de trabalhadores B**: 2 nós do trabalhador são incluídos uniformemente entre as zonas, atingindo o `maxSize` de 2 nós do trabalhador por zona. Os nós do trabalhador aumentam a capacidade do cluster em aproximadamente 8 núcleos (4 núcleos x 2 nós do trabalhador).
5.  As 20 cápsulas com solicitações de 1 núcleo são distribuídas conforme a seguir nos nós do trabalhador. Observe que, como os nós do trabalhador têm reservas de recursos, bem como os pods que são executados para cobrir recursos de cluster padrão, os pods para sua carga de trabalho não podem usar todos os recursos de cálculo disponíveis de um nó do trabalhador. Por exemplo, embora os nós do trabalhador do `b2c.4x16` tenham 4 núcleos, apenas 3 pods que solicitam um mínimo de 1 núcleo podem ser planejados para os nós do trabalhador.
    <table summary="Uma tabela que descreve a distribuição da carga de trabalho em cluster escalado.">
    <caption>Distribuição de carga de trabalho no cluster escalado.</caption>
    <thead>
    <tr>
      <th>Conjunto do trabalhador</th>
      <th>Zona</th>
      <th>Tipo</th>
      <th># nós do trabalhador</th>
      <th># pods</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>A</td>
      <td>dal10</td>
      <td>u2c.2x4</td>
      <td>4 nós</td>
      <td>3 pods</td>
    </tr>
    <tr>
      <td>A</td>
      <td>dal12</td>
      <td>u2c.2x4</td>
      <td>5 nós</td>
      <td>5 pods</td>
    </tr>
    <tr>
      <td>B</td>
      <td>dal10</td>
      <td>b2c.4x16</td>
      <td>2 nós</td>
      <td>6 pods</td>
    </tr>
    <tr>
      <td>B</td>
      <td>dal12</td>
      <td>b2c.4x16</td>
      <td>2 nós</td>
      <td>6 pods</td>
    </tr>
    </tbody>
    </table>
6.  Você não precisa mais da carga de trabalho adicional, portanto, exclua a implementação. Após um curto período de tempo, o escalador automático de cluster detecta que seu cluster não precisa mais de todos os seus recursos de cálculo e começa a diminuir a capacidade dos nós do trabalhador um de cada vez.
7.  Seus conjuntos de trabalhadores são escalados para baixo. O escalador automático de cluster varre em intervalos regulares para verificar se há solicitações de recurso de pod pendentes e nós do trabalhador subutilizados para aumentar ou diminuir a capacidade dos conjuntos de trabalhadores.

<br>
**Como posso garantir que meu nó do trabalhador e as práticas de implementação sejam escaláveis?**<br>
Aproveite ao máximo o escalador automático de cluster organizando seu nó do trabalhador e as estratégias de cargas de trabalho do app. Para obter mais informações, consulte as [FAQs do Kubernetes Cluster Autoscaler ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md).

<br>
**O que são algumas diretrizes gerais para conjuntos de trabalhadores e nós?**<br>
*   É possível executar somente um `ibm-iks-cluster-autoscaler` por cluster.
*   O escalador automático de cluster escala seu cluster em resposta às [solicitações de recurso![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) de sua carga de trabalho. Como tal, você não precisa [redimensionar](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) ou [rebalancear](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) seus conjuntos de trabalhadores.
*   Não use o [comando](/docs/containers?topic=containers-cs_cli_reference#cs_worker_rm) `ibmcloud ks worker-rm` para remover nós do trabalhador individuais de seu conjunto de trabalhadores, pois isso pode desequilibrar o conjunto de trabalhadores.
*   Como as contaminações não podem ser aplicadas no nível do conjunto de trabalhadores, não [contamine os nós do trabalhador](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) para evitar resultados inesperados. Por exemplo, ao implementar uma carga de trabalho que não é tolerada pelos nós do trabalhador contaminados, os nós do trabalhador não são considerados para aumento de capacidade e mais nós do trabalhador poderão ser pedidos, mesmo se o cluster tiver capacidade suficiente. No entanto, os nós do trabalhador contaminados ainda serão identificados como subutilizados se tiverem menos do que o limite (por padrão, 50%) de seus recursos utilizados e, portanto, serão considerados para redução de capacidade.

<br>
**O que são algumas diretrizes gerais para cargas de trabalho do app?**<br>
*   Tenha em mente que a auto-inicialização é baseada no uso de cálculo que seu pedido de configurações de carga de trabalho e não considera outros fatores, como custos da máquina.
*   Especifique [solicitações de recurso ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) para todas as suas implementações porque as solicitações de recurso são o que o escalador automático de cluster usa para calcular quantos nós do trabalhador são necessários para executar a carga de trabalho.
*   Use [orçamentos de interrupção do pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/) para evitar reagendamento abrupto ou exclusões de seus pods.
*   Se você estiver usando a prioridade do pod, será possível [editar o corte de prioridade ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#how-does-cluster-autoscaler-work-with-pod-priority-and-preemption) para mudar quais tipos de prioridade acionam o aumento de capacidade. Por padrão, o limite de prioridade é zero (`0`).

<br>
**Por que meus conjuntos de trabalhadores escalados automaticamente são não balanceados?**<br>
Durante um aumento de capacidade, o escalador automático de cluster balanceia os nós entre as zonas, com uma diferença permitida de um nó do trabalhador a mais ou a menos (+/- 1). Suas cargas de trabalho pendentes podem não solicitar capacidade suficiente para tornar cada zona balanceada. Nesse caso, se você desejar balancear manualmente os conjuntos de trabalhadores, [atualize o configmap do escalador automático de cluster](#ca_cm) para remover o conjunto de trabalhadores não balanceado. Em seguida, execute o [comando](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) `ibmcloud ks worker-pool-rebalance` e inclua o conjunto de trabalhadores de volta no configmap do escalador automático de cluster.

**Por que não posso redimensionar ou rebalancear meu conjunto de trabalhadores?**<br>
Quando o escalador automático de cluster está ativado para um conjunto de trabalhadores, não é possível [redimensionar](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) ou [rebalancear](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) seus conjuntos de trabalhadores. Deve-se [editar o configmap](#ca_cm) para mudar o tamanho mínimo ou máximo do conjunto de trabalhadores ou desativar a escalação automática de cluster para esse conjunto de trabalhadores.

Além disso, se você não desativar os conjuntos de trabalhadores antes de desinstalar o gráfico do Helm `ibm-iks-cluster-autoscaler`, os conjuntos de trabalhadores não poderão ser redimensionados manualmente. Reinstale o gráfico `ibm-iks-cluster-autoscaler` Helm, [edite o configmap](#ca_cm) para desativar o conjunto de trabalhadores e tente novamente.

<br />


## Implementando o gráfico do Helm do escalador automático de cluster em seu cluster
{: #ca_helm}

Instale o plug-in do escalador automático de cluster do {{site.data.keyword.containerlong_notm}} com um gráfico do Helm para escalar automaticamente os conjuntos de trabalhadores em seu cluster.
{: shortdesc}

** Antes de iniciar **:

1.  [ Instale a CLI e os plug-ins necessários ](/docs/cli?topic=cloud-cli-ibmcloud-cli):
    *  {{site.data.keyword.Bluemix_notm}}  CLI (` ibmcloud `)
    *  Plug-in do {{site.data.keyword.containerlong_notm}}  (` ibmcloud ks `)
    *  Plug-in do {{site.data.keyword.registrylong_notm}}  (` ibmcloud cr `)
    *  Kubernetes (` kubectl `)
    *  Helm (` helm `)
2.  [Crie um cluster padrão](/docs/containers?topic=containers-clusters#clusters_ui) que execute **Kubernetes versão 1.12 ou mais recente**.
3.   [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
4.  Confirme se suas credenciais do {{site.data.keyword.Bluemix_notm}} Identity and Access Management estão armazenadas no cluster. O autoscaler do cluster usa esse segredo para autenticar.
    ```
    kubectl get secrets -n kube-system | grep storage-secret-store
    ```
    {: pre}
5.  O escalador automático de cluster pode escalar apenas os conjuntos de trabalhadores que têm o rótulo `ibm-cloud.kubernetes.io/worker-pool-id`.
    1.  Verifique se o conjunto de trabalhadores tem o rótulo necessário.
        ```
        ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID> | grep Labels
        ```
        {: pre}

        Saída de exemplo de um conjunto de trabalhadores com o rótulo:
        ```
        Rótulos:             ibm-cloud.kubernetes.io/worker-pool-id=a1aa111111b22b22cc3c3cc444444d44-4d555e5
        ```
        {: screen}
    2.  Se o seu conjunto de trabalhadores não tiver o rótulo necessário, [inclua um novo conjunto de trabalhadores](/docs/containers?topic=containers-clusters#add_pool) e use esse conjunto de trabalhadores com o ajustador automático de escala do cluster.


<br>
**Para instalar o plug-in `ibm-iks-cluster-autoscaler` em seu cluster**:

1.  [Siga as instruções](/docs/containers?topic=containers-integrations#helm) para instalar o cliente **Helm versão 2.11 ou mais recente** em sua máquina local e instalar o servidor do Helm (tiller) com uma conta de serviço em seu cluster.
2.  Verifique se o tiller está instalado com uma conta do serviço.

    ```
    kubectl get serviceaccount -n kube-system | grep tiller
    ```
    {: pre}

    Saída de exemplo:

    ```
    NAME SECRETS AGE tiller 1 2m
    ```
    {: screen}
3.  Inclua e atualize o repositório do Helm no qual está o gráfico do Helm do escalador automático de cluster.
    ```
    helm repo incluir ibm https://registry.bluemix.net/helm/ibm/
    ```
    {: pre}
    ```
    helm repo update
    ```
    {: pre}
4.  Instale o gráfico do Helm do escalador automático de cluster no namespace `kube-system` de seu cluster.

    Também é possível [customizar as configurações do escalador automático de cluster](#ca_chart_values), como a quantia de tempo que ele aguarda antes de aumentar ou diminuir a capacidade dos nós do trabalhador.
    {: tip}

    ```
    helm install ibm/ibm-iks-cluster-autoscaler --namespace kube-system --name ibm-iks-cluster-autoscaler
    ```
    {: pre}

    Saída de exemplo:
    ```
    NAME:   ibm-iks-cluster-autoscaler
    LAST DEPLOYED: Thu Nov 29 13:43:46 2018
    NAMESPACE: kube-system
    STATUS: DEPLOYED

    RESOURCES:
    ==> v1/ClusterRole
    NAME                       AGE
    ibm-iks-cluster-autoscaler  1s

    == > v1/Pod (relacionado)

    NAME                                        READY  STATUS             RESTARTS  AGE
    ibm-iks-cluster-autoscaler-67c8f87b96-qbb6c  0/1    ContainerCreating  0         1s

    == > v1/ConfigMap

    NOME DA IDADE
    iks-ca-configmap 1s

    ==> v1/ClusterRoleBinding
    ibm-iks-cluster-autoscaler  1s

    ==> v1/Role
    ibm-iks-cluster-autoscaler  1s

    ==> v1/RoleBinding
    ibm-iks-cluster-autoscaler  1s

    ==> v1/Service
    ibm-iks-cluster-autoscaler  1s

    ==> v1beta1/Deployment
    ibm-iks-cluster-autoscaler  1s

    ==> v1/ServiceAccount
    ibm-iks-cluster-autoscaler  1s

    NOTAS:
    Agradecemos a instalação de: ibm-iks-cluster-autoscaler. Sua liberação é nomeada: ibm-iks-cluster-autoscaler

    Para obter mais informações sobre como usar o escalador automático de cluster, consulte o arquivo README.md do gráfico.
    ```
    {: screen}

5.  Verifique se a instalação foi bem-sucedida.

    1.  Verifique se o pod do escalador automático de cluster está em um estado **Em execução**.
        ```
        kubectl get pods --namespace=kube-system | grep ibm-iks-cluster-autoscaler
        ```
        {: pre}
        Saída de exemplo:
        ```
        ibm-iks-cluster-autoscaler-8497bfc968-dbn7w   1/1       Running   0          9m
        ```
        {: screen}
    2.  Verifique se o serviço do escalador automático de cluster foi criado.
        ```
        kubectl get service --namespace=kube-system | grep ibm-iks-cluster-autoscaler
        ```
        {: pre}
        Saída de exemplo:
        ```
        ibm-iks-cluster-autoscaler   ClusterIP   172.21.xxx.xx    <none>        8085/TCP        9m
        ```
        {: screen}

6.  Repita essas etapas para cada cluster no qual você deseja fornecer o escalador automático de cluster.

7.  Para iniciar o ajuste de escala de seus conjuntos de trabalhadores, consulte [Atualizando a configuração do escalador automático de cluster](#ca_cm).

<br />


## Atualizando o configmap do escalador automático de cluster para ativar o ajuste de escala
{: #ca_cm}

Atualize o configmap do escalador automático de cluster para permitir a escala automática dos nós do trabalhador em seus conjuntos de trabalhadores com base nos valores mínimo e máximo que você configurou.
{: shortdesc}

Depois de editar o configmap para ativar um conjunto de trabalhadores, o escalador automático de cluster começa a escalar seu cluster em resposta às suas solicitações de carga de trabalho. Como tal, não é possível [redimensionar](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) ou [rebalancear](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) os conjuntos de trabalhadores. A varredura e o aumento e redução de escala acontecem em intervalos regulares ao longo do tempo e, dependendo do número de nós do trabalhador, podem levar um período de tempo mais longo para serem concluídas, como 30 minutos. Posteriormente, se você desejar [remover o escalador automático de cluster](#ca_rm), deverá primeiro desativar cada conjunto de trabalhadores no configmap.
{: note}

** Antes de iniciar **:
*  [ Instale o plug-in  ` ibm-iks-cluster-cluster-autoscaler `  ](#ca_helm).
*  [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

**Para atualizar o configmap do escalador automático de cluster e os valores**:

1.  Edite o arquivo YAML do configmap do escalador automático de cluster.
    ```
    kubectl edit cm iks-ca-configmap -n kube-system -o yaml
    ```
    {: pre}
    Saída de exemplo:
    ```
    apiVersion: v1 data: workerPoolsConfig.json: | [
         {"name": "default","minSize": 1,"maxSize": 2,"enabled":false}
        ]
    kind: ConfigMap
    metadata:
      creationTimestamp: 2018-11-29T18:43:46Z
      name: iks-ca-configmap
      namespace: kube-system
      resourceVersion: "2227854"
      selfLink: /api/v1/namespaces/kube-system/configmaps/iks-ca-configmap
      uid: b45d047b-f406-11e8-b7f0-82ddffc6e65e
    ```
    {: screen}
2.  Edite o configmap com os parâmetros para definir como o escalador automático de cluster escalará seu conjunto de trabalhadores do cluster. Observe que, a menos que você [desativou](/docs/containers?topic=containers-cs_cli_reference#cs_alb_configure) os balanceadores de carga do aplicativo (ALBs) em seu cluster padrão, você deverá alterar o `minSize` para `2` por zona para que os pods ALB possam ser propagados para alta disponibilidade.

    <table>
    <caption>Parâmetros configmap do autocaler do cluster</caption>
    <thead>
    <th id="parameter-with-default">Parâmetro com valor padrão</th>
    <th id="parameter-with-description">Descrição</th>
    </thead>
    <tr>
    <th id="parameter-name" headers="parameter-with-default">`"name": "default"`</th>
    <td headers="parameter-name parameter-with-description">Substitua `"default"` pelo nome ou ID do conjunto de trabalhadores que você deseja escalar. Para listar os conjuntos de trabalhadores, execute `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`.<br><br>
    Para gerenciar mais de um conjunto de trabalhadores, copie a linha JSON para uma linha separada por vírgulas, como a seguir. <pre class="codeblock">[
     {1}, "maxSize": 2, "enabled" :false },
     {2}", "minSize": 2, "maxSize": 5, "enabled" :true }
    ]</pre><br><br>
    **Nota**: o escalador automático de cluster pode escalar apenas os conjuntos de trabalhadores que têm o rótulo `ibm-cloud.kubernetes.io/worker-pool-id`. Para verificar se o conjunto do trabalhador tem a etiqueta necessária, execute `ibmcloud ks worker-pool-get -- cluster <cluster_name_or_ID> -- worker-pool <worker_pool_name_or_ID> | grep Labels `. Se o seu conjunto de trabalhadores não tiver o rótulo necessário, [inclua um novo conjunto de trabalhadores](/docs/containers?topic=containers-clusters#add_pool) e use esse conjunto de trabalhadores com o ajustador automático de escala do cluster.</td>
    </tr>
    <tr>
    <th id="parameter-minsize" headers="parameter-with-default">` "minSize": 1 `</th>
    <td headers="parameter-minsize parameter-with-description">Especifique o número mínimo de nós do trabalhador por zona para estar no conjunto de trabalhadores em todos os momentos. O valor deve ser 2 ou superior para que seus pods do ALB possam ser difundidos para alta disponibilidade. Se você [desativou](/docs/containers?topic=containers-cs_cli_reference#cs_alb_configure) o ALB em seu cluster padrão, será possível configurar o valor para `1`.</td>
    </tr>
    <tr>
    <th id="parameter-maxsize" headers="parameter-with-default">` "maxSize": 2 `</th>
    <td headers="parameter-maxsize parameter-with-description">Especifique o número máximo de nós do trabalhador por zona para estar no conjunto de trabalhadores. O valor deve ser igual ou maior que o valor que você configurou para o `minSize`.</td>
    </tr>
    <tr>
    <th id="parameter-enabled" headers="parameter-with-default">` "enabled": false `</th>
    <td headers="parameter-enabled parameter-with-description">Configure o valor como `true` para o escalador automático de cluster para gerenciar o ajuste de escala para o conjunto de trabalhadores. Configure o valor como `false` para impedir que o escalador automático de cluster escale o conjunto de trabalhadores.<br><br>
    Posteriormente, se você desejar [remover o escalador automático de cluster](#ca_rm), deverá primeiro desativar cada conjunto de trabalhadores no configmap.</td>
    </tr>
    </tbody>
    </table>
3.  Salve o arquivo de configuração.
4.  Obtenha seu pod do autoescalador do cluster.
    ```
    kubectl get pods -n kube-system
    ```
    {: pre}
5.  Revise a seção **`Eventos`** do pod autoscaler do cluster para um evento **`ConfigUpdated`** para verificar se o configmap foi atualizado com êxito. A mensagem de evento para seu configmap está no formato a seguir: `minSize:maxSize:PoolName:<SUCCESS|FAILED>:error message `.

    ```
    kubectl describe pod -n kube-system <cluster_autoscaler_pod>
    ```
    {: pre}

    Saída de exemplo:
    ```
		Name: ibm-iks-cluster-autoscaler-857c4d9d54-gwvc6 		Namespace: kube-system 		...
		Events:
    Type    Reason                 Age   From                     Message
		----     ------         ----  ----                                        -------

		Normal ConfigUpdated 3m ibm-iks-cluster-autoscaler-857c4d9d54-gwvc6 {"1:3:default":"SUCCESS:"}
    ```
    {: screen}

## Customizando os valores de configuração do gráfico do Helm do escalador automático do cluster
{: #ca_chart_values}

Customize as configurações do escalador automático de cluster, como a quantia de tempo que ele aguarda antes de aumentar ou diminuir a capacidade dos nós do trabalhador.
{: shortdesc}

** Antes de iniciar **:
*  [ Instale o plug-in  ` ibm-iks-cluster-cluster-autoscaler `  ](#ca_helm).
*  [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

**Para atualizar os valores do autocalador do cluster**:

1.  Revise os valores de configuração do gráfico do Helm do escalador automático de cluster. O escalador automático de cluster vem com configurações padrão. No entanto, talvez você queira mudar alguns valores, como os intervalos de redução de escala ou varrição, dependendo da frequência com que você muda suas cargas de trabalho do cluster.
    ```
    helm get values ibm-iks-cluster-autoscaler -a
    ```
    {: pre}

    Saída de exemplo:
    ```
    expander: least-waste
    image:
      pullPolicy: Always
      repository: registry.ng.bluemix.net/armada-master/ibmcloud-cluster-autoscaler
      tag: dev1
    maxNodeProvisionTime: 120m
    resources:
      limits:
        cpu: 300m
        memory: 300Mi
      requests:
        cpu: 100m
        memory: 100Mi
    scaleDownDelayAfterAdd: 10m
    scaleDownDelayAfterDelete: 10m
    scaleDownUtilizationThreshold: 0.5
    scaleDownUnneededTime: 10m
    scanInterval: 1m
    skipNodes:
      withLocalStorage: true
      withSystemPods: true
    ```
    {: codeblock}

    <table>
    <caption>Valores de Configuração do Autoscaler do Cluster</caption>
    <thead>
    <th>Parâmetro</th>
    <th>Descrição</th>
    <th>Valor-padrão</th>
    </thead>
    <tbody>
    <tr>
    <td>Parâmetro ` api_route `</td>
    <td>Configure o [{{site.data.keyword.containerlong_notm}} terminal de API](/docs/containers?topic=containers-cs_cli_reference#cs_api) para a região em que está o seu cluster.</td>
    <td>Nenhum padrão. Use a região de destino em que está seu cluster.</td>
    </tr>
    <tr>
    <td>Parâmetro `expander`</td>
    <td>Especifique como o escalador automático de cluster determina qual conjunto de trabalhadores será escalado se você tiver múltiplos conjuntos de trabalhadores. Os valores possíveis são:
    <ul><li>`random`: seleciona aleatoriamente entre `most-pods` e `least-waste`.</li>
    <li>`most-pods`: seleciona o conjunto de trabalhadores que é capaz de planejar a maioria dos pods ao aumentar a capacidade. Use esse método se você estiver usando `nodeSelector` para certificar-se de que os pods sejam colocados em nós do trabalhador específicos.</li>
    <li>`least-waste`: seleciona o conjunto de trabalhadores que tem a CPU menos não utilizada ou, no caso de um empate, a memória menos não utilizada, após o aumento de capacidade. Use esse método se você tiver múltiplos conjuntos de trabalhadores com tipos de máquina com CPU e memória grandes e desejar usar essas máquinas maiores apenas quando os pods pendentes precisarem de grandes quantias de recursos.</li></ul></td>
    <td>aleatório</td>
    </tr>
    <tr>
    <td>Parâmetro ` image.repository `</td>
    <td>Especifique a imagem do Docker do escalador automático de cluster a ser usada.</td>
    <td>` registry.bluemix.net/ibm/ibmcloud-cluster-autoscaler `</td>
    </tr>
    <tr>
    <td>Parâmetro ` image.pullPolicy `</td>
    <td>Especifique quando extrair a imagem do Docker. Os valores possíveis são:
    <ul><li>`Always`: extrai a imagem toda vez que o pod é iniciado.</li>
    <li>`IfNotPresent`: Puxe a imagem apenas se a imagem ainda não estiver presente localmente.</li>
    <li>`Never`: assume que a imagem existe localmente e nunca extrai a imagem.</li></ul></td>
    <td>Sempre</td>
    </tr>
    <tr>
    <td>Parâmetro ` maxNodeProvisionTime `</td>
    <td>Configure a quantidade máxima de tempo em minutos que um nó trabalhador pode tomar para iniciar o fornecimento antes que o autoscaler do cluster cancele a solicitação de ajuste de escala.</td>
    <td>120 m</td>
    </tr>
    <tr>
    <td>parâmetro `resources.limits.cpu`</td>
    <td>Configure a quantia máxima de CPU do nó do trabalhador que o pod `ibm-iks-cluster-autoscaler` pode consumir.</td>
    <td>300m</td>
    </tr>
    <tr>
    <td>parâmetro ` resources.limits.memory `</td>
    <td>Configure a quantia máxima de memória do nó do trabalhador que o pod `ibm-iks-cluster-autoscaler` pode consumir.</td>
    <td>300Mi</td>
    </tr>
    <tr>
    <td>Parâmetro ` resources.requests.cpu `</td>
    <td>Configure a quantia mínima de CPU do nó do trabalhador com a qual o pod `ibm-iks-cluster-autoscaler` inicia.</td>
    <td>100m</td>
    </tr>
    <tr>
    <td>Parâmetro ` resources.requests.memory `</td>
    <td>Configure a quantia mínima de memória do nó do trabalhador com a qual o pod `ibm-iks-cluster-autoscaler` inicia.</td>
    <td>100Mi</td>
    </tr>
    <tr>
    <td>Parâmetro ` scaleDownUnneededTime `</td>
    <td>Configure a quantia de tempo em minutos em que um nó do trabalhador deve ser desnecessário antes de poder ter sua capacidade diminuída.</td>
    <td>10 m</td>
    </tr>
    <tr>
    <td>Parâmetros `scaleDownDelayAfterAdd`, `scaleDownDelayAfterDelete`</td>
    <td>Configure a quantia de tempo em minutos que o escalador automático de cluster aguarda para iniciar ações de ajuste de escala novamente após aumentar (`add`) ou diminuir (`delete`) a capacidade.</td>
    <td>10 m</td>
    </tr>
    <tr>
    <td>Parâmetro ` scaleDownUtilizationThreshold `</td>
    <td>Configure o limite de utilização do nó do trabalhador. Se a utilização do nó do trabalhador ficar abaixo do limite, a diminuição de capacidade desse nó do trabalhador será considerada. A utilização do nó do trabalhador é calculada como a soma dos recursos de CPU e memória que são solicitados por todos os pods executados no nó do trabalhador dividida pela capacidade de recursos do nó do trabalhador.</td>
    <td>0,5</td>
    </tr>
    <tr>
    <td>Parâmetro ` scanInterval `</td>
    <td>Configure com que frequência, em minutos, o escalador automático de cluster varre o uso de carga de trabalho que aciona o aumento ou a diminuição de capacidade.</td>
    <td>1 m</td>
    </tr>
    <tr>
    <td>Parâmetro ` skipNodes.withLocalStorage `</td>
    <td>Quando configurado como `true`, os nós do trabalhador que têm pods que estão salvando dados no armazenamento local não têm sua capacidade diminuída.</td>
    <td>true</td>
    </tr>
    <tr>
    <td>Parâmetro ` skipNodes.withSystemPods `</td>
    <td>Quando configurado como `true`, os nós do trabalhador que têm os pods `kube-system` não têm sua capacidade diminuída. Não configure o valor como `false` porque diminuir a capacidade de pods `kube-system` pode ter resultados inesperados.</td>
    <td>true</td>
    </tr>
    </tbody>
    </table>
2.  Para mudar qualquer um dos valores de configuração do escalador automático de cluster, atualize o gráfico do Helm com os novos valores.
    ```
    helm upgrade --set scanInterval=2m ibm-iks-cluster-autoscaler ibm/ibm-iks-cluster-autoscaler -i
    ```
    {: pre}

    Para reconfigurar o gráfico para os valores padrão:
    ```
    upgrade do leme -- reset-values ibm-iks-cluster-autoscaler ibm/ibm-iks-cluster-autoscaler
    ```
    {: pre}
3.  Para verificar suas mudanças, revise os valores do gráfico do Helm novamente.
    ```
    helm get values ibm-iks-cluster-autoscaler -a
    ```
    {: pre}

## Limitando apps a serem executados em apenas determinados conjuntos de trabalhadores escalados automaticamente
{: #ca_limit_pool}

Para limitar uma implementação de pod para um conjunto de trabalhadores específico que é gerenciado pelo escalador automático de cluster, use rótulos e `nodeSelector`.
{: shortdesc}

** Antes de iniciar **:
*  [ Instale o plug-in  ` ibm-iks-cluster-cluster-autoscaler `  ](#ca_helm).
*  [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

**Para limitar os pods a serem executados em determinados conjuntos de trabalhadores escalados automaticamente**:

1.  Crie o conjunto de trabalhadores com o rótulo que você deseja usar.
    ```
    ibmcloud ks-pool-create -- name < name>-- cluster < cluster_name_or_ID>-- machine-type < machine_type>--size-per-zone < number_of_worker_nodes>-- etiquetas < key>= < value>
    ```
    {: pre}
2.  [Inclua o conjunto de trabalhadores na configuração do escalador automático de cluster](#ca_cm).
3.  Em seu modelo de especificação de pod, corresponda o `nodeSelector` ao rótulo que você usou em seu conjunto de trabalhadores.
    ```
    ...
    spec:
          containers:
      - name: nginx
        image: nginx
        imagePullPolicy: IfNotPresent
      nodeSelector:
        app: nginx
    ...
    ```
    {: codeblock}
4.  Implemente o pod. Por causa do rótulo correspondente, o pod é planejado em um nó do trabalhador que está no conjunto de trabalhadores rotulados.
    ```
    kubectl aplicar -f pod.yaml
    ```
    {: pre}

<br />


## Aumentando a capacidade dos nós do trabalhador antes que o conjunto de trabalhadores tenha recursos insuficientes
{: #ca_scaleup}

Conforme descrito no tópico [Entendendo como funciona o escalador automático de cluster](#ca_about) e as [Perguntas mais frequentes do escalador automático de cluster do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md), o escalador automático de cluster aumentará a capacidade de seus conjuntos de trabalhadores em resposta aos recursos solicitados de sua carga de trabalho com relação aos recursos disponíveis do conjunto de trabalhadores. No entanto, você pode desejar que o escalador automático de cluster aumente a capacidade dos nós do trabalhador antes que o conjunto de trabalhadores fique sem recursos. Nesse caso, sua carga de trabalho não precisa esperar o fornecimento dos nós do trabalhador porque a capacidade do conjunto de trabalhadores já foi aumentada para atender às solicitações de recurso.
{: shortdesc}

O escalador automático de cluster não suporta ajuste de escala antecipado (fornecimento extra) de conjuntos de trabalhadores. No entanto, é possível configurar outros recursos do Kubernetes para trabalhar com o escalador automático de cluster para atingir o ajuste de escala antecipado.

<dl>
  <dt><strong> Pausar pods </strong></dt>
  <dd>É possível criar uma implementação que implementa [contêineres de pausa ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://stackoverflow.com/questions/48651269/what-are-the-pause-containers) em pods com solicitações de recurso específicas e designar à implementação uma prioridade baixa de pod. Quando esses recursos são necessários por cargas de trabalho de prioridade mais alta, o pod de pausa é priorizado e torna-se um pod pendente. Esse evento aciona o autoscaler de cluster para aumentar a escala.<br><br>Para obter mais informações sobre como configurar uma implementação de pod de pausa, consulte a [FAQ do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#how-can-i-configure-overprovisioning-with-cluster-autoscaler).<p class="note">Se você usar esse método, certifique-se de entender como a [prioridade do pod](/docs/containers?topic=containers-pod_priority#pod_priority) funciona e defina a prioridade do pod para suas implementações. Por exemplo, se o pod de pausa não tiver recursos suficientes para um pod de prioridade mais alta, o pod não será priorizado. A carga de trabalho de prioridade mais alta permanece pendente, portanto, o escalador automático de cluster é acionado para aumentar a capacidade. No entanto, nesse caso, a ação de ajuste de escala não é antecipada porque a carga de trabalho real com a qual você se importa não está planejada, mas o pod de pausa sim.</p></dd>

  <dt><strong>HPA (Horizontal pod autoscaling)</strong></dt>
  <dd>Como o ajuste de escala automático de pod horizontal é baseado no uso médio de CPU dos pods, o limite de uso da CPU que você configura é atingido antes que o conjunto de trabalhadores realmente fique sem recursos. Mais pods são solicitados, o que aciona o escalador automático de cluster para aumentar a capacidade do conjunto de trabalhadores.<br><br>Para obter mais informações sobre a configuração do HPA, consulte os [docs do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/).</dd>
</dl>

<br />


## Atualizando o Gráfico Helm do Autoscaler do Cluster
{: #ca_helm_up}

É possível atualizar o gráfico do Helm do escalador automático de cluster existente para a versão mais recente. Para verificar sua versão do gráfico do Helm atual, execute `helm ls | grep cluster-autoscaler`.
{: shortdesc}

Atualizando para o gráfico do Helm mais recente da versão 1.0.2 ou anterior? [ Siga estas instruções ](#ca_helm_up_102).
{: note}

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Atualize o repositório Helm para recuperar a versão mais recente de todos os gráficos Helm nesse repositório.
    ```
    helm repo update
    ```
    {: pre}

2.  Opcional: faça download do gráfico Helm mais recente em sua máquina local. Em seguida, extraia o pacote e revise o arquivo `release.md` para localizar as informações de liberação mais recentes.
    ```
    helm fetch ibm/ibm-iks-cluster-autoscaler
    ```
    {: pre}

3.  Localize o nome do gráfico do Helm do autocalador de cluster que você instalou em seu cluster.
    ```
    helm ls | grep cluster-autoscaler
    ```
    {: pre}

    Saída de exemplo:
    ```
    myhelmchart 	1       	Mon Jan  7 14:47:44 2019	DEPLOYED	ibm-ks-cluster-autoscaler-1.0.0  	kube-system
    ```
    {: screen}

4.  Atualize o gráfico do Helm do autocalador de cluster para a versão mais recente.
    ```
    upgrade do leme -- force -- recreate-pods < helm_chart_name>ibm/ibm-iks-cluster-autoscaler
    ```
    {: pre}

5.  Verifique se a seção [configmap do escalador automático de cluster](#ca_cm) `workerPoolsConfig.json` está configurada como `"enabled": true` para os conjuntos de trabalhadores que você deseja escalar.
    ```
    kubectl describe cm iks-ca-configmap -n kube-system
    ```
    {: pre}

    Saída de exemplo:
    ```
    Nome: iks-ca-configmap
    Namespace: kube-system
    Rótulos: < none>
    Anotações: kubectl.kubernetes.io/last-appliation={"apiVersion" :"v1" ,"data" :{"workerPoolsConfig.json" :"[\n { \" nome \": \" docs \": 1, \" maxSize \": 3, \" enabled \" :true } \n "}, "kind": "ConfigMap": "ConfigMap": "

    Data
    ====
    workerPoolsConfig.json:
    ----
    [
     {1}, "maxSize": 3, "enabled" :true }
    ]

    Events:  <none>
    ```
    {: screen}

### Atualizando para o gráfico do Helm mais recente da versão 1.0.2 ou anterior
{: #ca_helm_up_102}

A versão mais recente do gráfico do Helm do escalador automático de cluster requer uma remoção completa de versões do gráfico do Helm do escalador automático de cluster instaladas anteriormente. Se você instalou o gráfico do Helm versão 1.0.2 ou anterior, desinstale essa versão primeiro antes de instalar o gráfico do Helm mais recente do escalador automático de cluster.
{: shortdesc}

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Obtenha o configmap do autoscaler do cluster.
    ```
    kubectl get cm iks-ca-configmap -n kube-system -o yaml > iks-ca-configmap.yaml
    ```
    {: pre}
2.  Remova todos os conjuntos de trabalhadores do configmap configurando o valor `"enabled"` como `false`.
    ```
    kubectl edit cm iks-ca-configmap -n kube-system
    ```
    {: pre}
3.  Se você aplicou configurações customizadas ao gráfico do Helm, anote suas configurações customizadas.
    ```
    helm get values ibm-ks-cluster-autoscaler -a
    ```
    {: pre}
4.  Desinstale seu gráfico de Helm atual.
    ```
    helm delete -- purge ibm-ks-cluster-autoscaler
    ```
    {: pre}
5.  Atualize o repositório do gráfico do Helm para obter a versão mais recente do gráfico do Helm do escalador automático de cluster.
    ```
    helm repo update
    ```
    {: pre}
6.  Instale o gráfico do Helm do escalador automático de cluster mais recente. Aplique quaisquer configurações customizadas que você usou anteriormente com o sinalizador `--set`, como `scanInterval=2m`.
    ```
    helm install  ibm/ibm-iks-cluster-autoscaler --namespace kube-system --name ibm-iks-cluster-autoscaler [--set <custom_settings>]
    ```
    {: pre}
7.  Aplique o configmap do escalador automático de cluster que você recuperou anteriormente para ativar a escala automática para os seus conjuntos de trabalhadores.
    ```
    kubectl aplicar -f iks-ca-configmap.yaml
    ```
    {: pre}
8.  Obtenha seu pod do autoescalador do cluster.
    ```
    kubectl get pods -n kube-system
    ```
    {: pre}
9.  Revise a seção **`Events`** do pod do escalador automático de cluster e procure um evento **`ConfigUpdated`** para verificar se o configmap foi atualizado com êxito. A mensagem de evento para seu configmap está no formato a seguir: `minSize:maxSize:PoolName:<SUCCESS|FAILED>:error message `.
    ```
    kubectl describe pod -n kube-system <cluster_autoscaler_pod>
    ```
    {: pre}

    Saída de exemplo:
    ```
		Name: ibm-iks-cluster-autoscaler-857c4d9d54-gwvc6 		Namespace: kube-system 		...
		Events:
    Type    Reason                 Age   From                     Message
		----     ------         ----  ----                                        -------

		Normal ConfigUpdated 3m ibm-iks-cluster-autoscaler-857c4d9d54-gwvc6 {"1:3:default":"SUCCESS:"}
    ```
    {: screen}

<br />


## Removendo o Autoscaler do Cluster
{: #ca_rm}

Se você não desejar escalar automaticamente seus conjuntos de trabalhadores, será possível desinstalar o gráfico do Helm do escalador automático de cluster. Após a remoção, você deverá [redimensionar](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) ou [rebalancear](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) seus conjuntos de trabalhadores manualmente.
{: shortdesc}

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  No [configmap do escalador automático de cluster](#ca_cm), remova o conjunto de trabalhadores, configurando o valor `"enabled"` como `false`.
    ```
    kubectl edit cm iks-ca-configmap -n kube-system
    ```
    {: pre}
    Saída de exemplo:
    ```
    apiVersion: v1 data: workerPoolsConfig.json: | [
         {"name": "default","minSize": 1,"maxSize": 2,"enabled":false},
         {"name":"mypool","minSize":1,"maxSize":5,"enabled":false}
        ]
    kind: ConfigMap...
    ```
2.  Liste os gráficos do Helm existentes e anote o nome do escalador automático de cluster.
    ```
    helm ls
    ```
    {: pre}
3.  Remover o gráfico do Helm existente de seu cluster.
    ```
    helm delete --purge <ibm-iks-cluster-autoscaler_name>
    ```
    {: pre}
