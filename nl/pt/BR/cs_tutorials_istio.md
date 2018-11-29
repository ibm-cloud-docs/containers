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



# Tutorial: Instalando o Istio no {{site.data.keyword.containerlong_notm}}
{: #istio_tutorial}

[Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/info/istio) é uma plataforma aberta para conectar, proteger, controlar e observar serviços em plataformas em nuvem, como o Kubernetes no {{site.data.keyword.containerlong}}. Com o Istio, é possível gerenciar o tráfego de rede, fazer o balanceamento de carga entre microsserviços, cumprir políticas de acesso e verificar a identidade de serviço e muito mais.
{:shortdesc}

Neste tutorial, será possível ver como instalar o Istio com quatro microsserviços para um app mock simples de livraria chamado BookInfo. Os microsserviços incluem uma página da web do produto, detalhes do livro, revisões e classificações. Ao implementar microsserviços de BookInfo em um cluster do {{site.data.keyword.containerlong}} no qual o Istio está instalado, você injeta os proxies de sidecar Istio Envoy nos pods de cada microsserviço.

## Objetivos

-   Implementar o gráfico Helm do Istio em seu cluster
-   Implementar o aplicativo de amostra BookInfo
-   Verificar a implementação do app BookInfo e executar round robin nas três versões do serviço de classificações

## Tempo Necessário

30 minutos

## Público

Este tutorial é destinado a desenvolvedores de software e administradores de rede que estão usando o Istio pela primeira vez.

## Pré-requisitos

-  [Instale a CLI do IBM Cloud, o plug-in do {{site.data.keyword.containerlong_notm}} e a CLI do Kubernetes](cs_cli_install.html#cs_cli_install_steps). O Istio requer o Kubernetes versão 1.9 ou superior. Certifique-se de instalar a versão da CLI `kubectl` que corresponde à versão do Kubernetes do seu cluster.
-  [Crie um cluster que execute o Kubernetes versão 1.9 ou mais recente](cs_clusters.html#clusters_cli) ou [atualize um cluster existente para a versão 1.9](cs_versions.html#cs_v19).
-  [Destino a CLI para seu cluster](cs_cli_install.html#cs_cli_configure).

## Lição 1: Fazer download e instalar o Istio
{: #istio_tutorial1}

Faça download e instale o Istio em seu cluster.
{:shortdesc}

1. Instale o Istio usando o [gráfico Helm do IBM Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm-charts/ibm-istio).
    1. [Configure o Helm em seu cluster e inclua o repositório `ibm-charts` em sua instância do Helm](cs_integrations.html#helm).
    2.  **Somente para Helm versões 2.9 ou anterior**: instale as definições de recurso customizado do Istio.
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. Instale o gráfico Helm em seu cluster.
        ```
        helm install ibm-charts/ibm-istio -- name=istio -- namespace istio-system
        ```
        {: pre}

2. Assegure-se de que os pods para os 9 serviços do Istio e o pod para o Prometheus estejam totalmente implementados antes de continuar.
    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
    ```
    {: screen}

Bom Trabalho! Você instalou com êxito o Istio em seu cluster. Em seguida, implemente o aplicativo de amostra BookInfo em seu cluster.


## Lição 2: Implementar o app BookInfo
{: #istio_tutorial2}

Implemente os microsserviços do aplicativo de amostra BookInfo para seu cluster do Kubernetes.
{:shortdesc}

Esses quatro microsserviços incluem uma página da web do produto, detalhes do livro, revisões (com várias versões do microsserviço de revisão) e classificações. Quando você implementa o BookInfo, os proxies sidecar do Envoy são injetados como contêineres nos pods dos microsserviços do app antes dos pods do microsserviço serem implementados. O Istio usa uma versão estendida do proxy do Envoy para mediar todo o tráfego de entrada e de saída para todos os microsserviços na rede de serviços. Para saber mais sobre o Envoy, consulte a [documentação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy).

1. Faça o download do pacote do Istio contendo os arquivos necessários do BookInfo.
    1. Faça download do Istio diretamente de [https://github.com/istio/istio/releases ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/istio/istio/releases) e extraia os arquivos de instalação ou obtenha a versão mais recente usando cURL:
       ```
       curl -L https://git.io/getLatestIstio | sh -
       ```
       {: pre}

    2. Mude o diretório para o local do arquivo Istio.
       ```
       cd < filepath> /istio-1.0
       ```
       {: pre}

    3. Inclua o cliente `istioctl` em seu PATH. Por exemplo, execute o comando a seguir em um sistema Linux ou MacOS:
        ```
        export PATH=$PWD/istio-1.0/bin: $PATH
        ```
        {: pre}

2. Rotule o namespace  ` padrão `  com  ` istio-injection=enabled `.
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. Implemente o app BookInfo. Quando os microsserviços do app são implementados, o sidecar do Envoy também é implementado em cada pod de microsserviço.

   ```
   kubectl apply -f samples / bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. Assegure-se de que os microsserviços e seus pods correspondentes sejam implementados:
    ```
    kubectl get svc
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         1m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         1m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         1m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         1m
    ```
    {: screen}

    ```
    kubectl get pods
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

5. Para verificar a implementação do app, obtenha o endereço público para seu cluster.
    * Clusters padrão:
        1. Para expor seu app em um IP de ingresso público, implemente o gateway do BookInfo.
            ```
            kubectl apply -f samples / bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

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
        1. Obtenha o endereço IP público de qualquer nó do trabalhador em seu cluster.
            ```
            ibmcloud ks workers <cluster_name_or_ID>
            ```
            {: pre}

        2. Crie uma variável de ambiente GATEWAY_URL que use o endereço IP público do nó do trabalhador.
            ```
            export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. Execute curl para a variável `GATEWAY_URL` para verificar se o app BookInfo está em execução. Uma resposta `200` significa que o app BookInfo está sendo executado adequadamente com o Istio.
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  Visualize a página da web do BookInfo em um navegador.

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

7. Tente atualizar a página várias vezes. Versões diferentes da seção de revisões executam round robin entre estrelas vermelhas, estrelas pretas e nenhuma estrela.

Bom Trabalho! Você implementou com êxito o aplicativo de amostra BookInfo com sidecars do Istio Envoy. Em seguida, é possível limpar seus recursos ou continuar com mais tutoriais para explorar ainda mais o Istio.

## Limpeza
{: #istio_tutorial_cleanup}

Se você concluiu o trabalho com o Istio e não deseja [continuar explorando](#istio_tutorial_whatsnext), é possível limpar os recursos do Istio em seu cluster.
{:shortdesc}

1. Exclua todos os serviços, pods e implementações do BookInfo no cluster.
    ```
    samples / bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. Desinstale a implementação do Istio Helm.
    ```
    helm del istio -- purge
    ```
    {: pre}

3. Se você usou o Helm 2.9 ou anterior:
    1. Exclua o recurso de tarefa extra.
      ```
      kubectl -n istio-system delete job -- all
      ```
      {: pre}
    2. Opcional: exclua as definições de recurso customizado do Istio.
      ```
      kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
      ```
      {: pre}

## O que Vem a Seguir?
{: #istio_tutorial_whatsnext}

* Procurando expor seu app com o {{site.data.keyword.containerlong_notm}} e o Istio? Saiba como conectar o ALB do Ingress do {{site.data.keyword.containerlong_notm}} e um Gateway do Istio nesta [postagem do blog ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2018/09/transitioning-your-service-mesh-from-ibm-cloud-kubernetes-service-ingress-to-istio-ingress/).
* Para explorar o Istio ainda mais, é possível localizar mais guias na [documentação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/).
    * [Roteamento inteligente ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/guides/intelligent-routing.html): este exemplo mostra como rotear o tráfego para uma versão específica de microsserviços de revisões e classificações do BookInfo usando recursos de gerenciamento de tráfego do Istio.
    * [Telemetria detalhada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/guides/telemetry.html): este exemplo inclui como obter métricas, logs e rastreios uniformes ao longo de microsserviços do BookInfo usando o Istio Mixer e o proxy do Envoy.
* Faça a [Classe cognitiva: introdução aos microsserviços com o Istio e o IBM Cloud Kubernetes Service ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Nota**: é possível ignorar a seção de instalação do Istio desse curso.
* Verifique essa postagem do blog sobre como usar o [Vistio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) para visualizar sua malha de serviço Istio.
