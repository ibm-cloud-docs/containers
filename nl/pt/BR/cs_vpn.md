---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurando a conectividade de VPN
{: #vpn}

Com a conectividade de VPN, é possível conectar apps com segurança em um cluster do Kubernetes no {{site.data.keyword.containerlong}} a uma rede no local. Também é possível conectar apps que são externos ao seu cluster para um app que está em execução dentro de seu cluster.
{:shortdesc}

Para conectar seus nós do trabalhador e apps a um data center no local, é possível configurar uma das opções a seguir.

- **Serviço de VPN IPSec strongSwan**: é possível configurar um [Serviço de VPN IPSec strongSwan ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.strongswan.org/about.html) que conecte de forma segura seu cluster do Kubernetes a uma rede no local. O serviço de VPN do IPSec do strongSwan fornece um canal de comunicação seguro de ponta a ponta sobre a Internet que é baseado no conjunto de protocolos padrão de mercado da Internet Protocol Security (IPSec). Para configurar uma conexão segura entre seu cluster e uma rede no local, [configure e implemente o serviço VPN IPSec do strongSwan](#vpn-setup) diretamente em um pod no cluster.

- **Virtual Router Appliance (VRA) ou Fortigate Security Appliance (FSA)**: você pode escolher configurar um [VRA](/docs/infrastructure/virtual-router-appliance/about.html) ou [FSA](/docs/infrastructure/fortigate-10g/about.html) para configurar um terminal de VPN IPSec. Essa opção é útil quando você tem um cluster maior, deseja acessar múltiplos clusters por meio de uma única VPN ou precisa de uma VPN baseada em rota. Para configurar um VRA, veja [Configurando a conectividade VPN com o VRA](#vyatta).

## Usando o gráfico Helm do serviço de VPN IPSec strongSwan
{: #vpn-setup}

Use um gráfico Helm para configurar e implementar o serviço de VPN IPSec strongSwan dentro de um pod do Kubernetes.
{:shortdesc}

Como o strongSwan está integrado ao cluster, não é necessário um dispositivo de gateway externo. Quando a conectividade de VPN é estabelecida, as rotas são configuradas automaticamente em todos os nós do trabalhador no cluster. Essas rotas permitem a conectividade bidirecional por meio do túnel VPN entre pods em qualquer nó do trabalhador e o sistema remoto. Por exemplo, o diagrama a seguir mostra como um app no {{site.data.keyword.containershort_notm}} pode se comunicar com um servidor local por meio de uma conexão VPN do strongSwan:

<img src="images/cs_vpn_strongswan.png" width="700" alt="Expor um app no {{site.data.keyword.containershort_notm}} usando um balanceador de carga" style="width:700px; border-style: none"/>

1. Um app em seu cluster, `myapp`, recebe uma solicitação de um serviço Ingress ou LoadBalancer e precisa conectar-se com segurança a dados em sua rede local.

2. A solicitação para o data center local é encaminhada para o pod VPN do strongSwan do IPSec. O endereço IP de destino é usado para determinar quais pacotes de rede enviar para o pod VPN do strongSwan do IPSec.

3. A solicitação é criptografada e enviada pelo túnel VPN para o data center no local.

4. A solicitação recebida passa pelo firewall no local e é entregue ao terminal de túnel VPN (roteador) no qual ela é decriptografada.

5. O terminal de túnel VPN (roteador) encaminha a solicitação para o servidor ou mainframe no local, dependendo do endereço IP de destino que foi especificado na etapa 2. Os dados necessários são enviados de volta na conexão VPN para `myapp` por meio do mesmo processo.

## Considerações sobre o serviço de VPN strongSwan
{: strongswan_limitations}

Antes de usar o gráfico Helm do strongSwan, revise as considerações e limitações a seguir.

* O gráfico Helm do strongSwan requer que a passagem NAT seja ativada pelo terminal de VPN remoto. A passagem NAT requer a porta UDP 4500, além da porta UDP IPSec padrão de 500. Ambas as portas UDP precisam ser permitidas por meio de qualquer firewall que esteja configurado.
* O gráfico Helm do strongSwan não suporta VPNs IPSec baseadas em rota.
* O gráfico Helm do strongSwan suporta VPNs IPSec que usam chaves pré-compartilhadas, mas não suportam VPNs IPSec que requerem certificados.
* O gráfico Helm do strongSwan não permite que múltiplos clusters e outros recursos IaaS compartilhem uma única conexão VPN.
* O gráfico Helm do strongSwan é executado como um pod do Kubernetes dentro do cluster. O desempenho da VPN é afetado pelo uso de memória e de rede do Kubernetes e outros pods que estiverem em execução no cluster. Se você tiver um ambiente de desempenho crítico, considere usar uma solução de VPN que seja executada fora do cluster no hardware dedicado.
* O gráfico Helm do strongSwan executa um único pod de VPN como o terminal de túnel IPSec. Se o pod falhar, o cluster reiniciará o pod. No entanto, você pode experienciar um curto tempo de inatividade enquanto o novo pod é iniciado e a conexão VPN é restabelecida. Se você precisar de uma recuperação de erro mais rápida ou de uma solução de alta disponibilidade mais elaborada, considere usar uma solução de VPN que seja executada fora do cluster no hardware dedicado.
* O gráfico Helm do strongSwan não fornece métricas ou monitoramento do tráfego de rede que flui por meio da conexão VPN. Para obter uma lista de ferramentas de monitoramento suportadas, consulte [Serviços de criação de log e monitoramento](cs_integrations.html#health_services).

## Configurando o gráfico Helm do strongSwan
{: #vpn_configure}

Antes de iniciar:
* [Instale um gateway de VPN IPSec em seu data center no local](/docs/infrastructure/iaas-vpn/set-up-ipsec-vpn.html#setting-up-an-ipsec-connection).
* [ Criar um cluster padrão ](cs_clusters.html#clusters_cli).
* [Destine a CLI do Kubernetes para o cluster](cs_cli_install.html#cs_cli_configure).

### Etapa 1: obter o gráfico Helm do strongSwan
{: #strongswan_1}

1. [Instale o Helm para seu cluster e inclua o repositório do {{site.data.keyword.Bluemix_notm}} em sua instância do Helm](cs_integrations.html#helm).

2. Salve as definições de configuração padrão para o gráfico Helm do strongSwan em um arquivo YAML local.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Abra o arquivo  ` config.yaml ` .

### Etapa 2: Configurar definições básicas de IPSec
{: #strongswan_2}

Para controlar o estabelecimento da conexão VPN, modifique as configurações básicas do IPSec a seguir.

Para obter mais informações sobre cada configuração, leia a documentação fornecida no arquivo `config.yaml` para o gráfico Helm.
{: tip}

1. Se o terminal do túnel VPN no local não suportar `ikev2` como um protocolo para inicializar a conexão, mude o valor de `ipsec.keyexchange` para `ikev1` ou `ike`.
2. Configure `ipsec.esp` para uma lista de algoritmos de criptografia e de autenticação ESP que seu terminal de túnel VPN no local usa para a conexão.
    * Se `ipsec.keyexchange` estiver configurado como `ikev1`, esta configuração deverá ser especificada.
    * Se `ipsec.keyexchange` estiver configurado como `ikev2`, esta configuração será opcional.
    * Se você deixar essa configuração em branco, os algoritmos padrão do strongSwan `aes128-sha1,3des-sha1` serão usados para a conexão.
3. Configure `ipsec.ike` para uma lista de algoritmos de criptografia e autenticação IKE/ISAKMP SA que seu terminal de túnel VPN no local usa para a conexão. Os algoritmos devem ser específicos no formato `encryption-integrity[-prf]-dhgroup`.
    * Se `ipsec.keyexchange` estiver configurado como `ikev1`, esta configuração deverá ser especificada.
    * Se `ipsec.keyexchange` estiver configurado como `ikev2`, esta configuração será opcional.
    * Se você deixar essa configuração em branco, os algoritmos padrão do strongSwan `aes128-sha1-modp2048,3des-sha1-modp1536` serão usados para a conexão.
4. Mude o valor de `local.id` para qualquer sequência que você deseja usar para identificar o lado do cluster do Kubernetes local que seu terminal de túnel VPN usa. O padrão é  ` ibm-cloud `. Algumas implementações de VPN requerem que você use o endereço IP público para o endpoint local.
5. Mude o valor de `remote.id` para qualquer sequência que você deseja usar para identificar o lado no local remoto que seu terminal de túnel VPN usa. O padrão é  ` on-prem `. Algumas implementações de VPN requerem que você use o endereço IP público para o terminal remoto.
6. Mude o valor de `preshared.secret` para o segredo pré-compartilhado que seu gateway do terminal de túnel VPN no local usa para a conexão. Esse valor é armazenado em  ` ipsec.secrets `.
7. Opcional: configure `remote.privateIPtoPing` para qualquer endereço IP privado na sub-rede remota para executar ping como parte do teste de validação de conectividade do Helm.

### Etapa 3: selecionar a conexão VPN de entrada ou de saída
{: #strongswan_3}

Ao configurar uma conexão VPN strongSwan, você escolhe se a conexão VPN é de entrada para o cluster ou de saída do cluster.
{: shortdesc}

<dl>
<dt>Entrada</dt>
<dd>O terminal de VPN no local da rede remota inicia a conexão VPN e o cluster atende a conexão.</dd>
<dt>Saída</dt>
<dd>O cluster inicia a conexão VPN e o terminal de VPN no local da rede remota atende a conexão.</dd>
</dl>

Para estabelecer uma conexão VPN de entrada, modifique as configurações a seguir:
1. Verifique se `ipsec.auto` está configurado como `add`.
2. Opcional: configure `loadBalancerIP` para um endereço IP público móvel para o serviço de VPN strongSwan. Especificar um endereço IP é útil quando você precisa de um endereço IP estável, como quando se deve designar quais endereços IP são permitidos por meio de um firewall no local. O cluster deve ter pelo menos um endereço IP público disponível do balanceador de carga. [É possível verificar seus endereços IP públicos disponíveis](cs_subnets.html#review_ip) ou [liberar um endereço IP usado](cs_subnets.html#free).<br>**Nota**:
    * Se você deixar essa configuração em branco, um dos endereços IP públicos móveis disponíveis será usado.
    * Deve-se também configurar o endereço IP público que você seleciona ou o endereço IP público que está designado ao terminal de VPN do cluster no terminal de VPN no local.

Para estabelecer uma conexão VPN de saída, modifique as configurações a seguir:
1. Altere  ` ipsec.auto `  para  ` start `.
2. Configure `remote.gateway` para o endereço IP público para o terminal de VPN no local na rede remota.
3. Escolha uma das opções a seguir para o endereço IP para o terminal de VPN do cluster:
    * **Endereço IP público do gateway privado do cluster**: se seus nós do trabalhador estiverem conectados a somente uma VLAN privada, a solicitação de VPN de saída será roteada por meio do gateway privado para atingir a Internet. O endereço IP público do gateway privado é usado para a conexão VPN.
    * **Endereço IP público do nó do trabalhador no qual o pod strongSwan está em execução**: se o nó do trabalhador no qual o pod strongSwan está em execução for conectado a uma VLAN pública, o endereço IP público do nó do trabalhador será usado para a conexão VPN.
        <br>**Nota**:
        * Se o pod strongSwan for excluído e reprogramado em um nó do trabalhador diferente no cluster, o endereço IP público da VPN mudará. O terminal de VPN no local da rede remota deve permitir que a conexão VPN seja estabelecida por meio do endereço IP público de qualquer um dos nós do trabalhador do cluster.
        * Se o terminal de VPN remoto não puder manipular conexões VPN de múltiplos endereços IP públicos, limite os nós em que o pod de VPN strongSwan é implementado. Configure `nodeSelector` para os endereços IP de nós do trabalhador específicos ou um rótulo do nó do trabalhador. Por exemplo, o valor `kubernetes.io/hostname: 10.232.xx.xx` permite que o pod de VPN seja implementado somente para esse nó do trabalhador. O valor `strongswan: vpn` restringe o pod de VPN à execução em quaisquer nós do trabalhador com esse rótulo. É possível usar qualquer rótulo de nó do trabalhador. Para permitir que diferentes nós do trabalhador sejam usados com diferentes implementações do gráfico Helm, use `strongswan: <release_name>`. Para alta disponibilidade, selecione pelo menos dois nós do trabalhador.
    * **Endereço IP público do serviço strongSwan**: para estabelecer uma conexão usando o endereço IP do serviço de VPN strongSwan, configure `connectUsingLoadBalancerIP` como `true`. O endereço IP do serviço strongSwan é um endereço IP público móvel que pode ser especificado na configuração `loadBalancerIP` ou um endereço IP público móvel disponível que é designado automaticamente ao serviço.
        <br>**Nota**:
        * Se você escolher selecionar um endereço IP usando a configuração `loadBalancerIP`, o cluster deverá ter pelo menos um endereço IP público disponível do Load Balancer. [É possível verificar seus endereços IP públicos disponíveis](cs_subnets.html#review_ip) ou [liberar um endereço IP usado](cs_subnets.html#free).
        * Todos os nós do trabalhador do cluster devem estar na mesma VLAN pública. Caso contrário, deve-se usar a configuração `nodeSelector` para assegurar que o pod de VPN seja implementado em um nó do trabalhador na mesma VLAN pública que a do `loadBalancerIP`.
        * Se `connectUsingLoadBalancerIP` está configurado como `true` e `ipsec.keyexchange` está configurado como `ikev1`, deve-se configurar `enableServiceSourceIP` como `true`.

### Etapa 4: acessar recursos de cluster por meio da conexão VPN
{: #strongswan_4}

Determine quais recursos do cluster devem ser acessíveis pela rede remota por meio da conexão VPN.
{: shortdesc}

1. Inclua os CIDRs de uma ou mais sub-redes do cluster para a configuração `local.subnet`. Deve-se configurar os CIDRs de sub-rede local no terminal de VPN no local. Essa lista pode incluir as seguintes sub-redes:  
    * O CIDR da sub-rede do pod do Kubernetes:  ` 172.30.0.0/ 16 `. A comunicação bidirecional é ativada entre todos os pods do cluster e qualquer um dos hosts nas sub-redes de rede remota que você listar na configuração `remote.subnet`. Caso seja necessário evitar o acesso de qualquer host `remote.subnet` a pods do cluster por razões de segurança, não inclua a sub-rede de pod do Kubernetes na configuração `local.subnet`.
    * O CIDR de sub-rede de serviço do Kubernetes:  ` 172.21.0.0/ 16 `. Os endereços IP de serviço fornecem uma maneira de expor múltiplos pods de app que são implementados em vários nós do trabalhador por trás de um único IP.
    * Se seus apps forem expostos por um serviço NodePort na rede privada ou um ALB do Ingresso privado, inclua o CIDR de sub-rede privada do nó do trabalhador. Recupere os três primeiros octetos do endereço IP privado de seu trabalhador executando `ibmcloud ks worker <cluster_name>`. Por exemplo, se for `10.176.48.xx`, anote `10.176.48`. Em seguida, obtenha o CIDR da sub-rede privada do trabalhador executando o comando a seguir, substituindo `<xxx.yyy.zz>` pelo octeto que você recuperou anteriormente: `ibmcloud sl subnet list | grep <xxx.yyy.zzz>`.<br>**Nota**: se um nó do trabalhador for incluído em uma nova sub-rede privada, deve-se incluir o CIDR da nova sub-rede privada na configuração `local.subnet` e no terminal de VPN no local. Em seguida, a conexão VPN deve ser reiniciada.
    * Se você tiver apps que são expostos pelos serviços LoadBalancer na rede privada, inclua os CIDRs de sub-rede privada gerenciada pelo usuário do cluster. Para localizar esses valores, execute `ibmcloud ks cluster-get <cluster_name> --showResources`. Na seção **VLANS**, procure os CIDRs que possuem um valor **público** de `false`.<br>
    **Nota**: se `ipsec.keyexchange` estiver configurado como `ikev1`, será possível especificar apenas uma sub-rede. No entanto, é possível usar a configuração `localSubnetNAT` para combinar múltiplas sub-redes de cluster em uma única sub-rede.

2. Opcional: remapeie as sub-redes de cluster usando a configuração `localSubnetNAT`. A Conversão de endereço de rede (NAT) para sub-redes fornece uma solução alternativa para conflitos de sub-rede entre a rede de cluster e a rede remota no local. É possível usar o NAT para remapear as sub-redes de IP local privado, a sub-rede do pod (172.30.0.0/16) ou a sub-rede do serviço de pod (172.21.0.0/16) para uma sub-rede privada diferente. O túnel VPN vê as sub-redes de IP remapeadas em vez das sub-redes originais. O remapeamento acontece antes de os pacotes serem enviados pelo túnel VPN, bem como após os pacotes chegarem do túnel VPN. É possível expor as sub-redes remapeada e não remapeada ao mesmo tempo pela VPN. Para ativar o NAT, é possível incluir uma sub-rede inteira ou endereços IP individuais.
    * Se você incluir uma sub-rede inteira no formato `10.171.42.0/24=10.10.10.0/24`, o remapeamento será 1 para 1: todos os endereços IP na sub-rede de rede interna são mapeados para sub-rede de rede externa e vice-versa.
    * Se você incluir endereços IP individuais no formato `10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32`, somente os endereços IP internos serão mapeados para os endereços IP externos especificados.

3. Opcional para gráficos Helm do strongSwan da versão 2.2.0 e mais recente: oculte todos os endereços IP do cluster atrás de um único endereço IP configurando `enableSingleSourceIP` como `true`. Essa opção fornece uma das configurações mais seguras para a conexão VPN porque nenhuma conexão da rede remota de volta para o cluster é permitida.
    <br>**Nota**:
    * Essa configuração requer que todo fluxo de dados sobre a conexão VPN seja de saída, independentemente se a conexão VPN é estabelecida por meio do cluster ou da rede remota.
    * O `local.subnet` deve ser configurado para somente uma sub-rede /32.

4. Opcional para gráficos Helm do strongSwan da versão 2.2.0 e mais recente: ative o serviço strongSwan para rotear as solicitações recebidas da rede remota para um serviço que exista fora do cluster usando a configuração `localNonClusterSubnet`.
    <br>**Nota**:
    * O serviço sem cluster deve existir na mesma rede privada ou em uma rede privada que seja atingível pelos nós do trabalhador.
    * O nó do trabalhador sem cluster não pode iniciar o tráfego para a rede remota por meio da conexão VPN, mas o nó sem cluster pode ser o destino de solicitações recebidas da rede remota.
    * Deve-se listar os CIDRs das sub-redes sem cluster na configuração `local.subnet`.

### Etapa 5: acessar recursos de rede remota por meio da conexão VPN
{: #strongswan_5}

Determine quais recursos de rede remota devem ser acessíveis pelo cluster por meio da conexão VPN.
{: shortdesc}

1. Inclua os CIDRs de uma ou mais sub-redes privadas no local na configuração `remote.subnet`.
    <br>**Nota**: se `ipsec.keyexchange` estiver configurado como `ikev1`, será possível especificar apenas uma sub-rede.
2. Opcional para gráficos Helm do strongSwan Helm da versão 2.2.0 e mais recente: remapeie sub-redes de rede remota usando a configuração `remoteSubnetNAT`. A Conversão de endereço de rede (NAT) para sub-redes fornece uma solução alternativa para conflitos de sub-rede entre a rede de cluster e a rede remota no local. É possível usar NAT para remapear as sub-redes de IP da rede remota para uma sub-rede privada diferente. O túnel VPN vê as sub-redes de IP remapeadas em vez das sub-redes originais. O remapeamento acontece antes de os pacotes serem enviados pelo túnel VPN, bem como após os pacotes chegarem do túnel VPN. É possível expor as sub-redes remapeada e não remapeada ao mesmo tempo pela VPN.

### Etapa 6: implementar o gráfico Helm
{: #strongswan_6}

1. Se você precisar definir configurações mais avançadas, siga a documentação fornecida para cada configuração no gráfico Helm.

2. **Importante**: se não for necessária uma configuração no gráfico Helm, comente essa propriedade colocando um `#` na frente dela.

3. Salve o arquivo `config.yaml` atualizado.

4. Instale o gráfico do Helm em seu cluster com o arquivo `config.yaml` atualizado. As propriedades atualizadas são armazenadas em um configmap para seu gráfico.

    **Nota**: se você tem múltiplas implementações de VPN em um único cluster, é possível evitar conflitos de nomenclatura e diferenciar entre suas implementações escolhendo nomes de liberação mais descritivos que `vpn`. Para evitar o truncamento do nome de liberação, limite o nome de liberação para 35 caracteres ou menos.

    ```
    -f config.yaml helm install -- name=vpn ibm/strongswan
    ```
    {: pre}

5. Verifique o status de implementação do gráfico. Quando o gráfico estiver pronto, o campo **STATUS** perto da parte superior da saída terá um valor de `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

6. Quando o gráfico for implementado, verifique se as configurações atualizadas no arquivo `config.yaml` foram usadas.

    ```
    helm get values vpn
    ```
    {: pre}

## Testando e verificando a conectividade VPN do strongSwan
{: #vpn_test}

Depois de implementar seu gráfico Helm, teste a conectividade VPN.
{:shortdesc}

1. Se a VPN no gateway local não estiver ativo, inicie a VPN.

2. Configure a variável de ambiente `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

3. Verifique o status da VPN. Um status de `ESTABLISHED` significa que a conexão VPN foi bem-sucedida.

    ```
    Kubectl exec $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    Saída de exemplo:

    ```
    Security Associations (1 up, 0 connecting):
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.xxx.xxx[ibm-cloud]...192.xxx.xxx.xxx[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.xxx/26
    ```
    {: screen}

    **Nota**:

    <ul>
    <li>Quando você tenta estabelecer a conectividade VPN com o gráfico Helm do strongSwan, é provável que o status da VPN não seja `ESTABLISHED` na primeira vez. Você pode precisar verificar as configurações do terminal de VPN e mudar o arquivo de configuração várias vezes antes que a conexão seja bem-sucedida: <ol><li>Execute `helm delete --purge <release_name>`</li><li>Corrija os valores incorretos no arquivo de configuração.</li><li>Execute `helm install -f config.yaml -- name=<release_name> ibm/strongswan`</li></ol>Também é possível executar mais verificações na próxima etapa.</li>
    <li>Se o pod de VPN está em um estado `ERROR` ou continua travando e reiniciando, isso pode ser devido à validação do parâmetro das configurações do `ipsec.conf` no configmap do gráfico.<ol><li>Verifique quaisquer erros de validação nos logs do pod do strongSwan executando `kubectl logs -n $STRONGSWAN_POD`.</li><li>Se erros de validação existirem, execute `helm delete --purge <release_name>`<li>Corrija os valores incorretos no arquivo de configuração.</li><li>Execute `helm install -f config.yaml -- name=<release_name> ibm/strongswan`</li></ol>Se o seu cluster tem um alto número de nós do trabalhador, também é possível usar `helm upgrade` para aplicar mais rapidamente suas mudanças em vez de executar `helm delete` e `helm install`.</li>
    </ul>

4. É possível testar ainda mais a conectividade VPN executando os cinco testes do Helm que são incluídos na definição de gráfico do strongSwan.

    ```
    helm test vpn
    ```
    {: pre}

    * Se todos os testes passarem, sua conexão VPN do strongSwan foi configurada com êxito.

    * Se algum dos testes falhar, continue com a próxima etapa.

5. Visualize a saída de um teste com falha consultando os logs do pod de teste.

    ```
    kubectl logs <test_program>
    ```
    {: pre}

    **Nota**: alguns dos testes têm requisitos que são configurações opcionais na configuração de VPN. Se alguns dos testes falharem, as falhas poderão ser aceitáveis, dependendo de se você especificou essas configurações opcionais. Consulte a tabela a seguir para obter informações sobre cada teste e por que ele pode falhar.

    {: #vpn_tests_table}
    <table>
    <caption>Entendendo os testes de conectividade VPN do Helm</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Entendendo os testes de conectividade VPN do Helm</th>
    </thead>
    <tbody>
    <tr>
    <td><code>vpn-strongswan-check-config</code></td>
    <td>Valida a sintaxe do arquivo <code>ipsec.conf</code> que é gerado por meio do arquivo <code>config.yaml</code>. Esse teste pode falhar devido a valores incorretos no arquivo <code>config.yaml</code>.</td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-check-state</code></td>
    <td>Verifica se a conexão VPN tem um status de <code>ESTABLISHED</code>. Esse teste poderá falhar pelos motivos a seguir:<ul><li>Diferenças entre os valores no arquivo <code>config.yaml</code> e as configurações do terminal de VPN no local.</li><li>Se o cluster está em modo de "atendimento" (<code>ipsec.auto</code> está configurado para <code>add</code>), a conexão não é estabelecida no lado no local.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td>Efetua ping do endereço IP público <code>remote.gateway</code> que você configurou no arquivo <code>config.yaml</code>. Esse teste poderá falhar pelos motivos a seguir:<ul><li>Você não especificou um endereço IP do gateway de VPN no local. Se <code>ipsec.auto</code> está configurado para <code>start</code>, o endereço IP <code>remote.gateway</code> é necessário.</li><li>A conexão VPN não tem o status <code>ESTABLISHED</code>. Veja <code>vpn-strongswan-check-state</code> para obter mais informações.</li><li>A conectividade VPN é <code>ESTABLISHED</code>, mas os pacotes do ICMP estão sendo bloqueados por um firewall.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-1</code></td>
    <td>Efetua ping do endereço IP privado <code>remote.privateIPtoPing</code> do gateway de VPN no local por meio do pod de VPN no cluster. Esse teste poderá falhar pelos motivos a seguir:<ul><li>Você não especificou um endereço IP <code>remote.privateIPtoPing</code>. Se você intencionalmente não tiver especificado um endereço IP, essa falha será aceitável.</li><li>Você não especificou o CIDR de sub-rede de pod do cluster, <code>172.30.0.0/16</code>, na lista <code>local.subnet</code>.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-2</code></td>
    <td>Efetua ping do endereço IP privado <code>remote.privateIPtoPing</code> do gateway de VPN no local por meio do nó do trabalhador no cluster. Esse teste poderá falhar pelos motivos a seguir:<ul><li>Você não especificou um endereço IP <code>remote.privateIPtoPing</code>. Se você intencionalmente não tiver especificado um endereço IP, essa falha será aceitável.</li><li>Você não especificou o CIDR de sub-rede privada do nó do trabalhador na lista <code>local.subnet</code>.</li></ul></td>
    </tr>
    </tbody></table>

6. Exclua o gráfico Helm atual.

    ```
    helm delete --purge vpn
    ```
    {: pre}

7. Abra o arquivo `config.yaml` e corrija os valores incorretos.

8. Salve o arquivo `config.yaml` atualizado.

9. Instale o gráfico do Helm em seu cluster com o arquivo `config.yaml` atualizado. As propriedades atualizadas são armazenadas em um configmap para seu gráfico.

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

10. Verifique o status de implementação do gráfico. Quando o gráfico estiver pronto, o campo **STATUS** perto da parte superior da saída terá um valor de `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

11. Quando o gráfico for implementado, verifique se as configurações atualizadas no arquivo `config.yaml` foram usadas.

    ```
    helm get values vpn
    ```
    {: pre}

12. Limpe os pods de teste atuais.

    ```
    Kubectl get pods -a -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -l app=strongswan-test
    ```
    {: pre}

13. Execute os testes novamente.

    ```
    helm test vpn
    ```
    {: pre}

<br />


## Fazendo upgrade do gráfico Helm do strongSwan
{: #vpn_upgrade}

Certifique-se de que o gráfico Helm do strongSwan esteja atualizado fazendo upgrade dele.
{:shortdesc}

Para fazer upgrade de seu gráfico Helm do strongSwan para a versão mais recente:

  ```
  Helm upgrade -f config.yaml < release_name> ibm/strongswan
  ```
  {: pre}

**Importante**: o gráfico Helm do strongSwan 2.0.0 não funciona com o Calico v3 ou Kubernetes 1.10. Antes de [atualizar seu cluster para 1.10](cs_versions.html#cs_v110), atualize o strongSwan para o gráfico Helm 2.2.0, que é compatível com versões anteriores com Calico 2.6 e Kubernetes 1.8 e 1.9.

Atualizando seu cluster para Kubernetes 1.10? Certifique-se de excluir primeiro o gráfico Helm do strongSwan. Em seguida, após a atualização, reinstale-a.
{:tip}

### Fazendo upgrade da versão 1.0.0
{: #vpn_upgrade_1.0.0}

Devido a algumas das configurações que são usadas no gráfico Helm da versão 1.0.0, não é possível usar `helm upgrade` para atualizar da 1.0.0 para a versão mais recente.
{:shortdesc}

Para fazer upgrade da versão 1.0.0, deve-se excluir o gráfico 1.0.0 e instalar a versão mais recente:

1. Exclua o gráfico Helm da 1.0.0.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Salve as definições de configuração padrão para a versão mais recente do gráfico Helm do strongSwan em um arquivo YAML local.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Atualize o arquivo de configuração e salve o arquivo com suas mudanças.

4. Instale o gráfico do Helm em seu cluster com o arquivo `config.yaml` atualizado.

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

Além disso, algumas configurações de tempo limite do `ipsec.conf` que foram codificadas permanentemente na 1.0.0 são expostas como propriedades configuráveis em versões mais recentes. Os nomes e os padrões de algumas dessas configurações de tempo limite do `ipsec.conf` configuráveis também foram mudados para serem mais consistentes com os padrões do strongSwan. Se você está fazendo upgrade de seu gráfico Helm da 1.0.0 e deseja reter os padrões da versão 1.0.0 para as configurações de tempo limite, inclua as novas configurações em seu arquivo de configuração do gráfico com os valores padrão antigos.



  <table>
  <caption>As diferenças de configurações do ipsec.conf entre a versão 1.0.0 e a versão mais recente</caption>
  <thead>
  <th>Nome da configuração da 1.0.0</th>
  <th>Padrão da 1.0.0</th>
  <th>Nome da configuração de versão mais recente</th>
  <th>Padrão de versão mais recente</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ikelifetime</code></td>
  <td>60m</td>
  <td><code>ikelifetime</code></td>
  <td>3h</td>
  </tr>
  <tr>
  <td><code>keylife</code></td>
  <td>20m</td>
  <td><code>lifetime</code></td>
  <td>1h</td>
  </tr>
  <tr>
  <td><code>rekeymargin</code></td>
  <td>3m</td>
  <td><code>margintime</code></td>
  <td>9m</td>
  </tr>
  </tbody></table>


## Desativando o serviço de VPN IPSec strongSwan
{: vpn_disable}

É possível desativar a conexão VPN excluindo o gráfico Helm.
{:shortdesc}

  ```
  helm delete --purge <release_name>
  ```
  {: pre}

<br />


## Usando um Virtual Router Appliance
{: #vyatta}

O [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) fornece o sistema operacional Vyatta 5600 mais recente para servidores bare metal x86. É possível usar um VRA como um gateway de VPN para se conectar com segurança a uma rede no local.
{:shortdesc}

Todo o tráfego de rede pública e privada que entra ou sai das VLANs do cluster é roteado por meio de um VRA. É possível usar o VRA como um terminal de VPN para criar um túnel IPSec criptografado entre servidores na infraestrutura do IBM Cloud (SoftLayer) e recursos no local. Por exemplo, o diagrama a seguir mostra como um app em um nó do trabalhador somente privado no {{site.data.keyword.containershort_notm}} pode se comunicar com um servidor no local por meio de uma conexão VPN do VRA:

<img src="images/cs_vpn_vyatta.png" width="725" alt="Expor um app no {{site.data.keyword.containershort_notm}} usando um balanceador de carga" style="width:725px; border-style: none"/>

1. Um app em seu cluster, `myapp2`, recebe uma solicitação de um serviço Ingress ou LoadBalancer e precisa conectar-se com segurança a dados na rede local.

2. Como o `myapp2` está em um nó do trabalhador que está somente em uma VLAN privada, o VRA age como uma conexão segura entre os nós do trabalhador e a rede no local. O VRA usa o endereço IP de destino para determinar quais pacotes de rede enviar para a rede no local.

3. A solicitação é criptografada e enviada pelo túnel VPN para o data center no local.

4. A solicitação recebida passa pelo firewall no local e é entregue ao terminal de túnel VPN (roteador) no qual ela é decriptografada.

5. O terminal de túnel VPN (roteador) encaminha a solicitação para o servidor ou mainframe no local, dependendo do endereço IP de destino que foi especificado na etapa 2. Os dados necessários são enviados de volta na conexão VPN para `myapp2` por meio do mesmo processo.

Para configurar um Virtual Router Appliance:

1. [Pedir um VRA](/docs/infrastructure/virtual-router-appliance/getting-started.html).

2. [Configure a VLAN privada no VRA](/docs/infrastructure/virtual-router-appliance/manage-vlans.html).

3. Para ativar uma conexão VPN usando o VRA, [configure VRRP no VRA](/docs/infrastructure/virtual-router-appliance/vrrp.html#high-availability-vpn-with-vrrp).

**Nota**: se você tiver um dispositivo roteador existente e, em seguida, incluir um cluster, as novas sub-redes móveis que são ordenadas para o cluster não serão configuradas no dispositivo do roteador. Para usar os serviços de rede, deve-se ativar o roteamento entre as sub-redes na mesma VLAN [ativando o VLAN Spanning](cs_subnets.html#subnet-routing).
