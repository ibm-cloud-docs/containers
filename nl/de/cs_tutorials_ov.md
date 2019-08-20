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

# Überblick zum Lernprogramm
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


## Cluster erstellen und erste App bereitstellen
{: #tutorials-create-cluster-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cs_cluster_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Nativer Kubernetes-Cluster unter Ubuntu
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Erstellen Sie einen Kubernetes-Cluster in einer verwalteten Instanz von {{site.data.keyword.containerlong_notm}} mit Workerknoten der klassischen Infrastruktur, auf denen ein Ubuntu-Betriebssystem ausgeführt wird. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/tutorial_ov.png" alt="Architekturdiagramm für Lösung 'Kubernetes-Cluster erstellen'" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/containers?topic=containers-openshift_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Red Hat OpenShift-Cluster
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Erstellen Sie einen {{site.data.keyword.containerlong_notm}}-Cluster mit Workerknoten, die in der Software der OpenShift-Containerorchestrierungsplattform bereits vorinstalliert sind. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_org_ov_both_ses_rhos.png" alt="Architektur - RHOS" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Apps in Cluster bereitstellen 
{: #tutorials-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-scalable-webapp-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Skalierbare Webanwendung in Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Erstellen Sie ein Web-App-Gerüst, stellen Sie es in einem Cluster bereit und erfahren Sie, wie Ihre App skaliert und deren Zustand überwacht werden kann. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution2/Architecture.png" alt="Architekturdiagramm für die Bereitstellung von Web-Apps mit {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/logistics-wizard-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Kubernetes- und Cloud Foundry-Apps ausführen
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Erstellen Sie eine Bereitstellung des Logistics Wizards, in der die ERP- und Controller-Services in Kubernetes bereitgestellt werden und die Webbenutzerschnittstelle weiterhin als Cloud Foundry-App bereitgestellt bleibt. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/logistics-wizard-kubernetes/master/lw_kube_architecture.png" alt="Logistics Wizard - Architekturübersicht" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-pub-sub-object-storage#pub-sub-object-storage">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Asynchrone Datenverarbeitung für Apps
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Verwenden Sie den Apache Kafka-basierten Messaging-Service, um Workloads mit langer Laufzeit auf Apps zu orchestrieren, die in einem Kubernetes-Cluster ausgeführt werden. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution25/Architecture.png" alt="Architektur für asynchrone Datenverarbeitung" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Hochverfügbarkeit und Sicherheit einrichten
{: #tutorials-ov-ha-network-security}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-multi-region-k8s-cis#multi-region-k8s-cis">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Widerstandsfähige und sichere Cluster in mehreren Regionen mit Cloud Internet Services
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Integrieren Sie Cloud Internet Services mit Kubernetes-Clustern, um eine widerstandsfähige und sichere Lösung über mehrere {{site.data.keyword.cloud_notm}}-Regionen hinweg bereitzustellen. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution32-multi-region-k8s-cis/Architecture.png" alt="Architekturdiagramm zur Verwendung von Cloud Internet Service mit {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-strategies-for-resilient-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Strategien für widerstandsfähige Anwendungen in der Cloud
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Erfahren Sie, welche Faktoren bei der Erstellung widerstandsfähiger Apps in der Cloud zu beachten sind und welche {{site.data.keyword.cloud_notm}}-Services Sie verwenden können. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution39/Architecture.png" alt="Architekturdiagramm zur Erstellung widerstandsfähiger Anwendungen" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-policy_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Unerwünschten Netzdatenverkehr mit Calico-Richtlinien blockieren
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Hier erfahren Sie, wie Calico-Richtlinien verwendet werden können, um Netzdatenverkehr, der bestimmte IP-Adressen als Quelle oder Ziel hat, auf eine Whitelist oder Blacklist zu setzen. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_tutorial_policies_L4.png" alt="Blockierung des eingehenden Netzdatenverkehrs mit Calico-Netzrichtlinien" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-istio">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Netz aus Mikroservices mit Istio sichern, verwalten und überwachen
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Lernen Sie die Funktion für das intelligente Routing und die intelligente Überwachung von Istio kennen, um Ihre Mikroservices in der Cloud zu steuern und zu sichern. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/istio_ov.png" alt="Überblick zu Istio-Komponenten und -Abhängigkeiten" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-cloud-e2e-security#cloud-e2e-security">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Durchgängige Sicherheit für {{site.data.keyword.cloud_notm}}-App anwenden
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Hier erfahren Sie, wie die Authentifizierung und Verschlüsselung zum Schutz Ihrer App verwendet wird, und wie Clusteraktivitäten überwacht und protokolliert werden können. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://github.com/IBM-Bluemix-Docs/tutorials/blob/master/images/solution34-cloud-e2e-security/Architecture.png?raw=true" alt="Architekturdiagramm zur Anwendung einer durchgängigen Sicherheit für eine Cloud-App" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-users-teams-applications#users-teams-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Benutzer und Teams mit {{site.data.keyword.cloud_notm}} Identity and Access Management organisieren
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Konfigurieren Sie den Clusterzugriff für Benutzer und Teams und lernen Sie, wie diese Konfiguration umgebungsübergreifend repliziert werden kann. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution20-users-teams-applications/architecture.png" alt="Architekturdiagramm zur Organisation von Benutzern und Teams" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>



## App- und Clusterbereitstellungen automatisieren
{: #tutorials-ov-app-cluster-deployments}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Serverunabhängige Apps mit Knative-Services bereitstellen
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Erstellen Sie moderne, quellenzentrierte, containerisierte und serverunabhängige Apps in Ihrem Kubernetes-Cluster. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/knative_ov.png" alt="Überblick zu Knative-Komponenten und -Abhängigkeiten" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Fortlaufende Bereitstellung in Kubernetes-Clustern
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Richten Sie eine DevOps-Pipeline für containerisierte Apps ein, die in Kubernetes ausgeführt werden, und fügen Sie Integrationen wie beispielsweise den Sicherheitsscanner, Slackbenachrichtigungen und Analysen hinzu. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution21/Architecture.png" alt="Architekturdiagramm zur Einrichtung der Continuous Delivery und der kontinuierlichen Integrationspipeline" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/razee-io/Razee">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Bereitstellungen mit mehreren Clustern mit Razee automatisieren
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Automatisieren, verwalten und visualisieren Sie die Bereitstellung von Kubernetes-Ressourcen über mehrere Cluster, Umgebungen und Cloud-Provider hinweg mit Razee.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/razee_ov_no_txt.png" alt="Automatisierungsarchitektur für Razee-Bereitstellung" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Clusteraktivität überwachen und protokollieren
{: #tutorials-ov-monitor-log}

<div class = "solutionBoxContainer">
    <a href = "/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-kube#kube">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Protokolle für Kubernetes-Cluster mit {{site.data.keyword.la_full_notm}} verwalten
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Konfigurieren Sie einen Protokollierungsagenten in Ihrem Cluster und überwachen Sie unterschiedliche Protokollquellen mit {{site.data.keyword.la_full_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Log-Analysis-with-LogDNA/master/images/kube.png" alt="Architekturübersicht zu LogDNA" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/services/Monitoring-with-Sysdig?topic=Sysdig-kubernetes_cluster#kubernetes_cluster">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Clustermetriken mit {{site.data.keyword.mon_full_notm}} analysieren
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Richten Sie einen Agenten für Sysdig-Metriken in Ihrem Cluster ein und machen Sie sich mit der Überwachung des Clusterstatus vertraut.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Monitoring-with-Sysdig/master/images/kube.png" alt="Architekturübersicht zu Sysdig" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Apps in die Cloud migrieren 
{: #tutorials-ov-migrate-apps}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cf_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Cloud Foundry-App containerisieren
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Hier erfahren Sie, wie Sie ein Docker-Image anhand einer Python-Cloud Foundry-App erstellen, dieses Image mit einer Push-Operation an {{site.data.keyword.registryshort_notm}} übertragen und Ihre App auf einem Kubernetes-Cluster bereitstellen können. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/python_flask.png" alt="Hello World-Eingangsanzeige (Python)" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/tutorials?topic=solution-tutorials-vm-to-containers-and-kubernetes#move-a-vm-based-application-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                VM-basierte App migrieren
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Bereiten Sie den App-Code vor, containerisieren Sie die VM-basierte App und stellen Sie diese App in einem Kubernetes-Cluster bereit. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution30/modern_architecture.png" alt="Migration einer VM-basierten App in Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/jpetstore-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Java-Web-App modernisieren
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Containerisieren Sie die JPetStore-App und erweitern Sie sie mit Watson Visual Recognition und dem Twilio-Text-Messaging.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/jpetstore-kubernetes/master/readme_images/architecture.png" alt="Modernisierung und Erweiterung einer Java-Web-App" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>
