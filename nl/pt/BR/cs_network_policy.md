---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-27"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Controlando o tráfego com políticas de rede
{: #network_policies}

Cada cluster do Kubernetes é configurado com um plug-in de rede que é chamado Calico. As políticas de rede padrão são configuradas para assegurar a interface de rede pública de cada nó do trabalhador no {{site.data.keyword.containerlong}}.
{: shortdesc}

É possível usar o Calico e os recursos nativo do Kubernetes para configurar mais políticas de rede para um cluster quando você tem requisitos de segurança exclusivos. Essas políticas de rede especificam o tráfego de rede que você deseja permitir ou bloquear para/de um pod em um cluster. Você pode usar políticas de rede do Kubernetes para começar, mas para recursos mais robustos, use as políticas de rede do Calico.

<ul>
  <li>[Políticas de rede do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): algumas opções básicas são fornecidas, como a especificação de quais pods podem se comunicar entre si. O tráfego de rede recebido pode ser permitido ou bloqueado para um protocolo e uma porta. Esse tráfego pode ser filtrado com base nos rótulos e namespaces do Kubernetes do pod que está tentando se conectar a outros pods.</br>Essas políticas podem ser aplicadas usando comandos `kubectl` ou as APIs do Kubernetes. Quando essas políticas são aplicadas, elas são
convertidas em políticas de rede do Calico e o Calico impinge essas políticas.</li>
  <li>[Políticas de rede Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): essas políticas são um superconjunto das políticas de rede do Kubernetes e aprimoram as capacidades nativas do Kubernetes com os recursos a seguir.</li>
    <ul><ul><li>Permitir ou bloquear tráfego de rede em interfaces de rede específicas, não somente o tráfego de pod do Kubernetes.</li>
    <li>Permitir ou bloquear tráfego de rede recebido (ingresso) e de saída (egresso).</li>
    <li>[Bloquear tráfego recebido (ingresso) para os serviços LoadBalancer ou NodePort Kubernetes](#block_ingress).</li>
    <li>Permitir ou bloquear o tráfego que é baseado em um endereço IP de origem ou destino ou CIDR.</li></ul></ul></br>

Essas políticas são aplicadas usando comandos `calicoctl`. O Calico impinge essas políticas, que incluem quaisquer políticas de rede do Kubernetes que são convertidas em políticas do Calico, configurando regras iptables do Linux nos nós do trabalhador do Kubernetes. As regras de Iptables servem como um firewall para o nó do trabalhador para definir as características que o tráfego de rede deve atender para ser encaminhado para o recurso de destino.</ul>

<br />


## Configuração de política padrão
{: #default_policy}

Quando um cluster é criado, as políticas de rede padrão são configuradas para a interface de rede pública de cada nó do trabalhador para limitar o tráfego recebido da Internet pública. Essas políticas não afetam o tráfego de pod para pod e permitem o acesso ao nodeport do Kubernetes, ao balanceador de carga e aos serviços do Ingresso.
{:shortdesc}

As políticas padrão não são aplicadas a pods diretamente; elas são aplicadas à interface de rede pública de um nó do trabalhador usando um terminal de host do Calico. Quando um terminal de host é criado no Calico, todo o tráfego para/da interface de rede desse nó do trabalhador é bloqueado, a menos que o tráfego seja permitido por uma política.

**Importante:** não remova as políticas aplicadas a um terminal de host, a menos que você entenda completamente a política e saiba que não precisará do tráfego que está sendo permitido pela política.


 <table summary="A primeira linha na tabela abrange ambas as colunas. O resto das linhas deve ser lido da esquerda para a direita, com o local do servidor na coluna um e os endereços IP a serem correspondidos na coluna dois.">
 <caption>Políticas padrão para cada cluster</caption>
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

<br />


## Incluindo políticas de rede
{: #adding_network_policies}

Na maioria dos casos, as políticas padrão não precisam ser mudadas. Somente cenários avançados podem requerer mudanças. Se você achar que deve fazer mudanças, instale a CLI do Calico e crie suas próprias políticas de rede.
{:shortdesc}

Antes de iniciar:

1.  [Instale as CLIs do {{site.data.keyword.containershort_notm}} e do Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Crie um cluster grátis ou padrão.](cs_clusters.html#clusters_ui)
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

            -   S.O.
X:

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

    4.  Se as políticas de rede corporativa impedirem o acesso de seu sistema local a terminais públicos por proxies ou firewalls, veja [Executando comandos `calicoctl` por trás de um firewall](cs_firewall.html#firewall) para obter instruções sobre como permitir o acesso TCP para comandos do Calico.

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

4.  Crie as políticas de rede Calico para permitir ou bloquear o tráfego.

    1.  Defina sua [Política de rede Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) criando um script de configuração (.yaml). Esses arquivos de configuração incluem os seletores que descrevem a quais pods, namespaces ou hosts essas políticas se aplicam. Consulte essas [Políticas de amostra do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) para ajudá-lo a criar a sua própria.

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

<br />


## Bloquear tráfego recebido para serviços LoadBalancer ou NodePort.
{: #block_ingress}

Por padrão, os serviços Kubernetes `NodePort` e `LoadBalancer` são projetados para tornar seu app disponível em todas as interfaces do cluster públicas e privadas. No entanto, é possível bloquear o tráfego recebido para seus serviços com base na origem ou no destino do tráfego.
{:shortdesc}

Um serviço Kubernetes LoadBalancer também é um serviço NodePort. Um serviço LoadBalancer torna seu app disponível pelo endereço IP do balanceador de carga e a porta e torna seu app disponível na(s) porta(s) do nó do serviço. As portas de nó são acessíveis em cada endereço IP (público e privado) para cada nó no cluster.

O administrador de cluster pode usar as políticas de rede Calico `preDNAT` para bloquear:

  - Tráfego para serviços NodePort. O tráfego para serviços LoadBalancer é permitido.
  - O tráfego que é baseado em um endereço de origem ou CIDR.

Alguns usos comuns para políticas de rede Calico `preDNAT`:

  - Bloquear tráfego para as portas de nós públicos de um serviço LoadBalancer privado.
  - Bloquear tráfego para as portas de nós públicos em clusters que estão executando os [nós do trabalhador de borda](cs_edge.html#edge). Bloquear as portas de nós assegura que os nós do trabalhador de borda sejam os únicos nós do trabalhador que manipulam o tráfego recebido.

As políticas de rede `preDNAT` são úteis porque as políticas padrão Kubernetes e Calico são difíceis de aplicar à proteção dos serviços Kubernetes NodePort e LoadBalancer devido às regras iptables DNAT geradas para esses serviços.

As políticas de rede Calico `preDNAT` geram regras de iptables com base em um [recurso de
política de rede Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")] (https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

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
