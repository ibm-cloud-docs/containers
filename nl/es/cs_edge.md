---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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



# Restricción del tráfico de red para los nodos trabajadores de extremo
{: #edge}

Los nodos trabajadores de extremo pueden mejorar la seguridad de su clúster de Kubernetes al permitir el acceso externo a un número inferior de nodos trabajadores y aislar la carga de trabajo en red en {{site.data.keyword.containerlong}}.
{:shortdesc}

Cuando estos nodos trabajadores se marcan solo para trabajo en red, las demás cargas de trabajo no pueden consumir la CPU ni la memoria del nodo trabajador ni interferir con la red.

Si tiene un clúster multizona y desea restringir el tráfico de red a los nodos trabajadores de extremo, debe haber al menos 2 nodos trabajadores de extremo en cada zona para conseguir una alta disponibilidad de los pods del equilibrador de carga o Ingress. Cree una agrupación de nodos trabajadores de extremo que abarque todas las zonas del clúster y tenga como mínimo 2 nodos trabajadores por zona.
{: tip}

## Cómo etiquetar nodos trabajadores como nodos extremos
{: #edge_nodes}

Añada la etiqueta `dedicated=edge` a dos o más nodos trabajadores en cada VLAN pública en el clúster para garantizar que Ingress y los equilibradores de carga están desplegados solo en los nodos trabajadores.
{:shortdesc}

Antes de empezar:

1. Asegúrese de que tiene los siguientes [roles de {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform):
  * Cualquier rol de plataforma para el clúster
  * Rol de **Escritor** o **Gestor** del servicio sobre todos los espacios de nombres
2. [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
3. Asegúrese de que el clúster tiene al menos una VLAN pública. Los nodos trabajadores de extremo no están disponibles para clústeres solo con VLAN privadas.
4. [Cree una nueva agrupación de nodos trabajadores](/docs/containers?topic=containers-clusters#add_pool) que abarque toda la zona del clúster y que tenga al menos 2 nodos trabajadores por zona.

Para etiquetar nodos trabajadores como nodos extremos:

1. Obtenga una lista de los nodos trabajadores de la agrupación de nodos trabajadores de extremo. Utilice la dirección **IP privada** para identificar los nodos.

  ```
  ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <edge_pool_name>
  ```
  {: pre}

2. Añada a los nodos trabajadores la etiqueta `dedicated=edge`. Cuando un nodo se ha marcado con `dedicated=edge`, todos los Ingress y equilibradores de carga posteriores se despliegan en un nodo trabajador de extremo.

  ```
  kubectl label nodes <node1_IP> <node2_IP> dedicated=edge
  ```
  {: pre}

3. Recupere todos los equilibradores de carga existentes y los equilibradores de carga de aplicación (ALB) Ingress del clúster.

  ```
  kubectl get services --all-namespaces
  ```
  {: pre}

  En la salida, busque los servicios que tengan como **Type** el valor **LoadBalancer**. Anote el valor de **Namespace** y de **Name** de cada servicio de equilibrador de carga. Por ejemplo, en la siguiente salida hay tres servicios de equilibrio de carga: el equilibrador de carga `webserver-lb` en el espacio de nombres `default` y los ALB Ingress `public-crdf253b6025d64944ab99ed63bb4567b6-alb1` y `public-crdf253b6025d64944ab99ed63bb4567b6-alb2`, en el espacio de nombres `kube-system`.

  ```
  NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
  default       kubernetes                                       ClusterIP      172.21.0.1       <none>          443/TCP                      1h
  default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                 10m
  kube-system   heapster                                         ClusterIP      172.21.101.189   <none>          80/TCP                       1h
  kube-system   kube-dns                                         ClusterIP      172.21.0.10      <none>          53/UDP,53/TCP                1h
  kube-system   kubernetes-dashboard                             ClusterIP      172.21.153.239   <none>          443/TCP                      1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.48.228.78   80:30286/TCP,443:31363/TCP   1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb2   LoadBalancer   172.21.229.73    169.46.17.6     80:31104/TCP,443:31138/TCP   57m
  ```
  {: screen}

4. Utilizando la salida del paso anterior, ejecute el mandato siguiente para cada uno de los equilibradores de carga y ALB Ingress. Este mandato vuelve a desplegar el equilibrador de carga o el ALB Ingress en un nodo trabajador de extremo. Solo se deben volver a desplegar los equilibradores de carga públicos o los ALB.

  ```
  kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
  ```
  {: pre}

  Salida de ejemplo:

  ```
  service "my_loadbalancer" configured
  ```
  {: screen}

Se ha añadido la etiqueta `dedicated=edge` a los nodos trabajadores y se han vuelto a desplegar todos los equilibradores de carga existentes e Ingress en los nodos trabajadores de extremo. A continuación, evite que el resto de las [cargas de trabajo se ejecuten en los nodos trabajadores de extremo](#edge_workloads) y [bloquee el tráfico entrante en los NodePorts de los nodos trabajadores](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Restricción de la ejecución de cargas de trabajo en los nodos trabajadores de extremo
{: #edge_workloads}

Una ventaja de los nodos trabajadores extremos es que se puede especificar que solo ejecuten servicios de red.
{:shortdesc}

Mediante la tolerancia `dedicated=edge` se conseguirá que todos los servicios de equilibradores de carga y de Ingress se desplieguen solo en los nodos trabajadores etiquetados. Sin embargo, para evitar que se ejecuten otras cargas de trabajo en los nodos trabajadores de extremo y consuman recursos de los nodos trabajadores, se deben utilizar [antagonismos de Kubernetes ![Enlace de icono externo](../icons/launch-glyph.svg "Enlace de icono externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/).

Antes de empezar:
- Asegúrese de tener el [rol de servicio de {{site.data.keyword.Bluemix_notm}} IAM de **Gestor** sobre todos los espacios de nombres](/docs/containers?topic=containers-users#platform).
- [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Para evitar la ejecución de otras cargas de trabajo en los nodos trabajadores de extremo:

1. Obtenga una lista de todos los nodos trabajadores con la etiqueta `dedicated=edge`.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Aplique un antagonismo a cada nodo trabajador que impida que los pods se ejecuten en el nodo trabajador y que elimine los pods que no tengan la etiqueta `dedicated=edge` del nodo trabajador. Los pods que se eliminen se volverán a desplegar en los demás nodos trabajadores con capacidad.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```
  {: pre}
  Ahora, solo se desplegarán en los nodos trabajadores de extremo los pods con la tolerancia `dedicated=edge`.

3. Si elige [habilitar la conservación de direcciones IP de origen para un servicio de equilibrio de carga 1.0 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), asegúrese de que los pods de apps están planificados en los nodos trabajadores de extremo [añadiendo afinidad de nodos de extremo a los pods de app](/docs/containers?topic=containers-loadbalancer#edge_nodes). Los pods de app se deben planificar en los nodos de extremo para recibir solicitudes entrantes.

4. Para eliminar un antagonismo, ejecute el siguiente mandato.
    ```
    kubectl taint node <node_name> dedicated:NoSchedule- dedicated:NoExecute-
    ```
    {: pre}
