---

copyright: years: 2014, 2017 lastupdated: "14/11/2017

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

Para incluir recursos em seu controlador de Ingresso, é possível especificar anotações como metadados em um recurso de Ingresso.
{: shortdesc}

Para obter informações gerais sobre os serviços de Ingresso e como começar a usá-los, veja [Configurando o acesso público a um app usando o controlador de Ingresso](cs_apps.html#cs_apps_public_ingress).


|Anotação suportada|Descrição|
|--------------------|-----------|
|[Solicitação do cliente ou cabeçalho de resposta adicional](#proxy-add-headers)|Inclua informações do cabeçalho em uma solicitação do cliente antes de encaminhar a solicitação para seu app backend ou para uma resposta do cliente antes de enviar a resposta para o cliente.|
|[Armazenamento em buffer de dados de resposta do cliente](#proxy-buffering)|Desativar o armazenamento em buffer de uma resposta do cliente no controlador de Ingresso ao enviar a resposta para o cliente.|
|[Remoção do cabeçalho de resposta do cliente](#response-remove-headers)|Remover informações do cabeçalho de uma resposta do cliente antes de encaminhar a resposta para o cliente.|
|[Tempos limite de conexão e tempos limite de leitura customizados](#proxy-connect-timeout)|Ajustar o tempo que o controlador de Ingresso aguarda para conectar e ler do app backend antes de o app backend ser considerado não disponível.|
|[Portas HTTP e HTTPS customizadas](#custom-port)|Mude as portas padrão para o tráfego de rede HTTP e HTTPS.|
|[Tamanho máximo do corpo de solicitação do cliente customizado](#client-max-body-size)|Ajustar o tamanho do corpo de solicitação do cliente que tem permissão para ser enviado para o controlador de Ingresso.|
|[Serviços externos](#proxy-external-service)|Inclui definição de caminhos para serviços externos, como um serviço hospedado no {{site.data.keyword.Bluemix_notm}}.|
|[Limites de taxa global](#global-rate-limit)|Para todos os serviços, limite a taxa de processamento de solicitação e conexões por uma chave definida.|
|[HTTP redireciona para HTTPS](#redirect-to-https)|Redirecione solicitações de HTTP não seguras em seu domínio para HTTPS.|
|[Solicitações de keep-alive](#keepalive-requests)|Configure o número máximo de solicitações que podem ser servidas por meio de uma conexão keepalive.|
|[Tempo limite de keep-alive](#keepalive-timeout)|Configure o tempo que uma conexão keep-alive permanece aberta no servidor.|
|[Autenticação mútua](#mutual-auth)|Configure a autenticação mútua para o controlador de Ingresso.|
|[Buffers de proxy](#proxy-buffers)|Configura o número e o tamanho dos buffers que são usados para ler uma resposta para uma conexão única do servidor em proxy.|
|[Tamanho de buffers ocupados de proxy](#proxy-busy-buffers-size)|Limita o tamanho total de buffers que podem estar ocupados enviando uma resposta ao cliente enquanto a resposta ainda não está totalmente lida.|
|[Tamanho do buffer de proxy](#proxy-buffer-size)|Configura o tamanho do buffer que é usado para ler a primeira parte da resposta que é recebida do servidor em proxy.|
|[Gravar novamente caminhos](#rewrite-path)|Rotear tráfego de rede recebido para um caminho diferente no qual seu app backend atenda.|
|[Afinidade de sessão com cookies](#sticky-cookie-services)|Sempre rotear o tráfego de rede recebido para o mesmo servidor de envio de dados usando um cookie permanente.|
|[Limites de taxa de serviço](#service-rate-limit)|Para serviços específicos, limite a taxa de processamento de solicitação e conexões por uma chave definida.|
|[Suporte a serviços SSL](#ssl-services)|Permita o suporte a serviços SSL para balanceamento de carga.|
|[Portas TCP](#tcp-ports)|Acesse um app através de uma porta TCP não padrão.|
|[Envio de dados keep-alive](#upstream-keepalive)|Configure o número máximo de conexões keep-alive inativas para um servidor de envio de dados.|






## Cabeçalho de solicitação ou resposta do cliente adicional (cabeçalhos adicionais de proxy)
{: #proxy-add-headers}

Inclua informações extras do cabeçalho em uma solicitação do cliente antes de enviar a solicitação para o app backend ou para uma resposta do cliente antes de enviar a resposta ao cliente.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O controlador de Ingresso age como um proxy entre o app cliente e o app backend. As solicitações do cliente que são enviadas para o controlador de Ingresso são processadas (em proxy) e colocadas em uma nova solicitação que é então enviada do controlador de Ingresso para o app backend. Transmitir uma solicitação por proxy remove as informações do cabeçalho de HTTP, como o nome do usuário, que foi inicialmente enviado do cliente. Se o seu app backend requerer essas informações, será possível usar a anotação <strong>ingress.bluemix.net/proxy-add-headers</strong> para incluir informações do cabeçalho na solicitação do cliente antes de a solicitação ser encaminhada do controlador de Ingresso para seu app backend.

</br></br>
Quando um app backend envia uma resposta para o cliente, a resposta é transmitida por proxy pelo controlador de Ingresso e os cabeçalhos de HTTP são removidos da resposta. O app da web do cliente pode requerer essas informações de cabeçalho para processar com êxito a resposta. É possível usar a anotação <strong>ingress.bluemix.net/response-add-headers</strong> para incluir informações do cabeçalho na resposta do cliente antes de a resposta ser encaminhada do controlador de Ingresso para o app da web do cliente.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
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
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;service_name&gt;</em></code>: o nome do serviço do Kubernetes criado para o seu app.</li>
  <li><code><em>&lt;header&gt;</em></code>: a chave das informações do cabeçalho a serem incluídas na solicitação ou na resposta do cliente.</li>
  <li><code><em>&lt;value&gt;</em></code>: o valor das informações do cabeçalho a serem incluídas na solicitação ou na resposta do cliente.</li>
  </ul></td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />


 ## Buffer de dados de resposta do cliente (proxy-buffering)
 {: #proxy-buffering}

 Use a anotação de buffer para desativar o armazenamento de dados de resposta no controlador de Ingresso enquanto os dados são enviados para o cliente.
 {:shortdesc}

 <dl>
 <dt>Descrição</dt>
 <dd>O controlador de Ingresso age como um proxy entre seu app backend e o navegador da web do cliente. Quando uma resposta é enviada do app backend para o cliente, os dados de resposta são armazenados em buffer no controlador de Ingresso por padrão. O controlador de Ingresso transmite por proxy a resposta do cliente e começa a enviar a resposta para o cliente no ritmo do cliente. Depois que todos os dados do app backend são recebidos pelo controlador de Ingresso, a conexão com o app backend é encerrada. A conexão do controlador de Ingresso para o cliente permanece aberta até que o cliente recebe todos os dados.

 </br></br>
 Se o armazenamento em buffer de dados de resposta no controlador de Ingresso estiver desativado, os dados serão enviados imediatamente do controlador de Ingresso para o cliente. O cliente deverá estar apto a manipular os dados recebidos no ritmo do controlador de Ingresso. Se o cliente for muito lento, poderá haver perda de dados.
 </br></br>
 O armazenamento em buffer de dados de resposta no controlador de Ingresso é ativado por padrão.</dd>
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


 ## Remoção do cabeçalho de resposta do cliente (response-remove-headers)
 {: #response-remove-headers}

Remova as informações do cabeçalho que são incluídas na resposta do cliente do app final de backend antes de a resposta ser enviada para o cliente.
 {:shortdesc}

 <dl>
 <dt>Descrição</dt>
 <dd>O controlador de Ingresso age como um proxy entre seu app backend e o navegador da web do cliente. As respostas do cliente do app backend enviadas para o controlador de Ingresso são processadas (por proxy) e colocadas em uma nova resposta que é então enviada do controlador de Ingresso para o navegador da web do cliente. Embora a transmissão de uma resposta por proxy remova as informações do cabeçalho de HTTP inicialmente enviadas do app backend, esse processo pode não remover todos os cabeçalhos específicos do app backend. Remova as informações do cabeçalho de uma resposta do cliente antes de a resposta ser encaminhada do controlador de Ingresso para o navegador da web do cliente.</dd>
 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadados:
   name: myingress
   annotations:
     ingress.bluemix.net/response-remove-headers: |
       serviceName=&lt;service_name1&gt; {
       "&lt;header1&gt;";
       "&lt;header2&gt;";
       }
       serviceName=&lt;service_name2&gt; {
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
       - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
       - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>Substitua os seguintes valores:<ul>
   <li><code><em>&lt;service_name&gt;</em></code>: o nome do serviço do Kubernetes criado para o seu app.</li>
   <li><code><em>&lt;header&gt;</em></code>: a chave do cabeçalho a ser removida da resposta do cliente.</li>
   </ul></td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


## Tempos limites de conexão e tempos limites de leitura customizados (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Configure um tempo limite de conexão e um tempo limite de leitura customizados para o controlador de Ingresso. Ajuste o tempo de espera do controlador de Ingresso enquanto se conecta e lê do app backend antes de o app backend ser considerado indisponível.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Quando uma solicitação do cliente é enviada para o controlador de Ingresso, uma conexão com o app backend é aberta pelo controlador de Ingresso. Por padrão, o controlador de Ingresso aguarda 60 segundos para receber uma resposta do app backend. Se o app backend não responder dentro de 60 segundos, a solicitação de conexão será interrompida e o app backend será considerado indisponível.

</br></br>
Depois que o controlador de Ingresso é conectado ao app backend, os dados de resposta são lidos do app backend pelo controlador de Ingresso. Durante essa operação de leitura, o controlador de Ingresso aguarda um máximo de 60 segundos entre duas operações de leitura para receber dados do app backend. Se o app backend não enviar dados dentro de 60 segundos, a conexão com o app backend será encerrada e o app será considerado não disponível.
</br></br>
Um tempo limite de conexão e de leitura de 60 segundos é o tempo limite padrão em um proxy e geralmente não deve ser mudado.
</br></br>
Se a disponibilidade de seu app não for estável ou seu app estiver lento para responder em razão de altas cargas de trabalho, talvez você queira aumentar o tempo limite de conexão ou de leitura. Lembre-se de que aumentar o tempo limite afetará o desempenho do controlador de Ingresso, pois a conexão com o app backend deverá permanecer aberta até que o tempo limite seja atingido.
</br></br>
Por outro lado, será possível diminuir o tempo limite para ganhar desempenho no controlador de Ingresso. Assegure-se de que seu app backend seja capaz de manipular solicitações dentro do tempo limite especificado, mesmo durante cargas de trabalho mais altas.</dd>
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
 <td><code>annotations</code></td>
 <td>Substitua os seguintes valores:<ul><li><code><em>&lt;connect_timeout&gt;</em></code>: insira o número de segundos que se deve esperar para se conectar ao app backend, por exemplo, <strong>65s</strong>.

 </br></br>
 <strong>Nota:</strong> um tempo limite de conexão não pode exceder 75 segundos.</li><li><code><em>&lt;read_timeout&gt;</em></code>: insira o número de segundos que se deve esperar para ler o app backend, por exemplo, <strong>65 s</strong>.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


## Portas HTTP e HTTPS customizadas (custom-port)
{: #custom-port}

Mude as portas padrão para o tráfego de rede HTTP (porta 80) e HTTPS (porta 443).
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Por padrão, o controlador do Ingresso é configurado para atender ao tráfego de rede HTTP recebido na porta 80 e ao tráfego de rede HTTPS recebido na porta 443. É possível mudar as portas padrão para incluir segurança em seu domínio do controlador de Ingresso ou ativar somente uma porta HTTPS.
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
 <td><code>annotations</code></td>
 <td>Substitua os seguintes valores:<ul>
 <li><code><em>&lt;protocol&gt;</em></code>: insira <strong>http</strong> ou <strong>https</strong> para mudar a porta padrão para o tráfego de rede recebido HTTP ou HTTPS.</li>
 <li><code><em>&lt;port&gt;</em></code>: insira o número da porta que você deseja usar para o tráfego de rede recebido HTTP ou HTTPS.</li>
 </ul>
 <p><strong>Nota:</strong> quando uma porta customizada é especificada para HTTP ou HTTPS, as portas padrão não são mais válidas para HTTP e HTTPS. Por exemplo, para mudar a porta padrão para HTTPS para 8443, mas usar a porta padrão para HTTP, deve-se configurar portas customizadas para ambos: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p>
 </td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Uso</dt>
 <dd><ol><li>Revise as portas abertas para seu controlador do Ingresso. **Nota: o endereço IP precisa ser endereço IP de doc genérico. Também precisa vincular à CLI kubectl de destino? Talvez não.**
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


## Tamanho máximo do corpo da solicitação do cliente customizado (client-max-body-size)
{: #client-max-body-size}

Ajuste o tamanho máximo do corpo que o cliente pode enviar como parte de uma solicitação.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Para manter o desempenho esperado, o tamanho máximo do corpo de solicitação do cliente é configurado como 1 megabyte. Quando uma solicitação de cliente com um tamanho de corpo acima do limite é enviada para o controlador de Ingresso e o cliente não permite que os dados sejam divididos, o controlador de Ingresso retorna uma resposta de HTTP 413 (Entidade de solicitação muito grande) para o cliente. Uma conexão entre o cliente e o controlador de Ingresso não será possível até que o tamanho do corpo de solicitação seja reduzido. Quando o cliente permite a divisão dos dados em múltiplos chunks, os dados são divididos em pacotes de 1 megabyte e enviados para o controlador de Ingresso.

</br></br>
Talvez você queira aumentar o tamanho máximo do corpo porque espera solicitações do cliente com um tamanho de corpo maior que 1 megabyte. Por exemplo, você deseja que seu cliente possa fazer upload de arquivos grandes. Aumentar o tamanho máximo do corpo de solicitação poderá afetar o desempenho de seu controlador de Ingresso, pois a conexão com o cliente deverá permanecer aberta até que a solicitação seja recebida.
</br></br>
<strong>Nota:</strong> alguns navegadores da web do cliente não podem exibir a mensagem de resposta de HTTP 413 corretamente.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
 name: myingress
 annotations:
   ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
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
 <td><code>annotations</code></td>
 <td>Substitua o valor a seguir:<ul>
 <li><code><em>&lt;size&gt;</em></code>: insira o tamanho máximo do corpo de resposta do cliente. Por exemplo, para configurá-lo como 200 megabytes, defina <strong>200 m</strong>.

 </br></br>
 <strong>Nota:</strong> será possível configurar o tamanho como 0 para desativar a verificação do tamanho do corpo de solicitação do cliente.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


<retornar para cá>

## Serviços externos (proxy-external-service)
{: #proxy-external-service}
Inclua definições de caminho para serviços externos, como serviços hospedados no {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Inclua definições de caminho para serviços externos. Essa anotação é para casos especiais porque ela não opera em um serviço de backend e funciona em um serviço externo. Anotações diferentes de client-max-body-size, proxy-read-timeout, proxy-connect-timeout, proxy-buffering não são suportadas com uma rota de serviço externo.
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
    ingress.bluemix.net/proxy-external-service: "path=&lt;path&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
spec:
  tls:
  - System z:
    - &lt;mydomain&gt;
    secretName: mysecret
  rules:
  - host: &lt;mydomain&gt;
    http:
      paths:
      - path: &lt;path&gt;
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
 <td><code>annotations</code></td>
 <td>Substitua o valor a seguir:
 <ul>
 <li><code><em>&lt;external_service&gt;</em></code>: insira o serviço externo a ser chamado. Por exemplo, https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net.</li>
 </ul>
 </tr>
 </tbody></table>

 </dd></dl>


<br />


## Limites de taxa global (global-rate-limit)
{: #global-rate-limit}

Para todos os serviços, limite a taxa de processamento de solicitação e o número de conexões por uma chave definida que estão vindo de um único endereço IP para todos os hosts em um mapeamento de Ingresso.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Para configurar o limite, as zonas são definidas pelo `ngx_http_limit_conn_module` e `ngx_http_limit_req_module`. Essas zonas são aplicadas aos blocos de servidor que correspondem a cada host em um mapeamento de Ingresso.
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
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;key&gt;</em></code>: para configurar um limite global para solicitações recebidas com base no local ou serviço, use `key=location`. Para configurar um limite global para solicitações recebidas com base no cabeçalho, use `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code>: a taxa.</li>
  <li><code><em>&lt;conn&gt;</em></code>: o número de conexões.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

  <br />


 ## Redirecionamentos de HTTP para HTTPS (redirect-to-https)
 {: #redirect-to-https}

 Converta as solicitações não seguras do cliente HTTP para HTTPS.
 {:shortdesc}

 <dl>
 <dt>Descrição</dt>
 <dd>Configure seu controlador do Ingresso para proteger seu domínio com o certificado TLS fornecido pela IBM ou seu certificado TLS customizado. Alguns usuários podem tentar acessar seus apps usando uma solicitação de HTTP insegura para seu domínio do controlador de Ingresso, por exemplo, <code>http://www.myingress.com</code>, em vez de usar <code>https</code>. É possível usar a anotação de redirecionamento para sempre converter solicitações de HTTP inseguras em HTTPs. Se você não usar essa anotação, as solicitações não seguras de HTTP não serão convertidas em solicitações de HTTPS por padrão e poderão expor informações confidenciais não criptografadas ao público.

 </br></br>
 O redirecionamento de solicitações de HTTP para HTTPs é desativado por padrão.</dd>
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




 <br />

 
 ## Solicitações de keep-alive (keepalive-requests)
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
    ingress.bluemix.net/keepalive-requests: "serviceName=&lt;service_name&gt; requests=&lt;max_requests&gt;"
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
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: substitua <em>&lt;service_name&gt;</em> pelo nome do serviço do Kubernetes que você criou para o seu app. Este parâmetro é opcional. A configuração é aplicada a todos os serviços no host de Ingresso, a menos que um serviço seja especificado. Se o parâmetro for fornecido, as solicitações de keep-alive serão configuradas para o serviço especificado. Se o parâmetro não for fornecido, as solicitações de keep-alive serão configuradas no nível do servidor do <code>nginx.conf</code> para todos os serviços que não tiverem solicitações de keep-alive configuradas.</li>
  <li><code><em>&lt;requests&gt;</em></code>: substitua <em>&lt;max_requests&gt;</em> pelo número máximo de solicitações que podem ser entregues por meio de uma conexão keep-alive.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Tempo limite de keep-alive (keepalive-timeout)
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
     ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;service_name&gt; timeout=&lt;time&gt;s"
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
   <td><code>annotations</code></td>
   <td>Substitua os seguintes valores:<ul>
   <li><code><em>&lt;serviceName&gt;</em></code>: substitua <em>&lt;service_name&gt;</em> pelo nome do serviço do Kubernetes que você criou para o seu app. Este parâmetro é opcional. Se o parâmetro for fornecido, o tempo limite de keep-alive será configurado para o serviço especificado. Se o parâmetro não for fornecido, o tempo limite de keep-alive será configurado no nível do servidor do <code>nginx.conf</code> para todos os serviços que não têm o tempo limite de keep-alive configurado.</li>
   <li><code><em>&lt;timeout&gt;</em></code>: substitua <em>&lt;time&gt;</em> por uma quantia de tempo em segundos. Exemplo:<code><em>timeout=20s</em></code>. Um valor zero desativa as conexões do cliente de keep-alive.</li>
   </ul>
   </td>
   </tr>
   </tbody></table>

   </dd>
   </dl>

 <br />


 ## Autenticação mútua (mutual-auth)
 {: #mutual-auth}

 Configure a autenticação mútua para o controlador de Ingresso.
 {:shortdesc}

 <dl>
 <dt>Descrição</dt>
 <dd>
 Configure a autenticação mútua para o controlador de Ingresso. O cliente autentica o servidor e o servidor também autentica o cliente usando certificados. A autenticação mútua também é conhecida como autenticação baseada em certificado ou autenticação de duas vias.
 </dd>

 <dt>Pré-requisitos</dt>
 <dd>
 <ul>
 <li>[Deve-se ter um segredo válido que contenha a autoridade de certificação (CA) necessária](cs_apps.html#secrets). O <code>client.key</code> e o <code>client.crt</code> também são necessários para autenticar com autenticação mútua.</li>
 <li>Para ativar a autenticação mútua em uma porta diferente de 443, [configure o balanceador de carga para abrir a porta válida](cs_apps.html#opening_ingress_ports).</li>
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
    ingress.bluemix.net/mutual-auth: "port=&lt;port&gt; secretName=&lt;secretName&gt; serviceName=&lt;service1&gt;,&lt;service2&gt;"
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
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: o nome de um ou mais recursos de Ingresso. Este parâmetro é opcional.</li>
  <li><code><em>&lt;secretName&gt;</em></code>: substitua <em>&lt;secret_name&gt;</em> por um nome para o recurso de segredo.</li>
  <li><code><em>&lt;port&gt;</em></code>: insira o número da porta.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Buffers de proxy (proxy-buffers)
 {: #proxy-buffers}
 
 Configure buffers de proxy para o controlador de Ingresso.
 {:shortdesc}

 <dl>
 <dt>Descrição</dt>
 <dd>
 Configure o número e o tamanho dos buffers que são usados para ler uma resposta para uma conexão única do servidor em proxy. A configuração é aplicada a todos os serviços no host de Ingresso, a menos que um serviço seja especificado. Por exemplo, se uma configuração como <code>serviceName=SERVICE=2 size=1k</code> for especificada, 1K será aplicado ao serviço. Se uma configuração como <code>number=2 size=1k</code> for especificada, 1K será aplicado a todos os serviços no host de Ingresso.
 </dd>
 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  nome: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffers: "serviceName=&lt;service_name&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
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
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:
  <ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: substitua <em>&lt;serviceName&gt;</em> por um nome para o serviço para aplicar proxy-buffers. </li>
  <li><code><em>&lt;number_of_buffers&gt;</em></code>: substitua <em>&lt;number_of_buffers&gt;</em> por um número, como <em>2</em>.</li>
  <li><code><em>&lt;size&gt;</em></code>: insira o tamanho de cada buffer em kilobytes (k ou K), como <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>
  </dd>
  </dl>

 <br />


 ## Tamanho de buffers ocupados de proxy (proxy-busy-buffers-size)
 {: #proxy-busy-buffers-size}

 Configure o tamanho de buffers ocupados de proxy para o controlador de Ingresso.
 {:shortdesc}

 <dl>
 <dt>Descrição</dt>
 <dd>
 Quando o buffer de respostas do servidor em proxy está ativado, limite o tamanho total de buffers que pode estar ocupados enviando uma resposta ao cliente enquanto a resposta ainda não está totalmente lida. Enquanto isso, o restante dos buffers poderá ser usado para ler a resposta e, se necessário, armazenar em buffer parte da resposta em um arquivo temporário. A configuração é aplicada a todos os serviços no host de Ingresso, a menos que um serviço seja especificado. Por exemplo, se uma configuração como <code>serviceName=SERVICE size=1k</code> for especificada, 1k será aplicado ao serviço. Se uma configuração como <code>size=1k</code> for especificada, 1k será aplicado a todos os serviços no host de Ingresso.
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
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: substitua <em>&lt;serviceName&gt;</em> por um nome do serviço para aplicar o tamanho de buffers ocupados de proxy.</li>
  <li><code><em>&lt;size&gt;</em></code>: insira o tamanho de cada buffer em kilobytes (k ou K), como <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Tamanho do buffer de proxy (proxy-buffer-size)
 {: #proxy-buffer-size}

 Configure o tamanho do buffer de proxy para o controlador de Ingresso.
 {:shortdesc}

 <dl>
 <dt>Descrição</dt>
 <dd>
 Configure o tamanho do buffer que é usado para ler a primeira parte da resposta que é recebida do servidor proxy. Essa parte da resposta geralmente contém um cabeçalho de resposta pequeno. A configuração é aplicada a todos os serviços no host de Ingresso, a menos que um serviço seja especificado. Por exemplo, se uma configuração como <code>serviceName=SERVICE size=1k</code> for especificada, 1k será aplicado ao serviço. Se uma configuração como <code>size=1k</code> for especificada, 1k será aplicado a todos os serviços no host de Ingresso.
 </dd>


 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  nome: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
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
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: substitua <em>&lt;serviceName&gt;</em> por um nome do serviço para aplicar o tamanho de buffers ocupados de proxy.</li>
  <li><code><em>&lt;size&gt;</em></code>: insira o tamanho de cada buffer em kilobytes (k ou K), como <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />



## Gravar novamente caminhos (rewrite-path)
{: #rewrite-path}

Roteie o tráfego de rede recebido em um caminho de domínio do controlador de Ingresso para um caminho diferente no qual seu aplicativo backend atende.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O seu domínio de controlador do Ingresso roteia o tráfego de rede recebido em <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> para o seu app. O seu app atende em <code>/coffee</code>, em vez de <code>/beans</code>. Para encaminhar o tráfego de rede recebido para o seu app, inclua a anotação de regravação em seu arquivo de configuração do recurso de Ingresso. A anotação de nova gravação assegura que o tráfego de rede recebido em <code>/beans</code> seja encaminhado para o seu app usando o caminho <code>/coffee</code>. Ao incluir múltiplos serviços, use apenas um ponto e vírgula (;) para separá-los.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;target_path2&gt;"
spec:
  tls:
  - System z:
    - mydomain
    secretName: &lt;mytlssecret&gt;
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>Substitua <em>&lt;service_name&gt;</em> pelo nome do serviço do Kubernetes que você criou para o seu app e <em>&lt;target-path&gt;</em> pelo caminho em que seu app atende. O tráfego de rede recebido no domínio do controlador do Ingresso é encaminhado para o serviço do Kubernetes usando este caminho. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Neste caso, defina <code>/</code> como o <em>rewrite-path</em> para o seu app.</td>
</tr>
<tr>
<td><code>path</code></td>
<td>Substitua <em>&lt;domain_path&gt;</em> pelo caminho que você deseja anexar em seu domínio de controlador do Ingresso. O tráfego de rede recebido nesse caminho é encaminhado para o caminho de regravação que você definiu em sua anotação. No exemplo acima, configure o caminho de domínio como <code>/beans</code> para incluir esse caminho no balanceamento de carga de seu controlador do Ingresso.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <em>&lt;service_name&gt;</em> pelo nome do serviço do Kubernetes que você criou para o seu app. O nome do serviço que você usa aqui deve ser o mesmo nome que você definiu em sua anotação.</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>Substitua <em>&lt;service_port&gt;</em> pela porta na qual o seu serviço atende.</td>
</tr></tbody></table>

</dd></dl>

<br />


## Limites de taxa de serviço (service-rate-limit)
{: #service-rate-limit}

Para serviços específicos, limite a taxa de processamento de solicitação e o número de conexões por uma chave definida que estão vindo de um único endereço IP para todos os caminhos dos backends selecionados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Para configurar o limite, as zonas definidas pelo `ngx_http_limit_conn_module` e `ngx_http_limit_req_module` são aplicadas a todos os blocos de locais que correspondem a todos os serviços que são o destino na anotação no mapeamento de ingresso. </dd>


 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;service_name&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
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
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: o nome do recurso de Ingresso.</li>
  <li><code><em>&lt;key&gt;</em></code>: para configurar um limite global para solicitações recebidas com base no local ou serviço, use `key=location`. Para configurar um limite global para solicitações recebidas com base no cabeçalho, use `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code>: a taxa.</li>
  <li><code><em>&lt;conn&gt;</em></code>: o número de conexões.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


## Afinidade de sessão com cookies (sticky-cookie-services)
{: #sticky-cookie-services}

Use a anotação de cookie permanente para incluir a afinidade de sessão no controlador de Ingresso e sempre rotear o tráfego de rede recebido para o mesmo servidor de envio de dados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Para alta disponibilidade, algumas configurações de app requerem que você implemente múltiplos servidores de envio de dados que manipulam solicitações do cliente recebidas. Quando um cliente se conecta ao app backend, é possível usar a afinidade de sessão para que um cliente seja atendido pelo mesmo servidor de envio de dados pela duração de uma sessão ou pelo tempo que leva para concluir uma tarefa. É possível configurar o controlador de Ingresso para assegurar a afinidade de sessão sempre roteando o tráfego de rede recebido para o mesmo servidor de envio de dados.

</br></br>
Cada cliente que se conecta ao app backend é designado a um dos servidores de envio de dados disponíveis pelo controlador de Ingresso. O controlador de Ingresso cria um cookie de sessão que é armazenado no app do cliente, que está incluído nas informações do cabeçalho de cada solicitação entre o controlador de Ingresso e o cliente. As informações no cookie asseguram que todas as solicitações sejam manipuladas pelo mesmo servidor de envio de dados em toda a sessão.

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
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
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
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>Entendendo os componentes de arquivo YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;service_name&gt;</em></code>: o nome do serviço do Kubernetes criado para o seu app.</li>
  <li><code><em>&lt;cookie_name&gt;</em></code>: escolha um nome do cookie permanente que é criado durante uma sessão.</li>
  <li><code><em>&lt;expiration_time&gt;</em></code>: o tempo em segundos, minutos ou horas antes da expiração do cookie permanente. Esse tempo é independente da atividade do usuário. Depois que o cookie expira, ele é excluído pelo navegador da web do cliente e não é mais enviado para o controlador de Ingresso. Por exemplo, para configurar um prazo de expiração de 1 segundo, 1 minuto ou 1 hora, insira <strong>1s</strong>, <strong>1m</strong> ou <strong>1h</strong>.</li>
  <li><code><em>&lt;cookie_path&gt;</em></code>: o caminho que é anexado ao subdomínio do Ingresso e que indica para quais domínios e subdomínios o cookie é enviado para o controlador de Ingresso. Por exemplo, se o seu domínio do Ingresso for <code>www.myingress.com</code> e você desejar enviar o cookie em cada solicitação do cliente, deverá configurar <code>path=/</code>. Se desejar enviar o cookie somente para <code>www.myingress.com/myapp</code> e todos os seus subdomínios, então deverá configurar <code>path=/myapp</code>.</li>
  <li><code><em>&lt;hash_algorithm&gt;</em></code>: o algoritmo hash que protege as informações no cookie. Somente <code>sha1
</code> é suportado. SHA1 cria uma soma de hash com base nas informações no cookie e anexa essa soma de hash ao cookie. O servidor pode decriptografar as informações no cookie e verificar a integridade de dados.
  </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


## Suporte de serviços SSL (ssl-services)
{: #ssl-services}

Permitir solicitações de HTTPS e criptografar o tráfego para seus apps de envio de dados.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Criptografe o tráfego para seus apps de envio de dados que requerem HTTPS com os controladores de Ingresso.

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
    ingress.bluemix.net/ssl-services: ssl-service=&lt;service1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;service2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
spec:
  regras:
  - host: &lt;ibmdomain&gt; http: paths:
      - caminho: /&lt;myservicepath1&gt; backend: serviceName: &lt;myservice1&gt; servicePort: 8443
      - caminho: /&lt;myservicepath2&gt; backend: serviceName: &lt;myservice2&gt; servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Substitua <em>&lt;myingressname&gt;</em> por um nome para seu recurso de Ingresso.</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;myservice&gt;</em></code>: insira o nome do serviço que representa seu app. O tráfego é criptografado do controlador de Ingresso para esse app.</li>
  <li><code><em>&lt;ssl-secret&gt;</em></code>: insira o segredo para o serviço. Este parâmetro é opcional. Se o parâmetro for fornecido, o valor deverá conter a chave e o certificado que o seu app está esperando do cliente. </li></ul>
  </td>
  </tr>
  <tr>
  <td><code>rules/host</code></td>
  <td>Substitua <em>&lt;ibmdomain&gt;</em> pelo nome do <strong>subdomínio de Ingresso</strong> fornecido pela IBM.
  <br><br>
  <strong>Nota:</strong> para evitar falhas durante a criação do Ingresso, não use * para o seu host ou deixe a propriedade do host vazia.</td>
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Substitua <em>&lt;myservicepath&gt;</em> por uma barra ou pelo caminho exclusivo no qual o seu app estiver atendendo, para que o tráfego de rede possa ser encaminhado para o app.

  </br>
  Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia o tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber
o tráfego de rede de entrada.

  </br></br>
  Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.
  </br>
  Exemplos: <ul><li>Para <code>http://ingress_host_name/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
  </br>
  <strong>Dica:</strong> para configurar o seu Ingresso para atender em um caminho que é diferente daquele no qual o seu app atende, será possível usar <a href="#rewrite-path" target="_blank">reescrever anotação</a> para estabelecer o roteamento adequado para o seu app.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Substitua <em>&lt;myservice&gt;</em> pelo nome do serviço que você usou quando criou o serviço do Kubernetes para o seu app.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>A porta na qual o serviço atende. Use a mesma porta que você definiu quando criou o serviço do Kubernetes para seu app.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


### Suporte de serviços SSL com autenticação
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
      ssl-service=&lt;service1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;service2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
spec:
  tls:
  - System z:
    - &lt;ibmdomain&gt;
    secretName: &lt;secret_name&gt;
  rules:
  - host: &lt;ibmdomain&gt; http: paths:
      - caminho: /&lt;myservicepath1&gt; backend: serviceName: &lt;myservice1&gt; servicePort: 8443
      - caminho: /&lt;myservicepath2&gt; backend: serviceName: &lt;myservice2&gt; servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Substitua <em>&lt;myingressname&gt;</em> por um nome para seu recurso de Ingresso.</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;service&gt;</em></code>: insira o nome do serviço.</li>
  <li><code><em>&lt;service-ssl-secret&gt;</em></code>: insira o segredo para o serviço.</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>tls/host</code></td>
  <td>Substitua <em>&lt;ibmdomain&gt;</em> pelo nome do <strong>subdomínio de Ingresso</strong> fornecido pela IBM.
  <br><br>
  <strong>Nota:</strong> para evitar falhas durante a criação do Ingresso, não use * para o seu host ou deixe a propriedade do host vazia.</td>
  </tr>
  <tr>
  <td><code>tls/secretName</code></td>
  <td>Substitua <em>&lt;secret_name&gt;</em> pelo nome do segredo que contém seu certificado e, para autenticação mútua, chave.
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Substitua <em>&lt;myservicepath&gt;</em> por uma barra ou pelo caminho exclusivo no qual o seu app estiver atendendo, para que o tráfego de rede possa ser encaminhado para o app.

  </br>
  Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber
o tráfego de rede de entrada.

  </br></br>
  Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.
  </br>
  Exemplos: <ul><li>Para <code>http://ingress_host_name/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
  </br>
  <strong>Dica:</strong> para configurar o seu Ingresso para atender em um caminho que é diferente daquele no qual o seu app atende, será possível usar <a href="#rewrite-path" target="_blank">reescrever anotação</a> para estabelecer o roteamento adequado para o seu app.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Substitua <em>&lt;myservice&gt;</em> pelo nome do serviço que você usou quando criou o serviço do Kubernetes para o seu app.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>A porta na qual o serviço atende. Use a mesma porta que você definiu quando criou o serviço do Kubernetes para seu app.</td>
  </tr>
  </tbody></table>

  </dd>



<dt>Amostra secreta YAML para autenticação unilateral</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadados:
  name: &lt;secret_name&gt;
type: Opaque
dados:
  trusted.crt: &lt;certificate_name&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Substitua <em>&lt;secret_name&gt;</em> por um nome para o recurso de segredo.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Substitua o valor a seguir:<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>:insira o nome do certificado confiável.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>

<dt>Amostra secreta YAML para autenticação mútua</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadados:
  name: &lt;secret_name&gt;
type: Opaque
dados:
  trusted.crt : &lt;certificate_name&gt;
    client.crt : &lt;client_certificate_name&gt;
    client.key : &lt;certificate_key&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Substitua <em>&lt;secret_name&gt;</em> por um nome para o recurso de segredo.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>:insira o nome do certificado confiável.</li>
  <li><code><em>&lt;client_certificate_name&gt;</em></code>: insira o nome do certificado de cliente.</li>
  <li><code><em>&lt;certificate_key&gt;</em></code>: insira a chave para o certificado de cliente.</li></ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />



## Portas TCP para controladores de Ingresso (tcp-ports)
{: #tcp-ports}

Acesse um app através de uma porta TCP não padrão.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>
Use essa anotação para um app que está executando uma carga de trabalho de fluxos de TCP.

<p>**Nota**: o controlador de Ingresso opera no modo de passagem e encaminha o tráfego para apps backend. A finalização de SSL não é suportada neste caso.</p>
</dd>


 <dt>YAML do recurso de Ingresso de amostra</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/tcp-ports: "serviceName=&lt;service_name&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
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
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul>
  <li><code><em>&lt;ingressPort&gt;</em></code>: a porta TCP na qual você deseja acessar seu app.</li>
  <li><code><em>&lt;serviceName&gt;</em></code>: o nome do serviço do Kubernetes para acessar por meio da porta TCP não padrão.</li>
  <li><code><em>&lt;servicePort&gt;</em></code>: este parâmetro é opcional. Quando fornecido, a porta é substituída para este valor antes que o tráfego seja enviado para o app backend. Caso contrário, a porta permanece igual à porta de Ingresso.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


  ## Envio de dados keep-alive (upstream-keepalive)
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
      ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;service_name&gt; keepalive=&lt;max_connections&gt;"
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
    <td><code>annotations</code></td>
    <td>Substitua os seguintes valores:<ul>
    <li><code><em>&lt;serviceName&gt;</em></code>: substitua <em>&lt;service_name&gt;</em> pelo nome do serviço do Kubernetes que você criou para o seu app.</li>
    <li><code><em>&lt;keepalive&gt;</em></code>: Substitua <em>&lt;max_connections&gt;</em> pelo número máximo de conexões keep-alive inativas para o servidor de envio de dados. O padrão é 64. Um valor zero desativa conexões keep-alive de envio de dados para o serviço especificado.</li>
    </ul>
    </td>
    </tr>
    </tbody></table>
    </dd>
    </dl>


