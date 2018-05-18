---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurando serviços de balanceador de carga
{: #loadbalancer}

Exponha uma porta e use um endereço IP móvel para o balanceador de carga para acessar um app conteinerizado.
{:shortdesc}

## Planejando a rede externa com serviços LoadBalancer
{: #planning}

Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} solicita automaticamente cinco endereços IP móveis públicos e cinco endereços IP móveis privados e os provisiona em sua conta de infraestrutura do IBM Cloud (SoftLayer) durante a criação do cluster. Dois dos endereços IP móveis, um público e um privado, são usados para [Balanceadores de carga de aplicativo do Ingress](cs_ingress.html#planning). Quatro endereços IP móveis públicos e quatro endereços IP móveis privados podem ser usados para expor apps criando um serviço LoadBalancer.

Ao criar um serviço do Kubernetes LoadBalancer em um cluster em uma VLAN pública, um balanceador de carga externo é criado. Suas opções para endereços IP quando você cria um serviço LoadBalancer são como a seguir:

- Se o seu cluster está em uma VLAN pública, um dos quatro endereços IP públicos móveis disponíveis é usado.
- Se o seu cluster está disponível somente em uma VLAN privada, um dos quatro endereços IP privados móveis disponíveis é usado.
- É possível solicitar um endereço IP público ou privado móvel para um serviço LoadBalancer, incluindo uma anotação no arquivo de configuração: `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.

O endereço IP público móvel que é designado ao seu serviço LoadBalancer é permanente e não muda quando um nó do trabalhador é removido ou recriado. Portanto, o serviço LoadBalancer é mais disponível do que o serviço NodePort. Diferente dos serviços NodePort, é possível designar qualquer porta a seu balanceador de carga e não ser limitado a um determinado intervalo de portas. Se você usar um serviço LoadBalancer, uma porta de nó também estará disponível em cada endereço IP de qualquer nó do trabalhador. Para bloquear o acesso à porta de nó enquanto você estiver usando um serviço LoadBalancer, consulte [Bloqueando tráfego recebido](cs_network_policy.html#block_ingress).

O serviço LoadBalancer serve como o ponto de entrada externo para solicitações recebidas para o app. Para acessar o serviço LoadBalancer por meio da Internet, use o endereço IP público do balanceador de carga e a porta designada no formato `<ip_address>:<port>`. O diagrama a seguir mostra como um balanceador de carga direciona a comunicação da Internet para um app:

<img src="images/cs_loadbalancer_planning.png" width="550" alt="Expor um app no {{site.data.keyword.containershort_notm}} usando um balanceador de carga" style="width:550px; border-style: none"/>

1. Uma solicitação é enviada para seu app usando o endereço IP público de seu balanceador de carga e a porta designada no nó do trabalhador.

2. A solicitação é encaminhada automaticamente para o endereço IP e porta do cluster interno do serviço de balanceador de carga. O endereço IP do cluster interno é acessível somente dentro do cluster.

3. `kube-proxy` roteia a solicitação para o serviço de balanceador de carga do Kubernetes para o app.

4. A solicitação é encaminhada para o endereço IP privado do pod no qual o app é implementado. Se múltiplas instâncias do app são implementadas no cluster, o balanceador de carga roteia as solicitações entre os pods de app.




<br />




## Configurando o acesso a um app com um balanceador de carga
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
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
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
          name: <myservice>
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <private_ip_address>
        ```
        {: codeblock}

        <table>
        <caption>Entendendo os componentes de arquivo do serviço LoadBalancer</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td>Substitua <em>&lt;myservice&gt;</em> por um nome para o seu serviço de balanceador de carga.</td>
        </tr>
        <tr>
          <td><code>seletor</code></td>
          <td>Insira o par de chave de etiqueta (<em>&lt;selectorkey&gt;</em>) e valor (<em>&lt;selectorvalue&gt;</em>) que você deseja usar para destinar os pods nos quais seu app é executado. Por exemplo, se você usar o seletor <code>app: code</code> a seguir, todos os pods que tiverem esse rótulo em seus metadados serão incluídos no balanceamento de carga. Insira o mesmo rótulo que você usou quando implementou o seu app no cluster. </td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>A porta na qual o serviço atende.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Anotação para especificar o tipo de LoadBalancer. Os valores são `private` e `public`. Se você está criando um LoadBalancer público em clusters em VLANs públicas, essa anotação não é necessária.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Para criar um LoadBalancer privado ou usar um endereço IP móvel específico para um LoadBalancer público, substitua <em>&lt;loadBalancerIP&gt;</em> pelo endereço IP que você deseja usar. Para obter mais informações, veja a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer).</td>
        </tr>
        </tbody></table>

    3.  Opcional: configure um firewall especificando o `loadBalancerSourceRanges` na seção de especificação. Para obter mais informações, veja a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Crie o serviço em seu cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Quando o serviço de balanceador de carga for criado, um endereço IP móvel será designado automaticamente ao balanceador de carga. Se nenhum endereço IP móvel estiver disponível, o serviço de balanceador de carga não poderá ser criado.

3.  Verifique se o serviço de balanceador de carga foi criado com êxito. Substitua _&lt;myservice&gt;_ pelo nome do serviço de balanceador de carga que você criou na etapa anterior.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **Nota:** pode levar alguns minutos para o serviço de balanceador de carga ser criado corretamente e para que o app fique disponível.

    Exemplo de saída da CLI:

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----			-------------	--------	------			-------
      10s		10s		1	{service-controller }			Normal		CreatingLoadBalancer	Creating load balancer
      10s		10s		1	{service-controller }			Normal		CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    O endereço IP do **Ingresso de LoadBalancer** é o endereço IP móvel que foi designado ao seu serviço de balanceador de carga.

4.  Se você tiver criado um balanceador de carga público, acesse seu app pela Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira o endereço IP público móvel do balanceador de carga e a porta. No exemplo acima, o endereço IP público móvel `192.168.10.38` foi designado ao serviço de balanceador de carga.

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}
