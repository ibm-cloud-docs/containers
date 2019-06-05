---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-26"

keywords: kubernetes, iks 

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



# Restringindo o tráfego de rede para os nós do trabalhador de borda
{: #edge}

Os nós do trabalhador de borda podem melhorar a segurança de seu cluster do Kubernetes, permitindo que menos nós do trabalhador sejam acessados externamente e isolando a carga de trabalho de rede no {{site.data.keyword.containerlong}}.
{:shortdesc}

Quando esses nós do trabalhador são marcados somente para rede, outras cargas de trabalho não podem consumir a CPU ou memória do nó do trabalhador e interferir na rede.

Se você tiver um cluster de múltiplas zonas e desejar restringir o tráfego de rede para os nós do trabalhador de borda, pelo menos 2 nós do trabalhador de borda deverão ser ativados em cada zona para alta disponibilidade de balanceador de carga ou pods do Ingress. Crie um conjunto de trabalhadores do nó de borda que abrange todas as zonas em seu cluster, com pelo menos 2 nós do trabalhador por zona.
{: tip}

## Identificação de nós do trabalhador como nós de borda
{: #edge_nodes}

Inclua o rótulo `dedicated=edge` em dois ou mais nós do trabalhador em cada VLAN pública em seu cluster para assegurar que o Ingresso e os balanceadores de carga sejam implementados somente nesses nós do trabalhador.
{:shortdesc}

Antes de iniciar:

1. Assegure-se de que você tenha as [funções do {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) a seguir:
  * Qualquer função da plataforma para o cluster
  * Função de serviço **Gravador** ou **Gerenciador** para todos os namespaces
2. [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
3. Assegure-se de que seu cluster tem pelo menos uma VLAN pública. Os nós do trabalhador de borda não estão disponíveis para clusters somente com VLANs privadas.
4. [Crie um novo conjunto de trabalhadores](/docs/containers?topic=containers-clusters#add_pool) que abranja toda a zona em seu cluster e tenha pelo menos 2 trabalhadores por zona.

Para rotular nós do trabalhador como nós de borda:

1. Liste os nós do trabalhador em seu conjunto de trabalhadores do nó de borda. Use o endereço **IP privado** para identificar os nós.

  ```
  ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <edge_pool_name>
  ```
  {: pre}

2. Rotule os nós do trabalhador com `dedicated=edge`. Após um nó do trabalhador ser marcado com `dedicated=edge`, todo Ingresso subsequente e balanceadores de carga são implementados em um nó do trabalhador de borda.

  ```
  kubectl label nodes <node1_IP> <node2_IP> dedicated=edge
  ```
  {: pre}

3. Recupere todos os balanceadores de carga existentes e os balanceadores de carga do aplicativo (ALBs) do Ingress no cluster.

  ```
  kubectl get services -- all-namespaces
  ```
  {: pre}

  Na saída, procure serviços que tenham o **Tipo** de **LoadBalancer**. Anote o **Namespace** e o **Nome** de cada serviço de balanceador de carga. Por exemplo, na saída a seguir, há 3 serviços de balanceador de carga: o balanceador de carga `webserver-lb` no namespace `default` e os ALBs do Ingress `public-crdf253b6025d64944ab99ed63bb4567b6-alb1` e `public-crdf253b6025d64944ab99ed63bb4567b6-alb2` no namespace `kube-system`.

  ```
  NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
  default       kubernetes                                       ClusterIP      172.21.0.1       <none>          443/TCP                      1h
  default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                 10m
  kube-system   heapster                                         ClusterIP      172.21.101.189   <none>          80/TCP                       1h
  kube-system   kube-dns                                         ClusterIP      172.21.0.10      <none>          53/UDP,53/TCP                1h
  kube-system   kubernetes-dashboard                             ClusterIP      172.21.153.239   <none>          443/TCP                      1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.48.228.78   80:30286/TCP,443:31363/TCP   1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb2   LoadBalancer   172.21.229.73    169.46.17.6     80:31104/TCP,443:31138/TCP   57m
  ```
  {: screen}

4. Usando o resultado da etapa anterior, execute o comando a seguir para cada balanceador de carga e ALB do Ingress. Esse comando reimplementa o balanceador de carga ou o ALB do Ingress para um nó do trabalhador de borda. Somente balanceadores de carga públicos ou ALBs devem ser reimplementados.

  ```
  kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
  ```
  {: pre}

  Saída de exemplo:

  ```
  Serviço "my_loadbalancer" configurado
  ```
  {: screen}

Você rotulou os nós do trabalhador com `dedicated=edge` e reimplementou todos os balanceadores de carga existentes e o Ingresso nos nós do trabalhador de borda. Em seguida, evite que outras [cargas de trabalho sejam executadas em nós do trabalhador de borda](#edge_workloads) e [bloqueiem o tráfego de entrada para NodePorts em nós do trabalhador](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Evitando que cargas de trabalho sejam executadas em nós do trabalhador de borda
{: #edge_workloads}

Um benefício de nós do trabalhador de borda é que eles podem ser especificados para executar somente serviços de rede.
{:shortdesc}

Usar a tolerância `dedicated=edge` significa que todos os serviços de balanceador de carga e de Ingresso são implementados somente nos nós do trabalhador rotulados. No entanto, para evitar que outras cargas de trabalho sejam executadas em nós do trabalhador de borda e consumam recursos do nó do trabalhador, deve-se usar [contaminações do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/).

Antes de iniciar:
- Assegure-se de que você tenha a [função de **Gerenciador** do serviço {{site.data.keyword.Bluemix_notm}} IAM para todos os namespaces](/docs/containers?topic=containers-users#platform).
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Para evitar que outras cargas de trabalho sejam executadas em nós do trabalhador de borda:

1. Liste todos os nós do trabalhador com o rótulo `dedicated=edge`.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Aplique uma contaminação a cada nó do trabalhador que evita que os pods sejam executados no nó do trabalhador e que remove os pods que não têm o rótulo `dedicated=edge` do nó do trabalhador. Os pods removidos são reimplementados em outros nós do trabalhador com capacidade.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```
  {: pre}
  Agora, somente pods com a tolerância `dedicated=edge` são implementados em nós do trabalhador de borda.

3. Se você optar por [ativar a preservação do IP de origem para um serviço de balanceador de carga 1.0![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assegure-se de que os pods do app sejam planejados para os nós do trabalhador de borda [incluindo a afinidade do nó de borda nos pods do app](/docs/containers?topic=containers-loadbalancer#lb_edge_nodes). Os pods do app devem ser planejados nos nós de borda para obter solicitações recebidas.

4. Para remover uma contaminação, execute o comando a seguir.
    ```
    kubectl taint node < node_name> dedicado: NoSchedule- dedicado: NoExecute-
    ```
    {: pre}
