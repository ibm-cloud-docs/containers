---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

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



# Modificando o comportamento padrão do Ingress
{: #ingress-settings}

Depois de expor seus aplicativos criando um recurso do Ingress, é possível configurar ainda mais os ALBs do Ingress em seu cluster, configurando as opções a seguir.
{: shortdesc}

## Abrindo portas no ALB do Ingress
{: #opening_ingress_ports}

Por padrão, somente as portas 80 e 443 são expostas no ALB de Ingresso. Para expor outras portas, é possível editar o recurso configmpa `ibm-cloud-provider-ingress-cm`.
{: shortdesc}

1. Edite o arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Inclua uma seção <code>dados</code> e especifique as portas públicas `80`, `443` e quaisquer outras portas que você deseja expor separados por um ponto e vírgula (;).

    Por padrão, as portas 80 e 443 ficam abertas. Se você deseja manter a 80 e a 443 abertas, deve-se também incluí-las além de quaisquer outras portas especificadas no campo `public-ports`. Qualquer porta que não esteja especificada é encerrada. Se você ativou um ALB privado, deve-se também especificar quaisquer portas que você deseja manter abertas no campo `private-ports`.
    {: important}

    ```
    apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    Exemplo que mantém as portas `80`, `443` e `9443` abertas:
    ```
    apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: screen}

3. Salve o arquivo de configuração.

4. Verifique se as mudanças de configmap foram aplicadas.
  ```
  kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
  ```
  {: pre}

5. Opcional:
  * Acesse um app por meio de uma porta TCP não padrão que você abriu usando a anotação [`tcp-ports`](/docs/containers?topic=containers-ingress_annotation#tcp-ports).
  * Mude as portas padrão para o tráfego de rede HTTP (porta 80) e HTTPS (porta 443) para uma porta que você abriu usando a anotação [`custom-port`](/docs/containers?topic=containers-ingress_annotation#custom-port).

Para obter mais informações sobre os recursos do configmap, consulte a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/).

<br />


## Preservando o endereço IP de origem
{: #preserve_source_ip}

Por padrão, o endereço IP de origem da solicitação do cliente não é preservado. Quando uma solicitação do cliente para o seu app for enviada para o seu cluster, a solicitação será roteada para um pod para o serviço do balanceador de carga que expõe o ALB. Se nenhum pod de app existir no mesmo nó do trabalhador que o pod de serviço de balanceador de carga, o balanceador de carga encaminhará a solicitação para um pod de app em um nó do trabalhador diferente. O endereço IP de origem do pacote é mudado para o endereço IP público do nó do trabalhador no qual o pod de app está em execução.
{: shortdesc}

Para preservar o endereço IP de origem original da solicitação do cliente, é possível ativar a [preservação de IP de origem ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer). Preservar o IP do cliente é útil, por exemplo, quando os servidores de app precisam aplicar as políticas de segurança e de controle de acesso.

Se você [desativar um ALB](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure), qualquer mudança de IP de origem que fizer no serviço do balanceador de carga que expõe o ALB será perdida. Quando você reativa o ALB, deve-se ativar o IP de origem novamente.
{: note}

Para ativar a preservação de IP de origem, edite o serviço de balanceador de carga que expõe um ALB do Ingress:

1. Ative a preservação de IP de origem para um único ALB ou para todos os ALBs em seu cluster.
    * Para configurar a preservação de IP de origem para um único ALB:
        1. Obtenha o ID do ALB para o qual você deseja ativar o IP de origem. Os serviços ALB têm um formato semelhante a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` para um ALB público ou `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` para um ALB privado.
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Abra o YAML para o serviço de balanceador de carga que expõe o ALB.
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. Em **`spec`**, mude o valor de **`externalTrafficPolicy`** de `Cluster` para `Local`.

        4. Salve e feche o arquivo de configuração. A saída é semelhante à seguinte:

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * Para configurar a preservação de IP de origem para todos os ALBs públicos em seu cluster, execute o comando a seguir:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Saída de exemplo:
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * Para configurar a preservação de IP de origem para todos os ALBs privados em seu cluster, execute o comando a seguir:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Saída de exemplo:
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Verifique se o IP de origem está sendo preservado em seus logs de pods do ALB.
    1. Obtenha o ID de um pod para o ALB que você modificou.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Abra os logs para esse pod do ALB. Verifique se o endereço IP para o campo `client` é o endereço IP de solicitação do cliente em vez do endereço IP do serviço de balanceador de carga.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. Agora, ao consultar os cabeçalhos para as solicitações que são enviadas para o seu aplicativo back-end, é possível ver o endereço IP do cliente no cabeçalho `x-forwarded-for`.

4. Se você não desejar mais preservar o IP de origem, será possível reverter as mudanças feitas no serviço.
    * Para reverter a preservação do IP de origem para seus ALBs públicos:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * Para reverter a preservação do IP de origem para seus ALBs privados:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## Configurando protocolos SSL e cifras SSL no nível de HTTP
{: #ssl_protocols_ciphers}

Ative os protocolos e cifras SSL no nível HTTP global editando o configmap `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

Para estar em conformidade com o mandato do Conselho de Padrões de Segurança do PCI, o serviço Ingress desativa o TLS 1.0 e 1.1, por padrão, com a atualização da versão futura dos pods do ALB do Ingress em 23 de janeiro de 2019. A atualização é recuperada automaticamente para todos os {{site.data.keyword.containerlong_notm}} clusters que não tenham optado por atualizações automáticas do ALB. Se os clientes que se conectarem a seus apps suportarem TLS 1.2, nenhuma ação será necessária. Se você ainda tiver clientes anteriores que requerem suporte do TLS 1.0 ou 1.1, deverá ativar manualmente as versões do TLS necessárias. É possível substituir a configuração padrão para usar os protocolos TLS 1.1 ou 1.0 seguindo as etapas nesta seção. Para obter mais informações sobre como ver as versões do TLS que seus clientes usam para acessar seus aplicativos, consulte esta [postagem do blog do {{site.data.keyword.cloud_notm}}](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).
{: important}

Quando você especifica os protocolos ativados para todos os hosts, os parâmetros TLSv1.1 e TLSv1.2 (1.1.13, 1.0.12) funcionam somente quando o OpenSSL 1.0.1 ou superior é usado. O parâmetro TLSv1.3 (1.13.0) funciona somente quando o OpenSSL 1.1.1 construído com o suporte TLSv1.3 é usado.
{: note}

Para editar o configmap para ativar protocolos e cifras SSL:

1. Edite o arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Inclua os protocolos e cifras SSL. Formate as cifras de acordo com o [Formato de lista de cifras da biblioteca OpenSSL ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
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

<br />


## Aumentando o tempo de verificação de prontidão do reinício para os pods ALB
{: #readiness-check}

Aumente a quantidade de tempo que os pods ALB têm para analisar arquivos de recursos grandes do Ingress quando os pods do ALB são reiniciados.
{: shortdesc}

Quando um pod do ALB é reiniciado, como após a aplicação de uma atualização, uma verificação de prontidão evita que o pod do ALB tente rotear as solicitações de tráfego até que todos os arquivos de recursos do Ingress sejam analisados. Essa verificação de prontidão evita a perda de solicitação quando os pods do ALB são reiniciados. Por padrão, a verificação de prontidão espera 15 segundos depois que o pod reinicia para começar a verificar se todos os arquivos do Ingress são analisados. Se todos os arquivos forem analisados 15 segundos após a reinicialização do pod, o pod do ALB começará a rotear as solicitações de tráfego novamente. Se todos os arquivos não forem analisados 15 segundos após o reinício do pod, o pod não roteará o tráfego e a verificação de prontidão continuará a ser feita a cada 15 segundos por um tempo limite máximo de 5 minutos. Após 5 minutos, o pod ALB começa a rotear o tráfego.

Se você tiver arquivos de recursos muito grandes do Ingress, poderá levar mais de 5 minutos para que todos os arquivos sejam analisados. É possível mudar os valores padrão para a taxa de intervalo de verificação de prontidão e para o tempo limite máximo total de verificação de prontidão incluindo as configurações de `ingress-resource-creation-rate` e `ingress-resource-timeout` para o configmap `ibm-cloud-provider-ingress-cm`.

1. Edite o arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Na seção **dados**, inclua as configurações de `ingress-resource-creation-rate` e `ingress-resource-timeout`. Os valores podem ser formatados como segundos (`s`) e minutos (`m`). Exemplo:
   ```
   apiVersion: v1
   data:
     ingress-resource-creation-rate: 1m
     ingress-resource-timeout: 6m
     keep-alive: 8s
     private-ports: 80;443
     public-ports: 80;443
   ```
   {: codeblock}

3. Salve o arquivo de configuração.

4. Verifique se as mudanças de configmap foram aplicadas.
   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Ajustando o desempenho do ALB
{: #perf_tuning}

Para otimizar o desempenho de seus ALBs do Ingress, é possível mudar as configurações padrão de acordo com suas necessidades.
{: shortdesc}

### Incluindo listeners de soquete ALB em cada nó do trabalhador
{: #reuse-port}

Aumente o número de listeners de soquete do ALB de um por cluster para um por nó do trabalhador usando a diretiva `reuse-port` do Ingress.
{: shortdesc}

Quando a opção `reuse-port` estiver desativada, um único soquete de atendimento notificará os trabalhadores sobre as conexões recebidas e todos os nós do trabalhador tentarão fazer a conexão. Mas quando `reuse-port` estiver ativado, haverá um listener de soquete por nó do trabalhador para cada combinação de endereço IP e porta do ALB. Em vez de cada nó do trabalhador tentar fazer a conexão, o kernel do Linux determina qual listener de soquete disponível obterá a conexão. A contenção de bloqueio entre trabalhadores é reduzida, o que pode melhorar o desempenho. Para obter mais informações sobre os benefícios e desvantagens da diretiva `reuse-port`, consulte [esta postagem do blog do NGINX ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.nginx.com/blog/socket-sharding-nginx-release-1-9-1/).

É possível escalar os listeners editando o configmap `ibm-cloud-provider-ingress-cm` do Ingress.

1. Edite o arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Na seção `metadata`, inclua `reuse-port: "true"`. Exemplo:
   ```
   apiVersion: v1
   data:
     private-ports: 80;443;9443
     public-ports: 80;443
   kind: ConfigMap
   metadata:
     creationTimestamp: "2018-09-28T15:53:59Z"
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
     resourceVersion: "24648820"
     selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
     uid: b6ca0c36-c336-11e8-bf8c-bee252897df5
     reuse-port: "true"
   ```
   {: codeblock}

3. Salve o arquivo de configuração.

4. Verifique se as mudanças de configmap foram aplicadas.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Ativando o buffer de buffer e o tempo limite de flush
{: #access-log}

Por padrão, o ALB do Ingress registra cada solicitação conforme ela chega. Se você tem um ambiente que é intensamente usado, a criação de log de cada solicitação à medida que ela chega pode aumentar significativamente a utilização de E/S do disco. Para evitar E/S de disco contínuo, é possível ativar o armazenamento em buffer do log e limpar o tempo limite para o ALB editando o configmap do Ingress `ibm-cloud-provider-ingress-cm`. Quando o armazenamento em buffer está ativado, em vez de executar uma operação de gravação separada para cada entrada de log, o ALB armazena em buffer uma série de entradas e as grava em um arquivo em uma única operação.
{: shortdesc}

1. Crie e edite o arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Edite o configmap.
    1. Ative o armazenamento em buffer do log incluindo o campo `access-log-buffering` e configurando-o como `"true"`.

    2. Configure o limite para quando o ALB deve gravar conteúdos do buffer no log.
        * Intervalo de tempo: inclua o campo `flush-interval` e configure-o com que frequência o ALB deve gravar no log. Por exemplo, se o valor padrão de `5m` for usado, o ALB gravará conteúdos do buffer no log uma vez a cada 5 minutos.
        * Tamanho do buffer: inclua o campo `buffer-size` e configure-o para a quantia de memória de log que pode ser retida no buffer antes que o ALB grave os conteúdos do buffer no log. Por exemplo, se o valor padrão de `100KB` for usado, o ALB gravará os conteúdos do buffer no log toda vez que o buffer atingir 100 Kb de conteúdo de log.
        * Intervalo de tempo ou tamanho do buffer: quando `flush-interval` e `buffer-size` estão configurados, o ALB grava o conteúdo do buffer no log com base no parâmetro de limite que é atendido primeiro.

    ```
    apiVersion: v1
    kind: ConfigMap
    data:
      access-log-buffering: "true"
      flush-interval: "5m"
      buffer-size: "100KB"
    metadata:
      name: ibm-cloud-provider-ingress-cm
      ...
    ```
   {: codeblock}

3. Salve o arquivo de configuração.

4. Verifique se o ALB está configurado com as mudanças de log de acesso.

   ```
   kubectl logs -n kube-system <ALB_ID> -c nginx-ingress
   ```
   {: pre}

### Mudando o número ou a duração de conexões keep-alive
{: #keepalive_time}

As conexões keep-alive podem ter um grande impacto no desempenho reduzindo o uso de CPU e de rede que é necessário para abrir e fechar conexões. Para otimizar o desempenho de seus ALBs, é possível mudar o número máximo de conexões keep-alive entre o ALB e o cliente e por quanto tempo as conexões keep-alive podem durar.
{: shortdesc}

1. Edite o arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Mude os valores de `keep-alive-requests` e `keep-alive`.
    * `keep-alive-requests`: o número de conexões do cliente keep-alive que podem permanecer abertas para o ALB do Ingress. O padrão é  ` 4096 `.
    * `keep-alive`: o tempo limite, em segundos, durante o qual a conexão do cliente keep-alive permanece aberta para o ALB do Ingress. O padrão é `8s`.
   ```
   apiVersion: v1
   data:
     keep-alive-requests: "4096"
     keep-alive: "8s"
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

### Alterando a lista não processada de conexões pendentes
{: #backlog}

É possível diminuir a configuração de lista não processada padrão para quantas conexões pendentes podem esperar na fila do servidor.
{: shortdesc}

No configmap do Ingress `ibm-cloud-provider-ingress-cm`, o campo `backlog` configura o número máximo de conexões pendentes que podem esperar na fila do servidor. Por padrão, `backlog` está configurado como `32768`. É possível substituir o padrão editando o configmap do Ingress.

1. Edite o arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Mude o valor de `backlog` de `32768` para um valor inferior. O valor deve ser igual ou menor que 32768.

   ```
   apiVersion: v1
   data:
     backlog: "32768"
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

### Ajustando o desempenho do kernel
{: #ingress_kernel}

Para otimizar o desempenho de seus ALBs do Ingress, também é possível [mudar os parâmetros `sysctl` do kernel do Linux em nós do trabalhador](/docs/containers?topic=containers-kernel). Os nós do trabalhador são provisionados automaticamente com o ajuste do kernel otimizado, portanto, mude essas configurações somente se você tiver requisitos de otimização de desempenho específicos.
{: shortdesc}

<br />

