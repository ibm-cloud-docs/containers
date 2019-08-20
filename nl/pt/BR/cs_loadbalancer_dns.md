---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb, health check, dns, host name

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


# Registrando um nome de host de NLB
{: #loadbalancer_hostname}

Depois de configurar balanceadores de carga de rede (NLBs), será possível criar entradas DNS para os IPs do NLB criando nomes de host. Também é possível configurar monitores TCP/HTTP(S) para verificar o funcionamento dos endereços IP do NLB atrás de cada nome do host.
{: shortdesc}

<dl>
<dt>Nome de host</dt>
<dd>Ao criar um NLB público em um cluster de zona única ou multizona, é possível expor o seu aplicativo à Internet criando um nome de host para o endereço IP do NLB. Além disso, o {{site.data.keyword.cloud_notm}} é responsável por gerar e manter o certificado SSL curinga para o nome de host.
<p>Em clusters multizona, é possível criar um nome de host e incluir o endereço IP do NLB em cada zona para a entrada DNS desse nome de host. Por exemplo, se você implementou NLBs para o seu aplicativo em três zonas no Sul dos Estados Unidos, será possível criar o nome do host `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` para os três endereços IP do NLB. Quando um usuário acessa o seu nome do host do app, o cliente acessa um desses IPs aleatoriamente e a solicitação é enviada para esse NLB.</p>
Observe que atualmente não é possível criar nomes de host para NLBs privados.</dd>
<dt>Monitor de verificação de funcionamento</dt>
<dd>Ative as verificações de funcionamento nos endereços IP do NLB atrás de um nome de host único para determinar se elas estão disponíveis ou não. Quando você ativa um monitor para seu nome de host, o monitor verifica o funcionamento de cada IP do NLB e mantém os resultados da consulta de DNS atualizados com base nessas verificações de funcionamento. Por exemplo, se seus NLBs tiverem endereços IP `1.1.1.1`, `2.2.2.2` e `3.3.3.3`, uma consulta de DNS de operação normal retornará todos os 3 IPs, um dos quais será acessado pelo cliente de maneira aleatória. Se o NLB com o endereço IP `3.3.3.3` se tornar indisponível por algum motivo, como devido à falha de zona, a verificação de funcionamento para esse IP falhará, o monitor removerá o IP com falha do nome de host e a consulta de DNS retornará somente os IPs `1.1.1.1` e `2.2.2.2` funcionais.</dd>
</dl>

É possível ver todos os nomes de host registrados para IPs do NLB em seu cluster executando o comando a seguir.
```
ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
```
{: pre}

</br>

## Registrando IPs do NLB com um nome de host de DNS
{: #loadbalancer_hostname_dns}

Exponha seu aplicativo à Internet pública criando um nome de host para o endereço IP do balanceador de carga de rede (NLB).
{: shortdesc}

Antes de iniciar:
* Revise as considerações e limitações a seguir.
  * É possível criar nomes de host para os NLBs públicos da versão 1.0 e 2.0.
  * Atualmente, não é possível criar nomes de host para NLBs privados.
  * É possível registrar até 128 nomes de host. Esse limite pode ser aumentado solicitando um [caso de suporte](/docs/get-support?topic=get-support-getting-customer-support).
* [Crie um NLB para seu aplicativo em um cluster de zona única](/docs/containers?topic=containers-loadbalancer#lb_config) ou [crie NLBs em cada zona de um cluster multizona](/docs/containers?topic=containers-loadbalancer#multi_zone_config).

Para criar um nome de host para um ou mais endereços IP do NLB:

1. Obtenha o endereço **EXTERNAL-IP** para seu NLB. Se tiver NLBs em cada zona de um cluster multizona que exponham um aplicativo, obtenha os IPs para cada NLB.
  ```
  kubectl get svc
  ```
  {: pre}

  Na saída de exemplo a seguir, os **EXTERNAL-IP** do NLB são `168.2.4.5` e `88.2.4.5`.
  ```
  NAME             TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)                AGE
  lb-myapp-dal10   LoadBalancer   172.21.xxx.xxx   168.2.4.5         1883:30303/TCP         6d
  lb-myapp-dal12   LoadBalancer   172.21.xxx.xxx   88.2.4.5          1883:31303/TCP         6d
  ```
  {: screen}

2. Registre o IP criando um nome de host do DNS. Observe que é possível criar inicialmente o nome do host com apenas um endereço IP.
  ```
  ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <NLB_IP>
  ```
  {: pre}

3. Verifique se o nome do host foi criado.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Saída de exemplo:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.2.4.5"]      None             created                   <certificate>
  ```
  {: screen}

4. Se tiver NLBs em cada zona de um cluster multizona que exponham um aplicativo, inclua os IPs de outros NLBs no nome de host. Observe que é necessário executar o comando a seguir para cada endereço IP que você deseja incluir.
  ```
  ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
  ```
  {: pre}

5. Opcional: verifique se os IPs estão registrados com seu nome de host executando um `host` ou `ns lookup`.
  Exemplo de comando:
  ```
  host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
  ```
  {: pre}

  Saída de exemplo:
  ```
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 88.2.4.5  
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 168.2.4.5
  ```
  {: screen}

6. Em um navegador da web, insira a URL para acessar seu aplicativo por meio do nome de host criado.

Em seguida, é possível [ativar verificações de funcionamento no nome de host criando um monitor de funcionamento](#loadbalancer_hostname_monitor).

</br>

## Entendendo o formato do nome de host
{: #loadbalancer_hostname_format}

Nomes de host para NLBs seguem o formato `<cluster_name>-<globally_unique_account_HASH>-0001.<region>.containers.appdomain.cloud`.
{: shortdesc}

Por exemplo, um nome de host criado para um NLB pode ser semelhante a `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud`. A tabela a seguir descreve cada componente do nome de host.

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Entendendo o formato do nome de host do LB</th>
</thead>
<tbody>
<tr>
<td><code> &lt;cluster_name&gt; </code></td>
<td>O nome de seu cluster.
<ul><li>Se o nome do cluster contiver 26 caracteres ou menos, todo ele será incluído e não será modificado: <code>myclustername</code>.</li>
<li>Se o nome do cluster contiver 26 caracteres ou mais e for exclusivo nessa região, somente seus primeiros 24 caracteres serão usados: <code>myveryverylongclusternam</code>.</li>
<li>Se o nome do cluster tiver 26 caracteres ou mais e houver um cluster existente com o mesmo nome nessa região, apenas os primeiros 17 caracteres do nome do cluster serão usados e um traço com seis caracteres aleatórios será incluído: <code>myveryveryverylongclu-ABC123</code>.</li></ul>
</td>
</tr>
<tr>
<td><code>&lt;globally_unique_account_HASH&gt;</code></td>
<td>Um HASH exclusivo globalmente é criado para sua conta do {{site.data.keyword.cloud_notm}}. Todos os nomes de host criados para NLBs em clusters de sua conta usam esse HASH exclusivo globalmente.</td>
</tr>
<tr>
<td><code>0001</code></td>
<td>
O primeiro e o segundo caracteres, <code>00</code>, indicam um nome de host público. O terceiro e o quarto caracteres, como <code>01</code> ou outro número, atuam como um contador para cada nome de host criado.</td>
</tr>
<tr>
<td><code>&lt;região&gt;</code></td>
<td>A região de criação do cluster.</td>
</tr>
<tr>
<td><code>containers.appdomain.cloud</code></td>
<td>O subdomínio para nomes de host do {{site.data.keyword.containerlong_notm}}.</td>
</tr>
</tbody>
</table>

</br>

## Permitir verificações de funcionamento em um nome de host por meio da criação de um monitor de funcionamento
{: #loadbalancer_hostname_monitor}

Ative as verificações de funcionamento nos endereços IP do NLB atrás de um nome de host único para determinar se elas estão disponíveis ou não.
{: shortdesc}

Antes de começar, [registre IPs do NLB com um nome de host de DNS](#loadbalancer_hostname_dns).

1. Obtenha o nome de seu nome de host. Na saída, observe que o host tem um monitor **Status** de `Unconfigured`.
  ```
  ibmcloud ks nlb-dns-monitor-ls --cluster <cluster_name_or_id>
  ```
  {: pre}

  Saída de exemplo:
  ```
  Hostname                                                                                   Status         Type    Port   Path
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud        Unconfigured   N/A     0      N/A
  ```
  {: screen}

2. Crie um monitor de verificação de funcionamento para o nome de host. Se você não incluir um parâmetro de configuração, o valor padrão será usado.
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --enable --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
  ```
  {: pre}

  <table>
  <caption>Entendendo os componentes deste comando</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
  </thead>
  <tbody>
  <tr>
  <td><code>--cluster &lt;cluster_name_or_ID&gt;</code></td>
  <td>Necessário: o nome ou ID do cluster no qual o nome de host está registrado.</td>
  </tr>
  <tr>
  <td><code>--nlb-host &lt;host_name&gt;</code></td>
  <td>Necessário: o nome de host para o qual ativar um monitor de verificação de funcionamento.</td>
  </tr>
  <tr>
  <td><code>--enable</code></td>
  <td>Necessário: ativar o monitor de verificação de funcionamento para o nome de host.</td>
  </tr>
  <tr>
  <td><code>--description &lt;description&gt;</code></td>
  <td>Uma descrição do monitor de funcionamento.</td>
  </tr>
  <tr>
  <td><code>--type &lt;type&gt;</code></td>
  <td>O protocolo a ser usado para a verificação de funcionamento: <code>HTTP</code>, <code>HTTPS</code> ou <code>TCP</code>. Padrão: <code>HTTP</code></td>
  </tr>
  <tr>
  <td><code>--method &lt;method&gt;</code></td>
  <td>O método a ser usado para a verificação de funcionamento. Padrão para <code>type</code> <code>HTTP</code> e <code>HTTPS</code>: <code>GET</code>. Padrão para <code>type</code> <code>TCP</code>: <code>connection_established</code></td>
  </tr>
  <tr>
  <td><code>--path &lt;path&gt;</code></td>
  <td>Quando <code>type</code> for <code>HTTPS</code>: o caminho de terminal com relação ao qual será feita a verificação de funcionamento. Padrão: <code>/</code></td>
  </tr>
  <tr>
  <td><code>--timeout &lt;timeout&gt;</code></td>
  <td>O tempo limite, em segundos, antes que o IP seja considerado não funcional. Padrão: <code>5</code></td>
  </tr>
  <tr>
  <td><code>--retries &lt;retries&gt;</code></td>
  <td>Quando ocorrer um tempo limite, o número de novas tentativas para tentar antes do IP será considerado não funcional. Novas tentativas são tentadas imediatamente. Padrão: <code>2</code></td>
  </tr>
  <tr>
  <td><code>--interval &lt;interval&gt;</code></td>
  <td>O intervalo, em segundos, entre cada verificação de funcionamento. Intervalos curtos podem melhorar o tempo de failover, mas aumentar o carregamento nos IPs. Padrão: <code>60</code></td>
  </tr>
  <tr>
  <td><code>--port &lt;port&gt;</code></td>
  <td>O número da porta à qual se conectar para a verificação de funcionamento. Quando <code>type</code> for <code>TCP</code>, esse parâmetro será necessário. Quando <code>type</code> for <code>HTTP</code> ou <code>HTTPS</code>, defina a porta somente se você usar uma porta diferente de 80 para HTTP ou 443 para HTTPS. Padrão para TCP: <code>0</code>. Padrão para HTTP: <code>80</code>. Padrão para HTTPS: <code>443</code>.</td>
  </tr>
  <tr>
  <td><code>--expected-body &lt;expected-body&gt;</code></td>
  <td>Quando <code>type</code> for <code>HTTP</code> ou <code>HTTPS</code>: uma subsequência sem distinção entre maiúsculas e minúsculas que a verificação de funcionamento procurará no corpo da resposta. Se essa sequência não for localizada, o IP será considerado não funcional.</td>
  </tr>
  <tr>
  <td><code>--expected-codes &lt;expected-codes&gt;</code></td>
  <td>Quando <code>type</code> for <code>HTTP</code> ou <code>HTTPS</code>: códigos de HTTP que a verificação de funcionamento procurará na resposta. Se o código de HTTP não for localizado, o IP será considerado não funcional. Padrão: <code>2xx</code></td>
  </tr>
  <tr>
  <td><code>--allows-insecure &lt;true&gt;</code></td>
  <td>Quando <code>type</code> for <code>HTTP</code> ou <code>HTTPS</code>: configure como <code>true</code> para não validar o certificado.</td>
  </tr>
  <tr>
  <td><code>--follows-redirects &lt;true&gt;</code></td>
  <td>Quando <code>type</code> for <code>HTTP</code> ou <code>HTTPS</code>: configure como <code>true</code> para seguir quaisquer redirecionamentos que forem retornados pelo IP.</td>
  </tr>
  </tbody>
  </table>

  Exemplo de comando:
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --desc "Login page monitor" --type HTTPS --method GET --path / --timeout 5 --retries 2 --interval 60 --expected-body "healthy" --expected-codes 2xx --follows-redirects true
  ```
  {: pre}

3. Verifique se o monitor de verificação de funcionamento está definido com as configurações corretas.
  ```
  ibmcloud ks nlb-dns-monitor-get --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Saída de exemplo:
  ```
  <placeholder - still want to test this one>
  ```
  {: screen}

4. Visualize o status de verificação de funcionamento dos IPs do NLB que estão atrás de seu nome de host.
  ```
  ibmcloud ks nlb-dns-monitor-status --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Saída de exemplo:
  ```
  Hostname                                                                                IP          Health Monitor   H.Monitor Status
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     168.2.4.5   Enabled          Healthy
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     88.2.4.5    Enabled          Healthy
  ```
  {: screen}

</br>

### Atualizando e removendo IPs e monitores de nomes de host
{: #loadbalancer_hostname_delete}

É possível incluir e remover endereços IP do NLB dos nomes de host gerados. Também é possível desativar e ativar monitores de verificação de funcionamento para nomes de host, conforme necessário.
{: shortdesc}

**IPs de NLB**

Se você posteriormente incluir mais NLBs em outras zonas de seu cluster para expor o mesmo aplicativo, será possível incluir os IPs do NLB no nome de host existente. Observe que é necessário executar o comando a seguir para cada endereço IP que você deseja incluir.
```
ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
```
{: pre}

Também é possível remover endereços IP de NLBs que você não deseja que sejam mais registrados com um nome de host. Observe que se deve executar o comando a seguir para cada endereço IP que você deseja remover. Se você remover todos os IPs de um nome do host, o nome do host ainda existirá, mas nenhum IP será associado a ele.
```
ibmcloud ks nlb-dns-rm --cluster <cluster_name_or_id> --ip <ip1,ip2> --nlb-host <host_name>
```
{: pre}

</br>

**Monitores de verificação de funcionamento**

Se for necessário mudar a configuração do monitor de funcionamento, será possível mudar as configurações específicas. Inclua apenas os sinalizadores para as configurações que deseja mudar.
```
ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
```
{: pre}

É possível desativar o monitor de verificação de funcionamento para um nome de host a qualquer momento executando o comando a seguir:
```
ibmcloud ks nlb-dns-monitor-disable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}

Para ativar novamente um monitor para um nome de host, execute o comando a seguir:
```
ibmcloud ks nlb-dns-monitor-enable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}
