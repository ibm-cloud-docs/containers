---

copyright: years: 2014, 2017 lastupdated: "2017-10-24"

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

A tabela contém atualizações que provavelmente têm impacto em apps implementados ao atualizar um cluster para uma nova versão. Revise o [log de mudanças do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Icone de link externo")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) para uma lista completa de mudanças nas versões do Kubernetes.

Para obter mais informações sobre o processo de atualização, consulte [Atualizando clusters](cs_cluster.html#cs_cluster_update) e [Atualizando nós do trabalhador](cs_cluster.html#cs_cluster_worker_update).



## Versão 1.7
{: #cs_v17}

### Atualizar antes do mestre
{: #17_before}

<table summary="Atualizações do Kubernetes para as versões 1.7 e 1.6">
<caption>Tabela 1. Mudanças para fazer antes de atualizar o mestre para o Kubernetes 1.7</caption>
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
  <li>Execute este comando para determinar se você precisa atualizar seu caminhos de armazenamento.</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Se `Action required` for retornado, modifique cada pod impactado para referenciar o caminho absoluto antes de atualizar todos os nós do trabalhador. Se o pod for de propriedade de outro recurso, como uma implementação, modifique o [_PodSpec_ ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) dentro desse recurso.
</ol>
</td>
</tr>
</tbody>
</table>

### Atualizar depois do mestre
{: #17_after}

<table summary="Atualizações do Kubernetes para as versões 1.7 e 1.6">
<caption>Tabela 2. Mudanças feitas após a atualização do mestre para o Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrição
</tr>
</thead>
<tbod>
<tr>
<td>kubectl</td>
<td>Depois de atualizar a CLI `kubectl` para a versão do seu cluster, esses comandos `kubectl` deverão usar diversas sinalizações em vez de argumentos separados por vírgula. <ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  Por exemplo, execute `kubectl create role --resource-name <x> --resource-name <y>` e não `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Planejamento de afinidade de Pod</td>
<td> A anotação `scheduler.alpha.kubernetes.io/affinity` está descontinuada.
<ol>
  <li>Execute esse comando para cada namespace, exceto `ibm-system` e `kube-system` para determinar se é preciso atualizar o planejamento de afinidade de pod.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>Se `"Action required"` for retornado, modifique os pods impactados para usar o campo _afinidade_ de [_PodSpec_ ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) em vez da anotação `scheduler.alpha.kubernetes.io/affinity`.
</ol>
</tr>
<tr>
<td>Network Policy</td>
<td>A anotação `net.beta.kubernetes.io/network-policy` não é mais suportada.
<ol>
  <li>Execute esse comando para determinar se você precisa atualizar suas políticas de rede.</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Se `Action required` for retornado, inclua a política de rede a seguir em cada namespace do Kubernetes que foi listado.</br>

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

  <li> Com a política de rede no local, remova a anotação `net.beta.kubernetes.io/network-policy`.
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>Tolerations</td>
<td>A anotação `scheduler.alpha.kubernetes.io/tolerations` não é mais suportada.
<ol>
  <li>Execute esse comando para cada namespace, exceto para `ibm-system` e `kube-system` para determinar se é preciso atualizar tolerations.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Se `"Action required"` for retornado, modifique os pods impactados para usar o campo _tolerations_ de [_PodSpec_ ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) em vez da anotação `scheduler.alpha.kubernetes.io/tolerations`.
</ol>
</tr>
<tr>
<td>Taints</td>
<td>A anotação `scheduler.alpha.kubernetes.io/taints` não é mais suportada.
<ol>
  <li>Execute esse comando para determinar se você precisa atualizar taints. </br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Se `"Action required"` for retornado, remova a anotação `scheduler.alpha.kubernetes.io/taints` para cada nó que possui a anotação não suportada.</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Quando a anotação não suportada é removida, inclua um taint em cada nó. Deve-se ter o `kubectl` CLI versão 1.6 ou mais recente.</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
