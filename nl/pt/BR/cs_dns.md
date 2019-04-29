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

# Configurar o provedor DNS do cluster
{: #cluster_dns}

Cada serviço em seu cluster do {{site.data.keyword.containerlong}} é designado a um nome de Sistema de Nomes de Domínio (DNS) que o provedor de DNS do cluster registra para resolver solicitações de DNS. Dependendo da versão do Kubernetes de seu cluster, é possível escolher entre o DNS do Kubernetes (KubeDNS) ou o [CoreDNS ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://coredns.io/). Para obter mais informações sobre o DNS para serviços e pods, consulte [a documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/).
{: shortdesc}

**Que tipos de provedor DNS do cluster as versões do Kubernetes suportam?**<br>

| Versão do Kubernetes | Padrão para novos clusters | Descrição |
|---|---|---|
| 1.13 e mais recente | CoreDNS | Os clusters que são atualizados para 1.13 de um cluster anterior mantêm qualquer provedor DNS que eles usavam no momento da atualização. Se você desejar usar um diferente, [alterne o provedor DNS](#dns_set). |
| 1.12 | KubeDNS | Para usar o CoreDNS no lugar, [alterne o provedor DNS](#set_coredns). |
| 1.11 e anterior | KubeDNS | Não é possível alternar o provedor DNS para o CoreDNS. |
{: caption="Provedor de DNS do cluster padrão por versão do Kubernetes" caption-side="top"}

## Autoscaling do provedor DNS do cluster
{: #dns_autoscale}

Por padrão, seu provedor DNS do cluster do {{site.data.keyword.containerlong_notm}} inclui uma implementação para escalar automaticamente os pods do DNS em resposta ao número de nós do trabalhador e núcleos dentro do cluster. É possível finalizar os parâmetros do escalador automático do DNS editando o configmap de ajuste de escala automático do DNS. Por exemplo, se seus aplicativos tiverem um uso intenso do provedor DNS do cluster, talvez seja necessário aumentar o número mínimo de pods DNS para suportar o aplicativo. Para obter mais informações, consulte [a documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/).
{: shortdesc}

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Verifique se a implementação do provedor de DNS do cluster está disponível. Você pode ter o escalador automático para o KubeDNS, o CoreDNS ou ambos os provedores DNS instalados em seu cluster. Se você tiver os dois escaladores automáticos do DNS instalados, localize aquele que está em uso examinando a coluna **AVAILABLE** na saída da CLI. A implementação que está em uso é listada com 1 implementação disponível.
    ```
    kubectl get deployment -n kube-system | grep dns-autoscaler
    ```
    {: pre}
    
    Saída de exemplo:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler     0         0         0            0           32d
    kube-dns-autoscaler    1         1         1            1           260d
    ```
    {: screen}
2.  Obtenha o nome do configmap para os parâmetros de autoscaler DNS.
    ```
    kubectl get configmap -n kube-system
    ```
    {: pre}    
3.  Edite as configurações padrão para o escalador automático de DNS. Procure o campo `data.linear`, que padroniza para 1 pod de DNS por 16 nós do trabalhador ou 256 núcleos, com um mínimo de 2 pods de DNS independentemente do tamanho do cluster (`preventSinglePointFailure: true`). Para obter mais informações, consulte [a documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters).
    ```
    kubectl edit configmap -n kube-system <dns-autoscaler>
    ```
    {: pre}
    
    Saída de exemplo:
    ```
    apiVersion: v1
    data:
      linear: '{"coresPerReplica":256,"nodesPerReplica":16,"preventSinglePointFailure":true}'
    kind: ConfigMap
    metadata:
    ...
    ```
    {: screen}

## Customizando o provedor DNS do cluster
{: #dns_customize}

É possível customizar seu provedor DNS de cluster do {{site.data.keyword.containerlong_notm}} editando o configmap do DNS. Por exemplo, talvez você queira configurar domínios de stub e servidores de nome de envio de dados para resolver serviços que apontam para hosts externos. Além disso, se você usar o CoreDNS, será possível configurar múltiplos [Corefiles ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://coredns.io/2017/07/23/corefile-explained/) dentro do configmap do CoreDNS. Para obter mais informações, consulte [a documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
{: shortdesc}

Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Verifique se a implementação do provedor de DNS do cluster está disponível. Você pode ter o provedor de cluster DNS para KubeDNS, CoreDNS ou ambos os provedores DNS instalados em seu cluster. Se você tiver os dois provedores de DNS instalados, localize o que está em uso examinando a coluna **AVAILABLE** na saída da CLI. A implementação que está em uso é listada com 1 implementação disponível.
    ```
    kubectl get deployment -n kube-system -l k8s-app=kube-dns
    ```
    {: pre}
    
    Saída de exemplo:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns                0         0         0            0           89d
    kube-dns-amd64         2         2         2            2           89d
    ```
    {: screen}
2.  Edite as configurações padrão para o configmap do CoreDNS ou do KubeDNS.
    
    *   **Para CoreDNS**: use um Corefile na seção `data` do configmap para customizar os domínios de stub e os servidores de nomes de envio de dados. Para obter mais informações, consulte [a documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns).
        ```
        editor kubectl editar configmap -n kube-system coredns
        ```
        {: pre}
    
        ** Saída de exemplo do CoreDNS **: 
          ```
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: coredns
            namespace: kube-system
          data:
            Corefile: |
              abc.com:53 {
                  errors
                  cache 30
                  proxy . 1.2.3.4
              }
              .: 53 {
                  errors
                  health
                  kubernetes cluster.local in-addr.arpa ip6.arpa {
                     vagens inseguras
                     upstream 172.16.0.1
                     fallthrough in-addr.arpa ip6.arpa
                  } prometheus: 9153
                  proxy. /etc/resolv.conf
                  cache 30
                  loop
                  reload
                  loadbalance
              }
          ```
          {: screen}
          
          Você tem muitas customizações que você deseja organizar? No Kubernetes versão 1.12.6_1543 e mais recente, é possível incluir múltiplos Corefiles no configmap do CoreDNS. Para obter mais informações, consulte [a documentação de importação do Corefile ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://coredns.io/plugins/import/).
          {: tip}
          
    *   **Para KubeDNS**: configure domínios de stub e servidores de nome de envio de dados na seção `data` do configmap. Para obter mais informações, consulte [a documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns).
        ```
        kubectl edit configmap -n kube-system kube-dns
        ```
        {: pre}

        ** Saída de exemplo de KubeDNS **:
        ```
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: kube-dns
          namespace: kube-system
        data:
          stubDomains: |
          {"abc.com ": [" 1.2.3.4 " ] }
        ```
        {: screen}

## Configurando o provedor DNS de cluster para CoreDNS ou KubeDNS
{: #dns_set}

Se você tiver um cluster do {{site.data.keyword.containerlong_notm}} que execute o Kubernetes versão 1.12 ou mais recente, será possível escolher usar o DNS do Kubernetes (KubeDNS) ou o CoreDNS como o provedor DNS do cluster.
{: shortdesc}

** Antes de iniciar **:
1.  [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
2.  Determine o provedor de DNS do cluster atual. No exemplo a seguir, KubeDNS é o provedor de DNS do cluster atual.
    ```
    kubectl cluster-info
    ```
    {: pre}

    Saída de exemplo:
    ```
    ...
    O KubeDNS está em execução em https://c2.us-south.containers.cloud.ibm.com:20190/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    ...
    ```
    {: screen}
3.  Com base no provedor DNS que seu cluster usa, siga as etapas para alternar os provedores DNS.
    *  [ Alternar para usar o CoreDNS ](#set_coredns).
    *  [ Alternar para usar KubeDNS ](#set_kubedns).

### Configurando o CoreDNS como um provedor DNS de cluster
{: #set_coredns}

Configure o CoreDNS em vez de KubeDNS como o provedor DNS do cluster.
{: shortdesc}

1.  Se você customizou o configmap do provedor KubeDNS ou o configmap do escalador automático do KubeDNS, transfira qualquer customização para os configmaps do CoreDNS.
    *   Para o configmap `kube-dns` no namespace do `kube-system`, transfira qualquer [customização de DNS ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) para o configmap `coredns` no namespace `kube-system`. Observe que a sintaxe difere dos configmaps `kube-dns` e `coredns`. Para obter um exemplo, consulte [os docs do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns).
    *   Para o configmap `kube-dns-autoscaler` no namespace `kube-system`, transfira quaisquer [customizações de autoinicialização do DNS do ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) para o configmap `coredns-autoscaler` no namespace `kube-system`. Observe que a sintaxe de customização é a mesma.
2.  Reduza a escala da implementação do ajuste de escala automático do KubeDNS.
    ```
    kubectl scale deployment -n kube-system --replicas=0 kube-dns-autoscaler
    ```
    {: pre}
3.  Verifique e aguarde até que os pods sejam excluídos.
    ```
    kubectl get pods -n kube-system -l k8s-app=kube-dns-autoscaler
    ```
    {: pre}
4.  Reduza a escala da implementação do KubeDNS.
    ```
    kubectl scale deployment -n kube-system --replicas=0 kube-dns-amd64
    ```
    {: pre}
5.  Aumente a capacidade da implementação ajuste de escala automático do CoreDNS.
    ```
    kubectl scale deployment -n kube-system --replicas=1 coredns-autoscaler
    ```
    {: pre}
6.  Rotule e anote o serviço DNS do cluster para o CoreDNS.
    ```
    kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=CoreDNS
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port=9153
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape=true
    ```
    {: pre}
7.  **Opcional**: se você planeja usar o Prometheus para coletar métricas dos pods do CoreDNS, deve-se incluir uma porta de métricas no serviço `kube-dns` do qual você está alternando.
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"metrics","port":9153,"protocol":"TCP"}]}}' --type strategic
    ```
    {: pre}



### Configurando o KubeDNS como o provedor DNS do cluster
{: #set_kubedns}

Configure o KubeDNS em vez do CoreDNS como o provedor DNS do cluster.
{: shortdesc}

1.  Se você customizou o configmap do provedor CoreDNS ou o configmap do escalador automático do CoreDNS, transfira qualquer customização para os configmaps do KubeDNS.
    *   Para o configmap `coredns` no namespace `kube-system`, transfira qualquer [customização de DNS ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) para o configmap `kube-dns` no namespace `kube-system`. Observe que a sintaxe difere dos configmaps `kube-dns` e `coredns`. Para obter um exemplo, consulte [os docs do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns).
    *   Para o configmap `coredns-autoscaler` no namespace `kube-system`, transfira qualquer [customização do escalador automático de DNS ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) para o configmap `kube-dns-autoscaler` no namespace `kube-system`. Observe que a sintaxe de customização é a mesma.
2.  Reduza a escala da implementação do ajuste de escala automático do CoreDNS.
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns-autoscaler
    ```
    {: pre}
3.  Verifique e aguarde até que os pods sejam excluídos.
    ```
    kubectl get pods -n kube-system -l k8s-app=coredns-autoscaler
    ```
    {: pre}
4.  Reduza a escala da implementação do CoreDNS.
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns
    ```
    {: pre}
5.  Aumente a implementação do ajuste de escala automático do KubeDNS.
    ```
    kubectl scale deployment -n kube-system --replicas=1 kube-dns-autoscaler
    ```
    {: pre}
6.  Rotule e anote o serviço DNS do cluster para KubeDNS.
    ```
    kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=KubeDNS
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port-
    ```
    {: pre}
    ```
    kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape-
    ```
    {: pre}
7.  **Opcional**: se você usou o Prometheus para coletar métricas dos pods do CoreDNS, seu serviço `kube-dns` tinha uma porta de métricas. No entanto, o KubeDNS não precisa incluir essa porta de métricas para que seja possível remover a porta do serviço.
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"dns","port":53,"protocol":"UDP"},{"name":"dns-tcp","port":53,"protocol":"TCP"}]}}' --type merge
    ```
    {: pre}
