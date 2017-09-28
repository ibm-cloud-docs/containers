---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# Planejando clusters e apps
{: #cs_planning}

O {{site.data.keyword.containershort_notm}} oferece diversas
opções para configurar seu cluster do Kubernetes para atender aos requisitos funcionais e não funcionais
da organização. Algumas dessas configurações não podem ser mudadas depois que um cluster é
criado. Conhecer essas configurações com antecedência pode ajudar a assegurar que todos os recursos, como
memória, espaço em disco e endereços IP, estejam disponíveis para a equipe de desenvolvimento.
{:shortdesc}

## Comparação de clusters lite e padrão
{: #cs_planning_cluster_type}

É possível criar um cluster lite para familiarizar-se e testar os recursos do Kubernetes ou criar um cluster padrão para começar a implementar os seus apps com os recursos completos do Kubernetes.
{:shortdesc}

|Características|Clusters lite|Clusters padrão|
|---------------|-------------|-----------------|
|[Disponível no {{site.data.keyword.Bluemix_notm}} Public](cs_ov.html#public_environment)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Rede privada em um cluster](#cs_planning_private_network)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app público por um serviço Nodeport](#cs_nodeport)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Gerenciamento de acesso do usuário](cs_cluster.html#cs_cluster_user)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao serviço do {{site.data.keyword.Bluemix_notm}} por meio do cluster e de apps](cs_cluster.html#cs_cluster_service)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Espaço em disco no nó do trabalhador para armazenamento](#cs_planning_apps_storage)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Armazenamento persistente baseado em arquivo NFS com volumes](#cs_planning_apps_storage)||<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app público por um serviço de balanceador de carga](#cs_loadbalancer)||<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app público por um serviço de Ingresso](#cs_ingress)||<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Endereços IP públicos móveis](cs_apps.html#cs_cluster_ip_subnet)||<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Disponível no {{site.data.keyword.Bluemix_notm}} Dedicated (Beta encerrado)](cs_ov.html#dedicated_environment)||<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
{: caption="Tabela 1. Diferenças entre clusters lite e padrão" caption-side="top"}

## Configuração de Cluster
{: #cs_planning_cluster_config}

Use clusters padrão para aumentar a disponibilidade do app. É menos provável que seus usuários
experimentem tempo de inatividade quando você distribuir a configuração entre múltiplos nós do trabalhador e clusters. Recursos integrados, como balanceamento de carga e isolamento, aumentam a resiliência com relação a potenciais
falhas com hosts, redes ou apps.
{:shortdesc}

Revise estas potenciais configurações de cluster que são ordenadas com graus crescentes de
disponibilidade:

[![Estágios de alta disponibilidade para um cluster](images/cs_cluster_ha_roadmap.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_cluster_ha_roadmap.png)

1.  Um cluster com múltiplos nós do trabalhador
2.  Dois clusters que são executados em diferentes locais na mesma região, cada um com
múltiplos nós do trabalhador
3.  Dois clusters que são executados em diferentes regiões, cada um com múltiplos nós do trabalhador

Saiba mais sobre como é possível usar essas técnicas para aumentar a disponibilidade de seu cluster:

<dl>
<dt>Incluir nós do trabalhador suficientes para difundir instâncias do app</dt>
<dd>Para alta disponibilidade, permita que os desenvolvedores de app difundam seus contêineres em múltiplos
nós do trabalhador por cluster. Três nós do trabalhador permitem que o tempo de inatividade de um nó do trabalhador ocorra sem interromper o uso do app. É possível especificar quantos nós do trabalhador incluir ao criar um cluster por meio da [GUI do {{site.data.keyword.Bluemix_notm}}](cs_cluster.html#cs_cluster_ui) ou da [CLI](cs_cluster.html#cs_cluster_cli). O Kubernetes limita o número máximo de nós do trabalhador que você pode ter em um cluster. Revise [cotas de nó do trabalhador e de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/cluster-large/) para obter mais informações.
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>Difundir apps entre clusters</dt>
<dd>Crie múltiplos clusters, cada um com múltiplos nós do trabalhador. Se uma indisponibilidade ocorrer com o
cluster, ainda assim os usuários poderão acessar um app que também esteja implementado em outro cluster.
<p>Cluster
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Cluster
2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>Difundir apps entre clusters em diferentes regiões</dt>
<dd>Ao difundir aplicativos entre clusters em diferentes regiões, é possível permitir que o balanceamento de carga
ocorra com base na região em que o usuário está. Se o cluster, hardware ou até mesmo um local inteiro em
uma região ficar inativo, o tráfego será roteado para o contêiner que estiver implementado em outro local.
<p><strong>Importante:</strong> depois de configurar seu domínio customizado, será possível usar esses comandos para criar os clusters.</p>
<p>Local 1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Local 2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>


## Configuração do nó do trabalhador
{: #cs_planning_worker_nodes}

Um cluster do Kubernetes consiste em nós do trabalhador da máquina virtual e é monitorado e gerenciado
centralmente pelo mestre do Kubernetes. Os administradores de cluster devem decidir como configurar o cluster de nós
do trabalhador para assegurar que os usuários do cluster tenham todos os recursos para implementar e executar apps no
cluster.
{:shortdesc}

Ao criar um cluster padrão, os nós do trabalhador serão ordenados no {{site.data.keyword.BluSoftlayer_full}} em seu nome e configurados no {{site.data.keyword.Bluemix_notm}}. A cada nó do trabalhador é designado
um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados após a criação do cluster. Dependendo do nível de
isolamento de hardware escolhido, os nós do trabalhador podem ser configurados como nós compartilhados ou dedicados. Cada
nó do trabalhador é provisionado com um tipo específico de máquina que determina o número de vCPUs, memória
e espaço em disco que estão disponíveis para os contêineres que são implementados no nó do trabalhador. O Kubernetes limita o número máximo de nós do trabalhador que você pode ter em um cluster. Revise [cotas de nó do trabalhador e de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/cluster-large/) para obter mais informações.


### Hardware para nós do trabalhador
{: #shared_dedicated_node}

Cada nó do trabalhador é configurado como uma máquina virtual no hardware físico. Ao criar um cluster padrão no {{site.data.keyword.Bluemix_notm}} Public, você deverá escolher se deseja que o hardware subjacente seja compartilhado por múltiplos clientes {{site.data.keyword.IBM_notm}} (multiocupação) ou seja dedicado somente a você (ocupação única).
{:shortdesc}

Em uma configuração de diversos locatários, os recursos físicos, como CPU e memória, são compartilhados entre todas as
máquinas virtuais implementadas no mesmo hardware físico. Para assegurar que cada máquina
virtual possa ser executada independentemente, um monitor de máquina virtual, também referido como hypervisor,
segmenta os recursos físicos em entidades isoladas e aloca como recursos dedicados para
uma máquina virtual (isolamento de hypervisor).

Em uma configuração de locatário único, todos os recursos físicos são dedicados somente a você. É possível implementar
múltiplos nós do trabalhador como máquinas virtuais no mesmo host físico. Semelhante à configuração de diversos locatários,
o hypervisor assegura que cada nó do trabalhador obtenha seu compartilhamento dos recursos físicos
disponíveis.

Os nós compartilhados são geralmente mais baratos do que os nós dedicados porque os custos para o hardware
subjacente são compartilhados entre múltiplos clientes. No entanto, ao decidir entre nós compartilhados
e dedicados, você pode desejar verificar com seu departamento jurídico para discutir o nível de isolamento
e conformidade de infraestrutura que seu ambiente de app requer.

Ao criar um cluster lite, seu nó do trabalhador é provisionado automaticamente como um nó compartilhado na conta do {{site.data.keyword.BluSoftlayer_notm}} da {{site.data.keyword.IBM_notm}}.

Ao criar um cluster no {{site.data.keyword.Bluemix_notm}} Dedicated, é usada
uma configuração somente de locatário único e todos os recursos físicos são dedicados somente a você. Você implementa
múltiplos nós do trabalhador como máquinas virtuais no mesmo host físico.

## Implementações
{: #highly_available_apps}

Quanto mais amplamente você distribui a configuração entre múltiplos nós do trabalhador e clusters,
menos provável que os usuários tenham que experimentar tempo de inatividade com seu app.
{:shortdesc}

Revise estas configurações de app em potencial que são ordenadas com graus crescentes de
disponibilidade:

[![Estágios de alta disponibilidade para um app](images/cs_app_ha_roadmap.png)](../api/content/containers/images/cs_app_ha_roadmap.png)

1.  Uma implementação com n + 2 pods que são gerenciados por um conjunto de réplicas.
2.  Uma implementação com n + 2 pods que são gerenciados por um conjunto de réplicas e difundidos em múltiplos nós
(antiafinidade) no mesmo local.
3.  Uma implementação com n+2 pods que são gerenciados por um conjunto de réplicas e difundidos em
múltiplos nós (antiafinidade) em diferentes locais.
4.  Uma implementação com n + 2 pods que são gerenciados por um conjunto de réplicas e difundidos em
múltiplos nós (antiafinidade) em diferentes regiões.

Saiba mais sobre as técnicas para aumentar a disponibilidade de seu app:

<dl>
<dt>Usar implementações e conjuntos de réplicas para implementar seu app e suas dependências</dt>
<dd>Uma implementação é um recurso do Kubernetes que pode ser usado para declarar todos os componentes do app e
suas dependências. Descrever os componentes únicos em vez de escrever todas as etapas necessárias
e a ordem para criá-las, é possível se concentrar em como o app deve se parecer quando estiver
em execução.

</br>
Ao implementar mais de um pod, um conjunto de réplicas é criado automaticamente para as suas
implementações e monitora os pods e assegura que o número desejado de pods esteja ativo e em execução
sempre. Quando um pod fica inativo, o conjunto de réplicas substitui o pod não responsivo por um novo.
</br></br>
É possível usar uma implementação para definir estratégias de atualização para seu app incluindo o número de
módulos que você deseja incluir durante uma atualização contínua e o número de pods que podem estar indisponíveis
por vez. Ao executar uma atualização contínua, a implementação verifica se a revisão está ou não
funcionando e para o lançamento quando falhas são detectadas.
</br>
As implementações também fornecem a possibilidade
de implementar simultaneamente múltiplas revisões com diferentes sinalizações, portanto é possível, por exemplo, testar uma
implementação primeiro antes de decidir enviá-la por push para a produção.
</br></br>
Cada implementação mantém o controle
das revisões que foram implementadas. É possível usar esse histórico de revisões para retroceder para uma versão
anterior quando encontrar que as atualizações não estão funcionando conforme o esperado.</dd>
<dt>Incluir réplicas suficientes para a carga de trabalho de seu app, mais duas</dt>
<dd>Para tornar seu app ainda mais altamente disponível e mais resiliente à falha, considere a inclusão
de réplicas extras, além do mínimo, para manipular a carga de trabalho esperada. As réplicas extras podem manipular a
carga de trabalho no caso de um pod travar e o conjunto de réplicas ainda não tiver recuperado o pod travado. Para
proteção contra duas falhas simultâneas, inclua duas réplicas extras. Essa configuração é um padrão
N + 2, em que N é o número de réplicas para manipular a carga de trabalho recebida e + 2 são duas
réplicas extras.</dd>
<dt>Difundir pods em múltiplos nós (antiafinidade)</dt>
<dd>Ao criar sua implementação, cada pod pode ser implementado no mesmo nó do trabalhador. Essa configuração
na qual os pods existem no mesmo nó do trabalhador é conhecida como afinidade ou colocação. Para proteger o app
de uma falha do nó do trabalhador, é possível impingir a implementação para difundir os pods em múltiplos
nós do trabalhador usando a opção <strong>podAntiAffinity</strong>. Essa opção está disponível
somente para clusters padrão.

</br></br>
<strong>Nota:</strong> o arquivo YAML a seguir garante que cada pod seja implementado em um nó do trabalhador diferente. Quando você tem mais réplicas definidas do que tem nós do trabalhador disponíveis
no cluster, somente o número de réplicas que podem cumprir o requisito de antiafinidade
é implementado. Quaisquer réplicas adicionais permanecem em um estado pendente até que os nós do trabalhador adicionais sejam
incluídos no cluster.

<pre class="codeblock">
<code>apiVersion: v1
kind: Service
metadados:
  name: wasliberty
  labels:
    app: wasliberty
spec:
  ports:
    # the port that this service should serve on
  - port: 9080
  selector:
    app: wasliberty
  type: NodePort
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: wasliberty
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: wasliberty
      annotations:
        scheduler.alpha.kubernetes.io/affinity: >
            {
              "podAntiAffinity": {
                "requiredDuringSchedulingIgnoredDuringExecution": [
                  {
                    "labelSelector": {
                      "matchExpressions": [
                        {
                          "key": "app",
                          "operator": "In",
                          "values": ["wasliberty"]
                        }
                      ]
                    },
                    "topologyKey": "kubernetes.io/hostname"
                 }
                ]
               }
             }
    spec:
      containers:
      - name: wasliberty
        image: registry.&lt;region&gt;.bluemix.net/ibmliberty
        ports:
          - containerPort: 9080</code></pre>

</dd>
<dt>Distribuir pods em múltiplos locais ou regiões</dt>
<dd>Para proteger o app contra uma falha de local ou de região, será possível criar um segundo cluster em outro local ou região e usar um YAML de implementação para implementar um conjunto de réplicas duplicadas para o seu app. Incluindo uma rota e um balanceador de carga compartilhados na frente de seus clusters, é possível difundir a
carga de trabalho entre os locais e regiões. Para obter mais informações sobre compartilhamento de uma rota entre clusters, veja <a href="https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster" target="_blank">Alta disponibilidade de clusters</a>.

Para obter mais detalhes, revise as opções para <a href="https://console.bluemix.net/docs/containers/cs_planning.html#cs_planning_cluster_config" target="_blank">implementações altamente disponíveis</a>.</dd>
</dl>

### Implementação de app mínimo
{: #minimal_app_deployment}

Uma implementação básica do app em um cluster lite ou padrão pode incluir os componentes a seguir.
{:shortdesc}

<a href="../api/content/containers/images/cs_app_tutorial_components1.png">![Configuração de implementação](images/cs_app_tutorial_components1.png)</a>

Exemplo de script de configuração para um app mínimo.
```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.<region>.bluemix.net/ibmliberty:latest
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    run: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

## Rede privada
{: #cs_planning_private_network}

A comunicação de rede privada assegurada entre os nós do trabalhador e os pods é realizada com
redes locais virtuais privadas, também referidas como VLANs privadas. Uma VLAN configura um grupo de
nós do trabalhador e pods como se eles estivessem conectados à mesma ligação física.
{:shortdesc}

Ao criar um cluster, cada cluster é conectado automaticamente a uma VLAN privada. A VLAN privada
determina o endereço IP privado que é designado a um nó do trabalhador durante a criação de cluster.

|Tipo de cluster|Gerenciador da VLAN privada para o cluster|
|------------|-------------------------------------------|
|Clusters lite no {{site.data.keyword.Bluemix_notm}} Public|{{site.data.keyword.IBM_notm}}|
|Clusters padrão no {{site.data.keyword.Bluemix_notm}} Public|Você na sua conta do {{site.data.keyword.BluSoftlayer_notm}} <p>**Dica:** para ter acesso a todas as VLANs em sua conta, ative a [Ampliação de VLAN ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/procedure/enable-or-disable-vlan-spanning).</p>|
|Clusters padrão no {{site.data.keyword.Bluemix_notm}} Dedicated|{{site.data.keyword.IBM_notm}}|
{: caption="Tabela 2. Responsabilidades de gerenciamento da VLAN privada" caption-side="top"}

Todos os pods implementados em um nó do trabalhador também são designados a um endereço IP privado. Os pods são
designados a um IP na variação de endereços privados 172.30.0.0/16 e são roteados somente entre os nós do trabalhador. Para evitar conflitos, não use esse intervalo de IPs em nós que se comunicarão com seus nós do
trabalhador. Os nós do trabalhador e os pods podem se comunicar com segurança na rede privada usando os endereços IP
privados. No entanto, quando um pod trava ou um nó do trabalhador precisa ser recriado, um novo endereço IP privado
é designado.

Visto que é difícil rastrear a mudança de endereços IP privados para apps que devem ser altamente disponíveis, é possível usar os recursos integrados de descoberta de serviço do Kubernetes e expor os apps como serviços IP do cluster na rede privada no cluster. Um serviço do Kubernetes agrupa um conjunto
de pods e fornece conexão de rede a esses pods para outros serviços no cluster sem
expor o endereço IP privado real de cada pod. Ao criar um serviço IP do cluster, um endereço IP privado é designado a esse serviço do intervalo de endereços privados 10.10.10.0/24. Como ocorre com a variação de endereços
privados do pod, não use esse intervalo de IP em nós que se comunicarão com seus nós do trabalhador. Esse endereço IP é acessível somente dentro do cluster. Não
é possível acessar esse endereço IP na Internet. Ao mesmo tempo, uma entrada de consulta de DNS é criada para
o serviço e armazenada no componente kube-dns do cluster. A entrada DNS contém o nome do
serviço, o namespace no qual o serviço foi criado e o link para o endereço IP do cluster privado
designado.

Se um app no cluster precisar acessar um pod que esteja atrás de um serviço IP do cluster, ele poderá usar o endereço IP do cluster privado que foi designado ao serviço ou enviar uma solicitação usando o nome do serviço. Ao usar o nome do serviço, o nome é consultado no
componente kube-dns e roteado para o endereço IP do cluster privado do serviço. Quando uma solicitação
atinge o serviço, o serviço assegura que todas as solicitações sejam igualmente encaminhadas para os pods,
independentemente de seus endereços IP privados e o nó do trabalhador no qual eles estão implementados.

Para obter mais informações sobre como criar um serviço do tipo IP do cluster, veja [Serviços do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services---service-types).


## Rede pública
{: #cs_planning_public_network}

Ao criar um cluster, cada cluster deve ser conectado a uma VLAN pública. A VLAN pública
determina o endereço IP público que é designado a um nó do trabalhador durante a criação de cluster.
{:shortdesc}

Uma VLAN pública é protegida por um firewall do {{site.data.keyword.BluSoftlayer_notm}} que não permite conectividade de entrada ou de saída para a Internet por padrão. Embora o mestre do Kubernetes e os nós do trabalhador se comuniquem por VLAN pública usando seus
endereços IP públicos designados, eles não podem ser atingidos a partir da Internet.

|Tipo de cluster|Gerenciador da VLAN pública para o cluster|
|------------|------------------------------------------|
|Clusters lite no {{site.data.keyword.Bluemix_notm}} Public|{{site.data.keyword.IBM_notm}}|
|Clusters padrão no {{site.data.keyword.Bluemix_notm}} Public|Você na sua conta do {{site.data.keyword.BluSoftlayer_notm}}|
|Clusters padrão no {{site.data.keyword.Bluemix_notm}} Dedicated|{{site.data.keyword.IBM_notm}}|
{: caption="Tabela 3. Responsabilidades de gerenciamento da VLAN" caption-side="top"}

Dependendo de você ter criado um cluster lite ou padrão, será possível escolher entre as opções a seguir para expor um app ao público.

-   [Serviço do tipo NodePort](#cs_nodeport) (clusters lite e padrão)
-   [Serviço do tipo LoadBalancer](#cs_loadbalancer) (somente clusters padrão)
-   [Ingresso](#cs_ingress) (somente
clusters padrão)


### Expor um app à Internet usando um serviço do tipo NodePort
{: #cs_nodeport}

Exponha uma porta pública em seu nó do trabalhador e use o endereço IP público do nó do trabalhador
para acessar publicamente seu serviço no cluster.
{:shortdesc}

[![Expor um serviço usando um serviço do Kubernetes do tipo NodePort](images/cs_nodeport.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_nodeport.png)

Ao expor seu app criando um serviço do Kubernetes do tipo NodePort, um NodePort no intervalo de 30.000 a 32.767 e um endereço IP interno do cluster são designados ao serviço. O serviço NodePort serve como o ponto de entrada externo para solicitações recebidas para seu app.
O NodePort designado é exposto publicamente nas configurações kubeproxy de cada nó do trabalhador no
cluster. Cada nó do trabalhador inicia o atendimento no NodePort designado para solicitações recebidas para o
serviço. Para acessar o serviço por meio da Internet, será possível usar o endereço IP público de qualquer nó do trabalhador que tenha sido designado durante a criação do cluster e o NodePort no formato `<ip_address>:<nodeport>`.

Quando uma solicitação pública chega ao serviço NodePort, ela é encaminhada automaticamente para o IP interno do cluster do serviço e encaminhada posteriormente do componente kubeproxy para o endereço IP privado do pod no qual o app está implementado. O IP do cluster é
acessível somente dentro do cluster. Se você tiver múltiplas réplicas de seu app em execução em diferentes
pods, o componente kubeproxy balanceará a carga das solicitações recebidas entre todas as réplicas.

**Nota:** Lembre-se de que o endereço IP público do nó do trabalhador não é permanente. Quando um nó do trabalhador é removido ou recriado, um novo endereço IP público é designado ao
nó do trabalhador. É possível usar o serviço do tipo NodePort para testar o acesso público para seu app ou
quando o acesso público é necessário por somente um curto tempo. Quando você requerer um endereço IP público estável e mais disponibilidade para o seu serviço, exponha seu app usando um [serviço do tipo LoadBalancer](#cs_loadbalancer) ou [Ingresso](#cs_ingress).

Para obter mais informações sobre como criar um serviço do tipo NodePort com o {{site.data.keyword.containershort_notm}}, veja [Configurando o acesso público a um app usando o tipo de serviço NodePort](cs_apps.html#cs_apps_public_nodeport).


### Expor um app à Internet usando um serviço do tipo LoadBalancer
{: #cs_loadbalancer}

Exponha uma porta e usar o endereço IP público para o balanceador de carga para acessar o app.

[![Expor um serviço usando um serviço do Kubernetes do tipo LoadBalancer](images/cs_loadbalancer.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_loadbalancer.png)

Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} solicita automaticamente 5 endereços IP
públicos móveis e os provisiona em sua conta do {{site.data.keyword.BluSoftlayer_notm}} durante a criação do cluster. Um dos
endereços IP móveis é usado para o [controlador de Ingresso](#cs_ingress). Os 4 endereços IP públicos móveis podem ser usados para expor apps ao público criando um serviço do tipo LoadBalancer.

Ao criar um serviço do Kubernetes do tipo LoadBalancer, um balanceador de carga externo é criado e um dos 4 endereços IP públicos disponíveis é designado a ele. Se nenhum endereço
IP público móvel estiver disponível, a criação de seu serviço LoadBalancer falhará. O serviço LoadBalancer serve como o ponto de entrada externo para solicitações recebidas para o app. Ao contrário dos serviços do tipo NodePort, será possível designar qualquer porta ao balanceador de carga e não ficará limitado a um determinado intervalo de portas. O endereço IP público móvel designado ao serviço LoadBalancer é permanente e não muda quando um nó do trabalhador é removido ou recriado, tornando o serviço LoadBalancer mais disponível do que o serviço NodePort. Para acessar o serviço LoadBalancer por meio da Internet, use o endereço IP público do balanceador de carga e a porta designada no formato `<ip_address>:<port>`.

Quando uma solicitação pública chega no serviço LoadBalancer, ela é encaminhada automaticamente para o endereço IP interno do cluster designado ao serviço LoadBalancer durante a criação do serviço. O endereço IP do cluster é acessível somente dentro do cluster. No endereço IP
do cluster, as solicitações são encaminhadas adicionalmente ao componente kubeproxy do nó do trabalhador e,
em seguida, para o endereço IP privado do pod no qual o app está implementado. Se você tiver múltiplas réplicas de seu app em execução em diferentes
pods, o componente kubeproxy balanceará a carga das solicitações recebidas entre todas as réplicas.

Para obter mais informações sobre como criar um serviço do tipo LoadBalancer com o {{site.data.keyword.containershort_notm}}, veja [Configurando o acesso público a um app usando o tipo de serviço de balanceador de carga](cs_apps.html#cs_apps_public_load_balancer).



### Expor um app à Internet com Ingresso
{: #cs_ingress}

O Ingresso permite expor múltiplos serviços em seu cluster e torná-los publicamente
disponíveis usando um único ponto de entrada público.

[![Expor um serviço usando o suporte de ingresso do {{site.data.keyword.containershort_notm}}](images/cs_ingress.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_ingress.png)

Em vez de criar um serviço de balanceador de carga para cada app que você desejar expor ao público, o Ingresso fornece uma rota pública exclusiva que permite encaminhar solicitações públicas para apps dentro e fora do seu cluster com base em seus caminhos individuais. O ingresso consiste em dois componentes principais. O
recurso de Ingresso define as regras de como rotear solicitações recebidas para um app. Todos os recursos de Ingresso devem ser registrados com o controlador de Ingresso que atende a solicitações de serviço HTTP ou HTTPS recebidas e encaminha solicitações com base nas regras definidas para cada recurso de Ingresso.

Quando você cria um cluster padrão, o {{site.data.keyword.containershort_notm}} cria automaticamente um controlador do Ingresso altamente disponível para seu cluster e designa uma rota pública exclusiva com o formato `<cluster_name>.<region>.containers.mybluemix.net` a ele. A rota pública está vinculada a um endereço IP público móvel que é provisionado em sua
conta do {{site.data.keyword.BluSoftlayer_notm}} durante a criação de cluster.

Para expor um app por meio de Ingresso, deve-se criar um serviço Kubernetes para seu app e registrá-lo
com o controlador de Ingresso definindo um recurso de Ingresso. O recurso de Ingresso especifica o caminho que você deseja anexar à rota pública para formar uma URL exclusiva para seu app exposto, como por exemplo: `mycluster.us-south.containers.mybluemix.net/myapp`. Quando você
inserir essa rota em seu navegador da web, a solicitação será enviada ao endereço IP público móvel vinculado
do controlador do Ingresso. O controlador de Ingresso verifica se existe uma regra de roteamento para o caminho `myapp` no
cluster `mycluster`. Se uma regra de correspondência for localizada, a solicitação incluindo
o caminho individual será encaminhada para o pod no qual o app está implementado, considerando as regras que
foram definidas no objeto de recurso de Ingresso original. Para que o app processe solicitações
recebidas, certifique-se de que seu app atenda no caminho individual que você definiu no recurso de
Ingresso.

É possível configurar o controlador de Ingresso para gerenciar o tráfego de rede recebido para seus apps para os
cenários a seguir:

-   Usar o domínio fornecido pela IBM sem finalização TLS
-   Usar o domínio fornecido pela IBM e o certificado TLS com finalização TLS
-   Usar seu domínio customizado e certificado TLS para executar a finalização TLS
-   Usar o domínio fornecido pela IBM ou um customizado e os certificados TLS para acessar apps fora do seu
cluster
-   Inclua recursos em seu controlador do Ingresso usando anotações

Para obter mais informações sobre como usar o Ingresso com o {{site.data.keyword.containershort_notm}}, veja [Configurando o acesso público a um app usando o controlador de Ingresso](cs_apps.html#cs_apps_public_ingress).


## Gerenciamento de acesso do usuário
{: #cs_planning_cluster_user}

É possível conceder acesso a um cluster para outros usuários em sua organização para assegurar que
somente os usuários autorizados possam trabalhar com o cluster e implementar apps no cluster.
{:shortdesc}

Para obter mais informações, veja [Gerenciando usuários e o acesso a um cluster no {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_cluster_user). 


## Registros de imagem
{: #cs_planning_images}

Uma imagem do Docker é a base para cada contêiner que você cria. Uma imagem é criada por meio
de um Dockerfile, que é um arquivo que contém instruções para construir a imagem. Um Dockerfile pode
referenciar os artefatos de construção em suas instruções que são armazenadas separadamente, como um app, a configuração
do app e suas dependências.
{:shortdesc}

As imagens geralmente são armazenadas em um registro que pode ser acessado pelo público (registro público) ou configurado com acesso
limitado para um pequeno grupo de usuários (registro privado). Os registros
públicos, como Docker Hub, podem ser usados na introdução ao Docker e Kubernetes para criar seu
primeiro app conteinerizado em um cluster. Mas quando se trata de aplicativos corporativos, use um registro
privado como aquele fornecido no {{site.data.keyword.registryshort_notm}} para proteger suas imagens de serem usadas
e mudadas por usuários não autorizados. Os registros
privados devem ser configurados pelo administrador de cluster para assegurar que as credenciais para acessar o registro
privado estejam disponíveis para os usuários do cluster.

É possível usar múltiplos registros com o {{site.data.keyword.containershort_notm}} para implementar apps em seu cluster.

|Registro|Descrição|Benefício|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry/index.html)|Com essa opção, é possível configurar o seu próprio repositório de imagem do Docker seguro no {{site.data.keyword.registryshort_notm}} no qual é possível armazenar e compartilhar as imagens com segurança entre
usuários do cluster.|<ul><li>Gerencie o acesso a imagens em sua conta.</li><li>Use imagens e apps de amostra fornecidos pela {{site.data.keyword.IBM_notm}}, como o {{site.data.keyword.IBM_notm}} Liberty, como uma imagem pai e inclua seu próprio código de app nela.</li><li>Varredura automática de imagens para potenciais vulnerabilidades pelo Vulnerability Advisor, incluindo
recomendações específicas do S.O. para corrigi-las.</li></ul>|
|Qualquer outro registro privado|Conecte qualquer registro privado existente a seu cluster criando um [imagePullSecret ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/containers/images/). O segredo é usado para salvar com segurança sua URL de registro e credenciais em um
segredo do Kubernetes.|<ul><li>Use os registros privados existentes independentemente de sua origem (Docker Hub, registros pertencentes
à organização ou outros registros de Nuvem privada).</li></ul>|
|Docker Hub público|Use essa opção para usar imagens públicas existentes diretamente do Docker Hub quando nenhuma mudança
do Dockerfile for necessária. <p>**Nota:** lembre-se de que essa opção poderá não atender aos requisitos de segurança de sua organização, como gerenciamento de acesso, varredura de vulnerabilidade ou privacidade de app.</p>|<ul><li>Nenhuma configuração adicional é necessária para seu cluster.</li><li>Inclui uma variedade de aplicativos de software livre.</li></ul>|
{: caption="Tabela 4. Opções de registro de imagem pública e privada" caption-side="top"}

Depois de configurar um registro de imagem, os usuários do cluster podem usar as imagens para suas implementações de app
no cluster.

Para obter mais informações sobre como acessar um registro público ou privado e usar uma imagem para criar seu contêiner, veja [Usando registros de imagem privada e pública com o {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_apps_images).


## Armazenamento de dados persistentes
{: #cs_planning_apps_storage}

Um contêiner é, por design, de curta duração. No entanto, é possível escolher entre várias opções
para persistir dados no caso de um failover do contêiner e para compartilhar dados entre os contêineres.
{:shortdesc}

[![Opções de armazenamento persistente para implementações em clusters do Kubernetes](images/cs_planning_apps_storage.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_planning_apps_storage.png)

|Opção|Descrição|
|------|-----------|
|Opção 1: usar `/emptyDir` para persistir dados usando o espaço em disco disponível
no nó do trabalhador<p>Esse recurso está disponível para clusters lite e padrão.</p>|Com essa opção, é possível criar um volume vazio no espaço em disco do nó do trabalhador que
está designado a um pod. O contêiner nesse pod pode ler e gravar nesse volume. Como o
volume está designado a um pod específico, os dados não podem ser compartilhados com outros pods em um conjunto de réplicas.<p>Um volume `/emptyDir` e seus dados são removidos quando o pod designado é
excluído permanentemente do nó do trabalhador.</p><p>**Nota:** se o contêiner dentro do pod travar, os dados no volume ainda ficarão disponíveis no nó do trabalhador.</p><p>Para obter mais informações, veja [Volumes do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/storage/volumes/).</p>|
|Opção 2: criar uma solicitação de volume persistente para provisionar armazenamento persistente baseado em NFS para sua
implementação<p>Este recurso está disponível somente para clusters padrão.</p>|Com essa opção, é possível ter armazenamento persistente de dados do app e do contêiner por meio de um número ilimitado de compartilhamentos de arquivos NFS e de volumes persistentes. Você cria uma [solicitação de volume persistente](cs_apps.html) para iniciar uma solicitação para armazenamento de arquivo baseado em NFS. O {{site.data.keyword.containershort_notm}} fornece classes de armazenamento
predefinidas que definem o intervalo de tamanhos do armazenamento, o IOPS e as permissões de leitura e gravação para
o volume. É possível
escolher entre essas classes de armazenamento ao criar sua solicitação de volume persistente. Depois que você envia
uma solicitação de volume persistente, o {{site.data.keyword.containershort_notm}}
provisiona dinamicamente um volume persistente que está hospedado no armazenamento de arquivo baseado em NFS. [É possível montar a solicitação de volume persistente](cs_apps.html#cs_apps_volume_claim) como um volume para seu pod para permitir que o contêiner no pod leia e grave no volume. Os volumes persistentes podem ser
compartilhados entre o pods no mesmo conjunto de réplicas ou com outros pods no mesmo cluster.<p>Quando um
contêiner trava ou um pod é removido de um nó do trabalhador, os dados não são removidos e ainda podem ser
acessados por outros pods que montam o volume. As solicitações de volume persistente são hospedadas no armazenamento persistente, mas não possuem backups. Se você requerer um backup dos dados, crie um backup manual.</p><p>**Nota:** o armazenamento de compartilhamento de arquivo NFS é cobrado mensalmente. Se provisionar o armazenamento persistente para seu cluster e removê-lo
imediatamente, ainda assim terá que pagar o encargo mensal para o armazenamento persistente, mesmo se
você o usou somente por um curto tempo.</p>|
|Opção 3: ligar um serviço de banco de dados do {{site.data.keyword.Bluemix_notm}}
ao pod<p>Esse recurso está disponível para clusters lite e padrão.</p>|Com essa opção, é possível persistir e acessar dados usando um serviço de nuvem do banco de dados do {{site.data.keyword.Bluemix_notm}}. Ao ligar
o serviço do {{site.data.keyword.Bluemix_notm}} a um namespace em
seu cluster, um segredo do Kubernetes é criado. O segredo do Kubernetes retém a informação confidencial
sobre o serviço, como a URL para o serviço, seu nome do usuário e a senha. É possível montar o
segredo como um volume de segredo em seu pod e acessar o serviço usando as credenciais no segredo. Montando o volume de segredo em outros pods, também é possível compartilhar dados entre os pods.<p>Quando um
contêiner trava ou um pod é removido de um nó do trabalhador, os dados não são removidos e ainda podem ser
acessados por outros pods que montam o volume de segredo.</p><p>A maioria dos serviços de banco de dados do {{site.data.keyword.Bluemix_notm}} fornecem espaço em disco para
uma pequena quantia de dados sem custo, para que você possa testar seus recursos.</p><p>Para obter mais informações sobre como ligar um serviço do {{site.data.keyword.Bluemix_notm}} a um pod, veja [Incluindo serviços do {{site.data.keyword.Bluemix_notm}} para apps no {{site.data.keyword.containershort_notm}}](cs_apps.html#cs_apps_service).</p>|
{: caption="Tabela 5. Opções de armazenamento de dados persistentes para implementações em clusters do Kubernetes" caption-side="top"}


## Monitoramento de funcionamento
{: #cs_planning_health}

É possível usar os recursos Kubernetes e Docker padrão para monitorar o funcionamento de seu
cluster e os apps que são implementados nele.
{:shortdesc}
<dl>
<dt>Página de detalhes do cluster no {{site.data.keyword.Bluemix_notm}}</dt>
<dd>O {{site.data.keyword.containershort_notm}} fornece informações sobre o
funcionamento e a capacidade do cluster e o uso dos recursos de cluster. É possível usar essa
GUI para ampliar o cluster, trabalhar com seu armazenamento persistente e incluir recursos adicionais
no cluster por meio da ligação de serviço do
{{site.data.keyword.Bluemix_notm}}. Para visualizar a página de detalhes do cluster, acesse o **Painel do {{site.data.keyword.Bluemix_notm}}** e selecione um cluster.</dd>
<dt>Painel do Kubernetes</dt>
<dd>O painel do Kubernetes é uma interface administrativa da web que pode ser usada para revisar o
funcionamento de seus nós do trabalhador, localizar recursos do Kubernetes, implementar apps conteinerizados e
solucionar problemas de apps com base nas informações de criação de log e de monitoramento. Para obter mais informações sobre como acessar o painel do Kubernetes, veja [Ativando o painel do Kubernetes para o {{site.data.keyword.containershort_notm}}](cs_apps.html#cs_cli_dashboard).</dd>
<dt>Logs do Docker</dt>
<dd>É possível alavancar os recursos de criação de log do Docker integrados para revisar as atividades nos fluxos
de saída padrão STDOUT e STDERR. Para obter mais informações, veja [Visualizando logs de contêiner para um contêiner que é executado em um cluster do
Kubernetes](/docs/services/CloudLogAnalysis/containers/logging_containers_other_logs.html#logging_containers_collect_data).</dd>
<dt>Criando log e monitorando</dt>
<dd>O {{site.data.keyword.containershort_notm}} suporta os recursos de monitoramento
e criação de log adicionais para clusters padrão. Os logs e métricas estão localizados no
espaço do {{site.data.keyword.Bluemix_notm}} com login efetuado
quando o cluster do Kubernetes foi criado.<ul><li>As métricas do contêiner são coletadas automaticamente para todos os contêineres que são implementados em um cluster. Essas métricas são enviadas e disponibilizadas por meio de Grafana. Para obter mais informações sobre métricas, veja
[Monitorando para o {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/analyzing_metrics_bmx_ui.html#analyzing_metrics_bmx_ui).<p>Para acessar o painel do Grafana, acesse `https://metrics.<region>.bluemix.net`. Selecione a organização e o espaço do {{site.data.keyword.Bluemix_notm}} em que você criou
o cluster.</p></li><li>Os logs de contêiner são monitorados e encaminhados para fora do contêiner. É possível acessar logs
para um contêiner usando o painel do Kibana. Para obter mais informações sobre criação de log, veja [Criação de log para o {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/index.html#getting-started-with-cla).<p>Para acessar o painel do Kibana, acesse `https://logging.<region>.bluemix.net`. Selecione a organização e o espaço do {{site.data.keyword.Bluemix_notm}} em que você criou
o cluster.</p></li></ul></dd>
</dl>

### Outras ferramentas de monitoramento de funcionamento
{: #concept_xrh_dhj_wz}

É possível configurar outras ferramentas para recursos de criação de log
e monitoramento adicionais.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus é uma ferramenta de monitoramento, criação de log e alerta de software livre que foi projetada
especificamente para o Kubernetes para recuperar informações detalhadas sobre o cluster, os nós do trabalhador e
o funcionamento de implementação com base nas informações de criação de log do Kubernetes. Para obter informações de configuração, veja [Integrando serviços com o {{site.data.keyword.containershort_notm}}](#cs_planning_integrations).</dd>
</dl>


## Integrações
{: #cs_planning_integrations}

É possível usar vários serviços externos e serviços no Catálogo do {{site.data.keyword.Bluemix_notm}} com um cluster padrão no {{site.data.keyword.containershort_notm}}.{:shortdesc}

<table summary="Resumo para acessibilidade">
<caption>Tabela 6. Opções de integração para clusters e apps no Kubernetes</caption>
<thead>
<tr>
<th>Serviço</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>IBM Blockchain</td>
<td>Implementar um ambiente de desenvolvimento publicamente disponível para o IBM Blockchain para um cluster do Kubernetes no {{site.data.keyword.containerlong_notm}}. Use esse ambiente para desenvolver e customizar sua própria rede de blockchain para implementar apps que compartilham um livro razão imutável para registrar o histórico de transações. Para obter mais informações, veja <a href="https://ibm-blockchain.github.io" target="_blank">Desenvolver em um ambiente de simulação de nuvem
IBM Blockchain Platform <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Istio</td>
<td>Istio é um serviço de software livre que fornece aos desenvolvedores uma maneira de conectar, assegurar, gerenciar e
monitorar uma rede de microsserviços, também conhecida como malha de serviço, em plataformas de orquestração de nuvem como
o Kubernetes. O Istio fornece a capacidade de gerenciar o tráfego de rede, balanceamento de carga entre
microsserviços, impingir políticas de acesso e verificar a identidade de serviço na rede de serviço. Para instalar o Istio no cluster do Kubernetes no {{site.data.keyword.containershort_notm}}, veja o <a href="https://istio.io/docs/tasks/installing-istio.html" target="_blank">tópico de instalação <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> na documentação do Istio. Para revisar uma jornada de amostra do desenvolvedor sobre como usar o Istio com o Kubernetes, veja <a href="https://developer.ibm.com/code/journey/manage-microservices-traffic-using-istio/" target="_blank">Gerenciar o tráfego de microsserviços usando o Istio <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus é uma ferramenta de monitoramento, criação de log e alerta de software livre que foi projetada
especificamente para o Kubernetes para recuperar informações detalhadas sobre o cluster, os nós do trabalhador e
o funcionamento de implementação com base nas informações de criação de log do Kubernetes. A atividade de CPU, memória, E/S e rede
de todos os contêineres em execução em um cluster é coletada e pode ser usada em consultas ou alertas customizados
para monitorar o desempenho e as cargas de trabalho em seu cluster.
<p>Para usar o Prometheus.</p>
<ol>
<li>Instale o Prometheus seguindo <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">as instruções do CoreOS <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.<ol>
<li>Ao executar o comando de exportação, use seu namespace kube-system. <p><code>export NAMESPACE=kube-system hack/cluster-monitoring/deploy</code></p></li>
</ol>
</li>
<li>Após o Prometheus ser implementado em seu cluster, edite a origem de dados do Orometheus no Grafana para
se referir a <code>prometheus.kube-system:30900</code>.</li>
</ol>
</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>O Weave Scope fornece um diagrama visual de seus recursos dentro de um cluster do Kubernetes,
incluindo serviços, pods, contêineres, processos, nós e muito mais. O Weave Scope fornece métricas interativas para CPU e memória e também fornece ferramentas para uso de tail e executável em um contêiner.<p>Para obter mais informações, veja [Visualizando os recursos de cluster do Kubernetes com o Weave Scope e o {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>


## Acesse o portfólio do {{site.data.keyword.BluSoftlayer_notm}}
{: #cs_planning_unify_accounts}

Para criar um cluster padrão do Kubernetes, deve-se ter acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}. Esse acesso é necessário para
solicitar recursos de infraestrutura pagos, como nós do trabalhador, endereços IP públicos móveis ou
armazenamento persistente para seu cluster.
{:shortdesc}

As contas Pay-As-You-Go do {{site.data.keyword.Bluemix_notm}}
que foram criadas após a ativação da vinculação de conta automática já estão configuradas com
acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}, para que
seja possível comprar recursos de infraestrutura para seu cluster sem configuração adicional.

Usuários com outros tipos de conta do {{site.data.keyword.Bluemix_notm}}
ou usuários que possuem uma conta existente do {{site.data.keyword.BluSoftlayer_notm}} que não está vinculada à sua
conta do {{site.data.keyword.Bluemix_notm}}, devem
configurar suas contas para criar clusters padrão.

Revise a tabela a seguir para localizar opções disponíveis para cada tipo de conta.

|Tipo de conta|Descrição|Opções disponíveis para criar um cluster padrão|
|------------|-----------|----------------------------------------------|
|Contas de avaliação grátis|As contas de avaliação grátis não podem acessar o portfólio do {{site.data.keyword.BluSoftlayer_notm}}.<p>Se você tiver uma conta
existente do {{site.data.keyword.BluSoftlayer_notm}}, será possível vinculá-la à sua
conta de avaliação grátis.</p>|<ul><li>Opção 1: [faça upgrade de sua conta de avaliação grátis para uma conta de Pagamento por uso do {{site.data.keyword.Bluemix_notm}}](/docs/pricing/billable.html#upgradetopayg) que esteja configurada com acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}.</li><li>Opção 2: [vincule sua conta de avaliação grátis a uma conta existente do {{site.data.keyword.BluSoftlayer_notm}}](/docs/pricing/linking_accounts.html#unifyingaccounts).<p>Após a vinculação das duas contas, sua conta de avaliação grátis será submetida a upgrade automaticamente para uma conta Pay-As-You-Go. Ao vincular suas contas, você é faturado por meio do {{site.data.keyword.Bluemix_notm}} para ambos os recursos, {{site.data.keyword.Bluemix_notm}} e {{site.data.keyword.BluSoftlayer_notm}}.</p><p>**Nota:** a conta do {{site.data.keyword.BluSoftlayer_notm}} que for vinculada deverá ser configurada com permissões de Superusuário.</p></li></ul>|
|Contas Pay-As-You-Go|As contas Pay-As-You-Go criadas antes que a vinculação de conta automática estivesse disponível,
não vieram com acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}.<p>Se você tiver uma conta existente do {{site.data.keyword.BluSoftlayer_notm}}, não será possível vinculá-la a uma conta Pay-As-You-Go mais antiga.</p>|<ul><li>Opção 1: [crie uma nova conta Pay-As-You-Go](/docs/pricing/billable.html#billable) que seja configurada com acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}. Ao escolher essa opção,
você tem duas contas e faturamentos separados do
{{site.data.keyword.Bluemix_notm}}.<p>Se desejar continuar usando a sua conta Pay-As-You-Go antiga para criar clusters padrão, será possível usar sua nova conta Pay-As-You-Go para gerar uma chave API para acessar o portfólio do {{site.data.keyword.BluSoftlayer_notm}}. Em seguida, deve-se configurar a chave API
para sua conta Pay-As-You-Go antiga. Para obter mais informações, veja [Gerando
uma chave API para contas Pay-As-You-Go e de Assinatura antigas](#old_account). Lembre-se de que os recursos do {{site.data.keyword.BluSoftlayer_notm}} são faturados por meio de sua nova
conta Pay-As-You-Go.</p></li><li>Opção 2: se você já tiver uma conta existente do {{site.data.keyword.BluSoftlayer_notm}} que queira usar, será possível
[configurar suas credenciais](cs_cli_reference.html#cs_credentials_set) para
sua conta do {{site.data.keyword.Bluemix_notm}}.<p>**Nota:** a conta do {{site.data.keyword.BluSoftlayer_notm}} que você usar com o {{site.data.keyword.Bluemix_notm}} deverá ser configurada com permissões de Superusuário.</p></li></ul>|
|Contas de assinatura|As contas de assinatura não são configuradas com acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}.|<ul><li>Opção 1: [crie uma nova conta Pay-As-You-Go](/docs/pricing/billable.html#billable) que seja configurada com acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}. Ao escolher essa opção,
você tem duas contas e faturamentos separados do
{{site.data.keyword.Bluemix_notm}}.<p>Se desejar continuar usando a sua conta de Assinatura para criar clusters padrão, será possível usar sua nova conta Pay-As-You-Go para gerar uma chave API para acessar o portfólio do {{site.data.keyword.BluSoftlayer_notm}}. Em seguida, deve-se configurar a chave API
para sua conta de Assinatura. Para obter mais informações, veja [Gerando
uma chave API para contas Pay-As-You-Go e de Assinatura antigas](#old_account). Lembre-se de que os recursos do {{site.data.keyword.BluSoftlayer_notm}} são faturados por meio de sua nova
conta Pay-As-You-Go.</p></li><li>Opção 2: se você já tiver uma conta existente do {{site.data.keyword.BluSoftlayer_notm}} que queira usar, será possível
[configurar suas credenciais](cs_cli_reference.html#cs_credentials_set) para
sua conta do {{site.data.keyword.Bluemix_notm}}.<p>**Nota:** a conta do {{site.data.keyword.BluSoftlayer_notm}} que você usar com o {{site.data.keyword.Bluemix_notm}} deverá ser configurada com permissões de Superusuário.</p></li></ul>|
|Contas do {{site.data.keyword.BluSoftlayer_notm}}, nenhuma conta do {{site.data.keyword.Bluemix_notm}}|Para criar um cluster padrão, deve-se ter uma conta do {{site.data.keyword.Bluemix_notm}}.|<ul><li>Opção 1: [crie uma nova conta Pay-As-You-Go](/docs/pricing/billable.html#billable) que seja configurada com acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}. Ao escolher essa opção, um
novo {{site.data.keyword.BluSoftlayer_notm}} é criado para você. Você tem
duas contas e faturamentos separados do
{{site.data.keyword.BluSoftlayer_notm}}.</li><li>Opção 2: [crie uma conta de avaliação grátis](/docs/pricing/free.html#pricing) e [vincule-a à conta existente do {{site.data.keyword.BluSoftlayer_notm}}](/docs/pricing/linking_accounts.html#unifyingaccounts). Após a vinculação das duas contas, sua conta de avaliação grátis será submetida a upgrade automaticamente para uma conta Pay-As-You-Go. Ao vincular suas contas, você é faturado por meio do {{site.data.keyword.Bluemix_notm}} para ambos os recursos, {{site.data.keyword.Bluemix_notm}} e {{site.data.keyword.BluSoftlayer_notm}}.<p>**Nota:** a conta do {{site.data.keyword.BluSoftlayer_notm}} que for vinculada deverá ser configurada com permissões de Superusuário.</p></li></ul>|
{: caption="Tabela 7. Opções disponíveis para criar clusters padrão com contas não vinculadas a uma conta do {{site.data.keyword.BluSoftlayer_notm}}" caption-side="top"}


### Gerando uma chave API do {{site.data.keyword.BluSoftlayer_notm}} para
usar com contas do {{site.data.keyword.Bluemix_notm}}
{: #old_account}

Se desejar continuar usando a sua conta Pay-As-You-Go ou de Assinatura antiga para criar
clusters padrão, deverá gerar uma chave API com sua nova conta Pay-As-You-Go e configurar a
chave API para sua conta antiga.
{:shortdesc}

Antes de iniciar, crie uma conta Pay-As-You-Go do {{site.data.keyword.Bluemix_notm}}
que seja configurada automaticamente com acesso ao portfólio do {{site.data.keyword.BluSoftlayer_notm}}.

1.  Efetue login no portal do [{{site.data.keyword.BluSoftlayer_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://control.softlayer.com/) usando o {{site.data.keyword.ibmid}} e a senha criados para sua nova conta de Pagamento por uso.
2.  Selecione **Conta** e, em seguida, **Usuários**.
3.  Clique em **Gerar** para gerar uma chave API do {{site.data.keyword.BluSoftlayer_notm}} para sua nova conta Pay-As-You-Go.
4.  Copie a chave API.
5.  Na CLI, efetue login no {{site.data.keyword.Bluemix_notm}} usando o {{site.data.keyword.ibmid}} e a senha de sua conta de Pagamento por uso ou de Assinatura antiga.

  ```
  bx login
  ```
  {: pre}

6.  Configure a chave API gerada anteriormente para acessar o portfólio do {{site.data.keyword.BluSoftlayer_notm}}. Substitua `<API_KEY>` pela chave API e `<USERNAME>` pelo {{site.data.keyword.ibmid}} de sua nova conta de Pagamento por uso.

  ```
  bx cs credentials-set --infrastructure-api-key <API_KEY> --infrastructure-username <USERNAME>
  ```
  {: pre}

7.  Inicie a [criação de clusters padrão](cs_cluster.html#cs_cluster_cli).

**Nota:** para revisar sua chave API depois de ela ter sido gerada, siga as etapas 1 e 2 e, em seguida, na seção **Chave API**, clique em **Visualizar** para ver a chave API de seu ID do usuário.
