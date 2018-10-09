---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Planejando a configuração do seu cluster e do nó do trabalhador
{: #plan_clusters}
Projete seu cluster padrão para máxima disponibilidade e capacidade para seu app com o {{site.data.keyword.containerlong}}.

## Clusters altamente disponíveis
{: #ha_clusters}

Seus usuários são menos propensos a experienciar o tempo de inatividade quando você distribui seus apps em múltiplos nós do trabalhador, zonas e clusters. Recursos integrados, como balanceamento de carga e isolamento, aumentam a resiliência com relação a potenciais
falhas com hosts, redes ou apps.
{: shortdesc}

Revise estas potenciais configurações de cluster que são ordenadas com graus crescentes de disponibilidade.

![High availability for clusters](images/cs_cluster_ha_roadmap_multizone.png)

1. Um [cluster de zona única](#single_zone) com múltiplos nós do trabalhador em um conjunto de trabalhadores.
2. Um [cluster de múltiplas zonas](#multizone) que difunde nós do trabalhador em zonas dentro de uma região.
3. [Múltiplos clusters](#multiple_clusters) que são configurados em zonas ou regiões e que são conectados por meio de um balanceador de carga global.

## Cluster de zona única
{: #single_zone}

Para melhorar a disponibilidade para seu app e para permitir o failover para o caso de um nó do trabalhador não estar disponível em seu cluster, inclua nós do trabalhador adicionais em seu cluster de zona única.
{: shortdesc}

<img src="images/cs_cluster_singlezone.png" alt="Alta disponibilidade para clusters em uma zona única" width="230" style="width:230px; border-style: none"/>

Por padrão, seu cluster de zona única está configurado com um conjunto de trabalhadores denominado `default`. O conjunto de trabalhadores agrupa nós do trabalhador com a mesma configuração, tal como o tipo de máquina, que você definiu durante a criação do cluster. É possível incluir mais nós do trabalhador em seu cluster [redimensionando um conjunto de trabalhadores existente](cs_clusters.html#resize_pool) ou [incluindo um novo conjunto de trabalhadores](cs_clusters.html#add_pool).

Ao incluir mais nós do trabalhador, as instâncias do app podem ser distribuídas entre múltiplos nós do trabalhador. Se um nó do trabalhador ficar inativo, as instâncias do app em nós do trabalhador disponíveis continuarão a ser executadas. O Kubernetes reagenda automaticamente os pods de nós do trabalhador indisponíveis para assegurar desempenho e capacidade para seu app. Para assegurar que os seus pods sejam distribuídos de maneira uniforme entre os nós do trabalhador, implemente a [afinidade de pod](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature).

**Posso converter meu cluster de zona única em um cluster multizona?**</br>
Se o cluster estiver em uma das [cidades metropolitanas de multizona suportadas](cs_regions.html#zones), sim. Veja [Atualizando de nós do trabalhador independentes para conjuntos de trabalhadores](cs_cluster_update.html#standalone_to_workerpool).


**Eu tenho que usar clusters de múltiplas zonas?**</br>
Não. É possível criar tantos clusters de zona única quantos você desejar. De fato, você pode preferir clusters de zona única para gerenciamento simplificado ou se o seu cluster deve residir em uma [cidade de zona única](cs_regions.html#zones) específica.

## Cluster de múltiplas zonas
{: #multizone}

Com o  {{site.data.keyword.containerlong}}, é possível criar clusters multizona. Seus usuários são menos propensos a experienciar o tempo de inatividade quando você distribui seus apps em múltiplos nós do trabalhador e zonas usando um conjunto de trabalhadores. Os recursos integrados, como balanceamento de carga, aumentam a resiliência com relação a potenciais falhas de zona com hosts, redes ou apps. Se os recursos em uma zona ficam inativos, as cargas de trabalho do cluster ainda operam nas outras zonas. **Nota**: somente clusters de zona única estão disponíveis para as instâncias do {{site.data.keyword.Bluemix_dedicated_notm}}.
{: shortdesc}

** O que é um conjunto de trabalhadores? **</br>
Um conjunto de trabalhadores é uma coleção de nós do trabalhador com o mesmo tipo, como o tipo de máquina, a CPU e a memória. Quando você cria um cluster, um conjunto de trabalhadores padrão é criado automaticamente. Para difundir os nós do trabalhador em seu conjunto nas zonas, incluir nós do trabalhador no conjunto ou atualizar nós do trabalhador, é possível usar os novos comandos `ibmcloud ks worker-pool`.

**Ainda posso usar nós do trabalhador independentes?**</br>
A configuração de cluster anterior de nós do trabalhador independentes é suportada, mas descontinuada. Certifique-se de [incluir um conjunto de trabalhadores em seu cluster](cs_clusters.html#add_pool) e, em seguida, [migrar para usar os conjuntos de trabalhadores](cs_cluster_update.html#standalone_to_workerpool) para organizar os nós do trabalhador em vez de nós do trabalhador independentes.

**Posso converter meu cluster de zona única em um cluster multizona?**</br>
Se o cluster estiver em uma das [cidades metropolitanas de multizona suportadas](cs_regions.html#zones), sim. Veja [Atualizando de nós do trabalhador independentes para conjuntos de trabalhadores](cs_cluster_update.html#standalone_to_workerpool).


### Conte-me mais sobre a configuração do cluster de múltiplas zonas
{: #mz_setup}

<img src="images/cs_cluster_multizone.png" alt="High availability for multizone clusters" width="500" style="width:500px; border-style: none"/>

É possível incluir zonas adicionais em seu cluster para replicar os nós do trabalhador em seus conjuntos de trabalhadores em múltiplas zonas dentro de uma região. Os clusters de múltiplas zonas são projetados para planejar uniformemente os pods em nós do trabalhador e zonas para assegurar disponibilidade e recuperação de falha. Se os nós do trabalhador não forem difundidos uniformemente entre as zonas ou se houver capacidade insuficiente em uma das zonas, o planejador do Kubernetes poderá falhar ao planejar todos os pods solicitados. Como resultado, os pods podem entrar em um estado **Pendente** até que capacidade suficiente esteja disponível. Se você desejar mudar o comportamento padrão para fazer o planejador do Kubernetes distribuir os pods entre zonas em uma melhor distribuição de esforço, use a [política de afinidade de pod](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature) `preferredDuringSchedulingIgnoredDuringExecution`.

**Por que eu preciso de nós do trabalhador em 3 zonas?** </br>
Distribuir sua carga de trabalho em 3 zonas assegura alta disponibilidade para seu app no caso de uma ou duas zonas não estarem disponíveis, mas também torna sua configuração de cluster mais eficiente em termos de custo. Por que isso, você pergunta? Aqui está um exemplo.

Vamos dizer que você precisa de um nó do trabalhador com 6 núcleos para manipular a carga de trabalho para seu app. Para tornar seu cluster mais disponível, você tem as opções a seguir:

- **Duplicar seus recursos em outra zona:** essa opção deixa você com 2 nós do trabalhador, cada um com 6 núcleos em cada zona, totalizando 12 núcleos. </br>
- **Distribuir recursos em 3 zonas:** com essa opção, você implementa 3 núcleos por zona, deixando-o uma capacidade total de 9 núcleos. Para manipular a sua carga de trabalho, duas zonas devem estar ativas por vez. Se uma zona estiver indisponível, as outras duas zonas poderão manipular sua carga de trabalho. Se duas zonas estiverem indisponíveis, os 3 núcleos restantes estarão ativos para manipular sua carga de trabalho. A implementação de 3 núcleos por zona significa máquinas menores e, portanto, um custo reduzido para você.</br>

**Como meu mestre do Kubernetes está configurado?** </br>
Um cluster de múltiplas zonas é configurado com um único mestre do Kubernetes que é provisionado na mesma área metropolitana que os trabalhadores. Por exemplo, se os trabalhadores estiverem em uma ou múltiplas zonas `dal10`, `dal12` ou `dal13`, o mestre estará localizado na cidade metropolitana de Dallas.

**O que acontece se o mestre do Kubernetes se torna indisponível?** </br>
O [Mestre do Kubernetes](cs_tech.html#architecture) é o componente principal que mantém seu cluster funcionando. O mestre armazena recursos de cluster e suas configurações no banco de dados etcd que serve como o ponto único de verdade para seu cluster. O servidor da API do Kubernetes é o ponto de entrada principal para todas as solicitações de gerenciamento de cluster dos nós do trabalhador para o principal ou quando você deseja interagir com os recursos de cluster.<br><br>Se ocorrer uma falha do mestre, suas cargas de trabalho continuarão a ser executadas nos nós do trabalhador, mas não será possível usar os comandos `kubectl` para trabalhar com seus recursos de cluster ou visualizar o funcionamento do cluster até que o servidor da API do Kubernetes no mestre esteja novamente ativo. Se um pod ficar inativo durante a indisponibilidade do mestre, o pod não poderá ser reprogramado até que o nó do trabalhador possa atingir o servidor da API do Kubernetes novamente.<br><br>Durante uma indisponibilidade do mestre, ainda é possível executar os comandos `ibmcloud ks` com relação à API do {{site.data.keyword.containerlong_notm}} para trabalhar com seus recursos de infraestrutura, como nós do trabalhador ou VLANs. Se você mudar a configuração de cluster atual incluindo ou removendo nós do trabalhador no cluster, suas mudanças não ocorrerão até que o mestre esteja ativo novamente. **Nota**: não reinicie ou reinicialize um nó do trabalhador durante uma indisponibilidade do mestre. Essa ação remove os pods de seu nó do trabalhador. Como o servidor da API do Kubernetes está indisponível, os pods não podem ser reprogramados em outros nós do trabalhador no cluster.


Para proteger seu cluster com relação a uma falha do mestre do Kubernetes ou em regiões onde os clusters de múltiplas zonas não estão disponíveis, é possível [configurar múltiplos clusters e conectá-los a um balanceador de carga global](#multiple_clusters).

**Eu tenho que fazer alguma coisa para que o mestre possa se comunicar com os trabalhadores entre as zonas?**</br>
Sim. Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).

**Como permitir que meus usuários acessem meu app por meio da Internet pública?**</br>
É possível expor seus apps usando um balanceador de carga do aplicativo (ALB) do Ingresso ou um serviço de balanceador de carga.

Por padrão, os ALBs públicos são criados e ativados automaticamente em cada zona em seu cluster. Um multizone load balancer (MZLB) do Cloudflare para seu cluster também é criado e implementado automaticamente para que exista 1 MZLB para cada região. O MZLB coloca os endereços IP de seus ALBs atrás do mesmo nome do host e ativa as verificações de funcionamento nesses endereços IP para determinar se elas estão disponíveis ou não. Por exemplo, se você tiver nós do trabalhador em 3 zonas na região dos Leste dos EUA, o nome do host `yourcluster.us-east.containers.appdomain.cloud` terá 3 endereços IP do ALB. O funcionamento do MZLB verifica o IP do ALB público em cada zona de uma região e mantém os resultados de consulta de DNS atualizados com base nessas verificações de funcionamento. Para obter mais informações, consulte [Componentes e arquitetura do Ingress](cs_ingress.html#planning).

Os serviços de balanceador de carga são configurados somente em uma zona. As solicitações recebidas para seu app são roteadas dessa zona para todas as instâncias do app em outras zonas. Se essa zona se tornar indisponível, seu app poderá não ser acessível por meio da Internet. É possível configurar serviços adicionais de balanceador de carga em outras zonas para considerar uma falha de zona única. Para obter mais informações, consulte [serviços de balanceador de carga](cs_loadbalancer.html#multi_zone_config) altamente disponíveis.

**Posso configurar o armazenamento persistente para o meu cluster de múltiplas zonas?**</br>
Para o armazenamento persistente altamente disponível, use um serviço de nuvem como o [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) ou [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).

O arquivo NFS e o armazenamento de bloco não são compartilháveis entre as zonas. Os volumes persistentes podem ser usados somente na zona na qual o dispositivo de armazenamento real está localizado. Se você tem armazenamento de arquivo ou de bloco do NFS existente em seu cluster que deseja continuar a usar, deve-se aplicar rótulos de região e zona aos volumes persistentes existentes. Esses rótulos ajudam o kube-scheduler a determinar onde planejar um app que usa o volume persistente. Execute o comando a seguir e substitua  `<mycluster>`  com o nome do cluster.

```
bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <mycluster>
```
{: pre}

** Eu criei meu cluster multizone. Por que ainda há somente uma zona? Como incluir zonas em meu cluster?**</br>
Se você [cria seu cluster de múltiplas zonas com a CLI](cs_clusters.html#clusters_cli), o cluster é criado, mas deve-se incluir zonas no conjunto de trabalhadores para concluir o processo. Para abranger múltiplas zonas, seu cluster deve estar em uma [cidade metropolitana de múltiplas zonas](cs_regions.html#zones). Para incluir uma zona em seu cluster e difundir os nós do trabalhador entre as zonas, consulte [Incluindo uma zona em seu cluster](cs_clusters.html#add_zone).

### Quais são algumas mudanças de como eu gerencio atualmente meus clusters?
{: #mz_new_ways}

Com a introdução de conjuntos de trabalhadores, é possível usar um novo conjunto de APIs e comandos para gerenciar seu cluster. É possível ver esses novos comandos na [página de documentação da CLI](cs_cli_reference.html#cs_cli_reference) ou em seu terminal executando `ibmcloud ks help`.

A tabela a seguir compara os métodos antigos e novos para algumas ações comuns de gerenciamento de cluster.
<table summary="A tabela mostra a descrição da nova maneira de executar comandos de múltiplas zonas. As linhas devem ser lidas da esquerda para a direita, com a descrição na coluna um, a maneira antiga na coluna dois e a maneira nova de múltiplas zonas na coluna três.">
<caption>Novos métodos para comandos do conjunto de trabalhadores de múltiplas zonas.</caption>
  <thead>
  <th>Descrição</th>
  <th>Nós do trabalhador independente antigo</th>
  <th>Novos conjuntos de trabalhadores multizados</th>
  </thead>
  <tbody>
    <tr>
    <td>Inclua nós do trabalhador no cluster.</td>
    <td><strong>Descontinuado</strong>: <code>ibmcloud ks worker-add</code> para incluir nós do trabalhador independentes.</td>
    <td><ul><li>Para incluir tipos de máquina diferentes de seu conjunto existente, crie um novo conjunto de trabalhadores: [comando](cs_cli_reference.html#cs_worker_pool_create) <code>ibmcloud ks worker-pool-create</code>.</li>
    <li>Para incluir nós do trabalhador em um conjunto existente, redimensione o número de nós por zona no conjunto: [comando](cs_cli_reference.html#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code>.</li></ul></td>
    </tr>
    <tr>
    <td>Remover nós do trabalhador do cluster.</td>
    <td><code>ibmcloud ks worker-rm</code>, que ainda é possível usar para excluir um nó do trabalhador problemático de seu cluster.</td>
    <td><ul><li>Se o seu conjunto de trabalhadores estiver desbalanceado, por exemplo, depois de remover um nó do trabalhador, rebalance-o: [comando](cs_cli_reference.html#cs_rebalance) <code>ibmcloud ks worker-pool-rebalance</code>.</li>
    <li>Para reduzir o número de nós do trabalhador em um conjunto, redimensione o número por zona (valor mínimo de 1): [comando](cs_cli_reference.html#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code>.</li></ul></td>
    </tr>
    <tr>
    <td>Use uma nova VLAN para os nós do trabalhador.</td>
    <td><strong>Descontinuado</strong>: inclua um novo nó do trabalhador que use a nova VLAN privada ou pública: <code>ibmcloud ks worker-add</code>.</td>
    <td>Configure o conjunto de trabalhadores para usar uma VLAN pública ou privada diferente do que ele usou anteriormente: [comando](cs_cli_reference.html#cs_zone_network_set) <code>ibmcloud ks zone-network-network-set</code>.</td>
    </tr>
  </tbody>
  </table>

## Múltiplos clusters conectados a um balanceador de carga global
{: #multiple_clusters}

Para proteger o seu app de uma falha do mestre do Kubernetes ou para regiões nas quais clusters de múltiplas zonas não estão disponíveis, é possível criar múltiplos clusters em zonas diferentes dentro de uma região e conectá-los a um balanceador de carga global.
{: shortdesc}

<img src="images/cs_multiple_cluster_zones.png" alt="High availability for multiple clusters" width="700" style="width:700px; border-style: none"/>

Para balancear sua carga de trabalho entre múltiplos clusters, deve-se configurar um balanceador de carga global e incluir os endereços IP de seus balanceadores de carga do aplicativo (ALBs) ou serviços de balanceador de carga em seu domínio. Incluindo esses endereços IP, é possível rotear o tráfego recebido entre os seus clusters. Para que o balanceador de carga global detecte se um de seus clusters está indisponível, considere incluir uma verificação de funcionamento baseada em ping em cada endereço IP. Ao configurar essa verificação, seu provedor DNS faz regularmente os pings dos endereços IP que você incluiu em seu domínio. Se um endereço IP se tornar indisponível, o tráfego não será mais enviado para esse endereço IP. No entanto, o Kubernetes não reinicializa automaticamente os pods do cluster indisponível nos nós do trabalhador em clusters disponíveis. Se você deseja que o Kubernetes reinicie automaticamente os pods em clusters disponíveis, considere configurar um [cluster de múltiplas zonas](#multizone).

**Por que eu preciso de 3 clusters em 3 zonas?** </br>
Semelhante ao uso de [3 zonas em um cluster de múltiplas zonas](#multizone), é possível fornecer mais disponibilidade para o seu app configurando 3 clusters entre zonas. Também é possível reduzir os custos, comprando máquinas menores para manipular sua carga de trabalho.

**E se eu desejar configurar múltiplos clusters entre regiões?** </br>
É possível configurar múltiplos clusters em diferentes regiões de uma localização geográfica (como o Sul dos EUA e o Leste dos EUA) ou entre as localizações geográficas (como o Sul dos EUA e a Central da UE). Ambas as configurações oferecem o mesmo nível de disponibilidade para seu app, mas também incluem a complexidade quando se trata de compartilhamento de dados e replicação de dados. Para a maioria dos casos, permanecer dentro da mesma localização geográfica é suficiente. Mas se você tiver usuários ao redor do mundo, poderá ser melhor configurar um cluster no local em que os seus usuários estiverem, de maneira que os usuários não experienciem tempos de espera longos quando enviarem uma solicitação ao seu app.

**Para configurar um balanceador de carga global para múltiplos clusters:**

1. [Crie clusters](cs_clusters.html#clusters) em múltiplas zonas ou regiões.
2. Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).
3. Em cada cluster, exponha seu app usando um [balanceador de carga do aplicativo (ALB)](cs_ingress.html#ingress_expose_public) ou um [serviço de balanceador de carga](cs_loadbalancer.html#config).
4. Para cada cluster, liste os endereços IP públicos para os seus ALBs ou serviços de balanceador de carga.
   - Para listar o endereço IP de todos os ALBs ativados públicos em seu cluster:
     ```
     ibmcloud ks albs --cluster <cluster_name_or_id>
     ```
     {: pre}

   - Para listar o endereço IP para o seu serviço de balanceador de carga:
     ```
     kubectl describe service <myservice>
     ```
     {: pre}

     O endereço IP do **Ingresso do balanceador de carga** é o endereço IP móvel que foi designado a seu serviço de balanceador de carga.

4.  Configure um balanceador de carga global usando o {{site.data.keyword.Bluemix_notm}} Internet Services (CIS) ou configure seu próprio balanceador de carga global.

    **Para usar um balanceador de carga global do CIS**:
    1.  Configure o serviço seguindo as etapas 1 - 4 em [Introdução ao {{site.data.keyword.Bluemix_notm}} Internet Services (CIS)](/docs/infrastructure/cis/getting-started.html#getting-started-with-ibm-cloud-internet-services-cis-).
        *  As etapas 1 a 3 guiam você passo a passo pelo fornecimento da instância de serviço, incluindo seu domínio do app e configurando seus servidores de nomes.
        * A etapa 4 guia você passo a passo pela criação de registros do DNS. Crie um registro de DNS para cada ALB ou endereço IP do balanceador de carga que você coletou. Esses registros do DNS mapeiam seu domínio de app para todos os ALBs ou balanceadores de carga do cluster e asseguram que as solicitações para seu domínio de app sejam encaminhadas para seus clusters em um ciclo round-robin.
    2. [Inclua verificações de funcionamento](/docs/infrastructure/cis/glb-setup.html#add-a-health-check) para os ALBs ou balanceadores de carga. É possível usar a mesma verificação de funcionamento para os ALBs ou balanceadores de carga em todos os seus clusters ou criar verificações de funcionamento específicas para usar para clusters específicos.
    3. [Inclua um conjunto de origem](/docs/infrastructure/cis/glb-setup.html#add-a-pool) para cada cluster incluindo os IPs do ALB ou do balanceador de carga do cluster. Por exemplo, se você tiver 3 clusters que cada um tenha 2 ALBs, crie 3 conjuntos de origem que cada um tenha 2 endereços IP de ALB. Inclua uma verificação de funcionamento em cada conjunto de origem que você criar.
    4. [ Inclua um balanceador de carga global ](/docs/infrastructure/cis/glb-setup.html#set-up-and-configure-your-load-balancers).

    **Para usar seu próprio balanceador de carga global**:
    1. Configure seu domínio para rotear o tráfego recebido para seu ALB ou serviços de balanceador de carga, incluindo os endereços IP de todos os ALBs ativados públicos e serviços de balanceador de carga para seu domínio.
    2. Para cada endereço IP, ative uma verificação de funcionamento baseada em ping para que seu provedor DNS possa detectar endereços IP não funcionais. Se um endereço IP não funcional for detectado, o tráfego não será mais roteado para esse endereço IP.

## Clusters privados
{: #private_clusters}

Por padrão, o {{site.data.keyword.containerlong_notm}} configura seu cluster com acesso a uma VLAN privada e a uma VLAN pública. A VLAN privada determina o endereço IP privado que é designado a cada nó do trabalhador, que fornece cada nó do trabalhador com uma interface de rede privada. A VLAN pública permite que os nós do trabalhador se conectem de forma automática e segura ao mestre.


Se você deseja criar um cluster que tenha acesso somente a uma VLAN privada, é possível criar um cluster privado de zona única ou de múltiplas zonas. No entanto, quando os nós do trabalhador estão conectados somente a uma VLAN privada, os nós do trabalhador não podem se conectar automaticamente ao mestre. Deve-se configurar um dispositivo de gateway para fornecer conectividade de rede entre os nós do trabalhador e o mestre.
**Nota**: não é possível converter um cluster que está conectado a uma VLAN pública e privada para se tornar um cluster somente privado. A remoção de todas as VLANs públicas de um cluster faz com que diversos componentes do cluster parem de funcionar. Deve-se criar um novo cluster usando as etapas a seguir.

Se você deseja criar um cluster que tenha acesso somente a uma VLAN privada:

1.  Revise  [ Planejando a rede do cluster somente privado ](cs_network_planning.html#private_vlan)
2.  Configure seu dispositivo de gateway para conectividade de rede. Observe que é necessário [abrir as portas e os endereços IP necessários](cs_firewall.html#firewall_outbound) em seu firewall e [ativar o VLAN Spanning ](cs_subnets.html#vra-routing) para as sub-redes.
3.  [Crie um cluster usando a CLI](cs_clusters.html#clusters_cli), incluindo a sinalização `--private-only`.
4.  Se você deseja expor um app a uma rede privada usando um serviço privado NodePort, LoadBalancer ou Ingress, revise [Planejando a rede externa privada para uma configuração somente de VLAN privada](cs_network_planning.html#private_vlan). O serviço é acessível somente no endereço IP privado e deve-se configurar as portas em seu firewall para usar o endereço IP privado.


## Conjuntos do Trabalhador e nós do trabalhador
{: #planning_worker_nodes}

Um cluster do Kubernetes consiste em nós do trabalhador que são agrupados em conjuntos de nós do trabalhador e são monitorados e gerenciados centralmente pelo mestre do Kubernetes. Os administradores de cluster decidem como configurar o cluster de nós do trabalhador para assegurar que os usuários do cluster tenham todos os recursos para implementar e executar apps no cluster.
{:shortdesc}

Ao criar um cluster padrão, os nós do trabalhador com as mesmas especificações (tipo) de memória, CPU e espaço em disco são solicitados na infraestrutura do IBM Cloud (SoftLayer) em seu nome e incluídos no conjunto de nós do trabalhador padrão em seu cluster. A cada nó do trabalhador é designado
um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados após a criação do cluster. É possível escolher entre servidores virtuais ou físicos (bare metal). Dependendo do nível de isolamento de hardware escolhido, os nós do trabalhador virtual podem ser configurados como nós compartilhados ou dedicados. Para incluir diferentes tipos em seu cluster, [crie outro conjunto de trabalhadores](cs_cli_reference.html#cs_worker_pool_create).

O Kubernetes limita o número máximo de nós do trabalhador que você pode ter em um cluster. Revise [cotas de nó do trabalhador e de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/setup/cluster-large/) para obter mais informações.



## Hardware disponível para nós do trabalhador
{: #shared_dedicated_node}

Ao criar um cluster padrão no {{site.data.keyword.Bluemix_notm}}, você escolhe se os conjuntos de trabalhadores consistem em nós do trabalhador que são máquinas físicas (bare metal) ou máquinas virtuais que são executadas em hardware físico. Você também seleciona o tipo de nó do trabalhador ou a combinação de memória, CPU e outras especificações de máquina, como armazenamento em disco.
{:shortdesc}

![Opções de hardware para nós do trabalhador em um cluster padrão](images/cs_clusters_hardware.png)

Se você deseja mais de um tipo de nó do trabalhador, deve-se criar um conjunto de trabalhadores para cada tipo. Ao criar um cluster grátis, seu nó do trabalhador é provisionado automaticamente como um nó virtual compartilhado na conta de infraestrutura do IBM Cloud (SoftLayer). Conforme você planejar, considere o [limite mínimo do limite de nós do trabalhador](#resource_limit_node) de 10% de capacidade de memória total.

É possível implementar clusters usando a [UI do console](cs_clusters.html#clusters_ui) ou a [CLI](cs_clusters.html#clusters_cli).

Selecione uma das opções a seguir para decidir qual tipo de conjunto de trabalhadores você deseja.
* [Máquinas virtuais](#vm)
* [Máquinas físicas (bare metal)](#bm)
* [Máquinas de armazenamento definido pelo software (SDS)](#sds)

### Máquinas virtuais
{: #vm}

Com as VMs, você tem maior flexibilidade, tempos de fornecimento mais rápidos e recursos de escalabilidade mais automáticos do que o bare metal, com custo reduzido. É possível usar as VMs para casos de uso de propósitos mais gerais, como ambientes de teste e desenvolvimento, ambientes de preparação e produção, microsserviços e apps de negócios. No entanto, há alternativas no desempenho. Se você precisar de computação de alto desempenho para cargas de trabalho com uso intensivo de RAM, dados ou GPU, use [bare metal](#bm).
{: shortdesc}

**Deseja usar hardware compartilhado ou dedicado?**</br>
Ao criar um cluster virtual padrão, deve-se escolher se deseja que o hardware subjacente seja compartilhado por múltiplos clientes {{site.data.keyword.IBM_notm}} (ocupação variada) ou seja dedicado somente a você (ocupação única).

* **Em uma configuração de hardware compartilhado de diversos locatários**: os recursos físicos, como CPU e memória, são compartilhados entre todas as máquinas virtuais que são implementadas no mesmo hardware físico. Para assegurar que cada máquina
virtual possa ser executada independentemente, um monitor de máquina virtual, também referido como hypervisor,
segmenta os recursos físicos em entidades isoladas e aloca como recursos dedicados para
uma máquina virtual (isolamento de hypervisor).
* **Em uma configuração de hardware dedicado de locatário único**: todos os recursos físicos são dedicados somente a você. É possível implementar
múltiplos nós do trabalhador como máquinas virtuais no mesmo host físico. Semelhante à configuração de diversos locatários,
o hypervisor assegura que cada nó do trabalhador obtenha seu compartilhamento dos recursos físicos
disponíveis.

Os nós compartilhados são geralmente menos dispendiosos que os nós dedicados porque os custos para o hardware subjacente são compartilhados entre múltiplos clientes. No entanto, ao decidir entre nós compartilhados
e dedicados, você pode desejar verificar com seu departamento jurídico para discutir o nível de isolamento
e conformidade de infraestrutura que seu ambiente de app requer.

**Quais são os recursos gerais de VMs?**</br>
As máquinas virtuais usam o disco local em vez da rede de área de armazenamento (SAN) para confiabilidade. Os benefícios de confiabilidade incluem maior rendimento ao serializar bytes para o disco local e a degradação do sistema de arquivos reduzido devido a falhas de rede. Cada MV vem com velocidade de rede 1000 Mbps, 25 GB de armazenamento em disco local primário para o sistema de arquivos do S.O. e 100 GB de armazenamento em disco local secundário para dados, como o tempo de execução do contêiner e o `kubelet`.

**E se eu tiver descontinuado os tipos de máquina `u1c` ou `b1c`?**</br>
Para começar a usar os tipos de máquina `u2c` e `b2c`, [atualize os tipos de máquina incluindo nós do trabalhador](cs_cluster_update.html#machine_type).

** Quais tipos de máquina virtual estão disponíveis? **</br>
Tipos de máquina variam por zona. Para ver os tipos de máquina disponíveis em sua zona, execute `ibmcloud ks machine-types <zone>`. Também é possível revisar os tipos de máquina [bare metal](#bm) ou [SDS](#sds) disponíveis.

<table>
<caption>Tipos de máquina virtual disponíveis no  {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Caso Nome e uso</th>
<th>Núcleos / Memória</th>
<th>Disco Primário / Secundário</th>
<th>Velocidade</th>
</thead>
<tbody>
<tr>
<td><strong>Virtual, u2c.2x4</strong>: use essa VM de menor tamanho para teste rápido, provas de conceito e outras cargas de trabalho leves.</td>
<td>2 / 4GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.4x16</strong>: selecione essa VM balanceada para teste e desenvolvimento e outras cargas de trabalho leves.</td>
<td>4 / 16GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.16x64</strong>: selecione essa VM balanceada para cargas de trabalho de médio porte.</td></td>
<td>16 / 64GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.32x128</strong>: selecione essa VM balanceada para cargas de trabalho de médio a grande porte, como um banco de dados e um website dinâmico com vários usuários simultâneos.</td></td>
<td>32 / 128GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.56x242</strong>: selecione essa VM balanceada para cargas de trabalho grandes, como um banco de dados e múltiplos apps com muitos usuários simultâneos.</td></td>
<td>56 / 242GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, c2c.16x16</strong>: use esse tipo quando desejar um saldo equilibrado de recursos de cálculo do nó do trabalhador para cargas de trabalho leves.</td></td>
<td>16 / 16GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.16x32</strong>: use esse tipo quando desejar um saldo próximo de recursos de CPU e memória do nó do trabalhador para cargas de trabalho de leve a médio porte.</td></td>
<td>16 / 32GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.32x32</strong>: use esse tipo quando desejar um saldo equilibrado de recursos de cálculo do nó do trabalhador para cargas de trabalho de médio porte.</td></td>
<td>32 / 32 GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.32x64</strong>: use esse tipo quando desejar um saldo próximo de recursos de CPU e memória do nó do trabalhador para cargas de trabalho de médio porte.</td></td>
<td>16 / 16GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
</tbody>
</table>

### Máquinas físicas (bare metal)
{: #bm}

É possível provisionar o nó do trabalhador como um servidor físico de único locatário, também referido como bare metal.
{: shortdesc}

**Como o bare metal é diferente de VMs?**</br>
O bare metal dá acesso direto aos recursos físicos na máquina, como a memória ou CPU. Essa configuração elimina o hypervisor da máquina virtual que aloca recursos físicos para máquinas virtuais executadas no host. Em vez disso, todos os recursos de uma máquina bare metal são dedicados exclusivamente ao trabalhador, portanto, você não precisará se preocupar com "vizinhos barulhentos" compartilhando recursos ou diminuindo o desempenho. Os tipos de máquina física têm mais armazenamento local do que virtual e alguns têm RAID para fazer backup de dados locais.

**Além de melhores especificações para desempenho, posso fazer algo com bare metal que eu não posso com VMs?**</br>
Sim. Com bare metal, você tem a opção de ativar o Cálculo Confiável para verificar seus nós do trabalhador com relação à violação. Se você não ativar a confiança durante a criação do cluster, mas desejar posteriormente, será possível usar o comando `ibmcloud ks feature-enable` [](cs_cli_reference.html#cs_cluster_feature_enable). Depois de ativar a confiança, não é possível desativá-la posteriormente. É possível fazer um novo cluster sem confiança. Para obter mais informações sobre como a confiança funciona durante o processo de inicialização do nó, veja [{{site.data.keyword.containerlong_notm}} com Cálculo confiável](cs_secure.html#trusted_compute). O Cálculo confiável está disponível em clusters que executam o Kubernetes versão 1.9 ou mais recente e têm determinados tipos de máquina bare metal. Quando você executa o [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types <zone>`, é possível ver quais máquinas suportam confiança revisando o campo **Confiável**. Por exemplo, os tipos GPU `mgXc` não suportam o Cálculo confiável.

** Bare metal parece incrível! O que está me impedindo de pedir um agora?**</br>
Os servidores bare metal são mais caros do que os servidores virtuais e são mais adequados para apps de alto desempenho que precisam de mais recursos e controle de host. 

**Importante**: os servidores bare metal são faturados mensalmente. Se você cancelar um servidor bare metal antes do final do mês, será cobrado até o final do mês. Ordenar e cancelar servidores bare metal é um processo manual por meio da sua conta de infraestrutura (SoftLayer) do IBM Cloud. Pode levar mais de um dia útil para serem concluídos.

**Que tipos de bare metal posso pedir?**</br>
Tipos de máquina variam por zona. Para ver os tipos de máquina disponíveis em sua zona, execute `ibmcloud ks machine-types <zone>`. Também é possível revisar os tipos de máquina [VM](#vm) ou [SDS](#sds) disponíveis.

As máquinas bare metal são otimizadas para diferentes casos de uso, como cargas de trabalho intensivas de RAM, de dados ou de GPU.

Escolha um tipo de máquina com a configuração de armazenamento correta para suportar sua carga de trabalho. Alguns tipos têm uma combinação dos discos e configurações de armazenamento a seguir. Por exemplo, alguns tipos podem ter um disco primário SATA com um disco secundário SSD bruto.

* **SATA**: um dispositivo de armazenamento em disco de rotação magnética que é usado frequentemente para o disco primário do nó do trabalhador que armazena o sistema de arquivos de S.O.
* **SSD**: um dispositivo de armazenamento de unidade de estado sólido para dados de alto desempenho.
* **Bruto**: o dispositivo de armazenamento não está formatado, com a capacidade total disponível para uso.
* **RAID**: o dispositivo de armazenamento tem dados distribuídos para redundância e desempenho que variam dependendo do nível do RAID. Como tal, a capacidade do disco que está disponível para uso varia.


<table>
<caption>Tipos de máquina bare metal disponíveis no  {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Caso Nome e uso</th>
<th>Núcleos / Memória</th>
<th>Disco Primário / Secundário</th>
<th>Velocidade</th>
</thead>
<tbody>
<tr>
<td><strong>Bare metal com uso intensivo de RAM, mr1c.28x512</strong>: maximize a RAM disponível para os nós do trabalhador.</td>
<td>28 / 512GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal GPU, mg1c.16x128</strong>: escolha esse tipo para cargas de trabalho matematicamente intensivas, como aplicativos de cálculo de alto desempenho, aprendizado de máquina ou 3D. Esse tipo tem 1 cartão físico Tesla K80 com 2 unidades de processamento de gráfico (GPUs) por cartão para um total de 2 GPUs.</td>
<td>16 / 128GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal GPU, mg1c.28x256</strong>: escolha esse tipo para cargas de trabalho matematicamente intensivas, como aplicativos de cálculo de alto desempenho, aprendizado de máquina ou 3D. Esse tipo tem 2 cartões físicos Tesla K80 com 2 GPUs por cartão para um total de 4 GPUs.</td>
<td>28 / 256GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal com uso intensivo de dados, md1c.16x64.4x4tb</strong>: para uma quantia significativa de armazenamento em disco local, incluindo RAID para fazer backup de dados que são armazenados localmente na máquina. Use para casos como sistemas de arquivo distribuído, bancos de dados grandes e cargas de trabalho de análise de Big Data.</td>
<td>16 / 64GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal com uso intensivo de dados, md1c.28x512.4x4tb</strong>: para uma quantia significativa de armazenamento em disco local, incluindo RAID para fazer backup de dados que são armazenados localmente na máquina. Use para casos como sistemas de arquivo distribuído, bancos de dados grandes e cargas de trabalho de análise de Big Data.</td>
<td>28 / 512 GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal balanceado, mb1c.4x32</strong>: use para cargas de trabalho balanceadas que requerem mais recursos de cálculo do que as máquinas virtuais oferecem.</td>
<td>4 / 32GB</td>
<td>2TB SATA / 2TB SATA</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal balanceado, mb1c.16x64</strong>: use para cargas de trabalho balanceadas que requerem mais recursos de cálculo do que as máquinas virtuais oferecem.</td>
<td>16 / 64GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
</tbody>
</table>

### Máquinas de armazenamento definido pelo software (SDS)
{: #sds}

Os tipos de software-defined storage (SDS) são máquinas físicas provisionadas com um disco bruto para armazenamento local físico. Como os dados são localizados juntamente com o nó de cálculo, as máquinas SDS são adequadas para cargas de trabalho de alto desempenho.
{: shortdesc}

** Quando uso os sabores SDS? **</br>
Você normalmente usa máquinas SDS nos casos a seguir:
*  Se você usa um complemento SDS para o cluster, deve-se usar uma máquina SDS.
*  Se seu app é um [StatefulSet ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) que requer armazenamento local, é possível usar máquinas SDS e provisionar [volumes persistentes locais do Kubernetes (beta) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/blog/2018/04/13/local-persistent-volumes-beta/).
*  Você pode ter aplicativos customizados ou complementos de cluster que requerem armazenamento SDS ou local. Por exemplo, se você planeja usar logDNA, deve-se usar um tipo de máquina SDS.

** Quais tipos de SDS posso pedir? **</br>
Tipos de máquina variam por zona. Para ver os tipos de máquina disponíveis em sua zona, execute `ibmcloud ks machine-types <zone>`. Também é possível revisar os tipos de máquina [bare metal](#bm) ou [VM](#vm) disponíveis.

Escolha um tipo de máquina com a configuração de armazenamento correta para suportar sua carga de trabalho. Alguns tipos têm uma combinação dos discos e configurações de armazenamento a seguir. Por exemplo, alguns tipos podem ter um disco primário SATA com um disco secundário SSD bruto.

* **SATA**: um dispositivo de armazenamento em disco de rotação magnética que é usado frequentemente para o disco primário do nó do trabalhador que armazena o sistema de arquivos de S.O.
* **SSD**: um dispositivo de armazenamento de unidade de estado sólido para dados de alto desempenho.
* **Bruto**: o dispositivo de armazenamento não está formatado, com a capacidade total disponível para uso.
* **RAID**: o dispositivo de armazenamento tem dados distribuídos para redundância e desempenho que variam dependendo do nível do RAID. Como tal, a capacidade do disco que está disponível para uso varia.


<table>
<caption>Tipos de máquina SDS disponíveis no  {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Caso Nome e uso</th>
<th>Núcleos / Memória</th>
<th>Disco Primário / Secundário</th>
<th>Armazenamento local</th>
<th>Velocidade</th>
</thead>
<tbody>
<tr>
<td><strong>Bare metal com SDS, ms2c.28x256.3.8tb.ssd</strong>: se você precisar de armazenamento local extra para o desempenho, use esse tipo de disco pesado que suporte software-defined storage (SDS).</td>
<td>28 / 256GB</td>
<td>2TB SATA / 1.9TB SSD</td>
<td>3.8TB Raw SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal com SDS, ms2c.28x512.4x3.8tb.ssd</strong>: se você precisar de armazenamento local extra para o desempenho, use esse tipo de disco pesado que suporte o software-defined storage (SDS).</td>
<td>28 / 512GB</td>
<td>2TB SATA / 1.9TB SSD</td>
<td>4 discos, 3.8TB Raw SSD</td>
<td>10000Mbps</td>
</tr>
</tbody>
</table>

## Limites de memória do nó do trabalhador
{: #resource_limit_node}

O {{site.data.keyword.containerlong_notm}} configura um limite de memória em cada nó do trabalhador. Quando os pods que estão em execução no nó do trabalhador excedem esse limite de memória, os pods são removidos. No Kubernetes, esse limite é chamado de [limite máximo de despejo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

Se os pods são removidos frequentemente, inclua mais nós do trabalhador em seu cluster ou configure [limites de recursos ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) em seu pods.

**Cada máquina tem um limite mínimo que equivale a 10% de sua capacidade de memória total**. Quando há menos memória disponível no nó do trabalhador do que o limite mínimo que é permitido, o Kubernetes remove imediatamente o pod. O pod reagenda em outro nó do trabalhador se um nó do trabalhador está disponível. Por exemplo, se você tem uma máquina virtual `b2c.4x16`, sua capacidade de memória total é 16 GB. Se menos que 1600 MB (10%) de memória estiver disponível, novos pods não poderão ser planejados nesse nó do trabalhador, mas, como alternativa, serão planejados em outro nó do trabalhador. Se nenhum outro nó do trabalhador estiver disponível, os novos pods permanecerão não planejados.

Para revisar quanta memória é usada em seu nó do trabalhador, execute [`kubectl top node ` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/#top).

## Recuperação automática para seus nós do trabalhador
{: #autorecovery}

Componentes críticos, como `containerd`, `kubelet`, `kube-proxy` e `calico`, devem ser funcionais para ter um nó do trabalhador Kubernetes funcional. Com o tempo, esses componentes podem se dividir e podem deixar o nó do trabalhador em um estado não funcional. Os nós do trabalhador não funcionais diminuem a capacidade total do cluster e podem resultar em tempo de inatividade para seu app.
{:shortdesc}

É possível [configurar verificações de funcionamento para seu nó do trabalhador e ativar a Recuperação automática](cs_health.html#autorecovery). Se a Recuperação automática detecta um nó do trabalhador não funcional com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Para obter mais informações sobre como a Recuperação automática funciona, veja o [blog de Recuperação automática ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).

<br />

