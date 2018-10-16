---

copyright:
  years: 2017, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# {{site.data.keyword.cloudaccesstrailshort}}-Ereignisse
{: #at_events}

Mithilfe des {{site.data.keyword.cloudaccesstrailshort}}-Service können Sie vom Benutzer initiierte Aktivitäten in Ihrem {{site.data.keyword.containerlong_notm}}-Cluster anzeigen, verwalten und prüfen.
{: shortdesc}



Weitere Informationen zur Funktionsweise des Service finden Sie in der [Dokumentation zu {{site.data.keyword.cloudaccesstrailshort}}](/docs/services/cloud-activity-tracker/index.html). Weitere Informationen zu den Kubernetes-Aktionen, die verfolgt werden, finden Sie in der [Kubernetes-Dokumentation![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/home/). 


## Informationen für Kubernetes-Auditereignisse suchen
{: #kube-find}

{{site.data.keyword.cloudaccesstrailshort}}-Ereignisse sind in der {{site.data.keyword.cloudaccesstrailshort}}-**Kontodomäne** verfügbar, die sich in der {{site.data.keyword.Bluemix_notm}}-Region befindet, in der die Ereignisse generiert werden. {{site.data.keyword.cloudaccesstrailshort}}-Ereignisse sind in der {{site.data.keyword.cloudaccesstrailshort}}-**Bereichsdomäne** verfügbar, die zum Cloud Foundry-Bereich zugeordnet ist, in dem der {{site.data.keyword.cloudaccesstrailshort}}-Service bereitgestellt wird.

So überwachen Sie die Verwaltungsaktivität:

1. Melden Sie sich bei Ihrem {{site.data.keyword.Bluemix_notm}}-Konto an.
2. Stellen Sie über den Katalog eine Instanz des {{site.data.keyword.cloudaccesstrailshort}}-Service im selben Konto wie Ihre Instanz von {{site.data.keyword.containerlong_notm}} bereit.
3. Klicken Sie auf der Registerkarte **Verwalten** des {{site.data.keyword.cloudaccesstrailshort}}-Dashboards auf die Option **In Kibana anzeigen**.
4. Legen Sie den Zeitrahmen fest, für den Sie Protokolle anzeigen möchten. Der Standardwert ist 15 Minuten.
5. Klicken Sie in der Liste **Verfügbare Felder** auf **Typ**. Klicken Sie auf das Lupensymbol für **Activity Tracker**, um die Protokolle auf die Protokolle zu beschränken, die vom Service überwacht werden.
6. Sie können die anderen verfügbaren Felder verwenden, um die Suche einzugrenzen.

Die Informationen im Abschnitt [Berechtigungen zur Anzeige von Kontoereignissen erteilen](/docs/services/cloud-activity-tracker/how-to/grant_permissions.html#grant_permissions) helfen Ihnen dabei, wenn Sie andere Benutzer berechtigen wollen, Konto- und Bereichsereignisse anzuzeigen.
{: tip}

## Kubernetes-Auditereignisse aufzeichnen
{: #kube-events}

In der folgenden Tabelle finden Sie eine Liste der Ereignisse, die an {{site.data.keyword.cloudaccesstrailshort}} gesendet werden.
{: shortdesc}

**Vorbereitende Schritte**

Stellen Sie sicher, dass Ihr Cluster für die Weiterleitung von [Kubernetes-API-Auditereignissen](cs_health.html#api_forward) konfiguriert ist.

**Weitergeleitete Ereignisse**

<table>
  <tr>
    <th>Aktion</th>
    <th>Beschreibung</th>
  </tr>
  <tr>
    <td><code>bindings.create</code></td>
    <td>Eine Bindung wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>configmaps.create</code></td>
    <td>Eine Konfigurationszuordnung wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>configmaps.delete</code></td>
    <td>Eine Konfigurationszuordnung wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>Eine Konfigurationszuordnung wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>configmaps.update</code></td>
    <td>Eine Konfigurationszuordnung wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>events.create</code></td>
    <td>Ein Ereignis wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>events.delete</code></td>
    <td>Ein Ereignis wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>events.patch</code></td>
    <td>Ein Ereignis wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>events.update</code></td>
    <td>Ein Ereignis wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>Ein Bereichsgrenzwert wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>limitranges.delete</code></td>
    <td>Ein Bereichsgrenzwert wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>limitranges.patch</code></td>
    <td>Ein Bereichsgrenzwert wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>limitranges.update</code></td>
    <td>Eine Bereichsgrenze wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>namespaces.create</code></td>
    <td>Ein Namensbereich wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>namespaces.delete</code></td>
    <td>Ein Namensbereich wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>namespaces.patch</code></td>
    <td>Ein Namensbereich wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>Ein Namensbereich wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>nodes.create</code></td>
    <td>Ein Knoten wird erstellt.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>Ein Knoten wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>Ein Knoten wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>nodes.patch</code></td>
    <td>Ein Knoten wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>Ein Knoten wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.create</code></td>
    <td>Ein Persistent Volume Claim (PVC) wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.delete</code></td>
    <td>Ein Persistent Volume Claim (PVC) wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.patch</code></td>
    <td>Ein Persistent Volume Claim (PVC) wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.update</code></td>
    <td>Ein Persistent Volume Claim (PVC) wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.create</code></td>
    <td>Ein persistenter Datenträger (PV) wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.delete</code></td>
    <td>Ein persistenter Datenträger wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.patch</code></td>
    <td>Ein persistenter Datenträger wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.update</code></td>
    <td>Ein persistenter Datenträger wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>Ein Pod wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>pods.delete</code></td>
    <td>Ein Pod wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>pods.patch</code></td>
    <td>Ein Pod wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>pods.update</code></td>
    <td>Ein Pod wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>podtemplates.create</code></td>
    <td>Eine Pod-Vorlage wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>podtemplates.delete</code></td>
    <td>Eine Pod-Vorlage wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>Eine Pod-Vorlage wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>podtemplates.update</code></td>
    <td>Eine Pod-Vorlage wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.create</code></td>
    <td>Ein Replikationscontroller wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.delete</code></td>
    <td>Ein Replikationscontroller wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.patch</code></td>
    <td>Ein Replikationscontroller wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.update</code></td>
    <td>Ein Replikationscontroller wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.create</code></td>
    <td>Ein Ressourcenkontingent wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.delete</code></td>
    <td>Ein Ressourcenkontingent wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.patch</code></td>
    <td>Ein Ressourcenkontingent wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.update</code></td>
    <td>Ein Ressourcenkontingent wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>Ein geheimer Schlüssel wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>secrets.deleted</code></td>
    <td>Ein geheimer Schlüssel wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>secrets.get</code></td>
    <td>Ein geheimer Schlüssel wurde angezeigt.</td>
  </tr>
  <tr>
    <td><code>secrets.patch</code></td>
    <td>Ein geheimer Schlüssel wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>secrets.updated</code></td>
    <td>Ein geheimer Schlüssel wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>Ein Servicekonto wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.deleted</code></td>
    <td>Ein Servicekonto wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.patch</code></td>
    <td>Ein Servicekonto wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.updated</code></td>
    <td>Ein Servicekonto wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>services.create</code></td>
    <td>Ein Service wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>services.deleted</code></td>
    <td>Ein Service wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>services.patch</code></td>
    <td>Ein Service wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>Ein Service wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.create</code></td>
    <td>In Kubernetes Version 1.9 und höher wurde eine Mutation der Webhook-Konfiguration erstellt.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.delete</code></td>
    <td>In Kubernetes Version 1.9 und höher wurde eine Mutation der Webhook-Konfiguration gelöscht.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.patch</code></td>
    <td>In Kubernetes Version 1.9 und höher wurde eine Mutation der Webhook-Konfiguration korrigiert.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.update</code></td>
    <td>In Kubernetes Version 1.9 und höher wurde eine Mutation der Webhook-Konfiguration aktualisiert.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.create</code></td>
    <td>In Kubernetes Version 1.9 und höher wurde eine Validierung der Webhook-Konfiguration erstellt.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.delete</code></td>
    <td>In Kubernetes Version 1.9 und höher wurde die Validierung der Webhook-Konfiguration gelöscht.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.patch</code></td>
    <td>In Kubernetes Version 1.9 und höher wurde die Validierung der Webhook-Konfiguration korrigiert.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.update</code></td>
    <td>In Kubernetes Version 1.9 und höher wurde die Validierung der Webhook-Konfiguration aktualisiert .</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>In Kubernetes Version 1.8 wurde eine Konfiguration für External Admission Webhooks erstellt.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.delete</code></td>
    <td>In Kubernetes Version 1.8 wurde eine Konfiguration für External Admission Webhooks gelöscht.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.patch</code></td>
    <td>In Kubernetes Version 1.8 wurde eine Konfiguration für External Admission Webhooks korrigiert.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.update</code></td>
    <td>In Kubernetes Version 1.8 wurde eine Konfiguration für External Admission Webhooks aktualisiert.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.create</code></td>
    <td>Eine Controllerrevision wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.delete</code></td>
    <td>Eine Controllerrevision wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.patch</code></td>
    <td>Eine Controllerrevision wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.update</code></td>
    <td>Eine Controllerrevision wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>daemonsets.create</code></td>
    <td>Eine Dämongruppe wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>daemonsets.delete</code></td>
    <td>Eine Dämongruppe wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>Eine Dämongruppe wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>daemonsets.update</code></td>
    <td>Eine Dämongruppe wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>deployments.create</code></td>
    <td>Eine Bereitstellung wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>deployments.delete</code></td>
    <td>Eine Bereitstellung wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>deployments.patch</code></td>
    <td>Eine Bereitstellung wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>deployments.update</code></td>
    <td>Eine Bereitstellung wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>Eine Replikatgruppe wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>replicasets.delete</code></td>
    <td>Eine Replikatgruppe wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>replicasets.patch</code></td>
    <td>Eine Replikatgruppe wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>replicasets.update</code></td>
    <td>Eine Replikatgruppe wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>statefulsets.create</code></td>
    <td>Eine statusabhängige Gruppe wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>statefulsets.delete</code></td>
    <td>Eine statusabhängige Gruppe wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>statefulsets.patch</code></td>
    <td>Eine statusabhängige Gruppe wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>statefulsets.update</code></td>
    <td>Eine statusabhängige Gruppe wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>tokenreviews.create</code></td>
    <td>Eine Tokenprüfung wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>localsubjectaccessreviews.create</code></td>
    <td>Eine Zugriffsprüfung für lokale Subjekte wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>Eine Zugriffsprüfung für Self-Subjekte wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>selfsubjectrulesreviews.create</code></td>
    <td>Eine Regelprüfung für Self-Subjekte wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>subjectaccessreviews.create</code></td>
    <td>Eine Zugriffsprüfung für Subjekte wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.create</code></td>
    <td>Eine Richtlinie zur horizontalen Autoskalierung von Pods wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.delete</code></td>
    <td>Eine Richtlinie zur horizontalen Autoskalierung von Pods wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.patch</code></td>
    <td>Eine Richtlinie zur horizontalen Autoskalierung von Pods wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.update</code></td>
    <td>Eine Richtlinie zur horizontalen Autoskalierung von Pods wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>jobs.create</code></td>
    <td>Ein Job wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>jobs.delete</code></td>
    <td>Ein Job wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>jobs.patch</code></td>
    <td>Ein Job wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>jobs.update</code></td>
    <td>Ein Job wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.create</code></td>
    <td>Eine Anforderung zum Signieren eines Zertifikats wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.delete</code></td>
    <td>Eine Anforderung zum Signieren eines Zertifikats wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.patch</code></td>
    <td>Eine Anforderung zum Signieren eines Zertifikats wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.update</code></td>
    <td>Eine Anforderung zum Signieren eines Zertifikats wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>ingresses.create</code></td>
    <td>Eine Ingress-ALB wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>Eine Ingress-ALB wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>ingresses.patch</code></td>
    <td>Eine Ingress-ALB wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>ingresses.update</code></td>
    <td>Eine Ingress-ALB wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.create</code></td>
    <td>Eine Netzrichtlinie wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.delete</code></td>
    <td>Eine Netzrichtlinie wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.patch</code></td>
    <td>Eine Netzrichtlinie wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.update</code></td>
    <td>Eine Netzrichtlinie wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.create</code></td>
    <td>Für Kubernetes v1.10 und höher wurde eine Pod-Sicherheitsrichtlinie erstellt.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.delete</code></td>
    <td>Für Kubernetes v1.10 und höher wurde eine Pod-Sicherheitsrichtlinie gelöscht.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.patch</code></td>
    <td>Für Kubernetes v1.10 und höher wurde eine Pod-Sicherheitsrichtlinie korrigiert.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>Für Kubernetes v1.10 und höher wurde eine Pod-Sicherheitsrichtlinie aktualisiert.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.create</code></td>
    <td>Ein Budget für den Pod-Ausfall wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.delete</code></td>
    <td>Ein Budget für den Pod-Ausfall wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.patch</code></td>
    <td>Ein Budget für den Pod-Ausfall wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.update</code></td>
    <td>Ein Budget für den Pod-Ausfall wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.create</code></td>
    <td>Eine Clusterrollenbindung wird erstellt.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.deleted</code></td>
    <td>Eine Clusterrollenbindung wird gelöscht.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.patched</code></td>
    <td>Eine Clusterrollenbindung wird korrigiert.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.updated</code></td>
    <td>Eine Clusterrollenbindung wird aktualisiert.</td>
  </tr>
  <tr>
    <td><code>clusterroles.create</code></td>
    <td>Eine Clusterrolle wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>Eine Clusterrolle wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>clusterroles.patched</code></td>
    <td>Eine Clusterrolle wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>clusterroles.updated</code></td>
    <td>Eine Clusterrolle wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>rolebindings.create</code></td>
    <td>Eine Rollenbindung wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>rolebindings.deleted</code></td>
    <td>Eine Rollenbindung wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>rolebindings.patched</code></td>
    <td>Eine Rollenbindung wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>rolebindings.updated</code></td>
    <td>Eine Rollenbindung wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>roles.create</code></td>
    <td>Eine Rolle wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>roles.deleted</code></td>
    <td>Eine Rolle wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>roles.patched</code></td>
    <td>Eine Rolle wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>roles.updated</code></td>
    <td>Eine Rolle wurde aktualisiert.</td>
  </tr>
  <tr>
    <td><code>podpresets.create</code></td>
    <td>Eine Pod-Voreinstellung wurde erstellt.</td>
  </tr>
  <tr>
    <td><code>podpresets.deleted</code></td>
    <td>Eine Pod-Voreinstellung wurde gelöscht.</td>
  </tr>
  <tr>
    <td><code>podpresets.patched</code></td>
    <td>Eine Pod-Voreinstellung wurde korrigiert.</td>
  </tr>
  <tr>
    <td><code>podpresets.updated</code></td>
    <td>Eine Pod-Voreinstellung wurde aktualisiert.</td>
  </tr>
</table>
