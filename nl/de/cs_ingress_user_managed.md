---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, nginx, iks multiple ingress controllers

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


# Eigenen Ingress-Controller verwenden
{: #ingress-user_managed}

Führen Sie Ihren eigenen Ingress-Controller für {{site.data.keyword.cloud_notm}} aus und nutzen Sie einen Hostnamen und ein TLS-Zertifikat, der/das von IBM bereitgestellt wird.
{: shortdesc}

Die von IBM bereitgestellten Ingress-Lastausgleichsfunktionen für Anwendungen (ALBs) basieren auf NGINX-Controllern, die Sie mithilfe von [angepassten {{site.data.keyword.cloud_notm}}-Annotationen](/docs/containers?topic=containers-ingress_annotation) konfigurieren können. Abhängig von den Anforderungen Ihrer App müssen Sie möglicherweise einen eigenen angepassten Ingress-Controller konfigurieren. Wenn Sie anstelle der von IBM bereitgestellten Ingress-ALB einen eigenen Ingress-Controller verwenden, sind Sie für die Bereitstellung des Controller-Images, die Wartung und die Aktualisierung des Controllers sowie für alle sicherheitsrelevanten Aktualisierungen verantwortlich, die zum Schutz Ihres Ingress-Controllers vor Sicherheitslücken erforderlich sind. **Hinweis:** "Eigenen Ingress-Controller verwenden" wird nur zur Bereitstellung von öffentlichem externem Zugriff auf Ihre Apps unterstützt, jedoch nicht zur Bereitstellung von privatem externem Zugriff.

Sie haben 2 Optionen, um Ihren eigenen Ingress-Controller einzusetzen:
* [Erstellen Sie eine Netzlastausgleichsfunktion (Network Load Balancer, NLB), um Ihre angepasste Ingress-Controller-Bereitstellung zugänglich zu machen, und erstellen Sie anschließend einen Hostnamen für die NLB-IP-Adresse](#user_managed_nlb). {{site.data.keyword.cloud_notm}} stellt den Hostnamen bereit und übernimmt für Sie die Generierung und Pflege eines Platzhalter-SSL-Zertifikats für den Hostnamen. Weitere Informationen zu von IBM bereitgestellten NLB-DNS-Hostnamen finden Sie unter [NLB-Hostnamen registrieren](/docs/containers?topic=containers-loadbalancer_hostname).
* [Inaktivieren Sie die von IBM bereitgestellte ALB-Bereitstellung und verwenden Sie den Lastausgleichsservice, der die ALB zugänglich gemacht hat, sowie die DNS-Registrierung für die von IBM bereitgestellte Ingress-Unterdomäne](#user_managed_alb). Diese Option ermöglicht es Ihnen, die Ingress-Unterdomäne und das TLS-Zertifikat zu nutzen, die Ihrem Cluster bereits zugeordnet wurden.

## Ingress-Controller durch Erstellen einer NLB und eines Hostnamens zugänglich machen
{: #user_managed_nlb}

Erstellen Sie eine Netzlastausgleichsfunktion (Network Load Balancer, NLB), um Ihre angepasste Ingress-Controller-Bereitstellung zugänglich zu machen, und erstellen Sie anschließend einen Hostnamen für die NLB-IP-Adresse.
{: shortdesc}

1. Rufen Sie die Konfigurationsdatei für den Ingress-Controller auf. Sie können z. B. den [cloudgenerischen Ingress-Controller der NGINX-Community ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic) verwenden. Wenn Sie den Community-Controller verwenden, bearbeiten Sie die Datei `kustomization.yaml`, indem Sie die folgenden Schritte ausführen.
  1. Ersetzen Sie `namespace: ingress-nginx` durch `namespace: kube-system`.
  2. Ersetzen Sie die Bezeichnungen `app.kubernetes.io/name: ingress-nginx` und `app.kubernetes.io/part-of: ingress-nginx` im Abschnitt `commonLabels` durch eine Bezeichnung `app: ingress-nginx`.

2. Stellen Sie Ihren eigenen Ingress-Controller bereit. Führen Sie z. B. den folgenden Befehl aus, um den cloudgenerischen Ingress-Controller der NGINX-Community zu verwenden.
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

3. Definieren Sie eine Lastausgleichsfunktion, um Ihre angepasste Ingress-Bereitstellung zugänglich zu machen.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-lb-svc
    spec:
      type: LoadBalancer
      selector:
        app: ingress-nginx
      ports:
       - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
    ```
    {: codeblock}

4. Erstellen Sie den Service in Ihrem Cluster.
    ```
    kubectl apply -f my-lb-svc.yaml
    ```
    {: pre}

5. Rufen Sie die Adresse **EXTERNAL-IP** für die Lastausgleichsfunktion ab.
    ```
    kubectl get svc my-lb-svc -n kube-system
    ```
    {: pre}

    In der folgenden Beispielausgabe ist **EXTERNAL-IP** `168.1.1.1`.
    ```
    NAME         TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)            AGE
    my-lb-svc    LoadBalancer   172.21.xxx.xxx   168.1.1.1        80:30104/TCP       2m
    ```
    {: screen}

6. Registrieren Sie die IP-Adresse der Lastausgleichsfunktion, indem Sie einen DNS-Hostnamen erstellen.
    ```
    ibmcloud ks nlb-dns-create --cluster <clustername_oder_-id> --ip <LB_IP>
    ```
    {: pre}

7. Stellen Sie sicher, dass der Hostname erstellt wurde.
  ```
  ibmcloud ks nlb-dnss --cluster <clustername_oder_-id>
  ```
  {: pre}

  Beispielausgabe:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
  ```
  {: screen}

8. Optional: [Aktivieren Sie Statusprüfungen für den Hostnamen, indem Sie einen Statusmonitor erstellen](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor).

9. Stellen Sie alle anderen Ressourcen bereit, die von Ihrem angepassten Ingress-Controller benötigt werden, wie beispielsweise die Konfigurationszuordnung.

10. Erstellen Sie Ingress-Ressourcen für Ihre Apps. In der Kubernetes-Dokumentation finden Sie Anweisungen zum Erstellen [einer Ingress-Ressourcendatei ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/ingress/) und zum Verwenden von [Annotationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/).
  <p class="tip">Wenn Sie weiter von IBM bereitgestellte ALBs zusammen mit Ihrem angepassten Ingress-Controller in einem Cluster verwenden wollen, können Sie separate Ingress-Ressourcen für Ihre ALBs und den angepassten Controller erstellen. Fügen Sie in der [Ingress-Ressource, die Sie ausschließlich für die Anwendung auf die IBM ALBs erstellt haben](/docs/containers?topic=containers-ingress#ingress_expose_public), die Annotation <code>kubernetes.io/ingress.class: "iks-nginx"</code> hinzu.</p>

11. Greifen Sie auf Ihre App zu, indem Sie den Hostnamen der Lastausgleichsfunktion  den Sie in Schritt 7 ermittelt haben, und den Pfad verwenden, über den Ihre App empfangsbereit ist, die Sie in der Ingress-Ressourcendatei angegeben haben.
  ```
  https://<hostname_der_lastausgleichsfunktion>/<app-pfad>
  ```
  {: codeblock}

## Ingress-Controller mithilfe der vorhandenen Lastausgleichsfunktion und Ingress-Unterdomäne zugänglich machen
{: #user_managed_alb}

Inaktivieren Sie die von IBM bereitgestellte ALB-Bereitstellung und verwenden Sie den Lastausgleichsservice, der die ALB zugänglich gemacht hat, sowie die DNS-Registrierung für die von IBM bereitgestellte Ingress-Unterdomäne.
{: shortdesc}

1. Rufen Sie die ID der öffentlichen Standard-ALB ab. Das Format der öffentlichen ALB ähnelt dem Format `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. Inaktivieren Sie die öffentliche Standard-ALB. Inaktivieren Sie die öffentliche Standard-ALB. Das Flag `--disable-deployment` inaktiviert die von IBM bereitgestellte ALB-Implementierung, entfernt jedoch nicht die DNS-Registrierung für die von IBM bereitgestellte Ingress-Unterdomäne oder den LoadBalancer-Service, der zum Bereitstellen des Ingress-Controllers verwendet wird.
    ```
    ibmcloud ks alb-configure --albID <alb-id> --disable-deployment
    ```
    {: pre}

3. Rufen Sie die Konfigurationsdatei für den Ingress-Controller auf. Sie können z. B. den [cloudgenerischen Ingress-Controller der NGINX-Community ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic) verwenden. Wenn Sie den Community-Controller verwenden, bearbeiten Sie die Datei `kustomization.yaml`, indem Sie die folgenden Schritte ausführen.
  1. Ersetzen Sie `namespace: ingress-nginx` durch `namespace: kube-system`.
  2. Ersetzen Sie die Bezeichnungen `app.kubernetes.io/name: ingress-nginx` und `app.kubernetes.io/part-of: ingress-nginx` im Abschnitt `commonLabels` durch eine Bezeichnung `app: ingress-nginx`.
  3. Ersetzen Sie in der Variablen `SERVICE_NAME` den Wert `name: ingress-nginx` durch `name: <alb-id>`. Die ALB-ID aus Schritt 1 kann beispielsweise wie folgt aussehen: `name: public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.

4. Stellen Sie Ihren eigenen Ingress-Controller bereit. Führen Sie z. B. den folgenden Befehl aus, um den cloudgenerischen Ingress-Controller der NGINX-Community zu verwenden. **Wichtig**: Um weiterhin den LoadBalancer-Service zu verwenden, der den Controller und die von IBM bereitgestellte Ingress-Unterdomäne zugänglich gemacht hat, muss Ihr Controller im Namensbereich `kube-system` bereitgestellt werden.
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

5. Rufen Sie die Bezeichnung für die angepasste Ingress-Bereitstellung ab.
    ```
    kubectl get deploy <ingress-controllername> -n kube-system --show-labels
    ```
    {: pre}

    In der folgenden Beispielausgabe lautet der Bezeichnungswert `ingress-nginx`:
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

6. Öffnen Sie mithilfe der in Schritt 1 abgerufenen ALB-ID den LoadBalancer-Service, der die IBM ALB zugänglich macht.
    ```
    kubectl edit svc <alb-id> -n kube-system
    ```
    {: pre}

7. Aktualisieren Sie den LoadBalancer-Service so, dass er auf Ihre angepasste Ingress-Bereitstellung verweist. Entfernen Sie unter `spec/selector` die ALB-ID aus der Bezeichnung `app` und fügen Sie die Bezeichnung für Ihren eigenen Ingress-Controller hinzu, die Sie in Schritt 5 ermittelt haben.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <angepasste_controllerbezeichnung>
      ...
    ```
    {: codeblock}
    1. Optional: Der LoadBalancer-Service lässt Datenverkehr standardmäßig an Port 80 und 443 zu. Wenn Ihr angepasster Ingress-Controller eine andere Gruppe von Ports erfordert, fügen Sie diese Ports zum Abschnitt `ports` hinzu.

8. Speichern und schließen Sie die Konfigurationsdatei. Die Ausgabe ist ähnlich wie die folgende:
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

9. Stellen Sie sicher, dass der `Selektor` der ALB nun auf den Controller verweist.
    ```
    kubectl describe svc <alb-id> -n kube-system
    ```
    {: pre}

    Beispielausgabe:
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <keine>
    ```
    {: screen}

10. Stellen Sie alle anderen Ressourcen bereit, die von Ihrem angepassten Ingress-Controller benötigt werden, wie beispielsweise die Konfigurationszuordnung.

11. Wenn Sie über einen Mehrzonencluster verfügen, wiederholen Sie diese Schritte für jede ALB.

12. Wenn Sie über einen Mehrzonencluster verfügen, müssen Sie eine Statusprüfung konfigurieren. Der Cloudflare-DNS-Statusprüfungsendpunkt `albhealth.<clustername>.<region>.containers.appdomain.com` erwartet eine Antwort `200` mit einem Hauptteil `healthy` in der Antwort. Wenn keine Statusprüfung für die Rückgabe von `200` und `healthy` eingerichtet ist, entfernt die Statusprüfung alle ALB-IP-Adressen aus dem DNS-Pool. Sie können entweder die vorhandene Statusprüfungsressource bearbeiten oder eine eigene Statusprüfungsressource erstellen.
  * Gehen Sie wie folgt vor, um die vorhandene Statusprüfungsressource zu bearbeiten:
      1. Öffnen Sie die Ressource `alb-health`.
        ```
        kubectl edit ingress alb-health --namespace kube-system
        ```
        {: pre}
      2. Ändern Sie im Abschnitt `metadata.annotations` den Annotationsnamen `ingress.bluemix.net/server-snippets` in den Namen der Annotation, die Ihr Controller unterstützt. Sie können beispielsweise die Annotation `nginx.ingress.kubernetes.io/server-snippet` verwenden. Ändern Sie den Inhalt des Server-Snippets nicht.
      3. Speichern und schließen Sie die Datei. Ihre Änderungen werden automatisch angewendet.
  * Stellen Sie zur Erstellung einer eigenen Statusprüfungsressource sicher, dass das folgende Snippet an Cloudflare zurückgegeben wird:
    ```
    { return 200 'healthy'; add_header Content-Type text/plain; }
    ```
    {: codeblock}

13. Erstellen Sie Ingress-Ressourcen für Ihre Apps. Führen Sie dazu die Schritte im Abschnitt [Apps in Ihrem Cluster öffentlich zugänglich machen](/docs/containers?topic=containers-ingress#ingress_expose_public) aus.

Ihre Apps werden jetzt von Ihrem angepassten Ingress-Controller bereitgestellt. Um die von IBM bereitgestellte ALB-Bereitstellung wiederherzustellen, aktivieren Sie die ALB erneut. Die ALB wird erneut implementiert und der LoadBalancer-Service wird automatisch so konfiguriert, dass er auf die ALB verweist.

```
ibmcloud ks alb-configure --albID <alb-id> --enable
```
{: pre}
