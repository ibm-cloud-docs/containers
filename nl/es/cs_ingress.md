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



# Configuración de Ingress
{: #ingress}

Exponga varias apps en el clúster de Kubernetes creando recursos Ingress gestionados por el equilibrador de carga de aplicación proporcionado por IBM en {{site.data.keyword.containerlong}}.
{:shortdesc}

## Archivos YAML de ejemplo
{: #sample_ingress}

Utilice estos archivos YAML de ejemplo para comenzar a especificar rápidamente su recurso de Ingress.
{: shortdesc}

**Recurso de Ingress para exponer una app públicamente**</br>

¿Ya ha llevado a cabo los siguientes pasos?
- Desplegar una app
- Crear un servicio de app
- Seleccione un nombre de dominio y un secreto de TLS

Puede utilizar el siguiente archivo YAML de despliegue para crear un recurso de Ingress:

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingressresource
spec:
  tls:
  - hosts:
    - <domain>
    secretName: <tls_secret_name>
  rules:
  - host: <domain>
    http:
      paths:
      - path: /<app1_path>
        backend:
          serviceName: <app1_service>
          servicePort: 80
      - path: /<app2_path>
        backend:
          serviceName: <app2_service>
          servicePort: 80
```
{: codeblock}

</br>

**Recurso de Ingress para exponer una app de forma privada**</br>

¿Ya ha llevado a cabo los siguientes pasos?
- Habilitar un ALB privado
- Desplegar una app
- Crear un servicio de app
- Registrar un nombre de dominio personalizado y un secreto de TLS

Puede utilizar el siguiente archivo YAML de despliegue para crear un recurso de Ingress:

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingressresource
  annotations:
    ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
spec:
  tls:
  - hosts:
    - <domain>
    secretName: <tls_secret_name>
  rules:
  - host: <domain>
    http:
      paths:
      - path: /<app1_path>
        backend:
          serviceName: <app1_service>
          servicePort: 80
      - path: /<app2_path>
        backend:
          serviceName: <app2_service>
          servicePort: 80
```
{: codeblock}

<br />


## Requisitos previos
{: #config_prereqs}

Antes de empezar a trabajar con Ingress, revise los siguientes requisitos previos.
{:shortdesc}

**Requisitos previos para todas las configuraciones de Ingress:**
- Ingress únicamente está disponible para los clústeres estándares y necesita al menos dos nodos trabajadores por zona para garantizar la alta disponibilidad y que se aplican actualizaciones periódicas. Si solo tiene un nodo trabajador en una zona, el ALB no puede recibir actualizaciones automáticas. Cuando se despliegan actualizaciones automáticas en los pods de ALB, el pod se vuelve a cargar. Sin embargo, los pods de ALB tienen reglas antiafinidad para garantizar que solo hay un pod planificado para en cada nodo trabajador para alta disponibilidad. Puesto que solo hay un pod de ALB en un nodo trabajador, el pod no se reinicia para que el tráfico no se interrumpa. El pod ALB se actualiza a la última versión solo cuando se suprime suprimir el pod anterior para que se pueda planificar el nuevo pod actualizado.
- Para configurar Ingress se necesitan los siguientes [roles de {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform):
    - Rol de plataforma de **Administrador** sobre el clúster
    - Rol de servicio de **Gestor** sobre todos los espacios de nombres

**Requisitos previos para el uso de Ingress en clústeres multizona:**:
 - Si restringe el tráfico de red a los [nodos trabajadores de extremo](/docs/containers?topic=containers-edge), debe haber al menos dos nodos trabajadores de extremo en cada zona para conseguir una alta disponibilidad de los pods Ingress. [Cree una agrupación de nodos trabajadores de extremo](/docs/containers?topic=containers-add_workers#add_pool) que abarque todas las zonas del clúster y tenga como mínimo dos nodos trabajadores por zona.
 - Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) para la cuenta de infraestructura de IBM Cloud para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para habilitar VRF, [póngase en contacto con el representante de su cuenta de la infraestructura de IBM Cloud](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Para comprobar si un VRF ya está habilitado, utilice el mandato `ibmcloud account show`. Si no puede o no desea habilitar VRF, habilite la [distribución de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](/docs/containers?topic=containers-users#infra_access) **Red > Gestionar distribución de VLAN de red** o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmCloud ks vlan-spanning-get --region <region>`.
 - Si una zona falla, es posible que vea anomalías intermitentes en las solicitudes al ALB Ingress en dicha zona.

<br />


## Planificación de red para espacios de nombres múltiples o individuales
{: #multiple_namespaces}

Se necesita un recurso Ingress por espacio de nombres donde tenga apps que desee exponer.
{:shortdesc}

### Todas las apps están en un espacio de nombres
{: #one-ns}

Si las apps en el clúster están en el mismo espacio de nombres, se necesita un recurso de Ingress para definir las reglas de direccionamiento para las apps allí expuestas. Por ejemplo, si los servicios en un espacio de nombres de desarrollo exponen las apps `app1` y `app2`, puede crear un recurso de Ingress en el espacio de nombres. El recurso especifica `domain.net` como host y registra las vías que cada app escucha con `domain.net`.
{: shortdesc}

<img src="images/cs_ingress_single_ns.png" width="270" alt="Se necesita un recurso por espacio de nombres." style="width:270px; border-style: none"/>

### Las apps están en varios espacios de nombres
{: #multi-ns}

Si las apps en el clúster están en distintos espacios de nombres, se debe crear un recurso por espacio de nombres para definir reglas para las apps allí expuestas.
{: shortdesc}

Sin embargo, puede definir un nombre de host en un solo recurso. No puede definir el mismo nombre de host en varios recursos. Para registrar varios recursos de Ingress con el mismo nombre de host, debe utilizar un dominio comodín. Cuando se registra un dominio comodín como `*.domain.net`, varios subdominios se pueden resolver en el mismo host. A continuación, puede crear un recurso de Ingress en cada espacio de nombres y especificar un subdominio diferente en cada recurso de Ingress.

Por ejemplo, considere el escenario siguiente:
* Tiene dos versiones de la misma app, `app1` y `app3`, para fines de prueba.
* Despliega las apps en dos espacios de nombres diferentes dentro del mismo clúster: `app1` en el espacio de nombres de desarrollo y `app3` en el espacio de nombres de transferencia.

Para utilizar el mismo ALB de clúster para gestionar el tráfico a estas apps, puede crear los siguientes servicios y recursos:
* Un servicio Kubernetes en el espacio de nombres de desarrollo para exponer `app1`.
* Un recurso de Ingress en el espacio de nombres de desarrollo que especifica el host como `dev.domain.net`.
* Un servicio Kubernetes en el espacio de nombres de transferencia para exponer `app3`.
* Un recurso de Ingress en el espacio de nombres de transferencia que especifica el host como `stage.domain.net`.
</br>
<img src="images/cs_ingress_multi_ns.png" width="625" alt="Dentro de un espacio de nombres, utilice subdominios en uno o varios recursos" style="width:625px; border-style: none"/>

Ahora, ambos URL se resuelven al mismo dominio y, por lo tanto, el mismo ALB da servicio a ambos URL. Sin embargo, puesto que el recurso en el espacio de nombres de transferencia está registrado con el subdominio `stage`, el ALB de Ingress direcciona correctamente las solicitudes desde el URL `stage.domain.net/app3` únicamente a `app3`.

{: #wildcard_tls}
El comodín de subdominio de Ingress que IBM proporciona, `*.<cluster_name>.<region>.containers.appdomain.cloud`, está registrado de forma predeterminada para su clúster. El certificado TLS proporcionado por IBM es un certificado comodín y se puede utilizar para el subdominio comodín. Si desea utilizar un dominio personalizado, debe registrar el dominio personalizado como un dominio comodín como, por ejemplo, `*.custom_domain.net`. Para utilizar TLS, debe obtener un certificado comodín.
{: note}

### Varios dominios dentro del mismo espacio de nombres
{: #multi-domains}

En un espacio de nombres individual, puede utilizar un dominio para acceder a todas las apps en el espacio de nombres. Si desea utilizar diferentes dominios para las apps dentro de un espacio de nombres individual, utilice un dominio comodín. Cuando se registra un dominio comodín como `*.mycluster.us-south.containers.appdomain.cloud`, varios subdominios se resuelven todos ellos al mismo host. A continuación, puede utilizar un recurso para especificar varios hosts de subdominio dentro de dicho recurso. Como alternativa, puede crear varios recursos de Ingress en el espacio de nombres y especificar un subdominio diferente en cada recurso de Ingress.
{: shortdesc}

<img src="images/cs_ingress_single_ns_multi_subs.png" width="625" alt="Se necesita un recurso por espacio de nombres." style="width:625px; border-style: none"/>

El comodín de subdominio de Ingress que IBM proporciona, `*.<cluster_name>.<region>.containers.appdomain.cloud`, está registrado de forma predeterminada para su clúster. El certificado TLS proporcionado por IBM es un certificado comodín y se puede utilizar para el subdominio comodín. Si desea utilizar un dominio personalizado, debe registrar el dominio personalizado como un dominio comodín como, por ejemplo, `*.custom_domain.net`. Para utilizar TLS, debe obtener un certificado comodín.
{: note}

<br />


## Exposición de apps que están dentro de su clúster al público
{: #ingress_expose_public}

Exponga apps que están dentro de su clúster al público utilizando el ALB de Ingress público.
{:shortdesc}

Antes de empezar:

* Revise los [requisitos previos](#config_prereqs) de Ingress.
* [Inicie una sesión en su cuenta. Si procede, apunte al grupo de recursos adecuado. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

### Paso 1: Desplegar apps y crear servicios de app
{: #public_inside_1}

Empiece desplegando sus apps y crear servicios de Kubernetes para exponerlos.
{: shortdesc}

1.  [Despliegue la app en el clúster](/docs/containers?topic=containers-app#app_cli). Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración como, por ejemplo, `app: code`. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse dichos pods en el equilibrio de carga de Ingress.

2.   Cree un servicio de Kubernetes para cada app que desee exponer. El servicio de Kubernetes debe exponer la app para incluirla en el ALB de clúster en el equilibrio de carga de Ingress.
      1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myappservice.yaml`.
      2.  Defina un servicio para la app que el ALB expondrá.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icono de idea"/> Componentes del archivo YAML del servicio del ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Especifique el par de clave de etiqueta (<em>&lt;selector_key&gt;</em>) y valor (<em>&lt;selector_value&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Para especificar e incluir sus pods en el equilibrio de carga del servicio, asegúrese de que <em>&lt;selector_key&gt;</em> y <em>&lt;selector_value&gt;</em> coinciden con el par de clave/valor en la sección <code>spec.template.metadata.labels</code> de su archivo YAML de despliegue.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>El puerto que en el que está a la escucha el servicio.</td>
           </tr>
           </tbody></table>
      3.  Guarde los cambios.
      4.  Cree el servicio en el clúster. Si las apps están desplegadas en varios espacios de nombres en el clúster, asegúrese de que el servicio se despliega en el mismo espacio de nombres que la app que desea exponer.

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  Repita estos pasos para cada app que desee exponer.


### Paso 2: Seleccionar un dominio de app
{: #public_inside_2}

Cuando configure el ALB público, elija el dominio en el que sus apps serán accesibles.
{: shortdesc}

Puede utilizar el dominio proporcionado por IBM, como por ejemplo `mycluster-12345.us-south.containers.appdomain.cloud/myapp`, para acceder a su app desde Internet. Para utilizar en su lugar un dominio personalizado, puede configurar un registro CNAME para correlacionar su dominio personalizado con el dominio proporcionado por IBM o puede configurar un registro A con su proveedor de DNS que utiliza la dirección IP pública del ALB.

**Para utilizar el dominio de Ingress proporcionado por IBM:**

Obtenga el dominio proporcionado por IBM. Sustituya `<cluster_name_or_ID>` por el nombre del clúster en el que se ha desplegado la app.
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

Salida de ejemplo:
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}

**Para utilizar un dominio personalizado:**
1.    Cree un dominio personalizado. Para registrar un dominio personalizado, póngase en contacto con su proveedor de DNS (Domain Name Service) o con [{{site.data.keyword.cloud_notm}} DNS](/docs/infrastructure/dns?topic=dns-getting-started).
      * Si las apps que desea que Ingress exponga se encuentran en diferentes espacios de nombres en un clúster, registre el dominio personalizado como un dominio comodín como, por ejemplo, `*.custom_domain.net`.

2.  Configure el dominio de modo que direccione el tráfico de red de entrada al ALB proporcionado por IBM. Puede elegir entre las siguientes opciones:
    -   Defina un alias para el dominio personalizado especificando el dominio proporcionado por IBM como CNAME (Registro de nombre canónico). Para encontrar el dominio de Ingress proporcionado por IBM, ejecute `ibmcloud ks cluster-get --cluster <cluster_name>` y busque el campo **Subdominio de Ingress**. Se prefiere el uso de un CNAME porque IBM proporciona comprobaciones de estado automáticas en el subdominio de IBM y elimina cualquier IP anómala de la respuesta de DNS.
    -   Correlacione el dominio personalizado con la dirección IP pública portátil del ALB proporcionado por IBM añadiendo la dirección IP como un registro A. Para localizar la dirección IP pública portátil del ALB, ejecute `ibmcloud ks alb-get --albID <public_alb_ID>`.

### Paso 3: Seleccionar terminación TLS
{: #public_inside_3}

Después de elegir el dominio de la app, elija si desea utilizar o no la terminación TLS.
{: shortdesc}

El ALB equilibra carga de tráfico de red HTTP para las apps en su clúster. Para equilibrar también la carga de conexiones HTTPS entrantes, puede configurar el ALB para descifrar el tráfico de red y reenviar las solicitudes descifradas a las apps expuestas en su clúster.

* Si utiliza el subdominio de Ingress proporcionado por IBM, puede utilizar el certificado TLS proporcionado por IBM. Los certificados TLS proporcionados por IBM están firmados por LetsEncrypt y están gestionados por completo por IBM. Los certificados caducan cada 90 días y se renuevan automáticamente 37 días antes de que caduquen. Para obtener más información sobre la certificación de TLS comodín, consulte [esta nota](#wildcard_tls).
* Si utiliza un dominio personalizado, puede utilizar su propio certificado TLS para gestionar la terminación TLS. En primer lugar, el ALB comprueba si hay un secreto en el espacio de nombres en el que se encuentra la app, luego en `default` y, finalmente, en `ibm-cert-store`. Si tiene apps en un solo espacio de nombres, puede importar o crear un secreto TLS para el certificado en ese mismo espacio de nombres. Si tiene apps en varios espacios de nombres, importe o cree un secreto TLS para el certificado en el espacio de nombres `default` de forma que el ALB pueda acceder y utilizar el certificado en cada espacio de nombres. En los recursos de Ingress que defina para cada espacio de nombres, especifique el nombre del secreto que se encuentra en el espacio de nombres predeterminado. Para obtener más información sobre la certificación de TLS comodín, consulte [esta nota](#wildcard_tls). **Nota**: los certificados TLS que contienen claves precompartidas (TLS-PSK) no están soportados.

**Si utiliza el dominio Ingress proporcionado por IBM:**

Obtenga el secreto TLS proporcionado por IBM para el clúster.
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

Salida de ejemplo:
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}
</br>

**Si utiliza un dominio personalizado:**

Si hay un certificado TLS almacenado en {{site.data.keyword.cloudcerts_long_notm}} que desea utilizar, puede importar su secreto asociado a su clúster ejecutando el siguiente mandato:

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

Asegúrese de que no crea el secreto con el mismo nombre que el secreto de Ingress proporcionado por IBM. Puede obtener el nombre del secreto de Ingress proporcionado por IBM con el mandato `ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress`.
{: note}

Cuando importa un certificado con este mandato, el secreto de certificado se crea en un espacio de nombres denominado `ibm-cert-store`. A continuación, se crea una referencia a este secreto en el espacio de nombres `default`, al que puede acceder cualquier recurso de Ingress en cualquier espacio de nombres. Cuando el ALB está procesando solicitudes, sigue esta referencia para seleccionar y utilizar el secreto de certificado del espacio de nombres `ibm-cert-store`.

</br>

Si no tiene un certificado TLS listo, siga estos pasos:
1. Genere un certificado de la autoridad de certificados (CA) y una clave de su proveedor de certificados. Si tiene su propio dominio, compre un certificado TLS oficial para el mismo. Asegúrese de que el [CN ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://support.dnsimple.com/articles/what-is-common-name/) sea distinto para cada certificado.
2. Convierta el cert y la clave a base 64.
   1. Codifique el cert y la clave en la base 64 y guarde el valor codificado en base 64 en un nuevo archivo.
      ```
      openssl base64 -in tls.key -out tls.key.base64
      ```
      {: pre}

   2. Vea el valor codificado en base 64 para el cert y la clave.
      ```
      cat tls.key.base64
      ```
      {: pre}

3. Cree un archivo YAML secreto utilizando el certificado y la clave.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. Cree el certificado como un secreto de Kubernetes.
     ```
     kubectl apply -f ssl-my-test
     ```
     {: pre}
     Asegúrese de que no crea el secreto con el mismo nombre que el secreto de Ingress proporcionado por IBM. Puede obtener el nombre del secreto de Ingress proporcionado por IBM con el mandato `ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress`.
     {: note}


### Paso 4: Crear el recurso de Ingress
{: #public_inside_4}

Los recursos de Ingress definen las reglas de direccionamiento que los ALB utilizan para direccionar el tráfico a su servicio de app.
{: shortdesc}

Si el clúster tiene varios espacios de nombres donde se exponen las apps, se necesita un recurso de Ingress por espacio de nombres. Sin embargo, cada espacio de nombres debe utilizar un host diferente. Debe registrar un dominio comodín y especificar un subdominio diferente en cada recurso. Para obtener más información, consulte [Planificación de redes para uno o varios espacios de nombres](#multiple_namespaces).
{: note}

1. Abra el editor que prefiera y cree un archivo de configuración de Ingress llamado, por ejemplo, `myingressresource.yaml`.

2. Defina un recurso de Ingress en el archivo de configuración que utilice el dominio proporcionado por IBM o su dominio personalizado para direccionar el tráfico de entrada de red a los servicios que ha creado anteriormente.

    YAML de ejemplo que no utiliza TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    YAML de ejemplo que utiliza TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls.hosts</code></td>
    <td>Para utilizar TLS, sustituya <em>&lt;domain&gt;</em> con el subdominio de Ingress proporcionado por IBM o su dominio personalizado.

    </br></br>
    <strong>Nota:</strong><ul><li>Si sus apps están expuestas por los servicios en diferentes espacios de nombres en un clúster, añada un subdominio comodín al principio del dominio como, por ejemplo, `subdomain1.custom_domain.net` o `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilice un subdominio exclusivo para cada recurso que cree en el clúster.</li><li>No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls.secretName</code></td>
    <td><ul><li>Si utiliza el dominio de Ingress proporcionado por IBM, sustituya <em>&lt;tls_secret_name&gt;</em> por el nombre del secreto de Ingress proporcionado por IBM.</li><li>Si utiliza un dominio personalizado, sustituya <em>&lt;tls_secret_name&gt;</em> por el secreto que ha creado anteriormente que aloja la clave y el certificado TLS personalizados. Si ha importado un certificado de {{site.data.keyword.cloudcerts_short}}, puede ejecutar <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> para ver los secretos que están asociados con un certificado TLS.</li><ul><td>
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Sustituya <em>&lt;domain&gt;</em> con el subdominio de Ingress proporcionado por IBM o su dominio personalizado.

    </br></br>
    <strong>Nota:</strong><ul><li>Si sus apps están expuestas por los servicios en diferentes espacios de nombres en un clúster, añada un subdominio comodín al principio del dominio como, por ejemplo, `subdomain1.custom_domain.net` o `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilice un subdominio exclusivo para cada recurso que cree en el clúster.</li><li>No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Sustituya <em>&lt;app_path&gt;</em> con una barra inclinada o con la vía de acceso en la que su app está a la escucha. La vía de acceso se añade al dominio personalizado o proporcionado por IBM para crear una ruta exclusiva a su app. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al ALB. El ALB consulta el servicio asociado y envía el tráfico de red al servicio. A continuación, el servicio reenvía el tráfico a los pods en los que la app está en ejecución.
    </br></br>
    Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app. Ejemplos: <ul><li>Para <code>http://domain/</code>, especifique <code>/</code> como la vía de acceso.</li><li>Para <code>http://domain/app1_path</code>, especifique <code>/app1_path</code> como la vía de acceso.</li></ul>
    </br>
    <strong>Sugerencia:</strong> Para configurar Ingress para que escuche en una vía de acceso que sea distinta a la vía de acceso en la que escucha la app, utilice la [anotación de reescritura](/docs/containers?topic=containers-ingress_annotation#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Sustituya <em>&lt;app1_service&gt;</em> y <em>&lt;app2_service&gt;</em> y así sucesivamente con el nombre de los servicios que ha creado para exponer sus apps. Si sus apps están expuestas por los servicios en diferentes espacios de nombres en el clúster, incluya únicamente los servicios de app que se encuentran en el mismo espacio de nombres. Debe crear un recurso de Ingress para cada espacio de nombres donde tiene las apps que desea exponer.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
    </tr>
    </tbody></table>

3.  Cree el recurso de Ingress para el clúster. Asegúrese de que el recurso se despliega en el mismo espacio de nombres que los servicios de apps que ha especificado en el recurso.

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Verifique que el recurso de Ingress se haya creado correctamente.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si los mensajes en los sucesos describen un error en la configuración del recurso, cambie los valores en el archivo de recursos y aplique de nuevo el archivo del recurso.


El recurso de Ingress se crea en el mismo espacio de nombres que los servicios de las apps. Sus apps en este espacio de nombres se registran con el ALB de Ingress del clúster.

### Paso 5: Acceder a la app desde Internet
{: #public_inside_5}

En un navegador web, escriba el URL del servicio de la app al que va a acceder.
{: shortdesc}

```
https://<domain>/<app1_path>
```
{: codeblock}

Si tiene varias apps expuestas, acceda a dichas apps cambiando la vía de acceso que se añade al final del URL.

```
https://<domain>/<app2_path>
```
{: codeblock}

Si utiliza un dominio comodín para exponer apps en diferentes espacios de nombres, acceda a dichas apps con sus propios subdominios.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


¿Tiene problemas para conectarse a su app a través de Ingress? Intente [depurar Ingress](/docs/containers?topic=containers-cs_troubleshoot_debug_ingress).
{: tip}

<br />


## Exposición de apps que están fuera de su clúster al público
{: #external_endpoint}

Exponga apps que están fuera de su clúster al público incluyéndolas en el equilibrio de carga del ALB de Ingress público. Las solicitudes públicas entrantes en el dominio personalizado o proporcionado por IBM se reenvían automáticamente a la app externa.
{: shortdesc}

Antes de empezar:

* Revise los [requisitos previos](#config_prereqs) de Ingress.
* Asegúrese de que se pueda acceder a la app externa que desea incluir en el equilibrio de la carga del clúster mediante una dirección IP pública.
* [Inicie una sesión en su cuenta. Si procede, apunte al grupo de recursos adecuado. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Para exponer apps que están fuera de su clúster al público:

1.  Cree un servicio de Kubernetes para el clúster que enviará las solicitudes entrantes a un punto final externo que habrá creado.
    1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myexternalservice.yaml`.
    2.  Defina un servicio para la app que el ALB expondrá.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myexternalservice
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Visión general de los componentes de archivo del servicio ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata.name</code></td>
        <td>Sustituya <em><code>&lt;myexternalservice&gt;</code></em> por el nombre del servicio.<p>Obtenga más información sobre cómo [proteger su información personal](/docs/containers?topic=containers-security#pi) cuando se trabaja recursos de Kubernetes.</p></td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>El puerto que en el que está a la escucha el servicio.</td>
        </tr></tbody></table>

    3.  Guarde los cambios.
    4.  Cree el servicio de Kubernetes para el clúster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}
2.  Configure un punto final de Kubernetes que defina la ubicación externa de la app que desea incluir en el equilibrio de la carga del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de punto final llamado, por ejemplo, `myexternalendpoint.yaml`.
    2.  Defina el punto final externo. Incluya todas las direcciones IP públicas y puertos que puede utilizar para acceder a la app externa.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalservice
        subsets:
          - addresses:
              - ip: <external_IP1>
              - ip: <external_IP2>
            ports:
              - port: <external_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em><code>&lt;myexternalendpoint&gt;</code></em> por el nombre del servicio de Kubernetes que ha creado anteriormente.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Sustituya <em>&lt;external_IP&gt;</em> por las direcciones IP públicas que desea conectar con la app externa.</td>
         </tr>
         <td><code>port</code></td>
         <td>Sustituya <em>&lt;external_port&gt;</em> por el puerto en el que escucha la app externa.</td>
         </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el punto final de Kubernetes para el clúster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

3. Continúe con los pasos de "Exposición de apps que están dentro de su clúster al público", [Paso 2: Seleccionar un dominio de app](#public_inside_2).

<br />


## Exposición de apps de una red privada
{: #ingress_expose_private}

Exposición de apps para una red privada utilizando el ALB de Ingress privado.
{:shortdesc}

Para utilizar un ALB privado, primero debe habilitar el ALB privado. Puesto que a los clústeres de solo VLAN privada no se les asigna un subdominio de Ingress proporcionado por IBM, no se crea ningún secreto de Ingress durante la configuración del clúster. Para exponer las apps a la red privada, debe registrar el ALB con un dominio personalizado y, opcionalmente, importar su propio certificado TLS.

Antes de empezar:
* Revise los [requisitos previos](#config_prereqs) de Ingress.
* Revise las opciones para planificar el acceso privado a las apps cuando los nodos trabajadores estén conectados a [una VLAN pública y una privada](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) o [solo a una VLAN privada](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan).
    * Si los nodos trabajadores están conectados únicamente a una VLAN privada, debe configurar un [servicio DNS que esté disponible en la red privada ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

### Paso 1: Desplegar apps y crear servicios de app
{: #private_1}

Empiece desplegando sus apps y crear servicios de Kubernetes para exponerlos.
{: shortdesc}

1.  [Despliegue la app en el clúster](/docs/containers?topic=containers-app#app_cli). Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración como, por ejemplo, `app: code`. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse dichos pods en el equilibrio de carga de Ingress.

2.   Cree un servicio de Kubernetes para cada app que desee exponer. El servicio de Kubernetes debe exponer la app para incluirla en el ALB de clúster en el equilibrio de carga de Ingress.
      1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myappservice.yaml`.
      2.  Defina un servicio para la app que el ALB expondrá.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icono de idea"/> Componentes del archivo YAML del servicio del ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Especifique el par de clave de etiqueta (<em>&lt;selector_key&gt;</em>) y valor (<em>&lt;selector_value&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Para especificar e incluir sus pods en el equilibrio de carga del servicio, asegúrese de que <em>&lt;selector_key&gt;</em> y <em>&lt;selector_value&gt;</em> coinciden con el par de clave/valor en la sección <code>spec.template.metadata.labels</code> de su archivo YAML de despliegue.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>El puerto que en el que está a la escucha el servicio.</td>
           </tr>
           </tbody></table>
      3.  Guarde los cambios.
      4.  Cree el servicio en el clúster. Si las apps están desplegadas en varios espacios de nombres en el clúster, asegúrese de que el servicio se despliega en el mismo espacio de nombres que la app que desea exponer.

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  Repita estos pasos para cada app que desee exponer.


### Paso 2: Habilitar el ALB privado predeterminado
{: #private_ingress}

Cuando se crea un clúster estándar, se crea un equilibrador de carga de aplicación (ALB) privado proporcionado por IBM en cada zona y se le asigna una dirección IP privada portátil y una ruta privada. Sin embargo, el ALB privado predeterminado de cada zona no se habilita automáticamente. Para utilizar el ALB privado predeterminado para el equilibrio de carga del tráfico de red privado para sus apps, primero debe habilitarlo con la dirección IP privada portátil proporcionada por IBM o con su propia dirección IP privada portátil.
{:shortdesc}

Si ha utilizado el distintivo `--no-subnet` al crear el clúster, debe añadir una subred privada portátil o una subred gestionada por el usuario para poder habilitar el ALB privado. Para obtener más información, consulte [Solicitud de más subredes para el clúster](/docs/containers?topic=containers-subnets#request).
{: note}

**Para habilitar un ALB privado utilizando la dirección IP privada portátil asignada previamente y proporcionada por IBM:**

1. Obtenga el ID del ALB privado predeterminado que desea habilitar. Sustituya <em>&lt;cluster_name&gt;</em> por el nombre del clúster en el que está desplegada la app que desea exponer.

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    El campo **Status** de los ALB privados tiene el valor _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.xx.xxx.xxx  dal10   ingress:411/ingress-auth:315   2234945
    ```
    {: screen}
    En los clústeres multizona, el sufijo numerado del ID del ALB indica el orden en el que se ha añadido el ALB.
    * Por ejemplo, el sufijo `-alb1` en el ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` indica que fue el primer ALB privado predeterminado que se ha creado. Existe en la zona en la que ha creado el clúster. En el ejemplo anterior, el clúster se ha creado en `dal10`.
    * El sufijo `-alb2` del ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` indica que fue el segundo ALB privado predeterminado que se ha creado. Existe en la segunda zona que ha añadido al clúster. En el ejemplo anterior, la segunda zona es `dal12`.

2. Habilite el ALB privado. Sustituya <em>&lt;private_ALB_ID&gt;</em> por el ID del ALB privado de la salida del paso anterior.

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}

3. **Clústeres multizona**: para obtener una alta disponibilidad, repita los pasos anteriores para el ALB privado en cada zona.

<br>
**Para habilitar el ALB privado utilizando la dirección IP privada portátil:**

1. Obtenga una lista de los ALB disponibles de su clúster. Anote el ID de un ALB privado y la zona en la que se encuentra el ALB.

 ```
 ibmcloud ks albs --cluster <cluster_name>
 ```
 {: pre}

 El campo **Status** del ALB privado es _disabled_.
 ```
 ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.xx.xxx.xxx  dal10   ingress:411/ingress-auth:315   2234945
 ```
 {: screen}

 2. Configure la subred gestionada por el usuario de la dirección IP seleccionada para direccionar el tráfico en la VLAN privada de dicha zona.

   ```
   ibmcloud ks cluster-user-subnet-add --cluster <cluster_name> --subnet-cidr <subnet_CIDR> --private-vlan <private_VLAN>
   ```
   {: pre}

   <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icono de idea"/> Componentes de mandatos</th>
   </thead>
   <tbody>
   <tr>
   <td><code>&lt;cluster_name&gt;</code></td>
   <td>El nombre o el ID del clúster en el que se despliega la app que desea exponer.</td>
   </tr>
   <tr>
   <td><code>&lt;subnet_CIDR&gt;</code></td>
   <td>El CIDR de la subred gestionada por el usuario.</td>
   </tr>
   <tr>
   <td><code>&lt;private_VLAN_ID&gt;</code></td>
   <td>El ID de la VLAN privada. Este valor es obligatorio. El ID debe ser para una VLAN privada en la misma zona que el ALB privado. Para ver las VLAN privadas para esta zona en la que se encuentran los nodos trabajadores, ejecute `ibmcloud ks workers --cluster <cluster_name_or_ID>` y anote el ID de un nodo trabajador en esta zona. Con el ID del nodo trabajador, ejecute `ibmcloud ks worker-get --worker <worker_id> --cluster <cluster_name_or_id>`. En la salida, fíjese en el ID de **VLAN privada**.</td>
   </tr>
   </tbody></table>

3. Habilite el ALB privado. Sustituya <em>&lt;private_ALB_ID&gt;</em> por el ID del ALB privado y <em>&lt;user_IP&gt;</em> por la dirección IP de la subred gestionada por el usuario que desea utilizar.
   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

4. **Clústeres multizona**: para obtener una alta disponibilidad, repita los pasos anteriores para el ALB privado en cada zona.

### Paso 3: Correlacionar el dominio personalizado
{: #private_3}

A los clústeres de solo VLAN privada no se les asigna un subdominio de Ingress proporcionado por IBM. Cuando configure el ALB privado, exponga las apps utilizando un dominio personalizado.
{: shortdesc}

**Clústeres de solo VLAN privada:**

1. Si los nodos trabajadores están conectados únicamente a una VLAN privada, debe configurar su propio [servicio DNS que esté disponible en su red privada ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
2. Cree un dominio personalizado a través del proveedor de DNS. Si las apps que desea que Ingress exponga se encuentran en distintos espacios de nombres en un clúster, registre el dominio personalizado como un dominio comodín, como por ejemplo *.custom_domain.net`.
3. Con el servicio DNS privado, correlacione el dominio personalizado con las direcciones IP privadas portátiles de los ALB añadiendo las direcciones IP como registros A. Para localizar las direcciones IP privadas portátiles de los ALB, ejecute `ibmcloud ks alb-get --albID <private_alb_ID>` para cada ALB.

**Clústeres de VLAN privada y pública:**

1.    Cree un dominio personalizado. Para registrar un dominio personalizado, póngase en contacto con su proveedor de DNS (Domain Name Service) o con [{{site.data.keyword.cloud_notm}} DNS](/docs/infrastructure/dns?topic=dns-getting-started).
      * Si las apps que desea que Ingress exponga se encuentran en diferentes espacios de nombres en un clúster, registre el dominio personalizado como un dominio comodín como, por ejemplo, `*.custom_domain.net`.

2.  Correlacione el dominio personalizado con las direcciones IP privadas portátiles de los ALB añadiendo las direcciones IP como registros A. Para localizar las direcciones IP privadas portátiles de los ALB, ejecute `ibmcloud ks alb-get --albID <private_alb_ID>` para cada ALB.

### Paso 4: Seleccionar terminación TLS
{: #private_4}

Después de correlacionar el dominio personalizado, elija si desea utilizar o no la terminación TLS.
{: shortdesc}

El ALB equilibra carga de tráfico de red HTTP para las apps en su clúster. Para equilibrar también la carga de conexiones HTTPS entrantes, puede configurar el ALB para descifrar el tráfico de red y reenviar las solicitudes descifradas a las apps expuestas en su clúster.

Puesto que a los clústeres de solo VLAN privada no se les asigna un dominio de Ingress proporcionado por IBM, no se crea ningún secreto de Ingress durante la configuración del clúster. Puede utilizar su propio certificado TLS para gestionar la terminación TLS.  En primer lugar, el ALB comprueba si hay un secreto en el espacio de nombres en el que se encuentra la app, luego en `default` y, finalmente, en `ibm-cert-store`. Si tiene apps en un solo espacio de nombres, puede importar o crear un secreto TLS para el certificado en ese mismo espacio de nombres. Si tiene apps en varios espacios de nombres, importe o cree un secreto TLS para el certificado en el espacio de nombres `default` de forma que el ALB pueda acceder y utilizar el certificado en cada espacio de nombres. En los recursos de Ingress que defina para cada espacio de nombres, especifique el nombre del secreto que se encuentra en el espacio de nombres predeterminado. Para obtener más información sobre la certificación de TLS comodín, consulte [esta nota](#wildcard_tls). **Nota**: los certificados TLS que contienen claves precompartidas (TLS-PSK) no están soportados.

Si hay un certificado TLS almacenado en {{site.data.keyword.cloudcerts_long_notm}} que desea utilizar, puede importar su secreto asociado a su clúster ejecutando el siguiente mandato:

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

Cuando importa un certificado con este mandato, el secreto de certificado se crea en un espacio de nombres denominado `ibm-cert-store`. A continuación, se crea una referencia a este secreto en el espacio de nombres `default`, al que puede acceder cualquier recurso de Ingress en cualquier espacio de nombres. Cuando el ALB está procesando solicitudes, sigue esta referencia para seleccionar y utilizar el secreto de certificado del espacio de nombres `ibm-cert-store`.

### Paso 5: Crear el recurso de Ingress
{: #private_5}

Los recursos de Ingress definen las reglas de direccionamiento que los ALB utilizan para direccionar el tráfico a su servicio de app.
{: shortdesc}

Si el clúster tiene varios espacios de nombres donde se exponen las apps, se necesita un recurso de Ingress por espacio de nombres. Sin embargo, cada espacio de nombres debe utilizar un host diferente. Debe registrar un dominio comodín y especificar un subdominio diferente en cada recurso. Para obtener más información, consulte [Planificación de redes para uno o varios espacios de nombres](#multiple_namespaces).
{: note}

1. Abra el editor que prefiera y cree un archivo de configuración de Ingress llamado, por ejemplo, `myingressresource.yaml`.

2.  Defina un recurso de Ingress en el archivo de configuración que utilice su dominio personalizado para direccionar el tráfico de entrada de red a los servicios que ha creado anteriormente.

    YAML de ejemplo que no utiliza TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    YAML de ejemplo que utiliza TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td>Sustituya <em>&lt;private_ALB_ID&gt;</em> por el ID del ALB privado. Si tiene un clúster multizona y ha habilitado varios ALB privados, incluya el ID de cada ALB. Ejecute <code>ibmcloud ks albs --cluster <my_cluster></code> para buscar los ID de ALB. Para obtener más información sobre esta anotación de Ingress, consulte [Direccionamiento del equilibrador de carga de aplicación privado](/docs/containers?topic=containers-ingress_annotation#alb-id).</td>
    </tr>
    <tr>
    <td><code>tls.hosts</code></td>
    <td>Para utilizar TLS, sustituya <em>&lt;domain&gt;</em> por su dominio personalizado.</br></br><strong>Nota:</strong><ul><li>Si sus apps están expuestas por los servicios en diferentes espacios de nombres en un clúster, añada un subdominio comodín al principio del dominio como, por ejemplo, `subdomain1.custom_domain.net`. Utilice un subdominio exclusivo para cada recurso que cree en el clúster.</li><li>No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls.secretName</code></td>
    <td>Sustituya <em>&lt;tls_secret_name&gt;</em> por el nombre del secreto que ha creado anteriormente y que contiene el certificado TLS personalizado y la clave. Si ha importado un certificado de {{site.data.keyword.cloudcerts_short}}, puede ejecutar <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> para ver los secretos que están asociados con un certificado TLS.
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Sustituya <em>&lt;domain&gt;</em> por su dominio personalizado.
    </br></br>
    <strong>Nota:</strong><ul><li>Si sus apps están expuestas por los servicios en diferentes espacios de nombres en un clúster, añada un subdominio comodín al principio del dominio como, por ejemplo, `subdomain1.custom_domain.net`. Utilice un subdominio exclusivo para cada recurso que cree en el clúster.</li><li>No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</li></ul></td>
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Sustituya <em>&lt;app_path&gt;</em> con una barra inclinada o con la vía de acceso en la que su app está a la escucha. La vía de acceso se añade al dominio personalizado para crear una ruta exclusiva a su app. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al ALB. El ALB consulta el servicio asociado y envía el tráfico de red al servicio. A continuación, el servicio reenvía el tráfico a los pods en los que la app está en ejecución.
    </br></br>
    Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app. Ejemplos: <ul><li>Para <code>http://domain/</code>, especifique <code>/</code> como la vía de acceso.</li><li>Para <code>http://domain/app1_path</code>, especifique <code>/app1_path</code> como la vía de acceso.</li></ul>
    </br>
    <strong>Sugerencia:</strong> Para configurar Ingress para que escuche en una vía de acceso que sea distinta a la vía de acceso en la que escucha la app, utilice la [anotación de reescritura](/docs/containers?topic=containers-ingress_annotation#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Sustituya <em>&lt;app1_service&gt;</em> y <em>&lt;app2_service&gt;</em> y así sucesivamente con el nombre de los servicios que ha creado para exponer sus apps. Si sus apps están expuestas por los servicios en diferentes espacios de nombres en el clúster, incluya únicamente los servicios de app que se encuentran en el mismo espacio de nombres. Debe crear un recurso de Ingress para cada espacio de nombres donde tiene las apps que desea exponer.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
    </tr>
    </tbody></table>

3.  Cree el recurso de Ingress para el clúster. Asegúrese de que el recurso se despliega en el mismo espacio de nombres que los servicios de apps que ha especificado en el recurso.

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Verifique que el recurso de Ingress se haya creado correctamente.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si los mensajes en los sucesos describen un error en la configuración del recurso, cambie los valores en el archivo de recursos y aplique de nuevo el archivo del recurso.


El recurso de Ingress se crea en el mismo espacio de nombres que los servicios de las apps. Sus apps en este espacio de nombres se registran con el ALB de Ingress del clúster.

### Paso 6: Acceder a la app desde su red privada
{: #private_6}

1. Para poder acceder a la app, asegúrese de que puede acceder a un servicio DNS.
  * VLAN públicas y privadas: para utilizar un proveedor de DNS externo, debe [configurar nodos de extremo con acceso público](/docs/containers?topic=containers-edge#edge) y [configurar un dispositivo Virtual Router Appliance ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).
  * Solo VLAN privadas: debe configurar un [servicio DNS que esté disponible en la red privada ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

2. Desde dentro de su cortafuegos de la red privada, especifique el URL del servicio de app en un navegador web.

```
https://<domain>/<app1_path>
```
{: codeblock}

Si tiene varias apps expuestas, acceda a dichas apps cambiando la vía de acceso que se añade al final del URL.

```
https://<domain>/<app2_path>
```
{: codeblock}

Si utiliza un dominio comodín para exponer apps en diferentes espacios de nombres, acceda a dichas apps con sus propios subdominios.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


Para obtener una guía completa sobre cómo proteger la comunicación entre microservicios en los clústeres utilizando el ALB privado con TLS, consulte [este artículo del este blog ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).
{: tip}
