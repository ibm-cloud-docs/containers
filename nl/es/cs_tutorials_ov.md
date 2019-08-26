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

# Visión general de la guía de aprendizaje
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


## Cree un clúster y despliegue su primera app
{: #tutorials-create-cluster-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cs_cluster_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Clúster nativo de Kubernetes en Ubuntu
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Cree un clúster de Kubernetes en el {{site.data.keyword.containerlong_notm}} gestionado con los nodos trabajadores de infraestructura clásica que ejecutan un sistema operativo Ubuntu. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/tutorial_ov.png" alt="Diagrama de arquitectura para la solución Crear un clúster de Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/containers?topic=containers-openshift_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
          Clúster de Red Hat OpenShift
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Cree un clúster de {{site.data.keyword.containerlong_notm}} con nodos trabajadores que se instalen con el software de la plataforma de orquestación del contenedor OpenShift. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_org_ov_both_ses_rhos.png" alt="Arquitectura RHOS" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Desplegar apps en un clúster 
{: #tutorials-deploy-app}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-scalable-webapp-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Aplicación web escalable en Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Desarrollar una app web, desplegarla en un clúster y aprender a escalar la app y supervisar su estado. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution2/Architecture.png" alt="Diagrama de arquitectura para el despliegue de apps web con {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/logistics-wizard-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Ejecutar apps Cloud Foundry y Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Cree un despliegue del asistente Logistics en el que los servicios de ERP y de controlador se despliegan en Kubernetes, y la interfaz de usuario web permanece desplegada como una app de Cloud Foundry. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/logistics-wizard-kubernetes/master/lw_kube_architecture.png" alt="Descripción general de la arquitectura del asistente de Logistics" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-pub-sub-object-storage#pub-sub-object-storage">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Proceso de datos asíncrono para apps
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Utilice un servicio de mensajería basado en Apache Kafka para orquestar cargas de trabajo de larga ejecución en las apps que se ejecutan en un clúster de Kubernetes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution25/Architecture.png" alt="Arquitectura de proceso de datos asíncrono" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Configurar la alta disponibilidad y la seguridad
{: #tutorials-ov-ha-network-security}

<div class = "solutionBoxContainer">
    <a href = "/docs/tutorials?topic=solution-tutorials-multi-region-k8s-cis#multi-region-k8s-cis">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Clústeres multiregión resilientes y seguros con servicios de Internet en Cloud
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Integrar los servicios de Internet Cloud con clústeres de Kubernetes para ofrecer una solución resiliente y segura entre varias regiones de {{site.data.keyword.cloud_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution32-multi-region-k8s-cis/Architecture.png" alt="Diagrama de la arquitectura para el uso del servicio de Internet de Cloud con {{site.data.keyword.containerlong_notm}}" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-strategies-for-resilient-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Estrategias para aplicaciones resilientes en la nube
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Aprenda qué debe tener en cuenta al crear apps resilientes en la nube y qué servicios de {{site.data.keyword.cloud_notm}} puede utilizar. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution39/Architecture.png" alt="Diagrama de arquitectura para la creación de aplicaciones resilientes" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-policy_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Bloquear el tráfico de red no deseado con políticas de Calico
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Aprenda a utilizar políticas de Calico para permitir o prohibir (listas blancas y negras) tráfico de red desde y hacia determinadas direcciones IP. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/cs_tutorial_policies_L4.png" alt="Bloquear tráfico de red entrante con políticas de red de Calico" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/containers?topic=containers-istio">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Proteja, gestione y supervise una red de microservicios con Istio
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Explore las posibilidades de direccionamiento inteligente y supervisión de Istio para controlar y proteger los microservicios en la nube. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/istio_ov.png" alt="Visión general de los componentes de Istio y las dependencias" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-cloud-e2e-security#cloud-e2e-security">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Aplicar seguridad integral (extremo a extremo) a una app de {{site.data.keyword.cloud_notm}}
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Aprenda a utilizar la autenticación y el cifrado para proteger la app, y a supervisar y auditar las actividades del clúster. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://github.com/IBM-Bluemix-Docs/tutorials/blob/master/images/solution34-cloud-e2e-security/Architecture.png?raw=true" alt="Diagrama de la arquitectura para aplicar seguridad integral a una app de la nube" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-users-teams-applications#users-teams-applications">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Organización de usuarios y equipos con {{site.data.keyword.cloud_notm}} Identity and Access Management
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Configure el acceso de clúster para los usuarios y los equipos y aprenda a replicar esta configuración entre entornos. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution20-users-teams-applications/architecture.png" alt="Diagrama de la arquitectura para organizar usuarios y equipos" /></br>
                </div>
            </div>
        </div>
    </div>
    </a>
</div>



## Automatizar los despliegues de apps y clústeres
{: #tutorials-ov-app-cluster-deployments}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-serverless-apps-knative">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Desplegar apps sin servidor con los servicios de Knative
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Crear apps modernas, centradas en el código fuente y sin servidor sobre el clúster de Kubernetes. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/knative_ov.png" alt="Descripción general de componentes Knative y las dependencias" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "/docs/tutorials?topic=solution-tutorials-continuous-deployment-to-kubernetes#continuous-deployment-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Despliegue continuo en clústeres de Kubernetes
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Configure un conducto DevOps para apps contenerizadas que se ejecutan en Kubernetes y añada integraciones, como por ejemplo escáner de seguridad, notificaciones de Slack y analíticas.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution21/Architecture.png" alt="Diagrama de la arquitectura para la configuración de entrega continua y un conducto de integración continua" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/razee-io/Razee">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Automatizar despliegues multiclúster con Razee 
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br>  <p>Automatizar, gestionar y visualizar el despliegue de recursos de Kubernetes en clústeres, entornos y proveedores de nube con Razee.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/razee_ov_no_txt.png" alt="Arquitectura de automatización de despliegue de Razee" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Supervisar y registrar la actividad del clúster
{: #tutorials-ov-monitor-log}

<div class = "solutionBoxContainer">
    <a href = "/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-kube#kube">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Gestión de registros de clúster de Kubernetes con {{site.data.keyword.la_full_notm}}
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Configure un agente de registro en el clúster y supervise distintos orígenes de registro con {{site.data.keyword.la_full_notm}}. </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Log-Analysis-with-LogDNA/master/images/kube.png" alt="Descripción general de la arquitectura LogDNA" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/services/Monitoring-with-Sysdig?topic=Sysdig-kubernetes_cluster#kubernetes_cluster">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Analizar métricas de clúster con {{site.data.keyword.mon_full_notm}} 
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Configure un agente de métricas de Sysdig en el clúster y explore cómo puede supervisar el estado de su clúster.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/Monitoring-with-Sysdig/master/images/kube.png" alt="Descripción general de la arquitectura Sysdig" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>


## Migrar apps a la nube 
{: #tutorials-ov-migrate-apps}

<div class = "solutionBoxContainer">
    <a href = "/docs/containers?topic=containers-cf_tutorial">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Contenerizar una app de Cloud Foundry
          <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br> <p>Obtenga información sobre cómo crear una imagen Docker desde una app Cloud Foundry de Python, trasladar dicha imagen a {{site.data.keyword.registryshort_notm}} y desplegar la app en un clúster de Kubernetes.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "images/python_flask.png" alt="Pantalla de bienvenida Hello world de Python" />
                </div>
            </div>
        </div>
    </div>
    </a>
  <a href = "/docs/tutorials?topic=solution-tutorials-vm-to-containers-and-kubernetes#move-a-vm-based-application-to-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Migrar una app basada en VM
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Prepare el código de app, contenerice la app basada en VM y despliegue esta app en un clúster de Kubernetes.  </p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Bluemix-Docs/tutorials/master/images/solution30/modern_architecture.png" alt="migración de app basada en máquina virtual a Kubernetes" />
                </div>
            </div>
        </div>
    </div>
    </a>
    <a href = "https://github.com/IBM-Cloud/jpetstore-kubernetes">
    <div class = "solutionBox">
        <div class = "solutionBoxContent">
                Modernizar una app web de Java
            <div class="solutionBoxDescription">
                <div class="descriptionContainer">
                  </br><p>Contenerice la app de JPetStore y amplíela con la mensajería de texto de Watson Visual Recognition y Twilio.</p></br>
                </div>
                <div class="architectureDiagramContainer">
                    <img class="architectureDiagram" src = "https://raw.githubusercontent.com/IBM-Cloud/jpetstore-kubernetes/master/readme_images/architecture.png" alt="Modernice y amplíe una app web de Java" />
                </div>
            </div>
        </div>
    </div>
    </a>
</div>
