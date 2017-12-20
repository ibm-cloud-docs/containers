---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Régions et emplacements
{{site.data.keyword.Bluemix}} est présent dans le monde entier. Une région est un lieu géographique auquel accède un noeud final. Les emplacements sont des centres de données figurant dans la région. Les services au sein de {{site.data.keyword.Bluemix_notm}} peuvent être disponibles partout ou dans une région spécifique.
{:shortdesc}

[Les régions {{site.data.keyword.Bluemix_notm}}](#bluemix_regions) sont différentes des régions [{{site.data.keyword.containershort_notm}}](#container_regions).

![{{site.data.keyword.containershort_notm}} régions et centres de données](/images/regions.png)

Figure 1. Régions et centres de données {{site.data.keyword.containershort_notm}}

Régions {{site.data.keyword.containershort_notm}} prises en charge :
  * Asie-Pacifique nord
  * Asie-Pacifique sud
  * Europe centrale
  * Sud du Royaume-Uni
  * Est des Etats-Unis
  * Sud des Etats-Unis

Vous pouvez créer des clusters légers Kubernetes dans les régions suivantes :
  * Asie-Pacifique sud
  * Europe centrale
  * Sud du Royaume-Uni
  * Sud des Etats-Unis

  **Remarque** : si vous n'êtes pas un client ayant payé, vous ne pouvez pas créer de clusters légers dan la région Sud des Etats-Unis.


## Noeuds finaux d'API de régions {{site.data.keyword.Bluemix_notm}}
{: #bluemix_regions}

Vous pouvez organisez vos ressources entre les services {{site.data.keyword.Bluemix_notm}} en utilisant des régions {{site.data.keyword.Bluemix_notm}}. Par exemple, vous pouvez créer un cluster Kubernetes en utilisant une image Docker privée stockée dans le service {{site.data.keyword.registryshort_notm}} de la même région.
{:shortdesc}

Pour vérifier dans quelle région {{site.data.keyword.Bluemix_notm}} vous vous trouvez, exécutez la commande `bx info` et consultez la zone **Region**.

Vous pouvez accéder aux régions {{site.data.keyword.Bluemix_notm}} en spécifiant le noeud final d'API utilisé lorsque vous vous êtes connecté. Si vous ne spécifiez pas de région, vous êtes automatiquement connecté à la région la plus proche de vous.

Noeuds finaux d'API des régions {{site.data.keyword.Bluemix_notm}} avec des exemples de commandes de connexion :

  * Sud et Est des Etats-Unis
      ```
      bx login -a api.ng.bluemix.net
      ```
      {: pre}

  * Sydney et Asie-Pacifique nord
      ```
      bx login -a api.au-syd.bluemix.net
      ```
      {: pre}

  * Allemagne
      ```
      bx login -a api.eu-de.bluemix.net
      ```
      {: pre}

  * Royaume-Uni
      ```
      bx login -a api.eu-gb.bluemix.net
      ```
      {: pre}



<br />


## Noeuds finaux d'API et emplacements des régions {{site.data.keyword.containershort_notm}}
{: #container_regions}

En utilisant des régions {{site.data.keyword.containershort_notm}}, vous pouvez créer des clusters  Kubernetes ou y accéder dans une région différente de la région {{site.data.keyword.Bluemix_notm}} où vous êtes connecté. Les noeuds finaux de régions {{site.data.keyword.containershort_notm}} se réfèrent spécifiquement au service {{site.data.keyword.containershort_notm}}, et non pas à {{site.data.keyword.Bluemix_notm}} dans son ensemble.
{:shortdesc}

Noeuds finaux d'API de régions {{site.data.keyword.containershort_notm}} :
  * Asie-Pacifique nord : `https://ap-north.containers.bluemix.net`
  * Asie-Pacifique sud : `https://ap-south.containers.bluemix.net`
  * Europe centrale : `https://eu-central.containers.bluemix.net`
  * Sud du Royaume-Uni : `https://uk-south.containers.bluemix.net`
  * Est des Etats-Unis : `https://us-east.containers.bluemix.net`
  * Sud des Etats-Unis : `https://us-south.containers.bluemix.net`

Pour vérifier dans quelle région {{site.data.keyword.containershort_notm}} vous vous trouvez, exécutez la commande `bx cs api` et consultez la zone **Region**.

### Connexion à une autre région du service de conteneur
{: #container_login_endpoints}

Vous souhaiterez peut-être vous connecter à une autre région {{site.data.keyword.containershort_notm}} pour les raisons suivantes :
  * Vous avez créé des services {{site.data.keyword.Bluemix_notm}} ou des images Docker privées dans une région et vous souhaitez les utiliser avec {{site.data.keyword.containershort_notm}} dans une autre région.
  * Vous souhaitez accéder à un cluster dans une région différente de la région {{site.data.keyword.Bluemix_notm}} par défaut à laquelle vous êtes connecté.

</br>

Exemples de commandes pour se connecter à une région {{site.data.keyword.containershort_notm}} :
  * Asie-Pacifique nord :
    ```
    bx cs init --host https://ap-north.containers.bluemix.net
    ```
  {: pre}

  * Asie-Pacifique sud :
    ```
    bx cs init --host https://ap-south.containers.bluemix.net
    ```
    {: pre}

  * Europe centrale :
    ```
    bx cs init --host https://eu-central.containers.bluemix.net
    ```
    {: pre}

  * Sud du Royaume-Uni :
    ```
    bx cs init --host https://uk-south.containers.bluemix.net
    ```
    {: pre}

  * Est des Etats-Unis :
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * Sud des Etats-Unis :
    ```
    bx cs init --host https://us-south.containers.bluemix.net
    ```
    {: pre}


### Emplacements disponibles pour le service de conteneur
{: #locations}

Les emplacements sont des centres de données disponibles dans une région.

  | Région | Emplacement | Ville |
  |--------|----------|------|
  | Asie-Pacifique nord | hkg02, tok02 | Hong Kong, Tokyo |
  | Asie-Pacifique sud     | mel01, syd01, syd04        | Melbourne, Sydney |
  | Europe centrale     | ams03, fra02, par01        | Amsterdam, Frankfort, Paris |
  | Sud du Royaume-Uni      | lon02, lon04         | Londres |
  | Est des Etats-Unis      | tor01, wdc06, wdc07        | Toronto, Washington, DC |
  | Sud des Etats-Unis     | dal10, dal12, dal13       | Dallas |

### Utilisation des commandes d'API du service de conteneur
{: #container_api}

Pour interagir avec l'API {{site.data.keyword.containershort_notm}}, entrez le type de commande et ajoutez `/v1/command` au noeud final.

Exemple d'API `GET /clusters` au Sud des Etats-Unis :
  ```
  GET https://us-south.containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

Pour consulter la documentation sur les commandes d'API, ajoutez `swagger-api` au noeud final correspondant à la région à afficher.
  * Asie-Pacifique nord : https://ap-north.containers.bluemix.net/swagger-api/
  * Asie-Pacifique sud : https://ap-south.containers.bluemix.net/swagger-api/
  * Europe centrale : https://eu-central.containers.bluemix.net/swagger-api/
  * Sud du Royaume-Uni : https://uk-south.containers.bluemix.net/swagger-api/
  * Est des Etats-Unis : https://us-east.containers.bluemix.net/swagger-api/
  * Sud des Etats-Unis : https://us-south.containers.bluemix.net/swagger-api/
