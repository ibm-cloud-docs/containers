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

# Configurando a conectividade de VPN
{: #vpn}

A conectividade da VPN permite que você conecte seguramente apps em um cluster do Kubernetes a uma rede no local. Também é possível conectar apps que são externos ao seu cluster para um app que está em execução dentro de seu cluster.
{:shortdesc}

## Configurando a conectividade de VPN com o gráfico Helm do serviço VPN IPSec do Strongswan
{: #vpn-setup}

Para configurar a conectividade de VPN, é possível usar um Gráfico do Helm para configurar e implementar o [serviço VPN IPSec do Strongswan![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.strongswan.org/) dentro de um pod do Kubernetes. Todo o tráfego de VPN é, então, roteado por meio deste pod. Para obter mais informações sobre os comandos Helm usados para configurar o gráfico do Strongswan, veja a <a href="https://docs.helm.sh/helm/" target="_blank">documentação do Helm <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.
{:shortdesc}

Antes de iniciar:

- [Crie um cluster padrão.](cs_clusters.html#clusters_cli)
- [Se você estiver usando um cluster existente, atualize a versão 1.7.4 ou mais recente.](cs_cluster_update.html#master)
- O cluster deve ter pelo menos um endereço IP público disponível do balanceador de carga.
- [Destine a CLI do Kubernetes para o cluster](cs_cli_install.html#cs_cli_configure).

Para configurar a conectividade da VPN com o Strongswan:

1. Se ele ainda não estiver ativado, instale e inicialize o Helm para seu cluster.

    1. Instale a <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">CLI do Helm <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.

    2. Inicialize o Helm e instale o `tiller`.

        ```
        helm init
        ```
        {: pre}

    3. Verifique se o pod `tiller-deploy` tem o status `Running` em seu cluster.

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        Saída de exemplo:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. Inclua o repositório Helm do {{site.data.keyword.containershort_notm}} para sua instância do Helm.

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Verifique se o gráfico do Strongswan está listado no repositório Helm.

        ```
        helm search bluemix
        ```
        {: pre}

2. Salve as definições de configuração padrão para o diagrama Helm do Strongswan em um arquivo YAML local.

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. Abra o arquivo `config.yaml` e faça as mudanças a seguir para os valores padrão de acordo com a configuração de VPN que você desejar. Se uma propriedade tiver valores específicos dentre os quais é possível escolher, esses valores serão listados em comentários acima de cada propriedade no arquivo. **Importante**: se não for necessário mudar uma propriedade, deixe um comentário nessa propriedade, colocando um `#` na frente dela.

    <table>
    <caption>Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>Se você tiver um arquivo <code>ipsec.conf</code> existente que você deseja usar, remova as chaves (<code>{}</code>) e inclua o conteúdo do arquivo após essa propriedade. Os conteúdos do arquivo devem ser indentados. **Observação:** se você usar seu próprio arquivo, quaisquer valores para as seções <code>ipsec</code>, <code>local</code> e <code>remote</code> não serão usadas.</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>Se você tiver um arquivo <code>ipsec.secrets</code> existente que deseja usar, remova as chaves (<code>{}</code>) e inclua o conteúdo do arquivo após essa propriedade. Os conteúdos do arquivo devem ser indentados. **Observação:** se você usar seu próprio arquivo, nenhum valor para a seção <code>preshared</code> será usado.</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>Se seu terminal de túnel de VPN local não suportar o <code>ikev2</code> como um protocolo para inicializar a conexão, mude esse valor para <code>ikev1</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>Mude esse valor para a lista de algoritmos de criptografia/autenticação ESP que o seu terminal de túnel de VPN local usa para a conexão.</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>Mude esse valor para a lista de algoritmos de criptografia/autenticação IKE/ISAKMP SA que o seu terminal de túnel da VPN local usa para a conexão.</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>Se você deseja que o cluster inicie a conexão de VPN, mude esse valor para <code>start</code>.</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>Mude esse valor para a lista de CIDRs de sub-rede de cluster que deve ser exposta durante a conexão de VPN com a rede local. Essa lista pode incluir as seguintes sub-redes: <ul><li>O CIDR de sub-rede de pod do Kubernetes: <code>172.30.0.0/16</code></li><li>O CIDR de sub-rede do serviço do Kubernetes: <code>172.21.0.0/16</code></li><li>Se você tiver aplicativos expostos por um serviço NodePort na rede privada, o CIDR de sub-rede privada do nó do trabalhador. Para encontrar esse valor, execute <code>bx cs subnets | grep <xxx.yyy.zzz></code>, em que &lt;xxx.yyy.zzz&gt; são os três primeiros octectos do endereço IP privado do nó do trabalhador.</li><li>Se você tiver aplicativos expostos pelos serviços LoadBalancer na rede privada, os CIDRs de sub-rede privados ou gerenciados pelo usuário do cluster. Para encontrar esses valores, execute <code>bx cs cluster-get <cluster name> --showResources</code>. Na seção <b>VLANS</b>, procure os CIDRs que possuem um valor <b>público</b> de <code>false</code>.</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>Mude esse valor para o identificador de sequência para o lado cluster do Kubernetes local que o seu terminal de túnel da VPN usa para a conexão.</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>Mude esse valor para o endereço IP público para o gateway da VPN no local.</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Mude esse valor para a lista de CIDRs de sub-rede privada local a qual os clusters do Kubernetes têm permissão para acessar.</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>Mude esse valor para o identificador de sequência para o lado local remoto que o seu terminal de túnel da VPN usa para a conexão.</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>Mude esse valor para o segredo pré-compartilhado que o gateway do terminal do túnel da VPN local usa para a conexão.</td>
    </tr>
    </tbody></table>

4. Salve o arquivo `config.yaml` atualizado.

5. Instale o diagrama Helm em seu cluster com o arquivo `config.yaml` atualizado. As propriedades atualizadas são armazenadas em um mapa de configuração para seu gráfico.

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. Verifique o status de implementação do gráfico. Quando o gráfico estiver pronto, o campo **STATUS** perto da parte superior da saída terá um valor de `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

7. Quando o gráfico for implementado, verifique se as configurações atualizadas no arquivo `config.yaml` foram usadas.

    ```
    helm get values vpn
    ```
    {: pre}

8. Teste a nova conectividade da VPN.
    1. Se a VPN no gateway local não estiver ativo, inicie a VPN.

    2. Configure a variável de ambiente `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. Verifique o status da VPN. Um status de `ESTABLISHED` significa que a conexão de VPN foi bem-sucedida.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        Saída de exemplo:
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

        **Nota**:
          - É altamente provável que a VPN não tenha um status de `ESTABLISHED` na primeira vez que você usa esse diagrama Helm. Você pode precisar verificar as configurações do terminal de VPN local e retornar para a etapa 3 para mudar o arquivo `config.yaml` várias vezes antes que a conexão seja bem-sucedida.
          - Se o pod VPN está em um estado de `ERROR` ou continua travando e reiniciando, pode ser devido à validação do parâmetro das configurações `ipsec.conf` no mapa de configuração do gráfico. Para ver se este é o caso, verifique se há erros de validação nos logs do pod do Strongswan, executando `kubectl logs -n kube-system $STRONGSWAN_POD`. Se houver erros de validação, execute `helm delete --purge vpn`, retorne para a etapa 3 para corrigir os valores incorretos no arquivo `config.yaml` e repita as etapas 4 e 8. Se o seu cluster tem um alto número de nós do trabalhador, também será possível utilizar o `helm upgrade` para aplicar mais rapidamente suas mudanças, em vez de executar o `helm delete` e o `helm install`.

    4. Quando a VPN tiver um status de `ESTABLISHED`, teste a conexão com o `ping`. O exemplo a seguir envia um ping do pod da VPN no cluster do Kubernetes para o endereço IP privado do gateway da VPN local. Certifique-se de que `remote.subnet` e `local.subnet` sejam especificados no arquivo de configuração e que a lista de sub-rede local inclua o endereço IP de origem do qual você está enviando o ping.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

### Desativando o serviço VPN IPSec do Strongswan
{: vpn_disable}

1. Exclua o diagrama Helm.

    ```
    helm delete --purge vpn
    ```
    {: pre}
