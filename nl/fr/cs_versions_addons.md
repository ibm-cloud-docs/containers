---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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

Lorsque le module complémentaire ALB Ingress est mis à jour, les conteneurs `nginx-ingress` et `ingress-auth` figurant dans tous les pods d'ALB sont mis à jour à la dernière version. Par défaut, les mises à jour automatiques du module complémentaire sont activées mais vous pouvez les désactiver pour effectuer la mise à jour du module manuellement. Pour plus d'informations, voir la section sur la [mise à jour de l'équilibreur de charge d'application (ALB) Ingress](cs_cluster_update.html#alb).

Consultez le tableau suivant pour obtenir un récapitulatif des modifications de chaque version du module complémentaire ALB Ingress.

<table summary="Présentation des modifications de version du module complémentaire de l'équilibreur de charge d'application (ALB) Ingress">
<caption>Journal des modifications du module complémentaire de l'équilibreur de charge d'application Ingress</caption>
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
<td>393 / 282</td>
<td>29 nov. 2018</td>
<td>Amélioration des performances d'{{site.data.keyword.appid_full}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 nov. 2018</td>
<td>Amélioration des fonctions de connexion et de déconnexion d'{{site.data.keyword.appid_full}}.</td>
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
