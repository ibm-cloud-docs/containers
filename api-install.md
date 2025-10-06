---

copyright: 
  years: 2014, 2025
lastupdated: "2025-10-06"


keywords: containers, {{site.data.keyword.containerlong_notm}}, kubernetes, ic, ks, kubectl, api

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# Setting up the API
{: #cs_api_install}

You can use the {{site.data.keyword.containerlong}} API to create and manage your community Kubernetes or {{site.data.keyword.redhat_openshift_notm}} clusters. To use the CLI, see [Setting up the CLI](/docs/containers?topic=containers-cli-install).
{: shortdesc}

## About the API
{: #api_about}

The {{site.data.keyword.containerlong_notm}} API automates the provisioning and management of {{site.data.keyword.cloud_notm}} infrastructure resources for your clusters so that your apps have the compute, networking, and storage resources that they need to serve your users.
{: shortdesc}

The API supports the different infrastructure providers that are available for you to create clusters. For more information, see [the infrastructure provider overview](/docs/containers?topic=containers-overview#what-compute-infra-is-offered).

You can use the version two (`v2`) API to manage both classic and VPC clusters. The `v2` API is designed to avoid breaking existing functionality when possible. However, make sure that you review the following differences between the `v1` and `v2` API.    

API endpoint prefix
:    v1 API: `https://containers.cloud.ibm.com/global/v1`
:    v2 API: `https://containers.cloud.ibm.com/global/v2`

API reference docs
:    v1 API: [`https://containers.cloud.ibm.com/global/swagger-global-api/`](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external}
:    v2 API: [`https://containers.cloud.ibm.com/global/swagger-global-api/`](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external}.

API architectural style
:    v1 API: Representational state transfer (REST) that focuses on resources that you interact with through HTTP methods such as `GET`, `POST`, `PUT`, `PATCH`, and `DELETE`.
:    v2 API: Remote procedure calls (RPC) that focus on actions through only `GET` and `POST` HTTP methods.

Supported container platforms
:    v1 API: Use the {{site.data.keyword.containerlong_notm}} API to manage your {{site.data.keyword.cloud_notm}} infrastructure resources, such as worker nodes, for **both community Kubernetes and {{site.data.keyword.redhat_openshift_notm}} clusters**.
:    v2 API: Use the {{site.data.keyword.containerlong_notm}} `v2` API to manage your {{site.data.keyword.cloud_notm}} infrastructure resources, such as worker nodes, for **both community Kubernetes and {{site.data.keyword.redhat_openshift_notm}} VPC clusters**.

  
Kubernetes API
:    v1 API: To use the Kubernetes API to manage Kubernetes resources within the cluster, such as pods or namespaces, see [Working with your cluster by using the Kubernetes API](#kube_api).
:    v2 API: Same as `v1`; see [Working with your cluster by using the Kubernetes API](#kube_api).

Supported APIs by infrastructure type
:    v1 API: `classic`
:    v2 API: `vpc` and `classic`
     - The `vpc` provider is designed to support multiple VPC subproviders. The supported VPC subprovider is `vpc-gen2`, which corresponds to a VPC cluster for Generation 2 compute resources.
     - Provider-specific requests have a path parameter in the URL, such as `v2/vpc/createCluster`. Some APIs are only available to a particular provider, such as `GET vlan` for classic or `GET vpcs` for VPC.
     - Provider-neutral requests can include a provider-specific body parameter that you specify, usually in JSON, such as `{"provider": "vpc"}`, if you want to return responses for only the specified provider.

`GET` responses
:    v1 API: The `GET` method for a collection of resources (such as `GET v1/clusters`) returns the same details for each resource in the list as a `GET` method for an individual resource (such as `GET v1/clusters/{idOrName}`).
:    v2 API: To return responses faster, the v2 `GET` method for a collection of resources (such as `GET v2/clusters`) returns only a subset of information that is detailed in a `GET` method for an individual resource (such as `GET v2/clusters/{idOrName}`).
     Some list responses include a providers property to identify whether the returned item applies to classic or VPC infrastructure. For example, the `GET zones` list returns some results such as `mon01` that are available only in the classic infrastructure provider, while other results such as `us-south-01` are available only in the VPC infrastructure provider.

Cluster, worker node, and worker-pool responses
:    v1 API: Responses include only information that is specific to the classic infrastructure provider, such as the VLANs in `GET` cluster and worker responses.
:    v2 API: The information that is returned varies depending on the infrastructure provider. For such provider-specific responses, you can specify the provider in your request. For example, VPC clusters don't return VLAN information since they don't have VLANs. Instead, they return subnet and CIDR network information.

## Automating cluster deployments with the API
{: #cs_api}

You can use the {{site.data.keyword.containerlong_notm}} API to automate the creation, deployment, and management of your Kubernetes clusters.
{: shortdesc}

The {{site.data.keyword.containerlong_notm}} API requires header information that you must provide in your API request and that can vary depending on the API that you want to use. To determine what header information is needed for your API, see the [{{site.data.keyword.containerlong_notm}} API documentation](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external}.

To authenticate with {{site.data.keyword.containerlong_notm}}, you must provide an {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) token that is generated with your {{site.data.keyword.cloud_notm}} credentials and that includes the {{site.data.keyword.cloud_notm}} account ID where the cluster was created. Depending on the way you authenticate with {{site.data.keyword.cloud_notm}}, you can choose between the following options to automate the creation of your {{site.data.keyword.cloud_notm}} IAM token.

You can also use the [API swagger JSON file](https://containers.cloud.ibm.com/global/swagger-global-api/swagger.json){: external} to generate a client that can interact with the API as part of your automation work.
{: tip}

Unfederated ID
:    - **Generate an {{site.data.keyword.cloud_notm}} API key:** As an alternative to using the {{site.data.keyword.cloud_notm}} username and password, you can [use {{site.data.keyword.cloud_notm}} API keys](/docs/account?topic=account-userapikey&interface=ui#create_user_key). {{site.data.keyword.cloud_notm}} API keys are dependent on the {{site.data.keyword.cloud_notm}} account they are generated for. You can't combine your {{site.data.keyword.cloud_notm}} API key with a different account ID in the same {{site.data.keyword.cloud_notm}} IAM token. To access clusters that were created with an account other than the one your {{site.data.keyword.cloud_notm}} API key is based on, you must log in to the account to generate a new API key.
     - **{{site.data.keyword.cloud_notm}} username and password:** You can follow the steps in this topic to fully automate the creation of your {{site.data.keyword.cloud_notm}} IAM access token.
     
Federated ID
:    - **Generate an {{site.data.keyword.cloud_notm}} API key:** [{{site.data.keyword.cloud_notm}} API keys](/docs/account?topic=account-userapikey&interface=ui#create_user_key) are dependent on the {{site.data.keyword.cloud_notm}} account they are generated for. You can't combine your {{site.data.keyword.cloud_notm}} API key with a different account ID in the same {{site.data.keyword.cloud_notm}} IAM token. To access clusters that were created with an account other than the one your {{site.data.keyword.cloud_notm}} API key is based on, you must log in to the account to generate a new API key.
     - **Use a one-time passcode:** If you authenticate with {{site.data.keyword.cloud_notm}} by using a one-time passcode, you can't fully automate the creation of your {{site.data.keyword.cloud_notm}} IAM token because the retrieval of your one-time passcode requires a manual interaction with your web browser. To fully automate the creation of your {{site.data.keyword.cloud_notm}} IAM token, you must create an {{site.data.keyword.cloud_notm}} API key instead.


1. Create your {{site.data.keyword.cloud_notm}} IAM access token. The body information that is included in your request varies based on the {{site.data.keyword.cloud_notm}} authentication method that you use.

    ```sh
    POST https://iam.cloud.ibm.com/identity/token
    ```
    {: codeblock}
    
    Header 
    :    - `Content-Type: application/x-www-form-urlencoded` 
         - `Authorization: Basic Yng6Yng=` where `Yng6Yng=` equals the URL-encoded authorization for the username **bx** and the password **bx**. 
         
    Body for {{site.data.keyword.cloud_notm}} username and password
    :    - `grant_type: password` 
         - `username`: Your {{site.data.keyword.cloud_notm}} username.
         - `password`: Your {{site.data.keyword.cloud_notm}} password. 
         
    Body for {{site.data.keyword.cloud_notm}} API keys 
    :    - `grant_type: urn:ibm:params:oauth:grant-type:apikey`  
         - `apikey`: Your {{site.data.keyword.cloud_notm}} API key 
         
    Body for {{site.data.keyword.cloud_notm}} one-time passcode
    :    - `grant_type: urn:ibm:params:oauth:grant-type:passcode` 
         - `passcode`: Your {{site.data.keyword.cloud_notm}} one-time passcode. Run `ibmcloud login --sso` and follow the instructions in your CLI output to retrieve your one-time passcode by using your web browser. 

    The following example shows output for the previous request.

    ```sh
    {
    "access_token": "<iam_access_token>",
    "refresh_token": "<iam_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    "scope": "ibm openid"
    }

    ```
    {: screen}

    You can find the {{site.data.keyword.cloud_notm}} IAM token in the `access_token` field of your API output. Note the {{site.data.keyword.cloud_notm}} IAM token to retrieve additional header information in the next steps.

2. Retrieve the ID of the {{site.data.keyword.cloud_notm}} account that you want to work with. Replace `TOKEN` with the {{site.data.keyword.cloud_notm}} IAM token that you retrieved from the `access_token` field of your API output in the previous step. In your API output, you can find the ID of your {{site.data.keyword.cloud_notm}} account in the **resources.metadata.guid** field.

    ```sh
    GET https://accounts.cloud.ibm.com/coe/v2/accounts
    ```
    {: codeblock}
    
    Header
    :    - `Content-Type: application/json`
         - `Authorization: bearer TOKEN`
         - `Accept: application/json`

    The following example shows the output of the previous request.

    ```sh
    {
    "next_url": null,
    "total_results": 5,
    "resources": [
        {
            "metadata": {
                "guid": "<account_ID>",
                "url": "/coe/v2/accounts/<account_ID>",
                "created_at": "2016-09-29T02:49:41.842Z",
                "updated_at": "2018-08-16T18:56:00.442Z",
                "anonymousId": "1111a1aa1a1111a1aa11aa11111a1111"
            },
            "entity": {
                "name": "<account_name>",
    ```
    {: screen}

3. Generate a new {{site.data.keyword.cloud_notm}} IAM token that includes your {{site.data.keyword.cloud_notm}} credentials and the account ID that you want to work with.

    If you use an {{site.data.keyword.cloud_notm}} API key, you must use the {{site.data.keyword.cloud_notm}} account ID the API key was created for. To access clusters in other accounts, log in to this account and create an {{site.data.keyword.cloud_notm}} API key that is based on this account.
    {: note}

    ```sh
    POST https://iam.cloud.ibm.com/identity/token
    ```
    {: codeblock}
    
    Header
    :    - `Content-Type: application/x-www-form-urlencoded`
         - `Authorization: Basic Yng6Yng=` where `Yng6Yng=` equals the URL-encoded authorization for the username **bx** and the password **bx**. 

    Body for {{site.data.keyword.cloud_notm}} username and password
    :    - `grant_type: password`
         - `username`: Your {{site.data.keyword.cloud_notm}} username.
         - `password`: Your {{site.data.keyword.cloud_notm}} password. 
         - `bss_account`: The {{site.data.keyword.cloud_notm}} account ID that you retrieved in the previous step.
         
    Body for {{site.data.keyword.cloud_notm}} API keys
    :    - `grant_type: urn:ibm:params:oauth:grant-type:apikey`
         - `apikey`: Your {{site.data.keyword.cloud_notm}} API key.         
         - `bss_account`: The {{site.data.keyword.cloud_notm}} account ID that you retrieved in the previous step.
         
    Body for {{site.data.keyword.cloud_notm}} one-time passcode
    :    - `grant_type: urn:ibm:params:oauth:grant-type:passcode`
         - `passcode`: Your {{site.data.keyword.cloud_notm}} passcode. 
         - `bss_account`: The {{site.data.keyword.cloud_notm}} account ID that you retrieved in the previous step.


    The following example shows output for the API request.

    ```json
    {
        "access_token": "<iam_token>",
        "refresh_token": "<iam_refresh_token>",
        "token_type": "Bearer",
        "expires_in": 3600,
        "expiration": 1493747503
    }

    ```
    {: screen}

    You can find the {{site.data.keyword.cloud_notm}} IAM token in the `access_token` and the refresh token in the `refresh_token` field of your API output.

4. List all classic or VPC clusters in your account. If you want to [run Kubernetes API requests against a cluster](#kube_api), make sure to note the name or ID of the cluster that you want to work with.
    Example request to list Classic clusters.
    
    ```sh
    GET https://containers.cloud.ibm.com/global/v2/classic/getClusters
    ```
    {: codeblock}

    Header
    :    `Authorization: bearer <iam_token>`

    Example command to list VPC clusters.
    
    ```sh
    GET https://containers.cloud.ibm.com/global/v2/vpc/getClusters?provider=vpc-gen2
    ```
    {: codeblock}

    Header
    :    `Authorization`: Your {{site.data.keyword.cloud_notm}} IAM access token (`bearer <iam_token>`).

5. Review the [{{site.data.keyword.containerlong_notm}} API documentation](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external} to find a list of supported APIs.

When you use the API for automation, be sure to rely on the responses from the API, not files within those responses. For example, the Kubernetes configuration file for your cluster context is subject to change, so don't build automation based on specific contents of this file when you use the `GET /v1/clusters/{idOrName}/config` call.
{: note}



## Working with your cluster by using the Kubernetes API
{: #kube_api}

You can use the [Kubernetes API](https://kubernetes.io/docs/reference/using-api/){: external} to interact with your cluster in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

The following instructions require public network access in your cluster to connect to the public cloud service endpoint of your Kubernetes master.
{: note}

1. Follow the steps in [Automating cluster deployments with the API](#cs_api) to retrieve your {{site.data.keyword.cloud_notm}} IAM access token, refresh token, the ID of the cluster where you want to run Kubernetes API requests, and the {{site.data.keyword.containerlong_notm}} region where your cluster is located.

1. Retrieve an IBM Cloud IAM refresh token and IAM access token.

    ```sh
    POST https://iam.cloud.ibm.com/identity/token
    ```
    {: codeblock}

    Header
    :    - `Content-Type: application/x-www-form-urlencoded`
         - `Authorization: Basic Yng6Yng=` where `Yng6Yng=` equals the URL-encoded authorization for the username **bx** and the password **bx**. 
         - `cache-control: no-cache`

    Body
    :    - `delegated_refresh_token_expiry: 600`
         - `receiver_client_ids: kube`
         - `response_type: delegated_refresh_token`
         - `refresh_token`: Your {{site.data.keyword.cloud_notm}} IAM refresh token.
         - `grant_type: refresh_token`

    The following example shows output from the previous API request.

    ```sh
    {
    "access_token": <access_token>
    "refresh_token": <delegated_refresh_token>
    }
    ```
    {: screen}

1. Retrieve an {{site.data.keyword.cloud_notm}} IAM ID, IAM access, and IAM refresh token by using the delegated refresh token from the previous step. In your API output, you can find the IAM ID token in the `id_token` field, the IAM access token in the `access_token` field, and the IAM refresh token in the `refresh_token` field.
    ```sh
    POST https://iam.cloud.ibm.com/identity/token
    ```
    {: codeblock}

    Header
    :    - `Content-Type: application/x-www-form-urlencoded` 
         - `Authorization: Basic a3ViZTprdWJl`
              `a3ViZTprdWJl` equals the URL-encoded authorization for the username `kube` and the password `kube`.
         - `cache-control: no-cache`

    Body
    :    - `refresh_token`: Your {{site.data.keyword.cloud_notm}} IAM delegated refresh token.
         - `grant_type: urn:ibm:params:oauth:grant-type:delegated-refresh-token`

    The following example shows output from the previous API request.

    ```sh
    {
    "access_token": "<iam_access_token>",
    "id_token": "<iam_id_token>",
    "refresh_token": "<iam_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1553629664,
    "scope": "ibm openid containers-kubernetes"
    }
    ```
    {: screen}

1. Before you can access your cluster with your current identity, you must run the following request.
    ```curl
    POST https://containers.test.cloud.ibm.com/global/v2/applyRBAC
    ```
    {: pre}

    Header
    :   `Authorization: bearer <TOKEN>` Your IBM Cloud IAM access token

    Body
    :   `cluster: <cluster_name_or_ID>`

1. Note that RBAC sync is asynchronous, so run the following request until it has synced.
    ```curl
    GET https://containers.test.cloud.ibm.com/global/v2/getRBACStatus?cluster=<cluster_name_or_ID>
  -H "Authorization: ${BEARER2}"
    ```
    {: pre}

    Header
    :   `Authorization: bearer <TOKEN>` Your IBM Cloud IAM access token

    Example response. Ensure the output shows `synchronized:true`.
    
    ```json
    {"synchronized":true,"error":false}
    ```
    {: screen}




1. Retrieve the URL of the default service endpoint for your Kubernetes master by using the IAM access token and the name or ID of your cluster. You can find the URL in the **`masterURL`** of your API output.

    If only the public cloud service endpoint or only the private cloud service endpoint is enabled for your cluster, that endpoint is listed for the `masterURL`. If both the public and private cloud service endpoints are enabled for your cluster, the public cloud service endpoint is listed by default for the `masterURL`. To use the private cloud service endpoint instead, find the URL in the `privateServiceEndpointURL` field of the output.
    {: note}

    ```sh
    GET https://containers.cloud.ibm.com/global/v2/getCluster?cluster=<cluster_name_or_ID>
    ```
    {: codeblock}

    Header
    :    - `Authorization`: Your {{site.data.keyword.cloud_notm}} IAM access token.
   
    Path
    :    - `<cluster_name_or_ID>`: The name or ID of your cluster that you retrieved with the `GET https://containers.cloud.ibm.com/global/v2/classic/getClusters` or `GET https://containers.cloud.ibm.com/global/v2/vpc/getClusters?provider=vpc-gen2` API in [Automating cluster deployments with the API](#cs_api).

    The following example shows output for a public cloud service endpoint request.
    
    ```sh
    ...
    "etcdPort": "31593",
    "masterURL": "https://c2.us-south.containers.cloud.ibm.com:30422",
    "ingress": {
        ...}
    ```
    {: screen}

    The following example shows output for a private cloud service endpoint request.
    ```sh
    ...
    "etcdPort": "31593",
    "masterURL": "https://c2.private.us-south.containers.cloud.ibm.com:30422",
    "ingress": {
        ...}
    ```
    {: screen}

5. To use a private cloud service endpoint, you must first [expose the private cloud service endpoint by using a load balancer IP that is routable from your VPN connection into the private network](/docs/containers?topic=containers-access_cluster#access_private_se).

6. Run Kubernetes API requests against your cluster by using the IAM ID token that you retrieved earlier. For example, list the Kubernetes version that runs in your cluster.

    If you enabled SSL certificate verification in your API test framework, make sure to disable this feature.
    {: tip}

    ```sh
    GET <masterURL>/version
    ```
    {: codeblock}

    Header
    :    - `Authorization: bearer <id_token>`</td>
    
    Path
    :    - `<masterURL>`: The service endpoint of your Kubernetes master that you retrieved in the previous step.

    The following example shows the output of the previous API request.

    ```sh
    {
    "major": "1",
    "minor": "1.33",
    "gitVersion": "v1.33+IKS",
    "gitCommit": "c35166bd86eaa91d17af1c08289ffeab3e71e11e",
    "gitTreeState": "clean",
    "buildDate": "2019-03-21T10:08:03Z",
    "goVersion": "go1.11.5",
    "compiler": "gc",
    "platform": "linux/amd64"
    }
    ```
    {: screen}

7. Review the [Kubernetes API documentation](https://kubernetes.io/docs/reference/kubernetes-api/){: external} to find a list of supported APIs for the latest Kubernetes version. Make sure to use the API documentation that matches the Kubernetes version of your cluster. If you don't use the latest Kubernetes version, append your version at the end of the URL. For example, to access the API documentation for version 1.12, add `v1.12`.



## Refreshing IAM access tokens and obtaining new refresh tokens with the API
{: #cs_api_refresh}

Every {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) access token that is issued via the API expires after one hour. You must refresh your access token regularly to assure access to the {{site.data.keyword.cloud_notm}} API. You can use the same steps to obtain a new refresh token.
{: shortdesc}

Before you begin, make sure that you have an {{site.data.keyword.cloud_notm}} IAM refresh token or an {{site.data.keyword.cloud_notm}} API key that you can use to request a new access token.
- **Refresh token:** Follow the instructions in [Automating the cluster creation and management process with the {{site.data.keyword.cloud_notm}} API](#cs_api).
- **API key:** Retrieve your [{{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/) API key as follows.
    1. From the menu bar, click **Manage** > **Access (IAM)**.
    2. Click the **Users** page and then select yourself.
    3. In the **API keys** pane, click **Create an IBM Cloud API key**.
    4. Enter a **Name** and **Description** for your API key and click **Create**.
    5. Click **Show** to see the API key that was generated for you.
    6. Copy the API key so that you can use it to retrieve your new {{site.data.keyword.cloud_notm}} IAM access token.

Use the following steps if you want to create an {{site.data.keyword.cloud_notm}} IAM token or if you want to obtain a new refresh token.

1. Generate a new {{site.data.keyword.cloud_notm}} IAM access token by using the refresh token or the {{site.data.keyword.cloud_notm}} API key.
    ```sh
    POST https://iam.cloud.ibm.com/identity/token
    ```
    {: codeblock}

    Header
    :    - `Content-Type: application/x-www-form-urlencoded`
         - `Authorization: Basic Yng6Yng=`: Where `Yng6Yng=` equals the URL-encoded authorization for the username **bx** and the password **bx**.

    
    Body when using the refresh token
    :    - `grant_type: refresh_token`
         - `refresh_token:` Your {{site.data.keyword.cloud_notm}} IAM refresh token.
         - `bss_account:` Your {{site.data.keyword.cloud_notm}} account ID.
          
    Body when using the {{site.data.keyword.cloud_notm}} API key
    :    - `grant_type: urn:ibm:params:oauth:grant-type:apikey`
         - `apikey:` Your {{site.data.keyword.cloud_notm}} API key.


    The following example shows the output of the previous API request.

    ```sh
    {
        "access_token": "<iam_token>",
        "refresh_token": "<iam_refresh_token>",
        "token_type": "Bearer",
        "expires_in": 3600,
        "expiration": 1493747503
    }

    ```
    {: screen}

    You can find your new {{site.data.keyword.cloud_notm}} IAM token in the `access_token`, and the refresh token in the `refresh_token` field of your API output.

2. Continue working with the [{{site.data.keyword.containerlong_notm}} API documentation](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external} by using the token from the previous step.



## Refreshing {{site.data.keyword.cloud_notm}} IAM access tokens and obtaining new refresh tokens with the CLI
{: #cs_cli_refresh}

You can use the command line to [set the cluster context](/docs/containers?topic=containers-access_cluster), download the `kubeconfig` file for your Kubernetes cluster, and generate an {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) ID token and a refresh token to provide authentication.
{: shortdesc}

You can use [{{site.data.keyword.cloud_notm}} IAM](https://cloud.ibm.com/iam/overview){: external} to change the default expiration times for your tokens and sessions.
{: tip}

`Kubeconfig` session
:    When you start a new CLI session or after the session expires such as after the default of 24 hours, you must reset the cluster context.

ID token
:    Every IAM ID token that is issued via the CLI expires after a set period of time, such as 20 minutes. When the ID token expires, the refresh token is sent to the token provider to refresh the ID token. Your authentication is refreshed, and you can continue to run commands against your cluster.

Refresh token
:    Refresh tokens expire after a set period of time, such as 30 days, or if the administrator revokes the token. If the refresh token is expired, the ID token can't be refreshed, and you are not able to continue running commands in the CLI. You can get a new refresh token by running `ibmcloud ks cluster config --cluster <cluster_name>`. This command also refreshes your ID token.
