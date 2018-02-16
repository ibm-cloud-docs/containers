---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Anotações de ingresso
{: #ingress_annotation}

Para incluir recursos em seu balanceador de aplicativo, é possível especificar anotações como metadados em um recurso do Ingress.
{: shortdesc}

Para obter informações gerais sobre os serviços do Ingress e como começar a usá-los, consulte [Configurando o acesso público a um app usando o Ingress](cs_ingress.html#config).

<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th colspan=3>Anotações gerais</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-external-service">Serviços externos</a></td>
 <td><code>proxy-external-service</code></td>
 <td>Inclua definições de caminho para serviços externos, como um serviço hospedado no {{site.data.keyword.Bluemix_notm}}.</td>
 </tr>
 <tr>
 <td><a href="#alb-id">Roteamento do balanceador de carga privado do aplicativo</a></td>
 <td><code>ALB-ID</code></td>
 <td>Roteie solicitações recebidas para seus aplicativos com um balanceador de carga de aplicativo privado.</td>
 </tr>
 <tr>
 <td><a href="#rewrite-path">Gravar novamente caminhos</a></td>
 <td><code>rewrite-path</code></td>
 <td>Rotear tráfego de rede recebido para um caminho diferente no qual seu app backend atenda.</td>
 </tr>
 <tr>
 <td><a href="#sticky-cookie-services">Afinidade de sessão com cookies</a></td>
 <td><code>sticky-cookie-services</code></td>
 <td>Sempre rotear o tráfego de rede recebido para o mesmo servidor de envio de dados usando um cookie permanente.</td>
 </tr>
 <tr>
 <td><a href="#tcp-ports">Portas TCP</a></td>
 <td><code>tcp-ports</code></td>
 <td>Acesse um app através de uma porta TCP não padrão.</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
  <th colspan=3>Anotações da conexão</th>
  </thead>
  <tbody>
  <tr>
  <td><a href="#proxy-connect-timeout">Tempos limite de conexão e tempos limite de leitura customizados</a></td>
  <td><code>proxy-connect-timeout</code></td>
  <td>Ajuste o tempo que o balanceador de carga de aplicativo aguarda para se conectar e ler o aplicativo backend antes de o app de backend ser considerado indisponível.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-requests">Solicitações de keep-alive</a></td>
  <td><code>keepalive-requests</code></td>
  <td>Configure o número máximo de solicitações que podem ser servidas por meio de uma conexão keepalive.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-timeout">Tempo limite de keep-alive</a></td>
  <td><code>keepalive-timeout</code></td>
  <td>Configure o tempo que uma conexão keep-alive permanece aberta no servidor.</td>
  </tr>
  <tr>
  <td><a href="#upstream-keepalive">Envio de dados keep-alive</a></td>
  <td><code>upstream-keepalive</code></td>
  <td>Configure o número máximo de conexões keep-alive inativas para um servidor de envio de dados.</td>
  </tr>
  </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th colspan=3>Anotações de buffer de proxy</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-buffering">Armazenamento em buffer de dados de resposta do cliente</a></td>
 <td><code>proxy-buffering</code></td>
 <td>Desative o armazenamento em buffer de uma resposta do cliente no balanceador de carga de aplicativo ao enviar a resposta para o cliente.</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffers">Buffers de proxy</a></td>
 <td><code>proxy-buffers</code></td>
 <td>Configure o número e o tamanho dos buffers que leem uma resposta para uma conexão única do servidor com proxy.</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffer-size">Tamanho do buffer de proxy</a></td>
 <td><code>proxy-buffer-size</code></td>
 <td>Configure o tamanho do buffer que lê a primeira parte da resposta que é recebida do servidor com proxy.</td>
 </tr>
 <tr>
 <td><a href="#proxy-busy-buffers-size">Tamanho de buffers ocupados de proxy</a></td>
 <td><code>proxy-busy-buffers-size</code></td>
 <td>Configure o tamanho de buffers de proxy que possam estar ocupados.</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Anotações de solicitação e de resposta</th>
</thead>
<tbody>
<tr>
<td><a href="#proxy-add-headers">Solicitação do cliente ou cabeçalho de resposta adicional</a></td>
<td><code>proxy-add-headers</code></td>
<td>Inclua informações do cabeçalho em uma solicitação do cliente antes de encaminhar a solicitação para seu app backend ou para uma resposta do cliente antes de enviar a resposta para o cliente.</td>
</tr>
<tr>
<td><a href="#response-remove-headers">Remoção do cabeçalho de resposta do cliente</a></td>
<td><code>response-remove-headers</code></td>
<td>Remover informações do cabeçalho de uma resposta do cliente antes de encaminhar a resposta para o cliente.</td>
</tr>
<tr>
<td><a href="#client-max-body-size">Tamanho máximo do corpo de solicitação do cliente customizado</a></td>
<td><code>client-max-body-size</code></td>
<td>Ajuste o tamanho do corpo da solicitação do cliente que tem permissão para ser enviado para o balanceador de carga de aplicativo.</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Anotações de limite de serviço</th>
</thead>
<tbody>
<tr>
<td><a href="#global-rate-limit">Limites de taxa global</a></td>
<td><code>global-rate-limit</code></td>
<td>Limite a taxa de processamento de solicitação e o número de conexões por uma chave definida para todos os serviços.</td>
</tr>
<tr>
<td><a href="#service-rate-limit">Limites de taxa de serviço</a></td>
<td><code>service-rate-limit</code></td>
<td>Limitar a taxa de processamento de solicitação e o número de conexões por uma chave definida para serviços específicos.</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Anotações de autenticação HTTPS e TLS/SSL</th>
</thead>
<tbody>
<tr>
<td><a href="#custom-port">Portas HTTP e HTTPS customizadas</a></td>
<td><code>custom-port</code></td>
<td>Mude as portas padrão para o tráfego de rede HTTP (porta 80) e HTTPS (porta 443).</td>
</tr>
<tr>
<td><a href="#redirect-to-https">HTTP redireciona para HTTPS</a></td>
<td><code>redirect-to-https</code></td>
<td>Redirecione solicitações de HTTP não seguras em seu domínio para HTTPS.</td>
</tr>
<tr>
<td><a href="#mutual-auth">Autenticação mútua</a></td>
<td><code>mutual-auth</code></td>
<td>Configure a autenticação mútua para o balanceador de carga do aplicativo.</td>
</tr>
<tr>
<td><a href="#ssl-services">Suporte a serviços SSL</a></td>
<td><code>ssl-services</code></td>
<td>Permita o suporte a serviços SSL para balanceamento de carga.</td>
</tr>
</tbody></table>



## Anotações gerais
{: #general}

### Serviços externos (proxy-external-service)
{: #proxy-external-service}

Inclua definições de caminho para serviços externos, como serviços hospedados no {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Inclua definições de caminho para serviços externos. Use essa anotação somente quando seu app opera em um serviço externo em vez de um serviço de backend. Quando você usa essa anotação para criar uma rota de serviço externo, somente as anotações `client-max-body-size`, `proxy-read-timeout`, `proxy-connect-timeout` e `proxy-buffer` são suportadas em conjunto. Quaisquer outras anotações não são suportadas em conjunto com `proxy-external-service`.
</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>
apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: cafe-ingress
  annotations:
    ingress.bluemix.net/proxy-external-service: "path=&lt;mypath&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
spec:
  tls:
  - System z:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 80
</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>path</code></td>
 <td>Substitua <code>&lt;<em>mypath</em>&gt;</code> pelo caminho em que o serviço externo atende.</td>
 </tr>
 <tr>
 <td><code>external-svc</code></td>
 <td>Substitua <code>&lt;<em>external_service</em>&gt;</code> pelo serviço externo a ser chamado. Por exemplo, <code>https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net</code>.</td>
 </tr>
 <tr>
 <td><code>host</code></td>
 <td>Substitua <code>&lt;<em>mydomain</em>&gt;</code> pelo domínio do host para o serviço externo.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Roteamento do balanceador de carga de aplicativo privado (ALB-ID)
{: #alb-id}

Roteie solicitações recebidas para seus aplicativos com um balanceador de carga de aplicativo privado.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Escolha um balanceador de carga de aplicativo privado para rotear solicitações recebidas, em vez do balanceador de carga de aplicativo público.</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
name: myingress
annotations:
  ingress.bluemix.net/ALB-ID: "&lt;private_ALB_ID&gt;"
spec:
tls:
- System z:
  - mydomain
    secretName: mytlssecret
  rules:
- host: mydomain
  http:
    paths:
    - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
</thead>
<tbody>
<tr>
<td><code>&lt;private_ALB_ID&gt;</code></td>
<td>O ID para seu balanceador de carga de aplicativo privado. Execute <code>bx cs albs --cluster <my_cluster></code> para localizar o ID do balanceador de carga de aplicativo privado.
</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />



### Gravar novamente caminhos (rewrite-path)
{: #rewrite-path}

Roteie o tráfego de rede recebido em um caminho de domínio do balanceador de carga de aplicativo para um caminho diferente no qual seu aplicativo backend atende.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O domínio do balanceador de carga do aplicativo Ingress roteia o tráfego de rede recebido no <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> para o seu app. O seu app atende em <code>/coffee</code>, em vez de <code>/beans</code>. Para encaminhar o tráfego de rede recebido para o seu app, inclua a anotação de regravação em seu arquivo de configuração do recurso de Ingresso. A anotação de nova gravação assegura que o tráfego de rede recebido em <code>/beans</code> seja encaminhado para o seu app usando o caminho <code>/coffee</code>. Ao incluir múltiplos serviços, use apenas um ponto e vírgula (;) para separá-los.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;myservice1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;myservice2&gt; rewrite=&lt;target_path2&gt;"
spec:
  tls:
  - System z:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: /beans
        backend:
          serviceName: myservice1
          servicePort: 80
</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
</tr>
<tr>
<td><code>rewrite</code></td>
<td>Substitua <code>&lt;<em>target_path</em>&gt;</code> pelo caminho em que seu app atende. O tráfego de rede recebido no domínio do balanceador de carga de aplicativo é encaminhado para o serviço do Kubernetes usando este caminho. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. No exemplo acima, o caminho de regravação foi definido como <code>/coffee</code>.</td>
</tr>
</tbody></table>

</dd></dl>

<br />


### Afinidade de sessão com cookies (sticky-cookie-services)
{: #sticky-cookie-services}

Use a anotação de cookie permanente para incluir a afinidade de sessão para seu balanceador de carga de aplicativo e sempre roteie o tráfego de rede recebido para o mesmo servidor de envio de dados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Para alta disponibilidade, algumas configurações de app requerem que você implemente múltiplos servidores de envio de dados que manipulam solicitações do cliente recebidas. Quando um cliente se conecta ao app backend, é possível usar a afinidade de sessão para que um cliente seja atendido pelo mesmo servidor de envio de dados pela duração de uma sessão ou pelo tempo que leva para concluir uma tarefa. É possível configurar seu balanceador de carga de aplicativo para assegurar a afinidade de sessão sempre roteando o tráfego de rede recebido para o mesmo servidor de envio de dados.

</br></br>
Cada cliente que se conecta ao seu app backend é designado a um dos servidores de envio de dados disponíveis pelo balanceador de carga de aplicativo. O balanceador de carga de aplicativo cria um cookie de sessão que é armazenado no app do cliente, que está incluído nas informações do cabeçalho de cada solicitação entre o balanceador de carga de aplicativo e o cliente. As informações no cookie asseguram que todas as solicitações sejam manipuladas pelo mesmo servidor de envio de dados em toda a sessão.

</br></br>
Ao incluir múltiplos serviços, use um ponto e vírgula (;) para separá-los.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;myservice1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;myservice2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: / backend: serviceName: &lt;myservice1&gt; servicePort: 8080
      - path: /myapp backend: serviceName: &lt;myservice2&gt; servicePort: 80</code></pre>

  <table>
  <caption>Entendendo os componentes de arquivo YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
  </tr>
  <tr>
  <td><code>name</code></td>
  <td>Substitua <code>&lt;<em>cookie_name</em>&gt;</code> pelo nome de um cookie permanente que é criado durante uma sessão.</td>
  </tr>
  <tr>
  <td><code>expires</code></td>
  <td>Substitua <code>&lt;<em>expiration_time</em>&gt;</code> pelo tempo em segundos (s), minutos (m) ou horas (h) antes da expiração do cookie permanente. Esse tempo é independente da atividade do usuário. Depois que o cookie expira, ele é excluído pelo navegador da web do cliente e não é mais enviado para o balanceador de carga de aplicativo. Por exemplo, para configurar um prazo de expiração de 1 segundo, 1 minuto ou 1 hora, insira <code>1s</code>, <code>1m</code> ou <code>1h</code>.</td>
  </tr>
  <tr>
  <td><code>path</code></td>
  <td>Substitua <code>&lt;<em>cookie_path</em>&gt;</code> pelo caminho que é anexado ao subdomínio do Ingresso e que indica para quais domínios e subdomínios o cookie é enviado para o balanceador de carga de aplicativo. Por exemplo, se o seu domínio do Ingresso for <code>www.myingress.com</code> e você desejar enviar o cookie em cada solicitação do cliente, deverá configurar <code>path=/</code>. Se desejar enviar o cookie somente para <code>www.myingress.com/myapp</code> e todos os seus subdomínios, então deverá configurar <code>path=/myapp</code>.</td>
  </tr>
  <tr>
  <td><code>hash</code></td>
  <td>Substitua <code>&lt;<em>hash_algorithm</em>&gt;</code> pelo algoritmo hash que protege as informações no cookie. Somente <code>sha1
</code> é suportado. SHA1 cria uma soma de hash com base nas informações no cookie e anexa essa soma de hash ao cookie. O servidor pode decriptografar as informações no cookie e verificar a integridade de dados.</td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />



### Portas TCP para balanceadores de carga de aplicativo (portas tcp)
{: #tcp-ports}

Acesse um app através de uma porta TCP não padrão.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Use essa anotação para um app que está executando uma carga de trabalho de fluxos de TCP.

<p>**Observação**: o balanceador de carga de aplicativo opera no modo de passagem e encaminha o tráfego para apps backend. A finalização de SSL não é suportada neste caso.</p>
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
name: myingress
annotations:
  ingress.bluemix.net/tcp-ports: "serviceName=&lt;myservice&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
spec:
  tls:
  - System z:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço do Kubernetes para acessar por meio da porta TCP não padrão.</td>
  </tr>
  <tr>
  <td><code>ingressPort</code></td>
  <td>Substitua <code>&lt;<em>ingress_port</em>&gt;</code> pela porta TCP na qual você deseja acessar seu app.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>A substituição de <code>&lt;<em>service_port</em>&gt;</code> por este parâmetro é opcional. Quando fornecido, a porta é substituída para este valor antes que o tráfego seja enviado para o app backend. Caso contrário, a porta permanece igual à porta de Ingresso.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Anotações da conexão
{: #connection}

### Tempos limites de conexão e tempos limites de leitura customizados (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Configure um tempo limite de conexão e um tempo limite de leitura customizados para o balanceador de carga de aplicativo. Ajuste o tempo que o balanceador de carga de aplicativo aguarda para se conectar e ler o aplicativo backend antes de o app de backend ser considerado indisponível.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Quando uma solicitação do cliente é enviada para o balanceador de carga de aplicativo Ingress, uma conexão com o app backend é aberta pelo balanceador de carga de aplicativo. Por padrão, o balanceador de carga de aplicativo aguarda 60 segundos para receber uma resposta do app backend. Se o app backend não responder dentro de 60 segundos, a solicitação de conexão será interrompida e o app backend será considerado indisponível.

</br></br>
Após o balanceador de carga de aplicativo estar conectado ao app backend, os dados de resposta são lidos do app backend pelo balanceador de carga de aplicativo. Durante essa operação de leitura, o balanceador de carga de aplicativo aguarda um máximo de 60 segundos entre duas operações de leitura para receber dados do app backend. Se o app backend não enviar dados dentro de 60 segundos, a conexão com o app backend será encerrada e o app será considerado não disponível.
</br></br>
Um tempo limite de conexão e de leitura de 60 segundos é o tempo limite padrão em um proxy e geralmente não deve ser mudado.
</br></br>
Se a disponibilidade de seu app não for estável ou seu app estiver lento para responder em razão de altas cargas de trabalho, talvez você queira aumentar o tempo limite de conexão ou de leitura. Lembre-se de que aumentar o tempo limite afeta o desempenho do balanceador de carga de aplicativo, já que a conexão com o app backend deverá permanecer aberta até que o tempo limite seja atingido.
</br></br>
Por outro lado, é possível diminuir o tempo limite para obter desempenho no balanceador de carga de aplicativo. Assegure-se de que seu app backend seja capaz de manipular solicitações dentro do tempo limite especificado, mesmo durante cargas de trabalho mais altas.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
   ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;connect_timeout&gt;</code></td>
 <td>O número de segundos de espera para se conectar ao app de backend, por exemplo <code>65s</code>. <strong>Nota:</strong> um tempo limite de conexão não pode exceder 75 segundos.</td>
 </tr>
 <tr>
 <td><code>&lt;read_timeout&gt;</code></td>
 <td>O número de segundos de espera antes que o app de backend seja lido, por exemplo <code>65s</code>.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Solicitações de keep-alive (keepalive-requests)
{: #keepalive-requests}

Configure o número máximo de solicitações que podem ser servidas por meio de uma conexão keepalive.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configura o número máximo de solicitações que podem ser servidas por meio de uma conexão keep-alive.
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
name: myingress
annotations:
  ingress.bluemix.net/keepalive-requests: "serviceName=&lt;myservice&gt; requests=&lt;max_requests&gt;"
spec:
tls:
- System z:
  - mydomain
    secretName: mytlssecret
  rules:
- host: mydomain
  http:
    paths:
    - path: /
      backend:
        serviceName: &lt;myservice&gt;
        servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app. Este parâmetro é opcional. A configuração é aplicada a todos os serviços no host de Ingresso, a menos que um serviço seja especificado. Se o parâmetro for fornecido, as solicitações de keep-alive serão configuradas para o serviço especificado. Se o parâmetro não for fornecido, as solicitações de keep-alive serão configuradas no nível do servidor do <code>nginx.conf</code> para todos os serviços que não tiverem solicitações de keep-alive configuradas.</td>
</tr>
<tr>
<td><code>requests</code></td>
<td>Substitua <code>&lt;<em>max_requests</em>&gt;</code> pelo número máximo de solicitações que podem ser entregues por meio de uma conexão keep-alive.</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### Tempo limite de keep-alive (keepalive-timeout)
{: #keepalive-timeout}

Configure o tempo que uma conexão keep-alive permanece aberta no lado do servidor.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configura o tempo que uma conexão keep-alive permanece aberta no servidor.
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;myservice&gt; timeout=&lt;time&gt;s"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app. Este parâmetro é opcional. Se o parâmetro for fornecido, o tempo limite de keep-alive será configurado para o serviço especificado. Se o parâmetro não for fornecido, o tempo limite de keep-alive será configurado no nível do servidor do <code>nginx.conf</code> para todos os serviços que não têm o tempo limite de keep-alive configurado.</td>
 </tr>
 <tr>
 <td><code>tempo limite </code></td>
 <td>Substitua <code>&lt;<em>time</em>&gt;</code> por uma quantia de tempo em segundos. Exemplo:<code>timeout=20s</code>. Um valor zero desativa as conexões do cliente de keep-alive.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Envio de dados keep-alive (upstream-keepalive)
{: #upstream-keepalive}

Configure o número máximo de conexões keep-alive inativas para um servidor de envio de dados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Mude o número máximo de conexões keep-alive inativas para o servidor de envio de dados de um determinado serviço. O servidor de envio de dados tem 64 conexões keep-alive inativas por padrão.
</dd>


 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;myservice&gt; keepalive=&lt;max_connections&gt;"
 spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
  </tr>
  <tr>
  <td><code>keepalive</code></td>
  <td>Substitua <code>&lt;<em>max_connections</em>&gt;</code> pelo número máximo de conexões keep-alive inativas para o servidor de envio de dados. O padrão é <code>64</code>. Um valor <code>0</code> desativa conexões keep-alive de envio de dados para o serviço especificado.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Anotações de buffer de proxy
{: #proxy-buffer}


### Buffer de dados de resposta do cliente (proxy-buffering)
{: #proxy-buffering}

Use a anotação do buffer para desativar o armazenamento de dados de resposta no balanceador de carga de aplicativo enquanto os dados são enviados para o cliente.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O balanceador de carga do aplicativo de Ingresso age como um proxy entre seu aplicativo de backend e o navegador da web do
cliente. Quando uma resposta é enviada do app backend para o cliente, os dados de resposta são armazenados em buffer no balanceador de carga de aplicativo por padrão. O balanceador de carga de aplicativo envia a resposta do cliente por proxy e começa a enviar a resposta para o cliente no ritmo do cliente. Depois de todos os dados do app backend serem recebidos pelo balanceador de carga de aplicativo, a conexão com o app backend será encerrada. A conexão do balanceador de carga de aplicativo para o cliente permanece aberta até que o cliente receba todos os dados.

</br></br>
Se o armazenamento em buffer de dados de resposta no balanceador de carga de aplicativo está desativado, os dados são enviados imediatamente do balanceador de carga de aplicativo para o cliente. O cliente deve ser capaz de manipular dados recebidos no ritmo do balanceador de carga do aplicativo. Se o cliente for muito lento, poderá haver perda de dados.
</br></br>
O armazenamento em buffer de dados de resposta no balanceador de carga de aplicativo é ativado por padrão.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingress.bluemix.net/proxy-buffering: "False"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

<br />



### Buffers de proxy (proxy-buffers)
{: #proxy-buffers}

Configure o número e o tamanho dos buffers de proxy para o balanceador de carga de aplicativo.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configure o número e o tamanho dos buffers que leem uma resposta para uma conexão única do servidor com proxy. A configuração é aplicada a todos os serviços no host de Ingresso, a menos que um serviço seja especificado. Por exemplo, se uma configuração como <code>serviceName=SERVICE=2 size=1k</code> for especificada, 1K será aplicado ao serviço. Se uma configuração como <code>number=2 size=1k</code> for especificada, 1K será aplicado a todos os serviços no host de Ingresso.
</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 nome: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-buffers: "serviceName=&lt;myservice&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome de um serviço para aplicar proxy-buffers.</td>
 </tr>
 <tr>
 <td><code>number_of_buffers</code></td>
 <td>Substitua <code>&lt;<em>number_of_buffers</em>&gt;</code> por um número, como <em>2</em>.</td>
 </tr>
 <tr>
 <td><code>Padrão</code></td>
 <td>Substitua <code>&lt;<em>size</em>&gt;</code> pelo tamanho de cada buffer em kilobytes (k ou K), tal como <em>1K</em>.</td>
 </tr>
 </tbody>
 </table>
 </dd></dl>

<br />


### Tamanho do buffer de proxy (proxy-buffer-size)
{: #proxy-buffer-size}

Configure o tamanho do buffer de proxy que lê a primeira parte da resposta.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configure o tamanho do buffer que lê a primeira parte da resposta que é recebida do servidor com proxy. Essa parte da resposta geralmente contém um cabeçalho de resposta pequeno. A configuração é aplicada a todos os serviços no host de Ingresso, a menos que um serviço seja especificado. Por exemplo, se uma configuração como <code>serviceName=SERVICE size=1k</code> for especificada, 1k será aplicado ao serviço. Se uma configuração como <code>size=1k</code> for especificada, 1k será aplicado a todos os serviços no host de Ingresso.
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 nome: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;myservice&gt; size=&lt;size&gt;"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080
 </code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome de um serviço para aplicar proxy-buffers-size.</td>
 </tr>
 <tr>
 <td><code>Padrão</code></td>
 <td>Substitua <code>&lt;<em>size</em>&gt;</code> pelo tamanho de cada buffer em kilobytes (k ou K), tal como <em>1K</em>.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Tamanho de buffers ocupados de proxy (proxy-busy-buffers-size)
{: #proxy-busy-buffers-size}

Configure o tamanho de buffers de proxy que podem estar ocupados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Limite o tamanho dos buffers que estão enviando uma resposta ao cliente enquanto a resposta ainda não está totalmente lida. Enquanto isso, o restante dos buffers pode ler a resposta e, se necessário, parte do buffer da resposta em um arquivo temporário. A configuração é aplicada a todos os serviços no host de Ingresso, a menos que um serviço seja especificado. Por exemplo, se uma configuração como <code>serviceName=SERVICE size=1k</code> for especificada, 1k será aplicado ao serviço. Se uma configuração como <code>size=1k</code> for especificada, 1k será aplicado a todos os serviços no host de Ingresso.
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 nome: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-busy-buffers-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome de um serviço para aplicar proxy-busy-buffers-size.</td>
</tr>
<tr>
<td><code>Padrão</code></td>
<td>Substitua <code>&lt;<em>size</em>&gt;</code> pelo tamanho de cada buffer em kilobytes (k ou K), tal como <em>1K</em>.</td>
</tr>
</tbody></table>

 </dd>
 </dl>

<br />



## Anotações de solicitação e de resposta
{: #request-response}


### Cabeçalho de solicitação ou resposta do cliente adicional (cabeçalhos adicionais de proxy)
{: #proxy-add-headers}

Inclua informações extras do cabeçalho em uma solicitação do cliente antes de enviar a solicitação para o app backend ou para uma resposta do cliente antes de enviar a resposta ao cliente.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O balanceador de carga de aplicativo do Ingress age como um proxy entre o aplicativo do cliente e o app backend. As solicitações do cliente que são enviadas para o balanceador de carga de aplicativo são processadas (por proxy) e colocadas em uma nova solicitação que é, então, enviada do balanceador de carga de aplicativo para seu app backend. Transmitir uma solicitação por proxy remove as informações do cabeçalho de HTTP, como o nome do usuário, que foi inicialmente enviado do cliente. Se o seu app backend requerer essas informações, será possível usar a anotação <strong>ingress.bluemix.net/proxy-add-headers</strong> para incluir informações do cabeçalho na solicitação do cliente antes de a solicitação ser encaminhada do balanceador de carga do aplicativo para seu app de backend.

</br></br>
Quando um app backend envia uma resposta para o cliente, a resposta é enviada por proxy pelo balanceador de carga de aplicativo e os cabeçalhos de HTTP são removidos da resposta. O app da web do cliente pode requerer essas informações de cabeçalho para processar com êxito a resposta. É possível usar a anotação <strong>ingress.bluemix.net/response</strong> para incluir informações do cabeçalho na resposta do cliente antes de a resposta ser encaminhada do balanceador de carga de aplicativo para o app da web do cliente.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;myservice1&gt; {
      &lt;header1&gt; &lt;value1&gt;;
      &lt;header2&gt; &lt;value2&gt;;
      }
      serviceName=&lt;myservice2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;myservice1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;myservice2&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: / backend: serviceName: &lt;myservice1&gt; servicePort: 8080
      - path: /myapp backend: serviceName: &lt;myservice2&gt; servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>service_name</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
  </tr>
  <tr>
  <td><code>&lt;header&gt;</code></td>
  <td>A chave das informações do cabeçalho para incluir na solicitação do cliente ou resposta do cliente.</td>
  </tr>
  <tr>
  <td><code>&lt;value&gt;</code></td>
  <td>O valor das informações do cabeçalho para incluir na solicitação do cliente ou resposta do cliente.</td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />



### Remoção do cabeçalho de resposta do cliente (response-remove-headers)
{: #response-remove-headers}

Remova as informações do cabeçalho que são incluídas na resposta do cliente do app final de backend antes de a resposta ser enviada para o cliente.
 {:shortdesc}

 <dl>
 <dt>Descrição</dt>
 <dd>O balanceador de carga do aplicativo de Ingresso age como um proxy entre seu aplicativo de backend e o navegador da web do
cliente. As respostas do cliente do app backend que são enviadas para o balanceador de carga de aplicativo são processadas (por proxy) e colocadas em uma nova resposta, que é então enviada do balanceador de carga de aplicativo para o navegador da web do cliente. Embora a transmissão de uma resposta por proxy remova as informações do cabeçalho de HTTP inicialmente enviadas do app backend, esse processo pode não remover todos os cabeçalhos específicos do app backend. Remova informações do cabeçalho de uma resposta do cliente antes de a resposta ser encaminhada do balanceador de carga de aplicativo para o navegador da web do cliente.</dd>
 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadados:
   name: myingress
   annotations:
     ingress.bluemix.net/response-remove-headers: |
       serviceName=&lt;myservice1&gt; {
       "&lt;header1&gt;";
       "&lt;header2&gt;";
       }
       serviceName=&lt;myservice2&gt; {
       "&lt;header3&gt;";
       }
 spec:
   tls:
   - System z:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: / backend: serviceName: &lt;myservice1&gt; servicePort: 8080
       - path: /myapp backend: serviceName: &lt;myservice2&gt; servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>service_name</code></td>
   <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
   </tr>
   <tr>
   <td><code>&lt;header&gt;</code></td>
   <td>A chave do cabeçalho para remover da resposta do cliente.</td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


### Tamanho máximo do corpo da solicitação do cliente customizado (client-max-body-size)
{: #client-max-body-size}

Ajuste o tamanho máximo do corpo que o cliente pode enviar como parte de uma solicitação.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Para manter o desempenho esperado, o tamanho máximo do corpo de solicitação do cliente é configurado como 1 megabyte. Quando uma solicitação do cliente com um tamanho do corpo acima do limite é enviada para o balanceador de carga de aplicativo de Ingresso e o cliente não permite que os dados sejam divididos, o balanceador de carga de aplicativo retorna uma resposta HTTP 413 (Entidade de solicitação muito grande) ao cliente. Uma conexão entre o cliente e o balanceador de carga de aplicativo não é possível até que o tamanho do corpo de solicitação seja reduzido. Quando o cliente permite que os dados sejam divididos em múltiplos chunks, os dados são divididos em pacotes de 1 megabyte e enviados para o balanceador de carga de aplicativo.

</br></br>
Talvez você queira aumentar o tamanho máximo do corpo porque espera solicitações do cliente com um tamanho de corpo maior que 1 megabyte. Por exemplo, você deseja que seu cliente possa fazer upload de arquivos grandes. Aumentar o tamanho máximo do corpo de solicitação poderá afetar o desempenho de seu balanceador de aplicativo porque a conexão com o cliente deverá permanecer aberta até que a solicitação seja recebida.
</br></br>
<strong>Nota:</strong> alguns navegadores da web do cliente não podem exibir a mensagem de resposta HTTP 413 de forma adequada.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingress.bluemix.net/client-max-body-size: "size=&lt;size&gt;"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;size&gt;</code></td>
 <td>O tamanho máximo do corpo de resposta do cliente. Por exemplo, para configurá-lo como 200 megabytes, defina <code>200 m</code>.  <strong>Nota:</strong> será possível configurar o tamanho como 0 para desativar a verificação do tamanho do corpo de solicitação do cliente.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



## Anotações de limite de serviço
{: #service-limit}


### Limites de taxa global (global-rate-limit)
{: #global-rate-limit}

Limite a taxa de processamento de solicitação e o número de conexões por uma chave definida para todos os serviços.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Para todos os serviços, limite a taxa de processamento de solicitação e o número de conexões por uma chave definida que estão vindo de um único endereço IP para todos os caminhos dos backends selecionados.
</dd>


 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/global-rate-limit: "key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
 spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>chave</code></td>
  <td>Para configurar um limite global para solicitações recebidas baseadas no local ou no serviço, use `key=location`. Para configurar um limite global para solicitações recebidas com base no cabeçalho, use `X-USER-ID key==$http_x_user_id`.</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>Substitua <code>&lt;<em>rate</em>&gt;</code> pela taxa de processamento. Insira um valor como uma taxa por segundo (r/s) ou taxa por minuto (r/m). Exemplo: <code>50r/m</code>.</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>Substitua <code>&lt;<em>conn</em>&gt;</code> pelo número de conexões.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

<br />



### Limites de taxa de serviço (service-rate-limit)
{: #service-rate-limit}

Limitar a taxa de processamento de solicitação e o número de conexões para serviços específicos.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Para serviços específicos, limite a taxa de processamento de solicitação e o número de conexões por uma chave definida que estão vindo de um único endereço IP para todos os caminhos dos backends selecionados.
</dd>


 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;myservice&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
 spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço para o qual você deseja limitar a taxa de processamento.</li>
  </tr>
  <tr>
  <td><code>chave</code></td>
  <td>Para configurar um limite global para solicitações recebidas baseadas no local ou no serviço, use `key=location`. Para configurar um limite global para solicitações recebidas com base no cabeçalho, use `X-USER-ID key==$http_x_user_id`.</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>Substitua <code>&lt;<em>rate</em>&gt;</code> pela taxa de processamento. Para definir uma taxa por segundo, use r/s: <code>10r/s</code>. Para definir uma taxa por minuto, use r/m: <code>50r/m</code>.</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>Substitua <code>&lt;<em>conn</em>&gt;</code> pelo número de conexões.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />



## Anotações de autenticação HTTPS e TLS/SSL
{: #https-auth}


### Portas HTTP e HTTPS customizadas (custom-port)
{: #custom-port}

Mude as portas padrão para o tráfego de rede HTTP (porta 80) e HTTPS (porta 443).
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Por padrão, o balanceador de carga do aplicativo Ingress é configurado para atender ao tráfego de rede HTTP recebido na porta 80 e para o tráfego de rede HTTPS recebido na porta 443. É possível mudar as portas padrão para incluir segurança para o domínio balanceador de seu aplicativo ou ativar somente uma porta HTTPS.
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingress.bluemix.net/custom-port: "protocol=&lt;protocol1&gt; port=&lt;port1&gt;;protocol=&lt;protocol2&gt;port=&lt;port2&gt;"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;protocol&gt;</code></td>
 <td>Insira <strong>http</strong> ou <strong>https</strong> para mudar a porta padrão para o tráfego de rede recebido HTTP ou HTTPS.</td>
 </tr>
 <tr>
 <td><code>&lt;port&gt;</code></td>
 <td>Insira o número da porta que você deseja usar para o tráfego de rede recebido HTTP ou HTTPS. <p><strong>Nota:</strong> quando uma porta customizada é especificada para HTTP ou HTTPS, as portas padrão não são mais válidas para HTTP e HTTPS. Por exemplo, para mudar a porta padrão para HTTPS para 8443, mas usar a porta padrão para HTTP, deve-se configurar portas customizadas para ambos: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p></td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Uso</dt>
 <dd><ol><li>Revise as portas abertas para seu balanceador de carga de aplicativo. 
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
A saída da CLI é semelhante à seguinte:
<pre class="screen">
<code>NAME CLUSTER-IP EXTERNAL-IP PORT(S) AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>Abra o mapa de configuração do controlador do Ingresso.
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>Inclua as portas HTTP e HTTPS não padrão no mapa de configuração. Substitua &lt;port&gt; pelas portas HTTP ou HTTPS que você deseja abrir.
<pre class="codeblock">
<code>apiVersion: v1
kind: ConfigMap
dados:
 public-ports: &lt;port1&gt;;&lt;port2&gt;
metadados:
 creationTimestamp: 2017-08-22T19:06:51Z
 name: ibm-cloud-provider-ingress-cm
 namespace: kube-system
 resourceVersion: "1320"
 selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
 uid: &lt;uid&gt;</code></pre></li>
 <li>Verifique se o seu controlador do Ingresso foi reconfigurado com as portas não padrão.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
A saída da CLI é semelhante à seguinte:
<pre class="screen">
<code>NAME CLUSTER-IP EXTERNAL-IP PORT(S) AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>Configure seu Ingresso para usar as portas não padrão ao rotear o tráfego de rede recebido para seus serviços. Use o arquivo YAML de amostra nesta referência. </li>
<li>Atualize a configuração do controlador do Ingresso.
<pre class="pre">
<code>kubectl apply -f &lt;yaml_file&gt;</code></pre>
</li>
<li>Abra seu navegador da web preferencial para acessar seu app. Exemplo: <code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>

<br />



### Redirecionamentos de HTTP para HTTPS (redirect-to-https)
{: #redirect-to-https}

Converta as solicitações não seguras do cliente HTTP para HTTPS.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Você configura seu balanceador de carga do aplicativo Ingress para proteger seu domínio com o certificado TLS fornecido pela IBM ou seu certificado TLS customizado. Alguns usuários podem tentar acessar seus apps usando uma solicitação de HTTP insegura para o domínio do balanceador de carga de aplicativo, por exemplo <code>http://www.myingress.com</code>, em vez de usar <code>https</code>. É possível usar a anotação de redirecionamento para sempre converter solicitações de HTTP não seguras para HTTPS. Se você não usar essa anotação, as solicitações de HTTP não seguras não serão convertidas em solicitações de HTTPS por padrão e poderão expor informações confidenciais não criptografadas ao público.

</br></br>
O redirecionamento de solicitações de HTTP para HTTPS é desativado por padrão.</dd>

<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingress.bluemix.net/redirect-to-https: "True"
spec:
 tls:
 - System z:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

<br />



### Autenticação mútua (mutual-auth)
{: #mutual-auth}

Configure a autenticação mútua para o balanceador de carga do aplicativo.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configure a autenticação mútua para o balanceador de carga do aplicativo Ingress. O cliente autentica o servidor e o servidor também autentica o cliente usando certificados. A autenticação mútua também é conhecida como autenticação baseada em certificado ou autenticação de duas vias.
</dd>

<dt>Pré-requisitos</dt>
<dd>
<ul>
<li>[Deve-se ter um segredo válido que contenha a autoridade de certificação (CA) necessária](cs_app.html#secrets). O <code>client.key</code> e o <code>client.crt</code> também são necessários para autenticar com autenticação mútua.</li>
<li>Para ativar a autenticação mútua em uma porta diferente de 443, [configure o balanceador de carga para abrir a porta válida](cs_ingress.html#opening_ingress_ports).</li>
</ul>
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
name: myingress
annotations:
  ingress.bluemix.net/mutual-auth: "secretName=&lt;mysecret&gt; port=&lt;port&gt; serviceName=&lt;servicename1&gt;,&lt;servicename2&gt;"
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
</thead>
<tbody>
<tr>
<td><code>secretName</code></td>
<td>Substitua <code>&lt;<em>mysecret</em>&gt;</code> por um nome para o recurso secreto.</td>
</tr>
<tr>
<td><code>&lt;port&gt;</code></td>
<td>O número da porta do balanceador de carga de aplicativo.</td>
</tr>
<tr>
<td><code>&lt;serviceName&gt;</code></td>
<td>O nome de um ou mais recursos de Ingresso. Este parâmetro é opcional.</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### Suporte de serviços SSL (ssl-services)
{: #ssl-services}

Permitir solicitações de HTTPS e criptografar o tráfego para seus apps de envio de dados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Criptografe o tráfego para seus apps de envio de dados que requerem HTTPS com os balanceadores de carga de aplicativo.

**Opcional**: é possível incluir [autenticação unidirecional ou autenticação mútua](#ssl-services-auth) nessa anotação.
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: &lt;myingressname&gt;
  annotations:
    ingress.bluemix.net/ssl-services: "ssl-service=&lt;myservice1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;myservice2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
spec:
  regras:
  - host: mydomain
    http:
      paths:
      - path: / backend: serviceName: myservice1 servicePort: 8443
      - path: /
        backend:
          serviceName: myservice2
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço que representa seu app. O tráfego é criptografado do balanceador de carga de aplicativo para esse app.</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Substitua <code>&lt;<em>service-ssl-secret</em>&gt;</code> pelo segredo para do serviço. Este parâmetro é opcional. Se o parâmetro for fornecido, o valor deverá conter a chave e o certificado que o seu app está esperando do cliente.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


#### Suporte de serviços SSL com autenticação
{: #ssl-services-auth}

Permita as solicitações de HTTPS e criptografe o tráfego para seus apps de envio de dados com autenticação unilateral ou mútua para segurança adicional.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configure a autenticação mútua para apps de balanceamento de carga que requerem HTTPS com os controladores de Ingresso.

**Nota**: antes de iniciar, [converta o certificado e chave em base-64 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.base64encode.org/).

</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: &lt;myingressname&gt;
  annotations:
    ingress.bluemix.net/ssl-services: |
      ssl-service=&lt;myservice1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;myservice2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
spec:
  tls:
  - System z:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: / backend: serviceName: myservice1 servicePort: 8443
      - path: /
        backend:
          serviceName: myservice2
          servicePort: 8444
          </code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço que representa seu app. O tráfego é criptografado do balanceador de carga de aplicativo para esse app.</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Substitua <code>&lt;<em>service-ssl-secret</em>&gt;</code> pelo segredo para do serviço. Este parâmetro é opcional. Se o parâmetro for fornecido, o valor deverá conter a chave e o certificado que o seu app está esperando do cliente.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>


<br />



