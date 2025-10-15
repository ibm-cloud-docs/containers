---

copyright:
  years: 2014, 2025
lastupdated: "2025-09-29"


keywords: kubernetes, envoy, sidecar, mesh, bookinfo

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Deploying custom Istio gateways in Helm
{: #istio-custom-gateway-helm}

Customize gateways by editing the resource that defines the ingress and egress gateways for Istio-managed app traffic.
{: shortdesc}

With the move to Helm for the Istio add-on version 1.24 and later, the `IstioOperator` custom resource is no longer used.

## Setting up Helm
{: #istio-helm-install}

Before you begin deploying and managing custom gateways, set up Helm.

1. [Install Helm](/docs/containers?topic=containers-helm#install_v3).

1. Add Istio's Helm repo.

    ```sh 
    helm repo add istio https://istio-release.storage.googleapis.com/charts
    ```
    {: pre}

1. Run the `helm repo update` command.

    ```sh 
    helm repo update
    ```
    {: pre}


## Modifying existing default gateways
{: #istio-custom-gateway}

The add-on deploys one customizable `istio-ingressgateway` and one customizable `istio-egressgateway`.  To customize the gateway ConfigMaps for the Helm charts, instead of adding a key-value pair like you do for the control plane, edit the multiline string in the `value.yaml` key.

These `value.yaml` files are found as multiline strings in the `managed-istio-ingressgateway-values` and `managed-istio-egressgateway-values` ConfigMaps in the `ibm-operators` namespace.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
  name: managed-istio-egressgateway-values
  namespace: ibm-operators
data:
  values.yaml: |
 ...
      resources:
        requests:
          cpu: 100m
          memory: 128Mi
        limits:
          cpu: 2000m
          memory: 1024Mi
```
{: codeblock}


To edit the `istio-ingressgateway` and `istio-egressgateway` `value.yaml` content:

1. Create a cluster.

1. [Install the managed Istio add-on](/docs/containers?topic=containers-istio&interface=ui#istio_install) 1.24 or later.

    ```sh
    ibmcloud ks cluster addon enable istio -c $CLUSTERID --version 1.24
    ```
    {: pre}

1. Get the `kubeconfig` of the cluster.

    ```sh
    ibmcloud ks cluster config -c $CLUSTERID
    ```
    {: pre}

1. Locate the two Istio gateway ConfigMaps that hold the `value.yaml` content for the ingress and egress gateways. 

    ```sh
    kubectl get cm -n ibm-operators
    ```
    Output:
    ```text
    NAME                                        DATA   AGE
    istio-ca-root-cert                          1      12m
    kube-root-ca.crt                            1      24h
    managed-istio-base-control-plane-values     2      13m
    managed-istio-custom                        1      13m
    managed-istio-egressgateway-values          2      13m
    managed-istio-ingressgateway-values         2      13m
    managed-istio-istiod-control-plane-values   2      13m
    ```
    {: screen}

1. Output the `values.yaml` of the gateways to a file. 

    ```sh
    kubectl get cm -n ibm-operators  managed-istio-ingressgateway-values -o json | jq -r .data.\"values.yaml\" > gateway-values.yaml; open gateway-values.yaml
    ```
    {: pre}

    Output:
    ```yaml
    # "_internal_defaults_do_not_set" is a workaround for Helm limitations. Users should NOT set "._internal_defaults_do_not_set" explicitly, but rather directly set the fields internally.
    # For instance, instead of `--set _internal_defaults_do_not_set.foo=bar``, just set `--set foo=bar`.
    _internal_defaults_do_not_set:
    # Name allows overriding the release name. Generally this should not be set
    name: ""

    serviceAccount:
      # If set, a service account will be created. Otherwise, the default is used
      create: true
      # Annotations to add to the service account
      annotations: {}
      # The name of the service account to use.
      # If not set, the release name is used
      name: "istio-ingressgateway-service-account"
    
    podAnnotations:
        prometheus.io/port: "15020"
        prometheus.io/scrape: "true"
        prometheus.io/path: "/stats/prometheus"
        inject.istio.io/templates: "gateway"
        sidecar.istio.io/inject: "true"

    service:
        # Egress gateways do not need an external LoadBalancer IP so they set "service.type: ClusterIP".
        # Type of service. Set to "None" to disable the service entirely
        type: LoadBalancer
        ports:
        - name: http2
        port: 80
        protocol: TCP
        targetPort: 8080
        - name: https
        port: 443
        protocol: TCP
        targetPort: 8443
        loadBalancerIP: ""
        loadBalancerSourceRanges: []
        externalTrafficPolicy: ""
        externalIPs: []
        ipFamilyPolicy: ""
        ipFamilies: []
        ## Whether to automatically allocate NodePorts (only for LoadBalancers).
        # allocateLoadBalancerNodePorts: false

    resources:
        requests:
        cpu: 100m
        memory: 128Mi
        limits:
        cpu: 2000m
        memory: 1024Mi

    autoscaling:
        enabled: true
        minReplicas: 2
        maxReplicas: 5
        targetCPUUtilizationPercentage: 80
        targetMemoryUtilizationPercentage: {}
        autoscaleBehavior: {}
    
    tolerations:
    - key: dedicated
        value: edge

    topologySpreadConstraints: []

    affinity:
        podAntiAffinity:
        preferredDuringSchedulingIgnoredDuringExecution:
        - podAffinityTerm:
            labelSelector:
                matchExpressions:
                - key: app
                operator: In
                values:
                - istio-ingressgateway
            topologyKey: kubernetes.io/hostname
            weight: 100
        nodeAffinity:
        preferredDuringSchedulingIgnoredDuringExecution:
        - preference:
            matchExpressions:
            - key: dedicated
                operator: In
                values:
                - edge
            weight: 100
    ```
    {: codeblock}

1. You can manage the data plane, including these gateways. Start with the default configuration, which includes automatic patch updates, a preferred pod anti-affinity, and, toleration and preference for edge nodes. You are responsible for the customizations you make. Unlike the control plane `value.yaml` files, you can edit the `value.yaml` files in these ConfigMaps.

    These are the resources created by the istio/gateway chart by using the default Ingress configuration. The same naming conventions are true for egress. 
    - `PodDisruptionBudget`, `Service`, `Deployment`, and `HorizontalPodAutoscaler` are named in `istio-ingressgateway` in the `istio-system` namespace. These names are set by the `name` fields in the `values.yaml`.
    - `ServiceAccount`, `Role`, and `Rolebinding` are named in `istio-ingressgateway-service-account` in the `istio-system` namespace. These names are set by the `serviceAccount.name` field in the `values.yaml`.

1. Test the changes you want to make by first making them in the saved `gateway-values.yaml`. Then use a dry run of Helm to see the manifest changes.

    Example:

    Shown below are example changes. Only the changes are being shown; the rest of the `values.yaml` content is unchanged. These example changes include:

    - Changing the names of the resources

    - Adjusting resource requests/limits

    - Increasing autoscaling

    - Adding a node affinity

        - If you are considering using node affinity to create zone affinities, you might also use `topologySpreadConstraints` instead.

    a. Revise the `values.yaml` content as necessary. 

    ```yaml
    name: "custom-gateway"

    serviceAccount:
        name: "custom-ingressgateway-service-account"

    resources:
        requests:
            cpu: 100m
            memory: 128Mi
        limits:
            cpu: 2500m
            memory: 1024Mi

    autoscaling:
        enabled: true
        minReplicas: 3
        maxReplicas: 7
        targetCPUUtilizationPercentage: 80
        targetMemoryUtilizationPercentage: {}
        autoscaleBehavior: {}            

    affinity:
        nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
            - key: ibm-cloud.kubernetes.io/zone
                operator: In
                values:
                - "dal10"
    ```
    {: codeblock}

    b. Use Helm with the `--dry-run` option to output a manifest so that you can confirm the syntax and that the configuration matches your intent.

    When you are targeting one of the default gateways, which are `istio-ingressgateway` or `istio-egressgateway`, only run this command with the `--dry-run` option. Do not run this command without the `--dry-run` option.
    {: important}

    ```sh
    helm upgrade istio-ingressgateway istio/gateway --version 1.24.0 --install -n istio-system -f gateway-values.yaml --dry-run
    ```
    {: pre}

1. If you are satisfied with the changes, then use `kubectl edit` to edit the gateway's `values.yaml` inside the ConfigMap it came from.

    a. Open `gateway-values.yaml` and indent the copy of the `values.yaml`file by 4 spaces.

    b. Run the `kubectl edit` command.

    ```sh
    kubectl edit cm -n ibm-operators managed-istio-ingressgateway-values
    ```
    {: pre}

    c. Delete the lines of the previous `values.yaml`.

    d. Start the `values.yaml` key with a multiline string. Example: `|`

    e. Copy your 4 space indented `values.yaml` file into the lines below the `values.yaml` key. 

    Example:
    ```yaml
    data:
      values.yaml: |
        <Copy values.yaml here.>
      values.yaml.helm.result: |
        <Don't remove these previous Helm logs.>
    ```
    {: codeblock}


1. After about 10 minutes, check for an updated Helm log in the `values.yaml.helm.result` field of that ConfigMap and debug as necessary. 

    ```sh
    kubectl get cm -n ibm-operators managed-istio-ingressgateway-values -o json | jq -r .data.\"values.yaml.helm.result\"
    ```
    {: pre}

    Example output:
    ```screen
    GMT HELM_SUCCESS: Release "istio-ingressgateway" does not exist. Installing it now. 
    NAME: istio-ingressgateway 
    LAST DEPLOYED: Fri Sep 5 16:46:30 2025 
    NAMESPACE: istio-system 
    STATUS: deployed REVISION: 1 
    TEST SUITE: None 
    NOTES: "istio-ingressgateway" successfully installed!

    To learn more about the release, try:
    $ helm status istio-ingressgateway -n istio-system
    $ helm get all istio-ingressgateway -n istio-system 
    
    Next steps: 
    * Deploy an HTTP Gateway: https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/ 
    * Deploy an HTTPS Gateway: https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/
    ```
    {: pre}

1. View the configuration options.

    

    c. Show the values.

    ```sh
    helm show values istio/gateway --version 1.24.6
    ```
    {: pre}

    d. Review the possible keys that could display.

    ```yaml
        name: # The gateway deployment's and service's name
        serviceAccount:
          name: # The service account, role, and rolebinding name
        resources: # Resource requests and limits
        autoscaling: # Min and Max gateway pods
        tolerations: # Tolerate your taints
        topologySpreadConstraints: # An alternative to node affinities
        affinity: # Where you can specify node affinities
    ```
    {: codeblock}


## Creating additional gateways
{: #custom_gateways_helm_add}

After customizing the default gateway that has one gateway deployment, you might want to configure additional gateways. Generate the resource manifest with Helm, then either apply it with Helm or with a CI/CD pipeline for YAML resources.


1. Run the `helm show values` command.
    ```sh 
    helm show values "istio/gateway" --version "1.24.0"
    ```
    {: pre}

1. Create a `values.yaml` file for the gateway. Because the gateway is already customized, you can use its `values.yaml` as a starting point. 

    ```sh
    kubectl get cm -n ibm-operators  managed-istio-ingressgateway-values -o json | jq -r .data.\"values.yaml\"
    ```
    {: pre}

1. Make sure that the gateway's `name` and `serviceAccount.name` don't match any other gateways in the cluster. When picking a Helm release name, consider the following conditions.

    - Avoid `istio-base`, `istiod`, `istio-ingressgateway`, and `istio-egressgateway` because the Istio managed add-on uses those release names.
    - Avoid using the release name of another of the additional gateways.

1. Do a dry run to see the manifest of the YAML resources for the gateway.

    ```sh
    helm upgrade --dry-run $RELEASE_NAME istio/gateway --version 1.24.0 --install -n $NAMESPACE -f values.yaml
    ```
    {: pre}

1. Apply those resources with one of the following methods:
    - Use the Helm `upgrade` command without the `--dry-run` option.
    - Take the manifest of the YAML resources and apply it as you would other Istio data plane YAML, depending on your cluster's CI/CD use case.




### Removing gateway deployments 
{: #remove-gateway-dep}

If you enabled `istio-ingressgateway-public-2`, `istio-ingressgateway-public-3`, or have any other custom gateway that you want to remove, locate and delete these resources.

1. Locate the gateways.
    ```sh
    gateway_name=$GATEWAY_NAME
    namespace=$NAMESPACE
    kubectl get PodDisruptionBudget -n $NAMESPACE $GATEWAY_NAME --ignore-not-found
    kubectl get Service -n $NAMESPACE $GATEWAY_NAME --ignore-not-found
    kubectl get Deployment -n $NAMESPACE $GATEWAY_NAME --ignore-not-found
    kubectl get HorizontalPodAutoscaler -n $NAMESPACE $GATEWAY_NAME --ignore-not-found
    kubectl get ServiceAccount -n $NAMESPACE --ignore-not-found | grep $GATEWAY_NAME
    kubectl get Role -n $NAMESPACE --ignore-not-found | grep $GATEWAY_NAME
    kubectl get RoleBinding -n $NAMESPACE --ignore-not-found | grep $GATEWAY_NAME
    ```
    {: codeblock}

2. Remove the gateways.

    Example for removing `custom-ingressgateway` in the `custom-gateways` namespace:
    ```sh
    kubectl delete PodDisruptionBudget -n istio-system istio-ingressgateway-public-2 --ignore-not-found
    kubectl delete Service -n istio-system istio-ingressgateway-public-2 --ignore-not-found
    kubectl delete Deployment -n istio-system istio-ingressgateway-public-2 --ignore-not-found
    kubectl delete HorizontalPodAutoscaler -n istio-system istio-ingressgateway-public-2 --ignore-not-found
    kubectl delete ServiceAccount -n istio-system istio-ingressgateway-public-2-service-account --ignore-not-found
    kubectl delete Role -n istio-system istio-ingressgateway-public-2-sds --ignore-not-found
    kubectl delete RoleBinding -n istio-system istio-ingressgateway-public-2-sds --ignore-not-found
    ```
    {: codeblock}


    Example output:
    ```screen
    NAME                            MIN AVAILABLE   MAX UNAVAILABLE   ALLOWED DISRUPTIONS   AGE
    istio-ingressgateway-public-2   N/A             N/A               0                     2m33s

    NAME                            TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
    istio-ingressgateway-public-2   LoadBalancer   172.21.227.3   169.46.62.156   80:32705/TCP,443:31154/TCP   2m32s

    NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
    istio-ingressgateway-public-2   2/2     2            2           2m33s

    NAME                            REFERENCE                                  TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
    istio-ingressgateway-public-2   Deployment/istio-ingressgateway-public-2   cpu: <unknown>/80%   2         5         2          2m34s
    istio-ingressgateway-public-2-service-account   0         2m34s
    istio-ingressgateway-public-2-sds   2025-09-09T17:20:46Z
    istio-ingressgateway-public-2-sds   Role/istio-ingressgateway-public-2-sds   2m34s
    ```
    {: codeblock}
