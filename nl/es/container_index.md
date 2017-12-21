---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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

Empiece a trabajar sin interrupción con {{site.data.keyword.Bluemix_notm}} desplegando apps de alta disponibilidad en contenedores Docker que se ejecutan en clústeres de Kubernetes. Los contenedores son una forma estándar de empaquetar apps y todas sus dependencias para poder moverlas entre entornos sin complicaciones. A diferencia de las máquinas virtuales, los contenedores no incorporan el sistema operativo. El contenedor solo contiene código de la app, tiempo de ejecución, herramientas del sistema, bibliotecas y valores. Los contenedores son más ligeros, portátiles y eficientes que una máquina virtual.{:shortdesc}


Pulse en una opción para empezar:

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Con el {{site.data.keyword.Bluemix_notm}} Público, puede crear clústeres de Kubernetes o migrar grupos de contenedores únicos o escalables a clústeres. Con {{site.data.keyword.Bluemix_dedicated_notm}}, pulse este icono para ver las opciones." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Iniciación a clústeres de Kubernetes en {{site.data.keyword.Bluemix_notm}}" title="Iniciación a clústeres de Kubernetes en {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_classic.html#cs_classic" alt="Ejecución de contenedores únicos y escalables en {{site.data.keyword.containershort_notm}}" title="Ejecución de contenedores únicos y escalables en {{site.data.keyword.containershort_notm}}" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_ov.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} Entorno de nube de" title="{{site.data.keyword.Bluemix_notm}} Entorno de nube de" shape="rect" coords="326, -10, 448, 218" />
</map>


