---

copyright: 
  years: 2014, 2025
lastupdated: "2025-09-23"


keywords: kubernetes, help, network, connectivity

subcollection: containers

content-type: troubleshoot

---


{{site.data.keyword.attribute-definition-list}}





# Why do I see wrong credentials or access denied messages when I create a PVC?
{: #cred_failure}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}




When you create the PVC, you see an error message similar to one of the following:
{: tsSymptoms}

```sh
SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details.
```
{: screen}

```sh
AccessDenied: Access Denied status code: 403
```
{: screen}

```sh
CredentialsEndpointError: failed to load credentials
```
{: screen}

```sh
InvalidAccessKeyId: The AWS Access Key ID you provided does not exist in our records`
```
{: screen}

```sh
can't access bucket <bucket_name>: Forbidden: Forbidden
```
{: screen}



The {{site.data.keyword.cos_full_notm}} service credentials that you use to access the service instance might be wrong, or allow only read access to your bucket.
{: tsCauses}


Create a new secret.
{: tsResolve}

1. In the navigation on the service details page, click **Service Credentials**.
2. Find your credentials, then click **View credentials**.
3. In the **`iam_role_crn`** section, verify that you have the `Writer` or `Manager` role. If you don't have the correct role, you must create new {{site.data.keyword.cos_full_notm}} service credentials with the correct permission.
4. If the role is correct, verify that you use the correct **`access_key_id`** and **`secret_access_key`** in your Kubernetes secret.
5. [Create a new secret with the updated **`access_key_id`** and **`secret_access_key`**](/docs/containers?topic=containers-storage-cos-understand#create_cos_secret).
