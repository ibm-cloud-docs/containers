---

copyright:
  years: 2017, 2018
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


# {{site.data.keyword.cloudaccesstrailshort}} events
{: #at_events}

É possível visualizar, gerenciar e auditar atividades iniciadas pelo usuário em seu cluster do {{site.data.keyword.containerlong_notm}} usando o serviço {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

O  {{site.data.keyword.containershort_notm}}  gera dois tipos de eventos do  {{site.data.keyword.cloudaccesstrailshort}} :

* ** Eventos de gerenciamento de cluster **:
    * Esses eventos são gerados automaticamente e encaminhados para o {{site.data.keyword.cloudaccesstrailshort}}.
    * É possível visualizar esses eventos por meio do **domínio de contas** do {{site.data.keyword.cloudaccesstrailshort}}.

* ** Eventos de auditoria do servidor da API do Kubernetes **:
    * Esses eventos são gerados automaticamente, mas deve-se configurar seu cluster para encaminhar esses eventos para o serviço {{site.data.keyword.cloudaccesstrailshort}}.
    * É possível configurar seu cluster para enviar eventos para o **domínio de contas** ou para um **domínio de espaço** do {{site.data.keyword.cloudaccesstrailshort}}. Para obter mais informações, consulte [Enviando logs de auditoria](/docs/containers/cs_health.html#api_forward).

Para obter mais informações sobre como o serviço funciona, veja a [documentação do {{site.data.keyword.cloudaccesstrailshort}}](/docs/services/cloud-activity-tracker/index.html). Para obter mais informações sobre as ações do Kubernetes que são rastreadas, revise a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/home/).

## Localizando informações para eventos
{: #kube-find}

Para monitorar a atividade administrativa:

1. Efetue login em sua conta do  {{site.data.keyword.Bluemix_notm}} .
2. No catálogo, provisione uma instância do serviço {{site.data.keyword.cloudaccesstrailshort}} na mesma conta que sua instância do {{site.data.keyword.containerlong_notm}}.
3. Na guia **Gerenciar** do painel do {{site.data.keyword.cloudaccesstrailshort}}, selecione o domínio de conta ou de espaço.
  * **Logs de conta**: os eventos de gerenciamento de cluster e os eventos de auditoria do servidor de API do Kubernetes estão disponíveis no **domínio de contas** para a região do {{site.data.keyword.Bluemix_notm}} em que os eventos são gerados.
  * **Logs de espaço**: se você especificou um espaço quando configurou seu cluster para encaminhar eventos de auditoria do servidor de API do Kubernetes, esses eventos estarão disponíveis no **domínio de espaço** que está associado ao espaço do Cloud Foundry no qual o serviço {{site.data.keyword.cloudaccesstrailshort}} é provisionado.
4. Clique em  ** Visualizar no Kibana **.
5. Configure o prazo durante o qual deseja visualizar os logs. O padrão é 24 horas.
6. Para limitar sua procura, é possível clicar no ícone de edição para `ActivityTracker_Account_Search_in_24h` e incluir campos na coluna **Campos disponíveis**.

Para permitir que outros usuários visualizem eventos de conta e espaço, consulte [Concedendo permissões para ver eventos de conta](/docs/services/cloud-activity-tracker/how-to/grant_permissions.html#grant_permissions).
{: tip}

## Rastreando eventos de gerenciamento de cluster
{: #cluster-events}

Verifique a lista a seguir dos eventos de gerenciamento de cluster que são enviados para o {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

<table>
<tr>
<th>Ação</th>
<th>Descrição</th></tr><tr>
<td><code> containers-kubernetes.account-credentials.set </code></td>
<td>As credenciais de infraestrutura em uma região para um grupo de recursos foram configuradas.</td></tr><tr>
<td><code>containers-kubernetes.account-credentials.unset</code></td>
<td>As credenciais de infraestrutura em uma região para um grupo de recursos foram desconfiguradas.</td></tr><tr>
<td><code> containers-kubernetes.alb.create </code></td>
<td>Um ALB de Ingresso foi criado.</td></tr><tr>
<td><code> containers-kubernetes.alb.delete </code></td>
<td>Um ALB de Ingresso foi excluído.</td></tr><tr>
<td><code> containers-kubernetes.alb.get </code></td>
<td>As informações de ALB de Ingresso foram visualizadas.</td></tr><tr>
<td><code> containers-kubernetes.apikey.reset </code></td>
<td>Uma chave API foi reconfigurada para uma região e um grupo de recursos.</td></tr><tr>
<td><code> containers-kubernetes.cluster.create </code></td>
<td>Um cluster foi criado.</td></tr><tr>
<td><code> containers-kubernetes.cluster.delete </code></td>
<td>Um cluster foi excluído.</td></tr><tr>
<td><code> containers-kubernetes.cluster-feature.enable </code></td>
<td>Um recurso, como Cálculo confiável para nós do trabalhador bare metal, foi ativado em um cluster.</td></tr><tr>
<td><code>containers-kubernetes.cluster.get</code></td>
<td>As informações de cluster foram visualizadas.</td></tr><tr>
<td><code> containers-kubernetes.logging-config.create </code></td>
<td>Uma configuração de encaminhamento de log foi criada.</td></tr><tr>
<td><code> containers-kubernetes.logging-config.delete </code></td>
<td>Uma configuração de encaminhamento de logs foi excluída.</td></tr><tr>
<td><code> containers-kubernetes.logging-config.get </code></td>
<td>As informações para uma configuração de encaminhamento de logs foram visualizadas.</td></tr><tr>
<td><code> containers-kubernetes.logging-config.update </code></td>
<td>Uma configuração de encaminhamento de log foi atualizada.</td></tr><tr>
<td><code> containers-kubernetes.logging-config.refresh </code></td>
<td>Uma configuração de encaminhamento de log foi atualizada.</td></tr><tr>
<td><code> containers-kubernetes.logging-filter.create </code></td>
<td>Um filtro de criação de log foi criado.</td></tr><tr>
<td><code> containers-kubernetes.logging-filter.delete </code></td>
<td>Um filtro de criação de log foi excluído.</td></tr><tr>
<td><code> containers-kubernetes.logging-filter.get </code></td>
<td>As informações para um filtro de criação de log foram visualizadas.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.update</code></td>
<td>Um filtro de criação de log foi atualizado.</td></tr><tr>
<td><code> containers-kubernetes.logging-autoupdate.alteradas </code></td>
<td>O atualizador automático de complemento de criação de log foi ativado ou desativado.</td></tr><tr>
<td><code> containers-kubernetes.mzlb.create </code></td>
<td>Um balanceador de carga multizona foi criado.</td></tr><tr>
<td><code> containers-kubernetes.mzlb.delete </code></td>
<td>Um balanceador de carga de múltiplas zonas foi excluído.</td></tr><tr>
<td><code> containers-kubernetes.service.bind </code></td>
<td>Um serviço foi ligado a um cluster.</td></tr><tr>
<td><code> containers-kubernetes.service.unbind </code></td>
<td>Um serviço foi desvinculado de um cluster.</td></tr><tr>
<td><code> containers-kubernetes.subnet.add </code></td>
<td>Uma sub-rede de infraestrutura do IBM Cloud (SoftLayer) existente foi incluída em um cluster.</td></tr><tr>
<td><code> containers-kubernetes.subnet.create </code></td>
<td>Uma sub-rede foi criada.</td></tr><tr>
<td><code> containers-kubernetes.usersubnet.add </code></td>
<td>Uma sub-rede gerenciada pelo usuário foi incluída em um cluster.</td></tr><tr>
<td><code>containers-kubernetes.usersubnet.delete</code></td>
<td>Uma sub-rede gerenciada pelo usuário foi removida de um cluster.</td></tr><tr>
<td><code> containers-kubernetes.version.update </code></td>
<td>A versão do Kubernetes de um nó principal do cluster foi atualizada.</td></tr><tr>
<td><code> containers-kubernetes.worker.create </code></td>
<td>Um nó do trabalhador foi criado.</td></tr><tr>
<td><code> containers-kubernetes.worker.delete </code></td>
<td>Um nó do trabalhador foi excluído.</td></tr><tr>
<td><code> containers-kubernetes.worker.get </code></td>
<td>As informações para um nó do trabalhador foram visualizadas.</td></tr><tr>
<td><code> containers-kubernetes.worker.reboot </code></td>
<td>Um nó do trabalhador foi reinicializado.</td></tr><tr>
<td><code> containers-kubernetes.worker.reload </code></td>
<td>Um nó do trabalhador foi recarregado.</td></tr><tr>
<td><code> containers-kubernetes.worker.update </code></td>
<td>Um nó do trabalhador foi atualizado.</td></tr>
</table>

## Rastreando eventos de auditoria do Kubernetes
{: #kube-events}

Verifique a tabela a seguir para obter uma lista dos eventos de auditoria do servidor de API do Kubernetes que são enviados para o {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

Antes de iniciar: certifique-se de que seu cluster esteja configurado para encaminhar os [eventos de auditoria da API do Kubernetes](cs_health.html#api_forward).

<table>
  <tr>
    <th>Ação</th>
    <th>Descrição</th>
  </tr>
  <tr>
    <td><code> bindings.create </code></td>
    <td>Uma ligação foi criada.</td>
  </tr>
  <tr>
    <td><code> certificatesigningrequests.create </code></td>
    <td>Uma solicitação para assinar um certificado foi criada.</td>
  </tr>
  <tr>
    <td><code> certificatesigningrequests.delete </code></td>
    <td>Uma solicitação para assinar um certificado foi excluída.</td>
  </tr>
  <tr>
    <td><code> certificatesigningrequests.patch </code></td>
    <td>Uma solicitação para assinar um certificado foi corrigida.</td>
  </tr>
  <tr>
    <td><code> certificatesigningrequests.update </code></td>
    <td>Uma solicitação para assinar um certificado foi atualizada.</td>
  </tr>
  <tr>
    <td><code> clusterbindings.create </code></td>
    <td>Uma ligação de função de cluster foi criada.</td>
  </tr>
  <tr>
    <td><code> clusterbindings.deleted </code></td>
    <td>Uma ligação de função de cluster foi excluída.</td>
  </tr>
  <tr>
    <td><code> clusterbindings.patched </code></td>
    <td>Uma ligação de função de cluster foi corrigida.</td>
  </tr>
  <tr>
    <td><code> clusterbindings.updated </code></td>
    <td>Uma ligação de função de cluster foi atualizada.</td>
  </tr>
  <tr>
    <td><code> clusterroles.create </code></td>
    <td>Uma função de cluster foi criada.</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>Uma função de cluster foi excluída.</td>
  </tr>
  <tr>
    <td><code> clusterroles.patched </code></td>
    <td>Uma função de cluster foi corrigida.</td>
  </tr>
  <tr>
    <td><code> clusterroles.updated </code></td>
    <td>Uma função de cluster foi atualizada.</td>
  </tr>
  <tr>
    <td><code> configmaps.create </code></td>
    <td>Um mapa de configuração foi criado.</td>
  </tr>
  <tr>
    <td><code> configmaps.delete </code></td>
    <td>Um mapa de configuração foi excluído.</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>Um mapa de configuração foi corrigido.</td>
  </tr>
  <tr>
    <td><code> configmaps.update </code></td>
    <td>Um mapa de configuração foi atualizado.</td>
  </tr>
  <tr>
    <td><code> controllerrevisions.create </code></td>
    <td>Uma revisão do controlador foi criada.</td>
  </tr>
  <tr>
    <td><code> controllerrevisions.delete </code></td>
    <td>Uma revisão do controlador foi excluída.</td>
  </tr>
  <tr>
    <td><code> controllerrevisions.patch </code></td>
    <td>Uma revisão do controlador foi corrigida.</td>
  </tr>
  <tr>
    <td><code> controllerrevisions.update </code></td>
    <td>Uma revisão do controlador foi atualizada.</td>
  </tr>
  <tr>
    <td><code> daemonsets.create </code></td>
    <td>Um conjunto de daemons foi criado.</td>
  </tr>
  <tr>
    <td><code> daemonsets.delete </code></td>
    <td>Um conjunto de daemon foi excluído.</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>Um conjunto de daemons foi corrigido.</td>
  </tr>
  <tr>
    <td><code> daemonsets.update </code></td>
    <td>Um conjunto de daemon foi atualizado.</td>
  </tr>
  <tr>
    <td><code> deployments.create </code></td>
    <td>Uma implementação foi criada.</td>
  </tr>
  <tr>
    <td><code> deployments.delete </code></td>
    <td>Uma implementação foi excluída.</td>
  </tr>
  <tr>
    <td><code> deployments.patch </code></td>
    <td>Uma implementação foi corrigida.</td>
  </tr>
  <tr>
    <td><code> deployments.update </code></td>
    <td>Uma implementação foi atualizada.</td>
  </tr>
  <tr>
    <td><code> events.create </code></td>
    <td>Um evento foi criado.</td>
  </tr>
  <tr>
    <td><code> events.delete </code></td>
    <td>Um evento foi excluído.</td>
  </tr>
  <tr>
    <td><code> events.patch </code></td>
    <td>Um evento foi corrigido.</td>
  </tr>
  <tr>
    <td><code> events.update </code></td>
    <td>Um evento foi atualizado.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>No Kubernetes v1.8, uma configuração de gancho de admissões externas foi criada.</td>
  </tr>
  <tr>
    <td><code> externaladmissionhookconfigurations.delete </code></td>
    <td>No Kubernetes v1.8, uma configuração de gancho de admissões externas foi excluída.</td>
  </tr>
  <tr>
    <td><code> externaladmissionhookconfigurationconfigurations.patch </code></td>
    <td>No Kubernetes v1.8, uma configuração de gancho de admissões externas foi corrigida.</td>
  </tr>
  <tr>
    <td><code> externaladmissionhookconfigurations.update </code></td>
    <td>No Kubernetes v1.8, uma configuração de gancho de admissões externas foi atualizada.</td>
  </tr>
  <tr>
    <td><code> horizontalpodautoscalers.create </code></td>
    <td>Uma política de ajuste automático de escala de pod horizontal foi criada.</td>
  </tr>
  <tr>
    <td><code> horizontalpodautoscalers.delete </code></td>
    <td>Uma política de ajuste automático de escala de pod horizontal foi excluída.</td>
  </tr>
  <tr>
    <td><code> horizontalpodautoscalers.patch </code></td>
    <td>Uma política de ajuste automático de escala de pod horizontal foi corrigida.</td>
  </tr>
  <tr>
    <td><code> horizontalpodautoscalers.update </code></td>
    <td>Uma política de ajuste automático de escala de pod horizontal foi atualizada.</td>
  </tr>
  <tr>
    <td><code> ingresses.create </code></td>
    <td>Um ALB de Ingresso foi criado.</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>Um ALB de Ingresso foi excluído.</td>
  </tr>
  <tr>
    <td><code> ingresses.patch </code></td>
    <td>Um ALB de Ingresso foi corrigido.</td>
  </tr>
  <tr>
    <td><code> ingresses.update </code></td>
    <td>Um ALB de Ingresso foi atualizado.</td>
  </tr>
  <tr>
    <td><code> jobs.create </code></td>
    <td>Uma tarefa foi criada.</td>
  </tr>
  <tr>
    <td><code> jobs.delete </code></td>
    <td>Uma tarefa foi excluída.</td>
  </tr>
  <tr>
    <td><code> jobs.patch </code></td>
    <td>Uma tarefa foi corrigida.</td>
  </tr>
  <tr>
    <td><code> jobs.update </code></td>
    <td>Uma tarefa foi atualizada.</td>
  </tr>
  <tr>
    <td><code> localsubjectaccesscesscesscessreviews.create </code></td>
    <td>Uma revisão de acesso de assunto local foi criada.</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>Um limite de intervalo foi criado.</td>
  </tr>
  <tr>
    <td><code> UNK tranges.delete </code></td>
    <td>Um limite de intervalo foi excluído.</td>
  </tr>
  <tr>
    <td><code> UNK tranges.patch </code></td>
    <td>Um limite de intervalo foi corrigido.</td>
  </tr>
  <tr>
    <td><code> UNK tranges.update </code></td>
    <td>Um limite de intervalo foi atualizado.</td>
  </tr>
  <tr>
    <td><code> mutatingwebhookconfigurations.create </code></td>
    <td>No Kubernetes v1.9 e mais recente, uma configuração de webhook mutante foi criada.</td>
  </tr>
  <tr>
    <td><code> mutatingwebhookconfigurations.delete </code></td>
    <td>No Kubernetes v1.9 e mais recente, uma configuração de webhook mutante foi excluída.</td>
  </tr>
  <tr>
    <td><code> mutatingwebhookconfigurations.patch </code></td>
    <td>No Kubernetes v1.9 e mais recente, uma configuração de webhook mutante foi corrigida.</td>
  </tr>
  <tr>
    <td><code> mutatingwebhookconfigurations.update </code></td>
    <td>No Kubernetes v1.9 e mais recente, uma configuração de webhook mutante foi atualizada.</td>
  </tr>
  <tr>
    <td><code> namespaces.create </code></td>
    <td>Um namespace foi criado.</td>
  </tr>
  <tr>
    <td><code> namespaces.delete </code></td>
    <td>Um namespace foi excluído.</td>
  </tr>
  <tr>
    <td><code> namespaces.patch </code></td>
    <td>Um namespace foi corrigido.</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>Um namespace foi atualizado.</td>
  </tr>
  <tr>
    <td><code> networkpolicies.create </code></td>
    <td>Uma política de rede foi criada.</td>
  </tr>
  <tr>
    <td><code> networkpolicies.delete </code></td>
    <td>Uma política de rede foi excluída.</td>
  </tr>
  <tr>
    <td><code> networkpolicies.patch </code></td>
    <td>Uma política de rede foi corrigida.</td>
  </tr>
  <tr>
    <td><code> networkpolicies.update </code></td>
    <td>Uma política de rede foi atualizada.</td>
  </tr>
  <tr>
    <td><code> nodes.create </code></td>
    <td>Um nó é criado.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>Um nó foi excluído.</td>
  </tr>
  <tr>
    <td><code> nodes.patch </code></td>
    <td>Um nó foi corrigido.</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>Um nó foi atualizado.</td>
  </tr>
  <tr>
    <td><code> persistentvolumeclaims.create </code></td>
    <td>Uma solicitação de volume persistente foi criada.</td>
  </tr>
  <tr>
    <td><code> persistentvolumeclaims.delete </code></td>
    <td>Uma solicitação de volume persistente foi excluída.</td>
  </tr>
  <tr>
    <td><code> persistentvolumeclaims.patch </code></td>
    <td>Uma solicitação de volume persistente foi corrigida.</td>
  </tr>
  <tr>
    <td><code> persistentvolumeclaims.update </code></td>
    <td>Uma solicitação de volume persistente foi atualizada.</td>
  </tr>
  <tr>
    <td><code> persistentvolumes.create </code></td>
    <td>Um volume persistente foi criado.</td>
  </tr>
  <tr>
    <td><code> persistentvolumes.delete </code></td>
    <td>Um volume persistente foi excluído.</td>
  </tr>
  <tr>
    <td><code> persistentvolumes.patch </code></td>
    <td>Um volume persistente foi corrigido.</td>
  </tr>
  <tr>
    <td><code> persistentvolumes.update </code></td>
    <td>Um volume persistente foi atualizado.</td>
  </tr>
  <tr>
    <td><code> poddisruptionbudgets.create </code></td>
    <td>Um orçamento de interrupção do pod foi criado.</td>
  </tr>
  <tr>
    <td><code> poddisruptionbudgets.delete </code></td>
    <td>Um orçamento de interrupção do pod foi excluído.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.patch</code></td>
    <td>Um orçamento de interrupção do pod foi corrigido.</td>
  </tr>
  <tr>
    <td><code> poddisruptionbudgets.update </code></td>
    <td>Um orçamento de interrupção de pod foi atualizado.</td>
  </tr>
  <tr>
    <td><code> podpresets.create </code></td>
    <td>Uma pré-configuração de pod foi criada.</td>
  </tr>
  <tr>
    <td><code> podpresets.deleted </code></td>
    <td>Uma pré-configuração de pod foi excluída.</td>
  </tr>
  <tr>
    <td><code> podpresets.patched </code></td>
    <td>Uma pré-configuração de pod foi corrigida.</td>
  </tr>
  <tr>
    <td><code> podpresets.updated </code></td>
    <td>Uma pré-configuração de pod foi atualizada.</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>Um pod foi criado.</td>
  </tr>
  <tr>
    <td><code> pods.delete </code></td>
    <td>Um pod foi excluído.</td>
  </tr>
  <tr>
    <td><code> pods.patch </code></td>
    <td>Um pod foi remendado.</td>
  </tr>
  <tr>
    <td><code> pods.update </code></td>
    <td>Um pod foi atualizado.</td>
  </tr>
  <tr>
    <td><code> podsecuritypolicies.create </code></td>
    <td>Para o Kubernetes v1.10 e superior, uma política de segurança de pod foi criada.</td>
  </tr>
  <tr>
    <td><code> podsecuritypolicies.delete </code></td>
    <td>Para o Kubernetes v1.10 e superior, uma política de segurança de pod foi excluída.</td>
  </tr>
  <tr>
    <td><code> podsecuritypolicies.patch </code></td>
    <td>Para o Kubernetes v1.10 e superior, uma política de segurança de pod foi corrigida.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>Para o Kubernetes v1.10 e superior, uma política de segurança de pod foi atualizada.</td>
  </tr>
  <tr>
    <td><code> podtemplates.create </code></td>
    <td>Um modelo de pod foi criado.</td>
  </tr>
  <tr>
    <td><code> podtemplates.delete </code></td>
    <td>Um modelo de pod foi excluído.</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>Um modelo de pod foi corrigido.</td>
  </tr>
  <tr>
    <td><code> podtemplates.update </code></td>
    <td>Um modelo de pod foi atualizado.</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>Um conjunto de réplicas foi criado.</td>
  </tr>
  <tr>
    <td><code> replicasets.delete </code></td>
    <td>Um conjunto de réplicas foi excluído.</td>
  </tr>
  <tr>
    <td><code> replicasets.patch </code></td>
    <td>Um conjunto de réplicas foi corrigido.</td>
  </tr>
  <tr>
    <td><code> replicasets.update </code></td>
    <td>Um conjunto de réplicas foi atualizado.</td>
  </tr>
  <tr>
    <td><code> replicationcontrollers.create </code></td>
    <td>Um controlador de replicação foi criado.</td>
  </tr>
  <tr>
    <td><code> replicationcontrollers.delete </code></td>
    <td>Um controlador de replicação foi excluído.</td>
  </tr>
  <tr>
    <td><code> replicationcontrollers.patch </code></td>
    <td>Um controlador de replicação foi corrigido.</td>
  </tr>
  <tr>
    <td><code> replicationcontrollers.update </code></td>
    <td>Um controlador de replicação foi atualizado.</td>
  </tr>
  <tr>
    <td><code> resourcequotas.create </code></td>
    <td>Uma cota de recurso foi criada.</td>
  </tr>
  <tr>
    <td><code> resourcequotas.delete </code></td>
    <td>Uma cota de recurso foi excluída.</td>
  </tr>
  <tr>
    <td><code> resourcequotas.patch </code></td>
    <td>Uma cota de recurso foi corrigida.</td>
  </tr>
  <tr>
    <td><code> resourcequotas.update </code></td>
    <td>Uma cota de recurso foi atualizada.</td>
  </tr>
  <tr>
    <td><code> rolebindings.create </code></td>
    <td>Uma ligação de função foi criada.</td>
  </tr>
  <tr>
    <td><code> rolebindings.deleted </code></td>
    <td>Uma ligação de função foi excluída.</td>
  </tr>
  <tr>
    <td><code> rolebindings.patched </code></td>
    <td>Uma ligação de função foi corrigida.</td>
  </tr>
  <tr>
    <td><code> rolebindings.updated </code></td>
    <td>Uma ligação de função foi atualizada.</td>
  </tr>
  <tr>
    <td><code> roles.create </code></td>
    <td>Uma função foi criada.</td>
  </tr>
  <tr>
    <td><code> roles.deleted </code></td>
    <td>Uma função foi excluída.</td>
  </tr>
  <tr>
    <td><code> roles.patched </code></td>
    <td>Uma função foi corrigida.</td>
  </tr>
  <tr>
    <td><code> roles.updated </code></td>
    <td>Uma função foi atualizada.</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>Um segredo foi criado.</td>
  </tr>
  <tr>
    <td><code> secrets.deleted </code></td>
    <td>Um segredo foi excluído.</td>
  </tr>
  <tr>
    <td><code> secrets.get </code></td>
    <td>Um segredo foi visualizado.</td>
  </tr>
  <tr>
    <td><code> secrets.patch </code></td>
    <td>Um segredo foi corrigido.</td>
  </tr>
  <tr>
    <td><code> secrets.updated </code></td>
    <td>Um segredo foi atualizado.</td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>Uma revisão de acesso de autoassunto foi criada.</td>
  </tr>
  <tr>
    <td><code> selfsubjectrouesreviews.create </code></td>
    <td>Uma revisão de regras de autoassunto foi criada.</td>
  </tr>
  <tr>
    <td><code> subjectaccessreviewreviews.create </code></td>
    <td>Uma revisão de acesso de assunto foi criada.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>Uma conta de serviço foi criada.</td>
  </tr>
  <tr>
    <td><code> serviceaccounts.deleted </code></td>
    <td>Uma conta de serviço foi excluída.</td>
  </tr>
  <tr>
    <td><code> serviceaccounts.patch </code></td>
    <td>Uma conta do serviço foi corrigida.</td>
  </tr>
  <tr>
    <td><code> serviceaccounts.updated </code></td>
    <td>Uma conta de serviço foi atualizada.</td>
  </tr>
  <tr>
    <td><code> services.create </code></td>
    <td>Um serviço foi criado.</td>
  </tr>
  <tr>
    <td><code> services.deleted </code></td>
    <td>Um serviço foi excluído.</td>
  </tr>
  <tr>
    <td><code> services.patch </code></td>
    <td>Um serviço foi corrigido.</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>Um serviço foi atualizado.</td>
  </tr>
  <tr>
    <td><code> statefulsets.create </code></td>
    <td>Um conjunto stateful foi criado.</td>
  </tr>
  <tr>
    <td><code> statefulsets.delete </code></td>
    <td>Um conjunto stateful foi excluído.</td>
  </tr>
  <tr>
    <td><code> statefulsets.patch </code></td>
    <td>Um conjunto stateful foi corrigido.</td>
  </tr>
  <tr>
    <td><code> statefulsets.update </code></td>
    <td>Um conjunto stateful foi atualizado.</td>
  </tr>
  <tr>
    <td><code> tokenreviews.create </code></td>
    <td>Uma revisão de token foi criada.</td>
  </tr>
  <tr>
    <td><code> validatingwebhookconfigurations.create </code></td>
    <td>No Kubernetes v1.9 e mais recente, uma validação de configuração de webhook foi criada.</td>
  </tr>
  <tr>
    <td><code> validatingwebhookconfigurations.delete </code></td>
    <td>No Kubernetes v1.9 e mais recente, uma validação de configuração de webhook foi excluída.</td>
  </tr>
  <tr>
    <td><code> validatingwebhookconfigurations.patch </code></td>
    <td>No Kubernetes v1.9 e mais recente, uma validação de configuração de webhook foi corrigida.</td>
  </tr>
  <tr>
    <td><code> validatingwebhookconfigurations.update </code></td>
    <td>No Kubernetes v1.9 e mais recente, uma validação de configuração de webhook foi atualizada.</td>
  </tr>
</table>
