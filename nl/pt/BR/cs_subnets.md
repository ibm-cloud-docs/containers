---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

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

Mude o conjunto de endereços IP públicos ou privados móveis disponíveis para serviços de balanceador de carga, incluindo sub-redes em seu cluster do Kubernetes.
{:shortdesc}

## VLANs, sub-redes e IPs padrão para clusters
{: #default_vlans_subnets}

Durante a criação do cluster, os nós do trabalhador do cluster e as sub-redes padrão são conectados automaticamente a uma VLAN.

### VLANs
{: #vlans}

Quando você cria um cluster, os nós do trabalhador do cluster são conectados automaticamente a uma VLAN. Uma VLAN configura um grupo de nós do trabalhador e pods como se eles estivessem conectados à mesma ligação física e fornece um canal para conectividade entre os trabalhadores e os pods.

<dl>
<dt>VLANs para clusters grátis</dt>
<dd>Em clusters grátis, os nós do trabalhador do cluster são conectados a uma VLAN pública e uma VLAN privada de propriedade da IBM por padrão. Como a IBM controla as VLANs, as sub-redes e os endereços IP, não é possível criar clusters de múltiplas zonas ou incluir sub-redes em seu cluster e é possível usar somente serviços NodePort para expor seu app.</dd>
<dt>VLANs para clusters padrão</dt>
<dd>Em clusters padrão, na primeira vez que você criar um cluster em uma zona, uma VLAN pública e uma VLAN privada nessa zona serão provisionadas automaticamente para você em sua conta de infraestrutura do IBM Cloud (SoftLayer). Para cada cluster subsequente que você cria nessa zona, é possível reutilizar a mesma VLAN pública e privada porque múltiplos clusters podem compartilhar VLANs.</br></br>É possível conectar seus nós do trabalhador a uma VLAN pública e à VLAN privada ou somente à VLAN privada. Se você deseja conectar seus nós do trabalhador somente a uma VLAN privada, é possível usar o ID de uma VLAN privada existente ou [criar uma VLAN privada](/docs/cli/reference/ibmcloud/cli_vlan.html#ibmcloud-sl-vlan-create) e usar o ID durante a criação do cluster.</dd></dl>

Para ver as VLANs que são provisionadas em cada zona para sua conta, execute `ibmcloud ks vlans <zone>.` Para ver as VLANs em que um cluster está provisionado, execute `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` e procure a seção **VLANs da sub-rede**.

**Nota**:
* Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).
* A infraestrutura do IBM Cloud (SoftLayer) gerencia as VLANs que são provisionadas automaticamente quando você cria seu primeiro cluster em uma zona. Se você deixar que uma VLAN se torne inutilizável, como removendo todos os nós do trabalhador de uma VLAN, a infraestrutura do IBM Cloud (SoftLayer) recuperará a VLAN. Depois, se você precisar de uma nova VLAN, [entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#order-vlans).

### Subnets e endereços IP
{: #subnets_ips}

Além dos nós do trabalhador e dos pods, as sub-redes também são provisionadas automaticamente em VLANs. As sub-redes fornecem conectividade de rede para seus componentes do cluster designando endereços IP a eles.

As sub-redes a seguir são provisionadas automaticamente nas VLANs públicas e privadas padrão:

** Sub-redes Public VLAN **
* A sub-rede pública primária determina os endereços IP públicos que são designados aos nós do trabalhador durante a criação do cluster. Múltiplos clusters na mesma VLAN podem compartilhar uma sub-rede pública primária.
* A sub-rede pública móvel é ligada a somente um cluster e fornece o cluster com 8 endereços IP públicos. 3 IPs são reservados para as funções de infraestrutura do IBM Cloud (SoftLayer). 1 IP é usado pelo ALB do Ingresso público padrão e 4 IPs podem ser usados para criar serviços de rede do balanceador de carga público. Os IPs públicos móveis são endereços IP fixos permanentes que podem ser usados para acessar serviços de balanceador de carga na Internet. Se você precisar de mais de 4 IPs para balanceadores de carga públicos, consulte [Incluindo endereços IP móveis](#adding_ips).

** Sub-redes de VLAN privada **
* A sub-rede privada primária determina os endereços IP privados que são designados aos nós do trabalhador durante a criação do cluster. Múltiplos clusters na mesma VLAN podem compartilhar uma sub-rede privada primária.
* A sub-rede privada móvel é ligada a somente um cluster e fornece o cluster com 8 endereços IP privados. 3 IPs são reservados para as funções de infraestrutura do IBM Cloud (SoftLayer). 1 IP é usado pelo ALB do Ingresso privado padrão e 4 IPs podem ser usados para criar serviços de rede do balanceador de carga privado. Os IPs privados móveis são endereços IP fixos permanentes que podem ser usados para acessar serviços de balanceador de carga na Internet. Se você precisar de mais de 4 IPs para balanceadores de carga privados, consulte [Incluindo endereços IP móveis](#adding_ips).

Para ver todas as sub-redes provisionadas em sua conta, execute `ibmcloud ks subnets`. Para ver as sub-redes privadas e públicas móveis que estão ligadas a um cluster, é possível executar `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` e procure a seção **VLANs da sub-rede**.

**Nota**: no {{site.data.keyword.containerlong_notm}}, as VLANs têm um limite de 40 sub-redes. Se você atingir esse limite, primeiro verifique se é possível [reutilizar sub-redes na VLAN para criar novos clusters](#custom). Se você precisar de uma nova VLAN, peça uma [contatando o suporte do {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#order-vlans). Em seguida, [crie um cluster](cs_cli_reference.html#cs_cluster_create) que usa essa nova VLAN.

<br />


## Usando sub-redes customizadas ou existentes para criar um cluster
{: #custom}

Ao criar um cluster padrão, as sub-redes são criadas automaticamente para você. No entanto, em vez de usar as sub-redes provisionadas automaticamente, é possível usar as sub-redes móveis existentes de sua conta de infraestrutura do IBM Cloud (SoftLayer) ou reutilizar sub-redes de um cluster excluído.
{:shortdesc}

Use essa opção para reter endereços IP estáticos estáveis em remoções e criações de cluster ou para pedir blocos maiores de endereços IP.

**Nota:** os endereços IP públicos móveis são cobrados mensalmente. Se você remover os endereços IP públicos móveis depois que o cluster for provisionado, ainda terá que pagar o encargo mensal, mesmo se os tiver usado apenas por um curto período de tempo.

Antes de iniciar:
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).
- Para reutilizar sub-redes de um cluster que você não precisa mais, exclua o cluster desnecessário. Crie o novo cluster imediatamente, porque as sub-redes serão excluídas dentro de 24 horas se você não as reutilizar.

   ```
   ibmcloud ks cluster-rm <cluster_name_or_ID>
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

2. [Crie um cluster](cs_clusters.html#clusters_cli) usando o ID de VLAN que você identificou. Inclua a sinalização `--no-subnet` para evitar que uma nova sub-rede IP pública móvel e uma nova sub-rede IP privada móvel seja criada automaticamente.

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    Se não puder se lembrar em qual zona a VLAN está para a sinalização `--zone`, será possível verificar se a VLAN está em uma determinada zona executando `ibmcloud ks vlans <zone>`.
    {: tip}

3.  Verifique se o cluster foi criado. **Nota:** pode levar até 15 minutos para que as máquinas do nó do trabalhador sejam pedidas e para que o cluster seja configurado e provisionado em sua conta.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Quando seu cluster estiver totalmente provisionado, o **State** mudará para `deployed`.

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3         dal10      1.10.8
    ```
    {: screen}

4.  Verifique o status dos nós do trabalhador.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Antes de continuar com a próxima etapa, os nós do trabalhador devem estar prontos. O **State** muda para `normal` e o **Status** é `Ready`.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone   Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.10.8
    ```
    {: screen}

5.  Inclua a sub-rede em seu cluster especificando o ID da sub-rede. Quando você disponibiliza uma sub-rede para um cluster, um configmap do Kubernetes é criado incluindo todos os endereços IP públicos móveis disponíveis que podem ser usados. Se nenhum ALB do Ingresso existir na zona na qual a VLAN da sub-rede está localizada, um endereço IP privado móvel e um público móvel serão usados automaticamente para criar os ALBs públicos e privados para essa zona. É possível usar todos os outros endereços IP públicos e privados móveis da sub-rede para criar serviços de balanceador de carga para seus apps.

    ```
    ibmcloud ks cluster-subnet-add mycluster 807861
    ```
    {: pre}

6. **Importante**: para ativar a comunicação entre trabalhadores que estiverem em sub-redes diferentes na mesma VLAN, deve-se [ativar o roteamento entre sub-redes na mesma VLAN](#subnet-routing).

<br />


## Gerenciando endereços IP móveis portáteis
{: #managing_ips}

Por padrão, 4 endereços IP públicos móveis e 4 privados móveis podem ser usados para expor apps únicos para a rede pública ou privada [criando um serviço de balanceador de carga](cs_loadbalancer.html). Para criar um serviço de balanceador de carga, deve-se ter pelo menos 1 endereço IP móvel do tipo correto disponível. É possível visualizar os endereços IP móveis que estão disponíveis ou liberar um endereço IP móvel usado.

### Visualizando endereços IP públicos móveis disponíveis
{: #review_ip}

Para listar todos os endereços IP móveis em seu cluster, usados e disponíveis, é possível executar:

```
kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
```
{: pre}

Para listar somente os endereços IP públicos móveis que estão disponíveis para criar balanceadores de carga, é possível usar as etapas a seguir:

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).

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

    **Nota:** a criação desse serviço falha porque o mestre do Kubernetes não pode localizar o endereço IP do balanceador de carga especificado no configmap do Kubernetes. Quando você executa esse comando, é possível ver a mensagem de erro e a lista de endereços IP públicos disponíveis para o cluster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. Os endereços IP do provedor em nuvem a seguir estão disponíveis: <list_of_IP_addresses>
    ```
    {: screen}

<br />


### Liberando os endereços IP usados
{: #free}

É possível liberar um endereço IP móvel usado excluindo o serviço de balanceador de carga que está usando o endereço IP móvel.
{:shortdesc}

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).

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

Por padrão, 4 endereços IP públicos móveis e 4 privados móveis podem ser usados para expor apps únicos para a rede pública ou privada [criando um serviço de balanceador de carga](cs_loadbalancer.html). Para criar mais de 4 balanceadores de carga públicos ou 4 privados, é possível obter mais endereços IP móveis, incluindo sub-redes de rede no cluster.

**Nota:**
* Quando você torna uma sub-rede disponível para um cluster, os endereços IP
dessa sub-rede são usados para propósitos de rede do cluster. Para evitar conflitos de endereço IP, certifique-se de usar uma sub-rede com somente um cluster. Não use uma sub-rede para múltiplos clusters ou para outros
propósitos fora do {{site.data.keyword.containerlong_notm}} ao mesmo
tempo.
* Os endereços IP públicos móveis são cobrados mensalmente. Se você remove os endereços IP públicos móveis após a sua sub-rede ser provisionada, deve-se ainda pagar o encargo mensal, mesmo que os tenha usado somente por uma curta quantia de tempo.

### Incluindo IPs móveis pedindo mais sub-redes
{: #request}

É possível obter mais IPs móveis para serviços de balanceador de carga criando uma nova sub-rede em uma conta de infraestrutura do IBM Cloud (SoftLayer) e tornando-a disponível para seu cluster especificado.
{:shortdesc}

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).

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
    <td>Substitua <code>&lt;subnet_size&gt;</code> pelo número de endereços IP que você deseja incluir de sua sub-rede móvel. Os valores aceitos são 8, 16, 32 ou 64. <p>**Nota:** quando você inclui endereços IP móveis para sua sub-rede, três endereços IP são usados para estabelecer a rede interna do cluster. Não é possível usar esses três endereços IP para seu balanceador de carga do aplicativo ou para criar um serviço de balanceador de carga. Por exemplo, se você solicitar oito endereços IP públicos móveis, será possível usar cinco deles para expor os seus apps ao público.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Substitua <code>&lt;VLAN_ID&gt;</code> pelo ID da VLAN pública ou privada na qual você deseja alocar os endereços IP móveis públicos ou privados. Deve-se selecionar a VLAN pública ou privada à qual um nó do trabalhador existente está conectado. Para revisar a VLAN pública ou privada para um nó do trabalhador, execute o comando <code>ibmcloud ks worker-get &lt;worker_id&gt;</code>. <A sub-rede é provisionada na mesma zona em que a VLAN está.</td>
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


### Incluindo IPs privados móveis usando sub-redes gerenciadas pelo usuário
{: #user_managed}

É possível obter mais IPs privados móveis para serviços de balanceador de carga tornando uma sub-rede de uma rede no local disponível para o cluster especificado.
{:shortdesc}

Requisitos:
- Sub-redes gerenciadas pelo usuário podem ser incluídas em VLANs privadas apenas.
- O limite de comprimento de prefixo de sub-rede é /24 para /30. Por exemplo, `169.xx.xxx.xxx/24` especifica 253 endereços IP privados utilizáveis, enquanto `169.xx.xxx.xxx/30` especifica 1 endereço IP privado utilizável.
- O primeiro endereço IP na sub-rede deve ser usado como o gateway para a sub-rede.

Antes de iniciar:
- Configure o roteamento de tráfego de rede dentro e fora da sub-rede externa.
- Confirme se você tem conectividade VPN entre o gateway de rede do data center no local e o Virtual Router Appliance de rede privada ou o serviço VPN do strongSwan que é executado em seu cluster. Para obter mais informações, veja [Configurando a conectividade VPN](cs_vpn.html).

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

5. Inclua um [serviço de balanceador de carga privado](cs_loadbalancer.html) ou ative um [ALB do Ingresso privado](cs_ingress.html#private_ingress) para acessar seu app por meio da rede privada. Para usar um endereço IP privado por meio da sub-rede que você incluiu, deve-se especificar um endereço IP do CIDR da sub-rede. Caso contrário, um endereço IP será escolhido aleatoriamente das sub-redes de infraestrutura do IBM Cloud (SoftLayer) ou sub-redes fornecidas pelo usuário na VLAN privada.

<br />


## Gerenciando o roteamento de sub
{: #subnet-routing}

Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).

Revise os cenários a seguir nos quais o VLAN Spanning também é necessário.

### Ativando o roteamento entre as sub-redes primárias na mesma VLAN
{: #vlan-spanning}

Quando você cria um cluster, uma sub-rede que termina em `/26` é provisionada na VLAN primária privada padrão. Uma sub-rede primária privada pode fornecer IPs para até 62 nós do trabalhador.
{:shortdesc}

Esse limite de 62 nós do trabalhador pode ser excedido por um cluster grande ou por vários clusters menores em uma única região que estão na mesma VLAN. Quando o limite de 62 nós do trabalhador é atingido, uma segunda sub-rede primária privada na mesma VLAN é pedida.

Para assegurar que os trabalhadores nessas sub-redes primárias na mesma VLAN possam se comunicar, deve-se ativar o VLAN Spanning. Para obter instruções, veja [Ativar ou desativar a ampliação de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Para verificar se o VLAN Spanning já está ativado, use o [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

### Gerenciando o roteamento de sub-rede para dispositivos
{: #vra-routing}

Ao criar um cluster, uma sub-rede privada móvel e uma pública móvel são pedidas nas VLANs às quais o cluster está conectado. Essas sub-redes fornecem endereços IP para serviços de rede do Ingresso e do balanceador de carga.

No entanto, se você tiver um dispositivo de roteador existente, como um [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html#about), as sub-redes móveis recém-incluídas daquelas VLANs às quais o cluster está conectado não serão configuradas no roteador. Para usar os serviços de rede do Ingresso ou do balanceador de carga, deve-se assegurar que os dispositivos de rede possam rotear entre diferentes sub-redes na mesma VLAN [ativando o VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Para verificar se o VLAN Spanning já está ativado, use o [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}
