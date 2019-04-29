---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

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



# Suas responsabilidades usando {{site.data.keyword.containerlong_notm}}
Saiba mais sobre as responsabilidades de gerenciamento de cluster e termos e condições que você tem ao usar o {{site.data.keyword.containerlong}}.
{:shortdesc}

## Responsabilidades de gerenciamento de cluster
{: #responsibilities}

Revise as responsabilidades que você compartilha com a IBM para gerenciar seus clusters.
{:shortdesc}

**A IBM é responsável por:**

- Implementar o mestre, nós do trabalhador e componentes de gerenciamento dentro do cluster, como balanceador de carga de aplicativo de Ingresso, no tempo de criação do cluster
- Fornecer as atualizações de segurança, o monitoramento, o isolamento e a recuperação do mestre do Kubernetes para o cluster
- Fazendo atualizações de versão e correções de segurança disponíveis para você aplicar aos seus nós do trabalhador do cluster
- Monitorar o funcionamento dos nós do trabalhador e fornecer automação para a atualização e a recuperação dos nós do trabalhador
- Executar tarefas de automação em sua conta de infraestrutura, incluindo adicionar nós do trabalhador, remover nós do trabalhador e criar uma sub-rede padrão
- Gerenciar, atualizar e recuperar componentes operacionais dentro do cluster, tais como o balanceador de carga de aplicativo de Ingresso e o plug-in de armazenamento
- Provisionar volumes de armazenamento quando solicitado pelas solicitações de volume persistente
- Fornecer configurações de segurança em todos os nós do trabalhador

</br>

**Você é responsável por:**

- [Configurando a chave de API do {{site.data.keyword.containerlong_notm}} com as permissões apropriadas para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer) e outros serviços do {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-users#api_key)
- [Implementar e gerenciar recursos do Kubernetes, como pods, serviços e implementações no cluster](/docs/containers?topic=containers-app#app_cli)
- [Usar os recursos do serviço e o Kubernetes para assegurar a alta disponibilidade de apps](/docs/containers?topic=containers-app#highly_available_apps)
- [Incluindo ou removendo a capacidade do cluster redimensionando seus conjuntos de trabalhadores](/docs/containers?topic=containers-clusters#add_workers)
- [Ativando o VLAN Spanning e mantendo os seus conjuntos de trabalhadores de múltiplas zonas balanceados entre as zonas](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [Criar VLANs públicas e privadas na infraestrutura do IBM Cloud (SoftLayer) para isolamento da rede de seu cluster](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [Assegurando que todos os nós do trabalhador tenham conectividade de rede com as URLs de terminal em serviço do Kubernetes](/docs/containers?topic=containers-firewall#firewall) <p class="note">Se um nó do trabalhador tiver VLANs públicas e privadas, a conectividade de rede será configurada. Se os nós do trabalhador estão configurados somente com uma VLAN privada, deve-se permitir que os nós do trabalhador e o cluster mestre se comuniquem [ativando o terminal em serviço privado](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) ou [configurando um dispositivo de gateway](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway). Se você configurar um firewall, deverá gerenciar e configurar suas configurações para permitir acesso para o {{site.data.keyword.containerlong_notm}} e outros serviços do {{site.data.keyword.Bluemix_notm}} que você usa com o cluster.</p>
- [Atualizando o kube-apiserver do mestre quando as atualizações da versão do Kubernetes estão disponíveis](/docs/containers?topic=containers-update#master)
- [Mantendo os nós do trabalhador atualizados em versões principais, secundárias e de correção](/docs/containers?topic=containers-update#worker_node) <p class="note">Não é possível mudar o sistema operacional de seu nó do trabalhador ou efetuar login no nó do trabalhador. As atualizações do nó do trabalhador são fornecidas pela IBM como uma imagem de nó do trabalhador integral que inclui as correções de segurança mais recentes. Para aplicar as atualizações, o nó do trabalhador deve ser reformulado e recarregado com a nova imagem. As chaves para o usuário raiz são giradas automaticamente quando o nó do trabalhador é recarregado. </p>
- [Monitorando o funcionamento de seu cluster configurando o encaminhamento de log para seus componentes de cluster](/docs/containers?topic=containers-health#health).   
- [Recuperando nós do trabalhador problemáticos executando comandos `kubectl`, como `cordon` ou `drain`, e executando comandos `ibmcloud ks`, como `reboot`, `reload` ou `delete`](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)
- [Incluindo ou removendo sub-redes na infraestrutura do IBM Cloud (SoftLayer) conforme necessário](/docs/containers?topic=containers-subnets#subnets)
- [Fazer backup e restaurar dados no armazenamento persistente na infraestrutura do IBM Cloud (SoftLayer) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- Configurando os serviços de [criação de log](/docs/containers?topic=containers-health#logging) e de [monitoramento](/docs/containers?topic=containers-health#view_metrics) para suportar o funcionamento e o desempenho de seu cluster
- [Configurando o monitoramento de funcionamento para os nós do trabalhador com Recuperação automática](/docs/containers?topic=containers-health#autorecovery)
- Auditando eventos que mudam recursos em seu cluster, como usando [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events) para visualizar atividades iniciadas pelo usuário que mudam o estado de sua instância do {{site.data.keyword.containerlong_notm}}

<br />


## Abuso do {{site.data.keyword.containerlong_notm}}
{: #terms}

Os clientes não podem fazer uso inadequado do {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Uso inadequado inclui:

*   Qualquer atividade ilegal
*   Distribuição ou execução de malware
*   Prejudicar o {{site.data.keyword.containerlong_notm}} ou interferir no
uso de alguém do {{site.data.keyword.containerlong_notm}}
*   Prejudicar ou interferir no uso de alguém de qualquer outro serviço ou sistema
*   Acesso não autorizado a qualquer serviço ou sistema
*   Modificação não autorizada de qualquer serviço ou sistema
*   Violação dos direitos de outros

Veja [Termos dos serviços
de nuvem](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms) para obter os termos gerais de uso.
