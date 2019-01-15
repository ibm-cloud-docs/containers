---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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




# Abrindo portas e endereços IP necessários em seu firewall
{: #firewall}

Revise estas situações nas quais pode ser necessário abrir portas e endereços IP específicos em seus firewalls para o {{site.data.keyword.containerlong}}.
{:shortdesc}

* [Para executar comandos `ibmcloud`](#firewall_bx) em seu sistema local quando as políticas de rede corporativa evitam o acesso aos terminais de Internet pública por meio de proxies ou firewalls.
* [Para executar comandos `kubectl`](#firewall_kubectl) em seu sistema local quando políticas de rede corporativas evitam acesso a terminais de Internet pública por meio de proxies ou de firewalls.
* [Para executar comandos `calicoctl` ](#firewall_calicoctl)de seu sistema local quando as políticas de rede corporativa impedem o acesso aos terminais de Internet pública por meio de proxies ou de firewalls.
* [Para permitir a comunicação entre o mestre do Kubernetes e os nós do trabalhador](#firewall_outbound) quando um firewall for configurado para os nós do trabalhador ou as configurações de firewall forem customizadas em sua conta de infraestrutura do IBM Cloud (SoftLayer).
* [Para permitir que o cluster acesse recursos por meio de um firewall na rede privada](#firewall_private).
* [Para acessar o serviço NodePort, o serviço de balanceador de carga ou o Ingress de fora do cluster](#firewall_inbound).

<br />


## Executando comandos `ibmcloud ks` por trás de um firewall
{: #firewall_bx}

Se as políticas de rede corporativa evitam o acesso de seu sistema local a terminais públicos por meio de proxies ou firewalls, para executar os comandos `ibmcloud ks`, deve-se permitir acesso de TCP para o {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

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

<br />


## Executando comandos `kubectl` por trás de um firewall
{: #firewall_kubectl}

Se as políticas de rede corporativa impedirem o acesso de seu sistema local a terminais públicos por proxies ou firewalls, para executar os comandos `kubectl`, deve-se permitir o acesso TCP para o cluster.
{:shortdesc}

Quando um cluster é criado, a porta na URL principal é designada aleatoriamente de 20000 a 32767. É possível escolher abrir o intervalo de portas 20000 a 32767 para qualquer cluster que pode ser criado ou é possível escolher permitir o acesso a um cluster existente específico.

Antes de iniciar, permita acesso para [executar comandos `ibmcloud ks`](#firewall_bx).

Para permitir acesso para um cluster específico:

1. Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitadas. Se você tiver uma conta federada, inclua a opção `--sso`.

   ```
   ibmcloud login [ -- sso ]
   ```
   {: pre}

2. Se o cluster estiver em um grupo de recursos diferente de `default`, destine esse grupo de recursos. Para ver o grupo de recursos ao qual cada cluster pertence, execute `ibmcloud ks clusters`. **Nota**: deve-se ter pelo menos a [função **Visualizador**](cs_users.html#platform) para o grupo de recursos.
   ```
   ibmcloud target -g <resource_group_name>
   ```
   {: pre}

2. Selecione a região em que seu cluster está dentro.

   ```
   ibmcloud ks region-set
   ```
   {: pre}

3. Obtenha o nome do cluster.

   ```
   ibmcloud ks clusters
   ```
   {: pre}

4. Recupere a **URL principal** para seu cluster.

   ```
   ibmcloud ks cluster-get <cluster_name_or_ID>
   ```
   {: pre}

   Saída de exemplo:
   ```
   ...
   Master URL:		https://c3.<region>.containers.cloud.ibm.com
   ...
   ```
   {: screen}

5. Permita acesso ao **Master URL** na porta, como a porta `31142` do exemplo anterior.

6. Verifique sua conexão.

   ```
   curl --insecure <master_URL>/version
   ```
   {: pre}

   Exemplo de comando:
   ```
   curl --insecure https://c3.<region>.containers.cloud.ibm.com:31142/version
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

<br />


## Executando comandos `calicoctl` por trás de um firewall
{: #firewall_calicoctl}

Se as políticas de rede corporativa impedem o acesso de seu sistema local a terminais públicos por proxies ou firewalls, para executar comandos `calicoctl`, deve-se permitir acesso TCP aos comandos do Calico.
{:shortdesc}

Antes de iniciar, permita o acesso para executar [comandos `ibmcloud`](#firewall_bx) e [comandos `kubectl`](#firewall_kubectl).

1. Recupere o endereço IP da URL principal que você usou para permitir os comandos [`kubectl`](#firewall_kubectl).

2. Obtenha a porta para ETCD.

  ```
  kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
  ```
  {: pre}

3. Permita acesso para as políticas do Calico por meio do endereço IP principal da URL e a porta ETCD.

<br />


## Permitindo o cluster para acessar recursos de infraestrutura e outros serviços
{: #firewall_outbound}

Deixe seus recursos e serviços de infraestrutura de acesso ao cluster atrás de um firewall, como para regiões do {{site.data.keyword.containerlong_notm}}, {{site.data.keyword.registrylong_notm}}, {{site.data.keyword.monitoringlong_notm}}, {{site.data.keyword.loganalysislong_notm}}, IPs privados de infraestrutura do IBM Cloud (SoftLayer) e egresso para solicitações de volume persistente.
{:shortdesc}

1.  Anote o endereço IP público para todos os nós do trabalhador no cluster.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

2.  Permita tráfego de rede de saída da origem _<each_worker_node_publicIP>_ para o intervalo de portas TCP/UDP de destino 20000 a 32767 e a porta 443 e os seguintes endereços IP e grupos de rede. Se você tiver um firewall corporativo que impede sua máquina local de acessar terminais de Internet pública, execute essa etapa para os nós do trabalhador de origem e sua máquina local.

    Deve-se permitir o tráfego de saída para a porta 443 para todas as zonas dentro da região, para equilibrar a carga durante o processo de autoinicialização. Por exemplo, se seu cluster estiver no Sul dos EUA, o tráfego dos IPs públicos de cada um dos nós do trabalhador deverá ser permitido para a porta 443 do endereço IP para todas as zonas.
    {: important}

    <table summary="A primeira linha na tabela abrange ambas as colunas. O restante das linhas deve ser lido da esquerda para a direita, com a zona do servidor na coluna um e os endereços IP para corresponder na coluna dois.">
    <caption>Endereços IP a serem abertos para o tráfego de saída</caption>
        <thead>
        <th>Região</th>
        <th>Zona</th>
        <th>Endereço IP</th>
        </thead>
      <tbody>
        <tr>
          <td>AP Norte</td>
          <td>che01<br>hkg02<br>seo01<br>sng01<br>tok02, tok04, tok05</td>
          <td><code>169.38.70.10</code><br><code>169.56.132.234</code><br><code>169.56.69.242</code><br><code>161.202.186.226</code><br><code>161.202.126.210, 128.168.71.117, 165.192.69.69</code></td>
         </tr>
        <tr>
           <td>AP Sul</td>
           <td>mel01<br>syd01, syd04</td>
           <td><code>168.1.97.67</code><br><code>168.1.8.195, 130.198.66.26, 168.1.12.98, 130.198.64.19</code></td>
        </tr>
        <tr>
           <td>União Europeia Central</td>
           <td>ams03<br>mil01<br>osl01<br>par01<br>fra02, fra04, fra05</td>
           <td><code>169.50.169.110, 169.50.154.194</code><br><code> 159.122.190.98, 159.122.141.69 </code><br><code> 169.51.73.50 </code><br><code>159.8.86.149, 159.8.98.170</code><br><code>169.50.56.174, 161.156.65.42, 149.81.78.114</code></td>
          </tr>
        <tr>
          <td>Sul do Reino Unido</td>
          <td>lon02, lon04, lon05, lon06</td>
          <td><code>159.122.242.78, 158.175.111.42, 158.176.94.26, 159.122.224.242, 158.175.65.170, 158.176.95.146</code></td>
        </tr>
        <tr>
          <td>Leste dos EUA</td>
           <td>mon01<br>tor01<br>wdc04, wdc06, wdc07</td>
           <td><code>169.54.126.219</code><br><code>169.53.167.50</code><br><code>169.63.88.186, 169.60.73.142, 169.61.109.34, 169.63.88.178, 169.60.101.42, 169.61.83.62</code></td>
        </tr>
        <tr>
          <td>SUL dos EUA</td>
          <td>hou02<br>sao01<br>sjc03<br>sjc04<br>dal10,dal12,dal13</td>
          <td><code>184.173.44.62</code><br><code>169.57.151.10</code><br><code> 169.45.67.210 </code><br><code> 169.62.82.197 </code><br><code>169.46.7.238, 169.48.230.146, 169.61.29.194, 169.46.110.218, 169.47.70.10, 169.62.166.98, 169.48.143.218, 169.61.177.2, 169.60.128.2</code></td>
        </tr>
        </tbody>
      </table>

3.  Permita o tráfego de rede de saída dos nós do trabalhador para [regiões do {{site.data.keyword.registrylong_notm}}](/docs/services/Registry/registry_overview.html#registry_regions):
    - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
    - Substitua <em>&lt;registry_publicIP&gt;</em> pelos endereços IP de registro para os quais você deseja permitir o tráfego. O registro global armazena imagens públicas fornecidas pela IBM e os registros regionais armazenam suas próprias imagens privadas ou públicas.
      <p>
<table summary="A primeira linha na tabela abrange ambas as colunas. O restante das linhas deve ser lido da esquerda para a direita, com a zona do servidor na coluna um e os endereços IP para corresponder na coluna dois.">
  <caption>Endereços IP a serem abertos para o tráfego de Registro</caption>
      <thead>
        <th>Região do {{site.data.keyword.containerlong_notm}}</th>
        <th>Endereço de registro</th>
        <th>Endereço IP de registro</th>
      </thead>
      <tbody>
        <tr>
          <td>Registro global em {{site.data.keyword.containerlong_notm}} regiões</td>
          <td>registry.bluemix.net</td>
          <td><code>169.60.72.144/28</code></br><code>169.61.76.176/28</code></br><code>169.62.37.240/29</code></br><code>169.60.98.80/29</code></br><code>169.63.104.232/29></code></td>
        </tr>
        <tr>
          <td>AP Norte, AP Sul</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></br><code>168.1.1.240/29</code></br><code>130.198.88.128/29</code></td>
        </tr>
        <tr>
          <td>União Europeia Central</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></br><code> 169.50.58.104/ 29 </code></br><code>161.156.93.16/29</code></br><code> 149.81.79.152/ 29 </code></td>
         </tr>
         <tr>
          <td>Sul do Reino Unido</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></br><code> 158.175.97.184/ 29 </code></br><code> 158.176.105.64/ 29 </code></br><code>141.125.71.136/29</code></td>
         </tr>
         <tr>
          <td>Leste dos EUA, Sul dos EUA</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></br><code> 169.61.234.224/ 29 </code></br><code> 169.61.135.160/ 29 </code></br><code> 169.61.46.80/ 29 </code></td>
         </tr>
        </tbody>
      </table>
</p>

4.  Opcional: permita o tráfego de rede de saída dos nós do trabalhador para os serviços {{site.data.keyword.monitoringlong_notm}}, {{site.data.keyword.loganalysislong_notm}} e LogDNA:
    *   **{{site.data.keyword.monitoringlong_notm}}**:
        <pre class="screen">TCP port 443, port 9095 FROM &lt;each_worker_node_public_IP&gt; TO &lt;monitoring_public_IP&gt;</pre>
        Substitua <em>&lt;monitoring_public_IP&gt;</em> por todos os endereços das regiões de monitoramento para as quais você deseja permitir o tráfego:
        <p><table summary="A primeira linha na tabela abrange ambas as colunas. O restante das linhas deve ser lido da esquerda para a direita, com a zona do servidor na coluna um e os endereços IP para corresponder na coluna dois.">
  <caption>Endereços IP a serem abertos para o tráfego de monitoramento</caption>
        <thead>
        <th>Região do {{site.data.keyword.containerlong_notm}}</th>
        <th>Endereço de monitoramento</th>
        <th>Endereços IP de monitoramento</th>
        </thead>
      <tbody>
        <tr>
         <td>União Europeia Central</td>
         <td>Metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>Sul do Reino Unido</td>
         <td>Metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>Leste dos EUA, Sul dos EUA, AP Norte, AP Sul</td>
          <td>Metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
    *   **{{site.data.keyword.loganalysislong_notm}}**:
        <pre class="screen">TCP port 443, port 9091 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logging_public_IP&gt;</pre>
        Substitua <em>&lt;logging_public_IP&gt;</em> por todos os endereços das regiões de criação de log para as quais você deseja permitir o tráfego:
        <p><table summary="A primeira linha na tabela abrange ambas as colunas. O restante das linhas deve ser lido da esquerda para a direita, com a zona do servidor na coluna um e os endereços IP para corresponder na coluna dois.">
<caption>Endereços IP a serem abertos para o tráfego de criação de log</caption>
        <thead>
        <th>Região do {{site.data.keyword.containerlong_notm}}</th>
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
           <td>Sul do Reino Unido</td>
           <td>ingest.logging.eu-gb.bluemix.net</td>
           <td><code>169.50.115.113</code></td>
          </tr>
          <tr>
           <td>União Europeia Central</td>
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
    *   **{{site.data.keyword.la_full_notm}}**:
        <pre class="screen">TCP port 443, port 80 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logDNA_public_IP&gt;</pre>
        Substitua `<logDNA_public_IP>` com os [endereços IP de LogDNA](/docs/services/Log-Analysis-with-LogDNA/network.html#ips).

5. Se você usar os serviços de balanceador de carga, assegure-se de que todo o tráfego usando o protocolo VRRP seja permitido entre os nós do trabalhador nas interfaces pública e privada. O {{site.data.keyword.containerlong_notm}} usa o protocolo VRRP para gerenciar endereços IP para balanceadores de carga públicos e privados.

6. {: #pvc}Para criar solicitações de volume persistente para armazenamento de dados, permita acesso de egresso por meio de seu firewall para a infraestrutura do IBM Cloud (SoftLayer):
    - Permita que o acesso ao terminal de API da infraestrutura do IBM Cloud (SoftLayer) inicie solicitações de fornecimento: `TCP port 443 FROM <each_worker_node_public_IP> TO 66.228.119.120`.
    - Permita acesso ao intervalo de IP da infraestrutura do IBM Cloud (SoftLayer) para a zona em que seu cluster está na [ **rede Frontend (pública)**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#frontend-public-network) e na [**rede de back-end (privada)**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network). Para localizar a zona de seu cluster, execute `ibmcloud ks clusters`.

<br />


## Permitindo que o cluster acesse recursos por meio de um firewall privado
{: #firewall_private}

Se você tiver um firewall na rede privada, permita a comunicação entre os nós do trabalhador e permita que seu cluster acesse recursos de infraestrutura por meio da rede privada.
{:shortdesc}

1. Permitir todo o tráfego entre os nós do trabalhador.
    1. Permita todo o tráfego TCP, UDP, VRRP e IPEncap entre os nós do trabalhador nas interfaces pública e privada. O {{site.data.keyword.containerlong_notm}} usa o protocolo VRRP para gerenciar endereços IP para balanceadores de carga privados e o protocolo IPEncap para permitir o tráfego de pod para pod entre sub-redes.
    2. Se você usar políticas do Calico ou se tiver firewalls em cada zona de um cluster de múltiplas zonas, um firewall poderá bloquear a comunicação entre os nós do trabalhador. Deve-se abrir todos os nós do trabalhador no cluster entre si usando as portas dos trabalhadores, os endereços IP privados dos trabalhadores ou o rótulo do nó do trabalhador do Calico.

2. Permita os intervalos de IP privado da infraestrutura do IBM Cloud (SoftLayer) para que seja possível criar nós do trabalhador em seu cluster.
    1. Permita os intervalos apropriados de IP privado de infraestrutura do IBM Cloud (SoftLayer). Consulte  [ Rede de backend (privada) ](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network).
    2. Permita os intervalos de IP privado da infraestrutura do IBM Cloud (SoftLayer) para todas as [zonas](cs_regions.html#zones) que você está usando. Observe que é necessário incluir IPs para as zonas `dal01` e `wdc04`. Consulte  [ Rede de Serviço (na rede backend / privada) ](/docs/infrastructure/hardware-firewall-dedicated/ips.html#service-network-on-backend-private-network-).

3. Abra as portas a seguir:
    - Permita conexões TCP e UDP de saída dos trabalhadores para as portas 80 e 443 para permitir atualizações e recarregamentos do nó do trabalhador.
    - Permita TCP e UDP de saída para a porta 2049 para permitir o armazenamento de arquivo de montagem como volumes.
    - Permita TCP e UDP de saída para a porta 3260 para comunicação com o armazenamento de bloco.
    - Permita conexões TCP e UDP de entrada para a porta 10250 para o painel e comandos do Kubernetes, como `kubectl logs` e `kubectl exec`.
    - Permita conexões de entrada e de saída para a porta TCP e UDP 53 para acesso de DNS.

4. Se você também tem um firewall na rede pública ou se tem um cluster somente de VLAN privada e está usando um dispositivo de gateway como um firewall, deve-se também permitir os IPs e portas especificados em [Permitindo que o cluster acesse recursos de infraestrutura e outros serviços](#firewall_outbound).

<br />


## Acessando o NodePort, o balanceador de carga e os serviços do Ingress de fora do cluster
{: #firewall_inbound}

É possível permitir acesso de entrada para o NodePort, o balanceador de carga e os serviços do Ingress.
{:shortdesc}

<dl>
  <dt>Serviço NodePort</dt>
  <dd>Abra a porta que você configurou quando implementou o serviço aos endereços IP públicos para todos os nós do trabalhador para permitir o tráfego. Para localizar a porta, execute `kubectl get svc`. A porta está no intervalo de 20000 a 32000.<dd>
  <dt>Serviço de balanceador de carga</dt>
  <dd>Abra a porta que você configurou quando implementou o serviço para o endereço IP público do serviço do balanceador de carga.</dd>
  <dt>Entrada</dt>
  <dd>Abra a porta 80 para HTTP ou a porta 443 para HTTPS para o endereço IP para o balanceador de carga do aplicativo Ingress.</dd>
</dl>
