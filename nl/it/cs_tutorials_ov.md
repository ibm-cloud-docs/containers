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

# Panoramica dell'esercitazione
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


## Crea un cluster e distribuisci la tua prima applicazione
{: #tutorials-create-cluster-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cs_cluster_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Cluster nativo Kubernetes su Ubuntu
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Crea un cluster Kubernetes su {{site.data.keyword.containerlong_notm}} gestito con i nodi di lavoro dell'infrastruttura classica che eseguono un sistema operativo Ubuntu. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/tutorial_ov.png" alt="Diagramma dell'architettura per la soluzione di creazione di un cluster Kubernetes" />
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
                  </br><p>Crea un cluster {{site.data.keyword.containerlong_notm}} con i nodi di lavoro che vengono installati con il software della piattaforma di orchestrazione dei contenitori OpenShift. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_org_ov_both_ses_rhos.png" alt="RHOS - architettura" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Distribuisci applicazioni in un cluster 
{: #tutorials-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-scalable-webapp-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Applicazione web scalabile su Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Struttura un'applicazione web, distribuiscila a un cluster e impara come ridimensionare la tua applicazione e monitorarne l'integrità.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution2/Architecture.png" alt="Diagramma dell'architettura per la distribuzione di applicazioni web con {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/logistics-wizard-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Esegui le applicazioni Kubernetes e Cloud Foundry
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Crea una distribuzione Logistics Wizard dove i servizi ERP e Controller sono distribuiti in Kubernetes e l'interfaccia utente web resta distribuita come un'applicazione Cloud Foundry. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/logistics-wizard-kubernetes/master/lw_kube_architecture.png" alt="Panoramica dell'architettura di Logistics Wizard" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-pub-sub-object-storage#pub-sub-object-storage">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Elaborazione dei dati asincroni per le applicazioni
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Utilizza un servizio di messaggistica basato su Apache Kafka per orchestrare i carichi di lavoro a lunga esecuzione su applicazioni che vengono eseguite in un cluster Kubernetes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution25/Architecture.png" alt="Architettura dell'elaborazione di dati asincroni" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Configura alta disponibilità e sicurezza
{: #tutorials-ov-ha-network-security}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-multi-region-k8s-cis#multi-region-k8s-cis">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Cluster multiregione resilienti e sicuri con Cloud Internet Services
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Integra Cloud Internet Services con i cluster Kubernetes per fornire una soluzione resiliente e sicura in più regioni {{site.data.keyword.cloud_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution32-multi-region-k8s-cis/Architecture.png" alt="Diagramma dell'architettura per utilizzare Cloud Internet Services con {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-strategies-for-resilient-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Strategie per applicazioni resilienti nel cloud
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Impara cosa prendere in considerazione quando crei applicazioni resilienti nel cloud e quali servizi {{site.data.keyword.cloud_notm}} puoi utilizzare.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution39/Architecture.png" alt="Diagramma dell'architettura per la creazione di applicazioni resilienti" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-policy_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Blocca il traffico di rete indesiderato con le politiche Calico
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Impara come utilizzare le politiche Calico per inserire in whitelist o in blacklist il traffico di rete da e verso specifici indirizzi IP. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_tutorial_policies_L4.png" alt="Blocca il traffico di rete in entrata con le politiche di rete Calico" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-istio">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Proteggi, gestisci e monitora una rete di microservizi con Istio
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Esplora la funzionalità di instradamento e monitoraggio intelligente di Istio per controllare e proteggere i tuoi microservizi nel cloud. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/istio_ov.png" alt="Panoramica dei componenti e delle dipendenze Istio" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-cloud-e2e-security#cloud-e2e-security">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Applica la sicurezza end-to-end a un'applicazione {{site.data.keyword.cloud_notm}}
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Impara come utilizzare autenticazione e crittografia per proteggere la tua applicazione e come monitorare e controllare le attività del cluster. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://github.com/IBM-Bluemix-Docs/tutorials/blob/master/images/solution34-cloud-e2e-security/Architecture.png?raw=true" alt="Diagramma dell'architettura per l'applicazione della sicurezza end-to-end a un'applicazione cloud" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-users-teams-applications#users-teams-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Organizzazione di utenti e team con {{site.data.keyword.cloud_notm}} Identity and Access Management
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Configura l'accesso cluster per gli utenti e i team e impara come replicare questa configurazione tra gli ambienti. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution20-users-teams-applications/architecture.png" alt="Diagramma dell'architettura per l'organizzazione di utenti e team" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>



## Automatizza le distribuzioni di applicazioni e cluster
{: #tutorials-ov-app-cluster-deployments}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Distribuisci le applicazioni senza server con servizi Knative
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Crea applicazioni senza server e inserite in contenitori moderne e basate sul sorgente sul tuo cluster Kubernetes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/knative_ov.png" alt="Panoramica dei componenti e delle dipendenze Knative" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Distribuzione continua ai cluster Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Configura una pipeline DevOps per le applicazioni inserite nei contenitori eseguite in Kubernetes e aggiungi le integrazioni come ad esempio lo scanner di sicurezza, le notifiche Slack e l'analisi.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution21/Architecture.png" alt="Diagramma dell'architettura per l'impostazione di una pipeline di fornitura continua e integrazione continua" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/razee-io/Razee">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Automatizza le distribuzioni multicluster con Razee
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Automatizza, gestisci e visualizza la distribuzione di risorse Kubernetes tra cluster, ambienti e provider cloud con Razee.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/razee_ov_no_txt.png" alt="Architettura dell'automazione della distribuzione Razee" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Monitora e registra l'attività del cluster
{: #tutorials-ov-monitor-log}

<div class = "solutionBoxContainer">
    <a href = "/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-kube#kube">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Gestione dei log del cluster Kubernetes con {{site.data.keyword.la_full_notm}}
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Configura un agent di registrazione nel tuo cluster e monitora diverse origini di log con {{site.data.keyword.la_full_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Log-Analysis-with-LogDNA/master/images/kube.png" alt="Panoramica dell'architettura LogDNA" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/services/Monitoring-with-Sysdig?topic=Sysdig-kubernetes_cluster#kubernetes_cluster">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Analizza le metriche del cluster con {{site.data.keyword.mon_full_notm}}
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Configura un agent di metriche Sysdig nel tuo cluster ed esplora come puoi monitorare l'integrità del tuo cluster.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Monitoring-with-Sysdig/master/images/kube.png" alt="Panoramica dell'architettura Sysdig" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Migra le applicazioni al cloud 
{: #tutorials-ov-migrate-apps}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cf_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Inserisci nel contenitore un'applicazione Cloud Foundry
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Impara come creare un'immagine Docker da un'applicazione Python Cloud Foundry, esegui il push di questa immagine a {{site.data.keyword.registryshort_notm}} e distribuisci la tua applicazione a un cluster Kubernetes.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/python_flask.png" alt="Schermata di benvenuto hello world di Python" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/tutorials?topic=solution-tutorials-vm-to-containers-and-kubernetes#move-a-vm-based-application-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Migra un'applicazione basata sulla VM
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Prepara il tuo codice applicazione, inserisci nel contenitore la tua applicazione basata sulla VM e distribuisci questa VM a un cluster Kubernetes.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution30/modern_architecture.png" alt="Migrazione dell'applicazione basata sulla VM a Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/jpetstore-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Modernizza un'applicazione web Java
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Inserisci nel contenitore l'applicazione JPetStore ed estendila con la messaggistica di testo Twilio e Watson Visual Recognition.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/jpetstore-kubernetes/master/readme_images/architecture.png" alt="Modernizza ed estendi un'applicazione web Java" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>
