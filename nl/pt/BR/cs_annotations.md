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



# Customizando o Ingresso com Anotações
{: #ingress_annotation}

Para incluir recursos em seu application load balancer (ALB) de Ingresso, é possível especificar anotações como metadados em um recurso de Ingresso.
{: shortdesc}

**Importante**: antes de usar anotações, verifique se definiu corretamente a configuração do serviço Ingresso seguindo as etapas em [Expondo apps com o Ingresso](cs_ingress.html). Assim que você tiver configurado o ALB do Ingresso com uma configuração básica, será possível expandir os seus recursos incluindo anotações no arquivo do recurso Ingresso.

<table>
<caption>Anotações gerais</caption>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>Anotações gerais</th>
 <th>Nome</th>
 <th>Descrição</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-external-service">Serviços externos</a></td>
 <td><code>proxy-external-service</code></td>
 <td>Inclua definições de caminho para serviços externos, como um serviço hospedado no {{site.data.keyword.Bluemix_notm}}.</td>
 </tr>
 <tr>
 <td><a href="#location-modifier">Modificador de local</a></td>
 <td><code>location-modifier</code></td>
 <td>Modifique a maneira com que o ALB corresponde o URI de solicitação ao caminho do app.</td>
 </tr>
 <tr>
 <td><a href="#location-snippets"> Snippets de local </a></td>
 <td><code> location-snippets </code></td>
 <td>Inclua uma configuração de bloco de local customizado para um serviço.</td>
 </tr>
 <tr>
 <td><a href="#alb-id">Roteamento de ALB privado</a></td>
 <td><code>ALB-ID</code></td>
 <td>Roteie as solicitações recebidas para seus apps com um ALB privado.</td>
 </tr>
 <tr>
 <td><a href="#rewrite-path">Gravar novamente caminhos</a></td>
 <td><code>rewrite-path</code></td>
 <td>Roteie o tráfego de rede recebido para um caminho diferente em que seu app backend atende.</td>
 </tr>
 <tr>
 <td><a href="#server-snippets"> Fragmentos do servidor </a></td>
 <td><code> server-snippets </code></td>
 <td>Inclua uma configuração de bloco do servidor customizado.</td>
 </tr>
 <tr>
 <td><a href="#tcp-ports">Portas TCP</a></td>
 <td><code>tcp-ports</code></td>
 <td>Acesse um app através de uma porta TCP não padrão.</td>
 </tr>
 </tbody></table>

<br>

<table>
<caption>Anotações da conexão</caption>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>Anotações da conexão</th>
 <th>Nome</th>
 <th>Descrição</th>
  </thead>
  <tbody>
  <tr>
  <td><a href="#proxy-connect-timeout">Tempos limite de conexão e tempos limite de leitura customizados</a></td>
  <td><code>proxy-connect-timeout, proxy-read-timeout</code></td>
  <td>Configure o tempo que o ALB aguardará para se conectar e ler o app de backend antes que esse app seja considerado indisponível.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-requests">Solicitações de keep-alive</a></td>
  <td><code>keepalive-requests</code></td>
  <td>Configure o número máximo de solicitações que podem ser entregues por meio de uma conexão keep-alive.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-timeout">Tempo limite de keep-alive</a></td>
  <td><code>keepalive-timeout</code></td>
  <td>Configure o tempo máximo que uma conexão keep-alive permanece aberta no servidor.</td>
  </tr>
  <tr>
  <td><a href="#proxy-next-upstream-config">Próximo envio de dados do proxy</a></td>
  <td><code>proxy-next-upstream-config</code></td>
  <td>Configure quando o ALB pode passar uma solicitação para o próximo servidor de envio de dados.</td>
  </tr>
  <tr>
  <td><a href="#sticky-cookie-services">Afinidade de sessão com cookies</a></td>
  <td><code>sticky-cookie-services</code></td>
  <td>Sempre rotear o tráfego de rede recebido para o mesmo servidor de envio de dados usando um cookie permanente.</td>
  </tr>
  <tr>
  <td><a href="#upstream-fail-timeout"> Failtimeout de envio de dados </a></td>
  <td><code> upstream-fail-timeout </code></td>
  <td>Configure a quantia de tempo durante a qual o ALB pode tentar se conectar ao servidor antes que o servidor seja considerado indisponível.</td>
  </tr>
  <tr>
  <td><a href="#upstream-keepalive">Envio de dados keep-alive</a></td>
  <td><code>upstream-keepalive</code></td>
  <td>Configure o número máximo de conexões keep-alive inativas para um servidor de envio de dados.</td>
  </tr>
  <tr>
  <td><a href="#upstream-max-fails"> maxfailover do envio de dados </a></td>
  <td><code> upstream-max-falha </code></td>
  <td>Configure o número máximo de tentativas malsucedidas para se comunicar com o servidor antes que o servidor seja considerado indisponível.</td>
  </tr>
  </tbody></table>

<br>

  <table>
  <caption>Anotações de autenticação HTTPS e TLS/SSL</caption>
  <col width="20%">
  <col width="20%">
  <col width="60%">
  <thead>
  <th>Anotações de autenticação HTTPS e TLS/SSL</th>
  <th>Nome</th>
  <th>Descrição</th>
  </thead>
  <tbody>
  <tr>
  <td><a href="#appid-auth">Autenticação do {{site.data.keyword.appid_short}}</a></td>
  <td><code>appid-auth</code></td>
  <td>Use o {{site.data.keyword.appid_full_notm}} para autenticar com seu app.</td>
  </tr>
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
  <td><a href="#hsts">HTTP Strict Transport Security (HSTS)</a></td>
  <td><code>hsts</code></td>
  <td>Configure o navegador para acessar o domínio somente usando HTTPS.</td>
  </tr>
  <tr>
  <td><a href="#mutual-auth">Autenticação mútua</a></td>
  <td><code>mutual-auth</code></td>
  <td>Configure a autenticação mútua para o ALB.</td>
  </tr>
  <tr>
  <td><a href="#ssl-services">Suporte a serviços SSL</a></td>
  <td><code>ssl-services</code></td>
  <td>Permita que o suporte de serviços SSL criptografe o tráfego para seus apps de envio de dados que requerem HTTPS.</td>
  </tr>
  </tbody></table>

<br>

<table>
<caption>Anotações do Istio</caption>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>Anotações do Istio</th>
<th>Nome</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td><a href="#istio-services">Serviços do Istio</a></td>
<td><code>istio-services</code></td>
<td>Roteie o tráfego para serviços gerenciados pelo Istio.</td>
</tr>
</tbody></table>

<br>

<table>
<caption>Anotações de buffer de proxy</caption>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>Anotações de buffer de proxy</th>
 <th>Nome</th>
 <th>Descrição</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-buffering">Armazenamento em buffer de dados de resposta do cliente</a></td>
 <td><code>proxy-buffering</code></td>
 <td>Desative o armazenamento em buffer de uma resposta do cliente no ALB ao enviar a resposta para o cliente.</td>
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

<br>

<table>
<caption>Anotações de solicitação e de resposta</caption>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>Anotações de solicitação e de resposta</th>
<th>Nome</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td><a href="#add-host-port"> Incluir a porta do servidor no cabeçalho do host </a></td>
<td><code>add-host-port</code></td>
<td>Inclua a porta do servidor para o host para solicitações de roteamento.</td>
</tr>
<tr>
<td><a href="#client-max-body-size">Tamanho do corpo da solicitação do cliente</a></td>
<td><code>client-max-body-size</code></td>
<td>Configure o tamanho máximo do corpo que o cliente pode enviar como parte de uma solicitação.</td>
</tr>
<tr>
<td><a href="#large-client-header-buffers">Buffers de cabeçalhos do cliente grandes</a></td>
<td><code>large-client-header-buffers</code></td>
<td>Configure o número e o tamanho máximo dos buffers que leem cabeçalhos de solicitação de cliente grandes.</td>
</tr>
<tr>
<td><a href="#proxy-add-headers">Solicitação do cliente ou cabeçalho de resposta adicional</a></td>
<td><code>proxy-add-headers, response-add-headers</code></td>
<td>Inclua informações do cabeçalho em uma solicitação do cliente antes de encaminhar a solicitação para seu app backend ou para uma resposta do cliente antes de enviar a resposta para o cliente.</td>
</tr>
<tr>
<td><a href="#response-remove-headers">Remoção do cabeçalho de resposta do cliente</a></td>
<td><code>response-remove-headers</code></td>
<td>Remover informações do cabeçalho de uma resposta do cliente antes de encaminhar a resposta para o cliente.</td>
</tr>
</tbody></table>

<br>

<table>
<caption>Anotações de limite de serviço</caption>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>Anotações de limite de serviço</th>
<th>Nome</th>
<th>Descrição</th>
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

<br>



## Anotações gerais
{: #general}

### Serviços externos (proxy-external-service)
{: #proxy-external-service}

Inclua definições de caminho para serviços externos, como serviços hospedados no {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Inclua definições de caminho para serviços externos. Use essa anotação somente quando seu app opera em um serviço externo em vez de um serviço de backend. Quando você usa essa anotação para criar uma rota de serviço externo, somente as anotações `client-max-body-size`, `proxy-read-timeout`, `proxy-connect-timeout` e `proxy-buffer` são suportadas em conjunto. Quaisquer outras anotações não são suportadas em conjunto com `proxy-external-service`.<br><br><strong>Nota</strong>: não é possível especificar múltiplos hosts para um único serviço e caminho.
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
  - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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


### Modificador de local (location-modifier)
{: #location-modifier}

Modifique a maneira com que o ALB corresponde o URI de solicitação ao caminho do app.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Por padrão, os ALBs processam os caminhos em que os apps atendem como prefixos. Quando um ALB recebe uma solicitação para um app, o ALB verifica o recurso de Ingresso para um caminho (como um prefixo) que corresponde ao início do URI de solicitação. Se uma correspondência é localizada, a solicitação é encaminhada para o endereço IP do pod no qual o app está implementado.<br><br>A anotação `location-modifier` muda a maneira como o ALB procura correspondências modificando a configuração de bloco de local. O bloco de local determina como as solicitações são manipuladas para o caminho do app.<br><br><strong>Nota</strong>: para manipular caminhos de expressão regular (regex), essa anotação é necessária.</dd>

<dt>Modificadores suportados</dt>
<dd>

<table>
<caption>Modificadores suportados</caption>
 <col width="10%">
 <col width="90%">
 <thead>
 <th>Modificador</th>
 <th>Descrição</th>
 </thead>
 <tbody>
 <tr>
 <td><code>=</code></td>
 <td>O modificador sinal de igual faz com que o ALB selecione somente as correspondências exatas. Quando uma correspondência exata é localizada, a procura para e o caminho correspondente é selecionado.<br>Por exemplo, se seu app atende em <code>/tea</code>, o ALB seleciona somente caminhos <code>/tea</code> exatos ao corresponder uma solicitação com seu app.</td>
 </tr>
 <tr>
 <td><code>~</code></td>
 <td>O modificador til faz com que o ALB processe caminhos como caminhos regex com distinção entre maiúsculas e minúsculas durante a correspondência.<br>Por exemplo, se seu app atende em <code>/coffee</code>, o ALB pode selecionar os caminhos <code>/ab/coffee</code> ou <code>/123/coffee</code> ao corresponder uma solicitação com seu app mesmo que os caminhos não estejam configurados explicitamente para seu app.</td>
 </tr>
 <tr>
 <td><code>~\*</code></td>
 <td>O til seguido por um modificador asterisco faz com que o ALB processe caminhos como caminhos regex sem distinção entre maiúsculas e minúsculas durante a correspondência.<br>Por exemplo, se seu app atende em <code>/coffee</code>, o ALB pode selecionar os caminhos <code>/ab/Coffee</code> ou <code>/123/COFFEE</code> ao corresponder uma solicitação com seu app mesmo que os caminhos não estejam configurados explicitamente para seu app.</td>
 </tr>
 <tr>
 <td><code>^~</code></td>
 <td>O acento circunflexo seguido por um modificador til faz com que o ALB selecione a melhor correspondência não regex em vez de um caminho regex.</td>
 </tr>
 </tbody>
</table>

</dd>

<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
name: myingress
annotations:
  ingress.bluemix.net/location-modifier: "modifier='&lt;location_modifier&gt;' serviceName=&lt;myservice1&gt;;modifier='&lt;location_modifier&gt;' serviceName=&lt;myservice2&gt;"
spec:
  tls:
  - hosts:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice&gt;
          servicePort: 80</code></pre>

 <table>
 <caption>Entendendo os componentes de anotação</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
  </thead>
  <tbody>
  <tr>
  <td><code>modifier</code></td>
  <td>Substitua <code>&lt;<em>location_modifier</em>&gt;</code> pelo modificador de local que você deseja usar para o caminho. Os modificadores suportados são <code>'='</code>, <code>'~'</code>, <code>'~\*'</code> e <code>'^~'</code>. Deve-se colocar os modificadores entre aspas simples.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />


### Fragmentos de local (location-snippets)
{: #location-snippets}

Inclua uma configuração de bloco de local customizado para um serviço.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Um bloco do servidor é uma diretiva nginx que define a configuração para o servidor virtual do ALB. Um bloco de local é uma diretiva nginx definida dentro do bloco do servidor. Os blocos de local definem como o Ingresso processa o URI de solicitação ou a parte da solicitação que vem após o nome de domínio ou endereço IP e porta.<br><br>Quando um bloco de servidor recebe uma solicitação, o bloco de local corresponde ao URI para um caminho e a solicitação é encaminhada para o endereço IP do pod no qual o app está implementado. Usando a anotação <code>location-snippets</code>, é possível modificar como o bloco de local encaminha as solicitações para serviços específicos.<br><br>Para modificar o bloco do servidor como um todo, consulte a anotação <a href="#server-snippets">server-snippets</a>.</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
name: myingress
annotations:
  ingresso s.bluemix.net/location-snippets: |
    serviceName=&lt;myservice&gt;
    # Exemplo de snippet de local
    proxy_request_buffering off;
    rewrite_log on;
    proxy_set_header "x-header-test-header" "location-snippet-header";
    &lt;EOS&gt;
spec:
tls:
- hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço que você criou para seu app.</td>
</tr>
<tr>
<td>Fragmento de local</td>
<td>Forneça o fragmento de configuração que você deseja usar para o serviço especificado. Esse fragmento de amostra configura o bloco de local para desativar o armazenamento em buffer de solicitação de proxy, ativar regravações de log e configurar cabeçalhos adicionais quando ele encaminha uma solicitação para o serviço <code>myservice</code>.</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />


### Roteamento de ALB privado (ALB-ID)
{: #alb-id}

Roteie as solicitações recebidas para seus apps com um ALB privado.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Escolha um ALB privado para rotear solicitações recebidas em vez do ALB público.</dd>


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
- hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>&lt;private_ALB_ID&gt;</code></td>
<td>O ID para seu ALB privado. Para localizar o ID de ALB privado, execute <code>ibmcloud ks albs --cluster &lt;my_cluster&gt;</code>.<p>
Se você tiver um cluster de múltiplas zonas com mais de um ALB privado ativado, será possível fornecer uma lista de IDs de ALB separados por <code>;</code>. Por exemplo: <code>ingress.bluemix.net/ALB-ID: &lt;private_ALB_ID_1&gt;;&lt;private_ALB_ID_2&gt;;&lt;private_ALB_ID_3&gt</code></p>
</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />


### Gravar novamente caminhos (rewrite-path)
{: #rewrite-path}

Roteie o tráfego de rede recebido em um caminho de domínio do ALB para um caminho diferente no qual seu aplicativo backend atende.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Seu domínio de ALB de Ingresso roteia o tráfego de rede recebido em <code>mykubecluster.us-south.containers.appdomain.cloud/beans</code> para seu app. O seu app atende em <code>/coffee</code>, em vez de <code>/beans</code>. Para encaminhar o tráfego de rede recebido para o seu app, inclua a anotação de regravação em seu arquivo de configuração do recurso de Ingresso. A anotação de nova gravação assegura que o tráfego de rede recebido em <code>/beans</code> seja encaminhado para o seu app usando o caminho <code>/coffee</code>. Ao incluir múltiplos serviços, use apenas um ponto e vírgula (;) para separá-los.</dd>
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
  - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
</tr>
<tr>
<td><code>rewrite</code></td>
<td>Substitua <code>&lt;<em>target_path</em>&gt;</code> pelo caminho em que seu app atende. O tráfego de rede recebido no domínio do ALB é encaminhado para o serviço Kubernetes usando esse caminho. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. No exemplo acima, o caminho de regravação foi definido como <code>/coffee</code>.</td>
</tr>
</tbody></table>

</dd></dl>

<br />


### Fragmentos do servidor (server-snippets)
{: #server-snippets}

Inclua uma configuração de bloco do servidor customizado.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Um bloco do servidor é uma diretiva nginx que define a configuração para o servidor virtual do ALB. Usando a anotação <code>server-snippets</code>, é possível modificar como o ALB manipula solicitações fornecendo um fragmento de configuração customizada.</dd>

<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
name: myingress
annotations:
  ingresso s.bluemix.net/server-snippets: |
    location = /health {
    return 200 'Healthy';
    add_header Content-Type text/plain;
    }
spec:
tls:
- hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td>Fragmento do servidor</td>
<td>Forneça o fragmento de configuração que você deseja usar. Esse fragmento de amostra especifica um bloco de local para manipular as solicitações <code>/health</code>. O bloco de local é configurado para retornar uma resposta funcional e incluir um cabeçalho quando ele encaminha uma solicitação.</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />


### Portas TCP para balanceadores de carga de aplicativo (portas tcp)
{: #tcp-ports}

Acesse um app através de uma porta TCP não padrão.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Use essa anotação para um app que está executando uma carga de trabalho de fluxos de TCP.

<p>**Nota**: o ALB opera no modo de passagem e encaminha o tráfego para apps de backend. A finalização de SSL não é suportada neste caso. A conexão TLS não é finalizada e passa intacta.</p>
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
  - hosts:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice&gt;
          servicePort: 80</code></pre>

 <table>
 <caption>Entendendo os componentes de anotação</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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
  <td>Este parâmetro é opcional. Quando fornecido, a porta é substituída para este valor antes que o tráfego seja enviado para o app backend. Caso contrário, a porta permanece igual à porta de Ingresso.</td>
  </tr>
  </tbody></table>

 </dd>
 <dt>Uso</dt>
 <dd><ol><li>Revise as portas abertas de seu ALB.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
A saída da CLI é semelhante à seguinte:
<pre class="screen">
<code>NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
public-cr18e61e63c6e94b658596ca93d087eed9-alb1 LoadBalancer 10.xxx.xx.xxx 169.xx.xxx.xxx 80:30416/TCP,443:32668/TCP 109d</code></pre></li>
<li>Abra o mapa de configuração do ALB.
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>Inclua as portas TCP no mapa de configuração. Substitua <code>&lt;port&gt;</code> pelas portas TCP que você deseja abrir. <b>Nota</b>: por padrão, as portas 80 e 443 ficam abertas. Se deseja manter a 80 e a 443 abertas, deve-se também incluí-las além de quaisquer outras portas TCP especificadas no campo `public-ports`. Quando se ativa um ALB privado, deve-se também especificar quaisquer portas que deseja manter abertas no campo `private-ports`. Para obter mais informações, veja <a href="cs_ingress.html#opening_ingress_ports">Abrindo portas no ALB do Ingress</a>.
<pre class="codeblock">
<code>apiVersion: v1
kind: ConfigMap
dados:
 public-ports: 80;443;&lt;port1&gt;;&lt;port2&gt;
metadados:
 creationTimestamp: 2017-08-22T19:06:51Z
 name: ibm-cloud-provider-ingress-cm
 namespace: kube-system
 resourceVersion: "1320"
 selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
 uid: &lt;uid&gt;</code></pre></li>
 <li>Verifique se o ALB está reconfigurado com as portas TCP.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
A saída da CLI é semelhante à seguinte:
<pre class="screen">
<code>NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
public-cr18e61e63c6e94b658596ca93d087eed9-alb1 LoadBalancer 10.xxx.xx.xxx 169.xx.xxx.xxx &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP 109d</code></pre></li>
<li>Configure seu Ingresso para acessar seu app por meio de uma porta TCP não padrão. Use o arquivo YAML de amostra nesta referência. </li>
<li>Crie seu recurso ALB ou atualize a configuração existente do ALB.
<pre class="pre">
<code>kubectl apply -f myingress.yaml</code></pre>
</li>
<li>Use curl no subdomínio do Ingress para acessar seu app. Exemplo:  <code> curl  &lt;domain&gt;: &lt;ingressPort&gt; </code></li></ol></dd></dl>

<br />


## Anotações da conexão
{: #connection}

### Tempos limites de conexão e tempos limites de leitura customizados (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Configure o tempo que o ALB aguardará para se conectar e ler o app de backend antes que esse app seja considerado indisponível.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Quando uma solicitação do cliente é enviada para o ALB de Ingresso, uma conexão com o app backend é aberta pelo ALB. Por padrão, o ALB aguarda 60 segundos para receber uma resposta do app backend. Se o app backend não responder dentro de 60 segundos, a solicitação de conexão será interrompida e o app backend será considerado indisponível.

</br></br>
Depois que o ALB é conectado ao app backend, os dados de resposta são lidos do app backend pelo ALB. Durante essa operação de leitura, o ALB aguarda um máximo de 60 segundos entre duas operações de leitura para receber dados do app backend. Se o app backend não enviar dados dentro de 60 segundos, a conexão com o app backend será encerrada e o app será considerado não disponível.
</br></br>
Um tempo limite de conexão e de leitura de 60 segundos é o tempo limite padrão em um proxy e geralmente não deve ser mudado.
</br></br>
Se a disponibilidade de seu app não for estável ou seu app estiver lento para responder em razão de altas cargas de trabalho, talvez você queira aumentar o tempo limite de conexão ou de leitura. Lembre-se de que aumentar o tempo limite afeta o desempenho do ALB porque a conexão com o app backend deve permanecer aberta até que o tempo limite seja atingido.
</br></br>
Por outro lado, é possível diminuir o tempo limite para ganhar desempenho no ALB. Assegure-se de que seu app backend seja capaz de manipular solicitações dentro do tempo limite especificado, mesmo durante cargas de trabalho mais altas.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   Ingress.bluemix.net/proxy-connect-timeout: "serviceName=&lt;myservice&gt; timeout=&lt;connect_timeout&gt;"
   Ingress.bluemix.net/proxy-read-timeout: "serviceName=&lt;myservice&gt; timeout=&lt;read_timeout&gt;"
spec:
 tls:
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;connect_timeout&gt;</code></td>
 <td>O número de segundos ou minutos a aguardar para se conectar ao app de backend, por exemplo, <code>65s</code> ou <code>1m</code>. <strong>Nota:</strong> um tempo limite de conexão não pode exceder 75 segundos.</td>
 </tr>
 <tr>
 <td><code>&lt;read_timeout&gt;</code></td>
 <td>O número de segundos ou minutos a esperar antes de o app de backend ser lido, por exemplo <code>65s</code> ou <code>2m</code>.
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Solicitações de keep-alive (keepalive-requests)
{: #keepalive-requests}

Configure o número máximo de solicitações que podem ser entregues por meio de uma conexão keep-alive.
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
- hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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

Configure o tempo máximo que uma conexão keep-alive permanece aberta no lado do servidor.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configura o tempo máximo que uma conexão keep-alive permanece aberta no servidor.
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
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app. Este parâmetro é opcional. Se o parâmetro for fornecido, o tempo limite de keep-alive será configurado para o serviço especificado. Se o parâmetro não for fornecido, o tempo limite de keep-alive será configurado no nível do servidor do <code>nginx.conf</code> para todos os serviços que não têm o tempo limite de keep-alive configurado.</td>
 </tr>
 <tr>
 <td><code>timeout</code></td>
 <td>Substitua <code>&lt;<em>time</em>&gt;</code> por uma quantia de tempo em segundos. Exemplo:<code>timeout=20s</code>. Um valor zero desativa as conexões do cliente de keep-alive.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />


### Próximo envio de dados do proxy (proxy-next-upstream-config)
{: #proxy-next-upstream-config}

Configure quando o ALB pode passar uma solicitação para o próximo servidor de envio de dados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
O ALB do Ingress age como um proxy entre o app do cliente e seu app. Algumas configurações de app requerem múltiplos servidores de envio de dados que manipulam solicitações de cliente recebidas do ALB. Às vezes, o servidor proxy usado pelo ALB não pode estabelecer uma conexão com um servidor de envio de dados que o app usa. O ALB poderá então tentar estabelecer uma conexão com o próximo servidor de envio de dados para passar a solicitação para ele, como alternativa. É possível usar a anotação `proxy-next-upstream-config` para configurar em que casos, quanto tempo e quantas vezes o ALB pode tentar passar uma solicitação para o próximo servidor de envio de dados.<br><br><strong>Nota</strong>: o tempo limite é sempre configurado quando você usa `proxy-next-upstream-config`, portanto, não inclua `timeout=true` nessa anotação.
</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-next-upstream-config: "serviceName=&lt;myservice1&gt; retries=&lt;tries&gt; timeout=&lt;time&gt; error=true http_502=true; serviceName=&lt;myservice2&gt; http_403=true non_idempotent=true"
spec:
  tls:
  - hosts:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice1
          servicePort: 80
</code></pre>

<table>
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
</tr>
<tr>
<td><code>retries</code></td>
<td>Substitua <code>&lt;<em>tries</em>&gt;</code> pela quantia máxima de vezes que o ALB tentará passar uma solicitação para o próximo servidor de envio de dados. Esse número inclui a solicitação original. Para desativar essa limitação, use <code>0</code>. Se você não especificar um valor, o valor padrão <code>0</code> será usado.
</td>
</tr>
<tr>
<td><code>timeout</code></td>
<td>Substitua <code>&lt;<em>time</em>&gt;</code> pelo período de tempo máximo, em segundos, que o ALB tentará passar uma solicitação para o próximo servidor de envio de dados. Por exemplo, para configurar um tempo de 30 segundos, insira <code>30s</code>. Para desativar essa limitação, use <code>0</code>. Se você não especificar um valor, o valor padrão <code>0</code> será usado.
</td>
</tr>
<tr>
<td><code>error</code></td>
<td>Se configurado como <code>true</code>, o ALB passará uma solicitação para o próximo servidor de envio de dados quando um erro tiver ocorrido ao estabelecer uma conexão com o primeiro servidor de envio de dados, ao passar uma solicitação para ele ou ao ler o cabeçalho de resposta.
</td>
</tr>
<tr>
<td><code>invalid_header</code></td>
<td>Se configurado como <code>true</code>, o ALB passará uma solicitação para o próximo servidor de envio de dados quando o primeiro servidor de envio de dados retornar uma resposta vazia ou inválida.
</td>
</tr>
<tr>
<td><code>http_502</code></td>
<td>Se configurado como <code>true</code>, o ALB passará uma solicitação para o próximo servidor de envio de dados quando o primeiro servidor de envio de dados retornar uma resposta com o código 502. É possível designar os códigos de resposta HTTP a seguir: <code>500</code>, <code>502</code>, <code>503</code>, <code>504</code>, <code>403</code>, <code>404</code>, <code>429</code>.
</td>
</tr>
<tr>
<td><code>non_idempotent</code></td>
<td>Se configurado como <code>true</code>, o ALB poderá passar solicitações com um método não idempotente para o próximo servidor de envio de dados. Por padrão, o ALB não passa essas solicitações para o próximo servidor de envio de dados.
</td>
</tr>
<tr>
<td><code>off</code></td>
<td>Para evitar que o ALB passe solicitações para o próximo servidor de envio de dados, configure como <code>true</code>.
</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />


### Afinidade de sessão com cookies (sticky-cookie-services)
{: #sticky-cookie-services}

Use a anotação de cookie permanente para incluir a afinidade de sessão para o ALB e sempre rotear o tráfego de rede recebido para o mesmo servidor de envio de dados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Para alta disponibilidade, algumas configurações de app requerem que você implemente múltiplos servidores de envio de dados que manipulam solicitações do cliente recebidas. Quando um cliente se conecta ao app backend, é possível usar a afinidade de sessão para que um cliente seja atendido pelo mesmo servidor de envio de dados pela duração de uma sessão ou pelo tempo que leva para concluir uma tarefa. É possível configurar seu ALB para assegurar a afinidade de sessão sempre roteando o tráfego de rede recebido para o mesmo servidor de envio de dados.

</br></br>
Cada cliente que se conecta ao seu app backend é designado a um dos servidores de envio de dados disponíveis pelo ALB. O ALB cria um cookie de sessão que é armazenado no app do cliente, que está incluído nas informações do cabeçalho de cada solicitação entre o ALB e o cliente. As informações no cookie asseguram que todas as solicitações sejam manipuladas pelo mesmo servidor de envio de dados em toda a sessão.

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
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /service1_path backend: serviceName: &lt;myservice1&gt; servicePort: 8080
      - path: /service2_path backend: serviceName: &lt;myservice2&gt; servicePort: 80</code></pre>

  <table>
  <caption>Entendendo os componentes de anotação</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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
  <td>Substitua <code>&lt;<em>expiration_time</em>&gt;</code> pelo tempo em segundos (s), minutos (m) ou horas (h) antes da expiração do cookie permanente. Esse tempo é independente da atividade do usuário. Depois que o cookie expira, ele é excluído pelo navegador da web do cliente e não é mais enviado para o ALB. Por exemplo, para configurar um prazo de expiração de 1 segundo, 1 minuto ou 1 hora, insira <code>1s</code>, <code>1m</code> ou <code>1h</code>.</td>
  </tr>
  <tr>
  <td><code>path</code></td>
  <td>Substitua <code>&lt;<em>cookie_path</em>&gt;</code> pelo caminho que é anexado ao subdomínio do Ingresso e que indica para quais domínios e subdomínios o cookie é enviado para o ALB. Por exemplo, se o seu domínio do Ingresso for <code>www.myingress.com</code> e você desejar enviar o cookie em cada solicitação do cliente, deverá configurar <code>path=/</code>. Se desejar enviar o cookie somente para <code>www.myingress.com/myapp</code> e todos os seus subdomínios, então deverá configurar <code>path=/myapp</code>.</td>
  </tr>
  <tr>
  <td><code>hash</code></td>
  <td>Substitua <code>&lt;<em>hash_algorithm</em>&gt;</code> pelo algoritmo hash que protege as informações no cookie. Somente <code>sha1
</code> é suportado. SHA1 cria uma soma de hash com base nas informações no cookie e anexa essa soma de hash ao cookie. O servidor pode decriptografar as informações no cookie e verificar a integridade de dados.</td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


### Failtimeout de envio de dados (upstream-fail-timeout)
{: #upstream-fail-timeout}

Configure a quantia de tempo durante a qual o ALB pode tentar se conectar ao servidor.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configure a quantia de tempo durante a qual o ALB pode tentar se conectar a um servidor antes que o servidor seja considerado indisponível. Para que um servidor seja considerado indisponível, o ALB deve atingir o número máximo de tentativas de conexão com falha configurado pela anotação <a href="#upstream-max-fails"><code>upstream-max-failed</code></a> dentro da quantia de tempo configurada. Essa quantia de tempo também determina por quanto tempo o servidor é considerado indisponível.
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingresso s.bluemix.net/upstream-fail-timeout: "serviceName= &lt;myservice&gt;  fail-timeout= &lt;fail_timeout&gt;"
spec:
  tls:
  - hosts:
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
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>serviceName(Optional)</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
</tr>
<tr>
<td><code>fail-timeout</code></td>
<td>Substitua <code>&lt;<em>fail_timeout</em>&gt;</code> pela quantia de tempo que o ALB pode tentar se conectar a um servidor antes que o servidor seja considerado indisponível. O padrão é  <code> 10s </code>. O tempo deve ser em segundos.</td>
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
Configure o número máximo de conexões keep-alive inativas para o servidor de envio de dados de um determinado serviço. O servidor de envio de dados tem 64 conexões keep-alive inativas por padrão.
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
  - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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


### Upstream maxfailover (upstream-max-falha)
{: #upstream-max-fails}

Configure o número máximo de tentativas malsucedidas para se comunicar com o servidor.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configure o número máximo de vezes que o ALB pode falhar ao se conectar ao servidor antes que o servidor seja considerado indisponível. Para que o servidor seja considerado indisponível, o ALB deve atingir o número máximo dentro da duração de tempo configurada pela anotação <a href="#upstream-fail-timeout"><code>upstream-fail-timeout</code></a>. A duração de tempo em que o servidor é considerado indisponível também é configurada pela anotação <code>upstream-fail-timeout</code>.</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingresso s.bluemix.net/upstream-max-falha: "serviceName= &lt;myservice&gt;  max-fails= &lt;max_fails&gt;"
spec:
  tls:
  - hosts:
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
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>serviceName(Optional)</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço Kubernetes que você criou para o seu app.</td>
</tr>
<tr>
<td><code> max-falha </code></td>
<td>Substitua <code>&lt;<em>max_fails</em>&gt;</code> pelo número máximo de tentativas malsucedidas que o ALB pode fazer para se comunicar com o servidor. O padrão é <code>1</code>. Um valor <code>0</code> desativa a anotação.</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />


## Anotações de autenticação HTTPS e TLS/SSL
{: #https-auth}

### Autenticação do {{site.data.keyword.appid_short_notm}} (appid-auth)
{: #appid-auth}

Use {{site.data.keyword.appid_full_notm}} para autenticar com seu aplicativo.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Autentique solicitações HTTP/HTTPS da web ou da API com {{site.data.keyword.appid_short_notm}}.

<p>Se você configura o tipo de solicitação para <code>web</code>, uma solicitação da web que contém um token de acesso do {{site.data.keyword.appid_short_notm}} é validada. Se a validação do token falha, a solicitação da web é rejeitada. Se a solicitação não contém um token de acesso, a solicitação é redirecionada para a página de login do {{site.data.keyword.appid_short_notm}}. <strong>Nota</strong>: para que a autenticação da web do {{site.data.keyword.appid_short_notm}} funcione, os cookies devem estar ativados no navegador do usuário.</p>

<p>Se você configura o tipo de solicitação para <code>api</code>, uma solicitação de API que contém um token de acesso do {{site.data.keyword.appid_short_notm}} é validada. Se a solicitação não contém um token de acesso, uma mensagem de erro <code>401: Unauthorized</code> é retornada ao usuário.</p>

<p>**Nota**: por motivos de segurança, a autenticação {{site.data.keyword.appid_short_notm}} suporta apenas backends com TLS/SSL ativado.</p>
</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/appid-auth: "bindSecret=&lt;bind_secret&gt; namespace=&lt;namespace&gt; requestType=&lt;request_type&gt; serviceName=&lt;myservice&gt;"
spec:
  tls:
  - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>bindSecret</code></td>
<td>Substitua <em><code>&lt;bind_secret&gt;</code></em> pelo segredo do Kubernetes que armazena o segredo de ligação para sua instância de serviço do {{site.data.keyword.appid_short_notm}}.</td>
</tr>
<tr>
<td><code> namespace</code></td>
<td>Substitua <em><code>&lt;namespace&gt;</code></em> pelo namespace do segredo de ligação. Este campo é padronizado para o namespace `padrão`.</td>
</tr>
<tr>
<td><code>requestType</code></td>
<td>Substitua <code><em>&lt;request_type&gt;</em></code> pelo tipo de solicitação que você deseja enviar para o {{site.data.keyword.appid_short_notm}}. Os valores aceitos são `web` ou `api`. O padrão é `api`.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code><em>&lt;myservice&gt;</em></code> pelo nome do serviço Kubernetes que você criou para o seu app. Esse campo é obrigatório. Se um nome de serviço não está incluído, a anotação é ativada para todos os serviços.  Se um nome de serviço está incluído, a anotação é ativada somente para esse serviço. Separe múltiplos serviços com uma vírgula (,).</td>
</tr>
</tbody></table>
</dd>
<dt>Uso</dt></dl>

Como o aplicativo usa o {{site.data.keyword.appid_short_notm}} para autenticação, deve-se provisionar uma instância do {{site.data.keyword.appid_short_notm}}, configurar a instância com URIs de redirecionamento válidos e gerar um segredo de ligação, ligando a instância a seu cluster.

1. Escolha uma instância do {{site.data.keyword.appid_short_notm}} existente ou crie uma nova.
    * Para usar uma instância existente, assegure-se de que o nome da instância de serviço não contenha espaços. Para remover espaços, selecione o menu de mais opções próximo ao nome de sua instância de serviço e selecione **Renomear serviço**.
    * Para provisionar uma  [ nova instância do  {{site.data.keyword.appid_short_notm}}  ](https://console.bluemix.net/catalog/services/app-id):
        1. Substitua o **Nome do serviço** preenchido automaticamente por seu próprio nome exclusivo para a instância de serviço.
            **Importante**: o nome da instância de serviço não pode conter espaços.
        2. Escolha a mesma região em que seu cluster está implementado.
        3. Clique em
**Criar**.
2. Inclua URLs de redirecionamento para seu app. Uma URL de redirecionamento é o terminal de retorno de chamada de seu app. Para evitar ataques de phishing, o ID do app valida a URL de solicitação com relação à lista de desbloqueio de URLs de redirecionamento.
    1. No console de gerenciamento do {{site.data.keyword.appid_short_notm}}, navegue para **Provedores de identidade > Gerenciar**.
    2. Certifique-se de que você tenha um Provedor de Identidade selecionado. Se nenhum Provedor de Identidade estiver selecionado, o usuário não será autenticado, mas um token de acesso será emitido para acesso anônimo ao app.
    3. No campo **Incluir URLs de redirecionamento da web**, inclua URLs de redirecionamento para seu app no formato `http://<hostname>/<app_path>/appid_callback `  ou  ` https://<hostname>/<app_path>/appid_callback `.
        * Por exemplo, um app que está registrado com o subdomínio do IBM Ingress pode ser semelhante a `https://mycluster.us-south.containers.appdomain.cloud/myapp1path/appid_callback`.
        * Um app que está registrado com um domínio customizado pode ser semelhante a `http://mydomain.net/myapp2path/appid_callback`.

3. Ligue a instância de serviço do {{site.data.keyword.appid_short_notm}} ao seu cluster.
    ```
    ibmcloud ks cluster-service-bind <cluster_name_or_ID> <namespace> <service_instance_name>
    ```
    {: pre}
    Quando o serviço é incluído com sucesso em seu cluster, é criado um segredo de cluster que contém as credenciais de sua instância de serviço. Exemplo de saída da CLI:
    ```
    ibmcloud ks cluster-service-bind mycluster mynamespace appid1
    Binding service instance to namespace...
    OK
    Namespace:    mynamespace
    Secret name:  binding-<service_instance_name>
    ```
    {: screen}

4. Obtenha o segredo que foi criado em seu namespace do cluster.
    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}

5. Use o segredo de ligação e o namespace do cluster para incluir a anotação `appid-auth` em seu recurso Ingress.

<br />



### Portas HTTP e HTTPS customizadas (custom-port)
{: #custom-port}

Mude as portas padrão para o tráfego de rede HTTP (porta 80) e HTTPS (porta 443).
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Por padrão, o ALB de Ingresso está configurado para atender ao tráfego de rede HTTP recebido na porta 80 e para o tráfego de rede HTTPS recebido na porta 443. É possível mudar as portas padrão para incluir segurança em seu domínio do ALB ou para ativar somente uma porta HTTPS.<p><strong>Nota</strong>: para ativar a autenticação mútua em uma porta, [configure o ALB para abrir a porta válida](cs_ingress.html#opening_ingress_ports) e, em seguida, especifique essa porta na [anotação `mutual-auth`](#mutual-auth). Não use a anotação `custom-port` para especificar uma porta para autenticação mútua.</p></dd>


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
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;protocol&gt;</code></td>
 <td>Insira <code>http</code> ou <code>https</code> para mudar a porta padrão para o tráfego de rede recebido HTTP ou HTTPS.</td>
 </tr>
 <tr>
 <td><code>&lt;port&gt;</code></td>
 <td>Insira o número da porta a ser usado para o tráfego de rede recebido HTTP ou HTTPS.  <p><strong>Nota:</strong> quando uma porta customizada é especificada para HTTP ou HTTPS, as portas padrão não são mais válidas para HTTP e HTTPS. Por exemplo, para mudar a porta padrão para HTTPS para 8443, mas usar a porta padrão para HTTP, deve-se configurar portas customizadas para ambos: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p></td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Uso</dt>
 <dd><ol><li>Revise as portas abertas de seu ALB.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
A saída da CLI é semelhante à seguinte:
<pre class="screen">
<code>NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
public-cr18e61e63c6e94b658596ca93d087eed9-alb1 LoadBalancer 10.xxx.xx.xxx 169.xx.xxx.xxx 80:30416/TCP,443:32668/TCP 109d</code></pre></li>
<li>Abra o mapa de configuração do ALB.
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>Inclua as portas HTTP e HTTPS não padrão no mapa de configuração. Substitua &lt;port&gt; pelas portas HTTP ou HTTPS que você deseja abrir. <b>Nota</b>: por padrão, as portas 80 e 443 ficam abertas. Se deseja manter a 80 e a 443 abertas, deve-se também incluí-las além de quaisquer outras portas TCP especificadas no campo `public-ports`. Quando se ativa um ALB privado, deve-se também especificar quaisquer portas que deseja manter abertas no campo `private-ports`. Para obter mais informações, veja <a href="cs_ingress.html#opening_ingress_ports">Abrindo portas no ALB do Ingress</a>.
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
 <li>Verifique se o ALB está reconfigurado com as portas não padrão.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
A saída da CLI é semelhante à seguinte:
<pre class="screen">
<code>NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
public-cr18e61e63c6e94b658596ca93d087eed9-alb1 LoadBalancer 10.xxx.xx.xxx 169.xx.xxx.xxx &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP 109d</code></pre></li>
<li>Configure seu Ingresso para usar as portas não padrão ao rotear o tráfego de rede recebido para seus serviços. Use o arquivo YAML de amostra nesta referência. </li>
<li>Atualize sua configuração do ALB.
<pre class="pre">
<code>kubectl apply -f myingress.yaml</code></pre>
</li>
<li>Abra seu navegador da web preferencial para acessar seu app. Exemplo: <code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>

<br />



### Redirecionamentos de HTTP para HTTPS (redirect-to-https)
{: #redirect-to-https}

Converta as solicitações não seguras do cliente HTTP para HTTPS.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Você configura seu ALB de Ingresso para proteger seu domínio com o certificado TLS fornecido pela IBM ou seu certificado TLS customizado. Alguns usuários podem tentar acessar seus apps usando uma solicitação de <code>http</code> não segura para seu domínio do ALB, por exemplo <code>http://www.myingress.com</code>, em vez de usar <code>https</code>. É possível usar a anotação de redirecionamento para sempre converter solicitações de HTTP não seguras para HTTPS. Se você não usar essa anotação, as solicitações de HTTP não seguras não serão convertidas em solicitações de HTTPS por padrão e poderão expor informações confidenciais não criptografadas ao público.

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
 - hosts:
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

</dd>

</dl>

<br />


### HTTP Strict Transport Security (hsts)
{: #hsts}

<dl>
<dt>Descrição</dt>
<dd>
O HSTS instrui o navegador a acessar apenas um domínio somente usando HTTPS. Mesmo se o usuário insere ou segue um link HTTP simples, o navegador faz upgrade estritamente da conexão com HTTPS.
</dd>


<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    Ingress.bluemix.net/hsts: enabled=true maxAge= &lt; 31536000 &gt; includeSubdomains = true
spec:
  tls:
  - hosts:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: /service1_path backend: serviceName: myservice1 servicePort: 8443
      - path: /service2_path backend: serviceName: myservice2 servicePort: 8444 </code></pre>

<table>
<caption>Entendendo os componentes de anotação</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ativado</code></td>
  <td>Use <code>true</code> para ativar o HSTS.</td>
  </tr>
    <tr>
  <td><code>maxAge</code></td>
  <td>Substitua <code>&lt;<em>31536000</em>&gt;</code> por um número inteiro representando quantos segundos um navegador armazenará em cache as solicitações de envio diretamente para HTTPS. O padrão é <code>31536000</code>, que é igual a 1 ano.</td>
  </tr>
  <tr>
  <td><code>includeSubdomains</code></td>
  <td>Use <code>true</code> para informar ao navegador que a política HSTS também se aplica a todos os subdomínios do domínio atual. O padrão é <code>true</code>. </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>


<br />


### Autenticação mútua (mutual-auth)
{: #mutual-auth}

Configure a autenticação mútua para o ALB.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Configure a autenticação mútua de tráfego de recebimento de dados para o ALB de Ingresso. O cliente externo autentica o servidor e o servidor também autentica o cliente usando certificados. A autenticação mútua também é conhecida como autenticação baseada em certificado ou autenticação de duas vias.</br></br>
Use a anotação `mutual-auth` para a finalização de SSL entre o cliente e o ALB do Ingress. Use a [anotação `ssl-services`](#ssl-services) para a finalização de SSL entre o ALB do Ingress e o aplicativo backend.
</dd>

<dt>Pré-requisitos</dt>
<dd>
<ul>
<li>Deve-se ter um segredo de autenticação mútua válido que contenha o <code>ca.crt</code> necessário. Para criar um segredo de autenticação mútua, consulte as etapas no final desta seção.</li>
<li>Para ativar a autenticação mútua em uma porta diferente de 443, [configure o ALB para abrir a porta válida](cs_ingress.html#opening_ingress_ports) e, em seguida, especifique essa porta nesta anotação. Não use a anotação `custom-port` para especificar uma porta para autenticação mútua.</li>
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
  - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>secretName</code></td>
<td>Substitua <code>&lt;<em>mysecret</em>&gt;</code> por um nome para o recurso secreto.</td>
</tr>
<tr>
<td><code>port</code></td>
<td>Substitua <code>&lt;<em>port</em>&gt;</code> pelo número da porta ALB.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code>&lt;<em>servicename</em>&gt;</code> pelo nome de um ou mais recursos do Ingress. Este parâmetro é opcional.</td>
</tr>
</tbody></table>

</dd>
</dl>

**Para criar um segredo de autenticação mútua:**

1. Gere uma chave e um certificado de uma das maneiras a seguir:
    * Gere um certificado de autoridade de certificação (CA) e a chave por meio do provedor de certificado. Se você tiver seu próprio domínio, compre um certificado TLS oficial para seu domínio.
      **Importante**: certifique-se de que o [CN ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://support.dnsimple.com/articles/what-is-common-name/) seja diferente para cada certificado.
    * Para propósitos de teste, é possível criar um certificado auto-assinado usando o OpenSSL. Para obter mais informações, consulte esse [tutorial de certificado SSL autoassinado ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.akadia.com/services/ssh_test_certificate.html).
        1. Crie um `ca.key`.
            ```
            openssl genrsa -out ca.key 1024
            ```
            {: pre}
        2. Use a chave para criar um `ca.crt`.
            ```
            openssl req -new -x509 -key ca.key -out ca.crt
            ```
            {: pre}
        3. Use o `ca.crt` para criar um certificado autoassinado.
            ```
            openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
            ```
            {: pre}
2. [Converta o certificado na base 64 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.base64encode.org/).
3. Crie um arquivo do YAML secreto usando o cert.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       ca.crt: <ca_certificate>
     ```
     {: codeblock}
4. Crie o certificado como um segredo do Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

<br />



### Suporte de serviços SSL (ssl-services)
{: #ssl-services}

Permitir solicitações de HTTPS e criptografar o tráfego para seus apps de envio de dados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Quando a sua configuração do recurso Ingresss tem uma seção TLS, o ALB do Ingresso pode manipular solicitações de URL protegida por HTTPS para o seu app. No entanto, o ALB manipula a finalização do TLS e decriptografa a solicitação antes de encaminhar o tráfego para seus apps. Se você tiver apps que requerem o protocolo HTTPS e precisar do tráfego para permanecer criptografado, use a anotação `ssl-services` para desativar a finalização do TLS padrão do ALB. O ALB finaliza a conexão do TLS e criptografa novamente o SSL antes de enviar o tráfego para o app de backend.</br></br>
Além disso, se seu app de backend puder manipular o TLS e você desejar incluir segurança adicional, será possível incluir a autenticação unilateral ou mútua fornecendo um certificado que está contido em um segredo.</br></br>
Use a anotação `ssl-services` para a finalização de SSL entre o ALB do Ingress e o aplicativo backend. Use a [anotação `mutual-auth`](#mutual-auth) para a finalização de SSL entre o cliente e o ALB do Ingress. </dd>

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
  - hosts:
    - mydomain secretName: mysecret rules:
  - host: mydomain
    http:
      paths:
      - path: /service1_path backend: serviceName: myservice1 servicePort: 8443
      - path: /service2_path backend: serviceName: myservice2 servicePort: 8444 </code></pre>

<table>
<caption>Entendendo os componentes de anotação</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço que requer HTTPS. O tráfego é criptografado do ALB para o serviço desse app.</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Se seu app de backend puder manipular o TLS e você desejar incluir segurança adicional, substitua <code>&lt;<em>service-ssl-secret</em>&gt;</code> pelo segredo de autenticação unilateral ou mútua para o serviço.<ul><li>Se você fornecer um segredo de autenticação unilateral, o valor deverá conter o <code>trusted.crt</code> do servidor de envio de dados. Para criar um segredo unidirecional, veja as etapas no término desta seção.</li><li>Se você fornecer um segredo de autenticação mútua, o valor deverá conter o <code>ca.crt</code> e o <code>ca.key</code> necessários que seu app está esperando do cliente. Para criar um segredo de autenticação mútua, consulte as etapas no final desta seção.</li></ul><strong>Aviso</strong>: se você não fornecer um segredo, as conexões não seguras serão permitidas. Você pode escolher omitir um segredo se desejar testar a conexão e não tiver certificados prontos ou se seus certificados estiverem expirados e você desejar permitir conexões não seguras.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

** Para criar um segredo de autenticação unidirecional: **

1. Obtenha a chave e o certificado de autoridade de certificação (CA) de seu servidor de envio de dados.
2. [Converta o certificado na base 64 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.base64encode.org/).
3. Crie um arquivo do YAML secreto usando o cert.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       trusted.crt: <ca_certificate>
     ```
     {: codeblock}
     **Nota**: se você desejar também cumprir a autenticação mútua para o tráfego de envio de dados, será possível fornecer um `client.crt` e `client.key`, além do `trusted.crt` na seção de dados.
4. Crie o certificado como um segredo do Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

</br>
**Para criar um segredo de autenticação mútua:**

1. Gere uma chave e um certificado de uma das maneiras a seguir:
    * Gere um certificado de autoridade de certificação (CA) e a chave por meio do provedor de certificado. Se você tiver seu próprio domínio, compre um certificado TLS oficial para seu domínio.
      **Importante**: certifique-se de que o [CN ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://support.dnsimple.com/articles/what-is-common-name/) seja diferente para cada certificado.
    * Para propósitos de teste, é possível criar um certificado auto-assinado usando o OpenSSL. Para obter mais informações, consulte esse [tutorial de certificado SSL autoassinado ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.akadia.com/services/ssh_test_certificate.html).
        1. Crie um `ca.key`.
            ```
            openssl genrsa -out ca.key 1024
            ```
            {: pre}
        2. Use a chave para criar um `ca.crt`.
            ```
            openssl req -new -x509 -key ca.key -out ca.crt
            ```
            {: pre}
        3. Use o `ca.crt` para criar um certificado autoassinado.
            ```
            openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
            ```
            {: pre}
2. [Converta o certificado na base 64 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.base64encode.org/).
3. Crie um arquivo do YAML secreto usando o cert.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       ca.crt: <ca_certificate>
     ```
     {: codeblock}
4. Crie o certificado como um segredo do Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

<br />


## Anotações do Istio
{: #istio-annotations}

### Serviços do Istio (istio-services)
{: #istio-services}

Roteie o tráfego para serviços gerenciados pelo Istio.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
<strong>Nota</strong>: essa anotação funciona somente com o Istio 0.7 e anterior.
<br>Se você tiver os serviços gerenciados pelo Istio, será possível usar um ALB de cluster para rotear solicitações HTTP/HTTPS para o controlador do Ingress do Istio. O controlador do Ingress do Istio roteia então as solicitações para os serviços de app. Para rotear o tráfego, deve-se fazer mudanças nos recursos do Ingress para o ALB do cluster e o controlador do Ingress do Istio.
<br><br>No recurso do Ingress para o ALB do cluster, deve-se:
  <ul>
    <li>especificar a anotação `istio-services`</li>
    <li>definir o caminho de serviço como o caminho real no qual o app atende</li>
    <li>definir a porta de serviço como a porta do controlador do Ingress do Istio</li>
  </ul>
<br>No recurso do Ingress para o controlador do Ingress do Istio, deve-se:
  <ul>
    <li>definir o caminho de serviço como o caminho real no qual o app atende</li>
    <li>definir a porta de serviço como a porta de HTTP/HTTPS do serviço de app que é exposto pelo controlador do Ingress do Istio</li>
</ul>
</dd>

<dt>YAML do recurso do Ingress de amostra para o ALB do cluster</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/istio-services: "enable=true serviceName=&lt;myservice1&gt; istioServiceNamespace=&lt;istio-namespace&gt; istioServiceName=&lt;istio-ingress-service&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: &lt;/myapp1&gt;
          backend:
            serviceName: &lt;myservice1&gt;
            servicePort: &lt;istio_ingress_port&gt;
      - path: &lt;/myapp2&gt;
          backend:
            serviceName: &lt;myservice2&gt;
            servicePort: &lt;istio_ingress_port&gt;</code></pre>

<table>
<caption>Entendendo os componentes de arquivo YAML</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
</thead>
<tbody>
<tr>
<td><code>enable</code></td>
  <td>Para ativar o roteamento de tráfego para os serviços gerenciados pelo Istio, configure como <code>True</code>.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code><em>&lt;myservice1&gt;</em></code> pelo nome do serviço do Kubernetes que você criou para o app gerenciado pelo Istio. Separe múltiplos serviços com um ponto e vírgula (;). Este campo é opcional. Se você não especificar um nome de serviço, todos os serviços gerenciados pelo Istio serão ativadas para roteamento de tráfego.</td>
</tr>
<tr>
<td><code>istioServiceNamespace</code></td>
<td>Substitua <code><em>&lt;istio-namespace&gt;</em></code> pelo namespace do Kubernetes no qual o Istio está instalado. Este campo é opcional. Se você não especificar um namespace, o <code>istio-system</code> será usado.</td>
</tr>
<tr>
<td><code>istioServiceName</code></td>
<td>Substitua <code><em>&lt;istio-ingress-service&gt;</em></code> pelo nome do serviço Ingress do Istio. Este campo é opcional. Se você não especificar o nome do serviço Ingress do Istio, o nome de serviço <code>istio-ingress</code> será usado.</td>
</tr>
<tr>
<td><code>path</code></td>
  <td>Para cada serviço gerenciado pelo Istio para o qual você deseja rotear o tráfego, substitua <code><em>&lt;/myapp1&gt;</em></code> pelo caminho de backend no qual o serviço gerenciado pelo Istio atende. O caminho deve corresponder ao caminho que você definiu no recurso do Ingress do Istio.</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>Para cada serviço gerenciado pelo Istio para o qual você deseja rotear o tráfego, substitua <code><em>&lt;istio_ingress_port&gt;</em></code> pela porta do controlador do Ingress do Istio.</td>
</tr>
</tbody></table>
</dd>

<dt>Uso</dt></dl>

1. Implemente seu app. Os recursos de exemplo fornecidos nestas etapas usam o aplicativo de amostra Istio chamado [BookInfo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://archive.istio.io/v0.7/docs/guides/bookinfo.html), que pode ser localizado no repositório `istio-0.7.1/samples/bookinfo/kube`.
   ```
   kubectl aplicar -f bookinfo.yaml -n istio-system
   ```
   {: pre}

2. Configure as regras de roteamento do Istio para o app. Por exemplo, no aplicativo de amostra Istio chamado BookInfo, as [regras de roteamento para cada microsserviço ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://archive.istio.io/v0.7/docs/tasks/traffic-management/request-routing.html) são definidas no arquivo `route-rule-all-v1.yaml`.

3. Exponha o app ao controlador Istio Ingress criando um recurso Istio Ingress. O recurso permite que os recursos do Istio, como regras de monitoramento e de rota, sejam aplicados ao tráfego que entra no cluster.
    Por exemplo, o recurso a seguir para o app BookInfo é predefinido no arquivo `bookinfo.yaml`:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: istio-ingress-resource
      annotations:
        kubernetes.io/ingress.class: "istio"
    spec:
      rules:
      - http:
          paths:
          - path: /productpage backend: serviceName: productpage servicePort: 9080
          - path: /login backend: serviceName: productpage servicePort: 9080
          - path: /logout backend: serviceName: productpage servicePort: 9080
          - path: /api/v1/products.* backend: serviceName: productpage servicePort: 9080
    ```
    {: codeblock}

4. Crie o recurso do Istio Ingress.
    ```
    kubectl create -f istio-ingress-resource.yaml -n istio-system
    ```
    {: pre}
    Seu app está conectado ao controlador Istio Ingress.

5. Obtenha o **subdomínio do Ingress** e o **segredo do Ingress** da IBM para o seu cluster. O subdomínio e o segredo são pré-registrados para o seu cluster e são usados como uma URL pública exclusiva para o seu app.
    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

6. Conecte o controlador Istio Ingress ao ALB de Ingresso da IBM para seu cluster criando um recurso IBM Ingress.
    Exemplo para o app BookInfo:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: ibm-ingress-resource
      annotations:
        ingress.bluemix.net/istio-services: "enabled=true serviceName=productpage istioServiceName=istio-ingress-resource"
    spec:
      tls:
      - hosts:
        - mycluster-459249.us-south.containers.mybluemix.net
        secretName: mycluster-459249
      rules:
      - host: mycluster-459249.us-south.containers.mybluemix.net
        http:
          paths:
          - path: /productpage backend: serviceName: productpage servicePort: 9080
          - path: /login backend: serviceName: productpage servicePort: 9080
          - path: /logout backend: serviceName: productpage servicePort: 9080
          - path: /api/v1/products.* backend: serviceName: productpage servicePort: 9080
    ```
    {: codeblock}

7. Crie o recurso do IBM ALB Ingress.
    ```
    kubectl aplicar -f ibm-ingress-resource.yaml -n istio-system
    ```
    {: pre}

8. Em um navegador, vá para  ` https://<hostname>/frontend` para visualizar a página da web do app.

<br />


## Anotações de buffer de proxy
{: #proxy-buffer}


### Buffer de dados de resposta do cliente (proxy-buffering)
{: #proxy-buffering}

Use a anotação de buffer para desativar o armazenamento de dados de resposta no ALB enquanto os dados são enviados para o cliente.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O ALB do Ingresso age como um proxy entre seu app backend e o navegador da web do cliente. Quando uma resposta é enviada do app backend para o cliente, os dados de resposta são armazenados em buffer no ALB por padrão. O ALB usa o proxy em uma resposta do cliente e começa a enviar a resposta para o cliente no ritmo do cliente. Depois que todos os dados do app backend são recebidos pelo ALB, a conexão com o app backend é encerrada. A conexão do ALB para o cliente permanece aberta até que o cliente receba todos os dados.

</br></br>
Se o armazenamento em buffer de dados de resposta no ALB está desativado, os dados são enviados imediatamente do ALB para o cliente. O cliente deve ser capaz de manipular os dados recebidos no ritmo do ALB. Se o cliente for muito lento, poderá haver perda de dados.
</br></br>
O armazenamento em buffer de dados de resposta no ALB é ativado por padrão.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   Ingress.bluemix.net/proxy-buffering: "ativado=&lt;false&gt; serviceName=&lt;myservice1&gt;"
spec:
 tls:
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
 </thead>
 <tbody>
 <tr>
 <td><code>ativado</code></td>
   <td>Para desativar o armazenamento em buffer de dados de resposta no ALB, configure para <code>false</code>.</td>
 </tr>
 <tr>
 <td><code>serviceName</code></td>
 <td>Substitua <code><em>&lt;myservice1&gt;</em></code> pelo nome do serviço do Kubernetes que você criou para o seu app. Separe múltiplos serviços com um ponto e vírgula (;). Este campo é opcional. Se você não especificar um nome do serviço, todos os serviços usarão essa anotação.</td>
 </tr>
 </tbody></table>
 </dd>
 </dl>

<br />



### Buffers de proxy (proxy-buffers)
{: #proxy-buffers}

Configure o número e o tamanho dos buffers de proxy para o ALB.
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
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome de um serviço para aplicar proxy-buffers.</td>
 </tr>
 <tr>
 <td><code>number</code></td>
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
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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
   Ingress.bluemix.net/proxy-busy-buffers-size: "serviceName=&lt;myservice&gt; tamanho=&lt;size&gt;"
spec:
 tls:
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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

### Incluir a porta do servidor no cabeçalho do host (add-host-port)
{: #add-host-port}

<dl>
<dt>Descrição</dt>
<dd>Inclua o `:server_port ` no cabeçalho do host de uma solicitação do cliente antes de encaminhar a solicitação para seu app de backend.

<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingresso s.bluemix.net/add-host-port: "enabled= &lt;true&gt;  serviceName= &lt;myservice&gt;"
spec:
 tls:
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
 </thead>
 <tbody>
 <tr>
 <td><code>ativado</code></td>
   <td>Para ativar a configuração de server_port para o host, configure como <code>true</code>.</td>
 </tr>
 <tr>
 <td><code>serviceName</code></td>
 <td>Substitua <code><em>&lt;myservice&gt;</em></code> pelo nome do serviço Kubernetes que você criou para o seu app. Separe múltiplos serviços com um ponto e vírgula (;). Este campo é opcional. Se você não especificar um nome do serviço, todos os serviços usarão essa anotação.</td>
 </tr>
 </tbody></table>
 </dd>
 </dl>

<br />


### Cabeçalho de solicitação ou resposta do cliente adicional (proxy-add-headers, response-add-headers)
{: #proxy-add-headers}

Inclua informações extras do cabeçalho em uma solicitação do cliente antes de enviar a solicitação para o app backend ou para uma resposta do cliente antes de enviar a resposta ao cliente.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O ALB de Ingresso age como um proxy entre o aplicativo do cliente e o seu app backend. As solicitações do cliente que são enviadas para o ALB são processadas (por proxy) e colocadas em uma nova solicitação que é então enviada para seu app backend. Da mesma forma, as respostas do app backend que são enviadas para o ALB são processadas (por proxy) e colocadas em uma nova resposta que é então enviada para o cliente. O uso de proxy em uma solicitação ou resposta remove informações de cabeçalho HTTP, como o nome do usuário, que foram enviadas inicialmente do cliente ou app backend.

<br><br>
Se o seu app backend requer informações do cabeçalho de HTTP, é possível usar a anotação <code>proxy-add-headers</code> para incluir informações do cabeçalho na solicitação do cliente antes que a solicitação seja encaminhada pelo ALB para o app backend.

<br>
<ul><li>Por exemplo, talvez você precise incluir as informações do cabeçalho X-Forward a seguir na solicitação antes que ela seja encaminhada para o seu app:

<pre class="screen">
<code>proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;</code></pre>

</li>

<li>Para incluir as informações do cabeçalho X-Forward na solicitação enviada ao seu app, use a anotação `proxy-add-headers` da maneira a seguir:

<pre class="screen">
<code>ingress.bluemix.net/proxy-add-headers: |
  serviceName=&lt;myservice1&gt; {
  Host $host;
  X-Real-IP $remote_addr;
  X-Forwarded-Proto $scheme;
  X-Forwarded-For $proxy_add_x_forwarded_for;
  }</code></pre>

</li></ul><br>

Se o app da web do cliente requer informações do cabeçalho de HTTP, é possível usar a anotação <code>response-add-headers</code> para incluir informações do cabeçalho na resposta antes que a resposta seja encaminhada pelo ALB para o app da web do cliente.</dd>

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
      &lt;header1&gt;: &lt;value1&gt;;
      &lt;header2&gt;: &lt;value2&gt;;
      }
      serviceName=&lt;myservice2&gt; {
      &lt;header3&gt;: &lt;value3&gt;;
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /service1_path backend: serviceName: &lt;myservice1&gt; servicePort: 8080
      - path: /service2_path backend: serviceName: &lt;myservice2&gt; servicePort: 80</code></pre>

 <table>
 <caption>Entendendo os componentes de anotação</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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
<dd>O ALB do Ingresso age como um proxy entre seu app backend e o navegador da web do cliente. As respostas do cliente do app backend que são enviadas para o ALB são processadas (por proxy) e colocadas em uma nova resposta que é então enviada do ALB para o navegador da web do cliente. Embora a transmissão de uma resposta por proxy remova as informações do cabeçalho de HTTP inicialmente enviadas do app backend, esse processo pode não remover todos os cabeçalhos específicos do app backend. Remova as informações do cabeçalho de uma resposta do cliente antes que a resposta seja encaminhada do ALB para o navegador da web do cliente.</dd>
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
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /service1_path backend: serviceName: &lt;myservice1&gt; servicePort: 8080
      - path: /service2_path backend: serviceName: &lt;myservice2&gt; servicePort: 80</code></pre>

<table>
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
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


### Tamanho do corpo da solicitação do cliente (client-max-body-size)
{: #client-max-body-size}

Configure o tamanho máximo do corpo que o cliente pode enviar como parte de uma solicitação.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Para manter o desempenho esperado, o tamanho máximo do corpo de solicitação do cliente é configurado como 1 megabyte. Quando uma solicitação de cliente com um tamanho do corpo sobre o limite é enviada para o ALB de Ingresso e o cliente não permite que os dados sejam divididos, o ALB retorna uma resposta de HTTP 413 (Entidade de solicitação muito grande) ao cliente. Uma conexão entre o cliente e o ALB não é possível até que o tamanho do corpo de solicitação seja reduzido. Quando o cliente permite que os dados sejam divididos em múltiplos chunks, os dados são divididos em pacotes de 1 megabyte e enviados para o ALB.

</br></br>
Talvez você queira aumentar o tamanho máximo do corpo porque espera solicitações do cliente com um tamanho de corpo maior que 1 megabyte. Por exemplo, você deseja que seu cliente possa fazer upload de arquivos grandes. Aumentar o tamanho máximo do corpo de solicitação pode afetar o desempenho de seu ALB porque a conexão com o cliente deve permanecer aberta até que a solicitação seja recebida.
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
   ingress.bluemix.net/client-max-body-size: size=&lt;size&gt;
spec:
 tls:
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;size&gt;</code></td>
 <td>O tamanho máximo do corpo de resposta do cliente. Por exemplo, para configurar o tamanho máximo para 200 megabytes, defina <code>200m</code>.  <strong>Nota:</strong> será possível configurar o tamanho como 0 para desativar a verificação do tamanho do corpo de solicitação do cliente.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


### Buffers de cabeçalhos do cliente grandes (large-client-header-buffers)
{: #large-client-header-buffers}

Configure o número e o tamanho máximo dos buffers que leem cabeçalhos de solicitação de cliente grandes.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Os buffers que leem os cabeçalhos da solicitação do cliente grandes são alocados somente por demanda: se uma conexão executa a transição para o estado keep-alive após o processamento de término da solicitação, esses buffers são liberados. Por padrão, o tamanho do buffer é igual a <code>8K</code> bytes. Se uma linha de solicitação excede o tamanho máximo configurado de um buffer, o erro <code>414 Request-URI Too Large</code> é retornado para o cliente. Além disso, se um campo de cabeçalho da solicitação excede o tamanho máximo configurado de um buffer, o erro <code>400 Bad Request</code> é retornado para o cliente. É possível ajustar o número máximo e o tamanho dos buffers que são usados para ler cabeçalhos da solicitação do cliente grandes.

<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingress.bluemix.net/large-client-header-buffers: "number=&lt;number&gt; size=&lt;size&gt;"
spec:
 tls:
 - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;number&gt;</code></td>
 <td>O número máximo de buffers que devem ser alocados para ler o cabeçalho da solicitação do cliente grande. Por exemplo, para configurá-lo como 4, defina <code>4</code>.</td>
 </tr>
 <tr>
 <td><code>&lt;size&gt;</code></td>
 <td>O tamanho máximo de buffers que leem o cabeçalho da solicitação do cliente grande. Por exemplo, para configurá-lo como 16 kilobytes, defina <code>16k</code>.
   <strong>Nota:</strong> o tamanho deve terminar com um <code>k</code> para kilobyte ou <code>m</code> para megabyte.</td>
 </tr>
</tbody></table>
</dd>
</dl>

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
  - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>chave</code></td>
<td>Para configurar um limite global para as solicitações recebidas com base na zona ou serviço, use `key=zone`. Para configurar um limite global para solicitações recebidas com base no cabeçalho, use `X-USER-ID key=$http_x_user_id`.</td>
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
  - hosts:
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
<caption>Entendendo os componentes de anotação</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Entendendo os componentes de anotação</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <code>&lt;<em>myservice</em>&gt;</code> pelo nome do serviço para o qual você deseja limitar a taxa de processamento.</li>
</tr>
<tr>
<td><code>chave</code></td>
<td>Para configurar um limite global para as solicitações recebidas com base na zona ou serviço, use `key=zone`. Para configurar um limite global para solicitações recebidas com base no cabeçalho, use `X-USER-ID key=$http_x_user_id`.</td>
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



