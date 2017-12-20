---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-14"

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

Pour ajouter des fonctionnalités à votre contrôleur Ingress, vous pouvez spécifier des annotations en tant que métadonnées dans une ressource Ingress.
{: shortdesc}

Pour des informations générales sur les services Ingress et comment les utiliser, voir [Configuration d'un accès public à une application à l'aide du contrôleur Ingress](cs_apps.html#cs_apps_public_ingress).


|Annotation prise en charge|Description|
|--------------------|-----------|
|[En-tête de réponse ou de demande client supplémentaire](#proxy-add-headers)|Ajouter des informations d'en-tête à une demande client avant d'acheminer la demande vers votre application de back end ou à une réponse client avant d'envoyer la réponse au client.|
|[Mise en mémoire tampon des données de réponse client](#proxy-buffering)|Désactiver la mise en mémoire tampon d'une réponse client sur le contrôleur Ingress lors de l'envoi de la réponse au client.|
|[Retrait d'en-tête de réponse client](#response-remove-headers)|Retirer les informations d'en-tête d'une réponse client avant d'acheminer la réponse vers le client.|
|[Personnalisation des paramètres connect-timeouts et read-timeouts](#proxy-connect-timeout)|Ajuster le délai d'attente observé par le contrôleur Ingress pour établir une connexion à et effectuer une lecture à partir de l'application de back end avant que celle-ci ne soit considérée comme indisponible.|
|[Ports HTTP et HTTPS personnalisés](#custom-port)|Remplacer les ports par défaut pour le trafic réseau HTTP et HTTPS.|
|[Personnaliser la taille du corps de demande client maximale](#client-max-body-size)|Ajuster la taille du corps de demande du client pouvant être envoyé au contrôleur Ingress.|
|[Services externes](#proxy-external-service)|Ajoute la définition des chemins à des services externes, tel un service hébergé dans {{site.data.keyword.Bluemix_notm}}.|
|[Limites de débit globales](#global-rate-limit)|Pour tous les services, limite le débit de traitement des demandes et connexions par une clé définie.|
|[Redirection HTTP vers HTTPS](#redirect-to-https)|Rediriger les demandes HTTP non sécurisées sur votre domaine vers HTTPS.|
|[Demandes de signal de présence](#keepalive-requests)|Configurer le nombre maximum de demandes pouvant être traitées via une connexion de signal de présence.|
|[Délai d'expiration de signal de présence](#keepalive-timeout)|Configurer la durée d'ouverture d'une connexion de signal de présence sur le serveur.|
|[Authentification mutuelle](#mutual-auth)|Configurer l'authentification mutuelle pour le contrôleur Ingress.|
|[Tampons de proxy](#proxy-buffers)|Définit le nombre et la taille des tampons utilisés pour lire une réponse d'une seule connexion provenant du serveur relayé via un proxy.|
|[Taille des tampons occupés de proxy](#proxy-busy-buffers-size)|Limite la taille totale des tampons pouvant être occupés à l'envoi d'une réponse au client alors que la réponse n'est pas encore totalement lue.|
|[Taille de tampon de proxy](#proxy-buffer-size)|Définit la taille du tampon utilisé pour lire la première partie de la réponse reçue du serveur relayé via un proxy.|
|[Chemins de redirection](#rewrite-path)|Acheminer le trafic réseau entrant vers un autre chemin sur lequel votre application de back end est en mode écoute.|
|[Affinité de session avec des cookies](#sticky-cookie-services)|Acheminer systématiquement le trafic réseau entrant vers le même serveur en amont à l'aide d'un cookie compliqué.|
|[Limites de débit de service](#service-rate-limit)|Pour des services spécifiques, limite le débit de traitement des demandes et connexions par une clé définie.|
|[Support des services SSL](#ssl-services)|Autorise la prise en charge des services SSL pour l'équilibrage de charge.|
|[Ports TCP](#tcp-ports)|Accéder à une application via un port TCP non standard.|
|[Signal de présence en amont](#upstream-keepalive)|Configurer le nombre maximum de connexions de signal de présence inactives pour un serveur en amont.|






## En-tête de réponse ou de demande client supplémentaire (proxy-add-headers)
{: #proxy-add-headers}

Ajoutez des informations d'en-tête à une demande client avant d'envoyer la demande vers l'application de back end ou à une réponse client avant d'envoyer la réponse au client.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Le contrôleur Ingress agit comme un proxy enetre l'application client et votre application de back end. Les demandes client qui sont envoyées au contrôleur Ingress sont traitées (relayées via un proxy) et placées dans une nouvelle demande qui est ensuite envoyée à l'application de back end à partir du contrôleur Ingress. Lorsqu'une demande passe par un  proxy, les informations d'en-tête HTTP intialement envoyées par le client, par exemple, le nom d'utilisateur, sont retirées. Si votre application de back end a besoin de ces informations, vous pouvez utiliser l'annotation <strong>ingress.bluemix.net/proxy-add-headers</strong> pour ajouter des informations d'en-tête à la demande client avant que celle-ci ne soit acheminée vers votre application de back end à partir du contrôleur Ingress.

</br></br>
Lorsqu'une application de back end envoie une réponse au client, la réponse est relayée via un proxy par le contrôleur Ingress et les en-têtes HTTP sont retirés de la réponse. L'application Web client peut avoir besoin de ces informations d'en-tête pour traiter correctement la réponse. Vous pouvez utiliser l'annotation <strong>ingress.bluemix.net/response-add-headers</strong> pour ajouter des informations d'en-tête à la réponse client avant que celle-ci ne soit acheminée vers votre application Web client à partir du contrôleur Ingress.</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
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
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;service_name&gt;</em></code> : nom du service Kubernetes que vous avez créé pour votre application.</li>
  <li><code><em>&lt;header&gt;</em></code> : clé des informations d'en-tête à ajouter à la demande client ou à la réponse client.</li>
  <li><code><em>&lt;value&gt;</em></code> : valeur des informations d'en-tête à ajouter à la demande client ou à la réponse client.</li>
  </ul></td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />


 ## Mise en mémoire tampon des données de réponse client (proxy-buffering)
 {: #proxy-buffering}

 Utilisez l'annotation buffer pour désactiver le stockage des données de réponse sur le contrôleur Ingress alors que les données sont envoyées au client.
 {:shortdesc}

 <dl>
 <dt>Description</dt>
 <dd>Le contrôleur Ingress agit comme un proxy entre votre application de back end et l'application Web client. Lorsqu'une réponse est envoyée au client à partir de l'application de back end, par défaut, les données de réponse sont mises en mémoire tampon sur le contrôleur Ingress. La réponse client est relayée via un proxy par le contrôleur Ingress qui commence alors à l'envoyer au client au rythme de ce dernier. Une fois que toutes les données provenant de l'application de back end ont été reçues par le contrôleur Ingress, la connexion avec l'application de back end est fermée. La connexion entre le contrôleur Ingress et le client reste ouverte jusqu'à ce que ce dernier reçoive toutes les données.

 </br></br>
 Si la mise en mémoire tampon des données de réponse sur le contrôleur Ingress est désactivée, les données sont immédiatement envoyées au client à partir du contrôleur Ingress. Le client doit être capable de traiter les données entrantes au rythme du contrôleur Ingress. Si le client est trop lent, les données risquent d'être perdues.
 </br></br>
 La mise en mémoire tampon des données de réponse sur le contrôleur Ingress est activée par défaut.</dd>
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


 ## Retrait d'en-tête de réponse client (response-remove-headers)
 {: #response-remove-headers}

Retirez de l'application de back end les informations d'en-tête incluses dans la réponse client, avant que celle-ci ne soit envoyée au client.
 {:shortdesc}

 <dl>
 <dt>Description</dt>
 <dd>Le contrôleur Ingress agit comme un proxy entre votre application de back end et l'application Web client. Les réponses client de l'application de back end qui sont envoyées au contrôleur Ingress sont traitées (elles sont relayées via un proxy) et placées dans une nouvelle réponse qui est ensuite envoyée au navigateur Web client à partir du contrôleur Ingress. Même si le fait de relayer une réponse via un proxy permet de retirer les informations d'en-tête HTTP initialement envoyées à partir de l'application de back end, il se peut que les en-têtes propres à l'application de back end ne soient pas tous retirés par ce processus. Retirez les informations d'en-tête d'une réponse client avant que celle-ci ne soit acheminée du contrôleur Ingress vers le navigateur Web du client.</dd>
 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/response-remove-headers: |
       serviceName=&lt;service_name1&gt; {
       "&lt;header1&gt;";
       "&lt;header2&gt;";
       }
       serviceName=&lt;service_name2&gt; {
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
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
       - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>Remplacez les valeurs suivantes :<ul>
   <li><code><em>&lt;service_name&gt;</em></code> : nom du service Kubernetes que vous avez créé pour votre application.</li>
   <li><code><em>&lt;header&gt;</em></code> : clé de l'en-tête à retirer de la réponse client.</li>
   </ul></td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


## Personnalisation des paramètres connect-timeout et read-timeout (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Définissez un paramètre connect-timeout et un paramètre read-timeout personnalisés pour le contrôleur Ingress. Ajustez le délai d'attente observé par le contrôleur Ingress pour établir une connexion à et effectuer une lecture à partir de l'application de back end avant que celle-ci ne soit considérée comme indisponible.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Lorsqu'une demande client est envoyée au contrôleur Ingress, une connexion à l'application de back end est ouverte par le contrôleur Ingress. Par défaut, le contrôleur Ingress attend une réponse de l'application de back end pendant 60 secondes. Si l'application de back end ne répond pas au cours de ce délai de 60 secondes, la demande de connexion est abandonnée et l'application de back end est considérée comme indisponible.

</br></br>
Une fois le contrôleur Ingress connecté à l'application de back end, le contrôleur Ingress lit les données de réponse de cette dernière. Au cours de cette opération de lecture, le contrôleur Ingress observe un délai d'attente maximal de 60 secondes entre deux opérations de lecture avant de recevoir les données de l'application de back end. Si l'application de back end n'envoie pas les données au cours de ce délai de 60 secondes, la connexion avec l'application de back end est fermée et cette dernière est considérée comme indisponible.
</br></br>
Sur un proxy, les paramètres connect-timeout et read-timeout sont définis par défaut sur 60 secondes et ne doivent généralement pas être modifiés.
</br></br>
En cas d'instabilité de la disponibilité de votre application ou si celle-ci est lente à répondre en raison de charges de travail élevées, vous souhaiterez peut-être augmenter la valeur du paramètre connect-timeout ou read-timeout. Gardez à l'esprit que le fait d'augmenter le délai d'attente aura un impact sur les performances du contrôleur Ingress car la connexion avec l'application de back end doit rester ouverte jusqu'à ce que le délai d'attente soit atteint.
</br></br>
D'un autre côté, vous pouvez réduire le délai d'attente afin d'améliorer les performances du contrôleur Ingress. Assurez-vous que votre application de back end est capable de traiter les demandes dans le délai d'attente imparti, même lorsque les charges de travail sont plus importantes.</dd>
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
 <td><code>annotations</code></td>
 <td>Remplacez les valeurs suivantes :<ul><li><code><em>&lt;connect_timeout&gt;</em></code> : entrez le délai d'attente, exprimé en secondes, à observer avant d'établir une connexion avec l'application de back end, par exemple <strong>65s</strong>.

 </br></br>
 <strong>Remarque :</strong> La valeur d'un paramètre connect-timeout ne doit pas excéder 75 secondes.</li><li><code><em>&lt;read_timeout&gt;</em></code> : entrez le délai d'attente en secondes à observer avant la lecture de l'application de back end, <strong>65s</strong>.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


## Ports HTTP et HTTPS personnalisés (custom-port)
{: #custom-port}

Modifiez les ports par défaut pour le trafic réseau HTTP (port 80) et HTTPS (port 443).
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Par défaut, le contrôleur Ingress est configuré pour écouter le trafic réseau HTTP entrant sur le port 80 et le trafic réseau HTTPS entrant sur le port 443. Vous pouvez modifier ces ports par défaut pour renforcer la sécurité dans le domaine du contrôleur Ingress ou pour activer uniquement un port HTTPS.
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
 <td><code>annotations</code></td>
 <td>Remplacez les valeurs suivantes :<ul>
 <li><code><em>&lt;protocol&gt;</em></code> : entrez <strong>http</strong> ou <strong>https</strong> pour remplacer le port par défaut correspondant au trafic réseau HTTP ou HTTPS entrant.</li>
 <li><code><em>&lt;port&gt;</em></code> : entrez le numéro de port que vous voulez utiliser pour le trafic réseau HTTP ou HTTPS entrant.</li>
 </ul>
 <p><strong>Remarque :</strong> lorsqu'un port personnalisé est indiqué pour HTTP ou HTTPS, les ports par défaut ne sont plus valides à la fois pour HTTP et HTTPS. Par exemple, pour remplacer le port par défaut pour HTTPS par 8443, mais utiliser le port par défaut pour HTTP, vous devez définir des ports personnalisés pour les deux ports : <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p>
 </td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Utilisation</dt>
 <dd><ol><li>Vérifiez les ports ouverts pour votre contrôleur Ingress. **Remarque : l'adresse IP doit être une adresse IP de documentation générique. Avec liaison à l'interface de ligne de commande kubectl qui cible ? Pas forcément.**
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


## Personnaliser la taille maximale du corps de demande client (client-max-body-size)
{: #client-max-body-size}

Ajustez la taille maximale du corps que le client peut envoyer dans le cadre d'une demande.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Dans le but de maintenir les performances attendues, la valeur définie pour la taille maximale du corps de la demande client est 1 mégaoctet. Lorqu'une demande client dont la taille du corps dépasse la limite est envoyée au contrôleur Ingress et que le client n'autorise pas le fractionnement des données, le contrôleur Ingress renvoie une réponse HTTP 413 (Request Entity Too Large) au client. Il est impossible d'établir une connexion entre le client et le contrôleur Ingress tant que la taille du corps de la demande n'est pas réduite. Lorsque le client autorise le fractionnement des données en plusieurs blocs, celles-ci sont scindées en blocs de 1 mégaoctet et envoyées au contrôleur Ingress.

</br></br>
Vous souhaiterez peut-être augmenter la taille maximale du corps car vous attendez des demandes client avec une taille de corps supérieure à 1 mégaoctet. Par exemple, vous voulez que votre client puisse télécharger des fichiers volumineux. Le fait d'augmenter la taille maximale du corps de demande peut avoir un impact sur les performances de votre contrôleur Ingress car la connexion avec le client doit rester ouverte jusqu'à ce que la demande soit reçue.
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
   ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
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
 <td><code>annotations</code></td>
 <td>Remplacez la valeur suivante :<ul>
 <li><code><em>&lt;size&gt;</em></code> : entrez la taille maximale du corps de réponse client. Par exemple, pour définir une taille de 200 mégaoctets, indiquez <strong>200m</strong>.

 </br></br>
 <strong>Remarque :</strong> vous pouvez définir la taille 0 pour désactiver la vérification de la taille du corps de demande client.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


<return to here>

## Services externes (proxy-external-service)
{: #proxy-external-service}
Ajoutez des définitions de chemin d'accès à des services externes, tels des services hébergés dans {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Ajouter des définitions de chemin d'accès à des services externes. Cette annotation est réservée à des cas spéciaux car elle ne fonctionne pas sur un service de back end et fonctionne sur un service externe. Les annotations autres que than client-max-body-size, proxy-read-timeout, proxy-connect-timeout et proxy-buffering ne sont pas prises en charge avec une route de service externe.
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
    ingress.bluemix.net/proxy-external-service: "path=&lt;path&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
spec:
  tls:
  - hosts:
    - &lt;mydomain&gt;
    secretName: mysecret
  rules:
  - host: &lt;mydomain&gt;
    http:
      paths:
      - path: &lt;path&gt;
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
 <td><code>annotations</code></td>
 <td>Remplacez la valeur suivante :
 <ul>
 <li><code><em>&lt;external_service&gt;</em></code> : indiquez le service externe à appeler. Par exemple, https://&lt;monservice&gt;.&lt;region&gt;.mybluemix.net.</li>
 </ul>
 </tr>
 </tbody></table>

 </dd></dl>


<br />


## Limites de débit globales (global-rate-limit)
{: #global-rate-limit}

Pour tous les services, limitez le débit de traitement des demandes et le nombre de connexions par une clé définie émanant d'une même adresse IP pour tous les hôtes d'un mappage Ingress.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Pour fixer la limite, des zones sont définies à l'aide des paramètres `ngx_http_limit_conn_module` et `ngx_http_limit_req_module`. Ces zones sont appliquées aux blocs du serveur qui correspondent à chaque hôte dans un mappage Ingress. </dd>


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
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;key&gt;</em></code> : Pour définir une limite globale pour les demandes entrantes en fonction de l'emplacement ou du service, utilisez `key=location`. Pour définir une limite globale pour les demandes entrantes en fonction de l'en-tête, utilisez `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code> : Débit.</li>
  <li><code><em>&lt;conn&gt;</em></code> : Nombre de connexions.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

  <br />


 ## Redirection HTTP vers HTTPS (redirect-to-https)
 {: #redirect-to-https}

 Convertissez les demandes HTTP non sécurisées en demandes HTTPS.
 {:shortdesc}

 <dl>
 <dt>Description</dt>
 <dd>Vous configurez votre contrôleur Ingress afin de sécuriser votre domaine avec le certificat TLS fourni par IBM ou votre certificat TLS personnalisé. Certains utilisateurs peuvent tenter d'accéder à vos applications en utilisant une demande HTTP non sécurisée sur votre domaine de contrôleur Ingress, par exemple, <code>http://www.myingress.com</code>, au lieu d'utiliser <code>https</code>. Vous pouvez utiliser l'annotation redirect pour convertir systématiquement les demandes HTTP non sécurisées en demandes HTTPS. Si vous n'utilisez pas cette annotation, les demandes HTTP non sécurisées ne sont pas converties en demandes HTTPS par défaut et peuvent exposer des informations confidentielles non chiffrées au public.

 </br></br>
 La conversion des demandes HTTP en demandes HTTPS est désactivée par défaut.</dd>
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




 <br />

 
 ## Demandes de signal de présence (keepalive-requests)
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
    ingress.bluemix.net/keepalive-requests: "serviceName=&lt;service_name&gt; requests=&lt;max_requests&gt;"
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
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;serviceName&gt;</em></code> : Remplacez <em>&lt;service_name&gt;</em> par le nom du service Kubernetes que vous avez créé pour votre application. Ce paramètre est facultatif. Si aucun service n'est spécifié, la configuration est appliquée à tous les services de l'hôte Ingress. Si le paramètre est fourni, les demandes de signal de présence sont définies pour le service indiqué. Si le paramètre n'est pas fourni, les demandes de signal de présence sont définies au niveau serveur de <code>nginx.conf</code> pour tous les services pour lesquels aucune demande de signal de présence n'est configurée.</li>
  <li><code><em>&lt;requests&gt;</em></code> : Remplacez <em>&lt;max_requests&gt;</em> par le nombre maximum de demandes pouvant être traitées via une connexion de signal de présence.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Délai d'expiration de signal de présence (keepalive-timeout)
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
     ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;service_name&gt; timeout=&lt;time&gt;s"
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
   <td><code>annotations</code></td>
   <td>Remplacez les valeurs suivantes :<ul>
   <li><code><em>&lt;serviceName&gt;</em></code> : Remplacez <em>&lt;service_name&gt;</em> par le nom du service Kubernetes que vous avez créé pour votre application. Ce paramètre est facultatif. Si le paramètre est fourni, le délai d'expiration de signal de présence est défini pour le service indiqué. Si le paramètre n'est pas fourni, le délai d'expiration de signal de présence est défini au niveau serveur de <code>nginx.conf</code> pour tous les services pour lesquels aucun délai d'expiration de signal de présence n'est configuré.</li>
   <li><code><em>&lt;timeout&gt;</em></code> : Remplacez <em>&lt;time&gt;</em> par une durée en secondes. Exemple :<code><em>timeout=20s</em></code>. Une valeur zéro désactive les connexions client de signal de présence.</li>
   </ul>
   </td>
   </tr>
   </tbody></table>

   </dd>
   </dl>

 <br />


 ## Authentification mutuelle (mutual-auth)
 {: #mutual-auth}

 Configurez l'authentification mutuelle pour le contrôleur Ingress.
 {:shortdesc}

 <dl>
 <dt>Description</dt>
 <dd>
 Configurer l'authentification mutuelle pour le contrôleur Ingress. Le client authentifie le serveur et le serveur authentifie également le client à l'aide de certificats. L'authentification mutuelle est également appelée authentification basée sur des certificats ou authentification bidirectionnelle.
 </dd>

 <dt>Conditions prérequises</dt>
 <dd>
 <ul>
 <li>[Vous devez disposer d'une valeur confidentielle valide contenant l'autorité de certification (CA) requise](cs_apps.html#secrets). Les valeurs <code>client.key</code> et <code>client.crt</code> sont également nécessaires pour une authentification via l'authentification mutuelle.</li>
 <li>Pour activer l'authentification mutuelle sur un autre port que le port 443, [configurez l'équilibreur de charge de manière à ouvrir un port valide](cs_apps.html#opening_ingress_ports).</li>
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
    ingress.bluemix.net/mutual-auth: "port=&lt;port&gt; secretName=&lt;secretName&gt; serviceName=&lt;service1&gt;,&lt;service2&gt;"
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
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;serviceName&gt;</em></code> : Nom d'une ou plusieurs ressources Ingress. Ce paramètre est facultatif. </li>
  <li><code><em>&lt;secretName&gt;</em></code> : Remplacez <em>&lt;secret_name&gt;</em> par le nom de la ressource de valeur confidentielle.</li>
  <li><code><em>&lt;port&gt;</em></code> : Entrez le numéro de port.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Tampons de proxy (proxy-buffers)
 {: #proxy-buffers}
 
 Configurez des tampons de proxy pour le contrôleur Ingress.
 {:shortdesc}

 <dl>
 <dt>Description</dt>
 <dd>
 Définir le nombre et la taille des tampons utilisés pour lire une réponse d'une seule connexion provenant du serveur relayé via un proxy. Si aucun service n'est spécifié, la configuration est appliquée à tous les services de l'hôte Ingress. Par exemple, si une configuration telle que <code>serviceName=SERVICE number=2 size=1k</code> est spécifiée, 1k est appliqué au service. Si une configuration telle que <code>number=2 size=1k</code> est spécifiée, 1k est appliqué à tous les services de l'hôte Ingress.
 </dd>
 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffers: "serviceName=&lt;service_name&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
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
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :
  <ul>
  <li><code><em>&lt;serviceName&gt;</em></code> : Remplacez <em>&lt;serviceName&gt;</em> par le nom du service auquel appliquer proxy-buffers. </li>
  <li><code><em>&lt;number_of_buffers&gt;</em></code> : Remplacez <em>&lt;number_of_buffers&gt;</em> par un chiffre, par exemple <em>2</em>.</li>
  <li><code><em>&lt;size&gt;</em></code> : Indiquez la taille de chaque tampon en kilooctets (k ou K), par exemple <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>
  </dd>
  </dl>

 <br />


 ## Taille des tampons occupés de proxy (proxy-busy-buffers-size)
 {: #proxy-busy-buffers-size}

 Configurez la taille des tampons occupés de proxy du contrôleur Ingress.
 {:shortdesc}

 <dl>
 <dt>Description</dt>
 <dd>
 Lorsque la mise en mémoire tampon des réponses provenant du serveur relayé via un proxy est activée, limite la taille totale des tampons pouvant être occupés à l'envoi d'une réponse au client alors que la réponse n'est pas encore totalement lue. Pendant ce temps, les tampons restants peuvent être utilisés pour lire la réponse et, au besoin, mettre en mémoire tampon une partie de la réponse dans un fichier temporaire. Si aucun service n'est spécifié, la configuration est appliquée à tous les services de l'hôte Ingress. Par exemple, si une configuration telle que <code>serviceName=SERVICE size=1k</code> est spécifiée, 1k est appliqué au service. Si une configuration telle que <code>size=1k</code> est spécifiée, 1k est appliqué à tous les services de l'hôte Ingress.
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
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;serviceName&gt;</em></code> : Remplacez <em>&lt;serviceName&gt;</em> par le nom du service auquel appliquer proxy-busy-buffers-size.</li>
  <li><code><em>&lt;size&gt;</em></code> : Indiquez la taille de chaque tampon en kilooctets (k ou K), par exemple <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Taille de tampon de proxy (proxy-buffer-size)
 {: #proxy-buffer-size}

 Configurez la taille de tampon de proxy du contrôleur Ingress.
 {:shortdesc}

 <dl>
 <dt>Description</dt>
 <dd>
 Définir la taille du tampon utilisé pour lire la première partie de la réponse reçue du serveur relayé via un proxy. Cette partie de la réponse contient généralement un petit en-tête de réponse. Si aucun service n'est spécifié, la configuration est appliquée à tous les services de l'hôte Ingress. Par exemple, si une configuration telle que <code>serviceName=SERVICE size=1k</code> est spécifiée, 1k est appliqué au service. Si une configuration telle que <code>size=1k</code> est spécifiée, 1k est appliqué à tous les services de l'hôte Ingress.
 </dd>


 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
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
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;serviceName&gt;</em></code> : Remplacez <em>&lt;serviceName&gt;</em> par le nom du service auquel appliquer proxy-busy-buffers-size.</li>
  <li><code><em>&lt;size&gt;</em></code> : Indiquez la taille de chaque tampon en kilooctets (k ou K), par exemple <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />



## Chemins de redirection (rewrite-path)
{: #rewrite-path}

Acheminez le trafic réseau entrant sur un chemin de domaine de contrôleur Ingress vers un chemin différent sur lequel votre application de back end est en mode écoute.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Votre domaine de contrôleur Ingress achemine vers votre application le trafic réseau entrant sur
<code>mykubecluster.us-south.containers.mybluemix.net/beans</code>. Votre application est en mode écoute sur <code>/coffee</code> au lieu de <code>/beans</code>. Pour acheminer le trafic réseau entrant vers votre application, ajoutez l'annotation rewrite au fichier de configuration de votre ressource Ingress. L'annotation rewrite garantit que le trafic réseau entrant sur <code>/beans</code> est réacheminé vers votre application en utilisant le chemin <code>/coffee</code>. Lorsque vous incluez plusieurs services, utilisez uniquement un point-virgule (;) pour les séparer.</dd>
<dt>Exemple de fichier YAML de ressource Ingress</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;target_path2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: &lt;mytlssecret&gt;
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>Remplacez <em>&lt;service_name&gt;</em> par le nom du service Kubernetes que vous avez créé pour votre application et <em>&lt;target-path&gt;</em>, par le chemin sur lequel votre application est à l'écoute. Le trafic réseau entrant sur le domaine du contrôleur Ingress est réacheminé au service Kubernetes en utilisant ce chemin. La plupart des applications ne sont pas à l'écoute sur un chemin spécifique, mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez <code>/</code> comme <em>chemin_redirection</em> pour votre application.</td>
</tr>
<tr>
<td><code>path</code></td>
<td>Remplacez <em>&lt;domain_path&gt;</em> par le chemin que vous désirez ajouter en suffixe à votre domaine de contrôleur
Ingress. Le trafic réseau entrant sur ce chemin est réacheminé vers le chemin de redirection que vous avez défini dans votre annotation. Dans l'exemple ci-dessus, affectez au chemin de domaine la valeur  <code>/beans</code> pour inclure ce chemin dans l'équilibrage de charge de votre contrôleur Ingress.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Remplacez <em>&lt;service_name&gt;</em> par le nom du service Kubernetes que vous avez créé pour votre application. Le nom du service que vous utilisez ici doit être identique au nom que vous avez défini dans votre annotation.</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>Remplacez <em>&lt;service_port&gt;</em> par le port sur lequel votre service est en mode écoute.</td>
</tr></tbody></table>

</dd></dl>

<br />


## Limites de débit de service (service-rate-limit)
{: #service-rate-limit}

Pour des services spécifiques, limitez le débit de traitement des demandes et le nombre de connexions par une clé définie émanant d'une même adresse IP pour tous le chemins des back end sélectionnés.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Pour définir la limite, des zones définies par `ngx_http_limit_conn_module` et `ngx_http_limit_req_module` sont appliquées à tous les blocs d'emplacement qui correspondent à tous les services ciblés dans l'annotation dans le mappage ingress. </dd>


 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;service_name&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
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
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;serviceName&gt;</em></code> : Nom de la ressource Ingress.</li>
  <li><code><em>&lt;key&gt;</em></code> : Pour définir une limite globale pour les demandes entrantes en fonction de l'emplacement ou du service, utilisez `key=location`. Pour définir une limite globale pour les demandes entrantes en fonction de l'en-tête, utilisez `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code> : Débit.</li>
  <li><code><em>&lt;conn&gt;</em></code> : Nombre de connexions.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


## Affinité de session avec des cookies (sticky-cookie-services)
{: #sticky-cookie-services}

Utilisez l'annotation sticky cookie pour ajouter une affinité de session à votre contrôleur Ingress et toujours réacheminer le trafic réseau entrant vers le même serveur en amont.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>Pour la haute disponibilité, certaines configurations d'application nécessitent de déployer plusieurs serveurs en amont qui prennent en charge les demandes client entrantes. Lorsqu'un client se connecte à votre application de back end, vous pouvez utiliser l'affinité de session pour qu'un client soit servi par le même serveur en amont pendant toute la durée d'une session ou pendant la durée d'exécution d'une tâche. Vous pouvez configurer votre contrôleur Ingress pour garantir l'affinité de session en acheminant systématiquement le trafic réseau entrant vers le même serveur en amont.

</br></br>
Chaque client qui se connecte à votre application de back end est affecté à l'un des serveurs en amont disponibles par le contrôleur Ingress. Le contrôleur Ingress crée un cookie de session qui est stocké dans l'application du client et qui est inclus dans les informations d'en-tête de chaque demande entre le contrôleur Ingress et le client. Les informations contenues dans le cookie garantissent la prise en charge de toutes les demandes par le même serveur en amont pendant toute la session.

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
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
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
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>Description des composants du fichier YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;service_name&gt;</em></code> : nom du service Kubernetes que vous avez créé pour votre application.</li>
  <li><code><em>&lt;cookie_name&gt;</em></code> : choisissez un nom pour le cookie compliqué créé au cours d'une session.</li>
  <li><code><em>&lt;expiration_time&gt;</em></code> : délai, expriméen secondes, minutes ou heures avant l'expiration du cookie compliqué. Ce délai est indépendant de l'activité d'utilisateur. Une fois le cookie arrivé à expiration, il est supprimé par le navigateur Web du client et n'est plus envoyé au contrôleur Ingress. Par exemple, pour définir un délai d'expiration d'1 seconde, d'1 minute ou d'1 heure, entrez <strong>1s</strong>, <strong>1m</strong> ou <strong>1h</strong>.</li>
  <li><code><em>&lt;cookie_path&gt;</em></code> : chemin qui est ajouté au sous-domaine Ingress et qui indique pour quels domaines et sous-domaines le cookie est envoyé au contrôleur Ingress. Par exemple, si votre domaine Ingress est <code>www.myingress.com</code> et que vous souhaitez envoyer le cookie dans chaque demande client, vous devez définir <code>path=/</code>. Si vous souhaitez envoyer le cookie uniquement pour <code>www.myingress.com/myapp</code> et tous ses sous-domaines, vous devez définir <code>path=/myapp</code>.</li>
  <li><code><em>&lt;hash_algorithm&gt;</em></code> : algorithme de hachage qui protège les informations dans le cookie. Seul le type <code>sha1</code> est pris en charge. SHA1 crée une somme hachée basée sur les informations contenues dans le cookie et l'ajoute au cookie. Le serveur peut déchiffrer les informations contenues dans le cookie et vérifier l'intégrité des données.
  </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


## Support des services SSL (ssl-services)
{: #ssl-services}

Autorisez les demandes HTTPS et chiffrez le trafic vers vos applications en amont.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Chiffrer le trafic vers vos application en amont qui nécessitent HTTPS avec les contrôleurs Ingress.

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
    ingress.bluemix.net/ssl-services: ssl-service=&lt;service1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;service2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
spec:
  rules:
  - host: &lt;ibmdomain&gt;
    http:
      paths:
      - path: /&lt;myservicepath1&gt;
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8443
      - path: /&lt;myservicepath2&gt;
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Remplacez <em>&lt;myingressname&gt;</em> par le nom de votre ressource Ingress.</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;myservice&gt;</em></code> : Entrez le nom du service qui représente votre application. Le trafic est chiffré entre le contrôleur Ingress et cette application.</li>
  <li><code><em>&lt;ssl-secret&gt;</em></code> : Entrez la valeur confidentielle du service. Ce paramètre est facultatif. S'il est fourni, la valeur doit contenir la clé et le certificat que votre application attend du client. </li></ul>
  </td>
  </tr>
  <tr>
  <td><code>rules/host</code></td>
  <td>Remplacez <em>&lt;ibmdomain&gt;</em> par le nom de <strong>sous-domaine Ingress</strong> fourni par IBM.
  <br><br>
  <strong>Remarque :</strong> pour éviter des échecs lors de la création Ingress, n'utilisez pas le signe * pour votre hôte ou laissez vide la propriété de l'hôte.</td>
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Remplacez <em>&lt;myservicepath&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application est à l'écoute, afin que ce trafic réseau puisse être réacheminé à l'application.

  </br>
  Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine fourni par IBM afin de constituer un chemin unique vers votre application. Par exemple, <code>ingress_domain/myservicepath1</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute, en utilisant ce même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

  </br></br>
  Bon nombre d'applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application.
  </br>
  Exemples : <ul><li>Pour <code>http://ingress_host_name/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>http://ingress_host_name/myservicepath</code>, entrez <code>/myservicepath</code> pour le chemin.</li></ul>
  </br>
  <strong>Astuce :</strong> pour configurer Ingress de manière à être à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'<a href="#rewrite-path" target="_blank">annotation rewrite</a>
pour définir le routage approprié vers votre application.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Remplacez <em>&lt;myservice&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


### Support des services SSL avec authentification
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
      ssl-service=&lt;service1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;service2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
spec:
  tls:
  - hosts:
    - &lt;ibmdomain&gt;
    secretName: &lt;secret_name&gt;
  rules:
  - host: &lt;ibmdomain&gt;
    http:
      paths:
      - path: /&lt;myservicepath1&gt;
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8443
      - path: /&lt;myservicepath2&gt;
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Remplacez <em>&lt;myingressname&gt;</em> par le nom de votre ressource Ingress.</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;service&gt;</em></code> : Entrez le nom du service.</li>
  <li><code><em>&lt;service-ssl-secret&gt;</em></code> : Entrez la valeur confidentielle du service.</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>tls/host</code></td>
  <td>Remplacez <em>&lt;ibmdomain&gt;</em> par le nom de <strong>sous-domaine Ingress</strong> fourni par IBM.
  <br><br>
  <strong>Remarque :</strong> pour éviter des échecs lors de la création Ingress, n'utilisez pas le signe * pour votre hôte ou laissez vide la propriété de l'hôte.</td>
  </tr>
  <tr>
  <td><code>tls/secretName</code></td>
  <td>Rmeplacez <em>&lt;secret_name&gt;</em> par le nom et la valeur confidentielle qui contient votre certificat et, pour l'authentification mutuelle, la clé.
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Remplacez <em>&lt;myservicepath&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application est à l'écoute, afin que ce trafic réseau puisse être réacheminé à l'application.

  </br>
  Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine fourni par IBM afin de constituer un chemin unique vers votre application. Par exemple, <code>ingress_domain/myservicepath1</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute, en utilisant ce même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

  </br></br>
  De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application.
  </br>
  Exemples : <ul><li>Pour <code>http://ingress_host_name/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>http://ingress_host_name/myservicepath</code>, entrez <code>/myservicepath</code> pour le chemin.</li></ul>
  </br>
  <strong>Astuce :</strong> pour configurer Ingress de manière à être à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'<a href="#rewrite-path" target="_blank">annotation rewrite</a>
pour définir le routage approprié vers votre application.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Remplacez <em>&lt;myservice&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
  </tr>
  </tbody></table>

  </dd>



<dt>Exemple de fichier YAML de valeur confidentielle pour l'authentification unidirectionnelle</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadata:
  name: &lt;secret_name&gt;
type: Opaque
data:
  trusted.crt: &lt;certificate_name&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Remplacez <em>&lt;secret_name&gt;</em> par le nom de la ressource de valeur confidentielle.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Remplacez la valeur suivante :<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code> : Entrez le nom du certificat digne de confiance.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>

<dt>Exemple de fichier YAML de valeur confidentielle pour l'authentification mutuelle</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadata:
  name: &lt;secret_name&gt;
type: Opaque
data:
  trusted.crt : &lt;certificate_name&gt;
    client.crt : &lt;client_certificate_name&gt;
    client.key : &lt;certificate_key&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Remplacez <em>&lt;secret_name&gt;</em> par le nom de la ressource de valeur confidentielle.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code> : Entrez le nom du certificat digne de confiance.</li>
  <li><code><em>&lt;client_certificate_name&gt;</em></code> : Entrez le nom du certificat client.</li>
  <li><code><em>&lt;certificate_key&gt;</em></code> : Entrez la clé du certificat client.</li></ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />



## Ports TCP pour les contrôleurs Ingress (tcp-ports)
{: #tcp-ports}

Accédez à une application via un port TCP non standard.
{:shortdesc}

<dl>
<dt>Description</dt>
<dd>
Utiliser cette annotation pour une application qui s'exécute sur une charge de travail de flux TCP.

<p>**Remarque** : le contrôleur Ingress fonctionne en mode relais et réachemine le trafic vers les applications de back end. La terminaison SSL n'est pas prise en charge dans ce cas.</p>
</dd>


 <dt>Exemple de fichier YAML de ressource Ingress</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/tcp-ports: "serviceName=&lt;service_name&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
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
  <td><code>annotations</code></td>
  <td>Remplacez les valeurs suivantes :<ul>
  <li><code><em>&lt;ingressPort&gt;</em></code> : Port TCP par lequel vous voulez accéder à votre application.</li>
  <li><code><em>&lt;serviceName&gt;</em></code> : Nom du service Kubernetes auquel accéder via un port TCP non standard.</li>
  <li><code><em>&lt;servicePort&gt;</em></code> : Ce paramètre est facultatif. Lorsqu'il est fourni, le port est remplacé par cette valeur avant l'envoi du trafic à l'application de back end. Sinon, le port est identique au port Ingress.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


  ## Signal de présence en amont (upstream-keepalive)
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
      ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;service_name&gt; keepalive=&lt;max_connections&gt;"
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
    <td><code>annotations</code></td>
    <td>Remplacez les valeurs suivantes :<ul>
    <li><code><em>&lt;serviceName&gt;</em></code> : Remplacez <em>&lt;service_name&gt;</em> par le nom du service Kubernetes que vous avez créé pour votre application. </li>
    <li><code><em>&lt;keepalive&gt;</em></code> : Remplacez <em>&lt;max_connections&gt;</em> par le nombre maximum de connexions de signal de présence inactives au serveur en amont. La valeur par défaut est 64. Une valeur zéro désactive les connexions de signal de présence inactives pour le service spécifié.</li>
    </ul>
    </td>
    </tr>
    </tbody></table>
    </dd>
    </dl>


