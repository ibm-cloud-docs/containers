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

# Ajustando o Desempenho
{: #kernel}

Se você tiver requisitos específicos de otimização de desempenho, será possível mudar as configurações padrão para os parâmetros `sysctl` do kernel do Linux em nós do trabalhador e os namespaces de rede de pod no {{site.data.keyword.containerlong}}.
{: shortdesc}

Os nós do trabalhador são provisionados automaticamente com o desempenho do kernel otimizado, mas é possível mudar as configurações padrão aplicando um objeto `DaemonSet` customizado do Kubernetes para seu cluster. O daemonset altera as configurações para todos os nós do trabalhador existentes e aplica as configurações a quaisquer novos nós do trabalhador que são provisionados no cluster. Nenhum pods é afetado.

Para otimizar as configurações do kernel para os pods de app, é possível inserir um initContainer no YAML `pod/ds/rs/deployment` para cada implementação. O initContainer é incluído em cada implementação de app que está no namespace de rede do pod para o qual você deseja otimizar o desempenho.

Por exemplo, as amostras nas seções a seguir mudam o número máximo padrão de conexões permitidas no ambiente por meio da configuração `net.core.somaxconn` e o intervalo de portas efêmeras por meio da configuração `net.ipv4.ip_local_port_range`.

**Aviso**: se você escolher mudar as configurações de parâmetro do kernel padrão, fará isso por sua própria conta e risco. Você é responsável por executar testes com relação a quaisquer configurações mudadas e para quaisquer interrupções potenciais causadas pelas configurações mudadas em seu ambiente.

## Otimizando o desempenho do nó do
{: #worker}

Aplique um [daemonset ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para mudar os parâmetros do kernel no host do nó do trabalhador.

**Nota**: deve-se ter a [função de acesso de Administrador](cs_users.html#access_policies) para executar o initContainer privilegiado de amostra. Após os contêineres para as implementações serem inicializados, os privilégios serão eliminados.

1. Salve o daemonset a seguir em um arquivo denominado `worker-node-kernel-settings.yaml`. Na seção `spec.template.spec.initContainers`, inclua os campos e valores para os parâmetros `sysctl` que você deseja ajustar. Este daemonset de exemplo muda os valores dos parâmetros `net.core.somaxconn` e `net.ipv4.ip_local_port_range`.
    ```
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    metadata:
      name: kernel-optimization
      namespace: kube-system
      labels:
        tier: management
        app: kernel-optimization
    spec:
      template:
        metadata:
          labels:
            name: kernel-optimization
        spec:
          hostNetwork: true
          hostPID: true
          hostIPC: true
          initContainers:
            - :
                - sh
                - -c
                - sysctl -w net.ipv4.ip_local_port_range="1025 65535"; sysctl -w net.core.somaxconn=32768;
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
                capabilities:
                  add:
                    - NET_ADMIN
              volumeMounts:
                - name: modifysys
                  mountPath: /sys
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                    sleep 100000;
                  done
          volumes:
            - name: modifysys
              hostPath:
                path: /sys
    ```
    {: codeblock}

2. Aplique o daemonset aos nós do trabalhador. As mudanças são aplicadas imediatamente.
    ```
    kubectl apply -f worker-node-node-kernel-settings.yaml
    ```
    {: pre}

<br />

Para reverter os parâmetros `sysctl` de seus nós do trabalhador para os valores padrão configurados pelo {{site.data.keyword.containerlong_notm}}:

1. Exclua o daemonset. Os initContainers que aplicaram as configurações customizadas são removidos.
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [Reinicialize todos os nós do trabalhador no cluster](cs_cli_reference.html#cs_worker_reboot). Os nós do trabalhador voltam on-line, com os valores padrão aplicados.

<br />


## Otimizando o desempenho do pod
{: #pod}

Se você tiver demandas de carga de trabalho específicas, será possível aplicar uma correção de [initContainer ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) para mudar os parâmetros do kernel para os pods de app.
{: shortdesc}

**Nota**: deve-se ter a [função de acesso de Administrador](cs_users.html#access_policies) para executar o initContainer privilegiado de amostra. Após os contêineres para as implementações serem inicializados, os privilégios serão eliminados.

1. Salve a correção de initContainer a seguir em um arquivo denominado `pod-patch.yaml` e inclua os campos e valores para os parâmetros `sysctl` que você deseja ajustar. Esse initContainer de exemplo muda os valores dos parâmetros `net.core.somaxconn` e `net.ipv4.ip_local_local_port_range`.
    ```
    spec:
      template:
        spec:
          initContainers:
          - :
            - sh
            - -c
            - sysctl -e -w net.core.somaxconn=32768;  sysctl -e -w net.ipv4.ip_local_port_range="1025 65535";
            image: alpine:3.6
            imagePullPolicy: IfNotPresent
            name: sysctl
            resources: {}
            securityContext:
              privileged: true
    ```
    {: codeblock}

2. Corrigir cada uma de suas implementações.
    ```
    implementação kubectl patch deployment < deployment_name> -- patch pod-patch.yaml
    ```
    {: pre}

3. Se você mudou o valor `net.core.somaxconn` nas configurações do kernel, a maioria dos apps poderá usar automaticamente o valor atualizado. No entanto, alguns apps podem requerer que você mude manualmente o valor correspondente em seu código de app para corresponder ao valor de kernel. Por exemplo, se você está ajustando o desempenho de um pod no qual um app NGINX está sendo executado, deve-se mudar o valor do campo `backlog` no código de app NGINX para corresponder. Para obter mais informações, consulte esta [postagem do blog NGINX ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.nginx.com/blog/tuning-nginx/).
