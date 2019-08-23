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



# Modification du comportement Ingress par défaut
{: #ingress-settings}

Une fois que vous avez exposé vos applications en créant une ressource Ingress, vous pouvez configurer les ALB Ingress dans votre cluster en définissant les options ci-après.
{: shortdesc}

## Ouverture de ports dans l'équilibreur de charge d'application (ALB) Ingress
{: #opening_ingress_ports}

Par défaut, seuls les ports 80 et 443 sont exposés dans l'équilibreur de charge ALB Ingress. Pour exposer d'autres ports, vous pouvez éditer la ressource configmap `ibm-cloud-provider-ingress-cm`.
{: shortdesc}

1. Editez le fichier de configuration correspondant à la ressource configmap `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ajoutez une section <code>data</code> et spécifiez les ports publics `80`, `443`, ainsi que tous les autres ports que vous voulez exposer, séparés par un point virgule (;).

    Par défaut, les ports 80 et 443 sont ouverts. Pour conserver les ports 80 et 443 ouverts, vous devez également les inclure en plus des autres ports que vous indiquez dans la zone `public-ports`. Tout port non spécifié est fermé. Si vous avez activé un équilibreur de charge ALB privé, vous devez également spécifier tous les ports que vous souhaitez garder ouverts dans la zone `private-ports`.
    {: important}

    ```
    apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    Exemple pour conserver les ports `80`, `443` et `9443` ouverts :
    ```
    apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: screen}

3. Sauvegardez le fichier de configuration.

4. Vérifiez que les modifications apportées à configmap ont été appliquées.
  ```
  kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
  ```
  {: pre}

5. Facultatif :
  * Accédez à une application via un port TCP non standard que vous avez ouvert en utilisant l'annotation [`tcp-ports`](/docs/containers?topic=containers-ingress_annotation#tcp-ports).
  * Remplacez les ports par défaut pour le trafic réseau HTTP (port 80) et HTTPS (port 443) par un port que vous avez ouvert en utilisant l'annotation [`custom-port`](/docs/containers?topic=containers-ingress_annotation#custom-port).

Pour plus d'informations sur les ressources configmap, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/). 

<br />


## Conservation de l'adresse IP source
{: #preserve_source_ip}

Par défaut, l'adresse IP source de la demande client n'est pas conservée. Lorsqu'une demande client vers votre application est envoyée à votre cluster, elle est acheminée à un pod pour le service d'équilibreur de charge qui expose l'équilibreur de charge d'application (ALB). S'il n'existe aucun pod d'application sur le même noeud worker que le pod de service d'équilibreur de charge, l'équilibreur de charge transmet la demande à un pod d'application sur un autre noeud worker. L'adresse IP source du package est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod d'application.
{: shortdesc}

Pour conserver l'adresse IP source d'origine de la demande du client, vous pouvez activer la [conservation de l'adresse IP source ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer). Conserver l'adresse IP du client est pratique, notamment lorsque les serveurs d'applications doivent appliquer des règles de sécurité et de contrôle d'accès.

Si vous [désactivez un ALB](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure), toutes les modifications d'adresse IP source que vous effectuez dans le service d'équilibreur de charge qui expose l'ALB sont perdues. Lorsque vous réactivez l'ALB, vous devez également réactiver l'adresse IP source.
{: note}

Pour activer la conservation de l'adresse IP source, éditez le service d'équilibreur de charge qui expose un ALB Ingress :

1. Activez la conservation de l'adresse IP source d'un ALB unique ou de tous les ALB figurant dans votre cluster.
    * Pour configurer la conservation de l'adresse IP source d'un seul ALB :
        1. Obtenez l'ID de l'ALB pour lequel vous voulez activer l'adresse IP source. Les services ALB ont un format de ce type : `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` pour un ALB public ou `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` pour un ALB privé.
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Ouvrez le fichier YAML correspondant au service d'équilibreur de charge qui expose l'ALB.
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. Sous **`spec`**, modifiez la valeur de **`externalTrafficPolicy`** en remplaçant `Cluster` par `Local`.

        4. Sauvegardez et fermez le fichier de configuration. La sortie est similaire à ceci :

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * Pour configurer la conservation de l'adresse IP source pour tous les ALB publics de votre cluster, exécutez la commande suivante :
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Exemple de sortie :
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * Pour configurer la conservation de l'adresse IP source pour tous les ALB privés de votre cluster, exécutez la commande suivante :
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Exemple de sortie :
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Vérifiez que l'adresse IP source est conservée dans les journaux de pod de votre ALB.
    1. Obtenez l'ID d'un pod pour l'ALB que vous avez modifié.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Ouvrez les journaux correspondant à ce pod d'ALB. Vérifiez que l'adresse IP de la zone `client` est l'adresse IP de la demande client au lieu de l'adresse IP du service d'équilibreur de charge.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. Désormais, quand vous recherchez les en-têtes des demandes qui sont envoyées à votre application de back end, vous pouvez voir l'adresse IP client dans l'en-tête `x-forwarded-for`. 

4. Pour cesser de conserver l'adresse IP source, vous pouvez annuler les modifications que vous avez apportées au service.
    * Pour annuler la conservation de l'adresse IP source pour vos ALB publics :
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * Pour annuler la conservation de l'adresse IP source pour vos ALB privés :
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## Configuration de protocoles et de chiffrements SSL au niveau HTTP
{: #ssl_protocols_ciphers}

Activez les protocoles et chiffrements SSL au niveau HTTP global en éditant la ressource configmap `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

Pour être en conformité avec le mandat PCI Security Standards Council, le service Ingress désactive TLS 1.0 et 1.1 par défaut avec la mise à jour de la version des pods d'ALB Ingress prévue le 23 janvier 2019. La mise à jour se déploie automatiquement sur tous les clusters {{site.data.keyword.containerlong_notm}} qui n'ont pas désactivé les mises à jour automatiques d'ALB. Si les clients qui se connectent à vos applications prennent en charge TLS 1.2, aucune action n'est requise. Si vous avez toujours des clients qui nécessitent la prise en charge de TLS 1.0 ou 1.1, vous devez activer manuellement les versions TLS requises. Vous pouvez remplacer la valeur par défaut pour utiliser les protocoles TLS 1.1 ou 1.0 en suivant les étapes indiquées dans cette section. Pour plus d'informations sur l'affichage des versions TLS utilisées par vos clients pour accéder à vos applications, voir cet [article du blogue {{site.data.keyword.cloud_notm}}](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).
{: important}

Lorsque vous indiquez les protocoles activés pour tous les hôtes, les paramètres TLSv1.1 et TLSv1.2 (1.1.13, 1.0.12) fonctionnent uniquement avec l'utilisation d'OpenSSL 1.0.1 ou version supérieure. Le paramètre TLSv1.3 (1.13.0) fonctionne uniquement avec l'utilisation d'OpenSSL 1.1.1 généré avec le support TLSv1.3.
{: note}

Pour éditer le fichier configmap pour activer les chiffrements et protocoles SSL :

1. Editez le fichier de configuration correspondant à la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ajoutez les chiffrements et protocoles SSL. Configurez les chiffrements en fonction du [format de liste de chiffrements de la bibliothèque OpenSSL ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
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

<br />


## Augmentation de la durée de vérification de la disponibilité lors du démarrage des pods d'ALB
{: #readiness-check}

Augmentez la durée pendant laquelle les pods d'ALB doivent analyser d'importants fichiers de ressources Ingress lorsqu'ils redémarrent.
{: shortdesc}

Lorsqu'un pod d'ALB redémarre, une vérification de disponibilité empêche le pod d'ALB de tenter d'acheminer les demandes de trafic tant que les fichiers de ressources Ingress n'ont pas tous été analysés. Cette vérification de disponibilité empêche toute perte de demande lorsque les pods d'ALB redémarrent. Par défaut, la vérification de disponibilité attend 15 secondes après le redémarrage du pod pour commencer à vérifier si tous les fichiers Ingress sont analysés. Si tous les fichiers sont analysés 15 secondes après le redémarrage du pod, le pod d'ALB recommence à router les demandes de trafic. Si les fichiers ne sont pas tous analysés 15 secondes après le redémarrage du pod, celui-ci ne route pas le trafic et la vérification de disponibilité se poursuit toutes les 15 secondes pendant 5 minutes au maximum. Au bout de 5 minutes, le pod d'ALB commence à router le trafic. 

Si vous possédez de très gros fichiers de ressources Ingress, l'analyse de tous les fichiers peut prendre plus de 5 minutes. Vous pouvez modifier les valeurs par défaut pour le taux d'intervalle de vérification de disponibilité et pour le délai d'attente de vérification de disponibilité maximal total en ajoutant les paramètres `ingress-resource-creation-rate` et `ingress-resource-timeout` à l'objet configmap `ibm-cloud-provider-ingress-cm`. 

1. Editez le fichier de configuration correspondant à la ressource configmap `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Dans la section **data**, ajoutez les paramètres `ingress-resource-creation-rate` et `ingress-resource-timeout`. Les valeurs peuvent être formatées sous forme de secondes (`s`) et de minutes (`m`). Exemple :
   ```
   apiVersion: v1
   data:
     ingress-resource-creation-rate: 1m
     ingress-resource-timeout: 6m
     keep-alive: 8s
     private-ports: 80;443
     public-ports: 80;443
   ```
   {: codeblock}

3. Sauvegardez le fichier de configuration.

4. Vérifiez que les modifications apportées à configmap ont été appliquées.
   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Optimisation des performances de l'équilibreur de charge d'application (ALB)
{: #perf_tuning}

Pour optimiser les performances de vos ALB Ingress, vous pouvez modifier les paramètres par défaut selon vos besoins.
{: shortdesc}

### Ajout de programmes d'écoute de socket ALB à chaque noeud worker
{: #reuse-port}

Augmentez le nombre de programmes d'écoute de socket ALB d'un par cluster à un par noeud worker en utilisant la directive Ingress `reuse-port`.
{: shortdesc}

Lorsque l'option `reuse-port` est désactivée, un seul socket en mode écoute informe les noeuds worker sur les connexions entrantes et tous les noeuds worker tentent de prendre la connexion. Mais lorsque l'option `reuse-port` est activée, un programme d'écoute de socket existe par noeud worker pour chaque combinaison d'adresse IP ALB et de port. Chaque noeud worker ne tente pas de prendre la connexion, mais à la place, le noyau Linux détermine le programme d'écoute de socket disponible qui obtient la connexion. Le conflit d'accès entre les noeuds worker est réduit, ce qui peut améliorer les performances. Pour plus d'informations sur les avantages et les inconvénients de la directive `reuse-port`, voir [cet article de blogue NGINX ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.nginx.com/blog/socket-sharding-nginx-release-1-9-1/). 

Vous pouvez mettre à l'échelle les programmes d'écoute en éditant l'objet configmap Ingress `ibm-cloud-provider-ingress-cm`. 

1. Editez le fichier de configuration correspondant à la ressource configmap `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Dans la section `metadata`, ajoutez `reuse-port: "true"`. Exemple :
   ```
   apiVersion: v1
   data:
     private-ports: 80;443;9443
     public-ports: 80;443
   kind: ConfigMap
   metadata:
     creationTimestamp: "2018-09-28T15:53:59Z"
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
     resourceVersion: "24648820"
     selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
     uid: b6ca0c36-c336-11e8-bf8c-bee252897df5
     reuse-port: "true"
   ```
   {: codeblock}

3. Sauvegardez le fichier de configuration.

4. Vérifiez que les modifications apportées à configmap ont été appliquées.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Activation de la mise en mémoire tampon des journaux et du délai d'attente du vidage
{: #access-log}

Par défaut, dès qu'une demande arrive, l'ALB Ingress la consigne dans un journal. Si vous disposez d'un environnement avec une utilisation intensive, la consignation de chaque demande dès son arrivée peut considérablement augmenter l'utilisation d'E-S disque. Pour éviter d'obtenir des E-S disque en continu, vous pouvez activer la mise en mémoire tampon des journaux et du délai d'attente de vidage pour l'ALB en modifiant la ressource configmap Ingress `ibm-cloud-provider-ingress-cm`. Lorsque la mise en mémoire tampon est activée, au lieu d'effectuer une opération d'écriture distincte pour chaque entrée de journal, l'ALB met en mémoire tampon une série d'entrées et les écrit ensemble dans un fichier en une seule opération.
{: shortdesc}

1. Créez et éditez le fichier de configuration correspondant à la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Editez la ressource configmap.
    1. Activez la mise en mémoire tampon des journaux en ajoutant la zone `access-log-buffering` et en la définissant avec la valeur `"true"`.

    2. Définissez le seuil à partir duquel l'ALB doit commencer à écrire le contenu de la mémoire tampon dans le journal.
        * Intervalle de temps : ajoutez la zone `flush-interval` et définissez la fréquence à laquelle l'ALB doit écrire dans le journal. Par exemple, si la valeur par défaut `5m` est utilisée, l'ALB écrit le contenu de la mémoire tampon dans le journal toutes les 5 minutes.
        * Taille de mémoire tampon : ajoutez la zone `buffer-size` et définissez-la avec la quantité de mémoire de journal que peut contenir la mémoire tampon avant que l'ALB écrive le contenu de la mémoire tampon dans le journal. Par exemple, si la valeur par défaut `100KB` est utilisée, l'ALB écrit le contenu de la mémoire tampon dans le journal chaque fois que la mémoire tampon atteint 100 ko de contenu de journal.
        * Intervalle de temps ou taille de mémoire tampon : lorsque les deux zones `flush-interval` et `buffer-size` sont définies, l'ALB écrit le contenu de la mémoire tampon dans le journal en fonction du premier paramètre de seuil atteint.

    ```
    apiVersion: v1
    kind: ConfigMap
    data:
      access-log-buffering: "true"
      flush-interval: "5m"
      buffer-size: "100KB"
    metadata:
      name: ibm-cloud-provider-ingress-cm
      ...
    ```
   {: codeblock}

3. Sauvegardez le fichier de configuration.

4. Vérifiez que votre ALB est configuré avec les modifications du journal des accès.

   ```
   kubectl logs -n kube-system <ALB_ID> -c nginx-ingress
   ```
   {: pre}

### Modification du nombre ou de la durée des connexions persistantes (keepalive)
{: #keepalive_time}

Les connexions persistantes (keepalive) peuvent avoir un impact majeur sur les performances en diminuant l'utilisation de l'UC et du réseau nécessaire pour ouvrir et fermer les connexions. Pour optimiser les performances de vos ALB, vous pouvez modifier le nombre maximal de connexions persistantes pour les connexions entre l'ALB et le client et la durée possible de ces connexions.
{: shortdesc}

1. Editez le fichier de configuration correspondant à la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Modifiez les valeurs des zones `keep-alive-requests` et `keep-alive`.
    * `keep-alive-requests` : nombre de connexions client persistantes pouvant rester ouvertes dans l'ALB Ingress. La valeur par défaut est `4096`.
    * `keep-alive` : délai exprimé en secondes, pendant lequel la connexion client persistante reste ouverte dans l'ALB Ingress. La valeur par défaut est `8s`.
   ```
   apiVersion: v1
   data:
     keep-alive-requests: "4096"
     keep-alive: "8s"
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

### Modification du journal des éléments en attente pour les connexions en attente
{: #backlog}

Vous pouvez diminuer le paramètre du journal des éléments en attente (backlog) correspondant au nombre de connexions en attente pouvant figurer dans la file d'attente du serveur.
{: shortdesc}

Dans la ressource configmap Ingress `ibm-cloud-provider-ingress-cm`,  la zone `backlog` définit le nombre maximal de connexions en attente pouvant attendre dans la file d'attente du serveur. Par défaut la valeur de `backlog` est fixée à `32768`. Vous pouvez remplacer cette valeur par défaut en modifiant la ressource configmap d'Ingress.

1. Editez le fichier de configuration correspondant à la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Modifiez la valeur de `backlog` en remplaçant `32768` par une valeur plus faible. La valeur doit être inférieure ou égale à 32768.

   ```
   apiVersion: v1
   data:
     backlog: "32768"
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

### Optimisation des performances du noyau
{: #ingress_kernel}

Pour optimiser les performances de vos ALB Ingress, vous pouvez également [modifier les paramètres  `sysctl` du noyau Linux sur les noeuds worker](/docs/containers?topic=containers-kernel). Les noeuds worker sont automatiquement mis à disposition avec un noyau déjà optimisé, par conséquent ne modifiez ces paramètres que si vous nécessitez l'optimisation de performances spécifiques.
{: shortdesc}

<br />

