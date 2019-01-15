---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# Limitazione del traffico di rete ai nodi di lavoro edge
{: #edge}

I nodi di lavoro edge possono migliorare la sicurezza del tuo cluster Kubernetes consentendo a un minor numero di nodi di lavoro di essere accessibili esternamente e isolando il carico di lavoro della rete in {{site.data.keyword.containerlong}}.
{:shortdesc}

Quando questi nodi di lavoro sono contrassegnati solo per la rete, gli altri carichi di lavoro non possono consumare la CPU o la memoria del nodo di lavoro e interferire con la rete.

Se hai un cluster multizona e vuoi limitare il traffico di rete ai nodi di lavoro edge, devi abilitare almeno 2 nodi di lavoro edge in ciascuna zona per l'alta disponibilità del programma di bilanciamento del carico o dei pod Ingress. Crea un pool di nodi di lavoro del nodo edge che si estenda tra tutte le zone del tuo cluster, con almeno 2 nodi di lavoro per zona.
{: tip}

## Etichettatura dei nodi di lavoro come nodi edge
{: #edge_nodes}

Aggiungi l'etichetta `dedicated=edge` a due o più nodi di lavoro su ogni VLAN pubblica nel tuo cluster per garantire che i programmi di bilanciamento del carico e Ingress vengano distribuiti solo a quei nodi di lavoro.
{:shortdesc}

Prima di iniziare:

1. Assicurati di avere un [ruolo della piattaforma](cs_users.html#platform) {{site.data.keyword.Bluemix_notm}} IAM.
2. [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).
3. Assicurati che il tuo cluster abbia almeno una VLAN pubblica. I nodi di lavoro edge non sono disponibili per i cluster con solo le VLAN private.
4. [Crea un nuovo pool di nodi di lavoro](cs_clusters.html#add_pool) che si estenda tra tutte le zone del tuo cluster e che abbia almeno 2 nodi di lavoro per zona.

Per etichettare i nodi di lavoro come nodi edge:

1. Elenca i nodi di lavoro nel tuo pool di nodi di lavoro del nodo edge. Utilizza l'indirizzo **IP privato** per identificare i nodi.

  ```
  ibmcloud ks workers <cluster_name_or_ID> --worker-pool <edge_pool_name>
  ```
  {: pre}

2. Etichetta i nodi di lavoro con `dedicated=edge`. Una volta che un nodo di lavoro è contrassegnato con `dedicated=edge`, tutti i successivi programmi di bilanciamento del carico e Ingress vengono distribuiti a un nodo di lavoro edge.

  ```
  kubectl label nodes <node1_IP> <node2_IP> dedicated=edge
  ```
  {: pre}

3. Richiama tutti i programmi di bilanciamento del carico e ALB (application load balancer) Ingress esistenti nel cluster.

  ```
  kubectl get services --all-namespaces
  ```
  {: pre}

  Nell'output, cerca i servizi che hanno il **Type** uguale a **LoadBalancer**. Nota lo **Spazio dei nomi** e il **Nome** di ogni servizio del programma di bilanciamento del carico. Ad esempio, nel seguente output, ci sono 3 servizi del programma di bilanciamento del carico: il programma di bilanciamento del carico `webserver-lb` nello spazio dei nomi `default` e gli ALB Ingress, `public-crdf253b6025d64944ab99ed63bb4567b6-alb1` e `public-crdf253b6025d64944ab99ed63bb4567b6-alb2`, nello spazio dei nomi `kube-system`.

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

4. Utilizzando l'output dal passo precedente, immetti il seguente comando per ogni programma di bilanciamento del carico e ALB Ingress. Questo comando ridistribuisce il programma di bilanciamento del carico o l'ALB Ingress a un nodo di lavoro edge. Solo i programmi di bilanciamento del carico o gli ALB pubblici devono essere ridistribuiti.

  ```
  kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
  ```
  {: pre}

  Output di esempio:

  ```
  service "my_loadbalancer" configured
  ```
  {: screen}

Hai etichettato i nodi di lavoro con `dedicated=edge` e hai ridistribuito tutti i programmi di bilanciamento del carico e Ingress esistenti ai nodi di lavoro edge. Successivamente, impedisci [l'esecuzione di altri carichi di lavoro sui nodi di lavoro edge](#edge_workloads) e [blocca il traffico in entrata verso le NodePort sui nodi di lavoro](cs_network_policy.html#block_ingress).

<br />


## Blocco dell'esecuzione dei carichi di lavoro sui nodi di lavoro edge
{: #edge_workloads}

Uno dei vantaggi dei nodi di lavoro edge è che possono essere specificati per eseguire solo i servizi di rete.
{:shortdesc}

L'utilizzo della tolleranza `dedicated=edge` indica che tutti i servizi di bilanciamento del carico e Ingress vengono distribuiti solo ai nodi di lavoro etichettati. Tuttavia, per impedire che altri carichi di lavoro vengano eseguiti sui nodi di lavoro edge e consumino le risorse dei nodi di lavoro, devi utilizzare le [corruzioni Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/).

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1. Elenca tutti i nodi di lavoro con l'etichetta `dedicated=edge`.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Applica una corruzione a ciascun nodo di lavoro che impedisce l'esecuzione dei pod sul nodo di lavoro e rimuove i pod che non hanno l'etichetta `dedicated=edge` dal nodo di lavoro. I pod che vengono rimossi vengono ridistribuiti su altri nodi di lavoro con capacità.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```
  {: pre}
  Adesso, solo i pod con la tolleranza `dedicated=edge` vengono distribuiti ai tuoi nodi di lavoro edge.

3. Se scegli di [abilitare la conservazione dell'IP di origine per un servizio del programma di bilanciamento del carico 1.0 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assicurati che i pod dell'applicazione siano pianificati sui nodi di lavoro edge [aggiungendo l'affinità del nodo edge ai pod dell'applicazione](cs_loadbalancer.html#edge_nodes). I pod dell'applicazione devono essere pianificati nei nodi edge per ricevere le richieste in entrata.
