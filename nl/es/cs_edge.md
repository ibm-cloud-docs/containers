---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Restricción del tráfico de red para los nodos trabajadores de extremo
{: #edge}

Los nodos trabajadores de extremo pueden mejorar la seguridad de su clúster al permitir el acceso externo a un número inferior de nodos trabajadores y aislar la carga de trabajo en red. Cuando estos nodos trabajadores se marcan solo para trabajo en red, las demás cargas de trabajo no pueden consumir la CPU ni la memoria del nodo trabajador ni interferir con la red.
{:shortdesc}

## Etiquetar nodos trabajadores como nodos extremos
{: #edge_nodes}

Añada la etiqueta `dedicated=edge` a dos o más nodos trabajadores en el clúster para garantizar que Ingress y los equilibradores de carga están desplegados solo en los nodos trabajadores.

Antes de empezar:

- [Cree un clúster estándar.](cs_clusters.html#clusters_cli)
- Asegúrese de que el clúster tiene al menos una VLAN pública. Los nodos trabajadores de extremo no están disponibles para clústeres solo con VLAN privadas.
- [Defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure).

Pasos:

1. Obtenga una lista de todos los nodos trabajadores del clúster. Utilice la dirección IP privada de la columna **NAME** para identificar los nodos. Seleccione al menos dos nodos trabajadores para que sean nodos trabajadores de extremo. Utilizar dos o más nodos trabajadores mejora la disponibilidad de los recursos de red.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated
  ```
  {: pre}

2. Añada a los nodos trabajadores la etiqueta `dedicated=edge`. Cuando un nodo se ha marcado con `dedicated=edge`, todos los Ingress y equilibradores de carga posteriores se despliegan en un nodo trabajador de extremo.

  ```
  kubectl label nodes <node_name> <node_name2> dedicated=edge
  ```
  {: pre}

3. Recupere todos los servicios del equilibrador de carga existente en el clúster.

  ```
  kubectl get services --all-namespaces -o jsonpath='{range .items[*]}kubectl get service -n {.metadata.namespace} {.metadata.name} -o yaml | kubectl apply -f - :{.spec.type},{end}' | tr "," "\n" | grep "LoadBalancer" | cut -d':' -f1
  ```
  {: pre}

  Salida:

  ```
  kubectl get service -n <namespace> <name> -o yaml | kubectl apply -f
  ```
  {: screen}

4. Con la salida del paso anterior, copie y pegue cada línea `kubectl get service`. Este mandato vuelve a desplegar el equilibrador de carga en un nodo trabajador de extremo. Solo es necesario volver a desplegar los equilibradores de carga públicos.

  Salida:

  ```
  service "<name>" configured
  ```
  {: screen}

Se ha añadido a los nodos trabajadores la etiqueta `dedicated=edge` y se han vuelto a desplegar todos los equilibradores de carga existentes e Ingress en los nodos trabajadores de extremo. A continuación, evite que el resto de las [cargas de trabajo se ejecuten en los nodos trabajadores de extremo](#edge_workloads) y [bloquee el tráfico entrante en los puertos de nodo de los nodos trabajadores](cs_network_policy.html#block_ingress).

<br />


## Restricción de la ejecución de cargas de trabajo en los nodos trabajadores de extremo
{: #edge_workloads}

Una de las ventajas de los nodos trabajadores extremos es que se puede especificar que solo ejecuten servicios de red. Mediante la tolerancia `dedicated=edge` se conseguirá que todos los servicios de equilibradores de carga y de Ingress se desplieguen solo en los nodos trabajadores etiquetados. Sin embargo, para evitar que se ejecuten otras cargas de trabajo en los nodos trabajadores de extremo y consuman recursos de los nodos trabajadores, se deben utilizar [corrupciones de Kubernetes ![Enlace de icono externo](../icons/launch-glyph.svg "Enlace de icono externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/).
{:shortdesc}

1. Obtenga una lista de todos los nodos trabajadores con la etiqueta `edge`.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Aplique una corrupción a cada nodo trabajador que impida que los pods se ejecuten en el nodo trabajador y que elimine los pods que no tengan la etiqueta `edge` del nodo trabajador. Los pods que se eliminen se volverán a desplegar en los demás nodos trabajadores con capacidad.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```

Ahora, solo se desplegarán en los nodos trabajadores de extremo los pods con la tolerancia `dedicated=edge`.
