---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, nginx, iks multiple ingress controllers

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


# Trazendo seu próprio controlador do Ingresso
{: #ingress-user_managed}

Traga seu próprio controlador do Ingress para ser executado no {{site.data.keyword.cloud_notm}} e alavancar um nome do host fornecido pela IBM e um certificado TLS.
{: shortdesc}

Os balanceadores de carga de aplicativo (ALBs) do Ingress fornecidos pela IBM são baseados em controladores NGINX que podem ser configurados usando [ anotações do {{site.data.keyword.cloud_notm}}](/docs/containers?topic=containers-ingress_annotation) customizadas. Dependendo do que seu app requer, você talvez deseje configurar seu próprio controlador do Ingress customizado. Ao trazer seu próprio controlador do Ingress em vez de usar o ALB do Ingress fornecido pela IBM, você é responsável por fornecer a imagem do controlador, manter o controlador, atualizando o controlador e quaisquer atualizações relacionadas à segurança para manter seu controlador do Ingress livre de vulnerabilidades. **Nota**: a inclusão de seu próprio controlador do Ingress é suportada apenas para fornecer acesso externo público aos seus aplicativos e não para fornecer acesso externo privado.

Você tem duas opções para trazer seu próprio controlador do Ingress:
* [Crie um balanceador de carga de rede (NLB) para expor sua implementação do controlador do Ingress customizado e, em seguida, crie um nome do host para o endereço IP do NLB](#user_managed_nlb). O {{site.data.keyword.cloud_notm}} fornece o nome do host e cuida da geração e manutenção de um certificado SSL curinga para o nome do host. Para obter mais informações sobre nomes do host do DNS do NLB fornecidos pela IBM, consulte [Registrando um nome do host do NLB](/docs/containers?topic=containers-loadbalancer_hostname).
* [Desative a implementação do ALB fornecido pela IBM e use o serviço de balanceador de carga que expôs o ALB e o registro DNS para o subdomínio do Ingress fornecido pela IBM](#user_managed_alb). Essa opção permite alavancar o subdomínio do Ingress e o certificado TLS que já estão designados ao seu cluster.

## Expor seu controlador do Ingress criando um NLB e um nome do host
{: #user_managed_nlb}

Crie um balanceador de carga de rede (NLB) para expor sua implementação do controlador do Ingress customizado e, em seguida, crie um nome do host para o endereço IP do NLB.
{: shortdesc}

1. Deixe o arquivo de configuração para o seu controlador de ingresso pronto. Por exemplo, é possível usar o [controlador Ingress da comunidade NGINX da nuvem genérica ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic). Se você usar o controlador da comunidade, edite o arquivo `kustomization.yaml` seguindo estas etapas.
  1. Substitua o `namespace: ingress-nginx` por `namespace: kube-system`.
  2. Na seção `commonLabels`, substitua os rótulos `app.kubernetes.io/name: ingress-nginx` e `app.kubernetes.io/part-of: ingress-nginx` por um rótulo `app: ingress-nginx`.

2. Implemente seu próprio controlador de Ingresso. Por exemplo, para usar o controlador Ingress da comunidade NGINX da nuvem genérica, execute o comando a seguir.
    ```
    kubectl apply --kustomize. -n kube-system
    ```
    {: pre}

3. Defina um balanceador de carga para expor sua implementação customizada do Ingress.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-lb-svc
    spec:
      type: LoadBalancer
      selector:
        app: ingress-nginx
      ports:
       - protocol: TCP port: 8080 externalTrafficPolicy: Local
    ```
    {: codeblock}

4. Crie o serviço em seu cluster.
    ```
    kubectl apply -f my-lb-svc.yaml
    ```
    {: pre}

5. Obtenha o endereço **EXTERNAL-IP** para o balanceador de carga.
    ```
    kubectl get svc my-lb-svc -n kube-system
    ```
    {: pre}

    Na saída de exemplo a seguir, o **EXTERNAL-IP** é `168.1.1.1`.
    ```
    NAME         TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)            AGE
    my-lb-svc    LoadBalancer   172.21.xxx.xxx   168.1.1.1        80:30104/TCP       2m
    ```
    {: screen}

6. Registre o endereço IP do balanceador de carga criando um nome do host do DNS.
    ```
    ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <LB_IP>
    ```
    {: pre}

7. Verifique se o nome do host foi criado.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Saída de exemplo:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
  ```
  {: screen}

8. Opcional: [ative verificações de funcionamento no nome do host criando um monitor de funcionamento](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor).

9. Implemente quaisquer outros recursos que forem necessários para o controlador de ingresso customizado, como o configmap.

10. Crie recursos do Ingress para seus apps. É possível usar a documentação do Kubernetes para criar [um arquivo de recursos do Ingress ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/ingress/) e usar [anotações ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/).
  <p class="tip">Se você continuar a usar ALBs fornecidos pela IBM simultaneamente com seu controlador do Ingress customizado em um cluster, será possível criar recursos do Ingress separados para seus ALBs e o controlador customizado. No [Recurso de Ingresso que você cria para aplicar somente aos ALBs da IBM](/docs/containers?topic=containers-ingress#ingress_expose_public), inclua a anotação <code>kubernetes.io/ingress.class: "iks-nginx"</code>.</p>

11. Acesse seu app usando o nome do host do balanceador de carga que foi localizado na etapa 7 e o caminho em que seu app atende que foi especificado no arquivo de recursos do Ingress.
  ```
  https://<load_blanacer_host_name>/<app_path>
  ```
  {: codeblock}

## Exponha seu controlador do Ingress usando o balanceador de carga existente e o subdomínio do Ingress
{: #user_managed_alb}

Desative a implementação do ALB fornecido pela IBM e use o serviço de balanceador de carga que expôs o ALB e o registro DNS para o subdomínio do Ingress fornecido pela IBM.
{: shortdesc}

1. Obtenha o ID do ALB público padrão. O ALB público é formatado semelhante a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. Desative o ALB público padrão. A sinalização `--disable-deployment` desativa a implementação do ALB fornecido pela IBM, mas não remove o registro do DNS para o subdomínio do Ingresso fornecido pela IBM ou o serviço de balanceador de carga usado para expor o controlador de ingresso.
    ```
    ibmcloud ks alb-configure -- albID < ALB_ID> --disable-deployment
    ```
    {: pre}

3. Deixe o arquivo de configuração para o seu controlador de ingresso pronto. Por exemplo, é possível usar o [controlador Ingress da comunidade NGINX da nuvem genérica ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic). Se você usar o controlador da comunidade, edite o arquivo `kustomization.yaml` seguindo estas etapas.
  1. Substitua o `namespace: ingress-nginx` por `namespace: kube-system`.
  2. Na seção `commonLabels`, substitua os rótulos `app.kubernetes.io/name: ingress-nginx` e `app.kubernetes.io/part-of: ingress-nginx` por um rótulo `app: ingress-nginx`.
  3. Na variável `SERVICE_NAME`, substitua `name: ingress-nginx` por `name: <ALB_ID>`. Por exemplo, o ID do ALB da etapa 1 pode ser semelhante a `name: public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.

4. Implemente seu próprio controlador de Ingresso. Por exemplo, para usar o controlador Ingress da comunidade NGINX da nuvem genérica, execute o comando a seguir. **Importante**: para continuar a usar o serviço de balanceador de carga expondo o controlador e o subdomínio do Ingresso fornecido pela IBM, seu controlador deve ser implementado no namespace `kube-system`.
    ```
    kubectl apply --kustomize. -n kube-system
    ```
    {: pre}

5. Obtenha o rótulo em sua implementação customizada do Ingresso.
    ```
    kubectl get deploy <ingress-controller-name> -n kube-system --show-labels
    ```
    {: pre}

    Na saída de exemplo a seguir, o valor do rótulo é `ingress-nginx`:
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

6. Usando o ID do ALB que você tem na etapa 1, abra o serviço do balanceador de carga que expõe o ALB da IBM.
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

7. Atualize o serviço de balanceador de carga para apontar para a sua implementação customizada do Ingress. Em `spec/selector`, remova o ID de ALB do rótulo `app` e inclua o rótulo para seu próprio controlador de ingresso que você obteve na etapa 5.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. Opcional: por padrão, o serviço de balanceador de carga permite o tráfego na porta 80 e 443. Se o seu controlador de ingresso customizado requer um conjunto diferente de portas, inclua essas portas na seção `ports`.

8. Salve e feche o arquivo de configuração. A saída é semelhante à seguinte:
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

9. Verifique se o `Selector` do ALB agora aponta para o seu controlador.
    ```
    kubectl describe svc < ALB_ID> -n kube-system
    ```
    {: pre}

    Saída de exemplo:
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
    ```
    {: screen}

10. Implemente quaisquer outros recursos que forem necessários para o controlador de ingresso customizado, como o configmap.

11. Se você tiver um cluster de múltiplas zonas, repita estas etapas para cada ALB.

12. Se você tem um cluster de multizona, deve-se configurar uma verificação de funcionamento. O terminal de verificação de funcionamento do DNS do Cloudflare, `albhealth.<clustername>.<region>.containers.appdomain.com`, espera uma resposta `200` com um corpo de `healthy` na resposta. Se nenhuma verificação de funcionamento estiver configurada para retornar `200` e `healthy`, a verificação de funcionamento removerá quaisquer endereços IP do ALB do conjunto DNS. É possível editar o recurso de verificação de funcionamento existente ou criar o seu próprio.
  * Para editar o recurso de verificação de funcionamento existente:
      1. Abra o recurso `alb-health`.
        ```
        kubectl edit ingress alb-health --namespace kube-system
        ```
        {: pre}
      2. Na seção `metadata.annotations`, mude o nome da anotação `ingress.bluemix.net/server-snippets` para a anotação que o controlador suporta. Por exemplo, é possível usar a anotação `nginx.ingress.kubernetes.io/server-snippet`. Não mude o conteúdo do fragmento do servidor.
      3. Salve e feche o arquivo. Suas mudanças são aplicadas automaticamente.
  * Para criar seu próprio recurso de verificação de funcionamento, assegure-se de que o fragmento a seguir seja retornado ao Cloudflare:
    ```
    { return 200 'healthy'; add_header Content-Type text/plain; }
    ```
    {: codeblock}

13. Crie recursos do Ingresso para seus apps seguindo as etapas em [Expondo apps que estão dentro de seu cluster para o público](/docs/containers?topic=containers-ingress#ingress_expose_public).

Seus apps agora são expostos pelo controlador de ingresso customizado. Para restaurar a implementação do ALB fornecido pela IBM, reative o ALB. O ALB é reimplementado e o serviço de balanceador de carga é reconfigurado automaticamente para apontar para o ALB.

```
ibmcloud ks alb-configure --albID <alb ID> --enable
```
{: pre}
