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


# Planejando expor os seus apps com rede externa
{: #planning}

Com o {{site.data.keyword.containerlong}}, é possível gerenciar a rede externa, tornando os apps acessíveis publicamente ou privadamente.
{: shortdesc}

## Escolhendo um serviço NodePort, LoadBalancer ou Ingress
{: #external}

Para tornar seus apps externamente acessíveis por meio da Internet pública ou de uma rede privada, o {{site.data.keyword.containerlong_notm}} suporta três serviços de rede.
{:shortdesc}

**[Serviço NodePort](cs_nodeport.html)** (clusters grátis e padrão)
* Exponha uma porta em cada nó do trabalhador e use o endereço IP público ou privado de qualquer nó do trabalhador para acessar seu serviço no cluster.
* Iptables é um recurso de kernel Linux que balanceia a carga de solicitações nos pods do app, fornece roteamento de rede de alto desempenho e fornece controle de acesso à rede.
* Os endereços IP público e privado do nó do trabalhador não são permanentes. Quando um nó do trabalhador é removido ou recriado, um novo endereço IP público e um privado são designados ao nó do trabalhador.
* O serviço NodePort é ótimo para testar o acesso público ou privado. Ele também poderá ser usado se você precisar de acesso público ou privado por somente um curto período.

**[Serviço LoadBalancer](cs_loadbalancer.html)** (somente clusters padrão)
* Cada cluster padrão é provisionado com quatro endereços IP públicos móveis e quatro privados móveis que podem ser usados para criar um balanceador de carga TCP/UDP externo para seu app.
* Iptables é um recurso de kernel Linux que balanceia a carga de solicitações nos pods do app, fornece roteamento de rede de alto desempenho e fornece controle de acesso à rede.
* Os endereços IP públicos e privados móveis que são designados ao balanceador de carga são permanentes e não mudam quando um nó do trabalhador é recriado no cluster.
* É possível customizar seu balanceador de carga expondo qualquer porta que seu app requer.

**[Ingresso](cs_ingress.html)** (somente clusters padrão)
* Exponha múltiplos apps em um cluster criando um balanceador de carga do aplicativo (ALB) HTTP ou HTTPS, TCP ou UDP externo. O ALB usa um ponto de entrada público ou privado seguro e exclusivo para rotear as solicitações recebidas para seus apps.
* É possível usar uma rota para expor múltiplos apps em seu cluster como serviços.
* O Ingresso consiste em três componentes:
  * O recurso de Ingresso define as regras de como rotear e balancear a carga de solicitações recebidas para um app.
  * O ALB atende às solicitações de serviço HTTP ou HTTPS, TCP ou UDP recebidas. Ele encaminha as solicitações em pods dos apps com base nas regras que você definiu no recurso de Ingresso.
  * O multizone load balancer (MZLB) manipula todas as solicitações recebidas para seus apps e balanceia a carga das solicitações entre os ALBs em várias zonas.
* Use o Ingresso para implementar seu próprio ALB com regras de roteamento customizado e se precisar de finalização SSL para seus apps.

Para escolher o melhor serviço de rede para seu app, é possível seguir essa árvore de decisão e clicar em uma das opções para iniciar.

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="Esta imagem orienta na escolha da melhor opção de rede para seu aplicativo. Se esta imagem não estiver sendo exibida, a informação ainda poderá ser encontrada na documentação." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Serviço Nodeport" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="Serviço LoadBalancer" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Serviço Ingress" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## Planejando a rede pública externa
{: #public_access}

Quando você cria um cluster do Kubernetes no {{site.data.keyword.containerlong_notm}}, é possível conectar o cluster a uma VLAN pública. A VLAN pública determina o endereço IP público que é designado a cada nó do trabalhador, que fornece a cada nó do trabalhador uma interface de rede pública.
{:shortdesc}

Para tornar um app publicamente disponível para a Internet, é possível criar um serviço NodePort, LoadBalancer ou Ingress. Para comparar cada serviço, consulte [Escolhendo um serviço NodePort, LoadBalancer ou Ingress](#external).

O diagrama a seguir mostra como o Kubernetes encaminha o tráfego de rede pública no {{site.data.keyword.containerlong_notm}}.

![{{site.data.keyword.containerlong_notm}} Arquitetura do Kubernetes](images/networking.png)

*Plano de dados do Kubernetes no {{site.data.keyword.containerlong_notm}}*

A interface de rede pública para os nós do trabalhador nos clusters grátis e padrão é protegida por políticas de rede do Calico. Essas políticas bloqueiam a maior parte do tráfego de entrada por padrão. No entanto, o tráfego de entrada que é necessário para o Kubernetes funcionar é permitido, assim como conexões para os serviços NodePort, LoadBalancer e Ingresso. Para obter mais informações sobre essas políticas, incluindo como modificá-las, veja [Políticas de rede](cs_network_policy.html#network_policies).

Para obter mais informações sobre como configurar o cluster para rede, incluindo informações sobre sub-redes, firewalls e VPNs, veja [Planejando a rede de cluster padrão](cs_network_cluster.html#both_vlans).

<br />


## Planejando a rede externa privada para uma configuração de VLAN pública e privada
{: #private_both_vlans}

Quando os seus nós do trabalhador são conectados a ambas, uma VLAN pública e uma privada, é possível tornar o seu app acessível somente por meio de uma rede privada criando os serviços privados NodePort, LoadBalancer ou Ingress. Em seguida, é possível criar políticas do Calico para bloquear o tráfego público para os serviços.

** NodePort **
* [Crie um serviço NodePort](cs_nodeport.html). Além do endereço IP público, um serviço NodePort está disponível durante o endereço IP privado de um nó do trabalhador.
* Um serviço NodePort abre uma porta em um nó do trabalhador sobre o endereço IP privado e público do nó do trabalhador. Deve-se usar uma [política de rede preDNAT do Calico](cs_network_policy.html#block_ingress) para bloquear os NodePorts públicos.

**LoadBalancer**
* [Crie um serviço do LoadBalancer privado](cs_loadbalancer.html).
* Um serviço de balanceador de carga com um endereço IP privado móvel ainda tem uma porta do nó público aberta em cada nó do trabalhador. Deve-se usar uma [política de rede preDNAT do Calico](cs_network_policy.html#block_ingress) para bloquear as portas de nó público nele.

**Entrada
    **
* Ao criar um cluster, um balanceador de carga do aplicativo (ALB) de ingresso público e um privado são criados automaticamente. Como o ALB público está ativado e o ALB privado está desativado por padrão, deve-se [desativar o ALB público](cs_cli_reference.html#cs_alb_configure) e [ativar o ALB privado](cs_ingress.html#private_ingress).
* Em seguida, [crie um serviço do Ingress privado](cs_ingress.html#ingress_expose_private).

Como um exemplo, vamos supor que você criou um serviço de balanceador de carga privado. Você também criou uma política preDNAT do Calico para bloquear o tráfego público de atingir os NodePorts públicos abertos pelo balanceador de carga. Esse balanceador de carga privado pode ser acessado por:
* Qualquer pod no mesmo cluster
* Qualquer pod em qualquer cluster na mesma conta do IBM Cloud
* Se você tiver o [VLAN Spanning ativado](cs_subnets.html#subnet-routing), qualquer sistema que esteja conectado a qualquer uma das VLANs privadas na mesma conta do IBM Cloud
* Se você não estiver na conta do IBM Cloud, mas ainda estiver atrás do firewall da empresa, qualquer sistema por meio de uma conexão VPN com a sub-rede em que o IP do balanceador de carga está ativo
* Se você estiver em uma conta do IBM Cloud diferente, qualquer sistema por meio de uma conexão VPN com a sub-rede em que o IP do balanceador de carga está ativo

Para obter mais informações sobre como configurar o cluster para rede, incluindo informações sobre sub-redes, firewalls e VPNs, veja [Planejando a rede de cluster padrão](cs_network_cluster.html#both_vlans).

<br />


## Planejando a rede externa privada para uma configuração somente de VLAN privada
{: #private_vlan}

Quando os nós do trabalhador são conectados somente a uma VLAN privada, é possível tornar seu app acessível somente por meio de uma rede privada criando os serviços privados NodePort, LoadBalancer ou Ingress. Como os nós do trabalhador não estão conectados a uma VLAN pública, nenhum tráfego público é roteado para esses serviços.

** NodePort **:
* [ Criar um serviço NodePort privado ](cs_nodeport.html). O serviço está disponível por meio do endereço IP privado de um nó do trabalhador.
* Em seu firewall privado, abra a porta que você configurou quando implementou o serviço nos endereços IP privados para todos os nós do trabalhador para os quais permitir o tráfego. Para localizar a porta, execute `kubectl get svc`. A porta está no intervalo de 20000 a 32000.

**LoadBalancer**
* [Crie um serviço do LoadBalancer privado](cs_loadbalancer.html). Se o seu cluster está disponível somente em uma VLAN privada, um dos quatro endereços IP privados móveis disponíveis é usado.
* Em seu firewall privado, abra a porta que você configurou quando implementou o serviço para o endereço IP privado do serviço de balanceador de carga.

** Ingresso **:
* Deve-se configurar um [serviço DNS que está disponível na rede privada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
* Ao criar um cluster, um balanceador de carga do aplicativo (ALB) de ingresso privado é criado automaticamente, mas não é ativado por padrão. Você deve  [ ativar o ALB privado ](cs_ingress.html#private_ingress).
* Em seguida, [crie um serviço do Ingress privado](cs_ingress.html#ingress_expose_private).
* Em seu firewall privado, abra a porta 80 para HTTP ou a porta 443 para HTTPS para o endereço IP para o ALB privado.

Para obter mais informações sobre como configurar seu cluster para rede, incluindo informações sobre sub-redes e dispositivos de gateway, consulte [Planejando a rede para uma configuração somente de VLAN privada](cs_network_cluster.html#private_vlan).
