---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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



# Journal des modifications des modules complémentaires de cluster

Votre cluster {{site.data.keyword.containerlong}} est fourni avec des modules complémentaires qui sont automatiquement mis à jour par IBM. Vous pouvez également désactiver les mises à jour automatiques pour certains modules complémentaires pour effectuer leur mise à jour manuellement indépendamment du maître et des noeuds worker. Consultez les tableaux des sections suivantes pour obtenir un récapitulatif des modifications de chaque version.
{: shortdesc}

## Journal des modifications du module complémentaire d'équilibreur de charge d'application (ALB) Ingress
{: #alb_changelog}

Affichage des modifications de version pour le module d'équilibreur de charge d'application (ALB) Ingress dans vos clusters {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Lorsque le module complémentaire ALB Ingress est mis à jour, les conteneurs `nginx-ingress` et `ingress-auth` figurant dans tous les pods d'ALB sont mis à jour à la dernière version. Par défaut, les mises à jour automatiques du module complémentaire sont activées mais vous pouvez les désactiver pour effectuer la mise à jour du module manuellement. Pour plus d'informations, voir la section sur la [mise à jour de l'équilibreur de charge d'application (ALB) Ingress](/docs/containers?topic=containers-update#alb).

Consultez le tableau suivant pour obtenir un récapitulatif des modifications de chaque version du module complémentaire ALB Ingress.

<table summary="Présentation des modifications de version du module complémentaire de l'équilibreur de charge d'application (ALB) Ingress">
<caption>Journal des modifications du module complémentaire de l'équilibreur de charge d'application Ingress</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
<thead>
<tr>
<th>Version `nginx-ingress` / `ingress-auth`</th>
<th>Date de publication</th>
<th>Modifications sans interruption</th>
<th>Modifications nécessitant une interruption</th>
</tr>
</thead>
<tbody>
<tr>
<td>411 / 306</td>
<td>21 mars 2019</td>
<td>Mise à jour de la version Go à 1.12.1.</td>
<td>-</td>
</tr>
<tr>
<td>410 / 305</td>
<td>18 mars 2019</td>
<td><ul>
<li>Correction de vulnérabilités pour les analyses d'image.</li>
<li>Amélioration de la fonction de consignation pour {{site.data.keyword.appid_full}}.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408 / 304</td>
<td>5 mars 2019</td>
<td>-</td>
<td>Correction de bogues dans l'intégration d'autorisation concernant la fonctionnalité de déconnexion, l'expiration de jeton et le rappel d'autorisation `OAuth`. Ces corrections sont appliquées uniquement si vous avez activé l'autorisation {{site.data.keyword.appid_full_notm}} en utilisant l'annotation [`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth). Pour implémenter ces corrections, des en-têtes supplémentaires sont ajoutés, ce qui augmente la taille totale des en-têtes. En fonction de la taille de vos propres en-têtes et de la taille totale des réponses, il vous faudra peut-être ajuster les [annotations de mémoire tampon de proxy](/docs/containers?topic=containers-ingress_annotation#proxy-buffer) que vous utilisez.</td>
</tr>
<tr>
<td>406 / 301</td>
<td>19 fév. 2019</td>
<td><ul>
<li>Mise à jour de la version Go à 1.11.5.</li>
<li>Correction de vulnérabilités pour les analyses d'image.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>404 / 300</td>
<td>31 jan. 2019</td>
<td>Mise à jour de la version Go à 1.11.4.</td>
<td>-</td>
</tr>
<tr>
<td>403 / 295</td>
<td>23 jan. 2019</td>
<td><ul>
<li>Mise à jour de la version NGINX des équilibreurs de charge d'application (ALB) à 1.15.2.</li>
<li>Les certificats TLS fournis par IBM sont désormais renouvelés 37 jours avant leur date d'expiration et non plus 7 jours avant.</li>
<li>Ajout de la fonctionnalité de déconnexion {{site.data.keyword.appid_full_notm}} : si le préfixe `/logout` figure dans un chemin {{site.data.keyword.appid_full_notm}}, les cookies sont supprimés et l'utilisateur est redirigé vers la page de connexion.</li>
<li>Ajout d'un en-tête aux demandes {{site.data.keyword.appid_full_notm}} pour assurer un suivi interne.</li>
<li>Ajout de la directive d'emplacement {{site.data.keyword.appid_short_notm}} pour pouvoir utiliser l'annotation `app-id` avec les annotations `proxy-buffers`, `proxy-buffer-size` et `proxy-busy-buffer-size`.</li>
<li>Correction d'un bogue pour que les journaux d'information ne soient pas labellisés comme des erreurs.</li>
</ul></td>
<td>Désactivation de TLS 1.0 et 1.1 par défaut. Si les clients qui se connectent à vos applications prennent en charge TLS 1.2, aucune action n'est requise. Si vous avez toujours des clients qui nécessitent la prise en charge de TLS 1.0 ou 1.1, activez manuellement les versions TLS requises en suivant [ces étapes](/docs/containers?topic=containers-ingress#ssl_protocols_ciphers). Pour plus d'informations sur l'affichage des versions TLS utilisées par vos clients pour accéder à vos applications, voir cet [article du blogue {{site.data.keyword.Bluemix_notm}}](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).</td>
</tr>
<tr>
<td>393 / 291</td>
<td>9 jan. 2019</td>
<td>Ajout de la prise en charge d'instances multiples d'{{site.data.keyword.appid_full_notm}}.</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>29 nov. 2018</td>
<td>Amélioration des performances d'{{site.data.keyword.appid_full_notm}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 nov. 2018</td>
<td>Amélioration des fonctions de connexion et de déconnexion d'{{site.data.keyword.appid_full_notm}}.</td>
<td>Le certificat autosigné pour `*.containers.mybluemix.net` est remplacé par le certificat signé LetsEncrypt automatiquement généré et utilisé par le cluster. Le certificat autosigné `*.containers.mybluemix.net` est retiré.</td>
</tr>
<tr>
<td>350 / 192</td>
<td>5 nov. 2018</td>
<td>Prise en charge de l'activation et de la désactivation des mises à jour automatiques pour le module complémentaire ALB Ingress.</td>
<td>-</td>
</tr>
</tbody>
</table>
