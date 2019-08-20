---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb

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
{:preview: .preview}



# Sobre os NLBs
{: #loadbalancer-about}

Ao criar um cluster padrão, o {{site.data.keyword.containerlong}} provisiona automaticamente uma sub-rede pública móvel e uma sub-rede privada móvel.
{: shortdesc}

* A sub-rede pública móvel fornece cinco endereços IP utilizáveis. Um endereço IP público móvel é usado pelo [ALB do Ingress público](/docs/containers?topic=containers-ingress) padrão. Os 4 endereços IP públicos móveis restantes podem ser usados para expor aplicativos únicos à Internet, criando serviços de balanceador de carga de rede pública ou NLBs.
* A sub-rede privada móvel fornece cinco endereços IP utilizáveis. Um endereço IP privado móvel é usado pelo [ALB do Ingress privado](/docs/containers?topic=containers-ingress#private_ingress) padrão. Os 4 endereços IP privados móveis restantes podem ser usados para expor aplicativos únicos a uma rede privada, criando serviços de balanceador de carga privado ou NLBs.

Os endereços IP públicos e privados móveis são IPs flutuantes estáticos e não mudam quando um nó do trabalhador é removido. Se o nó do trabalhador no qual o endereço IP do NLB está for removido, um daemon Keepalived que monitora constantemente o IP o moverá automaticamente para outro nó do trabalhador. É possível designar qualquer porta para seu NLB. O NLB atua como o ponto de entrada externo para solicitações recebidas para o aplicativo. Para acessar o NLB por meio da Internet, é possível usar o endereço IP público de seu NLB e a porta designada no formato `<IP_address>:<port>`. Também é possível criar entradas DNS para NLBs registrando os endereços IP do NLB com nomes de host.

Quando você expõe um aplicativo com um serviço NLB, ele é disponibilizado automaticamente por meio do NodePorts do serviço também. Os [NodePorts](/docs/containers?topic=containers-nodeport) são acessíveis em cada endereço IP público e privado de cada nó do trabalhador dentro do cluster. Para bloquear o tráfego para NodePorts enquanto estiver usando um NLB, consulte [Controlando o tráfego de entrada para o balanceador de carga de rede (NLB) ou os serviços NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Comparação do balanceamento de carga básico e DSR nos NLBs da versão 1.0 e 2.0
{: #comparison}

Quando você cria um NLB, é possível escolher um NLB da versão 1.0, que executa o balanceamento de carga básico, ou um NLB da versão 2.0, que executa o balanceamento de carga do direct server return (DSR). Observe que os NLBs da versão 2.0 estão em beta.
{: shortdesc}

**Como os NLBs versões 1.0 e 2.0 são semelhantes?**

Os NLBs versão 1.0 e 2.0 são balanceadores de carga de Camada 4 que existem no espaço kernel do Linux. Ambas as versões são executadas dentro do cluster e usam os recursos do nó do trabalhador. Portanto, a capacidade disponível dos NLBs é sempre dedicada a seu próprio cluster. Além disso, ambas as versões de NLBs não finalizam a conexão. Em vez disso, eles encaminham conexões para um pod de app.

**Como os NLBs versões 1.0 e 2.0 são diferentes?**

Quando um cliente envia uma solicitação ao seu aplicativo, o NLB roteia pacotes de solicitações para o endereço IP do nó do trabalhador no qual um pod de aplicativo existe. Os NLBs da versão 1.0 usam a conversão de endereço de rede (NAT) para regravar o endereço IP de origem do pacote de solicitações para o IP do nó do trabalhador no qual um pod do balanceador de carga existe. Quando o nó do trabalhador retorna o pacote de resposta do aplicativo, usa esse IP do nó do trabalhador no qual o NLB existe. Em seguida, o NLB deve enviar o pacote de resposta para o cliente. Para evitar que o endereço IP seja reescrito, é possível [ativar a preservação de IP de origem](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations). No entanto, a preservação de IP de origem requer que os pods do balanceador de carga e os pods de app sejam executados no mesmo trabalhador para que a solicitação não tenha que ser encaminhada para outro trabalhador. Deve-se incluir afinidade de nó e tolerâncias nos pods do app. Para obter mais informações sobre o balanceamento de carga básico com NLBs da versão 1.0, consulte [v1.0: componentes e arquitetura do balanceamento de carga básico](#v1_planning).

Ao contrário dos NLBs da versão 1.0, os da versão 2.0 não usam o NAT ao encaminhar solicitações para os pods de aplicativo em outros trabalhadores. Quando um NLB 2.0 roteia uma solicitação do cliente, ele usa IP sobre IP (IPIP) para encapsular o pacote de solicitações original em outro pacote. Esse pacote de IPIP de encapsulamento tem um IP de origem do nó do trabalhador no qual o pod do balanceador de carga está, que permite que o pacote de solicitações original preserve o IP do cliente como seu endereço IP de origem. O nó do trabalhador então usa o retorno de retorno do servidor direto (DSR) para enviar o pacote de resposta do app para o IP do cliente. O pacote de resposta ignora o NLB e é enviado diretamente ao cliente, diminuindo a quantidade de tráfego que deve ser manipulada pelo NLB. Para obter informações adicionais sobre o balanceamento de carga do DSR com NLBs da versão 2.0, consulte [v2.0: componentes e arquitetura do balanceamento de carga do DSR](#planning_ipvs).

<br />


## Componentes e arquitetura de um NLB 1.0
{: #v1_planning}

O balanceador de carga de rede TCP/UDP (NLB) 1.0 usa os Iptables, um recurso kernel do Linux para carregar solicitações de balanceamento nos pods de um aplicativo.
{: shortdesc}

### Fluxo de tráfego em um cluster de zona única
{: #v1_single}

O diagrama a seguir mostra como um NLB 1.0 direciona a comunicação da Internet para um aplicativo em um cluster de zona única.
{: shortdesc}

<img src="images/cs_loadbalancer_planning.png" width="410" alt="Expor um aplicativo no {{site.data.keyword.containerlong_notm}} usando um NLB 1.0" style="width:410px; border-style: none"/>

1. Uma solicitação para seu aplicativo usa o endereço IP público de seu NLB e a porta designada no nó do trabalhador.

2. A solicitação é encaminhada automaticamente para o endereço IP e a porta do cluster interno do serviço NLB. O endereço IP do cluster interno é acessível somente dentro do cluster.

3. `kube-proxy` roteia para o aplicativo a solicitação para o serviço NLB.

4. A solicitação é encaminhada para o endereço IP privado do pod de app. O endereço IP de origem do pacote de solicitação é mudado para o endereço IP público do nó do trabalhador no qual o pod de app está em execução. Se diversas instâncias de aplicativo forem implementadas no cluster, o NLB roteará as solicitações entre os pods do aplicativo.

### Fluxo de tráfego em um cluster de múltiplas zonas
{: #v1_multi}

O diagrama a seguir mostra como um balanceador de carga de rede (NLB) 1.0 direciona a comunicação da Internet para um aplicativo em um cluster multizona.
{: shortdesc}

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Usar um NLB 1.0 para balancear a carga de aplicativos em clusters multizona" style="width:500px; border-style: none"/>

Por padrão, cada NLB 1.0 é configurado em apenas uma zona. Para alcançar alta disponibilidade, deve-se implementar um NLB 1.0 em cada zona na qual haja instâncias do aplicativo. As solicitações são manipuladas pelos NLBs em diversas zonas em um ciclo round-robin. Além disso, cada NLB roteia solicitações para as instâncias do aplicativo em sua própria zona e em outras zonas.

<br />


## Componentes e arquitetura de um NLB 2.0 (beta)
{: #planning_ipvs}

Os recursos do balanceador de carga de rede (NLB) 2.0 estão em beta. Para usar um NLB 2.0, deve-se [atualizar os nós principal e do trabalhador do cluster](/docs/containers?topic=containers-update) para o Kubernetes versão 1.12 ou mais recente.
{: note}

O NLB 2.0 é um balanceador de carga de Camada 4 que usa o IP Virtual Server (IPVS) do kernel do Linux. O NLB 2.0 suporta TCP e UDP, é executado na frente de diversos nós do trabalhador e usa o tunelamento IP sobre IP (IPIP) para distribuir o tráfego que chega a um único endereço IP do NLB em todos esses nós do trabalhador.

Deseja mais detalhes sobre os padrões de implementação de balanceamento de carga que estão disponíveis no {{site.data.keyword.containerlong_notm}}? Verifiqe esta [postagem do blog![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/).
{: tip}

### Fluxo de tráfego em um cluster de zona única
{: #ipvs_single}

O diagrama a seguir mostra como um NLB 2.0 direciona a comunicação da Internet para um aplicativo em um cluster de zona única.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_planning.png" width="600" alt="Expor um aplicativo no {{site.data.keyword.containerlong_notm}} usando um NLB na versão 2.0" style="width:600px; border-style: none"/>

1. Uma solicitação do cliente para seu aplicativo usa o endereço IP público de seu NLB e a porta designada no nó do trabalhador. Neste exemplo, o NLB tem um endereço IP virtual de 169.61.23.130, que está atualmente no trabalhador 10.73.14.25.

2. O NLB encapsula o pacote de solicitações do cliente (rotulado como "CR" na imagem) dentro de um pacote IPIP (rotulado como "IPIP"). O pacote de solicitação do cliente retém o IP do cliente como seu endereço IP de origem. O pacote de encapsulamento do IPIP usa o IP 10.73.14.25 IP como seu endereço IP de origem.

3. O NLB roteia o pacote IPIP para um trabalhador no qual um pod de aplicativo está, 10.73.14.26. Se diversas instâncias de aplicativo forem implementadas no cluster, o NLB roteará as solicitações entre os trabalhadores nos quais os pods do aplicativo estão implementados.

4. O trabalhador 10.73.14.26 descompacta o pacote de encapsulamento do IPIP e, em seguida, descompacta o pacote de solicitações do cliente. O pacote de solicitações do cliente é encaminhado para o pod de app nesse nó do trabalhador.

5. O trabalhador 10.73.14.26 usa o endereço IP de origem do pacote de solicitações original, o IP do cliente, para retornar o pacote de resposta do pod do app diretamente para o cliente.

### Fluxo de tráfego em um cluster de múltiplas zonas
{: #ipvs_multi}

O fluxo de tráfego por meio de um cluster de várias zonas segue o mesmo caminho que o [tráfego por meio de um cluster de zona única](#ipvs_single). Em um cluster multizona, o NLB roteia solicitações para as instâncias do aplicativo em sua própria zona e em outras zonas. O diagrama a seguir mostra como os NLBs da versão 2.0 direcionam o tráfego da Internet em cada zona para um aplicativo em um cluster multizona.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="Expor um aplicativo no {{site.data.keyword.containerlong_notm}} usando um NLB 2.0" style="width:500px; border-style: none"/>

Por padrão, cada NLB versão 2.0 é configurado em apenas uma zona. É possível obter maior disponibilidade implementando um NLB na versão 2.0 em cada zona na qual há instâncias de aplicativo.
