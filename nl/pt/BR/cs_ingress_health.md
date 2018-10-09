---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Criação de Log e Monitoramento de Ingresso
{: #ingress_health}

Customize a criação de log e configure o monitoramento para ajudar a solucionar problemas e melhorar o desempenho de sua configuração do Ingress.
{: shortdesc}

## Visualizando logs do Ingresso
{: #ingress_logs}

Os logs são coletados automaticamente para seus ALBs do Ingress. Para visualizar os logs do ALB, escolha entre duas opções.
* [Crie uma configuração de criação de log para o serviço Ingress](cs_health.html#configuring) em seu cluster.
* Verifique os logs a partir da CLI.
    1. Obtenha o ID de um pod para um ALB.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Abra os logs para esse pod do ALB. Verifique se os logs seguem o formato atualizado.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

</br>O conteúdo do log do Ingress padrão é formatado em JSON e exibe campos comuns que descrevem a sessão de conexão entre um cliente e seu app. Um log de exemplo com os campos padrão é semelhante ao seguinte:

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>Entendendo os campos no formato de log do Ingress padrão</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Entendendo os campos no formato de log do Ingress padrão</th>
</thead>
<tbody>
<tr>
<td><code> "time_date": "$time_iso8601" </code></td>
<td>O horário local no formato padrão ISO 8601 quando o log é gravado.</td>
</tr>
<tr>
<td><code> "client": "$remote_addr" </code></td>
<td>O endereço IP do pacote de solicitação que o cliente enviou ao seu app. Esse IP pode mudar com base nas situações a seguir:<ul><li>Quando uma solicitação do cliente para o seu app for enviada para o seu cluster, a solicitação será roteada para um pod para o serviço do balanceador de carga que expõe o ALB. Se nenhum pod de app existir no mesmo nó do trabalhador que o pod de serviço de balanceador de carga, o balanceador de carga encaminhará a solicitação para um pod de app em um nó do trabalhador diferente. O endereço IP de origem do pacote de solicitação é mudado para o endereço IP público do nó do trabalhador no qual o pod de app está em execução.</li><li>Se a [preservação de IP de origem estiver ativada](cs_ingress.html#preserve_source_ip), o endereço IP original da solicitação do cliente para seu app será registrado no lugar.</li></ul></td>
</tr>
<tr>
<td><code> "host": "$http_host" </code></td>
<td>O host, ou subdomínio, por meio do qual seus apps são acessíveis. Esse host é configurado nos arquivos de recursos do Ingress para seus ALBs.</td>
</tr>
<tr>
<td><code> "esquema": "$scheme" </code></td>
<td>O tipo de solicitação: <code>HTTP</code> ou <code>HTTPS</code>.</td>
</tr>
<tr>
<td><code> "request_method": "$request_method" </code></td>
<td>O método da chamada de solicitação para o app de backend, como <code>GET</code> ou <code>POST</code>.</td>
</tr>
<tr>
<td><code> "request_uri": "$uri" </code></td>
<td>O URI da solicitação original para seu caminho de app. Os ALBs processam os caminhos que os apps atendem como prefixos. Quando um ALB recebe uma solicitação de um cliente para um app, o ALB verifica o recurso Ingress para um caminho (como um prefixo) que corresponde ao caminho no URI da solicitação.</td>
</tr>
<tr>
<td><code> "request_id": "$request_id" </code></td>
<td>Um identificador de solicitação exclusivo gerado a partir de 16 bytes aleatórios.</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>O código de status para a sessão de conexão.<ul>
<li><code> 200 </code>: Sessão concluída com sucesso</li>
<li><code>400</code>: os dados de cliente não podem ser analisados</li>
<li><code>403</code>: acesso proibido; por exemplo, quando o acesso é limitado para determinados endereços IP do cliente</li>
<li><code> 500 </code>: erro do servidor interno</li>
<li><code>502</code>: gateway ruim; por exemplo, se um servidor de envio de dados não puder ser selecionado ou atingido</li>
<li><code>503</code>: serviço indisponível; por exemplo, quando o acesso é limitado pelo número de conexões</li>
</ul></td>
</tr>
<tr>
<td><code> "upstream_addr": "$upstream_addr" </code></td>
<td>O endereço IP e a porta ou o caminho para o soquete do domínio do UNIX do servidor de envio de dados. Se vários servidores forem contatados durante o processamento de solicitação, seus endereços serão separados por vírgulas: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock"</code>. Se a solicitação for redirecionada internamente de um grupo de servidores para outro, os endereços do servidor de diferentes grupos serão separados por dois-pontos: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80"</code>. Se o ALB não puder selecionar um servidor, o nome do grupo de servidores será registrado no lugar.</td>
</tr>
<tr>
<td><code> "upstream_status": $upstream_status </code></td>
<td>O código de status da resposta obtida do servidor de envio de dados para o app de backend, como códigos de resposta de HTTP padrão. Os códigos de status de várias respostas são separados por vírgulas e dois-pontos como endereços na variável <code>$upstream_addr</code>. Se o ALB não puder selecionar um servidor, o código de status 502 (Gateway ruim) será registrado.</td>
</tr>
<tr>
<td><code> "request_time": $request_time </code></td>
<td>O tempo de processamento da solicitação, medido em segundos com uma resolução de milissegundos. Esse tempo inicia quando o ALB lê os primeiros bytes da solicitação do cliente e para quando o ALB envia os últimos bytes da resposta para o cliente. O log será gravado imediatamente após o tempo de processamento da solicitação parar.</td>
</tr>
<tr>
<td><code> "upstream_response_time": $upstream_response_time </code></td>
<td>O tempo que leva para o ALB receber a resposta do servidor de envio de dados para o app de backend, medido em segundos com uma resolução de milissegundos. Os tempos de várias respostas são separados por vírgulas e dois-pontos como endereços na variável <code>$upstream_addr</code>.</td>
</tr>
<tr>
<td><code> "upstream_connect_time": $upstream_connect_time </code></td>
<td>O tempo que leva para o ALB estabelecer uma conexão com o servidor de envio de dados para o app de backend, medido em segundos com uma resolução de milissegundos. Se o TLS/SSL estiver ativado em sua configuração do recurso Ingress, esse tempo incluirá o tempo gasto no handshake. Os tempos de várias conexões são separados por vírgulas e dois-pontos como endereços na variável <code>$upstream_addr</code>.</td>
</tr>
<tr>
<td><code> "upstream_header_time": $upstream_header_time </code></td>
<td>O tempo que leva para o ALB receber o cabeçalho de resposta do servidor de envio de dados para o app de backend, medido em segundos com uma resolução de milissegundos. Os tempos de várias conexões são separados por vírgulas e dois-pontos como endereços na variável <code>$upstream_addr</code>.</td>
</tr>
</tbody></table>

## Customizando o conteúdo e o formato de log do Ingress
{: #ingress_log_format}

É possível customizar o conteúdo e o formato de logs que são coletados para o ALB do Ingress.
{:shortdesc}

Por padrão, os logs do Ingress são formatados em JSON e exibem campos de log comuns. No entanto, também é possível criar um formato de log customizado. Para escolher quais componentes de log são encaminhados e como os componentes são organizados na saída de log:

1. Crie e abra uma versão local do arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Inclua um <code>dados</code> seção. Inclua o campo `log-format` e, opcionalmente, o campo `log-format-escape-json`.

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    <table>
    <caption>Componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone ideia"/> Entendendo a configuração de formato de log</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>Substitua <code>&lt;key&gt;</code> pelo nome do componente de log e <code>&lt;log_variable&gt;</code> por uma variável para o componente de log que você deseja coletar em entradas de log. É possível incluir texto e pontuação que você deseja que a entrada de log contenha, como aspas em torno de valores de sequência e vírgulas para separar os componentes de log. Por exemplo, formatar um componente como <code>request: "$request"</code> gera o seguinte em uma entrada de log: <code>request: "GET / HTTP/1.1"</code>. Para obter uma lista de todas as variáveis que você pode usar, veja o <a href="http://nginx.org/en/docs/varindex.html">Índice de variável Nginx</a>.<br><br>Para registrar um cabeçalho adicional como <em>x-custom-ID</em>, inclua o par chave-valor a seguir no conteúdo de log customizado: <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>Os hifens (<code>-</code>) são convertidos em sublinhados (<code>_</code>) e <code>$http_</code> deve ser pré-anexado ao nome do cabeçalho customizado.</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>Opcional: por padrão, os logs são gerados em formato de texto. Para gerar logs no formato JSON, inclua o campo <code>log-format-escape-json</code> e use o valor <code>true</code>.</td>
    </tr>
    </tbody></table>

    Por exemplo, seu formato de log pode conter as variáveis a seguir:
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    Uma entrada de log de acordo com esse formato é semelhante ao exemplo a seguir:
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    Para criar um formato de log customizado que é baseado no formato padrão para logs do ALB, modifique a seção a seguir conforme necessário e inclua-a em seu configmap:
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. Salve o arquivo de configuração.

5. Verifique se as mudanças de configmap foram aplicadas.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. Para visualizar os logs do ALB do Ingresso, escolha entre duas opções.
    * [Crie uma configuração de criação de log para o serviço Ingress](cs_health.html#logging) em seu cluster.
    * Verifique os logs a partir da CLI.
        1. Obtenha o ID de um pod para um ALB.
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. Abra os logs para esse pod do ALB. Verifique se os logs seguem o formato atualizado.
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## Aumentando o tamanho da zona de memória compartilhada para a coleção de métricas do Ingress
{: #vts_zone_size}

As zonas de memória compartilhada são definidas para que os processos do trabalhador possam compartilhar informações, como cache, persistência de sessão e limites de taxa. Uma zona de memória compartilhada, chamada de zona de status de tráfego do host virtual, está configurada para o Ingresso para coletar dados de métricas para um ALB.
{:shortdesc}

No configmap do Ingresso `ibm-cloud-provider-ingress-cm`, o campo `vts-status-zone-size` configura o tamanho da zona de memória compartilhada para a coleta de dados de métrica. Por padrão, `vts-status-zone-size` é configurado como `10m`. Se você tiver um ambiente grande que requeira mais memória para coleta de métricas, será possível substituir o padrão para usar, como alternativa, um valor maior, seguindo estas etapas.

1. Crie e abra uma versão local do arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Mude o valor de `vts-status-zone-size` de `10m` para um valor maior.

   ```
   apiVersion: v1
   data:
     vts-status-zone-size: "10m"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Salve o arquivo de configuração.

4. Verifique se as mudanças de configmap foram aplicadas.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}
