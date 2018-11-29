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

# Consignation et surveillance d'Ingress
{: #ingress_health}

Personnalisez la consignation dans les journaux et configurez la surveillance pour vous aider à identifier et résoudre les erreurs et à améliorer les performances de la configuration de votre service Ingress.
{: shortdesc}

## Affichage des journaux Ingress
{: #ingress_logs}

Les journaux sont automatiquement collectés pour vos équilibreurs de charge d'application (ALB) Ingress. Pour afficher les journaux de l'ALB, vous avez le choix entre deux options :
* [Créer une configuration de consignation pour le service Ingress](cs_health.html#configuring) dans votre cluster.
* Consulter les journaux à partir de l'interface de ligne de commande (CLI).
    1. Obtenez l'ID d'un pod pour un équilibreur de charge ALB.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Ouvrez les journaux correspondant à ce pod d'ALB. Vérifiez que les journaux sont conformes au nouveau format.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

</br>Par défaut, le contenu des journaux est au format JSON et affiche des zones courantes qui décrivent la session de connexion entre un client et votre application. Voici un exemple de journal avec les zones par défaut :

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>Description des zones au format de journal Ingress par défaut</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des zones au format de journal Ingress par défaut</th>
</thead>
<tbody>
<tr>
<td><code>"time_date": "$time_iso8601"</code></td>
<td>Heure locale au format ISO 8601 standard au moment de l'écriture dans le journal.</td>
</tr>
<tr>
<td><code>"client": "$remote_addr"</code></td>
<td>Adresse IP du package de demande que le client a envoyé à votre application. Cette adresse IP change en fonction des situations suivantes :<ul><li>Lorsqu'une demande client vers votre application est envoyée à votre cluster, elle est acheminée à un pod pour le service d'équilibreur de charge qui expose l'équilibreur de charge d'application (ALB). S'il n'existe aucun pod d'application sur le même noeud worker que le pod de service d'équilibreur de charge, l'équilibreur de charge transmet la demande à un pod d'application sur un autre noeud worker. L'adresse IP source du package de demande est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod d'application.</li><li>Si la [conservation de l'adresse IP source est activée](cs_ingress.html#preserve_source_ip), l'adresse IP d'origine de la demande du client à votre application est enregistrée à la place.</li></ul></td>
</tr>
<tr>
<td><code>"host": "$http_host"</code></td>
<td>Hôte ou sous-domaine, via lequel vos applications sont accessibles. Cet hôte est configuré dans les fichiers de la ressource Ingress pour vos équilibreurs de charge d'application (ALB).</td>
</tr>
<tr>
<td><code>"scheme": "$scheme"</code></td>
<td>Type de demande : <code>HTTP</code> ou <code>HTTPS</code>.</td>
</tr>
<tr>
<td><code>"request_method": "$request_method"</code></td>
<td>Méthode d'appel de la demande à l'application de back end, par exemple <code>GET</code> ou <code>POST</code>.</td>
</tr>
<tr>
<td><code>"request_uri": "$uri"</code></td>
<td>URI de la demande d'origine vers votre chemin d'application. Les ALB traitent les chemins sur lesquels les applications sont à l'écoute en tant que préfixes. Lorsqu'un ALB reçoit une demande d'un client vers une application, il recherche un chemin (en tant que préfixe) dans la ressource Ingress, qui correspond au chemin dans l'URI.</td>
</tr>
<tr>
<td><code>"request_id": "$request_id"</code></td>
<td>Identificateur unique de la demande généré à partir de 16 octets aléatoires.</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>Code indiquant le statut de la session de connexion.<ul>
<li><code>200</code> : la session s'est terminée correctement</li>
<li><code>400</code> : les données du client n'ont pas pu être analysées</li>
<li><code>403</code> : accès interdit, par exemple lorsque l'accès est limité à certaines adresses IP client</li>
<li><code>500</code> : erreur de serveur interne</li>
<li><code>502</code> : passerelle incorrecte, par exemple si un serveur en amont est inaccessible ou qu'il est impossible de le sélectionner</li>
<li><code>503</code> : service non disponible, par exemple lorsque l'accès est limité à un certain nombre de connexions</li>
</ul></td>
</tr>
<tr>
<td><code>"upstream_addr": "$upstream_addr"</code></td>
<td>Adresse IP et port ou chemin vers le socket du domaine UNIX du serveur en amont. Si plusieurs serveurs sont contactés lors du traitement de la demande, leurs adresses sont séparées par des virgules : <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock"</code>. Si la demande est redirigée en interne d'un groupe de serveurs à un autre, les adresses de serveur des différents groupes sont séparées par des points-virgules : <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80"</code>. Si l'équilibreur de charge ALB ne parvient pas à sélectionner un serveur, le nom du groupe de serveurs est consigné à la place.</td>
</tr>
<tr>
<td><code>"upstream_status": $upstream_status</code></td>
<td>Code indiquant le statut de la réponse obtenue du serveur en amont pour l'application de back end, par exemple codes de réponse HTTP standard. Les codes de statut de plusieurs réponses sont séparés par des virgules ou des signes deux-points comme les adresses dans la variable <code>$upstream_addr</code>. Si l'ALB ne parvient pas à sélectionner un serveur, le code de statut 502 (Passerelle incorrecte) est consigné.</td>
</tr>
<tr>
<td><code>"request_time": $request_time</code></td>
<td>Temps de traitement de la demande, mesuré en secondes avec une résolution en millisecondes. Il démarre lorsque l'ALB lit les premiers octets de la demande du client et prend fin lorsque l'ALB envoie les derniers octets de la réponse au client. L'écriture dans le journal s'effectue immédiatement dès que le temps de traitement de la demande s'arrête.</td>
</tr>
<tr>
<td><code>"upstream_response_time": $upstream_response_time</code></td>
<td>Temps nécessaire à l'ALB pour recevoir la réponse du serveur en amont pour l'application de back end, mesuré en secondes avec une résolution en millisecondes. Les temps de plusieurs réponses sont séparés par des virgules ou des signes deux-points comme les adresses dans la variable <code>$upstream_addr</code>.</td>
</tr>
<tr>
<td><code>"upstream_connect_time": $upstream_connect_time</code></td>
<td>Temps nécessaire à l'ALB pour établir une connexion avec le serveur en amont pour l'application de back end, mesuré en secondes avec une résolution en millisecondes. Si TLS/SSL est activé dans la configuration de la ressource Ingress, ce temps comprend la durée d'établissement de la liaison. Les temps de plusieurs connexions sont séparés par des virgules ou des signes deux-points comme les adresses dans la variable <code>$upstream_addr</code>.</td>
</tr>
<tr>
<td><code>"upstream_header_time": $upstream_header_time</code></td>
<td>Temps nécessaire à l'ALB pour recevoir l'en-tête de réponse du serveur en amont pour l'application de back end, mesuré en secondes avec une résolution en millisecondes. Les temps de plusieurs connexions sont séparés par des virgules ou des signes deux-points comme les adresses dans la variable <code>$upstream_addr</code>.</td>
</tr>
</tbody></table>

## Personnalisation du contenu et du format des journaux Ingress
{: #ingress_log_format}

Vous pouvez personnaliser le contenu et le format des journaux collectés par l'équilibreur de charge d'application (ALB) Ingress.
{:shortdesc}

Par défaut, les journaux Ingress sont au format JSON et affichent des zones de journal courantes. Vous pouvez toutefois créer un format personnalisé pour les journaux. Pour choisir les composants de journal qui sont transférés et comment ces composants sont organisés dans la sortie du journal :

1. Créez et ouvrez une version locale du fichier de configuration pour la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ajoutez une section <code>data</code>. Ajoutez la zone `log-format` et éventuellement, la zone `log-format-escape-json`.

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    <table>
    <caption>Composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description de la configuration du format de journal (log-format)</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>Remplacez <code>&lt;key&gt;</code> par le nom du composant de journal et <code>&lt;log_variable&gt;</code> par une variable du composant de journal que vous voulez collecter dans les entrées de journal. Vous pouvez inclure le texte et la ponctuation que vous souhaitez dans l'entrée de journal, par exemple des guillemets autour des valeurs de chaîne et des virgules pour séparer les composants de journal. Par exemple, si vous formatez un composant ainsi : <code>request: "$request"</code>, l'entrée de journal suivante est générée : <code>request: "GET / HTTP/1.1"</code>. Pour obtenir la liste de toutes les variables que vous pouvez utiliser, voir le document <a href="http://nginx.org/en/docs/varindex.html">Nginx variable index</a>.<br><br>Pour consigner un en-tête supplémentaire, par exemple, <em>x-custom-ID</em>, ajoutez la paire clé-valeur suivante au contenu de journal personnalisé : <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>Les traits d'union (<code>-</code>) sont convertis en traits de soulignement (<code>_</code>) et <code>$http_</code> doit être ajouté en préfixe au nom d'en-tête personnalisé.</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>Facultatif : par défaut, les journaux sont générés en format texte. Pour générer les fichiers au format JSON, ajoutez la zone <code>log-format-escape-json</code> et utilisez la valeur <code>true</code>.</td>
    </tr>
    </tbody></table>

    Par exemple, votre format de journal peut contenir les variables suivantes :
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    Une entrée de journal correspondant à ce format ressemble à l'exemple suivant :
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    Pour créer un format de journal personnalisé en fonction du format par défaut de l'équilibreur de charge d'application (ALB), modifiez la section suivante selon les besoins et ajoutez-la dans configmap :
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. Sauvegardez le fichier de configuration.

5. Vérifiez que les modifications apportées à configmap ont été appliquées.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. Pour afficher les journaux de l'équilibreur de charge d'application (ALB) Ingress, vous avez le choix entre deux options :
    * [Créer une configuration de consignation pour le service Ingress](cs_health.html#logging) dans votre cluster.
    * Consulter les journaux à partir de l'interface de ligne de commande (CLI).
        1. Obtenez l'ID d'un pod pour un équilibreur de charge ALB.
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. Ouvrez les journaux correspondant à ce pod d'ALB. Vérifiez que les journaux sont conformes au nouveau format.
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## Augmentation de la taille de zone de mémoire partagée pour la collecte des données de mesure d'Ingress
{: #vts_zone_size}

Les zones de mémoire partagée sont définies pour que les processus de noeud worker puissent partager des informations de type cache, persistance de session et limites de débit. Une zone de mémoire partagée, désignée par zone d'état de trafic hôte virtuel (virtual host traffic status zone), est définie pour qu'Ingress collecte des données de mesure pour un équilibreur de charge d'application (ALB).
{:shortdesc}

Dans la ressource configmap `ibm-cloud-provider-ingress-cm` d'Ingress, la zone `vts-status-zone-size` définit la taille de la zone de mémoire partagée pour la collecte des données de mesure. Par défaut, la valeur de `vts-status-zone-size` est définie à `10m`. Si vous disposez d'un environnement plus important qui nécessite davantage de mémoire pour la collecte des données de mesure, vous pouvez remplacer la valeur par défaut par une valeur plus élevée en procédant comme suit :

1. Créez et ouvrez une version locale du fichier de configuration pour la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Modifiez la valeur de `vts-status-zone-size` en remplaçant `10m` par une valeur plus élevée.

   ```
   apiVersion: v1
   data:
     vts-status-zone-size: "10m"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Sauvegardez le fichier de configuration.

4. Vérifiez que les modifications apportées à configmap ont été appliquées.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}
