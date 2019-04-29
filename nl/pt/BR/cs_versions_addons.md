---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, nginx, ingress controller

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



# Log de mudanças de complementos do cluster

Seu cluster do {{site.data.keyword.containerlong}} vem com complementos que são atualizados automaticamente pela IBM. Também é possível desativar atualizações automáticas para alguns complementos e atualizá-las manualmente separadamente dos nós principal e do trabalhador. Consulte as tabelas nas seções a seguir para obter um resumo das mudanças para cada versão.
{: shortdesc}

## Log de mudanças do complemento ALB do Ingress
{: #alb_changelog}

Visualize as mudanças da versão de construção para o complemento do balanceador de carga do aplicativo (ALB) do Ingress em seus clusters do {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Quando o complemento ALB do Ingress é atualizado, os contêineres `nginx-ingress` e `ingress-auth` em todos os pods ALB são atualizados para a versão de construção mais recente. Por padrão, as atualizações automáticas para o complemento são ativadas, mas é possível desativar as atualizações automáticas e atualizar manualmente o complemento. Para obter mais informações, consulte [Atualizando o balanceador de carga do aplicativo Ingress](/docs/containers?topic=containers-update#alb).

Consulte a tabela a seguir para obter um resumo das mudanças de cada compilação do complemento ALB do Ingress.

<table summary="Visão geral de mudanças de construção para o complemento do balanceador de carga do aplicativo do aplicativo Ingress">
<caption>Log de mudanças para o complemento do balanceador de carga do aplicativo Ingress</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
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
<td>411 / 306</td>
<td>21 de março de 2019</td>
<td>Atualiza a versão do Go para 1.12.1.</td>
<td>-</td>
</tr>
<tr>
<td>410 / 305</td>
<td>18 de março de 2019</td>
<td><ul>
<li>Corrige vulnerabilidades para varreduras de imagem.</li>
<li>Melhora a criação de log para o  {{site.data.keyword.appid_full}}.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408 / 304</td>
<td>05 de março de 2019</td>
<td>-</td>
<td>Corrige erros na integração de autorização relacionados à funcionalidade de logout, expiração do token e retorno de chamada de autorização `OAuth`. Essas correções serão implementadas apenas se você tiver ativado a autorização do {{site.data.keyword.appid_full_notm}} usando a anotação [`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth). Para implementar essas correções, os cabeçalhos adicionais são incluídos, o que aumenta o tamanho total do cabeçalho. Dependendo do tamanho de seus próprios cabeçalhos e do tamanho total de respostas, pode ser necessário ajustar quaisquer [anotações de buffer do proxy](/docs/containers?topic=containers-ingress_annotation#proxy-buffer) que você usa.</td>
</tr>
<tr>
<td>406 / 301</td>
<td>19 de fevereiro de 2019</td>
<td><ul>
<li>Atualiza a versão do Go para 1.11.5.</li>
<li>Corrige vulnerabilidades para varreduras de imagem.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>404 / 300</td>
<td>31 de janeiro de 2019</td>
<td>Atualiza a versão do Go para 1.11.4.</td>
<td>-</td>
</tr>
<tr>
<td>403 / 295</td>
<td>23 de janeiro de 2019</td>
<td><ul>
<li>Atualiza a versão NGINX de ALBs para 1.15.2.</li>
<li>Agora, os certificados TLS fornecidos pela IBM são renovados automaticamente 37 dias antes de expirarem em vez de 7 dias.</li>
<li>Inclui a funcionalidade de logout do {{site.data.keyword.appid_full_notm}}: se o prefixo `/logout` existir em um caminho do {{site.data.keyword.appid_full_notm}}, os cookies serão removidos e o usuário será enviado de volta para a página de login.</li>
<li>Inclui um cabeçalho nas solicitações do {{site.data.keyword.appid_full_notm}} para propósitos de rastreamento interno.</li>
<li>Atualiza a diretiva de localização do {{site.data.keyword.appid_short_notm}} para que a anotação `app-id` possa ser usada em conjunto com as anotações `proxy-buffers`, `proxy-buffer-size` e `proxy-busy-buffer-size`.</li>
<li>Corrige um erro para que os logs informativos não sejam rotulados como erros.</li>
</ul></td>
<td>Desativa o TLS 1.0 e 1.1 por padrão. Se os clientes que se conectarem a seus apps suportarem TLS 1.2, nenhuma ação será necessária. Se você ainda tiver clientes anteriores que requerem suporte do TLS 1.0 ou 1.1, ative manualmente as versões do TLS necessárias seguindo [estas etapas](/docs/containers?topic=containers-ingress#ssl_protocols_ciphers). Para obter mais informações sobre como ver as versões do TLS que seus clientes usam para acessar seus apps, consulte esta [Postagem do blog do {{site.data.keyword.Bluemix_notm}}](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).</td>
</tr>
<tr>
<td>393 / 291</td>
<td>09 de janeiro de 2019</td>
<td>Inclui suporte para múltiplas instâncias do  {{site.data.keyword.appid_full_notm}} .</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>29 de novembro de 2018</td>
<td>Melhora o desempenho para o  {{site.data.keyword.appid_full_notm}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 de novembro de 2018</td>
<td>Melhora os recursos de criação de log e logout para o  {{site.data.keyword.appid_full_notm}}.</td>
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
