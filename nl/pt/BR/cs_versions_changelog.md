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



# Log de mudanças da versão
{: #changelog}

Visualize informações de mudanças de versão para atualizações principais, secundárias e de correção que estão disponíveis para os clusters do Kubernetes do {{site.data.keyword.containerlong}}. As mudanças incluem atualizações para o Kubernetes e componentes do Provedor do {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

Para obter mais informações sobre versões principais, secundárias e de correção e ações de preparação entre versões secundárias, consulte [Versões do Kubernetes](cs_versions.html). 
{: tip}

Para obter informações sobre mudanças desde a versão anterior, veja os logs de mudanças a seguir.
-  [Log de mudanças](#112_changelog) da Versão 1.12.
-  Versão 1.11  [ changelog ](#111_changelog).
-  Version 1.10 [changelog](#110_changelog).
-  [Archive](#changelog_archive) de logs de mudanças para versões descontinuadas ou não suportadas.

Alguns logs de mudanças são para _fix packs do nó do trabalhador_ e se aplicam somente aos nós do trabalhador. Deve-se [aplicar essas correções](cs_cli_reference.html#cs_worker_update) para assegurar a conformidade de segurança para seus nós do trabalhador. Outros logs de mudanças são para _fix packs de mestre_ e se aplicam somente ao cluster mestre. Os fix packs de mestre podem não ser aplicados automaticamente. É possível escolher [aplicá-los manualmente](cs_cli_reference.html#cs_cluster_update). Para obter mais informações sobre tipos de correção, veja [Tipos de atualização](cs_versions.html#update_types).
{: note}

</br>

## Log de mudanças da Versão 1.12
{: #112_changelog}

Revise o log de mudanças da versão 1.12. 
{: shortdesc}

### Log de mudanças para 1.12.3_1531, liberado em 5 de dezembro de 2018
{: #1123_1531}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.12.3_1531.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.12.2_1530">
<caption>Mudanças desde a versão 1.12.2_1530</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.12.2-68</td>
<td>v1.12.3-91</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.12.3.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.2</td>
<td>v1.12.3</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.3). A atualização resolve o [CVE-2018-1002105 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/issues/71411).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.12.2_1530, liberado em 4 de dezembro de 2018
{: #1122_1530}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.12.2_1530.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.12.2_1529">
<caption>Mudanças desde a versão 1.12.2_1529</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Utilização do recurso do nó do trabalhador</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluídos cgroups dedicados para o kubelet e o containerd para evitar que esses componentes sejam executados sem recursos. Para obter mais informações, consulte [Reservas de recursos do nó do trabalhador](cs_clusters_planning.html#resource_limit_node).</td>
</tr>
</tbody>
</table>



### Log de mudanças para 1.12.2_1529, liberado em 27 de novembro de 2018
{: #1122_1529}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.12.2_1529.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.12.2_1528">
<caption>Mudanças desde a versão 1.12.2_1528</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>Consulte as [notas sobre a liberação do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.3/releases/#v331). A atualização resolve o [Tigera Technical Advisory TTA-2018-001 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>Configuração de DNS do cluster</td>
<td>N/A</td>
<td>N/A</td>
<td>Foi corrigido um erro que pode resultar em pods DNS e CoreDNS do Kubernetes para execução após as operações de criação ou atualização de cluster.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.0</td>
<td>v1.1.5</td>
<td>Veja as [notas sobre a liberação de containerd![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/containerd/containerd/releases/tag/v1.1.5). Containerd atualizado para corrigir um conflito que pode [parar a finalização dos pods ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/containerd/containerd/issues/2744).</td>
</tr>
<tr>
<td>Cliente e servidor OpenVPN</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Imagem atualizada para o [CVE-2018-0732 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) e o [CVE-2018-0737 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.12.2_1528, liberado em 19 de novembro de 2018
{: #1122_1528}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.12.2_1528. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.12.2_1527">
<caption>Mudanças desde a versão 1.12.2_1527</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Atualizadas as imagens do nó do trabalhador com atualização do kernel para o [CVE-2018-7755 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>


### Log de mudanças para 1.12.2_1527, liberado em 7 de novembro de 2018
{: #1122_1527}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.12.2_1527. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1533">
<caption>Mudanças desde a versão 1.11.3_1533</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Configuração do Calico</td>
<td>N/A</td>
<td>N/A</td>
<td>Os pods do Calico `calico-*` no namespace `kube-system` agora configuram solicitações de recurso de CPU e de memória para todos os contêineres.</td>
</tr>
<tr>
<td>Provedor DNS do cluster</td>
<td>N/A</td>
<td>N/A</td>
<td>O DNS do Kubernetes (KubeDNS) permanece o provedor DNS padrão do cluster. No entanto, você agora tem a opção de [mudar o provedor DNS do cluster para CoreDNS](cs_cluster_update.html#dns).</td>
</tr>
<tr>
<td>Provedor de métricas do cluster</td>
<td>N/A</td>
<td>N/A</td>
<td>O Kubernetes Metrics Server substitui o Kubernetes Heapster (descontinuado desde o Kubernetes versão 1.8) como o provedor de métricas do cluster. Para itens de ação, consulte [a ação de preparação `metrics-server`](cs_versions.html#metrics-server).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.4</td>
<td>1.2.0</td>
<td>Veja as [notas sobre a liberação de containerd![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/containerd/containerd/releases/tag/v1.2.0).</td>
</tr>
<tr>
<td>CoreDNS</td>
<td>N/A</td>
<td>1.2.2</td>
<td>Consulte as [notas sobre a liberação do CoreDNS ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/coredns/coredns/releases/tag/v1.2.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.3</td>
<td>v1.12.2</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.2).</td>
</tr>
<tr>
<td>Configuração do Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluídas três novas políticas de segurança do pod da IBM e suas funções de cluster associadas. Para obter mais informações, consulte [Entendendo os recursos padrão para o gerenciamento de cluster da IBM](cs_psp.html#ibm_psp).</td>
</tr>
<tr>
<td>Painel do Kubernetes</td>
<td>v1.8.3</td>
<td>v1.10.0</td>
<td>Veja as [Notas sobre a liberação do Painel do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.0).<br><br>
Se você acessar o painel por meio de `kubectl proxy`, o botão **SKIP** na página de login será removido. Em vez disso, use um **Token** para efetuar login. Além disso, agora é possível aumentar a capacidade do número de pods do Painel do Kubernetes executando `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.</td>
</tr>
<tr>
<td>DNS do Kubernetes</td>
<td>14.1.2010</td>
<td>1.14.13</td>
<td>Veja as [Notas sobre a liberação do DNS do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/dns/releases/tag/1.14.13).</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>N/A</td>
<td>v0.3.1</td>
<td>Consulte as [Notas sobre a liberação do Kubernetes Metrics Server ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.3.1).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.11.3-118</td>
<td>v1.12.2-68</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.12. As mudanças adicionais incluem o seguinte:
<ul><li>Os pods do balanceador de carga (`ibm-cloud-provider-ip-*` no namespace `ibm-system`) agora configuram as solicitações de recurso de CPU e de memória.</li>
<li>A anotação `service.kubernetes.io/ibm-load-balancecer-cloud-provider-vlan` é incluída para especificar a VLAN na qual o serviço de balanceador de carga é implementado. Para ver VLANs disponíveis em seu cluster, execute `ibmcloud ks vlans --zone <zone>`.</li>
<li>Um novo [balanceador de carga 2.0](cs_loadbalancer.html#planning_ipvs) está disponível como um beta.</li></ul></td>
</tr>
<tr>
<td>Configuração do cliente OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>O cliente OpenVPN `vpn-* pod` no namespace `kube-system` agora configura solicitações de recurso de CPU e de memória.</td>
</tr>
</tbody>
</table>

## Versão 1.11 changelog
{: #111_changelog}

Revise o log de mudanças da versão 1.11.

### Log de mudanças para 1.11.5_1537, liberado em 5 de dezembro de 2018
{: #1115_1537}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.11.5_1537.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.4_1536">
<caption>Mudanças desde a versão 1.11.4_1536</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.11.4-142</td>
<td>v1.11.5-152</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.11.5.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.4</td>
<td>v1.11.5</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.5). A atualização resolve o [CVE-2018-1002105 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/issues/71411).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.11.4_1536, liberado em 4 de dezembro de 2018
{: #1114_1536}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.11.4_1536.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.4_1535">
<caption>Mudanças desde a versão 1.11.4_1535</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Utilização do recurso do nó do trabalhador</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluídos cgroups dedicados para o kubelet e o containerd para evitar que esses componentes sejam executados sem recursos. Para obter mais informações, consulte [Reservas de recursos do nó do trabalhador](cs_clusters_planning.html#resource_limit_node).</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.11.4_1535, liberado em 27 de novembro de 2018
{: #1114_1535}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.11.4_1535.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1534">
<caption>Mudanças desde a versão 1.11.3_1534</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>Consulte as [notas sobre a liberação do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.3/releases/#v331). A atualização resolve o [Tigera Technical Advisory TTA-2018-001 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.1.4</td>
<td>v1.1.5</td>
<td>Veja as [notas sobre a liberação de containerd![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/containerd/containerd/releases/tag/v1.1.5). Containerd atualizado para corrigir um conflito que pode [parar a finalização dos pods ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/containerd/containerd/issues/2744).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.11.3-127</td>
<td>v1.11.4-142</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.11.4.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.3</td>
<td>v1.11.4</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.4).</td>
</tr>
<tr>
<td>Cliente e servidor OpenVPN</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Imagem atualizada para o [CVE-2018-0732 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) e o [CVE-2018-0737 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.11.3_1534, liberado em 19 de novembro de 2018
{: #1113_1534}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.11.3_1534. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1533">
<caption>Mudanças desde a versão 1.11.3_1533</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Atualizadas as imagens do nó do trabalhador com atualização do kernel para o [CVE-2018-7755 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>


### Log de mudanças para 1.11.3_1533, liberado em 7 de novembro de 2018
{: #1113_1533}

A tabela a seguir mostra as mudanças incluídas na correção 1.11.3_1533. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1531">
<caption>Mudanças desde a versão 1.11.3_1531</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Atualização de alta disponibilidade do cluster mestre</td>
<td>N/A</td>
<td>N/A</td>
<td>Foram corrigidos os mestres altamente disponíveis (HA) para clusters que usam webhooks de admissão, como `initializerconfigurations`, `mutatingwebhookconfigurations` ou `validatingwebhookconfigurations`. É possível usar esses webhooks com gráficos Helm, como para [Cumprimento de segurança de imagem de contêiner](/docs/services/Registry/registry_security_enforce.html#security_enforce).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.11.3-100</td>
<td>v1.11.3-127</td>
<td>Incluída a anotação `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` para especificar a VLAN na qual o serviço de balanceador de carga é implementado. Para ver VLANs disponíveis em seu cluster, execute `ibmcloud ks vlans --zone <zone>`.</td>
</tr>
<tr>
<td>Kernel ativado por TPM</td>
<td>N/A</td>
<td>N/A</td>
<td>Os nós do trabalhador do bare metal com chips TPM para Computação confiável usam o kernel Ubuntu padrão até que a confiança seja ativada. Se você [ativar a confiança](cs_cli_reference.html#cs_cluster_feature_enable) em um cluster existente, será necessário [recarregar](cs_cli_reference.html#cs_worker_reload) quaisquer nós do trabalhador do bare metal existentes com chips TPM. Para verificar se um nó do trabalhador bare metal tem um chip TPM, revise o campo **Confiável** depois de executar o [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types --zone`.</td>
</tr>
</tbody>
</table>

### Log de mudanças para fix pack do mestre 1.11.3_1531, liberado em 1 de novembro de 2018
{: #1113_1531_ha-master}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do mestre 1.11.3_1531. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1527">
<caption>Mudanças desde a versão 1.11.3_1527</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster mestre</td>
<td>N/A</td>
<td>N/A</td>
<td>Atualizada a configuração do cluster mestre para aumentar a alta disponibilidade (HA). Os clusters agora têm três réplicas principais do Kubernetes configuradas com uma configuração altamente disponível (HA), com cada mestre implementado em hosts físicos separados. Além disso, se o cluster estiver em uma zona com capacidade para múltiplas zonas, os mestres serão difundidos pelas zonas.<br>Para ações que devem ser executadas, consulte [Atualizando para os clusters mestres altamente disponíveis](cs_versions.html#ha-masters). Estas ações de preparação se aplicam:<ul>
<li>Se você tiver um firewall ou políticas de rede customizadas do Calico.</li>
<li>Se você estiver usando as portas do host `2040` ou `2041` nos nós do trabalhador.</li>
<li>Se você usou o endereço IP do cluster mestre para acesso no cluster ao mestre.</li>
<li>Se você tiver automação que chame a API ou a CLI do Calico (`calicoctl`), tal como para criar políticas do Calico.</li>
<li>Se você usar políticas de rede do Kubernetes ou do Calico para controlar o acesso de egresso do pod ao mestre.</li></ul></td>
</tr>
<tr>
<td>Proxy de alta disponibilidade do cluster mestre</td>
<td>N/A</td>
<td>1.8.12-alpine</td>
<td>Incluído um pod `ibm-master-proxy-*` para balanceamento de carga do lado do cliente em todos os nós do trabalhador, para que cada cliente do nó do trabalhador possa rotear solicitações para uma réplica disponível do mestre de alta disponibilidade.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.18</td>
<td>v3.3.1</td>
<td>Consulte as [notas sobre a liberação do etcd ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/coreos/etcd/releases/v3.3.1).</td>
</tr>
<tr>
<td>Criptografando dados em etcd</td>
<td>N/A</td>
<td>N/A</td>
<td>Anteriormente, os dados etcd eram armazenados em uma instância de armazenamento de arquivo NFS do mestre que está criptografada em repouso. Agora, os dados etcd são armazenados no disco local do mestre e submetidos a backup no {{site.data.keyword.cos_full_notm}}. Os dados são criptografados durante o trânsito para o {{site.data.keyword.cos_full_notm}} e em repouso. No entanto, os dados etcd no disco local do mestre não são criptografados. Se você desejar que os dados etcd locais do mestre sejam criptografados, [ative o {{site.data.keyword.keymanagementservicelong_notm}} em seu cluster](cs_encrypt.html#keyprotect).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.11.3_1531, liberado em 26 de outubro de 2018
{: #1113_1531}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.11.3_1531. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1525">
<caption>Mudanças desde a versão 1.11.3_1525</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Manipulação de interrupção do S.O.</td>
<td>N/A</td>
<td>N/A</td>
<td>Substituiu o daemon do sistema de solicitação de interrupção (IRQ) por um manipulador de interrupção de maior desempenho.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack de mestre 1.11.3_1527, liberado em 15 de outubro de 2018
{: #1113_1527}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do mestre 1.11.3_1527. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1524">
<caption>Mudanças desde a versão 1.11.3_1524</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Configuração do Calico</td>
<td>N/A</td>
<td>N/A</td>
<td>Corrigida a análise de prontidão do contêiner `calico-node` para manipular melhor as falhas do nó.</td>
</tr>
<tr>
<td>Atualização do cluster</td>
<td>N/A</td>
<td>N/A</td>
<td>Corrigido o problema com a atualização de complementos de cluster quando o mestre é atualizado de uma versão não suportada.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.11.3_1525 do nó do trabalhador, liberado em 10 de outubro de 2018
{: #1113_1525}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.11.3_1525. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1524">
<caption>Mudanças desde a versão 1.11.3_1524</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Imagens atualizadas do nó do trabalhador com atualização do kernel para [CVE-2018-14633, CVE-2018-17182 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Tempo limite de sessão inativa</td>
<td>N/A</td>
<td>N/A</td>
<td>Configure o tempo limite de sessão inativa para 5 minutos por motivos de conformidade.</td>
</tr>
</tbody>
</table>


### Log de mudanças para 1.11.3_1524, liberado em 2 de outubro de 2018
{: #1113_1524}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.11.3_1524. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.3_1521">
<caption>Mudanças desde a versão 1.11.3_1521</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>1.1.3</td>
<td>1.1.4</td>
<td>Veja as [notas sobre a liberação de containerd![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/containerd/containerd/releases/tag/v1.1.4).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.11.3-91</td>
<td>v1.11.3-100</td>
<td>Atualizado o link de documentação nas mensagens de erro do balanceador de carga.</td>
</tr>
<tr>
<td>Classes de armazenamento de arquivo IBM</td>
<td>N/A</td>
<td>N/A</td>
<td>Removido o parâmetro `reclaimPolicy` duplicado nas classes de armazenamento de arquivo da IBM.<br><br>
Além disso, agora quando você atualiza o cluster mestre, a classe de armazenamento de arquivo padrão da IBM permanece inalterada. Se você desejar mudar a classe de armazenamento padrão, execute `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e substitua `<storageclass>` pelo nome da classe de armazenamento.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.11.3_1521, liberado em 20 de setembro de 2018
{: #1113_1521}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.11.3_1521. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.2_1516">
<caption>Mudanças desde a versão 1.11.2_1516</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.11.2-71</td>
<td>v1.11.3-91</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.11.3.</td>
</tr>
<tr>
<td>Classes de armazenamento de arquivo IBM</td>
<td>N/A</td>
<td>N/A</td>
<td>Removido `mountOptions` nas classes de armazenamento de arquivo da IBM para usar o padrão fornecido pelo nó do trabalhador.<br><br>
Além disso, agora quando você atualiza o cluster mestre, a classe de armazenamento de arquivo IBM padrão permanece `ibmc-file-bronze`. Se você desejar mudar a classe de armazenamento padrão, execute `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e substitua `<storageclass>` pelo nome da classe de armazenamento.</td>
</tr>
<tr>
<td>Provedor de serviço de gerenciamento de chaves</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluída a capacidade de usar o provedor de serviço de gerenciamento de chave (KMS) do Kubernetes no cluster, para suportar o {{site.data.keyword.keymanagementservicefull}}. Quando você [ativar o {{site.data.keyword.keymanagementserviceshort}} no cluster](cs_encrypt.html#keyprotect), todos os segredos do Kubernetes serão criptografados.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.2</td>
<td>v1.11.3</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.3).</td>
</tr>
<tr>
<td>Autoscaler de DNS do Kubernetes</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>Veja as [notas sobre a liberação do escalador automático de DNS do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>Girar log</td>
<td>N/A</td>
<td>N/A</td>
<td>Alternado para usar os cronômetros `systemd` em vez de `cronjobs` para evitar que `logrotate` falhe nos nós do trabalhador que não sejam recarregados ou atualizados em 90 dias. **Nota**: em todas as versões anteriores dessa liberação secundária, o disco primário é preenchido após a falha da tarefa cron porque os logs não são girados. A tarefa cron falha depois que o nó do trabalhador fica ativo por 90 dias sem ser atualizado ou recarregado. Se os logs preencherem o disco primário inteiro, o nó do trabalhador entrará em um estado de falha. O nó do trabalhador pode ser corrigido usando o [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` ou o [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>Expiração de senha raiz</td>
<td>N/A</td>
<td>N/A</td>
<td>As senhas raiz dos nós do trabalhador expiram depois de 90 dias por motivos de conformidade. Se o seu conjunto de ferramentas de automação precisar efetuar login no nó do trabalhador como raiz ou depender de tarefas cron executadas como raiz, será possível desativar a expiração de senha efetuando login no nó do trabalhador e executando `chage -M -1 root`. **Nota**: se você tiver requisitos de conformidade de segurança que evitem a execução como raiz ou a remoção da expiração de senha, não desative a expiração. Em vez disso, é possível [atualizar](cs_cli_reference.html#cs_worker_update) ou [recarregar](cs_cli_reference.html#cs_worker_reload) seus nós do trabalhador pelo menos a cada 90 dias.</td>
</tr>
<tr>
<td>Componentes de tempo de execução do nó do trabalhador (`kubelet`, `kube-proxy`, `containerd`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Dependências de componentes de tempo de execução removidas no disco primário. Esse aprimoramento evita que os nós do trabalhador falhem quando o disco primário é preenchido.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Limpar periodicamente unidades de montagem transientes para evitar que se tornem sem limites. Essa ação trata do [Problema 57345 do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.11.2_1516, liberado em 4 de setembro de 2018
{: #1112_1516}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.11.2_1516. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.2_1514">
<caption>Mudanças desde a versão 1.11.2_1514</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>Consulte as [notas sobre a liberação do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.2/releases/#v321).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.2</td>
<td>1.1.3</td>
<td>Consulte as [notas sobre a liberação do `containerd` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/containerd/containerd/releases/tag/v1.1.3).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.11.2-60</td>
<td>v1.11.2-71</td>
<td>A configuração do provedor em nuvem mudou para manipular melhor as atualizações para serviços do balanceador de carga com `externalTrafficPolicy` configurado como `local`.</td>
</tr>
<tr>
<td>Configuração do plug-in de armazenamento de arquivo IBM</td>
<td>N/A</td>
<td>N/A</td>
<td>Removida a versão do NFS padrão das opções de montagem nas classes de armazenamento de arquivo fornecidas pela IBM. O sistema operacional do host agora negocia a versão do NFS com o servidor NFS da infraestrutura do IBM Cloud (SoftLayer). Para configurar manualmente uma versão específica do NFS ou para mudar a versão do NFS de seu PV que foi negociada pelo sistema operacional do host, veja [Mudando a versão padrão do NFS](cs_storage_file.html#nfs_version_class).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.11.2_1514 do nó do trabalhador, liberado em 23 de agosto de 2018
{: #1112_1514}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.11.2_1514. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.11.2_1513">
<caption>Mudanças desde a versão 1.11.2_1513</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>` systemd `</td>
<td>229</td>
<td>230</td>
<td>` systemd `  atualizado para corrigir o vazamento  ` cgroup ` .</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Atualizadas as imagens do nó do trabalhador com atualização do kernel para [CVE-2018-3620,CVE-2018-3646 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.11.2_1513, liberado em 14 de agosto de 2018
{: #1112_1513}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.11.2_1513. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.5_1518">
<caption>Mudanças desde a versão 1.10.5_1518</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>N/A</td>
<td>1.1.2</td>
<td>O `containerd` substitui o Docker como o novo tempo de execução do contêiner para Kubernetes. Consulte as [notas sobre a liberação do `containerd` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/containerd/containerd/releases/tag/v1.1.2). Para ações que devem ser executadas, consulte [Atualizando para `containerd` como o tempo de execução do contêiner](cs_versions.html#containerd).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>O `containerd` substitui o Docker como o novo tempo de execução do contêiner para Kubernetes, para aprimorar o desempenho. Para ações que devem ser executadas, consulte [Atualizando para `containerd` como o tempo de execução do contêiner](cs_versions.html#containerd).</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.14</td>
<td>v3.2.18</td>
<td>Consulte as [notas sobre a liberação do etcd ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/coreos/etcd/releases/v3.2.18).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.5-118</td>
<td>v1.11.2-60</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.11. Além disso, os pods do balanceador de carga agora usam a nova classe de prioridade do pod `ibm-app-cluster-critical`.</td>
</tr>
<tr>
<td>Plug-in de armazenamento de arquivo IBM</td>
<td>334</td>
<td>338</td>
<td>Atualizada a versão do `incubator` para 1.8. O armazenamento de arquivo é provisionado para a zona específica que você seleciona. Não é possível atualizar os rótulos de uma instância de PV existente (estática), a menos que você esteja usando um cluster de múltiplas zonas e precise [incluir os rótulos de região e zona](cs_storage_basics.html#multizone).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.11.2</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2).</td>
</tr>
<tr>
<td>Configuração do Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Atualizada a configuração do OpenID Connect para o servidor da API do Kubernetes do cluster para suportar os grupos de acesso do {{site.data.keyword.Bluemix_notm}} Identity Access and Management (IAM). `Priority` foi incluído na opção `--enable-admission-plugins` para o servidor da API do Kubernetes do cluster e o cluster foi configurado para suportar de pod. Para obter informações adicionais, veja:
<ul><li>[{{site.data.keyword.Bluemix_notm}} Grupos de acesso do IAM ](cs_users.html#rbac)</li>
<li>[ Configurando a prioridade do pod ](cs_pod_priority.html#pod_priority)</li></ul></td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>V1.5.2</td>
<td>v.1.5.4</td>
<td>Limites de recurso aumentados para o contêiner `heapster-nanny`. Consulte as [notas sobre a liberação do Kubernetes Heapster ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/heapster/releases/tag/v1.5.4).</td>
</tr>
<tr>
<td>Configuração de criação de log</td>
<td>N/A</td>
<td>N/A</td>
<td>O diretório de log do contêiner é agora `/var/log/pods/` em vez do `/var/lib/docker/containers/` anterior.</td>
</tr>
</tbody>
</table>

<br />


## Version 1.10 log
{: #110_changelog}

Revise o log de mudanças da versão 1.10.

### Log de mudanças para 1.10.11_1536, liberado em 4 de dezembro de 2018
{: #11011_1536}

A tabela a seguir mostra as mudanças incluídas na correção 1.10.11_1536.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.8_1532">
<caption>Mudanças desde a versão 1.10.8_1532</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>Consulte as [notas sobre a liberação do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.3/releases/#v331). A atualização resolve o [Tigera Technical Advisory TTA-2018-001 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.8-197</td>
<td>v1.10.11-219</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.10.11.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.8</td>
<td>v1.10.11</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.11). A atualização resolve o [CVE-2018-1002105 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/issues/71411).</td>
</tr>
<tr>
<td>Cliente e servidor OpenVPN</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Imagem atualizada para o [CVE-2018-0732 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) e o [CVE-2018-0737 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
<tr>
<td>Utilização do recurso do nó do trabalhador</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluídos cgroups dedicados para o kubelet e o docker para evitar que esses componentes sejam executados sem recursos. Para obter mais informações, consulte [Reservas de recursos do nó do trabalhador](cs_clusters_planning.html#resource_limit_node).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.10.8_1532, liberado em 27 de novembro de 2018
{: #1108_1532}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.8_1532.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.8_1531">
<caption>Mudanças desde a versão 1.10.8_1531</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>17.06.2</td>
<td>18.06.1</td>
<td>Consulte as [Notas sobre a liberação do Docker ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.docker.com/engine/release-notes/#18061-ce).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.10.8_1531, liberado em 19 de novembro de 2018
{: #1108_1531}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.8_1531. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.8_1530">
<caption>Mudanças desde a versão 1.10.8_1530</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Atualizadas as imagens do nó do trabalhador com atualização do kernel para o [CVE-2018-7755 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.10.8_1530, liberado em 7 de novembro de 2018
{: #1108_1530_ha-master}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.10.8_1530. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.8_1528">
<caption>Mudanças desde a versão 1.10.8_1528</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster mestre</td>
<td>N/A</td>
<td>N/A</td>
<td>Atualizada a configuração do cluster mestre para aumentar a alta disponibilidade (HA). Os clusters agora têm três réplicas principais do Kubernetes configuradas com uma configuração altamente disponível (HA), com cada mestre implementado em hosts físicos separados. Além disso, se o cluster estiver em uma zona com capacidade para múltiplas zonas, os mestres serão difundidos pelas zonas.<br>Para ações que devem ser executadas, consulte [Atualizando para os clusters mestres altamente disponíveis](cs_versions.html#ha-masters). Estas ações de preparação se aplicam:<ul>
<li>Se você tiver um firewall ou políticas de rede customizadas do Calico.</li>
<li>Se você estiver usando as portas do host `2040` ou `2041` nos nós do trabalhador.</li>
<li>Se você usou o endereço IP do cluster mestre para acesso no cluster ao mestre.</li>
<li>Se você tiver automação que chame a API ou a CLI do Calico (`calicoctl`), tal como para criar políticas do Calico.</li>
<li>Se você usar políticas de rede do Kubernetes ou do Calico para controlar o acesso de egresso do pod ao mestre.</li></ul></td>
</tr>
<tr>
<td>Proxy de alta disponibilidade do cluster mestre</td>
<td>N/A</td>
<td>1.8.12-alpine</td>
<td>Incluído um pod `ibm-master-proxy-*` para balanceamento de carga do lado do cliente em todos os nós do trabalhador, para que cada cliente do nó do trabalhador possa rotear solicitações para uma réplica disponível do mestre de alta disponibilidade.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.18</td>
<td>v3.3.1</td>
<td>Consulte as [notas sobre a liberação do etcd ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/coreos/etcd/releases/v3.3.1).</td>
</tr>
<tr>
<td>Criptografando dados em etcd</td>
<td>N/A</td>
<td>N/A</td>
<td>Anteriormente, os dados etcd eram armazenados em uma instância de armazenamento de arquivo NFS do mestre que está criptografada em repouso. Agora, os dados etcd são armazenados no disco local do mestre e submetidos a backup no {{site.data.keyword.cos_full_notm}}. Os dados são criptografados durante o trânsito para o {{site.data.keyword.cos_full_notm}} e em repouso. No entanto, os dados etcd no disco local do mestre não são criptografados. Se você desejar que os dados etcd locais do mestre sejam criptografados, [ative o {{site.data.keyword.keymanagementservicelong_notm}} em seu cluster](cs_encrypt.html#keyprotect).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.8-172</td>
<td>v1.10.8-197</td>
<td>Incluída a anotação `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` para especificar a VLAN na qual o serviço de balanceador de carga é implementado. Para ver VLANs disponíveis em seu cluster, execute `ibmcloud ks vlans --zone <zone>`.</td>
</tr>
<tr>
<td>Kernel ativado por TPM</td>
<td>N/A</td>
<td>N/A</td>
<td>Os nós do trabalhador do bare metal com chips TPM para Computação confiável usam o kernel Ubuntu padrão até que a confiança seja ativada. Se você [ativar a confiança](cs_cli_reference.html#cs_cluster_feature_enable) em um cluster existente, será necessário [recarregar](cs_cli_reference.html#cs_worker_reload) quaisquer nós do trabalhador do bare metal existentes com chips TPM. Para verificar se um nó do trabalhador bare metal tem um chip TPM, revise o campo **Confiável** depois de executar o [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types --zone`.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.10.8_1528, liberado em 26 de outubro de 2018
{: #1108_1528}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.8_1528. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.8_1527">
<caption>Mudanças desde a versão 1.10.8_1527</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Manipulação de interrupção do S.O.</td>
<td>N/A</td>
<td>N/A</td>
<td>Substituiu o daemon do sistema de solicitação de interrupção (IRQ) por um manipulador de interrupção de maior desempenho.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack de mestre 1.10.8_1527, liberado em 15 de outubro de 2018
{: #1108_1527}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do mestre 1.10.8_1527. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.8_1524">
<caption>Mudanças desde a versão 1.10.8_1524</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Configuração do Calico</td>
<td>N/A</td>
<td>N/A</td>
<td>Corrigida a análise de prontidão do contêiner `calico-node` para manipular melhor as falhas do nó.</td>
</tr>
<tr>
<td>Atualização do cluster</td>
<td>N/A</td>
<td>N/A</td>
<td>Corrigido o problema com a atualização de complementos de cluster quando o mestre é atualizado de uma versão não suportada.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.10.8_1525 do nó do trabalhador, liberado em 10 de outubro de 2018
{: #1108_1525}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.8_1525. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.8_1524">
<caption>Mudanças desde a versão 1.10.8_1524</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Imagens atualizadas do nó do trabalhador com atualização do kernel para [CVE-2018-14633, CVE-2018-17182 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Tempo limite de sessão inativa</td>
<td>N/A</td>
<td>N/A</td>
<td>Configure o tempo limite de sessão inativa para 5 minutos por motivos de conformidade.</td>
</tr>
</tbody>
</table>


### Log de mudanças para 1.10.8_1524, liberado em 2 de outubro de 2018
{: #1108_1524}

A tabela a seguir mostra as mudanças incluídas na correção 1.10.8_1524. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.7_1520">
<caption>Mudanças desde a versão 1.10.7_1520</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Provedor de serviço de gerenciamento de chaves</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluída a capacidade de usar o provedor de serviço de gerenciamento de chave (KMS) do Kubernetes no cluster, para suportar o {{site.data.keyword.keymanagementservicefull}}. Quando você [ativar o {{site.data.keyword.keymanagementserviceshort}} no cluster](cs_encrypt.html#keyprotect), todos os segredos do Kubernetes serão criptografados.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.7</td>
<td>v1.10.8</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8).</td>
</tr>
<tr>
<td>Autoscaler de DNS do Kubernetes</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>Veja as [notas sobre a liberação do escalador automático de DNS do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.7-146</td>
<td>v1.10.8-172</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.10.8. Além disso, atualizado o link de documentação nas mensagens de erro do balanceador de carga.</td>
</tr>
<tr>
<td>Classes de armazenamento de arquivo IBM</td>
<td>N/A</td>
<td>N/A</td>
<td>Removido `mountOptions` nas classes de armazenamento de arquivo da IBM para usar o padrão fornecido pelo nó do trabalhador. Removido o parâmetro `reclaimPolicy` duplicado nas classes de armazenamento de arquivo da IBM.<br><br>
Além disso, agora quando você atualiza o cluster mestre, a classe de armazenamento de arquivo padrão da IBM permanece inalterada. Se você desejar mudar a classe de armazenamento padrão, execute `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e substitua `<storageclass>` pelo nome da classe de armazenamento.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.10.7_1521 do nó do trabalhador, liberado em 20 de setembro de 2018
{: #1107_1521}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.7_1521. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.7_1520">
<caption>Mudanças desde a versão 1.10.7_1520</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Girar log</td>
<td>N/A</td>
<td>N/A</td>
<td>Alternado para usar os cronômetros `systemd` em vez de `cronjobs` para evitar que `logrotate` falhe nos nós do trabalhador que não sejam recarregados ou atualizados em 90 dias. **Nota**: em todas as versões anteriores dessa liberação secundária, o disco primário é preenchido após a falha da tarefa cron porque os logs não são girados. A tarefa cron falha depois que o nó do trabalhador fica ativo por 90 dias sem ser atualizado ou recarregado. Se os logs preencherem o disco primário inteiro, o nó do trabalhador entrará em um estado de falha. O nó do trabalhador pode ser corrigido usando o [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` ou o [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>Componentes de tempo de execução do nó do trabalhador (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Dependências de componentes de tempo de execução removidas no disco primário. Esse aprimoramento evita que os nós do trabalhador falhem quando o disco primário é preenchido.</td>
</tr>
<tr>
<td>Expiração de senha raiz</td>
<td>N/A</td>
<td>N/A</td>
<td>As senhas raiz dos nós do trabalhador expiram depois de 90 dias por motivos de conformidade. Se o seu conjunto de ferramentas de automação precisar efetuar login no nó do trabalhador como raiz ou depender de tarefas cron executadas como raiz, será possível desativar a expiração de senha efetuando login no nó do trabalhador e executando `chage -M -1 root`. **Nota**: se você tiver requisitos de conformidade de segurança que evitem a execução como raiz ou a remoção da expiração de senha, não desative a expiração. Em vez disso, é possível [atualizar](cs_cli_reference.html#cs_worker_update) ou [recarregar](cs_cli_reference.html#cs_worker_reload) seus nós do trabalhador pelo menos a cada 90 dias.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Limpar periodicamente unidades de montagem transientes para evitar que se tornem sem limites. Essa ação trata do [Problema 57345 do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Desativada a ponte de Docker padrão para que o intervalo de IP `172.17.0.0/16` seja agora usado para rotas privadas. Se você depender da construção de contêineres do Docker em nós do trabalhador executando comandos `docker` no host diretamente ou usando um pod que monta o soquete do Docker, escolha entre as opções a seguir.<ul><li>Para assegurar a conectividade de rede externa ao construir o contêiner, execute `docker build. -- host de rede `.</li>
<li>Para criar explicitamente uma rede a ser usada ao construir o contêiner, execute `docker network create` e, em seguida, use essa rede.</li></ul>
**Nota**: tem dependências no soquete do Docker ou no Docker diretamente? [Atualize para `containerd` em vez de `docker` como o tempo de execução do contêiner](cs_versions.html#containerd) para que seus clusters estejam preparados para executar o Kubernetes versão 1.11 ou mais recente.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.10.7_1520, liberado em 4 de setembro de 2018
{: #1107_1520}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.10.7_1520. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.5_1519">
<caption>Mudanças desde a versão 1.10.5_1519</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>Veja as [notas sobre a liberação do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.2/releases/#v321).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.5-118</td>
<td>v1.10.7-146</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.10.7. Além disso, a configuração do provedor em nuvem foi mudada para manipular melhor as atualizações para serviços de balanceador de carga com `externalTrafficPolicy` configurado como `local`.</td>
</tr>
<tr>
<td>Plug-in de armazenamento de arquivo IBM</td>
<td>334</td>
<td>338</td>
<td>Atualizada a versão de incubadora para 1.8. O armazenamento de arquivo é provisionado para a zona específica que você seleciona. Não é possível atualizar os rótulos de uma instância de PV existente (estática), a menos que você esteja usando um cluster multizona e precise incluir os rótulos de região e zona.<br><br> Removida a versão do NFS padrão das opções de montagem nas classes de armazenamento de arquivo fornecidas pela IBM. O sistema operacional do host agora negocia a versão do NFS com o servidor NFS da infraestrutura do IBM Cloud (SoftLayer). Para configurar manualmente uma versão específica do NFS ou para mudar a versão do NFS de seu PV que foi negociada pelo sistema operacional do host, veja [Mudando a versão padrão do NFS](cs_storage_file.html#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.10.7</td>
<td>Veja as [notas sobre a liberação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.7).</td>
</tr>
<tr>
<td>Configuração do Kubernetes Heapster</td>
<td>N/A</td>
<td>N/A</td>
<td>Limites de recurso aumentados para o contêiner `heapster-nanny`.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.10.5_1519 do nó do trabalhador, liberado em 23 de agosto de 2018
{: #1105_1519}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.5_1519. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.5_1518">
<caption>Mudanças desde a versão 1.10.5_1518</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>` systemd `</td>
<td>229</td>
<td>230</td>
<td>` systemd `  atualizado para corrigir o vazamento  ` cgroup ` .</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Atualizadas as imagens do nó do trabalhador com atualização do kernel para [CVE-2018-3620,CVE-2018-3646 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


### Log de mudanças para o fix pack 1.10.5_1518 do nó do trabalhador, liberado em 13 de agosto de 2018
{: #1105_1518}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.5_1518. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.5_1517">
<caption>Mudanças desde a versão 1.10.5_1517</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Pacotes do Ubuntu</td>
<td>N/A</td>
<td>N/A</td>
<td>Atualizações para pacotes do Ubuntu instalados.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.10.5_1517, liberado em 27 de julho de 2018
{: #1105_1517}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.10.5_1517. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.3_1514">
<caption>Mudanças desde a versão 1.10.3_1514</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>V3.1.1</td>
<td>v3.1.3</td>
<td>Veja as [notas sobre a liberação do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.1/releases/#v313).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.10.5. Além disso, os eventos `create failure` do serviço do LoadBalancer agora incluem qualquer erro de sub-rede móvel.</td>
</tr>
<tr>
<td>Plug-in de armazenamento de arquivo IBM</td>
<td>320</td>
<td>334</td>
<td>Foi aumentado o tempo limite para criação de volume persistente de 15 a 30 minutos. Mudado o tipo de faturamento padrão para `hourly`. Incluídas opções de montagem nas classes de armazenamento predefinidas. Na instância de armazenamento de arquivo do NFS em sua conta de infraestrutura do IBM Cloud (SoftLayer), foi mudado o campo **Notas** para o formato da JSON e foi incluído o namespace do Kubernetes no qual o PV está implementado. Para suportar clusters de múltiplas zonas, inclua rótulos de zona e região em volumes persistentes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>Veja as [notas sobre a liberação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Aprimoramentos menores para configurações de rede do nó do trabalhador para cargas de trabalho de rede de alto desempenho.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>A implementação do cliente do OpenVPN `vpn` que é executada no namespace `kube-system` agora é gerenciada pelo `addon-manager` do Kubernetes.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.10.3_1514, liberado em 3 de julho de 2018
{: #1103_1514}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.3_1514. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.3_1513">
<caption>Mudanças desde a versão 1.10.3_1513</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>`sysctl` otimizado para cargas de trabalho de rede de alto desempenho.</td>
</tr>
</tbody>
</table>


### Log de mudanças para o fix pack do nó do trabalhador 1.10.3_1513, liberado em 21 de junho de 2018
{: #1103_1513}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.3_1513. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.3_1512">
<caption>Mudanças desde a versão 1.10.3_1512</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Para tipos de máquina não criptografados, o disco secundário é limpo obtendo um novo sistema de arquivos quando você recarrega ou atualiza o nó do trabalhador.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.10.3_1512, liberado em 12 de junho de 2018
{: #1103_1512}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.10.3_1512. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.1_1510">
<caption>Mudanças desde a versão 1.10.1_1510</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>Veja as [notas sobre a liberação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3).</td>
</tr>
<tr>
<td>Configuração do Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluído `PodSecurityPolicy` na opção `--enable-admission-plugins` para o servidor de API do Kubernetes do cluster e configurado o cluster para suportar políticas de segurança de pod. Para obter mais informações, consulte [Configurando políticas de segurança do pod](cs_psp.html).</td>
</tr>
<tr>
<td>Configuração do Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Ativada a opção `--authentication-token-webhook` para suportar tokens de conta do serviço e acesso da API para autenticação no terminal HTTPS `kubelet`.</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.10.3.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluído `livenessProbe` na implementação do cliente do OpenVPN `vpn` que é executada no namespace `kube-system`.</td>
</tr>
<tr>
<td>Atualização do kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Novas imagens do nó do trabalhador com atualização do kernel para [CVE-2018-3639 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>



### Log de mudanças para o fix pack 1.10.1_1510 do nó do trabalhador, liberado em 18 de maio de 2018
{: #1101_1510}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.1_1510. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.1_1509">
<caption>Mudanças desde a versão 1.10.1_1509</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Correção para tratar de um erro ocorrido se você tiver usado o plug-in de armazenamento de bloco.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.10.1_1509 do nó do trabalhador, liberado em 16 de maio de 2018
{: #1101_1509}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.10.1_1509. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.10.1_1508">
<caption>Mudanças desde a versão 1.10.1_1508</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Os dados armazenados no diretório-raiz `kubelet` agora são salvos no disco secundário maior da máquina do nó do trabalhador.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.10.1_1508, liberado em 1º de maio de 2018
{: #1101_1508}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.10.1_1508. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.7_1510">
<caption>Mudanças desde a versão 1.9.7_1510</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>V3.1.1</td>
<td>Veja as [notas sobre a liberação do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v3.1/releases/#v311).</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>V1.5.0</td>
<td>V1.5.2</td>
<td>Veja as [notas sobre a liberação do Kubernetes Heapster ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>Veja as [notas sobre a liberação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1).</td>
</tr>
<tr>
<td>Configuração do Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluído <code>StorageObjectInUseProtection</code> na opção <code>--enable-admission-plugins</code> para o servidor de API do Kubernetes do cluster.</td>
</tr>
<tr>
<td>DNS do Kubernetes</td>
<td>1.14.8</td>
<td>14.1.2010</td>
<td>Veja as [notas sobre a liberação do DNS do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/dns/releases/tag/1.14.10).</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Atualizado para suportar Kubernetes 1,10 release.</td>
</tr>
<tr>
<td>Suporte de GPU</td>
<td>N/A</td>
<td>N/A</td>
<td>O suporte para as [cargas de trabalho do contêiner de unidade de processamento de gráfico (GPU)](cs_app.html#gpu_app) está agora disponível para planejamento e execução. Para obter uma lista de tipos de máquina de GPU disponíveis, veja [Hardware para nós do trabalhador](cs_clusters_planning.html#shared_dedicated_node). Para obter mais informações, veja a documentação do Kubernetes para [Planejar GPUs ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/).</td>
</tr>
</tbody>
</table>

<br />


## Archive
{: #changelog_archive}

Versões do Kubernetes não suportadas:
*  [Versão 1.9](#19_changelog)
*  [Versão 1.8](#18_changelog)
*  [Versão 1.7](#17_changelog)

### Log de mudanças da versão 1.9 (descontinuado, não suportado em 27 de dezembro de 2018)
{: #19_changelog}

Revise o log de mudanças da versão 1.9.

### Log de mudanças para o fix pack do nó do trabalhador 1.9.11_1538, liberado em 4 de dezembro de 2018
{: #1911_1538}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.11_1538.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.11_1537">
<caption>Mudanças desde a versão 1.9.11_1537</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Utilização do recurso do nó do trabalhador</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluídos cgroups dedicados para o kubelet e o docker para evitar que esses componentes sejam executados sem recursos. Para obter mais informações, consulte [Reservas de recursos do nó do trabalhador](cs_clusters_planning.html#resource_limit_node).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.9.11_1537, liberado em 27 de novembro de 2018
{: #1911_1537}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.11_1537.
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.11_1536">
<caption>Mudanças desde a versão 1.9.11_1536</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>17.06.2</td>
<td>18.06.1</td>
<td>Consulte as [Notas sobre a liberação do Docker ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.docker.com/engine/release-notes/#18061-ce).</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.9.11_1536, liberado em 19 de novembro de 2018
{: #1911_1536}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.9.11_1536. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.10_1532">
<caption>Mudanças desde a versão 1.9.10_1532</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>v2.6.12</td>
<td>Consulte as [notas sobre a liberação do Calico ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.projectcalico.org/v2.6/releases/#v2612). A atualização resolve o [Tigera Technical Advisory TTA-2018-001 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Atualizadas as imagens do nó do trabalhador com atualização do kernel para o [CVE-2018-7755 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.10</td>
<td>v1.9.11</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.11).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.10-219</td>
<td>v1.9.11-249</td>
<td>Atualizado para suportar a liberação 1.9.11 do Kubernetes.</td>
</tr>
<tr>
<td>Cliente e servidor OpenVPN</td>
<td>2.4.4-r2</td>
<td>2.4.6-r3-IKS-8</td>
<td>Imagem atualizada para o [CVE-2018-0732 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) e o [CVE-2018-0737 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

### Log de mudanças para a correção do nó do trabalhador 1.9.10_1532, liberado em 7 de novembro de 2018
{: #1910_1532}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.11_1532. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.10_1531">
<caption>Mudanças desde a versão 1.9.10_1531</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel ativado por TPM</td>
<td>N/A</td>
<td>N/A</td>
<td>Os nós do trabalhador do bare metal com chips TPM para Computação confiável usam o kernel Ubuntu padrão até que a confiança seja ativada. Se você [ativar a confiança](cs_cli_reference.html#cs_cluster_feature_enable) em um cluster existente, será necessário [recarregar](cs_cli_reference.html#cs_worker_reload) quaisquer nós do trabalhador do bare metal existentes com chips TPM. Para verificar se um nó do trabalhador bare metal tem um chip TPM, revise o campo **Confiável** depois de executar o [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types --zone`.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.9.10_1531, liberado em 26 de outubro de 2018
{: #1910_1531}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.10_1531. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.10_1530">
<caption>Mudanças desde a versão 1.9.10_1530</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Manipulação de interrupção do S.O.</td>
<td>N/A</td>
<td>N/A</td>
<td>Substituiu o daemon do sistema de solicitação de interrupção (IRQ) por um manipulador de interrupção de maior desempenho.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack de mestre 1.9.10_1530 liberado em 15 de outubro de 2018
{: #1910_1530}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.10_1530. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.10_1527">
<caption>Mudanças desde a versão 1.9.10_1527</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Atualização do cluster</td>
<td>N/A</td>
<td>N/A</td>
<td>Corrigido o problema com a atualização de complementos de cluster quando o mestre é atualizado de uma versão não suportada.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.9.10_1528 do nó do trabalhador, liberado em 10 de outubro de 2018
{: #1910_1528}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.10_1528. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.10_1527">
<caption>Mudanças desde a versão 1.9.10_1527</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Imagens atualizadas do nó do trabalhador com atualização do kernel para [CVE-2018-14633, CVE-2018-17182 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Tempo limite de sessão inativa</td>
<td>N/A</td>
<td>N/A</td>
<td>Configure o tempo limite de sessão inativa para 5 minutos por motivos de conformidade.</td>
</tr>
</tbody>
</table>


### Log de mudanças para 1.9.10_1527, liberado em 2 de outubro de 2018
{: #1910_1527}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.9.10_1527. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.10_1523">
<caption>Mudanças desde a versão 1.9.10_1523</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.10-192</td>
<td>v1.9.10-219</td>
<td>Atualizado o link de documentação nas mensagens de erro do balanceador de carga.</td>
</tr>
<tr>
<td>Classes de armazenamento de arquivo IBM</td>
<td>N/A</td>
<td>N/A</td>
<td>Removido `mountOptions` nas classes de armazenamento de arquivo da IBM para usar o padrão fornecido pelo nó do trabalhador. Removido o parâmetro `reclaimPolicy` duplicado nas classes de armazenamento de arquivo da IBM.<br><br>
Além disso, agora quando você atualiza o cluster mestre, a classe de armazenamento de arquivo padrão da IBM permanece inalterada. Se você desejar mudar a classe de armazenamento padrão, execute `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e substitua `<storageclass>` pelo nome da classe de armazenamento.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.9.10_1524 do nó do trabalhador, liberado em 20 de setembro de 2018
{: #1910_1524}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.10_1524. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.10_1523">
<caption>Mudanças desde a versão 1.9.10_1523</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Girar log</td>
<td>N/A</td>
<td>N/A</td>
<td>Alternado para usar os cronômetros `systemd` em vez de `cronjobs` para evitar que `logrotate` falhe nos nós do trabalhador que não sejam recarregados ou atualizados em 90 dias. **Nota**: em todas as versões anteriores dessa liberação secundária, o disco primário é preenchido após a falha da tarefa cron porque os logs não são girados. A tarefa cron falha depois que o nó do trabalhador fica ativo por 90 dias sem ser atualizado ou recarregado. Se os logs preencherem o disco primário inteiro, o nó do trabalhador entrará em um estado de falha. O nó do trabalhador pode ser corrigido usando o [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` ou o [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>Componentes de tempo de execução do nó do trabalhador (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Dependências de componentes de tempo de execução removidas no disco primário. Esse aprimoramento evita que os nós do trabalhador falhem quando o disco primário é preenchido.</td>
</tr>
<tr>
<td>Expiração de senha raiz</td>
<td>N/A</td>
<td>N/A</td>
<td>As senhas raiz dos nós do trabalhador expiram depois de 90 dias por motivos de conformidade. Se o seu conjunto de ferramentas de automação precisar efetuar login no nó do trabalhador como raiz ou depender de tarefas cron executadas como raiz, será possível desativar a expiração de senha efetuando login no nó do trabalhador e executando `chage -M -1 root`. **Nota**: se você tiver requisitos de conformidade de segurança que evitem a execução como raiz ou a remoção da expiração de senha, não desative a expiração. Em vez disso, é possível [atualizar](cs_cli_reference.html#cs_worker_update) ou [recarregar](cs_cli_reference.html#cs_worker_reload) seus nós do trabalhador pelo menos a cada 90 dias.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Limpar periodicamente unidades de montagem transientes para evitar que se tornem sem limites. Essa ação trata do [Problema 57345 do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Desativada a ponte de Docker padrão para que o intervalo de IP `172.17.0.0/16` seja agora usado para rotas privadas. Se você depender da construção de contêineres do Docker em nós do trabalhador executando comandos `docker` no host diretamente ou usando um pod que monta o soquete do Docker, escolha entre as opções a seguir.<ul><li>Para assegurar a conectividade de rede externa ao construir o contêiner, execute `docker build. -- host de rede `.</li>
<li>Para criar explicitamente uma rede a ser usada ao construir o contêiner, execute `docker network create` e, em seguida, use essa rede.</li></ul>
**Nota**: tem dependências no soquete do Docker ou no Docker diretamente? [Atualize para `containerd` em vez de `docker` como o tempo de execução do contêiner](cs_versions.html#containerd) para que seus clusters estejam preparados para executar o Kubernetes versão 1.11 ou mais recente.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.9.10_1523, liberado em 4 de setembro de 2018
{: #1910_1523}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.9.10_1523. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.9_1522">
<caption>Mudanças desde a versão 1.9.9_1522</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.9-167</td>
<td>v1.9.10-192</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.9.10. Além disso, a configuração do provedor em nuvem foi mudada para manipular melhor as atualizações para serviços de balanceador de carga com `externalTrafficPolicy` configurado como `local`.</td>
</tr>
<tr>
<td>Plug-in de armazenamento de arquivo IBM</td>
<td>334</td>
<td>338</td>
<td>Atualizada a versão de incubadora para 1.8. O armazenamento de arquivo é provisionado para a zona específica que você seleciona. Não é possível atualizar os rótulos de uma instância de PV existente (estática), a menos que você esteja usando um cluster multizona e precise incluir os rótulos de região e zona.<br><br>Removida a versão do NFS padrão das opções de montagem nas classes de armazenamento de arquivo fornecidas pela IBM. O sistema operacional do host agora negocia a versão do NFS com o servidor NFS da infraestrutura do IBM Cloud (SoftLayer). Para configurar manualmente uma versão específica do NFS ou para mudar a versão do NFS de seu PV que foi negociada pelo sistema operacional do host, veja [Mudando a versão padrão do NFS](cs_storage_file.html#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.9</td>
<td>v1.9.10</td>
<td>Veja as [notas sobre a liberação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.10).</td>
</tr>
<tr>
<td>Configuração do Kubernetes Heapster</td>
<td>N/A</td>
<td>N/A</td>
<td>Limites de recurso aumentados para o contêiner `heapster-nanny`.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.9.9_1522 do nó do trabalhador, liberado em 23 de agosto de 2018
{: #199_1522}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.9_1522. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.9_1521">
<caption>Mudanças desde a versão 1.9.9_1521</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>` systemd `</td>
<td>229</td>
<td>230</td>
<td>` systemd `  atualizado para corrigir o vazamento  ` cgroup ` .</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Atualizadas as imagens do nó do trabalhador com atualização do kernel para [CVE-2018-3620,CVE-2018-3646 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


### Log de mudanças para o fix pack 1.9.9_1521 do nó do trabalhador, liberado em 13 de agosto de 2018
{: #199_1521}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.9_1521. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.9_1520">
<caption>Mudanças desde a versão 1.9.9_1520</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Pacotes do Ubuntu</td>
<td>N/A</td>
<td>N/A</td>
<td>Atualizações para pacotes do Ubuntu instalados.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.9.9_1520, liberado em 27 de julho de 2018
{: #199_1520}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.9.9_1520. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.8_1517">
<caption>Mudanças desde a versão 1.9.8_1517</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.9.9. Além disso, os eventos `create failure` do serviço do LoadBalancer agora incluem qualquer erro de sub-rede móvel.</td>
</tr>
<tr>
<td>Plug-in de armazenamento de arquivo IBM</td>
<td>320</td>
<td>334</td>
<td>Foi aumentado o tempo limite para criação de volume persistente de 15 a 30 minutos. Mudado o tipo de faturamento padrão para `hourly`. Incluídas opções de montagem nas classes de armazenamento predefinidas. Na instância de armazenamento de arquivo do NFS em sua conta de infraestrutura do IBM Cloud (SoftLayer), foi mudado o campo **Notas** para o formato da JSON e foi incluído o namespace do Kubernetes no qual o PV está implementado. Para suportar clusters de múltiplas zonas, inclua rótulos de zona e região em volumes persistentes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>Veja as [notas sobre a liberação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Aprimoramentos menores para configurações de rede do nó do trabalhador para cargas de trabalho de rede de alto desempenho.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>A implementação do cliente do OpenVPN `vpn` que é executada no namespace `kube-system` agora é gerenciada pelo `addon-manager` do Kubernetes.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.9.8_1517, liberado em 3 de julho de 2018
{: #198_1517}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.8_1517. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.8_1516">
<caption>Mudanças desde a versão 1.9.8_1516</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>`sysctl` otimizado para cargas de trabalho de rede de alto desempenho.</td>
</tr>
</tbody>
</table>


### Log de mudanças para o fix pack do nó do trabalhador 1.9.8_1516, liberado em 21 de junho de 2018
{: #198_1516}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.8_1516. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.8_1515">
<caption>Mudanças desde a versão 1.9.8_1515</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Para tipos de máquina não criptografados, o disco secundário é limpo obtendo um novo sistema de arquivos quando você recarrega ou atualiza o nó do trabalhador.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.9.8_1515, liberado em 19 de junho de 2018
{: #198_1515}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.9.8_1515. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.7_1513">
<caption>Mudanças desde a versão 1.9.7_1513</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8).</td>
</tr>
<tr>
<td>Configuração do Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluída PodSecurityPolicy na opção --admission-control para o servidor da API do Kubernetes do cluster e configurado o cluster para suportar políticas de segurança do pod. Para obter mais informações, consulte [Configurando políticas de segurança do pod](cs_psp.html).</td>
</tr>
<tr>
<td>Provedor do IBM Cloud</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.9.8.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluído <code>livenessProbe</code> na implementação do cliente do OpenVPN <code>vpn</code> que é executada no namespace <code>kube-system</code>.</td>
</tr>
</tbody>
</table>


### Log de mudanças para o fix pack do trabalhador do trabalhador 1.9.7_1513, liberado em 11 de junho de 2018
{: #197_1513}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.7_1513. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.7_1512">
<caption>Mudanças desde a versão 1.9.7_1512</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Atualização do kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Novas imagens do nó do trabalhador com atualização do kernel para [CVE-2018-3639 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.9.7_1512 do nó do trabalhador, liberado em 18 de maio de 2018
{: #197_1512}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.7_1512. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.7_1511">
<caption>Mudanças desde a versão 1.9.7_1511</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Correção para tratar de um erro ocorrido se você tiver usado o plug-in de armazenamento de bloco.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.9.7_1511 nó do trabalhador, liberado em 16 de maio de 2018
{: #197_1511}

A tabela a seguir mostra as mudanças que estão incluídas no fix pack do nó do trabalhador 1.9.7_1511. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.7_1510">
<caption>Mudanças desde a versão 1.9.7_1510</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Os dados armazenados no diretório-raiz `kubelet` agora são salvos no disco secundário maior da máquina do nó do trabalhador.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.9.7_1510, liberado em 30 de abril de 2018
{: #197_1510}

A tabela a seguir mostra as mudanças que estão incluídas na correção 1.9.7_1510. 
{: shortdesc}

<table summary="Mudanças que foram feitas desde a versão 1.9.3_1506">
<caption>Mudanças desde a versão 1.9.3_1506</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.9.3</td>
<td>v1.9.7	</td>
<td><p>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7). Essa liberação trata das vulnerabilidades [CVE-2017-1002101 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: agora, `secret`, `configMap`, `downwardAPI` e volumes projetados são montados como somente leitura. Anteriormente, os apps podiam gravar dados nesses volumes, mas o sistema podia reverter automaticamente os dados. Se os seus apps dependerem do comportamento inseguro prévio, modifique-os de modo correspondente.</p></td>
</tr>
<tr>
<td>Configuração do Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluído `admissionregistration.k8s.io/v1alpha1=true` na opção `--runtime-config` para o servidor de API do Kubernetes do cluster.</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
<td>Os serviços `NodePort` e `LoadBalancer` agora suportam [preservar o IP de origem do cliente](cs_loadbalancer.html#node_affinity_tolerations) configurando `service.spec.externalTrafficPolicy` como `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corrija a configuração de tolerância do [nó de borda](cs_edge.html#edge) para clusters mais velhos.</td>
</tr>
</tbody>
</table>

<br />


### Changelog Versão 1.8 (Não suportado)
{: #18_changelog}

Revise as mudanças a seguir.

### Log de mudanças para o fix pack 1.8.15_1521 do nó do trabalhador, liberado em 20 de setembro de 2018
{: #1815_1521}

<table summary="Mudanças que foram feitas desde a versão 1.8.15_1520">
<caption>Mudanças desde a versão 1.8.15_1520</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Girar log</td>
<td>N/A</td>
<td>N/A</td>
<td>Alternado para usar os cronômetros `systemd` em vez de `cronjobs` para evitar que `logrotate` falhe nos nós do trabalhador que não sejam recarregados ou atualizados em 90 dias. **Nota**: em todas as versões anteriores dessa liberação secundária, o disco primário é preenchido após a falha da tarefa cron porque os logs não são girados. A tarefa cron falha depois que o nó do trabalhador fica ativo por 90 dias sem ser atualizado ou recarregado. Se os logs preencherem o disco primário inteiro, o nó do trabalhador entrará em um estado de falha. O nó do trabalhador pode ser corrigido usando o [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` ou o [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>Componentes de tempo de execução do nó do trabalhador (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Dependências de componentes de tempo de execução removidas no disco primário. Esse aprimoramento evita que os nós do trabalhador falhem quando o disco primário é preenchido.</td>
</tr>
<tr>
<td>Expiração de senha raiz</td>
<td>N/A</td>
<td>N/A</td>
<td>As senhas raiz dos nós do trabalhador expiram depois de 90 dias por motivos de conformidade. Se o seu conjunto de ferramentas de automação precisar efetuar login no nó do trabalhador como raiz ou depender de tarefas cron executadas como raiz, será possível desativar a expiração de senha efetuando login no nó do trabalhador e executando `chage -M -1 root`. **Nota**: se você tiver requisitos de conformidade de segurança que evitem a execução como raiz ou a remoção da expiração de senha, não desative a expiração. Em vez disso, é possível [atualizar](cs_cli_reference.html#cs_worker_update) ou [recarregar](cs_cli_reference.html#cs_worker_reload) seus nós do trabalhador pelo menos a cada 90 dias.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Limpar periodicamente unidades de montagem transientes para evitar que se tornem sem limites. Essa ação trata do [Problema 57345 do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.8.15_1520 do nó do trabalhador, liberado em 23 de agosto de 2018
{: #1815_1520}

<table summary="Mudanças que foram feitas desde a versão 1.8.15_1519">
<caption>Mudanças desde a versão 1.8.15_1519</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>` systemd `</td>
<td>229</td>
<td>230</td>
<td>` systemd `  atualizado para corrigir o vazamento  ` cgroup ` .</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Atualizadas as imagens do nó do trabalhador com atualização do kernel para [CVE-2018-3620,CVE-2018-3646 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack 1.8.15_1519 do nó do trabalhador, liberado em 13 de agosto de 2018
{: #1815_1519}

<table summary="Mudanças que foram feitas desde a versão 1.8.15_1518">
<caption>Mudanças desde a versão 1.8.15_1518</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Pacotes do Ubuntu</td>
<td>N/A</td>
<td>N/A</td>
<td>Atualizações para pacotes do Ubuntu instalados.</td>
</tr>
</tbody>
</table>

### Log de mudanças para 1.8.15_1518, liberado em 27 de julho de 2018
{: #1815_1518}

<table summary="Mudanças que foram feitas desde a versão 1.8.13_1516">
<caption>Mudanças desde a versão 1.8.13_1516</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.8.15. Além disso, os eventos `create failure` do serviço do LoadBalancer agora incluem qualquer erro de sub-rede móvel.</td>
</tr>
<tr>
<td>Plug-in de armazenamento de arquivo IBM</td>
<td>320</td>
<td>334</td>
<td>Foi aumentado o tempo limite para criação de volume persistente de 15 a 30 minutos. Mudado o tipo de faturamento padrão para `hourly`. Incluídas opções de montagem nas classes de armazenamento predefinidas. Na instância de armazenamento de arquivo do NFS em sua conta de infraestrutura do IBM Cloud (SoftLayer), foi mudado o campo **Notas** para o formato da JSON e foi incluído o namespace do Kubernetes no qual o PV está implementado. Para suportar clusters de múltiplas zonas, inclua rótulos de zona e região em volumes persistentes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>Veja as [notas sobre a liberação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Aprimoramentos menores para configurações de rede do nó do trabalhador para cargas de trabalho de rede de alto desempenho.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>A implementação do cliente do OpenVPN `vpn` que é executada no namespace `kube-system` agora é gerenciada pelo `addon-manager` do Kubernetes.</td>
</tr>
</tbody>
</table>

### Log de mudanças para o fix pack do nó do trabalhador 1.8.13_1516, liberado em 3 de julho de 2018
{: #1813_1516}

<table summary="Mudanças que foram feitas desde a versão 1.8.13_1515">
<caption>Mudanças desde a versão 1.8.13_1515</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>`sysctl` otimizado para cargas de trabalho de rede de alto desempenho.</td>
</tr>
</tbody>
</table>


### Log de mudanças para o fix pack do nó do trabalhador 1.8.13_1515, liberado em 21 de junho de 2018
{: #1813_1515}

<table summary="Mudanças que foram feitas desde a versão 1.8.13_1514">
<caption>Mudanças desde a versão 1.8.13_1514</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Para tipos de máquina não criptografados, o disco secundário é limpo obtendo um novo sistema de arquivos quando você recarrega ou atualiza o nó do trabalhador.</td>
</tr>
</tbody>
</table>

### Log de mudanças 1.8.13_1514, liberado em 19 de junho de 2018
{: #1813_1514}

<table summary="Mudanças que foram feitas desde a versão 1.8.11_1512">
<caption>Mudanças desde a versão 1.8.11_1512</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13).</td>
</tr>
<tr>
<td>Configuração do Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluída PodSecurityPolicy na opção --admission-control para o servidor da API do Kubernetes do cluster e configurado o cluster para suportar políticas de segurança do pod. Para obter mais informações, consulte [Configurando políticas de segurança do pod](cs_psp.html).</td>
</tr>
<tr>
<td>Provedor do IBM Cloud</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Atualizado para suportar a liberação do Kubernetes 1.8.13.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Incluído <code>livenessProbe</code> na implementação do cliente do OpenVPN <code>vpn</code> que é executada no namespace <code>kube-system</code>.</td>
</tr>
</tbody>
</table>


### Log de mudanças para o fix pack do nó do trabalhador 1.8.11_1512, liberado em 11 de junho de 2018
{: #1811_1512}

<table summary="Mudanças que foram feitas desde a versão 1.8.11_1511">
<caption>Mudanças desde a versão 1.8.11_1511</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Atualização do kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Novas imagens do nó do trabalhador com atualização do kernel para [CVE-2018-3639 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>


### Log de mudanças para o fix pack 1.8.11_1511 do nó do trabalhador, liberado em 18 de maio de 2018
{: #1811_1511}

<table summary="Mudanças que foram feitas desde a versão 1.8.11_1510">
<caption>Mudanças desde a versão 1.8.11_1510</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Correção para tratar de um erro ocorrido se você tiver usado o plug-in de armazenamento de bloco.</td>
</tr>
</tbody>
</table>

### Mudanças de log para o fix pack 1.8.11_1510 do nó do trabalhador, liberado em 16 de maio de 2018
{: #1811_1510}

<table summary="Mudanças que foram feitas desde a versão 1.8.11_1509">
<caption>Mudanças desde a versão 1.8.11_1509</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Os dados armazenados no diretório-raiz `kubelet` agora são salvos no disco secundário maior da máquina do nó do trabalhador.</td>
</tr>
</tbody>
</table>


### Log de mudanças para 1.8.11_1509, liberado em 19 de abril de 2018
{: #1811_1509}

<table summary="Mudanças que foram feitas desde a versão 1.8.8_1507">
<caption>Mudanças desde a versão 1.8.8_1507</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td><p>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). Essa liberação trata das vulnerabilidades [CVE-2017-1002101 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p>Agora, `secret`, `configMap`, `downwardAPI` e volumes projetados são montados como somente leitura. Anteriormente, os apps podiam gravar dados nesses volumes, mas o sistema podia reverter automaticamente os dados. Se os seus apps dependerem do comportamento inseguro prévio, modifique-os de modo correspondente.</p></td>
</tr>
<tr>
<td>Pause a imagem do contêiner</td>
<td>3.0</td>
<td>3.1</td>
<td>Remove processos zumbi órfãos herdados.</td>
</tr>
<tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>Os serviços `NodePort` e `LoadBalancer` agora suportam [preservar o IP de origem do cliente](cs_loadbalancer.html#node_affinity_tolerations) configurando `service.spec.externalTrafficPolicy` como `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corrija a configuração de tolerância do [nó de borda](cs_edge.html#edge) para clusters mais velhos.</td>
</tr>
</tbody>
</table>

<br />


### Version 1.7 changelog (Unsupported)
{: #17_changelog}

Revise as mudanças a seguir.

#### Log de mudanças para o fix pack do nó do trabalhador 1.7.16_1514, liberado em 11 de junho de 2018
{: #1716_1514}

<table summary="Mudanças que foram feitas desde a versão 1.7.16_1513">
<caption>Mudanças desde a versão 1.7.16_1513</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Atualização do kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Novas imagens do nó do trabalhador com atualização do kernel para [CVE-2018-3639 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

#### Log de mudanças para o fix pack 1.7.16_1513 do nó do trabalhador, liberado em 18 de maio de 2018
{: #1716_1513}

<table summary="Mudanças que foram feitas desde a versão 1.7.16_1512">
<caption>Mudanças desde a versão 1.7.16_1512</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Correção para tratar de um erro ocorrido se você tiver usado o plug-in de armazenamento de bloco.</td>
</tr>
</tbody>
</table>

#### Log de mudanças para o fix pack 1.7.16_1512 do nó do trabalhador, liberado em 16 de maio de 2018
{: #1716_1512}

<table summary="Mudanças que foram feitas desde a versão 1.7.16_1511">
<caption>Mudanças desde a versão 1.7.16_1511</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Os dados armazenados no diretório-raiz `kubelet` agora são salvos no disco secundário maior da máquina do nó do trabalhador.</td>
</tr>
</tbody>
</table>

#### Log de mudanças para 1.7.16_1511, liberado em 19 de abril de 2018
{: #1716_1511}

<table summary="Mudanças que foram feitas desde a versão 1.7.4_1509">
<caption>Mudanças desde a versão 1.7.4_1509</caption>
<thead>
<tr>
<th>Componente</th>
<th>Prévio</th>
<th>Atual</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td><p>Veja as [Notas sobre a liberação do Kubernetes![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). Essa liberação trata das vulnerabilidades [CVE-2017-1002101 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p>Agora, `secret`, `configMap`, `downwardAPI` e volumes projetados são montados como somente leitura. Anteriormente, os apps podiam gravar dados nesses volumes, mas o sistema podia reverter automaticamente os dados. Se os seus apps dependerem do comportamento inseguro prévio, modifique-os de modo correspondente.</p></td>
</tr>
<td>Provedor do {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>Os serviços `NodePort` e `LoadBalancer` agora suportam [preservar o IP de origem do cliente](cs_loadbalancer.html#node_affinity_tolerations) configurando `service.spec.externalTrafficPolicy` como `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corrija a configuração de tolerância do [nó de borda](cs_edge.html#edge) para clusters mais velhos.</td>
</tr>
</tbody>
</table>
