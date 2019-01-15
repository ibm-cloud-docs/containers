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


# CLI-Änderungsprotokoll
{: #cs_cli_changelog}

Sie werden im Terminal benachrichtigt, wenn Aktualisierungen für die `ibmcloud`-CLI und -Plug-ins verfügbar sind. Halten Sie Ihre CLI stets aktuell, sodass Sie alle verfügbaren Befehle und Flags verwenden können.
{:shortdesc}

Informationen zum Installieren des CLI-Plug-ins finden Sie im Abschnitt [CLI installieren](cs_cli_install.html#cs_cli_install_steps).

In der folgenden Tabelle werden die Änderungen für jede Plug-in-Version der Befehlszeilenschnittstelle (CLI) zusammengefasst.

<table summary="Übersicht über die Versionsänderungen für das {{site.data.keyword.containerlong_notm}}-CLI-Plug-in">
<caption>Änderungsprotokoll für das {{site.data.keyword.containerlong_notm}}-CLI-Plug-in</caption>
<thead>
<tr>
<th>Version</th>
<th>Freigabedatum</th>
<th>Änderungen</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.1.654</td>
<td>5. Dezember 2018</td>
<td>Aktualisieren der Dokumentation und Übersetzung.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15. November 2018</td>
<td>
<ul><li>Hinzufügen des Befehls [<code>ibmcloud ks cluster-refresh</code>](cs_cli_reference.html#cs_cluster_refresh). </li>
<li>Hinzufügen des Namens der Ressourcengruppe zur Ausgabe von <code>ibmcloud ks cluster-get</code> und <code>ibmcloud ks clusters</code>. </li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>6. November 2018</td>
<td>Hinzufügen der Befehle [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable), [<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable), [<code>ibmcloud ks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get), [<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback) und [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) für die Verwaltung von automatischen Aktualisierungen des Ingress-ALB-Cluster-Add-ons.
</td>
</tr>
<tr>
<td>0.1.621</td>
<td>30. Oktober 2018</td>
<td><ul>
<li>Hinzufügen des [Befehls <code>ibmcloud ks credential-get</code>](cs_cli_reference.html#cs_credential_get). </li>
<li>Hinzufügen von Unterstützung für die Protokollquelle <code>storage</code> zu allen Clusterprotokollierungsbefehlen. Weitere Informationen finden Sie unter <a href="cs_health.html#logging">Informationen zur Protokollweiterleitung für Cluster und Apps</a>. </li>
<li>Hinzufügen des Flags `--network` zum [Befehl <code>ibmcloud ks cluster-config</code>](cs_cli_reference.html#cs_cluster_config), der die Calico-Konfigurationsdatei für die Ausführung aller Calico-Befehle herunterlädt. </li>
<li>Kleinere Fehlerkorrekturen und Refactoring</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10. Oktober 2018</td>
<td><ul><li>Hinzufügen der Ressourcengruppen-ID zur Ausgabe von <code>ibmcloud ks cluster-get</code>.</li>
<li>Bei [Aktivierung von {{site.data.keyword.keymanagementserviceshort}}](cs_encrypt.html#keyprotect) als KMS-Provider (KMS - Key Management Service) im Cluster, wird das Feld für die Aktivierung von KMS in der Ausgabe von <code>ibmcloud ks cluster-get</code> hinzugefügt.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>02. Oktober 2018</td>
<td>Hinzufügen der Unterstützung für [Ressourcengruppen](cs_clusters.html#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>01. Oktober 2018</td>
<td><ul>
<li>Hinzufügen der Befehle [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) und [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) zum Erfassen der API-Serverprotokolle im Cluster.</li>
<li>Hinzufügen des Befehls [<code>ibmcloud ks key-protect-enable</code>](cs_cli_reference.html#cs_key_protect) zum Aktivieren von {{site.data.keyword.keymanagementserviceshort}} als KMS-Provider (KMS - Key Management Service) im Cluster.</li>
<li>Hinzufügen des Flags <code>--skip-master-health</code> zu den Befehlen [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) und [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) zum Überspringen der Masterstatusprüfung vor dem Einleiten eines Neustarts oder Warmstarts.</li>
<li>Umbenennen von <code>Owner Email</code> in <code>Owner</code> in der Ausgabe von <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
