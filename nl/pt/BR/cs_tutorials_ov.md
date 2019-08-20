---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-19"

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
{:preview: .preview}

# Visão geral do Tutorial
{: #tutorials-ov}

<style>
<!--
    #tutorials { /* hide the page header */
        display: none !important
    }
    .allCategories {
        display: flex !important;
        flex-direction: row !important;
        flex-wrap: wrap !important;
    }
    .solutionBoxContainer {}
    .solutionBoxContainer a {
        text-decoration: none !important;
        border: none !important;
    }
    .solutionBox {
        display: inline-block !important;
        width: 600px !important;
        margin: 0 10px 20px 0 !important;
        padding: 10px !important;
        border: 1px #dfe6eb solid !important;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2) !important;
    }
    @media screen and (min-width: 960px) {
        .solutionBox {
        width: 27% !important;
        }
        .solutionBoxContent {
        height: 320px !important;
        }
    }
    @media screen and (min-width: 1298px) {
        .solutionBox {
        width: calc(33% - 2%) !important;
        }
        .solutionBoxContent {
        min-height: 320px !important;
        }
    }
    .solutionBox:hover {
        border-color: rgb(136, 151, 162) !important;
    }
    .solutionBoxContent {
        display: flex !important;
        flex-direction: column !important;
    }
    .solutionBoxDescription {
        flex-grow: 1 !important;
        display: flex !important;
        flex-direction: column !important;
    }
    .descriptionContainer {
    }
    .descriptionContainer p {
        margin: 2px !important;
        overflow: hidden !important;
        display: -webkit-box !important;
        -webkit-line-clamp: 4 !important;
        -webkit-box-orient: vertical !important;
        font-size: 12px !important;
        font-weight: 400 !important;
        line-height: 1.5 !important;
        letter-spacing: 0 !important;
        max-height: 70px !important;
    }
    .architectureDiagramContainer {
        flex-grow: 1 !important;
        min-width: 200px !important;
        padding: 0 10px !important;
        text-align: center !important;
        display: flex !important;
        flex-direction: column !important;
        justify-content: center !important;
    }
    .architectureDiagram {
        max-height: 170px !important;
        padding: 5px !important;
        margin: 0 auto !important;
    }
-->
</style>


