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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Usando o {{site.data.keyword.containerlong_notm}} com o {{site.data.keyword.Bluemix_notm}} Private
{: #hybrid_iks_icp}

Se você tiver uma conta {{site.data.keyword.Bluemix}} Private, será possível usá-la com os serviços do {{site.data.keyword.Bluemix_notm}} selecionados, incluindo o {{site.data.keyword.containerlong}}. Para obter mais informações, consulte o blog em [Experiência híbrida no {{site.data.keyword.Bluemix_notm}} Private e IBM Public Cloud![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://ibm.biz/hybridJune2018).
{: shortdesc}

Você entende as  [ {{site.data.keyword.Bluemix_notm}}  ofertas ](cs_why.html#differentiation). Agora, é possível [conectar sua nuvem pública e privada](#hybrid_vpn) e [reutilizar seus pacotes privados para contêineres públicos](#hybrid_ppa_importer).

## Conectando sua nuvem pública e privada com a VPN strongSwan
{: #hybrid_vpn}

Estabeleça a conectividade de VPN entre o cluster público do Kubernetes e sua instância do {{site.data.keyword.Bluemix}} Private para permitir a comunicação bidirecional.
{: shortdesc}

1.  Crie um cluster padrão com o {{site.data.keyword.containerlong}} no {{site.data.keyword.Bluemix_notm}} Public ou use um existente. Para criar um cluster, escolha entre as opções a seguir: 
    - [Crie um cluster padrão por meio da GUI](cs_clusters.html#clusters_ui). 
    - [Crie um cluster padrão por meio da CLI](cs_clusters.html#clusters_cli). 
    - [ Use o Cloud Automation Manager (CAM) para criar um cluster usando um modelo predefinido![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/SS2L37_2.1.0.3/cam_deploy_IKS.html). Ao implementar um cluster com o CAM, o Helm tiller é instalado automaticamente para você.

2.  Em seu cluster do {{site.data.keyword.containerlong_notm}}, [siga as instruções para configurar o serviço de VPN IPSec strongSwan](cs_vpn.html#vpn_configure). 

    *  Para a  [ Etapa 2 ](cs_vpn.html#strongswan_2), observe que:

       * O `local.id ` que você configurar em seu cluster do {{site.data.keyword.containerlong_notm}} deverá corresponder ao que configurar posteriormente como o `remote.id` em seu cluster do {{site.data.keyword.Bluemix}} Private. 
       * O `remote.id` que você configurar em seu cluster do {{site.data.keyword.containerlong_notm}} deverá corresponder ao que configurar posteriormente como o `local.id` em seu cluster do {{site.data.keyword.Bluemix}} Private.
       * O `preshared.secret` que você configurar em seu cluster do {{site.data.keyword.containerlong_notm}} deverá corresponder ao que configurar posteriormente como o `preshared.secret` em seu cluster do {{site.data.keyword.Bluemix}} Private.

    *  Para a [Etapa 3](cs_vpn.html#strongswan_3), configure o strongSwan para uma conexão VPN de **entrada**.

       ```
       ipsec.auto: add
       loadBalancerIP: <portable_public_IP>
       ```
       {: codeblock}

3.  Anote o endereço IP público móvel que você configurar como o `loadbalancerIP`.

    ```
    kubectl get svc vpn-strongswan
    ```
    {: pre}

4.  [Crie um cluster no {{site.data.keyword.Bluemix_notm}} Private![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/installing/installing.html).

5.  Em seu cluster do {{site.data.keyword.Bluemix_notm}} Private, implemente o serviço de VPN IPSec strongSwan.

    1.  [Conclua as soluções alternativas de VPN IPSec strongSwan ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/SS2L37_2.1.0.3/cam_strongswan.html). 

    2.  [Configure o gráfico Helm de VPN strongSwan ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/app_center/create_release.html) em seu cluster privado. 
    
        *  Nos parâmetros de configuração, configure o campo **Gateway remoto** para o valor do endereço IP público móvel que você configurar como o `loadbalancerIP` de seu cluster do {{site.data.keyword.containerlong_notm}}.
    
           ```
           Operation at startup: start
           ...
           Remote gateway: <portable_public_IP>
           ...
           ```
           {: codeblock}
    
        *  Lembre-se de que o `local.id` privado deve corresponder ao `remote.id` público, o `remote.id` privado deve corresponder ao `local.id` público e os valores `preshared.secret` para privado e público devem corresponder.
        
        Agora, é possível iniciar uma conexão do cluster do {{site.data.keyword.Bluemix_notm}} Private para o cluster do {{site.data.keyword.containerlong_notm}}.

7.  [Teste a conexão VPN](cs_vpn.html#vpn_test) entre seus clusters.

8.  Repita essas etapas para cada cluster que você deseja conectar. 


## Executando imagens do {{site.data.keyword.Bluemix_notm}} Private em contêineres públicos do Kubernetes
{: #hybrid_ppa_importer}

É possível executar produtos IBM licenciados selecionados que foram empacotados para o {{site.data.keyword.Bluemix_notm}} Private em um cluster no {{site.data.keyword.Bluemix_notm}} Public.  
{: shortdesc}

O software licenciado está disponível no [IBM Passport Advantage ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www-01.ibm.com/software/passportadvantage/index.html). Para usar esse software em um cluster no {{site.data.keyword.Bluemix_notm}} Public, deve-se fazer download do software, extrair a imagem e fazer upload da imagem para seu namespace no {{site.data.keyword.registryshort}}. Independentemente do ambiente no qual você planeja usar o software, deve-se obter a licença necessária para o produto primeiro. 

A tabela a seguir é uma visão geral de produtos disponíveis do {{site.data.keyword.Bluemix_notm}} Private que podem ser usados em seu cluster no {{site.data.keyword.Bluemix_notm}} Public.

| Nome do produto | Versão | Número de Peça |
| --- | --- | --- |
| IBM Db2 Direct Advanced Edition Server | 11,1 | CNU3TML |
| IBM Db2 Advanced Enterprise Server Edition Server | 11,1 | CNU3SML |
| IBM MQ Advanced | 9.0.5 | CNU1VML |
| IBM WebSphere Application Server Liberty | 16.0.0.3 | Imagem do Docker Hub |
{: caption="Tabela. Produtos suportados do {{site.data.keyword.Bluemix_notm}} Private para serem usados no {{site.data.keyword.Bluemix_notm}} Public." caption-side="top"}

Antes de iniciar: 
- [Instale o plug-in da CLI do {{site.data.keyword.registryshort}} (`ibmcloud cr`)](/docs/services/Registry/registry_setup_cli_namespace.html#registry_cli_install). 
- [Configure um namespace no {{site.data.keyword.registryshort}}](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add) ou recupere seu namespace existente executando `ibmcloud cr namespaces`. 
- [Destine a sua CLI `kubectl` para o seu cluster](/docs/containers/cs_cli_install.html#cs_cli_configure). 
- [Instale a CLI do Helm e configure o tiller em seu cluster](/docs/containers/cs_integrations.html#helm). 

Para implementar uma imagem do {{site.data.keyword.Bluemix_notm}} Private em um cluster no {{site.data.keyword.Bluemix_notm}} Public:

1.  Siga as etapas na [documentação do {{site.data.keyword.registryshort}}](/docs/services/Registry/ts_index.html#ts_ppa) para fazer download do software licenciado por meio do IBM Passport Advantage, envie a imagem por push para seu namespace e instale o gráfico Helm em seu cluster. 

    ** Para o IBM WebSphere Application Server Liberty **:
    
    1.  Em vez de obter a imagem por meio do IBM Passport Advantage, use a [imagem do Docker Hub ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://hub.docker.com/_/websphere-liberty/). Para obter instruções sobre como obter uma licença de produção, consulte [Fazendo upgrade da imagem do Docker Hub para uma imagem de produção![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/WASdev/ci.docker/tree/master/ga/production-upgrade).
    
    2.  Siga as [instruções do gráfico Helm do Liberty![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/rwlp_icp_helm.html). 

2.  Verifique se o **STATUS** do gráfico Helm mostra `DEPLOYED`. Se não, aguarde alguns minutos e, em seguida, tente novamente.
    ```
    helm status <helm_chart_name>
    ```
    {: pre}
   
3.  Consulte a documentação específica do produto para obter mais informações sobre como configurar e usar o produto com seu cluster. 

    - [IBM Db2 Direct Advanced Edition Server ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.licensing.doc/doc/c0070181.html) 
    - [IBM MQ Advanced ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.0.0/com.ibm.mq.helphome.v90.doc/WelcomePagev9r0.html)
    - [IBM WebSphere Application Server Liberty ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/as_ditamaps/was900_welcome_liberty.html)