## Iniciación a los clústeres
{: #clusters}

Entonces ¿desea desplegar una app en el contenedor? ¡Un momento! Cree antes un clúster de Kubernetes. Kubernetes es una herramienta de organización para contenedores. Con Kubernetes, los desarrolladores pueden desplegar rápidamente apps de alta disponibilidad utilizando la potencia y la flexibilidad de los clústeres.
{:shortdesc}

Y ¿qué es un clúster? Un clúster es un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantienen la alta disponibilidad de las apps. Cuando tenga un clúster, podrá desplegar sus apps en contenedores.


Para crear un clúster lite:

1.  En el [**catálogo** ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/catalog/?category=containers), en la categoría **Contenedores**, pulse **Clústeres de Kubernetes**.

2.  Escriba un **Nombre de clúster**. El tipo de clúster predeterminado es lite. La próxima vez, puede crear un clúster estándar y definir personalizaciones adicionales como, por ejemplo, el número de nodos trabajadores que habrá en el clúster.

3.  Pulse **Crear clúster**. Se abren los detalles del clúster, pero el nodo trabajador del clúster tarda unos minutos en suministrarse. Verá el estado del nodo trabajador en el separador **Nodos trabajadores**. Cuando el estado sea `Listo`, significa que el nodo trabajador está listo para ser utilizado.

Enhorabuena. ¡Ha creado su primer clúster!

*   El clúster lite tiene un nodo trabajador con 2 CPU y 4 GB de memoria disponible para que utilicen sus apps.
*   El nodo trabajador se supervisa y se gestiona de forma centralizada mediante un Kubernetes maestro de alta disponibilidad propiedad de {{site.data.keyword.IBM_notm}} que controla y supervisa todos los recursos de Kubernetes del clúster. Puede centrarse en el nodo trabajador y en las apps que se despliegan en el nodo trabajador sin tener que preocuparse de gestionar también este nodo maestro.
*   Los recursos necesarios para ejecutar el clúster, como VLANS y direcciones IP, se gestionan en una cuenta de infraestructura de IBM Cloud (SoftLayer) propiedad de {{site.data.keyword.IBM_notm}}. Cuando cree un clúster estándar, podrá gestionar estos recursos en su propia cuenta de infraestructura de IBM Cloud (SoftLayer). Encontrará más información sobre estos recursos cuando cree un clúster estándar.
*   **Sugerencia:** Con una cuenta lite de {{site.data.keyword.Bluemix_notm}}, puede crear 1 clúster lite con 2 CPU y 4 GB de RAM e integrarlo con servicios lite. Para crear más clústeres, disponer de diferentes tipos de máquina y utilizar servicios completos, [actualice a una {{site.data.keyword.Bluemix_notm}}cuenta de Pago según uso](/docs/pricing/billable.html#upgradetopayg).


**¿Qué es lo siguiente?**

Cuando el clúster esté activo y en ejecución, empiece a utilizarlo.

* [Instalar las CLI para empezar a trabajar con el clúster.](cs_cli_install.html#cs_cli_install)
* [Desplegar una app en el clúster.](cs_apps.html#cs_apps_cli)
* [Cree un clúster estándar con varios nodos para aumentar la disponibilidad.](cs_cluster.html#cs_cluster_ui)
* [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}}
para almacenar y compartir imágenes de Docker con otros usuarios. ](/docs/services/Registry/index.html)


## Iniciación a los clústeres en {{site.data.keyword.Bluemix_dedicated_notm}} (Beta cerrada)
{: #dedicated}

Kubernetes es una herramienta de organización para planificar contenedores de apps en un clúster de máquinas de cálculo. Con Kubernetes, los desarrolladores pueden desarrollar rápidamente aplicaciones de alta disponibilidad aprovechando la potencia y la flexibilidad de los contenedores en su instancia de {{site.data.keyword.Bluemix_dedicated_notm}}.
{:shortdesc}

Antes de empezar, [configure su entorno de {{site.data.keyword.Bluemix_dedicated_notm}} para utilizar clústeres](cs_ov.html#setup_dedicated). A continuación, puede crear un clúster. Un clúster es un conjunto de nodos trabajadores organizados en una red. La finalidad del clúster es definir un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantengan la alta disponibilidad de las aplicaciones. Cuando tenga un clúster, podrá desplegar su app en dicho clúster.

**Sugerencia:** Si su organización todavía no tiene un entorno {{site.data.keyword.Bluemix_dedicated_notm}}, podría no necesitarlo. [Pruebe primero un clúster estándar dedicado en el entorno {{site.data.keyword.Bluemix_notm}} Público.](cs_cluster.html#cs_cluster_ui)

Para desplegar un clúster en {{site.data.keyword.Bluemix_dedicated_notm}}:

1.  Inicie una sesión en la consola de {{site.data.keyword.Bluemix_notm}} Público ([https://console.bluemix.net ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/catalog/?category=containers)) con su ID de IBM. Aunque debe solicitar un clúster de {{site.data.keyword.Bluemix_notm}} Público, lo va a desplegar en una cuenta de {{site.data.keyword.Bluemix_dedicated_notm}}.
2.  Si tiene varias cuentas, en el menú de cuentas seleccione una cuenta de {{site.data.keyword.Bluemix_notm}}.
3.  En el catálogo, en la categoría **Contenedores**, pulse **Clúster de Kubernetes**.
4.  Especifique los detalles del clúster.
    1.  Escriba un **Nombre de clúster**.
    2.  Seleccione la **Versión de Kubernetes** que va utilizar en los nodos trabajadores. 
    3.  Seleccione un **Tipo de máquina**. El tipo de máquina define la cantidad de memoria y CPU virtual que se configura en cada nodo trabajador y que está disponible para todos los contenedores que despliegue en los nodos.
    4.  Elija el **Número de nodos trabajadores** que necesita. Seleccione 3 para conseguir una alta disponibilidad del clúster.

Los campos del tipo de clúster, la ubicación, la VLAN pública, la VLAN privada y el hardware se definen durante el proceso de creación de la cuenta de {{site.data.keyword.Bluemix_dedicated_notm}}, de forma que no es posible ajustar estos valores.
5.  Pulse **Crear clúster**. Se abren los detalles del clúster, pero los nodos trabajadores del clúster tardar unos minutos en suministrarse. Verá el estado de los nodos trabajadores en el separador **Nodos trabajadores**. Cuando el estado sea `Listo`, significa que los nodos trabajadores están listos para ser utilizados.

    Los nodos trabajadores se supervisan y se gestionan de forma centralizada mediante un Kubernetes maestro de alta disponibilidad propiedad de {{site.data.keyword.IBM_notm}} que controla y supervisa todos los recursos de Kubernetes del clúster. Puede centrarse en los nodos trabajadores y en las apps que se despliegan en los nodos trabajadores sin tener que preocuparse de gestionar también este nodo maestro.

Enhorabuena. ¡Ha creado su primer clúster!


**¿Qué es lo siguiente?**

Cuando el clúster esté activo y en ejecución, puede realizar las siguientes tareas:

* [Instalar las CLI para empezar a trabajar con el clúster.](cs_cli_install.html#cs_cli_install)
* [Desplegar una app en el clúster.](cs_apps.html#cs_apps_cli)
* [Añadir servicios de {{site.data.keyword.Bluemix_notm}} al clúster.](cs_cluster.html#binding_dedicated)
* [Obtener más información sobre las diferencias entre clústeres en {{site.data.keyword.Bluemix_dedicated_notm}} y Público.](cs_ov.html#env_differences)

