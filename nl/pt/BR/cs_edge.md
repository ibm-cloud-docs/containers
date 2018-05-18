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

# Restringindo o tráfego de rede para os nós do trabalhador de borda
{: #edge}

Os nós do trabalhador de borda podem melhorar a segurança de seu cluster do Kubernetes, permitindo que menos nós do trabalhador sejam acessados externamente e isolando a carga de trabalho de rede no {{site.data.keyword.containerlong}}.
{:shortdesc}

Quando esses nós do trabalhador são marcados somente para rede, outras cargas de trabalho não podem consumir a CPU ou memória do nó do trabalhador e interferir na rede.




## Rotular nós do trabalhador como nós da borda
{: #edge_nodes}

Inclua o rótulo `dedicated=edge` em dois ou mais nós do trabalhador em cada VLAN pública em seu cluster para assegurar que o Ingresso e os balanceadores de carga sejam implementados somente nesses nós do trabalhador.
{:shortdesc}

Antes de iniciar:

- [Crie um cluster padrão.](cs_clusters.html#clusters_cli)
- Assegure-se de que seu cluster tem pelo menos uma VLAN pública. Os nós do trabalhador de borda não estão disponíveis para clusters somente com VLANs privadas.
- [Destine a CLI do Kubernetes para o cluster](cs_cli_install.html#cs_cli_configure).

Etapas:

1. Liste todos os nós do trabalhador no cluster. Use o endereço IP privado da coluna **NAME** para identificar os nós. Selecione pelo menos dois nós do trabalhador em cada VLAN pública para serem os nós do trabalhador de borda. Usar dois ou mais nós do trabalhador melhora a disponibilidade dos recursos de rede.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated
  ```
  {: pre}

2. Rotule os nós do trabalhador com `dedicated=edge`. Após um nó do trabalhador ser marcado com `dedicated=edge`, todo Ingresso subsequente e balanceadores de carga são implementados em um nó do trabalhador de borda.

  ```
  kubectl label nodes <node_name> <node_name2> dedicated=edge
  ```
  {: pre}

3. Recupere todos os serviços existentes do balanceador de carga em seu cluster.

  ```
  kubectl get services --all-namespaces -o jsonpath='{range .items[*]}kubectl get service -n {.metadata.namespace} {.metadata.name} -o yaml | kubectl apply -f - :{.spec.type},{end}' | tr "," "\n" | grep "LoadBalancer" | cut -d':' -f1
  ```
  {: pre}

  Saída:

  ```
  kubectl get service -n <namespace> <name> -o yaml | kubectl apply -f
  ```
  {: screen}

4. Usando a saída da etapa anterior, copie e cole cada linha `kubectl get service`. Esse comando reimplementa o balanceador de carga para um nó do trabalhador de borda. somente balanceadores de carga públicos precisam ser reimplementados.

  Saída:

  ```
  service "<name>" configured
  ```
  {: screen}

Você rotulou os nós do trabalhador com `dedicated=edge` e reimplementou todos os balanceadores de carga existentes e o Ingresso para os nós do trabalhador de borda. Em seguida, evite que outras [cargas de trabalho sejam executadas em nós do trabalhador de ponta](#edge_workloads) e [bloqueiem o tráfego de entrada para as portas de nós em nós do trabalhador](cs_network_policy.html#block_ingress).

<br />


## Evitar que cargas de trabalho sejam executadas em nós do trabalhador de borda
{: #edge_workloads}

Um benefício de nós do trabalhador de borda é que eles podem ser especificados para executar somente serviços de rede.
{:shortdesc} 

Usar a tolerância `dedicated=edge` significa que todos os serviços de balanceador de carga e de Ingresso são implementados somente nos nós do trabalhador rotulados. No entanto, para evitar que outras cargas de trabalho sejam executadas em nós do trabalhador de borda e consumam recursos do nó do trabalhador, deve-se usar [contaminações do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/).


1. Liste todos os nós do trabalhador com o rótulo `edge`.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Aplique uma contaminação a cada nó do trabalhador que evita que os pods sejam executados no nó do trabalhador e que remove os pods que não possuem o rótulo `edge` do nó do trabalhador. Os pods removidos são reimplementados em outros nós do trabalhador com capacidade.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```

Agora, somente pods com a tolerância `dedicated=edge` são implementados em nós do trabalhador de borda.
