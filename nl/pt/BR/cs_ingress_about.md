---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

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



# Sobre os ALBs do Ingress
{: #ingress-about}

Ingress é um serviço do Kubernetes que equilibra cargas de trabalho do tráfego de rede em seu cluster encaminhando solicitações públicas ou privadas para seus apps. É possível usar o Ingress para expor múltiplos serviços de app ao público ou a uma rede privada usando uma rota público ou privada exclusiva.
{: shortdesc}

## O que vem com o Ingresso?
{: #ingress_components}

O Ingress consiste em três componentes: recursos do Ingress, balanceadores de carga de aplicativo (ALBs) e o balanceador de carga multizona (MZLB).
{: shortdesc}

### Recurso do Ingress
{: #ingress-resource}

Para expor um app usando o Ingresso, deve-se criar um serviço do Kubernetes para seu app e registrar esse serviço com o Ingresso ao definir um recurso Ingresso. O Ingresso é um recurso do Kubernetes que define as regras sobre como rotear as solicitações recebidas para apps. O recurso Ingresso também especifica o caminho para seus serviços de app, que são anexados à rota pública para formar uma URL de app exclusiva, como `mycluster.us-south.containers.appdomain.cloud/myapp1`.
{: shortdesc}

Um recurso Ingress é necessário por namespace no qual você tem apps que deseja expor.
* Se os apps em seu cluster estão todos no mesmo namespace, um recurso Ingress é necessário para definir as regras de roteamento para os apps que são expostos lá. Observe que, se você desejar usar domínios diferentes para os aplicativos dentro do mesmo namespace, será possível usar um domínio curinga para especificar múltiplos hosts de subdomínio em um recurso.
* Se os apps em seu cluster estão em namespaces diferentes, deve-se criar um recurso por namespace para definir regras para os apps que são expostos lá. Deve-se utilizar um domínio curinga e especificar um subdomínio diferente em cada recurso do Ingress.

Para obter mais informações, veja [Planejando a rede para namespaces únicos ou múltiplos](/docs/containers?topic=containers-ingress#multiple_namespaces).

A partir de 24 de maio de 2018, o formato de subdomínio Ingress mudou para novos clusters. O nome da região ou zona incluído no novo formato de subdomínio é gerado com base na zona na qual o cluster foi criado. Se você tiver dependências de pipeline em nomes de domínio de app consistentes, será possível usar seu próprio domínio customizado em vez do subdomínio do Ingresso fornecido pela IBM.
{: note}

* Todos os clusters criados após 24 de maio de 2018 são designados a um subdomínio no novo formato, `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`.
* Os clusters de zona única criados antes de 24 de maio de 2018 continuam a usar o subdomínio designado no formato antigo, `<cluster_name>.<region>.containers.mybluemix.net`.
* Se você mudar um cluster de zona única criado antes de 24 de maio de 2018 para multizona [incluindo uma zona no cluster](/docs/containers?topic=containers-add_workers#add_zone) pela primeira vez, o cluster continuará a usar o subdomínio designado no formato antigo, `<cluster_name>.<region>.containers.mybluemix.net` e também é designado a um subdomínio no novo formato, `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. O subdomínio pode ser usado.

### Balanceador de carga de aplicativo (ALB)
{: #alb-about}

O balanceador de carga de aplicativo (ALB) é um balanceador de carga externo que atende as solicitações de serviço HTTP, HTTPS ou TCP recebidas. O ALB então encaminha as solicitações para o pod de app apropriado de acordo com as regras definidas no recurso Ingresso.
{: shortdesc}

Quando você cria um cluster padrão, o {{site.data.keyword.containerlong_notm}} cria automaticamente um ALB altamente disponível para seu cluster e designa uma rota pública exclusiva a ele. A rota pública é vinculada a um endereço IP público móvel que é provisionado em sua conta de infraestrutura do IBM Cloud durante a criação do cluster. Um ALB privado padrão também é criado automaticamente, mas não é ativado automaticamente.

**Clusters de múltiplas zonas**: quando você inclui uma zona em seu cluster, uma sub-rede pública móvel é incluída e um novo ALB público é criado e ativado automaticamente na sub-rede nessa zona. Todos os ALBs públicos padrão em seu cluster compartilham uma rota pública, mas têm endereços IP diferentes. Um ALB privado padrão também é criado automaticamente em cada zona, mas não é ativado automaticamente.

### Balanceador de Carga Multizona (MZLB)
{: #mzlb}

**Clusters de múltiplas zonas**: sempre que você cria um cluster de múltiplas zonas ou [inclui uma zona em um cluster de zona única](/docs/containers?topic=containers-add_workers#add_zone), um multizone load balancer (MZLB) do Cloudflare é criado e implementado automaticamente para que exista 1 MZLB para cada região. O MZLB coloca os endereços IP de seus ALBs atrás do mesmo subdomínio e ativa as verificações de funcionamento nesses endereços IP para determinar se eles estão disponíveis ou não.

Por exemplo, se você tiver nós do trabalhador em 3 zonas na região Leste dos EUA, o subdomínio `yourcluster.us-east.containers.appdomain.cloud` terá 3 endereços IP de ALB. O funcionamento do MZLB verifica o IP do ALB público em cada zona de uma região e mantém os resultados de consulta de DNS atualizados com base nessas verificações de funcionamento. Por exemplo, se seus ALBs tiverem endereços IP `1.1.1.1`, `2.2.2.2` e `3.3.3.3`, uma consulta de DNS de operação normal de seu subdomínio do Ingress retornará todos os 3 IPs, 1 dos quais o cliente acessa aleatoriamente. Se o ALB com endereço IP `3.3.3.3` se tornar indisponível por qualquer motivo, como devido à falha de zona em que a verificação de funcionamento para essa zona falhará, o MZLB removerá o IP com falha do subdomínio e a consulta de DNS retornará somente os IPs do ALB `1.1.1.1` e `2.2.2.2` funcionais. O subdomínio tem um tempo de vida (TTL) de 30 segundos, portanto, após 30 segundos, os novos aplicativos do cliente poderão acessar somente um dos IPs do ALB funcionais e disponíveis.

Em casos raros, alguns resolvedores de DNS ou aplicativos do cliente podem continuar a usar o IP do ALB não funcional após o TTL de 30 segundos. Esses aplicativos do cliente podem experimentar um tempo de carregamento mais longo até que o aplicativo do cliente abandone o IP `3.3.3.3` e tente se conectar ao `1.1.1.1` ou `2.2.2.2`. Dependendo das configurações do navegador do cliente ou do aplicativo do cliente, o atraso pode variar de alguns segundos a um tempo limite de TCP integral.

A carga do MZLB é balanceada para ALBs públicos que usam somente o subdomínio do Ingresso fornecido pela IBM. Se você usa somente ALBs privados, deve-se verificar manualmente o funcionamento dos ALBs e atualizar os resultados da consulta de DNS. Se você usar ALBs públicos que usam um domínio customizado, será possível incluir os ALBs no balanceamento de carga do MZLB criando um CNAME em sua entrada do DNS para encaminhar as solicitações de seu domínio customizado para o subdomínio do Ingresso fornecido pela IBM para seu cluster.

Se você usar as políticas de rede pré-DNAT do Calico para bloquear todo o tráfego de entrada para os serviços do Ingress, você também deverá inserir na lista de desbloqueio os [IPs IPv4 do Cloudflare ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.cloudflare.com/ips/) que são usados para verificar o funcionamento de seus ALBs. Para obter as etapas sobre como criar uma política pré-DNAT do Calico para incluir na lista de desbloqueio esses IPs, consulte a Lição 3 do [tutorial de política de rede do Calico](/docs/containers?topic=containers-policy_tutorial#lesson3).
{: note}

<br />


## Como os IPs são designados aos ALBs do Ingress?
{: #ips}

Ao criar um cluster padrão, o {{site.data.keyword.containerlong_notm}} provisiona automaticamente uma sub-rede pública móvel e uma sub-rede privada móvel. Por padrão, o cluster usa automaticamente:
* 1 endereço IP público móvel da sub-rede pública móvel para o ALB do Ingress público padrão.
* Um endereço IP privado móvel da sub-rede privada móvel para o ALB do Ingress privado padrão.
{: shortdesc}

Se você tiver um cluster de múltiplas zonas, um ALB público padrão e um ALB privado padrão serão criados automaticamente em cada zona. Os endereços IP de seus ALBs públicos padrão estão todos atrás do mesmo subdomínio fornecido pela IBM para seu cluster.

Os endereços IP públicos e privados móveis são IPs flutuantes estáticos e não mudam quando um nó do trabalhador é removido. Se o nó do trabalhador for removido, um daemon `Keepalived` que monitora constantemente o IP reprogramará automaticamente os pods do ALB que estavam nesse trabalhador para outro nó do trabalhador nessa zona. Os pods do ALB reprogramados retêm o mesmo endereço IP estático. Para a duração do cluster, o endereço IP do ALB em cada zona não muda. Se você remover uma zona de um cluster, o endereço IP do ALB para essa zona será removido.

Para ver os IPs designados a seus ALBs, é possível executar o comando a seguir.
```
ibmcloud ks albs --cluster <cluster_name_or_id>
```
{: pre}

Para obter mais informações sobre o que acontece com o ALB IPs no caso de uma falha de zona, consulte a definição para o [componente do balanceador de carga multizone](#ingress_components).



<br />


## Como uma solicitação chega ao meu app com o Ingress em um cluster de zona única?
{: #architecture-single}



O diagrama a seguir mostra como o Ingresso direciona a comunicação da Internet para um app em um cluster de zona única:

<img src="images/cs_ingress_singlezone.png" width="800" alt="Expor um app em um cluster de zona única usando o Ingress" style="width:800px; border-style: none"/>

1. Um usuário envia uma solicitação para seu app acessando a URL do app. Essa URL é a URL pública para o seu app exposto anexada ao caminho de recurso de Ingresso, como `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Um serviço de sistema DNS resolve o subdomínio na URL para o endereço IP público móvel do balanceador de carga que expõe o ALB em seu cluster.

3. Com base no endereço IP resolvido, o cliente envia a solicitação para o serviço de balanceador de carga que expõe o ALB.

4. O serviço do balanceador de carga roteia a solicitação para o ALB.

5. O ALB verifica se uma regra de roteamento para o caminho `myapp` existe no cluster. Se uma regra de correspondência é localizada, a solicitação é encaminhada de acordo com as regras que você definiu no recurso de Ingresso para o pod no qual o app está implementado. O endereço IP de origem do pacote é mudado para o endereço IP do endereço IP público do nó do trabalhador no qual o pod de app está em execução. Se múltiplas instâncias do app são implementadas no cluster, o ALB balanceia a carga de solicitações entre os pods de app.

<br />


## Como uma solicitação chega ao meu app com o Ingress em um cluster de múltiplas zonas?
{: #architecture-multi}

O diagrama a seguir mostra como o Ingresso direciona a comunicação da Internet para um app em um cluster de múltiplas zonas:

<img src="images/cs_ingress_multizone.png" width="800" alt="Expor um app em um cluster de múltiplas zonas usando o Ingress" style="width:800px; border-style: none"/>

1. Um usuário envia uma solicitação para seu app acessando a URL do app. Essa URL é a URL pública para o seu app exposto anexada ao caminho de recurso de Ingresso, como `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Um serviço do sistema DNS, que age como o balanceador de carga global, resolve o subdomínio na URL para um endereço IP disponível que foi relatado como funcional pelo MZLB. O MZLB verifica continuamente os endereços IP públicos móveis dos serviços de balanceador de carga que expõem ALBs públicos em cada zona em seu cluster. Os endereços IP são resolvidos em um ciclo round-robin, assegurando que as solicitações tenham igualmente a carga balanceada entre os ALBs funcionais em várias zonas.

3. O cliente envia a solicitação para o endereço IP do serviço de balanceador de carga que expõe um ALB.

4. O serviço do balanceador de carga roteia a solicitação para o ALB.

5. O ALB verifica se uma regra de roteamento para o caminho `myapp` existe no cluster. Se uma regra de correspondência é localizada, a solicitação é encaminhada de acordo com as regras que você definiu no recurso de Ingresso para o pod no qual o app está implementado. O endereço IP de origem do pacote é mudado para o endereço IP público do nó do trabalhador no qual o pod de app está em execução. Se múltiplas instâncias de app são implementadas no cluster, a carga do ALB balanceia as solicitações entre os pods de app em todas as zonas.
