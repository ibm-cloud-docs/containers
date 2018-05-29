---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

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


# Resolução de problemas de rede do cluster
{: #cs_troubleshoot_network}

Ao usar o {{site.data.keyword.containerlong}}, considere estas técnicas para resolução de problemas de rede do cluster.
{: shortdesc}

Se você tiver um problema mais geral, tente a [depuração do cluster](cs_troubleshoot.html).
{: tip}

## Não é possível se conectar a um app por meio de um serviço de balanceador de carga
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Você expôs publicamente seu app criando um serviço de balanceador de carga no cluster. Quando tentou se conectar ao app por meio do endereço IP público ou do balanceador de carga, a conexão falhou ou atingiu o tempo limite.

{: tsCauses}
O serviço de balanceador de carga pode não estar funcionando corretamente por um dos motivos a seguir:

-   O cluster é um cluster grátis ou um cluster padrão com somente um nó do trabalhador.
-   O cluster não está totalmente implementado ainda.
-   O script de configuração para o serviço de balanceador de carga inclui erros.

{: tsResolve}
Para solucionar problemas do serviço de balanceador de carga:

1.  Verifique se configura um cluster padrão totalmente implementado e se tem pelo menos dois nós do trabalhador para assegurar alta disponibilidade para o serviço de balanceador de carga.

  ```
  bx cs workers <cluster_name_or_ID>
  ```
  {: pre}

    Na saída da CLI, certifique-se de que o **Status** dos nós do trabalhador exiba **Pronto** e que o **Tipo de máquina** mostre um tipo de máquina diferente de **livre**.

2.  Verifique a precisão do arquivo de configuração para o serviço de balanceador de carga.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: myservice
    spec:
      type: LoadBalancer
      selector:
        <selector_key>:<selector_value>
      ports:
       - protocol: TCP
         port: 8080
    ```
    {: pre}

    1.  Verifique se você definiu **LoadBalancer** como o tipo para seu serviço.
    2.  Certifique-se de que o `<selector_key>` e o `<selector_value>` usados na seção `spec.selector` do serviço LoadBalancer é o mesmo par de chave/valor usado na seção `spec.template.metadata.labels` do yaml de sua implementação. Se os rótulos não corresponderem, a seção **Terminais** em seu serviço LoadBalancer exibirá **<nenhum>** e seu app não ficará acessível na Internet.
    3.  Verifique se usou a **porta** em que seu app atende.

3.  Verifique o serviço de balanceador de carga e revise a seção **Eventos** para localizar erros em potencial.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    Procure as mensagens de erro a seguir:

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Para usar o serviço de balanceador de carga, deve-se ter um cluster padrão com pelo menos dois nós do trabalhador.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Essa mensagem de erro indica que não sobrou nenhum endereço IP público móvel para ser alocado para o serviço de balanceador de carga. Consulte <a href="cs_subnets.html#subnets">Incluindo sub-redes nos clusters</a> para localizar informações sobre como solicitar endereços IP públicos móveis para seu cluster. Depois que os endereços IP públicos móveis estiverem disponíveis para o cluster, o serviço de balanceador de carga será criado automaticamente.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>Você definiu um endereço IP público móvel para o serviço de balanceador de carga usando a seção **loadBalancerIP**, mas esse endereço IP público móvel não está disponível em sua sub-rede pública móvel. Mude o script de configuração do serviço de balanceador de carga e escolha um dos endereços IP públicos móveis disponíveis ou remova a seção **loadBalancerIP** de seu script para que um endereço IP público móvel disponível possa ser alocado automaticamente.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Você não tem nós do trabalhador suficientes para implementar um serviço de balanceador de carga. Um motivo talvez seja que você tenha implementado um cluster padrão com mais de um nó do trabalhador, mas o fornecimento dos nós do trabalhador tenha falhado.</li>
    <ol><li>Liste os nós do trabalhador disponíveis.</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>Se pelo menos dois nós do trabalhador disponíveis forem localizados, liste os detalhes do nó do trabalhador.</br><pre class="codeblock"><code>bx cs worker-get [&lt;cluster_name_or_ID&gt;] &lt;worker_ID&gt;</code></pre></li>
    <li>Certifique-se de que os IDs da VLAN pública e privada para os nós do trabalhador que foram retornados pelos comandos <code>kubectl get nodes</code> e <code>bx cs [&lt;cluster_name_or_ID&gt;] worker-get</code> correspondam.</li></ol></li></ul>

4.  Se você estiver usando um domínio customizado para se conectar ao serviço de balanceador de carga, certifique-se de que seu domínio customizado seja mapeado para o endereço IP público do serviço de balanceador de carga.
    1.  Localize o endereço IP público do serviço de balanceador de carga.

        ```
        kubectl describe service <myservice> | grep "LoadBalancer Ingress"
        ```
        {: pre}

    2.  Verifique se o seu domínio customizado está mapeado para o endereço IP público móvel do serviço de balanceador de carga no registro de Ponteiro (PTR).

<br />




## Não é possível se conectar a um app por meio de Ingresso
{: #cs_ingress_fails}

{: tsSymptoms}
Você expôs publicamente seu app criando um recurso de Ingresso para seu app no cluster. Ao tentar se conectar ao app por meio do endereço IP público ou o subdomínio do balanceador de carga de aplicativo de Ingresso, a conexão falhou ou atingiu o tempo limite.

{: tsCauses}
O Ingresso pode não estar funcionando corretamente pelos motivos a seguir:
<ul><ul>
<li>O cluster não está totalmente implementado ainda.
<li>O cluster foi configurado como um cluster grátis ou como um cluster padrão com somente um nó do trabalhador.
<li>O script de configuração de Ingresso inclui erros.
</ul></ul>

{: tsResolve}
Para solucionar problemas do Ingresso:

1.  Verifique se você configurou um cluster padrão que esteja totalmente implementado e tenha pelo menos dois nós do trabalhador para assegurar alta disponibilidade para o balanceador de carga de aplicativo de Ingresso.

  ```
  bx cs workers <cluster_name_or_ID>
  ```
  {: pre}

    Na saída da CLI, certifique-se de que o **Status** dos nós do trabalhador exiba **Pronto** e que o **Tipo de máquina** mostre um tipo de máquina diferente de **livre**.

2.  Recupere o subdomínio de balanceador de carga de aplicativo de Ingresso e o endereço IP público e, em seguida execute ping de cada um.

    1.  Recupere o subdomínio de balanceador de carga de aplicativo.

      ```
      bx cs cluster-get <cluster_name_or_ID> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Execute ping do subdomínio de balanceador de carga de aplicativo de Ingresso.

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Recupere o endereço IP público de seu balanceador de carga de aplicativo de Ingresso.

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Execute ping do endereço IP público do balanceador de carga de aplicativo de Ingresso.

      ```
      ping <ingress_controller_IP>
      ```
      {: pre}

    Se a CLI retornar um tempo limite para o endereço IP público ou o subdomínio do balanceador de carga de aplicativo do Ingress e você tiver configurado um firewall customizado que esteja protegendo os nós do trabalhador, talvez seja necessário abrir portas e grupos de rede adicionais em seu [firewall](cs_troubleshoot_clusters.html#cs_firewall).

3.  Se você estiver usando um domínio customizado, certifique-se de que seu domínio customizado esteja mapeado para o endereço IP público ou subdomínio do balanceador de carga de aplicativo de Ingresso fornecido pela IBM com o provedor de Domain Name Service (DNS).
    1.  Se você usou o subdomínio do balanceador de carga de aplicativo de Ingresso, verifique seu registro de Canonical Name (CNAME).
    2.  Se você usou o endereço IP público do balanceador de carga de aplicativo de Ingresso, verifique se o seu domínio customizado está mapeado para o endereço IP público móvel no Registro de Ponteiro (PTR).
4.  Verifique seu arquivo de configuração do recurso de Ingresso.

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress_subdomain>
        secretName: <ingress_tls_secret>
      rules:
      - host: <ingress_subdomain>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  Verifique se o subdomínio do balanceador de carga de aplicativo de Ingresso e o certificado TLS estão corretos. Para localizar o subdomínio fornecido pela IBM e o certificado TLS, execute `bx cs cluster-get <cluster_name_or_ID>`.
    2.  Certifique-se de que seu app atenda no mesmo caminho configurado na seção de **caminho** de seu Ingresso. Se o seu app estiver configurado para atender no caminho raiz, inclua **/** como seu caminho.
5.  Verifique a sua implementação do Ingresso e procure mensagens de aviso ou erro em potencial.

    ```
    kubectl describe ingress <myingress>
    ```
    {: pre}

    Por exemplo, na seção **Eventos** da saída, você pode ver mensagens de aviso sobre valores inválidos em seu recurso de Ingresso ou em certas anotações usadas.

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xxx,169.xx.xxx.xxx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.mybluemix.net
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

6.  Verifique os logs para seu balanceador de carga de aplicativo.
    1.  Recupere o ID dos pods do Ingresso que estão em execução no cluster.

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  Recupere os logs para cada pod do Ingresso.

      ```
      Kubectl logs < ingress_pod_ID> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  Procure mensagens de erro nos logs do balanceador de carga de aplicativo.

<br />




## Problemas de segredo do balanceador de carga de aplicativo de Ingresso
{: #cs_albsecret_fails}

{: tsSymptoms}
Após a implementação de um segredo do balanceador de carga de aplicativo de Ingresso para seu cluster, o campo `Description` não está atualizando com o nome secreto quando você visualiza seu certificado no {{site.data.keyword.cloudcerts_full_notm}}.

Quando você lista informações sobre o segredo do balanceador de carga de aplicativo, o status diz `*_failed`. Por exemplo, `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
Revise as razões a seguir porque o segredo do balanceador de carga de aplicativo pode falhar e as etapas de resolução de problemas correspondentes:

<table>
 <thead>
 <th>Por que isso está acontecendo?</th>
 <th>Como corrigi-lo</th>
 </thead>
 <tbody>
 <tr>
 <td>Você não tem as funções de acesso necessárias para fazer download e atualizar os dados do certificado.</td>
 <td>Verifique com seu Administrador de conta para designar a você as funções de **Operador** e **Editor** para sua instância do {{site.data.keyword.cloudcerts_full_notm}}. Para obter mais detalhes, veja <a href="/docs/services/certificate-manager/access-management.html#managing-service-access-roles">Gerenciando o acesso de serviço</a> para o {{site.data.keyword.cloudcerts_short}}.</td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de criação, atualização ou remoção não pertence à mesma conta que o cluster.</td>
 <td>Verifique se o CRN do certificado fornecido é importado para uma instância do serviço {{site.data.keyword.cloudcerts_short}} que está implementado na mesma conta que seu cluster.</td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de criação está incorreto.</td>
 <td><ol><li>Verifique a precisão da sequência CRN do certificado que você fornece.</li><li>Se for constatado que o CRN do certificado está exato, tente atualizar o segredo: <code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Se esse comando resultar no status <code>update_failed</code>, remova o segredo: <code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt;</code></li><li>Implemente o segredo novamente: <code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>O CRN do certificado fornecido no tempo de atualização está incorreto.</td>
 <td><ol><li>Verifique a precisão da sequência CRN do certificado que você fornece.</li><li>Se for constatado que o CRN do certificado está exato, remova o segredo: <code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt;</code></li><li>Implemente o segredo novamente: <code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Tente atualizar o segredo: <code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>O serviço {{site.data.keyword.cloudcerts_long_notm}} está tendo tempo de inatividade.</td>
 <td>Verifique se o serviço {{site.data.keyword.cloudcerts_short}} está funcionando.</td>
 </tr>
 </tbody></table>

<br />


## Não é possível obter um subdomínio para o ALB do Ingress
{: #cs_subnet_limit}

{: tsSymptoms}
Quando você executa `bx cs cluster-get <cluster>`, seu cluster está em um estado `normal`, mas nenhum **Subdomínio do Ingress** está disponível.

É possível ver uma mensagem de erro semelhante à seguinte:

```
There are already the maximum number of subnets permitted in this VLAN.
```
{: screen}

{: tsCauses}
Ao criar um cluster, 8 sub-redes móveis públicas e 8 privadas são solicitadas na VLAN especificada. Para o {{site.data.keyword.containershort_notm}}, as VLANs têm um limite de 40 sub-redes. Se a VLAN do cluster já tiver atingido esse limite, o **Subdomínio do Ingress** falhará ao provisionar.

Para visualizar quantas sub-redes uma VLAN tem:
1.  No [console da infraestrutura do IBM Cloud (SoftLayer)](https://control.bluemix.net/), selecione **Rede** > **IP de gerenciamento** > **VLANs**.
2.  Clique no **Número da VLAN** da VLAN usada para criar seu cluster. Revise a seção **Sub-redes** para ver se há 40 ou mais sub-redes.

{: tsResolve}
Se você precisar de uma nova VLAN, peça uma [entrando em contato com o suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support). Em seguida, [crie um cluster](cs_cli_reference.html#cs_cluster_create) que usa essa nova VLAN.

Se você tiver outra VLAN disponível, será possível [configurar a ampliação da VLAN](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) no cluster existente. Depois, será possível incluir novos nós do trabalhador no cluster que usam a outra VLAN com sub-redes disponíveis.

Se você não estiver usando todas as sub-redes na VLAN, será possível reutilizar sub-redes no cluster.
1.  Verifique se as sub-redes que você deseja usar estão disponíveis. **Nota**: a conta de infraestrutura que você está usando pode ser compartilhada ao longo de múltiplas contas do {{site.data.keyword.Bluemix_notm}}. Em caso positivo, mesmo se você executar o comando `bx cs subnets` para ver sub-redes com **Clusters de ligação**, será possível ver informações apenas para seus clusters. Verifique com o proprietário da conta de infraestrutura para certificar-se de que as sub-redes estão disponíveis e não em uso por nenhuma outra conta ou equipe.

2.  [Crie um cluster](cs_cli_reference.html#cs_cluster_create) com a opção `--no-subnet` para que o serviço não tente criar novas sub-redes. Especifique o local e a VLAN que têm as sub-redes disponíveis para reutilização.

3.  Use o [comando](cs_cli_reference.html#cs_cluster_subnet_add) `bx cs cluster-subnet-add` para incluir sub-redes existentes em seu cluster. Para obter mais informações, veja [Incluindo ou reutilizando sub-redes customizadas e existentes nos clusters do Kubernetes](cs_subnets.html#custom).

<br />


## Não é possível estabelecer a conectividade VPN com o gráfico Helm do strongSwan
{: #cs_vpn_fails}

{: tsSymptoms}
Quando você verifica a conectividade VPN executando `kubectl exec -n kube-system $STRONGSWAN_POD -- ipsec status`, você não vê um status de `ESTABLISHED` ou o pod VPN está em um estado `ERROR` ou continua travando e reiniciando.

{: tsCauses}
Seu arquivo de configuração do gráfico Helm tem valores incorretos, valores ausentes ou erros de sintaxe.

{: tsResolve}
Quando você tentar estabelecer a conectividade VPN com o gráfico Helm do strongSwan, é provável que o status da VPN não seja `ESTABLISHED` na primeira vez. Você pode precisar verificar vários tipos de problemas e mudar seu arquivo de configuração de acordo. Para solucionar problemas de sua conectividade VPN do strongSwan:

1. Verifique as configurações de terminal de VPN no local com relação às configurações em seu arquivo de configuração. Se houver incompatibilidades:

    <ol>
    <li>Exclua o gráfico do Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija os valores incorretos no arquivo <code>config.yaml</code> e salve o arquivo atualizado.</li>
    <li>Instale o novo gráfico do Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

2. Se o pod VPN está em um estado de `ERROR` ou continua travando e reiniciando, pode ser devido à validação do parâmetro das configurações `ipsec.conf` no mapa de configuração do gráfico.

    <ol>
    <li>Verifique quaisquer erros de validação nos logs do pod do Strongswan.</br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>Se houver erros de validação, exclua o gráfico Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija os valores incorretos no arquivo `config.yaml` e salve o arquivo atualizado.</li>
    <li>Instale o novo gráfico do Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

3. Execute os 5 testes do Helm incluídos na definição de gráfico do strongSwan.

    <ol>
    <li>Execute os testes do Helm.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>Se algum teste falhar, consulte [Entendendo os testes de conectividade de VPN do Helm](cs_vpn.html#vpn_tests_table) para obter informações sobre cada teste e por que ele pode falhar. <b>Nota</b>: alguns dos testes têm requisitos que são configurações opcionais na configuração de VPN. Se alguns dos testes falharem, as falhas poderão ser aceitáveis, dependendo de se você especificou essas configurações opcionais.</li>
    <li>Visualize a saída de um teste com falha consultando os logs do pod de teste.<br><pre class="codeblock"><code>kubectl logs -n kube-system <test_program></code></pre></li>
    <li>Exclua o gráfico do Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija os valores incorretos no arquivo <code>config.yaml</code> e salve o arquivo atualizado.</li>
    <li>Instale o novo gráfico do Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    <li>Para verificar suas mudanças:<ol><li>Obtenha os pods do teste atual.</br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>Limpe os pods de teste atuais.</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>Execute os testes novamente.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. Execute a ferramenta de depuração da VPN empacotada dentro da imagem de pod da VPN.

    1. Configure a variável de ambiente `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. Execute a ferramenta de depuração.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        A ferramenta exibe várias páginas de informações conforme ela executa vários testes para problemas de rede comum. As linhas de saída que iniciam com `ERROR`, `WARNING`, `VERIFY` ou `CHECK` indicam erros possíveis com a conectividade VPN.

    <br />


## A conectividade VPN do StrongSwan falha após a adição ou exclusão do nó do trabalhador
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
Você estabeleceu anteriormente uma conexão VPN de trabalho, usando o serviço de VPN IPSec do strongSwan. No entanto, após ter incluído ou excluído um nó do trabalhador em seu cluster, você tem um ou mais dos sintomas a seguir:

* você não tem um status de VPN de `ESTABLISHED`
* não é possível acessar novos nós do trabalhador por meio de sua rede no local
* não é possível acessar a rede remota de pods que estão em execução em novos nós do trabalhador

{: tsCauses}
Se você tiver incluído um nó do trabalhador:

* o nó do trabalhador foi provisionado em uma nova sub-rede privada que não é exposta sobre a conexão VPN por suas configurações `localSubnetNAT` ou `local.subnet` existentes
* as rotas de VPN não podem ser incluídas no nó do trabalhador porque o trabalhador tem contaminações ou rótulos que não estão incluídos em suas configurações `tolerations` ou `nodeSelector` existentes
* o pod de VPN está em execução no novo nó do trabalhador, mas o endereço IP público desse nó do trabalhador não é permitido por meio do firewall no local

Se você tiver excluído um nó do trabalhador:

* esse nó do trabalhador foi o único nó em que um pod de VPN estava em execução, devido a restrições em certas contaminações ou rótulos em suas configurações `tolerations` ou `nodeSelector` existentes

{: tsResolve}
Atualize os valores do gráfico Helm para refletir as mudanças do nó do trabalhador:

1. Exclua o gráfico do Helm existente.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Abra o arquivo de configuração para seu serviço de VPN do strongSwan.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Verifique as configurações a seguir e faça mudanças para refletir os nós do trabalhador excluídos ou incluídos, conforme necessário.

    Se você tiver incluído um nó do trabalhador:

    <table>
     <thead>
     <th>Configuração</th>
     <th>Descrição</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>O nó do trabalhador incluído pode ser implementado em uma nova sub-rede privada diferente das outras sub-redes existentes em que outros nós do trabalhador estão. Se você está usando a sub-rede NAT para remapear os endereços IP locais privados de seu cluster e o nó do trabalhador foi incluído em uma nova sub-rede, inclua a nova sub-rede CIDR nesta configuração.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Se você limitou anteriormente o pod de VPN para execução em quaisquer nós do trabalhador com um rótulo específico e deseja que as rotas de VPN sejam incluídas no trabalhador, certifique-se de que o nó do trabalhador incluído tenha esse rótulo.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Se o nó do trabalhador incluído está contaminado e você deseja que as rotas de VPN sejam incluídas no trabalhador, mude essa configuração para permitir que o pod de VPN seja executado em todos os nós do trabalhador contaminados ou nós do trabalhador com contaminações específicas.</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>O nó do trabalhador incluído pode ser implementado em uma nova sub-rede privada diferente das outras sub-redes existentes em que outros nós do trabalhador estão. Se seus apps são expostos por serviços NodePort ou LoadBalancer na rede privada e eles estão em um novo nó do trabalhador que você incluiu, inclua a nova sub-rede CIDR nesta configuração. **Nota**: se você incluir valores para `local.subnet`, verifique as configurações de VPN para a sub-rede no local para ver se elas também devem ser atualizadas.</td>
     </tr>
     </tbody></table>

    Se você tiver excluído um nó do trabalhador:

    <table>
     <thead>
     <th>Configuração</th>
     <th>Descrição</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Se você estiver usando a NAT da sub-rede para remapear endereços IP locais privados específicos, remova quaisquer endereços IP dessa configuração que sejam do nó do trabalhador antigo. Se você está usando a sub-rede NAT para remapear sub-redes inteiras e não têm nós do trabalhador restantes em uma sub-rede, remova essa sub-rede CIDR desta configuração.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Se você limitou anteriormente o pod de VPN para execução em um único nó do trabalhador e esse nó do trabalhador foi excluído, mude essa configuração para permitir que o pod de VPN seja executado em outros nós do trabalhador.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Se o nó do trabalhador que você excluiu não tiver sido contaminado, mas os únicos nós do trabalhador que permanecem estão contaminados, mude essa configuração para permitir que o pod da VPN seja executado em todos os nós do trabalhador contaminados ou nós do trabalhador com contaminações específicas.
     </td>
     </tr>
     </tbody></table>

4. Instale o novo gráfico Helm com os seus valores atualizados.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. Verifique o status de implementação do gráfico. Quando o gráfico estiver pronto, o campo **STATUS** perto da parte superior da saída terá um valor de `DEPLOYED`.

    ```
    helm status <release_name>
    ```
    {: pre}

6. Em alguns casos, você pode precisar mudar suas configurações no local e suas configurações de firewall para corresponderem às mudanças feitas no arquivo de configuração de VPN.

7. Inicie a VPN.
    * Se a conexão VPN é iniciada pelo cluster (`ipsec.auto` está configurado para `start`), inicie a VPN no gateway no local e, em seguida, inicie a VPN no cluster.
    * Se a conexão VPN é iniciada pelo gateway no local (`ipsec.auto` está configurado para `auto`), inicie a VPN no cluster e, em seguida, inicie a VPN no gateway no local.

8. Configure a variável de ambiente `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. Verifique o status da VPN.

    ```
    kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * Se a conexão VPN tem um status de `ESTABLISHED`, a conexão VPN foi bem-sucedida. Nenhuma ação adicional é necessária.

    * Se você ainda está tendo problemas de conexão, veja [Não é possível estabelecer a conectividade VPN com o gráfico Helm do strongSwan](#cs_vpn_fails) para solucionar problemas posteriormente de sua conexão VPN.

<br />




## Não é possível recuperar a URL do ETCD para configuração da CLI do Calico
{: #cs_calico_fails}

{: tsSymptoms}
Quando você recuperar o `<ETCD_URL>` para [incluir políticas de rede](cs_network_policy.html#adding_network_policies), você obtém uma mensagem de erro `calico-config not found`.

{: tsCauses}
Seu cluster não está no [Kubernetes versão 1.7](cs_versions.html) ou mais recente.

{: tsResolve}
[Atualize o seu cluster](cs_cluster_update.html#master) ou recupere o `<ETCD_URL>` com comandos que são compatíveis com versões anteriores do Kubernetes.

Para recuperar o `<ETCD_URL>`, execute um dos comandos a seguir:

- Linux e OS X:

    ```
    kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
    ```
    {: pre}

- Windows:
    <ol>
    <li> Obtenha uma lista dos pods no namespace kube-system e localize o pod controlador do Calico. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Exemplo:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> Visualize os detalhes do pod controlador do Calico.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;calico_pod_ID&gt;</code></pre>
    <li> Localize o valor de terminais do ETCD. Exemplo: <code>https://169.1.1.1:30001</code>
    </ol>

Quando você recuperar o `<ETCD_URL>`, continue com as etapas conforme listado em (Incluindo políticas de rede) [cs_network_policy.html#adding_network_policies].

<br />




## Obtendo ajuda e suporte
{: #ts_getting_help}

Ainda está tendo problemas com o seu cluster?
{: shortdesc}

-   Para ver se o {{site.data.keyword.Bluemix_notm}} está disponível, [verifique a página de status do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).
-   Poste uma pergunta no [Slack do {{site.data.keyword.containershort_notm}}. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com)
    Se você não estiver usando um IBMid para a sua conta do {{site.data.keyword.Bluemix_notm}}, [solicite um convite](https://bxcs-slack-invite.mybluemix.net/) para essa Folga.
    {: tip}
-   Revise os fóruns para ver se outros usuários tiveram o mesmo problema. Ao usar os fóruns para fazer uma pergunta, marque sua pergunta para que ela seja vista pelas equipes de desenvolvimento do {{site.data.keyword.Bluemix_notm}}.

    -   Se você tiver questões técnicas sobre como desenvolver ou implementar clusters ou apps com o {{site.data.keyword.containershort_notm}}, poste sua pergunta no [Stack Overflow ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e identifique a sua pergunta com `ibm-cloud`, `kubernetes` e `containers`.
    -   Para perguntas sobre o serviço e instruções de introdução, use o fórum [IBM developerWorks dW Answers ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Inclua as tags `ibm-cloud` e `containers`.
    Consulte [Obtendo ajuda](/docs/get-support/howtogetsupport.html#using-avatar) para obter mais detalhes sobre o uso dos fóruns.

-   Entre em contato com o Suporte IBM abrindo um chamado. Para obter informações sobre como abrir um chamado de suporte IBM ou sobre níveis de suporte e severidades de chamado, consulte [Entrando em contato com o suporte](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Ao relatar um problema, inclua seu ID do cluster. Para obter o ID do cluster, execute `bx cs clusters`.


