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


# Configurando serviços NodePort
{: #nodeport}

Torne seu app disponível para acesso à Internet usando o endereço IP público de qualquer nó do trabalhador em um cluster e expondo uma porta do nó. Use essa opção para teste e acesso público de curto prazo.
{:shortdesc}

## Configurando o acesso público para um app usando o tipo de serviço NodePort
{: #config}

É possível expor seu app como um serviço do Kubernetes NodePort para clusters lite ou padrão.
{:shortdesc}

**Nota:** o endereço IP público de um nó do trabalhador não é permanente. Se o nó do trabalhador precisar ser recriado, um novo endereço IP público será designado ao nó do trabalhador. Se você precisar de um endereço IP público estável e mais disponibilidade para seu serviço, exponha seu app usando um [serviço LoadBalancer](cs_loadbalancer.html) ou [Ingresso](cs_ingress.html).

Se você ainda não tem um app pronto, é possível usar um app de exemplo do Kubernetes chamado [Guestbook ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml).

1.  No arquivo de configuração para seu app, defina uma seção de [serviço ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/service/).

    Exemplo:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <my-nodeport-service>
      labels:
        run: <my-demo>
    spec:
      selector:
        run: <my-demo>
      type: NodePort
      ports:
       - port: <8081>
         # nodePort: <31514>

    ```
    {: codeblock}

    <table>
    <caption>Entendendo os componentes deste arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Entendendo os componentes de seção do serviço NodePort</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Substitua <code><em>&lt;my-nodeport-service&gt;</em></code> por um nome para seu serviço NodePort.</td>
    </tr>
    <tr>
    <td><code>execução</code></td>
    <td>Substitua <code><em>&lt;my-demo&gt;</em></code> pelo nome de sua implementação.</td>
    </tr>
    <tr>
    <td><code>port</code></td>
    <td>Substitua <code><em>&lt;8081&gt;</em></code> pela porta em que seu serviço atende. </td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>Opcional: substitua <code><em>&lt;31514&gt;</em></code> por um NodePort no intervalo de 30000 a 32767. Não especifique um NodePort que já esteja em uso por outro serviço. Se nenhum NodePort for designado, um aleatório será designado para você.<br><br>Se você deseja especificar um NodePort e deseja ver quais NodePorts já estão em uso, é possível executar o comando a seguir: <pre class="pre"><code>kubectl get svc</code></pre>Os NodePorts em uso aparecem sob o campo **Portas**.</td>
     </tr>
     </tbody></table>


    Para o exemplo Guestbook, uma seção de serviço de front-end já existe no arquivo de configuração. Para disponibilizar o app Guestbook externamente, inclua o tipo NodePort e uma NodePort no intervalo de 30000 a 32767 na seção de serviço de front-end.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      type: NodePort
      ports:
      - port: 80
        nodePort: 31513
      selector:
        app: guestbook
        tier: frontend
    ```
    {: codeblock}

2.  Salve o arquivo de configuração atualizado.

3.  Repita essas etapas para criar um serviço NodePort para cada app que você deseja expor para a Internet.

**E agora?**

Quando o app for implementado, será possível usar o endereço IP público de qualquer nó do trabalhador e o NodePort para formar a URL pública para acessar o app em um navegador.

1.  Obtenha o endereço IP público para um nó do trabalhador no cluster.

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    Saída:

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
    ```
    {: screen}

2.  Se um NodePort aleatório foi designado, descubra qual foi designado.

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    Saída:

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    Neste exemplo, o NodePort é `30872`.

3.  Forme a URL com um dos endereços IP públicos do nó do trabalhador e o NodePort. Exemplo: `http://192.0.2.23:30872`