## Crie um cluster e implemente seu primeiro aplicativo
{: #tutorials-create-cluster-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cs_cluster_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Cluster nativo do Kubernetes no Ubuntu
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Crie um cluster Kubernetes no {{site.data.keyword.containerlong_notm}} gerenciado com nós do trabalhador de infraestrutura clássica que executam um sistema operacional Ubuntu. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/tutorial_ov.png" alt="Diagrama da arquitetura para a solução Criar um cluster Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/containers?topic=containers-openshift_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Cluster do Red Hat OpenShift
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Crie um cluster do {{site.data.keyword.containerlong_notm}} com os nós do trabalhador que vêm instalados com o software da plataforma de orquestração do contêiner OpenShift. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_org_ov_both_ses_rhos.png" alt="Architecture RHOS" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Implementar aplicativos em um cluster 
{: #tutorials-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-scalable-webapp-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Aplicativo da web escalável no Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Faça scaffold de um aplicativo da web, implemente-o em um cluster e saiba como escalar seu aplicativo e monitorar seu funcionamento. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution2/Architecture.png" alt="Diagrama de arquitetura para implementar aplicativos da web com o {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/logistics-wizard-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Executar aplicativos Kubernetes e Cloud Foundry
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Crie uma implementação do assistente de Logística em que os serviços ERP e Controller são implementados em Kubernetes e a interface com o usuário da web permanece implementada como um aplicativo Cloud Foundry. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/logistics-wizard-kubernetes/master/lw_kube_architecture.png" alt="Visão geral da arquitetura do assistente de Logística" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-pub-sub-object-storage#pub-sub-object-storage">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Processamento de dados assíncronos para aplicativos
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Use um serviço de sistema de mensagens baseado em Apache Kafka para orquestrar cargas de trabalho de longa execução para aplicativos que são executados em um cluster Kubernetes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution25/Architecture.png" alt="Arquitetura de processamento de dados assíncronos" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Configurar alta disponibilidade e segurança
{: #tutorials-ov-ha-network-security}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-multi-region-k8s-cis#multi-region-k8s-cis">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Clusters de várias regiões resilientes e seguros com o Cloud Internet Services
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Integrar o Cloud Internet Services aos clusters Kubernetes para entregar uma solução resiliente e segura para múltiplas regiões do {{site.data.keyword.cloud_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution32-multi-region-k8s-cis/Architecture.png" alt="Diagrama de arquitetura para usar o Cloud Internet Service com o {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-strategies-for-resilient-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Estratégias para aplicativos resilientes na nuvem
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Saiba o que considerar ao criar aplicativos resilientes na nuvem e quais serviços do {{site.data.keyword.cloud_notm}} você pode usar. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution39/Architecture.png" alt="Diagrama de arquitetura para criar aplicativos resilientes" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-policy_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Bloquear tráfego de rede indesejado com políticas do Calico
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Saiba como usar as políticas do Calico para inserir o tráfego de rede na lista de bloqueio ou de desbloqueio para determinados endereços IP. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_tutorial_policies_L4.png" alt="Bloquear tráfego de rede recebido com políticas de rede do Calico" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-istio">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Proteger, gerenciar e monitorar uma rede de microsserviços com o Istio
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Explore o recurso inteligente de roteamento e monitoramento do Istio para controlar e proteger seus microsserviços na nuvem. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/istio_ov.png" alt="Visão geral dos componentes e dependências do Istio" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-cloud-e2e-security#cloud-e2e-security">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Aplicar segurança de ponta a ponta a um aplicativo {{site.data.keyword.cloud_notm}}
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Aprenda a usar a autenticação e a criptografia para proteger seu aplicativo e como monitorar e auditar atividades de cluster. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://github.com/IBM-Bluemix-Docs/tutorials/blob/master/images/solution34-cloud-e2e-security/Architecture.png?raw=true" alt="Diagrama de arquitetura para aplicar segurança de ponta a ponta em um aplicativo em nuvem" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-users-teams-applications#users-teams-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Organizando usuários e equipes com o {{site.data.keyword.cloud_notm}} Identity and Access Management
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Configure o acesso ao cluster para usuários e equipes e saiba como replicar essa configuração entre os ambientes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution20-users-teams-applications/architecture.png" alt="Diagrama de arquitetura para organizar usuários e equipes" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>



## Automatizar implementações de aplicativo e cluster
{: #tutorials-ov-app-cluster-deployments}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Implementar aplicativos serverless com serviços Knative
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Crie aplicativos modernos, centrados na origem, conteinerizados e serverless na parte superior do cluster Kubernetes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/knative_ov.png" alt="Visão geral dos componentes e das dependências do Knative" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Implementação contínua para clusters Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Configure um pipeline do DevOps para aplicativos conteinerizados que são executados em Kubernetes e inclua integrações, como scanner de segurança, notificações do Slack e análise de dados.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution21/Architecture.png" alt="Diagrama da arquitetura para configurar um pipeline de integração contínua e de entrega contínua" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/razee-io/Razee">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Automatizar implementações de múltiplos clusters com o Razee
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Automatize, gerencie e visualize a implementação de recursos do Kubernetes em clusters, ambientes e provedores em nuvem com Razee.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/razee_ov_no_txt.png" alt="Arquitetura de automação de implementação do Razee" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Monitorar e registrar atividade do cluster
{: #tutorials-ov-monitor-log}

<div class = "solutionBoxContainer">
    <a href = "/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-kube#kube">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Gerenciando logs de cluster Kubernetes com o {{site.data.keyword.la_full_notm}}
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Configure um agente de criação de log em seu cluster e monitore diferentes origens de log com o {{site.data.keyword.la_full_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Log-Analysis-with-LogDNA/master/images/kube.png" alt="Visão geral da arquitetura de LogDNA" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/services/Monitoring-with-Sysdig?topic=Sysdig-kubernetes_cluster#kubernetes_cluster">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Analisar métricas de cluster com o {{site.data.keyword.mon_full_notm}}
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Configure um agente de métricas Sysdig em seu cluster e explore como é possível monitorar o funcionamento do cluster.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Monitoring-with-Sysdig/master/images/kube.png" alt="Visão geral da arquitetura do Sysdig" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Migrar aplicativos para a nuvem 
{: #tutorials-ov-migrate-apps}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cf_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Conteinerizar um aplicativo Cloud Foundry
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Aprenda como criar uma imagem do Docker por meio de um aplicativo Python Cloud Foundry, enviar por push essa imagem para o {{site.data.keyword.registryshort_notm}} e implementar o seu aplicativo em um cluster Kubernetes.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/python_flask.png" alt="Tela de boas-vindas Hello World da Python" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/tutorials?topic=solution-tutorials-vm-to-containers-and-kubernetes#move-a-vm-based-application-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Migrar um aplicativo baseado em VM
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Prepare o seu código do aplicativo, conteinerize seu aplicativo baseado em VM e implemente esse aplicativo em um cluster Kubernetes.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution30/modern_architecture.png" alt="Migração de aplicativo baseado em VM para Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/jpetstore-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Modernizar um aplicativo web Java
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Recarregue o aplicativo JPetStore e amplie-o com o sistema de mensagens de texto do Watson Visual Recognition e Twilio.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/jpetstore-kubernetes/master/readme_images/architecture.png" alt="Modernizar e ampliar um aplicativo da web Java" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>
