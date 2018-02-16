---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurando sub-redes para clusters
{: #subnets}

Mude o conjunto de endereços IP públicos ou privados móveis disponíveis, incluindo sub-redes em seu cluster.
{:shortdesc}

No {{site.data.keyword.containershort_notm}}, é possível incluir IPs móveis estáveis para serviços do Kubernetes, incluindo sub-redes da rede no cluster. Nesse caso, as sub-redes não estão sendo usadas com netmasking para criar a conectividade entre um ou mais clusters. Em vez disso, as sub-redes são usadas para fornecer IPs fixos permanente para um serviço de um cluster que pode ser usado para acessar esse serviço.

Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} provisiona automaticamente uma sub-rede pública móvel com 5 endereços IP públicos e uma sub-rede privada móvel com 5 endereços IP privados. Os endereços IP públicos e privados móveis são estáticos e não mudam quando um nó do trabalhador ou mesmo o cluster é removido. Para cada sub-rede, um dos endereços IP móveis públicos e um dos endereços IP móveis privados serão usados para os [balanceadores de carga de aplicativo](cs_ingress.html) que você pode usar para expor múltiplos apps em seu cluster. Os 4 endereços IP públicos móveis e os 4 endereços IP privados móveis podem ser usados para expor apps únicos ao público [criando um serviço de balanceador de carga](cs_loadbalancer.html).

**Nota:** os endereços IP públicos móveis são cobrados mensalmente. Se escolher remover os endereços IP públicos móveis depois que o cluster for provisionado, ainda assim terá que pagar o encargo mensal, mesmo se você os usou por um curto tempo.

