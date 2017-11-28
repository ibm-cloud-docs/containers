---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-18"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Regiones y ubicaciones
{{site.data.keyword.Bluemix}} está ubicado en todo el mundo. Una región es un área geográfica a la que accede un punto final. Las ubicaciones son centros de datos de una región. Los servicios de {{site.data.keyword.Bluemix_notm}} pueden estar disponibles a nivel global o dentro de una región específica.{:shortdesc}

Las [regiones de {{site.data.keyword.Bluemix_notm}}](#bluemix_regions) difieren de las [regiones de {{site.data.keyword.containershort_notm}}](#container_regions).

Regiones de {{site.data.keyword.containershort_notm}} soportadas: 
  * AP Sur
  * UE Central
  * UK Sur
  * EE.UU. Este
  * EE.UU. Sur

## Puntos finales de API de regiones de {{site.data.keyword.Bluemix_notm}}
{: #bluemix_regions}

Puede organizar los recursos entre servicios de {{site.data.keyword.Bluemix_notm}} mediante regiones de {{site.data.keyword.Bluemix_notm}}. Por ejemplo, puede crear un clúster de Kubernetes utilizando una imagen de Docker privada almacenada en {{site.data.keyword.registryshort_notm}} de la misma región.{:shortdesc}

Para comprobar la región de {{site.data.keyword.Bluemix_notm}} en la que está actualmente, ejecute `bx info` y revise el campo **Región**. 

Se puede acceder a las regiones de {{site.data.keyword.Bluemix_notm}} especificando el punto final de API cuando se inicia la sesión. Si no especifica ninguna región, la sesión se iniciará automáticamente en la región más cercana.

Puntos finales de API de regiones de {{site.data.keyword.Bluemix_notm}} con mandatos de inicio de sesión de ejemplo:

  * EE.UU. Sur y EE.UU. Este
      ```
      bx login -a api.ng.bluemix.net
      ```
      {: pre}

  * Sidney
      ```
      bx login -a api.au-syd.bluemix.net
      ```
      {: pre}

  * Alemania
      ```
      bx login -a api.eu-de.bluemix.net
      ```
      {: pre}

  * Reino Unido
      ```
      bx login -a api.eu-gb.bluemix.net
      ```
      {: pre}



<br />


## Puntos finales de API de regiones y ubicaciones de {{site.data.keyword.containershort_notm}}
{: #container_regions}

Mediante regiones de {{site.data.keyword.containershort_notm}}, puede crear o acceder a clústeres de Kubernetes de una región distinta de la región de {{site.data.keyword.Bluemix_notm}} en la que ha iniciado la sesión. Los puntos finales de regiones de {{site.data.keyword.containershort_notm}} hacen referencia específicamente a {{site.data.keyword.containershort_notm}}, no a {{site.data.keyword.Bluemix_notm}} en general. {:shortdesc}

Puntos finales de API de regiones de {{site.data.keyword.containershort_notm}}:
  * AP Sur: `https://ap-south.containers.bluemix.net`
  * UE Central: `https://eu-central.containers.bluemix.net`
  * UK Sur: `https://uk-south.containers.bluemix.net`
  * EE.UU. Este: `https://us-east.containers.bluemix.net`
  * EE.UU. Sur: `https://us-south.containers.bluemix.net`

**Nota:** EE.UU. este solo se puede utilizar con mandatos de CLI. 

Para comprobar la región de {{site.data.keyword.containershort_notm}} en la que está actualmente, ejecute `bx cs api` y revise el campo **Región**. 

### Inicio de sesión en una región de servicio de contenedor diferente
{: #container_login_endpoints}

Supongamos que desea iniciar una sesión en otra región de {{site.data.keyword.containershort_notm}} por las siguientes razones:
  * Ha creado servicios de {{site.data.keyword.Bluemix_notm}} o imágenes de Docker privadas en una región y desea utilizarlos con {{site.data.keyword.containershort_notm}} en otra región.
  * Desea acceder a un clúster de una región distinta de la región de {{site.data.keyword.Bluemix_notm}} predeterminada en la que ha iniciado la sesión.

</br>

Ejemplo de mandatos para iniciar una sesión en una región de {{site.data.keyword.containershort_notm}}:
  * AP Sur:
    ```
    bx cs init --host https://ap-south.containers.bluemix.net
    ```
    {: pre}

  * UE Central:
    ```
    bx cs init --host https://eu-central.containers.bluemix.net
    ```
    {: pre}

  * UK Sur: 
    ```
    bx cs init --host https://uk-south.containers.bluemix.net
    ```
    {: pre}

  * EE.UU. Este:
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * EE. UU. Sur:
    ```
    bx cs init --host https://us-south.containers.bluemix.net
    ```
    {: pre}

### Creación de clústeres lite en regiones del servicio de contenedor
{: #lite_regions}

Puede crear clústeres lite de Kubernetes en las siguientes regiones:
  * AP Sur
  * UE Central
  * UK Sur
  * EE.UU. Sur

### Ubicaciones disponibles para el servicio de contenedor
{: #locations}

Las ubicaciones son centros de datos que están disponibles dentro de una región.

  | Región | Ubicación | Ciudad|
  |--------|----------|------|
  | AP Sur| mel01, syd01, syd04        | Melbourne, Sidney |
  | UE Central| ams03, fra02        | Amsterdam, Frankfurt |
  | UK Sur| lon02, lon04         | Londres |
  | EE.UU. este| wdc06, wdc07        | Washington, DC |
  | EE.UU. Sur     | dal10, dal12, dal13       | Dallas |

### Utilización de mandatos de la API del servicio de contenedor
{: #container_api}

Para interactuar con la API de {{site.data.keyword.containershort_notm}}, especifique el tipo de mandato y añada `/v1/command` al punto final.

Ejemplo de API `GET /clusters` en EE.UU. Sur: 
  ```
  GET https://us-south.containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

Para ver la documentación sobre los mandatos de API, añada `swagger-api` al final de la región que desea ver.
  * AP Sur: https://ap-south.containers.bluemix.net/swagger-api/
  * UE Central: https://eu-central.containers.bluemix.net/swagger-api/
  * UK Sur: https://uk-south.containers.bluemix.net/swagger-api/
  * EE.UU. Este: https://us-east.containers.bluemix.net/swagger-api/
  * EE.UU. Sur: https://us-south.containers.bluemix.net/swagger-api/
