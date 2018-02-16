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


# Annotations Ingress
{: #ingress_annotation}

Pour ajouter des fonctionnalités à votre équilibreur de charge d'application, vous pouvez spécifier des annotations sous forme de métadonnées dans une ressource Ingress.
{: shortdesc}

Pour des informations générales sur les services Ingress et comment les utiliser, voir [Configuration de l'accès public à une application à l'aide d'Ingress](cs_ingress.html#config).

<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th colspan=3>Annotations générales</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-external-service">Services externes</a></td>
 <td><code>proxy-external-service</code></td>
 <td>Permet d'ajouter des définitions de chemin à des services externes, tels qu'un service hébergé dans {{site.data.keyword.Bluemix_notm}}.</td>
 </tr>
 <tr>
 <td><a href="#alb-id">Routage d'équilibreur de charge d'application privé</a></td>
 <td><code>ALB-ID</code></td>
 <td>Routez les demandes entrantes à vos applications  avec un équilibreur de charge d'application privé.</td>
 </tr>
 <tr>
 <td><a href="#rewrite-path">Chemins de redirection</a></td>
 <td><code>rewrite-path</code></td>
 <td>Acheminer le trafic réseau entrant vers un autre chemin sur lequel votre application de back end est en mode écoute.</td>
 </tr>
 <tr>
 <td><a href="#sticky-cookie-services">Affinité de session avec des cookies</a></td>
 <td><code>sticky-cookie-services</code></td>
 <td>Acheminer systématiquement le trafic réseau entrant vers le même serveur en amont à l'aide d'un cookie compliqué.</td>
 </tr>
 <tr>
 <td><a href="#tcp-ports">Ports TCP</a></td>
 <td><code>tcp-ports</code></td>
 <td>Accéder à une application via un port TCP non standard.</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
  <th colspan=3>Annotations de connexion</th>
  </thead>
  <tbody>
  <tr>
  <td><a href="#proxy-connect-timeout">Personnalisation des paramètres connect-timeouts et read-timeouts</a></td>
  <td><code>proxy-connect-timeout</code></td>
  <td>Permet d'ajuster le délai d'attente observé par l'équilibreur de charge d'application pour établir une connexion et effectuer une lecture depuis l'application de back-end avant que celle-ci ne soit considérée comme indisponible.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-requests">Demandes de signal de présence</a></td>
  <td><code>keepalive-requests</code></td>
  <td>Configurer le nombre maximum de demandes pouvant être traitées via une connexion de signal de présence.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-timeout">Délai d'expiration de signal de présence</a></td>
  <td><code>keepalive-timeout</code></td>
  <td>Configurer la durée d'ouverture d'une connexion de signal de présence sur le serveur.</td>
  </tr>
  <tr>
  <td><a href="#upstream-keepalive">Signal de présence en amont</a></td>
  <td><code>upstream-keepalive</code></td>
  <td>Configurer le nombre maximum de connexions de signal de présence inactives pour un serveur en amont.</td>
  </tr>
  </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th colspan=3>Annotations de tampons de proxy</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-buffering">Mise en mémoire tampon des données de réponse client</a></td>
 <td><code>proxy-buffering</code></td>
 <td>Désactiver la mise en mémoire tampon d'une réponse client sur l'équilibreur de charge d'application lors de l'envoi de la réponse au client.</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffers">Tampons de proxy</a></td>
 <td><code>proxy-buffers</code></td>
 <td>Permet de définir le nombre et la taille des tampons qui lisent une réponse pour une connexion unique provenant du serveur relayé via un proxy.</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffer-size">Taille de tampon de proxy</a></td>
 <td><code>proxy-buffer-size</code></td>
 <td>Permet de définir la taille du tampon qui lit la première partie de la réponse reçue du serveur relayé via un proxy.</td>
 </tr>
 <tr>
 <td><a href="#proxy-busy-buffers-size">Taille des tampons occupés de proxy</a></td>
 <td><code>proxy-busy-buffers-size</code></td>
 <td>Définit la taille des tampons de proxy pouvant être occupés.</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Annotations de demande et de réponse</th>
</thead>
<tbody>
<tr>
<td><a href="#proxy-add-headers">En-tête de réponse ou de demande client supplémentaire</a></td>
<td><code>proxy-add-headers</code></td>
<td>Ajouter des informations d'en-tête à une demande client avant d'acheminer la demande vers votre application de back end ou à une réponse client avant d'envoyer la réponse au client.</td>
</tr>
<tr>
<td><a href="#response-remove-headers">Retrait d'en-tête de réponse client</a></td>
<td><code>response-remove-headers</code></td>
<td>Retirer les informations d'en-tête d'une réponse client avant d'acheminer la réponse vers le client.</td>
</tr>
<tr>
<td><a href="#client-max-body-size">Personnaliser la taille du corps de demande client maximale</a></td>
<td><code>client-max-body-size</code></td>
<td>Ajustez la taille du corps de la demande du client pouvant être envoyée à l'équilibreur de charge d'application.</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Annotations de limite de service</th>
</thead>
<tbody>
<tr>
<td><a href="#global-rate-limit">Limites de débit globales</a></td>
<td><code>global-rate-limit</code></td>
<td>Limite le débit de traitement des demandes et le nombre de connexions compte tenu d'une clé définie pour tous les services.</td>
</tr>
<tr>
<td><a href="#service-rate-limit">Limites de débit de service</a></td>
<td><code>service-rate-limit</code></td>
<td>Limite le débit de traitement des demandes et le nombre de connexions compte tenu d'une clé définie pour des services spécifiques.</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Annotations d'authentification HTTPS et TLS/SSL</th>
</thead>
<tbody>
<tr>
<td><a href="#custom-port">Ports HTTP et HTTPS personnalisés</a></td>
<td><code>custom-port</code></td>
<td>Modifiez les ports par défaut pour le trafic réseau HTTP (port 80) et HTTPS (port 443).</td>
</tr>
<tr>
<td><a href="#redirect-to-https">Redirection HTTP vers HTTPS</a></td>
<td><code>redirect-to-https</code></td>
<td>Rediriger les demandes HTTP non sécurisées sur votre domaine vers HTTPS.</td>
</tr>
<tr>
<td><a href="#mutual-auth">Authentification mutuelle</a></td>
<td><code>mutual-auth</code></td>
<td>Configurez une authentification mutuelle pour l'équilibreur de charge d'application.</td>
</tr>
<tr>
<td><a href="#ssl-services">Support des services SSL</a></td>
<td><code>ssl-services</code></td>
<td>Autorise la prise en charge des services SSL pour l'équilibrage de charge.</td>
</tr>
</tbody></table>



## Annotations générales
{: #general}

### Services externes (proxy-external-service)
{: #proxy-external-service}

Ajoutez des définitions de chemin d'accès à des services externes, tels des services hébergés dans {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Ajouter des définitions de chemin d'accès à des services externes. N'utilisez cette annotation que si votre application opère sur un service externe au lieu d'un service de back-end. Lorsque vous utilisez cette annotation pour créer une route de service externe, seules les annotations `client-max-body-size`, `proxy-read-timeout`, `proxy-connect-timeout` et `proxy-buffering` sont prises en charge en conjonction. Aucune autre annotation n'est prise en charge en conjonction avec `proxy-external-service`.
</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: cafe-ingress
  annotations:
    ingress.bluemix.net/proxy-external-service: "path=&lt;mypath&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 80
</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>path</code></td>
 <td>Remplacez <code>&lt;<em>mypath</em>&gt;</code> par le chemin sur lequel le service externe est à l'écoute.</td>
 </tr>
 <tr>
 <td><code>external-svc</code></td>
 <td>Remplacez <code>&lt;<em>external_service</em>&gt;</code> par le service externe à appeler. Par exemple, <code>https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net</code>.</td>
 </tr>
 <tr>
 <td><code>host</code></td>
 <td>Remplacez <code>&lt;<em>mydomain</em>&gt;</code> par le domaine hôte du service externe.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Routage  d'équilibreur de charge d'application privé (ALB-ID)
{: #alb-id}

Routez les demandes entrantes vers vos applications à l'aide d'un équilibreur de charge d'application privé.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Choisissez un équilibreur de charge d'application privé pour acheminer les demandes entrantes au lieu d'utiliser l'équilibreur de charge d'application public.</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: myingress
annotations:
  ingress.bluemix.net/ALB-ID: "&lt;private_ALB_ID&gt;"
spec:
tls:
- hosts:
  - mydomain
    secretName: mytlssecret
  rules:
- host: mydomain
  http:
    paths:
    - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
</thead>
<tbody>
<tr>
<td><code>&lt;private_ALB_ID&gt;</code></td>
<td>ID de votre équilibreur de charge d'application privé. Lancez la commande <code>bx cs albs --cluster <my_cluster></code> pour identifier l'ID de l'équilibreur de charge d'application privé.
</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />



### Chemins de redirection (rewrite-path)
{: #rewrite-path}

Acheminez le trafic réseau entrant sur un chemin de domaine d'équilibreur de charge d'application différent de celui où votre application de back end est à l'écoute.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Votre domaine d'équilibreur de charge d'application Ingress achemine le trafic réseau sur <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> à votre application. Votre application est en mode écoute sur <code>/coffee</code> au lieu de <code>/beans</code>. Pour acheminer le trafic réseau entrant vers votre application, ajoutez l'annotation rewrite au fichier de configuration de votre ressource Ingress. L'annotation rewrite garantit que le trafic réseau entrant sur <code>/beans</code> est réacheminé vers votre application en utilisant le chemin <code>/coffee</code>. Lorsque vous incluez plusieurs services, utilisez uniquement un point-virgule (;) pour les séparer.</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;myservice1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;myservice2&gt; rewrite=&lt;target_path2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /beans
        backend:
          serviceName: myservice1
          servicePort: 80
</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service Kubernetes que vous avez créé pour votre application.</td>
</tr>
<tr>
<td><code>rewrite</code></td>
<td>Remplacez <code>&lt;<em>target_path</em>&gt;</code> par le chemin sur lequel votre application est à l'écoute. Le trafic réseau entrant sur le domaine d'équilibreur de charge d'application est acheminé au service Kubernetes en utilisant ce chemin. La plupart des applications ne sont pas à l'écoute sur un chemin spécifique, mais utilisent le chemin racine et un port spécifique. Dans l'exemple ci-dessus, le chemin de redirection a été défini en tant que <code>/coffee</code>.</td>
</tr>
</tbody></table>

</dd></dl>

<br />


### Affinité de session avec des cookies (sticky-cookie-services)
{: #sticky-cookie-services}

Utilisez l'annotation sticky cookie pour ajouter une affinité de session à votre équilibreur de charge d'application et toujours acheminer le trafic réseau entrant au même serveur en amont.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Pour la haute disponibilité, certaines configurations d'application nécessitent de déployer plusieurs serveurs en amont qui prennent en charge les demandes client entrantes. Lorsqu'un client se connecte à votre application de back end, vous pouvez utiliser l'affinité de session pour qu'un client soit servi par le même serveur en amont pendant toute la durée d'une session ou pendant la durée d'exécution d'une tâche. Vous pouvez configurer votre équilibreur de charge d'application pour assurer une affinité de session en acheminant toujours le trafic réseau entrant au même serveur en amont.

</br></br>
Chaque client qui se connecte à votre application de back end est affecté par l'équilibreur de charge d'application à l'un des serveurs n amont disponibles. L'équilibreur de charge d'application crée un cookie de session stocké dans l'application du client et inclus dans les informations d'en-tête de chaque demande entre l'équilibreur de charge d'application et le client. Les informations contenues dans le cookie garantissent la prise en charge de toutes les demandes par le même serveur en amont pendant toute la session.

</br></br>
Lorsque vous incluez plusieurs services, utilisez un point-virgule (;) pour les séparer.</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;myservice1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;myservice2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>Description des composants du fichier YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service Kubernetes que vous avez créé pour votre application.</td>
  </tr>
  <tr>
  <td><code>name</code></td>
  <td>Remplacez <code>&lt;<em>cookie_name</em>&gt;</code> par le nom d'un cooky sticky créé lors d'une session.</td>
  </tr>
  <tr>
  <td><code>expires</code></td>
  <td>Remplacez <code>&lt;<em>expiration_time</em>&gt;</code> par le délai en secondes (s), minutes (m), ou heures (h) avant expiration du cookie sticky. Ce délai est indépendant de l'activité d'utilisateur. Une fois le cookie arrivé à expiration, il est supprimé par le navigateur Web du client et n'est plus envoyé à l'équilibreur de charge d'application. Par exemple, pour définir un délai d'expiration d'1 seconde, d'1 minute ou d'1 heure, entrez <code>1s</code>, <code>1m</code> ou <code>1h</code>.</td>
  </tr>
  <tr>
  <td><code>path</code></td>
  <td>Remplacez <code>&lt;<em>cookie_path</em>&gt;</code> par le chemin ajouté au sous-domaine Ingress et qui indique pour quels domaines et sous-domaines le cookie est envoyé à l'équilibreur de charge d'application. Par exemple, si votre domaine Ingress est <code>www.myingress.com</code> et que vous souhaitez envoyer le cookie dans chaque demande client, vous devez définir <code>path=/</code>. Si vous souhaitez envoyer le cookie uniquement pour <code>www.myingress.com/myapp</code> et tous ses sous-domaines, vous devez définir <code>path=/myapp</code>.</td>
  </tr>
  <tr>
  <td><code>hash</code></td>
  <td>Remplacez <code>&lt;<em>hash_algorithm</em>&gt;</code> par l'algorithme de hachage qui protège les informations dans le cookie. Seul le type <code>sha1</code> est pris en charge. SHA1 crée une somme hachée basée sur les informations contenues dans le cookie et l'ajoute au cookie. Le serveur peut déchiffrer les informations contenues dans le cookie et vérifier l'intégrité des données.</td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />



### Ports TCP pour les équilibreurs de charge d'application (tcp-ports)
{: #tcp-ports}

Accédez à une application via un port TCP non standard.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Utiliser cette annotation pour une application qui s'exécute sur une charge de travail de flux TCP.

<p>**Remarque **: l'équilibreur de charge d'application opère en mode "pass-through" et achemine le trafic aux applications de back end. La terminaison SSL n'est pas prise en charge dans ce cas.</p>
</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: myingress
annotations:
  ingress.bluemix.net/tcp-ports: "serviceName=&lt;myservice&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service Kubernetes pour accès au port TCP non standard.</td>
  </tr>
  <tr>
  <td><code>ingressPort</code></td>
  <td>Remplacez <code>&lt;<em>ingress_port</em>&gt;</code> par le port TCP sur lequel accéder à votre application.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>Remplacez <code>&lt;<em>service_port</em>&gt;</code> par ce paramètre (facultatif). Lorsqu'il est fourni, le port est remplacé par cette valeur avant l'envoi du trafic à l'application de back end. Sinon, le port est identique au port Ingress.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Annotations de connexion
{: #connection}

### Personnalisation des paramètres connect-timeout et read-timeout (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Définissez un paramètre connect-timeout et un paramètre read-timeout personnalisés pour l'équilibreur de charge d'application. Permet d'ajuster le délai pendant lequel l'équilibreur de charge d'application patiente pour se connecter et effectuer une lecture depuis l'application de back-end avant de déterminer que celle-ci est indisponible.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Lorsqu'une demande client est envoyée à l'équilibreur de charge d'application Ingress, une connexion à l'application de back end est ouverte par l'équilibreur de charge d'application. Par défaut, l'équilibreur de charge d'application patiente pendant 60 secondes pour la réception d'une réponse de l'application de back end. Si l'application de back end ne répond pas au cours de ce délai de 60 secondes, la demande de connexion est abandonnée et l'application de back end est considérée comme indisponible.

</br></br>
Une fois que l'équilibreur de charge d'application est connecté à l'application de back end, les données de réponse sont lues depuis cette application par l'équilibreur de charge d'application. Au cours de cette opération de lecture, l'équilibreur de charge d'application patiente jusqu'à 60 secondes entre deux opérations de lecture pour recevoir des données de l'application de back end. Si l'application de back end n'envoie pas les données au cours de ce délai de 60 secondes, la connexion avec l'application de back end est fermée et cette dernière est considérée comme indisponible.
</br></br>
Sur un proxy, les paramètres connect-timeout et read-timeout sont définis par défaut sur 60 secondes et ne doivent généralement pas être modifiés.
</br></br>
En cas d'instabilité de la disponibilité de votre application ou si celle-ci est lente à répondre en raison de charges de travail élevées, vous souhaiterez peut-être augmenter la valeur du paramètre connect-timeout ou read-timeout. Rappelez-vous que l'augmentation du délai d'attente a une incidence sur les performances de l'équilibreur de charge d'application puisque la connexion à l'application de back end doit rester ouverte jusqu'à expiration de ce délai.
</br></br>
D'une autre côté, vous pouvez réduire le délai d'attente afin d'améliorer les performances de l'équilibreur de charge d'application. Assurez-vous que votre application de back end est capable de traiter les demandes dans le délai d'attente imparti, même lorsque les charges de travail sont plus importantes.</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
   ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;connect_timeout&gt;</code></td>
 <td>Délai d'attente, en secondes, pour connexion à l'application de back-end. Par exemple, <code>65s</code>. <strong>Remarque :</strong> La valeur d'un paramètre connect-timeout ne doit pas excéder 75 secondes.</td>
 </tr>
 <tr>
 <td><code>&lt;read_timeout&gt;</code></td>
 <td>Délai d'attente pour lecture depuis l'application de back-end. Par exemple, <code>65s</code>.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Demandes de signal de présence (keepalive-requests)
{: #keepalive-requests}

Configurez le nombre maximum de demandes pouvant être traitées via une connexion de signal de présence.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Définir le nombre maximum de demandes pouvant être traitées via une connexion de signal de présence.
</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: myingress
annotations:
  ingress.bluemix.net/keepalive-requests: "serviceName=&lt;myservice&gt; requests=&lt;max_requests&gt;"
spec:
tls:
- hosts:
  - mydomain
    secretName: mytlssecret
  rules:
- host: mydomain
  http:
    paths:
    - path: /
      backend:
        serviceName: &lt;myservice&gt;
        servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service Kubernetes que vous avez créé pour votre application.Ce paramètre est facultatif. Si aucun service n'est spécifié, la configuration est appliquée à tous les services de l'hôte Ingress. Si le paramètre est fourni, les demandes de signal de présence sont définies pour le service indiqué. Si le paramètre n'est pas fourni, les demandes de signal de présence sont définies au niveau serveur de <code>nginx.conf</code> pour tous les services pour lesquels aucune demande de signal de présence n'est configurée.</td>
</tr>
<tr>
<td><code>requests</code></td>
<td>Remplacez <code>&lt;<em>max_requests</em>&gt;</code> par le nombre maximal de demandes pouvant être traitées dans le cadre d'une connexion avec signal de présence (keepalive).</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### Délai d'expiration de signal de présence (keepalive-timeout)
{: #keepalive-timeout}

Configurez la durée d'ouverture d'une connexion de signal de présence côté serveur.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Définit la durée d'ouverture d'une connexion de signal de présence côté serveur.
</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;myservice&gt; timeout=&lt;time&gt;s"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service Kubernetes que vous avez créé pour votre application.Ce paramètre est facultatif. Si le paramètre est fourni, le délai d'expiration de signal de présence est défini pour le service indiqué. Si le paramètre n'est pas fourni, le délai d'expiration de signal de présence est défini au niveau serveur de <code>nginx.conf</code> pour tous les services pour lesquels aucun délai d'expiration de signal de présence n'est configuré.</td>
 </tr>
 <tr>
 <td><code>timeout</code></td>
 <td>Remplacez <code>&lt;<em>time</em>&gt;</code> par la durée, en secondes. Exemple :<code>timeout=20s</code>. Une valeur zéro désactive les connexions client de signal de présence.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Signal de présence en amont (upstream-keepalive)
{: #upstream-keepalive}

Configurez le nombre maximum de connexions de signal de présence inactives pour un serveur en amont.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Modifier le nombre maximum de connexions de signal de présence inactives à un serveur en amont d'un service donné. Le serveur en amont accepte, par défaut, de 64 connexions de signal de présence inactives.
</dd>


 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;myservice&gt; keepalive=&lt;max_connections&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service Kubernetes que vous avez créé pour votre application.</td>
  </tr>
  <tr>
  <td><code>keepalive</code></td>
  <td>Remplacez <code>&lt;<em>max_connections</em>&gt;</code> par le nombre maximal de connexions inactives avec signal de présence au serveur en amont. Valeur par défaut : <code>64</code>. La valeur <code>0</code> désactive les connexions avec signal de présence en amont pour le service spécifié.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Annotations de tampons de proxy
{: #proxy-buffer}


### Mise en mémoire tampon des données de réponse client (proxy-buffering)
{: #proxy-buffering}

Utilisez l'annotation de buffer pour désactiver le stockage de données de réponse sur l'équilibreur de charge d'application tandis que les données sont envoyées au client.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>L'équilibreur de charge d'application Ingress fait office de proxy entre votre application de back end et le navigateur Web du client. Lorsqu'une réponse est envoyée de l'application de back end au client, les données de réponse sont placées par défaut en mémoire tampon sur l'équilibreur de charge d'application. L'équilibreur de charge d'application met en proxy la réponse client et commence à envoyer la réponse au client à la cadence du client. Une fois que toutes les données du back end ont été reçues par l'équilibreur de charge d'application, la connexion à l'application de back end est clôturée. La connexion de l'équilibreur de charge au client reste ouverte jusqu'à ce que le client ait reçu toutes les données.

</br></br>
Si la mise en mémoire tampon des données de réponse sur l'équilibreur de charge d'application est désactivée, les données sont envoyées immédiatement de l'équilibreur de charge d'application au client. Le client doit être capable de traiter les données entrantes au rythme de l'équilibreur de charge d'application. Si le client est trop lent, les données risquent d'être perdues.
</br></br>
La mise en mémoire tampon des données de réponse sur l'équilibreur de charge d'application est activée par défaut.</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/proxy-buffering: "False"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

<br />



### Tampons de proxy (proxy-buffers)
{: #proxy-buffers}

Permet de configurer le nombre et la taille des tampons de proxy pour l'équilibreur de charge d'application.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Permet de définir le nombre et la taille des tampons qui lisent une réponse pour une connexion unique provenant du serveur relayé via un proxy. Si aucun service n'est spécifié, la configuration est appliquée à tous les services de l'hôte Ingress. Par exemple, si une configuration telle que <code>serviceName=SERVICE number=2 size=1k</code> est spécifiée, 1k est appliqué au service. Si une configuration telle que <code>number=2 size=1k</code> est spécifiée, 1k est appliqué à tous les services de l'hôte Ingress.
</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-buffers: "serviceName=&lt;myservice&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service auquel appliquer proxy-buffers.</td>
 </tr>
 <tr>
 <td><code>number_of_buffers</code></td>
 <td>Remplacez <code>&lt;<em>number_of_buffers</em>&gt;</code> par un nombre. Par exemple, <em>2</em>.</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>Remplacez <code>&lt;<em>size</em>&gt;</code> par la taille de chaque tampon, en kilooctets (k ou K). Par exemple, <em>1K</em>.</td>
 </tr>
 </tbody>
 </table>
 </dd></dl>

<br />


### Taille de tampon de proxy (proxy-buffer-size)
{: #proxy-buffer-size}

Permet de définir la taille du tampon de proxy qui lit la première partie de la réponse.{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Permet de définir la taille du tampon qui lit la première partie de la réponse reçue du serveur relayé via un proxy. Cette partie de la réponse contient généralement un petit en-tête de réponse. Si aucun service n'est spécifié, la configuration est appliquée à tous les services de l'hôte Ingress. Par exemple, si une configuration telle que <code>serviceName=SERVICE size=1k</code> est spécifiée, 1k est appliqué au service. Si une configuration telle que <code>size=1k</code> est spécifiée, 1k est appliqué à tous les services de l'hôte Ingress.
</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;myservice&gt; size=&lt;size&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080
 </code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service auquel appliquer proxy-buffers-size.</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>Remplacez <code>&lt;<em>size</em>&gt;</code> par la taille de chaque tampon, en kilooctets (k ou K). Par exemple, <em>1K</em>.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Taille des tampons occupés de proxy (proxy-busy-buffers-size)
{: #proxy-busy-buffers-size}

Permet de configurer la taille des tampons de proxy pouvant être occupés.{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Limite la taille des tampons pouvant envoyer une réponse au client alors que la réponse n'a pas été encore complètement lue. Dans l'intervalle, le reste des tampons peut lire la réponse et, au besoin, placer en mémoire tampon une partie de la réponse dans un fichier temporaire. Si aucun service n'est spécifié, la configuration est appliquée à tous les services de l'hôte Ingress. Par exemple, si une configuration telle que <code>serviceName=SERVICE size=1k</code> est spécifiée, 1k est appliqué au service. Si une configuration telle que <code>size=1k</code> est spécifiée, 1k est appliqué à tous les services de l'hôte Ingress.
</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-busy-buffers-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service auquel appliquer proxy-busy-buffers-size.</td>
</tr>
<tr>
<td><code>size</code></td>
<td>Remplacez <code>&lt;<em>size</em>&gt;</code> par la taille de chaque tampon, en kilooctets (k ou K). Par exemple, <em>1K</em>.</td>
</tr>
</tbody></table>

 </dd>
 </dl>

<br />



## Annotations de demande et de réponse
{: #request-response}


### En-tête de réponse ou de demande client supplémentaire (proxy-add-headers)
{: #proxy-add-headers}

Ajoutez des informations d'en-tête à une demande client avant d'envoyer la demande vers l'application de back end ou à une réponse client avant d'envoyer la réponse au client.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>L'équilibreur de charge d'application Ingress fait office de proxy entre l'application client et l'application de back end . Les demandes client envoyées à l'équilibreur de charge d'application sont traitées (relayées via un proxy) et placées dans une nouvelles demande envoyée ensuite depuis l'équilibreur de charge d'application à votre application de back-end. Lorsqu'une demande passe par un  proxy, les informations d'en-tête HTTP intialement envoyées par le client, par exemple, le nom d'utilisateur, sont retirées. Si votre application de back end a besoin de cette information, vous pouvez utiliser l'annotation <strong>ingress.bluemix.net/proxy-add-headers</strong> pour ajouter les informations d'en-tête à la demande client avant qu'elle ne soit envoyée de l'équilibreur de charge d'application à votre application de back end.

</br></br>
Lorsqu'une application de back end envoie une réponse au client, celle-ci est relayée via proxy par l'équilibreur de charge d'application et les en-têtes HTTP sont supprimés de la réponse. L'application Web client peut avoir besoin de ces informations d'en-tête pour traiter correctement la réponse. Vous pouvez utiliser l'annotation <strong>ingress.bluemix.net/response-add-headers</strong> pour ajouter des informations d'en-tête à la réponse client avant que celle-ci ne soit envoyée de l'équilibreur de charge d'application à l'application Web client.</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;myservice1&gt; {
      &lt;header1&gt; &lt;value1&gt;;
      &lt;header2&gt; &lt;value2&gt;;
      }
      serviceName=&lt;myservice2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;myservice1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;myservice2&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>service_name</code></td>
  <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service Kubernetes que vous avez créé pour votre application.</td>
  </tr>
  <tr>
  <td><code>&lt;header&gt;</code></td>
  <td>Clé des informations d'en-tête à ajouter à la demande ou à la réponse du client.</td>
  </tr>
  <tr>
  <td><code>&lt;value&gt;</code></td>
  <td>Valeur des informations d'en-tête à ajouter à la demande ou à la réponse du client.</td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />



### Retrait d'en-tête de réponse client (response-remove-headers)
{: #response-remove-headers}

Retirez de l'application de back end les informations d'en-tête incluses dans la réponse client, avant que celle-ci ne soit envoyée au client.
 {:shortdesc}

 <dl>
 <dt>Description</dt>
 <dd>L'équilibreur de charge d'application Ingress fait office de proxy entre votre application de back end et le navigateur Web du client. Les réponses client de l'application de back end qui sont envoyées à l'équilibreur de charge d'application (relayées via proxy) et placées dans une nouvelle réponse qui est alors envoyée de l'équilibreur de charge d'application au navigateur Web du client. Même si le fait de relayer une réponse via un proxy permet de retirer les informations d'en-tête HTTP initialement envoyées à partir de l'application de back end, il se peut que les en-têtes propres à l'application de back end ne soient pas tous retirés par ce processus. Supprimez les informations d'en-tête d'une réponse client avant que celle-ci ne soit envoyée de l'équilibreur de charge d'application au navigateur Web du client.</dd>
 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/response-remove-headers: |
       serviceName=&lt;myservice1&gt; {
       "&lt;header1&gt;";
       "&lt;header2&gt;";
       }
      serviceName=&lt;myservice2&gt; {
       "&lt;header3&gt;";
       }
 spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8080
       - path: /myapp
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>service_name</code></td>
   <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service Kubernetes que vous avez créé pour votre application.</td>
   </tr>
   <tr>
   <td><code>&lt;header&gt;</code></td>
   <td>Clé de l'en-tête à retirer de la réponse du client.</td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


### Personnaliser la taille maximale du corps de demande client (client-max-body-size)
{: #client-max-body-size}

Ajustez la taille maximale du corps que le client peut envoyer dans le cadre d'une demande.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Dans le but de maintenir les performances attendues, la valeur définie pour la taille maximale du corps de la demande client est 1 mégaoctet. Lorsqu'une demande client dont la taille du corps dépasse la limite est envoyée à l'équilibreur de charge d'application Ingress et que le client n'autorise pas la scission des données, l'équilibreur de charge d'application renvoie une réponse HTTP 413 (Entité de demande trop volumineuse) au client. Une connexion entre le client et l'équilibreur de charge d'application n'est pas possible tant que le corps de la demande n'a pas été réduit. Lorsque le client autorise le fractionnement des données en plusieurs blocs, les données sont divisées en packages de 1 mégaoctet et envoyées à l'équilibreur de charge d'application.

</br></br>
Vous souhaiterez peut-être augmenter la taille maximale du corps car vous attendez des demandes client avec une taille de corps supérieure à 1 mégaoctet. Par exemple, vous voulez que votre client puisse télécharger des fichiers volumineux. L'augmentation de la taille de corps de demande maximale peut avoir une incidence sur les performances de votre équilibreur de charge d'application puisque la connexion au client doit rester ouverte jusqu'à ce que la réponse ait été reçue.
</br></br>
<strong>Remarque :</strong> certains navigateurs Web client ne peuvent pas afficher correctement le message de réponse HTTP 413.</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/client-max-body-size: "size=&lt;size&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;size&gt;</code></td>
 <td>Taille maximale du corps de réponse client. Par exemple, pour définir une taille de 200 mégaoctets, indiquez <code>200m</code>.  <strong>Remarque :</strong> vous pouvez définir la taille 0 pour désactiver la vérification de la taille du corps de demande client.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



## Annotations de limite de service
{: #service-limit}


### Limites de débit globales (global-rate-limit)
{: #global-rate-limit}

Limite le débit de traitement des demandes et le nombre de connexions compte tenu d'une clé définie pour tous les services.{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Pour tous les services, permet de limiter d'après une clé définie le débit de traitement des demandes et le nombre de connexions émanant d'une même adresse IP pour tous les chemins de back end sélectionnés.
</dd>


 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/global-rate-limit: "key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>key</code></td>
  <td>Pour définir une limite globale pour les demandes entrantes en fonction de l'emplacement ou du service, utilisez `key=location`. Pour définir une limite globale pour les demandes entrantes en fonction de l'en-tête, utilisez `X-USER-ID key==$http_x_user_id`.</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>Remplacez <code>&lt;<em>rate</em>&gt;</code> par le débit de traitement. Entrez une valeur correspondant à un débit par seconde (r/s) ou à un débit par minute (r/m). Exemple : <code>50r/m</code>.</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>Remplacez <code>&lt;<em>conn</em>&gt;</code> par le nombre de connexions.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

<br />



### Limites de débit de service (service-rate-limit)
{: #service-rate-limit}

Permet de limiter le débit de traitement des demandes et le nombre de connexions pour des services spécifiques.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Pour des services spécifiques, limitez le débit de traitement des demandes et le nombre de connexions par une clé définie émanant d'une même adresse IP pour tous le chemins des back end sélectionnés.
</dd>


 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;myservice&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service pour lequel vous désirez limiter le débit de traitement.</li>
  </tr>
  <tr>
  <td><code>key</code></td>
  <td>Pour définir une limite globale pour les demandes entrantes en fonction de l'emplacement ou du service, utilisez `key=location`. Pour définir une limite globale pour les demandes entrantes en fonction de l'en-tête, utilisez `X-USER-ID key==$http_x_user_id`.</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>Remplacez <code>&lt;<em>rate</em>&gt;</code> par le débit de traitement. Pour définir un débit par seconde, utilisez r/s: <code>10r/s</code>. Pour définir un débit par minute, utilisez r/m: <code>50r/m</code>.</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>Remplacez <code>&lt;<em>conn</em>&gt;</code> par le nombre de connexions.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />



## Annotations d'authentification HTTPS et TLS/SSL
{: #https-auth}


### Ports HTTP et HTTPS personnalisés (custom-port)
{: #custom-port}

Modifiez les ports par défaut pour le trafic réseau HTTP (port 80) et HTTPS (port 443).
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Par défaut, l'équilibreur de charge d'application Ingress est configuré pour être à l'écoute du trafic réseau HTTP entrant sur le port 80 et du trafic réseau HTTPS entrant sur le port 443. Vous pouvez changer les ports par défaut pour renforcer la sécurité de votre domaine d'équilibreur de charge ou pour activer seulement un port HTTPS.
</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/custom-port: "protocol=&lt;protocol1&gt; port=&lt;port1&gt;;protocol=&lt;protocol2&gt;port=&lt;port2&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;protocol&gt;</code></td>
 <td>Entrez <strong>http</strong> ou <strong>https</strong> pour changer le port par défaut pour le trafic réseau HTTP ou HTTPS entrant .</td>
 </tr>
 <tr>
 <td><code>&lt;port&gt;</code></td>
 <td>Entrez le numéro de port que vous désirez utiliser pour le trafic réseau HTTP ou HTTPS entrant. <p><strong>Remarque :</strong> lorsqu'un port personnalisé est indiqué pour HTTP ou HTTPS, les ports par défaut ne sont plus valides à la fois pour HTTP et HTTPS. Par exemple, pour remplacer le port par défaut pour HTTPS par 8443, mais utiliser le port par défaut pour HTTP, vous devez définir des ports personnalisés pour les deux ports : <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p></td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Utilisation</dt>
 <dd><ol><li>Examinez les ports ouverts pour votre équilibreur de charge d'application. 
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
La sortie de votre interface CLI sera similaire à ceci:
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>Ouvrez la mappe de configuration Ingress.
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>Ajoutez les ports HTTP et HTTPS différents des valeurs par défaut à la mappe de configuration (ConfigMap). Remplacez &lt;port&gt; par le port HTTP ou HTTPS que vous souhaitez ouvrir.
<pre class="codeblock">
<code>apiVersion: v1
kind: ConfigMap
data:
 public-ports: &lt;port1&gt;;&lt;port2&gt;
metadata:
 creationTimestamp: 2017-08-22T19:06:51Z
 name: ibm-cloud-provider-ingress-cm
 namespace: kube-system
 resourceVersion: "1320"
 selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
 uid: &lt;uid&gt;</code></pre></li>
 <li>Vérifiez que votre contrôleur Ingress est reconfiguré avec les ports différents des ports par défaut.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
La sortie de votre interface CLI sera similaire à ceci:
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>Configurez Ingress pour utiliser les ports différents des ports par défaut lorsque vous routez le trafic réseau entrant vers vos services. Utilisez l'exemple de fichier YAML dans cette référence. </li>
<li>Mettez à jour la configuration de votre contrôleur Ingress.
<pre class="pre">
<code>kubectl apply -f &lt;yaml_file&gt;</code></pre>
</li>
<li>Ouvrez le navigateur Web de votre choix pour accéder à votre application. Exemple : <code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>

<br />



### Redirection HTTP vers HTTPS (redirect-to-https)
{: #redirect-to-https}

Convertissez les demandes HTTP non sécurisées en demandes HTTPS.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Configurez votre équilibreur de charge d'application Ingress pour sécuriser votre domaine avec le certificat TLS fourni par IBM ou votre certificat TLS personnalisé. Certains utilisateurs peuvent tenter d'accéder à vos applications en utilisant une demande HTTP non sécurisée vers le domaine d'équilibreur de charge de votre application (par exemple, <code>http://www.myingress.com</code> au lieu de d'utiliser <code>https</code>). Vous pouvez utiliser l'annotation redirect pour convertir systématiquement en HTTPS les demandes HTTP non sécurisées. Si vous n'utilisez pas cette annotation, les demandes HTTP non sécurisées ne sont pas converties par défaut en demandes HTTPS et peuvent exposer au public des informations confidentielles non chiffrées.

 </br></br>
La redirection de demandes HTTP en demandes HTTPS est désactivée par défaut.</dd>

<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/redirect-to-https: "True"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

<br />



### Authentification mutuelle (mutual-auth)
{: #mutual-auth}

Configurez une authentification mutuelle pour l'équilibreur de charge d'application.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Configurez une authentification mutuelle pour l'équilibreur de charge d'application Ingress. Le client authentifie le serveur et le serveur authentifie également le client à l'aide de certificats. L'authentification mutuelle est également appelée authentification basée sur des certificats ou authentification bidirectionnelle.
</dd>

<dt>Conditions prérequises</dt>
<dd>
<ul>
<li>[Vous devez disposer d'une valeur confidentielle valide contenant l'autorité de certification (CA) requise](cs_app.html#secrets). Les valeurs <code>client.key</code> et <code>client.crt</code> sont également nécessaires pour une authentification via l'authentification mutuelle.</li>
<li>Pour activer l'authentification mutuelle sur un autre port que le port 443, [configurez l'équilibreur de charge de manière à ouvrir un port valide](cs_ingress.html#opening_ingress_ports).</li>
</ul>
</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: myingress
annotations:
  ingress.bluemix.net/mutual-auth: "secretName=&lt;mysecret&gt; port=&lt;port&gt; serviceName=&lt;servicename1&gt;,&lt;servicename2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
</thead>
<tbody>
<tr>
<td><code>secretName</code></td>
<td>Remplacez <code>&lt;<em>mysecret</em>&gt;</code> par le nom de la ressource confidentielle.</td>
</tr>
<tr>
<td><code>&lt;port&gt;</code></td>
<td>Numéro de port de l'équilibreur de charge d'application.</td>
</tr>
<tr>
<td><code>&lt;serviceName&gt;</code></td>
<td>Nom d'une ou de plusieurs ressources Ingress. Ce paramètre est facultatif.</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### Support des services SSL (ssl-services)
{: #ssl-services}

Autorisez les demandes HTTPS et chiffrez le trafic vers vos applications en amont.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Chiffrez le trafic vers vos applications en amont qui requièrent d'utiliser HTTPS avec les équilibreurs de charge d'application.

**Facultatif** : vous pouvez ajouter [l'authentification unidirectionnelle ou l'authentification mutuelle](#ssl-services-auth) à cette annotation.
</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: &lt;nom_ingress&gt;
  annotations:
    ingress.bluemix.net/ssl-services: "ssl-service=&lt;myservice1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;myservice2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
spec:
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice1
          servicePort: 8443
      - path: /
        backend:
          serviceName: myservice2
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service qui représente votre application. Le trafic depuis l'équilibreur de charge d'application vers cette application est chiffré.</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Remplacez <code>&lt;<em>service-ssl-secret</em>&gt;</code> par le nom de la valeur confidentielle pour le service. Ce paramètre est facultatif. S'il est fourni, la valeur doit contenir la clé et le certificat que votre application attend du client.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


#### Support des services SSL avec authentification
{: #ssl-services-auth}

Autorisez les demandes HTTPS et chiffrez le trafic vers vos applications en amont avec authentification unidirectionnelle ou mutuelle pour une sécurité supplémentaire.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Configurer l'authentification mutuelle pour des applications d'équilibrage de charge authentication qui nécessitent HTTPS avec les contrôleurs Ingress.

**Remarque** : avant de commencer, [convertit le certificat et la clé en base 64 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.base64encode.org/).

</dd>


<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: &lt;nom_ingress&gt;
  annotations:
    ingress.bluemix.net/ssl-services: |
      ssl-service=&lt;myservice1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;myservice2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice1
          servicePort: 8443
      - path: /
        backend:
          serviceName: myservice2
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Remplacez <code>&lt;<em>myservice</em>&gt;</code> par le nom du service qui représente votre application. Le trafic depuis l'équilibreur de charge d'application vers cette application est chiffré.</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Remplacez <code>&lt;<em>service-ssl-secret</em>&gt;</code> par le nom de la valeur confidentielle pour le service. Ce paramètre est facultatif. S'il est fourni, la valeur doit contenir la clé et le certificat que votre application attend du client.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>


<br />



