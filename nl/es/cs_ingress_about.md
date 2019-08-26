---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:preview: .preview}



# Acerca de los ALB de Ingress
{: #ingress-about}

Ingress es un servicio de Kubernetes que equilibra cargas de trabajo de tráfico de red en el clúster reenviando solicitudes públicas o privadas a sus apps. Puede utilizar Ingress para exponer varios servicios de app a la red privada o pública mediante una única ruta privada o pública.
{: shortdesc}

## ¿Qué se suministra con Ingress?
{: #ingress_components}

Ingress consta de tres componentes: recursos de Ingress, equilibradores de carga de aplicaciones (ALB) y el equilibrador de carga multizona (MZLB).
{: shortdesc}

### Recurso de Ingress
{: #ingress-resource}

Para exponer una app mediante Ingress, debe crear un servicio Kubernetes para la app y registrar este servicio con Ingress mediante la definición de un recurso de Ingress. El recurso de Ingress es un recurso de Kubernetes que define las reglas sobre cómo direccionar solicitudes de entrada para las apps. El recurso de Ingress también especifica la vía de acceso a los servicios de app, que se añaden a la ruta pública para formar un URL de app exclusivo, como por ejemplo `mycluster.us-south.containers.appdomain.cloud/myapp1`.
{: shortdesc}

Se necesita un recurso Ingress por espacio de nombres donde tenga apps que desee exponer.
* Si las apps en el clúster están en el mismo espacio de nombres, se necesita un recurso de Ingress para definir las reglas de direccionamiento para las apps allí expuestas. Tenga en cuenta que si desea utilizar distintos dominios para las apps dentro del mismo espacio de nombres, puede utilizar un dominio comodín para especificar varios hosts de subdominio dentro de un recurso.
* Si las apps en el clúster están en distintos espacios de nombres, se debe crear un recurso por espacio de nombres para definir reglas para las apps allí expuestas. Debe utilizar un dominio comodín y especificar un subdominio diferente en cada recurso de Ingress.

Para obtener más información, consulte [Planificación de redes para uno o varios espacios de nombres](/docs/containers?topic=containers-ingress#multiple_namespaces).

Desde el 24 de mayo de 2018, el formato de subdominio de Ingress ha cambiado para nuevos clústeres. El nombre de región o de zona incluido en el nuevo formato de subdominio se genera en función de la zona en la que se ha creado el clúster. Si tiene dependencias de ejecución secuencial sobre nombres de dominio de app coherentes, puede utilizar su propio dominio personalizado en lugar del subdominio de Ingress que proporciona IBM.
{: note}

* A todos los clústeres creados después del 24 de mayo de 2018 se les asigna un subdominio en el nuevo formato, `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`.
* Los clústeres de una sola zona creados antes del 24 de mayo de 2018 continúan utilizando el subdominio asignado en el formato antiguo, `<cluster_name>.<region>.containers.mybluemix.net`.
* Si cambia un clúster de una sola zona creado antes del 24 de mayo de 2018 por uno multizona mediante la [adición de una zona al clúster](/docs/containers?topic=containers-add_workers#add_zone) por primera vez, el clúster sigue utilizando el subdominio asignado en el formato antiguo, `<cluster_name>.<region>.containers.mybluemix.net`, y también se le asigna un subdominio en el nuevo formato, `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. Se puede utilizar cualquiera de los subdominios.

### Equilibrador de carga de aplicación (ALB)
{: #alb-about}

El equilibrador de carga de aplicación (ALB) es un equilibrador de carga externo que escucha solicitudes del servicio HTTP, HTTPS o TCP de entrada. Luego el ALB reenvía las solicitudes al pod de app adecuado de acuerdo con las reglas definidas en el recurso Ingress.
{: shortdesc}

Cuando se crea un clúster estándar, {{site.data.keyword.containerlong_notm}} crea automáticamente un ALB altamente disponible para el clúster y le asigna una ruta pública exclusiva. La ruta pública se enlaza a una dirección IP pública portátil que se suministra a la cuenta de infraestructura de IBM Cloud durante la creación del clúster. También se crea automáticamente un ALB privado predeterminado, pero no se habilita automáticamente.

**Clústeres multizona**: cuando añade una zona al clúster, se añade una subred pública portátil y se crea automáticamente un nuevo ALB público y se habilita en la subred de dicha zona. Todos los ALB públicos predeterminados del clúster comparten una ruta pública, pero tienen direcciones IP diferentes. También se crea automáticamente un ALB privado predeterminado en cada zona, pero no se habilita automáticamente.

### Equilibrador de carga multizona (MZLB)
{: #mzlb}

**Clústeres multizona**: cuando se crea un clúster multizona o se [añade una zona a un clúster de una sola zona](/docs/containers?topic=containers-add_workers#add_zone), se crea y se despliega automáticamente un equilibrador de carga multizona (MZLB) de Cloudflare, de forma que exista 1 MZLB para cada región. El MZLB coloca las direcciones IP de los ALB detrás del mismo subdominio y habilita las comprobaciones de estado en estas direcciones IP para determinar si están disponibles o no.

Por ejemplo, si tiene nodos trabajadores en 3 zonas en la región EE. UU. este, el subdominio `yourcluster.us-east.containers.appdomain.cloud` tiene 3 direcciones IP de ALB. El estado de MZLB comprueba la IP de ALB pública en cada zona de una región y mantiene actualizados los resultados de la búsqueda de DNS en función de estas comprobaciones de estado. Por ejemplo, si los ALB tienen las direcciones IP `1.1.1.1`, `2.2.2.2` y `3.3.3.3`, una operación normal de búsqueda de DNS del subdominio Ingress devuelve las 3 IP; el cliente accede a 1 de ellas de forma aleatoria. Si el ALB con la dirección IP `3.3.3.3` deja de estar disponible por cualquier motivo, por ejemplo debido a una anomalía de zona, la comprobación de estado de dicha zona falla, el MZLB elimina la IP fallida del subdominio y la búsqueda de DNS devuelve sólo las IP de ALB `1.1.1.1` y `2.2.2.2` en buen estado. El subdominio tiene un tiempo de duración (TTL) de 30 segundos, de modo que, pasados 30 segundos, las nuevas apps cliente solo pueden acceder a una de las IP de ALB disponibles en buen estado.

En casos excepcionales, algunos solucionadores de DNS o apps cliente pueden continuar utilizando la IP de ALB en mal estado después del TTL de 30 segundos. Estas apps cliente pueden experimentar un tiempo de carga más largo hasta que la app cliente abandona la IP `3.3.3.3` e intenta conectarse a `1.1.1.1` o `2.2.2.2`. En función del navegador del cliente o de los valores de la app cliente, el retraso puede oscilar entre unos pocos segundos y un tiempo de espera TCP completo.

MZLB solo equilibra la carga de los ALB públicos que utilizan los subdominios Ingress proporcionados por IBM. Si solo utiliza ALB privados, debe comprobar manualmente el estado de los ALB y actualizar los resultados de la búsqueda de DNS. Si utiliza ALB públicos que utilizan un dominio personalizado, puede incluir los ALB en el equilibrio de carga de MZLB creando un CNAME en la entrada DNS para reenviar las solicitudes desde el dominio personalizado al subdominio de Ingress proporcionado por IBM para el clúster.

Si utiliza políticas de red pre-DNAT de Calico para bloquear todo el tráfico de entrada a los servicios Ingress, también debe colocar en la lista blanca las [IP IPv4 de Cloudflare ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.cloudflare.com/ips/) que se utilizan para comprobar el estado de los ALB. Para ver los pasos a seguir para crear una política pre-DNAT de Calico para colocar estas IP en la lista blanca, consulte la [Lección 3 de la guía de aprendizaje de la política de red de Calico](/docs/containers?topic=containers-policy_tutorial#lesson3).
{: note}

<br />


## ¿Cómo se asignan las IP a los ALB de Ingress?
{: #ips}

Cuando se crea un clúster estándar, {{site.data.keyword.containerlong_notm}} suministra automáticamente una subred pública portátil y una subred privada portátil. De forma predeterminada, el clúster utiliza automáticamente:
* 1 dirección IP pública portátil de la subred pública portátil correspondiente al ALB de Ingress público predeterminado.
* 1 dirección IP privada portátil de la subred privada portátil correspondiente al ALB de Ingress privado predeterminado.
{: shortdesc}

Si tiene un clúster multizona, se crea automáticamente un ALB público predeterminado y un ALB privado predeterminado en cada zona. Las direcciones IP de los ALB públicos predeterminados están todas detrás del mismo subdominio proporcionado por IBM para el clúster.

Las direcciones IP públicas y privadas portátiles son IP flotantes estáticas y no cambian cuando se elimina un nodo trabajador. Si se elimina el nodo trabajador, un daemon `Keepalived` que supervisa constantemente la IP vuelve a planificar automáticamente los pods de ALB que estaban en ese nodo trabajador en otro nodo trabajador de dicha zona. Los pods de ALB reprogramados mantienen la misma dirección IP estática. Durante la vida del clúster, la dirección IP de ALB en cada zona no cambia. Si elimina una zona de un clúster, la dirección IP del ALB para dicha zona se elimina.

Para ver las IP asignadas a los ALB, puede ejecutar el mandato siguiente.
```
ibmcloud ks albs --cluster <cluster_name_or_id>
```
{: pre}

Para obtener más información sobre lo que ocurre con las IP de ALB en el caso de que se produzca una anomalía en una zona, consulte la definición del [componente equilibrador de carga multizona](#ingress_components).



<br />


## ¿Cómo llega a mi app una solicitud con Ingress en un clúster de una sola zona?
{: #architecture-single}



En el siguiente diagrama se muestra cómo Ingress dirige la comunicación procedente de internet a una app en un clúster de una sola zona:

<img src="images/cs_ingress_singlezone.png" width="800" alt="Exposición de una app en un clúster de una sola zona mediante Ingress" style="width:800px; border-style: none"/>

1. Un usuario envía una solicitud a la app accediendo al URL de la app. Este URL es el URL público para la app expuesta al que se añade la vía de acceso al recurso de Ingress como, por ejemplo, `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Un servicio del sistema DNS resuelve el subdominio en el URL como la dirección IP pública portátil del equilibrador de carga que expone el ALB en el clúster.

3. En función de la dirección IP resulta, el cliente envía la solicitud al servicio equilibrador de carga que expone el ALB.

4. El servicio equilibrador de carga direcciona la solicitud al ALB.

5. El ALB comprueba si existe una regla de direccionamiento para la vía de acceso `myapp` en el clúster. Si se encuentra una regla coincidente, la solicitud se reenvía al pod en el que se ha desplegado la app, de acuerdo con las reglas que ha definido en el recurso de Ingress. La dirección IP de origen del paquete se cambia por la dirección IP pública del nodo trabajador donde el pod de app está en ejecución. Si se despliegan varias instancias de app en el clúster, el ALB equilibra la carga de las solicitudes entre los pods de app.

<br />


## ¿Cómo llega a mi app una solicitud con Ingress en un clúster multizona?
{: #architecture-multi}

En el siguiente diagrama se muestra cómo Ingress dirige la comunicación procedente de internet a una app en un clúster multizona:

<img src="images/cs_ingress_multizone.png" width="800" alt="Exposición de una app en un clúster multizona mediante Ingress" style="width:800px; border-style: none"/>

1. Un usuario envía una solicitud a la app accediendo al URL de la app. Este URL es el URL público para la app expuesta al que se añade la vía de acceso al recurso de Ingress como, por ejemplo, `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Un servicio del sistema DNS, que actúa como el equilibrador de carga global, resuelve el subdominio en el URL como una dirección IP que MZLB ha detectado que está en buen estado. MZLB comprueba continuamente las direcciones IP públicas portátiles de los servicios del equilibrador de carga que exponen ALB públicos en cada zona del clúster. Las direcciones IP se resuelven en un ciclo en rueda, lo que garantiza que las solicitudes se equilibran equitativamente entre los ALB en buen estado de varias zonas.

3. El cliente envía la solicitud a la dirección IP del servicio equilibrador de carga que expone un ALB.

4. El servicio equilibrador de carga direcciona la solicitud al ALB.

5. El ALB comprueba si existe una regla de direccionamiento para la vía de acceso `myapp` en el clúster. Si se encuentra una regla coincidente, la solicitud se reenvía al pod en el que se ha desplegado la app, de acuerdo con las reglas que ha definido en el recurso de Ingress. La dirección IP de origen del paquete se cambia a la dirección IP pública del nodo trabajador donde el pod de app está en ejecución. Si se despliegan varias instancias de app en el clúster, el ALB equilibra la carga de las solicitudes entre los pods de app de todas las zonas.
