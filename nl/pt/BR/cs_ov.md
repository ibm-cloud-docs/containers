---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Sobre o {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

O {{site.data.keyword.containershort}} fornece ferramentas poderosas, combinando s tecnologias Docker e Kubernetes, uma experiência intuitiva do usuário e a segurança e o isolamento integrados para automatizar a implementação, a operação, o ajuste de escala e o monitoramento de apps conteinerizados em um cluster de hosts de cálculo.
{:shortdesc}


<br />


## Contêineres do Docker
{: #cs_ov_docker}

Docker é um projeto de software livre que foi liberado pelo dotCloud em 2013. Construído sobre os recursos da tecnologia de contêiner do Linux (LXC) existente, o Docker se tornou uma plataforma de software para construir, testar, implementar e escalar apps rapidamente. O Docker empacota o software em unidades padronizadas, chamadas de contêineres, que incluem todos os elementos que um app precisa para ser executado.
{:shortdesc}

Aprenda alguns conceitos básicos do Docker:

<dl>
<dt>Image</dt>
<dd>Uma imagem do Docker é construída usando um Dockerfile, um arquivo de texto que define como construir a imagem e quais os artefatos de construção a serem incluídos nela, tal como o app, a configuração do app e suas dependências. As imagens sempre são construídas usando outras imagens, tornando-as rápidas de serem configuradas. Deixe alguém fazer a maior parte do trabalho em uma imagem e, em seguida, ajuste-a para seu uso.</dd>
<dt>Registro</dt>
<dd>Um registro de imagem é um lugar para armazenar, recuperar e compartilhar imagens do Docker. As imagens que são armazenadas em um registro podem estar publicamente disponíveis (registro público) ou acessíveis por um pequeno grupo de usuários (registro privado). O {{site.data.keyword.containershort_notm}} oferece imagens públicas, como o ibmliberty, que podem ser usadas para criar seu primeiro app conteinerizado. Quando se trata de aplicativos corporativos, use um registro privado como aquele que é fornecido no {{site.data.keyword.Bluemix_notm}} para proteger suas imagens de serem usadas por usuários não autorizados.
</dd>
<dt>Contêiner</dt>
<dd>Cada contêiner é criado de uma imagem. Um contêiner é um app empacotado com todas as suas dependências, para que o app possa ser movido entre ambientes e ser executado sem mudanças. Ao contrário de máquinas virtuais, os contêineres não virtualizam um dispositivo, seu sistema operacional e o hardware subjacente. Somente o código de app, o tempo de execução,
as ferramentas de sistema, as bibliotecas e as configurações são empacotadas dentro do contêiner. Os contêineres são executados como processos isolados em hosts de cálculo e compartilham o sistema operacional do host e seus recursos de hardware. Essa abordagem torna um contêiner mais leve, móvel e eficiente do que
uma máquina virtual.</dd>
</dl>

### Benefícios chave do uso de contêineres
{: #container_benefits}

<dl>
<dt>Contêineres são ágeis</dt>
<dd>Os contêineres simplificam a administração do sistema, fornecendo ambientes padronizados para as implementações de desenvolvimento e de produção. Um tempo de execução leve permite aumentar e diminuir rapidamente a capacidade de implementações. Remova a complexidade do gerenciamento de diferentes plataformas de sistema operacional e suas infraestruturas subjacentes, usando contêineres para ajudá-lo a implementar e executar qualquer app em qualquer infraestrutura, de modo rápido e confiável.</dd>
<dt>Contêineres são pequenos</dt>
<dd>É possível ajustar vários contêineres na quantia de espaço que uma única máquina virtual requer.</dd>
<dt>Contêineres são móveis</dt>
<dd><ul>
  <li>Reutilize fragmentos de imagens para construir contêineres. </li>
  <li>Mova o código do app rapidamente do ambiente de preparação para o de produção.</li>
  <li>Automatize seus processos com ferramentas de entrega contínua.</li> </ul></dd>
</dl>


<br />


## Conceitos básicos do Kubernetes
{: #kubernetes_basics}

O Kubernetes foi desenvolvido pelo Google como parte do projeto Borg e entregue à comunidade de software livre
em 2014. O Kubernetes combina mais de 15 anos de pesquisa do Google na execução de uma infraestrutura conteinerizada com cargas de trabalho de produção, contribuições de software livre e ferramentas de gerenciamento de contêiner do Docker, para fornecer uma plataforma de app isolada e segura para gerenciamento de contêineres móveis, extensíveis e com capacidade de recuperação automática em caso de failovers.
{:shortdesc}

Aprenda alguns conceitos básicos do Kubernetes conforme mostrado no diagrama a seguir.

![Configuração de implementação](images/cs_app_tutorial_components1.png)

<dl>
<dt>Conta</dt>
<dd>Sua conta refere-se à sua conta do {{site.data.keyword.Bluemix_notm}}.</dd>

<dt>Grupo</dt>
<dd>Um cluster do Kubernetes consiste em uma ou mais hosts de cálculo que são chamadas nós do trabalhador. Os nós do trabalhador são gerenciados por um mestre do Kubernetes que controla e monitora centralmente todos os recursos
do Kubernetes no cluster. Então quando você implementa os recursos para um app conteinerizado, o mestre do Kubernetes decide em qual nó do trabalhador implementar esses recursos, levando em consideração os requisitos de implementação e a capacidade disponível no cluster. Os recursos do Kubernetes incluem serviços, implementações e pods.</dd>

<dt>Serviço</dt>
<dd>Um serviço é um recurso do Kubernetes que agrupa um conjunto de pods e fornece conectividade de rede a esses pods, sem expor o endereço IP privado real de cada pod. É possível
usar um serviço para tornar seu app disponível no cluster ou na Internet pública.
</dd>

<dt>Implementação</dt>
<dd>Uma implementação é um recurso do Kubernetes em que se pode especificar informações sobre outros recursos ou habilidades que são necessários para executar seu app, tais como serviços, armazenamento persistente ou anotações. Você documenta uma implementação em um arquivo YAML de configuração e, depois, aplica ao cluster. O mestre do Kubernetes configura os recursos e implementa os contêineres em pods nos nós do trabalhador com capacidade disponível.
</br></br>
Defina as estratégias de atualização para seu app, incluindo o número de pods que você deseja incluir durante uma atualização contínua e o número de pods que podem estar indisponíveis por vez. Quando você executar a uma atualização contínua, a implementação verificará se a atualização está funcionando e parará o lançamento quando falhas forem detectadas.</dd>

<dt>Pod</dt>
<dd>Cada app conteinerizado que é implementado em um cluster é implementado, executado e gerenciado por um recurso do Kubernetes que é chamado de pod. Os pods representam pequenas unidades implementáveis em um cluster do Kubernetes e são usados para agrupar os contêineres que devem ser tratados como uma unidade única. Na maioria dos casos, cada contêiner é implementado em seu próprio pod. No entanto, um app pode requerer que um contêiner e outros contêineres auxiliares sejam implementados em um pod para que esses contêineres possam ser direcionados usando o mesmo endereço IP privado.</dd>

<dt>App</dt>
<dd>Um app pode se referir a um app completo ou um componente de um app. Você pode implementar componentes de um app em pods separados ou nós do trabalhador separados.
</br></br>
Para aprender mais sobre a terminologia do Kubernetes, <a href="cs_tutorials.html#cs_cluster_tutorial" target="_blank">tente o tutorial</a>.</dd>

</dl>

<br />


## Benefícios do uso de clusters
{: #cs_ov_benefits}

Os clusters são implementados em hosts de cálculo que fornecem Kubernetes nativos e recursos incluídos no {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Benefício|Descrição|
|-------|-----------|
|Clusters do Kubernetes de locatário único com isolamento de infraestrutura de cálculo, de rede e de armazenamento|<ul><li>Crie sua própria infraestrutura customizada que atenda aos requisitos de sua organização.</li><li>Provisione um mestre do Kubernetes dedicado e seguro, nós do trabalhador, redes virtuais e armazenamento usando os recursos fornecidos pela infraestrutura do IBM Cloud (SoftLayer).</li><li>Armazene dados persistentes, compartilhar dados entre pods do Kubernetes e restaure dados quando necessário com o
serviço de volume integrado e seguro.</li><li>O mestre do Kubernetes totalmente gerenciado que é continuamente monitorado e atualizado pelo {{site.data.keyword.IBM_notm}} para manter seu cluster disponível.</li><li>Benefício do suporte integral para todas as APIs nativas do Kubernetes.</li></ul>|
|Conformidade de segurança de imagem com o Vulnerability Advisor|<ul><li>Configure seu próprio registro de imagem privada assegurada do Docker no qual as imagens são armazenadas e compartilhadas por todos
os usuários na organização.</li><li>Benefício de varredura automática de imagens em seu registro privado do {{site.data.keyword.Bluemix_notm}}.</li><li>Revise as recomendações específicas para o sistema operacional usado na imagem para corrigir potenciais
vulnerabilidades.</li></ul>|
|Ajuste automático de escala de apps|<ul><li>Defina políticas customizadas para aumentar e reduzir a capacidade de apps com base no consumo de CPU e memória.</li></ul>|
|Monitoramento contínuo do funcionamento do cluster|<ul><li>Use o painel de cluster para ver e gerenciar rapidamente o funcionamento de seu cluster, os nós do trabalhador
e as implementações de contêiner.</li><li>Localize métricas detalhadas de consumo usando o {{site.data.keyword.monitoringlong}} e expanda rapidamente o seu cluster para atender cargas de trabalho.</li><li>Revise as informações de criação de log usando o {{site.data.keyword.loganalysislong}} para ver atividades detalhadas do cluster.</li></ul>|
|Recuperação automática de contêineres não saudáveis|<ul><li>Verificações contínuas de funcionamento em contêineres implementados em um nó do trabalhador.</li><li>A recriação automática de contêineres em caso de falhas.</li></ul>|
|Descoberta de serviço e gerenciamento de serviço|<ul><li>Registre centralmente os serviços de app para torná-los disponíveis para outros apps em seu cluster sem
expô-los publicamente.</li><li>Descubra os serviços registrados sem manter o controle da mudança de endereços IP ou IDs de contêiner e
beneficie-se do roteamento automático para instâncias disponíveis.</li></ul>|
|Exposição segura de serviços ao público|<ul><li>As redes de sobreposição privada com balanceador de carga integral e suporte de Ingresso para tornar os seus apps publicamente
disponíveis e balancear as cargas de trabalho em múltiplos nós do trabalhador sem manter o controle da mudança de
endereços IP dentro de seu cluster.</li><li>Escolha entre um endereço IP público, uma rota fornecida pela {{site.data.keyword.IBM_notm}} ou seu próprio domínio customizado para acessar serviços em seu cluster por meio da Internet.</li></ul>|
|Integração de serviço do {{site.data.keyword.Bluemix_notm}}|<ul><li>Inclua recursos extras em seu app por meio da integração de serviços do {{site.data.keyword.Bluemix_notm}}, como APIs do Watson, Blockchain, serviços de dados ou Internet das Coisas e ajude os usuários do cluster a simplificarem o desenvolvimento de apps e processos de gerenciamento de contêiner.</li></ul>|
{: caption="Tabela 1. Benefícios do uso de clusters com o {{site.data.keyword.containerlong_notm}}" caption-side="top"}

<br />


## Arquitetura de serviço
{: #cs_ov_architecture}

Cada nó do trabalhador é configurado com um mecanismo de Docker gerenciado pela {{site.data.keyword.IBM_notm}}, recursos de cálculo separados, rede e serviço de volume, bem como recursos de segurança integrados que fornecem isolamento, capacidades de gerenciamento de recurso e conformidade de segurança do nó do trabalhador. O nó do trabalhador comunica-se com o mestre usando certificados TLS seguros e conexão openVPN.
{:shortdesc}

*Figura 1. Arquitetura e rede do Kubernetes no {{site.data.keyword.containershort_notm}}*

![{{site.data.keyword.containerlong_notm}} Arquitetura do Kubernetes](images/cs_org_ov.png)

O diagrama descreve o que você mantém e o que a IBM mantém em um cluster. Para obter mais detalhes sobre essas tarefas de manutenção, veja [Responsabilidades de gerenciamento de cluster](cs_planning.html#responsibilities).

<br />


## Abuso de contêineres
{: #cs_terms}

Os clientes não podem fazer uso inadequado do {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Uso inadequado inclui:

*   Qualquer atividade ilegal
*   Distribuição ou execução de malware
*   Prejudicar o {{site.data.keyword.containershort_notm}} ou interferir no
uso de alguém do {{site.data.keyword.containershort_notm}}
*   Prejudicar ou interferir no uso de alguém de qualquer outro serviço ou sistema
*   Acesso não autorizado a qualquer serviço ou sistema
*   Modificação não autorizada de qualquer serviço ou sistema
*   Violação dos direitos de outros

Veja [Termos dos serviços
de nuvem](/docs/navigation/notices.html#terms) para obter os termos gerais de uso.
