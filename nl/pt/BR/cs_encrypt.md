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


# Protegendo informações sensíveis em seu cluster
{: #encryption}

Por padrão, seu cluster do {{site.data.keyword.containerlong}} usa discos criptografados para armazenar informações, como configurações em `etcd` ou o sistema de arquivos de contêiner que é executado nos discos secundários do nó do trabalhador. Ao implementar seu app, não armazene informações confidenciais, como credenciais ou chaves, no arquivo de configuração YAML, configmaps ou scripts. Em vez disso, use [Segredos do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/secret/). Também é possível criptografar dados em segredos do Kubernetes para evitar que usuários não autorizados acessem informações confidenciais do cluster.
{: shortdesc}

Para obter mais informações sobre como proteger seu cluster, veja [Segurança para o {{site.data.keyword.containerlong_notm}}](cs_secure.html#security).



## Entendendo Quando Usar Segredos
{: #secrets}

Segredos do Kubernetes são uma maneira segura para armazenar informação confidencial, como nomes de usuário, senhas ou chaves. Se você precisar de informações confidenciais criptografadas, [ative o {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) para criptografar os segredos. Para obter mais informações sobre o que é possível armazenar em segredos, consulte a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/secret/).
{:shortdesc}

Revise as tarefas a seguir que requerem segredos.

### Incluindo um serviço em um cluster
{: #secrets_service}

Quando você liga um serviço a um cluster, não é necessário criar um segredo para armazenar suas credenciais de serviço. Um segredo é criado automaticamente para você. Para obter mais informações, consulte [Incluindo serviços do Cloud Foundry em clusters](cs_integrations.html#adding_cluster).

### Criptografando o tráfego para seus apps com segredos do TLS
{: #secrets_tls}

O ALB faz o balanceamento de carga do tráfego de rede HTTP para os apps no cluster. Para também balancear a carga de conexões HTTPS recebidas, será possível configurar o ALB para decriptografar o tráfego de rede e encaminhar a solicitação decriptografada para os apps expostos no cluster. Para obter mais informações, veja a [documentação de configuração do Ingress](cs_ingress.html#public_inside_3).

Além disso, se você tiver apps que requerem o protocolo HTTPS e precisar que o tráfego permaneça criptografado, será possível usar segredos de autenticação unidirecional ou mútua com a anotação `ssl-services`. Para obter mais informações, veja a [documentação de anotações do Ingress](cs_annotations.html#ssl-services).

### Acessando seu registro com credenciais armazenadas em um `imagePullSecret` do Kubernetes
{: #imagepullsecret}

Ao criar um cluster, os segredos para suas credenciais do {{site.data.keyword.registrylong}} são criados automaticamente no namespace do Kubernetes `default`. No entanto, deve-se [criar seu próprio imagePullSecret para seu cluster](cs_images.html#other) se desejar implementar um contêiner nas situações a seguir.
* Em uma imagem em seu registro do {{site.data.keyword.registryshort_notm}} para um namespace do Kubernetes diferente de `default`.
* Em uma imagem em seu registro do {{site.data.keyword.registryshort_notm}} que está armazenada em uma região do {{site.data.keyword.Bluemix_notm}} ou em uma conta do {{site.data.keyword.Bluemix_notm}} diferente.
* Em uma imagem que é armazenada em uma conta do {{site.data.keyword.Bluemix_notm}} Dedicated.
* Em uma imagem que é armazenada em um registro privado externo.

<br />


## Criptografando segredos do Kubernetes usando  {{site.data.keyword.keymanagementserviceshort}}
{: #keyprotect}

É possível criptografar seus segredos do Kubernetes usando o [{{site.data.keyword.keymanagementservicefull}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](/docs/services/key-protect/index.html#getting-started-with-key-protect) como um [provedor de serviço de gerenciamento de chave (KMS) do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) em seu cluster. O provedor KMS é um recurso alfa no Kubernetes para as versões 1.10 e 1.11.
{: shortdesc}

Por padrão, os segredos do Kubernetes são armazenados em um disco criptografado no componente `etcd` do mestre do Kubernetes gerenciado pela IBM. Os nós do trabalhador também têm discos secundários que são criptografados por chaves LUKS gerenciadas pela IBM que são armazenadas como segredos no cluster. Quando você ativa o {{site.data.keyword.keymanagementserviceshort}} em seu cluster, sua própria chave raiz é usada para criptografar segredos do Kubernetes, incluindo os segredos do LUKS. Você obtém mais controle sobre seus dados sensíveis criptografando os segredos com sua chave raiz. O uso de sua própria criptografia inclui uma camada de segurança para seus segredos do Kubernetes e fornece um controle mais granular de quem pode acessar informações confidenciais do cluster. Se você precisar remover irreversivelmente o acesso a seus segredos, será possível excluir a chave raiz.

**Importante**: se você excluir a chave raiz em sua instância do {{site.data.keyword.keymanagementserviceshort}}, não será possível acessar ou remover os dados dos segredos em seu cluster posteriormente.

Antes de iniciar:
* [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).
* Verifique se o cluster executa o Kubernetes versão 1.10.8_1524, 1.11.3_1521 ou mais recente, executando `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>`  e verificando o campo  ** Versão ** .
* Verifique se você tem [permissões de **Administrador**](cs_users.html#access_policies) para concluir estas etapas.
* Certifique-se de que a chave API que está configurada para a região em que seu cluster está tenha autorização para usar o Key Protect. Para verificar o proprietário da chave API cujas credenciais estão armazenadas para a região, execute `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`.

Para ativar o {{site.data.keyword.keymanagementserviceshort}} ou para atualizar a instância ou a chave raiz que criptografa segredos no cluster:

1.  [ Crie uma  {{site.data.keyword.keymanagementserviceshort}}  instância ](/docs/services/key-protect/provision.html#provision).

2.  Obtenha o ID da instância de serviço.

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [ Crie uma chave raiz ](/docs/services/key-protect/create-root-keys.html#create-root-keys). Por padrão, a chave raiz é criada sem uma data de expiração.

    É necessário configurar uma data de expiração para obedecer às políticas de segurança interna? [Crie a chave raiz usando a API](/docs/services/key-protect/create-root-keys.html#api) e inclua o parâmetro `expirationDate`. **Importante**: antes que sua chave raiz expire, deve-se repetir estas etapas para atualizar seu cluster para usar uma nova chave raiz. Caso contrário, não será possível decriptografar seus segredos.
    {: tip}

4.  Anote a  [ chave raiz  ** ID ** ](/docs/services/key-protect/view-keys.html#gui).

5.  Obtenha o  [ {{site.data.keyword.keymanagementserviceshort}}  terminal ](/docs/services/key-protect/regions.html#endpoints)  de sua instância.

6.  Obtenha o nome do cluster para o qual você deseja ativar o {{site.data.keyword.keymanagementserviceshort}}.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  Ative  {{site.data.keyword.keymanagementserviceshort}}  em seu cluster. Preencha as sinalizações com as informações que você recuperou anteriormente.

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

Depois que o {{site.data.keyword.keymanagementserviceshort}} é ativado no cluster, os segredos existentes e os novos segredos criados no cluster são criptografados automaticamente usando a sua chave raiz do {{site.data.keyword.keymanagementserviceshort}}. É possível girar sua chave a qualquer momento, repetindo estas etapas com um novo ID de chave raiz.
