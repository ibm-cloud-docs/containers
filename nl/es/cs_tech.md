---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Tecnología {{site.data.keyword.containerlong_notm}} 

## Contenedores de Docker
{: #docker_containers}

Docker es un proyecto de código abierto que sacó al mercado dotCloud en 2013. Basado en las funciones de la tecnología existente de contenedores de Linux (LXC), Docker se convirtió en una plataforma de software que se puede utilizar para crear, probar, desplegar y adaptar apps rápidamente. Docker incluye software en unidades estandarizadas denominadas contenedores que incluyen todos los elementos que una app necesita para ejecutarse.
{:shortdesc}

Obtenga información acerca de algunos aspectos básicos de Docker:

<dl>
<dt>Imagen</dt>
<dd>Una imagen de Docker se crea a partir de Dockerfile, un archivo de texto que define cómo crear la imagen y qué artefactos incluir en ella, como la app, la configuración de la app y sus dependencias. Las imágenes siempre se crean a partir de otras imágenes, lo que agiliza su configuración. Deje que otra persona haga la mayor parte del trabajo en una imagen y entonces modifíquela para su uso.</dd>
<dt>Registro</dt>
<dd>Un registro de imagen es un lugar para almacenar, recuperar y compartir imágenes de Docker. Las imágenes que se almacenan en un registro pueden estar disponibles a nivel público (registro público) o pueden resultar accesibles para un pequeño grupo de usuarios (registro privado). {{site.data.keyword.containershort_notm}} ofrece imágenes públicas, como ibmliberty, que puede utilizar para crear su primera app contenerizada. Cuando se trate de aplicaciones de empresa, utilice un registro privado como el que se proporciona en {{site.data.keyword.Bluemix_notm}} para evitar que usuarios no autorizados utilicen sus imágenes.
</dd>
<dt>Contenedor</dt>
<dd>Cada contenedor se crea a partir de una imagen. Un contenedor es una app empaquetada con todas sus dependencias, de modo que la app se puede traspasar entre entornos y se puede ejecutar sin cambios. A diferencia de las máquinas virtuales, los contenedores no virtualizan un dispositivo, su sistema operativo y el hardware subyacente. El contenedor solo contiene código de la app, tiempo de ejecución, herramientas del sistema, bibliotecas y valores. Los contenedores se ejecutan como procesos aislados en el sistema hosts y comparten el sistema operativo del host y sus recursos de hardware. Este enfoque hace que el contenedor sea más ligero, portable y eficiente que una máquina virtual.</dd>
</dl>

### Principales ventajas de utilizar contenedores
{: #container_benefits}

<dl>
<dt>Los contenedores son ágiles</dt>
<dd>Los contenedores simplifican la administración del sistema proporcionando entornos estándares para despliegues de producción y desarrollo. El tiempo de ejecución ligero permite un escalado rápido de despliegues. Elimine la complejidad de gestionar varias plataformas de sistemas operativos y sus infraestructuras subyacentes utilizando contenedores que le ayudan a desplegar y ejecutar apps rápidamente, de forma segura y en cualquier infraestructura.</dd>
<dt>Los contenedores son pequeños</dt>
<dd>Puede incluir varios contenedores en el espacio que necesita una sola máquina virtual.</dd>
<dt>Los contenedores son portátiles</dt>
<dd><ul>
  <li>Reutilice fragmentos de imágenes para crear contenedores. </li>
  <li>Traslade código de app rápidamente de los entornos de transferencia a producción.</li>
  <li>Automatice los procesos con herramientas de entrega continua.</li> </ul></dd>
</dl>


<br />


## Aspectos básicos de Kubernetes
{: #kubernetes_basics}

Kubernetes fue desarrollado por Google como parte del proyecto Borg y entregado a la comunidad de código abierto en 2014. Kubernetes combina más de 15 años de investigación por parte de Google en la ejecución de una infraestructura contenerizada con cargas de trabajo de producción, contribuciones de código abierto y herramientas de gestión de contenedores Docker para ofrecer una plataforma de app aislada y segura para gestionar contenedores que sea portátil, ampliable y con resolución automática de problemas en caso de que se produzcan anomalías.
{:shortdesc}

Conozca algunos conceptos básicos de Kubernetes que se muestran en el diagrama siguiente.

![Configuración del despliegue](images/cs_app_tutorial_components1.png)

<dl>
<dt>Cuenta</dt>
<dd>Su cuenta se refiere a su cuenta de {{site.data.keyword.Bluemix_notm}}.</dd>

<dt>Clúster</dt>
<dd>Un clúster de Kubernetes consta de uno o varios hosts de cálculo que se denominan nodos trabajadores. Los nodos trabajadores se gestionan mediante un Kubernetes maestro que controla y supervisa de forma centralizada todos los recursos de Kubernetes del clúster. De ese modo, cuando se despliegan los recursos de una app contenerizada,
el Kubernetes maestro decide en qué nodo trabajador desplegar los recursos, teniendo en cuenta los requisitos del despliegue y la capacidad disponible del clúster. Los recursos de Kubernetes incluyen servicios, despliegues y pods.</dd>

<dt>Servicio</dt>
<dd>Un servicio es un recurso de Kubernetes que agrupa un conjunto de pods y proporciona conexión de red a estos pods sin exponer la dirección IP privada real de cada pod. Puede utilizar un servicio para poner la app a disponibilidad dentro de su clúster o en Internet público.
</dd>

<dt>Despliegue</dt>
<dd>Un despliegue es un recurso de Kubernetes en el que se especifica información acerca de otros recursos o prestaciones necesarios para ejecutar la app, como por ejemplo servicios, almacenamiento permanente o anotaciones. Puede documentar un despliegue en un archivo YAML de configuración y luego aplicarlo al clúster. El Kubernetes maestro configura los recursos y despliega los contenedores en pods en los nodos trabajadores con capacidad disponible.
</br></br>
Defina estrategias para la app que incluyan el número de pods que desea añadir durante una actualización continuada y el número de pods que pueden no estar disponibles al mismo tiempo. Cuando lleva a cabo una actualización continuada, el despliegue comprueba si la actualización funciona y detiene la implantación cuando se detectan anomalías.</dd>

<dt>Pod</dt>
<dd>Cada app contenerizada que se despliega en un clúster se despliega, ejecuta y gestiona mediante un recurso de Kubernetes que se denomina pod. Los pods representan las unidades desplegables de tamaño reducido de un clúster de Kubernetes y se utilizan para agrupar contenedores que se deben tratar como una sola unidad. En la mayoría de los casos, cada contenedor se despliega en su propio pod. Sin embargo, una app puede requerir un contenedor y otros contenedores ayudantes para desplegarse en un pod, de manera que dichos contenedores puedan resolverse mediante la misma dirección IP privada.</dd>

<dt>App</dt>
<dd>Una app puede hacer referencia a una app completa o al componente de una app. Puede desplegar componentes de una app en pods o nodos trabajadores independientes.
</br></br>
Para obtener más información sobre terminología de Kubernetes, <a href="cs_tutorials.html#cs_cluster_tutorial" target="_blank">consulte la Guía de aprendizaje</a>.</dd>

</dl>

<br />


## Arquitectura del servicio
{: #architecture}

Cada nodo trabajador está configurado con un motor Docker gestionado por {{site.data.keyword.IBM_notm}}, distintos recursos de cálculo, sistema de red y servicio de volúmenes, así como características integradas de seguridad que proporciona identificación, funciones de gestión de recursos y conformidad con la seguridad de los nodos trabajadores. El nodo trabajador se comunica con el nodo maestro mediante certificados TLS seguros y conexión openVPN.
{:shortdesc}

![{{site.data.keyword.containerlong_notm}} Arquitectura de Kubernetes](images/cs_org_ov.png)

En el diagrama se describe las tareas de mantenimiento de las que se ocupa el usuario y de las que se ocupa IBM. Para obtener más información sobre las tareas de mantenimiento, consulte [Responsabilidades de gestión de clústeres](cs_why.html#responsibilities).

<br />

