---

copyright:
  years: 2017, 2018
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


# Eventi {{site.data.keyword.cloudaccesstrailshort}}
{: #at_events}

Puoi visualizzare, gestire e controllare le attività avviate dall'utente nel tuo cluster {{site.data.keyword.containershort_notm}} utilizzando il servizio {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

## Ricerca delle informazioni
{: #at-find}

Gli eventi {{site.data.keyword.cloudaccesstrailshort}} sono disponibili nel **dominio account** {{site.data.keyword.cloudaccesstrailshort}} disponibile nella regione {{site.data.keyword.Bluemix_notm}} in cui sono stati generati gli eventi. Gli eventi {{site.data.keyword.cloudaccesstrailshort}} sono disponibili nel **dominio spazio** {{site.data.keyword.cloudaccesstrailshort}} associato allo spazio Cloud Foundry in cui è stato eseguito il provisioning del servizio {{site.data.keyword.cloudaccesstrailshort}}.

Per monitorare l'attività amministrativa:

1. Accedi al tuo account {{site.data.keyword.Bluemix_notm}}.
2. Dal catalogo, esegui il provisioning di un'istanza del servizio {{site.data.keyword.cloudaccesstrailshort}} nello stesso account della tua istanza di {{site.data.keyword.containershort_notm}}.
3. Sulla scheda **Gestisci** del dashboard {{site.data.keyword.cloudaccesstrailshort}}, fai clic su **Visualizza in Kibana**.
4. Imposta l'intervallo di tempo per il quale desideri visualizzare i log. Il valore predefinito è 15 minuti.
5. Nell'elenco **Campi disponibili**, fai clic su **type**. Fai clic sull'icona della lente di ingrandimento del **Programma di traccia dell'attività** per limitare i log a quelli tracciati dal servizio.
6. Puoi utilizzare gli altri campi disponibili per restringere la tua ricerca.



## Traccia degli eventi
{: #events}

Controlla le seguenti tabelle per un elenco degli eventi inviati a {{site.data.keyword.cloudaccesstrailshort}}.

Per ulteriori informazioni su come funziona il servizio, vedi la [documentazione di {{site.data.keyword.cloudaccesstrailshort}}](/docs/services/cloud-activity-tracker/index.html).

Per ulteriori informazioni sulle azioni Kubernetes che vengono tracciate, vedi la [documentazione Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/home/).

<table>
  <tr>
    <th>Azione</th>
    <th>Descrizione</th>
  </tr>
  <tr>
    <td><code>bindings.create</code></td>
    <td>È stato creato un bind.</td>
  </tr>
  <tr>
    <td><code>configmaps.create</code></td>
    <td>È stata creata una mappa di configurazione.</td>
  </tr>
  <tr>
    <td><code>configmaps.delete</code></td>
    <td>È stata eliminata una mappa di configurazione.</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>È stata corretta una mappa di configurazione.</td>
  </tr>
  <tr>
    <td><code>configmaps.update</code></td>
    <td>È stata aggiornata una mappa di configurazione.</td>
  </tr>
  <tr>
    <td><code>events.create</code></td>
    <td>È stato creato un evento.</td>
  </tr>
  <tr>
    <td><code>events.delete</code></td>
    <td>È stato eliminato un evento.</td>
  </tr>
  <tr>
    <td><code>events.patch</code></td>
    <td>È stato corretto un evento.</td>
  </tr>
  <tr>
    <td><code>events.update</code></td>
    <td>È stato aggiornato un evento.</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>È stato creato un limite di intervallo.</td>
  </tr>
  <tr>
    <td><code>limitranges.delete</code></td>
    <td>È stato eliminato un limite di intervallo.</td>
  </tr>
  <tr>
    <td><code>limitranges.patch</code></td>
    <td>È stato corretto un limite di intervallo.</td>
  </tr>
  <tr>
    <td><code>limitranges.update</code></td>
    <td>È stato aggiornato un limite di intervallo.</td>
  </tr>
  <tr>
    <td><code>namespaces.create</code></td>
    <td>È stato creato uno spazio dei nomi.</td>
  </tr>
  <tr>
    <td><code>namespaces.delete</code></td>
    <td>È stato eliminato uno spazio dei nomi.</td>
  </tr>
  <tr>
    <td><code>namespaces.patch</code></td>
    <td>È stato corretto uno spazio dei nomi.</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>È stato aggiornato uno spazio dei nomi.</td>
  </tr>
  <tr>
    <td><code>nodes.create</code></td>
    <td>È stato creato un nodo.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>È stato eliminato un nodo.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>È stato eliminato un nodo.</td>
  </tr>
  <tr>
    <td><code>nodes.patch</code></td>
    <td>È stato corretto un nodo.</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>È stato aggiornato un nodo.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.create</code></td>
    <td>È stata creata un'attestazione del volume persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.delete</code></td>
    <td>È stata eliminata un'attestazione del volume persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.patch</code></td>
    <td>È stata corretta un'attestazione del volume persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.update</code></td>
    <td>È stata aggiornata un'attestazione del volume persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.create</code></td>
    <td>È stato creato un volume persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.delete</code></td>
    <td>È stato eliminato un volume persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.patch</code></td>
    <td>È stato corretto un volume persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.update</code></td>
    <td>È stato aggiornato un volume persistente.</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>È stato creato un pod.</td>
  </tr>
  <tr>
    <td><code>pods.delete</code></td>
    <td>È stato eliminato un pod.</td>
  </tr>
  <tr>
    <td><code>pods.patch</code></td>
    <td>È stato corretto un pod.</td>
  </tr>
  <tr>
    <td><code>pods.update</code></td>
    <td>È stato aggiornato un pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.create</code></td>
    <td>È stato creato un template di pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.delete</code></td>
    <td>È stato eliminato un template di pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>È stato corretto un template di pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.update</code></td>
    <td>È stato aggiornato un template di pod.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.create</code></td>
    <td>È stato creato un controller di replica.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.delete</code></td>
    <td>È stato eliminato un controller di replica.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.patch</code></td>
    <td>È stato corretto un controller di replica.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.update</code></td>
    <td>È stato aggiornato un controller di replica.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.create</code></td>
    <td>È stata creata una quota della risorsa.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.delete</code></td>
    <td>È stata eliminata una quota della risorsa.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.patch</code></td>
    <td>È stata corretta una quota della risorsa.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.update</code></td>
    <td>È stata aggiornata una quota della risorsa.</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>È stato creato un segreto.</td>
  </tr>
  <tr>
    <td><code>secrets.deleted</code></td>
    <td>È stato eliminato un segreto.</td>
  </tr>
  <tr>
    <td><code>secrets.get</code></td>
    <td>È stato visualizzato un segreto.</td>
  </tr>
  <tr>
    <td><code>secrets.patch</code></td>
    <td>È stato corretto un segreto.</td>
  </tr>
  <tr>
    <td><code>secrets.updated</code></td>
    <td>È stato aggiornato un segreto.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>È stato creato un account di servizio.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.deleted</code></td>
    <td>È stato eliminato un account di servizio.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.patch</code></td>
    <td>È stato corretto un account di servizio.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.updated</code></td>
    <td>È stato aggiornato un account di servizio.</td>
  </tr>
  <tr>
    <td><code>services.create</code></td>
    <td>È stato creato un servizio.</td>
  </tr>
  <tr>
    <td><code>services.deleted</code></td>
    <td>È stato eliminato un servizio.</td>
  </tr>
  <tr>
    <td><code>services.patch</code></td>
    <td>È stato corretto un servizio.</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>È stato aggiornato un servizio.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.create</code></td>
    <td>In Kubernetes v1.9 e successive, è stata creata una configurazione webhook oggetto di variazioni.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.delete</code></td>
    <td>In Kubernetes v1.9 e successive, è stata eliminata una configurazione webhook oggetto di variazioni.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.patch</code></td>
    <td>In Kubernetes v1.9 e successive, è stata corretta una configurazione webhook oggetto di variazioni.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.update</code></td>
    <td>In Kubernetes v1.9 e successive, è stata aggiornata una configurazione webhook oggetto di variazioni.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.create</code></td>
    <td>In Kubernetes v1.9 e successive, è stata creata una convalida della configurazione webhook.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.delete</code></td>
    <td>In Kubernetes v1.9 e successive, è stata eliminata una convalida della configurazione webhook.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.patch</code></td>
    <td>In Kubernetes v1.9 e successive, è stata corretta una convalida della configurazione webhook.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.update</code></td>
    <td>In Kubernetes v1.9 e successive, è stata aggiornata una convalida della configurazione webhook.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>In Kubernetes v1.8, è stata creata una configurazione hook di ammissioni esterne.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.delete</code></td>
    <td>In Kubernetes v1.8, è stata eliminata una configurazione hook di ammissioni esterne.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.patch</code></td>
    <td>In Kubernetes v1.8, è stata corretta una configurazione hook di ammissioni esterne.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.update</code></td>
    <td>In Kubernetes v1.8, è stata aggiornata una configurazione hook di ammissioni esterne.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.create</code></td>
    <td>È stata creata una revisione del controller.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.delete</code></td>
    <td>È stata eliminata una revisione del controller.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.patch</code></td>
    <td>È stata corretta una revisione del controller.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.update</code></td>
    <td>È stata aggiornata una revisione del controller.</td>
  </tr>
  <tr>
    <td><code>daemonsets.create</code></td>
    <td>È stata creata una serie di daemon.</td>
  </tr>
  <tr>
    <td><code>daemonsets.delete</code></td>
    <td>È stata eliminata una serie di daemon.</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>È stata corretta una serie di daemon.</td>
  </tr>
  <tr>
    <td><code>daemonsets.update</code></td>
    <td>È stata aggiornata una serie di daemon.</td>
  </tr>
  <tr>
    <td><code>deployments.create</code></td>
    <td>È stata creata una distribuzione.</td>
  </tr>
  <tr>
    <td><code>deployments.delete</code></td>
    <td>È stata eliminata una distribuzione.</td>
  </tr>
  <tr>
    <td><code>deployments.patch</code></td>
    <td>È stata corretta una distribuzione.</td>
  </tr>
  <tr>
    <td><code>deployments.update</code></td>
    <td>È stata aggiornata una distribuzione.</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>È stata creata una serie di repliche.</td>
  </tr>
  <tr>
    <td><code>replicasets.delete</code></td>
    <td>È stata eliminata una serie di repliche.</td>
  </tr>
  <tr>
    <td><code>replicasets.patch</code></td>
    <td>È stata corretta una serie di repliche.</td>
  </tr>
  <tr>
    <td><code>replicasets.update</code></td>
    <td>È stata aggiornata una serie di repliche.</td>
  </tr>
  <tr>
    <td><code>statefulsets.create</code></td>
    <td>È stata creata una serie con stato.</td>
  </tr>
  <tr>
    <td><code>statefulsets.delete</code></td>
    <td>È stata eliminata una serie con stato.</td>
  </tr>
  <tr>
    <td><code>statefulsets.patch</code></td>
    <td>È stata corretta una serie con stato.</td>
  </tr>
  <tr>
    <td><code>statefulsets.update</code></td>
    <td>È stata aggiornata una serie con stato.</td>
  </tr>
  <tr>
    <td><code>tokenreviews.create</code></td>
    <td>È stata creata una revisione token.</td>
  </tr>
  <tr>
    <td><code>localsubjectaccessreviews.create</code></td>
    <td>È stata creata una revisione di accesso locale del soggetto. </td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>È stata creata una auto revisione di accesso del soggetto. </td>
  </tr>
  <tr>
    <td><code>selfsubjectrulesreviews.create</code></td>
    <td>È stata creata una auto revisione delle regole del soggetto. </td>
  </tr>
  <tr>
    <td><code>subjectaccessreviews.create</code></td>
    <td>È stata creata una revisione di accesso del soggetto. </td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.create</code></td>
    <td>È stata creata una politica di ridimensionamento pod orizzontale.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.delete</code></td>
    <td>È stata eliminata una politica di ridimensionamento pod orizzontale.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.patch</code></td>
    <td>È stata corretta una politica di ridimensionamento pod orizzontale.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.update</code></td>
    <td>È stata aggiornata una politica di ridimensionamento pod orizzontale.</td>
  </tr>
  <tr>
    <td><code>jobs.create</code></td>
    <td>È stato creato un lavoro.</td>
  </tr>
  <tr>
    <td><code>jobs.delete</code></td>
    <td>È stato eliminato un lavoro.</td>
  </tr>
  <tr>
    <td><code>jobs.patch</code></td>
    <td>È stato corretto un lavoro.</td>
  </tr>
  <tr>
    <td><code>jobs.update</code></td>
    <td>È stato aggiornato un lavoro.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.create</code></td>
    <td>È stata creata una richiesta per firmare un certificato.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.delete</code></td>
    <td>È stata eliminata una richiesta per firmare un certificato.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.patch</code></td>
    <td>È stata corretta una richiesta per firmare un certificato.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.update</code></td>
    <td>È stata aggiornata una richiesta per firmare un certificato.</td>
  </tr>
  <tr>
    <td><code>ingresses.create</code></td>
    <td>È stato creato un ALB Ingress.</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>È stato eliminato un ALB Ingress.</td>
  </tr>
  <tr>
    <td><code>ingresses.patch</code></td>
    <td>È stato corretto un ALB Ingress.</td>
  </tr>
  <tr>
    <td><code>ingresses.update</code></td>
    <td>È stato aggiornato un ALB Ingress.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.create</code></td>
    <td>È stata creata una politica di rete.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.delete</code></td>
    <td>È stata eliminata una politica di rete.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.patch</code></td>
    <td>È stata corretta una politica di rete.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.update</code></td>
    <td>È stata aggiornata una politica di rete.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.create</code></td>
    <td>Per Kubernetes v1.10 e successive, è stata creata una politica di sicurezza del pod.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.delete</code></td>
    <td>Per Kubernetes v1.10 e successive, è stata eliminata una politica di sicurezza del pod.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.patch</code></td>
    <td>Per Kubernetes v1.10 e successive, è stata corretta una politica di sicurezza del pod.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>Per Kubernetes v1.10 e successive, è stata aggiornata una politica di sicurezza del pod.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.create</code></td>
    <td>È stato creato un PDB (pod disruption budget).</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.delete</code></td>
    <td>È stato eliminato un PDB (pod disruption budget).</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.patch</code></td>
    <td>È stato corretto un PDB (pod disruption budget).</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.update</code></td>
    <td>È stato aggiornato un PDB (pod disruption budget).</td>
  </tr>
  <tr>
    <td><code>clusterbindings.create</code></td>
    <td>È stato creato un bind del ruolo cluster.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.deleted</code></td>
    <td>È stato eliminato un bind del ruolo cluster.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.patched</code></td>
    <td>È stato corretto un bind del ruolo cluster.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.updated</code></td>
    <td>È stato aggiornato un bind del ruolo cluster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.create</code></td>
    <td>È stato creato un ruolo cluster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>È stato eliminato un ruolo cluster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.patched</code></td>
    <td>È stato corretto un ruolo cluster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.updated</code></td>
    <td>È stato aggiornato un ruolo cluster.</td>
  </tr>
  <tr>
    <td><code>rolebindings.create</code></td>
    <td>È stato creato un bind del ruolo.</td>
  </tr>
  <tr>
    <td><code>rolebindings.deleted</code></td>
    <td>È stato eliminato un bind del ruolo.</td>
  </tr>
  <tr>
    <td><code>rolebindings.patched</code></td>
    <td>È stato corretto un bind del ruolo.</td>
  </tr>
  <tr>
    <td><code>rolebindings.updated</code></td>
    <td>È stato aggiornato un bind del ruolo.</td>
  </tr>
  <tr>
    <td><code>roles.create</code></td>
    <td>È stato creato un ruolo.</td>
  </tr>
  <tr>
    <td><code>roles.deleted</code></td>
    <td>È stato eliminato un ruolo.</td>
  </tr>
  <tr>
    <td><code>roles.patched</code></td>
    <td>È stato corretto un ruolo.</td>
  </tr>
  <tr>
    <td><code>roles.updated</code></td>
    <td>È stato aggiornato un ruolo.</td>
  </tr>
  <tr>
    <td><code>podpresets.create</code></td>
    <td>È stato creato un pod preimpostato. </td>
  </tr>
  <tr>
    <td><code>podpresets.deleted</code></td>
    <td>È stato eliminato un pod preimpostato. </td>
  </tr>
  <tr>
    <td><code>podpresets.patched</code></td>
    <td>È stato corretto un pod preimpostato. </td>
  </tr>
  <tr>
    <td><code>podpresets.updated</code></td>
    <td>È stato aggiornato un pod preimpostato. </td>
  </tr>
</table>