## Solicitando sub-redes adicionais para seu cluster
{: #request}

É possível incluir IPs públicos ou privados móveis e estáveis no cluster designando sub-redes para o cluster.

**Nota:** quando você disponibiliza uma sub-rede para um cluster, os endereços IP dessa sub-rede são usados para propósitos de rede do cluster. Para evitar conflitos de endereço IP, certifique-se de usar uma sub-rede com somente um cluster. Não use uma sub-rede para múltiplos clusters ou para outros
propósitos fora do {{site.data.keyword.containershort_notm}} ao mesmo
tempo.

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para criar uma sub-rede em uma conta de infraestrutura do IBM Cloud (SoftLayer) e torná-la disponível para um cluster especificado:

1. Provisione uma nova sub-rede.

    ```
    bx cs cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>O comando para provisionar uma sub-rede para seu cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td>Substitua <code>&gt;cluster_name_or_id &lt;</code> pelo nome ou o ID do cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>Substitua <code>&gt;subnet_size&lt;</code> pelo número de endereços IP que você deseja incluir de sua sub-rede móvel. Os valores aceitos são 8, 16, 32 ou 64. <p>**Observação:** quando você inclui endereços IP móveis em sua sub-rede, três endereços IP são usados para estabelecer redes internas de cluster, de forma que não é possível usá-los para seu balanceador de carga do aplicativo ou para criar um serviço do balanceador de carga. Por exemplo, se você solicitar oito endereços IP públicos móveis, será possível usar cinco deles para expor os seus apps ao público.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Substitua <code>&gt;&lt;VLAN_ID</code> pelo ID da VLAN pública ou privada na qual você deseja alocar os endereços IP móveis públicos ou privados. Deve-se selecionar a VLAN pública ou privada à qual um nó do trabalhador existente está conectado. Para revisar a VLAN pública ou a VLAN privada para um nó do trabalhador, execute o comando <code>bx cs worker-get &gt;worker_id&lt;</code>.</td>
    </tr>
    </tbody></table>

2.  Verifique se a sub-rede foi criada com sucesso e se foi incluída em seu cluster. A sub-rede CIDR é listada na seção **VLANs**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

<br />


## Incluindo sub-redes customizadas e existentes nos clusters do Kubernetes
{: #custom}

É possível incluir sub-redes públicas ou privadas móveis existentes em seu cluster do Kubernetes.

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Se você tiver uma sub-rede existente no portfólio da infraestrutura do IBM Cloud (SoftLayer) com regras de firewall customizado ou endereços IP disponíveis que deseja usar, crie um cluster sem sub-rede e disponibilize sua sub-rede existente para o cluster quando o cluster provisionar.

1.  Identifique a sub-rede a ser usada. Observe o ID da sub-rede e o ID da VLAN. Neste exemplo, o ID da sub-rede é 807861 e o ID da VLAN é 1901230.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Confirme a localização da VLAN. Neste exemplo, o local é dal10.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Crie um cluster usando o local e o ID da VLAN identificados. Inclua a sinalização `--no-subnet` para evitar que uma nova sub-rede IP pública móvel e uma nova sub-rede IP privada móvel seja criada automaticamente.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Verifique se a criação do cluster foi solicitada.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** pode levar até 15 minutos para que as máquinas do nó do trabalhador sejam ordenadas e para que o cluster seja configurado e provisionado em sua conta.

    Quando o fornecimento do cluster é concluído, o status do cluster muda para **implementado**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Verifique o status dos nós do trabalhador.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando os nós do trabalhador estiverem prontos, o estado mudará para **normal** e o status será **Pronto**. Quando o status do nó for **Pronto**, será possível, então, acessar o cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Inclua a sub-rede em seu cluster especificando o ID da sub-rede. Quando você disponibiliza uma sub-rede para um cluster, é criado um mapa de configuração do Kubernetes para você que inclui todos os endereços IP públicos móveis disponíveis que podem ser usados. Se ainda não existir nenhum balanceador de carga de aplicativo para seu cluster, um endereço IP móvel público e um endereço IP móvel privado serão usados automaticamente para criar os balanceadores de carga de aplicativo públicos e privados. Todos os outros endereços IP públicos e privados móveis podem ser usados para criar serviços de balanceador de carga para seus apps.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

<br />


## Incluindo sub-redes gerenciadas por usuário e endereços IP para clusters do Kubernetes
{: #user_managed}

Forneça sua própria sub-rede de uma rede no local que você desejar que o {{site.data.keyword.containershort_notm}} acesse. Em seguida, é possível incluir endereços IP privados dessa sub-rede para serviços de balanceador de carga em seu cluster do Kubernetes.

Requisitos:
- Sub-redes gerenciadas pelo usuário podem ser incluídas em VLANs privadas apenas.
- O limite de comprimento de prefixo de sub-rede é /24 para /30. Por exemplo, `203.0.113.0/24` especifica 253 endereços IP privados utilizáveis, enquanto `203.0.113.0/30` especifica 1 endereço IP privado utilizável.
- O primeiro endereço IP na sub-rede deve ser usado como o gateway para a sub-rede.

Antes de iniciar:
- Configure o roteamento de tráfego de rede dentro e fora da sub-rede externa.
- Confirme se você tem conectividade de VPN entre o dispositivo de gateway do data center no local e a rede privada Vyatta em seu portfólio de infraestrutura do IBM Cloud (SoftLayer) ou o serviço VPN do Strongswan em execução em seu cluster. Para usar um Vyatta, veja esta [postagem do blog ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)]. Para usar Strongswan, veja [Configurando a conectividade de VPN com o serviço VPN IPSec do Strongswan](cs_vpn.html).

1. Visualize o ID de VLAN privada do seu cluster. Localize a seção **VLANs**. No campo **Gerenciado pelo usuário**, identifique o ID da VLAN com _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Inclua a sub-rede externa em sua VLAN privada. Os endereços IP privados móveis são incluídos no mapa de configuração do cluster.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Exemplo:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Verifique se a sub-rede fornecida pelo usuário foi incluída. O campo **Gerenciado pelo usuário** é _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Inclua um serviço de balanceador de carga privado ou um balanceador de carga privado do aplicativo Ingress para acessar seu app na rede privada. Se você deseja usar um endereço IP privado da sub-rede que você incluiu quando criou um balanceador de carga privado ou um balanceador de carga privado do aplicativo Ingress, deve-se especificar um endereço IP. Caso contrário, um endereço IP será escolhido aleatoriamente das sub-redes de infraestrutura do IBM Cloud (SoftLayer) ou sub-redes fornecidas pelo usuário na VLAN privada. Para obter mais informações, veja [Configurando acesso a um app usando o tipo de serviço de balanceador de carga](cs_loadbalancer.html#config) ou [Ativando o balanceador de carga de aplicativo privado](cs_ingress.html#private_ingress).

<br />


## Gerenciando endereços IP e sub-redes
{: #manage}

É possível usar sub-redes e endereços IP públicos e privados móveis para expor apps em seu cluster e torná-los acessíveis na Internet ou em uma rede privada.
{:shortdesc}

No {{site.data.keyword.containershort_notm}}, é possível incluir IPs móveis estáveis para serviços do Kubernetes, incluindo sub-redes da rede no cluster. Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} provisiona automaticamente uma sub-rede pública móvel com 5 endereços IP públicos móveis e uma sub-rede privada móvel com 5 endereços IP privados móveis. Os endereços IP móveis são estáticos e não mudam quando um nó do trabalhador ou, até mesmo o cluster, é removido.

Dois dos endereços IP móveis, um público e um privado, são usados para os [Balanceadores de carga de aplicativo do Ingress](cs_ingress.html) que você pode usar para expor múltiplos apps em seu cluster. 4 endereços IP públicos móveis e 4 endereços IP privados móveis podem ser usados para expor apps [criando um serviço de balanceador de carga](cs_loadbalancer.html).

**Nota:** os endereços IP públicos móveis são cobrados mensalmente. Se escolher remover os endereços IP públicos móveis depois que o cluster for provisionado, ainda assim terá que pagar o encargo mensal, mesmo se você os usou por um curto tempo.



1.  Crie um arquivo de configuração de serviço do Kubernetes que seja chamado `myservice.yaml` e defina um serviço do tipo `LoadBalancer` com um endereço IP do balanceador de carga simulado. O exemplo a seguir usa o endereço IP 1.1.1.1 como o endereço IP do balanceador de carga.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Crie o serviço em seu cluster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Inspecione o serviço.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Nota:** a criação desse serviço falha porque o mestre do Kubernetes não pode localizar o endereço IP do balanceador de carga especificado no mapa de configuração do Kubernetes. Quando você executa esse comando, é possível ver a mensagem de erro e a lista de endereços IP públicos disponíveis para o cluster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. Os IPs do provedor em nuvem a seguir estão disponíveis: <list_of_IP_addresses>
    ```
    {: screen}

<br />




## Liberando os endereços IP usados
{: #free}

É possível liberar um endereço IP móvel usado excluindo o serviço de balanceador de carga que está usando o endereço IP móvel.

Antes de iniciar, [configure o contexto para o cluster que você deseja usar.](cs_cli_install.html#cs_cli_configure)

1.  Liste os serviços disponíveis em seu cluster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Remova o serviço de balanceador de carga que usa um endereço IP público ou privado.

    ```
    kubectl delete service <myservice>
    ```
    {: pre}
