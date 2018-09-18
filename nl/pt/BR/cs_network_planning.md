---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Planejando a rede do
{: #planning}

Com o {{site.data.keyword.containerlong}}, é possível gerenciar a rede externa tornando os apps publicamente ou privadamente acessíveis e a rede interna em seu cluster.
{: shortdesc}

## Escolhendo um serviço NodePort, LoadBalancer ou Ingress
{: #external}

Para tornar os seus apps externamente acessíveis por meio da [Internet pública](#public_access) ou de uma [rede privada](#private_both_vlans), o {{site.data.keyword.containershort_notm}} suporta três serviços de rede.
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

Quando você cria um cluster do Kubernetes no {{site.data.keyword.containershort_notm}}, é possível conectar o cluster a uma VLAN pública. A VLAN pública determina o endereço IP público que é designado a cada nó do trabalhador, que fornece a cada nó do trabalhador uma interface de rede pública.
{:shortdesc}

Para tornar um app publicamente disponível para a Internet, é possível criar um serviço NodePort, LoadBalancer ou Ingress. Para comparar cada serviço, consulte [Escolhendo um serviço NodePort, LoadBalancer ou Ingress](#external).

O diagrama a seguir mostra como o Kubernetes encaminha o tráfego de rede pública no {{site.data.keyword.containershort_notm}}.

![{{site.data.keyword.containershort_notm}} Arquitetura do Kubernetes](images/networking.png)

*Plano de dados do Kubernetes no {{site.data.keyword.containershort_notm}}*

A interface de rede pública para os nós do trabalhador nos clusters grátis e padrão é protegida por políticas de rede do Calico. Essas políticas bloqueiam a maior parte do tráfego de entrada por padrão. No entanto, o tráfego de entrada que é necessário para o Kubernetes funcionar é permitido, assim como conexões para os serviços NodePort, LoadBalancer e Ingresso. Para obter mais informações sobre essas políticas, incluindo como modificá-las, veja [Políticas de rede](cs_network_policy.html#network_policies).

<br />


## Planejando a rede externa privada para uma configuração de VLAN pública e privada
{: #private_both_vlans}

Ao criar um cluster do Kubernetes no {{site.data.keyword.containershort_notm}}, deve-se conectar o seu cluster a uma VLAN privada. A VLAN privada determina o endereço IP privado que é designado a cada nó do trabalhador, que fornece cada nó do trabalhador com uma interface de rede privada.
{:shortdesc}

Quando você deseja manter seus apps conectados somente a uma rede privada, é possível usar a interface de rede privada para os nós do trabalhador em clusters padrão. No entanto, quando os nós do trabalhador são conectados a uma VLAN pública e uma VLAN privada, deve-se também usar as políticas de rede do Calico para proteger seu cluster contra o acesso público indesejado.

As seções a seguir descrevem os recursos no {{site.data.keyword.containershort_notm}} que podem ser usados para expor apps a uma rede privada e proteger seu cluster contra o acesso público indesejado. Opcionalmente, também é possível isolar suas cargas de trabalho de rede e conectar seu cluster a recursos em uma rede no local.

### Expor seus apps com serviços de rede privada e proteger seu cluster com políticas de rede do Calico
{: #private_both_vlans_calico}

A interface de rede pública para os nós do trabalhador é protegida por [configurações de política de rede do Calico predefinidas](cs_network_policy.html#default_policy) que são configuradas em cada nó do trabalhador durante a criação do cluster. Por padrão, todo o tráfego de rede de saída é permitido para todos os nós do trabalhador. O tráfego de rede de entrada é bloqueado, exceto para algumas portas que são abertas para que o tráfego de rede possa ser monitorado pela IBM e para a IBM instalar automaticamente as atualizações de segurança para o mestre do Kubernetes. O acesso ao kubelet do nó do trabalhador é protegido por um túnel OpenVPN. Para obter mais informações, consulte a [arquitetura do {{site.data.keyword.containershort_notm}}](cs_tech.html).

Se você expuser os seus apps com um serviço NodePort, um serviço LoadBalancer ou um balanceador de carga do aplicativo do Ingress, as políticas padrão do Calico também permitirão o tráfego de rede de entrada da Internet para esses serviços. Para tornar seu app acessível somente por meio de uma rede privada, é possível escolher usar somente os serviços privados NodePort, LoadBalancer ou Ingresso e bloquear todo o tráfego público para os serviços.

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

Para obter mais informações sobre cada serviço, consulte [Escolhendo um serviço da NodePort, do LoadBalancer ou do Ingress](#external).

### Opcional: isolar as cargas de trabalho de rede para os nós do trabalhador de borda
{: #private_both_vlans_edge}

Os nós do trabalhador de borda podem melhorar a segurança de seu cluster, permitindo que menos nós do trabalhador sejam acessados externamente e isolando a carga de trabalho de rede. Para assegurar que os pods do Ingresso e do balanceador de carga sejam implementados somente para os nós do trabalhador especificados, [rotule os nós do trabalhador como nós de borda](cs_edge.html#edge_nodes). Para também evitar que outras cargas de trabalho sejam executadas em nós de borda, [contamine os nós de borda](cs_edge.html#edge_workloads).

Em seguida, use uma [política de rede preDNAT do Calico](cs_network_policy.html#block_ingress) para bloquear o tráfego para portas de nó público em clusters que estão executando os nós do trabalhador de borda. Bloquear as portas de nós assegura que os nós do trabalhador de borda sejam os únicos nós do trabalhador que manipulam o tráfego recebido.

### Opcional: conectar a um banco de dados no local usando a VPN strongSwan
{: #private_both_vlans_vpn}

Para conectar com segurança seus nós do trabalhador e apps a uma rede no local, é possível configurar um [serviço de VPN IPSec strongSwan ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.strongswan.org/about.html). O serviço de VPN do IPSec do strongSwan fornece um canal de comunicação seguro de ponta a ponta sobre a Internet que é baseado no conjunto de protocolos padrão de mercado da Internet Protocol Security (IPSec). Para configurar uma conexão segura entre seu cluster e uma rede no local, [configure e implemente o serviço VPN IPSec do strongSwan](cs_vpn.html#vpn-setup) diretamente em um pod no cluster.

<br />


## Planejando a rede externa privada para somente uma configuração de VLAN privada
{: #private_vlan}

Ao criar um cluster do Kubernetes no {{site.data.keyword.containershort_notm}}, deve-se conectar o seu cluster a uma VLAN privada. A VLAN privada determina o endereço IP privado que é designado a cada nó do trabalhador, que fornece cada nó do trabalhador com uma interface de rede privada.
{:shortdesc}

Quando os nós do trabalhador são conectados somente a uma VLAN privada, é possível usar a interface de rede privada para que os nós do trabalhador mantenham os apps conectados somente à rede privada. É possível, então, usar um dispositivo de gateway para proteger seu cluster contra o acesso público indesejado.

As seções a seguir descrevem os recursos no {{site.data.keyword.containershort_notm}} que podem ser usados para proteger seu cluster contra o acesso público indesejado, expor apps a uma rede privada e conectar-se a recursos em uma rede no local.

### Configurar um dispositivo de gateway
{: #private_vlan_gateway}

Se nós do trabalhador forem configurados com uma VLAN privada apenas, será necessário configurar uma solução alternativa para conectividade de rede. É possível configurar um firewall com políticas de rede customizadas para fornecer segurança de rede dedicada para seu cluster padrão e para detectar e corrigir a intrusão de rede. Por exemplo, você pode escolher configurar um [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html) ou um [Fortigate Security Appliance](/docs/infrastructure/fortigate-10g/about.html) para agir como seu firewall e bloquear o tráfego indesejado. Ao configurar um firewall, [deve-se também abrir as portas e os endereços IP necessários](cs_firewall.html#firewall_outbound) para cada região para que o mestre e os nós do trabalhador possam se comunicar. 

**Nota**: se você tiver um dispositivo roteador existente e, em seguida, incluir um cluster, as novas sub-redes móveis que são ordenadas para o cluster não serão configuradas no dispositivo do roteador. Para usar os serviços de rede, deve-se ativar o roteamento entre as sub-redes na mesma VLAN [ativando o VLAN Spanning](cs_subnets.html#vra-routing).

### Expor seus apps com serviços de rede privada
{: #private_vlan_services}

Para tornar seu app acessível por meio de uma rede privada, é possível usar os serviços privados NodePort, LoadBalancer ou Ingress. Como os nós do trabalhador não estão conectados a uma VLAN pública, nenhum tráfego público é roteado para esses serviços.

** NodePort **:
* [ Criar um serviço NodePort privado ](cs_nodeport.html). O serviço está disponível por meio do endereço IP privado de um nó do trabalhador.
* Em seu firewall privado, abra a porta que você configurou quando implementou o serviço nos endereços IP privados para todos os nós do trabalhador para os quais permitir o tráfego. Para localizar a porta, execute `kubectl get svc`. A porta está no intervalo de 20000 a 32000.

**LoadBalancer**
* [Crie um serviço do LoadBalancer privado](cs_loadbalancer.html). Se o seu cluster está disponível somente em uma VLAN privada, um dos quatro endereços IP privados móveis disponíveis é usado.
* Em seu firewall privado, abra a porta que você configurou quando implementou o serviço para o endereço IP privado do serviço de balanceador de carga.

** Ingresso **:
* Ao criar um cluster, um balanceador de carga do aplicativo (ALB) de ingresso privado é criado automaticamente, mas não é ativado por padrão. Você deve  [ ativar o ALB privado ](cs_ingress.html#private_ingress).
* Em seguida, [crie um serviço do Ingress privado](cs_ingress.html#ingress_expose_private).
* Em seu firewall privado, abra a porta 80 para HTTP ou a porta 443 para HTTPS para o endereço IP para o ALB privado.


Para obter mais informações sobre cada serviço, consulte [Escolhendo um serviço da NodePort, do LoadBalancer ou do Ingress](#external).

### Opcional: conectar-se a um banco de dados no local usando o dispositivo de gateway
{: #private_vlan_vpn}

Para conectar com segurança os nós do trabalhador e apps a uma rede no local, deve-se configurar um gateway de VPN. É possível usar o [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) ou o [Fortigate Security Appliance (FSA ](/docs/infrastructure/fortigate-10g/about.html) que você configurou como um firewall para também configurar um terminal de VPN IPSec. Para configurar um VRA, veja [Configurando a conectividade VPN com o VRA](cs_vpn.html#vyatta).

<br />


## Planejando a rede em cluster
{: #in-cluster}

Todos os pods que são implementados em um nó do trabalhador são designados a um endereço IP privado no intervalo 172.30.0.0/16 e são roteados somente entre os nós do trabalhador. Para evitar conflitos, não use esse intervalo de IPs em quaisquer nós que se comunicam com seus nós do trabalhador. Os nós do trabalhador e os pods podem se comunicar com segurança na rede privada usando endereços IP privados. No entanto, quando um pod trava ou um nó do trabalhador precisa ser recriado, um novo endereço IP privado
é designado.

Por padrão, é difícil rastrear a mudança de endereços IP privados para apps que devem ser altamente disponíveis. Em vez disso, é possível usar os recursos de descoberta de serviço do Kubernetes integrados para expor apps como serviços IP do cluster na rede privada. Um serviço do Kubernetes agrupa um conjunto de pods e fornece uma conexão de rede a esses pods para outros serviços no cluster sem expor o endereço IP privado real de cada pod. Os serviços são designados a um endereço IP em cluster que é acessível somente dentro do cluster.
* **Clusters mais antigos**: em clusters que foram criados antes de fevereiro de 2018 na zona dal13 ou antes de outubro de 2017 em qualquer outra zona, os serviços são designados a um IP de um dos 254 IPs no intervalo 10.10.10.0/24. Se você atinge o limite de 254 serviços e precisa de mais serviços, deve-se criar um novo cluster.
* **Clusters mais recentes**: em clusters que foram criados após fevereiro de 2018 na zona dal13 ou depois de outubro de 2017 em qualquer outra zona, os serviços são designados a um IP de um dos 65.000 IPs no intervalo 172.21.0.0/16.

Para evitar conflitos, não use esse intervalo de IPs em quaisquer nós que se comunicam com seus nós do trabalhador. Uma entrada de consulta de DNS também é criada para o serviço e armazenada no componente `kube-dns` do cluster. A entrada de DNS contém o nome do serviço, o namespace no qual o serviço foi criado e o link para o endereço IP em cluster designado.

Para acessar um pod por trás de um serviço IP do cluster, os apps podem usar o endereço IP em cluster do serviço ou enviar uma solicitação usando o nome do serviço. Quando você usa o nome do serviço, o nome é consultado no componente `kube-dns` e roteado para o endereço IP em cluster do serviço. Quando uma solicitação atinge o serviço, o serviço assegura que todas as solicitações sejam igualmente encaminhadas para os pods, independentemente de seus endereços IP em cluster e do nó do trabalhador em que eles são implementados.
