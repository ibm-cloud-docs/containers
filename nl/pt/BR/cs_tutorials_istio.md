---

copyright: years: 2014, 2017 lastupdated: "2017-12-18"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Tutorial: Instalando o Istio no {{site.data.keyword.containerlong_notm}}
{: #istio_tutorial}

[Istio](https://www.ibm.com/cloud/info/istio) é uma plataforma aberta que fornece aos desenvolvedores uma maneira uniforme de conectar, assegurar e gerenciar uma rede de microsserviços, também conhecida como uma rede de serviços, em plataformas de nuvem como o Kubernetes. O Istio fornece a capacidade de gerenciar o tráfego de rede, executar o balanceamento de carga entre microsserviços, cumprir políticas de acesso e verificar a identidade de serviço na rede de serviços e muito mais.

{:shortdesc}

Neste tutorial, será possível ver como instalar o Istio com quatro microsserviços para um app mock simples de livraria chamado BookInfo. Os microsserviços incluem uma página da web do produto, detalhes do livro, revisões e classificações. Quando você implementa microsserviços de BookInfo em um cluster do {{site.data.keyword.containershort}} no qual o Istio está instalado, você injeta os proxies do sidecar Istio Envoy no pods de cada microsserviço.

**Observação**: algumas configurações e recursos da plataforma Istio ainda estão em desenvolvimento e estão sujeitas a mudanças com base no feedback do usuário. Permita alguns meses para estabilização antes de usar o Istio em produção. 

## Objetivos

-   Faça download e instale o Istio em seu cluster
-   Implemente o aplicativo de amostra BookInfo
-   Injete os proxies sidecar do Envoy em pods dos quatro microsserviços do app para conectar os microsserviços à rede de serviços
-   Verifique a implementação do app BookInfo e execute round robin nas três versões do serviço de classificação

## Tempo Necessário

30 minutos

## Público

Este tutorial é destinado a desenvolvedores de software e administradores de rede que nunca usaram o Istio antes.

## Pré-requisitos

-  [Instale a CLI](cs_cli_install.html#cs_cli_install_steps)
-  [Crie um cluster](cs_cluster.html#cs_cluster_cli)
-  [Direcione a CLI para o seu cluster](cs_cli_install.html#cs_cli_configure)

## Lição 1: Fazer download e instalar o Istio
{: #istio_tutorial1}

Faça download e instale o Istio em seu cluster.

1. Faça download do Istio diretamente do [https://github.com/istio/istio/releases ![Ícone de linkexterno](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/istio/istio/releases) ou obtenha a versão mais recente usando curl:


   ```
   curl -L https://git.io/getLatestIstio | sh -
   ```
   {: pre}

2. Extraia os arquivos de instalação.

3. Inclua o cliente `istioctl` em seu PATH. Por exemplo, execute o comando a seguir em um sistema Linux ou MacOS:

   ```
   export PATH=$PWD/istio-0.4.0/bin:$PATH
   ```
   {: pre}

4. Mude o diretório para o local do arquivo Istio.

   ```
   cd <path_to_istio-0.4.0>
   ```
   {: pre}

5. Instale o Istio no cluster do Kubernetes. Istio é implementado no namespace do Kubernetes `istio-system`.

   ```
   kubectl apply -f install/kubernetes/istio.yaml
   ```
   {: pre}

   **Observação**: se você precisar permitir a autenticação TLS mútua entre sidecars, será possível instalar o arquivo `istio-auth` em vez disso: `kubectl apply -f install/kubernetes/istio-auth.yaml`

6. Assegure-se de que os serviços Kubernetes `istio-pilot`, `istio-mixer` e `istio-ingress` estejam totalmente implementados antes de continuar.

   ```
   kubectl get svc -n istio-system
   ```
   {: pre}

   ```
   NAME            TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                                                            AGE
   istio-ingress   LoadBalancer   172.21.121.139   169.48.221.218   80:31176/TCP,443:30288/TCP                                         2m
   istio-mixer     ClusterIP      172.21.31.30     <none>           9091/TCP,15004/TCP,9093/TCP,9094/TCP,9102/TCP,9125/UDP,42422/TCP   2m
   istio-pilot     ClusterIP      172.21.97.191    <none>           15003/TCP,443/TCP                                                  2m
   ```
   {: screen}

7. Assegure-se de que os pods correspondentes `istio-pilot-*`, `istio-mixer-*`, `istio-ingress-*` e `istio-ca-*` sejam também totalmente implementados antes de continuar.

   ```
   kubectl get pods -n istio-system
   ```
   {: pre}

   ```
   istio-ca-3657790228-j21b9           1/1       Running   0          5m
   istio-ingress-1842462111-j3vcs      1/1       Running   0          5m
   istio-pilot-2275554717-93c43        1/1       Running   0          5m
   istio-mixer-2104784889-20rm8        2/2       Running   0          5m
   ```
   {: screen}


Parabéns! Você instalou com sucesso o Istio em seu cluster. Em seguida, implemente o aplicativo de amostra BookInfo em seu cluster.


## Lição 2: Implementar o app BookInfo
{: #istio_tutorial2}

Implemente os microsserviços do aplicativo de amostra BookInfo para seu cluster do Kubernetes. Esses quatro microsserviços incluem uma página da web do produto, detalhes do livro, revisões (com várias versões do microsserviço de revisão) e classificações. É possível localizar todos os arquivos usados neste exemplo no diretório `samples/bookinfo` da instalação do Istio.

Quando você implementa o BookInfo, os proxies sidecar do Envoy são injetados como contêineres nos pods dos microsserviços do app antes dos pods do microsserviço serem implementados. O Istio usa uma versão estendida do proxy do Envoy para mediar todo o tráfego de entrada e de saída para todos os microsserviços na rede de serviços. Para saber mais sobre o Envoy, consulte a [documentação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/concepts/what-is-istio/overview.html#envoy).

1. Implemente o app BookInfo. O comando `kube-inject` inclui o Envoy no arquivo `bookinfo.yaml` e usa esse arquivo atualizado para implementar o app. Quando os microsserviços do app são implementados, o sidecar do Envoy também é implementado em cada pod de microsserviço.

   ```
   kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/kube/bookinfo.yaml)
   ```
   {: pre}

2. Assegure-se de que os microsserviços e seus pods correspondentes sejam implementados:

   ```
   kubectl get svc
   ```
   {: pre}

   ```
   NAME                       CLUSTER-IP   EXTERNAL-IP   PORT(S)              AGE
   details                    10.0.0.31    <none>        9080/TCP             6m
   kubernetes                 10.0.0.1     <none>        443/TCP              30m
   productpage                10.0.0.120   <none>        9080/TCP             6m
   ratings                    10.0.0.15    <none>        9080/TCP             6m
   reviews                    10.0.0.170   <none>        9080/TCP             6m
   ```
   {: screen}

   ```
   kubectl get pods
   ```
   {: pre}

   ```
   NAME                                        READY     STATUS    RESTARTS   AGE
   details-v1-1520924117-48z17                 2/2       Running   0          6m
   productpage-v1-560495357-jk1lz              2/2       Running   0          6m
   ratings-v1-734492171-rnr5l                  2/2       Running   0          6m
   reviews-v1-874083890-f0qf0                  2/2       Running   0          6m
   reviews-v2-1343845940-b34q5                 2/2       Running   0          6m
   reviews-v3-1813607990-8ch52                 2/2       Running   0          6m
   ```
   {: screen}

3. Para verificar a implementação do aplicativo, obtenha o endereço público para seu cluster.

    * Se você estiver trabalhando com um cluster padrão, execute o comando a seguir para obter o IP e a porta do Ingress do seu cluster:

       ```
       kubectl get ingress
       ```
       {: pre}

       A saída é semelhante à seguinte:

       ```
       NAME      HOSTS     ADDRESS          PORTS     AGE
       gateway   *         169.48.221.218   80        3m
       ```
       {: screen}

       O endereço resultante do Ingress para este exemplo é `169.48.221.218:80`. Exporte o endereço como a URL do gateway com o comando a seguir. Você usará a URL de gateway na próxima etapa para acessar a página de produto do BookInfo.

       ```
       export GATEWAY_URL=169.48.221.218:80
       ```
       {: pre}

    * Se você está trabalhando com um cluster lite, deve-se usar o IP público do nó do trabalhador e o NodePort. Execute o comando a seguir para obter o IP público do nó do trabalhador:

       ```
       bx cs workers <cluster_name_or_ID>
       ```
       {: pre}

       Exporte o IP público do nó do trabalhador como a URL do gateway com o comando a seguir. Você usará a URL de gateway na próxima etapa para acessar a página de produto do BookInfo.

       ```
       export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingress -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
       ```
       {: pre}

4. Enrole a variável `GATEWAY_URL` para verificar se o BookInfo está em execução. Uma resposta `200` significa que o BookInfo está sendo executado adequadamente com o Istio.

   ```
   curl -I http://$GATEWAY_URL/productpage
   ```
   {: pre}

5. Em um navegador, navegue para `http://$GATEWAY_URL/productpage` para visualizar a página da web do BookInfo.

6. Tente atualizar a página várias vezes. Versões diferentes da seção de revisões executam round robin entre estrelas vermelhas, estrelas pretas e nenhuma estrela.

Parabéns! Você implementou com sucesso o aplicativo de amostra BookInfo com sidecars do Istio Envoy. Em seguida, é possível limpar seus recursos ou continuar com mais tutoriais para explorar ainda mais a funcionalidade do Istio.

## Limpeza
{: #istio_tutorial_cleanup}

Se você não quiser explorar ainda mais a funcionalidade do Istio fornecida em [O que vem a seguir?](#istio_tutorial_whatsnext), será possível limpar os recursos do Istio do seu cluster.

1. Exclua todos os serviços, pods e implementações do BookInfo no cluster.

   ```
   samples/bookinfo/kube/cleanup.sh
   ```
   {: pre}

2. Desinstale o Istio.

   ```
   kubectl delete -f install/kubernetes/istio.yaml
   ```
   {: pre}

## O que Vem a Seguir?
{: #istio_tutorial_whatsnext}

Para explorar ainda mais a funcionalidade do Istio, é possível localizar mais guias na [documentação do Istio ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/).

* [Intelligent Routing ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/guides/intelligent-routing.html): este exemplo mostra como usar os vários recursos de gerenciamento de tráfego do Istio com o BookInfo para rotear o tráfego para versão específica dos microsserviços de revisões e de classificações.

* [Telemetria detalhada ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://istio.io/docs/guides/telemetry.html): este exemplo demonstra como obter métricas uniformes, logs e rastreios entre os microsserviços do BookInfo usando o Istio Mixer e o proxy do Envoy.
