---

copyright: 
  years: 2014, 2025
lastupdated: "2025-08-01"


keywords: kubernetes, containers, infrastructure, rbac, policy

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}

# Authorizing resources with IAM trusted profiles
{: #pod-iam-identity}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}

Learn how to setup access to or for your resources by using trusted profiles. 
{: shortdesc}

You can enable IAM trusted profiles by running the [`ibmcloud ks cluster master refresh`](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh) command.
{: tip}



## Creating an IAM trusted profile 
{: #iam-trusted-profile-create}

To create a trusted profile in your account, see [Creating trusted profiles](/docs/account?topic=account-create-trusted-profile&interface=ui) in the IAM documentation. Note that to create a trusted profile, you must be the account owner. Additionally, the following access roles are required.
- Administrator role for all account management services.
- Administrator role on the IAM Identity Service. For more information, see [IAM Identity Service](/docs/account?topic=account-account-services&interface=ui#identity-service-account-management). 


## Configure your application pods to authenticate with {{site.data.keyword.cloud_notm}} services
{: #iam-identity-pod}

Give application pods that run in your {{site.data.keyword.containerlong}} cluster access to {{site.data.keyword.cloud_notm}} services by using trusted profiles in {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM). As a developer, you can configure your application pods to authenticate with {{site.data.keyword.cloud_notm}} services in clusters that are linked to an IAM trusted profile set up.
{: shortdesc}

To complete these steps, you do not need to have the administrator access role. However, you must meet the following requirements: **Viewer** [platform](/docs/containers?topic=containers-iam-platform-access-roles) access role; **Writer** [service](/docs/containers?topic=containers-iam-platform-access-roles) access role for the cluster in {{site.data.keyword.cloud_notm}} IAM for **{{site.data.keyword.containershort}}**; the `iam-identity.profile.create` and `iam-identity.profile.linkToResource` actions for the [IAM identity service](/docs/account?topic=account-iam-service-roles-actions#iam-identity-roles).
{: note}

Before you begin:
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
* Make sure that your account administrator [created an IAM trusted profile for your cluster](/docs/containers?topic=containers-pod-iam-identity&interface=api#iam-identity-create-api).

To configure your application pods to authenticate with {{site.data.keyword.cloud_notm}} services:

1. Design your pod configuration file to use [service account token volume projection](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#service-account-token-volume-projection){: external}. 
    1. In the `containers` section, mount the identity token in the `volumeMounts` section.
        ```yaml
        ...
            volumeMounts:
            - mountPath: /var/run/secrets/tokens
              name: sa-token
        ```
        {: codeblock}

    1. In the `volumes` section, set up the service account token volume projection.

        Modify the `expirationSeconds` field to control how long the token is valid for. To retrieve IAM tokens, the service account token expiration must be 1 hour or less.
        {: tip}

        ```yaml
        ...
        volumes:
          - name: sa-token
            projected:
              sources:
              - serviceAccountToken:
                  path: sa-token
                  expirationSeconds: 3600
                  audience: iam
        ...
        ```
        {: codeblock}

1. Design your app to exchange the service account projected token for an IAM token that you can use for subsequent API calls to {{site.data.keyword.cloud_notm}} services. Review the following example authentication request. Replace `${profile_id}` with the ID of the trusted profile that the cluster is linked to. To list available profile IDs, you or the account administrator can use the `ibmcloud iam tps` command, the `GET 'https://iam.cloud.ibm.com/v1/profiles/?account_id=<account_id>'`, or you can view the trusted profiles in the [IAM console](https://cloud.ibm.com/iam/trusted-profiles/){: external}.

    ```sh
    curl -s -X POST \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "Accept: application/json" \
        -d grant_type=urn:ibm:params:oauth:grant-type:cr-token \
        -d cr_token=$(cat /var/run/secrets/tokens/sa-token) \
        -d profile_id=${profile_id} \
        https://iam.cloud.ibm.com/identity/token
    ```
    {: codeblock}

1. Before your app is deployed, try the following example Kubernetes job to test the token exchange. In the following Kubernetes job, a `curl` pod makes an API request to {{site.data.keyword.cloud_notm}} IAM to verify that the cluster's public key is exchanged for an IAM access token. Your app might call other {{site.data.keyword.cloud_notm}} services that the trusted profile authorizes.

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: token-exchange-job
      namespace: default
    spec:
      template:
        spec:
          containers:
          - name: curl
            image: curlimages/curl:7.77.0
            command: ["/bin/sh"]
            args: ["-c", "curl -s -H \"Content-Type: application/x-www-form-urlencoded\" -H \"Accept: application/json\" -d grant_type=urn:ibm:params:oauth:grant-type:cr-token -d cr_token=$(cat /var/run/secrets/tokens/sa-token) -d profile_id=<profile_id> https://iam.cloud.ibm.com/identity/token"]
            volumeMounts:
            - mountPath: /var/run/secrets/tokens
              name: sa-token
          restartPolicy: Never
          serviceAccountName: default
          volumes:
          - name: sa-token
            projected:
              sources:
              - serviceAccountToken:
                  path: sa-token
                  expirationSeconds: 3600
                  audience: iam
    ```
    {: codeblock}

1. Deploy the job.
    ```sh
    kubectl apply -f exchange-job.yaml
    ```
    {: pre}

1. Review the job details to verify it was successful.
    ```sh
    kubectl describe job token-exchange-job
    ```
    {: pre}

1. Review the output for the `job completed` and `succeeded` messages to verify the job was a success.

1. If the job succeeded, check your {{site.data.keyword.cloudaccesstrailshort}} global events in Frankfurt to verify the log line with details on the Trusted Profile request. If the job failed, review your configuration and try again.
