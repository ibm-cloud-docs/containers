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


# CLI changelog
{: #cs_cli_changelog}

No terminal, você é notificado quando atualizações para a CLI `ibmcloud` e plug-ins estão disponíveis. Certifique-se de manter sua CLI atualizada para que seja possível usar todos os comandos e sinalizações disponíveis.
{:shortdesc}

Para instalar o plug-in da CLI, veja [Instalando a CLI](cs_cli_install.html#cs_cli_install_steps).

Consulte a tabela a seguir para obter um resumo das mudanças para cada versão de plug-in da CLI.

<table summary="Log de mudanças para o plug-in da CLI do {{site.data.keyword.containerlong_notm}} ">
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
