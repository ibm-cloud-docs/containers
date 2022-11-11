---

copyright:
  years: 2014, 2022
lastupdated: "2022-11-11"

keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Why does ALB secret creation or deletion fail?
{: #cs_albsecret_fails}
{: support}

Supported infrastructure providers
:   Classic
:   VPC


After you deploy an Ingress application load balancer (ALB) secret to your cluster by using the `ibmcloud ks ingress secret create` command, the `Description` field is not updating with the secret name when you view your certificate in {{site.data.keyword.cloudcerts_full_notm}}.
{: tsSymptoms}

When you list information about the ALB secret, the state says `*_failed`. For example, `create_failed`, `update_failed`, `delete_failed`.


Review the following reasons why the ALB secret might fail and the corresponding troubleshooting steps.
{: tsResolve}

Before you begin, list the ALB secret details (`ibmcloud ks ingress secretget`) and view the ALB secret `status` to get more information on the reason for failure.
{: tip}


**The owner of the cluster's API Key does not have the required access roles to download and update certificate data.**  
Check with your account Administrator to assign the owner of the cluster's API Key, the following {{site.data.keyword.cloud_notm}} IAM roles:
    - The **Manager** and **Writer** service access roles for your {{site.data.keyword.cloudcerts_full_notm}} instance. For more information, see Managing service access for {{site.data.keyword.cloudcerts_short}}.
    - The **Administrator** platform access role for the cluster.

**The certificate CRN provided at time of create, update, or remove does not belong to the same account as the cluster.**  
Check that the certificate CRN you provided is imported to an instance of the {{site.data.keyword.cloudcerts_short}} service that is deployed in the same account as your cluster**

**The certificate CRN provided at time of create is incorrect.**  
Check the accuracy of the certificate CRN string you provide.
    - If the certificate CRN is found to be accurate, then try to update the secret: `ibmcloud ks ingress secret update --cluster <cluster_name_or_ID> --name <secret_name> --namespace <namespace> --cert-crn <certificate_CRN>`.
    - If this command results in the update_failed status, then remove the secret: `ibmcloud ks ingress secret rm --cluster <cluster_name_or_ID> --name <secret_name> --namespace <namespace>`.
    - Deploy the secret again: `ibmcloud ks ingress secret create --cluster <cluster_name_or_ID> --name <secret_name> --cert-crn <certificate_CRN> --namespace`.

**The certificate CRN provided at time of update is incorrect.**  
    - Check the accuracy of the certificate CRN string you provide.
    - If the certificate CRN is found to be accurate, then remove the secret: `ibmcloud ks ingress secret rm --cluster <cluster_name_or_ID> --name <secret_name> --namespace <namespace>`.
    - Deploy the secret again: `ibmcloud ks ingress s-ecret create --cluster <cluster_name_or_ID> --name <secret_name> --cert-crn <certificate_CRN> --namespace <namespace>`.
    - Try to update the secret: `ibmcloud ks ingress secret update --cluster <cluster_name_or_ID> --name <secret_name> --namespace <namespace> --cert-crn <certificate_CRN>`.

**The {{site.data.keyword.cloudcerts_long_notm}} service is experiencing downtime.**  
Check that your {{site.data.keyword.cloudcerts_short}} service is up and running.

**Your imported secret has the same name as the IBM-provided Ingress secret.**  
Rename your secret. You can check the name of the IBM-provided Ingress secret by running `ibmcloud ks cluster get --cluster  | grep Ingress`.

**The description for the certificate is not updated with the secret name when you view the certificate in {{site.data.keyword.cloudcerts_full_notm}}.**  
Check whether the length of the certificate description reached the upper limit of 1024 characters.







