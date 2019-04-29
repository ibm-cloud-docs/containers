---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, multi az, multi-az, szr, mzr

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



# Planejando a configuração do seu cluster e do nó do trabalhador
{: #plan_clusters}
Projete seu cluster padrão para máxima disponibilidade e capacidade para seu app com o {{site.data.keyword.containerlong}}.
{: shortdesc}

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

Por padrão, seu cluster de zona única está configurado com um conjunto de trabalhadores denominado `default`. O conjunto de trabalhadores agrupa nós do trabalhador com a mesma configuração, tal como o tipo de máquina, que você definiu durante a criação do cluster. É possível incluir mais nós do trabalhador em seu cluster [redimensionando um conjunto de trabalhadores existente](/docs/containers?topic=containers-clusters#resize_pool) ou [incluindo um novo conjunto de trabalhadores](/docs/containers?topic=containers-clusters#add_pool).

Ao incluir mais nós do trabalhador, as instâncias do app podem ser distribuídas entre múltiplos nós do trabalhador. Se um nó do trabalhador ficar inativo, as instâncias do app em nós do trabalhador disponíveis continuarão a ser executadas. O Kubernetes reagenda automaticamente os pods de nós do trabalhador indisponíveis para assegurar desempenho e capacidade para seu app. Para assegurar que os seus pods sejam distribuídos de maneira uniforme entre os nós do trabalhador, implemente a [afinidade de pod](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature).

**Posso converter meu cluster de zona única em um cluster de múltiplas zonas?**</br>
Se o cluster estiver em uma das [cidades metropolitanas de multizona suportadas](/docs/containers?topic=containers-regions-and-zones#zones), sim. Consulte [Atualizando de nós do trabalhador independentes para conjuntos de trabalhadores](/docs/containers?topic=containers-update#standalone_to_workerpool).


**Eu tenho que usar clusters de múltiplas zonas?**</br>
Não. É possível criar tantos clusters de zona única quantos você desejar. De fato, você pode preferir clusters de zona única para gerenciamento simplificado ou se o seu cluster deve residir em uma [cidade de zona única](/docs/containers?topic=containers-regions-and-zones#zones) específica.

**Posso ter um mestre altamente disponível em uma única zona?**</br>
Sim, com clusters que executam o Kubernetes versão 1.10 ou mais recente. Em uma única zona, o seu mestre está altamente disponível e inclui réplicas em hosts físicos separados para seu servidor de API do Kubernetes, um etcd, um planejador e um gerenciador de controlador para proteger contra uma indisponibilidade, como durante uma atualização principal. Para proteger contra uma falha zonal, é possível:
* [criar um cluster em uma zona com capacidade para várias zonas](/docs/containers?topic=containers-plan_clusters#multizone), em que o mestre seja distribuído entre zonas.
* [criar múltiplos clusters](#multiple_clusters) e conectá-los a um balanceador de carga global.

## Cluster de múltiplas zonas
{: #multizone}

Com o  {{site.data.keyword.containerlong}}, é possível criar clusters multizona. Seus usuários são menos propensos a experienciar o tempo de inatividade quando você distribui seus apps em múltiplos nós do trabalhador e zonas usando um conjunto de trabalhadores. Os recursos integrados, como balanceamento de carga, aumentam a resiliência com relação a potenciais falhas de zona com hosts, redes ou apps. Se os recursos em uma zona ficam inativos, as cargas de trabalho do cluster ainda operam nas outras zonas. **Nota**: somente clusters de zona única estão disponíveis para as instâncias do {{site.data.keyword.Bluemix_dedicated_notm}}.
{: shortdesc}

** O que é um conjunto de trabalhadores? **</br>
Um conjunto de trabalhadores é uma coleção de nós do trabalhador com o mesmo tipo, como o tipo de máquina, a CPU e a memória. Quando você cria um cluster, um conjunto de trabalhadores padrão é criado automaticamente. Para difundir os nós do trabalhador em seu conjunto nas zonas, incluir nós do trabalhador no conjunto ou atualizar nós do trabalhador, é possível usar os novos comandos `ibmcloud ks worker-pool`.

**Ainda posso usar nós do trabalhador independentes?**</br>
A configuração de cluster anterior de nós do trabalhador independentes é suportada, mas descontinuada. Certifique-se de [incluir um conjunto de trabalhadores em seu cluster](/docs/containers?topic=containers-clusters#add_pool) e, em seguida, [usar os conjuntos de trabalhadores](/docs/containers?topic=containers-update#standalone_to_workerpool) para organizar os nós do trabalhador em vez de nós do trabalhador independentes.

**Posso converter meu cluster de zona única em um cluster de múltiplas zonas?**</br>
Se o cluster estiver em uma das [cidades metropolitanas de multizona suportadas](/docs/containers?topic=containers-regions-and-zones#zones), sim. Consulte [Atualizando de nós do trabalhador independentes para conjuntos de trabalhadores](/docs/containers?topic=containers-update#standalone_to_workerpool).


### Conte-me mais sobre a configuração do cluster de múltiplas zonas
{: #mz_setup}

<img src="images/cs_cluster_multizone-ha.png" alt="Alta disponibilidade para clusters de várias zonas" width="500" style="width:500px; border-style: none"/>

É possível incluir zonas adicionais em seu cluster para replicar os nós do trabalhador em seus conjuntos de trabalhadores em múltiplas zonas dentro de uma região. Os clusters de múltiplas zonas são projetados para planejar uniformemente os pods em nós do trabalhador e zonas para assegurar disponibilidade e recuperação de falha. Se os nós do trabalhador não forem difundidos uniformemente entre as zonas ou se houver capacidade insuficiente em uma das zonas, o planejador do Kubernetes poderá falhar ao planejar todos os pods solicitados. Como resultado, os pods podem entrar em um estado **Pendente** até que capacidade suficiente esteja disponível. Se você desejar mudar o comportamento padrão para fazer o planejador do Kubernetes distribuir os pods entre zonas em uma melhor distribuição de esforço, use a [política de afinidade de pod](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature) `preferredDuringSchedulingIgnoredDuringExecution`.

**Por que eu preciso de nós do trabalhador em 3 zonas?** </br>
Distribuir sua carga de trabalho em 3 zonas assegura alta disponibilidade para seu app no caso de uma ou duas zonas não estarem disponíveis, mas também torna sua configuração de cluster mais eficiente em termos de custo. Por que isso, você pergunta? Aqui está um exemplo.

Vamos dizer que você precisa de um nó do trabalhador com 6 núcleos para manipular a carga de trabalho para seu app. Para tornar seu cluster mais disponível, você tem as opções a seguir:

- **Duplicar seus recursos em outra zona:** essa opção deixa você com 2 nós do trabalhador, cada um com 6 núcleos em cada zona, totalizando 12 núcleos. </br>
- **Distribuir recursos em 3 zonas:** com essa opção, você implementa 3 núcleos por zona, deixando-o uma capacidade total de 9 núcleos. Para manipular a sua carga de trabalho, duas zonas devem estar ativas por vez. Se uma zona estiver indisponível, as outras duas zonas poderão manipular sua carga de trabalho. Se duas zonas estiverem indisponíveis, os 3 núcleos restantes estarão ativos para manipular sua carga de trabalho. A implementação de 3 núcleos por zona significa máquinas menores e, portanto, um custo reduzido para você.</br>

**Como meu mestre do Kubernetes está configurado?** </br>
Se você criar um cluster de múltiplas zonas em [selecionar cidades metropolitanas com múltiplas zonas](/docs/containers?topic=containers-regions-and-zones#zones), um mestre do Kubernetes altamente disponível será implementado automaticamente e três réplicas serão difundidas pelas zonas metropolitanas. Por exemplo, se o cluster estiver nas zonas `dal10`, `dal12`ou `dal13`, as réplicas do mestre Kubernetes serão difundidas em cada zona no metropolitano de Dallas multizone.

**O que acontece se o mestre do Kubernetes se torna indisponível?** </br>
O [Mestre do Kubernetes](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture) é o componente principal que mantém seu cluster funcionando. O mestre armazena recursos de cluster e suas configurações no banco de dados etcd que serve como o ponto único de verdade para seu cluster. O servidor da API do Kubernetes é o ponto de entrada principal para todas as solicitações de gerenciamento de cluster dos nós do trabalhador para o principal ou quando você deseja interagir com os recursos de cluster.<br><br>Se ocorrer uma falha do mestre, suas cargas de trabalho continuarão a ser executadas nos nós do trabalhador, mas não será possível usar os comandos `kubectl` para trabalhar com seus recursos de cluster ou visualizar o funcionamento do cluster até que o servidor da API do Kubernetes no mestre esteja novamente ativo. Se um pod ficar inativo durante a indisponibilidade do mestre, o pod não poderá ser reprogramado até que o nó do trabalhador possa atingir o servidor da API do Kubernetes novamente.<br><br>Durante uma indisponibilidade do mestre, ainda é possível executar os comandos `ibmcloud ks` com relação à API do {{site.data.keyword.containerlong_notm}} para trabalhar com seus recursos de infraestrutura, como nós do trabalhador ou VLANs. Se você mudar a configuração de cluster atual incluindo ou removendo nós do trabalhador no cluster, suas mudanças não ocorrerão até que o mestre esteja ativo novamente.

Não reinicie ou reinicialize um nó do trabalhador durante uma indisponibilidade do mestre. Essa ação remove os pods de seu nó do trabalhador. Como o servidor da API do Kubernetes está indisponível, os pods não podem ser reprogramados em outros nós do trabalhador no cluster.
{: important}


Para proteger seu cluster com relação a uma falha do mestre do Kubernetes ou em regiões onde os clusters de múltiplas zonas não estão disponíveis, é possível [configurar múltiplos clusters e conectá-los a um balanceador de carga global](#multiple_clusters).

**Eu tenho que fazer alguma coisa para que o mestre possa se comunicar com os trabalhadores entre as zonas?**</br>
Sim. Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster de múltiplas zonas, deve-se ativar um [Virtual Router Function (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que seus nós do trabalhador possam se comunicar entre si na rede privada. Para ativar o VRF, [entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Se não for possível ou você não desejar ativar o VRF, ative o [VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Para executar essa ação, você precisa da [permissão de infraestrutura](/docs/containers?topic=containers-users#infra_access) **Rede > Gerenciar a rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.

**Como permitir que meus usuários acessem meu app por meio da Internet pública?**</br>
É possível expor seus apps usando um balanceador de carga do aplicativo (ALB) do Ingresso ou um serviço de balanceador de carga.

- **Balanceador de carga do aplicativo (ALB) do Ingress** Por padrão, os ALBs públicos são automaticamente criados e ativados em cada zona em seu cluster. Um multizone load balancer (MZLB) do Cloudflare para seu cluster também é criado e implementado automaticamente para que exista 1 MZLB para cada região. O MZLB coloca os endereços IP de seus ALBs atrás do mesmo nome do host e ativa as verificações de funcionamento nesses endereços IP para determinar se eles estão disponíveis ou não. Por exemplo, se você tiver nós do trabalhador em 3 zonas na região Leste dos EUA, o nome do host `yourcluster.us-east.containers.appdomain.cloud` terá 3 endereços IP de ALB. O funcionamento do MZLB verifica o IP do ALB público em cada zona de uma região e mantém os resultados de consulta de DNS atualizados com base nessas verificações de funcionamento. Para obter mais informações, consulte [Componentes e arquitetura do Ingress](/docs/containers?topic=containers-ingress#planning).

- **Serviços do balanceador de carga:** os serviços do balanceador de carga são configurados em somente uma zona. As solicitações recebidas para seu app são roteadas dessa zona para todas as instâncias do app em outras zonas. Se essa zona se tornar indisponível, seu app poderá não ser acessível por meio da Internet. É possível configurar serviços adicionais de balanceador de carga em outras zonas para considerar uma falha de zona única. Para obter mais informações, consulte [serviços de balanceador de carga](/docs/containers?topic=containers-loadbalancer#multi_zone_config) altamente disponíveis.

**Posso configurar o armazenamento persistente para o meu cluster de múltiplas zonas?**</br>
Para o armazenamento persistente altamente disponível, use um serviço de nuvem como o [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-getting-started-with-cloudant#getting-started-with-cloudant) ou [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage?topic=cloud-object-storage-about-ibm-cloud-object-storage#about-ibm-cloud-object-storage). Também é possível tentar uma solução de armazenamento definida por software (SDS), como a [Portworx](/docs/containers?topic=containers-portworx#portworx), que usa [máquinas SDS](#sds). Para obter mais informações, consulte [Comparação de opções de armazenamento persistente para clusters de múltiplas zonas](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).

O arquivo NFS e o armazenamento de bloco não são compartilháveis entre as zonas. Os volumes persistentes podem ser usados somente na zona na qual o dispositivo de armazenamento real está localizado. Se você tem armazenamento de arquivo ou de bloco do NFS existente em seu cluster que deseja continuar a usar, deve-se aplicar rótulos de região e zona aos volumes persistentes existentes. Esses rótulos ajudam o kube-scheduler a determinar onde planejar um app que usa o volume persistente. Execute o comando a seguir e substitua  `<mycluster>`  com o nome do cluster.

```
bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <mycluster>
```
{: pre}

** Eu criei meu cluster multizone. Por que ainda há somente uma zona? Como incluir zonas em meu cluster?**</br>
Se você [cria seu cluster de múltiplas zonas com a CLI](/docs/containers?topic=containers-clusters#clusters_cli), o cluster é criado, mas deve-se incluir zonas no conjunto de trabalhadores para concluir o processo. Para abranger múltiplas zonas, seu cluster deve estar em uma [cidade metropolitana de múltiplas zonas](/docs/containers?topic=containers-regions-and-zones#zones). Para incluir uma zona em seu cluster e difundir nós do trabalhador entre as zonas, consulte [Incluindo uma zona em seu cluster](/docs/containers?topic=containers-clusters#add_zone).

### Quais são algumas mudanças de como eu gerencio atualmente meus clusters?
{: #mz_new_ways}

Com a introdução de conjuntos de trabalhadores, é possível usar um novo conjunto de APIs e comandos para gerenciar seu cluster. É possível ver esses novos comandos na [página de documentação da CLI](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference) ou em seu terminal executando `ibmcloud ks help`.
{: shortdesc}

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
    <td><p class="deprecated"><code>ibmcloud ks worker-add</code> para incluir nós do trabalhador independentes.</p></td>
    <td><ul><li>Para incluir diferentes tipos de máquina do que seu conjunto existente, crie um novo conjunto de trabalhadores: [comando](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_create) <code>ibmcloud ks worker-pool-create</code>.</li>
    <li>Para incluir nós do trabalhador em um conjunto existente, redimensione o número de nós por zona no conjunto: [comando](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code>.</li></ul></td>
    </tr>
    <tr>
    <td>Remover nós do trabalhador do cluster.</td>
    <td><code>ibmcloud ks worker-rm</code>, que ainda é possível usar para excluir um nó do trabalhador problemático de seu cluster.</td>
    <td><ul><li>Se o conjunto de trabalhadores estiver não balanceado, por exemplo, após a remoção de um nó do trabalhador, rebalance-o: [comando](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) <code>ibmcloud ks worker-pool-rebalance</code>.</li>
    <li>Para reduzir o número de nós do trabalhador em um conjunto, redimensiona o número por zona (valor mínimo de 1): <code>comando ibmcloud ks worker-pool-resize</code> [comando](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize).</li></ul></td>
    </tr>
    <tr>
    <td>Use uma nova VLAN para os nós do trabalhador.</td>
    <td><p class="deprecated">Inclua um novo nó do trabalhador que use a nova VLAN privada ou pública: <code>ibmcloud ks worker-add</code>.</p></td>
    <td>Configure o conjunto de trabalhadores para usar uma VLAN pública ou privada diferente da usada anteriormente: [comando](/docs/containers?topic=containers-cs_cli_reference#cs_zone_network_set) <code>ibmcloud ks zone-network-set</code>.</td>
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

1. [Criar clusters](/docs/containers?topic=containers-clusters#clusters) em múltiplas zonas ou regiões.
2. Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster de múltiplas zonas, deve-se ativar um [Virtual Router Function (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que seus nós do trabalhador possam se comunicar entre si na rede privada. Para ativar o VRF, [entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Se não for possível ou você não desejar ativar o VRF, ative o [VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Para executar essa ação, você precisa da [permissão de infraestrutura](/docs/containers?topic=containers-users#infra_access) **Rede > Gerenciar a rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
3. Em cada cluster, exponha seu app usando um [balanceador de carga do aplicativo (ALB)](/docs/containers?topic=containers-ingress#ingress_expose_public) ou um [serviço de balanceador de carga](/docs/containers?topic=containers-loadbalancer).
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
    1.  Configure o serviço seguindo as etapas de 1 a 5 em [Introdução ao {{site.data.keyword.Bluemix_notm}} Internet Services (CIS)](/docs/infrastructure/cis?topic=cis-getting-started#getting-started). Essas etapas o guiam pelo fornecimento da instância de serviço, incluindo seu domínio do app, configurando seus servidores de nomes e criando registros DNS. Crie um registro de DNS para cada ALB ou endereço IP do balanceador de carga que você coletou. Esses registros do DNS mapeiam seu domínio de app para todos os ALBs ou balanceadores de carga do cluster e asseguram que as solicitações para seu domínio de app sejam encaminhadas para seus clusters em um ciclo round-robin.
    2. [Inclua verificações de funcionamento](/docs/infrastructure/cis?topic=cis-set-up-and-configure-your-load-balancers#add-a-health-check) para os ALBs ou balanceadores de carga. É possível usar a mesma verificação de funcionamento para os ALBs ou balanceadores de carga em todos os seus clusters ou criar verificações de funcionamento específicas para usar para clusters específicos.
    3. [Inclua um conjunto de origem](/docs/infrastructure/cis?topic=cis-set-up-and-configure-your-load-balancers#add-a-pool) para cada cluster incluindo os IPs do ALB ou do balanceador de carga do cluster. Por exemplo, se você tiver 3 clusters que cada um tenha 2 ALBs, crie 3 conjuntos de origem que cada um tenha 2 endereços IP de ALB. Inclua uma verificação de funcionamento em cada conjunto de origem que você criar.
    4. [ Inclua um balanceador de carga global ](/docs/infrastructure/cis?topic=cis-set-up-and-configure-your-load-balancers#set-up-and-configure-your-load-balancers).

    **Para usar seu próprio balanceador de carga global**:
    1. Configure seu domínio para rotear o tráfego recebido para seu ALB ou serviços de balanceador de carga, incluindo os endereços IP de todos os ALBs ativados públicos e serviços de balanceador de carga para seu domínio.
    2. Para cada endereço IP, ative uma verificação de funcionamento baseada em ping para que seu provedor DNS possa detectar endereços IP não funcionais. Se um endereço IP não funcional for detectado, o tráfego não será mais roteado para esse endereço IP.

## Clusters privados
{: #private_clusters}

Por padrão, o {{site.data.keyword.containerlong_notm}} configura seu cluster com acesso a uma VLAN privada e a uma VLAN pública. A VLAN privada determina o endereço IP privado que é designado a cada nó do trabalhador, que fornece cada nó do trabalhador com uma interface de rede privada. A VLAN pública permite que os nós do trabalhador se conectem de forma automática e segura ao mestre.
{: shortdesc}

No entanto, você pode desejar criar uma VLAN privada ou um cluster de terminal em serviço privado para requisitos de segurança ou de conformidade. Suas opções para criar um cluster privado dependem do tipo de conta de infraestrutura do IBM Cloud (SoftLayer) que você tem e da configuração de VLAN pública e privada que você deseja. Para obter mais informações sobre cada uma das configurações a seguir, consulte [Planejando sua rede de cluster](/docs/containers?topic=containers-cs_network_ov).

Você tem um cluster existente que você deseja tornar apenas privado? Para ver como é possível incluir conjuntos de trabalhadores ou modificar conjuntos de trabalhadores existentes com novas VLANs, confira [Mudando as conexões VLAN do nó do trabalhador](/docs/containers?topic=containers-cs_network_cluster#change-vlans).
{: note}

**Conta ativada para VRF, mestre do Kubernetes privado, nós do trabalhador em VLANs públicas e privadas**</br>
Em clusters que executam o Kubernetes versão 1.11 ou mais recente, é possível configurar sua rede de cluster para usar os terminais em serviço público e privado. Depois de ativar o terminal em serviço privado, o mestre Kubernetes e os nós do trabalhador sempre se comunicam por meio da VLAN privada por meio do terminal em serviço privado. Mesmo se você ativar o terminal em serviço público para seu cluster, a comunicação do mestre do Kubernetes com o nó do trabalhador permanecerá na VLAN privada. Depois de ativar o terminal em serviço privado, não é possível desativá-lo. É possível manter o terminal em serviço público para acesso seguro ao mestre do Kubernetes na Internet, por exemplo, para executar comandos `kubectl` ou é possível desativar o terminal em serviço público para um cluster somente de terminal em serviço privado.

**Conta não VRF ou ativadas para VRF, os nós do mestre do Kubernetes e nós do trabalhador apenas na VLAN privada**</br>
Se você configurar seus nós do trabalhador em uma VLAN privada apenas, eles não poderão expor automaticamente seus serviços de app na rede pública e, em uma conta não VRF, também não poderão se conectar ao mestre. Deve-se configurar um dispositivo de gateway para fornecer conectividade de rede entre os nós do trabalhador e o mestre.

Para contas não VRF: se você criar o cluster com VLANs públicas e privadas, não será possível remover mais tarde as VLANs públicas desse cluster. A remoção de todas as VLANs públicas de um cluster faz com que diversos componentes do cluster parem de funcionar. Em vez disso, crie um novo cluster sem a VLAN pública.
{: note}

**Conta não VRF, mestre do Kubernetes e nós do trabalhador nas VLANs pública e privada**</br>
Para a maioria dos casos, sua configuração de cluster pode incluir nós do trabalhador em VLANs públicas e privadas. Em seguida, é possível bloquear o cluster bloqueando o tráfego de VLAN pública com as políticas do Calico e restringindo o tráfego para selecionar os nós de borda.

## Conjuntos do Trabalhador e nós do trabalhador
{: #planning_worker_nodes}

Um cluster do Kubernetes consiste em nós do trabalhador que são agrupados em conjuntos de nós do trabalhador e são monitorados e gerenciados centralmente pelo mestre do Kubernetes. Os administradores de cluster decidem como configurar o cluster de nós do trabalhador para assegurar que os usuários do cluster tenham todos os recursos para implementar e executar apps no cluster.
{:shortdesc}

Ao criar um cluster padrão, os nós do trabalhador com as mesmas especificações (tipo) de memória, CPU e espaço em disco são solicitados na infraestrutura do IBM Cloud (SoftLayer) em seu nome e incluídos no conjunto de nós do trabalhador padrão em seu cluster. A cada nó do trabalhador é designado
um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados após a criação do cluster. É possível escolher entre servidores virtuais ou físicos (bare metal). Dependendo do nível de isolamento de hardware escolhido, os nós do trabalhador virtual podem ser configurados como nós compartilhados ou dedicados. Para incluir diferentes tipos em seu cluster, [crie outro conjunto de trabalhadores](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_create).

O Kubernetes limita o número máximo de nós do trabalhador que você pode ter em um cluster. Revise [cotas de nó do trabalhador e de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/setup/cluster-large/) para obter mais informações.


Deseja certificar-se de sempre ter nós do trabalhador suficientes para cobrir sua carga de trabalho? Experimente  [ o cluster autoscaler ](/docs/containers?topic=containers-ca#ca).
{: tip}

<br />


## Hardware disponível para nós do trabalhador
{: #shared_dedicated_node}

Ao criar um cluster padrão no {{site.data.keyword.Bluemix_notm}}, você escolhe se os conjuntos de trabalhadores consistem em nós do trabalhador que são máquinas físicas (bare metal) ou máquinas virtuais que são executadas em hardware físico. Você também seleciona o tipo de nó do trabalhador ou a combinação de memória, CPU e outras especificações de máquina, como armazenamento em disco.
{:shortdesc}

<img src="images/cs_clusters_hardware.png" width="700" alt="Opções de hardware para os nós do trabalhador em um cluster padrão" style="width:700px; border-style: none"/>

Se você deseja mais de um tipo de nó do trabalhador, deve-se criar um conjunto de trabalhadores para cada tipo. Não é possível redimensionar os nós do trabalhador existentes para que tenham recursos diferentes, como CPU ou memória. Ao criar um cluster grátis, seu nó do trabalhador é provisionado automaticamente como um nó virtual compartilhado na conta de infraestrutura do IBM Cloud (SoftLayer). Em clusters padrão, é possível escolher o tipo de máquina que funciona melhor para sua carga de trabalho. Conforme você planeja, considere as [reservas de recurso do nó do trabalhador](#resource_limit_node) na capacidade total de CPU e memória.

É possível implementar clusters usando a [UI do console](/docs/containers?topic=containers-clusters#clusters_ui) ou a [CLI](/docs/containers?topic=containers-clusters#clusters_cli).

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

Alguns tipos estão disponíveis para apenas um tipo de configuração de ocupação. Por exemplo, as VMs `m2c` estão disponíveis apenas como configuração de ocupação `shared`.
{: note}

**Quais são os recursos gerais de VMs?**</br>
As máquinas virtuais usam o disco local em vez da rede de área de armazenamento (SAN) para confiabilidade. Os benefícios de confiabilidade incluem maior rendimento ao serializar bytes para o disco local e a degradação do sistema de arquivos reduzido devido a falhas de rede. Cada MV vem com velocidade de rede 1000 Mbps, 25 GB de armazenamento em disco local primário para o sistema de arquivos do S.O. e 100 GB de armazenamento em disco local secundário para dados, como o tempo de execução do contêiner e o `kubelet`. O armazenamento local no nó do trabalhador é somente para processamento de curto prazo e os discos primário e secundário são limpos quando você atualiza ou recarrega o nó do trabalhador. Para obter soluções de armazenamento persistente, consulte [Planejando o armazenamento persistente altamente disponível](/docs/containers?topic=containers-storage_planning#storage_planning).

**E se eu tiver descontinuado os tipos de máquina `u1c` ou `b1c`?**</br>
Para começar a usar os tipos de máquina `u2c` e `b2c`, [atualize os tipos de máquina incluindo nós do trabalhador](/docs/containers?topic=containers-update#machine_type).

** Quais tipos de máquina virtual estão disponíveis? **</br>
Tipos de máquina variam por zona. Para ver os tipos de máquina disponíveis em sua zona, execute `ibmcloud ks machine-types <zone>`. Por exemplo, as VMs `m2c` estão disponíveis somente no local de Dallas (`dal10, dal12, dal13`). Também é possível revisar os tipos de máquina [bare metal](#bm) ou [SDS](#sds) disponíveis.

{: #vm-table}
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
<td><strong>Virtual, b2c.32x128</strong>: selecione essa VM balanceada para cargas de trabalho de médio a grande porte, como um banco de dados e um website dinâmico com vários usuários simultâneos.</td>
<td>32 / 128GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.56x242</strong>: selecione essa VM balanceada para cargas de trabalho grandes, como um banco de dados e múltiplos apps com muitos usuários simultâneos.</td>
<td>56 / 242GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, c2c.16x16</strong>: use esse tipo quando desejar um saldo equilibrado de recursos de cálculo do nó do trabalhador para cargas de trabalho leves.</td>
<td>16 / 16GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.16x32</strong>: use esse tipo quando desejar uma razão 1:2 de CPU e recursos de memória do nó do trabalhador para cargas de trabalho de pequeno a médio porte.</td>
<td>16 / 32GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.32x32</strong>: use esse tipo quando desejar um saldo equilibrado de recursos de cálculo do nó do trabalhador para cargas de trabalho de médio porte.</td>
<td>32 / 32 GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.32x64</strong>: use esse tipo quando desejar uma razão 1:2 de CPU e recursos de memória do nó do trabalhador para cargas de trabalho de médio porte.</td>
<td>32 / 64 GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, m2c.8x64</strong>: use esse tipo quando desejar uma proporção 1:8 de recursos de CPU e de memória para cargas de trabalho leves a médias que requerem mais memória, como bancos de dados como o {{site.data.keyword.Db2_on_Cloud_short}}. Disponível somente em Dallas e como uma ocupação `--hardware shared`.</td>
<td>8 / 64 GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, m2c.16x128</strong>: use esse tipo quando você deseja uma proporção 1:8 de recursos de CPU e de memória para cargas de trabalho médias que requerem mais memória, como bancos de dados como o {{site.data.keyword.Db2_on_Cloud_short}}. Disponível somente em Dallas e como uma ocupação `--hardware shared`.</td>
<td>16 / 128GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, m2c.30x240</strong>: Use este tipo quando desejar uma proporção 1: 8 de recursos de CPU e memória para cargas de trabalho de médio a grande porte que requerem mais memória, como bancos de dados como {{site.data.keyword.Db2_on_Cloud_short}}. Disponível somente em Dallas e como uma ocupação `--hardware shared`.</td>
<td>30 / 240GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, m2c.48x384</strong>: use esse tipo quando você deseja uma proporção 1:8 de recursos de CPU e de memória para cargas de trabalho médias a grandes que requeiram mais memória, como bancos de dados como o {{site.data.keyword.Db2_on_Cloud_short}}. Disponível somente em Dallas e como uma ocupação `--hardware shared`.</td>
<td>48 / 384GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, m2c.56x448</strong>: use esse tipo quando desejar uma proporção 1:8 de CPU e recursos de memória para cargas de trabalho de grande porte que requerem mais memória, como bancos de dados como o {{site.data.keyword.Db2_on_Cloud_short}}. Disponível somente em Dallas e como uma ocupação `--hardware shared`.</td>
<td>56 / 448GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr><tr>
<td><strong>Virtual, m2c.64x512</strong>: use esse tipo quando desejar uma proporção 1:8 de recursos de CPU e de memória para cargas de trabalho grandes que requerem mais memória, como bancos de dados como o {{site.data.keyword.Db2_on_Cloud_short}}. Disponível somente em Dallas e como uma ocupação `--hardware shared`.</td>
<td>64 / 512GB</td>
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
O bare metal dá acesso direto aos recursos físicos na máquina, como a memória ou CPU. Essa configuração elimina o hypervisor da máquina virtual que aloca recursos físicos para máquinas virtuais executadas no host. Em vez disso, todos os recursos de uma máquina bare metal são dedicados exclusivamente ao trabalhador, portanto, você não precisará se preocupar com "vizinhos barulhentos" compartilhando recursos ou diminuindo o desempenho. Os tipos de máquina física têm mais armazenamento local do que virtual e alguns têm RAID para aumentar a disponibilidade de dados. O armazenamento local no nó do trabalhador é somente para processamento de curto prazo e os discos primário e secundário são limpos quando você atualiza ou recarrega o nó do trabalhador. Para obter soluções de armazenamento persistente, consulte [Planejando o armazenamento persistente altamente disponível](/docs/containers?topic=containers-storage_planning#storage_planning).

**Além de melhores especificações para desempenho, posso fazer algo com bare metal que eu não posso com VMs?**</br>
Sim. Com bare metal, você tem a opção de ativar o Cálculo Confiável para verificar seus nós do trabalhador com relação à violação. Se você não ativar a confiança durante a criação do cluster, mas desejar posteriormente, será possível usar o [comando](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Depois de ativar a confiança, não é possível desativá-la posteriormente. É possível fazer um novo cluster sem confiança. Para obter mais informações sobre como a confiança funciona durante o processo de inicialização do nó, veja [{{site.data.keyword.containerlong_notm}} com Cálculo confiável](/docs/containers?topic=containers-security#trusted_compute). O Trusted Compute está disponível para determinados tipos de máquina bare metal. Ao executar o comando `ibmcloud ks machine-types <zone>` [](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types), é possível ver quais máquinas suportam confiança revisando o campo **Confiável**. Por exemplo, os tipos GPU `mgXc` não suportam o Cálculo confiável.

Além do Trusted Compute, também é possível aproveitar o {{site.data.keyword.datashield_full}} (Beta). O {{site.data.keyword.datashield_short}} está integrado às tecnologias Intel® Software Guard Extensions (SGX) e Fortanix® para que seu código de carga de trabalho de contêiner do {{site.data.keyword.Bluemix_notm}} e os dados sejam protegidos em uso. O código do app e os dados são executados em enclaves reforçados pela CPU, que são áreas confiáveis de memória no nó do trabalhador que protegem os aspectos críticos do app, o que ajuda a manter o código e os dados confidenciais e não modificados. Se você ou sua empresa requer sensibilidade de dados devido a políticas internas, regulamentações governamentais ou requisitos de conformidade da indústria, essa solução pode ajudá-lo a mover-se para a nuvem. Os casos de uso de exemplo incluem instituições financeiras e de assistência médica ou países com políticas governamentais que requerem soluções de nuvem no local.

** Bare metal parece incrível! O que está me impedindo de pedir um agora?**</br>
Os servidores bare metal são mais caros do que os servidores virtuais e são mais adequados para apps de alto desempenho que precisam de mais recursos e controle de host.

Os servidores bare metal são faturados mensalmente. Se você cancelar um servidor bare metal antes do final do mês, será cobrado até o final do mês. Depois de pedir ou cancelar um servidor bare metal, o processo é concluído manualmente em sua conta de infraestrutura do IBM Cloud (SoftLayer). Portanto, isso pode levar mais de um dia útil para ser concluído.
{: important}

**Que tipos de bare metal posso pedir?**</br>
Tipos de máquina variam por zona. Para ver os tipos de máquina disponíveis em sua zona, execute `ibmcloud ks machine-types <zone>`. Também é possível revisar os tipos de máquina [VM](#vm) ou [SDS](#sds) disponíveis.

As máquinas bare metal são otimizadas para diferentes casos de uso, como cargas de trabalho intensivas de RAM, de dados ou de GPU.

Escolha um tipo de máquina com a configuração de armazenamento correta para suportar sua carga de trabalho. Alguns tipos têm uma combinação dos discos e configurações de armazenamento a seguir. Por exemplo, alguns tipos podem ter um disco primário SATA com um disco secundário SSD bruto.

* **SATA**: um dispositivo de armazenamento em disco de rotação magnética que é usado frequentemente para o disco primário do nó do trabalhador que armazena o sistema de arquivos de S.O.
* **SSD**: um dispositivo de armazenamento de unidade de estado sólido para dados de alto desempenho.
* **Bruto**: o dispositivo de armazenamento não está formatado, com a capacidade total disponível para uso.
* **RAID**: o dispositivo de armazenamento tem dados distribuídos para redundância e desempenho que variam dependendo do nível do RAID. Como tal, a capacidade do disco que está disponível para uso varia.


{: #bm-table}
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
<td><strong>Bare metal com uso intensivo de dados, md1c.16x64.4x4tb</strong>: use esse tipo para uma quantia significativa de armazenamento em disco local, incluindo RAID para aumentar a disponibilidade de dados, para cargas de trabalho, como sistemas de arquivos distribuídos, bancos de dados grandes e análise de Big Data.</td>
<td>16 / 64GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal com uso intensivo de dados, md1c.28x512.4x4tb</strong>: use esse tipo para uma quantia significativa de armazenamento em disco local, incluindo RAID para aumentar a disponibilidade de dados, para cargas de trabalho, como sistemas de arquivos distribuídos, bancos de dados grandes e análise de Big Data.</td>
<td>28 / 512 GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Balanceado bare metal, mb2c.4x32</strong>: Use para cargas de trabalho balanceadas que requerem mais recursos de cálculo do que as máquinas virtuais oferecem. Esse tipo também pode ser ativado com o Intel® Software Guard Extensions (SGX) para que seja possível usar o <a href="/docs/services/data-shield?topic=data-shield-getting-started#getting-started" target="_blank">{{site.data.keyword.datashield_short}} (Beta)<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para criptografar a sua memória de dados.</td>
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

Os tipos de software-defined storage (SDS) são máquinas físicas que são provisionadas com discos rígidos adicionais para armazenamento local físico. Diferentemente do disco local primário e secundário, esses discos rígidos não são limpos durante uma atualização ou um recarregamento do nó do trabalhador. Como os dados são localizados juntamente com o nó de cálculo, as máquinas SDS são adequadas para cargas de trabalho de alto desempenho.
{: shortdesc}

** Quando uso os sabores SDS? **</br>
Você normalmente usa máquinas SDS nos casos a seguir:
*  Se você usar um complemento SDS, como o [Portworx](/docs/containers?topic=containers-portworx#portworx) para o cluster, use uma máquina SDS.
*  Se seu app é um [StatefulSet ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) que requer armazenamento local, é possível usar máquinas SDS e provisionar [volumes persistentes locais do Kubernetes (beta) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/blog/2018/04/13/local-persistent-volumes-beta/).
*  Você pode ter apps customizados que requeiram armazenamento local bruto adicional.

Para obter mais soluções de armazenamento, veja [Planejando o armazenamento persistente altamente disponível](/docs/containers?topic=containers-storage_planning#storage_planning).

** Quais tipos de SDS posso pedir? **</br>
Tipos de máquina variam por zona. Para ver os tipos de máquina disponíveis em sua zona, execute `ibmcloud ks machine-types <zone>`. Também é possível revisar os tipos de máquina [bare metal](#bm) ou [VM](#vm) disponíveis.

Escolha um tipo de máquina com a configuração de armazenamento correta para suportar sua carga de trabalho. Alguns tipos têm uma combinação dos discos e configurações de armazenamento a seguir. Por exemplo, alguns tipos podem ter um disco primário SATA com um disco secundário SSD bruto.

* **SATA**: um dispositivo de armazenamento em disco de rotação magnética que é usado frequentemente para o disco primário do nó do trabalhador que armazena o sistema de arquivos de S.O.
* **SSD**: um dispositivo de armazenamento de unidade de estado sólido para dados de alto desempenho.
* **Bruto**: o dispositivo de armazenamento não está formatado, com a capacidade total disponível para uso.
* **RAID**: o dispositivo de armazenamento tem dados distribuídos para redundância e desempenho que variam dependendo do nível do RAID. Como tal, a capacidade do disco que está disponível para uso varia.


{: #sds-table}
<table>
<caption>Tipos de máquina SDS disponíveis no  {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Caso Nome e uso</th>
<th>Núcleos / Memória</th>
<th>Disco Primário / Secundário</th>
<th>Discos brutos adicionais</th>
<th>Velocidade</th>
</thead>
<tbody>
<tr>
<td><strong>Bare metal com SDS, ms2c.4x32.1.9tb.ssd</strong>: se você precisar de armazenamento local extra para desempenho, use esse tipo de disco pesado que suporta o software-defined storage (SDS).</td>
<td>4 / 32GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>SSD Bruto 1,9 TB (caminho do dispositivo: `/dev/sdc`)</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal com SDS, ms2c.16x64.1.9tb.ssd</strong>: se for necessário armazenamento local extra para desempenho, use esse tipo de disco pesado que suporta software-defined storage (SDS).</td>
<td>16 / 64GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>SSD Bruto 1,9 TB (caminho do dispositivo: `/dev/sdc`)</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal com SDS, ms2c.28x256.3.8tb.ssd</strong>: se você precisar de armazenamento local extra para o desempenho, use esse tipo de disco pesado que suporte software-defined storage (SDS).</td>
<td>28 / 256GB</td>
<td>2TB SATA / 1.9TB SSD</td>
<td>3.8 TB de SSD bruto (caminho do dispositivo: `/dev/sdc`)</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal com SDS, ms2c.28x512.4x3.8tb.ssd</strong>: se você precisar de armazenamento local extra para o desempenho, use esse tipo de disco pesado que suporte o software-defined storage (SDS).</td>
<td>28 / 512GB</td>
<td>2TB SATA / 1.9TB SSD</td>
<td>4 discos, 3.8 TB de SSD bruto (caminhos de dispositivo: `/dev/sdc`, `/dev/sdd`, `/dev/sde`, `/dev/sdf`)</td>
<td>10000Mbps</td>
</tr>
</tbody>
</table>

## Reservas de recursos do nó do trabalhador
{: #resource_limit_node}

O {{site.data.keyword.containerlong_notm}} configura as reservas de recursos de cálculo que limitam os recursos de cálculo disponíveis em cada nó do trabalhador. Os recursos de memória e CPU reservados não podem ser usados por pods no nó do trabalhador e reduzem os recursos alocáveis em cada nó do trabalhador. Quando você implementa inicialmente os pods, se o nó do trabalhador não tiver recursos alocáveis suficientes, a implementação falhará. Além disso, se os pods excederem o limite de recurso do nó do trabalhador, os pods serão despejados. No Kubernetes, esse limite é chamado de [limite máximo de despejo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

Se menos CPU ou memória estiver disponível do que as reservas do nó do trabalhador, o Kubernetes começará a despejar os pods para restaurar recursos de cálculo suficientes. Os pods serão reagendados em outro nó do trabalhador se um nó do trabalhador estiver disponível. Se os pods forem despejados frequentemente, inclua mais nós do trabalhador em seu cluster ou configure [limites de recurso ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) em seus pods.

Os recursos que são reservados em seu nó do trabalhador dependem da quantia de CPU e memória que acompanha seu nó do trabalhador. O {{site.data.keyword.containerlong_notm}} define as camadas de memória e de CPU, conforme mostrado nas tabelas a seguir. Se o nó do trabalhador vem com recursos de cálculo em múltiplas camadas, uma porcentagem de seus recursos de CPU e memória é reservada para cada camada.

Para revisar quantos recursos de cálculo são usados atualmente no nó do trabalhador, execute [`kubectl top node` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/#top).
{: tip}

<table summary="Esta tabela mostra as reservas de memória do nó do trabalhador por camada.">
<caption>Reservas de memória do nó do trabalhador por camada.</caption>
<thead>
<tr>
  <th>Camada de memória</th>
  <th>% ou quantia reservada</th>
  <th>Exemplo do nó do trabalhador `b2c.4x16` (16 GB)</th>
  <th>Exemplo do nó do trabalhador `mg1c.28x256` (256 GB)</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Primeiros 16 GB (0 a 16 GB)</td>
  <td>10% de memória</td>
  <td>1,6 GB</td>
  <td>1,6 GB</td>
</tr>
<tr>
  <td>Próximos 112 GB (17 a 128 GB)</td>
  <td>6% de memória</td>
  <td>N/A</td>
  <td>6,72 GB</td>
</tr>
<tr>
  <td>GBs restantes (mais de 129 GB)</td>
  <td>2% de memória</td>
  <td>N/A</td>
  <td>2,54 GB</td>
</tr>
<tr>
  <td>Reserva adicional para o despejo de [`kubelet` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/)</td>
  <td>100 MB</td>
  <td>100 MB (quantia simples)</td>
  <td>100 MB (quantia simples)</td>
</tr>
<tr>
  <td>**Total reservado**</td>
  <td>**(varia)**</td>
  <td>**1,7 GB do total de 16 GB**</td>
  <td>**10,96 GB do total de 256 GB**</td>
</tr>
</tbody>
</table>

<table summary="Esta tabela mostra as reservas de CPU do nó do trabalhador por camada.">
<caption>Reservas de CPU do nó do trabalhador por camada.</caption>
<thead>
<tr>
  <th>Camada da CPU</th>
  <th>% reservada</th>
  <th>Exemplo do nó do trabalhador `b2c.4x16` (4 núcleos)</th>
  <th>Exemplo do nó do trabalhador `mg1c.28x256` (28 núcleos)</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Primeiro núcleo (núcleo 1)</td>
  <td>6% núcleos</td>
  <td>0,06 núcleos</td>
  <td>0,06 núcleos</td>
</tr>
<tr>
  <td>Próximos 2 núcleos (núcleos 2-3)</td>
  <td>1% núcleos</td>
  <td>0,02 núcleos</td>
  <td>0,02 núcleos</td>
</tr>
<tr>
  <td>Próximos 2 núcleos (núcleos 4-5)</td>
  <td>0,5% núcleos</td>
  <td>0,005 núcleos</td>
  <td>0,01 núcleos</td>
</tr>
<tr>
  <td>Núcleos restantes (Núcleos 6 +)</td>
  <td>0,25% núcleos</td>
  <td>N/A</td>
  <td>0,0575 núcleos</td>
</tr>
<tr>
  <td>**Total reservado**</td>
  <td>**(varia)**</td>
  <td>**0,085 núcleos de 4 núcleos totais**</td>
  <td>**0,1475 núcleos de 28 núcleos totais**</td>
</tr>
</tbody>
</table>

## Recuperação automática para seus nós do trabalhador
{: #planning_autorecovery}

Componentes críticos, como `containerd`, `kubelet`, `kube-proxy` e `calico`, devem ser funcionais para ter um nó do trabalhador Kubernetes funcional. Com o tempo, esses componentes podem se dividir e podem deixar o nó do trabalhador em um estado não funcional. Os nós do trabalhador não funcionais diminuem a capacidade total do cluster e podem resultar em tempo de inatividade para seu app.
{:shortdesc}

É possível [configurar verificações de funcionamento para seu nó do trabalhador e ativar a Recuperação automática](/docs/containers?topic=containers-health#autorecovery). Se a Recuperação automática detecta um nó do trabalhador não funcional com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Para obter mais informações sobre como a Recuperação automática funciona, veja o [blog de Recuperação automática ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).

<br />

