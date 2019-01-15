---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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


# CLI changelog
{: #cs_cli_changelog}

No terminal, você é notificado quando atualizações para a CLI `ibmcloud` e plug-ins estão disponíveis. Certifique-se de manter sua CLI atualizada para que seja possível usar todos os comandos e sinalizações disponíveis.
{:shortdesc}

Para instalar o plug-in da CLI, veja [Instalando a CLI](cs_cli_install.html#cs_cli_install_steps).

Consulte a tabela a seguir para obter um resumo das mudanças para cada versão de plug-in da CLI.

<table summary="Visão geral das mudanças de versão do plug-in da CLI do {{site.data.keyword.containerlong_notm}}">
<caption>Changelog para o plug-in da CLI do  {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<tr>
<th>Versão</th>
<th>Data de liberação</th>
<th>Mudanças</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.1.654</td>
<td>05 de dezembro de 2018</td>
<td>Atualiza a documentação e a tradução.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15 de novembro de 2018</td>
<td>
<ul><li>Inclui o comando [<code>ibmcloud ks cluster-refresh</code>](cs_cli_reference.html#cs_cluster_refresh).</li>
<li>Inclui o nome do grupo de recursos na saída de <code>ibmcloud ks cluster-get</code> e <code>ibmcloud ks clusters</code>.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>06 de novembro de 2018</td>
<td>Inclui os comandos [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable),  [<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable), [<code>ibmcloud ks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get), [<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback) e [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) para gerenciar atualizações automáticas do complemento de cluster ALB do Ingress.
</td>
</tr>
<tr>
<td>0.1.621</td>
<td>30 de outubro de 2018</td>
<td><ul>
<li>Inclui o comando [<code>ibmcloud ks credential-get</code>](cs_cli_reference.html#cs_credential_get).</li>
<li>Inclui suporte para a origem de log de <code>armazenamento</code> em todos os comandos de criação de log do cluster. Para obter mais informações, veja <a href="cs_health.html#logging">Entendendo o cluster e o encaminhamento de log do app</a>.</li>
<li>Inclui o sinalizador `--network` no comando [<code>ibmcloud ks cluster-config</code>](cs_cli_reference.html#cs_cluster_config), que faz download do arquivo de configuração Calico para executar todos os comandos do Calico.</li>
<li>Correções de bug secundário e refatoração</li></ul>
</td>
</tr>
<tr>
<td>0,1.593</td>
<td>10 de outubro de 2018</td>
<td><ul><li>Inclui o ID do grupo de recursos na saída de <code>ibmcloud ks cluster-get</code>.</li>
<li>Quando o [{{site.data.keyword.keymanagementserviceshort}} está ativado](cs_encrypt.html#keyprotect) como um provedor de serviço de gerenciamento de chaves (KMS) em seu cluster, inclui o campo ativado pelo KMS na saída de <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0,1.591</td>
<td>02 de outubro de 2018</td>
<td>Inclui suporte para  [ grupos de recursos ](cs_clusters.html#prepare_account_level).</td>
</tr>
<tr>
<td>0,1.590</td>
<td>01 de outubro de 2018</td>
<td><ul>
<li>Inclui os comandos [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) e [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) para coletar logs do servidor de API em seu cluster.</li>
<li>Inclui o [comando <code>ibmcloud ks key-protect-enable</code>](cs_cli_reference.html#cs_key_protect) para ativar o {{site.data.keyword.keymanagementserviceshort}} como um provedor de serviço de gerenciamento de chaves (KMS) em seu cluster.</li>
<li>Inclui a sinalização <code>--skip-master-health</code> nos comandos [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) e [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) para ignorar a verificação de funcionamento principal antes de iniciar a reinicialização ou o recarregamento.</li>
<li>Renomeia <code>Owner Email</code> para <code>Owner</code> na saída de <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
