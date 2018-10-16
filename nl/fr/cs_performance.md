---

copyright:
  years: 2014, 2018
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

# Optimisation des performances
{: #kernel}

Si vous avez des exigences spécifiques en termes d'optimisation des performances, vous pouvez modifier les paramètres par défaut `sysctl` du noyau Linux sur les noeuds worker et dans les espaces de nom de réseau de pods dans {{site.data.keyword.containerlong}}.
{: shortdesc}

Les noeuds worker sont automatiquement mis à disposition avec des performances de noyau déjà optimisées, mais vous pouvez modifier les paramètres par défaut en appliquant un DaemonSet personnalisé à votre cluster. Le DaemonSet modifie les paramètres de tous les noeuds worker existants et les applique aux nouveaux noeuds worker mis à disposition dans le cluster. Aucun pod n'est affecté.

Pour optimiser les paramètres du noyau pour les pods d'application, vous pouvez insérer l'élément initContainer dans le fichier YAML `pod/ds/rs/deployment` pour chaque déploiement. L'élément initContainer est ajouté à chaque déploiement d'application figurant dans l'espace de nom du réseau de pods dont vous souhaitez optimiser les performances.

Ainsi, les exemples dans les sections suivantes changent le nombre maximal de connexions autorisées dans l'environnement via le paramètre `net.core.somaxconn` et la plage de ports éphémères via le paramètre `net.ipv4.ip_local_port_range`.

**Avertissement** : si vous choisissez de modifier les valeurs par défaut des paramètres du noyau, vous le faites à vos propres risques. Vous êtes responsable de l'exécution des tests sur les paramètres modifiés et de toute interruption potentielle qui serait provoquée par les paramètres modifiés dans votre environnement.

## Optimisation des performances de noeud worker
{: #worker}

Appliquez un [DaemonSet ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) pour modifier les paramètres du noyau sur l'hôte du noeud worker.

**Remarque** : vous devez disposer du [rôle d'accès Administrateur](cs_users.html#user-roles) pour exécuter  le modèle d'élément privilégié initContainer. Une fois que les conteneurs pour les déploiements sont initialisés, les privilèges sont supprimés.

1. Sauvegardez le DaemonSet suivant dans un fichier nommé `worker-node-kernel-settings.yaml`. Dans la section `spec.template.spec.initContainers`, ajoutez les zones et les valeurs pour les paramètres `sysctl` que vous désirez optimiser. Cet exemple de DaemonSet modifie les valeurs des paramètres `net.core.somaxconn` et `net.ipv4.ip_local_port_range`.
    ```
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    metadata:
      name: kernel-optimization
      namespace: kube-system
      labels:
        tier: management
        app: kernel-optimization
    spec:
      template:
        metadata:
          labels:
            name: kernel-optimization
        spec:
          hostNetwork: true
          hostPID: true
          hostIPC: true
          initContainers:
            - command:
                - sh
                - -c
                - sysctl -w net.ipv4.ip_local_port_range="1025 65535"; sysctl -w net.core.somaxconn=32768;
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
                capabilities:
                  add:
                    - NET_ADMIN
              volumeMounts:
                - name: modifysys
                  mountPath: /sys
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                    sleep 100000;
                  done
          volumes:
            - name: modifysys
              hostPath:
                path: /sys
    ```
    {: codeblock}

2. Appliquez le DaemonSet à vos noeuds worker. Les modifications sont appliquées immédiatement.
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

Pour rétablir les valeurs par défaut des paramètres `sysctl` de vos noeuds worker, définis par {{site.data.keyword.containerlong_notm}} :

1. Supprimez le DaemonSet. Les éléments initContainers qui avaient appliqué les paramètres personnalisés sont supprimés.
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [Réamorcez tous les noeuds worker dans le cluster](cs_cli_reference.html#cs_worker_reboot). Les noeuds worker sont à nouveau en ligne dès que les valeurs par défaut sont appliquées.

<br />


## Optimisation des performances de pod
{: #pod}

Si vous avez des exigences spécifiques en matière de charge de travail, vous pouvez appliquer un correctif [initContainer ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) pour modifier les paramètres du noyau pour les pods d'application.
{: shortdesc}

**Remarque** : vous devez disposer du [rôle d'accès Administrateur](cs_users.html#user-roles) pour exécuter  le modèle d'élément privilégié initContainer. Une fois que les conteneurs pour les déploiements sont initialisés, les privilèges sont supprimés.

1. Sauvegardez le correctif initContainer suivant dans un fichier nommé `pod-patch.yaml` et ajoutez les zones et les valeurs pour les paramètres `sysctl` que vous désirez optimiser. Cet exemple de correctif initContainer modifie les valeurs des paramètres `net.core.somaxconn` et `net.ipv4.ip_local_port_range`.
    ```
    spec:
      template:
        spec:
          initContainers:
          - command:
            - sh
            - -c
            - sysctl -e -w net.core.somaxconn=32768;  sysctl -e -w net.ipv4.ip_local_port_range="1025 65535";
            image: alpine:3.6
            imagePullPolicy: IfNotPresent
            name: sysctl
            resources: {}
            securityContext:
              privileged: true
    ```
    {: codeblock}

2. Appliquez le correctif à chacun de vos déploiements.
    ```
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. Si vous avez modifié la valeur `net.core.somaxconn` dans les paramètres du noyau, la plupart des applications peuvent utiliser automatiquement la valeur mise à jour. En revanche, certaines applications pourront nécessiter la modification manuelle de la valeur correspondante dans le code de votre application pour qu'elle corresponde à la valeur du noyau. Par exemple si vous optimisez les performances d'un pod dans lequel s'exécute une application NGINX, vous devez modifier la valeur de la zone `backlog` dans le code d'application NGINX pour qu'elle corresponde. Pour plus d'informations, reportez-vous à cet [article du blogue NGINX ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.nginx.com/blog/tuning-nginx/).
