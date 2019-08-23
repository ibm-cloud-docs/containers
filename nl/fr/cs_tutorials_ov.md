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

# Présentation du tutoriel
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


## Création d'un cluster et déploiement de votre première application
{: #tutorials-create-cluster-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cs_cluster_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Cluster Kubernetes natif sur Ubuntu
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Créez un cluster Kubernetes sur {{site.data.keyword.containerlong_notm}} géré avec des noeuds worker d'infrastructure classique qui exécutent un système d'exploitation Ubuntu. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/tutorial_ov.png" alt="Diagramme d'architecture pour la création d'un cluster Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/containers?topic=containers-openshift_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Cluster Red Hat OpenShift
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Créez un cluster {{site.data.keyword.containerlong_notm}} avec des noeuds worker qui sont fournis installés avec le logiciel de plateforme d'orchestration de conteneur OpenShift.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_org_ov_both_ses_rhos.png" alt="Architecture RHOS" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Déploiement d'application sur un cluster 
{: #tutorials-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-scalable-webapp-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Application Web évolutive sur Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Structurez une application Web, déployez-la sur un cluster et apprenez à mettre à l'échelle votre application et à surveiller son intégrité. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution2/Architecture.png" alt="Diagramme d'architecture pour le déploiement d'applications Web à l'aide d'{{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/logistics-wizard-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Exécution de Kubernetes et des applications Cloud Foundry
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Créez un déploiement de l'assistant logistique dans lequel les services de contrôleur et de planification des ressources de l'entreprise sont déployés dans Kubernetes et l'interface utilisateur Web reste déployée en tant qu'application Cloud Foundry. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/logistics-wizard-kubernetes/master/lw_kube_architecture.png" alt="Présentation de l'architecture de l'assistant logistique" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-pub-sub-object-storage#pub-sub-object-storage">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Traitement de données asynchrone pour les applications
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Utilisez un service de messagerie basé sur Apache Kafka pour orchestrer des charges de travail de longue durée vers des applications qui s'exécutent dans un cluster Kubernetes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution25/Architecture.png" alt="Architecture de traitement des données asynchrone" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Configuration de la haute disponibilité et de la sécurité
{: #tutorials-ov-ha-network-security}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-multi-region-k8s-cis#multi-region-k8s-cis">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Clusters résilients et sécurisés sur plusieurs régions avec Cloud Internet Services
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Intégrez Cloud Internet Services à des clusters Kubernetes pour fournir une solution résiliente et sécurisée sur plusieurs régions {{site.data.keyword.cloud_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution32-multi-region-k8s-cis/Architecture.png" alt="Diagramme d'architecture pour l'utilisation de Cloud Internet Service avec {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-strategies-for-resilient-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Stratégies relatives aux applications résilientes dans le cloud
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Découvrez les éléments à prendre en compte lorsque vous créez des applications résilientes dans le cloud et les services {{site.data.keyword.cloud_notm}} que vous pouvez utiliser. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution39/Architecture.png" alt="Diagramme d'architecture pour la création d'applications résilientes" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-policy_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Blocage du trafic réseau indésirable à l'aide de règles Calico
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Apprenez à utiliser des règles Calico pour mettre sur liste blanche ou sur liste noire le trafic réseau depuis et vers certaines adresses IP. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_tutorial_policies_L4.png" alt="Bloquer le trafic réseau entrant à l'aide de règles réseau Calico" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-istio">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Sécurisation, gestion et surveillance d'un réseau de microservices avec Istio
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Explorez la capacité intelligente de routage et de surveillance d'Istio pour contrôler et sécuriser vos microservices dans le cloud. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/istio_ov.png" alt="Présentation des composants et dépendances Istio" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-cloud-e2e-security#cloud-e2e-security">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Application d'une sécurité de bout en bout à une application {{site.data.keyword.cloud_notm}}
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Apprenez à utiliser l'authentification et le chiffrement pour protéger votre application, et à surveiller et auditer les activités de cluster. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://github.com/IBM-Bluemix-Docs/tutorials/blob/master/images/solution34-cloud-e2e-security/Architecture.png?raw=true" alt="Diagramme d'architecture pour l'application d'une sécurité de bout en bout à une application en cloud" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-users-teams-applications#users-teams-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Organisation des utilisateurs et des équipes à l'aide d'{{site.data.keyword.cloud_notm}} Identity and Access Management
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Configurez l'accès aux clusters pour les utilisateurs et les équipes et apprenez à répliquer cette configuration dans plusieurs environnements. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution20-users-teams-applications/architecture.png" alt="Diagramme d'architecture pour l'organisation des utilisateurs et des équipes" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>



## Automatisation des déploiements d'application et de cluster
{: #tutorials-ov-app-cluster-deployments}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Déploiement d'applications sans serveur avec des services Knative
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Créez des applications modernes, conteneurisées, axées sur la source et sans serveur, en plus de votre cluster Kubernetes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/knative_ov.png" alt="Présentation des composants et dépendances Knative" />
</div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Déploiement continu sur des clusters Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Configurez un pipeline DevOps pour les applications conteneurisées qui s'exécutent dans Kubernetes et ajoutez des intégrations, telles que le scanner de sécurité, les notifications Slack et les analyses.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution21/Architecture.png" alt="Diagramme d'architecture pour la configuration d'une distribution continue et d'un pipeline d'intégration continue" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/razee-io/Razee">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Automatisation de déploiements sur plusieurs clusters à l'aide de Razee
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Automatisez, gérez et visualisez le déploiement de ressources Kubernetes sur plusieurs clusters, environnements et fournisseurs de cloud à l'aide de Razee. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/razee_ov_no_txt.png" alt="Architecture d'automatisation du déploiement Razee" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Surveillance et consignation de l'activité de cluster
{: #tutorials-ov-monitor-log}

<div class = "solutionBoxContainer">
    <a href = "/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-kube#kube">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Gestion des journaux de cluster Kubernetes avec {{site.data.keyword.la_full_notm}}
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Configurez un agent de consignation dans votre cluster et surveillez différentes sources de journal à l'aide d'{{site.data.keyword.la_full_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Log-Analysis-with-LogDNA/master/images/kube.png" alt="Présentation de l'architecture LogDNA" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/services/Monitoring-with-Sysdig?topic=Sysdig-kubernetes_cluster#kubernetes_cluster">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Analyse des métriques de cluster à l'aide d'{{site.data.keyword.mon_full_notm}}
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Configurez un agent de métriques Sysdig dans votre cluster et explorez la façon dont vous pouvez surveiller l'état de santé du cluster. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Monitoring-with-Sysdig/master/images/kube.png" alt="Présentation de l'architecture Sysdig" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Migration d'applications vers le cloud 
{: #tutorials-ov-migrate-apps}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cf_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Conteneurisation d'une application Cloud Foundry
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Apprenez à créer une image Docker à partir d'une application Python Cloud Foundry, à envoyer cette image dans {{site.data.keyword.registryshort_notm}} et à déployer votre application sur un cluster Kubernetes.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/python_flask.png" alt="Ecran de bienvenue Python hello world" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/tutorials?topic=solution-tutorials-vm-to-containers-and-kubernetes#move-a-vm-based-application-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Migration d'une application basée sur une machine virtuelle
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Préparez votre code d'application, conteneurisez votre application basée sur une machine virtuelle et déployez cette application sur un cluster Kubernetes.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution30/modern_architecture.png" alt="Migration d'une application basée sur une machine virtuelle vers Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/jpetstore-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Modernisation d'une application Web Java
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Conteneurisez l'application JPetStore et étendez-la à l'aide de Watson Visual Recognition et de la messagerie textuelle Twilio. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/jpetstore-kubernetes/master/readme_images/architecture.png" alt="Modernisation et extension d'une application Web Java" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>
