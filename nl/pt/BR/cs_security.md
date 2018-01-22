---

copyright: years: 2014, 2017 lastupdated: "2017-12-13"

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

## Segurança por componente de cluster
{: #cs_security_cluster}

Cada cluster do {{site.data.keyword.containerlong_notm}} possui recursos de segurança integrados para seus nós [principal](#cs_security_master) e [trabalhador](#cs_security_worker). Se você tiver um firewall, será necessário acessar o balanceamento de carga de fora do cluster ou desejar executar os comandos `kubectl` de seu sistema local quando as políticas de rede corporativa impedirem o acesso aos terminais de Internet pública, [abra portas em seu firewall](#opening_ports). Se você deseja conectar os apps em seu cluster a uma rede no local ou a outros apps externos para seu cluster, [configure a conectividade da VPN](#vpn).
{: shortdesc}

No diagrama a seguir, é possível ver recursos de segurança que são agrupados por mestre do Kubernetes, nós do trabalhador e imagens de contêiner.

<img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} cluster security" style="width:400px; border-style: none"/>


  <table summary="A primeira linha na tabela abrange ambas as colunas. As linhas restantes devem ser lidas da esquerda para a direita, com o local do servidor na coluna um e endereços IP para corresponder na coluna dois.">
  <caption>Tabela 1. Recursos de segurança</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Configurações de segurança de cluster integrado no {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Mestre do Kubernetes</td>
      <td>O mestre do Kubernetes em cada cluster é gerenciado pela IBM e é altamente disponível. Ele inclui configurações de segurança do {{site.data.keyword.containershort_notm}} que asseguram conformidade de segurança e comunicação segura para e dos nós do trabalhador. As atualizações são executadas pela IBM conforme necessário. O mestre do Kubernetes dedicado controla e monitora centralmente todos os recursos do Kubernetes no cluster. Com base nos requisitos de implementação e na capacidade no cluster, o mestre do Kubernetes planeja automaticamente os seus apps conteinerizados para implementar ao longo de nós do trabalhador disponíveis. Para obter mais informações, veja [Segurança do mestre do Kubernetes](#cs_security_master).</td>
    </tr>
    <tr>
      <td>Nó do trabalhador</td>
      <td>Os contêineres são implementados em nós do trabalhador que são dedicados a um cluster e que asseguram o isolamento de cálculo, de rede e de armazenamento para os clientes IBM. O {{site.data.keyword.containershort_notm}} fornece recursos de segurança integrados para manter os nós do trabalhador seguros nas redes privada e pública e para assegurar a conformidade de segurança do nó do trabalhador. Para obter mais informações, veja [Segurança do nó do trabalhador](#cs_security_worker). Além disso, é possível incluir [políticas de rede Calico](#cs_security_network_policies) para especificar melhor o tráfego de rede que você deseja permitir ou bloquear para/de um pod em um nó do trabalhador. </td>
     </tr>
     <tr>
      <td>Imagens</td>
      <td>Como administrador de cluster, é possível configurar o seu próprio repositório de imagem do Docker seguro no {{site.data.keyword.registryshort_notm}} no qual é possível armazenar e compartilhar imagens do Docker entre os seus usuários de cluster. Para assegurar implementações seguras de contêiner, cada imagem em seu registro privado é varrida pelo Vulnerability Advisor. O Vulnerability Advisor é um componente do {{site.data.keyword.registryshort_notm}} que varre para obter potenciais vulnerabilidades, faz recomendações de segurança e fornece instruções para resolver vulnerabilidades. Para obter mais informações, veja [Segurança da imagem no {{site.data.keyword.containershort_notm}}](#cs_security_deployment).</td>
    </tr>
  </tbody>
</table>

### Mestre do Kubernetes
{: #cs_security_master}

Revise os recursos de segurança integrados do mestre do Kubernetes para proteger o mestre do Kubernetes e para assegurar a comunicação de rede de cluster.
{: shortdesc}

<dl>
  <dt>Mestre do Kubernetes totalmente gerenciado e dedicado</dt>
    <dd>Cada cluster do Kubernetes no {{site.data.keyword.containershort_notm}} é controlado por um mestre do Kubernetes dedicado que é gerenciado pela IBM em uma conta de infraestrutura do IBM Cloud (SoftLayer) pertencente à IBM. O mestre do Kubernetes é configurado com os componentes dedicados a seguir que não são compartilhados com outros clientes IBM.
    <ul><li>Armazenamento de dados etcd: armazena todos os recursos do Kubernetes de um cluster, como Serviços, Implementações e Pods. Os ConfigMaps e Segredos do Kubernetes são dados do app armazenados como pares de valores de chave para que eles possam ser usados por um app que é executado em um pod. Os dados no etcd são armazenados em um disco criptografado
gerenciado pela IBM e são criptografados por TLS quando enviados a um pod para assegurar a proteção e integridade
de dados.</li>
    <li>kube-apiserver: serve como o ponto de entrada principal para todas as solicitações do nó do trabalhador para o mestre do Kubernetes. O kube-apiserver valida e processa solicitações e pode ler e gravar
no armazenamento de dados etcd.</li>
    <li>kube-scheduler: decida onde implementar pods, levando em consideração a capacidade da conta e as necessidades
de desempenho, as restrições de política de hardware e software, as especificações de antiafinidade e os requisitos
de carga de trabalho. Se não puder ser localizado nenhum nó do trabalhador que corresponda aos requisitos, o pod não será implementado
no cluster.</li>
    <li>kube-controller-manager: responsável por monitorar os conjuntos de réplicas e criar pods correspondentes
para atingir o estado desejado.</li>
    <li>OpenVPN: o componente específico do {{site.data.keyword.containershort_notm}} para fornecer conectividade de rede segura para toda comunicação do mestre do Kubernetes com o nó do trabalhador.</li></ul></dd>
  <dt>Conectividade de rede assegurada TLS para toda comunicação do nó do trabalhador com o mestre do Kubernetes</dt>
    <dd>Para assegurar a comunicação de rede com o mestre do Kubernetes, o {{site.data.keyword.containershort_notm}} gera certificados TLS que criptografam a comunicação para e a partir dos componentes kube-apiserver e armazenamento de dados etcd para cada cluster. Esses certificados nunca são compartilhados entre clusters ou entre os componentes do mestre do Kubernetes.</dd>
  <dt>Conectividade de rede segura OpenVPN para toda comunicação do mestre do Kubernetes com o nó do trabalhador</dt>
    <dd>Embora o Kubernetes assegure a comunicação entre o mestre do Kubernetes e os nós do trabalhador usando o protocolo `https`, nenhuma autenticação é fornecida no nó do trabalhador por padrão. Para assegurar essa comunicação, o {{site.data.keyword.containershort_notm}} configura automaticamente uma conexão OpenVPN entre o mestre do Kubernetes e o nó do trabalhador quando o cluster é criado.</dd>
  <dt>Monitoramento contínuo de rede do mestre do Kubernetes</dt>
    <dd>Cada mestre do Kubernetes é monitorado continuamente pela IBM para controlar e corrigir os ataques de Negação de Serviço (DOS) de nível de processo.</dd>
  <dt>Conformidade de segurança do nó do mestre do Kubernetes</dt>
    <dd>O {{site.data.keyword.containershort_notm}} varre automaticamente cada nó em que o mestre do Kubernetes é implementado em busca de vulnerabilidades localizadas em correções de segurança do Kubernetes e específicas do S.O. que precisam ser aplicadas para assegurar proteção do nó principal. Se vulnerabilidades forem localizadas, o {{site.data.keyword.containershort_notm}} aplicará automaticamente as correções e resolverá as vulnerabilidades em nome do usuário.</dd>
</dl>

<br />


### Nós do trabalhador
{: #cs_security_worker}

Revise os recursos integrados de segurança do nó do trabalhador para proteger o ambiente do nó do trabalhador e assegurar o isolamento de recurso, rede e armazenamento.
{: shortdesc}

<dl>
  <dt>Isolamento de infraestrutura de cálculo, rede e armazenamento</dt>
    <dd>Ao criar um cluster, as máquinas virtuais são provisionadas como nós do trabalhador na conta de infraestrutura do IBM Cloud (SoftLayer) do cliente ou na conta de infraestrutura dedicada do IBM Cloud (SoftLayer) pela IBM. Os nós do trabalhador são dedicados a um cluster e não hospedam cargas de outros clusters.</br> Cada conta do {{site.data.keyword.Bluemix_notm}} é configurada com VLANs de infraestrutura do IBM Cloud (SoftLayer) para assegurar o desempenho e o isolamento da rede de qualidade nos nós do trabalhador. </br>Para persistir dados em seu cluster, é possível provisionar armazenamento de arquivo baseado em NFS dedicado da infraestrutura do IBM Cloud (SoftLayer) e alavancar os recursos de segurança de dados integrados dessa plataforma.</dd>
  <dt>Configuração de nó do trabalhador seguro</dt>
    <dd>Cada nó do trabalhador é configurado com um sistema operacional Ubuntu que não pode ser mudado pelo usuário. Para proteger o sistema operacional dos nós do trabalhador de potenciais ataques, cada nó do trabalhador é definido com configurações de firewall de especialista que são impingidas por regras iptable do Linux.</br> Todos os contêineres que são executados no Kubernetes são protegidos pelas configurações de política de rede Calico que são configuradas em cada nó do trabalhador durante a criação de cluster. Essa configuração assegura a comunicação de rede segura entre os nós do trabalhador e os pods. Para restringir ainda mais as ações que um contêiner pode executar no nó do trabalhador, os usuários podem escolher configurar [políticas de AppArmor ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) nos nós do trabalhador.</br> Acesso SSH é desativado no nó do trabalhador. Se desejar instalar recursos adicionais no nó do trabalhador, será possível usar [conjuntos de daemons do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) para tudo o que você desejar executar em cada nó do trabalhador ou [tarefas do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) para qualquer ação única que precisar ser executada.</dd>
  <dt>Conformidade de segurança do nó do trabalhador do Kubernetes</dt>
    <dd>A IBM trabalha com as equipes consultivas de segurança interna e externa para resolver vulnerabilidades de conformidade de segurança em potencial. A IBM mantém o acesso aos nós do trabalhador para implementar atualizações e correções de segurança para o sistema operacional.</br> <b>Importante</b>: reinicialize os nós do trabalhador regularmente para assegurar a instalação das atualizações e correções de segurança que são implementadas automaticamente no sistema operacional. A IBM não reinicializa seus nós do trabalhador.</dd>
  <dt>Disco criptografado</dt>
  <dd>Por padrão, o {{site.data.keyword.containershort_notm}} fornece duas partições de dados criptografados de SSD local para todos os nós do trabalhador quando provisionados. A primeira partição não é criptografada e a segunda partição montada em _/var/lib/docker_ é desbloqueada quando provisionada usando chaves de criptografia LUKS. Cada trabalhador em cada cluster do Kubernetes tem sua própria chave de criptografia LUKS exclusiva, gerenciada pelo {{site.data.keyword.containershort_notm}}. Ao criar um cluster ou incluir um nó do trabalhador em um cluster existente, as chaves são obtidas de forma segura e, depois, descartadas após o disco criptografado ser desbloqueado.
  <p><b>Observação</b>: a criptografia pode impactar o desempenho de E/S do disco. Para cargas de trabalho que requerem E/S de disco de alto desempenho, teste um cluster com criptografia ativada e desativada para ajudá-lo a decidir se deseja desativar a criptografia.</p>
  </dd>
  <dt>Suporte para firewalls de rede da infraestrutura do IBM Cloud (SoftLayer)</dt>
    <dd>O {{site.data.keyword.containershort_notm}} é compatível com todas as [ofertas de firewall do IBM Cloud (SoftLayer) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/network-security). No {{site.data.keyword.Bluemix_notm}} Public, é possível configurar um firewall com políticas de rede customizadas para fornecer segurança de rede dedicada para seu cluster e para detectar e corrigir intrusão de rede. Por exemplo, é possível optar por configurar um [Vyatta ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/vyatta-1) para agir como seu firewall e bloquear tráfego indesejado. Ao configurar um firewall, [deve-se também abrir as portas e os endereços IP necessários](#opening_ports) para cada região para que o mestre e os nós do trabalhador possam se comunicar.</dd>
  <dt>Manter os serviços privados ou expor os serviços e apps seletivamente para a Internet pública</dt>
    <dd>É possível escolher manter seus serviços e apps privados e alavancar os recursos de segurança integrados descritos neste tópico para assegurar uma comunicação segura entre os nós do trabalhador e os pods. Para expor os serviços e apps para a Internet pública, é possível alavancar o suporte do Ingresso e do balanceador de carga para tornar os seus serviços publicamente disponíveis com segurança.</dd>
  <dt>Conecte com segurança seus nós do trabalhador e apps a um data center local</dt>
  <dd>Para conectar seus nós do trabalhador e apps a um data center no local, é possível configurar um terminal de VPN IPSec com um serviço Strongswan ou com um dispositivo de gateway Vyatta ou um dispositivo Fortigate.<br><ul><li><b>Serviço VPN do Strongswan IPSec</b>: é possível configurar um [Serviço VPN do Strongswan IPSec ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.strongswan.org/) que conecta de forma segura seu cluster do Kubernetes a uma rede no local. O serviço VPN do Strongswan IPSec fornece um canal de comunicação seguro de ponta a ponta na Internet, que é baseado no conjunto de protocolo padrão de mercado Internet Protocol Security (IPsec). Para configurar uma conexão segura entre seu cluster e uma rede no local, deve-se ter um gateway da VPN IPsec ou um servidor de infraestrutura do IBM Cloud (SoftLayer) instalado em seu datacenter no local. Então, é possível [configurar e implementar o serviço VPN do Strongswan IPSec](cs_security.html#vpn) em um pod do Kubernetes.</li><li><b>Dispositivo de gateway Vyatta ou dispositivo Fortigate</b>: se você tiver um cluster maior, será possível escolher configurar um Dispositivo de gateway Vyatta ou um Dispositivo Fortigate para configurar um terminal de VPN IPSec. Para obter mais informações, consulte esta postagem do blog em [Conectando um cluster a um data center local![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).</li></ul></dd>
  <dt>Monitoramento contínuo e criação de log de atividade do cluster</dt>
    <dd>Para clusters padrão, todos os eventos relacionados ao cluster, como incluir um nó do trabalhador, atualizar continuamente o progresso ou as informações de uso de capacidade podem ser registrados e monitorados pelo {{site.data.keyword.containershort_notm}} e enviados para {{site.data.keyword.loganalysislong_notm}} e o {{site.data.keyword.monitoringlong_notm}}. Para obter informações sobre como configurara criação de log e o monitoramento, consulte [Configurando clusters de log](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_logging) e [Configurando o monitoramento de cluster](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_monitoring).</dd>
</dl>

### Imagens
{: #cs_security_deployment}

Gerencie a segurança e integridade de suas imagens com recursos de segurança integrada.
{: shortdesc}

<dl>
<dt>Repositório seguro de imagem privada do Docker no {{site.data.keyword.registryshort_notm}}</dt>
<dd>É possível configurar o seu próprio repositório de imagem do Docker em um registro de imagem privada de múltiplos locatários, altamente disponível e escalável que é hospedado pela IBM para construir, armazenar com segurança e compartilhar imagens do Docker entre usuários de cluster.</dd>

<dt>Conformidade de segurança de imagem</dt>
<dd>Quando você usar o {{site.data.keyword.registryshort_notm}}, será possível alavancar a varredura de segurança integrada que é fornecida pelo Vulnerability Advisor. Cada imagem enviada por push para o seu namespace é varrida automaticamente para obter vulnerabilidades com relação a um banco de dados de problemas conhecidos do CentOS, Debian, Red Hat e Ubuntu. Se vulnerabilidades forem localizadas, o Vulnerability Advisor fornecerá instruções de como resolvê-las para assegurar a integridade e segurança da imagem.</dd>
</dl>

Para visualizar a avaliação de vulnerabilidade para suas imagens, [revise a documentação do Vulnerability Advisor](/docs/services/va/va_index.html#va_registry_cli).

<br />


## Abrindo portas e endereços IP necessários em seu firewall
{: #opening_ports}

Revise essas situações nas quais pode ser necessário abrir portas e endereços IP específicos em seus firewalls:
* [Para executar comandos `bx` ](#firewall_bx) de seu sistema local quando as políticas de rede corporativa impedem o acesso aos terminais de Internet pública por meio de proxies ou de firewalls.
* [Para executar comandos `kubectl`](#firewall_kubectl) em seu sistema local quando políticas de rede corporativas evitam acesso a terminais de Internet pública por meio de proxies ou de firewalls.
* [Para executar comandos `calicoctl` ](#firewall_calicoctl)de seu sistema local quando as políticas de rede corporativa impedem o acesso aos terminais de Internet pública por meio de proxies ou de firewalls.
* [Para permitir a comunicação entre o mestre do Kubernetes e os nós do trabalhador](#firewall_outbound) quando um firewall for configurado para os nós do trabalhador ou as configurações de firewall forem customizadas em sua conta de infraestrutura do IBM Cloud (SoftLayer).
* [Para acessar o serviço NodePort, o serviço LoadBalancer ou o Ingress de fora do cluster](#firewall_inbound).

### Executando comandos `bx cs` por trás de um firewall
{: #firewall_bx}

Se as políticas de rede corporativa impedirem o acesso de seu sistema local a terminais públicos por proxies ou firewalls, para executar os comandos `bx cs`, deve-se permitir acesso TCP ao {{site.data.keyword.containerlong_notm}}.

1. Permita o acesso a `containers.bluemix.net` na porta 443.
2. Verifique sua conexão. Se o acesso for configurado corretamente, navios serão exibidos na saída.
   ```
   curl https://containers.bluemix.net/v1/
   ```
   {: pre}

   Saída de exemplo:
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}

### Executando comandos `kubectl` por trás de um firewall
{: #firewall_kubectl}

Se as políticas de rede corporativa impedirem o acesso de seu sistema local a terminais públicos por proxies ou firewalls, para executar os comandos `kubectl`, deve-se permitir o acesso TCP para o cluster.

Quando um cluster é criado, a porta na URL principal é designada aleatoriamente de 20000 a 32767. É possível escolher abrir o intervalo de portas 20000 a 32767 para qualquer cluster que pode ser criado ou é possível escolher permitir o acesso a um cluster existente específico.

Antes de iniciar, permita acesso aos comandos [executar `bx cs`](#firewall_bx).

Para permitir acesso para um cluster específico:

1. Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitadas. Se você tiver uma conta federada, inclua a opção `--sso`.

    ```
    bx login [--sso]
    ```
    {: pre}

2. Selecione a região em que seu cluster está dentro.

   ```
   bx cs region-set
   ```
   {: pre}

3. Obtenha o nome do cluster.

   ```
   bx cs clusters
   ```
   {: pre}

4. Recupere a **URL principal** para seu cluster.

   ```
   bx cs cluster-get <cluster_name_or_id>
   ```
   {: pre}

   Saída de exemplo:
   ```
   ...
   URL principal:		https://169.46.7.238:31142
   ...
   ```
   {: screen}

5. Permita acesso à **URL principal** na porta, como a porta `31142` no exemplo anterior.

6. Verifique sua conexão.

   ```
   curl --insecure <master_URL>/version
   ```
   {: pre}

   Exemplo de comando:
   ```
   curl --insecure https://169.46.7.238:31142/version
   ```
   {: pre}

   Saída de exemplo:
   ```
   {
     "major": "1",
     "minor": "7+",
     "gitVersion": "v1.7.4-2+eb9172c211dc41",
     "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
     "gitTreeState": "clean",
     "buildDate": "2017-11-16T08:13:08Z",
     "goVersion": "go1.8.3",
     "compiler": "gc",
     "platform": "linux/amd64"
   }
   ```
   {: screen}

7. Opcional: repita essas etapas para cada cluster que você precisa expor.

### Executando comandos `calicoctl` por trás de um firewall
{: #firewall_calicoctl}

Se as políticas de rede corporativa impedem o acesso de seu sistema local a terminais públicos por proxies ou firewalls, para executar comandos `calicoctl`, deve-se permitir acesso TCP aos comandos do Calico.

Antes de iniciar, permita acesso aos comandos [`bx` ](#firewall_bx) e aos comandos [`kubectl`](#firewall_kubectl).

1. Recupere o endereço IP da URL principal que você usou para permitir os comandos [`kubectl`](#firewall_kubectl).

2. Obtenha a porta para ETCD.

  ```
  kubectl get cm -n kube-system calico-config -o yaml | grep etcd_endpoints
  ```
  {: pre}

3. Permita acesso para as políticas do Calico por meio do endereço IP principal da URL e a porta ETCD.

### Permitindo o cluster para acessar recursos de infraestrutura e outros serviços
{: #firewall_outbound}

  1.  Observe o endereço IP público para todos os nós do trabalhador no cluster.

      ```
      bx cs workers <cluster_name_or_id>
      ```
      {: pre}

  2.  Permita tráfego de rede de saída da origem _<each_worker_node_publicIP>_ para o intervalo de portas TCP/UDP de destino 20000 a 32767 e a porta 443 e os seguintes endereços IP e grupos de rede. Se você tiver um firewall corporativo que impede sua máquina local de acessar terminais de Internet pública, execute essa etapa para os nós do trabalhador de origem e sua máquina local.
      - **Importante**: deve-se permitir o tráfego de saída para a porta 443 para todos os locais dentro da região, para equilibrar a carga durante o processo de autoinicialização. Por exemplo, se o seu cluster estiver no Sul dos EUA, deve-se permitir o tráfego da porta 443 para os endereços IP para todos os locais (dal10, dal12 e dal13).
      <p>
  <table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
      <thead>
      <th>Região</th>
      <th>Localização</th>
      <th>Endereço IP</th>
      </thead>
    <tbody>
      <tr>
        <td>AP Norte</td>
        <td>hkg02<br>tok02</td>
        <td><code>169.56.132.234</code><br><code>161.202.126.210</code></td>
       </tr>
      <tr>
         <td>AP Sul</td>
         <td>mel01<br>syd01<br>syd04</td>
         <td><code>168.1.97.67</code><br><code>168.1.8.195</code><br><code>130.198.64.19, 130.198.66.34</code></td>
      </tr>
      <tr>
         <td>União Europeia Central</td>
         <td>ams03<br>fra02<br>mil01<br>par01</td>
         <td><code>169.50.169.106, 169.50.154.194</code><br><code>169.50.56.170, 169.50.56.174</code><br><code>159.122.190.98</code><br><code>159.8.86.149, 159.8.98.170</code></td>
        </tr>
      <tr>
        <td>Sul do Reino Unido</td>
        <td>lon02<br>lon04</td>
        <td><code>159.122.242.78</code><br><code>158.175.65.170, 158.175.74.170, 158.175.76.2</code></td>
      </tr>
      <tr>
        <td>Leste dos EUA</td>
         <td>tor01<br>wdc06<br>wdc07</td>
         <td><code>169.53.167.50</code><br><code>169.60.73.142</code><br><code>169.61.83.62</code></td>
      </tr>
      <tr>
        <td>SUL dos EUA</td>
        <td>dal10<br>dal12<br>dal13</td>
        <td><code>169.47.234.18, 169.46.7.234</code><br><code>169.47.70.10</code><br><code>169.60.128.2</code></td>
      </tr>
      </tbody>
    </table>
</p>

  3.  Permita o tráfego de rede de saída dos nós do trabalhador para o {{site.data.keyword.registrylong_notm}}:
      - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
      - Substitua <em>&lt;registry_publicIP&gt;</em> por todos os endereços para as regiões de registro para as quais você deseja permitir o tráfego:
        <p>
<table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
      <thead>
        <th>Região do contêiner</th>
        <th>Endereço de registro</th>
        <th>Endereço IP de registro</th>
      </thead>
      <tbody>
        <tr>
          <td>AP Norte, AP Sul</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></td>
        </tr>
        <tr>
          <td>União Europeia Central</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></td>
         </tr>
         <tr>
          <td>Sul do Reino Unido</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></td>
         </tr>
         <tr>
          <td>Leste dos EUA, Sul dos EUA</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></td>
         </tr>
        </tbody>
      </table>
</p>

  4.  Opcional: permita o tráfego de rede de saída dos nós do trabalhador para os serviços do {{site.data.keyword.monitoringlong_notm}} e do {{site.data.keyword.loganalysislong_notm}}:
      - `TCP port 443, port 9095 FROM <each_worker_node_publicIP> TO <monitoring_publicIP>`
      - Substitua <em>&lt;monitoring_publicIP&gt;</em> por todos os endereços para as regiões de monitoramento para as quais você deseja permitir o tráfego:
        <p><table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
        <thead>
        <th>Região do contêiner</th>
        <th>Endereço de monitoramento</th>
        <th>Endereços IP de monitoramento</th>
        </thead>
      <tbody>
        <tr>
         <td>União Europeia Central</td>
         <td>Metrics.eu-de.bluemix.net</td>
         <td><code>159.122.78.136/29</code></td>
        </tr>
        <tr>
         <td>Sul do Reino Unido</td>
         <td>Metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>Leste dos EUA, Sul dos EUA, AP Norte</td>
          <td>Metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
      - `TCP port 443, port 9091 FROM <each_worker_node_publicIP> TO <logging_publicIP>`
      - Substitua <em>&lt;logging_publicIP&gt;</em> por todos os endereços para as regiões de criação de log para as quais você deseja permitir tráfego:
        <p><table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
        <thead>
        <th>Região do contêiner</th>
        <th>Endereço de criação de log</th>
        <th>Endereços IP de log</th>
        </thead>
        <tbody>
          <tr>
            <td>Leste dos EUA, Sul dos EUA</td>
            <td>ingest.logging.ng.bluemix.net</td>
            <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
           </tr>
          <tr>
           <td>UE Central, Sul do Reino Unido</td>
           <td>ingest-eu-fra.logging.bluemix.net</td>
           <td><code>158.177.88.43</code><br><code>159.122.87.107</code></td>
          </tr>
          <tr>
           <td>AP Sul, AP Norte</td>
           <td>ingest-au-syd.logging.bluemix.net</td>
           <td><code>130.198.76.125</code><br><code>168.1.209.20</code></td>
          </tr>
         </tbody>
       </table>
</p>

  5. Para firewalls privados, permita os intervalos de IP privado da infraestrutura apropriada do IBM Cloud (SoftLayer). Consulte [este link](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) iniciando com a seção **Rede de backend (privada)**.
      - Inclua todos os [locais dentro das regiões](cs_regions.html#locations) que você está usando.
      - Observe que se deve incluir o local de dal01 (data center).
      - Abra as portas 80 e 443 para permitir o processo de autoinicialização do cluster.

  6. Para criar solicitações de volume persistentes para armazenamento de dados, permita acesso de egresso por meio de seu firewall para [endereços IP da infraestrutura do IBM Cloud (SoftLayer)](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) do local (data center) em que seu cluster está.
      - Para localizar o local (data center) de seu cluster, execute `bx cs clusters`.
      - Permita acesso ao intervalo de IP para a **Rede frontend (pública)** e a **Rede backend (privada)**.
      - Observe que se deve incluir o local de dal01 (data center) para a **Rede backend (privada)**.

### Acessando o NodePort, o balanceador de carga e os serviços do Ingress de fora do cluster
{: #firewall_inbound}

É possível permitir acesso de entrada para o NodePort, o balanceador de carga e os serviços do Ingress.

<dl>
  <dt>Serviço NodePort</dt>
  <dd>Abra a porta que você configurou quando implementou o serviço aos endereços IP públicos para todos os nós do trabalhador para permitir o tráfego. Para localizar a porta, execute `kubectl get svc`. A porta está no intervalo de 20000 a 32000.<dd>
  <dt>Serviço LoadBalancer</dt>
  <dd>Abra a porta que você configurou quando implementou o serviço para o endereço IP público do serviço do balanceador de carga.</dd>
  <dt>Entrada</dt>
  <dd>Abra a porta 80 para HTTP ou a porta 443 para HTTPS para o endereço IP para o balanceador de carga do aplicativo Ingress.</dd>
</dl>

<br />


## Configurando o diagrama Helm da conectividade de VPN com a VPN do Strongswan IPSec
{: #vpn}

A conectividade da VPN permite que você conecte seguramente apps em um cluster do Kubernetes a uma rede no local. Também é possível conectar apps que são externos ao seu cluster para um app que está em execução dentro de seu cluster. Para configurar a conectividade VPN, é possível usar um diagrama Helm para configurar e implementar o [serviço Helm do Strongswan IPSec![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.strongswan.org/) dentro de um pod do Kubernetes. Todo o tráfego de VPN é, então, roteado por meio deste pod. Para obter mais informações sobre os comandos Helm usado para configurar o gráfico do Strongswan, consulte a [documentação do Helm ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.helm.sh/helm/).

Antes de iniciar:

- [Crie um cluster padrão.](cs_cluster.html#cs_cluster_cli)
- [Se você estiver usando um cluster existente, atualize a versão 1.7.4 ou mais recente.](cs_cluster.html#cs_cluster_update)
- O cluster deve ter pelo menos um endereço IP público disponível do balanceador de carga.
- [Destine a CLI do Kubernetes para o cluster](cs_cli_install.html#cs_cli_configure).

Para configurar a conectividade da VPN com o Strongswan:

1. Se ele ainda não estiver ativado, instale e inicialize o Helm para seu cluster.

    1. [Instale a CLI do Helm ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.helm.sh/using_helm/#installing-helm).

    2. Inicialize o Helm e instale o `tiller`.

        ```
        helm init
        ```
        {: pre}

    3. Verifique se o pod `tiller-deploy` tem o status `Running` em seu cluster.

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        Saída de exemplo:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. Inclua o repositório Helm do {{site.data.keyword.containershort_notm}} para sua instância do Helm.

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Verifique se o gráfico do Strongswan está listado no repositório Helm.

        ```
        helm search bluemix
        ```
        {: pre}

2. Salve as definições de configuração padrão para o diagrama Helm do Strongswan em um arquivo YAML local.

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. Abra o arquivo `config.yaml` e faça as mudanças a seguir para os valores padrão de acordo com a configuração de VPN que você desejar. Se uma propriedade tiver configurado opções para valores, elas serão listadas em comentários sobre cada propriedade no arquivo. **Importante**: se não for necessário mudar uma propriedade, deixe um comentário nessa propriedade, colocando um `#` na frente dela.

    <table>
    <caption>Tabela 2. Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>Se você tiver um arquivo <code>ipsec.conf</code> existente que você deseja usar, remova as chaves (<code>{}</code>) e inclua o conteúdo do arquivo após essa propriedade. Os conteúdos do arquivo devem ser indentados. **Observação:** se você usar seu próprio arquivo, quaisquer valores para as seções <code>ipsec</code>, <code>local</code> e <code>remote</code> não serão usadas.</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>Se você tiver um arquivo <code>ipsec.secrets</code> existente que deseja usar, remova as chaves (<code>{}</code>) e inclua o conteúdo do arquivo após essa propriedade. Os conteúdos do arquivo devem ser indentados. **Observação:** se você usar seu próprio arquivo, nenhum valor para a seção <code>preshared</code> será usado.</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>Se seu terminal de túnel de VPN local não suportar o <code>ikev2</code> como um protocolo para inicializar a conexão, mude esse valor para <code>ikev1</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>Mude esse valor para a lista de algoritmos de criptografia/autenticação ESP que o seu terminal de túnel de VPN local usa para a conexão.</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>Mude esse valor para a lista de algoritmos de criptografia/autenticação IKE/ISAKMP SA que o seu terminal de túnel da VPN local usa para a conexão.</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>Se você deseja que o cluster inicie a conexão de VPN, mude esse valor para <code>start</code>.</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>Mude esse valor para a lista de CIDRs de sub-rede de cluster que deve ser exposta durante a conexão de VPN com a rede local. Essa lista pode incluir as seguintes sub-redes: <ul><li>O CIDR de sub-rede de pod do Kubernetes: <code>172.30.0.0/16</code></li><li>O CIDR de sub-rede do serviço do Kubernetes: <code>172.21.0.0/16</code></li><li>Se você tiver aplicativos expostos por um serviço NodePort na rede privada, o CIDR de sub-rede privada do nó do trabalhador. Para encontrar esse valor, execute <code>bx cs subnets | grep <xxx.yyy.zzz></code>, em que &lt;xxx.yyy.zzz&gt; são os três primeiros octectos do endereço IP privado do nó do trabalhador.</li><li>Se você tiver aplicativos expostos pelos serviços LoadBalancer na rede privada, os CIDRs de sub-rede privados ou gerenciados pelo usuário do cluster. Para encontrar esses valores, execute <code>bx cs cluster-get <cluster name> --showResources</code>. Na seção <b>VLANS</b>, procure os CIDRs que possuem um valor <b>público</b> de <code>false</code>.</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>Mude esse valor para o identificador de sequência para o lado cluster do Kubernetes local que o seu terminal de túnel da VPN usa para a conexão.</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>Mude esse valor para o endereço IP público para o gateway da VPN no local.</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Mude esse valor para a lista de CIDRs de sub-rede privada local a qual os clusters do Kubernetes têm permissão para acessar.</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>Mude esse valor para o identificador de sequência para o lado local remoto que o seu terminal de túnel da VPN usa para a conexão.</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>Mude esse valor para o segredo pré-compartilhado que o gateway do terminal do túnel da VPN local usa para a conexão.</td>
    </tr>
    </tbody></table>

4. Salve o arquivo `config.yaml` atualizado.

5. Instale o diagrama Helm em seu cluster com o arquivo `config.yaml` atualizado. As propriedades atualizadas são armazenadas em um mapa de configuração para seu gráfico.

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. Verifique o status de implementação do gráfico. Quando o gráfico estiver pronto, o campo **STATUS** perto da parte superior da saída terá um valor de `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

7. Quando o gráfico for implementado, verifique se as configurações atualizadas no arquivo `config.yaml` foram usadas.

    ```
    helm get values vpn
    ```
    {: pre}

8. Teste a nova conectividade da VPN.
    1. Se a VPN no gateway local não estiver ativo, inicie a VPN.

    2. Configure a variável de ambiente `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. Verifique o status da VPN. Um status de `ESTABLISHED` significa que a conexão de VPN foi bem-sucedida.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        Saída de exemplo:
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

        **Nota**:
          - É altamente provável que a VPN não tenha um status de `ESTABLISHED` na primeira vez que você usa esse diagrama Helm. Você pode precisar verificar as configurações do terminal de VPN local e retornar para a etapa 3 para mudar o arquivo `config.yaml` várias vezes antes que a conexão seja bem-sucedida.
          - Se o pod VPN está em um estado de `ERROR` ou continua travando e reiniciando, pode ser devido à validação do parâmetro das configurações `ipsec.conf` no mapa de configuração do gráfico. Para ver se este é o caso, verifique se há erros de validação nos logs do pod do Strongswan, executando `kubectl logs -n kube-system $STRONGSWAN_POD`. Se houver erros de validação, execute `helm delete --purge vpn`, retorne para a etapa 3 para corrigir os valores incorretos no arquivo `config.yaml` e repita as etapas 4 e 8. Se o seu cluster tem um alto número de nós do trabalhador, também será possível utilizar o `helm upgrade` para aplicar mais rapidamente suas mudanças, em vez de executar o `helm delete` e o `helm install`.

    4. Quando a VPN tiver um status de `ESTABLISHED`, teste a conexão com o `ping`. O exemplo a seguir envia um ping do pod da VPN no cluster do Kubernetes para o endereço IP privado do gateway da VPN local. Certifique-se de que `remote.subnet` e `local.subnet` sejam especificados no arquivo de configuração e que a lista de sub-rede local inclua o endereço IP de origem do qual você está enviando o ping.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

Para desativar o serviço de VPN do Strongswan IPSec:

1. Exclua o diagrama Helm.

    ```
    helm delete --purge vpn
    ```
    {: pre}

<br />


## Políticas de rede
{: #cs_security_network_policies}

Cada cluster do Kubernetes é configurado com um plug-in de rede que é chamado Calico. As políticas de rede padrão são configuradas para assegurar a interface de rede pública de cada nó do trabalhador. É possível usar o Calico e os recursos nativo do Kubernetes para configurar mais políticas de rede para um cluster quando você tem requisitos de segurança exclusivos. Essas políticas de rede especificam o tráfego de rede que você deseja permitir ou bloquear para/de um pod em um cluster.
{: shortdesc}

É possível escolher entre o Calico e os recursos nativos do Kubernetes para criar políticas de rede para seu cluster. Você pode usar políticas de rede do Kubernetes para começar, mas para recursos mais robustos, use as políticas de rede do Calico.

<ul>
  <li>[Políticas de rede do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): algumas opções básicas são fornecidas, como a especificação de quais pods podem se comunicar entre si. O tráfego de rede recebido pode ser permitido ou bloqueado para um protocolo e uma porta. Esse tráfego pode ser filtrado com base nos rótulos e namespaces do Kubernetes do pod que está tentando se conectar a outros pods.</br>Essas políticas podem ser aplicadas usando comandos `kubectl` ou as APIs do Kubernetes. Quando essas políticas são aplicadas, elas são
convertidas em políticas de rede do Calico e o Calico impinge essas políticas.</li>
  <li>[Políticas de rede do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://docs.projectcalico.org/v2.4/getting-started/kubernetes/tutorials/advanced-policy): essas políticas são um superconjunto das políticas de rede do Kubernetes e aprimoram as capacidades nativas do Kubernetes com os recursos a seguir.</li>
    <ul><ul><li>Permitir ou bloquear tráfego de rede em interfaces de rede específicas, não somente o tráfego de pod do Kubernetes.</li>
    <li>Permitir ou bloquear tráfego de rede recebido (ingresso) e de saída (egresso).</li>
    <li>[Bloquear tráfego recebido (ingresso) para os serviços LoadBalancer ou NodePort Kubernetes](#cs_block_ingress).</li>
    <li>Permitir ou bloquear o tráfego que é baseado em um endereço IP de origem ou destino ou CIDR.</li></ul></ul></br>

Essas políticas são aplicadas usando comandos `calicoctl`. O Calico impinge essas políticas, que incluem quaisquer políticas de rede do Kubernetes que são convertidas em políticas do Calico, configurando regras iptables do Linux nos nós do trabalhador do Kubernetes. As regras de Iptables servem como um firewall para o nó do trabalhador para definir as características que o tráfego de rede deve atender para ser encaminhado para o recurso de destino.</ul>


### Configuração de política padrão
{: #concept_nq1_2rn_4z}

Quando um cluster é criado, as políticas de rede padrão são configuradas automaticamente para a interface de rede pública de cada nó do trabalhador para limitar o tráfego recebido para um nó do trabalhador na Internet pública. Essas políticas não afetam o tráfego de pod para pod e são configuradas para permitir acesso à porta de nó do Kubernetes, ao balanceador de carga e aos serviços do Ingresso.

As políticas padrão não são aplicadas a pods diretamente; elas são aplicadas à interface de rede pública de um nó do trabalhador usando um terminal de host do Calico. Quando um terminal de host é criado no Calico, todo o tráfego para/da interface de rede desse nó do trabalhador é bloqueado, a menos que o tráfego seja permitido por uma política.

**Importante:** não remova as políticas aplicadas a um terminal de host, a menos que você entenda completamente a política e saiba que não precisará do tráfego que está sendo permitido pela política.


 <table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
 <caption>Tabela 3. Políticas padrão para cada cluster</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Políticas padrão para cada cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Permite todo o tráfego de saída.</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>Permite o tráfego recebido na porta 52311 para o app bigfix para permitir as atualizações necessárias do nó do trabalhador.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Permite pacotes icmp recebidos (pings).</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Permite o tráfego recebido da porta de nó, do balanceador de carga e do serviço de ingresso para os pods que esses serviços estão expondo. Observe que a porta que esses serviços expõem na interface pública não precisa ser especificada, porque o Kubernetes usa a conversão de endereço de rede de destino (DNAT) para encaminhar essas solicitações de serviço para os pods corretos. Esse redirecionamento ocorre antes que as políticas de terminal de host sejam aplicadas aos iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Permite conexões recebidas para sistemas específicos da infraestrutura do IBM Cloud (SoftLayer) que são usados para gerenciar os nós do trabalhador.</td>
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

Antes de iniciar:

1.  [Instale as CLIs do {{site.data.keyword.containershort_notm}} e do Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Crie um cluster lite ou padrão.](cs_cluster.html#cs_cluster_ui)
3.  [Destine a CLI do Kubernetes para o cluster](cs_cli_install.html#cs_cli_configure). Inclua a opção `--admin` com o comando `bx cs cluster-config`, que é usado para fazer download dos certificados e arquivos de permissão. Este download também inclui as chaves para a função de Super Usuário, que você precisa para executar comandos do Calico.

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **Nota**: a CLI do Calico versão 1.6.1 é suportada.

Para incluir políticas de rede:
1.  Instale a CLI do Calico.
    1.  [Faça download da CLI do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1).

        **Dica:** se estiver usando o Windows, instale a CLI do Calico no mesmo diretório que a CLI do {{site.data.keyword.Bluemix_notm}}. Essa configuração economiza algumas
mudanças de caminho de arquivo ao executar comandos posteriormente.

    2.  Para usuários do OSX e Linux, conclua as etapas a seguir.
        1.  Mova o arquivo executável para o diretório /usr/local/bin.
            -   Linux:

              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   S.O. X:

              ```
              mv /<path_to_file>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Torne o arquivo executável.

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

    1.  Para S.O. Linux e X, crie o diretório `/etc/calico`. Para Windows, qualquer diretório pode ser usado.

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Crie um arquivo `calicoctl.cfg`.
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
        {: codeblock}

        1.  Recupere o `<ETCD_URL>`. Se este comando falhar com um erro `calico-config not found`, consulte este [tópico de resolução de problemas](cs_troubleshoot.html#cs_calico_fails).

          -   Linux e OS X:

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   Exemplo de saída:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Obtenha os valores de configuração calico do mapa de configuração. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>Na seção de `dados`, localize o valor etcd_endpoints. Exemplo: <code>https://169.1.1.1:30001</code>
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
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows:
              <ol><li>Abra o diretório que você recuperou na última etapa.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
              <li> Localize o arquivo <code>ca-*pem_file</code>.</ol>

        4.  Verifique se a configuração do Calico está funcionando
corretamente.

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

### Bloquear tráfego recebido para serviços LoadBalancer ou NodePort.
{: #cs_block_ingress}

Por padrão, os serviços Kubernetes `NodePort` e `LoadBalancer` são projetados para tornar seu app disponível em todas as interfaces do cluster públicas e privadas. No entanto, é possível bloquear o tráfego recebido para seus serviços com base na origem ou no destino do tráfego. Para bloquear o tráfego, crie políticas de rede do Calico `preDNAT`.

Um serviço Kubernetes LoadBalancer também é um serviço NodePort. Um serviço LoadBalancer torna seu app disponível pelo endereço IP do balanceador de carga e a porta e torna seu app disponível na(s) porta(s) do nó do serviço. As portas de nó são acessíveis em cada endereço IP (público e privado) para cada nó no cluster.

O administrador de cluster pode usar as políticas de rede Calico `preDNAT` para bloquear:

  - Tráfego para serviços NodePort. O tráfego para serviços LoadBalancer é permitido.
  - O tráfego que é baseado em um endereço de origem ou CIDR.

Alguns usos comuns para políticas de rede Calico `preDNAT`:

  - Bloquear tráfego para as portas de nós públicos de um serviço LoadBalancer privado.
  - Bloquear tráfego para as portas de nós públicos em clusters que estão executando os [nós do trabalhador de borda](#cs_edge). Bloquear as portas de nós assegura que os nós do trabalhador de borda sejam os únicos nós do trabalhador que manipulam o tráfego recebido.

As políticas de rede `preDNAT` são úteis porque as políticas padrão Kubernetes e Calico são difíceis de aplicar à proteção dos serviços Kubernetes NodePort e LoadBalancer devido às regras iptables DNAT geradas para esses serviços.

As políticas de rede Calico `preDNAT` geram regras iptables com base em um [recurso de política de rede Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v2.4/reference/calicoctl/resources/policy).

1. Defina uma política de rede Calico `preDNAT` para acesso de ingresso aos serviços do Kubernetes.

  Exemplo que bloqueia todas as portas de nós:

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. Aplique a política de rede Calico preDNAT. Leva aproximadamente 1 minuto para as mudanças de política serem aplicadas em todo o cluster.

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}

<br />



## Restringindo o tráfego de rede para os nós do trabalhador de borda
{: #cs_edge}

Inclua o rótulo `dedicated=edge` em dois ou mais nós do trabalhador em seu cluster para assegurar que o Ingresso e os balanceadores de carga sejam implementados somente nesses nós do trabalhador.

Os nós do trabalhador de borda podem melhorar a segurança de seu cluster, permitindo que menos nós do trabalhador sejam acessados externamente e isolando a carga de trabalho de rede. Quando esses nós do trabalhador são marcados somente para rede, outras cargas de trabalho não podem consumir a CPU ou memória do nó do trabalhador e interferir na rede.

Antes de iniciar:

- [Crie um cluster padrão.](cs_cluster.html#cs_cluster_cli)
- Assegure-se de que seu cluster tem pelo menos uma VLAN pública. Os nós do trabalhador de borda não estão disponíveis para clusters somente com VLANs privadas.
- [Destine a CLI do Kubernetes para o cluster](cs_cli_install.html#cs_cli_configure).


1. Liste todos os nós do trabalhador no cluster. Use o endereço IP privado da coluna **NAME** para identificar os nós. Selecione pelo menos dois nós do trabalhador para serem os nós do trabalhador de borda. Usar dois ou mais nós do trabalhador melhora a disponibilidade dos recursos de rede.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated
  ```
  {: pre}

2. Rotule os nós do trabalhador com `dedicated=edge`. Após um nó do trabalhador ser marcado com `dedicated=edge`, todo Ingresso subsequente e balanceadores de carga são implementados em um nó do trabalhador de borda.

  ```
  kubectl label nodes <node_name> <node_name2> dedicated=edge
  ```
  {: pre}

3. Recupere todos os serviços existentes do balanceador de carga em seu cluster.

  ```
  kubectl get services --all-namespaces -o jsonpath='{range .items[*]}kubectl get service -n {.metadata.namespace} {.metadata.name} -o yaml | kubectl apply -f - :{.spec.type},{end}' | tr "," "\n" | grep "LoadBalancer" | cut -d':' -f1
  ```
  {: pre}

  Saída:

  ```
  kubectl get service -n <namespace> <name> -o yaml | kubectl apply -f
  ```
  {: screen}

4. Usando a saída da etapa anterior, copie e cole cada linha `kubectl get service`. Esse comando reimplementa o balanceador de carga para um nó do trabalhador de borda. somente balanceadores de carga públicos precisam ser reimplementados.

  Saída:

  ```
  service "<name>" configured
  ```
  {: screen}

Você rotulou os nós do trabalhador com `dedicated=edge` e reimplementou todos os balanceadores de carga existentes e o Ingresso para os nós do trabalhador de borda. Em seguida, evite que outras [cargas de trabalho sejam executadas em nós do trabalhador de ponta](#cs_edge_workloads) e [bloqueiem o tráfego de entrada para as portas de nós em nós do trabalhador](#cs_block_ingress).

### Evitar que cargas de trabalho sejam executadas em nós do trabalhador de borda
{: #cs_edge_workloads}

Um dos benefícios de nós do trabalhador de borda é que esses nós do trabalhador podem ser especificados para executar somente serviços de rede. Usar a tolerância `dedicated=edge` significa que todos os serviços de balanceador de carga e de Ingresso são implementados somente nos nós do trabalhador rotulados. No entanto, para evitar que outras cargas de trabalho sejam executadas em nós do trabalhador de borda e consumam recursos do nó do trabalhador, deve-se usar [contaminações do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/).

1. Liste todos os nós do trabalhador com o rótulo `edge`.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Aplique uma contaminação a cada nó do trabalhador que evita que os pods sejam executados no nó do trabalhador e que remove os pods que não possuem o rótulo `edge` do nó do trabalhador. Os pods removidos são reimplementados em outros nós do trabalhador com capacidade.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```

Agora, somente pods com a tolerância `dedicated=edge` são implementados em nós do trabalhador de borda.
