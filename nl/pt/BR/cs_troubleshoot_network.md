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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Resolução de problemas de rede do cluster
{: #cs_troubleshoot_network}

Ao usar o {{site.data.keyword.containerlong}}, considere estas técnicas para resolução de problemas de rede do cluster.
{: shortdesc}

Tendo problemas de conexão com seu app por meio do Ingress? Tente  [ Depurging Ingress ](cs_troubleshoot_debug_ingress.html).
{: tip}

## Não é possível se conectar a um app por meio de um serviço de balanceador de carga
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Você expôs publicamente seu app criando um serviço de balanceador de carga no cluster. Quando tentou se conectar ao seu app usando o endereço IP público do balanceador de carga, a conexão falhou ou atingiu o tempo limite.

{: tsCauses}
O serviço de balanceador de carga pode não estar funcionando corretamente por um dos motivos a seguir:

-   O cluster é um cluster grátis ou um cluster padrão com somente um nó do trabalhador.
-   O cluster não está totalmente implementado ainda.
-   O script de configuração para o serviço de balanceador de carga inclui erros.

{: tsResolve}
Para solucionar problemas do serviço de balanceador de carga:

1.  Verifique se você configurou um cluster padrão que está totalmente implementado e tem pelo menos dois nós do trabalhador para assegurar alta disponibilidade para o serviço de balanceador de carga.

  ```
  ibmcloud ks workers <cluster_name_or_ID>
  ```
  {: pre}

    Na saída da CLI, certifique-se de que o **Status** dos nós do trabalhador exiba **Pronto** e que o **Tipo de máquina** mostre um tipo de máquina diferente de **livre**.

2. Para balanceadores de carga da versão 2.0: assegure-se de concluir os [pré-requisitos do balanceador de carga 2.0](cs_loadbalancer.html#ipvs_provision).

3. Verifique a precisão do arquivo de configuração para o serviço de balanceador de carga.
    * Balanceadores de carga da versão 2.0:
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myservice
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>:<selector_value>
          ports:
           - protocol: TCP port: 8080 externalTrafficPolicy: Local
        ```
        {: screen}

        1. Verifique se você definiu **LoadBalancer** como o tipo para seu serviço.
        2. Verifique se você incluiu a anotação `service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"`.
        3. Na seção `spec.selector` do serviço LoadBalancer, assegure-se de que o `<selector_key>` e o `<selector_value>` sejam os mesmos que o par chave/valor que você usou na seção `spec.template.metadata.labels` de seu yaml de implementação. Se os rótulos não corresponderem, a seção **Terminais** em seu serviço LoadBalancer exibirá **<nenhum>** e seu app não ficará acessível na Internet.
        4. Verifique se usou a **porta** em que seu app atende.
        5. Verifique se você configurou `externalTrafficPolicy` para `Local`.

    * Balanceadores de carga da Versão 1.0:
        ```
        apiVersion: v1
    kind: Service
    metadata:
      name: myservice
    spec:
      type: LoadBalancer
      selector:
        <selector_key>:<selector_value>
      ports:
           - protocol: TCP port: 8080
        ```
        {: screen}

        1. Verifique se você definiu **LoadBalancer** como o tipo para seu serviço.
        2. Na seção `spec.selector` do serviço LoadBalancer, assegure-se de que o `<selector_key>` e o `<selector_value>` sejam os mesmos que o par chave/valor que você usou na seção `spec.template.metadata.labels` de seu yaml de implementação. Se os rótulos não corresponderem, a seção **Terminais** em seu serviço LoadBalancer exibirá **<nenhum>** e seu app não ficará acessível na Internet.
        3. Verifique se usou a **porta** em que seu app atende.

3.  Verifique o serviço de balanceador de carga e revise a seção **Eventos** para localizar erros em potencial.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    Procure as mensagens de erro a seguir:

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Para usar o serviço de balanceador de carga, deve-se ter um cluster padrão com pelo menos dois nós do trabalhador.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Essa mensagem de erro indica que não sobrou nenhum endereço IP público móvel para ser alocado para o serviço de balanceador de carga. Consulte <a href="cs_subnets.html#subnets">Incluindo sub-redes nos clusters</a> para localizar informações sobre como solicitar endereços IP públicos móveis para seu cluster. Depois que os endereços IP públicos móveis estiverem disponíveis para o cluster, o serviço de balanceador de carga será criado automaticamente.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>Você definiu um endereço IP público móvel para o serviço de balanceador de carga usando a seção **loadBalancerIP**, mas esse endereço IP público móvel não está disponível em sua sub-rede pública móvel. Na seção **loadBalancerIP** de seu script de configuração, remova o endereço IP existente e inclua um dos endereços IP públicos móveis disponíveis. Também é possível remover a seção **loadBalancerIP** de seu script para que um endereço IP público móvel disponível possa ser alocado automaticamente.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Você não tem nós do trabalhador suficientes para implementar um serviço de balanceador de carga. Um motivo talvez seja que você tenha implementado um cluster padrão com mais de um nó do trabalhador, mas o fornecimento dos nós do trabalhador tenha falhado.</li>
    <ol><li>Liste os nós do trabalhador disponíveis.</br><pre class="pre"><code>kubectl get nodes</code></pre></li>
    <li>Se pelo menos dois nós do trabalhador disponíveis forem localizados, liste os detalhes do nó do trabalhador.</br><pre class="pre"><code>ibmcloud ks worker-get &lt;cluster_name_or_ID&gt; &lt;worker_ID&gt;</code></pre></li>
    <li>Certifique-se de que os IDs de VLAN pública e privada para os nós do trabalhador que foram retornados pelos comandos <code>kubectl get nodes</code> e <code>ibmcloud ks &lt;cluster_name_or_ID&gt; worker-get</code> correspondam.</li></ol></li></ul>

4.  Se você estiver usando um domínio customizado para se conectar ao serviço de balanceador de carga, certifique-se de que seu domínio customizado seja mapeado para o endereço IP público do serviço de balanceador de carga.
    1.  Localize o endereço IP público do serviço de balanceador de carga.
        ```
        kubectl describe service <service_name> | grep "LoadBalancer Ingress"
        ```
        {: pre}

    2.  Verifique se o seu domínio customizado está mapeado para o endereço IP público móvel do serviço de balanceador de carga no registro de Ponteiro (PTR).

<br />


## Não é possível se conectar a um app por meio de Ingresso
{: #cs_ingress_fails}

{: tsSymptoms}
Você expôs publicamente seu app criando um recurso de Ingresso para seu app no cluster. Quando tentou se conectar ao seu app usando o endereço IP público ou subdomínio do balanceador de carga do aplicativo (ALB) de Ingresso, a conexão falhou ou atingiu o tempo limite.

{: tsResolve}
Primeiro, verifique se seu cluster está totalmente implementado e tem pelo menos 2 nós do trabalhador disponíveis por zona para assegurar alta disponibilidade para o ALB.
```
ibmcloud ks workers <cluster_name_or_ID>
```
{: pre}

Na saída da CLI, certifique-se de que o **Status** dos nós do trabalhador exiba **Pronto** e que o **Tipo de máquina** mostre um tipo de máquina diferente de **livre**.

* Se o seu cluster padrão estiver completamente implementado e tiver pelo menos 2 nós do trabalhador por zona, mas nenhum **Subdomínio do Ingress** estiver disponível, consulte [Não é possível obter um subdomínio para o ALB do Ingress](cs_troubleshoot_network.html#cs_subnet_limit).
* Para outros problemas, solucione problemas de sua configuração do Ingress seguindo as etapas em [Depurando o Ingress](cs_troubleshoot_debug_ingress.html).

<br />


## Problemas de segredo do balanceador de carga de aplicativo de Ingresso
{: #cs_albsecret_fails}

{: tsSymptoms}
Depois de implementar um segredo do balanceador de carga do aplicativo (ALB) de Ingresso em seu cluster, o campo `Description` não está sendo atualizado com o nome do segredo quando você visualiza seu certificado no {{site.data.keyword.cloudcerts_full_notm}}.

Quando você lista informações sobre o segredo do ALB, o status indica `*_failed`. Por exemplo, `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
Revise as razões a seguir por que o segredo do ALB pode falhar e as etapas de resolução de problemas correspondentes:

<table>
<caption>Resolução de Problemas do balanceador de carga de aplicativo de Ingresso segredos</caption>
 <thead>
 <th>Por que isso está acontecendo?</th>
 <th>Como corrigi-lo</th>
 </thead>
 <tbody>
 <tr>
 <td>Você não tem as funções de acesso necessárias para fazer download e atualizar os dados do certificado.</td>
 <td>Verifique com seu Administrador de conta para designar a você as funções do {{site.data.keyword.Bluemix_notm}} IAM a seguir:<ul><li>As funções de serviço **Gerente** e **Gravador** para sua instância do {{site.data.keyword.cloudcerts_full_notm}}. Para obter mais informações, veja <a href="/docs/services/certificate-manager/access-management.html#managing-service-access-roles">Gerenciando acesso de serviço</a> para {{site.data.keyword.cloudcerts_short}}.</li><li>A <a href="cs_users.html#platform">função de plataforma **Administrador**</a> para o cluster.</li></ul></td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de criação, atualização ou remoção não pertence à mesma conta que o cluster.</td>
 <td>Verifique se o CRN do certificado fornecido é importado para uma instância do serviço {{site.data.keyword.cloudcerts_short}} que está implementado na mesma conta que seu cluster.</td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de criação está incorreto.</td>
 <td><ol><li>Verifique a precisão da sequência CRN do certificado que você fornece.</li><li>Se o CRN do certificado for localizado como exato, tente atualizar o segredo: <code>ibmcloud ks alb-cert-deploy --update --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Se esse comando resultar no status <code>update_failed</code>, remova o segredo: <code>ibmcloud ks alb-cert-rm --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt;</code></li><li>Implemente o segredo novamente: <code>ibmcloud ks alb-cert-deploy --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de atualização está incorreto.</td>
 <td><ol><li>Verifique a precisão da sequência CRN do certificado que você fornece.</li><li>Se o CRN do certificado for localizado como exato, remova o segredo: <code>ibmcloud ks alb-cert-rm --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt;</code></li><li>Implemente o segredo novamente: <code>ibmcloud ks alb-cert-deploy --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Tente atualizar o segredo: <code>ibmcloud ks alb-cert-deploy --update --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>O serviço {{site.data.keyword.cloudcerts_long_notm}} está tendo tempo de inatividade.</td>
 <td>Verifique se o serviço {{site.data.keyword.cloudcerts_short}} está funcionando.</td>
 </tr>
 </tbody></table>

<br />


## Não é possível obter um subdomínio para o ALB do Ingress
{: #cs_subnet_limit}

{: tsSymptoms}
Quando você executa `ibmcloud ks cluster-get <cluster>`< seu cluster está em um estado `normal`, mas nenhum **Subdomínio do Ingress** está disponível.

É possível ver uma mensagem de erro semelhante à seguinte:

```
There are already the maximum number of subnets permitted in this VLAN.
```
{: screen}

{: tsCauses}
Em clusters padrão, na primeira vez que você criar um cluster em uma zona, uma VLAN pública e uma VLAN privada nessa zona serão provisionadas automaticamente para você em sua conta de infraestrutura do IBM Cloud (SoftLayer). Nessa zona, 1 sub-rede móvel pública é solicitada na VLAN pública especificada e 1 sub-rede móvel privada é solicitada na VLAN privada especificada. Para o {{site.data.keyword.containerlong_notm}}, as VLANs têm um limite de 40 sub-redes. Se a VLAN do cluster em uma zona já tiver atingido esse limite, o **Subdomínio do Ingress** falhará ao provisionar.

Para visualizar quantas sub-redes uma VLAN tem:
1.  No [console da infraestrutura do IBM Cloud (SoftLayer)](https://control.bluemix.net/), selecione **Rede** > **IP de gerenciamento** > **VLANs**.
2.  Clique no **Número da VLAN** da VLAN usada para criar seu cluster. Revise a seção **Subnets** para ver se 40 ou mais sub-redes existem.

{: tsResolve}
Se você precisar de uma nova VLAN, peça uma [entrando em contato com o suporte do {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#ordering-premium-vlans). Em seguida, [crie um cluster](cs_cli_reference.html#cs_cluster_create) que usa essa nova VLAN.

Se você tiver outra VLAN disponível, será possível [configurar a ampliação da VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) no cluster existente. Depois, será possível incluir novos nós do trabalhador no cluster que usam a outra VLAN com sub-redes disponíveis. Para verificar se o VLAN Spanning já está ativado, use o [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.

Se você não estiver usando todas as sub-redes na VLAN, será possível reutilizar sub-redes no cluster.
1.  Verifique se as sub-redes que você deseja usar estão disponíveis.

    A conta de infraestrutura que você está usando pode ser compartilhada entre múltiplas contas do {{site.data.keyword.Bluemix_notm}}. Em caso positivo, mesmo se você executar o comando `ibmcloud ks subnets` para ver sub-redes com **Clusters ligados**, será possível ver informações somente para os seus clusters. Verifique com o proprietário da conta de infraestrutura para certificar-se de que as sub-redes estão disponíveis e não em uso por nenhuma outra conta ou equipe.
    {: note}

2.  [Crie um cluster](cs_cli_reference.html#cs_cluster_create) com a opção `--no-subnet` para que o serviço não tente criar novas sub-redes. Especifique a zona e a VLAN que tem as sub-redes que estão disponíveis para reutilização.

3.  Use o [comando](cs_cli_reference.html#cs_cluster_subnet_add) `ibmcloud ks cluster-subnet-add` para incluir sub-redes existentes em seu cluster. Para obter mais informações, veja [Incluindo ou reutilizando sub-redes customizadas e existentes nos clusters do Kubernetes](cs_subnets.html#custom).

<br />


## O ALB do Ingresso não é implementado em uma zona
{: #cs_multizone_subnet_limit}

{: tsSymptoms}
Quando você tem um cluster de múltiplas zonas e executa `ibmcloud ks albs <cluster>`, nenhum ALB é implementado em uma zona. Por exemplo, se você tiver nós do trabalhador em 3 zonas, poderá ver uma saída semelhante à seguinte na qual um ALB público não foi implementado na terceira zona.
```
ALB ID                                            Status     Type      ALB IP           Zone    Build
private-cr96039a75fddb4ad1a09ced6699c88888-alb1   disabled   private   -                dal10   ingress:350/ingress-auth:192
private-cr96039a75fddb4ad1a09ced6699c88888-alb2   disabled   private   -                dal12   ingress:350/ingress-auth:192
private-cr96039a75fddb4ad1a09ced6699c88888-alb3   disabled   private   -                dal13   ingress:350/ingress-auth:192
public-cr96039a75fddb4ad1a09ced6699c88888-alb1    enabled    public    169.xx.xxx.xxx  dal10   ingress:350/ingress-auth:192
public-cr96039a75fddb4ad1a09ced6699c88888-alb2    enabled    public    169.xx.xxx.xxx  dal12   ingress:350/ingress-auth:192
```
{: screen}

{: tsCauses}
Em cada zona, 1 sub-rede móvel pública é solicitada na VLAN pública especificada e 1 sub-rede móvel privada é solicitada na VLAN privada especificada. Para o {{site.data.keyword.containerlong_notm}}, as VLANs têm um limite de 40 sub-redes. Se a VLAN pública do cluster em uma zona já tiver atingido esse limite, o ALB do Ingresso público para essa zona falhará ao provisionar.

{: tsResolve}
Para verificar o número de sub-redes em uma VLAN e para obter as etapas sobre como obter outra VLAN, veja [Não é possível obter um subdomínio para ALB do Ingress](#cs_subnet_limit).

<br />


## A conexão via WebSocket é fechada após 60 segundos
{: #cs_ingress_websocket}

{: tsSymptoms}
Seu serviço Ingresso expõe um app que usa um WebSocket. No entanto, a conexão entre um cliente e o app WebSocket é fechada quando nenhum tráfego é enviado entre eles por 60 segundos.

{: tsCauses}
A conexão com seu app WebSocket pode cair após 60 segundos de inatividade por um dos motivos a seguir:

* A sua conexão de Internet tem um proxy ou firewall que não tolera conexões longas.
* Um tempo limite no ALB para o app WebSocket finaliza a conexão.

{: tsResolve}
Para evitar que a conexão seja fechada após 60 segundos de inatividade:

1. Se você se conectar ao seu app WebSocket por meio de um proxy ou firewall, certifique-se de que o proxy ou o firewall não esteja configurado para finalizar automaticamente as conexões longas.

2. Para manter a conexão ativa, é possível aumentar o valor do tempo limite ou configurar uma pulsação em seu app.
<dl><dt>Alterar o tempo limite</dt>
<dd>Aumente o valor do `proxy-read-timeout` em sua configuração do ALB. Por exemplo, para mudar o tempo limite de `60s` para um valor maior, como `300s`, inclua esta [anotação](cs_annotations.html#connection) em seu arquivo de recursos do Ingress: `ingress.bluemix.net/proxy-read-timeout: "serviceName=<service_name> timeout=300s " `. O tempo limite é mudado para todos os ALBs públicos em seu cluster.</dd>
<dt>Configurar uma pulsação</dt>
<dd>Se você não desejar mudar o valor de tempo limite de leitura padrão do ALB, configure uma pulsação em seu app WebSocket. Ao configurar um protocolo de pulsação usando uma estrutura como [WAMP ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://wamp-proto.org/), o servidor de envio de dados do app envia periodicamente uma mensagem "ping" em um intervalo cronometrado e o cliente responde com uma mensagem "pong". Configure o intervalo de pulsação para 58 segundos ou menos para que o tráfego "ping/pong" mantenha a conexão aberta antes que o tempo limite de 60 segundos seja cumprido.</dd></dl>

<br />


## A preservação de IP de origem falha ao usar nós contaminados
{: #cs_source_ip_fails}

{: tsSymptoms}
Você ativou a preservação de IP de origem para um [balanceador de carga da versão 1.0](cs_loadbalancer.html#node_affinity_tolerations) ou um serviço [ALB do Ingress](cs_ingress.html#preserve_source_ip), mudando `externalTrafficPolicy` para `Local` no arquivo de configuração do serviço. No entanto, nenhum tráfego atinge o serviço de backend para seu app.

{: tsCauses}
Ao ativar a preservação de IP de origem para os serviços de balanceador de carga ou ALB do Ingress, o endereço IP de origem da solicitação do cliente é preservado. O serviço encaminha o tráfego para os pods de app no mesmo nó do trabalhador somente para assegurar que o endereço IP do pacote de solicitações não seja mudado. Geralmente, os pods dos serviços de balanceador de carga ou ALB de Ingress são implementados nos mesmos nós do trabalhador nos quais os pods de app são implementados. No entanto, existem algumas situações em que os pods de serviço e os pods de app podem não ser planejados para o mesmo nó do trabalhador. Se você usar [contaminações do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) em nós do trabalhador, quaisquer pods que não tiverem uma tolerância de contaminação serão impedidos de serem executados nos nós do trabalhador contaminados. A preservação de IP de origem pode não estar funcionando com base no tipo de contaminação que você usou:

* **Contaminações do nó de borda**: você [incluiu o rótulo `dedicated=edge`](cs_edge.html#edge_nodes) em dois ou mais nós do trabalhador em cada VLAN pública em seu cluster para assegurar que os pods do Ingress e do balanceador de carga sejam implementados somente nesses nós do trabalhador. Em seguida, você também [contaminou esses nós de borda](cs_edge.html#edge_workloads) para evitar que quaisquer outras cargas de trabalho sejam executadas em nós de borda. No entanto, você não incluiu uma regra de afinidade de nó de borda e tolerância em sua implementação do app. Seus pods de app não podem ser planejados nos mesmos nós contaminados que os pods de serviço e nenhum tráfego atinge o serviço de backend para seu app.

* **Contaminações customizadas**: você usou contaminações customizadas em vários nós para que somente os pods de app com essa tolerância de contaminação possam ser implementados nesses nós. Você incluiu regras de afinidade e tolerâncias para as implementações de seu app e o serviço de balanceador de carga ou Ingress para que seus pods sejam implementados somente nesses nós. No entanto, os pods `ibm-cloud-provider-ip` `keepalived` que são criados automaticamente no namespace `ibm-system` asseguram que os pods do balanceador de carga e os pods de app estejam sempre planejados para o mesmo nó do trabalhador. Esses pods `keepalived` não têm as tolerâncias para as contaminações customizadas que você usou. Eles não podem ser planejados nos mesmos nós contaminados em que os seus pods de app estão em execução e nenhum tráfego atinge o serviço de backend para seu app.

{: tsResolve}
Resolva o problema escolhendo uma das opções a seguir:

* **Contaminações de nó de borda**: para assegurar que seus pods do balanceador de carga e do app sejam implementados em nós de borda contaminados, [inclua regras de afinidade e tolerâncias de nó de borda em sua implementação do app](cs_loadbalancer.html#edge_nodes). Os pods do balanceador de carga e do ALB do Ingress têm essas regras de afinidade e tolerâncias por padrão.

* **Contaminações customizadas**: remova as contaminações customizadas para as quais os pods `keepalived` não têm tolerâncias. Em vez disso, é possível [rotular nós do trabalhador como nós de borda e, em seguida, contaminar esses nós de borda](cs_edge.html).

Se você concluir uma das opções acima, mas os pods `keepalived` ainda não estiverem planejados, será possível obter mais informações sobre os pods `keepalived`:

1. Obtenha os pods  ` keepalived ` .
    ```
    kubectl get pods -n ibm-system
    ```
    {: pre}

2. Na saída, procure os pods `ibm-cloud-provider-ip` que têm um **Status** de `Pending`. Exemplo:
    ```
    ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-7zv9t     0/1       Pending   0          2m        <none>          <none>
    ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-8ptvg     0/1       Pending   0          2m        <none>          <none>
    ```
    {:screen}

3. Descreva cada pod `keepalived` e procure a seção **Eventos**. Trate quaisquer mensagens de erro ou de aviso que estejam listadas.
    ```
    kubectl describe pod ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-7zv9t -n ibm-system
    ```
    {: pre}

<br />


## Não é possível estabelecer a conectividade VPN com o gráfico Helm do strongSwan
{: #cs_vpn_fails}

{: tsSymptoms}
Quando você verifica a conectividade de VPN executando `kubectl exec $STRONGSWAN_POD -- ipsec status`, você não vê um status de `ESTABLISHED` ou o pod de VPN está em um estado de `ERROR` ou continua travando e reiniciando.

{: tsCauses}
Seu arquivo de configuração do gráfico Helm tem valores incorretos, valores ausentes ou erros de sintaxe.

{: tsResolve}
Quando você tentar estabelecer a conectividade VPN com o gráfico Helm do strongSwan, é provável que o status da VPN não seja `ESTABLISHED` na primeira vez. Você pode precisar verificar vários tipos de problemas e mudar seu arquivo de configuração de acordo. Para solucionar problemas de sua conectividade VPN do strongSwan:

1. [Teste e verifique a conectividade de VPN do strongSwan](cs_vpn.html#vpn_test) executando os cinco testes do Helm que estão incluídos na definição de gráfico do strongSwan.

2. Se não for possível estabelecer a conectividade de VPN depois de executar os testes do Helm, será possível executar a ferramenta de depuração de VPN que está empacotada dentro da imagem do pod VPN.

    1. Configure a variável de ambiente `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. Execute a ferramenta de depuração.

        ```
        kubectl exec  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        A ferramenta exibe várias páginas de informações conforme ela executa vários testes para problemas de rede comum. As linhas de saída que iniciam com `ERROR`, `WARNING`, `VERIFY` ou `CHECK` indicam erros possíveis com a conectividade VPN.

    <br />


## Não é possível instalar uma nova liberação do gráfico Helm do strongSwan
{: #cs_strongswan_release}

{: tsSymptoms}
Você modifica o gráfico Helm do strongSwan e tenta instalar sua nova liberação executando `helm install -f config.yaml --name=vpn ibm/strongswan`. No entanto, você vê o erro a seguir:
```
Error: release vpn failed: deployments.extensions "vpn-strongswan" already exists
```
{: screen}

{: tsCauses}
Esse erro indica que a versão anterior do gráfico do strongSwan não foi completamente desinstalada.

{: tsResolve}

1. Exclua a liberação do gráfico anterior.
    ```
    helm delete --purge vpn
    ```
    {: pre}

2. Exclua a implementação para a liberação anterior. A exclusão da implementação e do pod associado leva até 1 minuto.
    ```
    kubectl delete deploy vpn-strongswan
    ```
    {: pre}

3. Verifique se a implementação foi excluída. A implementação `vpn-strongswan` não aparece na lista.
    ```
    kubectl get deployments
    ```
    {: pre}

4. Reinstale o gráfico Helm do strongSwan atualizado com um novo nome de liberação.
    ```
    -f config.yaml helm install -- name=vpn ibm/strongswan
    ```
    {: pre}

<br />


## A conectividade VPN do strongSwan falha depois de incluir ou excluir nós do trabalhador
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
Você estabeleceu anteriormente uma conexão VPN de trabalho, usando o serviço de VPN IPSec do strongSwan. No entanto, após ter incluído ou excluído um nó do trabalhador em seu cluster, você tem um ou mais dos sintomas a seguir:

* Você não tem um status de VPN de `ESTABLISHED`
* Não é possível acessar novos nós do trabalhador por meio de sua rede no local
* Não é possível acessar a rede remota de pods que estão em execução em novos nós do trabalhador

{: tsCauses}
Se você incluiu um nó do trabalhador em um conjunto de trabalhadores:

* O nó do trabalhador foi provisionado em uma nova sub-rede privada que não é exposta sobre a conexão VPN por suas configurações `localSubnetNAT` ou `local.subnet` existentes
* as rotas de VPN não podem ser incluídas no nó do trabalhador porque o trabalhador tem contaminações ou rótulos que não estão incluídos em suas configurações `tolerations` ou `nodeSelector` existentes
* O pod de VPN está em execução no novo nó do trabalhador, mas o endereço IP público do nó do trabalhador não é permitido por meio do firewall no local

Se você tiver excluído um nó do trabalhador:

* Esse nó do trabalhador era o único nó em que um pod de VPN estava em execução, devido a restrições em certas contaminações ou rótulos em suas configurações `tolerations` ou `nodeSelector` existentes

{: tsResolve}
Atualize os valores do gráfico Helm para refletir as mudanças do nó do trabalhador:

1. Exclua o gráfico do Helm existente.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Abra o arquivo de configuração para seu serviço de VPN do strongSwan.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Verifique as configurações a seguir e mude as configurações para refletir os nós do trabalhador excluídos ou incluídos, conforme necessário.

    Se você tiver incluído um nó do trabalhador:

    <table>
    <caption>Configurações do nó do trabalhador < /caption?
     <thead>
     <th>Configuração</th>
     <th>Descrição</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>O trabalhador incluído pode ser implementado em uma sub-rede privada nova e diferente das outras sub-redes existentes em que outros nós do trabalhador estão. Se você estiver usando a sub-rede NAT para remapear endereços IP locais privados de seu cluster e o trabalhador foi incluído em uma nova sub-rede, inclua a nova sub-rede CIDR nesta configuração.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Se você limitou anteriormente a implementação do pod de VPN para trabalhadores com um rótulo específico, assegure-se de que o nó do trabalhador incluído também tenha esse rótulo.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Se o nó do trabalhador incluído estiver contaminado, mude essa configuração para permitir que o pod de VPN seja executado em todos os trabalhadores contaminados com quaisquer contaminações ou contaminações específicas.</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>O trabalhador incluído pode ser implementado em uma sub-rede privada nova e diferente das sub-redes existentes em que outros trabalhadores estão. Se seus apps são expostos por serviços NodePort ou LoadBalancer na rede privada e os apps estão no trabalhador incluído, inclua a nova sub-rede CIDR nesta configuração. **Nota**: se você incluir valores para `local.subnet`, verifique as configurações de VPN para a sub-rede no local para ver se elas também devem ser atualizadas.</td>
     </tr>
     </tbody></table>

    Se você tiver excluído um nó do trabalhador:

    <table>
    <caption>Configurações do nó do trabalhador</caption>
     <thead>
     <th>Configuração</th>
     <th>Descrição</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Se você estiver usando a sub-rede NAT para remapear endereços IP locais privados específicos, remova quaisquer endereços IP dessa configuração que sejam do trabalhador antigo. Se você estiver usando a sub-rede NAT para remapear sub-redes inteiras e nenhum trabalhador permanecer em uma sub-rede, remova essa sub-rede CIDR desta configuração.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Se você limitou anteriormente a implementação do pod de VPN a um trabalhador único e esse trabalhador foi excluído, mude essa configuração para permitir que o pod de VPN seja executado em outros trabalhadores.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Se o trabalhador que você excluiu não foi contaminado, mas os únicos trabalhadores que permanecem estão contaminados, mude essa configuração para permitir que o pod de VPN seja executado em trabalhadores com quaisquer contaminações ou contaminações específicas.
     </td>
     </tr>
     </tbody></table>

4. Instale o novo gráfico Helm com os seus valores atualizados.

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. Verifique o status de implementação do gráfico. Quando o gráfico estiver pronto, o campo **STATUS** perto da parte superior da saída terá um valor de `DEPLOYED`.

    ```
    helm status <release_name>
    ```
    {: pre}

6. Em alguns casos, você pode precisar mudar suas configurações no local e suas configurações de firewall para corresponderem às mudanças feitas no arquivo de configuração de VPN.

7. Inicie a VPN.
    * Se a conexão VPN é iniciada pelo cluster (`ipsec.auto` está configurado para `start`), inicie a VPN no gateway no local e, em seguida, inicie a VPN no cluster.
    * Se a conexão VPN é iniciada pelo gateway no local (`ipsec.auto` está configurado para `auto`), inicie a VPN no cluster e, em seguida, inicie a VPN no gateway no local.

8. Configure a variável de ambiente `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. Verifique o status da VPN.

    ```
    Kubectl exec $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * Se a conexão VPN tem um status de `ESTABLISHED`, a conexão VPN foi bem-sucedida. Nenhuma ação adicional é necessária.

    * Se você ainda está tendo problemas de conexão, veja [Não é possível estabelecer a conectividade VPN com o gráfico Helm do strongSwan](#cs_vpn_fails) para solucionar problemas posteriormente de sua conexão VPN.

<br />



## Não é possível recuperar políticas de rede do Calico
{: #cs_calico_fails}

{: tsSymptoms}
Ao tentar visualizar políticas de rede do Calico em seu cluster executando `calicoctl get policy`, você obtém um dos resultados inesperados ou mensagens de erro a seguir:
- Uma lista vazia
- Uma lista de políticas antigas do Calico v2 em vez de políticas da v3
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'projectcalico.org/v3'`

Ao tentar visualizar políticas de rede do Calico em seu cluster executando `calicoctl get GlobalNetworkPolicy`, você obtém um dos resultados inesperados ou mensagens de erro a seguir:
- Uma lista vazia
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'v1'`
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'projectcalico.org/v3'`
- `Failed to get resources: Resource type 'GlobalNetworkPolicy' is not supported`

{: tsCauses}
Para usar políticas do Calico, quatro fatores devem estar alinhados: a versão do Kubernetes do cluster, a versão da CLI do Calico, a sintaxe do arquivo de configuração do Calico e os comandos da política de visualização. Um ou mais desses fatores não está na versão correta.

{: tsResolve}
Quando o cluster está no [Kubernetes versão 1.10 ou mais recente](cs_versions.html), deve-se usar a CLI do Calico v3.1, a sintaxe do arquivo de configuração v3 `calicoctl.cfg` e os comandos `calicoctl get GlobalNetworkPolicy` e `calicoctl get NetworkPolicy`.

Quando o cluster está no [Kubernetes versão 1.9 ou anterior](cs_versions.html), deve-se usar a CLI do Calico v1.6.3, a sintaxe do arquivo de configuração v2 `calicoctl.cfg` e o comando `calicoctl get policy`.

Para assegurar que todos os fatores do Calico estejam alinhados:

1. Visualize seu cluster do Kubernetes versão.
    ```
    ibmcloud ks cluster-get <cluster_name>
    ```
    {: pre}

    * Se o seu cluster estiver no Kubernetes versão 1.10 ou mais recente:
        1. [Instale e configure a CLI versão 3.3.1 do Calico](cs_network_policy.html#1.10_install). A configuração inclui atualizar manualmente o arquivo `calicoctl.cfg` para usar a sintaxe do Calico v3.
        2. Assegure-se de que quaisquer políticas que você criar e desejar aplicar a seu cluster usem a [Sintaxe do Calico v3 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy). Se você tiver um arquivo `.yaml` ou `.json` de política existente na sintaxe do Calico v2, será possível converter isso para a sintaxe do Calico v3 usando o comando [`calicoctl convert` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.1/reference/calicoctl/commands/convert).
        3. Para [visualizar políticas](cs_network_policy.html#1.10_examine_policies), assegure-se de que você esteja usando `calicoctl get GlobalNetworkPolicy` para as políticas globais e `calicoctl get NetworkPolicy --namespace <policy_namespace>` para políticas que estão com escopo definido para namespaces específicos.

    * Se o seu cluster estiver no Kubernetes versão 1.9 ou anterior:
        1. [Instale e configure a CLI do Calico versão 1.6.3](cs_network_policy.html#1.9_install). Assegure-se de que o arquivo `calicoctl.cfg` use a sintaxe do Calico v2.
        2. Assegure-se de que quaisquer políticas que você criar e desejar aplicar ao seu cluster usem a [sintaxe do Calico v2 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).
        3. Para [visualizar políticas](cs_network_policy.html#1.9_examine_policies), assegure-se de que você esteja usando `calicoctl get policy`.

Antes de atualizar seu cluster do Kubernetes versão 1.9 ou anterior para a versão 1.10 ou mais recente, revise [Preparando-se para atualizar para o Calico v3](cs_versions.html#110_calicov3).
{: tip}

<br />


## Não é possível incluir nós do trabalhador devido a um ID de VLAN inválido
{: #suspended}

{: tsSymptoms}
A sua conta do {{site.data.keyword.Bluemix_notm}} foi suspensa ou todos os nós do trabalhador em seu cluster foram excluídos. Após a reativação da conta, não é possível incluir nós do trabalhador ao tentar redimensionar ou rebalancear seu conjunto de trabalhadores. Você vê uma mensagem de erro semelhante à seguinte:

```
SoftLayerAPIError(SoftLayer_Exception_Public): Could not obtain network VLAN with id #123456.
```
{: screen}

{: tsCauses}
Quando uma conta é suspensa, os nós do trabalhador dentro da conta são excluídos. Se um cluster não tem nós do trabalhador, a infraestrutura do IBM Cloud (SoftLayer) recupera as VLANs públicas e privadas associadas. No entanto, o conjunto de trabalhadores do cluster ainda tem os IDs de VLAN anteriores em seus metadados e usa esses IDs indisponíveis quando você rebalanceia ou redimensiona o conjunto. Os nós falham ao serem criados porque as VLANs não estão mais associadas ao cluster.

{: tsResolve}

É possível [excluir seu conjunto de trabalhadores existente](cs_cli_reference.html#cs_worker_pool_rm), em seguida, [criar um novo conjunto de trabalhadores](cs_cli_reference.html#cs_worker_pool_create).

Como alternativa, é possível manter o seu conjunto de trabalhadores existente pedindo novas VLANs e usando-as para criar novos nós do trabalhador no conjunto.

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).

1.  Para obter as zonas para as quais você precisa de novos IDs de VLAN, anote o **Local** na saída de comando a seguir. **Nota**: se o seu cluster for de múltiplas zonas, serão necessários IDs de VLAN para cada zona.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

2.  Obtenha uma nova VLAN privada e pública para cada zona em que seu cluster está [contatando o suporte do {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#ordering-premium-vlans).

3.  Anote os novos IDs de VLAN privada e pública para cada zona.

4.  Anote o nome de seus conjuntos de trabalhadores.

    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

5.  Use o [comando](cs_cli_reference.html#cs_zone_network_set) `zone-network-set` para mudar os metadados de rede do conjunto de trabalhadores.

    ```
    ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> -- worker-pools <worker-pool> --private-vlan <private_vlan_ID> --public-vlan <public_vlan_ID>
    ```
    {: pre}

6.  **Somente cluster de múltiplas zonas**: repita a **Etapa 5** para cada zone em seu cluster.

7.  Rebalanceie ou redimensione seu conjunto de trabalhadores para incluir nós do trabalhador que usam os novos IDs de VLAN. Por exemplo:

    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <worker_pool> --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

8.  Verifique se os nós do trabalhador estão criados.

    ```
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool>
    ```
    {: pre}

<br />



## Obtendo ajuda e suporte
{: #ts_getting_help}

Ainda está tendo problemas com o seu cluster?
{: shortdesc}

-  No terminal, você é notificado quando atualizações para a CLI `ibmcloud` e plug-ins estão disponíveis. Certifique-se de manter sua CLI atualizada para que seja possível usar todos os comandos e sinalizações disponíveis.
-   Para ver se o {{site.data.keyword.Bluemix_notm}} está disponível, [verifique a página de status do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).
-   Poste uma pergunta no [{{site.data.keyword.containerlong_notm}} Slack ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com).
    Se você não estiver usando um IBMid para a sua conta do {{site.data.keyword.Bluemix_notm}}, [solicite um convite](https://bxcs-slack-invite.mybluemix.net/) para essa Folga.
    {: tip}
-   Revise os fóruns para ver se outros usuários tiveram o mesmo problema. Ao usar os fóruns para fazer uma pergunta, marque sua pergunta para que ela seja vista pelas equipes de desenvolvimento do {{site.data.keyword.Bluemix_notm}}.
    -   Se você tiver questões técnicas sobre como desenvolver ou implementar clusters ou apps com o {{site.data.keyword.containerlong_notm}}, poste sua pergunta no [Stack Overflow ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo") ](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e identifique-a com `ibm-cloud`, `kubernetes` e `containers`.
    -   Para perguntas sobre o serviço e instruções de introdução, use o fórum do [IBM Developer Answers ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Inclua as tags `ibm-cloud` e `containers`.
    Consulte [Obtendo ajuda](/docs/get-support/howtogetsupport.html#using-avatar) para obter mais detalhes sobre o uso dos fóruns.
-   Entre em contato com o Suporte IBM abrindo um caso. Para saber mais sobre como abrir um caso de suporte IBM ou sobre os níveis de suporte e as severidades do caso, consulte [Entrando em contato com o suporte](/docs/get-support/howtogetsupport.html#getting-customer-support).
Ao relatar um problema, inclua o ID do cluster. Para obter o ID do seu cluster, execute `ibmcloud ks clusters`.
{: tip}

