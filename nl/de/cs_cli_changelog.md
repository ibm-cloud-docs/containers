---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# CLI-Änderungsprotokoll
{: #cs_cli_changelog}

Sie werden im Terminal benachrichtigt, wenn Aktualisierungen für die `ibmcloud`-CLI und -Plug-ins verfügbar sind. Halten Sie Ihre CLI stets aktuell, sodass Sie alle verfügbaren Befehle und Flags verwenden können.
{:shortdesc}

Informationen zum Installieren des CLI-Plug-ins finden Sie im Abschnitt [CLI installieren](cs_cli_install.html#cs_cli_install_steps).

In der folgenden Tabelle werden die Änderungen für jede Plug-in-Version der Befehlszeilenschnittstelle (CLI) zusammengefasst.

<table summary="Änderungsprotokoll für das {{site.data.keyword.containerlong_notm}}-CLI-Plug-in">
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
