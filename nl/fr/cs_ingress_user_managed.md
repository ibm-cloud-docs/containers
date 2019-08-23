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


# Utilisation de votre propre contrôleur Ingress
{: #ingress-user_managed}

Utilisez votre propre contrôleur Ingress à exécuter sur {{site.data.keyword.cloud_notm}} et optimisez un nom d'hôte et un certificat TLS fournis par IBM.
{: shortdesc}

Les équilibreurs de charge d'application (ALB) Ingress fournis par IBM sont basés sur des contrôleurs NGINX que vous pouvez configurer en utilisant des [annotations {{site.data.keyword.cloud_notm}} personnalisées](/docs/containers?topic=containers-ingress_annotation). En fonction de ce que votre application requiert, vous souhaiterez peut-être configurer votre propre contrôleur Ingress personnalisé. Lorsque vous fournissez votre propre contrôleur Ingress au lieu d'utiliser l'ALB Ingress fourni par IBM, il vous incombe de fournir l'image du contrôleur et d'assurer la maintenance et la mise à jour du contrôleur ainsi que les mises à jour de sécurité nécessaires pour protéger le contrôleur Ingress des vulnérabilités. **Remarque** : L'utilisation de votre propre contrôleur Ingress n'est prise en charge que pour fournir un accès externe public à vos applications et elle n'est pas prise en charge pour fournir un accès externe privé.

Deux méthodes vous permettent de fournir votre propre contrôleur Ingress :
* [Créez un équilibreur de charge de réseau (NLB) pour exposer votre déploiement de contrôleur Ingress personnalisé, puis créez un nom d'hôte pour l'adresse IP NLB](#user_managed_nlb). {{site.data.keyword.cloud_notm}} fournit un nom d'hôte et se charge de générer et gérer un certificat SSL générique pour le nom d'hôte. Pour plus d'informations sur les noms d'hôte DNS NLB fournis par IBM, voir [Enregistrement d'un nom d'hôte NLB](/docs/containers?topic=containers-loadbalancer_hostname).
* [Désactivez le déploiement d'ALB fourni par IBM et utilisez le service d'équilibreur de charge qui a exposé l'ALB et l'enregistrement DNS pour le sous-domaine Ingress fourni par IBM.](#user_managed_alb) Cette option vous permet d'optimiser le sous-domaine Ingress et le certificat TLS qui sont déjà affectés à votre cluster.

## Exposition de votre contrôleur Ingress en créant un NLB et un nom d'hôte
{: #user_managed_nlb}

Créez un équilibreur de charge de réseau (NLB) pour exposer votre déploiement de contrôleur Ingress personnalisé, puis créez un nom d'hôte pour l'adresse IP NLB.
{: shortdesc}

1. Obtenez le fichier de configuration de votre contrôleur Ingress. Par exemple, vous pouvez utiliser le [contrôleur Ingress de communauté NGINX générique de cloud ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic). Si vous utilisez le contrôleur de communauté, éditez le fichier `kustomization.yaml` en procédant comme indiqué ci-après.
  1. Remplacez `namespace: ingress-nginx` par `namespace: kube-system`.
  2. Dans la section `commonLabels`, remplacez les libellés `app.kubernetes.io/name: ingress-nginx` et `app.kubernetes.io/part-of: ingress-nginx` par un libellé `app: ingress-nginx`.

2. Déployez votre propre contrôleur Ingress. Par exemple, pour utiliser le contrôleur Ingress de communauté NGINX générique de cloud, exécutez la commande suivante :
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

3. Définissez un équilibreur de charge pour exposer votre déploiement Ingress personnalisé.
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

4. Créez le service dans votre cluster.
    ```
    kubectl apply -f my-lb-svc.yaml
    ```
    {: pre}

5. Obtenez l'adresse **EXTERNAL-IP** pour l'équilibreur de charge.
    ```
    kubectl get svc my-lb-svc -n kube-system
    ```
    {: pre}

    Dans l'exemple suivant, la valeur de **EXTERNAL-IP** est `168.1.1.1`.
    ```
    NAME         TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)            AGE
    my-lb-svc    LoadBalancer   172.21.xxx.xxx   168.1.1.1        80:30104/TCP       2m
    ```
    {: screen}

6. Enregistrez l'adresse IP d'équilibreur de charge en créant un nom d'hôte DNS.
    ```
    ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <LB_IP>
    ```
    {: pre}

7. Vérifiez que le nom d'hôte est créé.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Exemple de sortie :
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
  ```
  {: screen}

8. Facultatif : [Activez les diagnostics d'intégrité sur le nom d'hôte en créant un moniteur d'état](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor).

9. Déployez les autres ressources nécessaires à votre contrôleur Ingress personnalisé, par exemple configmap.

10. Créez des ressources Ingress pour vos applications. Vous pouvez utiliser la documentation Kubernetes pour créer [un fichier de ressources Ingress ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/ingress/) et utiliser des [annotations ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/).
  <p class="tip">Si vous continuez à utiliser des ALB fournis par IBM- en même temps que votre contrôleur Ingress personnalisé dans un cluster, vous pouvez créer des ressources Ingress distinctes pour vos ALB et pour votre contrôleur personnalisé. Dans la [ressource Ingress que vous créez pour les ALB IBM uniquement](/docs/containers?topic=containers-ingress#ingress_expose_public), ajoutez l'annotation <code>kubernetes.io/ingress.class: "iks-nginx"</code>.</p>

11. Accédez à votre application en utilisant le nom d'hôte d'équilibreur de charge que vous avez identifié à l'étape 7 et le chemin d'écoute de votre application que vous avez spécifié dans le fichier de ressources Ingress.
  ```
  https://<load_blanacer_host_name>/<app_path>
  ```
  {: codeblock}

## Exposez votre contrôleur Ingress en utilisant l'équilibreur de charge et le sous-domaine Ingress existants
{: #user_managed_alb}

Désactivez le déploiement d'ALB fourni par IBM et utilisez le service d'équilibreur de charge qui a exposé l'ALB et l'enregistrement DNS pour le sous-domaine Ingress fourni par IBM.
{: shortdesc}

1. Obtenez l'ID de l'ALB public par défaut. Le format de l'ALB public est semblable à `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. Désactivez l'ALB public par défaut. L'indicateur `--disable-deployment` désactive le déploiement de l'ALB fourni par IBM, mais ne supprime pas l'enregistrement DNS du sous-domaine Ingress fourni par IBM ou le service d'équilibreur de charge utilisé pour exposer le contrôleur Ingress.
    ```
    ibmcloud ks alb-configure --albID <ALB_ID> --disable-deployment
    ```
    {: pre}

3. Obtenez le fichier de configuration de votre contrôleur Ingress. Par exemple, vous pouvez utiliser le [contrôleur Ingress de communauté NGINX générique de cloud ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic). Si vous utilisez le contrôleur de communauté, éditez le fichier `kustomization.yaml` en procédant comme indiqué ci-après.
  1. Remplacez `namespace: ingress-nginx` par `namespace: kube-system`.
  2. Dans la section `commonLabels`, remplacez les libellés `app.kubernetes.io/name: ingress-nginx` et `app.kubernetes.io/part-of: ingress-nginx` par un libellé `app: ingress-nginx`.
  3. Dans la variable `SERVICE_NAME`, remplacez `name: ingress-nginx` par `name: <ALB_ID>`. Par exemple, l'ID ALB identifié à l'étape peut se présenter comme suit : `name: public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.

4. Déployez votre propre contrôleur Ingress. Par exemple, pour utiliser le contrôleur Ingress de communauté NGINX générique de cloud, exécutez la commande suivante : **Important** : pour continuer à utiliser le service d'équilibreur de charge exposant le contrôleur et le sous-domaine Ingress fourni par IBM, votre contrôleur doit être déployé dans l'espace de nom `kube-system`.
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

5. Obtenez le libellé de votre déploiement Ingress personnalisé.
    ```
    kubectl get deploy <ingress-controller-name> -n kube-system --show-labels
    ```
    {: pre}

    Dans l'exemple suivant, la valeur du libellé est `ingress-nginx`:
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

6. En utilisant l'ID ALB que vous avez obtenu à l'étape 1, ouvrez le service d'équilibreur de charge qui expose l'ALB IBM.
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

7. Mettez à jour le service d'équilibreur de charge pour qu'il pointe vers votre déploiement Ingress personnalisé. Sous `spec/selector`, supprimez l'ID de l'ALB du libellé `app` et ajoutez le libellé de votre propre contrôleur Ingress que vous avez obtenu à l'étape 5.
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
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. Facultatif : par défaut, le service d'équilibreur de charge autorise le trafic sur les ports 80 et 443. Si votre contrôleur Ingress personnalisé nécessite un autre ensemble de ports, ajoutez ces ports dans la section `ports`.

8. Sauvegardez et fermez le fichier de configuration. La sortie est similaire à ceci :
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

9. Vérifiez que l'ALB `Selector` pointe désormais sur votre contrôleur.
    ```
    kubectl describe svc <ALB_ID> -n kube-system
    ```
    {: pre}

    Exemple de sortie :
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
    Events:                   <none>
    ```
    {: screen}

10. Déployez les autres ressources nécessaires à votre contrôleur Ingress personnalisé, par exemple configmap.

11. Si vous disposez d'un cluster à zones multiples, répétez ces étapes pour chaque ALB.

12. Si vous disposez d'un cluster à zones multiples, vous devez configurer un diagnostic d'intégrité. Le noeud final de diagnostic d'intégrité DNS Cloudflare, `albhealth.<clustername>.<region>.containers.appdomain.com`, s'attend à recevoir une réponse `200` avec un corps sain (`healthy`) dans la réponse. Si aucun diagnostic d'intégrité n'est configuré pour renvoyer `200` et `healthy`, le diagnostic d'intégrité retire les adresses IP ALB du pool DNS. Vous pouvez éditer la ressource de diagnostic d'intégrité existante ou créez votre propre ressource.
  * Pour éditer la ressource de diagnostic d'intégrité existante :
      1. Ouvrez la ressource `alb-health`.
        ```
        kubectl edit ingress alb-health --namespace kube-system
        ```
        {: pre}
      2. Dans la section `metadata.annotations`, remplacez le nom d'annotation `ingress.bluemix.net/server-snippets` par l'annotation prise en charge par votre contrôleur. Par exemple, vous pourrez utiliser l'annotation `nginx.ingress.kubernetes.io/server-snippet`. Ne modifiez pas le contenu du fragment de serveur.
      3. Sauvegardez puis fermez le fichier. Vos modifications sont automatiquement appliquées.
  * Pour créer votre propre ressource de diagnostic d'intégrité, assurez-vous que le fragment suivant est renvoyé à Cloudflare :
    ```
    { return 200 'healthy'; add_header Content-Type text/plain; }
    ```
    {: codeblock}

13. Créez des ressources Ingress pour vos applications en suivant les étapes indiquées à la section [Exposition au public d'applications figurant dans votre cluster](/docs/containers?topic=containers-ingress#ingress_expose_public).

Vos applications sont désormais exposées par votre contrôleur Ingress personnalisé. Pour rétablir le déploiement de l'ALB fourni par IBM, réactivez l'ALB. L'ALB est redéployé et le service d'équilibreur de charge est automatiquement reconfiguré pour pointer vers l'ALB.

```
ibmcloud ks alb-configure --albID <alb ID> --enable
```
{: pre}
