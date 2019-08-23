---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb, health check, dns, host name

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


# Enregistrement d'un nom d'hôte d'équilibreur de charge de réseau
{: #loadbalancer_hostname}

Après avoir configuré des équilibreurs de charge de réseau, vous pouvez à présent créer des entrées DNS pour les adresses IP NLB en créant des noms d'hôte. Vous pouvez également configurer des moniteurs TCP/HTTP(S) afin d'effectuer un diagnostic d'intégrité des adresses IP NLB derrière chaque nom d'hôte.
{: shortdesc}

<dl>
<dt>Nom d'hôte</dt>
<dd>Lorsque vous créez un équilibreur de charge de réseau public dans un cluster à zone unique ou à zones multiples, vous pouvez exposer votre application sur Internet en créant un nom d'hôte pour l'adresse IP NLB. En outre, {{site.data.keyword.cloud_notm}} se charge de générer et gérer le certificat SSL d'assistant pour le nom d'hôte.
<p>Dans les clusters à zones multiples, vous pouvez créer un nom d'hôte et ajouter l'adresse IP NLB de chaque zone à cette entrée DNS de nom d'hôte. Par exemple, si vous avez déployé des équilibreurs de charge de réseau pour votre application dans trois zones dans la région Sud des Etats-Unis, vous pouvez créer le nom d'hôte `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` pour les trois adresses IP NLB. Lorsqu'un utilisateur accède à votre nom d'hôte d'application, le client accède à l'une de ces adresses IP de manière aléatoire et la demande est envoyée à cet équilibreur de charge de réseau.</p>
Notez que vous ne pouvez pas créer de noms d'hôte pour des équilibreurs de charge de réseau privés.</dd>
<dt>Moniteur de diagnostic d'intégrité</dt>
<dd>Activez des diagnostics d'intégrité sur les adresses IP NLB situées derrière un nom d'hôte unique afin de déterminer si elles sont disponibles ou non. Lorsque vous activez un moniteur pour votre nom d'hôte, il réalise un diagnostic d'intégrité de l'adresse IP NLB et tient à jour les résultats de recherche DNS en fonction de ces diagnostics d'intégrité. Par exemple, si vos équilibreurs de charge de réseau ont les adresses IP `1.1.1.1`, `2.2.2.2` et `3.3.3.3`, une opération normale de recherche DNS de votre nom d'hôte renvoie ces trois adresses IP, dont 1 est accessible au client de manière aléatoire. Si l'équilibreur de charge de réseau avec l'adresse IP `3.3.3.3` devient indisponible pour une raison quelconque, par exemple en cas de défaillance d'une zone, le diagnostic d'intégrité correspondant à cette adresse IP échoue, le moniteur retire du nom d'hôte l'adresse IP ayant échoué et la recherche DNS renvoie uniquement les adresses IP `1.1.1.1` et `2.2.2.2` qui sont saines.</dd>
</dl>

Vous pouvez voir tous les noms d'hôte qui sont enregistrés pour les adresses IP d'équilibreur de charge de réseau dans votre cluster en exécutant la commande suivante :
```
ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
```
{: pre}

</br>

## Enregistrement d'adresses IP NLB avec un nom d'hôte DNS
{: #loadbalancer_hostname_dns}

Exposez votre application au public sur Internet en créant un nom d'hôte pour l'adresse IP NLB.
{: shortdesc}

Avant de commencer :
* Passez en revue les remarques et limitations suivantes.
  * Vous pouvez créer des noms d'hôte pour les équilibreurs de charge de réseau 1.0 et 2.0.
  * Vous ne pouvez pas créer de noms d'hôte pour des équilibreurs de charge de réseau privés.
  * Vous pouvez enregistrer jusqu'à 128 noms d'hôte. Cette limite peut être levée sur demande en ouvrant un [cas de support](/docs/get-support?topic=get-support-getting-customer-support).
* [Créez un équilibreur de charge de réseau pour votre application dans un cluster à zone unique](/docs/containers?topic=containers-loadbalancer#lb_config) ou [créez des équilibreurs de charge de réseau dans chaque zone d'un cluster à zones multiples](/docs/containers?topic=containers-loadbalancer#multi_zone_config).

Pour créer un nom d'hôte pour une ou plusieurs adresses IP NLB :

1. Procurez-vous l'adresse **EXTERNAL-IP** de votre équilibreur de charge de réseau. Si vous avez des équilibreurs de charge de réseau dans chaque zone d'un cluster à zones multiples qui exposent une application, procurez-vous les adresses IP pour chaque équilibreur de charge de réseau.
  ```
  kubectl get svc
  ```
  {: pre}

  Dans l'exemple de sortie suivant, les adresses **EXTERNAL-IP** des équilibreurs de charge de réseau sont `168.2.4.5` et `88.2.4.5`.
  ```
  NAME             TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)                AGE
  lb-myapp-dal10   LoadBalancer   172.21.xxx.xxx   168.2.4.5         1883:30303/TCP         6d
  lb-myapp-dal12   LoadBalancer   172.21.xxx.xxx   88.2.4.5          1883:31303/TCP         6d
  ```
  {: screen}

2. Enregistrez l'adresse IP en créant un nom d'hôte DNS. Notez que vous pouvez initialement créer le nom d'hôte avec une seule adresse IP.
  ```
  ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <NLB_IP>
  ```
  {: pre}

3. Vérifiez que le nom d'hôte est créé.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Exemple de sortie :
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.2.4.5"]      None             created                   <certificate>
  ```
  {: screen}

4. Si vous avez des équilibreurs de charge de réseau dans chaque zone d'un cluster à zones multiples qui exposent une application, ajoutez les adresses IP des autres équilibreurs de charge de réseau au nom d'hôte. Notez que vous devez exécuter la commande suivante pour chaque adresse IP que vous souhaitez ajouter. 
  ```
  ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
  ```
  {: pre}

5. Facultatif : vérifiez que les adresses IP sont enregistrés avec votre nom d'hôte en exécutant une commande `host` ou `ns lookup`.
  Exemple de commande :
  ```
  host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
  ```
  {: pre}

  Exemple de sortie :
  ```
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 88.2.4.5  
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 168.2.4.5
  ```
  {: screen}

6. Dans un navigateur Web, entrez l'URL permettant d'accéder à votre application via le nom d'hôte que vous avez créé.

Vous pouvez ensuite [activer les diagnostics d'intégrité sur le nom d'hôte en créant un moniteur d'état](#loadbalancer_hostname_monitor).

</br>

## Description du format pour le nom d'hôte
{: #loadbalancer_hostname_format}

Les noms d'hôte pour les équilibreurs de charge de réseau suivent le format `<cluster_name>-<globally_unique_account_HASH>-0001.<region>.containers.appdomain.cloud`.
{: shortdesc}

Par exemple, un nom d'hôte que vous créez pour un équilibreur de charge de réseau peut se présenter comme suit : `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud`. Le tableau suivant décrit chaque composant du nom d'hôte.

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description du format du nom d'hôte d'équilibreur de charge de réseau</th>
</thead>
<tbody>
<tr>
<td><code>&lt;cluster_name&gt;</code></td>
<td>Nom de votre cluster.
<ul><li>Si le nom du cluster comprend tout au plus 26 caractères, il est entièrement inclus sans être modifié : <code>myclustername</code>.</li>
<li>Si le nom du cluster comprend au moins 26 caractères et s'il est unique dans cette région, seuls les 24 premiers caractères sont utilisés : <code>myveryverylongclusternam</code>.</li>
<li>Si le nom du cluster comprend au moins 26 caractères et s'il n'est pas unique dans cette région, seuls les 17 premiers caractères sont utilisés et un tiret suivi de six caractères aléatoires est ajouté : <code>myveryverylongclu-ABC123</code>. </li></ul>
</td>
</tr>
<tr>
<td><code>&lt;globally_unique_account_HASH&gt;</code></td>
<td>Une valeur de hachage unique globale est créée pour votre compte {{site.data.keyword.cloud_notm}}. Tous les noms d'hôte que vous créez pour des équilibreurs de charge de réseau dans des clusters dans votre compte utilisent cette valeur de hachage unique globale.</td>
</tr>
<tr>
<td><code>0001</code></td>
<td>
Le premier et le deuxième caractères, <code>00</code>, indiquent un nom d'hôte public. Le troisième et le quatrième caractères, par exemple, <code>01</code> ou un autre nombre, agissent en tant que compteur pour chaque nom d'hôte que vous créez.</td>
</tr>
<tr>
<td><code>&lt;region&gt;</code></td>
<td>Région dans laquelle le cluster est créé.</td>
</tr>
<tr>
<td><code>containers.appdomain.cloud</code></td>
<td>Sous-domaine pour les noms d'hôte {{site.data.keyword.containerlong_notm}}.</td>
</tr>
</tbody>
</table>

</br>

## Activation de diagnostics d'intégrité sur un nom d'hôte en créant un moniteur d'état
{: #loadbalancer_hostname_monitor}

Activez des diagnostics d'intégrité sur les adresses IP NLB situées derrière un nom d'hôte unique afin de déterminer si elles sont disponibles ou non.
{: shortdesc}

Avant de commencer, [enregistrez des adresses IP NLB avec un nom d'hôte DNS](#loadbalancer_hostname_dns).

1. Procurez-vous le nom de votre hôte. Dans la sortie, notez que l'**état** du moniteur pour l'hôte est `Unconfigured`.
  ```
  ibmcloud ks nlb-dns-monitor-ls --cluster <cluster_name_or_id>
  ```
  {: pre}

  Exemple de sortie :
  ```
  Hostname                                                                                   Status         Type    Port   Path
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud        Unconfigured   N/A     0      N/A
  ```
  {: screen}

2. Créez un moniteur de diagnostic d'intégrité pour le nom d'hôte. Si vous n'incluez pas de paramètre de configuration, la valeur par défaut est utilisée.
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --enable --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
  ```
  {: pre}

  <table>
  <caption>Description des composantes de cette commande</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
  </thead>
  <tbody>
  <tr>
  <td><code>--cluster &lt;cluster_name_or_ID&gt;</code></td>
  <td>Obligatoire : nom ou ID du cluster sur lequel le nom d'hôte est enregistré.</td>
  </tr>
  <tr>
  <td><code>--nlb-host &lt;host_name&gt;</code></td>
  <td>Obligatoire : Nom d'hôte pour lequel configurer un moniteur de diagnostic d'intégrité.</td>
  </tr>
  <tr>
  <td><code>--enable</code></td>
  <td>Obligatoire : Activez le moniteur de diagnostic d'intégrité pour le nom d'hôte.</td>
  </tr>
  <tr>
  <td><code>--description &lt;description&gt;</code></td>
  <td>Description du moniteur de diagnostic d'intégrité. </td>
  </tr>
  <tr>
  <td><code>--type &lt;type&gt;</code></td>
  <td>Protocole à utiliser pour le diagnostic d'intégrité : <code>HTTP</code>, <code>HTTPS</code> ou <code>TCP</code>. Valeur par défaut : <code>HTTP</code></td>
  </tr>
  <tr>
  <td><code>--method &lt;method&gt;</code></td>
  <td>Méthode à utiliser pour le diagnostic d'intégrité. Valeur par défaut pour <code>type</code> <code>HTTP</code> et <code>HTTPS</code> : <code>GET</code>. Valeur par défaut pour  <code>type</code> <code>TCP</code> : <code>connection_established</code>.</td>
  </tr>
  <tr>
  <td><code>--path &lt;path&gt;</code></td>
  <td>Lorsque <code>type</code> a pour valeur <code>HTTPS</code>, chemin de noeud final sur lequel doit porter le diagnostic d'intégrité. Valeur par défaut : <code>/</code></td>
  </tr>
  <tr>
  <td><code>--timeout &lt;timeout&gt;</code></td>
  <td>Délai d'attente, en secondes avant que l'adresse IP soit considérée comme défectueuse. Valeur par défaut : <code>5</code></td>
  </tr>
  <tr>
  <td><code>--retries &lt;retries&gt;</code></td>
  <td>Lorsqu'un dépassement de délai d'attente se produit, nombre de tentatives avant que l'adresse IP soit considérée comme défectueuse. Les nouvelles tentatives sont effectuées immédiatement. Valeur par défaut : <code>2</code></td>
  </tr>
  <tr>
  <td><code>--interval &lt;interval&gt;</code></td>
  <td>Intervalle, en secondes, entre chaque diagnostic d'intégrité. Des intervalles courts peuvent améliorer les temps de reprise, mais augmenter la charge sur les adresses IP. Valeur par défaut : <code>60</code></td>
  </tr>
  <tr>
  <td><code>--port &lt;port&gt;</code></td>
  <td>Numéro de port auquel établir une connexion pour le diagnostic d'intégrité. Lorsque <code>type</code> a pour valeur <code>TCP</code>, ce paramètre est obligatoire. Lorsque <code>type</code> a pour valeur <code>HTTP</code> ou <code>HTTPS</code>, définissez le port uniquement si vous utilisez un port autre que 80 pour HTTP ou 443 pour HTTPS. Valeur par défaut pour TCP : <code>0</code>. Valeur par défaut pour HTTP : <code>80</code>. Valeur par défaut pour HTTPS : <code>443</code>.</td>
  </tr>
  <tr>
  <td><code>--expected-body &lt;expected-body&gt;</code></td>
  <td>Lorsque <code>type</code> a pour valeur <code>HTTP</code> ou <code>HTTPS</code>, sous-chaîne non sensible à la casse que le diagnostic d'intégrité recherche dans le corps de la réponse. Si chaîne n'est pas trouvée, l'adresse IP est considérée comme défectueuse. </td>
  </tr>
  <tr>
  <td><code>--expected-codes &lt;expected-codes&gt;</code></td>
  <td>Lorsque <code>type</code> a pour valeur <code>HTTP</code> ou <code>HTTPS</code>, codes HTTP que le diagnostic d'intégrité recherche dans la réponse. Si le code HTTP est introuvable, l'adresse IP est considérée comme défectueuse. Valeur par défaut : <code>2xx</code></td>
  </tr>
  <tr>
  <td><code>--allows-insecure &lt;true&gt;</code></td>
  <td>Lorsque <code>type</code> a pour valeur <code>HTTP</code> ou <code>HTTPS</code>, affectez la valeur <code>true</code> pour ne pas valider le certificat.</td>
  </tr>
  <tr>
  <td><code>--follows-redirects &lt;true&gt;</code></td>
  <td>Lorsque <code>type</code> a pour valeur <code>HTTP</code> ou <code>HTTPS</code>, affectez la valeur <code>true</code> pour suivre les éventuelles redirections qui sont renvoyées par l'adresse IP. </td>
  </tr>
  </tbody>
  </table>

  Exemple de commande :
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --desc "Login page monitor" --type HTTPS --method GET --path / --timeout 5 --retries 2 --interval 60  --expected-body "healthy" --expected-codes 2xx --follows-redirects true
  ```
  {: pre}

3. Vérifiez que le moniteur de diagnostic d'intégrité est configuré avec les paramètres appropriés.
  ```
  ibmcloud ks nlb-dns-monitor-get --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Exemple de sortie :
  ```
  <placeholder - still want to test this one>
  ```
  {: screen}

4. Affichez l'état du diagnostic d'intégrité des adresses IP NLB situées derrière votre nom d'hôte.
  ```
  ibmcloud ks nlb-dns-monitor-status --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Exemple de sortie :
  ```
  Hostname                                                                                IP          Health Monitor   H.Monitor Status
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     168.2.4.5   Enabled          Healthy
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     88.2.4.5    Enabled          Healthy
  ```
  {: screen}

</br>

### Mise à jour et retrait d'adresses IP et de moniteurs dans les noms d'hôte
{: #loadbalancer_hostname_delete}

Vous pouvez ajouter et retirer des adresses IP NLB dans les noms d'hôte que vous avez générés. Vous pouvez également désactiver et activer les moniteurs de diagnostic d'intégrité pour les noms d'hôte si nécessaire.
{: shortdesc}

**Adresses IP d'équilibreur de charge de réseau**

Si vous ajoutez ultérieurement d'autres équilibreurs de charge de réseau dans d'autres zones de votre cluster pour exposer la même application, vous pouvez ajouter les adresses IP correspondantes pour le nom d'hôte existant. Notez que vous devez exécuter la commande suivante pour chaque adresse IP que vous souhaitez ajouter. 
```
ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
```
{: pre}

Vous pouvez également retirer les adresses IP d'équilibreur de charge de réseau qui ne doivent plus être enregistrées avec un nom d'hôte. Notez que vous devez exécuter la commande suivante pour chaque adresse IP que vous souhaitez retirer. Si vous retirez toutes les adresses IP d'un nom d'hôte, le nom d'hôte existe toujours mais aucune adresse IP ne lui est associée.
```
ibmcloud ks nlb-dns-rm --cluster <cluster_name_or_id> --ip <ip1,ip2> --nlb-host <host_name>
```
{: pre}

</br>

**Moniteurs de diagnostic d'intégrité**

Si vous devez modifier la configuration de votre moniteur d'état, vous pouvez modifier des paramètres spécifiques. Ajoutez uniquement les options des paramètres que vous souhaitez modifier.
```
ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
```
{: pre}

Vous pouvez désactiver le moniteur de diagnostic d'intégrité pour un nom d'hôte à tout moment en exécutant la commande suivante :
```
ibmcloud ks nlb-dns-monitor-disable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}

Pour réactiver un moniteur pour un nom d'hôte, exécutez la commande suivante :
```
ibmcloud ks nlb-dns-monitor-enable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}
