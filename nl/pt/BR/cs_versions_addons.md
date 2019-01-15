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


# Log de mudanças de complementos do cluster

Seu cluster do {{site.data.keyword.containerlong}} vem com complementos que são atualizados automaticamente pela IBM. Também é possível desativar atualizações automáticas para alguns complementos e atualizá-las manualmente separadamente dos nós principal e do trabalhador. Consulte as tabelas nas seções a seguir para obter um resumo das mudanças para cada versão.
{: shortdesc}

## Log de mudanças do complemento ALB do Ingress
{: #alb_changelog}

Visualize as mudanças da versão de construção para o complemento do balanceador de carga do aplicativo (ALB) do Ingress em seus clusters do {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Quando o complemento ALB do Ingress é atualizado, os contêineres `nginx-ingress` e `ingress-auth` em todos os pods ALB são atualizados para a versão de construção mais recente. Por padrão, as atualizações automáticas para o complemento são ativadas, mas é possível desativar as atualizações automáticas e atualizar manualmente o complemento. Para obter mais informações, consulte [Atualizando o balanceador de carga do aplicativo Ingress](cs_cluster_update.html#alb).

Consulte a tabela a seguir para obter um resumo das mudanças de cada compilação do complemento ALB do Ingress.

<table summary="Visão geral de mudanças de construção para o complemento do balanceador de carga do aplicativo do aplicativo Ingress">
<caption>Log de mudanças para o complemento do balanceador de carga do aplicativo Ingress</caption>
<thead>
<tr>
<th>`nginx-ingress` / `ingress-auth` build</th>
<th>Data de liberação</th>
<th>Mudanças sem interrupções</th>
<th>Mudanças disruptivas</th>
</tr>
</thead>
<tbody>
<tr>
<td>393 / 282</td>
<td>29 de novembro de 2018</td>
<td>Melhora o desempenho para o {{site.data.keyword.appid_full}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 de novembro de 2018</td>
<td>Melhora os recursos de criação de log e logout para o {{site.data.keyword.appid_full}}.</td>
<td>Substitui o certificado autoassinado para `*.containers.mybluemix.net` com o certificado assinado LetsEncrypt que é gerado automaticamente para o cluster e é usado por ele. O certificado autoassinado `*.containers.mybluemix.net` é removido.</td>
</tr>
<tr>
<td>350 / 192</td>
<td>05 de novembro de 2018</td>
<td>Inclui suporte para ativar e desativar atualizações automáticas do complemento ALB do Ingress.</td>
<td>-</td>
</tr>
</tbody>
</table>
