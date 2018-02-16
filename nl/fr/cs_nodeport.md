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


# Configuration de services NodePort
{: #nodeport}

Rendez votre application accessible sur Internet en utilisant l'adresse IP publique de n'importe quel noeud worker dans un cluster et en exposant un port de noeud. Utilisez cette option à des fins de test et d'un accès public à court terme.
{:shortdesc}

## Configuration de l'accès public à une application à l'aide du type de service NodePort
{: #config}

Vous pouvez exposer votre application en tant que service Kubernetes NodePort pour les clusters léger ou standard.
{:shortdesc}

**Remarque :** l'adresse IP publique d'un noeud worker n'est pas permanente. Si le noeud worker doit être recréé, une nouvelle adresse IP publique lui est affectée. Si vous avez besoin d'une adresse IP publique stable et d'une plus grande disponibilité de votre service, exposez votre application en utilisant un [service LoadBalancer](cs_loadbalancer.html) ou [Ingress](cs_ingress.html).

Si vous n'avez pas encore d'application prête, vous pouvez utiliser l'exemple d'application Kubernetes intitulé [Guestbook ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml).

1.  Dans le fichier de configuration de votre application, définissez une section [service ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/service/).

    Exemple :

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <my-nodeport-service>
      labels:
        run: <my-demo>
    spec:
      selector:
        run: <my-demo>
      type: NodePort
      ports:
       - port: <8081>
         # nodePort: <31514>

    ```
    {: codeblock}

    <table>
    <caption>Description des composants de ce fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Description des composants de la section service NodePort</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Remplacez <code><em>&lt;my-nodeport-service&gt;</em></code> par le nom de votre service NodePort.</td>
    </tr>
    <tr>
    <td><code>run</code></td>
    <td>Remplacez <code><em>&lt;my-demo&gt;</em></code> par le nom de votre déploiement.</td>
    </tr>
    <tr>
    <td><code>port</code></td>
    <td>Remplacez <code><em>&lt;8081&gt;</em></code> par le port sur lequel votre service est à l'écoute. </td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>Facultatif : Remplacez <code><em>&lt;31514&gt;</em></code> par un NodePort sur la plage 30000 à 32767. Ne spécifiez pas de NodePort déjà utilisé par un autre service. Si aucune valeur NodePort n'est affectée, une valeur Nodeport aléatoire est affectée pour vous.<br><br>Si vous désirez spécifier un NodePort et savoir lesquels sont déjà utilisés, vous pouvez utiliser la commande suivante : <pre class="pre"><code>kubectl get svc</code></pre>Les NodePorts utilisés figurent sous la zone **Ports**.</td>
     </tr>
     </tbody></table>


    Dans l'exemple Guestbook, une section de service front-end existe déjà dans le fichier de configuration. Pour rendre l'application Guestbook disponible en externe, ajoutez le type NodePort et un NodePort sur la plage 30000 à 32767 dans la section de service front-end.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      type: NodePort
      ports:
      - port: 80
        nodePort: 31513
      selector:
        app: guestbook
        tier: frontend
    ```
    {: codeblock}

2.  Sauvegardez le fichier de configuration mis à jour.

3.  Répétez ces étapes pour créer un service NodePort pour chaque application que vous désirez exposer sur Internet.

**Etape suivante ?**

Une fois l'application déployée, vous pouvez utiliser l'adresse IP publique de n'importe quel noeud worker et le NodePort
pour composer l'URL publique d'accès à l'application dans un navigateur.

1.  Extrayez l'adresse IP publique d'un noeud worker dans le cluster.

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    Sortie :

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
    ```
    {: screen}

2.  Si un NodePort aléatoire a été affecté, identifiez-le.

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    Sortie :

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    Dans cet exemple, la valeur de NodePort est `30872`.

3.  Composez l'URL avec l'une des adresses IP publiques de noeud worker et le port de noeud (NodePort). Exemple : `http://192.0.2.23:30872`
