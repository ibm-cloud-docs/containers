---

copyright:
  years: 2026, 2026
lastupdated: "2026-06-23"


keywords: kubernetes, headlamp, dashboard, add-on, gui

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Setting up the Headlamp add-on
{: #headlamp-addon}

Headlamp is a Kubernetes dashboard that provides a graphical user interface for managing and monitoring your cluster resources. The Headlamp add-on for {{site.data.keyword.containerlong}} provides a seamless installation of Headlamp with automatic lifecycle management and integration with {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) for authentication.
{: shortdesc}

## Understanding the Headlamp add-on
{: #headlamp-addon-about}

The Headlamp add-on is the recommended replacement for the archived kubernetes-dashboard project. Headlamp provides a modern, user-friendly interface for viewing and managing Kubernetes resources in your cluster.
{: shortdesc}

Key features of the Headlamp add-on include:

- **IAM OIDC authentication**: Seamlessly authenticate with your {{site.data.keyword.cloud_notm}} account using IAM OIDC.
- **Independent lifecycle management**: The add-on version is decoupled from cluster master BOM versions, allowing for independent updates.
- **Ready to Access**: The add-on is automatically exposed through an Ingress resource on your cluster's default public ingress hostname with a `headlamp` subdomain.
- **Secure access**: Each cluster receives a unique OIDC client ID to prevent authentication spoofing attacks.

## Prerequisites
{: #headlamp-prereqs}

Before you install the Headlamp add-on, ensure that your cluster meets the following requirements:

- You must have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service access role](/docs/containers?topic=containers-iam-platform-access-roles) for {{site.data.keyword.containerlong_notm}}.
- Your cluster must be running a [supported Kubernetes version](/docs/containers?topic=containers-cs_versions).
- For Classic clusters, you must [enable VRF and service endpoints](/docs/account?topic=account-vrf-service-endpoint&interface=ui).
- Your browser must have access to:
    - The cluster's default ingress hostname.
    - The {{site.data.keyword.cloud_notm}} IAM authorization endpoint at `https://iam.cloud.ibm.com`.

## Installing the Headlamp add-on
{: #headlamp-install}

The Headlamp add-on is currently only available through the CLI. You cannot install or manage the add-on from the {{site.data.keyword.cloud_notm}} console.
{: note}

### Installing the Headlamp add-on with the CLI
{: #headlamp-install-cli}


1. Target your cluster.
    ```sh
    ibmcloud ks cluster config --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Enable the `headlamp` add-on.
    ```sh
    ibmcloud ks cluster addon enable headlamp --cluster <cluster_name_or_ID>
    ```
    {: pre}

3. Verify that the Headlamp add-on has a status of `Addon Ready`.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output:
    ```sh
    NAME       Version   Health State   Health Status
    headlamp   0.1.0     normal         Addon Ready
    ```
    {: screen}

4. Verify that the Headlamp pods are running.
    ```sh
    kubectl get pods -n ibm-system -l app.kubernetes.io/name=addon-headlamp
    ```
    {: pre}

## Accessing the Headlamp dashboard
{: #headlamp-access}

After you install the Headlamp add-on, you can access the dashboard through your cluster's default ingress hostname.
{: shortdesc}

1. Get your cluster's default ingress hostname.
    ```sh
    ibmcloud ks cluster get --cluster <cluster_name_or_ID> | grep "Ingress Subdomain"
    ```
    {: pre}

2. Open your browser and navigate to `https://headlamp.<ingress_subdomain>`, where `<ingress_subdomain>` is your cluster's default ingress hostname.

    Example: `https://headlamp.mycluster-abc123-0000.us-south.containers.appdomain.cloud`

3. Click **Sign In** to authenticate with {{site.data.keyword.cloud_notm}} IAM.

4. If you're not already logged in to {{site.data.keyword.cloud_notm}}, you'll be redirected to the IAM login page. After authentication, you'll be redirected back to the Headlamp dashboard.

5. Once authenticated, you can view and manage your cluster resources through the Headlamp interface.

## Migrating from kubernetes-dashboard
{: #headlamp-migrate-kube-dashboard}

The Kubernetes community has archived the kubernetes-dashboard project. After you install the Headlamp add-on, you can scale down the kubernetes-dashboard deployment if it's running in your cluster.

To scale down the kubernetes-dashboard deployment after installing Headlamp:

```sh
kubectl scale deployment -n kube-system kubernetes-dashboard --replicas=0
kubectl scale deployment -n kube-system dashboard-metrics-scraper --replicas=0
```
{: pre}

## Understanding Headlamp authentication
{: #headlamp-auth}

The Headlamp add-on uses {{site.data.keyword.cloud_notm}} IAM OIDC authentication to secure access to your cluster resources.
{: shortdesc}

When you enable the Headlamp add-on, the following authentication components are automatically configured:

- **Unique client ID**: A unique OIDC client ID is created for your cluster and stored in a Kubernetes secret in the `ibm-system` namespace.
- **Hybrid private-public OIDC**: Headlamp uses private IAM endpoints for backchannel requests, while frontchannel - login in the browser - happens over public IAM endpoints.
- **Token management**: Authentication tokens are stored in browser cookies and automatically included in requests to the Kubernetes API server.

The authentication flow works as follows:

1. When you access the Headlamp dashboard, you're presented with a login page.
2. Clicking **Sign In** redirects you to the public {{site.data.keyword.cloud_notm}} IAM authorization endpoint.
3. After successful authentication, IAM redirects you back to Headlamp with an authorization code.
4. Headlamp exchanges the authorization code for an access token over private network.
5. The access token is used to authenticate requests to the Kubernetes API server.

Your access to cluster resources is determined by your {{site.data.keyword.cloud_notm}} IAM roles and Kubernetes RBAC permissions enforced by the Kubernetes API server.

## Updating the Headlamp add-on
{: #headlamp-update}

The Headlamp add-on is automatically updated when new versions are released. You can check the current version and health status of the add-on at any time.
{: shortdesc}

To check the add-on version:

```sh
ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
```
{: pre}

## Disabling the Headlamp add-on
{: #headlamp-disable}

If you no longer need the Headlamp dashboard, you can disable the add-on.
{: shortdesc}

When you disable the Headlamp add-on, the following resources are removed:
- Headlamp deployment and pods
- Headlamp service and ingress resources
- OIDC client ID and associated secrets

### Disabling the Headlamp add-on with the CLI
{: #headlamp-disable-cli}


1. Disable the Headlamp add-on.
    ```sh
    ibmcloud ks cluster addon disable headlamp --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Verify that the add-on is removed.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

## Accessing Headlamp over private ingress on VPC clusters
{: #headlamp-private-ingress}

Configure your VPC cluster to access Headlamp through private ingress instead of public ingress for enhanced security.
{: shortdesc}

When you choose to access Headlamp from private networks, like over a VPC VPN, you can reconfigure your cluster with the following steps:

1. Disable your cluster's public ALB.
    ```sh
    ibmcloud ks ingress alb disable --cluster <cluster_name_or_ID> --alb <public_ALB_ID>
    ```
	{: pre}

2. Enable private ingress.
    ```sh
    ibmcloud ks ingress alb enable vpc-gen2 --cluster <cluster_name_or_ID> --alb <private_ALB_ID>
    ```
	{: pre}

3. Register a domain to the private ALB.
    ```sh
    ibmcloud ks ingress domain create --cluster <cluster_name_or_ID> --hostname $<private_ALB_ID_hostname>
    ```
	{: pre}


4. Set the new domain as the default.
    ```sh
    ibmcloud ks ingress domain default replace --cluster <cluster_name_or_ID> --domain <new_domain>
    ```
    {: pre}


The IBM Cloud backend updates headlamp in approximately 5 minutes. When the update completes, the dashboard is available on the new default ingress hostname, with `headlamp.` subdomain.

## Kubernetes resources created by the addon
{: #headlamp-k8s-resources}


The Headlamp addon creates several Kubernetes resources in your cluster that require proper network configuration.
{: shortdesc}

If you have a custom firewall or network settings, you need to configure that to allow communication between the following resources:
* 2 **Ingress** resources
    + private with private-iks-k8s-nginx ingressClass
    + public with public-iks-k8s-nginx ingressClass
* 1 **Service** (ClusterIP on port 80 → 4466)
* 1 **Deployment** 
    + headlamp container (port 4466)
    + nginx sidecar container

## Enable OIDC for Headlamp add-on over public endpoints
{: #headlamp-oidc-override}

If your cluster cannot connect to private IAM endpoints, override the OIDC endpoint settings to use public endpoints.
{: shortdesc}

These steps assume that the cluster can access the IAM public endpoints.

Before you begin, ensure that `kubectl` is configured for the cluster.

1. Open the `headlamp-values` ConfigMap for editing:
    ```sh
    kubectl edit cm -n ibm-system headlamp-values
    ```
    {: pre}

    In the editor, add the following to the `data` section. Replace `<account_id>` with the ID of the account where the cluster is deployed.
    ```yaml
    data:
      values.yaml: |-
        oidc:
          overrides:
            tokenEndpointUrl: "https://iam.cloud.ibm.com/identity/token?account=<account_id>"
            jwksUri: "https://iam.cloud.ibm.com/identity/keys"
    ```

2. Wait up to 5 minutes for the updated values to propagate to the cluster.

3. Restart the Headlamp deployment:
    ```sh
    kubectl rollout restart deployment/headlamp -n ibm-system
    ```
    {: pre}

## Troubleshooting the Headlamp add-on
{: #headlamp-troubleshooting}

Use the following information to troubleshoot common issues with the Headlamp add-on.
{: shortdesc}

### Cannot access the Headlamp dashboard
{: #headlamp-ts-access}

If you can't access the Headlamp dashboard, verify the following:

1. Check that the add-on is installed and healthy.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Verify that the Headlamp pods are running.
    ```sh
    kubectl get pods -n ibm-system -l app.kubernetes.io/name=addon-headlamp
    ```
    {: pre}

3. Check that the ingress resource is configured correctly.
    ```sh
    kubectl get ingress -n ibm-system
    ```
    {: pre}

4. For public-only clusters, verify that network security rules allow outbound HTTPS connections to public IAM endpoints. If needed, see [Enable OIDC for Headlamp add-on over public endpoints](#headlamp-oidc-override) to update the OIDC configuration.

### Authentication fails
{: #headlamp-ts-auth}

If authentication fails when accessing the Headlamp dashboard:

1. Verify that you have the necessary IAM permissions to access the cluster.

2. Check that your browser can access `https://iam.cloud.ibm.com`.

3. Clear your browser cookies and try again.

4. Verify that the OIDC client ID secret exists in your cluster.
    ```sh
    kubectl get secret clientid-secrets -n ibm-system
    ```
    {: pre}

### Pods are not running
{: #headlamp-ts-pods}

If the Headlamp pods are not running:

1. Check the pod status and events.
    ```sh
    kubectl describe pods -n ibm-system -l app.kubernetes.io/name=addon-headlamp
    ```
    {: pre}

2. Check the pod logs for errors.
    ```sh
    kubectl logs -n ibm-system -l app.kubernetes.io/name=addon-headlamp
    ```
    {: pre}
