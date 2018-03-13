---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Planejando a rede externa
{: #planning}

Ao criar um cluster, cada cluster deve ser conectado a uma VLAN pública. A VLAN pública
determina o endereço IP público que é designado a um nó do trabalhador durante a criação de cluster.
{:shortdesc}

A interface de rede pública para os nós do trabalhador nos clusters grátis e padrão é protegida por políticas de rede do Calico. Essas políticas bloqueiam a maior parte do tráfego de entrada por padrão. No entanto, o tráfego de entrada que é necessário para o Kubernetes funcionar é permitida, assim como conexões NodePort, Loadbalancer e os serviços do Ingresso. Para obter mais informações sobre essas políticas, incluindo como modificá-las, consulte [Políticas de rede](cs_network_policy.html#network_policies).

|Tipo de cluster|Gerenciador da VLAN pública para o cluster|
|------------|------------------------------------------|
|Clusters livres no {{site.data.keyword.Bluemix_notm}}|{{site.data.keyword.IBM_notm}}|
|Clusters padrão no {{site.data.keyword.Bluemix_notm}}|Você em sua conta de infraestrutura do IBM Cloud (SoftLayer)|
{: caption="Responsabilidades de gerenciamento da VLAN" caption-side="top"}

Para obter informações sobre a comunicação de rede de cluster entre os nós do trabalhador e os pods, veja [Rede de cluster](cs_secure.html#in_cluster_network). Para obter informações sobre como conectar com segurança apps em execução em um cluster do Kubernetes a uma rede no local ou a apps externos para o cluster, veja [Configurando a conectividade de VPN](cs_vpn.html).

## Permitindo o acesso público a apps
{: #public_access}

Para tornar um app publicamente disponível na Internet, deve-se atualizar seu arquivo de configuração antes de implementar o app em um cluster.
{:shortdesc}

*Plano de dados do Kubernetes no {{site.data.keyword.containershort_notm}}*

![{{site.data.keyword.containerlong_notm}} Arquitetura do Kubernetes](images/networking.png)

O diagrama mostra como o Kubernetes transporta o tráfego de rede do usuário em {{site.data.keyword.containershort_notm}}. Dependendo se você criou um cluster grátis ou padrão, existem diferentes maneiras de tornar seu app acessível na Internet.

<dl>
<dt><a href="#nodeport" target="_blank">Serviço NodePort</a> (clusters grátis e padrão)</dt>
<dd>
 <ul>
  <li>Exponha uma porta pública em cada nó do trabalhador e use o endereço IP público de qualquer nó do trabalhador para acessar publicamente seu serviço no cluster.</li>
  <li>Iptables é um recurso de kernel do Linux que faz o balanceamento de carga das solicitações dos Pods do aplicativo, fornece
roteamento de rede de alto desempenho e controle de acesso de rede.</li>
  <li>O endereço IP público do nó do trabalhador não é permanente. Quando um nó do trabalhador é removido ou recriado, um novo endereço IP público é designado ao
nó do trabalhador.</li>
  <li>O serviço NodePort é ótimo para testar o acesso público. Ele também pode ser usado se você precisa de acesso público somente por um curto tempo.</li>
 </ul>
</dd>
<dt><a href="#loadbalancer" target="_blank">Serviço LoadBalancer</a> (somente clusters padrão)</dt>
<dd>
 <ul>
  <li>Cada cluster padrão é provisionado com 4 endereços IP públicos móveis e 4 endereços IP privados móveis que podem ser usados para criar um balanceador de carga TCP/UDP externo para seu app.</li>
  <li>Iptables é um recurso de kernel do Linux que faz o balanceamento de carga das solicitações dos Pods do aplicativo, fornece
roteamento de rede de alto desempenho e controle de acesso de rede.</li>
  <li>O endereço IP público móvel que é designado para o balanceador de carga é permanente e não muda quando um nó do trabalhador é recriado no cluster.</li>
  <li>É possível customizar seu balanceador de carga expondo qualquer porta que seu app requer.</li></ul>
</dd>
<dt><a href="#ingress" target="_blank">Ingresso</a> (somente clusters padrão)</dt>
<dd>
 <ul>
  <li>Exponha múltiplos apps no cluster criando um balanceador de carga HTTP ou HTTPS externo que use um ponto de entrada público assegurado e exclusivo para rotear solicitações recebidas para seus apps.</li>
  <li>É possível usar uma rota pública para expor múltiplos apps em seu cluster como serviços.</li>
  <li>O Ingresso consiste em dois componentes principais: o recurso de Ingresso e o balanceador de carga de aplicativo.
   <ul>
    <li>O recurso de Ingresso define as regras de como rotear e balancear a carga de solicitações recebidas para um app.</li>
    <li>O balanceador de carga de aplicativo atende às solicitações de serviço HTTP ou HTTPS recebidas e encaminha as solicitações em pods dos apps com base nas regras definidas para cada recurso de Ingresso.</li>
   </ul>
  <li>Use Ingresso se desejar implementar seu próprio balanceador de carga de aplicativo com regras de roteamento customizado e se precisar de finalização SSL para seus apps.</li>
 </ul>
</dd></dl>

Para escolher a melhor opção de rede para seu aplicativo, é possível seguir esta árvore de decisão:

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="Esta imagem orienta na escolha da melhor opção de rede para seu aplicativo. Se esta imagem não estiver sendo exibida, a informação ainda poderá ser encontrada na documentação." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html#config" alt="Serviço Nodeport" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html#config" alt="Serviço Loadbalancer" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html#config" alt="Serviço Ingress" shape="circle" coords="445, 420, 45"/>
</map>


<br />


## Exponha um app à Internet usando um serviço NodePort
{: #nodeport}

Exponha uma porta pública em seu nó do trabalhador e use o endereço IP público do nó do trabalhador para acessar seu serviço no cluster publicamente por meio da Internet.
{:shortdesc}

Ao expor seu app criando um serviço do Kubernetes do tipo NodePort, um NodePort no intervalo de 30.000 a 32.767 e um endereço IP interno do cluster são designados ao serviço. O serviço NodePort serve como o ponto de entrada externo para solicitações recebidas para seu app. O NodePort designado é exposto publicamente nas configurações kubeproxy de cada nó do trabalhador no cluster. Cada nó do trabalhador inicia o atendimento no NodePort designado para solicitações recebidas para o
serviço. Para acessar o serviço por meio da Internet, será possível usar o endereço IP público de qualquer nó do trabalhador que tenha sido designado durante a criação do cluster e o NodePort no formato `<ip_address>:<nodeport>`. Além do endereço IP público, um serviço NodePort está disponível durante o endereço IP privado de um nó do trabalhador.

O diagrama a seguir mostra como a comunicação é direcionada da Internet para um app quando um serviço NodePort está configurado.

![Exponha um serviço usando um serviço Kubernetes NodePort](images/cs_nodeport.png)

Conforme descrito no diagrama, quando uma solicitação chega ao serviço NodePort, ela é encaminhada automaticamente para o IP de cluster interno do serviço e encaminhada posteriormente do componente `kube-proxy` componente para o endereço IP privado do pod no qual o app está implementado. O IP do cluster é
acessível somente dentro do cluster. Se você tiver múltiplas réplicas de seu app em execução em diferentes pods, o componente `kube-proxy` equilibrará a carga das solicitações recebidas entre todas as réplicas.

**Nota:** o endereço IP público do nó do trabalhador não é permanente. Quando um nó do trabalhador é removido ou recriado, um novo endereço IP público é designado ao
nó do trabalhador. É possível usar o serviço do NodePort para testar o acesso público para o seu aplicativo ou quando o acesso público for necessário apenas para uma quantia pequena de tempo. Ao requerer um endereço IP público estável e mais disponibilidade para seu serviço, exponha seu app usando um [serviço LoadBalancer](#loadbalancer) ou [Ingresso](#ingress).

Para obter instruções sobre como criar um serviço do tipo NodePort com o {{site.data.keyword.containershort_notm}}, veja [Configurando o acesso público a um app usando o tipo de serviço NodePort](cs_nodeport.html#config).

<br />



## Exponha um app à Internet usando um serviço LoadBalancer
{: #loadbalancer}

Exponha uma porta e use o endereço IP público ou privado para que o balanceador de carga acesse o app.
{:shortdesc}


Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} solicita automaticamente cinco endereços IP móveis públicos e cinco endereços IP móveis privados e os provisiona em sua conta de infraestrutura do IBM Cloud (SoftLayer) durante a criação do cluster. Dois dos endereços IP móveis, um público e um privado, são usados para [Balanceadores de carga de aplicativo do Ingress](#ingress). Quatro endereços IP móveis públicos e quatro endereços IP móveis privados podem ser usados para expor apps criando um serviço LoadBalancer.

Ao criar um serviço do Kubernetes LoadBalancer em um cluster em uma VLAN pública, um balanceador de carga externo é criado. Um dos quatro endereços IP públicos disponíveis é designado ao balanceador de carga. Se nenhum endereço
IP público móvel estiver disponível, a criação de seu serviço LoadBalancer falhará. O serviço LoadBalancer serve como o ponto de entrada externo para solicitações recebidas para o app. Diferente dos serviços NodePort, é possível designar qualquer porta a seu balanceador de carga e não ser limitado a um determinado intervalo de portas. O endereço IP público móvel que é designado ao seu serviço LoadBalancer é permanente e não muda quando um nó do trabalhador é removido ou recriado. Portanto, o serviço LoadBalancer é mais disponível do que o serviço NodePort. Para acessar o serviço LoadBalancer por meio da Internet, use o endereço IP público do balanceador de carga e a porta designada no formato `<ip_address>:<port>`.

O diagrama a seguir mostra como o LoadBalancer direciona a comunicação da Internet para um app:

![Exponha um serviço usando um tipo de serviço Kubernetes LoadBalancer](images/cs_loadbalancer.png)

Conforme descrito no diagrama, quando uma solicitação chega ao serviço LoadBalancer, a solicitação é encaminhada automaticamente para o endereço IP do cluster interno que é designado ao serviço LoadBalancer durante a criação de serviço. O endereço IP do cluster é acessível somente dentro do cluster. No endereço IP do cluster, as solicitações recebidas são encaminhadas adicionalmente ao componente `kube-proxy` de seu nó do trabalhador. Então, as solicitações são encaminhadas ao endereço IP privado do pod no qual o app está implementado. Se você tiver múltiplas réplicas de seu app em execução em diferentes pods, o componente `kube-proxy` equilibrará a carga das solicitações recebidas entre todas as réplicas.

Se você usar um serviço LoadBalancer, uma porta de nó também estará disponível em cada endereço IP de qualquer nó do trabalhador. Para bloquear o acesso à porta de nó enquanto você estiver usando um serviço LoadBalancer, consulte [Bloqueando tráfego recebido](cs_network_policy.html#block_ingress).

Suas opções para endereços IP quando você cria um serviço LoadBalancer são como a seguir:

- Se o seu cluster estiver em uma VLAN pública, um endereço IP móvel público será usado.
- Se o seu cluster estiver disponível apenas em uma VLAN privada, então, um endereço IP móvel privado será usado.
- É possível solicitar um endereço IP público ou privado móvel para um serviço LoadBalancer, incluindo uma anotação no arquivo de configuração: `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.



Para obter instruções sobre como criar um serviço LoadBalancer com o {{site.data.keyword.containershort_notm}}, veja [Configurando o acesso público a um app usando o tipo de serviço de balanceador de carga](cs_loadbalancer.html#config).


<br />



## Expor um app à Internet com Ingresso
{: #ingress}

O Ingresso permite expor múltiplos serviços em seu cluster e torná-los publicamente disponíveis usando um ponto de entrada público único.
{:shortdesc}

Em vez de criar um serviço de balanceador de carga para cada app que você desejar expor ao público, o Ingresso fornece uma rota pública exclusiva que permite encaminhar solicitações públicas para apps dentro e fora do seu cluster com base em seus caminhos individuais. O ingresso consiste em dois componentes principais. O
recurso de Ingresso define as regras de como rotear solicitações recebidas para um app. Todos os recursos de Ingresso devem ser registrados com o balanceador de carga de aplicativo de Ingresso que atende solicitações de serviço HTTP ou HTTPS recebidas e encaminha as solicitações com base nas regras definidas para cada recurso de Ingresso.

Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} cria automaticamente um balanceador de carga de aplicativo altamente disponível para seu cluster e designa uma rota pública exclusiva com o formato `<cluster_name>.<region>.containers.mybluemix.net` a ele. A rota pública está vinculada a um endereço IP público móvel que é provisionado em sua conta de infraestrutura do IBM Cloud (SoftLayer) durante a criação do cluster. Um balanceador de carga de aplicativo privado também é criado automaticamente, mas não é ativado automaticamente.

O diagrama a seguir mostra como o Ingresso direciona a comunicação da internet para um app:

![Expor um serviço usando o suporte de ingresso do {{site.data.keyword.containershort_notm}}](images/cs_ingress.png)

Para expor um app por meio de Ingresso, deve-se criar um serviço do Kubernetes para seu app e registrar esse serviço com o balanceador de carga de aplicativo definindo um recurso de Ingresso. O recurso de Ingresso especifica o caminho que você deseja anexar à rota pública para formar uma URL exclusiva para seu app exposto, como `mycluster.us-south.containers.mybluemix.net/myapp`. Quando você insere essa rota em seu navegador da web, conforme descrito no diagrama, a solicitação é enviada ao endereço IP público móvel vinculado do balanceador de carga de aplicativo. O balanceador de carga de aplicativo verifica se uma regra de roteamento para o caminho `myapp` no cluster `mycluster` existe. Se uma regra de correspondência for localizada, a solicitação incluindo
o caminho individual será encaminhada para o pod no qual o app está implementado, considerando as regras que
foram definidas no objeto de recurso de Ingresso original. Para que o app processe solicitações
recebidas, certifique-se de que seu app atenda no caminho individual que você definiu no recurso de
Ingresso.



É possível configurar o balanceador de carga de aplicativo para gerenciar o tráfego de rede recebido para seus apps para os cenários a seguir:

-   Usar o domínio fornecido pela IBM sem finalização TLS
-   Usar o domínio fornecido pela IBM com finalização TLS
-   Usar um domínio customizado com finalização TLS
-   Usar o domínio fornecido pela IBM ou um customizado com finalização TLS para acessar apps fora de seu cluster
-   Usar um balanceador de carga de aplicativo privado e um domínio customizado sem finalização TLS
-   Usar um balanceador de carga de aplicativo privado e um domínio do cliente com finalização TLS
-   Incluir recursos em seu balanceador de carga de aplicativo usando anotações

Para obter instruções sobre como usar o Ingresso com o {{site.data.keyword.containershort_notm}}, veja [Configurando o acesso público a um app usando o Ingresso](cs_ingress.html#ingress).

<br />

