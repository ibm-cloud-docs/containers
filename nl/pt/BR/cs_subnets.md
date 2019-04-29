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



# Configurando sub-redes para clusters
{: #subnets}

Mude o conjunto de endereços IP públicos ou privados móveis disponíveis para serviços de balanceador de carga, incluindo sub-redes em seu cluster do Kubernetes.
{:shortdesc}

## Usando sub-redes customizadas ou existentes da infraestrutura do IBM Cloud (SoftLayer) para criar um cluster
{: #subnets_custom}

Ao criar um cluster padrão, as sub-redes são criadas automaticamente para você. No entanto, em vez de usar as sub-redes provisionadas automaticamente, é possível usar as sub-redes móveis existentes de sua conta de infraestrutura do IBM Cloud (SoftLayer) ou reutilizar sub-redes de um cluster excluído.
{:shortdesc}

Use essa opção para reter endereços IP estáticos estáveis em remoções e criações de cluster ou para pedir blocos maiores de endereços IP. Se, em vez disso, você desejar obter mais endereços IP privados móveis para seus serviços de balanceador de carga de cluster usando sua própria sub-rede da rede no local, consulte [Incluindo IPs privados móveis incluindo sub-redes gerenciadas pelo usuário em VLANs privadas](#user_managed).

Os endereços IP públicos móveis são cobrados mensalmente. Se você remover os endereços IP públicos móveis depois que o cluster for provisionado, ainda terá que pagar o encargo mensal, mesmo se os tiver usado apenas por um curto período de tempo.
{: note}

Antes de iniciar:
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
- Para reutilizar sub-redes de um cluster que você não precisa mais, exclua o cluster desnecessário. Crie o novo cluster imediatamente, porque as sub-redes serão excluídas dentro de 24 horas se você não as reutilizar.

   ```
   ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
   ```
   {: pre}

Para usar uma sub-rede existente no portfólio da infraestrutura do IBM Cloud (SoftLayer) com regras de firewall customizado ou endereços IP disponíveis:

1. Obtenha o ID da sub-rede que você deseja usar e o ID da VLAN no qual a sub-rede está.

    ```
    ibmcloud ks subnets
    ```
    {: pre}

    Nesta saída de exemplo, o ID de sub-rede é `1602829` e o ID de VLAN é `2234945`:
    ```
    Getting subnet list...
    OK
    ID        Network             Gateway          VLAN ID   Type      Bound Cluster
    1550165   10.xxx.xx.xxx/26    10.xxx.xx.xxx    2234947   private
    1602829   169.xx.xxx.xxx/28   169.xx.xxx.xxx   2234945   public
    ```
    {: screen}

2. [Crie um cluster](/docs/containers?topic=containers-clusters#clusters_cli) usando o ID de VLAN que você identificou. Inclua a sinalização `--no-subnet` para evitar que uma nova sub-rede IP pública móvel e uma nova sub-rede IP privada móvel seja criada automaticamente.

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    Se você não puder lembrar em qual zona a VLAN está para a sinalização `--zone`, será possível verificar se a VLAN está em uma determinada zona executando `ibmcloud ks vlans --zone <zone>`.
    {: tip}

3.  Verifique se o cluster foi criado. Pode levar até 15 minutos para que as máquinas do nó do trabalhador sejam ordenadas e para que o cluster seja configurado e provisionado em sua conta.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Quando seu cluster estiver totalmente provisionado, o **State** mudará para `deployed`.

    ```
    Name         ID                                   State      Created          Workers    Zone      Version     Resource Group Name
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3          dal10     1.12.6      Default
    ```
    {: screen}

4.  Verifique o status dos nós do trabalhador.

    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Antes de continuar com a próxima etapa, os nós do trabalhador devem estar prontos. O **State** muda para `normal` e o **Status** é `Ready`.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone     Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.12.6
    ```
    {: screen}

5.  Inclua a sub-rede em seu cluster especificando o ID da sub-rede. Quando você disponibiliza uma sub-rede para um cluster, um configmap do Kubernetes é criado incluindo todos os endereços IP públicos móveis disponíveis que podem ser usados. Se nenhum ALB do Ingresso existir na zona na qual a VLAN da sub-rede está localizada, um endereço IP privado móvel e um público móvel serão usados automaticamente para criar os ALBs públicos e privados para essa zona. É possível usar todos os outros endereços IP públicos e privados móveis da sub-rede para criar serviços de balanceador de carga para seus apps.

  ```
  ibmcloud ks cluster-subnet-add --cluster <cluster_name_or_id> --subnet-id <subnet_ID>
  ```
  {: pre}

  Exemplo de comando:
  ```
  ibmcloud ks cluster-subnet-add --cluster mycluster --subnet-id 807861
  ```
  {: screen}

6. **Importante**: para ativar a comunicação entre trabalhadores que estiverem em sub-redes diferentes na mesma VLAN, deve-se [ativar o roteamento entre sub-redes na mesma VLAN](#subnet-routing).

<br />


## Gerenciando endereços IP móveis portáteis
{: #managing_ips}

Por padrão, 4 endereços IP públicos móveis e 4 privados móveis podem ser usados para expor apps únicos à rede pública ou privada [criando um serviço de balanceador de carga](/docs/containers?topic=containers-loadbalancer). Para criar um serviço de balanceador de carga, deve-se ter pelo menos 1 endereço IP móvel do tipo correto disponível. É possível visualizar os endereços IP móveis que estão disponíveis ou liberar um endereço IP móvel usado.
{: shortdesc}

### Visualizando endereços IP públicos móveis disponíveis
{: #review_ip}

Para listar todos os endereços IP móveis em seu cluster, ambos usados e disponíveis, é possível executar o comando a seguir.
{: shortdesc}

```
kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
```
{: pre}

Para listar somente os endereços IP públicos móveis que estão disponíveis para criar balanceadores de carga, é possível usar as etapas a seguir:

Antes de iniciar:
-  Assegure-se de que você tenha a [função de **Gravador** ou **Gerenciador** do serviço {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o namespace `default`.
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Para listar os endereços IP públicos móveis disponíveis:

1.  Crie um arquivo de configuração de serviço do Kubernetes que seja chamado `myservice.yaml` e defina um serviço do tipo `LoadBalancer` com um endereço IP do balanceador de carga simulado. O exemplo a seguir usa o endereço IP 1.1.1.1 como
o endereço IP do balanceador de carga. Substitua `<zone>` pela zona na qual você deseja verificar os IPs disponíveis.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
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

    A criação desse serviço falha porque o mestre do Kubernetes não pode localizar o endereço IP do balanceador de carga especificado no configmap do Kubernetes. Quando você executa esse comando, é possível ver a mensagem de erro e a lista de endereços IP públicos disponíveis para o cluster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. Os endereços IP do provedor em nuvem a seguir estão disponíveis: <list_of_IP_addresses>
    ```
    {: screen}

<br />


### Liberando os endereços IP usados
{: #free}

É possível liberar um endereço IP móvel usado excluindo o serviço de balanceador de carga que está usando o endereço IP móvel.
{:shortdesc}

Antes de iniciar:
-  Assegure-se de que você tenha a [função de **Gravador** ou **Gerenciador** do serviço {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o namespace `default`.
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Para excluir um balanceador de carga:

1.  Liste os serviços disponíveis em seu cluster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Remova o serviço de balanceador de carga que usa um endereço IP público ou privado.

    ```
    kubectl delete service <service_name>
    ```
    {: pre}

<br />


## Incluindo endereços IP móveis
{: #adding_ips}

Por padrão, 4 endereços IP públicos móveis e 4 privados móveis podem ser usados para expor apps únicos à rede pública ou privada [criando um serviço de balanceador de carga](/docs/containers?topic=containers-loadbalancer). Para criar mais de 4 balanceadores de carga públicos ou 4 privados, é possível obter mais endereços IP móveis, incluindo sub-redes de rede no cluster.
{: shortdesc}

Quando você torna uma sub-rede disponível para um cluster, os endereços IP
dessa sub-rede são usados para propósitos de rede do cluster. Para evitar conflitos de endereço IP, certifique-se de usar uma sub-rede com somente um cluster. Não use uma sub-rede para múltiplos clusters ou para outros
propósitos fora do {{site.data.keyword.containerlong_notm}} ao mesmo
tempo.
{: important}

Os endereços IP públicos móveis são cobrados mensalmente. Se você remove os endereços IP públicos móveis após a sua sub-rede ser provisionada, deve-se ainda pagar o encargo mensal, mesmo que os tenha usado somente por uma curta quantia de tempo.
{: note}

### Incluindo IPs móveis pedindo mais sub-redes
{: #request}

É possível obter mais IPs móveis para serviços de balanceador de carga criando uma nova sub-rede em uma conta de infraestrutura do IBM Cloud (SoftLayer) e tornando-a disponível para seu cluster especificado.
{:shortdesc}

Antes de iniciar:
-  Assegure-se de que você tenha a [função de **Operador** ou **Administrador** da plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o cluster.
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Para pedir uma sub-rede:

1. Provisione uma nova sub-rede.

    ```
    ibmcloud ks cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
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
    <td>Substitua <code>&lt;cluster_name_or_id&gt;</code> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>Substitua <code>&lt;subnet_size&gt;</code> pelo número de endereços IP que você deseja incluir de sua sub-rede móvel. Os valores aceitos são 8, 16, 32 ou 64. <p class="note"> Quando você inclui endereços IP móveis para sua sub-rede, três endereços IP são usados para estabelecer a rede interna do cluster. Não é possível usar esses três endereços IP para seu balanceador de carga do aplicativo ou para criar um serviço de balanceador de carga. Por exemplo, se você solicitar oito endereços IP públicos móveis, será possível usar cinco deles para expor os seus apps ao público.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Substitua <code>&lt;VLAN_ID&gt;</code> pelo ID da VLAN pública ou privada na qual você deseja alocar os endereços IP móveis públicos ou privados. Deve-se selecionar a VLAN pública ou privada à qual um nó do trabalhador existente está conectado. Para revisar a VLAN pública ou privada para um nó do trabalhador, execute o comando <code>ibmcloud ks worker-get --worker &lt;worker_id&gt;</code>. <A sub-rede é provisionada na mesma zona em que a VLAN está.</td>
    </tr>
    </tbody></table>

2. Verifique se a sub-rede foi criada com sucesso e se foi incluída em seu cluster. O CIDR da sub-rede é listado na seção **Subnet VLANs**.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name_or_ID>
    ```
    {: pre}

    Nesta saída de exemplo, uma segunda sub-rede foi incluída na VLAN pública `2234945`:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR          Public   User-managed
    2234947   10.xxx.xx.xxx/29     false    false
    2234945   169.xx.xxx.xxx/29    true     false
    2234945   169.xx.xxx.xxx/29    true     false
    ```
    {: screen}

3. **Importante**: para ativar a comunicação entre trabalhadores que estiverem em sub-redes diferentes na mesma VLAN, deve-se [ativar o roteamento entre sub-redes na mesma VLAN](#subnet-routing).

<br />


### Incluindo IPs privados portáteis incluindo sub-redes gerenciadas pelo usuário em VLANs privadas
{: #user_managed}

É possível obter mais IPs privados móveis para serviços do balanceador de carga fazendo uma sub-rede de uma rede no local disponível para seu cluster.
{:shortdesc}

Deseja reutilizar sub-redes móveis existentes em sua conta de infraestrutura do IBM Cloud (SoftLayer) em vez disso? Consulte [Usando sub-redes customizadas ou existentes da infraestrutura do IBM Cloud (SoftLayer) para criar um cluster](#subnets_custom).
{: tip}

Requisitos:
- Sub-redes gerenciadas pelo usuário podem ser incluídas em VLANs privadas apenas.
- O limite de comprimento de prefixo de sub-rede é /24 para /30. Por exemplo, `169.xx.xxx.xxx/24` especifica 253 endereços IP privados utilizáveis, enquanto `169.xx.xxx.xxx/30` especifica 1 endereço IP privado utilizável.
- O primeiro endereço IP na sub-rede deve ser usado como o gateway para a sub-rede.

Antes de iniciar:
- Configure o roteamento de tráfego de rede dentro e fora da sub-rede externa.
- Confirme se você tem conectividade VPN entre o gateway de rede do data center no local e o Virtual Router Appliance de rede privada ou o serviço VPN do strongSwan que é executado em seu cluster. Para obter mais informações, veja [Configurando a conectividade VPN](/docs/containers?topic=containers-vpn).
-  Assegure-se de que você tenha a [função de **Operador** ou **Administrador** da plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o cluster.
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).


Para incluir uma sub-rede de uma rede no local:

1. Visualize o ID da VLAN privada de seu cluster. Localize a seção  ** VLANs de sub-rede ** . No campo **Gerenciado pelo usuário**, identifique o ID da VLAN com _false_.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    Subnet VLANs VLAN ID Subnet CIDR Public User-managed 2234947 10.xxx.xx.xxx/29 false false 2234945 169.xx.xxx.xxx/29 true false
    ```
    {: screen}

2. Inclua a sub-rede externa em sua VLAN privada. Os endereços IP privados móveis são incluídos no configmap do cluster.

    ```
    ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Exemplo:

    ```
    ibmcloud ks cluster-user-subnet-add mycluster 10.xxx.xx.xxx/ 24 2234947
    ```
    {: pre}

3. Verifique se a sub-rede fornecida pelo usuário foi incluída. O campo **Gerenciado pelo usuário** é _true_.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    Nesta saída de exemplo, uma segunda sub-rede foi incluída na VLAN privada `2234947`:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR       Public   User-managed
    2234947   10.xxx.xx.xxx/29  false    false
    2234945   169.xx.xxx.xxx/29 true     false
    2234947   10.xxx.xx.xxx/24  false    true
    ```
    {: screen}

4. [Ative o roteamento entre sub-redes na mesma VLAN](#subnet-routing).

5. Inclua um [serviço de balanceador de carga privado](/docs/containers?topic=containers-loadbalancer) ou ative um [ALB do Ingresso privado](/docs/containers?topic=containers-ingress#private_ingress) para acessar seu app por meio da rede privada. Para usar um endereço IP privado por meio da sub-rede que você incluiu, deve-se especificar um endereço IP do CIDR da sub-rede. Caso contrário, um endereço IP será escolhido aleatoriamente das sub-redes de infraestrutura do IBM Cloud (SoftLayer) ou sub-redes fornecidas pelo usuário na VLAN privada.

<br />


## Gerenciando o roteamento de sub
{: #subnet-routing}

Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster de múltiplas zonas, deve-se ativar um [Virtual Router Function (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que seus nós do trabalhador possam se comunicar entre si na rede privada. Para ativar o VRF, [entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Se não for possível ou você não desejar ativar o VRF, ative o [VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Para executar essa ação, você precisa da [permissão de infraestrutura](/docs/containers?topic=containers-users#infra_access) **Rede > Gerenciar a rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.

Revise os cenários a seguir nos quais o VLAN Spanning também é necessário.

### Ativando o roteamento entre as sub-redes primárias na mesma VLAN
{: #vlan-spanning}

Quando você cria um cluster, as sub-redes públicas primárias e privadas são provisionadas nas VLANs públicas e privadas. A sub-rede pública primária termina em `/28` e fornece 14 IPs públicos para os nós do trabalhador. A sub-rede privada primária termina em `/26` e fornece IPs privados para até 62 nós do trabalhador.
{:shortdesc}

Você pode exceder os 14 IPs públicos e os 62 IPs privados iniciais para nós do trabalhador, tendo um cluster grande ou vários clusters menores na mesma localização na mesma VLAN. Quando uma sub-rede pública ou privada atinge o limite de nós do trabalhador, outra sub-rede primária na mesma VLAN é pedida.

Para assegurar que os trabalhadores nessas sub-redes primárias na mesma VLAN possam se comunicar, deve-se ativar o VLAN Spanning. Para obter instruções, veja [Ativar ou desativar a ampliação de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning).

Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

### Gerenciando o roteamento de sub-rede para dispositivos
{: #vra-routing}

Ao criar um cluster, uma sub-rede privada móvel e uma pública móvel são pedidas nas VLANs às quais o cluster está conectado. Essas sub-redes fornecem endereços IP para serviços de rede do Ingresso e do balanceador de carga.
{: shortdesc}

No entanto, se você tiver um dispositivo de roteador existente, como um [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra), as sub-redes móveis recém-incluídas daquelas VLANs às quais o cluster está conectado não serão configuradas no roteador. Para usar os serviços de rede do Ingresso ou do balanceador de carga, deve-se assegurar que os dispositivos de rede possam rotear entre diferentes sub-redes na mesma VLAN [ativando o VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning).

Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}
