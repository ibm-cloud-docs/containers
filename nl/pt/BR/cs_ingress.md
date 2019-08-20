---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

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
{:preview: .preview}



# Configurando o Ingress
{: #ingress}

Exponha múltiplos apps em seu cluster do Kubernetes criando recursos de Ingresso que são gerenciados pelo balanceador de carga de aplicativo fornecido pela IBM no {{site.data.keyword.containerlong}}.
{:shortdesc}

## YAMLs de amostra
{: #sample_ingress}

Use esses arquivos YAML de amostra para começar rapidamente com a especificação do recurso Ingress.
{: shortdesc}

**Recurso do Ingress para expor publicamente um app**</br>

Você já concluiu o seguinte?
- Implementar app
- Criar serviço de app
- Selecione o nome de domínio e o segredo do TLS

É possível usar o YAML de implementação a seguir para criar um recurso Ingress:

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingressresource
spec:
  tls:
  - hosts:
    - <domain>
    secretName: <tls_secret_name>
  rules:
  - host: <domain>
    http:
      paths:
      - path: /<app1_path>
        backend:
          serviceName: <app1_service>
          servicePort: 80
      - path: /<app2_path>
        backend:
          serviceName: <app2_service>
          servicePort: 80
```
{: codeblock}

</br>

**Recurso do Ingress para expor privadamente um app**</br>

Você já concluiu o seguinte?
- Ativar ALB privado
- Implementar app
- Criar serviço de app
- Registrar nome de domínio customizado e segredo do TLS

É possível usar o YAML de implementação a seguir para criar um recurso Ingress:

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingressresource
  annotations:
    ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
spec:
  tls:
  - hosts:
    - <domain>
    secretName: <tls_secret_name>
  rules:
  - host: <domain>
    http:
      paths:
      - path: /<app1_path>
        backend:
          serviceName: <app1_service>
          servicePort: 80
      - path: /<app2_path>
        backend:
          serviceName: <app2_service>
          servicePort: 80
```
{: codeblock}

<br />


## Pré-requisitos
{: #config_prereqs}

Antes de começar com o Ingresso, revise os pré-requisitos a seguir.
{:shortdesc}

**Pré-requisitos para todas as configurações de Ingresso:**
- O Ingresso está disponível somente para clusters padrão e requer pelo menos dois nós do trabalhador por zona para assegurar alta disponibilidade e que as atualizações periódicas sejam aplicadas. Se você tiver apenas um trabalhador em uma zona, o ALB não poderá receber atualizações automáticas. Quando as atualizações automáticas são apresentadas aos pods do ALB, o pod é recarregado. No entanto, os pods do ALB possuem regras de antiafinidade para assegurar que apenas um pod seja planejado para cada nó do trabalhador para alta disponibilidade. Como há apenas um pod do ALB em um trabalhador, o pod não é reiniciado para que o tráfego não seja interrompido. O pod do ALB somente será atualizado para a versão mais recente quando você excluir o pod antigo manualmente para que o novo e atualizado possa ser planejado.
- A configuração do Ingress requer as seguintes [funções do {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform):
    - Função de plataforma ** Administrador **  para o cluster
    - Função de serviço ** Manager **  em todos os namespaces

**Pré-requisitos para usar o Ingresso em clusters de múltiplas zonas**:
 - Se você restringir o tráfego de rede para [nós de trabalhador de borda](/docs/containers?topic=containers-edge), pelo menos dois nós do trabalhador de borda deverão ser ativados em cada zona para a alta disponibilidade dos pods do Ingress. [Crie um conjunto de trabalhadores do nó de borda](/docs/containers?topic=containers-add_workers#add_pool) que abranja todas as zonas em seu cluster e tenha pelo menos dois nós do trabalhador por zona.
 - Se você tiver múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou em um cluster multizona, você deverá ativar um [Virtual Router Function (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) para sua conta de infraestrutura do IBM Cloud para que os nós do trabalhador possam se comunicar entre si na rede privada. Para ativar o VRF, [entre em contato com o seu representante de conta de infraestrutura do IBM Cloud](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Para verificar se um VRF já está ativado, use o comando `ibmcloud account show`. Se não for possível ou você não desejar ativar o VRF, ative o [VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Para executar essa ação, você precisa da [permissão de infraestrutura](/docs/containers?topic=containers-users#infra_access) **Rede > Gerenciar a rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se a ampliação de VLAN já está ativada, use o [comando](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
 - Se uma zona falhar, você poderá ver falhas intermitentes em solicitações para o ALB do Ingress nessa zona.

<br />


## Planejando a rede para um único ou múltiplos namespaces
{: #multiple_namespaces}

Um recurso Ingress é necessário por namespace no qual você tem apps que deseja expor.
{:shortdesc}

### Todos os apps estão em um namespace
{: #one-ns}

Se os apps em seu cluster estão todos no mesmo namespace, um recurso Ingress é necessário para definir as regras de roteamento para os apps que são expostos lá. Por exemplo, se você tem o `app1` e o `app2` expostos por serviços em um espaço de desenvolvimento, é possível criar um recurso de Ingresso no namespace. O recurso especifica `domain.net` como o host e registra os caminhos em que cada app atende com `domain.net`.
{: shortdesc}

<img src="images/cs_ingress_single_ns.png" width="270" alt="Um recurso é necessário por namespace." style="width:270px; border-style: none"/>

### Os apps estão em múltiplos namespaces
{: #multi-ns}

Se os apps em seu cluster estão em namespaces diferentes, deve-se criar um recurso por namespace para definir regras para os apps que são expostos lá.
{: shortdesc}

No entanto, é possível definir um nome do host em apenas um recurso. Não é possível definir o mesmo nome do host em múltiplos recursos. Para registrar múltiplos recursos do Ingress com o mesmo nome do host, deve-se usar um domínio curinga. Quando um domínio curinga, como `*.domain.net`, é registrado, vários subdomínios podem ser todos resolvidos para o mesmo host. Em seguida, é possível criar um recurso de Ingresso em cada namespace e especificar um subdomínio diferente em cada recurso de Ingresso.

Por exemplo, considere o seguinte cenário:
* Você tem duas versões do mesmo app, `app1` e `app3`, para propósitos de teste.
* Você implementa os apps em dois namespaces diferentes dentro do mesmo cluster: `app1` no namespace de desenvolvimento e `app3` no namespace temporário.

Para usar o mesmo ALB do cluster para gerenciar o tráfego para esses apps, você cria os serviços e recursos a seguir:
* Um serviço do Kubernetes no namespace de desenvolvimento para expor `app1`.
* Um recurso Ingresso no namespace de desenvolvimento que especifica o host como `dev.domain.net`.
* Um serviço do Kubernetes no namespace temporário para expor `app3`.
* Um recurso Ingresso no namespace de preparação que especifica o host como `stage.domain.net`.
</br>
<img src="images/cs_ingress_multi_ns.png" width="625" alt="Dentro de um namespace, use subdomínios em um ou múltiplos recursos" style="width:625px; border-style: none"/>


Agora, ambas as URLs são resolvidas para o mesmo domínio e são, portanto, ambas atendidas pelo mesmo ALB. No entanto, como o recurso no namespace de preparação é registrado com o subdomínio `stage`, o ALB do Ingress roteia corretamente as solicitações da URL `stage.domain.net/app3` para somente `app3`.

{: #wildcard_tls}
O IBM fornecido pelo subdomínio de Ingresso curinga, `*.<cluster_name>.<region>.containers.appdomain.cloud`, é registrado por padrão para seu cluster. O certificado TLS fornecido pela IBM é um certificado curinga e pode ser usado para o subdomínio curinga. Se deseja usar um domínio customizado, deve-se registrá-lo como um domínio curinga, como `*.custom_domain.net`. Para usar o TLS, deve-se obter um certificado curinga.
{: note}

### Vários domínios dentro de um namespace
{: #multi-domains}

Em um namespace individual, é possível usar um domínio para acessar todos os apps no namespace. Se você deseja usar domínios diferentes para os apps dentro de um namespace individual, use um domínio curinga. Quando um domínio curinga como `*.mycluster.us-south.containers.appdomain.cloud` for registrado, múltiplos subdomínios serão todos resolvidos no mesmo host. Em seguida, é possível usar um recurso para especificar múltiplos hosts de subdomínio dentro desse recurso. Como alternativa, é possível criar múltiplos recursos de Ingresso no namespace e especificar um subdomínio diferente em cada recurso de Ingresso.
{: shortdesc}

<img src="images/cs_ingress_single_ns_multi_subs.png" width="625" alt="Um recurso é necessário por namespace." style="width:625px; border-style: none"/>

O IBM fornecido pelo subdomínio de Ingresso curinga, `*.<cluster_name>.<region>.containers.appdomain.cloud`, é registrado por padrão para seu cluster. O certificado TLS fornecido pela IBM é um certificado curinga e pode ser usado para o subdomínio curinga. Se deseja usar um domínio customizado, deve-se registrá-lo como um domínio curinga, como `*.custom_domain.net`. Para usar o TLS, deve-se obter um certificado curinga.
{: note}

<br />


## Expondo apps que estão dentro de seu cluster para o público
{: #ingress_expose_public}

Exponha apps que estão dentro de seu cluster para o público usando o ALB de Ingresso público.
{:shortdesc}

Antes de iniciar:

* Revise o Ingresso [pré-requisitos](#config_prereqs).
* [Efetue login em sua conta. Se aplicável, direcione o grupo de recursos apropriado. Configure o contexto para o seu cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

### Etapa 1: Implementar apps e criar serviços de app
{: #public_inside_1}

Inicie implementando seus apps e criando serviços do Kubernetes para expô-los.
{: shortdesc}

1.  [Implemente o seu app no cluster](/docs/containers?topic=containers-app#app_cli). Assegure-se de incluir um rótulo em sua implementação na seção de metadados de seu arquivo de configuração, como `app: code`. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução para que os pods possam ser incluídos no balanceamento de carga do Ingress.

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
          <td>Insira a chave de etiqueta (<em>&lt;selector_key&gt;</em>) e o par de valores (<em>&lt;selector_value&gt;</em>) que você deseja usar para destinar os pods nos quais o seu app é executado. Para destinar seus pods e incluí-los no balanceamento de carga de serviço, assegure-se de que o <em>&lt;selector_key&gt;</em> e o <em>&lt;selector_value&gt;</em> sejam os mesmos que o par chave/valor na seção <code>spec.template.metadata.labels</code> de seu YAML de implementação.</td>
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


### Etapa 2: Selecionar um domínio de app
{: #public_inside_2}

Ao configurar o ALB público, você escolhe o domínio por meio do qual seus apps serão acessíveis.
{: shortdesc}

É possível usar o domínio fornecido pela IBM, como `mycluster-12345.us-south.containers.appdomain.cloud/myapp`, para acessar seu app na Internet. Para usar um domínio customizado em vez disso, é possível configurar um registro CNAME para mapear seu domínio customizado para o domínio fornecido pela IBM ou configurar um registro A com seu provedor DNS que usa o endereço IP público do ALB.

** Para usar o domínio do Ingress fornecido pela IBM: **

Obtenha o domínio fornecido pela IBM. Substitua `<cluster_name_or_ID>` pelo nome do cluster no qual o aplicativo está implementado.
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

Saída de exemplo:
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}

** Para usar um domínio customizado: **
1.    Crie um domínio customizado. Para registrar seu domínio customizado, trabalhe com seu provedor do Domain Name Service (DNS) ou com o [{{site.data.keyword.cloud_notm}} DNS](/docs/infrastructure/dns?topic=dns-getting-started).
      * Se os apps que você deseja que o Ingress exponha estiverem em namespaces diferentes em um cluster, registre o domínio customizado como um domínio curinga, como `*.custom_domain.net`.

2.  Configure seu domínio para rotear o tráfego de rede recebido para o ALB fornecido pela IBM. Escolha entre estas opções:
    -   Defina um alias para seu domínio customizado especificando o domínio fornecido pela IBM como um registro de Nome Canônico (CNAME). Para localizar o domínio do Ingress fornecido pela IBM, execute `ibmcloud ks cluster-get --cluster <cluster_name>` e procure o campo **Subdomínio do Ingress**. O uso de um CNAME é preferencial porque a IBM fornece verificações de funcionamento automáticas no subdomínio IBM e remove os IPs com falha da resposta de DNS.
    -   Mapeie o seu domínio customizado para o endereço IP público móvel do ALB fornecido pela IBM incluindo o endereço IP como um registro A. Para localizar o endereço IP público móvel do ALB, execute `ibmcloud ks alb-get --albID  <public_alb_ID>`.

### Etapa 3: Selecionar finalização de TLS
{: #public_inside_3}

Depois de escolher o domínio do app, você escolhe se deseja usar a finalização do TLS.
{: shortdesc}

O ALB faz o balanceamento de carga do tráfego de rede HTTP para os apps no cluster. Para também balancear a carga de conexões HTTPS recebidas, será possível configurar o ALB para decriptografar o tráfego de rede e encaminhar a solicitação decriptografada para os apps expostos no cluster.

* Se você usar o subdomínio do Ingress fornecido pela IBM, será possível usar o certificado do TLS fornecido pela IBM. Os certificados do TLS fornecidos pela IBM são assinados por LetsEncrypt e são totalmente gerenciados pela IBM. Os certificados expiram a cada 90 dias e são renovados automaticamente 37 dias antes de expirarem. Para obter mais informações sobre a certificação de TLS curinga, consulte [esta nota](#wildcard_tls).
* Se você usar um domínio customizado, será possível usar o seu próprio certificado do TLS para gerenciar a rescisão do TLS. O ALB primeiro verifica se há um segredo no namespace no qual o app está, em seguida, em `default` e, finalmente, em `ibm-cert-store`. Se você tiver apps apenas em um namespace, será possível importar ou criar um segredo do TLS para o certificado nesse mesmo namespace. Se você tiver apps em vários namespaces, importe ou crie um segredo do TLS para o certificado no namespace `default` para que o ALB possa acessar e usar o certificado em cada namespace. Nos recursos Ingress que você define para cada namespace, especifique o nome do segredo que está no namespace padrão. Para obter mais informações sobre a certificação de TLS curinga, consulte [esta nota](#wildcard_tls). **Nota**: os certificados TLS que contêm chaves pré-compartilhadas (TLS-PSK) não são suportados.

**Se você usar o domínio do Ingress fornecido pela IBM:**

Obtenha o segredo do TLS fornecido pela IBM para seu cluster.
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

Saída de exemplo:
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}
</br>

** Se você usar um domínio customizado: **

Se um certificado TLS é armazenado no {{site.data.keyword.cloudcerts_long_notm}} que você deseja usar, é possível importar seu segredo associado para o cluster executando o comando a seguir:

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

Certifique-se de que você não crie o segredo com o mesmo nome que o segredo de Ingress fornecido pela IBM. É possível obter o nome do segredo do Ingress fornecido pela IBM executando `ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress`.
{: note}

Quando você importa um certificado com esse comando, o segredo do certificado é criado em um namespace chamado `ibm-cert-store`. Uma referência a esse segredo é, então, criada no namespace `default`, que qualquer recurso Ingress em qualquer namespace pode acessar. Quando o ALB está processando solicitações, ele segue essa referência para selecionar e usar o segredo do certificado por meio do namespace `ibm-cert-store`.

</br>

Se você não tiver um certificado TLS pronto, siga estas etapas:
1. Gere um certificado de autoridade de certificação (CA) e a chave por meio do provedor de certificado. Se você tiver seu próprio domínio, compre um certificado TLS oficial para seu domínio. Certifique-se de que o [CN ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://support.dnsimple.com/articles/what-is-common-name/) seja diferente para cada certificado.
2. Converta o certificado e a chave na base 64.
   1. Codifique o certificado e a chave na base 64 e salve o valor codificado na base 64 em um novo arquivo.
      ```
      openssl base64 -in tls.key -out tls.key.base64
      ```
      {: pre}

   2. Visualize o valor codificado com base 64 para seu certificado e chave.
      ```
      cat tls.key.base64
      ```
      {: pre}

3. Crie um arquivo YAML secreto usando o certificado e a chave.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. Crie o certificado como um segredo do Kubernetes.
     ```
     kubectl apply -f ssl-my-test
     ```
     {: pre}
     Certifique-se de que você não crie o segredo com o mesmo nome que o segredo de Ingress fornecido pela IBM. É possível obter o nome do segredo do Ingress fornecido pela IBM executando `ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress`.
     {: note}


### Etapa 4: Criar o Recurso do Ingresso
{: #public_inside_4}

Os recursos do Ingress definem as regras de roteamento que o ALB usa para rotear tráfego para seu serviço de app.
{: shortdesc}

Se o seu cluster tiver múltiplos namespaces em que os apps são expostos, um recurso do Ingress será necessário por namespace. No entanto, cada namespace deve usar um host diferente. Deve-se registrar um domínio curinga e especificar um subdomínio diferente em cada recurso. Para obter mais informações, veja [Planejando a rede para namespaces únicos ou múltiplos](#multiple_namespaces).
{: note}

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
      - System z:
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
    <td><code> tls.hosts </code></td>
    <td>Para usar o TLS, substitua <em>&lt;domain&gt;</em> pelo subdomínio do Ingress fornecido pela IBM ou seu domínio customizado.

    </br></br>
    <strong>Nota:</strong><ul><li>Se os seus apps forem expostos por serviços em namespaces diferentes em um cluster, anexe um subdomínio curinga ao início do domínio, como `subdomain1.custom_domain.net` ou `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Use um subdomínio exclusivo para cada recurso criado no cluster.</li><li>Não usar &ast; para o host ou deixar a propriedade do host vazia para evitar falhas durante a criação do Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code> tls.secretName </code></td>
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
    <td>Substitua <em>&lt;app_path&gt;</em> por uma barra ou pelo caminho em que seu app está atendendo. O caminho é anexado ao domínio fornecido pela IBM ou ao seu domínio customizado para criar uma rota exclusiva para o app. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço. Em seguida, o serviço encaminha o tráfego aos pods nos quais o aplicativo está sendo executado.
    </br></br>
    Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app. Exemplos: <ul><li>Para <code>http://domain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://domain/app1_path</code>, insira <code>/app1_path</code> como o caminho.</li></ul>
    </br>
    <strong>Dica:</strong> para configurar o Ingress para atender em um caminho diferente do caminho no qual seu app atende, será possível usar [gravar novamente a anotação](/docs/containers?topic=containers-ingress_annotation#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Substitua <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em> e assim por diante, pelo nome dos serviços criados para expor seus apps. Se os seus apps forem expostos por serviços em namespaces diferentes no cluster, inclua apenas serviços de app que estejam no mesmo namespace. Deve-se criar um recurso do Ingress para cada namespace no qual você tem aplicativos que deseja expor.</td>
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

### Etapa 5: acessar seu app por meio da Internet
{: #public_inside_5}

Em um navegador da web, insira a URL do serviço de app a ser acessado.
{: shortdesc}

```
https://<domain>/<app1_path>
```
{: codeblock}

Se tiver exposto múltiplos apps, acesse-os mudando o caminho anexado à URL.

```
https://<domain>/<app2_path>
```
{: codeblock}

Se você usar um domínio curinga para expor apps em namespaces diferentes, acesse esses apps com seus próprios subdomínios.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


Tendo problemas de conexão com seu app por meio do Ingress? Tente  [ Depurging Ingress ](/docs/containers?topic=containers-cs_troubleshoot_debug_ingress).
{: tip}

<br />


## Expondo apps que estão fora de seu cluster para o público
{: #external_endpoint}

Expor apps que estão fora de seu cluster para o público, incluindo-os no balanceamento de carga do ALB de Ingresso público. As solicitações públicas recebidas no domínio customizado ou fornecido pela IBM são encaminhadas automaticamente para o app externo.
{: shortdesc}

Antes de iniciar:

* Revise o Ingresso [pré-requisitos](#config_prereqs).
* Assegure-se de que o app externo que você deseja incluir no balanceamento de carga do cluster possa ser acessado usando um endereço IP público.
* [Efetue login em sua conta. Se aplicável, direcione o grupo de recursos apropriado. Configure o contexto para o seu cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Para expor os apps que estão fora de seu cluster para o público:

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
        <td><code>metadata.name</code></td>
        <td>Substitua <em><code>&lt;myexternalservice&gt;</code></em> por um nome de seu serviço.<p>Saiba mais sobre [como proteger suas informações pessoais](/docs/containers?topic=containers-security#pi) quando trabalhar com recursos do Kubernetes.</p></td>
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
          name: myexternalservice
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
        <td>Substitua <em><code>&lt;myexternalendpoint&gt;</code></em> pelo nome do serviço do Kubernetes que você criou anteriormente.</td>
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

3. Continue com as etapas em "Expondo apps que estão dentro de seu cluster para o público", [Etapa 2: selecionar um domínio de app](#public_inside_2).

<br />


## Expondo apps para uma rede privada
{: #ingress_expose_private}

Exponha apps para uma rede privada usando o ALB de Ingresso privado.
{:shortdesc}

Para usar um ALB privado, deve-se primeiro ativar o ALB privado. Como os clusters somente de VLAN privada não são designados a um subdomínio do Ingress fornecido pela IBM, nenhum segredo do Ingress é criado durante a configuração do cluster. Para expor seus apps à rede privada, deve-se registrar seu ALB com um domínio customizado e, opcionalmente, importar seu próprio certificado TLS.

Antes de iniciar:
* Revise o Ingresso [pré-requisitos](#config_prereqs).
* Revise as opções para planejar o acesso privado aos apps quando os nós do trabalhador forem conectados a [uma VLAN pública e uma privada](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) ou a [somente a uma VLAN privada](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan).
    * Se os seus nós do trabalhador estão conectados somente a uma VLAN privada, deve-se configurar um [serviço do DNS do que esteja disponível na rede privada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

### Etapa 1: Implementar apps e criar serviços de app
{: #private_1}

Inicie implementando seus apps e criando serviços do Kubernetes para expô-los.
{: shortdesc}

1.  [Implemente o seu app no cluster](/docs/containers?topic=containers-app#app_cli). Assegure-se de incluir um rótulo em sua implementação na seção de metadados de seu arquivo de configuração, como `app: code`. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução para que os pods possam ser incluídos no balanceamento de carga do Ingress.

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
          <td>Insira a chave de etiqueta (<em>&lt;selector_key&gt;</em>) e o par de valores (<em>&lt;selector_value&gt;</em>) que você deseja usar para destinar os pods nos quais o seu app é executado. Para destinar seus pods e incluí-los no balanceamento de carga de serviço, assegure-se de que o <em>&lt;selector_key&gt;</em> e o <em>&lt;selector_value&gt;</em> sejam os mesmos que o par chave/valor na seção <code>spec.template.metadata.labels</code> de seu YAML de implementação.</td>
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

Se você usou a sinalização `--no-subnet` quando criou o cluster, deverá incluir uma sub-rede privada móvel ou uma sub-rede gerenciada pelo usuário antes de ser possível ativar o ALB privado. Para obter mais informações, veja [Solicitando sub-redes adicionais para seu cluster](/docs/containers?topic=containers-subnets#request).
{: note}

**Para ativar um ALB privado padrão usando o endereço IP privado móvel fornecido pela IBM pré-designado:**

1. Obtenha o ID do ALB privado padrão que você deseja ativar. Substitua <em>&lt;cluster_name&gt;</em> pelo nome do cluster no qual o app que você deseja expor está implementado.

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    O campo **Status** para os ALBs privados é _disabled_.
    ```
    ALB ID Enabled Status Type ALB IP Zone Build ALB VLAN ID private-crdf253b6025d64944ab99ed63bb4567b6-alb1 false disabled private - dal10 ingress:411/ingress-auth:315 2234947 public-crdf253b6025d64944ab99ed63bb4567b6-alb1 true enabled public 169.xx.xxx.xxx dal10 ingress:411/ingress-auth:315 2234945
    ```
    {: screen}
    Em clusters de múltiplas zonas, o sufixo numerado no ID de ALB indica a ordem em que o ALB foi incluído.
    * Por exemplo, o sufixo `-alb1` no ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` indica que ele foi o primeiro ALB privado padrão criado. Ele existe na zona em que você criou o cluster. No exemplo anterior, o cluster foi criado em `dal10`.
    * O sufixo `-alb2` no ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` indica que ele foi o segundo ALB privado padrão criado. Ele existe na segunda zona que você incluiu em seu cluster. No exemplo anterior, a segunda zona é `dal12`.

2. Ative o ALB privado. Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID de ALB privado da saída na etapa anterior.

   ```
   ibmcloud ks alb-configure -- albID < private_ALB_ID> -- enable
   ```
   {: pre}

3. **Clusters multizona**: para alta disponibilidade, repita as etapas anteriores para o ALB privado em cada zona.

<br>
**Para ativar o ALB privado usando seu próprio endereço IP privado móvel:**

1. Liste os ALBs disponíveis em seu cluster. Anote o ID de um ALB privado e a zona na qual está o ALB.

 ```
 ibmcloud ks albs --cluster <cluster_name>
 ```
 {: pre}

 O campo **Status** para o ALB privado está _desativado_.
 ```
 ALB ID Enabled Status Type ALB IP Zone Build ALB VLAN ID private-crdf253b6025d64944ab99ed63bb4567b6-alb1 false disabled private - dal10 ingress:411/ingress-auth:315 2234947 public-crdf253b6025d64944ab99ed63bb4567b6-alb1 true enabled public 169.xx.xxx.xxx dal10 ingress:411/ingress-auth:315 2234945
 ```
 {: screen}

 2. Configure a sub-rede gerenciada pelo usuário de seu endereço IP escolhido para rotear o tráfego na VLAN privada nessa zona.

   ```
   ibmcloud ks cluster-user-subnet-add --cluster <cluster_name> --subnet-cidr <subnet_CIDR> --private-vlan <private_VLAN>
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
   <td>O ID da VLAN privada. Este valor é obrigatório. O ID deve ser para uma VLAN privada na mesma zona que o ALB privado. Para ver as VLANs privadas para essa zona na qual estão os nós do trabalhador, execute `ibmcloud ks workers --cluster <cluster_name_or_ID>` e anote o ID de um nó do trabalhador nessa zona. Usando o ID do nó do trabalhador, execute `ibmcloud ks worker-get --worker <worker_id> --cluster <cluster_name_or_id>`. Na saída, anote o ID da **VLAN privada**.</td>
   </tr>
   </tbody></table>

3. Ative o ALB privado. Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID para o ALB privado e o <em>&lt;user_IP&gt;</em> pelo endereço IP da sub-rede gerenciada pelo usuário que você deseja usar.
   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

4. **Clusters multizona**: para alta disponibilidade, repita as etapas anteriores para o ALB privado em cada zona.

### Etapa 3: mapear seu domínio customizado
{: #private_3}

Os clusters de VLAN privada somente não são designados a um subdomínio do Ingress fornecido pela IBM. Quando você configura o ALB privado, expõe seus apps usando um domínio customizado.
{: shortdesc}

**Clusters privados de VLAN privada:**

1. Se os nós do trabalhador estiverem conectados somente a uma VLAN privada, você deverá configurar seu próprio [serviço DNS que está disponível em sua rede privada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
2. Crie um domínio customizado por meio de seu provedor DNS. Se os aplicativos que você deseja que Ingress exponham estão em namespaces diferentes em um cluster, registre o domínio customizado como um domínio curinga, como *.custom_domain.net `.
3. Usando seu serviço DNS privado, mapeie seu domínio customizado para os endereços IP privados móveis dos ALBs incluindo os endereços IP como registros A. Para localizar os endereços IP privados móveis dos ALBs, execute `ibmcloud ks alb-get --albID <private_alb_ID>` para cada ALB.

** Clusters VLAN privada e pública: **

1.    Crie um domínio customizado. Para registrar seu domínio customizado, trabalhe com seu provedor do Domain Name Service (DNS) ou com o [{{site.data.keyword.cloud_notm}} DNS](/docs/infrastructure/dns?topic=dns-getting-started).
      * Se os apps que você deseja que o Ingress exponha estiverem em namespaces diferentes em um cluster, registre o domínio customizado como um domínio curinga, como `*.custom_domain.net`.

2.  Mapeie seu domínio customizado para os endereços IP privados móveis dos ALBs incluindo os endereços IP como registros A. Para localizar os endereços IP privados móveis dos ALBs, execute `ibmcloud ks alb-get --albID <private_alb_ID>` para cada ALB.

### Etapa 4: Selecionar finalização de TLS
{: #private_4}

Depois de mapear seu domínio customizado, escolha se deseja usar a finalização do TLS.
{: shortdesc}

O ALB faz o balanceamento de carga do tráfego de rede HTTP para os apps no cluster. Para também balancear a carga de conexões HTTPS recebidas, será possível configurar o ALB para decriptografar o tráfego de rede e encaminhar a solicitação decriptografada para os apps expostos no cluster.

Como os clusters somente de VLAN privada não são designados a um domínio do Ingress fornecido pela IBM, nenhum segredo do Ingress é criado durante a configuração do cluster. É possível usar seu próprio certificado TLS para gerenciar a finalização do TLS.  O ALB primeiro verifica se há um segredo no namespace no qual o app está, em seguida, em `default` e, finalmente, em `ibm-cert-store`. Se você tiver apps apenas em um namespace, será possível importar ou criar um segredo do TLS para o certificado nesse mesmo namespace. Se você tiver apps em vários namespaces, importe ou crie um segredo do TLS para o certificado no namespace `default` para que o ALB possa acessar e usar o certificado em cada namespace. Nos recursos Ingress que você define para cada namespace, especifique o nome do segredo que está no namespace padrão. Para obter mais informações sobre a certificação de TLS curinga, consulte [esta nota](#wildcard_tls). **Nota**: os certificados TLS que contêm chaves pré-compartilhadas (TLS-PSK) não são suportados.

Se um certificado TLS é armazenado no {{site.data.keyword.cloudcerts_long_notm}} que você deseja usar, é possível importar seu segredo associado para o cluster executando o comando a seguir:

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

Quando você importa um certificado com esse comando, o segredo do certificado é criado em um namespace chamado `ibm-cert-store`. Uma referência a esse segredo é, então, criada no namespace `default`, que qualquer recurso Ingress em qualquer namespace pode acessar. Quando o ALB está processando solicitações, ele segue essa referência para selecionar e usar o segredo do certificado por meio do namespace `ibm-cert-store`.

### Etapa 5: Criar o recurso Ingress
{: #private_5}

Os recursos do Ingress definem as regras de roteamento que o ALB usa para rotear tráfego para seu serviço de app.
{: shortdesc}

Se o seu cluster tiver múltiplos namespaces em que os apps são expostos, um recurso do Ingress será necessário por namespace. No entanto, cada namespace deve usar um host diferente. Deve-se registrar um domínio curinga e especificar um subdomínio diferente em cada recurso. Para obter mais informações, veja [Planejando a rede para namespaces únicos ou múltiplos](#multiple_namespaces).
{: note}

1. Abra o seu editor preferencial e crie um arquivo de configuração do Ingress que seja denominado, por exemplo, `myingressresource.yaml`.

2.  Defina um recurso de Ingresso em seu arquivo de configuração que use o seu domínio customizado para rotear o tráfego de rede recebido para os serviços que você criou anteriormente.

    YAML de exemplo que não usa TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
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
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
    spec:
      tls:
      - System z:
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
    <td>Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID de seu ALB privado. Se você tiver um cluster multizona e múltiplos ALBs privados ativados, inclua o ID de cada ALB. Execute <code>ibmcloud ks albs -- cluster < my_cluster ></code> para localizar os IDs de ALB. Para obter mais informações sobre essa anotação de Ingresso, veja [Roteamento do balanceador de carga de aplicativo privado](/docs/containers?topic=containers-ingress_annotation#alb-id).</td>
    </tr>
    <tr>
    <td><code> tls.hosts </code></td>
    <td>Para usar o TLS, substitua <em>&lt;domain&gt;</em> por seu domínio customizado.</br></br><strong>Nota:</strong><ul><li>Se os seus apps forem expostos por serviços em namespaces diferentes em um cluster, anexe um subdomínio curinga ao início do domínio, como `subdomain1.custom_domain.net`. Use um subdomínio exclusivo para cada recurso criado no cluster.</li><li>Não usar &ast; para o host ou deixar a propriedade do host vazia para evitar falhas durante a criação do Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code> tls.secretName </code></td>
    <td>Substitua <em>&lt;tls_secret_name&gt;</em> pelo nome do segredo que você criou anteriormente e que contém o seu certificado e chave TLS customizados. Se você importou um certificado do {{site.data.keyword.cloudcerts_short}}, será possível executar <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> para ver os segredos que estiverem associados a um certificado do TLS.
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Substitua <em>&lt;domain&gt;</em> por seu domínio customizado.
    </br></br>
    <strong>Nota:</strong><ul><li>Se os seus apps forem expostos por serviços em namespaces diferentes em um cluster, anexe um subdomínio curinga ao início do domínio, como `subdomain1.custom_domain.net`. Use um subdomínio exclusivo para cada recurso criado no cluster.</li><li>Não usar &ast; para o host ou deixar a propriedade do host vazia para evitar falhas durante a criação do Ingress.</li></ul></td>
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Substitua <em>&lt;app_path&gt;</em> por uma barra ou pelo caminho em que seu app está atendendo. O caminho é anexado ao seu domínio customizado para criar uma rota exclusiva para seu app. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço. Em seguida, o serviço encaminha o tráfego aos pods nos quais o aplicativo está sendo executado.
    </br></br>
    Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app. Exemplos: <ul><li>Para <code>http://domain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://domain/app1_path</code>, insira <code>/app1_path</code> como o caminho.</li></ul>
    </br>
    <strong>Dica:</strong> para configurar o Ingress para atender em um caminho diferente do caminho no qual seu app atende, será possível usar [gravar novamente a anotação](/docs/containers?topic=containers-ingress_annotation#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Substitua <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em> e assim por diante, pelo nome dos serviços criados para expor seus apps. Se os seus apps forem expostos por serviços em namespaces diferentes no cluster, inclua apenas serviços de app que estejam no mesmo namespace. Deve-se criar um recurso do Ingress para cada namespace no qual você tem aplicativos que deseja expor.</td>
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

### Etapa 6: acessar seu app por meio de sua rede privada
{: #private_6}

1. Antes de poder acessar seu app, certifique-se de que seja possível acessar um serviço DNS.
  * VLAN pública e privada: para usar o provedor do DNS externo padrão, deve-se [configurar nós de borda com acesso público](/docs/containers?topic=containers-edge#edge) e [configurar um Virtual Router Appliance ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).
  * Apenas VLAN privada: deve-se configurar um [serviço do DNS que está disponível na rede privada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

2. De dentro de seu firewall de rede privada, insira a URL do serviço de app em um navegador da web.

```
https://<domain>/<app1_path>
```
{: codeblock}

Se tiver exposto múltiplos apps, acesse-os mudando o caminho anexado à URL.

```
https://<domain>/<app2_path>
```
{: codeblock}

Se você usar um domínio curinga para expor apps em namespaces diferentes, acesse esses apps com seus próprios subdomínios.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


Para obter um tutorial abrangente sobre como assegurar a comunicação de microsserviço-para-microsserviço em seus clusters usando o ALB privado com TLS, veja [esta postagem do blog ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).
{: tip}
