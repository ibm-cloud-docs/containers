---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

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


# Régions et zones
{: #regions-and-zones}

Une région est un emplacement géographique spécifique dans lequel vous pouvez déployer des applications, des services et d'autres ressources {{site.data.keyword.Bluemix}}. [Les régions {{site.data.keyword.Bluemix_notm}}](#bluemix_regions) sont différentes des [régions {{site.data.keyword.containerlong}}](#container_regions). Les régions se composent d'une ou de plusieurs zones, lesquelles correspondent à des centres de données physiques qui hébergent les ressources de calcul, les ressources réseau et les ressources de stockage, ainsi que les systèmes de refroidissement et les appareils électriques hébergeant les services et les applications. Les zones sont isolées les unes des autres pour garantir qu'aucun point de défaillance unique ne sera partagé.
{:shortdesc}

![Régions et zones {{site.data.keyword.containerlong_notm}}](images/regions-mz.png)

_Régions et zones {{site.data.keyword.containerlong_notm}}_

 {{site.data.keyword.Bluemix_notm}} est présent dans le monde entier. Les services au sein d'{{site.data.keyword.Bluemix_notm}} peuvent être disponibles partout ou dans une région spécifique. Lorsque vous créez un cluster Kubernetes dans {{site.data.keyword.containerlong_notm}}, ses ressources restent dans la région dans laquelle vous avez déployé le cluster.

 Vous pouvez créer des clusters standard dans toutes les régions {{site.data.keyword.containerlong_notm}} prises en charge. Les clusters gratuits ne sont disponibles que dans certaines régions.
{: note}

 | Région {{site.data.keyword.containerlong_notm}} | Emplacement {{site.data.keyword.Bluemix_notm}} correspondant |
| --- | --- |
| Asie-Pacifique nord (clusters standard uniquement) | Tokyo |
| Asie-Pacifique sud | Sydney |
| Europe centrale | Francfort |
| Sud du Royaume-Uni | Londres |
| Est des Etats-Unis (clusters standard uniquement) | Washington DC |
| Sud des Etats-Unis | Dallas |
{: caption="Régions de Kubernetes Service prises en charge et emplacements IBM Cloud correspondants." caption-side="top"}

 <br />


## Emplacements dans {{site.data.keyword.Bluemix_notm}}
{: #bluemix_regions}

Vous pouvez organiser vos ressources entre les services {{site.data.keyword.Bluemix_notm}} en utilisant des emplacements {{site.data.keyword.Bluemix_notm}}, également appelés régions. Par exemple, vous pouvez créer un cluster Kubernetes en utilisant une image Docker privée stockée dans le service {{site.data.keyword.registryshort_notm}} au même emplacement.
{:shortdesc}

Vous pouvez spécifier une région {{site.data.keyword.Bluemix_notm}} lorsque vous vous connectez au noeud final d'API global. Pour afficher la liste des régions disponibles, exécutez la commande `ibmcloud regions`. Pour vérifier à quel emplacement {{site.data.keyword.Bluemix_notm}} vous vous trouvez, exécutez la commande `ibmcloud target` et consultez la zone **Region**. Si vous n'indiquez pas de région, vous êtes invité à en sélectionner une.

Par exemple, pour vous connecter au noeud final d'API global dans la région de Dallas (`us-south`) :
```
ibmcloud login -a https://cloud.ibm.com -r us-south
```
{: pre}

Pour vous connecter au noeud final d'API global et sélectionner une région :
```
ibmcloud login -a https://cloud.ibm.com
```
{: pre}

Exemple de sortie :
```
API endpoint: cloud.ibm.com

Get One Time Code from https://identity-2.eu-central.iam.cloud.ibm.com/identity/passcode to proceed.
Open the URL in the default browser? [Y/n]> y
One Time Code > 
Authenticating...
OK

Select an account:
1. MyAccount (00a11aa1a11aa11a1111a1111aaa11aa) <-> 1234567
2. TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321
Enter a number> 2
Targeted account TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321


Targeted resource group default

Select a region (or press enter to skip):
1. au-syd
2. jp-tok
3. eu-de
4. eu-gb
5. us-south
6. us-east
Enter a number> 5
Targeted region us-south


API endpoint:      https://cloud.ibm.com   
Region:            us-south   
User:              first.last@email.com   
Account:           TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321  
Resource group:    default   
CF API endpoint:      
Org:                  
Space:                

...
```
{: screen}

<br />


## Régions dans {{site.data.keyword.containerlong_notm}}
{: #container_regions}

En utilisant des régions {{site.data.keyword.containerlong_notm}}, vous pouvez créer des clusters  Kubernetes ou y accéder dans une région différente de la région {{site.data.keyword.Bluemix_notm}} où vous êtes connecté. Les noeuds finaux de régions {{site.data.keyword.containerlong_notm}} se réfèrent spécifiquement au service {{site.data.keyword.containerlong_notm}}, et non pas à {{site.data.keyword.Bluemix_notm}} dans son ensemble.
{:shortdesc}

Vous pouvez créer des clusters standard dans toutes les régions {{site.data.keyword.containerlong_notm}} prises en charge. Les clusters gratuits ne sont disponibles que dans certaines régions.
{: note}

 Régions {{site.data.keyword.containerlong_notm}} prises en charge :
  * Asie-Pacifique nord (clusters standard uniquement)
  * Asie-Pacifique sud
  * Europe centrale
  * Sud du Royaume-Uni
  * Est des Etats-Unis (clusters standard uniquement)
  * Sud des Etats-Unis

Vous pouvez accéder à {{site.data.keyword.containerlong_notm}} via un noeud final global : `https://containers.cloud.ibm.com/v1`.
* Pour vérifier dans quelle région {{site.data.keyword.containerlong_notm}} vous vous trouvez actuellement,  exécutez la commande `ibmcloud ks region`.
* Pour extraire la liste des régions disponibles et de leurs noeuds finaux, exécutez la commande `ibmcloud ks regions`.

Pour utiliser l'API avec le noeud final global, dans toutes vos demandes, transmettez le nom de région dans l'en-tête `X-Region`.
{: tip}

### Connexion à une autre région d'{{site.data.keyword.containerlong_notm}}
{: #container_login_endpoints}

Vous pouvez changer de région en utilisant l'interface de ligne de commande (CLI) d'{{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Vous souhaiterez peut-être vous connecter à une autre région {{site.data.keyword.containerlong_notm}} pour les raisons suivantes :
  * Vous avez créé des services {{site.data.keyword.Bluemix_notm}} ou des images Docker privées dans une région et vous souhaitez les utiliser avec {{site.data.keyword.containerlong_notm}} dans une autre région.
  * Vous souhaitez accéder à un cluster dans une région différente de la région {{site.data.keyword.Bluemix_notm}} par défaut à laquelle vous êtes connecté.

Pour basculer rapidement d'une région à une autre, exécutez la commande [`ibmcloud ks region-set`](/docs/containers?topic=containers-cs_cli_reference#cs_region-set).

### Utilisation des commandes d'API {{site.data.keyword.containerlong_notm}}
{: #containers_api}

Pour interagir avec l'API {{site.data.keyword.containerlong_notm}}, entrez le type de commande et ajoutez `/v1/command` au noeud final global.
{:shortdesc}

 Exemple d'API `GET /clusters` :
  ```
  GET https://containers.cloud.ibm.com/v1/clusters
  ```
  {: codeblock}

 </br>

Pour utiliser l'API avec le noeud final global, dans toutes vos demandes, transmettez le nom de région dans l'en-tête `X-Region`. Pour afficher la liste des régions disponibles, exécutez la commande `ibmcloud ks regions`.
{: tip}

Pour afficher la documentation sur les commandes d'API, accédez à [https://containers.cloud.ibm.com/swagger-api/](https://containers.cloud.ibm.com/swagger-api/).

## Zones dans {{site.data.keyword.containerlong_notm}}
{: #zones}

Les zones sont des centres de données physiques disponibles au sein d'une région {{site.data.keyword.Bluemix_notm}}. Les régions constituent un outil conceptuel permettant d'organiser les zones et peuvent inclure des zones (centres de données) dans différents pays. Le tableau suivant affiche les zones disponibles par région.
{:shortdesc}

* **Agglomération à zones multiples** : si vous créez un cluster dans une agglomération à zones multiples, les répliques de votre maître Kubernetes à haute disponibilité sont automatiquement réparties entre les différentes zones. Vous avez la possibilité de répartir vos noeuds worker entre les zones pour protéger vos applications en cas de défaillance d'une zone.
* **Emplacement à zone unique** : si vous créez un cluster dans un emplacement à zone unique, vous pouvez créer plusieurs noeuds worker, mais vous ne pouvez pas les répartir sur plusieurs zones. Le maître à haute disponibilité comprend trois répliques sur des hôtes distincts, mais n'est pas réparti entre les zones.

<table summary="Le tableau présente les zones disponibles par régions. La lecture des lignes s'effectue de gauche à droite, avec la région dans la première colonne, les agglomérations à zones multiples dans la deuxième colonne et les emplacements à zone unique dans la troisième colonne.">
<caption>Zones uniques et zones multiples disponibles par région.</caption>
  <thead>
  <th>Région</th>
  <th>Agglomération à zones multiples</th>
  <th>Agglomération à zone unique</th>
  </thead>
  <tbody>
    <tr>
      <td>Asie-Pacifique nord</td>
      <td>Tokyo : tok02, tok04, tok05</td>
      <td><p>Chennai : che01</p>
      <p>Hong Kong (région administrative spéciale) de la République populaire de Chine : hkg02</p>
      <p>Séoul : seo01</p>
      <p>Singapour : sng01</p></td>
    </tr>
    <tr>
      <td>Asie-Pacifique sud</td>
      <td>Sydney : syd01, syd04, syd05</td>
      <td>Melbourne : mel01</td>
    </tr>
    <tr>
      <td>Europe centrale</td>
      <td>Francfort : fra02, fra04, fra05</td>
      <td><p>Amsterdam : ams03</p>
      <p>Milan : mil01</p>
      <p>Oslo : osl01</p>
      <p>Paris : par01</p>
      </td>
    </tr>
    <tr>
      <td>Sud du Royaume-Uni</td>
      <td>Londres : lon04, lon05`*`, lon06</td>
      <td></td>
    </tr>
    <tr>
      <td>Est des Etats-Unis</td>
      <td>Washington DC : wdc04, wdc06, wdc07</td>
      <td><p>Montréal : mon01</p>
      <p>Toronto : tor01</p></td>
    </tr>
    <tr>
      <td>Sud des Etats-Unis</td>
      <td>Dallas : dal10, dal12, dal13</td>
      <td><p>Mexico : mex01</p><p>San José : sjc03, sjc04</p><p>São Paulo : sao01</p></td>
    </tr>
  </tbody>
</table>

`*` lon05 remplace lon02. Les nouveaux clusters doivent utiliser lon05, et les maîtres à haute disponibilité répartis entre les zones ne sont pris en charge que dans lon05.
{: note}

### Clusters à zone unique
{: #regions_single_zone}

Les ressources de votre cluster restent dans la zone dans laquelle est déployé le cluster. L'image suivante met en évidence les relations entre les composants d'un cluster à zone unique dans la région Est des Etats-Unis :

<img src="/images/region-cluster-resources.png" width="650" alt="Comprendre où résident les ressources de votre cluster" style="width:650px; border-style: none"/>

_Comprendre où résident les ressources de votre cluster à zone unique._

1.  Les ressources de votre cluster, notamment le maître et les noeuds worker, sont situées dans la même zone dans laquelle vous avez déployé le cluster. Lorsque vous initiez des actions d'orchestration de conteneurs locaux, par exemple des commandes `kubectl`, les informations s'échangent entre le maître et vos noeuds worker dans la même zone.

2.  Si vous configurez d'autres ressources de cluster, par exemple du stockage, des ressources réseau, du calcul ou des applications qui s'exécutent dans des pods, les ressources et leurs données restent dans la zone dans laquelle vous avez déployé votre cluster.

3.  Lorsque vous initiez des actions de gestion de cluster, par exemple l'exécution de commandes `ibmcloud ks`, les informations de base sur le cluster (par exemple le nom, l'ID, l'utilisateur, la commande) sont acheminées via un noeud final régional.

### Clusters à zones multiples
{: #regions_multizone}

Dans un cluster à zones multiples, le noeud maître est déployé dans une zone compatible avec plusieurs zones et les ressources de votre cluster sont réparties sur plusieurs zones.

1.  Les noeuds worker sont répartis sur plusieurs zones d'une région pour offrir une plus grande disponibilité à votre cluster. Le maître reste dans la zone compatible avec plusieurs zones dans laquelle vous avez déployé le cluster. Lorsque vous initiez des actions d'orchestration de conteneurs locaux, par exemple avec des commandes `kubectl`, les informations s'échangent entre le maître et vos noeuds worker via un noeud final régional.

2.  D'autres ressources de cluster, comme par exemple du stockage, des ressources réseau, du calcul ou des applications s'exécutant dans des pods, varient par leur manière de se déployer dans les zones de votre cluster à zones multiples. Pour plus d'informations, consultez les rubriques suivantes :
  * Configuration de [stockage de fichiers](/docs/containers?topic=containers-file_storage#add_file) et de [stockage par blocs](/docs/containers?topic=containers-block_storage#add_block) dans les clusters à zones multiples
  * [Activation de l'accès public ou privé à une application à l'aide d'un service LoadBalancer dans un cluster à zones multiples](/docs/containers?topic=containers-loadbalancer#multi_zone_config)
  * [Gestion de trafic réseau à l'aide d'Ingress](/docs/containers?topic=containers-ingress#planning)
  * [Augmentation de la disponibilité de votre application](/docs/containers?topic=containers-app#increase_availability)

3.  Lorsque vous initiez des actions de gestion de cluster, par exemple l'exécution de [commandes `ibmcloud ks`](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference), les informations de base sur le cluster (par exemple le nom, l'ID, l'utilisateur, la commande) sont acheminées via un noeud final régional.




