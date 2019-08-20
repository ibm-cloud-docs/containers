---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:preview: .preview}



# Informationen zu Ingress-ALBs
{: #ingress-about}

Ingress ist ein Kubernetes Service, der Netzverkehr-Workloads in Ihrem Cluster ausgleicht, indem er öffentliche oder private Anforderungen an Ihre Apps weiterleitet. Mit Ingress können Sie in einem öffentlichen oder privaten Netz mehrere App-Services zugänglich machen, indem Sie eine eindeutige öffentliche oder private Route verwenden.
{: shortdesc}

## Wie setzt sich Ingress zusammen?
{: #ingress_components}

Ingress besteht aus drei Komponenten: Ingress-Ressourcen, Lastausgleichsfunktionen für Anwendungen (ALBs) und der Lastausgleichsfunktion für mehrere Zonen (MZLB).
{: shortdesc}

### Ingress-Ressource
{: #ingress-resource}

Um eine App über Ingress zugänglich zu machen, müssen Sie einen Kubernetes Service für Ihre App erstellen und diesen Service bei Ingress registrieren, indem Sie eine Ingress-Ressource definieren. Die Ingress-Ressource ist eine Kubernetes-Ressource, die die Regeln für die Weiterleitung eingehender Anforderungen für Apps definiert. Die Ingress-Ressource gibt auch den Pfad zu Ihren App-Services an, die an die öffentliche Route angehängt werden, um eine eindeutige App-URL zu bilden, z. B. `mycluster.us-south.containers.appdomain.cloud/myapp1`.
{: shortdesc}

Es ist eine Ingress-Ressource pro Namensbereich erforderlich, in dem sich die zugänglich zu machenden Apps befinden.
* Wenn sich die Apps in Ihrem Cluster alle im selben Namensbereich befinden, ist eine Ingress-Ressource erforderlich, um die Weiterleitungsregeln für die dort zugänglich gemachten Apps zu definieren. Beachten Sie, dass Sie, wenn Sie für die Apps in einem einzelnen Namensbereich unterschiedliche Domänen verwenden möchten, eine Platzhalterdomäne verwenden können, um mehrere Unterdomänenhosts in einer Ressource anzugeben.
* Wenn sich die Apps in Ihrem Cluster in unterschiedlichen Namensbereichen befinden, müssen Sie eine Ressource pro Namensbereich erstellen, um Regeln für die dort zugänglich gemachten Apps zu definieren. Sie müssen eine Platzhalterdomäne verwenden und in jeder Ingress-Ressource eine andere Unterdomäne angeben. 

Weitere Informationen finden Sie in [Netzbetrieb für einen einzelnen oder mehrere Namensbereiche planen](/docs/containers?topic=containers-ingress#multiple_namespaces).

Seit dem 24. Mai 2018 gibt es ein anderes Ingress-Unterdomänenformat für neue Cluster. Der in dem neuen Unterdomänenformat enthaltene Bereich oder Zonenname wird basierend auf der Zone generiert, in der der Cluster erstellt wurde. Wenn Pipeline-Abhängigkeiten für konsistente App-Domänennamen bestehen, können Sie anstelle der von IBM bereitgestellten Ingress-Unterdomäne Ihre eigene angepasste Domäne verwenden.
{: note}

* Allen Clustern, die nach dem 24. Mai 2018 erstellt wurden, wird eine Unterdomäne im neuen Format `<clustername>.<region_oder_zone>.containers.appdomain.cloud` zugeordnet.
* Einzelzonencluster, die vor dem 24. Mai 2018 erstellt wurden, verwenden weiterhin die zugeordnete Unterdomäne im alten Format `<clustername>.<region>.containers.mybluemix.net`.
* Wenn Sie einen Einzelzonencluster, der vor dem 24. Mai 2018 erstellt wurde, in einen Mehrzonencluster ändern, indem Sie zum ersten Mal [eine Zone zum Cluster hinzufügen](/docs/containers?topic=containers-add_workers#add_zone), verwendet der Cluster weiterhin die zugeordnete Unterdomäne im alten Format `<clustername>.<region>.containers.mybluemix.net`. Außerdem wird dem Cluster eine Unterdomäne im neuen Format `<clustername>.<region_oder_zone>.containers.appdomain.cloud` zugewiesen. Es können beide Unterdomänen verwendet werden.

### Lastausgleichsfunktion für Anwendungen (ALB)
{: #alb-about}

Die Lastausgleichsfunktion für Anwendungen (ALB) ist eine externe Lastausgleichsfunktion, die für eingehende HTTP-, HTTPS- oder TCP-Serviceanforderungen empfangsbereit ist. Die ALB leitet Anforderungen gemäß den Regeln, die in der Ingress-Ressource definiert sind, an den entsprechenden App-Pod weiter.
{: shortdesc}

Wenn Sie einen Standardcluster erstellen, erstellt {{site.data.keyword.containerlong_notm}} automatisch eine hoch verfügbare ALB für Ihre Cluster und ordnet ihnen eine eindeutige öffentliche Route zu. Die öffentliche Route ist mit einer portierbaren öffentlichen IP-Adresse verknüpft, die bei der Erstellung des Clusters in Ihrem Konto der IBM Cloud-Infrastruktur eingerichtet wird. Es wird zwar auch eine private Standard-ALB erstellt, diese wird jedoch nicht automatisch aktiviert.

**Mehrzonencluster**: Wenn Sie eine Zone zu Ihrem Cluster hinzufügen, wird ein portierbares öffentliches Teilnetz hinzugefügt und eine neue öffentliche ALB automatisch erstellt und im Teilnetz in dieser Zone aktiviert. Alle öffentlichen Standard-ALBs in Ihrem Cluster nutzen eine öffentliche Route gemeinsam, haben jedoch unterschiedliche IP-Adressen. Es wird zwar auch eine private Standard-ALB in jeder Zone erstellt, diese wird jedoch nicht automatisch aktiviert.

### Lastausgleichsfunktion für mehrere Zonen (MZLB)
{: #mzlb}

**Mehrzonencluster**: Wenn Sie einen Mehrzonencluster erstellen oder [ eine Zone zu einem Einzelzonencluster hinzufügen](/docs/containers?topic=containers-add_workers#add_zone), wird automatisch eine Cloudflare-MZLB (Multizone Load Balancer) erstellt und bereitgestellt, sodass eine (1) MZLB für jede Region vorhanden ist. Die MZLB stellt die IP-Adressen Ihrer ALBs hinter dieselbe Unterdomäne und aktiviert die Zustandsprüfungen für diese IP-Adressen, um zu ermitteln, ob sie verfügbar sind oder nicht.

Wenn Sie beispielsweise Workerknoten in drei (3) Zonen in der Region 'Vereinigte Staaten (Osten)' haben, hat die Unterdomäne `yourcluster.us-east.containers.appdomain.cloud` drei ALB-IP-Adressen. Der MZLB-Status überprüft die öffentliche ALB-IP in jeder Zone des Clusters und hält die Ergebnisse der DNS-Suche auf der Basis dieser Zustandsprüfungen aktualisiert. Wenn Ihre ALBs beispielsweise die IP-Adressen `1.1.1.1`, `2.2.2.2` und `3.3.3.3` haben, gibt eine normale Operation der DNS-Suche in Ihrer Ingress-Unterdomäne alle drei IPs zurück, von denen der Client auf eine zufällig zugreift. Wenn die ALB mit der IP-Adresse `3.3.3.3` aus irgendeinem Grund nicht verfügbar ist, z. B. wegen eines Zonenfehlers, schlägt die Zustandsprüfung für diese Zone fehl, die MZLB entfernt die fehlgeschlagene IP-Adresse aus der Unterdomäne und die DNS-Suche gibt nur die einwandfreien ALB-IPs `1.1.1.1` und `2.2.2.2` zurück. Die Unterdomäne hat eine Lebensdauer von 30 Sekunden (TTL, Time to live). Nach 30 Sekunden können neue Client-Apps nur auf eine der verfügbaren, einwandfreien ALB-IPs zugreifen.

In seltenen Fällen können manche DNS-Resolver oder Client-Apps nach dem Intervall von 30 Sekunden weiterhin die nicht einwandfreie ALB-IP verwenden. Diese Client-Apps können eine längere Ladezeit aufweisen, bis die Clientanwendung die IP-Adresse `3.3.3.3` verlässt und versucht, eine Verbindung zu `1.1.1.1` oder `2.2.2.2` herzustellen. Je nach Client-Browser- oder Client-App-Einstellungen kann die Verzögerung von einigen Sekunden bis zu einem vollständigen TCP-Zeitlimitintervall reichen.

Die MZLB führt einen Lastausgleich für öffentliche ALBs durch, die die von IBM bereitgestellte Ingress-Unterdomäne verwenden. Wenn Sie nur private ALBs verwenden, müssen Sie den Status der ALBs manuell überprüfen und die Ergebnisse der DNS-Suche aktualisieren. Wenn Sie öffentliche ALBs verwenden, die eine angepasste Domäne verwenden, können Sie die ALBs in den Lastausgleich für MZLB aufnehmen, indem Sie einen CNAME in Ihrem DNS-Eintrag erstellen, um Anforderungen von Ihrer angepassten Domäne an die von IBM bereitgestellte Ingress-Unterdomäne für Ihren Cluster weiterzuleiten.

Wenn Sie die preDNAT-Netzrichtlinien von Calico verwenden, um den gesamten eingehenden Datenverkehr zu Ingress-Services zu blockieren, müssen Sie auch die [Cloudflare-IPv4-IPs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.cloudflare.com/ips/), die zur Überprüfung des Status Ihrer ALBs verwendet werden, in die Whitelist stellen. Informationen zum Erstellen einer Calico-preDNAT-Richtlinie für die Whitelist für diese IPs finden Sie in der [Lerneinheit 3 des Lernprogramms zur Calico-Netzrichtlinie](/docs/containers?topic=containers-policy_tutorial#lesson3).
{: note}

<br />


## Wie werden Ingress-ALBs IP-Adressen zugeordnet?
{: #ips}

Wenn Sie einen Standardcluster erstellen, stellt {{site.data.keyword.containerlong_notm}} automatisch ein portierbares öffentliches Teilnetz und ein portierbares privates Teilnetz bereit. Standardmäßig verwendet der Cluster folgende Adressen:
* 1 portierbare öffentliche IP-Adresse aus dem portierbaren öffentlichen Teilnetz für die öffentliche Standard-Ingress-ALB.
* 1 portierbare private IP-Adresse aus dem portierbaren privaten Teilnetz für die private Standard-Ingress-ALB.
{: shortdesc}

Wenn Sie einen Mehrzonencluster haben, werden in jeder Zone automatisch eine öffentliche Standard-ALB und eine private Standard-ALB erstellt. Die IP-Adressen Ihrer öffentlichen Standard-ALBs befinden sich alle hinter derselben von IBM bereitgestellten Unterdomäne für Ihren Cluster.

Portierbare öffentliche und private IP-Adressen sind statische variable IPs und ändern sich nicht, wenn ein Workerknoten entfernt wird. Wenn der Workerknoten entfernt wird, sorgt ein Dämon `Keepalived`, der die IP-Adressen fortlaufend überwacht, dafür, dass die ALB-Pods, die sich auf diesem Workerknoten befanden, automatisch auf einem anderen Workerknoten in dieser Zone neu geplant werden. Die neu geplanten ALB-Pods behalten dieselbe statische IP-Adresse bei. Die ALB-IP-Adresse in jeder Zone ändert sich im Verlauf des Lebenszyklus des Clusters nicht. Wenn Sie eine Zone aus einem Cluster entfernen, wird die ALB-IP-Adresse für diese Zone entfernt.

Zum Anzeigen der IP-Adressen, die Ihren ALBs zugeordnet sind, können Sie den folgenden Befehl ausführen.
```
ibmcloud ks albs --cluster <clustername_oder_-id>
```
{: pre}

Weitere Informationen dazu, was mit ALB-IP-Adressen bei einem Zonenfehler geschieht, finden Sie in der Definition für die [Komponente der Lastausgleichsfunktion für mehrere Zonen](#ingress_components).



<br />


## Wie kann eine Anforderung mithilfe von Ingress in einem Einzelzonencluster in meine App gelangen?
{: #architecture-single}



Das folgende Diagramm zeigt, wie Ingress die Kommunikation zwischen dem Internet und einer App in einem Einzelzonencluster steuert:

<img src="images/cs_ingress_singlezone.png" width="800" alt="App in einem Einzelzonencluster mithilfe von Ingress zugänglich machen" style="width:800px; border-style: none"/>

1. Ein Benutzer sendet eine Anforderung an Ihre App, indem er auf die URL Ihrer App zugreift. Diese URL ist die öffentliche URL für Ihre zugänglich gemachte App, der der Pfad der Ingress-Ressource wie zum Beispiel `mycluster.us-south.containers.appdomain.cloud/myapp` angehängt wird.

2. Ein DNS-Systemservice löst die Unterdomäne in der URL in die portierbare öffentliche IP-Adresse der Lastausgleichsfunktion auf, die die ALB in Ihrem Cluster zugänglich macht.

3. Basierend auf der aufgelösten IP-Adresse sendet der Client die Anforderung an den LoadBalancer-Service, der die ALB bereitstellt.

4. Der LoadBalancer-Service leitet die Anforderung an die ALB weiter.

5. Die ALB überprüft, ob eine Weiterleitungsregel für den Pfad `myapp` im Cluster vorhanden ist. Wird eine übereinstimmende Regel gefunden, wird die Anforderung entsprechend der Regeln, die Sie in der Ingress-Ressource definiert haben, an den Pod weitergeleitet, in dem die App bereitgestellt wurde. Die Quellen-IP-Adresse des Pakets wird in die IP-Adresse der öffentlichen IP-Adresse des Workerknotens geändert, auf dem der App-Pod ausgeführt wird. Wenn mehrere App-Instanzen im Cluster bereitgestellt werden, gleicht die ALB die Anforderungen zwischen den App-Pods aus.

<br />


## Wie kann eine Anforderung mithilfe von Ingress in einem Mehrzonencluster in meine App gelangen?
{: #architecture-multi}

Das folgende Diagramm zeigt, wie Ingress die Kommunikation zwischen dem Internet und einer App in einem Mehrzonencluster steuert:

<img src="images/cs_ingress_multizone.png" width="800" alt="App in einer Mehrzonencluster mithilfe von Ingress zugänglich machen" style="width:800px; border-style: none"/>

1. Ein Benutzer sendet eine Anforderung an Ihre App, indem er auf die URL Ihrer App zugreift. Diese URL ist die öffentliche URL für Ihre zugänglich gemachte App, der der Pfad der Ingress-Ressource wie zum Beispiel `mycluster.us-south.containers.appdomain.cloud/myapp` angehängt wird.

2. Ein DNS-Systemservice, der als globale Lastausgleichsfunktion fungiert, löst die Unterdomäne in der URL in eine verfügbare IP-Adresse auf, die von der MZLB als in einwandfreiem Zustand gemeldet wurde. Die MZLB überprüft fortlaufend die portierbaren öffentlichen IP-Adressen der LoadBalancer-Services, die öffentliche ALBs in jeder Zone in Ihrem Cluster zugänglich machen. Die IP-Adressen werden in einem Umlaufzyklus aufgelöst, wodurch sichergestellt wird, dass Anforderungen gleichmäßig auf die ordnungsgemäß funktionierenden ALBs in verschiedenen Zonen abgestimmt sind.

3. Der Client sendet die Anforderung an die IP-Adresse des LoadBalancer-Service, der eine ALB bereitstellt.

4. Der LoadBalancer-Service leitet die Anforderung an die ALB weiter.

5. Die ALB überprüft, ob eine Weiterleitungsregel für den Pfad `myapp` im Cluster vorhanden ist. Wird eine übereinstimmende Regel gefunden, wird die Anforderung entsprechend der Regeln, die Sie in der Ingress-Ressource definiert haben, an den Pod weitergeleitet, in dem die App bereitgestellt wurde. Die Quellen-IP-Adresse des Pakets wird in die öffentliche IP-Adresse des Workerknotens geändert, auf dem der App-Pod ausgeführt wird. Wenn mehrere App-Instanzen im Cluster implementiert sind, gleicht die ALB die Anforderungen zwischen App-Pods in allen Zonen aus.
