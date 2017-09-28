---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Segurança para o {{site.data.keyword.containerlong_notm}}
{: #cs_security}

É possível usar recursos de segurança integrados para análise de risco e proteção de segurança. Esses recursos ajudam você a proteger a sua infraestrutura de cluster e a comunicação de rede, a isolar os seus recursos de cálculo e a assegurar a conformidade de segurança em seus componentes de infraestrutura e implementações de contêiner.
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png">Segurança do cluster do <img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} " style="width:400px;" /></a>

<table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
  <thead>
  <th colspan=2><img src="images/idea.png"/> Configurações de segurança integradas do cluster no {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Mestre do Kubernetes</td>
      <td>O mestre do Kubernetes em cada cluster é gerenciado pela IBM e é altamente disponível. Ele inclui configurações de segurança do {{site.data.keyword.containershort_notm}} que asseguram conformidade de segurança e comunicação segura para e dos nós do trabalhador. As atualizações são executadas pela IBM conforme necessário. O mestre do Kubernetes dedicado controla e monitora centralmente todos os recursos do Kubernetes no cluster. Com base nos requisitos de implementação e na capacidade no cluster, o mestre do Kubernetes planeja automaticamente os seus apps conteinerizados para implementar ao longo de nós do trabalhador disponíveis. Para obter mais informações, veja [Segurança do mestre do Kubernetes](#cs_security_master).</td>
    </tr>
    <tr>
      <td>Nó do trabalhador</td>
      <td>Os contêineres são implementados em nós do trabalhador que são dedicados a um cluster e que asseguram o isolamento de cálculo, de rede e de armazenamento para os clientes IBM. O {{site.data.keyword.containershort_notm}} fornece recursos de segurança integrados para manter os nós do trabalhador seguros nas redes privada e pública e para assegurar a conformidade de segurança do nó do trabalhador. Para obter mais informações, veja [Segurança do nó do trabalhador](#cs_security_worker).</td>
     </tr>
     <tr>
      <td>Imagens</td>
      <td>Como administrador de cluster, é possível configurar o seu próprio repositório de imagem do Docker seguro no {{site.data.keyword.registryshort_notm}} no qual é possível armazenar e compartilhar imagens do Docker entre os seus usuários de cluster. Para assegurar implementações seguras de contêiner, cada imagem em seu registro privado é varrida pelo Vulnerability Advisor. O Vulnerability Advisor é um componente do {{site.data.keyword.registryshort_notm}} que varre para obter potenciais vulnerabilidades, faz recomendações de segurança e fornece instruções para resolver vulnerabilidades. Para obter mais informações, veja [Segurança da imagem no {{site.data.keyword.containershort_notm}}](#cs_security_deployment).</td>
    </tr>
  </tbody>
</table>

## Mestre do Kubernetes
{: #cs_security_master}

Revise os recursos de segurança integrados do mestre do Kubernetes para proteger o mestre do Kubernetes e para assegurar a comunicação de rede de cluster.
{: shortdesc}

<dl>
  <dt>Mestre do Kubernetes totalmente gerenciado e dedicado</dt>
    <dd>Cada cluster do Kubernetes no {{site.data.keyword.containershort_notm}} é controlado por um mestre do Kubernetes dedicado que é gerenciado pela IBM em uma conta do {{site.data.keyword.BluSoftlayer_full}} de propriedade da IBM. O mestre do Kubernetes é configurado com os componentes dedicados a seguir que não são compartilhados com outros clientes IBM.
    <ul><ul><li>Armazenamento de dados etcd: armazena todos os recursos do Kubernetes de um cluster, como Serviços, Implementações e Pods. Os ConfigMaps e Segredos do Kubernetes são dados do app armazenados como pares de valores de chave para que eles possam ser usados por um app que é executado em um pod. Os dados no etcd são armazenados em um disco criptografado gerenciado pela IBM e são criptografados por TLS quando enviados a um pod para assegurar a proteção e integridade de dados.
    <li>kube-apiserver: serve como o ponto de entrada principal para todas as solicitações do nó do trabalhador para o mestre do Kubernetes. O kube-apiserver valida e processa solicitações e pode ler e gravar no armazenamento de dados etcd.
    <li><kube-scheduler: decide onde implementar pods, levando em consideração a capacidade e as necessidades de desempenho, as restrições de política de hardware e software, as especificações de antiafinidade e os requisitos de carga de trabalho. Se não puder ser localizado nenhum nó do trabalhador que corresponda aos requisitos, o pod não será implementado no cluster.
    <li>kube-controller-manager: responsável por monitorar os conjuntos de réplicas e criar pods correspondentes para atingir o estado desejado.
    <li>OpenVPN: componente específico do {{site.data.keyword.containershort_notm}} para fornecer conectividade de rede assegurada para toda comunicação do mestre do Kubernetes com o nó do trabalhador.</ul></ul></dd>
  <dt>Conectividade de rede assegurada TLS para toda comunicação do nó do trabalhador com o mestre do Kubernetes</dt>
    <dd>Para assegurar a comunicação de rede com o mestre do Kubernetes, o {{site.data.keyword.containershort_notm}} gera certificados TLS que criptografam a comunicação para e a partir dos componentes kube-apiserver e armazenamento de dados etcd para cada cluster. Esses certificados nunca são compartilhados entre clusters ou entre os componentes do mestre do Kubernetes.</dd>
  <dt>Conectividade de rede segura OpenVPN para toda comunicação do mestre do Kubernetes com o nó do trabalhador</dt>
    <dd>Embora o Kubernetes assegure a comunicação entre o mestre do Kubernetes e os nós do trabalhador usando o protocolo `https`, nenhuma autenticação é fornecida no nó do trabalhador por padrão. Para assegurar essa comunicação, o {{site.data.keyword.containershort_notm}} configura automaticamente uma conexão OpenVPN entre o mestre do Kubernetes e o nó do trabalhador quando o cluster é criado.</dd>
  <dt>Monitoramento contínuo de rede do mestre do Kubernetes</dt>
    <dd>Cada mestre do Kubernetes é monitorado continuamente pela IBM para controlar e corrigir os ataques de Negação de Serviço (DOS) de nível de processo.</dd>
  <dt>Conformidade de segurança do nó do mestre do Kubernetes</dt>
    <dd>O {{site.data.keyword.containershort_notm}} varre automaticamente cada nó em que o mestre do Kubernetes é implementado em busca de vulnerabilidades localizadas em correções de segurança do Kubernetes e específicas do S.O. que precisam ser aplicadas para assegurar proteção do nó principal. Se vulnerabilidades forem localizadas, o {{site.data.keyword.containershort_notm}} aplicará automaticamente as correções e resolverá as vulnerabilidades em nome do usuário.</dd>
</dl>  

## Nós do trabalhador
{: #cs_security_worker}

Revise os recursos integrados de segurança do nó do trabalhador para proteger o ambiente do nó do trabalhador e assegurar o isolamento de recurso, rede e armazenamento.
{: shortdesc}

<dl>
  <dt>Isolamento de infraestrutura de cálculo, rede e armazenamento</dt>
    <dd>Ao criar um cluster, as máquinas virtuais são provisionadas como nós do trabalhador na conta do {{site.data.keyword.BluSoftlayer_notm}} do cliente ou na conta dedicada do {{site.data.keyword.BluSoftlayer_notm}} pela IBM. Os nós do trabalhador são dedicados a um cluster e não hospedam cargas de outros clusters.</br> Cada conta do {{site.data.keyword.Bluemix_notm}} é configurada com VLANs do {{site.data.keyword.BluSoftlayer_notm}} para assegurar desempenho de rede de qualidade e isolamento nos nós do trabalhador. </br>Para persistir dados no cluster, é possível provisionar armazenamento de arquivo baseado em NFS dedicado do {{site.data.keyword.BluSoftlayer_notm}} e alavancar os recursos de segurança de dados integrados dessa plataforma.</dd>
  <dt>Configuração de nó do trabalhador seguro</dt>
    <dd>Cada nó do trabalhador é configurado com um sistema operacional Ubuntu que não pode ser mudado pelo usuário. Para proteger o sistema operacional dos nós do trabalhador de potenciais ataques, cada nó do trabalhador é definido com configurações de firewall de especialista que são impingidas por regras iptable do Linux.</br> Todos os contêineres que são executados no Kubernetes são protegidos pelas configurações de política de rede Calico que são configuradas em cada nó do trabalhador durante a criação de cluster. Essa configuração assegura a comunicação de rede segura entre os nós do trabalhador e os pods. Para restringir ainda mais as ações que um contêiner pode executar no nó do trabalhador, os usuários podem escolher configurar [políticas de AppArmor ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) nos nós do trabalhador.</br> Por padrão, o acesso SSH para o usuário raiz é desativado no nó do trabalhador. Se desejar instalar recursos adicionais no nó do trabalhador, será possível usar [conjuntos de daemons do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) para tudo o que você desejar executar em cada nó do trabalhador ou [tarefas do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) para qualquer ação única que precisar ser executada.</dd>
  <dt>Conformidade de segurança do nó do trabalhador do Kubernetes</dt>
    <dd>A IBM trabalha com as equipes de recomendação de segurança interna e externamente para identificar potenciais problemas de conformidade de segurança para nós do trabalhador e libera continuamente atualizações de conformidade e correções de segurança para tratar das vulnerabilidades localizadas. As atualizações e correções de segurança são implementadas automaticamente no sistema operacional do nó do trabalhador pela IBM. Para fazer isso, a IBM mantém o acesso SSH para os nós do trabalhador.</br> <b>Nota</b>: algumas atualizações requerem uma reinicialização do nó do trabalhador. No entanto, a IBM não reinicializa nós do trabalhador durante a instalação de atualizações ou correções de segurança. Os usuários são aconselhados a reinicializar os nós do trabalhador regularmente para assegurar que a instalação de atualizações e correções de segurança possam ser concluídas.</dd>
  <dt>Suporte para firewalls de rede do SoftLayer</dt>
    <dd>O {{site.data.keyword.containershort_notm}} é compatível com todas as [ofertas de firewall do {{site.data.keyword.BluSoftlayer_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/network-security). No {{site.data.keyword.Bluemix_notm}} Public, é possível configurar um firewall com políticas de rede customizadas para fornecer segurança de rede dedicada para seu cluster e para detectar e corrigir intrusão de rede. Por exemplo, é possível optar por configurar um [Vyatta ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/vyatta-1) para agir como seu firewall e bloquear tráfego indesejado. Ao configurar um firewall, [deve-se também abrir as portas e os endereços IP necessários](#opening_ports) para cada região para que o mestre e os nós do trabalhador possam se comunicar. No {{site.data.keyword.Bluemix_notm}} Dedicated, firewalls, DataPower, Fortigate e DNS já estão configurados como parte da implementação do ambiente dedicado padrão.</dd>
  <dt>Manter os serviços privados ou expor os serviços e apps seletivamente para a Internet pública</dt>
    <dd>É possível escolher manter seus serviços e apps privados e alavancar os recursos de segurança integrados descritos neste tópico para assegurar uma comunicação segura entre os nós do trabalhador e os pods. Para expor os serviços e apps para a Internet pública, é possível alavancar o suporte do Ingresso e do balanceador de carga para tornar os seus serviços publicamente disponíveis com segurança.</dd>
  <dt>Conecte com segurança seus nós do trabalhador e apps a um data center local</dt>
    <dd>É possível instalar um Dispositivo de gateway Vyatta ou um Dispositivo Fortigate para configurar um terminal VPN IPSec que conecte o cluster do Kubernetes a um data center local. Em um túnel criptografado, todos os serviços executados no cluster do Kubernetes podem se comunicar de forma segura com apps locais, como diretórios do usuário, bancos de dados ou mainframes. Para obter mais informações, veja [Conectando um cluster a um data center local ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).</dd>
  <dt>Monitoramento contínuo e criação de log de atividade do cluster</dt>
    <dd>Para clusters padrão, todos os eventos relacionados ao cluster, como incluir um nó do trabalhador, progresso de atualização contínua ou informações de uso de capacidade, são registrados e monitorados pelo {{site.data.keyword.containershort_notm}} e enviados para o IBM Monitoring and Logging Service.</dd>
</dl>

### Abrindo portas e endereços IP necessários em seu firewall
{: #opening_ports}

Ao configurar um firewall para seus nós do trabalhador ou customizar as configurações de firewall em sua conta do {{site.data.keyword.BluSoftlayer_notm}}, deve-se abrir determinadas portas e endereços IP para que o nó do trabalhador e o mestre do Kubernetes possam se comunicar.

1.  Observe o endereço IP público para todos os nós do trabalhador no cluster.

    ```
    bx cs workers <cluster_name_or_id>
    ```
    {: pre}

2.  Em seu firewall, permita as conexões a seguir para e a partir de seus nós do trabalhador.

  ```
  TCP port 443 FROM <each_worker_node_publicIP> TO registry.<region>.bluemix.net, apt.dockerproject.org
  ```
  {: codeblock}

    <ul><li>Para conectividade de SAÍDA dos nós do trabalhador, permita tráfego de rede de saída do nó do trabalhador de origem para o intervalo de portas TCP/UDP de destino 20.000 a 32.767, para `<each_worker_node_publicIP>` e os endereços IP e grupos de rede a seguir:</br>
    

    <table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> Endereços IP de saída</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>


## Políticas de rede
{: #cs_security_network_policies}

Cada cluster do Kubernetes é configurado com um plug-in de rede que é chamado Calico. As políticas de rede padrão são configuradas para assegurar a interface de rede pública de cada nó do trabalhador. É possível usar o Calico e os recursos nativo do Kubernetes para configurar mais políticas de rede para um cluster quando você tem requisitos de segurança exclusivos. Essas políticas de rede especificam o tráfego de rede que você deseja permitir ou bloquear para/de um pod em um cluster.
{: shortdesc}

É possível escolher entre o Calico e os recursos nativos do Kubernetes para criar políticas de rede para seu cluster. Você pode usar políticas de rede do Kubernetes para começar, mas para recursos mais robustos, use as políticas de rede do Calico.

<ul><li>[Políticas de rede do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): algumas opções básicas são fornecidas, como a especificação de quais pods podem se comunicar entre si. O tráfego de rede recebido para os pods pode ser permitido ou bloqueado para um protocolo e porta com base nas etiquetas e namespaces do Kubernetes do pod que está tentando se conectar a eles.</br>Essas políticas podem ser aplicadas usando comandos `kubectl` ou as APIs do Kubernetes. Quando essas políticas são aplicadas, elas são convertidas em políticas de rede do Calico e o Calico impinge essas políticas.
<li>[Políticas de rede do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy): essas políticas são um superconjunto das políticas de rede do Kubernetes e aprimoram as capacidades nativas do Kubernetes com os recursos a seguir.
<ul><ul><li>Permitir ou bloquear tráfego de rede em interfaces de rede específicas, não somente o tráfego de pod do Kubernetes.<li>Permitir ou bloquear tráfego de rede recebido (ingresso) e de saída (egresso).<li>Permitir ou bloquear o tráfego que é baseado em um endereço IP de origem ou destino ou CIDR.</ul></ul></br>
Essas políticas são aplicadas usando comandos `calicoctl`. O Calico impinge essas políticas, que incluem quaisquer políticas de rede do Kubernetes que são convertidas em políticas do Calico, configurando regras iptables do Linux nos nós do trabalhador do Kubernetes. As regras de Iptables servem como um firewall para o nó do trabalhador para definir as características que o tráfego de rede deve atender para ser encaminhado para o recurso de destino.</ul>


### Configuração de política padrão
{: #concept_nq1_2rn_4z}

Quando um cluster é criado, as políticas de rede padrão são configuradas automaticamente para a interface de rede pública de cada nó do trabalhador para limitar o tráfego recebido para um nó do trabalhador na Internet pública. Essas políticas não afetam o tráfego de pod para pod e são configuradas para permitir acesso à porta de nó do Kubernetes, ao balanceador de carga e aos serviços do Ingresso.

As políticas padrão não são aplicadas aos pods diretamente; elas são aplicadas à interface de rede pública de um nó do trabalhador usando um [terminal de host do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal). Quando um terminal de host é criado no Calico, todo o tráfego para/da interface de rede desse nó do trabalhador é bloqueado, a menos que o tráfego seja permitido por uma política.

Observe que uma política para permitir SSH não existe, então o acesso SSH por meio da interface de rede pública é bloqueado, assim como todas as outras portas que não têm uma política para abri-los. O acesso SSH e outro acesso estão disponíveis na interface de rede privada de cada nó do trabalhador.

**Importante:** não remova as políticas aplicadas a um terminal de host, a menos que você entenda completamente a política e saiba que não precisará do tráfego que está sendo permitido pela política.



  <table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
  <thead>
  <th colspan=2><img src="images/idea.png"/> Políticas padrão para cada cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Permite todo o tráfego de saída.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Permite pacotes icmp recebidos (pings).</td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>Permite todo o tráfego recebido para a porta 10250, que é a porta usada pelo kubelet. Essa política permite que `kubectl logs` e `kubectl exec` funcionem corretamente no cluster do Kubernetes.</td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Permite o tráfego recebido da porta de nó, do balanceador de carga e do serviço de ingresso para os pods que esses serviços estão expondo. Observe que a porta que esses serviços expõem na interface pública não precisa ser especificada, porque o Kubernetes usa a conversão de endereço de rede de destino (DNAT) para encaminhar essas solicitações de serviço para os pods corretos. Esse redirecionamento ocorre antes que as políticas de terminal de host sejam aplicadas aos iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Permite conexões recebidas para sistemas {{site.data.keyword.BluSoftlayer_notm}} específicos que são usados para gerenciar os nós do trabalhador.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Permitir pacotes vrrp, que são usados para monitorar e mover endereços IP virtuais entre os nós do trabalhador.</td>
   </tr>
  </tbody>
</table>


### Incluindo políticas de rede
{: #adding_network_policies}

Na maioria dos casos, as políticas padrão não precisam ser mudadas. Somente cenários avançados podem requerer mudanças. Se você achar que deve-se fazer mudanças, instale a CLI do Calico e crie suas próprias políticas de rede

Antes de iniciar, conclua as etapas a seguir.

1.  [Instale as CLIs do {{site.data.keyword.containershort_notm}} e do Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Crie um cluster lite ou padrão.](cs_cluster.html#cs_cluster_ui)
3.  [Destine a CLI do Kubernetes para o cluster](cs_cli_install.html#cs_cli_configure). Inclua a opção `--admin` com o comando `bx cs cluster-config`, que é usado para fazer download dos certificados e arquivos de permissão. Este download também inclui as chaves para a função rbac de Administrador, que é necessária para executar comandos do Calico.

  ```
  bx cs cluster-config <cluster_name> 
  ```
  {: pre}


Para incluir políticas de rede:
1.  Instale a CLI do Calico.
    1.  [Faça download da CLI do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/projectcalico/calicoctl/releases/).

        **Dica:** se estiver usando o Windows, instale a CLI do Calico no mesmo diretório que a CLI do {{site.data.keyword.Bluemix_notm}}. Essa configuração economiza algumas mudanças de caminho de arquivo ao executar comandos posteriormente.

    2.  Para usuários do OSX e Linux, conclua as etapas a seguir.
        1.  Mova o arquivo executável para o diretório /usr/local/bin.
            -   Linux:

              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   S.O. X:

              ```
              mv /<path_to_file>/calico-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Converta o arquivo binário para um executável.

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Verifique se os comandos `calico` são executados corretamente verificando a versão de cliente da CLI do Calico.

        ```
        calicoctl version
        ```
        {: pre}

2.  Configure a CLI do Calico.

    1.  Para Linux e OS X, crie o diretório '/etc/calico'. Para Windows, qualquer diretório pode ser usado.

      ```
      mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Crie um arquivo 'calicoctl.cfg'.
        -   Linux e OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows: crie o arquivo com um editor de texto.

    3.  Digite as informações a seguir no arquivo <code>calicoctl.cfg</code>.

      ```
      apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD_URL>
          etcdKeyFile: <CERTS_DIR>/admin-key.pem
          etcdCertFile: <CERTS_DIR>/admin.pem
          etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
      ```
      {: pre}

        1.  Recupere o `<ETCD_URL>`.

          -   Linux e OS X:

              ```
              kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
              ```
              {: pre}

          -   Exemplo de saída:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Obtenha uma lista dos pods no namespace kube-system e localize o pod controlador do Calico. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Exemplo:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
            <li>Visualize os detalhes do pod controlador do Calico.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
            <li>Localize o valor de terminais do ETCD. Exemplo: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Recupere o `<CERTS_DIR>`, o diretório no qual os certificados do Kubernetes são transferidos por download.

            -   Linux e OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                Exemplo de saída:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                Exemplo de saída:

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **Nota**: para obter o caminho do diretório, remova o nome de arquivo `kube-config-prod-<location>-<cluster_name>.yml` do término da saída.

        3.  Recupere o <code>ca-*pem_file<code>.

            -   Linux e OS X:

              ```
              ls `dirname $KUBECONFIG` | grep ca-.*pem
              ```
              {: pre}

            -   Windows:
              <ol><li>Abra o diretório que você recuperou na última etapa.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&#60;cluster_name&#62;-admin\</code></pre>
              <li> Localize o arquivo <code>ca-*pem_file</code>.</ol>

        4.  Verifique se a configuração do Calico está funcionando corretamente.

            -   Linux e OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
              ```
              {: pre}

              Saída:

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  Examine as políticas de rede existentes.

    -   Visualize o terminal de host do Calico.

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   Visualize todas as políticas de rede do Calico e do Kubernetes que foram criadas para o cluster. Essa lista inclui políticas que podem não estar aplicadas a quaisquer pods ou hosts ainda. Para que uma política de rede seja impingida, ela deve localizar um recurso do Kubernetes que corresponda ao seletor que foi definido na política de rede do Calico.

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   Visualize detalhes para uma política de rede.

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   Visualize os detalhes de todas as políticas de rede para o cluster.

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  Crie as políticas de rede do Calico para permitir ou bloquear o tráfego.

    1.  Defina a [política de rede do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy) criando um script de configuração (.yaml). Esses arquivos de configuração incluem os seletores que descrevem a quais pods, namespaces ou hosts essas políticas se aplicam. Consulte essas [políticas de amostra do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) para ajudá-lo a criar a sua própria.

    2.  Aplique as políticas ao cluster.
        -   Linux e OS X:

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}


## Imagens
{: #cs_security_deployment}

Gerencie a segurança e integridade de suas imagens com recursos de segurança integrada.
{: shortdesc}

### Repositório seguro de imagem privada do Docker no {{site.data.keyword.registryshort_notm}}:

 É possível configurar o seu próprio repositório de imagem do Docker em um registro de imagem privada de múltiplos locatários, altamente disponível e escalável que é hospedado pela IBM para construir, armazenar com segurança e compartilhar imagens do Docker entre usuários de cluster.

### Conformidade de segurança de imagem:

Quando você usar o {{site.data.keyword.registryshort_notm}}, será possível alavancar a varredura de segurança integrada que é fornecida pelo Vulnerability Advisor. Cada imagem enviada por push para o seu namespace é varrida automaticamente para obter vulnerabilidades com relação a um banco de dados de problemas conhecidos do CentOS, Debian, Red Hat e Ubuntu. Se vulnerabilidades forem localizadas, o Vulnerability Advisor fornecerá instruções de como resolvê-las para assegurar a integridade e segurança da imagem.

Para visualizar a avaliação de vulnerabilidade para sua imagem:

1.  No **catálogo**, selecione **Contêineres**.
2.  Selecione a imagem na qual você deseja ver avaliação de vulnerabilidade.
3.  Na seção **Avaliação de vulnerabilidade**, clique em **Visualizar relatório**.
