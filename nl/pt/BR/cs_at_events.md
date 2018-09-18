---

copyright:
  years: 2017, 2018
lastupdated: "2018-08-06"

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

É possível visualizar, gerenciar e auditar atividades iniciadas pelo usuário em seu cluster do {{site.data.keyword.containershort_notm}} usando o serviço {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

## Localizando as informações
{: #at-find}

Os eventos do {{site.data.keyword.cloudaccesstrailshort}} estão disponíveis no
{{site.data.keyword.cloudaccesstrailshort}} **domínio de contas** disponível na região do
{{site.data.keyword.Bluemix_notm}} na qual eles são gerados. Os eventos do {{site.data.keyword.cloudaccesstrailshort}} estão disponíveis no **domínio de espaço** do {{site.data.keyword.cloudaccesstrailshort}} que está associado ao espaço do Cloud Foundry no qual o serviço {{site.data.keyword.cloudaccesstrailshort}} é provisionado.

Para monitorar a atividade administrativa:

1. Efetue login em sua conta do  {{site.data.keyword.Bluemix_notm}} .
2. No catálogo, provisione uma instância do serviço {{site.data.keyword.cloudaccesstrailshort}} na mesma conta que sua instância do {{site.data.keyword.containershort_notm}}.
3. Na guia **Gerenciar** do painel do {{site.data.keyword.cloudaccesstrailshort}}, clique em **Visualizar no Kibana**.
4. Configure o prazo durante o qual deseja visualizar os logs. O padrão é 15 min.
5. Na lista **Campos disponíveis**, clique em **tipo**. Clique no ícone de lupa para o **Activity Tracker** para limitar os logs somente aos rastreados pelo serviço.
6. É possível usar os outros campos disponíveis para limitar sua procura.



## Eventos de rastreamento
{: #events}

Confira as tabelas a seguir para obter uma lista dos eventos que são enviados para o {{site.data.keyword.cloudaccesstrailshort}}.

Para obter mais informações sobre como o serviço funciona, consulte a [documentação do {{site.data.keyword.cloudaccesstrailshort}}](/docs/services/cloud-activity-tracker/index.html).

Para obter mais informações sobre as ações do Kubernetes que são rastreadas, revise a [documentação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/home/).

<table>
  <tr>
    <th>Ação</th>
    <th>Descrição</th>
  </tr>
  <tr>
    <td><code> bindings.create </code></td>
    <td>Uma ligação é criada.</td>
  </tr>
  <tr>
    <td><code> configmaps.create </code></td>
    <td>Um mapa de configuração é criado.</td>
  </tr>
  <tr>
    <td><code> configmaps.delete </code></td>
    <td>Um mapa de configuração foi excluído.</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>Um mapa de configuração é corrigido.</td>
  </tr>
  <tr>
    <td><code> configmaps.update </code></td>
    <td>Um mapa de configuração é atualizado.</td>
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
    <td><code>limitranges.create</code></td>
    <td>Um limite de intervalo é criado.</td>
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
    <td><code> namespaces.create </code></td>
    <td>Um namespace é criado.</td>
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
    <td><code> nodes.create </code></td>
    <td>Um nó é criado.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>Um nó foi excluído.</td>
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
    <td><code> localsubjectaccesscesscesscessreviews.create </code></td>
    <td>Uma revisão de acesso de assunto local foi criada.</td>
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
    <td><code> poddisruptionbugets.create </code></td>
    <td>Um buget de interrupção do pod foi criado.</td>
  </tr>
  <tr>
    <td><code> poddisruptionbugets.delete </code></td>
    <td>Um buget de interrupção do pod foi excluído.</td>
  </tr>
  <tr>
    <td><code> poddisruptionbugets.patch </code></td>
    <td>Um bóia de interrupção do pod foi corrigido.</td>
  </tr>
  <tr>
    <td><code> poddisruptionbugets.update </code></td>
    <td>Um buget de interrupção do pod foi atualizado.</td>
  </tr>
  <tr>
    <td><code> clusterbindings.create </code></td>
    <td>Uma ligação de função de cluster é criada.</td>
  </tr>
  <tr>
    <td><code> clusterbindings.deleted </code></td>
    <td>Uma ligação de função de cluster foi excluída.</td>
  </tr>
  <tr>
    <td><code> clusterbindings.patched </code></td>
    <td>Uma ligação de função de cluster é corrigida.</td>
  </tr>
  <tr>
    <td><code> clusterbindings.updated </code></td>
    <td>Uma ligação de função de cluster é atualizada.</td>
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
</table>
