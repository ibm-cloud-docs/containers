---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Iniciación a {{site.data.keyword.containerlong_notm}}
{: #container_index}

Empiece a trabajar sin interrupción con {{site.data.keyword.Bluemix_notm}} desplegando apps de alta disponibilidad en contenedores Docker que se ejecutan en clústeres de Kubernetes. Los contenedores son una forma estándar de empaquetar apps y todas sus dependencias para poder moverlas entre entornos sin complicaciones. A diferencia de las máquinas virtuales, los contenedores no incorporan el sistema operativo. El contenedor solo contiene código de la app, tiempo de ejecución, herramientas del sistema, bibliotecas y valores. Los contenedores son más ligeros, portátiles y eficientes que una máquina virtual.
{:shortdesc}


Pulse en una opción para empezar:

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Pulse un icono para empezar rápidamente con {{site.data.keyword.containershort_notm}}. Con {{site.data.keyword.Bluemix_dedicated_notm}}, pulse este icono para ver las opciones." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Iniciación a clústeres de Kubernetes en {{site.data.keyword.Bluemix_notm}}" title="Iniciación a clústeres de Kubernetes en {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="Instale las CLI." title="Instale las CLI." shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} Entorno de nube de" title="{{site.data.keyword.Bluemix_notm}} Entorno de nube de" shape="rect" coords="326, -10, 448, 218" />
</map>


## Iniciación a los clústeres
{: #clusters}

Entonces ¿desea desplegar una app en el contenedor? ¡Un momento! Cree antes un clúster de Kubernetes. Kubernetes es una herramienta de organización para contenedores. Con Kubernetes, los desarrolladores pueden desplegar rápidamente apps de alta disponibilidad utilizando la potencia y la flexibilidad de los clústeres.
{:shortdesc}

Y ¿qué es un clúster? Un clúster es un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantienen la alta disponibilidad de las apps. Cuando tenga un clúster, podrá desplegar sus apps en contenedores.

[Antes de empezar, debe tener una cuenta de {{site.data.keyword.Bluemix_notm}} de suscripción o de Pago según uso para crear un clúster gratuito.](https://console.bluemix.net/registration/)


Para crear un clúster gratuito:

1.  En el [**catálogo** ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/catalog/?category=containers), en la categoría **Contenedores**, pulse **Clústeres de Kubernetes**.

2.  Escriba un **Nombre de clúster**. El tipo de clúster predeterminado es gratuito. La próxima vez, puede crear un clúster estándar y definir personalizaciones adicionales como, por ejemplo, el número de nodos trabajadores que habrá en el clúster.

3.  Pulse **Crear clúster**. Se abren los detalles del clúster, pero el nodo trabajador del clúster tarda unos minutos en suministrarse. Verá el estado del nodo trabajador en el separador **Nodos trabajadores**. Cuando el estado sea `Listo`, significa que el nodo trabajador está listo para ser utilizado.

Enhorabuena. ¡Ha creado su primer clúster!

*   El clúster gratuito tiene un nodo trabajador con 2 CPU y 4 GB de memoria disponible para que utilicen sus apps.
*   El nodo trabajador se supervisa y se gestiona de forma centralizada mediante un maestro de Kubernetes de alta disponibilidad propiedad de {{site.data.keyword.IBM_notm}} que controla y supervisa todos los recursos de Kubernetes del clúster. Puede centrarse en el nodo trabajador y en las apps que se despliegan en el nodo trabajador sin tener que preocuparse de gestionar también este maestro.
*   Los recursos necesarios para ejecutar el clúster, como VLANS y direcciones IP, se gestionan en una cuenta de infraestructura de IBM Cloud (SoftLayer) propiedad de {{site.data.keyword.IBM_notm}}. Cuando cree un clúster estándar, podrá gestionar estos recursos en su propia cuenta de infraestructura de IBM Cloud (SoftLayer). Encontrará más información sobre estos recursos cuando cree un clúster estándar.


**¿Qué es lo siguiente?**

Cuando el clúster esté activo y en ejecución, empiece a utilizarlo.

* [Instalar las CLI para empezar a trabajar con el clúster.](cs_cli_install.html#cs_cli_install)
* [Desplegar una app en el clúster.](cs_app.html#app_cli)
* [Cree un clúster estándar con varios nodos para aumentar la disponibilidad.](cs_clusters.html#clusters_ui)
* [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}}
para almacenar y compartir imágenes de Docker con otros usuarios. ](/docs/services/Registry/index.html)
