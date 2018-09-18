---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

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
