---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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


# Usando o complemento do Istio gerenciado (beta)
{: #istio}

O Istio on {{site.data.keyword.containerlong}} fornece uma instalação contínua do Istio, atualizações automáticas e gerenciamento de ciclo de vida de componentes de plano de controle do Istio e integração com a criação de log de plataforma e as ferramentas de monitoramento.
{: shortdesc}

Com um clique, é possível obter todos os componentes principais do Istio, rastreio adicional, monitoramento e visualização e o aplicativo de amostra BookInfo funcionando. O Istio no {{site.data.keyword.containerlong_notm}} é oferecido como um complemento gerenciado, portanto, o {{site.data.keyword.Bluemix_notm}} mantém automaticamente todos os seus componentes do Istio atualizados.

## Entendendo o Istio no  {{site.data.keyword.containerlong_notm}}
{: #istio_ov}

### O que é Istio?
{: #istio_ov_what_is}

[Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/info/istio) é uma plataforma de malha de serviços aberta para conectar, proteger, controlar e observar microsserviços em plataformas de nuvem, como o Kubernetes, no {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Ao deslocar os aplicativos monolíticos para uma arquitetura de microsserviço distribuída, um conjunto de novos desafios surge, como controlar o tráfego de seus microsserviços, fazer lançamentos ocultos e lançamentos canários de seus serviços, manipular falhas, proteger a comunicação de serviço, observar os serviços e impor políticas de acesso consistentes na frota de serviços. Para resolver essas dificuldades, é possível aproveitar uma malha de serviços. Uma malha de serviço fornece uma rede transparente e independente de idioma para conexão, observação, proteção e controle da conectividade entre microsserviços. O Istio fornece insights e controle sobre a malha de serviços, permitindo que você gerencie o tráfego de rede, balanceie a carga entre microsserviços, imponha políticas de acesso, verifique a identidade de serviço e mais.

Por exemplo, usar Istio em sua rede de microsserviços pode ajudá-lo a:
- Atingir melhor visibilidade nos apps em execução em seu cluster
- Implementar versões canárias de apps e controlar o tráfego que é enviado a eles
- Ativar a criptografia automática de dados que são transferidos entre os microsserviços
- Impor limitação de taxa e inserir políticas na lista de desbloqueio e na lista de bloqueio com base em atributo

Uma malha de serviços do Istio é composta de um plano de dados e um plano de controle. O plano de dados consiste em sidecars de proxy do Envoy em cada pod de app, o que faz a mediação da comunicação entre os microsserviços. O plano de controle consiste em Pilot, telemetria e política do Mixer e Citadel, que aplicam configurações do Istio em seu cluster. Para obter mais informações sobre cada um desses componentes, consulte a [Descrição do complemento `istio`](#istio_components).

### O que é Istio no  {{site.data.keyword.containerlong_notm}}  (beta)?
{: #istio_ov_addon}

O Istio on {{site.data.keyword.containerlong_notm}} é oferecido como um complemento gerenciado que integra o Istio diretamente com o cluster Kubernetes.
{: shortdesc}

**Como ele se parece em meu cluster?**</br>
Quando você instala o complemento Istio, o controle e os planos de dados do Istio usam as VLANs às quais seu cluster já está conectado. O tráfego de configuração flui sobre a rede privada em seu cluster e não requer a abertura de portas adicionais ou endereços IP em seu firewall. Se você expor seus apps gerenciados pelo Istio com um gateway do Istio, as solicitações de tráfego externo para os apps fluirão sobre a VLAN pública.

** Como o processo de atualização funciona? **</br>
A versão do Istio no complemento gerenciado é testada pelo {{site.data.keyword.Bluemix_notm}} e aprovada para o uso no {{site.data.keyword.containerlong_notm}}. Além disso, o complemento Istio simplifica a manutenção do seu plano de controle do Istio para que você possa se concentrar em gerenciar seus microsserviços. O {{site.data.keyword.Bluemix_notm}} mantém todos os seus componentes do Istio atualizados, apresentando automaticamente as atualizações para a versão mais recente do Istio suportada pelo {{site.data.keyword.containerlong_notm}}.  

Se você precisar usar a versão mais recente do Istio ou customizar a sua instalação do Istio, será possível instalar a versão de software livre do Istio seguindo as etapas no tutorial [Iniciação rápida do {{site.data.keyword.Bluemix_notm}}![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/setup/kubernetes/quick-start-ibm/).
{: tip}

**Há alguma limitação?** </br>
Se você instalou o [controlador de admissão de imposição de segurança imagem de contêiner](/docs/services/Registry?topic=registry-security_enforce#security_enforce) em seu cluster, não será possível ativar o complemento Istio gerenciado em seu cluster.

<br />


## O que posso instalar?
{: #istio_components}

O Istio on {{site.data.keyword.containerlong_notm}} é oferecido como três complementos gerenciados em seu cluster.
{: shortdesc}

<dl>
<dt>Istio (` istio `)</dt>
<dd>Instala os componentes principais do Istio, incluindo o Prometheus. Para obter mais informações sobre qualquer um dos componentes do plano de controle a seguir, consulte a [Documentação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/concepts/what-is-istio).
  <ul><li>`Envoy` executa o proxy do tráfego de entrada e de saída para todos os serviços na malha. O Envoy é implementado como um contêiner sidecar no mesmo pod que seu contêiner de app.</li>
  <li>`Mixer` fornece controles de coleção de telemetria e de política.<ul>
    <li>Os pods de telemetria são ativados com um terminal Prometheus, que agrega todos os dados de telemetria dos sidecars e serviços de proxy do Envoy em seus pods de app.</li>
    <li>Os pods de política aplicam o controle de acesso, incluindo a limitação de taxa e a aplicação de políticas de lista de desbloqueio e de lista de bloqueio.</li></ul>
  </li>
  <li>`Pilot` fornece a descoberta de serviço para os sidecars do Envoy e configura as regras de roteamento de gerenciamento de tráfego para sidecars.</li>
  <li>`Citadel` usa o gerenciamento de identidade e de credencial para fornecer autenticação de usuário final e de serviço para serviço.</li>
  <li>`Galley` valida as mudanças na configuração para os outros componentes do plano de controle do Istio.</li>
</ul></dd>
<dt>Istio extras (` istio-extras `)</dt>
<dd>Opcional: Instala o [Grafana ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://grafana.com/), o [Jaeger ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.jaegertracing.io/) e o [Kiali ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.kiali.io/) para fornecer monitoramento, rastreio e visualização extras para o Istio.</dd>
<dt>Aplicativo de amostra BookInfo (` istio-sample-bookinfo `)</dt>
<dd>Opcional: implementa o [aplicativo de amostra BookInfo para o Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/examples/bookinfo/). Essa implementação inclui a configuração de demo de base e as regras de destino padrão para que seja possível experimentar os recursos do Istio imediatamente.</dd>
</dl>

<br>
Sempre é possível ver quais complementos do Istio estão ativados em seu cluster executando o comando a seguir:
```
ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
```
{: pre}

O complemento gerenciado `istio` pode ser instalado em um cluster livre. Para instalar também os complementos `istio-extras` e `istio-sample-bookinfo`, crie um cluster padrão com pelo menos dois nós do trabalhador.
{: note}

<br />


## Instalando o Istio no {{site.data.keyword.containerlong_notm}}
{: #istio_install}

Instale os complementos gerenciados pelo Istio em um cluster existente.
{: shortdesc}

**Antes de começar**</br>
* Assegure-se de que você tenha a [função de **Gravador** ou **Gerenciador** do serviço {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o {{site.data.keyword.containerlong_notm}}.
* [Destino da CLI para um cluster 1.10 ou mais recente existente](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
* Se você instalou anteriormente o Istio no cluster usando o gráfico do Helm da IBM ou por meio de outro método, [limpe a instalação do Istio](#istio_uninstall_other).

### Instalando complementos do Istio gerenciados na CLI
{: #istio_install_cli}

1. Ative o  ` istio `  add-on.
  ```
  ibmcloud ks cluster-addon-enable istio --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Opcional: Ative o complemento  ` istio-extras ` .
  ```
  ibmcloud ks cluster-addon-enable istio-extras --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Opcional: Ative o complemento  ` istio-sample-bookinfo ` .
  ```
  ibmcloud ks cluster-addon-enable istio-sample-bookinfo --cluster <cluster_name_or_ID>
  ```
  {: pre}

4. Verifique se os complementos do Istio gerenciados que você instalou estão ativados nesse cluster.
  ```
  ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Saída de exemplo:
  ```
  Name                      Version
  istio                     1.0.5
  istio-extras              1.0.5
  istio-sample-bookinfo     1.0.5
  ```
  {: screen}

5. Também é possível verificar os componentes individuais de cada complemento em seu cluster.
  - Componentes de `istio` e `istio-extras`: assegure-se de que os serviços do Istio e seus pods correspondentes sejam implementados.
    ```
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```
    NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP                                                                    AGE
    grafana                  ClusterIP      172.21.98.154    <none>          3000/TCP                                                       2m
    istio-citadel            ClusterIP      172.21.221.65    <none>          8060/TCP,9093/TCP                                              2m
    istio-egressgateway      ClusterIP      172.21.46.253    <none>          80/TCP,443/TCP                                                 2m
    istio-galley             ClusterIP      172.21.125.77    <none>          443/TCP,9093/TCP                                               2m
    istio-ingressgateway     LoadBalancer   172.21.230.230   169.46.56.125   80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,
                                                                              8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP   2m
    istio-pilot              ClusterIP      172.21.171.29    <none>          15010/TCP,15011/TCP,8080/TCP,9093/TCP                          2m
    istio-policy             ClusterIP      172.21.140.180   <none>          9091/TCP,15004/TCP,9093/TCP                                    2m
    istio-sidecar-injector   ClusterIP      172.21.248.36    <none>          443/TCP                                                        2m
    istio-telemetry          ClusterIP      172.21.204.173   <none>          9091/TCP,15004/TCP,9093/TCP,42422/TCP                          2m
    jaeger-agent             ClusterIP      None             <none>          5775/UDP,6831/UDP,6832/UDP                                     2m
    jaeger-collector         ClusterIP      172.21.65.195    <none>          14267/TCP,14268/TCP                                            2m
    jaeger-query             ClusterIP      172.21.171.199   <none>          16686/TCP                                                      2m
    kiali                    ClusterIP      172.21.13.35     <none>          20001/TCP                                                      2m
    prometheus               ClusterIP      172.21.105.229   <none>          9090/TCP                                                       2m
    tracing                  ClusterIP      172.21.125.177   <none>          80/TCP                                                         2m
    zipkin                   ClusterIP      172.21.1.77      <none>          9411/TCP                                                       2m
    ```
    {: screen}

    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                      READY   STATUS    RESTARTS   AGE
    grafana-76dcdfc987-94ldq                  1/1     Running   0          2m
    istio-citadel-869c7f9498-wtldz            1/1     Running   0          2m
    istio-egressgateway-69bb5d4585-qxxbp      1/1     Running   0          2m
    istio-galley-75d7b5bdb9-c9d9n             1/1     Running   0          2m
    istio-ingressgateway-5c8764db74-gh8xg     1/1     Running   0          2m
    istio-pilot-55fd7d886f-vv6fb              2/2     Running   0          2m
    istio-policy-6bb6f6ddb9-s4c8t             2/2     Running   0          2m
    istio-sidecar-injector-7d9845dbb7-r8nq5   1/1     Running   0          2m
    istio-telemetry-7695b4c4d4-tlvn8          2/2     Running   0          2m
    istio-tracing-55bbf55878-z4rd2            1/1     Running   0          2m
    kiali-77566cc66c-kh6lm                    1/1     Running   0          2m
    prometheus-5d5cb44877-lwrqx               1/1     Running   0          2m
    ```
    {: screen}

  - Componentes de `istio-sample-bookinfo`: assegure-se de que os microsserviços de BookInfo e seus pods correspondentes sejam implementados.
    ```
    kubectl get svc -n default
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         2m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         2m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         2m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         2m
    ```
    {: screen}

    ```
    kubectl get pods -n default
    ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

### Instalando complementos de Istio gerenciados na IU
{: #istio_install_ui}

1. Em seu [painel do cluster ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/containers-kubernetes/clusters), clique no nome de um cluster da versão 1.10 ou mais recente.

2. Clique na guia  ** Complementos ** .

3. No cartão Istio, clique em  ** Instalar **.

4. A caixa de seleção **Istio** já está selecionada. Para instalar também o aplicativo de amostra Istio extras e BookInfo, selecione as caixas de seleção **Istio Extras** e **Amostra Istio**.

5. Clique em **Instalar**.

6. No cartão Istio, verifique se os complementos que você ativou estão listados.

Em seguida, é possível experimentar os recursos do Istio verificando o [app de amostra BookInfo](#istio_bookinfo).

<br />


## Tentando o app de amostra BookInfo
{: #istio_bookinfo}

O complemento BookInfo (`istio-sample-bookinfo`) implementa o [aplicativo de amostra BookInfo para o Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/examples/bookinfo/) no namespace `default`. Essa implementação inclui a configuração de demo de base e as regras de destino padrão para que seja possível experimentar os recursos do Istio imediatamente.
{: shortdesc}

Os quatro microsserviços de BookInfo incluem:
* `productpage` chama os microsserviços `details` e `reviews` para preencher a página.
* `details` contém informações sobre o manual.
* `reviews` contém revisões de livro e chama o microsserviço `ratings`.
* `ratings` contém informações de classificação de livro que acompanham uma revisão de livro.

O microsserviço  ` revisões `  tem várias versões:
* `v1` não chama o microsserviço `ratings`.
* `v2` chama o microsserviço `ratings` e exibe classificações como 1 a 5 estrelas pretas.
* `v3` chama o microsserviço `ratings` e exibe classificações como 1 a 5 estrelas vermelhas.

Os YAMLs de implementação para cada um desses microsserviços são modificados para que os proxies do sidecar do Envoy sejam pré-injetados como contêineres nos pods de microsserviços antes de serem implementados. Para obter mais informações sobre a injeção de sidecar manual, consulte a [Documentação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/setup/kubernetes/sidecar-injection/). O aplicativo BookInfo também já está exposto em um endereço IP público do Ingress por um gateway do Istio. Observe que, embora o aplicativo BookInfo possa ajudá-lo a iniciar, ele não é destinado ao uso de produção.

Antes de iniciar, [instale os complementos gerenciados `istio`, `istio-extras` e `istio-sample-bookinfo`](#istio_install) em um cluster.

1. Obtenha o endereço público de seu cluster.
  * Clusters padrão:
      2. Configure o host do ingresso.
        ```
        export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
        ```
        {: pre}

      3. Configure a porta de ingresso.
        ```
        export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name == "http2 ") ] .port } ')
        ```
        {: pre}

      4. Crie uma variável de ambiente `GATEWAY_URL` que use o host e a porta do ingresso.
         ```
         export GATEWAY_URL = $INGRESS_HOST: $INGRESS_PORT
         ```
         {: pre}

  * Clusters grátis:
      1. Configure o host do ingresso. Esse host é o endereço IP público de qualquer nó do trabalhador em seu cluster.
        ```
        export INGRESS_HOST = $(kubectl get nodes -o jsonpath='{0}] .status.addresses [? (@.type == "ExternalIP ") ] .address } ')
        ```
        {: pre}

      2. Configure a porta de ingresso.
        ```
        export INGRESS_PORT=$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
        ```
        {: pre}

      3. Crie uma variável de ambiente GATEWAY_URL que use o endereço IP público do nó do trabalhador e um NodePort.
         ```
         export GATEWAY_URL = $INGRESS_HOST: $INGRESS_PORT
         ```
         {: pre}

2. Execute curl para a variável `GATEWAY_URL` para verificar se o app BookInfo está em execução. Uma resposta `200` significa que o app BookInfo está sendo executado adequadamente com o Istio.
   ```
   curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
   ```
   {: pre}

3.  Visualize a página da web do BookInfo em um navegador.

    Para Mac OS ou Linux:
    ```
    open http:// $GATEWAY_URL/productpage
    ```
    {: pre}

    Para o Windows:
    ```
    start http:// $GATEWAY_URL/productpage
    ```
    {: pre}

4. Tente atualizar a página várias vezes. Versões diferentes da seção de revisões executam round robin entre estrelas vermelhas, estrelas pretas e nenhuma estrela.

### Entendendo o que aconteceu
{: #istio_bookinfo_understanding}

O BookInfo de amostra demonstra como três componentes de gerenciamento de tráfego do Istio trabalham juntos para rotear o tráfego de ingresso para o app.
{: shortdesc}

<dl>
<dt>`Gateway `</dt>
<dd>O `bookinfo-gateway` [Gateway ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway) descreve um balanceador de carga, o serviço `istio-ingressgateway` no namespace `istio-system`, que age como o ponto de entrada do ingresso para o tráfego HTTP/TCP para o BookInfo. O Istio configura o balanceador de carga para atender solicitações recebidas nos apps gerenciados pelo Istio nas portas que estão definidas no arquivo de configuração de gateway.
</br></br>Para ver o arquivo de configuração para o gateway BookInfo, execute o comando a seguir.
<pre class="pre"><code> kubectl get gateway bookinfo-gateway -o yaml </code></pre></dd>

<dt>` VirtualService `</dt>
<dd>O `bookinfo` [`VirtualService` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService) define as regras que controlam como as solicitações são roteadas dentro da malha de serviços definindo microsserviços como `destinations`. No serviço virtual `bookinfo`, o URI `/productpage` de uma solicitação é roteado para o host `productpage` na porta `9080`. Dessa maneira, todas as solicitações para o aplicativo BookInfo são roteadas primeiro para o microsserviço `productpage`, que, em seguida, chama os outros microsserviços do BookInfo.
</br></br>Para ver a regra de serviço virtual que é aplicada a BookInfo, execute o comando a seguir.
<pre class="pre"><code> kubectl get virtualservice bookinfo -o yaml </code></pre></dd>

<dt>` DestinationRule `</dt>
<dd>Depois que o gateway roteia a solicitação de acordo com a regra de serviço virtual, os `details`, `productpage`, `ratings`, `reviews` e [`DestinationRules` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#DestinationRule) definem políticas que são aplicadas à solicitação quando ela atinge um microsserviço. Por exemplo, quando você atualiza a página do produto BookInfo, as mudanças que você vê são o resultado do microsserviço `productpage` aleatoriamente chamando versões diferentes, `v1`, `v2` e `v3`, do microsserviço `reviews`. As versões são selecionadas aleatoriamente porque a regra de destino `reviews` fornece peso igual para os `subsets` ou as versões nomeadas do microsserviço. Esses subconjuntos são usados pelas regras de serviço virtual quando o tráfego é roteado para versões específicas do serviço.
</br></br>Para ver as regras de destino que são aplicadas a BookInfo, execute o comando a seguir.
<pre class="pre"><code> kubectl describe destinationrules </code></pre></dd>
</dl>

</br>

Em seguida, é possível [expor o BookInfo usando o subdomínio Ingress fornecido pela IBM](#istio_expose_bookinfo) ou [registrar, monitorar, rastrear e visualizar](#istio_health) a malha de serviços para o aplicativo BookInfo.

<br />


## Criação de log, monitoramento, rastreio e visualização do Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_health}

Para registrar, monitorar, rastrear e visualizar seus apps gerenciados pelo Istio no {{site.data.keyword.containerlong_notm}}, é possível ativar os painéis Grafana, Jaeger e Kiali instalados no complemento `istio-extras` ou implementar LogDNA e Sysdig como serviços de terceiros para os nós do trabalhador.
{: shortdesc}

### Ativando os painéis do Grafana, do Jaeger e do Kiali
{: #istio_health_extras}

Os complementos extras do Istio (`istio-extras`) instalam o [Grafana ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://grafana.com/), o [Jaeger ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.jaegertracing.io/) e o [Kiali ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.kiali.io/). Ative os painéis para cada um desses serviços para fornecer monitoramento, rastreio e visualização extras para o Istio.
{: shortdesc}

Antes de iniciar, [instale os complementos gerenciados `istio` e `istio-extras`](#istio_install) em um cluster.

**Grafana**</br>
1. Inicie o encaminhamento de porta do Kubernetes para o painel Grafana.
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
  ```
  {: pre}

2. Para abrir o painel Grafana do Istio, acesse a URL a seguir: http://localhost:3000/dashboard/db/istio-mesh-dashboard. Se você instalou o [complemento BookInfo](#istio_bookinfo), o painel do Istio mostrará as métricas para o tráfego que você gerou quando atualizou a página do produto algumas vezes. Para obter mais informações sobre como usar o painel Grafana do Istio, consulte [Visualizando o painel do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/tasks/telemetry/using-istio-dashboard/) na documentação de software livre do Istio.

** Jaeger **</br>
1. Inicie o encaminhamento de porta do Kubernetes para o painel Jaeger.
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &
  ```
  {: pre}

2. Para abrir a IU do Jaeger, acesse a URL a seguir: http://localhost:16686.

3. Se você instalou o [complemento BookInfo](#istio_bookinfo), será possível selecionar `productpage` na lista de **Serviços** e clicar em **Localizar rastreios**. Os rastreios para o tráfego que você gerou ao atualizar a página do produto algumas vezes são mostrados. Para obter mais informações sobre como usar o Jaeger com o Istio, consulte [Gerando rastreios usando a amostra BookInfo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/tasks/telemetry/distributed-tracing/#generating-traces-using-the-bookinfo-sample) na documentação de software livre do Istio.

** Kiali **</br>
1. Inicie o encaminhamento de porta do Kubernetes para o painel Kiali.
  ```
  kubectl -n istio-forward port-forward $(kubectl -n istio-system get pod -l app=kiali -o jsonpath='{.items[0 ] .metadata.name } ') 20001:20001 &
  ```
  {: pre}

2. Para abrir a IU do Kiali, acesse a URL a seguir: http://localhost:20001.

3. Insira `admin` para o nome do usuário e a passphrase. Para obter mais informações sobre como usar o Kiali para visualizar seus microsserviços gerenciados pelo Istio, consulte [Gerando um gráfico de serviço ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/tasks/telemetry/kiali/#generating-a-service-graph) na documentação de software livre do Istio.

### Configurando a criação de log com o  {{site.data.keyword.la_full_notm}}
{: #istio_health_logdna}

Gerenciar logs de forma ininterrupta para seu contêiner de app e o contêiner sidecar do proxy Envoy em cada pod implementando o LogDNA nos nós do trabalhador para encaminhar logs para o {{site.data.keyword.loganalysislong}}.
{: shortdesc}

Para usar o [{{site.data.keyword.la_full}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about), você implementa um agente de criação de log para cada nó do trabalhador em seu cluster. Esse agente coleta logs com a extensão `*.log ` e arquivos sem extensão que são armazenados no diretório `/var/log` de seu pod de todos os namespaces, incluindo `kube-system` Esses logs incluem logs de seu contêiner de app e do contêiner sidecar de proxy do Envoy em cada pod. Em seguida, o agente encaminha os logs para o serviço {{site.data.keyword.la_full_notm}}.

Para iniciar, configure o LogDNA para seu cluster seguindo as etapas em [Gerenciando logs de cluster Kubernetes com o {{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube).




### Configurando o monitoramento com o {{site.data.keyword.mon_full_notm}}
{: #istio_health_sysdig}

Obtenha visibilidade operacional no desempenho e funcionamento de seus apps gerenciados pelo Istio implementando o Sysdig em seus nós do trabalhador para encaminhar métricas para o {{site.data.keyword.monitoringlong}}.
{: shortdesc}

Com o Istio on {{site.data.keyword.containerlong_notm}}, o complemento `istio` gerenciado instala o Prometheus em seu cluster. Os pods `istio-mixer-telemetry` em seu cluster são anotados com um terminal Prometheus para que o Prometheus possa agregar todos os dados de telemetria para seus pods. Ao implementar um agente Sysdig para cada nó trabalhador em seu cluster, o Sysdig já está ativado automaticamente para detectar e extrair os dados desses terminais Prometheus para exibi-los no painel de monitoramento do {{site.data.keyword.Bluemix_notm}}.

Como todo o trabalho da Prometheus é feito, tudo o que resta para você é implementar o Sysdig em seu cluster.

1. Configure a Sysdig seguindo as etapas em [Analisando métricas para um app implementado em um cluster Kubernetes](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster).

2. [Ative a IU do Sysdig ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster_step3).

3. Clique em  ** Incluir novo painel **.

4. Procure por `Istio` e selecione um dos painéis Istio predefinidos do Sysdig.

Para obter mais informações sobre como referenciar as métricas e os painéis, monitorar os componentes internos do Istio e monitorar as implementações e as implementações canárias A/B do Istio, consulte a postagem do blog do Sysdig [Como monitorar o Istio, a malha de serviços do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://sysdig.com/blog/monitor-istio/). Procure a seção chamada "Monitorando o Istio: métricas e painéis de referência".

<br />


## Configurando a injeção de sidecar para seus apps
{: #istio_sidecar}

Pronto para gerenciar seus próprios apps usando o Istio? Antes de implementar seu app, deve-se primeiro decidir como você deseja injetar os sidecars de proxy do Envoy nos pods do app.
{: shortdesc}

Cada pod de app deve estar executando um sidecar de proxy do Envoy para que os microsserviços possam ser incluídos na malha de serviços. É possível assegurar que os sidecars sejam injetados em cada pod de app automaticamente ou manualmente. Para obter mais informações sobre a injeção de sidecar, consulte a [Documentação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/setup/kubernetes/sidecar-injection/).

### Ativando a injeção de sidecar automática
{: #istio_sidecar_automatic}

Quando a injeção de sidecar automática está ativada, um namespace atende qualquer nova implementação e modifica automaticamente os YAMLs de implementação para incluir os sidecars. Ative a injeção de sidecar automática para um namespace quando planejar implementar múltiplos apps que você deseja integrar com o Istio nesse namespace. Observe que a injeção de sidecar automática não está ativada para nenhum namespace por padrão no complemento gerenciado do Istio.

Para ativar a injeção de sidecar automática para um namespace:

1. Obtenha o nome do namespace no qual você deseja implementar apps gerenciados pelo Istio.
  ```
  kubectl get namespaces
  ```
  {: pre}

2. Rotule o namespace como `istio-injection=enabled`.
  ```
  kubectl label namespace < namespace> istio-injection=enabled
  ```
  {: pre}

3. Implemente apps no namespace rotulado ou reimplemente apps que já estão no namespace.
  * Para implementar um app no namespace rotulado:
    ```
    kubectl apply <myapp>.yaml --namespace <namespace>
    ```
    {: pre}
  * Para reimplementar um app que já está implementado nesse namespace, exclua o pod do app para que ele seja reimplementado com o sidecar injetado.
    ```
    kubectl delete pod -l app=<myapp>
    ```
    {: pre}

5. Se você não tiver criado um serviço para expor seu app, crie um serviço do Kubernetes. Seu app deve ser exposto por um serviço do Kubernetes para ser incluído como um microsserviço na malha de serviço Istio. Assegure-se de seguir os [requisitos do Istio para pods e serviços ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/setup/kubernetes/spec-requirements/).

  1. Defina um serviço para o app.
    ```
    apiVersion: v1 kind: Service metadata: name: myappservice spec: selector: <selector_key>: <selector_value> ports:
       - protocol: TCP
         port: 8080
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Entendendo os componentes de arquivo YAML do serviço</th>
    </thead>
    <tbody>
    <tr>
    <td><code>seletor</code></td>
    <td>Insira a chave de etiqueta (<em>&lt;selector_key&gt;</em>) e o par de valores (<em>&lt;selector_value&gt;</em>) que você deseja usar para destinar os pods nos quais o seu app é executado.</td>
     </tr>
     <tr>
     <td><code>port</code></td>
     <td>A porta na qual o serviço atende.</td>
     </tr>
     </tbody></table>

  2. Crie o serviço em seu cluster. Assegure-se de que o serviço seja implementado no mesmo namespace que o app.
    ```
    kubectl aplica -f myappservice.yaml -n < namespace>
    ```
    {: pre}

Os pods de app são agora integrados à sua malha de serviço Istio porque eles têm o contêiner sidecar do Istio em execução ao lado do contêiner de app.

### Injeção manual de sidecars
{: #istio_sidecar_manual}

Se você não desejar ativar a injeção de sidecar automática em um namespace, será possível injetar manualmente o sidecar em um YAML de implementação. Injete os sidecars manualmente quando os apps estiverem em execução em namespaces juntamente com outras implementações nas quais você não deseja que os sidecars sejam injetados automaticamente.

Para injetar os sidecars manualmente em uma implementação:

1. Faça download do cliente  ` istioctl ` .
  ```
  curl -L https://git.io/getLatestIstio | sh -
  ```

2. Navegue para o diretório do pacote Istio.
  ```
  cd istio-1.0.6
  ```
  {: pre}

3. Injete o sidecar do Envoy no YAML de implementação do app.
  ```
  istioctl kube-inject -f <myapp>.yaml | kubectl apply -f -
  ```
  {: pre}

4. Implemente seu app.
  ```
  kubectl apply < myapp> .yaml
  ```
  {: pre}

5. Se você não tiver criado um serviço para expor seu app, crie um serviço do Kubernetes. Seu app deve ser exposto por um serviço do Kubernetes para ser incluído como um microsserviço na malha de serviço Istio. Assegure-se de seguir os [requisitos do Istio para pods e serviços ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/setup/kubernetes/spec-requirements/).

  1. Defina um serviço para o app.
    ```
    apiVersion: v1 kind: Service metadata: name: myappservice spec: selector: <selector_key>: <selector_value> ports:
       - protocol: TCP
         port: 8080
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Entendendo os componentes de arquivo YAML do serviço</th>
    </thead>
    <tbody>
    <tr>
    <td><code>seletor</code></td>
    <td>Insira a chave de etiqueta (<em>&lt;selector_key&gt;</em>) e o par de valores (<em>&lt;selector_value&gt;</em>) que você deseja usar para destinar os pods nos quais o seu app é executado.</td>
     </tr>
     <tr>
     <td><code>port</code></td>
     <td>A porta na qual o serviço atende.</td>
     </tr>
     </tbody></table>

  2. Crie o serviço em seu cluster. Assegure-se de que o serviço seja implementado no mesmo namespace que o app.
    ```
    kubectl aplica -f myappservice.yaml -n < namespace>
    ```
    {: pre}

Os pods de app são agora integrados à sua malha de serviço Istio porque eles têm o contêiner sidecar do Istio em execução ao lado do contêiner de app.

<br />


## Expondo apps gerenciados pelo Istio usando o subdomínio do Ingress fornecido pela IBM
{: #istio_expose}

Depois de [configurar a injeção do sidecar de proxy do Envoy](#istio_sidecar) e implementar seus apps na malha de serviços do Istio, é possível expor seus apps gerenciados pelo Istio para solicitações públicas usando o subdomínio do Ingress fornecido pela IBM.
{: shortdesc}

O ALB do {{site.data.keyword.containerlong_notm}} usa os recursos do Kubernetes Ingress para controlar como o tráfego é roteado para seus apps. No entanto, Istio usa [Gateways ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway) e [VirtualServices ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService) para controlar como o tráfego é roteado para seus apps. Um gateway configura um balanceador de carga que age como o ponto de entrada para seus apps gerenciados pelo Istio. Os serviços virtuais definem as regras de roteamento para que o tráfego seja encaminhado corretamente para seus microsserviços de app.

Em clusters padrão, um subdomínio do Ingress fornecido pela IBM é designado automaticamente ao seu cluster para que seja possível expor publicamente seus apps. É possível aproveitar a entrada DNS para esse subdomínio para expor seus apps gerenciados pelo Istio conectando o ALB padrão do {{site.data.keyword.containerlong_notm}} ao gateway de ingresso do Istio.

É possível tentar o [exemplo para expor o BookInfo usando o subdomínio do Ingress fornecido pela IBM](#istio_expose_bookinfo) primeiro ou [expor publicamente seus próprios apps gerenciados pelo Istio, conectando o gateway do Istio e o ALB do Ingress](#istio_expose_link).

### Exemplo: expondo o BookInfo usando o subdomínio do Ingress fornecido pela IBM
{: #istio_expose_bookinfo}

Ao ativar o [complemento BookInfo](#istio_bookinfo) em seu cluster, o gateway do Istio `bookinfo-gateway` é criado para você. O gateway usa as regras de serviço virtual e de destino do Istio para configurar um balanceador de carga, `istio-ingressgateway`, que expõe publicamente o app BookInfo. Nas etapas a seguir, você cria um recurso Ingress do Kubernetes que encaminha as solicitações recebidas para o ALB do Ingress do {{site.data.keyword.containerlong_notm}} para o balanceador de carga `istio-ingressgateway`.
{: shortdesc}

Antes de iniciar, [ative os complementos gerenciados `istio` e `istio-sample-bookinfo`](#istio_install) em um cluster.

1. Obtenha o subdomínio do Ingress fornecido pela IBM para seu cluster. Se você desejar usar o TLS, anote também o segredo do TLS do Ingress fornecido pela IBM na saída.
  ```
  ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
  ```
  {: pre}

  Saída de exemplo:
  ```
  Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
  Ingress Secret:         mycluster-12345
  ```
  {: screen}

2. Crie um recurso do Ingresso. O {{site.data.keyword.containerlong_notm}} ALB usa as regras definidas neste recurso para encaminhar o tráfego para o balanceador de carga Istio que expõe o seu aplicativo Istio-gerenciado.
  ```
  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    name: myingressresource
    namespace: istio-system
  spec:
    tls:
    - hosts:
      - bookinfo.<IBM-ingress-domain>
      secretName: <tls_secret_name>
    rules:
    - host: bookinfo.<IBM-ingress-domain>
      http:
        paths:
        - path: /
          backend:
            serviceName: istio-ingressgateway
            servicePort: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code> tls.hosts </code></td>
  <td>Para usar o TLS, substitua <em>&lt;IBM-ingress-domain&gt;</em> pelo subdomínio Ingress fornecido pela IBM. Observe que `bookinfo` é pré-anexado ao seu subdomínio de Ingress fornecido pela IBM. O curinga do subdomínio Ingress fornecidos pela IBM, <code> *.&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>, é registrado por padrão para seu cluster.</td>
  </tr>
  <tr>
  <td><code> tls.secretName </code></td>
  <td>Substitua <em>&lt;tls_secret_name&gt;</em> pelo nome do segredo de Ingress fornecido pela IBM. O certificado TLS fornecido pela IBM é um certificado curinga e pode ser usado para o subdomínio curinga.<td>
  </tr>
  <tr>
  <td><code>host</code></td>
  <td>Substitua <em>&lt;IBM-ingress-domain&gt;</em> pelo subdomínio do Ingress fornecido pela IBM. Observe que `bookinfo` é pré-anexado ao seu subdomínio de Ingress fornecido pela IBM.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Observe que o nome do serviço é <code>istio-ingressgateway</code> para que o ALB encaminhe solicitações desse subdomínio para o serviço de balanceador de carga do Istio.</td>
  </tr>
  </tbody></table>

3. Crie o recurso Ingress.
  ```
  kubectl aplicar -f myingressresource.yaml -n istio-system
  ```
  {: pre}

4. Em um navegador da web, abra a página do produto BookInfo.
  - Se você ativou o TLS:
    ```
    https://bookinfo. < IBM-ingress-domain> /productpage
    ```
    {: codeblock}
  - Se você não ativou o TLS:
    ```
    http://bookinfo. < IBM-ingress-domain> /productpage
    ```
    {: codeblock}

5. Tente atualizar a página várias vezes. As solicitações para  ` http://bookinfo.<IBM-domain>/productpage` são recebidos pelo ALB e são encaminhados para o balanceador de carga de gateway do Istio. As diferentes versões do microsserviço `reviews` ainda são retornadas aleatoriamente porque o gateway do Istio gerencia as regras de serviço virtual e de roteamento de destino para microsserviços.

Para obter mais informações sobre o gateway, as regras de serviço virtual e as regras de destino para o app BookInfo, consulte [Entendendo o que aconteceu](#istio_bookinfo_understanding).

### Expondo publicamente seus próprios apps gerenciados pelo Istio conectando o gateway do Istio e o ALB do Ingress
{: #istio_expose_link}

Use o subdomínio do Ingress fornecido pela IBM para seus apps gerenciados pelo Istio conectando o gateway do Istio e o {{site.data.keyword.containerlong_notm}} ALB. As etapas a seguir mostram como configurar um gateway do Istio, criar um serviço virtual que define regras de gerenciamento de tráfego para seus serviços gerenciados pelo Istio e configurar seu ALB do Ingress do {{site.data.keyword.containerlong_notm}} para que ele direcione o tráfego de seu subdomínio do Ingress fornecido pela IBM para o balanceador de carga `istio-ingressgateway`.
{: shortdesc}

Antes de iniciar:
1. [Instale o complemento gerenciado `istio`](#istio_install) em um cluster.
2. Instale o cliente  ` istioctl ` .
  1. Faça download de  ` istioctl `.
    ```
    curl -L https://git.io/getLatestIstio | sh -
    ```
  2. Navegue para o diretório do pacote Istio.
    ```
    cd istio-1.0.6
    ```
    {: pre}
3. [Configure a injeção de sidecar para seus microsserviços de app, implemente os microsserviços de app em um namespace e crie serviços do Kubernetes para os microsserviços de app para que eles possam ser incluídos na malha de serviços do Istio](#istio_sidecar).

Para conectar o gateway do Istio e o {{site.data.keyword.containerlong_notm}} ALB:

1. Crie um gateway. Esse gateway de amostra usa o serviço de balanceador de carga `istio-ingressgateway` para expor a porta 80 para HTTP. Substitua `<namespace>` com o namespace no qual os microsserviços gerenciados pelo Istio são implementados. Se os microsserviços atendem em uma porta diferente de `80`, inclua essa porta. Para obter mais informações sobre os componentes YAML do gateway, consulte a [documentação de referência do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway).
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: Gateway
  metadata:
    name: my-gateway
    namespace: <namespace>
  spec:
    selector:
      istio: ingressgateway
    servers:
    - port:
        name: http
        number: 80
        protocol: HTTP
      hosts:
      - '*'
  ```
  {: codeblock}

2. Aplique o gateway no namespace no qual os microsserviços gerenciados pelo Istio são implementados.
  ```
  kubectl apply -f my-gateway.yaml -n <namespace>
  ```
  {: pre}

3. Crie um serviço virtual que use o gateway `my-gateway` e defina as regras de roteamento para os microsserviços do app. Para obter mais informações sobre os componentes YAML do serviço virtual, consulte a [documentação de referência do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService).

  Se você já expõe seu microsserviço usando o ALB do {{site.data.keyword.containerlong_notm}}, o Istio fornecerá uma ferramenta conversora como parte do cliente `istioctl` que pode ajudar a migrar as definições de recurso do Ingress para os serviços virtuais correspondentes. A ferramenta do conversor [ `istioctl` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/commands/istioctl/#istioctl-experimental-convert-ingress) converte os recursos do Ingress em serviços virtuais em uma base de melhor esforço. Observe que as anotações do Ingress não são convertidas porque o gateway do Istio não usa as anotações do Ingress. A saída é um ponto de início para a configuração de ingresso do Istio e pode requerer algumas modificações. Para usar a ferramenta, execute o comando a seguir: `istioctl experimental convert-ingress -f <existing_ingress_resource>.yaml > my-virtual-service.yaml`
  {: tip}

  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    name: my-virtual-service
    namespace: <namespace>
  spec:
    gateways:
    - my-gateway
    hosts:
    - '*'
    http:
    - match:
      - uri:
          exact: /<service_path>
      route:
      - destination:
          host: <service_name>
          port:
            number: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code> namespace</code></td>
  <td>Substitua <em>&lt;namespace&gt;</em> pelo namespace no qual os microsserviços gerenciados por Istio são implementados.</td>
  </tr>
  <tr>
  <td><code>gateways</code></td>
  <td>Observe que <code>my-gateway</code> é especificado para que o gateway possa aplicar essas regras de roteamento de serviço virtual para o balanceador de carga do Istio.<td>
  </tr>
  <tr>
  <td><code> http.match.uri.exato </code></td>
  <td>Substitua <em>&lt;service_path&gt;</em> pelo caminho em que seu microsserviço de ponto de entrada atenderá. Por exemplo, no aplicativo BookInfo, o caminho é definido como <code>/productpage</code>.</td>
  </tr>
  <tr>
  <td><code> http.route.destination.host </code></td>
  <td>Substitua <em>&lt;service_name&gt;</em> pelo nome de seu microsserviço de ponto de entrada. Por exemplo, no aplicativo BookInfo, <code>productpage</code> serviu como o microsserviço de ponto de entrada que chamou os outros microsserviços de app.</td>
  </tr>
  <tr>
  <td><code> http.route.destination.port.number </code></td>
  <td>Se seu microsserviço atenda em uma porta diferente, substitua <em>&lt;80&gt;</em> pela porta.</td>
  </tr>
  </tbody></table>

4. Aplique as regras de serviço virtual no namespace no qual o microsserviço gerenciado pelo Istio está implementado.
  ```
  kubectl apply -f my-virtual-service.yaml -n <namespace>
  ```
  {: pre}

5. Opcional: Para criar regras que são aplicadas após o tráfego ser roteado para cada microsserviço, como regras para enviar tráfego para versões diferentes de um microsserviço, é possível criar e aplicar [`DestinationRules` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#DestinationRule).

6. Crie um arquivo de recursos de Ingresso. O ALB do {{site.data.keyword.containerlong_notm}} usa as regras definidas nesse recurso de amostra para encaminhar o tráfego para o balanceador de carga Istio que expõe seu microsserviço gerenciado pelo Istio.
  ```
  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    name: my-ingress-resource
    namespace: istio-system
  spec:
    rules:
    - host: <sub-domain>.<IBM-ingress-domain>
      http:
        paths:
        - path: /
          backend:
            serviceName: istio-ingressgateway
            servicePort: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>host</code></td>
  <td>Substitua <em>&lt;sub-domain&gt;</em> por um subdomínio para seu app e <em>&lt;IBM-ingress-domain&gt;</em> pelo subdomínio do Ingress fornecido pela IBM. É possível localizar o subdomínio do Ingress fornecido pela IBM para seu cluster executando <code>ibmcloud ks cluster-get --cluster &lt;cluster_name_or_ID&gt;</code>. Seu subdomínio escolhido é registrado automaticamente porque o curinga do subdomínio do Ingress fornecido pela IBM, <code>*.&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>, é registrado como padrão para o seu cluster.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Observe que <code>istio-ingressgateway</code> está especificado para que o ALB encaminha solicitações recebidas para o serviço de balanceador de carga do Istio.</td>
  </tr>
  </tbody></table>

7. Aplique o recurso Ingress no namespace no qual os microsserviços gerenciados por Istio são implementados.
  ```
  kubectl aplica -f my-ingresso-resource.yaml -n < namespace>
  ```
  {: pre}

8. Em um navegador da web, verifique se o tráfego está sendo roteado para os microsserviços gerenciados pelo Istio inserindo a URL do microsserviço do aplicativo para acessar.
  ```
  http://<subdomain>.<IBM-ingress-domain>/<service_path>
  ```
  {: codeblock}

<br />


## Desinstalando o Istio no  {{site.data.keyword.containerlong_notm}}
{: #istio_uninstall}

Se você tiver concluído o trabalho com o Istio, será possível limpar os recursos do Istio em seu cluster, desinstalando os complementos do Istio.
{:shortdesc}

Observe que o complemento `istio` é uma dependência para os complementos `istio-extras`, `istio-sample-bookinfo` e [`knative`](/docs/containers?topic=containers-knative_tutorial). O complemento `istio-extras` é uma dependência para o complemento `istio-sample-bookinfo`.

### Desinstalando complementos do Istio gerenciados na CLI
{: #istio_uninstall_cli}

1. Desative o complemento  ` istio-sample-bookinfo ` .
  ```
  ibmcloud ks cluster-addon-disable istio-sample-bookinfo --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Desative o complemento  ` istio-extras ` .
  ```
  ibmcloud ks cluster-addon-disable istio-extras --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Desative o  ` istio `  add-on.
  ```
  ibmcloud ks cluster-addon-disable istio --cluster <cluster_name_or_ID> -f
  ```
  {: pre}

4. Verifique se todos os complementos do Istio gerenciados estão desativados neste cluster. Nenhum complemento do Istio é retornado na saída.
  ```
  ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
  ```
  {: pre}

### Desinstalando Complementos de Istio Gerenciados na UI
{: #istio_uninstall_ui}

1. Em seu [painel do cluster ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/containers-kubernetes/clusters), clique no nome de um cluster da versão 1.10 ou mais recente.

2. Clique na guia  ** Complementos ** .

3. No cartão do Istio, clique no ícone de menu.

4. Desinstale o individual ou todos os complementos do Istio.
  - Individual Istio add-ons:
    1. Clique em  ** Atualizar **.
    2. Desmarque as caixas de seleção para os complementos que você deseja desativar. Se você limpar um complemento, outros complementos que requerem esse complemento como uma dependência podem ser limpos automaticamente.
    3. Clique em  ** Atualizar **. Os complementos do Istio são desativados e os recursos para esses complementos são removidos desse cluster.
  - Todos os complementos do Istio:
    1. Clique em  ** Desinstalar **. Todos os complementos do Istio gerenciados são desativados nesse cluster e todos os recursos do Istio nesse cluster são removidos.

5. No cartão Istio, verifique se os complementos que você desinstalou não são mais listados.

<br />


### Desinstalando outras instalações do Istio em seu cluster
{: #istio_uninstall_other}

Se você instalou anteriormente o Istio no cluster usando o gráfico do Helm da IBM ou por meio de outro método, limpe a instalação do Istio antes de ativar os complementos do Istio gerenciados no cluster. Para verificar se o Istio já está em um cluster, execute `kubectl get namespaces` e procure o namespace `istio-system` na saída.
{: shortdesc}

- Se você instalou o Istio usando o gráfico do Helm do {{site.data.keyword.Bluemix_notm}} Istio:
  1. Desinstale a implementação do Istio Helm.
    ```
    helm del istio -- purge
    ```
    {: pre}

  2. Se você usou o Helm 2.9 ou anterior, exclua o recurso de tarefa extra.
    ```
    kubectl -n istio-system delete job -- all
    ```
    {: pre}

- Se você instalou o Istio manualmente ou usou o gráfico do Helm da comunidade Istio, consulte a [documentação de desinstalação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/setup/kubernetes/quick-start/#uninstall-istio-core-components).
* Se você instalou o BookInfo anteriormente no cluster, limpe esses recursos.
  1. Mude o diretório para o local do arquivo Istio.
    ```
    cd < filepath> /istio-1.0.5
    ```
    {: pre}

  2. Exclua todos os serviços, pods e implementações do BookInfo no cluster.
    ```
    samples / bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

## O que Vem a Seguir?
{: #istio_next}

* Para explorar o Istio ainda mais, é possível localizar mais guias na [documentação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/).
    * [Roteamento inteligente ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/guides/intelligent-routing.html): este exemplo mostra como rotear o tráfego para uma versão específica de microsserviços de revisões e classificações do BookInfo usando recursos de gerenciamento de tráfego do Istio.
    * [Telemetria detalhada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/guides/telemetry.html): este exemplo inclui como obter métricas, logs e rastreios uniformes ao longo de microsserviços do BookInfo usando o Istio Mixer e o proxy do Envoy.
* Faça a [Classe cognitiva: introdução aos microsserviços com o Istio e o IBM Cloud Kubernetes Service ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Nota**: é possível ignorar a seção de instalação do Istio desse curso.
* Consulte essa postagem do blog sobre como usar o [Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) para visualizar sua malha de serviços do Istio.
