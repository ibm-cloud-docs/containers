---

copyright: years: 2014, 2017 lastupdated: "2017-12-18"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# As versões do Kubernetes para {{site.data.keyword.containerlong_notm}}
{: #cs_versions}

Revise as versões do Kubernetes que estão disponíveis no {{site.data.keyword.containerlong}}.
{:shortdesc}

O {{site.data.keyword.containershort_notm}} suporta várias versões do Kubernetes. A versão padrão é usada quando você cria ou atualiza um cluster, a menos que especifique uma versão diferente. As versões disponíveis do Kubernetes são:
- 1.8.4
- 1.7.4 (versão padrão)
- 1.5.6

As informações a seguir resumem as atualizações que provavelmente têm impacto em apps implementados ao atualizar um cluster para uma nova versão. Revise o [log de mudanças do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Icone de link externo")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) para uma lista completa de mudanças nas versões do Kubernetes.

Para obter mais informações sobre o processo de atualização, consulte [Atualizando clusters](cs_cluster.html#cs_cluster_update) e [Atualizando nós do trabalhador](cs_cluster.html#cs_cluster_worker_update).

## Tipos de atualização
{: #version_types}

O Kubernetes fornece estes tipos de atualização de versão:
{:shortdesc}

|Tipo de atualização|Exemplos de rótulos de versão|Atualizado por|Impacto
|-----|-----|-----|-----|
|Principal|1.x.x|Você|Mudanças de operação para clusters, incluindo scripts ou implementações.|
|Menor|x.5.x|Você|Mudanças de operação para clusters, incluindo scripts ou implementações.|
|Correção|x.x.3|IBM e você|Sem mudanças nos scripts ou implementações. A IBM atualiza os mestres automaticamente, mas você aplica correções a nós do trabalhador.|
{: caption="Impactos de atualizações do Kubernetes" caption-side="top"}

Por padrão, não será possível atualizar um mestre do Kubernetes mais de duas versões secundárias à frente. Por exemplo, se o seu mestre atual for versão 1.5 e você desejar atualizar para 1.8, deve-se atualizar para 1.7 primeiro. É possível forçar a atualização para continuar, mas atualizar mais de duas versões secundárias poderá causar resultados inesperados.

## Versão 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" height="100" width="62.5" align="left" alt="Esse badge indica a certification do Kubernetes versão 1.8 para o IBM Cloud Container Service."/> O {{site.data.keyword.containerlong_notm}} é um produto Kubernetes certificado para a versão 1.8 no programa CNCF Kubernetes Software Conformance Certification. _Kubernetes® é uma marca registrada do The Linux Foundation nos Estados Unidos e em outros países e é usada nos termos de uma licença do Linux Foundation._</p>

Revise as mudanças que você pode precisar fazer ao atualizar para o Kubernetes versão 1.8.

<br/>

### Atualizar antes do mestre
{: #18_before}

<table summary="Atualizações do Kubernetes para versões 1.8">
<caption>Mudanças para fazer antes de atualizar o mestre para o Kubernetes 1.8</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrição
</tr>
</thead>
<tbody>
<tr>
<td colspan='2'>Nenhuma mudança necessária antes de atualizar o mestre</td>
</tr>
</tbody>
</table>

### Atualizar depois do mestre
{: #18_after}

<table summary="Atualizações do Kubernetes para versões 1.8">
<caption>Mudanças para fazer depois de atualizar o mestre para o Kubernetes 1.8</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrição
</tr>
</thead>
<tbody>
<tr>
<td>Login do painel do Kubernetes</td>
<td>A URL para acessar o painel do Kubernetes na versão 1.8 mudou e o processo de login inclui uma nova etapa de autenticação. Veja [Acessando o painel do Kubernetes](cs_apps.html#cs_cli_dashboard) para obter mais informações.</td>
</tr>
<tr>
<tr>
<td>Permissões de painel do Kubernetes</td>
<td>Para forçar os usuários a efetuar login com suas credenciais para visualizar recursos de cluster na versão 1.8, remova a autorização RBAC do ClusterRoleBinding 1.7. Execute `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>O comando `kubectl delete` não reduz mais os objetos da API de carga de trabalho, como pods, antes de o objeto ser excluído. Se você requerer que o objeto seja reduzido, use o comando kubectl scale![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale) antes de excluir o objeto.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>O comando `kubectl run` deve usar múltiplas sinalizações para `--env` em vez de argumentos separados por vírgula. Por exemplo, execute <code>kubectl run --env <x>=<y> --env <z>=&lt;a&gt;</code> e não <code>kubectl run --env <x>=<y>,<z>=&lt;a&gt;</code>. </td>
</tr>
<td>`kubectl stop`</td>
<td>O comando `kubectl stop` não está mais disponível.</td>
</tr>
</tbody>
</table>


## Versão 1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" height="100" width="62.5" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" align="left" alt="Esse badge indica a certificação do Kubernetes versão 1.7 para o IBM Cloud Container Service."/> O {{site.data.keyword.containerlong_notm}} é um produto Certified Kubernetes para a versão 1.7 no programa CNCF Kubernetes Software Conformance Certification.</p>

Revise as mudanças que você pode precisar fazer ao atualizar para o Kubernetes versão 1.7.

<br/>

### Atualizar antes do mestre
{: #17_before}

<table summary="Atualizações do Kubernetes para as versões 1.7 e 1.6">
<caption>Mudanças para fazer antes de atualizar o mestre para o Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrição
</tr>
</thead>
<tbody>
<tr>
<td>Armazenamento</td>
<td>Os scripts de configuração com `hostPath` e `mountPath` com o referência de diretório-pai como `../to/dir` não são permitidos. Mude os caminhos para caminhos absolutos simples, por exemplo, `/path/to/dir`.
<ol>
  <li>Determine se você precisa mudar os caminhos de armazenamento:</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Se `Ação necessária` é retornado, mude o pods para referenciar o caminho absoluto antes de atualizar todos os nós do trabalhador. Se o pod é de propriedade de outro recurso, como uma implementação, mude o [_PodSpec_ ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) dentro desse recurso.
</ol>
</td>
</tr>
</tbody>
</table>

### Atualizar depois do mestre
{: #17_after}

<table summary="Atualizações do Kubernetes para as versões 1.7 e 1.6">
<caption>Mudanças para fazer depois de atualizar o mestre para o Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrição
</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>Após a atualização da CLI `kubectl`, estes comandos `kubectl create` devem usar múltiplas sinalizações em vez de argumentos separados por vírgula:<ul>
 <li>`Função`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  Por exemplo, execute `kubectl create role --resource-name <x> --resource-name <y>` e não `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Planejamento de afinidade de Pod</td>
<td> A anotação `scheduler.alpha.kubernetes.io/affinity` está descontinuada.
<ol>
  <li>Para cada namespace, exceto `ibm-system` e `kube-system`, determine se você precisa atualizar o planejamento de afinidade de pod:</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>Se `"Action required"` for retornado, use o campo [_PodSpec_ ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ em vez da anotação `scheduler.alpha.kubernetes.io/affinity`.
</ol>
</tr>
<tr>
<td>Network Policy</td>
<td>A anotação `net.beta.kubernetes.io/network-policy` não está mais disponível.
<ol>
  <li>Determine se você precisa mudar as políticas:</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Se `"Action required"` for retornado, inclua a política de rede a seguir em cada namespace do Kubernetes que foi listado:</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namespace&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
  metadados:
    name: default-deny
    namespace: &lt;namespace&gt;
  spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> Depois de incluir a política de rede, remova a anotação `net.beta.kubernetes.io/network-policy`:
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>Tolerations</td>
<td>A anotação `scheduler.alpha.kubernetes.io/tolerations` não está mais disponível.
<ol>
  <li>Para cada namespace, exceto `ibm-system` e `kube-system`, determine se é necessário mudar as tolerâncias:</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Se `"Action required"` for retornado, use o campo [_PodSpec_ ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _tolerations_ em vez da anotação `scheduler.alpha.kubernetes.io/tolerations`
</ol>
</tr>
<tr>
<td>Taints</td>
<td>A anotação `scheduler.alpha.kubernetes.io/taints` não está mais disponível.
<ol>
  <li>Determine se você precisa mudar as contaminações:</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Se `"Action required"` é retornado, remova a anotação `scheduler.alpha.kubernetes.io/taints` para cada nó:</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Inclua uma contaminação em cada nó:</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
<tr>
<td>DNS do pod StatefulSet</td>
<td>Os pods StatefulSet perdem suas entradas DNS do Kubernetes depois de atualizar o mestre. Para restaurar as entradas DNS, exclua os pods StatefulSet. O Kubernetes recria os pods e restaura automaticamente as entradas DNS. Para obter mais informações, veja [Problema do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/issues/48327).
</tr>
</tbody>
</table>
