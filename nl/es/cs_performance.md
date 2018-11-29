---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Ajuste del rendimiento
{: #kernel}

Si tiene requisitos de optimización de rendimiento específicos, puede cambiar los valores predeterminados para los parámetros `sysctl` del kernel de Linux en los nodos trabajadores y los espacios de nombres de red de pod en {{site.data.keyword.containerlong}}.
{: shortdesc}

Los nodos trabajadores se suministran automáticamente con un rendimiento optimizado de kernel, pero puede cambiar los valores predeterminados aplicando un `DaemonSet` personalizado al clúster. El daemonset altera los valores de todos los nodos trabajadores existentes y aplica los valores a los nuevos nodos trabajadores que se suministran en el clúster. Los pods no se ven afectados.

Para optimizar los valores del kernel para los pods de app, puede insertar un initContainer en el YAML de `pod/ds/rs/deployment` para cada despliegue. El initContainer se añade a cada despliegue de app que se encuentra en el espacio de nombres de red de pod para el que desea optimizar el rendimiento.

Por ejemplo, en los ejemplos de las secciones siguientes se cambia el número máximo predeterminado de conexiones permitidas en el entorno mediante el valor `net.core.somaxconn` y el rango de puertos efímeros a través del valor `net.ipv4.ip_local_port_range`.

**Aviso**: si decide cambiar los valores predeterminados del parámetro de kernel, lo hace por su cuenta y riesgo. Usted es el responsable de ejecutar pruebas en cualquier configuración modificada y de cualquier interrupción potencial ocasionada por los valores modificados en el entorno.

## Optimización del rendimiento del nodo trabajador
{: #worker}

Aplique un [daemonset ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para cambiar los parámetros de kernel en el host de nodo trabajador.

**Nota**: debe tener el [rol de acceso de administrador](cs_users.html#access_policies) para ejecutar el initContainer de ejemplo con privilegios. Después de inicializar los contenedores para los despliegues, se descartarán los privilegios.

1. Guarde el daemonset siguiente en un archivo denominado `worker-node-kernel-settings.yaml`. En la sección `spec.template.spec.initContainers`, añada los campos y valores de los parámetros de `sysctl` que desea ajustar. En este ejemplo, el daemonset cambia los valores de los parámetros `net.core.somaxconn` y `net.ipv4.ip_local_port_range`.
    ```
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    metadata:
      name: kernel-optimization
      namespace: kube-system
      labels:
        tier: management
        app: kernel-optimization
    spec:
      template:
        metadata:
          labels:
            name: kernel-optimization
        spec:
          hostNetwork: true
          hostPID: true
          hostIPC: true
          initContainers:
            - mandato:
                - sh
                - -c
                - sysctl -w net.ipv4.ip_local_port_range="1025 65535"; sysctl -w net.core.somaxconn=32768;
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
                capabilities:
                  add:
                    - NET_ADMIN
              volumeMounts:
                - name: modifysys
                  mountPath: /sys
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                    sleep 100000;
                  done
          volumes:
            - name: modifysys
              hostPath:
                path: /sys
    ```
    {: codeblock}

2. Aplique el daemonset a los nodos trabajadores. Los cambios se aplican inmediatamente.
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

Para revertir los parámetros de `sysctl` de los nodos trabajadores a los valores predeterminados establecidos por {{site.data.keyword.containerlong_notm}}:

1. Suprima el daemonset. Se eliminan los initContainers que han aplicado los valores personalizados.
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [Rearranque todos los nodos trabajadores del clúster](cs_cli_reference.html#cs_worker_reboot). Los nodos trabajadores vuelven a estar en línea con los valores predeterminados aplicados.

<br />


## Optimización del rendimiento de pod
{: #pod}

Si tiene demandas de carga de trabajo específicas, puede aplicar un parche de [initContainer ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) para cambiar los parámetros de kernel de los pods de app.
{: shortdesc}

**Nota**: debe tener el [rol de acceso de administrador](cs_users.html#access_policies) para ejecutar el initContainer de ejemplo con privilegios. Después de inicializar los contenedores para los despliegues, se descartarán los privilegios.

1. Guarde el siguiente parche de initContainer en un archivo denominado `pod-patch.yaml` y añada los campos y los valores de los parámetros de `sysctl` que desea ajustar. En este ejemplo, initContainer cambia los valores de los parámetros `net.core.somaxconn` y `net.ipv4.ip_local_port_range`.
    ```
    spec:
      template:
        spec:
          initContainers:
          - mandato:
            - sh
            - -c
            - sysctl -e -w net.core.somaxconn=32768;  sysctl -e -w net.ipv4.ip_local_port_range="1025 65535";
            image: alpine:3.6
            imagePullPolicy: IfNotPresent
            name: sysctl
            resources: {}
            securityContext:
              privileged: true
    ```
    {: codeblock}

2. Aplique un parche a cada uno de los despliegues.
    ```
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. Si ha cambiado el valor `net.core.somaxconn` en los valores de kernel, la mayoría de las apps pueden utilizar automáticamente el valor actualizado. Sin embargo, es posible que en algunas apps se deba cambiar manualmente el valor correspondiente en el código de la app para que coincida con el valor del kernel. Por ejemplo, si va a ajustar el rendimiento de un pod en el que se ejecuta una app NGINX, debe cambiar el valor del campo `backlog` en el código de la app NGINX para que coincida. Para obtener más información, consulte esta [publicación del blog sobre NGINX ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.nginx.com/blog/tuning-nginx/).
