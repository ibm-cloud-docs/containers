---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Expondo apps com o Ingress&6
{: #ingress}

Exponha múltiplos apps em seu cluster do Kubernetes criando recursos de Ingresso que são gerenciados pelo balanceador de carga de aplicativo fornecido pela IBM no {{site.data.keyword.containerlong}}.
{:shortdesc}

## Componentes e Arquitetura do Ingresso
{: #planning}

Ingress é um serviço do Kubernetes que equilibra cargas de trabalho do tráfego de rede em seu cluster encaminhando solicitações públicas ou privadas para seus apps. É possível usar o Ingress para expor múltiplos serviços de app ao público ou a uma rede privada usando uma rota público ou privada exclusiva.
{:shortdesc}

### O que vem com o Ingresso?
{: #components}

O Ingresso consiste em três componentes:
<dl>
<dt>Recurso Ingresso</dt>
<dd>Para expor um app usando o Ingresso, deve-se criar um serviço do Kubernetes para seu app e registrar esse serviço com o Ingresso ao definir um recurso Ingresso. O Ingresso é um recurso do Kubernetes que define as regras sobre como rotear as solicitações recebidas para apps. O recurso Ingresso também especifica o caminho para seus serviços de app, que são anexados à rota pública para formar uma URL de app exclusiva, como `mycluster.us-south.containers.appdomain.cloud/myapp1`. <br></br>**Nota**: desde 24 de maio de 2018, o formato de subdomínio de Ingresso mudou para os novos clusters. O nome da região ou zona incluído no novo formato de subdomínio é gerado com base na zona na qual o cluster foi criado. Se você tiver dependências de pipeline em nomes de domínio de app consistentes, será possível usar seu próprio domínio customizado em vez do subdomínio do Ingresso fornecido pela IBM.<ul><li>Todos os clusters criados após 24 de maio de 2018 são designados a um subdomínio no novo formato, <code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code>.</li><li>Os clusters de zona única criados antes de 24 de maio de 2018 continuam a usar o subdomínio designado no formato antigo, <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code>.</li><li>Se você mudar um cluster de zona única criado antes de 24 de maio de 2018 para múltiplas zonas [incluindo uma zona no cluster](cs_clusters.html#add_zone) pela primeira vez, o cluster continuará usando o subdomínio designado no formato antigo,
<code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code> e também será designado a um subdomínio no novo formato, <code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code>. O subdomínio pode ser usado.</li></ul></br>**Clusters de múltiplas zonas**: o recurso Ingresso é global, e é necessário somente um por namespace para um cluster de múltiplas zonas.</dd>
<dt>Balanceador de carga de aplicativo (ALB)</dt>
<dd>O balanceador de carga do aplicativo (ALB) é um balanceador de carga externo que atende as solicitações de serviço HTTP, HTTPS, TCP ou UDP recebidas. O ALB então encaminha as solicitações para o pod de app apropriado de acordo com as regras definidas no recurso Ingresso. Quando você cria um cluster padrão, o {{site.data.keyword.containerlong_notm}} cria automaticamente um ALB altamente disponível para seu cluster e designa uma rota pública exclusiva a ele. A rota pública está vinculada a um endereço IP público móvel que é provisionado em sua conta de infraestrutura do IBM Cloud (SoftLayer) durante a criação do cluster. Um ALB privado padrão também é criado automaticamente, mas não é ativado automaticamente.<br></br>**Clusters de múltiplas zonas**: quando você inclui uma zona em seu cluster, uma sub-rede pública móvel é incluída e um novo ALB público é criado e ativado automaticamente na sub-rede nessa zona. Todos os ALBs públicos padrão em seu cluster compartilham uma rota pública, mas têm endereços IP diferentes. Um ALB privado padrão também é criado automaticamente em cada zona, mas não é ativado automaticamente.</dd>
<dt>Balanceador de Carga Multizona (MZLB)</dt>
<dd><p>**Clusters de múltiplas zonas**: sempre que você cria um cluster de múltiplas zonas ou [inclui uma zona em um cluster de zona única](cs_clusters.html#add_zone), um multizone load balancer (MZLB) do Cloudflare é criado e implementado automaticamente para que exista 1 MZLB para cada região. O MZLB coloca os endereços IP de seus ALBs atrás do mesmo nome do host e ativa as verificações de funcionamento nesses endereços IP para determinar se elas estão disponíveis ou não. Por exemplo, se você tiver nós do trabalhador em 3 zonas na região dos Leste dos EUA, o nome do host `yourcluster.us-east.containers.appdomain.cloud` terá 3 endereços IP do ALB. O funcionamento do MZLB verifica o IP do ALB público em cada zona de uma região e mantém os resultados de consulta de DNS atualizados com base nessas verificações de funcionamento. Por exemplo, se seus ALBs tiverem endereços IP `1.1.1.1`, `2.2.2.2` e `3.3.3.3`, uma consulta de DNS de operação normal de seu subdomínio do Ingress retornará todos os 3 IPs, 1 dos quais o cliente acessa aleatoriamente. Se o ALB com o endereço IP `3.3.3.3` se tornar indisponível por qualquer motivo, como devido à falha na zona, a verificação de funcionamento para essa zona falhará, o MZLB removerá o IP com falha do nome do host e a consulta de DNS retornará somente os IPs do ALB `1.1.1.1` e `2.2.2.2` funcionais. O subdomínio tem um tempo de vida (TTL) de 30 segundos, portanto, após 30 segundos, os novos aplicativos do cliente poderão acessar somente um dos IPs do ALB funcionais e disponíveis.</p><p>Em casos raros, alguns resolvedores de DNS ou aplicativos do cliente podem continuar a usar o IP do ALB não funcional após o TTL de 30 segundos. Esses aplicativos do cliente podem experimentar um tempo de carregamento mais longo até que o aplicativo do cliente abandone o IP `3.3.3.3` e tente se conectar ao `1.1.1.1` ou `2.2.2.2`. Dependendo das configurações do navegador do cliente ou do aplicativo do cliente, o atraso pode variar de alguns segundos a um tempo limite de TCP integral.</p>
<p>A carga do MZLB é balanceada para ALBs públicos que usam somente o subdomínio do Ingresso fornecido pela IBM. Se você usa somente ALBs privados, deve-se verificar manualmente o funcionamento dos ALBs e atualizar os resultados da consulta de DNS. Se você usar ALBs públicos que usam um domínio customizado, será possível incluir os ALBs no balanceamento de carga do MZLB criando um CNAME em sua entrada do DNS para encaminhar as solicitações de seu domínio customizado para o subdomínio do Ingresso fornecido pela IBM para seu cluster.</p>
<p><strong>Nota</strong>: se você usa políticas de rede do Calico pré-DNAT para bloquear todo o tráfego recebido para serviços do Ingress, deve-se também incluir na lista de desbloqueio os <a href="https://www.cloudflare.com/ips/">IPs IPv4 do Cloudflare <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> que são usados para verificar o funcionamento de seus ALBs. Para obter as etapas sobre como criar uma política pré-DNAT do Calico para incluir na lista de desbloqueio esses IPs, consulte a Lição 3 do <a href="cs_tutorials_policies.html#lesson3">Tutorial de política de rede do Calico</a>.</dd>
</dl>

### Como uma solicitação chega ao meu app com o Ingress em um cluster de zona única?
{: #architecture-single}

O diagrama a seguir mostra como o Ingresso direciona a comunicação da Internet para um app em um cluster de zona única:

<img src="images/cs_ingress_singlezone.png" alt="Expor um app em um cluster de zona única usando o Ingress" style="border-style: none"/>

1. Um usuário envia uma solicitação para seu app acessando a URL do app. Essa URL é a URL pública para o seu app exposto anexada ao caminho de recurso de Ingresso, como `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Um serviço do sistema DNS resolve o nome do host na URL para o endereço IP público móvel do balanceador de carga que expõe o ALB em seu cluster.

3. Com base no endereço IP resolvido, o cliente envia a solicitação para o serviço de balanceador de carga que expõe o ALB.

4. O serviço do balanceador de carga roteia a solicitação para o ALB.

5. O ALB verifica se uma regra de roteamento para o caminho `myapp` existe no cluster. Se uma regra de correspondência é localizada, a solicitação é encaminhada de acordo com as regras que você definiu no recurso de Ingresso para o pod no qual o app está implementado. O endereço IP de origem do pacote é mudado para o endereço IP do endereço IP público do nó do trabalhador no qual o pod de app está em execução. Se múltiplas instâncias do app são implementadas no cluster, o ALB balanceia a carga de solicitações entre os pods de app.

### Como uma solicitação chega ao meu app com o Ingress em um cluster de múltiplas zonas?
{: #architecture-multi}

O diagrama a seguir mostra como o Ingresso direciona a comunicação da Internet para um app em um cluster de múltiplas zonas:

<img src="images/cs_ingress_multizone.png" alt="Expor um app em um cluster de múltiplas zonas usando o Ingress" style="border-style: none"/>

1. Um usuário envia uma solicitação para seu app acessando a URL do app. Essa URL é a URL pública para o seu app exposto anexada ao caminho de recurso de Ingresso, como `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Um serviço do sistema DNS, que age como o balanceador de carga global, resolve o nome do host na URL para um endereço IP disponível que foi relatado como funcional pelo MZLB. O MZLB verifica continuamente os endereços IP públicos móveis dos serviços de balanceador de carga que expõem ALBs públicos em cada zona em seu cluster. Os endereços IP são resolvidos em um ciclo round-robin, assegurando que as solicitações tenham igualmente a carga balanceada entre os ALBs funcionais em várias zonas.

3. O cliente envia a solicitação para o endereço IP do serviço de balanceador de carga que expõe um ALB.

4. O serviço do balanceador de carga roteia a solicitação para o ALB.

5. O ALB verifica se uma regra de roteamento para o caminho `myapp` existe no cluster. Se uma regra de correspondência é localizada, a solicitação é encaminhada de acordo com as regras que você definiu no recurso de Ingresso para o pod no qual o app está implementado. O endereço IP de origem do pacote é mudado para o endereço IP do endereço IP público do nó do trabalhador no qual o pod de app está em execução. Se múltiplas instâncias de app são implementadas no cluster, a carga do ALB balanceia as solicitações entre os pods de app em todas as zonas.

<br />


## Pré-requisitos
{: #config_prereqs}

Antes de começar com o Ingresso, revise os pré-requisitos a seguir.
{:shortdesc}

**Pré-requisitos para todas as configurações de Ingresso:**
- O Ingresso está disponível somente para clusters padrão e requer pelo menos dois nós do trabalhador por zona para assegurar alta disponibilidade e que as atualizações periódicas sejam aplicadas.
- Configurar o Ingresso requer uma [política de acesso de Administrador](cs_users.html#access_policies). Verifique sua [política de acesso](cs_users.html#infra_access) atual.

**Pré-requisitos para usar o Ingresso em clusters de múltiplas zonas**:
 - Se você restringir o tráfego de rede para os [ nós do trabalhador de borda](cs_edge.html), pelo menos 2 nós do trabalhador de borda deverão ser ativados em cada zona para alta disponibilidade de pods do Ingress. [Crie um conjunto de trabalhadores de nó de borda](cs_clusters.html#add_pool) que abranja todas as zonas em seu cluster e tenha pelo menos 2 nós do trabalhador por zona.
 - Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).
 - Se uma zona falhar, você poderá ver falhas intermitentes em solicitações para o ALB do Ingresso nessa zona.

<br />


## Planejando a rede para um único ou múltiplos namespaces
{: #multiple_namespaces}

Pelo menos um recurso de Ingresso é necessário por namespace no qual você tem aplicativos que deseja expor.
{:shortdesc}

### Todos os apps estão em um namespace
{: #one-ns}

Se os apps em seu cluster estão no mesmo namespace, pelo menos um recurso de Ingresso é necessário para definir regras de roteamento para os apps expostos lá. Por exemplo, se você tem o `app1` e o `app2` expostos por serviços em um espaço de desenvolvimento, é possível criar um recurso de Ingresso no namespace. O recurso especifica `domain.net` como o host e registra os caminhos em que cada app atende com `domain.net`.

<img src="images/cs_ingress_single_ns.png" width="300" alt="Pelo menos um recurso é necessário por namespace." style="width:300px; border-style: none"/>

### Os apps estão em múltiplos namespaces
{: #multi-ns}

Se os apps em seu cluster estão em namespaces diferentes, deve-se criar pelo menos um recurso por namespace para definir regras para os apps expostos lá. Para registrar múltiplos recursos de Ingresso com o ALB de Ingresso do cluster, deve-se usar um domínio curinga. Quando um domínio curinga como `*.domain.net` for registrado, múltiplos subdomínios serão todos resolvidos para o mesmo host. Em seguida, é possível criar um recurso de Ingresso em cada namespace e especificar um subdomínio diferente em cada recurso de Ingresso.

Por exemplo, considere o seguinte cenário:
* Você tem duas versões do mesmo app, `app1` e `app3`, para propósitos de teste.
* Você implementa os apps em dois namespaces diferentes dentro do mesmo cluster: `app1` no namespace de desenvolvimento e `app3` no namespace temporário.

Para usar o mesmo ALB do cluster para gerenciar o tráfego para esses apps, você cria os serviços e recursos a seguir:
* Um serviço do Kubernetes no namespace de desenvolvimento para expor `app1`.
* Um recurso Ingresso no namespace de desenvolvimento que especifica o host como `dev.domain.net`.
* Um serviço do Kubernetes no namespace temporário para expor `app3`.
* Um recurso Ingresso no namespace de preparação que especifica o host como `stage.domain.net`.
</br>
<img src="images/cs_ingress_multi_ns.png" width="500" alt="Dentro de um namespace, use subdomínios em um ou múltiplos recursos" style="width:500px; border-style: none"/>


Agora, ambas as URLs são resolvidas para o mesmo domínio e são, portanto, ambas atendidas pelo mesmo ALB. No entanto, como o recurso no namespace de preparação é registrado com o subdomínio `stage`, o ALB do Ingresso roteia corretamente as solicitações da URL `stage.domain.net/app3` para somente `app3`.

{: #wildcard_tls}
**Nota**:
* O IBM fornecido pelo subdomínio de Ingresso curinga, `*.<cluster_name>.<region>.containers.appdomain.cloud` é registrado por padrão para seu cluster. O certificado TLS fornecido pela IBM é um certificado curinga e pode ser usado para o subdomínio curinga.
* Se deseja usar um domínio customizado, deve-se registrá-lo como um domínio curinga, como `*.custom_domain.net`. Para usar o TLS, deve-se obter um certificado curinga.

### Vários domínios dentro de um namespace
{: #multi-domains}

Em um namespace individual, é possível usar um domínio para acessar todos os apps no namespace. Se você deseja usar domínios diferentes para os apps dentro de um namespace individual, use um domínio curinga. Quando um domínio curinga como `*.mycluster.us-south.containers.appdomain.cloud` for registrado, múltiplos subdomínios serão todos resolvidos no mesmo host. Em seguida, é possível usar um recurso para especificar múltiplos hosts de subdomínio dentro desse recurso. Como alternativa, é possível criar múltiplos recursos de Ingresso no namespace e especificar um subdomínio diferente em cada recurso de Ingresso.

<img src="images/cs_ingress_single_ns_multi_subs.png" alt="Pelo menos um recurso é necessário por namespace." style="border-style: none"/>

**Nota**:
* O IBM fornecido pelo subdomínio de Ingresso curinga, `*.<cluster_name>.<region>.containers.appdomain.cloud` é registrado por padrão para seu cluster. O certificado TLS do Ingress fornecido pela IBM é um certificado curinga e pode ser usado para o subdomínio curinga.
* Se deseja usar um domínio customizado, deve-se registrá-lo como um domínio curinga, como `*.custom_domain.net`. Para usar o TLS, deve-se obter um certificado curinga.

<br />


## Expondo apps que estão dentro de seu cluster para o público
{: #ingress_expose_public}

Exponha apps que estão dentro de seu cluster para o público usando o ALB de Ingresso público.
{:shortdesc}

Antes de iniciar:

* Revise o Ingresso [pré-requisitos](#config_prereqs).
* [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

### Etapa 1: Implementar apps e criar serviços de app
{: #public_inside_1}

Inicie implementando seus apps e criando serviços do Kubernetes para expô-los.
{: shortdesc}

1.  [Implemente o seu app no cluster](cs_app.html#app_cli). Assegure-se de incluir um rótulo em sua implementação na seção de metadados de seu arquivo de configuração, como `app: code`. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução para que os pods possam ser incluídos no balanceamento de carga do Ingress.

2.   Crie um serviço do Kubernetes para cada app que se deseja expor. O seu app deve ser exposto por um serviço do Kubernetes a ser incluído pelo ALB de cluster no balanceamento de carga do Ingress.
      1.  Abra o seu editor preferencial e crie um arquivo de configuração de serviço que seja denominado, por exemplo, `myappservice.yaml`.
      2.  Defina um serviço para o app que o ALB exporá.

          ```
          apiVersion: v1 kind: Service metadata: name: myappservice spec: selector: <selector_key>: <selector_value> ports:
             - protocol: TCP port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Ícone Ideia"/> Entendendo os componentes do arquivo YAML do serviço ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>seletor</code></td>
          <td>Insira a chave de etiqueta (<em>&lt;selector_key&gt;</em>) e o par de valores (<em>&lt;selector_value&gt;</em>) que você deseja usar para destinar os pods nos quais o seu app é executado. Para direcionar seus pods e incluí-los no balanceamento de carga do serviço, assegure-se de que o <em>&lt;selector_key&gt;</em> e o <em>&lt;selector_value&gt;</em> sejam iguais ao par de chave/valor na seção <code>spec.template.metadata.labels</code> do yaml de sua implementação.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>A porta na qual o serviço atende.</td>
           </tr>
           </tbody></table>
      3.  Salve as suas mudanças.
      4.  Crie o serviço em seu cluster. Se os apps forem implementados em múltiplos namespaces no cluster, assegure-se de que o serviço seja implementado no mesmo namespace que o app que se deseja expor.

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  Repita essas etapas para cada app que desejar expor.


### Etapa 2: Selecionar um domínio de app e uma finalização de TLS
{: #public_inside_2}

Ao configurar o ALB público, você escolhe o domínio pelo qual seus apps são acessíveis e se usa a finalização do TLS.
{: shortdesc}

<dl>
<dt>Domínio</dt>
<dd>É possível usar o domínio fornecido pela IBM, como <code>mycluster-12345.us-south.containers.appdomain.cloud/myapp</code>, para acessar seu app na Internet. Para usar um domínio customizado em vez disso, é possível configurar um registro CNAME para mapear o seu domínio customizado para o domínio fornecido pela IBM ou configurar um registro A com o seu provedor do DNS usando o endereço IP público do ALB.</dd>
<dt>Finalização TLS</dt>
<dd>O ALB faz o balanceamento de carga do tráfego de rede HTTP para os apps no cluster. Para também balancear a carga de conexões HTTPS recebidas, será possível configurar o ALB para decriptografar o tráfego de rede e encaminhar a solicitação decriptografada para os apps expostos no cluster. <ul><li>Se você usar o subdomínio do Ingress fornecido pela IBM, será possível usar o certificado do TLS fornecido pela IBM. Os certificados do TLS fornecidos pela IBM são assinados por LetsEncrypt e são totalmente gerenciados pela IBM. Os certificados expiram a cada 90 dias e são renovados automaticamente 7 dias antes de expirarem.</li><li>Se você usar um domínio customizado, será possível usar o seu próprio certificado do TLS para gerenciar a rescisão do TLS. Se você tiver apps apenas em um namespace, será possível importar ou criar um segredo do TLS para o certificado nesse mesmo namespace. Se você tiver apps em múltiplos namespaces, importe ou crie um segredo do TLS para o certificado no namespace <code>default</code> para que o ALB possa acessar e usar o certificado em cada namespace. <strong>Nota</strong>: os certificados TLS que contêm chaves pré-compartilhadas (TLS-PSK) não são suportados.</li></ul></dd>
</dl>

#### Para usar o domínio de Ingresso fornecido pela IBM:
Obtenha o domínio fornecido pela IBM e, se você desejar usar o TLS, o segredo do TLS fornecido pela IBM para seu cluster. Substitua _&lt;cluster_name_or_ID&gt;_ pelo nome do cluster no qual o app está implementado. **Nota**: para obter informações sobre a certificação do TLS curinga, consulte [esta nota](#wildcard_tls).
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep Ingress
```
{: pre}

Saída de exemplo:

```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}


#### Para usar um domínio customizado:
1.    Crie um domínio customizado. Para registrar seu domínio customizado, trabalhe com o provedor Domain Name Service (DNS) ou com o [DNS do {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns).
      * Se os apps que você deseja que o Ingress exponha estiverem em namespaces diferentes em um cluster, registre o domínio customizado como um domínio curinga, como `*.custom_domain.net`.

2.  Configure seu domínio para rotear o tráfego de rede recebido para o ALB fornecido pela IBM. Escolha entre estas opções:
    -   Defina um alias para seu domínio customizado especificando o domínio fornecido pela IBM como um registro de Nome Canônico (CNAME). Para localizar o domínio do Ingress fornecido pela IBM, execute `ibmcloud ks cluster-get <cluster_name>` e procure o campo **Subdomínio do Ingresso**. O uso de um CNAME é preferencial porque a IBM fornece verificações de funcionamento automáticas no subdomínio IBM e remove os IPs com falha da resposta de DNS.
    -   Mapeie o seu domínio customizado para o endereço IP público móvel do ALB fornecido pela IBM incluindo o endereço IP como um registro. Para localizar o endereço IP público móvel do ALB, execute `ibmcloud ks alb-get <public_alb_ID>`.
3.   Opcional: para usar o TLS, importe ou crie um certificado do TLS e um segredo de chave. Se você usar um domínio curinga, assegure-se de importar ou criar um certificado curinga no namespace <code>default</code> para que o ALB possa acessar e usar o certificado em cada namespace. <strong>Nota</strong>: os certificados TLS que contêm chaves pré-compartilhadas (TLS-PSK) não são suportados.
      * Se um certificado TLS é armazenado no {{site.data.keyword.cloudcerts_long_notm}} que você deseja usar, é possível importar seu segredo associado para o cluster executando o comando a seguir:
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * Se você não tiver um certificado TLS pronto, siga estas etapas:
        1. Crie um certificado e chave TLS para seu domínio que é codificado no formato PEM.
        2. Crie um segredo que use seu certificado e chave do TLS. Substitua <em>&lt;tls_secret_name&gt;</em> pelo nome para o seu segredo do Kubernetes, <em>&lt;tls_key_filepath&gt;</em> pelo caminho para o seu arquivo-chave do TLS customizado e <em>&lt;tls_cert_filepath&gt;</em> pelo caminho para o seu arquivo de certificado do TLS customizado.
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### Etapa 3: Criar o recurso de Ingresso
{: #public_inside_3}

Os recursos do Ingress definem as regras de roteamento que o ALB usa para rotear tráfego para seu serviço de app.
{: shortdesc}

**Nota:** se o seu cluster tiver múltiplos namespaces nos quais os apps serão expostos, pelo menos um recurso do Ingress será necessário por namespace. No entanto, cada namespace deve usar um host diferente. Deve-se registrar um domínio curinga e especificar um subdomínio diferente em cada recurso. Para obter mais informações, veja [Planejando a rede para namespaces únicos ou múltiplos](#multiple_namespaces).

1. Abra o seu editor preferencial e crie um arquivo de configuração do Ingress que seja denominado, por exemplo, `myingressresource.yaml`.

2. Defina um recurso do Ingress em seu arquivo de configuração que use o domínio fornecido pela IBM ou seu domínio customizado para rotear o tráfego de rede recebido para os serviços criados anteriormente.

    YAML de exemplo que não usa TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      rules:
      - host: <domain> http: paths:
          - path: /<app1_path> backend: serviceName: <app1_service> servicePort: 80
          - path: /<app2_path> backend: serviceName: <app2_service> servicePort: 80
    ```
    {: codeblock}

    Exemplo YAML que usa TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      tls:
      - hosts:
        - <domain> secretName: <tls_secret_name> rules:
      - host: <domain> http: paths:
          - path: /<app1_path> backend: serviceName: <app1_service> servicePort: 80
          - path: /<app2_path> backend: serviceName: <app2_service> servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>Para usar o TLS, substitua <em>&lt;domain&gt;</em> pelo subdomínio do Ingress fornecido pela IBM ou seu domínio customizado.

    </br></br>
    <strong>Nota:</strong><ul><li>Se os seus apps forem expostos por serviços em namespaces diferentes em um cluster, anexe um subdomínio curinga ao início do domínio, como `subdomain1.custom_domain.net` ou `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Use um subdomínio exclusivo para cada recurso criado no cluster.</li><li>Não usar &ast; para o host ou deixar a propriedade do host vazia para evitar falhas durante a criação do Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><ul><li>Se você usar o domínio do Ingress fornecido pela IBM, substitua <em>&lt;tls_secret_name&gt;</em> pelo nome do segredo do Ingress fornecido pela IBM.</li><li>Se você usar um domínio customizado, substitua <em>&lt;tls_secret_name&gt;</em> pelo segredo que você criou anteriormente, que contém o seu certificado e chave do TLS customizados. Se você importou um certificado do {{site.data.keyword.cloudcerts_short}}, será possível executar <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> para ver os segredos que estiverem associados a um certificado do TLS.</li><ul><td>
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Substitua <em>&lt;domain&gt;</em> pelo subdomínio do Ingress fornecido pela IBM ou por seu domínio customizado.

    </br></br>
    <strong>Nota:</strong><ul><li>Se os seus apps forem expostos por serviços em namespaces diferentes em um cluster, anexe um subdomínio curinga ao início do domínio, como `subdomain1.custom_domain.net` ou `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Use um subdomínio exclusivo para cada recurso criado no cluster.</li><li>Não usar &ast; para o host ou deixar a propriedade do host vazia para evitar falhas durante a criação do Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Substitua <em>&lt;app_path&gt;</em> por uma barra ou pelo caminho em que seu app está atendendo. O caminho é anexado ao domínio fornecido pela IBM ou ao seu domínio customizado para criar uma rota exclusiva para o app. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço. O serviço, então, encaminha o tráfego para os pods nos quais o app está em execução.
    </br></br>
    Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app. Exemplos: <ul><li>Para <code>http://domain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://domain/app1_path</code>, insira <code>/app1_path</code> como o caminho.</li></ul>
    </br>
    <strong>Dica:</strong> para configurar o Ingress para atender em um caminho diferente do caminho no qual seu app atende, será possível usar [gravar novamente a anotação](cs_annotations.html#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Substitua <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em> e assim por diante, pelo nome dos serviços criados para expor seus apps. Se os seus apps forem expostos por serviços em namespaces diferentes no cluster, inclua apenas serviços de app que estejam no mesmo namespace. Deve-se criar um recurso do Ingress para cada namespace que contenha apps que se deseja expor.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>A porta na qual o serviço atende. Use a mesma porta que você definiu quando criou o serviço do Kubernetes para seu app.</td>
    </tr>
    </tbody></table>

3.  Crie o recurso de Ingresso para seu cluster. Assegure-se de que o recurso seja implementado no mesmo namespace que os serviços de app especificados no recurso.

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Verifique se o recurso de Ingresso foi criado com êxito.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.


O recurso do Ingress é criado no mesmo namespace que os serviços de app. Seus apps nesse namespace são registrados com o ALB do Ingress do cluster.

### Etapa 4: Acessar seu app na Internet
{: #public_inside_4}

Em um navegador da web, insira a URL do serviço de app a ser acessado.

```
https://<domain>/<app1_path>
```
{: pre}

Se tiver exposto múltiplos apps, acesse-os mudando o caminho anexado à URL.

```
https://<domain>/<app2_path>
```
{: pre}

Se usar um domínio curinga para expor apps em diferentes namespaces, acesse esses apps com seus respectivos subdomínios.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


Tendo problemas de conexão com seu app por meio do Ingress? Tente  [ Depurging Ingress ](cs_troubleshoot_debug_ingress.html).
{: tip}

<br />


## Expondo apps que estão fora de seu cluster para o público
{: #external_endpoint}

Expor apps que estão fora de seu cluster para o público, incluindo-os no balanceamento de carga do ALB de Ingresso público. As solicitações públicas recebidas no domínio customizado ou fornecido pela IBM são encaminhadas automaticamente para o app externo.
{:shortdesc}

Antes de iniciar:

* Revise o Ingresso [pré-requisitos](#config_prereqs).
* Assegure-se de que o app externo que você deseja incluir no balanceamento de carga do cluster possa ser acessado usando um endereço IP público.
* [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

### Etapa 1: criar um serviço de app e terminal externo
{: #public_outside_1}

Inicie criando um serviço do Kubernetes para expor o app externo e configurando um terminal externo do Kubernetes para o app.
{: shortdesc}

1.  Crie um serviço do Kubernetes para o seu cluster que encaminhará as solicitações recebidas para um terminal externo que você criará.
    1.  Abra seu editor preferencial e crie um arquivo de configuração de serviço que seja chamado, por exemplo, de `myexternalservice.yaml`.
    2.  Defina um serviço para o app que o ALB exporá.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myexternalservice
        spec:
          ports:
           - protocol: TCP port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Entendendo os componentes de arquivo de serviço do ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Substitua <em>&lt;myexternalservice&gt;</em> por um nome de seu serviço.<p>Saiba mais sobre [como proteger suas informações pessoais](cs_secure.html#pi) quando trabalhar com recursos do Kubernetes.</p></td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>A porta na qual o serviço atende.</td>
        </tr></tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o serviço do Kubernetes para seu cluster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}
2.  Configure um terminal do Kubernetes que defina o local externo do app que você deseja incluir no balanceamento de carga do cluster.
    1.  Abra seu editor preferencial e crie um arquivo de configuração do terminal que é chamado, por exemplo, de `myexternalendpoint.yaml`.
    2.  Defina seu terminal externo. Inclua todos os endereços IP públicos e portas que podem ser usados para acessar seu app externo.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalendpoint
        subsets:
          - addresses:
              - ip: <external_IP1>
              - ip: <external_IP2>
            ports:
              - port: <external_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myexternalendpoint&gt;</em> pelo nome do serviço do Kubernetes que você criou anteriormente.</td>
        </tr>
        <tr>
        <td><code>IP</code></td>
        <td>Substitua <em>&lt;external_IP&gt;</em> pelos endereços IP públicos para se conectar ao app externo.</td>
         </tr>
         <td><code>port</code></td>
         <td>Substitua <em>&lt;external_port&gt;</em> pela porta em que seu app externo atende.</td>
         </tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o terminal do Kubernetes para seu cluster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

### Etapa 2: Selecionar um domínio de app e uma finalização de TLS
{: #public_outside_2}

Ao configurar o ALB público, você escolhe o domínio pelo qual seus apps são acessíveis e se usa a finalização do TLS.
{: shortdesc}

<dl>
<dt>Domínio</dt>
<dd>É possível usar o domínio fornecido pela IBM, como <code>mycluster-12345.us-south.containers.appdomain.cloud/myapp</code>, para acessar seu app na Internet. Para usar um domínio customizado em vez disso, é possível configurar um registro CNAME para mapear o seu domínio customizado para o domínio fornecido pela IBM ou configurar um registro A com o seu provedor do DNS usando o endereço IP público do ALB.</dd>
<dt>Finalização TLS</dt>
<dd>A carga do ALB equilibra o tráfego de rede HTTP de seus apps. Para também balancear a carga de conexões HTTPS recebidas, será possível configurar o ALB para decriptografar o tráfego de rede e encaminhar a solicitação decriptografada para os apps expostos no cluster. <ul><li>Se você usar o subdomínio do Ingress fornecido pela IBM, será possível usar o certificado do TLS fornecido pela IBM. Os certificados do TLS fornecidos pela IBM são assinados por LetsEncrypt e são totalmente gerenciados pela IBM. Os certificados expiram a cada 90 dias e são renovados automaticamente 7 dias antes de expirarem.</li><li>Se você usar um domínio customizado, será possível usar o seu próprio certificado do TLS para gerenciar a rescisão do TLS. Importe ou crie um segredo do TLS para o certificado no namespace <code>default</code> do cluster. <strong>Nota</strong>: os certificados TLS que contêm chaves pré-compartilhadas (TLS-PSK) não são suportados.</li></ul></dd>
</dl>

#### Para usar o domínio de Ingresso fornecido pela IBM:
Obtenha o domínio fornecido pela IBM e, se você desejar usar o TLS, o segredo do TLS fornecido pela IBM para seu cluster. Substitua _&lt;cluster_name_or_ID&gt;_ pelo nome do cluster no qual o app está implementado. **Nota**: para obter informações sobre a certificação do TLS curinga, consulte [esta nota](#wildcard_tls).
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep Ingress
```
{: pre}

Saída de exemplo:

```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}


#### Para usar um domínio customizado:
1.    Crie um domínio customizado. Para registrar seu domínio customizado, trabalhe com o provedor Domain Name Service (DNS) ou com o [DNS do {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns).
      * Se os apps que você deseja que o Ingress exponha estiverem em namespaces diferentes em um cluster, registre o domínio customizado como um domínio curinga, como `*.custom_domain.net`.

2.  Configure seu domínio para rotear o tráfego de rede recebido para o ALB fornecido pela IBM. Escolha entre estas opções:
    -   Defina um alias para seu domínio customizado especificando o domínio fornecido pela IBM como um registro de Nome Canônico (CNAME). Para localizar o domínio do Ingress fornecido pela IBM, execute `ibmcloud ks cluster-get <cluster_name>` e procure o campo **Subdomínio do Ingresso**. O uso de um CNAME é preferencial porque a IBM fornece verificações de funcionamento automáticas no subdomínio IBM e remove os IPs com falha da resposta de DNS.
    -   Mapeie o seu domínio customizado para o endereço IP público móvel do ALB fornecido pela IBM incluindo o endereço IP como um registro. Para localizar o endereço IP público móvel do ALB, execute `ibmcloud ks alb-get <public_alb_ID>`.
3.   Opcional: para usar o TLS, importe ou crie um certificado do TLS e um segredo de chave. Se você usar um domínio curinga, assegure-se de importar ou criar um certificado curinga no namespace <code>default</code> para que o ALB possa acessar e usar o certificado em cada namespace. <strong>Nota</strong>: os certificados TLS que contêm chaves pré-compartilhadas (TLS-PSK) não são suportados.
      * Se um certificado TLS é armazenado no {{site.data.keyword.cloudcerts_long_notm}} que você deseja usar, é possível importar seu segredo associado para o cluster executando o comando a seguir:
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * Se você não tiver um certificado TLS pronto, siga estas etapas:
        1. Crie um certificado e chave TLS para seu domínio que é codificado no formato PEM.
        2. Crie um segredo que use seu certificado e chave do TLS. Substitua <em>&lt;tls_secret_name&gt;</em> pelo nome para o seu segredo do Kubernetes, <em>&lt;tls_key_filepath&gt;</em> pelo caminho para o seu arquivo-chave do TLS customizado e <em>&lt;tls_cert_filepath&gt;</em> pelo caminho para o seu arquivo de certificado do TLS customizado.
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### Etapa 3: Criar o recurso de Ingresso
{: #public_outside_3}

Os recursos do Ingress definem as regras de roteamento que o ALB usa para rotear tráfego para seu serviço de app.
{: shortdesc}

**Nota:** se você está expondo múltiplos apps externos e os serviços criados para os apps na [Etapa 1](#public_outside_1) estão em namespaces diferentes, pelo menos um recurso de Ingresso é necessário por namespace. No entanto, cada namespace deve usar um host diferente. Deve-se registrar um domínio curinga e especificar um subdomínio diferente em cada recurso. Para obter mais informações, veja [Planejando a rede para namespaces únicos ou múltiplos](#multiple_namespaces).

1. Abra seu editor preferencial e crie um arquivo de configuração do Ingresso que seja chamado, por exemplo, de `myexternalingress.yaml`.

2. Defina um recurso do Ingress em seu arquivo de configuração que use o domínio fornecido pela IBM ou seu domínio customizado para rotear o tráfego de rede recebido para os serviços criados anteriormente.

    YAML de exemplo que não usa TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myexternalingress
    spec:
      rules:
      - host: <domain> http: paths:
          - path: /<external_app1_path> backend: serviceName: <app1_service> servicePort: 80
          - path: /<external_app2_path> backend: serviceName: <app2_service> servicePort: 80
    ```
    {: codeblock}

    Exemplo YAML que usa TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myexternalingress
    spec:
      tls:
      - hosts:
        - <domain> secretName: <tls_secret_name> rules:
      - host: <domain> http: paths:
          - path: /<external_app1_path> backend: serviceName: <app1_service> servicePort: 80
          - path: /<external_app2_path> backend: serviceName: <app2_service> servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>Para usar o TLS, substitua <em>&lt;domain&gt;</em> pelo subdomínio do Ingress fornecido pela IBM ou seu domínio customizado.

    </br></br>
    <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><ul><li>Se você usar o domínio do Ingress fornecido pela IBM, substitua <em>&lt;tls_secret_name&gt;</em> pelo nome do segredo do Ingress fornecido pela IBM.</li><li>Se você usar um domínio customizado, substitua <em>&lt;tls_secret_name&gt;</em> pelo segredo que você criou anteriormente, que contém o seu certificado e chave do TLS customizados. Se você importou um certificado do {{site.data.keyword.cloudcerts_short}}, será possível executar <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> para ver os segredos que estiverem associados a um certificado do TLS.</li><ul><td>
    </tr>
    <tr>
    <td><code>rules/host</code></td>
    <td>Substitua <em>&lt;domain&gt;</em> pelo subdomínio do Ingress fornecido pela IBM ou por seu domínio customizado.

    </br></br>
    <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Substitua <em>&lt;external_app_path&gt;</em> por uma barra ou o caminho em que seu app está atendendo. O caminho é anexado ao domínio fornecido pela IBM ou ao seu domínio customizado para criar uma rota exclusiva para o app. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço. O serviço encaminha o tráfego para o app externo. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede recebido.
    </br></br>
    Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app. Exemplos: <ul><li>Para <code>http://domain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://domain/app1_path</code>, insira <code>/app1_path</code> como o caminho.</li></ul>
    </br></br>
    <strong>Dica:</strong> para configurar o Ingress para atender em um caminho diferente do caminho no qual seu app atende, será possível usar [gravar novamente a anotação](cs_annotations.html#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Substitua <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em>, por exemplo, pelo nome dos serviços que você criou para expor seus apps externos. Se os seus apps forem expostos por serviços em namespaces diferentes no cluster, inclua apenas serviços de app que estejam no mesmo namespace. Deve-se criar um recurso do Ingress para cada namespace que contenha apps que se deseja expor.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>A porta na qual o serviço atende. Use a mesma porta que você definiu quando criou o serviço do Kubernetes para seu app.</td>
    </tr>
    </tbody></table>

3.  Crie o recurso de Ingresso para seu cluster. Assegure-se de que o recurso seja implementado no mesmo namespace que os serviços de app especificados no recurso.

    ```
    kubectl apply -f myexternalingress.yaml -n <namespace>
    ```
    {: pre}
4.   Verifique se o recurso de Ingresso foi criado com êxito.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.


O recurso do Ingress é criado no mesmo namespace que os serviços de app. Seus apps nesse namespace são registrados com o ALB do Ingress do cluster.

### Etapa 4: Acessar seu app na Internet
{: #public_outside_4}

Em um navegador da web, insira a URL do serviço de app a ser acessado.

```
https://<domain>/<app1_path>
```
{: pre}

Se tiver exposto múltiplos apps, acesse-os mudando o caminho anexado à URL.

```
https://<domain>/<app2_path>
```
{: pre}

Se usar um domínio curinga para expor apps em diferentes namespaces, acesse esses apps com seus respectivos subdomínios.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


Tendo problemas de conexão com seu app por meio do Ingress? Tente  [ Depurging Ingress ](cs_troubleshoot_debug_ingress.html).
{: tip}

<br />


## Expondo apps para uma rede privada
{: #ingress_expose_private}

Exponha apps para uma rede privada usando o ALB de Ingresso privado.
{:shortdesc}

Antes de iniciar:
* Revise o Ingresso [pré-requisitos](#config_prereqs).
* Revise as opções para planejar o acesso privado aos apps quando os nós do trabalhador forem conectados a [uma VLAN pública e uma privada](cs_network_planning.html#private_both_vlans) ou a [somente a uma VLAN privada](cs_network_planning.html#private_vlan).
    * Se os seus nós do trabalhador estão conectados somente a uma VLAN privada, deve-se configurar um [serviço do DNS do que esteja disponível na rede privada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

### Etapa 1: Implementar apps e criar serviços de app
{: #private_1}

Inicie implementando seus apps e criando serviços do Kubernetes para expô-los.
{: shortdesc}

1.  [Implemente o seu app no cluster](cs_app.html#app_cli). Assegure-se de incluir um rótulo em sua implementação na seção de metadados de seu arquivo de configuração, como `app: code`. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução para que os pods possam ser incluídos no balanceamento de carga do Ingress.

2.   Crie um serviço do Kubernetes para cada app que se deseja expor. O seu app deve ser exposto por um serviço do Kubernetes a ser incluído pelo ALB de cluster no balanceamento de carga do Ingress.
      1.  Abra o seu editor preferencial e crie um arquivo de configuração de serviço que seja denominado, por exemplo, `myappservice.yaml`.
      2.  Defina um serviço para o app que o ALB exporá.

          ```
          apiVersion: v1 kind: Service metadata: name: myappservice spec: selector: <selector_key>: <selector_value> ports:
             - protocol: TCP port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Ícone Ideia"/> Entendendo os componentes do arquivo YAML do serviço ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>seletor</code></td>
          <td>Insira a chave de etiqueta (<em>&lt;selector_key&gt;</em>) e o par de valores (<em>&lt;selector_value&gt;</em>) que você deseja usar para destinar os pods nos quais o seu app é executado. Para direcionar seus pods e incluí-los no balanceamento de carga do serviço, assegure-se de que o <em>&lt;selector_key&gt;</em> e o <em>&lt;selector_value&gt;</em> sejam iguais ao par de chave/valor na seção <code>spec.template.metadata.labels</code> do yaml de sua implementação.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>A porta na qual o serviço atende.</td>
           </tr>
           </tbody></table>
      3.  Salve as suas mudanças.
      4.  Crie o serviço em seu cluster. Se os apps forem implementados em múltiplos namespaces no cluster, assegure-se de que o serviço seja implementado no mesmo namespace que o app que se deseja expor.

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  Repita essas etapas para cada app que desejar expor.


### Etapa 2: ativar o ALB privado padrão
{: #private_ingress}

Ao criar um cluster padrão, um balanceador de carga do aplicativo (ALB) privado fornecido pela IBM é criado em cada zona que você tem nós do trabalhador e designado a um endereço IP privado móvel e uma rota privada. No entanto, o ALB privado padrão em cada zona não é ativado automaticamente. Para usar o ALB privado padrão para balancear a carga do tráfego de rede privada para seus apps, deve-se primeiro ativá-lo com o endereço IP privado móvel fornecido pela IBM ou seu próprio endereço IP privado móvel.
{:shortdesc}

**Nota**: se você usou a sinalização `--no-subnet` quando criou o cluster, deve-se incluir uma sub-rede privada móvel ou uma sub-rede gerenciada pelo usuário antes de poder ativar o ALB privado. Para obter mais informações, veja [Solicitando sub-redes adicionais para seu cluster](cs_subnets.html#request).

**Para ativar um ALB privado padrão usando o endereço IP privado móvel fornecido pela IBM pré-designado:**

1. Obtenha o ID do ALB privado padrão que você deseja ativar. Substitua <em>&lt;cluster_name&gt;</em> pelo nome do cluster no qual o app que você deseja expor está implementado.

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    O campo **Status** para os ALBs privados é _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone
    private-cr6d779503319d419aa3b4ab171d12c3b8-alb1   false     disabled   private   -               dal10
    private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2   false     disabled   private   -               dal12
    public-cr6d779503319d419aa3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx  dal10
    public-crb2f60e9735254ac8b20b9c1e38b649a5-alb2    true      enabled    public    169.xx.xxx.xxx  dal12
    ```
    {: screen}
    Em clusters de múltiplas zonas, o sufixo numerado no ID de ALB indica a ordem em que o ALB foi incluído.
    * Por exemplo, o sufixo `-alb1` no ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` indica que ele foi o primeiro ALB privado padrão criado. Ele existe na zona em que você criou o cluster. No exemplo acima, o cluster foi criado em `dal10`.
    * O sufixo `-alb2` no ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` indica que ele foi o segundo ALB privado padrão criado. Ele existe na segunda zona que você incluiu em seu cluster. No exemplo acima, a segunda zona é `dal12`.

2. Ative o ALB privado. Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID de ALB privado da saída na etapa anterior.

   ```
   ibmcloud ks alb-configure -- albID < private_ALB_ID> -- enable
   ```
   {: pre}

3. **Clusters multizona**: para alta disponibilidade, repita as etapas acima para o ALB privado em cada zona.

<br>
**Para ativar o ALB privado usando seu próprio endereço IP privado móvel:**

1. Configure a sub-rede gerenciada pelo usuário de seu endereço IP escolhido para rotear o tráfego na VLAN privada do seu cluster.

   ```
   ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN_ID>
   ```
   {: pre}

   <table>
   <thead>
   <th colspan=2>Entendendo os componentes do comando<img src="images/idea.png" alt="Idea icon"/></th>
   </thead>
   <tbody>
   <tr>
   <td><code> &lt;cluster_name&gt; </code></td>
   <td>O nome ou ID do cluster no qual o app que você deseja expor está implementado.</td>
   </tr>
   <tr>
   <td><code>&lt;subnet_CIDR&gt;</code></td>
   <td>O CIDR de sua sub-rede gerenciada pelo usuário.</td>
   </tr>
   <tr>
   <td><code>&lt;private_VLAN_ID&gt;</code></td>
   <td>Um ID de VLAN privada disponível. É possível localizar o ID de uma VLAN privada disponível, executando `ibmcloud ks vlans`.</td>
   </tr>
   </tbody></table>

2. Liste os ALBs disponíveis em seu cluster para obter o ID de ALB privado.

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    O campo **Status** para o ALB privado está _desativado_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -               dal10
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx  dal10
    ```
    {: screen}

3. Ative o ALB privado. Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID do ALB privado da saída na etapa anterior e <em>&lt;user_IP&gt;</em> pelo endereço IP de sua sub-rede gerenciada pelo usuário que você deseja usar.

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

4. **Clusters multizona**: para alta disponibilidade, repita as etapas acima para o ALB privado em cada zona.

### Etapa 3: mapear seu domínio customizado e selecionar a finalização do TLS
{: #private_3}

Ao configurar o ALB privado, você usa um domínio customizado por meio do qual seus apps serão acessíveis e escolhe se deseja usar a finalização do TLS.
{: shortdesc}

O ALB faz o balanceamento de carga do tráfego de rede HTTP para seus apps. Para também fazer o balanceamento de carga de conexões HTTPS recebidas, é possível configurar o ALB para usar seu próprio certificado TLS para decriptografar o tráfego de rede. O ALB então encaminha a solicitação decriptografada para os apps expostos em seu cluster.
1.   Crie um domínio customizado. Para registrar seu domínio customizado, trabalhe com o provedor Domain Name Service (DNS) ou com o [DNS do {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns).
      * Se os apps que você deseja que o Ingress exponha estiverem em namespaces diferentes em um cluster, registre o domínio customizado como um domínio curinga, como `*.custom_domain.net`.

2. Mapeie o seu domínio customizado para o endereço IP privado móvel do ALB privado fornecido pela IBM, incluindo o endereço IP como um registro. Para localizar o endereço IP privado móvel do ALB privado, execute `ibmcloud ks albs --cluster <cluster_name>`.
3.   Opcional: para usar o TLS, importe ou crie um certificado do TLS e um segredo de chave. Se você usar um domínio curinga, assegure-se de importar ou criar um certificado curinga no namespace <code>default</code> para que o ALB possa acessar e usar o certificado em cada namespace. <strong>Nota</strong>: os certificados TLS que contêm chaves pré-compartilhadas (TLS-PSK) não são suportados.
      * Se um certificado TLS é armazenado no {{site.data.keyword.cloudcerts_long_notm}} que você deseja usar, é possível importar seu segredo associado para o cluster executando o comando a seguir:
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * Se você não tiver um certificado TLS pronto, siga estas etapas:
        1. Crie um certificado e chave TLS para seu domínio que é codificado no formato PEM.
        2. Crie um segredo que use seu certificado e chave do TLS. Substitua <em>&lt;tls_secret_name&gt;</em> pelo nome para o seu segredo do Kubernetes, <em>&lt;tls_key_filepath&gt;</em> pelo caminho para o seu arquivo-chave do TLS customizado e <em>&lt;tls_cert_filepath&gt;</em> pelo caminho para o seu arquivo de certificado do TLS customizado.
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### Etapa 4: Criar o Recurso do Ingresso
{: #private_4}

Os recursos do Ingress definem as regras de roteamento que o ALB usa para rotear tráfego para seu serviço de app.
{: shortdesc}

**Nota:** se o seu cluster tiver múltiplos namespaces nos quais os apps serão expostos, pelo menos um recurso do Ingress será necessário por namespace. No entanto, cada namespace deve usar um host diferente. Deve-se registrar um domínio curinga e especificar um subdomínio diferente em cada recurso. Para obter mais informações, veja [Planejando a rede para namespaces únicos ou múltiplos](#multiple_namespaces).

1. Abra o seu editor preferencial e crie um arquivo de configuração do Ingress que seja denominado, por exemplo, `myingressresource.yaml`.

2.  Defina um recurso de Ingresso em seu arquivo de configuração que use o seu domínio customizado para rotear o tráfego de rede recebido para os serviços que você criou anteriormente.

    YAML de exemplo que não usa TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
    spec:
      rules:
      - host: <domain> http: paths:
          - path: /<app1_path> backend: serviceName: <app1_service> servicePort: 80
          - path: /<app2_path> backend: serviceName: <app2_service> servicePort: 80
    ```
    {: codeblock}

    Exemplo YAML que usa TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
    spec:
      tls:
      - hosts:
        - <domain> secretName: <tls_secret_name> rules:
      - host: <domain> http: paths:
          - path: /<app1_path> backend: serviceName: <app1_service> servicePort: 80
          - path: /<app2_path> backend: serviceName: <app2_service> servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td>Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID de seu ALB privado. Execute <code>ibmcloud ks albs --cluster <my_cluster></code> para localizar o ID do ALB. Para obter mais informações sobre essa anotação de Ingresso, veja [Roteamento do balanceador de carga de aplicativo privado](cs_annotations.html#alb-id).</td>
    </tr>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>Para usar TLS, substitua <em>&lt;domain&gt;</em> com seu domínio customizado.</br></br><strong>Nota:</strong><ul><li>Se os seus apps forem expostos por serviços em namespaces diferentes em um cluster, anexe um subdomínio curinga ao início do domínio, como `subdomain1.custom_domain.net`. Use um subdomínio exclusivo para cada recurso criado no cluster.</li><li>Não usar &ast; para o host ou deixar a propriedade do host vazia para evitar falhas durante a criação do Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td>Substitua <em>&lt;tls_secret_name&gt;</em> pelo nome do segredo que você criou anteriormente e que contém o seu certificado e chave TLS customizados. Se você importou um certificado do {{site.data.keyword.cloudcerts_short}}, será possível executar <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> para ver os segredos que estiverem associados a um certificado do TLS.
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Substitua <em>&lt;domain&gt;</em> com seu domínio customizado.
    </br></br>
    <strong>Nota:</strong><ul><li>Se os seus apps forem expostos por serviços em namespaces diferentes em um cluster, anexe um subdomínio curinga ao início do domínio, como `subdomain1.custom_domain.net`. Use um subdomínio exclusivo para cada recurso criado no cluster.</li><li>Não usar &ast; para o host ou deixar a propriedade do host vazia para evitar falhas durante a criação do Ingress.</li></ul></td>
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Substitua <em>&lt;app_path&gt;</em> por uma barra ou pelo caminho em que seu app está atendendo. O caminho é anexado ao seu domínio customizado para criar uma rota exclusiva para seu app. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço. O serviço, então, encaminha o tráfego para os pods nos quais o app está em execução.
    </br></br>
    Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app. Exemplos: <ul><li>Para <code>http://domain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://domain/app1_path</code>, insira <code>/app1_path</code> como o caminho.</li></ul>
    </br>
    <strong>Dica:</strong> para configurar o Ingress para atender em um caminho diferente do caminho no qual seu app atende, será possível usar [gravar novamente a anotação](cs_annotations.html#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Substitua <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em> e assim por diante, pelo nome dos serviços criados para expor seus apps. Se os seus apps forem expostos por serviços em namespaces diferentes no cluster, inclua apenas serviços de app que estejam no mesmo namespace. Deve-se criar um recurso do Ingress para cada namespace que contenha apps que se deseja expor.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>A porta na qual o serviço atende. Use a mesma porta que você definiu quando criou o serviço do Kubernetes para seu app.</td>
    </tr>
    </tbody></table>

3.  Crie o recurso de Ingresso para seu cluster. Assegure-se de que o recurso seja implementado no mesmo namespace que os serviços de app especificados no recurso.

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Verifique se o recurso de Ingresso foi criado com êxito.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.


O recurso do Ingress é criado no mesmo namespace que os serviços de app. Seus apps nesse namespace são registrados com o ALB do Ingress do cluster.

### Etapa 5: acessar seu app por meio de sua rede privada
{: #private_5}

1. Antes de poder acessar seu app, certifique-se de que seja possível acessar um serviço DNS.
  * VLAN pública e privada: para usar o provedor do DNS externo padrão, deve-se [configurar nós de borda com acesso público](cs_edge.html#edge) e [configurar um Virtual Router Appliance ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).
  * Apenas VLAN privada: deve-se configurar um [serviço do DNS que está disponível na rede privada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

2. De dentro de seu firewall de rede privada, insira a URL do serviço de app em um navegador da web.

```
https://<domain>/<app1_path>
```
{: pre}

Se tiver exposto múltiplos apps, acesse-os mudando o caminho anexado à URL.

```
https://<domain>/<app2_path>
```
{: pre}

Se usar um domínio curinga para expor apps em diferentes namespaces, acesse esses apps com seus respectivos subdomínios.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


Para obter um tutorial abrangente sobre como assegurar a comunicação de microsserviço-para-microsserviço em seus clusters usando o ALB privado com TLS, veja [esta postagem do blog ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).
{: tip}

<br />


## Customizando um Recurso de Ingresso com Anotações
{: #annotations}

Para incluir recursos em seu balanceador de carga do aplicativo (ALB) do Ingress, é possível incluir as anotações específicas da IBM como metadados em um recurso Ingress.
{: shortdesc}

Introdução a algumas das anotações mais comumente usadas.
* [redirect-to-https](cs_annotations.html#redirect-to-https): converta solicitações do cliente HTTP não seguras para HTTPS.
* [rewrite-path](cs_annotations.html#rewrite-path): roteie o tráfego de rede recebido para um caminho diferente no qual seu app de backend atende.
* [ssl-services](cs_annotations.html#ssl-services): use TLS para criptografar o tráfego para seus apps de envio de dados que requerem HTTPS.
* [client-max-body-size ](cs_annotations.html#client-max-body-size): configure o tamanho máximo do corpo que o cliente pode enviar como parte de uma solicitação.

Para obter a lista integral de anotações suportadas, consulte [Customizando o Ingresso com anotações](cs_annotations.html).

<br />


## Abrindo portas no ALB do Ingresso
{: #opening_ingress_ports}

Por padrão, somente as portas 80 e 443 são expostas no ALB de Ingresso. Para expor outras portas, é possível editar o recurso configmpa `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

1. Crie e abra uma versão local do arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Inclua uma seção <code>dados</code> e especifique as portas públicas `80`, `443` e quaisquer outras portas que você deseja expor separados por um ponto e vírgula (;).

    **Importante**: por padrão, as portas 80 e 443 estão abertas. Se você deseja manter a 80 e a 443 abertas, deve-se também incluí-las além de quaisquer outras portas especificadas no campo `public-ports`. Qualquer porta que não esteja especificada é encerrada. Se você ativou um ALB privado, deve-se também especificar quaisquer portas que você deseja manter abertas no campo `private-ports`.

    ```
    apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    Exemplo que mantém as portas `80`, `443` e `9443` abertas:
    ```
    apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: screen}

3. Salve o arquivo de configuração.

4. Verifique se as mudanças de configmap foram aplicadas.

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

Para obter mais informações sobre os recursos configmap, veja a [documentação do Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/).

<br />


## Preservando o endereço IP de origem
{: #preserve_source_ip}

Por padrão, o endereço IP de origem da solicitação do cliente não é preservado. Quando uma solicitação do cliente para o seu app for enviada para o seu cluster, a solicitação será roteada para um pod para o serviço do balanceador de carga que expõe o ALB. Se nenhum pod de app existir no mesmo nó do trabalhador que o pod de serviço de balanceador de carga, o balanceador de carga encaminhará a solicitação para um pod de app em um nó do trabalhador diferente. O endereço IP de origem do pacote é mudado para o endereço IP público do nó do trabalhador no qual o pod de app está em execução.

Para preservar o endereço IP de origem original da solicitação do cliente, é possível [ativar a preservação de IP de origem ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer). Preservar o IP do cliente é útil, por exemplo, quando os servidores de app precisam aplicar as políticas de segurança e de controle de acesso.

**Nota**: se você [desativa um ALB](cs_cli_reference.html#cs_alb_configure), quaisquer mudanças de IP de origem feitas no serviço de balanceador de carga expondo o ALB são perdidas. Quando você reativa o ALB, deve-se ativar o IP de origem novamente.

Para ativar a preservação de IP de origem, edite o serviço de balanceador de carga que expõe um ALB do Ingresso:

1. Ative a preservação de IP de origem para um único ALB ou para todos os ALBs em seu cluster.
    * Para configurar a preservação de IP de origem para um único ALB:
        1. Obtenha o ID do ALB para o qual você deseja ativar o IP de origem. Os serviços ALB têm um formato semelhante a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` para um ALB público ou `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` para um ALB privado.
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Abra o YAML para o serviço de balanceador de carga que expõe o ALB.
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. Em **spec**, mude o valor de **externalTrafficPolicy** de `Cluster` para `Local`.

        4. Salve e feche o arquivo de configuração. A saída é semelhante à seguinte:

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * Para configurar a preservação de IP de origem para todos os ALBs públicos em seu cluster, execute o comando a seguir:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Saída de exemplo:
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * Para configurar a preservação de IP de origem para todos os ALBs privados em seu cluster, execute o comando a seguir:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Saída de exemplo:
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Verifique se o IP de origem está sendo preservado em seus logs de pods do ALB.
    1. Obtenha o ID de um pod para o ALB que você modificou.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Abra os logs para esse pod do ALB. Verifique se o endereço IP para o campo `client` é o endereço IP de solicitação do cliente em vez do endereço IP do serviço de balanceador de carga.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. Agora, ao procurar os cabeçalhos para as solicitações enviadas para seu app de backend, é possível ver o endereço IP do cliente no cabeçalho `x-forwarded-for`.

4. Se você não desejar mais preservar o IP de origem, será possível reverter as mudanças feitas no serviço.
    * Para reverter a preservação do IP de origem para seus ALBs públicos:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * Para reverter a preservação do IP de origem para seus ALBs privados:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## Configurando protocolos SSL e cifras SSL no nível de HTTP
{: #ssl_protocols_ciphers}

Ative os protocolos e cifras SSL no nível HTTP global editando o configmap `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

Por padrão, o protocolo TLS 1.2 é usado para todas as configurações de Ingress que usam o domínio fornecido pela IBM. É possível substituir o padrão para usar os protocolos TLS 1.1 ou 1.0 seguindo estas etapas.

**Nota**: quando você especifica os protocolos ativados para todos os hosts, os parâmetros TLSv1.1 e TLSv1.2 (1.1.13, 1.0.12) funcionam somente quando o OpenSSL 1.0.1 ou superior é usado. O parâmetro TLSv1.3 (1.13.0) funciona somente quando o OpenSSL 1.1.1 construído com o suporte TLSv1.3 é usado.

Para editar o configmap para ativar protocolos e cifras SSL:

1. Crie e abra uma versão local do arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Inclua os protocolos e cifras SSL. Formate as cifras de acordo com o [Formato de lista de cifras da biblioteca OpenSSL ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
   ```
   {: codeblock}

3. Salve o arquivo de configuração.

4. Verifique se as mudanças de configmap foram aplicadas.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Ajustando o desempenho do ALB
{: #perf_tuning}

Para otimizar o desempenho de seus ALBs do Ingresso, é possível mudar as configurações padrão de acordo com suas necessidades.
{: shortdesc}

### Ativando o buffer de buffer e o tempo limite de flush
{: #access-log}

Por padrão, o ALB do Ingress registra cada solicitação conforme ela chega. Se você tem um ambiente que é intensamente usado, a criação de log de cada solicitação à medida que ela chega pode aumentar significativamente a utilização de E/S do disco. Para evitar E/S de disco contínuo, é possível ativar o armazenamento em buffer do log e limpar o tempo limite para o ALB editando o configmap do Ingress `ibm-cloud-provider-ingress-cm`. Quando o armazenamento em buffer está ativado, em vez de executar uma operação de gravação separada para cada entrada de log, o ALB armazena em buffer uma série de entradas e as grava em um arquivo em uma única operação.

1. Crie e abra uma versão local do arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Edite o configmap.
    1. Ative o armazenamento em buffer do log incluindo o campo `access-log-buffering` e configurando-o como `"true"`.

    2. Configure o limite para quando o ALB deve gravar conteúdos do buffer no log.
        * Intervalo de tempo: inclua o campo `flush-interval` e configure-o com que frequência o ALB deve gravar no log. Por exemplo, se o valor padrão de `5m` for usado, o ALB gravará conteúdos do buffer no log uma vez a cada 5 minutos.
        * Tamanho do buffer: inclua o campo `buffer-size` e configure-o para a quantia de memória de log que pode ser retida no buffer antes que o ALB grave os conteúdos do buffer no log. Por exemplo, se o valor padrão de `100KB` for usado, o ALB gravará os conteúdos do buffer no log toda vez que o buffer atingir 100 Kb de conteúdo de log.
        * Intervalo de tempo ou tamanho do buffer: quando `flush-interval` e `buffer-size` estão configurados, o ALB grava o conteúdo do buffer no log com base no parâmetro de limite que é atendido primeiro.

    ```
    apiVersion: v1
    kind: ConfigMap
    data:
      access-log-buffering: "true"
      flush-interval: "5m"
      buffer-size: "100KB"
    metadata:
      name: ibm-cloud-provider-ingress-cm
      ...
    ```
   {: codeblock}

3. Salve o arquivo de configuração.

4. Verifique se o ALB está configurado com as mudanças de log de acesso.

   ```
   kubectl logs -n kube-system <ALB_ID> -c nginx-ingress
   ```
   {: pre}

### Mudando o número ou a duração de conexões keep-alive
{: #keepalive_time}

As conexões keep-alive podem ter um grande impacto no desempenho, reduzindo a sobrecarga da CPU e da rede necessária para abrir e fechar conexões. Para otimizar o desempenho de seus ALBs, é possível mudar o número máximo de conexões keep-alive entre o ALB e o cliente e por quanto tempo as conexões keep-alive podem durar.
{: shortdesc}

1. Crie e abra uma versão local do arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Mude os valores de `keep-alive-requests` e `keep-alive`.
    * `keep-alive-requests`: o número de conexões do cliente keep-alive que podem permanecer abertas para o ALB do Ingress. O padrão é  ` 4096 `.
    * `keep-alive`: o tempo limite, em segundos, durante o qual a conexão do cliente keep-alive permanece aberta para o ALB do Ingress. O padrão é `8s`.
   ```
   apiVersion: v1
   data:
     keep-alive-requests: "4096"
     keep-alive: "8s"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Salve o arquivo de configuração.

4. Verifique se as mudanças de configmap foram aplicadas.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}


### Alterando a lista não processada de conexões pendentes
{: #backlog}

É possível diminuir a configuração de lista não processada padrão para quantas conexões pendentes podem esperar na fila do servidor.
{: shortdesc}

No configmap do Ingress `ibm-cloud-provider-ingress-cm`, o campo `backlog` configura o número máximo de conexões pendentes que podem esperar na fila do servidor. Por padrão, `backlog` está configurado como `32768`. É possível substituir o padrão editando o configmap do Ingress.

1. Crie e abra uma versão local do arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Mude o valor de `backlog` de `32768` para um valor inferior. O valor deve ser igual ou menor que 32768.

   ```
   apiVersion: v1
   data:
     backlog: "32768"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Salve o arquivo de configuração.

4. Verifique se as mudanças de configmap foram aplicadas.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}


### Ajustando o desempenho do kernel
{: #kernel}

Para otimizar o desempenho de seus ALBs do Ingress, também é possível [mudar os parâmetros `sysctl` do kernel do Linux em nós do trabalhador](cs_performance.html). Os nós do trabalhador são provisionados automaticamente com o ajuste de kernel otimizado, portanto, mude essas configurações somente se você tiver requisitos de otimização de desempenho específicos.

<br />


## Trazendo seu próprio controlador do Ingresso
{: #user_managed}

Traga o seu próprio controlador do Ingress e execute-o no {{site.data.keyword.Bluemix_notm}} enquanto alavanca o subdomínio do Ingress fornecido pela IBM e o certificado TLS designado ao seu cluster.
{: shortdesc}

A configuração de seu próprio controlador de ingresso customizado pode ser útil quando você tem requisitos específicos do Ingress. Ao trazer seu próprio controlador do Ingress em vez de usar o ALB do Ingress fornecido pela IBM, você é responsável por fornecer a imagem do controlador, manter o controlador e atualizar o controlador.

1. Obtenha o ID do ALB público padrão. O ALB público tem um formato semelhante a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. Desative o ALB público padrão. A sinalização `--disable-deployment` desativa a implementação do ALB fornecido pela IBM, mas não remove o registro do DNS para o subdomínio do Ingresso fornecido pela IBM ou o serviço de balanceador de carga usado para expor o controlador de ingresso.
    ```
    ibmcloud ks alb-configure -- albID < ALB_ID> --disable-deployment
    ```
    {: pre}

3. Deixe o arquivo de configuração para o seu controlador de ingresso pronto. Por exemplo, é possível usar o arquivo de configuração YAML para o [controlador de ingresso da comunidade nginx ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/ingress-nginx/blob/master/deploy/mandatory.yaml).

4. Implemente seu próprio controlador de Ingresso. **Importante**: para continuar a usar o serviço de balanceador de carga expondo o controlador e o subdomínio do Ingresso fornecido pela IBM, seu controlador deve ser implementado no namespace `kube-system`.
    ```
    kubectl aplicar -f customingress.yaml -n kube-system
    ```
    {: pre}

5. Obtenha o rótulo em sua implementação customizada do Ingresso.
    ```
    kubectl get deploy nginx-ingress-controller -n kube-system --show-labels
    ```
    {: pre}

    Na saída de exemplo a seguir, o valor do rótulo é `ingress-nginx`:
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

5. Usando o ID de ALB que você obteve na etapa 1, abra o serviço de balanceador de carga que expõe o ALB.
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

6. Atualize o serviço de balanceador de carga para apontar para a sua implementação customizada do Ingress. Em `spec/selector`, remova o ID de ALB do rótulo `app` e inclua o rótulo para seu próprio controlador de ingresso que você obteve na etapa 5.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. Opcional: por padrão, o serviço de balanceador de carga permite o tráfego na porta 80 e 443. Se o seu controlador de ingresso customizado requer um conjunto diferente de portas, inclua essas portas na seção `ports`.

7. Salve e feche o arquivo de configuração. A saída é semelhante à seguinte:
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

8. Verifique se o `Selector` do ALB agora aponta para o seu controlador.
    ```
    kubectl describe svc < ALB_ID> -n kube-system
    ```
    {: pre}

    Saída de exemplo:
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
    ```
    {: screen}

8. Implemente quaisquer outros recursos que forem necessários para o controlador de ingresso customizado, como o configmap.

9. Se você tiver um cluster de múltiplas zonas, repita estas etapas para cada ALB.

10. Crie recursos do Ingresso para seus apps seguindo as etapas em [Expondo apps que estão dentro de seu cluster para o público](#ingress_expose_public).

Seus apps agora são expostos pelo controlador de ingresso customizado. Para restaurar a implementação do ALB fornecido pela IBM, reative o ALB. O ALB é reimplementado e o serviço de balanceador de carga é reconfigurado automaticamente para apontar para o ALB.

```
ibmcloud ks alb-configure --alb-ID <alb ID> --enable
```
{: pre}
