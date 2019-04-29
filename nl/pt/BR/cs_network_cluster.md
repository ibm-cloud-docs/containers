---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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

# Configurando sua rede de cluster
{: #cs_network_cluster}

Defina uma configuração de rede em seu cluster do {{site.data.keyword.containerlong}}.
{:shortdesc}

Essa página ajuda a configurar a configuração de rede do seu cluster. Não tem certeza de qual configuração escolher? Consulte  [ Planejando sua rede de cluster ](/docs/containers?topic=containers-cs_network_ov).
{: tip}

## Configurando a rede do cluster com um VLAN público e privado
{: #both_vlans}

Configure seu cluster com acesso a [uma VLAN pública e uma VLAN privada](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options). A imagem a seguir mostra as opções de rede que podem ser configuradas para seu cluster com essa configuração.
{: shortdesc}

Essa configuração de rede consiste nas configurações de rede necessárias a seguir durante a criação de cluster e configurações de rede opcionais após a criação do cluster.

1. Se criar o cluster em um ambiente atrás de um firewall, [permita o tráfego de rede de saída para os IPs públicos e privados](/docs/containers?topic=containers-firewall#firewall_outbound) para os serviços do {{site.data.keyword.Bluemix_notm}} que você planeja usar.

2. Crie um cluster que esteja conectado a uma VLAN pública e uma privada. Se você criar um cluster de múltiplas zonas, será possível escolher os pares de VLAN para cada zona.

3. Escolha como o mestre do Kubernetes e os nós do trabalhador se comunicam.
  * Se o VRF estiver ativado em sua conta do {{site.data.keyword.Bluemix_notm}}, ative os terminais em serviço [somente públicos](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public), [públicos e privados](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both) ou [somente privados](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private).
  * Se não for possível ou não desejar ativar o VRF, ative o [terminal em serviço público apenas](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public).

4. Depois de criar seu cluster, é possível configurar as opções de rede a seguir:
  * Configure um [serviço de conexão VPN do strongSwan](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_public) para permitir a comunicação entre seu cluster e uma rede no local ou {{site.data.keyword.icpfull_notm}}.
  * Crie [serviços de descoberta do Kubernetes](/docs/containers?topic=containers-cs_network_planning#in-cluster) para permitir a comunicação no cluster entre os pods.
  * Crie serviços [públicos](/docs/containers?topic=containers-cs_network_planning#public_access) do Ingress, do balanceador de carga ou dos serviços de porta de nó para expor os apps às redes públicas.
  * Crie serviços [privados](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) do Ingress, do balanceador de carga ou dos serviços de porta de nó para expor os apps às redes privadas e criar políticas de rede do Calico para proteger seu cluster do acesso público.
  * Isole as cargas de trabalho de rede para os [nós do trabalhador de borda](/docs/containers?topic=containers-cs_network_planning#both_vlans_private_edge).
  * [Isole seu cluster na rede privada](/docs/containers?topic=containers-cs_network_planning#isolate).

<br />


## Configurando a rede de cluster com uma VLAN privada apenas
{: #setup_private_vlan}

Se você tiver requisitos de segurança específicos ou precisar criar políticas de rede customizadas e regras de roteamento para fornecer segurança de rede dedicada, configure seu cluster com acesso a [uma VLAN privada apenas](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options). A imagem a seguir mostra as opções de rede que podem ser configuradas para seu cluster com essa configuração.
{: shortdesc}

Essa configuração de rede consiste nas configurações de rede necessárias a seguir durante a criação de cluster e configurações de rede opcionais após a criação do cluster.

1. Se criar o cluster em um ambiente atrás de um firewall, [permita o tráfego de rede de saída para os IPs públicos e privados](/docs/containers?topic=containers-firewall#firewall_outbound) para os serviços do {{site.data.keyword.Bluemix_notm}} que você planeja usar.

2. Crie um cluster que esteja conectado a [private VLAN apenas](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options). Se você criar um cluster de múltiplas zonas, será possível escolher uma VLAN privada em cada zona.

3. Escolha como o mestre do Kubernetes e os nós do trabalhador se comunicam.
  * Se o VRF estiver ativado em sua conta do {{site.data.keyword.Bluemix_notm}}, [ative um terminal em serviço privado](#set-up-private-se).
  * Se você não puder ou não desejar ativar o VRF, seus nós do mestre e do trabalhador do Kubernetes não poderão se conectar automaticamente ao mestre. Deve-se configurar seu cluster com um [dispositivo de gateway](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private).

4. Depois de criar seu cluster, é possível configurar as opções de rede a seguir:
  * [Configure um gateway VPN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private) para permitir a comunicação entre seu cluster e uma rede no local ou {{site.data.keyword.icpfull_notm}}. Se você configurou anteriormente um VRA ou FSA para permitir a comunicação entre os nós do mestre e do trabalhador, é possível configurar um terminal VPN IPSec no VRA ou no FSA.
  * Crie [serviços de descoberta do Kubernetes](/docs/containers?topic=containers-cs_network_planning#in-cluster) para permitir a comunicação no cluster entre os pods.
  * Crie serviços [privados](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan) do Ingress, do balanceador de carga ou dos serviços de porta de nó para expor os apps em redes privadas.
  * Isole as cargas de trabalho de rede para os [nós do trabalhador de borda](/docs/containers?topic=containers-cs_network_planning#both_vlans_private_edge).
  * [Isole seu cluster na rede privada](/docs/containers?topic=containers-cs_network_planning#isolate).

<br />


## Mudando as conexões VLAN do nó do trabalhador
{: #change-vlans}

Ao criar um cluster, você escolhe se deseja conectar os nós do trabalhador a uma VLAN privada e pública ou a uma VLAN somente privada. Os nós do trabalhador fazem parte de conjuntos de trabalhadores que armazenam metadados de rede que incluem as VLANs a serem usadas para fornecer os nós do trabalhador futuros no conjunto. Você pode desejar mudar a configuração da conectividade VLAN do seu cluster posteriormente, em casos como os seguintes.
{: shortdesc}

* As VLANs do conjunto de trabalhadores em uma zona fica sem capacidade e você precisa fornecer uma nova VLAN para seus nós do trabalhador do cluster usarem.
* Você tem um cluster com nós do trabalhador que estão em VLANs públicas e privadas, mas você deseja mudar para um [cluster somente privado](#setup_private_vlan).
* Você tem um cluster somente privado, mas deseja alguns nós do trabalhador, como um conjunto de trabalhadores de [nós de borda](/docs/containers?topic=containers-edge#edge) na VLAN pública para expor seus apps na Internet.

Tentando alterar o terminal em serviço para comunicação do trabalhador principal no lugar? Consulte os tópicos para configurar os terminais em serviço [públicos](#set-up-public-se) e [privados](#set-up-private-se).
{: tip}

Antes de iniciar:
* [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
* Se os nós do trabalhador forem independentes (não como parte de um conjunto de trabalhadores), [atualize-os para os conjuntos de trabalhadores](/docs/containers?topic=containers-update#standalone_to_workerpool).

Para mudar as VLANs que um conjunto de trabalhadores usa para fornecer nós do trabalhador:

1. Liste os nomes dos conjuntos de trabalhadores em seu cluster.
  ```
  ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Determine as zonas para um dos conjuntos de trabalhadores. Na saída, procure o campo **Zonas**.
  ```
  ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

3. Para cada zona que você localizou na etapa anterior, obtenha uma VLAN pública e privada disponível que sejam compatíveis entre si.

  1. Verifique as VLANs públicas e privadas disponíveis que estão listadas em **Tipo** na saída.
    ```
    ibmcloud ks vlans --zone <zone>
    ```
    {: pre}

  2. Verifique se as VLANs públicas e privadas na zona são compatíveis. Para serem compatíveis, o **Roteador** deve ter o mesmo ID de pod. Nesta saída de exemplo, os IDs do pod **Roteador** correspondem: `01a` e `01a`. Se um ID de pod fosse `01a` e o outro fosse `02a`, não seria possível configurar esses IDs de VLAN pública e privada para o conjunto de trabalhadores.
    ```
    ID        Name   Number   Type      Router         Supports Virtual Workers
    229xxxx          1234     private   bcr01a.dal12   true
    229xxxx          5678     public    fcr01a.dal12   true
    ```
    {: screen}

  3. Se você precisar pedir uma nova VLAN pública ou privada para a zona, será possível pedir no console do [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans) ou use o comando a seguir. Lembre-se de que as VLANs devem ser compatíveis, com os IDs de pod correspondentes do **Roteador** como na etapa anterior. Se você estiver criando um par de novas VLANs públicas e privadas, elas deverão ser compatíveis uma com a outra.
    ```
    ibmcloud sl vlan create -t [public|private] -d <zone> -r <compatible_router>
    ```
    {: pre}

  4. Observe os IDs das VLANs compatíveis.

4. Configure um conjunto de trabalhadores com os novos metadados de rede da VLAN para cada zona. É possível criar um novo conjunto de trabalhadores, ou modificar um conjunto de trabalhadores existente.

  * **Criar um novo conjunto de trabalhadores**: consulte [incluindo nós do trabalhador criando um novo conjunto de trabalhadores](/docs/containers?topic=containers-clusters#add_pool).

  * **Modificar um conjunto de trabalhadores existente**: configure os metadados de rede do conjunto de trabalhadores para usar a VLAN para cada zona. Os nós do trabalhador que já foram criados no conjunto continuam a usar as VLANs anteriores, mas novos nós do trabalhador no conjunto usam novos metadados de VLAN que você configurou.

    * Exemplo para incluir VLANs públicas e privadas, como, se você mudar de somente privada para privada e pública:
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

    * Exemplo para incluir apenas uma VLAN privada, como mudar de VLANs públicas e privadas para somente privadas quando há uma [conta ativada para VRF que usa terminais em serviço](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started):
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

5. Inclua nós do trabalhador no conjunto de trabalhadores redimensionando o conjunto.
  ```
  ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
  ```
  {: pre}

  Se você desejar remover nós do trabalhador que usam os metadados de rede anteriores, mude o número de trabalhadores por zona para duplicar a quantia anterior de trabalhadores por zona. Posteriormente nessas etapas, é possível unir, drenar e remover os nós do trabalhador anteriores.
  {: tip}

6. Verifique se os novos nós do trabalhador são criados com o **IP público** e **IP privado** apropriados na saída. Por exemplo, se você mudar o conjunto de trabalhadores de uma VLAN pública e privada para somente privada, os novos nós do trabalhador terão apenas um IP privado. Se você mudar o conjunto de trabalhadores de VLANs somente privadas para públicas e privadas, os novos nós do trabalhador terão IPs públicos e privados.
  ```
  ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

7. Opcional: remova os nós do trabalhador com os metadados de rede anteriores do conjunto de trabalhadores.
  1. Na saída da etapa anterior, anote o **ID** e o **IP privado** dos nós do trabalhador que você deseja remover do conjunto de trabalhadores.
  2. Marque o nó do trabalhador como não programável em um processo conhecido como bloqueio. Ao bloquear um nó do trabalhador, ele fica indisponível para planejamento futuro do pod.
    ```
    kubectl cordon <worker_private_ip>
    ```
    {: pre}
  3. Verifique se o planejamento do pod está desativado para seu nó do trabalhador.
    ```
    kubectl get nodes
    ```
    {: pre}
     O nó do trabalhador ficará desativado para planejamento do pod se o status exibir **`SchedulingDisabled`**.
  4. Force os pods para que sejam removidos do nó do trabalhador e reprogramados nos nós do trabalhador restantes no cluster.
    ```
    dreno kubectl de dreno < worker_private_ip>
    ```
    {: pre}
     Esse processo pode levar alguns minutos.
  5. Remova o nó do trabalhador. Use o ID do trabalhador que você recuperou anteriormente.
    ```
    ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}
  6. Verifique se o nó do trabalhador foi removido.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

8. Opcional: é possível repetir as etapas de 2 a 7 para cada conjunto de trabalhadores em seu cluster. Depois de concluir essas etapas, todos os nós do trabalhador em seu cluster são configurados com as novas VLANs.

9. Os ALBs padrão em seu cluster ainda estão ligados à VLAN antiga porque seus endereços IP são de uma sub-rede na VLAN. Como os ALBs não podem ser movidos através de VLANs, é possível, em vez disso, [criar ALBs nas novas VLANs e desativar ALBs nas VLANs antigas](/docs/containers?topic=containers-ingress#migrate-alb-vlan).

<br />


## Configurando o terminal em serviço privado
{: #set-up-private-se}

Em clusters que executam o Kubernetes versão 1.11 ou mais recente, ative ou desative o terminal em serviço privado para seu cluster.
{: shortdesc}

O terminal em serviço privado torna seu mestre do Kubernetes acessível privadamente. Os nós do trabalhador e seus usuários de cluster autorizados podem se comunicar com o mestre do Kubernetes sobre a rede privada. Para determinar se é possível ativar o terminal em serviço privado, consulte [Planejando a comunicação do mestre para o trabalhador](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master). Observe que não é possível desativar o terminal em serviço privado depois de ativá-lo.

** Etapas para ativar durante a criação do cluster **</br>
1. Ative o [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) em sua conta de infraestrutura do IBM Cloud (SoftLayer).
2. [Ative sua conta do {{site.data.keyword.Bluemix_notm}} para usar os terminais em serviço](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Se você criar o cluster em um ambiente atrás de um firewall, [ permita o tráfego de rede de saída para os IPs públicos e privados ](/docs/containers?topic=containers-firewall#firewall_outbound) para recursos de infraestrutura e para os serviços do {{site.data.keyword.Bluemix_notm}} que você planeja usar.
4. Crie um cluster:
  * [Crie um cluster com a CLI](/docs/containers?topic=containers-clusters#clusters_cli) e use o sinalizador `--private-service-endpoint`. Se você também desejar ativar o terminal em serviço público, use o sinalizador `--public-service-endpoint`.
  * [Crie um cluster com a IU](/docs/containers?topic=containers-clusters#clusters_ui_standard) e selecione **Somente terminal privado**. Se você também desejar ativar o terminal em serviço público, selecione **Terminais públicos e privados**.
5. Se você ativar o terminal em serviço privado apenas para um cluster em um ambiente atrás de um firewall:
  1. Verifique se você está em sua rede privada do {{site.data.keyword.Bluemix_notm}} ou conectado à rede privada por meio de uma conexão VPN.
  2. [Permita que os usuários de cluster autorizados executem comandos `kubectl`](/docs/containers?topic=containers-firewall#firewall_kubectl) para acessar o mestre por meio do terminal em serviço privado. Os usuários do cluster devem estar em sua rede privada do {{site.data.keyword.Bluemix_notm}} ou se conectar à rede privada por meio de uma conexão VPN para executar os comandos `kubectl`.
  3. Se o seu acesso à rede estiver protegido por um firewall da empresa, você deverá [permitir acesso aos terminais públicos para a API `ibmcloud` e a API `ibmcloud ks` em seu firewall ](/docs/containers?topic=containers-firewall#firewall_bx). Embora toda a comunicação com o mestre seja por meio da rede privada, os comandos `ibmcloud` e `ibmcloud ks` devem passar pelos terminais de API pública.

  </br>

** Etapas para ativar após a criação do cluster **</br>
1. Ative o [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) em sua conta de infraestrutura do IBM Cloud (SoftLayer).
2. [Ative sua conta do {{site.data.keyword.Bluemix_notm}} para usar os terminais em serviço](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Ative o terminal em serviço privado.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
4. Atualize o servidor da API mestre do Kubernetes para usar o terminal em serviço privado. É possível seguir o prompt na CLI ou executar manualmente o comando a seguir.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

5. [Crie um configmap](/docs/containers?topic=containers-update#worker-up-configmap) para controlar o número máximo de nós do trabalhador que podem estar indisponíveis por vez em seu cluster. Quando você atualiza seus nós do trabalhador, o configmap ajuda a evitar o tempo de inatividade para seus apps, pois os apps são reagendados de forma ordenada em nós do trabalhador disponíveis.
6. Atualize todos os nós do trabalhador em seu cluster para selecionar a configuração de terminal em serviço privado.

  <p class="important">Emitindo o comando de atualização, os nós do trabalhador são recarregados para selecionar a configuração de terminal em serviço. Se nenhuma atualização do trabalhador está disponível, deve-se [recarregar os nós do trabalhador manualmente](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Se você recarregar, certifique-se de bloquear, drenar e gerenciar o pedido para controlar o número máximo de nós do trabalhador que estão indisponíveis por vez.</p>
  ```
  ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}

8. Se o cluster estiver em um ambiente atrás de um firewall:
  * [Permita que os usuários de cluster autorizados executem comandos `kubectl` para acessar o mestre por meio do terminal em serviço privado. ](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * [Permita o tráfego de rede de saída para os IPs privados](/docs/containers?topic=containers-firewall#firewall_outbound) para recursos de infraestrutura e para os serviços do {{site.data.keyword.Bluemix_notm}} que você planeja usar.

9. Opcional: para usar o terminal em serviço privado apenas, desative o terminal em serviço público.
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
  </br>

** Etapas para desativar **</br>
O terminal em serviço privado não pode ser desativado.

## Configurando o terminal em serviço público
{: #set-up-public-se}

Ative ou desative o terminal em serviço público para seu cluster.
{: shortdesc}

O terminal em serviço público torna o mestre do Kubernetes publicamente acessível. Seus nós do trabalhador e seus usuários de cluster autorizados podem se comunicar de forma segura com o mestre do Kubernetes na rede pública. Para determinar se é possível ativar o terminal em serviço público, consulte [Planejando a comunicação entre os nós do trabalhador e o mestre do Kubernetes](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master).

** Etapas para ativar durante a criação do cluster **</br>

1. Se criar o cluster em um ambiente atrás de um firewall, [permita o tráfego de rede de saída para os IPs públicos e privados](/docs/containers?topic=containers-firewall#firewall_outbound) para os serviços do {{site.data.keyword.Bluemix_notm}} que você planeja usar.

2. Crie um cluster:
  * [Crie um cluster com a CLI](/docs/containers?topic=containers-clusters#clusters_cli) e use o sinalizador `--public-service-endpoint`. Se você desejar ativar o terminal em serviço privado também, use o sinalizador `--private-service-endpoint` também.
  * [Crie um cluster com a IU](/docs/containers?topic=containers-clusters#clusters_ui_standard) e selecione **Somente terminal público**. Se você também desejar ativar o terminal em serviço privado, selecione **Terminais públicos e privados**.

3. Se você criar o cluster em um ambiente protegido por um firewall, [permita que os usuários de cluster autorizados executem comandos `kubectl` para acessar o principal por meio do terminal em serviço público apenas ou por meio dos terminais em serviço público e privado.](/docs/containers?topic=containers-firewall#firewall_kubectl)

  </br>

** Etapas para ativar após a criação do cluster **</br>
Se você desativou anteriormente o terminal público, será possível reativá-lo.
1. Ative o terminal em serviço público.
  ```
  ibmcloud ks cluster-feature-enable public-service-endpoint -- cluster < cluster_name_or_ID>
  ```
  {: pre}
2. Atualize o servidor da API do mestre do Kubernetes para usar o terminal em serviço público. É possível seguir o prompt na CLI ou executar manualmente o comando a seguir.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

  </br>

** Etapas para desativar **</br>
Para desativar o terminal em serviço público, deve-se primeiro ativar o terminal em serviço privado para que seus nós do trabalhador possam se comunicar com o mestre do Kubernetes.
1. Ative o terminal em serviço privado.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
2. Atualize o servidor de API do mestre do Kubernetes para usar o terminal em serviço privado, seguindo o prompt da CLI ou executando manualmente o comando a seguir.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
3. [Crie um configmap](/docs/containers?topic=containers-update#worker-up-configmap) para controlar o número máximo de nós do trabalhador que podem estar indisponíveis por vez em seu cluster. Quando você atualiza seus nós do trabalhador, o configmap ajuda a evitar o tempo de inatividade para seus apps, pois os apps são reagendados de forma ordenada em nós do trabalhador disponíveis.

4. Atualize todos os nós do trabalhador em seu cluster para selecionar a configuração de terminal em serviço privado.

  <p class="important">Emitindo o comando de atualização, os nós do trabalhador são recarregados para selecionar a configuração de terminal em serviço. Se nenhuma atualização do trabalhador está disponível, deve-se [recarregar os nós do trabalhador manualmente](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Se você recarregar, certifique-se de bloquear, drenar e gerenciar o pedido para controlar o número máximo de nós do trabalhador que estão indisponíveis por vez.</p>
  ```
  ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}
5. Desativar o terminal em serviço público.
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}

## Alternando do terminal em serviço público para o terminal em serviço privado
{: #migrate-to-private-se}

Em clusters que executam o Kubernetes versão 1.11 ou mais recente, ative os nós do trabalhador para se comunicar com o mestre por meio da rede privada em vez da rede pública, ativando o terminal em serviço privado.
{: shortdesc}

Todos os clusters que estão conectados a uma VLAN pública e privada usam o terminal em serviço público por padrão. Seus nós do trabalhador e seus usuários de cluster autorizados podem se comunicar de forma segura com o mestre do Kubernetes na rede pública. Para permitir que os nós do trabalhador se comuniquem com o mestre do Kubernetes por meio da rede privada em vez da rede pública, é possível ativar o terminal em serviço privado. Posteriormente, é possível desativar opcionalmente o terminal em serviço público.
* Se você ativar o terminal em serviço privado e mantiver o terminal em serviço público ativado também, os trabalhadores sempre se comunicarão com o mestre por meio da rede privada, mas seus usuários poderão se comunicar com o mestre por meio da rede pública ou privada.
* Se você ativar o terminal em serviço privado, mas desativar o terminal em serviço público, os trabalhadores e os usuários deverão se comunicar com o mestre por meio da rede privada.

Observe que não é possível desativar o terminal em serviço privado depois de ativá-lo.

1. Ative o [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) em sua conta de infraestrutura do IBM Cloud (SoftLayer).
2. [Ative sua conta do {{site.data.keyword.Bluemix_notm}} para usar os terminais em serviço](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Ative o terminal em serviço privado.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
4. Atualize o servidor de API do mestre do Kubernetes para usar o terminal em serviço privado, seguindo o prompt da CLI ou executando manualmente o comando a seguir.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
5. [Crie um configmap](/docs/containers?topic=containers-update#worker-up-configmap) para controlar o número máximo de nós do trabalhador que podem estar indisponíveis por vez em seu cluster. Quando você atualiza seus nós do trabalhador, o configmap ajuda a evitar o tempo de inatividade para seus apps, pois os apps são reagendados de forma ordenada em nós do trabalhador disponíveis.

6.  Atualize todos os nós do trabalhador em seu cluster para selecionar a configuração de terminal em serviço privado.

    <p class="important">Emitindo o comando de atualização, os nós do trabalhador são recarregados para selecionar a configuração de terminal em serviço. Se nenhuma atualização do trabalhador está disponível, deve-se [recarregar os nós do trabalhador manualmente](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Se você recarregar, certifique-se de bloquear, drenar e gerenciar o pedido para controlar o número máximo de nós do trabalhador que estão indisponíveis por vez.</p>
    ```
    ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
    {: pre}

7. Opcional: desative o terminal em serviço público.
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
