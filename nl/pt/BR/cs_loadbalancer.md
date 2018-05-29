---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Expondo apps com LoadBalancers
{: #loadbalancer}

Exponha uma porta e use um endereço IP móvel para o balanceador de carga para acessar um app conteinerizado.
{:shortdesc}

## Gerenciando o tráfego de rede usando os LoadBalancers
{: #planning}

Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} solicita automaticamente cinco endereços IP móveis públicos e cinco endereços IP móveis privados e os provisiona em sua conta de infraestrutura do IBM Cloud (SoftLayer) durante a criação do cluster. Dois dos endereços IP móveis, um público e um privado, são usados para [Balanceadores de carga de aplicativo do Ingress](cs_ingress.html). Quatro endereços IP móveis públicos e quatro endereços IP móveis privados podem ser usados para expor apps criando um serviço LoadBalancer.

Ao criar um serviço do Kubernetes LoadBalancer em um cluster em uma VLAN pública, um balanceador de carga externo é criado. Suas opções para endereços IP quando você cria um serviço LoadBalancer são como a seguir:

- Se o seu cluster está em uma VLAN pública, um dos quatro endereços IP públicos móveis disponíveis é usado.
- Se o seu cluster está disponível somente em uma VLAN privada, um dos quatro endereços IP privados móveis disponíveis é usado.
- É possível solicitar um endereço IP público ou privado móvel para um serviço LoadBalancer, incluindo uma anotação no arquivo de configuração: `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.

O endereço IP público móvel que é designado ao seu serviço LoadBalancer é permanente e não muda quando um nó do trabalhador é removido ou recriado. Portanto, o serviço LoadBalancer é mais disponível do que o serviço NodePort. Diferente dos serviços NodePort, é possível designar qualquer porta a seu balanceador de carga e não ser limitado a um determinado intervalo de portas. Se você usar um serviço LoadBalancer, uma porta de nó também estará disponível em cada endereço IP de qualquer nó do trabalhador. Para bloquear o acesso à porta de nó enquanto você estiver usando um serviço LoadBalancer, consulte [Bloqueando tráfego recebido](cs_network_policy.html#block_ingress).

O serviço LoadBalancer serve como o ponto de entrada externo para solicitações recebidas para o app. Para acessar o serviço LoadBalancer por meio da Internet, use o endereço IP público do balanceador de carga e a porta designada no formato `<IP_address>:<port>`. O diagrama a seguir mostra como um balanceador de carga direciona a comunicação da Internet para um app:

<img src="images/cs_loadbalancer_planning.png" width="550" alt="Expor um app no {{site.data.keyword.containershort_notm}} usando um balanceador de carga" style="width:550px; border-style: none"/>

1. Uma solicitação é enviada para seu app usando o endereço IP público de seu balanceador de carga e a porta designada no nó do trabalhador.

2. A solicitação é encaminhada automaticamente para o endereço IP e porta do cluster interno do serviço de balanceador de carga. O endereço IP do cluster interno é acessível somente dentro do cluster.

3. `kube-proxy` roteia a solicitação para o serviço de balanceador de carga do Kubernetes para o app.

4. A solicitação é encaminhada para o endereço IP privado do pod no qual o app é implementado. Se múltiplas instâncias do app são implementadas no cluster, o balanceador de carga roteia as solicitações entre os pods de app.




<br />




## Ativando o acesso público ou privado para um app usando um serviço LoadBalancer
{: #config}

Antes de iniciar:

-   Este recurso está disponível somente para clusters padrão.
-   Deve-se ter um endereço IP público ou privado móvel disponível para designar ao serviço de balanceador de carga.
-   Um serviço de balanceador de carga com um endereço IP privado móvel ainda tem uma porta do nó público aberta em cada nó do trabalhador. Para incluir uma política de rede para evitar o tráfego público, consulte [Bloqueando tráfego recebido](cs_network_policy.html#block_ingress).

Para criar um serviço de balanceador de carga:

1.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução para que eles possam ser incluídos no balanceamento de carga.
2.  Crie um serviço de balanceador de carga para o app que você deseja expor. Para tornar seu app disponível na Internet pública ou em uma rede privada, crie um serviço do Kubernetes para seu app. Configure seu serviço para incluir todos os pods que compõem o seu app no balanceamento de carga.
    1.  Crie um arquivo de configuração de serviço que seja chamado, por exemplo, de `myloadbalancer.yaml`.

    2.  Defina um serviço de balanceador de carga para o app que você deseja expor.
        - Se o seu cluster estiver em uma VLAN pública, um endereço IP móvel público será usado. A maioria dos clusters está em uma VLAN pública.
        - Se o seu cluster estiver disponível apenas em uma VLAN privada, então, um endereço IP móvel privado será usado.
        - É possível solicitar um endereço IP público ou privado móvel para um serviço LoadBalancer, incluindo uma anotação no arquivo de configuração.

        O serviço LoadBalancer que usa um endereço IP padrão:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
        spec:
          type: LoadBalancer
          selector:
            <selector_key>:<selector_value>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        O serviço LoadBalancer que usa uma anotação para especificar um endereço IP privado ou público:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
          <td><code>seletor</code></td>
          <td>Insira a chave de etiqueta (<em>&lt;selector_key&gt;</em>) e o par de valores (<em>&lt;selector_value&gt;</em>) que você deseja usar para destinar os pods nos quais o seu app é executado. Para direcionar os seus pods e incluí-los no balanceamento de carga de serviço, certifique-se de que a <em>&lt;selector_key&gt;</em> e o <em>&lt;selector_value&gt;</em> sejam os mesmos que o par de chave/valor que você usou na seção <code>spec.template.metadata.labels</code> de seu yaml de implementação.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>A porta na qual o serviço atende.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Anotação para especificar o tipo de LoadBalancer. Os valores aceitos são `private` e `public`. Se você está criando um LoadBalancer público em clusters em VLANs públicas, essa anotação não é necessária.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Para criar um LoadBalancer privado ou usar um endereço IP móvel específico para um LoadBalancer público, substitua <em>&lt;IP_address&gt;</em> pelo endereço IP que você deseja usar. Para obter mais informações, veja a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer).</td>
        </tr>
        </tbody></table>

    3.  Opcional: configure um firewall especificando o `loadBalancerSourceRanges` na seção **spec**. Para obter mais informações, veja a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Crie o serviço em seu cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Quando o serviço de balanceador de carga for criado, um endereço IP móvel será designado automaticamente ao balanceador de carga. Se nenhum endereço IP móvel estiver disponível, o serviço de balanceador de carga não poderá ser criado.

3.  Verifique se o serviço de balanceador de carga foi criado com êxito.

    ```
    Kubectl describe myloadbalancer de serviço
    ```
    {: pre}

    **Nota:** pode levar alguns minutos para o serviço de balanceador de carga ser criado corretamente e para que o app fique disponível.

    Exemplo de saída da CLI:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    O endereço IP do **Ingresso de LoadBalancer** é o endereço IP móvel que foi designado ao seu serviço de balanceador de carga.

4.  Se você tiver criado um balanceador de carga público, acesse seu app pela Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira o endereço IP público móvel do balanceador de carga e a porta.

        ```
        Http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Se você optar por [preservar o endereço IP de origem do pacote recebido![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) e tiver nós de borda, nós do trabalhador somente privados ou múltiplas VLANs, assegure-se de que os pods do app sejam incluídos no balanceamento de carga [incluindo a afinidade de nó e as tolerâncias nos pods do app](#node_affinity_tolerations).

<br />


## Incluindo a afinidade de nó e as tolerâncias nos pods do app para o IP de origem
{: #node_affinity_tolerations}

Sempre que você implementa pods de app, os pods de serviço do balanceador de carga também são implementados nos nós do trabalhador nos quais os pods de app são implementados. No entanto, existem algumas situações em que os pods do balanceador de carga e os pods do app podem não ser planejados no mesmo nó do trabalhador:
{: shortdesc}

* Você contaminou nós de borda nos quais apenas pods do serviço de balanceador de carga podem ser implementados. Pods do app não podem ser implementados nesses nós.
* O seu cluster está conectado a múltiplas VLANs públicas ou privadas e os pods de seu app podem ser implementados em nós do trabalhador conectados apenas a uma VLAN. Os pods do serviço de balanceador de carga podem não ser implementados nesses nós do trabalhador porque o endereço IP do balanceador de carga está conectado a uma VLAN diferente daquela dos nós do trabalhador.

Quando uma solicitação do cliente para seu app é enviada para seu cluster, ela é roteada para um pod para o serviço de balanceador de carga do Kubernetes que expõe o app. Se um pod de app não existir no mesmo nó do trabalhador que o do pod de serviço de balanceador de carga, o balanceador de carga encaminhará a solicitação para um nó de trabalhador diferente no qual um pod de app é implementado. O endereço IP de origem do pacote é mudado para o endereço IP público do nó do trabalhador no qual o pod de app está em execução.

Se você quiser preservar o endereço IP de origem original da solicitação do cliente, será possível [ativar o IP de origem ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) para serviços de balanceador de carga. Preservar o IP do cliente é útil, por exemplo, quando os servidores de app precisam aplicar as políticas de segurança e de controle de acesso. Após a ativação do IP de origem, os pods do serviço de balanceador de carga devem encaminhar solicitações para pods do app que são implementados no mesmo nó do trabalhador somente. Para forçar seu app a implementar em nós do trabalhador específicos nos quais os pods do serviço de balanceador de carga também podem implementar, deve-se incluir as regras de afinidade e as tolerâncias na implementação do app.

### Incluindo regras de afinidade e tolerâncias do nó de borda
{: #edge_nodes}

Quando você [identifica nós do trabalhador como nós de borda](cs_edge.html#edge_nodes), os pods do serviço de balanceador de carga são implementados apenas nesses nós de borda. Se você também [contaminar os nós de borda](cs_edge.html#edge_workloads), os pods de app não poderão ser implementados nos nós de borda.
{:shortdesc}

Ao ativar o IP de origem, as solicitações recebidas não poderão ser encaminhadas do balanceador de carga para o pod de app. Para forçar a implementação dos pods de app nos nós de borda, inclua uma [regra de afinidade ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) e uma [tolerância ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) do nó de borda na implementação do app.

Exemplo de yaml de implementação com afinidade do nó de borda e tolerância do nó de borda:

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

Observe que ambas as seções de **afinidade** e de **tolerâncias** têm `dedicated` como a `key` e `edge` como o `value`.

### Incluindo regras de afinidade para múltiplas VLANs públicas ou privadas
{: #edge_nodes}

Quando o cluster está conectado a múltiplas VLANs públicas ou privadas, os pods do app podem ser implementados nos nós do trabalhador que são conectados apenas a uma VLAN. Se o endereço IP do balanceador de carga estiver conectado a uma VLAN diferente desses nós do trabalhador, os pods do serviço de balanceador de carga não serão implementados nesses nós do trabalhador.
{:shortdesc}

Quando o IP de origem for ativado, planeje os pods de app nos nós do trabalhador que forem a mesma VLAN que o endereço IP do balanceador de carga, incluindo uma regra de afinidade na implementação do app.

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

1. Obtenha o endereço IP do serviço de balanceador de carga que você deseja usar. Procure o endereço IP no campo **Ingress do LoadBalancer**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Recupere o ID da VLAN a que o serviço de balanceador de carga está conectado.

    1. Liste as VLANs públicas móveis para seu cluster.
        ```
        Bx cs cluster-get -- showResources < cluster_name_or_ID>
        ```
        {: pre}

        Saída de exemplo:
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. Na saída sob **VLANs da sub-rede**, procure o CIDR de sub-rede que corresponde ao endereço IP do balanceador de carga recuperado anteriormente e anote o ID da VLAN.

        Por exemplo, se o endereço IP do serviço de balanceador de carga for `169.36.5.xxx`, a sub-rede correspondente na saída de exemplo acima será `169.36.5.xxx/29`. O ID da VLAN ao qual a sub-rede está conectada é `2234945`.

3. [Inclua uma regra de afinidade ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) na implementação do app para o ID da VLAN que você anotou na etapa anterior.

    Por exemplo, se você tiver múltiplas VLANs, mas quiser que os pods de seu app sejam implementados nos nós do trabalhador somente na VLAN pública `2234945`:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    No yaml acima, a seção **afinidade** tem `publicVLAN` como a `key` e `"2234945"` como o `value`.

4. Aplique o arquivo de configuração de implementação atualizado.
    ```
    Kubectl apply -f com-node-affinity.yaml
    ```
    {: pre}

5. Verifique se os pods do app implementados nos nós do trabalhador estão conectados à VLAN designada.

    1. Liste os pods em seu cluster. Substitua `<selector>` pelo rótulo que você usou para o app.
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        Saída de exemplo:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. Na saída, identifique um pod para seu app. Observe o ID de **NÓ** do nó do trabalhador em que o pod está.

        Na saída de exemplo acima, o pod do app `cf-py-d7b7d94db-vp8pq` está no nó do trabalhador `10.176.48.78`.

    3. Liste os detalhes para o nó do trabalhador.

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        Saída de exemplo:

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. Na seção **Rótulos** da saída, verifique se a VLAN pública ou privada é a VLAN que você designou nas etapas anteriores.

